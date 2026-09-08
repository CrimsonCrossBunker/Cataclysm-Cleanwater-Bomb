#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include <array>
#include <cmath>
#include <limits>

#include "cata_path.h"
#include "lua_platform_state.h"
#include "path_info.h"
#include "worldfactory.h"

TEST_CASE( "lua_platform_state_codec_preserves_double_precision_and_signed_zero",
           "[lua][platform][state][persistence]" )
{
    namespace platform = cata::lua_platform;
    const std::array<double, 7> values = {{
            1.2345678901234567, std::nextafter( 1.0, 2.0 ), 1.0e-20, 1.0e20,
            std::numeric_limits<double>::max(), std::numeric_limits<double>::denorm_min(), -0.0
        }
    };
    platform::script_persistent_state source;
    for( std::size_t index = 0; index < values.size(); ++index ) {
        platform::assign_persistent_value( source, std::to_string( index ), values[index] );
    }
    std::ostringstream output;
    platform::write_persistent_state( output, source );
    const platform::script_persistent_state restored = platform::read_persistent_state(
            json_loader::from_string( output.str() ) );
    REQUIRE( restored.size() == values.size() );
    for( std::size_t index = 0; index < values.size(); ++index ) {
        INFO( index );
        const double value = std::get<double>( restored.at( std::to_string( index ) ) );
        CHECK( value == values[index] );
        CHECK( std::signbit( value ) == std::signbit( values[index] ) );
    }
}

TEST_CASE( "lua_platform_runtime_scope_files_preserve_small_and_adjacent_doubles",
           "[lua][platform][state][persistence]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    REQUIRE( world_generator != nullptr );
    const platform_lua_test_directory temporary;
    const std::string old_savedir = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "state_float_precision" );
    sol::state old_lua;
    sol::state new_lua;
    const on_out_of_scope cleanup( [&]() {
        platform::clear_active_runtimes();
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
    } );
    PATH_INFO::set_savedir( temporary.root.string() + "/" );
    world_generator->active_world = &isolated_world;
    REQUIRE( std::filesystem::create_directory( isolated_world.folder_path().get_unrelative_path() ) );
    const std::shared_ptr<platform::runtime> before = platform::make_runtime( "float-owner", 2014,
        old_lua );
    platform::set_active_runtimes( { before } );
    platform::assign_persistent_value( before->world_state, "tiny", 1.0e-20 );
    const double adjacent = std::nextafter( 1.0, 2.0 );
    platform::assign_persistent_value( before->character_state, "adjacent", adjacent );
    std::string error;
    REQUIRE( platform::runtime_save( error ) );
    platform::clear_active_runtimes();
    const std::shared_ptr<platform::runtime> after = platform::make_runtime( "float-owner", 2015,
        new_lua );
    platform::set_active_runtimes( { after } );
    platform::runtime_world_ready( false );
    REQUIRE( after->world_state.size() == 1 );
    REQUIRE( after->character_state.size() == 1 );
    CHECK( std::get<double>( after->world_state.at( "tiny" ) ) == 1.0e-20 );
    CHECK( std::get<double>( after->character_state.at( "adjacent" ) ) == adjacent );
}
#endif
