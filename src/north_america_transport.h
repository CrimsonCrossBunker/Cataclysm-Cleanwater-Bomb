#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_TRANSPORT_H
#define CATA_SRC_NORTH_AMERICA_TRANSPORT_H

#include <cstddef>
#include <vector>

#include "coordinates.h"

class mapgendata;

namespace north_america
{

struct road_cell {
    unsigned lanes = 0;
    std::size_t connections = 0;
};

// Connection masks use north, east, south, west. Only the second function
// downsamples geometry, for the continent-scale map.
std::vector<road_cell> road_network( point_abs_omt origin, int width, int height );
std::vector<unsigned> chart_roads( point_abs_omt origin, int width, int height, int stride );
bool draw_mapped_road( mapgendata &dat );

} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_TRANSPORT_H
