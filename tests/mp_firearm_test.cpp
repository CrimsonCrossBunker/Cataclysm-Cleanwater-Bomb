#include "cata_catch.h"

#include <sstream>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "bionics.h"
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
#include "pocket_type.h"
#include "ranged.h"
#include "ranged_actions.h"
#include "rng.h"
#include "skill.h"
#include "ret_val.h"
#include "type_id.h"

namespace
{
class firearm_events : public event_subscriber
{
    public:
        using event_subscriber::notify;

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

static item_location equip_bow( Character &who )
{
    who.set_wielded_item( item( itype_id( "shortbow" ) ) );
    who.set_skill_level( skill_id( "archery" ), 5 );
    const auto worn = who.wear_item( item( itype_id( "backpack" ) ), false );
    REQUIRE( worn );
    item_location bag( who, & **worn );
    REQUIRE( bag->put_in( item( itype_id( "arrow_wood" ), calendar::turn, 5 ),
                          pocket_type::CONTAINER ).success() );
    who.set_moves( 2000 );
    who.set_stamina( who.get_stamina_max() );
    who.recoil = 3000;
    return item_location( bag, &bag->only_item() );
}

TEST_CASE( "authoritative_rpm_fire_uses_selected_burst_and_actual_round_cost",
           "[multiplayer][firearm][gun_rpm]" )
{
    firearm_fixture fixture;
    npc &actor = fixture.remote();
    const int available = GENERATE( 2, 15 );
    item pistol( itype_id( "glock_18c" ) );
    pistol.set_flag( flag_id( "NEVER_JAMS" ) );
    pistol.ammo_set( itype_id( "9mm" ), available );
    actor.set_wielded_item( pistol );
    actor.set_skill_level( skill_id( "pistol" ), MAX_SKILL );

    cata_mp::firearm_state state;
    cata_mp::firearm_intent intent;
    intent.weapon = actor.get_wielded_item()->uid().get_value();
    intent.mode = gun_mode_id( "AUTO" );
    intent.origin = actor.pos_abs();
    intent.target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    intent.action = "prepare";
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );

    const int moves = actor.get_moves();
    const int speed = actor.get_speed();
    const int rpm = actor.get_wielded_item()->gun_current_mode().rpm;
    REQUIRE( rpm > 0 );
    intent.action = "FIRE";
    for( const int invalid : {
             0, 1, 31
         } ) {
        intent.burst_rounds = invalid;
        CHECK( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
               cata_mp::firearm_outcome::rejected );
        CHECK( actor.get_moves() == moves );
        CHECK( actor.get_wielded_item()->ammo_remaining() == available );
    }

    intent.burst_rounds = 3;
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::finished );
    const int fired = available == 2 ? 2 : 3;
    CHECK( actor.get_wielded_item()->ammo_remaining() == available - fired );
    CHECK( actor.get_moves() == moves - firearm_burst_move_cost( fired, rpm, speed ) );
}

TEST_CASE( "authoritative_fixed_burst_uses_the_weapon_count_and_rate",
           "[multiplayer][firearm][gun_rpm]" )
{
    firearm_fixture fixture;
    npc &actor = fixture.remote();
    arm_shooter( actor, itype_id( "modular_m16a4" ) );
    item &rifle = *actor.get_wielded_item();
    rifle.set_flag( flag_id( "NEVER_JAMS" ) );
    actor.set_skill_level( rifle.gun_skill(), 0 );
    actor.set_moves( 1000 );

    cata_mp::firearm_state state;
    cata_mp::firearm_intent intent;
    intent.weapon = rifle.uid().get_value();
    intent.mode = gun_mode_id( "BURST" );
    intent.origin = actor.pos_abs();
    intent.target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    intent.action = "prepare";
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );

    const int ammo_before = rifle.ammo_remaining();
    REQUIRE( ammo_before >= 3 );
    const int moves_before = actor.get_moves();
    const int speed = actor.get_speed();
    intent.action = "FIRE";
    intent.burst_rounds = 7;
    CHECK( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
           cata_mp::firearm_outcome::rejected );
    CHECK( rifle.ammo_remaining() == ammo_before );
    CHECK( actor.get_moves() == moves_before );

    intent.burst_rounds = 0;
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::finished );
    CHECK( rifle.ammo_remaining() == ammo_before - 3 );
    CHECK( actor.get_moves() == moves_before - firearm_burst_move_cost( 3, 800, speed ) );
}

