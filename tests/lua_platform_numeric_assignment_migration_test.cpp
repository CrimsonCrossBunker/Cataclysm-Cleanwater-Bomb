#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cmath>
#include <memory>
#include <string>
#include <string_view>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "debug.h"
#include "dialogue.h"
#include "global_vars.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser.h"
#include "math_parser_diag_value.h"
#include "math_parser_type.h"
#include "npc.h"
#include "talker.h"

namespace
{

bool apply_native_math_assignment( dialogue &context, const std::string_view source )
{
    math_exp expression;
    if( !expression.parse( source, true ) || expression.get_type() != math_type_t::assign ) {
        return false;
    }
    static_cast<void>( expression.eval( context ) );
    return true;
}

} // namespace

TEST_CASE( "lua_platform_literal_assignment_migration_matches_native_math",
           "[lua][platform][numeric_assignment_migration][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 7621 ), true );
    beta.setID( character_id( 7622 ), true );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::math );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "numeric_assignment_migration", 7623, lua );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;
    lua["ccb"] = ccb;

    const std::size_t world_generation = platform::detail::runtime_world_generation_storage();
    lua["alpha_owner"] = platform::game_handle::from_creature(
                             alpha, { "avatar", 7621, 0, 0, 0, {} },
                             owner->handle_runtime(), world_generation );
    lua["beta_owner"] = platform::game_handle::from_creature(
                            beta, { "npc", 7622, 0, 0, 0, {} },
                            owner->handle_runtime(), world_generation );

    const std::string global_key = "migration_global_large";
    const diag_value *previous_global = get_globals().maybe_get_global_value( global_key );
    const bool global_existed = previous_global != nullptr;
    const diag_value old_global = global_existed ? *previous_global : diag_value{};
    const on_out_of_scope restore_global( [global_key, global_existed, old_global]() {
        if( global_existed ) {
            get_globals().set_global_value( global_key, old_global );
        } else {
            get_globals().remove_global_value( global_key );
        }
    } );

    dialogue native_pair( get_talker_for( alpha ), get_talker_for( beta ) );
    const std::string character_key = "migration_scientific";
    const std::string positive_zero_key = "migration_positive_zero";
    const std::string beta_key = "migration_negative_zero";
    const std::string context_key = "migration_context_zero";
    alpha.set_value( character_key, diag_value( "old alpha text" ) );
    alpha.set_value( positive_zero_key, diag_value( "old zero text" ) );
    beta.set_value( beta_key, diag_value( "old beta text" ) );
    get_globals().set_global_value( global_key, diag_value( "old global text" ) );
    native_pair.set_value( context_key, diag_value( "old context text" ) );

    REQUIRE( apply_native_math_assignment( native_pair,
                                           "u_migration_scientific = 1.25e2" ) );
    REQUIRE( apply_native_math_assignment( native_pair,
                                           "u_migration_positive_zero = 0" ) );
    REQUIRE( apply_native_math_assignment( native_pair,
                                           "n_migration_negative_zero = -0" ) );
    REQUIRE( apply_native_math_assignment( native_pair,
                                           "migration_global_large = 1e300" ) );
    REQUIRE( apply_native_math_assignment( native_pair,
                                           "_migration_context_zero = 0" ) );

    REQUIRE( alpha.get_value( character_key ).is_dbl() );
    REQUIRE( alpha.get_value( positive_zero_key ).is_dbl() );
    REQUIRE( beta.get_value( beta_key ).is_dbl() );
    REQUIRE( get_globals().get_global_value( global_key ).is_dbl() );
    REQUIRE( native_pair.get_value( context_key ).is_dbl() );
    const double native_character = alpha.get_value( character_key ).dbl();
    const double native_positive_zero = alpha.get_value( positive_zero_key ).dbl();
    const double native_beta_zero = beta.get_value( beta_key ).dbl();
    const double native_global = get_globals().get_global_value( global_key ).dbl();
    const double native_context = native_pair.get_value( context_key ).dbl();
    CHECK( native_character == 125.0 );
    CHECK( std::isfinite( native_global ) );
    CHECK( native_global == 1e300 );

    // Reinstall non-numeric old values so both Native '=' and the generated
    // setter path prove replacement without reading/converting the old value.
    alpha.set_value( character_key, diag_value( "old alpha text" ) );
    alpha.set_value( positive_zero_key, diag_value( "old zero text" ) );
    beta.set_value( beta_key, diag_value( "old beta text" ) );
    get_globals().set_global_value( global_key, diag_value( "old global text" ) );
    native_pair.set_value( context_key, diag_value( "old context text" ) );
    sol::table context = lua.create_table();
    sol::table context_data = lua.create_table_with( context_key, "old context text" );
    context["data"] = context_data;
    lua["context"] = context;

    const auto run_lua_assignment = [&]( const std::string & script ) {
        platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script(
                    script, sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    };

    // These direct writes are the captured render_static_character_math
    // output. The assignment RHS remains 0.0 + literal, matching Native '='.
    run_lua_assignment( R"lua(
local services = ccb.services
local function service_value(result)
    if not result.ok then error(result.error.message, 0) end
    return result.value
end
service_value(services.variables.set(
    alpha_owner, "migration_scientific", 0.0 + (125), { include_before = false }))
service_value(services.variables.set(
    alpha_owner, "migration_positive_zero", 0.0 + (0), { include_before = false }))
service_value(services.variables.set(
    beta_owner, "migration_negative_zero", 0.0 + (-0), { include_before = false }))
service_value(services.variables.set_global(
    "migration_global_large", 0.0 + (1.0000000000000001e+300), { include_before = false }))
context.data["migration_context_zero"] = 0.0 + (0)
assert(math.type(0.0 + (125)) == "float")
assert(math.type(0.0 + (0)) == "float")
assert(math.type(0.0 + (-0)) == "float")
assert(math.type(0.0 + (1.0000000000000001e+300)) == "float")
assert(math.type(context.data["migration_context_zero"]) == "float")
)lua" );

    CHECK( alpha.get_value( character_key ).is_dbl() );
    CHECK( alpha.get_value( character_key ).dbl() == native_character );
    CHECK( alpha.get_value( positive_zero_key ).is_dbl() );
    CHECK( alpha.get_value( positive_zero_key ).dbl() == native_positive_zero );
    CHECK( std::signbit( alpha.get_value( positive_zero_key ).dbl() ) ==
           std::signbit( native_positive_zero ) );
    CHECK( beta.get_value( beta_key ).is_dbl() );
    CHECK( beta.get_value( beta_key ).dbl() == native_beta_zero );
    CHECK( std::signbit( beta.get_value( beta_key ).dbl() ) == std::signbit( native_beta_zero ) );
    CHECK( get_globals().get_global_value( global_key ).is_dbl() );
    CHECK( get_globals().get_global_value( global_key ).dbl() == native_global );
    const sol::object context_zero = context_data[context_key];
    REQUIRE( context_zero.get_type() == sol::type::number );
    CHECK( context_zero.as<double>() == native_context );
    CHECK( std::signbit( context_zero.as<double>() ) == std::signbit( native_context ) );

    const std::string missing_beta_key = "migration_missing_beta";
    alpha.set_value( missing_beta_key, 73.0 );
    dialogue native_without_beta( get_talker_for( alpha ), nullptr );
    math_exp missing_beta_assignment;
    REQUIRE( missing_beta_assignment.parse( "n_migration_missing_beta = 99", true ) );
    REQUIRE( missing_beta_assignment.get_type() == math_type_t::assign );
    const std::string missing_beta_warning = capture_debugmsg_during( [&]() {
        static_cast<void>( missing_beta_assignment.eval( native_without_beta ) );
    } );
    CHECK( missing_beta_warning.find( "invalid beta talker" ) != std::string::npos );
    CHECK( alpha.get_value( missing_beta_key ).dbl() == 73.0 );

    // Tool regression checks separately prove that an absent read_npc target
    // is left TODO instead of emitting a write against mutation-fallback alpha.
    CHECK( beta.maybe_get_value( missing_beta_key ) == nullptr );
}

#endif // CATA_ENABLE_LUA_PLATFORM
