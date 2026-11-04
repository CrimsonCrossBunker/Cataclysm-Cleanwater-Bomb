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
#include "bionics.h"
#include "bionic_activation.h"
#include "bionic_water_activity.h"
#include "cached_options.h"
#include "character_martial_arts.h"
#include "martial_style_selection.h"
#include "martialarts.h"
#include "field_type.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "craft_command.h"
#include "crafting.h"
#include "construction.h"
#include "bodypart.h"
#include "effect.h"
#include "explosion.h"
#include "magic.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "game_constants.h"
#include "clzones.h"
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
#include "faction.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_reload.h"
#include "item_uid.h"
#include "item_unload.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "line.h"
#include "map_iterator.h"
#include "mapdata.h"
#include "skill.h"
#include "temp_crafting_inventory.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_selector.h"
#include "messages.h"
#include "message_routing.h"
#include "mp_player_feedback.h"
#include "mp_test_helpers.h"
#include "viewer.h"
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
#include "vehicle_control.h"
#include "vehicle_electronics.h"
#include "level_cache.h"
#include "veh_utils.h"
#include "remote_vehicle_activity.h"
#include "vpart_range.h"
#include "veh_type.h"
#include "vpart_position.h"
#include "submap.h"
#include "weather.h"
#include "weather_gen.h"


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

namespace
{
unsigned int prepare_targeted_bionic( Character &who, const bionic_id &id )
{
    who.add_bionic( bionic_id( "bio_power_storage" ) );
    const unsigned int uid = who.add_bionic( id );
    who.set_max_power_level( 200_kJ );
    who.set_power_level( 200_kJ );
    who.set_moves( 100 );
    return uid;
}
void prepare_bionic_target( map &here, const tripoint_bub_ms &target, const bionic_id &id )
{
    if( id == bionic_id( "bio_lockpick" ) ) {
        here.ter_set( target, ter_str_id( "t_door_locked" ) );
    } else if( id == bionic_id( "bio_lighter" ) ) {
        here.add_item_or_charges( target, item( itype_id( "2x4" ) ) );
        REQUIRE( here.is_flammable( target ) );
    } else {
        here.furn_set( target, furn_str_id( "f_console" ) );
        REQUIRE( here.has_flag( ter_furn_flag::TFLAG_CONSOLE, target ) );
    }
}
std::string bionic_request( reload_fixture &fixture, Character &who, unsigned int uid,
                            const bionic_id &id, const tripoint_abs_ms &target )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", id );
        out.member( "target", target );
    } );
}
} // namespace

TEST_CASE( "targeted_bionics_execute_once_on_the_owning_player", "[mp_bionic]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    auto controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    avatar &host = get_avatar();
    map &here = get_map();
    host.setpos( here, tripoint_bub_ms( 65, 60, 0 ) );
    const bionic_id id( GENERATE( "bio_lockpick", "bio_lighter", "bio_emp" ) );
    CAPTURE( id.str() );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    prepare_targeted_bionic( host, id );
    const tripoint_bub_ms target = remote.pos_bub() + tripoint::east;
    prepare_bionic_target( here, target, id );
    const auto before = remote.get_power_level();
    const std::string wire = bionic_request( fixture, remote, uid, id, here.get_abs( target ) );
    fixture.run( remote, wire );
    CHECK( remote.get_power_level() == before - id->power_activate );
    CHECK( host.get_power_level() == before );
    const auto after_start = rng_get_engine();
    fixture.run( remote, wire );
    CHECK( rng_get_engine() == after_start );
    CHECK( remote.get_power_level() == before - id->power_activate );
    if( id == bionic_id( "bio_lockpick" ) ) {
        REQUIRE( remote.activity.id() == activity_id( "ACT_LOCKPICK" ) );
        save_reload_activity( remote );
        remote.set_moves( 100 );
        remote.activity.moves_left = 1;
        fixture.run( remote, fixture.request( remote, "step" ) );
        CHECK_FALSE( remote.activity );
        CHECK( here.ter( target ) == ter_str_id( "t_door_c" ).id() );
    } else if( id == bionic_id( "bio_lighter" ) ) {
        CHECK( here.get_field( target, fd_fire ) );
        CHECK( remote.get_moves() == 0 );
    } else {
        CHECK( here.furn( target ) == furn_str_id( "f_machinery_electronic" ).id() );
        CHECK( remote.get_moves() == 0 );
    }
}

TEST_CASE( "targeted_bionics_reject_invalid_intents_and_cancel_removed_implants", "[mp_bionic]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    map &here = get_map();
    const bionic_id id( "bio_lockpick" );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const tripoint_bub_ms target = remote.pos_bub() + tripoint::east;
    prepare_bionic_target( here, target, id );
    const std::string failure = GENERATE( "far", "power", "shorted", "wrong_uid", "wrong_type", "removed_after_load" );
    CAPTURE( failure );
    if( failure == "power" ) {
        remote.set_power_level( 0_kJ );
    } else if( failure == "shorted" ) {
        ( *remote.find_bionic_by_uid( uid ) )->incapacitated_time = 1_minutes;
    }
    const auto before_power = remote.get_power_level();
    const auto before_rng = rng_get_engine();
    fixture.run( remote, bionic_request( fixture, remote,
                                       failure == "wrong_uid" ? uid + 100 : uid,
                                       failure == "wrong_type" ? bionic_id( "bio_lighter" ) : id,
                                       here.get_abs( failure == "far" ? target + tripoint::east : target ) ) );
    if( failure == "removed_after_load" ) {
        REQUIRE( remote.activity );
        save_reload_activity( remote );
        remote.remove_bionic( **remote.find_bionic_by_uid( uid ) );
        // Another instance of the same type must not inherit the old work.
        const unsigned int replacement = remote.add_bionic( id );
        REQUIRE( replacement != uid );
        remote.set_moves( 100 );
        remote.activity.moves_left = 1;
        fixture.run( remote, fixture.request( remote, "step" ) );
    } else {
        CHECK( remote.get_power_level() == before_power );
        CHECK( rng_get_engine() == before_rng );
    }
    CHECK_FALSE( remote.activity );
    CHECK( here.ter( target ) == ter_str_id( "t_door_locked" ).id() );
}

TEST_CASE( "bionic_identity_is_not_recycled_after_character_restore", "[mp_bionic][bionics]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const bionic_id id( "bio_lockpick" );
    const unsigned int uid = prepare_targeted_bionic( who, id );
    who.remove_bionic( **who.find_bionic_by_uid( uid ) );
    const std::string mode = GENERATE( "save", "player_state", "turn_state" );
    CAPTURE( mode );
    std::ostringstream saved;
    JsonOut out( saved );
    if( mode == "save" ) {
        who.serialize( out );
    } else if( mode == "player_state" ) {
        who.store_player_state( out );
    } else {
        who.store_turn_state( out );
    }
    const JsonObject data = json_loader::from_string( saved.str() ).get_object();
    if( mode == "save" ) {
        npc restored;
        restored.deserialize( data );
        CHECK( restored.add_bionic( id ) > uid );
        return;
    } else if( mode == "player_state" ) {
        who.load_player_state( data );
    } else {
        who.load_turn_state( data );
    }
    CHECK( who.add_bionic( id ) > uid );
}

TEST_CASE( "bionic_menu_and_examine_only_queue_client_requests", "[mp_bionic]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const bionic_id id( "bio_lockpick" );
    const unsigned int uid = prepare_targeted_bionic( who, id );
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    prepare_bionic_target( here, target, id );
    const auto before_power = who.get_power_level();
    const auto before_rng = rng_get_engine();
    cata_mp::set_client_mode( true );
    SECTION( "native_menu_entry" ) {
        bool close_ui = false;
        const bionic_activation_choices choices{ here.get_abs( target ) };
        REQUIRE( who.activate_bionic( **who.find_bionic_by_uid( uid ), false, &close_ui, &choices ) );
        CHECK( close_ui );
    }
    SECTION( "examine_entry" ) {
        iexamine::locked_object_pickable( who, target );
    }
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK( who.activity.execution() == activity_execution::presentation );
    CHECK( who.get_power_level() == before_power );
    CHECK( rng_get_engine() == before_rng );
    CHECK( here.ter( target ) == ter_str_id( "t_door_locked" ).id() );
}

TEST_CASE( "bionic_emp_affects_the_character_at_the_target_tile", "[mp_bionic]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    map &here = get_map();
    host.setpos( here, remote.pos_bub() + tripoint::west );
    const bionic_id id( "bio_emp" );
    const unsigned int uid = prepare_targeted_bionic( host, id );
    prepare_targeted_bionic( remote, bionic_id( "bio_lockpick" ) );
    const auto host_power = host.get_power_level();
    const auto remote_power = remote.get_power_level();
    REQUIRE( execute_owned_bionic_action( host, uid, id, { remote.pos_abs() } ) );
    CHECK( host.get_power_level() == host_power - id->power_activate );
    CHECK( remote.get_power_level() < remote_power );
}

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
TEST_CASE( "bionic_native_hooks_keep_lua_state_on_the_acting_character", "[mp_bionic][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    reload_fixture fixture;
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::string mod = "owned_bionic_hook";
    const auto runtime = platform::make_runtime( mod, 4110, lua );
    const on_out_of_scope cleanup( []() { platform::shutdown(); } );
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );
    lua["ccb"] = ccb;
    npc &remote = fixture.remote();
    auto controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 65, 60, 0 ) );
    const bionic_id id( "bio_lockpick" );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const unsigned int host_uid = prepare_targeted_bionic( host, id );
    const bool remove_during_hook = GENERATE( false, true );
    lua.set_function( "mutate_native", [&]() {
        if( remove_during_hook ) {
            const auto bio = remote.find_bionic_by_uid( uid );
            if( bio ) {
                remote.remove_bionic( **bio );
            }
        }
    } );
    const auto registered = lua.safe_script( R"lua(
ccb.runtime.handler("activated", function(context)
    local state = ccb.state.character
    state.set("uses", state.get("uses", 0) + 1)
    mutate_native()
end)
ccb.runtime.hook("on_bionic_activated", "activated")
)lua", sol::script_pass_on_error );
    REQUIRE( registered.valid() );
    const auto uses = [&]( Character &who ) {
        const auto &values = who.lua_character_state.for_mod( mod );
        const auto found = values.find( "uses" );
        return found == values.end() ? int64_t( 0 ) : std::get<int64_t>( found->second );
    };
    const tripoint_bub_ms target = remote.pos_bub() + tripoint::east;
    prepare_bionic_target( get_map(), target, id );
    const std::string wire = bionic_request( fixture, remote, uid, id, get_map().get_abs( target ) );
    fixture.run( remote, wire );
    CHECK( uses( remote ) == 1 );
    CHECK( uses( host ) == 0 );
    CHECK( static_cast<bool>( remote.activity ) == !remove_during_hook );
    fixture.run( remote, wire );
    CHECK( uses( remote ) == 1 );
    const tripoint_bub_ms host_target = host.pos_bub() + tripoint::east;
    prepare_bionic_target( get_map(), host_target, id );
    REQUIRE( execute_owned_bionic_action( host, host_uid, id,
                                            { get_map().get_abs( host_target ) } ) );
    CHECK( uses( host ) == 1 );
    CHECK( uses( remote ) == 1 );
}
#endif


namespace
{
std::string bionic_switch_request( reload_fixture &fixture, Character &who, unsigned int uid,
                                  const bionic_id &id, bool enabled )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", enabled ? "bionic_activation" : "bionic_deactivation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", id );
    } );
}
} // namespace

TEST_CASE( "bionic_switches_set_only_the_owning_players_native_state", "[mp_bionic_switch]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    const bionic_id id( "bio_night_vision" );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const unsigned int host_uid = prepare_targeted_bionic( host, id );
    const auto host_power = host.get_power_level();
    const auto before = remote.get_power_level();
    const std::string start = bionic_switch_request( fixture, remote, uid, id, true );
    fixture.run( remote, start );
    CHECK( remote.has_active_bionic( id ) );
    CHECK( remote.has_flag( json_character_flag( "NIGHT_VISION" ) ) );
    CHECK_FALSE( host.has_active_bionic( id ) );
    CHECK( host.get_power_level() == host_power );
    CHECK( remote.get_power_level() == before - id->power_activate );
    const auto after_start = rng_get_engine();
    fixture.run( remote, start );
    CHECK( rng_get_engine() == after_start );
    CHECK( remote.get_power_level() == before - id->power_activate );

    const std::string stop = bionic_switch_request( fixture, remote, uid, id, false );
    const std::string result = fixture.run( remote, stop );
    CHECK_FALSE( remote.has_active_bionic( id ) );
    CHECK_FALSE( remote.has_flag( json_character_flag( "NIGHT_VISION" ) ) );
    CHECK( remote.get_power_level() == before - id->power_activate - id->power_deactivate );
    const auto after_stop = rng_get_engine();
    fixture.run( remote, stop );
    CHECK( rng_get_engine() == after_stop );
    CHECK( remote.get_power_level() == before - id->power_activate - id->power_deactivate );

    // The real reply updates the replica without rerunning native callbacks.
    const auto host_bionic = host.find_bionic_by_uid( host_uid );
    REQUIRE( host_bionic );
    REQUIRE( host.activate_bionic( **host_bionic ) );
    cata_mp::set_client_mode( true );
    player_activity activity{ invoke_item_activity_actor( item_location(), std::string() ) };
    activity.set_execution( activity_execution::presentation );
    host.assign_activity( activity );
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = fixture.sequence;
    const auto rng_before_reply = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( result ) );
    REQUIRE( cata_mp::client_apply_message( result ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( host.activity );
    CHECK_FALSE( host.has_active_bionic( id ) );
    CHECK_FALSE( host.has_flag( json_character_flag( "NIGHT_VISION" ) ) );
    CHECK( host.get_power_level() == remote.get_power_level() );
    CHECK( rng_get_engine() == rng_before_reply );
}

TEST_CASE( "bionic_switches_preserve_exclusion_and_native_periodic_effects", "[mp_bionic_switch]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    SECTION( "hearing_and_earplugs" ) {
        const bionic_id hearing( "bio_ears" );
        const unsigned int hearing_uid = prepare_targeted_bionic( remote, hearing );
        prepare_targeted_bionic( host, hearing );
        if( !host.has_active_bionic( hearing ) ) {
            REQUIRE( host.activate_bionic( **host.find_bionic_by_type( hearing ) ) );
        }
        const bionic_id plugs( "bio_earplugs" );
        const auto plug = remote.find_bionic_by_type( plugs );
        REQUIRE( plug );
        fixture.run( remote, bionic_switch_request( fixture, remote, ( *plug )->get_uid(), plugs, true ) );
        CHECK( remote.has_flag( json_character_flag( "DEAF" ) ) );
        CHECK_FALSE( remote.has_active_bionic( hearing ) );
        CHECK( host.has_active_bionic( hearing ) );
        fixture.run( remote, bionic_switch_request( fixture, remote, hearing_uid, hearing, true ) );
        CHECK_FALSE( remote.has_flag( json_character_flag( "DEAF" ) ) );
        CHECK( remote.has_active_bionic( hearing ) );
    }
    SECTION( "painkiller_tick" ) {
        const bionic_id id( "bio_painkiller" );
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        prepare_targeted_bionic( host, id );
        remote.set_pain( 100 );
        remote.set_painkiller( 0 );
        host.set_painkiller( 0 );
        fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
        REQUIRE( remote.has_active_bionic( id ) );
        const auto before_tick = remote.get_power_level();
        remote.process_bionic( **remote.find_bionic_by_uid( uid ) );
        CHECK( remote.get_painkiller() == 1 );
        CHECK( remote.get_power_level() == before_tick - id->power_trigger );
        CHECK( host.get_painkiller() == 0 );
    }
    SECTION( "retract_existing_weapon" ) {
        const bionic_id id( "bio_claws" );
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        REQUIRE( remote.activate_bionic( **remote.find_bionic_by_uid( uid ) ) );
        REQUIRE( remote.is_using_bionic_weapon() );
        host.set_wielded_item( item( itype_id( "hammer" ) ) );
        fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, false ) );
        CHECK_FALSE( remote.has_active_bionic( id ) );
        CHECK_FALSE( remote.is_using_bionic_weapon() );
        CHECK_FALSE( remote.get_wielded_item() );
        REQUIRE( host.get_wielded_item() );
        CHECK( host.get_wielded_item()->typeId() == itype_id( "hammer" ) );
    }
    SECTION( "evaporator_uses_its_owners_environment" ) {
        const bionic_id id( "bio_evap" );
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        const bool underwater = GENERATE( true, false );
        remote.set_underwater( underwater );
        host.set_underwater( !underwater );
        const restore_on_out_of_scope humidity( get_weather().weather_precise->humidity );
        get_weather().weather_precise->humidity = 80;
        fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
        CHECK( remote.has_active_bionic( id ) == !underwater );
    }
}

TEST_CASE( "bionic_switch_client_entries_do_not_toggle_the_replica", "[mp_bionic_switch]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    const bionic_id id( "bio_night_vision" );
    const unsigned int uid = prepare_targeted_bionic( who, id );
    const bool enabled = GENERATE( true, false );
    if( !enabled ) {
        REQUIRE( who.activate_bionic( **who.find_bionic_by_uid( uid ) ) );
    }
    const auto before_power = who.get_power_level();
    const auto before_rng = rng_get_engine();
    cata_mp::set_client_mode( true );
    if( enabled ) {
        bool close_ui = false;
        REQUIRE( who.activate_bionic( **who.find_bionic_by_uid( uid ), false, &close_ui ) );
        CHECK( close_ui );
    } else {
        REQUIRE( who.deactivate_bionic( **who.find_bionic_by_uid( uid ) ) );
    }
    CHECK( who.has_active_bionic( id ) == !enabled );
    CHECK( who.get_power_level() == before_power );
    CHECK( rng_get_engine() == before_rng );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
}

