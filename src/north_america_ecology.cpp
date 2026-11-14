#include "north_america_ecology.h"

#include <algorithm>
#include <array>
#include <cstdint>
#include <map>
#include <string>
#include <utility>
#include <vector>

#include "cata_utility.h"
#include "flexbuffer_json.h"
#include "map.h"
#include "mapdata.h"
#include "mapgendata.h"
#include "north_america.h"
#include "omdata.h"
#include "path_info.h"
#include "rng.h"
#include "type_id.h"
#include "weighted_list.h"

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
                    const int x = run.get_int( 0 );
                    const int y = run.get_int( 1 );
                    const int length = run.get_int( 2 );
                    const int index = run.get_int( 3 );
                    if( x < 0 || y < 0 || x >= width || y >= height ||
                        length < 1 || length > width - x || index < 1 || index >= limit ) {
                        run.throw_error( "Invalid North America ecology atlas run" );
                    }
                    std::fill_n( dest.begin() + y * width + x, length, index );
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
    const int x = i % data.width;
    const int y = i / data.width;
    for( const point &delta : {
             point( 0, -1 ), point( -1, 0 ), point( 1, 0 ), point( 0, 1 )
         } ) {
        const point neighbor = point( x, y ) + delta;
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

double rural_city_multiplier( point_abs_om pos )
{
    static constexpr std::array<double, 8> population_multipliers{ 0.0, 0.02, 0.08, 0.18,
            0.38, 0.65, 1.0, 1.35
                                                                 };
    const ecology_atlas &data = get_ecology();
    const point_abs_omt center = project_to<coords::omt>( pos ) + point( OMAPX / 2, OMAPY / 2 );
    const int i = data.index( center );
    return i >= 0 ? population_multipliers[data.population[i]] : 1.0;
}

std::string ecoregion_code( point_abs_omt pos )
{
    const ecology_profile *profile = profile_at( pos );
    return profile ? profile->ecoregion : std::string();
}

void place_native_vegetation( mapgendata &dat )
{
    if( dat.zlevel() != 0 || !active() ) {
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
    static const ter_str_id grass( "t_grass" );
    static const ter_str_id grass_long( "t_grass_long" );
    static const ter_str_id grass_tall( "t_grass_tall" );
    static const ter_str_id dirt( "t_dirt" );
    const std::array<ter_id, 4> ground{ grass.id(), grass_long.id(), grass_tall.id(), dirt.id() };
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