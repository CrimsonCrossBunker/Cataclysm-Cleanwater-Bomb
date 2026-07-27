#include "catalua_ui_actions.h"
#include "catalua_ui_actions_internal.h"

#include <algorithm>
#include <array>
#include <cstddef>
#include <cstdint>
#include <deque>
#include <stdexcept>
#include <string>
#include <utility>

#include "avatar.h"
#include "avatar_action.h"
#include "bionics.h"
#include "calendar.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "messages.h"
#include "mp_gamestate.h"
#include "mutation.h"
#include "point.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::size_t maximum_pending_actions = 64;
constexpr std::size_t maximum_action_results = 128;
constexpr std::size_t maximum_item_search_nodes = 4096;
constexpr int maximum_item_search_depth = 16;

struct action_request {
    std::uint64_t id = 0;
    std::string type;
    std::string text_argument;
    std::int64_t integer_argument = 0;
    std::int64_t queued_turn = 0;
};

struct action_result {
    std::uint64_t id = 0;
    std::string type;
    std::string status;
    std::string error;
    std::int64_t queued_turn = 0;
    std::int64_t completed_turn = 0;
    bool action_taken = false;
};

std::deque<action_request> pending_actions;
std::deque<action_result> action_results;
std::uint64_t next_action_id = 1;

std::int64_t current_turn()
{
    return to_turn<std::int64_t>( calendar::turn );
}

void remember_result( action_result result )
{
    if( action_results.size() >= maximum_action_results ) {
        action_results.pop_front();
    }
    action_results.push_back( std::move( result ) );
}

std::string required_string( const sol::optional<sol::table> &options, const std::string &name,
                             const std::string &action_type )
{
    if( !options ) {
        throw std::invalid_argument( "game.actions.enqueue '" + action_type +
                                     "' requires options." + name );
    }
    const sol::object value = ( *options )[name];
    if( !value.valid() || value.get_type() != sol::type::string ) {
        throw std::invalid_argument( "game.actions.enqueue '" + action_type + "' requires string options." +
                                     name );
    }
    return value.as<std::string>();
}

std::int64_t required_integer( const sol::optional<sol::table> &options, const std::string &name,
                               const std::string &action_type )
{
    if( !options ) {
        throw std::invalid_argument( "game.actions.enqueue '" + action_type +
                                     "' requires options." + name );
    }
    const sol::object value = ( *options )[name];
    if( !value.valid() || !value.is<lua_Integer>() ) {
        throw std::invalid_argument( "game.actions.enqueue '" + action_type + "' requires integer options."
                                     +
                                     name );
    }
    return static_cast<std::int64_t>( value.as<lua_Integer>() );
}

std::uint64_t enqueue_action( const std::function<void()> &authorize_access,
                              const std::function<bool()> &can_mutate, const std::string &type,
                              const sol::optional<sol::table> &options )
{
    authorize_access();
    if( !can_mutate() ) {
        throw std::runtime_error( "game.actions.enqueue is only available from an active callback" );
    }
    if( pending_actions.size() >= maximum_pending_actions ) {
        throw std::runtime_error( "game.actions queue is full" );
    }

    action_request request;
    request.id = next_action_id++;
    request.type = type;
    request.queued_turn = current_turn();
    if( type == "move" ) {
        request.text_argument = required_string( options, "direction", type );
        static const std::array<const char *, 8> directions = {
            "north", "north_east", "east", "south_east",
            "south", "south_west", "west", "north_west"
        };
        if( std::find( directions.begin(), directions.end(), request.text_argument ) == directions.end() ) {
            throw std::invalid_argument( "game.actions.enqueue move direction is invalid" );
        }
    } else if( type == "use_item" || type == "toggle_bionic" ) {
        request.integer_argument = required_integer( options, "uid", type );
        if( request.integer_argument <= 0 ) {
            throw std::invalid_argument( "game.actions.enqueue '" + type + "' uid must be positive" );
        }
    } else if( type == "toggle_mutation" ) {
        request.text_argument = required_string( options, "id", type );
        if( request.text_argument.empty() ) {
            throw std::invalid_argument( "game.actions.enqueue toggle_mutation id cannot be empty" );
        }
    } else if( type != "wait" && type != "cancel_activity" ) {
        throw std::invalid_argument( "game.actions.enqueue action type is not allowed: " + type );
    }

    pending_actions.push_back( std::move( request ) );
    return pending_actions.back().id;
}