TEST_CASE( "bionic_switches_reject_unmigrated_choices_and_invalid_stops", "[mp_bionic_switch]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    SECTION( "unmigrated_choice" ) {
        const bionic_id id( "bio_remote" );
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        const auto power = remote.get_power_level();
        const auto rng = rng_get_engine();
        fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
        CHECK_FALSE( remote.has_active_bionic( id ) );
        CHECK( remote.get_power_level() == power );
        CHECK( rng_get_engine() == rng );
        avatar &who = get_avatar();
        const unsigned int local_uid = prepare_targeted_bionic( who, id );
        cata_mp::set_client_mode( true );
        CHECK_FALSE( who.activate_bionic( **who.find_bionic_by_uid( local_uid ) ) );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( who.has_active_bionic( id ) );
    }
    SECTION( "shorted_or_wrong_identity" ) {
        const bionic_id id( "bio_night_vision" );
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        REQUIRE( remote.activate_bionic( **remote.find_bionic_by_uid( uid ) ) );
        const bool shorted = GENERATE( true, false );
        if( shorted ) {
            ( *remote.find_bionic_by_uid( uid ) )->incapacitated_time = 1_minutes;
        }
        const auto power = remote.get_power_level();
        const auto rng = rng_get_engine();
        fixture.run( remote, bionic_switch_request( fixture, remote, shorted ? uid : uid + 100, id, false ) );
        CHECK( ( *remote.find_bionic_by_uid( uid ) )->powered );
        CHECK( remote.get_power_level() == power );
        CHECK( rng_get_engine() == rng );
    }
}


#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
TEST_CASE( "bionic_switch_hooks_retain_owned_activities_and_safe_deactivation", "[mp_bionic_switch][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    reload_fixture fixture;
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::string mod = "owned_bionic_switch";
    const auto runtime = platform::make_runtime( mod, 4111, lua );
    const on_out_of_scope cleanup( []() { platform::shutdown(); } );
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );
    lua["ccb"] = ccb;
    npc &remote = fixture.remote();
    auto controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    const bionic_id id( "bio_night_vision" );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const bool remove_on_stop = GENERATE( false, true );
    lua.set_function( "begin_native_work", [&]() {
        remote.assign_activity( player_activity( activity_id( "ACT_WAIT" ), 100 ) );
    } );
    lua.set_function( "stop_native", [&]() {
        if( remove_on_stop ) {
            const auto bio = remote.find_bionic_by_uid( uid );
            if( bio ) {
                remote.remove_bionic( **bio );
            }
        }
    } );
    const auto registered = lua.safe_script( R"lua(
ccb.runtime.handler("on", function(context)
    local state = ccb.state.character
    state.set("started", state.get("started", 0) + 1)
    begin_native_work()
end)
ccb.runtime.handler("off", function(context)
    local state = ccb.state.character
    state.set("stopped", state.get("stopped", 0) + 1)
    stop_native()
end)
ccb.runtime.hook("on_bionic_activated", "on")
ccb.runtime.hook("on_bionic_deactivated", "off")
)lua", sol::script_pass_on_error );
    REQUIRE( registered.valid() );
    const auto value = [&]( Character &who, const std::string &key ) {
        const auto &values = who.lua_character_state.for_mod( mod );
        const auto found = values.find( key );
        return found == values.end() ? int64_t( 0 ) : std::get<int64_t>( found->second );
    };
    const auto before = remote.get_power_level();
    fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
    CHECK( remote.get_power_level() == before - id->power_activate );
    CHECK( remote.has_active_bionic( id ) );
    REQUIRE( remote.activity.id() == activity_id( "ACT_WAIT" ) );
    CHECK( remote.activity.execution() == activity_execution::authoritative );
    CHECK( value( remote, "started" ) == 1 );
    CHECK( value( get_avatar(), "started" ) == 0 );
    remote.cancel_activity();
    remote.set_moves( 100 );
    const std::string stop = bionic_switch_request( fixture, remote, uid, id, false );
    fixture.run( remote, stop );
    CHECK_FALSE( remote.has_active_bionic( id ) );
    CHECK( remote.find_bionic_by_uid( uid ).has_value() == !remove_on_stop );
    CHECK( value( remote, "stopped" ) == 1 );
    CHECK( value( get_avatar(), "stopped" ) == 0 );
    fixture.run( remote, stop );
    CHECK( value( remote, "stopped" ) == 1 );
}
#endif

namespace
{
cata_mp::remote_player_session &bind_feedback_player( npc &actor, char id, uint64_t peer )
{
    auto &recipient = make_test_remote( g->multiplayer_session(), peer );
    recipient.connected = true;
    recipient.credentials.id = player_id( std::string( 32, id ) );
    actor.set_value( "mp_proxy", std::string( "1" ) );
    actor.set_value( "mp_player_id", recipient.credentials.id.str() );
    recipient.actor.bind_player( actor, recipient.credentials.id, g->npc_lifetimes(),
                                 g->player_controls().claim( recipient.credentials.id, actor ) );
    return recipient;
}
}

TEST_CASE( "native_player_feedback_keeps_private_and_observer_messages_separate", "[mp_feedback]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    auto &recipient = bind_feedback_player( remote, 'a', 701 );
    npc &other = spawn_npc( { 62, 60 }, "test_talker" );
    auto &other_recipient = bind_feedback_player( other, 'b', 702 );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 61, 60, 0 ) );
    get_map().build_map_cache( 0 );
    REQUIRE( get_player_view().sees( get_map(), remote ) );
    Messages::clear_messages();

    remote.add_msg_if_player( m_bad, "private owner failure" );
    REQUIRE( recipient.feedback.pending.size() == 1 );
    CHECK( recipient.feedback.pending.front().params.type == m_bad );
    CHECK( other_recipient.feedback.pending.empty() );
    CHECK( Messages::size() == 0 );
    remote.add_msg_player_or_npc( m_good, "owner success", "<npcname> succeeds" );
    REQUIRE( recipient.feedback.pending.size() == 2 );
    REQUIRE( Messages::size() == 1 );
    CHECK( Messages::recent_messages( 1 ).front().second.find( "succeeds" ) != std::string::npos );
    CHECK( Messages::recent_messages_for_player( 1, recipient.credentials.id ).empty() );
    CHECK( Messages::recent_messages_for_player( 1, other_recipient.credentials.id ).size() == 1 );
    remote.add_msg_player_or_say( m_warning, "owner instruction", "NPC-only speech" );
    CHECK( recipient.feedback.pending.back().text == "owner instruction" );
    CHECK( Messages::size() == 1 );

    // Same displayed text with a different audience must not coalesce.
    const auto observer = Messages::recent_messages( 1 ).front().second;
    Messages::add_msg( m_good, observer );
    CHECK( Messages::size() == 2 );
    CHECK( Messages::recent_messages_for_player( 2, recipient.credentials.id ).size() == 1 );
    Messages::add_observer_msg( m_good, observer, recipient.credentials.id );
    CHECK( Messages::recent_messages_for_player( 1, recipient.credentials.id ).empty() );

    // Tags and copied numeric IDs alone cannot route private messages.
    npc impostor;
    impostor.setID( remote.getID() );
    impostor.set_value( "mp_proxy", std::string( "1" ) );
    impostor.set_value( "mp_player_id", recipient.credentials.id.str() );
    const auto before = recipient.feedback.sequence;
    impostor.add_msg_if_player( "must not be delivered" );
    CHECK( recipient.feedback.sequence == before );
    recipient.admission.retire();
    remote.add_msg_if_player( "disconnected" );
    CHECK( recipient.feedback.sequence == before );
    CHECK( cata_mp::take_player_feedback( recipient ) == "[]" );
    CHECK( recipient.feedback.pending.empty() );
}

TEST_CASE( "native_feedback_survives_full_logs_and_replays_without_advancing_gameplay_rng", "[mp_feedback]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    auto &recipient = bind_feedback_player( remote, 'a', 701 );
    const override_option options( "MESSAGE_LIMIT", "20" );
    Messages::clear_messages();
    for( int i = 0; i < 40; ++i ) {
        Messages::add_msg( "host log " + std::to_string( i ) );
    }
    const size_t host_size = Messages::size();
    for( int i = 0; i < 140; ++i ) {
        remote.add_msg_if_player( game_message_params( m_bad, gmf_bypass_cooldown ), "owner repeated message" );
    }
    CHECK( Messages::size() == host_size );
    REQUIRE( recipient.feedback.pending.size() == cata_mp::player_feedback_queue::max_pending );
    CHECK( recipient.feedback.pending.front().sequence == 13 );
    CHECK( recipient.feedback.pending.back().sequence == 140 );
    remote.add_msg_if_player( std::string( 8191, 'x' ) + "汽油" );
    CHECK( recipient.feedback.pending.back().text == std::string( 8191, 'x' ) );
    const std::string wire = "{\"player_feedback\":" + cata_mp::take_player_feedback( recipient ) + "}";
    CHECK( recipient.feedback.pending.empty() );
    const JsonValue value = json_loader::from_string( wire );
    const JsonObject data = value.get_object();
    get_avatar().add_effect( efftype_id( "weed_high" ), 3_hours );
    const auto rng_before = rng_get_engine();
    cata_mp::apply_player_feedback( data );
    CHECK( rng_get_engine() == rng_before );
    CHECK( g->multiplayer_session().client_feedback_sequence == 141 );
    CHECK( g->multiplayer_session().client_turn.client_msg_watermark == Messages::size() );
    const auto first = Messages::recent_messages( Messages::size() );
    cata_mp::apply_player_feedback( data );
    CHECK( Messages::recent_messages( Messages::size() ) == first );
    CHECK( rng_get_engine() == rng_before );

    g->multiplayer_session().reset();
    CHECK( g->multiplayer_session().client_feedback_sequence == 0 );
    cata_mp::apply_player_feedback( data );
    CHECK( g->multiplayer_session().client_feedback_sequence == 141 );
}

TEST_CASE( "informational_bionics_report_the_owning_body_without_host_input", "[mp_feedback]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    auto &recipient = bind_feedback_player( remote, 'a', 701 );
    const bionic_id id( GENERATE( "bio_geiger", "bio_blood_anal", "bio_meteorologist" ) );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    remote.set_rad( 53 );
    get_avatar().set_rad( 11 );
    remote.add_effect( efftype_id( "poison" ), 1_hours );
    const auto power = remote.get_power_level();
    const std::string request = bionic_switch_request( fixture, remote, uid, id, true );
    Messages::clear_messages();
    fixture.run( remote, request );
    REQUIRE_FALSE( recipient.feedback.pending.empty() );
    CHECK( remote.get_power_level() == power - id->power_activate );
    const int64_t sequence = recipient.feedback.sequence;
    fixture.run( remote, request );
    CHECK( recipient.feedback.sequence == sequence );
    std::string report;
    for( const auto &entry : recipient.feedback.pending ) {
        report += entry.text + "\n";
    }
    if( id == bionic_id( "bio_geiger" ) ) {
        CHECK( report.find( "53" ) != std::string::npos );
        CHECK( report.find( "11" ) == std::string::npos );
    } else if( id == bionic_id( "bio_blood_anal" ) ) {
        CHECK( report.find( "Blood Test Results" ) != std::string::npos );
        CHECK( report.find( "Poison" ) != std::string::npos );
    } else {
        CHECK( report.find( "Temperature:" ) != std::string::npos );
        CHECK( report.find( "Relative Humidity:" ) != std::string::npos );
        CHECK( report.find( "Wind Direction:" ) != std::string::npos );
    }
    const std::string last_line = recipient.feedback.pending.back().text;
    // The actual state producer includes the private channel, then drains it.
    const std::string state = cata_mp::serialize_remote_player_state( recipient );
    const JsonValue state_value = json_loader::from_string( state );
    const JsonObject data = state_value.get_object();
    data.allow_omitted_members();
    REQUIRE( data.has_array( "player_feedback" ) );
    CHECK_FALSE( data.get_array( "player_feedback" ).empty() );
    CHECK( recipient.feedback.pending.empty() );
    Messages::clear_messages();
    cata_mp::apply_player_feedback( data );
    const auto displayed = Messages::recent_messages( Messages::size() );
    REQUIRE_FALSE( displayed.empty() );
    CHECK( displayed.back().second == last_line );
}

namespace
{
std::string martial_choice_request( reload_fixture &fixture, Character &who,
                                   const martial_style_choice &choice )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "martial_style" );
        out.member( "martial_style", choice );
    } );
}

std::string cqb_choice_request( reload_fixture &fixture, Character &who, unsigned int uid,
                               const martial_style_choice &choice )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", "bio_cqb" );
        out.member( "martial_style", choice );
    } );
}
}

