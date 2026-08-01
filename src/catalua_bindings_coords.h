#pragma once
#ifndef CATA_SRC_CATALUA_BINDINGS_COORDS_H
#define CATA_SRC_CATALUA_BINDINGS_COORDS_H

#include <cstdint>
#include <functional>
#include <string>
#include <string_view>
#include <tuple>
#include <vector>

#include "catalua_sol.h"
#include "coords_fwd.h"

namespace cata::lua_ui
{

class script_point_coord
{
    public:
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
                   lhs.x_ == rhs.x_ && lhs.y_ == rhs.y_;
        }

    private:
        script_point_coord(
            coords::origin origin, coords::scale scale, int x, int y );

        coords::origin origin_ = coords::origin::relative;
        coords::scale scale_ = coords::scale::map_square;
        int x_ = 0;
        int y_ = 0;
};

class script_tripoint_coord
{
    public:
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
                   lhs.x_ == rhs.x_ && lhs.y_ == rhs.y_ && lhs.z_ == rhs.z_;
        }

    private:
        script_tripoint_coord(
            coords::origin origin, coords::scale scale, int x, int y, int z );

        coords::origin origin_ = coords::origin::relative;
        coords::scale scale_ = coords::scale::map_square;
        int x_ = 0;
        int y_ = 0;
        int z_ = 0;
};

std::vector<std::string> supported_script_coordinate_kinds();
std::vector<script_point_coord> script_coordinate_rectangle(
    const script_point_coord &from, const script_point_coord &to,
    std::int64_t max_points );
std::vector<script_tripoint_coord> script_coordinate_box(
    const script_tripoint_coord &from, const script_tripoint_coord &to,
    std::int64_t max_points );

// Installs immutable, coordinate-space-aware v5 values under game.coords.
void install_coordinate_value_api(
    sol::state &lua, sol::table &game, std::function<void()> require_values );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_BINDINGS_COORDS_H
