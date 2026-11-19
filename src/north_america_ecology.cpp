#include "north_america_ecology.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <initializer_list>
#include <limits>
#include <map>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include "cata_path.h"
#include "cata_utility.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "line.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "mapgen_functions.h"
#include "mapgendata.h"
#include "north_america.h"
#include "north_america_elevation.h"
#include "omdata.h"
#include "path_info.h"
#include "regional_climate.h"
#include "rng.h"
#include "type_id.h"
#include "weighted_list.h"

static const ter_str_id ter_t_dirt( "t_dirt" );
static const ter_str_id ter_t_grass( "t_grass" );
static const ter_str_id ter_t_grass_long( "t_grass_long" );
static const ter_str_id ter_t_grass_tall( "t_grass_tall" );

namespace north_america
{
namespace
{

struct biome_settings {
    float forest_adjustment = 0;
    ter_str_id groundcover;
    int open_shrub_percent = 0;
};

struct plant {
    ter_str_id terrain;
    int weight = 0;
    bool shrub = false;
};

struct ecology_profile {
    std::string ecoregion;
    biome_settings biome;
    std::vector<plant> plants;
};

struct habitat {
    oter_str_id terrain;
    oter_str_id base;
    std::vector<std::string> regions;
    // Longitude west, latitude south, longitude east, latitude north.
    std::array<double, 4> bounds = { -180, -90, 180, 90 };
    std::vector<std::array<double, 3>> groves;
    std::vector<regional_climate::coordinates> corridor;
    double corridor_width_km = 0;
    double minimum_m = -altitude_limit_m;
    double maximum_m = altitude_limit_m;
    double treeline_minimum_m = -2 * altitude_limit_m;
    double treeline_maximum_m = 2 * altitude_limit_m;
    double transition_m = 100;
    bool wet_only = false;
    int tree_percent = 0;
    int shrub_percent = 0;
    int rock_percent = 0;
    int water_percent = 0;
    std::vector<plant> plants;
    std::vector<std::pair<ter_str_id, int>> ground;
};

struct treeline_zone {
    std::vector<std::string> regions;
    std::array<double, 4> bounds;
    std::vector<std::pair<double, double>> heights;
};

bool contains_location( const std::array<double, 4> &bounds,
                        regional_climate::coordinates location )
{
    return location.longitude >= bounds[0] && location.latitude >= bounds[1] &&
           location.longitude <= bounds[2] && location.latitude <= bounds[3];
}

std::array<double, 4> habitat_bounds( const JsonObject &jo )
{
    const JsonArray bounds = jo.get_array( "bounds" );
    if( bounds.size() != 4 || bounds.get_float( 0 ) >= bounds.get_float( 2 ) ||
        bounds.get_float( 1 ) >= bounds.get_float( 3 ) ) {
        jo.throw_error_at( "bounds", "Expected west, south, east, north bounds" );
    }
    return { bounds.get_float( 0 ), bounds.get_float( 1 ),
             bounds.get_float( 2 ), bounds.get_float( 3 ) };
}

struct habitat_atlas {
    std::vector<habitat> habitats;
    std::vector<treeline_zone> treelines;

