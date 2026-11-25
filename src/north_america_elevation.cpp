#include "north_america_elevation.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <exception>
#include <filesystem>
#include <fstream>
#include <functional>
#include <limits>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>
#include <zconf.h>
#include <zlib.h>

#include "calendar.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "coordinates.h"
#include "debug.h"
#include "filesystem.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "mapgendata.h"
#include "native_file_path.h"
#include "north_america.h"
#include "omdata.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "point.h"
#include "regional_climate.h"
#include "submap.h"
#include "type_id.h"
#include "vehicle.h"
#include "vpart_position.h"

namespace north_america
{
namespace
{
constexpr int grid_width = 5671;
constexpr int grid_height = 2341;
constexpr std::size_t grid_bytes = 2 * grid_width * grid_height;
constexpr double south = 6.0 + 1.0 / 120.0;
constexpr double west = -195.0 + 1.0 / 120.0;
constexpr double samples_per_degree = 30.0;
constexpr double tropopause_m = 11000.0;
constexpr double lapse_rate = 0.0065;

bool read_compressed_grid( std::istream &input, std::vector<std::uint8_t> &bytes )
{
    z_stream stream{};
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wold-style-cast"
    const int initialized = inflateInit2( &stream, MAX_WBITS | 16 );
#pragma GCC diagnostic pop
    if( initialized != Z_OK ) {
        throw std::runtime_error( "could not initialize gzip elevation reader" );
    }
    const on_out_of_scope cleanup( [&stream]() {
        inflateEnd( &stream );
    } );
    std::array<Bytef, 32768> buffer;
    std::array<char, 8> signature{};
    Bytef extra;
    stream.next_out = reinterpret_cast<Bytef *>( signature.data() );
    stream.avail_out = signature.size();
    while( true ) {
        if( stream.avail_in == 0 ) {
            input.read( reinterpret_cast<char *>( buffer.data() ), buffer.size() );
            stream.next_in = buffer.data();
            stream.avail_in = static_cast<uInt>( input.gcount() );
        }
        const int result = inflate( &stream, Z_NO_FLUSH );
        if( result != Z_OK && result != Z_STREAM_END ) {
            throw std::runtime_error( stream.msg ? stream.msg : "incomplete gzip elevation data" );
        }
        if( stream.total_out > signature.size() + grid_bytes ) {
            return false;
        }
        if( stream.avail_out == 0 ) {
            if( bytes.empty() ) {
                if( std::string_view( signature.data(), signature.size() ) != "CCBDEM1\n" ) {
                    return false;
                }
                bytes.resize( grid_bytes );
                stream.next_out = bytes.data();
                stream.avail_out = static_cast<uInt>( bytes.size() );
            } else {
                // Leave room to consume the gzip trailer and detect excess output.
                stream.next_out = &extra;
                stream.avail_out = 1;
            }
        }
        if( result == Z_STREAM_END ) {
            return stream.total_out == signature.size() + grid_bytes;
        }
    }
}

struct elevation_grid {
    std::vector<std::uint8_t> bytes;

    elevation_grid() {
        const cata_path directory = PATH_INFO::datadir_path() / "raw";
        const cata_path compressed = directory / "north_america.elevation.gz";
        const cata_path path = file_exist( compressed ) ? compressed :
                               directory / "north_america.elevation";
        try {
            std::ifstream input( native_file_path( path.get_unrelative_path() ), std::ios::binary );
            if( !input ) {
                throw std::runtime_error( "opening elevation file failed" );
            }
            std::array<char, 2> header{};
            if( !input.read( header.data(), header.size() ) ) {
                return;
            }
            input.seekg( 0 );
            std::vector<std::uint8_t> data;
            if( header[0] == '\x1f' && header[1] == '\x8b' ) {
                if( read_compressed_grid( input, data ) ) {
                    bytes = std::move( data );
                }
                return;
            }
            std::array<char, 8> signature{};
            if( !input.read( signature.data(), signature.size() ) ||
                std::string_view( signature.data(), signature.size() ) != "CCBDEM1\n" ) {
                return;
            }
            data.resize( grid_bytes );
            if( input.read( reinterpret_cast<char *>( data.data() ), data.size() ) ) {
                bytes = std::move( data );
            }
        } catch( const std::exception &err ) {
            debugmsg( "Failed to read elevation data from \"%s\": %s",
                      path.generic_u8string().c_str(), err.what() );
        }
    }

