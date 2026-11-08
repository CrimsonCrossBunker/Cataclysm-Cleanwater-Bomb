#include <algorithm>
#include <cstdio>
#include <functional>
#include <iterator>
#include <memory>
#include <optional>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_attire.h"
#include "character_id.h"
#include "coordinates.h"
#include "dialogue.h"
#include "condition.h"
#include "dialogue_chatbin.h"
#include "dialogue_win.h"
#include "effect.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "faction.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "global_vars.h"
#include "input_enums.h"
#include "inventory.h"
#include "item.h"
#include "item_category.h"
#include "item_location.h"
#include "talker_npc.h"
#include "json.h"
#include "json_loader.h"
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    #include "lua_platform_dialogue.h"
    #include "lua_platform_runtime.h"
    #include "lua_platform_state.h"
#endif
#include "magic.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "math_parser_diag_value.h"
#include "messages.h"
#include "mission.h"
#include "mission_dialogue.h"
#include "monster.h"
#include "npc.h"
#include "npc_lifetime.h"
#include "npc_opinion.h"
#include "npctalk.h"
#include "overmapbuffer.h"
#include "pimpl.h"
#include "player_helpers.h"
#include "point.h"
#include "rng.h"
#include "string_formatter.h"
#include "sounds.h"
#include "talker.h"
#include "talker_topic.h"
#include "type_id.h"
#include "units.h"
#include "weather.h"
#include "weather_gen.h"

static const bionic_id bio_ads( "bio_ads" );
static const bionic_id bio_power_storage( "bio_power_storage" );

static const efftype_id effect_currently_busy( "currently_busy" );
static const efftype_id effect_gave_quest_item( "gave_quest_item" );
static const efftype_id effect_infected( "infected" );
static const efftype_id effect_infection( "infection" );
static const efftype_id effect_sleep( "sleep" );

static const item_category_id item_category_food( "food" );
static const item_category_id item_category_manual( "manual" );

static const itype_id itype_backpack( "backpack" );
static const itype_id itype_badge_marshal( "badge_marshal" );
static const itype_id itype_beer( "beer" );
static const itype_id itype_bottle_glass( "bottle_glass" );
static const itype_id itype_bottle_plastic( "bottle_plastic" );
static const itype_id itype_dnd_handbook( "dnd_handbook" );
static const itype_id itype_knife_huge( "knife_huge" );
static const itype_id itype_manual_speech( "manual_speech" );

static const morale_type morale_haircut( "morale_haircut" );

static const mtype_id mon_zombie( "mon_zombie" );

static const npc_class_id NC_TEST_CLASS( "NC_TEST_CLASS" );

static const proficiency_id proficiency_prof_test( "prof_test" );

static const skill_id skill_driving( "driving" );

static const spell_id spell_test_spell_json( "test_spell_json" );
static const spell_id spell_test_spell_lava( "test_spell_lava" );
static const spell_id spell_test_spell_pew( "test_spell_pew" );

static const trait_id trait_ELFA_EARS( "ELFA_EARS" );

static const trait_id trait_PROF_FED( "PROF_FED" );
static const trait_id trait_PROF_SWAT( "PROF_SWAT" );
static const trait_id trait_PSYCHOPATH( "PSYCHOPATH" );
static const trait_id trait_SAPIOVORE( "SAPIOVORE" );
static const trait_id trait_WEB_WEAVER( "WEB_WEAVER" );
static const trait_id trait_test_trait( "test_trait" );

static npc &create_test_talker( bool shopkeep = false )
{
    const string_id<npc_template> test_talker( shopkeep ? "test_shopkeep" : "test_talker" );
    const character_id model_id = get_map().place_npc( point_bub_ms( 25, 25 ), test_talker );
    g->load_npcs();

    npc *model_npc = g->find_npc( model_id );
    REQUIRE( model_npc != nullptr );

    for( const trait_id &tr : model_npc->get_mutations() ) {
        model_npc->unset_mutation( tr );
    }
    model_npc->name = "Beta NPC";
    model_npc->set_hunger( 0 );
    model_npc->set_thirst( 0 );
    model_npc->set_sleepiness( 0 );
    model_npc->remove_effect( effect_sleep );
    // An ugly hack to prevent NPC falling asleep during testing due to massive sleepiness
    model_npc->set_mutation( trait_WEB_WEAVER );

    return *model_npc;
}

static void gen_response_lines( dialogue &d, size_t expected_count )
{
    d.gen_responses( d.topic_stack.back() );
    for( talk_response &response : d.responses ) {
        response.create_option_line( d, input_event() );
    }
    if( d.responses.size() != expected_count ) {
        printf( "Test failure in %s\n", d.topic_stack.back().id.c_str() );
        for( talk_response &response : d.responses ) {
            printf( "response: %s\n", response.text.c_str() );
        }
    }
    CAPTURE( d.responses );
    REQUIRE( d.responses.size() == expected_count );
}

static std::string gen_dynamic_line( dialogue &d )
{
    std::string challenge = d.dynamic_line( d.topic_stack.back() );
    return challenge;
}

static void change_om_type( const std::string &new_type )
{
    const tripoint_abs_omt omt_pos( coords::project_to<coords::omt>( get_map().get_abs(
                                        get_player_character().pos_bub() ) ) );
    overmap_buffer.ter_set( omt_pos, oter_id( new_type ) );
}

static npc &prep_test( dialogue &d, bool shopkeep = false )
{
    map &here = get_map();
    clear_avatar();
    clear_vehicles();
    clear_map_without_vision();
    avatar &player_character = get_avatar();
    player_character.set_value( "test_var", "It's avatar" );
    player_character.name = "Alpha Avatar";
    REQUIRE_FALSE( player_character.in_vehicle );

    const tripoint_bub_ms test_origin( 15, 15, 0 );
    player_character.setpos( here, test_origin );

    g->faction_manager_ptr->create_if_needed();

    npc &beta = create_test_talker( shopkeep );
    beta.set_value( "test_var", "It's npc" );
    d = dialogue( get_talker_for( player_character ), get_talker_for( beta ) );
    return beta;
}

TEST_CASE( "npc_talk_start", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    d.add_topic( "TALK_TEST_START" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
}

TEST_CASE( "npc_talk_failures", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    d.add_topic( "TALK_TEST_FAIL_RESPONSE" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "*Impossible Test: Never See this." );
}

TEST_CASE( "npc_talk_failures_topic", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    d.add_topic( "TALK_TEST_FAIL_RESPONSE" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].success.next_topic.id == "TALK_TEST_START" );
}

TEST_CASE( "npc_talk_describe_mission", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    d.add_topic( "TALK_DESCRIBE_MISSION" );
    std::string d_line = gen_dynamic_line( d );
    CHECK( d_line == "I'm looking for wounded to help." );
}

TEST_CASE( "npc_talk_stats", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    Character &player_character = get_avatar();
    player_character.set_str_bonus( 0 );
    player_character.set_dex_bonus( 0 );
    player_character.set_int_bonus( 0 );
    player_character.set_per_bonus( 0 );
    player_character.set_str_base( 8 );
    player_character.set_dex_base( 8 );
    player_character.set_int_base( 8 );
    player_character.set_per_base( 8 );

    d.add_topic( "TALK_TEST_SIMPLE_STATS" );
    gen_response_lines( d, 5 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a strength test response." );
    CHECK( d.responses[2].text == "This is a dexterity test response." );
    CHECK( d.responses[3].text == "This is an intelligence test response." );
    CHECK( d.responses[4].text == "This is a perception test response." );
    player_character.set_str_base( 6 );
    player_character.set_dex_base( 6 );
    player_character.set_int_base( 6 );
    player_character.set_per_base( 6 );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );

    d.add_topic( "TALK_TEST_NEGATED_STATS" );
    gen_response_lines( d, 5 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a low strength test response." );
    CHECK( d.responses[2].text == "This is a low dexterity test response." );
    CHECK( d.responses[3].text == "This is a low intelligence test response." );
    CHECK( d.responses[4].text == "This is a low perception test response." );
}

TEST_CASE( "npc_talk_skills", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    Character &player_character = get_avatar();
    player_character.set_skill_level( skill_driving, 8 );

    d.add_topic( "TALK_TEST_SIMPLE_SKILLS" );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a driving test response." );

    player_character.set_skill_level( skill_driving, 6 );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );

    d.add_topic( "TALK_TEST_NEGATED_SKILLS" );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a low driving test response." );
}

TEST_CASE( "npc_talk_wearing_and_trait", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );

    Character &player_character = get_avatar();
    for( const trait_id &tr : player_character.get_mutations() ) {
        player_character.unset_mutation( tr );
    }

    d.add_topic( "TALK_TEST_WEARING_AND_TRAIT" );
    gen_response_lines( d, 1 );

    CHECK( d.responses[0].text == "This is a basic test response." );
    player_character.toggle_trait( trait_ELFA_EARS );
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a trait test response." );
    CHECK( d.responses[2].text == "This is a short trait test response." );
    player_character.wear_item( item( itype_badge_marshal ) );
    gen_response_lines( d, 4 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a trait test response." );
    CHECK( d.responses[2].text == "This is a short trait test response." );
    CHECK( d.responses[3].text == "This is a wearing test response." );
    talker_npc.toggle_trait( trait_ELFA_EARS );
    gen_response_lines( d, 6 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a trait test response." );
    CHECK( d.responses[2].text == "This is a short trait test response." );
    CHECK( d.responses[3].text == "This is a wearing test response." );
    CHECK( d.responses[4].text == "This is an NPC trait test response." );
    CHECK( d.responses[5].text == "This is an NPC short trait test response." );
    player_character.toggle_trait( trait_ELFA_EARS );
    talker_npc.toggle_trait( trait_ELFA_EARS );
    player_character.toggle_trait( trait_PSYCHOPATH );
    talker_npc.toggle_trait( trait_SAPIOVORE );
    gen_response_lines( d, 4 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a wearing test response." );
    CHECK( d.responses[2].text == "This is a trait flags test response." );
    CHECK( d.responses[3].text == "This is an NPC trait flags test response." );
    player_character.toggle_trait( trait_PSYCHOPATH );
    talker_npc.toggle_trait( trait_SAPIOVORE );
}

TEST_CASE( "npc_talk_effect", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );
    Character &player_character = get_avatar();

    d.add_topic( "TALK_TEST_EFFECT" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    talker_npc.add_effect( effect_gave_quest_item, 9999_turns );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is an NPC effect test response." );
    player_character.add_effect( effect_gave_quest_item, 9999_turns );
    d.gen_responses( d.topic_stack.back() );
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is an NPC effect test response." );
    CHECK( d.responses[2].text == "This is a player effect test response." );
}

TEST_CASE( "npc_talk_service", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );
    Character &player_character = get_avatar();

    d.add_topic( "TALK_TEST_SERVICE" );
    player_character.cash = 0;
    talker_npc.add_effect( effect_currently_busy, 9999_turns );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    player_character.cash = 800;
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a cash test response." );
    talker_npc.remove_effect( effect_currently_busy );
    gen_response_lines( d, 4 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a cash test response." );
    CHECK( d.responses[2].text == "This is an NPC service test response." );
    CHECK( d.responses[3].text == "This is an NPC available test response." );
}

TEST_CASE( "npc_talk_location", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    REQUIRE( !overmap_buffer.find_camp( get_avatar().pos_abs_omt().xy() ) );
    change_om_type( "pond_field_north" );
    d.add_topic( "TALK_TEST_LOCATION" );
    d.gen_responses( d.topic_stack.back() );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    change_om_type( "field" );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a om_location_field test response." );
    change_om_type( "faction_base_camp_11" );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a faction camp any test response." );
    change_om_type( "evac_center_7_west" );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a om_location_field direction variant response." );
}

TEST_CASE( "npc_talk_role", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );

    d.add_topic( "TALK_TEST_NPC_ROLE" );
    talker_npc.companion_mission_role_id = "NO_TEST_ROLE";
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    talker_npc.companion_mission_role_id = "TEST_ROLE";
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a nearby role test response." );
}

TEST_CASE( "npc_talk_class", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );

    d.add_topic( "TALK_TEST_NPC_CLASS" );
    talker_npc.myclass = npc_class_id::NULL_ID();
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    talker_npc.myclass = NC_TEST_CLASS;
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a class test response." );

    d.add_topic( "TALK_FRIEND_GUARD" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "I have a custom response to a common topic" );
    CHECK( d.responses[0].success.next_topic.id == "TALK_TEST_FACTION_TRUST" );
}

TEST_CASE( "npc_talk_allies", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );

    for( npc *guy : g->allies() ) {
        talk_function::leave( *guy );
    }
    talk_function::follow( talker_npc );
    d.add_topic( "TALK_TEST_NPC_ALLIES" );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is an NPC allies 1 test response." );
}

