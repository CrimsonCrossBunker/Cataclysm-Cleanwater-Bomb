#pragma once
#ifndef CATA_SRC_SPACE_LUNAR_TRANSFER_MODEL_H
#define CATA_SRC_SPACE_LUNAR_TRANSFER_MODEL_H

#include "space_orbit_model.h"

namespace space_model
{
struct lunar_transfer {
    orbit earth_leg;
    double lunar_entry_s;
    double lunar_encounter_s;
    double departure_delta_v_km_s;
    double capture_delta_v_km_s;
    state required_parking_state;
    state lunar_entry;
};

lunar_transfer plan_lunar_transfer( double departure_s, double earth_parking_altitude_km,
                                    double lunar_parking_altitude_km );
} // namespace space_model

#endif // CATA_SRC_SPACE_LUNAR_TRANSFER_MODEL_H
