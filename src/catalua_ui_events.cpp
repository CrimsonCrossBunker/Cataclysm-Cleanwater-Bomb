#include "catalua_ui_events.h"

#include <algorithm>
#include <cctype>
#include <stdexcept>
#include <utility>

namespace cata::lua_ui
{

std::uint64_t script_event_registry::subscribe(
    std::string event_name, const int priority, const std::size_t source_index,
    const bool once )
{
    if( event_name.empty() || event_name.size() > 192 ) {
        throw std::invalid_argument( "Lua event name must contain 1 to 192 bytes" );
    }
    if( priority < minimum_priority || priority > maximum_priority ) {
        throw std::invalid_argument( "Lua event priority must be within -10000..10000" );
    }
    if( subscriptions_.size() >= maximum_subscriptions ) {
        throw std::runtime_error( "Lua event subscription limit reached" );
    }
    const std::uint64_t id = next_id_++;
    subscriptions_.push_back( {
        id, std::move( event_name ), priority, source_index, next_sequence_++, once
    } );
    return id;
}

bool script_event_registry::unsubscribe(
    const std::uint64_t id, const std::size_t source_index )
{
    const auto found = std::find_if(
                           subscriptions_.begin(), subscriptions_.end(),
    [id, source_index]( const script_event_subscription & entry ) {
        return entry.id == id && entry.source_index == source_index;
    } );
    if( found == subscriptions_.end() ) {
        return false;
    }
    subscriptions_.erase( found );
    return true;
}

bool script_event_registry::unsubscribe_unchecked( const std::uint64_t id )
{
    const auto found = std::find_if(
                           subscriptions_.begin(), subscriptions_.end(),
    [id]( const script_event_subscription & entry ) {
        return entry.id == id;
    } );
    if( found == subscriptions_.end() ) {
        return false;
    }
    subscriptions_.erase( found );
    return true;
}

std::vector<script_event_subscription> script_event_registry::matching(
    const std::string_view event_name ) const
{
    std::vector<script_event_subscription> result;
    for( const script_event_subscription &entry : subscriptions_ ) {
        if( entry.event_name == event_name ) {
            result.push_back( entry );
        }
    }
    std::stable_sort(
        result.begin(), result.end(),
        []( const script_event_subscription & left,
    const script_event_subscription & right ) {
        if( left.priority != right.priority ) {
            return left.priority > right.priority;
        }
        return left.sequence < right.sequence;
    } );
    return result;
}

bool script_event_registry::has_matching(
    const std::string_view event_name ) const
{
    return std::any_of(
               subscriptions_.begin(), subscriptions_.end(),
    [event_name]( const script_event_subscription & entry ) {
        return entry.event_name == event_name;
    } );
}

bool script_event_registry::contains( const std::uint64_t id ) const
{
    return std::any_of(
               subscriptions_.begin(), subscriptions_.end(),
    [id]( const script_event_subscription & entry ) {
        return entry.id == id;
    } );
}

std::size_t script_event_registry::size() const
{
    return subscriptions_.size();
}

const std::vector<script_event_subscription> &script_event_registry::all() const
{
    return subscriptions_;
}

void script_event_registry::clear()
{
    subscriptions_.clear();
    next_id_ = 1;
    next_sequence_ = 1;
}

bool is_safe_custom_event_segment( const std::string_view value )
{
    return !value.empty() && value.size() <= 128 &&
    std::all_of( value.begin(), value.end(), []( const unsigned char ch ) {
        return std::isalnum( ch ) != 0 || ch == '_' || ch == '-' || ch == '.';
    } );
}

bool is_lifecycle_event_name( const std::string_view value )
{
    static constexpr std::string_view names[] = {
        "ccb.lifecycle.reload",
        "ccb.lifecycle.world_ready",
        "ccb.lifecycle.before_save",
        "ccb.lifecycle.after_save",
        "ccb.lifecycle.shutdown"
    };
    return std::find( std::begin( names ), std::end( names ), value ) !=
           std::end( names );
}

} // namespace cata::lua_ui
