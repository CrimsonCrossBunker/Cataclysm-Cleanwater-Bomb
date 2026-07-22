#include "catalua_ui_renderer.h"

#include <stdexcept>
#include <unordered_set>

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
    }
    return static_cast<script_ui_capability>( 0 );
}

} // namespace

bool script_ui_renderer_info::supports( script_ui_capability capability ) const
{
    const std::uint32_t mask = static_cast<std::uint32_t>( capability );
    return mask != 0 && ( capabilities & mask ) == mask;
}

std::string script_ui_context::backend() const
{
    return std::string( renderer_.info().backend );
}

std::string script_ui_context::platform() const
{
    return std::string( renderer_.info().platform );
}

bool script_ui_context::supports( const std::string &capability ) const
{
    return renderer_.info().supports( capability_from_name( capability ) );
}

bool script_ui_context::is_immediate_mode() const
{
    return renderer_.info().immediate_mode;
}

bool script_ui_context::uses_native_widgets() const
{
    return renderer_.info().native_widgets;
}

void script_ui_context::text( const std::string &value ) const
{
    renderer_.text( value );
}

void script_ui_context::heading( const std::string &value ) const
{
    renderer_.heading( value );
}

void script_ui_context::bullet_text( const std::string &value ) const
{
    renderer_.bullet_text( value );
}

void script_ui_context::disabled_text( const std::string &value ) const
{
    renderer_.disabled_text( value );
}

void script_ui_context::text_colored( const std::string &value, double red, double green,
                                      double blue, double alpha ) const
{
    renderer_.text_colored( value, red, green, blue, alpha );
}

void script_ui_context::separator() const
{
    renderer_.separator();
}

void script_ui_context::same_line() const
{
    renderer_.same_line();
}

void script_ui_context::new_line() const
{
    renderer_.new_line();
}

void script_ui_context::spacing() const
{
    renderer_.spacing();
}

void script_ui_context::set_next_item_width( double width ) const
{
    renderer_.set_next_item_width( width );
}

void script_ui_context::progress_bar( double fraction,
                                      const std::optional<std::string> &overlay ) const
{
    renderer_.progress_bar( fraction, overlay );
}

bool script_ui_context::button( const std::string &label ) const
{
    return button_id( label, label );
}

bool script_ui_context::button_id( const std::string &id, const std::string &label ) const
{
    return renderer_.button( id, label );
}

bool script_ui_context::small_button( const std::string &label ) const
{
    return small_button_id( label, label );
}

bool script_ui_context::small_button_id( const std::string &id, const std::string &label ) const
{
    return renderer_.small_button( id, label );
}

bool script_ui_context::checkbox( const std::string &label, bool value ) const
{
    return checkbox_id( label, label, value );
}

bool script_ui_context::checkbox_id( const std::string &id, const std::string &label,
                                     bool value ) const
{
    return renderer_.checkbox( id, label, value );
}

bool script_ui_context::radio_button( const std::string &label, bool active ) const
{
    return radio_button_id( label, label, active );
}

bool script_ui_context::radio_button_id( const std::string &id, const std::string &label,
        bool active ) const
{
    return renderer_.radio_button( id, label, active );
}

bool script_ui_context::selectable( const std::string &label, bool selected ) const
{
    return selectable_id( label, label, selected );
}

bool script_ui_context::selectable_id( const std::string &id, const std::string &label,
                                       bool selected ) const
{
    return renderer_.selectable( id, label, selected );
}

int script_ui_context::slider_int( const std::string &label, int value, int minimum,
                                   int maximum ) const
{
    return slider_int_id( label, label, value, minimum, maximum );
}

int script_ui_context::slider_int_id( const std::string &id, const std::string &label, int value,
                                      int minimum, int maximum ) const
{
    return renderer_.slider_int( id, label, value, minimum, maximum );
}

double script_ui_context::slider_float( const std::string &label, double value, double minimum,
                                        double maximum ) const
{
    return slider_float_id( label, label, value, minimum, maximum );
}

double script_ui_context::slider_float_id( const std::string &id, const std::string &label,
        double value, double minimum, double maximum ) const
{
    return renderer_.slider_float( id, label, value, minimum, maximum );
}

int script_ui_context::input_int( const std::string &label, int value ) const
{
    return input_int_id( label, label, value );
}

int script_ui_context::input_int_id( const std::string &id, const std::string &label,
                                     int value ) const
{
    return renderer_.input_int( id, label, value );
}

double script_ui_context::input_float( const std::string &label, double value ) const
{
    return input_float_id( label, label, value );
}

double script_ui_context::input_float_id( const std::string &id, const std::string &label,
        double value ) const
{
    return renderer_.input_float( id, label, value );
}

std::string script_ui_context::input_text( const std::string &label,
        const std::string &value ) const
{
    return input_text_id( label, label, value );
}

std::string script_ui_context::input_text_id( const std::string &id, const std::string &label,
        const std::string &value ) const
{
    return renderer_.input_text( id, label, value );
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
    return renderer_.radial_select( id, center_label, options );
}

void script_ui_context::child( const std::string &id, double height,
                               const std::function<void()> &draw ) const
{
    if( id.empty() || height < 0.0 || !draw ) {
        throw std::invalid_argument( "ctx:child requires an id, non-negative height, and callback" );
    }
    renderer_.child( id, height, draw );
}

void script_ui_context::table( const std::string &id, int columns,
                               const std::function<void()> &draw ) const
{
    if( id.empty() || columns < 1 || columns > 64 || !draw ) {
        throw std::invalid_argument( "ctx:table requires an id, 1..64 columns, and callback" );
    }
    renderer_.table( id, columns, draw );
}

void script_ui_context::table_next_row() const
{
    renderer_.table_next_row();
}

bool script_ui_context::table_next_column() const
{
    return renderer_.table_next_column();
}

void script_ui_context::tabs( const std::string &id, const std::function<void()> &draw ) const
{
    if( id.empty() || !draw ) {
        throw std::invalid_argument( "ctx:tabs requires an id and callback" );
    }
    renderer_.tabs( id, draw );
}

bool script_ui_context::tab( const std::string &id, const std::string &label,
                             const std::function<void()> &draw ) const
{
    if( id.empty() || !draw ) {
        throw std::invalid_argument( "ctx:tab requires an id and callback" );
    }
    return renderer_.tab( id, label, draw );
}

bool script_ui_context::tree( const std::string &id, const std::string &label, bool default_open,
                              const std::function<void()> &draw ) const
{
    if( id.empty() || !draw ) {
        throw std::invalid_argument( "ctx:tree requires an id and callback" );
    }
    return renderer_.tree( id, label, default_open, draw );
}

bool script_ui_context::modal( const std::string &id, const std::string &title, bool open,
                               const std::function<void()> &draw ) const
{
    if( id.empty() || !draw ) {
        throw std::invalid_argument( "ctx:modal requires an id and callback" );
    }
    return renderer_.modal( id, title, open, draw );
}

void script_ui_context::tooltip( const std::string &text ) const
{
    renderer_.tooltip( text );
}

void script_ui_context::virtual_list( int item_count, double item_height,
                                      const std::function<void( int, int )> &draw_range ) const
{
    if( item_count < 0 || item_count > 1000000 || item_height <= 0.0 || !draw_range ) {
        throw std::invalid_argument(
            "ctx:virtual_list requires 0..1000000 items, positive height, and callback" );
    }
    renderer_.virtual_list( item_count, item_height, draw_range );
}

} // namespace cata::lua_ui
