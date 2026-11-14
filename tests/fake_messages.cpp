#include <algorithm>
#include <cstddef>
#include <string>
#include <utility>
#include <vector>

#include "calendar.h"
#include "coords_fwd.h"
#include "messages.h"
#include "message_routing.h"

class Creature;
class JsonObject;
class JsonOut;
namespace debugmode
{
enum debug_filter : int;
}  // namespace debugmode
struct game_message_params;

namespace catacurses
{
class window;
}  // namespace catacurses

/**
 * For unit testing we just store all messages so they can be dumped in the
 * event of a test failure.
 */

static std::vector<std::pair<std::string, std::string>> messages;
static std::vector<std::optional<player_id>> excluded_owners;

std::vector<std::pair<std::string, std::string>> Messages::recent_messages( size_t count )
{
    count = std::min( count, messages.size() );
    return { messages.end() - static_cast<std::ptrdiff_t>( count ), messages.end() };
}
std::vector<std::pair<std::string, std::string>> Messages::recent_messages_with_formatting(
            const size_t count )
{
    // Headless tests preserve the supplied text, including inline formatting tags.
    // Display colours and message fading belong to the UI implementation.
    return recent_messages( count );
}
bool Messages::has_debug_filter( debugmode::debug_filter )
{
    return true;
}
void Messages::add_msg( std::string m )
{
    if( !m.empty() ) {
        messages.emplace_back( to_string_time_of_day( calendar::turn ), std::move( m ) );
        excluded_owners.emplace_back();
    }
}
void Messages::add_msg( const game_message_params &, std::string m )
{
    add_msg( std::move( m ) );
}
void Messages::add_observer_msg( const game_message_params &params, std::string message,
                                 const std::optional<player_id> &owner )
{
    if( !message.empty() ) {
        Messages::add_msg( params, std::move( message ) );
        excluded_owners.back() = owner;
    }
}
std::vector<std::pair<std::string, std::string>> Messages::recent_messages_for_player(
            size_t count, const player_id &recipient )
{
    std::vector<std::pair<std::string, std::string>> result;
    for( size_t i = messages.size() - std::min( count, messages.size() ); i < messages.size(); ++i ) {
        if( !excluded_owners[i] || !( *excluded_owners[i] == recipient ) ) {
            result.push_back( messages[i] );
        }
    }
    return result;
}
void Messages::clear_messages()
{
    messages.clear();
    excluded_owners.clear();
}
void Messages::deactivate() {}
size_t Messages::size()
{
    return messages.size();
}
bool Messages::has_undisplayed_messages()
{
    return false;
}
void Messages::display_messages() {}
void Messages::display_messages( const catacurses::window &, int, int, int, int ) {}
void Messages::serialize( JsonOut & ) {}
void Messages::deserialize( const JsonObject & ) {}
void add_msg( std::string m )
{
    Messages::add_msg( std::move( m ) );
}
void add_msg( const game_message_params &, std::string m )
{
    Messages::add_msg( std::move( m ) );
}
void add_msg_if_player_sees( const tripoint_bub_ms &, std::string m )
{
    Messages::add_msg( std::move( m ) );
}
void add_msg_if_player_sees( const Creature &, std::string m )
{
    Messages::add_msg( std::move( m ) );
}
void add_msg_if_player_sees( const tripoint_bub_ms &, const game_message_params &, std::string m )
{
    Messages::add_msg( std::move( m ) );
}
void add_msg_if_player_sees( const Creature &, const game_message_params &, std::string m )
{
    Messages::add_msg( std::move( m ) );
}