    int elevation_at( const point &position ) const {
        const std::size_t index = 2 * ( position.y * grid_width + position.x );
        const int raw = bytes[index] | ( bytes[index + 1] << 8 );
        return raw < 32768 ? raw : raw - 65536;
    }
};

const elevation_grid &grid()
{
    static const elevation_grid data;
    return data;
}

double interpolate( double a, double b, double fraction )
{
    return a + ( b - a ) * fraction;
}

bool foundation_terrain( ter_id id )
{
    const ter_t &terrain = id.obj();
    return !terrain.has_flag( ter_furn_flag::TFLAG_NATURAL_UNDERGROUND ) &&
           !terrain.has_flag( ter_furn_flag::TFLAG_TREE ) &&
           ( terrain.has_flag( ter_furn_flag::TFLAG_INDOORS ) ||
             terrain.has_flag( ter_furn_flag::TFLAG_SUPPORTS_ROOF ) ||
             terrain.has_flag( ter_furn_flag::TFLAG_DOOR ) ||
             terrain.has_flag( ter_furn_flag::TFLAG_WINDOW ) );
}

bool entrance_terrain( ter_id id )
{
    return id->has_flag( ter_furn_flag::TFLAG_DOOR ) ||
           id->has_flag( ter_furn_flag::TFLAG_BARRICADABLE_DOOR ) ||
           ( !id->close.is_null() && id->close.obj().has_flag( ter_furn_flag::TFLAG_DOOR ) );
}

bool transport_terrain( ter_id id )
{
    return ( id->has_flag( ter_furn_flag::TFLAG_ROAD ) && !foundation_terrain( id ) ) ||
           id->has_flag( ter_furn_flag::TFLAG_RAIL );
}

int to_centimetres( double metres )
{
    return static_cast<int>( std::lround( metres * 100.0 ) );
}
} // namespace

std::optional<double> dem_elevation( regional_climate::coordinates location )
{
    const elevation_grid &data = grid();
    if( data.bytes.empty() || !std::isfinite( location.latitude ) ||
        !std::isfinite( location.longitude ) ) {
        return std::nullopt;
    }
    // The western section includes the Aleutians on the other side of the date line.
    const double longitude = location.longitude > 0.0 ? location.longitude - 360.0 : location.longitude;
    const double x = ( longitude - west ) * samples_per_degree;
    const double y = ( location.latitude - south ) * samples_per_degree;
    if( x < 0 || y < 0 || x > grid_width - 1 || y > grid_height - 1 ) {
        return std::nullopt;
    }
    const int column = std::min( static_cast<int>( x ), grid_width - 2 );
    const int row = std::min( static_cast<int>( y ), grid_height - 2 );
    const double a = interpolate( data.elevation_at( point( column, row ) ),
                                  data.elevation_at( point( column + 1, row ) ), x - column );
    const double b = interpolate( data.elevation_at( point( column, row + 1 ) ),
                                  data.elevation_at( point( column + 1, row + 1 ) ), x - column );
    return interpolate( a, b, y - row );
}

std::optional<double> dem_elevation( point_abs_ms position )
{
    return dem_elevation( location( position ) );
}

bool elevation_active()
{
    return active() && !grid().bytes.empty();
}

double surface_elevation( point_abs_ms position )
{
    // Cache the water surface and four DEM corners per overmap tile. Land
    // elevations remain continuous across tile boundaries and between samples.
    constexpr int span = SEEX * 2;
    struct terrain_cell {
        point_abs_omt key;
        std::array<double, 4> heights{};
        bool initialized = false;
    };
    static thread_local std::array<terrain_cell, 8192> cache;
    const point_abs_omt tile = project_to<coords::omt>( position );
    terrain_cell &entry = cache[std::hash<point_abs_omt> {}( tile ) % cache.size()];
    const point_abs_ms start = project_to<coords::ms>( tile );
    if( !entry.initialized || entry.key != tile ) {
        entry.key = tile;
        entry.initialized = true;
        if( const auto water = water_surface_elevation( start + point( span / 2, span / 2 ) ) ) {
            if( water->flat ) {
                entry.heights.fill( water->metres );
            } else {
                // Lakes have a constant waterline. River samples follow their
                // centerline profile within each cell as well as across cells.
                const auto height = [&]( point offset ) {
                    return water_surface_elevation( start + offset ).value_or( *water ).metres;
                };
                entry.heights = {{
                        height( point::zero ), height( { span, 0 } ),
                        height( { 0, span } ), height( { span, span } )
                    }
                };

            }
        } else {
            entry.heights = {{
                    dem_elevation( start ).value_or( 0.0 ),
                    dem_elevation( start + point( span, 0 ) ).value_or( 0.0 ),
                    dem_elevation( start + point( 0, span ) ).value_or( 0.0 ),
                    dem_elevation( start + point( span, span ) ).value_or( 0.0 )
                }
            };
        }
    }
    const point offset = position.raw() - start.raw();
    const double x = static_cast<double>( offset.x ) / span;
    const double y = static_cast<double>( offset.y ) / span;
    return interpolate( interpolate( entry.heights[0], entry.heights[1], x ),
                        interpolate( entry.heights[2], entry.heights[3], x ), y );
}

double altitude_at( const tripoint_abs_ms &position )
{
    return surface_elevation( position.xy() ) + position.z() * floor_height_m;
}

static point_abs_ms overmap_tile_center( point_abs_omt location )
{
    return project_to<coords::ms>( location ) + point( SEEX, SEEY );
}

double altitude_at( const tripoint_abs_omt &position )
{
    return altitude_at( tripoint_abs_ms( overmap_tile_center( position.xy() ), position.z() ) );
}

static std::optional<point_abs_ms> special_foundation_center( const tripoint_abs_omt &origin )
{
    // All OMTs of a placed special share the same argument slot, even if the
    // special has no arguments. Adjacent copies of a building have separate slots.
    auto *const instance = overmap_buffer.mapgen_args( origin );
    if( !instance ) {
        return std::nullopt;
    }
    const overmap_with_local_coords owner = overmap_buffer.get_existing_om_global( origin );
    if( !owner ) {
        return std::nullopt;
    }
    std::vector<tripoint_om_omt> pending{ owner.local };
    std::set<tripoint_om_omt> seen{ owner.local };
    point lo = owner.local.xy().raw();
    point hi = lo;
    for( std::size_t i = 0; i < pending.size(); ++i ) {
        const tripoint_om_omt p = pending[i];
        lo.x = std::min( lo.x, p.x() );
        lo.y = std::min( lo.y, p.y() );
        hi.x = std::max( hi.x, p.x() );
        hi.y = std::max( hi.y, p.y() );
        for( const point &step : four_cardinal_directions ) {
            const tripoint_om_omt next = p + step;
            if( owner.om->mapgen_args( next ) == instance && seen.insert( next ).second ) {
                pending.push_back( next );
            }
        }
    }
    if( pending.size() == 1 ) {
        return std::nullopt;
    }
    const point middle = ( lo + hi - owner.local.xy().raw() * 2 ) * SEEX;
    return overmap_tile_center( origin.xy() ) + middle;
}

void grade_generated_surface( mapgendata &dat )
{
    if( dat.zlevel() != 0 || !elevation_active() ) {
        return;
    }
    map &here = dat.m;
    constexpr int width = 2 * SEEX;
    constexpr int height = 2 * SEEY;
    const oter_id terrain = dat.terrain_type();
    const auto transport = [&]( const tripoint_bub_ms & p ) {
        return transport_terrain( here.ter( p ) );
    };
    static const oter_type_str_id manhole( "road_nesw_manhole" );
    static const oter_type_str_id divided_highway( "hw_road" );
    if( terrain->has_flag( oter_flags::bridge ) || terrain->is_highway_special() ) {
        return; // Elevated decks and abutments keep their existing structural levels.
    }

    const point middle( SEEX, SEEY );
    std::vector<point> arms;
    if( terrain->is_linear() || terrain->get_type_id() == manhole ) {
        for( const om_direction::type direction : om_direction::all ) {
            if( !terrain->is_linear() || om_lines::has_segment( terrain->get_line(), direction ) ) {
                const point step = om_direction::displace( direction ).raw();
                arms.push_back( { step.x * SEEX, step.y * SEEY } );
            }
        }
    }

    const point_abs_ms origin = project_to<coords::ms>( dat.pos().xy() );
    const bool divided = terrain->get_type_id() == divided_highway;
    const point median_offset = divided ? om_direction::displace( terrain->get_dir() ).raw() :
                                point::zero;
    const std::string &terrain_name = terrain->get_type_id().str();
    const bool airfield = string_starts_with( terrain_name, "helipad" ) ||
                          string_starts_with( terrain_name, "runway" );
    const std::optional<point_abs_ms> pad_center = airfield ?
            special_foundation_center( dat.pos() ) : std::nullopt;
    const int pad_height = airfield ? to_centimetres( surface_elevation(
                               pad_center.value_or( origin + middle ) ) ) : 0;
    constexpr int area = width * height;
    std::array<bool, area> covered{};
    const auto local = []( point p ) {
        return p.x >= 0 && p.x < width && p.y >= 0 && p.y < height;
    };
    const auto key = []( point p ) {
        return p.y * width + p.x;
    };
    const auto at = []( point p ) {
        return tripoint_bub_ms( p.x, p.y, 0 );
    };
    std::optional<point_abs_ms> special_center;
    bool checked_special = false;
    for( int y = 0; y < height; ++y ) {
        for( int x = 0; x < width; ++x ) {
            const point start( x, y );
            if( covered[key( start )] || here.get_surface_grade( at( start ) ) ) {
                continue;
            }

            if( airfield && transport( at( start ) ) ) {
                here.set_surface_grade( at( start ), { pad_height, 0 } );
                continue;
            }
            if( divided && transport( at( start ) ) ) {
                const point centerline( median_offset.y == 0 ? SEEX + median_offset.x *SEEX : x,
                                        median_offset.x == 0 ? SEEY + median_offset.y *SEEY : y );
                const int elevation = to_centimetres( surface_elevation( origin + centerline ) );
                here.set_surface_grade( at( start ), { elevation, 0 } );
                continue;
            }
            if( !arms.empty() && transport( at( start ) ) ) {
                double distance = std::numeric_limits<double>::max();
                point projected = middle;
                const point offset = start - middle;
                for( const point &arm : arms ) {
                    const int along = std::clamp( arm.x != 0 ? offset.x : offset.y,
                                                  std::min( 0, arm.x + arm.y ),
                                                  std::max( 0, arm.x + arm.y ) );
                    const point candidate = middle + ( arm.x != 0 ? point( along, 0 ) :
                                                       point( 0, along ) );
                    const point d = candidate - start;
                    const double sq = d.x * d.x + d.y * d.y;
                    if( sq < distance ) {
                        distance = sq;
                        projected = candidate;
                    }
                }
                const int elevation = to_centimetres( surface_elevation( origin + projected ) );
                here.set_surface_grade( at( start ), { elevation, 0 } );
                continue;
            }

            if( !foundation_terrain( here.ter( at( start ) ) ) ) {
                continue;
            }
            if( !checked_special ) {
                special_center = special_foundation_center( dat.pos() );
                checked_special = true;
            }
            std::vector<point> footprint{ start };
            covered[key( start )] = true;
            point lo = start;
            point hi = start;
            std::vector<point> landings;
            std::optional<point> entrance;
            int entrances = 0;
            for( std::size_t i = 0; i < footprint.size(); ++i ) {
                const point p = footprint[i];
                lo.x = std::min( lo.x, p.x );
                lo.y = std::min( lo.y, p.y );
                hi.x = std::max( hi.x, p.x );
                hi.y = std::max( hi.y, p.y );
                bool has_landing = false;
                for( const point &step : four_cardinal_directions ) {
                    const point next = p + step;
                    if( !local( next ) ) {
                        continue;
                    }
                    const ter_id ground = here.ter( at( next ) );
                    if( foundation_terrain( ground ) ) {
                        if( !covered[key( next )] ) {
                            covered[key( next )] = true;
                            footprint.push_back( next );
                        }
                    } else if( entrance_terrain( here.ter( at( p ) ) ) &&
                               here.passable_ter_furn( at( next ) ) &&
                               !ground->has_flag( ter_furn_flag::TFLAG_SWIMMABLE ) &&
                               !ground->has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) ) {
                        has_landing = true;
                        landings.push_back( next );
                    }
                }
                if( has_landing ) {
                    entrance = p;
                    ++entrances;
                }
            }
            const point_abs_ms reference = special_center.value_or(
                                               origin + ( entrances == 1 ? *entrance : ( lo + hi ) / 2 ) );
            const graded_surface grade{ to_centimetres( surface_elevation( reference ) ), 0 };
            for( const point &p : footprint ) {
                here.set_surface_grade( at( p ), grade );
            }
            for( const point &p : landings ) {
                if( !here.get_surface_grade( at( p ) ) && !transport( at( p ) ) ) {
                    here.set_surface_grade( at( p ), grade );
                }
            }
        }
    }
}

