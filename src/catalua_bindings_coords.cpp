#if CATA_ENABLE_LUA_PLATFORM

#include "catalua_bindings_coords.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <limits>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>
#include <vector>

#include "coordinates.h"
#include "line.h"
#include "point.h"

namespace cata::lua
{

namespace
{

struct coordinate_kind_definition {
    std::string_view name;
    coords::origin origin;
    coords::scale scale;
};

constexpr std::array<coordinate_kind_definition, 18> coordinate_kinds = {{
        { "rel_ms", coords::origin::relative, coords::scale::map_square },
        { "rel_sm", coords::origin::relative, coords::scale::submap },
        { "rel_omt", coords::origin::relative, coords::scale::overmap_terrain },
        { "rel_seg", coords::origin::relative, coords::scale::segment },
        { "rel_om", coords::origin::relative, coords::scale::overmap },
        { "abs_ms", coords::origin::abs, coords::scale::map_square },
        { "abs_sm", coords::origin::abs, coords::scale::submap },
        { "abs_omt", coords::origin::abs, coords::scale::overmap_terrain },
        { "abs_seg", coords::origin::abs, coords::scale::segment },
        { "abs_om", coords::origin::abs, coords::scale::overmap },
        { "sm_ms", coords::origin::submap, coords::scale::map_square },
        { "omt_ms", coords::origin::overmap_terrain, coords::scale::map_square },
        { "omt_sm", coords::origin::overmap_terrain, coords::scale::submap },
        { "om_ms", coords::origin::overmap, coords::scale::map_square },
        { "om_sm", coords::origin::overmap, coords::scale::submap },
        { "om_omt", coords::origin::overmap, coords::scale::overmap_terrain },
        { "bub_ms", coords::origin::reality_bubble, coords::scale::map_square },
        { "bub_sm", coords::origin::reality_bubble, coords::scale::submap }
    }
};

constexpr std::int64_t maximum_coordinate_range_points = 4096;

coords::origin parse_origin( const std::string_view name )
{
    if( name == "rel" || name == "relative" ) {
        return coords::origin::relative;
    }
    if( name == "abs" || name == "absolute" ) {
        return coords::origin::abs;
    }
    if( name == "sm" || name == "submap" ) {
        return coords::origin::submap;
    }
    if( name == "omt" || name == "overmap_terrain" ) {
        return coords::origin::overmap_terrain;
    }
    if( name == "om" || name == "overmap" ) {
        return coords::origin::overmap;
    }
    if( name == "bub" || name == "bubble" || name == "reality_bubble" ) {
        return coords::origin::reality_bubble;
    }
    throw std::invalid_argument(
        "services.coords received an unknown coordinate origin: " + std::string( name ) );
}

coords::scale parse_scale( const std::string_view name )
{
    if( name == "ms" || name == "map_square" ) {
        return coords::scale::map_square;
    }
    if( name == "sm" || name == "submap" ) {
        return coords::scale::submap;
    }
    if( name == "omt" || name == "overmap_terrain" ) {
        return coords::scale::overmap_terrain;
    }
    if( name == "seg" || name == "segment" ) {
        return coords::scale::segment;
    }
    if( name == "om" || name == "overmap" ) {
        return coords::scale::overmap;
    }
    throw std::invalid_argument(
        "services.coords received an unknown coordinate scale: " + std::string( name ) );
}

std::string_view origin_name( const coords::origin origin )
{
    switch( origin ) {
        case coords::origin::relative:
            return "rel";
        case coords::origin::abs:
            return "abs";
        case coords::origin::submap:
            return "sm";
        case coords::origin::overmap_terrain:
            return "omt";
        case coords::origin::overmap:
            return "om";
        case coords::origin::reality_bubble:
            return "bub";
    }
    throw std::logic_error( "services.coords value has an unknown origin" );
}

std::string_view scale_name( const coords::scale scale )
{
    switch( scale ) {
        case coords::scale::map_square:
            return "ms";
        case coords::scale::submap:
            return "sm";
        case coords::scale::overmap_terrain:
            return "omt";
        case coords::scale::segment:
            return "seg";
        case coords::scale::overmap:
            return "om";
        case coords::scale::vehicle:
            break;
    }
    throw std::logic_error( "services.coords value has an unknown scale" );
}

bool is_supported_kind( const coords::origin origin, const coords::scale scale )
{
    return std::any_of(
               coordinate_kinds.begin(), coordinate_kinds.end(),
    [origin, scale]( const coordinate_kind_definition & definition ) {
        return definition.origin == origin && definition.scale == scale;
    } );
}

void require_supported_kind( const coords::origin origin, const coords::scale scale )
{
    if( !is_supported_kind( origin, scale ) ) {
        throw std::invalid_argument(
            "services.coords does not support coordinate kind " +
            std::string( origin_name( origin ) ) + "_" +
            std::string( scale_name( scale ) ) );
    }
}

int checked_axis( const std::int64_t value )
{
    if( value < std::numeric_limits<int>::min() ||
        value > std::numeric_limits<int>::max() ) {
        throw std::overflow_error( "services.coords axis exceeds the engine coordinate range" );
    }
    return static_cast<int>( value );
}

int checked_axis_sum( const int lhs, const int rhs )
{
    return checked_axis( static_cast<std::int64_t>( lhs ) + rhs );
}

int checked_axis_difference( const int lhs, const int rhs )
{
    return checked_axis( static_cast<std::int64_t>( lhs ) - rhs );
}

int checked_axis_product( const int value, const std::int64_t factor )
{
    const long double product =
        static_cast<long double>( value ) * static_cast<long double>( factor );
    if( product < static_cast<long double>( std::numeric_limits<int>::min() ) ||
        product > static_cast<long double>( std::numeric_limits<int>::max() ) ) {
        throw std::overflow_error( "services.coords arithmetic exceeds the engine coordinate range" );
    }
    return static_cast<int>( product );
}

std::int64_t axis_distance( const int lhs, const int rhs )
{
    return std::llabs( static_cast<std::int64_t>( lhs ) - rhs );
}

void require_matching_kind(
    const coords::origin lhs_origin, const coords::scale lhs_scale,
    const coords::origin rhs_origin, const coords::scale rhs_scale,
    const std::string_view operation )
{
    if( lhs_origin != rhs_origin || lhs_scale != rhs_scale ) {
        throw std::invalid_argument(
            "services.coords cannot " + std::string( operation ) +
            " coordinates with different origins or scales" );
    }
}

coords::origin addition_result_origin(
    const coords::origin lhs, const coords::origin rhs )
{
    if( rhs == coords::origin::relative ) {
        return lhs;
    }
    if( lhs == coords::origin::relative ) {
        return rhs;
    }
    throw std::invalid_argument(
        "services.coords addition requires at least one relative coordinate" );
}

coords::origin subtraction_result_origin(
    const coords::origin lhs, const coords::origin rhs )
{
    if( rhs == coords::origin::relative ) {
        return lhs;
    }
    if( lhs == rhs && lhs != coords::origin::relative ) {
        return coords::origin::relative;
    }
    throw std::invalid_argument(
        "services.coords subtraction requires a relative offset or matching coordinate kinds" );
}

void require_same_scale( const coords::scale lhs, const coords::scale rhs )
{
    if( lhs != rhs ) {
        throw std::invalid_argument(
            "services.coords arithmetic requires coordinates at the same scale" );
    }
}

void require_relative( const coords::origin origin, const std::string_view operation )
{
    if( origin != coords::origin::relative ) {
        throw std::invalid_argument(
            "services.coords " + std::string( operation ) +
            " is only valid for relative coordinates" );
    }
}

int scale_size( const coords::scale scale )
{
    return coords::map_squares_per( scale );
}

std::int64_t exact_projection_factor(
    const coords::scale source, const coords::scale result )
{
    const std::int64_t source_size = scale_size( source );
    const std::int64_t result_size = scale_size( result );
    const std::int64_t larger = std::max( source_size, result_size );
    const std::int64_t smaller = std::min( source_size, result_size );
    if( larger % smaller != 0 ) {
        throw std::invalid_argument(
            "services.coords projection requires exactly divisible coordinate scales" );
    }
    return larger / smaller;
}

int floor_divide_axis( const int value, const std::int64_t divisor )
{
    std::int64_t quotient = static_cast<std::int64_t>( value ) / divisor;
    const std::int64_t remainder =
        static_cast<std::int64_t>( value ) % divisor;
    if( remainder < 0 ) {
        --quotient;
    }
    return checked_axis( quotient );
}

int projected_axis(
    const int value, const coords::scale source, const coords::scale result )
{
    if( source == result ) {
        return value;
    }
    const std::int64_t factor = exact_projection_factor( source, result );
    if( scale_size( source ) > scale_size( result ) ) {
        return checked_axis_product( value, factor );
    }
    return floor_divide_axis( value, factor );
}

coords::origin remainder_origin( const coords::scale coarse_scale )
{
    switch( coarse_scale ) {
        case coords::scale::submap:
            return coords::origin::submap;
        case coords::scale::overmap_terrain:
            return coords::origin::overmap_terrain;
        case coords::scale::overmap:
            return coords::origin::overmap;
        case coords::scale::map_square:
        case coords::scale::segment:
        case coords::scale::vehicle:
            break;
    }
    throw std::invalid_argument(
        "services.coords cannot produce a remainder for the requested scale" );
}

std::int64_t projection_down_factor(
    const coords::scale source, const coords::scale coarse )
{
    const std::int64_t source_size = scale_size( source );
    const std::int64_t coarse_size = scale_size( coarse );
    if( coarse_size <= source_size || coarse_size % source_size != 0 ) {
        throw std::invalid_argument(
            "services.coords project_remain requires an exactly divisible coarser scale" );
    }
    remainder_origin( coarse );
    return coarse_size / source_size;
}

void require_valid_remainder_axis(
    const int value, const std::int64_t factor )
{
    if( value < 0 || static_cast<std::int64_t>( value ) >= factor ) {
        throw std::invalid_argument(
            "services.coords project_combine requires a bounded non-negative remainder" );
    }
}

std::size_t checked_output_limit( const std::int64_t max_points )
{
    if( max_points <= 0 || max_points > maximum_coordinate_range_points ) {
        throw std::invalid_argument(
            "services.coords max_points must be between 1 and " +
            std::to_string( maximum_coordinate_range_points ) );
    }
    return static_cast<std::size_t>( max_points );
}

void require_output_count(
    const std::uint64_t count, const std::size_t limit )
{
    if( count > limit ) {
        throw std::length_error(
            "services.coords result exceeds the requested max_points limit" );
    }
}

std::uint64_t inclusive_axis_count( const int from, const int to )
{
    return static_cast<std::uint64_t>(
               axis_distance( from, to ) ) + 1U;
}

std::size_t checked_rectangle_count(
    const int from_x, const int to_x, const int from_y, const int to_y,
    const std::size_t limit )
{
    const std::uint64_t width = inclusive_axis_count( from_x, to_x );
    const std::uint64_t height = inclusive_axis_count( from_y, to_y );
    require_output_count( width, limit );
    require_output_count( height, limit );
    if( width > limit / height ) {
        throw std::length_error(
            "services.coords result exceeds the requested max_points limit" );
    }
    return static_cast<std::size_t>( width * height );
}

std::size_t checked_box_count(
    const int from_x, const int to_x, const int from_y, const int to_y,
    const int from_z, const int to_z, const std::size_t limit )
{
    const std::uint64_t depth = inclusive_axis_count( from_z, to_z );
    require_output_count( depth, limit );
    const std::size_t area =
        checked_rectangle_count( from_x, to_x, from_y, to_y, limit );
    if( area > limit / depth ) {
        throw std::length_error(
            "services.coords result exceeds the requested max_points limit" );
    }
    return static_cast<std::size_t>( area * depth );
}

template<typename Coordinate>
sol::table coordinate_vector_table(
    sol::this_state lua_state, const std::vector<Coordinate> &values )
{
    sol::state_view state( lua_state );
    sol::table result = state.create_table(
                            static_cast<int>( values.size() ), 0 );
    for( std::size_t index = 0; index < values.size(); ++index ) {
        result[index + 1] = values[index];
    }
    return result;
}

} // namespace

script_point_coord::script_point_coord(
    const coords::origin origin, const coords::scale scale,
    const int x, const int y )
    : origin_( origin ), scale_( scale ), x_( x ), y_( y )
{
    require_supported_kind( origin_, scale_ );
}

script_point_coord script_point_coord::from(
    const std::string_view origin, const std::string_view scale,
    const std::int64_t x, const std::int64_t y )
{
    return script_point_coord(
               parse_origin( origin ), parse_scale( scale ),
               checked_axis( x ), checked_axis( y ) );
}

script_point_coord script_point_coord::from_native(
    const coords::origin origin, const coords::scale scale, const point &value )
{
    return script_point_coord( origin, scale, value.x, value.y );
}

int script_point_coord::x() const noexcept
{
    return x_;
}

int script_point_coord::y() const noexcept
{
    return y_;
}

std::string script_point_coord::origin() const
{
    return std::string( origin_name( origin_ ) );
}

std::string script_point_coord::scale() const
{
    return std::string( scale_name( scale_ ) );
}

std::string script_point_coord::type_name() const
{
    return "Point_" + origin() + "_" + scale();
}

point script_point_coord::to_native() const
{
    return point( x_, y_ );
}

script_point_coord script_point_coord::add( const script_point_coord &rhs ) const
{
    require_same_scale( scale_, rhs.scale_ );
    return script_point_coord(
               addition_result_origin( origin_, rhs.origin_ ), scale_,
               checked_axis_sum( x_, rhs.x_ ), checked_axis_sum( y_, rhs.y_ ) );
}

script_point_coord script_point_coord::subtract( const script_point_coord &rhs ) const
{
    require_same_scale( scale_, rhs.scale_ );
    return script_point_coord(
               subtraction_result_origin( origin_, rhs.origin_ ), scale_,
               checked_axis_difference( x_, rhs.x_ ),
               checked_axis_difference( y_, rhs.y_ ) );
}

script_point_coord script_point_coord::scale_by( const std::int64_t factor ) const
{
    require_relative( origin_, "scaling" );
    return script_point_coord(
               origin_, scale_,
               checked_axis_product( x_, factor ),
               checked_axis_product( y_, factor ) );
}

script_point_coord script_point_coord::negate() const
{
    return scale_by( -1 );
}

script_point_coord script_point_coord::project_to(
    const std::string_view result_scale ) const
{
    const coords::scale target = parse_scale( result_scale );
    require_supported_kind( origin_, target );
    exact_projection_factor( scale_, target );
    return script_point_coord(
               origin_, target,
               projected_axis( x_, scale_, target ),
               projected_axis( y_, scale_, target ) );
}

std::tuple<script_point_coord, script_point_coord>
script_point_coord::project_remain(
    const std::string_view result_scale ) const
{
    const coords::scale coarse_scale = parse_scale( result_scale );
    const std::int64_t factor =
        projection_down_factor( scale_, coarse_scale );
    const coords::origin fine_origin = remainder_origin( coarse_scale );
    require_supported_kind( origin_, coarse_scale );
    require_supported_kind( fine_origin, scale_ );

    const int coarse_x = floor_divide_axis( x_, factor );
    const int coarse_y = floor_divide_axis( y_, factor );
    const int remainder_x = checked_axis(
                                static_cast<std::int64_t>( x_ ) -
                                static_cast<std::int64_t>( coarse_x ) * factor );
    const int remainder_y = checked_axis(
                                static_cast<std::int64_t>( y_ ) -
                                static_cast<std::int64_t>( coarse_y ) * factor );
    return {
        script_point_coord( origin_, coarse_scale, coarse_x, coarse_y ),
        script_point_coord(
            fine_origin, scale_, remainder_x, remainder_y )
    };
}

script_point_coord script_point_coord::project_combine(
    const script_point_coord &remainder ) const
{
    const std::int64_t factor =
        projection_down_factor( remainder.scale_, scale_ );
    if( remainder.origin_ != remainder_origin( scale_ ) ) {
        throw std::invalid_argument(
            "services.coords project_combine received the wrong remainder origin" );
    }
    require_supported_kind( origin_, remainder.scale_ );
    require_valid_remainder_axis( remainder.x_, factor );
    require_valid_remainder_axis( remainder.y_, factor );
    return script_point_coord(
               origin_, remainder.scale_,
               checked_axis(
                   static_cast<std::int64_t>( x_ ) * factor + remainder.x_ ),
               checked_axis(
                   static_cast<std::int64_t>( y_ ) * factor + remainder.y_ ) );
}

std::vector<script_point_coord> script_point_coord::line_to(
    const script_point_coord &rhs, const std::int64_t max_points ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "trace a line between" );
    const std::size_t limit = checked_output_limit( max_points );
    const std::uint64_t count =
        static_cast<std::uint64_t>( square_distance( rhs ) ) + 1U;
    require_output_count( count, limit );