TEST_CASE( "npc_talk_needs", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );

    d.add_topic( "TALK_TEST_NPC_NEEDS" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    talker_npc.set_thirst( 90 );
    talker_npc.set_hunger( 90 );
    talker_npc.set_sleepiness( sleepiness_levels::EXHAUSTED );
    gen_response_lines( d, 4 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is an NPC thirst test response." );
    CHECK( d.responses[2].text == "This is an NPC hunger test response." );
    CHECK( d.responses[3].text == "This is an NPC sleepiness test response." );
}

TEST_CASE( "npc_talk_mission_goal", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );

    d.add_topic( "TALK_TEST_MISSION_GOAL" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    const std::vector<mission_type> &all_missions = mission_type::get_all();
    bool set_mission = false;
    for( const mission_type &some_mission : all_missions ) {
        if( some_mission.goal == MGOAL_ASSASSINATE ) {
            mission *assassinate = mission::reserve_new( some_mission.id, talker_npc.getID() );
            talker_npc.chatbin.missions.push_back( assassinate );
            talker_npc.chatbin.mission_selected = assassinate;
            d.actor( true )->select_mission( assassinate );
            set_mission = true;
            break;
        }
    }
    CHECK( set_mission );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a mission goal test response." );
}

TEST_CASE( "npc_talk_season", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    const time_point old_calendar = calendar::turn;
    calendar::turn = calendar::start_of_cataclysm;
    d.add_topic( "TALK_TEST_SEASON" );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a season spring test response." );
    calendar::turn += calendar::season_length();
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a days since Cataclysm 30 test response." );
    CHECK( d.responses[2].text == "This is a season summer test response." );
    calendar::turn += calendar::season_length();
    gen_response_lines( d, 4 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a days since Cataclysm 30 test response." );
    CHECK( d.responses[2].text == "This is a days since Cataclysm 120 test response." );
    CHECK( d.responses[3].text == "This is a season autumn test response." );
    calendar::turn += calendar::season_length();
    gen_response_lines( d, 5 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a days since Cataclysm 30 test response." );
    CHECK( d.responses[2].text == "This is a days since Cataclysm 120 test response." );
    CHECK( d.responses[3].text == "This is a days since Cataclysm 210 test response." );
    CHECK( d.responses[4].text == "This is a season winter test response." );
    calendar::turn += calendar::season_length();
    gen_response_lines( d, 6 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a season spring test response." );
    CHECK( d.responses[2].text == "This is a days since Cataclysm 30 test response." );
    CHECK( d.responses[3].text == "This is a days since Cataclysm 120 test response." );
    CHECK( d.responses[4].text == "This is a days since Cataclysm 210 test response." );
    CHECK( d.responses[5].text == "This is a days since Cataclysm 300 test response." );
    calendar::turn = old_calendar;
}

TEST_CASE( "npc_talk_time", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    const time_point old_calendar = calendar::turn;
    calendar::turn = sunrise( calendar::turn ) + 4_hours;
    d.add_topic( "TALK_TEST_TIME" );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a is day test response." );
    calendar::turn = sunset( calendar::turn ) + 2_hours;
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a is night test response." );
    calendar::turn = old_calendar;
}

TEST_CASE( "npc_talk_switch", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );
    Character &player_character = get_avatar();

    d.add_topic( "TALK_TEST_SWITCH" );
    player_character.cash = 1000;
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a switch 1 test response." );
    CHECK( d.responses[2].text == "This is another basic test response." );
    player_character.cash = 100;
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a switch 2 test response." );
    CHECK( d.responses[2].text == "This is another basic test response." );
    player_character.cash = 10;
    gen_response_lines( d, 4 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a switch default 1 test response." );
    CHECK( d.responses[2].text == "This is a switch default 2 test response." );
    CHECK( d.responses[3].text == "This is another basic test response." );
    player_character.cash = 0;
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a switch default 2 test response." );
    CHECK( d.responses[2].text == "This is another basic test response." );
}

TEST_CASE( "npc_talk_or", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );
    Character &player_character = get_avatar();

    d.add_topic( "TALK_TEST_OR" );
    player_character.cash = 0;
    talker_npc.add_effect( effect_currently_busy, 9999_turns );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    player_character.toggle_trait( trait_ELFA_EARS );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is an or trait test response." );
}

TEST_CASE( "npc_talk_and", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );
    Character &player_character = get_avatar();

    player_character.toggle_trait( trait_ELFA_EARS );
    d.add_topic( "TALK_TEST_AND" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    player_character.cash = 800;
    talker_npc.remove_effect( effect_currently_busy );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is an and cash, available, trait test response." );
}

TEST_CASE( "npc_talk_nested", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );
    Character &player_character = get_avatar();

    d.add_topic( "TALK_TEST_NESTED" );
    talker_npc.add_effect( effect_currently_busy, 9999_turns );
    player_character.cash = 0;
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    player_character.cash = 800;
    player_character.set_int_base( 11 );
    player_character.set_int_bonus( 0 );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a complex nested test response." );
}

TEST_CASE( "npc_talk_conditionals", "[npc_talk]" )
{
    dialogue d;
    Character &player_character = get_avatar();
    prep_test( d );
    player_character.cash = 800;

    d.add_topic( "TALK_TEST_TRUE_FALSE_CONDITIONAL" );
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a true/false true response." );
    CHECK( d.responses[2].text == "This is a conditional trial response." );
    talk_response &chosen = d.responses[2];
    bool trial_success = chosen.trial.roll( d );
    CHECK( trial_success == true );
    talk_effect_t &trial_effect = trial_success ? chosen.success : chosen.failure;
    CHECK( trial_effect.next_topic.id == "TALK_TEST_TRUE_CONDITION_NEXT" );
    player_character.cash = 0;
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a true/false false response." );
    CHECK( d.responses[2].text == "This is a conditional trial response." );
    chosen = d.responses[2];
    trial_success = chosen.trial.roll( d );
    CHECK( trial_success == false );
    trial_effect = trial_success ? chosen.success : chosen.failure;
    CHECK( trial_effect.next_topic.id == "TALK_TEST_FALSE_CONDITION_NEXT" );
}

TEST_CASE( "npc_talk_items", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );
    Character &player_character = get_avatar();

    player_character.remove_items_with( []( const item & it ) {
        return it.get_category_shallow().get_id() == item_category_manual ||
               it.get_category_shallow().get_id() == item_category_food ||
               it.typeId() == itype_bottle_glass;
    } );
    d.add_topic( "TALK_TEST_HAS_ITEM" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    d.add_topic( "TALK_TEST_ITEM_REPEAT" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );

    const auto has_item = [&]( Character & p, const itype_id & id, int count ) {
        item old_item = item( id );
        if( old_item.count_by_charges() ) {
            return p.has_charges( id, count );
        } else {
            return p.has_amount( id, count );
        }
    };
    const auto has_beer_bottle = [&]( Character & p, int count ) {
        return has_item( p, itype_bottle_glass, 1 ) && has_item( p, itype_beer, count );
    };
    player_character.cash = 1000;
    player_character.set_int_base( 8 );
    player_character.worn.wear_item( player_character, item( itype_backpack ), false, false );
    d.add_topic( "TALK_TEST_EFFECTS" );
    gen_response_lines( d, 19 );
    // add and remove effect
    REQUIRE_FALSE( player_character.has_effect( effect_infection ) );
    talk_effect_t &effects = d.responses[1].success;
    effects.apply( d );
    CHECK( player_character.has_effect( effect_infection ) );
    CHECK( player_character.get_effect_dur( effect_infection ) == time_duration::from_turns( 10 ) );
    REQUIRE_FALSE( talker_npc.has_effect( effect_infection ) );
    effects = d.responses[2].success;
    effects.apply( d );
    CHECK( talker_npc.has_effect( effect_infection ) );
    CHECK( talker_npc.get_effect( effect_infection ).is_permanent() );
    effects = d.responses[3].success;
    effects.apply( d );
    CHECK_FALSE( player_character.has_effect( effect_infection ) );
    effects = d.responses[4].success;
    effects.apply( d );
    CHECK_FALSE( talker_npc.has_effect( effect_infection ) );
    // add and remove trait
    REQUIRE_FALSE( player_character.has_trait( trait_PROF_FED ) );
    effects = d.responses[5].success;
    effects.apply( d );
    CHECK( player_character.has_trait( trait_PROF_FED ) );
    REQUIRE_FALSE( talker_npc.has_trait( trait_PROF_FED ) );
    effects = d.responses[6].success;
    effects.apply( d );
    CHECK( talker_npc.has_trait( trait_PROF_FED ) );
    effects = d.responses[7].success;
    effects.apply( d );
    CHECK_FALSE( player_character.has_trait( trait_PROF_FED ) );
    effects = d.responses[8].success;
    effects.apply( d );
    CHECK_FALSE( talker_npc.has_trait( trait_PROF_FED ) );
    // buying and spending
    talker_npc.op_of_u.owed = 1000;
    REQUIRE_FALSE( has_beer_bottle( player_character, 2 ) );
    REQUIRE( talker_npc.op_of_u.owed == 1000 );
    effects = d.responses[9].success;
    effects.apply( d );
    CHECK( talker_npc.op_of_u.owed == 500 );
    CHECK( has_beer_bottle( player_character, 2 ) );
    REQUIRE_FALSE( has_item( player_character, itype_bottle_plastic, 1 ) );
    effects = d.responses[10].success;
    effects.apply( d );
    CHECK( has_item( player_character, itype_bottle_plastic, 1 ) );
    CHECK( talker_npc.op_of_u.owed == 500 );
    effects = d.responses[11].success;
    effects.apply( d );
    CHECK( talker_npc.op_of_u.owed == 0 );
    talker_npc.op_of_u.owed = 1000;
    // effect chains
    REQUIRE_FALSE( player_character.has_effect( effect_infected ) );
    REQUIRE_FALSE( talker_npc.has_effect( effect_infected ) );
    REQUIRE_FALSE( player_character.has_trait( trait_PROF_SWAT ) );
    REQUIRE_FALSE( talker_npc.has_trait( trait_PROF_SWAT ) );
    effects = d.responses[12].success;
    effects.apply( d );
    CHECK( player_character.has_effect( effect_infected ) );
    CHECK( player_character.get_effect_dur( effect_infected ) == time_duration::from_turns( 10 ) );
    CHECK( talker_npc.has_effect( effect_infected ) );
    CHECK( talker_npc.get_effect( effect_infected ).is_permanent() );
    CHECK( player_character.has_trait( trait_PROF_SWAT ) );
    CHECK( talker_npc.has_trait( trait_PROF_SWAT ) );
    CHECK( talker_npc.op_of_u.owed == 0 );
    CHECK( talker_npc.get_attitude() == NPCATT_KILL );
    // opinion changes
    talker_npc.op_of_u = npc_opinion();
    REQUIRE_FALSE( talker_npc.op_of_u.trust );
    REQUIRE_FALSE( talker_npc.op_of_u.fear );
    REQUIRE_FALSE( talker_npc.op_of_u.value );
    REQUIRE_FALSE( talker_npc.op_of_u.anger );
    REQUIRE_FALSE( talker_npc.op_of_u.owed );
    effects = d.responses[13].success;
    REQUIRE( effects.opinion.trust == 10 );
    effects.apply( d );
    CHECK( talker_npc.op_of_u.trust == 10 );
    CHECK( talker_npc.op_of_u.fear == 11 );
    CHECK( talker_npc.op_of_u.value == 12 );
    CHECK( talker_npc.op_of_u.anger == 13 );
    CHECK( talker_npc.op_of_u.owed == 14 );

    d.add_topic( "TALK_TEST_HAS_ITEM" );
    gen_response_lines( d, 7 );
    CHECK( d.responses[1].text == "This is a basic test response." );
    CHECK( d.responses[2].text == "This is a u_has_item beer test response." );
    CHECK( d.responses[3].text == "This is a u_has_item bottle_glass test response." );
    CHECK( d.responses[4].text == "This is a u_has_items beer test response." );
    CHECK( d.responses[5].text == "This is a u_has_item_category manuals test response." );
    CHECK( d.responses[6].text == "This is a u_has_item_category manuals count 2 test response." );
    CHECK( d.responses[0].text == "This is a repeated item manual_speech test response" );
    CHECK( d.responses[0].success.next_topic.item_type == itype_manual_speech );
    d.add_topic( d.responses[0].success.next_topic );
    gen_dynamic_line( d );
    CHECK( d.cur_item == itype_manual_speech );

    d.add_topic( "TALK_TEST_ITEM_REPEAT" );
    gen_response_lines( d, 8 );
    CHECK( d.responses[0].text == "This is a repeated category manuals, food test response" );
    CHECK( d.responses[0].success.next_topic.item_type == itype_beer );
    CHECK( d.responses[1].text == "This is a repeated category manuals, food test response" );
    CHECK( d.responses[1].success.next_topic.item_type == itype_dnd_handbook );
    CHECK( d.responses[2].text == "This is a repeated category manuals, food test response" );
    CHECK( d.responses[2].success.next_topic.item_type == itype_manual_speech );
    CHECK( d.responses[3].text == "This is a repeated category manuals test response" );
    CHECK( d.responses[3].success.next_topic.item_type == itype_dnd_handbook );
    CHECK( d.responses[4].text == "This is a repeated category manuals test response" );
    CHECK( d.responses[4].success.next_topic.item_type == itype_manual_speech );
    CHECK( d.responses[5].text == "This is a repeated item beer, bottle_glass test response" );
    CHECK( d.responses[5].success.next_topic.item_type == itype_bottle_glass );
    CHECK( d.responses[6].text == "This is a repeated item beer, bottle_glass test response" );
    CHECK( d.responses[6].success.next_topic.item_type == itype_beer );
    CHECK( d.responses[7].text == "This is a basic test response." );

    d.add_topic( "TALK_TEST_ITEM_WIELDED" );
    item_location loc = player_character.i_add( item( itype_knife_huge ) );
    CHECK( player_character.wield( loc ) );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text ==
           "This is a u_has_wielded_with_weapon_category KNIVES test response." );
    player_character.i_rem( &*player_character.get_wielded_item() );

    // test sell and consume
    d.add_topic( "TALK_TEST_EFFECTS" );
    gen_response_lines( d, 19 );
    REQUIRE( has_item( player_character, itype_bottle_plastic, 1 ) );
    REQUIRE( has_beer_bottle( player_character, 2 ) );
    const std::vector<item *> glass_bottles = player_character.items_with( []( const item & it ) {
        return it.typeId() == itype_bottle_glass;
    } );
    REQUIRE( !glass_bottles.empty() );
    REQUIRE( player_character.wield( *glass_bottles.front() ) );
    effects = d.responses[14].success;
    effects.apply( d );
    CHECK_FALSE( has_item( player_character, itype_bottle_plastic, 1 ) );
    CHECK_FALSE( has_item( player_character, itype_beer, 1 ) );
    CHECK( has_item( talker_npc, itype_bottle_plastic, 1 ) );
    CHECK( has_item( talker_npc, itype_beer, 2 ) );
    effects = d.responses[15].success;
    effects.apply( d );
    CHECK_FALSE( has_item( talker_npc, itype_beer, 2 ) );
    CHECK( has_item( talker_npc, itype_beer, 1 ) );
    effects = d.responses[16].success;
    effects.apply( d );
    CHECK( has_item( player_character, itype_beer, 1 ) );
    effects = d.responses[17].success;
    effects.apply( d );
    CHECK( has_item( player_character, itype_beer, 0 ) );
    CHECK_FALSE( has_item( player_character, itype_beer, 1 ) );
}

TEST_CASE( "npc_talk_vars", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    d.add_topic( "TALK_TEST_VARS" );
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a u_add_var test response." );
    CHECK( d.responses[2].text == "This is an npc_add_var test response." );
    talk_effect_t &effects = d.responses[1].success;
    effects.apply( d );
    effects = d.responses[2].success;
    effects.apply( d );
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a compare_string, u_remove_var test response." );
    CHECK( d.responses[2].text == "This is a compare_string, npc_remove_var test response." );
    effects = d.responses[1].success;
    effects.apply( d );
    effects = d.responses[2].success;
    effects.apply( d );
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a u_add_var test response." );
    CHECK( d.responses[2].text == "This is an npc_add_var test response." );
}

TEST_CASE( "npc_talk_vars_time", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    time_point start_turn = calendar::turn;
    calendar::turn = calendar::turn + time_duration( 1_hours );
    d.add_topic( "TALK_TEST_VARS_TIME" );
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a u_add_var time test response." );
    CHECK( d.responses[2].text == "This is an npc_add_var time test response." );
    talk_effect_t &effects = d.responses[1].success;
    effects.apply( d );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    time_point then = calendar::turn;
    calendar::turn = calendar::turn + time_duration( 4_days );
    REQUIRE( then < calendar::turn );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a u_compare_var time test response for > 3_days." );
    calendar::turn = start_turn;
}

TEST_CASE( "npc_talk_bionics", "[npc_talk]" )
{
    dialogue d;
    npc &beta = prep_test( d );
    Character &player_character = get_avatar();

    player_character.clear_bionics();
    beta.clear_bionics();
    d.add_topic( "TALK_TEST_BIONICS" );
    gen_response_lines( d, 1 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    player_character.add_bionic( bio_ads );
    beta.add_bionic( bio_power_storage );
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "This is a u_has_bionics bio_ads test response." );
    CHECK( d.responses[2].text == "This is an npc_has_bionics ANY response." );
}

TEST_CASE( "npc_faction_trust", "[npc_talk]" )
{
    dialogue d;
    npc &beta = prep_test( d, true );
    Character &player_character = get_avatar();

    player_character.get_faction()->trusts_u = 0;
    beta.get_faction()->trusts_u = 0;
    d.add_topic( "TALK_TEST_FACTION_TRUST" );
    gen_response_lines( d, 3 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "Add 50 to faction trust." );
    CHECK( d.responses[2].text == "Start trade." );
    talk_effect_t &effects = d.responses[1].success;
    effects.apply( d );
    REQUIRE( beta.get_faction()->trusts_u == 50 );
    gen_response_lines( d, 4 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "Faction trust is at least 20." );
    CHECK( d.responses[2].text == "Add 50 to faction trust." );
    CHECK( d.responses[3].text == "Start trade." );
}

TEST_CASE( "test_talk_meta", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    d.add_topic( "TALK_TEST_META" );
    gen_response_lines( d, 2 );
    CHECK( d.responses[0].text == "This is a basic test response." );
    CHECK( d.responses[1].text == "Mod TESTING DATA is loaded." );
}

TEST_CASE( "npc_talk_effects", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );
    Character &player_character = get_avatar();

    // speaker effects just use are owed because I don't want to do anything complicated
    player_character.cash = 1000;
    talker_npc.op_of_u.owed = 2000;
    CHECK( talker_npc.op_of_u.owed == 2000 );
    d.add_topic( "TALK_TEST_SPEAKER_EFFECT_SIMPLE" );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 1500 );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 1000 );
    d.add_topic( "TALK_TEST_SPEAKER_EFFECT_SIMPLE_CONDITIONAL" );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 500 );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 0 );
    talker_npc.op_of_u.owed = 2000;
    CHECK( talker_npc.op_of_u.owed == 2000 );
    d.add_topic( "TALK_TEST_SPEAKER_EFFECT_SENTINEL" );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 1500 );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 1500 );
    d.add_topic( "TALK_TEST_SPEAKER_EFFECT_SENTINEL_CONDITIONAL" );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 1000 );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 1000 );

    talker_npc.op_of_u.owed = 4500;
    CHECK( talker_npc.op_of_u.owed == 4500 );
    d.add_topic( "TALK_TEST_SPEAKER_EFFECT_COMPOUND" );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 3500 );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 2500 );
    d.add_topic( "TALK_TEST_SPEAKER_EFFECT_COMPOUND_CONDITIONAL" );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 1000 );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 500 );
    talker_npc.op_of_u.owed = 3500;
    CHECK( talker_npc.op_of_u.owed == 3500 );
    d.add_topic( "TALK_TEST_SPEAKER_EFFECT_COMPOUND_SENTINEL" );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 2750 );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 2250 );
    d.add_topic( "TALK_TEST_SPEAKER_EFFECT_COMPOUND_SENTINEL_CONDITIONAL" );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 1500 );
    d.apply_speaker_effects( d.topic_stack.back() );
    REQUIRE( talker_npc.op_of_u.owed == 1500 );

    // test change class
    talker_npc.myclass = NC_TEST_CLASS;
    d.add_topic( "TALK_TEST_EFFECTS" );
    gen_response_lines( d, 19 );
    talk_effect_t &effects = d.responses[18].success;
    effects.apply( d );
    CHECK( talker_npc.myclass == npc_class_id::NULL_ID() );
}

