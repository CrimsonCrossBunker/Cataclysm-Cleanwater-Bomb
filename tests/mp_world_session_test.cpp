#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "creature_tracker.h"
#include "current_map.h"
#include "debug.h"
#include "character_martial_arts.h"
#include "flag.h"
#include "effect.h"
#include "game.h"
#include "json_loader.h"
#include "json.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "monster.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_melee.h"
#include "mp_combat_result.h"
#include "skill.h"
#include "item_uid.h"
#include "mp_protocol.h"
#include "mp_queue.h"
#include "mp_world_session.h"
#include "mp_test_helpers.h"
#include "rng.h"
#include "recipe.h"
#include "avatar.h"
#include "activity_actor_definitions.h"
#include "calendar.h"
#include "cata_utility.h"
#include "filesystem.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "player_helpers.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "worldfactory.h"
#include <algorithm>
#include <filesystem>
#include <map>
#include <set>
#include <sstream>
#include <thread>
#include "player_activity.h"

namespace
{
cata_mp::player_id test_player()
{
    return cata_mp::player_id( std::string( 32, '7' ) );
}

npc &bind_test_player( cata_mp::world_session &session )
{
    make_test_remote( session );
    npc &actor = spawn_npc( { 60, 60 }, "test_talker" );
    actor.set_value( "mp_proxy", std::string( "1" ) );
    actor.set_value( "mp_player_id", test_player().str() );
    only_test_remote( session ).actor.bind_player( actor, test_player(), g->npc_lifetimes(),
            g->player_controls().claim( test_player(), actor ) );
    return actor;
}

std::string initial_player_packet( const std::string &name )
{
    const restore_on_out_of_scope restore_name( get_avatar().name );
    get_avatar().name = name;
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_object();
    out.member( "action", "player_create" );
    out.member( "player_state" );
    get_avatar().store_player_state( out );
    out.end_object();
    return encoded.str();
}

void finish_player_creation( const cata_mp::peer_admission &admission, const std::string &name )
{
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                           initial_player_packet( name ), admission } ) );
    cata_mp::process_mp_events();
}

void bind_test_view( cata_mp::world_session &session )
{
    npc &actor = spawn_npc( { 61, 60 }, "test_talker" );
    actor.set_value( "mp_proxy", std::string( "1" ) );
    session.client_host_actor.bind_view( actor, g->npc_lifetimes() );
}
} // namespace

TEST_CASE( "mp_cleanup_never_claims_npcs_by_name_or_unverified_cleanup_ids",
           "[multiplayer][world_session][player_identity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    const auto cleanup_path = PATH_INFO::world_base_save_path() / "mp_npc_cleanup.json";
    REQUIRE_FALSE( file_exist( cleanup_path ) );
    const on_out_of_scope cleanup( [&]() {
        clear_npcs();
        remove_file( cleanup_path );
        session.reset();
    } );
    npc &same_name = spawn_npc( { 60, 60 }, "test_talker" );
    same_name.name = get_avatar().name;
    const auto same_id = same_name.getID();
    npc &default_name = spawn_npc( { 61, 60 }, "test_talker" );
    default_name.name = "player2";
    const auto default_id = default_name.getID();
    npc &proxy = spawn_npc( { 62, 60 }, "test_talker" );
    proxy.name = same_name.name;
    proxy.set_value( "mp_proxy", std::string( "1" ) );
    const auto proxy_id = proxy.getID();
    write_to_file( cleanup_path, [&]( std::ostream & out ) {
        // Old metadata is not sufficient evidence: IDs may have been reused.
        out << "{\"ids\":[" << same_id.get_value() << "],\"names\":[\"player2\"]}";
    } );
    session.stale_proxy_cleanup_done = false;
    cata_mp::mp_cleanup_stale_npcs_after_load();
    CHECK( g->critter_by_id<npc>( same_id ) != nullptr );
    CHECK( g->critter_by_id<npc>( default_id ) != nullptr );
    CHECK( g->critter_by_id<npc>( proxy_id ) == nullptr );
    CHECK_FALSE( overmap_buffer.find_npc( proxy_id ) );
    CHECK( session.stale_proxy_cleanup_done );
}

TEST_CASE( "mp_native_export_reassigns_retained_monsters_after_session_reset",
           "[multiplayer][world_session][entity_identity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        get_creature_tracker().clear();
    } );
    npc &remote = bind_test_player( session );
    only_test_remote( session ).connected = true;
    auto first = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                                            tripoint_bub_ms( 62, 60, 0 ) );
    auto second = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                  tripoint_bub_ms( 63, 60, 0 ) );
    REQUIRE( get_creature_tracker().add( first ) );
    REQUIRE( get_creature_tracker().add( second ) );
    const auto exported_ids = [&]() {
        JsonValue value = json_loader::from_string( cata_mp::serialize_remote_player_state(
                              only_test_remote( session ) ) );
        JsonObject state = value.get_object();
        state.allow_omitted_members();
        std::vector<int> result;
        for( JsonObject mon : state.get_array( "monsters" ) ) {
            mon.allow_omitted_members();
            result.push_back( mon.get_int( "nid" ) );
        }
        return result;
    };
    REQUIRE( exported_ids().size() == 2 );
    REQUIRE( session.replication.entity_ids.known_id( *first ) != 0 );
    REQUIRE( session.replication.entity_ids.known_id( *second ) != 0 );
    // Closing/reopening retains native monsters. The former object-owned wire
    // fields survived allocator reset and let a new arrival reuse ID 1.
    session.reset();
    make_test_remote( session );
    only_test_remote( session ).actor.bind_player( remote, test_player(), g->npc_lifetimes(),
            g->player_controls().claim( test_player(), remote ) );
    only_test_remote( session ).connected = true;
    auto arrival = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                   tripoint_bub_ms( 64, 60, 0 ) );
    REQUIRE( get_creature_tracker().add( arrival ) );
    const auto ids = exported_ids();
    REQUIRE( ids.size() == 3 );
    CHECK( std::set<int>( ids.begin(), ids.end() ).size() == 3 );
    CHECK( session.replication.entity_ids.known_id( *first ) !=
           session.replication.entity_ids.known_id( *arrival ) );
    CHECK( session.replication.entity_ids.known_id( *second ) !=
           session.replication.entity_ids.known_id( *arrival ) );
}

TEST_CASE( "mp_three_remote_players_keep_actions_baselines_and_reconnects_separate",
           "[multiplayer][world_session][peer_session][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const std::vector<cata_mp::player_credentials> profiles = {
        { player_id( std::string( 32, '4' ) ), std::string( 64, 'a' ) },
        { player_id( std::string( 32, '5' ) ), std::string( 64, 'b' ) },
        { player_id( std::string( 32, '6' ) ), std::string( 64, 'c' ) }
    };
    std::vector<cata_path> records;
    for( const auto &profile : profiles ) {
        records.push_back( PATH_INFO::world_base_save_path() / ( "mp_actor_" + profile.id.str() +
                           ".json" ) );
        REQUIRE_FALSE( file_exist( records.back() ) );
    }
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        get_creature_tracker().clear();
        for( const auto &record : records ) {
            remove_file( record );
        }
        remove_file( PATH_INFO::world_base_save_path() / "mp_npc_cleanup.json" );
    } );
    std::vector<cata_mp::peer_admission> admissions;
    for( size_t i = 0; i < profiles.size(); ++i ) {
        admissions.push_back( cata_mp::peer_admission::create( 801 + i ) );
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::connect,
                                               "same display name", "", admissions.back(), profiles[i] } ) );
    }
    cata_mp::process_mp_events();
    REQUIRE( session.remote_players.size() == 3 );
    for( size_t i = 0; i < admissions.size(); ++i ) {
        const auto *pending = session.find_remote( admissions[i] );
        REQUIRE( pending );
        REQUIRE( pending->awaiting_character );
        CHECK_FALSE( pending->actor.id().is_valid() );
        CHECK_FALSE( file_exist( records[i] ) );
        finish_player_creation( admissions[i], i == 0 ? "first owner" :
                                i == 1 ? "second owner" : "third owner" );
    }
    auto *first = session.find_remote( admissions[0] );
    auto *second = session.find_remote( admissions[1] );
    auto *third = session.find_remote( admissions[2] );
    REQUIRE( first );
    REQUIRE( second );
    REQUIRE( third );
    npc *first_actor = first->actor.retained( g->npc_lifetimes() );
    npc *second_actor = second->actor.retained( g->npc_lifetimes() );
    npc *third_actor = third->actor.retained( g->npc_lifetimes() );
    REQUIRE( first_actor );
    REQUIRE( second_actor );
    REQUIRE( third_actor );
    CHECK( first_actor->getID() != second_actor->getID() );
    CHECK( first_actor->pos_abs() != second_actor->pos_abs() );
    CHECK( second_actor->pos_abs() != third_actor->pos_abs() );
    const auto send = [&]( const cata_mp::peer_admission & admission, const std::string & message ) {
        const auto *peer = session.find_remote( admission );
        const auto packet = peer ? test_granted_action( message, peer->turn.grant_seq ) : message;
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action,
                                               "same display name", packet, admission } ) );
    };
    send( admissions[0], R"({"action":"wait"})" );
    send( admissions[1], R"({"action":"wait"})" );
    cata_mp::process_mp_events();
    CHECK( first_actor->name == "first owner" );
    CHECK( second_actor->name == "second owner" );
    CHECK( first->turn.client_acted_this_turn );
    CHECK( second->turn.client_acted_this_turn );
    CHECK_FALSE( third->turn.client_acted_this_turn );
    CHECK_FALSE( cata_mp::client_acted_this_turn() );
    send( admissions[2], R"({"action":"wait"})" );
    cata_mp::process_mp_events();
    CHECK( cata_mp::client_acted_this_turn() );

    get_avatar().setpos( get_map(), tripoint_bub_ms( 70, 70, 0 ) );
    first_actor->setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    second_actor->setpos( get_map(), tripoint_bub_ms( 61, 60, 0 ) );
    third_actor->setpos( get_map(), tripoint_bub_ms( 63, 60, 0 ) );
    const auto third_position = third_actor->pos_abs();
    next_test_remote_turn( *first );
    send( admissions[0], "{\"action\":\"swap_with_partner\",\"target_player\":\"" +
          profiles[1].id.str() + "\",\"char_stats\":{\"name\":\"forged\"}}" );
    cata_mp::process_mp_events();
    CHECK( first_actor->pos_bub() == tripoint_bub_ms( 61, 60, 0 ) );
    CHECK( second_actor->pos_bub() == tripoint_bub_ms( 60, 60, 0 ) );
    CHECK( third_actor->pos_abs() == third_position );
    CHECK( first_actor->name == "first owner" );
    CHECK( second->turn.pending_partner_swap );
    CHECK_FALSE( third->turn.pending_partner_swap );

    auto zed = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                                          tripoint_bub_ms( 65, 60, 0 ) );
    REQUIRE( get_creature_tracker().add( zed ) );
    const auto export_monsters = [&]( cata_mp::remote_player_session & peer ) {
        const JsonValue value = json_loader::from_string( cata_mp::serialize_remote_player_state( peer ) );
        const JsonObject state = value.get_object();
        state.allow_omitted_members();
        CHECK( state.get_array( "players" ).size() == 2 );
        return state.get_array( "monsters" ).size();
    };
    CHECK( export_monsters( *first ) == 1 );
    CHECK( export_monsters( *first ) == 0 );
    CHECK( export_monsters( *second ) == 1 );
    const auto second_baseline = second->replication.server_mon_last_sent;

    // Helpers commit to one stable player, not whichever avatar is nearest.
    first->observation.partner_activity = "ACT_HELP_PARTNER";
    first->observation.partner_help_target = third->credentials.id.str();
    CHECK( cata_mp::is_partner_helping( first_actor->getID(), third_actor->getID() ) );
    CHECK_FALSE( cata_mp::is_partner_helping( first_actor->getID(), second_actor->getID() ) );
    get_avatar().setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    third->observation.partner_activity = "ACT_CRAFT";
    third->observation.partner_activity_moves_total = 20000;
    third->observation.partner_activity_pct = 53;
    REQUIRE( activity_id( "ACT_HELP_PARTNER" ).is_valid() );
    REQUIRE( cata_mp::start_helping_partner( third_actor->getID() ) );
    third_actor->setpos( get_map(), tripoint_bub_ms( 64, 60, 0 ) );
    second->observation.partner_activity_pct = 17;
    CHECK( cata_mp::partner_activity_pct() == 53 );
    send( admissions[1], R"({"action":"activity_end","client_activity":""})" );
    cata_mp::process_mp_events();
    CHECK( get_avatar().activity.id().str() == "ACT_HELP_PARTNER" );
    send( admissions[2], R"({"action":"activity_end","client_activity":""})" );
    cata_mp::process_mp_events();
    CHECK_FALSE( get_avatar().activity );

    first->observation.partner_activity = "ACT_CRAFT";
    REQUIRE( cata_mp::start_helping_partner( first_actor->getID() ) );
    const character_id retained_id = first_actor->getID();
    const uint32_t previous_sequence = first->turn.grant_seq;
    admissions[0].retire();
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect,
                                           "same display name", "", admissions[0] } ) );
    cata_mp::process_mp_events();
    CHECK_FALSE( session.find_remote( admissions[0] ) );
    CHECK_FALSE( get_avatar().activity );
    CHECK( session.find_remote( admissions[1] ) == second );
    CHECK( second->replication.server_mon_last_sent == second_baseline );
    const auto replacement = cata_mp::peer_admission::create( 801 );
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::connect,
                                           "new nickname", "", replacement, profiles[0] } ) );
    cata_mp::process_mp_events();
    first = session.find_remote( replacement );
    REQUIRE( first );
    CHECK( first->actor.id() == retained_id );
    CHECK( first->turn.grant_seq > previous_sequence );
    CHECK( first->replication.server_mon_last_sent.empty() );
    send( admissions[0], R"({"action":"activity_start","activity_id":"ACT_CRAFT"})" );
    cata_mp::process_mp_events();
    CHECK( first->actor.retained( g->npc_lifetimes() )->name == "first owner" );
    CHECK( second_actor->name == "second owner" );
    CHECK( first->observation.partner_activity.empty() );
}

