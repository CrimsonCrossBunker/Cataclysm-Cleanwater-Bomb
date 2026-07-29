#include "cata_catch.h"
#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "catalua_bindings.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_enums.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "catalua_ui.h"
#include "catalua_ui_actions.h"
#include "catalua_ui_events.h"
#include "catalua_ui_i18n.h"
#include "catalua_ui_manifest.h"
#include "catalua_ui_modules.h"
#include "catalua_ui_navigation.h"
#include "catalua_ui_navigation_internal.h"
#include "catalua_ui_renderer.h"
#include "catalua_ui_scheduler.h"
#include "catalua_ui_services.h"
#include "catalua_ui_state.h"
#include "effect.h"
#include "event_bus.h"
#include "input_context_actions.h"
#include "item.h"
#include "json_loader.h"
#include "path_info.h"
#include "ui_profile.h"
#include "units.h"
#include "weather.h"
#include "worldfactory.h"

#include <algorithm>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <functional>
#include <iterator>
#include <limits>
#include <memory>
#include <optional>
#include <sstream>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

namespace
{

namespace fs = std::filesystem;

class recording_ui_renderer final : public cata::lua_ui::script_ui_renderer
{
    public:
        cata::lua_ui::script_ui_renderer_info info() const override {
            using capability = cata::lua_ui::script_ui_capability;
            return {
                "recording", "test",
                static_cast<std::uint32_t>( capability::progress_bar ) |
                static_cast<std::uint32_t>( capability::buttons ) |
                static_cast<std::uint32_t>( capability::child_regions ) |
                static_cast<std::uint32_t>( capability::tables ) |
                static_cast<std::uint32_t>( capability::tabs ) |
                static_cast<std::uint32_t>( capability::trees ) |
                static_cast<std::uint32_t>( capability::modals ) |
                static_cast<std::uint32_t>( capability::tooltips ) |
                static_cast<std::uint32_t>( capability::virtualization ) |
                static_cast<std::uint32_t>( capability::radial_selection ) |
                static_cast<std::uint32_t>( capability::action_slots ),
                false, true
            };
        }

        double available_width() const override {
            return 1000.0;
        }

        void text( const std::string &value ) override {
            calls.push_back( "text:" + value );
        }
        void heading( const std::string &value ) override {
            calls.push_back( "heading:" + value );
        }
        void bullet_text( const std::string &value ) override {
            calls.push_back( "bullet:" + value );
        }
        void disabled_text( const std::string &value ) override {
            calls.push_back( "disabled:" + value );
        }
        void text_colored( const std::string &value, double, double, double, double ) override {
            calls.push_back( "colored:" + value );
        }
        void separator() override {
            calls.emplace_back( "separator" );
        }
        void same_line() override {
            calls.emplace_back( "same_line" );
        }
        void new_line() override {
            calls.emplace_back( "new_line" );
        }
        void spacing() override {
            calls.emplace_back( "spacing" );
        }
        void set_next_item_width( double width ) override {
            item_width = width;
        }
        void progress_bar( double fraction,
                           const std::optional<std::string> &overlay ) override {
            progress = fraction;
            progress_overlay = overlay;
        }
        bool button( const std::string &id, const std::string &label ) override {
            calls.push_back( "button:" + id + ":" + label );
            return true;
        }
        bool small_button( const std::string &id, const std::string &label ) override {
            calls.push_back( "small_button:" + id + ":" + label );
            return false;
        }
        bool checkbox( const std::string &id, const std::string &, bool value ) override {
            last_widget_id = id;
            return !value;
        }
        bool radio_button( const std::string &id, const std::string &, bool active ) override {
            last_widget_id = id;
            return !active;
        }
        bool selectable( const std::string &id, const std::string &, bool selected ) override {
            last_widget_id = id;
            return !selected;
        }
        int slider_int( const std::string &id, const std::string &, int, int,
                        int maximum ) override {
            last_widget_id = id;
            return maximum;
        }
        double slider_float( const std::string &id, const std::string &, double, double minimum,
                             double ) override {
            last_widget_id = id;
            return minimum;
        }
        int input_int( const std::string &id, const std::string &, int value ) override {
            last_widget_id = id;
            return value + 1;
        }
        double input_float( const std::string &id, const std::string &, double value ) override {
            last_widget_id = id;
            return value + 0.5;
        }
        std::string input_text( const std::string &id, const std::string &,
                                const std::string &value ) override {
            last_widget_id = id;
            return value + "-edited";
        }
        std::string radial_select(
            const std::string &id, const std::string &,
            const std::vector<cata::lua_ui::script_ui_radial_option> &options ) override {
            last_widget_id = id;
            const auto found = std::find_if( options.begin(), options.end(),
            []( const cata::lua_ui::script_ui_radial_option & option ) {
                return option.enabled && !option.selected;
            } );
            return found == options.end() ? std::string() : found->id;
        }
        std::string action_slot(
            const std::string &id, const std::string &selected_action, int,
            const std::vector<cata::lua_ui::script_ui_action_option> &options ) override {
            last_widget_id = id;
            const auto found = std::find_if( options.begin(), options.end(),
            [&]( const cata::lua_ui::script_ui_action_option & option ) {
                return option.enabled && option.id != selected_action;
            } );
            return found == options.end() ? selected_action : found->id;
        }
        void child( const std::string &id, double,
                    const std::function<void()> &draw ) override {
            calls.push_back( "child_begin:" + id );
            draw();
            calls.push_back( "child_end:" + id );
        }
        void table( const std::string &id, int columns,
                    const std::function<void()> &draw ) override {
            calls.push_back( "table_begin:" + id + ":" + std::to_string( columns ) );
            draw();
            calls.push_back( "table_end:" + id );
        }
        void table_next_row() override {
            calls.emplace_back( "table_row" );
        }
        bool table_next_column() override {
            calls.emplace_back( "table_column" );
            return true;
        }
        void tabs( const std::string &id, const std::function<void()> &draw ) override {
            calls.push_back( "tabs_begin:" + id );
            draw();
            calls.push_back( "tabs_end:" + id );
        }
        bool tab( const std::string &id, const std::string &,
                  const std::function<void()> &draw ) override {
            calls.push_back( "tab:" + id );
            draw();
            return true;
        }
        bool tree( const std::string &id, const std::string &, bool,
                   const std::function<void()> &draw ) override {
            calls.push_back( "tree:" + id );
            draw();
            return true;
        }
        bool modal( const std::string &id, const std::string &, bool open,
                    const std::function<void()> &draw ) override {
            calls.push_back( "modal:" + id );
            if( open ) {
                draw();
            }
            return open;
        }
        void tooltip( const std::string &text ) override {
            calls.push_back( "tooltip:" + text );
        }
        void virtual_list( int item_count, double,
                           const std::function<void( int, int )> &draw_range ) override {
            calls.emplace_back( "virtual_list" );
            draw_range( 0, item_count );
        }

        std::vector<std::string> calls;
        double item_width = 0.0;
        double progress = 0.0;
        std::optional<std::string> progress_overlay;
        std::string last_widget_id;
};

class scoped_lua_user_script
{
    public:
        scoped_lua_user_script() : path_( fs::u8path( PATH_INFO::config_dir() ) / "lua" / "main.lua" ),
            manifest_path_( path_.parent_path() / "manifest.json" ) {
            std::error_code error;
            fs::create_directories( path_.parent_path(), error );
            if( error ) {
                throw std::runtime_error( "Unable to create Lua test directory: " + error.message() );
            }
            if( fs::exists( path_ ) ) {
                std::ifstream input( path_, std::ios::binary );
                if( !input ) {
                    throw std::runtime_error( "Unable to read existing user Lua script" );
                }
                previous_ = std::string( std::istreambuf_iterator<char>( input ),
                                         std::istreambuf_iterator<char>() );
            }
            if( fs::exists( manifest_path_ ) ) {
                std::ifstream input( manifest_path_, std::ios::binary );
                if( !input ) {
                    throw std::runtime_error( "Unable to read existing user Lua manifest" );
                }
                previous_manifest_ = std::string( std::istreambuf_iterator<char>( input ),
                                                  std::istreambuf_iterator<char>() );
            }
            cata::lua_ui::shutdown();
        }

        scoped_lua_user_script( const scoped_lua_user_script & ) = delete;
        scoped_lua_user_script &operator=( const scoped_lua_user_script & ) = delete;

        ~scoped_lua_user_script() {
            cata::lua_ui::shutdown();
            if( previous_ ) {
                std::ofstream output( path_, std::ios::binary | std::ios::trunc );
                output << *previous_;
            } else {
                std::error_code error;
                fs::remove( path_, error );
            }
            if( previous_manifest_ ) {
                std::ofstream output( manifest_path_, std::ios::binary | std::ios::trunc );
                output << *previous_manifest_;
            } else {
                std::error_code error;
                fs::remove( manifest_path_, error );
            }
        }

        void write( const std::string &source ) const {
            std::ofstream output( path_, std::ios::binary | std::ios::trunc );
            output << source;
            if( !output ) {
                throw std::runtime_error( "Unable to write user Lua test script" );
            }
        }

        void write_manifest( const std::string &source ) const {
            std::ofstream output( manifest_path_, std::ios::binary | std::ios::trunc );
            output << source;
            if( !output ) {
                throw std::runtime_error( "Unable to write user Lua test manifest" );
            }
        }

    private:
        fs::path path_;
        fs::path manifest_path_;
        std::optional<std::string> previous_;
        std::optional<std::string> previous_manifest_;
};

class scoped_lua_user_module
{
    public:
        explicit scoped_lua_user_module( const fs::path &relative_path ) :
            path_( fs::u8path( PATH_INFO::config_dir() ) / "lua" / relative_path ) {
            std::error_code error;
            fs::create_directories( path_.parent_path(), error );
            if( error ) {
                throw std::runtime_error(
                    "Unable to create Lua module test directory: " + error.message() );
            }
            if( fs::exists( path_ ) ) {
                std::ifstream input( path_, std::ios::binary );
                previous_ = std::string( std::istreambuf_iterator<char>( input ),
                                         std::istreambuf_iterator<char>() );
                if( !input ) {
                    throw std::runtime_error( "Unable to read existing Lua module" );
                }
            }
        }

        scoped_lua_user_module( const scoped_lua_user_module & ) = delete;
        scoped_lua_user_module &operator=( const scoped_lua_user_module & ) = delete;

        ~scoped_lua_user_module() {
            if( previous_ ) {
                std::ofstream output( path_, std::ios::binary | std::ios::trunc );
                output << *previous_;
            } else {
                std::error_code error;
                fs::remove( path_, error );
            }
        }

        void write( const std::string &source ) const {
            std::ofstream output( path_, std::ios::binary | std::ios::trunc );
            output << source;
            if( !output ) {
                throw std::runtime_error( "Unable to write Lua test module" );
            }
        }

    private:
        fs::path path_;
        std::optional<std::string> previous_;
};

class scoped_calendar_turn
{
    public:
        scoped_calendar_turn() : previous_( calendar::turn ) {}
        scoped_calendar_turn( const scoped_calendar_turn & ) = delete;
        scoped_calendar_turn &operator=( const scoped_calendar_turn & ) = delete;
        ~scoped_calendar_turn() {
            calendar::turn = previous_;
        }

        time_point original() const {
            return previous_;
        }

    private:
        time_point previous_;
};

class scoped_lua_state_file
{
    public:
        scoped_lua_state_file() : scoped_lua_state_file(
                ( PATH_INFO::player_base_save_path() +
                  ".lua_ui.json" ).get_unrelative_path() ) {}

        explicit scoped_lua_state_file( fs::path path ) : path_( std::move( path ) ) {
            if( fs::exists( path_ ) ) {
                std::ifstream input( path_, std::ios::binary );
                previous_ = std::string( std::istreambuf_iterator<char>( input ),
                                         std::istreambuf_iterator<char>() );
                if( !input ) {
                    throw std::runtime_error( "Unable to read existing Lua state file" );
                }
            }
        }

        scoped_lua_state_file( const scoped_lua_state_file & ) = delete;
        scoped_lua_state_file &operator=( const scoped_lua_state_file & ) = delete;

        ~scoped_lua_state_file() {
            if( previous_ ) {
                std::ofstream output( path_, std::ios::binary | std::ios::trunc );
                output << *previous_;
            } else {
                std::error_code error;
                fs::remove( path_, error );
            }
        }

        void write( const std::string &contents ) const {
            std::ofstream output( path_, std::ios::binary | std::ios::trunc );
            output << contents;
            if( !output ) {
                throw std::runtime_error( "Unable to write Lua state test file" );
            }
        }

        bool exists() const {
            return fs::exists( path_ );
        }

        std::string read() const {
            std::ifstream input( path_, std::ios::binary );
            const std::string result{
                std::istreambuf_iterator<char>( input ),
                std::istreambuf_iterator<char>()
            };
            if( !input ) {
                throw std::runtime_error( "Unable to read Lua state test file" );
            }
            return result;
        }

    private:
        fs::path path_;
        std::optional<std::string> previous_;
};

} // namespace

TEST_CASE( "lua_ui_context_uses_a_platform_neutral_renderer", "[lua][ui][renderer]" )
{
    recording_ui_renderer renderer;
    cata::lua_ui::script_ui_context context( renderer );

    CHECK( context.backend() == "recording" );
    CHECK( context.platform() == "test" );
    CHECK_FALSE( context.is_immediate_mode() );
    CHECK( context.uses_native_widgets() );
    const cata::lua_ui::script_ui_environment environment = context.environment();
    const cata::ui::profile profile = cata::ui::current_profile();
    CHECK( environment.profile == profile.id );
    CHECK( environment.input == std::string( cata::ui::input_mode_name( profile.input ) ) );
    CHECK( environment.density == std::string( cata::ui::density_mode_name( profile.density ) ) );
    CHECK( environment.breakpoint == std::string( cata::ui::layout_breakpoint_name(
                profile.breakpoint_for_width( 1000.0F ) ) ) );
    CHECK( environment.minimum_target == profile.minimum_target );
    CHECK( environment.touch == profile.is_touch() );
    CHECK( environment.hover == profile.allow_hover );
    CHECK( environment.swipe_scroll == profile.allow_swipe );
    CHECK( environment.keyboard_navigation == profile.keyboard_navigation );
    CHECK( environment.long_press_dangerous == profile.long_press_dangerous );
    CHECK( context.supports( "progress_bar" ) );
    CHECK( context.supports( "buttons" ) );
    CHECK( context.supports( "tables" ) );
    CHECK( context.supports( "virtualization" ) );
    CHECK( context.supports( "radial_selection" ) );
    CHECK( context.supports( "action_slots" ) );
    CHECK_FALSE( context.supports( "text_input" ) );
    CHECK_FALSE( context.supports( "unknown" ) );

    context.text( "hello" );
    context.heading( "section" );
    context.set_next_item_width( 240.0 );
    context.progress_bar( 0.75, std::string( "75%" ) );

    CHECK( renderer.calls[0] == "text:hello" );
    CHECK( renderer.calls[1] == "heading:section" );
    CHECK( renderer.item_width == 240.0 );
    CHECK( renderer.progress == 0.75 );
    REQUIRE( renderer.progress_overlay );
    CHECK( *renderer.progress_overlay == "75%" );

    context.item_width( "normal" );
    CHECK( renderer.item_width == cata::ui::current_profile().width_normal );
    context.text_tone( "ready", "good" );
    CHECK( renderer.calls.back() == "colored:ready" );
    CHECK_THROWS_AS( context.item_width( "pixels" ), std::invalid_argument );
    CHECK_THROWS_AS( context.text_tone( "bad tone", "purple" ), std::invalid_argument );

    CHECK( context.button( "apply" ) );
    CHECK_FALSE( context.small_button( "add" ) );
    CHECK_FALSE( context.checkbox( "enabled", true ) );
    CHECK( context.radio_button( "mode", false ) );
    CHECK( context.selectable( "entry", false ) );
    CHECK( context.slider_int( "count", 5, 0, 100 ) == 100 );
    CHECK( context.slider_float( "ratio", 0.5, 0.25, 1.0 ) == 0.25 );
    CHECK( context.input_int( "count", 5 ) == 6 );
    CHECK( context.input_float( "ratio", 0.5 ) == 1.0 );
    CHECK( context.input_text( "name", "value" ) == "value-edited" );
    const std::vector<cata::lua_ui::script_ui_radial_option> radial_options = {
        { "walk", "Walk", true, true },
        { "run", "Run", true, false }
    };
    CHECK( context.radial_select_id( "movement", "Walk", radial_options ) == "run" );
    CHECK( renderer.last_widget_id == "movement" );
    const std::vector<cata::lua_ui::script_ui_action_option> action_options = {
        { "pickup", "Pickup", true, false, {} },
        { "drop", "Drop", true, false, {} }
    };
    CHECK( context.action_slot_id( "ground", "pickup", 4, action_options ) == "drop" );
    CHECK( renderer.last_widget_id == "ground" );

    CHECK( context.button_id( "apply_action", "Apply translated" ) );
    CHECK( renderer.calls.back() == "button:apply_action:Apply translated" );
    CHECK_FALSE( context.checkbox_id( "feature_enabled", "Enabled translated", true ) );
    CHECK( renderer.last_widget_id == "feature_enabled" );
    CHECK( context.slider_int_id( "amount", "Amount translated", 5, 0, 100 ) == 100 );
    CHECK( renderer.last_widget_id == "amount" );
    CHECK( context.input_text_id( "player_name", "Name translated", "value" ) ==
           "value-edited" );
    CHECK( renderer.last_widget_id == "player_name" );

    context.child( "details", 120.0, [&context]() {
        context.text( "inside child" );
    } );
    context.scroll( "semantic_scroll", "normal", [&context]() {
        context.text( "inside semantic scroll" );
    } );
    context.grid( "responsive_grid", 1, 2, 3, [&context]() {
        context.table_next_row();
        CHECK( context.table_next_column() );
    } );
    const int responsive_columns =
        profile.breakpoint_for_width( 1000.0F ) == cata::ui::layout_breakpoint::narrow ? 1 :
        profile.breakpoint_for_width( 1000.0F ) == cata::ui::layout_breakpoint::wide ? 3 : 2;
    CHECK( std::find( renderer.calls.begin(), renderer.calls.end(),
                      "table_begin:responsive_grid:" +
                      std::to_string( responsive_columns ) ) != renderer.calls.end() );
    context.table( "stats", 2, [&context]() {
        context.table_next_row();
        CHECK( context.table_next_column() );
        context.text( "cell" );
    } );
    context.tabs( "sections", [&context]() {
        CHECK( context.tab( "first", "First", [&context]() {
            context.text( "tab body" );
        } ) );
    } );
    CHECK( context.tree( "advanced", "Advanced", true, [&context]() {
        context.text( "tree body" );
    } ) );
    CHECK( context.modal( "confirm", "Confirm", true, [&context]() {
        context.text( "modal body" );
    } ) );
    context.tooltip( "help" );
    int virtual_items = 0;
    context.virtual_list( 5, 20.0, [&virtual_items]( int first, int last ) {
        virtual_items += last - first;
    } );
    context.virtual_list_rows( 3, "normal", [&virtual_items]( int first, int last ) {
        virtual_items += last - first;
    } );
    CHECK( virtual_items == 8 );
    CHECK_THROWS_AS( context.table( "bad", 0, []() {} ), std::invalid_argument );
    CHECK_THROWS_AS( context.virtual_list( -1, 1.0, []( int, int ) {} ),
    std::invalid_argument );

    const std::size_t call_count = renderer.calls.size();
    context.invalidate();
    CHECK_THROWS_AS( context.backend(), std::runtime_error );
    CHECK_THROWS_AS( context.text( "after draw" ), std::runtime_error );
    CHECK( renderer.calls.size() == call_count );
}

