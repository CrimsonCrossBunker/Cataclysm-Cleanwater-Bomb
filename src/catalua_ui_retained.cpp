#include "catalua_ui_retained.h"

#include <algorithm>
#include <charconv>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <stdexcept>
#include <string>
#include <sstream>
#include <utility>

#include "json.h"

namespace cata::lua_ui
{

namespace
{

constexpr int maximum_retained_virtual_items = 200;
constexpr std::uint32_t retained_capability_mask =
    static_cast<std::uint32_t>( script_ui_capability::colored_text ) |
    static_cast<std::uint32_t>( script_ui_capability::inline_layout ) |
    static_cast<std::uint32_t>( script_ui_capability::item_width ) |
    static_cast<std::uint32_t>( script_ui_capability::progress_bar ) |
    static_cast<std::uint32_t>( script_ui_capability::buttons ) |
    static_cast<std::uint32_t>( script_ui_capability::selection ) |
    static_cast<std::uint32_t>( script_ui_capability::numeric_input ) |
    static_cast<std::uint32_t>( script_ui_capability::text_input ) |
    static_cast<std::uint32_t>( script_ui_capability::child_regions ) |
    static_cast<std::uint32_t>( script_ui_capability::tables ) |
    static_cast<std::uint32_t>( script_ui_capability::tabs ) |
    static_cast<std::uint32_t>( script_ui_capability::trees ) |
    static_cast<std::uint32_t>( script_ui_capability::modals ) |
    static_cast<std::uint32_t>( script_ui_capability::tooltips ) |
    static_cast<std::uint32_t>( script_ui_capability::virtualization ) |
    static_cast<std::uint32_t>( script_ui_capability::radial_selection );

bool encoded_bool( const std::optional<std::string> &value, bool fallback )
{
    if( !value || value->rfind( "bool:", 0 ) != 0 ) {
        return fallback;
    }
    return value->substr( 5 ) == "1" || value->substr( 5 ) == "true";
}

int encoded_int( const std::optional<std::string> &value, int fallback )
{
    if( !value || value->rfind( "int:", 0 ) != 0 ) {
        return fallback;
    }
    int result = fallback;
    const std::string raw = value->substr( 4 );
    const auto parsed = std::from_chars( raw.data(), raw.data() + raw.size(), result );
    return parsed.ec == std::errc() && parsed.ptr == raw.data() + raw.size() ? result : fallback;
}

double encoded_number( const std::optional<std::string> &value, double fallback )
{
    if( !value || value->rfind( "number:", 0 ) != 0 ) {
        return fallback;
    }
    char *end = nullptr;
    const std::string raw = value->substr( 7 );
    const double result = std::strtod( raw.c_str(), &end );
    return end == raw.c_str() + raw.size() && std::isfinite( result ) ? result : fallback;
}

std::string encoded_text( const std::optional<std::string> &value,
                          const std::string &fallback )
{
    return value && value->rfind( "text:", 0 ) == 0 ? value->substr( 5 ) : fallback;
}

void write_node( JsonOut &json, const retained_ui_node &node )
{
    json.start_object();
    json.member( "type", node.type );
    if( !node.id.empty() ) {
        json.member( "id", node.id );
    }
    if( !node.label.empty() ) {
        json.member( "label", node.label );
    }
    if( !node.text.empty() ) {
        json.member( "text", node.text );
    }
    if( !node.string_value.empty() || node.type == "input_text" ) {
        json.member( "stringValue", node.string_value );
    }
    if( node.type == "progress" || node.type == "slider_float" || node.type == "input_float" ||
        node.type == "color_text" ) {
        json.member( "numberValue", node.number_value );
    }
    if( node.type == "slider_int" || node.type == "input_int" ) {
        json.member( "integerValue", node.integer_value );
    }
    if( node.type == "checkbox" || node.type == "radio" || node.type == "selectable" ||
        node.type == "tree" || node.type == "modal" ) {
        json.member( "boolValue", node.bool_value );
    }
    if( node.type == "radial_option" ) {
        json.member( "enabled", node.enabled );
        json.member( "selected", node.selected );
    }
    if( node.minimum != 0.0 || node.maximum != 0.0 ) {
        json.member( "minimum", node.minimum );
        json.member( "maximum", node.maximum );
    }
    if( node.height != 0.0 ) {
        json.member( "height", node.height );
    }
    if( node.columns != 0 ) {
        json.member( "columns", node.columns );
    }
    if( node.count != 0 || node.type == "virtual_list" ) {
        json.member( "count", node.count );
        json.member( "truncated", node.truncated );
    }
    if( !node.children.empty() ) {
        json.member( "children" );
        json.start_array();
        for( const retained_ui_node &child : node.children ) {
            write_node( json, child );
        }
        json.end_array();
    }
    json.end_object();
}

class retained_script_ui_renderer final : public script_ui_renderer
{
    public:
        retained_script_ui_renderer( retained_ui_document &document, std::string id_prefix,
                                     retained_interaction_reader interaction_reader ) :
            document_( document ), prefix_( std::move( id_prefix ) ),
            interaction_reader_( std::move( interaction_reader ) ) {
            stack_.push_back( &document_.nodes );
        }

