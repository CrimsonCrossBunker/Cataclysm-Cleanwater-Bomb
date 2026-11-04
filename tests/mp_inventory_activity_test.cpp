#include "cata_catch.h"

#include <algorithm>
#include <functional>
#include <limits>
#include <sstream>
#include <vector>

#include "activity_actor_definitions.h"
#include "action.h"
#include "avatar.h"
#include "avatar_action.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "craft_command.h"
#include "crafting.h"
#include "construction.h"
#include "bodypart.h"
#include "effect.h"
#include "magic.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "handle_liquid.h"
#include "item.h"
#include "iexamine.h"
#include "options_helpers.h"
#include "item_activation.h"
#include "tool_activity_target.h"
#include "iuse_actor.h"
#include "item_components.h"
#include "item_healing.h"
#include "item_insert.h"
#include "item_consumption.h"
#include "player_control.h"
#include "flag.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_reload.h"
#include "item_uid.h"
#include "item_unload.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "mapdata.h"
#include "skill.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_selector.h"
#include "messages.h"
#include "mp_client_conn.h"
#include "mp_combat_result.h"
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
#include "uistate.h"
#include "vehicle.h"
#include "veh_type.h"
#include "vpart_position.h"
#include "submap.h"


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
    SECTION( "consume" ) {
        who.assign_activity( consume_activity_actor::client_view() );
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

namespace
{
struct consumption_fixture : reload_fixture {
    player_control_registry controls;
    std::optional<player_control> control;
    npc &remote() {
        npc &who = reload_fixture::remote();
        control.emplace( controls.claim( cata_mp::player_id( std::string( 32, '6' ) ), who ) );
        REQUIRE( who.is_player_controlled() );
        who.stomach.empty();
        who.guts.empty();
        who.set_hunger( 100 );
        who.set_thirst( 100 );
        return who;
    }
};

class consumption_events : public event_subscriber
{
    public:
        std::vector<character_id> actors;
        consumption_events() {
            get_event_bus().subscribe( this );
        }
        void notify( const cata::event &event ) override {
            if( event.type() == event_type::character_consumes_item ) {
                actors.push_back( event.get<character_id>( "character" ) );
            }
        }
};

item_location drinking_source( Character &who )
{
    item bottle( itype_id( "bottle_plastic" ) );
    REQUIRE( bottle.put_in( item( itype_id( "water_clean" ), calendar::turn, 2 ),
                            pocket_type::CONTAINER ).success() );
    who.set_wielded_item( bottle );
    item_location root = who.get_wielded_item();
    return item_location( root, root->all_items_top().front() );
}

std::string consume_request( reload_fixture &fixture, Character &who,
                             const item_location &source, bool consequences = false )
{
    return fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "consume" );
        out.member( "source", capture_item_source( who, source ) );
        out.member( "allow_consequences", consequences );
    } );
}

std::string needs_state( const Character &who )
{
    std::ostringstream text;
    JsonOut out( text );
    who.store_needs_state( out );
    return text.str();
}
} // namespace

TEST_CASE( "native_consumption_uses_the_activity_owner_not_the_global_avatar",
           "[multiplayer][consume_owned]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    item_location source = drinking_source( who );
    get_avatar().set_underwater( true );
    const std::string local_before = needs_state( get_avatar() );
    consumption_events events;
    who.assign_activity( consume_activity_actor( source ) );
    REQUIRE( who.activity.moves_left > 0 );
    who.set_moves( 100000 );
    who.activity.do_turn( who );
    CHECK_FALSE( who.activity );
    CHECK( source->charges == 1 );
    CHECK( who.stomach.get_water() > 0_ml );
    CHECK( who.get_thirst() == who.Character::get_thirst() );
    REQUIRE( events.actors.size() == 1 );
    CHECK( events.actors.front() == who.getID() );
    CHECK( needs_state( get_avatar() ) == local_before );
}

TEST_CASE( "owned_consumption_progress_cancel_and_saved_source",
           "[multiplayer][consume_owned]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    item_location source = drinking_source( who );
    consumption_events events;
    fixture.run( who, consume_request( fixture, who, source ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    const int total = who.activity.moves_left;
    REQUIRE( total > 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( who.activity.moves_left < total );
    CHECK( who.get_moves() == 0 );
    CHECK( source->charges == 2 );
    save_reload_activity( who );
    SECTION( "finish once" ) {
        who.set_moves( 100000 );
        const std::string step = fixture.request( who, "step" );
        fixture.run( who, step );
        REQUIRE_FALSE( who.activity );
        CHECK( source->charges == 1 );
        const std::string after = needs_state( who );
        fixture.run( who, step );
        CHECK( needs_state( who ) == after );
        CHECK( events.actors.size() == 1 );
    }
    SECTION( "cancel without AP" ) {
        who.set_moves( -5 );
        fixture.run( who, fixture.request( who, "cancel" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == -5 );
        CHECK( source->charges == 2 );
        CHECK( events.actors.empty() );
    }
    SECTION( "source removed after saving" ) {
        source.remove_item();
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == 100 );
        CHECK( events.actors.empty() );
    }
}

TEST_CASE( "owned_consumption_validates_actor_food_and_confirmation",
           "[multiplayer][consume_owned]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "apple" ), calendar::turn, 2 ) );
    item_location source = who.get_wielded_item();
    SECTION( "another player's food" ) {
        get_avatar().set_wielded_item( item( itype_id( "apple" ) ) );
        fixture.run( who, consume_request( fixture, who, get_avatar().get_wielded_item() ) );
        CHECK_FALSE( who.activity );
    }
    SECTION( "hard dietary restriction cannot be confirmed away" ) {
        source->set_flag( flag_DIRTY );
        fixture.run( who, consume_request( fixture, who, source, true ) );
        CHECK_FALSE( who.activity );
    }
    SECTION( "rotten food requires the owner's confirmation" ) {
        source->set_relative_rot( 2.0 );
        fixture.run( who, consume_request( fixture, who, source ) );
        CHECK_FALSE( who.activity );
        fixture.run( who, consume_request( fixture, who, source, true ) );
        CHECK( cata_mp::owns_inventory_activity( who ) );
        fixture.run( who, fixture.request( who, "cancel" ) );
    }
    CHECK( source->charges == 2 );
    CHECK( who.get_moves() == 100 );
    CHECK( who.stomach.contains() == 0_ml );
}

TEST_CASE( "consumption_results_restore_needs_without_client_ingestion_or_stale_overwrite",
           "[multiplayer][consume_owned]" )
{
    consumption_fixture fixture;
    restore_on_out_of_scope restore_menu( uistate.open_menu );
    restore_on_out_of_scope restore_consume_ui( uistate.consume_uistate );
    uistate.open_menu.reset();
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_id( "chocolate" ), calendar::turn, 2 ) );
    const std::string started = fixture.run( remote, consume_request( fixture, remote,
                                remote.get_wielded_item() ) );
    REQUIRE( remote.activity );
    remote.set_moves( 100000 );
    const std::string finished = fixture.run( remote, fixture.request( remote, "step" ) );
    REQUIRE_FALSE( remote.activity );
    const std::string expected = needs_state( remote );
    const int expected_morale = remote.get_morale_level();
    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    local.assign_activity( consume_activity_actor::client_view( true ) );
    const auto rng = rng_get_engine();
    consumption_events events;
    REQUIRE( cata_mp::client_apply_message( started ) );
    local.get_morale_level(); // Populate the cache before restoring changed morale.
    view.pending_request = 2;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->charges == 1 );
    CHECK( needs_state( local ) == expected );
    CHECK( local.get_morale_level() == expected_morale );
    cata_mp::client_update_inventory_activity_view();
    REQUIRE( uistate.open_menu.has_value() );
    uistate.open_menu.reset(); // The UI consumed the deferred menu callback.
    REQUIRE( cata_mp::client_apply_message( finished ) );
    REQUIRE( cata_mp::client_apply_message( started ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( uistate.open_menu.has_value() );
    CHECK( needs_state( local ) == expected );
    CHECK( events.actors.empty() );
    CHECK( rng_get_engine() == rng );
}

TEST_CASE( "client_consumption_continuation_respects_cancel_and_other_ui",
           "[multiplayer][consume_owned]" )
{
    reload_fixture fixture;
    restore_on_out_of_scope restore_menu( uistate.open_menu );
    restore_on_out_of_scope restore_consume_ui( uistate.consume_uistate );
    uistate.open_menu.reset();
    cata_mp::set_client_mode( true );
    avatar &local = get_avatar();
    auto &view = g->multiplayer_session().client_inventory_activity;
    local.assign_activity( consume_activity_actor::client_view( true ) );
    view.active = true;
    view.finished = true;
    view.next_request = 17;
    bool existing_menu_ran = false;
    SECTION( "cancel does not reopen the menu" ) {
        local.cancel_activity();
    }
    SECTION( "single item use does not reopen the menu" ) {
        local.assign_activity( consume_activity_actor::client_view() );
    }
    SECTION( "a pending menu is preserved" ) {
        uistate.open_menu = [&]() {
            existing_menu_ran = true;
        };
    }
    const bool had_menu = uistate.open_menu.has_value();
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( view.active );
    CHECK( view.next_request == 17 );
    CHECK( uistate.open_menu.has_value() == had_menu );
    if( had_menu ) {
        ( *uistate.open_menu )();
        CHECK( existing_menu_ran );
    }
}

TEST_CASE( "shared_save_acknowledgement_requires_explicit_success",
           "[multiplayer][coop_save]" )
{
    reload_fixture fixture;
    cata_mp::set_client_mode( true );
    Messages::clear_messages();
    std::string response;
    bool saved = false;
    SECTION( "successful write" ) {
        response = R"({"type":"save_done","saved":true})";
        saved = true;
    }
    SECTION( "failed write" ) {
        response = R"({"type":"save_done","saved":false})";
    }
    SECTION( "legacy receipt without a write result" ) {
        response = R"({"type":"save_done"})";
    }
    REQUIRE( cata_mp::client_apply_message( response ) );
    const auto messages = Messages::recent_messages( 1 );
    REQUIRE( messages.size() == 1 );
    CHECK( ( messages.front().second.find( "The host saved the shared world" ) != std::string::npos ) ==
           saved );
    CHECK( ( messages.front().second.find( "did not confirm a successful save" ) != std::string::npos )
           ==
           !saved );
}

TEST_CASE( "rejoining_player_restores_saved_inventory_and_needs_without_stale_rollback",
           "[multiplayer][coop_save]" )
{
    consumption_fixture fixture;
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_id( "chocolate" ), calendar::turn, 3 ) );
    remote.set_thirst( 42 );
    remote.set_str_base( 15 );
    remote.set_skill_level( skill_id( "mechanics" ), 6 );
    remote.set_mutation( trait_id( "QUICK" ) );
    remote.set_mutation( trait_id( "CARNIVORE" ) );
    remote.set_mutation( trait_id( "MASOCHIST" ) );
    remote.set_pain( 80 );
    const int expected_morale = remote.get_morale_level();
    REQUIRE( expected_morale > 0 );
    // Set the authoritative body after trait setup, which itself recalculates HP.
    // A snapshot must retain this state, rather than recompute it from strength.
    remote.set_part_hp_max( bodypart_id( "arm_l" ), 137 );
    remote.set_part_hp_cur( bodypart_id( "arm_l" ), 17 );
    REQUIRE( remote.get_part_hp_cur( bodypart_id( "arm_l" ) ) == 17 );
    const std::string resumed = cata_mp::make_player_resume_result( remote, fixture.inventory );
    REQUIRE( fixture.inventory.revision > 0 );
    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    local.set_wielded_item( item( itype_id( "rock" ) ) );
    local.set_str_base( 8 );
    REQUIRE_FALSE( local.has_trait_flag( json_character_flag( "CARNIVORE_DIET" ) ) );
    const auto identity = local.getID();
    const auto position = local.pos_abs();
    local.activity = player_activity( activity_id( "ACT_WAIT" ), 400 );
    const auto rng = rng_get_engine();
    consumption_events events;
    REQUIRE( cata_mp::client_apply_message( resumed ) );
    REQUIRE( local.get_wielded_item() );
    CHECK( local.get_wielded_item()->typeId() == itype_id( "chocolate" ) );
    CHECK( local.get_wielded_item()->charges == 3 );
    CHECK( local.get_thirst() == 42 );
    CHECK( local.get_str_base() == 15 );
    CHECK( local.get_morale_level() == expected_morale );
    CHECK( local.get_part_hp_cur( bodypart_id( "arm_l" ) ) == 17 );
    CHECK( local.get_part_hp_max( bodypart_id( "arm_l" ) ) == 137 );
    CHECK( local.get_skill_level( skill_id( "mechanics" ) ) == 6 );
    CHECK( local.has_trait( trait_id( "QUICK" ) ) );
    CHECK( local.has_trait_flag( json_character_flag( "CARNIVORE_DIET" ) ) );
    CHECK( local.getID() == identity );
    CHECK( local.pos_abs() == position );
    CHECK( local.activity.id() == activity_id( "ACT_WAIT" ) );
    // Bad packets must not leave a half-replaced body or lose carried items.
    std::ostringstream before;
    JsonOut saved( before );
    local.store_player_state( saved );
    std::string malformed = before.str();
    const auto body = malformed.find( "\"body\":" );
    REQUIRE( body != std::string::npos );
    malformed.replace( body, 6, "\"missing_body\"" );
    const auto strength = malformed.find( "\"str_max\":15" );
    REQUIRE( strength != std::string::npos );
    malformed.replace( strength, 12, "\"str_max\":99" );
    CHECK_THROWS_AS( local.load_player_state( json_loader::from_string( malformed ).get_object() ),
                     JsonError );
    CHECK( local.get_str_base() == 15 );
    CHECK( local.get_morale_level() == expected_morale );
    REQUIRE( local.get_wielded_item() );
    CHECK( local.get_wielded_item()->charges == 3 );
    remote.get_wielded_item()->charges = 2;
    remote.set_thirst( 24 );
    REQUIRE( cata_mp::client_apply_message( cata_mp::make_player_resume_result( remote,
                                            fixture.inventory ) ) );
    REQUIRE( cata_mp::client_apply_message( resumed ) );
    CHECK( local.get_wielded_item()->charges == 2 );
    CHECK( local.get_thirst() == 24 );
    CHECK( events.actors.empty() );
    CHECK( rng_get_engine() == rng );
}

