#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_BINDINGS_COORDS_H
#define CATA_SRC_LUA_PLATFORM_BINDINGS_COORDS_H

#include <point.h>
#include <cstdint>
#include <functional>
#include <string>
#include <string_view>
#include <tuple>
#include <vector>

#include "coords_fwd.h"
#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class script_point_coord
{
    public:
        // Lua accepts wide scalar axes; validate them before creating a native point.
        // NOLINTNEXTLINE(cata-xy)
        static script_point_coord from(
            std::string_view origin, std::string_view scale,
            std::int64_t x, std::int64_t y );
        static script_point_coord from_native(
            coords::origin origin, coords::scale scale, const point &value );

        int x() const noexcept;
        int y() const noexcept;
        std::string origin() const;
        std::string scale() const;
        std::string type_name() const;
        point to_native() const;
        script_point_coord add( const script_point_coord &rhs ) const;
        script_point_coord subtract( const script_point_coord &rhs ) const;
        script_point_coord scale_by( std::int64_t factor ) const;
        script_point_coord negate() const;
        script_point_coord project_to( std::string_view result_scale ) const;
        std::tuple<script_point_coord, script_point_coord> project_remain(
            std::string_view result_scale ) const;
        script_point_coord project_combine(
            const script_point_coord &remainder ) const;
        std::vector<script_point_coord> line_to(
            const script_point_coord &rhs, std::int64_t max_points ) const;
        std::int64_t manhattan_distance( const script_point_coord &rhs ) const;
        std::int64_t square_distance( const script_point_coord &rhs ) const;
        double euclidean_distance( const script_point_coord &rhs ) const;
        int compare( const script_point_coord &rhs ) const;
        std::string to_string() const;

        coords::origin native_origin() const noexcept;
        coords::scale native_scale() const noexcept;

        friend bool operator==( const script_point_coord &lhs,
                                const script_point_coord &rhs ) {
            return lhs.origin_ == rhs.origin_ && lhs.scale_ == rhs.scale_ &&
                   lhs.value_ == rhs.value_;
        }

    private:
        script_point_coord(
            coords::origin origin, coords::scale scale, const point &value );

        coords::origin origin_ = coords::origin::relative;
        coords::scale scale_ = coords::scale::map_square;
        point value_ = point::zero;
};

class script_tripoint_coord
{
    public:
        // Lua accepts wide scalar axes; validate them before creating a native tripoint.
        // NOLINTNEXTLINE(cata-xy)
        static script_tripoint_coord from(
            std::string_view origin, std::string_view scale,
            std::int64_t x, std::int64_t y, std::int64_t z );
        static script_tripoint_coord from_native(
            coords::origin origin, coords::scale scale, const tripoint &value );

        int x() const noexcept;
        int y() const noexcept;
        int z() const noexcept;
        std::string origin() const;
        std::string scale() const;
        std::string type_name() const;
        tripoint to_native() const;
        script_point_coord xy() const;
        script_tripoint_coord add( const script_tripoint_coord &rhs ) const;
        script_tripoint_coord add_xy( const script_point_coord &rhs ) const;
        script_tripoint_coord subtract( const script_tripoint_coord &rhs ) const;
        script_tripoint_coord subtract_xy( const script_point_coord &rhs ) const;
        script_tripoint_coord mirror_around( const script_tripoint_coord &center ) const;
        script_tripoint_coord scale_by( std::int64_t factor ) const;
        script_tripoint_coord negate() const;
        script_tripoint_coord project_to( std::string_view result_scale ) const;
        std::tuple<script_tripoint_coord, script_point_coord> project_remain(
            std::string_view result_scale ) const;
        script_tripoint_coord project_combine(
            const script_point_coord &remainder ) const;
        std::vector<script_tripoint_coord> line_to(
            const script_tripoint_coord &rhs, std::int64_t max_points ) const;
        std::int64_t manhattan_distance( const script_tripoint_coord &rhs ) const;
        std::int64_t square_distance( const script_tripoint_coord &rhs ) const;
        double euclidean_distance( const script_tripoint_coord &rhs ) const;
        int compare( const script_tripoint_coord &rhs ) const;
        std::string to_string() const;

        coords::origin native_origin() const noexcept;
        coords::scale native_scale() const noexcept;

        friend bool operator==( const script_tripoint_coord &lhs,
                                const script_tripoint_coord &rhs ) {
            return lhs.origin_ == rhs.origin_ && lhs.scale_ == rhs.scale_ &&
                   lhs.value_ == rhs.value_;
        }

    private:
        script_tripoint_coord(
            coords::origin origin, coords::scale scale, const tripoint &value );

        coords::origin origin_ = coords::origin::relative;
        coords::scale scale_ = coords::scale::map_square;
        tripoint value_ = tripoint::zero;
};

std::vector<std::string> supported_script_coordinate_kinds();
std::vector<script_point_coord> script_coordinate_rectangle(
    const script_point_coord &from, const script_point_coord &to,
    std::int64_t max_points );
std::vector<script_tripoint_coord> script_coordinate_box(
    const script_tripoint_coord &from, const script_tripoint_coord &to,
    std::int64_t max_points );

// Installs immutable, coordinate-space-aware Platform values under
// services.coords.
void install_coordinate_value_api(
    sol::state &lua, sol::table &services, const std::function<void()> &require_values );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_BINDINGS_COORDS_H
