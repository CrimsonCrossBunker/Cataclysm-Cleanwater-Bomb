#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "dispersion.h"
#include "enums.h"
#include "flexbuffer_json.h"
#include "gun_mode.h"
#include "item.h"
#include "itype.h"
#include "json_error.h"
#include "json_loader.h"
#include "line.h"
#include "ranged.h"
#include "translations.h"
#include "type_id.h"
#include "units.h"

static const gun_mode_id gun_mode_AUTO( "AUTO" );
static const gun_mode_id gun_mode_BURST( "BURST" );
static const gun_mode_id gun_mode_DEFAULT( "DEFAULT" );
static const gun_mode_id gun_mode_REACH( "REACH" );
static const gun_mode_id gun_mode_VOLLEY( "VOLLEY" );
static const itype_id itype_223( "223" );
static const itype_id itype_308( "308" );
static const itype_id itype_545( "545" );
static const itype_id itype_kord( "kord" );
static const itype_id itype_m14ebr( "m14ebr" );
static const itype_id itype_modular_m16_auto_rifle( "modular_m16_auto_rifle" );
static const itype_id itype_modular_m16a4( "modular_m16a4" );
static const itype_id itype_test_multimag_gun( "test_multimag_gun" );
static const itype_id itype_test_multimag_gun_consume( "test_multimag_gun_consume" );
static const skill_id skill_gun( "gun" );
static const skill_id skill_rifle( "rifle" );

TEST_CASE( "trained_rifle_shooters_can_hold_a_close_automatic_burst",
           "[ranged][gun_rpm][recoil]" )
{
    const bool battle_rifle = GENERATE( false, true );
    const int strength = battle_rifle ? 14 : 8;
    avatar shooter;
    shooter.normalize();
    shooter.set_str_base( strength );
    shooter.reset_stats();
    shooter.set_skill_level( skill_gun, 7 );
    shooter.set_skill_level( skill_rifle, 7 );
    item rifle( battle_rifle ? itype_m14ebr : itype_modular_m16_auto_rifle );
    rifle.ammo_set( battle_rifle ? itype_308 : itype_223, 12 );
    REQUIRE( rifle.ammo_remaining() == 12 );
    REQUIRE( rifle.gun_set_mode( gun_mode_AUTO ) );
    const gun_mode mode = rifle.gun_current_mode();
    REQUIRE( mode.full_auto() );
    const int kick = rifle.gun_recoil( shooter );
    REQUIRE( kick > 0 );

    firearm_burst_recoil control( shooter.get_arm_str(), shooter.get_skill_level( skill_rifle ),
                                  mode.rpm );
    const double second_shot = control.after_shot( kick );
    const double third_shot = control.after_shot( kick );
    CHECK( second_shot < kick * 5.0 * 0.65 );
    CHECK( third_shot > second_shot );
    const double aim = rifle.sight_dispersion( shooter ).second;
    for( int fired = 3; fired < 12; ++fired ) {
        const double recoil = control.after_shot( kick );
        if( fired >= 5 ) {
            // Aimed shots after settling stay inside a standing medium target at four tiles.
            const double dispersion = shooter.total_gun_dispersion( rifle, aim + recoil, 0 ).max();
            CHECK( iso_tangent( 4, units::from_arcmin( dispersion + 11.0 ) ) <
                   occupied_tile_fraction( creature_size::medium ) );
            CHECK( recoil < second_shot );
        }
    }
}

TEST_CASE( "arm_strength_and_weapon_skill_both_help_settle_a_burst",
           "[ranged][gun_rpm][recoil]" )
{
    firearm_burst_recoil strong( 14, 7.0f, 750 );
    firearm_burst_recoil average( 8, 7.0f, 750 );
    firearm_burst_recoil novice( 8, 1.0f, 750 );
    constexpr int kick = 150;
    CHECK( strong.after_shot( kick ) < average.after_shot( kick ) );
    // Compare equally long bursts using the same weapon kick.
    novice.after_shot( kick );
    double strong_recoil = 0.0;
    double average_recoil = 0.0;
    double novice_recoil = 0.0;
    for( int fired = 2; fired <= 5; ++fired ) {
        strong_recoil = strong.after_shot( kick );
        average_recoil = average.after_shot( kick );
        novice_recoil = novice.after_shot( kick );
    }
    CHECK( strong_recoil < average_recoil );
    CHECK( average_recoil < novice_recoil );
}

