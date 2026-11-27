#include "north_america_transport.h"

#include <weighted_list.h>
#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <initializer_list>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <string>
#include <string_view>
#include <tuple>
#include <unordered_map>
#include <utility>

#include "cata_path.h"
#include "cata_utility.h"
#include "coordinates.h"
#include "enums.h"
#include "flexbuffer_json.h"
#include "line.h"
#include "lru_cache.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapgen.h"
#include "mapgen_functions.h"
#include "mapgendata.h"
#include "north_america.h"
#include "north_america_ecology.h"
#include "north_america_elevation.h"
#include "omdata.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "point.h"
#include "submap.h"
#include "regional_settings.h"
#include "rng.h"
#include "type_id.h"
#include "units.h"

static const furn_str_id furn_f_street_light( "f_street_light" );

static const nested_mapgen_id
nested_mapgen_24x24_road_four_way_crossroad_vehicles_city( "24x24_road_four_way_crossroad_vehicles_city" );
static const nested_mapgen_id
nested_mapgen_24x24_road_straight_vehicles_city( "24x24_road_straight_vehicles_city" );
static const nested_mapgen_id
nested_mapgen_24x24_road_straight_vehicles_city_ew( "24x24_road_straight_vehicles_city_ew" );

static const oter_str_id oter_atlas_avenue_flank_ew( "atlas_avenue_flank_ew" );
static const oter_str_id oter_atlas_avenue_flank_ns( "atlas_avenue_flank_ns" );
static const oter_str_id oter_road_ew( "road_ew" );
static const oter_str_id oter_road_ns( "road_ns" );
static const oter_str_id oter_atlas_highway_east_west( "atlas_highway_east_west" );
static const oter_str_id oter_atlas_highway_north_south( "atlas_highway_north_south" );

static const oter_type_str_id oter_type_atlas_raised_bridge_deck( "atlas_raised_bridge_deck" );
static const oter_type_str_id oter_type_atlas_road_bridge( "atlas_road_bridge" );
static const oter_type_str_id oter_type_bridge( "bridge" );
static const oter_type_str_id oter_type_bridgehead_ground( "bridgehead_ground" );
static const oter_type_str_id oter_type_bridgehead_ramp( "bridgehead_ramp" );
static const oter_type_str_id oter_type_road( "road" );

static const ter_str_id ter_t_atlas_pavement_white( "t_atlas_pavement_white" );
static const ter_str_id ter_t_atlas_bridge_white( "t_atlas_bridge_white" );
static const ter_str_id ter_t_concrete_wall( "t_concrete_wall" );
static const ter_str_id ter_t_grass( "t_grass" );
static const ter_str_id ter_t_guardrail( "t_guardrail" );
static const ter_str_id ter_t_guardrail_hw_air( "t_guardrail_hw_air" );
static const ter_str_id ter_t_open_air( "t_open_air" );
static const ter_str_id ter_t_pavement( "t_pavement" );
static const ter_str_id ter_t_pavement_hw_air( "t_pavement_hw_air" );
static const ter_str_id ter_t_pavement_y( "t_pavement_y" );
static const ter_str_id ter_t_pavement_y_hw_air( "t_pavement_y_hw_air" );
static const ter_str_id ter_t_sidewalk( "t_sidewalk" );
static const ter_str_id ter_t_sidewalk_hw_air( "t_sidewalk_hw_air" );
static const ter_str_id ter_t_water_moving_dp( "t_water_moving_dp" );
static const ter_str_id ter_t_zebra( "t_zebra" );

namespace north_america
{
namespace
{
constexpr int bucket_width = 256;
constexpr int road_span = 2 * SEEX;
constexpr int wide_highway_halo = 4;
constexpr int highway_shoulder = 2;

std::uint32_t street_hash( std::uint32_t value )
{
    value ^= value >> 16;
    value *= 0x7feb352dU;
    value ^= value >> 15;
    value *= 0x846ca68bU;
    return value ^ ( value >> 16 );
}

struct street_axis {
    int block;
    // Negative slopes turn the axis the other way. A bend reverses its slope periodically.
    int slope = 0;
    int bend = 0;
    bool stagger = false;
    std::uint32_t seed = 0;

    int offset( int coordinate ) const {
        if( slope == 0 ) {
            return 0;
        }
        if( bend != 0 ) {
            // Shift bend locations gradually so adjacent neighborhoods have different block shapes.
            const int wave_period = 2 * bend + 13;
            const int phase = modulo( coordinate, wave_period );
            const int shift = std::min( phase, wave_period - phase ) / 4;
            coordinate = modulo( coordinate + shift, 2 * bend );
            coordinate = std::min( coordinate, 2 * bend - coordinate );
        }
        return coordinate / slope;
    }

    urban_road at( int line ) const {
        const int number = divide_round_to_minus_infinity( line + block / 2, block );
        const int slot = modulo( number, 5 );
        const int spread = block >= 6 ? 2 : 1;
        const int variation = static_cast<int>(
                                  street_hash( static_cast<std::uint32_t>( number ) ^ seed ) % ( 2 * spread + 1 ) ) -
                              spread;
        const int bias = ( slot == 2 ? 1 : slot == 4 ? -1 : 0 ) * static_cast<int>( stagger );
        // Keep each line in its own interval so neighboring streets never overlap.
        const int shift = number == 0 ? 0 :
                          std::clamp( variation + bias, -block / 2 + 1, ( block - 1 ) / 2 - 1 );
        if( line != number * block + shift ) {
            return urban_road::none;
        }
        return slot == 0 ? urban_road::arterial : slot == 2 ? urban_road::collector : urban_road::local;
    }

    // Draw the main step first; the cross-step shifts the centreline by one tile.
    urban_road cross_step( int across, int along ) const {
        const int before = offset( along - 1 );
        const int after = offset( along );
        return before == after ? urban_road::none : at( across - std::min( before, after ) );
    }
};

struct street_layout {
    street_axis rows;
    street_axis columns;
    int diagonal = 0;
    bool short_local_streets = false;
};

street_layout layout_for( const place &city )
{
    const std::string_view region = city.region;
    if( city.name == "New York" ) {
        return { { 4, 2 }, { 8, -2 }, -4 };
    }
    if( city.name == "Winnipeg" ) {
        return { { 5, 4, 30, true }, { 6, -4, 38 }, 3 };
    }
    if( region == "Massachusetts" || region == "Rhode Island" || region == "Maine" ||
        region == "New Hampshire" || region == "Vermont" || region == "Connecticut" ||
        region == "Nova Scotia" || region == "New Brunswick" ) {
        return { { 5, 3, 13, true }, { 5, -4, 17, true }, 0, true };
    }
    if( region == "Qu\u00e9bec" || region == "Quebec" || region == "Ontario" ) {
        return { { 5, 4, 36 }, { 6, -4, 45, true }, -3 };
    }
    if( city.country == "Mexico" ) {
        return { { 4, -4, 23, true }, { 6, 5, 31, true }, 3 };
    }
    if( region == "California" || region == "Oregon" || region == "Washington" ||
        region == "British Columbia" || region == "Arizona" || region == "Nevada" ) {
        return { { 5, 5, 27 }, { 7, 0, 0, true }, -3, true };
    }
    if( region == "Louisiana" || region == "Florida" || region == "South Carolina" ||
        region == "Georgia" ) {
        return { { 5, 4, 21, true }, { 6, -6, 27 }, 0, true };
    }
    if( region == "Manitoba" || region == "Alberta" || region == "Saskatchewan" ||
        region == "North Dakota" || region == "South Dakota" || region == "Nebraska" ||
        region == "Kansas" || region == "Iowa" || region == "Texas" ) {
        return { { 5 }, { 6 }, 4 };
    }
    return { { 5 }, { 6, -5, 33 }, 3 };
}

// The caller supplies the north or west endpoint, so adjacent windows agree.
urban_road urban_link( const street_layout &layout, point p, bool east )
{
    const street_axis &rows = layout.rows;
    const street_axis &columns = layout.columns;
    const int along = east ? p.x : p.y;
    const int across = east ? p.y : p.x;
    const street_axis &main = east ? rows : columns;
    const street_axis &cross = east ? columns : rows;
    const int line = across - main.offset( along );
    urban_road street = main.at( line );
    if( layout.short_local_streets && street == urban_road::local &&
        ( along + 3 * line ) % 23 == 0 ) {
        street = urban_road::none;
    }
    street = std::max( street, cross.cross_step( along, across ) );
    if( layout.diagonal != 0 && std::abs( p.x ) < 90 ) {
        const street_axis diagonal{ 1, layout.diagonal };
        const int before = diagonal.offset( p.x - 1 );
        const int after = diagonal.offset( p.x );
        if( east ? p.y == after : before != after && p.y == std::min( before, after ) ) {
            street = urban_road::arterial;
        }
    }
    return street;
}

struct road_segment {
    point begin;
    point end;
    unsigned lanes;

    point min() const {
        return { std::min( begin.x, end.x ), std::min( begin.y, end.y ) };
    }
    point max() const {
        return { std::max( begin.x, end.x ), std::max( begin.y, end.y ) };
    }
};

int highway_half_width( unsigned lanes )
{
    return std::clamp( static_cast<int>( lanes ), 4, 12 ) * SEEX / 2 - highway_shoulder;
}

ter_id highway_lane_surface( unsigned lanes, int stripe, bool dashed, bool controlled,
                             bool elevated = false, int half_width = 0, bool ramp = false )
{
    if( half_width == 0 ) {
        half_width = highway_half_width( lanes );
    }
    if( ramp ) {
        return stripe >= half_width - 1 ? ter_t_atlas_pavement_white.id() : ter_t_pavement.id();
    }
    const int median = controlled ? 2 : 0;
    if( stripe < median ) {
        return elevated ? ter_t_guardrail_hw_air.id() :
               stripe == 0 ? ter_t_guardrail.id() : ter_t_grass.id();
    }
    if( stripe == median ) {
        return ( elevated ? ter_t_pavement_y_hw_air : ter_t_pavement_y ).id();
    }
    const int lane_width = std::max( 1, ( half_width - median - 2 ) /
                                     static_cast<int>( lanes / 2 ) );
    const int across = stripe - median;
    const bool white = dashed && across % lane_width == 0 &&
                       across < lane_width * static_cast<int>( lanes / 2 );
    return white ? ( elevated ? ter_t_atlas_bridge_white : ter_t_atlas_pavement_white ).id() :
           ( elevated ? ter_t_pavement_hw_air : ter_t_pavement ).id();
}

struct wide_route {
    point begin;
    point end;
    unsigned lanes;
    bool controlled_access;
    int half_width = 0;
    bool ramp = false;
    bool local_access = false;
};

struct highway_stroke {
    double east;
    double south;
    double length;
    int half_width;
    bool vertical;
};

highway_stroke make_highway_stroke( const wide_route &segment )
{
    const point delta = segment.end - segment.begin;
    const double length = std::hypot( delta.x, delta.y );
    const int width = segment.half_width > 0 ? segment.half_width : highway_half_width( segment.lanes );
    if( length == 0 ) {
        return { 0, 0, 0, width, false };
    }
    return { delta.x / length, delta.y / length, length,
             width, std::abs( delta.y ) > std::abs( delta.x ) };
}

point highway_alignment( const road_segment &route )
{
    return route.lanes % 4 == 0 ? point( SEEX, SEEY ) : point::zero;
}

double highway_distance( const highway_stroke &stroke, double east, double south )
{
    const double along = std::clamp( east * stroke.east + south * stroke.south, 0.0,
                                     stroke.length );
    return std::hypot( east - stroke.east * along, south - stroke.south * along );
}

std::optional<std::pair<point, point>> clip_highway_stroke( const wide_route &route,
                                    const highway_stroke &stroke, point low, point high )
{
    double first = 0;
    double last = stroke.length;
    for( int axis = 0; axis < 2; ++axis ) {
        const double start = axis == 0 ? route.begin.x : route.begin.y;
        const double direction = axis == 0 ? stroke.east : stroke.south;
        const int minimum = axis == 0 ? low.x : low.y;
        const int maximum = axis == 0 ? high.x : high.y;
        if( std::abs( direction ) < 1e-12 ) {
            if( start < minimum || start > maximum ) {
                return std::nullopt;
            }
            continue;
        }
        const double a = ( minimum - start ) / direction;
        const double b = ( maximum - start ) / direction;
        first = std::max( first, std::min( a, b ) );
        last = std::min( last, std::max( a, b ) );
        if( first > last ) {
            return std::nullopt;
        }
    }
    return std::make_pair( route.begin + point( std::lround( first * stroke.east ),
                           std::lround( first * stroke.south ) ),
                           route.begin + point( std::lround( last * stroke.east ),
                                   std::lround( last * stroke.south ) ) );
}

template<typename Visitor>
void visit_road_raster( point begin, point end, point low, point high, const Visitor &visit )
{
    const point delta = end - begin;
    const int dx = std::abs( delta.x );
    const int dy = std::abs( delta.y );
    const int length = std::max( dx, dy );
    if( length == 0 ) {
        visit( begin, begin );
        return;
    }
    const int sx = ( delta.x > 0 ) - ( delta.x < 0 );
    const int sy = ( delta.y > 0 ) - ( delta.y < 0 );
    const bool east_west = dx >= dy;
    const int start = east_west ? begin.x : begin.y;
    const int sign = east_west ? sx : sy;
    const int minimum = east_west ? low.x : low.y;
    const int maximum = east_west ? high.x : high.y;
    const int first = std::max( 0, sign > 0 ? minimum - start : start - maximum );
    const int last = std::min( length, sign > 0 ? maximum - start : start - minimum );
    const auto at = [begin, dx, dy, length, sx, sy, east_west]( int step ) {
        if( dx == dy ) {
            return begin + point( sx * step, sy * step );
        }
        // Preserve the native t=0 Bresenham phase when skipping distant points.
        const int minor = step == 0 ? 0 : static_cast<int>(
                              ( static_cast<std::int64_t>( std::min( dx, dy ) ) * ( step - 1 ) + length - 1 ) / length );
        return begin + ( east_west ? point( sx * step, sy * minor ) :
                         point( sx * minor, sy * step ) );
    };
    for( int step = first; step <= last; ++step ) {
        visit( at( std::max( 0, step - 1 ) ), at( step ) );
    }
}

class highway_route_index
{
    public:
        static constexpr int cell_size = 64;
        std::vector<highway_stroke> strokes;

