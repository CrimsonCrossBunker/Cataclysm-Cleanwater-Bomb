#include <tuple>
#include <initializer_list>
#include <cstddef>
#include "character_id.h"
#include <algorithm>
#include <item_location.h>
#include <ret_val.h>
#include <memory>
#include <optional>
#include <sstream>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_martial_arts.h"
#include "coordinates.h"
#include "creature.h"
#include "damage.h"
#include "effect.h"
#include "effect_source.h"
#include "enums.h"
#include "faction.h"
// IWYU pragma: no_include <flexbuffer_json.h>
#include "flexbuffer_json.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "magic_enchantment.h"
#include "lua_platform_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "martialarts.h"
#include "melee.h"
#include "monster.h"
#include "mtype.h"
#include "npc.h"
#include "pimpl.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"

static const bodypart_str_id body_part_debug_tail( "debug_tail" );

static const efftype_id effect_downed( "downed" );
static const efftype_id effect_grabbed( "grabbed" );
static const efftype_id effect_grabbing( "grabbing" );
static const efftype_id effect_martial_grapple( "martial_grapple" );
static const efftype_id effect_stunned( "stunned" );

static const enchantment_id enchantment_ENCH_TEST_BIRD_PARTS( "ENCH_TEST_BIRD_PARTS" );

static const itype_id itype_club_wooden( "club_wooden" );
static const itype_id itype_spear_steel( "spear_steel" );
static const itype_id itype_stick( "stick" );
static const itype_id itype_sword_crude( "sword_crude" );
static const itype_id itype_sword_metal_fencing( "sword_metal_fencing" );
static const itype_id itype_sword_wood( "sword_wood" );
static const itype_id itype_test_eoc_armor_suit( "test_eoc_armor_suit" );
static const itype_id itype_test_weapon1( "test_weapon1" );
static const itype_id itype_test_weapon2( "test_weapon2" );

static const json_character_flag json_flag_PSEUDOPOD_GRASP( "PSEUDOPOD_GRASP" );

static const mabuff_id ma_buff_buff_niten_ondodge( "buff_niten_ondodge" );

static const matec_id PENETRATE( "PENETRATE" );
static const matec_id PRECISE( "PRECISE" );
static const matec_id RAPID( "RAPID" );
static const matec_id WBLOCK_1( "WBLOCK_1" );
static const matec_id WIDE( "WIDE" );
static const matec_id niten_timing_attack( "niten_timing_attack" );
static const matec_id tec_bojutsu_frontstrike( "tec_bojutsu_frontstrike" );
static const matec_id tec_boxing_cross( "tec_boxing_cross" );
static const matec_id tec_brawl_grapple_throw( "tec_brawl_grapple_throw" );
static const matec_id tec_brawl_power( "tec_brawl_power" );
static const matec_id tec_break( "tec_break" );
static const matec_id tec_feint( "tec_feint" );
static const matec_id tec_grapple_drag( "tec_grapple_drag" );
static const matec_id tec_grapple_hold( "tec_grapple_hold" );
static const matec_id tec_judo_hip_throw( "tec_judo_hip_throw" );
static const matec_id tec_sojutsu_jab( "tec_sojutsu_jab" );
static const matec_id test_active_accurate_strike( "test_active_accurate_strike" );
static const matec_id test_active_cooldown_strike( "test_active_cooldown_strike" );
static const matec_id test_active_strike( "test_active_strike" );
static const matec_id test_manual_cooldown_strike( "test_manual_cooldown_strike" );
static const matec_id test_tech_condition_knockback( "test_tech_condition_knockback" );
static const matec_id test_tech_condition_stun( "test_tech_condition_stun" );
static const matec_id test_tech_condition_sweep( "test_tech_condition_sweep" );
static const matec_id test_technique( "test_technique" );
static const matec_id test_vector_tech_1( "test_vector_tech_1" );
static const matec_id test_vector_tech_2( "test_vector_tech_2" );

static const matype_id style_boxing( "style_boxing" );
static const matype_id style_brawling( "style_brawling" );
static const matype_id style_none( "style_none" );
static const matype_id test_style_cooldown( "test_style_cooldown" );
static const matype_id test_style_ma1( "test_style_ma1" );

static const mtype_id mon_zombie( "mon_zombie" );

static const skill_id skill_melee( "melee" );

static const species_id species_SLIME( "SLIME" );
static const species_id species_ZOMBIE( "ZOMBIE" );

static const trait_id trait_ARM_TENTACLES( "ARM_TENTACLES" );
static const trait_id trait_DEBUG_TAIL( "DEBUG_TAIL" );

static constexpr tripoint_bub_ms dude_pos( HALF_MAPSIZE_X, HALF_MAPSIZE_Y, 0 );

