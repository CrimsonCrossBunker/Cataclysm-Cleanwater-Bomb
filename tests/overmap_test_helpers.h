#pragma once
#ifndef CATA_TESTS_OVERMAP_TEST_HELPERS_H
#define CATA_TESTS_OVERMAP_TEST_HELPERS_H

#include <array>
#include <map>
#include <vector>

#include "character_id.h"
#include "coordinates.h"
#include "mongroup.h"
#include "overmap.h"

class overmap_test_helper
{
    public:
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
