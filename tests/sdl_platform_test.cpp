#if defined(TILES)

#include <map>
#include <sstream>
#include <string>

#include "cata_catch.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"
#include "options.h"
#include "options_helpers.h"
#include "sdl_version_wrappers.h"

TEST_CASE( "tiles_use_the_supported_sdl3_runtime", "[tiles][sdl3]" )
{
    const SDLVersionInfo compiled = GetCompiledSDLVersion();
    const SDLVersionInfo linked = GetLinkedSDLVersion();
    CHECK( compiled.major == 3 );
    CHECK( compiled.minor >= 4 );
    CHECK( linked.major == 3 );
    CHECK( linked.minor >= 4 );
}

TEST_CASE( "sdl3_reads_retired_graphics_options_and_saves_active_settings",
           "[tiles][sdl3][option]" )
{
    options_manager &options = get_options();
    REQUIRE( options.has_option( "FRAMEBUFFER_ACCEL" ) );
    REQUIRE( options.has_option( "USE_COLOR_MODULATED_TEXTURES" ) );
    const override_option framebuffer( "FRAMEBUFFER_ACCEL", "false" );
    const override_option color_modulated( "USE_COLOR_MODULATED_TEXTURES", "false" );
    const override_option scaling( "SCALING_MODE", "none" );

    const JsonArray legacy = json_loader::from_string( R"([
        {"name":"FRAMEBUFFER_ACCEL","value":"true"},
        {"name":"USE_COLOR_MODULATED_TEXTURES","value":"true"},
        {"name":"SCALING_MODE","value":"linear"}
    ])" );
    options.deserialize( legacy );
    CHECK( get_option<bool>( "FRAMEBUFFER_ACCEL" ) );
    CHECK( get_option<bool>( "USE_COLOR_MODULATED_TEXTURES" ) );
    CHECK( options.get_option( "FRAMEBUFFER_ACCEL" ).is_hidden() );
    CHECK( options.get_option( "USE_COLOR_MODULATED_TEXTURES" ).is_hidden() );

    std::ostringstream output;
    JsonOut json( output );
    options.serialize( json );
    const JsonArray saved = json_loader::from_string( output.str() );
    std::map<std::string, std::string> values;
    for( const JsonObject entry : saved ) {
        entry.allow_omitted_members();
        values.emplace( entry.get_string( "name" ), entry.get_string( "value" ) );
    }
    // Hidden retired IDs are accepted on load but omitted by the existing
    // page-based serializer. Active graphics settings still roundtrip.
    CHECK( values.count( "FRAMEBUFFER_ACCEL" ) == 0 );
    CHECK( values.count( "USE_COLOR_MODULATED_TEXTURES" ) == 0 );
    REQUIRE( values.count( "SCALING_MODE" ) == 1 );
    CHECK( values.at( "SCALING_MODE" ) == "linear" );
}

#endif // TILES