static avatar &prepare_grappler( const std::string &style = "style_judo" )
{
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    static bool platform_world_ready = false;
    if( !platform_world_ready ) {
        cata::lua_platform::on_world_ready( true );
        platform_world_ready = true;
    }
#endif
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

TEST_CASE( "brawling_grapple_throw_uses_lua_and_preserves_existing_style",
           "[martial_arts][active_technique][grappling]" )
{
    avatar &dude = prepare_grappler( "style_brawling" );

    CHECK( style_brawling->allow_all_weapons );
    CHECK( style_brawling->techniques.count( tec_brawl_power ) == 1 );
    CHECK_FALSE( style_brawling->static_buffs.empty() );
    CHECK_FALSE( style_brawling->onpause_buffs.empty() );
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    target.friendly = -1;

    REQUIRE( tec_brawl_grapple_throw.is_valid() );
    CHECK( tec_brawl_grapple_throw->lua_platform_mod == "ccb" );
    const int moves = dude.get_moves();
    const int stamina = dude.get_stamina();
    CHECK_FALSE( tec_brawl_grapple_throw->activation_allowed( dude, "target", &target ) );
    CHECK_FALSE( dude.use_active_technique( target, tec_brawl_grapple_throw ) );
    CHECK( dude.get_moves() == moves );
    CHECK( dude.get_stamina() == stamina );
    REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
    CHECK( tec_brawl_grapple_throw->activation_allowed( dude, "target", &target ) );
    REQUIRE( dude.use_active_technique( target, tec_brawl_grapple_throw ) );
    CHECK( target.pos_bub() == dude_pos + tripoint::west );
    CHECK( target.has_effect( effect_downed ) );
    CHECK_FALSE( target.has_effect( effect_martial_grapple ) );
}

TEST_CASE( "active_grappling_controls_and_releases_npc_targets",
           "[martial_arts][active_technique][grappling][npc]" )
{
    avatar &dude = prepare_grappler();
    npc &target = spawn_npc( ( dude_pos + tripoint::east ).xy(), "test_talker" );
    clear_character( target, true );
    faction *const group = target.get_faction();
    REQUIRE( group );
    restore_on_out_of_scope restore_likes( group->likes_u );
    restore_on_out_of_scope restore_respect( group->respects_u );
    restore_on_out_of_scope restore_trust( group->trusts_u );
    group->likes_u = 0;
    target.set_attitude( NPCATT_NULL );
    target.setpos( get_map(), dude_pos + tripoint::east );
    const tripoint_abs_ms origin = dude.pos_abs();

    REQUIRE_FALSE( target.is_enemy() );
    REQUIRE( dude.use_active_technique( target, tec_grapple_hold ) );
    CHECK( target.hit_by_player );
    CHECK(( target.get_attitude() == NPCATT_KILL || target.get_attitude() == NPCATT_FLEE_TEMP ) );
    CHECK_FALSE( target.move_effects( false ) );
    CHECK( target.move_effects( true ) );
    SECTION( "drag and throw" ) {
        REQUIRE( dude.use_active_technique( target, tec_grapple_drag ) );
        CHECK( target.pos_abs() == origin );
        CHECK( dude.pos_abs() == origin + tripoint::west );
        REQUIRE( dude.use_active_technique( target, tec_judo_hip_throw ) );
        CHECK( target.pos_abs() == origin + tripoint_rel_ms(-2, 0, 0 ) );
        CHECK( target.has_effect( effect_downed ) );
        CHECK_FALSE( target.has_effect( effect_martial_grapple ) );
    }
    SECTION( "invalid holder" ) {
        dude.set_wielded_item( item( itype_stick ) );
        CHECK( target.move_effects( false ) );
        CHECK_FALSE( target.has_effect( effect_martial_grapple ) );
    }
    SECTION( "lethal finish still records the attack" ) {
        target.set_attitude( NPCATT_NULL );
        group->likes_u = 0;
        target.hit_by_player = false;
        target.clear_worn();
        target.set_part_hp_cur( body_part_torso, 1 );
        REQUIRE( dude.use_active_technique( target, tec_judo_hip_throw ) );
        CHECK( target.is_dead_state() );
        CHECK( target.hit_by_player );
    }
    SECTION( "one grip across creature categories" ) {
        monster &other = spawn_test_monster( "mon_zombie", dude_pos + tripoint::north );
        dude.remove_effect( tec_grapple_hold->grapple_cooldown_effect() );
        REQUIRE( dude.use_active_technique( other, tec_grapple_hold ) );
        CHECK_FALSE( target.has_effect( effect_martial_grapple ) );
        CHECK( other.has_effect( effect_martial_grapple ) );
    }
}

TEST_CASE( "critical_only_techniques_are_automatic_not_manually_forced",
           "[martial_arts][active_technique]" )
{
    avatar &dude = prepare_grappler();
    dude.martial_arts_data->reset_style();
    dude.set_wielded_item( item( itype_sword_metal_fencing ) );

    monster &target = spawn_test_monster( "mon_feral_human_pipe", dude_pos + tripoint::east );
    const int moves = dude.get_moves();
    const int stamina = dude.get_stamina();
    CHECK_FALSE( PRECISE->can_activate() );
    CHECK_FALSE( dude.evaluate_technique( PRECISE, target, dude.used_weapon(), false, false,
                                          false, true ) );
    CHECK_FALSE( dude.evaluate_technique( PRECISE, target, dude.used_weapon(), false, false,
                                          false, false ) );
    CHECK( dude.evaluate_technique( PRECISE, target, dude.used_weapon(), true, false, false, false ) );
    CHECK_FALSE( dude.use_active_technique( target, PRECISE ) );
    CHECK( dude.get_moves() == moves );
    CHECK( dude.get_stamina() == stamina );
}

TEST_CASE( "active_techniques_include_current_style_and_weapon_attacks",
           "[martial_arts][active_technique]" )
{
    standard_npc dude( "TestCharacter", dude_pos, {}, 0, 8, 8, 8, 8 );
    clear_character( dude, true );
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    dude.martial_arts_data->add_martialart( test_style_ma1 );
    dude.martial_arts_data->set_style( test_style_ma1 );

    const std::vector<matec_id> available = dude.active_techniques();
    CHECK( std::find( available.begin(), available.end(), test_active_strike ) != available.end() );
    CHECK( std::find( available.begin(), available.end(), test_technique ) == available.end() );

    dude.martial_arts_data->reset_style();
    const std::vector<matec_id> without_style = dude.active_techniques();
    CHECK( std::find( without_style.begin(), without_style.end(), test_active_strike ) ==
           without_style.end() );

    dude.set_wielded_item( item( itype_sword_metal_fencing ) );
    const std::vector<matec_id> below_requirement = dude.active_techniques();
    CHECK( std::find( below_requirement.begin(), below_requirement.end(), RAPID ) ==
           below_requirement.end() );
    dude.set_skill_level( skill_melee, 2 );
    const std::vector<matec_id> weapon_techniques = dude.active_techniques();
    CHECK( std::find( weapon_techniques.begin(), weapon_techniques.end(), RAPID ) !=
           weapon_techniques.end() );
    dude.set_skill_level( skill_melee, 3 );
    const std::vector<matec_id> critical_techniques = dude.active_techniques();
    const matec_id precise( PRECISE );
    REQUIRE_FALSE( precise->manual_activation );
    REQUIRE( precise->crit_tec );
    CHECK_FALSE( precise->can_activate() );
    CHECK( std::find( critical_techniques.begin(), critical_techniques.end(), precise ) ==
           critical_techniques.end() );
    const std::vector<matec_id> automatic_techniques =
        dude.martial_arts_data->get_all_techniques( dude.used_weapon(), dude );
    CHECK( std::find( automatic_techniques.begin(), automatic_techniques.end(), precise ) !=
           automatic_techniques.end() );

    dude.remove_weapon();
    const matype_id boxing( style_boxing );
    const matec_id cross( tec_boxing_cross );
    dude.martial_arts_data->add_martialart( boxing );
    dude.martial_arts_data->set_style( boxing );
    REQUIRE_FALSE( cross->manual_activation );
    const std::vector<matec_id> boxing_techniques = dude.active_techniques();
    CHECK( std::find( boxing_techniques.begin(), boxing_techniques.end(), cross ) !=
           boxing_techniques.end() );
    dude.martial_arts_data->reset_style();
    const std::vector<matec_id> reset_techniques = dude.active_techniques();
    CHECK( std::find( reset_techniques.begin(), reset_techniques.end(), cross ) ==
           reset_techniques.end() );
}

TEST_CASE( "active_techniques_exclude_counters_and_passive_abilities",
           "[martial_arts][active_technique]" )
{
    clear_map();
    standard_npc dude( "TestCharacter", dude_pos, {}, 0, 8, 8, 8, 8 );
    clear_character( dude, true );
    dude.set_all_skills( 10 );
    item weapon( itype_sword_metal_fencing );
    const std::vector<matec_id> excluded = {
        PRECISE, PENETRATE,
        tec_bojutsu_frontstrike, WBLOCK_1,
        tec_feint, tec_break
    };
    for( const matec_id &id : excluded ) {
        weapon.add_technique( id );
    }
    dude.set_wielded_item( weapon );
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    const std::vector<matec_id> available = dude.active_techniques();
    dude.set_moves( 1000 );
    const int stamina_before = dude.get_stamina();
    for( const matec_id &id : excluded ) {
        CAPTURE( id );
        CHECK_FALSE( id->can_activate() );
        CHECK( std::find( available.begin(), available.end(), id ) == available.end() );
        CHECK_FALSE( dude.use_active_technique( target, id ) );
    }
    CHECK( dude.get_moves() == 1000 );
    CHECK( dude.get_stamina() == stamina_before );
}

TEST_CASE( "active_techniques_preserve_target_conditions_and_attack_costs",
           "[martial_arts][active_technique]" )
{
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    dude.setpos( get_map(), dude_pos );
    dude.set_all_skills( 5 );
    item weapon( itype_sword_wood );
    weapon.add_technique( test_tech_condition_stun );
    dude.set_wielded_item( weapon );
    monster &target = spawn_test_monster( "mon_feral_human_pipe", dude_pos + tripoint::east );
    dude.set_moves( 1000 );
    const int stamina_before = dude.get_stamina();
    target.add_effect( effect_stunned, 1_minutes );
    CHECK_FALSE( dude.use_active_technique( target, test_tech_condition_stun ) );
    CHECK( dude.get_moves() == 1000 );
    CHECK( dude.get_stamina() == stamina_before );

    target.remove_effect( effect_stunned );
    REQUIRE( dude.evaluate_technique( test_tech_condition_stun, target, dude.used_weapon(), false,
                                      false,
                                      false, true ) );
    melee::clear_stats();
    REQUIRE( dude.use_active_technique( target, test_tech_condition_stun ) );
    CHECK( melee::get_stats().attack_count == 1 );
    CHECK( dude.get_moves() < 1000 );
    CHECK( dude.get_stamina() < stamina_before );
}

TEST_CASE( "active_techniques_preserve_buffs_and_area_requirements",
           "[martial_arts][active_technique]" )
{
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    dude.setpos( get_map(), dude_pos );
    dude.set_all_skills( 5 );
    item weapon( itype_sword_metal_fencing );
    const matec_id timing( niten_timing_attack );
    const matec_id wide( WIDE );
    weapon.add_technique( timing );
    weapon.add_technique( wide );
    dude.set_wielded_item( weapon );
    const std::vector<matec_id> before_buff = dude.active_techniques();
    CHECK( std::find( before_buff.begin(), before_buff.end(), timing ) == before_buff.end() );
    ma_buff_buff_niten_ondodge->apply_buff( dude );
    const std::vector<matec_id> after_buff = dude.active_techniques();
    CHECK( std::find( after_buff.begin(), after_buff.end(), timing ) != after_buff.end() );

    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    dude.set_moves( 1000 );
    CHECK_FALSE( dude.evaluate_technique( wide, target, dude.used_weapon(), true, false, false ) );
    CHECK_FALSE( dude.use_active_technique( target, wide ) );
    CHECK( dude.get_moves() == 1000 );
    spawn_test_monster( "mon_zombie", dude_pos + tripoint_rel_ms( 1, 1, 0 ) );
    REQUIRE( dude.evaluate_technique( wide, target, dude.used_weapon(), true, false, false ) );
    CHECK_FALSE( dude.use_active_technique( target, wide ) );
    CHECK( dude.get_moves() == 1000 );
}

TEST_CASE( "active_reach_techniques_validate_range_and_obstructions",
           "[martial_arts][active_technique][reach]" )
{
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    map &here = get_map();
    dude.setpos( here, dude_pos );
    dude.set_all_skills( 5 );
    item spear( itype_spear_steel );
    const matec_id jab( tec_sojutsu_jab );
    spear.add_technique( jab );
    dude.set_wielded_item( spear );
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint_rel_ms( 2, 0, 0 ) );
    dude.set_moves( 1000 );
    REQUIRE( dude.active_technique_range( jab ) == 2 );
    SECTION( "solid_obstacle" ) {
        here.ter_set( dude_pos + tripoint::east, ter_id( "t_wall" ) );
        CHECK_FALSE( dude.use_active_technique( target, jab ) );
        CHECK( dude.get_moves() == 1000 );
    }
    SECTION( "intervening_creature" ) {
        spawn_test_monster( "mon_dog", dude_pos + tripoint::east );
        CHECK_FALSE( dude.use_active_technique( target, jab ) );
        CHECK( dude.get_moves() == 1000 );
    }
    SECTION( "out_of_range" ) {
        target.setpos( here, dude_pos + tripoint_rel_ms( 3, 0, 0 ) );
        CHECK_FALSE( dude.use_active_technique( target, jab ) );
        CHECK( dude.get_moves() == 1000 );
    }
    SECTION( "clear_path" ) {
        melee::clear_stats();
        REQUIRE( dude.use_active_technique( target, jab ) );
        CHECK( melee::get_stats().attack_count == 1 );
        CHECK( dude.get_moves() < 1000 );
    }
    CHECK_FALSE( dude.reach_attacking );
}

