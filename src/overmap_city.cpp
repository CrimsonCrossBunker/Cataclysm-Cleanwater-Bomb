#include <algorithm>
#include <array>
#include <cmath>
#include <cstddef>
#include <functional>
#include <iterator>
#include <initializer_list>
#include <optional>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "city.h"
#include "common_types.h"
#include "coordinates.h"
#include "cuboid_rectangle.h"
#include "debug.h"
#include "flood_fill.h"
#include "map_iterator.h"
#include "map_scale_constants.h"
#include "north_america.h"
#include "north_america_ecology.h"
#include "north_america_transport.h"
#include "omdata.h"
#include "overmap.h"
#include "overmap_connection.h"
#include "overmap_location.h"
#include "overmapbuffer.h"
#include "point.h"
#include "regional_settings.h"
#include "rng.h"
#include "simple_pathfinding.h"
#include "text_snippets.h"
#include "type_id.h"

static const oter_str_id oter_road_nesw( "road_nesw" );
static const oter_str_id oter_road_nesw_manhole( "road_nesw_manhole" );

static const oter_type_str_id oter_type_road( "road" );

static constexpr int BUILDINGCHANCE = 4;

static pf::directed_path<point_om_omt> straight_path( const point_om_omt &source,
        om_direction::type dir, size_t len )
{
    pf::directed_path<point_om_omt> res;
    if( len == 0 ) {
        return res;
    }
    point_om_omt p = source;
    res.nodes.reserve( len );
    for( size_t i = 0; i + 1 < len; ++i ) {
        res.nodes.emplace_back( p, dir );
        p += om_direction::displace( dir );
    }
    res.nodes.emplace_back( p, om_direction::type::invalid );
    return res;
}

overmap_special_id north_america::regional_house_for( std::string_view jurisdiction )
{
    static const auto styles = [] {
        std::unordered_map<std::string_view, overmap_special_id> result;
        const auto add = [&]( const char *house, std::initializer_list<std::string_view> areas )
        {
            for( const std::string_view area : areas ) {
                result.emplace( area, overmap_special_id( house ) );
            }
        };
        add( "house_regional_cape_cod", { "US-CT", "US-MA", "US-ME", "US-NH", "US-RI", "US-VT",
                                          "CA-NB", "CA-NL", "CA-NS", "CA-PE"
                                        } );
        add( "house_regional_craftsman", { "US-CA", "US-OR", "US-WA", "CA-BC" } );
        add( "house_regional_shotgun", { "US-AL", "US-GA", "US-LA", "US-MS", "US-SC" } );
        add( "house_regional_prairie", { "US-AK", "US-MN", "US-MT", "US-ND", "US-NE", "US-SD",
                                         "CA-AB", "CA-MB", "CA-SK"
                                       } );
        add( "house_regional_brick_bungalow", { "US-IA", "US-IL", "US-IN", "US-MI", "US-MO",
                                                "US-NJ", "US-NY", "US-OH", "US-PA", "US-WI", "CA-ON"
                                              } );
        add( "house_regional_adobe", { "US-AZ", "US-NM", "MX-CHH", "MX-COA", "MX-SON" } );
        add( "house_regional_quebec", { "CA-QC" } );
        return result;
    }();
    const auto found = styles.find( jurisdiction );
    if( found != styles.end() ) {
        return found->second;
    }
    const std::string_view country = jurisdiction.substr( 0, 3 );
    if( country == "MX-" ) {
        static const overmap_special_id patio( "house_regional_mexican_patio" );
        return patio;
    }
    if( country == "US-" ) {
        static const overmap_special_id ranch( "house_regional_ranch" );
        return ranch;
    }
    return overmap_special_id::NULL_ID();
}

