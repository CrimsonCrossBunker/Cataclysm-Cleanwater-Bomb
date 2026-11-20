#include <functional>
#include <initializer_list>
#include <list>
#include <map>
#include <optional>
#include <string>
#include <utility>

#include "avatar.h"
#include "bodypart.h"
#include "body_part_set.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_attire.h"
#include "coordinates.h"
#include "damage.h"
#include "debug.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "fire.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "magic_enchantment.h"
#include "map.h"
#include "map_helpers.h"
#include "map_iterator.h"
#include "material.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "weather.h"
#include "weather_type.h"
#include "wound.h"

static const damage_type_id damage_heat( "heat" );
static const itype_id itype_test_extra_bodypart_clothing( "test_extra_bodypart_clothing" );
static const itype_id itype_test_protective_clothing( "test_protective_clothing" );

TEST_CASE( "clothing_warmth_ignores_absent_body_parts", "[character][clothing][warmth]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );

    const bodypart_id tail_long( "tail_long" );
    REQUIRE_FALSE( dummy.has_part( tail_long ) );
    dummy.wear_item( item( itype_test_extra_bodypart_clothing ), false );

    std::map<bodypart_id, int> warmth;
    const std::string debug_message = capture_debugmsg_during( [&] {
        warmth = dummy.worn.warmth( dummy );
    } );

    CHECK( debug_message.empty() );
    CHECK( warmth.at( body_part_torso ) == 20 );
    CHECK( warmth.count( tail_long ) == 0 );
}

TEST_CASE( "worn_clothing_provides_wind_resistance", "[character][clothing][wind]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );

    const std::map<bodypart_id, int> unprotected = dummy.get_wind_resistance();
    CHECK( unprotected.at( body_part_torso ) == 0 );

    dummy.wear_item( item( itype_test_protective_clothing ), false );

    const std::map<bodypart_id, int> protected_parts = dummy.get_wind_resistance();
    CHECK( protected_parts.at( body_part_torso ) == 100 );
    CHECK( protected_parts.at( body_part_head ) == 0 );
}

TEST_CASE( "wind_resistance_is_applied_independently_per_body_part", "[character][clothing][wind]" )
{
    avatar &dummy = get_avatar();
    clear_map();

    map &here = get_map();
    for( const tripoint_bub_ms &p : here.points_in_radius( dummy.pos_bub(), 1 ) ) {
        here.ter_set( p, ter_id( "t_grass" ) );
    }
    here.ter_set( dummy.pos_bub() + tripoint::above, ter_id( "t_open_air" ) );
    here.build_map_cache( dummy.posz() );
    here.build_map_cache( dummy.posz() + 1 );

    scoped_weather_override weather_clear( WEATHER_CLEAR );
    weather_clear.with_windspeed( 30 );
    restore_on_out_of_scope restore_temperature( get_weather().forced_temperature );
    get_weather().forced_temperature = units::from_fahrenheit( -10 );

    const auto hand_frostbite_timer = [&]( const bool wear_protective_clothing ) {
        clear_character( dummy );
        dummy.set_all_parts_temp_cur( BODYTEMP_VERY_COLD );
        dummy.set_all_parts_temp_conv( BODYTEMP_VERY_COLD );
        dummy.set_part_frostbite_timer( body_part_hand_l, 0 );
        if( wear_protective_clothing ) {
            dummy.wear_item( item( itype_test_protective_clothing ), false );
        }

        dummy.update_bodytemp();
        return dummy.get_part_frostbite_timer( body_part_hand_l );
    };

    // The test clothing protects only the torso.  It must not reduce the wind experienced by
    // the bare hand, which is processed later by update_bodytemp().
    const int unprotected = hand_frostbite_timer( false );
    const int torso_protected = hand_frostbite_timer( true );

    REQUIRE( unprotected > 8 );
    CHECK( torso_protected == unprotected );
}

TEST_CASE( "worn_clothing_protects_from_wetting", "[character][clothing][wetting]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    dummy.wear_item( item( itype_test_protective_clothing ), false );
    dummy.set_part_wetness( body_part_torso, 0 );
    dummy.set_part_wetness( body_part_head, 0 );

    dummy.drench( 100, { body_part_torso }, false );
    CHECK( dummy.get_part_wetness( body_part_torso ) == 0 );

    dummy.drench( 100, { body_part_head }, false );
    CHECK( dummy.get_part_wetness( body_part_head ) > 0 );
}

