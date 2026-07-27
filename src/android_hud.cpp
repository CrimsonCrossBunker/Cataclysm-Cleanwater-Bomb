#include "android_hud.h"

#include <algorithm>
#include <cctype>
#include <chrono>
#include <cstdlib>
#include <limits>
#include <mutex>
#include <optional>
#include <sstream>
#include <stack>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include "android_ui_mode.h"

#if defined(__ANDROID__)
    #include "avatar.h"
    #include "catacharset.h"
    #include "color.h"
    #include "coordinates.h"
    #include "creature.h"
    #include "cursesport.h"
    #include "input_context_actions.h"
    #include "item_location.h"
    #include "json.h"
    #include "messages.h"
    #include "omdata.h"
    #include "output.h"
    #include "overmapbuffer.h"
    #include "sdltiles.h"
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
    int foreground = 0xffc0c0c0;
    int background = 0xff000000;
    bool bold = false;
    bool blink = false;
};

struct hud_rich_text {
    std::string text;
    std::vector<hud_text_run> runs;
};

struct hud_terminal_cell {
    int column = 0;
    int span = 1;
    std::string text;
    int foreground = 0xffc0c0c0;
    int background = 0xff000000;
    bool bold = false;
    bool blink = false;
};

struct hud_terminal_row {
    std::vector<hud_terminal_cell> cells;
};

struct hud_terminal_text {
    unsigned int columns = 0;
    int foreground = 0xffc0c0c0;
    int background = 0xff000000;
    bool bold = false;
    bool blink = false;
    std::vector<hud_terminal_row> rows;
};

struct hud_info_source {
    std::string id;
    std::string title;
    std::string category;
    std::string renderer;
    std::string catalog_tier = "single";
    std::string widget_id;
    unsigned int default_widget_columns = 24;
    int default_label_columns = -1;
    int default_width = 320;
    int default_height = 100;
    bool multiline = false;
    bool square = false;
    bool configurable_widget_layout = false;
    bool composite = false;
    bool default_enabled = true;
    bool context_ambiguous = false;
    int sidebar_order = -1;
    int group_order = -1;
    int occurrence = 0;
    std::string sidebar_id;
    std::string sidebar_title;
    std::string context_warning;
    std::string inherited_separator = ": ";
    int inherited_padding = 2;
};

struct hud_info_value {
    std::string request_key;
    std::string source_id;
    hud_terminal_text content;
};

struct hud_subscription {
    std::string request_key;
    std::string source_id;
    widget_hud_layout layout;
};

struct hud_snapshot {
    bool ready = false;
    int revision = 0;
    int catalog_revision = 0;
    int context_revision = 0;
    std::string input_category;
    std::string scene_id;
    std::string scene_title;
    std::vector<hud_action> actions;
    std::vector<hud_info_source> sources;
    std::vector<hud_info_value> values;
    std::vector<hud_contact> hostile_contacts;
    std::vector<hud_overmap_cell> overmap_cells;
    std::vector<hud_rich_text> messages;
};

std::mutex hud_mutex;
std::mutex source_catalog_mutex;
hud_snapshot latest_snapshot;
minimap_rect latest_minimap_rect;
std::vector<hud_subscription> active_subscriptions;
std::chrono::steady_clock::time_point last_snapshot_refresh;
std::vector<hud_info_source> source_catalog;
int source_catalog_language_revision = -1;
std::size_t source_catalog_widget_count = 0;
int source_catalog_revision = 0;

bool safe_source_id( const std::string &id )
{
    if( id.empty() || id.size() > 160 ) {
        return false;
    }
    return std::all_of( id.begin(), id.end(), []( const unsigned char c ) {
        return std::isalnum( c ) != 0 || c == '_' || c == '-' || c == '.' || c == ':';
    } );
}

int android_argb( const SDL_Color &color )
{
    return static_cast<int>( 0xff000000u |
                             static_cast<unsigned int>( color.r ) << 16 |
                             static_cast<unsigned int>( color.g ) << 8 |
                             static_cast<unsigned int>( color.b ) );
}

struct resolved_terminal_style {
    int foreground = 0xffc0c0c0;
    int background = 0xff000000;
    bool bold = false;
    bool blink = false;
};