    std::vector<script_point_coord> result;
    result.reserve( static_cast<std::size_t>( count ) );
    result.push_back( *this );
    if( !( *this == rhs ) ) {
        const std::vector<point> native_line =
            ::line_to( to_native(), rhs.to_native() );
        for( const point &value : native_line ) {
            result.push_back( from_native( origin_, scale_, value ) );
        }
    }
    return result;
}

std::int64_t script_point_coord::manhattan_distance(
    const script_point_coord &rhs ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "measure" );
    return axis_distance( x_, rhs.x_ ) + axis_distance( y_, rhs.y_ );
}

std::int64_t script_point_coord::square_distance(
    const script_point_coord &rhs ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "measure" );
    return std::max( axis_distance( x_, rhs.x_ ), axis_distance( y_, rhs.y_ ) );
}

double script_point_coord::euclidean_distance(
    const script_point_coord &rhs ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "measure" );
    return std::hypot(
               static_cast<double>( axis_distance( x_, rhs.x_ ) ),
               static_cast<double>( axis_distance( y_, rhs.y_ ) ) );
}

int script_point_coord::compare( const script_point_coord &rhs ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "compare" );
    if( x_ == rhs.x_ && y_ == rhs.y_ ) {
        return 0;
    }
    return std::tie( x_, y_ ) < std::tie( rhs.x_, rhs.y_ ) ? -1 : 1;
}

