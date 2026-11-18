#include <algorithm>
#include <array>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <memory>
#include <optional>
#include <string>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "city.h"
#include "common_types.h"
#include "coordinates.h"
#include "game.h"
#include "line.h"
#include "map.h"
#include "map_helpers.h"
#include "map_scale_constants.h"
#include "mapgendata.h"
#include "north_america.h"
#include "north_america_ecology.h"
#include "north_america_elevation.h"
#include "north_america_transport.h"
#include "omdata.h"
#include "overmap.h"
#include "overmap_location.h"
#include "overmap_test_helpers.h"
#include "overmapbuffer.h"
#include "point.h"
#include "regional_climate.h"
#include "rng.h"
#include "type_id.h"

static const oter_type_str_id oter_type_atlas_road_bridge( "atlas_road_bridge" );
static const oter_type_str_id oter_type_road( "road" );
static const oter_type_str_id oter_type_shelter( "shelter" );
static const oter_type_str_id oter_type_shelter_roof( "shelter_roof" );
static const oter_type_str_id oter_type_shelter_under( "shelter_under" );

static const overmap_location_id overmap_location_land( "land" );

static const overmap_special_id overmap_special_Motel( "Motel" );
static const overmap_special_id
overmap_special_house_regional_cape_cod( "house_regional_cape_cod" );

static const ter_str_id ter_t_open_air( "t_open_air" );
static const ter_str_id ter_t_rock( "t_rock" );
static const ter_str_id ter_t_water_moving_dp( "t_water_moving_dp" );

TEST_CASE( "atlas_elevation_distinguishes_sea_level_from_local_storeys", "[north_america]" )
{
    const auto boston = north_america::dem_elevation( regional_climate::coordinates{ 42.47, -71.2894 } );
    const auto denver = north_america::dem_elevation( regional_climate::coordinates{ 39.74, -104.99 } );
    const auto mexico = north_america::dem_elevation( regional_climate::coordinates{ 19.43, -99.13 } );
    REQUIRE( boston );
    REQUIRE( denver );
    REQUIRE( mexico );
    CHECK( *boston < 100.0 );
    CHECK( *denver > 1500.0 );
    CHECK( *mexico > 2100.0 );

    const tripoint_abs_ms ground( 0, 0, 0 );
    const double elevation = north_america::altitude_at( ground );
    CHECK( north_america::altitude_at( tripoint_abs_ms( ground.xy(), -3 ) ) ==
           Approx( elevation - 12.0 ) );
    CHECK( north_america::altitude_at( tripoint_abs_ms( ground.xy(), 2 ) ) ==
           Approx( elevation + 8.0 ) );
    CHECK( north_america::temperature_delta_at_height( *denver, *denver ) == 0 );
    CHECK( north_america::temperature_delta_at_height( *denver + 1000, *denver ) ==
           Approx( -6.5 ) );
    CHECK( north_america::pressure_ratio_at_height( *mexico ) < 0.8 );
    CHECK( north_america::grade_move_multiplier( 0.03 ) == 1 );
    CHECK( north_america::grade_move_multiplier( 0.30 ) >
           north_america::grade_move_multiplier( -0.30 ) );
}

TEST_CASE( "atlas_elevation_navigation_extends_past_the_structural_layers", "[north_america]" )
{
    const point_abs_omt city_site = point_abs_omt::zero;
    const double ground = north_america::altitude_at( tripoint_abs_omt( city_site, 0 ) );
    const auto underground = north_america::overmap_at_altitude( city_site, ground - 97.0 );
    const auto in_air = north_america::overmap_at_altitude( city_site, ground + 97.0 );
    REQUIRE( underground );
    REQUIRE( in_air );
    CHECK( underground->z() == -24 );
    CHECK( in_air->z() == 24 );
    CHECK( north_america::altitude_at( *underground ) == Approx( ground - 96.0 ) );
    CHECK( north_america::minimum_overmap_z( city_site ) < -OVERMAP_DEPTH );
    CHECK( north_america::maximum_overmap_z( city_site ) > OVERMAP_HEIGHT );
    CHECK_FALSE( north_america::overmap_at_altitude( city_site,
                 north_america::altitude_limit_m + 1 ) );
}