/*: the root is overmap::place_cities()
20:50 <kevingranade>: which is at overmap.cpp:1355 or so
20:51 <kevingranade>: the key is cs = rng(4, 17), setting the "size" of the city
20:51 <kevingranade>: which is roughly it's radius in overmap tiles
20:52 <kevingranade>: then later overmap::place_mongroups() is called
20:52 <kevingranade>: which creates a mongroup with radius city_size * 2.5 and population city_size * 80
20:53 <kevingranade>: tadaa

spawns happen at... <cue Clue music>
20:56 <kevingranade>: game:pawn_mon() in game.cpp:7380*/
void overmap::place_cities()
{
    const region_settings_city &city_settings = settings->get_settings_city();
    int op_city_spacing = city_settings.city_spacing;
    int op_city_size = city_settings.city_size;
    int max_urbanity = settings->max_urban;
    if( op_city_size <= 0 ) {
        return;
    }
    // make sure city size adjust is never high enough to drop op_city_size below 2
    int city_size_adjust = std::min( urbanity - static_cast<int>( forestosity / 2.0f ),
                                     -1 * op_city_size + 2 );
    int city_space_adjust = urbanity / 2;
    int max_city_size = std::min( op_city_size + city_size_adjust, op_city_size * max_urbanity );
    if( max_city_size < op_city_size ) {
        // funny things happen if max_city_size is less than op_city_size.
        max_city_size = op_city_size;
    }
    if( op_city_spacing > 0 ) {
        city_space_adjust = std::min( city_space_adjust, op_city_spacing - 2 );
        op_city_spacing = op_city_spacing - city_space_adjust + static_cast<int>( forestosity );
    }
    // make sure not to get too extreme on the spacing if you go way far.
    op_city_spacing = std::min( op_city_spacing, 10 );

    // spacing dictates how much of the map is covered in cities
    //   city  |  cities  |   size N cities per overmap
    // spacing | % of map |  2  |  4  |  8  |  12 |  16
    //     0   |   ~99    |2025 | 506 | 126 |  56 |  31
    //     1   |    50    |1012 | 253 |  63 |  28 |  15
    //     2   |    25    | 506 | 126 |  31 |  14 |   7
    //     3   |    12    | 253 |  63 |  15 |   7 |   3
    //     4   |     6    | 126 |  31 |   7 |   3 |   1
    //     5   |     3    |  63 |  15 |   3 |   1 |   0
    //     6   |     1    |  31 |   7 |   1 |   0 |   0
    //     7   |     0    |  15 |   3 |   0 |   0 |   0
    //     8   |     0    |   7 |   1 |   0 |   0 |   0

    const double omts_per_overmap = OMAPX * OMAPY;
    const double city_map_coverage_ratio = 1.0 / std::pow( 2.0, op_city_spacing );
    const double omts_per_city = ( op_city_size * 2 + 1 ) * ( max_city_size * 2 + 1 ) * 3 / 4.0;


    const bool atlas_world = north_america::active();
    const point_abs_omt atlas_origin = project_to<coords::omt>( pos() );
    if( atlas_world ) {
        const auto add_atlas_city = [&]( const north_america::place & place, point_abs_omt origin,
        int size, bool bounded ) {
            const point local = origin.raw() - atlas_origin.raw();
            const point_om_omt center( std::clamp( local.x, 1, OMAPX - 2 ),
                                       std::clamp( local.y, 1, OMAPY - 2 ) );
            const int step = north_america::urban_district_size();
            const int half = step / 2;
            std::optional<point_om_omt> location;
            for( const point_om_omt &candidate : closest_points_first( center, bounded ? half : 12 ) ) {
                const tripoint_om_omt p( candidate, 0 );
                if( !inbounds( p, 1 ) || ter( p )->is_water() || city_tiles.count( candidate ) ) {
                    continue;
                }
                if( bounded ) {
                    const point offset = candidate.raw() - local;
                    if( offset.x < -half || offset.x >= step - half ||
                        offset.y < -half || offset.y >= step - half ) {
                        continue;
                    }
                }
                if( !location || ter( p )->type_is( oter_type_road ) ) {
                    location = candidate;
                }
                if( !bounded || ter( p )->type_is( oter_type_road ) ) {
                    break;
                }
            }
            if( location ) {
                city seed( place.name, *location, size );
                seed.pos_om = pos();
                seed.population = place.population;
                if( !bounded ) {
                    ter_set( tripoint_om_omt( *location, 0 ), oter_road_nesw );
                    city_tiles.insert( *location );
                }
                cities.push_back( seed );
            }
        };
        const auto &districts = north_america::urban_districts_in( pos() );
        const int district_size = north_america::urban_district_size() / 2 - 1;
        for( const north_america::urban_district &district : districts ) {
            if( project_to<coords::om>( district.center ) == pos() ) {
                add_atlas_city( north_america::cities()[district.city_index], district.center,
                                district_size, true );
            }
        }
        // An overmap can contain the edge of a built-up area without containing
        // any district centre. Give that settlement a local anchor only if needed.
        for( const north_america::urban_district &district : districts ) {
            if( project_to<coords::om>( district.center ) == pos() ) {
                continue;
            }
            const north_america::place &place = north_america::cities()[district.city_index];
            if( std::none_of( cities.begin(), cities.end(), [&]( const city & c ) {
            return c.name == place.name;
        } ) ) {
                add_atlas_city( place, district.center, district_size, true );
            }
        }
        for( const size_t index : north_america::cities_in( pos() ) ) {
            const north_america::place &place = north_america::cities()[index];
            if( place.population < north_america::minimum_zoned_population &&
                !north_america::in_urban_footprint( place.position ) ) {
                add_atlas_city( place, place.position, north_america::named_city_size( place.population ),
                                false );
            }
        }
        if( !cities.empty() ) {
            return;
        }
    }
    const bool use_random_cities = city::get_all().empty();

    int num_cities_on_this_overmap = 0;
    std::vector<city> cities_to_place;

    if( !use_random_cities ) {
        // how many predetermined cities on this overmap?
        for( const city &c : city::get_all() ) {
            if( c.pos_om == pos() ) {
                num_cities_on_this_overmap++;
                cities_to_place.emplace_back( c );
            }
        }
    } else {
        // Random cities if no cities were defined in regional settings
        const double density = atlas_world ? north_america::rural_city_multiplier( pos() ) : 1.0;
        num_cities_on_this_overmap = roll_remainder( density * omts_per_overmap *
                                     city_map_coverage_ratio / omts_per_city );
    }

    if( num_cities_on_this_overmap == 0 && !city_settings.is_megacity ) {
        return;
    }
    tripoint_range city_candidates_range = points_in_radius_where(
            tripoint_om_omt( OMAPX / 2, OMAPY / 2, 0 ),
    OMAPX / 2 - ( atlas_world ? 10 : max_city_size ), [&]( const tripoint_om_omt & p ) {
        return ter( p ) == settings->default_oter[OVERMAP_DEPTH] &&
               ( !atlas_world || north_america::rural_population_band( atlas_origin + p.xy().raw() ) > 0 );
    } );
    std::vector<tripoint_om_omt> city_candidates( city_candidates_range.begin(),
            city_candidates_range.end() );

    const size_t num_cities_on_this_overmap_count = num_cities_on_this_overmap;

    if( city_settings.is_megacity ) {
        // Clang pls. These are separate variables for legibility.
        // NOLINTNEXTLINE(cata-combine-locals-into-point)
        const int quarter_OMAPX = OMAPX / 4;
        const int quarter_OMAPY = OMAPY / 4;
        // This places 4 equidistant "individual cities" on every overmap, guaranteed. We're essentially building a smaller square within the square overmap.
        // For space-filling reasons there is now a fifth in the exact center.
        std::vector<tripoint_om_omt> megacity_quad_points = {
            {quarter_OMAPX, quarter_OMAPY, 0},
            {quarter_OMAPX, quarter_OMAPY * 3, 0},
            {quarter_OMAPX * 2, quarter_OMAPY * 2, 0},
            {quarter_OMAPX * 3, quarter_OMAPY, 0},
            {quarter_OMAPX * 3, quarter_OMAPY * 3, 0}
        };
        for( tripoint_om_omt selected_point : megacity_quad_points ) {
            city tmp( SNIPPET.expand( settings->get_settings_city().name_snippet ) );
            tmp.pos_om = pos();
            ter_set( selected_point, oter_road_nesw ); // every city starts with an intersection
            city_tiles.insert( selected_point.xy() );
            tmp.pos = selected_point.xy();
            // Note: The higher we bump this, the more gets filled in. However, performance becomes worse and worse as it apparently tries to place parts of cities overtop each other.
            // For the moment, this is the value I've gone with so it's playable in some state.
            tmp.size = 40;
            cities.push_back( tmp );
        }
        return;
    }

    // place a seed for num_cities_on_this_overmap cities, and maybe one more
    while( cities.size() < num_cities_on_this_overmap_count && !city_candidates.empty() ) {

        tripoint_om_omt selected_point;
        city tmp( SNIPPET.expand( city_settings.name_snippet ) );
        tmp.pos_om = pos();
        if( use_random_cities ) {
            // randomly make some cities smaller or larger
            int size = rng( op_city_size - 1, max_city_size );
            if( one_in( 3 ) ) { // 33% tiny
                size = size * 1 / 3;
            } else if( one_in( 2 ) ) { // 33% small
                size = size * 2 / 3;
            } else if( one_in( 2 ) ) { // 17% large
                size = size * 3 / 2;
            } else {           // 17% huge
                size = size * 2;
            }
            // Ensure that cities are at least size 2, as city of size 1 is just a crossroad with no buildings at all
            size = std::max( size, 2 );
            size = std::min( size, 55 );
            // TODO: put cities closer to the edge when they can span overmaps
            // don't draw cities across the edge of the map, they will get clipped
            selected_point = random_entry_removed( city_candidates );
            if( atlas_world ) {
                size = std::min( std::max( op_city_size, 2 ),
                                 north_america::rural_town_size( atlas_origin + selected_point.xy().raw() ) );
            }
            // remove candidates within 2 tiles of selection
            for( const tripoint_om_omt &remove_radius : points_in_radius( selected_point, 2 ) ) {
                std::vector<tripoint_om_omt>::iterator removed_point =
                    std::find( city_candidates.begin(), city_candidates.end(), remove_radius );
                if( removed_point != city_candidates.end() ) {
                    city_candidates.erase( removed_point );
                }
            }

            ter_set( selected_point, oter_road_nesw ); // every city starts with an intersection
            city_tiles.insert( selected_point.xy() );
            tmp.pos = selected_point.xy();
            tmp.size = size;

        } else {
            tmp = random_entry( cities_to_place );
            selected_point = tripoint_om_omt( tmp.pos, 0 );
            ter_set( tripoint_om_omt( tmp.pos, 0 ), oter_road_nesw );
            city_tiles.insert( tmp.pos );
        }

        cities.push_back( tmp );
    }
}