TEST_CASE( "npc_change_topic", "[npc_talk]" )
{
    dialogue d;
    npc &talker_npc = prep_test( d );

    const std::string original_chat = talker_npc.chatbin.first_topic;
    REQUIRE( original_chat != "TALK_TEST_SET_TOPIC" );
    d.add_topic( "TALK_TEST_SET_TOPIC" );
    gen_response_lines( d, 2 );
    talk_effect_t &effects = d.responses[1].success;
    effects.apply( d );
    CHECK( talker_npc.chatbin.first_topic != original_chat );
    CHECK( talker_npc.chatbin.first_topic == "TALK_TEST_SET_TOPIC" );
}

TEST_CASE( "npc_compare_int_op", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    d.add_topic( "TALK_TEST_COMPARE_INT_OP" );
    gen_response_lines( d, 10 );
    CHECK( d.responses[ 0 ].text == "Two != five." );
    CHECK( d.responses[ 1 ].text == "Two <= five." );
    CHECK( d.responses[ 2 ].text == "Two < five." );
    CHECK( d.responses[ 3 ].text == "Five = five." );
    CHECK( d.responses[ 4 ].text == "Five == five." );
    CHECK( d.responses[ 5 ].text == "Five <= five." );
    CHECK( d.responses[ 6 ].text == "Five >= five." );
    CHECK( d.responses[ 7 ].text == "Five != two." );
    CHECK( d.responses[ 8 ].text == "Five >= two." );
    CHECK( d.responses[ 9 ].text == "Five > two." );
}

TEST_CASE( "npc_test_tags", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );

    global_variables &globvars = get_globals();
    globvars.set_global_value( "test_var", "It's global" );

    d.add_topic( "TALK_TEST_TAGS" );
    d.set_value( "test_var", "It's context" );
    gen_response_lines( d, 8 );
    CHECK( d.responses[0].create_option_line( d, input_event() ).text ==
           "Avatar tag is set to It's avatar." );
    CHECK( d.responses[1].create_option_line( d, input_event() ).text ==
           "NPC tag is set to It's npc." );
    CHECK( d.responses[2].create_option_line( d, input_event() ).text ==
           "Global tag is set to It's global." );
    CHECK( d.responses[3].create_option_line( d, input_event() ).text ==
           "Item name is TEST rock." );
    CHECK( d.responses[4].create_option_line( d, input_event() ).text ==
           "Item description is A rock the size of a baseball.  Makes a decent melee weapon, and is also good for throwing at enemies." );
    CHECK( d.responses[5].create_option_line( d, input_event() ).text ==
           "Trait name is Ink glands." );
    CHECK( d.responses[6].create_option_line( d, input_event() ).text ==
           "Trait description is A mutation to test enchantments." );
    CHECK( d.responses[7].create_option_line( d, input_event() ).text ==
           "Context tag is set to It's context." );
    globvars.clear_global_values();
}