    habitat_atlas() {
        read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america_habitats.json",
        [this]( const JsonValue & value ) {
            const JsonObject root = value.get_object();
            root.allow_omitted_members();
            if( root.get_int( "version" ) != 1 ) {
                root.throw_error( "Unsupported North America habitat atlas version" );
            }
            for( const JsonObject jo : root.get_array( "treelines" ) ) {
                treeline_zone zone;
                zone.bounds = habitat_bounds( jo );
                jo.read( "regions", zone.regions );
                for( const JsonArray knot : jo.get_array( "heights" ) ) {
                    const double latitude = knot.get_float( 0 );
                    if( !zone.heights.empty() && latitude <= zone.heights.back().first ) {
                        knot.throw_error( "Treeline latitudes must increase" );
                    }
                    zone.heights.emplace_back( latitude, knot.get_float( 1 ) );
                }
                if( zone.heights.empty() ) {
                    jo.throw_error_at( "heights", "At least one treeline height is required" );
                }
                treelines.push_back( std::move( zone ) );
            }
            for( const JsonObject jo : root.get_array( "habitats" ) ) {
                habitat entry;
                entry.terrain = oter_str_id( jo.get_string( "overmap" ) );
                entry.base = oter_str_id( jo.get_string( "base" ) );
                jo.read( "regions", entry.regions );
                if( jo.has_member( "bounds" ) ) {
                    entry.bounds = habitat_bounds( jo );
                }
                const auto read_range = [&jo]( const char *key, double & low, double & high ) {
                    if( jo.has_member( key ) ) {
                        const JsonArray range = jo.get_array( key );
                        if( range.size() != 2 || range.get_float( 0 ) >= range.get_float( 1 ) ) {
                            jo.throw_error_at( key, "Expected an increasing height range in metres" );
                        }
                        low = range.get_float( 0 );
                        high = range.get_float( 1 );
                    }
                };
                read_range( "elevation_m", entry.minimum_m, entry.maximum_m );
                read_range( "relative_to_treeline_m", entry.treeline_minimum_m,
                            entry.treeline_maximum_m );
                entry.transition_m = std::max( 1.0, jo.get_float( "transition_m", 100 ) );
                entry.wet_only = jo.get_bool( "wet_only", false );
                entry.tree_percent = jo.get_int( "tree_percent", 0 );
                entry.shrub_percent = jo.get_int( "shrub_percent", 0 );
                entry.rock_percent = jo.get_int( "rock_percent", 0 );
                entry.water_percent = jo.get_int( "water_percent", 0 );
                for( const int percent : { entry.tree_percent, entry.shrub_percent,
                                          entry.rock_percent, entry.water_percent } ) {
                    if( percent < 0 || percent > 100 ) {
                        jo.throw_error( "Habitat cover percentages must be between zero and 100" );
                    }
                }
                for( const JsonArray grove : jo.get_array( "groves" ) ) {
                    entry.groves.push_back( { grove.get_float( 0 ), grove.get_float( 1 ),
                                             grove.get_float( 2 ) } );
                }
                for( const JsonArray vertex : jo.get_array( "corridor" ) ) {
                    entry.corridor.push_back( { vertex.get_float( 1 ), vertex.get_float( 0 ) } );
                }
                entry.corridor_width_km = jo.get_float( "corridor_width_km", 0 );
                for( const JsonArray definition : jo.get_array( "plants" ) ) {
                    const std::string kind = definition.get_string( 2 );
                    if( kind != "tree" && kind != "shrub" ) {
                        definition.throw_error( "Habitat plants must be trees or shrubs" );
                    }
                    entry.plants.push_back( { ter_str_id( definition.get_string( 0 ) ),
                                              definition.get_int( 1 ), kind == "shrub" } );
                }
                for( const JsonArray ground : jo.get_array( "ground" ) ) {
                    entry.ground.emplace_back( ter_str_id( ground.get_string( 0 ) ), ground.get_int( 1 ) );
                }
                habitats.push_back( std::move( entry ) );
            }
        } );
    }
};

const habitat_atlas &get_habitats()
{
    static const habitat_atlas data;
    return data;
}

bool matches_region( const std::vector<std::string> &regions, std::string_view code )
{
    return regions.empty() || std::find( regions.begin(), regions.end(), code ) != regions.end();
}

double treeline_at( regional_climate::coordinates location, std::string_view region )
{
    for( const treeline_zone &zone : get_habitats().treelines ) {
        if( !contains_location( zone.bounds, location ) || !matches_region( zone.regions, region ) ) {
            continue;
        }
        const auto &heights = zone.heights;
        for( std::size_t i = 1; i < heights.size(); ++i ) {
            if( location.latitude < heights[i].first ) {
                const double fraction = std::clamp( ( location.latitude - heights[i - 1].first ) /
                                        ( heights[i].first - heights[i - 1].first ), 0.0, 1.0 );
                return heights[i - 1].second + fraction * ( heights[i].second - heights[i - 1].second );
            }
        }
        return heights.back().second;
    }
    return 4000;
}

double horizontal_distance_km( regional_climate::coordinates location,
                               double longitude, double latitude )
{
    const double east = ( location.longitude - longitude ) * 111.32 *
                        std::cos( location.latitude * 0.0174532925199433 );
    const double north = ( location.latitude - latitude ) * 111.32;
    return std::hypot( east, north );
}

double corridor_distance_km( const habitat &entry, regional_climate::coordinates location )
{
    double distance = std::numeric_limits<double>::max();
    const double scale = std::cos( location.latitude * 0.0174532925199433 );
    for( std::size_t i = 1; i < entry.corridor.size(); ++i ) {
        const auto &a = entry.corridor[i - 1];
        const auto &b = entry.corridor[i];
        const double dx = ( b.longitude - a.longitude ) * scale;
        const double dy = b.latitude - a.latitude;
        const double length_squared = dx * dx + dy * dy;
        const double fraction = length_squared > 0 ? std::clamp(
                                    ( ( location.longitude - a.longitude ) * scale * dx +
                                      ( location.latitude - a.latitude ) * dy ) / length_squared, 0.0, 1.0 ) : 0;
        distance = std::min( distance, horizontal_distance_km( location,
                             a.longitude + fraction * ( b.longitude - a.longitude ),
                             a.latitude + fraction * dy ) );
    }
    return distance;
}

double habitat_roll( point_abs_omt pos )
{
    std::uint32_t hash = static_cast<std::uint32_t>( pos.x() ) * 3619419497U ^
                         static_cast<std::uint32_t>( pos.y() ) * 19349663U;
    hash ^= hash >> 16;
    hash *= 0x7feb352dU;
    hash ^= hash >> 15;
    return ( hash % 10000 + 0.5 ) / 10000.0;
}

const habitat *habitat_at( point_abs_omt pos, std::string_view region, bool wet )
{
    const point_abs_ms center = project_to<coords::ms>( pos ) + point( SEEX, SEEY );
    const regional_climate::coordinates geo = location( center );
    std::optional<double> height;
    double treeline_height = 0;
    for( const habitat &entry : get_habitats().habitats ) {
        if( ( entry.wet_only && !wet ) || ( wet && entry.base.str() != "forest_water" ) ||
            !contains_location( entry.bounds, geo ) ||
            !matches_region( entry.regions, region ) ) {
            continue;
        }
        if( !height ) {
            height = dem_elevation( geo ).value_or( 0 );
            treeline_height = treeline_at( geo, region );
        }
        const double above_treeline = *height - treeline_height;
        const double margin = std::min( { *height - entry.minimum_m, entry.maximum_m - *height,
                                         above_treeline - entry.treeline_minimum_m,
                                         entry.treeline_maximum_m - above_treeline } );
        if( margin <= 0 || habitat_roll( pos ) >= std::min( 1.0, margin / entry.transition_m ) ) {
            continue;
        }
        if( !entry.groves.empty() && std::none_of( entry.groves.begin(), entry.groves.end(),
        [&geo]( const auto & grove ) {
            return horizontal_distance_km( geo, grove[0], grove[1] ) <= grove[2];
        } ) ) {
            continue;
        }
        if( !entry.corridor.empty() &&
            corridor_distance_km( entry, geo ) > entry.corridor_width_km ) {
            continue;
        }
        return &entry;
    }
    return nullptr;
}

const habitat *habitat_by_terrain( const oter_id &terrain )
{
    if( terrain->get_type_id().str().compare( 0, 9, "na_biome_" ) != 0 ) {
        return nullptr;
    }
    for( const habitat &entry : get_habitats().habitats ) {
        if( entry.terrain.id() == terrain ) {
            return &entry;
        }
    }
    return nullptr;
}

void draw_habitat_cover( mapgendata &dat, const habitat &entry )
{
    weighted_int_list<ter_id> trees;
    weighted_int_list<ter_id> shrubs;
    weighted_int_list<ter_id> ground;
    for( const plant &p : entry.plants ) {
        if( p.weight > 0 && p.terrain.is_valid() ) {
            ( p.shrub ? shrubs : trees ).add( p.terrain.id(), p.weight );
        }
    }
    for( const auto &[terrain, weight] : entry.ground ) {
        if( weight > 0 && terrain.is_valid() ) {
            ground.add( terrain.id(), weight );
        }
    }
    const double phase = habitat_roll( dat.pos().xy() ) * 6.283185307179586;
    for( int y = 0; y < 2 * SEEY; ++y ) {
        for( int x = 0; x < 2 * SEEX; ++x ) {
            const point_bub_ms pos( x, y );
            const ter_t &original = *dat.m.ter( pos );
            if( original.has_flag( ter_furn_flag::TFLAG_SWIMMABLE ) ||
                original.has_flag( ter_furn_flag::TFLAG_WALL ) ||
                original.has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) ) {
                continue;
            }
            if( dat.m.has_furn( pos ) ) {
                continue;
            }
            const ter_id *replacement = ground.pick();
            if( !replacement ) {
                continue;
            }
            // Low-frequency patches keep wet ground, scree and shrubs from looking like confetti.
            const double patch = 0.65 + 0.35 * std::sin( x * 0.23 + phase ) *
                                 std::sin( y * 0.19 - phase );
            if( x_in_y( entry.tree_percent, 100 ) ) {
                if( const ter_id *tree = trees.pick() ) {
                    replacement = tree;
                }
            } else if( x_in_y( entry.shrub_percent * patch, 100 ) ) {
                if( const ter_id *shrub = shrubs.pick() ) {
                    replacement = shrub;
                }
            } else if( x_in_y( entry.water_percent * patch, 100 ) ) {
                static const ter_str_id water( "t_water_sh" );
                replacement = nullptr;
                dat.m.ter_set( pos, water.id() );
            } else if( x_in_y( entry.rock_percent * patch, 100 ) ) {
                static const ter_str_id rock( "t_rock_floor" );
                replacement = nullptr;
                dat.m.ter_set( pos, rock.id() );
            }
            if( replacement ) {
                dat.m.ter_set( pos, *replacement );
            }
        }
    }
}

