#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_bindings_coords.h"
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
TEST_CASE( "lua_platform_choice_positions_reject_invalid_shapes_before_ui",
           "[lua][platform][runtime][presentation]" )
{
    cata::lua_platform::clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::string );
    sol::table ccb = lua.create_table();
    const auto runtime = cata::lua_platform::make_runtime( "choice_positions", 1902, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    cata::lua_platform::runtime_world_ready( true );
    lua["ccb"] = ccb;
    lua["relative"] = cata::lua_platform::script_tripoint_coord::from_native(
                          coords::origin::relative, coords::scale::map_square, tripoint::zero );
    lua["loaded"] = cata::lua_platform::script_tripoint_coord::from_native(
                        coords::origin::abs, coords::scale::map_square, get_avatar().pos_abs().raw() );
    cata::lua_platform::detail::callback_scope callback( *runtime );
    const auto result = lua.safe_script( R"(
        local function rejected(entries, message)
            local ok, err = pcall(ccb.presentation.choose, "test", entries)
            assert(not ok and string.find(tostring(err), message, 1, true))
        end
        rejected({{id="a",label="A",position={x=1,y=2,z=0}}}, "typed abs_ms")
        rejected({{id="a",label="A",position=relative}}, "abs_ms coordinates")
        rejected({{id="a",label="A",position=loaded},{id="b",label="B"}}, "every entry or none")
        rejected({{id="a",label="A"},{id="b",label="B",position=loaded}}, "every entry or none")
    )", sol::script_pass_on_error );
    if( !result.valid() ) {
        const sol::error error = result;
        INFO( error.what() );
    }
    REQUIRE( result.valid() );
}
#endif