TEST_CASE( "npc_compare_int", "[npc_talk]" )
{
    calendar::turn = calendar::turn_zero;
    calendar::start_of_cataclysm = calendar::turn_zero;
    calendar::start_of_game = calendar::turn_zero;

    dialogue d;
    npc &beta = prep_test( d );
    Character &player_character = get_avatar();
    clear_avatar();

    player_character.set_str_bonus( 0 );
    player_character.set_dex_bonus( 0 );
    player_character.set_int_bonus( 0 );
    player_character.set_per_bonus( 0 );
    player_character.set_str_base( 4 );
    player_character.set_dex_base( 4 );
    player_character.set_int_base( 4 );
    player_character.set_per_base( 4 );
    beta.set_str_bonus( 0 );
    beta.set_dex_bonus( 0 );
    beta.set_int_bonus( 0 );
    beta.set_per_bonus( 0 );
    beta.set_str_base( 8 );
    beta.set_dex_base( 8 );
    beta.set_int_base( 8 );
    beta.set_per_base( 8 );
    player_character.kill_xp = 50;
    for( npc *guy : g->allies() ) {
        talk_function::leave( *guy );
    }
    player_character.cash = 0;
    beta.op_of_u.owed = 0;
    const skill_id skill = skill_driving;
    player_character.set_skill_level( skill, 0 );

    tripoint_bub_ms loc = get_avatar().pos_bub() + tripoint::east;
    monster &dummy_monster = spawn_test_monster( "mon_dragon_dummy", loc );

    get_weather().temperature = units::from_fahrenheit( 19 );
    get_weather().windspeed = 20;
    get_weather().weather_precise->temperature = units::from_fahrenheit( 19 );
    get_weather().weather_precise->windpower = 20;
    get_weather().weather_precise->humidity = 20;
    get_weather().weather_precise->pressure = 20;
    get_weather().clear_temp_cache();
    player_character.set_stored_kcal( 118169 );
    player_character.remove_items_with( []( const item & it ) {
        return it.get_category_shallow().get_id() == item_category_manual ||
               it.get_category_shallow().get_id() == item_category_food ||
               it.typeId() == itype_bottle_glass;
    } );
    player_character.remove_value( "test_var_time_test_test" );
    calendar::turn = calendar::turn_zero;

    int expected_answers = 7;
    if( player_character.magic->max_mana( player_character ) == 900 ) {
        expected_answers++;
    }

    d.add_topic( "TALK_TEST_COMPARE_INT" );
    gen_response_lines( d, expected_answers );
    CHECK( d.responses[ 0 ].text == "This is a math test response that increments by 1." );
    CHECK( d.responses[ 1 ].text == "This is a math test response that increments by 2." );
    CHECK( d.responses[ 2 ].text == "This is a u_add_var time test response." );
    CHECK( d.responses[expected_answers - 2].text == "Exp of Pew, Pew is -1." );
    CHECK( d.responses[expected_answers - 1].text ==
           "Test Proficiency total learning time is 24 hours." );

    beta.set_str_base( 9 );
    beta.set_dex_base( 10 );
    beta.set_int_base( 11 );
    beta.set_per_base( 12 );
    time_point then = calendar::turn;
    calendar::turn = calendar::turn + time_duration( 4_days );
    REQUIRE( then < calendar::turn );
    // Increment the u var by 1, so that it has a value of 1.
    talk_effect_t &effects = d.responses[ 0 ].success;
    effects.apply( d );
    // Increment the npc var by 2, so that it has a value of 2.
    effects = d.responses[ 1 ].success;
    effects.apply( d );
    // Create a u time variable.
    effects = d.responses[ 2 ].success;
    effects.apply( d );
    talk_function::follow( beta );
    player_character.cash = 13;
    beta.op_of_u.owed = 14;
    player_character.set_skill_level( skill, 8 );
    get_weather().weather_precise->temperature = units::from_fahrenheit( 21 );
    get_weather().weather_precise->windpower = 15;
    get_weather().weather_precise->humidity = 16;
    get_weather().weather_precise->pressure = 17;
    get_weather().clear_temp_cache();
    player_character.setpos( tripoint_abs_ms{ -1, -2, -3 } );
    player_character.set_pain( 21 );
    player_character.add_bionic( bio_power_storage );
    player_character.set_power_level( 22_mJ );
    player_character.set_max_power_level( 44_mJ );
    player_character.clear_morale();
    player_character.add_morale( morale_haircut, 23 );
    player_character.set_hunger( 26 );
    player_character.set_thirst( 27 );
    player_character.set_stored_kcal( 118169 );
    player_character.worn.wear_item( player_character, item( itype_backpack ), false, false );
    player_character.inv->add_item( item( itype_bottle_glass ) );
    player_character.inv->add_item( item( itype_bottle_glass ) );
    player_character.inv->add_item( item( itype_bottle_glass ) );
    cata::event e = cata::event::make<event_type::character_kills_monster>(
                        get_player_character().getID(), mon_zombie, 0 );
    get_event_bus().send_with_talker( get_player_character().as_character(), dummy_monster.as_monster(),
                                      e );
    player_character.magic->learn_spell( spell_test_spell_json, player_character, false );
    player_character.set_mutation( trait_test_trait ); // Give the player the spell scool test_trait
    player_character.magic->set_spell_level( spell_test_spell_json, 1, &player_character );
    player_character.magic->learn_spell( spell_test_spell_pew, player_character, true );
    player_character.magic->set_spell_level( spell_test_spell_pew, 4, &player_character );
    player_character.magic->learn_spell( spell_test_spell_lava, player_character, true );
    player_character.magic->set_spell_level( spell_test_spell_lava, 12, &player_character );
    player_character.set_proficiency_practice( proficiency_prof_test, 12_hours );
    // Set focus after killing monster, since the character
    // gains weakpoint proficiency practice which lowers focus
    // (see kill_tracker::notify() -> weakpoint_families::practice_kill())
    player_character.set_focus( 24 );
    player_character.set_str_bonus( 0 );
    player_character.set_dex_bonus( 0 );
    player_character.set_int_bonus( 0 );
    player_character.set_per_bonus( 0 );
    player_character.set_str_base( 5 );
    player_character.set_dex_base( 6 );
    player_character.set_int_base( 7 );
    player_character.set_per_base( 8 );
    player_character.magic->set_mana( 25 );

    // Each response is separated out into a single line for easier browsing.
    // TODO: Reliably test the random number generator.
    std::vector<std::string> expected_responses = {
        "This is a math test response that increments by 1.",
        "This is a math test response that increments by 2.",
        "PC strength is five.",
        "PC dexterity is six.",
        "PC intelligence is seven.",
        "PC perception is eight.",
        "NPC strength is nine.",
        "NPC dexterity is ten.",
        "NPC intelligence is eleven.",
        "NPC perception is twelve.",
        "PC Custom var is one.",
        "NPC Custom var is two.",
        "This is a u_var time test response for > 3_days.",
        "time_since_cataclysm > 3_days.",
        "time_since_cataclysm in days > 3", //NOTE: Extra conditional response inserted after this for next part of test, ctrl+f "insert" if reordering/removing this element!
        "Allies equals 1",
        "Cash equals 13",
        "Owed amount equals 14",
        "Driving skill more than or equal to 5",
        "Temperature is 21.",
        "Windpower is 15.",
        "Humidity is 16.",
        "Pressure is 17.",
        "Pos_x is -1.",
        "Pos_y is -2.",
        "Pos_z is -3.",
        "Pain level is 21.",
        "Bionic power is 22.",
        "Bionic power max is 44.",
        "Bionic power is at 50%.",
        "Morale is 23.",
        "Focus is 24.",
        "Mana is 25.",
        "Mana max is 900.",
        "Mana is at 2%.",
        "Hunger is 26.",
        "Thirst is 27.",
        "Stored kcal is 118'169.",
        "Has 3 glass bottles.",
        "Has more or equal to 35 experience.",
        "Highest spell level in school test_trait is 1.",
        "Spell level of Pew, Pew is 4.",
        "Spell level of highest spell is 12.",
        "Exp of Pew, Pew is 11006.",
        "Test Proficiency learning is 50% out of 100%.",
        "Test Proficiency learning done is 12 hours total.",
        "Test Proficiency learning is 50% learnt.",
        "Test Proficiency learning is 500 permille learnt.",
        "Test Proficiency total learning time is 24 hours.",
        "Test Proficiency time lest to learn is 12h."
    };

    expected_answers = expected_responses.size();
    gen_response_lines( d, expected_answers );
    for( int i = 0; i < expected_answers; i++ ) {
        // Offset by one here for human ease-of-use. Vectors count from 0, people don't.
        const std::string TEST_INFO = string_format( "Response # %d of %d", i + 1, expected_answers );
        CAPTURE( TEST_INFO );
        CHECK( d.responses[ i ].text == expected_responses[i] );
    }

    // This activates a new response, so we add it to the container and check again.
    calendar::turn = calendar::turn + time_duration( 4_days );
    const std::string extra_test_response = "This is a time since u_var test response for > 3_days.";

    const int extra_response_pos = std::distance( expected_responses.begin(),
                                   std::find( expected_responses.begin(), expected_responses.end(),
                                           "time_since_cataclysm in days > 3" ) ) + 1;
    expected_responses.insert( expected_responses.begin() + extra_response_pos, extra_test_response );
    expected_answers = expected_responses.size();
    gen_response_lines( d, expected_answers );
    CHECK( d.responses[ extra_response_pos ].text == expected_responses[extra_response_pos] );

    // Teardown
    player_character.remove_value( "test_var_time_test_test" );
}

TEST_CASE( "npc_arithmetic", "[npc_talk]" )
{
    tripoint_abs_ms pos;

    dialogue d;
    npc &beta = prep_test( d );
    Character &player_character = get_avatar();

    d.add_topic( "TALK_TEST_ARITHMETIC" );
    gen_response_lines( d, 31 );

    // make sure tested scenarios haven't messed with our start time
    calendar::start_of_cataclysm = calendar::turn_zero;
    calendar::start_of_game = calendar::turn_zero;
    calendar::turn = calendar::turn_zero;
    REQUIRE( calendar::turn == time_point( 0 ) );
    // "Sets time since cataclysm to 1."
    talk_effect_t &effects = d.responses[ 0 ].success;
    effects.apply( d );
    CHECK( calendar::turn == time_point( 1 ) );

    get_weather().weather_precise->temperature = units::from_fahrenheit( 20 );
    get_weather().clear_temp_cache();
    // "Sets temperature to 2."
    effects = d.responses[ 1 ].success;
    effects.apply( d );
    CHECK( units::to_fahrenheit( get_weather().weather_precise->temperature ) == Approx( 2 ).margin(
               0.01 ) );

    get_weather().weather_precise->windpower = 20;
    get_weather().clear_temp_cache();
    // "Sets windpower to 3."
    effects = d.responses[ 2 ].success;
    effects.apply( d );
    CHECK( get_weather().weather_precise->windpower == 3 );

    get_weather().weather_precise->humidity = 20;
    get_weather().clear_temp_cache();
    // "Sets humidity to 4."
    effects = d.responses[ 3 ].success;
    effects.apply( d );
    CHECK( get_weather().weather_precise->humidity == 4 );

    get_weather().weather_precise->pressure = 20;
    get_weather().clear_temp_cache();
    // "Sets pressure to 5."
    effects = d.responses[ 4 ].success;
    effects.apply( d );
    CHECK( get_weather().weather_precise->pressure == 5 );

    player_character.set_str_base( 10 );
    // "Sets base strength to 6."
    effects = d.responses[ 5 ].success;
    effects.apply( d );
    CHECK( player_character.get_str_base() == 6 );

    player_character.set_dex_base( 10 );
    // "Sets base dexterity to 7."
    effects = d.responses[ 6 ].success;
    effects.apply( d );
    CHECK( player_character.get_dex_base() == 7 );

    player_character.set_int_base( 10 );
    // "Sets base intelligence to 8."
    effects = d.responses[ 7 ].success;
    effects.apply( d );
    CHECK( player_character.get_int_base() == 8 );

    player_character.set_per_base( 10 );
    // "Sets base perception to 9."
    effects = d.responses[ 8 ].success;
    effects.apply( d );
    CHECK( player_character.get_per_base() == 9 );

    std::string var_name = "test_var_time_test_test";
    player_character.set_value( var_name, 1 );
    // "Sets custom var to 10."
    effects = d.responses[ 9 ].success;
    effects.apply( d );
    CHECK( player_character.get_value( var_name ) == 10 );

    beta.op_of_u.owed = 0;
    // "Sets owed to 12."
    effects = d.responses[ 10 ].success;
    effects.apply( d );
    CHECK( beta.op_of_u.owed == 12 );

    const skill_id skill = skill_driving;
    // "Sets skill level in driving to 10."
    effects = d.responses[ 11 ].success;
    effects.apply( d );
    CHECK( static_cast<int>( player_character.get_skill_level( skill ) ) == 10 );

    // "Move character position one tile west."
    pos = player_character.pos_abs();
    effects = d.responses[ 12 ].success;
    effects.apply( d );
    CHECK( player_character.pos_abs().x() == pos.x() - 1 );

    // "Move character position two tiles north."
    pos = player_character.pos_abs();
    effects = d.responses[ 13 ].success;
    effects.apply( d );
    CHECK( player_character.pos_abs().y() == pos.y() + 2 );

    // "Sets character z level to -3."
    effects = d.responses[ 14 ].success;
    effects.apply( d );
    CHECK( player_character.posz() == -3 );

    // "Sets pain to 17."
    effects = d.responses[ 15 ].success;
    effects.apply( d );
    CHECK( player_character.get_pain() == 17 );

    player_character.add_bionic( bio_power_storage );
    player_character.set_power_level( 10_mJ );
    player_character.set_max_power_level( 44_mJ );
    // "Sets power to 18."
    effects = d.responses[ 16 ].success;
    effects.apply( d );
    CHECK( player_character.get_power_level().value() == 18 );

    // "Sets power to 20%."
    effects = d.responses[ 17 ].success;
    effects.apply( d );
    CHECK( player_character.get_power_level().value() == 8 );

    // "Sets focus to 19."
    effects = d.responses[ 18 ].success;
    effects.apply( d );
    CHECK( player_character.get_focus() == 19 );

    // "Sets mana to 21."
    effects = d.responses[ 19 ].success;
    effects.apply( d );
    CHECK( player_character.magic->available_mana() == 21 );

    // "Sets mana to 25%."
    effects = d.responses[ 20 ].success;
    effects.apply( d );
    CHECK( player_character.magic->available_mana() == ( player_character.magic->max_mana(
                player_character ) * 25 ) / 100 );

    // "Sets thirst to 22."
    effects = d.responses[ 21 ].success;
    effects.apply( d );
    CHECK( player_character.get_thirst() == 22 );

    // "Sets stored_kcal to 23."
    effects = d.responses[ 22 ].success;
    effects.apply( d );
    CHECK( player_character.get_stored_kcal() == 23 );

    // Spell tests setup
    if( player_character.magic->knows_spell( spell_test_spell_pew ) ) {
        player_character.magic->forget_spell( spell_test_spell_pew );
    }
    CHECK( player_character.magic->knows_spell( spell_test_spell_pew ) == false );

    // "Sets pew pew's level to -1."
    effects = d.responses[23].success;
    effects.apply( d );
    CHECK( player_character.magic->knows_spell( spell_test_spell_pew ) == false );

    // "Sets pew pew's level to 4."
    effects = d.responses[24].success;
    effects.apply( d );
    CHECK( player_character.magic->knows_spell( spell_test_spell_pew ) == true );
    CHECK( player_character.magic->get_spell( spell_test_spell_pew ).get_level() == 4 );

    // "Sets pew pew's level to -1."
    effects = d.responses[23].success;
    effects.apply( d );
    CHECK( player_character.magic->knows_spell( spell_test_spell_pew ) == false );

    // "Sets pew pew's exp to 11006."
    effects = d.responses[26].success;
    effects.apply( d );
    CHECK( player_character.magic->knows_spell( spell_test_spell_pew ) == true );
    CHECK( player_character.magic->get_spell( spell_test_spell_pew ).get_level() == 4 );

    // "Sets pew pew's exp to -1."
    effects = d.responses[25].success;
    effects.apply( d );
    CHECK( player_character.magic->knows_spell( spell_test_spell_pew ) == false );

    // Setup proficiency tests
    if( player_character.has_proficiency( proficiency_prof_test ) ) {
        player_character.lose_proficiency( proficiency_prof_test, true );
    }
    std::vector<proficiency_id> proficiencies_vector = player_character.learning_proficiencies();
    if( std::count( proficiencies_vector.begin(),
                    proficiencies_vector.end(),
                    proficiency_prof_test ) != 0 ) {
        player_character.set_proficiency_practiced_time( proficiency_prof_test, -1 );
    }

    // "Sets Test Proficiency learning done to -1."
    effects = d.responses[28].success;
    effects.apply( d );
    CHECK( player_character.has_proficiency( proficiency_prof_test ) == false );
    proficiencies_vector = player_character.learning_proficiencies();
    CHECK( std::count( proficiencies_vector.begin(),
                       proficiencies_vector.end(),
                       proficiency_prof_test ) == 0 );

    // "Sets Test Proficiency learning done to 24h."
    effects = d.responses[29].success;
    effects.apply( d );
    add_msg( m_bad, "%s: %g", proficiency_prof_test.str(),
             player_character.get_proficiency_practice( proficiency_prof_test ) );
    CHECK( player_character.has_proficiency( proficiency_prof_test ) == true );
    proficiencies_vector = player_character.learning_proficiencies();
    CHECK( std::count( proficiencies_vector.begin(),
                       proficiencies_vector.end(),
                       proficiency_prof_test ) == 0 );

    // "Sets Test Proficiency learning done to 12 hours total."
    effects = d.responses[27].success;
    effects.apply( d );
    CHECK( player_character.has_proficiency( proficiency_prof_test ) == false );
    proficiencies_vector = player_character.learning_proficiencies();
    CHECK( std::count( proficiencies_vector.begin(),
                       proficiencies_vector.end(),
                       proficiency_prof_test ) != 0 );

    // "Sets Test Proficiency learning done to -1."
    effects = d.responses[28].success;
    effects.apply( d );
    CHECK( player_character.has_proficiency( proficiency_prof_test ) == false );
    proficiencies_vector = player_character.learning_proficiencies();
    CHECK( std::count( proficiencies_vector.begin(),
                       proficiencies_vector.end(),
                       proficiency_prof_test ) == 0 );


    // Proficency learning without 'direct': true is impacted by focus
    const auto prof_xp = [&player_character]() {
        return to_seconds<int>( player_character.get_proficiency_practiced_time( proficiency_prof_test ) );
    };

    // For 100 focus
    player_character.set_focus( 100 );
    // No starting XP
    REQUIRE( prof_xp() == 0 );

    // "Learns Test Proficiency for 1h"
    effects = d.responses[30].success;
    effects.apply( d );

    int amt_100 = prof_xp();
    CAPTURE( amt_100 );

    CHECK( player_character.has_proficiency( proficiency_prof_test ) == false );
    proficiencies_vector = player_character.learning_proficiencies();
    CHECK( std::count( proficiencies_vector.begin(),
                       proficiencies_vector.end(),
                       proficiency_prof_test ) == 1 );

    // Reset progress
    player_character.set_proficiency_practice( proficiency_prof_test, 0_seconds );
    REQUIRE( prof_xp() == 0 );

    // For 5 focus
    player_character.set_focus( 5 );

    // "Learns Test Proficiency for 1h"
    effects = d.responses[30].success;
    effects.apply( d );

    int amt_5 = prof_xp();
    CAPTURE( amt_5 );

    CHECK( player_character.has_proficiency( proficiency_prof_test ) == false );
    proficiencies_vector = player_character.learning_proficiencies();
    CHECK( std::count( proficiencies_vector.begin(),
                       proficiencies_vector.end(),
                       proficiency_prof_test ) == 1 );

    // Simply check that they're less, don't need to get any fancier
    CHECK( amt_5 < amt_100 );


    // Teardown
    player_character.remove_value( var_name );
}