void extend_foundation( map &here, const tripoint_bub_ms &p, double previous_altitude )
{
    const ter_id terrain = here.ter( p );
    if( !foundation_terrain( terrain ) ) {
        return;
    }
    const int now = std::max( 1, to_turn<int>( calendar::turn ) );
    graded_surface grade{ to_centimetres( previous_altitude - p.z() * floor_height_m ), now };
    const auto earlier = []( const graded_surface & a, const graded_surface & b ) {
        return a.built_at < b.built_at || ( a.built_at == b.built_at && a.centimetres < b.centimetres );
    };
    for( const point &step : four_cardinal_directions ) {
        const tripoint_bub_ms next = p + step;
        if( !here.inbounds( next ) || !foundation_terrain( here.ter( next ) ) ) {
            continue;
        }
        if( const graded_surface *nearby = here.get_surface_grade( next );
            nearby && earlier( *nearby, grade ) ) {
            grade = *nearby;
        } else if( !nearby && p.z() != 0 ) {
            if( const graded_surface *below = here.get_surface_grade( next + tripoint::below );
                below && earlier( *below, grade ) ) {
                grade = *below;
            }
        }
    }
    if( const graded_surface *below = here.get_surface_grade( p + tripoint::below );
        below && earlier( *below, grade ) ) {
        grade = *below;
    }

    // A newly joined section inherits the oldest foundation in the connected
    // player structure. Keep the original pad of any pre-existing building.
    std::vector<tripoint_bub_ms> pending{ p };
    std::set<tripoint_bub_ms> seen{ p };
    bool needs_join = false;
    for( const point &step : four_cardinal_directions ) {
        const tripoint_bub_ms next = p + step;
        if( const graded_surface *other = here.get_surface_grade( next );
            other && other->built_at > 0 && foundation_terrain( here.ter( next ) ) &&
            ( other->built_at != grade.built_at || other->centimetres != grade.centimetres ) ) {
            needs_join = true;
        }
    }
    for( std::size_t i = 0; needs_join && i < pending.size(); ++i ) {
        for( const point &step : four_cardinal_directions ) {
            const tripoint_bub_ms next = pending[i] + step;
            const graded_surface *other = here.get_surface_grade( next );
            if( other && other->built_at > 0 && foundation_terrain( here.ter( next ) ) &&
                seen.insert( next ).second ) {
                pending.push_back( next );
                if( earlier( *other, grade ) ) {
                    grade = *other;
                }
            }
        }
    }
    grade.built_at = std::max( 1, grade.built_at );
    for( const tripoint_bub_ms &tile : pending ) {
        here.set_surface_grade( tile, grade );
    }
    if( entrance_terrain( terrain ) ) {
        for( const point &step : four_cardinal_directions ) {
            const tripoint_bub_ms next = p + step;
            if( here.inbounds( next ) && !here.get_surface_grade( next ) &&
                here.has_flag_ter( ter_furn_flag::TFLAG_DIGGABLE, next ) ) {
                here.set_surface_grade( next, grade );
            }
        }
    }
}

