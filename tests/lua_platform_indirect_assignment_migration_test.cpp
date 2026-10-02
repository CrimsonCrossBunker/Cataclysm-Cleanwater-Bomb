#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <array>
#include <cstddef>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
#include <variant>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "condition.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "global_vars.h"
#include "json_loader.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser_diag_value.h"
#include "math_parser_type.h"
#include "npc.h"

namespace
{

enum class storage_scope {
    alpha,
    beta,
    global,
    context
};

enum class pointer_shape {
    missing,
    string,
    null_value,
    number,
    array,
    coordinate
};

enum class assignment_operation {
    assign,
    add,
    increment
};

struct variable_ref {
    storage_scope scope;
    std::string key;
};

using stored_value = std::variant<std::monostate, double, std::string>;

struct rhs_case {
    std::string pointer;
    variable_ref target;
    stored_value value;
};

struct assignment_case {
    std::string_view name;
    assignment_operation operation;
    pointer_shape pointer_type;
    std::string pointer;
    variable_ref target;
    stored_value old_target;
    double expected_value;
    bool expects_error = false;
    bool expects_pointer_type_diagnostic = false;
    std::optional<rhs_case> rhs = std::nullopt;
    bool verifies_single_parse = false;
    unsigned int pointer_type_diagnostic_count = 1;
};

const std::array<std::string_view, 3> native_assignment_sources = {
    "v_pointer = 7.5",
    "v_pointer += v_rhs_pointer",
    "v_pointer++",
};

std::size_t output_index( const assignment_operation operation )
{
    switch( operation ) {
        case assignment_operation::assign:
            return 0;
        case assignment_operation::add:
            return 1;
        case assignment_operation::increment:
            return 2;
    }
    return 0;
}

eoc_math native_assignment( const std::string_view source )
{
    const std::string json = R"({"math":[")" + std::string( source ) + R"("]})";
    eoc_math expression;
    expression.from_json( json_loader::from_string( json ).get_object(),
                          "math", math_type_t::assign );
    return expression;
}

struct saved_global_values {
    global_variables::impl_t values = get_globals().get_global_values();

