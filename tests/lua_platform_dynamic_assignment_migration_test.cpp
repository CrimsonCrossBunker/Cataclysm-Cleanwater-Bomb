#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <array>
#include <cmath>
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
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser_diag_value.h"
#include "math_parser_type.h"
#include "npc.h"

namespace
{

enum class assignment_scope {
    alpha,
    beta,
    global,
    context
};

struct variable_ref {
    assignment_scope scope;
    std::string_view key;

    std::string math_token() const
    {
        switch( scope ) {
            case assignment_scope::alpha:
                return "u_" + std::string( key );
            case assignment_scope::beta:
                return "n_" + std::string( key );
            case assignment_scope::global:
                return std::string( key );
            case assignment_scope::context:
                return "_" + std::string( key );
        }
        return {};
    }
};

using stored_value = std::variant<std::monostate, double, std::string_view>;

struct assignment_case {
    std::string_view name;
    variable_ref target;
    std::string_view operation;
    std::optional<variable_ref> rhs;
    stored_value old_value;
    stored_value rhs_value;
    double expected_value;
    bool expects_error;
    bool expects_infinity = false;
    bool expects_negative_infinity = false;
    bool expects_nan = false;
    bool expects_negative_zero = false;
    bool expects_positive_zero = false;
    std::string_view rhs_math = {};
};

constexpr std::array assignment_cases = {
    assignment_case{
        "alpha += alpha RHS",
        { assignment_scope::alpha, "dynamic_alpha_add" }, "+=",
        variable_ref{ assignment_scope::alpha, "dynamic_alpha_add_rhs" },
        4.5, 1.25, 5.75, false
    },
    assignment_case{
        "beta -= alpha RHS",
        { assignment_scope::beta, "dynamic_beta_sub" }, "-=",
        variable_ref{ assignment_scope::alpha, "dynamic_alpha_sub_rhs" },
        20.0, 1.25, 18.75, false
    },
    assignment_case{
        "global *= beta RHS",
        { assignment_scope::global, "dynamic_global_mul" }, "*=",
        variable_ref{ assignment_scope::beta, "dynamic_beta_mul_rhs" },
        1.5, 2.5, 3.75, false
    },
    assignment_case{
        "context /= global RHS",
        { assignment_scope::context, "dynamic_context_div" }, "/=",
        variable_ref{ assignment_scope::global, "dynamic_global_div_rhs" },
        12.5, 2.5, 5.0, false
    },
    assignment_case{
        "alpha %= context RHS",
        { assignment_scope::alpha, "dynamic_alpha_mod" }, "%=",
        variable_ref{ assignment_scope::context, "dynamic_context_mod_rhs" },
        10.5, 4.0, 2.5, false
    },
    assignment_case{
        "alpha increment",
        { assignment_scope::alpha, "dynamic_alpha_increment" }, "++",
        std::nullopt, 7.25, std::monostate{}, 8.25, false
    },
    assignment_case{
        "beta decrement",
        { assignment_scope::beta, "dynamic_beta_decrement" }, "--",
        std::nullopt, 7.25, std::monostate{}, 6.25, false
    },
    assignment_case{
        "increment missing alpha value from zero",
        { assignment_scope::alpha, "dynamic_alpha_missing" }, "++",
        std::nullopt, std::monostate{}, std::monostate{}, 1.0, false
    },
    assignment_case{
        "assignment replaces nonnumeric beta old value",
        { assignment_scope::beta, "dynamic_beta_replace" }, "=",
        variable_ref{ assignment_scope::alpha, "dynamic_alpha_replace_rhs" },
        std::string_view( "old text" ), 2.75, 2.75, false
    },
    assignment_case{
        "nonnumeric RHS leaves alpha target unchanged",
        { assignment_scope::alpha, "dynamic_alpha_bad_rhs" }, "+=",
        variable_ref{ assignment_scope::beta, "dynamic_beta_bad_rhs" },
        41.5, std::string_view( "not numeric" ), 41.5, true
    },
    assignment_case{
        "nonnumeric old global value leaves target unchanged",
        { assignment_scope::global, "dynamic_global_bad_old" }, "+=",
        variable_ref{ assignment_scope::alpha, "dynamic_alpha_good_rhs" },
        std::string_view( "old text" ), 2.75, 0.0, true
    },
    assignment_case{
        "alpha division by zero retains native infinity",
        { assignment_scope::alpha, "dynamic_alpha_infinity" }, "/=",
        variable_ref{ assignment_scope::global, "dynamic_global_zero" },
        1.0, 0.0, 0.0, false, true
    },
    assignment_case{
        "beta division by zero retains native negative infinity",
        { assignment_scope::beta, "dynamic_beta_negative_infinity" }, "/=",
        variable_ref{ assignment_scope::global, "dynamic_global_zero" },
        -1.0, 0.0, 0.0, false, true, true
    },
    assignment_case{
        "alpha modulo retains native negative zero",
        { assignment_scope::alpha, "dynamic_alpha_negative_zero" }, "%=",
        variable_ref{ assignment_scope::global, "dynamic_global_two" },
        -4.0, 2.0, 0.0, false, false, false, false, true
    },
    assignment_case{
        "global zero division retains native positive zero",
        { assignment_scope::global, "dynamic_global_positive_zero" }, "=",
        std::nullopt, std::monostate{}, std::monostate{}, 0.0,
        false, false, false, false, false, true, "0/2"
    },
    assignment_case{
        "global zero divided by zero retains native NaN",
        { assignment_scope::global, "dynamic_global_nan" }, "=",
        std::nullopt, std::monostate{}, std::monostate{}, 0.0,
        false, false, false, false, false, false, "0/0"
    }
};

void remove_storage_value( const variable_ref &variable, avatar &alpha, npc &beta,
                           dialogue &context )
{
    switch( variable.scope ) {
        case assignment_scope::alpha:
            alpha.remove_value( std::string( variable.key ) );
            break;
        case assignment_scope::beta:
            beta.remove_value( std::string( variable.key ) );
            break;
        case assignment_scope::global:
            get_globals().remove_global_value( std::string( variable.key ) );
            break;
        case assignment_scope::context:
            context.remove_value( std::string( variable.key ) );
            break;
    }
}

void set_storage_value( const variable_ref &variable, const stored_value &value,
                        avatar &alpha, npc &beta, dialogue &context )
{
    if( std::holds_alternative<std::monostate>( value ) ) {
        remove_storage_value( variable, alpha, beta, context );
        return;
    }

    const diag_value converted = std::visit( []( const auto &entry ) -> diag_value {
        using value_type = std::decay_t<decltype( entry )>;
        if constexpr( std::is_same_v<value_type, std::monostate> ) {
            return {};
        } else if constexpr( std::is_same_v<value_type, double> ) {
            return diag_value( entry );
        } else {
            return diag_value( std::string( entry ) );
        }
    }, value );
    switch( variable.scope ) {
        case assignment_scope::alpha:
            alpha.set_value( std::string( variable.key ), converted );
            break;
        case assignment_scope::beta:
            beta.set_value( std::string( variable.key ), converted );
            break;
        case assignment_scope::global:
            get_globals().set_global_value( std::string( variable.key ), converted );
            break;
        case assignment_scope::context:
            context.set_value( std::string( variable.key ), converted );
            break;
    }
}

const diag_value *lookup_storage_value( const variable_ref &variable,
                                        const avatar &alpha, const npc &beta,
                                        const dialogue &context )
{
    switch( variable.scope ) {
        case assignment_scope::alpha:
            return alpha.maybe_get_value( std::string( variable.key ) );
        case assignment_scope::beta:
            return beta.maybe_get_value( std::string( variable.key ) );
        case assignment_scope::global:
            return get_globals().maybe_get_global_value( std::string( variable.key ) );
        case assignment_scope::context:
            return context.maybe_get_value( std::string( variable.key ) );
    }
    return nullptr;
}

std::string assignment_expression( const assignment_case &test_case )
{
    std::string expression = test_case.target.math_token();
    expression += test_case.operation;
    if( test_case.rhs ) {
        expression += test_case.rhs->math_token();
    } else if( !test_case.rhs_math.empty() ) {
        expression += test_case.rhs_math;
    }
    return expression;
}

eoc_math native_assignment( const assignment_case &test_case )
{
    const std::string source = R"({"math":[")" +
                               assignment_expression( test_case ) + R"("]})";
    eoc_math expression;
    expression.from_json( json_loader::from_string( source ).get_object(),
                          "math", math_type_t::assign );
    return expression;
}

