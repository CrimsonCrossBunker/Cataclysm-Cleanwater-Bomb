#pragma once
#ifndef CATA_TESTS_OVERMAP_TEST_HELPERS_H
#define CATA_TESTS_OVERMAP_TEST_HELPERS_H

#include <array>
#include <bitset>
#include <map>
#include <vector>

#include "character_id.h"
#include "coordinates.h"
#include "mongroup.h"
#include "north_america.h"
#include "north_america_transport.h"
#include "overmap.h"

class overmap_test_helper
{
    public:
        static void place_atlas_roads_on_land( overmap &om,
                                               const std::vector<north_america::road_cell> &network ) {
            const std::vector<north_america::terrain> land(
                ( OMAPX + 2 ) * ( OMAPY + 2 ), north_america::terrain::land );
            om.place_atlas_roads( network, land );
        }
        static bool generate_atlas_streets_and_buildings( overmap &om ) {
            std::vector<north_america::terrain> coast;
            if( !om.place_north_american_water( coast ) ) {
                return false;
            }
            const auto streets = north_america::road_network( om.global_base_point(), OMAPX, OMAPY );
            om.place_atlas_roads( streets, coast );
            om.place_cities();
            om.build_cities();
            om.build_atlas_neighborhoods( *overmap_connection_id( "local_road" ), streets );
            om.flood_fill_city_tiles();
            return true;
        }
        static void place_specials( overmap &om, overmap_special_batch &specials ) {
            om.place_specials( specials );
        }
        static void generate_railroads( overmap &om ) {
            om.place_railroads( std::vector<const overmap *>( 4, nullptr ) );
        }
        static void set_highway_connections(
            overmap &om,
            const std::array<tripoint_om_omt, 4> &conns ) {
            om.highway_connections = conns;
        }
        static const std::array<tripoint_om_omt, 4> &get_highway_connections(
            const overmap &om ) {
            return om.highway_connections;
        }
        static bool select_highway_end_points( overmap &om,
                                               const std::vector<const overmap *> &neighbors,
                                               std::array<tripoint_om_omt, 4> &end_points,
                                               std::bitset<4> &connections ) {
            return om.highway_select_end_points( neighbors, end_points, connections, {}, 0 );
        }
        static void place_nemesis( overmap &om, const tripoint_abs_omt &p, int mission_id = -1 ) {
            om.place_nemesis( p, mission_id );
        }
        static void signal_nemesis( overmap &om, const tripoint_abs_sm &p, character_id who ) {
            om.signal_nemesis( p, who );
        }
        static void move_nemesis( overmap &om ) {
            om.move_nemesis();
        }
        static bool remove_nemesis( overmap &om, character_id who ) {
            return om.remove_nemesis( who );
        }
        static std::multimap<tripoint_om_sm, mongroup> &groups( overmap &om ) {
            return om.zg;
        }
};

#endif // CATA_TESTS_OVERMAP_TEST_HELPERS_H
