#include "plant_climate.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <functional>
#include <iterator>
#include <memory>
#include <numeric>
#include <set>
#include <string>
#include <tuple>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include "calendar.h"
#include "cata_path.h"
#include "cata_utility.h"
#include "climate_seasons.h"
#include "coordinates.h"
#include "farming.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "iexamine.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "north_america.h"
#include "north_america_elevation.h"
#include "north_america_soil.h"
#include "omdata.h"
#include "options.h"
#include "overmap_ui.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "point.h"
#include "regional_climate.h"
#include "type_id.h"
#include "units.h"
#include "value_ptr.h"
#include "weather.h"
#include "weather_gen.h"
#include "weather_type.h"

crop_climate_profile crop_climate_profile::load( const JsonObject &jo )
{
    const crop_climate_profile result{
        jo.get_float( "base_c" ), jo.get_float( "optimum_c" ),
        jo.get_float( "min_c" ), jo.get_float( "max_c" ),
        jo.get_float( "degree_days" ), jo.get_float( "water_mm" ), jo.get_int( "growing_days" ),
        jo.get_float( "water_peak", 0.5 ), jo.get_int( "vernalization_days", 0 ),
        jo.get_float( "root_zone_water_mm", 0.0 ), jo.get_float( "harvest_yield_g_per_m2", 0.0 )
    };
    if( result.min_c > result.base_c || result.base_c >= result.optimum_c ||
        result.optimum_c >= result.max_c || result.degree_days <= 0 ||
        result.water_mm <= 0 || result.growing_days <= 0 ||
        result.water_peak < 0 || result.water_peak > 1 || result.vernalization_days < 0 ||
        result.root_zone_water_mm < 0 || result.harvest_yield_g_per_m2 < 0 ) {
        jo.throw_error( "Invalid crop climate profile" );
    }
    return result;
}

double crop_climate_profile::heat_units( double low, double high ) const
{
    if( low < min_c || high > max_c ) {
        return 0;
    }
    // Growth saturates at the optimum. Excess heat within the viable
    // range suppresses growth as the daytime high approaches the limit.
    const double mean = std::min( ( low + high ) / 2, optimum_c );
    const double heat_stress = 1 - std::max( 0.0, high - optimum_c ) / ( max_c - optimum_c );
    return std::max( 0.0, mean - base_c ) * heat_stress;
}

std::optional<time_point> field_crop::sowing_date( time_point when ) const
{
    constexpr int calendar_days = regional_climate::model_year_days;
    const time_duration year = calendar::year_length();
    const auto day_offset = [year]( int day ) {
        return time_duration::from_turns( std::lround(
                                              to_turns<double>( year ) * day / calendar_days ) );
    };
    time_point harvest_year = when - time_past_new_year( when );
    if( when >= harvest_year + day_offset( harvest_day + 1 ) ) {
        harvest_year += year;
    }
    const time_point planted = harvest_year + year * planting_year_offset + day_offset( planting_day );
    return planted <= when ? std::optional<time_point>( planted ) : std::nullopt;
}

namespace
{
struct weighted_crop {
    field_crop crop;
    unsigned weight;
};

const itype_id itype_seed_wheat( "seed_wheat" );
const itype_id itype_seed_red_winter_wheat( "seed_red_winter_wheat" );

std::unordered_map<point_abs_omt, point_abs_omt> field_origins;
std::unordered_map<point_abs_omt, std::optional<field_crop>> field_crops;

bool is_crop_field( point_abs_omt field )
{
    const oter_id &terrain = overmap_buffer.ter_existing( tripoint_abs_omt( field, 0 ) );
    return terrain && terrain->get_travel_cost_type() == oter_travel_cost_type::crop_field;
}

point_abs_omt field_origin( point_abs_omt field )
{
    if( const auto known = field_origins.find( field ); known != field_origins.end() ) {
        return known->second;
    }
    if( !is_crop_field( field ) ) {
        return field;
    }
    // Farmland specials stay within an overmap. Roads and other terrain separate parcels.
    const auto region = project_to<coords::om>( field );
    const auto special = overmap_buffer.overmap_special_at( tripoint_abs_omt( field, 0 ) );
    std::vector<point_abs_omt> parcel{ field };
    std::unordered_set<point_abs_omt> seen{ field };
    point_abs_omt origin = field;
    for( std::size_t i = 0; i < parcel.size(); ++i ) {
        for( const point &step : four_cardinal_directions ) {
            const point_abs_omt next = parcel[i] + step;
            if( project_to<coords::om>( next ) == region && seen.insert( next ).second &&
                is_crop_field( next ) &&
                overmap_buffer.overmap_special_at( tripoint_abs_omt( next, 0 ) ) == special ) {
                parcel.push_back( next );
                origin = std::min( origin, next );
            }
        }
    }
    for( const point_abs_omt &member : parcel ) {
        field_origins.emplace( member, origin );
    }
    return origin;
}

std::size_t field_hash( point_abs_omt field )
{
    return std::hash<point_abs_omt>{}( field ) ^ g->get_seed();
}

int crop_calendar_day( const JsonValue &value )
{
    static constexpr std::array<int, 12> month_lengths{{
            31, 28, 31, 30, 31, 30,
            31, 31, 30, 31, 30, 31
        }};
    const int encoded = value.get_int();
    const int month = encoded / 100;
    const int day = encoded % 100;
    if( month < 1 || month > 12 || day < 1 || day > month_lengths[month - 1] ) {
        value.throw_error( "Expected a planting or harvest date in MMDD form" );
    }
    const int quarter = ( month - 1 ) / 3;
    const int within_quarter = ( month - 1 ) % 3;
    constexpr std::array<int, 3> month_start = { 0, 31, 61 };
    return quarter * 91 + month_start[within_quarter] +
           std::min( day, within_quarter == 0 ? 31 : 30 ) - 1;
}
const std::vector<weighted_crop> &regional_field_options( point_abs_omt field )
{
    static const auto profiles = [] {
        std::unordered_map<std::string, std::vector<weighted_crop>> result;
        read_from_file_json( PATH_INFO::datadir_path() / "raw" / "north_america_field_crops.json",
                             [&]( const JsonValue & data )
        {
            const JsonObject root = data.get_object();
            root.allow_omitted_members();
            for( const JsonMember entry : root.get_object( "regions" ) ) {
                std::vector<weighted_crop> &options = result[entry.name()];
                for( const JsonValue row : entry.get_array() ) {
                    const JsonArray values = row.get_array();
                    const int weight = values.get_int( 1 );
                    if( weight <= 0 || weight > 100 ) {
                        row.throw_error( "Field crop weights must be between 1 and 100" );
                    }
                    const int planting = crop_calendar_day( values[2] );
                    const int harvest = crop_calendar_day( values[3] );
                    const int default_offset = planting > harvest ? -1 : 0;
                    const int year_offset = values.size() > 4 ?
                                            values.get_object( 4 ).get_int( "planting_year_offset" ) : default_offset;
                    if( year_offset != default_offset ) {
                        row.throw_error( "Field planting year must match the planting and harvest dates" );
                    }
                    options.push_back( {
                        {
                            itype_id( values.get_string( 0 ) ), planting, harvest, year_offset
                        },
                        static_cast<unsigned>( weight )
                    } );
                }
            }
        } );
        return result;
    }();
    const point_abs_ms center = project_to<coords::ms>( field ) + point( SEEX, SEEY );
    const auto options = profiles.find( std::string( north_america::jurisdiction_at( center ) ) );
    static const std::vector<weighted_crop> empty;
    return options == profiles.end() ? empty : options->second;
}

std::optional<field_crop> weighted_field_crop( const std::vector<weighted_crop> &options,
        point_abs_omt field )
{
    const unsigned total = std::accumulate( options.begin(), options.end(), 0u,
    []( unsigned sum, const weighted_crop &choice ) {
        return sum + choice.weight;
    } );
    if( total == 0 ) {
        return std::nullopt;
    }
    unsigned roll = static_cast<unsigned>( field_hash( field ) % total );
    for( const weighted_crop &choice : options ) {
        if( roll < choice.weight ) {
            return choice.crop;
        }
        roll -= choice.weight;
    }
    return std::nullopt;
}
} // namespace

