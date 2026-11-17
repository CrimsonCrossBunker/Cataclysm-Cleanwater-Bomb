#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_TRANSPORT_H
#define CATA_SRC_NORTH_AMERICA_TRANSPORT_H

#include <cstddef>
#include <vector>

#include "coordinates.h"
#include "type_id.h"

class mapgendata;

namespace north_america
{

enum class urban_road { none, local, collector, arterial };

inline constexpr int min_wide_road_run = 4;
inline constexpr int max_road_flanks = 3;

struct road_cell {
    unsigned lanes = 0;
    std::size_t connections = 0;
    std::size_t mapped_connections = 0;
    urban_road street = urban_road::none;
};

// Connection masks use north, east, south, west. Only the second function
// downsamples geometry, for the continent-scale map.
std::vector<road_cell> road_network( point_abs_omt origin, int width, int height,
                                     bool include_local_streets = true );
std::vector<unsigned> chart_roads( point_abs_omt origin, int width, int height, int stride );
oter_id avenue_flank( bool north_south );
bool is_avenue_flank( const oter_id &terrain );
bool draw_mapped_road( mapgendata &dat );

} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_TRANSPORT_H