struct ecology_atlas {
    point origin;
    int step = 1;
    int width = 0;
    int height = 0;
    std::vector<size_t> cells;
    std::vector<uint8_t> population;
    std::vector<uint8_t> forest_cover;
    std::vector<ecology_profile> profiles;

    ecology_atlas() {
        std::map<std::string, biome_settings> biomes;
        std::vector<plant> species;
        if( !read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america_ecology_profiles.json",
        [&]( const JsonValue & value ) {
        const JsonObject definitions = value.get_object();
            for( const JsonMember entry : definitions.get_object( "biomes" ) ) {
                const JsonArray data = entry.get_array();
                biomes.emplace( entry.name(), biome_settings{ static_cast<float>( data.get_float( 0 ) ),
                                ter_str_id( data.get_string( 1 ) ), data.get_int( 2 ) } );
            }
            for( const JsonValue entry : definitions.get_array( "species" ) ) {
                const JsonObject data = entry.get_object();
                data.allow_omitted_members();
                const bool shrub = data.get_string( "kind" ) == "S";
                species.push_back( { ter_str_id( ( shrub ? "t_shrub_" : "t_tree_" ) +
                                                 data.get_string( "id" ) ), data.get_int( "weight" ), shrub } );
            }
            // The bake uses this table to match CEC codes to gameplay profiles.
            definitions.get_object( "regions" ).allow_omitted_members();
        } ) ) {
            return;
        }
        const bool loaded = read_from_file_json( PATH_INFO::datadir_path() / "raw" /
        "north_america.ecology", [&]( const JsonValue & value ) {
            const JsonObject root = value.get_object();
            const JsonArray grid = root.get_array( "grid" );
            origin = point( grid.get_int( 0 ), grid.get_int( 1 ) );
            step = grid.get_int( 2 );
            width = grid.get_int( 3 );
            height = grid.get_int( 4 );
            if( root.get_int( "version" ) != 1 || step <= 0 ||
                width <= 0 || height <= 0 || width > 4000 || height > 4000 ) {
                root.throw_error( "Invalid North America ecology atlas dimensions or version" );
            }
            for( const JsonValue entry : root.get_array( "profiles" ) ) {
                ecology_profile profile;
                if( !entry.test_null() ) {
                    const JsonArray data = entry.get_array();
                    profile.ecoregion = data.get_string( 0 );
                    profile.biome = biomes.at( data.get_string( 1 ) );
                    for( const JsonValue index : data.get_array( 2 ) ) {
                        profile.plants.push_back( species.at( index.get_int() ) );
                    }
                }
                profiles.push_back( std::move( profile ) );
            }
            cells.resize( width * height );
            population.resize( width * height );
            forest_cover.resize( width * height );
            const auto fill_runs = [&]( const JsonArray & runs, auto & dest, int limit ) {
                for( const JsonValue entry : runs ) {
                    const JsonArray run = entry.get_array();
                    const point start( run.get_int( 0 ), run.get_int( 1 ) );
                    const int length = run.get_int( 2 );
                    const int index = run.get_int( 3 );
                    if( start.x < 0 || start.y < 0 || start.x >= width || start.y >= height ||
                        length < 1 || length > width - start.x || index < 1 || index >= limit ) {
                        run.throw_error( "Invalid North America ecology atlas run" );
                    }
                    std::fill_n( dest.begin() + start.y * width + start.x, length, index );
                }
            };
            fill_runs( root.get_array( "runs" ), cells, profiles.size() );
            fill_runs( root.get_array( "population" ), population, 8 );
            fill_runs( root.get_array( "forest_cover" ), forest_cover, 7 );
        } );
        if( !loaded ) {
            cells.clear();
        }
    }

    int index( point_abs_omt pos ) const {
        if( cells.empty() ) {
            return -1;
        }
        const point offset = project_to<coords::ms>( pos ).raw() - origin;
        if( offset.x < 0 || offset.y < 0 || offset.x >= width * step || offset.y >= height * step ) {
            return -1;
        }
        return offset.y / step * width + offset.x / step;
    }
};