namespace
{
using north_america::urban_zone;

struct urban_buildings {
    std::vector<overmap_special_id> large;
    std::vector<overmap_special_id> small;
};

const urban_buildings &buildings_for( urban_zone zone )
{
    static const std::array<urban_buildings, 5> buildings = { {
            {   {
                    overmap_special_id( "apartments_mod_new" ), overmap_special_id( "apartments_con_new" ),
                    overmap_special_id( "urban_9_house_garage_loft" )
                },
                {
                    overmap_special_id( "house_01" ), overmap_special_id( "house_02" ),
                    overmap_special_id( "house_03" ), overmap_special_id( "house_gardener" )
                }
            },
            {   { overmap_special_id( "parking_lot_2x2" ), overmap_special_id( "shopping_plaza" ) },
                {
                    overmap_special_id( "s_grocery" ), overmap_special_id( "s_restaurant" ),
                    overmap_special_id( "s_bookstore" ), overmap_special_id( "s_clothes" ),
                    overmap_special_id( "s_pharm" ), overmap_special_id( "s_hardware" )
                }
            },
            {   {
                    overmap_special_id( "office_tower" ), overmap_special_id( "office_skyscraper" ),
                    overmap_special_id( "office_tower_large" ), overmap_special_id( "apartments_mod_new" )
                },
                {
                    overmap_special_id( "small_office" ), overmap_special_id( "office_cubical" ),
                    overmap_special_id( "bank" ), overmap_special_id( "bank_1" ),
                    overmap_special_id( "s_restaurant_fast" )
                }
            },
            {   { overmap_special_id( "public_works" ), overmap_special_id( "storage_units_medium" ) },
                {
                    overmap_special_id( "warehouse" ), overmap_special_id( "abandonedwarehouse_1" ),
                    overmap_special_id( "s_garage" ), overmap_special_id( "s_garage_1" ),
                    overmap_special_id( "recyclecenter" ), overmap_special_id( "small_storage_units" )
                }
            },
            {   {
                    overmap_special_id( "school" ), overmap_special_id( "urban_library" ),
                    overmap_special_id( "urban_35_hospital" )
                },
                {
                    overmap_special_id( "s_library" ), overmap_special_id( "s_library_2" ),
                    overmap_special_id( "museum" ), overmap_special_id( "office_doctor" ),
                    overmap_special_id( "playground" )
                }
            },
        }
    };
    return buildings[static_cast<std::size_t>( zone )];
}

struct urban_center {
    point offset;
    int radius;
    urban_zone zone;
};

std::optional<urban_zone> mapped_neighborhood( const north_america::place &place, point local )
{
    // Offsets are approximate OMTs from the atlas city point.
    static constexpr std::array<urban_center, 7> new_york = { {
            { { -8, -10 }, 44, urban_zone::downtown }, // Midtown
            { { -100, 205 }, 38, urban_zone::downtown }, // Lower Manhattan
            { { -20, 282 }, 32, urban_zone::downtown }, // Downtown Brooklyn
            { { 132, 36 }, 28, urban_zone::downtown }, // Long Island City
            { { -57, 96 }, 18, urban_zone::institutional }, // Washington Square
            { { 74, -253 }, 23, urban_zone::institutional }, // Morningside Heights
            { { 35, 242 }, 27, urban_zone::industrial }, // Brooklyn Navy Yard
        }
    };
    static constexpr std::array<urban_center, 3> winnipeg = { {
            { { 93, -23 }, 29, urban_zone::downtown },
            { { 48, -19 }, 21, urban_zone::institutional }, // University of Winnipeg
            { { 363, 177 }, 55, urban_zone::industrial }, // St. Boniface Industrial Park
        }
    };
    const auto match = [&]( const auto & centers ) -> std::optional<urban_zone> {
        for( const urban_center &center : centers )
        {
            if( square_dist( local, center.offset ) < center.radius ) {
                return center.zone;
            }
        }
        return std::nullopt;
    };
    if( place.name == "New York" ) {
        return match( new_york );
    }
    if( place.name == "Winnipeg" ) {
        return match( winnipeg );
    }
    return std::nullopt;
}

urban_zone neighborhood_zone( const north_america::place &place, point_abs_omt location,
                              const std::array<north_america::city_zone_center, 4> &centers,
                              bool near_arterial, bool dense )
{
    const point local = location.raw() - place.position.raw();
    if( const std::optional<urban_zone> mapped = mapped_neighborhood( place, local ) ) {
        return *mapped;
    }
    for( const north_america::city_zone_center &center : centers ) {
        if( square_dist( location, center.center ) < center.radius ) {
            return center.zone;
        }
    }
    // High streets extend the commercial district along major roads. Other
    // blocks outside the main employment and institutional areas are residential.
    const north_america::city_zone_center &market = centers[1];
    return near_arterial && ( dense || square_dist( location, market.center ) < market.radius * 3 ) ?
           urban_zone::commercial : urban_zone::housing;
}

struct atlas_lot {
    tripoint_om_omt pos;
    const city *town;
    overmap_special_id regional_house;
    urban_zone zone;
    std::array<om_direction::type, 4> entrances = {};
    unsigned frontage = 0;
    bool dense = false;
};

int urban_cell( const point_om_omt &p )
{
    return p.y() * OMAPX + p.x();
}
} // namespace

