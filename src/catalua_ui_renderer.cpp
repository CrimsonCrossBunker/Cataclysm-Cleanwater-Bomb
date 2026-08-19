#include "catalua_ui_renderer.h"

#include <stdexcept>
#include <unordered_set>

#include "ui_profile.h"

namespace cata::lua_ui
{

namespace
{

script_ui_capability capability_from_name( std::string_view name )
{
    if( name == "colored_text" ) {
        return script_ui_capability::colored_text;
    } else if( name == "inline_layout" ) {
        return script_ui_capability::inline_layout;
    } else if( name == "item_width" ) {
        return script_ui_capability::item_width;
    } else if( name == "progress_bar" ) {
        return script_ui_capability::progress_bar;
    } else if( name == "buttons" ) {
        return script_ui_capability::buttons;
    } else if( name == "selection" ) {
        return script_ui_capability::selection;
    } else if( name == "numeric_input" ) {
        return script_ui_capability::numeric_input;
    } else if( name == "text_input" ) {
        return script_ui_capability::text_input;
    } else if( name == "child_regions" ) {
        return script_ui_capability::child_regions;
    } else if( name == "tables" ) {
        return script_ui_capability::tables;
    } else if( name == "tabs" ) {
        return script_ui_capability::tabs;
    } else if( name == "trees" ) {
        return script_ui_capability::trees;
    } else if( name == "modals" ) {
        return script_ui_capability::modals;
    } else if( name == "tooltips" ) {
        return script_ui_capability::tooltips;
    } else if( name == "virtualization" ) {
        return script_ui_capability::virtualization;
    } else if( name == "radial_selection" ) {
        return script_ui_capability::radial_selection;
    } else if( name == "action_slots" ) {
        return script_ui_capability::action_slots;
    } else if( name == "sprite_canvas" ) {
        return script_ui_capability::sprite_canvas;
    }
    return static_cast<script_ui_capability>( 0 );
}

} // namespace

bool script_ui_renderer_info::supports( script_ui_capability capability ) const
{
    const std::uint32_t mask = static_cast<std::uint32_t>( capability );
    return mask != 0 && ( capabilities & mask ) == mask;
}

script_ui_context::script_ui_context( script_ui_renderer &renderer ) :
    renderer_( &renderer ), profile_( cata::ui::current_profile() )
{
}

void script_ui_context::invalidate() noexcept
{
    renderer_ = nullptr;
}

script_ui_renderer &script_ui_context::renderer() const
{
    if( renderer_ == nullptr ) {
        throw std::runtime_error(
            "Lua UI context is only valid during its current draw callback" );
    }
    return *renderer_;
}

std::string script_ui_context::backend() const
{
    return std::string( renderer().info().backend );
}

std::string script_ui_context::platform() const
{
    return std::string( renderer().info().platform );
}

bool script_ui_context::supports( const std::string &capability ) const
{
    return renderer().info().supports( capability_from_name( capability ) );
}

bool script_ui_context::is_immediate_mode() const
{
    return renderer().info().immediate_mode;
}

bool script_ui_context::uses_native_widgets() const
{
    return renderer().info().native_widgets;
}

script_ui_environment script_ui_context::environment() const
{
    return {
        profile_.id,
        std::string( cata::ui::input_mode_name( profile_.input ) ),
        std::string( cata::ui::density_mode_name( profile_.density ) ),
        std::string( cata::ui::layout_breakpoint_name(
                         profile_.breakpoint_for_width(
                             static_cast<float>( renderer().available_width() ) ) ) ),
        profile_.minimum_target,
        profile_.is_touch(),
        profile_.allow_hover,
        profile_.allow_swipe,
        profile_.native_text_input,
        profile_.keyboard_navigation,
        profile_.pointer_activation,
        profile_.tap_activation,
        profile_.long_press_dangerous
    };
}

void script_ui_context::text( const std::string &value ) const
{
    renderer().text( value );
}

void script_ui_context::heading( const std::string &value ) const
{
    renderer().heading( value );
}

void script_ui_context::bullet_text( const std::string &value ) const
{
    renderer().bullet_text( value );
}

void script_ui_context::disabled_text( const std::string &value ) const
{
    renderer().disabled_text( value );
}

void script_ui_context::text_colored( const std::string &value, double red, double green,
                                      double blue, double alpha ) const
{
    renderer().text_colored( value, red, green, blue, alpha );
}

void script_ui_context::text_tone( const std::string &value, const std::string &tone ) const
{
    if( tone == "normal" ) {
        renderer().text( value );
    } else if( tone == "muted" ) {
        renderer().disabled_text( value );
    } else if( tone == "good" ) {
        renderer().text_colored( value, 0.30, 0.85, 0.42, 1.0 );
    } else if( tone == "warning" ) {
        renderer().text_colored( value, 1.0, 0.70, 0.20, 1.0 );
    } else if( tone == "bad" ) {
        renderer().text_colored( value, 1.0, 0.32, 0.28, 1.0 );
    } else if( tone == "info" ) {
        renderer().text_colored( value, 0.35, 0.72, 1.0, 1.0 );
    } else {
        throw std::invalid_argument(
            "ctx:text_tone tone must be normal, muted, good, warning, bad, or info" );
    }
}

void script_ui_context::separator() const
{
    renderer().separator();
}

void script_ui_context::same_line() const
{
    renderer().same_line();
}

void script_ui_context::new_line() const
{
    renderer().new_line();
}

void script_ui_context::spacing() const
{
    renderer().spacing();
}

void script_ui_context::set_next_item_width( double width ) const
{
    renderer().set_next_item_width( width );
}

void script_ui_context::item_width( const std::string &token ) const
{
    cata::ui::size_token parsed;
    if( !cata::ui::size_token_from_name( token, parsed ) ) {
        throw std::invalid_argument(
            "ctx:item_width token must be compact, normal, wide, or fill" );
    }
    renderer().set_next_item_width( profile_.item_width( parsed ) );
}

void script_ui_context::progress_bar( double fraction,
                                      const std::optional<std::string> &overlay ) const
{
    renderer().progress_bar( fraction, overlay );
}

bool script_ui_context::button( const std::string &label ) const
{
    return button_id( label, label );
}

bool script_ui_context::button_id( const std::string &id, const std::string &label ) const
{
    return renderer().button( id, label );
}

bool script_ui_context::small_button( const std::string &label ) const
{
    return small_button_id( label, label );
}

bool script_ui_context::small_button_id( const std::string &id, const std::string &label ) const
{
    return renderer().small_button( id, label );
}

bool script_ui_context::checkbox( const std::string &label, bool value ) const
{
    return checkbox_id( label, label, value );
}

bool script_ui_context::checkbox_id( const std::string &id, const std::string &label,
                                     bool value ) const
{
    return renderer().checkbox( id, label, value );
}

bool script_ui_context::radio_button( const std::string &label, bool active ) const
{
    return radio_button_id( label, label, active );
}

bool script_ui_context::radio_button_id( const std::string &id, const std::string &label,
        bool active ) const
{
    return renderer().radio_button( id, label, active );
}

bool script_ui_context::selectable( const std::string &label, bool selected ) const
{
    return selectable_id( label, label, selected );
}

bool script_ui_context::selectable_id( const std::string &id, const std::string &label,
                                       bool selected ) const
{
    return renderer().selectable( id, label, selected );
}

int script_ui_context::slider_int( const std::string &label, int value, int minimum,
                                   int maximum ) const
{
    return slider_int_id( label, label, value, minimum, maximum );
}

int script_ui_context::slider_int_id( const std::string &id, const std::string &label, int value,
                                      int minimum, int maximum ) const
{
    return renderer().slider_int( id, label, value, minimum, maximum );
}

double script_ui_context::slider_float( const std::string &label, double value, double minimum,
                                        double maximum ) const
{
    return slider_float_id( label, label, value, minimum, maximum );
}

double script_ui_context::slider_float_id( const std::string &id, const std::string &label,
        double value, double minimum, double maximum ) const
{
    return renderer().slider_float( id, label, value, minimum, maximum );
}

int script_ui_context::input_int( const std::string &label, int value ) const
{
    return input_int_id( label, label, value );
}

int script_ui_context::input_int_id( const std::string &id, const std::string &label,
                                     int value ) const
{
    return renderer().input_int( id, label, value );
}

double script_ui_context::input_float( const std::string &label, double value ) const
{
    return input_float_id( label, label, value );
}

double script_ui_context::input_float_id( const std::string &id, const std::string &label,
        double value ) const
{
    return renderer().input_float( id, label, value );
}

std::string script_ui_context::input_text( const std::string &label,
        const std::string &value ) const
{
    return input_text_id( label, label, value );
}

std::string script_ui_context::input_text_id( const std::string &id, const std::string &label,
        const std::string &value ) const
{
    return renderer().input_text( id, label, value );
}

std::string script_ui_context::radial_select_id(
    const std::string &id, const std::string &center_label,
    const std::vector<script_ui_radial_option> &options ) const
{
    if( id.empty() || center_label.empty() || options.empty() || options.size() > 8 ) {
        throw std::invalid_argument(
            "ctx:radial_select_id requires an id, center label, and 1..8 options" );
    }
    std::unordered_set<std::string> option_ids;
    for( const script_ui_radial_option &option : options ) {
        if( option.id.empty() || option.label.empty() || option.id.size() > 64 ||
            !option_ids.insert( option.id ).second ) {
            throw std::invalid_argument(
                "ctx:radial_select_id option ids must be unique, non-empty, and at most 64 bytes" );
        }
    }
    return renderer().radial_select( id, center_label, options );
}

std::string script_ui_context::action_slot_id(
    const std::string &id, const std::string &selected_action,
    const int context_revision, const std::vector<script_ui_action_option> &options ) const
{
    if( id.empty() || id.size() > 128 || context_revision < 0 || options.size() > 16 ) {
        throw std::invalid_argument(
            "ctx:action_slot_id requires a 1..128 byte id, a non-negative context revision, "
            "and at most 16 options" );
    }
    std::unordered_set<std::string> option_ids;
    for( const script_ui_action_option &option : options ) {
        if( option.id.empty() || option.label.empty() || option.id.size() > 64 ||
            !option_ids.insert( option.id ).second ) {
            throw std::invalid_argument(
                "ctx:action_slot_id option ids must be unique, non-empty, and at most 64 bytes" );
        }
    }
    return renderer().action_slot( id, selected_action, context_revision, options );
}

void script_ui_context::child( const std::string &id, double height,
                               const std::function<void()> &draw ) const
{
    if( id.empty() || height < 0.0 || !draw ) {
        throw std::invalid_argument( "ctx:child requires an id, non-negative height, and callback" );
    }
    renderer().child( id, height, draw );
}

void script_ui_context::scroll( const std::string &id, const std::string &height_token,
                                const std::function<void()> &draw ) const
{
    cata::ui::size_token parsed;
    if( !cata::ui::size_token_from_name( height_token, parsed ) ) {
        throw std::invalid_argument(
            "ctx:scroll height token must be compact, normal, wide, or fill" );
    }
    child( id, profile_.panel_height( parsed ), draw );
}

void script_ui_context::table( const std::string &id, int columns,
                               const std::function<void()> &draw ) const
{
    if( id.empty() || columns < 1 || columns > 64 || !draw ) {
        throw std::invalid_argument( "ctx:table requires an id, 1..64 columns, and callback" );
    }
    renderer().table( id, columns, draw );
}

void script_ui_context::grid( const std::string &id, const int narrow_columns,
                              const int regular_columns, const int wide_columns,
                              const std::function<void()> &draw ) const
{
    if( narrow_columns < 1 || narrow_columns > 64 ||
        regular_columns < 1 || regular_columns > 64 ||
        wide_columns < 1 || wide_columns > 64 ) {
        throw std::invalid_argument( "ctx:grid requires three column counts in the range 1..64" );
    }
    int columns = regular_columns;
    switch( profile_.breakpoint_for_width(
                static_cast<float>( renderer().available_width() ) ) ) {
        case cata::ui::layout_breakpoint::narrow:
            columns = narrow_columns;
            break;
        case cata::ui::layout_breakpoint::regular:
            columns = regular_columns;
            break;
        case cata::ui::layout_breakpoint::wide:
            columns = wide_columns;
            break;
    }
    table( id, columns, draw );
}

void script_ui_context::table_next_row() const
{
    renderer().table_next_row();
}

bool script_ui_context::table_next_column() const
{
    return renderer().table_next_column();
}

void script_ui_context::tabs( const std::string &id, const std::function<void()> &draw ) const
{
    if( id.empty() || !draw ) {
        throw std::invalid_argument( "ctx:tabs requires an id and callback" );
    }
    renderer().tabs( id, draw );
}

bool script_ui_context::tab( const std::string &id, const std::string &label,
                             const std::function<void()> &draw ) const
{
    if( id.empty() || !draw ) {
        throw std::invalid_argument( "ctx:tab requires an id and callback" );
    }
    return renderer().tab( id, label, draw );
}

bool script_ui_context::tree( const std::string &id, const std::string &label, bool default_open,
                              const std::function<void()> &draw ) const
{
    if( id.empty() || !draw ) {
        throw std::invalid_argument( "ctx:tree requires an id and callback" );
    }
    return renderer().tree( id, label, default_open, draw );
}

bool script_ui_context::modal( const std::string &id, const std::string &title, bool open,
                               const std::function<void()> &draw ) const
{
    if( id.empty() || !draw ) {
        throw std::invalid_argument( "ctx:modal requires an id and callback" );
    }
    return renderer().modal( id, title, open, draw );
}

void script_ui_context::tooltip( const std::string &text ) const
{
    renderer().tooltip( text );
}

void script_ui_context::virtual_list( int item_count, double item_height,
                                      const std::function<void( int, int )> &draw_range ) const
{
    if( item_count < 0 || item_count > 1000000 || item_height <= 0.0 || !draw_range ) {
        throw std::invalid_argument(
            "ctx:virtual_list requires 0..1000000 items, positive height, and callback" );
    }
    renderer().virtual_list( item_count, item_height, draw_range );
}

void script_ui_context::virtual_list_rows(
    const int item_count, const std::string &row_token,
    const std::function<void( int, int )> &draw_range ) const
{
    cata::ui::size_token parsed;
    if( !cata::ui::size_token_from_name( row_token, parsed ) ||
        parsed == cata::ui::size_token::fill ) {
        throw std::invalid_argument(
            "ctx:virtual_list_rows token must be compact, normal, or wide" );
    }
    virtual_list( item_count, profile_.row_height( parsed ), draw_range );
}

void script_ui_context::canvas_begin( const double width, const double height ) const
{
    renderer().canvas_begin( width, height );
}

void script_ui_context::canvas_rect( const double x, const double y, const double width,
                                     const double height, const double red, const double green,
                                     const double blue, const double alpha ) const
{
    renderer().canvas_rect( x, y, width, height, red, green, blue, alpha );
}

void script_ui_context::canvas_text( const double x, const double y, const std::string &value,
                                     const double red, const double green, const double blue,
                                     const double alpha ) const
{
    renderer().canvas_text( x, y, value, red, green, blue, alpha );
}

bool script_ui_context::canvas_sprite( const std::string &tile_id, const double x,
                                       const double y, const double width,
                                       const double height ) const
{
    return renderer().canvas_sprite( tile_id, x, y, width, height );
}

bool script_ui_context::canvas_button( const std::string &id, const std::string &label,
                                       const double x, const double y, const double width,
                                       const double height, const bool request_focus ) const
{
    return renderer().canvas_button( id, label, x, y, width, height, request_focus );
}

} // namespace cata::lua_ui