TEST_CASE( "test_topic_item_mutator", "[npc_talk]" )
{
    dialogue d;
    prep_test( d );
    Character &player_character = get_avatar();
    clear_avatar();
    global_variables &globvars = get_globals();
    globvars.clear_global_values();

    player_character.inv->add_item( item( itype_bottle_glass ) );
    CHECK( player_character.has_amount( itype_bottle_glass, 1 ) );
    d.add_topic( "TALK_TEST_TOPIC_ITEM_MUTATOR" );
    gen_response_lines( d, 2 );
    talk_response &chosen = d.responses[0];
    CHECK( chosen.text == "This is a repeated item bottle_glass test response" );
    d.add_topic( chosen.success.next_topic );
    gen_dynamic_line( d );
    gen_response_lines( d, 1 );
    chosen = d.responses[0];
    chosen.success.apply( d );
    CHECK( globvars.get_global_value( "key1" ) == "bottle_glass" );
}

TEST_CASE( "dialogue_opinions_belong_to_the_interlocutor", "[npc_talk][multiplayer]" )
{
    dialogue host_dialogue;
    npc &provider = prep_test( host_dialogue );
    provider.op_of_u = npc_opinion();
    host_dialogue.actor( true )->set_npc_trust( 12 );
    host_dialogue.actor( true )->add_debt( 900 );

    npc remote;
    remote.setID( character_id( 700001 ) );
    REQUIRE( remote.getID() != get_avatar().getID() );
    dialogue remote_dialogue( get_talker_for( remote ), get_talker_for( provider ) );
    REQUIRE( remote_dialogue.const_actor( true )->get_npc_trust() == 0 );
    REQUIRE( remote_dialogue.const_actor( true )->debt() == 0 );
    remote_dialogue.actor( true )->set_npc_trust( -4 );
    remote_dialogue.actor( true )->set_npc_fear( 8 );
    remote_dialogue.actor( true )->add_debt( 200 );
    remote_dialogue.actor( true )->add_sold( 50 );

    // Switching back and forth must not retarget existing wrappers or clones.
    host_dialogue.actor( true )->add_debt( 100 );
    const const_dialogue condition( remote_dialogue );
    dialogue copied( remote_dialogue );
    dialogue moved( std::move( copied ) );
    moved.actor( true )->add_debt( 25 );
    CHECK( condition.const_actor( true )->debt() == 225 );
    CHECK( remote_dialogue.const_actor( true )->debt() == 225 );
    CHECK( host_dialogue.const_actor( true )->debt() == 1000 );
    CHECK( host_dialogue.const_actor( true )->get_npc_trust() == 12 );
    CHECK( provider.op_of_u.owed == 1000 );
    CHECK( provider.op_of_u.sold == 0 );
    CHECK( condition.const_actor( true )->sold() == 50 );

    // Reversed roles use the same relationship, including const-only contexts.
    dialogue reverse( get_talker_for( provider ), get_talker_for( remote ) );
    CHECK( reverse.const_actor( false )->get_npc_fear() == 8 );
    const const_dialogue readonly( get_talker_for( remote )->const_clone(),
                                   get_talker_for( provider )->const_clone() );
    CHECK( readonly.const_actor( true )->get_npc_trust() == -4 );
}

TEST_CASE( "dialogue_trials_and_hostility_use_the_same_player_opinion", "[npc_talk][multiplayer]" )
{
    dialogue host_dialogue;
    npc &provider = prep_test( host_dialogue );
    provider.op_of_u = npc_opinion();
    provider.personality.aggression = 0;
    provider.op_of_u.trust = 10;
    provider.op_of_u.fear = 20;
    provider.op_of_u.anger = 25;
    npc remote;
    remote.setID( character_id( 700001 ) );
    dialogue remote_dialogue( get_talker_for( remote ), get_talker_for( provider ) );
    talker &remote_provider = *remote_dialogue.actor( true );
    remote_provider.set_npc_trust( -2 );
    remote_provider.set_npc_fear( 0 );
    remote_provider.set_npc_anger( 25 );

    CHECK_FALSE( host_dialogue.const_actor( true )->turned_hostile() );
    CHECK( remote_provider.turned_hostile() );
    CHECK_FALSE( host_dialogue.const_actor( true )->check_hostile_response( 1 ) );
    CHECK( remote_provider.check_hostile_response( 1 ) );
    CHECK( host_dialogue.const_actor( true )->trial_chance_mod( "lie" ) -
           remote_provider.trial_chance_mod( "lie" ) == 36 );
    CHECK( remote_provider.parse_mod( "TRUST", 3 ) == -6 );
    CHECK( remote_provider.parse_mod( "FEAR", 2 ) == 0 );
    CHECK( remote_provider.opinion_text() == provider.opinion_text( remote.getID() ) );

    // Looking at an unknown participant does not allocate a saved relationship
    // or advance gameplay randomness.
    std::ostringstream before;
    JsonOut before_json( before );
    provider.serialize( before_json );
    const auto rng_before = rng_get_engine();
    const npc &readonly = provider;
    CHECK( readonly.opinion_of( character_id( 700002 ) ).trust == 0 );
    std::ostringstream after;
    JsonOut after_json( after );
    provider.serialize( after_json );
    CHECK( after.str() == before.str() );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "npc_opinions_keep_their_owners_across_save_and_reload",
           "[npc_talk][save][multiplayer]" )
{
    dialogue d;
    npc &provider = prep_test( d );
    const character_id host = get_avatar().getID();
    const character_id remote( 700001 );
    provider.op_of_u = npc_opinion();
    provider.op_of_u.trust = 14;
    provider.op_of_u.owed = 500;
    provider.opinion_of( remote ).trust = -3;
    provider.opinion_of( remote ).owed = 80;
    provider.opinion_of( remote ).sold = 150;
    std::ostringstream encoded;
    JsonOut out( encoded );
    provider.serialize( out );

    npc restored;
    restored.deserialize( json_loader::from_string( encoded.str() ).get_object() );
    CHECK( restored.opinion_of( host ).trust == 14 );
    CHECK( restored.opinion_of( remote ).trust == -3 );
    CHECK( restored.opinion_of( remote ).owed == 80 );
    CHECK( restored.opinion_of( remote ).sold == 150 );

    // Client replicas may have a different local avatar. The saved legacy slot
    // must remain the host's relationship, not silently become the client's.
    const on_out_of_scope restore_player_id( [host]() {
        get_avatar().setID( host, true );
    } );
    get_avatar().setID( remote, true );
    npc replica;
    replica.deserialize( json_loader::from_string( encoded.str() ).get_object() );
    const int replica_host_debt = replica.opinion_of( host ).owed;
    const int replica_remote_debt = replica.opinion_of( remote ).owed;
    get_avatar().setID( host, true );
    CHECK( replica_host_debt == 500 );
    CHECK( replica_remote_debt == 80 );

    // Loading another save into the same object must discard stale entries.
    restored.opinion_of( character_id( 700002 ) ).trust = 99;
    restored.deserialize( json_loader::from_string( encoded.str() ).get_object() );
    CHECK( std::as_const( restored ).opinion_of( character_id( 700002 ) ).trust == 0 );
}

TEST_CASE( "legacy_npc_opinion_is_not_inherited_by_the_first_remote_speaker",
           "[npc_talk][save][multiplayer]" )
{
    dialogue d;
    npc &provider = prep_test( d );
    provider.op_of_u = npc_opinion();
    provider.op_of_u.trust = 9;
    provider.op_of_u.owed = 300;
    std::ostringstream encoded;
    JsonOut out( encoded );
    provider.serialize( out );
    // Keep the native save representation, dropping only the newly added keys.
    std::ostringstream legacy;
    JsonOut legacy_json( legacy );
    legacy_json.start_object();
    std::istringstream input( encoded.str() );
    TextJsonIn source( input );
    source.start_object();
    while( !source.end_object() ) {
        const std::string name = source.get_member_name();
        const int start = source.tell();
        source.skip_value();
        std::string value = source.substr( start, source.tell() - start );
        value.erase( value.find_last_not_of( " \t\r\n," ) + 1 );
        if( name != "op_of_u_owner" && name != "opinions" ) {
            legacy_json.member( name );
            legacy << value;
            legacy_json.set_need_separator();
        }
    }
    legacy_json.end_object();
    npc restored;
    restored.deserialize( json_loader::from_string( legacy.str() ).get_object() );
    npc remote;
    remote.setID( character_id( 700001 ) );
    dialogue remote_dialogue( get_talker_for( remote ), get_talker_for( restored ) );
    CHECK( remote_dialogue.const_actor( true )->debt() == 0 );
    remote_dialogue.actor( true )->add_debt( 20 );
    dialogue host_dialogue( get_talker_for( get_avatar() ), get_talker_for( restored ) );
    CHECK( host_dialogue.const_actor( true )->debt() == 300 );
    CHECK( host_dialogue.const_actor( true )->get_npc_trust() == 9 );
    CHECK( remote_dialogue.const_actor( true )->debt() == 20 );
}

