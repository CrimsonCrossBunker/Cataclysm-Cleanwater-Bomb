#include "android_hud.h"

#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <deque>
#include <mutex>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#if defined(__ANDROID__)
    #include "avatar.h"
    #include "color.h"
    #include "coordinates.h"
    #include "creature.h"
    #include "imgui/imgui.h"
    #include "item_location.h"
    #include "json.h"
    #include "omdata.h"
    #include "overmapbuffer.h"
    #include "messages.h"
    #include "output.h"
#endif

namespace android_hud
{

#if defined(__ANDROID__)
namespace
{

struct hud_body_part {
    std::string id;
    int current = 0;
    int maximum = 0;
};

struct hud_contact {
    std::string name;
    int dx = 0;
    int dy = 0;
    int distance = 0;
};

struct hud_overmap_cell {
    std::string symbol;
    int color = 0xff30343a;
};

struct hud_action {
    std::string id;
    std::string label;
    std::string group;
    bool repeatable = false;
    bool dangerous = false;

    bool operator==( const hud_action &rhs ) const {
        return id == rhs.id && label == rhs.label && group == rhs.group &&
               repeatable == rhs.repeatable && dangerous == rhs.dangerous;
    }
};

struct queued_action {
    std::string id;
    int context_revision = 0;
};

struct hud_snapshot {
    bool ready = false;
    int revision = 0;
    int context_revision = 0;
    std::string context;
    int stamina = 0;
    int stamina_max = 0;
    int pain = 0;
    int safe_mode = 0;
    std::string weapon;
    std::vector<hud_body_part> body_parts;
    std::vector<hud_contact> hostile_contacts;
    std::vector<hud_overmap_cell> overmap_cells;
    std::vector<std::string> messages;
    std::vector<hud_action> active_actions;
};

std::mutex hud_mutex;
std::deque<queued_action> pending_actions;
hud_snapshot latest_snapshot;
minimap_rect latest_minimap_rect;
std::chrono::steady_clock::time_point last_snapshot_refresh;

const std::set<std::string> &internal_actions()
{
    static const std::set<std::string> actions = {
        "ANY_INPUT", "MOUSE_MOVE", "COORDINATE", "CLICK_AND_DRAG", "SEC_SELECT", "TIMEOUT"
    };
    return actions;
}

bool has_fragment( const std::string &id, const std::string &fragment )
{
    return id.find( fragment ) != std::string::npos;
}

bool is_repeatable( const std::string &id )
{
    static const std::set<std::string> exact = {
        "UP", "RIGHTUP", "RIGHT", "RIGHTDOWN", "DOWN", "LEFTDOWN", "LEFT", "LEFTUP",
        "PAGE_UP", "PAGE_DOWN", "SCROLL_UP", "SCROLL_DOWN", "HOME", "END",
        "LEVEL_UP", "LEVEL_DOWN", "NEXT", "PREV", "NEXT_TAB", "PREV_TAB",
        "NEXT_COLUMN", "PREV_COLUMN", "NEXT_TARGET", "PREV_TARGET",
        "INCREASE_COUNT", "DECREASE_COUNT", "INCREASE_VALUE", "DECREASE_VALUE"
    };
    return exact.count( id ) > 0 || has_fragment( id, "SCROLL_" ) ||
           has_fragment( id, "BATCH_SIZE_" );
}

bool is_dangerous( const std::string &id )
{
    static const std::set<std::string> dangerous = {
        "SUICIDE", "quit_to_snapshot", "DELETE_TEMPLATE", "DELETE_WORLD", "RESET",
        "debug", "debug_mode", "QUICKLOAD", "quickload"
    };
    return dangerous.count( id ) > 0 || has_fragment( id, "DELETE_" ) ||
           has_fragment( id, "DEBUG_" );
}

std::string action_group( const std::string &id )
{
    static const std::set<std::string> navigation = {
        "UP", "RIGHTUP", "RIGHT", "RIGHTDOWN", "DOWN", "LEFTDOWN", "LEFT", "LEFTUP",
        "CENTER", "center", "HOME", "END", "LEVEL_UP", "LEVEL_DOWN"
    };
    static const std::set<std::string> primary = {
        "CONFIRM", "SELECT", "QUIT", "YES", "NO", "FIRE", "pause"
    };
    if( navigation.count( id ) > 0 ) {
        return "navigation";
    }
    if( primary.count( id ) > 0 ) {
        return "primary";
    }
    if( has_fragment( id, "PAGE_" ) || has_fragment( id, "SCROLL_" ) ||
        has_fragment( id, "TAB" ) || has_fragment( id, "COLUMN" ) ||
        has_fragment( id, "TARGET" ) ) {
        return "navigation";
    }
    if( id.rfind( "TEXT.", 0 ) == 0 || has_fragment( id, "FILTER" ) ||
        has_fragment( id, "SEARCH" ) ) {
        return "text";
    }
    if( is_dangerous( id ) || id == "main_menu" || id == "open_options" ||
        id == "help" || id == "HELP_KEYBINDINGS" || id == "save" || id == "quicksave" ) {
        return "system";
    }
    if( has_fragment( id, "AIM" ) || has_fragment( id, "FIRE" ) ||
        has_fragment( id, "AMMO" ) || id == "throw" || id == "reload_weapon" ) {
        return "combat";
    }
    if( has_fragment( id, "ITEM" ) || has_fragment( id, "INVENTORY" ) ||
        id == "pickup" || id == "wear" || id == "wield" || id == "eat" || id == "apply" ) {
        return "items";
    }
    if( id == "map" || id == "look" || id == "MISSIONS" || id == "missions" ||
        has_fragment( id, "NOTE" ) || has_fragment( id, "TRAVEL" ) || has_fragment( id, "MAP" ) ) {
        return "world";
    }
    if( id == "player_data" || id == "bionics" || id == "mutations" ||
        id == "medical" || id == "morale" || has_fragment( id, "TRAIT" ) ||
        has_fragment( id, "SKILL" ) ) {
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

std::string safe_weapon_name( const avatar &player )
{
    const item_location wielded = player.get_wielded_item();
    return wielded ? wielded->tname() : std::string();
}

int android_argb( const nc_color &color )
{
    const ImVec4 rgba = color;
    const int r = std::clamp( static_cast<int>( rgba.x * 255.0f ), 0, 255 );
    const int g = std::clamp( static_cast<int>( rgba.y * 255.0f ), 0, 255 );
    const int b = std::clamp( static_cast<int>( rgba.z * 255.0f ), 0, 255 );
    return static_cast<int>( 0xff000000u | static_cast<unsigned int>( r << 16 ) |
                             static_cast<unsigned int>( g << 8 ) | static_cast<unsigned int>( b ) );
}

} // namespace

bool enqueue_action( const std::string &action, const int context_revision )
{
    std::lock_guard<std::mutex> lock( hud_mutex );
    const bool active = std::any_of( latest_snapshot.active_actions.begin(),
    latest_snapshot.active_actions.end(), [&]( const hud_action & candidate ) {
        return candidate.id == action;
    } );
    if( !active || ( context_revision >= 0 &&
                     context_revision != latest_snapshot.context_revision ) ) {
        return false;
    }
    // A held Android button must not create an unbounded sequence of stale
    // commands while a modal game UI is open.
    constexpr size_t max_pending_actions = 8;
    if( pending_actions.size() >= max_pending_actions ) {
        pending_actions.pop_front();
    }
    pending_actions.push_back( { action, latest_snapshot.context_revision } );
    return true;
}

bool consume_action_for_context( const std::vector<std::string> &registered_actions,
                                 std::string &action )
{
    std::lock_guard<std::mutex> lock( hud_mutex );
    if( pending_actions.empty() ) {
        return false;
    }

    // Commands are one-shot.  Dropping a command that belongs to a previous
    // screen is safer than replaying it after the player exits that screen.
    queued_action candidate = std::move( pending_actions.front() );
    pending_actions.pop_front();
    if( candidate.context_revision != latest_snapshot.context_revision ||
        !is_registered( registered_actions, candidate.id ) ) {
        return false;
    }
    action = std::move( candidate.id );
    return true;
}

void set_active_context( const std::string &category,
                         const std::vector<action_descriptor> &registered_actions )
{
    std::vector<hud_action> filtered;
    filtered.reserve( registered_actions.size() );
    for( const action_descriptor &action : registered_actions ) {
        if( internal_actions().count( action.id ) == 0 ) {
            filtered.push_back( { action.id, action.label, action_group( action.id ),
                                  is_repeatable( action.id ), is_dangerous( action.id ) } );
        }
    }

    std::lock_guard<std::mutex> lock( hud_mutex );
    if( latest_snapshot.context != category || latest_snapshot.active_actions != filtered ) {
        latest_snapshot.context = category;
        latest_snapshot.active_actions = std::move( filtered );
        ++latest_snapshot.context_revision;
        ++latest_snapshot.revision;
        pending_actions.clear();
    }
}

void set_minimap_rect( const minimap_rect &rect )
{
    std::lock_guard<std::mutex> lock( hud_mutex );
    latest_minimap_rect = rect;
}

minimap_rect get_minimap_rect()
{
    std::lock_guard<std::mutex> lock( hud_mutex );
    return latest_minimap_rect;
}

void publish_snapshot( const avatar &player, const int safe_mode )
{
    const std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    if( last_snapshot_refresh.time_since_epoch().count() != 0 &&
        std::chrono::duration_cast<std::chrono::milliseconds>( now - last_snapshot_refresh ).count() <
        100 ) {
        return;
    }
    last_snapshot_refresh = now;

    hud_snapshot next;
    next.ready = true;
    next.stamina = player.get_stamina();
    next.stamina_max = player.get_stamina_max();
    next.pain = player.get_pain();
    next.safe_mode = safe_mode;
    next.weapon = safe_weapon_name( player );

    for( const bodypart_id &part : player.get_all_body_parts() ) {
        next.body_parts.push_back( { part.id().str(), player.get_part_hp_cur( part ),
                                     player.get_part_hp_max( part ) } );
    }

    const tripoint_bub_ms player_pos = player.pos_bub();
    for( Creature *const creature : player.get_hostile_creatures( 60 ) ) {
        if( creature == nullptr || next.hostile_contacts.size() >= 32 ) {
            continue;
        }
        const tripoint_bub_ms creature_pos = creature->pos_bub();
        const int dx = creature_pos.x() - player_pos.x();
        const int dy = creature_pos.y() - player_pos.y();
        next.hostile_contacts.push_back( { creature->get_name(), dx, dy,
                                           std::max( std::abs( dx ), std::abs( dy ) ) } );
    }

    const tripoint_abs_omt player_omt = player.pos_abs_omt();
    for( int y = -3; y <= 3; ++y ) {
        for( int x = -3; x <= 3; ++x ) {
            const tripoint_abs_omt omt = player_omt + tripoint( x, y, 0 );
            const om_vision_level vision = overmap_buffer.seen( omt );
            if( vision == om_vision_level::unseen ) {
                next.overmap_cells.push_back( { "#", android_argb( c_dark_gray ) } );
                continue;
            }
            const oter_id &terrain = overmap_buffer.ter( omt );
            nc_color color = terrain->get_color( vision, false );
            if( overmap_buffer.is_explored( omt ) ) {
                color = c_dark_gray;
            }
            next.overmap_cells.push_back( { terrain->get_symbol( vision, false ),
                                            android_argb( color ) } );
        }
    }

    for( const std::pair<std::string, std::string> &message : Messages::recent_messages( 4 ) ) {
        next.messages.push_back( remove_color_tags( message.second ) );
    }

    std::lock_guard<std::mutex> lock( hud_mutex );
    next.revision = latest_snapshot.revision + 1;
    next.context_revision = latest_snapshot.context_revision;
    next.context = latest_snapshot.context;
    next.active_actions = latest_snapshot.active_actions;
    latest_snapshot = std::move( next );
}

std::string snapshot_json()
{
    std::lock_guard<std::mutex> lock( hud_mutex );
    std::ostringstream out;
    JsonOut json( out );
    json.start_object();
    json.member( "schema", 2 );
    json.member( "revision", latest_snapshot.revision );
    json.member( "contextRevision", latest_snapshot.context_revision );
    json.member( "context", latest_snapshot.context );
    json.member( "ready", latest_snapshot.ready );
    json.member( "availableActions" );
    json.start_array();
    for( const hud_action &action : latest_snapshot.active_actions ) {
        json.write( action.id );
    }
    json.end_array();
    json.member( "actions" );
    json.start_array();
    for( const hud_action &action : latest_snapshot.active_actions ) {
        json.start_object();
        json.member( "id", action.id );
        json.member( "label", action.label );
        json.member( "group", action.group );
        json.member( "repeatable", action.repeatable );
        json.member( "dangerous", action.dangerous );
        json.end_object();
    }
    json.end_array();
    json.member( "state" );
    json.start_object();
    json.member( "stamina", latest_snapshot.stamina );
    json.member( "staminaMax", latest_snapshot.stamina_max );
    json.member( "pain", latest_snapshot.pain );
    json.member( "safeMode", latest_snapshot.safe_mode );
    json.member( "weapon", latest_snapshot.weapon );
    json.member( "bodyParts" );
    json.start_array();
    for( const hud_body_part &part : latest_snapshot.body_parts ) {
        json.start_object();
        json.member( "id", part.id );
        json.member( "current", part.current );
        json.member( "maximum", part.maximum );
        json.end_object();
    }
    json.end_array();
    json.member( "hostiles" );
    json.start_array();
    for( const hud_contact &contact : latest_snapshot.hostile_contacts ) {
        json.start_object();
        json.member( "name", contact.name );
        json.member( "dx", contact.dx );
        json.member( "dy", contact.dy );
        json.member( "distance", contact.distance );
        json.end_object();
    }
    json.end_array();
    json.member( "overmap" );
    json.start_array();
    for( const hud_overmap_cell &cell : latest_snapshot.overmap_cells ) {
        json.start_object();
        json.member( "symbol", cell.symbol );
        json.member( "color", cell.color );
        json.end_object();
    }
    json.end_array();
    json.member( "messages", latest_snapshot.messages );
    json.end_object();
    json.end_object();
    return out.str();
}

#else

bool enqueue_action( const std::string &, int )
{
    return false;
}

bool consume_action_for_context( const std::vector<std::string> &, std::string & )
{
    return false;
}

void set_active_context( const std::string &, const std::vector<action_descriptor> & )
{
}

void set_minimap_rect( const minimap_rect & )
{
}

minimap_rect get_minimap_rect()
{
    return {};
}

void publish_snapshot( const avatar &, int )
{
}

std::string snapshot_json()
{
    return "{}";
}

#endif

} // namespace android_hud