TEST_CASE( "atlas_extended_map_window_loads_original_rock_and_air", "[north_america][worldgen]" )
{
    const restore_on_out_of_scope saved_mode( g->north_america_world );
    g->north_america_world = true;
    smallmap sample;
    map &window = *sample.cast_to_map();
    const point_abs_sm site( 9876, 23456 );
    const point_bub_ms middle( SEEX, SEEY );

    window.load( tripoint_abs_sm( site, -30 ), false, false );
    REQUIRE( window.inbounds_z( -30 ) );
    CHECK( window.ter( tripoint_bub_ms( middle, -30 ) ) == ter_t_rock.id() );
    CHECK( !window.inbounds_z( 0 ) );
    REQUIRE( window.ensure_z_in_window( tripoint_bub_ms( middle, -41 ) ) );
    CHECK( window.get_abs_sub().z() == -30 );
    CHECK( window.ter( tripoint_bub_ms( middle, -41 ) ) == ter_t_rock.id() );

    window.load( tripoint_abs_sm( site, 30 ), false, false );
    REQUIRE( window.inbounds_z( 30 ) );
    CHECK( window.ter( tripoint_bub_ms( middle, 30 ) ) == ter_t_open_air.id() );
    CHECK( !window.inbounds_z( -30 ) );
    REQUIRE( window.ensure_z_in_window( tripoint_bub_ms( middle, 41 ) ) );
    CHECK( window.get_abs_sub().z() == 30 );
    CHECK( window.ter( tripoint_bub_ms( middle, 41 ) ) == ter_t_open_air.id() );
}

TEST_CASE( "atlas_diagonal_slopes_have_visible_relief", "[north_america]" )
{
    CHECK( north_america::surface_relief_shade( point::zero ) == 0 );
    CHECK( north_america::surface_relief_shade( point( 25, -25 ) ) != 0 );
    CHECK( north_america::surface_relief_shade( point( -25, 25 ) ) != 0 );
    CHECK( north_america::surface_relief_shade( point( 25, 25 ) ) >
           north_america::surface_relief_shade( point( -25, -25 ) ) );
}

TEST_CASE( "atlas_george_washington_bridge_crosses_the_water_overmap_seam", "[north_america]" )
{
    const point_abs_omt left( -9361, 7354 );
    constexpr int span = 20;
    const point_abs_omt origin = left - point( 0, span / 2 );
    const auto water = north_america::raster( origin, 2, span );
    const auto west = north_america::road_network( origin, 1, span, false );
    const auto east = north_america::road_network( origin + point::east, 1, span, false );
    bool crosses = false;
    for( int i = 0; i < span; ++i ) {
        if( west[i].lanes >= 8 && east[i].lanes >= 8 &&
            water[i * 2] != north_america::terrain::land &&
            water[i * 2 + 1] != north_america::terrain::land &&
            om_lines::has_segment( west[i].mapped_connections, om_direction::type::east ) &&
            om_lines::has_segment( east[i].mapped_connections, om_direction::type::west ) ) {
            crosses = true;
        }
    }
    CHECK( crosses );
}

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
    const auto at = [&]( const point & position ) -> const north_america::road_cell & {
        return area[position.y * width + position.x];
    };
    CHECK( at( point( 20, 20 ) ).street == urban_road::arterial );
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
            const point cell( x, y );
            const std::size_t links = at( cell ).connections;
            if( at( cell ).street == urban_road::local && om_lines::all[links].mapgen == 1 ) {
                ++turns;
            }
            CHECK( om_lines::has_segment( links, om_direction::type::east ) ==
                   om_lines::has_segment( at( cell + point::east ).connections, om_direction::type::west ) );
            CHECK( om_lines::has_segment( links, om_direction::type::south ) ==
                   om_lines::has_segment( at( cell + point::south ).connections, om_direction::type::north ) );
        }
    }
    CHECK( turns > 15 );
    for( int offset = 0; offset < width; ++offset ) {
        const auto single = north_america::road_network( origin + point( 20, offset ), 1, 1 ).front();
        CHECK( single.connections == at( point( 20, offset ) ).connections );
        CHECK( single.street == at( point( 20, offset ) ).street );
    }
}

