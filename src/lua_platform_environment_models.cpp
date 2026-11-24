#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_environment_models.h"

#include <stdexcept>
#include <string>
#include <utility>

#include "ionosphere_model.h"
#include "near_earth_orbit_model.h"
#include "troposphere_model.h"

namespace cata::lua_platform
{
namespace
{
double required_number( const sol::table &options, const char *key )
{
    const sol::object value = options.raw_get<sol::object>( key );
    if( value.get_type() != sol::type::number ) {
        throw std::invalid_argument( std::string( key ) + " must be a number" );
    }
    return value.as<double>();
}

sol::table vector_snapshot( sol::state_view lua, const near_earth_orbit_model::vector3 &value )
{
    return lua.create_table_with( "x", value.x, "y", value.y, "z", value.z );
}
} // namespace

void install_environment_models_api( sol::table &services,
                                     const std::function<void()> &require_read )
{
    sol::state_view lua( services.lua_state() );
    sol::table models = lua.create_table();
    models.set_function( "ionosphere", [require_read]( sol::this_state state, double altitude_km,
    double solar_elevation_deg ) {
        require_read();
        const auto result = ionosphere_model::evaluate( altitude_km, solar_elevation_deg );
        return sol::state_view( state ).create_table_with(
                   "d_electrons_m3", result.d_electrons_m3, "e_electrons_m3", result.e_electrons_m3,
                   "f_electrons_m3", result.f_electrons_m3, "total_electrons_m3", result.total_electrons_m3,
                   "plasma_frequency_hz", result.plasma_frequency_hz );
    } );
    models.set_function( "troposphere", [require_read]( sol::this_state state, double altitude_m,
    const sol::optional<sol::table> &reference ) {
        require_read();
        const auto result = reference ? troposphere_model::evaluate( altitude_m,
                            required_number( *reference, "altitude_m" ),
                            required_number( *reference, "temperature_k" ),
                            required_number( *reference, "pressure_pa" ) ) : troposphere_model::evaluate( altitude_m );
        return sol::state_view( state ).create_table_with(
                   "temperature_k", result.temperature_k, "pressure_pa", result.pressure_pa,
                   "density_kg_m3", result.density_kg_m3, "speed_of_sound_m_s", result.speed_of_sound_m_s );
    } );
    models.set_function( "near_earth_orbit", [require_read]( sol::this_state state,
    const sol::table &elements, double elapsed_s ) {
        require_read();
        const auto result = near_earth_orbit_model::propagate( {
            required_number( elements, "perigee_altitude_km" ),
            required_number( elements, "apogee_altitude_km" ),
            required_number( elements, "inclination_deg" ),
            required_number( elements, "ascending_node_deg" ),
            required_number( elements, "argument_of_perigee_deg" ),
            required_number( elements, "mean_anomaly_deg" )
        }, elapsed_s );
        sol::state_view lua( state );
        return lua.create_table_with( "position_km", vector_snapshot( lua, result.position_km ),
                                      "velocity_km_s", vector_snapshot( lua, result.velocity_km_s ),
                                      "altitude_km", result.altitude_km, "period_s", result.period_s );
    } );
    services["environment_models"] = std::move( models );
}
} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