void overmap::build_atlas_neighborhoods( const overmap_connection &road,
        const std::vector<north_america::road_cell> &streets )
{
    const auto origin = global_base_point();
    const auto &districts = north_america::urban_districts_in( pos() );
    if( districts.empty() || cities.empty() ) {
        return;
    }

    static const overmap_location_id land( "land" );
    std::vector<const north_america::place *> owners( OMAPX * OMAPY );
    std::vector<atlas_lot> fronts;
    constexpr int max_infill_depth = 4;
    std::array < std::vector<atlas_lot>, max_infill_depth - 1 > interiors;
    const int step = north_america::urban_district_size();
    const auto near_street = [&]( const tripoint_om_omt & p ) {
        return inbounds( p ) && ( road.has( ter( p ) ) || north_america::is_avenue_flank( ter( p ) ) );
    };

    for( const north_america::urban_district &district : districts ) {
        const north_america::place &owner = north_america::cities()[district.city_index];
        const auto &zoning = north_america::city_zone_centers( district.city_index );
        const point center = district.center.raw() - origin.raw();
        const point start = center - point( step / 2, step / 2 );
        const point stop = start + point( step, step );
        const tripoint_om_omt local_center( std::clamp( center.x, 1, OMAPX - 2 ),
                                            std::clamp( center.y, 1, OMAPY - 2 ), 0 );
        const city &town = get_nearest_city( local_center );
        if( !town ) {
            continue;
        }
        const overmap_special_id regional_house = north_america::regional_house_for(
                    north_america::jurisdiction_at( project_to<coords::ms>( origin + local_center.xy().raw() ) ) );
        for( int y = std::max( start.y, 1 ); y < std::min( stop.y, OMAPY - 1 ); ++y ) {
            for( int x = std::max( start.x, 1 ); x < std::min( stop.x, OMAPX - 1 ); ++x ) {
                const tripoint_om_omt p( x, y, 0 );
                const oter_id existing = ter( p );
                if( road.has( existing ) || north_america::is_avenue_flank( existing ) ) {
                    city_tiles.insert( p.xy() );
                    continue;
                }
                if( !land->test( existing ) || existing->is_water() ||
                    overmap_special_placements.count( p ) ) {
                    continue;
                }
                const point_abs_omt absolute = origin + p.xy().raw();
                const int development = north_america::urban_density( district, absolute );
                if( development == 0 ) {
                    continue;
                }
                owners[urban_cell( p.xy() )] = &owner;
                if( development < 100 && rng( 1, 100 ) > development ) {
                    continue;
                }
                atlas_lot lot{ p, &town, regional_house, urban_zone::housing };
                lot.dense = development >= 75 && north_america::population_band( absolute ) >= 5;
                bool near_arterial = false;
                for( om_direction::type dir : om_direction::all ) {
                    const auto delta = om_direction::displace( dir );
                    const tripoint_om_omt next = p + delta;
                    if( near_street( next ) ) {
                        lot.entrances[lot.frontage++] = dir;
                        near_arterial |= streets[urban_cell( next.xy() )].street ==
                                         north_america::urban_road::arterial ||
                                         north_america::is_avenue_flank( ter( next ) );
                    }
                }
                lot.zone = neighborhood_zone( owner, absolute, zoning, near_arterial, lot.dense );
                if( lot.frontage ) {
                    fronts.push_back( lot );
                    continue;
                }
                int depth = max_infill_depth + 1;
                for( const om_direction::type dir : om_direction::all ) {
                    const auto delta = om_direction::displace( dir );
                    tripoint_om_omt next = p + delta;
                    for( int distance = 2; distance < depth; ++distance ) {
                        next = next + delta;
                        if( !inbounds( next ) || ter( next )->is_water() ) {
                            break;
                        }
                        if( near_street( next ) ) {
                            depth = distance;
                            lot.entrances[0] = dir;
                            break;
                        }
                    }
                }
                if( depth <= max_infill_depth ) {
                    interiors[depth - 2].push_back( lot );
                }
            }
        }
    }

    std::unordered_map<const city *, std::unordered_set<overmap_special_id>> placed_unique;
    std::unordered_map<overmap_special_id, std::vector<tripoint_rel_omt>> footprints;
    const auto try_place = [&]( const atlas_lot & lot, const overmap_special_id & id,
    om_direction::type direction ) {
        if( id.is_null() || !id.is_valid() || city_tiles.count( lot.pos.xy() ) ) {
            return false;
        }
        const overmap_special &special = *id;
        const bool city_unique = special.has_flag( "CITY_UNIQUE" );
        if( ( city_unique && placed_unique[lot.town].count( id ) ) ||
            !special.get_constraints().city_size.contains( lot.town->size ) ) {
            return false;
        }
        auto [footprint, first_visit] = footprints.try_emplace( id );
        if( first_visit ) {
            for( const overmap_special_locations &entry : special.required_locations() ) {
                footprint->second.push_back( entry.p );
            }
        }
        for( const tripoint_rel_omt &offset : footprint->second ) {
            const tripoint_om_omt tile = lot.pos + om_direction::rotate( offset, direction );
            if( !inbounds( tile, 1 ) || overmap_special_placements.count( tile ) ||
                ( offset.z() == 0 && ( city_tiles.count( tile.xy() ) ||
                                       owners[urban_cell( tile.xy() )] != owners[urban_cell( lot.pos.xy() )] ) ) ) {
                return false;
            }
        }
        if( !can_place_special( special, lot.pos, direction, false ) ) {
            return false;
        }
        for( const tripoint_om_omt &used : place_special( special, lot.pos, direction,
                *lot.town, false, false ) ) {
            city_tiles.insert( used.xy() );
        }
        if( city_unique ) {
            placed_unique[lot.town].insert( id );
        }
        return true;
    };

    std::shuffle( fronts.begin(), fronts.end(), rng_get_engine() );
    for( const atlas_lot &lot : fronts ) {
        // Buildings with a larger footprint get first choice of contiguous lots.
        const int frequency = lot.zone == urban_zone::downtown ? 4 : lot.dense ? 8 : 14;
        if( !one_in( frequency ) ||
            city_tiles.count( lot.pos.xy() ) ) {
            continue;
        }
        const auto &large = buildings_for( lot.zone ).large;
        const overmap_special_id &building = random_entry( large );
        for( unsigned i = 0; i < lot.frontage; ++i ) {
            if( try_place( lot, building, lot.entrances[i] ) ) {
                break;
            }
        }
    }

    const region_settings_city &city_spec = settings->get_settings_city();
    for( const atlas_lot &lot : fronts ) {
        if( city_tiles.count( lot.pos.xy() ) ) {
            continue;
        }
        const om_direction::type dir = lot.entrances[rng( 0, lot.frontage - 1 )];
        const bool mixed_housing = ( lot.zone == urban_zone::commercial ||
                                     lot.zone == urban_zone::institutional ) && one_in( 5 );
        const urban_zone use = mixed_housing ? urban_zone::housing : lot.zone;
        const bool housing = use == urban_zone::housing;
        if( one_in( 26 ) && try_place( lot, city_spec.pick_park(), dir ) ) {
            continue;
        }
        if( housing && one_in( 3 ) && try_place( lot, lot.regional_house, dir ) ) {
            continue;
        }
        if( one_in( 3 ) && ( housing || use == urban_zone::commercial ) &&
            try_place( lot, housing ? city_spec.pick_house() : city_spec.pick_shop(), dir ) ) {
            continue;
        }
        const auto &small = buildings_for( use ).small;
        const int first = rng( 0, static_cast<int>( small.size() ) - 1 );
        for( std::size_t i = 0; i < small.size(); ++i ) {
            if( try_place( lot, small[( first + i ) % small.size()], dir ) ) {
                break;
            }
        }
    }

    static const std::array<overmap_special_id, 3> green_space = {
        overmap_special_id( "park" ), overmap_special_id( "park_5" ), overmap_special_id( "park_7" )
    };
    // Work from the front toward the backs of developed blocks. Do not turn
    // large gaps between streets or unserved shoreline into planned grounds.
    for( const auto &lots : interiors ) {
        for( const atlas_lot &lot : lots ) {
            const auto facing = lot.entrances[0];
            if( city_tiles.count( ( lot.pos + om_direction::displace( facing ) ).xy() ) ) {
                try_place( lot, random_entry( green_space ), facing );
            }
        }
    }
}