TEST_CASE( "mp_player_view_rebuild_preserves_rng_and_does_not_create_a_controller",
           "[multiplayer][world_session][peer_session][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    npc source;
    source.normalize();
    source.name = "other player";
    source.spawn_at_precise( get_map().get_abs( tripoint_bub_ms( 62, 62, 0 ) ) );
    source.set_wielded_item( item( itype_id( "rock" ) ) );
    source.add_effect( efftype_id( "glowing" ), 10_turns );
    REQUIRE( source.active_light() > 0.0f );
    cata_mp::peer_observation observation;
    observation.partner_activity = "ACT_CRAFT";
    observation.partner_activity_pct = 35;
    cata_mp::player_view view;
    const on_out_of_scope cleanup( [&]() {
        cata_mp::remove_player_view( view );
    } );
    std::string baseline;
    const auto encode = [&]() {
        std::ostringstream stream;
        JsonOut out( stream );
        cata_mp::write_player_view( out, test_player(), source, observation, baseline );
        return stream.str();
    };
    const auto initial = json_loader::from_string( encode() );
    const auto before = rng_get_engine();
    cata_mp::apply_player_view( initial.get_object(), view );
    CHECK( rng_get_engine() == before );
    npc *replica = view.actor.retained( g->npc_lifetimes() );
    REQUIRE( replica );
    CHECK_FALSE( g->player_controls().is_claimed( *replica ) );
    CHECK( replica->name == source.name );
    REQUIRE( replica->get_wielded_item() );
    CHECK( replica->get_wielded_item()->uid() == source.get_wielded_item()->uid() );
    CHECK( view.observation.partner_activity_pct == 35 );
    CHECK( view.observation.mp_remote_player_luminance == source.active_light() );
    const character_id id = replica->getID();
    source.spawn_at_precise( get_map().get_abs( tripoint_bub_ms( 63, 62, 0 ) ) );
    const auto moved = json_loader::from_string( encode() );
    JsonObject delta = moved.get_object();
    delta.allow_omitted_members();
    CHECK_FALSE( delta.has_object( "appearance" ) );
    cata_mp::apply_player_view( delta, view );
    CHECK( view.actor.id() == id );
    CHECK( replica->pos_abs() == source.pos_abs() );
    CHECK( rng_get_engine() == before );
    cata_mp::remove_player_view( view );
    CHECK_FALSE( g->critter_by_id<npc>( id ) );
    CHECK_FALSE( overmap_buffer.find_npc( id ) );
}

TEST_CASE( "mp_bookkeeping_classification_uses_only_the_message_envelope",
           "[multiplayer][world_session][action_budget]" )
{
    for( const char *message : {
             R"({"action":"activity_start","activity_id":"ACT_WAIT"})",
             R"({"action":"activity_end","activity_id":"ACT_WAIT"})",
             R"({"action":"save_request"})",
             R"({ "type" : "action", "action" : "activity_end", "activity_id":"ACT_WAIT" })",
             R"({"type":"note_sync"})", R"({"type":"chat"})",
             R"({"type":"templates_list"})"
         } ) {
        CAPTURE( message );
        CHECK( cata_mp::is_state_sync_message( message ) );
    }
    for( const char *message : {
             R"({"type":"trade_delta","give":[]})",
             R"({"action":"worn_sync"})", R"({"type":"resync_request"})",
             R"({"action":"wait","client_tile_changes":[]})",
             R"({"type":"action","action":"move","item":{"action":"worn_sync"}})",
             R"({"action":"wait","item":{"type":"trade_delta"}})",
             R"({"type":"chat","action":"wait"})",
             R"({"action":"worn_sync","action":"wait"})",
             R"({"type":"chat","type":"action"})",
             R"({"type":"chat"} {})", R"({"action":42})",
             R"({"client_tile_changes":[]})", R"({})", R"([])", R"({)"
         } ) {
        CAPTURE( message );
        CHECK_FALSE( cata_mp::is_state_sync_message( message ) );
    }
}

TEST_CASE( "mp_action_budget_preserves_queued_actions_and_bookkeeping_order",
           "[multiplayer][world_session][action_budget][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        cata_mp::get_mp_queue().clear();
    } );
    bind_test_player( session );
    only_test_remote( session ).connected = true;
    set_test_admission( session, cata_mp::peer_admission::create( 701 ) );
    const std::string attached_delta = GENERATE( false, true ) ?
                                       R"(,"client_tile_changes":[])" : "";
    auto &queue = cata_mp::get_mp_queue();
    const auto push = [&]( const std::string & data, const cata_mp::peer_admission & admission,
    uint32_t sequence = 1 ) {
        REQUIRE( queue.push( { cata_mp::mp_event::type::action, "nickname",
                               test_granted_action( data, sequence ), admission } ) );
    };
    push( R"({"action":"wait","client_calendar_turn":100)" + attached_delta + "}",
          only_test_remote( session ).admission );
    push( R"({"action":"activity_start","activity_id":"ACT_WAIT"})",
          only_test_remote( session ).admission );
    // Stale events do not consume the current peer's budget or block its queue.
    push( R"({"action":"wait","client_calendar_turn":300})",
          cata_mp::peer_admission::create( 702 ) );
    push( R"({"action":"wait","client_calendar_turn":200)" + attached_delta + "}",
          only_test_remote( session ).admission, 2 );
    push( R"({"action":"activity_start","activity_id":"ACT_WAIT_STAMINA"})",
          only_test_remote( session ).admission );

    cata_mp::process_mp_events();
    CHECK( only_test_remote( session ).observation.partner_calendar_turn == 100 );
    CHECK( only_test_remote( session ).observation.partner_activity == "ACT_WAIT" );
    REQUIRE_FALSE( queue.empty() );

    next_test_remote_turn( only_test_remote( session ) );
    cata_mp::process_mp_events();
    CHECK( only_test_remote( session ).observation.partner_calendar_turn == 200 );
    CHECK( only_test_remote( session ).observation.partner_activity == "ACT_WAIT_STAMINA" );
    CHECK( queue.empty() );
}

