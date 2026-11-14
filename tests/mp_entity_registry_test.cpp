#include "cata_catch.h"

#include <climits>
#include <optional>
#include <stdexcept>
#include <utility>

#include "creature_tracker.h"
#include "monster.h"
#include "mp_entity_registry.h"
#include "rng.h"
#include "vehicle.h"

static const mtype_id mon_test_zombie( "mon_test_zombie" );
static const vproto_id vehicle_prototype_bicycle( "bicycle" );

TEST_CASE( "mp_entity_ids_share_a_session_sequence_without_changing_native_identity",
           "[multiplayer][entity_identity]" )
{
    cata_mp::entity_registry ids;
    monster first( mon_test_zombie );
    monster copied( first );
    vehicle bike( vehicle_prototype_bicycle );
    REQUIRE( first.uid().is_valid() );
    REQUIRE( copied.uid().get_value() != first.uid().get_value() );
    const auto uid = first.uid().get_value();
    const auto rng_before = rng_get_engine();

    CHECK( ids.known_id( first ) == 0 );
    CHECK( ids.assign( first ) == 1 );
    CHECK( ids.assign( bike ) == 2 );
    CHECK( ids.assign( copied ) == 3 );
    CHECK( ids.assign( first ) == 1 );
    CHECK( ids.assign( bike ) == 2 );
    CHECK( first.uid().get_value() == uid );
    CHECK( rng_get_engine() == rng_before );

    cata_mp::entity_registry other_session;
    CHECK( other_session.known_id( first ) == 0 );
    CHECK( other_session.assign( copied ) == 1 );
    CHECK( other_session.assign( first ) == 2 );
    CHECK( ids.known_id( first ) == 1 );
    cata_mp::entity_registry moved( std::move( ids ) );
    CHECK( moved.known_id( first ) == 1 );
}

TEST_CASE( "mp_entity_ids_reject_reused_addresses_and_moved_native_objects",
           "[multiplayer][entity_identity]" )
{
    cata_mp::entity_registry ids;
    std::optional<vehicle> bike( std::in_place, vehicle_prototype_bicycle );
    const auto *address = &*bike;
    const auto first_id = ids.assign( *bike );
    const auto first_uid = bike->uid().get_value();
    bike.reset();
    bike.emplace( vehicle_prototype_bicycle );
    REQUIRE( &*bike == address );
    REQUIRE( bike->uid().get_value() != first_uid );
    CHECK( ids.assign( *bike ) > first_id );

    const auto second_id = ids.assign( *bike );
    vehicle replacement( vehicle_prototype_bicycle );
    const auto replacement_uid = replacement.uid().get_value();
    const auto replacement_id = ids.assign( replacement );
    *bike = std::move( replacement );
    REQUIRE( bike->uid().get_value() == replacement_uid );
    CHECK( ids.assign( *bike ) > replacement_id );
    CHECK( ids.assign( *bike ) != second_id );
    CHECK_THROWS_AS( ids.assign( replacement ), std::invalid_argument );

    std::optional<monster> mon( std::in_place, mon_test_zombie );
    const auto old_id = ids.assign( *mon );
    const auto *mon_address = &*mon;
    mon.reset();
    mon.emplace( mon_test_zombie );
    REQUIRE( &*mon == mon_address );
    CHECK( ids.known_id( *mon ) == 0 );
    CHECK( ids.assign( *mon ) > old_id );
    monster moved( std::move( *mon ) );
    CHECK( ids.known_id( *mon ) == 0 );
    CHECK( ids.known_id( moved ) == 0 );
    CHECK( ids.assign( moved ) > old_id );
}

TEST_CASE( "mp_entity_lookup_requires_loaded_live_native_membership",
           "[multiplayer][entity_identity]" )
{
    creature_tracker tracker;
    cata_mp::entity_registry ids;
    auto original = make_shared_fast<monster>( mon_test_zombie, tripoint_bub_ms( 0, 0, 0 ) );
    REQUIRE( tracker.add( original ) );
    const auto id = ids.assign( *original );
    REQUIRE( ids.find_monster( id, tracker ) == original.get() );
    CHECK_FALSE( ids.find_monster( 0, tracker ) );
    tracker.remove( *original );
    CHECK_FALSE( ids.find_monster( id, tracker ) );

    auto replacement = make_shared_fast<monster>( mon_test_zombie, tripoint_bub_ms( 0, 0, 0 ) );
    REQUIRE( tracker.add( replacement ) );
    CHECK_FALSE( ids.find_monster( id, tracker ) );
    const auto replacement_id = ids.assign( *replacement );
    REQUIRE( replacement_id != id );
    CHECK( ids.find_monster( replacement_id, tracker ) == replacement.get() );
    original.reset();
    CHECK_FALSE( ids.find_monster( id, tracker ) );
    replacement->set_hp( 0 );
    REQUIRE( replacement->is_dead() );
    CHECK_FALSE( ids.find_monster( replacement_id, tracker ) );
}

