#include "cata_catch.h"

#include <sstream>

#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "creature_tracker.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_disposition.h"
#include "item_location.h"
#include "item_stack.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "mp_client_conn.h"
#include "mp_combat_result.h"
#include "mp_equipment.h"
#include "mp_gamestate.h"
#include "mp_pickup.h"
#include "mp_queue.h"
#include "mp_test_helpers.h"
#include "npc.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "rng.h"

namespace
{
class equipment_fixture
{
    public:
        restore_on_out_of_scope<time_point> time{ calendar::turn };
        restore_on_out_of_scope<cata_default_random_engine> rng{ rng_get_engine() };
        equipment_fixture() {
            clear_avatar();
            clear_map();
            g->multiplayer_session().reset();
            calendar::turn = calendar::turn_zero + 12_hours;
            get_avatar().setpos( get_map(), tripoint_bub_ms( 90, 90, 0 ) );
        }
        ~equipment_fixture() {
            g->multiplayer_session().reset();
            cata_mp::get_mp_queue().clear();
            clear_npcs();
            get_creature_tracker().clear();
            clear_avatar();
        }
        npc &remote() {
            npc &who = spawn_npc( { 60, 60 }, "test_talker" );
            clear_character( who, true );
            who.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
            const cata_mp::player_id owner( std::string( 32, '8' ) );
            who.set_value( "mp_proxy", std::string( "1" ) );
            who.set_value( "mp_player_id", owner.str() );
            auto &peer = make_test_remote( g->multiplayer_session() );
            peer.actor.bind_player( who, owner, g->npc_lifetimes(),
                                    g->player_controls().claim( owner, who ) );
            peer.connected = true;
            peer.turn.remote_moves = 1000;
            peer.turn.granted_this_turn = true;
            who.set_moves( 1000 );
            return who;
        }
};

class equipment_events : public event_subscriber
{
    public:
        int wear = 0;
        int takeoff = 0;
        int wield = 0;
        equipment_events() {
            get_event_bus().subscribe( this );
        }
        void notify( const cata::event &e ) override {
            if( e.type() == event_type::character_wears_item ) {
                ++wear;
            } else if( e.type() == event_type::character_takeoff_item ) {
                ++takeoff;
            } else if( e.type() == event_type::character_wields_item ) {
                ++wield;
            }
        }
};

item_location ground_item( Character &who, const itype_id &type )
{
    item &placed = get_map().add_item_or_charges( who.pos_bub(), item( type ) );
    return item_location( map_cursor( who.pos_bub() ), &placed );
}

item_location bag_item( Character &who, const itype_id &type )
{
    const auto worn = who.wear_item( item( itype_id( "backpack" ) ), false );
    REQUIRE( worn );
    item_location bag( who, & **worn );
    REQUIRE( bag->put_in( item( type ), pocket_type::CONTAINER ).success() );
    REQUIRE( bag->all_items_top().size() == 1 );
    return item_location( bag, bag->all_items_top().front() );
}
} // namespace