TEST_CASE( "authoritative_character_turn_frames_preserve_replica_ownership",
           "[multiplayer][body_authority]" )
{
    consumption_fixture fixture;
    npc &owner = fixture.remote();
    owner.set_mutation( trait_id( "CARNIVORE" ) );
    owner.set_mutation( trait_id( "MASOCHIST" ) );
    owner.add_effect( efftype_id( "took_prozac" ), 3_hours );
    owner.set_pain( 80 );
    const int expected_morale = owner.get_morale_level();
    REQUIRE( expected_morale > 0 );
    owner.set_part_hp_max( bodypart_id( "arm_l" ), 137 );
    owner.set_part_hp_cur( bodypart_id( "arm_l" ), 17 );
    owner.set_part_temp_cur( bodypart_id( "arm_l" ), units::from_legacy_bodypart_temp( 3800 ) );
    owner.set_part_wetness( bodypart_id( "arm_l" ), 12 );
    owner.set_stamina( 1234 );
    owner.set_thirst( 42 );
    owner.magic->set_mana( 456 );
    owner.add_effect( efftype_id( "bleed" ), 10_minutes, bodypart_id( "arm_l" ), 2 );
    owner.add_effect( efftype_id( "sleep" ), 3_hours );
    const auto snapshot = [&]() {
        std::ostringstream encoded;
        JsonOut out( encoded );
        owner.store_turn_state( out );
        return encoded.str();
    };
    const auto frame = [&]( int64_t revision ) {
        return R"({"type":"state","character_revision":)" + std::to_string( revision ) +
               R"(,"character_turn":)" + snapshot() + "}";
    };
    const std::string first = frame( 1 );
    const JsonObject projected = json_loader::from_string( snapshot() ).get_object();
    projected.allow_omitted_members();
    CHECK_FALSE( projected.has_member( "inv" ) );
    CHECK_FALSE( projected.has_member( "worn" ) );
    CHECK_FALSE( projected.has_member( "weapon" ) );
    CHECK_FALSE( projected.has_member( "activity" ) );
    CHECK_FALSE( projected.has_member( "location" ) );

    avatar &replica = get_avatar();
    cata_mp::set_client_mode( true );
    replica.set_wielded_item( item( itype_id( "rock" ) ) );
    const item_location held = replica.get_wielded_item();
    const item *const address = held.get_item();
    const character_id identity = replica.getID();
    const tripoint_abs_ms position = replica.pos_abs();
    replica.activity = player_activity( activity_id( "ACT_WAIT" ), 400 );
    replica.set_moves( 37 );
    replica.add_effect( efftype_id( "poison" ), 10_minutes );
    REQUIRE_FALSE( replica.has_trait_flag( json_character_flag( "CARNIVORE_DIET" ) ) );
    const auto rng = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( first ) );
    CHECK( replica.get_part_hp_cur( bodypart_id( "arm_l" ) ) == 17 );
    CHECK( replica.get_part_hp_max( bodypart_id( "arm_l" ) ) == 137 );
    CHECK( replica.get_part_temp_cur( bodypart_id( "arm_l" ) ) ==
           units::from_legacy_bodypart_temp( 3800 ) );
    CHECK( replica.get_part_wetness( bodypart_id( "arm_l" ) ) == 12 );
    CHECK( replica.get_stamina() == 1234 );
    CHECK( replica.get_thirst() == 42 );
    CHECK( replica.magic->available_mana() == 456 );
    CHECK( replica.get_pain() == 80 );
    CHECK( replica.get_morale_level() == expected_morale );
    CHECK( replica.get_effect( efftype_id( "sleep" ) ).get_duration() == 3_hours );
    CHECK( replica.get_effect( efftype_id( "bleed" ), bodypart_id( "arm_l" ) ).get_duration() ==
           10_minutes );
    CHECK_FALSE( replica.has_effect( efftype_id( "poison" ) ) );
    CHECK( replica.has_trait_flag( json_character_flag( "CARNIVORE_DIET" ) ) );
    CHECK( replica.getID() == identity );
    CHECK( replica.pos_abs() == position );
    CHECK( replica.activity.id() == activity_id( "ACT_WAIT" ) );
    CHECK( replica.activity.moves_left == 400 );
    CHECK( replica.get_moves() == 37 );
    CHECK( held.get_item() == address );
    CHECK( replica.get_wielded_item().get_item() == address );
    CHECK( rng_get_engine() == rng );

    // Two updates may occur without advancing the game calendar. The earlier
    // frame must not undo a more recent effect removal or stamina expenditure.
    owner.set_stamina( 900 );
    owner.remove_effect( efftype_id( "bleed" ) );
    REQUIRE( cata_mp::client_apply_message( frame( 2 ) ) );
    REQUIRE( cata_mp::client_apply_message( first ) );
    CHECK( replica.get_stamina() == 900 );
    CHECK_FALSE( replica.has_effect( efftype_id( "bleed" ) ) );
    CHECK( held.get_item() == address );

    // A malformed body cannot leave a half-imported character behind.
    owner.set_stamina( 500 );
    std::string malformed = snapshot();
    const auto body = malformed.find( "\"body\":" );
    REQUIRE( body != std::string::npos );
    malformed.replace( body, 6, "\"missing_body\"" );
    const auto before_rejected = rng_get_engine();
    CHECK_THROWS_AS( replica.load_turn_state( json_loader::from_string( malformed ).get_object() ),
                     JsonError );
    CHECK( replica.get_stamina() == 900 );
    CHECK( replica.get_part_hp_cur( bodypart_id( "arm_l" ) ) == 17 );
    CHECK( replica.activity.id() == activity_id( "ACT_WAIT" ) );
    CHECK( held.get_item() == address );
    CHECK( rng_get_engine() == before_rejected );
}


TEST_CASE( "current_item_replica_preserves_zero_charges_and_timers",
           "[multiplayer][item_turn]" )
{
    reload_fixture fixture;
    item ammo( itype_id( "556" ), calendar::turn, 5 );
    ammo.charges = 0;
    ammo.active = true;
    ammo.item_counter = 7;
    ammo.countdown_point = calendar::turn + 13_turns;
    const auto encode = []( const item & value ) {
        std::ostringstream text;
        JsonOut out( text );
        value.serialize( out );
        return text.str();
    };
    const std::string wire = encode( ammo );
    const auto rng = rng_get_engine();
    item restored = item::from_current_state( json_loader::from_string( wire ).get_object() );
    CHECK( rng_get_engine() == rng );
    CHECK( restored.uid() == ammo.uid() );
    CHECK( restored.charges == 0 );
    CHECK( restored.active );
    CHECK( restored.item_counter == 7 );
    CHECK( restored.countdown_point == ammo.countdown_point );
    CHECK( ammo.charges == 0 );
    CHECK( encode( restored ) == wire );

    CHECK_THROWS_AS( item::from_current_state( json_loader::from_string(
                         R"({"typeid":"556","uid":0})" ).get_object() ), JsonError );
    item rock( itype_id( "rock" ) );
    rock.charges = -1;
    const std::string rock_wire = encode( rock );
    CHECK( rock.charges == -1 );
    CHECK( item::from_current_state( json_loader::from_string( rock_wire ).get_object() ).charges ==
           -1 );

    // Historical save compatibility still repairs old zero-count ammunition.
    item legacy;
    legacy.deserialize( json_loader::from_string( wire ).get_object() );
    CHECK( legacy.charges > 0 );

    item bag( itype_id( "backpack" ) );
    REQUIRE( bag.put_in( ammo, pocket_type::CONTAINER ).success() );
    item cable( itype_id( "power_cord" ) );
    cable.link().last_processed = calendar::turn - 17_turns;
    REQUIRE( bag.put_in( cable, pocket_type::CONTAINER ).success() );
    const std::string nested = encode( bag );
    const auto nested_rng = rng_get_engine();
    item restored_bag = item::from_current_state( json_loader::from_string( nested ).get_object() );
    CHECK( rng_get_engine() == nested_rng );
    CHECK( encode( restored_bag ) == nested );
}

TEST_CASE( "native_item_turns_replicate_changes_and_preserve_surviving_locations",
           "[multiplayer][item_turn]" )
{
    reload_fixture fixture;
    npc &owner = fixture.remote();
    owner.set_wielded_item( item( itype_id( "backpack" ) ) );
    item_location bag = owner.get_wielded_item();
    item temporary( itype_id( "rock" ) );
    temporary.ethereal = true;
    temporary.set_var( "ethereal", 2 );
    REQUIRE( bag->put_in( temporary, pocket_type::CONTAINER ).success() );
    REQUIRE( bag->put_in( item( itype_id( "556" ), calendar::turn, 5 ),
                          pocket_type::CONTAINER ).success() );
    avatar &replica = get_avatar();
    cata_mp::set_client_mode( true );
    const auto initial = cata_mp::make_inventory_update( owner, fixture.inventory );
    REQUIRE( cata_mp::client_apply_message( initial ) );
    auto &client = g->multiplayer_session().client_pickup;
    const item_location replica_bag = replica.get_wielded_item();
    const item *const bag_address = replica_bag.get_item();
    const auto source_ammo = owner.items_with( []( const item & it ) {
        return it.typeId() == itype_id( "556" );
    } );
    const auto replica_ammo = replica.items_with( []( const item & it ) {
        return it.typeId() == itype_id( "556" );
    } );
    const auto replica_rocks = replica.items_with( []( const item & it ) {
        return it.typeId() == itype_id( "rock" );
    } );
    REQUIRE( source_ammo.size() == 1 );
    REQUIRE( replica_ammo.size() == 1 );
    REQUIRE( replica_rocks.size() == 1 );
    const item_location rounds( replica_bag, replica_ammo.front() );
    const item_location disappearing( replica_bag, replica_rocks.front() );
    const item *const rounds_address = rounds.get_item();
    replica.activity = player_activity( activity_id( "ACT_WAIT" ), 400 );
    replica.activity.targets.push_back( rounds );

    const auto before = cata_mp::capture_inventory_turn( owner );
    CHECK_FALSE( cata_mp::make_inventory_turn_update( owner, before, fixture.inventory ) );
    owner.process_items( &get_map() );
    source_ammo.front()->charges = 3;
    const auto first = cata_mp::make_inventory_turn_update( owner, before, fixture.inventory );
    REQUIRE( first );
    const JsonObject delta = json_loader::from_string( *first ).get_object();
    delta.allow_omitted_members();
    CHECK( delta.get_string( "type" ) == "inventory_delta" );
    CHECK_FALSE( delta.has_member( "carried" ) );
    CHECK( delta.get_array( "items" ).size() == 2 );
    const auto before_apply = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( *first ) );
    CHECK( rng_get_engine() == before_apply );
    REQUIRE( rounds.get_item() == rounds_address );
    CHECK( rounds->charges == 3 );
    REQUIRE( disappearing );
    CHECK( disappearing->get_var( "ethereal", 0 ) == 1 );
    CHECK( replica_bag.get_item() == bag_address );
    CHECK( replica.activity.targets.front().get_item() == rounds_address );
    CHECK( client.revision == fixture.inventory.revision );
    const auto old_upload = json_loader::from_string( R"({"inventory_revision":1})" ).get_object();
    CHECK_FALSE( cata_mp::pickup_inventory_revision_matches( old_upload, fixture.inventory ) );

    const auto second_before = cata_mp::capture_inventory_turn( owner );
    owner.process_items( &get_map() );
    source_ammo.front()->charges = 0;
    const auto second = cata_mp::make_inventory_turn_update( owner, second_before, fixture.inventory );
    REQUIRE( second );
    const JsonObject graph = json_loader::from_string( *second ).get_object();
    graph.allow_omitted_members();
    CHECK( graph.get_string( "type" ) == "inventory_update" );
    REQUIRE( cata_mp::client_apply_message( *second ) );
    CHECK_FALSE( disappearing );
    CHECK( replica_bag.get_item() == bag_address );
    REQUIRE( rounds.get_item() == rounds_address );
    CHECK( rounds->charges == 0 );
    CHECK( replica.activity.targets.front().get_item() == rounds_address );
    CHECK( replica.items_with( []( const item & it ) {
        return it.typeId() == itype_id( "rock" );
    } ).empty() );
    REQUIRE( cata_mp::client_apply_message( *first ) );
    CHECK( client.revision == fixture.inventory.revision );
    CHECK_FALSE( disappearing );
}

