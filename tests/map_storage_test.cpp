#include <chrono>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <memory>
#include <stdexcept>
#include <string>
#include <system_error>
#include <thread>

#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "game.h"
#include "map.h"
#include "map_storage_context.h"
#include "mapbuffer.h"
#include "path_info.h"
#include "rng.h"
#include "submap.h"
#include "type_id.h"
#include "world_identity.h"
#include "worldfactory.h"

static const ter_str_id ter_t_dirt( "t_dirt" );
static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_soil( "t_soil" );
static const ter_str_id ter_t_wall( "t_wall" );

namespace
{
class storage_fixture
{
    public:
        storage_fixture() {
            for( int i = 0; i < 1000; ++i ) {
                const auto candidate = std::filesystem::temp_directory_path() /
                                       ( "ccb-map-storage-test-" + std::to_string( i ) );
                std::error_code error;
                if( std::filesystem::create_directory( candidate, error ) ) {
                    root = candidate;
                    break;
                }
                REQUIRE( ( !error || error == std::errc::file_exists ) );
            }
            REQUIRE_FALSE( root.empty() );
        }
        ~storage_fixture() {
            std::error_code error;
            std::filesystem::remove_all( root, error );
        }
        map_storage_context context( const std::string &world, const std::string &dimension,
                                     bool compressed ) const {
            const auto directory = root / world;
            std::filesystem::create_directories( directory );
            // Different world dictionaries exercise namespace ownership as well
            // as the archive path. Raw content dictionaries are supported by ZSTD.
            std::ofstream dictionary( directory / "maps.dict", std::ios::binary );
            dictionary << std::string( 512, world.front() );
            REQUIRE( dictionary.good() );
            return map_storage_context( world_id( std::string( 32, world.front() ) ),
                                        dimension_id( dimension ),
                                        cata_path( cata_path::root_path::unknown, directory ), compressed );
        }
        std::filesystem::path root;
};

void insert_quad( mapbuffer &buffer, const tripoint_abs_sm &base, const ter_str_id &terrain )
{
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            auto sm = std::make_unique<submap>();
            sm->set_all_ter( terrain, true );
            sm->set_ter( point_sm_ms::zero, ter_t_wall );
            REQUIRE_FALSE( sm->is_uniform() );
            REQUIRE( buffer.add_submap( base + point_rel_sm( x, y ), sm ) );
        }
    }
}

void check_quad( mapbuffer &buffer, const tripoint_abs_sm &base, const ter_str_id &terrain )
{
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            submap *sm = buffer.lookup_submap( base + point_rel_sm( x, y ) );
            REQUIRE( sm );
            CHECK( sm->get_ter( point_sm_ms::zero ) == ter_t_wall );
            CHECK( sm->get_ter( point_sm_ms( 1, 1 ) ) == terrain );
        }
    }
}

void wait_for_prefetch( mapbuffer &buffer )
{
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 5 );
    while( buffer.prefetch_status().pending != 0 && std::chrono::steady_clock::now() < deadline ) {
        std::this_thread::sleep_for( std::chrono::milliseconds( 1 ) );
    }
    REQUIRE( buffer.prefetch_status().pending == 0 );
    REQUIRE( buffer.prefetch_status().ready == 1 );
}
} // namespace

TEST_CASE( "map_storage_captures_resolved_paths_and_dimension_namespace", "[map_storage]" )
{
    storage_fixture fixture;
    const std::string old_save = PATH_INFO::savedir();
    on_out_of_scope restore( [&]() {
        PATH_INFO::set_savedir( old_save );
    } );
    PATH_INFO::set_savedir( fixture.root.generic_u8string() );
    const cata_path relative( cata_path::root_path::save, "a" );
    const world_id id( std::string( 32, 'a' ) );
    const map_storage_context normal( id, dimension_id( "default" ), relative, false );
    const map_storage_context other( id, dimension_id( "elsewhere" ), relative, true );
    PATH_INFO::set_savedir( ( fixture.root / "moved" ).generic_u8string() );
    CHECK( normal.world() == id );
    CHECK( other.dimension() == dimension_id( "elsewhere" ) );
    CHECK( normal.directory().get_unrelative_path() == fixture.root / "a" );
    CHECK( other.directory().get_unrelative_path() == fixture.root / "a/dimensions/elsewhere" );
    CHECK( other.dictionary().get_unrelative_path() == fixture.root / "a/maps.dict" );
    CHECK_FALSE( normal.compressed() );
    CHECK( other.compressed() );
    CHECK_THROWS_AS( map_storage_context( world_id(), dimension_id( "default" ), relative, false ),
                     std::invalid_argument );
    CHECK_THROWS_AS( map_storage_context( id, dimension_id( "../other" ), relative, false ),
                     std::invalid_argument );
}

