#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_space_models.h"

#include <stdexcept>
#include <string>
#include <utility>

#include "space_earth_moon_model.h"
#include "space_lunar_transfer_model.h"
#include "space_observation_model.h"
#include "space_orbit_model.h"
#include "space_radiation_model.h"

namespace cata::lua_platform
{
namespace
{
using namespace space_model;

bool missing( const sol::object &value )
{
    return !value.valid() || value.get_type() == sol::type::lua_nil;
}

double number( const sol::table &table, const char *key )
{
    const sol::object value = table.raw_get<sol::object>( key );
    if( value.get_type() != sol::type::number ) {
        throw std::invalid_argument( std::string( key ) + " must be a number" );
    }
    return value.as<double>();
}

double number_or( const sol::table &table, const char *key, double fallback = 0.0 )
{
    return missing( table.raw_get<sol::object>( key ) ) ? fallback : number( table, key );
}

sol::table nested( const sol::table &table, const char *key )
{
    const sol::object value = table.raw_get<sol::object>( key );
    if( value.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( key ) + " must be a table" );
    }
    return value.as<sol::table>();
}

body read_body( const std::string &value )
{
    if( value == "earth" ) {
        return body::earth;
    }
    if( value == "moon" ) {
        return body::moon;
    }
    throw std::invalid_argument( "space center must be earth or moon" );
}

const char *body_name( body value )
{
    return value == body::earth ? "earth" : "moon";
}

constexpr const char *inertial_frame = "simulation_inertial";

vector3 read_vector( const sol::table &table )
{
    return { number( table, "x" ), number( table, "y" ), number( table, "z" ) };
}

orbit read_orbit( const sol::table &table )
{
    return { read_body( table.raw_get<std::string>( "center" ) ),
             number( table, "periapsis_altitude_km" ), number( table, "apoapsis_altitude_km" ),
             number_or( table, "inclination_deg" ), number_or( table, "ascending_node_deg" ),
             number_or( table, "argument_of_periapsis_deg" ), number_or( table, "mean_anomaly_deg" ),
             number_or( table, "epoch_s" ) };
}

state read_state( const sol::table &table )
{
    if( table.raw_get<std::string>( "frame" ) != inertial_frame ) {
        throw std::invalid_argument( "space state frame must be simulation_inertial" );
    }
    return { read_body( table.raw_get<std::string>( "center" ) ), number( table, "time_s" ),
             read_vector( nested( table, "position_km" ) ),
             read_vector( nested( table, "velocity_km_s" ) ) };
}

observer read_observer( const sol::table &table )
{
    return { number( table, "latitude_deg" ), number( table, "longitude_deg" ),
             number_or( table, "altitude_km" ) };
}

sol::table vector_snapshot( sol::state_view lua, vector3 value )
{
    return lua.create_table_with( "x", value.x, "y", value.y, "z", value.z );
}

sol::table state_snapshot( sol::state_view lua, const state &motion )
{
    return lua.create_table_with( "center", body_name( motion.center ), "frame", inertial_frame,
                                  "time_s", motion.time_s,
                                  "position_km", vector_snapshot( lua, motion.position_km ),
                                  "velocity_km_s", vector_snapshot( lua, motion.velocity_km_s ) );
}

sol::table orbit_snapshot( sol::state_view lua, const orbit &elements )
{
    return lua.create_table_with( "center", body_name( elements.center ),
                                  "periapsis_altitude_km", elements.periapsis_altitude_km,
                                  "apoapsis_altitude_km", elements.apoapsis_altitude_km,
                                  "inclination_deg", elements.inclination_deg,
                                  "ascending_node_deg", elements.ascending_node_deg,
                                  "argument_of_periapsis_deg", elements.argument_of_periapsis_deg,
                                  "mean_anomaly_deg", elements.mean_anomaly_deg, "epoch_s", elements.epoch_s );
}
} // namespace