TEST_CASE( "mp_entity_ids_never_wrap_or_recycle_after_exhaustion",
           "[multiplayer][entity_identity]" )
{
    CHECK_THROWS_AS( cata_mp::entity_registry( 0 ), std::invalid_argument );
    CHECK_THROWS_AS( cata_mp::entity_registry( static_cast<uint32_t>( INT_MAX ) + 1 ),
                     std::invalid_argument );
    cata_mp::entity_registry ids( 2 );
    monster mon( mon_test_zombie );
    vehicle bike( vehicle_prototype_bicycle );
    CHECK( ids.assign( mon ) == 1 );
    CHECK( ids.assign( bike ) == 2 );
    CHECK( ids.assign( mon ) == 1 );
    CHECK( ids.assign( bike ) == 2 );
    monster extra( mon_test_zombie );
    CHECK_THROWS_AS( ids.assign( extra ), std::overflow_error );
    CHECK( ids.known_id( extra ) == 0 );
    CHECK( ids.known_id( mon ) == 1 );
}

TEST_CASE( "mp_entity_registry_prunes_destroyed_incarnations_during_churn",
           "[multiplayer][entity_identity]" )
{
    cata_mp::entity_registry ids;
    monster live( mon_test_zombie );
    const auto live_id = ids.assign( live );
    uint32_t previous = live_id;
    for( int i = 0; i < 256; ++i ) {
        monster transient( mon_test_zombie );
        const auto id = ids.assign( transient );
        REQUIRE( id > previous );
        previous = id;
    }
    CHECK( ids.retained_entries() <= 64 );
    CHECK( ids.known_id( live ) == live_id );
    CHECK( ids.assign( live ) == live_id );
}

TEST_CASE( "mp_monster_mirrors_are_bijective_and_session_owned",
           "[multiplayer][entity_identity]" )
{
    cata_mp::monster_mirrors mirrors;
    monster first( mon_test_zombie );
    monster copy( first );
    const auto rng_before = rng_get_engine();
    CHECK_FALSE( mirrors.bind( 0, first ) );
    CHECK_FALSE( mirrors.bind( static_cast<uint32_t>( INT_MAX ) + 1, first ) );
    REQUIRE( mirrors.bind( 7, first ) );
    CHECK( mirrors.bind( 7, first ) );
    CHECK_FALSE( mirrors.bind( 8, first ) );
    CHECK_FALSE( mirrors.bind( 7, copy ) );
    CHECK( mirrors.known_id( copy ) == 0 );
    CHECK( mirrors.bind( 8, copy ) );
    CHECK( mirrors.find( 7 ) == &first );
    CHECK( mirrors.find( 8 ) == &copy );
    cata_mp::monster_mirrors other;
    CHECK( other.known_id( first ) == 0 );
    CHECK( other.bind( 7, copy ) );
    CHECK( other.find( 7 ) == &copy );
    CHECK( mirrors.find( 7 ) == &first );
    other = cata_mp::monster_mirrors();
    CHECK_FALSE( other.find( 7 ) );
    CHECK( other.known_id( copy ) == 0 );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "mp_monster_mirrors_retire_unloaded_incarnations_but_preserve_pending_death_reports",
           "[multiplayer][entity_identity]" )
{
    creature_tracker tracker;
    cata_mp::monster_mirrors mirrors;
    auto original = make_shared_fast<monster>( mon_test_zombie, tripoint_bub_ms( 0, 0, 0 ) );
    REQUIRE( tracker.add( original ) );
    REQUIRE( mirrors.bind( 11, *original ) );
    mirrors.begin_sync( tracker );
    CHECK( mirrors.find( 11 ) == original.get() );
    original->set_hp( 0 );
    REQUIRE( original->is_dead() );
    mirrors.begin_sync( tracker );
    CHECK( mirrors.find( 11 ) == original.get() );
    CHECK( mirrors.known_id( *original ) == 11 );
    tracker.remove( *original );
    mirrors.begin_sync( tracker );
    CHECK_FALSE( mirrors.find( 11 ) );
    CHECK( mirrors.known_id( *original ) == 0 );
    auto replacement = make_shared_fast<monster>( mon_test_zombie, tripoint_bub_ms( 0, 0, 0 ) );
    REQUIRE( tracker.add( replacement ) );
    REQUIRE( mirrors.bind( 11, *replacement ) );
    CHECK( mirrors.find( 11 ) == replacement.get() );
    original.reset();
    CHECK( mirrors.find( 11 ) == replacement.get() );
}

TEST_CASE( "mp_monster_mirrors_reject_reused_addresses_and_moved_native_identity",
           "[multiplayer][entity_identity]" )
{
    cata_mp::monster_mirrors mirrors;
    std::optional<monster> mon( std::in_place, mon_test_zombie );
    REQUIRE( mirrors.bind( 19, *mon ) );
    const auto *address = &*mon;
    mon.reset();
    CHECK_FALSE( mirrors.find( 19 ) );
    mon.emplace( mon_test_zombie );
    REQUIRE( &*mon == address );
    CHECK( mirrors.known_id( *mon ) == 0 );
    REQUIRE( mirrors.bind( 19, *mon ) );
    monster moved( std::move( *mon ) );
    CHECK_FALSE( mirrors.find( 19 ) );
    CHECK( mirrors.known_id( moved ) == 0 );
    REQUIRE( mirrors.bind( 19, moved ) );
    CHECK( mirrors.find( 19 ) == &moved );
}
