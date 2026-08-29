#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_BINDINGS_VALUES_H
#define CATA_SRC_LUA_PLATFORM_BINDINGS_VALUES_H

#include <cstdint>
#include <functional>
#include <string>
#include <string_view>
#include <variant>
#include <vector>

#include "lua_platform_sol.h"

class time_duration;
class time_point;

namespace cata::lua_platform
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
        static script_unit_value from_integer(
            std::string_view kind, std::int64_t value,
            std::string_view unit );
        static script_unit_value from_canonical_integer(
            std::string_view kind, std::string_view unit, std::int64_t value );
        static script_unit_value from_canonical_number(
            std::string_view kind, std::string_view unit, double value );

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

class script_time_duration
{
    public:
        static script_time_duration from( std::int64_t value, std::string_view unit );
        static script_time_duration from_native( const ::time_duration &value );

        std::int64_t turns() const noexcept;
        double value_as( std::string_view unit ) const;
        script_time_duration add( const script_time_duration &rhs ) const;
        script_time_duration subtract( const script_time_duration &rhs ) const;
        script_time_duration scale( std::int64_t factor ) const;
        script_time_duration divide( std::int64_t divisor ) const;
        script_time_duration negate() const;
        int compare( const script_time_duration &rhs ) const noexcept;
        ::time_duration to_native() const;
        std::string display() const;
        std::string to_string() const;

        friend bool operator==( const script_time_duration &lhs,
                                const script_time_duration &rhs ) {
            return lhs.turns_ == rhs.turns_;
        }

    private:
        explicit script_time_duration( std::int64_t turns );
        std::int64_t turns_ = 0;
};

class script_time_point
{
    public:
        static script_time_point from_turn( std::int64_t turn );
        static script_time_point from_native( const ::time_point &value );

        std::int64_t turn() const noexcept;
        script_time_point add( const script_time_duration &duration ) const;
        script_time_point subtract( const script_time_duration &duration ) const;
        script_time_duration difference( const script_time_point &rhs ) const;
        int compare( const script_time_point &rhs ) const noexcept;
        ::time_point to_native() const;
        int second_of_minute() const;
        int minute_of_hour() const;
        int hour_of_day() const;
        bool is_day() const;
        bool is_night() const;
        bool is_dawn() const;
        bool is_dusk() const;
        script_time_point sunrise() const;
        script_time_point sunset() const;
        std::string moon_phase() const;
        std::string season() const;
        std::string display() const;
        std::string to_string() const;

        friend bool operator==( const script_time_point &lhs,
                                const script_time_point &rhs ) {
            return lhs.turn_ == rhs.turn_;
        }

    private:
        explicit script_time_point( std::int64_t turn );
        std::int64_t turn_ = 0;
};

// Installs immutable Platform value factories under services.types. The
// authorization callback enforces the runtime's read boundary.
void install_value_type_api(
    sol::state &lua, sol::table &services, std::function<void()> require_values );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_BINDINGS_VALUES_H