TEST_CASE( "martial_style_choices_apply_native_effects_only_to_the_owner", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    avatar &host = get_avatar();
    const matype_id karate( "style_karate" );
    const matype_id none( "style_none" );
    const martial_style_choice choice{ martial_style_action::select, karate };
    remote.martial_arts_data->add_martialart( karate );
    REQUIRE_FALSE( karate->static_buffs.empty() );
    const efftype_id stance = karate->static_buffs.front()->get_effect_id();
    const int moves = remote.get_moves();
    const std::string request = martial_choice_request( fixture, remote, choice );
    const std::string result = fixture.run( remote, request );
    CHECK( remote.martial_arts_data->selected_style() == karate );
    CHECK( remote.has_effect( stance ) );
    CHECK( remote.get_moves() == moves );
    CHECK( host.martial_arts_data->selected_style() == none );
    CHECK_FALSE( host.has_effect( stance ) );
    const auto rng = rng_get_engine();
    fixture.run( remote, request );
    CHECK( rng_get_engine() == rng );

    host.martial_arts_data->add_martialart( karate );
    host.set_moves( 100 );
    cata_mp::set_client_mode( true );
    REQUIRE( cata_mp::client_select_martial_style( choice ) );
    CHECK( host.martial_arts_data->selected_style() == none );
    CHECK_FALSE( host.has_effect( stance ) );
    CHECK( host.activity.execution() == activity_execution::presentation );
    g->multiplayer_session().client_inventory_activity.pending_request = fixture.sequence;
    const auto before_apply = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( result ) );
    REQUIRE( cata_mp::client_apply_message( result ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK( host.martial_arts_data->selected_style() == karate );
    CHECK( host.has_effect( stance ) );
    CHECK( rng_get_engine() == before_apply );
    CHECK_FALSE( host.activity );
}

TEST_CASE( "martial_preferences_are_owned_replay_safe_and_survive_save", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    auto controller = g->player_controls().claim( player_id( std::string( 32, 'a' ) ), remote );
    auto &arts = *remote.martial_arts_data;
    const matype_id style( "test_style_ma1" );
    const matype_id none( "style_none" );
    arts.add_martialart( style );
    remote.set_wielded_item( item( itype_id( "test_weapon1" ) ) );
    REQUIRE( style->weapon_valid( remote.get_wielded_item() ) );
    const martial_style_choice automatic{ martial_style_action::toggle_auto, matype_id() };
    const std::string auto_request = martial_choice_request( fixture, remote, automatic );
    fixture.run( remote, auto_request );
    fixture.run( remote, auto_request );
    CHECK( arts.auto_style );
    CHECK( arts.selected_style() == style );
    fixture.run( remote, martial_choice_request( fixture, remote,
                 { martial_style_action::select, none } ) );
    CHECK( arts.selected_style() == none );
    const std::string hands = martial_choice_request( fixture, remote,
                              { martial_style_action::toggle_hands_free, matype_id() } );
    fixture.run( remote, hands );
    fixture.run( remote, hands );
    CHECK( arts.keep_hands_free );
    CHECK_FALSE( get_avatar().martial_arts_data->auto_style );
    CHECK_FALSE( get_avatar().martial_arts_data->keep_hands_free );

    std::ostringstream saved;
    JsonOut out( saved );
    remote.serialize( out );
    npc restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    REQUIRE( restored.martial_arts_data->auto_style );
    REQUIRE( restored.martial_arts_data->keep_hands_free );
    restored.set_wielded_item( item( itype_id( "test_weapon2" ) ) );
    CHECK( restored.martial_arts_data->selected_style() == style );
    restored.set_wielded_item( item( itype_id( "test_weapon1" ) ) );
    CHECK( restored.martial_arts_data->selected_style() == none );
}

TEST_CASE( "cqb_choice_uses_installed_styles_and_preserves_native_cancellation_cost", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    auto controller = g->player_controls().claim( player_id( std::string( 32, 'a' ) ), remote );
    const bionic_id id( "bio_cqb" );
    const matype_id karate( "style_karate" );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const auto before = remote.get_power_level();
    const auto styles = available_martial_styles( remote, uid );
    REQUIRE( std::find( styles.begin(), styles.end(), karate ) != styles.end() );
    CHECK_FALSE( remote.has_active_bionic( id ) );
    CHECK_FALSE( remote.martial_arts_data->has_martialart( karate ) );
    CHECK( remote.get_power_level() == before );
    const martial_style_action action = GENERATE( martial_style_action::select,
                                        martial_style_action::cancel, martial_style_action::toggle_hands_free );
    const martial_style_choice choice{ action, action == martial_style_action::select ? karate : matype_id() };
    const std::string request = cqb_choice_request( fixture, remote, uid, choice );
    const std::string result = fixture.run( remote, request );
    CHECK( remote.has_active_bionic( id ) == ( action != martial_style_action::cancel ) );
    CHECK( remote.get_power_level() == before - id->power_activate );
    CHECK_FALSE( remote.martial_arts_data->has_martialart( karate ) );
    if( action == martial_style_action::select ) {
        CHECK( remote.martial_arts_data->selected_style() == karate );
        CHECK( remote.has_effect( karate->static_buffs.front()->get_effect_id() ) );
    } else if( action == martial_style_action::toggle_hands_free ) {
        CHECK( remote.martial_arts_data->keep_hands_free );
    }
    const auto after = rng_get_engine();
    fixture.run( remote, request );
    CHECK( remote.get_power_level() == before - id->power_activate );
    CHECK( rng_get_engine() == after );

    avatar &host = get_avatar();
    const unsigned int local_uid = prepare_targeted_bionic( host, id );
    const auto local_power = host.get_power_level();
    bionic_activation_choices input;
    input.martial_style = choice;
    cata_mp::set_client_mode( true );
    REQUIRE( host.activate_bionic( **host.find_bionic_by_uid( local_uid ), false, nullptr, &input ) );
    CHECK_FALSE( host.has_active_bionic( id ) );
    CHECK( host.get_power_level() == local_power );
    CHECK_FALSE( host.martial_arts_data->keep_hands_free );
    g->multiplayer_session().client_inventory_activity.pending_request = fixture.sequence;
    REQUIRE( cata_mp::client_apply_message( result ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK( host.has_active_bionic( id ) == remote.has_active_bionic( id ) );
    CHECK( host.get_power_level() == remote.get_power_level() );
    CHECK( host.martial_arts_data->selected_style() == remote.martial_arts_data->selected_style() );
    CHECK( host.martial_arts_data->keep_hands_free == remote.martial_arts_data->keep_hands_free );
}

TEST_CASE( "martial_and_cqb_choices_reject_unavailable_or_wrong_action_data", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    const matype_id karate( "style_karate" );
    const matype_id none( "style_none" );
    const martial_style_choice choose{ martial_style_action::select, karate };
    fixture.run( remote, martial_choice_request( fixture, remote, choose ) );
    CHECK( remote.martial_arts_data->selected_style() == none );
    remote.martial_arts_data->add_martialart( karate );
    fixture.run( remote, martial_choice_request( fixture, remote, choose ), false );
    CHECK( remote.martial_arts_data->selected_style() == none );
    fixture.run( remote, martial_choice_request( fixture, remote,
                 { martial_style_action::toggle_hands_free, karate } ) );
    CHECK_FALSE( remote.martial_arts_data->keep_hands_free );
    const bionic_id id( "bio_cqb" );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const auto power = remote.get_power_level();
    fixture.run( remote, cqb_choice_request( fixture, remote, uid,
                 { martial_style_action::select, matype_id( "not_a_real_style" ) } ) );
    CHECK_FALSE( remote.has_active_bionic( id ) );
    CHECK( remote.get_power_level() == power );
    bionic_activation_choices extra;
    extra.martial_style = choose;
    const bionic_id ordinary( "bio_night_vision" );
    const unsigned int ordinary_uid = prepare_targeted_bionic( remote, ordinary );
    CHECK_FALSE( execute_owned_bionic_action( remote, ordinary_uid, ordinary, extra ) );
    CHECK_FALSE( execute_owned_bionic_action( remote, uid, id, extra, bionic_action::deactivate ) );
}

TEST_CASE( "martial_turn_projection_rejects_unknown_styles_without_partial_changes", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    remote.martial_arts_data->add_martialart( matype_id( "style_karate" ) );
    std::ostringstream stream;
    JsonOut out( stream );
    remote.store_turn_state( out );
    std::string invalid = stream.str();
    const size_t position = invalid.find( "style_karate" );
    REQUIRE( position != std::string::npos );
    invalid.replace( position, std::string( "style_karate" ).size(), "nonexistent_martial_style" );
    avatar &host = get_avatar();
    const matype_id judo( "style_judo" );
    host.martial_arts_data->add_martialart( judo );
    host.martial_arts_data->set_style( judo );
    host.set_rad( 73 );
    const auto rng = rng_get_engine();
    const JsonValue value = json_loader::from_string( invalid );
    REQUIRE_THROWS_AS( host.load_turn_state( value.get_object() ), JsonError );
    CHECK( host.martial_arts_data->selected_style() == judo );
    CHECK( host.get_rad() == 73 );
    CHECK( rng_get_engine() == rng );
}

TEST_CASE( "world_bionics_spare_the_activator_and_project_affected_players", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    npc &other = spawn_npc( { 60, 62 }, "test_talker" );
    clear_character( other, true );
    auto &observer = bind_feedback_player( other, 'b', 702 );
    const bionic_id id( GENERATE( "bio_flashbang", "bio_shockwave" ) );
    const bool local = GENERATE( false, true );
    CAPTURE( id, local );
    const tripoint_bub_ms origin( 60, 60, 0 );
    host.setpos( here, local ? origin : origin + tripoint( 2, 0, 0 ) );
    remote.setpos( here, local ? origin + tripoint( 2, 0, 0 ) : origin );
    other.setpos( here, origin + tripoint( 0, 2, 0 ) );
    Character &activator = local ? static_cast<Character &>( host ) : remote;
    Character &bystander = local ? static_cast<Character &>( remote ) : host;
    const unsigned int uid = prepare_targeted_bionic( activator, id );
    activator.set_max_power_level( 500_kJ );
    activator.set_power_level( 500_kJ );
    here.build_map_cache( 0 );
    const tripoint_abs_ms other_before = other.pos_abs();
    const tripoint_abs_ms bystander_before = bystander.pos_abs();
    const std::string request = bionic_switch_request( fixture, remote, uid, id, true );
    if( local ) {
        REQUIRE( activator.activate_bionic( **activator.find_bionic_by_uid( uid ) ) );
    } else {
        fixture.run( remote, request );
        CHECK( fixture.reload.refresh_observers );
    }
    CHECK( activator.get_power_level() == 500_kJ - id->power_activate );
    CHECK( activator.get_moves() == 0 );
    CHECK( activator.pos_bub() == origin );
    CHECK_FALSE( activator.has_effect( efftype_id( "deaf" ) ) );
    CHECK_FALSE( activator.has_effect( efftype_id( "blind" ) ) );
    CHECK_FALSE( activator.has_effect( efftype_id( "stunned" ) ) );
    const efftype_id affected( id == bionic_id( "bio_flashbang" ) ? "deaf" : "stunned" );
    CHECK( bystander.has_effect( affected ) );
    CHECK( other.has_effect( affected ) );
    if( id == bionic_id( "bio_shockwave" ) ) {
        CHECK( other.pos_abs() != other_before );
        CHECK( bystander.pos_abs() != bystander_before );
    }
    if( !local ) {
        const auto after_rng = rng_get_engine();
        const auto after_pos = other.pos_abs();
        fixture.run( remote, request );
        CHECK_FALSE( fixture.reload.refresh_observers );
        CHECK( remote.get_power_level() == 500_kJ - id->power_activate );
        CHECK( other.pos_abs() == after_pos );
        CHECK( rng_get_engine() == after_rng );
    }

    // The same per-recipient producer used by observer delivery carries both
    // knockback coordinates and body effects. Loading its body is effect-free.
    const std::string state = cata_mp::serialize_remote_player_state( observer );
    const JsonValue encoded = json_loader::from_string( state );
    const JsonObject data = encoded.get_object();
    data.allow_omitted_members();
    const JsonObject position = data.get_object( "pos" );
    CHECK( position.get_int( "x" ) == other.pos_abs().x() );
    CHECK( position.get_int( "y" ) == other.pos_abs().y() );
    CHECK( position.get_int( "z" ) == other.pos_abs().z() );
    host.clear_effects();
    CHECK_FALSE( host.has_effect( affected ) );
    const auto before_apply = rng_get_engine();
    host.load_turn_state( data.get_object( "character_turn" ) );
    CHECK( host.has_effect( affected ) );
    CHECK( rng_get_engine() == before_apply );
}

TEST_CASE( "client_world_bionics_do_not_execute_area_effects_locally", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    avatar &host = get_avatar();
    npc &other = fixture.remote();
    host.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    const bionic_id id( GENERATE( "bio_flashbang", "bio_shockwave", "bio_resonator", "bio_magnet" ) );
    const unsigned int uid = prepare_targeted_bionic( host, id );
    host.set_max_power_level( 500_kJ );
    host.set_power_level( 500_kJ );
    const auto position = other.pos_abs();
    const auto rng = rng_get_engine();
    cata_mp::set_client_mode( true );
    REQUIRE( host.activate_bionic( **host.find_bionic_by_uid( uid ) ) );
    CHECK( g->multiplayer_session().client_inventory_activity.active );
    CHECK( host.activity.execution() == activity_execution::presentation );
    CHECK( host.get_power_level() == 500_kJ );
    CHECK( other.pos_abs() == position );
    CHECK_FALSE( other.has_effect( efftype_id( "deaf" ) ) );
    CHECK_FALSE( other.has_effect( efftype_id( "stunned" ) ) );
    CHECK( rng_get_engine() == rng );
}

TEST_CASE( "world_bionic_requests_require_ownership_and_native_power", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    const bionic_id id( GENERATE( "bio_flashbang", "bio_shockwave", "bio_resonator", "bio_magnet" ) );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const std::string failure = GENERATE( "unauthorized", "power", "wrong_uid" );
    CAPTURE( id, failure );
    remote.set_max_power_level( 500_kJ );
    remote.set_power_level( failure == "power" ? 0_kJ : 500_kJ );
    const auto power = remote.get_power_level();
    const auto position = host.pos_abs();
    const auto rng = rng_get_engine();
    fixture.run( remote, bionic_switch_request( fixture, remote,
                 failure == "wrong_uid" ? uid + 10 : uid, id, true ), failure != "unauthorized" );
    CHECK( remote.get_power_level() == power );
    CHECK( remote.get_moves() == 100 );
    CHECK( host.pos_abs() == position );
    CHECK_FALSE( host.has_effect( efftype_id( "deaf" ) ) );
    CHECK_FALSE( host.has_effect( efftype_id( "stunned" ) ) );
    CHECK( rng_get_engine() == rng );
    if( failure == "unauthorized" ) {
        CHECK_FALSE( fixture.reload.refresh_observers );
    }
}

TEST_CASE( "remote_player_bracing_protects_from_shockwave_like_local_bracing", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    const trait_id brace( "LEG_TENT_BRACE" );
    remote.set_mutation( brace );
    host.set_mutation( brace );
    REQUIRE( remote.is_barefoot() );
    REQUIRE( host.is_barefoot() );
    const auto host_position = host.pos_abs();
    const auto remote_position = remote.pos_abs();
    explosion_handler::shockwave( tripoint_bub_ms( 61, 60, 0 ), 3, 4, 2, 8 );
    CHECK( host.pos_abs() == host_position );
    CHECK( remote.pos_abs() == remote_position );
    CHECK_FALSE( host.has_effect( efftype_id( "stunned" ) ) );
    CHECK_FALSE( remote.has_effect( efftype_id( "stunned" ) ) );
}

namespace
{
void add_magnet_test_item( map &here, const tripoint_bub_ms &position )
{
    item pipe( itype_id( "pipe" ) );
    pipe.set_var( "ccb_magnet_test", 1 );
    here.add_item( position, std::move( pipe ) );
}

int count_magnet_test_items( map &here, const tripoint_bub_ms &origin )
{
    int count = 0;
    for( const tripoint_bub_ms &p : here.points_in_radius( origin, 12 ) ) {
        for( const item &entry : here.i_at( p ) ) {
            if( entry.has_var( "ccb_magnet_test" ) ) {
                count += entry.count();
            }
        }
    }
    return count;
}
}

TEST_CASE( "owned_resonator_changes_terrain_once_and_projects_the_delta", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    npc &other = spawn_npc( { 64, 62 }, "test_talker" );
    auto &observer = bind_feedback_player( other, 'b', 702 );
    const bool local = GENERATE( false, true );
    const tripoint_bub_ms origin( 60, 60, 0 );
    host.setpos( here, local ? origin : tripoint_bub_ms( 30, 30, 0 ) );
    remote.setpos( here, local ? tripoint_bub_ms( 30, 30, 0 ) : origin );
    Character &activator = local ? static_cast<Character &>( host ) : remote;
    const bionic_id id( "bio_resonator" );
    const unsigned int uid = prepare_targeted_bionic( activator, id );
    const tripoint_bub_ms door = origin + tripoint::east;
    here.ter_set( door, ter_str_id( "t_door_c" ) );
    const tripoint_abs_ms absolute = here.get_abs( door );
    cata_mp::serialize_remote_player_state( observer );
    std::string request;
    if( local ) {
        REQUIRE( activator.activate_bionic( **activator.find_bionic_by_uid( uid ) ) );
    } else {
        request = bionic_switch_request( fixture, remote, uid, id, true );
        fixture.run( remote, request );
        CHECK( fixture.reload.refresh_observers );
    }
    CHECK( activator.get_power_level() == 200_kJ - id->power_activate );
    CHECK( activator.get_moves() == 0 );
    CHECK( here.ter( door ) != ter_str_id( "t_door_c" ).id() );
    CHECK( here.passable( door ) );
    const ter_id destroyed = here.ter( door );
    if( !local ) {
        const auto rng = rng_get_engine();
        fixture.run( remote, request );
        CHECK_FALSE( fixture.reload.refresh_observers );
        CHECK( activator.get_power_level() == 200_kJ - id->power_activate );
        CHECK( here.ter( door ) == destroyed );
        CHECK( rng_get_engine() == rng );
    }
    const JsonValue state = json_loader::from_string( cata_mp::serialize_remote_player_state( observer ) );
    const JsonObject data = state.get_object();
    data.allow_omitted_members();
    bool found = false;
    for( const JsonValue &entry : data.get_array( "tile_changes" ) ) {
        const JsonObject tile = entry.get_object();
        tile.allow_omitted_members();
        if( tile.get_int( "x" ) == absolute.x() && tile.get_int( "y" ) == absolute.y() &&
            tile.get_int( "z" ) == absolute.z() ) {
            found = true;
            CHECK( tile.get_string( "ter" ) == destroyed.id().str() );
        }
    }
    CHECK( found );
}

TEST_CASE( "owned_magnet_preserves_item_counts_and_projects_source_and_landing", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATION_PROJECTILES", "false" );
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    npc &other = spawn_npc( { 64, 65 }, "test_talker" );
    auto &observer = bind_feedback_player( other, 'b', 702 );
    const bool local = GENERATE( false, true );
    const tripoint_bub_ms origin( 60, 60, 0 );
    host.setpos( here, local ? origin : tripoint_bub_ms( 30, 30, 0 ) );
    remote.setpos( here, local ? tripoint_bub_ms( 30, 30, 0 ) : origin );
    Character &activator = local ? static_cast<Character &>( host ) : remote;
    const bionic_id id( "bio_magnet" );
    const unsigned int uid = prepare_targeted_bionic( activator, id );
    const tripoint_bub_ms source = origin + tripoint( 4, 0, 0 );
    const tripoint_bub_ms landing = origin + tripoint::east;
    const tripoint_bub_ms sealed = origin + tripoint( 0, 4, 0 );
    const tripoint_bub_ms distant = origin + tripoint( 12, 0, 0 );
    here.furn_set( sealed, furn_str_id( "f_crate_c" ) );
    REQUIRE( here.has_flag( ter_furn_flag::TFLAG_SEALED, sealed ) );
    for( const auto &p : { source, source, sealed, distant, origin } ) {
        add_magnet_test_item( here, p );
    }
    const tripoint_bub_ms nonmetal = origin + tripoint( 4, 2, 0 );
    here.add_item( nonmetal, item( itype_id( "rock" ) ) );
    activator.set_wielded_item( item( itype_id( "pipe" ) ) );
    const int64_t wielded_uid = activator.get_wielded_item()->uid().get_value();
    REQUIRE( count_magnet_test_items( here, origin ) == 5 );
    cata_mp::serialize_remote_player_state( observer );
    std::string request;
    if( local ) {
        REQUIRE( activator.activate_bionic( **activator.find_bionic_by_uid( uid ) ) );
    } else {
        request = bionic_switch_request( fixture, remote, uid, id, true );
        fixture.run( remote, request );
        CHECK( fixture.reload.refresh_observers );
    }
    CHECK( activator.get_power_level() == 200_kJ - id->power_activate );
    CHECK( activator.get_moves() == 0 );
    CHECK( activator.get_wielded_item()->uid().get_value() == wielded_uid );
    CHECK( count_magnet_test_items( here, origin ) == 5 );
    for( const auto &p : { source, landing, sealed, distant, origin, nonmetal } ) {
        CHECK( here.i_at( p ).size() == 1 );
    }
    if( !local ) {
        const auto rng = rng_get_engine();
        fixture.run( remote, request );
        CHECK_FALSE( fixture.reload.refresh_observers );
        CHECK( activator.get_power_level() == 200_kJ - id->power_activate );
        CHECK( here.i_at( source ).size() == 1 );
        CHECK( here.i_at( landing ).size() == 1 );
        CHECK( count_magnet_test_items( here, origin ) == 5 );
        CHECK( rng_get_engine() == rng );
    }
    const JsonValue state = json_loader::from_string( cata_mp::serialize_remote_player_state( observer ) );
    const JsonObject data = state.get_object();
    data.allow_omitted_members();
    int found = 0;
    for( const JsonValue &entry : data.get_array( "tile_changes" ) ) {
        const JsonObject tile = entry.get_object();
        tile.allow_omitted_members();
        for( const auto &p : { source, landing } ) {
            const tripoint_abs_ms absolute = here.get_abs( p );
            if( tile.get_int( "x" ) == absolute.x() && tile.get_int( "y" ) == absolute.y() &&
                tile.get_int( "z" ) == absolute.z() ) {
                ++found;
                CHECK( tile.get_array( "items" ).size() == 1 );
            }
        }
    }
    CHECK( found == 2 );
}

TEST_CASE( "magnetic_attraction_restores_unlaunched_items_when_a_hit_retires_the_operator",
           "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATION_PROJECTILES", "false" );
    map &here = get_map();
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    avatar &victim = get_avatar();
    victim.setpos( here, tripoint_bub_ms( 58, 60, 0 ) );
    victim.set_dodges_left( 0 );
    victim.set_free_dodges_left( 0 );
    victim.set_mutation( trait_id( "HUGE" ) );
    const bionic_id id( "bio_magnet" );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const tripoint_bub_ms origin = remote.pos_bub();
    for( int x = 52; x <= 56; ++x ) {
        add_magnet_test_item( here, tripoint_bub_ms( x, 60, 0 ) );
    }
    REQUIRE( count_magnet_test_items( here, origin ) == 5 );
    class retire_on_damage : public event_subscriber
    {
        public:
            character_id source;
            character_id target;
            bool retired = false;
            retire_on_damage( character_id source, character_id target ) : source( source ), target( target ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( !retired && event.type() == event_type::character_takes_damage &&
                    event.get<character_id>( "character" ) == target && event.get<int>( "damage" ) > 0 ) {
                    retired = true;
                    g->remove_npc( source );
                }
            }
    } events( remote.getID(), victim.getID() );
    fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
    REQUIRE( events.retired );
    CHECK( fixture.reload.refresh_observers );
    CHECK( count_magnet_test_items( here, origin ) == 5 );
    int returned = 0;
    for( int x = 52; x <= 56; ++x ) {
        returned += here.i_at( tripoint_bub_ms( x, 60, 0 ) ).size();
    }
    CHECK( returned > 0 );
    CHECK( returned < 5 );
}
namespace
{
item_location extraction_corpse( Character &who, int charges )
{
    item corpse = item::make_corpse( mtype_id( "mon_zombie" ), calendar::turn );
    corpse.set_var( "remaining_water", charges );
    corpse.set_item_temperature( units::from_celsius( 20 ) );
    return get_map().add_item_or_charges_ret_loc( who.pos_bub(), corpse );
}

std::string water_start_request( reload_fixture &fixture, Character &who, unsigned int uid,
                                const item_source &corpse )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", bionic_id( "bio_water_extractor" ) );
        out.member( "water_corpse", corpse );
    } );
}