class saved_global_values
{
    public:
        saved_global_values()
        {
            for( const assignment_case &test_case : assignment_cases ) {
                save_if_global( test_case.target );
                if( test_case.rhs ) {
                    save_if_global( *test_case.rhs );
                }
            }
        }

        ~saved_global_values()
        {
            for( const auto &entry : previous_values ) {
                if( entry.second ) {
                    get_globals().set_global_value( entry.first, *entry.second );
                } else {
                    get_globals().remove_global_value( entry.first );
                }
            }
        }

    private:
        void save_if_global( const variable_ref &variable )
        {
            if( variable.scope != assignment_scope::global ) {
                return;
            }
            const std::string key( variable.key );
            for( const auto &saved : previous_values ) {
                if( saved.first == key ) {
                    return;
                }
            }
            const diag_value *previous = get_globals().maybe_get_global_value( key );
            previous_values.emplace_back(
                key, previous ? std::optional<diag_value>( *previous ) : std::nullopt );
        }

        std::vector<std::pair<std::string, std::optional<diag_value>>> previous_values;
};

void initialize_assignment_fixture( avatar &alpha, npc &beta, dialogue &context )
{
    for( const assignment_case &test_case : assignment_cases ) {
        set_storage_value( test_case.target, test_case.old_value, alpha, beta, context );
        if( test_case.rhs ) {
            set_storage_value( *test_case.rhs, test_case.rhs_value,
                               alpha, beta, context );
        }
    }
}

