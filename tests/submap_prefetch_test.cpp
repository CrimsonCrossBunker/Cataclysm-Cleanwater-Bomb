#include <chrono>
#include <filesystem>
#include <fstream>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <system_error>
#include <thread>

#include "cata_catch.h"
#include "compute_budget.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "json_loader_buffer.h"
#include "submap_prefetch.h"
#include "zzip.h"

namespace
{
class prefetch_fixture
{
    public:
        prefetch_fixture() {
            for( int i = 0; i < 1000; ++i ) {
                const std::filesystem::path candidate =
                    std::filesystem::temp_directory_path() /
                    std::filesystem::u8path( "ccb-prefetch-test-" + std::to_string( i ) );
                std::error_code error;
                if( std::filesystem::create_directory( candidate, error ) ) {
                    root = candidate;
                    break;
                }
                REQUIRE( ( !error || error == std::errc::file_exists ) );
            }
            REQUIRE_FALSE( root.empty() );
        }
        ~prefetch_fixture() {
            std::error_code error;
            std::filesystem::remove_all( root, error );
        }
        submap_prefetcher::request_t plain( int x, const std::string &bytes ) const {
            const std::filesystem::path file =
                root / std::filesystem::u8path( std::to_string( x ) + ".map" );
            std::ofstream out( file, std::ios::binary );
            out << bytes;
            REQUIRE( out.good() );
            submap_prefetcher::request_t request;
            request.om = tripoint_abs_omt( x, 0, 0 );
            request.quad_path = file;
            return request;
        }
        submap_prefetcher::request_t compressed( int x, std::string_view bytes ) const {
            const std::filesystem::path file =
                root / std::filesystem::u8path( std::to_string( x ) + ".zzip" );
            const std::filesystem::path entry = std::filesystem::u8path( "quad.map" );
            {
                auto archive = zzip::load( file );
                REQUIRE( archive );
                REQUIRE( archive->add_file( entry, bytes ) );
            }
            submap_prefetcher::request_t request;
            request.om = tripoint_abs_omt( x, 0, 0 );
            request.compressed = true;
            request.zzip_path = file;
            request.entry_name = entry;
            return request;
        }
        std::filesystem::path root;
};

void wait_until_idle( submap_prefetcher &prefetch )
{
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 5 );
    while( prefetch.inspect().pending != 0 && std::chrono::steady_clock::now() < deadline ) {
        std::this_thread::sleep_for( std::chrono::milliseconds( 1 ) );
    }
    REQUIRE( prefetch.inspect().pending == 0 );
}
} // namespace

TEST_CASE( "prefetch_transfers_owned_bytes_without_world_or_parser_access", "[prefetch]" )
{
    prefetch_fixture fixture;
    byte_budget budget( 8192 );
    submap_prefetcher prefetch( budget, 8 );
    const std::string text = "[1,2,3]";
    const submap_prefetcher::request_t request = fixture.plain( 0, text );
    REQUIRE( prefetch.request( request, 0 ) );
    wait_until_idle( prefetch );
    auto data = prefetch.take( request.om );
    REQUIRE( data );
    CHECK( std::string( data->bytes.get(), data->size ) == text );
    prefetch.clear();
    const std::size_t retained = budget.used();
    CHECK( retained >= text.size() + 1 );
    std::optional<JsonValue> parsed = json_from_owned_buffer( data->bytes );
    data.reset();
    CHECK( parsed->get_array().size() == 3 );
    CHECK( budget.used() == retained );
    parsed.reset();
    CHECK( budget.used() == 0 );
}