resolved_terminal_style resolve_terminal_style( const nc_color &color )
{
    resolved_terminal_style result;
    const int pair_index = std::clamp<int>(
                               color.to_color_pair_index(), 0,
                               cata_cursesport::colorpairs.size() - 1 );
    const cata_cursesport::pairs &pair =
        cata_cursesport::colorpairs[pair_index];
    result.bold = color.is_bold();
    result.blink = color.is_blink();

    int foreground_index = static_cast<int>( pair.FG );
    int background_index = static_cast<int>( pair.BG );
    const int bright_offset = static_cast<int>( windowsPalette.size() / 2 );
    if( result.bold ) {
        foreground_index += bright_offset;
    }
    if( result.blink ) {
        background_index += bright_offset;
    }
    foreground_index = std::clamp<int>(
                           foreground_index, 0, windowsPalette.size() - 1 );
    background_index = std::clamp<int>(
                           background_index, 0, windowsPalette.size() - 1 );
    result.foreground = android_argb( windowsPalette[foreground_index] );
    result.background = android_argb( windowsPalette[background_index] );
    return result;
}

int android_argb( const nc_color &color )
{
    return resolve_terminal_style( color ).foreground;
}

bool same_style( const hud_text_run &lhs, const hud_text_run &rhs )
{
    return lhs.foreground == rhs.foreground &&
           lhs.background == rhs.background &&
           lhs.bold == rhs.bold &&
           lhs.blink == rhs.blink;
}

hud_rich_text parse_formatted_text( const std::string &formatted )
{
    hud_rich_text result;
    std::stack<nc_color> colors;
    colors.push( c_light_gray );
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
        const resolved_terminal_style style = resolve_terminal_style(
                colors.empty() ? c_light_gray : colors.top() );
        run.foreground = style.foreground;
        run.background = style.background;
        run.bold = style.bold;
        run.blink = style.blink;
        result.text += run.text;
        if( !result.runs.empty() &&
            same_style( result.runs.back(), run ) ) {
            result.runs.back().text += run.text;
        } else {
            result.runs.push_back( std::move( run ) );
        }
    }
    if( result.text.empty() ) {
        result.text = remove_color_tags( formatted );
        if( !result.text.empty() ) {
            hud_text_run run;
            run.text = result.text;
            const resolved_terminal_style style =
                resolve_terminal_style( c_light_gray );
            run.foreground = style.foreground;
            run.background = style.background;
            run.bold = style.bold;
            run.blink = style.blink;
            result.runs.push_back( std::move( run ) );
        }
    }
    return result;
}

hud_terminal_text parse_formatted_terminal( const std::string &formatted,
        const unsigned int columns )
{
    const hud_rich_text rich = parse_formatted_text( formatted );
    hud_terminal_text result;
    result.columns = columns;
    const resolved_terminal_style base =
        resolve_terminal_style( c_light_gray );
    result.foreground = base.foreground;
    result.background = base.background;
    result.bold = base.bold;
    result.blink = base.blink;
    result.rows.emplace_back();
    int column = 0;

    for( const hud_text_run &run : rich.runs ) {
        for( const uint32_t codepoint : utf8_to_utf32( run.text ) ) {
            if( codepoint == U'\n' ) {
                result.rows.emplace_back();
                column = 0;
                continue;
            }

            const std::string glyph = utf32_to_utf8( codepoint );
            const int width = std::max( 0, utf8_width( glyph, true ) );
            hud_terminal_row &row = result.rows.back();
            if( width == 0 ) {
                if( !row.cells.empty() ) {
                    row.cells.back().text += glyph;
                }
                continue;
            }
            if( columns > 0 && column >= static_cast<int>( columns ) ) {
                column += width;
                continue;
            }
            const int visible_width = columns == 0 ? width :
                                      std::min<int>(
                                          width, columns - column );
            if( visible_width <= 0 ) {
                column += width;
                continue;
            }

            // Consecutive printable ASCII in one style can be drawn as one
            // monospace segment.  CJK, symbols and combining sequences retain
            // their own explicit cell span so Android never has to implement
            // a second wcwidth table.
            // Spaces remain real cells because their background can carry
            // native terminal highlighting.
            const bool group_ascii = codepoint >= 0x20 && codepoint <= 0x7e;
            if( group_ascii && !row.cells.empty() ) {
                hud_terminal_cell &previous = row.cells.back();
                if( previous.column + previous.span == column &&
                    previous.foreground == run.foreground &&
                    previous.background == run.background &&
                    previous.bold == run.bold &&
                    previous.blink == run.blink &&
                    previous.text.size() ==
                    static_cast<std::size_t>( previous.span ) ) {
                    previous.text += glyph;
                    previous.span += visible_width;
                    column += width;
                    continue;
                }
            }

            row.cells.push_back( {
                column, visible_width, glyph, run.foreground, run.background,
                run.bold, run.blink
            } );
            column += width;
        }
    }
    if( columns == 0 ) {
        int natural_columns = 0;
        for( const hud_terminal_row &row : result.rows ) {
            for( const hud_terminal_cell &cell : row.cells ) {
                natural_columns = std::max(
                                      natural_columns,
                                      cell.column + cell.span );
            }
        }
        result.columns = static_cast<unsigned int>(
                             std::clamp( natural_columns, 8, 80 ) );
    }
    return result;
}

