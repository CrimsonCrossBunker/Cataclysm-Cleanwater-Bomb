#include "mp_player_store.h"

#include <algorithm>
#include <fstream>
#include <chrono>
#include <limits>
#include <thread>
#include <set>
#include <sstream>
#include <stdexcept>
#include <utility>

#include "cata_utility.h"
#include "json.h"

namespace cata_mp
{
namespace
{
bool same_secret( const std::string &a, const std::string &b )
{
    if( a.size() != b.size() ) {
        return false;
    }
    unsigned int difference = 0;
    for( size_t i = 0; i < a.size(); ++i ) {
        difference |= static_cast<unsigned char>( a[i] ^ b[i] );
    }
    return difference == 0;
}

std::string read_document( const cata_path &path )
{
    const auto file = path.get_unrelative_path();
    const auto size = std::filesystem::file_size( file );
    if( size > 64 * 1024 * 1024 ) {
        throw std::runtime_error( "Multiplayer player record exceeds 64 MiB" );
    }
    std::ifstream input( file, std::ios::binary );
    std::string result( size, '\0' );
    if( !input.read( result.data(), result.size() ) ) {
        throw std::runtime_error( "Cannot read multiplayer player record" );
    }
    return result;
}

// Indexed member reads seek within the stream. Check the root terminator
// before those reads; TextJsonObject's cached end offset can be -1 at EOF.
TextJsonObject read_root( TextJsonIn &reader, std::istream &input )
{
    auto object = reader.get_object();
    object.allow_omitted_members();
    if( !input.eof() || reader.get_ate_separator() ) {
        throw std::runtime_error( "Trailing multiplayer identity data" );
    }
    return object;
}

player_credentials read_credentials( const TextJsonObject &object )
{
    if( object.get_int( "schema" ) != 1 ) {
        throw std::runtime_error( "Unsupported multiplayer identity schema" );
    }
    player_credentials result{ player_id( object.get_string( "player_id" ) ),
                               object.get_string( "resume_secret" ) };
    if( !result.valid() ) {
        throw std::runtime_error( "Invalid multiplayer credentials" );
    }
    return result;
}

void write_credentials( JsonOut &out, const player_credentials &credentials )
{
    out.member( "schema", 1 );
    out.member( "player_id", credentials.id.str() );
    out.member( "resume_secret", credentials.resume_secret );
}

character_id actor_id( const std::string &snapshot )
{
    std::istringstream input( snapshot );
    TextJsonIn reader( input );
    auto object = read_root( reader, input );
    const character_id result( object.get_int( "id" ) );
    if( !result.is_valid() || result.get_value() == std::numeric_limits<int>::max() ) {
        throw std::runtime_error( "Invalid multiplayer character snapshot" );
    }
    return result;
}

struct record {
    player_credentials credentials;
    std::string snapshot;
};

record read_record( const cata_path &path )
{
    // JsonError can contain source text, including the capability. Never expose
    // its excerpt through a debug log, popup, or network rejection.
    try {
        std::istringstream input( read_document( path ) );
        TextJsonIn reader( input );
        auto object = read_root( reader, input );
        return { read_credentials( object ), object.get_object( "character" ).str() };
    } catch( const JsonError & ) {
        throw std::runtime_error( "Malformed multiplayer player record" );
    }
}
} // namespace

player_credentials load_or_create_player_credentials( const cata_path &path )
{
    if( std::filesystem::exists( path.get_unrelative_path() ) ) {
        try {
            std::istringstream input( read_document( path ) );
            TextJsonIn reader( input );
            auto object = read_root( reader, input );
            return read_credentials( object );
        } catch( const JsonError & ) {
            throw std::runtime_error( "Malformed multiplayer profile; restore its backup" );
        }
    }
    const auto lock = ( path + ".creating" ).get_unrelative_path();
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 1 );
    while( !std::filesystem::create_directory( lock ) ) {
        if( std::filesystem::exists( path.get_unrelative_path() ) ) {
            return load_or_create_player_credentials( path );
        }
        if( std::chrono::steady_clock::now() >= deadline ) {
            throw std::runtime_error( "Multiplayer identity creation is busy or was interrupted; check the .creating directory" );
        }
        std::this_thread::sleep_for( std::chrono::milliseconds( 10 ) );
    }
    struct creation_lock {
        std::filesystem::path path;
        ~creation_lock() {
            std::error_code ignored;
            std::filesystem::remove( path, ignored );
        }
    } release{ lock };
    // Another creator may have published and unlocked between our first read
    // and mkdir. Never replace its identity with a new capability.
    if( std::filesystem::exists( path.get_unrelative_path() ) ) {
        return load_or_create_player_credentials( path );
    }
    const auto result = create_player_credentials();
    write_to_file( path, [&]( std::ostream & stream ) {
        JsonOut out( stream );
        out.start_object();
        write_credentials( out, result );
        out.end_object();
    } );
    return result;
}