static const itype_id itype_test_rock( "test_rock" );
static const mission_type_id mission_TEST_MISSION_FIND_ITEM( "TEST_MISSION_FIND_ITEM" );
static const mission_type_id mission_TEST_MISSION_GENERIC_REWARD( "TEST_MISSION_GENERIC_REWARD" );
static const mission_type_id mission_TEST_MISSION_GOAL_CONDITION1( "TEST_MISSION_GOAL_CONDITION1" );
static const mission_type_id mission_TEST_MISSION_GOAL_CONDITION2( "TEST_MISSION_GOAL_CONDITION2" );

TEST_CASE( "interleaved_dialogues_isolate_selected_missions_and_preserve_clones",
           "[npc_talk][mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &provider = create_test_talker();
    npc &remote = spawn_npc( point_bub_ms( 26, 25 ), "test_talker" );
    clear_character( remote, true );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );

    mission *host_available = mission::reserve_new(
                                  mission_TEST_MISSION_FIND_ITEM, provider.getID() );
    mission *remote_available = mission::reserve_new(
                                    mission_TEST_MISSION_GOAL_CONDITION1, provider.getID() );
    REQUIRE( host_available != nullptr );
    REQUIRE( remote_available != nullptr );
    provider.chatbin.missions = { host_available, remote_available };

    dialogue host_dialogue( get_talker_for( host ), get_talker_for( provider ) );
    dialogue remote_dialogue( get_talker_for( remote ), get_talker_for( provider ) );
    CHECK( host_dialogue.const_actor( true )->selected_mission() == nullptr );
    CHECK( remote_dialogue.const_actor( true )->selected_mission() == nullptr );

    host_dialogue.actor( true )->select_mission( host_available );
    remote_dialogue.actor( true )->select_mission( remote_available );
    CHECK( host_dialogue.const_actor( true )->selected_mission() == host_available );
    CHECK( remote_dialogue.const_actor( true )->selected_mission() == remote_available );

    const_dialogue host_const_copy( host_dialogue );
    dialogue remote_copy( remote_dialogue );
    CHECK( host_const_copy.const_actor( true )->selected_mission() == host_available );
    CHECK( remote_copy.const_actor( true )->selected_mission() == remote_available );
    CHECK( remote_copy.actor( true )->selected_mission() == remote_available );

    dialogue third_session( get_talker_for( host ), get_talker_for( provider ) );
    CHECK( third_session.const_actor( true )->selected_mission() == nullptr );

    talk_effect_t assign_effect(
        json_loader::from_string( R"({"effect":"assign_mission"})" ).get_object(),
        "effect", "test" );
    assign_effect.apply( remote_dialogue );
    CHECK( remote_available->get_assigned_player_id() == remote.getID() );
    CHECK( remote.get_active_missions() == std::vector<mission *> { remote_available } );
    CHECK( host.get_active_missions().empty() );
    CHECK( host_dialogue.const_actor( true )->selected_mission() == host_available );
    CHECK( host_dialogue.const_actor( true )->assigned_missions().empty() );
    CHECK( remote_dialogue.const_actor( true )->assigned_missions() ==
           std::vector<mission *> { remote_available } );

    assign_effect.apply( host_dialogue );
    CHECK( host_available->get_assigned_player_id() == host.getID() );
    CHECK( host.get_active_missions() == std::vector<mission *> { host_available } );
    CHECK( host_dialogue.const_actor( true )->assigned_missions() ==
           std::vector<mission *> { host_available } );
    CHECK( remote_dialogue.const_actor( true )->assigned_missions() ==
           std::vector<mission *> { remote_available } );

    remote.wield( remote.i_add( item( itype_test_rock ) ) );
    const conditional_t cond_complete( "mission_complete" );
    const conditional_t cond_incomplete( "mission_incomplete" );
    const conditional_t cond_has_remote(
        json_loader::from_string( R"({"u_has_mission":"TEST_MISSION_GOAL_CONDITION1"})" )
        .get_object() );
    CHECK( cond_complete( remote_dialogue ) );
    CHECK_FALSE( cond_incomplete( remote_dialogue ) );
    CHECK( cond_has_remote( remote_dialogue ) );
    CHECK_FALSE( cond_complete( host_dialogue ) );
    CHECK( cond_incomplete( host_dialogue ) );
    CHECK_FALSE( cond_has_remote( host_dialogue ) );

    const int host_value_before = provider.opinion_of( host.getID() ).value;
    const int remote_value_before = provider.opinion_of( remote.getID() ).value;
    talk_effect_t success_effect(
        json_loader::from_string( R"({"effect":"mission_success"})" ).get_object(),
        "effect", "test" );
    success_effect.apply( remote_dialogue );
    CHECK( remote_available->has_succeeded() );
    CHECK( host_available->in_progress() );
    CHECK( provider.opinion_of( remote.getID() ).value > remote_value_before );
    CHECK( provider.opinion_of( host.getID() ).value == host_value_before );
}

TEST_CASE( "competing_dialogue_mission_assignment_and_unauthorized_selection_are_rejected",
           "[npc_talk][mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &provider = create_test_talker();
    npc &other_npc = create_test_talker();
    npc &remote = spawn_npc( point_bub_ms( 26, 25 ), "test_talker" );
    clear_character( remote, true );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );

    mission_type &reward_def = const_cast<mission_type &>(
                                   mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_follow_up( reward_def.follow_up );
    reward_def.follow_up = mission_TEST_MISSION_FIND_ITEM;

    mission *contested = mission::reserve_new(
                             mission_TEST_MISSION_GENERIC_REWARD, provider.getID() );
    mission *foreign_npc_mission = mission::reserve_new(
                                       mission_TEST_MISSION_FIND_ITEM, other_npc.getID() );
    REQUIRE( contested != nullptr );
    REQUIRE( foreign_npc_mission != nullptr );
    provider.chatbin.missions = { contested };
    other_npc.chatbin.missions = { foreign_npc_mission };

    dialogue host_dialogue( get_talker_for( host ), get_talker_for( provider ) );
    dialogue remote_dialogue( get_talker_for( remote ), get_talker_for( provider ) );
    host_dialogue.actor( true )->select_mission( contested );
    remote_dialogue.actor( true )->select_mission( contested );
    CHECK( host_dialogue.const_actor( true )->selected_mission() == contested );
    CHECK( remote_dialogue.const_actor( true )->selected_mission() == contested );

    remote_dialogue.actor( true )->select_mission( foreign_npc_mission );
    CHECK( remote_dialogue.const_actor( true )->selected_mission() == nullptr );
    remote_dialogue.actor( true )->select_mission( contested );
    CHECK( remote_dialogue.const_actor( true )->selected_mission() == contested );

    talk_effect_t assign_effect(
        json_loader::from_string( R"({"effect":"assign_mission"})" ).get_object(),
        "effect", "test" );
    assign_effect.apply( host_dialogue );
    CHECK( contested->get_assigned_player_id() == host.getID() );
    CHECK( provider.chatbin.missions.empty() );
    CHECK( provider.chatbin.missions_assigned == std::vector<mission *> { contested } );
    CHECK( remote_dialogue.const_actor( true )->selected_mission() == nullptr );

    assign_effect.apply( remote_dialogue );
    CHECK( contested->get_assigned_player_id() == host.getID() );
    CHECK( remote.get_active_missions().empty() );

    remote_dialogue.actor( true )->select_mission( contested );
    CHECK( remote_dialogue.const_actor( true )->selected_mission() == nullptr );

    talk_effect_t clear_effect(
        json_loader::from_string( R"({"effect":"clear_mission"})" ).get_object(),
        "effect", "test" );
    talk_effect_t success_effect(
        json_loader::from_string( R"({"effect":"mission_success"})" ).get_object(),
        "effect", "test" );
    talk_effect_t fail_effect(
        json_loader::from_string( R"({"effect":"mission_failure"})" ).get_object(),
        "effect", "test" );

    // Remote cannot succeed, fail, or clear host's assigned mission.
    success_effect.apply( remote_dialogue );
    fail_effect.apply( remote_dialogue );
    clear_effect.apply( remote_dialogue );
    CHECK( contested->in_progress() );
    CHECK( provider.chatbin.missions_assigned == std::vector<mission *> { contested } );

    // Host succeeding twice only grants opinion/wrap_up once, and clear only spawns follow-up once.
    success_effect.apply( host_dialogue );
    CHECK( contested->has_succeeded() );
    const int value_after_first_success = provider.opinion_of( host.getID() ).value;
    success_effect.apply( host_dialogue );
    fail_effect.apply( host_dialogue );
    CHECK( provider.opinion_of( host.getID() ).value == value_after_first_success );
    CHECK_FALSE( contested->has_failed() );

    clear_effect.apply( host_dialogue );
    CHECK( provider.chatbin.missions_assigned.empty() );
    REQUIRE( provider.chatbin.missions.size() == 1 );
    CHECK( provider.chatbin.missions.front()->mission_id() == mission_TEST_MISSION_FIND_ITEM );
    clear_effect.apply( host_dialogue );
    CHECK( provider.chatbin.missions.size() == 1 );
}

TEST_CASE( "mission_dialogue_callbacks_survive_mission_replacement_and_actor_retirement",
           "[npc_talk][mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &provider = create_test_talker();
    npc &remote = spawn_npc( point_bub_ms( 26, 25 ), "test_talker" );
    clear_character( remote, true );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );

    mission_type &reward_def = const_cast<mission_type &>(
                                   mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_start( reward_def.start );

    SECTION( "same_uid_replacement_rejects_stale_session_selection" ) {
        mission *original = mission::reserve_new(
                                mission_TEST_MISSION_GENERIC_REWARD, provider.getID() );
        REQUIRE( original != nullptr );
        const int uid = original->get_id();
        const std::size_t original_gen = original->identity_generation();
        provider.chatbin.missions = { original };

        dialogue remote_dialogue( get_talker_for( remote ), get_talker_for( provider ) );
        remote_dialogue.actor( true )->select_mission( original );
        REQUIRE( remote_dialogue.const_actor( true )->selected_mission() == original );

        mission replacement = *original;
        mission::add_existing( replacement );
        mission *replaced_ptr = mission::find( uid, true );
        REQUIRE( replaced_ptr != nullptr );
        CHECK( replaced_ptr->identity_generation() != original_gen );
        CHECK( remote_dialogue.const_actor( true )->selected_mission() == nullptr );

        talk_effect_t assign_effect(
            json_loader::from_string( R"({"effect":"assign_mission"})" ).get_object(),
            "effect", "test" );
        assign_effect.apply( remote_dialogue );
        CHECK_FALSE( replaced_ptr->is_assigned() );
    }

    SECTION( "start_callback_replacing_mission_or_retiring_character_does_not_corrupt_chatbin" ) {
        bool retire_remote_in_callback = false;
        SECTION( "callback_replaces_mission" ) {}
        SECTION( "callback_retires_remote" ) {
            retire_remote_in_callback = true;
        }
        std::optional<mission> unassigned_snapshot;
        reward_def.start = [&]( mission * task, Character & who ) {
            if( retire_remote_in_callback ) {
                if( npc *npc_who = who.as_npc() ) {
                    g->remove_npc( npc_who->getID() );
                }
            } else {
                REQUIRE( unassigned_snapshot );
                who.remove_active_mission( *task );
                mission::add_existing( *unassigned_snapshot );
                provider.chatbin.missions = { mission::find( unassigned_snapshot->get_id(), true ) };
            }
        };

        mission *task = mission::reserve_new(
                            mission_TEST_MISSION_GENERIC_REWARD, provider.getID() );
        REQUIRE( task != nullptr );
        const int uid = task->get_id();
        unassigned_snapshot = *task;
        provider.chatbin.missions = { task };

        dialogue remote_dialogue( get_talker_for( remote ), get_talker_for( provider ) );
        remote_dialogue.actor( true )->select_mission( task );

        talk_effect_t assign_effect(
            json_loader::from_string( R"({"effect":"assign_mission"})" ).get_object(),
            "effect", "test" );
        assign_effect.apply( remote_dialogue );

        if( !retire_remote_in_callback ) {
            REQUIRE( provider.chatbin.missions.size() == 1 );
            CHECK( provider.chatbin.missions.front() == mission::find( uid, true ) );
            CHECK( provider.chatbin.missions_assigned.empty() );
            CHECK( remote_dialogue.const_actor( true )->selected_mission() == nullptr );
            mission *after = mission::find( uid, true );
            REQUIRE( after != nullptr );
            CHECK_FALSE( after->has_succeeded() );
            CHECK_FALSE( after->is_assigned() );
        } else {
            CHECK( remote_dialogue.const_actor( true )->selected_mission() == nullptr );
        }
    }
}