TEST_CASE( "worn_clothing_protects_from_heat", "[character][clothing][heat]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );

    const std::map<bodypart_id, int> unprotected = dummy.get_all_armor_type( damage_heat );
    dummy.wear_item( item( itype_test_protective_clothing ), false );
    const std::map<bodypart_id, int> protected_parts = dummy.get_all_armor_type( damage_heat );

    CHECK( protected_parts.at( body_part_torso ) > unprotected.at( body_part_torso ) );
    CHECK( protected_parts.at( body_part_head ) == unprotected.at( body_part_head ) );
}

TEST_CASE( "heat_armor_protects_only_the_covered_overheated_part", "[clothing][thermal_burn]" )
{
    clear_map();
    avatar &u = get_avatar();
    clear_character( u );
    REQUIRE( u.wear_item( item( itype_test_protective_clothing ), false ).has_value() );
    REQUIRE( u.get_armor_type( damage_heat, body_part_torso ) >= 4 );
    REQUIRE( u.get_armor_type( damage_heat, body_part_head ) == 0 );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const restore_on_out_of_scope restore_temperature( get_weather().forced_temperature );
    get_weather().forced_temperature = 19_C;
    for( int turn = 0; turn < 30; ++turn ) {
        calendar::turn += 1_turns;
        u.set_part_temp_cur( body_part_torso, BODYTEMP_SCORCHING + 0.75_C_delta );
        u.set_part_temp_cur( body_part_head, BODYTEMP_SCORCHING + 0.75_C_delta );
        u.update_bodytemp( true );
    }
    CHECK( u.get_part( body_part_head )->has_wound( wound_type_id( "thermal_blister" ) ) );
    CHECK_FALSE( u.get_part( body_part_torso )->has_wounds() );
}

TEST_CASE( "full_heat_immunity_blocks_hits_and_overheating_without_curing",
           "[clothing][thermal_burn]" )
{
    clear_map();
    avatar &u = get_avatar();
    clear_character( u );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const restore_on_out_of_scope restore_temperature( get_weather().forced_temperature );
    get_weather().forced_temperature = 19_C;
    const wound_type_id blister( "thermal_blister" );
    const bodypart_id bp = body_part_arm_l;
    u.apply_thermal_burn( bp, false );
    u.update_wounds( 1_hours );

    SECTION( "inborn fireproofing" ) {
        u.set_mutation( trait_id( "M_SKIN2" ) );
    }
    SECTION( "immunity supplied by clothing" ) {
        REQUIRE( u.wear_item( item( itype_id( "test_zentai_immune_test_fire" ) ), false ).has_value() );
    }

    REQUIRE( u.is_immune_damage( damage_heat ) );
    const int hp = u.get_hp( bp );
    const units::temperature before = u.get_part_temp_cur( bp );
    const auto dealt = u.deal_damage( nullptr, bp, damage_instance( damage_heat, 12 ) );
    CHECK( dealt.type_damage( damage_heat ) == 0 );
    CHECK( u.get_hp( bp ) == hp );
    CHECK( u.get_part_temp_cur( bp ) == before );
    for( int turn = 0; turn < 120; ++turn ) {
        calendar::turn += 1_turns;
        u.set_part_temp_cur( bp, BODYTEMP_SCORCHING + 2_C_delta );
        u.update_bodytemp( true );
    }
    CHECK( u.get_part_temp_cur( bp ) > BODYTEMP_SCORCHING );
    CHECK_FALSE( u.has_effect( efftype_id( "hot" ), bp ) );
    CHECK_FALSE( u.has_effect( efftype_id( "hot_speed" ), bp ) );
    const bodypart &part = *u.get_part( bp );
    REQUIRE( part.has_wound( blister ) );
    REQUIRE( part.get_wounds().size() == 1 );
    CHECK( part.get_wounds().front().get_healing_progress() == 1_hours );
}