bool cancel_action( std::uint64_t id )
{
    const auto found = std::find_if( pending_actions.begin(), pending_actions.end(),
    [id]( const action_request & entry ) {
        return entry.id == id;
    } );
    if( found == pending_actions.end() ) {
        return false;
    }
    remember_result( action_result{ found->id, found->type, "canceled", {}, found->queued_turn,
                                    current_turn(), false } );
    pending_actions.erase( found );
    return true;
}

sol::table request_snapshot( sol::state_view &state, const action_request &request )
{
    sol::table snapshot = state.create_table();
    snapshot["request_id"] = request.id;
    snapshot["type"] = request.type;
    snapshot["status"] = "queued";
    snapshot["queued_turn"] = request.queued_turn;
    return snapshot;
}

sol::table result_snapshot( sol::state_view &state, const action_result &result )
{
    sol::table snapshot = state.create_table();
    snapshot["request_id"] = result.id;
    snapshot["type"] = result.type;
    snapshot["status"] = result.status;
    snapshot["error"] = result.error;
    snapshot["queued_turn"] = result.queued_turn;
    snapshot["completed_turn"] = result.completed_turn;
    snapshot["action_taken"] = result.action_taken;
    return snapshot;
}

sol::table actions_status( sol::this_state lua, sol::optional<int> requested_result_limit )
{
    const int raw_limit = requested_result_limit.value_or( 32 );
    if( raw_limit < 0 ) {
        throw std::invalid_argument( "game.actions.status result limit cannot be negative" );
    }
    const std::size_t result_limit = static_cast<std::size_t>( std::min( raw_limit, 128 ) );
    sol::state_view state( lua );
    sol::table pending = state.create_table();
    for( std::size_t index = 0; index < pending_actions.size(); ++index ) {
        pending[index + 1] = request_snapshot( state, pending_actions[index] );
    }
    sol::table results = state.create_table();
    const std::size_t first = action_results.size() > result_limit ?
                              action_results.size() - result_limit : 0;
    for( std::size_t index = first; index < action_results.size(); ++index ) {
        results[index - first + 1] = result_snapshot( state, action_results[index] );
    }
    sol::table snapshot = state.create_table();
    snapshot["pending"] = std::move( pending );
    snapshot["pending_count"] = pending_actions.size();
    snapshot["pending_limit"] = maximum_pending_actions;
    snapshot["results"] = std::move( results );
    snapshot["result_count"] = action_results.size();
    snapshot["result_limit"] = result_limit;
    return snapshot;
}

item_location find_item_location_by_uid( item_location root, std::int64_t uid,
        std::size_t &visited, int depth )
{
    if( !root || visited >= maximum_item_search_nodes || depth > maximum_item_search_depth ) {
        return item_location();
    }
    ++visited;
    if( root->uid().get_value() == uid ) {
        return root;
    }
    for( item *child : root->all_items_top() ) {
        item_location found = find_item_location_by_uid( item_location( root, child ), uid, visited,
                              depth + 1 );
        if( found ) {
            return found;
        }
        if( visited >= maximum_item_search_nodes ) {
            break;
        }
    }
    return item_location();
}

item_location find_carried_item( avatar &player, std::int64_t uid )
{
    std::size_t visited = 0;
    for( item *root : player.inv_dump() ) {
        item_location found = find_item_location_by_uid( item_location( player, root ), uid, visited, 0 );
        if( found ) {
            return found;
        }
        if( visited >= maximum_item_search_nodes ) {
            break;
        }
    }
    return item_location();
}

tripoint_rel_ms direction_delta( const std::string &direction )
{
    if( direction == "north" ) {
        return tripoint_rel_ms( 0, -1, 0 );
    } else if( direction == "north_east" ) {
        return tripoint_rel_ms( 1, -1, 0 );
    } else if( direction == "east" ) {
        return tripoint_rel_ms( 1, 0, 0 );
    } else if( direction == "south_east" ) {
        return tripoint_rel_ms( 1, 1, 0 );
    } else if( direction == "south" ) {
        return tripoint_rel_ms( 0, 1, 0 );
    } else if( direction == "south_west" ) {
        return tripoint_rel_ms( -1, 1, 0 );
    } else if( direction == "west" ) {
        return tripoint_rel_ms( -1, 0, 0 );
    }
    return tripoint_rel_ms( -1, -1, 0 );
}

