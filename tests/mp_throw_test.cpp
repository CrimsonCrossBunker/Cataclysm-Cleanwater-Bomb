#include <cstdint>
#include <functional>
#include <list>
#include <memory>
#include <optional>
#include <random>
#include <sstream>
#include <string>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "game.h"
#include "game_constants.h"
#include "item.h"
#include "item_disposition.h"
#include "item_location.h"
#include "item_source.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "map_helpers.h"
#include "map_iterator.h"
#include "memory_fast.h"
#include "monster.h"
#include "mp_actor_binding.h"
#include "mp_admission.h"
#include "mp_client_conn.h"
#include "mp_firearm.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "mp_peek.h"
#include "mp_pickup.h"
#include "mp_player_identity.h"
#include "mp_queue.h"
#include "mp_test_helpers.h"
#include "mp_throw.h"
#include "mp_world_session.h"
#include "mp_world_state.h"
#include "npc.h"
#include "player_control.h"
#include "player_helpers.h"
#include "player_identity.h"
#include "pocket_type.h"
#include "point.h"
#include "projectile.h"
#include "ranged.h"
#include "ranged_actions.h"
#include "ret_val.h"
#include "rng.h"
#include "skill.h"
#include "sling.h"
#include "type_id.h"

static const itype_id itype_test_backpack( "test_backpack" );
static const itype_id itype_test_sling_payload( "test_sling_payload" );
static const itype_id itype_test_sling_payload_fire( "test_sling_payload_fire" );
static const itype_id itype_test_throwing_aid( "test_throwing_aid" );
static const itype_id itype_test_throwing_firestarter( "test_throwing_firestarter" );
static const itype_id itype_test_throwing_holster( "test_throwing_holster" );
static const itype_id itype_test_throwing_plain( "test_throwing_plain" );
static const itype_id itype_test_throwing_stack( "test_throwing_stack" );

static const mtype_id mon_test_zombie( "mon_test_zombie" );

static const skill_id skill_throw( "throw" );

namespace
{
void prepare_thrower( Character &who, const tripoint_bub_ms &where )
{
    clear_character( who, true );
    who.setpos( get_map(), where );
    who.set_wielded_item( item( itype_test_throwing_stack, calendar::turn, 10 ) );
    who.set_skill_level( skill_throw, 5 );
    who.set_moves( 1000 );
    who.set_stamina( who.get_stamina_max() );
}

class throw_fixture
{
    public:
        restore_on_out_of_scope<time_point> time{ calendar::turn };
        restore_on_out_of_scope<cata_default_random_engine> rng{ rng_get_engine() };

        throw_fixture() {
            clear_avatar();
            clear_map();
            g->multiplayer_session().reset();
            calendar::turn = calendar::turn_zero + 12_hours;
            get_avatar().setpos( get_map(), tripoint_bub_ms( 90, 90, 0 ) );
        }
        ~throw_fixture() {
            g->multiplayer_session().reset();
            cata_mp::get_mp_queue().clear();
            clear_npcs();
            get_creature_tracker().clear();
            clear_avatar();
        }
        npc &remote() {
            npc &who = spawn_npc( { 60, 60 }, "test_throwing_npc" );
            prepare_thrower( who, tripoint_bub_ms( 60, 60, 0 ) );
            const cata_mp::player_id owner( std::string( 32, '7' ) );
            who.set_value( "mp_proxy", std::string( "1" ) );
            who.set_value( "mp_player_id", owner.str() );
            cata_mp::remote_player_session &peer = make_test_remote( g->multiplayer_session() );
            peer.actor.bind_player( who, owner, g->npc_lifetimes(),
                                    g->player_controls().claim( owner, who ) );
            peer.connected = true;
            peer.turn.remote_moves = 1000;
            peer.turn.granted_this_turn = true;
            who.set_stamina( who.get_stamina_max() );
            return who;
        }
};

item_location add_projectile_to_backpack( Character &who,
        const itype_id &ammo = itype_test_throwing_stack )
{
    const auto worn = who.wear_item( item( itype_test_backpack ), false );
    REQUIRE( worn );
    item_location backpack( who, & **worn );
    const auto inserted = backpack->put_in( item( ammo, calendar::turn, 5 ),
                                            pocket_type::CONTAINER );
    REQUIRE( inserted.success() );
    REQUIRE( backpack->all_items_top().size() == 1 );
    return item_location( backpack, backpack->all_items_top().front() );
}
} // namespace