const ecology_atlas &get_ecology()
{
    static const ecology_atlas data;
    return data;
}

constexpr std::array<point, 8> district_neighbors{{
        point::north, point::east, point::south, point::west,
        point::north_east, point::south_east, point::south_west, point::north_west
    }};

struct urban_atlas {
    int step = 1;
    std::unordered_set<point> footprints;
    std::unordered_map<point_abs_om, std::vector<urban_district>> overmaps;
    std::vector<std::array<city_zone_center, 4>> land_use;

    void add( point grid, std::size_t city_index,
              std::vector<std::vector<point_abs_omt>> &centers ) {
        if( !footprints.insert( grid ).second ) {
            return;
        }
        const point_abs_omt first( grid * step );
        const point_abs_omt center = first + point( step / 2, step / 2 );
        centers[city_index].push_back( center );
        const point_abs_om lo = project_to<coords::om>( first );
        const point_abs_om hi = project_to<coords::om>( first + point( step - 1, step - 1 ) );
        for( int y = lo.y(); y <= hi.y(); ++y ) {
            for( int x = lo.x(); x <= hi.x(); ++x ) {
                overmaps[point_abs_om( x, y )].push_back( { center, city_index } );
            }
        }
    }

    void fill_missing_footprint( const place &city, std::size_t city_index,
                                 std::vector<std::vector<point_abs_omt>> &centers ) {
        const point grid = divide_xy_round_to_minus_infinity( city.position.raw(), step );
        const int radius = std::clamp( static_cast<int>( std::sqrt( city.population ) / 175 ),
                                       2, 4 );
        const int diameter = 2 * radius + 1;
        const point first = grid - point( radius, radius );
        const point_abs_omt first_center( first * step + point( step / 2, step / 2 ) );
        const std::vector<terrain> terrain_samples = raster( first_center, diameter, diameter, step );
        for( int y = -radius; y <= radius; ++y ) {
            for( int x = -radius; x <= radius; ++x ) {
                const int sample = ( y + radius ) * diameter + x + radius;
                if( x * x + y * y <= radius * radius && terrain_samples[sample] == terrain::land ) {
                    add( grid + point( x, y ), city_index, centers );
                }
            }
        }
    }

