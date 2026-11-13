#include <algorithm>
#include <cmath>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "coordinates.h"
#include "damage.h"
#include "debug.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_stack.h"
#include "itype.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "player_helpers.h"
#include "point.h"
#include "projectile.h"
#include "ranged.h"
#include "type_id.h"
#include "units.h"

static const flag_id json_flag_SLING_PROJECTILE( "SLING_PROJECTILE" );

static const itype_id itype_test_throwing_flagged( "test_throwing_flagged" );
static const itype_id itype_test_sling_payload( "test_sling_payload" );
static const itype_id itype_test_throw_correction( "test_throw_correction" );
static const itype_id itype_test_throwing_aid( "test_throwing_aid" );
static const itype_id itype_test_throwing_ammo( "test_throwing_ammo" );
static const itype_id itype_test_throwing_plain( "test_throwing_plain" );
static const itype_id itype_test_throwing_stack( "test_throwing_stack" );
static const itype_id itype_test_throwing_unrecoverable( "test_throwing_unrecoverable" );

static const skill_id skill_throw( "throw" );

struct throw_test_pstats {
    int skill_lvl;
    int str;
    int dex;
    int per;
};

static void reset_player( Character &you, const throw_test_pstats &pstats,
                          const tripoint_bub_ms &pos )
{
    clear_character( you );
    CHECK( !you.in_vehicle );
    you.setpos( get_map(), pos );
    you.set_str_base( pstats.str );
    you.set_dex_base( pstats.dex );
    you.set_per_base( pstats.per );
    you.set_str_bonus( 0 );
    you.set_per_bonus( 0 );
    you.set_dex_bonus( 0 );
    you.set_skill_level( skill_throw, pstats.skill_lvl );
}

TEST_CASE( "time_to_throw_independent_of_number_of_projectiles", "[throwing]" )
{
    Character &you = get_avatar();
    clear_avatar();

    item thrown( itype_test_throwing_stack, calendar::turn, 10 );
    REQUIRE( thrown.charges > 1 );
    you.wield( thrown );
    int initial_moves = -1;
    while( thrown.charges > 0 ) {
        const int cost = throw_cost( you, thrown );
        if( initial_moves < 0 ) {
            initial_moves = cost;
        } else {
            CHECK( initial_moves == cost );
        }
        thrown.charges--;
    }
}

TEST_CASE( "throw_cost_uses_half_attack_time_and_dexterity", "[throwing]" )
{
    clear_map_without_vision();
    avatar &you = get_avatar();
    reset_player( you, { 10, 8, 8, 8 }, { 30, 30, 0 } );
    const item rock( itype_test_throwing_stack, calendar::turn, 1 );
    const int base_cost = rock.attack_time( you ) / 2;
    const int skill_cost = base_cost / 2;
    CHECK( throw_cost( you, rock ) == base_cost + skill_cost - 8 );

    you.set_dex_base( 12 );
    CHECK( throw_cost( you, rock ) == base_cost + skill_cost - 12 );
}

TEST_CASE( "thrown_items_follow_recovery_chance", "[throwing]" )
{
    clear_map_without_vision();
    avatar &you = get_avatar();
    reset_player( you, { 10, 8, 8, 8 }, { 30, 30, 0 } );
    const bool recover = GENERATE( false, true );
    const itype_id thrown_id = recover ? itype_test_throwing_stack : itype_test_throwing_unrecoverable;
    const item thrown( thrown_id, calendar::turn, 1 );
    REQUIRE( thrown.type->thrown_recovery_chance == ( recover ? 100 : 0 ) );

    const dealt_projectile_attack attack = you.throw_item( { 31, 30, 0 }, thrown );
    bool found = false;
    for( const item &dropped : get_map().i_at( attack.end_point ) ) {
        found = found || dropped.typeId() == thrown_id;
    }
    CHECK( found == recover );
}

