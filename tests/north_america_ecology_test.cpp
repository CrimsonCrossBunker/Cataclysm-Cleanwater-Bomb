#include "cata_catch.h"

#include <algorithm>
#include <memory>

#include "cata_scope_helpers.h"
#include "game.h"
#include "coordinates.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapgendata.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "north_america.h"
#include "north_america_ecology.h"
#include "north_america_transport.h"
#include "overmap.h"
#include "overmap_test_helpers.h"
#include "overmapbuffer.h"
#include "rng.h"

TEST_CASE( "north_america_geographic_vegetation_and_population", "[north_america]" )
{
    const point_abs_omt winnipeg( -75949, -46747 );
    const point_abs_omt tucson( -151555, 13001 );
    const point_abs_omt fairbanks( -122921, -178545 );
    const point_abs_omt nunavut( -25769, -154568 );
    CHECK( north_america::ecoregion_code( winnipeg ) == "9.2" );
    CHECK( north_america::ecoregion_code( tucson ) == "10.2" );
    CHECK( north_america::ecoregion_code( fairbanks ) == "3.1" );
    CHECK( north_america::forest_adjustment( fairbanks ) > north_america::forest_adjustment(
               winnipeg ) );
    CHECK( north_america::rural_city_multiplier( project_to<coords::om>( winnipeg + point( 600,
            0 ) ) ) > north_america::rural_city_multiplier( project_to<coords::om>( nunavut ) ) );
}

TEST_CASE( "north_america_uses_footprints_and_limits_remote_town_sizes", "[north_america]" )
{
    const point_abs_om winnipeg = project_to<coords::om>( point_abs_omt( -75949, -46747 ) );
    const auto &districts = north_america::urban_districts_in( winnipeg );
    REQUIRE( !districts.empty() );
    CHECK( north_america::in_urban_footprint( districts.front().center ) );
    CHECK( north_america::rural_town_size( districts.front().center ) == 0 );

    const auto &places = north_america::cities();
    const auto churchill = std::find_if( places.begin(),
    places.end(), []( const north_america::place & p ) {
        return p.name == "Churchill";
    } );
    REQUIRE( churchill != places.end() );
    const int city_size = north_america::named_city_size( churchill->population );
    for( int east = -720; east <= 720; east += 120 ) {
        for( int north = -720; north <= 720; north += 120 ) {
            CHECK( north_america::rural_town_size( churchill->position + point( east, north ) ) < city_size );
        }
    }
}

TEST_CASE( "north_america_zones_all_large_atlas_cities", "[north_america][worldgen]" )
{
    using north_america::urban_zone;
    const auto &places = north_america::cities();
    for( std::size_t index = 0; index < places.size(); ++index ) {
        const auto &place = places[index];
        if( place.population < north_america::minimum_zoned_population ) {
            continue;
        }
        CAPTURE( place.name, place.region );
        const auto &zones = north_america::city_zone_centers( index );
        if( place.country == "Mexico" && place.region == "Sonora" && place.name == "Mazatl\u00e1n" ) {
            CHECK( zones[0].radius == 0 );
            continue;
        }
        REQUIRE( zones[0].zone == urban_zone::downtown );
        CHECK( zones[1].zone == urban_zone::commercial );
        CHECK( zones[2].zone == urban_zone::institutional );
        CHECK( zones[3].zone == urban_zone::industrial );
        for( const auto &zone : zones ) {
            CHECK( zone.radius > 0 );
            CHECK( north_america::in_urban_footprint( zone.center ) );
            const auto &districts = north_america::urban_districts_in(
                                        project_to<coords::om>( zone.center ) );
            CHECK( std::any_of( districts.begin(), districts.end(), [&]( const auto & district ) {
                return district.city_index == index &&
                       square_dist( district.center, zone.center ) <
                       north_america::urban_district_size() / 2;
            } ) );
        }
    }
}

