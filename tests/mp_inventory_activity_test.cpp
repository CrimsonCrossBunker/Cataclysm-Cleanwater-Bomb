#include "cata_catch.h"

#include <algorithm>
#include <functional>
#include <sstream>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "handle_liquid.h"
#include "item.h"
#include "item_insert.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_reload.h"
#include "item_uid.h"
#include "item_unload.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "messages.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "mp_item_source.h"
#include "mp_pickup.h"
#include "mp_queue.h"
#include "mp_unload.h"
#include "mp_world_session.h"
#include "npc.h"
#include "player_helpers.h"
#include "ret_val.h"
#include "rng.h"
#include "units.h"

namespace
{
struct reload_fixture {
    cata_mp::inventory_activity_host_state reload;
    cata_mp::pickup_host_state inventory;
    int64_t sequence = 0;
    restore_on_out_of_scope<cata_default_random_engine> rng{ rng_get_engine() };

    reload_fixture() {
        clear_avatar();
        clear_map();
        g->multiplayer_session().reset();
    }
    ~reload_fixture() {
        g->multiplayer_session().reset();
        cata_mp::get_mp_queue().clear();
        clear_npcs();
        clear_avatar();
        clear_map();
    }
    npc &remote() {
        npc &who = spawn_npc( { 60, 60 }, "test_talker" );
        clear_character( who, true );
        who.set_value( "mp_proxy", std::string( "1" ) );
        who.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
        who.set_moves( 100 );
        return who;
    }
    std::string request( Character &who, const std::string &operation,
                         const std::function<void( JsonOut & )> &extra = {},
                         std::optional<std::string> activity = std::nullopt ) {
        std::ostringstream stream;
        JsonOut out( stream );
        out.start_object();
        out.member( "request", ++sequence );
        out.member( "operation", operation );
        out.member( "activity", activity.value_or( std::to_string( who.activity.identity_generation() ) ) );
        out.member( "inventory_revision", inventory.revision );
        if( extra ) {
            extra( out );
        }
        out.end_object();
        return stream.str();
    }
    std::string run( Character &who, const std::string &wire, bool authorized = true ) {
        JsonValue value = json_loader::from_string( wire );
        JsonObject input = value.get_object();
        input.allow_omitted_members();
        return cata_mp::execute_inventory_activity_request( who, get_map(), input, reload, inventory,
                authorized );
    }
    std::string start( Character &who, const item_location &target, const item_location &ammo,
                       int quantity ) {
        std::vector<item::reload_option> options;
        who.list_ammo( target, options, true, true );
        const auto selected = std::find_if( options.begin(),
        options.end(), [&]( const item::reload_option & opt ) {
            return opt.ammo == ammo;
        } );
        REQUIRE( selected != options.end() );
        return run( who, request( who, "start", [&]( JsonOut & out ) {
            out.member( "selected", cata_mp::capture_item_source( who, target ) );
            out.member( "target", cata_mp::capture_item_source( who, selected->target ) );
            out.member( "ammo", cata_mp::capture_item_source( who, ammo ) );
            out.member( "quantity", quantity );
            out.member( "pocket", selected->pocket_index );
        } ) );
    }
};

class reload_events : public event_subscriber
{
    public:
        int starts = 0;
        int finishes = 0;
        reload_events() {
            get_event_bus().subscribe( this );
        }
        void notify( const cata::event &event ) override {
            if( event.type() == event_type::character_starts_activity ) {
                ++starts;
            }
            if( event.type() == event_type::character_finished_activity ) {
                ++finishes;
            }
        }
};

void save_reload_activity( Character &who )
{
    std::ostringstream encoded;
    JsonOut out( encoded );
    who.activity.serialize( out );
    JsonValue value = json_loader::from_string( encoded.str() );
    player_activity restored;
    restored.deserialize( value.get_object() );
    who.activity = std::move( restored );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
}

item_location loose_ammo( Character &who, int quantity )
{
    return get_map().add_item_or_charges_ret_loc( who.pos_bub(),
            item( itype_id( "556" ), calendar::turn, quantity ) );
}
} // namespace

