#include <algorithm>
#include <initializer_list>
#include <memory>
#include <optional>
#include <sstream>
#include <string>
#include <tuple>
#include <utility>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "character_martial_arts.h"
#include "coordinates.h"
#include "creature.h"
#include "effect.h"
#include "effect_source.h"
// IWYU pragma: no_include <flexbuffer_json.h>
#include "flexbuffer_json.h"
#include "item.h"
#include "json_loader.h"
#include "json.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "martialarts.h"
#include "monster.h"
#include "mtype.h"
#include "pimpl.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"

static const efftype_id effect_downed( "downed" );
static const efftype_id effect_harnessed( "harnessed" );
static const efftype_id effect_martial_grapple( "martial_grapple" );
static const efftype_id effect_ridden( "ridden" );
static const efftype_id effect_tied( "tied" );

static const itype_id itype_club_wooden( "club_wooden" );

static const matec_id tec_aikido_projection( "tec_aikido_projection" );
static const matec_id tec_grapple_drag( "tec_grapple_drag" );
static const matec_id tec_grapple_hold( "tec_grapple_hold" );
static const matec_id tec_judo_hip_throw( "tec_judo_hip_throw" );

static const matype_id style_aikido( "style_aikido" );

static constexpr tripoint_bub_ms dude_pos( HALF_MAPSIZE_X, HALF_MAPSIZE_Y, 0 );

static avatar &prepare_grappler( const std::string &style = "style_judo" )
{
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    dude.setpos( get_map(), dude_pos );
    dude.set_all_skills( 5 );
    dude.remove_weapon();
    const matype_id martial_art( style );
    dude.martial_arts_data->add_martialart( martial_art );
    dude.martial_arts_data->set_style( martial_art );
    dude.set_moves( 1000 );
    return dude;
}

TEST_CASE( "active_grappling_is_bound_to_appropriate_styles",
           "[martial_arts][active_technique][grappling]" )
{
    const std::vector<std::pair<std::string, std::string>> styles = {
        { "style_judo", "tec_judo_hip_throw" },
        { "style_aikido", "tec_aikido_projection" },
        { "style_pankration", "tec_pankration_slam" },
        { "style_tai_chi", "tec_taichi_unbalance" },
        { "style_krav_maga", "tec_krav_grapple_takedown" },
        { "style_muay_thai", "" }
    };
    for( const auto &entry : styles ) {
        CAPTURE( entry.first );
        avatar &dude = prepare_grappler( entry.first );
        const std::vector<matec_id> available = dude.active_techniques();
        for( const matec_id &technique : {
                 tec_grapple_hold, tec_grapple_drag
             } ) {
            CHECK( std::find( available.begin(), available.end(), technique ) != available.end() );
            CHECK( technique->manual_activation );
        }
        if( !entry.second.empty() ) {
            CHECK( std::find( available.begin(), available.end(),
                              matec_id( entry.second ) ) != available.end() );
        }
    }
    for( const char *style : {
             "style_boxing", "style_none"
         } ) {
        avatar &dude = prepare_grappler( style );
        for( const matec_id &technique : dude.active_techniques() ) {
            CHECK( technique->grapple_action.empty() );
        }
    }
}

TEST_CASE( "active_grappling_hold_controls_without_punch_damage",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    const int health = target.get_hp();
    const int stamina = dude.get_stamina();
    REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
    CHECK( target.get_hp() == health );
    CHECK( dude.get_stamina() <= stamina - tec_grapple_hold->grapple_stamina );
    CHECK( dude.get_moves() < 1000 );
    REQUIRE( target.has_effect( effect_martial_grapple ) );
    CHECK( target.get_effect( effect_martial_grapple ).get_source().get_character_id() ==
           dude.getID() );
    CHECK_FALSE( target.move_effects( false ) );
    CHECK( dude.has_effect( tec_grapple_hold->grapple_cooldown_effect() ) );
    const int spent_stamina = dude.get_stamina();
    const int spent_moves = dude.get_moves();
    CHECK_FALSE( dude.use_active_technique( target, tec_grapple_hold ) );
    CHECK( dude.get_stamina() == spent_stamina );
    CHECK( dude.get_moves() == spent_moves );
    const std::vector<matec_id> available = dude.active_techniques();
    CHECK( std::find( available.begin(), available.end(), tec_grapple_hold ) != available.end() );
    CHECK_FALSE( tec_grapple_hold->activation_allowed( dude, "start" ) );
    for( int attempt = 0; attempt < 30; ++attempt ) {
        const matec_id automatic = std::get<0>( dude.pick_technique( target, dude.used_weapon(), false,
                                                false, false, {} ) );
        CHECK( automatic->grapple_action.empty() );
    }
}

