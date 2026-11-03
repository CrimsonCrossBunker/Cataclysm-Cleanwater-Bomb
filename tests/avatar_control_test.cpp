#include "cata_catch.h"

#include <sstream>
#include <string>
#include <utility>

#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "debug.h"
#include "game.h"
#include "json.h"
#include "map.h"
#include "map_helpers.h"
#include "mp_actor_binding.h"
#include "npc.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "player_control.h"
#include "rng.h"

namespace
{
template<typename T>
std::string saved_character( const T &actor )
{
    std::ostringstream saved;
    JsonOut out( saved );
    actor.serialize( out );
    return saved.str();
}

class control_fixture
{
    public:
        avatar previous = std::move( get_avatar() );
        avatar &local = get_avatar();

        control_fixture() {
            g->player_controls().reset();
            local = avatar();
            clear_avatar();
            clear_map();
            local.setID( g->assign_npc_id(), true );
            local.name = "Local controller";
            local.set_save_id( "local-control-slot" );
            local.ensure_player_id();
            g->bind_local_player_control();
            local.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
        }

        ~control_fixture() {
            g->player_controls().reset();
            clear_npcs();
            local = std::move( previous );
        }

        npc &follower() {
            npc &actor = spawn_npc( point_bub_ms( 61, 60 ), "test_talker" );
            actor.set_fac( faction_id( "your_followers" ) );
            actor.set_attitude( NPCATT_FOLLOW );
            return actor;
        }
};
} // namespace

TEST_CASE( "local_takeover_cannot_steal_a_multiplayer_actor", "[avatar][control][multiplayer]" )
{
    control_fixture fixture;
    npc &remote = fixture.follower();
    const bool debug = GENERATE( false, true );
    const bool player_owned = GENERATE( false, true );
    CAPTURE( debug, player_owned );
    remote.set_value( "mp_proxy", std::string( "1" ) );
    cata_mp::actor_binding binding;
    if( player_owned ) {
        const cata_mp::player_id owner( std::string( 32, '4' ) );
        remote.set_value( "mp_player_id", owner.str() );
        binding.bind_player( remote, owner, g->npc_lifetimes(),
                             g->player_controls().claim( owner, remote ) );
    } else {
        // The host's client-side view has no player credential tag.
        binding.bind_view( remote, g->npc_lifetimes() );
    }
    REQUIRE( remote.is_player_ally() );
    const auto before_local = saved_character( fixture.local );
    const auto before_remote = saved_character( remote );
    const auto before_rng = rng_get_engine();
    const std::string diagnostic = capture_debugmsg_during( [&]() {
        fixture.local.control_npc( remote, debug );
    } );
    CHECK( diagnostic.find( "multiplayer" ) != std::string::npos );
    CHECK( saved_character( fixture.local ) == before_local );
    CHECK( saved_character( remote ) == before_remote );
    CHECK( rng_get_engine() == before_rng );
    CHECK( binding.resolve_loaded( &remote, g->npc_lifetimes() ) == &remote );
}

TEST_CASE( "local_takeover_keeps_the_save_slot_and_exchanges_character_roles", "[avatar][control]" )
{
    control_fixture fixture;
    npc &follower = fixture.follower();
    const auto original = fixture.local.getID();
    const auto player = fixture.local.get_player_id();
    const auto target = follower.getID();
    const auto target_position = follower.pos_abs();
    const auto old_control = g->player_controls().find( player );
    REQUIRE( old_control.resolve( g->player_controls() ) == &fixture.local );
    REQUIRE( original != target );
    fixture.local.control_npc( follower );
    CHECK( fixture.local.getID() == target );
    CHECK( follower.getID() == original );
    CHECK( fixture.local.pos_abs() == target_position );
    CHECK( fixture.local.get_save_id() == "local-control-slot" );
    CHECK( fixture.local.get_player_id() == player );
    CHECK_FALSE( old_control.resolve( g->player_controls() ) );
    CHECK( g->player_controls().find( player ).resolve( g->player_controls() ) == &fixture.local );
    // Returning control must preserve the same local save ownership.
    fixture.local.control_npc( follower );
    CHECK( fixture.local.getID() == original );
    CHECK( follower.getID() == target );
    CHECK( fixture.local.get_save_id() == "local-control-slot" );
    CHECK( fixture.local.get_player_id() == player );
    CHECK( g->player_controls().find( player ).resolve( g->player_controls() ) == &fixture.local );
}

