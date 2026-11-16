#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_SOIL_H
#define CATA_SRC_NORTH_AMERICA_SOIL_H

#include "coordinates.h"
#include "type_id.h"

class mapgendata;

namespace north_america
{

ter_str_id mapped_soil_at( point_abs_ms position );
int permafrost_coverage_at( point_abs_ms position );
void place_native_soil( mapgendata &dat );

// Use these for legacy exact terrain checks and transitions between the two
// states of a dirt tile. Classic dirt and dirt mounds remain valid inputs.
ter_id canonical_soil( ter_id terrain );
ter_id preserve_soil( ter_id terrain, ter_id replacement );
ter_id tilled_soil( ter_id surface );
ter_id planted_soil( ter_id mound );

struct crop_soil_properties {
    double water_capacity = 1.0;
    double infiltration = 1.0;
    double drainage = 0.0;
    double root_growth = 1.0;
};

crop_soil_properties crop_soil_at( ter_id terrain );

} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_SOIL_H