TEST_CASE( "active_technique_definitions_allow_conditional_reach_but_not_critical_only_attacks",
           "[martial_arts][active_technique][json]" )
{
    const JsonObject input = json_loader::from_string( R"({
        "name": "Conditional active reach strike",
        "manual_activation": true,
        "reach_tec": true,
        "weighting": -2,
        "melee_allowed": true,
        "condition": { "not": { "npc_has_effect": "stunned" } },
        "attack_vectors": [ "vector_null" ]
    })" ).get_object();
    ma_technique technique;
    REQUIRE_NOTHROW( technique.load( input, "test" ) );
    CHECK( technique.lua_platform_condition_handler.empty() );
    CHECK( technique.can_activate() );
    const JsonObject critical_input = json_loader::from_string( R"({
        "name": "Forced critical strike", "manual_activation": true,
        "crit_tec": true, "melee_allowed": true, "attack_vectors": [ "vector_null" ]
    })" ).get_object();
    CHECK_THROWS( technique.load( critical_input, "test" ) );
}

TEST_CASE( "active_technique_rechecks_target_and_spends_one_melee_attack",
           "[martial_arts][active_technique]" )
{
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    dude.setpos( get_map(), dude_pos );
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    dude.martial_arts_data->add_martialart( test_style_ma1 );
    dude.martial_arts_data->set_style( test_style_ma1 );
    monster &adjacent = spawn_test_monster( "mon_zombie", dude_pos + tripoint_rel_ms( 1, 0, 0 ) );
    monster &distant = spawn_test_monster( "mon_zombie", dude_pos + tripoint_rel_ms( 3, 0, 0 ) );
    dude.set_moves( 1000 );
    dude.set_stamina( dude.get_stamina_max() );
    const int moves_before = dude.get_moves();
    const int stamina_before = dude.get_stamina();
    REQUIRE( dude.is_adjacent( &adjacent, false ) );
    const std::vector<matec_id> granted = dude.active_techniques();
    REQUIRE( std::find( granted.begin(), granted.end(), test_active_strike ) != granted.end() );

    CHECK_FALSE( dude.use_active_technique( adjacent, test_technique ) );
    CHECK_FALSE( dude.use_active_technique( distant, test_active_strike ) );
    dude.martial_arts_data->reset_style();
    CHECK_FALSE( dude.use_active_technique( adjacent, test_active_strike ) );
    dude.martial_arts_data->set_style( test_style_ma1 );
    CHECK( dude.get_moves() == moves_before );
    CHECK( dude.get_stamina() == stamina_before );

    REQUIRE( dude.use_active_technique( adjacent, test_active_strike ) );
    CHECK( dude.get_moves() < moves_before );
    CHECK( dude.get_stamina() < stamina_before );
}