TEST_CASE( "mp_bookkeeping_backlog_yields_without_losing_order_or_large_messages",
           "[multiplayer][world_session][inbound_budget][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        cata_mp::get_mp_queue().clear();
    } );
    bind_test_player( session );
    auto &activity = only_test_remote( session ).observation.partner_activity;
    only_test_remote( session ).connected = true;
    set_test_admission( session, cata_mp::peer_admission::create( 701 ) );
    auto &queue = cata_mp::get_mp_queue();
    const auto push_sync = [&]( int index, size_t padding ) {
        const std::string data = R"({"action":"activity_start","activity_id":"ACT_WAIT_)" +
                                 std::to_string( index ) + R"(","padding":")" +
                                 std::string( padding, 'x' ) + R"("})";
        REQUIRE( queue.push( { cata_mp::mp_event::type::action, "nickname", data,
                               only_test_remote( session ).admission } ) );
    };

    SECTION( "a flood of small syncs yields before the final update" ) {
        for( int i = 0; i < 65; ++i ) {
            push_sync( i, 0 );
        }
        cata_mp::process_mp_events();
        CHECK( activity == "ACT_WAIT_63" );
        CHECK( queue.current_usage().queued == 1 );
        cata_mp::process_mp_events();
        CHECK( activity == "ACT_WAIT_64" );
        CHECK( queue.empty() );
    }
    SECTION( "large syncs share a byte budget" ) {
        push_sync( 0, 600 * 1024 );
        push_sync( 1, 600 * 1024 );
        cata_mp::process_mp_events();
        CHECK( activity == "ACT_WAIT_0" );
        CHECK( queue.current_usage().queued == 1 );
        cata_mp::process_mp_events();
        CHECK( activity == "ACT_WAIT_1" );
        CHECK( queue.empty() );
    }
    SECTION( "one oversized sync progresses without starving the queue" ) {
        push_sync( 0, 1024 * 1024 + 64 );
        push_sync( 1, 0 );
        cata_mp::process_mp_events();
        CHECK( activity == "ACT_WAIT_0" );
        CHECK( queue.current_usage().queued == 1 );
        cata_mp::process_mp_events();
        CHECK( activity == "ACT_WAIT_1" );
        CHECK( queue.empty() );
    }
    SECTION( "discarding stale events also yields" ) {
        const auto stale = cata_mp::peer_admission::create( 702 );
        for( int i = 0; i < 65; ++i ) {
            REQUIRE( queue.push( { cata_mp::mp_event::type::action, "nickname",
                                   R"({"action":"activity_start","activity_id":"ACT_WAIT"})", stale } ) );
        }
        cata_mp::process_mp_events();
        CHECK( activity.empty() );
        CHECK( queue.current_usage().queued == 1 );
        cata_mp::process_mp_events();
        CHECK( activity.empty() );
        CHECK( queue.empty() );
    }
}

TEST_CASE( "mp_turn_grants_reject_repeats_future_actions_and_stale_payloads",
           "[multiplayer][turn_coordination][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
    } );
    npc &actor = bind_test_player( session );
    auto &peer = only_test_remote( session );
    peer.connected = true;
    peer.turn.grant_seq = 41;
    const auto send = [&]( uint32_t grant, const std::string &message ) {
        const auto packet = test_granted_action( message, grant );
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action,
                                               "player", packet, peer.admission } ) );
        cata_mp::process_mp_events();
    };
    const auto wait = [&]( uint32_t grant, int client_turn ) {
        send( grant, R"({"action":"wait","client_calendar_turn":)" + std::to_string( client_turn ) +
              R"(,"move_mode":"run","char_stats":{"name":"forged","str":99},"client_stamina":1,"client_bleed":[]})" );
    };
    const auto initial_turn = peer.observation.partner_calendar_turn;
    const auto original_mode = actor.current_movement_mode();
    REQUIRE( original_mode != move_mode_id( "run" ) );
    const std::string original_name = actor.name;
    const int original_strength = actor.get_str_base();
    const efftype_id bleed( "bleed" );
    const bodypart_id arm = bodypart_str_id( "arm_l" ).id();
    actor.add_effect( bleed, 3_turns, arm );
    actor.set_stamina( 500 );
    wait( 40, 100 );
    wait( 42, 200 );
    CHECK( peer.observation.partner_calendar_turn == initial_turn );
    send( 41, R"({"action":"unknown","nested":{"action":"wait"}})" );
    CHECK_FALSE( peer.turn.client_acted_this_turn );
    wait( 41, 300 );
    CHECK( peer.observation.partner_calendar_turn == 300 );
    REQUIRE( peer.turn.client_acted_this_turn );
    wait( 41, 400 );
    CHECK( peer.observation.partner_calendar_turn == 300 );
    next_test_remote_turn( peer );
    wait( 41, 100 );
    CHECK_FALSE( peer.turn.client_acted_this_turn );
    wait( 42, 450 );
    CHECK( peer.turn.client_acted_this_turn );
    CHECK( peer.observation.partner_calendar_turn == 450 );
    CHECK( actor.current_movement_mode() == original_mode );
    CHECK( actor.name == original_name );
    CHECK( actor.get_str_base() == original_strength );
    CHECK( actor.get_stamina() == 500 );
    CHECK( actor.get_effect( bleed, arm ).get_duration() == 3_turns );
}

TEST_CASE( "mp_host_ignores_raw_monster_hp_for_stale_and_current_ids",
           "[multiplayer][world_session][entity_identity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        get_creature_tracker().clear();
        cata_mp::get_mp_queue().clear();
    } );
    bind_test_player( session );
    only_test_remote( session ).connected = true;
    set_test_admission( session, cata_mp::peer_admission::create( 701 ) );
    auto original = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                    tripoint_bub_ms( 62, 60, 0 ) );
    REQUIRE( get_creature_tracker().add( original ) );
    cata_mp::serialize_remote_player_state( only_test_remote( session ) );
    const auto old_id = session.replication.entity_ids.known_id( *original );
    REQUIRE( old_id != 0 );
    get_creature_tracker().remove( *original );
    auto copied = make_shared_fast<monster>( *original );
    REQUIRE( session.replication.entity_ids.known_id( *copied ) == 0 );
    REQUIRE( get_creature_tracker().add( copied ) );
    const auto hit = [&]( uint32_t id ) {
        auto &peer = only_test_remote( session );
        next_test_remote_turn( peer );
        const auto packet = test_granted_action( R"({"action":"wait","client_monster_hits":[{"nid":)" +
                            std::to_string( id ) + R"(,"hp":1}]})", peer.turn.grant_seq );
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                               packet, peer.admission } ) );
        cata_mp::process_mp_events();
    };
    const int initial_hp = copied->get_hp();
    REQUIRE( initial_hp > 1 );
    hit( old_id );
    CHECK( copied->get_hp() == initial_hp );
    CHECK( original->get_hp() == initial_hp );
    cata_mp::serialize_remote_player_state( only_test_remote( session ) );
    const auto copied_id = session.replication.entity_ids.known_id( *copied );
    REQUIRE( copied_id != old_id );
    hit( copied_id );
    CHECK( copied->get_hp() == initial_hp );
    CHECK( get_creature_tracker().is_present( copied.get() ) );
}

TEST_CASE( "mp_rejects_legacy_direct_world_action_uploads",
           "[multiplayer][world_session][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        cata_mp::get_mp_queue().clear();
    } );
    npc &actor = bind_test_player( session );
    auto &peer = only_test_remote( session );
    peer.connected = true;
    set_test_admission( session, cata_mp::peer_admission::create( 701 ) );
    next_test_remote_turn( peer );

    map &here = get_map();
    const tripoint_abs_ms origin = actor.pos_abs();
    const tripoint_abs_ms target = origin + tripoint_rel_ms( 2, 0, 0 );
    const tripoint_bub_ms tile = here.get_bub( target );
    REQUIRE( here.inbounds( tile ) );
    const size_t item_count = here.i_at( tile ).size();
    const std::string action = GENERATE( "drop", "position_sync", "smash", "eat", "vehicle_construct" );
    std::ostringstream encoded;
    JsonOut out( encoded );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", action );
    out.member( "grant_seq", peer.turn.grant_seq );
    out.member( "x", target.x() );
    out.member( "y", target.y() );
    out.member( "z", target.z() );
    out.member( "items", std::vector<item>{ item( itype_id( "bat" ) ) } );
    out.end_object();
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                           encoded.str(), peer.admission } ) );
    cata_mp::process_mp_events();
    CHECK( actor.pos_abs() == origin );
    CHECK( here.i_at( tile ).size() == item_count );
    CHECK_FALSE( peer.turn.client_acted_this_turn );
}

