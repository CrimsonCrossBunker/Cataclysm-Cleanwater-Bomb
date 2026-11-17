#include "north_america_elevation.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <functional>
#include <istream>
#include <string_view>
#include <vector>

#include "cata_path.h"
#include "cata_utility.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "north_america.h"
#include "path_info.h"
#include "regional_climate.h"

namespace north_america
{
namespace
{
constexpr int grid_width = 5671;
constexpr int grid_height = 2341;
constexpr double south = 6.0 + 1.0 / 120.0;
constexpr double west = -195.0 + 1.0 / 120.0;
constexpr double samples_per_degree = 30.0;
constexpr double tropopause_m = 11000.0;
constexpr double lapse_rate = 0.0065;

struct elevation_grid {
    std::vector<std::uint8_t> bytes;

    elevation_grid() {
        auto input = read_maybe_compressed_file(
                         PATH_INFO::datadir_path() / "raw" / "north_america.elevation.gz" );
        if( !input ) {
            return;
        }
        std::array<char, 8> signature{};
        if( !input->read( signature.data(), signature.size() ) ||
            std::string_view( signature.data(), signature.size() ) != "CCBDEM1\n" ) {
            return;
        }
        bytes.resize( 2 * grid_width * grid_height );
        if( !input->read( reinterpret_cast<char *>( bytes.data() ), bytes.size() ) ) {
            bytes.clear();
        }
    }

    int elevation_at( int x, int y ) const {
        const std::size_t index = 2 * ( y * grid_width + x );
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

bool building_surface( const map &here, const tripoint_bub_ms &surface )
{
    return here.inbounds( surface ) &&
           ( here.has_flag_ter( ter_furn_flag::TFLAG_INDOORS, surface ) ||
             here.has_flag_ter( ter_furn_flag::TFLAG_WALL, surface ) );
}
} // namespace

std::optional<double> dem_elevation( regional_climate::coordinates location )
{
    const auto &data = grid();
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
    const double a = interpolate( data.elevation_at( column, row ),
                                  data.elevation_at( column + 1, row ), x - column );
    const double b = interpolate( data.elevation_at( column, row + 1 ),
                                  data.elevation_at( column + 1, row + 1 ), x - column );
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
    const double natural = surface_elevation( absolute.xy() );
    const tripoint_bub_ms surface( position.xy(), 0 );
    if( !building_surface( here, surface ) ) {
        return natural + position.z() * floor_height_m;
    }
    const point_abs_omt lot = project_to<coords::omt>( absolute.xy() );
    const double platform = surface_elevation( project_to<coords::ms>( lot ) + point( SEEX, SEEY ) );
    return platform + position.z() * floor_height_m;
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

point surface_slope( const map &here, const tripoint_bub_ms &position )
{
    if( position.z() != 0 || !here.inbounds( position ) || building_surface( here, position ) ||
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
    const double grade = std::hypot( slope.x, slope.y );
    if( grade < 7 ) {
        return 0;
    }
    // Oblique light and the reduced vertical component of a sloping surface.
    const double normal = std::hypot( 100.0, grade );
    const double light = ( 100.0 + 0.72 * slope.x + 0.36 * slope.y ) / normal - 1.0;
    const int tone = static_cast<int>( std::lround( light * 95 ) );
    return tone >= 7 ? std::min( tone, 55 ) : std::clamp( tone, -55, -7 );
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

double wind_speed_factor( double altitude_m, double surface_m )
{
    const double height = std::clamp( altitude_m - surface_m + 10.0, 2.0, 250.0 );
    const double exposure = 1.0 + std::clamp( surface_m / 18000.0, 0.0, 0.45 );
    return std::pow( height / 10.0, 1.0 / 7.0 ) * exposure;
}
} // namespace north_america
