#include <item_location.h>
#include <algorithm>
#include <memory>
#include <optional>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character_martial_arts.h"
#include "coordinates.h"
#include "creature.h"
#include "damage.h"
#include "enums.h"
// IWYU pragma: no_include <flexbuffer_json.h>
#include "flexbuffer_json.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "magic_enchantment.h"
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

static const bodypart_str_id body_part_debug_tail( "debug_tail" );
static const efftype_id effect_downed( "downed" );
static const efftype_id effect_grabbed( "grabbed" );
static const efftype_id effect_grabbing( "grabbing" );
static const efftype_id effect_stunned( "stunned" );

static const enchantment_id enchantment_ENCH_TEST_BIRD_PARTS( "ENCH_TEST_BIRD_PARTS" );

static const itype_id itype_club_wooden( "club_wooden" );
static const itype_id itype_spear_steel( "spear_steel" );
static const itype_id itype_sword_crude( "sword_crude" );
static const itype_id itype_sword_metal_fencing( "sword_metal_fencing" );
static const itype_id itype_test_eoc_armor_suit( "test_eoc_armor_suit" );
static const itype_id itype_test_weapon1( "test_weapon1" );
static const itype_id itype_test_weapon2( "test_weapon2" );

static const json_character_flag json_flag_PSEUDOPOD_GRASP( "PSEUDOPOD_GRASP" );

static const mabuff_id ma_buff_buff_niten_ondodge( "buff_niten_ondodge" );

static const matec_id PRECISE( "PRECISE" );
static const matec_id RAPID( "RAPID" );
static const matec_id WBLOCK_1( "WBLOCK_1" );
static const matec_id WIDE( "WIDE" );
static const matec_id niten_timing_attack( "niten_timing_attack" );
static const matec_id tec_bojutsu_frontstrike( "tec_bojutsu_frontstrike" );
static const matec_id tec_boxing_cross( "tec_boxing_cross" );
static const matec_id tec_break( "tec_break" );
static const matec_id tec_feint( "tec_feint" );
static const matec_id tec_sojutsu_jab( "tec_sojutsu_jab" );
static const matec_id test_active_strike( "test_active_strike" );
static const matec_id test_tech_condition_knockback( "test_tech_condition_knockback" );
static const matec_id test_tech_condition_stun( "test_tech_condition_stun" );
static const matec_id test_tech_condition_sweep( "test_tech_condition_sweep" );
static const matec_id test_technique( "test_technique" );
static const matec_id test_vector_tech_1( "test_vector_tech_1" );
static const matec_id test_vector_tech_2( "test_vector_tech_2" );
static const matype_id style_boxing( "style_boxing" );
static const matype_id style_none( "style_none" );
static const matype_id test_style_ma1( "test_style_ma1" );

static const mtype_id mon_zombie( "mon_zombie" );

static const skill_id skill_melee( "melee" );

static const species_id species_SLIME( "SLIME" );
static const species_id species_ZOMBIE( "ZOMBIE" );

static const trait_id trait_ARM_TENTACLES( "ARM_TENTACLES" );
static const trait_id trait_DEBUG_TAIL( "DEBUG_TAIL" );

static constexpr tripoint_bub_ms dude_pos( HALF_MAPSIZE_X, HALF_MAPSIZE_Y, 0 );

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
    CHECK( std::find( critical_techniques.begin(), critical_techniques.end(), precise ) !=
           critical_techniques.end() );

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
    dude.set_wielded_item( item( itype_sword_metal_fencing ) );
    const matec_id precise( PRECISE );
    monster &target = spawn_test_monster( "mon_feral_human_pipe", dude_pos + tripoint::east );
    dude.set_moves( 1000 );
    const int stamina_before = dude.get_stamina();
    target.add_effect( effect_stunned, 1_minutes );
    CHECK_FALSE( dude.use_active_technique( target, precise ) );
    CHECK( dude.get_moves() == 1000 );
    CHECK( dude.get_stamina() == stamina_before );

    target.remove_effect( effect_stunned );
    REQUIRE( dude.evaluate_technique( precise, target, dude.used_weapon(), false, false,
                                      false, true ) );
    melee::clear_stats();
    REQUIRE( dude.use_active_technique( target, precise ) );
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
    CHECK_FALSE( dude.use_active_technique( target, wide ) );
    CHECK( dude.get_moves() == 1000 );
    spawn_test_monster( "mon_zombie", dude_pos + tripoint_rel_ms( 1, 1, 0 ) );
    REQUIRE( dude.use_active_technique( target, wide ) );
    CHECK( dude.get_moves() < 1000 );
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

TEST_CASE( "active_technique_definitions_allow_conditional_critical_and_reach_attacks",
           "[martial_arts][active_technique][json]" )
{
    const JsonObject input = json_loader::from_string( R"({
        "name": "Conditional active reach strike",
        "manual_activation": true,
        "crit_tec": true,
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