TEST_CASE( "item_delta_rejects_gaps_and_duplicate_ids_before_modifying_items",
           "[multiplayer][item_turn]" )
{
    reload_fixture fixture;
    avatar &replica = get_avatar();
    replica.set_wielded_item( item( itype_id( "556" ), calendar::turn, 5 ) );
    item_location rounds = replica.get_wielded_item();
    std::ostringstream payload;
    {
        JsonOut out( payload );
        rounds->store_current_state( out );
    }
    const auto request = [&]( int64_t base, bool duplicate ) {
        const std::string entry = R"({"uid":)" + std::to_string( rounds->uid().get_value() ) +
                                  R"(,"state":)" + payload.str() + "}";
        return R"({"base_revision":)" + std::to_string( base ) +
               R"(,"inventory_revision":2,"items":[)" + entry + ( duplicate ? "," + entry : "" ) + "]}";
    };
    rounds->charges = 3;
    cata_mp::pickup_client_state client;
    client.revision = 1;
    const auto rng = rng_get_engine();
    CHECK_THROWS_AS( cata_mp::apply_inventory_turn_update( replica,
                     json_loader::from_string( request( 0, false ) ).get_object(), client ), JsonError );
    CHECK_THROWS_AS( cata_mp::apply_inventory_turn_update( replica,
                     json_loader::from_string( request( 1, true ) ).get_object(), client ), JsonError );
    CHECK( rounds->charges == 3 );
    CHECK( client.revision == 1 );
    CHECK( rng_get_engine() == rng );
}


TEST_CASE( "owned_medication_applies_one_dose_to_its_actor_and_restores_the_client",
           "[multiplayer][consume_owned][medication_owned]" )
{
    const std::vector<std::pair<std::string, std::string>> medicines = {
        { "aspirin", "pkill1_nsaid" }, { "antibiotics", "antibiotic" },
        { "codeine", "pkill2" }, { "adrenaline_injector", "pkill2" },
        { "flu_shot", "flushot" }
    };
    for( const auto &medicine : medicines ) {
        DYNAMIC_SECTION( medicine.first ) {
            consumption_fixture fixture;
            npc &owner = fixture.remote();
            owner.set_wielded_item( item( itype_id( "backpack" ) ) );
            item_location bag = owner.get_wielded_item();
            REQUIRE( bag->put_in( item( itype_id( medicine.first ), calendar::turn, 2 ),
                                  pocket_type::CONTAINER ).success() );
            item_location source( bag, bag->all_items_top().front() );
            const efftype_id effect( medicine.second );
            const std::string host_before = needs_state( get_avatar() );
            consumption_events events;
            const std::string started = fixture.run( owner, consume_request( fixture, owner, source ) );
            REQUIRE( cata_mp::owns_inventory_activity( owner ) );
            CHECK( source->charges == 2 );
            CHECK_FALSE( owner.has_effect( effect ) );
            save_reload_activity( owner );
            owner.set_moves( 100000 );
            const std::string step = fixture.request( owner, "step" );
            const std::string finished = fixture.run( owner, step );
            REQUIRE_FALSE( owner.activity );
            REQUIRE( owner.has_effect( effect ) );
            CHECK( source->charges == 1 );
            CHECK( events.actors == std::vector<character_id> { owner.getID() } );
            CHECK( needs_state( get_avatar() ) == host_before );
            CHECK_FALSE( get_avatar().has_effect( effect ) );
            const auto duration = owner.get_effect_dur( effect );
            const auto after_dose = rng_get_engine();
            fixture.run( owner, step );
            CHECK( rng_get_engine() == after_dose );
            CHECK( source->charges == 1 );
            CHECK( owner.get_effect_dur( effect ) == duration );
            CHECK( events.actors.size() == 1 );

            avatar &replica = get_avatar();
            cata_mp::set_client_mode( true );
            auto &view = g->multiplayer_session().client_inventory_activity;
            view.active = true;
            view.pending_request = 1;
            replica.assign_activity( consume_activity_actor::client_view( false ) );
            const auto before_restore = rng_get_engine();
            REQUIRE( cata_mp::client_apply_message( started ) );
            view.pending_request = 2;
            REQUIRE( cata_mp::client_apply_message( finished ) );
            REQUIRE( replica.has_effect( effect ) );
            CHECK( replica.get_effect_dur( effect ) == duration );
            CHECK( replica.get_pain() == owner.get_pain() );
            CHECK( cata_mp::inventory_activity_view( replica.activity ) );
            CHECK( needs_state( replica ) == needs_state( owner ) );
            const auto remaining = replica.items_with( [&]( const item & it ) {
                return it.typeId() == itype_id( medicine.first );
            } );
            REQUIRE( remaining.size() == 1 );
            CHECK( remaining.front()->charges == 1 );
            REQUIRE( cata_mp::client_apply_message( finished ) );
            REQUIRE( cata_mp::client_apply_message( started ) );
            CHECK( remaining.front()->charges == 1 );
            CHECK( replica.get_effect_dur( effect ) == duration );
            CHECK( events.actors.size() == 1 );
            CHECK( rng_get_engine() == before_restore );
        }
    }
}

TEST_CASE( "owned_injection_requires_the_actors_tool_through_completion",
           "[multiplayer][consume_owned][medication_owned]" )
{
    consumption_fixture fixture;
    npc &owner = fixture.remote();
    owner.set_wielded_item( item( itype_id( "backpack" ) ) );
    item_location bag = owner.get_wielded_item();
    REQUIRE( bag->put_in( item( itype_id( "morphine" ), calendar::turn, 2 ),
                          pocket_type::CONTAINER ).success() );
    item_location drug( bag, bag->all_items_top().front() );
    get_avatar().set_wielded_item( item( itype_id( "syringe" ) ) );
    fixture.run( owner, consume_request( fixture, owner, drug ) );
    CHECK_FALSE( owner.activity );
    CHECK( drug->charges == 2 );
    CHECK_FALSE( owner.has_effect( efftype_id( "pkill3" ) ) );
    REQUIRE( bag->put_in( item( itype_id( "syringe" ) ), pocket_type::CONTAINER ).success() );
    fixture.run( owner, consume_request( fixture, owner, drug ) );
    REQUIRE( cata_mp::owns_inventory_activity( owner ) );
    bool removed = false;
    SECTION( "tool remains available" ) {}
    SECTION( "tool removed during activity" ) {
        const auto tools = owner.items_with( []( const item & it ) {
            return it.typeId() == itype_id( "syringe" );
        } );
        REQUIRE( tools.size() == 1 );
        item_location( bag, tools.front() ).remove_item();
        removed = true;
    }
    owner.set_moves( 100000 );
    fixture.run( owner, fixture.request( owner, "step" ) );
    CHECK_FALSE( owner.activity );
    CHECK( drug->charges == ( removed ? 2 : 1 ) );
    CHECK( owner.has_effect( efftype_id( "pkill3" ) ) == !removed );
    CHECK_FALSE( get_avatar().has_effect( efftype_id( "pkill3" ) ) );
}

TEST_CASE( "owned_consumption_does_not_invoke_targeted_or_scripted_medicine",
           "[multiplayer][consume_owned][medication_owned]" )
{
    for( const char *id : {
             "bfipowder", "myopia_contacts_weekly"
         } ) {
        DYNAMIC_SECTION( id ) {
            consumption_fixture fixture;
            npc &owner = fixture.remote();
            owner.set_wielded_item( item( itype_id( id ), calendar::turn, 2 ) );
            const item_location source = owner.get_wielded_item();
            const auto rng = rng_get_engine();
            const std::string before = needs_state( owner );
            fixture.run( owner, consume_request( fixture, owner, source, true ) );
            CHECK_FALSE( owner.activity );
            CHECK( source->charges == 2 );
            CHECK( needs_state( owner ) == before );
            CHECK( rng_get_engine() == rng );
        }
    }
}

TEST_CASE( "client_medication_activation_submits_without_obtaining_or_consuming",
           "[multiplayer][consume_owned][medication_owned]" )
{
    reload_fixture fixture;
    avatar &local = get_avatar();
    local.stomach.empty();
    local.set_moves( 100 );
    item_location source = get_map().add_item_or_charges_ret_loc( local.pos_bub(),
                           item( itype_id( "aspirin" ), calendar::turn, 2 ) );
    REQUIRE( source );
    const int64_t uid = source->uid().get_value();
    const auto rng = rng_get_engine();
    cata_mp::set_client_mode( true );
    avatar_action::use_item( local, source );
    const auto &view = g->multiplayer_session().client_inventory_activity;
    CHECK( view.active );
    CHECK( view.pending_request == 1 );
    CHECK( cata_mp::inventory_activity_view( local.activity ) );
    REQUIRE( source );
    CHECK( source.where() == item_location::type::map );
    CHECK( source->uid().get_value() == uid );
    CHECK( source->charges == 2 );
    CHECK_FALSE( local.has_effect( efftype_id( "pkill1_nsaid" ) ) );
    CHECK( rng_get_engine() == rng );
}

namespace
{
std::string firstaid_request( reload_fixture &fixture, Character &healer, Character &patient,
                              const item_location &source, const std::string &part = "arm_l" )
{
    return fixture.request( healer, "start", [&]( JsonOut & out ) {
        out.member( "kind", "firstaid" );
        out.member( "source", cata_mp::capture_item_source( healer, source ) );
        out.member( "self", &healer == &patient );
        out.member( "target", patient.pos_abs() );
        out.member( "target_player", cata_mp::partner_identity( patient.getID() ).str() );
        out.member( "target_npc", patient.getID().get_value() );
        out.member( "bodypart", part );
    } );
}

std::string practice_state( const Character &who )
{
    std::ostringstream text;
    JsonOut out( text );
    who.store_practice_state( out );
    return text.str();
}
}

