#include "item_temperature.h"

#include <cmath>
#include <tuple>

bool item_temperature_input::operator==( const item_temperature_input &other ) const
{
    return std::tie( environment, temperature, energy, mass, volume, insulation,
                     liquid_heat, solid_heat, latent_heat, freezing, turns ) ==
           std::tie( other.environment, other.temperature, other.energy, other.mass,
                     other.volume, other.insulation, other.liquid_heat, other.solid_heat,
                     other.latent_heat, other.freezing, other.turns );
}

item_temperature_result calculate_item_temperature( const item_temperature_input &input )
{
    const float env_temperature = input.environment;
    const float temperature_difference = env_temperature - input.temperature;
    const float mass = input.mass;
    const float conductivity_term = 0.0076 * std::pow( input.volume, 2.0 / 3.0 ) / input.insulation;
    const float specific_heat_liquid = input.liquid_heat;
    const float specific_heat_solid = input.solid_heat;
    const float latent_heat = input.latent_heat;
    const float freezing_temperature = input.freezing;
    const float specific_energy = input.energy;
    const float completely_frozen_specific_energy = specific_heat_solid * freezing_temperature;
    const float completely_liquid_specific_energy = completely_frozen_specific_energy + latent_heat;

    float new_specific_energy;
    float new_item_temperature;
    float freeze_percentage = 0.0f;
    int extra_time;

    // Temperature calculations based on Newton's law of cooling.
    // Calculations are done assuming that the item stays in its phase.
    // This assumption can cause over heating when transitioning from melting to liquid.
    // In other transitions the item may cool/heat too little but that won't be a problem.
    if( specific_energy < completely_frozen_specific_energy ) {
        // Was solid.
        new_item_temperature = ( - temperature_difference
                                 * std::exp( - input.turns * conductivity_term / ( mass * specific_heat_solid ) )
                                 + env_temperature );
        new_specific_energy = new_item_temperature * specific_heat_solid;
        if( new_item_temperature > freezing_temperature + 0.5 ) {
            // Started melting before temp was calculated.
            // 0.5 is here because we don't care if it heats up a bit too high
            // Calculate how long the item was solid
            // and apply rest of the time as melting
            extra_time = input.turns
                         - std::log( - temperature_difference / ( freezing_temperature - env_temperature ) )
                         * ( mass * specific_heat_solid / conductivity_term );
            new_specific_energy = ( completely_frozen_specific_energy )
                                  + conductivity_term
                                  * ( env_temperature - freezing_temperature ) * extra_time / mass;
            new_item_temperature = freezing_temperature;
            if( new_specific_energy > completely_liquid_specific_energy ) {
                // The item then also finished melting.
                // This may happen rarely with very small items
                // Just set the item to environment temperature
                return { env_temperature, 0, 0, true };
            }
        }
    } else if( specific_energy > completely_liquid_specific_energy ) {
        // Was liquid.
        new_item_temperature = ( - temperature_difference
                                 * std::exp( - input.turns * conductivity_term / ( mass *
                                             specific_heat_liquid ) )
                                 + env_temperature );
        new_specific_energy = ( new_item_temperature - freezing_temperature ) * specific_heat_liquid +
                              ( completely_liquid_specific_energy );
        if( new_item_temperature < freezing_temperature - 0.5 ) {
            // Started freezing before temp was calculated.
            // 0.5 is here because we don't care if it cools down a bit too low
            // Calculate how long the item was liquid
            // and apply rest of the time as freezing
            extra_time = input.turns
                         - std::log( - temperature_difference / ( freezing_temperature - env_temperature ) )
                         * ( mass * specific_heat_liquid / conductivity_term );
            new_specific_energy = ( completely_liquid_specific_energy )
                                  + conductivity_term
                                  * ( env_temperature - freezing_temperature ) * extra_time / mass;
            new_item_temperature = freezing_temperature;
            if( new_specific_energy < completely_frozen_specific_energy ) {
                // The item then also finished freezing.
                // This may happen rarely with very small itemsconductivity_term
                // Just set the item to environment temperature
                return { env_temperature, 0, 0, true };
            }
        }
    } else {
        // Was melting or freezing
        new_specific_energy = ( specific_energy ) + conductivity_term *
                              temperature_difference * input.turns / mass;
        new_item_temperature = freezing_temperature;
        if( new_specific_energy > completely_liquid_specific_energy ) {
            // Item melted before temp was calculated
            // Calculate how long the item was melting
            // and apply rest of the time as liquid
            extra_time = input.turns - ( mass / ( conductivity_term * temperature_difference ) )
                         *
                         ( completely_liquid_specific_energy - specific_energy );
            new_item_temperature = ( ( freezing_temperature - env_temperature )
                                     * std::exp( - extra_time * conductivity_term / ( mass *
                                                 specific_heat_liquid ) )
                                     + env_temperature );
            new_specific_energy = ( new_item_temperature - freezing_temperature ) * specific_heat_liquid +
                                  ( completely_liquid_specific_energy );
        } else if( new_specific_energy < completely_frozen_specific_energy ) {
            // Item froze before temp was calculated
            // Calculate how long the item was freezing
            // and apply rest of the time as solid
            extra_time = input.turns - ( mass / ( conductivity_term * temperature_difference ) )
                         *
                         ( completely_frozen_specific_energy - specific_energy );
            new_item_temperature = ( ( freezing_temperature - env_temperature )
                                     * std::exp( - extra_time * conductivity_term / ( mass *
                                                 specific_heat_solid ) )
                                     + env_temperature );
            new_specific_energy = new_item_temperature * specific_heat_solid;
        }
    }
    // Check freeze status now based on energies.
    if( new_specific_energy > completely_liquid_specific_energy ) {
        freeze_percentage = 0;
    } else if( new_specific_energy < completely_frozen_specific_energy ) {
        // Item is solid
        freeze_percentage = 1;
    } else {
        // Item is partially solid
        freeze_percentage = ( ( completely_liquid_specific_energy ) -
                              new_specific_energy ) /
                            ( completely_liquid_specific_energy - completely_frozen_specific_energy );
    }
    return { new_item_temperature, new_specific_energy, freeze_percentage, false };
}