    std::array<city_zone_center, 4> plan_city( const place &city,
            const std::vector<point_abs_omt> &districts ) const {
        std::array<city_zone_center, 4> zones{};
        if( districts.empty() ) {
            return zones;
        }
        const int span = std::clamp( static_cast<int>( std::sqrt( districts.size() ) * step / 2 ),
                                     step, 220 );
        const int core_radius = std::clamp( static_cast<int>( std::sqrt( city.population ) / 45 ),
                                            9, 60 );
        const point side = ( city.position.x() + city.position.y() ) % 2 ? point::east : point::west;
        zones = {{
                { city.position, core_radius, urban_zone::downtown },
                { city.position + side *( span / 2 ), core_radius / 2 + 5, urban_zone::commercial },
                { city.position + point::north *( span / 2 ), core_radius / 2 + 4, urban_zone::institutional },
                {
                    city.position - side *span + point::south *( span / 3 ), core_radius / 2 + 7,
                    urban_zone::industrial
                }
            }
        };
        for( std::size_t z = 0; z < zones.size(); ++z ) {
            const point_abs_omt target = zones[z].center;
            int lowest_cost = std::numeric_limits<int>::max();
            for( const point_abs_omt &district : districts ) {
                for( int y : {
                         -1, 0, 1
                         } ) {
                    for( int x : {
                             -1, 0, 1
                             } ) {
                        const point_abs_omt candidate = district + point( x, y ) * ( step / 3 );
                        int cost = square_dist( target, candidate );
                        for( std::size_t prev = 0; prev < z; ++prev ) {
                            const int separation = square_dist( zones[prev].center, candidate );
                            const int required = zones[prev].radius + zones[z].radius;
                            if( separation == 0 ) {
                                cost += 100'000;
                            } else if( separation < required ) {
                                cost += ( required - separation ) * 4;
                            }
                        }
                        if( cost < lowest_cost ) {
                            lowest_cost = cost;
                            zones[z].center = candidate;
                        }
                    }
                }
            }
        }
        for( city_zone_center &zone : zones ) {
            for( const city_zone_center &other : zones ) {
                if( zone.zone != other.zone ) {
                    zone.radius = std::min( zone.radius, square_dist( zone.center, other.center ) / 2 );
                }
            }
        }
        return zones;
    }