bool dispatch_action( const action_request &request )
{
    if( cata_mp::is_mp_mode() ) {
        throw std::runtime_error( "Lua game actions are not available in multiplayer sessions" );
    }
    avatar &player = get_avatar();
    if( request.type == "wait" ) {
        if( player.activity ) {
            throw std::runtime_error( "cannot wait while an activity is active" );
        }
        player.pause();
        return true;
    }
    if( request.type == "move" ) {
        if( player.activity ) {
            throw std::runtime_error( "cannot move while an activity is active" );
        }
        if( player.in_vehicle ) {
            throw std::runtime_error( "Lua move actions are disabled while in a vehicle" );
        }
        avatar_action::move( player, get_map(), direction_delta( request.text_argument ) );
        return true;
    }
    if( request.type == "cancel_activity" ) {
        if( !player.activity ) {
            throw std::runtime_error( "no activity is active" );
        }
        if( !player.activity.is_interruptible() ) {
            throw std::runtime_error( "the current activity is not interruptible" );
        }
        player.cancel_activity();
        return false;
    }
    if( request.type == "use_item" ) {
        item_location location = find_carried_item( player, request.integer_argument );
        if( !location ) {
            throw std::runtime_error( "carried item UID was not found" );
        }
        avatar_action::use_item( player, location );
        return true;
    }
    if( request.type == "toggle_mutation" ) {
        const trait_id id( request.text_argument );
        if( !id.is_valid() || !player.has_trait( id ) ) {
            throw std::runtime_error( "mutation is not present on the avatar" );
        }
        if( !id->activated ) {
            throw std::runtime_error( "mutation is not activatable" );
        }
        if( player.has_active_mutation( id ) ) {
            player.deactivate_mutation( id );
        } else {
            player.activate_mutation( id );
        }
        return true;
    }
    if( request.type == "toggle_bionic" ) {
        bionic *installed = nullptr;
        for( bionic &entry : *player.my_bionics ) {
            if( entry.get_uid() == static_cast<bionic::bionic_uid>( request.integer_argument ) ) {
                installed = &entry;
                break;
            }
        }
        if( installed == nullptr ) {
            throw std::runtime_error( "bionic UID was not found" );
        }
        const bool changed = installed->powered ? player.deactivate_bionic( *installed ) :
                             player.activate_bionic( *installed );
        if( !changed ) {
            throw std::runtime_error( "bionic state change was rejected by the game" );
        }
        return true;
    }
    throw std::runtime_error( "unsupported queued action" );
}

} // namespace

void install_action_api( sol::table &game, std::function<void()> authorize_access,
                         std::function<bool()> can_mutate )
{
    sol::state_view state( game.lua_state() );
    sol::table actions = state.create_table();
    actions.set_function( "enqueue", [authorize_access, can_mutate]( const std::string & type,
    const sol::optional<sol::table> &options ) {
        return enqueue_action( authorize_access, can_mutate, type, options );
    } );
    actions.set_function( "cancel", [authorize_access, can_mutate]( std::uint64_t request_id ) {
        authorize_access();
        if( !can_mutate() ) {
            throw std::runtime_error( "game.actions.cancel is only available from an active callback" );
        }
        return cancel_action( request_id );
    } );
    actions.set_function( "status", [authorize_access]( sol::this_state lua,
    sol::optional<int> requested_result_limit ) {
        authorize_access();
        return actions_status( lua, requested_result_limit );
    } );
    game["actions"] = std::move( actions );
}

std::optional<bool> process_next_action()
{
    if( pending_actions.empty() ) {
        return std::nullopt;
    }
    action_request request = std::move( pending_actions.front() );
    pending_actions.pop_front();
    action_result result{ request.id, request.type, "succeeded", {}, request.queued_turn,
                          current_turn(), false };
    try {
        result.action_taken = dispatch_action( request );
    } catch( const std::exception &error ) {
        result.status = "failed";
        result.error = error.what();
        result.action_taken = false;
        add_msg( m_bad, "[Lua] " + result.error );
    }
    remember_result( result );
    return result.action_taken;
}

void clear_actions()
{
    pending_actions.clear();
    action_results.clear();
    next_action_id = 1;
}

} // namespace cata::lua_ui