TEST_CASE( "mp_native_dispatch_rejoins_the_same_persistent_actor",
           "[multiplayer][world_session][player_identity][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const cata_mp::player_credentials profile{ cata_mp::player_id( std::string( 32, '3' ) ),
            std::string( 64, 'c' ) };
    const auto record = PATH_INFO::world_base_save_path() / ( "mp_actor_" + profile.id.str() +
                        ".json" );
    const auto backup = record + ".test-backup";
    REQUIRE_FALSE( file_exist( record ) );
    REQUIRE_FALSE( file_exist( backup ) );
    const on_out_of_scope cleanup( [&]() {
        clear_npcs();
        session.reset();
        std::filesystem::remove_all( record.get_unrelative_path() );
        remove_file( backup );
        remove_file( PATH_INFO::world_base_save_path() / "mp_npc_cleanup.json" );
        cata_mp::get_mp_queue().clear();
    } );
    std::map<uint64_t, cata_mp::peer_admission> admissions;
    const auto connect = [&]( uint64_t peer, const cata_mp::player_credentials & identity ) {
        admissions[peer] = cata_mp::peer_admission::create( peer );
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::connect, "connection nickname", "", admissions[peer], identity } ) );
        cata_mp::process_mp_events();
        if( const auto *pending = session.find_remote( admissions[peer] );
            pending && pending->awaiting_character ) {
            CHECK_FALSE( file_exist( record ) );
            finish_player_creation( admissions[peer], "Rosalee Blanco" );
        }
    };
    const recipe_id known_recipe( "balclava" );
    REQUIRE( known_recipe.is_valid() );
    get_avatar().learn_recipe( &known_recipe.obj() );
    get_avatar().set_str_base( 17 );
    connect( 101, profile );
    REQUIRE( only_test_remote( session ).connected );
    const auto original_id = only_test_remote( session ).actor.id();
    REQUIRE( original_id.is_valid() );
    npc *actor = g->critter_by_id<npc>( original_id );
    REQUIRE( actor );
    REQUIRE( actor->has_native_player_control() );
    CHECK( actor->get_str_base() == 17 );
    CHECK( actor->knows_recipe( &known_recipe.obj() ) );
    CHECK( actor->getID() != get_avatar().getID() );
    CHECK( actor->get_value( "mp_player_id" ).str() == profile.id.str() );
    // Use the world phase's actual prepare/advance/finish path. An admitted
    // compatibility proxy otherwise keeps negative AP forever after an action.
    only_test_remote( session ).turn.remote_moves = -5;
    REQUIRE( cata_mp::prepare_remote_character_turn( *actor ) );
    REQUIRE( g->player_controls().process_turn( *actor ) );
    cata_mp::finish_remote_character_turn( *actor );
    CHECK( only_test_remote( session ).turn.remote_moves > 0 );
    CHECK( only_test_remote( session ).turn.remote_moves == actor->get_moves() );
    // A stale replica must not erase the server's stamina or bleeding. This
    // goes through dispatch for an initialized, native-controlled player.
    actor->set_stamina( 1234 );
    actor->add_effect( efftype_id( "bleed" ), 10_minutes, bodypart_id( "arm_l" ), 2 );
    const time_duration bleeding = actor->get_effect( efftype_id( "bleed" ),
                                   bodypart_id( "arm_l" ) ).get_duration();
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                           R"({"action":"activity_end","client_stamina":9999,"client_bleed":[]})",
                                           admissions.at( 101 ) } ) );
    cata_mp::process_mp_events();
    CHECK( actor->get_stamina() == 1234 );
    CHECK( actor->get_effect( efftype_id( "bleed" ),
                              bodypart_id( "arm_l" ) ).get_duration() == bleeding );
    const auto before_unload = g->npc_lifetimes().acquire( *actor );
    actor->on_unload();
    g->remove_npc( actor->getID() );
    CHECK_FALSE( before_unload.resolve( g->npc_lifetimes() ) );
    CHECK_FALSE( only_test_remote( session ).actor.resolve_loaded( actor, g->npc_lifetimes() ) );
    CHECK( only_test_remote( session ).actor.retained( g->npc_lifetimes() ) == actor );
    REQUIRE( cata_mp::mp_save_remote_player() );
    g->load_npcs();
    CHECK( only_test_remote( session ).actor.resolve_loaded( actor, g->npc_lifetimes() ) == actor );
    CHECK_FALSE( before_unload.resolve( g->npc_lifetimes() ) );
    actor->name = "Rosalee Blanco";
    actor->set_value( "identity_regression", std::string( "retained" ) );
    std::filesystem::rename( record.get_unrelative_path(), backup.get_unrelative_path() );
    std::filesystem::create_directory( record.get_unrelative_path() );
    // A queued stale stats upload cannot overwrite the authoritative actor,
    // even when transport retirement precedes owner-thread dispatch.
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                           R"({"action":"worn_sync","char_stats":{"name":"stale upload","str":99}})",
                                           admissions.at( 101 ) } ) );
    admissions.at( 101 ).retire();
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", admissions.at( 101 ) } ) );
    cata_mp::process_mp_events();
    CHECK( only_test_remote( session ).detach_pending );
    CHECK( only_test_remote( session ).admission.peer_id() == 0 );
    CHECK( g->critter_by_id<npc>( original_id ) == actor );
    CHECK( actor->name == "Rosalee Blanco" );
    CHECK( cata_mp::is_remote_player( original_id ) );
    cata_mp::wait_for_client_action(); // Must not wait for the disconnected peer.
    actor->set_wielded_item( item( itype_id( "chocolate" ), calendar::turn, 3 ) );
    std::filesystem::remove( record.get_unrelative_path() );
    std::filesystem::rename( backup.get_unrelative_path(), record.get_unrelative_path() );
    REQUIRE( cata_mp::mp_save_remote_player() );
    CHECK( session.remote_players.empty() );
    REQUIRE( session.remote_players.empty() );
    session.reset(); // Includes a fresh world-store index, not merely a socket reconnect.
    connect( 202, profile );
    REQUIRE( only_test_remote( session ).connected );
    CHECK( only_test_remote( session ).actor.id() == original_id );
    actor = g->critter_by_id<npc>( original_id );
    REQUIRE( actor );
    CHECK( actor->name == "Rosalee Blanco" );
    CHECK( actor->get_value( "identity_regression" ).str() == "retained" );
    CHECK( actor->get_str_base() == 17 );
    CHECK( actor->knows_recipe( &known_recipe.obj() ) );
    REQUIRE( actor->get_wielded_item() );
    CHECK( actor->get_wielded_item()->charges == 3 );
    CHECK( only_test_remote( session ).pickup.revision > 0 );
    finish_player_creation( admissions.at( 202 ), "replacement attempt" );
    CHECK( actor->name == "Rosalee Blanco" );
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                           R"({"action":"worn_sync","wielded":"","char_stats":{"name":"stale local save"}})",
                                           admissions.at( 202 ) } ) );
    cata_mp::process_mp_events();
    REQUIRE( actor->get_wielded_item() );
    CHECK( actor->get_wielded_item()->typeId() == itype_id( "chocolate" ) );
    CHECK( actor->get_wielded_item()->charges == 3 );
    CHECK( actor->name == "Rosalee Blanco" );
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", admissions.at( 101 ) } ) );
    cata_mp::process_mp_events();
    CHECK( only_test_remote( session ).connected );
    CHECK( only_test_remote( session ).admission.peer_id() == 202 );
    only_test_remote( session ).replication.host_veh_cargo_baseline[tripoint_abs_ms( 1, 2,
                             0 )] = "old cargo";
    only_test_remote( session ).replication.last_vehicle_step_payload = "old stationary vehicles";
    only_test_remote( session ).turn.pending_partner_push = true;
    only_test_remote( session ).turn.action_msgs_pending.push_back( "former peer's action" );
    admissions.at( 202 ).retire();
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", admissions.at( 202 ) } ) );
    cata_mp::process_mp_events();
    CHECK( session.remote_players.empty() );
    auto impostor = profile;
    impostor.resume_secret = std::string( 64, 'd' );
    connect( 303, impostor );
    CHECK( session.remote_players.empty() );
    monster retained_monster( mtype_id( "mon_test_zombie" ) );
    const auto retained_nid = session.replication.entity_ids.assign( retained_monster );
    session.grant_sequence = 88;
    connect( 404, profile );
    REQUIRE( only_test_remote( session ).connected );
    CHECK( only_test_remote( session ).actor.id() == original_id );
    CHECK( session.replication.entity_ids.known_id( retained_monster ) == retained_nid );
    CHECK( only_test_remote( session ).turn.grant_seq == 89 );
    CHECK( only_test_remote( session ).replication.host_veh_cargo_baseline.empty() );
    CHECK( only_test_remote( session ).replication.last_vehicle_step_payload.empty() );
    CHECK_FALSE( only_test_remote( session ).turn.pending_partner_push );
    CHECK( only_test_remote( session ).turn.action_msgs_pending.empty() );
}

TEST_CASE( "mp_dispatch_never_controls_an_unloaded_or_replaced_actor",
           "[multiplayer][world_session][actor_binding][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        cata_mp::get_mp_queue().clear();
    } );
    npc &actor = bind_test_player( session );
    const auto retained = g->shared_from( actor );
    REQUIRE( retained );
    only_test_remote( session ).connected = true;
    set_test_admission( session, cata_mp::peer_admission::create( 701 ) );
    auto &activity = only_test_remote( session ).observation.partner_activity;
    const auto start_wait = [&]() {
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                               R"({"action":"activity_start","activity_id":"ACT_WAIT"})", only_test_remote( session ).admission } ) );
        cata_mp::process_mp_events();
    };
    start_wait();
    REQUIRE( activity == "ACT_WAIT" );
    activity.clear();

    SECTION( "ordinary unload rejects actions and native reload restores the same role" ) {
        const auto before = g->npc_lifetimes().acquire( actor );
        only_test_remote( session ).turn.proxy_was_alive = true;
        only_test_remote( session ).turn.granted_this_turn = true;
        actor.on_unload();
        g->remove_npc( actor.getID() );
        cata_mp::grant_client_turn();
        CHECK( only_test_remote( session ).connected );
        CHECK( only_test_remote( session ).turn.proxy_was_alive );
        CHECK_FALSE( only_test_remote( session ).turn.granted_this_turn );
        start_wait();
        CHECK( activity.empty() );
        CHECK_FALSE( before.resolve( g->npc_lifetimes() ) );
        g->load_npcs();
        start_wait();
        CHECK( activity == "ACT_WAIT" );
        CHECK_FALSE( before.resolve( g->npc_lifetimes() ) );
    }
    SECTION( "removal from the active tracker is sufficient to reject control" ) {
        // remove_npc does not invoke on_unload: an active lifetime alone is
        // insufficient without exact membership in the current native tracker.
        g->remove_npc( actor.getID() );
        start_wait();
        CHECK( activity.empty() );
        g->load_npcs();
        start_wait();
        CHECK( activity == "ACT_WAIT" );
    }
    SECTION( "copied ID and tags cannot transfer control to a replacement" ) {
        g->remove_npc( actor.getID() );
        auto replacement = make_shared_fast<npc>();
        replacement->normalize();
        replacement->setID( actor.getID() );
        replacement->spawn_at_precise( actor.pos_abs() );
        replacement->set_value( "mp_proxy", std::string( "1" ) );
        replacement->set_value( "mp_player_id", test_player().str() );
        replacement->name = "replacement";
        overmap_buffer.insert_npc( replacement );
        g->load_npcs();
        REQUIRE( g->critter_by_id<npc>( actor.getID() ) == replacement.get() );
        start_wait();
        CHECK( replacement->name == "replacement" );
        CHECK( activity.empty() );
        CHECK_FALSE( cata_mp::is_remote_player( replacement->getID() ) );
    }
}

TEST_CASE( "mp_restored_actor_ids_cannot_be_reallocated", "[multiplayer][player_identity]" )
{
    const character_id allocated = g->assign_npc_id();
    const character_id restored( allocated.get_value() + 100 );
    g->observe_npc_id( restored );
    CHECK( g->assign_npc_id() == character_id( restored.get_value() + 1 ) );
    g->observe_npc_id( allocated );
    CHECK( g->assign_npc_id() == character_id( restored.get_value() + 2 ) );
    CHECK_THROWS( g->observe_npc_id( character_id() ) );
}

TEST_CASE( "mp_proxy_bindings_belong_to_one_world", "[multiplayer][world_session]" )
{
    cata_mp::world_session first;
    cata_mp::world_session second;
    npc first_actor;
    first_actor.normalize();
    first_actor.setID( character_id( 12 ), true );
    first_actor.set_value( "mp_proxy", std::string( "1" ) );
    first_actor.set_value( "mp_player_id", test_player().str() );
    npc second_actor;
    second_actor.normalize();
    second_actor.setID( character_id( 12 ), true );
    second_actor.set_value( "mp_proxy", std::string( "1" ) );
    second_actor.set_value( "mp_player_id", test_player().str() );
    npc_lifetime_registry first_world;
    npc_lifetime_registry second_world;
    player_control_registry first_controls;
    player_control_registry second_controls;
    make_test_remote( first );
    only_test_remote( first ).actor.bind_player( first_actor, test_player(), first_world,
            first_controls.claim( test_player(), first_actor ) );
    only_test_remote( first ).connected = true;
    set_test_admission( first, cata_mp::peer_admission::create( 101 ) );
    make_test_remote( second );
    only_test_remote( second ).actor.bind_player( second_actor, test_player(), second_world,
            second_controls.claim( test_player(), second_actor ) );
    only_test_remote( second ).connected = true;
    set_test_admission( second, cata_mp::peer_admission::create( 101 ) );

    const auto first_admission = only_test_remote( first ).admission;
    CHECK( first.accepts_remote_event( first_admission ) );
    CHECK_FALSE( first.accepts_remote_event( only_test_remote( second ).admission ) );
    CHECK_FALSE( first.accepts_remote_event( cata_mp::peer_admission::create( 0 ) ) );
    CHECK_FALSE( first.accepts_remote_event( cata_mp::peer_admission::create( 202 ) ) );
    CHECK_FALSE( second.accepts_remote_event( cata_mp::peer_admission::create( 101 ) ) );
    first.reset();
    CHECK_FALSE( first.accepts_remote_event( first_admission ) );
    CHECK( second.accepts_remote_event( only_test_remote( second ).admission ) );
    CHECK( only_test_remote( second ).actor.id() == character_id( 12 ) );
}