    urban_atlas() {
        const auto &places = cities();
        std::vector<std::vector<point_abs_omt>> centers( places.size() );
        if( !read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america.urban",
        [&]( const JsonValue & value ) {
        const JsonObject root = value.get_object();
            step = root.get_int( "district_size" );
            if( root.get_int( "version" ) != 1 || step < 3 || step > OMAPX ) {
                root.throw_error( "Invalid urban footprint atlas" );
            }
            for( const JsonValue row : root.get_array( "districts" ) ) {
                const JsonArray record = row.get_array();
                const point grid( record.get_int( 0 ), record.get_int( 1 ) );
                const int index = record.get_int( 2 );
                if( index < 0 || static_cast<std::size_t>( index ) >= places.size() ) {
                    record.throw_error( "Invalid urban district city" );
                }
                add( grid, static_cast<std::size_t>( index ), centers );
            }
        } ) ) {
            return;
        }
        land_use.resize( places.size() );
        for( std::size_t index = 0; index < places.size(); ++index ) {
            const place &city = places[index];
            // The atlas already has the Sinaloa city and its real footprint.
            // Do not synthesize a second Mazatlan from the erroneous Sonora record.
            const bool duplicate_mazatlan = city.country == "Mexico" && city.region == "Sonora" &&
                                            city.name == "Mazatl\u00e1n";
            if( centers[index].empty() && city.population >= minimum_zoned_population &&
                !duplicate_mazatlan ) {
                fill_missing_footprint( city, index, centers );
            }
            land_use[index] = plan_city( city, centers[index] );
        }
        for( auto &entry : overmaps ) {
            for( urban_district &district : entry.second ) {
                const point grid = divide_xy_round_to_minus_infinity( district.center.raw(), step );
                for( std::size_t i = 0; i < district_neighbors.size(); ++i ) {
                    if( !footprints.count( grid + district_neighbors[i] ) ) {
                        district.open_edges |= 1U << i;
                    }
                }
            }
        }
    }
};

const urban_atlas &get_urban_atlas()
{
    static const urban_atlas data;
    return data;
}

const ecology_profile *profile_at( point_abs_omt pos )
{
    const ecology_atlas &data = get_ecology();
    const int i = data.index( pos );
    if( i < 0 ) {
        return nullptr;
    }
    if( data.cells[i] != 0 ) {
        return &data.profiles[data.cells[i]];
    }
    // The coarse cell center can be offshore even when a map tile is on land.
    const point origin( i % data.width, i / data.width );
    for( const point &delta : {
             point::north, point::west, point::east, point::south
         } ) {
        const point neighbor = origin + delta;
        if( neighbor.x < 0 || neighbor.x >= data.width || neighbor.y < 0 || neighbor.y >= data.height ) {
            continue;
        }
        const size_t profile = data.cells[neighbor.y * data.width + neighbor.x];
        if( profile != 0 ) {
            return &data.profiles[profile];
        }
    }
    return nullptr;
}

} // namespace

float forest_adjustment( point_abs_omt pos )
{
    const ecology_atlas &data = get_ecology();
    const int i = data.index( pos );
    if( i < 0 || data.cells[i] == 0 ) {
        const ecology_profile *profile = profile_at( pos );
        return profile ? profile->biome.forest_adjustment : 0;
    }
    const float biome = data.profiles[data.cells[i]].biome.forest_adjustment;
    const int cover = data.forest_cover[i];
    // MODIS land cover biases local noise without flattening the region to one
    // dominant terrain. Sparse cover can still produce isolated groves.
    return cover == 0 ? biome : biome + ( cover - 3 ) * 0.085f;
}

const std::vector<urban_district> &urban_districts_in( point_abs_om pos )
{
    static const std::vector<urban_district> empty;
    const auto &overmaps = get_urban_atlas().overmaps;
    const auto district = overmaps.find( pos );
    return district == overmaps.end() ? empty : district->second;
}