TEST_CASE( "authoritative_bow_matches_avatar_loading_damage_stamina_and_rng",
           "[multiplayer][firearm][archery]" )
{
    firearm_fixture fixture;
    npc &actor = fixture.remote();
    avatar &reference = get_avatar();
    arm_firearm_shooter( reference, tripoint_bub_ms( 60, 80, 0 ) );
    item_location ammo = equip_bow( actor );
    item_location reference_ammo = equip_bow( reference );
    auto first = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ), tripoint_bub_ms( 65, 60,
                                            0 ) );
    first->set_hp( 1000 );
    auto second = make_shared_fast<monster>( *first );
    second->spawn( tripoint_bub_ms( 65, 80, 0 ) );
    REQUIRE( get_creature_tracker().add( first ) );
    REQUIRE( get_creature_tracker().add( second ) );
    get_map().build_map_cache( 0 );
    actor.last_target_pos = first->pos_abs();
    reference.last_target_pos = second->pos_abs();
    reference.last_target = second;
    const bool aim_first = GENERATE( false, true );
    const auto before = rng_get_engine();
    item &gun = *reference.get_wielded_item();
    REQUIRE( prepare_gun_to_fire( reference, gun ) );
    get_event_bus().send<event_type::character_starts_activity>(
        reference.getID(), activity_id( "ACT_AIM" ), false );
    if( aim_first ) {
        aim_gun_for_moves( reference, gun, second->pos_bub(), 10 );
        REQUIRE( ready_ranged_ammo( reference, gun, reference_ammo ) );
    }
    mark_ranged_target( reference, true );
    get_event_bus().send<event_type::character_finished_activity>(
        reference.getID(), activity_id( "ACT_AIM" ), false );
    REQUIRE( reference.fire_gun( get_map(), second->pos_bub(), 1, gun,
                                 aim_first ? item_location() : reference_ammo ) == 1 );
    const auto expected_rng = rng_get_engine();
    const int reference_stamina = reference.get_stamina();
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
    intent.ammo = cata_mp::capture_item_source( actor, ammo );
    if( aim_first ) {
        intent.action = "AIM";
        REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
                 cata_mp::firearm_outcome::aiming );
        REQUIRE( actor.get_wielded_item()->ammo_remaining() == 1 );
    }
    intent.action = "FIRE";
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::finished );
    CHECK( ammo->charges == 4 );
    CHECK( actor.get_wielded_item()->ammo_remaining() == 0 );
    CHECK( first->get_hp() == second->get_hp() );
    CHECK( actor.get_moves() == reference.get_moves() );
    CHECK( actor.get_stamina() == reference_stamina );
    CHECK( reference.get_stamina() == reference_stamina ); // Remote firing must not charge the host.
    CHECK( actor.recoil == Approx( reference.recoil ) );
    CHECK( rng_get_engine() == expected_rng );
}

