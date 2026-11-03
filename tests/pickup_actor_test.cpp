#include <cstdint>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "game.h"
#include "inventory.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_pickup.h"
#include "mp_queue.h"
#include "mp_world_session.h"
#include "npc.h"
#include "pickup.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "rng.h"
#include "type_id.h"

namespace
{
void prepare_pickup_actor( Character &who )
{
    who.inv->clear();
    who.clear_worn();
    who.remove_weapon();
    REQUIRE( who.wear_item( item( itype_id( "backpack" ) ), false ).has_value() );
    who.set_moves( 1000 );
}

item &add_pickup_nails( map &here, const tripoint_bub_ms &pos, int charges,
                        const std::string &marker )
{
    item nails( itype_id( "nail" ) );
    nails.charges = charges;
    nails.set_var( "pickup_test_marker", marker );
    return here.add_item( pos, std::move( nails ) );
}

std::string carried_snapshot( const Character &who )
{
    std::ostringstream text;
    JsonOut out( text );
    who.store_carried_items( out );
    return text.str();
}

std::string ground_snapshot( map &here, const tripoint_bub_ms &pos )
{
    std::ostringstream text;
    JsonOut out( text );
    out.start_array();
    for( const item &it : here.i_at( pos ) ) {
        out.write( it );
    }
    out.end_array();
    return text.str();
}

std::string run_pickup_request( Character &who, const std::string &text,
                                cata_mp::pickup_host_state &state )
{
    JsonValue value = json_loader::from_string( text );
    JsonObject request = value.get_object();
    request.allow_omitted_members(); // The production dispatcher owns envelope metadata.
    return cata_mp::execute_pickup_request( who, get_map(), request, state );
}
} // namespace

TEST_CASE( "map_insertion_preserves_transferred_item_identity_and_clones_extra_copies",
           "[pickup][item_identity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos = get_avatar().pos_bub( here );
    item source( itype_id( "nail" ) );
    source.charges = 20;
    const auto original_uid = source.uid().get_value();
    REQUIRE( original_uid > 0 );

    SECTION( "transfer_one_or_several_items" ) {
        const int copies = GENERATE( 1, 3 );
        const auto rng_before = rng_get_engine();
        item &inserted = here.add_item( pos, std::move( source ), copies );
        CHECK( rng_get_engine() == rng_before );
        CHECK( inserted.uid().get_value() == original_uid );
        CHECK( source.uid().get_value() == 0 );
        std::set<int64_t> identities;
        for( const item &entry : here.i_at( pos ) ) {
            CHECK( entry.charges == 20 );
            CHECK( entry.uid().is_valid() );
            CHECK( identities.insert( entry.uid().get_value() ).second );
        }
        CHECK( static_cast<int>( identities.size() ) == copies );
        CHECK( identities.count( original_uid ) == 1 );
    }
    SECTION( "copying_a_retained_source_still_creates_a_distinct_item" ) {
        item &inserted = here.add_item( pos, source );
        CHECK( source.uid().get_value() == original_uid );
        CHECK( inserted.uid().get_value() != original_uid );
        CHECK( inserted.charges == source.charges );
    }
}