TEST_CASE( "owned_equipment_wear_takeoff_matches_native_cost_and_callbacks",
           "[multiplayer][equipment]" )
{
    equipment_fixture fixture;
    npc &who = fixture.remote();
    avatar &local = get_avatar();
    local.set_moves( 1000 );
    const bool held = GENERATE( false, true );
    item_location source;
    item_location reference;
    if( held ) {
        who.set_wielded_item( item( itype_id( "tshirt" ) ) );
        local.set_wielded_item( item( itype_id( "tshirt" ) ) );
        source = who.get_wielded_item();
        reference = local.get_wielded_item();
    } else {
        source = ground_item( who, itype_id( "tshirt" ) );
        reference = ground_item( local, itype_id( "tshirt" ) );
    }
    REQUIRE( local.wear( reference ) );
    equipment_events events;
    auto intent = cata_mp::make_equipment_intent( who, source, "wear" );
    REQUIRE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
    CHECK( who.get_moves() == local.get_moves() );
    CHECK( who.amount_worn( itype_id( "tshirt" ) ) == 1 );
    CHECK( events.wear == 1 );
    CHECK( events.wield == ( held ? 1 : 0 ) );
    CHECK_FALSE( source );
    item *remote_shirt = who.items_with( []( const item & it ) {
        return it.typeId() == itype_id( "tshirt" );
    } ).front();
    item *local_shirt = local.items_with( []( const item & it ) {
        return it.typeId() == itype_id( "tshirt" );
    } ).front();
    who.set_moves( 1000 );
    local.set_moves( 1000 );
    intent = cata_mp::make_equipment_intent( who, item_location( who, remote_shirt ), "takeoff" );
    REQUIRE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
    CHECK( events.takeoff == 1 );
    REQUIRE( local.takeoff( item_location( local, local_shirt ).obtain( local ) ) );
    CHECK( who.get_moves() == local.get_moves() );
    CHECK( who.amount_worn( itype_id( "tshirt" ) ) == 0 );
    CHECK( who.items_with( []( const item & it ) {
        return it.typeId() == itype_id( "tshirt" );
    } ).size() == 1 );
}

TEST_CASE( "owned_wield_uses_native_retrieval_and_selected_old_weapon_destination",
           "[multiplayer][equipment]" )
{
    equipment_fixture fixture;
    npc &who = fixture.remote();
    avatar &local = get_avatar();
    who.set_wielded_item( item( itype_id( "bat" ) ) );
    local.set_wielded_item( item( itype_id( "bat" ) ) );
    const bool nested = GENERATE( false, true );
    const auto source = nested ? bag_item( who, itype_id( "glock_19" ) ) :
                        ground_item( who, itype_id( "glock_19" ) );
    const auto reference = nested ? bag_item( local, itype_id( "glock_19" ) ) :
                           ground_item( local, itype_id( "glock_19" ) );
    const cata_mp::equipment_intent base = cata_mp::make_equipment_intent( who, source, "wield",
                                           nested );
    auto intent = base;
    intent.disposition = item_disposition{ "drop", 0, 0 };
    equipment_events events;
    REQUIRE( execute_item_disposition( local, local.get_wielded_item(), *intent.disposition ) );
    local.set_moves( 1000 );
    REQUIRE( local.wield( reference ) );
    const int expected_wield_events = events.wield;
    events.wield = 0;
    REQUIRE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
    CHECK( who.get_moves() == local.get_moves() );
    REQUIRE( who.get_wielded_item() );
    CHECK( who.get_wielded_item()->typeId() == itype_id( "glock_19" ) );
    CHECK_FALSE( source );
    CHECK( events.wield == expected_wield_events );
    bool found = false;
    for( const item &it : get_map().i_at( who.pos_bub() ) ) {
        found = found || it.typeId() == itype_id( "bat" );
    }
    CHECK( found );
    who.set_moves( 1000 );
    auto put_away = cata_mp::make_equipment_intent( who, who.get_wielded_item(), "wield" );
    put_away.disposition = item_disposition{ "drop", 0, 0 };
    REQUIRE( cata_mp::execute_equipment_intent( who, get_map(), put_away ) );
    CHECK_FALSE( who.get_wielded_item() );
}

