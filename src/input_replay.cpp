#include "input_replay.h"

#include <cstdint>
#include <fstream>
#include <iomanip>
#include <limits>
#include <locale>
#include <memory>
#include <queue>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "cached_options.h"
#include "input_enums.h"
#include "player_identity.h"
#include "point.h"

#define XXH_INLINE_ALL
#include <zstd/common/xxhash.h>
#undef XXH_INLINE_ALL

// Replay log format (line-based, intentionally human-diffable):
//
//   CATA_REPLAY 2            <- magic + format version (v1 still readable)
//   SEED <unsigned>          <- RNG seed applied on replay
//   PROFILE_SEED <32 hex>    <- independent public identity seed; v2 only
//   EV <type> <mods> <n> <k0> <k1> ... <mx> <my> <text> <edit>
//   ...
//
// On the EV line:
//   <type>  integer value of input_event_t
//   <mods>  bitmask of keymod_t (1=ctrl, 2=alt, 4=shift)
//   <n>     length of the key/mouse sequence, followed by <n> ints
//   <mx>/<my> mouse_pos
//   <text>/<edit> percent-escaped UTF-8 (space and % and control chars escaped),
//                 or "-" when empty
//
// Fields are space-separated; only <text>/<edit> may contain escaped spaces.

namespace
{

std::unique_ptr<std::ofstream> record_stream;
std::queue<input_event> replay_queue;
unsigned int header_seed = 0;
unsigned int pending_record_seed = 0;
bool replay_had_events = false;   // queue was non-empty when replay began
bool replay_finish_signaled = false; // one-shot guard for replay_just_finished()
bool replay_input_failed = false;
std::size_t loaded_event_count = 0;

constexpr int replay_format_version = 2;

struct profile_identity_state {
    std::string seed;
    std::uint64_t allocated = 0;
    bool legacy = false;
};
std::optional<profile_identity_state> profile_identities;

std::string format_profile_identity( std::uint64_t high, std::uint64_t low )
{
    std::ostringstream out;
    out.imbue( std::locale::classic() );
    out << std::hex << std::setfill( '0' ) << std::setw( 16 ) << high <<
        std::setw( 16 ) << low;
    return out.str();
}

int mods_to_bits( const std::set<keymod_t> &mods )
{
    int bits = 0;
    for( const keymod_t m : mods ) {
        switch( m ) {
            case keymod_t::ctrl:
                bits |= 1;
                break;
            case keymod_t::alt:
                bits |= 2;
                break;
            case keymod_t::shift:
                bits |= 4;
                break;
        }
    }
    return bits;
}

std::set<keymod_t> bits_to_mods( int bits )
{
    std::set<keymod_t> mods;
    if( bits & 1 ) {
        mods.insert( keymod_t::ctrl );
    }
    if( bits & 2 ) {
        mods.insert( keymod_t::alt );
    }
    if( bits & 4 ) {
        mods.insert( keymod_t::shift );
    }
    return mods;
}

// Escape so the field is a single whitespace-free token; "-" denotes empty.
std::string escape_field( const std::string &s )
{
    if( s.empty() ) {
        return "-";
    }
    std::string out;
    out.reserve( s.size() );
    for( const unsigned char c : s ) {
        if( c == '%' || c == ' ' || c == '-' || c < 0x20 ) {
            static const char *hex = "0123456789ABCDEF";
            out += '%';
            out += hex[( c >> 4 ) & 0xF];
            out += hex[c & 0xF];
        } else {
            out += static_cast<char>( c );
        }
    }
    return out;
}

int hex_val( char c )
{
    if( c >= '0' && c <= '9' ) {
        return c - '0';
    }
    if( c >= 'A' && c <= 'F' ) {
        return c - 'A' + 10;
    }
    if( c >= 'a' && c <= 'f' ) {
        return c - 'a' + 10;
    }
    return -1;
}

bool unescape_field( const std::string &s, std::string &out )
{
    out.clear();
    if( s == "-" ) {
        return true;
    }
    out.reserve( s.size() );
    for( size_t i = 0; i < s.size(); ++i ) {
        if( s[i] == '%' ) {
            if( i + 2 >= s.size() ) {
                return false;
            }
            const int hi = hex_val( s[i + 1] );
            const int lo = hex_val( s[i + 2] );
            if( hi < 0 || lo < 0 ) {
                return false;
            }
            out += static_cast<char>( ( hi << 4 ) | lo );
            i += 2;
        } else {
            out += s[i];
        }
    }
    return true;
}

bool fail( std::string *error, const std::string &message )
{
    if( error ) {
        *error = message;
    }
    return false;
}

} // namespace

