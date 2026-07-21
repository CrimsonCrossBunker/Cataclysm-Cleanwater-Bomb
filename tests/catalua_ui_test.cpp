#include "cata_catch.h"
#include "avatar.h"
#include "calendar.h"
#include "catalua_ui.h"
#include "catalua_ui_actions.h"
#include "catalua_ui_manifest.h"
#include "catalua_ui_renderer.h"
#include "catalua_ui_retained.h"
#include "catalua_ui_state.h"
#include "event_bus.h"
#include "json_loader.h"
#include "path_info.h"
#include "weather.h"

#include <cstdint>
#include <filesystem>
#include <fstream>
#include <functional>
#include <iterator>
#include <limits>
#include <map>
#include <optional>
#include <sstream>
#include <stdexcept>
#include <string>
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
                static_cast<std::uint32_t>( capability::virtualization ),
                false, true
            };
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

class scoped_lua_state_file
{
    public:
        scoped_lua_state_file() : path_( ( PATH_INFO::player_base_save_path() +
                                               ".lua_ui.json" ).get_unrelative_path() ) {
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
    CHECK( context.supports( "progress_bar" ) );
    CHECK( context.supports( "buttons" ) );
    CHECK( context.supports( "tables" ) );
    CHECK( context.supports( "virtualization" ) );
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
    CHECK( virtual_items == 5 );
    CHECK_THROWS_AS( context.table( "bad", 0, []() {} ), std::invalid_argument );
    CHECK_THROWS_AS( context.virtual_list( -1, 1.0, []( int, int ) {} ),
    std::invalid_argument );
}

TEST_CASE( "retained_lua_renderer_builds_bounded_native_widget_trees",
           "[lua][ui][renderer][retained]" )
{
    using namespace cata::lua_ui;

    retained_ui_document document;
    std::map<std::string, std::string> interactions = {
        { "surface/apply", "click" },
        { "surface/enabled", "bool:0" },
        { "surface/count", "int:7" },
        { "surface/name", "text:原生控件" }
    };
    const retained_interaction_reader reader = [&interactions]( const std::string & id )
    -> std::optional<std::string> {
        const auto found = interactions.find( id );
        if( found == interactions.end() )
        {
            return std::nullopt;
        }
        const std::string value = found->second;
        interactions.erase( found );
        return value;
    };
    std::unique_ptr<script_ui_renderer> renderer = make_retained_script_ui_renderer(
                document, "surface/", reader );
    script_ui_context context( *renderer );

    CHECK( context.backend() == "retained" );
    CHECK( context.platform() == "android" );
    CHECK_FALSE( context.is_immediate_mode() );
    CHECK( context.uses_native_widgets() );
    CHECK( context.button_id( "apply", "Apply" ) );
    CHECK_FALSE( context.checkbox_id( "enabled", "Enabled", true ) );
    CHECK( context.slider_int_id( "count", "Count", 2, 0, 10 ) == 7 );
    CHECK( context.input_text_id( "name", "Name", "old" ) == "原生控件" );

    int rendered_items = 0;
    context.virtual_list( 1000, 24.0, [&rendered_items]( int first, int last ) {
        rendered_items += last - first;
    } );
    CHECK( rendered_items == 200 );
    REQUIRE( document.nodes.size() == 5 );
    CHECK( document.nodes.back().type == "virtual_list" );
    CHECK( document.nodes.back().count == 1000 );
    CHECK( document.nodes.back().truncated );

    const std::string json = retained_document_json( document );
    CHECK( json.find( "surface/apply" ) != std::string::npos );
    CHECK( json.find( "原生控件" ) != std::string::npos );
    CHECK( json.find( "\"truncated\":true" ) != std::string::npos );

    retained_ui_surface surface;
    surface.id = "hud:editable";
    surface.title = "Editable";
    surface.kind = "hud";
    surface.anchor = "bottom_right";
    surface.default_width = 0.31;
    surface.default_height = 0.22;
    surface.movable = false;
    surface.scalable = false;
    surface.user_toggleable = false;
    const std::string surfaces_json = retained_surfaces_json( { surface }, 7, {} );
    CHECK( surfaces_json.find( "\"defaultWidth\":0.31" ) != std::string::npos );
    CHECK( surfaces_json.find( "\"defaultHeight\":0.22" ) != std::string::npos );
    CHECK( surfaces_json.find( "\"movable\":false" ) != std::string::npos );
    CHECK( surfaces_json.find( "\"scalable\":false" ) != std::string::npos );
    CHECK( surfaces_json.find( "\"userToggleable\":false" ) != std::string::npos );
}

TEST_CASE( "lua_module_names_stay_inside_script_roots", "[lua][ui][sandbox]" )
{
    using cata::lua_ui::is_safe_module_name;

    CHECK( is_safe_module_name( "widgets" ) );
    CHECK( is_safe_module_name( "lib.widgets.hud-v2" ) );

    CHECK_FALSE( is_safe_module_name( "" ) );
    CHECK_FALSE( is_safe_module_name( ".hidden" ) );
    CHECK_FALSE( is_safe_module_name( "hidden." ) );
    CHECK_FALSE( is_safe_module_name( "../outside" ) );
    CHECK_FALSE( is_safe_module_name( "lib..outside" ) );
    CHECK_FALSE( is_safe_module_name( "lib/widgets" ) );
    CHECK_FALSE( is_safe_module_name( "C:\\outside" ) );
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
    CHECK( base.api_version == api_version );
    CHECK( base.has_capability( "game.read" ) );
    CHECK_FALSE( base.has_capability( "game.actions" ) );

    script_manifest extension = read_script_manifest( json_loader::from_string( R"json({
        "id": "extension", "version": "2", "api_version": 2,
        "capabilities": [ "events" ], "dependencies": [ "base" ]
    })json" ) );
    CHECK_NOTHROW( validate_script_manifests( { base, extension } ) );
    CHECK_THROWS( validate_script_manifests( { extension, base } ) );

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

    SECTION( "infinite loops are interrupted" ) {
        CHECK_FALSE( cata::lua_ui::validate_snippet( "while true do end", 1000, error ) );
        CHECK( error.find( "instruction budget exceeded" ) != std::string::npos );
    }

    SECTION( "allocations cannot exceed the runtime memory limit" ) {
        CHECK_FALSE( cata::lua_ui::validate_snippet(
                         "return string.rep('x', 40 * 1024 * 1024)", 1000, error ) );
        CHECK_FALSE( error.empty() );
    }
}

TEST_CASE( "bundled_lua_ui_script_registers_api_v2", "[lua][ui][integration]" )
{
    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( error.empty() );

    const cata::lua_ui::runtime_status status = cata::lua_ui::status();
    CHECK( status.loaded );
    CHECK( status.generation > 0 );
    CHECK( status.page_count >= 1 );
    CHECK( status.hud_count >= 1 );
    CHECK( status.event_handler_count >= 1 );
    CHECK( status.memory_used > 0 );
    CHECK( status.memory_used <= status.memory_limit );

    cata::lua_ui::shutdown();
    const cata::lua_ui::runtime_status stopped = cata::lua_ui::status();
    CHECK_FALSE( stopped.loaded );
    CHECK( stopped.page_count == 0 );
    CHECK( stopped.hud_count == 0 );
    CHECK( stopped.event_handler_count == 0 );
    CHECK( stopped.memory_used == 0 );
    CHECK( stopped.last_error.empty() );
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
assert(pcall(function()
    ui.hud("forbidden", {}, function(ctx) end)
end) == false)

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

TEST_CASE( "lua_pages_render_as_android_retained_trees_and_consume_interactions",
           "[lua][ui][renderer][retained][integration]" )
{
    scoped_lua_user_script script;
    script.write( R"lua(
ui.page("retained_test", "Retained test", function(ctx)
    ctx:child("details", 120, function()
        ctx:text("child body")
    end)
    ctx:table("stats", 2, function()
        ctx:table_next_row()
        ctx:table_next_column()
        ctx:text("cell")
    end)
    ctx:tabs("sections", function()
        ctx:tab("first", "First", function()
            ctx:text("tab body")
        end)
    end)
    ctx:tree("advanced", "Advanced", true, function()
        ctx:text("tree body")
    end)
    ctx:virtual_list(3, 20, function(first, last)
        for index = first, last - 1 do
            ctx:text("row " .. index)
        end
    end)
    if ctx:button_id("apply", "Apply") then
        game.state_set("test.retained_clicked", true)
    end
end)
ui.hud("editable_hud", {
    title = "Editable HUD",
    default_anchor = "bottom_right",
    default_x = 18,
    default_y = 20,
    default_width = 0.31,
    default_height = 0.22,
    movable = false,
    scalable = false,
    user_toggleable = false
}, function(ctx)
    ctx:text("editable metadata")
end)
)lua" );

    std::string error;
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    REQUIRE( cata::lua_ui::select_android_page( "retained_test" ) );
    cata::lua_ui::publish_android_snapshot();
    const std::string snapshot = cata::lua_ui::android_snapshot_json();
    CHECK( snapshot.find( "page:retained_test" ) != std::string::npos );
    CHECK( snapshot.find( "hud:editable_hud" ) != std::string::npos );
    CHECK( snapshot.find( "\"defaultWidth\":0.31" ) != std::string::npos );
    CHECK( snapshot.find( "\"defaultHeight\":0.22" ) != std::string::npos );
    CHECK( snapshot.find( "\"movable\":false" ) != std::string::npos );
    CHECK( snapshot.find( "\"scalable\":false" ) != std::string::npos );
    CHECK( snapshot.find( "\"userToggleable\":false" ) != std::string::npos );
    CHECK( snapshot.find( "\"type\":\"child\"" ) != std::string::npos );
    CHECK( snapshot.find( "\"type\":\"table\"" ) != std::string::npos );
    CHECK( snapshot.find( "\"type\":\"tabs\"" ) != std::string::npos );
    CHECK( snapshot.find( "\"type\":\"virtual_list\"" ) != std::string::npos );

    REQUIRE( cata::lua_ui::submit_android_interaction(
                 "page:retained_test/apply", "click" ) );
    cata::lua_ui::publish_android_snapshot();
    script.write( R"lua(
assert(game.state_get("test.retained_clicked", false) == true)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );
    CHECK( cata::lua_ui::status().callback_count == 0 );
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
assert(math.type(player.x) == "integer")
assert(game.player_stats().name == player.name)
assert_plain_snapshot(player)

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

    assert(pcall(function()
        game.actions.enqueue("move", { direction = "sideways" })
    end) == false)
    assert(pcall(function()
        game.actions.enqueue("use_item", { uid = 0 })
    end) == false)
    assert(pcall(function()
        game.actions.enqueue("unknown")
    end) == false)

    local queued = game.actions.status(0)
    assert(queued.pending_count == 1)
    assert(#queued.pending == 1)
    assert(queued.pending[1].type == "cancel_activity")
    assert(queued.pending[1].status == "queued")
    assert(queued.result_count == 1)
    assert(#queued.results == 0)
end)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );

    get_event_bus().send<event_type::game_begin>( "lua-action-test" );
    const std::optional<bool> handled = cata::lua_ui::process_next_action();
    REQUIRE( handled );
    CHECK_FALSE( *handled );
    CHECK_FALSE( cata::lua_ui::process_next_action() );

    script.write( R"lua(
local status = game.actions.status(1000000)
assert(status.pending_count == 0)
assert(status.result_count == 2)
assert(status.result_limit == 128)
assert(#status.results == 2)
assert(status.results[1].type == "wait")
assert(status.results[1].status == "canceled")
assert(status.results[1].action_taken == false)
assert(status.results[2].type == "cancel_activity")
assert(status.results[2].status == "failed")
assert(status.results[2].action_taken == false)
assert(string.find(status.results[2].error, "no activity", 1, true) ~= nil)
)lua" );
    REQUIRE( cata::lua_ui::reload_scripts( error ) );

    cata::lua_ui::shutdown();
    CHECK_FALSE( cata::lua_ui::process_next_action() );
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
    CHECK( after_failure.hud_count == before.hud_count );
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
