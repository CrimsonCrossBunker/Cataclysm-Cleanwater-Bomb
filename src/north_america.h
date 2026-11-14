#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_H
#define CATA_SRC_NORTH_AMERICA_H

#include <string>
#include <vector>

#include "coordinates.h"
#include "regional_climate.h"

namespace north_america
{

enum class terrain { land, ocean, lake, river };

struct place {
    std::string country;
    std::string region;
    std::string name;
    point_abs_omt position;
    int population;
};

bool available();
bool active();
bool offer_starting_city();
const std::vector<place> &cities();
regional_climate::coordinates location( point_abs_ms position );
// The caller can include a border to make shoreline classification independent of generation order.
std::vector<terrain> raster( point_abs_omt origin, int width, int height );

} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_H