TEST_CASE( "owned_reload_preserves_native_progress_partial_ammo_and_cancel",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "stanag30" ) ) );
    const item_location target = who.get_wielded_item();
    const item_location ammo = loose_ammo( who, 30 );
    reload_events events;
    const std::string start_result = fixture.start( who, target, ammo, 30 );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    REQUIRE( who.activity.moves_left > 100 );
    CHECK( target->ammo_remaining() == 0 );
    CHECK( ammo->charges == 30 );
    CHECK( events.starts == 1 );
    const int total = who.activity.moves_left;
    // Legacy proxy ticking must neither inject AP nor reload a round.
    cata_mp::mp_tick_proxy_activity( who );
    CHECK( who.activity.moves_left == total );
    CHECK( who.get_moves() == 100 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    CHECK( who.get_moves() == 0 );
    CHECK( who.activity.moves_left < total );
    CHECK( target->ammo_remaining() == 1 );
    CHECK( ammo->charges == 29 );
    const int remaining = who.activity.moves_left;
    save_reload_activity( who );
    CHECK( who.activity.moves_left == remaining );
    who.set_moves( 100 );
    fixture.run( who, step );
    CHECK( who.activity.moves_left == remaining );
    CHECK( target->ammo_remaining() == 1 );
    CHECK( who.get_moves() == 100 );
    who.set_moves( -80 );
    const std::string cancel = fixture.request( who, "cancel" );
    fixture.run( who, cancel );
    CHECK_FALSE( who.activity );
    CHECK( who.get_moves() == -80 );
    CHECK( target->ammo_remaining() + ammo->charges == 30 );
    CHECK( events.finishes == 1 );
    fixture.run( who, cancel );
    CHECK( events.finishes == 1 );
}

TEST_CASE( "owned_reload_obtains_external_target_and_finishes_once", "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    item_location target = get_map().add_item_or_charges_ret_loc( who.pos_bub(),
                           item( itype_id( "stanag30" ) ) );
    const item_location ammo = loose_ammo( who, 3 );
    reload_events events;
    fixture.start( who, target, ammo, 3 );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    auto *actor = dynamic_cast<reload_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    target = actor->target();
    CHECK( target.held_by( who ) );
    who.set_moves( 100000 );
    const std::string response = fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( target->ammo_remaining() == 3 );
    CHECK_FALSE( ammo );
    CHECK( events.starts == 1 );
    CHECK( events.finishes == 1 );
    REQUIRE_FALSE( response.empty() );
}

TEST_CASE( "owned_reload_rejects_ungranted_step_and_stale_activity", "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "stanag30" ) ) );
    const item_location target = who.get_wielded_item();
    const item_location ammo = loose_ammo( who, 10 );
    fixture.start( who, target, ammo, 10 );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    const int before = who.activity.moves_left;
    fixture.run( who, fixture.request( who, "step" ), false );
    CHECK( who.activity.moves_left == before );
    CHECK( ammo->charges == 10 );
    const std::string old_activity = std::to_string( who.activity.identity_generation() );
    who.cancel_activity();
    fixture.start( who, target, ammo, 10 );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    fixture.run( who, fixture.request( who, "cancel", {}, old_activity ) );
    CHECK( cata_mp::owns_inventory_activity( who ) );
    // Moving away from the map source cannot keep remotely loading it.
    who.setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 5, 0, 0 ) );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( ammo->charges == 10 );
}

