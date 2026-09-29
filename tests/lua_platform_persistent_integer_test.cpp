#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <limits>
#include <string>
#include <variant>

#include "cata_catch.h"
#include "json_loader.h"
#include "lua_platform_state.h"

TEST_CASE( "lua_platform_persistent_coordinates_preserve_integer_bounds",
           "[lua][platform][semantic][state]" )
{
    const cata::lua_platform::script_persistent_value value =
        cata::lua_platform::detail::read_persistent_value( json_loader::from_string(
                R"({"type":"tripoint_abs_ms","value":[2147483647,-2147483648,0]})" ).get_object() );
    const cata::lua_platform::script_persistent_tripoint &coordinate =
        std::get<cata::lua_platform::script_persistent_tripoint>( value );
    CHECK( coordinate.x == std::numeric_limits<int>::max() );
    CHECK( coordinate.y == std::numeric_limits<int>::min() );
    CHECK( coordinate.z == 0 );
}

TEST_CASE( "lua_platform_persistent_coordinates_reject_integer_overflow",
           "[lua][platform][semantic][state]" )
{
    const std::string component = GENERATE( "2147483648", "-2147483649" );
    const std::string input = R"({"type":"tripoint_abs_ms","value":[)" + component + ",0,0]}";
    CHECK_THROWS( cata::lua_platform::detail::read_persistent_value(
                      json_loader::from_string( input ).get_object() ) );
}

#endif