void initialize_lua_context_value( sol::table &data, const variable_ref &variable,
                                   const stored_value &value )
{
    if( variable.scope != assignment_scope::context ||
        std::holds_alternative<std::monostate>( value ) ) {
        return;
    }
    if( const double *number = std::get_if<double>( &value ) ) {
        data[std::string( variable.key )] = *number;
    } else {
        data[std::string( variable.key )] =
            std::string( std::get<std::string_view>( value ) );
    }
}

sol::table make_lua_context( sol::state_view lua )
{
    sol::table context = lua.create_table();
    sol::table data = lua.create_table();
    for( const assignment_case &test_case : assignment_cases ) {
        initialize_lua_context_value( data, test_case.target, test_case.old_value );
        if( test_case.rhs ) {
            initialize_lua_context_value( data, *test_case.rhs, test_case.rhs_value );
        }
    }
    context["data"] = data;
    return context;
}

void check_numeric_result( const assignment_case &test_case, const double actual )
{
    if( test_case.expects_infinity ) {
        CHECK( std::isinf( actual ) );
        CHECK( std::signbit( actual ) == test_case.expects_negative_infinity );
    } else if( test_case.expects_nan ) {
        CHECK( std::isnan( actual ) );
    } else if( test_case.expects_negative_zero ) {
        CHECK( actual == 0.0 );
        CHECK( std::signbit( actual ) );
    } else if( test_case.expects_positive_zero ) {
        CHECK( actual == 0.0 );
        CHECK_FALSE( std::signbit( actual ) );
    } else {
        CHECK( actual == test_case.expected_value );
    }
}

void check_native_assignment_values( const avatar &alpha, const npc &beta,
                                     const dialogue &context )
{
    for( const assignment_case &test_case : assignment_cases ) {
        CAPTURE( test_case.name );
        const diag_value *actual = lookup_storage_value(
                                       test_case.target, alpha, beta, context );
        if( test_case.expects_error ) {
            REQUIRE( actual != nullptr );
            if( std::holds_alternative<std::string_view>( test_case.old_value ) ) {
                REQUIRE( actual->is_str() );
                CHECK( actual->str() ==
                       std::get<std::string_view>( test_case.old_value ) );
            } else {
                REQUIRE( actual->is_dbl() );
                check_numeric_result( test_case, actual->dbl() );
            }
        } else if( test_case.expects_infinity ) {
            REQUIRE( actual != nullptr );
            REQUIRE( actual->is_dbl() );
            check_numeric_result( test_case, actual->dbl() );
        } else if( test_case.expects_nan ) {
            REQUIRE( actual != nullptr );
            REQUIRE( actual->is_dbl() );
        } else if( test_case.expects_negative_zero ) {
            REQUIRE( actual != nullptr );
            REQUIRE( actual->is_dbl() );
        } else if( test_case.expects_positive_zero ) {
            REQUIRE( actual != nullptr );
            REQUIRE( actual->is_dbl() );
        } else {
            REQUIRE( actual != nullptr );
            REQUIRE( actual->is_dbl() );
        }
        if( !test_case.expects_error ) {
            check_numeric_result( test_case, actual->dbl() );
        }
    }
}