TEST_CASE( "reload_capacity_preview_accounts_for_consumed_sibling_ammo",
           "[reload_owned][reload][preview]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    item container( itype_id( "backpack" ) );
    REQUIRE( container.put_in( item( itype_id( "stanag30" ) ), pocket_type::CONTAINER ).success() );
    REQUIRE( container.put_in( item( itype_id( "556" ), calendar::turn, 30 ),
                               pocket_type::CONTAINER ).success() );
    item_location root = get_map().add_item_or_charges_ret_loc( who.pos_bub(), container );
    item_location target;
    item_location ammo;
    for( item *child : root->all_items_top() ) {
        if( child->typeId() == itype_id( "stanag30" ) ) {
            target = item_location( root, child );
        } else if( child->typeId() == itype_id( "556" ) ) {
            ammo = item_location( root, child );
        }
    }
    REQUIRE( target );
    REQUIRE( ammo );
    // Fill precisely the remaining weight budget. An implementation that only
    // adds loaded ammo weight without removing the sibling source would fail.
    const auto before = target.parent_pocket()->remaining_weight();
    const item ballast( itype_id( "9mm" ), calendar::turn, 1 );
    const int charges = units::to_milligram( before ) / units::to_milligram( ballast.weight() );
    REQUIRE( charges > 0 );
    target.parent_pocket()->add( item( itype_id( "9mm" ), calendar::turn, charges ) );
    REQUIRE( target.check_parent_capacity_recursive() );
    REQUIRE( target.parent_pocket()->remaining_weight() < ammo->weight() );
    CHECK( reload_would_fit( target, ammo, 30 ) );
    CHECK( target->ammo_remaining() == 0 );
    CHECK( ammo->charges == 30 );
    REQUIRE( target->reload( who, ammo, 30 ) );
    CHECK( target.check_parent_capacity_recursive() );
}

TEST_CASE( "owned_reload_overflow_waits_before_ammo_and_supports_drop_or_cancel",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const auto jeans = who.wear_item( item( itype_id( "jeans" ) ), false );
    REQUIRE( jeans );
    item_location clothing( who, & **jeans );
    const auto inserted = clothing->put_in( item( itype_id( "belt223" ) ), pocket_type::CONTAINER );
    REQUIRE( inserted.success() );
    item_location target( clothing, &clothing->only_item() );
    const item_location ammo = loose_ammo( who, 500 );
    who.i_add( item( itype_id( "ammolink223" ), calendar::turn, 500 ) );
    REQUIRE( who.has_charges( itype_id( "ammolink223" ), 500 ) );
    // Use an owned native activity directly to isolate placement from selection.
    item::reload_option option( &who, target, ammo, -1 );
    option.qty( 500 );
    REQUIRE( option.qty() == 500 );
    who.assign_activity( reload_activity_actor( std::move( option ), 0, true ) );
    REQUIRE_FALSE( reload_would_fit( target, ammo, 500 ) );
    const int before = who.activity.moves_left;
    fixture.run( who, fixture.request( who, "step" ) );
    REQUIRE( fixture.reload.needs_placement );
    CHECK( who.activity.moves_left == before );
    CHECK( who.get_moves() == 100 );
    CHECK( target->ammo_remaining() == 0 );
    CHECK( ammo->charges == 500 );
    CHECK( target.check_parent_capacity_recursive() );
    save_reload_activity( who );
    CHECK( who.activity.moves_left == before );
    const int placement = GENERATE( 0, 1, 2 );
    if( placement != 0 ) {
        fixture.run( who, fixture.request( who, "place", [placement]( JsonOut & out ) {
            out.member( "placement", placement == 1 ? "drop" : "wield" );
        } ) );
        CHECK_FALSE( fixture.reload.needs_placement );
        const auto *actor = dynamic_cast<const reload_activity_actor *>( who.activity.actor.get() );
        REQUIRE( actor );
        CHECK( actor->target().held_by( who ) == ( placement == 2 ) );
        if( placement == 2 ) {
            CHECK( who.is_wielding( *actor->target() ) );
        }
        CHECK( actor->target()->ammo_remaining() == 0 );
        CHECK( ammo->charges == 500 );
    }
    fixture.run( who, fixture.request( who, "cancel" ) );
    CHECK_FALSE( who.activity );
    CHECK( ammo->charges == 500 );
}