TEST_CASE( "prefetch_prioritizes_near_work_with_bounded_pending_and_ready_entries", "[prefetch]" )
{
    prefetch_fixture fixture;
    byte_budget budget( 8192 );
    submap_prefetcher prefetch( budget, 2 );
    const submap_prefetcher::request_t distant_request = fixture.plain( 30, "far" );
    const submap_prefetcher::request_t middle = fixture.plain( 20, "middle" );
    const submap_prefetcher::request_t nearby_request = fixture.plain( 0, "near" );
    prefetch.pause();
    REQUIRE( prefetch.request( distant_request, 30 ) );
    REQUIRE( prefetch.request( middle, 20 ) );
    CHECK( prefetch.request( middle, 20 ) );
    CHECK( prefetch.inspect().pending == 2 );
    CHECK_FALSE( prefetch.request( fixture.plain( 40, "rejected" ), 40 ) );
    REQUIRE( prefetch.request( nearby_request, 0 ) );
    CHECK( prefetch.inspect().queued == 2 );
    prefetch.resume();
    wait_until_idle( prefetch );
    CHECK_FALSE( prefetch.take( distant_request.om ) );
    CHECK( prefetch.inspect().ready == 2 );
    // Ready bytes participate in the same entry budget as pending reads.
    const submap_prefetcher::request_t closer = fixture.plain( 5, "closer" );
    REQUIRE( prefetch.request( closer, 5 ) );
    wait_until_idle( prefetch );
    CHECK( prefetch.inspect().ready == 2 );
    CHECK_FALSE( prefetch.take( middle.om ) );
    REQUIRE( prefetch.take( closer.om ) );
    REQUIRE( prefetch.take( nearby_request.om ) );
    prefetch.clear();
    CHECK( budget.used() == 0 );
}

TEST_CASE( "prefetch_pause_invalidates_old_bytes_before_owner_writes", "[prefetch][save]" )
{
    const bool compressed = GENERATE( false, true );
    prefetch_fixture fixture;
    byte_budget budget( 4 * 1024 * 1024 );
    submap_prefetcher prefetch( budget, 8 );
    const auto write = [&]( const std::string & text ) {
        return compressed ? fixture.compressed( 0, text ) : fixture.plain( 0, text );
    };
    submap_prefetcher::request_t request = write( "old" );
    REQUIRE( prefetch.request( request, 0 ) );
    wait_until_idle( prefetch );
    REQUIRE( prefetch.inspect().ready == 1 );
    prefetch.pause();
    CHECK_FALSE( prefetch.take( request.om ) );
    request = write( "new" );
    prefetch.pause();
    REQUIRE( prefetch.request( request, 0 ) );
    prefetch.resume();
    CHECK( prefetch.inspect().queued == 1 );
    prefetch.resume();
    wait_until_idle( prefetch );
    {
        auto result = prefetch.take( request.om );
        REQUIRE( result );
        CHECK( std::string( result->bytes.get(), result->size ) == "new" );
    }
    prefetch.clear();
    CHECK( budget.used() == 0 );
}

TEST_CASE( "prefetch_budget_failure_is_a_retryable_cache_miss", "[prefetch]" )
{
    prefetch_fixture fixture;
    byte_budget budget( 1024 );
    submap_prefetcher prefetch( budget, 4 );
    const submap_prefetcher::request_t small = fixture.plain( 0, "small" );
    REQUIRE( budget.acquire( budget.limit() ) );
    CHECK_FALSE( prefetch.request( small, 0 ) );
    CHECK( prefetch.inspect().pending == 0 );
    CHECK( prefetch.inspect().queued == 0 );
    budget.release( budget.limit() );

    REQUIRE( prefetch.request( fixture.plain( 1, std::string( 2048, 'x' ) ), 0 ) );
    wait_until_idle( prefetch );
    CHECK_FALSE( prefetch.take( tripoint_abs_omt( 1, 0, 0 ) ) );
    REQUIRE( prefetch.request( small, 0 ) );
    wait_until_idle( prefetch );
    REQUIRE( prefetch.take( small.om ) );
    prefetch.clear();
    CHECK( budget.used() == 0 );
}