int minimum_overmap_z( point_abs_omt location )
{
    return static_cast<int>( std::ceil( ( -altitude_limit_m -
                                          surface_elevation( overmap_tile_center( location ) ) ) / floor_height_m ) );
}

int maximum_overmap_z( point_abs_omt location )
{
    return static_cast<int>( std::floor( ( altitude_limit_m -
                                           surface_elevation( overmap_tile_center( location ) ) ) / floor_height_m ) );
}

std::optional<tripoint_abs_omt> overmap_at_altitude( point_abs_omt location, double metres )
{
    if( !within_altitude_limits( metres ) ) {
        return std::nullopt;
    }
    const double surface = surface_elevation( overmap_tile_center( location ) );
    const int z = static_cast<int>( std::lround( ( metres - surface ) / floor_height_m ) );
    return tripoint_abs_omt( location, std::clamp( z, minimum_overmap_z( location ),
                             maximum_overmap_z( location ) ) );
}

double altitude_at( const map &here, const tripoint_bub_ms &position )
{
    const tripoint_abs_ms absolute = here.get_abs( position );
    const double height = position.z() * floor_height_m;
    if( const graded_surface *grade = here.get_surface_grade( position ) ) {
        return grade->centimetres / 100.0 + height;
    }
    const tripoint_bub_ms surface( position.xy(), 0 );
    if( position.z() != 0 ) {
        if( const graded_surface *grade = here.get_surface_grade( surface ) ) {
            return grade->centimetres / 100.0 + height;
        }
    }
    // Older chunks have no stored foundation.
    if( here.inbounds( surface ) &&
        ( here.has_flag_ter( ter_furn_flag::TFLAG_INDOORS, surface ) ||
          here.has_flag_ter( ter_furn_flag::TFLAG_WALL, surface ) ) ) {
        return surface_elevation( overmap_tile_center( project_to<coords::omt>( absolute.xy() ) ) ) +
               height;
    }
    return surface_elevation( absolute.xy() ) + height;
}