TEST_CASE( "north_america_plans_connected_street_classes", "[north_america]" )
{
    using north_america::urban_road;
    const point_abs_omt center = GENERATE( point_abs_omt( -9451, 7811 ),
                                           point_abs_omt( -76078, -46705 ) );
    const point_abs_omt origin = center - point( 20, 20 );
    constexpr int width = 41;
    const auto area = north_america::road_network( origin, width, width );
    const auto at = [&]( int x, int y ) -> const north_america::road_cell & {
        return area[y * width + x];
    };
    CHECK( at( 20, 20 ).street == urban_road::arterial );
    for( const urban_road street : {
             urban_road::local, urban_road::collector, urban_road::arterial
         } ) {
        CHECK( std::count_if( area.begin(), area.end(), [street]( const north_america::road_cell & cell ) {
            return cell.street == street;
        } ) > 8 );
    }
    int turns = 0;
    for( int y = 0; y < width - 1; ++y ) {
        for( int x = 0; x < width - 1; ++x ) {
            const std::size_t links = at( x, y ).connections;
            if( at( x, y ).street == urban_road::local && om_lines::all[links].mapgen == 1 ) {
                ++turns;
            }
            CHECK( om_lines::has_segment( links, om_direction::type::east ) ==
                   om_lines::has_segment( at( x + 1, y ).connections, om_direction::type::west ) );
            CHECK( om_lines::has_segment( links, om_direction::type::south ) ==
                   om_lines::has_segment( at( x, y + 1 ).connections, om_direction::type::north ) );
        }
    }
    CHECK( turns > 15 );
    for( int offset = 0; offset < width; ++offset ) {
        const auto single = north_america::road_network( origin + point( 20, offset ), 1, 1 ).front();
        CHECK( single.connections == at( 20, offset ).connections );
        CHECK( single.street == at( 20, offset ).street );
    }
}

TEST_CASE( "atlas_city_development_tapers_and_rounds_the_fringe", "[north_america]" )
{
    const point_abs_omt center( -76080, -46704 );
    const int radius = north_america::urban_district_size() / 2;
    // North, east and northeast border open country.
    const north_america::urban_district fringe{ center, 0, 0b00010011 };
    const int near_edge = north_america::urban_density( fringe, center + point( 0, 5 - radius ) );
    const int inner_fringe = north_america::urban_density( fringe, center + point( 0, 13 - radius ) );
    CHECK( north_america::urban_density( fringe, center ) == 100 );
    CHECK( near_edge < inner_fringe );
    CHECK( inner_fringe < 100 );
    CHECK( north_america::urban_density( fringe, center + point( radius - 3, 5 - radius ) ) <
           near_edge );
}

TEST_CASE( "atlas_curving_bridge_has_one_continuous_deck", "[north_america][worldgen]" )
{
    const restore_on_out_of_scope saved_mode( g->north_america_world );
    g->north_america_world = true;
    clear_map();
    map &here = get_map();
    const mapgendata base( here, mapgendata::dummy_settings );
    const oter_type_str_id bridge( "atlas_road_bridge" );
    const std::size_t links = om_lines::set_segment(
                                  om_lines::set_segment( 0, om_direction::type::north ), om_direction::type::east );
    mapgendata corner( base, bridge->get_linear( links ) );
    REQUIRE( north_america::draw_mapped_road( corner ) );

    const ter_str_id water( "t_water_moving_dp" );
    for( int i = 0; i < SEEX; ++i ) {
        CHECK( here.ter( tripoint_bub_ms( SEEX, i, 0 ) ) != water.id() );
        CHECK( here.ter( tripoint_bub_ms( SEEX + i, SEEY, 0 ) ) != water.id() );
    }
    CHECK( here.ter( tripoint_bub_ms( SEEX, 2 * SEEY - 1, 0 ) ) == water.id() );
    CHECK( here.ter( tripoint_bub_ms( 0, SEEY, 0 ) ) == water.id() );
}

