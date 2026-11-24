#pragma once
#ifndef CATA_SRC_SPACE_EARTH_MOON_MODEL_H
#define CATA_SRC_SPACE_EARTH_MOON_MODEL_H

#include "space_orbit_model.h"

namespace space_model
{
state moon_ephemeris( double time_s );
state recenter( const state &motion, body center );
} // namespace space_model

#endif // CATA_SRC_SPACE_EARTH_MOON_MODEL_H
