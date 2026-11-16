#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_ECOLOGY_H
#define CATA_SRC_NORTH_AMERICA_ECOLOGY_H

#include <cstddef>
#include <string>
#include <vector>

#include "coordinates.h"

class mapgendata;

namespace north_america
{
float forest_adjustment( point_abs_omt pos );
double rural_city_multiplier( point_abs_om pos );
int rural_population_band( point_abs_omt pos );
int rural_town_size( point_abs_omt pos );
int named_city_size( int population );

struct urban_district {
    point_abs_omt center;
    std::size_t city_index;
};

const std::vector<urban_district> &urban_districts_in( point_abs_om pos );
bool in_urban_footprint( point_abs_omt pos );
int urban_district_size();
std::string ecoregion_code( point_abs_omt pos );
void place_native_vegetation( mapgendata &dat );
} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_ECOLOGY_H