std::string script_point_coord::to_string() const
{
    return type_name() + "(" + std::to_string( x_ ) + "," +
           std::to_string( y_ ) + ")";
}

coords::origin script_point_coord::native_origin() const noexcept
{
    return origin_;
}

coords::scale script_point_coord::native_scale() const noexcept
{
    return scale_;
}

script_tripoint_coord::script_tripoint_coord(
    const coords::origin origin, const coords::scale scale,
    const int x, const int y, const int z )
    : origin_( origin ), scale_( scale ), x_( x ), y_( y ), z_( z )
{
    require_supported_kind( origin_, scale_ );
}

script_tripoint_coord script_tripoint_coord::from(
    const std::string_view origin, const std::string_view scale,
    const std::int64_t x, const std::int64_t y, const std::int64_t z )
{
    return script_tripoint_coord(
               parse_origin( origin ), parse_scale( scale ),
               checked_axis( x ), checked_axis( y ), checked_axis( z ) );
}

script_tripoint_coord script_tripoint_coord::from_native(
    const coords::origin origin, const coords::scale scale,
    const tripoint &value )
{
    return script_tripoint_coord(
               origin, scale, value.x, value.y, value.z );
}

int script_tripoint_coord::x() const noexcept
{
    return x_;
}

int script_tripoint_coord::y() const noexcept
{
    return y_;
}

