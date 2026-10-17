#if defined(TILES)
#include "cata_catch.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_utility.h"
#include "character.h"
#include "creature.h"
#include "creature_render_view.h"
#include "effect.h"
#include "monster.h"
#include "mtype.h"
#include "map.h"
#include "magic_enchantment.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "player_helpers.h"
#include "rng.h"
#include "type_id.h"

TEST_CASE( "character_render_view_owns_appearance_after_character_changes",
           "[tiles][semantic_view]" )
{
    Character &ch = get_player_character();
    clear_character( ch );
    ch.male = false;
    ch.facing = FacingDirection::LEFT;
    ch.add_effect( efftype_id( "stunned" ), 1_minutes );
    const auto expected = ch.get_overlay_ids();
    const auto engine = rng_get_engine();
    const entity_render_view view = capture_character_render_view( ch, FacingDirection::NONE );
    CHECK( view.body == "player_female" );
    CHECK( view.category == "none" );
    CHECK( view.rotation == -1 );
    CHECK_FALSE( view.male );
    CHECK_FALSE( view.stack_overlays );
    CHECK( view.overlays == expected );
    CHECK( rng_get_engine() == engine );
    clear_character( ch );
    ch.male = true;
    ch.facing = FacingDirection::RIGHT;
    CHECK( view.body == "player_female" );
    CHECK( view.overlays == expected );
    CHECK( capture_character_render_view( ch, FacingDirection::LEFT ).rotation == -1 );
}

TEST_CASE( "monster_overlay_view_survives_actor_destruction_without_rng", "[tiles][semantic_view]" )
{
    entity_render_view view;
    std::vector<std::pair<std::string, std::string>> expected;
    auto engine = rng_get_engine();
    {
        monster mon( mtype_id( "mon_zombie" ) );
        mon.facing = FacingDirection::RIGHT;
        mon.add_effect( efftype_id( "stunned" ), 1_minutes );
        expected = mon.get_overlay_ids();
        engine = rng_get_engine();
        view = capture_monster_overlay_view( mon );
    }
    CHECK( view.rotation == 0 );
    CHECK( view.male );
    CHECK( view.stack_overlays );
    CHECK( view.overlays == expected );
    CHECK( rng_get_engine() == engine );
}
TEST_CASE( "creature_view_freezes_visibility_mount_and_copied_appearance",
           "[tiles][semantic_view]" )
{
    clear_map_without_vision();
    map &here = get_map();
    Character &you = get_player_character();
    clear_character( you );
    you.male = true;
    set_time_to_day();
    you.setpos( here, { 50, 50, 0 } );
    monster &mon = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    mon.facing = FacingDirection::LEFT;
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 0 );
    here.build_map_cache( 0, true );
    you.recalc_sight_limits();
    REQUIRE( you.sees( here, mon ) );
    SECTION( "normal body and overlays survive actor changes" ) {
        const auto view = capture_creature_render_view( here, you, &mon, mon.pos_bub(), false );
        REQUIRE( view );
        CHECK( view->body == "mon_zombie" );
        CHECK( view->rotation == -1 );
        REQUIRE( view->monster_overlays );
        const auto expected = mon.get_overlay_ids();
        mon.facing = FacingDirection::RIGHT;
        mon.add_effect( efftype_id( "stunned" ), 1_minutes );
        CHECK( view->rotation == -1 );
        CHECK( view->monster_overlays->overlays == expected );
    }
    SECTION( "invisible tile has no normal creature output" ) {
        CHECK_FALSE( capture_creature_render_view( here, you, &mon, mon.pos_bub(), true ) );
    }
    SECTION( "ridden creature captures its passenger first" ) {
        mon.add_effect( efftype_id( "ridden" ), 1_minutes );
        mon.mounted_player = &you;
        const auto view = capture_creature_render_view( here, you, &mon, mon.pos_bub(), false );
        REQUIRE( view );
        REQUIRE( view->rider );
        CHECK( view->rider->body == "player_male" );
        CHECK( view->ridden_body == "rid_mon_zombie" );
        mon.mounted_player = nullptr;
    }
    SECTION( "submerged monster yields to avatar sharing bridge tile" ) {
        here.ter_set( mon.pos_bub(), ter_id( "t_bridge" ) );
        you.setpos( here, mon.pos_bub() );
        mon.underwater = true;
        REQUIRE( mon.is_underwater() );
        const auto view = capture_creature_render_view( here, you, &mon, mon.pos_bub(), false );
        REQUIRE( view );
        REQUIRE( view->character );
        CHECK( view->character->body == "player_male" );
        CHECK( view->disposition.empty() );
    }
    SECTION( "summoner character is captured with monster facing" ) {
        mtype type = *mon.type;
        type.set_flag( mon_flag_COPY_SUMMONER_LOOK );
        restore_on_out_of_scope restore_type( mon.type );
        mon.type = &type;
        mon.set_summoner( &you );
        const auto view = capture_creature_render_view( here, you, &mon, mon.pos_bub(), false );
        REQUIRE( view );
        REQUIRE( view->character );
        CHECK( view->character->rotation == -1 );
        CHECK( view->character_result );
        CHECK( view->body.empty() );
    }
    SECTION( "avatar copy retains legacy drawing result" ) {
        mtype type = *mon.type;
        type.set_flag( mon_flag_COPY_AVATAR_LOOK );
        restore_on_out_of_scope restore_type( mon.type );
        mon.type = &type;
        const auto view = capture_creature_render_view( here, you, &mon, mon.pos_bub(), false );
        REQUIRE( view );
        REQUIRE( view->character );
        CHECK_FALSE( view->character_result );
        CHECK( view->body.empty() );
    }
}
TEST_CASE( "creature_view_keeps_special_vision_conditions_lazy", "[tiles][semantic_view]" )
{
    clear_map_without_vision();
    map &here = get_map();
    Character &you = get_player_character();
    clear_character( you );
    set_time_to_day();
    you.setpos( here, { 50, 50, 0 } );
    monster &mon = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 0 );
    here.build_map_cache( 0, true );
    you.recalc_sight_limits();
    REQUIRE_FALSE( get_avatar().cant_see( mon.pos_bub() ) );
    int conditions = 0;
    int descriptions = 0;
    restore_on_out_of_scope restore_vision( you.enchantment_cache->special_vision_vector );
    you.enchantment_cache->special_vision_vector.clear();
    enchant_cache::special_vision vision;
    vision.range = 10;
    vision.condition = [&]( const_dialogue const & ) {
        ++conditions;
        return true;
    };
    enchant_cache::special_vision_descriptions description;
    description.id = "infrared_creature";
    description.condition = [&]( const_dialogue const & ) {
        ++descriptions;
        return true;
    };
    vision.special_vision_descriptions_vector.push_back( description );
    SECTION( "unblocked description is captured once" ) {
        you.enchantment_cache->special_vision_vector.push_back( vision );
        const auto view = capture_creature_render_view( here, you, &mon, mon.pos_bub(), true );
        REQUIRE( view );
        CHECK( view->special );
        CHECK( view->body == "infrared_creature" );
        CHECK( view->disposition.empty() );
        CHECK( conditions == 1 );
        CHECK( descriptions == 1 );
    }
    SECTION( "legacy ignores-cone block does not evaluate description" ) {
        vision.ignores_aiming_cone = true;
        you.enchantment_cache->special_vision_vector.push_back( vision );
        CHECK_FALSE( capture_creature_render_view( here, you, &mon, mon.pos_bub(), true ) );
        CHECK( conditions == 1 );
        CHECK( descriptions == 0 );
    }
}
#endif // TILES