TEST_CASE( "faster_cyclic_rate_and_lower_weapon_kick_tighten_the_second_shot",
           "[ranged][gun_rpm][recoil]" )
{
    avatar shooter;
    shooter.normalize();
    shooter.set_skill_level( skill_gun, 7 );
    shooter.set_skill_level( skill_rifle, 7 );
    item m16( itype_modular_m16a4 );
    m16.ammo_set( itype_223, 3 );
    item kord( itype_kord );
    kord.ammo_set( itype_545, 2 );
    REQUIRE( m16.ammo_remaining() == 3 );
    REQUIRE( kord.ammo_remaining() == 2 );
    REQUIRE( m16.gun_set_mode( gun_mode_BURST ) );
    REQUIRE( kord.gun_set_mode( gun_mode_BURST ) );
    const int m16_rpm = m16.gun_current_mode().rpm;
    const int kord_rpm = kord.gun_current_mode().rpm;
    const int m16_kick = m16.gun_recoil( shooter );
    const int kord_kick = kord.gun_recoil( shooter );
    REQUIRE( kord_rpm > m16_rpm );
    REQUIRE( m16_kick > kord_kick );
    REQUIRE( kord_kick > 0 );

    const int arm_strength = shooter.get_arm_str();
    const double m16_second = firearm_burst_recoil( arm_strength, 7.0f, m16_rpm ).after_shot(
                                  m16_kick );
    const double faster_second = firearm_burst_recoil( arm_strength, 7.0f, kord_rpm ).after_shot(
                                     m16_kick );
    const double kord_second = firearm_burst_recoil( arm_strength, 7.0f, kord_rpm ).after_shot(
                                   kord_kick );
    CHECK( faster_second < m16_second );
    CHECK( kord_second < m16_second * 0.65 );
}

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
    CHECK( gun.modes.at( gun_mode_AUTO ).qty() == 0 );
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

TEST_CASE( "fixed_burst_loads_legacy_or_explicit_cyclic_rate", "[ranged][gun_rpm]" )
{
    islot_gun gun;
    SECTION( "legacy burst preserves the name and count" ) {
        gun.deserialize( json_loader::from_string(
                             R"({"modes":[["BURST","2 rd.",2]]})" ).get_object() );
        const gun_modifier_data &burst = gun.modes.at( gun_mode_BURST );
        CHECK( burst.qty() == 2 );
        CHECK( burst.rpm() == 900 );
        CHECK( burst.tname() == to_translation( "2 rd." ).translated() );
    }
    SECTION( "explicit burst uses the same mode ID and preserves flags" ) {
        gun.deserialize( json_loader::from_string(
                             R"({"modes":[["brust-rpm","800",3,"NPC_AVOID"]]})" ).get_object() );
        REQUIRE( gun.modes.size() == 1 );
        const gun_modifier_data &burst = gun.modes.at( gun_mode_BURST );
        CHECK( burst.qty() == 3 );
        CHECK( burst.rpm() == 800 );
        CHECK( burst.flags().count( "NPC_AVOID" ) == 1 );
    }
    SECTION( "volley keeps its untimed fixed shot count" ) {
        gun.deserialize( json_loader::from_string(
                             R"({"modes":[["BURST","volley",2,"VOLLEY"]]})" ).get_object() );
        const gun_modifier_data &burst = gun.modes.at( gun_mode_BURST );
        CHECK( burst.qty() == 2 );
        CHECK( burst.rpm() == 0 );
    }
}

TEST_CASE( "fixed_burst_rejects_invalid_rate_count_and_flags", "[ranged][gun_rpm]" )
{
    const std::string fields = GENERATE( R"(0,2)", R"("0",2)", R"("900 RPM",2)",
                                         R"("2147483648",2)", R"("900","2")", R"("900",1)",
                                         R"("900",2.5)", R"("900",4294967298)",
                                         R"("900",2,"VOLLEY")", R"("900",2,["MELEE"])" );
    CAPTURE( fields );
    islot_gun gun;
    const JsonObject definition = json_loader::from_string(
                                      R"({"modes":[["brust-rpm",)" + fields + "]]}" ).get_object();
    CHECK_THROWS_AS( gun.deserialize( definition ), JsonError );
}

TEST_CASE( "fixed_burst_gunmod_uses_burst_mode_id", "[ranged][gun_rpm]" )
{
    islot_gunmod mod;
    mod.deserialize( json_loader::from_string( R"({
        "install_time": "1 s",
        "mod_targets": [ "rifle" ],
        "mode_modifier": [["brust-rpm","1000",2]]
    })" ).get_object() );
    REQUIRE( mod.mode_modifier.size() == 1 );
    const gun_modifier_data &burst = mod.mode_modifier.at( gun_mode_BURST );
    CHECK( burst.qty() == 2 );
    CHECK( burst.rpm() == 1000 );
}

TEST_CASE( "legacy_burst_has_a_fixed_count_on_every_trigger_pull", "[ranged][gun_rpm]" )
{
    item gun( itype_test_multimag_gun_consume );
    REQUIRE( gun.gun_set_mode( gun_mode_BURST ) );
    const gun_mode burst = gun.gun_current_mode();
    REQUIRE( burst.fixed_burst() );
    CHECK( burst.rpm == 900 );
    CHECK( burst.start_firing( calendar::turn_zero ) == 3 );
    CHECK( burst.start_firing( calendar::turn_zero ) == 3 );
    CHECK( burst.shots_available( calendar::turn_zero + 1_seconds ) == 3 );
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