TEST_CASE( "mp_world_reset_clears_bindings_before_character_ids_are_reused",
           "[multiplayer][world_session]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    auto &session = g->multiplayer_session();
    const on_out_of_scope restore_session( [&session]() {
        session.reset();
        // reset_game_state clears the faction manager, while production setup
        // also discards the old overmaps. Do not reload test NPCs retaining
        // pointers to factions from that closed world in the next test.
        clear_overmaps();
    } );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_map_without_vision();
    const auto actor_id = bind_test_player( session ).getID();
    only_test_remote( session ).connected = true;
    set_test_admission( session, cata_mp::peer_admission::create( 101 ) );
    bind_test_view( session );
    session.client_host_spawned = true;
    session.stale_proxy_cleanup_done = true;

    session.client_apply_watchdog.begin( "world reset" );
    REQUIRE( session.client_apply_watchdog.running() );
    REQUIRE( cata_mp::is_remote_player( actor_id ) );
    g->reset_game_state();
    CHECK_FALSE( session.client_apply_watchdog.running() );
    CHECK_FALSE( cata_mp::is_remote_player( actor_id ) );
    CHECK( session.remote_players.empty() );
    CHECK_FALSE( session.client_host_spawned );
    CHECK_FALSE( cata_mp::get_host_npc_character_id().is_valid() );
    CHECK_FALSE( session.stale_proxy_cleanup_done );
    CHECK( g->assign_npc_id() == character_id( 1 ) );
}