player_credentials load_server_player_credentials( const cata_path &config_directory,
        const std::string &authority )
{
    if( authority.empty() || authority.size() > 96 ) {
        throw std::invalid_argument( "Missing or oversized multiplayer authority" );
    }
    // Bounded, reversible encoding avoids path traversal, name collisions, and
    // implementation-dependent std::hash values in persistent file names.
    static constexpr char hex[] = "0123456789abcdef";
    std::string name;
    for( const unsigned char byte : authority ) {
        name += hex[byte >> 4];
        name += hex[byte & 15];
    }
    const auto directory = config_directory / "mp_player_profiles";
    std::filesystem::create_directories( directory.get_unrelative_path() );
    return load_or_create_player_credentials( directory / ( name + ".json" ) );
}

player_store::player_store( cata_path world_directory ) : root_( std::move( world_directory ) ) {}

cata_path player_store::record_path( const player_id &id ) const
{
    if( !id.valid() ) {
        throw std::invalid_argument( "Missing persistent player ID" );
    }
    return root_ / ( "mp_actor_" + id.str() + ".json" );
}

void player_store::index()
{
    if( indexed_ ) {
        return;
    }
    std::map<player_id, owner> owners;
    std::set<character_id> actors;
    for( const auto &entry : std::filesystem::directory_iterator( root_.get_unrelative_path() ) ) {
        const auto name = entry.path().filename().u8string();
        if( name.compare( 0, 9, "mp_actor_" ) != 0 || entry.path().extension() != ".json" ) {
            continue;
        }
        const auto path = root_ / entry.path().filename();
        const auto saved = read_record( path );
        const auto actor = actor_id( saved.snapshot );
        if( !( path == record_path( saved.credentials.id ) ) ||
            !actors.insert( actor ).second ) {
            throw std::runtime_error( "Conflicting multiplayer actor ownership" );
        }
        owners.emplace( saved.credentials.id, owner{ actor, saved.credentials.resume_secret } );
    }
    owners_ = std::move( owners );
    indexed_ = true;
}

void player_store::authorize( const player_credentials &credentials ) const
{
    if( !credentials.valid() ) {
        throw std::invalid_argument( "Missing multiplayer credentials" );
    }
    const auto found = owners_.find( credentials.id );
    if( found != owners_.end() && !same_secret( found->second.secret, credentials.resume_secret ) ) {
        throw std::runtime_error( "Player identity belongs to another profile" );
    }
}

std::optional<std::string> player_store::load( const player_credentials &credentials )
{
    index();
    authorize( credentials );
    const auto found = owners_.find( credentials.id );
    if( found == owners_.end() ) {
        return std::nullopt;
    }
    const auto saved = read_record( record_path( credentials.id ) );
    if( !( saved.credentials.id == credentials.id ) ||
        !same_secret( saved.credentials.resume_secret, credentials.resume_secret ) ||
        actor_id( saved.snapshot ) != found->second.actor ) {
        throw std::runtime_error( "Player record changed outside its world owner" );
    }
    return saved.snapshot;
}

void player_store::save( const player_credentials &credentials, const std::string &character_json )
{
    if( character_json.size() > 64 * 1024 * 1024 - 1024 ) {
        throw std::runtime_error( "Multiplayer character snapshot exceeds the record limit" );
    }
    index();
    authorize( credentials );
    if( owners_.count( credentials.id ) ) {
        load( credentials ); // Detect corruption or external replacement before overwriting.
    } else if( std::filesystem::exists( record_path( credentials.id ).get_unrelative_path() ) ) {
        throw std::runtime_error( "Player record appeared outside its world owner" );
    }
    const auto actor = actor_id( character_json );
    for( const auto &entry : owners_ ) {
        if( entry.first == credentials.id ? entry.second.actor != actor : entry.second.actor == actor ) {
            throw std::runtime_error( "Cannot replace another player's actor binding" );
        }
    }
    write_to_file( record_path( credentials.id ), [&]( std::ostream & stream ) {
        JsonOut out( stream );
        out.start_object();
        write_credentials( out, credentials );
        out.member( "character" );
        // actor_id validated the complete JSON object before any file mutation.
        stream << character_json;
        out.set_need_separator();
        out.end_object();
    } );
    owners_.insert_or_assign( credentials.id, owner{ actor, credentials.resume_secret } );
}

std::vector<character_id> player_store::actor_ids()
{
    index();
    std::vector<character_id> result;
    for( const auto &entry : owners_ ) {
        result.push_back( entry.second.actor );
    }
    return result;
}

std::vector<cata_path> player_store::legacy_records() const
{
    std::vector<cata_path> result;
    for( const auto &entry : std::filesystem::directory_iterator( root_.get_unrelative_path() ) ) {
        const auto name = entry.path().filename().u8string();
        if( entry.is_regular_file() && name.compare( 0, 10, "mp_player_" ) == 0 &&
            entry.path().extension() == ".json" ) {
            result.push_back( root_ / entry.path().filename() );
        }
    }
    std::sort( result.begin(), result.end(), []( const cata_path & a, const cata_path & b ) {
        return a.generic_u8string() < b.generic_u8string();
    } );
    return result;
}

void player_store::import_legacy( const player_credentials &credentials, const cata_path &source )
{
    if( load( credentials ) ) {
        throw std::runtime_error( "Player already owns an actor; legacy import refused" );
    }
    const auto candidates = legacy_records();
    if( std::find( candidates.begin(), candidates.end(), source ) == candidates.end() ) {
        throw std::runtime_error( "Legacy record must be explicitly selected from this world" );
    }
    save( credentials, read_document( source ) );
}
} // namespace cata_mp
