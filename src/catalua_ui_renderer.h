#pragma once
#ifndef CATA_SRC_CATALUA_UI_RENDERER_H
#define CATA_SRC_CATALUA_UI_RENDERER_H

#include <cstdint>
#include <functional>
#include <optional>
#include <string>
#include <string_view>

namespace cata::lua_ui
{

// Capabilities describe which widget families a renderer implements with its
// native interaction model.  Calls remain safe when a capability is absent;
// adapters may render a read-only or simplified fallback instead.
enum class script_ui_capability : std::uint32_t {
    colored_text = 1U << 0,
    inline_layout = 1U << 1,
    item_width = 1U << 2,
    progress_bar = 1U << 3,
    buttons = 1U << 4,
    selection = 1U << 5,
    numeric_input = 1U << 6,
    text_input = 1U << 7,
    child_regions = 1U << 8,
    tables = 1U << 9,
    tabs = 1U << 10,
    trees = 1U << 11,
    modals = 1U << 12,
    tooltips = 1U << 13,
    virtualization = 1U << 14
};

struct script_ui_renderer_info {
    std::string_view backend;
    std::string_view platform;
    std::uint32_t capabilities = 0;
    bool immediate_mode = false;
    bool native_widgets = false;

    bool supports( script_ui_capability capability ) const;
};

// Platform-neutral rendering contract used by Lua UI callbacks.  ImGui,
// ImTui, and Android native UI adapters can implement this interface without
// exposing their own widget types to Lua.
class script_ui_renderer
{
    public:
        virtual ~script_ui_renderer() = default;

        virtual script_ui_renderer_info info() const = 0;

        virtual void text( const std::string &value ) = 0;
        virtual void heading( const std::string &value ) = 0;
        virtual void bullet_text( const std::string &value ) = 0;
        virtual void disabled_text( const std::string &value ) = 0;
        virtual void text_colored( const std::string &value, double red, double green,
                                   double blue, double alpha ) = 0;
        virtual void separator() = 0;
        virtual void same_line() = 0;
        virtual void new_line() = 0;
        virtual void spacing() = 0;
        virtual void set_next_item_width( double width ) = 0;
        virtual void progress_bar( double fraction,
                                   const std::optional<std::string> &overlay ) = 0;

        // Interactive widgets use stable ids independent of their visible
        // labels.  A retained renderer may key native view state and queued
        // interaction events by this id.  Values follow a controlled-widget
        // model: Lua supplies the current value and receives the renderer's
        // value for this frame; button results are one-shot activations.
        virtual bool button( const std::string &id, const std::string &label ) = 0;
        virtual bool small_button( const std::string &id, const std::string &label ) = 0;
        virtual bool checkbox( const std::string &id, const std::string &label, bool value ) = 0;
        virtual bool radio_button( const std::string &id, const std::string &label,
                                   bool active ) = 0;
        virtual bool selectable( const std::string &id, const std::string &label,
                                 bool selected ) = 0;
        virtual int slider_int( const std::string &id, const std::string &label, int value, int minimum,
                                int maximum ) = 0;
        virtual double slider_float( const std::string &id, const std::string &label, double value,
                                     double minimum, double maximum ) = 0;
        virtual int input_int( const std::string &id, const std::string &label, int value ) = 0;
        virtual double input_float( const std::string &id, const std::string &label,
                                    double value ) = 0;
        virtual std::string input_text( const std::string &id, const std::string &label,
                                        const std::string &value ) = 0;

        // Structured containers execute their body while the adapter owns the
        // matching Begin/End or Push/Pop pair.  This prevents Lua exceptions
        // from corrupting an immediate-mode backend's global stack.
        virtual void child( const std::string &id, double height,
                            const std::function<void()> &draw ) = 0;
        virtual void table( const std::string &id, int columns,
                            const std::function<void()> &draw ) = 0;
        virtual void table_next_row() = 0;
        virtual bool table_next_column() = 0;
        virtual void tabs( const std::string &id, const std::function<void()> &draw ) = 0;
        virtual bool tab( const std::string &id, const std::string &label,
                          const std::function<void()> &draw ) = 0;
        virtual bool tree( const std::string &id, const std::string &label, bool default_open,
                           const std::function<void()> &draw ) = 0;
        virtual bool modal( const std::string &id, const std::string &title, bool open,
                            const std::function<void()> &draw ) = 0;
        virtual void tooltip( const std::string &text ) = 0;
        virtual void virtual_list( int item_count, double item_height,
                                   const std::function<void( int, int )> &draw_range ) = 0;
};

// Safe facade exposed to Lua.  It owns no platform UI state and simply
// forwards validated widget operations to the active renderer.
class script_ui_context
{
    public:
        explicit script_ui_context( script_ui_renderer &renderer ) : renderer_( renderer ) {}

        std::string backend() const;
        std::string platform() const;
        bool supports( const std::string &capability ) const;
        bool is_immediate_mode() const;
        bool uses_native_widgets() const;

        void text( const std::string &value ) const;
        void heading( const std::string &value ) const;
        void bullet_text( const std::string &value ) const;
        void disabled_text( const std::string &value ) const;
        void text_colored( const std::string &value, double red, double green, double blue,
                           double alpha ) const;
        void separator() const;
        void same_line() const;
        void new_line() const;
        void spacing() const;
        void set_next_item_width( double width ) const;
        void progress_bar( double fraction, const std::optional<std::string> &overlay ) const;

        bool button( const std::string &label ) const;
        bool button_id( const std::string &id, const std::string &label ) const;
        bool small_button( const std::string &label ) const;
        bool small_button_id( const std::string &id, const std::string &label ) const;
        bool checkbox( const std::string &label, bool value ) const;
        bool checkbox_id( const std::string &id, const std::string &label, bool value ) const;
        bool radio_button( const std::string &label, bool active ) const;
        bool radio_button_id( const std::string &id, const std::string &label, bool active ) const;
        bool selectable( const std::string &label, bool selected ) const;
        bool selectable_id( const std::string &id, const std::string &label, bool selected ) const;
        int slider_int( const std::string &label, int value, int minimum, int maximum ) const;
        int slider_int_id( const std::string &id, const std::string &label, int value, int minimum,
                           int maximum ) const;
        double slider_float( const std::string &label, double value, double minimum,
                             double maximum ) const;
        double slider_float_id( const std::string &id, const std::string &label, double value,
                                double minimum, double maximum ) const;
        int input_int( const std::string &label, int value ) const;
        int input_int_id( const std::string &id, const std::string &label, int value ) const;
        double input_float( const std::string &label, double value ) const;
        double input_float_id( const std::string &id, const std::string &label, double value ) const;
        std::string input_text( const std::string &label, const std::string &value ) const;
        std::string input_text_id( const std::string &id, const std::string &label,
                                   const std::string &value ) const;
        void child( const std::string &id, double height,
                    const std::function<void()> &draw ) const;
        void table( const std::string &id, int columns,
                    const std::function<void()> &draw ) const;
        void table_next_row() const;
        bool table_next_column() const;
        void tabs( const std::string &id, const std::function<void()> &draw ) const;
        bool tab( const std::string &id, const std::string &label,
                  const std::function<void()> &draw ) const;
        bool tree( const std::string &id, const std::string &label, bool default_open,
                   const std::function<void()> &draw ) const;
        bool modal( const std::string &id, const std::string &title, bool open,
                    const std::function<void()> &draw ) const;
        void tooltip( const std::string &text ) const;
        void virtual_list( int item_count, double item_height,
                           const std::function<void( int, int )> &draw_range ) const;

    private:
        script_ui_renderer &renderer_;
};

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_RENDERER_H