TEST_CASE( "multipart_hit_stops_mitigating_on_an_invalidated_thermal_contact",
           "[character][clothing][thermal_burn]" )
{
    avatar &u = get_avatar();
    clear_character( u );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const bool recreate_contact = GENERATE( false, true );
    CAPTURE( recreate_contact );
    const efftype_id fire( "onfire" );
    const bodypart_id wing( "test_bird_wing_l" );
    enchantment replacement;
    replacement.load( json_loader::from_string( R"({
        "modified_bodyparts": [ { "lose": "hand_l" }, { "gain": "test_bird_wing_l" } ]
    })" ).get_object() );
    u.enchantment_cache->force_add( replacement, u );
    u.recalculate_bodyparts();
    REQUIRE( u.get_part_id( body_part_hand_l ) == wing );
    REQUIRE( u.wear_item( item( itype_id( "test_winglets" ) ), false ).has_value() );
    REQUIRE( u.get_armor_type( damage_heat, wing ) > 0 );
    const auto original_identity = u.get_part( wing )->identity_generation();

    // Guarantee an ignition notification on the first unit without destroying the armor.
    mat_burn_data &leather = const_cast<mat_burn_data &>( material_id( "leather" )->burn_data( 2 ) );
    const restore_on_out_of_scope restore_leather( leather );
    leather.immune = false;
    leather.volume_per_turn = 0_ml;
    leather.fuel = 10.0f;
    leather.burn = 0.0f;

    struct ignition_observer : event_subscriber {
        ignition_observer( avatar &who, const efftype_id &fire, const enchantment *replacement ) :
            who( who ), fire( fire ), replacement( replacement ) {}
        using event_subscriber::notify;
        void notify( const cata::event &event ) override {
            if( event.type() != event_type::character_gains_effect ||
                event.get<character_id>( "character" ) != who.getID() ||
                event.get<efftype_id>( "effect" ) != fire || ++ignitions != 1 ) {
                return;
            }
            who.clear_effects();
            who.enchantment_cache->clear();
            who.recalculate_bodyparts();
            if( replacement ) {
                who.enchantment_cache->force_add( *replacement, who );
                who.recalculate_bodyparts();
            }
            who.set_all_parts_temp_cur( BODYTEMP_NORM );
        }
        avatar &who;
        const efftype_id &fire;
        const enchantment *replacement;
        int ignitions = 0;
    } observer( u, fire, recreate_contact ? &replacement : nullptr );
    get_event_bus().subscribe( &observer );

    const int hp_before = u.get_part_hp_cur( body_part_arm_l );
    REQUIRE( hp_before > 20 );
    damage_instance attack( damage_heat, 10 );
    attack.damage_units.emplace_back( damage_heat, 10 );
    const auto dealt = u.deal_damage( nullptr, body_part_hand_l, attack );

    CHECK( observer.ignitions == 1 );
    CHECK( dealt.type_damage( damage_heat ) == 20 );
    CHECK( u.get_part_hp_cur( body_part_arm_l ) == hp_before - 20 );
    CHECK_FALSE( u.has_effect( fire ) );
    REQUIRE( u.has_part( wing ) == recreate_contact );
    const bodypart_id current_contact = recreate_contact ? wing : body_part_hand_l.id();
    CHECK( u.get_part( current_contact )->identity_generation() != original_identity );
    CHECK( u.get_part_temp_cur( current_contact ) == BODYTEMP_NORM );
    CHECK_FALSE( u.get_part( u.thermal_wound_part( current_contact ) )->has_wounds() );
}

TEST_CASE( "burnt_out_smoking_items_do_not_provide_wind_resistance", "[character][clothing][wind]" )
{
    for( const auto &smoking_item : {
             std::make_pair( "cig_lit", "cig_butt" ),
             std::make_pair( "cigar_lit", "cigar_butt" ),
             std::make_pair( "joint_lit", "joint_roach" )
         } ) {
        CAPTURE( smoking_item.first );
        avatar &dummy = get_avatar();
        clear_character( dummy );
        dummy.wear_item( item( itype_test_protective_clothing ), false );
        const auto expected = dummy.worn.wind_resistance( dummy );
        const auto worn = dummy.wear_item( item( itype_id( smoking_item.first ) ), false );
        REQUIRE( worn.has_value() );
        // Smoking converts the worn item in place when it burns out.
        ( **worn ).convert( itype_id( smoking_item.second ) );
        REQUIRE( ( **worn ).get_covered_body_parts().none() );
        std::map<bodypart_id, int> actual;
        const std::string debug_message = capture_debugmsg_during( [&] {
            actual = dummy.worn.wind_resistance( dummy );
        } );
        CHECK( debug_message.empty() );
        CHECK( actual == expected );
    }
}
