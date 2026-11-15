#include "north_america.h"

#include <algorithm>
#include <cmath>
#include <unordered_map>
#include <utility>

#include "cata_utility.h"
#include "city.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "mongroup.h"
#include "mp_client_conn.h"
#include "options.h"
#include "path_info.h"
#include "worldfactory.h"

namespace north_america
{
struct regional_loot_table {
    std::unordered_map<item_group_id, item_group_id> groups;
    std::string civic_flag;

    void add_groups( const JsonArray &ids, const std::string &suffix ) {
        for( const JsonValue value : ids ) {
            const std::string base = value.get_string();
            groups.emplace( item_group_id( base ), item_group_id( base + "-" + suffix ) );
        }
    }
};

namespace
{

constexpr double pi = 3.14159265358979323846;
constexpr double radians = pi / 180.0;
constexpr double bedford_latitude = 42.47 * radians;
constexpr double bedford_longitude = -71.2894;
constexpr double earth_radius = 6371000.0;
constexpr int tile_metres = coords::map_squares_per( coords::scale::overmap_terrain );

struct bounds {
    point min;
    point max;

    bool intersects( const bounds &other ) const {
        return min.x <= other.max.x && max.x >= other.min.x &&
               min.y <= other.max.y && max.y >= other.min.y;
    }
};

bounds extent( const std::vector<point> &path )
{
    bounds result{ path.front(), path.front() };
    for( const point &p : path ) {
        result.min.x = std::min( result.min.x, p.x );
        result.min.y = std::min( result.min.y, p.y );
        result.max.x = std::max( result.max.x, p.x );
        result.max.y = std::max( result.max.y, p.y );
    }
    return result;
}

std::vector<point> read_path( const JsonArray &vertices )
{
    std::vector<point> result;
    result.reserve( vertices.size() );
    for( const JsonValue value : vertices ) {
        const JsonArray vertex = value.get_array();
        result.emplace_back( vertex.get_int( 0 ), vertex.get_int( 1 ) );
    }
    return result;
}

struct feature {
    std::vector<std::vector<point>> paths;
    bounds box;
    std::unordered_map<int, std::vector<std::pair<point, point>>> edges_by_band;
};

// Horizontal scanlines only need edges in their latitude band. Index by
// projected metres, including bands west/north of the atlas origin.
constexpr int edge_band_width = 8192;
int edge_band( int y )
{
    return y / edge_band_width - ( y % edge_band_width < 0 ? 1 : 0 );
}

void index_edges( feature &polygon )
{
    for( const auto &ring : polygon.paths ) {
        for( size_t i = 1; i < ring.size(); ++i ) {
            const point a = ring[i - 1];
            const point b = ring[i];
            if( a.y == b.y ) {
                continue;
            }
            for( int band = edge_band( std::min( a.y, b.y ) );
                 band <= edge_band( std::max( a.y, b.y ) - 1 ); ++band ) {
                polygon.edges_by_band[band].emplace_back( a, b );
            }
        }
    }
}

struct atlas {
    std::vector<feature> land;
    std::vector<feature> lakes;
    std::vector<feature> rivers;
    std::vector<place> cities;
    std::unordered_map<point_abs_om, std::vector<size_t>> cities_by_overmap;
    bool loaded = false;

    atlas() {
        loaded = read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america.atlas",
        [this]( const JsonValue & value ) {
            const JsonObject root = value.get_object();
            if( root.get_int( "version" ) != 1 ) {
                root.throw_error( "Unknown North America atlas version" );
            }
            for( const auto &layer : {
                     std::make_pair( "land", &land ),
                     std::make_pair( "lakes", &lakes )
                 } ) {
                for( const JsonValue polygon : root.get_array( layer.first ) ) {
                    feature f;
                    for( const JsonValue ring : polygon.get_array() ) {
                        auto path = read_path( ring.get_array() );
                        if( path.size() >= 4 ) {
                            f.paths.push_back( std::move( path ) );
                        }
                    }
                    if( !f.paths.empty() ) {
                        f.box = extent( f.paths.front() );
                        index_edges( f );
                        layer.second->push_back( std::move( f ) );
                    }
                }
            }
            for( const JsonValue line : root.get_array( "rivers" ) ) {
                auto path = read_path( line.get_array() );
                if( path.size() >= 2 ) {
                    feature f;
                    f.box = extent( path );
                    f.paths.push_back( std::move( path ) );
                    rivers.push_back( std::move( f ) );
                }
            }
            for( const JsonValue value : root.get_array( "cities" ) ) {
                const JsonArray entry = value.get_array();
                const point_abs_ms p( entry.get_int( 3 ), entry.get_int( 4 ) );
                cities.push_back( { entry.get_string( 0 ), entry.get_string( 1 ),
                                    entry.get_string( 2 ), project_to<coords::omt>( p ),
                                    entry.get_int( 5 ) } );
                cities_by_overmap[project_to<coords::om>( cities.back().position )].push_back(
                    cities.size() - 1 );
            }
        } );
    }
};

const atlas &get_atlas()
{
    static const atlas instance;
    return instance;
}

struct jurisdiction_polygon {
    std::string code;
    feature area;