        highway_route_index( const std::vector<wide_route> &routes, point low, point high,
                             int radius = 0 ) :
            low_( low ), high_( high ) {
            strokes.reserve( routes.size() );
            for( std::size_t i = 0; i < routes.size(); ++i ) {
                const wide_route &route = routes[i];
                const highway_stroke stroke = make_highway_stroke( route );
                strokes.push_back( stroke );
                const int padding = stroke.half_width + radius + 1;
                const point first( std::max( low.x, std::min( route.begin.x, route.end.x ) - padding ),
                                   std::max( low.y, std::min( route.begin.y, route.end.y ) - padding ) );
                const point last( std::min( high.x, std::max( route.begin.x, route.end.x ) + padding ),
                                  std::min( high.y, std::max( route.begin.y, route.end.y ) + padding ) );
                if( first.x > last.x || first.y > last.y ) {
                    continue;
                }
                const point from = divide_xy_round_to_minus_infinity( first, cell_size );
                const point to = divide_xy_round_to_minus_infinity( last, cell_size );
                for( int y = from.y; y <= to.y; ++y ) {
                    for( int x = from.x; x <= to.x; ++x ) {
                        const point offset = point( x, y ) * cell_size + point( cell_size / 2,
                                             cell_size / 2 ) - route.begin;
                        if( highway_distance( stroke, offset.x, offset.y ) <=
                            padding + std::hypot( cell_size / 2, cell_size / 2 ) ) {
                            cells_[point( x, y )].push_back( i );
                        }
                    }
                }
            }
        }

        const std::vector<std::size_t> &nearby_routes( point position ) const {
            static const std::vector<std::size_t> empty;
            const auto found = cells_.find( divide_xy_round_to_minus_infinity( position, cell_size ) );
            return found == cells_.end() ? empty : found->second;
        }

        std::set<std::size_t> crossing_candidates( const wide_route &route,
                const highway_stroke &stroke ) const {
            std::set<std::size_t> result;
            const auto segment = clip_highway_stroke( route, stroke, low_, high_ );
            if( !segment ) {
                return result;
            }
            const point first = divide_xy_round_to_minus_infinity( segment->first, cell_size );
            const point last = divide_xy_round_to_minus_infinity( segment->second, cell_size );
            const auto collect = [this, &result]( point cell ) {
                for( int y = -2; y <= 2; ++y ) {
                    for( int x = -2; x <= 2; ++x ) {
                        if( const auto found = cells_.find( cell + point( x, y ) ); found != cells_.end() ) {
                            result.insert( found->second.begin(), found->second.end() );
                        }
                    }
                }
            };
            collect( first );
            for( const point &cell : line_to( first, last ) ) {
                collect( cell );
            }
            return result;
        }

    private:
        point low_;
        point high_;
        std::unordered_map<point, std::vector<std::size_t>> cells_;
};

struct transport_atlas {
    std::vector<road_segment> segments;
    std::unordered_map<point, std::vector<std::size_t>> buckets;

    transport_atlas() {
        const auto load_segments = [this]( const JsonValue & value ) {
            for( const JsonValue row : value.get_array() ) {
                const JsonArray entry = row.get_array();
                const road_segment segment{ { entry.get_int( 1 ), entry.get_int( 2 ) },
                    { entry.get_int( 3 ), entry.get_int( 4 ) },
                    static_cast<unsigned>( entry.get_int( 0 ) )
                };
                const point lo = divide_xy_round_to_minus_infinity( segment.min(), bucket_width );
                const point hi = divide_xy_round_to_minus_infinity( segment.max(), bucket_width );
                for( int y = lo.y; y <= hi.y; ++y ) {
                    for( int x = lo.x; x <= hi.x; ++x ) {
                        buckets[point( x, y )].push_back( segments.size() );
                    }
                }
                segments.push_back( segment );
            }
        };
        const cata_path raw = PATH_INFO::datadir_path() / "raw";
        read_from_file_json( raw / "north_america.transport", load_segments );
        read_from_file_json( raw / "north_america_nyc.transport", load_segments );
    }
};

template<typename Visitor>
void visit_roads( point from, point to, const Visitor &visit )
{
    static const transport_atlas atlas;
    const auto intersects = [&from, &to]( const road_segment & segment ) {
        const point lo = segment.min();
        const point hi = segment.max();
        return lo.x <= to.x && lo.y <= to.y && hi.x >= from.x && hi.y >= from.y;
    };

    const point lo = divide_xy_round_to_minus_infinity( from, bucket_width );
    const point hi = divide_xy_round_to_minus_infinity( to, bucket_width );
    if( ( hi.x - lo.x + 1 ) * ( hi.y - lo.y + 1 ) > 256 ) {
        for( const road_segment &segment : atlas.segments ) {
            if( intersects( segment ) ) {
                visit( segment );
            }
        }
        return;
    }
    std::vector<std::size_t> relevant;
    for( int y = lo.y; y <= hi.y; ++y ) {
        for( int x = lo.x; x <= hi.x; ++x ) {
            const auto bucket = atlas.buckets.find( point( x, y ) );
            if( bucket != atlas.buckets.end() ) {
                relevant.insert( relevant.end(), bucket->second.begin(), bucket->second.end() );
            }
        }
    }
    std::sort( relevant.begin(), relevant.end() );
    relevant.erase( std::unique( relevant.begin(), relevant.end() ), relevant.end() );
    for( std::size_t index : relevant ) {
        const auto &segment = atlas.segments[index];
        if( intersects( segment ) ) {
            visit( segment );
        }
    }
}

} // namespace

static std::vector<wide_route> highway_connection_routes( point_abs_omt origin, int width,
        int height,
        bool city_streets );

template<typename Visitor>
static void visit_wide_routes( point_abs_omt origin, int width, int height, bool mapped,
                               bool arterials, bool use_placed_streets, const Visitor &visit,
                               bool connections = true )
{
    const point first = origin.raw();
    if( mapped ) {
        if( connections ) {
            for( const wide_route &route : highway_connection_routes( origin, width, height, arterials ) ) {
                visit( route );
            }
        }
        visit_roads( first, first + point( width - 1, height - 1 ), [&]( const road_segment & route ) {
            if( route.lanes >= 4 && route.begin != route.end ) {
                const point offset = point( SEEX, SEEY ) + highway_alignment( route );
                visit( wide_route{ route.begin * road_span + offset, route.end * road_span + offset,
                                   route.lanes, true } );
            }
        } );
    }
    if( !arterials ) {
        return;
    }
    const std::vector<road_cell> streets = road_network( origin, width, height );
    for( int row = 0; row < height; ++row ) {
        for( int column = 0; column < width; ++column ) {
            const road_cell &cell = streets[row * width + column];
            const point_abs_omt tile = origin + point( column, row );
            std::size_t links = cell.arterial_connections;
            if( use_placed_streets ) {
                const oter_id &terrain = overmap_buffer.ter_existing( tripoint_abs_omt( tile, 0 ) );
                if( terrain ) {
                    const oter_type_str_id type = terrain->get_type_id();
                    if( type == oter_type_road ) {
                        links &= terrain->get_line();
                    } else if( type != oter_type_bridge && type != oter_type_bridgehead_ground &&
                               type != oter_type_bridgehead_ramp ) {
                        links = 0;
                    }
                }
            }
            const point center = tile.raw() * road_span +
                                 point( SEEX, SEEY ) * 2;
            std::array<point, 4> edges;
            int count = 0;
            for( const om_direction::type dir : om_direction::all ) {
                if( om_lines::has_segment( links, dir ) &&
                    !om_lines::has_segment( cell.mapped_wide_connections, dir ) ) {
                    edges[count++] = center + om_direction::displace( dir ).raw() * SEEX;
                }
            }
            const auto emit = [&]( point a, point b ) {
                if( b < a ) {
                    std::swap( a, b );
                }
                visit( wide_route{ a, b, 4, false, 0, false, cell.mapped_wide_connections != 0 } );
            };
            // Join the same edge points in both tiles, cutting across two-arm corners.
            if( count == 2 ) {
                emit( edges[0], edges[1] );
            } else {
                for( int i = 0; i < count; ++i ) {
                    emit( center, edges[i] );
                }
            }
        }
    }
}

std::vector<unsigned char> wide_highway_footprint( point_abs_omt origin, int width, int height,
        bool mapped, bool arterials )
{
    std::vector<unsigned char> result( width * height );
    const point first = origin.raw();
    const point halo( wide_highway_halo, wide_highway_halo );
    visit_wide_routes( origin - halo, width + 2 * halo.x, height + 2 * halo.y, mapped, arterials, false,
    [&]( const wide_route & route ) {
        const highway_stroke stroke = make_highway_stroke( route );
        const int corridor = stroke.half_width + highway_shoulder;
        const int offset = ( corridor + SEEX - 1 ) / road_span + 1;
        const auto stamp = [&]( point sample ) {
            const point local = sample - first;
            for( int row = std::max( 0, local.y - offset );
                 row <= std::min( height - 1, local.y + offset ); ++row ) {
                for( int column = std::max( 0, local.x - offset );
                     column <= std::min( width - 1, local.x + offset ); ++column ) {
                    const point from_start = ( first + point( column, row ) ) * road_span +
                                             point( SEEX, SEEY ) - route.begin;
                    const double along = std::clamp( from_start.x * stroke.east +
                                                     from_start.y * stroke.south, 0.0, stroke.length );
                    const double east = std::max( 0.0, std::abs( from_start.x - along * stroke.east ) - SEEX );
                    const double south = std::max( 0.0, std::abs( from_start.y - along * stroke.south ) - SEEY );
                    if( east * east + south * south < corridor * corridor ) {
                        unsigned char &cell = result[row * width + column];
                        const auto footprint = static_cast<unsigned char>( route.lanes * 2 + stroke.vertical );
                        cell = std::max( footprint, cell );
                    }
                }
            }
        };
        const point begin = divide_xy_round_to_minus_infinity( route.begin, road_span );
        const point end = divide_xy_round_to_minus_infinity( route.end, road_span );
        visit_road_raster( begin, end, first - point( offset, offset ),
                           first + point( width - 1 + offset, height - 1 + offset ),
        [&stamp]( point, point sample ) {
            stamp( sample );
        } );
    } );
    return result;
}

oter_id wide_highway_flank( bool north_south )
{
    return ( north_south ? oter_atlas_highway_north_south : oter_atlas_highway_east_west ).id();
}

namespace
{
struct wide_bridge_span {
    bool overpass = false;
    bool services = false;
    std::vector<wide_route> connections;
    std::vector<highway_service_site> service_sites;
    double east = 1;
    double south = 0;
    double low = 0;
    double high = 0;
    double across_low = 0;
    double across_high = 0;
    double low_height = 0;
    double high_height = 0;
    double deck_height = 0;
    double low_approach = road_span;
    double high_approach = road_span;

    bool carries( const wide_route &route ) const {
        if( !overpass ) {
            return true;
        }
        const highway_stroke stroke = make_highway_stroke( route );
        const double alignment = std::abs( stroke.east * east + stroke.south * south );
        const point offset = at( ( low + high ) / 2 ) - route.begin;
        return alignment > 0.9 &&
               std::abs( offset.y * stroke.east - offset.x * stroke.south ) < stroke.half_width;
    }

    double across( point p ) const {
        return p.y * east - p.x * south;
    }

    double side_distance( point p ) const {
        return std::min( across( p ) - across_low + road_span / 2.0,
                         across_high + road_span / 2.0 - across( p ) );
    }

    double ramp_distance( point p ) const {
        const double along = station( p );
        return std::min( { along - low, high - along, side_distance( p ) } );
    }

    double station( point p ) const {
        return p.x * east + p.y * south;
    }

    point at( double along ) const {
        const double across = ( across_low + across_high ) / 2;
        return point( std::lround( along * east - across * south ),
                      std::lround( along * south + across * east ) );
    }

    double deck_at( double along ) const {
        const double fraction = std::clamp( ( along - low ) / std::max( 1.0, high - low ), 0.0, 1.0 );
        return std::max( deck_height, low_height + fraction * ( high_height - low_height ) );
    }

    double height_at( point p, double ground ) const {
        const double along = station( p );
        double height = deck_at( along );
        if( along < low ) {
            const double fraction = std::clamp( ( along - low + low_approach ) / low_approach,
                                                0.0, 1.0 );
            height = ground + fraction * ( deck_at( low ) - ground );
        } else if( along > high ) {
            const double fraction = std::clamp( ( high + high_approach - along ) / high_approach,
                                                0.0, 1.0 );
            height = ground + fraction * ( deck_at( high ) - ground );
        }
        if( side_distance( p ) < 0 ) {
            const double fraction = std::clamp( 1 + side_distance( p ) / road_span, 0.0, 1.0 );
            height = ground + fraction * ( height - ground );
        }
        return height;
    }

