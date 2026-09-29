#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <filesystem>
#include <istream>
#include <limits>
#include <memory>
#include <string>
#include <variant>

#include "cata_catch.h"
#include "flexbuffer_cache.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_state.h"

namespace
{
class source_less_flexbuffer : public parsed_flexbuffer
{
    public:
        explicit source_less_flexbuffer( const std::shared_ptr<flexbuffer_storage> &storage ) :
            parsed_flexbuffer( storage ) {}

        bool is_stale() const override {
            return false;
        }
        std::unique_ptr<std::istream> get_source_stream() const override {
            return nullptr;
        }
        std::filesystem::path get_source_path() const noexcept override {
            return {};
        }
};

JsonValue parse_without_source( const std::string &input )
{
    const std::shared_ptr<parsed_flexbuffer> parsed = flexbuffer_cache::parse_buffer( input );
    const std::shared_ptr<parsed_flexbuffer> source_less =
        std::make_shared<source_less_flexbuffer>( parsed->get_storage() );
    return JsonValue( source_less, flexbuffer_root_from_storage( source_less->get_storage() ),
                      nullptr, 0 );
}
} // namespace

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
    const std::string component = GENERATE( "2147483648", "-2147483649",
                                            "18446744073709551615" );
    const std::string input = R"({"type":"tripoint_abs_ms","value":[)" + component + ",0,0]}";
    CHECK_THROWS( cata::lua_platform::detail::read_persistent_value(
                      json_loader::from_string( input ).get_object() ) );
}

TEST_CASE( "lua_platform_persistent_coordinates_read_source_less_flexbuffers",
           "[lua][platform][semantic][state]" )
{
    const JsonValue root = parse_without_source(
                               R"({"type":"tripoint_abs_ms","value":[2147483647,-2147483648,0]})" );
    const cata::lua_platform::script_persistent_value value =
        cata::lua_platform::detail::read_persistent_value( root.get_object() );
    const cata::lua_platform::script_persistent_tripoint &coordinate =
        std::get<cata::lua_platform::script_persistent_tripoint>( value );
    CHECK( coordinate.x == std::numeric_limits<int>::max() );
    CHECK( coordinate.y == std::numeric_limits<int>::min() );
    CHECK( coordinate.z == 0 );
}

TEST_CASE( "lua_platform_persistent_coordinates_reject_source_less_overflow",
           "[lua][platform][semantic][state]" )
{
    const std::string component = GENERATE( "2147483648", "-2147483649" );
    const JsonValue root = parse_without_source(
                               R"({"type":"tripoint_abs_ms","value":[)" + component + ",0,0]}" );
    CHECK_THROWS( cata::lua_platform::detail::read_persistent_value( root.get_object() ) );
}

#endif
