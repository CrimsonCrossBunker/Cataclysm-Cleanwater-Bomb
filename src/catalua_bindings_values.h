#pragma once
#ifndef CATA_SRC_CATALUA_BINDINGS_VALUES_H
#define CATA_SRC_CATALUA_BINDINGS_VALUES_H

#include <functional>
#include <string>
#include <string_view>
#include <vector>

#include "catalua_sol.h"

namespace cata::lua_ui
{

class script_game_id
{
    public:
        script_game_id() = default;
        script_game_id( std::string kind, std::string value );

        const std::string &kind() const noexcept;
        const std::string &value() const noexcept;
        bool is_null() const noexcept;
        bool is_valid() const;
        std::string to_string() const;

        friend bool operator==( const script_game_id &lhs, const script_game_id &rhs ) {
            return lhs.kind_ == rhs.kind_ && lhs.value_ == rhs.value_;
        }

    private:
        std::string kind_;
        std::string value_;
};

const std::vector<std::string> &supported_game_id_kinds();
bool is_supported_game_id_kind( std::string_view kind );

// Installs immutable v5 value factories under game.types.  The authorization
// callback must enforce both game.read and the source API version.
void install_value_type_api(
    sol::state &lua, sol::table &game, std::function<void()> require_values );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_BINDINGS_VALUES_H
