#include "world_identity_store.h"

#include <filesystem>
#include <fstream>
#include <sstream>
#include <stdexcept>

#include "cata_path.h"
#include "cata_utility.h"
#include "identity_random.h"
#include "json.h"

namespace
{
world_id read_world_identity( const cata_path &path )
{
    const auto file = path.get_unrelative_path();
    const auto size = std::filesystem::file_size( file );
    if( size > 1024 ) {
        throw std::runtime_error( "World identity exceeds 1 KiB" );
    }
    std::ifstream input( file, std::ios::binary );
    std::string document( size, '\0' );
    if( !input.read( document.data(), document.size() ) ) {
        throw std::runtime_error( "Cannot read world identity" );
    }
    try {
        std::istringstream stream( document );
        TextJsonIn reader( stream );
        auto object = reader.get_object();
        object.allow_omitted_members();
        // Validate root termination before indexed member reads seek backwards.
        if( !stream.eof() || reader.get_ate_separator() ) {
            throw std::runtime_error( "Trailing world identity data" );
        }
        if( object.get_int( "schema" ) != 1 ) {
            throw std::runtime_error( "Unsupported world identity schema" );
        }
        return world_id( object.get_string( "world_id" ) );
    } catch( const JsonError & ) {
        throw std::runtime_error( "Malformed world identity; restore its backup" );
    }
}
} // namespace

world_id load_or_create_world_identity( const cata_path &world_directory )
{
    const cata_path path = world_directory / WORLD_IDENTITY_FILE;
    if( std::filesystem::exists( path.get_unrelative_path() ) ) {
        return read_world_identity( path );
    }
    const auto lock = ( path + ".creating" ).get_unrelative_path();
    if( !std::filesystem::create_directory( lock ) ) {
        if( std::filesystem::exists( path.get_unrelative_path() ) ) {
            return read_world_identity( path );
        }
        throw std::runtime_error( "World identity creation is busy or interrupted; check its .creating directory" );
    }
    struct creation_lock {
        std::filesystem::path path;
        ~creation_lock() {
            std::error_code ignored;
            std::filesystem::remove( path, ignored );
        }
    } release{ lock };
    // Another creator may have published between our first read and mkdir.
    if( std::filesystem::exists( path.get_unrelative_path() ) ) {
        return read_world_identity( path );
    }
    const world_id result( random_identity_hex( 16 ) );
    write_to_file( path, [&]( std::ostream & stream ) {
        JsonOut out( stream );
        out.start_object();
        out.member( "schema", 1 );
        out.member( "world_id", result.str() );
        out.end_object();
    } );
    return result;
}