TEST_CASE( "active_grappling_drag_and_throw_use_owned_grips",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    const tripoint_abs_ms origin = dude.pos_abs();
    CHECK_FALSE( dude.use_active_technique( target, tec_grapple_drag ) );
    CHECK_FALSE( dude.use_active_technique( target, tec_judo_hip_throw ) );
    CHECK( dude.get_moves() == 1000 );
    REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
    const time_duration duration = target.get_effect( effect_martial_grapple ).get_duration();
    const int stamina = dude.get_stamina();
    REQUIRE( dude.use_active_technique( target, tec_grapple_drag ) );
    CHECK( dude.pos_abs() == origin + tripoint::west );
    CHECK( target.pos_abs() == origin );
    CHECK( target.get_effect( effect_martial_grapple ).get_duration() == duration );
    CHECK( dude.get_stamina() <= stamina - tec_grapple_drag->grapple_stamina );
    CHECK_FALSE( dude.use_active_technique( target, tec_grapple_drag ) );
    const int health = target.get_hp();
    REQUIRE( dude.use_active_technique( target, tec_judo_hip_throw ) );
    CHECK( dude.pos_abs() == origin + tripoint::west );
    CHECK( target.pos_abs() == origin + tripoint::west * 2 );
    CHECK_FALSE( target.has_effect( effect_martial_grapple ) );
    CHECK( target.has_effect( effect_downed ) );
    CHECK( target.get_hp() < health );
    CHECK( dude.has_effect( tec_judo_hip_throw->grapple_cooldown_effect() ) );
}


TEST_CASE( "active_grappling_drag_updates_underwater_state",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    map &here = get_map();
    const bool stays_in_water = GENERATE( false, true );
    here.ter_set( dude_pos, ter_id( "t_water_dp" ) );
    if( stays_in_water ) {
        here.ter_set( dude_pos + tripoint::west, ter_id( "t_water_dp" ) );
    }
    dude.set_underwater( true );
    const tripoint_abs_ms origin = dude.pos_abs();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    REQUIRE( dude.use_active_technique( target, matec_id( "tec_grapple_hold" ) ) );
    if( stays_in_water ) {
        CHECK_FALSE( dude.use_active_technique( target, matec_id( "tec_grapple_drag" ) ) );
        CHECK( dude.pos_abs() == origin );
    } else {
        REQUIRE( dude.use_active_technique( target, matec_id( "tec_grapple_drag" ) ) );
        CHECK( dude.pos_abs() == origin + tripoint::west );
    }
    CHECK( dude.is_underwater() == stays_in_water );
}

TEST_CASE( "active_grappling_requires_physical_and_unrestricted_hands",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    const bool held = GENERATE( false, true );
    if( held ) {
        REQUIRE( dude.use_active_technique( target, matec_id( "tec_grapple_hold" ) ) );
    }
    SECTION( "incorporeal" ) {
        dude.add_effect( efftype_id( "incorporeal" ), 1_minutes );
    }
    SECTION( "restricted_hands" ) {
        REQUIRE( dude.wear_item( item( itype_id( "bindle" ) ), false, false ) );
    }
    const int moves = dude.get_moves();
    const int stamina = dude.get_stamina();
    const int health = target.get_hp();
    CHECK_FALSE( dude.use_active_technique( target, matec_id( "tec_grapple_hold" ) ) );
    CHECK_FALSE( dude.use_active_technique( target, matec_id( "tec_grapple_drag" ) ) );
    CHECK_FALSE( dude.use_active_technique( target, matec_id( "tec_judo_hip_throw" ) ) );
    CHECK( dude.get_moves() == moves );
    CHECK( dude.get_stamina() == stamina );
    CHECK( dude.pos_bub() == dude_pos );
    CHECK( target.pos_bub() == dude_pos + tripoint::east );
    CHECK( target.get_hp() == health );
}