TEST_CASE( "throwing_leverage_raises_weight_damage_cap", "[throwing]" )
{
    clear_map_without_vision();
    avatar &you = get_avatar();
    reset_player( you, { 10, 8, 8, 8 }, { 30, 30, 0 } );
    const item projectile( itype_test_throwing_stack, calendar::turn, 1 );
    const double base_cap = you.thrown_item_adjusted_damage( projectile );
    const double base_damage = projectile.base_damage_thrown().type_damage( damage_bash );
    REQUIRE( base_cap > 0 );
    REQUIRE( base_cap < units::to_gram( projectile.weight() ) / 100.0 );
    CHECK( you.thrown_item_total_damage_raw( projectile ) == std::round( base_damage + base_cap ) );

    item aid( itype_test_throwing_aid );
    REQUIRE( aid.type->throw_correction );
    const throw_correction_data &correction = *aid.type->throw_correction;
    REQUIRE( correction.weight_multiplier > 1.0f );
    REQUIRE( you.wield( aid ) );
    const double cap = base_cap * ( 1.0 + 0.5 * ( correction.weight_multiplier - 1.0 ) );
    const double expected_damage = ( base_damage + cap ) * correction.damage_multiplier;
    CHECK( you.thrown_item_total_damage_raw( projectile ) == std::round( expected_damage ) );
    const dealt_projectile_attack attack = you.throw_item( { 31, 30, 0 }, projectile );
    CHECK( attack.proj.impact.type_damage( damage_bash ) == Approx( expected_damage ) );
}

TEST_CASE( "throw_correction_warns_without_rejecting_inverted_weight_bounds", "[throwing]" )
{
    throw_correction_data correction;
    const bool inherited_maximum = GENERATE( false, true );
    CAPTURE( inherited_maximum );
    if( inherited_maximum ) {
        correction.deserialize( json_loader::from_string( R"({"max_weight":"1 g"})"
                                                        ).get_object() );
    }
    const std::string definition = inherited_maximum ?
                                   R"({"min_weight":"2 g","throw_damage_multiplier":1.5})" :
                                   R"({"min_weight":"2 g","max_weight":"1 g","throw_damage_multiplier":1.5})";
    const std::string warning = capture_debugmsg_during( [&]() {
        CHECK_NOTHROW( correction.deserialize( json_loader::from_string( definition ).get_object() ) );
    } );
    CHECK( warning.find( "min_weight exceeds max_weight" ) != std::string::npos );
    CHECK( correction.was_loaded );
    CHECK( correction.damage_multiplier == Approx( 1.5f ) );
    CHECK_FALSE( correction.applies_to( item( itype_test_throwing_ammo, calendar::turn, 1 ) ) );
}

TEST_CASE( "throw_correction_rejects_empty_flag_arrays", "[throwing]" )
{
    const std::string definition = GENERATE( R"({"required_flag":[]})",
                                   R"({"required_flag":[[]]})" );
    CAPTURE( definition );
    throw_correction_data correction;
    CHECK_THROWS_AS( correction.deserialize( json_loader::from_string( definition ).get_object() ),
                     JsonError );
}