TEST_CASE( "mp_pickup_resolves_identity_after_authoritative_ground_replication",
           "[pickup][multiplayer][item_identity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
    } );
    npc &remote = spawn_npc( { 60, 60 }, "test_talker" );
    prepare_pickup_actor( remote );
    map &here = get_map();
    const tripoint_bub_ms pos = remote.pos_bub( here );
    const tripoint_abs_ms abs = here.get_abs( pos );
    here.i_clear( pos );
    item &original = add_pickup_nails( here, pos, 20, "replicated" );
    const auto original_uid = original.uid().get_value();
    const std::string packet = R"({"type":"state","tile_changes":[{"x":)" +
                               std::to_string( abs.x() ) + R"(,"y":)" + std::to_string( abs.y() ) +
                               R"(,"z":)" + std::to_string( abs.z() ) +
                               R"(,"items":)" + ground_snapshot( here, pos ) + "}]}";
    here.i_clear( pos );
    cata_mp::set_client_mode( true );
    session.peer.mp_remote_pos = get_avatar().pos_abs();
    for( int delivery = 0; delivery < 2; ++delivery ) {
        REQUIRE( cata_mp::client_apply_message( packet ) );
        REQUIRE( here.i_at( pos ).size() == 1 );
        REQUIRE( here.i_at( pos ).begin()->uid().get_value() == original_uid );
    }
    item &replica = *here.i_at( pos ).begin();
    Pickup::selection selection;
    selection.targets.emplace_back( map_cursor( pos ), &replica );
    selection.quantities.push_back( 7 );
    cata_mp::pickup_client_state client;
    cata_mp::pickup_host_state host;
    const auto request = cata_mp::make_pickup_request( selection, here, client );
    REQUIRE( request );
    cata_mp::set_client_mode( false );
    const auto result = run_pickup_request( remote, *request, host );
    REQUIRE_FALSE( result.empty() );
    CHECK( remote.charges_of( itype_id( "nail" ) ) == 7 );
    CHECK( replica.charges == 13 );
    CHECK( replica.uid().get_value() == original_uid );
}

TEST_CASE( "pickup_changes_only_the_selected_actor_and_source_stack",
           "[pickup][actor][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    avatar &local = get_avatar();
    npc &remote = spawn_npc( { 60, 60 }, "test_talker" );
    prepare_pickup_actor( local );
    prepare_pickup_actor( remote );
    const bool npc_actor = GENERATE( false, true );
    Character &who = npc_actor ? static_cast<Character &>( remote ) : local;
    Character &other = npc_actor ? static_cast<Character &>( local ) : remote;
    other.set_moves( 321 );
    other.recoil = 42;
    map &here = get_map();
    const tripoint_bub_ms pos = who.pos_bub( here );
    item &untouched = add_pickup_nails( here, pos, 12, "first" );
    item &source = add_pickup_nails( here, pos, 20, "selected" );
    const auto source_uid = source.uid().get_value();
    std::vector<item_location> targets{ item_location( map_cursor( pos ), &source ) };
    std::vector<int> quantities{ 7 };
    Pickup::pick_info info;
    bool stashed = true;
    REQUIRE( Pickup::do_pickup( who, targets, quantities, true, stashed, info,
                                Pickup::interaction::unattended ) );
    CHECK( stashed );
    CHECK( targets.empty() );
    CHECK( quantities.empty() );
    CHECK( who.charges_of( itype_id( "nail" ) ) == 7 );
    CHECK( who.get_moves() < 1000 );
    CHECK( other.charges_of( itype_id( "nail" ) ) == 0 );
    CHECK( other.get_moves() == 321 );
    CHECK( other.recoil == 42 );
    CHECK( untouched.charges == 12 );
    CHECK( source.charges == 13 );
    CHECK( source.uid().get_value() == source_uid );
}

TEST_CASE( "pickup_skips_a_lost_target_without_taking_its_same_type_replacement",
           "[pickup][actor][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    npc &who = spawn_npc( { 60, 60 }, "test_talker" );
    prepare_pickup_actor( who );
    map &here = get_map();
    const tripoint_bub_ms pos = who.pos_bub( here );
    item &removed = add_pickup_nails( here, pos, 8, "old" );
    item_location stale( map_cursor( pos ), &removed );
    here.i_rem( pos, &removed );
    REQUIRE_FALSE( stale );
    item &replacement = add_pickup_nails( here, pos, 8, "replacement" );
    item &selected = add_pickup_nails( here, pos, 10, "selected" );
    std::vector<item_location> targets{ item_location( map_cursor( pos ), &selected ), stale };
    std::vector<int> quantities{ 3, 0 };
    Pickup::pick_info info;
    bool stashed = true;
    REQUIRE( Pickup::do_pickup( who, targets, quantities, true, stashed, info,
                                Pickup::interaction::unattended ) );
    CHECK( who.charges_of( itype_id( "nail" ) ) == 3 );
    CHECK( get_avatar().charges_of( itype_id( "nail" ) ) == 0 );
    CHECK( replacement.charges == 8 );
    CHECK( selected.charges == 7 );
    CHECK( targets.empty() );
}

