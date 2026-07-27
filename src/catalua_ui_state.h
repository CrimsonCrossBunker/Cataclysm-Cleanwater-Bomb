#pragma once
#ifndef CATA_SRC_CATALUA_UI_STATE_H
#define CATA_SRC_CATALUA_UI_STATE_H

#include <cstddef>
#include <cstdint>
#include <iosfwd>
#include <string>
#include <unordered_map>
#include <variant>

class JsonValue;

namespace cata::lua_ui
{

using script_persistent_value = std::variant<bool, std::int64_t, double, std::string>;
using script_persistent_state = std::unordered_map<std::string, script_persistent_value>;

constexpr std::size_t persistent_state_max_keys = 1024;
constexpr std::size_t persistent_state_max_key_bytes = 256;
constexpr std::size_t persistent_state_max_string_bytes = 64U * 1024U;
constexpr std::size_t persistent_state_max_value_bytes = 512U * 1024U;
constexpr std::size_t persistent_state_max_file_bytes = 1024U * 1024U;

// Assign one validated value without partially changing the state on failure.
// Throws std::invalid_argument when a key, value, or total state limit is
// exceeded.
void assign_persistent_value( script_persistent_state &state, const std::string &key,
                              const script_persistent_value &value );

// Versioned, typed JSON codec.  Integers and floating-point values deliberately
// retain distinct types across a save/load round trip.
void write_persistent_state( std::ostream &output, const script_persistent_state &state );
script_persistent_state read_persistent_state( const JsonValue &input );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_STATE_H
