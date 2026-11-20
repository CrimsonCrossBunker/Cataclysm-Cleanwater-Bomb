#include <array>
#include <cmath>
#include <functional>
#include <memory>
#include <string>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "item.h"
#include "map_helpers.h"
#include "pimpl.h"
#include "player_helpers.h"
#include "type_id.h"
#include "units.h"
#include "weather.h"
#include "weather_gen.h"
#include "weather_type.h"

static const itype_id itype_balclava( "balclava" );
static const itype_id itype_bandana( "bandana" );
static const itype_id itype_boots( "boots" );
static const itype_id itype_boots_winter( "boots_winter" );
static const itype_id itype_coat_winter( "coat_winter" );
static const itype_id itype_gloves_fingerless( "gloves_fingerless" );
static const itype_id itype_gloves_liner( "gloves_liner" );
static const itype_id itype_gloves_winter( "gloves_winter" );
static const itype_id itype_gloves_wool( "gloves_wool" );
static const itype_id itype_goggles_ski( "goggles_ski" );
static const itype_id itype_hat_ball( "hat_ball" );
static const itype_id itype_hat_hunting( "hat_hunting" );
static const itype_id itype_hat_knit( "hat_knit" );
static const itype_id itype_jeans( "jeans" );
static const itype_id itype_long_underpants( "long_underpants" );
static const itype_id itype_pants_army( "pants_army" );
static const itype_id itype_pants_fur( "pants_fur" );
static const itype_id itype_sneakers( "sneakers" );
static const itype_id itype_socks( "socks" );
static const itype_id itype_socks_wool( "socks_wool" );
static const itype_id itype_test_jumpsuit_cotton( "test_jumpsuit_cotton" );
static const itype_id itype_test_jumpsuit_fur( "test_jumpsuit_fur" );
static const itype_id itype_test_jumpsuit_lycra( "test_jumpsuit_lycra" );
static const itype_id itype_trenchcoat( "trenchcoat" );
static const itype_id itype_tshirt( "tshirt" );
static const itype_id itype_under_armor( "under_armor" );
static const itype_id itype_vest( "vest" );

static void set_bodytemp_environment( int ambient_f )
{
    weather_manager &weather = get_weather();
    weather.forced_temperature = units::from_fahrenheit( ambient_f );
    weather.weather_precise->temperature = *weather.forced_temperature;
    weather.weather_precise->humidity = 50;
    weather.windspeed = 0;
    weather.weather_id = WEATHER_CLEAR;
    calendar::turn = calendar::turn_zero;
}

static void check_torso_temperature( const Character &who, int ambient_f,
                                     units::temperature target )
{
    const double actual = units::to_celsius( who.get_part_temp_cur( bodypart_id( "torso" ) ) );
    const double expected = units::to_celsius( target );
    CAPTURE( ambient_f, actual, expected );
    CHECK( std::abs( actual - expected ) < 0.2 );
}

// Set the stage for a particular ambient and target temperature and run update_bodytemp() until
// core body temperature settles.
static void temperature_check( Character *p, const int ambient_temp,
                               const units::temperature target_temp )
{
    p->set_body();
    p->clear_effects();
    set_bodytemp_environment( ambient_temp );
    p->set_all_parts_temp_cur( BODYTEMP_NORM );
    p->set_all_parts_temp_conv( BODYTEMP_NORM );

    units::temperature prev_temp = 0_K;
    units::temperature_delta prev_diff = 0_C_delta;
    for( int i = 0; i < 10000; i++ ) {
        const units::temperature torso_temp_cur = p->get_part_temp_cur( bodypart_id( "torso" ) );
        if( prev_diff != prev_temp - torso_temp_cur ) {
            prev_diff = prev_temp - torso_temp_cur;
        } else if( prev_temp == torso_temp_cur ) {
            break;
        }
        prev_temp = torso_temp_cur;
        calendar::turn += 1_turns;
        p->update_bodytemp();
    }
    check_torso_temperature( *p, ambient_temp, target_temp );
}

// Advance both the physiology and the clock so periodic sweat effects see real turns.
static void temperature_and_sweat_check( Character *p, const int ambient_temp,
        const units::temperature target_temp )
{
    set_bodytemp_environment( ambient_temp );
    const w_point &sample = *get_weather().weather_precise;
    for( int i = 0; i < to_turns<int>( 1_hours ); ++i ) {
        calendar::turn += 1_turns;
        p->process_effects();
        p->update_bodytemp();
        p->update_body_wetness( sample );
    }
    check_torso_temperature( *p, ambient_temp, target_temp );
}

static void equip_clothing( Character *p, const itype_id &clothing )
{
    const item article( clothing, calendar::turn_zero );
    p->wear_item( article );
}