TEST_CASE( "pickup_activity_restores_its_targets_and_executes_on_its_owner",
           "[pickup][actor][activities][save][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    npc &who = spawn_npc( { 60, 60 }, "test_talker" );
    prepare_pickup_actor( who );
    map &here = get_map();
    const tripoint_bub_ms pos = who.pos_bub( here );
    item &source = add_pickup_nails( here, pos, 20, "saved" );
    pickup_activity_actor activity( { item_location( map_cursor( pos ), &source ) }, { 7 },
                                    pos, true );
    std::ostringstream text;
    JsonOut out( text );
    activity.serialize( out );
    JsonValue value = json_loader::from_string( text.str() );
    const auto restored = pickup_activity_actor::deserialize( value );
    REQUIRE( restored );
    who.assign_activity( *restored );
    who.activity.do_turn( who );
    CHECK_FALSE( who.activity );
    CHECK( who.charges_of( itype_id( "nail" ) ) == 7 );
    CHECK( get_avatar().charges_of( itype_id( "nail" ) ) == 0 );
    CHECK( source.charges == 13 );
}

TEST_CASE( "pickup_rejects_invalid_quantities_before_changing_either_inventory",
           "[pickup][actor][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &who = get_avatar();
    prepare_pickup_actor( who );
    map &here = get_map();
    const tripoint_bub_ms pos = who.pos_bub( here );
    item &source = add_pickup_nails( here, pos, 20, "invalid" );
    std::vector<item_location> targets{ item_location( map_cursor( pos ), &source ) };
    std::vector<int> quantities;
    if( GENERATE( false, true ) ) {
        quantities.push_back( -1 );
    }
    Pickup::pick_info info;
    bool stashed = true;
    CHECK_FALSE( Pickup::do_pickup( who, targets, quantities, true, stashed, info,
                                    Pickup::interaction::unattended ) );
    CHECK_FALSE( stashed );
    CHECK( who.charges_of( itype_id( "nail" ) ) == 0 );
    CHECK( who.get_moves() == 1000 );
    CHECK( source.charges == 20 );
    REQUIRE( targets.size() == 1 );
    CHECK( targets.front().get_item() == &source );
}

TEST_CASE( "carried_item_snapshot_preserves_identity_and_rejects_partial_input",
           "[pickup][actor][inventory][save][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &who = get_avatar();
    prepare_pickup_actor( who );
    item nails( itype_id( "nail" ) );
    nails.charges = 7;
    REQUIRE( who.i_add( nails ) );
    who.set_wielded_item( item( itype_id( "hammer" ) ) );
    const auto snapshot = [&]() {
        std::ostringstream text;
        JsonOut out( text );
        who.store_carried_items( out );
        return text.str();
    };
    const std::string before = snapshot();
    const auto weight = who.weight_carried();

    SECTION( "a complete snapshot preserves exact carried item identities" ) {
        item_location old_weapon = who.get_wielded_item();
        JsonValue value = json_loader::from_string( before );
        const auto rng_before = rng_get_engine(); // The listener reseeds at each SECTION.
        who.load_carried_items( value.get_object() );
        CHECK_FALSE( old_weapon );
        CHECK( snapshot() == before );
        CHECK( who.charges_of( itype_id( "nail" ) ) == 7 );
        CHECK( who.weight_carried() == weight );
        CHECK( rng_get_engine() == rng_before );
    }
    SECTION( "a malformed final root cannot clear earlier inventory roots" ) {
        JsonValue value = json_loader::from_string(
                              R"({"outfit":{"worn":[]},"inventory":[],"has_weapon":true})" );
        const auto rng_before = rng_get_engine();
        CHECK_THROWS_AS( who.load_carried_items( value.get_object() ), JsonError );
        CHECK( snapshot() == before );
        CHECK( who.weight_carried() == weight );
        CHECK( rng_get_engine() == rng_before );
    }
}