TEST_CASE( "map_buffers_keep_same_coordinates_in_separate_storage_namespaces", "[map_storage]" )
{
    const bool compressed = GENERATE( false, true );
    const bool different_world = GENERATE( false, true );
    CAPTURE( compressed, different_world );
    storage_fixture fixture;
    mapbuffer first( fixture.context( "a", "default", compressed ) );
    mapbuffer second( fixture.context( different_world ? "b" : "a", "elsewhere", compressed ) );
    const tripoint_abs_sm base( 0, 0, 0 );
    const auto rng_before = rng_get_engine();
    insert_quad( first, base, ter_t_dirt );
    insert_quad( second, base, ter_t_floor );
    first.save( true );
    second.save();
    CHECK( first.begin() == first.end() );
    CHECK( second.begin() != second.end() );
    first.clear();
    second.clear();
    check_quad( second, base, ter_t_floor );
    check_quad( first, base, ter_t_dirt );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "legacy_map_buffer_binds_on_insertion_and_rebinds_only_after_clear", "[map_storage]" )
{
    storage_fixture fixture;
    const std::string old_save = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    on_out_of_scope restore( [&]() {
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_save );
    } );
    PATH_INFO::set_savedir( fixture.root.generic_u8string() );
    WORLD first_world( "a" );
    WORLD second_world( "b" );
    std::filesystem::create_directories( first_world.folder_path().get_unrelative_path() );
    std::filesystem::create_directories( second_world.folder_path().get_unrelative_path() );
    const map_storage_context first_context( first_world.identity(), g->get_dimension_prefix(),
            first_world.folder_path(), false );
    const map_storage_context second_context( second_world.identity(), g->get_dimension_prefix(),
            second_world.folder_path(), false );
    world_generator->active_world = &first_world;
    mapbuffer legacy;
    insert_quad( legacy, tripoint_abs_sm::zero, ter_t_dirt );
    world_generator->active_world = &second_world;
    legacy.save( true );
    mapbuffer first_reader( first_context );
    check_quad( first_reader, tripoint_abs_sm::zero, ter_t_dirt );
    CHECK_FALSE( std::filesystem::exists( second_context.directory().get_unrelative_path() / "maps" ) );
    legacy.clear();
    insert_quad( legacy, tripoint_abs_sm::zero, ter_t_floor );
    legacy.save( true );
    mapbuffer second_reader( second_context );
    check_quad( second_reader, tripoint_abs_sm::zero, ter_t_floor );
}

TEST_CASE( "map_buffer_clear_and_save_do_not_cancel_another_owners_prefetch",
           "[map_storage][prefetch]" )
{
    const bool compressed = GENERATE( false, true );
    storage_fixture fixture;
    const auto first_context = fixture.context( "a", "default", compressed );
    const auto second_context = fixture.context( "b", "default", compressed );
    mapbuffer first( first_context );
    mapbuffer second( second_context );
    const tripoint_abs_sm base( 0, 0, 0 );
    insert_quad( first, base, ter_t_dirt );
    insert_quad( second, base, ter_t_floor );
    first.save( true );
    second.save( true );
    first.prefetch_quad( tripoint_abs_omt::zero, 0 );
    second.prefetch_quad( tripoint_abs_omt::zero, 0 );
    wait_for_prefetch( first );
    wait_for_prefetch( second );
    first.clear();
    CHECK( first.prefetch_status().ready == 0 );
    CHECK( second.prefetch_status().ready == 1 );
    insert_quad( first, base, ter_t_dirt );
    first.save();
    CHECK( second.prefetch_status().ready == 1 );
    // Remove the backing file: synchronous fallback must not conceal a cancelled
    // result or bytes accidentally obtained from the other world's same quad.
    const auto directory = second_context.directory().get_unrelative_path() / "maps";
    REQUIRE( std::filesystem::remove( compressed ? directory / "0.0.0.zzip" :
                                      directory / "0.0.0/0.0.0.map" ) );
    check_quad( second, base, ter_t_floor );
    CHECK( second.prefetch_status().ready == 0 );
}

