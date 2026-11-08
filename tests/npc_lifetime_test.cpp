#include "cata_catch.h"

#include "game.h"
#include "npc.h"
#include "npc_lifetime.h"

TEST_CASE( "npc_lifetimes_belong_to_one_world_incarnation", "[npc_lifetime]" )
{
    npc first;
    first.normalize();
    first.setID( character_id( 12001 ), true );
    npc second;
    second.normalize();
    second.setID( first.getID(), true );
    npc_lifetime_registry first_world;
    npc_lifetime_registry second_world;
    const auto first_ref = first_world.acquire( first );
    const auto second_ref = second_world.acquire( second );
    REQUIRE( first_ref.resolve( first_world ) == &first );
    REQUIRE( second_ref.resolve( second_world ) == &second );
    CHECK_FALSE( first_ref.resolve( second_world ) );
    CHECK_FALSE( second_ref.resolve( first_world ) );

    first_world.reset();
    CHECK_FALSE( first_ref.resolve( first_world ) );
    CHECK( second_ref.resolve( second_world ) == &second );
    const auto restored = first_world.acquire( first );
    CHECK( restored.resolve( first_world ) == &first );
    CHECK_FALSE( first_ref.resolve( first_world ) );

    npc_lifetime departed;
    {
        npc_lifetime_registry departed_world;
        departed = departed_world.acquire( first );
        REQUIRE( departed.resolve( departed_world ) == &first );
    }
    CHECK_FALSE( departed.resolve( first_world ) );
    CHECK( restored.resolve( first_world ) == &first );
}

TEST_CASE( "npc_lifetimes_reject_reload_replacement_and_late_unload", "[npc_lifetime]" )
{
    npc_lifetime_registry world;
    npc original;
    original.normalize();
    original.setID( character_id( 12002 ), true );
    const auto before_unload = world.acquire( original );
    world.retire( original );
    CHECK_FALSE( before_unload.resolve( world ) );
    world.activate( original );
    const auto after_reload = world.acquire( original );
    CHECK( after_reload.generation() > before_unload.generation() );
    CHECK( after_reload.resolve( world ) == &original );
    CHECK_FALSE( before_unload.resolve( world ) );

    npc replacement;
    replacement.normalize();
    replacement.setID( original.getID(), true );
    const auto replacement_ref = world.acquire( replacement );
    CHECK_FALSE( after_reload.resolve( world ) );
    CHECK_FALSE( before_unload.resolve( world ) );
    world.retire( original );
    CHECK( replacement_ref.resolve( world ) == &replacement );
    replacement.setID( character_id( 12003 ), true );
    CHECK_FALSE( replacement_ref.resolve( world ) );

    npc_lifetime destroyed;
    {
        npc temporary;
        temporary.normalize();
        temporary.setID( character_id( 12004 ), true );
        destroyed = world.acquire( temporary );
        REQUIRE( destroyed.resolve( world ) == &temporary );
    }
    CHECK_FALSE( destroyed.resolve( world ) );
}

TEST_CASE( "native_npc_unload_retires_the_world_reference", "[npc_lifetime]" )
{
    npc value;
    value.normalize();
    value.setID( character_id( 12005 ), true );
    auto &world = g->npc_lifetimes();
    const auto before_unload = world.acquire( value );
    REQUIRE( before_unload.resolve( world ) == &value );
    value.on_unload();
    CHECK_FALSE( before_unload.resolve( world ) );
    activate_npc_lifetime( value );
    const auto loaded = world.acquire( value );
    CHECK( loaded.resolve( world ) == &value );
    CHECK_FALSE( before_unload.resolve( world ) );
    retire_npc_lifetime( value );
    CHECK_FALSE( loaded.resolve( world ) );
}