TEST_CASE( "mp_pickup_partial_stack_is_authoritative_and_duplicate_delivery_is_idempotent",
           "[pickup][multiplayer][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    avatar &local = get_avatar();
    npc &remote = spawn_npc( { 60, 60 }, "test_talker" );
    prepare_pickup_actor( local );
    prepare_pickup_actor( remote );
    map &here = get_map();
    const tripoint_bub_ms pos = remote.pos_bub( here );
    item &first = add_pickup_nails( here, pos, 12, "first" );
    item &selected = add_pickup_nails( here, pos, 20, "selected" );
    Pickup::selection selection;
    selection.targets.emplace_back( map_cursor( pos ), &selected );
    selection.quantities.push_back( 7 );
    cata_mp::pickup_client_state client;
    cata_mp::pickup_host_state host;
    const auto before = carried_snapshot( remote );
    const auto request = cata_mp::make_pickup_request( selection, here, client );
    REQUIRE( request );
    CHECK( carried_snapshot( remote ) == before );
    CHECK( selected.charges == 20 );
    CHECK_FALSE( cata_mp::make_pickup_request( selection, here, client ) );

    const auto result = run_pickup_request( remote, *request, host );
    CHECK( remote.charges_of( itype_id( "nail" ) ) == 7 );
    CHECK( local.charges_of( itype_id( "nail" ) ) == 0 );
    CHECK( selected.charges == 13 );
    CHECK( first.charges == 12 );
    CHECK( remote.get_moves() == 1000 );
    const auto after = carried_snapshot( remote );
    const auto rng_after = rng_get_engine();
    CHECK( run_pickup_request( remote, *request, host ) == result );
    CHECK( carried_snapshot( remote ) == after );
    CHECK( selected.charges == 13 );
    CHECK( rng_get_engine() == rng_after );
    CHECK( host.revision == 1 );
    JsonValue value = json_loader::from_string( result );
    JsonObject response = value.get_object();
    response.allow_omitted_members();
    CHECK( response.get_bool( "complete" ) );
    const auto client_rng = rng_get_engine();
    REQUIRE( cata_mp::apply_pickup_result( local, response, client ) );
    CHECK( rng_get_engine() == client_rng );
    CHECK( carried_snapshot( local ) == after );
    CHECK( local.last_item == remote.last_item );
    CHECK( client.pending_request == 0 );
    CHECK_FALSE( cata_mp::apply_pickup_result( local, response, client ) );
    CHECK( carried_snapshot( local ) == after );
    JsonValue old_sync = json_loader::from_string( R"({"inventory_revision":0})" );
    CHECK_FALSE( cata_mp::pickup_inventory_revision_matches( old_sync.get_object(), host ) );
    JsonValue current_sync = json_loader::from_string( R"({"inventory_revision":1})" );
    CHECK( cata_mp::pickup_inventory_revision_matches( current_sync.get_object(), host ) );
}

TEST_CASE( "mp_pickup_revalidates_source_reach_identity_and_inventory_version",
           "[pickup][multiplayer][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    npc &remote = spawn_npc( { 60, 60 }, "test_talker" );
    prepare_pickup_actor( remote );
    map &here = get_map();
    tripoint_bub_ms pos = remote.pos_bub( here );
    cata_mp::pickup_client_state client;
    cata_mp::pickup_host_state host;
    bool stale = false;
    bool malformed = false;
    SECTION( "out of reach" ) {
        pos += tripoint_rel_ms( 3, 0, 0 );
    }
    SECTION( "stale item replaced with another of the same type" ) {
        stale = true;
    }
    SECTION( "inventory changed since selection" ) {
        host.revision = 1;
    }
    SECTION( "same source selected twice" ) {
        malformed = true;
    }
    item &selected = add_pickup_nails( here, pos, 20, "selected" );
    Pickup::selection selection;
    selection.targets.emplace_back( map_cursor( pos ), &selected );
    selection.quantities.push_back( 7 );
    if( malformed ) {
        selection.targets.push_back( selection.targets.front() );
        selection.quantities.push_back( 7 );
    }
    const auto request = cata_mp::make_pickup_request( selection, here, client );
    REQUIRE( request );
    if( stale ) {
        here.i_rem( pos, &selected );
        add_pickup_nails( here, pos, 20, "replacement" );
    }
    const auto before = carried_snapshot( remote );
    const auto ground_before = ground_snapshot( here, pos );
    if( malformed ) {
        CHECK_THROWS_AS( run_pickup_request( remote, *request, host ), JsonError );
        CHECK( host.last_request == 0 );
    } else {
        JsonValue result = json_loader::from_string( run_pickup_request( remote, *request, host ) );
        JsonObject response = result.get_object();
        response.allow_omitted_members();
        CHECK_FALSE( response.get_bool( "complete" ) );
    }
    CHECK( carried_snapshot( remote ) == before );
    CHECK( remote.get_moves() == 1000 );
    // NPC setup may leave unrelated equipment on this tile. Neither it nor
    // the selected/replacement stack may change, independent of suite order.
    CHECK( ground_snapshot( here, pos ) == ground_before );
}