void install_space_models_api( sol::table &services, const std::function<void()> &require_read )
{
    sol::state_view lua( services.lua_state() );
    sol::table space = lua.create_table();
    space.set_function( "propagate", [require_read]( sol::this_state ls, const sol::table &elements,
    double time_s ) {
        require_read();
        const orbital_state result = propagate( read_orbit( elements ), time_s );
        sol::table snapshot = state_snapshot( sol::state_view( ls ), result.motion );
        snapshot["altitude_km"] = result.altitude_km;
        snapshot["period_s"] = result.period_s;
        return snapshot;
    } );
    space.set_function( "moon_ephemeris", [require_read]( sol::this_state ls, double time_s ) {
        require_read();
        return state_snapshot( sol::state_view( ls ), moon_ephemeris( time_s ) );
    } );
    space.set_function( "recenter", [require_read]( sol::this_state ls, const sol::table &target,
    const std::string &center ) {
        require_read();
        return state_snapshot( sol::state_view( ls ), recenter( read_state( target ), read_body( center ) ) );
    } );
    space.set_function( "plan_lunar_transfer", [require_read]( sol::this_state ls, double departure_s,
    double earth_parking_altitude_km, double lunar_parking_altitude_km ) {
        require_read();
        const lunar_transfer plan = plan_lunar_transfer( departure_s, earth_parking_altitude_km,
                                    lunar_parking_altitude_km );
        sol::state_view vm( ls );
        return vm.create_table_with( "earth_leg", orbit_snapshot( vm, plan.earth_leg ),
                                    "departure_s", plan.earth_leg.epoch_s,
                                    "lunar_entry_s", plan.lunar_entry_s,
                                    "lunar_encounter_s", plan.lunar_encounter_s,
                                    "departure_delta_v_km_s", plan.departure_delta_v_km_s,
                                    "capture_delta_v_km_s", plan.capture_delta_v_km_s,
                                    "total_delta_v_km_s", plan.departure_delta_v_km_s + plan.capture_delta_v_km_s,
                                    "required_parking_state", state_snapshot( vm, plan.required_parking_state ),
                                    "lunar_entry", state_snapshot( vm, plan.lunar_entry ) );
    } );
    space.set_function( "observe", [require_read]( sol::this_state ls, const sol::table &target,
    const sol::table &site, sol::optional<double> minimum_elevation_deg ) {
        require_read();
        const observation result = observe( read_state( target ), read_observer( site ),
                                            minimum_elevation_deg.value_or( 0.0 ) );
        return sol::state_view( ls ).create_table_with( "azimuth_deg", result.azimuth_deg,
                "elevation_deg", result.elevation_deg, "distance_km", result.distance_km,
                "range_rate_km_s", result.range_rate_km_s, "visible", result.visible );
    } );
    space.set_function( "next_pass", [require_read]( sol::this_state ls, const sol::table &elements,
    const sol::table &site, double begin_s, double end_s,
    sol::optional<double> minimum_elevation_deg ) -> sol::object {
        require_read();
        const auto result = next_pass( read_orbit( elements ), read_observer( site ), begin_s,
                                       end_s, minimum_elevation_deg.value_or( 0.0 ) );
        sol::state_view vm( ls );
        if( !result ) {
            return sol::make_object( vm, sol::lua_nil );
        }
        return sol::make_object( vm, vm.create_table_with( "rise_s", result->rise_s,
                                 "peak_s", result->peak_s, "set_s", result->set_s,
                                 "peak_elevation_deg", result->peak_elevation_deg,
                                 "clipped_at_start", result->clipped_at_start,
                                 "clipped_at_end", result->clipped_at_end ) );
    } );
    space.set_function( "line_of_sight", [require_read]( sol::this_state ls, const sol::table &from,
    const sol::table &to ) {
        require_read();
        const sightline result = line_of_sight( read_state( from ), read_state( to ) );
        return sol::state_view( ls ).create_table_with( "earth_blocked", result.earth_blocked,
                "moon_blocked", result.moon_blocked, "visible", !result.earth_blocked && !result.moon_blocked,
                "distance_km", result.distance_km, "light_time_s", result.light_time_s );
    } );
    space.set_function( "sunlit", [require_read]( const sol::table &target, const sol::table &direction ) {
        require_read();
        return sunlit( read_state( target ), read_vector( direction ) );
    } );
    space.set_function( "radiation", [require_read]( sol::this_state ls, const sol::table &target,
    const sol::optional<sol::table> &options ) {
        require_read();
        const radiation_sample result = radiation( read_state( target ),
                                        options ? number_or( *options, "shield_g_cm2" ) : 0.0,
                                        options ? number_or( *options, "solar_event_strength" ) : 0.0,
                                        options ? number_or( *options, "duration_s" ) : 0.0 );
        return sol::state_view( ls ).create_table_with( "galactic_msv_h", result.galactic_msv_h,
                "trapped_msv_h", result.trapped_msv_h, "solar_msv_h", result.solar_msv_h,
                "total_msv_h", result.total_msv_h, "dose_msv", result.dose_msv );
    } );
    services["space"] = std::move( space );
}
} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