        script_ui_renderer_info info() const override {
            return { "retained", "android", retained_capability_mask, false, true };
        }

        void text( const std::string &value ) override {
            add( "text", {}, {}, value );
        }
        void heading( const std::string &value ) override {
            add( "heading", {}, {}, value );
        }
        void bullet_text( const std::string &value ) override {
            add( "bullet", {}, {}, value );
        }
        void disabled_text( const std::string &value ) override {
            add( "disabled_text", {}, {}, value );
        }
        void text_colored( const std::string &value, double red, double green, double blue,
                           double alpha ) override {
            retained_ui_node &node = add( "color_text", {}, {}, value );
            node.string_value = std::to_string( red ) + "," + std::to_string( green ) + "," +
                                std::to_string( blue ) + "," + std::to_string( alpha );
        }
        void separator() override {
            add( "separator" );
        }
        void same_line() override {
            add( "same_line" );
        }
        void new_line() override {
            add( "new_line" );
        }
        void spacing() override {
            add( "spacing" );
        }
        void set_next_item_width( double width ) override {
            retained_ui_node &node = add( "item_width" );
            node.number_value = width;
        }
        void progress_bar( double fraction,
                           const std::optional<std::string> &overlay ) override {
            retained_ui_node &node = add( "progress", {}, {}, overlay.value_or( "" ) );
            node.number_value = std::clamp( fraction, 0.0, 1.0 );
        }

        bool button( const std::string &id, const std::string &label ) override {
            add( "button", id, label );
            return consume( id ).value_or( "" ) == "click";
        }
        bool small_button( const std::string &id, const std::string &label ) override {
            add( "small_button", id, label );
            return consume( id ).value_or( "" ) == "click";
        }
        bool checkbox( const std::string &id, const std::string &label, bool value ) override {
            value = encoded_bool( consume( id ), value );
            retained_ui_node &node = add( "checkbox", id, label );
            node.bool_value = value;
            return value;
        }
        bool radio_button( const std::string &id, const std::string &label,
                           bool active ) override {
            const bool clicked = consume( id ).value_or( "" ) == "click";
            retained_ui_node &node = add( "radio", id, label );
            node.bool_value = active;
            return clicked;
        }
        bool selectable( const std::string &id, const std::string &label,
                         bool selected ) override {
            const bool clicked = consume( id ).value_or( "" ) == "click";
            retained_ui_node &node = add( "selectable", id, label );
            node.bool_value = selected;
            return clicked;
        }
        int slider_int( const std::string &id, const std::string &label, int value, int minimum,
                        int maximum ) override {
            value = std::clamp( encoded_int( consume( id ), value ), minimum, maximum );
            retained_ui_node &node = add( "slider_int", id, label );
            node.integer_value = value;
            node.minimum = minimum;
            node.maximum = maximum;
            return value;
        }
        double slider_float( const std::string &id, const std::string &label, double value,
                             double minimum, double maximum ) override {
            value = std::clamp( encoded_number( consume( id ), value ), minimum, maximum );
            retained_ui_node &node = add( "slider_float", id, label );
            node.number_value = value;
            node.minimum = minimum;
            node.maximum = maximum;
            return value;
        }
        int input_int( const std::string &id, const std::string &label, int value ) override {
            value = encoded_int( consume( id ), value );
            retained_ui_node &node = add( "input_int", id, label );
            node.integer_value = value;
            return value;
        }
        double input_float( const std::string &id, const std::string &label,
                            double value ) override {
            value = encoded_number( consume( id ), value );
            retained_ui_node &node = add( "input_float", id, label );
            node.number_value = value;
            return value;
        }
        std::string input_text( const std::string &id, const std::string &label,
                                const std::string &value ) override {
            const std::string result = encoded_text( consume( id ), value );
            retained_ui_node &node = add( "input_text", id, label );
            node.string_value = result;
            return result;
        }