TEST_CASE( "mp_pickup_ingress_ignores_client_mutations_and_old_inventory_echoes",
           "[pickup][multiplayer][world_session][regression]" )
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
    npc &remote = spawn_npc( { 60, 60 }, "test_talker" );
    prepare_pickup_actor( remote );
    const cata_mp::player_id player( std::string( 32, '7' ) );
    remote.set_value( "mp_proxy", std::string( "1" ) );
    remote.set_value( "mp_player_id", player.str() );
    session.remote_actor.bind_player( remote, player, g->npc_lifetimes(),
                                      g->player_controls().claim( player, remote ) );
    session.remote_connected = true;
    session.remote_admission = cata_mp::peer_admission::create( 701 );
    session.host_turn.remote_moves = 100;
    map &here = get_map();
    const tripoint_bub_ms pos = remote.pos_bub( here );
    const tripoint_abs_ms abs = here.get_abs( pos );
    const auto terrain = here.ter( pos );
    item &source = add_pickup_nails( here, pos, 20, "selected" );
    Pickup::selection selection;
    selection.targets.emplace_back( map_cursor( pos ), &source );
    selection.quantities.push_back( 7 );
    cata_mp::pickup_client_state client;
    const auto request = cata_mp::make_pickup_request( selection, here, client );
    REQUIRE( request );
    // Legacy handlers searched nested type strings before parsing the action.
    // Neither that diversion nor attached tile/character changes may run first.
    const std::string attack = request->substr( 0, request->size() - 1 ) +
                               R"(,"nested":{"type":"trade_delta"},"char_stats":{"name":"forged"},"client_tile_changes":[{"x":)" +
                               std::to_string( abs.x() ) + R"(,"y":)" + std::to_string( abs.y() ) +
                               R"(,"z":)" + std::to_string( abs.z() ) +
                               R"(,"ter":"t_wall","items":[]}]})";
    const auto name = remote.name;
    const auto dispatch = [&]( const std::string & packet ) {
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                               packet, session.remote_admission } ) );
        cata_mp::process_mp_events();
    };
    dispatch( attack );
    REQUIRE( remote.charges_of( itype_id( "nail" ) ) == 7 );
    CHECK( source.charges == 13 );
    CHECK( remote.name == name );
    CHECK( here.ter( pos ) == terrain );
    CHECK( session.host_turn.client_acted_this_turn );
    CHECK( session.host_turn.remote_moves == 0 );
    const auto after = carried_snapshot( remote );
    session.host_turn.client_acted_this_turn = false;
    dispatch( attack );
    CHECK_FALSE( session.host_turn.client_acted_this_turn );
    CHECK( source.charges == 13 );
    dispatch( R"({"action":"worn_sync","inventory_revision":0,"char_stats":{"name":"old"},"worn":[],"wielded":"","client_inv":[]})" );
    CHECK( carried_snapshot( remote ) == after );
    CHECK( remote.name == name );
    // Matching revisions without the full carried snapshot are invalid too.
    dispatch( R"({"action":"worn_sync","inventory_revision":1,"worn":[],"client_inv":[]})" );
    CHECK( carried_snapshot( remote ) == after );
    session.client_pickup = client;
    session.begin_remote_peer();
    CHECK( session.host_pickup.revision == 0 );
    CHECK( session.host_pickup.last_result.empty() );
    session.reset();
    CHECK( session.client_pickup.pending_request == 0 );
    CHECK( session.client_pickup.revision == 0 );
}