TEST_CASE( "native_talk_effects_and_lua_dialogue_context_share_session_mission_semantics",
           "[npc_talk][mission][lua][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &provider = create_test_talker();
    npc &remote = spawn_npc( point_bub_ms( 26, 25 ), "test_talker" );
    clear_character( remote, true );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );

    dialogue remote_dialogue( get_talker_for( remote ), get_talker_for( provider ) );
    talk_effect_t add_effect(
        json_loader::from_string(
            R"({"effect":{"add_mission":"TEST_MISSION_GENERIC_REWARD"}})" ).get_object(),
        "effect", "test" );
    add_effect.apply( remote_dialogue );
    REQUIRE( remote.get_active_missions().size() == 1 );
    CHECK( host.get_active_missions().empty() );
    mission *added = remote.get_active_missions().front();
    REQUIRE( added != nullptr );
    CHECK( added->get_assigned_player_id() == remote.getID() );
    CHECK( remote_dialogue.const_actor( true )->selected_mission() == added );

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    sol::state lua;
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime_identity( runtime_owner, 991 );
    cata::lua_platform::runtime_world_ready( true );
    const std::size_t world_generation = cata::lua_platform::runtime_world_generation();
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::session_for(
            remote_dialogue, "TALK_TEST", runtime_identity, world_generation );
    cata::lua_platform::dialogue::context lua_ctx(
        lua.lua_state(), remote_dialogue, "TALK_TEST", true,
        "stale", {}, session, runtime_identity, world_generation, true );

    const int remote_value_before = provider.opinion_of( remote.getID() ).value;
    const int host_value_before = provider.opinion_of( host.getID() ).value;
    lua_ctx.succeed_selected_mission();
    CHECK( added->has_succeeded() );
    CHECK( provider.opinion_of( remote.getID() ).value > remote_value_before );
    CHECK( provider.opinion_of( host.getID() ).value == host_value_before );

    lua_ctx.clear_selected_mission();
    CHECK( provider.chatbin.missions_assigned.empty() );
    CHECK( remote_dialogue.const_actor( true )->selected_mission() == nullptr );
    mission *failed = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, provider.getID() );
    provider.chatbin.missions.push_back( failed );
    remote_dialogue.actor( true )->select_mission( failed );
    mission_dialogue::assign_selected_mission( remote_dialogue );
    lua_ctx.fail_selected_mission();
    CHECK( failed->has_failed() );
    CHECK( failed->get_assigned_player_id() == remote.getID() );
    cata::lua_platform::dialogue::end_session( remote_dialogue );
#endif
}


