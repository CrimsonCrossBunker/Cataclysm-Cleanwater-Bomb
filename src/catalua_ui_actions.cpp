#include "catalua_ui_actions.h"
#include "catalua_ui_actions_internal.h"

#include <algorithm>
#include <array>
#include <cctype>
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
#include "crafting.h"
#include "item.h"
#include "item_location.h"
#include "input_context_actions.h"
#include "map.h"
#include "messages.h"
#include "move_mode.h"
#include "mp_gamestate.h"
#include "mutation.h"
#include "output.h"
#include "point.h"
#include "recipe.h"
#include "translations.h"

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
    int context_revision = -1;
    std::string source_id;
    std::string label;
    bool dangerous = false;
    bool bool_argument = false;
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

bool valid_move_mode_id( const std::string &id )
{
    return !id.empty() && id.size() <= 64 &&
    std::all_of( id.begin(), id.end(), []( const unsigned char ch ) {
        return std::isalnum( ch ) != 0 || ch == '_' || ch == '-';
    } );
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
    } else if( type == "toggle_mutation" || type == "set_move_mode" ) {
        request.text_argument = required_string( options, "id", type );
        if( request.text_argument.empty() ) {
            throw std::invalid_argument( "game.actions.enqueue '" + type + "' id cannot be empty" );
        }
        if( type == "set_move_mode" && !valid_move_mode_id( request.text_argument ) ) {
            throw std::invalid_argument( "game.actions.enqueue set_move_mode id is invalid" );
        }
    } else if( type != "wait" && type != "cancel_activity" && type != "cycle_move_mode" ) {
        throw std::invalid_argument( "game.actions.enqueue action type is not allowed: " + type );
    }

    pending_actions.push_back( std::move( request ) );
    return pending_actions.back().id;
}

cata::input_context_actions::action_descriptor context_action_descriptor(
    const std::string &action, const int context_revision )
{
    const cata::input_context_actions::context_snapshot context =
        cata::input_context_actions::snapshot();
    if( context_revision != context.revision ) {
        throw std::runtime_error(
            "game.actions.enqueue_context received a stale context revision" );
    }
    const auto found = std::find_if(
                           context.actions.begin(), context.actions.end(),
    [&action]( const cata::input_context_actions::action_descriptor & entry ) {
        return entry.id == action;
    } );
    if( found == context.actions.end() ) {
        throw std::runtime_error(
            "game.actions.enqueue_context action is unavailable in the active context" );
    }
    return *found;
}