std::optional<field_crop> regional_field_crop( point_abs_omt field,
        const itype_id &existing_seed )
{
    const point_abs_omt origin = existing_seed.is_null() ? field_origin( field ) : field;
    const auto &options = regional_field_options( origin );
    if( !existing_seed.is_null() ) {
        const weighted_crop *matching = nullptr;
        const weighted_crop *winter_wheat = nullptr;
        for( const weighted_crop &choice : options ) {
            if( choice.crop.seed == existing_seed ) {
                matching = &choice;
            }
            if( choice.crop.seed == itype_seed_red_winter_wheat ) {
                winter_wheat = &choice;
            }
        }
        if( existing_seed == itype_seed_wheat && winter_wheat &&
            ( !matching || field_hash( origin ) % ( matching->weight + winter_wheat->weight ) <
              winter_wheat->weight ) ) {
            return winter_wheat->crop;
        }
        if( matching ) {
            return matching->crop;
        }
        if( existing_seed.is_valid() && existing_seed->seed && existing_seed->seed->climate ) {
            const crop_climate_profile &climate = *existing_seed->seed->climate;
            if( climate.vernalization_days > 0 ) {
                return field_crop{ existing_seed, 273, 211, -1 };
            }
            return field_crop{ existing_seed, climate.base_c >= 8 ? 125 : 105, 303, 0 };
        }
        return std::nullopt;
    }
    if( const auto known = field_crops.find( origin ); known != field_crops.end() ) {
        return known->second;
    }
    std::vector<weighted_crop> in_season;
    std::copy_if( options.begin(), options.end(), std::back_inserter( in_season ),
    [&]( const weighted_crop &choice ) {
        return choice.crop.seed.is_valid() && choice.crop.seed->seed &&
               regional_field_sowing( choice.crop, origin, calendar::start_of_cataclysm );
    } );
    if( options.empty() && is_crop_field( field ) ) {
        const auto wheat = regional_field_crop( origin, itype_seed_wheat );
        if( wheat && regional_field_sowing( *wheat, origin, calendar::start_of_cataclysm ) ) {
            in_season.push_back( { *wheat, 1 } );
        }
    }
    return field_crops.emplace( origin, weighted_field_crop( in_season, origin ) ).first->second;
}

fruit_climate_profile fruit_climate_profile::load( const JsonObject &jo )
{
    fruit_climate_profile result{
        crop_climate_profile::load( jo.get_object( "growth" ) ),
        harvest_id( jo.get_string( "harvest" ) ), jo.get_int( "bearing_days" )
    };
    if( result.bearing_days < 1 || result.bearing_days > 90 ) {
        jo.get_member( "bearing_days" ).throw_error( "Invalid fruit bearing period" );
    }
    return result;
}