TEST_CASE( "input_context_actions_are_revision_bound_bounded_and_non_destructive",
           "[lua][ui][actions][input_context]" )
{
    using namespace cata::input_context_actions;
    cata::input_context_actions::clear();
    publish( "DEFAULTMODE", "gameplay", "Gameplay", {
        { "pickup", "Pickup", {}, false, false },
        { "DELETE_WORLD", "Delete world", {}, false, false },
        { "delete_character", "Delete character", {}, false, false },
        { "ANY_INPUT", "Any input", {}, false, false },
        { "any_input", "Any input lower case", {}, false, false }
    } );
    const context_snapshot first = snapshot();
    CHECK( first.category == "DEFAULTMODE" );
    CHECK( first.hud_scene_id == "gameplay" );
    CHECK( first.hud_scene_title == "Gameplay" );
    CHECK( first.revision > 0 );
    REQUIRE( first.actions.size() == 3 );
    CHECK_FALSE( first.actions[0].dangerous );
    CHECK( first.actions[1].dangerous );
    CHECK( first.actions[2].dangerous );
    CHECK_FALSE( needs_publish(
                     "DEFAULTMODE",
                     "gameplay",
                     "Gameplay",
    { "pickup", "DELETE_WORLD", "delete_character", "ANY_INPUT", "any_input" },
    0,
    0 ) );
    CHECK( needs_publish(
               "DEFAULTMODE",
               "gameplay",
               "Gameplay",
    { "pickup", "DELETE_WORLD", "delete_character", "ANY_INPUT", "any_input" },
    0,
    1 ) );
    CHECK_FALSE( enqueue( "delete_character", first.revision ) );

    publish( "DEFAULTMODE", "gameplay", "Gameplay", {
        { "pickup", "Pickup", {}, false, false },
        { "DELETE_WORLD", "Delete world", {}, false, false },
        { "delete_character", "Delete character", {}, false, false },
        { "ANY_INPUT", "Any input", {}, false, false },
        { "any_input", "Any input lower case", {}, false, false }
    } );
    CHECK( snapshot().revision == first.revision );
    CHECK_FALSE( enqueue( "pickup", first.revision + 1 ) );
    CHECK_FALSE( enqueue( "DELETE_WORLD", first.revision ) );
    CHECK( validate_candidates(
               first.revision, { "pickup", "DELETE_WORLD", "missing" } ) ==
           std::vector<bool> { true, true, false } );
    REQUIRE( enqueue( "DELETE_WORLD", first.revision, true ) );
    std::string action;
    REQUIRE( consume( { "DELETE_WORLD" }, action ) );
    CHECK( action == "DELETE_WORLD" );
    CHECK( validate_candidates(
               first.revision + 1, { "pickup" } ) ==
           std::vector<bool> { false } );
    REQUIRE( enqueue( "pickup", first.revision ) );

    CHECK_FALSE( consume( { "inventory" }, action ) );
    REQUIRE( enqueue( "pickup", first.revision ) );
    REQUIRE( consume( { "pickup", "inventory" }, action ) );
    CHECK( action == "pickup" );

    for( int index = 0; index < 16; ++index ) {
        REQUIRE( enqueue( "pickup", first.revision ) );
    }
    CHECK_FALSE( enqueue( "pickup", first.revision ) );
    for( int index = 0; index < 16; ++index ) {
        REQUIRE( consume( { "pickup" }, action ) );
    }
    CHECK_FALSE( has_pending() );

    REQUIRE( enqueue( "pickup", first.revision ) );
    publish( "DEFAULTMODE", "gameplay", "Gameplay", {
        { "pickup", "Pick up", {}, false, false }
    } );
    CHECK( snapshot().revision != first.revision );
    CHECK_FALSE( has_pending() );

    const int action_revision = snapshot().revision;
    publish( "UILIST", "inventory.items", "Inventory", {
        { "CONFIRM", "Confirm", {}, false, false }
    } );
    CHECK( snapshot().revision != action_revision );
    CHECK( snapshot().category == "UILIST" );
    CHECK( snapshot().hud_scene_id == "inventory.items" );
    cata::input_context_actions::clear();
}

TEST_CASE( "lua_module_names_stay_inside_script_roots", "[lua][ui][sandbox]" )
{
    using cata::lua_ui::is_safe_module_name;
    using cata::lua_ui::maximum_module_name_bytes;

    CHECK( is_safe_module_name( "widgets" ) );
    CHECK( is_safe_module_name( "lib.widgets.hud-v2" ) );

    CHECK_FALSE( is_safe_module_name( "" ) );
    CHECK_FALSE( is_safe_module_name( ".hidden" ) );
    CHECK_FALSE( is_safe_module_name( "hidden." ) );
    CHECK_FALSE( is_safe_module_name( "../outside" ) );
    CHECK_FALSE( is_safe_module_name( "lib..outside" ) );
    CHECK_FALSE( is_safe_module_name( "lib/widgets" ) );
    CHECK_FALSE( is_safe_module_name( "C:\\outside" ) );
    CHECK( is_safe_module_name(
               std::string( maximum_module_name_bytes, 'm' ) ) );
    CHECK_FALSE( is_safe_module_name(
                     std::string( maximum_module_name_bytes + 1, 'm' ) ) );
}