TEST_CASE( "authoritative_throw_matches_native_damage_cost_and_rng", "[multiplayer][throw]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    avatar &reference = get_avatar();
    prepare_thrower( reference, tripoint_bub_ms( 60, 80, 0 ) );
    REQUIRE( who.get_cardiofit() == reference.get_cardiofit() );
    REQUIRE( who.get_stamina_max() == reference.get_stamina_max() );
    auto victim = make_shared_fast<monster>( mon_test_zombie,
                  tripoint_bub_ms( 65, 60, 0 ) );
    victim->set_hp( 1000 );
    auto expected_victim = make_shared_fast<monster>( *victim );
    expected_victim->spawn( tripoint_bub_ms( 65, 80, 0 ) );
    REQUIRE( get_creature_tracker().add( victim ) );
    REQUIRE( get_creature_tracker().add( expected_victim ) );
    get_map().build_map_cache( 0 );
    cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, who.get_wielded_item() );
    intent.target = victim->pos_abs();
    std::optional<tripoint_bub_ms> blind;
    SECTION( "normal" ) {}
    SECTION( "blind_around_corner" ) {
        intent.blind_from = get_map().get_abs( tripoint_bub_ms( 61, 60, 0 ) );
        blind = tripoint_bub_ms( 61, 80, 0 );
    }
    const cata_default_random_engine before =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    if( blind ) {
        reference.mod_moves( -reference.get_speed() * 2 );
    }
    reference.last_target = expected_victim;
    reference.last_target_pos = expected_victim->pos_abs();
    mark_ranged_target( reference, true );
    item thrown = *reference.get_wielded_item();
    reference.get_wielded_item()->mod_charges( -1 );
    thrown.charges = 1;
    reference.throw_item( expected_victim->pos_bub(), thrown, blind );
    const cata_default_random_engine expected_rng =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    rng_get_engine() = before;
    REQUIRE( cata_mp::execute_throw_intent( who, get_map(), intent ) );
    CHECK( who.get_wielded_item()->charges == 9 );
    CHECK( who.get_moves() == reference.get_moves() );
    CHECK( who.get_stamina() == reference.get_stamina() );
    CHECK( who.get_skill_level_object( skill_throw ).exercise( true ) ==
           reference.get_skill_level_object( skill_throw ).exercise( true ) );
    CHECK( victim->get_hp() == expected_victim->get_hp() );
    CHECK( rng_get_engine() == expected_rng );
}

TEST_CASE( "throw_preparation_uses_selected_disposal_and_keeps_cancel_cost",
           "[multiplayer][throw]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_test_throwing_plain ) );
    item_location source = add_projectile_to_backpack( who );
    cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, source );
    intent.disposition = item_disposition{ "drop", 0, 0 };
    const int before_moves = who.get_moves();
    const int retrieve_cost = who.item_handling_cost( *source, true, INVENTORY_HANDLING_PENALTY );
    // No target represents canceling the targeting UI after choosing preparation.
    CHECK_FALSE( cata_mp::execute_throw_intent( who, get_map(), intent ) );
    REQUIRE( who.get_wielded_item() );
    CHECK( who.get_wielded_item()->typeId() == itype_test_throwing_stack );
    CHECK( who.get_wielded_item()->charges == 5 );
    CHECK( who.get_moves() == before_moves - retrieve_cost );
    CHECK( who.items_with( []( const item & it ) {
        return it.typeId() == itype_test_throwing_stack;
    } ).size() == 1 );
    REQUIRE( get_map().i_at( who.pos_bub() ).size() == 1 );
    CHECK( get_map().i_at( who.pos_bub() ).begin()->typeId() == itype_test_throwing_plain );
}

TEST_CASE( "throwing_a_map_item_removes_the_source_without_creating_a_copy",
           "[multiplayer][throw]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    who.remove_weapon();
    map &here = get_map();
    item_location source = here.add_item_or_charges_ret_loc( who.pos_bub(),
                           item( itype_test_throwing_stack, calendar::turn, 5 ) );
    cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, source );
    intent.target = here.get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    REQUIRE( cata_mp::execute_throw_intent( who, here, intent ) );
    REQUIRE( who.get_wielded_item() );
    int charges = who.get_wielded_item()->charges;
    CHECK( charges == 4 );
    for( const tripoint_bub_ms &point : here.points_in_radius( who.pos_bub(), 8 ) ) {
        for( const item &it : here.i_at( point ) ) {
            if( it.typeId() == itype_test_throwing_stack ) {
                charges += it.charges;
            }
        }
    }
    CHECK( charges == 5 );
}