namespace
{
constexpr int model_days = regional_climate::model_year_days;
constexpr double charge_mm = 0.25; // A 250 mL water charge spread over a 1 m² tile.

struct crop_day {
    double low;
    double high;
    std::array<double, 24> rain;
    double reference_et_mm = 0;
};

double reference_evapotranspiration( double latitude, time_point date, double low, double high )
{
    constexpr double pi = 3.14159265358979323846;
    const double day = 365.0 * ( time_past_new_year( date ) / calendar::year_length() ) + 1;
    const double angle = 2 * pi * day / 365;
    const double phi = std::clamp( latitude, -89.9, 89.9 ) * pi / 180;
    const double declination = 0.409 * std::sin( angle - 1.39 );
    const double sunset = std::acos( std::clamp( -std::tan( phi ) * std::tan( declination ), -1.0, 1.0 ) );
    const double radiation = 24 * 60 / pi * 0.0820 * ( 1 + 0.033 * std::cos( angle ) ) *
                             ( sunset * std::sin( phi ) * std::sin( declination ) +
                               std::cos( phi ) * std::cos( declination ) * std::sin( sunset ) );
    // FAO-56 Hargreaves: radiation in MJ/m²/day becomes equivalent evaporation in mm/day.
    return std::max( 0.0, 0.0023 * ( ( low + high ) / 2 + 17.8 ) *
                     std::sqrt( std::max( 0.0, high - low ) ) * 0.408 * radiation );
}

struct crop_weather_cell {
    std::optional<regional_climate::normals> normals;
    std::unordered_map<int, crop_day> days;
    std::unordered_map<int, crop_day> field_history;
    std::unordered_map<harvest_id, std::optional<int>> ripening;
};

std::unordered_map<tripoint_abs_omt, crop_weather_cell> cells;

crop_weather_cell &cell_at( const tripoint_abs_omt &cell, const weather_generator &generator )
{
    const weather_manager &weather = get_weather_const();
    const auto current = std::make_tuple( g->get_seed(), &generator, calendar::year_length(),
                                          get_option<std::string>( "ETERNAL_WEATHER" ), weather.weather_override,
                                          weather.forced_temperature, weather.climate_origin,
                                          north_america::active() );
    static auto previous = current;
    if( previous != current ) {
        cells.clear();
        previous = current;
    }
    const auto found = cells.find( cell );
    if( found != cells.end() ) {
        return found->second;
    }
    if( cells.size() >= 32 ) {
        cells.clear();
    }
    crop_weather_cell &sample = cells[cell];
    const tripoint_abs_ms center = project_to<coords::ms>( cell ) + point( 384, 384 );
    sample.normals = north_america::active() ?
                     regional_climate::at( north_america::location( center.xy() ),
                                           north_america::elevation_active() ) :
                     generator.climate_at( center );
    return sample;
}

time_duration crop_time_of_day( time_point when )
{
    return time_past_midnight( when );
}

const crop_day &sample_day( const tripoint_abs_ms &pos, time_point date,
                            bool field_history = false )
{
    const weather_manager &weather = get_weather_const();
    const weather_generator &generator = weather.get_cur_weather_gen();
    const tripoint_abs_omt cell = snow_climate_cell( project_to<coords::omt>( pos ) );
    crop_weather_cell &cached = cell_at( cell, generator );
    const time_point start = date - crop_time_of_day( date );
    const int day = to_days<int>( start - calendar::turn_zero );
    auto &days = field_history ? cached.field_history : cached.days;
    const auto found = days.find( day );
    if( found != days.end() ) {
        return found->second;
    }
    if( days.size() >= 768 ) {
        days.clear();
    }
    const tripoint_abs_ms location = project_to<coords::ms>( cell ) + point( 384, 384 );
    const std::string eternal = get_option<std::string>( "ETERNAL_WEATHER" );
    const weather_type_id forced = field_history ? WEATHER_NULL :
                                   eternal == "normal" ? weather.weather_override : weather_type_id( eternal );
    const auto &normals = cached.normals;
    // Historical fields use the same regional rain events as live weather, without debug overrides.
    crop_day result{ 100, -100, {} };
    for( int hour = 0; hour < 24; ++hour ) {
        const w_point sample = generator.get_weather( location, start + hour * 1_hours, g->get_seed(),
                               false, &normals );
        const double c = units::to_celsius( field_history ? sample.temperature :
                                            weather.forced_temperature.value_or( sample.temperature ) );
        result.low = std::min( result.low, c );
        result.high = std::max( result.high, c );
        if( c > 1 ) {
            if( forced == WEATHER_NULL && sample.climate_precipitation_mm_per_hour ) {
                result.rain[hour] = *sample.climate_precipitation_mm_per_hour;
                continue;
            }
            const weather_type_id type = forced == WEATHER_NULL ? generator.get_weather_conditions( sample ) :
                                         forced;
            if( type->rains ) {
                result.rain[hour] = precip_mm_per_hour( type->precip );
            }
        }
    }
    const auto geographic = north_america::active() ?
                            std::optional<regional_climate::coordinates>( north_america::location( location.xy() ) ) :
                            generator.climate_location( location );
    result.reference_et_mm = reference_evapotranspiration(
                                 geographic ? geographic->latitude : 42.0, start, result.low, result.high );
    return days.emplace( day, result ).first->second;
}

double crop_rain_for_interval( const crop_day &day, time_duration elapsed, time_duration duration )
{
    if( duration == 1_days ) {
        return std::accumulate( day.rain.begin(), day.rain.end(), 0.0 );
    }
    double rain = 0;
    const time_duration end = elapsed + duration;
    while( elapsed < end ) {
        const time_duration step = std::min( end - elapsed, 1_hours - elapsed % 1_hours );
        rain += day.rain[to_hours<int>( elapsed )] * to_hours<double>( step );
        elapsed += step;
    }
    return rain;
}

north_america::crop_soil_properties crop_soil( const map &here, const tripoint_bub_ms &p,
        const furn_t &furniture )
{
    const plant_data *plant = furniture.plant.get();
    std::set<const plant_data *> visited;
    while( plant && visited.insert( plant ).second ) {
        if( plant->soil_source == "substrate" ) {
            return {};
        }
        if( plant->soil_source == "terrain" || plant->base.is_null() || !plant->base.is_valid() ) {
            break;
        }
        plant = plant->base->plant.get();
    }
    return north_america::crop_soil_at( here.ter( p ) );
}

double effective_crop_turns( const item &seed )
{
    return iexamine::get_plant_effective_growth_turns( seed ) +
           seed.get_var( "crop_growth_fraction", 0.0 );
}

double crop_water_need( const item &seed, const furn_t &furniture, double stage,
                        double water_use, double reference_et )
{
    const crop_climate_profile &climate = *seed.type->seed->climate;
    return climate.water_mm / climate.growing_days * model_days /
           to_days<double>( calendar::year_length() ) * water_use *
           iexamine::get_plant_water_consumption_multiplier( furniture ) * reference_et / 4.0 *
           ( 1.25 - 0.6 * std::abs( std::clamp( stage, 0.0, 1.0 ) - climate.water_peak ) );
}

double crop_base_water_capacity( const crop_climate_profile &climate )
{
    return climate.root_zone_water_mm > 0 ? climate.root_zone_water_mm :
           std::max( 40.0, climate.water_mm / climate.growing_days * 20 );
}

bool winter_crop_dormant( const crop_climate_profile &climate, double mean_c )
{
    return climate.vernalization_days > 0 && mean_c <= std::max( 4.0, climate.base_c );
}

double crop_temperature_offset( const map &here, const tripoint_bub_ms &p, bool sheltered )
{
    if( sheltered && &here == &get_map() ) {
        weather_manager &weather = get_weather();
        const auto ambient = weather.forced_temperature.value_or( weather.temperature );
        return units::to_celsius( weather.get_temperature( p ) ) - units::to_celsius( ambient );
    }
    return 0;
}

double crop_heat_fraction( const map &here, const tripoint_bub_ms &p,
                           const crop_climate_profile &climate, const crop_day &day, bool sheltered )
{
    const double offset = crop_temperature_offset( here, p, sheltered );
    const double mean = ( day.low + day.high ) / 2;
    const double restraint = sheltered ? ( day.high - day.low ) * 0.2 : 0;
    const double low = std::min( mean, day.low + restraint ) + offset;
    const double high = std::max( mean, day.high - restraint ) + offset;
    return climate.heat_units( low, high ) * model_days /
           to_days<double>( calendar::year_length() ) / climate.degree_days;
}

double vernalization_fraction( double low, double high )
{
    if( high <= low ) {
        return low >= -1 && low <= 10 ? 1.0 : 0.0;
    }
    return std::clamp( ( std::min( high, 10.0 ) - std::max( low, -1.0 ) ) /
                       ( high - low ), 0.0, 1.0 );
}
} // namespace

