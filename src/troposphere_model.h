#pragma once
#ifndef CATA_SRC_TROPOSPHERE_MODEL_H
#define CATA_SRC_TROPOSPHERE_MODEL_H

namespace troposphere_model
{
struct sample {
    double temperature_k;
    double pressure_pa;
    double density_kg_m3;
    double speed_of_sound_m_s;
};

sample evaluate( double altitude_m, double reference_altitude_m = 0.0,
                 double reference_temperature_k = 288.15, double reference_pressure_pa = 101325.0 );
} // namespace troposphere_model

#endif // CATA_SRC_TROPOSPHERE_MODEL_H