std::string water_choice_request( reload_fixture &fixture, Character &who,
                                 const unload_liquid_choice &choice )
{
    return fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "liquid", choice );
        out.member( "allow_consequences", true );
    } );
}
} // namespace

TEST_CASE( "water_extraction_keeps_one_activation_across_containers_and_save", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    avatar &host = get_avatar();
    const auto uid = prepare_targeted_bionic( who, bionic_id( "bio_water_extractor" ) );
    prepare_targeted_bionic( host, bionic_id( "bio_water_extractor" ) );
    host.set_moves( 517 );
    const auto corpse = extraction_corpse( who, 7 );
    const auto source = capture_item_source( who, corpse );
    const auto start = water_start_request( fixture, who, uid, source );
    fixture.run( who, start );
    REQUIRE( who.activity.id() == activity_id( "ACT_BIONIC_WATER" ) );
    CHECK( who.get_power_level() == 180_kJ );
    fixture.run( who, start );
    CHECK( who.get_power_level() == 180_kJ );
    save_reload_activity( who );
    who.process_activity();
    CHECK( who.get_moves() == 0 );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 7 );
    who.set_moves( 100 );

    who.set_wielded_item( item( itype_id( "bottle_plastic" ) ) );
    item_location bottle = who.get_wielded_item();
    item water( itype_id( "water_clean" ), calendar::turn, 7 );
    const int capacity = bottle->get_remaining_capacity_for_liquid( water, true );
    REQUIRE( capacity > 0 );
    REQUIRE( capacity < 7 );
    unload_liquid_choice choice;
    choice.source = corpse->uid().get_value();
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, bottle );
    const auto pour = water_choice_request( fixture, who, choice );
    fixture.run( who, pour );
    CHECK( fixture.reload.refresh_observers );
    REQUIRE_FALSE( bottle->is_container_empty() );
    CHECK( bottle->legacy_front().charges == capacity );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 7 - capacity );
    CHECK( who.get_moves() == 0 );
    CHECK( who.get_power_level() == 180_kJ );
    const auto rng = rng_get_engine();
    fixture.run( who, pour );
    CHECK_FALSE( fixture.reload.refresh_observers );
    CHECK( rng_get_engine() == rng );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 7 - capacity );
    save_reload_activity( who );

    const auto landing = who.pos_bub() + tripoint::east;
    choice.kind = LD_GROUND;
    choice.position = get_map().get_abs( landing );
    who.set_moves( 100 );
    fixture.run( who, water_choice_request( fixture, who, choice ) );
    CHECK_FALSE( who.activity );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 0 );
    int spilled = 0;
    for( const item &entry : get_map().i_at( landing ) ) {
        if( entry.typeId() == itype_id( "water_clean" ) ) {
            spilled += entry.charges;
        }
    }
    CHECK( spilled == 7 - capacity );
    CHECK( who.get_power_level() == 180_kJ );
    CHECK( host.get_power_level() == 200_kJ );
    CHECK( host.get_moves() == 517 );
    CHECK_FALSE( host.activity );
}

TEST_CASE( "water_extraction_cancel_refunds_only_unused_activation", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const auto uid = prepare_targeted_bionic( who, bionic_id( "bio_water_extractor" ) );
    const auto corpse = extraction_corpse( who, 4 );
    fixture.run( who, water_start_request( fixture, who, uid, capture_item_source( who, corpse ) ) );
    const bool extracted = GENERATE( false, true );
    if( extracted ) {
        who.set_wielded_item( item( itype_id( "bottle_plastic" ) ) );
        unload_liquid_choice choice;
        choice.source = corpse->uid().get_value();
        choice.kind = LD_ITEM;
        choice.container = capture_item_source( who, who.get_wielded_item() );
        fixture.run( who, water_choice_request( fixture, who, choice ) );
        REQUIRE( corpse->get_var( "remaining_water", -1 ) < 4 );
    }
    REQUIRE( who.activity );
    save_reload_activity( who );
    const auto cancel = fixture.request( who, "cancel" );
    fixture.run( who, cancel );
    fixture.run( who, cancel );
    CHECK_FALSE( who.activity );
    CHECK( who.get_power_level() == ( extracted ? 180_kJ : 200_kJ ) );
    if( !extracted ) {
        CHECK( corpse->get_var( "remaining_water", -1 ) == 4 );
    }
}

TEST_CASE( "water_extraction_revalidates_corpse_and_destination_identity", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const bionic_id type( "bio_water_extractor" );
    const auto uid = prepare_targeted_bionic( who, type );
    auto corpse = extraction_corpse( who, 4 );
    const auto source = capture_item_source( who, corpse );
    fixture.run( who, water_start_request( fixture, who, uid, source ) );
    save_reload_activity( who );
    unload_liquid_choice choice;
    choice.source = source.path.front();
    choice.kind = LD_GROUND;
    choice.position = who.pos_abs();
    const std::string failure = GENERATE( "replaced_corpse", "moved", "removed_bionic",
                                         "host_container", "far_destination", "wrong_corpse", "unauthorized" );
    CAPTURE( failure );
    if( failure == "replaced_corpse" ) {
        corpse.remove_item();
        extraction_corpse( who, 4 );
    } else if( failure == "moved" ) {
        who.setpos( get_map(), who.pos_bub() + tripoint::east );
    } else if( failure == "removed_bionic" ) {
        who.remove_bionic( **who.find_bionic_by_uid( uid ) );
    } else if( failure == "host_container" ) {
        get_avatar().set_wielded_item( item( itype_id( "bottle_plastic" ) ) );
        choice.kind = LD_ITEM;
        choice.container = capture_item_source( get_avatar(), get_avatar().get_wielded_item() );
    } else if( failure == "far_destination" ) {
        choice.position += tripoint( 4, 0, 0 );
    } else if( failure == "wrong_corpse" ) {
        ++choice.source;
    }
    fixture.run( who, water_choice_request( fixture, who, choice ), failure != "unauthorized" );
    if( corpse ) {
        CHECK( corpse->get_var( "remaining_water", -1 ) == 4 );
    }
    if( who.activity ) {
        fixture.run( who, fixture.request( who, "cancel" ) );
    }
    CHECK_FALSE( who.activity );
    CHECK( who.get_power_level() == 200_kJ );
    for( const item &entry : get_map().i_at( get_map().get_bub( source.position ) ) ) {
        CHECK( entry.typeId() != itype_id( "water_clean" ) );
    }
}

TEST_CASE( "water_extraction_drinks_as_owner_and_survives_callback_cancellation", "[mp_bionic_water]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    const auto uid = prepare_targeted_bionic( who, bionic_id( "bio_water_extractor" ) );
    const auto corpse = extraction_corpse( who, 4 );
    fixture.run( who, water_start_request( fixture, who, uid, capture_item_source( who, corpse ) ) );
    class cancel_on_drink : public event_subscriber {
        public:
            Character &who;
            item_location corpse;
            int count = 0;
            cancel_on_drink( Character &who, item_location corpse ) : who( who ), corpse( corpse ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::character_consumes_item ) {
                    ++count;
                    CHECK( event.get<character_id>( "character" ) == who.getID() );
                    CHECK( corpse->get_var( "remaining_water", -1 ) == 0 );
                    who.cancel_activity();
                }
            }
    } observer( who, corpse );
    consumption_events consumption;
    const auto stomach = who.stomach.contains();
    const auto host_stomach = get_avatar().stomach.contains();
    unload_liquid_choice choice;
    choice.source = corpse->uid().get_value();
    choice.kind = LD_CONSUME;
    const auto request = water_choice_request( fixture, who, choice );
    fixture.run( who, request );
    REQUIRE( observer.count == 1 );
    CHECK( consumption.actors == std::vector<character_id>{ who.getID() } );
    CHECK_FALSE( who.activity );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 3 );
    CHECK( who.get_power_level() == 180_kJ );
    CHECK( who.stomach.contains() > stomach );
    CHECK( get_avatar().stomach.contains() == host_stomach );
    CHECK( who.get_moves() < 100 );
    const auto rng = rng_get_engine();
    fixture.run( who, request );
    CHECK( observer.count == 1 );
    CHECK( rng_get_engine() == rng );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 3 );
}

TEST_CASE( "local_water_extraction_preserves_synchronous_pour_and_cancel", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    const auto uid = prepare_targeted_bionic( who, bionic_id( "bio_water_extractor" ) );
    const auto corpse = extraction_corpse( who, 4 );
    bionic_activation_choices choices;
    choices.water_corpse = capture_item_source( who, corpse );
    const bool pour = GENERATE( true, false );
    const restore_on_out_of_scope restore( test_mode_spilling_action );
    test_mode_spilling_action = pour ? test_mode_spilling_action_t::spill_all :
                               test_mode_spilling_action_t::cancel_spill;
    CHECK( who.activate_bionic( **who.find_bionic_by_uid( uid ), false, nullptr, &choices ) == pour );
    CHECK_FALSE( who.activity );
    CHECK( who.get_power_level() == ( pour ? 180_kJ : 200_kJ ) );
    CHECK( corpse->get_var( "remaining_water", -1 ) == ( pour ? 0 : 4 ) );
}

TEST_CASE( "client_water_selection_is_presentation_only_and_receives_remaining_water", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const bionic_id id( "bio_water_extractor" );
    const auto uid = prepare_targeted_bionic( who, id );
    const auto corpse = extraction_corpse( who, 4 );
    const auto result = fixture.run( who, water_start_request( fixture, who, uid,
                                    capture_item_source( who, corpse ) ) );
    avatar &local = get_avatar();
    local.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    const auto local_uid = prepare_targeted_bionic( local, id );
    const auto local_corpse = extraction_corpse( local, 5 );
    bionic_activation_choices choices;
    choices.water_corpse = capture_item_source( local, local_corpse );
    cata_mp::set_client_mode( true );
    const auto rng = rng_get_engine();
    REQUIRE( local.activate_bionic( **local.find_bionic_by_uid( local_uid ), false, nullptr, &choices ) );
    CHECK( local.get_power_level() == 200_kJ );
    CHECK( local_corpse->get_var( "remaining_water", -1 ) == 5 );
    CHECK( rng_get_engine() == rng );
    auto &view = g->multiplayer_session().client_inventory_activity;
    view.pending_request = fixture.sequence;
    REQUIRE( cata_mp::client_apply_message( result ) );
    CHECK( local.activity.execution() == activity_execution::presentation );
    CHECK( view.water_source_uid == corpse->uid().get_value() );
    REQUIRE( view.preview );
    CHECK( view.preview->typeId() == itype_id( "water_clean" ) );
    CHECK( view.preview->charges == 4 );
    CHECK( local.get_power_level() == 180_kJ );
    CHECK( rng_get_engine() == rng );
}

TEST_CASE( "water_extraction_never_duplicates_frozen_water", "[mp_bionic_water]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    const auto uid = prepare_targeted_bionic( who, bionic_id( "bio_water_extractor" ) );
    auto corpse = extraction_corpse( who, 4 );
    corpse->set_item_temperature( units::from_celsius( -20 ) );
    fixture.run( who, water_start_request( fixture, who, uid, capture_item_source( who, corpse ) ) );
    const auto *actor = dynamic_cast<bionic_water_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    const auto preview = actor->preview( who );
    REQUIRE( preview );
    REQUIRE_FALSE( preview->made_of( phase_id::LIQUID ) );
    who.set_wielded_item( item( itype_id( "bottle_plastic" ) ) );
    const auto stomach = who.stomach.contains();
    consumption_events events;
    unload_liquid_choice choice;
    choice.source = corpse->uid().get_value();
    choice.kind = GENERATE( LD_ITEM, LD_GROUND, LD_CONSUME );
    choice.container = capture_item_source( who, who.get_wielded_item() );
    choice.position = who.pos_abs();
    fixture.run( who, water_choice_request( fixture, who, choice ) );
    CHECK_FALSE( who.activity );
    CHECK( who.get_power_level() == 200_kJ );
    CHECK( who.get_moves() == 100 );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 4 );
    CHECK( who.get_wielded_item()->is_container_empty() );
    CHECK( who.charges_of( itype_id( "water_clean" ) ) == 0 );
    CHECK( who.stomach.contains() == stomach );
    CHECK( events.actors.empty() );
    for( const item &entry : get_map().i_at( who.pos_bub() ) ) {
        CHECK( entry.typeId() != itype_id( "water_clean" ) );
    }
}

namespace
{
struct vehicle_control_fixture : reload_fixture {
    vehicle_control_fixture() {
        // clear_avatar() clears items/body but does not reset driving flags.
        get_avatar().controlling_vehicle = false;
        get_avatar().in_vehicle = false;
    }
    ~vehicle_control_fixture() {
        get_avatar().controlling_vehicle = false;
        get_avatar().in_vehicle = false;
    }
};

vehicle &owned_test_vehicle( Character &who, const tripoint_bub_ms &position,
                             const std::string &prototype = "car" )
{
    map &here = get_map();
    vehicle *target = here.add_vehicle( vproto_id( prototype ), position, 0_degrees, 100,
                                      veh_spawn_status::UNDAMAGED );
    REQUIRE( target );
    target->is_locked = false;
    target->engine_on = false;
    target->set_owner( who.get_faction()->id );
    for( const vpart_reference &part : target->get_avail_parts( "CONTROLS" ) ) {
        who.setpos( here, part.pos_bub( here ) );
        return *target;
    }
    FAIL( "fixture vehicle needs controls" );
    return *target;
}

vehicle_control_selection control_choice( const Character &who, const vehicle &target,
        const std::string &action )
{
    vehicle_control_selection choice;
    choice.vehicle_id = target.uid().get_value();
    choice.position = who.pos_abs();
    choice.action = action;
    return choice;
}

std::string control_request( reload_fixture &fixture, Character &who,
                             const vehicle_control_selection &choice )
{
    return fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "vehicle_control" );
        out.member( "vehicle_control", choice );
    } );
}
} // namespace

