#include "cata_catch.h"

#include <initializer_list>
#include <sstream>

#include "avatar.h"
#include "cata_scope_helpers.h"
#include "creature_tracker.h"
#include "game.h"
#include "json.h"
#include "json_loader.h"
#include "map_helpers.h"
#include "monster.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_world_session.h"
#include "mtype.h"
#include "player_helpers.h"
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
    session.peer.mp_remote_pos = get_avatar().pos_abs();
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
    REQUIRE( session.replication.client.last_monster_hp.empty() );
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

TEST_CASE( "mp_client_damage_reports_use_only_current_native_bindings",
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
    session.peer.mp_remote_pos = get_avatar().pos_abs();
    auto original = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                    tripoint_bub_ms( 62, 60, 0 ) );
    REQUIRE( get_creature_tracker().add( original ) );
    REQUIRE( cata_mp::client_apply_message( state_message( {{ 17, original.get(), 70 }} ) ) );
    auto copied = make_shared_fast<monster>( *original );
    copied->spawn( original->pos_abs() + tripoint::east );
    REQUIRE( get_creature_tracker().add( copied ) );
    original->set_hp( 50 );
    copied->set_hp( 20 );
    const auto check_report = [&]( int hp ) {
        JsonValue value = json_loader::from_string( cata_mp::client_enrich_action(
                              R"({"type":"action","action":"wait"})" ) );
        JsonObject action = value.get_object();
        action.allow_omitted_members();
        JsonArray hits = action.get_array( "client_monster_hits" );
        REQUIRE( hits.size() == 1 );
        JsonObject hit = hits.get_object( 0 );
        CHECK( hit.get_int( "nid" ) == 17 );
        CHECK( hit.get_int( "hp" ) == hp );
    };
    check_report( 50 );
    CHECK( session.replication.client.monsters.known_id( *copied ) == 0 );
    original->set_hp( 0 );
    check_report( 0 );
    CHECK( session.replication.client.client_pending_kill.count( 17 ) == 1 );
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
    session.peer.mp_remote_pos = get_avatar().pos_abs();
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