    ~saved_global_values() {
        get_globals().set_global_values( std::move( values ) );
    }
};

void set_native_value( const variable_ref &variable, const stored_value &value,
                       avatar &alpha, npc &beta, dialogue &context )
{
    if( std::holds_alternative<std::monostate>( value ) ) {
        switch( variable.scope ) {
            case storage_scope::alpha:
                alpha.remove_value( variable.key );
                break;
            case storage_scope::beta:
                beta.remove_value( variable.key );
                break;
            case storage_scope::global:
                get_globals().remove_global_value( variable.key );
                break;
            case storage_scope::context:
                context.remove_value( variable.key );
                break;
        }
        return;
    }

    const diag_value converted = std::visit( []( const auto &entry ) -> diag_value {
        using value_type = std::decay_t<decltype( entry )>;
        if constexpr( std::is_same_v<value_type, std::monostate> ) {
            return {};
        } else {
            return diag_value( entry );
        }
    }, value );
    switch( variable.scope ) {
        case storage_scope::alpha:
            alpha.set_value( variable.key, converted );
            break;
        case storage_scope::beta:
            beta.set_value( variable.key, converted );
            break;
        case storage_scope::global:
            get_globals().set_global_value( variable.key, converted );
            break;
        case storage_scope::context:
            context.set_value( variable.key, converted );
            break;
    }
}

void remove_shared_value( const variable_ref &variable, avatar &alpha, npc &beta )
{
    switch( variable.scope ) {
        case storage_scope::alpha:
            alpha.remove_value( variable.key );
            break;
        case storage_scope::beta:
            beta.remove_value( variable.key );
            break;
        case storage_scope::global:
            get_globals().remove_global_value( variable.key );
            break;
        case storage_scope::context:
            break;
    }
}

void set_shared_value( const variable_ref &variable, const stored_value &value,
                       avatar &alpha, npc &beta )
{
    if( std::holds_alternative<std::monostate>( value ) ) {
        remove_shared_value( variable, alpha, beta );
        return;
    }
    if( variable.scope == storage_scope::context ) {
        return;
    }
    const diag_value converted = std::holds_alternative<double>( value ) ?
                                 diag_value( std::get<double>( value ) ) :
                                 diag_value( std::get<std::string>( value ) );
    switch( variable.scope ) {
        case storage_scope::alpha:
            alpha.set_value( variable.key, converted );
            break;
        case storage_scope::beta:
            beta.set_value( variable.key, converted );
            break;
        case storage_scope::global:
            get_globals().set_global_value( variable.key, converted );
            break;
        case storage_scope::context:
            break;
    }
}

const diag_value *lookup_native_value( const variable_ref &variable,
                                       const avatar &alpha, const npc &beta,
                                       const dialogue &context )
{
    switch( variable.scope ) {
        case storage_scope::alpha:
            return alpha.maybe_get_value( variable.key );
        case storage_scope::beta:
            return beta.maybe_get_value( variable.key );
        case storage_scope::global:
            return get_globals().maybe_get_global_value( variable.key );
        case storage_scope::context:
            return context.maybe_get_value( variable.key );
    }
    return nullptr;
}

void check_native_value( const diag_value *actual, const stored_value &expected )
{
    if( std::holds_alternative<std::monostate>( expected ) ) {
        CHECK( actual == nullptr );
    } else if( const double *number = std::get_if<double>( &expected ) ) {
        REQUIRE( actual != nullptr );
        REQUIRE( actual->is_dbl() );
        CHECK( actual->dbl() == *number );
    } else {
        REQUIRE( actual != nullptr );
        REQUIRE( actual->is_str() );
        CHECK( actual->str() == std::get<std::string>( expected ) );
    }
}

std::size_t diagnostic_count( const std::string &diagnostics, const std::string_view text )
{
    std::size_t count = 0;
    std::size_t position = 0;
    while( ( position = diagnostics.find( text, position ) ) != std::string::npos ) {
        ++count;
        position += text.size();
    }
    return count;
}

void check_lua_value( const assignment_case &test_case, const stored_value &expected,
                      const avatar &alpha, const npc &beta, const dialogue &native_context,
                      const sol::table &context_data )
{
    if( test_case.target.scope == storage_scope::context ) {
        const sol::object actual = context_data.raw_get<sol::object>( test_case.target.key );
        if( std::holds_alternative<std::monostate>( expected ) ) {
            CHECK_FALSE( ( actual.valid() && actual.get_type() != sol::type::nil ) );
        } else if( const double *number = std::get_if<double>( &expected ) ) {
            REQUIRE( actual.valid() );
            REQUIRE( actual.get_type() == sol::type::number );
            CHECK( actual.as<double>() == *number );
        } else {
            REQUIRE( actual.valid() );
            REQUIRE( actual.get_type() == sol::type::string );
            CHECK( actual.as<std::string>() == std::get<std::string>( expected ) );
        }
        return;
    }
    check_native_value( lookup_native_value( test_case.target, alpha, beta, native_context ),
                       expected );
}

void set_lua_context_value( sol::table &data, const std::string &key,
                            const stored_value &value )
{
    if( const double *number = std::get_if<double>( &value ) ) {
        data[key] = *number;
    } else if( const std::string *text = std::get_if<std::string>( &value ) ) {
        data[key] = *text;
    } else {
        data.raw_set( key, sol::nil );
    }
}

void initialize_shared_values( const assignment_case &test_case,
                               avatar &alpha, npc &beta )
{
    get_globals().set_global_value( "", diag_value( 31.0 ) );
    remove_shared_value( test_case.target, alpha, beta );
    set_shared_value( test_case.target, test_case.old_target, alpha, beta );
    if( test_case.rhs ) {
        remove_shared_value( test_case.rhs->target, alpha, beta );
        set_shared_value( test_case.rhs->target, test_case.rhs->value, alpha, beta );
    }
    alpha.set_value( "trap", diag_value( 99.0 ) );
}

void initialize_native_context( const assignment_case &test_case,
                                avatar &alpha, npc &beta, dialogue &context )
{
    if( test_case.target.scope == storage_scope::context ) {
        set_native_value( test_case.target, test_case.old_target, alpha, beta, context );
    }
    context.set_value( "next", diag_value( "u_trap" ) );
    switch( test_case.pointer_type ) {
        case pointer_shape::missing:
            break;
        case pointer_shape::string:
            context.set_value( "pointer", diag_value( test_case.pointer ) );
            break;
        case pointer_shape::null_value:
            context.set_value( "pointer", diag_value{} );
            break;
        case pointer_shape::number:
            context.set_value( "pointer", diag_value( 3.0 ) );
            break;
        case pointer_shape::array:
            context.set_value( "pointer", diag_value( diag_array{} ) );
            break;
        case pointer_shape::coordinate:
            context.set_value( "pointer", diag_value( tripoint_abs_ms( 1, 2, 3 ) ) );
            break;
    }
    if( test_case.rhs ) {
        context.set_value( "rhs_pointer", diag_value( test_case.rhs->pointer ) );
    }
}

} // namespace