    bool contains( point p ) const {
        if( !area.box.intersects( { p, p } ) ) {
            return false;
        }
        const auto edges = area.edges_by_band.find( edge_band( p.y ) );
        if( edges == area.edges_by_band.end() ) {
            return false;
        }
        bool inside = false;
        for( const auto &[a, b] : edges->second ) {
            if( ( a.y > p.y ) == ( b.y > p.y ) ) {
                continue;
            }
            const double x = a.x + static_cast<double>( b.x - a.x ) * ( p.y - a.y ) / ( b.y - a.y );
            if( p.x < x ) {
                inside = !inside;
            }
        }
        return inside;
    }
};

constexpr int jurisdiction_cell_size = 131072;

point jurisdiction_cell( point p )
{
    const auto index = []( int metres ) {
        return metres / jurisdiction_cell_size - ( metres % jurisdiction_cell_size < 0 ? 1 : 0 );
    };
    return point( index( p.x ), index( p.y ) );
}

struct jurisdiction_index {
    std::vector<jurisdiction_polygon> polygons;
    std::unordered_map<point, std::vector<size_t>> cells;
};

const jurisdiction_index &jurisdictions()
{
    static const auto index = [] {
        jurisdiction_index result;
        read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america.jurisdictions",
        [&]( const JsonValue & value ) {
            const JsonObject root = value.get_object();
            if( root.get_int( "version" ) != 1 ) {
                root.throw_error( "Unknown North America jurisdictions version" );
            }
            for( const JsonValue row : root.get_array( "polygons" ) ) {
                const JsonArray entry = row.get_array();
                feature area;
                for( const JsonValue ring : entry.get_array( 1 ) ) {
                    auto path = read_path( ring.get_array() );
                    if( path.size() >= 4 && path.front() == path.back() ) {
                        area.paths.push_back( std::move( path ) );
                    }
                }
                if( !area.paths.empty() ) {
                    area.box = extent( area.paths.front() );
                    index_edges( area );
                    // Queries use only the indexed edges and the bounding box.
                    area.paths.clear();
                    const point low = jurisdiction_cell( area.box.min );
                    const point high = jurisdiction_cell( area.box.max );
                    for( int x = low.x; x <= high.x; ++x ) {
                        for( int y = low.y; y <= high.y; ++y ) {
                            result.cells[point( x, y )].push_back( result.polygons.size() );
                        }
                    }
                    result.polygons.push_back( { entry.get_string( 0 ), std::move( area ) } );
                }
            }
        } );
        return result;
    }();
    return index;
}