TEST_CASE( "local_takeover_cannot_steal_another_local_control_role", "[avatar][control]" )
{
    control_fixture fixture;
    npc &other = fixture.follower();
    const player_id second_player( std::string( 32, '8' ) );
    auto second_control = g->player_controls().claim( second_player, other );
    const auto first_reference = g->player_controls().find( fixture.local.get_player_id() );
    const auto second_reference = g->player_controls().find( second_player );
    REQUIRE( first_reference.resolve( g->player_controls() ) == &fixture.local );
    REQUIRE( second_reference.resolve( g->player_controls() ) == &other );
    REQUIRE_FALSE( cata_mp::is_player_proxy( other ) );
    const auto local_before = saved_character( fixture.local );
    const auto other_before = saved_character( other );
    const auto rng_before = rng_get_engine();
    const bool debug = GENERATE( false, true );
    const std::string error = capture_debugmsg_during( [&]() {
        fixture.local.control_npc( other, debug );
    } );
    CHECK( error.find( "controlled actor" ) != std::string::npos );
    CHECK( saved_character( fixture.local ) == local_before );
    CHECK( saved_character( other ) == other_before );
    CHECK( rng_get_engine() == rng_before );
    CHECK( first_reference.resolve( g->player_controls() ) == &fixture.local );
    CHECK( second_reference.resolve( g->player_controls() ) == &other );
    second_control.reset();
    CHECK_FALSE( second_reference.resolve( g->player_controls() ) );
    fixture.local.control_npc( other );
    CHECK_FALSE( first_reference.resolve( g->player_controls() ) );
    CHECK( g->player_controls().find( fixture.local.get_player_id() ).resolve(
               g->player_controls() ) == &fixture.local );
}

TEST_CASE( "world_reset_revokes_local_control_even_if_the_avatar_survives",
           "[avatar][control][lifetime]" )
{
    control_fixture fixture;
    const auto player = fixture.local.get_player_id();
    const auto id = fixture.local.getID();
    const auto previous = g->player_controls().find( player );
    REQUIRE( previous.resolve( g->player_controls() ) == &fixture.local );
    g->reset_game_state();
    CHECK( fixture.local.getID() == id );
    CHECK_FALSE( previous.resolve( g->player_controls() ) );
    CHECK_FALSE( g->player_controls().is_reserved( player ) );
    g->bind_local_player_control();
    CHECK_FALSE( previous.resolve( g->player_controls() ) );
    CHECK( g->player_controls().find( player ).resolve( g->player_controls() ) == &fixture.local );
}

TEST_CASE( "native_world_turn_advances_controlled_npc_without_running_its_ai",
           "[avatar][control][character_turn][dispatch]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const override_option npc_food( "NO_NPC_FOOD", "false" );
    calendar::turn = calendar::turn_zero + 11_hours;
    control_fixture fixture;
    npc &second = fixture.follower();
    clear_character( second, true );
    second.set_attitude( NPCATT_FOLLOW );
    const player_id owner( std::string( 32, '7' ) );
    auto control = g->player_controls().claim( owner, second );
    REQUIRE_FALSE( cata_mp::is_player_proxy( second ) );
    const efftype_id blind( "blind" );
    fixture.local.add_effect( blind, 500_turns );
    second.add_effect( blind, 500_turns );
    second.set_moves( -37 );
    second.set_stamina( second.get_stamina_max() / 2 );
    const int initial_stamina = second.get_stamina();
    REQUIRE( initial_stamina < second.get_stamina_max() );
    const auto position = second.pos_abs();

    // Not a ten-second NPC body boundary: an owned actor must still advance.
    calendar::turn += 1_turns;
    g->simulate_turn_suffix();
    CHECK( second.pos_abs() == position );
    CHECK( second.get_moves() == -37 + second.get_speed() );
    CHECK( second.get_effect_dur( blind ) == 499_turns );
    CHECK( fixture.local.get_effect_dur( blind ) == 499_turns );
    CHECK( second.get_stamina() > initial_stamina );
    CHECK( second.get_stamina() < second.get_stamina_max() );

    // Releasing the assignment returns actions to NPC AI on the next step.
    control.reset();
    second.set_moves( 100 );
    calendar::turn += 1_turns;
    g->simulate_turn_suffix();
    CHECK( second.get_moves() <= 0 );
    CHECK( second.get_effect_dur( blind ) == 498_turns );
    CHECK( fixture.local.get_effect_dur( blind ) == 498_turns );

    // Reclaiming the same live actor must restore the same dispatch boundary.
    control = g->player_controls().claim( owner, second );
    second.set_moves( -37 );
    calendar::turn += 1_turns;
    g->simulate_turn_suffix();
    CHECK( second.get_moves() == -37 + second.get_speed() );
    CHECK( second.get_effect_dur( blind ) == 497_turns );
    CHECK( fixture.local.get_effect_dur( blind ) == 497_turns );
}