double occupant_altitude( const map &here, const tripoint_bub_ms &position )
{
    if( elevation_active() ) {
        if( const auto part = here.veh_at( position ) ) {
            const vehicle &aircraft = part->vehicle();
            if( const auto altitude = aircraft.flight_altitude() ) {
                return *altitude + ( position.z() - aircraft.pos_abs().z() ) * floor_height_m;
            }
        }
    }
    return altitude_at( here, position );
}

bool within_altitude_limits( double metres )
{
    return std::abs( metres ) <= altitude_limit_m;
}

double grade_move_multiplier( double grade )
{
    // Minor grades have no gameplay cost. Above those, an asymmetric
    // piecewise fit reflects the measured increase in uphill effort and
    // the added braking work on steep descents (Minetti et al., 2002).
    const double height = std::max( 0.0, std::abs( grade ) - 0.04 );
    if( grade >= 0.0 ) {
        return 1.0 + std::min( 2.5, height * ( 1.8 + 1.5 * height ) );
    }
    return 1.0 + std::min( 1.0, std::max( 0.0, height - 0.10 ) * 1.8 );
}

double grade_between( const map &here, const tripoint_bub_ms &from,
                      const tripoint_bub_ms &to )
{
    const point distance = to.xy().raw() - from.xy().raw();
    const double run = std::hypot( distance.x, distance.y );
    if( from.z() != to.z() || run == 0 || !here.inbounds( from ) || !here.inbounds( to ) ) {
        return 0;
    }
    return ( altitude_at( here, to ) - altitude_at( here, from ) ) / run;
}

