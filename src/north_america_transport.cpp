#include "north_america_transport.h"

#include <algorithm>
#include <array>
#include <unordered_map>

#include "cata_utility.h"
#include "flexbuffer_json.h"
#include "line.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapgendata.h"
#include "north_america.h"
#include "omdata.h"
#include "overmap.h"
#include "path_info.h"
#include "rng.h"
#include "units.h"
#include "vehicle_group.h"

namespace north_america
{
namespace
{
constexpr int bucket_width = 256;

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

struct transport_atlas {
    std::vector<road_segment> segments;
    std::unordered_map<point, std::vector<std::size_t>> buckets;

    transport_atlas() {
        read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america.transport",
        [this]( const JsonValue & value ) {
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
        } );
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

std::vector<road_cell> road_network( point_abs_omt origin, int width, int height )
{
    std::vector<road_cell> roads( width * height );
    const auto set_link = [&roads, width, height]( point p, point q, unsigned lanes ) {
        if( p.x < 0 || p.y < 0 || p.x >= width || p.y >= height ) {
            return;
        }
        const point delta = q - p;
        const om_direction::type direction = delta.x > 0 ? om_direction::type::east :
                                             delta.x < 0 ? om_direction::type::west :
                                             delta.y > 0 ? om_direction::type::south : om_direction::type::north;
        road_cell &cell = roads[p.y * width + p.x];
        cell.lanes = std::max( cell.lanes, lanes );
        cell.connections = om_lines::set_segment( cell.connections, direction );
    };
    const point first = origin.raw();
    visit_roads( first - point( 1, 1 ), first + point( width, height ), [&]( const road_segment & s ) {
        point previous = s.begin - first;
        for( const point &next_absolute : line_to( s.begin, s.end ) ) {
            const point next = next_absolute - first;
            if( next == previous ) {
                continue;
            }
            if( next.x != previous.x && next.y != previous.y ) {
                const point corner( next.x, previous.y );
                set_link( previous, corner, s.lanes );
                set_link( corner, previous, s.lanes );
                previous = corner;
            }
            set_link( previous, next, s.lanes );
            set_link( next, previous, s.lanes );
            previous = next;
        }
    } );
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

bool draw_mapped_road( mapgendata &dat )
{
    if( dat.zlevel() != 0 || !active() ||
        dat.terrain_type()->get_type_id().str() != "road" ) {
        return false;
    }
    const road_cell cell = road_network( dat.pos().xy(), 1, 1 ).front();
    if( cell.lanes < 4 ) {
        return false;
    }

    static const ter_str_id grass( "t_grass" );
    static const ter_str_id paving( "t_pavement" );
    static const ter_str_id yellow( "t_pavement_y" );
    static const ter_str_id white( "t_atlas_pavement_white" );
    const std::size_t links = dat.terrain_type()->get_line();
    const bool north = om_lines::has_segment( links, om_direction::type::north );
    const bool east = om_lines::has_segment( links, om_direction::type::east );
    const bool south = om_lines::has_segment( links, om_direction::type::south );
    const bool west = om_lines::has_segment( links, om_direction::type::west );
    const int center = SEEX;
    // The twelve-lane cross section is compressed to fit one overmap tile.
    const int lane_width = cell.lanes == 12 ? 2 : 3;
    const int half_width = static_cast<int>( cell.lanes ) * lane_width / 2;
    const auto surface = [&]( int across, int along ) {
        if( across == center - 1 ) {
            return yellow.id();
        }
        if( across > center - half_width && across != center &&
            ( across - center ) % lane_width == 0 && along % 6 < 3 ) {
            return white.id();
        }
        return paving.id();
    };
    for( int y = 0; y < 2 * SEEY; ++y ) {
        for( int x = 0; x < 2 * SEEX; ++x ) {
            const bool vertical = x >= center - half_width && x < center + half_width &&
                                  ( ( north && y < center + half_width ) ||
                                    ( south && y >= center - half_width ) );
            const bool horizontal = y >= center - half_width && y < center + half_width &&
                                    ( ( west && x < center + half_width ) ||
                                      ( east && x >= center - half_width ) );
            const ter_id ground = vertical && horizontal ? paving.id() :
                                  vertical ? surface( x, y ) : horizontal ? surface( y, x ) : grass.id();
            dat.m.ter_set( point_bub_ms( x, y ), ground );
        }
    }
    if( one_in( 10 ) && ( ( north && south && !east && !west ) ||
                          ( east && west && !north && !south ) ) ) {
        static const vgroup_id highway( "highway" );
        const bool heading_positive = one_in( 2 );
        const int side = heading_positive ? -lane_width : lane_width;
        const tripoint_bub_ms where( north ? center + side : center,
                                     north ? center : center - side, 0 );
        const units::angle heading = north ? ( heading_positive ? 90_degrees : 270_degrees ) :
                                     ( heading_positive ? 0_degrees : 180_degrees );
        dat.m.add_vehicle( highway->pick(), where, heading, -1, veh_spawn_status::DISABLED );
    }
    return true;
}

} // namespace north_america
