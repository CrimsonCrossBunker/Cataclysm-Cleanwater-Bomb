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

// Copy a Lua value map across an API boundary. Scalars, NullValue, and dense
// arrays are copied into owned storage; live tables, arbitrary userdata,
// functions, and game pointers are never retained.
script_value_map read_script_value_map(
    const sol::optional<sol::table> &input, const script_value_map_limits &limits,
    const std::string &api_name );
script_persistent_value script_persistent_value_from_lua(
    const sol::object &value, const std::string &api_name,
    std::size_t string_bytes = persistent_state_max_string_bytes );
sol::object script_persistent_value_to_lua( sol::state_view lua,
        const script_persistent_value &value );
sol::table script_value_map_to_lua( sol::state_view lua,
                                    const script_value_map &values );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_VALUES_H