bool sheer_slope( const map &here, const tripoint_bub_ms &from, const tripoint_bub_ms &to )
{
    return from.z() == 0 && to.z() == 0 && here.inbounds( from ) && here.inbounds( to ) &&
           std::abs( from.x() - to.x() ) <= 1 && std::abs( from.y() - to.y() ) <= 1 &&
           elevation_active() && !here.has_flag_ter( ter_furn_flag::TFLAG_SWIMMABLE, from ) &&
           !here.has_flag_ter( ter_furn_flag::TFLAG_SWIMMABLE, to ) &&
           !here.has_flag_ter( ter_furn_flag::TFLAG_RAMP, from ) &&
           !here.has_flag_ter( ter_furn_flag::TFLAG_RAMP, to ) &&
           std::abs( grade_between( here, from, to ) ) > walking_grade_limit;
}

point surface_slope( const map &here, const tripoint_bub_ms &position )
{
    if( position.z() != 0 || !here.inbounds( position ) || here.get_surface_grade( position ) ||
        here.has_flag_ter( ter_furn_flag::TFLAG_INDOORS, position ) ||
        here.has_flag_ter( ter_furn_flag::TFLAG_WALL, position ) ||
        here.has_flag_ter( ter_furn_flag::TFLAG_SWIMMABLE, position ) ) {
        return point::zero;
    }
    const point_abs_ms p = here.get_abs( position ).xy();
    const double x = ( surface_elevation( p + point::east ) -
                       surface_elevation( p - point::east ) ) / 2.0;
    const double y = ( surface_elevation( p + point::south ) -
                       surface_elevation( p - point::south ) ) / 2.0;
    return { static_cast<int>( std::clamp( std::lround( x * 100 ), -100L, 100L ) ),
             static_cast<int>( std::clamp( std::lround( y * 100 ), -100L, 100L ) ) };
}