void overmap::build_cities()
{

    const overmap_connection_id &overmap_connection_intra_city_road =
        settings->overmap_connection.intra_city_road_connection;
    const overmap_connection &local_road( *overmap_connection_intra_city_road );
    const bool atlas = north_america::active();
    const auto origin = project_to<coords::omt>( pos() );

    for( const city &c : cities ) {
        if( atlas && north_america::in_urban_footprint( origin + c.pos.raw() ) ) {
            continue;
        }
        const om_direction::type start_dir = om_direction::random();
        om_direction::type cur_dir = start_dir;

        // Track placed CITY_UNIQUE buildings
        std::unordered_set<overmap_special_id> placed_unique_buildings;
        // place streets in all cardinal directions from central intersection
        do {
            build_city_street( local_road, c.pos, c.size, cur_dir, c, placed_unique_buildings );
        } while( ( cur_dir = om_direction::turn_right( cur_dir ) ) != start_dir );
    }
    if( !atlas ) {
        flood_fill_city_tiles();
    }
}

overmap_special_id overmap::pick_random_building_to_place( int town_dist, int town_size,
        const std::unordered_set<overmap_special_id> &placed_unique_buildings,
        const tripoint_om_omt &building_pos, bool try_regional_house ) const
{
    const region_settings_city &city_spec = settings->get_settings_city();
    int shop_radius = city_spec.shop_radius;
    int park_radius = city_spec.park_radius;

    int shop_sigma = city_spec.shop_sigma;
    int park_sigma = city_spec.park_sigma;

    //Normally distribute shops and parks
    //Clamp at 1/2 radius to prevent houses from spawning in the city center.
    //Parks are nearly guaranteed to have a non-zero chance of spawning anywhere in the city.
    int shop_normal = shop_radius;
    if( shop_sigma > 0 ) {
        shop_normal = std::max( shop_normal, static_cast<int>( normal_roll( shop_radius, shop_sigma ) ) );
    }
    int park_normal = park_radius;
    if( park_sigma > 0 ) {
        park_normal = std::max( park_normal, static_cast<int>( normal_roll( park_radius, park_sigma ) ) );
    }
    if( try_regional_house && town_dist >= std::max( shop_normal, park_normal ) &&
        north_america::active() && one_in( 3 ) ) {
        const point_abs_omt placement = project_to<coords::omt>( pos() ) + building_pos.xy().raw();
        const point_abs_ms center = project_to<coords::ms>( placement ) + point( SEEX, SEEY );
        const overmap_special_id house = north_america::regional_house_for(
                                             north_america::jurisdiction_at( center ) );
        if( !house.is_null() && house.is_valid() ) {
            return house;
        }
    }
    auto building_type_to_pick = [&]() {
        if( shop_normal > town_dist ) {
            return std::mem_fn( &region_settings_city::pick_shop );
        } else if( park_normal > town_dist ) {
            return std::mem_fn( &region_settings_city::pick_park );
        } else {
            return std::mem_fn( &region_settings_city::pick_house );
        }
    };
    auto pick_building = building_type_to_pick();
    for( int attempt = 0; attempt < 24; ++attempt ) {
        const overmap_special_id ret = pick_building( city_spec );
        if( ret.is_null() ) {
            return ret;
        }
        bool existing_unique;
        if( ret->has_flag( "CITY_UNIQUE" ) ) {
            existing_unique = placed_unique_buildings.find( ret ) != placed_unique_buildings.end();
        } else if( ret->has_flag( "GLOBALLY_UNIQUE" ) || ret->has_flag( "OVERMAP_UNIQUE" ) ) {
            existing_unique = overmap_buffer.contains_unique_special( ret );
        } else {
            existing_unique = false;
        }
        if( !existing_unique && ret->get_constraints().city_size.contains( town_size ) ) {
            return ret;
        }
    }
    return overmap_special_id::NULL_ID();
}