TEST_CASE( "mp_late_disconnect_cannot_remove_another_peers_actor",
           "[multiplayer][world_session][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    REQUIRE( cata_mp::get_mp_queue().empty() );
    auto &session = g->multiplayer_session();
    const on_out_of_scope restore_session( [&session]() {
        session.reset();
    } );
    clear_map_without_vision();
    const auto actor_id = bind_test_player( session ).getID();
    only_test_remote( session ).connected = true;
    set_test_admission( session, cata_mp::peer_admission::create( 202 ) );
    const auto previous = cata_mp::peer_admission::create( 202 );
    previous.retire();
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "player", "", previous } ) );
    npc *actor = g->critter_by_id<npc>( actor_id );
    REQUIRE( actor );
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                           R"({"action":"activity_start","activity_id":"ACT_WAIT"})",
                                           cata_mp::peer_admission::create( 202 ) } ) );
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                           R"({"action":"activity_start","activity_id":"ACT_WAIT_STAMINA"})", previous } ) );
    // Same display name, different transport peer. Exercise the real dispatch
    // path, not just the predicate: the disconnect must never reach despawn.
    REQUIRE( cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", cata_mp::peer_admission::create( 101 )} ) );
    REQUIRE( cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", cata_mp::peer_admission::create( 0 )} ) );
    cata_mp::process_mp_events();
    CHECK( cata_mp::get_mp_queue().empty() );
    CHECK( only_test_remote( session ).connected );
    CHECK( only_test_remote( session ).admission.peer_id() == 202 );
    CHECK( only_test_remote( session ).observation.partner_activity.empty() );
    CHECK( cata_mp::is_remote_player( actor_id ) );

    cata_mp::mp_on_world_exit();
    CHECK( session.remote_players.empty() );
    CHECK_FALSE( session.accepts_remote_event( cata_mp::peer_admission::create( 202 ) ) );
    CHECK( session.remote_players.empty() );
}

TEST_CASE( "mp_return_to_menu_closes_modes_bindings_and_pending_events",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    REQUIRE( cata_mp::get_mp_queue().empty() );
    auto &session = g->multiplayer_session();
    const restore_on_out_of_scope restore_quit( g->uquit );
    const on_out_of_scope cleanup( []() {
        cata_mp::mp_on_world_exit();
        cata_mp::mp_event event;
        while( cata_mp::get_mp_queue().pop( event ) ) {}
        // cleanup_at_end releases MAPBUFFER. Recreate the test map before the
        // native harness saves its test world or another case uses its tiles.
        clear_overmaps();
    } );
    cata_mp::set_client_mode( true );
    clear_map_without_vision();
    bind_test_view( session );
    session.client_host_spawned = true;
    session.stale_proxy_cleanup_done = true;
    REQUIRE( cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", cata_mp::peer_admission::create( 101 )} ) );
    cata_mp::mp_set_host_world_name( "world being closed" );
    cata_mp::mp_set_host_player_name( "old host" );
    g->uquit = QUIT_SAVED;
    session.client_apply_watchdog.begin( "world exit" );
    REQUIRE( session.client_apply_watchdog.running() );

    // Exercise the actual gameplay -> main menu boundary, not the unconnected
    // exit helper directly. No socket is needed to expose the leaked mode.
    REQUIRE( turn_handler::cleanup_at_end() );
    CHECK_FALSE( session.client_apply_watchdog.running() );
    CHECK_FALSE( cata_mp::is_session_active() );
    CHECK_FALSE( session.client_host_spawned );
    CHECK_FALSE( session.client_host_actor.id().is_valid() );
    CHECK_FALSE( session.stale_proxy_cleanup_done );
    CHECK( cata_mp::get_mp_queue().empty() );
    CHECK( cata_mp::mp_get_host_world_name().empty() );
    CHECK( cata_mp::mp_get_host_player_name().empty() );
}

TEST_CASE( "mp_deferred_host_intent_survives_setup_but_not_world_exit",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const on_out_of_scope cleanup( []() {
        cata_mp::mp_on_world_exit();
    } );
    REQUIRE( cata_mp::mp_request_host_session( 0, "", "test" ) );
    g->reset_game_state();
    CHECK( cata_mp::is_host_mode() );
    CHECK_FALSE( cata_mp::is_hosting() );
    CHECK_FALSE( cata_mp::mp_menu_coop_status_text().empty() );

    cata_mp::mp_on_world_exit();
    cata_mp::process_mp_events();
    CHECK_FALSE( cata_mp::is_session_active() );
    CHECK_FALSE( cata_mp::is_hosting() );
    CHECK( cata_mp::mp_menu_coop_status_text().empty() );
}

TEST_CASE( "mp_room_closes_and_reopens_in_the_loaded_world",
           "[.multiplayer_runtime][world_session][lifecycle][regression]" )
{
    cata_mp::mp_on_world_exit();
    WORLD isolated_world( "room_switch" );
    const restore_on_out_of_scope restore_world( world_generator->active_world );
    const restore_on_out_of_scope restore_last_world( world_generator->last_world_name );
    const restore_on_out_of_scope restore_last_character( world_generator->last_character_name );
    const restore_on_out_of_scope restore_quit( g->uquit );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto save_root = PATH_INFO::world_base_save_path() / "room_switch";
    REQUIRE( std::filesystem::create_directory( save_root.get_unrelative_path() ) );
    const std::string savedir = PATH_INFO::savedir();
    WORLD *const previous_world = world_generator->active_world;
    const on_out_of_scope cleanup( [&]() {
        cata_mp::mp_on_world_exit();
        PATH_INFO::set_savedir( savedir );
        world_generator->set_active_world( previous_world );
        clear_overmaps();
        std::error_code error;
        std::filesystem::remove_all( save_root.get_unrelative_path(), error );
    } );
    PATH_INFO::set_savedir( save_root.get_unrelative_path().generic_u8string() + "/" );
    REQUIRE( assure_dir_exist( isolated_world.folder_path() ) );
    world_generator->set_active_world( &isolated_world );
    clear_overmaps();
    clear_avatar();
    clear_map_without_vision();
    g->uquit = QUIT_NO;
    avatar &host = get_avatar();
    map &here = get_map();
    host.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    const auto local_id = host.getID();
    const auto position = host.pos_abs();
    const auto turn = calendar::turn;
    auto &session = g->multiplayer_session();
    const auto open_room = [&]() {
        REQUIRE( cata_mp::mp_request_host_session( 0, "", "room-switch" ) );
        cata_mp::process_mp_events();
        INFO( session.hosting.error() );
        REQUIRE( cata_mp::is_hosting() );
    };
    open_room();
    CHECK( session.host_info.world == isolated_world.identity() );
    CHECK( session.host_info.world_name == isolated_world.world_name );
    CHECK( session.host_info.player_name == host.name );

    const cata_mp::player_credentials profile{ player_id( std::string( 32, '8' ) ),
            std::string( 64, 'd' ) };
    const auto join = [&]( uint64_t id ) {
        auto admission = cata_mp::peer_admission::create( id );
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::connect,
                                               "guest", "", admission, profile } ) );
        cata_mp::process_mp_events();
        REQUIRE( session.find_remote( admission ) );
        return admission;
    };
    const auto first = join( 901 );
    finish_player_creation( first, "room guest" );
    npc *guest = session.find_remote( first )->actor.retained( g->npc_lifetimes() );
    REQUIRE( guest );
    const auto guest_id = guest->getID();
    guest->setpos( here, tripoint_bub_ms( 68, 68, 0 ) );
    const tripoint_abs_ms saved_guest_position = guest->pos_abs();
    const auto seat_tile = guest->pos_bub( here );
    REQUIRE( here.add_vehicle( vproto_id( "bicycle" ), seat_tile, 0_degrees, 0,
                               veh_spawn_status::UNDAMAGED ) );
    const auto seat = here.veh_at( seat_tile ).part_with_feature( VPFLAG_BOARDABLE, false );
    REQUIRE( seat );
    here.board_vehicle( seat_tile, guest );
    REQUIRE( seat->part().passenger_id == guest_id );

    const auto center = here.get_abs_sub() + point_rel_sm( HALF_MAPSIZE, HALF_MAPSIZE );
    auto &region = session.load_region( *g, here, profile.id, center );
    REQUIRE( region.terrain->has_loaded_submap( guest->pos_abs_sm() ) );
    CHECK( region.terrain->get_abs_sub() == here.get_abs_sub() );
    CHECK( session.loaded_map_at( here, guest->pos_abs_sm() ) == &here );
    CHECK( session.scent_for( *region.terrain ) == region.scent.get() );
    CHECK( session.scent_for( here ) == nullptr );
    CHECK( &session.load_region( *g, here, profile.id, center ) == &region );
    const tripoint_bub_ms changed_tile( 72, 72, 0 );
    const tripoint_bub_ms mirrored_tile = region.terrain->get_bub( here.get_abs( changed_tile ) );
    const trap_str_id beartrap( "tr_beartrap" );
    const trap_str_id pit( "tr_pit" );
    region.terrain->trap_set( mirrored_tile, beartrap.id() );
    const auto &beartraps = here.trap_locations( beartrap.id() );
    CHECK( std::count( beartraps.begin(), beartraps.end(), changed_tile ) == 1 );
    here.ter_set( changed_tile, ter_str_id( "t_pit" ).id() );
    CHECK( std::count( beartraps.begin(), beartraps.end(), changed_tile ) == 0 );
    const auto &remote_pits = region.terrain->trap_locations( pit.id() );
    CHECK( std::count( remote_pits.begin(), remote_pits.end(), mirrored_tile ) == 1 );
    region.terrain->ter_set( mirrored_tile, ter_str_id( "t_floor" ).id() );
    CHECK( std::count( remote_pits.begin(), remote_pits.end(), mirrored_tile ) == 0 );
    CHECK( std::count( beartraps.begin(), beartraps.end(), changed_tile ) == 1 );
    region.terrain->remove_trap( mirrored_tile );
    CHECK( std::count( beartraps.begin(), beartraps.end(), changed_tile ) == 0 );

    const auto &emitters = here.get_furn_field_locations();
    region.terrain->furn_set( mirrored_tile, furn_str_id( "f_fog" ).id() );
    CHECK( std::count( emitters.begin(), emitters.end(), changed_tile ) == 1 );
    region.terrain->furn_set( mirrored_tile, furn_str_id( "f_swamp_gas" ).id() );
    CHECK( std::count( emitters.begin(), emitters.end(), changed_tile ) == 1 );
    region.terrain->furn_set( mirrored_tile, furn_str_id::NULL_ID() );
    CHECK( std::count( emitters.begin(), emitters.end(), changed_tile ) == 0 );

    here.build_map_cache( changed_tile.z() );
    REQUIRE( here.is_transparent_wo_fields( changed_tile ) );
    region.terrain->ter_set( mirrored_tile, ter_str_id( "t_wall" ).id() );
    here.build_map_cache( changed_tile.z() );
    CHECK_FALSE( here.is_transparent_wo_fields( changed_tile ) );
    region.terrain->ter_set( mirrored_tile, ter_str_id( "t_floor" ).id() );

    // Query the same two actors from both view contexts. The wall changes in
    // the guest window must invalidate the host's cached reachable members.
    const tripoint_bub_ms isolated_tile( 78, 78, 0 );
    auto &tracker = get_creature_tracker();
    auto isolated_monster = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ), isolated_tile );
    REQUIRE( tracker.add( isolated_monster ) );
    const auto is_host = [&]( Creature * candidate ) {
        return candidate == &host;
    };
    for( const tripoint_bub_ms &p : here.points_in_radius( isolated_tile, 1 ) ) {
        if( p != isolated_tile ) {
            region.terrain->ter_set( region.terrain->get_bub( here.get_abs( p ) ),
                                     ter_str_id( "t_wall" ).id() );
        }
    }
    CHECK( tracker.find_reachable( *isolated_monster, is_host ) == nullptr );
    region.terrain->ter_set( region.terrain->get_bub( here.get_abs( isolated_tile + point::west ) ),
                             ter_str_id( "t_floor" ).id() );
    {
        const swap_map context( *region.terrain );
        CHECK( tracker.find_reachable( *isolated_monster, is_host ) == &host );
    }
    CHECK( tracker.find_reachable( *isolated_monster, is_host ) == &host );
    tracker.remove( *isolated_monster );

    const tripoint_abs_ms second_vehicle_pos = here.get_abs( tripoint_bub_ms( 74, 74, 0 ) );
    vehicle *second_vehicle = here.add_vehicle( vproto_id( "bicycle" ),
        here.get_bub( second_vehicle_pos ), 0_degrees, 0,
        veh_spawn_status::UNDAMAGED );
    REQUIRE( second_vehicle );
    REQUIRE( veh_pointer_or_null( region.terrain->veh_at( second_vehicle_pos ) ) == second_vehicle );
    const auto second_vehicle_lifetime = second_vehicle->get_safe_reference();
    second_vehicle->summon_time_limit = 2_turns;
    here.vehmove( session.active_maps( here ), session.simulation_regions( here ) );
    REQUIRE( second_vehicle_lifetime );
    REQUIRE( second_vehicle->summon_time_limit );
    CHECK( *second_vehicle->summon_time_limit == 1_turns );
    region.terrain->destroy_vehicle( second_vehicle );
    CHECK_FALSE( here.veh_at( second_vehicle_pos ) );
    CHECK_FALSE( region.terrain->veh_at( second_vehicle_pos ) );

    // Make the normal shared save fail after the guest record was written.
    const auto master = PATH_INFO::world_base_save_path() / SAVE_MASTER;
    REQUIRE( std::filesystem::create_directory( master.get_unrelative_path() ) );
    bool closed = true;
    const std::string error = capture_debugmsg_during( [&]() {
        closed = cata_mp::mp_close_host_session();
    } );
    CHECK_FALSE( closed );
    CHECK( error.find( "game not saved" ) != std::string::npos );
    CHECK( cata_mp::is_hosting() );
    REQUIRE( session.find_remote( first ) );
    CHECK( seat->part().passenger_id == guest_id );
    REQUIRE( std::filesystem::remove( master.get_unrelative_path() ) );

    REQUIRE( cata_mp::mp_close_host_session() );
    CHECK_FALSE( cata_mp::is_session_active() );
    CHECK_FALSE( cata_mp::is_hosting() );
    CHECK( g->uquit == QUIT_NO );
    CHECK( host.getID() == local_id );
    CHECK( host.pos_abs() == position );
    CHECK( calendar::turn == turn );
    CHECK( session.remote_players.empty() );
    CHECK_FALSE( session.has_regions() );
    CHECK_FALSE( g->player_controls().is_reserved( profile.id ) );
    CHECK( g->critter_by_id<npc>( guest_id ) == nullptr );
    CHECK_FALSE( overmap_buffer.find_npc( guest_id ) );
    CHECK( g->get_follower_list().count( guest_id ) == 0 );
    CHECK_FALSE( seat->part().passenger_id.is_valid() );

    open_room();
    const auto second = join( 901 );
    CHECK_FALSE( session.find_remote( first ) );
    auto *restored = session.find_remote( second )->actor.retained( g->npc_lifetimes() );
    REQUIRE( restored );
    CHECK( restored->getID() == guest_id );
    CHECK( restored->pos_abs() == saved_guest_position );
    CHECK_FALSE( restored->in_vehicle );
    CHECK_FALSE( restored->controlling_vehicle );

    // Walk one window away without changing the local player's map, then close
    // and reopen the room. The guest's exact position and remote edits survive.
    const tripoint_bub_ms edge( ( MAPSIZE - 2 ) * SEEX, HALF_MAPSIZE_Y, 0 );
    here.ter_set( edge, ter_str_id( "t_floor" ).id() );
    restored->setpos( here, edge, false );
    cata_mp::refresh_resident_regions();
    REQUIRE( session.find_region( profile.id ) != nullptr );
    auto &distant_region = *session.find_region( profile.id );
    const tripoint_abs_sm distant_center = center + point_rel_sm( MAPSIZE + 2, 0 );
    restored->setpos( project_to<coords::ms>( distant_center ), false );
    cata_mp::refresh_resident_regions();
    map &distant = *distant_region.terrain;
    const tripoint_bub_ms distant_tile( HALF_MAPSIZE_X, HALF_MAPSIZE_Y, 0 );
    const tripoint_abs_ms distant_position = distant.get_abs( distant_tile );
    const tripoint_abs_ms marker = distant.get_abs( distant_tile + point::east );
    REQUIRE_FALSE( here.inbounds( distant_position ) );
    distant.furn_set( distant_tile, furn_str_id::NULL_ID() );
    distant.ter_set( distant_tile, ter_str_id( "t_floor" ).id() );
    distant.ter_set( distant.get_bub( marker ), ter_str_id( "t_wall" ).id() );
    restored->setpos( distant, distant_tile, false );
    REQUIRE( cata_mp::mp_close_host_session() );
    CHECK_FALSE( session.has_regions() );
    CHECK( host.pos_abs() == position );

    open_room();
    const auto third = join( 903 );
    auto *distant_guest = session.find_remote( third )->actor.retained( g->npc_lifetimes() );
    REQUIRE( distant_guest );
    CHECK( distant_guest->getID() == guest_id );
    CHECK( distant_guest->pos_abs() == distant_position );
    map *const restored_map = session.loaded_map_at( here, distant_guest->pos_abs_sm() );
    REQUIRE( restored_map != nullptr );
    REQUIRE( restored_map != &here );
    CHECK( restored_map->ter( restored_map->get_bub( marker ) ) == ter_str_id( "t_wall" ).id() );
    CHECK( cata_mp::mp_close_host_session() );
}

TEST_CASE( "mp_client_mode_and_teardown_belong_to_the_owning_world",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    const on_out_of_scope cleanup( []() {
        cata_mp::mp_on_world_exit();
    } );
    cata_mp::world_session other_world;
    cata_mp::set_client_mode( true );
    CHECK( g->multiplayer_session().client.enabled() );
    CHECK_FALSE( other_world.client.enabled() );
    other_world.reset();
    CHECK( cata_mp::is_client_mode() );

    other_world.client.set_enabled( true );
    g->multiplayer_session().reset();
    CHECK_FALSE( cata_mp::is_client_mode() );
    CHECK( other_world.client.enabled() );
    // Enabling client UI without a successful probe is not pending admission.
    other_world.prepare_for_world_load();
    CHECK_FALSE( other_world.client.enabled() );
}