TEST_CASE( "owned_equipment_rejects_inaccessible_stale_and_forbidden_items",
           "[multiplayer][equipment]" )
{
    equipment_fixture fixture;
    npc &who = fixture.remote();
    item_location source = bag_item( who, itype_id( "tshirt" ) );
    auto intent = cata_mp::make_equipment_intent( who, source, "wear" );
    SECTION( "stale_uid" ) {
        ++intent.source.path.back();
    }
    SECTION( "stale_ancestry" ) {
        ++intent.source.path.front();
    }
    SECTION( "stale_wielded" ) {
        ++intent.wielded;
    }
    SECTION( "other_player" ) {
        auto foreign = bag_item( get_avatar(), itype_id( "tshirt" ) );
        intent.source = cata_mp::capture_item_source( get_avatar(), foreign );
    }
    SECTION( "out_of_reach" ) {
        intent.source = cata_mp::capture_item_source( get_avatar(),
                        ground_item( get_avatar(), itype_id( "tshirt" ) ) );
    }
    SECTION( "unknown_operation" ) {
        intent.operation = "delete";
    }
    SECTION( "not_worn" ) {
        intent.operation = "takeoff";
    }
    SECTION( "no_moves" ) {
        who.set_moves( 0 );
    }
    const auto before = rng_get_engine();
    const int moves = who.get_moves();
    CHECK_FALSE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
    CHECK( who.get_moves() == moves );
    CHECK( rng_get_engine() == before );
    CHECK( source );
    CHECK( who.amount_worn( itype_id( "tshirt" ) ) == 0 );
}

TEST_CASE( "owned_equipment_does_not_implicitly_spill_or_remove_integrated_armor",
           "[multiplayer][equipment]" )
{
    equipment_fixture fixture;
    npc &who = fixture.remote();
    SECTION( "open_bucket_disposal" ) {
        who.set_wielded_item( item( itype_id( "bucket" ) ) );
        auto bucket = who.get_wielded_item();
        REQUIRE( bucket->put_in( item( itype_id( "water" ), calendar::turn, 4 ),
                                 pocket_type::CONTAINER ).success() );
        const auto source = ground_item( who, itype_id( "bat" ) );
        auto intent = cata_mp::make_equipment_intent( who, source, "wield" );
        intent.disposition = item_disposition{ "inventory", 0, 0 };
        CHECK_FALSE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
        REQUIRE( bucket );
        CHECK_FALSE( bucket->is_container_empty() );
        CHECK( source );
        CHECK( who.get_moves() == 1000 );
    }
    SECTION( "integrated_armor" ) {
        const auto worn = who.wear_item( item( itype_id( "tshirt" ) ), false );
        REQUIRE( worn );
        item_location shirt( who, & **worn );
        shirt->set_flag( flag_INTEGRATED );
        auto intent = cata_mp::make_equipment_intent( who, shirt, "takeoff" );
        CHECK_FALSE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
        CHECK( who.is_worn( *shirt ) );
        CHECK( who.get_moves() == 1000 );
    }
}

TEST_CASE( "equipment_requests_reject_retries_and_client_inventory_or_stats",
           "[multiplayer][equipment]" )
{
    equipment_fixture fixture;
    npc &who = fixture.remote();
    const auto source = ground_item( who, itype_id( "tshirt" ) );
    const auto intent = cata_mp::make_equipment_intent( who, source, "wear" );
    auto &peer = only_test_remote( g->multiplayer_session() );
    const auto encode = [&]( int revision ) {
        std::ostringstream buffer;
        JsonOut out( buffer );
        out.start_object();
        out.member( "type", "action" );
        out.member( "action", "equipment" );
        out.member( "equipment", intent );
        out.member( "inventory_revision", revision );
        out.member( "grant_seq", peer.turn.grant_seq );
        out.member( "char_stats" );
        out.start_object();
        out.member( "str", 999 );
        out.end_object();
        out.member( "wielded", "forged" );
        out.end_object();
        return buffer.str();
    };
    const auto send = [&]( const std::string & wire ) {
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action,
                                               "player", wire, peer.admission } ) );
        cata_mp::process_mp_events();
    };
    send( encode( peer.pickup.revision + 1 ) );
    CHECK( source );
    CHECK( who.amount_worn( itype_id( "tshirt" ) ) == 0 );
    const std::string request = encode( peer.pickup.revision );
    equipment_events events;
    send( request );
    CHECK( who.amount_worn( itype_id( "tshirt" ) ) == 1 );
    CHECK( who.get_str_base() == 8 );
    CHECK( events.wear == 1 );
    const int moves = peer.turn.remote_moves;
    const auto after = rng_get_engine();
    send( request );
    CHECK( who.amount_worn( itype_id( "tshirt" ) ) == 1 );
    CHECK( peer.turn.remote_moves == moves );
    CHECK( rng_get_engine() == after );
    CHECK( events.wear == 1 );
}