TEST_CASE( "owned_firstaid_treats_the_selected_patient_and_part_once",
           "[multiplayer][firstaid_owned]" )
{
    for( const bool self : {
             true, false
         } ) {
        for( const char *medicine : {
                 "bfipowder", "bandages"
             } ) {
            DYNAMIC_SECTION( medicine << " self=" << self ) {
                consumption_fixture fixture;
                npc &healer = fixture.remote();
                avatar &host = get_avatar();
                host.ensure_player_id();
                host.setpos( get_map(), tripoint_bub_ms( 61, 60, 0 ) );
                Character &patient = self ? static_cast<Character &>( healer ) : host;
                const bodypart_id arm( "arm_l" );
                const bodypart_id torso( "torso" );
                patient.set_part_hp_cur( arm, patient.get_part_hp_max( arm ) - 10 );
                patient.set_part_hp_cur( torso, patient.get_part_hp_max( torso ) - 30 );
                const efftype_id effect( std::string( medicine ) == "bandages" ? "bandaged" :
                                         "disinfected" );
                healer.set_wielded_item( item( itype_id( "backpack" ) ) );
                item_location bag = healer.get_wielded_item();
                item dressing( itype_id( medicine ), calendar::turn );
                if( dressing.count_by_charges() ) {
                    dressing.charges = 2;
                }
                REQUIRE( bag->put_in( std::move( dressing ),
                                      pocket_type::CONTAINER ).success() );
                item_location source( bag, bag->all_items_top().front() );
                const bool charged = source->count_by_charges();
                const std::string untouched_practice = practice_state( host );
                fixture.run( healer, firstaid_request( fixture, healer, patient, source ) );
                REQUIRE( cata_mp::owns_inventory_activity( healer ) );
                CHECK( cata_mp::is_passive_activity( healer.activity.id().str() ) );
                CHECK( healer.get_moves() == 0 );
                CHECK_FALSE( patient.has_effect( effect, arm ) );
                save_reload_activity( healer );
                healer.set_moves( 100000 );
                const std::string step = fixture.request( healer, "step" );
                fixture.run( healer, step );
                REQUIRE_FALSE( healer.activity );
                REQUIRE( patient.has_effect( effect, arm ) );
                CHECK_FALSE( patient.has_effect( effect, torso ) );
                CHECK( practice_state( host ) == untouched_practice );
                CHECK( healer.get_proficiency_practiced_time( proficiency_id( "prof_wound_care" ) ) >
                       0_turns );
                if( !self ) {
                    CHECK_FALSE( healer.has_effect( effect, arm ) );
                }
                if( charged ) {
                    REQUIRE( source );
                    CHECK( source->charges == 1 );
                } else {
                    CHECK_FALSE( source );
                }
                const auto duration = patient.get_effect_dur( effect, arm );
                const std::string progress = practice_state( healer );
                const auto rng = rng_get_engine();
                fixture.run( healer, step );
                CHECK( patient.get_effect_dur( effect, arm ) == duration );
                CHECK( practice_state( healer ) == progress );
                CHECK( rng_get_engine() == rng );
            }
        }
    }
}

TEST_CASE( "owned_firstaid_revalidates_tools_patients_and_cancellation",
           "[multiplayer][firstaid_owned]" )
{
    consumption_fixture fixture;
    npc &healer = fixture.remote();
    avatar &patient = get_avatar();
    patient.ensure_player_id();
    patient.setpos( get_map(), tripoint_bub_ms( 61, 60, 0 ) );
    const bodypart_id arm( "arm_l" );
    patient.set_part_hp_cur( arm, patient.get_part_hp_max( arm ) - 10 );
    healer.set_wielded_item( item( itype_id( "bfipowder" ), calendar::turn, 2 ) );
    item_location source = healer.get_wielded_item();
    reload_events events;
    fixture.run( healer, firstaid_request( fixture, healer, patient, source ) );
    REQUIRE( cata_mp::owns_inventory_activity( healer ) );
    std::string operation = "step";
    SECTION( "patient walks away" ) {
        patient.setpos( get_map(), tripoint_bub_ms( 64, 60, 0 ) );
    }
    SECTION( "tool is removed" ) {
        source.remove_item();
    }
    SECTION( "tool changes type" ) {
        source->convert( itype_id( "aspirin" ) );
    }
    SECTION( "tool becomes filthy" ) {
        source->set_flag( flag_FILTHY );
    }
    SECTION( "cancel without action points" ) {
        operation = "cancel";
    }
    healer.set_moves( operation == "cancel" ? -5 : 100000 );
    const std::string request = fixture.request( healer, operation );
    fixture.run( healer, request );
    CHECK_FALSE( healer.activity );
    CHECK_FALSE( patient.has_effect( efftype_id( "disinfected" ), arm ) );
    CHECK( healer.get_proficiency_practiced_time( proficiency_id( "prof_wound_care" ) ) == 0_turns );
    CHECK( events.finishes == 1 );
    if( source ) {
        CHECK( source->charges == 2 );
    }
    // Native cancellation emits a gameplay event whose EOCs may use RNG.
    // A repeated request must not emit it again or advance gameplay RNG.
    const auto rng = rng_get_engine();
    fixture.run( healer, request );
    CHECK( events.finishes == 1 );
    CHECK( rng_get_engine() == rng );
}

TEST_CASE( "owned_firstaid_rejects_invalid_or_untreatable_body_parts",
           "[multiplayer][firstaid_owned]" )
{
    consumption_fixture fixture;
    npc &healer = fixture.remote();
    healer.set_wielded_item( item( itype_id( "bfipowder" ), calendar::turn, 2 ) );
    item_location source = healer.get_wielded_item();
    item_location selected = source;
    std::string part = "arm_l";
    SECTION( "unknown body part" ) {
        part = "no_such_part";
    }
    SECTION( "undamaged body part" ) {}
    SECTION( "another actor owns the tool" ) {
        healer.set_part_hp_cur( bodypart_id( "arm_l" ), 10 );
        get_avatar().set_wielded_item( item( itype_id( "bfipowder" ), calendar::turn, 2 ) );
        selected = get_avatar().get_wielded_item();
    }
    const auto rng = rng_get_engine();
    fixture.run( healer, firstaid_request( fixture, healer, healer, selected, part ) );
    CHECK_FALSE( healer.activity );
    CHECK( source->charges == 2 );
    CHECK( rng_get_engine() == rng );
}

TEST_CASE( "firstaid_results_restore_body_and_practice_without_replaying_treatment",
           "[multiplayer][firstaid_owned]" )
{
    consumption_fixture fixture;
    npc &healer = fixture.remote();
    const bodypart_id arm( "arm_l" );
    healer.set_part_hp_cur( arm, healer.get_part_hp_max( arm ) - 10 );
    healer.set_wielded_item( item( itype_id( "bfipowder" ), calendar::turn, 2 ) );
    item_location source = healer.get_wielded_item();
    const std::string started = fixture.run( healer, firstaid_request( fixture, healer, healer,
                                source ) );
    REQUIRE( cata_mp::owns_inventory_activity( healer ) );
    healer.set_moves( 100000 );
    const std::string finished = fixture.run( healer, fixture.request( healer, "step" ) );
    REQUIRE_FALSE( healer.activity );
    REQUIRE( healer.has_effect( efftype_id( "disinfected" ), arm ) );
    avatar &replica = get_avatar();
    cata_mp::set_client_mode( true );
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    replica.assign_activity( firstaid_activity_actor::client_view() );
    reload_events events;
    const auto rng = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( started ) );
    view.pending_request = 2;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( replica.get_part_hp_cur( arm ) == healer.get_part_hp_cur( arm ) );
    CHECK( replica.get_effect_dur( efftype_id( "disinfected" ), arm ) ==
           healer.get_effect_dur( efftype_id( "disinfected" ), arm ) );
    CHECK( practice_state( replica ) == practice_state( healer ) );
    REQUIRE( replica.get_wielded_item() );
    CHECK( replica.get_wielded_item()->charges == 1 );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( replica.activity );
    REQUIRE( cata_mp::client_apply_message( started ) );
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( practice_state( replica ) == practice_state( healer ) );
    CHECK( replica.get_wielded_item()->charges == 1 );
    CHECK( events.finishes == 0 );
    CHECK( rng_get_engine() == rng );
}


TEST_CASE( "owned_craft_request_completes_for_its_player_once_after_activity_reload",
           "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const recipe_id recipe( "cudgel_test_charged_fast_stepless" );
    who.learn_recipe( &recipe.obj() );
    who.set_wielded_item( item( &recipe.obj(), 1, item_components{}, {}, false ) );
    item_location workpiece = who.get_wielded_item();
    workpiece->item_counter = 10000000;
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    save_reload_activity( who );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( workpiece );
    REQUIRE( who.get_wielded_item() );
    CHECK( who.get_wielded_item()->typeId() == itype_id( "cudgel" ) );
    const int64_t result = who.get_wielded_item()->uid().get_value();
    const auto completed = rng_get_engine();
    fixture.run( who, step );
    CHECK( who.get_wielded_item()->uid().get_value() == result );
    CHECK( rng_get_engine() == completed );
    CHECK_FALSE( get_avatar().get_wielded_item() );
}

TEST_CASE( "owned_craft_pending_outputs_survive_cancel_and_reject_an_old_activity_request",
           "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const recipe_id recipe( "cudgel_test_charged_fast_stepless" );
    who.learn_recipe( &recipe.obj() );
    who.set_wielded_item( item( &recipe.obj(), 1, item_components{}, {}, false ) );
    item_location workpiece = who.get_wielded_item();
    workpiece->item_counter = 10000000;
    auto &completion = workpiece->get_craft_results();
    completion.stage = craft_completion_stage::primary_results;
    completion.primary_had_results = true;
    completion.pending.emplace_back( itype_id( "gasoline" ), calendar::turn, 20 );
    const int64_t fuel_id = completion.pending.front().uid().get_value();
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    const std::string old_activity = std::to_string( who.activity.identity_generation() );
    fixture.run( who, fixture.request( who, "step" ) );
    const auto *actor = dynamic_cast<const craft_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for() == "results" );
    fixture.run( who, fixture.request( who, "cancel" ) );
    CHECK_FALSE( who.activity );
    REQUIRE( workpiece );
    REQUIRE( workpiece->get_craft_results().pending.size() == 1 );
    CHECK( workpiece->get_craft_results().pending.front().uid().get_value() == fuel_id );
    who.set_moves( 100 );
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    fixture.run( who, fixture.request( who, "cancel", {}, old_activity ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    fixture.run( who, fixture.request( who, "step" ) );
    item &bottle = get_map().add_item_or_charges( who.pos_bub(), item( itype_id( "bottle_plastic" ) ) );
    unload_liquid_choice choice;
    choice.source = fuel_id;
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, item_location( map_cursor( who.pos_bub() ),
                                            &bottle ) );
    const std::string collect = fixture.request( who, "results", [&]( JsonOut & out ) {
        out.member( "liquids", std::vector<unload_liquid_choice> { choice } );
    } );
    fixture.run( who, collect );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( workpiece );
    REQUIRE_FALSE( bottle.empty() );
    CHECK( bottle.legacy_front().charges == 20 );
    const auto received = rng_get_engine();
    fixture.run( who, collect );
    CHECK( bottle.legacy_front().charges == 20 );
    CHECK( rng_get_engine() == received );
}


TEST_CASE( "owned_workpiece_cannot_be_claimed_by_two_active_players",
           "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    avatar &other = get_avatar();
    other.setpos( get_map(), who.pos_bub() + tripoint::east );
    const recipe_id recipe( "cudgel_test_charged_fast_stepless" );
    item prepared( &recipe.obj(), 1, item_components{}, {}, false );
    prepared.item_counter = 10000000;
    item_location workpiece = get_map().add_item_or_charges_ret_loc( who.pos_bub(), prepared );
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    other.assign_activity( craft_activity_actor( workpiece, false, &other ) );
    CHECK_FALSE( other.activity );
    CHECK( workpiece->get_crafter_id() == who.getID() );
    CHECK( cata_mp::owns_inventory_activity( who ) );
}