int script_tripoint_coord::z() const noexcept
{
    return z_;
}

std::string script_tripoint_coord::origin() const
{
    return std::string( origin_name( origin_ ) );
}

std::string script_tripoint_coord::scale() const
{
    return std::string( scale_name( scale_ ) );
}

std::string script_tripoint_coord::type_name() const
{
    return "Tripoint_" + origin() + "_" + scale();
}

tripoint script_tripoint_coord::to_native() const
{
    return tripoint( x_, y_, z_ );
}

script_point_coord script_tripoint_coord::xy() const
{
    return script_point_coord::from_native(
               origin_, scale_, point( x_, y_ ) );
}

script_tripoint_coord script_tripoint_coord::add(
    const script_tripoint_coord &rhs ) const
{
    require_same_scale( scale_, rhs.scale_ );
    return script_tripoint_coord(
               addition_result_origin( origin_, rhs.origin_ ), scale_,
               checked_axis_sum( x_, rhs.x_ ), checked_axis_sum( y_, rhs.y_ ),
               checked_axis_sum( z_, rhs.z_ ) );
}

script_tripoint_coord script_tripoint_coord::add_xy(
    const script_point_coord &rhs ) const
{
    require_same_scale( scale_, rhs.native_scale() );
    require_relative( rhs.native_origin(), "point offset addition" );
    return script_tripoint_coord(
               origin_, scale_,
               checked_axis_sum( x_, rhs.x() ),
               checked_axis_sum( y_, rhs.y() ), z_ );
}

