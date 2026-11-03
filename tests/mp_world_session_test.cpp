#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "creature_tracker.h"
#include "game.h"
#include "json_loader.h"
#include "json.h"
#include "item.h"
#include "item_location.h"
#include "map_helpers.h"
#include "monster.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_protocol.h"
#include "mp_queue.h"
#include "mp_world_session.h"
#include "mp_test_helpers.h"
#include "rng.h"
#include "avatar.h"
#include "activity_actor_definitions.h"
#include "calendar.h"
#include "cata_utility.h"
#include "filesystem.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "player_helpers.h"
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
    send( admissions[0], R"({"action":"worn_sync","char_stats":{"name":"first owner"}})" );
    send( admissions[1], R"({"action":"worn_sync","char_stats":{"name":"second owner"}})" );
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
    send( admissions[1], R"({"action":"worn_sync","client_activity":""})" );
    cata_mp::process_mp_events();
    CHECK( get_avatar().activity.id().str() == "ACT_HELP_PARTNER" );
    send( admissions[2], R"({"action":"worn_sync","client_activity":""})" );
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
    send( admissions[0], R"({"action":"worn_sync","char_stats":{"name":"stale owner"}})" );
    cata_mp::process_mp_events();
    CHECK( first->actor.retained( g->npc_lifetimes() )->name == "first owner" );
    CHECK( second_actor->name == "second owner" );
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
             R"({"action":"worn_sync"})",
             R"({"action":"activity_start","activity_id":"ACT_WAIT"})",
             R"({"action":"activity_end","activity_id":"ACT_WAIT"})",
             R"({"action":"save_request"})",
             R"({ "type" : "action", "action" : "worn_sync", "char_stats":{} })",
             R"({"type":"note_sync"})", R"({"type":"chat"})",
             R"({"type":"templates_list"})", R"({"type":"resync_request"})"
         } ) {
        CAPTURE( message );
        CHECK( cata_mp::is_state_sync_message( message ) );
    }
    for( const char *message : {
             R"({"type":"trade_delta","give":[]})",
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
    npc &remote = bind_test_player( session );
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
    push( R"({"action":"wait","client_stamina":100)" + attached_delta + "}",
          only_test_remote( session ).admission );
    push( R"({"action":"worn_sync","char_stats":{"name":"after first"}})",
          only_test_remote( session ).admission );
    // Stale events do not consume the current peer's budget or block its queue.
    push( R"({"action":"wait","client_stamina":300})",
          cata_mp::peer_admission::create( 702 ) );
    push( R"({"action":"wait","client_stamina":200)" + attached_delta + "}",
          only_test_remote( session ).admission, 2 );
    push( R"({"action":"worn_sync","char_stats":{"name":"after second"}})",
          only_test_remote( session ).admission );

    cata_mp::process_mp_events();
    CHECK( remote.get_stamina() == 100 );
    CHECK( remote.name == "after first" );
    REQUIRE_FALSE( queue.empty() );

    next_test_remote_turn( only_test_remote( session ) );
    cata_mp::process_mp_events();
    CHECK( remote.get_stamina() == 200 );
    CHECK( remote.name == "after second" );
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
    npc &remote = bind_test_player( session );
    only_test_remote( session ).connected = true;
    set_test_admission( session, cata_mp::peer_admission::create( 701 ) );
    auto &queue = cata_mp::get_mp_queue();
    const auto push_sync = [&]( int index, size_t padding ) {
        const std::string data = R"({"action":"worn_sync","char_stats":{"name":"sync-)" +
                                 std::to_string( index ) + R"("},"padding":")" +
                                 std::string( padding, 'x' ) + R"("})";
        REQUIRE( queue.push( { cata_mp::mp_event::type::action, "nickname", data,
                               only_test_remote( session ).admission } ) );
    };

    SECTION( "a flood of small syncs yields before the final update" ) {
        for( int i = 0; i < 65; ++i ) {
            push_sync( i, 0 );
        }
        cata_mp::process_mp_events();
        CHECK( remote.name == "sync-63" );
        CHECK( queue.current_usage().queued == 1 );
        cata_mp::process_mp_events();
        CHECK( remote.name == "sync-64" );
        CHECK( queue.empty() );
    }
    SECTION( "large syncs share a byte budget" ) {
        push_sync( 0, 600 * 1024 );
        push_sync( 1, 600 * 1024 );
        cata_mp::process_mp_events();
        CHECK( remote.name == "sync-0" );
        CHECK( queue.current_usage().queued == 1 );
        cata_mp::process_mp_events();
        CHECK( remote.name == "sync-1" );
        CHECK( queue.empty() );
    }
    SECTION( "one oversized sync progresses without starving the queue" ) {
        push_sync( 0, 1024 * 1024 + 64 );
        push_sync( 1, 0 );
        cata_mp::process_mp_events();
        CHECK( remote.name == "sync-0" );
        CHECK( queue.current_usage().queued == 1 );
        cata_mp::process_mp_events();
        CHECK( remote.name == "sync-1" );
        CHECK( queue.empty() );
    }
    SECTION( "discarding stale events also yields" ) {
        const auto stale = cata_mp::peer_admission::create( 702 );
        const std::string original_name = remote.name;
        for( int i = 0; i < 65; ++i ) {
            REQUIRE( queue.push( { cata_mp::mp_event::type::action, "nickname",
                                   R"({"action":"worn_sync","char_stats":{"name":"stale"}})", stale } ) );
        }
        cata_mp::process_mp_events();
        CHECK( remote.name == original_name );
        CHECK( queue.current_usage().queued == 1 );
        cata_mp::process_mp_events();
        CHECK( remote.name == original_name );
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
    const auto send = [&]( uint32_t grant, int stamina ) {
        const auto packet = test_granted_action( R"({"action":"wait","client_stamina":)" +
                            std::to_string( stamina ) + "}", grant );
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action,
                                               "player", packet, peer.admission } ) );
        cata_mp::process_mp_events();
    };
    actor.set_stamina( 500 );
    send( 40, 100 );
    send( 42, 200 );
    CHECK( actor.get_stamina() == 500 );
    CHECK_FALSE( peer.turn.client_acted_this_turn );
    send( 41, 300 );
    CHECK( actor.get_stamina() == 300 );
    REQUIRE( peer.turn.client_acted_this_turn );
    send( 41, 400 );
    CHECK( actor.get_stamina() == 300 );
    next_test_remote_turn( peer );
    send( 41, 100 );
    CHECK_FALSE( peer.turn.client_acted_this_turn );
    send( 42, 450 );
    CHECK( peer.turn.client_acted_this_turn );
    CHECK( actor.get_stamina() == 450 );
}

