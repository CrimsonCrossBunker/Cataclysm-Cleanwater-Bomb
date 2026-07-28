#pragma once
#ifndef CATA_SRC_CATALUA_BINDINGS_VALUES_H
#define CATA_SRC_CATALUA_BINDINGS_VALUES_H

#include <cstdint>
#include <functional>
#include <string>
#include <string_view>
#include <variant>
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

class script_unit_value
{
    public:
        static script_unit_value from(
            std::string_view kind, double value, std::string_view unit );

        const std::string &kind() const noexcept;
        const std::string &canonical_unit() const noexcept;
        bool is_integral() const noexcept;
        std::int64_t canonical_integer() const;
        double canonical_number() const;
        long double canonical_wide() const;
        double value_as( std::string_view unit ) const;
        script_unit_value add( const script_unit_value &rhs ) const;
        script_unit_value subtract( const script_unit_value &rhs ) const;
        script_unit_value scale( double factor ) const;
        int compare( const script_unit_value &rhs ) const;
        std::string to_string() const;

        friend bool operator==( const script_unit_value &lhs,
                                const script_unit_value &rhs ) {
            return lhs.kind_ == rhs.kind_ && lhs.canonical_ == rhs.canonical_;
        }

    private:
        script_unit_value(
            std::string kind, std::string canonical_unit,
            std::variant<std::int64_t, double> canonical );

        std::string kind_;
        std::string canonical_unit_;
        std::variant<std::int64_t, double> canonical_;
};

const std::vector<std::string> &supported_script_unit_kinds();
std::vector<std::string> supported_units_for_kind( std::string_view kind );

// Installs immutable v5 value factories under game.types.  The authorization
// callback must enforce both game.read and the source API version.
void install_value_type_api(
    sol::state &lua, sol::table &game, std::function<void()> require_values );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_BINDINGS_VALUES_H
