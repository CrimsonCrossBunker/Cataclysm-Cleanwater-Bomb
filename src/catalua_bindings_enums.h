#pragma once
#ifndef CATA_SRC_CATALUA_BINDINGS_ENUMS_H
#define CATA_SRC_CATALUA_BINDINGS_ENUMS_H

#include <cstddef>
#include <functional>
#include <string>
#include <string_view>
#include <vector>

#include "catalua_sol.h"

namespace cata::lua_ui
{

class script_enum_value
{
    public:
        static script_enum_value from(
            std::string_view kind, std::string_view name );

        const std::string &kind() const noexcept;
        const std::string &name() const noexcept;
        std::size_t ordinal() const noexcept;
        std::string to_string() const;

        friend bool operator==( const script_enum_value &lhs,
                                const script_enum_value &rhs ) {
            return lhs.kind_ == rhs.kind_ && lhs.name_ == rhs.name_;
        }

    private:
        script_enum_value(
            std::string kind, std::string name, std::size_t ordinal );

        std::string kind_;
        std::string name_;
        std::size_t ordinal_ = 0;
};

std::vector<std::string> supported_script_enum_kinds();
std::vector<std::string> script_enum_names( std::string_view kind );
bool script_enum_kind_is_available( std::string_view kind );

// Installs immutable v5 enum values under game.enums.  Legacy CBN enums that
// became JSON-defined IDs in CCB are represented by dynamic typed names;
// removed engine concepts remain discoverable with an explicit status.
void install_enum_value_api(
    sol::state &lua, sol::table &game, std::function<void()> require_values );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_BINDINGS_ENUMS_H
