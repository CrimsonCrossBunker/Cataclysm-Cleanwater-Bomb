#include "input_context_actions.h"

#include <algorithm>
#include <cctype>
#include <cstdint>
#include <deque>
#include <limits>
#include <mutex>
#include <set>
#include <string>
#include <unordered_set>
#include <utility>
#include <vector>

namespace cata::input_context_actions
{

namespace
{

struct queued_action {
    std::string id;
    int context_revision = 0;
};

constexpr std::size_t maximum_pending_actions = 16;

std::mutex context_mutex;
context_snapshot active_context;
std::unordered_set<std::string> active_allowed_actions;
std::unordered_set<std::string> active_dangerous_actions;
std::deque<queued_action> pending_actions;
int active_label_revision = std::numeric_limits<int>::min();
std::uint64_t active_catalog_token = 0;

const std::set<std::string> &internal_actions()
{
    static const std::set<std::string> actions = {
        "ANY_INPUT", "MOUSE_MOVE", "COORDINATE", "CLICK_AND_DRAG", "SEC_SELECT", "TIMEOUT"
    };
    return actions;
}

std::string normalize_action_id( const std::string &id )
{
    std::string normalized = id;
    std::transform( normalized.begin(), normalized.end(), normalized.begin(),
    []( const unsigned char value ) {
        return static_cast<char>( std::toupper( value ) );
    } );
    return normalized;
}

bool has_fragment( const std::string &id, const std::string &fragment )
{
    return id.find( fragment ) != std::string::npos;
}

bool is_repeatable( const std::string &normalized_id )
{
    static const std::set<std::string> exact = {
        "UP", "RIGHTUP", "RIGHT", "RIGHTDOWN", "DOWN", "LEFTDOWN", "LEFT", "LEFTUP",
        "PAGE_UP", "PAGE_DOWN", "SCROLL_UP", "SCROLL_DOWN", "HOME", "END",
        "LEVEL_UP", "LEVEL_DOWN", "NEXT", "PREV", "NEXT_TAB", "PREV_TAB",
        "NEXT_COLUMN", "PREV_COLUMN", "NEXT_TARGET", "PREV_TARGET",
        "INCREASE_COUNT", "DECREASE_COUNT", "INCREASE_VALUE", "DECREASE_VALUE"
    };
    return exact.count( normalized_id ) > 0 || has_fragment( normalized_id, "SCROLL_" ) ||
           has_fragment( normalized_id, "BATCH_SIZE_" );
}

bool is_dangerous( const std::string &normalized_id )
{
    static const std::set<std::string> dangerous = {
        "SUICIDE", "QUIT_TO_SNAPSHOT", "DELETE_TEMPLATE", "DELETE_WORLD", "RESET",
        "DEBUG", "DEBUG_MODE", "QUICKLOAD"
    };
    return dangerous.count( normalized_id ) > 0 ||
           has_fragment( normalized_id, "DELETE" ) ||
           has_fragment( normalized_id, "DEBUG" );
}

std::string action_group( const std::string &normalized_id, const bool dangerous )
{
    static const std::set<std::string> navigation = {
        "UP", "RIGHTUP", "RIGHT", "RIGHTDOWN", "DOWN", "LEFTDOWN", "LEFT", "LEFTUP",
        "CENTER", "HOME", "END", "LEVEL_UP", "LEVEL_DOWN"
    };
    static const std::set<std::string> primary = {
        "CONFIRM", "SELECT", "QUIT", "YES", "NO", "FIRE", "PAUSE"
    };
    if( navigation.count( normalized_id ) > 0 ) {
        return "navigation";
    }
    if( primary.count( normalized_id ) > 0 ) {
        return "primary";
    }
    if( has_fragment( normalized_id, "PAGE_" ) ||
        has_fragment( normalized_id, "SCROLL_" ) ||
        has_fragment( normalized_id, "TAB" ) ||
        has_fragment( normalized_id, "COLUMN" ) ||
        has_fragment( normalized_id, "TARGET" ) ) {
        return "navigation";
    }
    if( normalized_id.rfind( "TEXT.", 0 ) == 0 ||
        has_fragment( normalized_id, "FILTER" ) ||
        has_fragment( normalized_id, "SEARCH" ) ) {
        return "text";
    }
    if( dangerous || normalized_id == "MAIN_MENU" || normalized_id == "OPEN_OPTIONS" ||
        normalized_id == "HELP" || normalized_id == "HELP_KEYBINDINGS" ||
        normalized_id == "SAVE" || normalized_id == "QUICKSAVE" ) {
        return "system";
    }
    if( has_fragment( normalized_id, "AIM" ) ||
        has_fragment( normalized_id, "FIRE" ) ||
        has_fragment( normalized_id, "AMMO" ) ||
        normalized_id == "AUTOATTACK" || normalized_id == "THROW" ||
        normalized_id == "RELOAD_WEAPON" ) {
        return "combat";
    }
    if( has_fragment( normalized_id, "ITEM" ) ||
        has_fragment( normalized_id, "INVENTORY" ) ||
        normalized_id == "PICKUP" || normalized_id == "WEAR" ||
        normalized_id == "WIELD" || normalized_id == "EAT" ||
        normalized_id == "APPLY" ) {
        return "items";
    }
    if( normalized_id == "MAP" || normalized_id == "LOOK" ||
        normalized_id == "MISSIONS" || has_fragment( normalized_id, "NOTE" ) ||
        has_fragment( normalized_id, "TRAVEL" ) ||
        has_fragment( normalized_id, "MAP" ) ) {
        return "world";
    }
    if( normalized_id == "PLAYER_DATA" || normalized_id == "BIONICS" ||
        normalized_id == "MUTATIONS" || normalized_id == "MEDICAL" ||
        normalized_id == "MORALE" || normalized_id == "BODYSTATUS" ||
        has_fragment( normalized_id, "TRAIT" ) ||
        has_fragment( normalized_id, "SKILL" ) ) {
        return "character";
    }
    return "context";
}

bool is_registered( const std::vector<std::string> &registered_actions,
                    const std::string &action )
{
    return std::find( registered_actions.begin(), registered_actions.end(), action ) !=
           registered_actions.end();
}

int next_revision( int current )
{
    return current == std::numeric_limits<int>::max() ? 1 : current + 1;
}

} // namespace

bool action_descriptor::operator==( const action_descriptor &rhs ) const
{
    return id == rhs.id && label == rhs.label && group == rhs.group &&
           repeatable == rhs.repeatable && dangerous == rhs.dangerous;
}

bool needs_publish( const std::string &category,
                    const std::string &hud_scene_id,
                    const std::string &hud_scene_title,
                    const std::vector<std::string> &registered_action_ids,
                    const std::uint64_t catalog_token,
                    const int label_revision )
{
    std::lock_guard<std::mutex> lock( context_mutex );
    if( category != active_context.category ||
        hud_scene_id != active_context.hud_scene_id ||
        hud_scene_title != active_context.hud_scene_title ||
        catalog_token != active_catalog_token ||
        label_revision != active_label_revision ) {
        return true;
    }
    std::size_t published_index = 0;
    for( const std::string &action_id : registered_action_ids ) {
        if( action_id.empty() ) {
            continue;
        }
        if( published_index < active_context.actions.size() &&
            action_id == active_context.actions[published_index].id ) {
            ++published_index;
            continue;
        }
        if( internal_actions().count( normalize_action_id( action_id ) ) == 0 ) {
            return true;
        }
    }
    return published_index != active_context.actions.size();
}

void publish( const std::string &category,
              const std::string &hud_scene_id,
              const std::string &hud_scene_title,
              const std::vector<action_descriptor> &registered_actions,
              const std::uint64_t catalog_token,
              const int label_revision )
{
    std::vector<action_descriptor> filtered;
    filtered.reserve( registered_actions.size() );
    for( const action_descriptor &action : registered_actions ) {
        const std::string normalized_id = normalize_action_id( action.id );
        if( normalized_id.empty() || internal_actions().count( normalized_id ) > 0 ) {
            continue;
        }
        const bool dangerous = action.dangerous || is_dangerous( normalized_id );
        filtered.push_back( {
            action.id,
            action.label,
            action.group.empty() ? action_group( normalized_id, dangerous ) : action.group,
            action.repeatable || is_repeatable( normalized_id ),
            dangerous
        } );
    }

    std::lock_guard<std::mutex> lock( context_mutex );
    if( active_context.category == category &&
        active_context.hud_scene_id == hud_scene_id &&
        active_context.hud_scene_title == hud_scene_title &&
        active_context.actions == filtered ) {
        active_catalog_token = catalog_token;
        active_label_revision = label_revision;
        return;
    }
    active_context.category = category;
    active_context.hud_scene_id = hud_scene_id.empty() ? category : hud_scene_id;
    active_context.hud_scene_title = hud_scene_title.empty() ?
                                     active_context.hud_scene_id : hud_scene_title;
    active_context.actions = std::move( filtered );
    active_context.revision = next_revision( active_context.revision );
    active_catalog_token = catalog_token;
    active_label_revision = label_revision;
    active_allowed_actions.clear();
    active_dangerous_actions.clear();
    active_allowed_actions.reserve( active_context.actions.size() );
    for( const action_descriptor &action : active_context.actions ) {
        active_allowed_actions.insert( action.id );
        if( action.dangerous ) {
            active_dangerous_actions.insert( action.id );
        }
    }
    pending_actions.clear();
}

context_snapshot snapshot()
{
    std::lock_guard<std::mutex> lock( context_mutex );
    return active_context;
}

std::vector<bool> validate_candidates( const int context_revision,
                                       const std::vector<std::string> &actions )
{
    std::vector<bool> result( actions.size(), false );
    std::lock_guard<std::mutex> lock( context_mutex );
    if( context_revision != active_context.revision ) {
        return result;
    }
    for( std::size_t index = 0; index < actions.size(); ++index ) {
        result[index] = active_allowed_actions.count( actions[index] ) > 0;
    }
    return result;
}

bool enqueue( const std::string &action, const int context_revision,
              const bool dangerous_authorized )
{
    std::lock_guard<std::mutex> lock( context_mutex );
    if( active_allowed_actions.count( action ) == 0 ||
        ( active_dangerous_actions.count( action ) > 0 && !dangerous_authorized ) ||
        ( context_revision >= 0 && context_revision != active_context.revision ) ||
        pending_actions.size() >= maximum_pending_actions ) {
        return false;
    }
    pending_actions.push_back( { action, active_context.revision } );
    return true;
}

bool has_pending()
{
    std::lock_guard<std::mutex> lock( context_mutex );
    return !pending_actions.empty();
}

bool consume( const std::vector<std::string> &registered_actions, std::string &action )
{
    std::lock_guard<std::mutex> lock( context_mutex );
    while( !pending_actions.empty() ) {
        queued_action candidate = std::move( pending_actions.front() );
        pending_actions.pop_front();
        if( candidate.context_revision == active_context.revision &&
            is_registered( registered_actions, candidate.id ) ) {
            action = std::move( candidate.id );
            return true;
        }
    }
    return false;
}

void clear()
{
    std::lock_guard<std::mutex> lock( context_mutex );
    active_context.category.clear();
    active_context.hud_scene_id.clear();
    active_context.hud_scene_title.clear();
    active_context.actions.clear();
    active_context.revision = next_revision( active_context.revision );
    active_catalog_token = 0;
    active_label_revision = std::numeric_limits<int>::min();
    active_allowed_actions.clear();
    active_dangerous_actions.clear();
    pending_actions.clear();
}

} // namespace cata::input_context_actions