    bool contains( point p, double margin = 0 ) const {
        const double along = station( p );
        const double normal = across( p );
        return along >= low - low_approach - margin && along <= high + high_approach + margin &&
               normal >= across_low - 1.5 * road_span - margin &&
               normal <= across_high + 1.5 * road_span + margin;
    }
};

std::vector<wide_bridge_span> collect_wide_bridge_spans( point_abs_omt bucket,
        bool mapped, bool arterials )
{
    constexpr int reach = 64;
    constexpr int side = 3 * reach;
    const point_abs_omt origin = bucket - point( reach, reach );
    const auto roads = wide_highway_footprint( origin, side, side, mapped, arterials );
    const auto water = raster( origin, side, side );
    std::vector<int> labels( side * side, -1 );
    std::vector<std::vector<point>> crossings;
    for( int y = 0; y < side; ++y ) {
        for( int x = 0; x < side; ++x ) {
            const int index = y * side + x;
            if( labels[index] >= 0 || !roads[index] || water[index] == terrain::land ) {
                continue;
            }
            const int id = static_cast<int>( crossings.size() );
            std::vector<point> pending{ point( x, y ) };
            labels[index] = id;
            for( std::size_t i = 0; i < pending.size(); ++i ) {
                for( const point &step : four_cardinal_directions ) {
                    const point next = pending[i] + step;
                    if( next.x < 0 || next.y < 0 || next.x >= side || next.y >= side ) {
                        continue;
                    }
                    const int key = next.y * side + next.x;
                    if( labels[key] < 0 && roads[key] && water[key] != terrain::land ) {
                        labels[key] = id;
                        pending.push_back( next );
                    }
                }
            }
            crossings.push_back( std::move( pending ) );
        }
    }
    std::vector<point> directions( crossings.size() );
    std::vector<bool> vertical_crossings;
    for( const auto &cells : crossings ) {
        const int vertical = static_cast<int>( std::count_if( cells.begin(),
        cells.end(), [&roads]( point p ) {
            return roads[p.y * side + p.x] % 2 != 0;
        } ) );
        vertical_crossings.push_back( vertical * 2 > static_cast<int>( cells.size() ) );
    }
    visit_wide_routes( origin, side, side, mapped, arterials, false,
    [&crossings, &directions, &vertical_crossings, origin]( const wide_route & route ) {
        const highway_stroke stroke = make_highway_stroke( route );
        for( std::size_t id = 0; id < crossings.size(); ++id ) {
            point delta = route.end - route.begin;
            const int along = vertical_crossings[id] ? delta.y : delta.x;
            const int across = vertical_crossings[id] ? delta.x : delta.y;
            if( std::abs( along ) * 2 < std::abs( across ) ) {
                continue;
            }
            if( along < 0 ) {
                delta = -delta;
            }
            if( std::any_of( crossings[id].begin(), crossings[id].end(), [&stroke, &route,
            origin]( point cell ) {
            const point offset = ( origin.raw() + cell ) * road_span + point( SEEX, SEEY ) - route.begin;
                return highway_distance( stroke, offset.x, offset.y ) < stroke.half_width;
            } ) ) {
                directions[id] += delta;
            }
        }
    } );
    std::vector<wide_bridge_span> result;
    for( std::size_t id = 0; id < crossings.size(); ++id ) {
        const auto &cells = crossings[id];
        if( std::any_of( cells.begin(), cells.end(), []( point p ) {
        return p.x == 0 || p.y == 0 || p.x == side - 1 || p.y == side - 1;
    } ) ) {
            continue;
        }
        point direction = directions[id];
        if( direction == point::zero ) {
            direction = vertical_crossings[id] ? point::south : point::east;
        }
        const double length = std::hypot( direction.x, direction.y );
        wide_bridge_span span;
        span.east = direction.x / length;
        span.south = direction.y / length;
        span.low = span.across_low = std::numeric_limits<double>::max();
        span.high = span.across_high = std::numeric_limits<double>::lowest();
        span.deck_height = std::numeric_limits<double>::lowest();
        const double extent = road_span / 2.0 * ( std::abs( span.east ) + std::abs( span.south ) );
        for( const point &cell : cells ) {
            const point_abs_ms center = project_to<coords::ms>( origin + cell ) + point( SEEX, SEEY );
            const double along = span.station( center.raw() );
            const double across = center.y() * span.east - center.x() * span.south;
            span.low = std::min( span.low, along - extent );
            span.high = std::max( span.high, along + extent );
            span.across_low = std::min( span.across_low, across - extent );
            span.across_high = std::max( span.across_high, across + extent );
            span.deck_height = std::max( span.deck_height, surface_elevation( center ) + 5.0 );
        }
        span.low -= road_span / 2.0;
        span.high += road_span / 2.0;
        for( int pass = 0; pass < 3; ++pass ) {
            span.low_height = surface_elevation( point_abs_ms( span.at( span.low - span.low_approach ) ) );
            span.high_height = surface_elevation( point_abs_ms( span.at( span.high + span.high_approach ) ) );
            span.low_approach = std::max( span.low_approach,
                                          ( span.deck_at( span.low ) - span.low_height ) / 0.08 );
            span.high_approach = std::max( span.high_approach,
                                           ( span.deck_at( span.high ) - span.high_height ) / 0.08 );
        }
        span.low_height = surface_elevation( point_abs_ms( span.at( span.low - span.low_approach ) ) );
        span.high_height = surface_elevation( point_abs_ms( span.at( span.high + span.high_approach ) ) );
        result.push_back( span );
    }
    return result;
}

void append_highway_overpasses( std::vector<wide_bridge_span> &spans, point_abs_omt bucket,
                                bool city_streets )
{
    constexpr int side = 224;
    const point_abs_omt origin = bucket - point( 80, 80 );
    std::vector<wide_route> routes;
    visit_wide_routes( origin, side, side, true, false, false,
    [&routes]( wide_route route ) {
        if( route.end < route.begin ) {
            std::swap( route.begin, route.end );
        }
        routes.push_back( route );
    }, false );
    if( std::none_of( routes.begin(), routes.end(), []( const wide_route & route ) {
    return route.controlled_access;
} ) ) {
        return;
    }
    const highway_route_index highways( routes, origin.raw() * road_span - point( 128, 128 ),
                                        ( origin.raw() + point( side, side ) ) * road_span + point( 128, 128 ), 256 );
    if( city_streets ) {
        visit_wide_routes( origin, side, side, false, true, false,
        [&routes, &highways]( const wide_route & route ) {
            if( !highways.nearby_routes( ( route.begin + route.end ) / 2 ).empty() ) {
                routes.push_back( route );
            }
        }, false );
    }
    const std::size_t mapped_count = routes.size();
    const auto water = raster( origin, side, side );
    const auto dry = [origin, &water]( point p ) {
        const point tile = project_to<coords::omt>( point_abs_ms( p ) ).raw() - origin.raw();
        return tile.x >= 16 && tile.y >= 16 && tile.x < side - 16 && tile.y < side - 16 &&
               water[tile.y * side + tile.x] == terrain::land;
    };
    const auto network = road_network( origin, side, side, city_streets );
    for( int y = 0; y < side; ++y ) {
        for( int x = 0; x < side; ++x ) {
            const road_cell &cell = network[y * side + x];
            const std::size_t links = cell.connections & ~cell.mapped_wide_connections &
                                      ~cell.arterial_connections;
            const point center = ( origin.raw() + point( x, y ) ) * road_span + point( SEEX, SEEY );
            if( links == 0 || highways.nearby_routes( center ).empty() ) {
                continue;
            }
            for( const om_direction::type dir : om_direction::all ) {
                if( om_lines::has_segment( links, dir ) ) {
                    const point edge = center + om_direction::displace( dir ).raw() * SEEX;
                    routes.push_back( { std::min( center, edge ), std::max( center, edge ), 2, false, 8,
                                        false, cell.mapped_wide_connections != 0 } );
                }
            }
        }
    }
    std::set<point> service_centers;
    constexpr int service_spacing = 3200 * road_span;
    for( std::size_t i = 0; i < mapped_count; ++i ) {
        const wide_route route = routes[i];
        if( !route.controlled_access ) {
            continue;
        }
        const highway_stroke stroke = make_highway_stroke( route );
        const bool vertical = std::abs( stroke.south ) > std::abs( stroke.east );
        const int first = vertical ? route.begin.y : route.begin.x;
        const int last = vertical ? route.end.y : route.end.x;
        const auto segment = clip_highway_stroke( route, stroke, origin.raw() * road_span,
                             ( origin.raw() + point( side, side ) ) * road_span );
        if( !segment ) {
            continue;
        }
        const int clipped_first = vertical ? segment->first.y : segment->first.x;
        const int clipped_last = vertical ? segment->second.y : segment->second.x;
        const int lo = std::min( clipped_first, clipped_last );
        const int hi = std::max( clipped_first, clipped_last );
        const int start = static_cast<int>( std::floor( static_cast<double>( lo ) / service_spacing ) ) - 1;
        const int finish = static_cast<int>( std::floor( static_cast<double>( hi ) / service_spacing ) ) +
                           1;
        for( int index = start; index <= finish; ++index ) {
            const int station = index * service_spacing + static_cast<int>( street_hash(
                                    static_cast<std::uint32_t>( index ) ^ ( vertical ? 0x7d1aU : 0x3bc9U ) ) %
                                ( service_spacing / 2 ) ) - service_spacing / 4;
            if( station <= lo || station > hi || first == last ) {
                continue;
            }
            const double t = static_cast<double>( station - first ) / ( last - first );
            const point center( std::lround( route.begin.x + t * ( route.end.x - route.begin.x ) ),
                                std::lround( route.begin.y + t * ( route.end.y - route.begin.y ) ) );
            const point_abs_omt tile = project_to<coords::omt>( point_abs_ms( center ) );
            if( in_urban_footprint( tile ) ||
                project_to<coords::om>( tile - point( 16, 16 ) ) != project_to<coords::om>( tile + point( 16,
                        16 ) ) ||
                !dry( center ) || !service_centers.insert( center ).second ) {
                continue;
            }
            const point reach( std::lround( -stroke.south * ( stroke.half_width + 200 ) ),
                               std::lround( stroke.east * ( stroke.half_width + 200 ) ) );
            routes.push_back( { center - reach, center + reach, 2, false, 8 } );
        }
    }
    const highway_route_index route_index( routes, origin.raw() * road_span - point( 128, 128 ),
                                           ( origin.raw() + point( side, side ) ) * road_span + point( 128, 128 ) );
    const auto through = [&routes, &route_index]( point center, const highway_stroke & axis ) {
        int connected = 0;
        for( const int side : {
                 -1, 1
                 } ) {
            const point sample = center + point( std::lround( side * 120 * axis.east ),
                                                 std::lround( side * 120 * axis.south ) );
            const auto &nearby = route_index.nearby_routes( sample );
            if( std::any_of( nearby.begin(), nearby.end(), [&axis, sample, &routes,
                   &route_index]( std::size_t index ) {
            const wide_route &route = routes[index];
                const highway_stroke &stroke = route_index.strokes[index];
                const point offset = sample - route.begin;
                return std::abs( stroke.east * axis.east + stroke.south * axis.south ) > 0.9 &&
                       highway_distance( stroke, offset.x, offset.y ) < stroke.half_width;
            } ) ) {
                connected |= side < 0 ? 1 : 2;
            }
        }
        return connected;
    };
    std::vector<point> placed;
    std::vector<std::pair<wide_route, wide_route>> axes;
    for( std::size_t i = 0; i < mapped_count; ++i ) {
        if( !routes[i].controlled_access ) {
            continue;
        }
        const highway_stroke &a = route_index.strokes[i];
        for( const std::size_t j : route_index.crossing_candidates( routes[i], a ) ) {
            if( j <= i ) {
                continue;
            }
            const highway_stroke &b = route_index.strokes[j];
            const double cross = a.east * b.south - a.south * b.east;
            if( std::abs( cross ) < 0.35 ) {
                continue;
            }
            const point offset = routes[j].begin - routes[i].begin;
            const double along_a = ( offset.x * b.south - offset.y * b.east ) / cross;
            const double along_b = ( offset.x * a.south - offset.y * a.east ) / cross;
            const int extension = routes[j].controlled_access ? 1 : 2 * road_span;
            if( along_a < -1 || along_b < -extension || along_a > a.length + 1 ||
                along_b > b.length + extension ) {
                continue;
            }
            const point center = routes[i].begin + point( std::lround( along_a * a.east ),
                                 std::lround( along_a * a.south ) );
            if( !dry( center ) || std::any_of( placed.begin(), placed.end(), [center]( point other ) {
            return std::hypot( center.x - other.x, center.y - other.y ) < 2 * road_span;
            } ) ) {
                continue;
            }
            const int local_sides = through( center, b );
            if( through( center, a ) != 3 || local_sides == 0 ||
                ( local_sides != 3 && ( routes[j].controlled_access || !routes[j].local_access ) ) ) {
                continue;
            }
            const bool lift_a = routes[j].controlled_access && ( routes[i].lanes > routes[j].lanes ||
                                ( routes[i].lanes == routes[j].lanes &&
                                  std::tie( routes[i].begin, routes[i].end ) < std::tie( routes[j].begin, routes[j].end ) ) );
            const highway_stroke &upper = lift_a ? a : b;
            const highway_stroke &lower = lift_a ? b : a;
            wide_bridge_span span;
            span.overpass = true;
            span.services = service_centers.count( center ) > 0;
            span.east = upper.east;
            span.south = upper.south;
            const double station = span.station( center );
            const double normal = span.across( center );
            const double half_length = ( lower.half_width + highway_shoulder + road_span / 2 ) / std::abs(
                                           cross );
            span.low = station - half_length;
            span.high = station + half_length;
            span.across_low = normal - upper.half_width - highway_shoulder;
            span.across_high = normal + upper.half_width + highway_shoulder;
            span.deck_height = surface_elevation( point_abs_ms( center ) ) + 5;
            span.low_approach = span.high_approach = 5 / 0.06;
            span.low_height = surface_elevation( point_abs_ms( span.at( span.low - span.low_approach ) ) );
            span.high_height = surface_elevation( point_abs_ms( span.at( span.high + span.high_approach ) ) );
            if( !routes[j].controlled_access ) {
                span.connections.push_back( { span.at( span.low - span.low_approach - road_span ),
                                              span.at( span.high + span.high_approach + road_span ),
                                              routes[j].lanes, false, upper.half_width } );
            }
            spans.push_back( std::move( span ) );
            axes.emplace_back( routes[i], routes[j] );
            placed.push_back( center );
        }
    }
    for( std::size_t i = 0; i < spans.size(); ++i ) {
        wide_bridge_span &span = spans[i];
        if( axes[i].second.controlled_access ) {
            continue;
        }
        const highway_stroke main = make_highway_stroke( axes[i].first );
        const point center = placed[i];
        const bool urban = in_urban_footprint( project_to<coords::omt>( point_abs_ms( center ) ) );
        const int spacing = urban ? 64 : 128;
        const point tile = project_to<coords::omt>( point_abs_ms( center ) ).raw();
        const point cell = divide_xy_round_to_minus_infinity( tile, spacing ) * spacing;
        const point target = ( cell + point( spacing / 2, spacing / 2 ) ) * road_span;
        const double score = std::hypot( center.x - target.x, center.y - target.y );
        bool ramps = true;
        for( std::size_t j = 0; j < spans.size() && !span.services; ++j ) {
            if( i == j || axes[j].second.controlled_access ) {
                continue;
            }
            const highway_stroke other = make_highway_stroke( axes[j].first );
            const point other_tile = project_to<coords::omt>( point_abs_ms( placed[j] ) ).raw();
            const double other_score = std::hypot( placed[j].x - target.x, placed[j].y - target.y );
            const double across = ( placed[j].y - center.y ) * main.east - ( placed[j].x - center.x ) *
                                  main.south;
            if( std::abs( main.east * other.east + main.south * other.south ) > 0.99 &&
                std::abs( across ) < main.half_width &&
                divide_xy_round_to_minus_infinity( other_tile, spacing ) * spacing == cell &&
                ( other_score < score || ( other_score == score && placed[j] < center ) ) ) {
                ramps = false;
                break;
            }
        }
        if( !ramps ) {
            continue;
        }
        for( const int side : {
                 -1, 1
                 } ) {
            const double local_distance = ( span.high - span.low ) / 2 + span.high_approach + 30;
            const point local = span.at( ( span.low + span.high ) / 2 + side * local_distance );
            const int normal_side = ( ( local.y - center.y ) * main.east - ( local.x - center.x ) * main.south )
                                    < 0 ? -1 : 1;
            const double local_station = ( local.x - center.x ) * main.east + ( local.y - center.y ) *
                                         main.south;
            for( const int along : {
                     -1, 1
                     } ) {
                const point merge = center + point( std::lround( ( local_station + along * 170 ) * main.east -
                                                    normal_side * ( main.half_width - 4 ) * main.south ),
                                                    std::lround( ( local_station + along * 170 ) * main.south + normal_side *
                                                            ( main.half_width - 4 ) * main.east ) );
                const point control_a = merge - point( std::lround( along * 90 * main.east ),
                                                       std::lround( along * 90 * main.south ) );
                const point control_b = local + point( std::lround( along * 50 * main.east ),
                                                       std::lround( along * 50 * main.south ) );
                point previous = merge;
                for( int step = 1; step <= 16; ++step ) {
                    const double t = step / 16.0;
                    const double u = 1 - t;
                    const point next( std::lround( u * u * u * merge.x + 3 * u * u * t * control_a.x + 3 * u * t * t *
                                                   control_b.x + t * t * t * local.x ),
                                      std::lround( u * u * u * merge.y + 3 * u * u * t * control_a.y + 3 * u * t * t * control_b.y + t * t
                                                   * t * local.y ) );
                    if( previous != next ) {
                        span.connections.push_back( { previous, next, 2, false, 3, true } );
                    }
                    previous = next;
                }
            }
            if( span.services ) {
                const point site = local + point( std::lround( main.east * 2 * road_span ),
                                                  std::lround( main.south * 2 * road_span ) );
                const point facing = std::abs( main.east ) > std::abs( main.south ) ?
                                     point( main.east > 0 ? -1 : 1, 0 ) : point( 0, main.south > 0 ? -1 : 1 );
                const point_abs_omt lot = project_to<coords::omt>( point_abs_ms( site ) );
                const point access = project_to<coords::ms>( lot ).raw() + point( SEEX, SEEY ) +
                                     facing * road_span;
                span.connections.push_back( { local, access, 2, false, 8 } );
                span.service_sites.push_back( { lot, facing } );
            }
        }
    }
}

using bridge_spans = std::vector<wide_bridge_span>;
using bridge_span_owner = std::shared_ptr<const bridge_spans>;

bridge_span_owner highway_plans_at( point_abs_omt bucket, bool city_streets )
{
    static lru_cache<tripoint, bridge_span_owner> cache;
    const tripoint key( bucket.raw(), city_streets ? 1 : 0 );
    if( const auto found = cache.get( key, {} ) ) {
        return found;
    }
    std::vector<wide_bridge_span> plans;
    append_highway_overpasses( plans, bucket, city_streets );
    plans.erase( std::remove_if( plans.begin(), plans.end(), [bucket]( const wide_bridge_span & span ) {
        const point center = project_to<coords::omt>( point_abs_ms( span.at( (
                                 span.low + span.high ) / 2 ) ) ).raw();
        return divide_xy_round_to_minus_infinity( center, 64 ) * 64 != bucket.raw();
    } ), plans.end() );
    const bridge_span_owner result = std::make_shared<bridge_spans>( std::move( plans ) );
    cache.insert( 128, key, result );
    return result;
}

bridge_span_owner wide_bridge_spans_at( point_abs_omt tile,
                                        bool mapped, bool arterials )
{
    static lru_cache<tripoint, bridge_span_owner> cache;
    const point bucket = divide_xy_round_to_minus_infinity( tile.raw(), 64 ) * 64;
    const tripoint key( bucket, static_cast<int>( mapped ) + 2 * static_cast<int>( arterials ) );
    if( const auto found = cache.get( key, {} ) ) {
        return found;
    }
    auto spans = collect_wide_bridge_spans( point_abs_omt( bucket ), mapped, arterials );
    if( mapped ) {
        for( int y = -64; y <= 64; y += 64 ) {
            for( int x = -64; x <= 64; x += 64 ) {
                const auto plans = highway_plans_at( point_abs_omt( bucket + point( x, y ) ), arterials );
                spans.insert( spans.end(), plans->begin(), plans->end() );
            }
        }
    }
    const bridge_span_owner result = std::make_shared<bridge_spans>( std::move( spans ) );
    cache.insert( 32, key, result );
    return result;
}

struct wide_bridge_query {
    bridge_span_owner owner;
    std::vector<const wide_bridge_span *> candidates;

