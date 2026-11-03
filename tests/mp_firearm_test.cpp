#include "cata_catch.h"

#include <sstream>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "creature_tracker.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "game_constants.h"
#include "gun_mode.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "monster.h"
#include "mp_client_conn.h"
#include "mp_combat_result.h"
#include "mp_firearm.h"
#include "mp_gamestate.h"
#include "mp_queue.h"
#include "mp_test_helpers.h"
#include "npc.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "ranged.h"
#include "ranged_actions.h"
#include "rng.h"
#include "skill.h"

namespace
{
class firearm_events : public event_subscriber
{
    public:
        int starts = 0;
        int finishes = 0;

        firearm_events() {
            get_event_bus().subscribe( this );
        }
        void notify( const cata::event &event ) override {
            if( event.type() == event_type::character_starts_activity ) {
                ++starts;
            } else if( event.type() == event_type::character_finished_activity ) {
                ++finishes;
            }
        }
};

void arm_firearm_shooter( Character &actor, const tripoint_bub_ms &position )
{
    clear_character( actor, true );
    actor.setpos( get_map(), position );
    item pistol( itype_id( "glock_19" ) );
    pistol.ammo_set( itype_id( "9mm" ), 15 );
    actor.set_wielded_item( pistol );
    REQUIRE( actor.get_wielded_item()->ammo_remaining() == 15 );
    actor.set_skill_level( skill_id( "gun" ), 5 );
    actor.set_skill_level( skill_id( "pistol" ), 5 );
    actor.set_moves( 1000 );
    actor.recoil = 3000;
}

class firearm_fixture
{
    public:
        restore_on_out_of_scope<time_point> time{ calendar::turn };
        restore_on_out_of_scope<cata_default_random_engine> rng{ rng_get_engine() };

        firearm_fixture() {
            clear_avatar();
            clear_map();
            g->multiplayer_session().reset();
            calendar::turn = calendar::turn_zero + 12_hours;
            get_avatar().setpos( get_map(), tripoint_bub_ms( 90, 90, 0 ) );
        }
        ~firearm_fixture() {
            g->multiplayer_session().reset();
            cata_mp::get_mp_queue().clear();
            clear_npcs();
            get_creature_tracker().clear();
            clear_avatar();
        }
        npc &remote() {
            npc &actor = spawn_npc( { 60, 60 }, "test_talker" );
            arm_firearm_shooter( actor, tripoint_bub_ms( 60, 60, 0 ) );
            const cata_mp::player_id owner( std::string( 32, '7' ) );
            actor.set_value( "mp_proxy", std::string( "1" ) );
            actor.set_value( "mp_player_id", owner.str() );
            auto &peer = make_test_remote( g->multiplayer_session() );
            peer.actor.bind_player( actor, owner, g->npc_lifetimes(),
                                    g->player_controls().claim( owner, actor ) );
            peer.connected = true;
            peer.turn.remote_moves = 1000;
            peer.turn.granted_this_turn = true;
            actor.set_stamina( actor.get_stamina_max() );
            return actor;
        }
};
} // namespace

