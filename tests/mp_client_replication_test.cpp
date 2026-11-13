#include "cata_catch.h"

#include <initializer_list>
#include <memory>
#include <sstream>

#include "avatar.h"
#include "avatar_action.h"
#include "calendar.h"
#include "rng.h"
#include "activity_actor_definitions.h"
#include "cata_scope_helpers.h"
#include "creature_tracker.h"
#include "game.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "mapbuffer.h"
#include "monster.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_world_session.h"
#include "player_activity.h"
#include "mtype.h"
#include "player_helpers.h"
#include "submap.h"
#include "worldfactory.h"

namespace
{
struct wire_monster {
    int id;
    const monster *native;
    int hp;
};

std::string state_message( std::initializer_list<wire_monster> monsters,
                           std::initializer_list<int> removed = {} )
{
    std::ostringstream out;
    JsonOut json( out );
    json.start_object();
    json.member( "type", "state" );
    json.member( "monsters" );
    json.start_array();
    for( const auto &entry : monsters ) {
        json.start_object();
        json.member( "nid", entry.id );
        json.member( "id", entry.native->type->id.str() );
        json.member( "x", entry.native->pos_abs().x() );
        json.member( "y", entry.native->pos_abs().y() );
        json.member( "z", entry.native->pos_abs().z() );
        json.member( "hp", entry.hp );
        json.end_object();
    }
    json.end_array();
    json.member( "removed_monsters" );
    json.start_array();
    for( const int id : removed ) {
        json.write( id );
    }
    json.end_array();
    json.end_object();
    return out.str();
}
} // namespace

TEST_CASE( "mp_client_pins_authority_world_independently_of_local_world",
           "[multiplayer][world_identity][regression]" )
{
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
    } );
    const world_id local = world_generator->active_world->identity();
    const std::string remote_id( 32, local.str() == std::string( 32, '1' ) ? '2' : '1' );
    cata_mp::set_client_mode( true );
    cata_mp::mp_store_pending_welcome( "{\"type\":\"welcome\",\"world_id\":\"" + remote_id + "\"}" );
    CHECK( session.admission.host_world.str() == remote_id );
    CHECK( session.admission.host_world != local );
    const auto pending = session.admission.pending_welcome;
    const auto seed = g->get_seed();
    CHECK_FALSE( cata_mp::client_apply_message(
                     R"({"type":"welcome","world_id":"33333333333333333333333333333333","seed":999})" ) );
    CHECK_FALSE( cata_mp::client_apply_message( R"({"type":"welcome","seed":999})" ) );
    CHECK_THROWS( cata_mp::mp_store_pending_welcome( R"({"type":"welcome","world_id":"bad"})" ) );
    CHECK( session.admission.pending_welcome == pending );
    CHECK( session.admission.host_world.str() == remote_id );
    CHECK( g->get_seed() == seed );
    CHECK( world_generator->active_world->identity() == local );
    session.reset();
    CHECK_FALSE( session.admission.host_world.valid() );
}

TEST_CASE( "mp_client_exits_replica_without_switching_to_solo",
           "[multiplayer][client_replication][regression]" )
{
    auto &session = g->multiplayer_session();
    session.reset();
    const restore_on_out_of_scope restore_quit( g->uquit );
    avatar &guest = get_avatar();
    const int previous_moves = guest.get_moves();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        guest.set_moves( previous_moves );
    } );
    g->uquit = QUIT_NO;
    guest.set_moves( 100 );
    cata_mp::set_client_mode( true );
    const std::string packet = GENERATE(
                                   R"({"type":"session_ending","from":"host"})",
                                   R"({"type":"state","connected":false})",
                                   R"({"type":"inventory_update"})" );
    REQUIRE( cata_mp::client_apply_message( packet ) );
    CHECK( cata_mp::is_client_mode() );
    CHECK( guest.get_moves() == 0 );
    CHECK( g->uquit == QUIT_NOSAVED );
    CHECK_FALSE( session.client_turn.exit_reason.empty() );
    CHECK_FALSE( cata_mp::client_apply_message( packet ) );
}