TEST_CASE( "owned_vehicle_start_uses_native_time_survives_save_and_releases_without_unboarding",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    auto &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    const int host_moves = host.get_moves();
    const int battery = target.fuel_left( here, itype_id( "battery" ) );
    const std::string request = control_request( fixture, who, control_choice( who, target, "take" ) );
    fixture.run( who, request );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( who.activity.id() == activity_id( "ACT_START_ENGINES" ) );
    REQUIRE( who.activity.moves_left > 1 );
    CHECK_FALSE( target.engine_on );
    CHECK( target.fuel_left( here, itype_id( "battery" ) ) == battery );
    CHECK( who.controlling_vehicle );
    CHECK( who.in_vehicle );
    CHECK_FALSE( host.controlling_vehicle );
    CHECK_FALSE( host.activity );
    // Engine starting is time-based. Save the pending native activity before
    // advancing a world turn, which may legitimately complete a warm engine.
    const int total = who.activity.moves_left;
    save_reload_activity( who );
    CHECK( who.activity.moves_left == total );
    const int left = who.activity.moves_left;
    fixture.run( who, request );
    CHECK( who.activity.moves_left == left );
    who.set_moves( 100000 );
    const std::string step = fixture.request( who, "step" );
    const size_t messages_before_start = recipient.feedback.pending.size();
    fixture.run( who, step );
    REQUIRE_FALSE( who.activity );
    REQUIRE( target.engine_on );
    CHECK( recipient.feedback.pending.size() == messages_before_start + 1 );
    const int after_start = target.fuel_left( here, itype_id( "battery" ) );
    fixture.run( who, step );
    CHECK( target.fuel_left( here, itype_id( "battery" ) ) == after_start );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "release" ) ) );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK( who.in_vehicle );
    CHECK( target.engine_on );
    CHECK( target.get_passenger( here.veh_at( who.pos_bub() )->part_index() ) == &who );
    CHECK( host.get_moves() == host_moves );
}

TEST_CASE( "owned_vehicle_controls_reject_wrong_identity_and_competing_driver",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    vehicle_control_selection choice = control_choice( who, target, "take" );
    SECTION( "wrong vehicle identity" ) {
        ++choice.vehicle_id;
    }
    SECTION( "out of reach controls" ) {
        who.setpos( here, who.pos_bub() + tripoint_rel_ms( 6, 0, 0 ) );
    }
    SECTION( "another player already driving" ) {
        avatar &host = get_avatar();
        host.setpos( here, who.pos_bub() );
        host.controlling_vehicle = true;
    }
    SECTION( "locked vehicle" ) {
        target.is_locked = true;
    }
    const auto before = rng_get_engine();
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK_FALSE( target.engine_on );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "owned_vehicle_start_cancels_when_controls_are_lost_or_vehicle_replaced",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "take" ) ) );
    REQUIRE( who.activity );
    SECTION( "player cancels startup" ) {
        fixture.run( who, fixture.request( who, "cancel" ) );
        CHECK_FALSE( who.controlling_vehicle );
        CHECK( who.in_vehicle );
        CHECK_FALSE( target.engine_on );
    }
    SECTION( "controls disappear" ) {
        for( const vpart_reference &part : target.get_avail_parts( "CONTROLS" ) ) {
            target.set_hp( part.part(), 0, false );
        }
        who.set_moves( 100000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( target.engine_on );
    }
    SECTION( "replacement vehicle must not inherit cranking" ) {
        const tripoint_bub_ms original = target.pos_bub( here );
        here.destroy_vehicle( &target );
        vehicle &replacement = owned_test_vehicle( who, original );
        who.set_moves( 100000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( replacement.engine_on );
    }
    CHECK_FALSE( who.activity );
}

TEST_CASE( "native_engine_start_checks_actual_driver_limbs",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ), "bicycle" );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    REQUIRE_FALSE( target.engines.empty() );
    vehicle_part &engine = target.part( target.engines.front() );
    engine.enabled = true;
    who.set_part_hp_cur( bodypart_id( "leg_l" ), 0 );
    who.set_part_hp_cur( bodypart_id( "leg_r" ), 0 );
    CHECK_FALSE( target.start_engine( here, engine, who ) );
    who.set_part_hp_cur( bodypart_id( "leg_l" ), who.get_part_hp_max( bodypart_id( "leg_l" ) ) );
    who.set_part_hp_cur( bodypart_id( "leg_r" ), who.get_part_hp_max( bodypart_id( "leg_r" ) ) );
    host.set_part_hp_cur( bodypart_id( "leg_l" ), 0 );
    host.set_part_hp_cur( bodypart_id( "leg_r" ), 0 );
    CHECK( target.start_engine( here, engine, who ) );
}

TEST_CASE( "vehicle_start_client_view_never_executes_native_start",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    avatar &who = get_avatar();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    who.set_moves( 100 );
    cata_mp::set_client_mode( true );
    const auto before = rng_get_engine();
    const std::string action = GENERATE( "take", "hotwire", "autopilot_follow", "autopilot_patrol",
                                        "precollision_off" );
    const bool hotwire = action == "hotwire";
    target.is_locked = hotwire;
    CHECK( cata_mp::client_vehicle_control( control_choice( who, target, action ) ) );
    REQUIRE( cata_mp::inventory_activity_view( who.activity ) );
    who.activity.do_turn( who );
    CHECK( target.is_locked == hotwire );
    CHECK_FALSE( target.engine_on );
    CHECK_FALSE( target.is_following );
    CHECK_FALSE( target.is_patrolling );
    CHECK( target.precollision_on );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "remote_vehicle_binding_is_per_character_and_rejects_replacement_identity",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    vehicle &first = owned_test_vehicle( host, tripoint_bub_ms( 45, 45, 0 ) );
    vehicle &second = owned_test_vehicle( remote, tripoint_bub_ms( 65, 65, 0 ) );
    for( vehicle *target : { &first, &second } ) {
        REQUIRE( target->install_part( here, point_rel_ms::zero,
                                      vpart_id( "drive_by_wire_controls" ) ) >= 0 );
    }
    for( Character *who : { static_cast<Character *>( &host ), static_cast<Character *>( &remote ) } ) {
        item controller( itype_id( "remotevehcontrol" ) );
        controller.active = true;
        who->set_wielded_item( controller );
    }
    REQUIRE( set_remote_vehicle( host, here, &first ) );
    REQUIRE( set_remote_vehicle( remote, here, &second ) );
    CHECK( get_remote_vehicle( host, here ) == &first );
    CHECK( get_remote_vehicle( remote, here ) == &second );
    CHECK_FALSE( first.remote_controlled( remote ) );
    const auto before = rng_get_engine();
    CHECK( resolve_remote_vehicle( host, here ) == &first );
    CHECK( rng_get_engine() == before );
    SECTION( "old bubble-coordinate save migrates to identity" ) {
        set_remote_vehicle( remote, here, nullptr );
        remote.set_value( "remote_controlling_vehicle", tripoint_abs_ms( second.pos_bub( here ).raw() ) );
        REQUIRE( get_remote_vehicle( remote, here ) == &second );
        CHECK_FALSE( remote.maybe_get_value( "remote_controlling_vehicle" ) );
        CHECK( remote.maybe_get_value( "remote_vehicle_uid" ) );
    }
    SECTION( "stale position hint cannot select another vehicle" ) {
        remote.set_value( "remote_vehicle_position", first.pos_abs() );
        CHECK( get_remote_vehicle( remote, here ) == &second );
    }
    SECTION( "replaced vehicle does not inherit binding" ) {
        const tripoint_bub_ms position = second.pos_bub( here );
        here.destroy_vehicle( &second );
        owned_test_vehicle( remote, position );
        CHECK( get_remote_vehicle( remote, here ) == nullptr );
    }
    SECTION( "one disconnected controller does not clear the other" ) {
        remote.get_wielded_item()->active = false;
        CHECK( get_remote_vehicle( remote, here ) == nullptr );
    }
    CHECK( get_remote_vehicle( host, here ) == &first );
}

TEST_CASE( "vehicle_start_assignment_handles_removed_owner_or_vehicle",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    const bool retire_owner = GENERATE( false, true );
    class remove_on_start : public event_subscriber
    {
        public:
            character_id owner;
            vehicle *target;
            bool retire;
            bool fired = false;
            remove_on_start( character_id owner, vehicle *target, bool retire ) :
                owner( owner ), target( target ), retire( retire ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( !fired && event.type() == event_type::character_starts_activity &&
                    event.get<character_id>( "character" ) == owner ) {
                    fired = true;
                    if( retire ) {
                        g->remove_npc( owner );
                    } else {
                        get_map().destroy_vehicle( target );
                    }
                }
            }
    } events( who.getID(), &target, retire_owner );
    const std::string reply = fixture.run( who, control_request( fixture, who,
                              control_choice( who, target, "take" ) ) );
    REQUIRE( events.fired );
    if( retire_owner ) {
        CHECK( reply.empty() );
        CHECK_FALSE( target.engine_on );
    } else {
        who.set_moves( 100000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( who.controlling_vehicle );
    }
}

TEST_CASE( "vehicle_muscle_power_and_training_belong_to_the_seated_driver",
           "[multiplayer][vehicle_driving_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    avatar &host = get_avatar();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( host, tripoint_bub_ms( 60, 60, 0 ), "bicycle" );
    const tripoint_bub_ms controls = host.pos_bub();
    const proficiency_id driving( "prof_driver" );
    const float host_training = host.get_proficiency_practice( driving );
    const int host_stamina = host.get_stamina();
    // Merely standing over the pedals does not provide a body's fuel or training.
    CHECK( target.fuel_left( here, itype_id( "muscle" ) ) == 0 );
    target.consume_fuel( here, 1000, false );
    CHECK( host.get_proficiency_practice( driving ) == host_training );
    CHECK( host.get_stamina() == host_stamina );

    host.setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    who.setpos( here, controls );
    here.board_vehicle( controls, &who );
    who.controlling_vehicle = true;
    target.engine_on = true;
    REQUIRE( target.get_driver( here ) == &who );
    REQUIRE( vehicle_operator( target, here ) == &who );
    REQUIRE( target.fuel_left( here, itype_id( "muscle" ) ) > 0 );
    const float training = who.get_proficiency_practice( driving );
    const int stamina = who.get_stamina();
    target.consume_fuel( here, 1000, false );
    CHECK( who.get_stamina() < stamina );
    CHECK( who.get_proficiency_practice( driving ) > training );
    CHECK( host.get_stamina() == host_stamina );
    CHECK( host.get_proficiency_practice( driving ) == host_training );

    who.controlling_vehicle = false;
    const int released_stamina = who.get_stamina();
    const float released_training = who.get_proficiency_practice( driving );
    target.consume_fuel( here, 1000, false );
    CHECK( who.get_stamina() == released_stamina );
    CHECK( who.get_proficiency_practice( driving ) == released_training );
    CHECK( vehicle_operator( target, here ) == nullptr );
}

TEST_CASE( "vehicle_cruise_and_idle_recognize_seated_and_remote_players",
           "[multiplayer][vehicle_driving_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    get_avatar().setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    const bool remote_control = GENERATE( false, true );
    if( remote_control ) {
        REQUIRE( target.install_part( here, point_rel_ms::zero,
                                      vpart_id( "drive_by_wire_controls" ) ) >= 0 );
        item controller( itype_id( "remotevehcontrol" ) );
        controller.active = true;
        who.set_wielded_item( controller );
        who.setpos( here, tripoint_bub_ms( 50, 50, 0 ) );
        REQUIRE( set_remote_vehicle( who, here, &target ) );
        REQUIRE( target.get_driver( here ) == nullptr );
    } else {
        here.board_vehicle( who.pos_bub(), &who );
        who.controlling_vehicle = true;
    }
    REQUIRE( controlled_vehicle( who, here ) == &target );
    target.engine_on = true;
    REQUIRE( adjust_vehicle_cruise( who, here, -1 ) );
    REQUIRE( target.cruise_velocity > 0 );
    const int stamina = who.get_stamina();
    target.gain_moves( here );
    CHECK( target.velocity > 0 );
    REQUIRE_FALSE( target.fuel_used_last_turn.empty() );
    const auto used = target.fuel_used_last_turn;
    target.idle( here, true );
    CHECK( target.fuel_used_last_turn == used );
    CHECK( who.get_stamina() == stamina );
    CHECK( who.get_proficiency_practice( proficiency_id( "prof_driver" ) ) > 0.0f );
    CHECK( get_avatar().get_proficiency_practice( proficiency_id( "prof_driver" ) ) == 0.0f );

    const auto snapshot = json_loader::from_string(
                              cata_mp::serialize_remote_player_state( only_test_remote( g->multiplayer_session() ) ) );
    const JsonObject state = snapshot.get_object();
    state.allow_omitted_members();
    CHECK( state.get_bool( "client_ctrl_veh" ) );
    const JsonObject vehicle_position = state.get_object( "client_veh_pos" );
    vehicle_position.allow_omitted_members();
    CHECK( vehicle_position.get_int( "x" ) == target.pos_abs().x() );
}

TEST_CASE( "vehicle_driving_intents_reject_unowned_controls_and_mutation_uploads",
           "[multiplayer][vehicle_driving_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    auto &recipient = bind_feedback_player( who, 'a', 701 );
    g->multiplayer_session().host_mode = true;
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    get_avatar().setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    recipient.turn.granted_this_turn = true;
    const auto send = [&]( const std::string &action, int dx, int dy ) {
        std::ostringstream stream;
        JsonOut out( stream );
        out.start_object();
        out.member( "type", "action" );
        out.member( "action", action );
        out.member( "dx", dx );
        out.member( "dy", dy );
        out.member( "grant_seq", recipient.turn.grant_seq );
        out.member( "char_stats" );
        out.start_object();
        out.member( "str", 999 );
        out.end_object();
        out.end_object();
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                                stream.str(), recipient.admission } ) );
        cata_mp::process_mp_events();
    };
    const int strength = who.get_str_base();
    const auto rng_before = rng_get_engine();
    send( "cruise", 0, -1 );
    send( "pldrive", 1, 0 );
    send( "handbrake", 0, 0 );
    CHECK( target.cruise_velocity == 0 );
    CHECK( recipient.turn.remote_moves == 100 );
    CHECK( rng_get_engine() == rng_before );
    CHECK( who.get_str_base() == strength );

    here.board_vehicle( who.pos_bub(), &who );
    who.controlling_vehicle = true;
    target.engine_on = true;
    send( "cruise", 0, std::numeric_limits<int>::min() );
    send( "pldrive", 99, 0 );
    CHECK( target.cruise_velocity == 0 );
    CHECK( rng_get_engine() == rng_before );
    send( "cruise", 0, -1 );
    REQUIRE( target.cruise_velocity > 0 );
    CHECK( recipient.turn.remote_moves == 100 );
    CHECK( who.get_str_base() == strength );
    target.is_on_ramp = true;
    send( "pldrive", 1, 0 );
    CHECK( recipient.turn.remote_moves == 100 );
    CHECK( rng_get_engine() == rng_before );
    target.is_on_ramp = false;
    send( "pldrive", 1, 0 );
    CHECK( recipient.turn.remote_moves < 100 );
    CHECK( who.get_moves() == recipient.turn.remote_moves );
    CHECK( who.get_str_base() == strength );
    next_test_remote_turn( recipient );
    target.last_turn = 0_degrees;
    target.velocity = 2000;
    send( "handbrake", 0, 0 );
    CHECK( target.cruise_velocity == 0 );
    CHECK( target.velocity == 0 );
    CHECK( recipient.turn.remote_moves == 0 );
    CHECK( who.get_moves() == 0 );
    CHECK( recipient.turn.client_acted_this_turn );
    const auto after_brake = rng_get_engine();
    send( "cruise", 0, -1 );
    CHECK( target.cruise_velocity == 0 );
    CHECK( rng_get_engine() == after_brake );
}

TEST_CASE( "remote_driving_feedback_and_sinking_do_not_depend_on_the_host",
           "[multiplayer][vehicle_driving_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    auto &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    here.board_vehicle( who.pos_bub(), &who );
    who.controlling_vehicle = true;
    get_avatar().setpos( here, tripoint_bub_ms( 100, 100, 0 ) );
    SECTION( "thrust failure reaches its operator" ) {
        target.engine_on = false;
        target.cruise_velocity = 400;
        const auto count = recipient.feedback.pending.size();
        target.thrust( here, 1 );
        CHECK( recipient.feedback.pending.size() > count );
    }
    SECTION( "standing at controls still permits driving without boarding" ) {
        here.unboard_vehicle( who.pos_bub() );
        who.controlling_vehicle = true;
        REQUIRE_FALSE( who.in_vehicle );
        CHECK( controlled_vehicle( who, here ) == &target );
        CHECK( drive_vehicle( who, here, tripoint_rel_ms( 0, -1, 0 ) ) );
        CHECK( target.cruise_velocity > 0 );
    }
    SECTION( "broken driving controls stop accepting input" ) {
        const int controls = target.avail_part_with_feature( here.veh_at( who.pos_bub() )->part_index(),
                             VPFLAG_CONTROLS );
        REQUIRE( controls >= 0 );
        target.set_hp( target.part( controls ), 0, false );
        const auto before = rng_get_engine();
        CHECK_FALSE( drive_vehicle( who, here, tripoint_rel_ms( 1, 0, 0 ) ) );
        CHECK( rng_get_engine() == before );
        CHECK_FALSE( who.controlling_vehicle );
    }
    SECTION( "sinking unboards remote passengers even after releasing controls" ) {
        who.controlling_vehicle = false;
        const int64_t id = target.uid().get_value();
        for( const tripoint_abs_ms &position : target.get_points() ) {
            here.ter_set( here.get_bub( position ), ter_id( "t_water_dp" ) );
        }
        target.check_falling_or_floating();
        REQUIRE_FALSE( target.can_float( here ) );
        CHECK( target.act_on_map( here ) == nullptr );
        CHECK_FALSE( who.in_vehicle );
        CHECK_FALSE( who.controlling_vehicle );
        CHECK( vehicle::find_vehicle_by_uid( here, id ) == nullptr );
    }
}

