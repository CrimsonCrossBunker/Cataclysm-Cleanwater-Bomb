#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "debug.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "mounted_charge.h"

TEST_CASE( "lua_platform_mounted_charge_damage_validates_results_and_snapshots",
           "[lua][platform][mounted][charge]" )
{
    namespace platform = cata::lua_platform;
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math );
    sol::table ccb = lua.create_table();
    const auto owner = platform::make_runtime( "charge-damage-test", 4301, lua );
    const auto previous = platform::detail::active_runtimes;
    const on_out_of_scope cleanup( [previous]() {
        platform::set_active_runtimes( previous );
        debug_reset_error_observed();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;
    lua["ccb"] = ccb;

    const std::string body = GENERATE(
                                 std::string( "return 1.25" ), std::string( "return -10" ),
                                 std::string( "return 10" ), std::string( "return 'invalid'" ),
                                 std::string( "return 0/0" ), std::string( "return math.huge" ),
                                 std::string( "return 1.1, 1.2" ), std::string( "return" ),
                                 std::string( "error('charge damage sentinel')" ) );
    CAPTURE( body );
    const sol::protected_function_result registration = lua.safe_script( R"lua(
ccb.runtime.handler("damage", function(context)
    assert(context.technique_id == "MOUNTED_CHARGE")
    assert(context.character ~= nil)
    assert(type(context.weapon_id) == "string")
    assert(context.completed_steps == 3)
    assert(context.mount_speed == 123.5)
    assert(type(context.running) == "boolean")
    assert(context.damage_type == "stab")
    assert(math.abs(context.multiplier_per_step - 0.1) < 0.00001)
    assert(context.max_multiplier == 1.5)
)lua" + body + "\nend, 1)", sol::script_pass_on_error );
    REQUIRE( registration.valid() );
    mounted_charge_profile profile;
    profile.max_steps = 15;
    const std::optional<double> multiplier = platform::invoke_mounted_charge_damage_handler(
            "MOUNTED_CHARGE", "charge-damage-test", "damage", get_avatar(), profile, 3, 123.5 );
    if( body == "return 1.25" ) {
        REQUIRE( multiplier.has_value() );
        CHECK( *multiplier == Approx( 1.25 ) );
    } else if( body == "return -10" ) {
        REQUIRE( multiplier.has_value() );
        CHECK( *multiplier == 1.0 );
    } else if( body == "return 10" ) {
        REQUIRE( multiplier.has_value() );
        CHECK( *multiplier == 1.5 );
    } else {
        CHECK_FALSE( multiplier.has_value() );
        CHECK( debug_has_error_been_observed() );
    }
    CHECK( owner->callback_depth == 0 );
    CHECK_FALSE( platform::invoke_mounted_charge_damage_handler(
                     "MOUNTED_CHARGE", "charge-damage-test", "missing", get_avatar(), profile, 3,
                     123.5 ).has_value() );
    owner->world_is_ready = false;
    CHECK_FALSE( platform::invoke_mounted_charge_damage_handler(
                     "MOUNTED_CHARGE", "charge-damage-test", "damage", get_avatar(), profile, 3,
                     123.5 ).has_value() );
}

#endif