void write_rich_text_members( JsonOut &json, const hud_rich_text &value )
{
    json.member( "text", value.text );
    json.member( "runs" );
    json.start_array();
    for( const hud_text_run &run : value.runs ) {
        json.start_object();
        json.member( "text", run.text );
        json.member( "foreground", run.foreground );
        json.member( "background", run.background );
        json.member( "bold", run.bold );
        json.member( "blink", run.blink );
        json.end_object();
    }
    json.end_array();
}

void write_terminal_members( JsonOut &json, const hud_terminal_text &value )
{
    json.member( "terminal" );
    json.start_object();
    json.member( "columns", value.columns );
    json.member( "foreground", value.foreground );
    json.member( "background", value.background );
    json.member( "bold", value.bold );
    json.member( "blink", value.blink );
    json.member( "rows" );
    json.start_array();
    for( const hud_terminal_row &row : value.rows ) {
        json.start_object();
        json.member( "cells" );
        json.start_array();
        for( const hud_terminal_cell &cell : row.cells ) {
            json.start_object();
            json.member( "column", cell.column );
            json.member( "span", cell.span );
            json.member( "text", cell.text );
            json.member( "foreground", cell.foreground );
            json.member( "background", cell.background );
            json.member( "bold", cell.bold );
            json.member( "blink", cell.blink );
            json.end_object();
        }
        json.end_array();
        json.end_object();
    }
    json.end_array();
    json.end_object();
}

void add_widget_source( std::vector<hud_info_source> &result, const std::string &id,
                        const std::string &title, const std::string &category,
                        const std::string &widget_id, const unsigned int default_widget_columns,
                        const int default_width, const int default_height,
                        const bool multiline = false )
{
    hud_info_source source;
    source.id = id;
    source.title = title;
    source.category = category;
    source.renderer = "terminal_widget";
    source.catalog_tier = "advanced";
    source.widget_id = widget_id;
    source.default_widget_columns = default_widget_columns;
    source.default_width = default_width;
    source.default_height = default_height;
    source.multiline = multiline;
    result.push_back( std::move( source ) );
}

struct sidebar_context {
    std::string source_id;
    std::string sidebar_id;
    std::string sidebar_title;
    std::string widget_id;
    std::string separator;
    int padding = 2;
    int columns = 42;
    int sidebar_order = -1;
    int group_order = -1;
    int occurrence = 0;
    bool default_enabled = true;
};

std::string sidebar_group_source_id( const std::string &sidebar_id,
                                     const std::string &widget_id,
                                     const int occurrence )
{
    return "sidebar." + sidebar_id + ".group." + widget_id + "." +
           std::to_string( occurrence );
}

hud_info_source make_contextual_widget_source(
    const sidebar_context &context, const std::string &catalog_tier )
{
    const widget_id id( context.widget_id );
    const widget &raw = id.obj();
    const std::string translated_label = raw._label.translated();

    hud_info_source source;
    source.id = context.source_id;
    source.title = translated_label.empty() ?
                   context.widget_id : translated_label;
    source.category = context.sidebar_title;
    source.renderer = "terminal_widget";
    source.catalog_tier = catalog_tier;
    source.widget_id = context.widget_id;
    source.default_widget_columns = static_cast<unsigned int>(
                                        std::clamp( context.columns, 8, 80 ) );
    source.default_width = std::clamp(
                               std::max( 320, context.columns * 9 ), 140, 1200 );
    source.default_height = std::clamp(
                                raw._height > 0 ? raw._height * 32 : 90,
                                64, 800 );
    source.multiline = raw._height > 1 || raw._style == "layout";
    source.configurable_widget_layout = true;
    source.composite = raw._style == "layout";
    source.default_enabled = context.default_enabled;
    source.sidebar_order = context.sidebar_order;
    source.group_order = context.group_order;
    source.occurrence = context.occurrence;
    source.sidebar_id = context.sidebar_id;
    source.sidebar_title = context.sidebar_title;
    source.inherited_separator = context.separator;
    source.inherited_padding = context.padding;
    return source;
}

