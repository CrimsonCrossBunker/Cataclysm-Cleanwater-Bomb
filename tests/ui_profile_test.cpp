#include "catch/catch.hpp"

#include "path_info.h"
#include "ui_profile.h"

#include <array>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <string>
#include <utility>

TEST_CASE( "adaptive_ui_profiles_only_change_layout_policy", "[ui][profile]" )
{
    const cata::ui::profile touch = cata::ui::make_profile( cata::ui::input_mode::touch );
    const cata::ui::profile desktop =
        cata::ui::make_profile( cata::ui::input_mode::mouse_keyboard );
    const cata::ui::profile terminal =
        cata::ui::make_profile( cata::ui::input_mode::terminal );

    CHECK( touch.is_touch() );
    CHECK( touch.allow_swipe );
    CHECK( touch.native_text_input );
    CHECK( touch.use_touch_main_menu );
    CHECK( touch.minimum_target > desktop.minimum_target );
    CHECK( touch.page_width == 1.0F );

    CHECK_FALSE( desktop.is_touch() );
    CHECK( desktop.allow_hover );
    CHECK_FALSE( desktop.native_text_input );
    CHECK_FALSE( desktop.use_touch_main_menu );
    CHECK( desktop.page_width < touch.page_width );

    CHECK( terminal.is_terminal() );
    CHECK_FALSE( terminal.use_touch_main_menu );
    CHECK( terminal.density == cata::ui::density_mode::compact );
    CHECK( cata::ui::input_mode_name( touch.input ) == "touch" );
    CHECK( cata::ui::density_mode_name( desktop.density ) == "comfortable" );

    CHECK( touch.item_width( cata::ui::size_token::normal ) == 260.0F );
    CHECK( touch.row_height( cata::ui::size_token::wide ) == 68.0F );
    CHECK( touch.panel_height( cata::ui::size_token::fill ) == 0.0F );
    CHECK( touch.breakpoint_for_width( 500.0F ) ==
           cata::ui::layout_breakpoint::narrow );
    CHECK( touch.breakpoint_for_width( 900.0F ) ==
           cata::ui::layout_breakpoint::regular );
    CHECK( touch.breakpoint_for_width( 1400.0F ) ==
           cata::ui::layout_breakpoint::wide );
}

TEST_CASE( "bundled_lua_ui_profile_loads_from_the_data_directory",
           "[ui][profile][integration]" )
{
    cata::ui::reset_profile_cache_for_tests();
    const cata::ui::profile loaded = cata::ui::current_profile();
    CHECK_FALSE( loaded.id.empty() );
    CHECK( cata::ui::profile_last_error().empty() );
#if defined(__ANDROID__)
#if defined(CCB_ANDROID_NEW_UI) && CCB_ANDROID_NEW_UI
    CHECK( loaded.input == cata::ui::input_mode::touch );
#else
    CHECK( loaded.input == cata::ui::input_mode::mouse_keyboard );
#endif
#elif defined(TILES)
    CHECK( loaded.input == cata::ui::input_mode::mouse_keyboard );
#else
    CHECK( loaded.input == cata::ui::input_mode::terminal );
#endif
}

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
TEST_CASE( "all_bundled_lua_ui_profiles_are_valid", "[ui][profile][integration]" )
{
    namespace fs = std::filesystem;
    using profile_case = std::pair<const char *, cata::ui::input_mode>;
    const std::array<profile_case, 3> profiles = {{
            { "android_touch", cata::ui::input_mode::touch },
            { "pc_legacy", cata::ui::input_mode::mouse_keyboard },
            { "terminal_legacy", cata::ui::input_mode::terminal }
        }
    };

    for( const profile_case &profile : profiles ) {
        const fs::path path = fs::u8path( PATH_INFO::datadir() ) / "lua" / "ui" /
                              "profiles" / ( std::string( profile.first ) + ".lua" );
        std::ifstream input( path, std::ios::binary );
        REQUIRE( input );
        const std::string source{ std::istreambuf_iterator<char>( input ),
                                  std::istreambuf_iterator<char>() };
        cata::ui::profile parsed;
        std::string error;
        INFO( path.string() );
        REQUIRE( cata::ui::load_profile_from_lua(
                     source, path.string(), cata::ui::make_profile( profile.second ),
                     parsed, error ) );
        CHECK( error.empty() );
        CHECK( parsed.id == profile.first );
        CHECK( parsed.input == profile.second );
    }
}

TEST_CASE( "lua_ui_profiles_are_declarative_bounded_and_fallback_safe", "[ui][profile][lua]" )
{
    const cata::ui::profile fallback =
        cata::ui::make_profile( cata::ui::input_mode::touch );
    cata::ui::profile parsed;
    std::string error;
    const std::string valid = R"lua(
return {
    schema = 1,
    id = "android_touch",
    input = "touch",
    density = "touch",
    metrics = {
        minimum_target = 64,
        width_compact = 180,
        width_normal = 300,
        width_wide = 480,
        breakpoint_narrow = 700,
        breakpoint_wide = 1100,
    },
    interaction = {
        tap_activation = true,
        touch_main_menu = true,
    },
}
)lua";
    REQUIRE( cata::ui::load_profile_from_lua(
                 valid, "valid_profile.lua", fallback, parsed, error ) );
    CHECK( error.empty() );
    CHECK( parsed.id == "android_touch" );
    CHECK( parsed.minimum_target == 64.0F );
    CHECK( parsed.width_normal == 300.0F );
    CHECK( parsed.tap_activation );
    CHECK( parsed.use_touch_main_menu );

    SECTION( "executable loops are stopped by the bootstrap budget" ) {
        CHECK_FALSE( cata::ui::load_profile_from_lua(
                         "while true do end", "loop.lua", fallback, parsed, error ) );
        CHECK( error.find( "instruction budget exceeded" ) != std::string::npos );
        CHECK( parsed.id == fallback.id );
    }

    SECTION( "invalid semantic ordering uses the compiled fallback" ) {
        std::string invalid = valid;
        const std::string from = "width_normal = 300";
        invalid.replace( invalid.find( from ), from.size(), "width_normal = 900" );
        CHECK_FALSE( cata::ui::load_profile_from_lua(
                         invalid, "invalid.lua", fallback, parsed, error ) );
        CHECK_FALSE( error.empty() );
        CHECK( parsed.width_normal == fallback.width_normal );
    }

    SECTION( "unknown fields are rejected instead of silently ignored" ) {
        std::string invalid = valid;
        const std::string from = "minimum_target = 64";
        invalid.replace( invalid.find( from ), from.size(), "minimum_targte = 64" );
        CHECK_FALSE( cata::ui::load_profile_from_lua(
                         invalid, "unknown_field.lua", fallback, parsed, error ) );
        CHECK( error.find( "unknown field 'minimum_targte'" ) != std::string::npos );
        CHECK( parsed.minimum_target == fallback.minimum_target );
    }

    SECTION( "schema is required" ) {
        std::string invalid = valid;
        const std::string from = "    schema = 1,\n";
        invalid.erase( invalid.find( from ), from.size() );
        CHECK_FALSE( cata::ui::load_profile_from_lua(
                         invalid, "missing_schema.lua", fallback, parsed, error ) );
        CHECK( error.find( "schema must be 1" ) != std::string::npos );
        CHECK( parsed.id == fallback.id );
    }
}
#endif