TEST_CASE( "bow_cancellation_preserves_selected_loaded_or_unloaded_arrow",
           "[multiplayer][firearm][archery]" )
{
    firearm_fixture fixture;
    npc &actor = fixture.remote();
    item_location ammo = equip_bow( actor );
    cata_mp::firearm_state state;
    cata_mp::firearm_intent intent;
    intent.weapon = actor.get_wielded_item()->uid().get_value();
    intent.mode = actor.get_wielded_item()->gun_get_mode_id();
    intent.origin = actor.pos_abs();
    intent.target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    intent.action = "prepare";
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    intent.action = "AIM";
    intent.ammo = cata_mp::capture_item_source( actor, ammo );
    const bool unload = GENERATE( false, true );
    REQUIRE( cata_mp::execute_firearm_intent( actor, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    REQUIRE( actor.get_wielded_item()->ammo_remaining() == 1 );
    cata_mp::finish_firearm_activity( actor, state, true, unload );
    CHECK( actor.get_wielded_item()->ammo_remaining() == ( unload ? 0 : 1 ) );
    CHECK( actor.charges_of( itype_id( "arrow_wood" ) ) +
           actor.get_wielded_item()->ammo_remaining() == 5 );
    const int moves = actor.get_moves();
    const auto before = rng_get_engine();
    cata_mp::finish_firearm_activity( actor, state, true, unload );
    CHECK( actor.get_moves() == moves );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "sling_preparation_pacification_and_cancel_use_server_state",
           "[multiplayer][firearm][sling]" )
{
    firearm_fixture fixture;
    npc &actor = fixture.remote();
    avatar &reference = get_avatar();
    arm_firearm_shooter( reference, tripoint_bub_ms( 60, 80, 0 ) );
    actor.set_wielded_item( item( itype_id( "staff_sling" ) ) );
    reference.set_wielded_item( item( itype_id( "staff_sling" ) ) );
    const bool pacified = GENERATE( false, true );
    if( pacified ) {
        actor.add_effect( efftype_id( "relax_gas" ), 10_minutes );
        reference.add_effect( efftype_id( "relax_gas" ), 10_minutes );
    }
    const auto before = rng_get_engine();
    const bool expected = reference.try_break_relax_gas( "ready", "blocked" );
    const auto expected_rng = rng_get_engine();
    rng_get_engine() = before;
    auto &peer = only_test_remote( g->multiplayer_session() );
    cata_mp::firearm_intent intent;
    intent.weapon = actor.get_wielded_item()->uid().get_value();
    intent.origin = actor.pos_abs();
    intent.action = "prepare";
    firearm_events events;
    const auto outcome = cata_mp::execute_firearm_intent( actor, get_map(), peer.firearm, intent );
    CHECK( ( outcome == cata_mp::firearm_outcome::aiming ) == expected );
    CHECK( actor.get_moves() == reference.get_moves() );
    CHECK( rng_get_engine() == expected_rng );
    peer.turn.remote_moves = actor.get_moves();
    const std::string cancel = "{\"action\":\"firearm_cancel\",\"weapon\":" +
                               std::to_string( intent.weapon ) + ",\"request\":1,\"unload_ras\":false}";
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player", cancel, peer.admission } ) );
    cata_mp::process_mp_events();
    CHECK( peer.firearm.weapon == 0 );
    CHECK( actor.get_moves() == reference.get_moves() );
    CHECK( rng_get_engine() == expected_rng );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
}

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
    int64_t sequence = 0;
    const auto packet = [&]( const std::string & action, uint64_t id ) {
        std::ostringstream text;
        JsonOut out( text );
        out.start_object();
        out.member( "action", "firearm" );
        out.member( "request", ++sequence );
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
                             ",\"request\":1,\"outcome\":2,\"inventory_revision\":1,\"recoil\":500,\"combat\":" + combat + "}";
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

namespace
{
cata_mp::firearm_intent prepare_laser_intent( Character &who )
{
    who.add_bionic( bionic_id( "bio_power_storage" ) );
    const unsigned int uid = who.add_bionic( bionic_id( "bio_laser" ) );
    who.set_max_power_level( 200_kJ );
    who.set_power_level( 200_kJ );
    who.set_moves( 1000 );
    const item *gun = cata_mp::bionic_firearm_source( who, uid );
    REQUIRE( gun );
    cata_mp::firearm_intent intent;
    intent.bionic = uid;
    intent.weapon = gun->uid().get_value();
    intent.mode = gun->gun_get_mode_id();
    intent.origin = who.pos_abs();
    intent.target = who.pos_abs() + point_rel_ms( 5, 0 );
    intent.action = "prepare";
    intent.request = 1;
    return intent;
}
} // namespace

TEST_CASE( "bionic_firearm_aim_fire_and_repeat_keep_operator_gun_and_power",
           "[multiplayer][firearm][bionic]" )
{
    firearm_fixture fixture;
    npc &who = fixture.remote();
    auto intent = prepare_laser_intent( who );
    const int64_t held = who.get_wielded_item()->uid().get_value();
    const int ammo = who.get_wielded_item()->ammo_remaining();
    const auto power = who.get_power_level();
    const auto host_power = get_avatar().get_power_level();
    const int host_moves = get_avatar().get_moves();
    cata_mp::firearm_state state;
    firearm_events events;
    REQUIRE( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    REQUIRE( state.bionic_weapon );
    CHECK( state.bionic == intent.bionic );
    CHECK( who.get_power_level() == power );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( get_avatar().activity );
    CHECK( events.starts == 1 );
    const int moves = who.get_moves();
    const auto prepared_rng = rng_get_engine();
    CHECK( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
           cata_mp::firearm_outcome::rejected );
    CHECK( who.get_moves() == moves );
    CHECK( rng_get_engine() == prepared_rng );
    CHECK( events.starts == 1 );
    intent.action = "AIM";
    intent.request = 2;
    REQUIRE( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    CHECK( who.get_moves() < moves );
    CHECK( who.get_power_level() == power );
    const auto session_gun = state.bionic_weapon;
    intent.action = "FIRE";
    intent.request = 3;
    REQUIRE( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::finished );
    CHECK( who.get_power_level() == power - 30_kJ );
    CHECK( who.get_wielded_item()->uid().get_value() == held );
    CHECK( who.get_wielded_item()->ammo_remaining() == ammo );
    CHECK( get_avatar().get_power_level() == host_power );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK_FALSE( get_avatar().activity );
    CHECK( events.finishes == 1 );
    const auto fired_rng = rng_get_engine();
    CHECK( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
           cata_mp::firearm_outcome::rejected );
    CHECK( who.get_power_level() == power - 30_kJ );
    CHECK( rng_get_engine() == fired_rng );
    intent.action = "prepare";
    intent.request = 4;
    who.set_moves( 1000 );
    REQUIRE( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    CHECK( state.bionic_weapon == session_gun );
    CHECK( events.starts == 2 );
    cata_mp::finish_firearm_activity( who, state, true );
    CHECK_FALSE( state.bionic_weapon );
    CHECK( state.bionic == 0 );
    CHECK( state.last_request == 4 );
    CHECK( events.finishes == 2 );
    CHECK( who.get_power_level() == power - 30_kJ );
}

TEST_CASE( "bionic_firearm_revalidates_installed_identity_before_effects",
           "[multiplayer][firearm][bionic]" )
{
    firearm_fixture fixture;
    npc &who = fixture.remote();
    auto intent = prepare_laser_intent( who );
    cata_mp::firearm_state state;
    REQUIRE( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    SECTION( "bionic removed" ) {
        who.remove_bionic( **who.find_bionic_by_uid( intent.bionic ) );
    }
    SECTION( "bionic shorted" ) {
        ( *who.find_bionic_by_uid( intent.bionic ) )->incapacitated_time = 1_minutes;
    }
    SECTION( "wrong installed identity" ) {
        intent.bionic += 100;
    }
    SECTION( "weapon replaced on the same bionic" ) {
        ( *who.find_bionic_by_uid( intent.bionic ) )->set_weapon( item( itype_id( "bio_laser_gun" ) ) );
    }
    SECTION( "insufficient operator energy" ) {
        who.set_power_level( 0_kJ );
    }
    const auto power = who.get_power_level();
    const int ammo = who.get_wielded_item()->ammo_remaining();
    const int moves = who.get_moves();
    const auto rng = rng_get_engine();
    intent.action = "FIRE";
    intent.request = 2;
    CHECK( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
           cata_mp::firearm_outcome::rejected );
    CHECK( who.get_power_level() == power );
    CHECK( who.get_wielded_item()->ammo_remaining() == ammo );
    CHECK( who.get_moves() == moves );
    // A native cancellation may run its completion hook; rejection must still
    // never fire or spend power. Pure identity failures have no hook to run.
    if( state.weapon != 0 ) {
        CHECK( rng_get_engine() == rng );
    }
}

TEST_CASE( "bionic_firearm_client_activation_only_opens_an_owned_aim_view",
           "[multiplayer][firearm][bionic]" )
{
    firearm_fixture fixture;
    avatar &who = get_avatar();
    arm_firearm_shooter( who, tripoint_bub_ms( 60, 60, 0 ) );
    const auto intent = prepare_laser_intent( who );
    const auto power = who.get_power_level();
    const auto held = who.get_wielded_item()->uid().get_value();
    const auto rng = rng_get_engine();
    cata_mp::set_client_mode( true );
    bool close_ui = false;
    REQUIRE( who.activate_bionic( **who.find_bionic_by_uid( intent.bionic ), false, &close_ui ) );
    CHECK( close_ui );
    auto *aim = dynamic_cast<aim_activity_actor *>( who.activity.actor.get() );
    REQUIRE( aim );
    CHECK( aim->bionic_source() == intent.bionic );
    REQUIRE( aim->get_weapon( who ) );
    CHECK( aim->get_weapon( who )->typeId() == itype_id( "bio_laser_gun" ) );
    CHECK( cata_mp::bionic_firearm_source( who, intent.bionic )->uid().get_value() == intent.weapon );
    CHECK( cata_mp::client_firearm_phase() == cata_mp::firearm_view_phase::pending );
    CHECK( g->multiplayer_session().client_firearm.bionic == intent.bionic );
    CHECK( who.get_wielded_item()->uid().get_value() == held );
    CHECK( who.get_power_level() == power );
    CHECK( rng_get_engine() == rng );
    who.cancel_activity();
    CHECK( cata_mp::client_firearm_phase() == cata_mp::firearm_view_phase::inactive );
    CHECK( who.get_power_level() == power );
    CHECK( g->multiplayer_session().client_firearm.next_request > 1 );
}

TEST_CASE( "saved_bionic_aim_resolves_its_operator_instead_of_the_avatar",
           "[multiplayer][firearm][bionic]" )
{
    firearm_fixture fixture;
    npc &who = fixture.remote();
    const auto intent = prepare_laser_intent( who );
    const item *gun = cata_mp::bionic_firearm_source( who, intent.bionic );
    REQUIRE( gun );
    player_activity activity( aim_activity_actor::use_bionic( *gun, intent.bionic ) );
    std::ostringstream encoded;
    JsonOut out( encoded );
    activity.serialize( out );
    player_activity restored;
    restored.deserialize( json_loader::from_string( encoded.str() ).get_object() );
    auto *aim = dynamic_cast<aim_activity_actor *>( restored.actor.get() );
    REQUIRE( aim );
    CHECK( aim->bionic_source() == intent.bionic );
    REQUIRE( aim->get_weapon( who ) );
    REQUIRE( aim->get_weapon( who ) );
    CHECK( aim->get_weapon( who )->typeId() == itype_id( "bio_laser_gun" ) );
    CHECK( cata_mp::bionic_firearm_source( who, intent.bionic )->uid().get_value() == intent.weapon );
    CHECK_FALSE( aim->get_weapon( get_avatar() ) );
    who.remove_bionic( **who.find_bionic_by_uid( intent.bionic ) );
    CHECK_FALSE( aim->get_weapon( who ) );
}

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_runtime_internal.h"
#include "lua_platform_test_support.h"

TEST_CASE( "bionic_firearm_activation_hook_runs_once_per_aiming_session",
           "[multiplayer][firearm][bionic][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    firearm_fixture fixture;
    npc &who = fixture.remote();
    auto intent = prepare_laser_intent( who );
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "owned_bionic_gun", 4112, lua );
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );
    lua["ccb"] = ccb;
    int activations = 0;
    const bool remove_during_hook = GENERATE( false, true );
    lua.set_function( "activated", [&]() {
        ++activations;
        if( remove_during_hook ) {
            who.remove_bionic( **who.find_bionic_by_uid( intent.bionic ) );
        }
    } );
    REQUIRE( lua.safe_script( R"lua(
ccb.runtime.handler("activated", function(context) activated() end)
ccb.runtime.hook("on_bionic_activated", "activated")
)lua", sol::script_pass_on_error ).valid() );
    cata_mp::firearm_state state;
    const auto outcome = cata_mp::execute_firearm_intent( who, get_map(), state, intent );
    CHECK( activations == 1 );
    if( remove_during_hook ) {
        CHECK( outcome == cata_mp::firearm_outcome::rejected );
        CHECK_FALSE( state.bionic_weapon );
        CHECK_FALSE( get_avatar().activity );
        CHECK( who.get_power_level() == 200_kJ );
        return;
    }
    REQUIRE( outcome == cata_mp::firearm_outcome::aiming );
    intent.action = "FIRE";
    intent.request = 2;
    REQUIRE( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::finished );
    who.set_moves( 1000 );
    intent.action = "prepare";
    intent.request = 3;
    REQUIRE( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    CHECK( activations == 1 );
    cata_mp::finish_firearm_activity( who, state, true );
    intent.request = 4;
    REQUIRE( cata_mp::execute_firearm_intent( who, get_map(), state, intent ) ==
             cata_mp::firearm_outcome::aiming );
    CHECK( activations == 2 );
}
#endif