int urban_district_size()
{
    return get_urban_atlas().step;
}

const std::array<city_zone_center, 4> &city_zone_centers( std::size_t city_index )
{
    static const std::array<city_zone_center, 4> empty{};
    const auto &zones = get_urban_atlas().land_use;
    return city_index < zones.size() ? zones[city_index] : empty;
}

bool in_urban_footprint( point_abs_omt pos, int margin )
{
    const urban_atlas &atlas = get_urban_atlas();
    const point offset( margin, margin );
    const point lo = divide_xy_round_to_minus_infinity( pos.raw() - offset, atlas.step );
    const point hi = divide_xy_round_to_minus_infinity( pos.raw() + offset, atlas.step );
    for( int y = lo.y; y <= hi.y; ++y ) {
        for( int x = lo.x; x <= hi.x; ++x ) {
            if( atlas.footprints.count( point( x, y ) ) ) {
                return true;
            }
        }
    }
    return false;
}

int urban_density( const urban_district &district, point_abs_omt pos )
{
    if( !district.open_edges ) {
        return 100;
    }
    const int step = urban_district_size();
    const point p = pos.raw() - district.center.raw() + point( step / 2, step / 2 );
    const std::array<int, 4> distance{{ p.y, step - 1 - p.x, step - 1 - p.y, p.x }};
    constexpr int fringe = 20;
    int depth = fringe + 5;
    for( int i = 0; i < 4; ++i ) {
        const int next = ( i + 1 ) % 4;
        const bool open = district.open_edges & ( 1U << i );
        if( open ) {
            depth = std::min( depth, distance[i] );
        }
        if( open && ( district.open_edges & ( 1U << next ) ) ) {
            // Cut back the square corners where two exposed sides meet.
            depth = std::min( depth, ( distance[i] + distance[next] - 14 ) * 3 / 4 );
        }
        if( district.open_edges & ( 1U << ( i + 4 ) ) ) {
            depth = std::min( depth, ( distance[i] + distance[next] ) * 3 / 4 );
        }
    }
    // A low-frequency edge varies at neighborhood scale and is continuous at district seams.
    const auto wave = []( int coordinate, int period ) {
        const int phase = modulo( coordinate, period );
        return std::min( phase, period - phase );
    };
    const int variation = ( wave( pos.x(), 39 ) + wave( pos.y(), 53 ) ) / 4 - 5;
    return std::clamp( ( depth + variation - 2 ) * 100 / fringe, 0, 100 );
}

int population_band( point_abs_omt pos )
{
    const ecology_atlas &data = get_ecology();
    const int i = data.index( pos );
    return i >= 0 ? data.population[i] : 0;
}

int rural_population_band( point_abs_omt pos )
{
    return in_urban_footprint( pos ) ? 0 : population_band( pos );
}

double rural_city_multiplier( point_abs_om pos )
{
    static constexpr std::array<double, 8> town_frequency{
        0.0, 0.012, 0.05, 0.14, 0.30, 0.55, 0.85, 1.1
    };
    const point_abs_omt origin = project_to<coords::omt>( pos );
    double sum = 0.0;
    constexpr int samples = 4;
    for( int y = 0; y < samples; ++y ) {
        for( int x = 0; x < samples; ++x ) {
            const point offset( ( 2 * x + 1 ) * OMAPX / ( 2 * samples ),
                                ( 2 * y + 1 ) * OMAPY / ( 2 * samples ) );
            sum += town_frequency[rural_population_band( origin + offset )];
        }
    }
    return sum / ( samples * samples );
}

int named_city_size( int population )
{
    return std::clamp( 2 + static_cast<int>( std::sqrt( std::max( 0, population ) / 220.0 ) ), 2, 55 );
}

int rural_town_size( point_abs_omt pos )
{
    static constexpr std::array<int, 8> size_by_density{ 0, 2, 2, 3, 4, 5, 7, 10 };
    int size = size_by_density[rural_population_band( pos )];
    if( size <= 2 ) {
        return size;
    }
    // The footprint is incomplete around small remote towns. Keep nearby
    // procedural settlements below the size of the recorded local centre.
    constexpr int proximity = 1400; // 33.6 km
    for( const place &settlement : cities() ) {
        if( settlement.population < 20000 &&
            square_dist( settlement.position.raw(), pos.raw() ) <= proximity ) {
            size = std::min( size, std::max( 2, named_city_size( settlement.population ) - 1 ) );
        }
    }
    return size;
}