TEST_CASE( "active_grappling_mass_and_size_change_cost_and_control",
           "[martial_arts][active_technique][grappling]" )
{
    int light_stamina = 0;
    int light_moves = 0;
    time_duration light_duration = 0_turns;
    for( const int weight : {
             30, 90
         } ) {
        avatar &dude = prepare_grappler();
        monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
        mtype target_type = *target.type;
        restore_on_out_of_scope restore_type( target.type );
        target_type.weight = units::from_kilogram( weight );
        target.type = &target_type;
        const int stamina = dude.get_stamina();
        REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
        const int cost = stamina - dude.get_stamina();
        const int moves = 1000 - dude.get_moves();
        const time_duration duration = target.get_effect( effect_martial_grapple ).get_duration();
        if( weight == 30 ) {
            light_stamina = cost;
            light_moves = moves;
            light_duration = duration;
        } else {
            CHECK( cost > light_stamina );
            CHECK( moves > light_moves );
            CHECK( duration < light_duration );
        }
    }
    for( const bool oversized : {
             false, true
         } ) {
        avatar &dude = prepare_grappler();
        monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
        mtype target_type = *target.type;
        restore_on_out_of_scope restore_type( target.type );
        target_type.weight = oversized ? 30_kilogram : 1000_kilogram;
        target_type.size = oversized ? creature_size::huge : creature_size::medium;
        target.type = &target_type;
        const int stamina = dude.get_stamina();
        CHECK_FALSE( dude.use_active_technique( target, tec_grapple_hold ) );
        CHECK( dude.get_stamina() == stamina );
        CHECK( dude.get_moves() == 1000 );
    }
}

TEST_CASE( "active_grappling_size_limits_control_independently_of_weight",
           "[martial_arts][active_technique][grappling]" )
{
    time_duration medium_duration = 0_turns;
    int medium_moves = 0;
    for( const creature_size size : {
             creature_size::medium, creature_size::large
         } ) {
        avatar &dude = prepare_grappler();
        monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
        mtype target_type = *target.type;
        restore_on_out_of_scope restore_type( target.type );
        target_type.weight = 30_kilogram;
        target_type.size = size;
        target.type = &target_type;
        REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
        const time_duration duration = target.get_effect( effect_martial_grapple ).get_duration();
        if( size == creature_size::medium ) {
            medium_duration = duration;
            medium_moves = dude.get_moves();
        } else {
            CHECK( duration < medium_duration );
            CHECK( dude.get_moves() < medium_moves );
        }
    }
}

TEST_CASE( "active_grappling_heavy_targets_reduce_throw_effects",
           "[martial_arts][active_technique][grappling]" )
{
    int light_damage = 0;
    time_duration light_duration = 0_turns;
    for( const int weight : {
             30, 90
         } ) {
        avatar &dude = prepare_grappler();
        monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
        mtype target_type = *target.type;
        restore_on_out_of_scope restore_type( target.type );
        target_type.weight = units::from_kilogram( weight );
        target.type = &target_type;
        target.set_hp( 1000 );
        REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
        REQUIRE( dude.use_active_technique( target, tec_judo_hip_throw ) );
        const int damage = 1000 - target.get_hp();
        const time_duration duration = target.get_effect( effect_downed ).get_duration();
        if( weight == 30 ) {
            light_damage = damage;
            light_duration = duration;
        } else {
            CHECK( damage < light_damage );
            CHECK( duration < light_duration );
        }
    }
}

