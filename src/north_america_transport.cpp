#include "north_america_transport.h"

#include <weighted_list.h>
#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <initializer_list>
#include <map>
#include <memory>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>

#include "cata_path.h"
#include "cata_utility.h"
#include "coordinates.h"
#include "enums.h"
#include "flexbuffer_json.h"
#include "line.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapgen.h"
#include "mapgen_functions.h"
#include "mapgendata.h"
#include "north_america.h"
#include "north_america_ecology.h"
#include "omdata.h"
#include "overmap.h"
#include "path_info.h"
#include "point.h"
#include "rng.h"
#include "type_id.h"
#include "units.h"
#include "vehicle_group.h"

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

static const oter_type_str_id oter_type_atlas_road_bridge( "atlas_road_bridge" );
static const oter_type_str_id oter_type_road( "road" );

static const ter_str_id ter_t_atlas_pavement_white( "t_atlas_pavement_white" );
static const ter_str_id ter_t_grass( "t_grass" );
static const ter_str_id ter_t_guardrail( "t_guardrail" );
static const ter_str_id ter_t_pavement( "t_pavement" );
static const ter_str_id ter_t_pavement_y( "t_pavement_y" );
static const ter_str_id ter_t_sidewalk( "t_sidewalk" );
static const ter_str_id ter_t_water_moving_dp( "t_water_moving_dp" );

static const vgroup_id VehicleGroup_highway( "highway" );