TEST_CASE( "client_inventory_activity_view_does_not_advance_native_or_emit_lifecycle",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    cata_mp::set_client_mode( true );
    reload_events events;
    who.set_moves( 100 );
    SECTION( "reload" ) {
        who.assign_activity( reload_activity_actor::client_view() );
    }
    SECTION( "unload" ) {
        who.assign_activity( unload_activity_actor::client_view() );
    }
    SECTION( "insert" ) {
        who.assign_activity( insert_item_activity_actor::client_view() );
    }
    who.activity.moves_left = 500;
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    const auto before = rng_get_engine();
    who.activity.do_turn( who );
    CHECK( who.activity.moves_left == 500 );
    CHECK( who.get_moves() == 0 );
    CHECK( rng_get_engine() == before );
    const activity_id view_id = who.activity.id();
    who.cancel_activity();
    g->multiplayer_session().client_turn.client_last_grant_seq = 1;
    REQUIRE_FALSE( cata_mp::is_client_waiting_for_ack() );
    cata_mp::client_dispatch_wait_for_activity( view_id, true );
    cata_mp::mp_client_post_action( 100 );
    CHECK_FALSE( cata_mp::is_client_waiting_for_ack() );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
}

TEST_CASE( "reload_wire_updates_client_progress_inventory_and_completion_once",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_id( "stanag30" ) ) );
    const item_location target = remote.get_wielded_item();
    const item_location ammo = loose_ammo( remote, 3 );
    const std::string started = fixture.start( remote, target, ammo, 3 );
    const std::string progressed = fixture.run( remote, fixture.request( remote, "step" ) );
    const int remaining = remote.activity.moves_left;
    REQUIRE( remaining > 0 );
    remote.set_moves( 100000 );
    const std::string finished = fixture.run( remote, fixture.request( remote, "step" ) );
    REQUIRE_FALSE( remote.activity );

    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    view.next_request = 1;
    reload_events events;
    local.assign_activity( reload_activity_actor::client_view() );
    const auto before_rng = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( started ) );
    CHECK( cata_mp::inventory_activity_view( local.activity ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 0 );
    view.pending_request = 2;
    REQUIRE( cata_mp::client_apply_message( progressed ) );
    CHECK( local.activity.moves_left == remaining );
    CHECK( local.get_wielded_item()->ammo_remaining() == 1 );
    view.pending_request = 3;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 3 );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( local.activity );
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 3 );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
    CHECK( rng_get_engine() == before_rng );
}

TEST_CASE( "reload_save_after_source_exhaustion_retains_ammo_name_and_quantity",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "stanag30" ) ) );
    item_location target = who.get_wielded_item();
    target->set_var( "dirt", 8000 );
    item_location ammo = loose_ammo( who, 3 );
    fixture.start( who, target, ammo, 3 );
    for( int round = 0; round < 3; ++round ) {
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
    }
    REQUIRE( who.activity );
    REQUIRE_FALSE( ammo );
    REQUIRE( target->ammo_remaining() == 3 );
    save_reload_activity( who );
    Messages::clear_messages();
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( target->ammo_remaining() == 3 );
    const auto messages = Messages::recent_messages( 1 );
    REQUIRE( messages.size() == 1 );
    CHECK( messages.front().second.find( item::nname( itype_id( "556" ), 3 ) ) != std::string::npos );
}

namespace
{
std::string start_unload( reload_fixture &fixture, Character &who,
                          const item_location &root, const unload_selection &selection,
                          const std::vector<unload_liquid_choice> &liquids = {} )
{
    const auto intent = cata_mp::make_unload_intent( who, root, selection, liquids );
    return fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "unload" );
        out.member( "unload", intent );
    } ) );
}
} // namespace

