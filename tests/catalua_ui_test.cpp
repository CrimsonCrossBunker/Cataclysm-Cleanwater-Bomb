#include "cata_catch.h"
#include "avatar.h"
#include "bionics.h"
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
#include "catalua_ui_callbacks.h"
#include "catalua_ui_events.h"
#include "catalua_ui_i18n.h"
#include "catalua_ui_manifest.h"
#include "catalua_ui_mapgen.h"
#include "catalua_ui_modules.h"
#include "catalua_ui_navigation.h"
#include "catalua_ui_navigation_internal.h"
#include "catalua_ui_renderer.h"
#include "catalua_ui_scheduler.h"
#include "catalua_ui_services.h"
#include "catalua_ui_state.h"
#include "effect.h"
#include "event_bus.h"
#include "flag.h"
#include "game.h"
#include "input_context_actions.h"
#include "item.h"
#include "itype.h"
#include "json_loader.h"
#include "magic.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "mapgendata.h"
#include "mission.h"
#include "monster.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "projectile.h"
#include "requirements.h"
#include "trap.h"
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
#include <list>
#include <map>
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

TEST_CASE( "lua_v5_hook_and_callback_catalogs_are_complete_and_bounded",
           "[lua][bindings][hooks][callbacks]" )
{
    using namespace cata::lua_ui;

    const std::vector<script_hook_spec> &hooks = script_hook_specs();
    REQUIRE( hooks.size() == 48 );
    std::vector<std::string_view> hook_names;
    hook_names.reserve( hooks.size() );
    for( const script_hook_spec &hook : hooks ) {
        CHECK_FALSE( hook.name.empty() );
        CHECK_FALSE( script_hook_mode_name( hook.mode ).empty() );
        hook_names.push_back( hook.name );
    }
    std::sort( hook_names.begin(), hook_names.end() );
    CHECK( std::adjacent_find( hook_names.begin(), hook_names.end() ) ==
           hook_names.end() );
    REQUIRE( find_script_hook_spec( "on_try_npc_interaction" ) != nullptr );
    CHECK( find_script_hook_spec( "on_try_npc_interaction" )->mode ==
           script_hook_mode::intercept );
    CHECK( find_script_hook_spec( "on_weather_updated" )->mode ==
           script_hook_mode::observe );
    CHECK( find_script_hook_spec( "not_a_hook" ) == nullptr );

    const std::vector<script_callback_kind_spec> &kinds =
        script_callback_kind_specs();
    REQUIRE( kinds.size() == 11 );
    std::size_t method_count = 0;
    for( const script_callback_kind_spec &kind : kinds ) {
        CHECK_FALSE( kind.kind.empty() );
        CHECK_FALSE( kind.target_id_kind.empty() );
        CHECK_FALSE( kind.methods.empty() );
        method_count += kind.methods.size();
        for( const script_callback_method_spec &method : kind.methods ) {
            CHECK_FALSE( method.name.empty() );
            CHECK( find_script_callback_method_spec( kind, method.name ) !=
                   nullptr );
        }
    }
    CHECK( method_count == 38 );
    REQUIRE( find_script_callback_kind_spec( "iranged" ) != nullptr );
    CHECK( find_script_callback_method_spec(
               *find_script_callback_kind_spec( "iranged" ),
               "can_fire" )->decision );
    CHECK( find_script_callback_kind_spec( "not_an_actor" ) == nullptr );

    script_callback_registry registry;
    const std::uint64_t low = registry.subscribe(
                                  "iwieldable", "cudgel", { "on_wield" },
                                  -10, 1, false );
    const std::uint64_t high_first = registry.subscribe(
                                         "iwieldable", "cudgel",
    { "can_wield", "on_wield" },
    100, 1, false );
    const std::uint64_t high_second = registry.subscribe(
                                          "iwieldable", "cudgel",
    { "on_wield" }, 100, 2, true );
    registry.subscribe(
        "iwieldable", "rock", { "on_wield" }, 1000, 2, false );

    const std::vector<script_callback_registration> matching =
        registry.matching( "iwieldable", "cudgel", "on_wield" );
    REQUIRE( matching.size() == 3 );
    CHECK( matching[0].id == high_first );
    CHECK( matching[1].id == high_second );
    CHECK( matching[2].id == low );
    CHECK( matching[1].once );
    CHECK( registry.matching(
               "iwieldable", "cudgel", "can_wield" ).size() == 1 );
    CHECK_FALSE( registry.unsubscribe( high_second, 1 ) );
    CHECK( registry.unsubscribe( high_second, 2 ) );
    CHECK( registry.unsubscribe_unchecked( low ) );
    CHECK_THROWS_AS(
        registry.subscribe(
            "missing", "cudgel", { "on_wield" }, 0, 1, false ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        registry.subscribe(
            "iwieldable", "cudgel", { "missing" }, 0, 1, false ),
        std::invalid_argument );
    CHECK_THROWS_AS(
        registry.subscribe(
            "iwieldable", "cudgel", { "on_wield" },
            script_callback_registry::maximum_priority + 1, 1, false ),
        std::invalid_argument );
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
    CHECK( binding_domain_is_covered( "crafting" ) );
    CHECK( binding_domain_is_covered( "mapgen" ) );

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
    const std::string original_status = first_entry["status"];
    first_entry["id"] = "mutated";
    first_entry["status"] = "mutated";

    sol::protected_function_result second_result = api_catalog();
    REQUIRE( second_result.valid() );
    sol::table second = second_result;
    sol::table second_entry = second[1];
    CHECK( second_entry.get<std::string>( "id" ) == original_id );
    CHECK( second_entry.get<std::string>( "status" ) == original_status );

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

TEST_CASE( "lua_v5_mutation_definitions_are_detached_paginated_snapshots",
           "[lua][bindings][mutations][definitions][integration]" )
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
local definitions = game.mutations.definitions({
    offset = 0,
    limit = 1000000
})
assert(definitions.limit == 256)
assert(definitions.returned == #definitions.items)
assert(definitions.returned <= definitions.total)
assert(definitions.has_more ==
    (definitions.offset + definitions.returned < definitions.total))

local speed = game.types.id("mutation", "DEBUG_SPEED")
local definition = game.mutations.definition(speed)
assert(definition.id == speed)
assert(type(definition.name) == "string")
assert(type(definition.description) == "string")
assert(type(definition.availability.valid) == "boolean")
assert(type(definition.availability.debug) == "boolean")
assert(definition.activation.activated == true)
assert(definition.activation.cooldown.turns >= 0)
assert(math.type(definition.statistics.points) == "integer")
assert(type(definition.statistics.body_temperature_minimum_celsius_delta) ==
    "number")
assert(type(definition.equipment.destroys_gear) == "boolean")
assert(definition.relations.prerequisites.returned ==
    #definition.relations.prerequisites.items)
assert(definition.relations.conflicts_with.returned ==
    #definition.relations.conflicts_with.items)
assert(definition.relations.categories.returned ==
    #definition.relations.categories.items)
assert(definition.variants.returned == #definition.variants.items)
assert(definition.learned_spells.returned ==
    #definition.learned_spells.items)

assert(pcall(function()
    game.mutations.definitions({ offset = -1 })
end) == false)
assert(pcall(function()
    game.mutations.definitions({ unknown = 1 })
end) == false)
assert(pcall(function()
    game.mutations.definition(game.types.id("item", "rock"))
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_character_mutations_are_generation_safe_and_write_gated",
           "[lua][bindings][mutations][state][write][integration]" )
{
    avatar &player = get_avatar();
    const trait_id debug_speed( "DEBUG_SPEED" );
    const bool originally_present =
        player.has_permanent_trait( debug_speed );
    if( originally_present ) {
        player.unset_mutation( debug_speed );
    }
    on_out_of_scope cleanup( [&player, debug_speed,
    originally_present]() {
        if( player.has_permanent_trait( debug_speed ) ) {
            player.unset_mutation( debug_speed );
        }
        if( originally_present ) {
            player.set_mutation( debug_speed );
        }
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
local speed = game.types.id("mutation", "DEBUG_SPEED")

local initial = game.mutations.list(avatar, {
    offset = 0,
    limit = 1000000,
    include_hidden = true,
    include_enchantment = true
})
assert(initial.ok == true)
assert(initial.value.limit == 256)
assert(initial.value.returned == #initial.value.items)
assert(initial.value.has_more ==
    (initial.value.offset + initial.value.returned < initial.value.total))
assert(game.mutations.has(avatar, speed).value == false)
assert(game.mutations.get(avatar, speed).ok == false)

local granted = game.mutations.grant(avatar, speed)
assert(granted.ok == true)
assert(granted.value.id == speed)
assert(granted.value.permanent == true)
assert(granted.value.activatable == true)
assert(granted.value.active == false)
assert(game.mutations.has(avatar, speed).value == true)
assert(game.mutations.get(avatar, speed).value.id == speed)
assert(game.mutations.grant(avatar, speed).error.code ==
    "already_present")

local activated = game.mutations.set_active(avatar, speed, true)
assert(activated.ok == true)
assert(activated.value.accepted == true)
assert(activated.value.after.active == true)
local deactivated = game.mutations.set_active(avatar, speed, false)
assert(deactivated.ok == true)
assert(deactivated.value.accepted == true)
assert(deactivated.value.after.active == false)

assert(pcall(function()
    game.mutations.list(avatar, { limit = -1 })
end) == false)
assert(pcall(function()
    game.mutations.list(avatar, { include_hidden = 1 })
end) == false)
assert(pcall(function()
    game.mutations.list(avatar, { unknown = true })
end) == false)
assert(pcall(function()
    game.mutations.set_variant(avatar, speed, "unknown")
end) == false)
assert(pcall(function()
    game.mutations.has(avatar, game.types.id("item", "rock"))
end) == false)

local removed = game.mutations.remove(avatar, speed)
assert(removed.ok == true)
assert(removed.value.removed.id == speed)
assert(removed.value.present == false)
assert(game.mutations.has(avatar, speed).value == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
    CHECK_FALSE( player.has_permanent_trait( debug_speed ) );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.mutations.grant(
    game.characters.avatar(),
    game.types.id("mutation", "DEBUG_SPEED"))
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
    CHECK_FALSE( player.has_permanent_trait( debug_speed ) );
}

TEST_CASE( "lua_v5_spell_definitions_and_known_spells_are_detached_and_bounded",
           "[lua][bindings][spells][definitions][integration]" )
{
    avatar &player = get_avatar();
    const spell_id test_spell( "test_spell_pew" );
    const bool originally_known =
        player.magic->knows_spell( test_spell );
    if( !originally_known ) {
        player.magic->learn_spell(
            test_spell, player, true );
    }
    on_out_of_scope cleanup( [&player, test_spell,
    originally_known]() {
        if( !originally_known &&
            player.magic->knows_spell( test_spell ) ) {
            player.magic->forget_spell( test_spell );
        }
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
local pew = game.types.id("spell", "test_spell_pew")

local definitions = game.spells.definitions({
    offset = 0,
    limit = 1000000
})
assert(definitions.limit == 256)
assert(definitions.returned == #definitions.items)
assert(definitions.returned <= definitions.total)
assert(definitions.has_more ==
    (definitions.offset + definitions.returned < definitions.total))

local definition = game.spells.definition(pew)
assert(definition.id == pew)
assert(type(definition.name) == "string")
assert(type(definition.description) == "string")
assert(type(definition.effect) == "string")
assert(type(definition.shape) == "string")
assert(type(definition.energy_source) == "string")
assert(type(definition.formulas.minimum_damage.dynamic) == "boolean")
assert(definition.formulas.minimum_damage.minimum ~= nil)
assert(definition.valid_targets.returned ==
    #definition.valid_targets.items)
assert(definition.flags.returned == #definition.flags.items)
assert(definition.additional_spells.returned ==
    #definition.additional_spells.items)

local known = game.spells.list(avatar, {
    offset = 0,
    limit = 1000000
})
assert(known.ok == true)
assert(known.value.limit == 256)
assert(known.value.returned == #known.value.items)
assert(known.value.has_more ==
    (known.value.offset + known.value.returned < known.value.total))
assert(game.spells.knows(avatar, pew).value == true)
local fetched = game.spells.get(avatar, pew)
assert(fetched.ok == true)
assert(fetched.value.id == pew)
assert(math.type(fetched.value.experience) == "integer")
assert(math.type(fetched.value.level) == "integer")
assert(math.type(fetched.value.maximum_level) == "integer")
assert(type(fetched.value.can_cast) == "boolean")
assert(type(fetched.value.has_enough_energy) == "boolean")
assert(type(fetched.value.failure_probability) == "number")
assert(math.type(fetched.value.casting_time_moves) == "integer")
assert(fetched.value.duration.turns >= 0)
local learn = game.spells.can_learn(avatar, pew)
assert(learn.ok == true)
assert(learn.value.known == true)
assert(type(learn.value.can_learn) == "boolean")
assert(learn.value.time.turns >= 0)

assert(pcall(function()
    game.spells.definitions({ limit = -1 })
end) == false)
assert(pcall(function()
    game.spells.list(avatar, { unknown = 1 })
end) == false)
assert(pcall(function()
    game.spells.get(avatar, game.types.id("item", "rock"))
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_spellbook_mana_and_casting_operations_are_controlled",
           "[lua][bindings][spells][write][integration]" )
{
    avatar &player = get_avatar();
    const spell_id kiss( "test_spell_kiss" );
    const spell_id primer( "ink_gland_spray_primer" );
    const bool kiss_known = player.magic->knows_spell( kiss );
    const bool primer_known =
        player.magic->knows_spell( primer );
    const int kiss_experience = kiss_known ?
                                player.magic->get_spell( kiss ).xp() : 0;
    const int primer_experience = primer_known ?
                                  player.magic->get_spell( primer ).xp() : 0;
    const int original_mana = player.magic->available_mana();
    const bool original_ignore = player.magic->casting_ignore;
    const spell_id original_last = player.magic->last_spell;
    const bool kiss_favorite =
        player.magic->is_favorite( kiss );
    const bool primer_favorite =
        player.magic->is_favorite( primer );
    REQUIRE( player.activity.is_null() );
    if( kiss_known ) {
        player.magic->set_spell_level( kiss, -1, &player );
    }
    if( primer_known ) {
        player.magic->set_spell_level(
            primer, -1, &player );
    }
    on_out_of_scope cleanup( [&player, kiss, primer, kiss_known,
    primer_known, kiss_experience, primer_experience,
    original_mana, original_ignore, original_last,
    kiss_favorite, primer_favorite]() {
        if( !player.activity.is_null() ) {
            player.cancel_activity();
        }
        const auto restore_spell =
        [&player]( const spell_id & id, const bool known,
                   const int experience, const bool favorite ) {
            if( player.magic->knows_spell( id ) ) {
                player.magic->set_spell_level(
                    id, -1, &player );
            }
            if( known ) {
                player.magic->learn_spell(
                    id, player, true );
                player.magic->set_spell_exp(
                    id, experience, &player );
            }
            if( player.magic->is_favorite( id ) !=
                favorite ) {
                player.magic->toggle_favorite( id );
            }
        };
        restore_spell(
            kiss, kiss_known, kiss_experience,
            kiss_favorite );
        restore_spell(
            primer, primer_known, primer_experience,
            primer_favorite );
        player.magic->set_mana( original_mana );
        player.magic->casting_ignore = original_ignore;
        player.magic->last_spell = original_last;
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
local kiss = game.types.id("spell", "test_spell_kiss")
local primer = game.types.id("spell", "ink_gland_spray_primer")

local learned = game.spells.learn(avatar, kiss, {
    force = true,
    experience = 100
})
assert(learned.ok == true)
assert(learned.value.id == kiss)
assert(learned.value.experience == 100)
assert(game.spells.learn(avatar, kiss, { force = true }).error.code ==
    "already_known")

local gained = game.spells.gain_experience(avatar, kiss, 50)
assert(gained.ok == true)
assert(gained.value.after.experience >=
    gained.value.before.experience)
local leveled = game.spells.set_level(avatar, kiss, 2)
assert(leveled.ok == true)
assert(leveled.value.after.level == 2)
local more_levels = game.spells.gain_levels(avatar, kiss, 1)
assert(more_levels.ok == true)
assert(more_levels.value.after.level >=
    more_levels.value.before.level)
local reset_exp = game.spells.set_experience(avatar, kiss, 200)
assert(reset_exp.ok == true)
assert(reset_exp.value.after.experience == 200)

local mana = game.spells.mana(avatar)
assert(mana.ok == true)
assert(math.type(mana.value.current) == "integer")
assert(math.type(mana.value.maximum) == "integer")
assert(type(mana.value.regeneration_per_turn) == "number")
local full = game.spells.set_mana(avatar, mana.value.maximum)
assert(full.ok == true)
assert(full.value.after.current == mana.value.maximum)
local spent = game.spells.modify_mana(avatar, -1)
assert(spent.ok == true)
assert(spent.value.after.current ==
    math.max(0, spent.value.before.current - 1))
local ignore = game.spells.set_casting_ignore(
    avatar, not mana.value.casting_ignore)
assert(ignore.ok == true)
assert(ignore.value.after == not mana.value.casting_ignore)
local favorite = game.spells.set_favorite(avatar, kiss, true)
assert(favorite.ok == true and favorite.value.after == true)

local learned_primer = game.spells.learn(avatar, primer, {
    force = true
})
assert(learned_primer.ok == true)
local current = game.spells.mana(avatar).value
game.spells.set_mana(avatar, current.maximum)
local position = game.creatures.snapshot(avatar).value.position
local queued = game.spells.queue_cast(avatar, primer, position)
assert(queued.ok == true)
assert(queued.value.accepted == true)
assert(queued.value.spell.id == primer)
assert(queued.value.target == position)
assert(queued.value.activity.kind == "activity")

assert(pcall(function()
    game.spells.learn(avatar, kiss, { unknown = true })
end) == false)
assert(pcall(function()
    game.spells.set_experience(avatar, kiss, -1)
end) == false)
assert(pcall(function()
    game.spells.gain_levels(avatar, kiss, 0)
end) == false)
assert(pcall(function()
    game.spells.set_mana(avatar, -1)
end) == false)
assert(pcall(function()
    game.spells.queue_cast(
        avatar, primer, game.coords.tripoint_rel_ms(0, 0, 0))
end) == false)

local forgotten = game.spells.forget(avatar, kiss)
assert(forgotten.ok == true)
assert(forgotten.value.forgotten.id == kiss)
assert(forgotten.value.known == false)
assert(game.spells.knows(avatar, kiss).value == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
    CHECK_FALSE( player.activity.is_null() );
    player.cancel_activity();
    if( player.magic->knows_spell( kiss ) ) {
        player.magic->set_spell_level( kiss, -1, &player );
    }

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.spells.learn(
    game.characters.avatar(),
    game.types.id("spell", "test_spell_kiss"),
    { force = true })
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
    CHECK_FALSE( player.magic->knows_spell( kiss ) );
}

TEST_CASE( "lua_v5_missions_use_detached_definitions_and_generation_tokens",
           "[lua][bindings][missions][lifecycle][integration]" )
{
    avatar &player = get_avatar();
    const std::size_t world_count_before =
        mission::get_all_active().size();
    const std::size_t active_count_before =
        player.get_active_missions().size();

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read", "game.write" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local test_id = game.types.id(
    "mission", "TEST_MISSION_GOAL_CONDITION1")
local definitions = game.missions.definitions({
    offset = 0,
    limit = 1000000
})
assert(definitions.limit == 256)
assert(definitions.returned == #definitions.items)
assert(definitions.returned <= definitions.total)
assert(definitions.has_more ==
    (definitions.offset + definitions.returned < definitions.total))

local definition = game.missions.definition(test_id)
assert(definition.id == test_id)
assert(type(definition.name) == "string")
assert(type(definition.description) == "string")
assert(definition.goal.kind == "MissionGoal")
assert(math.type(definition.difficulty) == "integer")
assert(type(definition.deadline.dynamic) == "boolean")
assert(definition.origins.returned == #definition.origins.items)
assert(definition.likely_rewards.returned ==
    #definition.likely_rewards.items)
assert(definition.dialogue.returned == #definition.dialogue.items)

local reserved = game.missions.reserve(test_id)
assert(reserved.ok == true)
assert(reserved.value.id == test_id)
assert(reserved.value.status == "reserved")
assert(reserved.value.assigned == false)
local token = reserved.value.token
assert(math.type(token.uid) == "integer")
assert(token:is_valid() == true)
assert(type(tostring(token)) == "string")
assert(game.missions.get(token).value.uid == token.uid)

local listed = game.missions.list({
    offset = 0,
    limit = 1000000,
    scope = "all",
    status = "reserved"
})
assert(listed.limit == 256)
assert(listed.returned == #listed.items)
local found = false
for _, entry in ipairs(listed.items) do
    if entry.uid == token.uid then
        found = true
    end
end
assert(found)

local assigned = game.missions.assign(token)
assert(assigned.ok == true)
assert(assigned.value.status == "active")
assert(assigned.value.assigned == true)
assert(assigned.value.selected == true)
local selected = game.missions.select(token)
assert(selected.ok == true and selected.value.selected == true)
assert(game.missions.current().value.uid == token.uid)
assert(type(game.missions.is_complete(token).value) == "boolean")
local stepped = game.missions.step_complete(token, 1)
assert(stepped.ok == true and stepped.value.step == 1)

local abandoned = game.missions.abandon(token)
assert(abandoned.ok == true)
assert(abandoned.value.removed == true)
assert(token:is_valid() == false)
assert(game.missions.get(token).error.code == "missing_mission")

local second = game.missions.reserve(test_id)
assert(second.ok == true)
local second_token = second.value.token
local cancelled = game.missions.cancel(second_token)
assert(cancelled.ok == true)
assert(cancelled.value.removed == true)
assert(second_token:is_valid() == false)

local origin = game.enums.value(
    "MissionOrigin", "ORIGIN_GAME_START")
local omt = game.coords.tripoint_abs_omt(0, 0, 0)
local random = game.missions.random_definition(origin, omt)
assert(random.ok == true)
assert(random.value.kind == "mission")

assert(pcall(function()
    game.missions.definitions({ limit = -1 })
end) == false)
assert(pcall(function()
    game.missions.list({ scope = "unknown" })
end) == false)
assert(pcall(function()
    game.missions.reserve(game.types.id("item", "rock"))
end) == false)
assert(pcall(function()
    game.missions.random_definition(
        origin, game.coords.tripoint_rel_ms(0, 0, 0))
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
    CHECK( mission::get_all_active().size() ==
           world_count_before );
    CHECK( player.get_active_missions().size() ==
           active_count_before );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.missions.reserve(
    game.types.id(
        "mission", "TEST_MISSION_GOAL_CONDITION1"))
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
    CHECK( mission::get_all_active().size() ==
           world_count_before );
    CHECK( player.get_active_missions().size() ==
           active_count_before );
}

TEST_CASE( "lua_v5_world_reads_bounded_active_map_snapshots",
           "[lua][bindings][world][map][integration]" )
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
local avatar = game.creatures.snapshot(
    game.creatures.avatar()).value
local position = avatar.position
local bounds = game.world.bounds()
assert(bounds.minimum.origin == "abs")
assert(bounds.minimum.scale == "ms")
assert(bounds.maximum.origin == "abs")
assert(bounds.map_squares > 0)
assert(bounds.submaps > 0)

local tile = game.world.tile(position, {
    item_limit = 1000000,
    field_limit = 1000000
})
assert(tile.position == position)
assert(tile.terrain.kind == "terrain")
assert(tile.terrain:is_valid())
assert(type(tile.terrain_name) == "string")
assert(type(tile.outside) == "boolean")
assert(type(tile.passable) == "boolean")
assert(math.type(tile.move_cost) == "integer")
assert(type(tile.ambient_light) == "number")
assert(tile.items.limit == 128)
assert(tile.items.returned == #tile.items.items)
assert(tile.items.returned <= tile.items.total)
assert(tile.fields.limit == 128)
assert(tile.fields.returned == #tile.fields.items)
assert(tile.vehicle.present == false or
    tile.vehicle.handle:is_valid())

for _, entry in ipairs(tile.items.items) do
    assert(entry.handle:is_valid())
    assert(entry.id.kind == "item")
    assert(math.type(entry.uid) == "integer")
end
for _, entry in ipairs(tile.fields.items) do
    assert(entry.id.kind == "field")
    assert(entry.age.turns ~= nil)
end

local region = game.world.region(position, {
    radius = 1000000,
    radius_z = 1000000,
    offset = 0,
    limit = 1,
    item_limit = 0,
    field_limit = 0
})
assert(region.radius == 30)
assert(region.radius_z == 5)
assert(region.limit == 1)
assert(region.returned == #region.items)
assert(region.returned <= region.total)
assert(region.has_more ==
    (region.offset + region.returned < region.total))

local vehicles = game.world.vehicles({
    offset = 0,
    limit = 1000000
})
assert(vehicles.limit == 256)
assert(vehicles.returned == #vehicles.items)
assert(vehicles.returned <= vehicles.total)

assert(pcall(function()
    game.world.tile(game.coords.tripoint_rel_ms(0, 0, 0))
end) == false)
assert(pcall(function()
    game.world.tile(position, { unknown = 1 })
end) == false)
assert(pcall(function()
    game.world.region(position, { radius = -1 })
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( "game.world.bounds()" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.read" ) != std::string::npos );
}

TEST_CASE( "lua_v5_world_applies_controlled_active_map_mutations",
           "[lua][bindings][world][map][write][integration]" )
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
local position = game.creatures.snapshot(
    game.creatures.avatar()).value.position
local before = game.world.tile(position)
local web = game.types.id("field", "fd_web")
local original_web = nil
for _, entry in ipairs(before.fields.items) do
    if entry.id == web then
        original_web = entry
    end
end
local spawned_handle = nil

local ok, failure = pcall(function()
    local terrain = game.world.set_terrain(
        position, before.terrain)
    assert(terrain.ok == true)
    assert(terrain.value.accepted == true)
    assert(terrain.value.after.kind == before.terrain.kind)
    assert(terrain.value.after.value == before.terrain.value)

    local furniture = game.world.set_furniture(
        position, before.furniture)
    assert(furniture.ok == true)
    assert(furniture.value.accepted == true)
    assert(furniture.value.changed == false)

    local trap = game.world.set_trap(
        position, before.trap)
    assert(trap.ok == true)
    assert(trap.value.accepted == true)
    assert(trap.value.changed == false)

    if original_web ~= nil then
        local cleared = game.world.remove_field(position, web)
        assert(cleared.ok == true)
        assert(cleared.value.removed == true)
    end
    local placed = game.world.put_field(
        position, web, 1, game.time.duration(0, "turn"))
    assert(placed.ok == true)
    assert(placed.value.id == web)
    assert(placed.value.after_intensity == 1)
    assert(placed.value.after_age.turns == 0)

    local removed_field = game.world.remove_field(position, web)
    assert(removed_field.ok == true)
    assert(removed_field.value.removed == true)
    assert(game.world.remove_field(position, web).value.removed == false)

    local backpack = game.types.id("item", "backpack")
    local spawned = game.world.spawn_item(position, backpack, 1)
    assert(spawned.ok == true)
    if spawned.value.items[1] ~= nil then
        spawned_handle = spawned.value.items[1].handle
    end
    assert(spawned.value.added == 1)
    assert(spawned.value.count_by_charges == false)
    assert(spawned.value.instances == 1)
    assert(#spawned.value.items == 1)
    assert(spawned_handle:is_valid())

    local wrong_kind = game.world.remove_item(
        position, game.creatures.avatar())
    assert(wrong_kind.ok == false)
    assert(wrong_kind.error.code == "wrong_kind")
    local removed_item = game.world.remove_item(
        position, spawned_handle)
    assert(removed_item.ok == true)
    assert(removed_item.value.removed == true)
    assert(spawned_handle:is_valid() == false)
    spawned_handle = nil

    assert(pcall(function()
        game.world.set_terrain(
            position, backpack)
    end) == false)
    assert(pcall(function()
        game.world.put_field(
            position, web, 1000000,
            game.time.duration(0, "turn"))
    end) == false)
    assert(pcall(function()
        game.world.put_field(
            position, web, 1,
            game.time.duration(366, "day"))
    end) == false)
    assert(pcall(function()
        game.world.spawn_item(position, backpack, 101)
    end) == false)
end)

if spawned_handle ~= nil and spawned_handle:is_valid() then
    game.world.remove_item(position, spawned_handle)
end
game.world.remove_field(position, web)
if original_web ~= nil then
    game.world.put_field(
        position, web, original_web.intensity,
        original_web.age)
end
assert(ok, failure)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local position = game.creatures.snapshot(
    game.creatures.avatar()).value.position
local terrain = game.world.tile(position).terrain
game.world.set_terrain(position, terrain)
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
}

TEST_CASE( "lua_v5_overmap_reads_existing_tiles_with_bounded_search",
           "[lua][bindings][world][overmap][read][integration]" )
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
local avatar = game.creatures.snapshot(
    game.creatures.avatar()).value
local origin = avatar.position:project_to("overmap_terrain")
local limits = game.overmap.limits()
assert(limits.maximum_radius == 60)
assert(limits.maximum_radius_z == 5)
assert(limits.maximum_limit == 256)
assert(limits.maximum_selectors == 16)
assert(limits.maximum_note_bytes == 4096)
assert(limits.maximum_reveal_radius == 30)
assert(limits.existing_only == true)

local tile = game.overmap.tile(origin)
assert(tile.exists == true)
assert(tile.position == origin)
assert(tile.terrain.kind == "overmap_terrain")
assert(tile.terrain:is_valid())
assert(type(tile.name) == "string")
assert(type(tile.visible_name) == "string")
assert(tile.vision.kind == "OmVisionLevel")
assert(type(tile.seen) == "boolean")
assert(type(tile.explored) == "boolean")
assert(type(tile.generated) == "boolean")

local exact = game.enums.value("OtMatchType", "exact")
local selector = { terrain = tile.terrain, match = exact }
assert(game.overmap.matches(origin, tile.terrain) == true)
assert(game.overmap.matches(origin, tile.terrain, exact) == true)
assert(game.overmap.matches(origin, {
    terrain = tile.terrain,
    match = game.enums.value("OtMatchType", "contains"),
}) == true)

local options = {
    types = { selector },
    radius = 0,
    radius_z = 0,
    seen = tile.seen,
    explored = tile.explored,
    limit = 1,
}
local found = game.overmap.search(origin, options)
assert(found.total == 1)
assert(found.returned == 1)
assert(found.scanned == 1)
assert(found.existing == 1)
assert(found.items[1].position == origin)
assert(found.items[1].terrain == tile.terrain)
assert(found.existing_only == true)

local closest = game.overmap.closest(origin, options)
assert(closest.ok == true)
assert(closest.value.position == origin)
local sampled = game.overmap.random(origin, options)
assert(sampled.ok == true)
assert(sampled.value.position == origin)

local excluded = game.overmap.search(origin, {
    exclude_types = { tile.terrain },
    radius = 0,
})
assert(excluded.total == 0)
local missing = game.overmap.closest(origin, {
    exclude_types = { tile.terrain },
    radius = 0,
})
assert(missing.ok == false)
assert(missing.error.code == "not_found")

assert(pcall(function()
    game.overmap.tile(avatar.position)
end) == false)
assert(pcall(function()
    game.overmap.search(origin, { radius = 61 })
end) == false)
assert(pcall(function()
    game.overmap.search(origin, { radius_z = 6 })
end) == false)
assert(pcall(function()
    game.overmap.search(origin, { limit = 257 })
end) == false)
assert(pcall(function()
    game.overmap.search(origin, {
        types = { [2] = tile.terrain },
        radius = 0,
    })
end) == false)
assert(pcall(function()
    game.overmap.matches(
        origin, tile.terrain,
        game.enums.values("Direction", 0, 1)[1])
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( "game.overmap.limits()" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.read" ) != std::string::npos );
}

TEST_CASE( "lua_v5_overmap_applies_existing_only_controlled_mutations",
           "[lua][bindings][world][overmap][write][integration]" )
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
local avatar = game.creatures.snapshot(
    game.creatures.avatar()).value
local position = avatar.position:project_to("overmap_terrain")
local before = game.overmap.tile(position)
assert(before.exists == true)

local ok, failure = pcall(function()
    local terrain = game.overmap.set_terrain(
        position, before.terrain)
    assert(terrain.ok == true)
    assert(terrain.value.accepted == true)
    assert(terrain.value.changed == false)
    assert(terrain.value.after == before.terrain)

    local alternate_name = "full"
    if before.vision.name == "full" then
        alternate_name = "details"
    end
    local alternate = game.enums.value(
        "OmVisionLevel", alternate_name)
    local seen = game.overmap.set_seen(position, alternate)
    assert(seen.ok == true)
    assert(seen.value.accepted == true)
    assert(seen.value.changed == true)
    assert(seen.value.after == alternate)

    local explored = game.overmap.set_explored(
        position, not before.explored)
    assert(explored.ok == true)
    assert(explored.value.accepted == true)
    assert(explored.value.changed == true)
    assert(explored.value.after == not before.explored)

    local note_text = "Lua v5 overmap integration 测试"
    local note = game.overmap.set_note(position, note_text)
    assert(note.ok == true)
    assert(note.value.accepted == true)
    assert(note.value.after_present == true)
    assert(game.overmap.tile(position).note == note_text)

    local danger = game.overmap.set_note_danger(
        position, 3, true)
    assert(danger.ok == true)
    assert(danger.value.accepted == true)
    assert(danger.value.after_dangerous == true)
    assert(danger.value.after_radius == 3)
    local safe = game.overmap.set_note_danger(
        position, 0, false)
    assert(safe.ok == true)
    assert(safe.value.accepted == true)
    assert(safe.value.after_dangerous == false)
    assert(safe.value.after_radius == -1)

    local cleared = game.overmap.set_note(position, nil)
    assert(cleared.ok == true)
    assert(cleared.value.accepted == true)
    assert(cleared.value.after_present == false)
    local missing_note = game.overmap.set_note_danger(
        position, 1, true)
    assert(missing_note.ok == false)
    assert(missing_note.error.code == "not_found")

    local unseen = game.enums.value(
        "OmVisionLevel", "unseen")
    assert(game.overmap.set_seen(position, unseen).ok == true)
    local revealed = game.overmap.reveal(position, 0)
    assert(revealed.ok == true)
    assert(revealed.value.scanned == 1)
    assert(revealed.value.existing == 1)
    assert(revealed.value.changed == 1)
    assert(revealed.value.vision.name == "full")
    assert(game.overmap.reveal(position, 0).value.changed == 0)

    assert(pcall(function()
        game.overmap.set_terrain(
            position, game.types.id("item", "rock"))
    end) == false)
    assert(pcall(function()
        game.overmap.set_seen(
            position,
            game.enums.values("Direction", 0, 1)[1])
    end) == false)
    assert(pcall(function()
        game.overmap.set_note(
            position, string.rep("x", 4097))
    end) == false)
    assert(pcall(function()
        game.overmap.set_note(position, "a\0b")
    end) == false)
    assert(pcall(function()
        game.overmap.set_note_danger(position, 101, true)
    end) == false)
    assert(pcall(function()
        game.overmap.reveal(position, 31)
    end) == false)
end)

game.overmap.set_seen(position, before.vision)
game.overmap.set_explored(position, before.explored)
game.overmap.set_note(position, before.note)
if before.note ~= nil then
    local restore_radius = 0
    if before.note_dangerous then
        restore_radius = before.note_danger_radius
    end
    game.overmap.set_note_danger(
        position, restore_radius,
        before.note_dangerous)
end
assert(ok, failure)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local position = game.creatures.snapshot(
    game.creatures.avatar()).value.position
    :project_to("overmap_terrain")
local vision = game.overmap.tile(position).vision
game.overmap.set_seen(position, vision)
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
}

TEST_CASE( "lua_v5_hordes_expose_bounded_definitions_and_existing_snapshots",
           "[lua][bindings][world][hordes][read][integration]" )
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
local limits = game.hordes.limits()
assert(limits.maximum_radius == 30)
assert(limits.maximum_radius_z == 5)
assert(limits.maximum_limit == 256)
assert(limits.maximum_signal_power == 60)
assert(limits.existing_only == true)
assert(#limits.flavors == 4)

local definitions = game.hordes.definitions({
    offset = 0,
    limit = 1000000,
})
assert(definitions.limit == 256)
assert(definitions.returned == #definitions.items)
assert(definitions.returned <= definitions.total)
assert(definitions.total > 0)
local first = definitions.items[1]
assert(first.id.kind == "monster_group")
assert(first.id:is_valid())
assert(math.type(first.entries) == "integer")
assert(type(first.is_animal) == "boolean")
assert(type(first.safe) == "boolean")

local definition = game.hordes.definition(first.id, {
    offset = 0,
    limit = 1000000,
})
assert(definition.id == first.id)
assert(definition.entries.limit == 256)
assert(definition.entries.returned == #definition.entries.items)
assert(definition.entries.returned <= definition.entries.total)
assert(type(definition.is_animal) == "boolean")
assert(type(definition.safe) == "boolean")
assert(math.type(definition.frequency_total) == "integer")
for _, entry in ipairs(definition.entries.items) do
    assert(entry.kind == "group" or entry.kind == "monster")
    assert(entry.id.kind == "monster_group" or
        entry.id.kind == "monster")
    assert(math.type(entry.frequency) == "integer")
    assert(math.type(entry.cost_multiplier) == "integer")
    assert(entry.starts.turns ~= nil)
    assert(entry.ends.turns ~= nil)
    assert(type(entry.lasts_forever) == "boolean")
    assert(type(entry.event) == "string")
    assert(entry.conditions.returned ==
        #entry.conditions.items)
end

local members = game.hordes.monsters(
    first.id, false, { limit = 1000000 })
assert(members.group == first.id)
assert(members.limit == 256)
assert(members.returned == #members.items)
for _, monster in ipairs(members.items) do
    assert(monster.kind == "monster")
    assert(monster:is_valid())
    assert(game.hordes.contains(first.id, monster) == true)
end

local avatar = game.creatures.snapshot(
    game.creatures.avatar()).value
local omt = avatar.position:project_to("overmap_terrain")
local entities = game.hordes.entities(omt, {
    radius = 0,
    radius_z = 0,
    limit = 1000000,
    flavors = { "active", "idle", "dormant", "immobile" },
})
assert(entities.limit == 256)
assert(entities.returned == #entities.items)
assert(entities.returned <= entities.total)
assert(entities.existing_only == true)
for _, entry in ipairs(entities.items) do
    assert(entry.token:is_valid())
    assert(entry.position.origin == "abs")
    assert(entry.position.scale == "ms")
    assert(entry.overmap_position == omt)
    assert(entry.monster.kind == "monster")
    assert(type(entry.name) == "string")
    assert(type(entry.flavor) == "string")
    assert(type(entry.active) == "boolean")
    assert(type(entry.heavy) == "boolean")
    assert(math.type(entry.tracking_intensity) == "integer")
    assert(game.hordes.entity(entry.token).ok == true)
end

local legacy = game.hordes.legacy_groups(omt, {
    radius = 0,
    radius_z = 0,
    horde_only = false,
    limit = 1000000,
})
assert(legacy.limit == 256)
assert(legacy.returned == #legacy.items)
assert(legacy.returned <= legacy.total)
assert(legacy.existing_only == true)
for _, entry in ipairs(legacy.items) do
    assert(entry.token:is_valid())
    assert(entry.group.kind == "monster_group")
    assert(entry.position.origin == "abs")
    assert(entry.position.scale == "sm")
    assert(type(entry.behavior) == "string")
    assert(type(entry.horde) == "boolean")
    assert(entry.monsters.returned == #entry.monsters.items)
    assert(game.hordes.legacy_group(entry.token).ok == true)
end

local summary = game.hordes.summary(omt)
assert(summary.position == omt)
assert(math.type(summary.entities) == "integer")
assert(math.type(summary.legacy_hordes) == "integer")
assert(math.type(summary.estimated_size) == "integer")
assert(type(summary.has_horde) == "boolean")
assert(summary.existing_only == true)

assert(pcall(function()
    game.hordes.entities(avatar.position)
end) == false)
assert(pcall(function()
    game.hordes.entities(omt, { radius = 31 })
end) == false)
assert(pcall(function()
    game.hordes.entities(omt, { radius_z = 6 })
end) == false)
assert(pcall(function()
    game.hordes.entities(omt, { flavors = { [2] = "idle" } })
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( "game.hordes.limits()" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.read" ) != std::string::npos );
}

TEST_CASE( "lua_v5_hordes_use_generation_tokens_and_controlled_mutations",
           "[lua][bindings][world][hordes][write][integration]" )
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
local avatar = game.creatures.snapshot(
    game.creatures.avatar()).value
local position = avatar.position
local omt = position:project_to("overmap_terrain")
local sm = position:project_to("submap")
local zombie = game.types.id("monster", "mon_zombie")
local definitions = game.hordes.definitions({ limit = 1 })
assert(definitions.returned == 1)
local group_id = definitions.items[1].id

local entity_token = nil
local legacy_token = nil
local ok, failure = pcall(function()
    local created = game.hordes.spawn_entity(position, zombie)
    assert(created.ok == true)
    entity_token = created.value.token
    assert(entity_token:is_valid() == true)
    assert(created.value.monster == zombie)
    assert(created.value.position == position)
    assert(game.hordes.entity(entity_token).value.monster == zombie)

    local alerted = game.hordes.alert_entity(
        entity_token, position, 25)
    assert(alerted.ok == true)
    assert(alerted.value.before.tracking_intensity == 0)
    assert(alerted.value.after.tracking_intensity == 25)
    assert(alerted.value.after.active == true)
    assert(alerted.value.after.token == entity_token)

    local filtered = game.hordes.entities(omt, {
        radius = 0,
        monster = zombie,
        flavors = { "active" },
        limit = 256,
    })
    local found = false
    for _, entry in ipairs(filtered.items) do
        if entry.token == entity_token then
            found = true
        end
    end
    assert(found == true)

    local signaled = game.hordes.signal(sm, 1)
    assert(signaled.ok == true)
    assert(signaled.value.accepted == true)
    assert(signaled.value.existing_only == true)

    local legacy = game.hordes.spawn_legacy_group({
        group = group_id,
        position = sm,
        population = 17,
        interest = 30,
        horde = true,
        behavior = "roam",
        target = sm,
        nemesis_target = sm,
    })
    assert(legacy.ok == true)
    legacy_token = legacy.value.token
    assert(legacy_token:is_valid() == true)
    assert(legacy.value.group == group_id)
    assert(legacy.value.population == 17)
    assert(legacy.value.interest == 30)
    assert(legacy.value.behavior == "roam")

    local updated = game.hordes.update_legacy_group(
        legacy_token, {
            population = 19,
            interest = 45,
            dying = true,
            horde = true,
            behavior = "city",
            target = sm,
        })
    assert(updated.ok == true)
    assert(updated.value.before.population == 17)
    assert(updated.value.after.population == 19)
    assert(updated.value.after.interest == 45)
    assert(updated.value.after.dying == true)
    assert(updated.value.after.behavior == "city")
    assert(updated.value.after.token == legacy_token)
    assert(game.hordes.legacy_group(
        legacy_token).value.population == 19)

    assert(pcall(function()
        game.hordes.spawn_entity(
            position, game.types.id("item", "rock"))
    end) == false)
    assert(pcall(function()
        game.hordes.alert_entity(
            entity_token, position, 1000001)
    end) == false)
    assert(pcall(function()
        game.hordes.signal(sm, 61)
    end) == false)
    assert(pcall(function()
        game.hordes.update_legacy_group(
            legacy_token, { interest = 14 })
    end) == false)
end)

if legacy_token ~= nil and legacy_token:is_valid() then
    local removed = game.hordes.remove_legacy_group(legacy_token)
    assert(removed.ok == true)
    assert(removed.value.removed == true)
    assert(legacy_token:is_valid() == false)
    assert(game.hordes.legacy_group(
        legacy_token).error.code == "missing_legacy_horde")
end
if entity_token ~= nil and entity_token:is_valid() then
    local removed = game.hordes.remove_entity(entity_token)
    assert(removed.ok == true)
    assert(removed.value.removed == true)
    assert(entity_token:is_valid() == false)
    assert(game.hordes.entity(
        entity_token).error.code == "missing_horde_entity")
end
assert(ok, failure)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local position = game.creatures.snapshot(
    game.creatures.avatar()).value.position
game.hordes.spawn_entity(
    position,
    game.types.id("monster", "mon_zombie"))
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
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

TEST_CASE( "lua_v5_inventory_traversal_includes_protected_equipment",
           "[lua][bindings][items][inventory][equipment][integration]" )
{
    avatar &player = get_avatar();
    std::optional<item> original_weapon;
    if( item_location wielded = player.get_wielded_item() ) {
        original_weapon = *wielded;
    }

    item protected_weapon( itype_id( "hammer" ) );
    protected_weapon.set_flag( flag_NO_UNWIELD );
    protected_weapon.set_var( "ccb_lua_protected_root", "wielded" );
    player.set_wielded_item( protected_weapon );

    item integrated_shirt( itype_id( "tshirt" ) );
    integrated_shirt.set_flag( flag_INTEGRATED );
    integrated_shirt.set_var( "ccb_lua_protected_root", "integrated" );
    const auto integrated = player.worn.wear_item(
                                player, integrated_shirt, false, false );
    REQUIRE( integrated );
    const std::int64_t integrated_uid =
        ( **integrated ).uid().get_value();

    item locked_shirt( itype_id( "tshirt" ) );
    locked_shirt.set_flag( flag_NO_TAKEOFF );
    locked_shirt.set_var( "ccb_lua_protected_root", "locked" );
    const auto locked = player.worn.wear_item(
                            player, locked_shirt, false, false );
    REQUIRE( locked );
    const std::int64_t locked_uid =
        ( **locked ).uid().get_value();

    on_out_of_scope cleanup(
    [&player, original_weapon, integrated_uid, locked_uid]() {
        const auto takeoff_test_item =
        [&player]( const std::int64_t uid ) {
            std::vector<item_location> worn =
                player.worn.top_items_loc( player );
            auto location = std::find_if(
                                worn.begin(), worn.end(),
            [uid]( const item_location & entry ) {
                return entry &&
                       entry->uid().get_value() == uid;
            } );
            if( location == worn.end() ) {
                return;
            }
            ( **location ).unset_flag( flag_INTEGRATED );
            ( **location ).unset_flag( flag_NO_TAKEOFF );
            std::list<item> removed;
            player.takeoff( *location, &removed );
        };
        takeoff_test_item( integrated_uid );
        takeoff_test_item( locked_uid );
        player.set_wielded_item(
            original_weapon.value_or( item() ) );
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

local function protected_entry(entries, marker)
    for _, entry in ipairs(entries) do
        local value = game.items.get_var(
            entry.handle, "ccb_lua_protected_root")
        if value.ok and value.value.value == marker then
            return entry
        end
    end
    return nil
end

local wielded_page = game.inventory.list(avatar, {
    recursive = false,
    include_wielded = true,
    include_worn = false,
    include_carried = false,
    limit = 512
})
local wielded = protected_entry(
    wielded_page.value.items, "wielded")
assert(wielded ~= nil)
assert(wielded.location == "wielded")
assert(game.inventory.find(avatar, wielded.uid).ok == true)

local worn_page = game.inventory.list(avatar, {
    recursive = false,
    include_wielded = false,
    include_worn = true,
    include_carried = false,
    limit = 512
})
local integrated = protected_entry(
    worn_page.value.items, "integrated")
local locked = protected_entry(
    worn_page.value.items, "locked")
assert(integrated ~= nil and locked ~= nil)
assert(integrated.location == "worn")
assert(locked.location == "worn")

local integrated_remove = game.inventory.remove(
    avatar, integrated.handle)
assert(integrated_remove.ok == false)
assert(integrated_remove.error.code == "cannot_takeoff")
assert(game.inventory.find(avatar, integrated.uid).ok == true)

local locked_remove = game.inventory.remove(
    avatar, locked.handle)
assert(locked_remove.ok == false)
assert(locked_remove.error.code == "cannot_takeoff")
assert(game.inventory.find(avatar, locked.uid).ok == true)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_item_snapshots_are_detailed_detached_and_bounded",
           "[lua][bindings][items][snapshot][integration]" )
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
    limit = 512,
    max_depth = 16
})
assert(listed.ok == true)
local rock = nil
for _, entry in ipairs(listed.value.items) do
    if entry.id.value == "rock" then
        rock = entry
    end
end
assert(rock ~= nil)

local fetched = game.items.snapshot(rock.handle, 1000000)
assert(fetched.ok == true)
local value = fetched.value
assert(value.uid == rock.uid)
assert(value.id == rock.id)
assert(type(value.name) == "string")
assert(type(value.display_name) == "string")
assert(type(value.type_name) == "string")
assert(type(value.description) == "string")
assert(type(value.category.id) == "string")
assert(type(value.category.name) == "string")
assert(math.type(value.charges) == "integer")
assert(type(value.count_by_charges) == "boolean")
assert(type(value.stackable) == "boolean")
assert(type(value.active) == "boolean")
assert(type(value.favorite) == "boolean")
assert(value.weight.kind == "mass")
assert(value.weight_without_contents.kind == "mass")
assert(value.volume.kind == "volume")
assert(value.price_pre_cataclysm.kind == "money")
assert(value.price_post_cataclysm.kind == "money")
assert(type(value.birthday) == "userdata")
assert(math.type(value.birthday.turn) == "integer")
assert(type(value.rot) == "userdata")
assert(math.type(value.rot.turns) == "integer")
assert(math.type(value.condition.damage) == "integer")
assert(math.type(value.condition.degradation) == "integer")
assert(math.type(value.condition.damage_level) == "integer")
assert(math.type(value.condition.max_damage) == "integer")
assert(type(value.condition.relative_health) == "number")
assert(type(value.classification.gun) == "boolean")
assert(type(value.classification.container) == "boolean")
assert(type(value.resources.ammo_remaining) == "number")
assert(type(value.resources.uses_energy) == "boolean")
assert(math.type(value.contents_count) == "integer")
assert(math.type(value.pocket_count) == "integer")
assert(value.relation_limit == 256)

for _, page in ipairs({
    value.materials,
    value.type_flags,
    value.own_flags,
    value.faults,
    value.techniques
}) do
    assert(page.limit == 256)
    assert(page.returned == #page.items)
    assert(page.returned <= page.total)
    assert(page.truncated == (page.returned < page.total))
end

local wrong_kind = game.items.snapshot(avatar)
assert(wrong_kind.ok == false)
assert(wrong_kind.error.code == "wrong_kind")
assert(pcall(function()
    game.items.snapshot(rock.handle, -1)
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_item_pockets_and_contents_are_recursive_and_bounded",
           "[lua][bindings][items][pockets][contents][integration]" )
{
    avatar &player = get_avatar();
    item backpack( itype_id( "debug_backpack" ) );
    REQUIRE( backpack.put_in(
                 item( itype_id( "rock" ) ),
                 pocket_type::CONTAINER ).success() );
    item_location added = player.i_add( backpack );
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
    limit = 512,
    max_depth = 16
})
assert(listed.ok == true)
local backpack = nil
for _, entry in ipairs(listed.value.items) do
    if entry.id.value == "debug_backpack" then
        backpack = entry
    end
end
assert(backpack ~= nil)

local pockets = game.items.pockets(backpack.handle, {
    offset = 0,
    limit = 1000000
})
assert(pockets.ok == true)
local pocket_page = pockets.value
assert(pocket_page.limit == 256)
assert(pocket_page.returned == #pocket_page.items)
assert(pocket_page.returned <= pocket_page.total)
local container_pocket = nil
for _, pocket in ipairs(pocket_page.items) do
    assert(math.type(pocket.index) == "integer")
    assert(pocket.ordinal == pocket.index + 1)
    assert(type(pocket.type) == "string")
    assert(type(pocket.name) == "string")
    assert(type(pocket.description) == "string")
    assert(math.type(pocket.items) == "integer")
    assert(type(pocket.empty) == "boolean")
    assert(type(pocket.rigid) == "boolean")
    assert(type(pocket.watertight) == "boolean")
    assert(type(pocket.sealed) == "boolean")
    assert(pocket.capacity.volume.kind == "volume")
    assert(pocket.capacity.volume_used.kind == "volume")
    assert(pocket.capacity.volume_remaining.kind == "volume")
    assert(pocket.capacity.weight.kind == "mass")
    assert(pocket.capacity.weight_used.kind == "mass")
    assert(pocket.capacity.weight_remaining.kind == "mass")
    assert(pocket.capacity.length_max.kind == "length")
    assert(pocket.capacity.length_min.kind == "length")
    if pocket.type == "container" and pocket.items > 0 then
        container_pocket = pocket
    end
end
assert(container_pocket ~= nil)

local contents = game.items.contents(backpack.handle, {
    recursive = true,
    limit = 1000000,
    max_depth = 1000000
})
assert(contents.ok == true)
local content_page = contents.value
assert(content_page.limit == 512)
assert(content_page.max_depth == 16)
assert(content_page.returned == #content_page.items)
assert(content_page.returned <= content_page.total)
assert(type(content_page.total_exact) == "boolean")
local rock = nil
for _, entry in ipairs(content_page.items) do
    assert(entry.handle.kind == "item")
    assert(entry.handle:locator().scope == "item_contained")
    assert(math.type(entry.parent_uid) == "integer")
    assert(math.type(entry.pocket_index) == "integer")
    assert(type(entry.pocket_type) == "string")
    assert(entry.depth >= 1)
    if entry.id.value == "rock" then
        rock = entry
    end
end
assert(rock ~= nil)
assert(game.items.snapshot(rock.handle).value.id == rock.id)

local direct = game.items.contents(backpack.handle, {
    recursive = false,
    limit = 512
})
assert(direct.ok == true)
for _, entry in ipairs(direct.value.items) do
    assert(entry.depth == 1)
end

assert(game.items.pockets(avatar).error.code == "wrong_kind")
assert(game.items.contents(avatar).error.code == "wrong_kind")
assert(pcall(function()
    game.items.pockets(backpack.handle, { unknown = true })
end) == false)
assert(pcall(function()
    game.items.contents(backpack.handle, { max_depth = -1 })
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_item_mutations_are_typed_bounded_and_write_gated",
           "[lua][bindings][items][mutation][integration]" )
{
    avatar &player = get_avatar();
    const auto backpack = player.worn.wear_item(
                              player, item( itype_id( "debug_backpack" ) ),
                              false, false );
    REQUIRE( backpack );
    const std::int64_t backpack_uid =
        ( **backpack ).uid().get_value();
    item_location rock = player.i_add( item( itype_id( "rock" ) ) );
    REQUIRE( rock );
    const std::int64_t rock_uid = rock->uid().get_value();
    item battery( itype_id( "battery" ), calendar::turn, 10 );
    battery.set_var( "ccb_lua_test_marker", "battery" );
    item_location stored_battery = player.i_add( battery );
    REQUIRE( stored_battery );
    const std::int64_t battery_uid =
        stored_battery->uid().get_value();
    on_out_of_scope cleanup(
    [&player, backpack_uid, rock_uid, battery_uid]() {
        player.remove_items_with(
        [backpack_uid, rock_uid, battery_uid]( const item & entry ) {
            const std::int64_t uid =
                entry.uid().get_value();
            return uid == backpack_uid || uid == rock_uid ||
                   uid == battery_uid;
        }, 3 );
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
local listed = game.inventory.list(avatar, {
    limit = 512,
    max_depth = 16
})
assert(listed.ok == true)
local rock = nil
local battery = nil
for _, entry in ipairs(listed.value.items) do
    if entry.id.value == "rock" then
        rock = entry
    elseif entry.id.value == "battery" then
        local marker = game.items.get_var(
            entry.handle, "ccb_lua_test_marker")
        if marker.ok and marker.value.value == "battery" then
            battery = entry
        end
    end
end
assert(rock ~= nil and battery ~= nil)

local original = game.items.snapshot(rock.handle).value
local changed = game.items.update(rock.handle, {
    damage = math.min(1, original.condition.max_damage),
    favorite = not original.favorite
})
assert(changed.ok == true)
assert(changed.value.before.uid == rock.uid)
assert(changed.value.after.favorite == not original.favorite)
assert(changed.value.after.damage ==
    math.min(1, original.condition.max_damage))

local charged = game.items.update(battery.handle, {
    charges = 7
})
assert(charged.ok == true)
assert(charged.value.after.charges == 7)

local text_var = game.items.set_var(
    rock.handle, "ccb_lua_text", "cleanwater")
assert(text_var.ok == true)
assert(text_var.value.existed == false)
assert(text_var.value.after.kind == "string")
assert(text_var.value.after.value == "cleanwater")
local fetched_text = game.items.get_var(
    rock.handle, "ccb_lua_text")
assert(fetched_text.ok == true)
assert(fetched_text.value.kind == "string")
assert(fetched_text.value.value == "cleanwater")

local number_var = game.items.set_var(
    rock.handle, "ccb_lua_number", 12.5)
assert(number_var.ok == true)
assert(number_var.value.after.kind == "number")
assert(number_var.value.after.value == 12.5)

local point = game.coords.tripoint(
    "absolute", "map_square", 1, 2, 3)
local point_var = game.items.set_var(
    rock.handle, "ccb_lua_point", point)
assert(point_var.ok == true)
assert(point_var.value.after.kind == "coordinate")
assert(point_var.value.after.value == point)
assert(game.items.erase_var(
    rock.handle, "ccb_lua_text").value == true)
assert(game.items.get_var(
    rock.handle, "ccb_lua_text").error.code == "not_found")

local pseudo = game.types.id("json_flag", "PSEUDO")
assert(game.items.set_flag(
    rock.handle, pseudo, true).value.own_after == true)
assert(game.items.has_flag(
    rock.handle, pseudo).value == true)
assert(game.items.set_flag(
    rock.handle, pseudo, false).value.own_after == false)

local feint = game.types.id(
    "martial_art_technique", "tec_feint")
assert(game.items.set_technique(
    rock.handle, feint, true).value.after == true)
assert(game.items.has_technique(
    rock.handle, feint).value == true)
assert(game.items.set_technique(
    rock.handle, feint, false).value.after == false)

assert(pcall(function()
    game.items.update(battery.handle, { charges = -1 })
end) == false)
assert(pcall(function()
    game.items.update(rock.handle, { unknown = true })
end) == false)
assert(pcall(function()
    game.items.set_var(rock.handle, "", "bad")
end) == false)
assert(pcall(function()
    game.items.set_flag(
        rock.handle, game.types.id("item", "rock"), true)
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    const int damage_after_write = rock->damage();
    const bool favorite_after_write = rock->is_favorite;
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
    limit = 512,
    max_depth = 16
})
for _, entry in ipairs(listed.value.items) do
    if entry.id.value == "rock" then
        game.items.update(entry.handle, { favorite = false })
    end
end
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
    CHECK( rock->damage() == damage_after_write );
    CHECK( rock->is_favorite == favorite_after_write );
}

TEST_CASE( "lua_v5_inventory_operations_are_bounded_transactional_and_write_gated",
           "[lua][bindings][items][inventory][operations][integration]" )
{
    avatar &player = get_avatar();
    const auto backpack = player.worn.wear_item(
                              player, item( itype_id( "debug_backpack" ) ),
                              false, false );
    REQUIRE( backpack );
    const std::int64_t backpack_uid =
        ( **backpack ).uid().get_value();
    on_out_of_scope cleanup(
    [&player, backpack_uid]() {
        player.remove_items_with(
        [backpack_uid]( const item & entry ) {
            return entry.uid().get_value() == backpack_uid ||
                   entry.get_var(
                       "ccb_lua_inventory_ops", "" ) == "owned";
        } );
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
local hammer_id = game.types.id("item", "hammer")
local battery_id = game.types.id("item", "battery")
local shirt_id = game.types.id("item", "tshirt")

local hammer_before = game.inventory.resources(
    avatar, hammer_id, 2)
assert(hammer_before.ok == true)
assert(hammer_before.value.id == hammer_id)
assert(type(hammer_before.value.has_amount) == "boolean")
assert(type(hammer_before.value.has_charges) == "boolean")
assert(type(hammer_before.value.has_tools) == "boolean")
assert(type(hammer_before.value.has_components) == "boolean")

local hammers = game.inventory.give(
    avatar, hammer_id, 2)
assert(hammers.ok == true)
assert(hammers.value.requested == 2)
assert(hammers.value.added == 2)
assert(hammers.value.rejected == 0)
assert(hammers.value.count_by_charges == false)
assert(hammers.value.instances == 2)
assert(#hammers.value.items == 2)
for _, entry in ipairs(hammers.value.items) do
    assert(entry.id == hammer_id)
    assert(game.items.set_var(
        entry.handle, "ccb_lua_inventory_ops", "owned").ok)
end
local hammer_after = game.inventory.resources(
    avatar, hammer_id, 2)
assert(hammer_after.value.amount >=
    hammer_before.value.amount + 2)
assert(hammer_after.value.has_amount == true)
assert(hammer_after.value.has_tools == true)

local wielded = game.inventory.wield(
    avatar, hammers.value.items[1].handle)
assert(wielded.ok == true)
assert(wielded.value.accepted == true)
assert(wielded.value.item.location == "wielded")
local occupied = game.inventory.wield(
    avatar, hammers.value.items[2].handle)
assert(occupied.ok == true)
assert(occupied.value.accepted == false)
assert(occupied.value.reason == "wielded_slot_occupied")
local stashed = game.inventory.stash_wielded(avatar)
assert(stashed.ok == true)
assert(stashed.value.accepted == true)
assert(stashed.value.item.location ~= "wielded")

local shirt = game.inventory.give(
    avatar, shirt_id, 1)
assert(shirt.ok == true)
assert(shirt.value.added == 1)
assert(game.items.set_var(
    shirt.value.items[1].handle,
    "ccb_lua_inventory_ops", "owned").ok)
local worn = game.inventory.wear(
    avatar, shirt.value.items[1].handle)
assert(worn.ok == true)
assert(worn.value.accepted == true)
assert(worn.value.item.location == "worn")

local battery_before = game.inventory.resources(
    avatar, battery_id, 1).value
local battery = game.inventory.give(
    avatar, battery_id, 10)
assert(battery.ok == true)
assert(battery.value.added == 10)
assert(battery.value.count_by_charges == true)
assert(battery.value.instances == 1)
assert(game.items.set_var(
    battery.value.items[1].handle,
    "ccb_lua_inventory_ops", "owned").ok)
local battery_snapshot = game.items.snapshot(
    battery.value.items[1].handle).value
local partial = game.inventory.remove(
    avatar, battery.value.items[1].handle, 3)
assert(partial.ok == true)
assert(partial.value.removed == 3)
assert(partial.value.fully_removed == false)
assert(partial.value.remaining ==
    battery_snapshot.charges - 3)
assert(partial.value.item.handle:is_valid() == true)
local battery_after_partial = game.inventory.resources(
    avatar, battery_id, 1).value
assert(battery_after_partial.charges ==
    battery_before.charges + 7)
local battery_removed = game.inventory.remove(
    avatar, partial.value.item.handle)
assert(battery_removed.ok == true)
assert(battery_removed.value.fully_removed == true)
assert(battery_removed.value.remaining == 0)

assert(game.inventory.remove(
    avatar, worn.value.item.handle).value.fully_removed == true)
assert(game.inventory.remove(
    avatar, stashed.value.item.handle).value.fully_removed == true)
local second = game.inventory.find(
    avatar, hammers.value.items[2].uid)
assert(second.ok == true)
assert(game.inventory.remove(
    avatar, second.value.handle).value.fully_removed == true)
local hammer_final = game.inventory.resources(
    avatar, hammer_id, 2).value
assert(hammer_final.amount == hammer_before.value.amount)
local battery_final = game.inventory.resources(
    avatar, battery_id, 1).value
assert(battery_final.charges == battery_before.charges)

assert(pcall(function()
    game.inventory.give(avatar, hammer_id, 101)
end) == false)
assert(pcall(function()
    game.inventory.give(avatar, hammer_id, 1,
        { unknown = true })
end) == false)
assert(pcall(function()
    game.inventory.resources(
        avatar, game.types.id("effect", "onfire"), 1)
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.inventory.give(
    game.characters.avatar(),
    game.types.id("item", "hammer"), 1)
)lua" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.write" ) != std::string::npos );
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
    CHECK( kinds.size() == 26 );
    CHECK( std::find( kinds.begin(), kinds.end(), "DamageType" ) != kinds.end() );
    CHECK( std::find( kinds.begin(), kinds.end(), "OmVisionLevel" ) != kinds.end() );
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
assert(#game.enums.kinds() == 26)
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

TEST_CASE( "lua_v5_hooks_are_described_ordered_owned_and_error_isolated",
           "[lua][bindings][hooks][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "events", "game.hooks", "game.read", "state.character"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local limits = game.hooks.limits()
assert(limits.hooks == 48)
assert(limits.handlers == 1024)
assert(limits.registered == 0)
assert(limits.priority_min == -10000)
assert(limits.priority_max == 10000)
assert(limits.dispatch_depth == 16)
assert(limits.instruction_budget > 0)

local catalog = game.hooks.list()
assert(#catalog == 48)
local observed = game.hooks.describe("on_game_started")
assert(observed.name == "on_game_started")
assert(observed.mode == "observe")
assert(observed.cancellable == false)
assert(observed.requires_write == false)
local intercept = game.hooks.describe("on_try_npc_interaction")
assert(intercept.mode == "intercept")
assert(intercept.cancellable == true)
assert(intercept.requires_write == true)
assert(#intercept.result_fields == 1)
assert(intercept.result_fields[1] == "allow")
local skill_info =
    game.hooks.describe("on_character_display_skill_info")
assert(skill_info.mode == "intercept")
assert(skill_info.cancellable == false)
assert(skill_info.result_fields[1] == "text")
assert(pcall(function()
    game.hooks.on("on_try_npc_interaction", function() end)
end) == false)
assert(pcall(function()
    game.hooks.on("not_a_hook", function() end)
end) == false)

local removed = game.hooks.on("on_game_started", function()
    error("removed hook ran")
end)
assert(game.hooks.off(removed) == true)
assert(game.hooks.off(removed) == false)

game.hooks.on("on_game_started", {
    priority = 100, once = true
}, function(payload)
    assert(payload.hook == "on_game_started")
    assert(payload.mode == "observe")
    assert(payload.cancellable == false)
    local order = state.character.get("hooks.order", "")
    state.character.set("hooks.order", order .. "H")
end)

game.hooks.on("on_game_started", {
    priority = 50
}, function()
    local count = state.character.get("hooks.bad", 0)
    state.character.set("hooks.bad", count + 1)
    error("expected isolated hook failure")
end)

game.hooks.on("on_game_started", {
    priority = -100
}, function()
    local order = state.character.get("hooks.order", "")
    state.character.set("hooks.order", order .. "L")
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( cata::lua_ui::has_native_hook( "on_game_started" ) );
    CHECK_FALSE( cata::lua_ui::has_native_hook(
                     "on_weather_updated" ) );
    CHECK( cata::lua_ui::dispatch_native_hook(
               "on_game_started" ) );
    CHECK( cata::lua_ui::status().last_error.find(
               "expected isolated hook failure" ) != std::string::npos );
    CHECK( cata::lua_ui::dispatch_native_hook(
               "on_game_started" ) );

    script.write( R"lua(
assert(state.character.get("hooks.order", "") == "HLL")
assert(state.character.get("hooks.bad", 0) == 1)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
}

TEST_CASE( "lua_v5_hook_results_are_typed_bounded_and_transactional",
           "[lua][bindings][hooks][results][integration]" )
{
    using namespace cata::lua_ui;

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "events", "game.hooks", "game.read", "game.write"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.hooks.on("on_character_display_skill_info",
    { priority = 100 }, function(payload)
        payload.results.text = "shared"
        return { text = "returned" }
    end)
game.hooks.on("on_character_display_skill_info", function(payload)
    assert(payload.prev.text == "returned")
    assert(payload.results.text == "shared\nreturned")
    return { text = "tail" }
end)

game.hooks.on("on_character_display_skill_action", function(payload)
    payload.results.handled = true
end)

game.hooks.on("on_dialogue_start",
    { priority = 100 }, function()
        return { result = string.rep("x", 513) }
    end)
game.hooks.on("on_dialogue_start", function()
    return "TALK_LUA_TEST"
end)

game.hooks.on("on_make_mapgen_factory_list",
    { priority = 100 }, function(payload)
        assert(#payload.candidates == 2)
        assert(payload.candidates[1] == "house")
        return { results = { "lua_one", "lua_two", "lua_one" } }
    end)
game.hooks.on("on_make_mapgen_factory_list", function(payload)
    assert(#payload.results.results == 2)
    table.insert(payload.results.results, "lua_three")
end)
)lua" );

    std::string error;
    REQUIRE( reload_scripts( error ) );

    const native_hook_result info = dispatch_native_hook_result(
                                        "on_character_display_skill_info" );
    CHECK( info.allowed );
    CHECK( info.text == "shared\nreturned\ntail" );

    const native_hook_result action = dispatch_native_hook_result(
                                          "on_character_display_skill_action" );
    CHECK( action.handled );

    const native_hook_result dialogue = dispatch_native_hook_result(
                                            "on_dialogue_start" );
    REQUIRE( dialogue.result );
    CHECK( *dialogue.result == "TALK_LUA_TEST" );
    CHECK( status().last_error.find(
               "invalid length" ) != std::string::npos );

    const native_hook_result mapgen = dispatch_native_hook_result(
                                        "on_make_mapgen_factory_list", {
        {
            "candidates",
            std::vector<std::string> { "house", "field" }
        }
    } );
    CHECK( mapgen.results ==
           std::vector<std::string> {
        "lua_one", "lua_two", "lua_three"
    } );
}

TEST_CASE( "lua_v5_effect_hooks_run_from_opt_in_native_lifecycles",
           "[lua][bindings][hooks][effects][integration]" )
{
    using namespace cata::lua_ui;

    clear_avatar();
    avatar &player = get_avatar();
    const efftype_id lifecycle_effect( "test_lua_lifecycle" );
    player.remove_effect( lifecycle_effect );

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "events", "game.hooks", "game.read", "game.write",
            "state.character"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local expected = game.types.id("effect", "test_lua_lifecycle")

local function observe(name, creature_field, remove_on_second_tick)
    return function(payload)
        assert(payload.effect == expected)
        assert(payload.body_part.kind == "body_part")
        assert(payload.body_part:is_null())
        assert(payload[creature_field] ~= nil)
        if payload.intensity ~= nil then
            assert(payload.intensity == 2)
        end
        local key = "native_effects." .. name
        local count = state.character.get(key, 0) + 1
        state.character.set(key, count)
        if remove_on_second_tick and count == 2 then
            local removed = game.effects.remove(
                payload[creature_field], payload.effect)
            assert(removed.ok and removed.value)
        end
    end
end

game.hooks.on("on_character_effect_added",
    observe("character_added", "character", false))
game.hooks.on("on_character_effect",
    observe("character_tick", "character", true))
game.hooks.on("on_character_effect_removed",
    observe("character_removed", "character", false))
game.hooks.on("on_mon_effect_added",
    observe("monster_added", "monster", false))
game.hooks.on("on_mon_effect",
    observe("monster_tick", "monster", true))
game.hooks.on("on_mon_effect_removed",
    observe("monster_removed", "monster", false))
)lua" );

    std::string error;
    REQUIRE( reload_scripts( error ) );

    player.add_effect(
        lifecycle_effect, 5_minutes,
        bodypart_str_id::NULL_ID(), false, 2, true );
    REQUIRE( player.has_effect( lifecycle_effect ) );
    player.process_effects();
    CHECK_FALSE( player.has_effect( lifecycle_effect ) );

    monster test_monster( mtype_id( "mon_zombie" ) );
    test_monster.add_effect(
        lifecycle_effect, 5_minutes,
        bodypart_str_id::NULL_ID(), false, 2, true );
    REQUIRE( test_monster.has_effect( lifecycle_effect ) );
    test_monster.process_effects();
    CHECK_FALSE( test_monster.has_effect( lifecycle_effect ) );

    script.write( R"lua(
assert(state.character.get(
    "native_effects.character_added", 0) == 1)
assert(state.character.get(
    "native_effects.character_tick", 0) == 2)
assert(state.character.get(
    "native_effects.character_removed", 0) == 1)
assert(state.character.get(
    "native_effects.monster_added", 0) == 1)
assert(state.character.get(
    "native_effects.monster_tick", 0) == 2)
assert(state.character.get(
    "native_effects.monster_removed", 0) == 1)
)lua" );
    REQUIRE( reload_scripts( error ) );
}

TEST_CASE( "lua_v5_callback_actors_dispatch_typed_bounded_payloads",
           "[lua][bindings][callbacks][integration]" )
{
    using namespace cata::lua_ui;

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "events", "game.callbacks", "game.hooks", "game.read",
            "game.write", "state.character"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local limits = game.callbacks.limits()
assert(limits.kinds == 11)
assert(limits.registrations == 1024)
assert(limits.registrations_per_target == 64)
assert(limits.registered == 0)
assert(limits.priority_min == -10000)
assert(limits.priority_max == 10000)
assert(limits.dispatch_depth == 16)
assert(limits.instruction_budget > 0)

local catalog = game.callbacks.list()
assert(#catalog == 11)
local wieldable = game.callbacks.describe("iwieldable")
assert(wieldable.kind == "iwieldable")
assert(wieldable.target_id_kind == "item")
assert(#wieldable.methods == 4)
assert(pcall(function()
    game.callbacks.describe("not_an_actor")
end) == false)

local rock = game.types.id("item", "rock")
assert(pcall(function()
    game.callbacks.register("iwieldable",
        game.types.id("monster", "mon_zombie"), {
            on_wield = function() end
        })
end) == false)
assert(pcall(function()
    game.callbacks.register("iwieldable", rock, {
        unknown = function() end
    })
end) == false)

local removed = game.callbacks.register("iwieldable", rock, {
    on_wield = function()
        error("removed callback ran")
    end
})
assert(game.callbacks.off(removed) == true)
assert(game.callbacks.off(removed) == false)

game.callbacks.register("iwieldable", rock, {
    priority = 100,
    once = true,
    on_wield = function(payload)
        assert(payload.actor_kind == "iwieldable")
        assert(payload.method == "on_wield")
        assert(payload.decision == false)
        assert(payload.target_id == rock)
        assert(payload.character ~= nil)
        assert(payload.item ~= nil)
        assert(payload.position.coordinate_space == "abs_ms")
        assert(payload.position.x == 11)
        assert(payload.position.y == 22)
        assert(payload.position.z == 1)
        assert(payload.skill ==
            game.types.id("skill", "fabrication"))
        assert(math.type(payload.count) == "integer")
        assert(payload.count == 2)
        assert(payload.ratio == 0.5)
        assert(payload.label == "typed")
        assert(payload.flag == true)
        local order = state.character.get("callbacks.order", "")
        state.character.set("callbacks.order", order .. "H")
    end
})

game.callbacks.register("iwieldable", rock, {
    priority = 50,
    on_wield = function()
        local order = state.character.get("callbacks.order", "")
        state.character.set("callbacks.order", order .. "B")
        error("expected isolated callback actor failure")
    end
})

game.callbacks.register("iwieldable", rock, {
    priority = -100,
    on_wield = function()
        local order = state.character.get("callbacks.order", "")
        state.character.set("callbacks.order", order .. "L")
    end,
    can_wield = function(payload)
        assert(payload.decision == true)
        return false
    end
})

game.hooks.on("on_weather_changed", function(payload)
    assert(payload.before == "clear")
    assert(payload.after == "rain")
    state.character.set("callbacks.native_hook", true)
end)
game.hooks.on("on_try_npc_interaction", function()
    return { allow = false, stop = true }
end)
)lua" );

    std::string error;
    REQUIRE( reload_scripts( error ) );

    item rock( itype_id( "rock" ) );
    const native_callback_arguments payload = {
        { "character", static_cast<const Character *>( &get_avatar() ) },
        { "item", static_cast<const item *>( &rock ) },
        { "position", native_callback_point { "abs_ms", 11, 22, 1 } },
        { "skill", native_callback_id { "skill", "fabrication" } },
        { "count", std::int64_t { 2 } },
        { "ratio", 0.5 },
        { "label", std::string( "typed" ) },
        { "flag", true }
    };
    CHECK( dispatch_native_callback(
               "iwieldable", "rock", "on_wield", payload ) );
    CHECK( status().last_error.find(
               "expected isolated callback actor failure" ) !=
           std::string::npos );
    CHECK( dispatch_native_callback(
               "iwieldable", "rock", "on_wield", payload ) );
    CHECK_FALSE( dispatch_native_callback(
                     "iwieldable", "rock", "can_wield", payload ) );

    CHECK( dispatch_native_hook(
               "on_weather_changed", {
        { "before", std::string( "clear" ) },
        { "after", std::string( "rain" ) }
    } ) );
    CHECK_FALSE( dispatch_native_hook(
                     "on_try_npc_interaction" ) );

    script.write( R"lua(
assert(state.character.get("callbacks.order", "") == "HBLL")
assert(state.character.get("callbacks.native_hook", false) == true)
)lua" );
    REQUIRE( reload_scripts( error ) );
}

TEST_CASE( "lua_v5_item_callback_actors_run_from_native_item_lifecycle",
           "[lua][bindings][callbacks][items][integration]" )
{
    using namespace cata::lua_ui;

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "game.callbacks", "game.read", "game.write",
            "state.character"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local rock = game.types.id("item", "rock")
local shirt = game.types.id("item", "tshirt")
local function observe(name)
    return function(payload)
        assert(payload.item ~= nil)
        local key = "native_items." .. name
        state.character.set(
            key, state.character.get(key, 0) + 1)
    end
end
local function decide(name)
    return function(payload)
        observe(name)(payload)
        return true
    end
end

game.callbacks.register("iuse", rock, {
    can_use = decide("can_use"),
    on_use = decide("on_use")
})
game.callbacks.register("iwieldable", rock, {
    on_wield = observe("on_wield")
})
game.callbacks.register("iwearable", rock, {
    on_wear = observe("on_wear"),
    on_takeoff = observe("on_takeoff")
})
game.callbacks.register("istate", rock, {
    on_pickup = observe("on_pickup"),
    on_tick = observe("on_tick"),
    on_drop = decide("on_drop")
})
game.callbacks.register("iequippable", shirt, {
    on_durability_change = observe("on_durability_change"),
    on_repair = observe("on_repair"),
    on_break = observe("on_break")
})
)lua" );

    std::string error;
    REQUIRE( reload_scripts( error ) );
    CHECK( has_native_callback( "iuse", "rock", "on_use" ) );

    avatar &player = get_avatar();
    item rock( itype_id( "rock" ) );
    const tripoint_bub_ms position( 4, 5, 0 );

    rock.on_pickup( player );
    rock.type->tick( &player, rock, position );
    CHECK( player.invoke_item(
               &rock, position, player.get_moves() ) );
    CHECK_FALSE( rock.on_drop( position ) );
    rock.on_wield( player, false );
    rock.on_wear( player );
    rock.on_takeoff( player );

    item shirt( itype_id( "tshirt" ) );
    REQUIRE( shirt.max_damage() > 0 );
    CHECK_FALSE( shirt.mod_damage( itype::damage_scale, &player ) );
    CHECK_FALSE( shirt.mod_damage( -itype::damage_scale, &player ) );
    shirt.force_set_damage( shirt.max_damage() );
    CHECK( shirt.mod_damage( itype::damage_scale, &player ) );

    script.write( R"lua(
assert(state.character.get("native_items.can_use", 0) == 1)
assert(state.character.get("native_items.on_use", 0) == 1)
assert(state.character.get("native_items.on_wield", 0) == 1)
assert(state.character.get("native_items.on_wear", 0) == 1)
assert(state.character.get("native_items.on_takeoff", 0) == 1)
assert(state.character.get("native_items.on_pickup", 0) == 1)
assert(state.character.get("native_items.on_tick", 0) == 1)
assert(state.character.get("native_items.on_drop", 0) == 1)
assert(state.character.get(
    "native_items.on_durability_change", 0) == 2)
assert(state.character.get("native_items.on_repair", 0) == 1)
assert(state.character.get("native_items.on_break", 0) == 1)
)lua" );
    REQUIRE( reload_scripts( error ) );
}

TEST_CASE( "lua_v5_combat_callbacks_and_hooks_run_from_native_lifecycles",
           "[lua][bindings][callbacks][combat][integration]" )
{
    using namespace cata::lua_ui;

    clear_avatar();
    clear_map_without_vision();
    avatar &player = get_avatar();
    map &here = get_map();
    player.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    player.set_moves( 10000 );

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "events", "game.callbacks", "game.hooks", "game.read",
            "game.write", "state.character"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    const auto write_combat_script = [&]( const bool allow_fire ) {
        script.write( std::string( R"lua(
state.character.set("native_combat.allow_fire", )lua" ) +
                                            ( allow_fire ? "true" : "false" ) + R"lua()
local gun = game.types.id("item", "glock_19")
local rock = game.types.id("item", "rock")
local function count(name)
    state.character.set(
        "native_combat." .. name,
        state.character.get("native_combat." .. name, 0) + 1)
end

game.callbacks.register("iranged", gun, {
    can_fire = function(payload)
        assert(payload.character ~= nil)
        assert(payload.item ~= nil)
        assert(payload.target.coordinate_space == "bub_ms")
        assert(payload.shots == 1)
        count("can_fire")
        return true
    end,
    on_fire = function(payload)
        assert(payload.item ~= nil)
        count("on_fire")
        return state.character.get("native_combat.allow_fire", false)
    end
})
game.callbacks.register("imelee", rock, {
    on_melee_attack = function(payload)
        assert(payload.character ~= nil)
        assert(payload.target ~= nil)
        assert(payload.item ~= nil)
        count("on_melee_attack")
        return false
    end,
    on_miss = function(payload)
        assert(payload.target ~= nil)
        count("on_miss")
    end
})
game.hooks.on("on_shoot", function(payload)
    assert(payload.weapon ~= nil)
    assert(payload.target.coordinate_space == "bub_ms")
    assert(payload.shots == 1)
    count("on_shoot")
end)
game.hooks.on("on_throw", function(payload)
    assert(payload.item ~= nil)
    assert(payload.target.coordinate_space == "bub_ms")
    assert(payload.origin.coordinate_space == "bub_ms")
    count("on_throw")
end)
game.hooks.on("on_creature_melee_attacked", function(payload)
    assert(payload.attacker ~= nil)
    assert(payload.target ~= nil)
    assert(payload.success == false)
    count("on_creature_melee_attacked")
end)
)lua" );
    };

    write_combat_script( false );
    std::string error;
    REQUIRE( reload_scripts( error ) );

    item gun( itype_id( "glock_19" ) );
    gun.set_flag( flag_NEVER_JAMS );
    gun.ammo_set( gun.ammo_default(), 2 );
    REQUIRE( gun.ammo_remaining() == 2 );
    const tripoint_bub_ms ranged_target =
        player.pos_bub( here ) + tripoint_rel_ms::east * 5;
    const int moves_before_veto = player.get_moves();
    CHECK( player.fire_gun( here, ranged_target, 1, gun ) == 0 );
    CHECK( gun.ammo_remaining() == 2 );
    CHECK( player.get_moves() == moves_before_veto );

    write_combat_script( true );
    REQUIRE( reload_scripts( error ) );
    CHECK( player.fire_gun( here, ranged_target, 1, gun ) == 1 );
    CHECK( gun.ammo_remaining() == 1 );

    item thrown_rock( itype_id( "rock" ) );
    player.throw_item(
        player.pos_bub( here ) + tripoint_rel_ms::south * 2,
        thrown_rock );

    item melee_rock( itype_id( "rock" ) );
    REQUIRE( player.wield( melee_rock ) );
    monster &target = spawn_test_monster(
                          "mon_zombie",
                          player.pos_bub( here ) + tripoint_rel_ms::east );
    CHECK( player.melee_attack_abstract(
               target, false, matec_id( "" ) ) );
    g->remove_zombie( target );

    script.write( R"lua(
assert(state.character.get("native_combat.can_fire", 0) == 2)
assert(state.character.get("native_combat.on_fire", 0) == 2)
assert(state.character.get("native_combat.on_shoot", 0) == 1)
assert(state.character.get("native_combat.on_throw", 0) == 1)
assert(state.character.get("native_combat.on_melee_attack", 0) == 1)
assert(state.character.get("native_combat.on_miss", 0) == 1)
assert(state.character.get(
    "native_combat.on_creature_melee_attacked", 0) == 1)
)lua" );
    REQUIRE( reload_scripts( error ) );
}

TEST_CASE( "lua_v5_bionic_and_mutation_callbacks_run_from_native_lifecycles",
           "[lua][bindings][callbacks][character][integration]" )
{
    using namespace cata::lua_ui;

    clear_avatar();
    clear_map_without_vision();
    avatar &player = get_avatar();

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "game.callbacks", "game.read", "game.write",
            "state.character"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local bio = game.types.id("bionic", "bio_flashlight")
local mutation = game.types.id("mutation", "WEB_WEAVER")
local function observe(name, id_field, expected)
    return function(payload)
        assert(payload.character ~= nil)
        assert(payload[id_field] == expected)
        state.character.set(
            "native_character." .. name,
            state.character.get("native_character." .. name, 0) + 1)
    end
end

game.callbacks.register("bionic", bio, {
    on_activate = observe("bionic_activate", "bionic", bio),
    on_deactivate = observe("bionic_deactivate", "bionic", bio),
    on_installed = observe("bionic_installed", "bionic", bio),
    on_removed = observe("bionic_removed", "bionic", bio)
})
game.callbacks.register("mutation", mutation, {
    on_activate = observe("mutation_activate", "mutation", mutation),
    on_deactivate = observe(
        "mutation_deactivate", "mutation", mutation),
    on_gain = observe("mutation_gain", "mutation", mutation),
    on_loss = observe("mutation_loss", "mutation", mutation)
})
)lua" );

    std::string error;
    REQUIRE( reload_scripts( error ) );

    player.set_max_power_level( 100_kJ );
    player.set_power_level( 100_kJ );
    const bionic_id flashlight( "bio_flashlight" );
    const bionic_uid flashlight_uid =
        player.add_bionic( flashlight );
    REQUIRE( flashlight_uid != 0 );
    std::optional<bionic *> installed =
        player.find_bionic_by_uid( flashlight_uid );
    REQUIRE( installed );
    CHECK( player.activate_bionic( **installed ) );
    CHECK( player.deactivate_bionic( **installed ) );
    player.remove_bionic( **installed );
    CHECK_FALSE( player.find_bionic_by_uid( flashlight_uid ) );

    const trait_id web_weaver( "WEB_WEAVER" );
    player.set_mutation( web_weaver );
    REQUIRE( player.has_trait( web_weaver ) );
    player.activate_mutation( web_weaver );
    CHECK( player.has_active_mutation( web_weaver ) );
    player.deactivate_mutation( web_weaver );
    CHECK_FALSE( player.has_active_mutation( web_weaver ) );
    player.unset_mutation( web_weaver );
    CHECK_FALSE( player.has_trait( web_weaver ) );

    script.write( R"lua(
assert(state.character.get("native_character.bionic_activate", 0) == 1)
assert(state.character.get("native_character.bionic_deactivate", 0) == 1)
assert(state.character.get("native_character.bionic_installed", 0) == 1)
assert(state.character.get("native_character.bionic_removed", 0) == 1)
assert(state.character.get("native_character.mutation_activate", 0) == 1)
assert(state.character.get("native_character.mutation_deactivate", 0) == 1)
assert(state.character.get("native_character.mutation_gain", 0) == 1)
assert(state.character.get("native_character.mutation_loss", 0) == 1)
)lua" );
    REQUIRE( reload_scripts( error ) );
}

TEST_CASE( "lua_v5_trap_callbacks_run_from_central_trigger_lifecycle",
           "[lua][bindings][callbacks][traps][integration]" )
{
    using namespace cata::lua_ui;

    clear_avatar();
    clear_map_without_vision();
    avatar &player = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms trap_position( 31, 30, 0 );
    player.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    here.trap_set( trap_position, trap_str_id( "tr_bubblewrap" ) );
    const trap &bubblewrap = trap_str_id( "tr_bubblewrap" ).obj();

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "game.callbacks", "game.read", "game.write",
            "state.character"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local bubblewrap = game.types.id("trap", "tr_bubblewrap")
local function count(name)
    local value = state.character.get("native_trap." .. name, 0) + 1
    state.character.set("native_trap." .. name, value)
    return value
end
game.callbacks.register("trap", bubblewrap, {
    can_trigger = function(payload)
        assert(payload.creature ~= nil)
        assert(payload.item == nil)
        assert(payload.trap == bubblewrap)
        assert(payload.position.coordinate_space == "bub_ms")
        return count("can_trigger") > 1
    end,
    on_trigger = function(payload)
        assert(payload.trap == bubblewrap)
        count("on_trigger")
    end,
    on_trigger_aftermath = function(payload)
        assert(payload.trap == bubblewrap)
        count("on_trigger_aftermath")
    end
})
)lua" );

    std::string error;
    REQUIRE( reload_scripts( error ) );

    bubblewrap.trigger( trap_position, player );
    CHECK( here.tr_at( trap_position ).id ==
           trap_str_id( "tr_bubblewrap" ) );
    bubblewrap.trigger( trap_position, player );
    CHECK( here.tr_at( trap_position ).is_null() );

    script.write( R"lua(
assert(state.character.get("native_trap.can_trigger", 0) == 2)
assert(state.character.get("native_trap.on_trigger", 0) == 1)
assert(state.character.get("native_trap.on_trigger_aftermath", 0) == 1)
)lua" );
    REQUIRE( reload_scripts( error ) );
}

TEST_CASE( "lua_v5_monster_callbacks_collect_menus_and_observe_taming",
           "[lua][bindings][callbacks][monsters][integration]" )
{
    using namespace cata::lua_ui;

    clear_avatar();
    clear_map_without_vision();
    avatar &player = get_avatar();
    map &here = get_map();
    player.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const std::string monster_type = "mon_zombie";
    monster &target = spawn_test_monster(
                          monster_type,
                          player.pos_bub( here ) + tripoint_rel_ms::east );

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "events", "game.callbacks", "game.hooks", "game.read",
            "game.write", "state.character"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local zombie = game.types.id("monster", "mon_zombie")
local function count(name)
    state.character.set(
        "native_monster." .. name,
        state.character.get("native_monster." .. name, 0) + 1)
end
game.callbacks.register("monster", zombie, {
    priority = 100,
    get_examine_menu_entries = function()
        count("bad_actor_get_menu")
        return { entries = "not a table" }
    end
})
game.callbacks.register("monster", zombie, {
    get_examine_menu_entries = function(payload)
        assert(payload.character ~= nil)
        assert(payload.monster ~= nil)
        count("actor_get_menu")
        return {
            { menu_id = "actor_entry", menu_label = "Actor entry" },
            { id = "shared_entry", label = "Actor wins" }
        }
    end,
    on_examine_menu_entry = function(payload)
        assert(payload.entry == "actor_entry")
        count("actor_select")
    end,
    on_tame = function(payload)
        assert(payload.monster_type == zombie)
        count("actor_tame")
    end
})
game.hooks.on("on_monster_get_examine_menu_entries",
    { priority = 100 }, function()
        count("bad_hook_get_menu")
        return { entries = "not a table" }
    end)
game.hooks.on("on_monster_get_examine_menu_entries", function(payload)
    assert(payload.monster ~= nil)
    count("hook_get_menu")
    return {
        entries = {
            { id = "hook_entry", label = "Hook entry", enabled = false },
            { id = "shared_entry", label = "Hook duplicate" }
        }
    }
end)
game.hooks.on("on_monster_examine_menu_entry", function(payload)
    assert(payload.entry == "actor_entry")
    count("hook_select")
end)
game.hooks.on("on_monster_tame", function(payload)
    assert(payload.monster_type == zombie)
    count("hook_tame")
end)
)lua" );

    std::string error;
    REQUIRE( reload_scripts( error ) );
    const std::uint64_t initial_callback_count =
        status().callback_count;

    const native_callback_arguments payload = {
        { "character", static_cast<const Character *>( &player ) },
        { "monster", static_cast<const Creature *>( &target ) },
        {
            "monster_type", native_callback_id {
                "monster", monster_type
            }
        }
    };
    const std::vector<native_menu_entry> actor_entries =
        collect_native_callback_menu_entries(
            "monster", monster_type,
            "get_examine_menu_entries", payload );
    REQUIRE( actor_entries.size() == 2 );
    CHECK( actor_entries[0].id == "actor_entry" );
    CHECK( actor_entries[0].label == "Actor entry" );
    CHECK( actor_entries[0].enabled );
    CHECK( status().callback_count == initial_callback_count + 2 );

    const std::vector<native_menu_entry> hook_entries =
        collect_native_hook_menu_entries(
            "on_monster_get_examine_menu_entries", payload );
    REQUIRE( hook_entries.size() == 2 );
    CHECK( hook_entries[0].id == "hook_entry" );
    CHECK( hook_entries[0].label == "Hook entry" );
    CHECK_FALSE( hook_entries[0].enabled );
    CHECK( status().callback_count == initial_callback_count + 4 );
    CHECK( status().last_error.find(
               "'entries' must be a table" ) != std::string::npos );

    native_callback_arguments selection_payload = payload;
    selection_payload.push_back( {
        "entry", std::string( "actor_entry" )
    } );
    CHECK( dispatch_native_callback(
               "monster", monster_type,
               "on_examine_menu_entry", selection_payload ) );
    CHECK( dispatch_native_hook(
               "on_monster_examine_menu_entry", selection_payload ) );

    target.make_pet( player );
    CHECK( target.is_pet() );
    CHECK( status().callback_count == initial_callback_count + 8 );

    script.write( R"lua(
assert(state.character.get("native_monster.bad_actor_get_menu", 0) == 1)
assert(state.character.get("native_monster.bad_hook_get_menu", 0) == 1)
assert(state.character.get("native_monster.actor_get_menu", 0) == 1)
assert(state.character.get("native_monster.hook_get_menu", 0) == 1)
assert(state.character.get("native_monster.actor_select", 0) == 1)
assert(state.character.get("native_monster.hook_select", 0) == 1)
assert(state.character.get("native_monster.actor_tame", 0) == 1)
assert(state.character.get("native_monster.hook_tame", 0) == 1)
)lua" );
    REQUIRE( reload_scripts( error ) );
    g->remove_zombie( target );
}

TEST_CASE( "lua_v5_recipe_catalog_is_detached_filtered_and_bounded",
           "[lua][bindings][recipes][crafting][integration]" )
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
local limits = game.recipes.limits()
assert(limits.default_limit == 64)
assert(limits.maximum_limit == 256)
assert(limits.maximum_batch == 1000)

local page = game.recipes.list({
    offset = 0,
    limit = 3,
    include_obsolete = false
})
assert(page.limit == 3)
assert(page.returned == #page.items)
assert(page.returned <= page.total)
assert(page.has_more ==
    (page.offset + page.returned < page.total))
for _, entry in ipairs(page.items) do
    assert(entry.id.kind == "recipe")
    assert(type(entry.result_name) == "string")
    assert(type(entry.category) == "string")
    assert(type(entry.subcategory) == "string")
    assert(math.type(entry.difficulty) == "integer")
    assert(entry.time.turns >= 0)
    assert(entry.required_skills.returned ==
        #entry.required_skills.items)
    assert(entry.books.returned == #entry.books.items)
    assert(entry.proficiencies.returned ==
        #entry.proficiencies.items)
    assert(type(entry.availability.known) == "boolean")
    assert(type(entry.availability.craftable) == "boolean")
end

local cudgel = game.types.id(
    "recipe", "cudgel_test_no_tools")
local detail = game.recipes.get(cudgel, 2)
assert(detail.id == cudgel)
assert(detail.result.kind == "item")
assert(detail.result.value == "cudgel")
assert(detail.batch == 2)
assert(detail.time.turns >= 0)
assert(type(detail.description) == "string")

local fabrication = game.types.id("skill", "fabrication")
local skill_page = game.recipes.by_skill(
    fabrication, { limit = 8 })
assert(skill_page.returned == #skill_page.items)
for _, entry in ipairs(skill_page.items) do
    assert(entry.primary_skill == fabrication)
end

local baseball = game.types.id("recipe", "test_baseball")
assert(game.recipes.has_flag(baseball, "BLIND_EASY") == true)
local flag_page = game.recipes.by_flag(
    "BLIND_EASY", { limit = 8 })
assert(flag_page.returned == #flag_page.items)
for _, entry in ipairs(flag_page.items) do
    assert(game.recipes.has_flag(entry.id, "BLIND_EASY"))
end

assert(pcall(function()
    game.recipes.list({ limit = -1 })
end) == false)
assert(pcall(function()
    game.recipes.list({ batch = 1001 })
end) == false)
assert(pcall(function()
    game.recipes.list({ skill = cudgel })
end) == false)
assert(pcall(function()
    game.recipes.list({ unknown = true })
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( "game.recipes.list({ limit = 1 })" );
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.find( "game.read" ) != std::string::npos );
}

TEST_CASE( "lua_v5_requirements_are_structured_bounded_and_inventory_aware",
           "[lua][bindings][requirements][crafting][integration]" )
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
local limits = game.requirements.limits()
assert(limits.default_limit == 64)
assert(limits.maximum_limit == 256)
assert(limits.maximum_batch == 1000)
assert(limits.maximum_groups == 128)
assert(limits.maximum_alternatives_per_group == 64)

local eggs = game.requirements.get("test_eggs", 2)
assert(eggs ~= nil)
assert(eggs.id == "test_eggs")
assert(eggs.batch == 2)
assert(type(eggs.null) == "boolean")
assert(type(eggs.empty) == "boolean")
assert(type(eggs.blacklisted) == "boolean")
assert(type(eggs.can_make) == "boolean")
assert(type(eggs.all_text) == "string")
assert(type(eggs.missing_text) == "string")
assert(eggs.tools.returned == #eggs.tools.items)
assert(eggs.qualities.returned == #eggs.qualities.items)
assert(eggs.components.returned == #eggs.components.items)
assert(eggs.components.total == 1)
local group = eggs.components.items[1]
assert(group.total == 1)
assert(group.returned == #group.items)
assert(type(group.satisfied) == "boolean")
local component = group.items[1]
assert(component.id ==
    game.types.id("item", "test_egg"))
assert(component.count == 2)
assert(component.count_for_batch == 4)
assert(type(component.by_charges) == "boolean")
assert(type(component.available) == "boolean")

assert(game.requirements.get(
    "this_requirement_does_not_exist") == nil)

local page = game.requirements.list({
    offset = 0,
    limit = 2,
    batch = 1
})
assert(page.limit == 2)
assert(page.returned == #page.items)
assert(page.has_more ==
    (page.offset + page.returned < page.total))

local recipe = game.types.id(
    "recipe", "cudgel_test_no_tools")
local needs = game.requirements.for_recipe(recipe, 3)
assert(needs.recipe == recipe)
assert(needs.batch == 3)
assert(math.type(needs.deduped_alternative_count) ==
    "integer")
assert(type(needs.deduped_too_complex) == "boolean")
assert(type(needs.has_required_skills) == "boolean")
assert(type(needs.has_required_proficiencies) == "boolean")
assert(needs.components.returned ==
    #needs.components.items)

assert(pcall(function()
    game.requirements.get("", 1)
end) == false)
assert(pcall(function()
    game.requirements.get("test_eggs", 0)
end) == false)
assert(pcall(function()
    game.requirements.for_recipe(
        game.types.id("item", "rock"), 1)
end) == false)
assert(pcall(function()
    game.requirements.list({ unknown = true })
end) == false)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_crafting_starts_only_through_the_safe_action_queue",
           "[lua][bindings][crafting][actions][integration]" )
{
    clear_avatar();
    on_out_of_scope reset_avatar( []() {
        clear_avatar();
    } );
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "events",
            "game.actions",
            "game.read",
            "game.write"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local recipe = game.types.id(
    "recipe", "cudgel_test_no_tools")

assert(pcall(function()
    game.crafting.queue_start(recipe)
end) == false)
assert(pcall(function()
    game.crafting.queue_start(recipe, { batch = 0 })
end) == false)
assert(pcall(function()
    game.crafting.queue_start(recipe, { batch = 1001 })
end) == false)
assert(pcall(function()
    game.crafting.queue_start(recipe, { long = 1 })
end) == false)
assert(pcall(function()
    game.crafting.queue_start(recipe, { unknown = true })
end) == false)
assert(pcall(function()
    game.crafting.queue_start(
        game.types.id("item", "rock"))
end) == false)

events.on("game_begin", function()
    local request = game.crafting.queue_start(
        recipe, { batch = 1, long = false })
    assert(math.type(request) == "integer")
    local status = game.actions.status(0)
    assert(status.pending_count == 1)
    assert(#status.pending == 1)
    assert(status.pending[1].request_id == request)
    assert(status.pending[1].type == "craft")
    assert(status.pending[1].recipe ==
        "cudgel_test_no_tools")
    assert(status.pending[1].batch == 1)
    assert(status.pending[1].long == false)
    assert(status.pending[1].source == "user")
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    avatar &player = get_avatar();
    player.learn_recipe(
        &recipe_id( "cudgel_test_no_tools" ).obj() );
    if( player.activity ) {
        player.cancel_activity();
    }
    get_event_bus().send<event_type::game_begin>(
        "lua-crafting-action-test" );
    player.activity = player_activity(
                          activity_id( "ACT_AIM" ), 100 );
    const std::optional<bool> dispatched =
        cata::lua_ui::process_next_action();
    REQUIRE( dispatched );
    CHECK_FALSE( *dispatched );
    CHECK_FALSE( cata::lua_ui::process_next_action() );

    if( player.activity ) {
        player.cancel_activity();
    }
    player.controlling_vehicle = true;
    get_event_bus().send<event_type::game_begin>(
        "lua-crafting-driving-action-test" );
    const std::optional<bool> driving_dispatch =
        cata::lua_ui::process_next_action();
    player.controlling_vehicle = false;
    REQUIRE( driving_dispatch );
    CHECK_FALSE( *driving_dispatch );
    CHECK_FALSE( cata::lua_ui::process_next_action() );

    script.write( R"lua(
local status = game.actions.status()
assert(status.pending_count == 0)
assert(status.result_count == 2)
assert(#status.results == 2)
assert(status.results[1].type == "craft")
assert(status.results[1].status == "failed")
assert(status.results[1].action_taken == false)
assert(string.find(status.results[1].error,
    "activity", 1, true) ~= nil)
assert(status.results[2].type == "craft")
assert(status.results[2].status == "failed")
assert(status.results[2].action_taken == false)
assert(string.find(status.results[2].error,
    "crafting is not currently allowed", 1, true) ~= nil)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );

    if( player.activity ) {
        player.cancel_activity();
    }
}

TEST_CASE( "lua_v5_bounded_requirement_groups_check_every_alternative",
           "[lua][bindings][requirements][crafting][integration]" )
{
    clear_avatar();
    clear_map();
    on_out_of_scope reset_world( []() {
        clear_avatar();
        clear_map();
    } );

    avatar &player = get_avatar();
    player.i_add( item( itype_id( "rock" ) ) );

    std::vector<item_comp> alternatives;
    alternatives.reserve( 65 );
    for( std::size_t index = 0; index < 64; ++index ) {
        alternatives.emplace_back(
            itype_id( "2x4" ), 1 );
    }
    alternatives.emplace_back( itype_id( "rock" ), 1 );

    requirement_data::alter_item_comp_vector components;
    components.emplace_back( std::move( alternatives ) );
    const requirement_id requirement(
        "lua_v5_bounded_alternatives" );
    auto &all_requirements = const_cast<
                             std::map<requirement_id,
                             requirement_data> &>(
                                 requirement_data::all() );
    REQUIRE( all_requirements.count( requirement ) == 0 );
    on_out_of_scope remove_requirement(
    [&all_requirements, &requirement]() {
        all_requirements.erase( requirement );
    } );
    requirement_data::save_requirement(
        requirement_data( {}, {}, components ),
        requirement );

    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local requirement =
    game.requirements.get(
        "lua_v5_bounded_alternatives")
local group = requirement.components.items[1]
assert(group.total == 65)
assert(group.returned == 64)
assert(#group.items == 64)
assert(group.truncated == true)
assert(group.satisfied == true)
for index = 1, #group.items do
    assert(group.items[index].available == false)
end
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_v5_mapgen_context_is_bounded_deterministic_and_scoped",
           "[lua][bindings][mapgen][context]" )
{
    small_fake_map scratch( ter_str_id( "t_dirt" ).id() );
    mapgendata data(
        *scratch.cast_to_map(), mapgendata::dummy_settings );

    cata::lua_ui::script_mapgen_context read_only(
        data, false, UINT64_C( 0x123456789abcdef0 ) );
    CHECK( read_only.valid() );
    CHECK( read_only.id() ==
           cata::lua_ui::script_game_id(
               "overmap_terrain", "field" ) );
    CHECK( read_only.north() == read_only.get_nesw( 0 ) );
    CHECK( read_only.east() == read_only.get_nesw( 1 ) );
    CHECK( read_only.south() == read_only.get_nesw( 2 ) );
    CHECK( read_only.west() == read_only.get_nesw( 3 ) );
    CHECK( read_only.neast() == read_only.get_nesw( 4 ) );
    CHECK( read_only.seast() == read_only.get_nesw( 5 ) );
    CHECK( read_only.swest() == read_only.get_nesw( 6 ) );
    CHECK( read_only.nwest() == read_only.get_nesw( 7 ) );
    CHECK( read_only.above().value() == "field" );
    CHECK( read_only.below().value() == "field" );
    CHECK( read_only.zlevel() == 0 );
    CHECK( read_only.get_rotation() == 0 );
    CHECK( read_only.get_rot_suffix() == "_north" );
    CHECK( read_only.terrain_at( 0, 0 ).value() == "t_dirt" );
    CHECK_FALSE( read_only.furniture_at( 0, 0 ) );
    CHECK_FALSE( read_only.trap_at( 0, 0 ) );
    CHECK_THROWS( read_only.get_nesw( -1 ) );
    CHECK_THROWS( read_only.get_nesw( 8 ) );
    CHECK_THROWS( read_only.terrain_at( -1, 0 ) );
    CHECK_THROWS( read_only.terrain_at( 24, 0 ) );
    CHECK_THROWS(
        read_only.set_terrain(
            0, 0,
            cata::lua_ui::script_game_id(
                "terrain", "t_grass" ) ) );

    cata::lua_ui::script_mapgen_context random_a(
        data, false, UINT64_C( 0x1111222233334444 ) );
    cata::lua_ui::script_mapgen_context random_b(
        data, false, UINT64_C( 0x1111222233334444 ) );
    for( int index = 0; index < 32; ++index ) {
        CHECK( random_a.random_int( -1000, 1000 ) ==
               random_b.random_int( -1000, 1000 ) );
    }
    CHECK_FALSE( random_a.random_chance( 0, 1 ) );
    CHECK( random_a.random_chance( 1, 1 ) );
    CHECK_THROWS( random_a.random_int( 2, 1 ) );
    CHECK_THROWS( random_a.random_chance( 2, 1 ) );

    cata::lua_ui::script_mapgen_context budgeted(
        data, false, UINT64_C( 0x777788889999aaaa ) );
    for( std::size_t operation = 0;
         operation <
         cata::lua_ui::script_mapgen_context::maximum_operations;
         ++operation ) {
        static_cast<void>( budgeted.random_int( 0, 1 ) );
    }
    CHECK( budgeted.operations_remaining() == 0 );
    CHECK_THROWS( budgeted.random_int( 0, 1 ) );

    cata::lua_ui::script_mapgen_context writable(
        data, true, UINT64_C( 0x5555666677778888 ) );
    const cata::lua_ui::script_game_id grass(
        "terrain", "t_grass" );
    const cata::lua_ui::script_game_id armchair(
        "furniture", "f_armchair" );
    const cata::lua_ui::script_game_id bubblewrap(
        "trap", "tr_bubblewrap" );
    CHECK( writable.set_terrain( 0, 0, grass ) );
    CHECK( writable.terrain_at( 0, 0 ) == grass );
    CHECK( writable.set_furniture( 0, 0, armchair ) );
    REQUIRE( writable.furniture_at( 0, 0 ) );
    CHECK( *writable.furniture_at( 0, 0 ) == armchair );
    CHECK( writable.set_trap( 0, 0, bubblewrap ) );
    REQUIRE( writable.trap_at( 0, 0 ) );
    CHECK( *writable.trap_at( 0, 0 ) == bubblewrap );
    writable.set_dir( 3, 42 );
    CHECK( writable.get_direction( 3 ) == 42 );
    CHECK_THROWS( writable.set_dir( 8, 0 ) );
    CHECK_THROWS(
        writable.nest( "unknown_lua_nested_mapgen", 0, 0 ) );
    writable.nest( "mapgen_test_nested", 2, 2 );
    CHECK( writable.operations_used() > 0 );
    CHECK( writable.operations_remaining() <
           cata::lua_ui::script_mapgen_context::maximum_operations );

    writable.invalidate();
    CHECK_FALSE( writable.valid() );
    CHECK_THROWS( writable.id() );
    CHECK_THROWS( writable.operations_used() );
}

TEST_CASE( "lua_v5_mapgen_hooks_are_filtered_ordered_and_read_only",
           "[lua][bindings][mapgen][hooks][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [ "events", "game.hooks", "game.read" ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local calls = 0
local retained = nil
local limits = game.mapgen.limits()
assert(limits.map_width == 24 and limits.map_height == 24)
assert(limits.operations == 8192)
assert(limits.nested_generators == 32)
assert(limits.full_generators == 4)
assert(limits.handlers == 1024)
assert(limits.registered == 0)
assert(limits.terrain_ids == 64)

assert(pcall(function()
    game.mapgen.on_postprocess({
        terrain_ids = { "__unknown_lua_oter__" }
    }, function() end)
end) == false)
assert(pcall(function()
    game.mapgen.on_postprocess({
        z_min = 1, z_max = 0
    }, function() end)
end) == false)

local removed = game.mapgen.on_postprocess(function()
    error("removed mapgen handler ran")
end)
assert(game.mapgen.off(removed) == true)
assert(game.mapgen.off(removed) == false)

game.mapgen.on_postprocess({
    priority = 100,
    once = true,
    terrain_ids = { "field", "field" },
    z_min = 0,
    z_max = 0
}, function(ctx)
    calls = calls + 1
    assert(calls == 1)
    assert(ctx:valid())
    assert(ctx:id().kind == "overmap_terrain")
    assert(ctx:id().value == "field")
    assert(ctx:zlevel() == 0)
    assert(ctx:get_rot_suffix() == "_north")
    assert(ctx:north().kind == "overmap_terrain")
    assert(ctx:operations_used() > 0)
    retained = ctx
    local grass = game.types.id("terrain", "t_grass")
    assert(pcall(function()
        ctx:set_terrain(0, 0, grass)
    end) == false)
end)

game.mapgen.on_postprocess({ priority = -100 }, function(ctx)
    calls = calls + 1
    if calls == 2 then
        assert(retained ~= nil)
        assert(retained:valid() == false)
        assert(pcall(function() retained:id() end) == false)
    else
        assert(calls == 3)
    end
    assert(ctx:valid())
end)

game.mapgen.on_postprocess({
    terrain_ids = { "forest" }
}, function()
    error("terrain-filtered mapgen handler ran")
end)
game.mapgen.on_postprocess({
    z_min = 1,
    z_max = 1
}, function()
    error("z-filtered mapgen handler ran")
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    small_fake_map scratch( ter_str_id( "t_dirt" ).id() );
    mapgendata data(
        *scratch.cast_to_map(), mapgendata::dummy_settings );
    cata::lua_ui::dispatch_mapgen_postprocess( data );
    CHECK( cata::lua_ui::status().last_error.empty() );
    cata::lua_ui::dispatch_mapgen_postprocess( data );
    CHECK( cata::lua_ui::status().last_error.empty() );
}

TEST_CASE( "lua_v5_mapgen_hooks_mutate_with_scoped_deterministic_contexts",
           "[lua][bindings][mapgen][hooks][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "events", "game.hooks", "game.read", "game.write"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
local calls = 0
local retained = nil
local first_sequence = nil

game.mapgen.on_postprocess({
    priority = 100,
    once = true,
    terrain_ids = { "field" },
    z_min = 0,
    z_max = 0
}, function(ctx)
    calls = calls + 1
    assert(calls == 1)
    retained = ctx
    assert(pcall(function() ctx:terrain_at(-1, 0) end) == false)
    assert(pcall(function()
        ctx:set_terrain(
            0, 0,
            game.types.id("terrain", "__unknown_lua_terrain__"))
    end) == false)
    assert(pcall(function()
        ctx:nest("__unknown_lua_nested_mapgen__", 0, 0)
    end) == false)

    assert(ctx:set_terrain(
        1, 1, game.types.id("terrain", "t_grass")))
    assert(ctx:set_furniture(
        2, 2, game.types.id("furniture", "f_armchair")))
    assert(ctx:set_trap(
        3, 3, game.types.id("trap", "tr_bubblewrap")))
    ctx:nest("mapgen_test_nested", 4, 4)
end)

game.mapgen.on_postprocess({ priority = 0 }, function(ctx)
    calls = calls + 1
    assert(retained ~= nil and retained:valid() == false)
    assert(ctx:terrain_at(1, 1).value == "t_grass")
    assert(ctx:furniture_at(2, 2).value == "f_armchair")
    assert(ctx:trap_at(3, 3).value == "tr_bubblewrap")

    local sequence = {
        ctx:random_int(-1000, 1000),
        ctx:random_int(-1000, 1000),
        ctx:random_int(-1000, 1000)
    }
    if first_sequence == nil then
        assert(calls == 2)
        first_sequence = sequence
    else
        assert(calls == 3)
        for index = 1, #sequence do
            assert(sequence[index] == first_sequence[index])
        end
    end
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    small_fake_map scratch( ter_str_id( "t_dirt" ).id() );
    mapgendata data(
        *scratch.cast_to_map(), mapgendata::dummy_settings );
    cata::lua_ui::dispatch_mapgen_postprocess( data );
    CHECK( cata::lua_ui::status().last_error.empty() );
    CHECK( scratch.cast_to_map()->ter(
               tripoint_bub_ms( 1, 1, 0 ) ) ==
           ter_str_id( "t_grass" ).id() );
    CHECK( scratch.cast_to_map()->furn(
               tripoint_bub_ms( 2, 2, 0 ) ) ==
           furn_str_id( "f_armchair" ).id() );
    CHECK( scratch.cast_to_map()->tr_at(
               tripoint_bub_ms( 3, 3, 0 ) ).id ==
           trap_str_id( "tr_bubblewrap" ) );

    cata::lua_ui::dispatch_mapgen_postprocess( data );
    CHECK( cata::lua_ui::status().last_error.empty() );
}

TEST_CASE( "lua_v5_mapgen_hooks_respect_the_native_postprocess_gate",
           "[lua][bindings][mapgen][hooks][integration]" )
{
    scoped_lua_user_script script;
    script.write_manifest( R"json({
        "id": "user",
        "version": "5.0.0",
        "api_version": 5,
        "capabilities": [
            "events", "game.hooks", "game.read",
            "game.write"
        ],
        "dependencies": [ "builtin" ]
    })json" );
    script.write( R"lua(
game.mapgen.on_postprocess({
    once = true,
    terrain_ids = { "field" },
    z_min = 0,
    z_max = 0
}, function(ctx)
    ctx:set_furniture(
        0, 0,
        game.types.id("furniture", "f_armchair"))
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );

    const tripoint_abs_omt position( 77, 77, 0 );
    std::vector<std::pair<tripoint_abs_omt, oter_id>>
            original_terrain;
    for( int dx = -1; dx <= 1; ++dx ) {
        for( int dy = -1; dy <= 1; ++dy ) {
            const tripoint_abs_omt nearby =
                position + tripoint( dx, dy, 0 );
            original_terrain.emplace_back(
                nearby, overmap_buffer.ter( nearby ) );
            overmap_buffer.ter_set(
                nearby, oter_str_id( "field" ).id() );
        }
    }
    on_out_of_scope restore_terrain( [&original_terrain]() {
        for( const auto &[where, terrain] : original_terrain ) {
            overmap_buffer.ter_set( where, terrain );
        }
    } );

    const auto generated_furniture =
    [&position]( const bool run_post_process ) {
        smallmap generated;
        generated.generate(
            position, calendar::turn, false,
            run_post_process );
        const furn_id result = generated.cast_to_map()->furn(
                                   tripoint_bub_ms( 0, 0, 0 ) );
        generated.delete_unmerged_submaps();
        return result;
    };

    const furn_id marker = furn_str_id( "f_armchair" ).id();
    CHECK( generated_furniture( false ) != marker );
    CHECK( generated_furniture( true ) == marker );
    CHECK( cata::lua_ui::status().last_error.empty() );
}