namespace
{
std::optional<time_point> field_sowing_at( const field_crop &crop, point_abs_omt field,
        time_point when )
{
    field_crop local = crop;
    // Stagger adjacent fields within the local planting window without varying within a field.
    const int planting_delay = static_cast<int>( ( field_hash( field ) >> 8 ) % 10 );
    if( crop.seed.is_valid() && crop.seed->seed && crop.seed->seed->climate &&
        crop.planting_year_offset == 0 && crop.planting_day < crop.harvest_day ) {
        const crop_climate_profile &growth = *crop.seed->seed->climate;
        const auto &normals = cell_at( snow_climate_cell( tripoint_abs_omt( field, 0 ) ),
                                      get_weather_const().get_cur_weather_gen() ).normals;
        const int latest = std::min( crop.harvest_day - 1, crop.planting_day + 35 );
        local.planting_day = std::min( latest, crop.planting_day + planting_delay );
        if( normals ) {
            const double minimum = std::max( 5.0, growth.base_c + 2.0 );
            for( int day = crop.planting_day; day <= latest; ++day ) {
                const auto temperature = regional_climate::temperature_for_day( *normals, day );
                if( temperature.mean_c >= minimum && temperature.mean_c - temperature.daily_range_c >=
                    std::max( growth.min_c, growth.base_c - 5 ) ) {
                    local.planting_day = std::min( latest, day + planting_delay );
                    return local.sowing_date( when );
                }
            }
            return std::nullopt;
        }
    } else if( crop.planting_year_offset < 0 ) {
        local.planting_day = std::min( crop.planting_day + planting_delay,
                                      regional_climate::model_year_days - 1 );
    }
    return local.sowing_date( when );
}
} // namespace

std::optional<time_point> regional_field_sowing( const field_crop &crop, point_abs_omt field,
        time_point when )
{
    return field_sowing_at( crop, field_origin( field ), when );
}

void repair_regional_field_crop( map &here, const tripoint_bub_ms &p, item &seed )
{
    const bool update_winter_wheat = seed.typeId() == itype_seed_red_winter_wheat &&
                                     !seed.has_var( "crop_winter_wheat_v2" );
    if( ( seed.has_var( "crop_field_history_v4" ) && !update_winter_wheat ) ||
        p.z() != 0 || !north_america::active() ||
        seed.has_flag( json_flag_HIDDEN_ITEM ) || !seed.type->seed->climate ) {
        return;
    }
    static const furn_str_id field_seed( "f_plant_seed" );
    static const furn_str_id field_seedling( "f_plant_seedling" );
    static const furn_str_id field_mature( "f_plant_mature" );
    static const furn_str_id field_harvest( "f_plant_harvest" );
    static const furn_str_id field_overgrown( "f_plant_unharvested_overgrown" );
    const furn_id furniture = here.furn( p );
    if( !furniture->plant || ( furniture != field_seed.id() && furniture != field_seedling.id() &&
                              furniture != field_mature.id() && furniture != field_harvest.id() &&
                              furniture != field_overgrown.id() ) ) {
        return;
    }
    const tripoint_abs_omt omt = project_to<coords::omt>( here.get_abs( p ) );
    if( !seed.has_var( "crop_field_sown" ) &&
        ( seed.birthday() > calendar::start_of_cataclysm ||
          overmap_buffer.ter_existing( omt )->get_travel_cost_type() != oter_travel_cost_type::crop_field ) ) {
        return;
    }
    seed.set_var( "crop_field_history_v4", true );
    if( update_winter_wheat ) {
        seed.set_var( "crop_winter_wheat_v2", true );
    }
    if( iexamine::is_plant_fertilized( seed ) || iexamine::get_plant_water( seed ) > 0 ) {
        return;
    }
    const auto crop = regional_field_crop( omt.xy(), seed.typeId() );
    if( !crop ) {
        return;
    }
    const auto sown = update_winter_wheat && seed.has_var( "crop_field_sown" ) ?
                      std::optional<time_point>( time_point::from_turn(
                                  static_cast<int>( seed.get_var( "crop_field_sown", 0.0 ) ) ) ) :
                      field_sowing_at( *crop, omt.xy(), calendar::start_of_cataclysm );
    if( !sown ) {
        return;
    }
    if( !update_winter_wheat && crop->seed == seed.typeId() && seed.has_var( "crop_field_sown" ) &&
        seed.get_var( "crop_field_sown", 0.0 ) == to_turn<int>( *sown ) ) {
        return;
    }

    // Reconstruct growth from the corrected date so the old season's heat and rain aren't reused.
    if( crop->seed != seed.typeId() ) {
        seed.convert( crop->seed );
    }
    if( crop->seed == itype_seed_red_winter_wheat ) {
        seed.set_var( "crop_winter_wheat_v2", true );
    }
    seed.set_birthday( std::max( *sown, calendar::turn_zero ) );
    seed.set_var( "crop_field_sown", to_turn<int>( *sown ) );
    seed.set_var( "crop_field_history_v3", true );
    iexamine::set_plant_last_water_check( seed, *sown );
    iexamine::set_plant_effective_growth_turns( seed, 0 );
    seed.erase_var( "crop_soil_moisture_mm" );
    seed.erase_var( "crop_thermal_growth" );
    seed.erase_var( "crop_growing_time" );
    seed.erase_var( "crop_vernalization_days" );
    seed.erase_var( "crop_sampled_rain_mm" );
    seed.erase_var( "crop_degree_days" );
    here.furn_set( p, field_seed );
}