TEST_CASE( "winnipeg_city_blocks_fill_across_a_whole_overmap", "[north_america][worldgen]" )
{
    const restore_on_out_of_scope saved_mode( g->north_america_world );
    // NOLINTNEXTLINE(cata-determinism)
    const restore_on_out_of_scope saved_rng( rng_get_engine() );
    g->north_america_world = true;
    rng_set_engine_seed( 1320 );
    const point_abs_om location = project_to<coords::om>( point_abs_omt( -76078, -46705 ) );
    const auto om = std::make_unique<overmap>( location );
    REQUIRE( overmap_test_helper::generate_atlas_streets_and_buildings( *om ) );

    const auto &districts = north_america::urban_districts_in( location );
    const int radius = north_america::urban_district_size() / 2;
    const overmap_location_id land( "land" );
    const point_abs_omt origin = project_to<coords::omt>( location );
    const oter_type_str_id road( "road" );
    const oter_id flank_ns = north_america::avenue_flank( true );
    const oter_id flank_ew = north_america::avenue_flank( false );
    REQUIRE( flank_ns );
    REQUIRE( flank_ew );
    int widened = 0;
    int tested_bands = 0;
    for( int start = 5; start + 20 < OMAPY; start += 20 ) {
        int developed = 0;
        int vacant = 0;
        for( int y = start; y < start + 20; ++y ) {
            for( int x = 1; x < OMAPX - 1; ++x ) {
                const tripoint_om_omt p( x, y, 0 );
                const oter_id terrain = om->ter( p );
                if( terrain == flank_ns || terrain == flank_ew ) {
                    ++widened;
                    const bool vertical = terrain == flank_ns;
                    const oter_id core( vertical ? "road_ns" : "road_ew" );
                    CHECK( om->ter( p + ( vertical ? point::west : point::north ) ) == core );
                    const point step = vertical ? point::north : point::east;
                    CHECK( ( om->ter( p + step ) == terrain || om->ter( p - step ) == terrain ) );
                    continue;
                }
                if( terrain->is_water() || terrain->type_is( road ) ) {
                    continue;
                }
                const point_abs_omt absolute = origin + p.xy().raw();
                const auto district = std::find_if( districts.begin(), districts.end(),
                [&]( const north_america::urban_district & candidate ) {
                    const point offset = absolute.raw() - candidate.center.raw();
                    return offset.x >= -radius && offset.x < radius && offset.y >= -radius &&
                           offset.y < radius;
                } );
                if( district == districts.end() || north_america::urban_density( *district, absolute ) < 75 ) {
                    continue;
                }
                if( land->test( terrain ) ) {
                    ++vacant;
                } else {
                    ++developed;
                }
            }
        }
        if( developed + vacant > 100 ) {
            ++tested_bands;
            CAPTURE( start, developed, vacant );
            CHECK( developed > vacant * 2 );
        }
    }
    CHECK( tested_bands >= 4 );
    CHECK( widened > 0 );
}

TEST_CASE( "atlas_special_placement_does_not_generate_neighbor_overmaps",
           "[north_america][worldgen]" )
{
    const restore_on_out_of_scope saved_mode( g->north_america_world );
    const restore_on_out_of_scope saved_rng( rng_get_engine() );
    g->north_america_world = true;
    rng_set_engine_seed( 1326 );

    const point_abs_om origin( -951, 582 );
    auto om = std::make_unique<overmap>( origin );
    const oter_id water( "ocean_surface" );
    for( int y = 0; y < OMAPY; ++y ) {
        for( int x = 0; x < OMAPX; ++x ) {
            om->ter_set( { x, y, 0 }, water );
        }
    }

    const overmap_special_id motel( "Motel" );
    REQUIRE( motel.is_valid() );
    REQUIRE( motel->get_constraints().occurrences.min > 0 );
    overmap_special_batch specials( origin, { &motel.obj() } );
    const auto count_before = overmap_buffer.global_state.overmap_count;
    overmap_test_helper::place_specials( *om, specials );
    CHECK( overmap_buffer.global_state.overmap_count == count_before );
    REQUIRE( !specials.empty() );
    CHECK( specials.begin()->instances_placed == 0 );
}

TEST_CASE( "atlas_start_reveals_only_existing_overmaps", "[north_america][worldgen]" )
{
    const point_abs_om origin( -953, 580 );
    const tripoint_abs_omt p( project_to<coords::omt>( origin ), 0 );
    REQUIRE_FALSE( overmap_buffer.get_existing( origin ) );
    const auto count_before = overmap_buffer.global_state.overmap_count;
    CHECK_FALSE( overmap_buffer.reveal_route( p, p + point::east, 3, false, true ) );
    CHECK_FALSE( overmap_buffer.reveal( p, 3, []( const oter_id & ) {
        return true;
    }, true ) );
    CHECK( overmap_buffer.global_state.overmap_count == count_before );
}

TEST_CASE( "north_america_coarse_highway_samples_match_full_raster", "[north_america]" )
{
    const point_abs_omt origin( -75970, -46772 );
    const auto coarse = north_america::raster( origin, 7, 7, 9 );
    const auto full = north_america::raster( origin, 55, 55 );
    for( int y = 0; y < 7; ++y ) {
        for( int x = 0; x < 7; ++x ) {
            CHECK( coarse[y * 7 + x] == full[y * 9 * 55 + x * 9] );
        }
    }
    CHECK( north_america::suitable_for_highway_intersection( project_to<coords::om>( origin ) ) );
    CHECK_FALSE( north_america::suitable_for_highway_intersection( point_abs_om( 35, 0 ) ) );
}