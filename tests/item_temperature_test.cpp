#include <cmath>
#include <limits>

#include "cata_catch.h"
#include "item_temperature.h"

static item_temperature_input thermal_sample()
{
    return { 293.15f, 263.15f, 263.15f * 2.0f, 1000.0f, 1000, 1.0f,
             4.0f, 2.0f, 334.0f, 273.15f, 600 };
}

TEST_CASE( "item_thermal_kernel_retains_newton_cooling", "[item][temperature][threading]" )
{
    item_temperature_input input = thermal_sample();
    const float conductivity = 0.0076 * std::pow( input.volume, 2.0 / 3.0 ) / input.insulation;

    SECTION( "solid warms without melting" ) {
        const auto result = calculate_item_temperature( input );
        const float expected = -( input.environment - input.temperature ) *
                               std::exp( -input.turns * conductivity / ( input.mass * input.solid_heat ) ) +
                               input.environment;
        CHECK_FALSE( result.equilibrium );
        CHECK( result.temperature == expected );
        CHECK( result.energy == expected * input.solid_heat );
        CHECK( result.frozen == 1.0f );
    }
    SECTION( "liquid cools without freezing" ) {
        input.environment = 283.15f;
        input.temperature = 313.15f;
        const float liquid_energy = input.solid_heat * input.freezing + input.latent_heat;
        input.energy = liquid_energy + ( input.temperature - input.freezing ) * input.liquid_heat;
        const auto result = calculate_item_temperature( input );
        const float expected = -( input.environment - input.temperature ) *
                               std::exp( -input.turns * conductivity / ( input.mass * input.liquid_heat ) ) +
                               input.environment;
        CHECK_FALSE( result.equilibrium );
        CHECK( result.temperature == expected );
        CHECK( result.energy == ( expected - input.freezing ) * input.liquid_heat + liquid_energy );
        CHECK( result.frozen == 0.0f );
    }
}

TEST_CASE( "item_thermal_kernel_retains_phase_changes", "[item][temperature][threading]" )
{
    item_temperature_input input = thermal_sample();
    input.temperature = input.freezing;
    const float solid_energy = input.solid_heat * input.freezing;
    const float liquid_energy = solid_energy + input.latent_heat;
    input.energy = solid_energy + input.latent_heat / 2;

    SECTION( "partially frozen matter absorbs latent heat" ) {
        const auto result = calculate_item_temperature( input );
        const float conductivity = 0.0076 * std::pow( input.volume, 2.0 / 3.0 ) / input.insulation;
        const float expected = input.energy + conductivity * ( input.environment - input.temperature ) *
                               input.turns / input.mass;
        CHECK_FALSE( result.equilibrium );
        CHECK( result.temperature == input.freezing );
        CHECK( result.energy == expected );
        CHECK( result.frozen == ( liquid_energy - expected ) / ( liquid_energy - solid_energy ) );
    }
    SECTION( "long warming of a small solid retains equilibrium shortcut" ) {
        input.mass = 1;
        input.volume = 1;
        input.temperature = 263.15f;
        input.energy = input.temperature * input.solid_heat;
        input.turns = 3600;
        const auto result = calculate_item_temperature( input );
        CHECK( result.equilibrium );
        CHECK( result.temperature == input.environment );
    }
    SECTION( "long cooling of a small liquid retains equilibrium shortcut" ) {
        input.mass = 1;
        input.volume = 1;
        input.temperature = 283.15f;
        input.environment = 253.15f;
        input.energy = liquid_energy + ( input.temperature - input.freezing ) * input.liquid_heat;
        input.turns = 3600;
        const auto result = calculate_item_temperature( input );
        CHECK( result.equilibrium );
        CHECK( result.temperature == input.environment );
    }
}

TEST_CASE( "item_thermal_input_checks_every_captured_value", "[item][temperature][threading]" )
{
    const auto original = thermal_sample();
    auto changed = original;
    CHECK( changed == original );
    for( float item_temperature_input::*field : {
             &item_temperature_input::environment, &item_temperature_input::temperature,
             &item_temperature_input::energy, &item_temperature_input::mass,
             &item_temperature_input::insulation, &item_temperature_input::liquid_heat,
             &item_temperature_input::solid_heat, &item_temperature_input::latent_heat,
             &item_temperature_input::freezing } ) {
        changed = original;
        changed.*field = std::nextafter( changed.*field, std::numeric_limits<float>::infinity() );
        CHECK_FALSE( changed == original );
    }
    changed = original;
    ++changed.volume;
    CHECK_FALSE( changed == original );
    changed = original;
    ++changed.turns;
    CHECK_FALSE( changed == original );
}
