#include <cstddef>
#include <filesystem>
#include <fstream>
#include <functional>
#include <initializer_list>
#include <iterator>
#include <limits>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <system_error>
#include <vector>

#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "debug.h"
#include "flexbuffer_cache.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "ofstream_wrapper.h"
#include "zzip.h"
#include "zzip_stack.h"

static std::filesystem::path file_io_directory()
{
    for( int attempt = 0; attempt < 100; ++attempt ) {
        const std::filesystem::path directory = std::filesystem::temp_directory_path() /
                                                std::filesystem::u8path( "ccb-file-io-test-" + std::to_string( attempt ) );
        if( std::filesystem::create_directory( directory ) ) {
            return directory;
        }
    }
    FAIL( "Could not create a file I/O test directory" );
    return {};
}



TEST_CASE( "file_writes_commit_only_on_success", "[utility][file_io][nogame]" )
{
    const std::filesystem::path directory = file_io_directory();
    on_out_of_scope cleanup( [&directory]() {
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const std::filesystem::path path = directory /
                                       std::filesystem::u8path( "\u5b591.json" );
    const bool existing_file = GENERATE( false, true );
    const bool typed_path = GENERATE( false, true );
    const bool return_status = GENERATE( false, true );
    const auto write = [&]( const std::function<void( std::ostream & )> &writer ) {
        if( typed_path ) {
            const cata_path target( cata_path::root_path::unknown, path );
            if( return_status ) {
                return write_to_file( target, writer, nullptr );
            }
            write_to_file( target, writer );
        } else {
            if( return_status ) {
                return write_to_file( path.u8string(), writer, nullptr );
            }
            write_to_file( path.u8string(), writer );
        }
        return true;
    };
    if( existing_file ) {
        std::ofstream previous( path, std::ios::binary );
        previous << "previous contents";
        REQUIRE( previous.good() );
    }

    const auto check_previous = [&]() {
        CHECK( std::filesystem::exists( path ) == existing_file );
        if( existing_file ) {
            std::ifstream input( path, std::ios::binary );
            const std::string contents( ( std::istreambuf_iterator<char>( input ) ),
                                        std::istreambuf_iterator<char>() );
            CHECK( contents == "previous contents" );
        }
        for( const std::filesystem::directory_entry &entry :
             std::filesystem::directory_iterator( directory ) ) {
            CHECK( entry.path() == path );
        }
    };
    const auto expect_failure = [&]( const std::function<void( std::ostream & )> &writer ) {
        if( return_status ) {
            CHECK_FALSE( write( writer ) );
        } else {
            CHECK_THROWS( write( writer ) );
        }
        check_previous();
    };

    SECTION( "successful_write_replaces_the_target" ) {
        REQUIRE( write( []( std::ostream & output ) {
            output << "complete contents";
        } ) );
        std::ifstream input( path, std::ios::binary );
        const std::string contents( ( std::istreambuf_iterator<char>( input ) ),
                                    std::istreambuf_iterator<char>() );
        CHECK( contents == "complete contents" );
    }

    SECTION( "exception_before_writing_preserves_the_target" ) {
        expect_failure( []( std::ostream & ) {
            throw std::runtime_error( "serialization failed" );
        } );
    }

    SECTION( "exception_after_writing_preserves_the_target" ) {
        expect_failure( []( std::ostream & output ) {
            output << "partial contents";
            throw std::runtime_error( "serialization failed" );
        } );
    }

    SECTION( "stream_failure_preserves_the_target" ) {
        expect_failure( []( std::ostream & output ) {
            output << "partial contents";
            output.setstate( std::ios::failbit );
        } );
    }

    SECTION( "stream_exception_preserves_the_target" ) {
        expect_failure( []( std::ostream & output ) {
            output.exceptions( std::ios::failbit | std::ios::badbit );
            output << "partial contents";
            output.setstate( std::ios::failbit );
        } );
    }

    SECTION( "uncommitted_wrapper_preserves_the_target" ) {
        {
            ofstream_wrapper output( path, std::ios::binary );
            output.stream() << "uncommitted contents";
        }
        check_previous();
    }

    SECTION( "failed_rename_retains_complete_temporary_file" ) {
        const std::filesystem::path blocked = directory / std::filesystem::u8path( "blocked" );
        REQUIRE( std::filesystem::create_directory( blocked ) );
        {
            ofstream_wrapper output( blocked, std::ios::binary );
            output.stream() << "complete contents";
            CHECK_THROWS_AS( output.close(), std::runtime_error );
        }
        CHECK( std::filesystem::is_directory( blocked ) );
        int recovery_files = 0;
        for( const std::filesystem::directory_entry &entry :
             std::filesystem::directory_iterator( directory ) ) {
            if( entry.path() != path && entry.path() != blocked ) {
                std::ifstream input( entry.path(), std::ios::binary );
                const std::string contents( ( std::istreambuf_iterator<char>( input ) ),
                                            std::istreambuf_iterator<char>() );
                CHECK( contents == "complete contents" );
                ++recovery_files;
            }
        }
        CHECK( recovery_files == 1 );
    }
}

TEST_CASE( "corrupt_json_reads_do_not_default", "[utility][file_io][nogame]" )
{
    const std::filesystem::path directory = file_io_directory();
    on_out_of_scope cleanup( [&directory]() {
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const cata_path path( cata_path::root_path::unknown,
                          directory / std::filesystem::u8path( "contents.json" ) );
    const std::string contents = GENERATE( std::string(), std::string( " " ),
                                           std::string( "{" ), std::string( "\0payload", 8 ) );
    write_to_file( path, [&]( std::ostream & output ) {
        output.write( contents.data(), contents.size() );
    } );
    CHECK_THROWS( json_loader::from_path( path ) );
    CHECK( read_whole_file( path ) == contents );
}

TEST_CASE( "json_file_offsets_are_bounded", "[utility][file_io][nogame]" )
{
    const std::filesystem::path directory = file_io_directory();
    on_out_of_scope cleanup( [&directory]() {
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const cata_path path( cata_path::root_path::unknown,
                          directory / std::filesystem::u8path( "contents.json" ) );
    const std::string contents = std::string( 1, ' ' ) + "\n{\"value\":1}";
    write_to_file( path, [&]( std::ostream & output ) {
        output << contents;
    } );
    flexbuffer_cache cache( directory / std::filesystem::u8path( "cache" ), directory );
    const bool warm_cache = GENERATE( false, true );
    if( warm_cache ) {
        REQUIRE_NOTHROW( cache.parse_and_cache( path.get_unrelative_path() ) );
    }
    for( const size_t offset : {
             contents.size(), contents.size() + 1,
             std::numeric_limits<size_t>::max()
         } ) {
        CAPTURE( offset, warm_cache );
        CHECK_THROWS_WITH( json_loader::from_path_at_offset( path, offset ),
                           Catch::Matchers::Contains( "offset" ) );
        CHECK_THROWS_WITH( cache.parse_and_cache( path.get_unrelative_path(), offset ),
                           Catch::Matchers::Contains( "offset" ) );
    }
    CHECK( json_loader::from_path_at_offset( path, 2 ).get_object().get_int( "value" ) == 1 );
    CHECK_NOTHROW( cache.parse_and_cache( path.get_unrelative_path(), 2 ) );
    CHECK_NOTHROW( cache.parse_and_cache( path.get_unrelative_path() ) );
}

TEST_CASE( "file_reads_preserve_complete_contents", "[utility][file_io][nogame]" )
{
    const std::filesystem::path directory = file_io_directory();
    on_out_of_scope cleanup( [&directory]() {
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const cata_path path( cata_path::root_path::unknown,
                          directory / std::filesystem::u8path( "contents" ) );
    const std::string contents = GENERATE( std::string(), std::string( "x" ),
                                           std::string( "\x1f" ), std::string( "complete contents" ),
                                           std::string( "\0payload", 8 ) );
    write_to_file( path, [&]( std::ostream & output ) {
        output.write( contents.data(), contents.size() );
    } );
    CHECK( read_whole_file( path ) == contents );
    CHECK( read_whole_file( path.get_unrelative_path() ) == contents );
    CHECK( read_whole_file( path.generic_u8string() ) == contents );
    auto input = read_maybe_compressed_file( path );
    REQUIRE( input != nullptr );
    CHECK( std::string( ( std::istreambuf_iterator<char>( *input ) ),
                        std::istreambuf_iterator<char>() ) == contents );
}

TEST_CASE( "archive_creation_rejects_unreadable_sources", "[utility][file_io][archive_io][nogame]" )
{
    const std::filesystem::path directory = file_io_directory();
    on_out_of_scope cleanup( [&]() {
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const std::filesystem::path folder = directory / std::filesystem::u8path( "source" );
    REQUIRE( std::filesystem::create_directory( folder ) );
    const std::filesystem::path source = folder / std::filesystem::u8path( "entry" );
    const std::filesystem::path archive_path = directory / std::filesystem::u8path( "save.zzip" );
    CHECK_FALSE( zzip::create_from_folder_with_files( archive_path, folder, { source }, 0,
                 {} ).has_value() );
    write_to_file( source.u8string(), []( std::ostream & output ) {
        output << "retained source";
    } );
    auto archive = zzip::create_from_folder_with_files( archive_path, folder, { source }, 0, {} );
    REQUIRE( archive.has_value() );
    CHECK( read_from_zzip_optional( *archive,
    std::filesystem::u8path( "entry" ), [&]( std::string_view contents ) {
        CHECK( contents == "retained source" );
    } ) );
    CHECK( read_whole_file( source ) == "retained source" );
}

TEST_CASE( "archive_dictionary_failures_are_recoverable", "[utility][file_io][archive_io][nogame]" )
{
    const std::filesystem::path directory = file_io_directory();
    on_out_of_scope cleanup( [&]() {
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const std::filesystem::path path = directory / std::filesystem::u8path( "save.zzip" );
    const std::string failure = GENERATE( "missing", "empty", "directory" );
    const std::filesystem::path dictionary = directory / std::filesystem::u8path( "dictionary-" +
            failure );
    {
        std::optional<zzip> archive = zzip::load( path );
        REQUIRE( archive.has_value() );
        REQUIRE( archive->add_file( std::filesystem::u8path( "entry" ), "original" ) );
    }
    const auto original = read_whole_file( path );
    REQUIRE( original.has_value() );
    CAPTURE( failure );
    if( failure == "empty" ) {
        write_to_file( dictionary.u8string(), []( std::ostream & ) {} );
    } else if( failure == "directory" ) {
        REQUIRE( std::filesystem::create_directory( dictionary ) );
    }
    CHECK_FALSE( zzip::load( path, dictionary ).has_value() );
    CHECK( read_whole_file( path ) == original );
    if( failure != "missing" ) {
        REQUIRE( std::filesystem::remove( dictionary ) );
    }
    write_to_file( dictionary.u8string(), []( std::ostream & output ) {
        output << "dictionary";
    } );
    std::optional<zzip> archive = zzip::load( path, dictionary );
    REQUIRE( archive.has_value() );
    REQUIRE( archive->add_file( std::filesystem::u8path( "entry" ), "updated" ) );
    bool read = false;
    CHECK( read_from_zzip_optional( *archive,
    std::filesystem::u8path( "entry" ), [&]( std::string_view contents ) {
        read = true;
        CHECK( contents == "updated" );
    } ) );
    CHECK( read );
    CHECK_FALSE( read_from_zzip_optional( *archive,
    std::filesystem::u8path( "missing" ), [&]( std::string_view ) {
        FAIL( "Missing archive member called its reader" );
    } ) );
}

TEST_CASE( "archive_stack_open_failures_are_recoverable", "[utility][file_io][archive_io][nogame]" )
{
    const std::filesystem::path directory = file_io_directory();
    on_out_of_scope cleanup( [&]() {
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const std::string tier = GENERATE( "cold", "warm", "hot" );
    CAPTURE( tier );
    const std::filesystem::path blocked = directory / std::filesystem::u8path( "memory" ) /
                                          std::filesystem::u8path( "memory." + tier + ".zzip" );
    std::filesystem::create_directories( blocked );
    if( tier != "cold" ) {
        auto cold = zzip::load( directory / std::filesystem::u8path( "memory" ) /
                                std::filesystem::u8path( "memory.cold.zzip" ) );
        REQUIRE( cold.has_value() );
        REQUIRE( cold->add_file( std::filesystem::u8path( "entry" ), "stale contents" ) );
    }
    auto stack = zzip_stack::load( directory / std::filesystem::u8path( "memory" ) );
    REQUIRE( stack != nullptr );
    CHECK_THROWS_AS( stack->get_entries(), std::runtime_error );
    const std::string errors = capture_debugmsg_during( [&]() {
        CHECK_FALSE( read_from_zzip_optional( stack,
        std::filesystem::u8path( "entry" ), [&]( std::string_view ) {
            FAIL( "Unreadable archive called its reader" );
        } ) );
    } );
    CHECK( errors.find( blocked.filename().u8string() ) != std::string::npos );
    REQUIRE( std::filesystem::remove( blocked ) );
    REQUIRE( stack->add_file( std::filesystem::u8path( "entry" ), "contents" ) );
    CHECK( stack->get_entries().size() == 1 );
    CHECK( read_from_zzip_optional( stack,
    std::filesystem::u8path( "entry" ), [&]( std::string_view contents ) {
        CHECK( contents == "contents" );
    } ) );
}

TEST_CASE( "compressed_file_reads_reject_truncation", "[utility][file_io][nogame]" )
{
    const std::filesystem::path directory = file_io_directory();
    on_out_of_scope cleanup( [&directory]() {
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const cata_path path( cata_path::root_path::unknown,
                          directory / std::filesystem::u8path( "contents" ) );
    const char compressed[] =
        "\x1f\x8b\x08\x00\x00\x00\x00\x00\x02\xff\x4b\xce\xcf\x2d\xc8\x49\x2d\x49\x55"
        "\x48\xce\xcf\x2b\x49\xcd\x2b\x29\x06\x00\x65\x49\xc0\x04\x11\x00\x00\x00";
    const bool truncated = GENERATE( false, true );
    write_to_file( path, [&]( std::ostream & output ) {
        output.write( compressed, sizeof( compressed ) - ( truncated ? 9 : 1 ) );
    } );
    if( truncated ) {
        CHECK_FALSE( capture_debugmsg_during( [&]() {
            CHECK_FALSE( read_whole_file( path ).has_value() );
        } ).empty() );
        CHECK_FALSE( capture_debugmsg_during( [&]() {
            CHECK( read_maybe_compressed_file( path ) == nullptr );
        } ).empty() );
    } else {
        CHECK( read_whole_file( path ) == "complete contents" );
        auto input = read_maybe_compressed_file( path );
        REQUIRE( input != nullptr );
        CHECK( std::string( ( std::istreambuf_iterator<char>( *input ) ),
                            std::istreambuf_iterator<char>() ) == "complete contents" );
    }
}