void add_special_source( std::vector<hud_info_source> &result,
                         const std::string &id, const std::string &title,
                         const std::string &category, const std::string &renderer,
                         const int default_width, const int default_height,
                         const bool multiline, const bool square )
{
    hud_info_source source;
    source.id = id;
    source.title = title;
    source.category = category;
    source.renderer = renderer;
    source.catalog_tier = "recommended";
    source.default_width = default_width;
    source.default_height = default_height;
    source.multiline = multiline;
    source.square = square;
    result.push_back( std::move( source ) );
}

std::vector<hud_info_source> make_source_catalog()
{
    std::vector<hud_info_source> result;
    result.reserve( widget::get_all().size() + 256 );

    // The common catalog is generated from the same loaded Widget factory as
    // the desktop sidebar manager.  This retains mod sidebars, duplicate rows,
    // separators and W_DISABLED_BY_DEFAULT entries without maintaining a
    // second hard-coded Android list.
    std::unordered_map<std::string, std::vector<sidebar_context>>
            direct_contexts;
    int sidebar_order = 0;
    for( const widget &sidebar : widget::get_all() ) {
        if( sidebar._style != "sidebar" ) {
            continue;
        }
        const std::string sidebar_id = sidebar.getId().str();
        if( !safe_source_id( sidebar_id ) ) {
            continue;
        }
        const std::string translated_sidebar = sidebar._label.translated();
        const std::string sidebar_title = translated_sidebar.empty() ?
                                          sidebar_id : translated_sidebar;
        std::unordered_map<std::string, int> occurrences;
        for( std::size_t group_order = 0;
             group_order < sidebar._widgets.size(); ++group_order ) {
            const widget_id &child_id = sidebar._widgets[group_order];
            if( !child_id.is_valid() ||
                !safe_source_id( child_id.str() ) ) {
                continue;
            }
            const int occurrence = occurrences[child_id.str()]++;
            sidebar_context context;
            context.sidebar_id = sidebar_id;
            context.sidebar_title = sidebar_title;
            context.widget_id = child_id.str();
            context.source_id = sidebar_group_source_id(
                                    sidebar_id, child_id.str(), occurrence );
            context.separator = sidebar._separator;
            context.padding = std::max( 0, sidebar._padding );
            context.columns = std::max( 8, sidebar._width - 2 );
            context.sidebar_order = sidebar_order;
            context.group_order = static_cast<int>( group_order );
            context.occurrence = occurrence;
            context.default_enabled =
                !child_id->has_flag( "W_DISABLED_BY_DEFAULT" );
            direct_contexts[context.widget_id].push_back( context );
            result.push_back( make_contextual_widget_source(
                                  context, "common" ) );
        }
        ++sidebar_order;
    }

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

    add_special_source( result, "log.messages", _( "Message log" ), _( "Logs" ),
                        "message_log", 620, 250, true, false );
    add_special_source( result, "map.pixel", _( "Pixel minimap" ), _( "Maps and radar" ),
                        "pixel_minimap", 400, 400, true, true );
    add_special_source( result, "map.overmap_grid", _( "7x7 overmap grid" ),
                        _( "Maps and radar" ), "overmap_grid", 350, 350, true, true );
    add_special_source( result, "radar.threat_grid", _( "Local threat grid" ),
                        _( "Maps and radar" ), "threat_grid", 350, 350, true, true );

    const std::string advanced = _( "Advanced raw widgets" );
    for( const widget &raw : widget::get_all() ) {
        const std::string widget_id = raw.getId().str();
        // A sidebar root is a panel-layout definition, not one renderable
        // information row.  Its direct children are already present above.
        if( raw._style == "sidebar" || !safe_source_id( widget_id ) ) {
            continue;
        }
        const std::string translated_label = raw._label.translated();
        const std::string title = translated_label.empty() ? widget_id : translated_label;
        const int width = std::clamp( raw._width > 0 ? raw._width * 18 : 360, 140, 1200 );
        const int height = std::clamp( raw._height > 0 ? raw._height * 42 : 90, 64, 800 );
        hud_info_source source;
        const auto contexts = direct_contexts.find( widget_id );
        if( contexts != direct_contexts.end() &&
            contexts->second.size() == 1 ) {
            source = make_contextual_widget_source(
                         contexts->second.front(), "advanced" );
        } else {
            source.renderer = "terminal_widget";
            source.catalog_tier = "advanced";
            source.widget_id = widget_id;
            source.default_widget_columns =
                static_cast<unsigned int>( std::clamp(
                                               raw._width > 0 ? raw._width : 42,
                                               8, 80 ) );
            source.inherited_separator = raw.explicit_separator ?
                                         raw._separator : ": ";
            source.inherited_padding = raw.explicit_padding ?
                                       std::max( 0, raw._padding ) : 2;
            source.multiline = raw._height > 1 ||
                               raw._style == "layout";
            source.configurable_widget_layout = true;
            source.composite = raw._style == "layout";
            if( contexts != direct_contexts.end() &&
                contexts->second.size() > 1 ) {
                source.context_ambiguous = true;
                source.context_warning = _(
                                             "This Widget belongs to several sidebar contexts; "
                                             "standalone defaults are used." );
            }
        }
        source.id = "widget." + widget_id;
        source.title = title;
        source.category = advanced;
        source.default_width = width;
        source.default_height = height;
        result.push_back( std::move( source ) );
    }
    return result;
}