TEST_CASE( "throw_correction_ammo_and_flag_selectors", "[throwing]" )
{
    const item ammo( itype_test_throwing_ammo, calendar::turn, 1 );
    const item rock( itype_test_throwing_flagged );
    const item knife( itype_test_throwing_plain );
    REQUIRE( ammo.is_ammo() );
    REQUIRE_FALSE( ammo.has_flag( json_flag_SLING_PROJECTILE ) );
    REQUIRE( rock.has_flag( json_flag_SLING_PROJECTILE ) );
    REQUIRE_FALSE( rock.is_ammo() );

    throw_correction_data correction;
    correction.deserialize( json_loader::from_string( R"({
        "required_flag": "SLING_PROJECTILE", "allow_ammotype": ["test_throwing"]
    })" ).get_object() );
    CHECK( correction.applies_to( ammo ) );
    CHECK( correction.applies_to( rock ) );
    CHECK_FALSE( correction.applies_to( knife ) );

    SECTION( "omitted_fields_preserve_inherited_selectors" ) {
        correction.deserialize( json_loader::from_string( "{}" ).get_object() );
        CHECK( correction.applies_to( ammo ) );
        CHECK( correction.applies_to( rock ) );
        CHECK_FALSE( correction.applies_to( knife ) );
    }
    SECTION( "ammo_list_without_flags_requires_matching_ammo" ) {
        throw_correction_data ammo_only;
        ammo_only.deserialize( json_loader::from_string( R"({"allow_ammotype":["test_throwing"]})"
                                                       ).get_object() );
        CHECK( ammo_only.applies_to( ammo ) );
        CHECK_FALSE( ammo_only.applies_to( rock ) );
        CHECK_FALSE( ammo_only.applies_to( knife ) );
    }
    SECTION( "null_clears_inherited_flags_but_preserves_ammo_list" ) {
        correction.deserialize( json_loader::from_string( R"({"required_flag":null})"
                                                        ).get_object() );
        CHECK( correction.applies_to( ammo ) );
        CHECK_FALSE( correction.applies_to( rock ) );
        CHECK_FALSE( correction.applies_to( knife ) );
    }
    SECTION( "clearing_both_selectors_removes_item_type_restrictions" ) {
        correction.deserialize( json_loader::from_string( R"({
            "required_flag": null, "allow_ammotype": []
        })" ).get_object() );
        CHECK( correction.applies_to( knife ) );
    }
    SECTION( "both_matching_paths_still_check_physical_limits" ) {
        const std::string limit = GENERATE( R"({"min_weight":"1 kg"})",
                                            R"({"max_weight":"0 g"})",
                                            R"({"max_volume":"0 ml"})",
                                            R"({"max_length":"0 mm"})" );
        CAPTURE( limit );
        correction.deserialize( json_loader::from_string( limit ).get_object() );
        CHECK_FALSE( correction.applies_to( ammo ) );
        CHECK_FALSE( correction.applies_to( rock ) );
    }
}

TEST_CASE( "throw_correction_full_bonus_skill_loading", "[throwing]" )
{
    throw_correction_data correction;
    CHECK_FALSE( correction.full_bonus_skill );
    CHECK( correction.skill_adjusted_bonus( 1.6f, 0.0f, false ) == Approx( 1.6f ) );
    correction.deserialize( json_loader::from_string( R"({"full_bonus_skill":3})"
                                                    ).get_object() );
    REQUIRE( correction.full_bonus_skill == 3 );
    correction.deserialize( json_loader::from_string( "{}" ).get_object() );
    CHECK( correction.full_bonus_skill == 3 );

    SECTION( "zero_disables_the_requirement" ) {
        correction.deserialize( json_loader::from_string( R"({"full_bonus_skill":0})"
                                                        ).get_object() );
        CHECK( correction.full_bonus_skill == 0 );
        CHECK( correction.skill_adjusted_bonus( 1.6f, 0.0f, false ) == Approx( 1.6f ) );
    }
    SECTION( "null_clears_the_inherited_requirement" ) {
        correction.deserialize( json_loader::from_string( R"({"full_bonus_skill":null})"
                                                        ).get_object() );
        CHECK_FALSE( correction.full_bonus_skill );
        CHECK( correction.skill_adjusted_bonus( 1.6f, 0.0f, false ) == Approx( 1.6f ) );
    }
    SECTION( "invalid_requirements_are_rejected" ) {
        const std::string definition = GENERATE( R"({"full_bonus_skill":-1})",
                                                R"({"full_bonus_skill":"3"})" );
        CHECK_THROWS_AS( correction.deserialize( json_loader::from_string( definition ).get_object() ),
                         JsonError );
    }
}