        std::string radial_select(
            const std::string &id, const std::string &center_label,
            const std::vector<script_ui_radial_option> &options ) override {
            std::string result;
            const std::optional<std::string> interaction = consume( id );
            if( interaction && interaction->rfind( "select:", 0 ) == 0 ) {
                const std::string candidate = interaction->substr( 7 );
                const auto found = std::find_if( options.begin(), options.end(),
                [&candidate]( const script_ui_radial_option & option ) {
                    return option.id == candidate && option.enabled;
                } );
                if( found != options.end() ) {
                    result = found->id;
                }
            }
            retained_ui_node &node = add( "radial_select", id, center_label );
            for( const script_ui_radial_option &option : options ) {
                retained_ui_node child;
                child.type = "radial_option";
                child.id = option.id;
                child.label = option.label;
                child.enabled = option.enabled;
                child.selected = option.selected;
                node.children.push_back( std::move( child ) );
            }
            return result;
        }

        void child( const std::string &id, double height,
                    const std::function<void()> &draw ) override {
            retained_ui_node &node = add( "child", id );
            node.height = height;
            with_children( node, draw );
        }
        void table( const std::string &id, int columns,
                    const std::function<void()> &draw ) override {
            retained_ui_node &node = add( "table", id );
            node.columns = columns;
            ++table_depth_;
            try {
                with_children( node, draw );
            } catch( ... ) {
                --table_depth_;
                throw;
            }
            --table_depth_;
        }
        void table_next_row() override {
            if( table_depth_ == 0 ) {
                throw std::runtime_error( "ctx:table_next_row must be called inside ctx:table" );
            }
            add( "table_row" );
        }
        bool table_next_column() override {
            if( table_depth_ == 0 ) {
                throw std::runtime_error( "ctx:table_next_column must be called inside ctx:table" );
            }
            add( "table_column" );
            return true;
        }
        void tabs( const std::string &id, const std::function<void()> &draw ) override {
            retained_ui_node &node = add( "tabs", id );
            ++tab_depth_;
            try {
                with_children( node, draw );
            } catch( ... ) {
                --tab_depth_;
                throw;
            }
            --tab_depth_;
        }
        bool tab( const std::string &id, const std::string &label,
                  const std::function<void()> &draw ) override {
            if( tab_depth_ == 0 ) {
                throw std::runtime_error( "ctx:tab must be called inside ctx:tabs" );
            }
            retained_ui_node &node = add( "tab", id, label );
            with_children( node, draw );
            return true;
        }
        bool tree( const std::string &id, const std::string &label, bool default_open,
                   const std::function<void()> &draw ) override {
            const bool open = encoded_bool( consume( id ), default_open );
            retained_ui_node &node = add( "tree", id, label );
            node.bool_value = open;
            if( open ) {
                with_children( node, draw );
            }
            return open;
        }
        bool modal( const std::string &id, const std::string &title, bool open,
                    const std::function<void()> &draw ) override {
            open = encoded_bool( consume( id ), open );
            retained_ui_node &node = add( "modal", id, title );
            node.bool_value = open;
            if( open ) {
                with_children( node, draw );
            }
            return open;
        }
        void tooltip( const std::string &text ) override {
            add( "tooltip", {}, {}, text );
        }
        void virtual_list( int item_count, double item_height,
                           const std::function<void( int, int )> &draw_range ) override {
            retained_ui_node &node = add( "virtual_list" );
            node.count = item_count;
            node.height = item_height;
            const int end = std::min( item_count, maximum_retained_virtual_items );
            node.truncated = end < item_count;
            stack_.push_back( &node.children );
            try {
                draw_range( 0, end );
            } catch( ... ) {
                stack_.pop_back();
                throw;
            }
            stack_.pop_back();
        }