std::string ecoregion_code( point_abs_omt pos )
{
    const ecology_profile *profile = profile_at( pos );
    return profile ? profile->ecoregion : std::string();
}

oter_id wilderness_terrain( point_abs_omt pos, const oter_id &original )
{
    const std::string &type = original->get_type_id().str();
    if( type != "field" && type != "forest" && type != "forest_thick" && type != "forest_water" ) {
        return original;
    }
    if( in_urban_footprint( pos ) ) {
        return original;
    }
    const ecology_profile *profile = profile_at( pos );
    const habitat *local = habitat_at( pos, profile ? std::string_view( profile->ecoregion ) :
                                      std::string_view(),
                                      type == "forest_water" );
    return local && local->terrain.is_valid() ? local->terrain.id() : original;
}

bool draw_native_habitat( mapgendata &dat )
{
    if( !active() || dat.zlevel() != 0 ) {
        return false;
    }
    const habitat *local = habitat_by_terrain( dat.terrain_type() );
    if( !local || !local->base.is_valid() ) {
        return false;
    }
    mapgendata base( dat, local->base.id() );
    for( oter_id &neighbor : base.t_nesw ) {
        if( const habitat *adjacent = habitat_by_terrain( neighbor ) ) {
            neighbor = adjacent->base.id();
        }
    }
    return run_mapgen_func( local->base->get_mapgen_id(), base );
}

void place_native_vegetation( mapgendata &dat )
{
    if( dat.zlevel() != 0 || !active() ) {
        return;
    }
    if( const habitat *local = habitat_by_terrain( dat.terrain_type() ) ) {
        draw_habitat_cover( dat, *local );
        return;
    }
    const std::string &terrain = dat.terrain_type()->get_type_id().str();
    const bool field = terrain == "field";
    const bool forest = terrain == "forest" || terrain == "forest_thick" ||
                        terrain == "forest_water";
    if( !field && !forest ) {
        return;
    }
    const ecology_profile *profile = profile_at( dat.pos().xy() );
    if( !profile ) {
        return;
    }

    weighted_int_list<ter_id> trees;
    weighted_int_list<ter_id> shrubs;
    for( const plant &p : profile->plants ) {
        if( p.weight > 0 && p.terrain.is_valid() ) {
            ( p.shrub ? shrubs : trees ).add( p.terrain.id(), p.weight );
        }
    }
    const std::array<ter_id, 4> ground{
        ter_t_grass.id(), ter_t_grass_long.id(), ter_t_grass_tall.id(), ter_t_dirt.id()
    };
    const ter_id groundcover = profile->biome.groundcover.id();
    const ter_id null_terrain = ter_str_id::NULL_ID().id();
    const bool keep_eastern_harvests = profile->ecoregion == "5.3" || profile->ecoregion == "8.1";
    const bool sparse_canopy = profile->biome.forest_adjustment < -0.30f;
    map &here = dat.m;
    for( int y = 0; y < 2 * SEEY; ++y ) {
        for( int x = 0; x < 2 * SEEX; ++x ) {
            const point_bub_ms pos( x, y );
            const ter_id original = here.ter( pos );
            if( original->has_flag( ter_furn_flag::TFLAG_TREE ) ||
                original->has_flag( ter_furn_flag::TFLAG_YOUNG ) ) {
                if( keep_eastern_harvests && one_in( 2 ) ) {
                    continue;
                }
                if( const ter_id *replacement = trees.pick() ) {
                    here.ter_set( pos, *replacement );
                } else if( sparse_canopy && groundcover != null_terrain ) {
                    here.ter_set( pos, groundcover );
                }
            } else if( original->has_flag( ter_furn_flag::TFLAG_SHRUB ) ) {
                if( keep_eastern_harvests && one_in( 2 ) ) {
                    continue;
                }
                if( const ter_id *replacement = shrubs.pick() ) {
                    here.ter_set( pos, *replacement );
                }
            } else if( field && !here.has_furn( pos ) &&
                       std::find( ground.begin(), ground.end(), original ) != ground.end() ) {
                if( x_in_y( profile->biome.open_shrub_percent, 100 ) ) {
                    if( const ter_id *replacement = shrubs.pick() ) {
                        here.ter_set( pos, *replacement );
                        continue;
                    }
                }
                if( groundcover != null_terrain && one_in( 2 ) ) {
                    here.ter_set( pos, groundcover );
                }
            }
        }
    }
}

} // namespace north_america