TEST_CASE( "active_technique_accuracy_bonus_modifies_the_attack_roll",
           "[martial_arts][active_technique]" )
{
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    dude.setpos( get_map(), dude_pos );
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    dude.martial_arts_data->add_martialart( test_style_ma1 );
    dude.martial_arts_data->set_style( test_style_ma1 );
    dude.set_moves( 1000 );

    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    target.set_dodge_bonus( 1000 );
    melee::clear_stats();

    REQUIRE( dude.use_active_technique( target, test_active_accurate_strike ) );
    CHECK( melee::get_stats().attack_count == 1 );
    CHECK( melee::get_stats().hit_count == 1 );
}

TEST_CASE( "active_technique_notifies_allied_npc_once_on_hit_or_miss",
           "[martial_arts][active_technique][npc]" )
{
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    dude.setpos( get_map(), dude_pos );
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    dude.martial_arts_data->add_martialart( test_style_ma1 );
    dude.martial_arts_data->set_style( test_style_ma1 );
    dude.set_moves( 1000 );

    npc &target = spawn_npc( ( dude_pos + tripoint::east ).xy(), "test_talker" );
    clear_character( target, true );
    target.setpos( get_map(), dude_pos + tripoint::east );
    target.set_attitude( NPCATT_FOLLOW );
    target.op_of_u.trust = 20;
    target.op_of_u.anger = 0;
    REQUIRE( target.is_player_ally() );

    const bool should_hit = GENERATE( false, true );
    target.set_dodge_bonus( should_hit ? -10000 : 10000 );
    melee::clear_stats();

    REQUIRE( dude.use_active_technique( target, test_active_strike ) );
    CHECK( melee::get_stats().attack_count == 1 );
    CHECK( melee::get_stats().hit_count == ( should_hit ? 1 : 0 ) );
    CHECK( target.hit_by_player );
    CHECK( target.op_of_u.trust == 15 );
    CHECK( target.op_of_u.anger == 5 );
    CHECK( target.is_player_ally() );
}

