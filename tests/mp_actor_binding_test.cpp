#include <memory>
#include <string>

#include "cata_catch.h"
#include "character_id.h"
#include "mp_actor_binding.h"
#include "mp_player_identity.h"
#include "npc.h"
#include "npc_lifetime.h"
#include "player_control.h"
#include "player_identity.h"

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
    player_control_registry controls;
    npc_lifetime_registry other_world;
    cata_mp::actor_binding binding;
    binding.bind_player( first, owner, world, controls.claim( owner, first ) );
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
    player_control_registry controls;
    cata_mp::actor_binding binding;
    auto actor = std::make_unique<npc>();
    prepare_actor( *actor, 12011 );
    binding.bind_player( *actor, owner, world, controls.claim( owner, *actor ) );
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
    CHECK_THROWS( binding.bind_player( actor, cata_mp::player_id(), world, player_control() ) );
    CHECK_THROWS( binding.bind_player( actor, owner, world, player_control() ) );
    player_control_registry controls;
    CHECK_THROWS( binding.bind_player( actor, cata_mp::player_id( std::string( 32, '6' ) ), world,
                                       controls.claim( owner, actor ) ) );
    CHECK_FALSE( binding.id().is_valid() );
    binding.bind_view( actor, world );
    REQUIRE( binding.resolve_loaded( &actor, world ) == &actor );
    binding.reset();
    CHECK_FALSE( binding.retained( world ) );
    CHECK_FALSE( binding.resolve_loaded( &actor, world ) );
}

TEST_CASE( "mp_actor_binding_releases_world_control_and_rejects_wrong_assignment",
           "[multiplayer][actor_binding][player_control]" )
{
    npc first;
    npc second;
    prepare_actor( first, 12110 );
    prepare_actor( second, 12111 );
    npc_lifetime_registry world;
    player_control_registry controls;
    cata_mp::actor_binding binding;
    CHECK_THROWS( binding.bind_player( second, owner, world, controls.claim( owner, first ) ) );
    CHECK_FALSE( controls.is_claimed( first ) );
    CHECK_FALSE( binding.id().is_valid() );
    binding.bind_player( first, owner, world, controls.claim( owner, first ) );
    const auto before = controls.find( owner );
    CHECK_THROWS( controls.claim( owner, second ) );
    CHECK( binding.resolve_loaded( &first, world ) == &first );
    binding.reset();
    CHECK_FALSE( before.resolve( controls ) );
    binding.bind_player( second, owner, world, controls.claim( owner, second ) );
    CHECK_FALSE( before.resolve( controls ) );
    REQUIRE( binding.resolve_loaded( &second, world ) == &second );
    controls.reset();
    CHECK_FALSE( binding.retained( world ) );
    CHECK_FALSE( binding.resolve_loaded( &second, world ) );
}

TEST_CASE( "mp_npc_replica_binding_is_view_only_and_retains_exact_identity",
           "[multiplayer][actor_binding][regression]" )
{
    npc actor;
    actor.normalize();
    actor.setID( character_id( 12112 ), true );
    npc_lifetime_registry world;
    npc_lifetime_registry other_world;
    player_control_registry controls;
    cata_mp::actor_binding binding;
    CHECK_THROWS( binding.bind_view( actor, world ) );
    actor.set_value( "mp_npc_replica", std::string( "1" ) );
    actor.set_value( "mp_player_id", owner.str() );
    CHECK_FALSE( cata_mp::is_player_proxy( actor ) );
    CHECK_THROWS( binding.bind_player( actor, owner, world, controls.claim( owner, actor ) ) );
    CHECK_FALSE( binding.id().is_valid() );
    binding.bind_view( actor, world );
    REQUIRE( binding.resolve_loaded( &actor, world ) == &actor );
    CHECK_FALSE( binding.retained( other_world ) );
    npc replacement;
    replacement.normalize();
    replacement.setID( actor.getID(), true );
    replacement.set_value( "mp_npc_replica", std::string( "1" ) );
    CHECK_FALSE( binding.resolve_loaded( &replacement, world ) );
    world.retire( actor );
    CHECK_FALSE( binding.resolve_loaded( &actor, world ) );
    CHECK( binding.retained( world ) == &actor );
    world.activate( actor );
    CHECK( binding.resolve_loaded( &actor, world ) == &actor );
    actor.set_value( "mp_npc_replica", std::string( "0" ) );
    CHECK_FALSE( binding.retained( world ) );
}