TEST_CASE( "mp_client_applies_terrain_after_following_a_distant_authoritative_position",
           "[multiplayer][client_replication][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_overmaps();
    } );
    const restore_on_out_of_scope restore_quit( g->uquit );
    g->uquit = QUIT_NO;
    cata_mp::set_client_mode( true );
    map &here = get_map();
    const tripoint_bub_ms local( HALF_MAPSIZE_X, HALF_MAPSIZE_Y, 0 );
    get_avatar().setpos( here, local, false );
    const tripoint_abs_sm start = get_avatar().pos_abs_sm();
    const auto state = []( const tripoint_abs_ms &position ) {
        return R"({"type":"state","connected":true,"pos":{"x":)" + std::to_string( position.x() ) +
               ",\"y\":" + std::to_string( position.y() ) + ",\"z\":" +
               std::to_string( position.z() ) + "}}";
    };
    REQUIRE( cata_mp::client_apply_message( state( get_avatar().pos_abs() ) ) );
    const tripoint_abs_sm destination = start + point_rel_sm( MAPSIZE + 2, 0 );
    const tripoint_abs_ms absolute = project_to<coords::ms>( destination );
    REQUIRE_FALSE( here.inbounds( absolute ) );
    auto existing = std::make_unique<submap>();
    existing->set_all_ter( ter_str_id( "t_floor" ).id(), true );
    existing->last_touched = calendar::turn - 1_days;
    const time_point last_touched = existing->last_touched;
    REQUIRE( MAPBUFFER.add_submap( destination, existing ) );
    const std::string prefix = R"({"type":"map_sync","z":0,"pal":["t_wall","f_null"],"subs":[{"sx":)" +
                               std::to_string( destination.x() ) + ",\"sy\":" +
                               std::to_string( destination.y() );
    CHECK( cata_mp::client_apply_message( prefix + R"(,"t":[[99999999,0]],"f":[[144,1]]}]})" ) );
    CHECK( session.replication.client.pending_terrain.empty() );
    REQUIRE( cata_mp::client_apply_message( prefix + R"(,"t":[[144,0]],"f":[[144,1]]}]})" ) );
    REQUIRE( session.replication.client.pending_terrain.count( destination ) == 1 );
    REQUIRE( cata_mp::client_apply_message( state( absolute + point::east ) ) );
    CHECK( get_avatar().pos_abs() == absolute + point::east );
    CHECK( here.ter( here.get_bub( absolute ) ) == ter_str_id( "t_wall" ).id() );
    CHECK( MAPBUFFER.lookup_submap( destination )->last_touched == last_touched );
    CHECK( session.replication.client.pending_terrain.empty() );
}

TEST_CASE( "mp_client_new_admission_does_not_import_retained_monster_ids",
           "[multiplayer][client_replication][entity_identity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        get_creature_tracker().clear();
    } );
    cata_mp::set_client_mode( true );
    cata_mp::mp_store_pending_welcome(
        R"({"type":"welcome","world_id":"11111111111111111111111111111111"})" );
    session.host_observation.mp_remote_pos = get_avatar().pos_abs();
    auto first = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                                            tripoint_bub_ms( 62, 60, 0 ) );
    auto second = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                  tripoint_bub_ms( 66, 60, 0 ) );
    REQUIRE( get_creature_tracker().add( first ) );
    REQUIRE( get_creature_tracker().add( second ) );
    REQUIRE( cata_mp::client_apply_message( state_message( {{ 5, first.get(), 70 },
        { 6, second.get(), 60 }} ) ) );
    REQUIRE( session.replication.client.monsters.find( 5 ) == first.get() );
    REQUIRE( session.replication.client.monsters.find( 6 ) == second.get() );
    // A queued welcome within the same connection must not erase live bindings.
    REQUIRE( cata_mp::client_apply_message(
                 R"({"type":"welcome","world_id":"11111111111111111111111111111111","world":"first"})" ) );
    CHECK( session.replication.client.monsters.find( 5 ) == first.get() );
    // A new successful connection probe resets replication before its first
    // state, even when these native monsters have not been destroyed/reloaded.
    cata_mp::mp_store_pending_welcome(
        R"({"type":"welcome","world_id":"22222222222222222222222222222222","world":"next"})" );
    REQUIRE( session.replication.client.monsters.known_id( *first ) == 0 );
    REQUIRE( cata_mp::client_apply_message( state_message( {{ 5, second.get(), 40 }} ) ) );
    CHECK( session.replication.client.monsters.find( 5 ) == second.get() );
    CHECK( second->get_hp() == 40 );
    CHECK( first->get_hp() == 70 );
    CHECK_FALSE( get_creature_tracker().is_present( first.get() ) );
    // Omission from a delta is not a removal; an old host's ID cannot kill it.
    REQUIRE( cata_mp::client_apply_message( state_message( {}, { 6 } ) ) );
    CHECK( get_creature_tracker().is_present( second.get() ) );
    CHECK( session.replication.client.monsters.find( 5 ) == second.get() );
    session.reset();
    CHECK( session.replication.client.monsters.known_id( *second ) == 0 );
    CHECK_FALSE( cata_mp::client_apply_message( state_message( {{ 5, second.get(), 1 }} ) ) );
    CHECK( second->get_hp() == 40 );
}