// Ambient setpoints (°F) for the seven torso thresholds in clear, still air at 50% humidity.
static void test_temperature_spread( Character *p, const std::array<int, 7> &ambient_temps )
{
    temperature_check( p, ambient_temps[0], BODYTEMP_FREEZING );
    temperature_check( p, ambient_temps[1], BODYTEMP_VERY_COLD );
    temperature_check( p, ambient_temps[2], BODYTEMP_COLD );
    temperature_check( p, ambient_temps[3], BODYTEMP_NORM );
    temperature_check( p, ambient_temps[4], BODYTEMP_HOT );
    temperature_check( p, ambient_temps[5], BODYTEMP_VERY_HOT );
    temperature_check( p, ambient_temps[6], BODYTEMP_SCORCHING );
}

TEST_CASE( "player_body_temperatures_converge_on_expected_values", "[.bodytemp]" )
{
    const restore_on_out_of_scope restore_weather( get_weather() );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    clear_map_without_vision();
    Character &dummy = get_player_character();

    clear_character( dummy );

    // See http://personal.cityu.edu.hk/~bsapplec/heat.htm for temperature basis.
    // As we aren't modeling metabolic rate, assume 2 METS when not sleeping.
    // Obviously though 0.7 METS when sleeping is called for.

    // I'm not sure how to apply +1 METS as a temperature offset,
    // treating it as a 12C/54F boost across the board

    // The commented out tests are the ideals calculated from the above site.
    // The enabled tests are the current status quo just to check for regressions.

    SECTION( "Nude target temperatures." ) {
        //test_temperature_spread( &dummy, { 19, 34, 49, 64, 79, 94, 109 } );
        test_temperature_spread( &dummy, {{ -15, 12, 39, 67, 85, 99, 111 }} );
    }

    SECTION( "Lightly clothed target temperatures" ) {
        equip_clothing( &dummy, itype_hat_ball );
        equip_clothing( &dummy, itype_bandana );
        equip_clothing( &dummy, itype_tshirt );
        equip_clothing( &dummy, itype_gloves_fingerless );
        equip_clothing( &dummy, itype_jeans );
        equip_clothing( &dummy, itype_socks );
        equip_clothing( &dummy, itype_sneakers );

        //test_temperature_spread( &dummy, { -3, 12, 27, 42, 57, 72, 87 } );
        test_temperature_spread( &dummy, {{ -20, 7, 34, 64, 83, 98, 110 }} );
    }

    SECTION( "Heavily clothed target temperatures" ) {
        equip_clothing( &dummy, itype_hat_knit );
        equip_clothing( &dummy, itype_tshirt );
        equip_clothing( &dummy, itype_vest );
        equip_clothing( &dummy, itype_trenchcoat );
        equip_clothing( &dummy, itype_gloves_wool );
        equip_clothing( &dummy, itype_long_underpants );
        equip_clothing( &dummy, itype_pants_army );
        equip_clothing( &dummy, itype_socks_wool );
        equip_clothing( &dummy, itype_boots );

        //test_temperature_spread( &dummy, { -25, -10, 5, 20, 35, 50, 65 } );
        test_temperature_spread( &dummy, {{ -40, -13, 15, 53, 76, 93, 106 }} );
    }

    SECTION( "Arctic gear target temperatures" ) {
        equip_clothing( &dummy, itype_balclava );
        equip_clothing( &dummy, itype_goggles_ski );
        equip_clothing( &dummy, itype_hat_hunting );
        equip_clothing( &dummy, itype_under_armor );
        equip_clothing( &dummy, itype_vest );
        equip_clothing( &dummy, itype_coat_winter );
        equip_clothing( &dummy, itype_gloves_liner );
        equip_clothing( &dummy, itype_gloves_winter );
        equip_clothing( &dummy, itype_long_underpants );
        equip_clothing( &dummy, itype_pants_fur );
        equip_clothing( &dummy, itype_socks_wool );
        equip_clothing( &dummy, itype_boots_winter );

        //test_temperature_spread( &dummy, { -47, -32, -17, -2, 13, 28, 43 } );
        test_temperature_spread( &dummy, {{ -100, -73, -42, 0, 53, 76, 92 }} );
    }
}

TEST_CASE( "sweating", "[char][suffer][.bodytemp]" )
{
    const restore_on_out_of_scope restore_weather( get_weather() );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    clear_map_without_vision();
    avatar &dummy = get_avatar();
    clear_character( dummy );

    // three different materials of breathability, same warmth
    item fur_jumper( itype_test_jumpsuit_fur );
    item lycra_jumper( itype_test_jumpsuit_lycra );
    item cotton_jumper( itype_test_jumpsuit_cotton );

    GIVEN( "avatar wears outfit and sweats for an hour" ) {
        WHEN( "wearing fur" ) {
            dummy.clear_worn();
            dummy.wear_item( fur_jumper, false );

            temperature_and_sweat_check( &dummy, 100, 43.0_C );
        }
        WHEN( "wearing cotton" ) {
            dummy.clear_worn();
            dummy.wear_item( cotton_jumper, false );

            temperature_and_sweat_check( &dummy, 100, 42.9_C );
        }
        WHEN( "wearing lycra" ) {
            dummy.clear_worn();
            dummy.wear_item( lycra_jumper, false );

            temperature_and_sweat_check( &dummy, 100, 42.6_C );
        }

    }
}
