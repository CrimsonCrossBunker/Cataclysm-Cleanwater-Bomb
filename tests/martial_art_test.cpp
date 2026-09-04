#include <memory>
#include <optional>
#include <set>
#include <string>
#include <tuple>
#include <vector>

#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character_martial_arts.h"
#include "coordinates.h"
#include "creature.h"
#include "damage.h"
#include "enums.h"
#include "item.h"
#include "json_loader.h"
#include "magic_enchantment.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "martialarts.h"
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
static const itype_id itype_sword_crude( "sword_crude" );
static const itype_id itype_test_eoc_armor_suit( "test_eoc_armor_suit" );
static const itype_id itype_test_weapon1( "test_weapon1" );
static const itype_id itype_test_weapon2( "test_weapon2" );

static const json_character_flag json_flag_PSEUDOPOD_GRASP( "PSEUDOPOD_GRASP" );

static const matec_id test_tech_condition_knockback( "test_tech_condition_knockback" );
static const matec_id test_tech_condition_stun( "test_tech_condition_stun" );
static const matec_id test_tech_condition_sweep( "test_tech_condition_sweep" );
static const matec_id test_technique( "test_technique" );
static const matec_id test_vector_tech_1( "test_vector_tech_1" );
static const matec_id test_vector_tech_2( "test_vector_tech_2" );
static const matype_id test_style_ma1( "test_style_ma1" );

static const species_id species_SLIME( "SLIME" );
static const species_id species_ZOMBIE( "ZOMBIE" );

static const trait_id trait_ARM_TENTACLES( "ARM_TENTACLES" );
static const trait_id trait_DEBUG_TAIL( "DEBUG_TAIL" );

static constexpr tripoint_bub_ms dude_pos( HALF_MAPSIZE_X, HALF_MAPSIZE_Y, 0 );

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
    monster target( mtype_id( "mon_zombie" ) );

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