void clear_plant_climate_cache()
{
    cells.clear();
    field_origins.clear();
    field_crops.clear();
}

bool is_primary_crop_seed( const item &value )
{
    return value.is_seed() && !value.has_var( "crop_relay_waiting" );
}

item *relay_crop_at( map &here, const tripoint_bub_ms &p )
{
    for( item &value : here.i_at( p ) ) {
        if( value.has_var( "crop_relay_waiting" ) && value.is_seed() ) {
            return &value;
        }
    }
    return nullptr;
}

bool relay_corn_has_planting_weather( const map &here, const tripoint_bub_ms &p )
{
    const tripoint_abs_ms pos = here.get_abs( p );
    const crop_day &today = sample_day( pos, calendar::turn );
    if( ( today.low + today.high ) / 2 < 10 || today.low < 4 ) {
        return false;
    }
    const crop_day &tomorrow = sample_day( pos, calendar::turn + 1_days );
    return ( tomorrow.low + tomorrow.high ) / 2 >= 10 && tomorrow.low >= 4;
}

void release_relay_crop( const map &here, const tripoint_bub_ms &p, item &seed,
                         double soil_water_mm )
{
    seed.erase_var( "crop_relay_waiting" );
    iexamine::set_plant_last_water_check( seed, calendar::turn );
    const islot_seed &slot = *seed.type->seed;
    if( !slot.climate || slot.get_harvest_stage_idx() <= 0 ) {
        return;
    }
    const auto &climate = *slot.climate;
    const auto &stages = slot.get_cumulative_stage_thresholds();
    const double emergence = to_turns<double>( stages.front() );
    const double maturity = to_turns<double>( stages[slot.get_harvest_stage_idx() - 1] );
    const double limit = emergence / maturity;
    const double per_model_day = model_days / to_days<double>( calendar::year_length() );
    const auto soil = north_america::crop_soil_at( here.ter( p ) );
    const double capacity = crop_base_water_capacity( climate ) * soil.water_capacity;
    double moisture = std::clamp( seed.get_var( "crop_relay_start_water_mm", soil_water_mm ),
                                  0.0, capacity );
    seed.erase_var( "crop_relay_start_water_mm" );
    const double water_use = std::max( 0.01f, get_option<float>( "CROP_WATER_CONSUMPTION" ) );
    const double growth_speed = get_option<float>( "CROP_GROWTH_SPEED" );
    double development = 0;
    const tripoint_abs_ms pos = here.get_abs( p );
    // A shaded understory can establish a seedling while the wheat finishes grain fill.
    const time_point start = is_crop_sheltered( here, p ) ? calendar::turn :
                             std::max( seed.birthday(), calendar::turn - 60_days );
    for( time_point cursor = start; cursor < calendar::turn && development < limit; ) {
        const time_duration elapsed = crop_time_of_day( cursor );
        const time_duration step = std::min( 1_days - elapsed, calendar::turn - cursor );
        const crop_day &day = sample_day( pos, cursor );
        const double days = to_days<double>( step ) * per_model_day;
        moisture = std::min( capacity, moisture +
                             crop_rain_for_interval( day, elapsed, step ) * soil.infiltration );
        const double demand = std::max( 0.0001, days * climate.water_mm / climate.growing_days *
                                       0.35 * water_use * day.reference_et_mm / 4.0 );
        const double water = std::min( moisture, demand );
        moisture -= water;
        development += 0.5 * days * ( water / demand ) * growth_speed * soil.root_growth *
                       std::min( climate.heat_units( day.low, day.high ) / climate.degree_days,
                                 1.0 / climate.growing_days );
        cursor += step;
    }
    development = std::min( limit, development );
    seed.set_var( "crop_thermal_growth", development );
    seed.set_var( "crop_growing_time", development );
    seed.set_var( "crop_soil_moisture_mm", std::clamp( soil_water_mm, 0.0, capacity ) );
    iexamine::set_plant_effective_growth_turns( seed, static_cast<int>( maturity * development ) );
}

