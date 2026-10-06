#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_VALUES_H
#define CATA_SRC_LUA_PLATFORM_VALUES_H

#include <cstddef>
#include <string>

#include "lua_platform_sol.h"
#include "lua_platform_state.h"

struct diag_value;

namespace cata::lua_platform
{

enum class script_diag_value_read_policy {
    bounded,
    native_range
};

// Bounded dialogue/computer values share 512-node, 8-level and 8192-byte string
// bounds. A caller may impose a smaller per-array limit (computers use 256).
// native_range preserves native scalar/string/tree values and rejects cyclic
// Lua arrays; callers still specify their per-array limit explicitly.
// Empty array slots use NullValue; a top-level empty value reads as nil.
// Nil deletion and key/store limits remain the caller's responsibility.
diag_value script_diag_value_from_lua(
    const sol::object &value, const std::string &description,
    std::size_t maximum_array_entries = 512,
    script_diag_value_read_policy policy = script_diag_value_read_policy::bounded );
sol::object script_diag_value_to_lua(
    sol::state_view lua, const diag_value &value, const std::string &description,
    std::size_t maximum_array_entries = 512 );

// Bind optional tables as objects when later arguments must keep their slots:
// the bundled sol optional<table> does not consume an explicit nil argument.
sol::optional<sol::table> read_optional_table(
    const sol::object &value, const std::string &description );

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