const std::unordered_map<std::string, regional_loot_table> &regional_loot_tables()
{
    static const auto tables = [] {
        std::unordered_map<std::string, regional_loot_table> result;
        read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america_loot.json",
        [&]( const JsonValue & value ) {
            const JsonObject root = value.get_object();
            const JsonArray state_groups = root.get_array( "state_groups" );
            const JsonArray firearm_groups = root.get_array( "firearm_groups" );
            const JsonArray uniform_groups = root.get_array( "uniform_groups" );
            for( const JsonValue row : root.get_array( "jurisdictions" ) ) {
                const JsonArray entry = row.get_array();
                const std::string code = entry.get_string( 0 );
                const std::string firearm_profile = entry.get_string( 1 );
                const std::string uniform_profile = entry.get_string( 2 );
                regional_loot_table &table = result[code];
                table.add_groups( state_groups, code );
                table.add_groups( firearm_groups, firearm_profile );
                table.add_groups( uniform_groups, uniform_profile );
            }
            // These keys are consumed by the offline data generator.
            root.allow_omitted_members();
        } );
        read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america_supplies.json",
                             [&]( const JsonValue & value )
        {
            const JsonObject root = value.get_object();
            const JsonArray state_groups = root.get_array( "regional_groups" );
            const JsonArray map_groups = root.get_array( "atlas_map_groups" );
            const JsonArray service_groups = root.get_array( "service_groups" );
            const JsonObject flags = root.get_object( "civic_flags" );
            for( const JsonValue row : root.get_array( "jurisdictions" ) ) {
                const std::string code = row.get_array().get_string( 0 );
                const std::string country = code.substr( 0, 2 );
                regional_loot_table &table = result[code];
                table.add_groups( state_groups, code );
                table.add_groups( map_groups, code );
                if( flags.has_string( country ) ) {
                    table.civic_flag = flags.get_string( country );
                    table.add_groups( service_groups, country );
                }
            }
            root.allow_omitted_members();
        } );
        return result;
    }();
    return tables;
}

thread_local const regional_loot_table *current_loot_table = nullptr;

class water_grid
{
    public:
        water_grid( point_abs_omt origin, int width, int height, int stride )
            : tiles( width * height, terrain::ocean ), width( width ), height( height ),
              step( stride * tile_metres ),
              first( project_to<coords::ms>( origin ).raw() + point( tile_metres / 2, tile_metres / 2 ) ),
              box{ first, first + point( ( width - 1 ) * step, ( height - 1 ) * step ) } {}

        void paint( const feature &polygon, terrain type ) {
            if( !box.intersects( polygon.box ) ) {
                return;
            }
            std::vector<std::vector<double>> crossings( height );
            for( int band = edge_band( first.y ); band <= edge_band( box.max.y ); ++band ) {
                const auto entry = polygon.edges_by_band.find( band );
                if( entry == polygon.edges_by_band.end() ) {
                    continue;
                }
                const int band_begin = row( band * edge_band_width );
                const int band_end = row( ( band + 1 ) * edge_band_width );
                for( const auto &[a, b] : entry->second ) {
                    const int begin = std::max( band_begin, row( std::min( a.y, b.y ) ) );
                    const int end = std::min( band_end, row( std::max( a.y, b.y ) ) );
                    for( int y = begin; y < end; ++y ) {
                        const double t = static_cast<double>( first.y + y * step - a.y ) / ( b.y - a.y );
                        crossings[y].push_back( a.x + t * ( b.x - a.x ) );
                    }
                }
            }
            for( int y = 0; y < height; ++y ) {
                auto &xs = crossings[y];
                std::sort( xs.begin(), xs.end() );
                for( size_t i = 1; i < xs.size(); i += 2 ) {
                    // Even/odd fill uses all rings, preserving holes and islands.
                    std::fill( tiles.begin() + y * width + column( xs[i - 1] ),
                               tiles.begin() + y * width + column( xs[i] ), type );
                }
            }
        }

        void paint_river( const feature &river, bool chart ) {
            // The source supplies centerlines. A three-tile corridor preserves connectivity
            // at this resolution, including on diagonals and across overmap boundaries.
            const int radius = std::max( 3 * tile_metres / 2, chart ? step / 2 : 0 );
            const point padding( radius, radius );
            if( !box.intersects( { river.box.min - padding, river.box.max + padding } ) ) {
                return;
            }
            const auto &line = river.paths.front();
            for( size_t i = 1; i < line.size(); ++i ) {
                const point &a = line[i - 1];
                const point &b = line[i];
                const point delta = b - a;
                const double dx = delta.x;
                const double dy = delta.y;
                const double length_squared = dx * dx + dy * dy;
                if( length_squared == 0 ) {
                    continue;
                }
                const int x0 = column( std::min( a.x, b.x ) - radius );
                const int x1 = column( std::max( a.x, b.x ) + radius + 1 );
                const int y0 = row( std::min( a.y, b.y ) - radius );
                const int y1 = row( std::max( a.y, b.y ) + radius + 1 );
                for( int y = y0; y < y1; ++y ) {
                    const double py = first.y + y * step - a.y;
                    for( int x = x0; x < x1; ++x ) {
                        terrain &cell = tiles[y * width + x];
                        if( cell != terrain::land ) {
                            continue;
                        }
                        const double px = first.x + x * step - a.x;
                        const double t = std::clamp( ( px * dx + py * dy ) / length_squared, 0.0, 1.0 );
                        const double ex = px - t * dx;
                        const double ey = py - t * dy;
                        if( ex * ex + ey * ey <= radius * radius ) {
                            cell = terrain::river;
                        }
                    }
                }
            }
        }