TEST_CASE( "prefetch_failed_result_publication_does_not_terminate_worker", "[prefetch]" )
{
    prefetch_fixture fixture;
    byte_budget budget( 1024 );
    submap_prefetcher prefetch( budget, 4 );
    // Sweep payload sizes near the quota. Some leave room for decoding and
    // ownership, but not for the larger completed-map node. This injects real
    // allocation failures at publication without any test hook in the worker.
    for( std::size_t size = 600; size < 1024; size += 8 ) {
        auto request = fixture.plain( 0, std::string( size, 'x' ) );
        REQUIRE( prefetch.request( request, 0 ) );
        wait_until_idle( prefetch );
        prefetch.take( request.om );
        CHECK( budget.used() <= budget.limit() );
    }
    CHECK( prefetch.inspect().publication_failures > 0 );
    auto request = fixture.plain( 0, "recovered" );
    REQUIRE( prefetch.request( request, 0 ) );
    wait_until_idle( prefetch );
    {
        auto result = prefetch.take( request.om );
        REQUIRE( result );
        CHECK( std::string( result->bytes.get(), result->size ) == "recovered" );
    }
    prefetch.clear();
    CHECK( budget.used() == 0 );
}

TEST_CASE( "prefetch_cancel_and_reissue_do_not_publish_old_request_bytes", "[prefetch]" )
{
    prefetch_fixture fixture;
    byte_budget budget( 16 * 1024 * 1024 );
    submap_prefetcher prefetch( budget, 8 );
    const auto old = fixture.plain( 0, std::string( 8 * 1024 * 1024, 'o' ) );
    auto current = fixture.plain( 1, "current" );
    current.om = old.om;
    for( int i = 0; i < 8; ++i ) {
        REQUIRE( prefetch.request( old, 0 ) );
        const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 5 );
        while( prefetch.inspect().queued != 0 && std::chrono::steady_clock::now() < deadline ) {
            std::this_thread::yield();
        }
        prefetch.evict_beyond( tripoint_abs_omt( 100, 0, 0 ), 0 );
        REQUIRE( prefetch.request( current, 0 ) );
        wait_until_idle( prefetch );
        auto result = prefetch.take( current.om );
        REQUIRE( result );
        CHECK( std::string( result->bytes.get(), result->size ) == "current" );
    }
    prefetch.clear();
    CHECK( budget.used() == 0 );
}

TEST_CASE( "prefetch_clear_joins_active_work_and_lazy_restart_preserves_pause", "[prefetch]" )
{
    prefetch_fixture fixture;
    byte_budget budget( 4 * 1024 * 1024 );
    submap_prefetcher prefetch( budget, 8 );
    const auto request = fixture.compressed( 0, std::string( 1024 * 1024, 'a' ) );
    for( int i = 0; i < 8; ++i ) {
        REQUIRE( prefetch.request( request, 0 ) );
        prefetch.clear();
        CHECK( budget.used() == 0 );
        CHECK( prefetch.inspect().pending == 0 );
    }
    prefetch.pause();
    prefetch.clear();
    REQUIRE( prefetch.request( request, 0 ) );
    CHECK( prefetch.inspect().queued == 1 );
    prefetch.resume();
    wait_until_idle( prefetch );
    REQUIRE( prefetch.take( request.om ) );
    prefetch.clear();
    CHECK( budget.used() == 0 );
}

TEST_CASE( "private_zstd_context_respects_budget_and_releases_it", "[prefetch][zzip]" )
{
    byte_budget denied( 1 );
    CHECK( zzip::create_private_dctx( {}, &denied ) == nullptr );
    CHECK( denied.used() == 0 );
    byte_budget allowed( 4 * 1024 * 1024 );
    auto *context = zzip::create_private_dctx( {}, &allowed );
    REQUIRE( context );
    CHECK( allowed.used() > 0 );
    zzip::destroy_private_dctx( context );
    CHECK( allowed.used() == 0 );
    CHECK_THROWS_AS( json_from_owned_buffer( {} ), JsonError );
}