std::vector<hud_info_source> current_source_catalog(
    int *const catalog_revision = nullptr )
{
    std::lock_guard<std::mutex> lock( source_catalog_mutex );
    const int language_revision = detail::get_current_language_version();
    const std::size_t widget_count = widget::get_all().size();
    if( source_catalog.empty() ||
        source_catalog_language_revision != language_revision ||
        source_catalog_widget_count != widget_count ) {
        source_catalog = make_source_catalog();
        source_catalog_language_revision = language_revision;
        source_catalog_widget_count = widget_count;
        source_catalog_revision =
            source_catalog_revision == std::numeric_limits<int>::max() ?
            1 : source_catalog_revision + 1;
    }
    if( catalog_revision != nullptr ) {
        *catalog_revision = source_catalog_revision;
    }
    return source_catalog;
}

hud_terminal_text render_widget_info( const avatar &player,
                                      const hud_info_source &source,
                                      const hud_subscription &subscription )
{
    const widget_id id( source.widget_id );
    if( !id.is_valid() ) {
        return {};
    }
    // widget::layout mutates transient range/height state.  Render a copy, then
    // project its color-tagged output into an immutable platform-neutral value.
    widget rendered = id.obj();
    widget_hud_layout layout = subscription.layout;
    layout.inherited_separator = source.inherited_separator;
    layout.inherited_padding = source.inherited_padding;
    if( layout.mode == widget_hud_layout_mode::original ||
        layout.columns == 0 ) {
        layout.columns = source.default_widget_columns;
    }
    std::string formatted;
    unsigned int terminal_columns = layout.columns;
    if( source.configurable_widget_layout ) {
        formatted = rendered.layout_for_hud( player, layout );
        if( layout.mode == widget_hud_layout_mode::loose ) {
            terminal_columns = 0;
        }
    } else {
        // Curated single-value sources keep their compact no-label
        // representation.  Composite and advanced sources keep the original
        // CCB label, separator and row/column structure.
        terminal_columns = source.default_widget_columns;
        formatted = rendered.layout( player, terminal_columns, 0,
                                     !source.configurable_widget_layout );
    }
    return parse_formatted_terminal( formatted, terminal_columns );
}

void append_subscribed_values( hud_snapshot &next, const avatar &player,
                               const std::vector<hud_subscription> &subscriptions )
{
    std::unordered_map<std::string, const hud_info_source *> sources_by_id;
    sources_by_id.reserve( next.sources.size() );
    for( const hud_info_source &source : next.sources ) {
        if( source.renderer == "terminal_widget" ) {
            sources_by_id.emplace( source.id, &source );
        }
    }
    std::unordered_set<std::string> rendered_keys;
    rendered_keys.reserve( subscriptions.size() );
    for( const hud_subscription &subscription : subscriptions ) {
        const auto found = sources_by_id.find( subscription.source_id );
        if( found == sources_by_id.end() ) {
            continue;
        }
        const hud_info_source &source = *found->second;
        if( !rendered_keys.insert(
                subscription.request_key ).second ) {
            continue;
        }
        next.values.push_back( {
            subscription.request_key, source.id,
            render_widget_info( player, source, subscription )
        } );
    }
}