TEST_CASE( "mp_host_metadata_and_events_belong_to_the_owning_world",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    auto &current = g->multiplayer_session();
    const on_out_of_scope cleanup( [&]() {
        current.reset();
    } );
    cata_mp::world_session other;
    cata_mp::mp_set_host_world_name( "current world" );
    cata_mp::mp_set_host_player_name( "current host" );
    cata_mp::mp_capture_host_omt( tripoint_abs_omt( 1, 2, 3 ) );
    current.host_info.seed = 11;
    other.host_info = { "other world", "other host", 22, std::array<int, 3>{ 4, 5, 6 },
                        world_id( std::string( 32, '2' ) )
                      };
    REQUIRE( cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::action, "", "current", cata_mp::peer_admission::create( 1 )} ) );
    CHECK( other.hosting.events().empty() );
    REQUIRE( other.hosting.events().push( {cata_mp::mp_event::type::action, "", "other", cata_mp::peer_admission::create( 2 )} ) );

    other.reset();
    CHECK( other.hosting.events().empty() );
    CHECK( other.host_info.world_name.empty() );
    CHECK_FALSE( other.host_info.world.valid() );
    CHECK_FALSE( other.host_info.host_omt );
    CHECK( cata_mp::mp_get_host_world_name() == "current world" );
    CHECK( cata_mp::mp_get_host_player_name() == "current host" );
    CHECK( cata_mp::mp_host_world_seed() == 11 );
    CHECK( cata_mp::mp_host_omt() == tripoint_abs_omt( 1, 2, 3 ) );
    cata_mp::mp_event event;
    REQUIRE( cata_mp::get_mp_queue().pop( event ) );
    CHECK( event.data == "current" );
    CHECK( cata_mp::get_mp_queue().empty() );

    REQUIRE( other.hosting.events().push( {cata_mp::mp_event::type::action, "", "survivor", cata_mp::peer_admission::create( 2 )} ) );
    REQUIRE( current.hosting.events().push( {cata_mp::mp_event::type::action, "", "retired", cata_mp::peer_admission::create( 1 )} ) );
    current.reset();
    CHECK( cata_mp::get_mp_queue().empty() );
    CHECK( cata_mp::mp_get_host_world_name().empty() );
    CHECK( cata_mp::mp_get_host_player_name().empty() );
    CHECK( cata_mp::mp_host_world_seed() == 0 );
    CHECK_FALSE( cata_mp::mp_host_omt_valid() );
    REQUIRE( other.hosting.events().pop( event ) );
    CHECK( event.data == "survivor" );
}

TEST_CASE( "mp_world_state_does_not_cross_owner_or_reload_boundaries",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    auto &current = g->multiplayer_session();
    const on_out_of_scope cleanup( [&]() {
        current.reset();
        clear_npcs();
    } );
    current.reset();
    clear_map_without_vision();
    bind_test_player( current );
    only_test_remote( current ).connected = true;
    cata_mp::world_session other;
    make_test_remote( other );
    const tripoint_abs_ms location( 4, 5, 0 );
    cata_mp::set_host_mode( true );
    only_test_remote( current ).replication.tile_baseline[location].ter = "t_wall";
    only_test_remote( other ).replication.tile_baseline[location].ter = "t_floor";
    current.replication.client.phantom_strikes["zombie@4,5,0"] = 2;
    current.replication.client.pending_omsync.emplace_back();
    current.client_turn.client_waiting_for_ack = true;
    current.client_turn.client_last_grant_seq = 41;
    only_test_remote( current ).observation.partner_activity = "ACT_CRAFT";
    only_test_remote( current ).observation.partner_activity_moves_total = 20000;
    only_test_remote( current ).observation.partner_activity_pct = 75;
    CHECK( cata_mp::partner_activity_accepts_help() );
    CHECK( cata_mp::partner_activity_pct() == 75 );
    CHECK_FALSE( other.host_mode );
    other.reset();
    CHECK( cata_mp::is_host_mode() );
    CHECK( only_test_remote( current ).replication.tile_baseline.at( location ).ter == "t_wall" );
    CHECK( current.replication.client.phantom_strikes.at( "zombie@4,5,0" ) == 2 );

    make_test_remote( other );
    only_test_remote( other ).replication.tile_baseline[location].ter = "t_door_c";
    only_test_remote( other ).turn.grant_seq = 99;
    current.prepare_for_world_load();
    CHECK( cata_mp::is_host_mode() ); // Launch intent survives setup.
    CHECK( current.remote_players.empty() );
    CHECK( current.replication.client.phantom_strikes.empty() );
    CHECK( current.replication.client.pending_omsync.empty() );
    CHECK_FALSE( current.client_turn.client_waiting_for_ack );
    CHECK( current.client_turn.client_last_grant_seq == 0 );
    CHECK( cata_mp::partner_activity_moves_total() == 0 );
    CHECK( cata_mp::partner_activity_pct() == 0 );
    CHECK( only_test_remote( other ).replication.tile_baseline.at( location ).ter == "t_door_c" );
    CHECK( only_test_remote( other ).turn.grant_seq == 99 );
    current.reset();
    CHECK_FALSE( cata_mp::is_host_mode() );
}

TEST_CASE( "mp_failed_admission_metadata_cannot_leak_into_another_world",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    auto &current = g->multiplayer_session();
    const on_out_of_scope cleanup( [&]() {
        current.reset();
    } );
    cata_mp::set_client_mode( true );
    cata_mp::mp_store_pending_welcome(
        R"({"type":"welcome","world_id":"11111111111111111111111111111111","world":"old world","host_name":"old host","seed":42,"host_omt":[3,4,0]})" );
    REQUIRE( cata_mp::mp_client_spawn_omt() == tripoint_abs_omt( 3, 4, 0 ) );
    // UI intent and a welcome string are insufficient: only a successful live
    // unjoined probe may retain its spawn metadata across production setup.
    REQUIRE_FALSE( current.client.pending_admission() );
    current.prepare_for_world_load();
    CHECK_FALSE( cata_mp::is_client_mode() );
    CHECK( cata_mp::mp_client_host_world_name().empty() );
    CHECK( cata_mp::mp_client_host_player_name().empty() );
    CHECK( cata_mp::mp_client_spawn_omt() == tripoint_abs_omt::invalid );
    CHECK( current.admission.pending_welcome.empty() );
}

TEST_CASE( "activated_mutation_flags_belong_to_the_queried_player",
           "[multiplayer][world_session][body_authority][regression]" )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_avatar();
    clear_map_without_vision();
    npc remote;
    remote.normalize();
    remote.set_stored_kcal( remote.get_healthy_kcal() );
    const trait_id mutation( "WEB_RAPPEL" );
    const json_character_flag flag( "WEB_RAPPEL" );
    avatar &local = get_avatar();
    local.set_mutation( mutation );
    remote.set_mutation( mutation );
    REQUIRE( remote.can_power_mutation( mutation ) );
    remote.activate_mutation( mutation );
    REQUIRE( remote.has_active_mutation( mutation ) );
    REQUIRE_FALSE( local.has_active_mutation( mutation ) );
    CHECK( remote.has_trait_flag( flag ) );
    CHECK( remote.count_trait_flag( flag ) == 1 );
    CHECK_FALSE( local.has_trait_flag( flag ) );
    CHECK( local.count_trait_flag( flag ) == 0 );
    remote.deactivate_mutation( mutation );
    local.activate_mutation( mutation );
    CHECK_FALSE( remote.has_trait_flag( flag ) );
    CHECK( remote.count_trait_flag( flag ) == 0 );
    CHECK( local.has_trait_flag( flag ) );
    CHECK( local.count_trait_flag( flag ) == 1 );
    clear_avatar();
}

// Requires the co-op runtime adjacent to the test executable, as for the game.
TEST_CASE( "group_wait_requires_every_grant_even_when_every_player_is_passive",
           "[.multiplayer_runtime][turn_coordination][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        clear_avatar();
    } );
    const bool started = session.hosting.start( 0, "", "turn-regression" );
    INFO( session.hosting.error() );
    REQUIRE( started );
    auto &queue = cata_mp::get_mp_queue();
    avatar &local = get_avatar();
    local.assign_activity( wait_activity_actor( 100_seconds ) );
    player_activity waiting{ wait_activity_actor( 100_seconds ) };
    waiting.set_execution( activity_execution::authoritative );
    for( int i = 0; i < 3; ++i ) {
        auto &peer = make_test_remote( session, 801 + i );
        const cata_mp::player_id owner( std::string( 32, '1' + i ) );
        npc &actor = spawn_npc( { 61 + i, 60 }, "test_talker" );
        actor.set_value( "mp_proxy", std::string( "1" ) );
        actor.set_value( "mp_player_id", owner.str() );
        peer.actor.bind_player( actor, owner, g->npc_lifetimes(),
                                g->player_controls().claim( owner, actor ) );
        peer.connected = true;
        actor.assign_activity( waiting );
    }
    REQUIRE( cata_mp::should_fast_forward() );
    auto &last = *session.remote_players.at( 803 );
    npc *sleeper = last.actor.retained( g->npc_lifetimes() );
    REQUIRE( sleeper );
    sleeper->activity.set_to_null();
    CHECK_FALSE( cata_mp::should_fast_forward() );
    REQUIRE( queue.push( { cata_mp::mp_event::type::action, "player",
                           R"({"action":"activity_start","activity_id":"ACT_TRY_SLEEP","client_sleeping":true})",
                           last.admission } ) );
    cata_mp::process_mp_events();
    CHECK_FALSE( cata_mp::should_fast_forward() );
    const efftype_id sleep( "sleep" );
    sleeper->add_effect( sleep, 10_hours );
    CHECK( cata_mp::should_fast_forward() );
    local.activity.set_to_null();
    local.add_effect( sleep, 10_hours );
    CHECK( cata_mp::should_fast_forward() );
    sleeper->remove_effect( sleep );
    sleeper->assign_activity( waiting );

    // Another session poll must not replenish an outstanding budget.
    cata_mp::grant_client_turn();
    for( const auto &entry : session.remote_players ) {
        const auto &peer = *entry.second;
        CHECK( peer.turn.grant_seq == 1 );
        CHECK( peer.turn.remote_moves == 100 );
    }
    const auto step = []( const npc &actor ) {
        return test_granted_action(
                   R"({"action":"inventory_activity","operation":"step","request":1,"inventory_revision":0,"activity":")" +
                   std::to_string( actor.activity.identity_generation() ) + "\"}", 1 );
    };
    for( int i = 0; i < 2; ++i ) {
        const auto &peer = *session.remote_players.at( 801 + i );
        const npc *actor = peer.actor.retained( g->npc_lifetimes() );
        REQUIRE( actor );
        REQUIRE( queue.push( { cata_mp::mp_event::type::action, "player", step( *actor ),
                               peer.admission } ) );
    }
    cata_mp::process_mp_events();
    REQUIRE_FALSE( cata_mp::client_acted_this_turn() );
    const auto admission = last.admission;
    const auto packet = step( *sleeper );
    // The queue is the only shared object; all world/actor access stays here.
    std::thread reply( [&queue, packet, admission]() {
        std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
        static_cast<void>( queue.push( { cata_mp::mp_event::type::action, "player", packet,
                                         admission } ) );
    } );
    const on_out_of_scope join( [&]() {
        reply.join();
    } );
    cata_mp::wait_for_client_action();
    CHECK( last.turn.client_acted_this_turn );
    CHECK( cata_mp::client_acted_this_turn() );
    CHECK_FALSE( session.host_waiting_for_clients );
    sleeper->add_effect( sleep, 10_hours );
    last.turn.remote_moves = 100;
    cata_mp::grant_client_turn();
    CHECK_FALSE( last.turn.granted_this_turn );
    CHECK( last.turn.remote_moves == 0 );
    CHECK( cata_mp::client_acted_this_turn() );
}