TEST_CASE( "partial_quad_restores_uniform_submaps_only_in_its_own_buffer", "[map_storage]" )
{
    const bool compressed = GENERATE( false, true );
    storage_fixture fixture;
    const auto context = fixture.context( "a", "default", compressed );
    int lookups = 0;
    mapbuffer buffer( context, [&]( const tripoint_abs_omt & p ) {
        CHECK( p == tripoint_abs_omt::zero );
        ++lookups;
        return oter_id( "solid_earth" );
    } );
    const auto global_size = std::distance( MAPBUFFER.begin(), MAPBUFFER.end() );
    auto sm = std::make_unique<submap>();
    sm->set_all_ter( ter_t_floor );
    REQUIRE( buffer.add_submap( tripoint_abs_sm::zero, sm ) );
    buffer.save( true );
    REQUIRE( buffer.begin() == buffer.end() );
    submap *missing = buffer.lookup_submap( tripoint_abs_sm( 1, 1, 0 ) );
    REQUIRE( missing );
    CHECK( missing->get_ter( point_sm_ms::zero ) == ter_t_soil );
    CHECK( buffer.lookup_submap( tripoint_abs_sm::zero )->get_ter( point_sm_ms::zero ) == ter_t_floor );
    CHECK( lookups == 1 );
    CHECK( std::distance( buffer.begin(), buffer.end() ) == 4 );
    CHECK( std::distance( MAPBUFFER.begin(), MAPBUFFER.end() ) == global_size );
}

TEST_CASE( "failed_map_save_retains_owned_submaps_for_retry", "[map_storage][save]" )
{
    const bool compressed = GENERATE( false, true );
    storage_fixture fixture;
    const auto context = fixture.context( "a", "default", compressed );
    mapbuffer buffer( context );
    const tripoint_abs_sm base( 0, 0, 0 );
    insert_quad( buffer, base, ter_t_floor );
    submap *original = buffer.lookup_submap( base );
    const auto maps = context.directory().get_unrelative_path() / "maps";
    {
        std::ofstream blocked( maps );
        blocked << "not a directory";
        REQUIRE( blocked.good() );
    }
    CHECK_THROWS_AS( buffer.save( true ), std::runtime_error );
    CHECK( buffer.lookup_submap( base ) == original );
    check_quad( buffer, base, ter_t_floor );
    REQUIRE( std::filesystem::remove( maps ) );
    buffer.save( true );
    REQUIRE( buffer.begin() == buffer.end() );
    check_quad( buffer, base, ter_t_floor );
}

TEST_CASE( "resident_map_save_releases_only_outside_submaps", "[map_storage][save]" )
{
    const bool compressed = GENERATE( false, true );
    storage_fixture fixture;
    mapbuffer buffer( fixture.context( "a", "default", compressed ) );
    const map &resident = get_map();
    const auto center = project_to<coords::omt>( resident.get_abs_sub() ) + point_rel_omt( 1, 1 );
    const auto distant = center + point_rel_omt( resident.getmapsize(), 0 );
    const auto inside = project_to<coords::sm>( center );
    const auto outside = project_to<coords::sm>( distant );
    REQUIRE( resident.inbounds( center ) );
    REQUIRE_FALSE( resident.inbounds( distant ) );

    insert_quad( buffer, inside, ter_t_floor );
    insert_quad( buffer, outside, ter_t_dirt );
    REQUIRE( buffer.submap_count() == 8 );

    buffer.save( false, &resident );
    CHECK( buffer.submap_count() == 4 );
    check_quad( buffer, inside, ter_t_floor );
    CHECK( buffer.submap_count() == 4 );
    check_quad( buffer, outside, ter_t_dirt );
    CHECK( buffer.submap_count() == 8 );
}

TEST_CASE( "owned_uniform_maps_persist_without_a_terrain_resolver", "[map_storage][save]" )
{
    const bool compressed = GENERATE( false, true );
    storage_fixture fixture;
    mapbuffer buffer( fixture.context( "a", "default", compressed ) );
    REQUIRE( buffer.generate_uniform_omt( tripoint_abs_sm::zero, oter_id( "solid_earth" ) ) );
    buffer.save( true );
    REQUIRE( buffer.begin() == buffer.end() );
    for( int x = 0; x < 2; ++x ) {
        for( int y = 0; y < 2; ++y ) {
            submap *restored = buffer.lookup_submap( tripoint_abs_sm( x, y, 0 ) );
            REQUIRE( restored );
            CHECK( restored->get_ter( point_sm_ms::zero ) == ter_t_soil );
        }
    }
}
