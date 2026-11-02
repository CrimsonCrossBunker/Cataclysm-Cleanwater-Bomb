#include "cata_catch.h"

#include <memory>
#include <string>

#include "mp_actor_binding.h"
#include "npc.h"

namespace
{
const cata_mp::player_id owner( std::string( 32, '4' ) );

void prepare_actor( npc &actor, int id )
{
    actor.normalize();
    actor.setID( character_id( id ), true );
    actor.set_value( "mp_proxy", std::string( "1" ) );
    actor.set_value( "mp_player_id", owner.str() );
}
} // namespace

TEST_CASE( "mp_actor_control_requires_exact_world_and_instance", "[multiplayer][actor_binding]" )
{
    npc first;
    npc second;
    prepare_actor( first, 12010 );
    prepare_actor( second, 12010 );
    npc_lifetime_registry world;
    npc_lifetime_registry other_world;
    cata_mp::actor_binding binding;
    binding.bind_player( first, owner, world );
    const auto old_lifetime = world.acquire( first );
    REQUIRE( binding.resolve_loaded( &first, world ) == &first );
    CHECK_FALSE( binding.resolve_loaded( &first, other_world ) );
    CHECK_FALSE( binding.retained( other_world ) );
    CHECK_FALSE( binding.resolve_loaded( &second, world ) );

    world.retire( first );
    CHECK_FALSE( binding.resolve_loaded( &first, world ) );
    CHECK_FALSE( world.active_reference( first ).resolve( world ) );
    CHECK( binding.retained( world ) == &first );
    world.activate( first );
    CHECK( binding.resolve_loaded( &first, world ) == &first );
    CHECK_FALSE( old_lifetime.resolve( world ) );

    // A replacement has identical persistent tags and ID, but no control role.
    const auto replacement = world.acquire( second );
    CHECK_FALSE( binding.resolve_loaded( &first, world ) );
    CHECK_FALSE( binding.resolve_loaded( &second, world ) );
    world.retire( first );
    CHECK( replacement.resolve( world ) == &second );
    CHECK_FALSE( binding.resolve_loaded( &second, world ) );
    CHECK( binding.retained( world ) == &first );
    world.reset();
    world.activate( first );
    CHECK_FALSE( binding.retained( world ) );
    CHECK_FALSE( binding.resolve_loaded( &first, world ) );
}

TEST_CASE( "mp_actor_control_rejects_tampered_or_destroyed_identity",
           "[multiplayer][actor_binding]" )
{
    npc_lifetime_registry world;
    cata_mp::actor_binding binding;
    auto actor = std::make_unique<npc>();
    prepare_actor( *actor, 12011 );
    binding.bind_player( *actor, owner, world );
    actor->set_value( "mp_player_id", std::string( 32, '5' ) );
    CHECK_FALSE( binding.resolve_loaded( actor.get(), world ) );
    CHECK_FALSE( binding.retained( world ) );
    actor->set_value( "mp_player_id", owner.str() );
    REQUIRE( binding.resolve_loaded( actor.get(), world ) == actor.get() );
    actor->set_value( "mp_proxy", std::string( "0" ) );
    CHECK_FALSE( binding.resolve_loaded( actor.get(), world ) );
    actor->set_value( "mp_proxy", std::string( "1" ) );
    actor->setID( character_id( 12012 ), true );
    CHECK_FALSE( binding.retained( world ) );
    actor->setID( character_id( 12011 ), true );
    REQUIRE( binding.retained( world ) == actor.get() );
    actor.reset();
    CHECK_FALSE( binding.retained( world ) );
    binding.reset();
    CHECK_FALSE( binding.id().is_valid() );
}

TEST_CASE( "mp_actor_admission_requires_valid_identity", "[multiplayer][actor_binding]" )
{
    npc_lifetime_registry world;
    cata_mp::actor_binding binding;
    npc actor;
    actor.normalize();
    actor.set_value( "mp_proxy", std::string( "1" ) );
    CHECK_THROWS( binding.bind_view( actor, world ) );
    prepare_actor( actor, 12013 );
    CHECK_THROWS( binding.bind_player( actor, cata_mp::player_id(), world ) );
    CHECK_THROWS( binding.bind_player( actor, cata_mp::player_id( std::string( 32, '6' ) ), world ) );
    CHECK_FALSE( binding.id().is_valid() );
    binding.bind_view( actor, world );
    REQUIRE( binding.resolve_loaded( &actor, world ) == &actor );
    binding.reset();
    CHECK_FALSE( binding.retained( world ) );
    CHECK_FALSE( binding.resolve_loaded( &actor, world ) );
}
