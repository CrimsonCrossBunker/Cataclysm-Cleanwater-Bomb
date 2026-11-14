#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_ECOLOGY_H
#define CATA_SRC_NORTH_AMERICA_ECOLOGY_H

#include <string>

#include "coordinates.h"

class mapgendata;

namespace north_america
{
float forest_adjustment( point_abs_omt pos );
double rural_city_multiplier( point_abs_om pos );
std::string ecoregion_code( point_abs_omt pos );
void place_native_vegetation( mapgendata &dat );
} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_ECOLOGY_H