script_tripoint_coord script_tripoint_coord::subtract(
    const script_tripoint_coord &rhs ) const
{
    require_same_scale( scale_, rhs.scale_ );
    return script_tripoint_coord(
               subtraction_result_origin( origin_, rhs.origin_ ), scale_,
               checked_axis_difference( x_, rhs.x_ ),
               checked_axis_difference( y_, rhs.y_ ),
               checked_axis_difference( z_, rhs.z_ ) );
}

script_tripoint_coord script_tripoint_coord::subtract_xy(
    const script_point_coord &rhs ) const
{
    require_same_scale( scale_, rhs.native_scale() );
    require_relative( rhs.native_origin(), "point offset subtraction" );
    return script_tripoint_coord(
               origin_, scale_,
               checked_axis_difference( x_, rhs.x() ),
               checked_axis_difference( y_, rhs.y() ), z_ );
}

script_tripoint_coord script_tripoint_coord::scale_by(
    const std::int64_t factor ) const
{
    require_relative( origin_, "scaling" );
    return script_tripoint_coord(
               origin_, scale_,
               checked_axis_product( x_, factor ),
               checked_axis_product( y_, factor ),
               checked_axis_product( z_, factor ) );
}

script_tripoint_coord script_tripoint_coord::negate() const
{
    return scale_by( -1 );
}

script_tripoint_coord script_tripoint_coord::project_to(
    const std::string_view result_scale ) const
{
    const coords::scale target = parse_scale( result_scale );
    require_supported_kind( origin_, target );
    exact_projection_factor( scale_, target );
    return script_tripoint_coord(
               origin_, target,
               projected_axis( x_, scale_, target ),
               projected_axis( y_, scale_, target ), z_ );
}

std::tuple<script_tripoint_coord, script_point_coord>
script_tripoint_coord::project_remain(
    const std::string_view result_scale ) const
{
    const coords::scale coarse_scale = parse_scale( result_scale );
    const std::int64_t factor =
        projection_down_factor( scale_, coarse_scale );
    const coords::origin fine_origin = remainder_origin( coarse_scale );
    require_supported_kind( origin_, coarse_scale );
    require_supported_kind( fine_origin, scale_ );

    const int coarse_x = floor_divide_axis( x_, factor );
    const int coarse_y = floor_divide_axis( y_, factor );
    const int remainder_x = checked_axis(
                                static_cast<std::int64_t>( x_ ) -
                                static_cast<std::int64_t>( coarse_x ) * factor );
    const int remainder_y = checked_axis(
                                static_cast<std::int64_t>( y_ ) -
                                static_cast<std::int64_t>( coarse_y ) * factor );
    return {
        script_tripoint_coord(
            origin_, coarse_scale, coarse_x, coarse_y, z_ ),
        script_point_coord::from_native(
            fine_origin, scale_, point( remainder_x, remainder_y ) )
    };
}