TEST_CASE( "mission_phase_removal_stops_the_outer_dialogue_effect_chain",
           "[npc_talk][mission][lifetime]" )
{
    clear_avatar();
    clear_map();
    avatar &owner = get_avatar();
    owner.reset_all_missions();
    mission::clear_all();
    npc &provider = create_test_talker();
    const character_id provider_id = provider.getID();
    const auto reference = g->npc_lifetimes().track_active( provider );
    const on_out_of_scope cleanup( [&]() {
        owner.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission_type &definition = const_cast<mission_type &>( mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_start( definition.start );
    const restore_on_out_of_scope restore_end( definition.end );
    const restore_on_out_of_scope restore_fail( definition.fail );
    const auto remove_provider = [provider_id]( mission *, Character & ) {
        g->remove_npc( provider_id );
    };
    mission *task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, provider_id );
    provider.chatbin.missions = { task };
    dialogue conversation( get_talker_for( owner ), get_talker_for( provider ) );
    conversation.actor( true )->select_mission( task );
    talk_effect_t effect;
    SECTION( "assign_start_removes_provider" ) {
        definition.start = remove_provider;
        effect.set_effect( &talk_function::assign_mission );
    }
    SECTION( "add_mission_start_removes_provider" ) {
        definition.start = remove_provider;
        effect.set_effect( talk_effect_fun_t( []( dialogue & d ) {
            mission_dialogue::add_mission_for_dialogue( d, mission_TEST_MISSION_GENERIC_REWARD );
        } ) );
    }
    SECTION( "finish_end_removes_provider" ) {
        mission_dialogue::assign_selected_mission( conversation );
        definition.end = remove_provider;
        effect.set_effect( talk_effect_fun_t( []( dialogue & d ) {
            mission_dialogue::finish_mission_by_type_for_dialogue(
                d, mission_TEST_MISSION_GENERIC_REWARD, true, -1 );
        } ) );
    }
    SECTION( "finish_fail_removes_provider" ) {
        mission_dialogue::assign_selected_mission( conversation );
        definition.fail = remove_provider;
        effect.set_effect( talk_effect_fun_t( []( dialogue & d ) {
            mission_dialogue::finish_mission_by_type_for_dialogue(
                d, mission_TEST_MISSION_GENERIC_REWARD, false, -1 );
        } ) );
    }
    bool later_effect_ran = false;
    effect.set_effect( talk_effect_fun_t( [&]( dialogue & ) {
        later_effect_ran = true;
    } ) );
    CHECK( effect.apply( conversation ).id == "TALK_DONE" );
    CHECK_FALSE( later_effect_ran );
    CHECK( reference.resolve( g->npc_lifetimes() ) == nullptr );
    CHECK( conversation.actor( true )->get_npc() == nullptr );
    CHECK( conversation.const_actor( true )->selected_mission() == nullptr );
    const_dialogue copied( conversation );
    CHECK( copied.const_actor( true )->selected_mission() == nullptr );
}

TEST_CASE( "mission_dialogue_rejects_freed_objects_and_same_id_substitutes",
           "[npc_talk][mission][lifetime]" )
{
    clear_avatar();
    clear_map();
    mission::clear_all();
    npc &provider = create_test_talker();
    const on_out_of_scope cleanup( []() {
        mission::clear_all();
        clear_npcs();
    } );
    auto speaker = std::make_unique<npc>();
    speaker->normalize();
    speaker->setID( get_avatar().getID() );
    dialogue conversation( get_talker_for( *speaker ), get_talker_for( provider ) );
    CHECK( mission_dialogue::resolve_dialogue_character( conversation ) == speaker.get() );
    mission *task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, provider.getID() );
    provider.chatbin.missions = { task };
    conversation.actor( true )->select_mission( task );
    REQUIRE( conversation.const_actor( true )->selected_mission() == task );
    const int uid = task->get_id();
    REQUIRE( mission::remove_unassigned( uid ) );
    CHECK_FALSE( mission_dialogue::identify_mission( task ).is_set() );
    CHECK( conversation.const_actor( true )->selected_mission() == nullptr );
    CHECK( conversation.const_actor( true )->available_missions().empty() );
    CHECK( mission::to_uid_vector( provider.chatbin.missions ).empty() );
    speaker.reset();
    CHECK( mission_dialogue::resolve_dialogue_character( conversation ) == nullptr );
    const_dialogue copied( conversation );
    CHECK( mission_dialogue::resolve_dialogue_character( copied ) == nullptr );
    CHECK( copied.const_actor( true )->selected_mission() == nullptr );
    CHECK_FALSE( mission_dialogue::participants_live( copied ) );
}

TEST_CASE( "dialogue_training_uses_its_selected_reward_and_preserves_paid_training",
           "[npc_talk][mission][training]" )
{
    clear_avatar();
    clear_map();
    avatar &owner = get_avatar();
    owner.reset_all_missions();
    mission::clear_all();
    npc &teacher = create_test_talker();
    const on_out_of_scope cleanup( [&]() {
        owner.activity.set_to_null();
        owner.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    teacher.chatbin.skill = skill_driving;
    teacher.set_skill_level( skill_driving, 4 );
    owner.set_skill_level( skill_driving, 0 );
    teacher.op_of_u.owed = 1000000;
    mission *reward = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, teacher.getID() );
    reward->assign( owner );
    reward->wrap_up( owner );
    REQUIRE( reward->has_succeeded() );
    teacher.chatbin.missions_assigned = { reward };
    // A shared legacy selection must not silently turn ordinary training free.
    teacher.chatbin.mission_selected = reward;
    dialogue conversation( get_talker_for( owner ), get_talker_for( teacher ) );
    bool use_reward = false;
    SECTION( "selected_reward_does_not_charge_credit" ) {
        use_reward = true;
        conversation.actor( true )->select_mission( reward );
    }
    SECTION( "no_session_reward_uses_normal_payment" ) {}
    talk_effect_t start;
    start.set_effect( &talk_function::start_training );
    start.apply( conversation );
    CHECK( static_cast<bool>( owner.activity ) );
    CHECK( static_cast<bool>( teacher.activity ) );
    if( use_reward ) {
        CHECK( teacher.op_of_u.owed == 1000000 );
        CHECK( teacher.chatbin.missions_assigned.empty() );
        CHECK( conversation.const_actor( true )->selected_mission() == nullptr );
    } else {
        CHECK( teacher.op_of_u.owed < 1000000 );
        CHECK( teacher.chatbin.missions_assigned == std::vector<mission *> { reward } );
    }
}


TEST_CASE( "dialogue_total_kills_belongs_to_its_speaker", "[npc_talk][multiplayer][kills]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    npc &speaker = create_test_talker();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    host.get_kill_statistics().reset( { { mtype_id( "mon_zombie" ), 9 } }, {} );
    speaker.get_kill_statistics().reset( { { mtype_id( "mon_zombie" ), 2 } }, {} );
    std::string local_text = "<total_kills>";
    std::string remote_text = "<total_kills>";
    parse_tags( local_text, host, speaker );
    parse_tags( remote_text, speaker, host );
    CHECK( local_text == "9" );
    CHECK( remote_text == "2" );
}

TEST_CASE( "dialogue_choice_revalidates_and_commits_only_once", "[npc_talk][ownership]" )
{
    clear_avatar();
    clear_map();
    npc &provider = create_test_talker();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    dialogue conversation( get_talker_for( get_avatar() ), get_talker_for( provider ) );
    const talk_topic topic( "TALK_DONE" );
    conversation.gen_responses( topic );
    REQUIRE_FALSE( conversation.responses.empty() );
    const std::uint64_t old_revision = conversation.response_revision();
    conversation.gen_responses( topic );
    const std::uint64_t revision = conversation.response_revision();
    REQUIRE( revision != old_revision );
    int executions = 0;
    bool permitted = true;
    talk_response choice;
    choice.condition = [&]( const const_dialogue & ) {
        rng( 1, 100 );
        return permitted;
    };
    choice.success.next_topic = talk_topic( "TALK_DONE" );
    choice.success.set_effect( talk_effect_fun_t( [&]( dialogue & d ) {
        ++executions;
        CHECK_FALSE( d.select_response( 0, revision ) );
        d.gen_responses( topic );
        CHECK( d.response_revision() == revision );
        CHECK_FALSE( d.select_response( 0, d.response_revision() ) );
        rng( 1, 100 );
    } ) );
    conversation.responses = { choice };
    conversation.response_condition_exists = { true };
    conversation.response_condition_eval = { true };
    const auto before = rng_get_engine();
    conversation.responses.front().deferred_text_condition = []( dialogue & ) {
        return rng( 1, 100 ) > 0;
    };
    conversation.responses.front().create_option_line( conversation, input_event() );
    CHECK( rng_get_engine() == before );
    CHECK_FALSE( conversation.select_response( 9, revision ) );
    CHECK_FALSE( conversation.select_response( 0, old_revision ) );
    dialogue copy( conversation );
    CHECK_FALSE( copy.select_response( 0, revision ) );
    CHECK( rng_get_engine() == before );
    CHECK( executions == 0 );

    SECTION( "changed_condition_rejects_without_gameplay_randomness_or_effects" ) {
        permitted = false;
        CHECK_FALSE( conversation.select_response( 0, revision ) );
        CHECK( executions == 0 );
        CHECK( rng_get_engine() == before );
    }
    SECTION( "success_cannot_repeat_or_reenter" ) {
        const auto next = conversation.select_response( 0, revision );
        REQUIRE( next );
        CHECK( next->id == "TALK_DONE" );
        CHECK( executions == 1 );
        CHECK( rng_get_engine() != before );
        const auto after = rng_get_engine();
        CHECK_FALSE( conversation.select_response( 0, revision ) );
        CHECK( executions == 1 );
        CHECK( rng_get_engine() == after );
    }
}

TEST_CASE( "dialogue_opens_native_topics_only_once", "[npc_talk]" )
{
    clear_avatar();
    int topic_queries = 0;
    class counting_talker : public talker_topic
    {
        public:
            explicit counting_talker( int &queries ) : queries_( queries ) {}
            std::vector<std::string> get_topics( bool ) const override {
                ++queries_;
                return {};
            }
        private:
            int &queries_;
    };
    CHECK( get_avatar().talk_to( std::make_unique<counting_talker>( topic_queries ) ) ==
           avatar_talk_to_result::not_started );
    CHECK( topic_queries == 1 );
}

TEST_CASE( "dialogue_choice_rejects_mission_taken_by_another_player",
           "[npc_talk][mission][ownership]" )
{
    clear_avatar();
    clear_map();
    avatar &owner = get_avatar();
    owner.reset_all_missions();
    mission::clear_all();
    npc &provider = create_test_talker();
    npc remote;
    remote.setID( character_id( 87433 ) );
    const on_out_of_scope cleanup( [&]() {
        remote.reset_all_missions();
        owner.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission_type &definition = const_cast<mission_type &>( mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_start( definition.start );
    definition.start = []( mission *, Character & ) {};
    mission *task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, provider.getID() );
    provider.chatbin.missions = { task };
    dialogue first( get_talker_for( owner ), get_talker_for( provider ) );
    first.gen_responses( talk_topic( "TALK_MISSION_LIST" ) );
    const auto offered = std::find_if( first.responses.begin(), first.responses.end(),
    [task]( const talk_response & response ) {
        return response.mission_selected_uid == task->get_id();
    } );
    REQUIRE( offered != first.responses.end() );
    const std::size_t index = std::distance( first.responses.begin(), offered );
    dialogue second( get_talker_for( remote ), get_talker_for( provider ) );
    second.actor( true )->select_mission( task );
    mission_dialogue::assign_selected_mission( second );
    REQUIRE( task->get_assigned_player_id() == remote.getID() );
    const auto before = rng_get_engine();
    CHECK_FALSE( first.select_response( index, first.response_revision() ) );
    CHECK( first.actor( true )->selected_mission() == nullptr );
    CHECK( owner.get_active_missions().empty() );
    CHECK( task->get_assigned_player_id() == remote.getID() );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "dialogue_choice_stops_after_participant_removal", "[npc_talk][lifetime]" )
{
    clear_avatar();
    clear_map();
    npc &provider = create_test_talker();
    const character_id provider_id = provider.getID();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    dialogue conversation( get_talker_for( get_avatar() ), get_talker_for( provider ) );
    conversation.gen_responses( talk_topic( "TALK_DONE" ) );
    REQUIRE_FALSE( conversation.responses.empty() );
    talk_response choice;
    choice.success.set_effect( talk_effect_fun_t( [provider_id]( dialogue & ) {
        g->remove_npc( provider_id );
    } ) );
    bool later_effect_ran = false;
    choice.success.set_effect( talk_effect_fun_t( [&]( dialogue & ) {
        later_effect_ran = true;
    } ) );
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    bool lua_ran = false;
    choice.lua_response_id = cata::lua_platform::dialogue::register_response_callback(
                                 cata::lua_platform::dialogue::response_callback_origin::platform,
    [&]( dialogue &, const talk_topic & fallback, bool ) {
        lua_ran = true;
        return fallback;
    } );
    const on_out_of_scope clear_callbacks( []() {
        cata::lua_platform::dialogue::clear_response_callbacks();
    } );
#endif
    conversation.responses = { choice };
    conversation.response_condition_exists = { false };
    conversation.response_condition_eval = { true };
    const auto next = conversation.select_response( 0, conversation.response_revision() );
    REQUIRE( next );
    CHECK( next->id == "TALK_DONE" );
    CHECK_FALSE( later_effect_ran );
    CHECK( conversation.actor( true )->get_npc() == nullptr );
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    CHECK_FALSE( lua_ran );
#endif
}

TEST_CASE( "dialogue_native_topic_actions_run_once_outside_text_preview",
           "[npc_talk][ownership]" )
{
    clear_avatar();
    clear_map();
    npc &provider = create_test_talker();
    npc remote;
    clear_character( remote );
    remote.setID( character_id( 87434 ), true );
    remote.setpos( get_map(), tripoint_bub_ms( 26, 25, 0 ) );
    remote.set_underwater( true );
    remote.oxygen = 200;
    const on_out_of_scope cleanup( []() {
        sounds::reset_sounds();
        clear_npcs();
    } );
    avatar &host = get_avatar();
    const int host_oxygen = host.oxygen;
    dialogue conversation( get_talker_for( remote ), get_talker_for( provider ) );
    const auto preview_rng = rng_get_engine();
    CHECK_FALSE( conversation.dynamic_line( talk_topic( "TALK_SHOUT" ) ).empty() );
    CHECK( remote.oxygen == 200 );
    CHECK( rng_get_engine() == preview_rng );
    REQUIRE( conversation.begin_conversation( false, "TALK_SHOUT", true ) ==
             dialogue_start_result::started );
    REQUIRE( conversation.prepare_topic() );
    const int after_shout = remote.oxygen;
    CHECK( after_shout == 200 - remote.get_shout_volume() );
    CHECK( host.oxygen == host_oxygen );
    const auto revision = conversation.response_revision();
    const auto after_rng = rng_get_engine();
    const std::string line = conversation.prepared_challenge();
    REQUIRE( conversation.prepare_topic() );
    CHECK( remote.oxygen == after_shout );
    CHECK( conversation.prepared_challenge() == line );
    CHECK( conversation.response_revision() == revision );
    CHECK( rng_get_engine() == after_rng );
    conversation.finish_conversation();
    conversation.finish_conversation();
    CHECK_FALSE( conversation.prepare_topic() );
    CHECK_FALSE( conversation.select_response( 0, revision ) );
    CHECK( remote.oxygen == after_shout );
}

TEST_CASE( "dialogue_native_lifecycle_rejects_a_retired_participant",
           "[npc_talk][lifetime]" )
{
    clear_avatar();
    clear_map();
    npc &provider = create_test_talker();
    const character_id provider_id = provider.getID();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    dialogue conversation( get_talker_for( get_avatar() ), get_talker_for( provider ) );
    REQUIRE( conversation.begin_conversation( false, "TALK_TEST_START", true ) ==
             dialogue_start_result::started );
    SECTION( "removal_before_first_snapshot" ) {
        g->remove_npc( provider_id );
        CHECK_FALSE( conversation.prepare_topic() );
    }
    SECTION( "removal_after_preparing_choices" ) {
        REQUIRE( conversation.prepare_topic() );
        const auto revision = conversation.response_revision();
        g->remove_npc( provider_id );
        const auto next = conversation.select_response( 0, revision );
        REQUIRE( next );
        CHECK( next->id == "TALK_DONE" );
        CHECK_FALSE( conversation.advance_conversation( *next ) );
    }
    conversation.finish_conversation();
    CHECK( conversation.done );
    CHECK_FALSE( conversation.prepare_topic() );
}

TEST_CASE( "dialogue_npc_services_use_session_character_ownership",
           "[npc_talk][multiplayer]" )
{
    clear_avatar();
    clear_map();
    npc &provider = create_test_talker();
    npc &remote = create_test_talker();
    remote.name = "Remote Player";
    remote.setpos( get_map(), tripoint_bub_ms( 26, 25, 0 ) );

    const on_out_of_scope cleanup( [&]() {
        remote.reset_all_missions();
        get_avatar().reset_all_missions();
        clear_npcs();
    } );

    avatar &host = get_avatar();
    host.cash = 1000;
    remote.cash = 2000;
    provider.op_of_u.owed = 50000;
    provider.opinion_of( remote.getID() ).owed = 50000;

    SECTION( "session_training_selection_and_remote_paid_or_reward_training" ) {
        const skill_id skill_speech( "speech" );
        provider.set_skill_level( skill_driving, 5 );
        provider.set_skill_level( skill_speech, 5 );
        host.set_skill_level( skill_driving, 0 );
        host.set_skill_level( skill_speech, 0 );
        remote.set_skill_level( skill_driving, 0 );
        remote.set_skill_level( skill_speech, 0 );

        dialogue remote_d( get_talker_for( remote ), get_talker_for( provider ) );
        dialogue host_d( get_talker_for( host ), get_talker_for( provider ) );

        remote_d.actor( true )->store_chosen_training(
            skill_driving, matype_id(), spell_id(), proficiency_id() );
        host_d.actor( true )->store_chosen_training(
            skill_speech, matype_id(), spell_id(), proficiency_id() );

        CHECK( remote_d.const_actor( true )->chosen_training_skill() == skill_driving );
        CHECK( host_d.const_actor( true )->chosen_training_skill() == skill_speech );

        const int host_owed_before = provider.op_of_u.owed;
        const int remote_owed_before = provider.opinion_of( remote.getID() ).owed;

        talk_effect_t train_effect;
        train_effect.set_effect( &talk_function::start_training );
        train_effect.apply( remote_d );

        CHECK( provider.op_of_u.owed == host_owed_before );
        CHECK( provider.opinion_of( remote.getID() ).owed < remote_owed_before );
        CHECK( remote.activity.id() == activity_id( "ACT_TRAIN" ) );
        CHECK_FALSE( host.activity.id() == activity_id( "ACT_TRAIN" ) );

        remote.cancel_activity();
        provider.cancel_activity();

        mission *reward_miss = mission::reserve_new(
                                   mission_type_id( "TEST_MISSION_GENERIC_REWARD" ),
                                   provider.getID() );
        REQUIRE( reward_miss != nullptr );
        provider.chatbin.missions.push_back( reward_miss );
        remote_d.actor( true )->select_mission( reward_miss );
        mission_dialogue::assign_selected_mission( remote_d );
        remote.i_add( item( itype_id( "test_rock" ) ) );
        REQUIRE( reward_miss->is_complete( provider.getID(), remote ) );

        const int remote_owed_after_paid = provider.opinion_of( remote.getID() ).owed;
        remote_d.actor( true )->store_chosen_training(
            skill_speech, matype_id(), spell_id(), proficiency_id() );
        train_effect.apply( remote_d );

        CHECK( provider.opinion_of( remote.getID() ).owed == remote_owed_after_paid );
        CHECK( provider.chatbin.missions_assigned.empty() );
        CHECK( remote.activity.id() == activity_id( "ACT_TRAIN" ) );
    }

    SECTION( "remote_mission_reward_credits_remote_debt_without_host_ui" ) {
        mission *miss = mission::reserve_new(
                            mission_type_id( "TEST_MISSION_GENERIC_REWARD" ),
                            provider.getID() );
        REQUIRE( miss != nullptr );
        provider.chatbin.missions.push_back( miss );
        dialogue remote_d( get_talker_for( remote ), get_talker_for( provider ) );
        remote_d.actor( true )->select_mission( miss );
        mission_dialogue::assign_selected_mission( remote_d );

        const int host_owed_before = provider.op_of_u.owed;
        const int remote_owed_before = provider.opinion_of( remote.getID() ).owed;

        talk_effect_t reward_effect;
        reward_effect.set_effect( &talk_function::mission_reward );
        reward_effect.apply( remote_d );

        CHECK( miss->generic_reward_claimed() );
        CHECK( provider.op_of_u.owed == host_owed_before );
        CHECK( provider.opinion_of( remote.getID() ).owed ==
               remote_owed_before + miss->get_value() );
    }

    SECTION( "remote_offer_cannot_take_the_hosts_item" ) {
        host.wield( host.i_add( item( itype_knife_huge ) ) );
        item_location offered = host.get_wielded_item();
        REQUIRE( offered );
        talker_npc receiver( &provider );
        receiver.bind_interlocutor( remote.getID(), &remote );
        CHECK( receiver.give_item_to( offered, false ) ==
               _( "Offering items is not available in remote dialogue yet." ) );
        CHECK( offered.held_by( host ) );
        CHECK( host.is_wielding( *offered ) );
    }

    SECTION( "remote_buy_from_follow_and_services_target_remote_character" ) {
        dialogue remote_d( get_talker_for( remote ), get_talker_for( provider ) );

        const int host_owed_before = provider.op_of_u.owed;
        const int remote_owed_before = provider.opinion_of( remote.getID() ).owed;
        CHECK( remote_d.actor( true )->buy_from( 1500 ) );
        CHECK( provider.op_of_u.owed == host_owed_before );
        CHECK( provider.opinion_of( remote.getID() ).owed == remote_owed_before - 1500 );

        provider.cash = 750;
        const int host_cash_before = host.cash;
        const int remote_cash_before = remote.cash;
        CHECK( remote_d.actor( true )->enslave_mind() );
        CHECK( host.cash == host_cash_before );
        CHECK( remote.cash == remote_cash_before + 750 );
        CHECK( provider.cash == 0 );

        talk_effect_t haircut_effect;
        haircut_effect.set_effect( &talk_function::buy_haircut );
        haircut_effect.apply( remote_d );
        CHECK( remote.has_morale( morale_haircut ) > 0 );
        CHECK( host.has_morale( morale_haircut ) == 0 );

        remote.wield( remote.i_add( item( itype_knife_huge ) ) );
        host.wield( host.i_add( item( itype_knife_huge ) ) );
        REQUIRE( remote.is_armed() );
        REQUIRE( host.is_armed() );
        talk_effect_t drop_weap_effect;
        drop_weap_effect.set_effect( &talk_function::player_weapon_drop );
        drop_weap_effect.apply( remote_d );
        CHECK_FALSE( remote.is_armed() );
        CHECK( host.is_armed() );
    }
}
