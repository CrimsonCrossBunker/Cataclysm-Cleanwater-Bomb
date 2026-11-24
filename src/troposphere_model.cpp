#include "troposphere_model.h"

#include <cmath>
#include <stdexcept>

namespace troposphere_model
{
sample evaluate( double altitude_m, double reference_altitude_m,
                 double reference_temperature_k, double reference_pressure_pa )
{
    const auto valid_altitude = []( double value ) {
        return std::isfinite( value ) && value >= -500.0 && value <= 11000.0;
    };
    if( !valid_altitude( altitude_m ) || !valid_altitude( reference_altitude_m ) ) {
        throw std::invalid_argument( "troposphere altitudes must be between -500 and 11000 m" );
    }
    if( !std::isfinite( reference_temperature_k ) || reference_temperature_k < 180.0 ||
        reference_temperature_k > 340.0 ) {
        throw std::invalid_argument( "troposphere reference_temperature_k must be between 180 and 340" );
    }
    if( !std::isfinite( reference_pressure_pa ) || reference_pressure_pa < 10000.0 ||
        reference_pressure_pa > 120000.0 ) {
        throw std::invalid_argument( "troposphere reference_pressure_pa must be between 10000 and 120000" );
    }

    constexpr double lapse_rate_k_m = 0.0065;
    constexpr double gravity_m_s2 = 9.80665;
    constexpr double dry_air_gas_constant = 287.05287;
    constexpr double heat_capacity_ratio = 1.4;
    const double temperature = reference_temperature_k -
                               lapse_rate_k_m * ( altitude_m - reference_altitude_m );
    const double pressure = reference_pressure_pa * std::pow( temperature / reference_temperature_k,
                            gravity_m_s2 / ( dry_air_gas_constant * lapse_rate_k_m ) );
    return { temperature, pressure, pressure / ( dry_air_gas_constant * temperature ),
             std::sqrt( heat_capacity_ratio * dry_air_gas_constant * temperature ) };
}
} // namespace troposphere_model
