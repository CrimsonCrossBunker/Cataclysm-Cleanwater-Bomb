#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_VALUES_H
#define CATA_SRC_LUA_PLATFORM_VALUES_H

#include <cstddef>
#include <string>

#include "lua_platform_sol.h"
#include "lua_platform_state.h"

namespace cata::lua_platform
{

struct script_value_map_limits {
    std::size_t entries = 32;
    std::size_t key_bytes = 64;
    std::size_t string_bytes = 4096;
    std::size_t storage_bytes = 16U * 1024U;
};

// Copy a Lua table across an API boundary.  Only scalar values are accepted,
// so no live table, userdata, function, or game pointer can cross sources.
script_value_map read_script_value_map(
    const sol::optional<sol::table> &input, const script_value_map_limits &limits,
    const std::string &api_name );
sol::table script_value_map_to_lua( sol::state_view lua,
                                    const script_value_map &values );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_VALUES_H