TEST_CASE( "sling_throw_resolves_nested_projectile_without_stowing_the_aid",
           "[multiplayer][throw]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_test_throwing_aid ) );
    const int64_t aid = who.get_wielded_item()->uid().get_value();
    item_location source = add_projectile_to_backpack( who );
    cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, source );
    REQUIRE( intent.item.path.size() == 2 );
    intent.target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    REQUIRE( cata_mp::execute_throw_intent( who, get_map(), intent ) );
    CHECK( who.get_wielded_item()->uid().get_value() == aid );
    CHECK( source->charges == 4 );
    CHECK( who.get_moves() < 1000 );
}

TEST_CASE( "item_disposition_resolves_identity_and_rejects_missing_destinations",
           "[multiplayer][throw][inventory]" )
{
    throw_fixture fixture;
    avatar &who = get_avatar();
    prepare_thrower( who, tripoint_bub_ms( 60, 60, 0 ) );
    who.set_wielded_item( item( itype_test_throwing_plain ) );
    const auto worn = who.wear_item( item( itype_test_throwing_holster ), false );
    REQUIRE( worn );
    item &holster = **worn;
    const item_disposition choice{ "holster", holster.uid().get_value(), 0 };
    item_disposition stale = choice;
    ++stale.container;
    const int moves = who.get_moves();
    CHECK_FALSE( execute_item_disposition( who, who.get_wielded_item(), stale ) );
    CHECK( who.get_moves() == moves );
    REQUIRE( who.get_wielded_item() );
    REQUIRE( execute_item_disposition( who, who.get_wielded_item(), choice ) );
    CHECK_FALSE( who.get_wielded_item() );
    CHECK( holster.has_item_with( []( const item & it ) {
        return it.typeId() == itype_test_throwing_plain;
    } ) );
}

TEST_CASE( "throw_request_rejects_stale_sources_and_duplicates_before_client_mutations",
           "[multiplayer][throw][sling]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    const bool sling = GENERATE( false, true );
    item_location ammo = who.get_wielded_item();
    if( sling ) {
        who.set_wielded_item( item( itype_test_throwing_aid ) );
        ammo = add_projectile_to_backpack( who, itype_test_sling_payload );
    }
    const int count = ammo->charges;
    cata_mp::remote_player_session &peer = only_test_remote( g->multiplayer_session() );
    cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, ammo );
    const tripoint_abs_ms target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    const auto packet = [&]( int64_t uid ) {
        std::ostringstream text;
        JsonOut out( text );
        out.start_object();
        out.member( "type", "action" );
        out.member( "action", "throw" );
        out.member( "method", sling ? "sling" : "hand" );
        out.member( "origin", intent.origin );
        out.member( "target", target );
        out.member( "blind_from", std::optional<tripoint_abs_ms>() );
        out.member( "source", "carried" );
        out.member( "source_position", intent.item.position );
        auto path = intent.item.path;
        path.back() = uid;
        out.member( "path", path );
        out.member( "wielded", intent.wielded );
        out.member( "inventory_revision", peer.pickup.revision );
        out.member( "grant_seq", peer.turn.grant_seq );
        out.member( "char_stats" );
        out.start_object();
        out.member( "str", 999 );
        out.end_object();
        out.end_object();
        return text.str();
    };
    const auto send = [&]( const std::string & wire ) {
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player", wire, peer.admission } ) );
        cata_mp::process_mp_events();
    };
    if( sling ) {
        cata_mp::firearm_intent prepare;
        prepare.action = "prepare";
        prepare.weapon = intent.wielded;
        prepare.origin = who.pos_abs();
        REQUIRE( cata_mp::execute_firearm_intent( who, get_map(), peer.firearm, prepare ) ==
                 cata_mp::firearm_outcome::aiming );
    }
    const cata_default_random_engine before =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    send( packet( intent.item.path.back() + 100 ) );
    CHECK( ammo->charges == count );
    CHECK( rng_get_engine() == before );
    const std::string wire = packet( intent.item.path.back() );
    send( wire );
    REQUIRE( ammo->charges == count - 1 );
    CHECK( who.get_str_base() == 8 );
    const int moves = peer.turn.remote_moves;
    const cata_default_random_engine after =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    send( wire );
    CHECK( ammo->charges == count - 1 );
    CHECK( peer.turn.remote_moves == moves );
    CHECK( rng_get_engine() == after );
}