        std::vector<terrain> tiles;

    private:
        int column( double x ) const {
            return std::clamp( static_cast<int>( std::ceil( ( x - first.x ) / step ) ), 0, width );
        }
        int row( int y ) const {
            return std::clamp( static_cast<int>( std::ceil(
                    ( y - static_cast<double>( first.y ) ) / step ) ), 0, height );
        }

        int width;
        int height;
        int step;
        point first;
        bounds box;
};

} // namespace

bool available()
{
    return get_option<std::string>( "WORLD_MAP_GENERATION" ) == "north_america" &&
           get_option<std::string>( "OVERMAP_PREGENERATED_PATH" ).empty() &&
           get_option<std::string>( "DEFAULT_REGION" ) == "default" && city::get_all().empty() &&
           get_atlas().loaded;
}

bool active()
{
    static const dimension_id earth( "default" );
    return g && g->north_america_world && g->get_dimension_prefix() == earth;
}

std::string_view jurisdiction_at( point_abs_ms position )
{
    const auto &index = jurisdictions();
    const auto candidates = index.cells.find( jurisdiction_cell( position.raw() ) );
    if( candidates == index.cells.end() ) {
        return {};
    }
    for( size_t candidate : candidates->second ) {
        const jurisdiction_polygon &polygon = index.polygons[candidate];
        if( polygon.contains( position.raw() ) ) {
            return polygon.code;
        }
    }
    return {};
}

std::string chart_discovery_key( std::string_view jurisdiction )
{
    return "north_america_chart_" + std::string( jurisdiction );
}

scoped_regional_loot::scoped_regional_loot( point_abs_ms position ) :
    previous( current_loot_table )
{
    current_loot_table = nullptr;
    if( active() ) {
        const auto &tables = regional_loot_tables();
        const auto found = tables.find( std::string( jurisdiction_at( position ) ) );
        if( found != tables.end() ) {
            current_loot_table = &found->second;
        }
    }
}

scoped_regional_loot::~scoped_regional_loot()
{
    current_loot_table = previous;
}

const item_group_id &regional_item_group( const item_group_id &base )
{
    if( current_loot_table ) {
        const auto found = current_loot_table->groups.find( base );
        if( found != current_loot_table->groups.end() ) {
            return found->second;
        }
    }
    return base;
}

const std::string &civic_flag_variant()
{
    static const std::string original;
    return current_loot_table ? current_loot_table->civic_flag : original;
}

mtype_id regional_monster( const mtype_id &type, point_abs_ms position )
{
    static const mtype_id swat( "mon_zombie_swat" );
    static const mtype_id marine( "mon_zombie_marine" );
    static const mtype_id stalker( "mon_zombie_marine_upgrade" );
    static const mtype_id swat_ca( "mon_zombie_swat_ca" );
    static const mtype_id swat_mx( "mon_zombie_swat_mx" );
    static const mtype_id marine_ca( "mon_zombie_marine_ca" );
    static const mtype_id marine_mx( "mon_zombie_marine_mx" );
    static const mtype_id stalker_ca( "mon_zombie_marine_upgrade_ca" );
    static const mtype_id stalker_mx( "mon_zombie_marine_upgrade_mx" );
    if( ( type != swat && type != marine && type != stalker ) || !active() ) {
        return type;
    }
    const std::string_view code = jurisdiction_at( position );
    const bool canada = code.substr( 0, 3 ) == "CA-";
    if( !canada && code.substr( 0, 3 ) != "MX-" ) {
        return type;
    }
    const mtype_id &variant = type == swat ? ( canada ? swat_ca : swat_mx ) :
                             type == marine ? ( canada ? marine_ca : marine_mx ) :
                             ( canada ? stalker_ca : stalker_mx );
    return variant.is_valid() && !MonsterGroupManager::monster_is_blacklisted( variant ) ?
           variant : type;
}