TEST_CASE( "active_technique_cooldown_tracks_execution_and_game_time",
           "[martial_arts][active_technique][cooldown]" )
{
    restore_on_out_of_scope restore_time( calendar::turn );
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    dude.setpos( get_map(), dude_pos );
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    dude.martial_arts_data->add_martialart( test_style_ma1 );
    dude.martial_arts_data->set_style( test_style_ma1 );

    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    target.set_dodge_bonus( 10000 );
    dude.set_moves( 1000 );
    const int moves_before = dude.get_moves();
    CHECK_FALSE( dude.use_active_technique( dude, test_manual_cooldown_strike ) );
    target.setpos( get_map(), dude_pos + tripoint( 3, 0, 0 ) );
    CHECK_FALSE( dude.use_active_technique( target, test_manual_cooldown_strike ) );
    target.setpos( get_map(), dude_pos + tripoint::east );
    dude.martial_arts_data->reset_style();
    CHECK_FALSE( dude.use_active_technique( target, test_manual_cooldown_strike ) );
    dude.martial_arts_data->set_style( test_style_ma1 );
    CHECK( dude.technique_cooldown_remaining( test_manual_cooldown_strike ) == 0_turns );
    CHECK( dude.get_moves() == moves_before );
    dude.start_technique_cooldown( RAPID );
    CHECK( dude.active_technique_cooldowns().empty() );

    melee::clear_stats();
    REQUIRE( dude.use_active_technique( target, test_manual_cooldown_strike ) );
    CHECK( melee::get_stats().attack_count == 1 );
    CHECK( melee::get_stats().hit_count == 0 );
    CHECK( dude.technique_cooldown_remaining( test_manual_cooldown_strike ) == 10_seconds );
    const int moves_after = dude.get_moves();
    CHECK_FALSE( dude.use_active_technique( target, test_manual_cooldown_strike ) );
    CHECK( dude.get_moves() == moves_after );
    const std::vector<matec_id> available = dude.active_techniques();
    CHECK( std::find( available.begin(), available.end(),
                      test_manual_cooldown_strike ) == available.end() );
    const std::vector<matec_id> menu = dude.active_techniques( true );
    CHECK( std::find( menu.begin(), menu.end(), test_manual_cooldown_strike ) != menu.end() );
    CHECK( test_manual_cooldown_strike->activation_allowed( dude, "menu" ) );
    CHECK_FALSE( test_manual_cooldown_strike->activation_allowed( dude, "start" ) );

    calendar::turn += 4_seconds;
    CHECK( dude.technique_cooldown_remaining( test_manual_cooldown_strike ) == 6_seconds );
    dude.martial_arts_data->reset_style();
    dude.remove_weapon();
    CHECK( dude.technique_cooldown_remaining( test_manual_cooldown_strike ) == 6_seconds );
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    dude.martial_arts_data->set_style( test_style_ma1 );
    calendar::turn += 6_seconds;
    CHECK( dude.technique_cooldown_remaining( test_manual_cooldown_strike ) == 0_turns );
    CHECK( dude.active_technique_cooldowns().empty() );
    CHECK( dude.use_active_technique( target, test_manual_cooldown_strike ) );
    CHECK( dude.technique_cooldown_remaining( test_manual_cooldown_strike ) == 10_seconds );
    CHECK( RAPID->cooldown == 0_turns );
}

TEST_CASE( "active_technique_cooldown_survives_save_load",
           "[martial_arts][active_technique][cooldown][save]" )
{
    restore_on_out_of_scope restore_time( calendar::turn );
    clear_avatar();
    avatar &dude = get_avatar();

    dude.start_technique_cooldown( test_manual_cooldown_strike );
    calendar::turn += 3_seconds;
    std::ostringstream serialized;
    JsonOut output( serialized );
    dude.serialize( output );
    std::string saved = serialized.str();
    SECTION( "saved deadline is preserved" ) {
        avatar restored;
        restored.deserialize( json_loader::from_string( saved ).get_object() );
        CHECK( restored.technique_cooldown_remaining( test_manual_cooldown_strike ) == 7_seconds );
        calendar::turn += 7_seconds;
        avatar expired;
        expired.deserialize( json_loader::from_string( saved ).get_object() );
        CHECK( expired.technique_cooldown_remaining( test_manual_cooldown_strike ) == 0_turns );
        CHECK( expired.active_technique_cooldowns().empty() );
    }
    SECTION( "older saves start with no cooldowns" ) {
        const size_t start = saved.find( "\"technique_cooldowns\"" );
        REQUIRE( start != std::string::npos );
        const size_t end = saved.find( ']', start );
        REQUIRE( end != std::string::npos );
        const size_t comma = saved.rfind( ',', start );
        REQUIRE( comma != std::string::npos );
        saved.erase( comma, end + 1 - comma );
        avatar restored;
        restored.start_technique_cooldown( test_manual_cooldown_strike );
        restored.deserialize( json_loader::from_string( saved ).get_object() );
        CHECK( restored.technique_cooldown_remaining( test_manual_cooldown_strike ) == 0_turns );
        CHECK( restored.active_technique_cooldowns().empty() );
    }
}

TEST_CASE( "martial_arts", "[martial_arts]" )
{
    SECTION( "martial art valid weapon" ) {
        GIVEN( "a weapon that fits the martial art" ) {
            CHECK( test_style_ma1->has_weapon( itype_test_weapon1 ) );
        }

        GIVEN( "a weapon that fits the martial art weapon category" ) {
            CHECK( test_style_ma1->has_weapon( itype_test_weapon2 ) );
        }
    }
}