TEST_CASE( "lua_script_manifests_validate_versions_capabilities_and_dependencies",
           "[lua][ui][manifest]" )
{
    using namespace cata::lua_ui;

    const script_manifest base = read_script_manifest( json_loader::from_string( R"json({
        "id": "base", "version": "1.0.0", "api_version": 2,
        "capabilities": [ "game.read", "ui.pages" ], "dependencies": []
    })json" ) );
    CHECK( base.id == "base" );
    CHECK( base.version == "1.0.0" );
    CHECK( base.api_version == 2 );
    CHECK( base.has_capability( "game.read" ) );
    CHECK_FALSE( base.has_capability( "game.actions" ) );

    script_manifest extension = read_script_manifest( json_loader::from_string( R"json({
        "id": "extension", "version": "2", "api_version": 2,
        "capabilities": [ "events" ], "dependencies": [ "base" ]
    })json" ) );
    CHECK_NOTHROW( validate_script_manifests( { base, extension } ) );
    CHECK_THROWS( validate_script_manifests( { extension, base } ) );

    const script_manifest v3 = read_script_manifest( json_loader::from_string( R"json({
        "id": "v3", "version": "3", "api_version": 3,
        "capabilities": [ "ui.pages" ], "dependencies": []
    })json" ) );
    CHECK( v3.api_version == 3 );
    const script_manifest v4 = read_script_manifest( json_loader::from_string( R"json({
        "id": "v4", "version": "4", "api_version": 4,
        "capabilities": [ "modules.import", "scheduler", "services.consume" ],
        "dependencies": []
    })json" ) );
    CHECK( v4.api_version == 4 );
    const script_manifest v5 = read_script_manifest( json_loader::from_string( R"json({
        "id": "v5", "version": "5", "api_version": 5,
        "capabilities": [
            "events", "game.callbacks", "game.hooks", "game.read", "game.write"
        ],
        "dependencies": []
    })json" ) );
    CHECK( v5.api_version == api_version );

    extension.dependencies = { "missing" };
    CHECK_THROWS( validate_script_manifests( { base, extension } ) );
    CHECK_THROWS( read_script_manifest( json_loader::from_string( R"json({
        "id": "bad", "version": "1", "api_version": 999,
        "capabilities": [], "dependencies": []
    })json" ) ) );
    CHECK_THROWS( read_script_manifest( json_loader::from_string( R"json({
        "id": "bad", "version": "1", "api_version": 2,
        "capabilities": [ "native.pointers" ], "dependencies": []
    })json" ) ) );
    CHECK_THROWS( read_script_manifest( json_loader::from_string( R"json({
        "id": "removed-hud", "version": "1", "api_version": 3,
        "capabilities": [ "ui.hud" ], "dependencies": []
    })json" ) ) );
    CHECK_THROWS( read_script_manifest( json_loader::from_string( R"json({
        "id": "old-scheduler", "version": "1", "api_version": 3,
        "capabilities": [ "scheduler" ], "dependencies": []
    })json" ) ) );
    CHECK_THROWS( read_script_manifest( json_loader::from_string( R"json({
        "id": "dangerous-without-actions", "version": "1", "api_version": 4,
        "capabilities": [ "game.actions.dangerous" ], "dependencies": []
    })json" ) ) );
    CHECK_THROWS( read_script_manifest( json_loader::from_string( R"json({
        "id": "write-without-read", "version": "1", "api_version": 5,
        "capabilities": [ "game.write" ], "dependencies": []
    })json" ) ) );
    CHECK_THROWS( read_script_manifest( json_loader::from_string( R"json({
        "id": "hooks-without-events", "version": "1", "api_version": 5,
        "capabilities": [ "game.hooks" ], "dependencies": []
    })json" ) ) );
    CHECK_THROWS( read_script_manifest( json_loader::from_string( R"json({
        "id": "callbacks-without-read", "version": "1", "api_version": 5,
        "capabilities": [ "game.callbacks" ], "dependencies": []
    })json" ) ) );
    CHECK_THROWS( read_script_manifest( json_loader::from_string( R"json({
        "id": "old-writer", "version": "1", "api_version": 4,
        "capabilities": [ "game.read", "game.write" ], "dependencies": []
    })json" ) ) );
    CHECK( capability_minimum_api_version( "scheduler" ) == 4 );
    CHECK( capability_minimum_api_version( "game.write" ) == 5 );
    CHECK( capability_minimum_api_version( "game.read" ) == minimum_api_version );
}

TEST_CASE( "lua_v4_modules_are_source_scoped_and_dependency_gated",
           "[lua][modules][sandbox]" )
{
    using cata::lua_ui::script_manifest;
    using cata::lua_ui::script_module_resolver;
    using cata::lua_ui::script_module_source;

    const fs::path builtin_root = fs::u8path( PATH_INFO::datadir() ) / "lua";
    const fs::path empty_root = fs::u8path( PATH_INFO::config_dir() ) / "lua";

    script_manifest builtin;
    builtin.id = "builtin";
    builtin.version = "4";
    builtin.api_version = 4;

    script_manifest consumer;
    consumer.id = "consumer";
    consumer.version = "4";
    consumer.api_version = 4;
    consumer.dependencies = { "builtin" };

    script_module_resolver resolver( {
        script_module_source{ builtin, builtin_root },
        script_module_source{ consumer, empty_root }
    } );

    CHECK_FALSE( resolver.resolve_local( 1, "ui.profiles.pc_legacy" ) );
    const auto imported =
        resolver.resolve_import( 1, "builtin", "ui.profiles.pc_legacy" );
    REQUIRE( imported );
    CHECK( imported->source_index == 0 );
    CHECK( imported->cache_key == "builtin:ui.profiles.pc_legacy" );
    CHECK_FALSE( resolver.resolve_import( 1, "missing_mod",
                                          "ui.profiles.pc_legacy" ) );
    CHECK_FALSE( resolver.resolve_local( 1, "../escape" ) );

    consumer.dependencies.clear();
    script_module_resolver builtin_is_implicit( {
        script_module_source{ builtin, builtin_root },
        script_module_source{ consumer, empty_root }
    } );
    CHECK( builtin_is_implicit.resolve_import( 1, "builtin",
            "ui.profiles.pc_legacy" ) );

    script_manifest provider = builtin;
    provider.id = "provider";
    script_module_resolver undeclared_provider( {
        script_module_source{ provider, builtin_root },
        script_module_source{ consumer, empty_root }
    } );
    CHECK_FALSE( undeclared_provider.resolve_import(
                     1, "provider", "ui.profiles.pc_legacy" ) );

    consumer.api_version = 3;
    script_module_resolver legacy( {
        script_module_source{ builtin, builtin_root },
        script_module_source{ consumer, empty_root }
    } );
    CHECK( legacy.resolve_local( 1, "ui.profiles.pc_legacy" ) );
}

TEST_CASE( "lua_turn_scheduler_is_bounded_stable_and_source_owned",
           "[lua][scheduler]" )
{
    using cata::lua_ui::deterministic_turn_scheduler;

    deterministic_turn_scheduler scheduler;
    const std::uint64_t later = scheduler.schedule_after( 100, 10, 1 );
    const std::uint64_t first = scheduler.schedule_after( 100, 5, 1 );
    const std::uint64_t second = scheduler.schedule_after( 100, 5, 2 );
    const std::uint64_t repeating = scheduler.schedule_every( 100, 3, 1 );

    CHECK( scheduler.take_due( 102 ).empty() );
    auto due = scheduler.take_due( 103 );
    REQUIRE( due.size() == 1 );
    CHECK( due[0].id == repeating );
    CHECK( scheduler.contains( repeating ) );

    due = scheduler.take_due( 105 );
    REQUIRE( due.size() == 2 );
    CHECK( due[0].id == first );
    CHECK( due[1].id == second );
    CHECK_FALSE( scheduler.contains( first ) );
    CHECK_FALSE( scheduler.cancel( second, 2 ) );

    CHECK_FALSE( scheduler.cancel( later, 2 ) );
    CHECK( scheduler.cancel( later, 1 ) );
    CHECK( scheduler.cancel( repeating, 1 ) );
    CHECK( scheduler.size() == 0 );

    CHECK_THROWS_AS( scheduler.schedule_after( 0, 0, 1 ),
                     std::invalid_argument );
    CHECK_THROWS_AS( scheduler.schedule_every(
                         0, deterministic_turn_scheduler::maximum_delay_turns + 1, 1 ),
                     std::invalid_argument );
}

TEST_CASE( "lua_event_subscriptions_are_priority_stable_and_source_owned",
           "[lua][events]" )
{
    using cata::lua_ui::script_event_registry;

    script_event_registry registry;
    const std::uint64_t normal = registry.subscribe( "game:avatar_moves", 0, 1, false );
    const std::uint64_t high_first =
        registry.subscribe( "game:avatar_moves", 50, 1, false );
    const std::uint64_t high_second =
        registry.subscribe( "game:avatar_moves", 50, 2, true );
    registry.subscribe( "custom:other:event", 100, 2, false );

    const auto matching = registry.matching( "game:avatar_moves" );
    REQUIRE( matching.size() == 3 );
    CHECK( matching[0].id == high_first );
    CHECK( matching[1].id == high_second );
    CHECK( matching[2].id == normal );
    CHECK( matching[1].once );

    CHECK_FALSE( registry.unsubscribe( high_second, 1 ) );
    CHECK( registry.unsubscribe( high_second, 2 ) );
    CHECK_FALSE( registry.contains( high_second ) );
    CHECK( registry.unsubscribe_unchecked( normal ) );
    CHECK_THROWS_AS(
        registry.subscribe( "event", script_event_registry::maximum_priority + 1,
                            1, false ),
        std::invalid_argument );
    CHECK( cata::lua_ui::is_safe_custom_event_segment( "quest.completed" ) );
    CHECK_FALSE( cata::lua_ui::is_safe_custom_event_segment( "../escape" ) );
    CHECK( cata::lua_ui::is_lifecycle_event_name(
               "ccb.lifecycle.world_ready" ) );
}

TEST_CASE( "lua_service_registry_is_bounded_versioned_and_provider_safe",
           "[lua][services]" )
{
    using namespace cata::lua_ui;

    script_service_registry registry;
    registry.provide( {
        "mod:provider", "quest.api", 2, 1, { "get", "update" }
    } );
    REQUIRE( registry.size() == 1 );
    const script_service_definition *service =
        registry.find( "mod:provider", "quest.api" );
    REQUIRE( service != nullptr );
    CHECK( service->version == 2 );
    CHECK( service->methods == std::vector<std::string> { "get", "update" } );

    registry.provide( {
        "mod:provider", "quest.api", 3, 1, { "get" }
    } );
    REQUIRE( registry.size() == 1 );
    service = registry.find( "mod:provider", "quest.api" );
    REQUIRE( service != nullptr );
    CHECK( service->version == 3 );
    CHECK( service->methods == std::vector<std::string> { "get" } );

    CHECK( is_safe_service_provider_identifier( "author:story_mod" ) );
    CHECK_FALSE( is_safe_service_identifier( "author:story_mod" ) );
    CHECK_THROWS_AS(
        registry.provide( { "../provider", "service", 1, 0, { "call" } } ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        registry.provide( { "provider", "service", 0, 0, { "call" } } ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        registry.provide( { "provider", "service", 1, 0, { "same", "same" } } ),
        std::invalid_argument );
}

TEST_CASE( "lua_i18n_api_returns_owned_translations_and_validates_plural_counts",
           "[lua][ui][i18n]" )
{
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    cata::lua_ui::install_i18n_api( lua );

    const sol::table i18n = lua["i18n"];
    REQUIRE( i18n.valid() );

    sol::protected_function lua_gettext = i18n["gettext"];
    sol::protected_function_result translated = lua_gettext( "Lua UI test message" );
    REQUIRE( translated.valid() );
    CHECK_FALSE( translated.get<std::string>().empty() );

    sol::protected_function lua_pgettext = i18n["pgettext"];
    translated = lua_pgettext( "Lua UI test context", "Lua UI contextual message" );
    REQUIRE( translated.valid() );
    CHECK_FALSE( translated.get<std::string>().empty() );

    sol::protected_function lua_ngettext = i18n["ngettext"];
    translated = lua_ngettext( "Lua UI item", "Lua UI items", std::int64_t{ 2 } );
    REQUIRE( translated.valid() );
    CHECK_FALSE( translated.get<std::string>().empty() );

    const sol::protected_function_result invalid_plural =
        lua_ngettext( "Lua UI item", "Lua UI items", std::int64_t{ -1 } );
    REQUIRE_FALSE( invalid_plural.valid() );
    const sol::error plural_error = invalid_plural;
    CHECK( std::string( plural_error.what() ).find( "cannot be negative" ) !=
           std::string::npos );

    sol::protected_function language_revision = i18n["language_revision"];
    const sol::protected_function_result revision = language_revision();
    REQUIRE( revision.valid() );
    CHECK( revision.get<int>() >= 0 );
}

TEST_CASE( "lua_binding_catalog_is_unique_capability_scoped_and_detached",
           "[lua][ui][bindings]" )
{
    using namespace cata::lua_ui;

    const std::vector<binding_domain> &catalog = binding_catalog();
    REQUIRE( catalog.size() == 14 );
    std::vector<std::string_view> ids;
    ids.reserve( catalog.size() );
    for( const binding_domain &domain : catalog ) {
        CHECK_FALSE( domain.id.empty() );
        CHECK_FALSE( domain.lua_namespace.empty() );
        CHECK( supported_script_capabilities().count( std::string( domain.capability ) ) == 1 );
        CHECK( domain.minimum_api_version >=
               capability_minimum_api_version( domain.capability ) );
        CHECK_FALSE( binding_status_name( domain.status ).empty() );
        ids.push_back( domain.id );
    }
    std::sort( ids.begin(), ids.end() );
    CHECK( std::adjacent_find( ids.begin(), ids.end() ) == ids.end() );
    CHECK( find_binding_domain( "coordinates" ) != nullptr );
    CHECK( find_binding_domain( "missing" ) == nullptr );
    CHECK( binding_domain_is_covered( "coordinates" ) );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table );
    sol::table game = lua.create_named_table( "game" );
    bool authorized = false;
    install_binding_catalog_api( game, [&authorized]() {
        if( !authorized ) {
            throw std::runtime_error( "catalog capability denied" );
        }
    } );

    sol::protected_function api_catalog = game["api_catalog"];
    sol::protected_function_result denied = api_catalog();
    CHECK_FALSE( denied.valid() );

    authorized = true;
    sol::protected_function_result first_result = api_catalog();
    REQUIRE( first_result.valid() );
    sol::table first = first_result;
    REQUIRE( first.size() == catalog.size() );
    sol::table first_entry = first[1];
    const std::string original_id = first_entry["id"];
    first_entry["id"] = "mutated";
    first_entry["status"] = "covered";

    sol::protected_function_result second_result = api_catalog();
    REQUIRE( second_result.valid() );
    sol::table second = second_result;
    sol::table second_entry = second[1];
    CHECK( second_entry.get<std::string>( "id" ) == original_id );
    CHECK( second_entry.get<std::string>( "status" ) != "covered" );

    sol::protected_function api_supports = game["api_supports"];
    CHECK( api_supports( "coordinates" ).get<bool>() );
    CHECK_FALSE( api_supports( "missing" ).get<bool>() );
}

TEST_CASE( "lua_game_handles_reject_stale_destroyed_and_wrong_kind_references",
           "[lua][bindings][handles]" )
{
    using namespace cata::lua_ui;

    constexpr std::size_t runtime_generation = 17;
    constexpr std::size_t world_generation = 23;
    game_handle_locator locator{ "test", 42, 1, 2, 3, { 4, 5 } };
    auto value = std::make_unique<item>();
    game_handle handle = game_handle::from_item(
                             *value, locator, runtime_generation, world_generation );

    native_handle_result<item> resolved =
        handle.resolve_item( runtime_generation, world_generation );
    REQUIRE( resolved );
    CHECK( resolved.value == value.get() );
    CHECK_FALSE( resolved.error );

    const native_handle_result<Creature> wrong =
        handle.resolve_creature( runtime_generation, world_generation );
    REQUIRE_FALSE( wrong );
    REQUIRE( wrong.error );
    CHECK( wrong.error->code == "wrong_kind" );

    resolved = handle.resolve_item( runtime_generation + 1, world_generation );
    REQUIRE_FALSE( resolved );
    REQUIRE( resolved.error );
    CHECK( resolved.error->code == "stale_runtime" );

    resolved = handle.resolve_item( runtime_generation, world_generation + 1 );
    REQUIRE_FALSE( resolved );
    REQUIRE( resolved.error );
    CHECK( resolved.error->code == "stale_world" );

    value.reset();
    resolved = handle.resolve_item( runtime_generation, world_generation );
    REQUIRE_FALSE( resolved );
    REQUIRE( resolved.error );
    CHECK( resolved.error->code == "destroyed" );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table );
    sol::table game = lua.create_named_table( "game" );
    std::size_t current_runtime = runtime_generation;
    std::size_t current_world = world_generation;
    install_game_handle_api(
        lua, game,
    [&current_runtime]() {
        return current_runtime;
    },
    [&current_world]() {
        return current_world;
    },
    []() {} );

    auto live_value = std::make_unique<item>();
    lua["test_handle"] = game_handle::from_item(
                             *live_value, locator, runtime_generation, world_generation );
    sol::protected_function_result script = lua.safe_script( R"lua(
assert(test_handle.kind == "item")
local locator = test_handle:locator()
assert(locator.scope == "test")
assert(locator.stable_id == 42)
assert(locator.position.x == 1)
assert(locator.position.y == 2)
assert(locator.position.z == 3)
assert(locator.path[1] == 4 and locator.path[2] == 5)
locator.scope = "mutated"
assert(test_handle:locator().scope == "test")
local status = test_handle:status()
assert(status.ok == true)
assert(status.value.kind == "item")
)lua" );
    REQUIRE( script.valid() );

    ++current_runtime;
    script = lua.safe_script( R"lua(
assert(test_handle:is_valid() == false)
local status = test_handle:status()
assert(status.ok == false)
assert(status.value == nil)
assert(status.error.code == "stale_runtime")
assert(type(status.error.message) == "string")
)lua" );
    REQUIRE( script.valid() );
}

TEST_CASE( "lua_top_level_handles_use_the_committed_runtime_generation",
           "[lua][bindings][handles][integration]" )
{
    scoped_calendar_turn turn;
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read", "scheduler" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local runtime = game.runtime_status()
assert(runtime.generation > 0)
assert(math.type(runtime.world_generation) == "integer")
local player = game.handles.avatar()
assert(player.kind == "creature")
assert(player:is_valid() == true)
scheduler.after(1, function()
    assert(player:is_valid() == true)
    local status = player:status()
    assert(status.ok == true)
    assert(status.value.kind == "creature")
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    const cata::lua_ui::runtime_status loaded = cata::lua_ui::status();
    CHECK( loaded.generation > 0 );
    calendar::turn = turn.original() + 1_turns;
    cata::lua_ui::on_turn();
    CHECK( cata::lua_ui::status().last_error.empty() );
}

TEST_CASE( "lua_v5_creature_queries_return_bounded_handles_and_snapshots",
           "[lua][bindings][creatures][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local avatar = game.creatures.avatar()
assert(avatar.kind == "creature")
assert(avatar:is_valid())

local result = game.creatures.snapshot(avatar)
assert(result.ok == true)
local snapshot = result.value
assert(snapshot.kind == "avatar")
assert(type(snapshot.name) == "string")
assert(type(snapshot.display_name) == "string")
assert(snapshot.position.origin == "abs")
assert(snapshot.position.scale == "ms")
assert(math.type(snapshot.position.x) == "integer")
assert(type(snapshot.visible) == "boolean")
assert(math.type(snapshot.distance) == "integer")
assert(type(snapshot.attitude) == "string")
assert(type(snapshot.dead) == "boolean")
assert(type(snapshot.hallucination) == "boolean")
assert(math.type(snapshot.hp) == "integer")
assert(math.type(snapshot.hp_max) == "integer")
assert(math.type(snapshot.hp_percent) == "integer")
assert(math.type(snapshot.moves) == "integer")
assert(math.type(snapshot.effect_count) == "integer")
assert(type(snapshot.size) == "string")

local nearby = game.creatures.nearby({
    radius = 0,
    limit = 4,
    visible_only = false,
    include_avatar = true
})
assert(nearby.radius == 0)
assert(nearby.limit == 4)
assert(nearby.returned == #nearby.items)
assert(nearby.total >= 1)
assert(nearby.truncated == (nearby.returned < nearby.total))
assert(nearby.items[1].handle:is_valid())
assert(type(nearby.items[1].snapshot.kind) == "string")

local capped = game.creatures.nearby({
    radius = 1000000,
    limit = 1000000,
    visible_only = false
})
assert(capped.radius == 60)
assert(capped.limit == 256)

local at_position = game.creatures.at(snapshot.position)
assert(at_position.ok == true)
assert(at_position.value:is_valid())
assert(game.creatures.snapshot(at_position.value).value.kind == "avatar")

local relative = game.coords.tripoint_rel_ms(0, 0, 0)
assert(pcall(function()
    game.creatures.at(relative)
end) == false)
assert(pcall(function()
    game.creatures.nearby({ radius = -1 })
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_character_queries_return_detailed_bounded_snapshots",
           "[lua][bindings][characters][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local avatar = game.characters.avatar()
local result = game.characters.snapshot(avatar)
assert(result.ok == true)
local character = result.value
assert(math.type(character.id) == "integer")
assert(type(character.name) == "string")
assert(character.avatar == true)
assert(character.npc == false)
assert(type(character.male) == "boolean")
assert(type(character.faction_id) == "string")

assert(math.type(character.stats.strength) == "integer")
assert(math.type(character.stats.dexterity_base) == "integer")
assert(math.type(character.stats.perception_bonus) == "integer")
assert(math.type(character.needs.stamina) == "integer")
assert(math.type(character.needs.stamina_max) == "integer")
assert(type(character.needs.kcal_percent) == "number")
assert(math.type(character.needs.focus) == "integer")
assert(type(character.senses.blind) == "boolean")
assert(type(character.senses.deaf) == "boolean")
assert(type(character.senses.stealthy) == "boolean")
assert(type(character.combat.dodge) == "number")
assert(math.type(character.combat.working_arms) == "integer")
assert(type(character.carrying.weight_grams) == "number")
assert(type(character.carrying.volume_ml) == "number")
assert(type(character.movement.id) == "string")
assert(type(character.movement.name) == "string")
assert(character.npc_state.present == false)

local body = character.body_parts
assert(body.returned == #body.items)
assert(body.returned <= body.total)
assert(body.limit == 32)
assert(body.truncated == (body.returned < body.total))
for _, part in ipairs(body.items) do
    assert(type(part.id) == "string")
    assert(type(part.name) == "string")
    assert(math.type(part.hp) == "integer")
    assert(math.type(part.hp_max) == "integer")
    assert(type(part.hp_percent) == "number")
    assert(math.type(part.encumbrance) == "integer")
    assert(type(part.temperature_c) == "number")
    assert(type(part.broken) == "boolean")
end

local zero = game.characters.snapshot(avatar, 0).value.body_parts
assert(zero.limit == 0 and zero.returned == 0)
local capped = game.characters.snapshot(avatar, 1000000).value.body_parts
assert(capped.limit == 64 and capped.returned <= 64)

local by_id = game.characters.by_id(character.id)
assert(by_id.ok == true)
assert(by_id.value:is_valid())
assert(game.characters.snapshot(by_id.value).value.id == character.id)
assert(game.characters.by_id(-9223372036854775807).ok == false)

local nearby = game.characters.nearby({
    radius = 0,
    limit = 4,
    visible_only = false,
    include_avatar = true
})
assert(nearby.total >= 1)
assert(nearby.returned == #nearby.items)
assert(nearby.items[1].handle:is_valid())
assert(math.type(nearby.items[1].id) == "integer")
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_character_mutations_are_bounded_and_write_gated",
           "[lua][bindings][characters][write][integration]" )
{
    avatar &player = get_avatar();
    const int original_moves = player.get_moves();
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read", "game.write" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local avatar = game.characters.avatar()
local adjusted = game.characters.adjust(avatar, { moves = 7 })
assert(adjusted.ok == true)
assert(adjusted.value.after.moves == adjusted.value.before.moves + 7)
local restored = game.characters.adjust(avatar, { moves = -7 })
assert(restored.ok == true)
assert(restored.value.after.moves == adjusted.value.before.moves)

local torso = game.types.id("body_part", "torso")
local healed = game.characters.heal(avatar, torso, 1)
assert(healed.ok == true)
assert(healed.value.body_part == torso)
assert(healed.value.requested == 1)
assert(healed.value.after >= healed.value.before)
assert(healed.value.after <= healed.value.maximum)

local snapshot = game.characters.snapshot(avatar, 0).value
local current_mode = game.types.id("move_mode", snapshot.movement.id)
local movement = game.characters.set_movement_mode(avatar, current_mode)
assert(movement.ok == true)
assert(movement.value.before == current_mode)
assert(movement.value.after == current_mode)

assert(pcall(function()
    game.characters.adjust(avatar, { unknown = 1 })
end) == false)
assert(pcall(function()
    game.characters.adjust(avatar, { moves = 1.5 })
end) == false)
assert(pcall(function()
    game.characters.adjust(avatar, { moves = 1000001 })
end) == false)
assert(pcall(function()
    game.characters.heal(avatar, torso, 0)
end) == false)
assert(pcall(function()
    game.characters.heal(
        avatar, game.types.id("effect", "downed"), 1)
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
    CHECK( player.get_moves() == original_moves );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.characters.adjust(game.characters.avatar(), { moves = 1 })
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
    CHECK( player.get_moves() == original_moves );
}

TEST_CASE( "lua_v5_effects_are_detached_bounded_and_write_gated",
           "[lua][bindings][effects][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read", "game.write" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local avatar = game.creatures.avatar()
local downed = game.types.id("effect", "downed")
local one_turn = game.time.duration(1, "turn")
local two_turns = game.time.duration(2, "turn")

game.effects.remove(avatar, downed)
local absent = game.effects.has(avatar, downed)
assert(absent.ok == true and absent.value == false)
assert(game.effects.get(avatar, downed).ok == false)

local added = game.effects.add(avatar, downed, one_turn, {
    intensity = 1,
    permanent = false,
    force = true
})
assert(added.ok == true)
assert(added.value.id == downed)
assert(added.value.duration == one_turn)
assert(added.value.body_part == nil)
assert(math.type(added.value.intensity) == "integer")
assert(type(added.value.name) == "string")
assert(type(added.value.description) == "string")
assert(type(added.value.permanent) == "boolean")
assert(added.value.resisted_by.effects.returned ==
    #added.value.resisted_by.effects.items)
assert(added.value.blocks_effects.returned ==
    #added.value.blocks_effects.items)

local present = game.effects.has(avatar, downed)
assert(present.ok == true and present.value == true)
local fetched = game.effects.get(avatar, downed)
assert(fetched.ok == true and fetched.value.id == downed)

local listed = game.effects.list(avatar, 1000000)
assert(listed.ok == true)
assert(listed.value.limit == 256)
assert(listed.value.returned == #listed.value.items)
assert(listed.value.returned <= listed.value.total)
assert(listed.value.truncated ==
    (listed.value.returned < listed.value.total))

local updated = game.effects.update(avatar, downed, {
    duration = two_turns,
    intensity = 1,
    permanent = true
})
assert(updated.ok == true)
assert(updated.value.before.id == downed)
assert(updated.value.after.duration == two_turns)
assert(updated.value.after.permanent == true)

assert(pcall(function()
    game.effects.add(avatar, downed,
        game.time.duration(0, "turn"))
end) == false)
assert(pcall(function()
    game.effects.add(avatar, downed, one_turn,
        { intensity = 1001 })
end) == false)
assert(pcall(function()
    game.effects.add(avatar, downed, one_turn,
        { unknown = true })
end) == false)
assert(pcall(function()
    game.effects.has(avatar,
        game.types.id("item", "rock"))
end) == false)

local removed = game.effects.remove(avatar, downed)
assert(removed.ok == true and removed.value == true)
assert(game.effects.has(avatar, downed).value == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
    CHECK_FALSE( get_avatar().has_effect( efftype_id( "downed" ) ) );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.effects.add(
    game.creatures.avatar(),
    game.types.id("effect", "downed"),
    game.time.duration(1, "turn"))
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
    CHECK_FALSE( get_avatar().has_effect( efftype_id( "downed" ) ) );
}

TEST_CASE( "lua_v5_effect_updates_notify_the_owning_creature",
           "[lua][bindings][effects][integration][regression]" )
{
    avatar &player = get_avatar();
    const efftype_id cold( "cold" );
    const bodypart_id torso = bodypart_str_id( "torso" ).id();
    player.remove_effect( cold, torso );
    player.clear_morale();
    on_out_of_scope cleanup( [&player, &cold, &torso]() {
        player.remove_effect( cold, torso );
        player.clear_morale();
    } );

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read", "game.write" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local avatar = game.characters.avatar()
local cold = game.types.id("effect", "cold")
local torso = game.types.id("body_part", "torso")
local duration = game.time.duration(10, "minute")
assert(game.effects.add(avatar, cold, duration, {
    body_part = torso,
    intensity = 1,
    force = true
}).ok)
local updated = game.effects.update(avatar, cold, {
    body_part = torso,
    intensity = 2
})
assert(updated.ok)
assert(updated.value.before.intensity == 1)
assert(updated.value.after.intensity == 2)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
    REQUIRE( player.has_effect( cold, torso ) );
    CHECK( player.get_effect( cold, torso ).get_intensity() == 2 );
    player.update_morale();
    const int lua_updated_morale = player.get_morale_level();

    player.remove_effect( cold, torso );
    player.clear_morale();
    player.add_effect(
        cold, 10_minutes, torso, false, 2, true );
    player.update_morale();
    CHECK( lua_updated_morale == player.get_morale_level() );
}

TEST_CASE( "lua_v5_bionics_use_detached_definitions_and_uid_operations",
           "[lua][bindings][bionics][integration]" )
{
    avatar &player = get_avatar();
    const int original_count = player.num_bionics();
    const units::energy original_power = player.get_power_level();
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read", "game.write" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local avatar = game.characters.avatar()
local earplugs = game.types.id("bionic", "bio_earplugs")
local ears = game.types.id("bionic", "bio_ears")

local definitions = game.bionics.definitions({
    offset = 0,
    limit = 1000000
})
assert(definitions.limit == 256)
assert(definitions.returned == #definitions.items)
assert(definitions.returned <= definitions.total)
assert(definitions.has_more ==
    (definitions.offset + definitions.returned < definitions.total))

local definition = game.bionics.definition(earplugs)
assert(definition.id == earplugs)
assert(type(definition.name) == "string")
assert(type(definition.description) == "string")
assert(definition.power.activation.kind == "energy")
assert(definition.power.charge_time.turns >= 0)
assert(type(definition.activated) == "boolean")
assert(definition.flags.returned == #definition.flags.items)
assert(definition.occupied_body_parts.returned ==
    #definition.occupied_body_parts.items)
assert(definition.damage_protection.returned ==
    #definition.damage_protection.items)

local bundle = game.bionics.install(avatar, ears)
assert(bundle.ok == true)
local bundled_instances = game.bionics.list(avatar, 256)
assert(bundled_instances.ok == true)
local included_uid = nil
for _, instance in ipairs(bundled_instances.value.items) do
    if instance.id == earplugs and instance.included then
        included_uid = instance.uid
    end
end
assert(included_uid ~= nil)
local included_removal = game.bionics.remove(avatar, included_uid)
assert(included_removal.ok == false)
assert(included_removal.error.code == "included_bionic")
assert(game.bionics.get(avatar, included_uid).ok == true)
local bundle_removal = game.bionics.remove(avatar, bundle.value.uid)
assert(bundle_removal.ok == true)
assert(game.bionics.has(avatar, ears).value == false)
assert(game.bionics.has(avatar, earplugs).value == false)

local before = game.bionics.list(avatar, 1000000)
assert(before.ok == true and before.value.limit == 256)
local installed = game.bionics.install(avatar, earplugs)
assert(installed.ok == true)
assert(installed.value.id == earplugs)
assert(math.type(installed.value.uid) == "integer")
local uid = installed.value.uid
assert(game.bionics.has(avatar, earplugs).value == true)
assert(game.bionics.get(avatar, uid).value.id == earplugs)

local configured = game.bionics.configure(avatar, uid, {
    auto_shutdown = false,
    show_sprite = false,
    safe_fuel_threshold = -1
})
assert(configured.ok == true)
assert(configured.value.after.auto_shutdown == false)
assert(configured.value.after.show_sprite == false)
assert(configured.value.after.safe_fuel_threshold == -1)

local activated = game.bionics.activate(avatar, uid)
assert(activated.ok == true)
assert(activated.value.accepted == true)
assert(activated.value.after.powered == true)
local deactivated = game.bionics.deactivate(avatar, uid)
assert(deactivated.ok == true)
assert(deactivated.value.accepted == true)
assert(deactivated.value.after.powered == false)

local zero = game.units.new("energy", 0, "kilojoule")
local power = game.bionics.set_power(avatar, zero)
assert(power.ok == true)
assert(power.value.after == zero)
assert(type(power.value.clamped) == "boolean")

assert(pcall(function()
    game.bionics.configure(avatar, uid,
        { safe_fuel_threshold = 1.1 })
end) == false)
assert(pcall(function()
    game.bionics.configure(avatar, uid, { unknown = true })
end) == false)
assert(pcall(function()
    game.bionics.has(avatar, game.types.id("item", "rock"))
end) == false)
assert(game.bionics.get(avatar, 0).ok == false)

local removed = game.bionics.remove(avatar, uid)
assert(removed.ok == true)
assert(removed.value.removed.id == earplugs)
assert(game.bionics.has(avatar, earplugs).value == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
    CHECK( player.num_bionics() == original_count );
    CHECK( player.get_power_level() == units::from_kilojoule( 0 ) );
    player.set_power_level( original_power );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.bionics.install(
    game.characters.avatar(),
    game.types.id("bionic", "bio_earplugs"))
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
    CHECK( player.num_bionics() == original_count );
    CHECK( player.get_power_level() == original_power );
}

TEST_CASE( "lua_v5_inventory_traversal_returns_bounded_item_handles",
           "[lua][bindings][items][inventory][integration]" )
{
    avatar &player = get_avatar();
    item_location added = player.i_add( item( itype_id( "rock" ) ) );
    REQUIRE( added );
    const std::int64_t added_uid = added->uid().get_value();
    on_out_of_scope cleanup( [&player, added_uid]() {
        player.remove_items_with(
        [added_uid]( const item & entry ) {
            return entry.uid().get_value() == added_uid;
        }, 1 );
    } );

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local avatar = game.characters.avatar()
local listed = game.inventory.list(avatar, {
    limit = 1000000,
    max_depth = 1000000
})
assert(listed.ok == true)
local page = listed.value
assert(page.limit == 512)
assert(page.max_depth == 16)
assert(page.returned == #page.items)
assert(page.returned <= page.total)
assert(type(page.total_exact) == "boolean")
assert(type(page.node_truncated) == "boolean")
assert(type(page.depth_truncated) == "boolean")

local rock = nil
for _, entry in ipairs(page.items) do
    assert(entry.handle.kind == "item")
    assert(math.type(entry.uid) == "integer")
    assert(entry.id.kind == "item")
    assert(type(entry.name) == "string")
    assert(entry.location == "wielded" or
        entry.location == "worn" or
        entry.location == "carried" or
        entry.location == "contained")
    assert(math.type(entry.depth) == "integer")
    if entry.id.value == "rock" then
        rock = entry
    end
end
assert(rock ~= nil)

local found = game.inventory.find(avatar, rock.uid)
assert(found.ok == true)
assert(found.value.uid == rock.uid)
assert(found.value.handle.kind == "item")
assert(found.value.id == rock.id)

local roots = game.inventory.list(avatar, {
    recursive = false,
    limit = 1000000
})
assert(roots.ok == true)
for _, entry in ipairs(roots.value.items) do
    assert(entry.depth == 0)
    assert(entry.location ~= "contained")
end

assert(pcall(function()
    game.inventory.list(avatar, { unknown = true })
end) == false)
assert(pcall(function()
    game.inventory.list(avatar, { offset = -1 })
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_game_ids_are_immutable_typed_and_registry_validated",
           "[lua][bindings][values][ids]" )
{
    using namespace cata::lua_ui;

    const std::vector<std::string> &kinds = supported_game_id_kinds();
    REQUIRE( kinds.size() == 41 );
    CHECK( std::is_sorted( kinds.begin(), kinds.end() ) );
    CHECK( std::adjacent_find( kinds.begin(), kinds.end() ) == kinds.end() );
    CHECK( is_supported_game_id_kind( "item" ) );
    CHECK_FALSE( is_supported_game_id_kind( "missing" ) );

    const script_game_id rock( "item", "rock" );
    CHECK( rock.kind() == "item" );
    CHECK( rock.value() == "rock" );
    CHECK_FALSE( rock.is_null() );
    CHECK( rock.is_valid() );
    CHECK( rock == script_game_id( "item", "rock" ) );
    CHECK_FALSE( rock == script_game_id( "item", "stick" ) );
    CHECK_FALSE( rock == script_game_id( "monster", "rock" ) );
    CHECK( rock.to_string() == "GameId<item>(rock)" );

    const script_game_id null_id( "item", "" );
    CHECK( null_id.is_null() );
    CHECK_FALSE( null_id.is_valid() );
    CHECK_THROWS_AS( script_game_id( "missing", "value" ), std::invalid_argument );
    CHECK_THROWS_AS(
        script_game_id( "item", std::string( 257, 'x' ) ), std::invalid_argument );
    CHECK_THROWS_AS( script_game_id( "item", "bad\nid" ), std::invalid_argument );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table );
    sol::table game = lua.create_named_table( "game" );
    bool authorized = false;
    install_value_type_api( lua, game, [&authorized]() {
        if( !authorized ) {
            throw std::runtime_error( "value capability denied" );
        }
    } );
    CHECK_THROWS( lua.safe_script( "return game.types.id('item', 'rock')" ) );
    CHECK_THROWS( lua.safe_script( "return game.time.turn_zero()" ) );
    CHECK_THROWS( lua.safe_script(
                      "return game.time.before_time_starts()" ) );

    authorized = true;
    sol::protected_function_result result = lua.safe_script( R"lua(
local id = game.types.id("item", "rock")
assert(id.kind == "item")
assert(id.value == "rock")
assert(id:is_null() == false)
assert(id:is_valid() == true)
assert(tostring(id) == "GameId<item>(rock)")
assert(id == game.types.id("item", "rock"))
assert(id ~= game.types.id("monster", "rock"))
assert(pcall(function() id.value = "stick" end) == false)
local kinds = game.types.id_kinds()
assert(#kinds == 41)
kinds[1] = "mutated"
assert(game.types.id_kinds()[1] == "activity")
)lua" );
    REQUIRE( result.valid() );
}

TEST_CASE( "lua_v5_value_factories_reject_older_source_contracts",
           "[lua][bindings][values][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "4.0.0",
        "api_version": 4,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local ok, error = pcall(function()
    game.types.id("item", "rock")
end)
assert(ok == false)
assert(string.find(error, "requires Lua API 5", 1, true) ~= nil)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_unit_values_are_exact_bounded_and_dimension_safe",
           "[lua][bindings][values][units]" )
{
    using namespace cata::lua_ui;

    const std::vector<std::string> &kinds = supported_script_unit_kinds();
    REQUIRE( kinds.size() == 11 );
    CHECK( std::is_sorted( kinds.begin(), kinds.end() ) );
    CHECK( supported_units_for_kind( "mass" ) ==
           std::vector<std::string>{ "gram", "kilogram", "milligram" } );
    CHECK_THROWS_AS( supported_units_for_kind( "missing" ), std::invalid_argument );

    const script_unit_value mass =
        script_unit_value::from( "mass", 1.5, "kilogram" );
    CHECK( mass.kind() == "mass" );
    CHECK( mass.canonical_unit() == "milligram" );
    CHECK( mass.is_integral() );
    CHECK( mass.canonical_integer() == units::from_kilogram( 1.5 ).value() );
    CHECK( mass.value_as( "gram" ) == Approx( 1500.0 ) );
    CHECK( mass.value_as( "kilogram" ) == Approx( 1.5 ) );
    CHECK( mass.add( mass ).value_as( "kilogram" ) == Approx( 3.0 ) );
    CHECK( mass.subtract( script_unit_value::from(
                              "mass", 500.0, "gram" ) ).value_as( "kilogram" ) ==
           Approx( 1.0 ) );
    CHECK( mass.scale( 2.0 ).value_as( "kilogram" ) == Approx( 3.0 ) );
    CHECK( mass.compare( script_unit_value::from(
                             "mass", 2.0, "kilogram" ) ) < 0 );

    const script_unit_value freezing =
        script_unit_value::from( "temperature", 32.0, "fahrenheit" );
    CHECK_FALSE( freezing.is_integral() );
    CHECK( freezing.value_as( "celsius" ) == Approx( 0.0 ).margin( 1.0e-9 ) );
    CHECK( freezing.value_as( "kelvin" ) == Approx( 273.15 ).margin( 1.0e-9 ) );
    CHECK( script_unit_value::from(
               "angle", 180.0, "degree" ).value_as( "radian" ) ==
           Approx( 3.14159265358979323846 ) );

    CHECK_THROWS_AS(
        mass.add( script_unit_value::from( "volume", 1.0, "liter" ) ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        script_unit_value::from( "mass", 0.0001, "milligram" ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        script_unit_value::from(
            "mass", 1000000.0000005, "kilogram" ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        script_unit_value::from( "mass", std::numeric_limits<double>::infinity(),
                                 "gram" ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        script_unit_value::from( "mass", 1.0, "missing" ),
        std::invalid_argument );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table game = lua.create_named_table( "game" );
    install_value_type_api( lua, game, []() {} );
    sol::protected_function_result result = lua.safe_script( R"lua(
local kg = game.units.new("mass", 1.5, "kilogram")
local grams = game.units.new("mass", 500, "gram")
assert(kg.kind == "mass")
assert(kg.canonical_unit == "milligram")
assert(kg:is_integral() == true)
assert(kg:value("gram") == 1500)
assert((kg + grams):value("kilogram") == 2)
assert((kg - grams):value("kilogram") == 1)
assert(grams < kg)
assert(grams <= kg)
assert(kg == game.units.new("mass", 1500, "gram"))
assert(kg ~= game.units.new("volume", 1.5, "liter"))
assert(kg:scale(2):value("kilogram") == 3)
assert(kg:compare(grams) == 1)
assert(pcall(function() return kg + game.units.new("volume", 1, "liter") end) == false)
assert(pcall(function() kg.kind = "volume" end) == false)
assert(#game.units.kinds() == 11)
assert(game.units.units("energy")[1] == "joule")
local exact = game.units.new("money", 9007199254740993, "cent")
local preceding = game.units.new("money", 9007199254740992, "cent")
assert(tostring(exact) == "Unit<money>(9007199254740993 cent)")
assert(exact ~= preceding)
assert(exact:compare(preceding) == 1)
assert(pcall(function()
    game.units.new("mass", 1000000.0000005, "kilogram")
end) == false)
)lua" );
    REQUIRE( result.valid() );
}

TEST_CASE( "lua_v5_time_values_are_immutable_checked_and_calendar_aware",
           "[lua][bindings][values][time]" )
{
    using namespace cata::lua_ui;
    scoped_calendar_turn calendar_guard;

    const script_time_duration ninety_minutes =
        script_time_duration::from( 90, "minute" );
    CHECK( ninety_minutes.turns() == 5400 );
    CHECK( ninety_minutes.to_native() == 90_minutes );
    CHECK( ninety_minutes.value_as( "hour" ) == Approx( 1.5 ) );
    CHECK( ninety_minutes.add(
               script_time_duration::from( 30, "minute" ) ).value_as( "hour" ) ==
           Approx( 2.0 ) );
    CHECK( ninety_minutes.subtract(
               script_time_duration::from( 30, "minute" ) ).value_as( "hour" ) ==
           Approx( 1.0 ) );
    CHECK( ninety_minutes.scale( 2 ).value_as( "hour" ) == Approx( 3.0 ) );
    CHECK( ninety_minutes.divide( 3 ).value_as( "minute" ) == Approx( 30.0 ) );
    CHECK( ninety_minutes.negate().turns() == -5400 );
    CHECK_FALSE( ninety_minutes.display().empty() );
    CHECK( ninety_minutes.to_string() == "TimeDuration(5400 turns)" );

    const script_time_point point = script_time_point::from_turn( 10000 );
    CHECK( point.to_native() == time_point::from_turn( 10000 ) );
    CHECK( point.add( ninety_minutes ).turn() == 15400 );
    CHECK( point.add( ninety_minutes ).difference( point ) == ninety_minutes );
    CHECK( point.second_of_minute() == 40 );
    CHECK_FALSE( point.display().empty() );
    CHECK( point.to_string() == "TimePoint(10000)" );
    CHECK_FALSE( point.season().empty() );
    CHECK_FALSE( point.moon_phase().empty() );

    CHECK_THROWS_AS(
        script_time_duration::from( std::numeric_limits<int>::max(), "week" ),
        std::overflow_error );
    CHECK_THROWS_AS(
        script_time_duration::from( 1, "missing" ), std::invalid_argument );
    CHECK_THROWS_AS(
        ninety_minutes.divide( 0 ), std::invalid_argument );
    CHECK_THROWS_AS(
        script_time_duration::from( 1, "second" ).divide( 2 ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        script_time_point::from_turn( std::numeric_limits<int>::max() ).add(
            script_time_duration::from( 1, "turn" ) ),
        std::overflow_error );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table );
    sol::table game = lua.create_named_table( "game" );
    install_value_type_api( lua, game, []() {} );
    calendar::turn = time_point::from_turn( 10000 );
    sol::protected_function_result result = lua.safe_script( R"lua(
local hour = game.time.duration(1, "hour")
local half = game.time.duration(30, "minute")
assert(hour.turns == 3600)
assert(hour:value("minute") == 60)
assert((hour + half):value("minute") == 90)
assert((hour - half):value("minute") == 30)
assert((hour * 2):value("hour") == 2)
assert((hour / 2):value("minute") == 30)
assert((-hour).turns == -3600)
assert(half < hour and half <= hour)
assert(game.time.now().turn == 10000)
assert(type(game.time.turn_zero().turn) == "number")
assert(type(game.time.before_time_starts().turn) == "number")
local later = game.time.now() + half
assert(later.turn == 11800)
assert((later - game.time.now()).turns == 1800)
assert((later - half).turn == 10000)
assert(type(later:is_day()) == "boolean")
assert(type(later:is_night()) == "boolean")
assert(type(later:is_dawn()) == "boolean")
assert(type(later:is_dusk()) == "boolean")
assert(type(later:moon_phase()) == "string")
assert(type(later:season()) == "string")
assert(type(later:sunrise().turn) == "number")
assert(type(later:sunset().turn) == "number")
assert(pcall(function() later.turn = 0 end) == false)
assert(tostring(hour) == "TimeDuration(3600 turns)")
assert(tostring(later) == "TimePoint(11800)")
)lua" );
    REQUIRE( result.valid() );
}

TEST_CASE( "lua_v5_coordinates_are_immutable_typed_and_checked",
           "[lua][bindings][values][coordinates]" )
{
    using namespace cata::lua_ui;

    const script_point_coord absolute =
        script_point_coord::from( "absolute", "map_square", 10, 20 );
    const script_point_coord offset =
        script_point_coord::from( "relative", "ms", -3, 5 );
    CHECK( absolute.add( offset ).to_native() == point( 7, 25 ) );
    CHECK( absolute.add( offset ).origin() == "abs" );
    CHECK( absolute.subtract(
               script_point_coord::from( "abs", "ms", 4, 8 ) ).origin() == "rel" );
    CHECK( offset.scale_by( 3 ).to_native() == point( -9, 15 ) );
    CHECK( absolute.manhattan_distance(
               script_point_coord::from( "abs", "ms", 13, 24 ) ) == 7 );
    CHECK( absolute.square_distance(
               script_point_coord::from( "abs", "ms", 13, 24 ) ) == 4 );
    CHECK( absolute.euclidean_distance(
               script_point_coord::from( "abs", "ms", 13, 24 ) ) == Approx( 5.0 ) );
    CHECK_THROWS_AS(
        absolute.add( script_point_coord::from( "abs", "ms", 1, 1 ) ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        absolute.add( script_point_coord::from( "rel", "sm", 1, 1 ) ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        script_point_coord::from( "sm", "sm", 1, 1 ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        script_point_coord::from(
            "abs", "ms", std::numeric_limits<std::int64_t>::max(), 0 ),
        std::overflow_error );

    const script_tripoint_coord position =
        script_tripoint_coord::from( "bub", "ms", 10, 20, 3 );
    const script_tripoint_coord delta =
        script_tripoint_coord::from( "rel", "ms", -2, 4, 1 );
    CHECK( position.add( delta ).to_native() == tripoint( 8, 24, 4 ) );
    CHECK( position.add_xy( offset ).to_native() == tripoint( 7, 25, 3 ) );
    CHECK( position.xy().to_native() == point( 10, 20 ) );
    CHECK( position.subtract(
               script_tripoint_coord::from( "bub", "ms", 7, 15, 1 ) ).origin() ==
           "rel" );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table game = lua.create_named_table( "game" );
    install_value_type_api( lua, game, []() {} );
    sol::protected_function_result result = lua.safe_script( R"lua(
local pos = game.coords.point_abs_ms(10, 20)
local off = game.coords.point_rel_ms(-3, 5)
local moved = pos + off
assert(moved.x == 7 and moved.y == 25)
assert(moved.origin == "abs" and moved.scale == "ms")
assert(moved.type == "Point_abs_ms")
assert((pos - game.coords.point_abs_ms(4, 8)).origin == "rel")
assert((off * 3) == game.coords.point_rel_ms(-9, 15))
assert((-off) == game.coords.point_rel_ms(3, -5))
assert(pos:manhattan_distance(game.coords.point_abs_ms(13, 24)) == 7)
assert(pos:square_distance(game.coords.point_abs_ms(13, 24)) == 4)
assert(pos:euclidean_distance(game.coords.point_abs_ms(13, 24)) == 5)
local tri = game.coords.tripoint_bub_ms(10, 20, 3)
local tri_moved = tri + game.coords.tripoint_rel_ms(-2, 4, 1)
assert(tri_moved == game.coords.tripoint_bub_ms(8, 24, 4))
assert((tri + off) == game.coords.tripoint_bub_ms(7, 25, 3))
assert(tri:xy() == game.coords.point_bub_ms(10, 20))
assert(#game.coords.kinds() == 18)
assert(pcall(function() pos.x = 0 end) == false)
assert(pcall(function() return pos + game.coords.point_abs_ms(1, 1) end) == false)
assert(pcall(function() return pos + game.coords.point_rel_sm(1, 1) end) == false)
assert(pcall(function() return pos < game.coords.point_bub_ms(10, 20) end) == false)
assert(tostring(pos) == "Point_abs_ms(10,20)")
)lua" );
    REQUIRE( result.valid() );
}

TEST_CASE( "lua_v5_coordinate_projections_and_ranges_are_checked_and_bounded",
           "[lua][bindings][values][coordinates][projection]" )
{
    using namespace cata::lua_ui;

    const script_point_coord absolute =
        script_point_coord::from( "abs", "ms", -1, 25 );
    const script_point_coord submap = absolute.project_to( "sm" );
    CHECK( submap == script_point_coord::from( "abs", "sm", -1, 2 ) );
    CHECK( submap.project_to( "ms" ) ==
           script_point_coord::from( "abs", "ms", -12, 24 ) );

    const auto [coarse, remainder] = absolute.project_remain( "sm" );
    CHECK( coarse == submap );
    CHECK( remainder == script_point_coord::from( "sm", "ms", 11, 1 ) );
    CHECK( coarse.project_combine( remainder ) == absolute );

    const script_point_coord minimum =
        script_point_coord::from(
            "abs", "ms", std::numeric_limits<int>::min(), 0 );
    const auto [minimum_coarse, minimum_remainder] =
        minimum.project_remain( "sm" );
    CHECK( minimum_coarse.project_combine( minimum_remainder ) == minimum );

    const script_tripoint_coord tripoint_value =
        script_tripoint_coord::from( "abs", "ms", -1, 25, 4 );
    const auto [tripoint_coarse, tripoint_remainder] =
        tripoint_value.project_remain( "sm" );
    CHECK( tripoint_coarse ==
           script_tripoint_coord::from( "abs", "sm", -1, 2, 4 ) );
    CHECK( tripoint_coarse.project_combine( tripoint_remainder ) ==
           tripoint_value );

    CHECK_THROWS_AS(
        script_point_coord::from( "abs", "om", 1, 1 ).project_to( "seg" ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        script_point_coord::from(
            "abs", "om", std::numeric_limits<int>::max(), 0 ).project_to( "ms" ),
        std::overflow_error );
    CHECK_THROWS_AS( submap.project_remain( "ms" ), std::invalid_argument );
    CHECK_THROWS_AS(
        coarse.project_combine(
            script_point_coord::from( "sm", "ms", 12, 0 ) ),
        std::invalid_argument );

    const std::vector<script_point_coord> line =
        script_point_coord::from( "bub", "ms", 0, 0 ).line_to(
            script_point_coord::from( "bub", "ms", 3, 2 ), 4 );
    REQUIRE( line.size() == 4 );
    CHECK( line.front() == script_point_coord::from( "bub", "ms", 0, 0 ) );
    CHECK( line.back() == script_point_coord::from( "bub", "ms", 3, 2 ) );
    CHECK_THROWS_AS(
        script_point_coord::from( "bub", "ms", 0, 0 ).line_to(
            script_point_coord::from( "bub", "ms", 100, 0 ), 10 ),
        std::length_error );
    CHECK( script_coordinate_rectangle(
               script_point_coord::from( "bub", "ms", 0, 0 ),
               script_point_coord::from( "bub", "ms", 2, 1 ), 6 ).size() == 6 );
    CHECK_THROWS_AS(
        script_coordinate_box(
            script_tripoint_coord::from( "bub", "ms", 0, 0, 0 ),
            script_tripoint_coord::from( "bub", "ms", 2, 2, 2 ), 20 ),
        std::length_error );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table );
    sol::table game = lua.create_named_table( "game" );
    install_value_type_api( lua, game, []() {} );
    sol::protected_function_result result = lua.safe_script( R"lua(
local value = game.coords.point_abs_ms(-1, 25)
local coarse, remainder = value:project_remain("sm")
assert(coarse == game.coords.point_abs_sm(-1, 2))
assert(remainder == game.coords.point_sm_ms(11, 1))
assert(coarse:project_combine(remainder) == value)
assert(game.coords.project_to(value, "sm") == coarse)
local api_coarse, api_remainder = game.coords.project_remain(value, "sm")
assert(game.coords.project_combine(api_coarse, api_remainder) == value)
local line = game.coords.line(
    game.coords.point_bub_ms(0, 0),
    game.coords.point_bub_ms(3, 2), 4)
assert(#line == 4)
assert(line[1] == game.coords.point_bub_ms(0, 0))
assert(line[4] == game.coords.point_bub_ms(3, 2))
local rectangle = game.coords.rectangle(
    game.coords.point_bub_ms(0, 0),
    game.coords.point_bub_ms(2, 1), 6)
assert(#rectangle == 6)
local box = game.coords.box(
    game.coords.tripoint_bub_ms(0, 0, 0),
    game.coords.tripoint_bub_ms(1, 1, 1), 8)
assert(#box == 8)
assert(game.coords.max_range_points == 4096)
assert(pcall(function()
    return game.coords.line(
        game.coords.point_bub_ms(0, 0),
        game.coords.point_bub_ms(100, 0), 10)
end) == false)
assert(pcall(function()
    return game.coords.rectangle(
        game.coords.point_bub_ms(0, 0),
        game.coords.point_bub_ms(100, 100), 4097)
end) == false)
)lua" );
    REQUIRE( result.valid() );
}

TEST_CASE( "lua_v5_enums_are_typed_discoverable_and_bounded",
           "[lua][bindings][values][enums]" )
{
    using namespace cata::lua_ui;

    const std::vector<std::string> kinds = supported_script_enum_kinds();
    CHECK( kinds.size() == 25 );
    CHECK( std::find( kinds.begin(), kinds.end(), "DamageType" ) != kinds.end() );
    CHECK( script_enum_kind_is_available( "DamageType" ) );
    CHECK( script_enum_kind_is_available( "ArtifactEffectActive" ) );
    CHECK_FALSE( script_enum_kind_is_available( "ArtifactEffectPassive" ) );
    CHECK_FALSE( script_enum_kind_is_available( "ArtifactCharge" ) );

    const script_enum_value hostile =
        script_enum_value::from( "Attitude", "hostile" );
    CHECK( hostile.kind() == "Attitude" );
    CHECK( hostile.name() == "hostile" );
    CHECK( hostile.ordinal() == 0 );
    CHECK( hostile.to_string() == "Attitude.hostile" );
    CHECK_THROWS_AS(
        script_enum_value::from( "Attitude", "missing" ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        script_enum_value::from( "ArtifactCharge", "anything" ),
        std::invalid_argument );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table );
    sol::table game = lua.create_named_table( "game" );
    install_value_type_api( lua, game, []() {} );
    sol::protected_function_result result = lua.safe_script( R"lua(
assert(#game.enums.kinds() == 25)
local hostile = game.enums.value("Attitude", "hostile")
assert(hostile.kind == "Attitude")
assert(hostile.name == "hostile")
assert(hostile.ordinal == 0)
assert(tostring(hostile) == "Attitude.hostile")
assert(hostile == game.enums.value("Attitude", "hostile"))
assert(hostile ~= game.enums.value("Attitude", "friendly"))
local directions = game.enums.values("Direction", 0, 4)
assert(#directions == 4)
assert(directions[1].kind == "Direction")
local damage = game.enums.describe("DamageType")
assert(damage.status == "dynamic_id")
assert(damage.available == true)
assert(damage.replacement == "GameId<damage_type>")
local removed = game.enums.describe("ArtifactCharge")
assert(removed.status == "not_applicable")
assert(removed.available == false)
assert(#removed.reason > 0)
assert(game.enums.has("Attitude", "friendly") == true)
assert(game.enums.has("ArtifactCharge", "anything") == false)
assert(game.enums.has("ArtifactEffectActive", "str_up") == true)
assert(game.enums.describe("ArtifactEffectPassive").status == "not_applicable")
assert(game.enums.value("ArtifactEffectActive", "str_up").name == "str_up")
assert(pcall(function() hostile.name = "neutral" end) == false)
assert(pcall(function()
    return game.enums.values("ActionId", 0, 513)
end) == false)
assert(pcall(function()
    return game.enums.value("ArtifactCharge", "anything")
end) == false)
)lua" );
    REQUIRE( result.valid() );
}

TEST_CASE( "lua_v5_serde_is_deterministic_typed_and_strictly_bounded",
           "[lua][bindings][values][serde]" )
{
    using namespace cata::lua_ui;

    sol::state lua;
    lua.open_libraries(
        sol::lib::base, sol::lib::string, sol::lib::table );
    sol::table game = lua.create_named_table( "game" );
    install_value_type_api( lua, game, []() {} );
    sol::protected_function_result result = lua.safe_script( R"lua(
local original = {
    answer = 42,
    precise = 9007199254740993,
    fraction = 1.25,
    enabled = true,
    text = "cleanwater",
    nested = { "a", "b", false },
    id = game.types.id("item", "rock"),
    enum = game.enums.value("Attitude", "friendly"),
    unit = game.units.new("mass", 1, "kilogram"),
    duration = game.time.duration(5, "minute"),
    moment = game.time.point(12345),
    point = game.coords.point("absolute", "map_square", -4, 7),
    tripoint = game.coords.tripoint(
        "relative", "overmap_terrain", 1, 2, -3)
}

local encoded = game.serde.encode(original)
assert(type(encoded) == "string")
assert(#encoded <= game.serde.max_bytes)
local copy = game.serde.decode(encoded)
assert(copy.answer == 42)
assert(copy.precise == 9007199254740993)
assert(copy.fraction == 1.25)
assert(copy.enabled == true)
assert(copy.text == "cleanwater")
assert(copy.nested[1] == "a" and copy.nested[3] == false)
assert(copy.id == original.id)
assert(copy.enum == original.enum)
assert(copy.unit == original.unit)
assert(copy.duration == original.duration)
assert(copy.moment == original.moment)
assert(copy.point == original.point)
assert(copy.tripoint == original.tripoint)

local first = { z = 3, a = 1, middle = 2 }
local second = { middle = 2, z = 3, a = 1 }
assert(game.serde.encode(first) == game.serde.encode(second))
assert(#game.serde.types() == 13)

local recursive = {}
recursive.self = recursive
assert(pcall(function() game.serde.encode(recursive) end) == false)
assert(pcall(function()
    game.serde.encode(function() return 1 end)
end) == false)
assert(pcall(function()
    game.serde.decode('{"format":"ccb_lua_value","version":1,' ..
        '"value":{"type":"native_pointer"}}')
end) == false)
assert(pcall(function()
    game.serde.decode(string.rep("[", 65))
end) == false)
)lua" );
    REQUIRE( result.valid() );
}

TEST_CASE( "lua_ui_navigation_is_callback_only_typed_and_bounded",
           "[lua][ui][navigation]" )
{
    using namespace cata::lua_ui;

    clear_navigation_requests();
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table ui = lua.create_named_table( "ui" );
    bool authorized = false;
    bool callback_active = false;
    install_navigation_api(
        ui,
    [&authorized]() {
        if( !authorized ) {
            throw std::runtime_error( "navigation capability denied" );
        }
    },
    [&callback_active]() {
        return callback_active;
    },
    []( const std::string & page_id ) {
        return page_id == "target";
    } );

    sol::protected_function open = ui["open"];
    sol::protected_function_result result = open( "target" );
    CHECK_FALSE( result.valid() );
    CHECK( pending_navigation_request_count() == 0 );

    authorized = true;
    result = open( "target" );
    CHECK_FALSE( result.valid() );
    const sol::error inactive_error = result;
    CHECK( std::string( inactive_error.what() ).find( "active callback" ) !=
           std::string::npos );

    callback_active = true;
    sol::table parameters = lua.create_table();
    parameters["boolean"] = true;
    parameters["integer"] = static_cast<lua_Integer>( 5000000000LL );
    parameters["float"] = 1.25;
    parameters["string"] = "typed";
    result = open( "target", parameters );
    REQUIRE( result.valid() );
    REQUIRE( pending_navigation_request_count() == 1 );

    const std::optional<navigation_request> request = take_navigation_request();
    REQUIRE( request );
    CHECK( request->type == navigation_request_type::open_page );
    CHECK( request->page_id == "target" );
    CHECK( std::get<bool>( request->parameters.at( "boolean" ) ) );
    CHECK( std::get<std::int64_t>( request->parameters.at( "integer" ) ) ==
           5000000000LL );
    CHECK( std::get<double>( request->parameters.at( "float" ) ) == 1.25 );
    CHECK( std::get<std::string>( request->parameters.at( "string" ) ) ==
           "typed" );

    SECTION( "unknown pages and unsupported values are rejected before enqueue" ) {
        result = open( "missing" );
        CHECK_FALSE( result.valid() );
        CHECK( pending_navigation_request_count() == 0 );

        sol::table invalid = lua.create_table();
        invalid["nested"] = lua.create_table();
        result = open( "target", invalid );
        CHECK_FALSE( result.valid() );
        CHECK( pending_navigation_request_count() == 0 );

        invalid = lua.create_table();
        invalid["infinite"] = std::numeric_limits<double>::infinity();
        result = open( "target", invalid );
        CHECK_FALSE( result.valid() );
        CHECK( pending_navigation_request_count() == 0 );

        invalid = lua.create_table();
        for( int index = 0; index < 5; ++index ) {
            invalid["value_" + std::to_string( index )] =
                std::string( 4096, 'x' );
        }
        result = open( "target", invalid );
        CHECK_FALSE( result.valid() );
        CHECK( pending_navigation_request_count() == 0 );
    }

    SECTION( "the pending queue has a hard upper bound" ) {
        sol::protected_function back = ui["back"];
        for( int index = 0; index < 16; ++index ) {
            result = back();
            REQUIRE( result.valid() );
        }
        CHECK( pending_navigation_request_count() == 16 );
        result = back();
        CHECK_FALSE( result.valid() );
        CHECK( pending_navigation_request_count() == 16 );
    }

    clear_navigation_requests();
}

TEST_CASE( "lua_persistent_state_codec_is_typed_and_bounded", "[lua][ui][state]" )
{
    using namespace cata::lua_ui;

    script_persistent_state original;
    assign_persistent_value( original, "boolean", true );
    assign_persistent_value( original, "integer", std::int64_t{ 5000000000LL } );
    assign_persistent_value( original, "float", 1.25 );
    assign_persistent_value( original, "string", std::string( "中文 value" ) );

    std::ostringstream first_output;
    write_persistent_state( first_output, original );
    const script_persistent_state restored = read_persistent_state(
                json_loader::from_string( first_output.str() ) );

    CHECK( std::get<bool>( restored.at( "boolean" ) ) );
    CHECK( std::get<std::int64_t>( restored.at( "integer" ) ) == 5000000000LL );
    CHECK( std::get<double>( restored.at( "float" ) ) == 1.25 );
    CHECK( std::get<std::string>( restored.at( "string" ) ) == "中文 value" );

    script_persistent_state different_order;
    assign_persistent_value( different_order, "string", std::string( "中文 value" ) );
    assign_persistent_value( different_order, "float", 1.25 );
    assign_persistent_value( different_order, "integer", std::int64_t{ 5000000000LL } );
    assign_persistent_value( different_order, "boolean", true );
    std::ostringstream second_output;
    write_persistent_state( second_output, different_order );
    CHECK( first_output.str() == second_output.str() );

    SECTION( "failed assignments do not mutate existing state" ) {
        const script_persistent_state before = original;
        CHECK_THROWS_AS( assign_persistent_value(
                             original, std::string( persistent_state_max_key_bytes + 1, 'k' ), true ),
                         std::invalid_argument );
        CHECK_THROWS_AS( assign_persistent_value(
                             original, "oversized", std::string( persistent_state_max_string_bytes + 1, 'x' ) ),
                         std::invalid_argument );
        CHECK_THROWS_AS( assign_persistent_value(
                             original, "infinite", std::numeric_limits<double>::infinity() ),
                         std::invalid_argument );
        CHECK( original == before );
    }

    SECTION( "unknown versions and types are rejected transactionally" ) {
        CHECK_THROWS_AS( read_persistent_state( json_loader::from_string(
                R"({"version":2,"values":{}})" ) ), std::invalid_argument );
        CHECK_THROWS_AS( read_persistent_state( json_loader::from_string(
                R"({"version":1,"values":{"key":{"type":"table","value":{}}}})" ) ),
                         std::invalid_argument );
    }

    SECTION( "JSON escaping cannot exceed the sidecar file limit" ) {
        script_persistent_state escaped;
        for( int index = 0; index < 7; ++index ) {
            assign_persistent_value( escaped, "escaped." + std::to_string( index ),
                                     std::string( persistent_state_max_string_bytes, '\0' ) );
        }
        assign_persistent_value( escaped, "escaped.final", std::string( 48U * 1024U, '\0' ) );
        std::ostringstream output;
        CHECK_THROWS_AS( write_persistent_state( output, escaped ), std::invalid_argument );
        CHECK( output.str().empty() );
    }
}

TEST_CASE( "lua_snippets_have_an_instruction_budget", "[lua][ui][sandbox]" )
{
    std::string error;

    SECTION( "ordinary code completes" ) {
        CHECK( cata::lua_ui::validate_snippet( "return 1 + 1", 1000, error ) );
        CHECK( error.empty() );
    }

    SECTION( "runtime uses the vendored Lua 5.4 API" ) {
        CHECK( cata::lua_ui::validate_snippet(
                   "assert(_VERSION == 'Lua 5.4')", 1000, error ) );
        CHECK( error.empty() );
    }

    SECTION( "infinite loops are interrupted" ) {
        CHECK_FALSE( cata::lua_ui::validate_snippet( "while true do end", 1000, error ) );
        CHECK( error.find( "instruction budget exceeded" ) != std::string::npos );
    }

    SECTION( "pcall cannot swallow the budget error" ) {
        CHECK_FALSE( cata::lua_ui::validate_snippet( R"lua(
pcall(function()
    pcall(function()
        while true do end
    end)
end)
return true
)lua", 4000, error ) );
        CHECK( error.find( "instruction budget exceeded" ) != std::string::npos );
    }

    SECTION( "xpcall cannot swallow the budget error" ) {
        CHECK_FALSE( cata::lua_ui::validate_snippet( R"lua(
xpcall(function()
    while true do end
end, function(message)
    return message
end)
return true
)lua", 4000, error ) );
        CHECK( error.find( "instruction budget exceeded" ) != std::string::npos );
    }

    SECTION( "allocations cannot exceed the runtime memory limit" ) {
        CHECK_FALSE( cata::lua_ui::validate_snippet(
                         "return string.rep('x', 40 * 1024 * 1024)", 1000, error ) );
        CHECK_FALSE( error.empty() );
    }
}

TEST_CASE( "bundled_lua_ui_script_registers_api_v4", "[lua][ui][integration]" )
{
    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    const cata::lua_ui::runtime_status status = cata::lua_ui::status();
    CHECK( status.loaded );
    CHECK( status.generation > 0 );
    CHECK( status.page_count == 0 );
    CHECK( status.event_handler_count == 0 );
    CHECK( status.memory_used > 0 );
    CHECK( status.memory_used <= status.memory_limit );

    cata::lua_ui::shutdown();
    const cata::lua_ui::runtime_status stopped = cata::lua_ui::status();
    CHECK_FALSE( stopped.loaded );
    CHECK( stopped.page_count == 0 );
    CHECK( stopped.event_handler_count == 0 );
    CHECK( stopped.memory_used == 0 );
    CHECK( stopped.last_error.empty() );
}

TEST_CASE( "lua_v4_services_copy_values_and_restore_provider_identity",
           "[lua][services][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "4.0.0",
        "api_version": 4,
        "capabilities": [
            "services.consume",
            "services.provide",
            "state.character"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
services.provide("counter.api", {
    version = 2,
    methods = {
        add = function(arguments)
            local calls = state.character.get("service.calls", 0) + 1
            state.character.set("service.calls", calls)
            arguments.value = 999
            return {
                value = arguments.left + arguments.right,
                calls = calls,
                provider = ccb_source_id
            }
        end
    }
})

assert(services.available("user", "counter.api"))
assert(services.available("user", "counter.api", 2))
assert(not services.available("user", "counter.api", 3))
local visible = services.list()
assert(#visible == 1)
assert(visible[1].provider == "user")
assert(visible[1].name == "counter.api")
assert(visible[1].version == 2)
assert(visible[1].methods[1] == "add")

local arguments = { left = 20, right = 22, value = 1 }
local result = services.call("user", "counter.api", "add", arguments)
assert(result.value == 42)
assert(result.calls == 1)
assert(result.provider == "user")
assert(arguments.value == 1)
assert(pcall(function()
    services.call("builtin", "missing", "call", {})
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v4_registry_returns_bounded_detached_definition_snapshots",
           "[lua][registry][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "4.0.0",
        "api_version": 4,
        "capabilities": [ "registry.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local kinds = registry.kinds()
assert(#kinds == 8)
assert(type(registry.revision()) == "number")

local page = registry.list("item", { offset = 0, limit = 2 })
assert(page.kind == "item")
assert(page.limit == 2)
assert(page.returned <= 2)
assert(page.total >= page.returned)
assert(type(page.has_more) == "boolean")
if page.returned > 0 then
    local id = page.entries[1].id
    local first = registry.get("item", id)
    assert(first.kind == "item")
    assert(first.id == id)
    assert(type(first.name) == "string")
    local original_name = first.name
    first.name = "detached mutation"
    assert(registry.get("item", id).name == original_name)
end

local detailed = registry.list("skill", { limit = 1, details = true })
if detailed.returned > 0 then
    assert(detailed.entries[1].kind == "skill")
end
assert(registry.get("item", "__missing_lua_registry_id__") == nil)
assert(pcall(function() registry.list("unknown") end) == false)
assert(pcall(function()
    registry.list("item", { limit = 257 })
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_definition_registry_uses_typed_ids_without_native_references",
           "[lua][bindings][definitions][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read", "registry.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local kinds = game.definitions.kinds()
assert(#kinds == 41)
assert(type(game.definitions.revision()) == "number")

local item = game.definitions.describe("item")
assert(item.typed == true)
assert(item.enumerable == true)
assert(item.detail_level == "snapshot")
assert(type(item.fields) == "table")
assert(type(item.count) == "number")

local damage = game.definitions.describe("damage_type")
assert(damage.enumerable == false)
assert(damage.detail_level == "identity")
assert(damage.count == nil)
local bash = game.types.id("damage_type", "bash")
assert(game.definitions.exists(bash) == true)
local bash_definition = game.definitions.get(bash)
assert(bash_definition.id == bash)
assert(bash_definition.value == "bash")
assert(bash_definition.valid == true)
assert(bash_definition.detail_level == "identity")

local page = game.definitions.list("item", { offset = 0, limit = 2 })
assert(page.returned <= 2)
if page.returned > 0 then
    local id = page.entries[1].id
    assert(id.kind == "item")
    assert(id.value == page.entries[1].value)
    local first = game.definitions.get(id)
    assert(first.id == id)
    assert(first.kind == "item")
    assert(first.detail_level == "snapshot")
    local original_name = first.name
    first.name = "detached mutation"
    assert(game.definitions.get(id).name == original_name)
end

local missing = game.types.id("item", "__missing_lua_definition_id__")
assert(game.definitions.exists(missing) == false)
assert(game.definitions.get(missing) == nil)
assert(pcall(function()
    game.definitions.list("damage_type")
end) == false)
assert(pcall(function()
    game.definitions.describe("unknown")
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_runtime_diagnostics_are_bounded_structured_and_path_free",
           "[lua][bindings][diagnostics][integration]" )
{
    scoped_calendar_turn turn;
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read", "scheduler" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local first_id = scheduler.after(1, function()
    error("expected diagnostic marker")
end)
local second_id = scheduler.after(2, function()
    local snapshot = game.diagnostics.snapshot()
    assert(snapshot.schema_version == 1)
    assert(snapshot.health.ok == false)
    assert(string.find(snapshot.health.last_error,
        "expected diagnostic marker", 1, true) ~= nil)
    assert(snapshot.callbacks.count >= 1)
    assert(snapshot.resources.scheduled_tasks <=
        snapshot.limits.scheduler_tasks)
    local recent = game.diagnostics.recent()
    assert(#recent >= 1 and #recent <=
        snapshot.limits.diagnostic_records)
    assert(recent[1].severity == "error")
    assert(recent[1].source == "user")
    assert(string.find(recent[1].message,
        "expected diagnostic marker", 1, true) ~= nil)
end)

local snapshot = game.diagnostics.snapshot()
assert(snapshot.health.ok == true)
assert(snapshot.runtime.generation > 0)
assert(snapshot.memory.used <= snapshot.memory.limit)
assert(snapshot.memory.remaining <= snapshot.memory.limit)
assert(snapshot.resources.scheduled_tasks == 2)
assert(snapshot.limits.script_instructions > 0)
assert(snapshot.limits.callback_instructions > 0)
assert(#snapshot.sources >= 2)
local found_user = false
for _, source in ipairs(snapshot.sources) do
    assert(source.root == nil and source.entry == nil)
    if source.id == "user" then
        found_user = true
        assert(source.api_version == 5)
        assert(source.scheduled_tasks == 2)
    end
end
assert(found_user)
assert(#game.diagnostics.recent(0) == 0)
assert(pcall(function()
    game.diagnostics.recent(65)
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
    calendar::turn = turn.original() + 1_turns;
    cata::lua_ui::on_turn();
    CHECK( cata::lua_ui::status().last_error.find(
               "expected diagnostic marker" ) != std::string::npos );
    calendar::turn = turn.original() + 2_turns;
    cata::lua_ui::on_turn();
    cata::lua_ui::shutdown();
}

TEST_CASE( "lua_v4_modules_use_strict_source_environments_and_consumer_caches",
           "[lua][modules][sandbox][integration]" )
{
    scoped_lua_user_script script;
    scoped_lua_user_module module( fs::path( "test_modules" ) / "counter.lua" );
    module.write( R"lua(
module_evaluations = (module_evaluations or 0) + 1
return {
    evaluations = module_evaluations,
    source = ccb_source_id
}
)lua" );
    script.write_manifest( R"json({
        "id": "user",
        "version": "4.0.0",
        "api_version": 4,
        "capabilities": [ "modules.import" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local first = require("test_modules.counter")
local second = require("test_modules.counter")
assert(rawequal(first, second))
assert(first.evaluations == 1)
assert(first.source == "user")
assert(modules.source_id() == "user")

local profile = modules.import("builtin", "ui.profiles.pc_legacy")
assert(profile.id == "pc_legacy")
profile.id = "consumer-local mutation"
assert(modules.import("builtin", "ui.profiles.pc_legacy").id ==
       "consumer-local mutation")

local saved_game = game
game = nil
assert(game == nil)
game = saved_game
assert(rawget(_G, "game") == saved_game)
assert(package.path == "")
assert(package.cpath == "")
assert(package.loadlib == nil)
assert(package.searchpath == nil)
assert(package.loaded._G == nil)

assert(pcall(function()
    modules.import("missing-provider", "test_modules.counter")
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_module_loading_enforces_source_depth_and_cache_limits",
           "[lua][modules][sandbox][integration]" )
{
    using namespace cata::lua_ui;

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [],
        "dependencies": [ "builtin" ]
    })json" );
    const auto reload = []() {
        std::string error;
        REQUIRE( reload_scripts( error ) );
        CHECK( error.empty() );
    };

    SECTION( "module source size" ) {
        scoped_lua_user_module module(
            fs::path( "test_limits" ) / "oversized.lua" );
        module.write( std::string(
                          maximum_module_source_bytes + 1, ' ' ) );
        script.write( R"lua(
local ok, error = pcall(require, "test_limits.oversized")
assert(ok == false)
assert(string.find(error, "source size limit", 1, true) ~= nil)
)lua" );
        reload();
    }

    SECTION( "nested module depth" ) {
        std::vector<std::unique_ptr<scoped_lua_user_module>> modules;
        for( std::size_t index = 0;
             index <= maximum_module_load_depth; ++index ) {
            const std::string name = "depth_" + std::to_string( index );
            auto module = std::make_unique<scoped_lua_user_module>(
                              fs::path( "test_limits" ) / ( name + ".lua" ) );
            if( index == maximum_module_load_depth ) {
                module->write( "return true\n" );
            } else {
                module->write(
                    "return require(\"test_limits.depth_" +
                    std::to_string( index + 1 ) + "\")\n" );
            }
            modules.push_back( std::move( module ) );
        }
        script.write( R"lua(
local ok, error = pcall(require, "test_limits.depth_0")
assert(ok == false)
assert(string.find(error, "nesting limit", 1, true) ~= nil)
)lua" );
        reload();
    }

    SECTION( "modules per source" ) {
        std::vector<std::unique_ptr<scoped_lua_user_module>> modules;
        for( std::size_t index = 0;
             index <= maximum_modules_per_source; ++index ) {
            const std::string name = "budget_" + std::to_string( index );
            auto module = std::make_unique<scoped_lua_user_module>(
                              fs::path( "test_limits" ) / ( name + ".lua" ) );
            module->write( "return true\n" );
            modules.push_back( std::move( module ) );
        }
        script.write(
            "for index = 0, " +
            std::to_string( maximum_modules_per_source ) + R"lua( do
    local ok, error = pcall(
        require, "test_limits.budget_" .. tostring(index))
    if index < )lua" +
                                            std::to_string( maximum_modules_per_source ) + R"lua( then
        assert(ok)
    else
        assert(ok == false)
        assert(string.find(error, "loaded module limit", 1, true) ~= nil)
    end
end
)lua" );
        reload();
    }
}

TEST_CASE( "lua_v4_scheduler_is_live_and_can_add_the_first_game_event_handler",
           "[lua][scheduler][events][integration]" )
{
    scoped_calendar_turn turn;
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "4.0.0",
        "api_version": 4,
        "capabilities": [ "events", "scheduler", "state.character" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
state.character.set("v4.scheduler.after", 0)
state.character.set("v4.scheduler.repeat", 0)
state.character.set("v4.scheduler.late_event", false)

scheduler.after(1, function(id, now, due)
    assert(math.type(id) == "integer")
    assert(now >= due)
    state.character.set("v4.scheduler.after", 1)
    events.on("game_begin", function(event)
        assert(event.type == "game_begin")
        state.character.set("v4.scheduler.late_event", true)
    end)
end)

scheduler.every(1, function()
    local count = state.character.get("v4.scheduler.repeat", 0) + 1
    state.character.set("v4.scheduler.repeat", count)
    return count < 2
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( cata::lua_ui::status().event_handler_count == 0 );

    calendar::turn = turn.original() + 1_turns;
    cata::lua_ui::on_turn();
    CHECK( cata::lua_ui::status().event_handler_count == 1 );
    get_event_bus().send<event_type::game_begin>( "lua-v4-late-event" );

    calendar::turn = turn.original() + 2_turns;
    cata::lua_ui::on_turn();
    calendar::turn = turn.original() + 3_turns;
    cata::lua_ui::on_turn();

    script.write( R"lua(
assert(state.character.get("v4.scheduler.after", 0) == 1)
assert(state.character.get("v4.scheduler.repeat", 0) == 2)
assert(state.character.get("v4.scheduler.late_event", false) == true)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v4_custom_and_lifecycle_events_are_ordered_typed_and_bounded",
           "[lua][events][lifecycle][integration]" )
{
    REQUIRE( world_generator );
    REQUIRE( world_generator->active_world != nullptr );
    scoped_lua_state_file character_file;
    scoped_lua_state_file world_file(
        ( world_generator->active_world->folder_path() /
          "lua_ui_world.json" ).get_unrelative_path() );
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "4.0.0",
        "api_version": 4,
        "capabilities": [ "events", "state.character" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
state.character.set("v4.events.reload", 0)
state.character.set("v4.events.before_save", 0)
state.character.set("v4.events.after_save", 0)

events.on("ccb.lifecycle.reload", { once = true }, function(event)
    assert(event.type == "ccb.lifecycle.reload")
    state.character.set(
        "v4.events.reload",
        state.character.get("v4.events.reload", 0) + 1)
end)
events.on("ccb.lifecycle.before_save", function()
    state.character.set(
        "v4.events.before_save",
        state.character.get("v4.events.before_save", 0) + 1)
end)
events.on("ccb.lifecycle.after_save", function(event)
    assert(event.data.success == true)
    state.character.set(
        "v4.events.after_save",
        state.character.get("v4.events.after_save", 0) + 1)
end)

local order = ""
local high = events.on("probe", { priority = 50 }, function(event)
    assert(event.type == "user:probe")
    assert(event.data.answer == 42)
    assert(event.data_types.answer == "integer")
    order = order .. "H"
end)
events.on("probe", { priority = 0, once = true }, function()
    order = order .. "O"
end)
assert(events.emit("probe", { answer = 42 }) == true)
assert(order == "HO")
assert(events.emit("probe", { answer = 42 }) == true)
assert(order == "HOH")
assert(events.off(high) == true)
assert(events.off(high) == false)

local from_self = events.on_from("user", "from-self", function(event)
    assert(event.type == "user:from-self")
    order = order .. "S"
end)
assert(events.emit("from-self", {}) == true)
assert(order == "HOHS")
assert(events.off(from_self) == true)
assert(pcall(function()
    events.emit("nested", { invalid = {} })
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    REQUIRE( cata::lua_ui::save_persistent_state( error ) );
    CHECK( error.empty() );

    script.write( R"lua(
assert(state.character.get("v4.events.reload", 0) == 1)
assert(state.character.get("v4.events.before_save", 0) == 1)
assert(state.character.get("v4.events.after_save", 0) == 1)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_event_callbacks_can_request_safe_page_navigation",
           "[lua][ui][navigation][integration]" )
{
    using namespace cata::lua_ui;

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "3.0.0",
        "api_version": 3,
        "capabilities": [ "ui.pages", "events" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
ui.page("navigation_target", "Navigation target", function(ctx, params)
    ctx:text(params.label or "missing")
end)

local top_level_ok, top_level_error = pcall(function()
    ui.open("navigation_target")
end)
assert(top_level_ok == false)
assert(string.find(top_level_error, "active callback", 1, true) ~= nil)

events.on("game_begin", function(event)
    ui.open("navigation_target", {
        integer = 42,
        float = 1.25,
        label = event.data.cdda_version
    })
end)
)lua" );

    std::string error;
    REQUIRE( reload_scripts( error ) );
    CHECK( pending_navigation_request_count() == 0 );
    get_event_bus().send<event_type::game_begin>( "navigation-event" );
    REQUIRE( pending_navigation_request_count() == 1 );

    const std::optional<navigation_request> request = take_navigation_request();
    REQUIRE( request );
    CHECK( request->type == navigation_request_type::open_page );
    CHECK( request->page_id == "navigation_target" );
    CHECK( std::get<std::int64_t>( request->parameters.at( "integer" ) ) == 42 );
    CHECK( std::get<double>( request->parameters.at( "float" ) ) == 1.25 );
    CHECK( std::get<std::string>( request->parameters.at( "label" ) ) ==
           "navigation-event" );

    get_event_bus().send<event_type::game_begin>( "queued-before-shutdown" );
    REQUIRE( pending_navigation_request_count() == 1 );
    shutdown();
    CHECK( pending_navigation_request_count() == 0 );
}

TEST_CASE( "lua_capabilities_follow_the_registering_source_into_callbacks",
           "[lua][ui][manifest][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "1.0.0",
        "api_version": 2,
        "capabilities": [ "ui.pages", "events" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
ui.page("restricted", "Restricted", function(ctx)
    ctx:text("restricted source")
end)

local read_ok, read_error = pcall(game.player_snapshot)
assert(read_ok == false)
assert(string.find(read_error, "game.read", 1, true) ~= nil)
assert(pcall(function() game.actions.status() end) == false)
assert(pcall(function() game.state_set("forbidden", true) end) == false)
assert(pcall(function() state.character.set("forbidden", true) end) == false)
assert(pcall(function() state.world.set("forbidden", true) end) == false)
assert(pcall(function() state.page.set("forbidden", true) end) == false)
assert(ui.hud == nil)

events.on("game_begin", function(event)
    game.player_snapshot()
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    get_event_bus().send<event_type::game_begin>( "lua-capability-test" );
    const cata::lua_ui::runtime_status status = cata::lua_ui::status();
    CHECK( status.loaded );
    CHECK( status.last_error.find( "source 'user' lacks capability 'game.read'" ) !=
           std::string::npos );
}

TEST_CASE( "lua_pages_use_the_platform_neutral_registry",
           "[lua][ui][renderer][integration]" )
{
    scoped_lua_user_script script;
    script.write( R"lua(
ui.page("registry_test", {
    title = "Registry test",
    category = "tools",
    order = 42,
    slots = { "settings.mods", "ingame.extensions" }
}, function(ctx)
    ctx:text("shared ImGui page")
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    const std::vector<cata::lua_ui::page_info> settings_pages =
        cata::lua_ui::registered_pages( "settings.mods" );
    REQUIRE( settings_pages.size() == 1 );
    CHECK( settings_pages.front().id == "registry_test" );
    CHECK( settings_pages.front().title == "Registry test" );
    CHECK( settings_pages.front().category == "tools" );
    CHECK( settings_pages.front().order == 42 );
    CHECK_FALSE( cata::lua_ui::has_registered_pages( "main.extensions" ) );
    CHECK( cata::lua_ui::has_registered_pages( "ingame.extensions" ) );
    const cata::lua_ui::runtime_status status = cata::lua_ui::status();
    CHECK( status.page_count == 1 );
    CHECK( status.callback_count == 0 );
}

TEST_CASE( "lua_game_snapshots_are_bounded_read_only_values", "[lua][ui][game][integration]" )
{
    scoped_lua_user_script script;
    const avatar &player = get_avatar();
    const int moves_before = player.get_moves();
    const int stamina_before = player.get_stamina();
    const std::size_t inventory_size_before = player.inv_dump().size();
    const time_point turn_before = calendar::turn;
    const weather_type_id weather_before = get_weather_const().weather_id;

    script.write( R"lua(
local function assert_plain_snapshot(value, visited)
    local value_type = type(value)
    assert(value_type ~= "userdata")
    assert(value_type ~= "function")
    assert(value_type ~= "thread")
    if value_type ~= "table" then
        return
    end
    visited = visited or {}
    if visited[value] then
        return
    end
    visited[value] = true
    for key, child in pairs(value) do
        assert_plain_snapshot(key, visited)
        assert_plain_snapshot(child, visited)
    end
end

local player = game.player_snapshot()
assert(type(player) == "table")
assert(type(player.name) == "string")
assert(math.type(player.moves) == "integer")
assert(math.type(player.stamina) == "integer")
assert(math.type(player.stamina_max) == "integer")
assert(type(player.kcal_percent) == "number")
assert(type(player.bionic_power_kj) == "number")
assert(type(player.movement_mode_id) == "string")
assert(type(player.movement_mode_name) == "string")
assert(type(player.desired_movement_mode_id) == "string")
assert(type(player.desired_movement_mode_name) == "string")
assert(type(player.movement_mode_pending) == "boolean")
assert(math.type(player.x) == "integer")
assert(game.player_stats().name == player.name)
assert_plain_snapshot(player)

local movement = game.movement_modes_snapshot()
assert(type(movement.items) == "table")
assert(math.type(movement.count) == "integer")
assert(movement.count == #movement.items)
assert(type(movement.current_id) == "string")
assert(type(movement.desired_id) == "string")
for _, mode in ipairs(movement.items) do
    assert(type(mode.id) == "string")
    assert(type(mode.name) == "string")
    assert(type(mode.available) == "boolean")
    assert(type(mode.current) == "boolean")
    assert(type(mode.desired) == "boolean")
    assert(math.type(mode.switch_moves) == "integer")
    assert(type(mode.switch_seconds) == "number")
end
assert_plain_snapshot(movement)

local clock = game.time_snapshot()
assert(type(clock) == "table")
assert(math.type(clock.turn) == "integer")
assert(math.type(clock.year) == "integer")
assert(type(clock.season_id) == "string")
assert(type(clock.season_name) == "string")
assert(math.type(clock.day) == "integer")
assert(math.type(clock.hour) == "integer")
assert(math.type(clock.minute) == "integer")
assert(type(clock.display) == "string")
assert_plain_snapshot(clock)

local weather = game.weather_snapshot()
assert(type(weather) == "table")
assert(type(weather.id) == "string")
assert(type(weather.name) == "string")
assert(type(weather.temperature_c) == "number")
assert(type(weather.temperature_display) == "string")
assert(type(weather.dangerous) == "boolean")
assert(type(weather.raining) == "boolean")
assert(type(weather.sight_penalty) == "number")
assert_plain_snapshot(weather)

local inventory = game.inventory_snapshot()
assert(type(inventory) == "table")
assert(type(inventory.items) == "table")
assert(inventory.limit == 128)
assert(inventory.returned == #inventory.items)
assert(inventory.returned <= inventory.total)
assert(inventory.truncated == (inventory.returned < inventory.total))
assert_plain_snapshot(inventory)

for _, entry in ipairs(inventory.items) do
    assert(type(entry.id) == "string")
    assert(type(entry.name) == "string")
    assert(type(entry.category_id) == "string")
    assert(type(entry.category_name) == "string")
    assert(math.type(entry.charges) == "integer")
    assert(type(entry.count_by_charges) == "boolean")
    assert(type(entry.weight_grams) == "number")
    assert(type(entry.volume_ml) == "number")
    assert(type(entry.worn) == "boolean")
    assert(type(entry.wielded) == "boolean")
end

local zero = game.inventory_snapshot(0)
assert(zero.limit == 0)
assert(zero.returned == 0)
assert(#zero.items == 0)
assert(zero.total == inventory.total)

local capped = game.inventory_snapshot(1000000)
assert(capped.limit == 512)
assert(capped.returned <= 512)

local effects = game.effects_snapshot()
assert(type(effects.items) == "table")
assert(effects.limit == 64)
assert(effects.returned == #effects.items)
assert(effects.returned <= effects.total)
for _, entry in ipairs(effects.items) do
    assert(type(entry.id) == "string")
    assert(type(entry.name) == "string")
    assert(type(entry.description) == "string")
    assert(type(entry.body_part_id) == "string")
    assert(math.type(entry.duration_turns) == "integer")
    assert(math.type(entry.intensity) == "integer")
    assert(type(entry.permanent) == "boolean")
end
assert_plain_snapshot(effects)

local skills = game.skills_snapshot()
assert(type(skills.items) == "table")
assert(skills.limit == 128)
assert(skills.returned == #skills.items)
assert(skills.returned <= skills.total)
for _, entry in ipairs(skills.items) do
    assert(type(entry.id) == "string")
    assert(type(entry.name) == "string")
    assert(type(entry.description) == "string")
    assert(type(entry.level) == "number")
    assert(math.type(entry.exercise_percent) == "integer")
    assert(math.type(entry.knowledge_level) == "integer")
    assert(math.type(entry.knowledge_percent) == "integer")
    assert(type(entry.rusty) == "boolean")
    assert(type(entry.training) == "boolean")
    assert(type(entry.combat) == "boolean")
end
assert_plain_snapshot(skills)

local equipment = game.equipment_snapshot()
assert(type(equipment.has_weapon) == "boolean")
assert(type(equipment.worn) == "table")
assert(equipment.limit == 64)
assert(equipment.returned <= equipment.total)
assert(equipment.returned == #equipment.worn + (equipment.weapon and 1 or 0))
assert_plain_snapshot(equipment)

local missing_contents = game.item_contents_snapshot(0, 0)
assert(missing_contents.found == false)
assert(missing_contents.returned == 0)
assert(missing_contents.limit == 0)
if inventory.items[1] then
    assert(math.type(inventory.items[1].uid) == "integer")
    assert(math.type(inventory.items[1].contents_count) == "integer")
    local contents = game.item_contents_snapshot(inventory.items[1].uid, 8)
    assert(contents.found == true)
    assert(contents.limit == 8)
    assert(contents.returned == #contents.items)
    assert(contents.returned <= contents.total)
    assert(contents.item.uid == inventory.items[1].uid)
    assert_plain_snapshot(contents)
end

local tile = game.current_tile_snapshot()
assert(type(tile.terrain_id) == "string")
assert(type(tile.terrain_name) == "string")
assert(type(tile.furniture_id) == "string")
assert(type(tile.furniture_name) == "string")
assert(type(tile.outside) == "boolean")
assert(type(tile.passable) == "boolean")
assert(math.type(tile.move_cost) == "integer")
assert(type(tile.ambient_light) == "number")
assert(type(tile.dangerous_field) == "boolean")
assert(math.type(tile.item_count) == "integer")
assert(type(tile.trap_visible) == "boolean")
assert(type(tile.trap_id) == "string")
assert(type(tile.trap_name) == "string")
assert(type(tile.trap_dangerous) == "boolean")
assert(type(tile.fields) == "table")
assert(tile.field_limit == 32)
assert(tile.field_returned == #tile.fields)
assert(tile.field_returned <= tile.field_total)
for _, entry in ipairs(tile.fields) do
    assert(type(entry.id) == "string")
    assert(type(entry.name) == "string")
    assert(math.type(entry.intensity) == "integer")
    assert(math.type(entry.age_turns) == "integer")
    assert(type(entry.dangerous) == "boolean")
end
assert_plain_snapshot(tile)

local mutations = game.mutations_snapshot()
assert(type(mutations.items) == "table")
assert(mutations.limit == 128)
assert(mutations.returned == #mutations.items)
for _, entry in ipairs(mutations.items) do
    assert(type(entry.id) == "string")
    assert(type(entry.name) == "string")
    assert(type(entry.description) == "string")
    assert(type(entry.active) == "boolean")
    assert(type(entry.activatable) == "boolean")
    assert(type(entry.base_trait) == "boolean")
    assert(type(entry.purifiable) == "boolean")
    assert(type(entry.threshold) == "boolean")
    assert(math.type(entry.points) == "integer")
end
assert_plain_snapshot(mutations)

local bionics = game.bionics_snapshot()
assert(type(bionics.items) == "table")
assert(bionics.limit == 128)
assert(bionics.returned == #bionics.items)
for _, entry in ipairs(bionics.items) do
    assert(math.type(entry.uid) == "integer")
    assert(type(entry.id) == "string")
    assert(type(entry.name) == "string")
    assert(type(entry.description) == "string")
    assert(type(entry.powered) == "boolean")
    assert(type(entry.activatable) == "boolean")
    assert(type(entry.included) == "boolean")
    assert(math.type(entry.incapacitated_turns) == "integer")
    assert(math.type(entry.charge_timer_turns) == "integer")
    assert(type(entry.activation_cost_kj) == "number")
end
assert_plain_snapshot(bionics)

local missions = game.missions_snapshot()
assert(type(missions.items) == "table")
assert(missions.limit == 128)
assert(missions.returned == #missions.items)
for _, entry in ipairs(missions.items) do
    assert(math.type(entry.uid) == "integer")
    assert(type(entry.id) == "string")
    assert(type(entry.name) == "string")
    assert(type(entry.description) == "string")
    assert(type(entry.status) == "string")
    assert(type(entry.selected) == "boolean")
    assert(type(entry.has_deadline) == "boolean")
    assert(math.type(entry.deadline_turn) == "integer")
    assert(type(entry.has_target) == "boolean")
end
assert_plain_snapshot(missions)

local activity = game.activity_snapshot()
assert(type(activity.active) == "boolean")
assert(type(activity.current) == "table")
assert(type(activity.current.id) == "string")
assert(type(activity.current.verb) == "string")
assert(math.type(activity.current.moves_total) == "integer")
assert(math.type(activity.current.moves_left) == "integer")
assert(type(activity.current.interruptible) == "boolean")
assert(type(activity.current.progress_message) == "string")
assert(type(activity.current.progress) == "number")
assert(type(activity.backlog) == "table")
assert(activity.backlog_limit == 64)
assert(activity.backlog_returned == #activity.backlog)
assert_plain_snapshot(activity)

local creatures = game.nearby_creatures_snapshot()
assert(type(creatures.items) == "table")
assert(creatures.radius == 20)
assert(creatures.limit == 64)
assert(creatures.returned == #creatures.items)
for _, entry in ipairs(creatures.items) do
    assert(type(entry.name) == "string")
    assert(type(entry.kind) == "string")
    assert(type(entry.attitude) == "string")
    assert(math.type(entry.distance) == "integer")
    assert(math.type(entry.hp) == "integer")
    assert(math.type(entry.hp_max) == "integer")
end
assert_plain_snapshot(creatures)

local capped_creatures = game.nearby_creatures_snapshot(1000, 1000)
assert(capped_creatures.radius == 60)
assert(capped_creatures.limit == 256)

local negative_ok = pcall(function()
    game.inventory_snapshot(-1)
end)
assert(negative_ok == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
    CHECK( player.get_moves() == moves_before );
    CHECK( player.get_stamina() == stamina_before );
    CHECK( player.inv_dump().size() == inventory_size_before );
    CHECK( calendar::turn == turn_before );
    CHECK( get_weather_const().weather_id == weather_before );
}

TEST_CASE( "lua_game_actions_are_queued_validated_and_isolated",
           "[lua][ui][game][actions][integration]" )
{
    scoped_lua_user_script script;
    std::string error;

    script.write( R"lua(
local top_level_ok, top_level_error = pcall(function()
    game.actions.enqueue("wait")
end)
assert(top_level_ok == false)
assert(string.find(top_level_error, "active callback", 1, true) ~= nil)

local initial = game.actions.status()
assert(initial.pending_count == 0)
assert(initial.result_count == 0)
assert(initial.pending_limit == 64)

events.on("game_begin", function(event)
    local wait_id = game.actions.enqueue("wait")
    assert(math.type(wait_id) == "integer")
    assert(game.actions.cancel(wait_id) == true)
    assert(game.actions.cancel(wait_id) == false)

    local cancel_id = game.actions.enqueue("cancel_activity")
    assert(math.type(cancel_id) == "integer")
    local set_mode_id = game.actions.enqueue("set_move_mode", { id = "walk" })
    assert(math.type(set_mode_id) == "integer")
    local cycle_id = game.actions.enqueue("cycle_move_mode")
    assert(math.type(cycle_id) == "integer")

    assert(pcall(function()
        game.actions.enqueue("move", { direction = "sideways" })
    end) == false)
    assert(pcall(function()
        game.actions.enqueue("use_item", { uid = 0 })
    end) == false)
    assert(pcall(function()
        game.actions.enqueue("set_move_mode", { id = "../run" })
    end) == false)
    assert(pcall(function()
        game.actions.enqueue("unknown")
    end) == false)

    local queued = game.actions.status(0)
    assert(queued.pending_count == 3)
    assert(#queued.pending == 3)
    assert(queued.pending[1].type == "cancel_activity")
    assert(queued.pending[1].status == "queued")
    assert(queued.pending[2].type == "set_move_mode")
    assert(queued.pending[2].status == "queued")
    assert(queued.pending[3].type == "cycle_move_mode")
    assert(queued.pending[3].status == "queued")
    assert(queued.result_count == 1)
    assert(#queued.results == 0)
end)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );

    avatar &player = get_avatar();
    const move_mode_id original_desired_mode = player.get_desired_move_mode();
    player.set_desired_movement_mode( move_mode_id( "walk" ) );
    const move_mode_id desired_mode_before = player.get_desired_move_mode();
    get_event_bus().send<event_type::game_begin>( "lua-action-test" );
    const std::optional<bool> handled = cata::lua_ui::process_next_action();
    REQUIRE( handled );
    CHECK_FALSE( *handled );
    const std::optional<bool> set_mode = cata::lua_ui::process_next_action();
    REQUIRE( set_mode );
    CHECK_FALSE( *set_mode );
    const std::optional<bool> cycled = cata::lua_ui::process_next_action();
    REQUIRE( cycled );
    CHECK_FALSE( *cycled );
    CHECK( player.get_desired_move_mode() != desired_mode_before );
    CHECK_FALSE( cata::lua_ui::process_next_action() );

    script.write( R"lua(
local status = game.actions.status(1000000)
assert(status.pending_count == 0)
assert(status.result_count == 4)
assert(status.result_limit == 128)
assert(#status.results == 4)
assert(status.results[1].type == "wait")
assert(status.results[1].status == "canceled")
assert(status.results[1].action_taken == false)
assert(status.results[2].type == "cancel_activity")
assert(status.results[2].status == "failed")
assert(status.results[2].action_taken == false)
assert(string.find(status.results[2].error, "no activity", 1, true) ~= nil)
assert(status.results[3].type == "set_move_mode")
assert(status.results[3].status == "succeeded")
assert(status.results[3].action_taken == false)
assert(status.results[4].type == "cycle_move_mode")
assert(status.results[4].status == "succeeded")
assert(status.results[4].action_taken == false)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );

    player.set_desired_movement_mode( original_desired_mode );
    cata::lua_ui::shutdown();
    CHECK_FALSE( cata::lua_ui::process_next_action() );
}

TEST_CASE( "lua_named_context_actions_require_capability_and_one_time_confirmation",
           "[lua][actions][capability][integration]" )
{
    using namespace cata::input_context_actions;

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "4.0.0",
        "api_version": 4,
        "capabilities": [ "events", "game.actions" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
events.on("game_begin", function()
    local context = game.actions.context_snapshot()
    assert(context.available.SAFE_ACTION == true)
    assert(context.available.DANGEROUS_ACTION == false)
    local safe_id = game.actions.enqueue_context("SAFE_ACTION", context.revision)
    assert(math.type(safe_id) == "integer")
    local allowed, error = pcall(function()
        game.actions.enqueue_context("DANGEROUS_ACTION", context.revision)
    end)
    assert(allowed == false)
    assert(string.find(error, "game.actions.dangerous", 1, true) ~= nil)
end)
)lua" );

    publish( "LUA_TEST", "lua.test", "Lua test", {
        { "SAFE_ACTION", "Safe action", {}, false, false },
        { "DANGEROUS_ACTION", "Dangerous action", {}, false, true }
    } );
    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    get_event_bus().send<event_type::game_begin>( "named-action-capability" );
    const std::optional<bool> dispatched = cata::lua_ui::process_next_action();
    REQUIRE( dispatched );
    CHECK_FALSE( *dispatched );
    CHECK( has_pending() );
    std::string consumed;
    CHECK( consume( { "SAFE_ACTION", "DANGEROUS_ACTION" }, consumed ) );
    CHECK( consumed == "SAFE_ACTION" );

    script.write_manifest( R"json({
        "id": "user",
        "version": "4.0.0",
        "api_version": 4,
        "capabilities": [
            "events",
            "game.actions",
            "game.actions.dangerous"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
events.on("game_begin", function()
    local context = game.actions.context_snapshot()
    assert(context.available.DANGEROUS_ACTION == true)
    local request = game.actions.enqueue_context(
        "DANGEROUS_ACTION", context.revision)
    assert(game.actions.cancel(request) == true)
end)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    get_event_bus().send<event_type::game_begin>( "named-action-dangerous" );
    CHECK_FALSE( cata::lua_ui::process_next_action() );
    cata::input_context_actions::clear();
}

TEST_CASE( "lua_reload_is_transactional", "[lua][ui][integration]" )
{
    scoped_lua_user_script script;
    std::string error;

    script.write( R"lua(
game.state_set("test.transaction", "original")
ui.page("transaction_test", "Transaction test", function(ctx) end)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    const cata::lua_ui::runtime_status before = cata::lua_ui::status();

    script.write( R"lua(
assert(game.state_get("test.transaction", "missing") == "original")
game.state_set("test.transaction", "candidate mutation")
error("expected candidate failure")
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "expected candidate failure" ) != std::string::npos );

    const cata::lua_ui::runtime_status after_failure = cata::lua_ui::status();
    CHECK( after_failure.loaded );
    CHECK( after_failure.generation == before.generation );
    CHECK( after_failure.page_count == before.page_count );
    CHECK( after_failure.event_handler_count == before.event_handler_count );

    script.write( R"lua(
assert(game.state_get("test.transaction", "missing") == "original")
ui.page("transaction_test", "Transaction test", function(ctx) end)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( cata::lua_ui::status().generation == before.generation + 1 );
}

TEST_CASE( "lua_reload_preserves_supported_state_types", "[lua][ui][integration]" )
{
    scoped_lua_user_script script;
    std::string error;

    script.write( R"lua(
game.state_set("test.boolean", true)
game.state_set("test.integer", 42)
game.state_set("test.float", 1.25)
game.state_set("test.string", "value")
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );

    script.write( R"lua(
assert(game.state_get("test.boolean", false) == true)
assert(game.state_get("test.integer", 0) == 42)
assert(math.type(game.state_get("test.integer", 0)) == "integer")
assert(game.state_get("test.float", 0.0) == 1.25)
assert(math.type(game.state_get("test.float", 0.0)) == "float")
assert(game.state_get("test.string", "missing") == "value")
game.state_set("test.removed", "temporary")
game.state_set("test.removed", nil)
assert(game.state_get("test.removed", "fallback") == "fallback")
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
}

TEST_CASE( "lua_state_persists_per_character_and_recovers_from_damage",
           "[lua][ui][state][integration]" )
{
    scoped_lua_state_file state_file;
    scoped_lua_user_script script;
    std::string error;

    script.write( R"lua(
game.state_set("persist.boolean", true)
game.state_set("persist.integer", 5000000000)
game.state_set("persist.float", 1.25)
game.state_set("persist.string", "持久化")
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    REQUIRE( cata::lua_ui::save_persistent_state( error ) );
    CHECK( error.empty() );
    CHECK( state_file.exists() );

    cata::lua_ui::shutdown();
    script.write( R"lua(
assert(game.state_get("persist.boolean", false) == true)
assert(game.state_get("persist.integer", 0) == 5000000000)
assert(math.type(game.state_get("persist.integer", 0)) == "integer")
assert(game.state_get("persist.float", 0.0) == 1.25)
assert(math.type(game.state_get("persist.float", 0.0)) == "float")
assert(game.state_get("persist.string", "missing") == "持久化")
)lua" );
    cata::lua_ui::on_world_ready();
    CHECK( cata::lua_ui::status().loaded );
    CHECK( cata::lua_ui::status().last_error.empty() );

    cata::lua_ui::shutdown();
    state_file.write( "{ damaged json" );
    script.write( R"lua(
assert(game.state_get("persist.string", "default") == "default")
)lua" );
    cata::lua_ui::on_world_ready();
    const cata::lua_ui::runtime_status recovered = cata::lua_ui::status();
    CHECK( recovered.loaded );
    CHECK( recovered.last_error.find( "state load failed" ) != std::string::npos );
}

TEST_CASE( "lua_v3_state_scopes_are_namespaced_transactional_and_persistent",
           "[lua][ui][state][integration]" )
{
    using namespace cata::lua_ui;

    REQUIRE( world_generator );
    REQUIRE( world_generator->active_world != nullptr );
    scoped_lua_state_file character_file;
    scoped_lua_state_file world_file(
        ( world_generator->active_world->folder_path() /
          "lua_ui_world.json" ).get_unrelative_path() );
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "3.0.0",
        "api_version": 3,
        "capabilities": [
            "ui.pages",
            "events",
            "state.character",
            "state.world",
            "state.page"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.state_set("shared", "v2 compatibility")
state.character.set("shared", "character")
state.world.set("shared", "world")
state.character.set("integer", 5000000000)
state.world.set("float", 1.25)

local page_ok, page_error = pcall(function()
    state.page.get("outside", "missing")
end)
assert(page_ok == false)
assert(string.find(page_error, "only available while drawing a page", 1, true) ~= nil)

ui.page("state_scope_page", "State scope page", function(ctx)
    local draws = state.page.get("draws", 0)
    state.page.set("draws", draws + 1)
    ctx:text("state")
end)

events.on("game_begin", function(event)
    assert(pcall(function()
        state.page.set("outside_event", true)
    end) == false)
end)
)lua" );

    std::string error;
    REQUIRE( reload_scripts( error ) );
    get_event_bus().send<event_type::game_begin>( "state-scope-test" );
    REQUIRE( save_persistent_state( error ) );
    CHECK( error.empty() );
    REQUIRE( character_file.exists() );
    REQUIRE( world_file.exists() );

    const std::string character_json = character_file.read();
    CHECK( character_json.find( "\"shared\"" ) != std::string::npos );
    CHECK( character_json.find( "v3:character:4:user:shared" ) !=
           std::string::npos );
    CHECK( character_json.find( "v2 compatibility" ) != std::string::npos );
    CHECK( character_json.find( "\"character\"" ) != std::string::npos );
    const std::string world_json = world_file.read();
    CHECK( world_json.find( "v3:world:4:user:shared" ) != std::string::npos );
    CHECK( world_json.find( "\"world\"" ) != std::string::npos );

    shutdown();
    script.write( R"lua(
assert(game.state_get("shared", "missing") == "v2 compatibility")
assert(state.character.get("shared", "missing") == "character")
assert(state.world.get("shared", "missing") == "world")
assert(state.character.get("integer", 0) == 5000000000)
assert(math.type(state.character.get("integer", 0)) == "integer")
assert(state.world.get("float", 0.0) == 1.25)
assert(math.type(state.world.get("float", 0.0)) == "float")
)lua" );
    on_world_ready();
    REQUIRE( status().loaded );
    CHECK( status().last_error.empty() );

    script.write( R"lua(
assert(state.character.get("shared", "missing") == "character")
assert(state.world.get("shared", "missing") == "world")
state.character.set("shared", "candidate character")
state.world.set("shared", "candidate world")
error("expected scoped-state transaction failure")
)lua" );
    CHECK_FALSE( reload_scripts( error ) );
    CHECK( error.find( "expected scoped-state transaction failure" ) !=
           std::string::npos );

    script.write( R"lua(
assert(state.character.get("shared", "missing") == "character")
assert(state.world.get("shared", "missing") == "world")
)lua" );
    REQUIRE( reload_scripts( error ) );
}

TEST_CASE( "lua_event_payloads_are_typed_and_callbacks_are_isolated", "[lua][ui][integration]" )
{
    scoped_lua_user_script script;
    std::string error;

    script.write( R"lua(
events.on("game_begin", function(event)
    assert(event.type == "game_begin")
    assert(math.type(event.turn) == "integer")
    assert(event.data.cdda_version == "lua-ui-test")
    assert(event.data_types.cdda_version == "string")
    local count = game.state_get("test.good_event_count", 0)
    game.state_set("test.good_event_count", count + 1)
end)

events.on("game_begin", function(event)
    local count = game.state_get("test.bad_event_count", 0)
    game.state_set("test.bad_event_count", count + 1)
    error("expected isolated callback failure")
end)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );

    get_event_bus().send<event_type::game_begin>( "lua-ui-test" );
    const cata::lua_ui::runtime_status after_failure = cata::lua_ui::status();
    CHECK( after_failure.loaded );
    CHECK( after_failure.last_error.find( "expected isolated callback failure" ) != std::string::npos );

    get_event_bus().send<event_type::game_begin>( "lua-ui-test" );
    script.write( R"lua(
assert(game.state_get("test.good_event_count", 0) == 2)
assert(game.state_get("test.bad_event_count", 0) == 1)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
}