TEST_CASE( "client_throw_request_keeps_inventory_and_gameplay_rng_untouched",
           "[multiplayer][throw][sling]" )
{
    throw_fixture fixture;
    avatar &who = get_avatar();
    prepare_thrower( who, tripoint_bub_ms( 60, 60, 0 ) );
    const bool sling = GENERATE( false, true );
    item_location ammo = who.get_wielded_item();
    if( sling ) {
        who.set_wielded_item( item( itype_test_throwing_aid ) );
        ammo = add_projectile_to_backpack( who, itype_test_sling_payload );
    }
    const int count = ammo->charges;
    cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, ammo );
    intent.method = sling ? cata_mp::throw_method::sling : cata_mp::throw_method::hand;
    intent.target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    const int64_t uid = who.get_wielded_item()->uid().get_value();
    const cata_default_random_engine before =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    cata_mp::set_client_mode( true );
    if( sling ) {
        REQUIRE( can_launch_sling( who, ammo ).success() );
        CHECK( rng_get_engine() == before );
    }
    cata_mp::client_request_throw( intent );
    CHECK( who.get_wielded_item()->uid().get_value() == uid );
    CHECK( ammo->charges == count );
    CHECK_FALSE( ammo->active );
    CHECK( who.get_moves() == 0 );
    CHECK( rng_get_engine() == before );
    CHECK( cata_mp::is_client_waiting_for_ack() );
}

TEST_CASE( "authoritative_sling_matches_native_ignition_damage_cost_and_rng",
           "[multiplayer][sling]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    avatar &reference = get_avatar();
    prepare_thrower( reference, tripoint_bub_ms( 60, 80, 0 ) );
    const itype_id ammo_id( GENERATE( "test_sling_payload", "test_sling_payload_fire" ) );
    who.set_wielded_item( item( itype_test_throwing_aid ) );
    reference.set_wielded_item( item( itype_test_throwing_aid ) );
    item_location ammo = add_projectile_to_backpack( who, ammo_id );
    item_location reference_ammo = add_projectile_to_backpack( reference, ammo_id );
    item_location lighter = who.i_add( tool_with_ammo( itype_test_throwing_firestarter,
                                       100 ) );
    item_location reference_lighter = reference.i_add( tool_with_ammo(
                                          itype_test_throwing_firestarter, 100 ) );
    REQUIRE( can_launch_sling( who, ammo ).success() );
    REQUIRE( can_launch_sling( reference, reference_ammo ).success() );
    who.set_moves( 1000 );
    reference.set_moves( 1000 );
    auto victim = make_shared_fast<monster>( mon_test_zombie,
                  tripoint_bub_ms( 65, 60, 0 ) );
    victim->set_hp( 1000 );
    auto expected_victim = make_shared_fast<monster>( *victim );
    expected_victim->spawn( tripoint_bub_ms( 65, 80, 0 ) );
    REQUIRE( get_creature_tracker().add( victim ) );
    REQUIRE( get_creature_tracker().add( expected_victim ) );
    get_map().build_map_cache( 0 );
    cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, ammo );
    intent.method = cata_mp::throw_method::sling;
    intent.target = victim->pos_abs();
    const int64_t weapon_uid = who.get_wielded_item()->uid().get_value();
    const cata_default_random_engine before =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    reference.last_target = expected_victim;
    reference.last_target_pos = expected_victim->pos_abs();
    mark_ranged_target( reference, true );
    const auto expected = launch_sling( reference, reference_ammo, expected_victim->pos_bub() );
    REQUIRE( expected );
    const cata_default_random_engine expected_rng =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    rng_get_engine() = before;
    REQUIRE( cata_mp::execute_throw_intent( who, get_map(), intent ) );
    REQUIRE( ammo );
    CHECK( ammo->charges == 4 );
    CHECK_FALSE( ammo->active );
    CHECK( who.get_wielded_item()->uid().get_value() == weapon_uid );
    CHECK( lighter->ammo_remaining() == reference_lighter->ammo_remaining() );
    CHECK( who.get_moves() == reference.get_moves() );
    CHECK( who.get_stamina() == reference.get_stamina() );
    CHECK( who.recoil == reference.recoil );
    CHECK( who.get_skill_level_object( skill_throw ).exercise( true ) ==
           reference.get_skill_level_object( skill_throw ).exercise( true ) );
    CHECK( victim->get_hp() == expected_victim->get_hp() );
    CHECK( rng_get_engine() == expected_rng );
    const item &expected_drop = expected->proj.get_drop();
    const tripoint_bub_ms end = who.pos_bub() + ( expected->end_point - reference.pos_bub() );
    map_stack landed = get_map().i_at( end );
    REQUIRE( landed.size() == 1 );
    CHECK( landed.begin()->typeId() == expected_drop.typeId() );
    CHECK( landed.begin()->active );
    CHECK( landed.begin()->countdown_point == expected_drop.countdown_point );
}