int surface_relief_shade( point slope )
{
    const int grade_squared = slope.x * slope.x + slope.y * slope.y;
    if( grade_squared < 49 ) {
        return 0;
    }
    // Oblique light and the reduced vertical component of a sloping surface.
    const double normal = std::sqrt( 10000.0 + grade_squared );
    const double light = ( 100.0 + 0.72 * slope.x + 0.36 * slope.y ) / normal - 1.0;
    const int tone = static_cast<int>( std::lround( light * 95 ) );
    return std::clamp( tone, -55, 55 );
}

double temperature_delta_at_height( double altitude_m, double reference_m )
{
    return ( std::min( reference_m, tropopause_m ) - std::min( altitude_m, tropopause_m ) ) *
           lapse_rate;
}

double pressure_ratio_at_height( double altitude_m )
{
    constexpr double standard_temperature_k = 288.15;
    constexpr double pressure_exponent = 5.25588;
    constexpr double gravity_over_air_constant = 0.0341632;
    const double lower = std::min( altitude_m, tropopause_m );
    const double temperature = standard_temperature_k - lapse_rate * lower;
    const double pressure_ratio = std::pow( temperature / standard_temperature_k, pressure_exponent );
    return pressure_ratio * std::exp( -gravity_over_air_constant *
                                      ( altitude_m - lower ) / temperature );
}

double air_density_ratio_at_height( double altitude_m )
{
    constexpr double standard_temperature_k = 288.15;
    const double temperature = standard_temperature_k - lapse_rate * std::min( altitude_m, tropopause_m );
    return pressure_ratio_at_height( altitude_m ) * standard_temperature_k / temperature;
}

double wind_speed_factor( double altitude_m, double surface_m )
{
    const double height = std::clamp( altitude_m - surface_m + 10.0, 2.0, 250.0 );
    const double exposure = 1.0 + std::clamp( surface_m / 18000.0, 0.0, 0.45 );
    return std::pow( height / 10.0, 1.0 / 7.0 ) * exposure;
}
} // namespace north_america
