#include "cata_catch.h"

#include <optional>
#include <string>
#include <vector>

#include "catalua_ui.h"
#include "catalua_ui_actions.h"

#if !defined(CATA_ENABLE_LUA_UI) || !CATA_ENABLE_LUA_UI

TEST_CASE( "disabled_lua_ui_build_has_an_inert_facade", "[lua][ui][build]" )
{
    CHECK_FALSE( cata::lua_ui::is_enabled() );

    std::string error;
    CHECK_FALSE( cata::lua_ui::reload_scripts( error ) );
    CHECK_FALSE( error.empty() );

    const cata::lua_ui::runtime_status status = cata::lua_ui::status();
    CHECK_FALSE( status.loaded );
    CHECK_FALSE( status.last_error.empty() );

    error.clear();
    CHECK_FALSE( cata::lua_ui::validate_snippet( "return true", 100, error ) );
    CHECK_FALSE( error.empty() );

    error = "stale";
    CHECK( cata::lua_ui::save_persistent_state( error ) );
    CHECK( error.empty() );
    CHECK_FALSE( cata::lua_ui::process_next_action().has_value() );
    CHECK( cata::lua_ui::registered_pages().empty() );
    CHECK_FALSE( cata::lua_ui::has_registered_pages() );
    CHECK_FALSE( cata::lua_ui::show_page( "missing" ) );
    CHECK_FALSE( cata::lua_ui::process_pending_navigation() );

    cata::lua_ui::on_world_ready();
    cata::lua_ui::clear_actions();
    cata::lua_ui::show_slot( "main.extensions" );
    cata::lua_ui::shutdown();
    cata::lua_ui::show();
}

#endif