TEST_CASE( "owned_unload_selects_only_the_requested_integral_source",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    get_avatar().set_moves( 517 );
    item gun( itype_id( "test_multimag_gun_integral_ammo" ) );
    item battery( itype_id( "heavy_battery_cell" ) );
    battery.ammo_set( itype_id( "battery" ), 100 );
    REQUIRE( gun.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    REQUIRE( gun.put_in( item( itype_id( "9mm" ), calendar::turn, 1 ),
                         pocket_type::MAGAZINE ).success() );
    who.set_wielded_item( gun );
    item_location root = who.get_wielded_item();
    const auto options = unload_sources( *root );
    REQUIRE( options.size() == 2 );
    unload_selection selected{ root, { options.back().identity } };
    bool valid = true;
    SECTION( "integral_only" ) {}
    SECTION( "stale_source" ) {
        selected.sources = { -1 };
        valid = false;
    }
    SECTION( "duplicate_source" ) {
        selected.sources.push_back( selected.sources.front() );
        valid = false;
    }
    const int before = who.get_moves();
    start_unload( fixture, who, root, selected );
    CHECK( root->ammo_remaining_in_pocket( "ammo" ) == ( valid ? 0 : 1 ) );
    REQUIRE( root->magazines_current().size() == 1 );
    CHECK( root->magazines_current().front()->ammo_remaining() == 100 );
    CHECK( ( who.get_moves() < before ) == valid );
    CHECK( get_avatar().get_moves() == 517 );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "owned_unload_uses_explicit_liquid_container_without_host_ui",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_moves( 1500 );
    get_avatar().set_moves( 517 );
    who.set_wielded_item( item( itype_id( "test_multimag_turret_flamethrower" ) ) );
    item_location root = who.get_wielded_item();
    item_pocket *fuel = root->pocket_by_id( "fuel" );
    REQUIRE( fuel );
    item gasoline( itype_id( "gasoline" ), calendar::turn, 20 );
    REQUIRE( fuel->insert_item( gasoline ).success() );
    item &bottle = get_map().add_item_or_charges( who.pos_bub(), item( itype_id( "bottle_plastic" ) ) );
    item supply = gasoline;
    supply.charges = 10000;
    const int capacity = bottle.get_remaining_capacity_for_liquid( supply, true );
    REQUIRE( capacity > 5 );
    REQUIRE( bottle.fill_with( supply, capacity - 5 ) == capacity - 5 );
    unload_liquid_choice choice;
    choice.source = fuel->all_items_top().front()->uid().get_value();
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, item_location( map_cursor( who.pos_bub() ),
                                            &bottle ) );
    const auto sources = unload_sources( *root );
    REQUIRE( sources.size() == 1 );
    unload_selection selected{ root, { sources.front().identity } };
    const auto intent = cata_mp::make_unload_intent( who, root, selected, { choice } );
    const std::string wire = fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "unload" );
        out.member( "unload", intent );
    } );
    fixture.run( who, wire );
    CHECK( root->ammo_remaining_in_pocket( "fuel" ) == 15 );
    CHECK( bottle.legacy_front().charges == capacity );
    const int after = who.get_moves();
    CHECK( after < 1400 );
    fixture.run( who, wire );
    CHECK( root->ammo_remaining_in_pocket( "fuel" ) == 15 );
    CHECK( bottle.legacy_front().charges == capacity );
    CHECK( who.get_moves() == after );
    CHECK( get_avatar().get_moves() == 517 );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_unload_activity_progress_cancel_and_source_loss",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    item mag( itype_id( "stanag30" ) );
    mag.ammo_set( itype_id( "556" ), 30 );
    who.set_wielded_item( mag );
    const item_location root = who.get_wielded_item();
    reload_events events;
    start_unload( fixture, who, root, { root, {} } );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    REQUIRE( who.activity.id() == activity_id( "ACT_UNLOAD" ) );
    const int total = who.activity.moves_left;
    REQUIRE( total > 100 );
    const std::string first_step = fixture.request( who, "step" );
    fixture.run( who, first_step );
    REQUIRE( who.activity );
    CHECK( who.activity.moves_left < total );
    CHECK( root->ammo_remaining() == 30 );
    const int progress = who.activity.moves_left;
    fixture.run( who, first_step );
    CHECK( who.activity.moves_left == progress );
    SECTION( "finish_once" ) {
        who.set_moves( 100000 );
        const std::string finish = fixture.request( who, "step" );
        fixture.run( who, finish );
        CHECK_FALSE( who.activity );
        CHECK( root->ammo_remaining() == 0 );
        const int moves = who.get_moves();
        fixture.run( who, finish );
        CHECK( who.get_moves() == moves );
    }
    SECTION( "cancel_without_ap" ) {
        who.set_moves( 0 );
        fixture.run( who, fixture.request( who, "cancel" ) );
        CHECK_FALSE( who.activity );
        CHECK( root->ammo_remaining() == 30 );
        CHECK( who.get_moves() == 0 );
    }
    SECTION( "removed_source" ) {
        who.remove_weapon();
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == 100 );
    }
    SECTION( "removed_source_after_save" ) {
        save_reload_activity( who );
        who.remove_weapon();
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == 100 );
    }
    CHECK( events.starts == 1 );
    CHECK( events.finishes == 1 );
}

