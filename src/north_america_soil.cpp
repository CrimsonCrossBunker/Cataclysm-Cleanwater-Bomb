#include "north_america_soil.h"

#include <array>
#include <cmath>
#include <cstdint>
#include <string>
#include <string_view>
#include <vector>

#include "cata_utility.h"
#include "flexbuffer_json.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapgendata.h"
#include "north_america.h"
#include "path_info.h"

namespace north_america
{
namespace
{

const ter_str_id dirt( "t_dirt" );
const ter_str_id dirtmound( "t_dirtmound" );
constexpr std::string_view soil_prefix = "t_atlas_soil_";

const std::array<std::pair<std::string_view, ter_str_id>, 9> soil_forms = {{
        { "", dirt }, { "_tilled", dirtmound },
        { "_long_grass", ter_str_id( "t_grass_long" ) },
        { "_tall_grass", ter_str_id( "t_grass_tall" ) }, { "_dead_grass", ter_str_id( "t_grass_dead" ) },
        { "_grazed_grass", ter_str_id( "t_grass_grazed" ) }, { "_grass", ter_str_id( "t_grass" ) },
        { "_forest_floor", ter_str_id( "t_forestfloor" ) }, { "_moss", ter_str_id( "t_moss" ) }
    }
};

const std::pair<std::string_view, ter_str_id> *soil_form( std::string_view id )
{
    if( id.substr( 0, soil_prefix.size() ) != soil_prefix ) {
        return nullptr;
    }
    for( const auto &form : soil_forms ) {
        const auto suffix = form.first;
        if( !suffix.empty() && id.size() > suffix.size() &&
            id.substr( id.size() - suffix.size() ) == suffix ) {
            return &form;
        }
    }
    return &soil_forms.front();
}

struct soil_atlas {
    double west = -180;
    double north = 90;
    double step = 0;
    std::vector<ter_str_id> types;
    std::vector<std::string> rows;

    char sample( regional_climate::coordinates location ) const {
        if( rows.empty() || step <= 0 ) {
            return '.';
        }
        const int y = static_cast<int>( std::floor( ( north - location.latitude ) / step ) );
        const int x = static_cast<int>( std::floor( ( location.longitude - west ) / step ) );
        return y >= 0 && y < static_cast<int>( rows.size() ) &&
               x >= 0 && x < static_cast<int>( rows[y].size() ) ? rows[y][x] : '.';
    }
};

soil_atlas load_grid( const char *file )
{
    soil_atlas result;
    read_from_file_json( PATH_INFO::datadir_path() / "raw" / file, [&]( const JsonValue & value ) {
        const JsonObject root = value.get_object();
        if( root.get_int( "version" ) != 1 ) {
            root.throw_error( "Unknown North America ground atlas version" );
        }
        result.west = root.get_float( "west" );
        result.north = root.get_float( "north" );
        result.step = root.get_float( "step" );
        if( result.step <= 0 ) {
            root.throw_error( "North America ground atlas has no cell size" );
        }
        if( root.has_member( "types" ) ) {
            for( const JsonValue type : root.get_array( "types" ) ) {
                result.types.emplace_back( "t_atlas_soil_" + type.get_string() );
            }
        }
        for( const JsonValue row : root.get_array( "rows" ) ) {
            result.rows.push_back( row.get_string() );
        }
    } );
    return result;
}

} // namespace

ter_str_id mapped_soil_at( point_abs_ms position )
{
    static const soil_atlas atlas = load_grid( "north_america.soils" );
    const int type = atlas.sample( location( position ) ) - 'A';
    return type >= 0 && type < static_cast<int>( atlas.types.size() ) &&
           atlas.types[type].is_valid() ? atlas.types[type] : dirt;
}

int permafrost_coverage_at( point_abs_ms position )
{
    static const soil_atlas atlas = load_grid( "north_america.permafrost" );
    switch( atlas.sample( location( position ) ) ) {
        case 'C':
            return 95;
        case 'D':
            return 70;
        case 'S':
            return 30;
        case 'I':
            return 5;
        default:
            return 0;
    }
}

void place_native_soil( mapgendata &dat )
{
    if( ( dat.zlevel() != 0 && dat.zlevel() != -1 ) || !active() ) {
        return;
    }
    const point_abs_ms center = project_to<coords::ms>( dat.pos().xy() ) + point( SEEX, SEEY );
    if( dat.zlevel() == -1 ) {
        const int coverage = permafrost_coverage_at( center );
        if( coverage == 0 ) {
            return;
        }
        // Patch size approximates continuous pockets without consuming the worldgen RNG.
        const point patch = divide_xy_round_to_minus_infinity( dat.pos().xy().raw(), 8 );
        std::uint32_t hash = ( static_cast<std::uint32_t>( patch.x ) * 3619419497U ) ^
                             ( static_cast<std::uint32_t>( patch.y ) * 19349663U );
        hash ^= hash >> 16;
        hash *= 0x7feb352dU;
        hash ^= hash >> 15;
        if( hash % 100 >= static_cast<unsigned>( coverage ) ||
            raster( dat.pos().xy(), 1, 1 ).front() != terrain::land ) {
            return;
        }
        static const ter_str_id rock( "t_rock" );
        static const ter_str_id frozen( "t_atlas_permafrost" );
        for( int y = 0; y < 2 * SEEY; ++y ) {
            for( int x = 0; x < 2 * SEEX; ++x ) {
                const point_bub_ms pos( x, y );
                if( dat.m.ter( pos ) == rock ) {
                    dat.m.ter_set( pos, frozen.id() );
                }
            }
        }
        return;
    }
    const ter_str_id soil = mapped_soil_at( center );
    if( soil == dirt ) {
        return;
    }
    std::array<std::pair<ter_id, ter_id>, soil_forms.size()> variants;
    for( size_t i = 0; i < soil_forms.size(); ++i ) {
        const auto &[suffix, base] = soil_forms[i];
        const ter_str_id local( soil.str() + std::string( suffix ) );
        variants[i] = { base.id(), local.is_valid() ? local.id() : base.id() };
    }
    for( int y = 0; y < 2 * SEEY; ++y ) {
        for( int x = 0; x < 2 * SEEX; ++x ) {
            const point_bub_ms pos( x, y );
            const ter_id terrain = dat.m.ter( pos );
            for( const auto &[base, local] : variants ) {
                if( terrain == base && local != base ) {
                    dat.m.ter_set( pos, local );
                    break;
                }
            }
        }
    }
}

ter_id canonical_soil( ter_id terrain )
{
    const std::string_view id = terrain.id().str();
    if( const auto *form = soil_form( id ) ) {
        return form->second.id();
    }
    return terrain;
}

ter_id preserve_soil( ter_id terrain, ter_id replacement )
{
    const std::string &id = terrain.id().str();
    if( const auto *form = soil_form( id ) ) {
        for( const auto &[suffix, base] : soil_forms ) {
            if( replacement == base ) {
                const ter_str_id local( id.substr( 0, id.size() - form->first.size() ) +
                                        std::string( suffix ) );
                return local.is_valid() ? local.id() : replacement;
            }
        }
    }
    return replacement;
}

ter_id tilled_soil( ter_id surface )
{
    return preserve_soil( surface, dirtmound.id() );
}

ter_id planted_soil( ter_id mound )
{
    const std::string &id = mound.id().str();
    if( const auto *form = soil_form( id ) ) {
        if( form->second != dirtmound ) {
            return mound;
        }
        return preserve_soil( mound, dirt.id() );
    }
    return dirt.id();
}

} // namespace north_america