TEST_CASE( "owned_craft_start_resume_and_repeat_consume_each_selection_once",
           "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    set_time( calendar::turn_zero + 12_hours );
    const recipe_id recipe( "cudgel_test_charged_fast_stepless" );
    who.learn_recipe( &recipe.obj() );
    who.set_skill_level( recipe->skill_used, recipe->difficulty );
    who.set_knowledge_level( recipe->skill_used, recipe->difficulty );
    for( const auto &skill : recipe->required_skills ) {
        who.set_skill_level( skill.first, skill.second );
        who.set_knowledge_level( skill.first, skill.second );
    }
    map &here = get_map();
    item_location material = here.add_item_or_charges_ret_loc( who.pos_bub(),
                             item( itype_id( "2x4" ) ) );
    item_location tool = here.add_item_or_charges_ret_loc( who.pos_bub(),
                         tool_with_ammo( itype_id( "soldering_iron_portable" ), 100 ) );
    who.invalidate_crafting_inventory();
    craft_command selected( &recipe.obj(), 1, true, &who, who.pos_bub() );
    REQUIRE( selected.prepare() );
    REQUIRE( selected.prepare_owned_start() );
    REQUIRE( material );
    const int initial_ammo = tool->ammo_remaining();
    const std::string start = fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "craft" );
        out.member( "selection" );
        selected.serialize_selection( out );
    } );
    fixture.run( who, start );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    REQUIRE( who.activity.targets.size() == 1 );
    item_location workpiece = who.activity.targets.front();
    REQUIRE( workpiece );
    CHECK_FALSE( material );
    CHECK( tool->ammo_remaining() < initial_ammo );
    const int paid_ammo = tool->ammo_remaining();
    const int paid_buckets = workpiece->get_step_tool_allocs().front().front().consumed_buckets;
    fixture.run( who, start );
    CHECK( who.activity.targets.front() == workpiece );
    CHECK( tool->ammo_remaining() == paid_ammo );

    SECTION( "resume_requires_the_owner_plan_and_keeps_paid_tools" ) {
        fixture.run( who, fixture.request( who, "cancel" ) );
        REQUIRE_FALSE( who.activity );
        REQUIRE( workpiece );
        const int progress = workpiece->item_counter;
        who.set_moves( 1000 );
        const std::string resume = fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", "craft_resume" );
            out.member( "source", capture_item_source( who, workpiece ) );
        } );
        fixture.run( who, resume );
        REQUIRE( cata_mp::owns_inventory_activity( who ) );
        workpiece = who.get_wielded_item();
        REQUIRE( workpiece );
        auto *actor = dynamic_cast<craft_activity_actor *>( who.activity.actor.get() );
        REQUIRE( actor );
        REQUIRE( actor->waiting_for() == "resume" );
        save_reload_activity( who );
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK( workpiece->item_counter == progress );
        CHECK( who.get_moves() == 100 );
        auto plan = craft_resume_selection::prepare( who, *workpiece );
        REQUIRE( plan );
        const std::string choose = fixture.request( who, "choose", [&]( JsonOut & out ) {
            out.member( "decision", "resume" );
            out.member( "selection", *plan );
            out.member( "plans" );
            write_craft_plans( out, workpiece->get_step_plans() );
        } );
        fixture.run( who, choose );
        actor = dynamic_cast<craft_activity_actor *>( who.activity.actor.get() );
        REQUIRE( actor );
        CHECK( actor->waiting_for().empty() );
        CHECK( tool->ammo_remaining() == paid_ammo );
        CHECK( workpiece->get_step_tool_allocs().front().front().consumed_buckets == paid_buckets );
        fixture.run( who, choose );
        CHECK( tool->ammo_remaining() == paid_ammo );
        CHECK( workpiece->item_counter == progress );
    }

    SECTION( "long_craft_restarts_once_with_fresh_materials" ) {
        // Existing progress tests cover ticking; exercise completion and the next
        // command here without a long crafting loop or generated material supply.
        workpiece->item_counter = 10000000;
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        auto *actor = dynamic_cast<craft_activity_actor *>( who.activity.actor.get() );
        REQUIRE( actor );
        REQUIRE( actor->waiting_for() == "repeat" );
        CHECK_FALSE( workpiece );
        item_location next_material = here.add_item_or_charges_ret_loc( who.pos_bub(),
                                      item( itype_id( "2x4" ) ) );
        who.invalidate_crafting_inventory();
        craft_command next( &recipe.obj(), 1, true, &who, who.pos_bub() );
        REQUIRE( next.prepare() );
        REQUIRE( next.prepare_owned_start() );
        const auto previous = who.activity.identity_generation();
        const std::string restart = fixture.request( who, "restart", [&]( JsonOut & out ) {
            out.member( "selection" );
            next.serialize_selection( out );
        } );
        who.set_moves( 100 );
        fixture.run( who, restart );
        REQUIRE( cata_mp::owns_inventory_activity( who ) );
        CHECK( who.activity.identity_generation() != previous );
        REQUIRE( who.activity.targets.size() == 1 );
        workpiece = who.activity.targets.front();
        REQUIRE( workpiece );
        CHECK( workpiece->item_counter == 0 );
        CHECK_FALSE( next_material );
        const int after_restart = tool->ammo_remaining();
        fixture.run( who, restart );
        CHECK( who.activity.targets.front() == workpiece );
        CHECK( tool->ammo_remaining() == after_restart );
    }
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_craft_keeps_component_liquid_until_its_owner_selects_a_container",
           "[multiplayer][craft_owned][liquid]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const recipe_id recipe( "cudgel_test_charged_fast_stepless" );
    item container( itype_id( "bottle_plastic" ) );
    item fuel( itype_id( "gasoline" ), calendar::turn, 20 );
    REQUIRE( container.fill_with( fuel, 20 ) == 20 );
    item_components components;
    components.add( container );
    who.set_wielded_item( item( &recipe.obj(), 1, components, {}, false ) );
    item_location workpiece = who.get_wielded_item();
    workpiece->get_craft_results().components_pending = true;
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    const auto *actor = dynamic_cast<const craft_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    CHECK( actor->waiting_for() == "components" );
    save_reload_activity( who );
    fixture.run( who, fixture.request( who, "results", [&]( JsonOut & out ) {
        out.member( "liquids", std::vector<unload_liquid_choice> {} );
    } ) );
    REQUIRE( craft_has_pending_components( *workpiece ) );
    item &remaining = workpiece->components.begin()->second.front().legacy_front();
    CHECK( remaining.charges == 20 );
    CHECK( workpiece->item_counter == 0 );
    item_location destination = get_map().add_item_or_charges_ret_loc( who.pos_bub(),
                                item( itype_id( "bottle_plastic" ) ) );
    unload_liquid_choice choice;
    choice.source = remaining.uid().get_value();
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, destination );
    const std::string pour = fixture.request( who, "results", [&]( JsonOut & out ) {
        out.member( "liquids", std::vector<unload_liquid_choice> { choice } );
    } );
    who.set_moves( 100 );
    fixture.run( who, pour );
    CHECK_FALSE( craft_has_pending_components( *workpiece ) );
    REQUIRE_FALSE( destination->empty() );
    CHECK( destination->legacy_front().charges == 20 );
    fixture.run( who, pour );
    CHECK( destination->legacy_front().charges == 20 );
    fixture.run( who, fixture.request( who, "cancel" ) );
    REQUIRE( workpiece );
    CHECK( workpiece->components.size() == 1 );
}

TEST_CASE( "craft_timers_notify_only_the_owning_player", "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    auto &session = g->multiplayer_session();
    const cata_mp::player_id owner( std::string( 32, '7' ) );
    who.set_value( "mp_player_id", owner.str() );
    auto peer = std::make_unique<cata_mp::remote_player_session>();
    peer->actor.bind_player( who, owner, g->npc_lifetimes(),
                             g->player_controls().claim( owner, who ) );
    peer->connected = true;
    session.remote_players.emplace( 7, std::move( peer ) );
    auto &notices = session.remote_players.at( 7 )->inventory_activity;
    cata_mp::notify_craft_owner( who.getID(), "timer", true );
    cata_mp::notify_craft_owner( get_avatar().getID(), "host only" );
    REQUIRE( notices.notices.size() == 1 );
    CHECK( notices.notices.front().alarm );
    const std::string encoded = cata_mp::take_craft_notifications( notices );
    CHECK( notices.notices.empty() );
    const JsonValue value = json_loader::from_string( "{\"craft_notices\":" + encoded + "}" );
    cata_mp::apply_craft_notifications( value.get_object() );
    const auto &received = session.client_inventory_activity.notices;
    REQUIRE( received.size() == 1 );
    CHECK( received.front().message == "timer" );
    CHECK( received.front().alarm );
    CHECK( cata_mp::take_craft_notifications( notices ) == "[]" );
}

TEST_CASE( "owned_construction_start_and_completion_apply_once",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    set_time( calendar::turn_zero + 12_hours );
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.ter_set( target, ter_str_id( "t_dirt" ) );
    const construction_str_id id( "constr_wall_half" );
    for( const auto &[skill, level] : id->required_skills ) {
        who.set_skill_level( skill, level );
        who.set_knowledge_level( skill, level );
    }
    for( int i = 0; i < 10; ++i ) {
        here.add_item_or_charges( who.pos_bub(), item( itype_id( "2x4" ) ) );
    }
    here.add_item_or_charges( who.pos_bub(), item( itype_id( "nail" ), calendar::turn, 20 ) );
    here.add_item_or_charges( who.pos_bub(), item( itype_id( "hammer" ) ) );
    who.invalidate_crafting_inventory();
    auto selected = construction_selection::prepare( who, id.obj(), here.get_abs( target ) );
    REQUIRE( selected );
    CHECK_FALSE( here.partial_con_at( target ) );

    SECTION( "invalid_material_quantity_does_not_start_or_consume" ) {
        REQUIRE_FALSE( selected->components.empty() );
        selected->components.front().comp.count = 1;
        fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", "construction" );
            out.member( "selection", *selected );
        } ) );
        CHECK_FALSE( here.partial_con_at( target ) );
        CHECK_FALSE( who.activity );
        int boards = 0;
        for( const item &it : here.i_at( who.pos_bub() ) ) {
            if( it.typeId() == itype_id( "2x4" ) ) {
                boards += it.count();
            }
        }
        CHECK( boards == 10 );
    }
    SECTION( "automatic_blueprint_selects_materials_on_the_server" ) {
        map_stack ground = here.i_at( who.pos_bub() );
        const auto boards = std::find_if( ground.begin(), ground.end(), []( const item & it ) {
            return it.typeId() == itype_id( "2x4" );
        } );
        REQUIRE( boards != ground.end() );
        REQUIRE( boards->count_by_charges() );
        REQUIRE( boards->charges == 10 );
        item carried = *boards;
        carried.charges = 5;
        boards->mod_charges( -5 );
        who.i_add( carried );
        REQUIRE( who.charges_of( itype_id( "2x4" ) ) == 5 );
        who.invalidate_crafting_inventory();
        // i_add may wield the boards and spend the setup character's moves.
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", "construction_auto" );
            out.member( "construction", id );
            out.member( "position", here.get_abs( target ) );
        } ) );
        REQUIRE( cata_mp::owns_inventory_activity( who ) );
        REQUIRE( here.partial_con_at( target ) );
        int consumed_boards = 0;
        for( const item &it : here.partial_con_at( target )->components ) {
            if( it.typeId() == itype_id( "2x4" ) ) {
                consumed_boards += it.count();
            }
        }
        CHECK( consumed_boards == 10 );
        CHECK( who.amount_of( itype_id( "2x4" ) ) == 0 );
    }
    SECTION( "start_reload_progress_and_finish" ) {
        const std::string start = fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", "construction" );
            out.member( "selection", *selected );
        } );
        fixture.run( who, start );
        REQUIRE( cata_mp::owns_inventory_activity( who ) );
        partial_con *site = here.partial_con_at( target );
        REQUIRE( site );
        const int64_t uid = site->uid;
        REQUIRE( uid > 0 );
        const auto components = site->components.size();
        REQUIRE( components > 0 );
        fixture.run( who, start );
        CHECK( site->uid == uid );
        CHECK( site->components.size() == components );
        save_reload_activity( who );
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        REQUIRE( site->counter > 0 );
        site->counter = 9999999;
        who.set_moves( 100 );
        const std::string finish = fixture.request( who, "step" );
        fixture.run( who, finish );
        CHECK_FALSE( here.partial_con_at( target ) );
        CHECK_FALSE( who.activity );
        CHECK( here.ter( target ) == ter_str_id( "t_wall_half" ) );
        const auto rng = rng_get_engine();
        fixture.run( who, finish );
        CHECK( rng_get_engine() == rng );
        CHECK( here.ter( target ) == ter_str_id( "t_wall_half" ) );
        CHECK_FALSE( get_avatar().activity );
    }
}