TEST_CASE( "firearm_intent_matches_native_aim_ammo_damage_and_rng", "[multiplayer][firearm]" )
{
    firearm_fixture fixture;
    npc &actor = fixture.remote();
    npc &reference = spawn_npc( { 60, 80 }, "test_talker" );
    arm_firearm_shooter( reference, tripoint_bub_ms( 60, 80, 0 ) );
    const auto control = g->player_controls().claim(
                             cata_mp::player_id( std::string( 32, '8' ) ), reference );
    reference.set_stamina( reference.get_stamina_max() );
    auto first = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                                            tripoint_bub_ms( 65, 60, 0 ) );
    first->set_hp( 1000 );
    auto second = make_shared_fast<monster>( *first );
    second->spawn( tripoint_bub_ms( 65, 80, 0 ) );
    REQUIRE( get_creature_tracker().add( first ) );
    REQUIRE( get_creature_tracker().add( second ) );
    get_map().build_map_cache( 0 );
    actor.last_target_pos = first->pos_abs();
    reference.last_target_pos = second->pos_abs();
    reference.last_target = second;
    std::string action = "FIRE";
    SECTION( "immediate_shot" ) {}
    SECTION( "precise_aim_and_shot" ) {
        action = "PRECISE_SHOT";
    }
    const auto before = rng_get_engine();
    item &gun = *reference.get_wielded_item();
    REQUIRE( prepare_gun_to_fire( reference, gun ) );
    get_event_bus().send<event_type::character_starts_activity>(
        reference.getID(), activity_id( "ACT_AIM" ), false );
    aim_gun_for_moves( reference, gun, second->pos_bub(), 10 );
    if( action != "FIRE" ) {
        REQUIRE( aim_gun_until_threshold( reference, gun, second->pos_bub(), action ) );
    }
    mark_ranged_target( reference, true );
    get_event_bus().send<event_type::character_finished_activity>(
        reference.getID(), activity_id( "ACT_AIM" ), false );
    REQUIRE( reference.fire_gun( get_map(), second->pos_bub(), 1, gun, item_location() ) == 1 );
    const auto expected_rng = rng_get_engine();
    rng_get_engine() = before;
    cata_mp::firearm_state state;
    cata_mp::firearm_intent intent;
    intent.weapon = actor.get_wielded_item()->uid().get_value();
    intent.mode = actor.get_wielded_item()->gun_get_mode_id();
    intent.origin = actor.pos_abs();
    intent.target = first->pos_abs();
    intent.action = "prepare";
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    intent.action = "AIM";
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    intent.action = action;
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::finished );
    CHECK( first->get_hp() == second->get_hp() );
    CHECK( actor.get_moves() == reference.get_moves() );
    CHECK( actor.recoil == Approx( reference.recoil ) );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 14 );
    CHECK( actor.get_skill_level_object( skill_id( "gun" ) ).exercise( true ) ==
           reference.get_skill_level_object( skill_id( "gun" ) ).exercise( true ) );
    CHECK( rng_get_engine() == expected_rng );
}

TEST_CASE( "firearm_queue_rejects_wrong_weapon_and_duplicate_shots", "[multiplayer][firearm]" )
{
    firearm_fixture fixture;
    npc &actor = fixture.remote();
    auto &peer = only_test_remote( g->multiplayer_session() );
    const auto weapon = actor.get_wielded_item()->uid().get_value();
    const auto packet = [&]( const std::string & action, uint64_t id ) {
        std::ostringstream text;
        JsonOut out( text );
        out.start_object();
        out.member( "action", "firearm" );
        out.member( "operation", action );
        out.member( "weapon", id );
        out.member( "mode", actor.get_wielded_item()->gun_get_mode_id() );
        out.member( "origin", actor.pos_abs() );
        out.member( "target", get_map().get_abs( tripoint_bub_ms( 65, 60, 0 ) ) );
        out.member( "grant_seq", peer.turn.grant_seq );
        out.member( "inventory_revision", peer.pickup.revision );
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
    const auto before = rng_get_engine();
    firearm_events events;
    send( packet( "prepare", weapon + 100 ) );
    CHECK( peer.firearm.weapon == 0 );
    CHECK( peer.turn.remote_moves == 1000 );
    CHECK( rng_get_engine() == before );
    send( packet( "prepare", weapon ) );
    REQUIRE( peer.firearm.weapon == weapon );
    send( packet( "AIM", weapon ) );
    CHECK( peer.turn.remote_moves < 1000 );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 15 );
    const int aim_moves = peer.turn.remote_moves;
    send( packet( "DROP_AIM", weapon ) );
    CHECK( actor.recoil == MAX_RECOIL );
    CHECK( peer.turn.remote_moves == aim_moves );
    const std::string shot = packet( "FIRE", weapon );
    send( shot );
    REQUIRE( actor.get_wielded_item()->ammo_remaining() == 14 );
    CHECK( actor.get_str_base() == 8 );
    const int moves = peer.turn.remote_moves;
    const auto after = rng_get_engine();
    send( shot );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 14 );
    CHECK( peer.turn.remote_moves == moves );
    CHECK( rng_get_engine() == after );
    CHECK( events.starts == 1 );
    CHECK( events.finishes == 1 );
    actor.set_moves( 1000 );
    peer.turn.remote_moves = 1000;
    peer.turn.client_acted_this_turn = false;
    send( packet( "prepare", weapon ) );
    const std::string canceled = R"({"type":"action","action":"activity_end","activity_id":"ACT_AIM"})";
    send( canceled );
    CHECK( peer.firearm.weapon == 0 );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 14 );
    CHECK( events.starts == 2 );
    CHECK( events.finishes == 2 );
    const auto after_cancel = rng_get_engine();
    send( canceled );
    CHECK( events.finishes == 2 );
    CHECK( rng_get_engine() == after_cancel );
}