TEST_CASE( "authoritative_melee_uses_native_rng_damage_and_action_cost", "[multiplayer][melee]" )
{
    clear_avatar();
    clear_map();
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        get_creature_tracker().clear();
    } );
    get_avatar().setpos( get_map(), tripoint_bub_ms( 90, 90, 0 ) );
    npc &actor = bind_test_player( session );
    npc &reference = spawn_npc( { 70, 60 }, "test_talker" );
    const auto reference_control = g->player_controls().claim(
                                       cata_mp::player_id( std::string( 32, '8' ) ), reference );
    for( Character *person : {
             &actor, &reference
         } ) {
        clear_character( *person, true );
        person->set_wielded_item( item( itype_id( "spear_wood" ) ) );
        person->set_skill_level( skill_id( "melee" ), 5 );
        person->reset_cardio_acc();
        person->set_stamina( person->get_stamina_max() );
        person->set_moves( 100 );
    }
    actor.set_value( "mp_proxy", std::string( "1" ) );
    actor.set_value( "mp_player_id", test_player().str() );
    reference.setpos( get_map(), tripoint_bub_ms( 70, 60, 0 ) );
    cata_mp::melee_action action = cata_mp::melee_action::strike;
    const matec_id technique( "test_active_strike" );
    SECTION( "adjacent_strike" ) {}
    SECTION( "reach_attack" ) {
        action = cata_mp::melee_action::reach;
    }
    SECTION( "active_technique" ) {
        action = cata_mp::melee_action::technique;
        for( Character *person : {
                 &actor, &reference
             } ) {
            person->set_wielded_item( item( itype_id( "test_weapon1" ) ) );
            const matype_id style( "test_style_ma1" );
            person->martial_arts_data->add_martialart( style );
            person->martial_arts_data->set_style( style );
        }
    }
    const int distance = action == cata_mp::melee_action::reach ? 2 : 1;
    auto first = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                                            tripoint_bub_ms( 60 + distance, 60, 0 ) );
    first->set_hp( 1000 );
    auto second = make_shared_fast<monster>( *first );
    second->spawn( tripoint_bub_ms( 70 + distance, 60, 0 ) );
    REQUIRE( get_creature_tracker().add( first ) );
    REQUIRE( get_creature_tracker().add( second ) );
    const auto before = rng_get_engine();
    if( action == cata_mp::melee_action::reach ) {
        reference.reach_attack( second->pos_bub(), -1, false );
    } else if( action == cata_mp::melee_action::technique ) {
        REQUIRE( reference.use_active_technique( *second, technique ) );
    } else {
        reference.melee_attack( *second, true );
    }
    const auto expected_rng = rng_get_engine();
    rng_get_engine() = before;
    cata_mp::melee_intent intent;
    intent.action = action;
    intent.technique = technique;
    intent.origin = actor.pos_abs();
    intent.target = first->pos_abs();
    cata_mp::execute_melee_intent( actor, get_map(), intent );
    CHECK( first->get_hp() == second->get_hp() );
    CHECK( actor.get_moves() == reference.get_moves() );
    CHECK( actor.get_stamina() == reference.get_stamina() );
    CHECK( actor.get_focus_pool() == reference.get_focus_pool() );
    CHECK( actor.get_skill_level_object( skill_id( "melee" ) ).exercise( true ) ==
           reference.get_skill_level_object( skill_id( "melee" ) ).exercise( true ) );
    CHECK( rng_get_engine() == expected_rng );
}

TEST_CASE( "melee_intent_rejects_stale_targets_and_attached_mutation_payloads",
           "[multiplayer][melee]" )
{
    clear_avatar();
    clear_map();
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        get_creature_tracker().clear();
    } );
    get_avatar().setpos( get_map(), tripoint_bub_ms( 90, 90, 0 ) );
    npc &actor = bind_test_player( session );
    auto &peer = only_test_remote( session );
    peer.connected = true;
    clear_character( actor, true );
    actor.set_value( "mp_proxy", std::string( "1" ) );
    actor.set_value( "mp_player_id", test_player().str() );
    actor.set_wielded_item( item( itype_id( "spear_wood" ) ) );
    auto target = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ), tripoint_bub_ms( 61, 60,
                  0 ) );
    target->set_hp( 1000 );
    REQUIRE( get_creature_tracker().add( target ) );
    cata_mp::serialize_remote_player_state( peer );
    const auto id = session.replication.entity_ids.known_id( *target );
    REQUIRE( id != 0 );
    uint64_t request_revision = peer.pickup.revision;
    const auto send = [&]( uint32_t target_id, tripoint_abs_ms position ) {
        std::ostringstream text;
        JsonOut out( text );
        out.start_object();
        out.member( "action", "melee" );
        out.member( "mode", "strike" );
        out.member( "origin", actor.pos_abs() );
        out.member( "target", position );
        out.member( "target_monster", target_id );
        out.member( "grant_seq", peer.turn.grant_seq );
        out.member( "inventory_revision", request_revision );
        out.member( "char_stats" );
        out.start_object();
        out.member( "str", 999 );
        out.end_object();
        out.member( "client_monster_hits" );
        out.start_array();
        out.start_object();
        out.member( "nid", id );
        out.member( "hp", 1 );
        out.end_object();
        out.end_array();
        out.end_object();
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player", text.str(), peer.admission } ) );
        cata_mp::process_mp_events();
    };
    const int strength = actor.get_str_base();
    const auto before = rng_get_engine();
    send( id + 100, target->pos_abs() );
    CHECK( target->get_hp() == 1000 );
    CHECK( actor.get_str_base() == strength );
    CHECK_FALSE( peer.turn.client_acted_this_turn );
    CHECK( rng_get_engine() == before );
    request_revision = peer.pickup.revision;
    target->setpos( get_map(), tripoint_bub_ms( 65, 60, 0 ) );
    send( id, target->pos_abs() );
    CHECK( target->get_hp() == 1000 );
    CHECK_FALSE( peer.turn.client_acted_this_turn );
    request_revision = peer.pickup.revision;
    target->setpos( get_map(), tripoint_bub_ms( 61, 60, 0 ) );
    bool partial_turn = false;
    peer.turn.remote_moves = 1;
    SECTION( "attack_spends_full_budget" ) {}
    SECTION( "fast_attack_preserves_remaining_budget" ) {
        peer.turn.remote_moves = 1000;
        partial_turn = true;
    }
    send( id, target->pos_abs() );
    CHECK( actor.get_str_base() == strength );
    CHECK( target->get_hp() > 1 );
    CHECK( peer.turn.remote_moves == actor.get_moves() );
    if( partial_turn ) {
        CHECK( peer.turn.remote_moves > 0 );
        REQUIRE_FALSE( peer.turn.client_acted_this_turn );
    } else {
        REQUIRE( peer.turn.client_acted_this_turn );
    }
    const int hp = target->get_hp();
    const auto settled_rng = rng_get_engine();
    send( id, target->pos_abs() );
    CHECK( target->get_hp() == hp );
    CHECK( rng_get_engine() == settled_rng );
}

TEST_CASE( "melee_result_preserves_weapon_identity_and_skill_progress_without_stale_rollback",
           "[multiplayer][melee]" )
{
    clear_avatar();
    clear_map();
    npc &actor = spawn_npc( { 61, 60 }, "test_talker" );
    const on_out_of_scope cleanup( [&]() {
        clear_npcs();
        clear_avatar();
    } );
    clear_character( actor, true );
    actor.set_wielded_item( item( itype_id( "spear_wood" ) ) );
    actor.get_skill_level_object( skill_id( "melee" ) ).set_exercise( 4321, true );
    actor.set_focus_pool( 43210 );
    const auto control = g->player_controls().claim(
                             cata_mp::player_id( std::string( 32, '8' ) ), actor );
    actor.set_stamina( 1234 );
    actor.add_effect( efftype_id( "stunned" ), 3_turns );
    cata_mp::pickup_host_state host;
    cata_mp::pickup_client_state client;
    const std::string wire = cata_mp::make_combat_result( actor, host );
    JsonValue value = json_loader::from_string( wire );
    JsonObject message = value.get_object();
    message.allow_omitted_members();
    avatar &observer = get_avatar();
    const auto before_rng = rng_get_engine();
    REQUIRE( cata_mp::apply_combat_result( observer, message, client ) );
    CHECK( rng_get_engine() == before_rng );
    REQUIRE( observer.get_wielded_item() );
    CHECK( observer.get_wielded_item()->uid() == actor.get_wielded_item()->uid() );
    CHECK( observer.get_stamina() == 1234 );
    CHECK( observer.get_focus_pool() == 43210 );
    CHECK( observer.get_skill_level_object( skill_id( "melee" ) ).exercise( true ) == 4321 );
    CHECK( observer.get_effect_dur( efftype_id( "stunned" ) ) == 3_turns );
    observer.set_stamina( 500 );
    CHECK_FALSE( cata_mp::apply_combat_result( observer, message, client ) );
    CHECK( observer.get_stamina() == 500 );
}

TEST_CASE( "mp_incomplete_first_join_never_persists_a_default_character",
           "[multiplayer][world_session][player_identity]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const cata_mp::player_credentials profile{ player_id( std::string( 32, '8' ) ),
            std::string( 64, 'c' ) };
    const auto record = PATH_INFO::world_base_save_path() / ( "mp_actor_" + profile.id.str() +
                        ".json" );
    REQUIRE_FALSE( file_exist( record ) );
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        remove_file( record );
        remove_file( PATH_INFO::world_base_save_path() / "mp_npc_cleanup.json" );
        cata_mp::get_mp_queue().clear();
    } );
    const auto admission = cata_mp::peer_admission::create( 901 );
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::connect,
                                           "pending", "", admission, profile } ) );
    cata_mp::process_mp_events();
    REQUIRE( session.find_remote( admission ) );
    REQUIRE( session.find_remote( admission )->awaiting_character );
    CHECK( cata_mp::mp_save_remote_player() );
    CHECK_FALSE( file_exist( record ) );
    SECTION( "disconnect before sending character" ) {
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect,
                                               "pending", "", admission } ) );
    }
    SECTION( "invalid character rejected without a record" ) {
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "pending",
                                               R"({"action":"player_create","player_state":{"schema":999}})", admission } ) );
    }
    cata_mp::process_mp_events();
    CHECK( session.remote_players.empty() );
    CHECK_FALSE( file_exist( record ) );
    CHECK_FALSE( g->player_controls().is_reserved( profile.id ) );
}