TEST_CASE( "owned_hotwire_uses_operator_skill_time_save_and_replay",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    target.is_locked = true;
    who.i_add( item( itype_id( "screwdriver" ) ) );
    who.set_skill_level( skill_id( "mechanics" ), 8 );
    who.set_moves( 100 );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    const int host_moves = host.get_moves();
    const std::string request = control_request( fixture, who, control_choice( who, target, "hotwire" ) );
    fixture.run( who, request );
    REQUIRE( who.activity.id() == activity_id( "ACT_HOTWIRE_CAR" ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( who.activity.moves_total == to_moves<int>( 750_seconds ) );
    save_reload_activity( who );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( who.activity.moves_left == to_moves<int>( 750_seconds ) - 100 );
    CHECK( target.is_locked );
    CHECK( host.get_moves() == host_moves );
    CHECK_FALSE( host.activity );
    who.set_moves( who.activity.moves_left );
    const std::string finish = fixture.request( who, "step" );
    fixture.run( who, finish );
    REQUIRE_FALSE( who.activity );
    CHECK_FALSE( target.is_locked );
    CHECK_FALSE( target.engine_on );
    const auto after = rng_get_engine();
    fixture.run( who, finish );
    CHECK( rng_get_engine() == after );
}

TEST_CASE( "owned_hotwire_cancels_lost_tools_controls_and_replaced_vehicles",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    target.is_locked = true;
    // Prototype cargo can supply extra screwdrivers. This case removes the
    // only available tool, rather than merely the operator's personal one.
    for( const vpart_reference &part : target.get_avail_parts( "CARGO" ) ) {
        target.get_items( part.part() ).clear();
    }
    item_location tool = who.i_add( item( itype_id( "screwdriver" ) ) );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "hotwire" ) ) );
    REQUIRE( who.activity.id() == activity_id( "ACT_HOTWIRE_CAR" ) );
    SECTION( "tool removed" ) {
        tool.remove_item();
        who.invalidate_crafting_inventory();
        REQUIRE_FALSE( who.crafting_inventory( &here ).has_quality( quality_id( "SCREW" ) ) );
    }
    SECTION( "operator moved away" ) {
        who.setpos( here, tripoint_bub_ms( 80, 80, 0 ) );
    }
    SECTION( "controls destroyed" ) {
        const int controls = target.avail_part_with_feature( here.veh_at( who.pos_bub() )->part_index(),
                             VPFLAG_CONTROLS );
        REQUIRE( controls >= 0 );
        target.set_hp( target.part( controls ), 0, false );
    }
    SECTION( "vehicle replaced at the same coordinates" ) {
        const tripoint_bub_ms position = target.pos_bub( here );
        here.destroy_vehicle( &target );
        vehicle &replacement = owned_test_vehicle( who, position );
        replacement.is_locked = true;
        save_reload_activity( who );
    }
    who.set_moves( 1000000 );
    const auto before = rng_get_engine();
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( rng_get_engine() == before );
    for( const wrapped_vehicle &entry : here.get_vehicles() ) {
        CHECK( entry.v->is_locked );
        CHECK_FALSE( entry.v->engine_on );
    }
}

TEST_CASE( "owned_engine_configuration_validates_all_choices_before_applying",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    REQUIRE_FALSE( target.engines.empty() );
    vehicle_part &engine = target.part( target.engines.front() );
    engine.enabled = true;
    target.engine_on = true;
    vehicle_control_selection selection = control_choice( who, target, "engines" );
    selection.engines.push_back( { engine.get_base().uid().get_value(), engine.fuel_current().str(), false } );
    SECTION( "stale part after a valid choice" ) {
        selection.engines.push_back( { std::numeric_limits<int64_t>::max(), engine.fuel_current().str(), false } );
    }
    SECTION( "duplicate part" ) {
        selection.engines.push_back( selection.engines.front() );
    }
    SECTION( "unsupported fuel" ) {
        selection.engines.front().fuel = "water_clean";
    }
    SECTION( "wrong vehicle identity" ) {
        ++selection.vehicle_id;
    }
    const auto before = rng_get_engine();
    fixture.run( who, control_request( fixture, who, selection ) );
    CHECK( engine.enabled );
    CHECK( target.engine_on );
    CHECK_FALSE( who.activity );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "owned_engine_configuration_stops_all_and_restarts_with_native_time",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    get_avatar().setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    vehicle_control_selection selection = control_choice( who, target, "engines" );
    for( const int index : target.engines ) {
        vehicle_part &part = target.part( index );
        part.enabled = true;
        selection.engines.push_back( { part.get_base().uid().get_value(), part.fuel_current().str(), false } );
    }
    REQUIRE_FALSE( selection.engines.empty() );
    target.engine_on = true;
    const std::string disable = control_request( fixture, who, selection );
    fixture.run( who, disable );
    CHECK_FALSE( target.engine_on );
    CHECK_FALSE( who.activity );
    for( const int index : target.engines ) {
        CHECK_FALSE( target.part( index ).enabled );
    }
    fixture.run( who, disable );
    CHECK_FALSE( target.engine_on );
    selection.engines.front().enabled = true;
    const int battery = target.fuel_left( here, itype_id( "battery" ) );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, selection ) );
    REQUIRE( who.activity.id() == activity_id( "ACT_START_ENGINES" ) );
    CHECK_FALSE( target.engine_on );
    CHECK( target.fuel_left( here, itype_id( "battery" ) ) == battery );
    CHECK_FALSE( get_avatar().activity );
    save_reload_activity( who );
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( target.engine_on );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "obsolete_vehicle_toggles_cannot_upload_state_or_change_engines",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    auto &recipient = bind_feedback_player( who, 'a', 701 );
    g->multiplayer_session().host_mode = true;
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    here.board_vehicle( who.pos_bub(), &who );
    who.controlling_vehicle = true;
    target.engine_on = true;
    const int strength = who.get_str_base();
    const auto before = rng_get_engine();
    for( const char *action : { "control_vehicle", "stop_engine", "toggle_engine" } ) {
        next_test_remote_turn( recipient );
        const std::string wire = test_granted_action( std::string( "{\"action\":\"" ) + action +
                                 "\",\"char_stats\":{\"str\":999}}", recipient.turn.grant_seq );
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player", wire,
                                                recipient.admission } ) );
        cata_mp::process_mp_events();
        CHECK( target.engine_on );
        CHECK( who.in_vehicle );
        CHECK( who.controlling_vehicle );
        CHECK( who.get_str_base() == strength );
        CHECK_FALSE( who.activity );
    }
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "vehicle_alarm_operations_use_the_actual_operator",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    auto &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    const int controls = target.avail_part_with_feature( here.veh_at( who.pos_bub() )->part_index(),
                         VPFLAG_CONTROLS );
    REQUIRE( controls >= 0 );
    if( !target.has_security_working( here ) ) {
        REQUIRE( target.install_part( here, target.part( controls ).mount,
                                      vpart_id( "vehicle_alarm" ) ) >= 0 );
    }
    REQUIRE( target.has_security_working( here ) );
    get_avatar().set_skill_level( skill_id( "mechanics" ), 0 );
    who.set_skill_level( skill_id( "mechanics" ), 10 );
    target.is_locked = false;
    target.is_alarm_on = false;
    const auto unlocked_rng = rng_get_engine();
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "alarm" ) ) );
    CHECK_FALSE( target.is_alarm_on );
    CHECK( rng_get_engine() == unlocked_rng );
    target.is_locked = true;
    const auto count = recipient.feedback.pending.size();
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "alarm" ) ) );
    REQUIRE( target.is_alarm_on );
    CHECK( recipient.feedback.pending.size() > count );
    const int controls_hp = target.part( controls ).hp();
    // Select a roll where a skilled operator stops the alarm, but the unskilled
    // host would damage the controls.  Keep this independent of setup RNG use.
    auto alarm_rng = rng_get_engine();
    bool selected_roll = false;
    for( int attempt = 0; attempt < 100 && !selected_roll; ++attempt ) {
        alarm_rng = rng_get_engine();
        const int roll = rng( 1, 100 );
        selected_roll = roll >= 10 && roll <= 20;
    }
    REQUIRE( selected_roll );
    rng_get_engine() = alarm_rng;
    const std::string request = control_request( fixture, who, control_choice( who, target, "smash_alarm" ) );
    fixture.run( who, request );
    CHECK_FALSE( target.is_alarm_on );
    CHECK( target.part( controls ).hp() == controls_hp );
    CHECK( target.is_locked );
    const auto after = rng_get_engine();
    fixture.run( who, request );
    CHECK( rng_get_engine() == after );
}

TEST_CASE( "legacy_hotwire_save_binds_nearby_controls_to_vehicle_identity",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    target.is_locked = true;
    who.i_add( item( itype_id( "screwdriver" ) ) );
    who.set_skill_level( skill_id( "mechanics" ), 8 );
    const tripoint_abs_ms controls = who.pos_abs();
    bool adjacent = false;
    for( const tripoint_abs_ms &position : target.get_points() ) {
        if( rl_dist( controls, position ) == 1 ) {
            who.setpos( here, here.get_bub( position ) );
            adjacent = true;
            break;
        }
    }
    REQUIRE( adjacent );
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    out.member( "target", target.pos_abs() );
    out.member( "moves_total", 100 );
    out.end_object();
    JsonValue value = json_loader::from_string( stream.str() );
    const auto actor = hotwire_car_activity_actor::deserialize( value );
    player_activity activity( *actor );
    actor->start( activity, who );
    REQUIRE( activity );
    CHECK( activity.moves_left == 100 );
    actor->finish( activity, who );
    CHECK_FALSE( target.is_locked );
}

namespace
{
vehicle &owned_autopilot_vehicle( Character &who )
{
    map &here = get_map();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    const auto at = here.veh_at( who.pos_bub() );
    REQUIRE( at );
    if( target.avail_part_with_feature( at->mount_pos(), "CTRL_ELECTRONIC" ) < 0 ) {
        REQUIRE( target.install_part( here, at->mount_pos(), vpart_id( "controls_electronic" ) ) >= 0 );
    }
    REQUIRE( target.install_part( here, at->mount_pos(), vpart_id( "programmable_autopilot" ) ) >= 0 );
    return target;
}
} // namespace

TEST_CASE( "owned_autopilot_follow_uses_operator_startup_and_persists_target",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_autopilot_vehicle( who );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 40, 40, 0 ) );
    const int host_moves = host.get_moves();
    const auto request = control_request( fixture, who, control_choice( who, target, "autopilot_follow" ) );
    fixture.run( who, request );
    REQUIRE( target.is_following );
    CHECK( target.get_follow_target() == &who );
    CHECK( target.following_character == who.getID() );
    REQUIRE( who.activity.id() == activity_id( "ACT_START_ENGINES" ) );
    CHECK( cata_mp::owns_inventory_activity( who ) );
    CHECK_FALSE( host.activity );
    CHECK( host.get_moves() == host_moves );
    const int startup = who.activity.moves_left;
    const auto rng = rng_get_engine();
    fixture.run( who, request );
    CHECK( who.activity.moves_left == startup );
    CHECK( rng_get_engine() == rng );

    std::ostringstream encoded;
    JsonOut out( encoded );
    target.serialize( out );
    vehicle restored( vproto_id( "" ) );
    restored.deserialize( json_loader::from_string( encoded.str() ).get_object() );
    CHECK( restored.following_character == who.getID() );
    CHECK( restored.get_follow_target() == &who );
    save_reload_activity( who );
    who.set_moves( startup );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( target.engine_on );
    CHECK( target.get_follow_target() == &who );
}

TEST_CASE( "autopilot_tracks_remote_player_and_suspends_for_their_boarding",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_autopilot_vehicle( who );
    target.engine_on = true;
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "autopilot_follow" ) ) );
    REQUIRE( target.get_follow_target() == &who );
    avatar &host = get_avatar();
    owned_test_vehicle( host, tripoint_bub_ms( 30, 30, 0 ) );
    here.board_vehicle( host.pos_bub(), &host );
    REQUIRE( host.in_vehicle );
    who.setpos( here, tripoint_bub_ms( 100, 60, 0 ) );
    // Actual movement dispatch must ignore the host's boarded state and target.
    here.vehmove();
    CHECK( target.is_following );
    CHECK( target.cruise_velocity > 0 );
    CHECK( target.get_follow_target() == &who );

    const auto seats = target.get_avail_parts( "BOARDABLE" );
    REQUIRE_FALSE( empty( seats ) );
    who.setpos( here, seats.begin()->pos_bub( here ) );
    here.board_vehicle( who.pos_bub(), &who );
    REQUIRE( who.in_vehicle );
    target.autopilot_follow( here );
    CHECK_FALSE( target.is_following );
    CHECK_FALSE( target.autopilot_on );
    CHECK( target.cruise_velocity == 0 );
}

TEST_CASE( "autopilot_missing_target_never_falls_back_to_host_and_legacy_binds_once",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    vehicle &target = owned_autopilot_vehicle( who );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    who.setpos( here, tripoint_bub_ms( 100, 60, 0 ) );
    target.engine_on = target.autopilot_on = target.is_following = true;
    SECTION( "missing assigned player" ) {
        target.following_character = character_id( 2000000000 );
        CHECK( target.get_follow_target() == nullptr );
        target.autopilot_follow( here );
        CHECK_FALSE( target.is_following );
        CHECK( target.cruise_velocity == 0 );
    }
    SECTION( "assigned player outside loaded map" ) {
        target.following_character = who.getID();
        // Leave the reality bubble without generating distant overmaps.
        const tripoint_bub_ms outside( here.getmapsize() * SEEX, 60, 0 );
        REQUIRE_FALSE( here.inbounds( outside ) );
        who.setpos( here, outside, false );
        target.autopilot_follow( here );
        CHECK_FALSE( target.is_following );
    }
    SECTION( "legacy save without an assigned player" ) {
        target.following_character.reset();
        CHECK( target.get_follow_target() == &get_avatar() );
        target.autopilot_follow( here );
        CHECK( target.following_character == get_avatar().getID() );
    }
}

TEST_CASE( "autopilot_collision_checks_followed_player_and_other_bodies_separately",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    vehicle &target = owned_autopilot_vehicle( who );
    target.is_following = target.autopilot_on = target.engine_on = true;
    target.following_character = who.getID();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    std::optional<tripoint_bub_ms> ahead;
    for( const point_abs_ms &point : target.immediate_path( &here ) ) {
        const tripoint_bub_ms p = here.get_bub( tripoint_abs_ms( point, 0 ) );
        if( !here.veh_at( p ) && here.passable( p ) ) {
            ahead = p;
            break;
        }
    }
    REQUIRE( ahead );
    who.setpos( here, *ahead );
    units::angle angle = 0_degrees;
    CHECK_FALSE( target.precollision_check( angle, here, true ) );
    who.setpos( here, tripoint_bub_ms( 100, 100, 0 ) );
    host.setpos( here, *ahead );
    CHECK( target.precollision_check( angle, here, true ) );
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    npc &other = spawn_npc( { ahead->x(), ahead->y() }, "test_talker" );
    CHECK( target.precollision_check( angle, here, true ) );
    CHECK( other.pos_bub() == *ahead );
}

TEST_CASE( "owned_autopilot_settings_validate_parts_access_and_replay",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    auto &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_autopilot_vehicle( who );
    target.engine_on = target.autopilot_on = target.is_following = true;
    target.following_character = who.getID();
    const auto disable = control_request( fixture, who, control_choice( who, target, "precollision_off" ) );
    fixture.run( who, disable );
    REQUIRE_FALSE( target.precollision_on );
    const auto rng = rng_get_engine();
    fixture.run( who, disable );
    CHECK_FALSE( target.precollision_on );
    CHECK( rng_get_engine() == rng );
    REQUIRE_FALSE( recipient.feedback.pending.empty() );
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "precollision_on" ) ) );
    REQUIRE( target.precollision_on );
    const auto stop = control_choice( who, target, "autopilot_stop" );
    SECTION( "stopping uses native state and engine shutdown" ) {
        fixture.run( who, control_request( fixture, who, stop ) );
        CHECK_FALSE( target.engine_on );
        CHECK_FALSE( target.is_following );
        CHECK_FALSE( target.is_patrolling );
        CHECK_FALSE( target.following_character );
    }
    SECTION( "lost access" ) {
        who.setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
        fixture.run( who, control_request( fixture, who, stop ) );
        CHECK( target.engine_on );
        CHECK( target.is_following );
    }
    SECTION( "broken autopilot" ) {
        const auto parts = target.get_avail_parts( "AUTOPILOT" );
        REQUIRE_FALSE( empty( parts ) );
        target.set_hp( parts.begin()->part(), 0, false );
        CHECK_FALSE( vehicle_control_accessible( who, here, target, who.pos_abs(), "autopilot_follow" ) );
        fixture.run( who, control_request( fixture, who, stop ) );
        CHECK_FALSE( target.engine_on );
        CHECK_FALSE( target.is_following );
    }
}