TEST_CASE( "client_firearm_result_finishes_view_without_firing_again", "[multiplayer][firearm]" )
{
    firearm_fixture fixture;
    const override_option no_repeat( "AIM_AFTER_FIRING", "false" );
    avatar &actor = get_avatar();
    arm_firearm_shooter( actor, tripoint_bub_ms( 60, 60, 0 ) );
    cata_mp::set_client_mode( true );
    firearm_events events;
    const auto before = rng_get_engine();
    actor.assign_activity( aim_activity_actor::use_wielded() );
    CHECK( cata_mp::client_firearm_phase() == cata_mp::firearm_view_phase::pending );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 15 );
    CHECK( rng_get_engine() == before );
    const auto id = actor.get_wielded_item()->uid().get_value();
    // Host reconstruction carries the same gun identity, with one round spent.
    npc &host = spawn_npc( { 60, 80 }, "test_talker" );
    std::ostringstream carried;
    JsonOut carried_out( carried );
    actor.store_carried_items( carried_out );
    JsonValue carried_value = json_loader::from_string( carried.str() );
    host.load_carried_items( carried_value.get_object() );
    host.get_wielded_item()->ammo_set( itype_id( "9mm" ), 14 );
    cata_mp::pickup_host_state inventory;
    const std::string combat = cata_mp::make_combat_result( host, inventory );
    const std::string wire = "{\"type\":\"firearm_result\",\"weapon\":" + std::to_string( id ) +
                             ",\"outcome\":2,\"inventory_revision\":1,\"recoil\":500,\"combat\":" + combat + "}";
    const auto before_apply = rng_get_engine();
    REQUIRE( cata_mp::client_apply_message( wire ) );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 14 );
    CHECK( actor.get_wielded_item()->uid().get_value() == id );
    REQUIRE( actor.get_moves() == 0 );
    cata_mp::client_finish_ready_firearm_activity();
    CHECK_FALSE( actor.activity );
    CHECK( cata_mp::client_firearm_phase() == cata_mp::firearm_view_phase::inactive );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 14 );
    CHECK( rng_get_engine() == before_apply );
    REQUIRE( cata_mp::client_apply_message( wire ) );
    CHECK_FALSE( actor.activity );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 14 );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
}

TEST_CASE( "client_firearm_cancellation_does_not_replay_gameplay_events",
           "[multiplayer][firearm]" )
{
    firearm_fixture fixture;
    avatar &actor = get_avatar();
    arm_firearm_shooter( actor, tripoint_bub_ms( 60, 60, 0 ) );
    cata_mp::set_client_mode( true );
    firearm_events events;
    const auto before = rng_get_engine();
    actor.assign_activity( aim_activity_actor::use_wielded() );
    actor.cancel_activity();
    CHECK_FALSE( actor.activity );
    CHECK( cata_mp::client_firearm_phase() == cata_mp::firearm_view_phase::inactive );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
    CHECK( rng_get_engine() == before );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 15 );
}