TEST_CASE( "owned_unload_liquid_activity_revalidates_destination_after_save",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "bottle_plastic" ) ) );
    item_location root = who.get_wielded_item();
    item water( itype_id( "water_clean" ), calendar::turn, 2 );
    REQUIRE( root->fill_with( water, 2 ) == 2 );
    item &bottle = get_map().add_item_or_charges( who.pos_bub(), item( itype_id( "bottle_plastic" ) ) );
    item_location destination( map_cursor( who.pos_bub() ), &bottle );
    unload_liquid_choice choice;
    choice.source = root->legacy_front().uid().get_value();
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, destination );
    start_unload( fixture, who, root, { root, {} }, { choice } );
    REQUIRE( who.activity );
    std::ostringstream saved;
    JsonOut out( saved );
    who.activity.serialize( out );
    JsonValue input = json_loader::from_string( saved.str() );
    player_activity loaded;
    loaded.deserialize( input.get_object() );
    who.activity = std::move( loaded );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    bool missing = false;
    SECTION( "destination_retained" ) {}
    SECTION( "destination_removed" ) {
        destination.remove_item();
        missing = true;
    }
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    if( missing ) {
        CHECK( root->legacy_front().charges == 2 );
    } else {
        CHECK( root->is_container_empty() );
        CHECK( destination->legacy_front().charges == 2 );
    }
}

TEST_CASE( "owned_unload_rejects_another_players_item_and_stale_cancel",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    item mag( itype_id( "stanag30" ) );
    mag.ammo_set( itype_id( "556" ), 30 );
    get_avatar().set_wielded_item( mag );
    const item_location foreign = get_avatar().get_wielded_item();
    start_unload( fixture, who, foreign, { foreign, {} } );
    CHECK_FALSE( who.activity );
    CHECK( foreign->ammo_remaining() == 30 );
    CHECK( who.get_moves() == 100 );
    who.set_wielded_item( mag );
    const item_location own = who.get_wielded_item();
    start_unload( fixture, who, own, { own, {} } );
    REQUIRE( who.activity );
    const std::string old_identity = std::to_string( who.activity.identity_generation() );
    fixture.run( who, fixture.request( who, "cancel" ) );
    start_unload( fixture, who, own, { own, {} } );
    REQUIRE( who.activity );
    fixture.run( who, fixture.request( who, "cancel", {}, old_identity ) );
    CHECK( who.activity );
    CHECK( own->ammo_remaining() == 30 );
}