crop_water_status get_crop_water_status( const map &here, const tripoint_bub_ms &p,
        const item &seed )
{
    const furn_t &furniture = here.furn( p ).obj();
    const islot_seed &slot = *seed.type->seed;
    const crop_climate_profile &climate = *slot.climate;
    const auto &thresholds = slot.get_cumulative_stage_thresholds();
    const double maturity = to_turns<double>( thresholds[slot.get_harvest_stage_idx() - 1] );
    const double capacity = crop_base_water_capacity( climate ) *
                            crop_soil( here, p, furniture ).water_capacity;
    const double moisture = std::clamp( seed.get_var( "crop_soil_moisture_mm", capacity * 0.65 ),
                                        0.0, capacity );
    const double irrigation = iexamine::get_plant_max_water( furniture ) > 0 ?
                              ( iexamine::get_plant_water( seed ) +
                                seed.get_var( "crop_irrigation_fraction", 0.0 ) ) * charge_mm : 0;
    const double day_fraction = model_days / to_days<double>( calendar::year_length() ) /
                                climate.growing_days;
    const crop_day &day = sample_day( here.get_abs( p ), calendar::turn );
    const bool sheltered = p.z() < 0 || here.is_roofed( p );
    const bool dormant = winter_crop_dormant( climate, ( day.low + day.high ) / 2 +
                         crop_temperature_offset( here, p, sheltered ) );
    return { moisture, capacity, irrigation,
             crop_water_need( seed, furniture, effective_crop_turns( seed ) / maturity,
                              get_option<float>( "CROP_WATER_CONSUMPTION" ), day.reference_et_mm ) *
             ( dormant ? 0.05 : 1.0 ),
             crop_heat_fraction( here, p, climate, day, sheltered ) < day_fraction, dormant };
}

double crop_harvest_multiplier( const item &seed )
{
    const double demand = seed.get_var( "crop_water_demand_mm", 0.0 );
    if( demand <= 0 ) {
        return 1;
    }
    const double supplied = seed.get_var( "crop_water_supplied_mm", demand );
    return std::clamp( 1.0 - 1.1 * ( 1.0 - supplied / demand ), 0.0, 1.0 );
}

int crop_harvest_count( const item &seed, int count )
{
    if( count <= 0 ) {
        return 0;
    }
    const islot_seed &slot = *seed.type->seed;
    if( slot.climate && slot.climate->harvest_yield_g_per_m2 > 0 ) {
        const item fruit( slot.fruit_id, calendar::turn );
        const double grams = static_cast<double>( units::to_gram( fruit.weight() ) );
        if( grams > 0 ) {
            count = std::max( 1, static_cast<int>( std::round( slot.climate->harvest_yield_g_per_m2 /
                                                   grams * get_option<float>( "CROP_HARVEST_MULTIPLIER" ) ) ) );
        }
    }
    // A harvestable standing crop retains a minimum primary yield; dead crops pass zero.
    return std::max( 1, static_cast<int>( std::round(
            count * crop_harvest_multiplier( seed ) ) ) );
}