void check_lua_assignment_values( const avatar &alpha, const npc &beta,
                                  const dialogue &native_context,
                                  const sol::table &context_data )
{
    for( const assignment_case &test_case : assignment_cases ) {
        CAPTURE( test_case.name );
        if( test_case.target.scope == assignment_scope::context ) {
            const sol::object actual = context_data.raw_get<sol::object>(
                                           std::string( test_case.target.key ) );
            REQUIRE( actual.valid() );
            if( test_case.expects_error &&
                std::holds_alternative<std::string_view>( test_case.old_value ) ) {
                REQUIRE( actual.get_type() == sol::type::string );
                CHECK( actual.as<std::string>() ==
                       std::get<std::string_view>( test_case.old_value ) );
            } else {
                REQUIRE( actual.get_type() == sol::type::number );
                if( test_case.expects_error ) {
                    CHECK( actual.as<double>() == test_case.expected_value );
                } else {
                    check_numeric_result( test_case, actual.as<double>() );
                }
            }
        } else {
            const diag_value *actual = lookup_storage_value(
                                           test_case.target, alpha, beta, native_context );
            REQUIRE( actual != nullptr );
            if( test_case.expects_error &&
                std::holds_alternative<std::string_view>( test_case.old_value ) ) {
                REQUIRE( actual->is_str() );
                CHECK( actual->str() ==
                       std::get<std::string_view>( test_case.old_value ) );
            } else {
                REQUIRE( actual->is_dbl() );
                if( test_case.expects_error ) {
                    CHECK( actual->dbl() == test_case.expected_value );
                } else {
                    check_numeric_result( test_case, actual->dbl() );
                }
            }
        }
    }
}

} // namespace