namespace input_replay
{

void set_record_seed( unsigned int seed )
{
    pending_record_seed = seed;
}

bool begin_record( const std::string &path, std::string *error )
{
    if( error ) {
        error->clear();
    }
    if( replay_mode != replay_mode_t::off ) {
        return fail( error, "An input recording or replay is already active" );
    }
    std::string identity_seed;
    try {
        identity_seed = create_player_id().str();
    } catch( const std::exception & ) {
        return fail( error, "Could not create replay profile identity seed" );
    }
    record_stream = std::make_unique<std::ofstream>( path, std::ios::binary | std::ios::trunc );
    if( !record_stream->good() ) {
        record_stream.reset();
        return fail( error, "Failed to open replay recording: " + path );
    }
    // Force the classic locale: the game sets a CJK locale at startup, whose
    // numeric facet inserts thousands separators ("3,102,551,058"), which then
    // re-parse wrong (truncated at the first comma). The log must be locale-neutral.
    record_stream->imbue( std::locale::classic() );
    *record_stream << "CATA_REPLAY " << replay_format_version << '\n';
    *record_stream << "SEED " << pending_record_seed << '\n';
    *record_stream << "PROFILE_SEED " << identity_seed << '\n';
    record_stream->flush();
    if( !record_stream->good() ) {
        record_stream.reset();
        return fail( error, "Failed to write replay recording: " + path );
    }
    profile_identities = profile_identity_state{ identity_seed, 0, false };
    replay_mode = replay_mode_t::record;
    return true;
}

bool begin_replay( const std::string &path, std::string *error )
{
    if( error ) {
        error->clear();
    }
    if( is_recording() ) {
        return fail( error, "Cannot replay while recording input" );
    }
    std::ifstream in( path, std::ios::binary );
    if( !in.good() ) {
        return fail( error, "Failed to open replay: " + path );
    }
    in.imbue( std::locale::classic() );

    std::string token;
    int version = 0;
    std::string line;
    // This repository's zstd copy intentionally provides xxHash64 only.
    // These two fingerprints namespace legacy public IDs, never credentials.
    XXH64_state_t fingerprint_high{};
    XXH64_state_t fingerprint_low{};
    XXH64_reset( &fingerprint_high, 0x4343425245504c41ULL );
    XXH64_reset( &fingerprint_low, 0x5950524f46494c45ULL );
    const auto hash_line = [&]( const std::string & text ) {
        for( auto *state : {
                 &fingerprint_high, &fingerprint_low
             } ) {
            XXH64_update( state, text.data(), text.size() );
            XXH64_update( state, "\n", 1 );
        }
    };
    std::getline( in, line );
    hash_line( line );
    std::istringstream header( line );
    header.imbue( std::locale::classic() );
    if( !( header >> token >> version ) || token != "CATA_REPLAY" ||
        ( version != 1 && version != replay_format_version ) || !( header >> std::ws ).eof() ) {
        return fail( error, "Invalid replay format header" );
    }
    std::getline( in, line );
    hash_line( line );
    std::istringstream seed_header( line );
    seed_header.imbue( std::locale::classic() );
    long long parsed_seed = -1;
    if( !( seed_header >> token >> parsed_seed ) || token != "SEED" ||
        parsed_seed < 0 || parsed_seed > std::numeric_limits<unsigned int>::max() ||
        !( seed_header >> std::ws ).eof() ) {
        return fail( error, "Invalid replay seed header" );
    }

    std::size_t line_number = 2;
    std::string identity_seed;
    if( version == 2 ) {
        std::getline( in, line );
        ++line_number;
        std::istringstream identity_header( line );
        identity_header.imbue( std::locale::classic() );
        if( !( identity_header >> token >> identity_seed ) || token != "PROFILE_SEED" ||
            !( identity_header >> std::ws ).eof() ) {
            return fail( error, "Invalid replay profile seed header" );
        }
        try {
            static_cast<void>( player_id( identity_seed ) );
        } catch( const std::invalid_argument & ) {
            return fail( error, "Invalid replay profile seed" );
        }
    }

    std::queue<input_event> loaded;
    while( std::getline( in, line ) ) {
        ++line_number;
        hash_line( line );
        if( line.find_first_not_of( " \t\r" ) == std::string::npos ) {
            continue;
        }
        std::istringstream ls( line );
        ls.imbue( std::locale::classic() );
        std::string tag;
        ls >> tag;
        if( tag != "EV" ) {
            return fail( error, "Unknown replay record on line " + std::to_string( line_number ) );
        }
        input_event ev;
        int type_i = 0;
        int mods_bits = 0;
        int n = 0;
        if( !( ls >> type_i >> mods_bits >> n ) ||
            type_i < static_cast<int>( input_event_t::error ) ||
            type_i > static_cast<int>( input_event_t::mouse ) ||
            mods_bits < 0 || mods_bits > 7 || n < 0 ) {
            return fail( error, "Invalid event header on line " + std::to_string( line_number ) );
        }
        ev.type = static_cast<input_event_t>( type_i );
        ev.modifiers = bits_to_mods( mods_bits );
        for( int i = 0; i < n; ++i ) {
            int k = 0;
            if( !( ls >> k ) ) {
                return fail( error, "Truncated event keys on line " + std::to_string( line_number ) );
            }
            ev.sequence.push_back( k );
        }
        std::string text_tok;
        std::string edit_tok;
        if( !( ls >> ev.mouse_pos.x >> ev.mouse_pos.y >> text_tok >> edit_tok ) ||
            !( ls >> std::ws ).eof() || !unescape_field( text_tok, ev.text ) ||
            !unescape_field( edit_tok, ev.edit ) ) {
            return fail( error, "Invalid event data on line " + std::to_string( line_number ) );
        }
        loaded.push( ev );
    }
    if( in.bad() || loaded.empty() ) {
        return fail( error, "Replay is unreadable or contains no events" );
    }

    if( version == 1 ) {
        // Old recordings predate public profile identities. Their exact input
        // supplies a reproducible namespace, without changing simulation RNG.
        identity_seed = format_profile_identity( XXH64_digest( &fingerprint_high ),
                        XXH64_digest( &fingerprint_low ) );
    }

    header_seed = static_cast<unsigned int>( parsed_seed );
    profile_identities = profile_identity_state{ identity_seed, 0, version == 1 };
    replay_queue = std::move( loaded );
    loaded_event_count = replay_queue.size();
    replay_had_events = !replay_queue.empty();
    replay_finish_signaled = false;
    replay_input_failed = false;
    replay_mode = replay_mode_t::replay;
    return true;
}

void finish()
{
    profile_identities.reset();
    if( record_stream ) {
        record_stream->flush();
        record_stream.reset();
    }
    std::queue<input_event> empty;
    std::swap( replay_queue, empty );
    replay_had_events = false;
    replay_finish_signaled = false;
    replay_input_failed = false;
    loaded_event_count = 0;
    replay_mode = replay_mode_t::off;
}

bool is_recording()
{
    return replay_mode == replay_mode_t::record && record_stream != nullptr;
}

std::optional<std::string> next_profile_identity( const std::string &legacy_save_slot )
{
    if( !is_recording() && !is_replaying() ) {
        return std::nullopt;
    }
    if( !profile_identities ||
        profile_identities->allocated == std::numeric_limits<std::uint64_t>::max() ) {
        replay_input_failed = true;
        throw replay_error( "Replay profile identity stream is unavailable or exhausted" );
    }
    auto &state = *profile_identities;
    std::uint64_t high = std::stoull( state.seed.substr( 0, 16 ), nullptr, 16 );
    std::uint64_t low = std::stoull( state.seed.substr( 16 ), nullptr, 16 );
    if( state.legacy ) {
        high ^= XXH64( legacy_save_slot.data(), legacy_save_slot.size(), 0x4343425245504c41ULL );
        low ^= XXH64( legacy_save_slot.data(), legacy_save_slot.size(), 0x5950524f46494c45ULL );
    }
    // Addition gives distinct IDs within a recording, without hashing or
    // advancing the simulation PRNG. The high half receives the carry.
    const std::uint64_t advanced = low + state.allocated;
    high += advanced < low ? 1 : 0;
    const std::string result = format_profile_identity( high, advanced );
    ++state.allocated;
    return result;
}

bool is_replaying()
{
    return replay_mode == replay_mode_t::replay;
}

void on_record( const input_event &ev )
{
    if( !is_recording() ) {
        return;
    }
    // Only record events that carry real player intent. error/timeout are poll
    // artifacts whose counts depend on wall-clock timing (non-deterministic), and
    // raw mouse-move spam is likewise timing-dependent noise. Recording them would
    // make the log both huge and non-reproducible. Exhaustion during an input
    // request is an error; successful completion is checked at a turn boundary.
    if( ev.type == input_event_t::error || ev.type == input_event_t::timeout ) {
        return;
    }
    if( ev.type == input_event_t::mouse && !ev.sequence.empty()
        && ev.sequence[0] == static_cast<int>( MouseInput::Move ) ) {
        return;
    }
    std::ostringstream os;
    os.imbue( std::locale::classic() );
    os << "EV " << static_cast<int>( ev.type )
       << ' ' << mods_to_bits( ev.modifiers )
       << ' ' << ev.sequence.size();
    for( const int k : ev.sequence ) {
        os << ' ' << k;
    }
    os << ' ' << ev.mouse_pos.x << ' ' << ev.mouse_pos.y
       << ' ' << escape_field( ev.text )
       << ' ' << escape_field( ev.edit );
    *record_stream << os.str() << '\n';
    record_stream->flush();
}

bool try_replay( input_event &out )
{
    if( !is_replaying() || replay_queue.empty() ) {
        return false;
    }
    out = replay_queue.front();
    replay_queue.pop();
    return true;
}

input_event next_event()
{
    input_event out;
    if( !try_replay( out ) ) {
        replay_input_failed = true;
        throw replay_error( "Replay exhausted inside an input request" );
    }
    return out;
}

bool had_input_failure()
{
    return replay_input_failed;
}

std::size_t total_events()
{
    return loaded_event_count;
}

bool replay_just_finished()
{
    if( !is_replaying() || !replay_had_events || replay_finish_signaled ) {
        return false;
    }
    if( replay_queue.empty() ) {
        replay_finish_signaled = true;
        return true;
    }
    return false;
}

unsigned int recorded_seed()
{
    return header_seed;
}

int replay_remaining()
{
    return is_replaying() ? static_cast<int>( replay_queue.size() ) : 0;
}

} // namespace input_replay