TEST_CASE( "martial_art_tech_effect_conditions", "[martial_arts][tech_effect]" )
{
    standard_npc dude( "TestCharacter", dude_pos, {}, 0, 8, 8, 8, 8 );
    monster target( mon_zombie );

    const auto load_effect = []( const std::string & data ) {
        JsonObject jo = json_loader::from_string( data ).get_object();
        return load_tech_effect_data( jo );
    };
    const auto apply_effect = [&]( tech_effect_data effect ) {
        ma_technique technique;
        technique.tech_effects.emplace_back( std::move( effect ) );
        damage_instance damage;
        int move_cost = 100;
        item_location weapon;
        dude.perform_technique( technique, target, damage, move_cost, weapon );
    };

    SECTION( "an effect without a condition still applies" ) {
        tech_effect_data effect = load_effect(
                                      R"({ "id": "stunned", "duration": 10, "on_damage": false })" );
        REQUIRE_FALSE( effect.has_condition );
        apply_effect( std::move( effect ) );
        CHECK( target.has_effect( effect_stunned ) );
    }

    SECTION( "a true dialogue condition applies the effect" ) {
        tech_effect_data effect = load_effect(
                                      R"({ "id": "stunned", "duration": 10, "on_damage": false, "condition": "u_is_npc" })" );
        REQUIRE( effect.has_condition );
        apply_effect( std::move( effect ) );
        CHECK( target.has_effect( effect_stunned ) );
    }

    SECTION( "a false dialogue condition blocks the effect" ) {
        tech_effect_data effect = load_effect(
                                      R"({ "id": "stunned", "duration": 10, "on_damage": false, "condition": { "not": "u_is_npc" } })" );
        REQUIRE( effect.has_condition );
        apply_effect( std::move( effect ) );
        CHECK_FALSE( target.has_effect( effect_stunned ) );
    }

    SECTION( "the legacy req_flag field remains supported" ) {
        tech_effect_data effect = load_effect(
                                      R"({ "id": "stunned", "duration": 10, "on_damage": false, "req_flag": "PSEUDOPOD_GRASP" })" );
        REQUIRE( effect.req_flag == json_flag_PSEUDOPOD_GRASP );
        REQUIRE_FALSE( dude.has_flag( json_flag_PSEUDOPOD_GRASP ) );
        apply_effect( effect );
        CHECK_FALSE( target.has_effect( effect_stunned ) );

        dude.set_mutation( trait_ARM_TENTACLES );
        REQUIRE( dude.has_flag( json_flag_PSEUDOPOD_GRASP ) );
        apply_effect( std::move( effect ) );
        CHECK( target.has_effect( effect_stunned ) );
    }
}

TEST_CASE( "Martial_art_required_weapon_categories", "[martial_arts]" )
{
    SECTION( "Weapon categories required for buff" ) {
        REQUIRE( !test_style_ma1->onmiss_buffs.empty() );
        const mabuff_id &buff1 = test_style_ma1->onmiss_buffs[0];
        const mabuff_id &buff2 = test_style_ma1->onmiss_buffs[1];

        REQUIRE( buff1->reqs.weapon_categories_allowed[0] == *test_style_ma1->weapon_category.begin() );
        standard_npc dude( "TestCharacter", dude_pos, {}, 0, 8, 8, 8, 8 );
        item weap2( itype_test_weapon2 );
        clear_character( dude, true );
        CHECK( !buff1->is_valid_character( dude ) );
        CHECK( !buff2->is_valid_character( dude ) );
        dude.wield( weap2 );
        dude.martial_arts_data->add_martialart( test_style_ma1 );
        dude.martial_arts_data->set_style( test_style_ma1, false );
        CHECK( buff1->is_valid_character( dude ) );
        CHECK( !buff2->is_valid_character( dude ) );
    }

    SECTION( "Weapon categories required for technique" ) {
        REQUIRE( !test_style_ma1->techniques.empty() );
        const matec_id &tec = *test_style_ma1->techniques.find( test_technique );

        REQUIRE( tec->reqs.weapon_categories_allowed[0] == *test_style_ma1->weapon_category.begin() );
        standard_npc dude( "TestCharacter", dude_pos, {}, 0, 8, 8, 8, 8 );
        item weap2( itype_test_weapon2 );
        clear_character( dude, true );
        CHECK( !tec->is_valid_character( dude ) );
        dude.wield( weap2 );
        dude.martial_arts_data->add_martialart( test_style_ma1 );
        dude.martial_arts_data->set_style( test_style_ma1, false );
        CHECK( tec->is_valid_character( dude ) );
    }
}

TEST_CASE( "Attack_vector_test", "[martial_arts][limb]" )
{
    clear_map_without_vision();
    standard_npc dude( "TestCharacter", dude_pos, {}, 0, 8, 8, 8, 8 );
    clear_character( dude );
    dude.martial_arts_data->add_martialart( test_style_ma1 );
    dude.martial_arts_data->set_style( test_style_ma1, false );
    monster &target_1 = spawn_test_monster( "mon_zombie_fat", dude_pos + tripoint::east );
    const matec_id &tec = *test_style_ma1->techniques.find( test_vector_tech_1 );
    const matec_id &tec2 = *test_style_ma1->techniques.find( test_vector_tech_2 );
    REQUIRE( !dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                       false ) );
    REQUIRE( dude.evaluate_technique( tec2, target_1, dude.used_weapon(), false, false,
                                      false ) );
    REQUIRE( dude.get_all_body_parts_of_type( bp_type::tail ).empty() );

    SECTION( "Limb requirements" ) {
        // Grow a tail, suddenly we can use it
        dude.toggle_trait( trait_DEBUG_TAIL );
        CHECK( dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                        false ) );
        // Unless our tail breaks
        REQUIRE( body_part_debug_tail->health_limit == 5 );
        dude.set_part_hp_cur( body_part_debug_tail, 1 );
        CHECK( !dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                         false ) );
    }
    SECTION( "Missing contact" ) {
        // Lose our vector limb
        dude.toggle_trait( trait_DEBUG_TAIL );
        CHECK( dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                        false ) );
        dude.enchantment_cache->force_add( *enchantment_ENCH_TEST_BIRD_PARTS, dude );
        dude.recalculate_bodyparts();
        REQUIRE( !dude.has_part( body_part_hand_l ) );
        CHECK( !dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                         false ) );
    }
    SECTION( "Limb HP" ) {
        dude.toggle_trait( trait_DEBUG_TAIL );
        CHECK( dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                        false ) );
        // Check bp hp limit (hands don't have HP so we check arms)
        dude.set_part_hp_cur( body_part_arm_l, 1 );
        CHECK( !dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                         false ) );
    }
    SECTION( "Encumbrance" ) {
        REQUIRE( dude.get_all_body_parts_of_type( bp_type::tail ).empty() );
        item test_eoc_armor_suit( itype_test_eoc_armor_suit );
        REQUIRE( dude.wear_item( test_eoc_armor_suit, false ) );
        CHECK( !dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                         false ) );
    }
    SECTION( "Limb substitution" ) {
        dude.enchantment_cache->force_add( *enchantment_ENCH_TEST_BIRD_PARTS, dude );
        dude.recalculate_bodyparts();
        CHECK( dude.evaluate_technique( tec2, target_1, dude.used_weapon(), false, false,
                                        false ) );
    }
}

