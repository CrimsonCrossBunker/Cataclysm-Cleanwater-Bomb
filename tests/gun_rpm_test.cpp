#include <string>

#include "calendar.h"
#include "cata_catch.h"
#include "flexbuffer_json.h"
#include "gun_mode.h"
#include "item.h"
#include "itype.h"
#include "json_error.h"
#include "json_loader.h"
#include "ranged.h"
#include "translations.h"
#include "type_id.h"

static const gun_mode_id gun_mode_AUTO( "AUTO" );
static const gun_mode_id gun_mode_BURST( "BURST" );
static const gun_mode_id gun_mode_DEFAULT( "DEFAULT" );
static const gun_mode_id gun_mode_REACH( "REACH" );
static const gun_mode_id gun_mode_VOLLEY( "VOLLEY" );
static const itype_id itype_test_multimag_gun( "test_multimag_gun" );
static const itype_id itype_test_multimag_gun_consume( "test_multimag_gun_consume" );

TEST_CASE( "gun_modes_load_legacy_quantities_and_rpm_strings", "[ranged][gun_rpm]" )
{
    islot_gun gun;
    gun.deserialize( json_loader::from_string( R"({
        "modes": [
            ["DEFAULT", "semi-auto", 1],
            ["AUTO", "auto", 2],
            ["EXPLICIT", "auto-rpm", "750"],
            ["VOLLEY", "volley", 2, ["VOLLEY"]],
            ["REACH", "bayonet", 2, "MELEE"]
        ]
    })" ).get_object() );

    CHECK( gun.modes.at( gun_mode_DEFAULT ).qty() == 1 );
    CHECK( gun.modes.at( gun_mode_DEFAULT ).rpm() == 0 );
    CHECK( gun.modes.at( gun_mode_AUTO ).rpm() == 600 );
    CHECK( gun.modes.at( gun_mode_id( "EXPLICIT" ) ).rpm() == 750 );
    CHECK( gun.modes.at( gun_mode_VOLLEY ).qty() == 2 );
    CHECK( gun.modes.at( gun_mode_VOLLEY ).rpm() == 0 );
    CHECK( gun.modes.at( gun_mode_REACH ).qty() == 2 );
    CHECK( gun.modes.at( gun_mode_REACH ).rpm() == 0 );
}

TEST_CASE( "gun_modes_reject_invalid_rpm_strings", "[ranged][gun_rpm]" )
{
    const std::string field = GENERATE( "\"0\"", "\"-1\"", "\"750'\"", "\"750 RPM\"",
                                       "\"2147483648\"", "\"750\", \"MELEE\"", "\"750\", \"VOLLEY\"" );
    CAPTURE( field );
    islot_gun gun;
    const JsonObject definition = json_loader::from_string(
                                      R"({"modes":[["AUTO","auto",)" + field + "]]}" ).get_object();
    CHECK_THROWS_AS( gun.deserialize( definition ), JsonError );
}

TEST_CASE( "legacy_burst_uses_the_converted_rate_on_an_item", "[ranged][gun_rpm]" )
{
    item gun( itype_test_multimag_gun_consume );
    REQUIRE( gun.gun_set_mode( gun_mode_BURST ) );
    const gun_mode burst = gun.gun_current_mode();
    CHECK( burst.rpm == 900 );
    CHECK( burst.start_firing( calendar::turn_zero ) == 15 );
    CHECK( gun.gun_current_mode().shots_available( calendar::turn_zero ) == 0 );
    CHECK( gun.gun_current_mode().shots_available( calendar::turn_zero + 1_seconds ) == 15 );
}

TEST_CASE( "gun_rpm_is_distributed_over_game_seconds", "[ranged][gun_rpm]" )
{
    item gun( itype_test_multimag_gun );
    const int rpm = GENERATE( 30, 600, 750 );
    const gun_mode automatic( to_translation( "auto" ), &gun, 0, {}, rpm );
    int total = 0;
    for( int second = 0; second < 60; ++second ) {
        const time_point when = calendar::turn_zero + time_duration::from_seconds( second );
        const int available = automatic.shots_available( when );
        if( rpm == 750 ) {
            CHECK( available == 12 + second % 2 );
        }
        CHECK( automatic.start_firing( when ) == available );
        CHECK( automatic.start_firing( when ) == 0 );
        total += available;
    }
    CHECK( total == rpm );
}

TEST_CASE( "gun_rpm_allowance_is_per_gun_and_shared_by_its_rpm_modes", "[ranged][gun_rpm]" )
{
    item gun( itype_test_multimag_gun );
    item other_gun( itype_test_multimag_gun );
    const gun_mode first( to_translation( "auto" ), &gun, 0, {}, 600 );
    const gun_mode faster( to_translation( "fast" ), &gun, 0, {}, 750 );
    const gun_mode other( to_translation( "auto" ), &other_gun, 0, {}, 600 );
    const gun_mode single( to_translation( "semi-auto" ), &gun, 1, {} );
    const time_point now = calendar::turn_zero;

    CHECK( first.start_firing( now ) == 10 );
    CHECK( faster.start_firing( now ) == 0 );
    CHECK( other.start_firing( now ) == 10 );
    CHECK( single.start_firing( now ) == 1 );
    CHECK( single.start_firing( now ) == 1 );
    CHECK( faster.start_firing( now + 11_seconds ) == 13 );
}

TEST_CASE( "selected_burst_round_count_depends_on_weapon_skill", "[ranged][gun_rpm]" )
{
    const auto beginner = firearm_burst_round_range( 11, 1 );
    CHECK( beginner.first == 8 );
    CHECK( beginner.second == 14 );
    const auto master = firearm_burst_round_range( 11, 10 );
    CHECK( master.first == 11 );
    CHECK( master.second == 11 );
    CHECK( firearm_burst_round_range( 2, 1 ).first == 2 );
    CHECK( firearm_burst_round_range( 30, 1 ).second == 30 );
}

TEST_CASE( "selected_burst_cost_scales_with_rpm_and_full_turn_ap", "[ranged][gun_rpm]" )
{
    CHECK( firearm_burst_move_cost( 11, 750, 100 ) == 88 );
    CHECK( firearm_burst_move_cost( 11, 750, 50 ) == 44 );
    CHECK( firearm_burst_move_cost( 30, 750, 100 ) == 240 );
    CHECK( firearm_burst_move_cost( 7, 750, 160 ) == 90 );
    CHECK( firearm_burst_move_cost( 3, 900, 100 ) == 20 );
    CHECK( firearm_burst_move_cost( 0, 750, 100 ) == 0 );
}