TEST_CASE( "atlas_start_clearance_measures_from_the_city_edge", "[north_america][worldgen]" )
{
    const point_abs_om winnipeg = project_to<coords::om>( point_abs_omt( -76078, -46705 ) );
    const int district_width = north_america::urban_district_size();
    std::optional<point_abs_omt> city_edge;
    for( const point_abs_om &om : closest_points_first( winnipeg, 2 ) ) {
        for( const north_america::urban_district &district : north_america::urban_districts_in( om ) ) {
            const point_abs_omt east = district.center + point( district_width - district_width / 2, 0 );
            if( !north_america::in_urban_footprint( east ) ) {
                city_edge = east - point::east;
                break;
            }
        }
        if( city_edge ) {
            break;
        }
    }
    REQUIRE( city_edge );
    const point_abs_omt just_outside = *city_edge + point::east;
    CHECK_FALSE( north_america::in_urban_footprint( just_outside ) );
    CHECK( north_america::in_urban_footprint( just_outside, 11 ) );
    const point_abs_omt beyond_buffer = *city_edge + point::east * 12;
    CHECK_FALSE( north_america::in_urban_footprint( beyond_buffer, 11 ) );
}

TEST_CASE( "outskirts_shelter_can_be_added_beyond_the_existing_city", "[north_america][worldgen]" )
{
    const restore_on_out_of_scope saved_mode( g->north_america_world );
    g->north_america_world = false;
    const auto om = std::make_unique<overmap>( point_abs_om( 200, 200 ) );
    const point_om_omt town( OMAPX / 2, OMAPY / 2 );
    om->cities.emplace_back( "Start test", town, 6 );
    const oter_id field( "field" );
    for( int y = 0; y < OMAPY; ++y ) {
        for( int x = 0; x < OMAPX; ++x ) {
            om->ter_set( tripoint_om_omt( x, y, 0 ), field );
        }
    }

    const tripoint_om_omt shelter = om->place_outskirts_shelter();
    REQUIRE_FALSE( shelter.is_invalid() );
    CHECK( square_dist( town.raw(), shelter.xy().raw() ) >= 18 );
    CHECK( om->is_far_from_city( shelter ) );
    CHECK( om->ter( shelter )->get_type_id() == oter_type_shelter );
    CHECK( om->ter( shelter + tripoint::below )->get_type_id() == oter_type_shelter_under );
    CHECK( om->ter( shelter + tripoint::above )->get_type_id() == oter_type_shelter_roof );
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
    const std::size_t links = om_lines::set_segment(
                                  om_lines::set_segment( 0, om_direction::type::north ), om_direction::type::east );
    mapgendata corner( base, oter_type_atlas_road_bridge->get_linear( links ) );
    REQUIRE( north_america::draw_mapped_road( corner ) );

    for( int i = 0; i < SEEX; ++i ) {
        CHECK( here.ter( tripoint_bub_ms( SEEX, i, 0 ) ) != ter_t_water_moving_dp.id() );
        CHECK( here.ter( tripoint_bub_ms( SEEX + i, SEEY, 0 ) ) != ter_t_water_moving_dp.id() );
    }
    CHECK( here.ter( tripoint_bub_ms( SEEX, 2 * SEEY - 1, 0 ) ) == ter_t_water_moving_dp.id() );
    CHECK( here.ter( tripoint_bub_ms( 0, SEEY, 0 ) ) == ter_t_water_moving_dp.id() );
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
    const point_abs_omt origin = project_to<coords::omt>( location );
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
                    const point across = vertical ? point::east : point::south;
                    bool has_core = false;
                    for( const int direction : {
                             -1, 1
                             } ) {
                        for( int n = 1; n <= north_america::max_road_flanks; ++n ) {
                            const oter_id other = om->ter( p + across * ( direction * n ) );
                            if( other != terrain ) {
                                has_core = has_core || other == core;
                                break;
                            }
                        }
                    }
                    CHECK( has_core );
                    const point step = vertical ? point::north : point::east;
                    CHECK( ( om->ter( p + step ) == terrain || om->ter( p - step ) == terrain ) );
                    continue;
                }
                if( terrain->is_water() || terrain->type_is( oter_type_road ) ) {
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
                if( overmap_location_land->test( terrain ) ) {
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

TEST_CASE( "atlas_highways_reserve_multiple_overmap_columns", "[north_america][worldgen]" )
{
    const restore_on_out_of_scope saved_mode( g->north_america_world );
    g->north_america_world = true;
    const std::size_t links = om_lines::set_segment(
                                  om_lines::set_segment( 0, om_direction::type::north ), om_direction::type::south );
    for( const unsigned lanes : {
             6u, 8u
         } ) {
        const auto om = std::make_unique<overmap>( point_abs_om::zero );
        std::vector<north_america::road_cell> roads( OMAPX * OMAPY );
        for( int y = 20; y < 36; ++y ) {
            auto &cell = roads[y * OMAPX + 40];
            cell.lanes = lanes;
            cell.connections = cell.mapped_connections = links;
        }
        overmap_test_helper::place_atlas_roads_on_land( *om, roads );
        CAPTURE( lanes );
        REQUIRE( om->ter( { 40, 28, 0 } ) == oter_id( "road_ns" ) );
        int width = 1;
        for( const int direction : {
                 -1, 1
                 } ) {
            for( int n = 1; n <= north_america::max_road_flanks; ++n ) {
                if( !north_america::is_avenue_flank( om->ter( { 40 + direction * n, 28, 0 } ) ) ) {
                    break;
                }
                ++width;
            }
        }
        CHECK( width == lanes / 2 );
    }
}

TEST_CASE( "atlas_city_building_can_be_placed_at_an_overmap_edge",
           "[north_america][worldgen]" )
{
    const auto om = std::make_unique<overmap>( point_abs_om::zero );
    const tripoint_om_omt edge( 0, OMAPY / 2, 0 );
    const overmap_special_id &house = overmap_special_house_regional_cape_cod;
    const city town( "" );
    const om_direction::type facing = om_direction::type::north;
    REQUIRE( house.is_valid() );
    om->ter_set( edge, oter_id( "field" ) );

    CHECK_FALSE( om->can_place_special( *house, edge, facing, false ) );
    REQUIRE( om->can_place_special( *house, edge, facing, false, 0 ) );
    const auto occupied = om->place_special( *house, edge, facing, town, false, false, 0 );
    CHECK( occupied.size() == 2 );
    CHECK( om->ter( edge ) == oter_id( "house_regional_cape_cod_north" ) );
    CHECK( om->ter( edge + tripoint::above ) == oter_id( "house_regional_cape_cod_roof_north" ) );
}

TEST_CASE( "atlas_overmap_overlay_queries_handle_layers_without_stored_metadata",
           "[north_america][worldgen]" )
{
    const auto om = std::make_unique<overmap>( point_abs_om::zero );
    const tripoint_om_omt marked( OMAPX / 2, OMAPY / 2, 0 );
    om->add_note( marked, "Danger" );
    om->mark_note_dangerous( marked, 1, true );
    REQUIRE( om->is_marked_dangerous( marked ) );
    for( const int z : {
             -OVERMAP_DEPTH - 1, OVERMAP_HEIGHT + 1
             } ) {
        const tripoint_om_omt outside( marked.xy(), z );
        CAPTURE( z );
        CHECK_FALSE( om->is_marked_dangerous( outside ) );
        CHECK( om->find_notes( z, "" ).empty() );
        CHECK( om->find_extras( z, "" ).empty() );
        CHECK_FALSE( om->get_omt_summary( outside ) );
    }
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

    REQUIRE( overmap_special_Motel.is_valid() );
    REQUIRE( overmap_special_Motel->get_constraints().occurrences.min > 0 );
    overmap_special_batch specials( origin, { &overmap_special_Motel.obj() } );
    const int count_before = overmap_buffer.global_state.overmap_count;
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
    const int count_before = overmap_buffer.global_state.overmap_count;
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
