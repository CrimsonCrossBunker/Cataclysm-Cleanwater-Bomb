#include "android_hud.h"

#include <algorithm>
#include <chrono>
#include <cstdlib>
#include <mutex>
#include <sstream>
#include <stack>
#include <string>
#include <utility>
#include <vector>

#if defined(__ANDROID__)
    #include "avatar.h"
    #include "color.h"
    #include "coordinates.h"
    #include "creature.h"
    #include "imgui/imgui.h"
    #include "input_context_actions.h"
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

struct hud_text_run {
    std::string text;
    int color = 0xffffffff;
    bool bold = false;
};

struct hud_message {
    std::string text;
    std::vector<hud_text_run> runs;
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
    std::vector<hud_message> messages;
    std::vector<hud_action> active_actions;
};

std::mutex hud_mutex;
hud_snapshot latest_snapshot;
minimap_rect latest_minimap_rect;
std::chrono::steady_clock::time_point last_snapshot_refresh;

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

hud_message parse_formatted_message( const std::string &formatted )
{
    hud_message result;
    std::stack<nc_color> colors;
    colors.push( c_white );

    for( std::string segment : split_by_color( formatted ) ) {
        if( segment.empty() ) {
            continue;
        }
        if( segment.front() == '<' ) {
            const color_tag_parse_result::tag_type tag = update_color_stack(
                        colors, segment, report_color_error::no );
            if( tag != color_tag_parse_result::non_color_tag ) {
                segment = rm_prefix( std::move( segment ) );
            }
        }
        if( segment.empty() ) {
            continue;
        }

        const nc_color color = colors.empty() ? c_white : colors.top();
        const int argb = android_argb( color );
        const bool bold = color.is_bold();
        result.text += segment;
        if( !result.runs.empty() && result.runs.back().color == argb &&
            result.runs.back().bold == bold ) {
            result.runs.back().text += segment;
        } else {
            result.runs.push_back( { std::move( segment ), argb, bold } );
        }
    }
    return result;
}

} // namespace

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
    const cata::input_context_actions::context_snapshot context =
        cata::input_context_actions::snapshot();
    next.context_revision = context.revision;
    next.context = context.category;
    next.active_actions.reserve( context.actions.size() );
    for( const cata::input_context_actions::action_descriptor &action : context.actions ) {
        next.active_actions.push_back( {
            action.id, action.label, action.group, action.repeatable, action.dangerous
        } );
    }

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

    for( const std::pair<std::string, std::string> &message :
         Messages::recent_messages_with_formatting( 4 ) ) {
        next.messages.push_back( parse_formatted_message( message.second ) );
    }

    std::lock_guard<std::mutex> lock( hud_mutex );
    next.revision = latest_snapshot.revision + 1;
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
    json.member( "messages" );
    json.start_array();
    for( const hud_message &message : latest_snapshot.messages ) {
        json.write( message.text );
    }
    json.end_array();
    json.member( "formattedMessages" );
    json.start_array();
    for( const hud_message &message : latest_snapshot.messages ) {
        json.start_object();
        json.member( "text", message.text );
        json.member( "runs" );
        json.start_array();
        for( const hud_text_run &run : message.runs ) {
            json.start_object();
            json.member( "text", run.text );
            json.member( "color", run.color );
            json.member( "bold", run.bold );
            json.end_object();
        }
        json.end_array();
        json.end_object();
    }
    json.end_array();
    json.end_object();
    json.end_object();
    return out.str();
}

#else

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
