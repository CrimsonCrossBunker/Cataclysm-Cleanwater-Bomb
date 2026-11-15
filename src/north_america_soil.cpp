#include "north_america_soil.h"

#include <cmath>
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
constexpr std::string_view tilled_suffix = "_tilled";

bool is_local_soil( std::string_view id )
{
    return id.substr( 0, soil_prefix.size() ) == soil_prefix;
}

bool is_tilled( std::string_view id )
{
    return id.size() > tilled_suffix.size() &&
           id.substr( id.size() - tilled_suffix.size() ) == tilled_suffix;
}

struct soil_atlas {
    double west = -180;
    double north = 90;
    double step = 0;
    std::vector<ter_str_id> types;
    std::vector<std::string> rows;
};

const soil_atlas &get_soils()
{
    static const soil_atlas atlas = [] {
        soil_atlas result;
        read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america.soils",
        [&]( const JsonValue & value ) {
            const JsonObject root = value.get_object();
            if( root.get_int( "version" ) != 1 ) {
                root.throw_error( "Unknown North America soil atlas version" );
            }
            result.west = root.get_float( "west" );
            result.north = root.get_float( "north" );
            result.step = root.get_float( "step" );
            if( result.step <= 0 ) {
                root.throw_error( "North America soil atlas has no cell size" );
            }
            for( const JsonValue type : root.get_array( "types" ) ) {
                result.types.emplace_back( "t_atlas_soil_" + type.get_string() );
            }
            for( const JsonValue row : root.get_array( "rows" ) ) {
                result.rows.push_back( row.get_string() );
            }
        } );
        return result;
    }();
    return atlas;
}

} // namespace

ter_str_id mapped_soil_at( point_abs_ms position )
{
    const soil_atlas &atlas = get_soils();
    if( atlas.rows.empty() || atlas.step <= 0 ) {
        return dirt;
    }
    const auto coordinates = location( position );
    const int y = static_cast<int>( std::floor( ( atlas.north - coordinates.latitude ) / atlas.step ) );
    const int x = static_cast<int>( std::floor( ( coordinates.longitude - atlas.west ) / atlas.step ) );
    if( y < 0 || y >= static_cast<int>( atlas.rows.size() ) || x < 0 ||
        x >= static_cast<int>( atlas.rows[y].size() ) ) {
        return dirt;
    }
    const int type = atlas.rows[y][x] - 'A';
    return type >= 0 && type < static_cast<int>( atlas.types.size() ) &&
           atlas.types[type].is_valid() ? atlas.types[type] : dirt;
}

void place_native_soil( mapgendata &dat )
{
    if( dat.zlevel() != 0 || !active() ) {
        return;
    }
    const point_abs_ms center = project_to<coords::ms>( dat.pos().xy() ) + point( SEEX, SEEY );
    const ter_id soil = mapped_soil_at( center ).id();
    if( soil == dirt ) {
        return;
    }
    for( int y = 0; y < 2 * SEEY; ++y ) {
        for( int x = 0; x < 2 * SEEX; ++x ) {
            const point_bub_ms pos( x, y );
            if( dat.m.ter( pos ) == dirt ) {
                dat.m.ter_set( pos, soil );
            }
        }
    }
}

ter_id canonical_soil( ter_id terrain )
{
    const std::string_view id = terrain.id().str();
    if( is_local_soil( id ) ) {
        return is_tilled( id ) ? dirtmound.id() : dirt.id();
    }
    return terrain;
}

ter_id tilled_soil( ter_id surface )
{
    const std::string &id = surface.id().str();
    if( is_local_soil( id ) && !is_tilled( id ) ) {
        const ter_str_id tilled( id + "_tilled" );
        if( tilled.is_valid() ) {
            return tilled.id();
        }
    }
    return dirtmound.id();
}

ter_id planted_soil( ter_id mound )
{
    const std::string &id = mound.id().str();
    if( is_local_soil( id ) ) {
        if( !is_tilled( id ) ) {
            return mound;
        }
        const ter_str_id surface( id.substr( 0, id.size() - tilled_suffix.size() ) );
        if( surface.is_valid() ) {
            return surface.id();
        }
    }
    return dirt.id();
}

} // namespace north_america