TEST_CASE( "owned_construction_rejects_replaced_sites_and_refunds_only_once",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    set_time( calendar::turn_zero + 12_hours );
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    const construction_str_id id( "constr_wall_half" );
    for( const auto &[skill, level] : id->required_skills ) {
        who.set_skill_level( skill, level );
    }
    partial_con original;
    original.id = id.id();
    original.components.emplace_back( itype_id( "2x4" ) );
    here.partial_con_set( target, original );
    const int64_t old_uid = here.partial_con_at( target )->uid;
    auto change = [&]( const std::string & kind, int64_t uid ) {
        return fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", kind );
            out.member( "position", here.get_abs( target ) );
            out.member( "site", uid );
        } );
    };
    fixture.run( who, change( "construction_resume", old_uid ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    save_reload_activity( who );
    here.partial_con_remove( target );
    here.partial_con_set( target, original );
    const int64_t replacement = here.partial_con_at( target )->uid;
    REQUIRE( replacement != old_uid );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( here.partial_con_at( target )->counter == 0 );
    fixture.run( who, change( "construction_cancel", old_uid ) );
    REQUIRE( here.partial_con_at( target ) );
    const std::string cancel = change( "construction_cancel", replacement );
    fixture.run( who, cancel );
    CHECK_FALSE( here.partial_con_at( target ) );
    const auto count = [&]() {
        return std::count_if( here.i_at( who.pos_bub() ).begin(), here.i_at( who.pos_bub() ).end(),
        []( const item & it ) {
            return it.typeId() == itype_id( "2x4" );
        } );
    };
    CHECK( count() == 1 );
    fixture.run( who, cancel );
    CHECK( count() == 1 );
}

TEST_CASE( "owned_vehicle_construction_waits_for_its_players_name",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    set_time( calendar::turn_zero + 12_hours );
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    partial_con site;
    site.id = construction_str_id( "constr_veh" ).id();
    site.counter = 10000000;
    site.components.emplace_back( itype_id( "frame" ) );
    here.partial_con_set( target, site );
    who.assign_activity( build_construction_activity_actor( here.get_abs( target ), &who ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    const auto *actor = dynamic_cast<const build_construction_activity_actor *>
                        ( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for() == "vehicle_name" );
    save_reload_activity( who );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( here.veh_at( target ) );
    CHECK( who.get_moves() == 100 );
    fixture.run( who, fixture.request( who, "choose", [&]( JsonOut & out ) {
        out.member( "decision", "vehicle_name" );
        out.member( "text", "Remote workshop" );
    } ) );
    save_reload_activity( who );
    const std::string finish = fixture.request( who, "step" );
    fixture.run( who, finish );
    REQUIRE( here.veh_at( target ) );
    CHECK( here.veh_at( target )->vehicle().name == "Remote workshop" );
    CHECK_FALSE( here.partial_con_at( target ) );
    CHECK_FALSE( who.activity );
    const auto rng = rng_get_engine();
    fixture.run( who, finish );
    CHECK( rng_get_engine() == rng );
    CHECK( here.veh_at( target )->vehicle().name == "Remote workshop" );
}

TEST_CASE( "construction_site_save_preserves_identity_and_loads_legacy_layout",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    submap original;
    original.set_all_ter( ter_str_id( "t_dirt" ) );
    // Two legacy entries exercise the optional metadata delimiter between sites.
    const JsonValue legacy = json_loader::from_string(
                                 R"([0,1,0,5000000,"constr_pit_shallow",[],2,3,0,0,"constr_wall_half",[]])" );
    original.load( legacy, "partial_constructions", 0 );
    REQUIRE( original.partial_constructions.size() == 2 );
    const tripoint_sm_ms first( 0, 1, 0 );
    const tripoint_sm_ms second( 2, 3, 0 );
    const int64_t first_uid = original.partial_constructions.at( first ).uid;
    const int64_t second_uid = original.partial_constructions.at( second ).uid;
    REQUIRE( first_uid > 0 );
    REQUIRE( second_uid > first_uid );
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    original.store( out );
    out.end_object();
    JsonValue saved = json_loader::from_string( stream.str() );
    const JsonObject object = saved.get_object();
    object.allow_omitted_members();
    submap restored;
    restored.load( object.get_member( "partial_constructions" ), "partial_constructions", 0 );
    REQUIRE( restored.partial_constructions.size() == 2 );
    CHECK( restored.partial_constructions.at( first ).uid == first_uid );
    CHECK( restored.partial_constructions.at( second ).uid == second_uid );
    CHECK( restored.partial_constructions.at( first ).counter == 5000000 );
    CHECK( g->assign_construction_uid() > second_uid );
}

TEST_CASE( "blueprint_client_only_requests_work_and_preserves_its_planner",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    who.assign_activity( multi_build_construction_activity_actor() );
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    map &here = get_map();
    const tripoint_abs_ms target = who.pos_abs() + tripoint::east;
    REQUIRE( cata_mp::client_start_blueprint_construction(
                 construction_str_id( "constr_wall_half" ), target ) );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK_FALSE( here.partial_con_at( here.get_bub( target ) ) );
    REQUIRE_FALSE( who.backlog.empty() );
    CHECK( who.backlog.front().id() == activity_id( "ACT_MULTIPLE_CONSTRUCTION" ) );
    CHECK( who.backlog.front().auto_resume );
    partial_con replica;
    replica.id = construction_str_id( "constr_wall_half" ).id();
    here.partial_con_set( here.get_bub( target ), replica );
    const std::string upload = cata_mp::client_enrich_action( R"({"action":"wait"})" );
    CHECK( upload.find( "partial_con" ) == std::string::npos );
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.pending_request = 0;
    view.finished = true;
    SECTION( "accepted_work_resumes_the_blueprint_planner" ) {
        view.activity = "42";
        cata_mp::client_update_inventory_activity_view();
        CHECK( who.activity.id() == activity_id( "ACT_MULTIPLE_CONSTRUCTION" ) );
        CHECK( who.backlog.empty() );
        CHECK_FALSE( view.active );
    }
    SECTION( "rejected_start_does_not_repeat_automatically" ) {
        cata_mp::client_update_inventory_activity_view();
        CHECK_FALSE( who.activity );
        REQUIRE_FALSE( who.backlog.empty() );
        CHECK_FALSE( who.backlog.front().auto_resume );
        CHECK_FALSE( view.active );
    }
    SECTION( "declined_work_does_not_restart_the_planner" ) {
        view.activity = "42";
        who.backlog.front().auto_resume = false;
        cata_mp::client_update_inventory_activity_view();
        CHECK_FALSE( who.activity );
        CHECK_FALSE( view.active );
    }

}

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "cata_path.h"
#include "inventory.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_test_support.h"
#include "path_info.h"
#include "worldfactory.h"
#include <filesystem>
#include <variant>

TEST_CASE( "mp_item_activation_keeps_character_state_and_delayed_work_owned",
           "[mp_inventory_activity][mp_item_activation][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    reload_fixture fixture;
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const platform_lua_test_directory directory;
    const std::string old_savedir = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "item_activation_ownership" );
    const on_out_of_scope cleanup( [&]() {
        platform::shutdown();
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
    } );
    PATH_INFO::set_savedir( directory.root.string() + "/" );
    world_generator->active_world = &isolated_world;
    REQUIRE( std::filesystem::create_directory( isolated_world.folder_path().get_unrelative_path() ) );
    directory.write( "main.lua", R"lua(
local ccb = require("ccb")
local state = ccb.state.character
ccb.runtime.handler("start", function(event)
    if event.data.activity == "ACT_TEST_OWNED_ITEM" then
        state.set("starts", state.get("starts", 0) + 1)
    end
end)
ccb.runtime.on("game:character_starts_activity", "start")
ccb.runtime.handler("turn", function(event)
    state.set("turns", state.get("turns", 0) + 1)
end)
ccb.runtime.handler("finish", function(event)
    state.set("finished", state.get("finished", 0) + 1)
end)
ccb.runtime.handler("later", function(event)
    state.set("later", state.get("later", 0) + 1)
end)
ccb.runtime.handler("activate", function(context)
    if state.get("uses", 0) > 0 then return 0 end
    local consumed = ccb.services.inventory.consume_by_type(context.character,
        ccb.services.types.id("item", "apple"), 1, 0)
    assert(consumed.ok and consumed.value.matched)
    state.set("uses", 1)
    if previous_task then
        assert(ccb.tasks.get(previous_task) == nil)
        assert(not ccb.tasks.cancel(previous_task))
    end
    previous_task = ccb.tasks.after(3, "later", {}, 1, "character")
    assert(ccb.tasks.list(nil, "character").total == 1)
    local assigned = ccb.services.activities.assign_timed(context.character,
        ccb.services.types.id("activity", "ACT_TEST_OWNED_ITEM"),
        ccb.services.time.duration(2, "second"))
    assert(assigned.ok)
    return 0
end)
local activity = ccb.content.ActivityType {
    id = "ACT_TEST_OWNED_ITEM", verb = "using an owned tool", based_on = "time"
}
activity:on_turn("turn")
activity:on_finish("finish")
ccb.content.add(activity)
local tool = ccb.content.Item {
    id = "test_owned_lua_tool", name = "owned tool", description = "ownership regression", symbol = "?"
}
tool:mass_grams(1)
tool:volume_ml(1)
tool:on_use("activate", "Activate")
ccb.content.add(tool)
)lua" );
    const std::string mod = "item_activation_ownership";
    std::string error;
    const bool prepared = platform::prepare_mods(
    { { mod, directory.root, directory.root / "main.lua" } }, error );
    INFO( error );
    REQUIRE( prepared );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    const auto runtime = platform::detail::find_active_runtime( mod );
    REQUIRE( runtime );
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    auto controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '8' ) ), remote );
    const itype_id tool( "test_owned_lua_tool" );
    const itype_id apple( "apple" );
    for( Character *actor : { static_cast<Character *>( &host ), static_cast<Character *>( &remote ) } ) {
        actor->lua_character_state = {};
        actor->set_wielded_item( item( tool ) );
        actor->inv->add_item( item( apple ), false, false, false );
        actor->inv->add_item( item( apple ), false, false, false );
        actor->set_moves( 1000 );
    }
    const auto value = [&]( Character &who, const std::string &key ) {
        const auto &state = who.lua_character_state.for_mod( mod );
        const auto found = state.find( key );
        return found == state.end() ? int64_t( 0 ) : std::get<int64_t>( found->second );
    };
    const std::string method = "lua_platform:" + mod + ":activate";
    const auto use_request = [&]( const item_source &source ) {
        return fixture.request( remote, "start", [&]( JsonOut &out ) {
            out.member( "kind", "item_use" );
            out.member( "source", source );
            out.member( "item_type", tool );
            out.member( "method", method );
            out.member( "target", remote.pos_abs() );
        } );
    };
    // An item UID in another player's inventory is not an activation grant.
    fixture.run( remote, use_request( capture_item_source( host, host.get_wielded_item() ) ) );
    CHECK( value( host, "uses" ) == 0 );
    CHECK( value( remote, "uses" ) == 0 );
    CHECK( remote.amount_of( apple ) == 2 );
    const std::string denied = use_request( capture_item_source( remote, remote.get_wielded_item() ) );
    fixture.run( remote, denied, false );
    CHECK_FALSE( remote.activity );
    // Even a rejection returns a new inventory revision. Reusing that stale
    // request must still be rejected before a fresh authorized intent starts.
    fixture.run( remote, denied );
    CHECK_FALSE( remote.activity );
    const std::string request = use_request( capture_item_source( remote, remote.get_wielded_item() ) );
    fixture.run( remote, request );
    REQUIRE( remote.activity );
    CHECK( remote.activity.execution() == activity_execution::authoritative );
    CHECK( value( remote, "uses" ) == 1 );
    CHECK( value( remote, "starts" ) == 1 );
    CHECK( value( host, "uses" ) == 0 );
    CHECK( remote.amount_of( apple ) == 1 );
    fixture.run( remote, request );
    CHECK( remote.amount_of( apple ) == 1 );
    CHECK( value( remote, "starts" ) == 1 );

    REQUIRE( execute_owned_item_activation( host, host.get_wielded_item(), method,
                                           host.pos_abs(), false, false ) );
    CHECK( value( host, "uses" ) == 1 );
    CHECK( value( host, "starts" ) == 1 );
    CHECK( host.amount_of( apple ) == 1 );
    REQUIRE( runtime->tasks.size() == 2 );
    CHECK( runtime->tasks.front().state_character_id == remote.getID() );
    CHECK( runtime->tasks.back().state_character_id == host.getID() );

    // Native save data owns the state and activity. The task sidecar owns the
    // pending callback identity; neither may silently rebind to the host.
    std::ostringstream saved_actor;
    JsonOut actor_json( saved_actor );
    remote.serialize( actor_json );
    npc loaded;
    loaded.deserialize( json_loader::from_string( saved_actor.str() ).get_object() );
    CHECK( value( loaded, "uses" ) == 1 );
    CHECK( loaded.activity.execution() == activity_execution::authoritative );
    REQUIRE( platform::runtime_save( error ) );
    runtime->tasks.clear();
    platform::runtime_world_ready( false );
    REQUIRE( runtime->tasks.size() == 2 );
    calendar::turn += 3_seconds;
    platform::runtime_process_tasks();
    CHECK( value( remote, "later" ) == 1 );
    CHECK( value( host, "later" ) == 1 );
    CHECK( runtime->tasks.empty() );

    fixture.reload = {}; // Reconnect reconstructs tracking from saved activity ownership.
    for( int turn = 0; turn < 2; ++turn ) {
        remote.set_moves( 1000 );
        host.set_moves( 1000 );
        fixture.run( remote, fixture.request( remote, "step" ) );
        host.activity.do_turn( host );
        CHECK( remote.activity.moves_left == host.activity.moves_left );
        CHECK( remote.get_moves() == host.get_moves() );
        CHECK( value( remote, "finished" ) == turn );
        CHECK( value( host, "finished" ) == turn );
    }
    CHECK_FALSE( remote.activity );
    CHECK_FALSE( host.activity );
    CHECK( value( host, "finished" ) == 1 );
    CHECK( value( remote, "finished" ) == 1 );

    // A client progress view must not run the Lua activity a second time.
    const int64_t host_starts = value( host, "starts" );
    const int64_t host_turns = value( host, "turns" );
    player_activity view( activity_id( "ACT_TEST_OWNED_ITEM" ), 100 );
    view.set_execution( activity_execution::presentation );
    host.assign_activity( view );
    host.activity.do_turn( host );
    CHECK( value( host, "starts" ) == host_starts );
    CHECK( value( host, "turns" ) == host_turns );
    CHECK( value( host, "finished" ) == 1 );
    host.assign_activity( view );
    host.cancel_activity();
    CHECK( g->multiplayer_session().client_inventory_activity.cancel_requested );
    CHECK( value( host, "starts" ) == host_starts );

    // Native state wins over stale sidecar values, including deliberate deletion.
    host.lua_character_state.for_mod( mod ).clear();
    host.lua_character_state.migrate_legacy( mod, { { "uses", int64_t( 99 ) } } );
    CHECK( value( host, "uses" ) == 0 );
    CHECK( value( remote, "uses" ) == 1 );
    sol::table ccb = ( *runtime->lua )["package"]["loaded"]["ccb"];
    const sol::protected_function get_state = ccb["state"]["character"]["get"];
    {
        platform::detail::callback_scope actor_scope( *runtime, &remote );
        platform::detail::callback_scope nested_actorless( *runtime, nullptr );
        const auto inherited = get_state( "uses", 0 );
        REQUIRE( inherited.valid() );
        CHECK( inherited.get<int>() == 1 );
        g->remove_npc( remote.getID() );
        // A stale explicit actor must never fall back to the host's state.
        const auto expired = get_state( "uses", 0 );
        CHECK_FALSE( expired.valid() );
    }
    CHECK( value( host, "uses" ) == 0 );
}
#endif

