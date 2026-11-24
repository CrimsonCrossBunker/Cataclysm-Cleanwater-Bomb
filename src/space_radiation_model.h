#pragma once
#ifndef CATA_SRC_SPACE_RADIATION_MODEL_H
#define CATA_SRC_SPACE_RADIATION_MODEL_H

#include "space_orbit_model.h"

namespace space_model
{
struct radiation_sample {
    double galactic_msv_h;
    double trapped_msv_h;
    double solar_msv_h;
    double total_msv_h;
    double dose_msv;
};

radiation_sample radiation( const state &target, double shield_g_cm2, double solar_event_strength,
                            double duration_s );
} // namespace space_model

#endif // CATA_SRC_SPACE_RADIATION_MODEL_H
