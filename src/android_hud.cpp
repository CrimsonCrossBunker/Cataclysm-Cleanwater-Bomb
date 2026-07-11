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
#include "creature.h"
#include "item_location.h"
#include "json.h"
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

struct hud_snapshot {
    bool ready = false;
    int revision = 0;
    int stamina = 0;
    int stamina_max = 0;
    int pain = 0;
    int safe_mode = 0;
    std::string weapon;
    std::vector<hud_body_part> body_parts;
    std::vector<hud_contact> hostile_contacts;
    std::vector<std::string> messages;
    std::vector<std::string> active_actions;
};

std::mutex hud_mutex;
std::deque<std::string> pending_actions;
hud_snapshot latest_snapshot;
std::chrono::steady_clock::time_point last_snapshot_refresh;

const std::set<std::string> &allowed_actions()
{
    // This is deliberately a curated public Android action surface.  Layouts
    // can only reference these stable IDs; Java cannot invoke arbitrary game
    // internals or construct keyboard events.
    static const std::set<std::string> actions = {
        "UP", "RIGHTUP", "RIGHT", "RIGHTDOWN", "DOWN", "LEFTDOWN", "LEFT", "LEFTUP",
        "pause", "LEVEL_DOWN", "LEVEL_UP", "center", "cycle_move", "cycle_move_reverse",
        "reset_move", "toggle_run", "toggle_crouch", "toggle_prone", "open_movement",
        "open", "close", "smash", "loot", "examine", "interact", "pickup", "pickup_all",
        "grab", "haul", "haul_toggle", "butcher", "chat", "look", "peek", "listitems",
        "inventory", "apply", "apply_wielded", "eat", "wield", "reload_weapon",
        "reload_wielded", "throw", "throw_wielded", "fire", "select_fire_mode", "wait",
        "sleep", "safemode", "autosafe", "autoattack", "ignore_enemy", "action_menu",
        "messages", "map", "missions", "help", "main_menu", "zoom_in", "zoom_out",
        "CONFIRM", "QUIT", "PAGE_UP", "PAGE_DOWN", "SCROLL_UP", "SCROLL_DOWN", "HOME", "END"
    };
    return actions;
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

} // namespace

bool enqueue_action( const std::string &action )
{
    if( allowed_actions().count( action ) == 0 ) {
        return false;
    }

    std::lock_guard<std::mutex> lock( hud_mutex );
    // A held Android button must not create an unbounded sequence of stale
    // commands while a modal game UI is open.
    constexpr size_t max_pending_actions = 8;
    if( pending_actions.size() >= max_pending_actions ) {
        pending_actions.pop_front();
    }
    pending_actions.push_back( action );
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
    const std::string candidate = std::move( pending_actions.front() );
    pending_actions.pop_front();
    if( !is_registered( registered_actions, candidate ) ) {
        return false;
    }
    action = candidate;
    return true;
}

void set_active_actions( const std::vector<std::string> &registered_actions )
{
    std::vector<std::string> filtered;
    filtered.reserve( registered_actions.size() );
    for( const std::string &action : registered_actions ) {
        if( allowed_actions().count( action ) != 0 ) {
            filtered.push_back( action );
        }
    }

    std::lock_guard<std::mutex> lock( hud_mutex );
    if( latest_snapshot.active_actions != filtered ) {
        latest_snapshot.active_actions = std::move( filtered );
        ++latest_snapshot.revision;
    }
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

    for( const std::pair<std::string, std::string> &message : Messages::recent_messages( 4 ) ) {
        next.messages.push_back( remove_color_tags( message.second ) );
    }

    std::lock_guard<std::mutex> lock( hud_mutex );
    next.revision = latest_snapshot.revision + 1;
    next.active_actions = latest_snapshot.active_actions;
    latest_snapshot = std::move( next );
}

std::string snapshot_json()
{
    std::lock_guard<std::mutex> lock( hud_mutex );
    std::ostringstream out;
    JsonOut json( out );
    json.start_object();
    json.member( "schema", 1 );
    json.member( "revision", latest_snapshot.revision );
    json.member( "ready", latest_snapshot.ready );
    json.member( "availableActions", latest_snapshot.active_actions );
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
    json.member( "messages", latest_snapshot.messages );
    json.end_object();
    json.end_object();
    return out.str();
}

#else

bool enqueue_action( const std::string & )
{
    return false;
}

bool consume_action_for_context( const std::vector<std::string> &, std::string & )
{
    return false;
}

void set_active_actions( const std::vector<std::string> & )
{
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