TEST_CASE( "authoritative_sling_rejections_do_not_light_or_consume_ammo",
           "[multiplayer][sling]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_test_throwing_aid ) );
    item_location ammo = add_projectile_to_backpack( who, itype_test_sling_payload_fire );
    item_location lighter = who.i_add( tool_with_ammo( itype_test_throwing_firestarter,
                                       100 ) );
    REQUIRE( can_launch_sling( who, ammo ).success() );
    cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, ammo );
    intent.method = cata_mp::throw_method::sling;
    intent.target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    SECTION( "cancel" ) {
        intent.target.reset();
    }
    SECTION( "self" ) {
        intent.target = intent.origin;
    }
    SECTION( "out_of_range" ) {
        intent.target = get_map().get_abs( tripoint_bub_ms( 120, 60, 0 ) );
    }
    SECTION( "stale_launcher" ) {
        ++intent.wielded;
    }
    SECTION( "blind_launch_not_supported" ) {
        intent.blind_from = intent.origin;
    }
    SECTION( "missing_ignition_resource" ) {
        lighter.remove_item();
        CHECK_FALSE( can_launch_sling( who, ammo ).success() );
    }
    SECTION( "underwater" ) {
        who.set_underwater( true );
    }
    SECTION( "ground_ammunition" ) {
        item_location ground = get_map().add_item_or_charges_ret_loc( who.pos_bub(), *ammo );
        intent = cata_mp::make_throw_intent( who, ground );
        intent.method = cata_mp::throw_method::sling;
        intent.target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    }
    const int moves = who.get_moves();
    const int stamina = who.get_stamina();
    const int fuel = lighter ? lighter->ammo_remaining() : 0;
    const cata_default_random_engine before =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    CHECK_FALSE( cata_mp::execute_throw_intent( who, get_map(), intent ) );
    CHECK( ammo->charges == 5 );
    CHECK_FALSE( ammo->active );
    CHECK( who.get_moves() == moves );
    CHECK( who.get_stamina() == stamina );
    CHECK( rng_get_engine() == before );
    if( lighter ) {
        CHECK( lighter->ammo_remaining() == fuel );
    }
}

TEST_CASE( "paid_ledge_throw_uses_the_owners_view_and_only_charges_peeking_once",
           "[multiplayer][throw][peek_owned]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    const tripoint_bub_ms ledge( 61, 60, 0 );
    const tripoint_bub_ms bottom( 61, 60, -2 );
    here.ter_set( ledge, ter_id( "test_t_throwing_open_air" ) );
    here.ter_set( ledge + tripoint::below, ter_id( "test_t_throwing_open_air" ) );
    here.ter_set( bottom, ter_id( "test_t_throwing_floor" ) );
    here.ter_set( bottom + tripoint::east, ter_id( "test_t_throwing_floor" ) );
    const tripoint_abs_ms origin = who.pos_abs();
    const int moves = who.get_moves();
    const int host_moves = get_avatar().get_moves();
    const cata_default_random_engine rng =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    const auto peek = cata_mp::authorize_ledge_peek( who, here, origin, here.get_abs( ledge ), 17 );
    REQUIRE( peek );
    CHECK( peek->viewpoint == here.get_abs( bottom ) );
    CHECK( who.pos_abs() == origin );
    CHECK( who.get_moves() == moves - who.get_speed() * 2 );
    CHECK( rng_get_engine() == rng );
    cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, who.get_wielded_item() );
    intent.blind_from = peek->viewpoint;
    intent.peek_request = peek->request;
    intent.target = here.get_abs( bottom + tripoint::east );
    item projectile = *who.get_wielded_item();
    projectile.charges = 1;
    const int cost = throw_cost( who, projectile );
    SECTION( "paid_deep_view" ) {
        REQUIRE( cata_mp::execute_throw_intent( who, here, intent, &*peek ) );
        CHECK( who.get_moves() == moves - who.get_speed() * 2 - cost );
        CHECK( who.get_wielded_item()->charges == 9 );
    }
    SECTION( "permission_cannot_be_borrowed_or_redirected" ) {
        const int invalid = GENERATE( 0, 1, 2, 3, 4 );
        cata_mp::peek_authorization changed = *peek;
        if( invalid == 0 ) {
            ++intent.peek_request;
        } else if( invalid == 1 ) {
            changed.owner = get_avatar().getID();
        } else if( invalid == 2 ) {
            intent.blind_from = here.get_abs( bottom + tripoint::east );
        } else if( invalid == 3 ) {
            here.ter_set( ledge, ter_id( "test_t_throwing_floor" ) );
        } else {
            intent.peek_request = 0; // A distant throw origin needs the paid permission.
        }
        // The Catch2 section listener reseeds the game RNG on entry.
        const cata_default_random_engine before_rejected_throw =
            rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
        CHECK_FALSE( cata_mp::execute_throw_intent( who, here, intent, &changed ) );
        CHECK( who.get_moves() == moves - who.get_speed() * 2 );
        CHECK( who.get_wielded_item()->charges == 10 );
        CHECK( rng_get_engine() == before_rejected_throw );
    }
    CHECK( who.pos_abs() == origin );
    CHECK( get_avatar().get_moves() == host_moves );
}

