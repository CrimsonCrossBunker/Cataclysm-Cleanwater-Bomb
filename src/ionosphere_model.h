#pragma once
#ifndef CATA_SRC_IONOSPHERE_MODEL_H
#define CATA_SRC_IONOSPHERE_MODEL_H

namespace ionosphere_model
{
struct sample {
    double d_electrons_m3;
    double e_electrons_m3;
    double f_electrons_m3;
    double total_electrons_m3;
    double plasma_frequency_hz;
};

sample evaluate( double altitude_km, double solar_elevation_deg );
} // namespace ionosphere_model

#endif // CATA_SRC_IONOSPHERE_MODEL_H
