#include "catalua_ui_eocs.h"

#include <cstddef>
#include <functional>
#include <utility>

namespace cata::lua_ui
{

void install_eoc_api(
    sol::table &game,
    std::function<std::size_t()>,
    std::function<std::size_t()>,
    std::function<void()> require_read,
    std::function<void()>,
    std::function<bool()> )
{
    sol::state_view lua( game.lua_state() );
    sol::table eocs = lua.create_table();
    eocs.set_function( "limits", [require_read]( sol::this_state lua_state ) {
        require_read();
        sol::state_view state( lua_state );
        return state.create_table_with(
                   "page", 256,
                   "context_entries", 128,
                   "context_key_bytes", 128,
                   "context_string_bytes", 8192 );
    } );
    game["eocs"] = std::move( eocs );
}

} // namespace cata::lua_ui