TEST_CASE( "lua_platform_dynamic_assignment_migration_matches_native_math",
           "[lua][platform][dynamic_assignment_migration][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 7811 ), true );
    beta.setID( character_id( 7812 ), true );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );

    dialogue native_pair( get_talker_for( alpha ), get_talker_for( beta ) );
    saved_global_values restore_globals;

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::math );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "dynamic_assignment_migration", 7813, lua );
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
                             alpha, { "avatar", 7811, 0, 0, 0, {} },
                             owner->handle_runtime(), world_generation );
    lua["beta_owner"] = platform::game_handle::from_creature(
                            beta, { "npc", 7812, 0, 0, 0, {} },
                            owner->handle_runtime(), world_generation );

    initialize_assignment_fixture( alpha, beta, native_pair );

    std::vector<eoc_math> native_expressions;
    native_expressions.reserve( assignment_cases.size() );
    for( const assignment_case &test_case : assignment_cases ) {
        native_expressions.push_back( native_assignment( test_case ) );
    }
    finalize_conditions();
    for( std::size_t index = 0; index < assignment_cases.size(); ++index ) {
        const assignment_case &test_case = assignment_cases[index];
        CAPTURE( test_case.name );
        double result = 0.0;
        // eoc_math::act catches math::exception and reports it through debugmsg.
        const std::string diagnostic = capture_debugmsg_during( [&]() {
            result = native_expressions[index].act( native_pair );
        } );
        if( test_case.expects_error ) {
            CHECK( result == 0.0 );
            CHECK( diagnostic.find( "Type mismatch" ) != std::string::npos );
        } else {
            CHECK( result == 0.0 );
            CHECK( diagnostic.empty() );
        }
    }
    check_native_assignment_values( alpha, beta, native_pair );

    // Captured verbatim from tools/migrate_lua_first.py::render_static_character_math.
    // Actor targets: u/read_u=alpha_owner and n/read_npc=beta_owner.
    constexpr std::array<std::string_view, 16> captured_lua_output = {
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(alpha_owner, \"dynamic_alpha_ad"
        "d\", {strict=true}); if variable_result.ok == false and variable_result.error and vari"
        "able_result.error.code == \"variable_type_mismatch\" then services.diagnostic(\"Math v"
        "ariable u_dynamic_alpha_add: \" .. variable_result.error.message); return nil end; val"
        "ues[1] = (function(result) if result.exists == false then return 0.0 end; return resul"
        "t.value end)(service_value(variable_result)); variable_result = services.variables.get"
        "_number(alpha_owner, \"dynamic_alpha_add_rhs\", {strict=true}); if variable_result.ok "
        "== false and variable_result.error and variable_result.error.code == \"variable_type_m"
        "ismatch\" then services.diagnostic(\"Math variable u_dynamic_alpha_add_rhs: \" .. vari"
        "able_result.error.message); return nil end; values[2] = (function(result) if result.ex"
        "ists == false then return 0.0 end; return result.value end)(service_value(variable_res"
        "ult)); values[3] = values[1] + values[2]; return values[3] end)()\n        if assigned"
        "_value ~= nil then\n            service_value(services.variables.set(\n               "
        " alpha_owner, \"dynamic_alpha_add\", assigned_value, { include_before = false }))\n   "
        "     end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(beta_owner, \"dynamic_beta_sub"
        "\", {strict=true}); if variable_result.ok == false and variable_result.error and varia"
        "ble_result.error.code == \"variable_type_mismatch\" then services.diagnostic(\"Math va"
        "riable n_dynamic_beta_sub: \" .. variable_result.error.message); return nil end; value"
        "s[1] = (function(result) if result.exists == false then return 0.0 end; return result."
        "value end)(service_value(variable_result)); variable_result = services.variables.get_n"
        "umber(alpha_owner, \"dynamic_alpha_sub_rhs\", {strict=true}); if variable_result.ok =="
        " false and variable_result.error and variable_result.error.code == \"variable_type_mis"
        "match\" then services.diagnostic(\"Math variable u_dynamic_alpha_sub_rhs: \" .. variab"
        "le_result.error.message); return nil end; values[2] = (function(result) if result.exis"
        "ts == false then return 0.0 end; return result.value end)(service_value(variable_resul"
        "t)); values[3] = values[1] - values[2]; return values[3] end)()\n        if assigned_v"
        "alue ~= nil then\n            service_value(services.variables.set(\n                b"
        "eta_owner, \"dynamic_beta_sub\", assigned_value, { include_before = false }))\n       "
        " end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_global_number(\"dynamic_global_mul\", "
        "{strict=true}); if variable_result.ok == false and variable_result.error and variable_"
        "result.error.code == \"variable_type_mismatch\" then services.diagnostic(\"Math variab"
        "le dynamic_global_mul: \" .. variable_result.error.message); return nil end; values[1]"
        " = (function(result) if result.exists == false then return 0.0 end; return result.valu"
        "e end)(service_value(variable_result)); variable_result = services.variables.get_numbe"
        "r(beta_owner, \"dynamic_beta_mul_rhs\", {strict=true}); if variable_result.ok == false"
        " and variable_result.error and variable_result.error.code == \"variable_type_mismatch"
        "\" then services.diagnostic(\"Math variable n_dynamic_beta_mul_rhs: \" .. variable_res"
        "ult.error.message); return nil end; values[2] = (function(result) if result.exists == "
        "false then return 0.0 end; return result.value end)(service_value(variable_result)); v"
        "alues[3] = values[1] * values[2]; return values[3] end)()\n        if assigned_value ~"
        "= nil then\n            service_value(services.variables.set_global(\n                "
        "\"dynamic_global_mul\", assigned_value, { include_before = false }))\n        end\n   "
        " end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_context_number(context and context.dat"
        "a, \"dynamic_context_div\", {strict=true}); if variable_result.ok == false and variabl"
        "e_result.error and variable_result.error.code == \"variable_type_mismatch\" then servi"
        "ces.diagnostic(\"Math variable _dynamic_context_div: \" .. variable_result.error.messa"
        "ge); return nil end; values[1] = (function(result) if result.exists == false then retu"
        "rn 0.0 end; return result.value end)(service_value(variable_result)); variable_result "
        "= services.variables.get_global_number(\"dynamic_global_div_rhs\", {strict=true}); if "
        "variable_result.ok == false and variable_result.error and variable_result.error.code ="
        "= \"variable_type_mismatch\" then services.diagnostic(\"Math variable dynamic_global_d"
        "iv_rhs: \" .. variable_result.error.message); return nil end; values[2] = (function(re"
        "sult) if result.exists == false then return 0.0 end; return result.value end)(service_"
        "value(variable_result)); values[3] = values[1] / values[2]; return values[3] end)()\n "
        "       if assigned_value ~= nil then\n            context.data[\"dynamic_context_div\""
        "] = assigned_value\n        end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(alpha_owner, \"dynamic_alpha_mo"
        "d\", {strict=true}); if variable_result.ok == false and variable_result.error and vari"
        "able_result.error.code == \"variable_type_mismatch\" then services.diagnostic(\"Math v"
        "ariable u_dynamic_alpha_mod: \" .. variable_result.error.message); return nil end; val"
        "ues[1] = (function(result) if result.exists == false then return 0.0 end; return resul"
        "t.value end)(service_value(variable_result)); variable_result = services.variables.get"
        "_context_number(context and context.data, \"dynamic_context_mod_rhs\", {strict=true});"
        " if variable_result.ok == false and variable_result.error and variable_result.error.co"
        "de == \"variable_type_mismatch\" then services.diagnostic(\"Math variable _dynamic_con"
        "text_mod_rhs: \" .. variable_result.error.message); return nil end; values[2] = (funct"
        "ion(result) if result.exists == false then return 0.0 end; return result.value end)(se"
        "rvice_value(variable_result)); values[3] = math.fmod(values[1], values[2]); return val"
        "ues[3] end)()\n        if assigned_value ~= nil then\n            service_value(servic"
        "es.variables.set(\n                alpha_owner, \"dynamic_alpha_mod\", assigned_value,"
        " { include_before = false }))\n        end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(alpha_owner, \"dynamic_alpha_in"
        "crement\", {strict=true}); if variable_result.ok == false and variable_result.error an"
        "d variable_result.error.code == \"variable_type_mismatch\" then services.diagnostic(\""
        "Math variable u_dynamic_alpha_increment: \" .. variable_result.error.message); return "
        "nil end; values[1] = (function(result) if result.exists == false then return 0.0 end; "
        "return result.value end)(service_value(variable_result)); values[2] = 1.0; values[3] ="
        " values[1] + values[2]; return values[3] end)()\n        if assigned_value ~= nil then"
        "\n            service_value(services.variables.set(\n                alpha_owner, \"dy"
        "namic_alpha_increment\", assigned_value, { include_before = false }))\n        end\n  "
        "  end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(beta_owner, \"dynamic_beta_decr"
        "ement\", {strict=true}); if variable_result.ok == false and variable_result.error and "
        "variable_result.error.code == \"variable_type_mismatch\" then services.diagnostic(\"Ma"
        "th variable n_dynamic_beta_decrement: \" .. variable_result.error.message); return nil"
        " end; values[1] = (function(result) if result.exists == false then return 0.0 end; ret"
        "urn result.value end)(service_value(variable_result)); values[2] = 1.0; values[3] = va"
        "lues[1] - values[2]; return values[3] end)()\n        if assigned_value ~= nil then\n "
        "           service_value(services.variables.set(\n                beta_owner, \"dynami"
        "c_beta_decrement\", assigned_value, { include_before = false }))\n        end\n    end"
        "\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(alpha_owner, \"dynamic_alpha_mi"
        "ssing\", {strict=true}); if variable_result.ok == false and variable_result.error and "
        "variable_result.error.code == \"variable_type_mismatch\" then services.diagnostic(\"Ma"
        "th variable u_dynamic_alpha_missing: \" .. variable_result.error.message); return nil "
        "end; values[1] = (function(result) if result.exists == false then return 0.0 end; retu"
        "rn result.value end)(service_value(variable_result)); values[2] = 1.0; values[3] = val"
        "ues[1] + values[2]; return values[3] end)()\n        if assigned_value ~= nil then\n  "
        "          service_value(services.variables.set(\n                alpha_owner, \"dynami"
        "c_alpha_missing\", assigned_value, { include_before = false }))\n        end\n    end"
        "\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; values[1] = 0.0; variable_result = services.variables.get_number(alpha_owner, "
        "\"dynamic_alpha_replace_rhs\", {strict=true}); if variable_result.ok == false and vari"
        "able_result.error and variable_result.error.code == \"variable_type_mismatch\" then se"
        "rvices.diagnostic(\"Math variable u_dynamic_alpha_replace_rhs: \" .. variable_result.e"
        "rror.message); return nil end; values[2] = (function(result) if result.exists == false"
        " then return 0.0 end; return result.value end)(service_value(variable_result)); values"
        "[3] = values[1] + values[2]; return values[3] end)()\n        if assigned_value ~= nil"
        " then\n            service_value(services.variables.set(\n                beta_owner, "
        "\"dynamic_beta_replace\", assigned_value, { include_before = false }))\n        end\n "
        "   end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(alpha_owner, \"dynamic_alpha_ba"
        "d_rhs\", {strict=true}); if variable_result.ok == false and variable_result.error and "
        "variable_result.error.code == \"variable_type_mismatch\" then services.diagnostic(\"Ma"
        "th variable u_dynamic_alpha_bad_rhs: \" .. variable_result.error.message); return nil "
        "end; values[1] = (function(result) if result.exists == false then return 0.0 end; retu"
        "rn result.value end)(service_value(variable_result)); variable_result = services.varia"
        "bles.get_number(beta_owner, \"dynamic_beta_bad_rhs\", {strict=true}); if variable_resu"
        "lt.ok == false and variable_result.error and variable_result.error.code == \"variable_"
        "type_mismatch\" then services.diagnostic(\"Math variable n_dynamic_beta_bad_rhs: \" .."
        " variable_result.error.message); return nil end; values[2] = (function(result) if resu"
        "lt.exists == false then return 0.0 end; return result.value end)(service_value(variabl"
        "e_result)); values[3] = values[1] + values[2]; return values[3] end)()\n        if ass"
        "igned_value ~= nil then\n            service_value(services.variables.set(\n          "
        "      alpha_owner, \"dynamic_alpha_bad_rhs\", assigned_value, { include_before = false"
        " }))\n        end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_global_number(\"dynamic_global_bad_old"
        "\", {strict=true}); if variable_result.ok == false and variable_result.error and varia"
        "ble_result.error.code == \"variable_type_mismatch\" then services.diagnostic(\"Math va"
        "riable dynamic_global_bad_old: \" .. variable_result.error.message); return nil end; v"
        "alues[1] = (function(result) if result.exists == false then return 0.0 end; return res"
        "ult.value end)(service_value(variable_result)); variable_result = services.variables.g"
        "et_number(alpha_owner, \"dynamic_alpha_good_rhs\", {strict=true}); if variable_result."
        "ok == false and variable_result.error and variable_result.error.code == \"variable_typ"
        "e_mismatch\" then services.diagnostic(\"Math variable u_dynamic_alpha_good_rhs: \" .. "
        "variable_result.error.message); return nil end; values[2] = (function(result) if resul"
        "t.exists == false then return 0.0 end; return result.value end)(service_value(variable"
        "_result)); values[3] = values[1] + values[2]; return values[3] end)()\n        if assi"
        "gned_value ~= nil then\n            service_value(services.variables.set_global(\n    "
        "            \"dynamic_global_bad_old\", assigned_value, { include_before = false }))\n"
        "        end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(alpha_owner, \"dynamic_alpha_in"
        "finity\", {strict=true}); if variable_result.ok == false and variable_result.error and"
        " variable_result.error.code == \"variable_type_mismatch\" then services.diagnostic(\"M"
        "ath variable u_dynamic_alpha_infinity: \" .. variable_result.error.message); return ni"
        "l end; values[1] = (function(result) if result.exists == false then return 0.0 end; re"
        "turn result.value end)(service_value(variable_result)); variable_result = services.var"
        "iables.get_global_number(\"dynamic_global_zero\", {strict=true}); if variable_result.o"
        "k == false and variable_result.error and variable_result.error.code == \"variable_type"
        "_mismatch\" then services.diagnostic(\"Math variable dynamic_global_zero: \" .. variab"
        "le_result.error.message); return nil end; values[2] = (function(result) if result.exis"
        "ts == false then return 0.0 end; return result.value end)(service_value(variable_resul"
        "t)); values[3] = values[1] / values[2]; return values[3] end)()\n        if assigned_v"
        "alue ~= nil then\n            service_value(services.variables.set(\n                a"
        "lpha_owner, \"dynamic_alpha_infinity\", assigned_value, { include_before = false }))\n"
        "        end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(beta_owner, \"dynamic_beta_nega"
        "tive_infinity\", {strict=true}); if variable_result.ok == false and variable_result.er"
        "ror and variable_result.error.code == \"variable_type_mismatch\" then services.diagnos"
        "tic(\"Math variable n_dynamic_beta_negative_infinity: \" .. variable_result.error.mess"
        "age); return nil end; values[1] = (function(result) if result.exists == false then ret"
        "urn 0.0 end; return result.value end)(service_value(variable_result)); variable_result"
        " = services.variables.get_global_number(\"dynamic_global_zero\", {strict=true}); if va"
        "riable_result.ok == false and variable_result.error and variable_result.error.code == "
        "\"variable_type_mismatch\" then services.diagnostic(\"Math variable dynamic_global_zer"
        "o: \" .. variable_result.error.message); return nil end; values[2] = (function(result)"
        " if result.exists == false then return 0.0 end; return result.value end)(service_value"
        "(variable_result)); values[3] = values[1] / values[2]; return values[3] end)()\n      "
        "  if assigned_value ~= nil then\n            service_value(services.variables.set(\n  "
        "              beta_owner, \"dynamic_beta_negative_infinity\", assigned_value, { includ"
        "e_before = false }))\n        end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; local variable_r"
        "esult; variable_result = services.variables.get_number(alpha_owner, \"dynamic_alpha_ne"
        "gative_zero\", {strict=true}); if variable_result.ok == false and variable_result.erro"
        "r and variable_result.error.code == \"variable_type_mismatch\" then services.diagnosti"
        "c(\"Math variable u_dynamic_alpha_negative_zero: \" .. variable_result.error.message);"
        " return nil end; values[1] = (function(result) if result.exists == false then return 0"
        ".0 end; return result.value end)(service_value(variable_result)); variable_result = se"
        "rvices.variables.get_global_number(\"dynamic_global_two\", {strict=true}); if variable"
        "_result.ok == false and variable_result.error and variable_result.error.code == \"vari"
        "able_type_mismatch\" then services.diagnostic(\"Math variable dynamic_global_two: \" ."
        ". variable_result.error.message); return nil end; values[2] = (function(result) if res"
        "ult.exists == false then return 0.0 end; return result.value end)(service_value(variab"
        "le_result)); values[3] = math.fmod(values[1], values[2]); return values[3] end)()\n   "
        "     if assigned_value ~= nil then\n            service_value(services.variables.set("
        "\n                alpha_owner, \"dynamic_alpha_negative_zero\", assigned_value, { incl"
        "ude_before = false }))\n        end\n    end\n",
        "    do\n        local assigned_value = (function() local values = {}; values[1] = 0.0;"
        " values[2] = 0.0; values[3] = 2.0; values[4] = values[2] / values[3]; values[5] = valu"
        "es[1] + values[4]; return values[5] end)()\n        if assigned_value ~= nil then\n   "
        "         service_value(services.variables.set_global(\n                \"dynamic_globa"
        "l_positive_zero\", assigned_value, { include_before = false }))\n        end\n    end"
        "\n",
        "    do\n        local assigned_value = (function() local values = {}; values[1] = 0.0;"
        " values[2] = 0.0; values[3] = 0.0; values[4] = values[2] / values[3]; values[5] = valu"
        "es[1] + values[4]; return values[5] end)()\n        if assigned_value ~= nil then\n   "
        "         service_value(services.variables.set_global(\n                \"dynamic_globa"
        "l_nan\", assigned_value, { include_before = false }))\n        end\n    end\n",
    };
    initialize_assignment_fixture( alpha, beta, native_pair );
    sol::table lua_context = make_lua_context( lua );
    lua["context"] = lua_context;
    const sol::table context_data = lua_context["data"];

    std::string script = R"lua(
local services = ccb.services
local function service_value(result)
    if not result.ok then
        error(result.error and result.error.message or "native variable operation failed", 0)
    end
    return result.value
end
)lua";
    for( const std::string_view output : captured_lua_output ) {
        script.append( output );
    }
    script += R"lua(
