#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_ECOLOGY_H
#define CATA_SRC_NORTH_AMERICA_ECOLOGY_H

#include <array>
#include <cstddef>
#include <string>
#include <vector>

#include "coordinates.h"

class mapgendata;

namespace north_america
{
float forest_adjustment( point_abs_omt pos );
double rural_city_multiplier( point_abs_om pos );
int population_band( point_abs_omt pos );
int rural_population_band( point_abs_omt pos );
int rural_town_size( point_abs_omt pos );
int named_city_size( int population );

struct urban_district {
    point_abs_omt center;
    std::size_t city_index;
    unsigned open_edges = 0;
};

const std::vector<urban_district> &urban_districts_in( point_abs_om pos );
bool in_urban_footprint( point_abs_omt pos );
// Development density within a populated atlas district, from 0 to 100.
int urban_density( const urban_district &district, point_abs_omt pos );
int urban_district_size();

inline constexpr int minimum_zoned_population = 100'000;

enum class urban_zone { housing, commercial, downtown, industrial, institutional };

struct city_zone_center {
    point_abs_omt center;
    int radius;
    urban_zone zone;
};

const std::array<city_zone_center, 4> &city_zone_centers( std::size_t city_index );
std::string ecoregion_code( point_abs_omt pos );
void place_native_vegetation( mapgendata &dat );
} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_ECOLOGY_H