TEST_CASE( "mp_native_item_activation_transforms_once", "[mp_inventory_activity][mp_item_activation]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_id( "grenade" ) ) );
    remote.set_moves( 1000 );
    const auto source = capture_item_source( remote, remote.get_wielded_item() );
    const std::string request = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", source );
        out.member( "item_type", "grenade" );
        out.member( "method", "transform" );
        out.member( "target", remote.pos_abs() );
    } );
    fixture.run( remote, request );
    REQUIRE( remote.get_wielded_item() );
    CHECK( remote.get_wielded_item()->typeId() == itype_id( "grenade_act" ) );
    const int moves = remote.get_moves();
    const auto countdown = remote.get_wielded_item()->countdown_point;
    fixture.run( remote, request );
    CHECK( remote.get_moves() == moves );
    CHECK( remote.get_wielded_item()->countdown_point == countdown );
    CHECK_FALSE( remote.activity );
}


TEST_CASE( "mp_item_activation_timer_uses_player_choice_once",
           "[mp_inventory_activity][mp_item_activation]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    host.set_moves( 1000 );
    host.set_wielded_item( item( itype_id( "c4" ) ) );
    remote.set_moves( 1000 );
    remote.set_wielded_item( item( itype_id( "c4" ) ) );
    const auto source = capture_item_source( remote, remote.get_wielded_item() );
    const std::string request = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", source );
        out.member( "item_type", "c4" );
        out.member( "method", "transform" );
        out.member( "target", remote.pos_abs() );
        out.member( "timer_seconds", 37 );
    } );
    const auto before_rng = rng_get_engine();
    fixture.run( remote, request );
    const auto after_rng = rng_get_engine();
    REQUIRE( remote.get_wielded_item() );
    CHECK( remote.get_wielded_item()->typeId() == itype_id( "c4armed" ) );
    CHECK( remote.get_wielded_item()->countdown_point == calendar::turn + 37_seconds );
    const int moves = remote.get_moves();
    fixture.run( remote, request );
    CHECK( remote.get_moves() == moves );
    CHECK( remote.get_wielded_item()->countdown_point == calendar::turn + 37_seconds );
    CHECK( rng_get_engine() == after_rng );

    // The same explicit choice follows the same native operation on the host.
    rng_get_engine() = before_rng;
    item_activation_choices choices;
    choices.timer_seconds = 37;
    REQUIRE( execute_owned_item_activation( host, host.get_wielded_item(), "transform",
                                           host.pos_abs(), false, false, choices ) );
    CHECK( host.get_wielded_item()->typeId() == remote.get_wielded_item()->typeId() );
    CHECK( host.get_wielded_item()->countdown_point == remote.get_wielded_item()->countdown_point );
    CHECK( host.get_moves() == moves );
    CHECK( rng_get_engine() == after_rng );

    // Timer is native item state and survives the normal save format.
    std::ostringstream saved;
    JsonOut out( saved );
    remote.get_wielded_item()->serialize( out );
    item restored;
    JsonValue value = json_loader::from_string( saved.str() );
    restored.deserialize( value.get_object() );
    CHECK( restored.typeId() == itype_id( "c4armed" ) );
    CHECK( restored.countdown_point == calendar::turn + 37_seconds );
}

TEST_CASE( "mp_item_activation_rejects_invalid_choices_before_effects",
           "[mp_inventory_activity][mp_item_activation]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    restore_on_out_of_scope restore_turn( calendar::turn );
    calendar::turn = calendar::turn_zero + 1_days;
    remote.set_moves( 1000 );
    remote.set_wielded_item( item( itype_id( "c4" ) ) );
    const auto source = capture_item_source( remote, remote.get_wielded_item() );
    const auto before_rng = rng_get_engine();
    for( const std::optional<int> seconds : { std::optional<int>(), std::optional<int>( 0 ),
                                            std::optional<int>( -1 ), std::optional<int>( std::numeric_limits<int>::max() ) } ) {
        const std::string request = fixture.request( remote, "start", [&]( JsonOut &out ) {
            out.member( "kind", "item_use" );
            out.member( "source", source );
            out.member( "item_type", "c4" );
            out.member( "method", "transform" );
            out.member( "target", remote.pos_abs() );
            if( seconds ) {
                out.member( "timer_seconds", *seconds );
            }
        } );
        const std::string result = fixture.run( remote, request );
        JsonValue value = json_loader::from_string( result );
        JsonObject response = value.get_object();
        response.allow_omitted_members();
        CHECK( response.get_string( "activity" ).empty() );
        CHECK( remote.get_moves() == 1000 );
        CHECK( remote.get_wielded_item()->typeId() == itype_id( "c4" ) );
        CHECK( rng_get_engine() == before_rng );
    }
    // A stale or malicious choice cannot retime a fixed-fuse transformation.
    remote.set_wielded_item( item( itype_id( "grenade" ) ) );
    item_activation_choices choices;
    choices.timer_seconds = 90;
    CHECK_FALSE( execute_owned_item_activation( remote, remote.get_wielded_item(), "transform",
                 remote.pos_abs(), false, false, choices ) );
    CHECK( remote.get_wielded_item()->typeId() == itype_id( "grenade" ) );
    CHECK( remote.get_moves() == 1000 );
    CHECK( rng_get_engine() == before_rng );
}

TEST_CASE( "item_activation_choices_preserve_delayed_readiness_and_npc_defaults",
           "[mp_item_activation]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    restore_on_out_of_scope restore_turn( calendar::turn );
    calendar::turn = calendar::turn_zero + 1_days;
    delayed_transform_iuse action;
    action.transform.target = itype_id( "c4armed" );
    action.set_timer = true;
    action.transform_age = 100;
    item explosive( itype_id( "c4" ), calendar::turn );
    item_activation_choices choices;
    choices.timer_seconds = 23;
    CHECK_FALSE( action.use_with_choices( &remote, explosive, &get_map(), remote.pos_bub(), choices ) );
    CHECK( explosive.typeId() == itype_id( "c4" ) );
    explosive.set_age( 100_seconds );
    REQUIRE( action.time_to_do( explosive ) == 0 );
    REQUIRE( action.use_with_choices( &remote, explosive, &get_map(), remote.pos_bub(), choices ) );
    CHECK( explosive.typeId() == itype_id( "c4armed" ) );
    CHECK( explosive.countdown_point == calendar::turn + 23_seconds );

    // An ordinary NPC call, with no player choice channel, keeps the type's fuse.
    item automatic( itype_id( "c4" ) );
    iuse_transform normal;
    normal.transform.target = itype_id( "c4armed" );
    normal.set_timer = true;
    REQUIRE( normal.use( &remote, automatic, &get_map(), remote.pos_bub() ) );
    CHECK( automatic.typeId() == itype_id( "c4armed" ) );
    CHECK( automatic.countdown_point == calendar::turn + 6_seconds );
}


TEST_CASE( "mp_adjacent_tools_complete_once_and_cancel_competing_work",
           "[mp_inventory_activity][mp_adjacent_tool]" )
{
    const std::string method = GENERATE( "CROWBAR", "PICKAXE", "JACKHAMMER", "PICK_LOCK" );
    CAPTURE( method );
    reload_fixture fixture;
    map &here = get_map();
    npc &remote = fixture.remote();
    auto controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 62, 60, 0 ) );
    const tripoint_bub_ms target( 61, 60, 0 );
    const ter_id original = ter_str_id( method == "CROWBAR" ? "test_t_prying1" :
                                       method == "PICK_LOCK" ? "t_door_locked" : "t_rock" ).id();
    here.ter_set( target, original );
    const itype_id tool_id( method == "CROWBAR" ? "test_halligan" :
                           method == "PICKAXE" ? "pickaxe" :
                           method == "JACKHAMMER" ? "jackhammer_mining" : "test_sonic_screwdriver" );
    for( Character *who : { static_cast<Character *>( &host ), static_cast<Character *>( &remote ) } ) {
        item tool( tool_id );
        if( method == "JACKHAMMER" ) {
            tool.ammo_set( itype_id( "gasoline" ), 1200 );
        }
        who->set_wielded_item( std::move( tool ) );
        who->set_moves( 1000 );
    }
    const std::string start = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( remote, remote.get_wielded_item() ) );
        out.member( "item_type", tool_id );
        out.member( "method", method );
        out.member( "target", here.get_abs( target ) );
    } );
    fixture.run( remote, start );
    REQUIRE( remote.activity );
    CHECK( remote.activity.execution() == activity_execution::authoritative );
    CHECK( remote.activity.moves_total > 0 );
    const int work = remote.activity.moves_left;
    fixture.run( remote, start );
    CHECK( remote.activity.moves_left == work );
    save_reload_activity( remote );
    CHECK( remote.activity.execution() == activity_execution::authoritative );

    REQUIRE( execute_owned_item_activation( host, host.get_wielded_item(), method,
                                           here.get_abs( target ), false, false ) );
    REQUIRE( host.activity );
    const auto host_ammo = host.get_wielded_item()->ammo_remaining();
    remote.activity.moves_left = 1;
    remote.set_moves( 100 );
    const std::string finish = fixture.request( remote, "step" );
    fixture.run( remote, finish );
    CHECK_FALSE( remote.activity );
    CHECK( here.ter( target ) != original );
    if( method == "PICK_LOCK" ) {
        CHECK( remote.get_skill_level_object( skill_id( "traps" ) ).exercise() > 0 );
        CHECK( host.get_skill_level_object( skill_id( "traps" ) ).exercise() == 0 );
    }
    if( method == "JACKHAMMER" ) {
        CHECK( remote.get_wielded_item()->ammo_remaining() < host_ammo );
    }
    const auto after_rng = rng_get_engine();
    const auto drops = here.i_at( target ).size();
    const auto remote_ammo = remote.get_wielded_item()->ammo_remaining();
    fixture.run( remote, finish );
    CHECK( rng_get_engine() == after_rng );
    CHECK( here.i_at( target ).size() == drops );
    CHECK( remote.get_wielded_item()->ammo_remaining() == remote_ammo );

    // The host's old activity must not harvest the replacement surface.
    host.activity.moves_left = 1;
    host.set_moves( 100 );
    host.activity.do_turn( host );
    CHECK_FALSE( host.activity );
    CHECK( here.i_at( target ).size() == drops );
    CHECK( host.get_wielded_item()->ammo_remaining() == host_ammo );
    CHECK( rng_get_engine() == after_rng );
}