TEST_CASE( "lua_platform_indirect_assignment_migration_matches_native_math",
           "[lua][platform][indirect_assignment_migration][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    saved_global_values restore_globals;

    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 7921 ), true );
    beta.setID( character_id( 7922 ), true );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::math, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "indirect_assignment_migration", 7923, lua );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;
    lua["ccb"] = ccb;
    const std::size_t world_generation =
        platform::detail::runtime_world_generation_storage();
    lua["alpha_owner"] = platform::game_handle::from_creature(
                             alpha, { "avatar", 7921, 0, 0, 0, {} },
                             owner->handle_runtime(), world_generation );
    lua["beta_owner"] = platform::game_handle::from_creature(
                            beta, { "npc", 7922, 0, 0, 0, {} },
                            owner->handle_runtime(), world_generation );

    const std::string long_raw_key = std::string( "raw\0", 4 ) + std::string( 8189, 'k' );
    const std::vector<assignment_case> cases = {
        { "alpha overwrite ignores old string", assignment_operation::assign,
          pointer_shape::string, "u_indirect_alpha", { storage_scope::alpha, "indirect_alpha" },
          std::string( "old alpha" ), 7.5 },
        { "beta add reads an indirect alpha RHS", assignment_operation::add,
          pointer_shape::string, "n_indirect_beta", { storage_scope::beta, "indirect_beta" },
          8.25, 9.75, false, false,
          rhs_case{ "u_indirect_rhs", { storage_scope::alpha, "indirect_rhs" }, 1.5 } },
        { "context increment", assignment_operation::increment, pointer_shape::string,
          "_indirect_context", { storage_scope::context, "indirect_context" }, 5.25, 6.25 },
        { "raw NUL long pointer stays global", assignment_operation::assign,
          pointer_shape::string, long_raw_key, { storage_scope::global, long_raw_key },
          std::monostate{}, 7.5 },
        { "unrecognized prefix is global", assignment_operation::assign,
          pointer_shape::string, "x_indirect_global",
          { storage_scope::global, "x_indirect_global" },
          4.0, 7.5 },
        { "v_next is parsed once as global", assignment_operation::increment,
          pointer_shape::string, "v_next", { storage_scope::global, "v_next" },
          4.0, 5.0, false, false, std::nullopt, true },
        { "missing pointer reads zero then writes", assignment_operation::increment,
          pointer_shape::missing, "", { storage_scope::global, "" }, 31.0, 1.0 },
        { "null pointer string writes empty global", assignment_operation::assign,
          pointer_shape::null_value, "", { storage_scope::global, "" }, 31.0, 7.5 },
        { "null pointer reads and writes empty global", assignment_operation::increment,
          pointer_shape::null_value, "", { storage_scope::global, "" }, 31.0, 32.0 },
        { "numeric pointer string mismatch writes empty global", assignment_operation::assign,
          pointer_shape::number, "", { storage_scope::global, "" }, 31.0, 7.5, false, true },
        { "numeric pointer read and write both resolve empty global",
          assignment_operation::increment, pointer_shape::number, "",
          { storage_scope::global, "" }, 31.0, 32.0, false, true,
          std::nullopt, false, 2 },
        { "array pointer string mismatch writes empty global", assignment_operation::assign,
          pointer_shape::array, "", { storage_scope::global, "" }, 31.0, 7.5, false, true },
        { "coordinate pointer string mismatch writes empty global", assignment_operation::assign,
          pointer_shape::coordinate, "", { storage_scope::global, "" }, 31.0, 7.5, false, true },
        { "empty string pointer writes empty global", assignment_operation::assign,
          pointer_shape::string, "", { storage_scope::global, "" }, 31.0, 7.5 },
        { "u prefix with empty key targets alpha", assignment_operation::assign,
          pointer_shape::string, "u_", { storage_scope::alpha, "" }, 2.0, 7.5 },
        { "n prefix with empty key targets beta", assignment_operation::assign,
          pointer_shape::string, "n_", { storage_scope::beta, "" }, 2.0, 7.5 },
        { "double underscore strips one prefix", assignment_operation::assign,
          pointer_shape::string, "__indirect_context",
          { storage_scope::context, "_indirect_context" },
          2.0, 7.5 },
        { "bad indirect old value leaves alpha unchanged", assignment_operation::add,
          pointer_shape::string, "u_indirect_bad_old", { storage_scope::alpha, "indirect_bad_old" },
          std::string( "keep old" ), 0.0, true, false,
          rhs_case{ "u_indirect_rhs", { storage_scope::alpha, "indirect_rhs" }, 1.5 } },
        { "bad indirect RHS leaves beta unchanged", assignment_operation::add,
          pointer_shape::string, "n_indirect_bad_rhs", { storage_scope::beta, "indirect_bad_rhs" },
          12.0, 12.0, true, false,
          rhs_case{ "u_indirect_bad_rhs", { storage_scope::alpha, "indirect_bad_rhs" },
                    std::string( "not numeric" ) } },
    };

    std::array<eoc_math, 3> native_math = {
        native_assignment( native_assignment_sources[0] ),
        native_assignment( native_assignment_sources[1] ),
        native_assignment( native_assignment_sources[2] ),
    };
    finalize_conditions();

    // Captured verbatim from tools/migrate_lua_first.py::render_static_character_math.
    // Read/write actors: u/read_u=alpha_owner and n/read_npc=beta_owner.
    constexpr std::array<std::string_view, 3> captured_lua_output = {
        "    do\n        local target_name = (function(pointer) if pointer.exists == false then"
        " return \"\" end; return pointer.value end)(service_value(services.variables.get_conte"
        "xt_string(context and context.data, \"pointer\")))\n        if string.sub(target_name,"
        " 1, 2) == \"u_\" then\n            service_value(services.variables.set(\n            "
        "    alpha_owner, string.sub(target_name, 3), 0.0 + (7.5), { include_before = false }))"
        "\n        elseif string.sub(target_name, 1, 2) == \"n_\" then\n            service_val"
        "ue(services.variables.set(\n                beta_owner, string.sub(target_name, 3), 0."
        "0 + (7.5), { include_before = false }))\n        elseif string.sub(target_name, 1, 1) "
        "== \"_\" then\n            context.data[string.sub(target_name, 2)] = 0.0 + (7.5)\n   "
        "     else\n            service_value(services.variables.set_global(\n                t"
        "arget_name, 0.0 + (7.5), { include_before = false }))\n        end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = (function(pointer) if pointer.exists == false then return {ok"
        "=true,value={exists=false}} end; if string.sub(pointer.value,1,2)==\"u_\" then return "
        "services.variables.get_number(alpha_owner, string.sub(pointer.value,3), {strict=true})"
        " elseif string.sub(pointer.value,1,2)==\"n_\" then return services.variables.get_numbe"
        "r(beta_owner, string.sub(pointer.value,3), {strict=true}) elseif string.sub(pointer.va"
        "lue,1,1)==\"_\" then return services.variables.get_context_number(context and context."
        "data, string.sub(pointer.value,2), {strict=true}) else return services.variables.get_g"
        "lobal_number(pointer.value, {strict=true}) end end)(service_value(services.variables.g"
        "et_context_string(context and context.data, \"pointer\"))); if variable_result.ok == f"
        "alse and variable_result.error and variable_result.error.code == \"variable_type_misma"
        "tch\" then services.diagnostic(\"Math variable v_pointer: \" .. variable_result.error."
        "message); return nil end; values[1] = (function(result) if result.exists == false then"
        " return 0.0 end; return result.value end)(service_value(variable_result)); variable_re"
        "sult = (function(pointer) if pointer.exists == false then return {ok=true,value={exist"
        "s=false}} end; if string.sub(pointer.value,1,2)==\"u_\" then return services.variables"
        ".get_number(alpha_owner, string.sub(pointer.value,3), {strict=true}) elseif string.sub"
        "(pointer.value,1,2)==\"n_\" then return services.variables.get_number(beta_owner, stri"
        "ng.sub(pointer.value,3), {strict=true}) elseif string.sub(pointer.value,1,1)==\"_\" th"
        "en return services.variables.get_context_number(context and context.data, string.sub(p"
        "ointer.value,2), {strict=true}) else return services.variables.get_global_number(point"
        "er.value, {strict=true}) end end)(service_value(services.variables.get_context_string("
        "context and context.data, \"rhs_pointer\"))); if variable_result.ok == false and varia"
        "ble_result.error and variable_result.error.code == \"variable_type_mismatch\" then ser"
        "vices.diagnostic(\"Math variable v_rhs_pointer: \" .. variable_result.error.message); "
        "return nil end; values[2] = (function(result) if result.exists == false then return 0."
        "0 end; return result.value end)(service_value(variable_result)); values[3] = values[1]"
        " + values[2]; return values[3] end)()\n        if assigned_value ~= nil then\n        "
        "    do\n                local target_name = (function(pointer) if pointer.exists == fa"
        "lse then return \"\" end; return pointer.value end)(service_value(services.variables.g"
        "et_context_string(context and context.data, \"pointer\")))\n                if string."
        "sub(target_name, 1, 2) == \"u_\" then\n                    service_value(services.vari"
        "ables.set(\n                        alpha_owner, string.sub(target_name, 3), assigned_"
        "value, { include_before = false }))\n                elseif string.sub(target_name, 1,"
        " 2) == \"n_\" then\n                    service_value(services.variables.set(\n       "
        "                 beta_owner, string.sub(target_name, 3), assigned_value, { include_bef"
        "ore = false }))\n                elseif string.sub(target_name, 1, 1) == \"_\" then\n "
        "                   context.data[string.sub(target_name, 2)] = assigned_value\n        "
        "        else\n                    service_value(services.variables.set_global(\n      "
        "                  target_name, assigned_value, { include_before = false }))\n         "
        "       end\n            end\n        end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = (function(pointer) if pointer.exists == false then return {ok"
        "=true,value={exists=false}} end; if string.sub(pointer.value,1,2)==\"u_\" then return "
        "services.variables.get_number(alpha_owner, string.sub(pointer.value,3), {strict=true})"
        " elseif string.sub(pointer.value,1,2)==\"n_\" then return services.variables.get_numbe"
        "r(beta_owner, string.sub(pointer.value,3), {strict=true}) elseif string.sub(pointer.va"
        "lue,1,1)==\"_\" then return services.variables.get_context_number(context and context."
        "data, string.sub(pointer.value,2), {strict=true}) else return services.variables.get_g"
        "lobal_number(pointer.value, {strict=true}) end end)(service_value(services.variables.g"
        "et_context_string(context and context.data, \"pointer\"))); if variable_result.ok == f"
        "alse and variable_result.error and variable_result.error.code == \"variable_type_misma"
        "tch\" then services.diagnostic(\"Math variable v_pointer: \" .. variable_result.error."
        "message); return nil end; values[1] = (function(result) if result.exists == false then"
        " return 0.0 end; return result.value end)(service_value(variable_result)); values[2] ="
        " 1.0; values[3] = values[1] + values[2]; return values[3] end)()\n        if assigned_"
        "value ~= nil then\n            do\n                local target_name = (function(point"
        "er) if pointer.exists == false then return \"\" end; return pointer.value end)(service"
        "_value(services.variables.get_context_string(context and context.data, \"pointer\")))"
        "\n                if string.sub(target_name, 1, 2) == \"u_\" then\n                   "
        " service_value(services.variables.set(\n                        alpha_owner, string.su"
        "b(target_name, 3), assigned_value, { include_before = false }))\n                elsei"
        "f string.sub(target_name, 1, 2) == \"n_\" then\n                    service_value(serv"
        "ices.variables.set(\n                        beta_owner, string.sub(target_name, 3), a"
        "ssigned_value, { include_before = false }))\n                elseif string.sub(target_"
        "name, 1, 1) == \"_\" then\n                    context.data[string.sub(target_name, 2)"
        "] = assigned_value\n                else\n                    service_value(services.v"
        "ariables.set_global(\n                        target_name, assigned_value, { include_b"
        "efore = false }))\n                end\n            end\n        end\n    end\n",
    };

    for( const assignment_case &test_case : cases ) {
        CAPTURE( test_case.name );
        initialize_shared_values( test_case, alpha, beta );
        dialogue native_context( get_talker_for( alpha ), get_talker_for( beta ) );
        initialize_native_context( test_case, alpha, beta, native_context );

        double native_result = 0.0;
        const std::string native_diagnostic = capture_debugmsg_during( [&]() {
            native_result = native_math[output_index( test_case.operation )].act( native_context );
        } );
        CHECK( native_result == 0.0 );
        const stored_value expected = test_case.expects_error ? test_case.old_target :
                                      stored_value( test_case.expected_value );
        check_native_value( lookup_native_value( test_case.target, alpha, beta, native_context ),
                            expected );
        if( test_case.expects_error ) {
            CHECK( native_diagnostic.find( "Type mismatch" ) != std::string::npos );
        } else if( test_case.expects_pointer_type_diagnostic ) {
            CHECK( native_diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
            CHECK( diagnostic_count( native_diagnostic, "Type mismatch in diag_value" ) ==
                   test_case.pointer_type_diagnostic_count );
        } else {
            CHECK( native_diagnostic.empty() );
        }
        if( test_case.verifies_single_parse ) {
            REQUIRE( get_globals().get_global_value( "v_next" ).is_dbl() );
            CHECK( get_globals().get_global_value( "v_next" ).dbl() == 5.0 );
            CHECK( alpha.get_value( "trap" ).dbl() == 99.0 );
        }

        initialize_shared_values( test_case, alpha, beta );
        sol::table context_data = lua.create_table();
        context_data["next"] = "u_trap";
        if( test_case.target.scope == storage_scope::context ) {
            set_lua_context_value( context_data, test_case.target.key, test_case.old_target );
        }
        switch( test_case.pointer_type ) {
            case pointer_shape::missing:
                break;
            case pointer_shape::string:
                context_data["pointer"] = test_case.pointer;
                break;
            case pointer_shape::null_value:
                context_data["pointer"] = ccb["services"]["types"]["null"].get<sol::object>();
                break;
            case pointer_shape::number:
                context_data["pointer"] = 3.0;
                break;
            case pointer_shape::array:
                context_data["pointer"] = lua.create_table();
                break;
            case pointer_shape::coordinate:
                context_data["pointer"] = platform::script_tripoint_coord::from_native(
                                               coords::origin::abs, coords::scale::map_square,
                                               tripoint( 1, 2, 3 ) );
                break;
        }
        if( test_case.rhs ) {
            context_data["rhs_pointer"] = test_case.rhs->pointer;
        }
        sol::table context = lua.create_table();
        context["data"] = context_data;
        lua["context"] = context;

        const std::string script = R"lua(
local services = ccb.services
local function service_value(result)
    if not result.ok then
        error(result.error and result.error.message or "native variable operation failed", 0)
    end
    return result.value
end
)lua" + std::string( captured_lua_output[output_index( test_case.operation )] );
        sol::protected_function_result lua_result;
        const std::string lua_diagnostic = capture_debugmsg_during( [&]() {
            platform::detail::callback_scope active_callback( *owner );
            lua_result = lua.safe_script( script, sol::script_pass_on_error );
        } );
        if( !lua_result.valid() ) {
            const sol::error error = lua_result;
            INFO( error.what() );
        }
        REQUIRE( lua_result.valid() );
        check_lua_value( test_case, expected, alpha, beta, native_context, context_data );
        if( test_case.expects_error ) {
            CHECK( lua_diagnostic.find( "Type mismatch" ) != std::string::npos );
        } else if( test_case.expects_pointer_type_diagnostic ) {
            CHECK( lua_diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
            CHECK( diagnostic_count( lua_diagnostic, "Type mismatch in diag_value" ) ==
                   test_case.pointer_type_diagnostic_count );
        } else {
            CHECK( lua_diagnostic.empty() );
        }
        if( test_case.verifies_single_parse ) {
            REQUIRE( get_globals().get_global_value( "v_next" ).is_dbl() );
            CHECK( get_globals().get_global_value( "v_next" ).dbl() == 5.0 );
            CHECK( alpha.get_value( "trap" ).dbl() == 99.0 );
        }
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