time_duration update_crop_climate( const map &here, const tripoint_bub_ms &p, item &seed,
                                   const furn_t &furniture, float growth_speed, float water_use,
                                   bool finish_interval )
{
    const islot_seed &slot = *seed.type->seed;
    const crop_climate_profile &climate = *slot.climate;
    const auto &thresholds = slot.get_cumulative_stage_thresholds();
    const int harvest = slot.get_harvest_stage_idx();
    const time_duration maturity = thresholds[std::max( 0, harvest - 1 )];
    const int overgrown = iexamine::get_plant_overgrown_stage_idx( slot );
    const bool allow_overgrowth = get_option<bool>( "CROP_OVERGROWN_ENABLED" ) &&
                                  !furniture.has_flag( "NO_CROP_OVERGROWTH" );
    const int final_stage = !allow_overgrowth && overgrown > 0 ?
                            overgrown - 1 : static_cast<int>( thresholds.size() ) - 1;
    const double final_growth = to_turns<double>( thresholds[std::max( 0, final_stage - 1 )] );
    const double per_model_day = model_days / to_days<double>( calendar::year_length() );
    const bool covered = here.is_roofed( p ) || p.z() < 0;
    const furn_t *stage_furniture = &furniture;
    north_america::crop_soil_properties soil = crop_soil( here, p, furniture );
    const double base_capacity = crop_base_water_capacity( climate );
    double capacity = base_capacity * soil.water_capacity;
    double irrigation = iexamine::get_plant_max_water( furniture ) > 0 ?
                        ( iexamine::get_plant_water( seed ) +
                          seed.get_var( "crop_irrigation_fraction", 0.0 ) ) * charge_mm : 0;
    double moisture = std::clamp( seed.get_var( "crop_soil_moisture_mm", capacity * 0.65 ),
                                  0.0, capacity );
    time_point start = iexamine::get_plant_last_water_check( seed );
    const time_point history_end = calendar::start_of_game;
    const tripoint_abs_ms position = here.get_abs( p );
    const time_point sown = time_point::from_turn( static_cast<int>(
                                seed.get_var( "crop_field_sown", to_turn<int>( seed.birthday() ) ) ) );
    const bool field_crop = seed.has_var( "crop_field_sown" );
    const bool repair_history = !seed.has_var( "crop_field_history_v3" );
    if( !seed.has_var( "seed_last_water_check" ) || start < sown ) {
        start = sown;
    }
    const auto interval_end = [field_crop, history_end]( time_point from, time_point limit ) {
        return field_crop && from < history_end ? std::min( limit, history_end ) : limit;
    };

    double effective = effective_crop_turns( seed );
    int current_stage = iexamine::get_plant_current_stage_idx( here, p,
                        slot.get_growth_stages() );
    if( current_stage > 0 && current_stage <= static_cast<int>( thresholds.size() ) ) {
        effective = std::max( effective, to_turns<double>( thresholds[current_stage - 1] ) );
    }
    if( start > calendar::turn ) {
        return time_duration::from_turns( effective );
    }
    const time_point end = finish_interval ? calendar::turn :
                           calendar::turn - crop_time_of_day( calendar::turn ) % 1_hours;
    const double maturity_turns = to_turns<double>( maturity );
    const double day_fraction = per_model_day / climate.growing_days;
    double thermal_growth = seed.get_var( "crop_thermal_growth", effective / maturity_turns );
    double growing_time = seed.get_var( "crop_growing_time", effective / maturity_turns );
    double chill = seed.get_var( "crop_vernalization_days", 0.0 );
    double sampled_rain = seed.get_var( "crop_sampled_rain_mm", 0.0 );
    double degree_days = seed.get_var( "crop_degree_days", 0.0 );
    double water_demand = seed.get_var( "crop_water_demand_mm", 0.0 );
    double water_supplied = seed.get_var( "crop_water_supplied_mm", 0.0 );
    if( field_crop && repair_history ) {
        // Backfill an empty ledger in older saves.
        const auto backfill = [&]( bool rain, bool heat, bool cold, time_point recorded_until ) {
            for( time_point cursor = sown; cursor < recorded_until; ) {
                const time_duration elapsed = crop_time_of_day( cursor );
                const time_duration step = std::min( recorded_until - cursor, 1_days - elapsed );
                const crop_day &day = sample_day( position, cursor - elapsed, true );
                if( rain ) {
                    const double mm = crop_rain_for_interval( day, elapsed, step );
                    sampled_rain += mm;
                    moisture = std::min( capacity, moisture +
                                         mm * soil.infiltration * std::exp( -to_days<double>( start - cursor ) / 6.0 ) );
                }
                if( heat ) {
                    degree_days += crop_heat_fraction( here, p, climate, day, false ) *
                                   to_days<double>( step ) * climate.degree_days;
                }
                if( cold ) {
                    chill = std::min( static_cast<double>( climate.vernalization_days ),
                                      chill + to_days<double>( step ) * per_model_day *
                                      vernalization_fraction( day.low, day.high ) );
                }
                cursor += step;
            }
        };
        const bool missing_rain = sampled_rain <= 0;
        const bool missing_heat = degree_days <= 0;
        const time_point recorded_until = std::min( start, history_end );
        const bool missing_chill = climate.vernalization_days > 0 &&
                                   !seed.has_var( "crop_vernalization_days" ) && thermal_growth >= 0.025;
        if( missing_rain || missing_heat || missing_chill ) {
            backfill( missing_rain, missing_heat, missing_chill, recorded_until );
        }
        seed.set_var( "crop_field_history_v3", true );
    }
    time_point sampled_date = start - 1_days;
    bool sampled_history = false;
    double heat_fraction = 0;
    double daily_mean = 0;
    double daily_chill = 0;
    double daily_et = 0;
    std::array<double, 24> hourly_rain{};
    while( start < end && effective < final_growth ) {
        while( current_stage >= 0 && current_stage < final_stage &&
               effective >= to_turns<double>( thresholds[current_stage] ) &&
               stage_furniture->plant && !stage_furniture->plant->transform.is_null() ) {
            stage_furniture = &stage_furniture->plant->transform.obj();
            ++current_stage;
            soil = crop_soil( here, p, *stage_furniture );
            capacity = base_capacity * soil.water_capacity;
            moisture = std::min( moisture, capacity );
            irrigation = std::min( irrigation,
                                   iexamine::get_plant_max_water( *stage_furniture ) * charge_mm );
        }
        const bool historical = field_crop && start < history_end;
        const time_duration elapsed = crop_time_of_day( start );
        const time_duration step = std::min( interval_end( start, end ) - start,
                                             1_hours - elapsed % 1_hours );
        const double days = to_days<double>( step );
        const time_point date = start - elapsed;
        if( date != sampled_date || historical != sampled_history ) {
            const crop_day &day = sample_day( position, date, historical );
            heat_fraction = crop_heat_fraction( here, p, climate, day, covered && !historical );
            const double offset = crop_temperature_offset( here, p, covered && !historical );
            daily_mean = ( day.low + day.high ) / 2 + offset;
            daily_chill = vernalization_fraction( day.low + offset, day.high + offset );
            hourly_rain = day.rain;
            daily_et = day.reference_et_mm;
            sampled_date = date;
            sampled_history = historical;
        }
        const int hour = to_hours<int>( elapsed );
        const bool winter_crop = climate.vernalization_days > 0;
        const bool dormant = winter_crop_dormant( climate, daily_mean );
        if( winter_crop && thermal_growth >= 0.025 ) {
            chill = std::min( static_cast<double>( climate.vernalization_days ),
                              chill + days * per_model_day * daily_chill );
        }
        const double activity = dormant ? 0.05 : std::clamp( heat_fraction / day_fraction, 0.15, 1.0 );
        const double need = std::max( 0.000001,
                                     crop_water_need( seed, *stage_furniture, effective / maturity_turns,
                                             std::max( 0.01f, water_use ), daily_et ) * days * activity );
        const double rain = covered && !historical ? 0 : hourly_rain[hour] * to_hours<double>( step );
        sampled_rain += rain;
        degree_days += heat_fraction * days * climate.degree_days;
        moisture = std::min( capacity, moisture + rain * soil.infiltration );
        const double consumed = std::min( irrigation, std::max( 0.0, need - moisture ) );
        irrigation -= consumed;
        const double available = moisture + consumed;
        const double water_ratio = std::clamp( available / need, 0.0, 1.0 );
        if( effective < maturity_turns && !dormant ) {
            water_demand += need;
            water_supplied += std::min( available, need );
        }
        moisture = std::clamp( available - need, 0.0, capacity );
        // Capacity is plant-available water at field capacity, not saturation.
        // Rain above it has already drained at the storage clamp.

        const double rate = stage_furniture->plant ?
                            growth_speed * stage_furniture->plant->growth_multiplier : growth_speed;
        if( effective >= maturity_turns ) {
            effective += to_turns<double>( step ) * rate;
        } else if( !dormant ) {
            const bool establishing = effective < to_turns<double>( thresholds.front() );
            const double establishment = establishing ? std::sqrt( water_ratio ) * soil.root_growth : 1.0;
            const double growth_days = days * rate * establishment;
            // Before cold exposure, winter wheat can establish leaves but cannot head.
            const double stage_limit = chill < climate.vernalization_days ? 0.33 : 1.0;
            thermal_growth = std::min( stage_limit, thermal_growth + heat_fraction * growth_days );
            if( heat_fraction > 0 ) {
                growing_time += day_fraction * days * rate;
            }
            effective = std::max( effective, maturity_turns *
                                  std::min( { stage_limit, thermal_growth, growing_time } ) );
        }
        start += step;
        if( effective >= final_growth ) {
            effective = final_growth;
            break;
        }
    }
    if( effective >= final_growth ) {
        // A standing field crop still records its local weather after growth stops.
        while( field_crop && start < end ) {
            const bool historical = start < history_end;
            const time_duration elapsed = crop_time_of_day( start );
            const time_duration step = std::min( interval_end( start, end ) - start, 1_days - elapsed );
            const crop_day &day = sample_day( position, start - elapsed, historical );
            degree_days += crop_heat_fraction( here, p, climate, day, covered && !historical ) *
                           to_days<double>( step ) * climate.degree_days;
            if( historical || !covered ) {
                sampled_rain += crop_rain_for_interval( day, elapsed, step );
            }
            start += step;
        }
        start = std::max( start, end );
    }

    if( iexamine::get_plant_max_water( *stage_furniture ) > 0 ) {
        const double charges = irrigation / charge_mm;
        iexamine::set_plant_water( seed, static_cast<int>( charges ) );
        seed.set_var( "crop_irrigation_fraction", charges - static_cast<int>( charges ) );
    }
    seed.set_var( "crop_soil_moisture_mm", moisture );
    seed.set_var( "crop_thermal_growth", thermal_growth );
    seed.set_var( "crop_growing_time", growing_time );
    if( climate.vernalization_days > 0 ) {
        seed.set_var( "crop_vernalization_days", chill );
    }
    seed.set_var( "crop_sampled_rain_mm", sampled_rain );
    seed.set_var( "crop_degree_days", degree_days );
    seed.set_var( "crop_water_demand_mm", water_demand );
    seed.set_var( "crop_water_supplied_mm", water_supplied );
    iexamine::set_plant_last_water_check( seed, start );
    iexamine::set_plant_effective_growth_turns( seed, static_cast<int>( effective ) );
    seed.set_var( "crop_growth_fraction", effective - static_cast<int>( effective ) );
    return time_duration::from_turns( effective );
}