TEST_CASE( "mp_monster_replica_uses_host_hp_and_despawns_without_death_effects",
           "[multiplayer][client_replication][entity_identity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        get_creature_tracker().clear();
    } );
    cata_mp::set_client_mode( true );
    cata_mp::mp_store_pending_welcome(
        R"({"type":"welcome","world_id":"11111111111111111111111111111111"})" );
    session.host_observation.mp_remote_pos = get_avatar().pos_abs();
    auto original = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                    tripoint_bub_ms( 62, 60, 0 ) );
    REQUIRE( get_creature_tracker().add( original ) );
    REQUIRE( cata_mp::client_apply_message( state_message( {{ 17, original.get(), 70 }} ) ) );
    original->set_hp( 50 );
    JsonValue value = json_loader::from_string( cata_mp::client_enrich_action(
                          R"({"type":"action","action":"wait"})" ) );
    JsonObject action = value.get_object();
    action.allow_omitted_members();
    CHECK_FALSE( action.has_member( "client_monster_hits" ) );

    REQUIRE( cata_mp::client_apply_message( state_message( {{ 17, original.get(), 65 }} ) ) );
    CHECK( original->get_hp() == 65 );
    REQUIRE( cata_mp::client_apply_message( state_message( {} ) ) );
    CHECK( session.replication.client.monsters.find( 17 ) == original.get() );

    map &here = get_map();
    const tripoint_bub_ms tile = original->pos_bub();
    const size_t item_count = here.i_at( tile ).size();
    const auto rng = rng_get_engine();
    const bool hp_removal = GENERATE( false, true );
    const std::string gone = hp_removal ? state_message( {{ 17, original.get(), 0 }} ) :
                             state_message( {}, { 17 } );
    REQUIRE( cata_mp::client_apply_message( gone ) );
    CHECK( session.replication.client.monsters.find( 17 ) == nullptr );
    CHECK_FALSE( get_creature_tracker().is_present( original.get() ) );
    CHECK( original->get_hp() == 65 );
    CHECK( here.i_at( tile ).size() == item_count );
    CHECK( rng_get_engine() == rng );
    REQUIRE( cata_mp::client_apply_message( gone ) );
    CHECK( here.i_at( tile ).size() == item_count );
}

TEST_CASE( "mp_client_duplicate_wire_ids_do_not_rebind_another_monster",
           "[multiplayer][client_replication][entity_identity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        get_creature_tracker().clear();
    } );
    cata_mp::set_client_mode( true );
    cata_mp::mp_store_pending_welcome(
        R"({"type":"welcome","world_id":"11111111111111111111111111111111"})" );
    session.host_observation.mp_remote_pos = get_avatar().pos_abs();
    auto original = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                    tripoint_bub_ms( 62, 60, 0 ) );
    REQUIRE( get_creature_tracker().add( original ) );
    REQUIRE( cata_mp::client_apply_message( state_message( {{ 17, original.get(), 70 }} ) ) );
    REQUIRE( cata_mp::client_apply_message( state_message( {{ 17, original.get(), 50 },
        { 17, original.get(), 1 }, { 0, original.get(), 2 }, { -1, original.get(), 3 }} ) ) );
    CHECK( original->get_hp() == 50 );
    CHECK( get_creature_tracker().size() == 1 );
    CHECK( session.replication.client.monsters.find( 17 ) == original.get() );
}