bool has_subscription( const std::vector<hud_subscription> &subscriptions,
                       const std::string &source_id )
{
    return std::any_of( subscriptions.begin(), subscriptions.end(),
    [&source_id]( const hud_subscription & subscription ) {
        return subscription.source_id == source_id;
    } );
}

void append_messages( hud_snapshot &next )
{
    for( const std::pair<std::string, std::string> &message :
         Messages::recent_messages_with_formatting( 8 ) ) {
        next.messages.push_back( parse_formatted_text( message.second ) );
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

std::string layout_node_segment( const widget_id &id, const int occurrence )
{
    return id.str() + "@" + std::to_string( occurrence );
}

void write_layout_schema_node( JsonOut &json, const widget_id &id,
                               const std::string &path,
                               const std::string &inherited_separator,
                               const int inherited_padding,
                               const bool conditional, const int depth,
                               int &node_count,
                               std::unordered_set<std::string> &ancestors )
{
    if( !id.is_valid() || depth > 32 || node_count >= 4096 ) {
        return;
    }
    const widget &node = id.obj();
    const std::string separator = node.explicit_separator ?
                                  node._separator : inherited_separator;
    const int padding = node.explicit_padding ?
                        std::max( 0, node._padding ) :
                        std::max( 0, inherited_padding );
    ++node_count;

    json.start_object();
    json.member( "id", id.str() );
    json.member( "path", path );
    json.member( "label", node._label.translated() );
    json.member( "style", node._style );
    json.member( "arrangement", node._arrange );
    json.member( "originalWidthColumns", node._width );
    json.member( "originalLabelColumns", node._label_width );
    json.member( "originalGapColumns", padding );
    json.member( "separator", separator );
    json.member( "labelScope", node._pad_labels );
    json.member( "conditional", conditional );
    json.member( "conditionalBranches", !node._clauses.empty() );
    json.member( "noPadding", node.has_flag( "W_NO_PADDING" ) );
    json.member( "defaultEnabled",
                 !node.has_flag( "W_DISABLED_BY_DEFAULT" ) );

    json.member( "children" );
    json.start_array();
    if( ancestors.insert( id.str() ).second ) {
        std::unordered_map<std::string, int> occurrences;
        const std::vector<widget_id> children =
            node.all_layout_children();
        for( const widget_id &child : children ) {
            if( !child.is_valid() || node_count >= 4096 ) {
                continue;
            }
            const int occurrence = occurrences[child.str()]++;
            write_layout_schema_node(
                json, child,
                path + "/" + layout_node_segment( child, occurrence ),
                separator, padding, !node._clauses.empty(), depth + 1,
                node_count, ancestors );
        }
        ancestors.erase( id.str() );
    }
    json.end_array();
    json.end_object();
}

} // namespace

void set_minimap_rect( const minimap_rect &rect )
{
    if( !android_ui_mode::is_new_ui_build() ) {
        return;
    }
    std::lock_guard<std::mutex> lock( hud_mutex );
    latest_minimap_rect = rect;
}

minimap_rect get_minimap_rect()
{
    if( !android_ui_mode::is_new_ui_build() ) {
        return {};
    }
    std::lock_guard<std::mutex> lock( hud_mutex );
    return latest_minimap_rect;
}

std::string layout_schema_json( const std::string &source_id )
{
    if( !android_ui_mode::is_new_ui_build() ) {
        return "{}";
    }
    std::optional<hud_info_source> selected;
    for( const hud_info_source &source : current_source_catalog() ) {
        if( source.id == source_id ) {
            selected = source;
            break;
        }
    }

    std::ostringstream out;
    JsonOut json( out );
    json.start_object();
    json.member( "schema", 1 );
    json.member( "sourceId", source_id );
    if( !selected.has_value() ||
        selected->renderer != "terminal_widget" ||
        !widget_id( selected->widget_id ).is_valid() ) {
        json.member( "available", false );
        json.end_object();
        return out.str();
    }

    json.member( "available", true );
    json.member( "defaultColumns", selected->default_widget_columns );
    json.member( "separator", selected->inherited_separator );
    json.member( "padding", selected->inherited_padding );
    json.member( "contextAmbiguous", selected->context_ambiguous );
    if( !selected->context_warning.empty() ) {
        json.member( "warning", selected->context_warning );
    }
    int node_count = 0;
    std::unordered_set<std::string> ancestors;
    const widget_id root( selected->widget_id );
    json.member( "root" );
    write_layout_schema_node(
        json, root, layout_node_segment( root, 0 ),
        selected->inherited_separator, selected->inherited_padding,
        false, 0, node_count, ancestors );
    json.member( "nodeCount", node_count );
    json.end_object();
    return out.str();
}

static bool safe_request_key( const std::string &key )
{
    return key.size() == 64 &&
    std::all_of( key.begin(), key.end(), []( const unsigned char c ) {
        return std::isxdigit( c ) != 0;
    } );
}

static bool safe_node_path( const std::string &path )
{
    if( path.empty() || path.size() > 2048 ) {
        return false;
    }
    return std::all_of( path.begin(), path.end(), []( const unsigned char c ) {
        return std::isalnum( c ) != 0 || c == '_' || c == '-' ||
               c == '.' || c == ':' || c == '@' || c == '/';
    } );
}

void set_subscriptions( const std::string &requests_json )
{
    if( !android_ui_mode::is_new_ui_build() ) {
        return;
    }
    std::vector<hud_subscription> accepted;
    std::unordered_set<std::string> seen;
    if( requests_json.size() <= 1024 * 1024 ) {
        try {
            std::istringstream input( requests_json );
            TextJsonIn json( input );
            TextJsonObject root = json.get_object();
            if( root.get_int( "schema", 0 ) == 2 ) {
                for( const TextJsonValue entry : root.get_array( "requests" ) ) {
                    if( accepted.size() >= 512 || !entry.test_object() ) {
                        break;
                    }
                    const TextJsonObject request = entry.get_object();
                    const std::string request_key =
                        request.get_string( "key", "" );
                    const std::string source_id =
                        request.get_string( "sourceId", "" );
                    if( !safe_request_key( request_key ) ||
                        !safe_source_id( source_id ) ||
                        !seen.insert( request_key ).second ) {
                        continue;
                    }

                    hud_subscription subscription;
                    subscription.request_key = request_key;
                    subscription.source_id = source_id;
                    const std::string mode =
                        request.get_string( "layoutMode", "original" );
                    if( mode == "custom" ) {
                        subscription.layout.mode =
                            widget_hud_layout_mode::custom;
                    } else if( mode == "loose" ) {
                        subscription.layout.mode =
                            widget_hud_layout_mode::loose;
                    } else {
                        subscription.layout.mode =
                            widget_hud_layout_mode::original;
                    }
                    if( request.has_int( "columns" ) ) {
                        subscription.layout.columns =
                            static_cast<unsigned int>( std::clamp(
                                                           request.get_int( "columns" ), 8, 80 ) );
                    }

                    int override_count = 0;
                    for( const TextJsonValue override_entry :
                         request.get_array( "nodeOverrides" ) ) {
                        if( override_count >= 256 ||
                            !override_entry.test_object() ) {
                            break;
                        }
                        const TextJsonObject encoded_override =
                            override_entry.get_object();
                        const std::string path =
                            encoded_override.get_string( "path", "" );
                        if( !safe_node_path( path ) ) {
                            continue;
                        }
                        widget_hud_node_override node;
                        if( encoded_override.has_int( "widthColumns" ) ) {
                            node.width_columns = std::clamp(
                                                     encoded_override.get_int(
                                                         "widthColumns" ), 1, 80 );
                        }
                        if( encoded_override.has_int( "labelColumns" ) ) {
                            node.label_columns = std::clamp(
                                                     encoded_override.get_int(
                                                         "labelColumns" ), 0, 40 );
                        }
                        if( encoded_override.has_int( "gapColumns" ) ) {
                            node.gap_columns = std::clamp(
                                                   encoded_override.get_int(
                                                       "gapColumns" ), 0, 8 );
                        }
                        if( encoded_override.has_string( "separator" ) ) {
                            const std::string separator =
                                encoded_override.get_string( "separator" );
                            if( separator.size() <= 32 &&
                                separator.find_first_of( "\r\n" ) ==
                                std::string::npos ) {
                                node.separator = separator;
                            }
                        }
                        subscription.layout.node_overrides.emplace(
                            path, std::move( node ) );
                        ++override_count;
                    }
                    accepted.push_back( std::move( subscription ) );
                }
            }
        } catch( const std::exception & ) {
            accepted.clear();
        }
    }
    std::lock_guard<std::mutex> lock( hud_mutex );
    active_subscriptions = std::move( accepted );
    last_snapshot_refresh = {};
}

void publish_snapshot( const avatar &player, const int )
{
    if( !android_ui_mode::is_new_ui_build() ) {
        return;
    }
    const cata::input_context_actions::context_snapshot context =
        cata::input_context_actions::snapshot();
    const std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    std::vector<hud_subscription> subscriptions;
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
    next.sources = current_source_catalog( &next.catalog_revision );
    append_subscribed_values( next, player, subscriptions );
    if( has_subscription( subscriptions, "log.messages" ) ) {
        append_messages( next );
    }
    if( has_subscription( subscriptions, "map.overmap_grid" ) ) {
        append_overmap( next, player );
    }
    if( has_subscription( subscriptions, "radar.threat_grid" ) ) {
        append_hostiles( next, player );
    }

    std::lock_guard<std::mutex> lock( hud_mutex );
    next.revision = latest_snapshot.revision + 1;
    latest_snapshot = std::move( next );
}

void clear_snapshot()
{
    if( !android_ui_mode::is_new_ui_build() ) {
        return;
    }
    // A command queued immediately before leaving a world must never be
    // consumed by an equivalent input context in the next world.
    cata::input_context_actions::clear();
    std::lock_guard<std::mutex> lock( hud_mutex );
    hud_snapshot cleared;
    cleared.revision = latest_snapshot.revision + 1;
    cleared.catalog_revision = latest_snapshot.catalog_revision;
    cleared.sources = latest_snapshot.sources;
    latest_snapshot = std::move( cleared );
    latest_minimap_rect = {};
    last_snapshot_refresh = {};
}

std::string snapshot_json( const int known_catalog_revision )
{
    if( !android_ui_mode::is_new_ui_build() ) {
        return "{}";
    }
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
    json.member( "schema", 5 );
    json.member( "revision", latest_snapshot.revision );
    json.member( "catalogRevision", latest_snapshot.catalog_revision );
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

    if( known_catalog_revision != latest_snapshot.catalog_revision ) {
        json.member( "infoSources" );
        json.start_array();
        for( const hud_info_source &source : latest_snapshot.sources ) {
            json.start_object();
            json.member( "id", source.id );
            json.member( "title", source.title );
            json.member( "category", source.category );
            json.member( "renderer", source.renderer );
            json.member( "catalogTier", source.catalog_tier );
            json.member( "defaultEnabled", source.default_enabled );
            json.member( "defaultWidth", source.default_width );
            json.member( "defaultHeight", source.default_height );
            json.member( "multiline", source.multiline );
            json.member( "square", source.square );
            if( source.configurable_widget_layout ) {
                json.member( "terminalConfigurable", true );
                json.member( "defaultColumns", source.default_widget_columns );
                if( source.default_label_columns >= 0 ) {
                    json.member( "defaultLabelColumns",
                                 source.default_label_columns );
                }
            }
            if( source.composite ) {
                json.member( "composite", true );
            }
            if( !source.sidebar_id.empty() ) {
                json.member( "sidebarId", source.sidebar_id );
                json.member( "sidebarTitle", source.sidebar_title );
                json.member( "sidebarOrder", source.sidebar_order );
                json.member( "groupOrder", source.group_order );
                json.member( "occurrence", source.occurrence );
            }
            if( source.context_ambiguous ) {
                json.member( "contextAmbiguous", true );
                json.member( "contextWarning", source.context_warning );
            }
            json.end_object();
        }
        json.end_array();
    }

    json.member( "values" );
    json.start_array();
    for( const hud_info_value &value : latest_snapshot.values ) {
        json.start_object();
        json.member( "requestKey", value.request_key );
        json.member( "sourceId", value.source_id );
        write_terminal_members( json, value.content );
        json.end_object();
    }
    json.end_array();

    json.member( "messages" );
    json.start_array();
    for( const hud_rich_text &message : latest_snapshot.messages ) {
        json.start_object();
        write_rich_text_members( json, message );
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

void set_subscriptions( const std::string & )
{
}

void publish_snapshot( const avatar &, int )
{
}

void clear_snapshot()
{
}

std::string snapshot_json( const int )
{
    return "{}";
}

std::string layout_schema_json( const std::string & )
{
    return "{}";
}

#endif

} // namespace android_hud