TEST_CASE( "active_grappling_defensive_projection_and_wrestling_slam_differ",
           "[martial_arts][active_technique][grappling]" )
{
    int projection_damage = 0;
    int projection_stamina = 0;
    for( const bool slam : {
             false, true
         } ) {
        avatar &dude = prepare_grappler( slam ? "style_pankration" : "style_aikido" );
        monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
        target.set_hp( 1000 );
        REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
        const int stamina = dude.get_stamina();
        const matec_id technique( slam ? "tec_pankration_slam" : "tec_aikido_projection" );
        REQUIRE( dude.use_active_technique( target, technique ) );
        if( !slam ) {
            projection_damage = 1000 - target.get_hp();
            projection_stamina = stamina - dude.get_stamina();
        } else {
            CHECK( 1000 - target.get_hp() > projection_damage );
            CHECK( stamina - dude.get_stamina() > projection_stamina );
        }
    }
}

TEST_CASE( "active_grappling_rejects_ungraspable_and_attached_targets",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    mtype target_type = *target.type;
    restore_on_out_of_scope restore_type( target.type );
    target.type = &target_type;
    SECTION( "amorphous" ) {
        target_type.bodytype = "blob";
    }
    SECTION( "flying" ) {
        target_type.set_flag( mon_flag_FLIES );
    }
    SECTION( "immobile" ) {
        target_type.set_flag( mon_flag_IMMOBILE );
    }
    SECTION( "slippery" ) {
        target_type.set_flag( mon_flag_PLASTIC );
    }
    SECTION( "ridden" ) {
        target.add_effect( effect_ridden, 1_minutes );
    }
    SECTION( "harnessed" ) {
        target.add_effect( effect_harnessed, 1_minutes );
    }
    SECTION( "tied" ) {
        target.add_effect( effect_tied, 1_minutes );
    }
    const int stamina = dude.get_stamina();
    CHECK_FALSE( dude.use_active_technique( target, tec_grapple_hold ) );
    CHECK( dude.get_stamina() == stamina );
    CHECK( dude.get_moves() == 1000 );
}

TEST_CASE( "active_grappling_rejects_blocked_retreats_without_charging",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
    SECTION( "wall" ) {
        get_map().ter_set( dude_pos + tripoint::west, ter_id( "t_wall" ) );
    }
    SECTION( "occupied_tile" ) {
        spawn_test_monster( "mon_zombie", dude_pos + tripoint::west );
    }
    SECTION( "unsupported_tile" ) {
        get_map().ter_set( dude_pos + tripoint::west, ter_id( "t_open_air" ) );
        get_map().ter_set( dude_pos + tripoint::west + tripoint::below, ter_id( "t_open_air" ) );
    }
    const int stamina = dude.get_stamina();
    const int moves = dude.get_moves();
    CHECK_FALSE( dude.use_active_technique( target, tec_grapple_drag ) );
    CHECK_FALSE( dude.use_active_technique( target, tec_judo_hip_throw ) );
    CHECK( dude.get_stamina() == stamina );
    CHECK( dude.get_moves() == moves );
    CHECK( dude.pos_bub() == dude_pos );
    CHECK( target.pos_bub() == dude_pos + tripoint::east );
}

TEST_CASE( "active_grappling_releases_when_holder_cannot_maintain_control",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
    SECTION( "separation" ) {
        dude.setpos( get_map(), dude_pos + tripoint::west );
    }
    SECTION( "wielding_a_weapon" ) {
        dude.set_wielded_item( item( itype_club_wooden ) );
    }
    SECTION( "exhaustion" ) {
        dude.set_stamina( 0 );
    }
    SECTION( "knockdown" ) {
        dude.add_effect( effect_downed, 1_minutes );
    }
    SECTION( "broken_arm" ) {
        dude.set_part_hp_cur( bodypart_id( "arm_l" ), 0 );
    }
    SECTION( "incorporeal" ) {
        dude.add_effect( efftype_id( "incorporeal" ), 1_minutes );
    }
    SECTION( "restricted_hands" ) {
        REQUIRE( dude.wear_item( item( itype_id( "bindle" ) ), false, false ) );
    }
    target.move_effects( false );
    CHECK_FALSE( target.has_effect( effect_martial_grapple ) );
}