TEST_CASE( "owned_unload_wire_applies_without_client_gameplay_hooks_or_rng",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    item mag( itype_id( "stanag30" ) );
    mag.ammo_set( itype_id( "556" ), 3 );
    remote.set_wielded_item( mag );
    item_location root = remote.get_wielded_item();
    const std::string started = start_unload( fixture, remote, root, { root, {} } );
    REQUIRE( remote.activity );
    remote.set_moves( 100000 );
    const std::string finished = fixture.run( remote, fixture.request( remote, "step" ) );
    REQUIRE_FALSE( remote.activity );
    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    reload_events events;
    local.assign_activity( unload_activity_actor::client_view() );
    const auto rng = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( started ) );
    REQUIRE( cata_mp::inventory_activity_view( local.activity ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 3 );
    view.pending_request = 2;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 0 );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( local.activity );
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 0 );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
    CHECK( rng_get_engine() == rng );
}

namespace
{
std::string insert_request( reload_fixture &fixture, Character &who,
                            const item_location &destination, const drop_locations &items )
{
    const insert_selection selection = capture_insert_selection( who, destination, items, true );
    return fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "insert" );
        out.member( "insert", selection );
    } );
}

int container_quantity( const item_location &container, const itype_id &type )
{
    int total = 0;
    for( const item *inside : container->all_items_top( pocket_type::CONTAINER ) ) {
        if( inside->typeId() == type ) {
            total += inside->count();
        }
    }
    return total;
}
} // namespace

TEST_CASE( "owned_insert_advances_native_list_and_saves_between_items",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "backpack" ) ) );
    const item_location destination = who.get_wielded_item();
    const item_location first = loose_ammo( who, 5 );
    const item_location second = get_map().add_item_or_charges_ret_loc( who.pos_bub(),
                                 item( itype_id( "9mm" ), calendar::turn, 7 ) );
    reload_events events;
    const std::string start = insert_request( fixture, who, destination, {{first, 5}, {second, 7}} );
    fixture.run( who, start );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( events.starts == 1 );
    CHECK( container_quantity( destination, itype_id( "556" ) ) == 0 );
    const int initial_moves = who.activity.moves_left;
    cata_mp::mp_tick_proxy_activity( who );
    CHECK( who.activity.moves_left == initial_moves );
    who.set_moves( 100000 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    REQUIRE( who.activity );
    CHECK_FALSE( first );
    CHECK( container_quantity( destination, itype_id( "556" ) ) == 5 );
    const int remaining = who.activity.moves_left;
    const int ap = who.get_moves();
    fixture.run( who, step );
    CHECK( who.activity.moves_left == remaining );
    CHECK( who.get_moves() == ap );
    save_reload_activity( who );
    SECTION( "finish remaining item after save" ) {
        who.set_moves( 100000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( second );
        CHECK( container_quantity( destination, itype_id( "9mm" ) ) == 7 );
        CHECK( events.finishes == 2 );
    }
    SECTION( "cancel keeps earlier insert and remaining source" ) {
        who.set_moves( -10 );
        fixture.run( who, fixture.request( who, "cancel" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == -10 );
        REQUIRE( second );
        CHECK( second->charges == 7 );
        CHECK( container_quantity( destination, itype_id( "9mm" ) ) == 0 );
    }
    CHECK( container_quantity( destination, itype_id( "556" ) ) == 5 );
}

TEST_CASE( "owned_insert_caps_changed_stack_and_preserves_partial_remainder",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "bottle_plastic" ) ) );
    item_location destination = who.get_wielded_item();
    item jug( itype_id( "jug_plastic" ) );
    REQUIRE( jug.put_in( item( itype_id( "water_clean" ), calendar::turn, 10 ),
                         pocket_type::CONTAINER ).success() );
    item_location root = get_map().add_item_or_charges_ret_loc( who.pos_bub(), jug );
    item_location water( root, root->all_items_top().front() );
    const std::string start = insert_request( fixture, who, destination, {{water, 10}} );
    fixture.run( who, start );
    REQUIRE( who.activity );
    water->charges = 3;
    save_reload_activity( who );
    who.set_moves( 100000 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    CHECK_FALSE( who.activity );
    CHECK( container_quantity( destination, itype_id( "water_clean" ) ) == 2 );
    CHECK( container_quantity( root, itype_id( "water_clean" ) ) == 1 );
    fixture.run( who, step );
    CHECK( container_quantity( destination, itype_id( "water_clean" ) ) == 2 );
    CHECK( container_quantity( root, itype_id( "water_clean" ) ) == 1 );
}

