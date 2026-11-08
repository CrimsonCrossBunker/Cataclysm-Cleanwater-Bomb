#include "cata_catch.h"

#include <memory>
#include <string>
#include <utility>

#include "avatar.h"
#include "bodypart.h"
#include "npc.h"
#include "player_control.h"
#include "rng.h"

namespace
{
const player_id first_player( std::string( 32, '3' ) );
const player_id second_player( std::string( 32, '4' ) );

void prepare( Character &actor, int id )
{
    actor.normalize();
    actor.setID( character_id( id ), true );
}
} // namespace

TEST_CASE( "player_controls_share_one_world_and_exclude_duplicate_owners", "[player_control]" )
{
    avatar local;
    npc second;
    npc copied_id;
    prepare( local, 12100 );
    prepare( second, 12101 );
    prepare( copied_id, 12100 );
    player_control_registry world;
    player_control_registry unrelated;
    const auto before = rng_get_engine();
    auto first = world.claim( first_player, local );
    const auto first_reference = world.find( first_player );
    CHECK_THROWS( world.claim( first_player, second ) );
    CHECK_THROWS( world.claim( second_player, local ) );
    CHECK_THROWS( world.claim( second_player, copied_id ) );
    CHECK( first_reference.resolve( world ) == &local );
    auto other = world.claim( second_player, second );
    const auto second_reference = world.find( second_player );
    CHECK( second_reference.resolve( world ) == &second );
    CHECK_FALSE( first_reference.resolve( unrelated ) );
    CHECK_FALSE( second_reference.resolve( unrelated ) );
    CHECK( rng_get_engine() == before );

    auto moved = std::move( first );
    CHECK_FALSE( first.get() );
    CHECK( moved.get() == &local );
    CHECK( first_reference.resolve( world ) == &local );
    moved.reset();
    CHECK_FALSE( first_reference.resolve( world ) );
    CHECK( second_reference.resolve( world ) == &second );
    first = world.claim( first_player, local );
    CHECK_FALSE( first_reference.resolve( world ) );
    CHECK( world.find( first_player ).resolve( world ) == &local );
    world.reset();
    CHECK_FALSE( first.get() );
    CHECK_FALSE( other.get() );
    CHECK_FALSE( second_reference.resolve( world ) );
    first = world.claim( first_player, local );
    CHECK_FALSE( first_reference.resolve( world ) );
    CHECK( world.find( first_player ).resolve( world ) == &local );
}

TEST_CASE( "player_control_does_not_survive_actor_replacement_or_world_destruction",
           "[player_control][lifetime]" )
{
    auto actor = std::make_unique<npc>();
    prepare( *actor, 12102 );
    player_control lease;
    player_control_reference reference;
    {
        player_control_registry world;
        lease = world.claim( first_player, *actor );
        reference = world.find( first_player );
        REQUIRE( reference.resolve( world ) == actor.get() );
        // Replacing an actor must not let its earlier controller follow it.
        npc replacement;
        prepare( replacement, 12102 );
        *actor = std::move( replacement );
        CHECK_FALSE( lease.get() );
        CHECK_FALSE( reference.resolve( world ) );
        lease = world.claim( first_player, *actor );
        CHECK_FALSE( reference.resolve( world ) );
        reference = world.find( first_player );
        actor.reset();
        CHECK_FALSE( lease.get() );
        CHECK_FALSE( reference.resolve( world ) );
        actor = std::make_unique<npc>();
        prepare( *actor, 12102 );
        lease = world.claim( first_player, *actor );
        reference = world.find( first_player );
    }
    CHECK_FALSE( lease.get() );
    player_control_registry another_world;
    CHECK_FALSE( reference.resolve( another_world ) );
}

TEST_CASE( "player_control_rejects_invalid_claims_and_retains_dead_actor_for_save",
           "[player_control][lifetime]" )
{
    npc actor;
    actor.normalize();
    player_control_registry world;
    CHECK_THROWS( world.claim( first_player, actor ) );
    actor.setID( character_id( 12103 ), true );
    CHECK_THROWS( world.claim( player_id(), actor ) );
    auto lease = world.claim( first_player, actor );
    const auto reference = world.find( first_player );
    actor.set_part_hp_cur( bodypart_id( "torso" ), 0 );
    REQUIRE( actor.is_dead_state() );
    CHECK_FALSE( reference.resolve( world ) );
    CHECK( lease.get() == &actor );
    CHECK( world.is_claimed( actor ) );
    CHECK( world.is_reserved( first_player ) );
    npc successor;
    prepare( successor, 12104 );
    CHECK_THROWS( world.claim( first_player, successor ) );
    lease.reset();
    CHECK_THROWS( world.claim( first_player, actor ) );
    CHECK_FALSE( world.is_reserved( first_player ) );
    lease = world.claim( first_player, successor );
    CHECK( lease.get() == &successor );
    CHECK_FALSE( reference.resolve( world ) );
}