void overmap::place_building( const tripoint_om_omt &p, om_direction::type dir, const city &town,
                              std::unordered_set<overmap_special_id> &placed_unique_buildings )
{
    const tripoint_om_omt building_pos = p + om_direction::displace( dir );
    const om_direction::type building_dir = om_direction::opposite( dir );
    if( north_america::active() ) {
        const auto origin = project_to<coords::omt>( pos() );
        if( north_america::in_urban_footprint( origin + town.pos.raw() ) &&
            !north_america::in_urban_footprint( origin + building_pos.xy().raw() ) ) {
            return;
        }
    }

    const int town_dist = ( trig_dist( building_pos.xy(), town.pos ) * 100 ) / std::max( town.size, 1 );

    for( size_t retries = 10; retries > 0; --retries ) {
        const overmap_special_id building_tid = pick_random_building_to_place( town_dist, town.size,
                                                placed_unique_buildings, building_pos, retries == 10 );
        if( building_tid.is_null() ) {
            return;
        }
        if( can_place_special( *building_tid, building_pos, building_dir, false ) ) {
            std::vector<tripoint_om_omt> used_tripoints = place_special( *building_tid, building_pos,
                    building_dir, town, false, false );
            for( const tripoint_om_omt &p : used_tripoints ) {
                city_tiles.insert( p.xy() );
            }
            if( building_tid->has_flag( "CITY_UNIQUE" ) ) {
                placed_unique_buildings.emplace( building_tid );
            }
            break;
        }
    }
}