TEST_CASE( "mp_adjacent_tools_reject_bad_targets_and_lost_access",
           "[mp_inventory_activity][mp_adjacent_tool]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_id( "test_halligan" ) ) );
    remote.set_moves( 1000 );
    const auto before_rng = rng_get_engine();
    for( const tripoint_bub_ms &target : { remote.pos_bub(), tripoint_bub_ms( 64, 60, 0 ),
                                        tripoint_bub_ms( 60, 60, 1 ) } ) {
        here.ter_set( target, ter_str_id( "test_t_prying1" ) );
        CHECK_FALSE( execute_owned_item_activation( remote, remote.get_wielded_item(), "CROWBAR",
                     here.get_abs( target ), false, false ) );
        CHECK_FALSE( remote.activity );
        CHECK( remote.get_moves() == 1000 );
        CHECK( rng_get_engine() == before_rng );
    }
    const tripoint_bub_ms target( 61, 60, 0 );
    here.ter_set( target, ter_str_id( "test_t_prying1" ) );
    REQUIRE( execute_owned_item_activation( remote, remote.get_wielded_item(), "CROWBAR",
                                           here.get_abs( target ), false, false ) );
    SECTION( "tool_removed" ) {
        remote.remove_weapon();
    }
    SECTION( "actor_moved_away" ) {
        remote.setpos( here, tripoint_bub_ms( 64, 60, 0 ) );
    }
    SECTION( "target_changed_while_saved" ) {
        save_reload_activity( remote );
        here.ter_set( target, ter_str_id( "t_door_locked" ) );
    }
    remote.activity.moves_left = 1;
    remote.set_moves( 100 );
    remote.activity.do_turn( remote );
    CHECK_FALSE( remote.activity );
    CHECK( here.i_at( target ).empty() );
}

TEST_CASE( "owned_tool_target_tracks_absolute_surface_and_vehicle_identity",
           "[mp_adjacent_tool]" )
{
    reload_fixture fixture;
    map &here = get_map();
    const tripoint_bub_ms target( 61, 60, 0 );
    here.ter_set( target, ter_str_id( "t_door_locked" ) );
    const auto captured = tool_activity_target::capture( here, here.get_abs( target ) );
    std::ostringstream stream;
    JsonOut out( stream );
    captured.serialize( out );
    tool_activity_target restored;
    JsonValue value = json_loader::from_string( stream.str() );
    restored.deserialize( value.get_object() );
    CHECK( restored.position == here.get_abs( target ) );
    CHECK( restored.matches( here ) );
    here.ter_set( target, ter_str_id( "t_door_c" ) );
    CHECK_FALSE( restored.matches( here ) );
    here.ter_set( target, ter_str_id( "t_pavement" ) );
    const auto empty = tool_activity_target::capture( here, here.get_abs( target ) );
    vehicle *car = here.add_vehicle( vproto_id( "car" ), target, 0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( car );
    const auto occupied = tool_activity_target::capture( here, here.get_abs( target ) );
    CHECK( occupied.vehicle == car->uid().get_value() );
    CHECK_FALSE( empty.matches( here ) );
    bool checked_lock = false;
    for( int i = 0; i < car->part_count(); ++i ) {
        if( car->part( i ).info().has_flag( "LOCKABLE_DOOR" ) ) {
            if( !car->part_has_lock( i ) ) {
                const point_rel_ms mount = car->part( i ).mount;
                REQUIRE( car->install_part( here, mount, vpart_id( "door_lock" ) ) >= 0 );
            }
            car->part( i ).locked = true;
            const auto door = tool_activity_target::capture( here,
                              here.get_abs( car->bub_part_pos( here, i ) ) );
            REQUIRE( door.locked_part != 0 );
            CHECK( door.matches( here ) );
            car->part( i ).locked = false;
            CHECK_FALSE( door.matches( here ) );
            checked_lock = true;
            break;
        }
    }
    CHECK( checked_lock );
    here.destroy_vehicle( car );
    CHECK_FALSE( occupied.matches( here ) );
}

TEST_CASE( "automatic_mining_is_authoritative_and_only_completed_work_queues_movement",
           "[multiplayer][mp_auto_tool]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &remote = fixture.remote();
    auto controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    avatar &local = get_avatar();
    local.clear_destination();
    const on_out_of_scope clear_route( [&local]() { local.clear_destination(); } );
    const tripoint_bub_ms target = remote.pos_bub() + tripoint::east;
    here.ter_set( target, ter_str_id( "t_rock" ) );
    remote.set_wielded_item( item( itype_id( "jackhammer_mining" ) ) );
    item_location tool = remote.get_wielded_item();
    tool->ammo_set( itype_id( "gasoline" ), 1200 );
    const std::string outcome = GENERATE( "finish", "cancel", "empty", "stunned", "lost_tool" );
    CAPTURE( outcome );
    if( outcome == "empty" ) {
        tool->ammo_set( itype_id( "gasoline" ), 0 );
    } else if( outcome == "stunned" ) {
        remote.add_effect( efftype_id( "stunned" ), 1_minutes );
    }
    const auto rng_before_start = rng_get_engine();
    const std::string wire = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "auto_mine" );
        out.member( "source", cata_mp::capture_item_source( remote, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", "JACKHAMMER" );
        out.member( "target", here.get_abs( target ) );
    } );
    const std::string started = fixture.run( remote, wire );
    const auto rng_after_start = rng_get_engine();
    fixture.run( remote, wire );
    const bool accepted = outcome != "empty" && outcome != "stunned";
    CHECK( static_cast<bool>( remote.activity ) == accepted );
    CHECK( static_cast<bool>( fixture.reload.automatic_mining_target ) == accepted );
    CHECK( rng_get_engine() == rng_after_start );
    if( !accepted ) {
        CHECK( rng_get_engine() == rng_before_start );
    }
    CHECK( here.ter( target ) == ter_str_id( "t_rock" ).id() );
    std::string result = started;
    if( accepted ) {
        save_reload_activity( remote );
        if( outcome == "lost_tool" ) {
            remote.remove_weapon();
        }
        remote.set_moves( 100 );
        remote.activity.moves_left = 0;
        result = fixture.run( remote, fixture.request( remote, outcome == "cancel" ? "cancel" : "step" ) );
        CHECK_FALSE( remote.activity );
    }
    const bool finished = outcome == "finish";
    CHECK( here.passable( target ) == finished );
    CHECK( ( result.find( "automatic_mining_destination" ) != std::string::npos ) == finished );
    CHECK_FALSE( fixture.reload.automatic_mining_target );
    if( finished ) {
        CHECK( tool->ammo_remaining() < 1200 );
    } else if( outcome != "lost_tool" ) {
        CHECK( tool->ammo_remaining() == ( outcome == "empty" ? 0 : 1200 ) );
    }

    // Apply the real authority result to a client view. It must queue the
    // follow-up step exactly once without executing the mining actor locally.
    local.setpos( here, remote.pos_bub() );
    cata_mp::set_client_mode( true );
    player_activity view_activity{ invoke_item_activity_actor( item_location(), std::string() ) };
    view_activity.set_execution( activity_execution::presentation );
    local.assign_activity( view_activity );
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = fixture.sequence;
    const auto rng_before_replica = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( result ) );
    CHECK( local.has_destination() == finished );
    REQUIRE( cata_mp::client_apply_message( result ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( local.activity );
    CHECK( rng_get_engine() == rng_before_replica );
    if( finished ) {
        CHECK( local.get_next_auto_move_direction() == ACTION_MOVE_RIGHT );
        CHECK_FALSE( local.has_destination() );
    }
}

TEST_CASE( "automatic_and_examine_tool_entries_only_create_client_views",
           "[multiplayer][mp_auto_tool]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    who.clear_destination();
    const on_out_of_scope clear_route( [&who]() { who.clear_destination(); } );
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    const override_option auto_features( "AUTO_FEATURES", "true" );
    const override_option auto_mining( "AUTO_MINING", "true" );
    restore_on_out_of_scope restore_mostseen( g->mostseen );
    g->mostseen = 0;
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    auto rng_before = rng_get_engine();
    SECTION( "automatic_mining" ) {
        here.ter_set( target, ter_str_id( "t_rock" ) );
        who.set_wielded_item( item( itype_id( "pickaxe" ) ) );
        rng_before = rng_get_engine();
        REQUIRE( cata_mp::client_auto_mine( here.get_abs( target ) ) );
        CHECK( here.ter( target ) == ter_str_id( "t_rock" ).id() );
        CHECK_FALSE( who.has_destination() );
    }
    SECTION( "examine_pry" ) {
        here.ter_set( target, ter_str_id( "test_t_prying1" ) );
        who.set_wielded_item( item( itype_id( "test_halligan" ) ) );
        rng_before = rng_get_engine();
        iexamine::locked_object( who, target );
        CHECK( here.ter( target ) == ter_str_id( "test_t_prying1" ).id() );
    }
    SECTION( "explicit_lockpick_target" ) {
        here.ter_set( target, ter_str_id( "t_door_locked" ) );
        who.set_wielded_item( item( itype_id( "test_sonic_screwdriver" ) ) );
        std::string method = "PICK_LOCK";
        rng_before = rng_get_engine();
        REQUIRE( cata_mp::client_activate_item( who.get_wielded_item(), method, here.get_abs( target ) ) );
        CHECK( here.ter( target ) == ter_str_id( "t_door_locked" ).id() );
    }
    CHECK( who.activity.execution() == activity_execution::presentation );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK( rng_get_engine() == rng_before );
    CHECK_FALSE( dynamic_cast<prying_activity_actor *>( who.activity.actor.get() ) );
    CHECK_FALSE( dynamic_cast<lockpick_activity_actor *>( who.activity.actor.get() ) );
}

TEST_CASE( "examine_prying_preserves_tools_without_a_manual_use_action",
           "[multiplayer][mp_auto_tool]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.ter_set( target, ter_str_id( "test_t_prying1" ) );
    who.set_wielded_item( item( itype_id( "nail_puller_bronze" ) ) );
    const item_location tool = who.get_wielded_item();
    REQUIRE_FALSE( supports_owned_item_activation( *tool, "CROWBAR" ) );
    const std::string start = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "examine_pry" );
        out.member( "source", cata_mp::capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "target", here.get_abs( target ) );
    } );
    fixture.run( who, start );
    REQUIRE( who.activity.id() == activity_id( "ACT_PRYING" ) );
    CHECK( who.activity.execution() == activity_execution::authoritative );
    who.activity.moves_left = 1;
    who.set_moves( 100 );
    const std::string finish = fixture.request( who, "step" );
    fixture.run( who, finish );
    CHECK( here.ter( target ) == ter_str_id( "t_dirt" ).id() );
    const auto count = here.i_at( target ).size();
    const auto rng_after = rng_get_engine();
    fixture.run( who, finish );
    CHECK( here.i_at( target ).size() == count );
    CHECK( rng_get_engine() == rng_after );
}
