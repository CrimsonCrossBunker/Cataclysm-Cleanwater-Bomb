#include "gunmod_ui.h"

#include <algorithm>
#include <cmath>
#include <functional>
#include <initializer_list>
#include <iterator>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <utility>
#include <vector>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "calendar.h"
#include "catacharset.h"
#include "character.h"
#include "clone_ptr.h"
#include "color.h"
#include "cursesdef.h"
#include "damage.h"
#include "game.h"
#include "game_inventory.h"
#include "gun_mode.h"
#include "input_context.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_search.h"
#include "itype.h"
#include "localized_comparator.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "mp_world_session.h"
#include "options.h"
#include "output.h"
#include "player_activity.h"
#include "pocket_type.h"
#include "point.h"
#include "ret_val.h"
#include "skill.h"
#include "string_formatter.h"
#include "string_input_popup.h"
#include "translations.h"
#include "type_id.h"
#include "ui_manager.h"
#include "units.h"
#include "units_utility.h"
#include "value_ptr.h"

static const gun_mode_id gun_mode_DEFAULT( "DEFAULT" );
static const itype_id itype_large_repairkit( "large_repairkit" );
static const itype_id itype_small_repairkit( "small_repairkit" );
static const trait_id trait_DEBUG_HS( "DEBUG_HS" );

namespace gunmod_ui
{

menu_layout layout_for_terminal( int width, int height )
{
    const int content_width = std::max( 1, width - 2 );
    const int minimum_pane = std::max( 28, utf8_width( _( "Available modifications" ) ) + 6 );
    const bool single = content_width < minimum_pane * 2;
    const int detail_height = height >= 24 ? std::clamp( height / 3, 7, 12 ) :
                              ( height >= 12 ? 4 : 1 );
    return { width, height, single ? content_width : content_width / 2,
             std::max( 1, height - detail_height - 4 ), detail_height, single };
}

item preview_change( const item &gun, const item &mod, bool installing )
{
    item preview( gun );
    if( installing ) {
        preview.put_in( mod, pocket_type::MOD );
    } else if( item *installed = preview.gunmod_find( mod.typeId() ) ) {
        preview.gun_set_mode( gun_mode_DEFAULT );
        preview.remove_item( *installed );
    }
    preview.on_contents_changed();
    return preview;
}

std::vector<slot_preview> preview_slots( const item &gun, const item &preview )
{
    const auto current = gun.get_mod_locations();
    const auto proposed = preview.get_mod_locations();
    const auto current_mods = gun.gunmods();
    const auto proposed_mods = preview.gunmods();
    std::set<gunmod_location> locations;
    for( const auto &entry : current ) {
        locations.insert( entry.first );
    }
    for( const auto &entry : proposed ) {
        locations.insert( entry.first );
    }
    std::vector<slot_preview> result;
    for( const gunmod_location &location : locations ) {
        const auto before = current.find( location );
        const auto after = proposed.find( location );
        const int capacity = before == current.end() ? 0 : before->second;
        const int preview_capacity = after == proposed.end() ? 0 : after->second;
        const auto uses_slot = [&location]( const item * mod ) {
            return mod->type->gunmod->location == location;
        };
        result.push_back( { location, capacity,
                            static_cast<int>( std::count_if( current_mods.begin(), current_mods.end(), uses_slot ) ),
                            preview_capacity,
                            static_cast<int>( std::count_if( proposed_mods.begin(), proposed_mods.end(), uses_slot ) ) } );
    }
    return result;
}

std::string removal_denial( const item &gun, const item &mod )
{
    if( mod.is_irremovable() ) {
        return _( "This modification cannot be removed." );
    }
    const std::string &location = mod.type->gunmod->location.str();
    if( ( location == "magazine" || location == "mechanism" ||
          location == "loading port" || location == "bore" ) &&
        ( gun.ammo_remaining() > 0 || gun.magazine_current() ) ) {
        return _( "Unload the gun and remove its magazine first." );
    }
    for( const auto &added : mod.type->gunmod->add_mod ) {
        const int freed = mod.type->gunmod->location == added.first ? 1 : 0;
        if( added.second > 0 && gun.get_free_mod_locations( added.first ) + freed < added.second ) {
            return string_format( _( "Remove modifications using the %s slots first." ),
                                  added.first.name() );
        }
    }
    return {};
}

std::string installation_denial( const Character &who, const item_location &gun,
                                 const item &mod )
{
    const auto compatible = gun->is_gunmod_compatible( mod );
    if( !compatible.success() ) {
        return compatible.str();
    }
    if( !who.has_trait( trait_DEBUG_HS ) && !who.meets_requirements( mod, *gun ) ) {
        return string_format( _( "Requires at least %s." ),
                              who.enumerate_unmet_requirements( mod, *gun ) );
    }
    if( !who.is_wielding( *gun ) ) {
        const auto wieldable = who.can_wield( *gun );
        if( !wieldable.success() ) {
            return wieldable.str();
        }
    }
    if( who.gunmod_installation_odds( gun, mod ).first <= 0 ) {
        return _( "This modification is too difficult for you to install." );
    }
    return {};
}

std::string installation_option::name() const
{
    return tool.is_null() ? _( "Without tools" ) : tool->nname( 1 );
}

std::vector<installation_option> installation_options( const Character &who,
        const item_location &gun, const item &mod )
{
    const auto odds = who.gunmod_installation_odds( gun, mod );
    std::vector<installation_option> result = {
        { itype_id::NULL_ID(), 0, odds.first, odds.second, true }
    };
    if( odds.first < 100 ) {
        result.push_back( { itype_small_repairkit, 100, std::min( odds.first * 2, 100 ),
                            odds.second / 2, who.has_charges( itype_small_repairkit, 100 ) } );
        result.push_back( { itype_large_repairkit, 25, std::min( odds.first * 3, 100 ),
                            0, who.has_charges( itype_large_repairkit, 25 ) } );
    }
    return result;
}

namespace
{

struct cursor {
    int selected = 0;
    int offset = 0;