TEST_CASE( "client_turn_packets_do_not_execute_activities_or_replay_a_grant",
           "[multiplayer][turn_coordination][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const restore_on_out_of_scope restore_time( calendar::turn );
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_avatar();
    } );
    cata_mp::set_client_mode( true );
    avatar &actor = get_avatar();
    actor.assign_activity( wait_activity_actor( 100_seconds ) );
    const auto packet = []( int turn, int sequence, int moves, bool partial = false ) {
        std::ostringstream text;
        JsonOut out( text );
        out.start_object();
        out.member( "type", "state" );
        out.member( "calendar_turn", turn );
        out.member( "grant_seq", sequence );
        out.member( "moves", moves );
        out.member( "free", partial );
        out.end_object();
        return text.str();
    };
    REQUIRE( cata_mp::client_apply_message( packet( 1000, 41, 100 ) ) );
    CHECK( actor.activity.moves_left == 10000 );
    CHECK( actor.get_moves() == 100 );
    CHECK_FALSE( cata_mp::should_advance_calendar() );
    CHECK( cata_mp::client_begin_simulation_turn() );
    CHECK_FALSE( cata_mp::client_begin_simulation_turn() );
    actor.set_moves( 0 );
    cata_mp::client_mark_action_sent();
    REQUIRE( cata_mp::client_apply_message( packet( 1000, 41, 100 ) ) );
    CHECK( actor.get_moves() == 0 );
    CHECK( cata_mp::is_client_waiting_for_ack() );
    REQUIRE( cata_mp::client_apply_message( packet( 1000, 41, 0 ) ) );
    CHECK_FALSE( cata_mp::is_client_waiting_for_ack() );
    REQUIRE( cata_mp::client_apply_message( packet( 1001, 42, 100 ) ) );
    REQUIRE( cata_mp::client_apply_message( packet( 1000, 41, 0 ) ) );
    CHECK( calendar::turn == time_point( 1001 ) );
    CHECK( actor.get_moves() == 100 );
    CHECK( cata_mp::client_begin_simulation_turn() );
    REQUIRE( cata_mp::client_apply_message( packet( 1001, 42, 30, true ) ) );
    CHECK( actor.get_moves() == 30 );
    CHECK_FALSE( cata_mp::client_begin_simulation_turn() );
    REQUIRE( cata_mp::client_apply_message( packet( 1002, 42, -50 ) ) );
    CHECK( cata_mp::client_begin_simulation_turn() );
    CHECK( actor.get_moves() == -50 );
    CHECK( actor.activity.moves_left == 10000 );
}

TEST_CASE( "client_autoattack_submits_intent_without_local_damage_or_rng", "[multiplayer][melee]" )
{
    clear_avatar();
    clear_map();
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const restore_on_out_of_scope restore_time( calendar::turn );
    calendar::turn = calendar::turn_zero + 12_hours;
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        get_creature_tracker().clear();
        clear_avatar();
    } );
    cata_mp::set_client_mode( true );
    avatar &actor = get_avatar();
    actor.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    monster source( mtype_id( "mon_test_zombie" ), tripoint_bub_ms( 61, 60, 0 ) );
    REQUIRE( cata_mp::client_apply_message( state_message( { { 81, &source, 100 } } ) ) );
    monster *target = session.replication.client.monsters.find( 81 );
    REQUIRE( target );
    session.client_turn.client_last_grant_seq = 41;
    actor.set_moves( 100 );
    get_map().build_map_cache( 0 );
    const int stamina = actor.get_stamina();
    const auto rng = rng_get_engine();
    avatar_action::autoattack( actor, get_map() );
    CHECK( target->get_hp() == 100 );
    CHECK( actor.get_stamina() == stamina );
    CHECK( rng_get_engine() == rng );
    CHECK( actor.get_moves() == 0 );
    CHECK( cata_mp::is_client_waiting_for_ack() );
}