TEST_CASE( "owned_autopilot_patrol_uses_initiating_faction_zones_and_survives_save",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope clear_zones( [&]() { zones.clear(); } );
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    who.set_fac( faction_id( "free_merchants" ) );
    vehicle &target = owned_autopilot_vehicle( who );
    target.engine_on = true;
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const auto start = here.get_abs( tripoint_bub_ms( 80, 70, 0 ) );
    const auto end = here.get_abs( tripoint_bub_ms( 85, 75, 0 ) );
    zones.add( "Host patrol", zone_type_id( "VEHICLE_PATROL" ), your_fac, false, true, start, end );
    zones.cache_data();
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "autopilot_patrol" ) ) );
    CHECK_FALSE( target.is_patrolling );
    zones.add( "Operator patrol", zone_type_id( "VEHICLE_PATROL" ), who.get_faction()->id,
               false, true, start, end );
    zones.cache_data();
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "autopilot_patrol" ) ) );
    REQUIRE( target.is_patrolling );
    CHECK_FALSE( target.is_following );
    CHECK( target.patrol_faction == who.get_faction()->id );
    std::ostringstream encoded;
    JsonOut out( encoded );
    target.serialize( out );
    vehicle restored( vproto_id( "" ) );
    restored.deserialize( json_loader::from_string( encoded.str() ).get_object() );
    CHECK( restored.patrol_faction == who.get_faction()->id );
    target.autopilot_patrol( &here );
    const auto points = zones.get_near( zone_type_id( "VEHICLE_PATROL" ), target.pos_abs(),
                                      MAX_VIEW_DISTANCE, nullptr, who.get_faction()->id );
    std::ostringstream updated;
    JsonOut waypoint_out( updated );
    target.serialize( waypoint_out );
    JsonObject snapshot = json_loader::from_string( updated.str() ).get_object();
    snapshot.allow_omitted_members();
    tripoint_abs_ms waypoint;
    snapshot.read( "autodrive_local_target", waypoint, true );
    CHECK( points.count( waypoint ) == 1 );
    target.enable_patrol( here, who );
    zones.clear();
    target.cruise_velocity = 400;
    target.autopilot_patrol( &here );
    CHECK_FALSE( target.is_patrolling );
    CHECK_FALSE( target.autopilot_on );
    CHECK( target.cruise_velocity == 0 );
}

namespace
{
item_location remote_controller( Character &who )
{
    item controller( itype_id( "remotevehcontrol" ) );
    item battery( itype_id( "light_battery_cell" ) );
    battery.ammo_set( itype_id( "battery" ), 100 );
    REQUIRE( controller.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    who.set_wielded_item( controller );
    who.set_moves( 1000 );
    REQUIRE( who.get_wielded_item()->ammo_sufficient( &who, "REMOTEVEH" ) );
    return who.get_wielded_item();
}

vehicle &radio_vehicle( Character &who, bool advanced = true )
{
    map &here = get_map();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    if( empty( target.get_avail_parts( advanced ? "REMOTE_CONTROLS" : "CTRL_ELECTRONIC" ) ) ) {
        REQUIRE( target.install_part( here, point_rel_ms::zero,
                                     vpart_id( advanced ? "drive_by_wire_controls" : "controls_electronic" ) ) >= 0 );
    }
    who.setpos( here, tripoint_bub_ms( 50, 50, 0 ) );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    return target;
}

std::string radio_request( reload_fixture &fixture, Character &who, const std::string &action,
                           std::optional<int64_t> uid = std::nullopt )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, who.get_wielded_item() ) );
        out.member( "item_type", "remotevehcontrol" );
        out.member( "method", "REMOTEVEH" );
        out.member( "target", who.pos_abs() );
        out.member( "remote_vehicle_action", action );
        out.member( "remote_vehicle_uid", uid );
    } );
}

void arrange_security_prompt( Character &who, item &controller, vehicle &target )
{
    map &here = get_map();
    if( !target.has_security_working( here ) ) {
        REQUIRE( target.install_part( here, point_rel_ms::zero, vpart_id( "vehicle_alarm" ) ) >= 0 );
    }
    REQUIRE( target.has_security_working( here ) );
    target.is_locked = true;
    target.is_alarm_on = false;
    who.set_skill_level( skill_id( "computer" ), 10 );
    who.set_int_bonus( 4 );
    auto selected = rng_get_engine();
    bool found = false;
    for( int attempt = 0; attempt < 100 && !found; ++attempt ) {
        selected = rng_get_engine();
        REQUIRE( controller.activation_success() );
        const int roll = dice( 12, who.get_int() ) - 50;
        found = roll >= 0 && roll < 20;
    }
    REQUIRE( found );
    rng_get_engine() = selected;
}
} // namespace

TEST_CASE( "remote_controller_take_and_stop_belong_to_operator_and_replay_once",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    target.engine_on = true;
    const item_location controller = remote_controller( who );
    const int before = controller->ammo_remaining();
    const int host_moves = get_avatar().get_moves();
    const auto request = radio_request( fixture, who, "control", target.uid().get_value() );
    const std::string result = fixture.run( who, request );
    CHECK( controller->active );
    CHECK( resolve_remote_vehicle( who, get_map() ) == &target );
    CHECK_FALSE( resolve_remote_vehicle( get_avatar(), get_map() ) );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK_FALSE( get_avatar().activity );
    CHECK( controller->ammo_remaining() == before - 1 );
    const auto rng = rng_get_engine();
    fixture.run( who, request );
    CHECK( controller->ammo_remaining() == before - 1 );
    CHECK( rng_get_engine() == rng );
    JsonObject reply = json_loader::from_string( result ).get_object();
    reply.allow_omitted_members();
    JsonObject binding = reply.get_object( "remote_vehicle" );
    binding.allow_omitted_members();
    CHECK( binding.get_int64( "uid" ) == target.uid().get_value() );
    fixture.run( who, radio_request( fixture, who, "stop" ) );
    CHECK_FALSE( controller->active );
    CHECK_FALSE( resolve_remote_vehicle( who, get_map() ) );
    CHECK( target.engine_on );
}

TEST_CASE( "remote_security_scan_survives_save_and_owner_choice_without_reroll",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    target.engine_on = true;
    item_location controller = remote_controller( who );
    arrange_security_prompt( who, *controller, target );
    const auto request = radio_request( fixture, who, "control", target.uid().get_value() );
    fixture.run( who, request );
    auto *actor = dynamic_cast<remote_vehicle_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for_security() );
    CHECK( who.get_moves() == 1000 );
    const auto scanned = rng_get_engine();
    fixture.run( who, request );
    CHECK( rng_get_engine() == scanned );
    save_reload_activity( who );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    actor = dynamic_cast<remote_vehicle_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for_security() );
    CHECK( rng_get_engine() == scanned );
    const bool consent = GENERATE( false, true );
    const int charges = controller->charges;
    const int ammo = controller->ammo_remaining();
    const int battery_ammo = controller->magazine_current()->ammo_remaining();
    auto canceled_rng = rng_get_engine();
    {
        // TEST_DATA's finished-activity EOC chooses its sole string with rng.
        // Include that native callback, but no second security dice roll.
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        rng( 0, 0 );
        canceled_rng = rng_get_engine();
    }
    const auto answer = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "remote_security", consent );
    } );
    fixture.run( who, answer );
    CHECK_FALSE( who.activity );
    if( consent ) {
        CHECK_FALSE( target.is_locked );
        CHECK( resolve_remote_vehicle( who, get_map() ) == &target );
        const int effort = ( 1000 - who.get_moves() ) / 100;
        CHECK( controller->charges == charges - effort );
        CHECK( controller->ammo_remaining() == ammo - effort - 1 );
        CHECK( controller->magazine_current()->ammo_remaining() == battery_ammo - 1 );
        CHECK( who.get_moves() <= 800 );
        CHECK( who.get_moves() >= 200 );
    } else {
        CHECK( target.is_locked );
        CHECK_FALSE( controller->active );
        CHECK( who.get_moves() == 900 );
        CHECK( controller->charges == charges - 1 );
        CHECK( controller->ammo_remaining() == ammo - 1 );
        CHECK( controller->magazine_current()->ammo_remaining() == battery_ammo );
        CHECK( rng_get_engine() == canceled_rng );
    }
    const auto final_rng = rng_get_engine();
    const int final_moves = who.get_moves();
    fixture.run( who, answer );
    CHECK( rng_get_engine() == final_rng );
    CHECK( who.get_moves() == final_moves );
}

TEST_CASE( "one_remote_vehicle_action_keeps_native_startup_without_granting_driving",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who, false );
    const item_location controller = remote_controller( who );
    fixture.run( who, radio_request( fixture, who, "action", target.uid().get_value() ) );
    auto *actor = dynamic_cast<remote_vehicle_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for_action() );
    CHECK_FALSE( controller->active );
    CHECK_FALSE( resolve_remote_vehicle( who, here ) );
    vehicle_control_selection choice;
    choice.vehicle_id = target.uid().get_value();
    choice.position = target.get_avail_parts( "CTRL_ELECTRONIC" ).begin()->pos_abs();
    choice.action = "start";
    const std::string action = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "vehicle_control", choice );
    } );
    fixture.run( who, action );
    REQUIRE( who.activity.id() == activity_id( "ACT_START_ENGINES" ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK_FALSE( controller->active );
    save_reload_activity( who );
    SECTION( "startup completes with the same controller" ) {
        who.set_moves( who.activity.moves_left );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( target.engine_on );
        CHECK_FALSE( resolve_remote_vehicle( who, here ) );
    }
    SECTION( "dropping the controller cancels the saved startup" ) {
        who.remove_weapon();
        who.set_moves( 1000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( target.engine_on );
    }
}

TEST_CASE( "remote_access_rejects_unreachable_and_replaced_vehicles_before_rng",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    const item_location controller = remote_controller( who );
    const int64_t uid = target.uid().get_value();
    SECTION( "out of radio range" ) {
        who.setpos( get_map(), tripoint_bub_ms( 1, 1, 0 ) );
    }
    SECTION( "original vehicle no longer exists" ) {
        get_map().destroy_vehicle( &target );
    }
    const auto rng = rng_get_engine();
    const int ammo = controller->ammo_remaining();
    fixture.run( who, radio_request( fixture, who, "control", uid ) );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( controller->active );
    CHECK( controller->ammo_remaining() == ammo );
    CHECK( who.get_moves() == 1000 );
    CHECK( rng_get_engine() == rng );
}

TEST_CASE( "local_remote_controller_retains_native_invocation_result_and_charge",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &target = radio_vehicle( who );
    target.engine_on = true;
    item_location controller = remote_controller( who );
    const int before = controller->ammo_remaining();
    item_activation_choices choices;
    choices.remote_vehicle_action = "control";
    choices.remote_vehicle_uid = target.uid().get_value();
    // invoke_item returns whether the item itself was consumed, not success.
    CHECK_FALSE( who.Character::invoke_item( controller.get_item(), "REMOTEVEH", who.pos_bub(),
                                           who.get_moves(), &choices ) );
    CHECK( controller->ammo_remaining() == before - 1 );
    CHECK( controller->active );
    CHECK( resolve_remote_vehicle( who, get_map() ) == &target );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "local_vehicle_menu_requires_its_live_remote_controller_outside_reach",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    vehicle &target = radio_vehicle( who );
    who.setpos( here, tripoint_bub_ms( 50, 50, 0 ) );
    target.engine_on = true;
    const item_location controller = remote_controller( who );
    const tripoint_bub_ms controls = target.get_avail_parts( "CONTROLS" ).begin()->pos_bub( here );
    REQUIRE( rl_dist( controls, who.pos_bub() ) > 1 );
    const int access = GENERATE( 0, 1, 2 );
    INFO( "0: ordinary menu, 1: authenticated radio, 2: dropped controller; access=" << access );
    veh_menu menu( target, "test remote vehicle menu" );
    if( access != 0 ) {
        menu.remote_controller = &controller;
    }
    target.build_interact_menu( menu, &here, controls, false );
    const std::vector<veh_menu_item> entries = menu.get_items();
    const auto stop = std::find_if( entries.begin(), entries.end(), []( const veh_menu_item &entry ) {
        return entry._hotkey_action == "TOGGLE_ENGINE";
    } );
    REQUIRE( stop != entries.end() );
    REQUIRE( stop->_enabled );
    REQUIRE( stop->_on_submit );
    if( access == 2 ) {
        who.remove_weapon();
    }
    stop->_on_submit();
    CHECK( target.engine_on == ( access != 1 ) );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK_FALSE( resolve_remote_vehicle( who, here ) );
}

TEST_CASE( "saved_remote_security_scan_never_uses_a_replacement_controller",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    item_location controller = remote_controller( who );
    arrange_security_prompt( who, *controller, target );
    fixture.run( who, radio_request( fixture, who, "control", target.uid().get_value() ) );
    REQUIRE( who.activity.id() == activity_id( "ACT_REMOTE_VEHICLE" ) );
    save_reload_activity( who );
    who.remove_weapon();
    controller = remote_controller( who );
    const int ammo = controller->ammo_remaining();
    fixture.run( who, fixture.request( who, "choose", []( JsonOut &out ) {
        out.member( "remote_security", true );
    } ) );
    CHECK_FALSE( who.activity );
    CHECK( target.is_locked );
    CHECK_FALSE( controller->active );
    CHECK( controller->ammo_remaining() == ammo );
    CHECK_FALSE( resolve_remote_vehicle( who, get_map() ) );
}

namespace
{
vehicle &electronic_vehicle( Character &who )
{
    vehicle &target = radio_vehicle( who, false );
    who.setpos( get_map(), target.get_avail_parts( "CTRL_ELECTRONIC" ).begin()->pos_bub( get_map() ) );
    who.set_moves( 100 );
    return target;
}

point_rel_ms next_electronic_mount( const vehicle &target )
{
    point_rel_ms front = point_rel_ms::zero;
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( !part.part().removed && part.mount_pos().x() > front.x() ) {
            front = part.mount_pos();
        }
    }
    return front + point_rel_ms( 1, 0 );
}

vehicle_control_selection electronic_choice( Character &who, vehicle &target,
        const std::string &system, bool enabled, int64_t part = 0 )
{
    auto choice = control_choice( who, target, "electronics" );
    choice.electronics = vehicle_electronics_selection{ system, part, enabled };
    return choice;
}

void require_lights( const vehicle &target, bool enabled )
{
    REQUIRE_FALSE( empty( target.get_avail_parts( "CONE_LIGHT" ) ) );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        CHECK( part.part().enabled == enabled );
    }
}
} // namespace

TEST_CASE( "owned_vehicle_device_choices_are_read_only_and_replay_once",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    auto &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        part.part().enabled = false;
    }
    const auto initial_rng = rng_get_engine();
    const auto options = vehicle_electronics_options( who, here, target );
    const auto lights = std::find_if( options.begin(), options.end(), []( const vehicle_electronics_option &option ) {
        return option.choice.system == "CONE_LIGHT";
    } );
    REQUIRE( lights != options.end() );
    CHECK( lights->enabled );
    CHECK( lights->choice.enabled );
    require_lights( target, false );
    CHECK( rng_get_engine() == initial_rng );
    const auto request = control_request( fixture, who, electronic_choice( who, target, "CONE_LIGHT", true ) );
    fixture.run( who, request );
    require_lights( target, true );
    CHECK( here.get_cache_ref( who.posz() ).lightmap_dirty );
    CHECK_FALSE( recipient.feedback.pending.empty() );
    const auto rng = rng_get_engine();
    fixture.run( who, request );
    require_lights( target, true );
    CHECK( rng_get_engine() == rng );
    fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "CONE_LIGHT", false ) ) );
    require_lights( target, false );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK_FALSE( get_avatar().controlling_vehicle );
}

TEST_CASE( "owned_vehicle_electronics_rejects_forged_systems_and_lost_access",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        part.part().enabled = false;
    }
    auto choice = electronic_choice( who, target, "CONE_LIGHT", true );
    SECTION( "engine is not an electronic switch" ) {
        choice.electronics->system = "ENGINE";
    }
    SECTION( "group does not accept arbitrary part IDs" ) {
        choice.electronics->part_id = 123456;
    }
    SECTION( "operator left the controls" ) {
        who.setpos( get_map(), tripoint_bub_ms( 100, 100, 0 ) );
    }
    SECTION( "vehicle was locked" ) {
        target.is_locked = true;
    }
    SECTION( "electronic controls were removed" ) {
        for( const vpart_reference &control : target.get_avail_parts( "CTRL_ELECTRONIC" ) ) {
            target.remove_part( control.part() );
        }
        REQUIRE_FALSE( vehicle_electronics_position( who, get_map(), target ) );
    }
    const auto rng = rng_get_engine();
    fixture.run( who, control_request( fixture, who, choice ) );
    require_lights( target, false );
    CHECK_FALSE( target.engine_on );
    CHECK( rng_get_engine() == rng );
}

TEST_CASE( "owned_camera_and_reactor_commands_validate_power_and_hardware_identity",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    SECTION( "camera state is explicit and refreshes visibility" ) {
        REQUIRE( target.install_part( here, point_rel_ms::zero, vpart_id( "cam_control" ) ) >= 0 );
        target.camera_on = false;
        const auto request = control_request( fixture, who, electronic_choice( who, target, "camera", true ) );
        fixture.run( who, request );
        CHECK( target.camera_on );
        CHECK( here.get_cache_ref( who.posz() ).seen_cache_dirty );
        fixture.run( who, request );
        CHECK( target.camera_on );
        fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "camera", false ) ) );
        CHECK_FALSE( target.camera_on );
        target.discharge_battery( here, target.fuel_left( here, itype_id( "battery" ) ) );
        REQUIRE( target.fuel_left( here, itype_id( "battery" ) ) == 0 );
        fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "camera", true ) ) );
        CHECK_FALSE( target.camera_on );
    }
    SECTION( "removed reactor never addresses its replacement" ) {
        const point_rel_ms mount = next_electronic_mount( target );
        REQUIRE( target.install_part( here, mount, vpart_id( "frame" ) ) >= 0 );
        const int index = target.install_part( here, mount, vpart_id( "compact_ASRG_containment" ) );
        REQUIRE( index >= 0 );
        target.part( index ).enabled = false;
        const int64_t id = target.part( index ).get_base().uid().get_value();
        const auto choice = electronic_choice( who, target, "reactor", true, id );
        fixture.run( who, control_request( fixture, who, choice ) );
        CHECK( target.part( index ).enabled );
        target.remove_part( target.part( index ) );
        const int replacement = target.install_part( here, mount, vpart_id( "compact_ASRG_containment" ) );
        REQUIRE( replacement >= 0 );
        target.part( replacement ).enabled = false;
        REQUIRE( target.part( replacement ).get_base().uid().get_value() != id );
        fixture.run( who, control_request( fixture, who, choice ) );
        CHECK_FALSE( target.part( replacement ).enabled );
    }
}

