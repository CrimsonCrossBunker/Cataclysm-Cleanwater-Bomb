#include "cata_catch.h"

#include <memory>
#include <sstream>
#include <string>
#include <utility>

#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character_turn.h"
#include "json.h"
#include "map.h"
#include "map_helpers.h"
#include "player_control.h"
#include "player_helpers.h"
#include "rng.h"
#include "type_id.h"

namespace
{
const efftype_id effect_blind( "blind" );

void prepare( avatar &actor, int id )
{
    clear_character( actor );
    actor.setID( character_id( id ), true );
    actor.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    actor.set_stamina( actor.get_stamina_max() / 2 );
    actor.set_moves( -37 );
    actor.add_effect( effect_blind, 500_turns );
}

std::string saved( const avatar &actor )
{
    std::ostringstream stream;
    JsonOut out( stream );
    actor.serialize( out );
    return stream.str();
}
} // namespace

TEST_CASE( "native_player_drivers_advance_only_their_owned_characters",
           "[character_turn][control]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_map_without_vision();
    calendar::turn = calendar::turn_zero + 11_hours;
    avatar first;
    avatar second;
    prepare( first, 12501 );
    prepare( second, 12502 );
    player_control_registry world;
    auto one = world.claim( player_id( std::string( 32, '5' ) ), first );
    auto two = world.claim( player_id( std::string( 32, '6' ) ), second );
    calendar::turn += 1_turns;
    const auto second_before = saved( second );
    const int initial_stamina = first.get_stamina();
    one.update_body();
    one.process_turn();
    CHECK( first.get_stamina() > initial_stamina );
    CHECK( first.get_moves() == -37 + first.get_speed() );
    CHECK( first.get_effect_dur( effect_blind ) == 499_turns );
    CHECK( saved( second ) == second_before );

    const auto first_after = saved( first );
    two.update_body();
    two.process_turn();
    CHECK( second.get_stamina() > initial_stamina );
    CHECK( second.get_moves() == -37 + second.get_speed() );
    CHECK( second.get_effect_dur( effect_blind ) == 499_turns );
    CHECK( saved( first ) == first_after );

    world.reset();
    const auto second_after = saved( second );
    const auto rng_before = rng_get_engine();
    CHECK_THROWS( one.update_body() );
    CHECK_THROWS( one.process_turn() );
    CHECK_THROWS( two.update_body() );
    CHECK_THROWS( two.process_turn() );
    CHECK( saved( first ) == first_after );
    CHECK( saved( second ) == second_after );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "observed_character_clocks_do_not_share_elapsed_time_or_grant_moves",
           "[character_turn][regression]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_map_without_vision();
    calendar::turn = calendar::turn_zero + 11_hours;
    avatar first;
    avatar second;
    prepare( first, 12503 );
    prepare( second, 12504 );
    character_turn_driver one;
    character_turn_driver two;
    one.bind( first, character_turn_policy::observed_clock );
    two.bind( second, character_turn_policy::observed_clock );
    calendar::turn += 1_turns;
    const int initial = first.get_stamina();
    one.update_body();
    one.process_turn();
    REQUIRE( first.get_stamina() > initial );
    REQUIRE( first.get_effect_dur( effect_blind ) == 499_turns );
    CHECK( first.get_moves() == -37 );
    CHECK( second.get_stamina() == initial );
    const auto first_after = saved( first );
    const auto rng_before = rng_get_engine();
    // The production client adapter binds at each call. It must not restart
    // timing while the network loop is spinning at the same calendar time.
    one.bind( first, character_turn_policy::observed_clock );
    one.update_body();
    one.process_turn();
    CHECK( saved( first ) == first_after );
    CHECK( rng_get_engine() == rng_before );

    calendar::turn += 3_turns;
    one.update_body();
    one.process_turn();
    two.update_body();
    two.process_turn();
    CHECK( first.get_effect_dur( effect_blind ) == 496_turns );
    CHECK( second.get_effect_dur( effect_blind ) == 499_turns );
    CHECK( first.get_stamina() > second.get_stamina() );
    CHECK( second.get_stamina() > initial );
    CHECK( first.get_moves() == -37 );
    CHECK( second.get_moves() == -37 );
}

TEST_CASE( "observed_character_clock_retains_bounded_catchup_and_rewind_rules",
           "[character_turn][regression]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_map_without_vision();
    calendar::turn = calendar::turn_zero + 11_hours;
    avatar actor;
    prepare( actor, 12505 );
    character_turn_driver driver;
    driver.bind( actor, character_turn_policy::observed_clock );
    driver.process_turn();
    REQUIRE( actor.get_effect_dur( effect_blind ) == 499_turns );
    calendar::turn += 150_turns;
    driver.process_turn();
    CHECK( actor.get_effect_dur( effect_blind ) == 399_turns );
    CHECK( actor.get_moves() == -37 );
    calendar::turn -= 2_turns;
    const auto before = saved( actor );
    const auto rng_before = rng_get_engine();
    driver.process_turn();
    CHECK( saved( actor ) == before );
    CHECK( rng_get_engine() == rng_before );
    calendar::turn += 1_turns;
    driver.process_turn();
    CHECK( actor.get_effect_dur( effect_blind ) == 398_turns );
    CHECK( actor.get_moves() == -37 );

    driver.reset();
    CHECK_THROWS( driver.process_turn() );
    driver.bind( actor, character_turn_policy::observed_clock );
    driver.process_turn();
    CHECK( actor.get_effect_dur( effect_blind ) == 397_turns );
    driver.bind( actor, character_turn_policy::native_step );
    driver.process_turn();
    CHECK( actor.get_effect_dur( effect_blind ) == 396_turns );
    CHECK( actor.get_moves() == -37 + actor.get_speed() );
}

TEST_CASE( "character_turn_driver_requires_live_binding_and_resets_for_replacement",
           "[character_turn][lifetime]" )
{
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_map_without_vision();
    calendar::turn = calendar::turn_zero + 11_hours;
    character_turn_driver driver;
    CHECK_THROWS( driver.update_body() );
    CHECK_THROWS( driver.process_turn() );
    auto actor = std::make_unique<avatar>();
    prepare( *actor, 12506 );
    driver.bind( *actor, character_turn_policy::observed_clock );
    driver.process_turn();
    *actor = avatar();
    prepare( *actor, 12506 );
    // Same address and ID do not make a replaced native actor the old one.
    CHECK_THROWS( driver.update_body() );
    CHECK_THROWS( driver.process_turn() );
    driver.bind( *actor, character_turn_policy::observed_clock );
    auto moved = std::move( driver );
    CHECK_THROWS( driver.process_turn() );
    moved.process_turn();
    CHECK( actor->get_effect_dur( effect_blind ) == 499_turns );
    actor.reset();
    CHECK_THROWS( moved.update_body() );
    CHECK_THROWS( moved.process_turn() );
}