    void normalize( int count, int height ) {
        selected = std::clamp( selected, 0, std::max( 0, count - 1 ) );
        offset = std::clamp( offset, std::max( 0, selected - height + 1 ), selected );
        offset = std::min( offset, std::max( 0, count - height ) );
    }
};

struct menu_state {
    std::string filter;
    std::optional<gunmod_location> slot_filter;
    int availability_filter = 0;
    int tool = 0;
    bool right_active = false;
    bool all_stats = false;
    int detail_offset = 0;
    cursor left;
    cursor right;
};

menu_state saved_state;
item_location saved_gun;

struct row {
    std::string text;
    item_location mod;
    gunmod_location location;
    nc_color color = c_light_gray;
    std::string status;
};

struct windows {
    menu_layout layout;
    catacurses::window root;
    catacurses::window left;
    catacurses::window right;
    catacurses::window detail;

    void resize( ui_adaptor &adaptor ) {
        layout = layout_for_terminal( TERMX, TERMY );
        root = catacurses::newwin( TERMY, TERMX, point::zero );
        if( TERMX < 20 || TERMY < 8 ) {
            adaptor.position_from_window( root );
            return;
        }
        const int content_width = std::max( 1, TERMX - 2 );
        left = catacurses::newwin( layout.body_height, layout.left_width, point( 1, 2 ) );
        const int right_width = layout.single_pane ? content_width : content_width - layout.left_width;
        right = catacurses::newwin( layout.body_height, right_width,
                                    point( layout.single_pane ? 1 : 1 + layout.left_width, 2 ) );
        detail = catacurses::newwin( layout.detail_height, content_width,
                                     point( 1, 2 + layout.body_height ) );
        adaptor.position_from_window( root );
    }
};

void draw_rows( const catacurses::window &window, const std::string &title,
                const std::vector<row> &rows, cursor &position, bool active )
{
    werase( window );
    const int width = getmaxx( window );
    const int height = std::max( 1, getmaxy( window ) - 2 );
    if( width > 4 && getmaxy( window ) > 2 ) {
        draw_border( window, active ? c_light_green : c_dark_gray );
        trim_and_print( window, point( 2, 0 ), width - 4, active ? c_yellow : c_light_gray, title );
    }
    position.normalize( static_cast<int>( rows.size() ), height );
    if( rows.empty() ) {
        trim_and_print( window, point::south_east, std::max( 1, width - 2 ), c_dark_gray,
                        _( "No matching modifications." ) );
    }
    for( int index = position.offset; index < static_cast<int>( rows.size() ) &&
         index < position.offset + height; ++index ) {
        const bool selected = index == position.selected;
        const nc_color color = selected && active ? h_white : rows[index].color;
        const int status_width = rows[index].status.empty() ? 0 :
                                 std::min( utf8_width( rows[index].status ) + 1, width / 3 );
        trim_and_print( window, point( 1, 1 + index - position.offset ),
                        std::max( 1, width - status_width - 2 ),
                        color, std::string( selected ? "> " : "  " ) + rows[index].text );
        if( status_width > 0 ) {
            trim_and_print( window, point( width - status_width - 1, 1 + index - position.offset ),
                            status_width, color, rows[index].status );
        }
    }
    if( width > 2 && getmaxy( window ) > 2 ) {
        scrollbar().offset_x( width - 1 ).offset_y( 1 ).content_size( rows.size() )
        .viewport_pos( position.offset ).viewport_size( height ).apply( window );
    }
    wnoutrefresh( window );
}

std::vector<row> available_rows( Character &who, const item_location &gun, const menu_state &state )
{
    std::vector<row> rows;
    const auto matches = item_filter_from_string( state.filter );
    for( const item_location &location : who.all_items_loc() ) {
        if( !location->is_gunmod() ||
            ( location.has_parent() && location.parent_pocket()->is_type( pocket_type::MOD ) ) ||
            !matches( *location ) ) {
            continue;
        }
        if( state.slot_filter && !( location->type->gunmod->location == *state.slot_filter ) ) {
            continue;
        }
        const bool compatible = gun->is_gunmod_compatible( *location ).success();
        const std::string denial = installation_denial( who, gun, *location );
        if( ( state.availability_filter == 1 && !denial.empty() ) ||
            ( state.availability_filter == 2 && denial.empty() ) ) {
            continue;
        }
        const std::string status = denial.empty() ? _( "ready" ) :
                                   ( compatible ? _( "requirements" ) : _( "incompatible" ) );
        rows.push_back( { location->tname(),
                          location, location->type->gunmod->location,
                          denial.empty() ? c_light_green : c_light_gray, status } );
    }
    std::stable_sort( rows.begin(), rows.end(), []( const row & first, const row & second ) {
        return localized_compare( first.mod->tname(), second.mod->tname() );
    } );
    return rows;
}

std::vector<row> slot_rows( item_location gun, const item &preview,
                            const item *selected, bool installing )
{
    std::vector<row> rows;
    for( const slot_preview &slot : preview_slots( *gun, preview ) ) {
        const bool changed = slot.capacity != slot.preview_capacity || slot.used != slot.preview_used;
        std::string title = string_format( _( "%1$s: %2$d/%3$d used" ), slot.location.name(),
                                           slot.used, slot.capacity );
        if( changed ) {
            title += string_format( _( " -> %1$d/%2$d" ), slot.preview_used, slot.preview_capacity );
        }
        rows.push_back( { title, item_location::nowhere, slot.location,
                          slot.preview_used > slot.preview_capacity ? c_light_red :
                          ( changed ? c_light_blue : c_white ), {} } );
        for( const item *mod : gun->gunmods() ) {
            const auto supplied = mod->type->gunmod->add_mod.find( slot.location );
            if( supplied != mod->type->gunmod->add_mod.end() && supplied->second > 0 ) {
                rows.push_back( { string_format( _( "    Capacity from %1$s: +%2$d" ),
                                                 mod->tname(), supplied->second ), item_location::nowhere,
                                  slot.location, c_dark_gray, {} } );
            }
        }
        for( item *mod : gun->gunmods() ) {
            if( !( mod->type->gunmod->location == slot.location ) ) {
                continue;
            }
            const bool removing = !installing && selected == mod;
            rows.push_back( { std::string( removing ? "  - " : "    " ) + mod->tname() +
                              ( mod->is_irremovable() ? _( " [permanent]" ) : "" ),
                              item_location( gun, mod ), slot.location, removing ? c_light_red : c_light_gray, {} } );
        }
        if( selected && installing && selected->type->gunmod->location == slot.location ) {
            rows.push_back( { string_format( _( "  + %s [preview]" ), selected->tname() ),
                              item_location::nowhere, slot.location, c_light_green, {} } );
        }
        if( slot.preview_capacity > slot.capacity ) {
            rows.push_back( { string_format( _( "  + %1$d slots from %2$s" ),
                                             slot.preview_capacity - slot.capacity, selected ? selected->tname() : "" ),
                              item_location::nowhere, slot.location, c_light_blue, {} } );
        }
        const int free = slot.preview_capacity - slot.preview_used;
        if( free > 0 ) {
            rows.push_back( { string_format( _( "    Empty: %d" ), free ), item_location::nowhere,
                              slot.location, c_dark_gray, {} } );
        }
    }
    return rows;
}

std::vector<std::string> statistics( const Character &who, const item &gun,
                                     const item &preview, bool all )
{
    std::vector<std::string> lines;
    const auto add = [&]( const std::string & name, double before, double after,
    const std::string & unit ) {
        if( all || std::abs( before - after ) > 0.0001 ) {
            lines.push_back( string_format( _( "%1$s: %2$.2f -> %3$.2f (%4$+.2f)%5$s" ),
                                            name, before, after, after - before, unit ) );
        }
    };
    add( _( "Weight" ), convert_weight( gun.weight() ),
         convert_weight( preview.weight() ), std::string( " " ) + weight_units() );
    add( _( "Volume" ), convert_volume( units::to_milliliter( gun.volume() ) ),
         convert_volume( units::to_milliliter( preview.volume() ) ),
         std::string( " " ) + volume_units_abbr() );
    add( _( "Length" ), convert_length_cm_in( gun.length() ),
         convert_length_cm_in( preview.length() ),
         get_option<std::string>( "DISTANCE_UNITS" ) == "metric" ? _( " cm" ) : _( " in." ) );
    add( _( "Dispersion (without ammunition)" ), gun.gun_dispersion( false ) / 100.0,
         preview.gun_dispersion( false ) / 100.0, _( " MOA" ) );
    add( _( "Sight dispersion" ), gun.sight_dispersion( who ).second / 100.0,
         preview.sight_dispersion( who ).second / 100.0, _( " MOA" ) );
    add( _( "Firing noise" ), gun.gun_noise().volume, preview.gun_noise().volume, "" );
    add( _( "Range (without ammunition)" ), gun.gun_range( false ), preview.gun_range( false ), "" );
    if( gun.ammo_current() == preview.ammo_current() && gun.ammo_remaining() > 0 &&
        gun.ammo_types() == preview.ammo_types() ) {
        add( _( "Damage (loaded ammunition)" ), gun.gun_damage().total_damage(),
             preview.gun_damage().total_damage(), "" );
        add( _( "Recoil (unsupported)" ), gun.gun_recoil( who ) / 100.0,
             preview.gun_recoil( who ) / 100.0, _( " MOA" ) );
    } else {
        lines.emplace_back( _( "Loaded damage and recoil require matching ammunition." ) );
    }
    if( gun.ammo_types() != preview.ammo_types() ) {
        lines.emplace_back( _( "Ammunition compatibility changes; check ammunition before firing." ) );
    }
    const auto current_modes = gun.gun_all_modes();
    const auto proposed_modes = preview.gun_all_modes();
    for( const auto &mode : proposed_modes ) {
        if( !current_modes.count( mode.first ) ) {
            lines.push_back( string_format( _( "New firing mode: %s" ), mode.second.tname() ) );
        }
    }
    for( const auto &mode : current_modes ) {
        if( !proposed_modes.count( mode.first ) ) {
            lines.push_back( string_format( _( "Removed firing mode: %s" ), mode.second.tname() ) );
        }
    }
    if( lines.empty() ) {
        lines.emplace_back( _( "No changes to the displayed statistics." ) );
    }
    return lines;
}

std::vector<std::string> requirements( const Character &who, const item_location &gun,
                                       const item_location &mod, bool installing,
                                       const std::string &denial, const menu_state &state )
{
    if( !mod ) {
        return { _( "Select a modification to preview installation or removal." ),
                 _( "Confirm a slot to filter available modifications." ) };
    }
    std::vector<std::string> lines;
    const time_duration duration = who.has_trait( trait_DEBUG_HS ) ? 0_seconds :
                                   mod->type->gunmod->install_time / ( installing ? 1 : 2 );
    lines.push_back( string_format( installing ? _( "Install: %1$s; time: %2$s" ) :
                                    _( "Remove: %1$s; time: %2$s" ), mod->tname(), to_string( duration ) ) );
    lines.push_back( denial.empty() ? _( "Requirements met." ) :
                     string_format( _( "Cannot proceed: %s" ), denial ) );
    if( installing ) {
        const auto options = installation_options( who, gun, *mod );
        const installation_option &option = options[std::min( state.tool,
                                                      static_cast<int>( options.size() ) - 1 )];
        lines.push_back( string_format( _( "Tool: %1$s; charges: %2$d [%3$s]" ), option.name(),
                                        option.charges, option.available ? _( "available" ) : _( "unavailable" ) ) );
        lines.push_back( string_format( _( "Success: %1$d%%; damage on failure: %2$d%%" ),
                                        option.success, option.damage ) );
        if( who.has_trait( trait_DEBUG_HS ) || who.meets_requirements( *mod, *gun ) ) {
            lines.emplace_back( _( "Character requirements: met." ) );
        } else {
            lines.push_back( string_format( _( "Missing requirements: %s" ),
                                            who.enumerate_unmet_requirements( *mod, *gun ) ) );
        }
        for( const auto &required : mod->type->min_skills ) {
            const skill_id skill = required.first.str() == "weapon" ? gun->gun_skill() : required.first;
            lines.push_back( string_format( _( "%1$s: %2$.1f / %3$d required" ), skill->name(),
                                            who.get_greater_skill_or_knowledge_level( skill ), required.second ) );
        }
        lines.push_back( string_format( _( "Source: %s" ), mod.describe( &who ) ) );
        if( !who.is_wielding( *gun ) ) {
            lines.emplace_back( _( "The gun must be wielded; handling time is additional." ) );
        }
        if( mod->is_irremovable() ) {
            lines.emplace_back( _( "Warning: this installation is permanent." ) );
        }
    }
    return lines;
}

std::vector<std::string> folded_lines( const std::vector<std::string> &lines, int width )
{
    std::vector<std::string> folded;
    for( const std::string &line : lines ) {
        const auto parts = foldstring( line, std::max( 1, width ) );
        folded.insert( folded.end(), parts.begin(), parts.end() );
    }
    return folded;
}

} // namespace

void show( Character &who, item_location gun, bool resume )
{
    if( !who.is_avatar() || !gun || !gun->is_gun() || gun->is_gunmod() ) {
        return;
    }
    // Local management must not overlap an authoritative client action.
    if( cata_mp::is_client_mode() &&
        ( cata_mp::is_client_waiting_for_ack() || who.get_moves() <= 0 ||
          g->multiplayer_session().client_inventory_activity.active ) ) {
        return;
    }
    menu_state state = resume && saved_gun == gun ? saved_state : menu_state();
    windows display;
    input_context context( "GUNMOD_MANAGER" );
    for( const char *action : {
             "UP", "DOWN", "LEFT", "RIGHT", "NEXT_TAB", "PREV_TAB",
             "PAGE_UP", "PAGE_DOWN", "CONFIRM", "QUIT", "FILTER", "RESET_FILTER",
             "EXAMINE", "COMPARE", "CHANGE_TOOL", "AVAILABILITY", "ALL_STATS",
             "DETAIL_UP", "DETAIL_DOWN", "SLOT_UP", "SLOT_DOWN", "SCROLL_UP", "SCROLL_DOWN",
             "HELP_KEYBINDINGS"
         } ) {
        context.register_action( action );
    }
    std::vector<row> left_rows = available_rows( who, gun, state );
    std::vector<row> right_rows = slot_rows( gun, *gun, nullptr, true );
    item_location selected;
    item_location pinned_installation;
    std::optional<item> preview;
    std::string denial;
    std::vector<std::string> requirement_lines;
    std::vector<std::string> stat_lines;
    bool refresh = true;
    ui_adaptor ui;
    ui.on_screen_resize( [&]( ui_adaptor & adaptor ) {
        display.resize( adaptor );
    } );
    ui.mark_resize();
    ui.on_redraw( [&]( const ui_adaptor & ) {
        werase( display.root );
        if( TERMX < 20 || TERMY < 8 ) {
            trim_and_print( display.root, point::zero, std::max( 1, TERMX ), c_light_red,
                            _( "Enlarge the terminal or quit." ) );
            wnoutrefresh( display.root );
            return;
        }
        draw_border( display.root );
        trim_and_print( display.root, point( 2, 0 ), std::max( 1, TERMX - 4 ), c_white,
                        string_format( _( "Gun modifications: %s" ), gun->tname() ) );
        std::string filter = state.filter;
        if( state.slot_filter ) {
            filter += string_format( _( " Slot: %s" ), state.slot_filter->name() );
        }
        const std::string availability = state.availability_filter == 1 ? _( "Ready" ) :
                                         ( state.availability_filter == 2 ? _( "Blocked" ) : _( "All" ) );
        trim_and_print( display.root, point::south_east, std::max( 1, TERMX - 2 ), c_light_gray,
                        string_format( _( "Filter: %1$s [%2$s]" ), filter, availability ) );
        const std::string controls = string_format( _( "%1$s Switch  %2$s Install/remove  %3$s Filter  "
                                     "%4$s Tool  %5$s Details  %6$s Help  %7$s Back" ),
                                     context.get_desc( "NEXT_TAB" ), context.get_desc( "CONFIRM" ),
                                     context.get_desc( "FILTER" ), context.get_desc( "CHANGE_TOOL" ),
                                     context.get_desc( "EXAMINE" ), context.get_desc( "HELP_KEYBINDINGS" ),
                                     context.get_desc( "QUIT" ) );
        const std::string compact = string_format( _( "%1$s Switch  %2$s Confirm  %3$s Help  %4$s Back" ),
                                    context.get_desc( "NEXT_TAB" ), context.get_desc( "CONFIRM" ),
                                    context.get_desc( "HELP_KEYBINDINGS" ), context.get_desc( "QUIT" ) );
        trim_and_print( display.root, point( 1, TERMY - 2 ), std::max( 1, TERMX - 2 ), c_light_gray,
                        utf8_width( controls, true ) > TERMX - 2 ? compact : controls );
        wnoutrefresh( display.root );
        if( !display.layout.single_pane || !state.right_active ) {
            draw_rows( display.left, _( "Available modifications" ), left_rows, state.left,
                       !state.right_active );
        }
        if( !display.layout.single_pane || state.right_active ) {
            draw_rows( display.right, _( "Slots: used/total" ), right_rows, state.right,
                       state.right_active );
        }
        werase( display.detail );
        const int detail_width = std::max( 1, getmaxx( display.detail ) - 2 );
        const bool two_columns = detail_width >= 70;
        const int column_width = two_columns ? ( detail_width - 3 ) / 2 : detail_width;
        auto folded = folded_lines( requirement_lines, column_width );
        auto stats = folded_lines( stat_lines, column_width );
        if( !two_columns ) {
            folded.insert( folded.end(), stats.begin(), stats.end() );
            stats.clear();
        }
        const int detail_inset = getmaxy( display.detail ) > 2 ? 1 : 0;
        const int detail_height = std::max( 1, getmaxy( display.detail ) - detail_inset * 2 );
        state.detail_offset = std::clamp( state.detail_offset, 0,
                                          std::max( 0, static_cast<int>( std::max( folded.size(), stats.size() ) ) - detail_height ) );
        if( getmaxy( display.detail ) > 2 ) {
            draw_border( display.detail );
            trim_and_print( display.detail, point( 2, 0 ), std::max( 1, detail_width - 2 ), c_light_blue,
                            string_format( _( "Requirements / whole-gun changes (%1$s/%2$s scroll)" ),
                                           context.get_desc( "DETAIL_UP" ), context.get_desc( "DETAIL_DOWN" ) ) );
        }
        const auto draw_lines = [&]( const std::vector<std::string> &lines, int start_column ) {
            for( int line = 0; line < detail_height &&
                 line + state.detail_offset < static_cast<int>( lines.size() ); ++line ) {
                trim_and_print( display.detail, point( start_column, line + detail_inset ), column_width,
                                c_light_gray,
                                lines[line + state.detail_offset] );
            }
        };
        draw_lines( folded, 1 );
        if( two_columns ) {
            draw_lines( stats, column_width + 3 );
        }
        wnoutrefresh( display.detail );
    } );

    while( gun ) {
        if( refresh ) {
            const item_location previous_selected = selected;
            state.left.normalize( left_rows.size(), std::max( 1, TERMY - 8 ) );
            state.right.normalize( right_rows.size(), std::max( 1, TERMY - 8 ) );
            selected = state.right_active ?
                       ( right_rows.empty() ? item_location::nowhere : right_rows[state.right.selected].mod ) :
                       ( left_rows.empty() ? item_location::nowhere : left_rows[state.left.selected].mod );
            if( !state.right_active ) {
                pinned_installation = selected;
            }
            const item_location display_mod = selected ? selected : pinned_installation;
            const bool installing = !state.right_active || !selected;
            denial.clear();
            preview.emplace( *gun );
            const bool compatible = display_mod && ( !installing ||
                                    gun->is_gunmod_compatible( *display_mod ).success() );
            if( display_mod ) {
                denial = installing ? installation_denial( who, gun, *display_mod ) :
                         removal_denial( *gun, *display_mod );
                if( compatible ) {
                    preview.emplace( preview_change( *gun, *display_mod, installing ) );
                }
            }
            const gunmod_location selected_slot = !right_rows.empty() ?
                                                  right_rows[state.right.selected].location : gunmod_location();
            const std::string selected_text = right_rows.empty() ? "" :
                                              right_rows[state.right.selected].text;
            right_rows = slot_rows( gun, *preview, compatible ? display_mod.get_item() : nullptr,
                                    installing );
            if( state.right_active ) {
                const auto found = std::find_if( right_rows.begin(), right_rows.end(), [&]( const row & entry ) {
                    return selected ? entry.mod == selected :
                           ( !entry.mod && entry.location == selected_slot && entry.text == selected_text );
                } );
                if( found != right_rows.end() ) {
                    state.right.selected = std::distance( right_rows.begin(), found );
                }
            } else if( selected && selected != previous_selected ) {
                const auto found = std::find_if( right_rows.begin(), right_rows.end(), [&]( const row & entry ) {
                    return entry.location == selected->type->gunmod->location;
                } );
                if( found != right_rows.end() ) {
                    state.right.selected = std::distance( right_rows.begin(), found );
                }
            }
            requirement_lines = requirements( who, gun, display_mod, installing, denial, state );
            stat_lines = compatible ? statistics( who, *gun, *preview, state.all_stats ) :
                         std::vector<std::string> { _( "Select a compatible modification to compare whole-gun statistics." ) };
            refresh = false;
        }
        ui_manager::redraw();
        const std::string action = context.handle_input();
        cursor &position = state.right_active ? state.right : state.left;
        if( action == "QUIT" ) {
            break;
        } else if( TERMX < 20 || TERMY < 8 ) {
            continue;
        } else if( action == "UP" || action == "DOWN" || action == "PAGE_UP" || action == "PAGE_DOWN" ||
                   action == "SCROLL_UP" || action == "SCROLL_DOWN" ) {
            const int step = action == "PAGE_UP" || action == "PAGE_DOWN" ?
                             std::max( 1, display.layout.body_height - 2 ) : 1;
            position.selected += action == "UP" || action == "PAGE_UP" || action == "SCROLL_UP" ? -step : step;
            state.detail_offset = 0;
            refresh = true;
        } else if( action == "NEXT_TAB" || action == "PREV_TAB" || action == "LEFT" || action == "RIGHT" ) {
            if( !state.right_active && !left_rows.empty() ) {
                const gunmod_location target = left_rows[state.left.selected].location;
                const auto found = std::find_if( right_rows.begin(), right_rows.end(), [&]( const row & entry ) {
                    return entry.location == target;
                } );
                if( found != right_rows.end() ) {
                    state.right.selected = std::distance( right_rows.begin(), found );
                }
            }
            state.right_active = !state.right_active;
            state.detail_offset = 0;
            refresh = true;
        } else if( action == "FILTER" ) {
            string_input_popup prompt;
            prompt.title( _( "Filter modifications" ) ).text( state.filter ).identifier( "gunmod_filter" );
            const std::string filter = prompt.query_string();
            if( !prompt.canceled() ) {
                state.filter = filter;
                state.left = {};
                left_rows = available_rows( who, gun, state );
            }
            refresh = true;
        } else if( action == "RESET_FILTER" || action == "AVAILABILITY" ) {
            if( action == "RESET_FILTER" ) {
                state.filter.clear();
                state.slot_filter.reset();
                state.availability_filter = 0;
            } else {
                state.availability_filter = ( state.availability_filter + 1 ) % 3;
            }
            state.left = {};
            left_rows = available_rows( who, gun, state );
            refresh = true;
        } else if( action == "CHANGE_TOOL" && selected && !state.right_active ) {
            state.tool = ( state.tool + 1 ) % installation_options( who, gun, *selected ).size();
            refresh = true;
        } else if( action == "ALL_STATS" ) {
            state.all_stats = !state.all_stats;
            refresh = true;
        } else if( action == "DETAIL_UP" || action == "DETAIL_DOWN" ) {
            state.detail_offset += action == "DETAIL_UP" ? -1 : 1;
        } else if( action == "SLOT_UP" || action == "SLOT_DOWN" ) {
            state.right.selected += action == "SLOT_UP" ? -1 : 1;
            state.right.normalize( right_rows.size(), std::max( 1, display.layout.body_height - 2 ) );
            if( state.right_active ) {
                refresh = true;
            }
        } else if( action == "EXAMINE" ) {
            std::string text;
            for( const std::string &line : requirement_lines ) {
                text += line + "\n";
            }
            for( const std::string &line : stat_lines ) {
                text += line + "\n";
            }
            if( selected ) {
                text += "\n" + selected->info( true );
            }
            scrollable_text( []() {
                return catacurses::newwin( TERMY, TERMX, point::zero );
            }, _( "Modification details" ), text );
        } else if( action == "COMPARE" && selected && preview ) {
            game_menus::inv::compare_item_menu( *gun, *preview, _( "Modification preview" ) ).show();
        } else if( action == "CONFIRM" ) {
            if( state.right_active && !selected && !right_rows.empty() ) {
                state.slot_filter = right_rows[state.right.selected].location;
                state.right_active = false;
                state.left = {};
                left_rows = available_rows( who, gun, state );
                refresh = true;
                continue;
            }
            if( !selected ) {
                continue;
            }
            denial = state.right_active ? removal_denial( *gun, *selected ) :
                     installation_denial( who, gun, *selected );
            if( !denial.empty() ) {
                popup( "%s", denial );
                continue;
            }
            saved_state = state;
            if( state.right_active ) {
                if( !query_yn( _( "Remove %1$s from %2$s?" ), selected->tname(), gun->tname() ) ) {
                    continue;
                }
                if( who.gunmod_remove( gun, *selected ) ) {
                    auto *actor = dynamic_cast<gunmod_remove_activity_actor *>( who.activity.actor.get() );
                    actor->reopen_menu = true;
                    saved_gun = gun;
                    return;
                }
            } else {
                const auto options = installation_options( who, gun, *selected );
                const installation_option option = options[std::min( state.tool,
                                                             static_cast<int>( options.size() ) - 1 )];
                if( !option.available ) {
                    popup( _( "The selected tool does not have enough charges." ) );
                    continue;
                }
                if( !query_yn( _( "Install %1$s on %2$s?" ), selected->tname(), gun->tname() ) ) {
                    continue;
                }
                if( !gun.held_by( who ) ) {
                    gun = gun.obtain( who );
                    if( !gun ) {
                        return;
                    }
                }
                who.gunmod_add( *gun, *selected, option.tool );
                if( auto *actor = dynamic_cast<gunmod_add_activity_actor *>( who.activity.actor.get() );
                    who.activity && actor ) {
                    actor->reopen_menu = true;
                    saved_gun = who.get_wielded_item();
                    return;
                }
                if( !gun ) {
                    gun = who.get_wielded_item();
                }
                if( gun ) {
                    left_rows = available_rows( who, gun, state );
                    right_rows = slot_rows( gun, *gun, nullptr, true );
                    refresh = true;
                }
            }
        }
    }
}

} // namespace gunmod_ui