    wide_bridge_query( point_abs_omt tile, bool mapped, bool arterials ) :
        owner( wide_bridge_spans_at( tile, mapped, arterials ) ) {
        const point center = project_to<coords::ms>( tile ).raw() + point( SEEX, SEEY );
        for( const wide_bridge_span &span : *owner ) {
            if( span.contains( center, std::hypot( SEEX, SEEY ) ) ) {
                candidates.push_back( &span );
            }
        }
    }
};

double wide_road_height( point_abs_ms center, point_abs_ms position, bool mapped, bool arterials,
                         const wide_route *route = nullptr, const wide_bridge_query *query = nullptr )
{
    const double ground = surface_elevation( center );
    const auto height = [position, route,
              ground]( const wide_bridge_span & span ) -> std::optional<double> {
        if( span.contains( position.raw() ) && ( !span.overpass || ( route && span.carries( *route ) ) ) )
        {
            return span.height_at( position.raw(), ground );
        }
        return std::nullopt;
    };
    if( query ) {
        for( const wide_bridge_span *span : query->candidates ) {
            if( const auto result = height( *span ) ) {
                return *result;
            }
        }
    } else {
        const auto spans = wide_bridge_spans_at( project_to<coords::omt>( position ), mapped, arterials );
        for( const wide_bridge_span &span : *spans ) {
            if( const auto result = height( span ) ) {
                return *result;
            }
        }
    }
    return ground;
}
} // namespace

static std::vector<wide_route> highway_connection_routes( point_abs_omt origin, int width,
        int height,
        bool city_streets )
{
    std::vector<wide_route> result;
    std::set<std::tuple<point, point, int, bool>> seen;
    const point first = divide_xy_round_to_minus_infinity( origin.raw() - point( 16, 16 ), 64 ) * 64;
    const point last = divide_xy_round_to_minus_infinity( origin.raw() + point( width + 16,
                       height + 16 ), 64 ) * 64;
    const point low = origin.raw() * road_span - point( 12, 12 );
    const point high = ( origin.raw() + point( width, height ) ) * road_span + point( 12, 12 );
    for( int y = first.y; y <= last.y; y += 64 ) {
        for( int x = first.x; x <= last.x; x += 64 ) {
            const auto plans = highway_plans_at( point_abs_omt( x, y ), city_streets );
            for( const wide_bridge_span &span : *plans ) {
                for( const wide_route &route : span.connections ) {
                    if( std::max( route.begin.x, route.end.x ) >= low.x &&
                        std::min( route.begin.x, route.end.x ) <= high.x &&
                        std::max( route.begin.y, route.end.y ) >= low.y &&
                        std::min( route.begin.y, route.end.y ) <= high.y &&
                        seen.emplace( route.begin, route.end, route.half_width, route.ramp ).second ) {
                        result.push_back( route );
                    }
                }
            }
        }
    }
    return result;
}

std::vector<highway_service_site> highway_services( point_abs_omt origin, int width, int height,
        bool city_streets )
{
    std::vector<highway_service_site> result;
    std::set<point_abs_omt> seen;
    const point first = divide_xy_round_to_minus_infinity( origin.raw(), 64 ) * 64;
    const point last = divide_xy_round_to_minus_infinity( origin.raw() + point( width - 1, height - 1 ),
                       64 ) * 64;
    for( int y = first.y; y <= last.y; y += 64 ) {
        for( int x = first.x; x <= last.x; x += 64 ) {
            const auto plans = highway_plans_at( point_abs_omt( x, y ), city_streets );
            for( const wide_bridge_span &span : *plans ) {
                for( const highway_service_site &site : span.service_sites ) {
                    const point offset = site.position.raw() - origin.raw();
                    if( offset.x >= 0 && offset.y >= 0 && offset.x < width && offset.y < height &&
                        seen.insert( site.position ).second ) {
                        result.push_back( site );
                    }
                }
            }
        }
    }
    return result;
}

std::vector<wide_bridge_cell> wide_bridge_footprint( point_abs_omt origin, int width, int height,
        bool mapped, bool arterials, const std::vector<unsigned char> &roads )
{
    std::vector<wide_bridge_cell> result( width * height );
    for( int y = 0; y < height; ++y ) {
        for( int x = 0; x < width; ++x ) {
            if( !roads[y * width + x] ) {
                continue;
            }
            const point_abs_omt tile = origin + point( x, y );
            const point center = ( project_to<coords::ms>( tile ) + point( SEEX, SEEY ) ).raw();
            const auto spans = wide_bridge_spans_at( tile, mapped, arterials );
            for( const wide_bridge_span &span : *spans ) {
                const double extent = road_span / 2.0 * ( std::abs( span.east ) + std::abs( span.south ) );
                if( span.contains( center, extent ) && ( !span.overpass ||
                        std::abs( span.across( center ) - ( span.across_low + span.across_high ) / 2 ) <=
                        ( span.across_high - span.across_low ) / 2 + extent ) ) {
                    const double along = span.station( center );
                    const bool side_approach = span.side_distance( center ) <
                                               std::min( along - span.low, span.high - along );
                    const bool vertical = side_approach ? std::abs( span.east ) > std::abs( span.south ) :
                                          std::abs( span.south ) > std::abs( span.east );
                    const bool lower_end = side_approach ?
                                           ( span.across( center ) < ( span.across_low + span.across_high ) / 2 ) !=
                                           ( vertical ? span.east < 0 : span.south > 0 ) :
                                           along < ( span.low + span.high ) / 2;
                    result[y * width + x] = { true, along - extent < span.low + 3 ||
                                              along + extent > span.high - 3 || span.side_distance( center ) < extent + 3,
                                              vertical, lower_end
                                            };
                    break;
                }
            }
        }
    }
    return result;
}

enum class crosswalk_tile : unsigned char { none, asphalt, stop_line, zebra, junction };

struct crossing_arm {
    std::vector<point> path;
    int half_width;
};

struct crossing_frame {
    double x;
    double y;
    double east;
    double south;
    double left = 0;
    double right = 0;
};

static std::optional<crossing_frame> crossing_at( const crossing_arm &arm, double distance )
{
    for( std::size_t i = 1; i < arm.path.size(); ++i ) {
        const point delta = arm.path[i] - arm.path[i - 1];
        const double length = std::hypot( delta.x, delta.y );
        if( length > 0 && distance <= length ) {
            return crossing_frame{ arm.path[i - 1].x + distance *delta.x / length,
                                   arm.path[i - 1].y + distance *delta.y / length,
                                   delta.x / length, delta.y / length };
        }
        distance -= length;
    }
    return std::nullopt;
}

static double distance_to_crossing_arm( const crossing_arm &arm, double x, double y,
                                        double *station = nullptr )
{
    double distance = std::numeric_limits<double>::max();
    double walked = 0;
    for( std::size_t i = 1; i < arm.path.size(); ++i ) {
        const point delta = arm.path[i] - arm.path[i - 1];
        const double length_squared = static_cast<double>( delta.x ) * delta.x +
                                      static_cast<double>( delta.y ) * delta.y;
        if( length_squared == 0 ) {
            continue;
        }
        const double along = std::clamp( ( ( x - arm.path[i - 1].x ) * delta.x +
                                           ( y - arm.path[i - 1].y ) * delta.y ) / length_squared, 0.0, 1.0 );
        const double length = std::sqrt( length_squared );
        const double candidate = std::hypot( x - arm.path[i - 1].x - along * delta.x,
                                             y - arm.path[i - 1].y - along * delta.y );
        if( candidate < distance ) {
            distance = candidate;
            if( station ) {
                *station = walked + along * length;
            }
        }
        walked += length;
    }
    return distance;
}

struct planned_crosswalk {
    crossing_frame frame;
    double distance;
};

static std::optional<planned_crosswalk> plan_crosswalk( const std::vector<crossing_arm> &arms,
        std::size_t index )
{
    const crossing_arm &arm = arms[index];
    std::optional<crossing_frame> crossing;
    double crossing_distance = 0;
    for( int distance = 1; distance < 6 * road_span; ++distance ) {
        auto frame = crossing_at( arm, distance );
        if( !frame ) {
            break;
        }
        const auto before = crossing_at( arm, std::max( 0, distance - SEEX ) );
        const auto after = crossing_at( arm, distance + SEEX );
        if( before && after ) {
            const double east = after->x - before->x;
            const double south = after->y - before->y;
            const double length = std::hypot( east, south );
            if( length > 0 ) {
                frame->east = east / length;
                frame->south = south / length;
            }
        }
        // Find both curbs in the actual union of the bent approach strokes.
        bool curbs = true;
        for( const int side : {
                 -1, 1
                 } ) {
            double edge = 0;
            for( const double offset : {
                     -2.0, 0.0, 2.0
                     } ) {
                double across = 0;
                for( ; across <= 2 * arm.half_width + highway_shoulder; across += 0.5 ) {
                    const double px = frame->x + offset * frame->east - side * across * frame->south;
                    const double py = frame->y + offset * frame->south + side * across * frame->east;
                    if( std::none_of( arms.begin(), arms.end(), [px, py]( const crossing_arm & other ) {
                    return distance_to_crossing_arm( other, px, py ) < other.half_width;
                    } ) ) {
                        break;
                    }
                }
                curbs = curbs && across <= 2 * arm.half_width + highway_shoulder;
                edge = std::max( edge, across );
            }
            ( side < 0 ? frame->left : frame->right ) = edge;
        }
        if( !curbs ) {
            continue;
        }
        bool clear = true;
        for( std::size_t other = 0; other < arms.size() && clear; ++other ) {
            if( index == other ) {
                continue;
            }
            for( double across = -frame->left; across <= frame->right && clear; across += 2 ) {
                for( const double offset : {
                         -2.0, 2.0
                         } ) {
                    if( distance_to_crossing_arm( arms[other], frame->x + offset * frame->east - frame->south * across,
                                                  frame->y + offset * frame->south + frame->east * across ) < arms[other].half_width + 2 ) {
                        clear = false;
                        break;
                    }
                }
            }
        }
        if( clear ) {
            crossing = frame;
            crossing_distance = distance;
            break;
        }
    }
    if( !crossing ) {
        return std::nullopt;
    }
    return planned_crosswalk{ *crossing, crossing_distance };
}

using crossing_plans = std::vector<std::optional<planned_crosswalk>>;

static std::shared_ptr<const crossing_plans> crosswalk_layouts( const std::vector<crossing_arm>
        &arms )
{
    static lru_cache<std::string, std::shared_ptr<const crossing_plans>> cache;
    std::string key;
    for( const crossing_arm &arm : arms ) {
        key += std::to_string( arm.half_width );
        key += ':';
        for( const point &p : arm.path ) {
            key += std::to_string( p.x );
            key += ',';
            key += std::to_string( p.y );
            key += ';';
        }
        key += '|';
    }
    if( const auto found = cache.get( key, {} ) ) {
        return found;
    }
    auto result = std::make_shared<crossing_plans>();
    result->reserve( arms.size() );
    for( std::size_t i = 0; i < arms.size(); ++i ) {
        result->push_back( plan_crosswalk( arms, i ) );
    }
    cache.insert( 512, key, result );
    return result;
}

static std::array<crosswalk_tile, road_span *road_span> wide_urban_crosswalks(
    const tripoint_abs_omt &omt, bool mapped, bool arterials )
{
    std::array<crosswalk_tile, road_span *road_span> marks{};
    std::array<bool, road_span *road_span> clear_markings{};
    if( !arterials ) {
        return marks;
    }
    constexpr int radius = max_road_flanks + 1;
    constexpr int side = 2 * radius + 1;
    const point_abs_omt origin = omt.xy() - point( radius, radius );
    const auto network = road_network( origin, side, side );
    std::map<point, std::vector<point>> paths;
    visit_wide_routes( omt.xy() - point( 2 * radius + 2, 2 * radius + 2 ),
                       4 * radius + 5, 4 * radius + 5, mapped, arterials, true,
    [&paths]( const wide_route & route ) {
        if( !route.controlled_access ) {
            paths[route.begin].push_back( route.end );
            paths[route.end].push_back( route.begin );
        }
    } );
    const point local_origin = project_to<coords::ms>( omt.xy() ).raw();
    for( int y = 0; y < side; ++y ) {
        for( int x = 0; x < side; ++x ) {
            const road_cell &cell = network[y * side + x];
            if( !cell.arterial_connections || ( mapped && cell.mapped_wide_connections ) ) {
                continue;
            }
            const tripoint_abs_omt junction( origin + point( x, y ), omt.z() );
            const oter_id &terrain = overmap_buffer.ter_existing( junction );
            if( !terrain || terrain->get_type_id() != oter_type_road ) {
                continue;
            }
            const int connections = static_cast<int>( std::count_if( om_direction::all.begin(),
            om_direction::all.end(), [&terrain]( om_direction::type direction ) {
                return om_lines::has_segment( terrain->get_line(), direction );
            } ) );
            if( connections < 3 ) {
                continue;
            }
            point center = project_to<coords::ms>( junction.xy() ).raw() + point( 2 * SEEX, 2 * SEEY );
            auto adjacent = paths.find( center );
            if( adjacent == paths.end() ) {
                std::optional<std::pair<point, point>> segment;
                point projected;
                double nearest = highway_half_width( 4 ) / 2.0;
                for( const auto &entry : paths ) {
                    for( const point &end : entry.second ) {
                        const point delta = end - entry.first;
                        const double length_squared = delta.x * delta.x + delta.y * delta.y;
                        if( length_squared == 0 ) {
                            continue;
                        }
                        const point offset = center - entry.first;
                        const double fraction = ( offset.x * delta.x + offset.y * delta.y ) / length_squared;
                        if( fraction <= 0 || fraction >= 1 ) {
                            continue;
                        }
                        const double distance = std::hypot( offset.x - fraction * delta.x,
                                                            offset.y - fraction * delta.y );
                        const point candidate = entry.first + point( std::lround( fraction * delta.x ),
                                                std::lround( fraction * delta.y ) );
                        if( candidate == entry.first || candidate == end ) {
                            continue;
                        }
                        if( distance < nearest ) {
                            nearest = distance;
                            projected = candidate;
                            segment = std::make_pair( entry.first, end );
                        }
                    }
                }
                if( segment ) {
                    center = projected;
                    for( const auto &ends : {
                             *segment, std::make_pair( segment->second, segment->first )
                         } ) {
                        auto &neighbors = paths[ends.first];
                        neighbors.erase( std::remove( neighbors.begin(), neighbors.end(), ends.second ),
                                         neighbors.end() );
                        neighbors.push_back( center );
                    }
                    paths[center] = { segment->first, segment->second };
                    adjacent = paths.find( center );
                }
            }
            if( adjacent == paths.end() ) {
                continue;
            }
            std::vector<crossing_arm> arms;
            for( const point &first : adjacent->second ) {
                crossing_arm arm{ { center, first }, highway_half_width( 4 ) };
                while( arm.path.size() < 16 ) {
                    const point current = arm.path.back();
                    const auto next = paths.find( current );
                    if( next == paths.end() ) {
                        break;
                    }
                    const point previous = arm.path[arm.path.size() - 2];
                    std::optional<point> continuation;
                    for( const point &candidate : next->second ) {
                        if( candidate != previous ) {
                            if( continuation && *continuation != candidate ) {
                                continuation.reset();
                                break;
                            }
                            continuation = candidate;
                        }
                    }
                    if( !continuation ||
                        std::find( arm.path.begin(), arm.path.end(), *continuation ) != arm.path.end() ) {
                        break;
                    }
                    arm.path.push_back( *continuation );
                }
                arms.push_back( std::move( arm ) );
            }
            for( const om_direction::type direction : om_direction::all ) {
                if( om_lines::has_segment( terrain->get_line(), direction ) &&
                    !om_lines::has_segment( cell.arterial_connections, direction ) ) {
                    arms.push_back( { {
                            center, center + om_direction::displace( direction ).raw() *
                            4 * road_span
                        }, 8 } );
                }
            }
            if( arms.size() < 3 ) {
                continue;
            }
            // Clear markings only in the overlap of the actual approach corridors.
            for( int row = 0; row < road_span; ++row ) {
                for( int col = 0; col < road_span; ++col ) {
                    const point p = local_origin + point( col, row );
                    const int overlapping = static_cast<int>( std::count_if( arms.begin(), arms.end(),
                    [p]( const crossing_arm & arm ) {
                        return distance_to_crossing_arm( arm, p.x + 0.5, p.y + 0.5 ) < arm.half_width;
                    } ) );
                    if( overlapping >= 2 ) {
                        clear_markings[row * road_span + col] = true;
                    }
                }
            }
            const auto layouts = crosswalk_layouts( arms );
            for( std::size_t index = 0; index < arms.size(); ++index ) {
                const crossing_arm &arm = arms[index];
                const auto &planned = ( *layouts )[index];
                if( !planned ) {
                    continue;
                }
                const crossing_frame *crossing = &planned->frame;
                const double crossing_distance = planned->distance;
                for( int row = 0; row < road_span; ++row ) {
                    for( int col = 0; col < road_span; ++col ) {
                        const point p = local_origin + point( col, row );
                        double station = 0;
                        if( distance_to_crossing_arm( arm, p.x + 0.5, p.y + 0.5, &station ) < arm.half_width &&
                            station <= crossing_distance + 7 ) {
                            clear_markings[row * road_span + col] = true;
                        }
                        const double east = local_origin.x + col + 0.5 - crossing->x;
                        const double south = local_origin.y + row + 0.5 - crossing->y;
                        const double along = east * crossing->east + south * crossing->south;
                        const double across = south * crossing->east - east * crossing->south;
                        if( across <= -crossing->left || across >= crossing->right ) {
                            continue;
                        }
                        crosswalk_tile &mark = marks[row * road_span + col];
                        if( along >= -2 && along < 2 ) {
                            const crosswalk_tile stripe = modulo( static_cast<int>( std::floor(
                                    ( across + crossing->left ) / 2 ) ), 2 ) ?
                                                          crosswalk_tile::zebra : crosswalk_tile::asphalt;
                            mark = std::max( mark, stripe );
                        } else if( along >= 5 && along < 6 ) {
                            mark = std::max( mark, across < -1 ? crosswalk_tile::stop_line :
                                             crosswalk_tile::asphalt );
                        }
                    }
                }
            }
        }
    }
    for( std::size_t i = 0; i < marks.size(); ++i ) {
        if( clear_markings[i] && marks[i] == crosswalk_tile::none ) {
            marks[i] = crosswalk_tile::junction;
        }
    }
    return marks;
}

void place_wide_highway_surface( mapgendata &dat )
{
    const oter_id terrain = dat.terrain_type();
    if( dat.zlevel() != 0 || ( terrain->get_type_id() != oter_type_road &&
                               terrain != oter_atlas_highway_north_south &&
                               terrain != oter_atlas_highway_east_west ) || !active() ) {
        return;
    }
    struct lane_sample {
        unsigned lanes = 0;
        int half_width = 0;
        double distance = 0;
        double along = 0;
        point_abs_ms center;
        bool controlled_access = false;
        bool ramp = false;
    };
    std::array<lane_sample, road_span *road_span> surface{};
    std::array<double, road_span *road_span> grade_sum{};
    std::array<double, road_span *road_span> grade_weight{};
    const point halo( wide_highway_halo, wide_highway_halo );
    const bool mapped = dat.region.place_roads || dat.region.overmap_highway.has_value();
    const bool arterials = dat.region.city_spec && dat.region.get_settings_city().city_size > 0;
    const bool ordinary_road = terrain->get_type_id() == oter_type_road;
    const road_cell road = ordinary_road ? road_network( dat.pos().xy(), 1, 1 ).front() : road_cell{};
    const std::size_t wide_links = ( arterials ? road.arterial_connections : 0 ) |
                                   ( mapped ? road.mapped_wide_connections : 0 );
    if( ordinary_road && !( mapped && road.mapped_wide_connections ) ) {
        bool has_flank = false;
        bool missing_neighbor = false;
        for( int y = -1; y <= 1 && !has_flank; ++y ) {
            for( int x = -1; x <= 1 && !has_flank; ++x ) {
                if( x == 0 && y == 0 ) {
                    continue;
                }
                const oter_id &neighbor = overmap_buffer.ter_existing( dat.pos() + point( x, y ) );
                has_flank = neighbor == oter_atlas_highway_north_south ||
                            neighbor == oter_atlas_highway_east_west ||
                            ( neighbor && ( neighbor->get_type_id() == oter_type_bridgehead_ground ||
                                            neighbor->get_type_id() == oter_type_bridge ) );
                missing_neighbor = missing_neighbor || !neighbor;
            }
        }
        // Keep stock pavement if the overmap reserved no adjoining wide-road tiles.
        if( !has_flank && !( missing_neighbor && wide_links ) ) {
            return;
        }
    }
    const bool only_wide_links = wide_links != 0 && ( terrain->get_line() & ~wide_links ) == 0;
    const bool urban = terrain->has_flag( oter_flags::has_sidewalk ) ||
                       in_urban_footprint( dat.pos().xy() ) || overmap_buffer.is_in_city( dat.pos() ) ||
                       road.street != urban_road::none;
    const bool grade_surface = elevation_active();
    std::optional<wide_bridge_query> bridge_grades;
    if( grade_surface ) {
        bridge_grades.emplace( dat.pos().xy(), mapped, arterials );
    }
    bool found = false;
    visit_wide_routes( dat.pos().xy() - halo, 2 * halo.x + 1, 2 * halo.y + 1, mapped, arterials, true,
    [&]( const wide_route & route ) {
        const highway_stroke stroke = make_highway_stroke( route );
        const point offset = dat.pos().xy().raw() * road_span - route.begin;
        const int corridor = stroke.half_width + highway_shoulder;
        if( highway_distance( stroke, offset.x + SEEX, offset.y + SEEY ) >=
            corridor + std::hypot( SEEX, SEEY ) ) {
            return;
        }
        for( int row = 0; row < road_span; ++row ) {
            for( int column = 0; column < road_span; ++column ) {
                const double east = offset.x + column + 0.5;
                const double south = offset.y + row + 0.5;
                const double distance = highway_distance( stroke, east, south );
                lane_sample &cell = surface[row * road_span + column];
                const bool paved = distance < stroke.half_width;
                const bool existing_paved = cell.lanes > 0 && cell.distance < cell.half_width;
                const bool preferred = route.controlled_access != cell.controlled_access ?
                                       route.controlled_access : paved != existing_paved ? paved :
                                       route.lanes != cell.lanes ? route.lanes > cell.lanes : distance < cell.distance;
                if( distance < corridor ) {
                    const double along = std::clamp( east * stroke.east + south * stroke.south,
                                                     0.0, stroke.length );
                    const point center = route.begin + point(
                                             static_cast<int>( std::lround( along * stroke.east ) ),
                                             static_cast<int>( std::lround( along * stroke.south ) ) );
                    if( grade_surface ) {
                        const double weight = ( corridor - distance ) * ( corridor - distance );
                        grade_sum[row * road_span + column] += weight * wide_road_height(
                                point_abs_ms( center ), project_to<coords::ms>( dat.pos().xy() ) +
                                point( column, row ), mapped, arterials, &route, &*bridge_grades );
                        grade_weight[row * road_span + column] += weight;
                    }
                    if( cell.lanes == 0 || preferred ) {
                        const double station = east * stroke.east + south * stroke.south;
                        cell = { route.lanes, stroke.half_width, distance,
                                 station + route.begin.x *stroke.east + route.begin.y * stroke.south,
                                 point_abs_ms( center ), route.controlled_access, route.ramp
                               };
                    }
                    found = true;
                }
            }
        }
    } );
    if( !found ) {
        return;
    }
    const bool needs_crosswalks = urban && std::any_of( surface.begin(), surface.end(),
    []( const lane_sample & sample ) {
        return sample.lanes > 0 && !sample.controlled_access && !sample.ramp &&
               sample.distance < sample.half_width;
    } );
    const auto crosswalks = needs_crosswalks ? wide_urban_crosswalks( dat.pos(), mapped, arterials ) :
                            std::array<crosswalk_tile, road_span *road_span> {};
    for( int row = 0; row < road_span; ++row ) {
        for( int column = 0; column < road_span; ++column ) {
            const point_bub_ms pos( column, row );
            const lane_sample &sample = surface[row * road_span + column];
            if( only_wide_links && ( sample.lanes == 0 ||
                                     sample.distance >= sample.half_width ) ) {
                const ter_id ground = dat.m.ter( pos );
                if( ground == ter_t_pavement || ground == ter_t_pavement_y ||
                    ground == ter_t_atlas_pavement_white || ground == ter_t_sidewalk ) {
                    dat.m.ter_set( pos, ter_t_grass.id() );
                }
            }
            if( sample.lanes == 0 ) {
                continue;
            }
            const int half_width = sample.half_width;
            const double elevation = grade_weight[row * road_span + column] > 0 ?
                                     grade_sum[row * road_span + column] / grade_weight[row * road_span + column] : 0;
            const int stripe = static_cast<int>( sample.distance );
            const tripoint_bub_ms tile( pos, 0 );
            if( stripe >= half_width && sample.controlled_access ) {
                dat.m.ter_set( pos, ter_t_sidewalk.id() );
                if( dat.m.has_furn( pos ) && dat.m.furn( pos ) != furn_f_street_light ) {
                    dat.m.furn_set( pos, furn_str_id::NULL_ID().id() );
                }
                if( grade_surface ) {
                    dat.m.set_surface_grade( tile, {
                        static_cast<int>( std::lround( elevation * 100.0 ) ), 0
                    } );
                }
                continue;
            }
            if( stripe >= half_width ) {
                const ter_id ground = dat.m.ter( pos );
                const bool verge = ground == ter_t_grass || ground == ter_t_sidewalk;
                if( urban && verge ) {
                    dat.m.ter_set( pos, ter_t_sidewalk.id() );
                    if( grade_surface ) {
                        dat.m.set_surface_grade( tile, {
                            static_cast<int>( std::lround( elevation * 100.0 ) ), 0
                        } );
                    }
                }
                const int marker = static_cast<int>( std::floor( sample.along ) );
                const int period = urban ? road_span : 2 * road_span;
                if( !sample.ramp && stripe == half_width + ( urban ? 1 : 0 ) && marker % period == 0 &&
                    verge && !dat.m.has_furn( pos ) ) {
                    dat.m.furn_set( pos, furn_f_street_light.id() );
                }
                continue;
            }
            const bool dashed = static_cast<int>( std::abs( sample.along ) ) % 6 < 3;
            const crosswalk_tile crossing = sample.controlled_access ? crosswalk_tile::none :
                                            crosswalks[row * road_span + column];
            const ter_id pavement = crossing == crosswalk_tile::zebra ? ter_t_zebra.id() :
                                    crossing == crosswalk_tile::stop_line ? ter_t_pavement_y.id() :
                                    crossing != crosswalk_tile::none ? ter_t_pavement.id() :
                                    highway_lane_surface( sample.lanes, stripe, dashed, sample.controlled_access,
                                            false, sample.half_width, sample.ramp );
            if( sample.controlled_access ? dat.m.has_furn( pos ) :
                dat.m.furn( pos ) == furn_f_street_light ) {
                dat.m.furn_set( pos, furn_str_id::NULL_ID().id() );
            }
            dat.m.ter_set( pos, pavement );
            if( grade_surface ) {
                dat.m.set_surface_grade( tile, {
                    static_cast<int>( std::lround( elevation * 100.0 ) ), 0
                } );
            }
        }
    }
}

std::vector<road_cell> road_network( point_abs_omt origin, int width, int height,
                                     bool include_local_streets )
{
    std::vector<road_cell> roads( width * height );
    const auto set_link = [&roads, width, height]( point p, point q, unsigned lanes,
    urban_road street = urban_road::none ) {
        if( p.x < 0 || p.y < 0 || p.x >= width || p.y >= height ) {
            return;
        }
        const point delta = q - p;
        const om_direction::type direction = delta.x > 0 ? om_direction::type::east :
                                             delta.x < 0 ? om_direction::type::west :
                                             delta.y > 0 ? om_direction::type::south : om_direction::type::north;
        road_cell &cell = roads[p.y * width + p.x];
        cell.connections = om_lines::set_segment( cell.connections, direction );
        if( street == urban_road::none ) {
            cell.lanes = std::max( cell.lanes, lanes );
            cell.mapped_connections = om_lines::set_segment( cell.mapped_connections, direction );
            if( lanes >= 4 ) {
                cell.mapped_wide_connections = om_lines::set_segment( cell.mapped_wide_connections, direction );
                unsigned &road_lanes = cell.mapped_lanes[static_cast<std::size_t>( direction )];
                road_lanes = std::max( road_lanes, lanes );
            }
        } else {
            cell.street = std::max( cell.street, street );
            if( street == urban_road::arterial ) {
                cell.arterial_connections = om_lines::set_segment( cell.arterial_connections, direction );
            }
        }
    };
    const point first = origin.raw();
    visit_roads( first - point::south_east, first + point( width,
    height ), [&]( const road_segment & s ) {
        visit_road_raster( s.begin, s.end, first - point::south_east,
        first + point( width, height ), [&]( point previous_absolute, point next_absolute ) {
            point previous = previous_absolute - first;
            const point next = next_absolute - first;
            if( next == previous ) {
                return;
            }
            if( next.x != previous.x && next.y != previous.y ) {
                const point corner( next.x, previous.y );
                set_link( previous, corner, s.lanes );
                set_link( corner, previous, s.lanes );
                previous = corner;
            }
            set_link( previous, next, s.lanes );
            set_link( next, previous, s.lanes );
        } );
    } );
    if( !include_local_streets ) {
        return roads;
    }
    // Cache ownership across the one-tile halo. Its geometry has to agree with
    // the separately generated overmap on the other side of every seam.
    const int stride = width + 2;
    struct urban_tile {
        const place *owner = nullptr;
        int density = 0;
    };
    std::vector<urban_tile> tiles( stride * ( height + 2 ) );
    const auto index = [stride]( point p ) {
        return ( p.y + 1 ) * stride + p.x + 1;
    };
    const point_abs_omt halo_origin = origin - point::south_east;
    const point_abs_om lo = project_to<coords::om>( halo_origin );
    const point_abs_om hi = project_to<coords::om>( origin + point( width, height ) );
    const int district_size = urban_district_size();
    const int radius = district_size / 2;
    std::unordered_map<const place *, street_layout> layouts;
    for( int y = lo.y(); y <= hi.y(); ++y ) {
        for( int x = lo.x(); x <= hi.x(); ++x ) {
            for( const urban_district &district : urban_districts_in( point_abs_om( x, y ) ) ) {
                const place *owner = &cities()[district.city_index];
                const point start = district.center.raw() - first - point( radius, radius );
                const point end = start + point( district_size, district_size );
                if( end.x <= -1 || end.y <= -1 || start.x > width || start.y > height ) {
                    continue;
                }
                if( layouts.find( owner ) == layouts.end() ) {
                    street_layout layout = layout_for( *owner );
                    layout.rows.seed = street_hash( owner->position.x() );
                    layout.columns.seed = street_hash( owner->position.y() );
                    layouts.emplace( owner, layout );
                }
                for( int row = std::max( start.y, -1 ); row < std::min( end.y, height + 1 ); ++row ) {
                    for( int col = std::max( start.x, -1 ); col < std::min( end.x, width + 1 ); ++col ) {
                        const point p( col, row );
                        tiles[index( p )] = { owner, urban_density( district, origin + p ) };
                    }
                }
            }
        }
    }
    if( layouts.empty() ) {
        return roads;
    }
    for( int y = -1; y < height; ++y ) {
        for( int x = -1; x < width; ++x ) {
            const point p( x, y );
            const place *owner = tiles[index( p )].owner;
            if( !owner ) {
                continue;
            }
            for( const point &delta : {
                     point::east, point::south
                 } ) {
                const point q = p + delta;
                const place *other = tiles[index( q )].owner;
                if( !other ) {
                    continue;
                }
                const bool east = delta.x != 0;
                const point absolute = first + p;
                urban_road street = urban_link( layouts.at( owner ), absolute - owner->position.raw(), east );
                if( owner != other ) {
                    street = std::max( street, urban_link( layouts.at( other ), absolute - other->position.raw(),
                                                           east ) );
                }
                const int density = std::min( tiles[index( p )].density, tiles[index( q )].density );
                const int minimum = street == urban_road::arterial ? 6 :
                                    street == urban_road::collector ? 13 : 24;
                if( street != urban_road::none && density >= minimum ) {
                    set_link( p, q, 0, street );
                    set_link( q, p, 0, street );
                }
            }
        }
    }
    return roads;
}

std::vector<unsigned> chart_roads( point_abs_omt origin, int width, int height, int stride )
{
    std::vector<unsigned> screen( width * height );
    const point first = origin.raw();
    const auto stamp = [&screen, width, height]( point p, unsigned lanes ) {
        if( p.x >= 0 && p.y >= 0 && p.x < width && p.y < height ) {
            auto &value = screen[p.y * width + p.x];
            value = std::max( value, lanes );
        }
    };
    visit_roads( first, first + point( width * stride - 1, height * stride - 1 ),
    [&]( const road_segment & s ) {
        if( stride >= 256 && s.lanes < 4 ) {
            return;
        }
        const point a = divide_xy_round_to_minus_infinity( s.begin - first, stride );
        const point b = divide_xy_round_to_minus_infinity( s.end - first, stride );
        stamp( a, s.lanes );
        for( const point &p : line_to( a, b ) ) {
            stamp( p, s.lanes );
        }
    } );
    return screen;
}

oter_id avenue_flank( bool north_south )
{
    return ( north_south ? oter_atlas_avenue_flank_ns : oter_atlas_avenue_flank_ew ).id();
}

bool is_avenue_flank( const oter_id &terrain )
{
    return terrain == avenue_flank( true ) || terrain == avenue_flank( false );
}

static const oter_id &road_neighbor( const mapgendata &dat, om_direction::type direction )
{
    return dat.neighbor_at( static_cast<om_direction::type>(
                                modulo( static_cast<int>( direction ) - dat.terrain_type()->get_rotation(), 4 ) ) );
}

static int taper_width( int edge, int interior, int distance, int length )
{
    const double t = std::clamp( static_cast<double>( distance ) / length, 0.0, 1.0 );
    return static_cast<int>( std::lround( edge + ( interior - edge ) * t * t * ( 3 - 2 * t ) ) );
}

static void spawn_atlas_street_vehicles( mapgendata &dat, bool north_south, bool east_west )
{
    if( !( north_south || east_west ) || !x_in_y( 67, 100 ) ) {
        return;
    }
    const nested_mapgen_id &pattern = north_south && east_west ?
                                      nested_mapgen_24x24_road_four_way_crossroad_vehicles_city :
                                      north_south ? nested_mapgen_24x24_road_straight_vehicles_city :
                                      nested_mapgen_24x24_road_straight_vehicles_city_ew;
    const auto it = nested_mapgens.find( pattern );
    if( it != nested_mapgens.end() ) {
        if( const auto *recipe = it->second.funcs().pick() ) {
            ( *recipe )->nest( dat, tripoint_rel_ms::zero, "atlas street vehicles" );
        }
    }
}

static bool draw_wide_avenue( mapgendata &dat )
{
    const oter_id terrain = dat.terrain_type();
    const bool flank = is_avenue_flank( terrain );
    const bool vertical = terrain == oter_road_ns || terrain == avenue_flank( true );
    if( !flank && terrain != oter_road_ns && terrain != oter_road_ew ) {
        return false;
    }
    const oter_id side = avenue_flank( vertical );
    const oter_id spine = vertical ? oter_road_ns : oter_road_ew;
    const point across_step = vertical ? point::east : point::south;
    const point along_step = vertical ? point::south : point::east;
    tripoint_abs_omt base = dat.pos();
    int offset = 0;
    if( flank ) {
        for( const int direction : {
                 -1, 1
                 } ) {
            for( int distance = 1; distance <= max_road_flanks; ++distance ) {
                const int from_flank = direction * distance;
                const tripoint_abs_omt candidate = dat.pos() + across_step * from_flank;
                const oter_id terrain_at = overmap_buffer.ter_existing( candidate );
                if( terrain_at == spine ) {
                    base = candidate;
                    offset = -from_flank;
                    break;
                }
                if( terrain_at != side ) {
                    break;
                }
            }
            if( offset != 0 ) {
                break;
            }
        }
    }
    const auto cross_section = [&]( const tripoint_abs_omt & p ) {
        std::array<int, 2> limits{};
        if( overmap_buffer.ter_existing( p ) == spine ) {
            for( int i = 0; i < 2; ++i ) {
                const int direction = i == 0 ? -1 : 1;
                while( std::abs( limits[i] ) < max_road_flanks &&
                       overmap_buffer.ter_existing( p + across_step * ( limits[i] + direction ) ) == side ) {
                    limits[i] += direction;
                }
            }
        }
        return limits;
    };
    const auto limits = cross_section( base );
    const auto same_width = [&]( int along ) {
        return cross_section( base + along_step * along ) == limits;
    };
    const int columns = limits[1] - limits[0] + 1;
    const bool highway = columns >= 3;
    const bool sidewalks = !highway || in_urban_footprint( dat.pos().xy() );
    const bool grade_surface = elevation_active();
    const point_abs_ms origin = project_to<coords::ms>( dat.pos().xy() );
    if( columns == 1 ) {
        if( flank ) {
            dat.m.draw_fill_background( ter_t_grass.id() );
        }
        return flank;
    }
    const bool continues_before = same_width( -1 );
    const bool continues_after = same_width( 1 );
    constexpr int span = SEEX * 2;
    constexpr int taper = span / 2 - 1;
    const int full_middle = ( limits[0] + limits[1] + 1 ) * span / 2;
    const int full_half_width = highway ? columns * span / 2 - 2 : 17;
    const int lanes_per_direction = highway ? columns : 2;
    const bool alternating = ( vertical ? base.y() : base.x() ) % 2 == 0;
    for( int along = 0; along < span; ++along ) {
        const int before = continues_before ? taper : along;
        const int after = continues_after ? taper : span - 1 - along;
        const int expansion = std::min( { taper, before, after } );
        // A contiguous wide cross-section. Each end tapers to the curb lines
        // and center stripe of the single-tile intersection it meets.
        const int middle = taper_width( SEEX, full_middle, expansion, taper );
        const int half_width = taper_width( 8, full_half_width, expansion, taper );
        const int pavement_start = middle - half_width;
        const int pavement_end = middle + half_width;
        const int lane_width = ( full_half_width - ( highway ? 3 : 0 ) ) / lanes_per_direction;
        const point_abs_ms centerline = origin + across_step * ( middle - offset * span ) +
                                        along_step * along;
        const int altitude = grade_surface ?
                             static_cast<int>( std::lround( surface_elevation( centerline ) * 100.0 ) ) : 0;
        for( int across = 0; across < span; ++across ) {
            const int position = across + offset * span;
            const int from_middle = std::abs( position - middle );
            ter_id ground = ter_t_grass.id();
            if( position >= pavement_start && position < pavement_end ) {
                if( position == middle - 1 || ( highway && position == middle ) ) {
                    ground = ter_t_pavement_y.id();
                } else if( from_middle > 0 && from_middle < lanes_per_direction * lane_width &&
                           from_middle < half_width - 2 && from_middle % lane_width == 0 &&
                           along % 6 < 3 ) {
                    ground = ter_t_atlas_pavement_white.id();
                } else {
                    ground = ter_t_pavement.id();
                }
            } else if( sidewalks && position >= pavement_start - 3 && position < pavement_end + 3 ) {
                ground = ter_t_sidewalk.id();
            }
            const point_bub_ms tile = vertical ? point_bub_ms( across, along ) :
                                      point_bub_ms( along, across );
            dat.m.ter_set( tile, ground );
            if( grade_surface && ground != ter_t_grass ) {
                dat.m.set_surface_grade( tripoint_bub_ms( tile, 0 ), { altitude, 0 } );
            }
        }
        if( expansion == taper && along == ( alternating ? 11 : 12 ) ) {
            const int curb = ( alternating ? pavement_start - 1 : pavement_end ) - offset * span;
            if( curb >= 0 && curb < span ) {
                const point_bub_ms lamp = vertical ? point_bub_ms( curb, along ) :
                                          point_bub_ms( along, curb );
                if( !dat.m.has_furn( lamp ) ) {
                    dat.m.furn_set( lamp, furn_f_street_light.id() );
                }
            }
        }
    }
    // The second tile shares the carriageway but generates separately.
    if( !flank && !highway ) {
        spawn_atlas_street_vehicles( dat, vertical, !vertical );
    }
    return true;
}

static std::vector<point> deck_centerline( std::size_t links )
{
    constexpr int center = SEEX;
    std::vector<point> endpoints;
    for( const auto direction : om_direction::all ) {
        if( om_lines::has_segment( links, direction ) ) {
            endpoints.push_back( point( center, center ) + center * om_direction::displace(
                                     direction ).raw() );
        }
    }
    const point middle( center, center );
    std::vector<point> curve;
    // Edge midpoints and tangents agree with vanilla decks and bridgehead ramps.
    if( endpoints.size() == 2 && endpoints[0] + endpoints[1] != 2 * middle ) {
        for( int i = 0; i <= 32; ++i ) {
            const double t = i / 32.0;
            const double a = ( 1.0 - t ) * ( 1.0 - t );
            const double b = 2.0 * t * ( 1.0 - t );
            const double c = t * t;
            curve.emplace_back( std::lround( a * endpoints[0].x + b * center + c * endpoints[1].x ),
                                std::lround( a * endpoints[0].y + b * center + c * endpoints[1].y ) );
        }
    } else {
        for( const point &endpoint : endpoints ) {
            curve.insert( curve.end(), 1, middle );
            const auto arm = line_to( middle, endpoint );
            curve.insert( curve.end(), arm.begin(), arm.end() );
        }
    }
    return curve;
}

static void draw_bridge_water( mapgendata &dat )
{
    if( dat.has_predecessor() && dat.last_predecessor()->is_water() ) {
        const oter_id predecessor = dat.last_predecessor();
        mapgendata water_dat( dat, predecessor );
        water_dat.pop_last_predecessor();
        if( run_mapgen_func( predecessor->get_mapgen_id(), water_dat ) ) {
            return;
        }
    }
    dat.m.draw_fill_background( ter_t_water_moving_dp.id() );
}

static void draw_curve_support( mapgendata &dat, const oter_id &deck )
{
    draw_bridge_water( dat );
    const auto curve = deck_centerline( deck->get_line() );
    if( !curve.empty() ) {
        const point pier = curve[curve.size() / 2];
        dat.m.draw_square_ter( ter_t_concrete_wall.id(), point_bub_ms( pier - point::south_east ),
                               point_bub_ms( pier + point::south_east ), dat.zlevel() );
    }
}

static void draw_raised_deck( mapgendata &dat )
{
    constexpr int span = 2 * SEEX;
    const auto curve = deck_centerline( dat.terrain_type()->get_line() );
    dat.m.draw_fill_background( ter_t_open_air.id() );
    for( int y = 0; y < span; ++y ) {
        for( int x = 0; x < span; ++x ) {
            const point tile( x, y );
            int distance = span * span;
            for( const point &sample : curve ) {
                const point offset = sample - tile;
                distance = std::min( distance, offset.x * offset.x + offset.y * offset.y );
            }
            if( distance <= 100 ) {
                const ter_str_id &terrain = distance == 0 && ( x + y ) % 6 < 3 ?
                                            ter_t_pavement_y_hw_air : distance < 81 ? ter_t_pavement_hw_air :
                                            distance < 93 ? ter_t_sidewalk_hw_air : ter_t_guardrail_hw_air;
                dat.m.ter_set( point_bub_ms( tile ), terrain.id() );
            }
        }
    }
}

static bool draw_wide_bridge( mapgendata &dat )
{
    static const oter_type_str_id bridge_road( "bridge_road" );
    const oter_type_str_id type = dat.terrain_type()->get_type_id();
    const bool bridge = type == oter_type_bridge || type == bridge_road ||
                        type == oter_type_atlas_raised_bridge_deck ||
                        type == oter_type_bridgehead_ground || type == oter_type_bridgehead_ramp;
    if( !bridge || dat.zlevel() < 0 || dat.zlevel() > 1 ) {
        return false;
    }
    const bool mapped = dat.region.place_roads || dat.region.overmap_highway.has_value();
    const bool arterials = dat.region.city_spec && dat.region.get_settings_city().city_size > 0;
    std::vector<wide_route> routes;
    const point halo( wide_highway_halo, wide_highway_halo );
    visit_wide_routes( dat.pos().xy() - halo, 2 * halo.x + 1, 2 * halo.y + 1,
    mapped, arterials, false, [&routes, &dat]( const wide_route & route ) {
        const highway_stroke stroke = make_highway_stroke( route );
        const point local = dat.pos().xy().raw() * road_span - route.begin;
        if( highway_distance( stroke, local.x + SEEX, local.y + SEEY ) <
            stroke.half_width + highway_shoulder + std::hypot( SEEX, SEEY ) ) {
            routes.push_back( route );
        }
    } );
    if( routes.empty() ) {
        return false;
    }
    const auto spans = wide_bridge_spans_at( dat.pos().xy(), mapped, arterials );
    const point_abs_ms origin = project_to<coords::ms>( dat.pos().xy() );
    const point center = origin.raw() + point( SEEX, SEEY );
    const auto selected = std::find_if( spans->begin(),
    spans->end(), [center]( const wide_bridge_span & span ) {
        return span.contains( center, std::hypot( SEEX, SEEY ) );
    } );
    if( selected == spans->end() ) {
        return false;
    }
    const wide_bridge_span &span = *selected;
    if( dat.zlevel() == 1 ) {
        dat.m.draw_fill_background( ter_t_open_air.id() );
    } else if( raster( dat.pos().xy(), 1, 1 ).front() != terrain::land ) {
        draw_bridge_water( dat );
    } else {
        dat.m.draw_fill_background( ter_t_grass.id() );
    }
    const double ramp_band = std::abs( span.east ) + std::abs( span.south );
    const auto inside = [&routes, &span, &dat, ramp_band]( point p ) {
        return std::any_of( routes.begin(), routes.end(), [p, &span, &dat,
           ramp_band]( const wide_route & route ) {
            if( span.overpass && ( dat.zlevel() == 1 ? !span.carries( route ) :
                                   span.carries( route ) && span.ramp_distance( p ) >= 2 * ramp_band ) ) {
                return false;
            }
            const highway_stroke stroke = make_highway_stroke( route );
            const point offset = p - route.begin;
            return highway_distance( stroke, offset.x + 0.5, offset.y + 0.5 ) <
                   stroke.half_width + highway_shoulder;
        } );
    };
    for( int y = 0; y < road_span; ++y ) {
        for( int x = 0; x < road_span; ++x ) {
            const point absolute = origin.raw() + point( x, y );
            const double ramp = span.ramp_distance( absolute );
            const wide_route *chosen = nullptr;
            double closest = std::numeric_limits<double>::max();
            double ground_sum = 0;
            double ground_weight = 0;
            for( const wide_route &route : routes ) {
                if( span.overpass && ( dat.zlevel() == 1 ? !span.carries( route ) :
                                       span.carries( route ) && ramp >= 2 * ramp_band ) ) {
                    continue;
                }
                const highway_stroke stroke = make_highway_stroke( route );
                const point offset = absolute - route.begin;
                const double distance = highway_distance( stroke, offset.x + 0.5, offset.y + 0.5 );
                const double corridor = stroke.half_width + highway_shoulder;
                if( elevation_active() && distance < corridor ) {
                    const double along = std::clamp( ( offset.x + 0.5 ) * stroke.east +
                                                     ( offset.y + 0.5 ) * stroke.south, 0.0, stroke.length );
                    const point projected = route.begin + point( std::lround( along * stroke.east ),
                                            std::lround( along * stroke.south ) );
                    const double weight = ( corridor - distance ) * ( corridor - distance );
                    ground_sum += weight * surface_elevation( point_abs_ms( projected ) );
                    ground_weight += weight;
                }
                const bool paved = distance < stroke.half_width;
                const bool existing_paved = chosen && closest < make_highway_stroke( *chosen ).half_width;
                const bool preferred = !chosen ? true :
                                       route.controlled_access != chosen->controlled_access ? route.controlled_access :
                                       paved != existing_paved ? paved : route.lanes != chosen->lanes ?
                                       route.lanes > chosen->lanes : distance < closest;
                if( distance < stroke.half_width + highway_shoulder && preferred ) {
                    chosen = &route;
                    closest = distance;
                }
            }
            if( !chosen ) {
                continue;
            }
            const bool upper = span.carries( *chosen );
            if( upper && ( dat.zlevel() == 0 ? ramp >= 2 * ramp_band : ramp < 0 ) ) {
                continue;
            }
            const highway_stroke stroke = make_highway_stroke( *chosen );
            const int stripe = static_cast<int>( closest );
            const bool roadway = stripe < stroke.half_width;
            const bool rail = !roadway && std::any_of( four_cardinal_directions.begin(),
            four_cardinal_directions.end(), [&inside, absolute]( point step ) {
                return !inside( absolute + step );
            } );
            const int station = static_cast<int>( std::abs( ( absolute.x + 0.5 ) * stroke.east +
                                                  ( absolute.y + 0.5 ) * stroke.south ) );
            const bool elevated = dat.zlevel() == 1;
            ter_id ground = rail ? ( elevated ? ter_t_guardrail_hw_air : ter_t_guardrail ).id() :
                            !roadway ? ( elevated ? ter_t_sidewalk_hw_air : ter_t_sidewalk ).id() :
                            highway_lane_surface( chosen->lanes, stripe, station % 6 < 3,
                                                  chosen->controlled_access, elevated, stroke.half_width, chosen->ramp );
            if( upper && ramp >= 0 && ramp < 2 * ramp_band && !rail &&
                !( chosen->controlled_access && stripe < 2 ) ) {
                const bool low = ramp < ramp_band;
                ground = ter_str_id( elevated ? ( low ? "t_ramp_down_low" : "t_ramp_down_high" ) :
                                     ( low ? "t_ramp_up_low" : "t_ramp_up_high" ) ).id();
            }
            const tripoint_bub_ms p( x, y, dat.zlevel() );
            dat.m.ter_set( p, ground );
            if( elevation_active() ) {
                const double ground_height = ground_sum / ground_weight;
                const double height = ( upper ? span.height_at( absolute, ground_height ) : ground_height ) -
                                      dat.zlevel() * floor_height_m;
                dat.m.set_surface_grade( p, { static_cast<int>( std::lround( height * 100 ) ), 0 } );
            }
        }
    }
    return true;
}

bool draw_mapped_road( mapgendata &dat )
{
    if( !active() ) {
        return false;
    }
    const oter_type_str_id type = dat.terrain_type()->get_type_id();
    if( draw_wide_bridge( dat ) ) {
        return true;
    }
    if( dat.zlevel() == 1 && type == oter_type_atlas_raised_bridge_deck ) {
        draw_raised_deck( dat );
        return true;
    }
    if( dat.zlevel() <= 0 && type == oter_type_bridge ) {
        const oter_id deck = overmap_buffer.ter_existing( tripoint_abs_omt( dat.pos().xy(), 1 ) );
        if( deck->get_type_id() == oter_type_atlas_raised_bridge_deck ) {
            draw_curve_support( dat, deck );
            return true;
        }
    }
    if( dat.zlevel() != 0 ) {
        return false;
    }
    if( dat.terrain_type() == oter_atlas_highway_north_south ||
        dat.terrain_type() == oter_atlas_highway_east_west ) {
        dat.m.draw_fill_background( ter_t_grass.id() );
        return true;
    }
    if( draw_wide_avenue( dat ) ) {
        return true;
    }
    if( type != oter_type_atlas_road_bridge ) {
        return false;
    }
    const auto neighbors = road_network( dat.pos().xy() - point::south_east, 3, 3 );
    const road_cell &cell = neighbors[4];
    const std::size_t links = dat.terrain_type()->get_line();
    draw_bridge_water( dat );

    const auto width_for = []( const road_cell & c ) {
        if( c.street == urban_road::arterial && c.lanes <= 4 ) {
            return 9;
        }
        if( c.lanes < 4 ) {
            return 8;
        }
        return static_cast<int>( c.lanes ) * ( c.lanes == 12 ? 2 : 3 ) / 2;
    };
    const bool north = om_lines::has_segment( links, om_direction::type::north );
    const bool east = om_lines::has_segment( links, om_direction::type::east );
    const bool south = om_lines::has_segment( links, om_direction::type::south );
    const bool west = om_lines::has_segment( links, om_direction::type::west );
    constexpr int center = SEEX;
    const int lane_width = cell.street == urban_road::arterial && cell.lanes <= 4 ? 4 :
                           cell.lanes == 12 ? 2 : 3;
    const int half_width = std::min( width_for( cell ), center - 3 );
    constexpr int sidewalk_width = 2;
    std::array<int, 4> edge_width{};
    for( const auto dir : om_direction::all ) {
        const point delta = om_direction::displace( dir ).raw();
        const road_cell &other = neighbors[4 + delta.y * 3 + delta.x];
        const oter_id &adjacent = road_neighbor( dat, dir );
        int width = 8;
        // Match the original 16-tile street and the narrow end of an avenue.
        // Keep the wider cross-section across uninterrupted highway or bridge spans.
        if( adjacent->get_type_id() == oter_type_atlas_road_bridge ) {
            width = std::min( half_width, width_for( other ) );
        }
        edge_width[static_cast<int>( dir )] = width;
    }
    const bool junction = static_cast<int>( north ) + east + south + west >= 3;
    const auto surface = [&]( int across, int along, int width ) {
        if( junction &&
            ( along == 2 || along == 2 * center - 3 ) && across % 2 == 0 ) {
            return ter_t_atlas_pavement_white.id();
        }
        if( across == center - 1 ) {
            return ter_t_pavement_y.id();
        }
        if( across > center - width && across < center + width - 1 && across != center &&
            ( across - center ) % lane_width == 0 && along % 6 < 3 ) {
            return ter_t_atlas_pavement_white.id();
        }
        return ter_t_pavement.id();
    };
    const auto in_arm = []( int across, int along, int width, bool negative, bool positive ) {
        return across >= center - width && across < center + width &&
               ( ( negative && along < center + width ) || ( positive && along >= center - width ) );
    };
    std::array<int, 2 * SEEY> vertical_width{};
    std::array<int, 2 * SEEX> horizontal_width{};
    for( int i = 0; i < center; ++i ) {
        vertical_width[i] = taper_width( edge_width[0], half_width, i, center - 1 );
        vertical_width[2 * center - 1 - i] = taper_width( edge_width[2], half_width, i, center - 1 );
        horizontal_width[i] = taper_width( edge_width[3], half_width, i, center - 1 );
        horizontal_width[2 * center - 1 - i] = taper_width( edge_width[1], half_width, i, center - 1 );
    }
    for( int y = 0; y < 2 * SEEY; ++y ) {
        for( int x = 0; x < 2 * SEEX; ++x ) {
            const int vy = vertical_width[y];
            const int hx = horizontal_width[x];
            const bool vertical = in_arm( x, y, vy, north, south );
            const bool horizontal = in_arm( y, x, hx, west, east );
            const bool has_sidewalk = in_arm( x, y, vy + sidewalk_width, north, south ) ||
                                      in_arm( y, x, hx + sidewalk_width, west, east );
            const int barrier = sidewalk_width + 1;
            const bool has_rail = in_arm( x, y, vy + barrier, north, south ) ||
                                  in_arm( y, x, hx + barrier, west, east );
            if( vertical || horizontal || has_sidewalk || has_rail ) {
                const ter_id ground = vertical && horizontal ? ter_t_pavement.id() :
                                      vertical ? surface( x, y, vy ) : horizontal ? surface( y, x, hx ) :
                                      has_sidewalk ? ter_t_sidewalk.id() : ter_t_guardrail.id();
                dat.m.ter_set( point_bub_ms( x, y ), ground );
            }
        }
    }
    return true;
}

void connect_wide_road_driveways( mapgendata &dat )
{
    const oter_id terrain = dat.terrain_type();
    if( !active() || dat.zlevel() != 0 || terrain->is_road() ||
        terrain->has_flag( oter_flags::bridge ) ) {
        return;
    }
    const bool mapped = dat.region.place_roads || dat.region.overmap_highway.has_value();
    const bool arterials = dat.region.city_spec && dat.region.get_settings_city().city_size > 0;
    const auto paved = []( ter_id ground ) {
        return ground == ter_t_pavement || ground == ter_t_pavement_y ||
               ground == ter_t_atlas_pavement_white;
    };
    bool has_driveway = false;
    for( int y = 0; y < road_span && !has_driveway; ++y ) {
        for( int x = 0; x < road_span && !has_driveway; ++x ) {
            has_driveway = paved( dat.m.ter( point_bub_ms( x, y ) ) );
        }
    }
    if( !has_driveway || ( !mapped && !arterials ) ) {
        return;
    }
    const point halo( wide_highway_halo, wide_highway_halo );
    std::vector<wide_route> streets;
    visit_wide_routes( dat.pos().xy() - halo, 2 * halo.x + 1, 2 * halo.y + 1,
    mapped, arterials, true, [&streets]( const wide_route & route ) {
        if( !route.controlled_access ) {
            streets.push_back( route );
        }
    } );
    if( streets.empty() ) {
        return;
    }
    const point_abs_ms origin = project_to<coords::ms>( dat.pos().xy() );
    const auto clear = [&dat, &paved]( point p ) {
        const tripoint_bub_ms tile( p.x, p.y, 0 );
        const ter_id ground = dat.m.ter( tile );
        return !dat.m.has_furn( tile ) &&
               ( paved( ground ) || ground == ter_t_sidewalk ||
                 ( ground->has_flag( ter_furn_flag::TFLAG_DIGGABLE ) &&
                   !ground->has_flag( ter_furn_flag::TFLAG_TREE ) &&
                   !ground->has_flag( ter_furn_flag::TFLAG_SHRUB ) && dat.m.passable( tile ) ) );
    };
    for( const om_direction::type direction : om_direction::all ) {
        const point outward = om_direction::displace( direction ).raw();
        const oter_id &neighbor = overmap_buffer.ter_existing( dat.pos() + outward );
        if( !neighbor || ( neighbor->get_type_id() != oter_type_road &&
                           neighbor != oter_atlas_highway_north_south &&
                           neighbor != oter_atlas_highway_east_west ) ) {
            continue;
        }
        const auto at = [outward]( int across, int depth ) {
            return outward.x ? point( outward.x < 0 ? depth : road_span - 1 - depth, across ) :
                   point( across, outward.y < 0 ? depth : road_span - 1 - depth );
        };
        std::array<int, road_span> entry;
        entry.fill( -1 );
        for( int across = 0; across < road_span; ++across ) {
            for( int depth = 0; depth <= 6; ++depth ) {
                if( !clear( at( across, depth ) ) ) {
                    break;
                }
                if( paved( dat.m.ter( point_bub_ms( at( across, depth ) ) ) ) &&
                    paved( dat.m.ter( point_bub_ms( at( across, depth + 1 ) ) ) ) &&
                    paved( dat.m.ter( point_bub_ms( at( across, depth + 2 ) ) ) ) &&
                    clear( at( across, depth + 1 ) ) && clear( at( across, depth + 2 ) ) ) {
                    entry[across] = depth + 2;
                    break;
                }
            }
        }
        for( int first = 0; first < road_span; ) {
            if( entry[first] < 0 ) {
                ++first;
                continue;
            }
            int end = first;
            while( end < road_span && entry[end] >= 0 ) {
                ++end;
            }
            const int width = std::min( 6, end - first );
            const int begin = first + ( end - first - width ) / 2;
            first = end;
            if( width < 3 ) {
                continue;
            }
            const point outside = origin.raw() + at( begin + width / 2, 0 ) + outward * 4;
            double nearest = std::numeric_limits<double>::max();
            std::optional<point> road_center;
            for( const wide_route &route : streets ) {
                const highway_stroke stroke = make_highway_stroke( route );
                const point offset = outside - route.begin;
                const double distance = highway_distance( stroke, offset.x, offset.y );
                if( distance < stroke.half_width + highway_shoulder && distance < nearest ) {
                    nearest = distance;
                    const double along = std::clamp( offset.x * stroke.east + offset.y * stroke.south,
                                                     0.0, stroke.length );
                    road_center = route.begin + point( std::lround( along * stroke.east ),
                                                       std::lround( along * stroke.south ) );
                }
            }
            if( !road_center ) {
                continue;
            }
            const double road_height = wide_road_height( point_abs_ms( *road_center ),
                                       point_abs_ms( outside ), mapped, arterials );
            for( int across = begin; across < begin + width; ++across ) {
                const int interior = entry[across];
                const point inside = at( across, interior );
                const double lot_height = altitude_at( dat.m, tripoint_bub_ms( inside.x, inside.y, 0 ) );
                for( int depth = 0; depth <= interior; ++depth ) {
                    const point p = at( across, depth );
                    dat.m.ter_set( point_bub_ms( p ), ter_t_pavement.id() );
                    if( elevation_active() ) {
                        const double fraction = static_cast<double>( depth + 4 ) / ( interior + 4 );
                        dat.m.set_surface_grade( tripoint_bub_ms( p.x, p.y, 0 ), {
                            static_cast<int>( std::lround( ( road_height + fraction *
                                                             ( lot_height - road_height ) ) * 100 ) ), 0
                        } );
                    }
                }
            }
        }
    }
}

} // namespace north_america