int fruit_model_day( time_point when )
{
    const time_duration year = calendar::year_length();
    return static_cast<int>( ( ( time_past_new_year( when ) + year ) % year ) / year * model_days );
}

bool has_local_fruit_climate( const tripoint_abs_ms &pos )
{
    const weather_generator &generator = get_weather_const().get_cur_weather_gen();
    if( !generator.climate_location( pos ) ) {
        return false;
    }
    const tripoint_abs_omt cell = snow_climate_cell( project_to<coords::omt>( pos ) );
    return cell_at( cell, generator ).normals.has_value();
}

std::optional<int> local_fruit_ripe_day( const fruit_climate_profile &fruit,
        const tripoint_abs_ms &pos )
{
    const tripoint_abs_omt cell = snow_climate_cell( project_to<coords::omt>( pos ) );
    const weather_generator &generator = get_weather_const().get_cur_weather_gen();
    crop_weather_cell &cached = cell_at( cell, generator );
    const auto previous = cached.ripening.find( fruit.harvest );
    if( previous != cached.ripening.end() ) {
        return previous->second;
    }
    auto result = cached.ripening.emplace( fruit.harvest, std::nullopt ).first;
    if( !cached.normals ) {
        return std::nullopt;
    }
    const regional_climate::normals &normals = *cached.normals;
    std::array<regional_climate::temperature_normal, model_days> means;
    for( int day = 0; day < model_days; ++day ) {
        means[day] = regional_climate::temperature_for_day( normals, day + 0.5 );
    }
    const int coldest = std::min_element( means.begin(), means.end(), []( const auto & a,
    const auto & b ) {
        return a.mean_c < b.mean_c;
    } ) - means.begin();
    const crop_climate_profile &growth = fruit.growth;
    double progressed = 0;
    double stored_rain = growth.water_mm / growth.growing_days * 10;
    const double need = growth.water_mm / growth.growing_days;
    for( int elapsed = 1; elapsed < model_days; ++elapsed ) {
        const int day = ( elapsed + coldest ) % model_days;
        const auto &sample = means[day];
        const double rain = normals.months[sample.month].precipitation_mm /
                            ( sample.month % 3 == 0 ? 31 : 30 );
        stored_rain = std::min( stored_rain + rain, need * 14 );
        const double heat = growth.heat_units( sample.mean_c - sample.daily_range_c,
                                               sample.mean_c + sample.daily_range_c );
        const double water_ratio = std::clamp( stored_rain / need, 0.2, 1.0 );
        if( heat > 0 ) {
            stored_rain = std::max( 0.0, stored_rain - need );
        }
        progressed += std::min( heat / growth.degree_days, 1.0 / growth.growing_days ) * water_ratio;
        if( progressed >= 1.0 ) {
            result->second = day;
            break;
        }
    }
    return result->second;
}

bool local_fruit_is_ripe( const fruit_climate_profile &fruit, const tripoint_abs_ms &pos,
                          time_point when )
{
    const auto ripe = local_fruit_ripe_day( fruit, pos );
    if( !ripe ) {
        return false;
    }
    const int elapsed = ( fruit_model_day( when ) - *ripe + model_days ) % model_days;
    return elapsed < fruit.bearing_days;
}