TEST_CASE( "Martial_art_technique_conditionals", "[martial_arts]" )
{
    clear_map_without_vision();
    standard_npc dude( "TestCharacter", dude_pos, {}, 0, 8, 8, 8, 8 );
    const tripoint_bub_ms target_1_pos = dude_pos + tripoint::east;
    const tripoint_bub_ms target_2_pos = dude_pos + tripoint::north;
    const tripoint_bub_ms target_3_pos = dude_pos + tripoint::west;
    clear_character( dude, true );
    dude.martial_arts_data->add_martialart( test_style_ma1 );
    dude.martial_arts_data->set_style( test_style_ma1, false );
    REQUIRE( dude.get_size() == 3 );
    SECTION( "Test sweep" ) {
        const matec_id &tec = *test_style_ma1->techniques.find( test_tech_condition_sweep );
        monster &target_1 = spawn_test_monster( "mon_zombie_fat", target_1_pos );
        monster &target_2 = spawn_test_monster( "mon_zombie_hulk", target_2_pos );
        monster &target_3 = spawn_test_monster( "mon_blob", target_3_pos );

        // test sweeping a zombie (succeed)
        REQUIRE( target_1.get_size() == 3 );
        CHECK( dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                        false ).has_value() );
        // Being downed disables the attack
        target_1.add_effect( effect_downed, 1_days );
        CHECK( !dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                         false ).has_value() );
        // test sweeping a big zomb (fail)
        REQUIRE( target_2.get_size() == 5 );
        CHECK( !dude.evaluate_technique( tec, target_2, dude.used_weapon(), false, false,
                                         false ).has_value() );
        // test sweeping a slime (fail)
        REQUIRE( target_3.get_size() == 3 );
        REQUIRE( target_3.type->bodytype == "blob" );
        CHECK( !dude.evaluate_technique( tec, target_3, dude.used_weapon(), false, false,
                                         false ).has_value() );
    }

    SECTION( "Test stun" ) {
        const matec_id &tec = *test_style_ma1->techniques.find( test_tech_condition_stun );
        monster &target_1 = spawn_test_monster( "mon_feral_human_pipe", target_1_pos );
        monster &target_2 = spawn_test_monster( "mon_zombie_fat", target_2_pos );
        monster &target_3 = spawn_test_monster( "mon_blob", target_3_pos );
        item weap( itype_sword_crude );
        dude.wield( weap );

        // test stunning a feral (succeed)
        REQUIRE( target_1.get_size() == 3 );
        REQUIRE( !target_1.type->in_species( species_ZOMBIE ) );
        CHECK( dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                        false ).has_value() );
        // Being stunned disables the attack
        target_1.add_effect( effect_stunned, 1_days );
        CHECK( !dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                         false ).has_value() );
        // test stunning a zombie (fail)
        REQUIRE( target_2.get_size() == 3 );
        REQUIRE( target_2.type->in_species( species_ZOMBIE ) );
        CHECK( !dude.evaluate_technique( tec, target_2, dude.used_weapon(), false, false,
                                         false ).has_value() );
        // test stunning a slime (fail)
        REQUIRE( target_3.get_size() == 3 );
        REQUIRE( target_3.type->in_species( species_SLIME ) );
        CHECK( !dude.evaluate_technique( tec, target_3, dude.used_weapon(), false, false,
                                         false ).has_value() );
    }
    SECTION( "Test knockback" ) {
        const matec_id &tec = *test_style_ma1->techniques.find( test_tech_condition_knockback );
        monster &target_1 = spawn_test_monster( "mon_feral_human_pipe", target_1_pos );
        monster &target_2 = spawn_test_monster( "mon_zombie_hulk", target_2_pos );
        monster &target_3 = spawn_test_monster( "mon_test_tech_grabber", target_3_pos );
        item weap( itype_club_wooden );
        dude.wield( weap );

        // test throwing a feral (succeed)
        REQUIRE( target_1.get_size() == 3 );
        CHECK( dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                        false ).has_value() );
        // Being downed disables the attack
        target_1.add_effect( effect_downed, 1_days );
        CHECK( !dude.evaluate_technique( tec, target_1, dude.used_weapon(), false, false,
                                         false ).has_value() );
        // test throwing a large target (fail)
        REQUIRE( target_2.get_size() == 5 );
        CHECK( !dude.evaluate_technique( tec, target_2, dude.used_weapon(), false, false,
                                         false ).has_value() );
        // test throwing a monster grabbing you (succeed)
        dude.add_effect( effect_grabbed, 1_days );
        target_3.add_effect( effect_grabbing, 1_days );
        REQUIRE( target_3.get_size() == 3 );
        REQUIRE( target_3.get_grab_strength() == 0 );
        CHECK( dude.evaluate_technique( tec, target_3, dude.used_weapon(), false, false,
                                        false ).has_value() );
    }
}

TEST_CASE( "automatic_martial_style_weapon_preferences", "[martial_arts]" )
{
    standard_npc dude( "TestCharacter", dude_pos, {}, 0, 8, 8, 8, 8 );
    clear_character( dude, true );
    character_martial_arts &arts = *dude.martial_arts_data;
    const matype_id none( style_none );
    arts.add_martialart( test_style_ma1 );
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    REQUIRE( test_style_ma1->weapon_valid( dude.get_wielded_item() ) );
    CHECK( arts.selected_style() == none );

    arts.auto_style = true;
    arts.auto_select_style( dude );
    CHECK( arts.selected_style() == test_style_ma1 );

    // Explicitly choosing no style is a valid preference, not a missing value.
    arts.set_style( none );
    arts.remember_weapon_style( dude );
    dude.set_wielded_item( item( itype_test_weapon2 ) );
    CHECK( arts.selected_style() == test_style_ma1 );
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    CHECK( arts.selected_style() == none );

    std::ostringstream saved;
    JsonOut out( saved );
    arts.serialize( out );
    character_martial_arts restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    REQUIRE( restored.auto_style );
    restored.set_style( test_style_ma1 );
    restored.auto_select_style( dude );
    CHECK( restored.selected_style() == none );

    dude.set_wielded_item( item() );
    arts.set_style( none );
    arts.remember_weapon_style( dude );
    dude.set_wielded_item( item( itype_test_weapon2 ) );
    CHECK( arts.selected_style() == test_style_ma1 );
    dude.remove_weapon();
    CHECK( arts.selected_style() == none );

    arts.auto_style = false;
    dude.set_wielded_item( item( itype_test_weapon2 ) );
    CHECK( arts.selected_style() == none );
}

