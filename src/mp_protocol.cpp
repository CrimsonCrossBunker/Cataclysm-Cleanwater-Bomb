#include "mp_protocol.h"

#include <cstdint>
#include <sstream>
#include <set>
#include <zstd/zstd.h>

#include "json.h"

namespace cata_mp
{
namespace
{
constexpr size_t max_packet_bytes = 8 * 1024 * 1024;
}

bool read_handshake( const std::string &wire, std::map<std::string, std::string> &fields )
{
    fields.clear();
    if( wire.size() > 16384 ) {
        return false;
    }
    try {
        std::istringstream input( wire );
        TextJsonIn reader( input );
        const std::set<std::string> string_fields = { "type", "name", "password", "version", "world",
                                                      "host_name", "message", "transport", "player_id", "resume_secret"
                                                    };
        std::set<std::string> seen;
        reader.start_object();
        while( !reader.end_object() ) {
            const std::string name = reader.get_member_name();
            if( !seen.insert( name ).second ) {
                return false;
            }
            if( string_fields.count( name ) ) {
                fields.emplace( name, reader.get_string() );
            } else {
                reader.skip_value();
            }
        }
        input >> std::ws;
        return input.eof() && !fields["type"].empty();
    } catch( const JsonError & ) {
        fields.clear();
        return false;
    }
}

std::string wire_quote( const std::string &text )
{
    std::ostringstream output;
    JsonOut writer( output );
    writer.write( text );
    return output.str();
}

std::string version_commit_id( const std::string &version )
{
    return version.substr( 0, std::min( version.find( "-dirty" ), version.find( '+' ) ) );
}

std::string encode_game_packet( const std::string &json )
{
    if( json.empty() || json.size() > max_packet_bytes ) {
        return {};
    }
    if( json.size() < 512 ) {
        return json;
    }
    // Renet preserves packet boundaries; a native zstd frame needs no base64.
    std::string compressed( ZSTD_compressBound( json.size() ), '\0' );
    const size_t size = ZSTD_compress( compressed.data(), compressed.size(),
                                       json.data(), json.size(), 3 );
    if( ZSTD_isError( size ) || size >= json.size() ) {
        return json;
    }
    compressed.resize( size );
    return compressed;
}

bool decode_game_packet( const std::string &packet, std::string &json )
{
    json.clear();
    if( packet.empty() || packet.size() > max_packet_bytes ) {
        return false;
    }
    // Zstandard's fixed magic cannot be the start of JSON.
    if( packet.compare( 0, 4, "\x28\xb5\x2f\xfd", 4 ) != 0 ) {
        json = packet;
        return true;
    }
    const auto size = ZSTD_getFrameContentSize( packet.data(), packet.size() );
    if( size == ZSTD_CONTENTSIZE_UNKNOWN || size == ZSTD_CONTENTSIZE_ERROR ||
        size > max_packet_bytes ) {
        return false;
    }
    json.resize( size );
    const size_t decoded = ZSTD_decompress( json.data(), json.size(), packet.data(), packet.size() );
    if( ZSTD_isError( decoded ) || decoded != size ) {
        json.clear();
        return false;
    }
    return true;
}
} // namespace cata_mp