TEST_CASE( "equipment_client_selection_and_replication_never_rerun_gameplay",
           "[multiplayer][equipment]" )
{
    equipment_fixture fixture;
    npc &who = fixture.remote();
    avatar &client = get_avatar();
    auto source = ground_item( who, itype_id( "tshirt" ) );
    auto intent = cata_mp::make_equipment_intent( who, source, "wear" );
    REQUIRE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
    cata_mp::pickup_host_state host_state;
    cata_mp::pickup_client_state client_state;
    const std::string result = cata_mp::make_combat_result( who, host_state );
    equipment_events events;
    const auto before = rng_get_engine();
    JsonValue value = json_loader::from_string( result );
    JsonObject message = value.get_object();
    REQUIRE( message.get_string( "type" ) == "combat_result" );
    REQUIRE( cata_mp::apply_combat_result( client, message, client_state ) );
    CHECK( client.amount_worn( itype_id( "tshirt" ) ) == 1 );
    CHECK( events.wear == 0 );
    CHECK( events.wield == 0 );
    CHECK( rng_get_engine() == before );
    item *shirt = client.items_with( []( const item & it ) {
        return it.typeId() == itype_id( "tshirt" );
    } ).front();
    intent = cata_mp::make_equipment_intent( client, item_location( client, shirt ), "takeoff" );
    cata_mp::set_client_mode( true );
    client.set_moves( 1000 );
    cata_mp::client_request_equipment( intent );
    CHECK( client.is_worn( *shirt ) );
    CHECK( events.takeoff == 0 );
    CHECK( rng_get_engine() == before );
    CHECK( cata_mp::is_client_waiting_for_ack() );
    CHECK( client.get_moves() == 0 );
}

TEST_CASE( "equipment_wear_retains_native_hand_validation_order", "[multiplayer][equipment]" )
{
    equipment_fixture fixture;
    npc &who = fixture.remote();
    item armor( itype_id( "tshirt" ) );
    armor.set_flag( flag_RESTRICT_HANDS );
    armor.set_flag( flag_ALWAYS_TWOHAND );
    who.set_wielded_item( armor );
    item_location source = who.get_wielded_item();
    REQUIRE_FALSE( who.can_wear( *source ).success() );
    const auto intent = cata_mp::make_equipment_intent( who, source, "wear" );
    REQUIRE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
    CHECK_FALSE( who.get_wielded_item() );
    CHECK( who.amount_worn( itype_id( "tshirt" ) ) == 1 );
}

TEST_CASE( "equipment_wear_uses_explicit_theft_consent_without_host_prompt",
           "[multiplayer][equipment]" )
{
    equipment_fixture fixture;
    npc &who = fixture.remote();
    who.set_fac( faction_id( "your_followers" ) );
    item_location source = ground_item( who, itype_id( "tshirt" ) );
    source->set_owner( faction_id( "hells_raiders" ) );
    REQUIRE_FALSE( source->is_owned_by( who, true ) );
    auto intent = cata_mp::make_equipment_intent( who, source, "wear" );
    CHECK_FALSE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
    REQUIRE( source );
    CHECK( who.get_moves() == 1000 );
    intent.allow_theft = true;
    REQUIRE( cata_mp::execute_equipment_intent( who, get_map(), intent ) );
    CHECK_FALSE( source );
    CHECK( who.amount_worn( itype_id( "tshirt" ) ) == 1 );
}
