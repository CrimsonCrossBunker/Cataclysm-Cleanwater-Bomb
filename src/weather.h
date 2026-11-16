#pragma once
#ifndef CATA_SRC_WEATHER_H
#define CATA_SRC_WEATHER_H

#include <optional>
#include <string>
#include <string_view>

#include "calendar.h"
#include "catacharset.h"
#include "color.h"
#include "coordinates.h"
#include "regional_climate.h"
#include "pimpl.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"
#include "weather_gen.h"
#include "weather_type.h"

class JsonObject;
class JsonOut;
class translation;

/**
 * @name BODYTEMP
 * Body temperature.
 * Most values can be changed with no impact on calculations.
 * Maximum heat cannot pass 57 C (the player will die of heatstroke)
 */
///@{
//!< More aggressive cold effects.
constexpr units::temperature BODYTEMP_FREEZING = 28_C;
//!< This value means frostbite occurs at the warmest temperature of 1C. If changed, the temp_conv calculation should be reexamined.
constexpr units::temperature BODYTEMP_VERY_COLD = 31_C;
//!< Frostbite timer will not improve while below this point.
constexpr units::temperature BODYTEMP_COLD = 34_C;
//!< Normal body temperature.
constexpr units::temperature BODYTEMP_NORM = 37_C;
//!< Level 1 hotness.
constexpr units::temperature BODYTEMP_HOT = 40_C;
//!< Level 2 hotness.
constexpr units::temperature BODYTEMP_VERY_HOT = 43_C;
//!< Level 3 hotness.
constexpr units::temperature BODYTEMP_SCORCHING = 46_C;

//!< Additional Threshold before speed is impacted by heat.
constexpr units::temperature_delta BODYTEMP_THRESHOLD = 1_C_delta;
///@}

// Wetness percentage 0.0f is DRY
// Level 1 wetness (DAMP) is between 0.0f and Level 2
// Level 2 wetness percentage
constexpr float BODYWET_PERCENT_WET = 0.3f;
// Level 3 wetness percentage
constexpr float BODYWET_PERCENT_SOAKED = 0.6f;

// Rough tresholds for sunlight intensity in W/m2.
namespace irradiance
{
// Sun at 5° on a clear day. Minimal for what is considered direct sunlight
constexpr float minimal = 87;

// Sun at 25° on a clear day.
constexpr float low = 422;

// Sun at 35° on a clear day.
constexpr float moderate = 573;

// Sun at 45° on a clear day.
constexpr float high = 707;

// Sun at 60° on a clear day.
constexpr float very_high = 866;

// Sun at 65° on a clear day.
constexpr float extreme = 906;
} // namespace irradiance

#include <cstdint>
#include <unordered_map>
#include <utility>
#include <vector>

class Character;
class Creature;
class item;
struct rl_vec2d;
struct trap;

double precip_mm_per_hour( precip_class p );
void handle_weather_effects( const weather_type_id &w );

/**
 * Weather drawing tracking.
 * Used for redrawing the view coordinates overwritten by the previous frame's animation bits (raindrops, snowflakes, etc,) and to draw this frame's weather animation.
 * @see game::get_player_input
 */
struct weather_printable {
    //!< Weather type in use.
    weather_type_id wtype;
    //!< Coordinates targeted for droplets.
    std::vector<std::pair<int, int> > vdrops;
    //!< Color to draw glyph this animation frame.
    nc_color colGlyph;
    //!< Glyph to draw this animation frame.
    uint32_t cGlyph;
    std::string get_symbol() const {
        return utf32_to_utf8( cGlyph );
    }
};

struct weather_sum {
    double rain_amount = 0;
    float sunlight = 0.0f;
    float radiant_exposure = 0.0f; // J/m2
    int wind_amount = 0;
};
bool is_creature_outside( const Creature &target );
bool can_creature_see_sky( const Creature &target );
void wet_character( Character &target, int amount );
weather_type_id get_bad_weather();
std::string get_shortdirstring( int angle );

std::string get_dirstring( int angle );

std::string weather_forecast( const point_abs_sm &abs_sm_pos );

// Returns input value (in Fahrenheit) converted to whatever temperature scale set in options.
//
// If scale is Celsius:    temperature(100) will return "37C"
// If scale is Fahrenheit: temperature(100) will return "100F"
//
// Use the decimals parameter to set number of decimal places returned in string.
std::string print_temperature( units::temperature temperature, int decimals = 0 );
std::string print_humidity( double humidity, int decimals = 0 );
std::string print_pressure( double pressure, int decimals = 0 );

// Returns temperature delta caused by windchill at given temperature, humidity and wind
units::temperature_delta get_local_windchill( units::temperature temperature, double humidity,
        double wind_mph );

int get_local_humidity( double humidity, const weather_type_id &weather, bool sheltered = false );

// Returns windspeed (mph) after being modified by local cover
int get_local_windpower( int windpower, const oter_id &omter, const tripoint_abs_ms &location,
                         const int &winddirection,
                         bool sheltered = false );
weather_sum sum_conditions( const time_point &start,
                            const time_point &end,
                            const tripoint_abs_ms &location );

/**
 * @param it The container item which is to be filled.
 * @param pos The absolute position of the funnel (in the map square system, the one used
 * by the @ref map, but absolute).
 * @param tr The funnel (trap which acts as a funnel).
 */
void retroactively_fill_from_funnel( item &it, const trap &tr, const time_point &start,
                                     const time_point &end, const tripoint_abs_ms &pos );

double funnel_charges_per_turn( double surface_area_mm2, double rain_depth_mm_per_hour );

rl_vec2d convert_wind_to_coord( int angle );