script_tripoint_coord script_tripoint_coord::project_combine(
    const script_point_coord &remainder ) const
{
    const std::int64_t factor =
        projection_down_factor( remainder.native_scale(), scale_ );
    if( remainder.native_origin() != remainder_origin( scale_ ) ) {
        throw std::invalid_argument(
            "services.coords project_combine received the wrong remainder origin" );
    }
    require_supported_kind( origin_, remainder.native_scale() );
    require_valid_remainder_axis( remainder.x(), factor );
    require_valid_remainder_axis( remainder.y(), factor );
    return script_tripoint_coord(
               origin_, remainder.native_scale(),
               checked_axis(
                   static_cast<std::int64_t>( x_ ) * factor + remainder.x() ),
               checked_axis(
                   static_cast<std::int64_t>( y_ ) * factor + remainder.y() ),
               z_ );
}

std::vector<script_tripoint_coord> script_tripoint_coord::line_to(
    const script_tripoint_coord &rhs, const std::int64_t max_points ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "trace a line between" );
    const std::size_t limit = checked_output_limit( max_points );
    const std::uint64_t count =
        static_cast<std::uint64_t>( square_distance( rhs ) ) + 1U;
    require_output_count( count, limit );

    std::vector<script_tripoint_coord> result;
    result.reserve( static_cast<std::size_t>( count ) );
    result.push_back( *this );
    if( !( *this == rhs ) ) {
        const std::vector<tripoint> native_line =
            ::line_to( to_native(), rhs.to_native() );
        for( const tripoint &value : native_line ) {
            result.push_back( from_native( origin_, scale_, value ) );
        }
    }
    return result;
}

std::int64_t script_tripoint_coord::manhattan_distance(
    const script_tripoint_coord &rhs ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "measure" );
    return axis_distance( x_, rhs.x_ ) + axis_distance( y_, rhs.y_ ) +
           axis_distance( z_, rhs.z_ );
}

std::int64_t script_tripoint_coord::square_distance(
    const script_tripoint_coord &rhs ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "measure" );
    return std::max( {
        axis_distance( x_, rhs.x_ ),
        axis_distance( y_, rhs.y_ ),
        axis_distance( z_, rhs.z_ )
    } );
}

double script_tripoint_coord::euclidean_distance(
    const script_tripoint_coord &rhs ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "measure" );
    return std::hypot(
               static_cast<double>( axis_distance( x_, rhs.x_ ) ),
               static_cast<double>( axis_distance( y_, rhs.y_ ) ),
               static_cast<double>( axis_distance( z_, rhs.z_ ) ) );
}

int script_tripoint_coord::compare( const script_tripoint_coord &rhs ) const
{
    require_matching_kind( origin_, scale_, rhs.origin_, rhs.scale_, "compare" );
    if( x_ == rhs.x_ && y_ == rhs.y_ && z_ == rhs.z_ ) {
        return 0;
    }
    return std::tie( x_, y_, z_ ) < std::tie( rhs.x_, rhs.y_, rhs.z_ ) ? -1 : 1;
}

std::string script_tripoint_coord::to_string() const
{
    return type_name() + "(" + std::to_string( x_ ) + "," +
           std::to_string( y_ ) + "," + std::to_string( z_ ) + ")";
}

coords::origin script_tripoint_coord::native_origin() const noexcept
{
    return origin_;
}

coords::scale script_tripoint_coord::native_scale() const noexcept
{
    return scale_;
}

std::vector<std::string> supported_script_coordinate_kinds()
{
    std::vector<std::string> result;
    result.reserve( coordinate_kinds.size() );
    for( const coordinate_kind_definition &definition : coordinate_kinds ) {
        result.emplace_back( definition.name );
    }
    return result;
}

std::vector<script_point_coord> script_coordinate_rectangle(
    const script_point_coord &from, const script_point_coord &to,
    const std::int64_t max_points )
{
    require_matching_kind(
        from.native_origin(), from.native_scale(),
        to.native_origin(), to.native_scale(), "iterate" );
    const std::size_t limit = checked_output_limit( max_points );
    const std::size_t count =
        checked_rectangle_count( from.x(), to.x(), from.y(), to.y(), limit );
    const std::int64_t minimum_x = std::min( from.x(), to.x() );
    const std::int64_t maximum_x = std::max( from.x(), to.x() );
    const std::int64_t minimum_y = std::min( from.y(), to.y() );
    const std::int64_t maximum_y = std::max( from.y(), to.y() );

    std::vector<script_point_coord> result;
    result.reserve( count );
    for( std::int64_t y = minimum_y; y <= maximum_y; ++y ) {
        for( std::int64_t x = minimum_x; x <= maximum_x; ++x ) {
            result.push_back( script_point_coord::from_native(
                                  from.native_origin(), from.native_scale(),
                                  point( checked_axis( x ), checked_axis( y ) ) ) );
        }
    }
    return result;
}

