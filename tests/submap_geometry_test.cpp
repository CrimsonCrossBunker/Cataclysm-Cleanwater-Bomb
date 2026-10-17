#include <array>
#include <cstddef>
#include <memory>
#include <new>
#include <set>
#include <sstream>
#include <thread>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "json.h"
#include "submap.h"
#include "type_id.h"

TEST_CASE( "submap_geometry_identity_tracks_moves_replacement_and_address_reuse",
           "[submap][submap_geometry]" )
{
    submap first;
    first.set_all_ter( ter_id( "t_floor" ) );
    const auto original = first.geometry_stamp();
    REQUIRE( original.first != 0 );
    submap moved( std::move( first ) );
    CHECK( moved.geometry_stamp() == original );
    CHECK( first.geometry_stamp().first == 0 );
    first.set_all_ter( ter_id( "t_wall" ) );
    CHECK( first.geometry_stamp().first != 0 );
    CHECK( first.geometry_stamp().first != moved.geometry_stamp().first );
    submap target;
    const auto replaced = target.geometry_stamp();
    target = std::move( moved );
    CHECK( target.geometry_stamp() == original );
    CHECK( target.geometry_stamp() != replaced );
    CHECK( moved.geometry_stamp().first == 0 );

    alignas( submap ) std::array<std::byte, sizeof( submap )> storage;
    submap *old = new( storage.data() ) submap;
    const auto before_reuse = old->geometry_stamp();
    old->~submap();
    submap *fresh = new( storage.data() ) submap;
    CHECK( fresh->geometry_stamp() != before_reuse );
    fresh->~submap();
}

TEST_CASE( "submap_geometry_stamps_are_runtime_only_and_not_gameplay_state",
           "[submap][submap_geometry]" )
{
    submap sm;
    sm.set_all_ter( ter_id( "t_floor" ) );
    const auto store = [&]() {
        std::ostringstream stream;
        JsonOut out( stream );
        out.start_object();
        sm.store( out );
        out.end_object();
        return stream.str();
    };
    const auto before = sm.geometry_stamp();
    const std::string saved = store();
    sm.set_ter( point_sm_ms{ 0, 0 }, ter_id( "t_floor" ) );
    sm.set_furn( point_sm_ms{ 0, 0 }, furn_id( "f_null" ) );
    CHECK( sm.geometry_stamp() != before );
    CHECK( store() == saved );
    CHECK( saved.find( "geometry" ) == std::string::npos );
}

TEST_CASE( "submap_geometry_identity_allocation_is_safe_for_independent_owners",
           "[submap][submap_geometry]" )
{
    // Return the empty storages to the main thread for destruction. Workers
    // never touch loaded map state, items, registries or saved geometry.
    std::array<std::vector<std::unique_ptr<submap>>, 2> owners;
    const auto create = [&]( unsigned owner ) {
        for( int i = 0; i < 64; ++i ) {
            owners[owner].push_back( std::make_unique<submap>() );
        }
    };
    std::thread first( create, 0 );
    std::thread second( create, 1 );
    first.join();
    second.join();
    std::set<std::uint64_t> identities;
    for( const auto &owner : owners ) {
        for( const auto &sm : owner ) {
            CHECK( sm->geometry_stamp().first != 0 );
            CHECK( identities.insert( sm->geometry_stamp().first ).second );
        }
    }
}