TEST_CASE( "owned_insert_rejects_invalid_selection_and_lost_targets",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "backpack" ) ) );
    item_location destination = who.get_wielded_item();
    item_location source = loose_ammo( who, 5 );
    SECTION( "duplicate source" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{source, 5}, {source, 5}} ) );
    }
    SECTION( "quantity exceeds source" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{source, 6}} ) );
    }
    SECTION( "other player inventory" ) {
        get_avatar().set_wielded_item( item( itype_id( "556" ), calendar::turn, 5 ) );
        fixture.run( who, insert_request( fixture, who, destination,
        {{get_avatar().get_wielded_item(), 5}} ) );
        CHECK( get_avatar().get_wielded_item()->charges == 5 );
    }
    SECTION( "loose liquid cannot be picked up through insertion" ) {
        item_location liquid = get_map().add_item_or_charges_ret_loc( who.pos_bub(),
                               item( itype_id( "water_clean" ), calendar::turn, 5 ) );
        REQUIRE( liquid );
        fixture.run( who, insert_request( fixture, who, destination, {{liquid, 5}} ) );
        CHECK( liquid->charges == 5 );
    }
    SECTION( "self containment" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{destination, 1}} ) );
    }
    SECTION( "source removed after save" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{source, 5}} ) );
        REQUIRE( who.activity );
        save_reload_activity( who );
        source.remove_item();
        fixture.run( who, fixture.request( who, "step" ) );
    }
    SECTION( "destination removed after save" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{source, 5}} ) );
        REQUIRE( who.activity );
        save_reload_activity( who );
        destination.remove_item();
        fixture.run( who, fixture.request( who, "step" ) );
    }
    CHECK_FALSE( who.activity );
    CHECK( who.get_moves() == 100 );
    if( source ) {
        CHECK( source->charges == 5 );
    }
    if( destination ) {
        CHECK( destination->is_container_empty() );
    }
}

TEST_CASE( "owned_unload_to_selected_container_uses_insert_activity",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "backpack" ) ) );
    item_location destination = who.get_wielded_item();
    item bag( itype_id( "backpack" ) );
    REQUIRE( bag.put_in( item( itype_id( "556" ), calendar::turn, 5 ),
                         pocket_type::CONTAINER ).success() );
    item_location root = get_map().add_item_or_charges_ret_loc( who.pos_bub(), bag );
    auto intent = cata_mp::make_unload_intent( who, root, {root, {}}, {} );
    intent.destination = capture_item_source( who, destination );
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "unload" );
        out.member( "unload", intent );
    } ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( who.activity.id() == activity_id( "ACT_INSERT_ITEM" ) );
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( root->is_container_empty() );
    CHECK( container_quantity( destination, itype_id( "556" ) ) == 5 );
}

TEST_CASE( "owned_insert_wire_applies_without_duplicate_client_execution",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_id( "backpack" ) ) );
    const item_location source = loose_ammo( remote, 5 );
    const std::string started = fixture.run( remote, insert_request( fixture, remote,
    remote.get_wielded_item(), {{source, 5}} ) );
    REQUIRE( remote.activity );
    remote.set_moves( 100000 );
    const std::string finished = fixture.run( remote, fixture.request( remote, "step" ) );
    REQUIRE_FALSE( remote.activity );
    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    reload_events events;
    local.assign_activity( insert_item_activity_actor::client_view() );
    const auto rng = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( started ) );
    CHECK( local.get_wielded_item()->is_container_empty() );
    view.pending_request = 2;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( local.activity );
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( container_quantity( local.get_wielded_item(), itype_id( "556" ) ) == 5 );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
    CHECK( rng_get_engine() == rng );
}