std::vector<script_tripoint_coord> script_coordinate_box(
    const script_tripoint_coord &from, const script_tripoint_coord &to,
    const std::int64_t max_points )
{
    require_matching_kind(
        from.native_origin(), from.native_scale(),
        to.native_origin(), to.native_scale(), "iterate" );
    const std::size_t limit = checked_output_limit( max_points );
    const std::size_t count =
        checked_box_count(
            from.x(), to.x(), from.y(), to.y(), from.z(), to.z(), limit );
    const std::int64_t minimum_x = std::min( from.x(), to.x() );
    const std::int64_t maximum_x = std::max( from.x(), to.x() );
    const std::int64_t minimum_y = std::min( from.y(), to.y() );
    const std::int64_t maximum_y = std::max( from.y(), to.y() );
    const std::int64_t minimum_z = std::min( from.z(), to.z() );
    const std::int64_t maximum_z = std::max( from.z(), to.z() );

    std::vector<script_tripoint_coord> result;
    result.reserve( count );
    for( std::int64_t z = minimum_z; z <= maximum_z; ++z ) {
        for( std::int64_t y = minimum_y; y <= maximum_y; ++y ) {
            for( std::int64_t x = minimum_x; x <= maximum_x; ++x ) {
                result.push_back( script_tripoint_coord::from_native(
                                      from.native_origin(), from.native_scale(),
                                      tripoint(
                                          checked_axis( x ), checked_axis( y ),
                                          checked_axis( z ) ) ) );
            }
        }
    }
    return result;
}