TEST_CASE( "mp_native_hit_dispatch_ignores_copied_or_stale_monster_wire_ids",
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
    CHECK( copied->get_hp() == 1 );
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
    };
    connect( 101, profile );
    REQUIRE( only_test_remote( session ).connected );
    const auto original_id = only_test_remote( session ).actor.id();
    REQUIRE( original_id.is_valid() );
    npc *actor = g->critter_by_id<npc>( original_id );
    REQUIRE( actor );
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
    actor->name = "before final sync";
    actor->set_value( "identity_regression", std::string( "retained" ) );
    std::filesystem::rename( record.get_unrelative_path(), backup.get_unrelative_path() );
    std::filesystem::create_directory( record.get_unrelative_path() );
    // The worker accepted this final action before observing disconnect. Its
    // retirement must not reorder the owner stream or lose the saved update.
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                           R"({"action":"worn_sync","char_stats":{"name":"Rosalee Blanco"}})",
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
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", admissions.at( 101 ) } ) );
    cata_mp::process_mp_events();
    CHECK( only_test_remote( session ).connected );
    CHECK( only_test_remote( session ).admission.peer_id() == 202 );
    only_test_remote( session ).replication.host_veh_cargo_baseline[tripoint_abs_ms( 1, 2,
                             0 )] = "old cargo";
    only_test_remote( session ).replication.last_vehicle_step_payload = "old stationary vehicles";
    only_test_remote( session ).turn.pending_wake_client = true;
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
    CHECK_FALSE( only_test_remote( session ).turn.pending_wake_client );
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
    const auto rename = [&]() {
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                               R"({"action":"worn_sync","char_stats":{"name":"accepted owner"}})", only_test_remote( session ).admission } ) );
        cata_mp::process_mp_events();
    };
    rename();
    REQUIRE( actor.name == "accepted owner" );
    actor.name = "unchanged";

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
        rename();
        CHECK( actor.name == "unchanged" );
        CHECK_FALSE( before.resolve( g->npc_lifetimes() ) );
        g->load_npcs();
        rename();
        CHECK( actor.name == "accepted owner" );
        CHECK_FALSE( before.resolve( g->npc_lifetimes() ) );
    }
    SECTION( "removal from the active tracker is sufficient to reject control" ) {
        // remove_npc does not invoke on_unload: an active lifetime alone is
        // insufficient without exact membership in the current native tracker.
        g->remove_npc( actor.getID() );
        rename();
        CHECK( actor.name == "unchanged" );
        g->load_npcs();
        rename();
        CHECK( actor.name == "accepted owner" );
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
        rename();
        CHECK( replacement->name == "replacement" );
        CHECK( actor.name == "unchanged" );
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
    actor->name = "current owner";
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                           R"({"action":"worn_sync","char_stats":{"name":"foreign live admission"}})",
                                           cata_mp::peer_admission::create( 202 ) } ) );
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                           R"({"action":"worn_sync","char_stats":{"name":"stale action"}})", previous } ) );
    // Same display name, different transport peer. Exercise the real dispatch
    // path, not just the predicate: the disconnect must never reach despawn.
    REQUIRE( cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", cata_mp::peer_admission::create( 101 )} ) );
    REQUIRE( cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", cata_mp::peer_admission::create( 0 )} ) );
    cata_mp::process_mp_events();
    CHECK( cata_mp::get_mp_queue().empty() );
    CHECK( only_test_remote( session ).connected );
    CHECK( only_test_remote( session ).admission.peer_id() == 202 );
    CHECK( actor->name == "current owner" );
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

TEST_CASE( "mp_client_body_updates_restart_in_a_new_world_at_the_same_time",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    auto &session = g->multiplayer_session();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_avatar();
    } );
    clear_map_without_vision();
    const auto start_world = [&]() {
        session.reset();
        calendar::turn = calendar::turn_zero + 11_hours;
        clear_avatar();
        cata_mp::set_client_mode( true );
        avatar &player = get_avatar();
        player.set_stamina( player.get_stamina_max() / 2 );
        calendar::turn += 1_turns;
        return player.get_stamina();
    };
    const int first_initial = start_world();
    cata_mp::client_character_turn_driver( get_avatar() ).update_body();
    const int first_updated = get_avatar().get_stamina();
    REQUIRE( first_updated > first_initial );
    cata_mp::client_character_turn_driver( get_avatar() ).update_body();
    CHECK( get_avatar().get_stamina() == first_updated );

    const int second_initial = start_world();
    cata_mp::client_character_turn_driver( get_avatar() ).update_body();
    CHECK( get_avatar().get_stamina() > second_initial );
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
    for( int i = 0; i < 3; ++i ) {
        auto &peer = make_test_remote( session, 801 + i );
        const cata_mp::player_id owner( std::string( 32, '1' + i ) );
        npc &actor = spawn_npc( { 61 + i, 60 }, "test_talker" );
        actor.set_value( "mp_proxy", std::string( "1" ) );
        actor.set_value( "mp_player_id", owner.str() );
        peer.actor.bind_player( actor, owner, g->npc_lifetimes(),
                                g->player_controls().claim( owner, actor ) );
        peer.connected = true;
        peer.observation.partner_activity = "ACT_WAIT";
    }
    REQUIRE( cata_mp::should_fast_forward() );
    auto &last = *session.remote_players.at( 803 );
    last.observation.partner_activity.clear();
    CHECK_FALSE( cata_mp::should_fast_forward() );
    last.observation.partner_sleeping = true;
    CHECK( cata_mp::should_fast_forward() );
    local.activity.set_to_null();
    const efftype_id sleep( "sleep" );
    local.add_effect( sleep, 10_hours );
    CHECK( cata_mp::should_fast_forward() );

    // Another session poll must not replenish an outstanding budget.
    cata_mp::grant_client_turn();
    for( const auto &entry : session.remote_players ) {
        const auto &peer = *entry.second;
        CHECK( peer.turn.grant_seq == 1 );
        CHECK( peer.turn.remote_moves == 100 );
    }
    const auto packet = test_granted_action( R"({"action":"wait","client_activity":"ACT_WAIT"})", 1 );
    for( int i = 0; i < 2; ++i ) {
        REQUIRE( queue.push( { cata_mp::mp_event::type::action, "player", packet,
                               session.remote_players.at( 801 + i )->admission } ) );
    }
    cata_mp::process_mp_events();
    REQUIRE_FALSE( cata_mp::client_acted_this_turn() );
    const auto admission = last.admission;
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
}