TEST_CASE( "active_grappling_rechecks_stamina_and_grip_ownership",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    SECTION( "actual_weight_cost_exceeds_remaining_stamina" ) {
        dude.set_stamina( tec_grapple_hold->grapple_stamina );
        CHECK( tec_grapple_hold->activation_allowed( dude, "start" ) );
        CHECK_FALSE( dude.use_active_technique( target, tec_grapple_hold ) );
        CHECK( dude.get_stamina() == tec_grapple_hold->grapple_stamina );
    }
    SECTION( "another_creatures_grip_cannot_be_stolen_or_used" ) {
        target.add_effect( effect_source::empty(), effect_martial_grapple, 5_turns );
        const int stamina = dude.get_stamina();
        CHECK_FALSE( dude.use_active_technique( target, tec_grapple_hold ) );
        CHECK_FALSE( dude.use_active_technique( target, tec_grapple_drag ) );
        CHECK_FALSE( dude.use_active_technique( target, tec_judo_hip_throw ) );
        CHECK( dude.get_stamina() == stamina );
    }
    CHECK( dude.get_moves() == 1000 );
    CHECK_FALSE( dude.has_effect( tec_grapple_hold->grapple_cooldown_effect() ) );
}

TEST_CASE( "active_grappling_only_holds_one_target_and_cooldowns_expire",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &first = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    monster &second = spawn_test_monster( "mon_zombie", dude_pos + tripoint::north );
    REQUIRE( dude.use_active_technique( first, tec_grapple_hold ) );
    CHECK_FALSE( dude.use_active_technique( second, tec_grapple_hold ) );
    dude.remove_effect( tec_grapple_hold->grapple_cooldown_effect() );
    REQUIRE( dude.use_active_technique( second, tec_grapple_hold ) );
    CHECK_FALSE( first.has_effect( effect_martial_grapple ) );
    REQUIRE( second.has_effect( effect_martial_grapple ) );
    restore_on_out_of_scope restore_time( calendar::turn );
    for( int turn = 0; turn < 8; ++turn ) {
        calendar::turn += 1_turns;
        dude.process_effects();
        second.process_effects();
    }
    CHECK_FALSE( second.has_effect( effect_martial_grapple ) );
    CHECK_FALSE( dude.has_effect( tec_grapple_hold->grapple_cooldown_effect() ) );
    REQUIRE( dude.use_active_technique( first, tec_grapple_hold ) );
}

TEST_CASE( "active_grappling_effects_preserve_sources_and_cooldowns_in_save_data",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
    for( const effect &original : {
             target.get_effect( effect_martial_grapple ),
             dude.get_effect( tec_grapple_hold->grapple_cooldown_effect() )
         } ) {
        std::ostringstream stream;
        JsonOut output( stream );
        original.serialize( output );
        effect restored;
        restored.deserialize( json_loader::from_string( stream.str() ).get_object() );
        CHECK( restored.get_id() == original.get_id() );
        CHECK( restored.get_duration() == original.get_duration() );
        CHECK( restored.get_source().get_character_id() == original.get_source().get_character_id() );
    }
}

TEST_CASE( "active_grappling_throw_cooldown_cannot_be_bypassed_by_style_switch",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler();
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
    REQUIRE( dude.use_active_technique( target, tec_judo_hip_throw ) );
    dude.martial_arts_data->add_martialart( style_aikido );
    dude.martial_arts_data->set_style( style_aikido );
    CHECK( tec_judo_hip_throw->grapple_cooldown_effect() ==
           tec_aikido_projection->grapple_cooldown_effect() );
    CHECK_FALSE( tec_aikido_projection->activation_allowed( dude, "start" ) );
    const int stamina = dude.get_stamina();
    const int moves = dude.get_moves();
    CHECK_FALSE( dude.use_active_technique( target, tec_aikido_projection ) );
    CHECK( dude.get_stamina() == stamina );
    CHECK( dude.get_moves() == moves );
}