void install_coordinate_value_api(
    sol::state &lua, sol::table &game, std::function<void()> require_values )
{
    lua.new_usertype<script_point_coord>(
        "PointCoord", sol::no_constructor,
        "x", sol::property( &script_point_coord::x ),
        "y", sol::property( &script_point_coord::y ),
        "origin", sol::property( &script_point_coord::origin ),
        "scale", sol::property( &script_point_coord::scale ),
        "type", sol::property( &script_point_coord::type_name ),
        "add", &script_point_coord::add,
        "subtract", &script_point_coord::subtract,
        "scale_by", &script_point_coord::scale_by,
        "to", &script_point_coord::project_to,
        "project_to", &script_point_coord::project_to,
        "project_remain", &script_point_coord::project_remain,
        "project_combine", &script_point_coord::project_combine,
        "manhattan_distance", &script_point_coord::manhattan_distance,
        "square_distance", &script_point_coord::square_distance,
        "euclidean_distance", &script_point_coord::euclidean_distance,
        "compare", &script_point_coord::compare,
        sol::meta_function::to_string, &script_point_coord::to_string,
        sol::meta_function::equal_to,
    []( const script_point_coord & lhs, const script_point_coord & rhs ) {
        return lhs == rhs;
    },
    sol::meta_function::less_than,
    []( const script_point_coord & lhs, const script_point_coord & rhs ) {
        return lhs.compare( rhs ) < 0;
    },
    sol::meta_function::less_than_or_equal_to,
    []( const script_point_coord & lhs, const script_point_coord & rhs ) {
        return lhs.compare( rhs ) <= 0;
    },
    sol::meta_function::addition, &script_point_coord::add,
    sol::meta_function::subtraction, &script_point_coord::subtract,
    sol::meta_function::multiplication, &script_point_coord::scale_by,
    sol::meta_function::unary_minus, &script_point_coord::negate );

    lua.new_usertype<script_tripoint_coord>(
        "TripointCoord", sol::no_constructor,
        "x", sol::property( &script_tripoint_coord::x ),
        "y", sol::property( &script_tripoint_coord::y ),
        "z", sol::property( &script_tripoint_coord::z ),
        "origin", sol::property( &script_tripoint_coord::origin ),
        "scale", sol::property( &script_tripoint_coord::scale ),
        "type", sol::property( &script_tripoint_coord::type_name ),
        "xy", &script_tripoint_coord::xy,
        "add", sol::overload(
            &script_tripoint_coord::add,
            &script_tripoint_coord::add_xy ),
        "subtract", sol::overload(
            &script_tripoint_coord::subtract,
            &script_tripoint_coord::subtract_xy ),
        "scale_by", &script_tripoint_coord::scale_by,
        "to", &script_tripoint_coord::project_to,
        "project_to", &script_tripoint_coord::project_to,
        "project_remain", &script_tripoint_coord::project_remain,
        "project_combine", &script_tripoint_coord::project_combine,
        "manhattan_distance", &script_tripoint_coord::manhattan_distance,
        "square_distance", &script_tripoint_coord::square_distance,
        "euclidean_distance", &script_tripoint_coord::euclidean_distance,
        "compare", &script_tripoint_coord::compare,
        sol::meta_function::to_string, &script_tripoint_coord::to_string,
        sol::meta_function::equal_to,
    []( const script_tripoint_coord & lhs, const script_tripoint_coord & rhs ) {
        return lhs == rhs;
    },
    sol::meta_function::less_than,
    []( const script_tripoint_coord & lhs, const script_tripoint_coord & rhs ) {
        return lhs.compare( rhs ) < 0;
    },
    sol::meta_function::less_than_or_equal_to,
    []( const script_tripoint_coord & lhs, const script_tripoint_coord & rhs ) {
        return lhs.compare( rhs ) <= 0;
    },
    sol::meta_function::addition,
    sol::overload(
        &script_tripoint_coord::add,
        &script_tripoint_coord::add_xy ),
    sol::meta_function::subtraction,
    sol::overload(
        &script_tripoint_coord::subtract,
        &script_tripoint_coord::subtract_xy ),
    sol::meta_function::multiplication, &script_tripoint_coord::scale_by,
    sol::meta_function::unary_minus, &script_tripoint_coord::negate );

    sol::table coord_api = lua.create_table();
    coord_api.set_function(
        "point",
        [require_values](
            const std::string & origin, const std::string & scale,
    const std::int64_t x, const std::int64_t y ) {
        require_values();
        return script_point_coord::from( origin, scale, x, y );
    } );
    coord_api.set_function(
        "tripoint",
        [require_values](
            const std::string & origin, const std::string & scale,
    const std::int64_t x, const std::int64_t y, const std::int64_t z ) {
        require_values();
        return script_tripoint_coord::from( origin, scale, x, y, z );
    } );
    coord_api.set_function( "kinds", [require_values]( sol::this_state lua_state ) {
        require_values();
        sol::state_view state( lua_state );
        sol::table result = state.create_table();
        const std::vector<std::string> kinds =
            supported_script_coordinate_kinds();
        for( std::size_t index = 0; index < kinds.size(); ++index ) {
            result[index + 1] = kinds[index];
        }
        return result;
    } );
    coord_api.set_function(
        "project_to",
        sol::overload(
            [require_values](
    const script_point_coord & value, const std::string & scale ) {
        require_values();
        return value.project_to( scale );
    },
    [require_values](
        const script_tripoint_coord & value, const std::string & scale ) {
        require_values();
        return value.project_to( scale );
    } ) );
    coord_api.set_function(
        "project_remain",
        sol::overload(
            [require_values](
    const script_point_coord & value, const std::string & scale ) {
        require_values();
        return value.project_remain( scale );
    },
    [require_values](
        const script_tripoint_coord & value, const std::string & scale ) {
        require_values();
        return value.project_remain( scale );
    } ) );
    coord_api.set_function(
        "project_combine",
        sol::overload(
            [require_values](
                const script_point_coord & coarse,
    const script_point_coord & remainder ) {
        require_values();
        return coarse.project_combine( remainder );
    },
    [require_values](
        const script_tripoint_coord & coarse,
        const script_point_coord & remainder ) {
        require_values();
        return coarse.project_combine( remainder );
    } ) );
    coord_api.set_function(
        "line",
        sol::overload(
            [require_values](
                sol::this_state lua_state, const script_point_coord & from,
    const script_point_coord & to, const std::int64_t max_points ) {
        require_values();
        return coordinate_vector_table(
                   lua_state, from.line_to( to, max_points ) );
    },
    [require_values](
        sol::this_state lua_state, const script_tripoint_coord & from,
        const script_tripoint_coord & to, const std::int64_t max_points ) {
        require_values();
        return coordinate_vector_table(
                   lua_state, from.line_to( to, max_points ) );
    } ) );
    coord_api.set_function(
        "rectangle",
        [require_values](
            sol::this_state lua_state, const script_point_coord & from,
    const script_point_coord & to, const std::int64_t max_points ) {
        require_values();
        return coordinate_vector_table(
                   lua_state,
                   script_coordinate_rectangle( from, to, max_points ) );
    } );
    coord_api.set_function(
        "box",
        [require_values](
            sol::this_state lua_state, const script_tripoint_coord & from,
    const script_tripoint_coord & to, const std::int64_t max_points ) {
        require_values();
        return coordinate_vector_table(
                   lua_state,
                   script_coordinate_box( from, to, max_points ) );
    } );
    coord_api["max_range_points"] = maximum_coordinate_range_points;

    for( const coordinate_kind_definition &definition : coordinate_kinds ) {
        const std::string point_name = "point_" + std::string( definition.name );
        coord_api.set_function(
            point_name,
            [require_values, definition](
        const std::int64_t x, const std::int64_t y ) {
            require_values();
            return script_point_coord::from_native(
                       definition.origin, definition.scale,
                       point( checked_axis( x ), checked_axis( y ) ) );
        } );

        const std::string tripoint_name =
            "tripoint_" + std::string( definition.name );
        coord_api.set_function(
            tripoint_name,
            [require_values, definition](
        const std::int64_t x, const std::int64_t y, const std::int64_t z ) {
            require_values();
            return script_tripoint_coord::from_native(
                       definition.origin, definition.scale,
                       tripoint(
                           checked_axis( x ), checked_axis( y ),
                           checked_axis( z ) ) );
        } );
    }
    game["coords"] = std::move( coord_api );
}

} // namespace cata::lua

#endif // CATA_ENABLE_LUA_PLATFORM
