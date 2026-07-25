#include "android_hud.h"

#include <algorithm>
#include <cctype>
#include <chrono>
#include <cstdlib>
#include <mutex>
#include <sstream>
#include <stack>
#include <string>
#include <unordered_set>
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
    #include "messages.h"
    #include "omdata.h"
    #include "output.h"
    #include "overmapbuffer.h"
    #include "translations.h"
    #include "widget.h"
#endif

namespace android_hud
{

#if defined(__ANDROID__)
namespace
{

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

struct hud_info_source {
    std::string id;
    std::string title;
    std::string category;
    std::string renderer;
    std::string widget_id;
    unsigned int widget_width = 24;
    int default_width = 320;
    int default_height = 100;
    bool multiline = false;
};

struct hud_info_value {
    std::string source_id;
    std::string text;
};

struct hud_snapshot {
    bool ready = false;
    int revision = 0;
    int context_revision = 0;
    std::string input_category;
    std::string scene_id;
    std::string scene_title;
    std::vector<hud_action> actions;
    std::vector<hud_info_source> sources;
    std::vector<hud_info_value> values;
    std::vector<hud_contact> hostile_contacts;
    std::vector<hud_overmap_cell> overmap_cells;
    std::vector<hud_message> messages;
};

std::mutex hud_mutex;
hud_snapshot latest_snapshot;
minimap_rect latest_minimap_rect;
std::unordered_set<std::string> active_subscriptions;
std::chrono::steady_clock::time_point last_snapshot_refresh;
std::vector<hud_info_source> source_catalog;
int source_catalog_language_revision = -1;

bool safe_source_id( const std::string &id )
{
    if( id.empty() || id.size() > 160 ) {
        return false;
    }
    return std::all_of( id.begin(), id.end(), []( const unsigned char c ) {
        return std::isalnum( c ) != 0 || c == '_' || c == '-' || c == '.' || c == ':';
    } );
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
        hud_text_run run;
        run.text = remove_color_tags( segment );
        run.color = android_argb( colors.top() );
        result.text += run.text;
        result.runs.push_back( std::move( run ) );
    }
    if( result.text.empty() ) {
        result.text = remove_color_tags( formatted );
    }
    return result;
}

void add_widget_source( std::vector<hud_info_source> &result, const std::string &id,
                        const std::string &title, const std::string &category,
                        const std::string &widget_id, const unsigned int widget_width,
                        const int default_width, const int default_height,
                        const bool multiline = false )
{
    result.push_back( { id, title, category, "text", widget_id, widget_width,
                        default_width, default_height, multiline } );
}

std::vector<hud_info_source> make_source_catalog()
{
    std::vector<hud_info_source> result;
    result.reserve( widget::get_all().size() + 80 );
    const std::string location = _( "Location and environment" );
    const std::string character = _( "Character" );
    const std::string needs = _( "Needs and load" );
    const std::string movement = _( "Movement and stamina" );
    const std::string activity = _( "Activity and fatigue" );
    const std::string combat = _( "Combat" );
    const std::string vehicle = _( "Vehicle" );
    const std::string body = _( "Body parts" );

    add_widget_source( result, "location.place", _( "Current location" ), location,
                       "i_place_text", 23, 460, 76 );
    add_widget_source( result, "location.coordinates", _( "Overmap coordinates" ), location,
                       "overmap_location_desc", 24, 420, 76 );
    add_widget_source( result, "environment.date", _( "Date" ), location,
                       "date_desc_no_label", 18, 260, 68 );
    add_widget_source( result, "environment.time", _( "Time" ), location,
                       "sundial_time_desc_no_label", 18, 260, 68 );
    add_widget_source( result, "environment.weather", _( "Weather" ), location,
                       "weather_desc_no_label", 18, 340, 68 );
    add_widget_source( result, "environment.wind", _( "Wind" ), location,
                       "wind_desc_no_label", 18, 340, 68 );
    add_widget_source( result, "environment.light", _( "Light" ), location,
                       "i_light_sym", 4, 180, 68 );
    add_widget_source( result, "environment.sound", _( "Sound" ), location,
                       "i_sound_graph", 5, 180, 68 );
    add_widget_source( result, "environment.temperature", _( "Temperature" ), location,
                       "env_temp_desc_no_label", 18, 300, 68 );

    add_widget_source( result, "character.strength", _( "Strength" ), character,
                       "i_str_num", 4, 160, 68 );
    add_widget_source( result, "character.dexterity", _( "Dexterity" ), character,
                       "i_dex_num", 4, 160, 68 );
    add_widget_source( result, "character.intelligence", _( "Intelligence" ), character,
                       "i_int_num", 4, 160, 68 );
    add_widget_source( result, "character.perception", _( "Perception" ), character,
                       "i_per_num", 4, 160, 68 );
    add_widget_source( result, "character.bionic_power", _( "Bionic power" ), character,
                       "i_bpower_graph", 5, 220, 68 );
    add_widget_source( result, "character.power_balance", _( "Power balance" ), character,
                       "i_bpower_balance_graph", 3, 220, 68 );
    add_widget_source( result, "character.oxygen", _( "Oxygen" ), character,
                       "oxygen_classic_layout", 18, 260, 68 );

    add_widget_source( result, "needs.hunger", _( "Hunger" ), needs,
                       "i_hunger_graph", 5, 190, 68 );
    add_widget_source( result, "needs.body_weight", _( "Body weight" ), needs,
                       "i_weight_sym", 4, 210, 68 );
    add_widget_source( result, "needs.thirst", _( "Thirst" ), needs,
                       "i_thrist_graph", 5, 190, 68 );
    add_widget_source( result, "needs.pain", _( "Pain" ), needs,
                       "pain_desc_no_label", 16, 240, 68 );
    add_widget_source( result, "needs.morale", _( "Morale" ), needs,
                       "i_mood_num", 5, 180, 68 );
    add_widget_source( result, "needs.focus", _( "Focus" ), needs,
                       "i_focus_num", 5, 180, 68 );
    add_widget_source( result, "needs.carry_weight", _( "Carried weight" ), needs,
                       "i_weight", 8, 260, 68 );

    add_widget_source( result, "movement.speed", _( "Speed" ), movement,
                       "i_speed_num", 4, 170, 68 );
    add_widget_source( result, "movement.mode", _( "Movement mode" ), movement,
                       "i_move_mode_text", 8, 220, 68 );
    add_widget_source( result, "movement.cost", _( "Move cost" ), movement,
                       "i_basemovecost_num", 5, 190, 68 );
    add_widget_source( result, "movement.moves", _( "Moves" ), movement,
                       "i_move_counter", 4, 170, 68 );
    add_widget_source( result, "movement.stamina", _( "Stamina" ), movement,
                       "i_stamina_graph", 11, 300, 68 );

    add_widget_source( result, "status.safe_mode", _( "Safe mode" ), activity,
                       "i_safe_mode_text", 8, 230, 68 );
    add_widget_source( result, "status.sleepiness", _( "Sleepiness" ), activity,
                       "i_rest_graph", 5, 190, 68 );
    add_widget_source( result, "status.activity", _( "Activity level" ), activity,
                       "i_activity_text", 14, 260, 68 );
    add_widget_source( result, "status.weariness", _( "Weariness" ), activity,
                       "i_weary_graph", 5, 220, 68 );
    add_widget_source( result, "status.weariness_progress", _( "Weariness progress" ), activity,
                       "i_wtrns_graph", 11, 300, 68 );
    add_widget_source( result, "status.weariness_malus", _( "Weariness penalty" ), activity,
                       "i_wmalus_text", 8, 270, 68 );

    add_widget_source( result, "combat.weapon", _( "Wielded item" ), combat,
                       "wielding_desc_no_label", 28, 460, 76 );
    add_widget_source( result, "combat.style", _( "Martial arts style" ), combat,
                       "style_desc_no_label", 18, 320, 76 );
    add_widget_source( result, "combat.compass", _( "Threat compass" ), combat,
                       "w_compass", 27, 460, 230, true );
    add_widget_source( result, "vehicle.summary", _( "Vehicle status" ), vehicle,
                       "vehicle_acf_no_label_layout", 18, 360, 140, true );

    struct body_source {
        const char *key;
        const char *title;
        const char *widget;
    };
    static const body_source body_sources[] = {
        { "head", "Head", "HD" }, { "torso", "Torso", "CT" },
        { "left_arm", "Left arm", "LA" }, { "right_arm", "Right arm", "RA" },
        { "left_leg", "Left leg", "LL" }, { "right_leg", "Right leg", "RL" }
    };
    for( const body_source &part : body_sources ) {
        const std::string base = std::string( "body." ) + part.key;
        const std::string title = _( part.title );
        add_widget_source( result, base + ".hp", string_format( _( "%s health" ), title ),
                           body, "i_bp_" + std::string( part.widget ) + "_hp_graph", 7, 230, 68 );
        add_widget_source( result, base + ".status", string_format( _( "%s status" ), title ),
                           body, "i_bp_" + std::string( part.widget ) + "_status_sym", 4, 230, 68 );
        add_widget_source( result, base + ".condition",
                           string_format( _( "%s overview" ), title ), body,
                           "w_bp_" + std::string( part.widget ) + "_status", 13, 280, 120, true );
        if( base == "body.head" || base == "body.torso" ) {
            add_widget_source( result, base + ".encumbrance",
                               string_format( _( "%s encumbrance" ), title ), body,
                               "i_bp_" + std::string( part.widget ) + "_enc_graph", 2, 230, 68 );
            add_widget_source( result, base + ".warmth",
                               string_format( _( "%s warmth" ), title ), body,
                               "i_bp_" + std::string( part.widget ) + "_warmth_graph", 2, 230, 68 );
            add_widget_source( result, base + ".wetness",
                               string_format( _( "%s wetness" ), title ), body,
                               "i_bp_" + std::string( part.widget ) + "_wet_graph", 2, 230, 68 );
        }
    }

    result.push_back( { "log.messages", _( "Message log" ), _( "Logs" ), "log", "", 0,
                        620, 250, true } );
    result.push_back( { "map.pixel", _( "Pixel minimap" ), _( "Maps and radar" ),
                        "pixel_minimap", "", 0, 400, 400, true } );
    result.push_back( { "map.overmap_grid", _( "7x7 overmap grid" ), _( "Maps and radar" ),
                        "overmap_grid", "", 0, 350, 350, true } );
    result.push_back( { "radar.threat_grid", _( "Local threat grid" ), _( "Maps and radar" ),
                        "threat_grid", "", 0, 350, 350, true } );

    const std::string advanced = _( "Advanced raw widgets" );
    for( const widget &raw : widget::get_all() ) {
        const std::string widget_id = raw.getId().str();
        if( !safe_source_id( widget_id ) ) {
            continue;
        }
        const std::string translated_label = raw._label.translated();
        const std::string title = translated_label.empty() ? widget_id : translated_label;
        const int width = std::clamp( raw._width > 0 ? raw._width * 18 : 360, 140, 1200 );
        const int height = std::clamp( raw._height > 0 ? raw._height * 42 : 90, 64, 800 );
        result.push_back( { "widget." + widget_id, title, advanced, "text", widget_id,
                            static_cast<unsigned int>( std::clamp( raw._width, 8, 80 ) ),
                            width, height, raw._height > 1 || raw._style == "layout" } );
    }
    return result;
}

const std::vector<hud_info_source> &current_source_catalog()
{
    const int language_revision = detail::get_current_language_version();
    if( source_catalog.empty() || source_catalog_language_revision != language_revision ) {
        source_catalog = make_source_catalog();
        source_catalog_language_revision = language_revision;
    }
    return source_catalog;
}

std::string render_widget_info( const avatar &player, const hud_info_source &source )
{
    const widget_id id( source.widget_id );
    if( !id.is_valid() ) {
        return {};
    }
    // widget::layout mutates transient range/height state.  Render a copy and
    // publish only immutable plain text to Android.
    widget rendered = id.obj();
    return remove_color_tags( rendered.layout( player, source.widget_width, 0, true ) );
}

void append_subscribed_values( hud_snapshot &next, const avatar &player,
                               const std::unordered_set<std::string> &subscriptions )
{
    for( const hud_info_source &source : next.sources ) {
        if( source.renderer != "text" || subscriptions.count( source.id ) == 0 ) {
            continue;
        }
        next.values.push_back( { source.id, render_widget_info( player, source ) } );
    }
}

void append_messages( hud_snapshot &next )
{
    for( const std::pair<std::string, std::string> &message :
         Messages::recent_messages_with_formatting( 8 ) ) {
        next.messages.push_back( parse_formatted_message( message.second ) );
    }
}

void append_overmap( hud_snapshot &next, const avatar &player )
{
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
}

void append_hostiles( hud_snapshot &next, const avatar &player )
{
    const tripoint_bub_ms player_pos = player.pos_bub();
    for( Creature *const creature : player.get_hostile_creatures( 60 ) ) {
        if( creature == nullptr || next.hostile_contacts.size() >= 64 ) {
            continue;
        }
        const tripoint_bub_ms creature_pos = creature->pos_bub();
        const int dx = creature_pos.x() - player_pos.x();
        const int dy = creature_pos.y() - player_pos.y();
        next.hostile_contacts.push_back( { creature->get_name(), dx, dy,
                                           std::max( std::abs( dx ), std::abs( dy ) ) } );
    }
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

void set_subscriptions( const std::vector<std::string> &sources )
{
    std::unordered_set<std::string> accepted;
    accepted.reserve( std::min<std::size_t>( sources.size(), 512 ) );
    for( const std::string &source : sources ) {
        if( accepted.size() >= 512 ) {
            break;
        }
        if( safe_source_id( source ) ) {
            accepted.insert( source );
        }
    }
    std::lock_guard<std::mutex> lock( hud_mutex );
    active_subscriptions = std::move( accepted );
    last_snapshot_refresh = {};
}

void publish_snapshot( const avatar &player, const int )
{
    const cata::input_context_actions::context_snapshot context =
        cata::input_context_actions::snapshot();
    const std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    std::unordered_set<std::string> subscriptions;
    bool context_changed = false;
    {
        std::lock_guard<std::mutex> lock( hud_mutex );
        subscriptions = active_subscriptions;
        context_changed = context.revision != latest_snapshot.context_revision ||
                          context.hud_scene_id != latest_snapshot.scene_id;
        if( !context_changed && last_snapshot_refresh.time_since_epoch().count() != 0 &&
            std::chrono::duration_cast<std::chrono::milliseconds>(
                now - last_snapshot_refresh ).count() < 100 ) {
            return;
        }
        last_snapshot_refresh = now;
    }

    hud_snapshot next;
    next.ready = true;
    next.context_revision = context.revision;
    next.input_category = context.category;
    next.scene_id = context.hud_scene_id.empty() ? context.category : context.hud_scene_id;
    next.scene_title = context.hud_scene_title.empty() ? next.scene_id : context.hud_scene_title;
    for( const cata::input_context_actions::action_descriptor &action : context.actions ) {
        next.actions.push_back( {
            action.id, action.label, action.group, action.repeatable, action.dangerous
        } );
    }
    next.sources = current_source_catalog();
    append_subscribed_values( next, player, subscriptions );
    if( subscriptions.count( "log.messages" ) > 0 ) {
        append_messages( next );
    }
    if( subscriptions.count( "map.overmap_grid" ) > 0 ) {
        append_overmap( next, player );
    }
    if( subscriptions.count( "radar.threat_grid" ) > 0 ) {
        append_hostiles( next, player );
    }

    std::lock_guard<std::mutex> lock( hud_mutex );
    next.revision = latest_snapshot.revision + 1;
    latest_snapshot = std::move( next );
}

void clear_snapshot()
{
    // A command queued immediately before leaving a world must never be
    // consumed by an equivalent input context in the next world.
    cata::input_context_actions::clear();
    std::lock_guard<std::mutex> lock( hud_mutex );
    hud_snapshot cleared;
    cleared.revision = latest_snapshot.revision + 1;
    cleared.sources = latest_snapshot.sources;
    latest_snapshot = std::move( cleared );
    latest_minimap_rect = {};
    last_snapshot_refresh = {};
}

std::string snapshot_json()
{
    // Blocking ImGui menus own their input context without running the normal
    // game-map draw loop.  Synchronize the lightweight scene/action metadata
    // here so Java can switch layouts while such a page is open; keep the last
    // published player information immutable until the game loop refreshes it.
    const cata::input_context_actions::context_snapshot context =
        cata::input_context_actions::snapshot();
    std::lock_guard<std::mutex> lock( hud_mutex );
    if( latest_snapshot.ready && !context.category.empty() &&
        ( context.revision != latest_snapshot.context_revision ||
          context.category != latest_snapshot.input_category ||
          context.hud_scene_id != latest_snapshot.scene_id ||
          context.hud_scene_title != latest_snapshot.scene_title ) ) {
        latest_snapshot.context_revision = context.revision;
        latest_snapshot.input_category = context.category;
        latest_snapshot.scene_id = context.hud_scene_id.empty() ?
                                   context.category : context.hud_scene_id;
        latest_snapshot.scene_title = context.hud_scene_title.empty() ?
                                      latest_snapshot.scene_id : context.hud_scene_title;
        latest_snapshot.actions.clear();
        for( const cata::input_context_actions::action_descriptor &action : context.actions ) {
            latest_snapshot.actions.push_back( {
                action.id, action.label, action.group, action.repeatable, action.dangerous
            } );
        }
        ++latest_snapshot.revision;
    }
    std::ostringstream out;
    JsonOut json( out );
    json.start_object();
    json.member( "schema", 3 );
    json.member( "revision", latest_snapshot.revision );
    json.member( "ready", latest_snapshot.ready );
    json.member( "contextRevision", latest_snapshot.context_revision );
    json.member( "inputCategory", latest_snapshot.input_category );
    json.member( "sceneId", latest_snapshot.scene_id );
    json.member( "sceneTitle", latest_snapshot.scene_title );

    json.member( "actions" );
    json.start_array();
    for( const hud_action &action : latest_snapshot.actions ) {
        json.start_object();
        json.member( "id", action.id );
        json.member( "label", action.label );
        json.member( "group", action.group );
        json.member( "repeatable", action.repeatable );
        json.member( "risk", action.dangerous ? "dangerous" : "safe" );
        json.end_object();
    }
    json.end_array();

    json.member( "infoSources" );
    json.start_array();
    for( const hud_info_source &source : latest_snapshot.sources ) {
        json.start_object();
        json.member( "id", source.id );
        json.member( "title", source.title );
        json.member( "category", source.category );
        json.member( "renderer", source.renderer );
        json.member( "defaultWidth", source.default_width );
        json.member( "defaultHeight", source.default_height );
        json.member( "multiline", source.multiline );
        json.end_object();
    }
    json.end_array();

    json.member( "values" );
    json.start_array();
    for( const hud_info_value &value : latest_snapshot.values ) {
        json.start_object();
        json.member( "sourceId", value.source_id );
        json.member( "text", value.text );
        json.end_object();
    }
    json.end_array();

    json.member( "messages" );
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

    json.member( "overmap" );
    json.start_array();
    for( const hud_overmap_cell &cell : latest_snapshot.overmap_cells ) {
        json.start_object();
        json.member( "symbol", cell.symbol );
        json.member( "color", cell.color );
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

void set_subscriptions( const std::vector<std::string> & )
{
}

void publish_snapshot( const avatar &, int )
{
}

void clear_snapshot()
{
}

std::string snapshot_json()
{
    return "{}";
}

#endif

} // namespace android_hud