pf::directed_path<point_om_omt> overmap::lay_out_street( const overmap_connection &connection,
        const point_om_omt &source, om_direction::type dir, size_t len, bool bounded_urban )
{
    const int &highway_width = settings->overmap_highway ?
                               settings->get_settings_highway().width_of_segments : 0;
    const auto origin = project_to<coords::omt>( pos() );
    auto valid_placement = [this, bounded_urban, origin]( const overmap_connection & connection,
                           const tripoint_om_omt pos,
    om_direction::type dir ) {
        if( !inbounds( pos, 1 ) ) {
            return false;  // Don't approach overmap bounds.
        }
        if( bounded_urban && !north_america::in_urban_footprint( origin + pos.xy().raw() ) ) {
            return false;
        }
        const oter_id &ter_id = ter( pos );
        // TODO: Make it so the city picks a bridge direction ( ns or ew ) and allows bridging over rivers in that direction with the same logic as highways
        if( ter_id->is_river() || ter_id->is_ravine() || ter_id->is_ravine_edge() ||
            ter_id->is_highway() || ter_id->is_highway_reserved() || !connection.pick_subtype_for( ter_id ) ) {
            return false;
        }
        int collisions = 0;

        for( const tripoint_om_omt &checkp : points_in_radius( pos, 1 ) ) {
            if( checkp != pos + om_direction::displace( dir, 1 ) &&
                checkp != pos + om_direction::displace( om_direction::opposite( dir ), 1 ) &&
                checkp != pos ) {
                if( ter( checkp )->get_type_id() == oter_type_road ) {
                    //Stop roads from running right next to each other
                    if( collisions >= 2 ) {
                        return false;
                    }
                    collisions++;
                }
            }
        }

        return true;
    };

    const tripoint_om_omt from( source, 0 );
    // See if we need to take another one-tile "step" further.
    const tripoint_om_omt en_pos = from + om_direction::displace( dir, len + 1 );
    if( inbounds( en_pos, 1 ) && connection.has( ter( en_pos ) ) ) {
        ++len;
    }
    size_t actual_len = 0;
    bool checked_highway = false;

    while( actual_len < len ) {
        const tripoint_om_omt pos = from + om_direction::displace( dir, actual_len );
        if( !valid_placement( connection, pos, dir ) ) {
            break;
        }
        const oter_id &ter_id = ter( pos );
        if( ter_id->is_highway_reserved() ) {
            if( !checked_highway ) {
                // Break if parallel to the highway direction
                if( are_parallel( dir, ter_id.obj().get_dir() ) ) {
                    break;
                }
                const tripoint_om_omt pos_after_highway = pos + om_direction::displace( dir, highway_width );
                // Ensure we can pass fully through
                if( !valid_placement( connection, pos_after_highway, dir ) ) {
                    break;
                }
                checked_highway = true;
            }
            // Prevent stopping under highway
            if( actual_len == len - 1 ) {
                ++len;
            }
        }

        city_tiles.insert( pos.xy() );
        ++actual_len;
        if( actual_len > 1 && connection.has( ter_id ) ) {
            break;  // Stop here.
        }
    }
    return straight_path( source, dir, actual_len );
}

