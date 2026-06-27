#include "input_replay.h"

#include <fstream>
#include <locale>
#include <memory>
#include <queue>
#include <sstream>
#include <string>

#include "cached_options.h"
#include "debug.h"

// Replay log format (line-based, intentionally human-diffable):
//
//   CATA_REPLAY 1            <- magic + format version
//   SEED <unsigned>          <- RNG seed applied on replay
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

constexpr int replay_format_version = 1;

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

std::string unescape_field( const std::string &s )
{
    if( s == "-" ) {
        return std::string();
    }
    std::string out;
    out.reserve( s.size() );
    for( size_t i = 0; i < s.size(); ++i ) {
        if( s[i] == '%' && i + 2 < s.size() ) {
            const int hi = hex_val( s[i + 1] );
            const int lo = hex_val( s[i + 2] );
            if( hi >= 0 && lo >= 0 ) {
                out += static_cast<char>( ( hi << 4 ) | lo );
                i += 2;
                continue;
            }
        }
        out += s[i];
    }
    return out;
}

} // namespace

namespace input_replay
{

void set_record_seed( unsigned int seed )
{
    pending_record_seed = seed;
}

bool begin_record( const std::string &path )
{
    record_stream = std::make_unique<std::ofstream>( path, std::ios::binary | std::ios::trunc );
    if( !record_stream->good() ) {
        record_stream.reset();
        debugmsg( "input_replay: failed to open record log '%s'", path );
        return false;
    }
    // Force the classic locale: the game sets a CJK locale at startup, whose
    // numeric facet inserts thousands separators ("3,102,551,058"), which then
    // re-parse wrong (truncated at the first comma). The log must be locale-neutral.
    record_stream->imbue( std::locale::classic() );
    *record_stream << "CATA_REPLAY " << replay_format_version << '\n';
    *record_stream << "SEED " << pending_record_seed << '\n';
    record_stream->flush();
    replay_mode = replay_mode_t::record;
    return true;
}

bool begin_replay( const std::string &path )
{
    std::ifstream in( path, std::ios::binary );
    if( !in.good() ) {
        debugmsg( "input_replay: failed to open replay log '%s'", path );
        return false;
    }
    in.imbue( std::locale::classic() );

    std::string token;
    int version = 0;
    in >> token >> version;
    if( token != "CATA_REPLAY" || version != replay_format_version ) {
        debugmsg( "input_replay: bad replay header in '%s' (token=%s version=%d)",
                  path, token, version );
        return false;
    }
    in >> token >> header_seed;
    if( token != "SEED" ) {
        debugmsg( "input_replay: missing SEED in replay log '%s'", path );
        return false;
    }

    std::queue<input_event> loaded;
    std::string line;
    std::getline( in, line ); // consume rest of SEED line
    while( std::getline( in, line ) ) {
        if( line.empty() ) {
            continue;
        }
        std::istringstream ls( line );
        ls.imbue( std::locale::classic() );
        std::string tag;
        ls >> tag;
        if( tag != "EV" ) {
            continue;
        }
        input_event ev;
        int type_i = 0;
        int mods_bits = 0;
        int n = 0;
        ls >> type_i >> mods_bits >> n;
        ev.type = static_cast<input_event_t>( type_i );
        ev.modifiers = bits_to_mods( mods_bits );
        for( int i = 0; i < n; ++i ) {
            int k = 0;
            ls >> k;
            ev.sequence.push_back( k );
        }
        ls >> ev.mouse_pos.x >> ev.mouse_pos.y;
        std::string text_tok;
        std::string edit_tok;
        ls >> text_tok >> edit_tok;
        ev.text = unescape_field( text_tok );
        ev.edit = unescape_field( edit_tok );
        loaded.push( ev );
    }

    replay_queue = std::move( loaded );
    replay_had_events = !replay_queue.empty();
    replay_finish_signaled = false;
    replay_mode = replay_mode_t::replay;
    return true;
}

void finish()
{
    if( record_stream ) {
        record_stream->flush();
        record_stream.reset();
    }
    std::queue<input_event> empty;
    std::swap( replay_queue, empty );
    replay_had_events = false;
    replay_finish_signaled = false;
    replay_mode = replay_mode_t::off;
}

bool is_recording()
{
    return replay_mode == replay_mode_t::record && record_stream != nullptr;
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
    // make the log both huge and non-reproducible; on replay the engine generates
    // its own timeouts when the queue yields nothing.
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