TEST_CASE( "peek_permission_is_consumed_by_throw_and_released_without_spending_an_action",
           "[multiplayer][throw][peek_owned]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    cata_mp::remote_player_session &peer = only_test_remote( g->multiplayer_session() );
    const tripoint_bub_ms ledge( 61, 60, 0 );
    const tripoint_bub_ms bottom = ledge + tripoint::below;
    here.ter_set( ledge, ter_id( "test_t_throwing_open_air" ) );
    here.ter_set( bottom, ter_id( "test_t_throwing_floor" ) );
    here.ter_set( bottom + tripoint::east, ter_id( "test_t_throwing_floor" ) );
    peer.inventory_activity.peek = cata_mp::authorize_ledge_peek( who, here, who.pos_abs(),
                                   here.get_abs( ledge ), 29 );
    REQUIRE( peer.inventory_activity.peek );
    peer.turn.remote_moves = who.get_moves();
    const cata_mp::throw_intent intent = cata_mp::make_throw_intent( who, who.get_wielded_item() );
    const auto send = [&]( const std::string & wire ) {
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player", wire, peer.admission } ) );
        cata_mp::process_mp_events();
    };
    const auto packet = [&]() {
        std::ostringstream text;
        JsonOut out( text );
        out.start_object();
        out.member( "type", "action" );
        out.member( "action", "throw" );
        out.member( "origin", intent.origin );
        out.member( "target", here.get_abs( bottom + tripoint::east ) );
        out.member( "blind_from", here.get_abs( bottom ) );
        out.member( "peek_request", 29 );
        out.member( "source", intent.item.kind );
        out.member( "source_position", intent.item.position );
        out.member( "path", intent.item.path );
        out.member( "wielded", intent.wielded );
        out.member( "inventory_revision", peer.pickup.revision );
        out.member( "grant_seq", peer.turn.grant_seq );
        out.end_object();
        return text.str();
    };
    SECTION( "replay_cannot_reuse_a_paid_view_even_with_a_fresh_grant_and_revision" ) {
        send( packet() );
        CHECK_FALSE( peer.inventory_activity.peek );
        REQUIRE( who.get_wielded_item() );
        CHECK( who.get_wielded_item()->charges == 9 );
        next_test_remote_turn( peer );
        who.set_moves( peer.turn.remote_moves );
        const cata_default_random_engine rng =
            rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
        send( packet() );
        CHECK( who.get_wielded_item()->charges == 9 );
        CHECK( who.get_moves() == 100 );
        CHECK( rng_get_engine() == rng );
    }
    SECTION( "closed_view_cannot_be_used_and_a_stale_close_keeps_a_new_view" ) {
        const int moves = who.get_moves();
        peer.turn.granted_this_turn = false;
        send( R"({"type":"action","action":"peek_close","request":28})" );
        REQUIRE( peer.inventory_activity.peek );
        send( R"({"type":"action","action":"peek_close","request":29})" );
        CHECK_FALSE( peer.inventory_activity.peek );
        CHECK( who.get_moves() == moves );
        CHECK( peer.turn.remote_moves == moves );
        CHECK( who.get_wielded_item()->charges == 10 );
        peer.turn.granted_this_turn = true;
        send( packet() );
        CHECK( who.get_wielded_item()->charges == 10 );
        CHECK( who.get_moves() == moves );
    }
}