bool offer_starting_city()
{
    return !cata_mp::is_client_mode() && world_generator && world_generator->active_world &&
           world_generator->active_world->world_saves.empty() && available();
}

const std::vector<place> &cities()
{
    return get_atlas().cities;
}

const std::vector<size_t> &cities_in( point_abs_om overmap )
{
    static const std::vector<size_t> empty;
    const auto &index = get_atlas().cities_by_overmap;
    const auto it = index.find( overmap );
    return it == index.end() ? empty : it->second;
}

bool suitable_for_highway_intersection( point_abs_om overmap )
{
    // Sample the whole overmap on a coarse lattice. This is a planning hint;
    // the actual route still sees the full-resolution terrain and water.
    constexpr int samples = 9;
    constexpr int stride = OMAPX / samples;
    const point_abs_omt start = project_to<coords::omt>( overmap );
    const auto water = raster( start + point( stride / 2, stride / 2 ), samples, samples, stride );
    return std::count( water.begin(), water.end(), terrain::land ) > samples * samples / 2;
}

bool military_base_region( point_abs_om overmap, unsigned seed )
{
    static const auto spacing = [] {
        std::unordered_map<std::string, unsigned> result;
        read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america_military_density.json",
                             [&]( const JsonValue & value )
        {
            for( JsonMember member : value.get_object() ) {
                const int one_in_overmaps = member.get_int();
                if( one_in_overmaps > 0 ) {
                    result.emplace( member.name(), static_cast<unsigned>( one_in_overmaps ) );
                }
            }
        } );
        return result;
    }();
    const point_abs_ms position = project_to<coords::ms>( overmap ) +
                                  point( OMAPX * tile_metres / 2, OMAPY * tile_metres / 2 );
    const std::string jurisdiction( jurisdiction_at( position ) );
    auto entry = spacing.find( jurisdiction );
    if( entry == spacing.end() ) {
        entry = spacing.find( jurisdiction.substr( 0, 2 ) );
    }
    if( entry == spacing.end() ) {
        return false;
    }
    unsigned hash = static_cast<unsigned>( overmap.x() ) * 3619419497U ^
                    static_cast<unsigned>( overmap.y() ) * 19349663U ^ seed;
    hash ^= hash >> 16;
    hash *= 0x7feb352dU;
    hash ^= hash >> 15;
    return hash % entry->second == 0;
}

regional_climate::coordinates location( point_abs_ms position )
{
    const double east = position.x();
    const double north = -static_cast<double>( position.y() );
    const double distance = std::hypot( east, north );
    if( distance == 0 ) {
        return { bedford_latitude / radians, bedford_longitude };
    }
    const double arc = distance / earth_radius;
    const double sin_arc = std::sin( arc );
    const double cos_arc = std::cos( arc );
    const double sin_lat = std::sin( bedford_latitude );
    const double cos_lat = std::cos( bedford_latitude );
    const double latitude = std::asin( std::clamp( cos_arc * sin_lat +
                                       ( north / distance ) * sin_arc * cos_lat, -1.0, 1.0 ) );
    const double longitude = std::atan2( east * sin_arc,
                                         distance * cos_lat * cos_arc - north * sin_lat * sin_arc );
    return { latitude / radians, std::remainder( bedford_longitude + longitude / radians, 360.0 ) };
}

std::vector<terrain> raster( point_abs_omt origin, int width, int height, int stride, bool chart )
{
    const atlas &data = get_atlas();
    water_grid grid( origin, width, height, stride );
    for( const feature &polygon : data.land ) {
        grid.paint( polygon, terrain::land );
    }
    for( const feature &polygon : data.lakes ) {
        grid.paint( polygon, terrain::lake );
    }
    for( const feature &river : data.rivers ) {
        grid.paint_river( river, chart );
    }
    return std::move( grid.tiles );
}

} // namespace north_america