TEST_CASE( "throw_correction_scales_only_favorable_changes", "[throwing]" )
{
    throw_correction_data correction;
    correction.full_bonus_skill = 3;
    const float skill = GENERATE( 0.0f, 0.5f, 1.0f, 2.0f, 3.0f, 4.0f );
    CAPTURE( skill );
    const float proficiency = std::min( 1.0f, skill / 3.0f );
    CHECK( correction.skill_adjusted_bonus( 1.6f, skill, false ) ==
           Approx( 1.0f + 0.6f * proficiency ) );
    CHECK( correction.skill_adjusted_bonus( 0.4f, skill, false ) == Approx( 0.4f ) );
    CHECK( correction.skill_adjusted_bonus( 0.4f, skill, true ) ==
           Approx( 1.0f - 0.6f * proficiency ) );
    CHECK( correction.skill_adjusted_bonus( 1.6f, skill, true ) == Approx( 1.6f ) );
    CHECK( correction.skill_adjusted_bonus( 1.0f, skill, false ) == Approx( 1.0f ) );
    CHECK( correction.skill_adjusted_bonus( 1.0f, skill, true ) == Approx( 1.0f ) );

    CHECK( correction.skill_adjusted_bonus( 0.6f, skill, false, 0.0f ) ==
           Approx( 0.6f * proficiency ) );
    CHECK( correction.skill_adjusted_bonus( -0.6f, skill, false, 0.0f ) == Approx( -0.6f ) );
    CHECK( correction.skill_adjusted_bonus( -0.6f, skill, true, 0.0f ) ==
           Approx( -0.6f * proficiency ) );
    CHECK( correction.skill_adjusted_bonus( 0.6f, skill, true, 0.0f ) == Approx( 0.6f ) );
}

static void check_throw_correction( const Character &you, const item &projectile,
                                    const float damage, const float range,
                                    const float stamina, const float dispersion,
                                    const float speed, const float weight )
{
    CHECK( you.throw_damage_multiplier( projectile ) == Approx( damage ) );
    CHECK( you.throw_range_multiplier( projectile ) == Approx( range ) );
    CHECK( you.throw_stamina_multiplier( projectile ) == Approx( stamina ) );
    CHECK( you.throw_dispersion_multiplier( projectile ) == Approx( dispersion ) );
    CHECK( you.throw_speed_multiplier( projectile ) == Approx( speed ) );
    CHECK( you.throw_weight_multiplier( projectile ) == Approx( weight ) );
}

TEST_CASE( "throwing_aid_proficiency_preserves_penalties", "[throwing]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    const int skill = GENERATE( 0, 1, 2, 3, 4 );
    const bool lighter = GENERATE( false, true );
    CAPTURE( skill, lighter );
    you.set_skill_level( skill_throw, skill );
    const float proficiency = std::min( 1.0f, skill / 3.0f );
    item aid( itype_id( lighter ? "test_throw_correction_skill_light" :
                       "test_throw_correction_skill" ) );
    REQUIRE( aid.type->throw_correction );
    REQUIRE( aid.type->throw_correction->full_bonus_skill == 3 );
    REQUIRE( you.wield( aid ) );
    const item projectile( itype_test_throwing_stack );

    if( lighter ) {
        check_throw_correction( you, projectile, 0.7f, 0.8f, 1.3f, 1.6f,
                                1.0f - 0.3f * proficiency, 1.0f - 0.3f * proficiency );
        CHECK( you.throw_weight_multiplier( projectile, true ) == Approx( 0.7f ) );
    } else {
        check_throw_correction( you, projectile, 1.0f + 0.6f * proficiency,
                                1.0f + 0.9f * proficiency, 1.0f - 0.3f * proficiency,
                                1.0f - 0.6f * proficiency, 1.3f, 1.6f );
        CHECK( you.throw_weight_multiplier( projectile, true ) ==
               Approx( 1.0f + 0.6f * proficiency ) );
    }
    const item incompatible( itype_test_throwing_plain );
    check_throw_correction( you, incompatible, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f );
    CHECK( you.throw_weight_multiplier( incompatible, true ) == Approx( 1.0f ) );
}

TEST_CASE( "throw_correction_flag_requirements", "[throwing]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    item correction( itype_test_throw_correction );
    REQUIRE( you.wield( correction ) );

    SECTION( "all_flags_in_an_inner_group_are_required" ) {
        item matching( itype_test_throwing_stack );
        check_throw_correction( you, matching, 1.1f, 1.2f, 1.3f, 1.4f, 1.5f, 1.6f );

        item missing_one_flag( itype_test_throwing_flagged );
        check_throw_correction( you, missing_one_flag, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f );
    }

    SECTION( "outer_groups_are_alternatives" ) {
        item matching( itype_test_sling_payload );
        check_throw_correction( you, matching, 1.1f, 1.2f, 1.3f, 1.4f, 1.5f, 1.6f );
    }
}