std::uint64_t enqueue_context_action_request(
    const std::function<void()> &authorize_access,
    const std::function<void()> &authorize_dangerous,
    const std::function<std::string()> &source_id,
    const std::function<bool()> &can_mutate, const std::string &action,
    const int context_revision )
{
    authorize_access();
    if( !can_mutate() ) {
        throw std::runtime_error(
            "game.actions.enqueue_context is only available from an active callback" );
    }
    const cata::input_context_actions::action_descriptor descriptor =
        context_action_descriptor( action, context_revision );
    if( descriptor.dangerous ) {
        authorize_dangerous();
    }
    return enqueue_context_action( action, context_revision, source_id() );
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
    if( request.type == "context" ) {
        snapshot["action"] = request.text_argument;
        snapshot["context_revision"] = request.context_revision;
        snapshot["dangerous"] = request.dangerous;
        snapshot["source"] = request.source_id;
    } else if( request.type == "craft" ) {
        snapshot["recipe"] = request.text_argument;
        snapshot["batch"] = request.integer_argument;
        snapshot["long"] = request.bool_argument;
        snapshot["source"] = request.source_id;
    }
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

sol::table input_context_snapshot( sol::this_state lua,
                                   const bool dangerous_available )
{
    sol::state_view state( lua );
    const cata::input_context_actions::context_snapshot context =
        cata::input_context_actions::snapshot();
    sol::table actions = state.create_table();
    sol::table available = state.create_table();
    for( std::size_t index = 0; index < context.actions.size(); ++index ) {
        const cata::input_context_actions::action_descriptor &action = context.actions[index];
        sol::table entry = state.create_table();
        entry["id"] = action.id;
        entry["label"] = action.label;
        entry["group"] = action.group;
        entry["repeatable"] = action.repeatable;
        entry["dangerous"] = action.dangerous;
        actions[index + 1] = std::move( entry );
        available[action.id] = !action.dangerous || dangerous_available;
    }
    sol::table result = state.create_table();
    result["category"] = context.category;
    result["revision"] = context.revision;
    result["actions"] = std::move( actions );
    result["available"] = std::move( available );
    return result;
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
    if( request.type == "context" ) {
        if( !cata::input_context_actions::enqueue(
                request.text_argument, request.context_revision,
                request.dangerous ) ) {
            throw std::runtime_error(
                "named input action became stale or unavailable before dispatch" );
        }
        return false;
    }
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
    if( request.type == "cycle_move_mode" ) {
        player.cycle_desired_move_mode();
        return false;
    }
    if( request.type == "set_move_mode" ) {
        const move_mode_id mode( request.text_argument );
        if( !mode.is_valid() ) {
            throw std::runtime_error( "movement mode id was not found" );
        }
        if( !player.can_switch_to( mode ) ) {
            throw std::runtime_error( "movement mode is not currently available" );
        }
        if( player.get_desired_move_mode() != mode ) {
            player.set_desired_movement_mode( mode );
        }
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
    if( request.type == "craft" ) {
        if( player.activity ) {
            throw std::runtime_error(
                "cannot start a craft while an activity is active" );
        }
        const recipe_id id( request.text_argument );
        if( !id.is_valid() ) {
            throw std::runtime_error(
                "queued recipe is no longer available" );
        }
        const recipe &value = id.obj();
        const int batch =
            static_cast<int>( request.integer_argument );
        if( !player.has_recipe( &value ) ) {
            throw std::runtime_error(
                "the recipe is not currently available to the avatar" );
        }
        if( !value.character_has_required_proficiencies( player ) ) {
            throw std::runtime_error(
                "the avatar lacks a required proficiency" );
        }
        if( !crafting_allowed( player, value ) ) {
            throw std::runtime_error(
                "crafting is not currently allowed" );
        }
        if( !player.can_start_craft(
                &value, recipe_filter_flags::none, batch ) ) {
            throw std::runtime_error(
                "the recipe cannot currently be started" );
        }
        if( request.bool_argument ) {
            player.make_all_craft( id, batch, std::nullopt );
        } else {
            player.make_craft( id, batch );
        }
        if( !player.activity ) {
            throw std::runtime_error(
                "craft setup was canceled or rejected" );
        }
        return true;
    }
    throw std::runtime_error( "unsupported queued action" );
}

} // namespace

void install_action_api( sol::table &game, std::function<void()> authorize_access,
                         std::function<void()> authorize_dangerous,
                         std::function<bool()> dangerous_available,
                         std::function<std::string()> source_id,
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
    actions.set_function(
        "enqueue_context",
        [authorize_access, authorize_dangerous, source_id, can_mutate](
    const std::string & action, const int context_revision ) {
        return enqueue_context_action_request(
                   authorize_access, authorize_dangerous, source_id, can_mutate,
                   action, context_revision );
    } );
    actions.set_function( "status", [authorize_access]( sol::this_state lua,
    sol::optional<int> requested_result_limit ) {
        authorize_access();
        return actions_status( lua, requested_result_limit );
    } );
    actions.set_function(
        "context_snapshot",
    [authorize_access, dangerous_available]( sol::this_state lua ) {
        authorize_access();
        return input_context_snapshot( lua, dangerous_available() );
    } );
    game["actions"] = std::move( actions );
}

std::uint64_t enqueue_context_action( const std::string &action,
                                      const int context_revision,
                                      const std::string &source_id )
{
    if( pending_actions.size() >= maximum_pending_actions ) {
        throw std::runtime_error( "game.actions queue is full" );
    }
    const cata::input_context_actions::action_descriptor descriptor =
        context_action_descriptor( action, context_revision );
    action_request request;
    request.id = next_action_id++;
    request.type = "context";
    request.text_argument = action;
    request.queued_turn = current_turn();
    request.context_revision = context_revision;
    request.source_id = source_id;
    request.label = descriptor.label;
    request.dangerous = descriptor.dangerous;
    pending_actions.push_back( std::move( request ) );
    return pending_actions.back().id;
}

std::uint64_t enqueue_craft_action( const std::string &recipe,
                                    const int batch,
                                    const bool long_craft,
                                    const std::string &source_id )
{
    if( pending_actions.size() >= maximum_pending_actions ) {
        throw std::runtime_error( "game.actions queue is full" );
    }
    if( recipe.empty() || recipe.size() > 256 ||
        recipe.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "queued recipe id must contain 1 to 256 non-NUL bytes" );
    }
    if( batch < 1 || batch > 1000 ) {
        throw std::invalid_argument(
            "queued craft batch must be within 1..1000" );
    }
    action_request request;
    request.id = next_action_id++;
    request.type = "craft";
    request.text_argument = recipe;
    request.integer_argument = batch;
    request.queued_turn = current_turn();
    request.source_id = source_id;
    request.bool_argument = long_craft;
    pending_actions.push_back( std::move( request ) );
    return pending_actions.back().id;
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
    if( request.type == "context" && request.dangerous &&
        !query_yn(
            _( "Lua source \"%s\" requests the dangerous action \"%s\" (%s).  Allow it once?" ),
            request.source_id, request.label, request.text_argument ) ) {
        result.status = "denied";
        remember_result( std::move( result ) );
        return false;
    }
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