TEST_CASE( "controlled_native_npc_does_not_receive_ai_stamina_reset",
           "[avatar][control][character_turn][dispatch]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    calendar::turn = calendar::turn_zero + 11_hours;
    control_fixture fixture;
    npc &second = fixture.follower();
    clear_character( second, true );
    auto control = g->player_controls().claim( player_id( std::string( 32, '8' ) ), second );
    second.set_stamina( second.get_stamina_max() / 2 );
    const int stamina = second.get_stamina();
    REQUIRE( stamina < second.get_stamina_max() );
    control.process_turn();
    CHECK( second.get_stamina() == stamina );
    control.reset();
    second.process_turn();
    CHECK( second.get_stamina() == second.get_stamina_max() );
}

TEST_CASE( "npc_work_schedule_cannot_wake_a_controlled_character",
           "[avatar][control][npc][schedule]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    calendar::turn = calendar::turn_zero + 12_hours;
    control_fixture fixture;
    npc &second = fixture.follower();
    second.myclass = npc_class_id( "NC_ROBOFAC_INTERCOM_DAY" );
    const efftype_id sleep( "sleep" );
    second.add_effect( sleep, 1_hours );
    REQUIRE( second.in_sleep_state() );
    auto control = g->player_controls().claim( player_id( std::string( 32, '9' ) ), second );
    second.reconcile_schedule();
    second.reconcile_schedule_on_load();
    CHECK( second.in_sleep_state() );
    control.reset();
    second.reconcile_schedule();
    CHECK_FALSE( second.in_sleep_state() );
}

TEST_CASE( "native_control_excludes_automatic_overmap_travel",
           "[avatar][control][dispatch][overmap]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    calendar::turn = calendar::turn_zero + 11_hours;
    control_fixture fixture;
    npc &second = fixture.follower();
    second.setpos( get_map(), tripoint_bub_ms( 87, 60, 0 ) );
    second.set_mission( NPC_MISSION_TRAVELLING );
    const tripoint_abs_omt origin = second.pos_abs_omt();
    const tripoint_abs_omt destination( origin.x() + 2, origin.y(), origin.z() );
    const tripoint_abs_omt next( origin.x() + 1, origin.y(), origin.z() );
    second.goal = destination;
    second.omt_path = { next };
    auto control = g->player_controls().claim( player_id( std::string( 32, 'a' ) ), second );
    const auto position = second.pos_abs();
    const auto route = second.omt_path;
    second.set_moves( -37 );

    // This production boundary also runs automatic overmap travel for NPCs
    // farther than 24 tiles away, even when they are still in the active map.
    calendar::turn += 5_minutes;
    g->simulate_turn_suffix();
    CHECK( second.pos_abs() == position );
    CHECK( second.goal == destination );
    CHECK( second.omt_path == route );
    CHECK( second.get_moves() == -37 + second.get_speed() );

    // Release control, suppress local AI movement with a negative move budget,
    // and prove that normal overmap travel remains available to the same NPC.
    control.reset();
    second.set_moves( -10000 );
    calendar::turn += 5_minutes;
    g->simulate_turn_suffix();
    CHECK( second.pos_abs_omt() == next );
    CHECK( second.pos_abs() != position );
}