std::string get_wind_arrow( int );

std::string get_wind_desc( double );

nc_color get_wind_color( double );

/**
 * Is it warm enough to plant seeds? Will it be warm enough during the type's grow periods?
 * Also includes check for whether the tile is exposed to sunlight.
 */
ret_val<void> warm_enough_to_plant( const tripoint_bub_ms &pos, const itype_id &it );

bool is_wind_blocker( const tripoint_bub_ms &location );

weather_type_id current_weather( const tripoint_abs_ms &location,
                                 const time_point &t = calendar::turn );

void glare( const weather_type_id &w );
/**
 * Amount of sunlight incident at the ground, taking weather and time of day
 * into account.
 */
float incident_sunlight( const weather_type_id &wtype,
                         const time_point &t = calendar::turn );
// Apply weather and time of day to the moonlight.
float incident_moonlight( const weather_type_id &wtype,
                          const time_point &t = calendar::turn );

/* Amount of irradiance (W/m2) at ground after weather modifications */
float incident_sun_irradiance( const weather_type_id &wtype,
                               const time_point &t = calendar::turn );

void weather_sound( const translation &sound_message, std::string_view sound_effect );

struct omt_snow_state {
    double depth_mm = 0;
    time_point last_update = calendar::turn;
    double water_mm = -1;
};

class map;

enum class snow_cover : uint8_t {
    none,
    light,
    medium,
    deep
};

tripoint_abs_omt snow_climate_cell( const tripoint_abs_omt &location );
snow_cover classify_snow( double depth_mm );
int snow_move_penalty( snow_cover cover );
double indoor_heat_retention( double wall_loss, int openings, double wind_mph );
void advance_snowpack( omt_snow_state &pack, double water_rate, double temperature_c,
                       double humidity, double wind_mph, double hours );

class weather_manager
{
    public:
        weather_manager();
        // sets weather_override
        void on_game_start();
        const weather_generator &get_cur_weather_gen() const;
        // Updates the temperature and weather patten
        void update_solar_location();
        void update_weather();
        // Incrementally update snow depth at the player's current OMT
        void update_snow_depth();
        // Snow depth in mm at a given OMT (0 if no data)
        double get_snow_depth_mm( const tripoint_abs_omt &omt_pos ) const;
        snow_cover get_snow_cover( const map &here, const tripoint_bub_ms &position ) const;
        snow_cover get_surface_snow_cover( const map &here, const tripoint_bub_ms &position ) const;
        // The air temperature
        units::temperature temperature = 0_K;
        bool lightning_active = false;
        // Weather pattern
        weather_type_id weather_id = WEATHER_NULL;
        int winddirection = 0;
        int windspeed = 0;
        // whether the last update_weather() resulted in `weather_id` changing
        bool weather_changed = false;

        // For debug menu option "Force temperature"
        std::optional<units::temperature> forced_temperature;
        // Cached weather data
        pimpl<w_point> weather_precise;
        // World-level anchor shared by dimensions. Terrain is still procedurally generated.
        std::optional<point_abs_ms> climate_origin;
        std::optional<double> climate_precipitation_mm_per_hour;
        std::optional<int> wind_direction_override;
        std::optional<int> windspeed_override;
        weather_type_id weather_override;
        // not only sets nextweather, but updates weather as well
        void set_nextweather( time_point t );
        // The time at which weather will shift next.
        time_point nextweather;
        /** temperature cache, cleared every turn, sparse map of map tripoints to temperatures */
        std::unordered_map< tripoint_bub_ms, units::temperature > temperature_cache;
        mutable std::unordered_map<tripoint_abs_omt, units::temperature> ground_temperature_cache;
        // Per-OMT snow depth state, updated incrementally
        mutable std::unordered_map< tripoint_abs_omt, omt_snow_state > snow_depth_map;
        /*
        * Returns current temperature of given tile. Includes temperature modifications from
        * radiative and convective sources, such as fires or hot air from heaters.
        */
        units::temperature get_temperature( const tripoint_bub_ms &location );
        // Coarse regional outdoor samples for aging items over long absences.
        units::temperature get_historical_temperature( const tripoint_abs_ms &location,
                time_point when );
        /*
        * Returns temperature of given OMT. Does not include any modifications from local sourecs,
        * this is essentially the "natural" temperature.
        */
        units::temperature get_area_temperature( const tripoint_abs_omt &location ) const;
        void clear_temp_cache();
        static void serialize_all( JsonOut &json );
        static void unserialize_all( const JsonObject &w );

    private:
        struct room_heat {
            double excess = 0;
            double equilibrium = 0;
            double time_constant = 1;
        };
        struct room_heat_layer {
            tripoint_abs_ms origin;
            time_point sampled_at;
            std::unordered_map<tripoint_abs_ms, std::size_t> assignments;
            std::vector<room_heat> rooms;
        };
        std::unordered_map<int, room_heat_layer> heated_rooms;
        std::optional<dimension_id> heat_dimension;
        units::temperature_delta get_room_heat( const map &here, const tripoint_bub_ms &location,
                                                const tripoint_bub_ms &player );

        struct historical_weather_cell {
            std::optional<regional_climate::normals> normals;
            std::unordered_map<int, units::temperature> samples;
        };
        std::unordered_map<tripoint_abs_omt, historical_weather_cell> historical_weather;
        std::optional<dimension_id> historical_weather_dimension;

        std::optional<time_point> last_weather_turn;
        std::optional<time_point> indoor_reference_time;
        units::temperature indoor_reference_temperature;
};

weather_manager &get_weather();
const weather_manager &get_weather_const();

#endif // CATA_SRC_WEATHER_H