TEST_CASE( "active_technique_cooldowns_follow_calendar_and_survive_style_changes_and_saves",
           "[martial_arts][active_technique][cooldown][save]" )
{
    restore_on_out_of_scope restore_time( calendar::turn );
    calendar::turn = calendar::turn_zero + 1_hours;
    character_martial_arts arts;
    const matec_id &technique = test_active_cooldown_strike;
    REQUIRE( technique.is_valid() );
    CHECK( arts.technique_cooldown_remaining( technique ) == 0_turns );
    arts.start_technique_cooldown( technique, 8_seconds );
    CHECK( arts.technique_cooldown_remaining( technique ) == 8_seconds );
    arts.reset_style();
    arts.clear_styles();
    arts.start_technique_cooldown( technique, 0_turns );
    arts.start_technique_cooldown( technique, 1_seconds );
    CHECK( arts.technique_cooldown_remaining( technique ) == 8_seconds );

    calendar::turn += 3_seconds;
    CHECK( arts.technique_cooldown_remaining( technique ) == 5_seconds );
    std::ostringstream output;
    JsonOut writer( output );
    arts.serialize( writer );
    character_martial_arts restored;
    restored.deserialize( json_loader::from_string( output.str() ).get_object() );
    CHECK( restored.technique_cooldown_remaining( technique ) == 5_seconds );
    calendar::turn += 5_seconds;
    CHECK( restored.technique_cooldown_remaining( technique ) == 0_turns );
    calendar::turn += 1_days;
    CHECK( restored.technique_cooldown_remaining( technique ) == 0_turns );
    restored.deserialize( json_loader::from_string( "{}" ).get_object() );
    CHECK( restored.technique_cooldown_remaining( technique ) == 0_turns );
}

TEST_CASE( "active_technique_cooldowns_commit_on_misses_but_not_rejected_attacks",
           "[martial_arts][active_technique][cooldown]" )
{
    restore_on_out_of_scope restore_time( calendar::turn );
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    dude.setpos( get_map(), dude_pos );
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    const matype_id &style = test_style_cooldown;
    const matec_id &technique = test_active_cooldown_strike;
    dude.martial_arts_data->add_martialart( style );
    dude.martial_arts_data->set_style( style );
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    dude.set_moves( 1000 );
    CHECK_FALSE( dude.use_active_technique( dude, technique ) );
    CHECK( dude.get_moves() == 1000 );
    CHECK( dude.martial_arts_data->technique_cooldown_remaining( technique ) == 0_turns );

    target.set_dodge_bonus( 1000 );
    REQUIRE( dude.active_technique_availability( technique ).success() );
    REQUIRE( dude.evaluate_technique( technique, target, dude.used_weapon(), false, false,
                                      false, true ) );
    melee::clear_stats();
    const int hp_before = target.get_hp();
    REQUIRE( dude.use_active_technique( target, technique ) );
    CHECK( melee::get_stats().attack_count == 1 );
    CHECK( melee::get_stats().hit_count == 0 );
    CHECK( target.get_hp() == hp_before );
    CHECK( dude.get_moves() < 1000 );
    CHECK( dude.martial_arts_data->technique_cooldown_remaining( technique ) == 8_seconds );
    CHECK_FALSE( dude.active_technique_availability( technique ).success() );
    const std::vector<matec_id> visible = dude.active_techniques( true );
    CHECK( std::find( visible.begin(), visible.end(), technique ) != visible.end() );
    const std::vector<matec_id> usable = dude.active_techniques();
    CHECK( std::find( usable.begin(), usable.end(), technique ) == usable.end() );
    const int moves_after = dude.get_moves();
    CHECK_FALSE( dude.use_active_technique( target, technique ) );
    CHECK( dude.get_moves() == moves_after );
    dude.remove_weapon();
    dude.set_wielded_item( item( itype_test_weapon1 ) );
    CHECK( dude.martial_arts_data->technique_cooldown_remaining( technique ) == 8_seconds );
    calendar::turn += 8_seconds;
    CHECK( dude.active_technique_availability( technique ).success() );
    REQUIRE( dude.use_active_technique( target, technique ) );
    CHECK( dude.martial_arts_data->technique_cooldown_remaining( technique ) == 8_seconds );
}

TEST_CASE( "active_technique_cooldown_definitions_validate_durations",
           "[martial_arts][active_technique][cooldown][json]" )
{
    const auto load = []( const std::string & duration ) {
        ma_technique technique;
        technique.load( json_loader::from_string(
                            R"({"name":"Cooldown test","cooldown":")" + duration + R"("})" ).get_object(), "test" );
        return technique.cooldown;
    };
    CHECK( load( "0 s" ) == 0_turns );
    CHECK( load( "8 s" ) == 8_seconds );
    CHECK( load( "1 d" ) == 1_days );
    CHECK_THROWS( load( "-1 s" ) );
    CHECK_THROWS( load( "2 d" ) );
}

TEST_CASE( "active_technique_cooldowns_do_not_disable_automatic_techniques",
           "[martial_arts][active_technique][cooldown]" )
{
    clear_avatar();
    clear_map();
    avatar &dude = get_avatar();
    dude.setpos( get_map(), dude_pos );
    dude.set_all_skills( 5 );
    dude.set_wielded_item( item( itype_sword_metal_fencing ) );
    const matec_id technique( RAPID );
    monster &target = spawn_test_monster( "mon_zombie", dude_pos + tripoint::east );
    dude.martial_arts_data->start_technique_cooldown( technique, 8_seconds );
    CHECK_FALSE( dude.active_technique_availability( technique ).success() );
    CHECK( dude.evaluate_technique( technique, target, dude.used_weapon(), false, false, false ) );
}