    private:
        retained_ui_node &add( std::string type, std::string id = {}, std::string label = {},
                               std::string text = {} ) {
            stack_.back()->push_back( retained_ui_node{} );
            retained_ui_node &node = stack_.back()->back();
            node.type = std::move( type );
            node.id = id.empty() ? std::string() : prefix_ + id;
            node.label = std::move( label );
            node.text = std::move( text );
            return node;
        }

        std::optional<std::string> consume( const std::string &id ) const {
            return interaction_reader_ ? interaction_reader_( prefix_ + id ) : std::nullopt;
        }

        void with_children( retained_ui_node &node, const std::function<void()> &draw ) {
            stack_.push_back( &node.children );
            try {
                draw();
            } catch( ... ) {
                stack_.pop_back();
                throw;
            }
            stack_.pop_back();
        }

        retained_ui_document &document_;
        std::string prefix_;
        retained_interaction_reader interaction_reader_;
        std::vector<std::vector<retained_ui_node> *> stack_;
        int table_depth_ = 0;
        int tab_depth_ = 0;
};

} // namespace

std::unique_ptr<script_ui_renderer> make_retained_script_ui_renderer(
    retained_ui_document &document, std::string id_prefix,
    retained_interaction_reader interaction_reader )
{
    return std::make_unique<retained_script_ui_renderer>( document, std::move( id_prefix ),
            std::move( interaction_reader ) );
}

std::string retained_document_json( const retained_ui_document &document )
{
    std::ostringstream output;
    JsonOut json( output );
    json.start_array();
    for( const retained_ui_node &node : document.nodes ) {
        write_node( json, node );
    }
    json.end_array();
    return output.str();
}

std::string retained_surfaces_json( const std::vector<retained_ui_surface> &surfaces,
                                    std::size_t generation,
                                    const std::string &selected_page )
{
    std::ostringstream output;
    JsonOut json( output );
    json.start_object();
    json.member( "schema", 1 );
    json.member( "generation", generation );
    json.member( "selectedPage", selected_page );
    json.member( "surfaces" );
    json.start_array();
    for( const retained_ui_surface &surface : surfaces ) {
        json.start_object();
        json.member( "id", surface.id );
        json.member( "title", surface.title );
        json.member( "kind", surface.kind );
        json.member( "anchor", surface.anchor );
        json.member( "x", surface.offset_x );
        json.member( "y", surface.offset_y );
        json.member( "alpha", surface.alpha );
        json.member( "defaultWidth", surface.default_width );
        json.member( "defaultHeight", surface.default_height );
        json.member( "interactive", surface.interactive );
        json.member( "background", surface.background );
        json.member( "titleBar", surface.title_bar );
        json.member( "movable", surface.movable );
        json.member( "scalable", surface.scalable );
        json.member( "userToggleable", surface.user_toggleable );
        json.member( "nodes" );
        json.start_array();
        for( const retained_ui_node &node : surface.document.nodes ) {
            write_node( json, node );
        }
        json.end_array();
        json.end_object();
    }
    json.end_array();
    json.end_object();
    return output.str();
}

} // namespace cata::lua_ui
