#include "catalua_bindings_coords.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <limits>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>

#include "point.h"

namespace cata::lua_ui
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
        "game.coords received an unknown coordinate origin: " + std::string( name ) );
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
        "game.coords received an unknown coordinate scale: " + std::string( name ) );
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
    throw std::logic_error( "game.coords value has an unknown origin" );
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
    throw std::logic_error( "game.coords value has an unknown scale" );
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
            "game.coords does not support coordinate kind " +
            std::string( origin_name( origin ) ) + "_" +
            std::string( scale_name( scale ) ) );
    }
}

int checked_axis( const std::int64_t value )
{
    if( value < std::numeric_limits<int>::min() ||
        value > std::numeric_limits<int>::max() ) {
        throw std::overflow_error( "game.coords axis exceeds the engine coordinate range" );
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
        throw std::overflow_error( "game.coords arithmetic exceeds the engine coordinate range" );
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
            "game.coords cannot " + std::string( operation ) +
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
        "game.coords addition requires at least one relative coordinate" );
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
        "game.coords subtraction requires a relative offset or matching coordinate kinds" );
}

void require_same_scale( const coords::scale lhs, const coords::scale rhs )
{
    if( lhs != rhs ) {
        throw std::invalid_argument(
            "game.coords arithmetic requires coordinates at the same scale" );
    }
}

void require_relative( const coords::origin origin, const std::string_view operation )
{
    if( origin != coords::origin::relative ) {
        throw std::invalid_argument(
            "game.coords " + std::string( operation ) +
            " is only valid for relative coordinates" );
    }
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

} // namespace cata::lua_ui