void overmap::build_city_street(
    const overmap_connection &connection, const point_om_omt &p, int cs, om_direction::type dir,
    const city &town, std::unordered_set<overmap_special_id> &placed_unique_buildings, int block_width )
{
    int c = cs;
    int croad = cs;

    if( dir == om_direction::type::invalid ) {
        debugmsg( "Invalid road direction." );
        return;
    }
    const bool bounded_urban = north_america::active() &&
                               north_america::in_urban_footprint( project_to<coords::omt>( pos() ) +
                                       town.pos.raw() );
    const pf::directed_path<point_om_omt> street_path = lay_out_street( connection, p, dir, cs + 1,
            bounded_urban );

    if( street_path.nodes.size() <= 1 ) {
        return; // Don't bother.
    }
    // Build the actual street.
    build_connection( connection, street_path, 0 );
    // Grow in the stated direction, sprouting off sub-roads and placing buildings as we go.
    const auto from = std::next( street_path.nodes.begin() );
    const auto to = street_path.nodes.end();

    //Alternate wide and thin blocks
    int new_width = block_width == 2 ? rng( 3, 5 ) : 2;

    for( auto iter = from; iter != to; ++iter ) {
        --c;

        const tripoint_om_omt rp( iter->pos, 0 );
        if( c >= 2 && c < croad - block_width ) {
            croad = c;
            int left = cs - rng( 1, 3 );
            int right = cs - rng( 1, 3 );

            //Remove 1 length road nubs
            if( left == 1 ) {
                left++;
            }
            if( right == 1 ) {
                right++;
            }

            build_city_street( connection, iter->pos, left, om_direction::turn_left( dir ),
                               town, placed_unique_buildings, new_width );

            build_city_street( connection, iter->pos, right, om_direction::turn_right( dir ),
                               town, placed_unique_buildings, new_width );

            const oter_id &oter = ter( rp );
            // TODO: Get rid of the hardcoded terrain ids.
            if( one_in( 2 ) && oter->get_line() == 15 && oter->type_is( oter_type_id( "road" ) ) ) {
                ter_set( rp, oter_road_nesw_manhole.id() );
            }
        }

        if( !one_in( BUILDINGCHANCE ) ) {
            place_building( rp, om_direction::turn_left( dir ), town, placed_unique_buildings );
        }
        if( !one_in( BUILDINGCHANCE ) ) {
            place_building( rp, om_direction::turn_right( dir ), town, placed_unique_buildings );
        }
    }

    // If we're big, make a right turn at the edge of town.
    // Seems to make little neighborhoods.
    cs -= rng( 1, 3 );

    if( cs >= 2 && c == 0 ) {
        const auto &last_node = street_path.nodes.back();
        const om_direction::type rnd_dir = om_direction::turn_random( dir );
        build_city_street( connection, last_node.pos, cs, rnd_dir, town, placed_unique_buildings );
        if( one_in( 5 ) ) {
            build_city_street( connection, last_node.pos, cs, om_direction::opposite( rnd_dir ),
                               town, placed_unique_buildings, new_width );
        }
    }
}

void overmap::clear_cities()
{
    cities.clear();
}


bool overmap::is_in_city( const tripoint_om_omt &p ) const
{
    if( !city_tiles.empty() ) {
        return city_tiles.find( p.xy() ) != city_tiles.end();
    } else {
        // Legacy handling
        return distance_to_city( p ) == 0;
    }
}

std::optional<int> overmap::distance_to_city( const tripoint_om_omt &p,
        int max_dist_to_check ) const
{
    if( !city_tiles.empty() ) {
        for( int i = 0; i <= max_dist_to_check; i++ ) {
            for( const tripoint_om_omt &tile : closest_points_first( p, i, i ) ) {
                if( is_in_city( tile ) ) {
                    return i;
                }
            }
        }
    } else {
        // Legacy handling
        const city &nearest_city = get_nearest_city( p );
        if( !!nearest_city ) {
            // 0 if within city
            return std::max( 0, nearest_city.get_distance_from( p ) - nearest_city.size );
        }
    }
    return {};
}

std::optional<int> overmap::approx_distance_to_city( const tripoint_om_omt &p,
        int max_dist_to_check ) const
{
    std::optional<int> ret;
    for( const city &elem : cities ) {
        const int dist = elem.get_distance_from( p );
        if( dist == 0 ) {
            return 0;
        }
        if( dist <= max_dist_to_check ) {
            ret = ret.has_value() ? std::min( ret.value(), dist ) : dist;
        }
    }
    return ret;
}

void overmap::flood_fill_city_tiles()
{
    std::unordered_set<point_om_omt> visited;
    // simplifies bounds checking
    const half_open_rectangle<point_om_omt> omap_bounds( point_om_omt( 0, 0 ), point_om_omt( OMAPX,
            OMAPY ) );

    // Look through every point on the overmap
    for( int y = 0; y < OMAPY; y++ ) {
        for( int x = 0; x < OMAPX; x++ ) {
            point_om_omt checked( x, y );
            // If we already looked at it in a previous flood-fill, ignore it
            if( visited.find( checked ) != visited.end() ) {
                continue;
            }
            // Is the area connected to this point enclosed by city_tiles?
            bool enclosed = true;
            // Predicate for flood-fill. Also detects if any point flood-filled to borders the edge
            // of the overmap and is thus not enclosed
            const auto is_unchecked = [&enclosed, &omap_bounds, this]( const point_om_omt & pt ) {
                if( city_tiles.find( pt ) != city_tiles.end() ) {
                    return false;
                }
                // We hit the edge of the overmap! We're free!
                if( !omap_bounds.contains( pt ) ) {
                    enclosed = false;
                    return false;
                }
                return true;
            };
            // All the points connected to this point that aren't part of a city
            std::vector<point_om_omt> area =
                ff::point_flood_fill_4_connected<std::vector>( checked, visited, is_unchecked );
            if( !enclosed ) {
                continue;
            }
            // They are enclosed, and so should be considered part of the city.
            city_tiles.reserve( city_tiles.size() + area.size() );
            for( const point_om_omt &pt : area ) {
                city_tiles.insert( pt );
            }
        }
    }
}
