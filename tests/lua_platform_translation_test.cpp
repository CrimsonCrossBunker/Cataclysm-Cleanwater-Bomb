#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include <string_view>

TEST_CASE( "lua_platform_translation_fallback_and_lifetime",
           "[lua][platform][runtime][translations]" )
{
    cata::lua_platform::clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_translation_test", 1901, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    lua["ccb"] = ccb;

    const auto run = [&lua]( std::string_view source ) {
        const sol::protected_function_result result = lua.safe_script(
                    source, sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
            REQUIRE( result.valid() );
        }
    };
    run( R"(
        assert(not pcall(ccb.services.format, "%s", {"before world ready"}))
        assert(not pcall(ccb.services.translate, "before world ready"))
        assert(not pcall(ccb.services.translate_plural, "one", "many", 1))
    )" );
    cata::lua_platform::runtime_world_ready( true );
    // Unique source strings deliberately have no entries in installed catalogs.
    run( R"(
        local one = "ccb translation regression singular 1901"
        local many = "ccb translation regression plural 1901"
        assert(ccb.services.translate(one) == one)
        assert(ccb.services.translate(one, "ccb regression context") == one)
        assert(ccb.services.translate_plural(one, many, 1) == one)
        assert(ccb.services.translate_plural(one, many, 0) == many)
        assert(ccb.services.translate_plural(one, many, 2, "ccb regression context") == many)
        assert(not pcall(ccb.services.translate_plural, one, many, -1))
        assert(not pcall(ccb.services.translate, "a\0b"))
        assert(not pcall(ccb.services.translate, one, "a\0b"))
        assert(not pcall(ccb.services.translate_plural, one, "a\0b", 2))
        assert(not pcall(ccb.services.translate_plural, one, many, 2, "a\0b"))
    )" );
    run( R"(
        local format = ccb.services.format
        assert(format("%2$s -> %1$s", {"NPC", "book"}) == "book -> NPC")
        assert(format("[%2$6s] %1$04d %%", {7, "x"}) == "[     x] 0007 %")
        assert(format("%d %.2f", {3, 1.25}) == "3 1.25")
        assert(format("%d", {true}) == "1")
        assert(format("100%%", {}) == "100%")
        assert(not pcall(format, "%s", {}))
        assert(not pcall(format, "%d", {"not a number"}))
        assert(not pcall(format, "%s", {{}}))
        assert(not pcall(format, "%s", {[2] = "hole"}))
        assert(not pcall(format, "%s", {[1] = "value", extra = "field"}))
        assert(not pcall(format, "a\0b", {}))
        assert(not pcall(format, "%s", {"a\0b"}))
    )" );
    lua["native_count_accepts_2_to_32"] = sizeof( std::size_t ) > 4;
    run( R"(
        local success = pcall(ccb.services.translate_plural,
            "ccb translation regression singular 1901", "ccb translation regression plural 1901",
            4294967296)
        assert(success == native_count_accepts_2_to_32)
    )" );
    cata::lua_platform::clear_active_runtimes();
    run( R"(
        assert(not pcall(ccb.services.format, "%s", {"after world unload"}))
        assert(not pcall(ccb.services.translate, "after world unload"))
        assert(not pcall(ccb.services.translate_plural, "one", "many", 2))
    )" );
}
#endif