namespace north_america
{
namespace
{
constexpr int bucket_width = 256;

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
        } else {
            cell.street = std::max( cell.street, street );
        }
    };
    const point first = origin.raw();
    visit_roads( first - point::south_east, first + point( width,
    height ), [&]( const road_segment & s ) {
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
    // Straight road mapgen rotates its neighbor array so the direction of
    // travel is always north/south and the flank is always to its right.
    if( !flank && dat.east() != side ) {
        return false;
    }
    const bool continues_before = ( flank ? ( vertical ? dat.north() : dat.west() ) :
                                    ( vertical ? dat.neast() : dat.seast() ) ) == side;
    const bool continues_after = ( flank ? ( vertical ? dat.south() : dat.east() ) :
                                   ( vertical ? dat.seast() : dat.neast() ) ) == side;
    constexpr int span = SEEX * 2;
    constexpr int taper = span / 2 - 1;
    for( int along = 0; along < span; ++along ) {
        const int before = continues_before ? taper : along;
        const int after = continues_after ? taper : span - 1 - along;
        const int expansion = std::min( { taper, before, after } );
        // A contiguous wide cross-section. Each end tapers to the curb lines
        // and center stripe of the single-tile intersection it meets.
        const int middle = taper_width( SEEX, 2 * SEEX, expansion, taper );
        const int half_width = taper_width( 8, 17, expansion, taper );
        const int pavement_start = middle - half_width;
        const int pavement_end = middle + half_width;
        for( int across = 0; across < span; ++across ) {
            const int position = across + ( flank ? span : 0 );
            ter_id ground = ter_t_grass.id();
            if( position >= pavement_start && position < pavement_end ) {
                if( position == middle - 1 ) {
                    ground = ter_t_pavement_y.id();
                } else if( along % 6 < 3 && ( position == middle - half_width / 2 ||
                                              position == middle + half_width / 2 ) ) {
                    ground = ter_t_atlas_pavement_white.id();
                } else {
                    ground = ter_t_pavement.id();
                }
            } else if( position >= pavement_start - 3 && position < pavement_end + 3 ) {
                ground = ter_t_sidewalk.id();
            }
            dat.m.ter_set( vertical ? point_bub_ms( across, along ) : point_bub_ms( along, across ),
                           ground );
        }
    }
    // The second tile shares the carriageway but generates separately.
    if( !flank ) {
        spawn_atlas_street_vehicles( dat, vertical, !vertical );
    }
    return true;
}

bool draw_mapped_road( mapgendata &dat )
{
    if( dat.zlevel() != 0 || !active() ) {
        return false;
    }
    if( draw_wide_avenue( dat ) ) {
        return true;
    }
    const oter_type_str_id type = dat.terrain_type()->get_type_id();
    const bool on_bridge = type == oter_type_atlas_road_bridge;
    if( type != oter_type_road && !on_bridge ) {
        return false;
    }
    const auto neighbors = road_network( dat.pos().xy() - point::south_east, 3, 3 );
    const road_cell &cell = neighbors[4];
    const bool boulevard = cell.street == urban_road::arterial && cell.lanes <= 4;
    const bool collector = cell.street == urban_road::collector && cell.lanes < 4;
    if( cell.lanes < 4 && !boulevard && !collector && !on_bridge ) {
        return false;
    }

    if( on_bridge ) {
        bool has_water = false;
        if( dat.has_predecessor() && dat.last_predecessor()->is_water() ) {
            const oter_id predecessor = dat.last_predecessor();
            mapgendata water_dat( dat, predecessor );
            water_dat.pop_last_predecessor();
            has_water = run_mapgen_func( predecessor->get_mapgen_id(), water_dat );
        }
        if( !has_water ) {
            dat.m.draw_fill_background( ter_t_water_moving_dp.id() );
        }
    }

    const auto width_for = []( const road_cell & c ) {
        if( c.street == urban_road::arterial && c.lanes <= 4 ) {
            return 9;
        }
        if( c.lanes < 4 ) {
            return 8;
        }
        return static_cast<int>( c.lanes ) * ( c.lanes == 12 ? 2 : 3 ) / 2;
    };
    const std::size_t links = dat.terrain_type()->get_line();
    const bool north = om_lines::has_segment( links, om_direction::type::north );
    const bool east = om_lines::has_segment( links, om_direction::type::east );
    const bool south = om_lines::has_segment( links, om_direction::type::south );
    const bool west = om_lines::has_segment( links, om_direction::type::west );
    constexpr int center = SEEX;
    const int lane_width = boulevard ? 4 : cell.lanes == 12 ? 2 : 3;
    const int maximum_width = on_bridge ? center - 3 : center;
    const int half_width = std::min( width_for( cell ), maximum_width );
    const int sidewalk_width = on_bridge ? 2 : boulevard || collector ? 3 : 0;
    std::array<int, 4> edge_width{};
    for( const auto dir : om_direction::all ) {
        const point delta = om_direction::displace( dir ).raw();
        const road_cell &other = neighbors[4 + delta.y * 3 + delta.x];
        const oter_id &adjacent = road_neighbor( dat, dir );
        int width = 8;
        // Match the original 16-tile street and the narrow end of an avenue.
        // Keep the wider cross-section across uninterrupted highway or bridge spans.
        if( on_bridge && adjacent->get_type_id() == oter_type_atlas_road_bridge ) {
            width = std::min( { half_width, width_for( other ), center - 3 } );
        } else if( !on_bridge && adjacent->get_type_id() == oter_type_road &&
                   cell.street == urban_road::none && other.street == urban_road::none &&
                   cell.lanes >= 4 && other.lanes >= 4 ) {
            width = std::min( half_width, width_for( other ) );
        }
        edge_width[static_cast<int>( dir )] = width;
    }
    const bool junction = static_cast<int>( north ) + east + south + west >= 3;
    const auto surface = [&]( int across, int along, int width ) {
        if( sidewalk_width && junction &&
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
            const bool has_rail = on_bridge &&
                                  ( in_arm( x, y, vy + barrier, north, south ) ||
                                    in_arm( y, x, hx + barrier, west, east ) );
            if( vertical || horizontal || has_sidewalk || has_rail || !on_bridge ) {
                const ter_id ground = vertical && horizontal ? ter_t_pavement.id() :
                                      vertical ? surface( x, y, vy ) : horizontal ? surface( y, x, hx ) :
                                      has_sidewalk ? ter_t_sidewalk.id() : has_rail ? ter_t_guardrail.id() : ter_t_grass.id();
                dat.m.ter_set( point_bub_ms( x, y ), ground );
            }
        }
    }
    if( !on_bridge && ( boulevard || collector ) ) {
        spawn_atlas_street_vehicles( dat, north && south, east && west );
    } else if( !on_bridge && one_in( 10 ) && ( ( north && south && !east &&
               !west ) || ( east && west && !north && !south ) ) ) {
        const bool heading_positive = one_in( 2 );
        const int side = heading_positive ? -lane_width : lane_width;
        const tripoint_bub_ms where( north ? center + side : center,
                                     north ? center : center - side, 0 );
        const units::angle heading = north ? ( heading_positive ? 90_degrees : 270_degrees ) :
                                     ( heading_positive ? 0_degrees : 180_degrees );
        dat.m.add_vehicle( VehicleGroup_highway->pick(), where, heading, -1, veh_spawn_status::DISABLED );
    }
    return true;
}

} // namespace north_america