TEST_CASE( "owned_motorized_doors_keep_native_blocking_locking_and_group_rules",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    auto &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const auto doors = target.get_avail_parts( "DOOR" );
    REQUIRE_FALSE( empty( doors ) );
    const int door = doors.begin()->part_index();
    const point_rel_ms mount = target.part( door ).mount;
    const int motor = target.install_part( here, mount, vpart_id( "door_motor" ) );
    REQUIRE( motor >= 0 );
    if( !target.part_has_lock( door ) ) {
        REQUIRE( target.install_part( here, mount, vpart_id( "door_lock" ) ) >= 0 );
    }
    const int64_t id = target.part( door ).get_base().uid().get_value();
    target.open( here, door );
    const auto close = electronic_choice( who, target, "door_open", false, id );
    get_avatar().setpos( here, here.get_bub( target.abs_part_pos( target.part( door ) ) ) );
    fixture.run( who, control_request( fixture, who, close ) );
    CHECK( target.part( door ).open );
    CHECK_FALSE( recipient.feedback.pending.empty() );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    fixture.run( who, control_request( fixture, who, close ) );
    CHECK_FALSE( target.part( door ).open );
    fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "door_lock", true, id ) ) );
    CHECK( target.part( door ).locked );
    const auto all_open = control_request( fixture, who, electronic_choice( who, target, "doors_open", true ) );
    fixture.run( who, all_open );
    CHECK_FALSE( target.part( door ).locked );
    CHECK( target.part( door ).open );
    fixture.run( who, all_open );
    CHECK( target.part( door ).open );
    fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "doors_and_curtains_close", false ) ) );
    CHECK_FALSE( target.part( door ).open );
    target.remove_part( target.part( motor ) );
    fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "door_open", true, id ) ) );
    CHECK_FALSE( target.part( door ).open );
}

TEST_CASE( "remote_one_shot_electronics_uses_the_authorized_controller_once",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    const item_location controller = remote_controller( who );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        part.part().enabled = false;
    }
    fixture.run( who, radio_request( fixture, who, "action", target.uid().get_value() ) );
    REQUIRE( who.activity.id() == activity_id( "ACT_REMOTE_VEHICLE" ) );
    auto choice = electronic_choice( who, target, "CONE_LIGHT", true );
    choice.position = target.get_avail_parts( "REMOTE_CONTROLS" ).begin()->pos_abs();
    const int ammo = controller->ammo_remaining();
    const auto request = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "vehicle_control", choice );
    } );
    fixture.run( who, request );
    CHECK_FALSE( who.activity );
    require_lights( target, true );
    CHECK( controller->ammo_remaining() == ammo - 1 );
    CHECK_FALSE( resolve_remote_vehicle( who, get_map() ) );
    fixture.run( who, request );
    CHECK( controller->ammo_remaining() == ammo - 1 );
}

TEST_CASE( "native_electronics_menu_dispatches_the_same_operator_command",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    vehicle &target = electronic_vehicle( who );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        part.part().enabled = false;
    }
    veh_menu menu( target, "test electronics" );
    target.build_electronics_menu( here, menu );
    require_lights( target, false );
    const auto entries = menu.get_items();
    const auto lights = std::find_if( entries.begin(), entries.end(), []( const veh_menu_item &entry ) {
        return entry._hotkey_action == "TOGGLE_HEADLIGHT";
    } );
    REQUIRE( lights != entries.end() );
    REQUIRE( lights->_enabled );
    REQUIRE( lights->_on_submit );
    lights->_on_submit();
    require_lights( target, true );
}

TEST_CASE( "planter_enabling_reads_the_operator_environment_instead_of_the_host",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    vehicle &target = electronic_vehicle( who );
    const int planter = target.install_part( here, next_electronic_mount( target ), vpart_id( "seed_drill" ) );
    REQUIRE( planter >= 0 );
    who.setpos( here, tripoint_bub_ms( 50, 50, 0 ), false );
    here.ter_set( who.pos_bub(), ter_str_id( "t_greenhouse_tilled" ) );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, -1 ), false );
    REQUIRE( warm_enough_to_plant( who.pos_bub(), itype_id( "seed_buckwheat" ) ).success() );
    REQUIRE_FALSE( warm_enough_to_plant( get_avatar().pos_bub(), itype_id( "seed_buckwheat" ) ).success() );
    CHECK( can_enable_vehicle_part( who, here, target, target.part( planter ) ) );
    CHECK_FALSE( target.can_enable( here, target.part( planter ) ) );
    // Ordinary soil must forecast temperature without advancing wind or gameplay RNG.
    here.ter_set( who.pos_bub(), ter_str_id( "t_dirt" ) );
    const auto rng = rng_get_engine();
    const int wind = weather_generator::current_winddir;
    vehicle_electronics_options( who, here, target );
    CHECK( rng_get_engine() == rng );
    CHECK( weather_generator::current_winddir == wind );
}

namespace
{
struct appliance_fixture : vehicle_control_fixture {
    restore_on_out_of_scope<time_point> saved_turn{ calendar::turn };
    appliance_fixture() {
        calendar::turn = calendar::turn_zero + 1_days;
    }
};

int install_test_appliance( Character &who, vehicle &target, const std::string &type )
{
    map &here = get_map();
    const point_rel_ms mount = next_electronic_mount( target );
    if( vpart_id( type )->location.str() != "structure" ) {
        REQUIRE( target.install_part( here, mount, vpart_id( "frame" ) ) >= 0 );
    }
    const auto allowed = target.can_mount( mount, vpart_id( type ).obj() );
    INFO( allowed.str() );
    REQUIRE( allowed.success() );
    const int index = target.install_part( here, mount, vpart_id( type ) );
    REQUIRE( index >= 0 );
    target.part( index ).enabled = false;
    here.add_vehicle_to_cache( &target );
    who.setpos( here, here.get_bub( target.abs_part_pos( target.part( index ) ) ) + tripoint_rel_ms( 0, 1, 0 ) );
    who.set_moves( 100 );
    return index;
}

void fill_appliance_water( vehicle &target, const itype_id &type = itype_id( "water" ) )
{
    for( const int index : target.fuel_containers ) {
        if( target.part( index ).is_tank() ) {
            target.part( index ).ammo_set( type, 100 );
            break;
        }
    }
    REQUIRE( target.fuel_left( get_map(), type ) == 100 );
}

vehicle_control_selection appliance_choice( Character &who, vehicle &target, int part,
        bool enabled, bool detergent = false, usage_from from = usage_from::player )
{
    auto choice = control_choice( who, target, "appliance" );
    choice.position = target.abs_part_pos( target.part( part ) );
    choice.appliance = vehicle_appliance_selection{};
    choice.appliance->part_id = target.part( part ).get_base().uid().get_value();
    choice.appliance->enabled = enabled;
    if( detergent ) {
        choice.appliance->detergent = comp_selection<item_comp>{from, item_comp( itype_id( "detergent" ), 5 )};
    }
    return choice;
}

void add_dirty_cargo( vehicle &target, int part, const itype_id &type = itype_id( "tshirt" ) )
{
    item cargo( type, calendar::turn );
    cargo.set_flag( flag_FILTHY );
    cargo.set_age( 30_minutes );
    REQUIRE( target.add_item( get_map(), target.part( part ), cargo ) );
}
} // namespace

TEST_CASE( "owned_washer_uses_operator_supplies_and_never_duplicates_start_costs",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    auto &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "washing_machine" );
    fill_appliance_water( target );
    add_dirty_cargo( target, machine );
    who.i_add( item( itype_id( "detergent" ), calendar::turn, 10 ) );
    // Adding supplies can wield them and spend the fixture's initial moves.
    who.set_moves( 100 );
    get_avatar().i_add( item( itype_id( "detergent" ), calendar::turn, 20 ) );
    const auto rng = rng_get_engine();
    const auto query = query_vehicle_appliance( who, get_map(), target,
                       target.abs_part_pos( target.part( machine ) ), target.part( machine ).get_base().uid().get_value() );
    REQUIRE( query );
    REQUIRE( query->appliance );
    REQUIRE( query->appliance->detergent );
    REQUIRE( valid_vehicle_appliance_selection( who, get_map(), target, query->position, *query->appliance ) );
    CHECK_FALSE( target.part( machine ).enabled );
    CHECK( target.fuel_left( get_map(), itype_id( "water" ) ) == 100 );
    CHECK( who.charges_of( itype_id( "detergent" ) ) == 10 );
    CHECK( rng_get_engine() == rng );
    const auto request = control_request( fixture, who, *query );
    fixture.run( who, request );
    CHECK( target.part( machine ).enabled );
    CHECK( target.get_items( target.part( machine ) ).only_item().age() == 0_turns );
    CHECK( target.fuel_left( get_map(), itype_id( "water" ) ) == 76 );
    CHECK( who.charges_of( itype_id( "detergent" ) ) == 5 );
    CHECK( get_avatar().charges_of( itype_id( "detergent" ) ) == 20 );
    CHECK_FALSE( recipient.feedback.pending.empty() );
    fixture.run( who, request );
    // A new request with the same desired state is also a harmless no-op.
    fixture.run( who, control_request( fixture, who, *query ) );
    CHECK( target.fuel_left( get_map(), itype_id( "water" ) ) == 76 );
    CHECK( who.charges_of( itype_id( "detergent" ) ) == 5 );
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, false ) ) );
    CHECK_FALSE( target.part( machine ).enabled );
    CHECK( who.charges_of( itype_id( "detergent" ) ) == 5 );
}

TEST_CASE( "owned_washer_rejects_forged_or_stale_choices_without_consuming_resources",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "washing_machine" );
    fill_appliance_water( target );
    add_dirty_cargo( target, machine );
    who.i_add( item( itype_id( "detergent" ), calendar::turn, 5 ) );
    // Adding supplies can wield them and spend the fixture's initial moves.
    who.set_moves( 100 );
    get_avatar().i_add( item( itype_id( "detergent" ), calendar::turn, 20 ) );
    auto choice = appliance_choice( who, target, machine, true, true );
    SECTION( "only the host has detergent" ) {
        who.use_charges( itype_id( "detergent" ), 5 );
    }
    SECTION( "wrong quantity" ) {
        choice.appliance->detergent->comp.count = 0;
    }
    SECTION( "wrong material" ) {
        choice.appliance->detergent->comp.type = itype_id( "water" );
    }
    SECTION( "invalid source" ) {
        choice.appliance->detergent->use_from = usage_from::none;
    }
    SECTION( "operator left" ) {
        who.setpos( get_map(), tripoint_bub_ms( 100, 100, 0 ) );
    }
    SECTION( "operator has no moves" ) {
        who.set_moves( 0 );
    }
    SECTION( "locked vehicle" ) {
        target.is_locked = true;
    }
    SECTION( "replacement machine" ) {
        const point_rel_ms mount = target.part( machine ).mount;
        target.remove_part( target.part( machine ) );
        REQUIRE( target.install_part( get_map(), mount, vpart_id( "washing_machine" ) ) >= 0 );
    }
    const int detergent = who.charges_of( itype_id( "detergent" ) );
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK_FALSE( target.part( machine ).enabled );
    CHECK( target.fuel_left( get_map(), itype_id( "water" ) ) == 100 );
    CHECK( who.charges_of( itype_id( "detergent" ) ) == detergent );
    CHECK( get_avatar().charges_of( itype_id( "detergent" ) ) == 20 );
}

TEST_CASE( "owned_dishwasher_preserves_content_rules_and_mixed_source_selection",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "dishwasher" );
    fill_appliance_water( target, itype_id( "water_clean" ) );
    const bool soft = GENERATE( false, true );
    add_dirty_cargo( target, machine, itype_id( soft ? "tshirt" : "bio_power_storage" ) );
    who.i_add( item( itype_id( "detergent" ), calendar::turn, 2 ) );
    // Adding supplies can wield them and spend the fixture's initial moves.
    who.set_moves( 100 );
    get_map().add_item_or_charges( who.pos_bub(), item( itype_id( "detergent" ), calendar::turn, 3 ) );
    fixture.run( who, control_request( fixture, who,
                                      appliance_choice( who, target, machine, true, true, usage_from::both ) ) );
    CHECK( target.part( machine ).enabled == !soft );
    CHECK( target.fuel_left( get_map(), itype_id( "water_clean" ) ) == ( soft ? 100 : 76 ) );
    CHECK( who.charges_of( itype_id( "detergent" ) ) == ( soft ? 2 : 0 ) );
    CHECK( get_map().i_at( who.pos_bub() ).empty() == !soft );
}

TEST_CASE( "owned_autoclave_preserves_sterilization_preconditions",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "autoclave" );
    fill_appliance_water( target );
    item cbm( itype_id( "bio_power_storage" ), calendar::turn );
    cbm.unset_flag( flag_FILTHY );
    cbm.unset_flag( flag_id( "NO_PACKED" ) );
    cbm.set_age( 30_minutes );
    bool valid = true;
    SECTION( "packed CBM" ) {}
    SECTION( "unpacked CBM" ) {
        cbm.set_flag( flag_id( "NO_PACKED" ) );
        valid = false;
    }
    SECTION( "filthy CBM" ) {
        cbm.set_flag( flag_FILTHY );
        valid = false;
    }
    REQUIRE( target.add_item( get_map(), target.part( machine ), cbm ) );
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, true ) ) );
    CHECK( target.part( machine ).enabled == valid );
    CHECK( target.fuel_left( get_map(), itype_id( "water" ) ) == ( valid ? 92 : 100 ) );
    CHECK( target.get_items( target.part( machine ) ).only_item().age() == ( valid ? 0_turns : 30_minutes ) );
}

TEST_CASE( "owned_cooker_checks_power_and_resets_nested_food_progress",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "app_electric_cooker" );
    item food( itype_id( "meat" ), calendar::turn );
    food.set_var( "cook_energy_done", "123" );
    item jar( itype_id( "jar_glass_sealed" ), calendar::turn );
    REQUIRE( jar.put_in( food, pocket_type::CONTAINER ).success() );
    REQUIRE( target.add_item( get_map(), target.part( machine ), jar ) );
    const bool powered = GENERATE( false, true );
    if( !powered ) {
        target.discharge_battery( get_map(), target.fuel_left( get_map(), itype_id( "battery" ) ) );
    }
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, true ) ) );
    CHECK( target.part( machine ).enabled == powered );
    const item &stored = target.get_items( target.part( machine ) ).only_item();
    const item *raw = stored.all_items_top( pocket_type::CONTAINER ).front();
    CHECK( raw->get_var( "cook_energy_done" ) == ( powered ? "0" : "123" ) );
}

TEST_CASE( "owned_weather_station_start_and_cancel_reuse_native_timer",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "veh_mobile_weather_station" );
    const auto start = control_request( fixture, who, appliance_choice( who, target, machine, true ) );
    fixture.run( who, start );
    CHECK( target.part( machine ).enabled );
    REQUIRE( target.get_items( target.part( machine ) ).size() == 1 );
    CHECK( target.get_items( target.part( machine ) ).only_item().typeId() == itype_id( "mws_weather_data_incomplete" ) );
    CHECK( target.get_items( target.part( machine ) ).only_item().age() == 0_turns );
    fixture.run( who, start );
    CHECK( target.get_items( target.part( machine ) ).size() == 1 );
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, false ) ) );
    CHECK_FALSE( target.part( machine ).enabled );
}

TEST_CASE( "owned_boiler_outside_its_dimension_never_destroys_cargo",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "ap_nl_safehouse_boiler" );
    REQUIRE( target.add_item( get_map(), target.part( machine ), item( itype_id( "rock" ), calendar::turn ) ) );
    const int battery = target.fuel_left( get_map(), itype_id( "battery" ) );
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, true ) ) );
    CHECK( target.get_items( target.part( machine ) ).size() == 1 );
    CHECK( target.fuel_left( get_map(), itype_id( "battery" ) ) == battery );
}

TEST_CASE( "native_appliance_callback_uses_owned_command_and_stable_hardware_identity",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    avatar &who = get_avatar();
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "washing_machine" );
    fill_appliance_water( target );
    add_dirty_cargo( target, machine );
    who.i_add( item( itype_id( "detergent" ), calendar::turn, 10 ) );
    // Adding supplies can wield them and spend the fixture's initial moves.
    who.set_moves( 100 );
    veh_menu menu( target, "appliances" );
    add_vehicle_appliance_menu( menu, get_map(), target, target.abs_part_pos( target.part( machine ) ) );
    const auto entries = menu.get_items();
    REQUIRE( entries.size() == 1 );
    CHECK_FALSE( target.part( machine ).enabled );
    const bool removed = GENERATE( false, true );
    if( removed ) {
        target.remove_part( target.part( machine ) );
    }
    entries.front()._on_submit();
    CHECK( who.charges_of( itype_id( "detergent" ) ) == ( removed ? 10 : 5 ) );
    CHECK( target.fuel_left( get_map(), itype_id( "water" ) ) == ( removed ? 100 : 76 ) );
}