local alpha_infinity = service_value(services.variables.get_number(
    alpha_owner, "dynamic_alpha_infinity", {strict=true})).value
local beta_negative_infinity = service_value(services.variables.get_number(
    beta_owner, "dynamic_beta_negative_infinity", {strict=true})).value
local alpha_negative_zero = service_value(services.variables.get_number(
    alpha_owner, "dynamic_alpha_negative_zero", {strict=true})).value
local global_positive_zero = service_value(services.variables.get_global_number(
    "dynamic_global_positive_zero", {strict=true})).value
local global_nan = service_value(services.variables.get_global_number(
    "dynamic_global_nan", {strict=true})).value
local context_result = service_value(services.variables.get_context_number(
    context.data, "dynamic_context_div", {strict=true})).value
assert(alpha_infinity == math.huge)
assert(beta_negative_infinity == -math.huge)
assert(alpha_negative_zero == 0 and 1 / alpha_negative_zero == -math.huge)
assert(global_positive_zero == 0 and 1 / global_positive_zero == math.huge)
assert(global_nan ~= global_nan)
assert(context_result == 5)
)lua";

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
    CHECK( lua_diagnostic.find( "Math variable n_dynamic_beta_bad_rhs" ) !=
           std::string::npos );
    CHECK( lua_diagnostic.find( "Math variable dynamic_global_bad_old" ) !=
           std::string::npos );
    check_lua_assignment_values( alpha, beta, native_pair, context_data );
}

#endif // CATA_ENABLE_LUA_PLATFORM
