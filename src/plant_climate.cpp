#include "plant_climate.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <functional>
#include <memory>
#include <set>
#include <string>
#include <tuple>
#include <unordered_map>
#include <utility>
#include <vector>

#include "calendar.h"
#include "cata_path.h"
#include "cata_utility.h"
#include "climate_seasons.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "iexamine.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "mapdata.h"
#include "north_america_soil.h"
#include "options.h"
#include "overmap_ui.h"
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
        jo.get_float( "water_peak", 0.5 )
    };
    if( result.min_c > result.base_c || result.base_c >= result.optimum_c ||
        result.optimum_c >= result.max_c || result.degree_days <= 0 ||
        result.water_mm <= 0 || result.growing_days <= 0 ||
        result.water_peak < 0 || result.water_peak > 1 ) {
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
    constexpr double days_in_calendar = 365;
    const time_duration year = calendar::year_length();
    const time_duration date = ( time_past_new_year( when ) + year ) % year;
    time_point planted = when - date + year * ( planting_day / days_in_calendar );
    if( planted > when ) {
        planted -= year;
    }
    const int field_season = ( harvest_day - planting_day + 365 ) % 365 + 1;
    return when - planted < year * ( field_season / days_in_calendar ) ?
           std::optional<time_point>( planted ) : std::nullopt;
}

namespace
{
struct weighted_crop {
    field_crop crop;
    unsigned weight;
};

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
    int result = day - 1;
    for( int i = 0; i < month - 1; ++i ) {
        result += month_lengths[i];
    }
    return result;
}
} // namespace

std::optional<field_crop> regional_field_crop( std::string_view region, unsigned field_roll )
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
                    options.push_back( {
                        {
                            itype_id( values.get_string( 0 ) ), crop_calendar_day( values[2] ),
                            crop_calendar_day( values[3] )
                        },
                        static_cast<unsigned>( weight )
                    } );
                }
            }
        } );
        return result;
    }();
    const auto options = profiles.find( std::string( region ) );
    if( options == profiles.end() || options->second.empty() ) {
        return std::nullopt;
    }
    unsigned total = 0;
    for( const weighted_crop &choice : options->second ) {
        total += choice.weight;
    }
    unsigned roll = field_roll % total;
    for( const weighted_crop &choice : options->second ) {
        if( roll < choice.weight ) {
            return choice.crop;
        }
        roll -= choice.weight;
    }
    return std::nullopt;
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
constexpr time_duration crop_history = 2 * 364_days;

struct crop_day {
    double low;
    double high;
    std::array<double, 24> rain;
};

struct crop_weather_cell {
    std::optional<regional_climate::normals> normals;
    std::unordered_map<int, crop_day> days;
    std::unordered_map<harvest_id, std::optional<int>> ripening;
};

std::unordered_map<tripoint_abs_omt, crop_weather_cell> cells;

crop_weather_cell &cell_at( const tripoint_abs_omt &cell, const weather_generator &generator )
{
    const auto &weather = get_weather_const();
    const auto current = std::make_tuple( g->get_seed(), &generator, calendar::year_length(),
                                          get_option<std::string>( "ETERNAL_WEATHER" ), weather.weather_override,
                                          weather.forced_temperature, weather.climate_origin );
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
    sample.normals = generator.climate_at( project_to<coords::ms>( cell ) );
    return sample;
}

const crop_day &sample_day( const tripoint_abs_ms &pos, time_point date )
{
    const weather_manager &weather = get_weather_const();
    const weather_generator &generator = weather.get_cur_weather_gen();
    const tripoint_abs_omt cell = snow_climate_cell( project_to<coords::omt>( pos ) );
    crop_weather_cell &cached = cell_at( cell, generator );
    const time_point start = date - time_past_midnight( date );
    const int day = to_days<int>( start - calendar::turn_zero );
    const auto found = cached.days.find( day );
    if( found != cached.days.end() ) {
        return found->second;
    }
    if( cached.days.size() >= 768 ) {
        cached.days.clear();
    }
    const tripoint_abs_ms location = project_to<coords::ms>( cell ) + point( 384, 384 );
    const std::string eternal = get_option<std::string>( "ETERNAL_WEATHER" );
    const weather_type_id forced = eternal == "normal" ? weather.weather_override :
                                   weather_type_id( eternal );
    crop_day result{ 100, -100, {} };
    for( int hour = 0; hour < 24; ++hour ) {
        const w_point sample = generator.get_weather( location, start + hour * 1_hours, g->get_seed(),
                               false, &cached.normals );
        const double c = units::to_celsius( weather.forced_temperature.value_or( sample.temperature ) );
        if( hour % 6 == 3 ) {
            result.low = std::min( result.low, c );
            result.high = std::max( result.high, c );
        }
        if( c > 1 ) {
            const weather_type_id type = forced == WEATHER_NULL ? generator.get_weather_conditions( sample ) :
                                         forced;
            if( type->rains ) {
                const auto regional_rate = forced == WEATHER_NULL ?
                                           regional_precipitation_rate( type, sample ) : std::nullopt;
                result.rain[hour] = regional_rate.value_or( precip_mm_per_hour( type->precip ) );
            }
        }
    }
    return cached.days.emplace( day, result ).first->second;
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
                        double water_use )
{
    const crop_climate_profile &climate = *seed.type->seed->climate;
    return climate.water_mm / climate.growing_days * model_days /
           to_days<double>( calendar::year_length() ) * water_use *
           iexamine::get_plant_water_consumption_multiplier( furniture ) *
           ( 1.25 - 0.6 * std::abs( std::clamp( stage, 0.0, 1.0 ) - climate.water_peak ) );
}

double crop_heat_fraction( const map &here, const tripoint_bub_ms &p,
                           const crop_climate_profile &climate, const crop_day &day )
{
    double offset = 0;
    if( &here == &get_map() ) {
        weather_manager &weather = get_weather();
        const auto ambient = weather.forced_temperature.value_or( weather.temperature );
        offset = units::to_celsius( weather.get_temperature( p ) ) - units::to_celsius( ambient );
    }
    const double mean = ( day.low + day.high ) / 2;
    const double restraint = here.is_roofed( p ) || p.z() < 0 ? ( day.high - day.low ) * 0.2 : 0;
    const double low = std::min( mean, day.low + restraint ) + offset;
    const double high = std::max( mean, day.high - restraint ) + offset;
    return climate.heat_units( low, high ) * model_days /
           to_days<double>( calendar::year_length() ) / climate.degree_days;
}
} // namespace

void clear_plant_climate_cache()
{
    cells.clear();
}

crop_water_status get_crop_water_status( const map &here, const tripoint_bub_ms &p,
        const item &seed )
{
    const furn_t &furniture = here.furn( p ).obj();
    const islot_seed &slot = *seed.type->seed;
    const crop_climate_profile &climate = *slot.climate;
    const auto &thresholds = slot.get_cumulative_stage_thresholds();
    const double maturity = to_turns<double>( thresholds[slot.get_harvest_stage_idx() - 1] );
    const double capacity = std::max( 12.0, climate.water_mm / climate.growing_days * 5 ) *
                            crop_soil( here, p, furniture ).water_capacity;
    const double moisture = std::clamp( seed.get_var( "crop_soil_moisture_mm", capacity * 0.65 ),
                                        0.0, capacity );
    const double irrigation = iexamine::get_plant_max_water( furniture ) > 0 ?
                              ( iexamine::get_plant_water( seed ) +
                                seed.get_var( "crop_irrigation_fraction", 0.0 ) ) * charge_mm : 0;
    const double day_fraction = model_days / to_days<double>( calendar::year_length() ) /
                                climate.growing_days;
    return { moisture, capacity, irrigation,
             crop_water_need( seed, furniture, effective_crop_turns( seed ) / maturity,
                              get_option<float>( "CROP_WATER_CONSUMPTION" ) ),
             crop_heat_fraction( here, p, climate, sample_day( here.get_abs( p ), calendar::turn ) ) <
             day_fraction };
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
    auto soil = crop_soil( here, p, furniture );
    const double base_capacity = std::max( 12.0, climate.water_mm / climate.growing_days * 5 );
    double capacity = base_capacity * soil.water_capacity;
    double irrigation = iexamine::get_plant_max_water( furniture ) > 0 ?
                        ( iexamine::get_plant_water( seed ) +
                          seed.get_var( "crop_irrigation_fraction", 0.0 ) ) * charge_mm : 0;
    double moisture = std::clamp( seed.get_var( "crop_soil_moisture_mm", capacity * 0.65 ),
                                  0.0, capacity );
    time_point start = iexamine::get_plant_last_water_check( seed );
    if( !seed.has_var( "seed_last_water_check" ) ) {
        start = calendar::turn - seed.age();
    }

    double effective = effective_crop_turns( seed );
    int current_stage = iexamine::get_plant_current_stage_idx( here, p,
                        slot.get_growth_stages() );
    if( current_stage > 0 && current_stage <= static_cast<int>( thresholds.size() ) ) {
        effective = std::max( effective, to_turns<double>( thresholds[current_stage - 1] ) );
    }
    if( start > calendar::turn ) {
        return time_duration::from_turns( effective );
    }
    start = std::max( start, calendar::turn - crop_history );
    const tripoint_abs_ms position = here.get_abs( p );
    const time_point end = finish_interval ? calendar::turn :
                           calendar::turn - time_past_midnight( calendar::turn ) % 1_hours;
    const double maturity_turns = to_turns<double>( maturity );
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
        const time_duration step = std::min( end - start,
                                             1_hours - time_past_midnight( start ) % 1_hours );
        const double days = to_days<double>( step );
        const crop_day &day = sample_day( position, start );
        const int hour = to_hours<int>( time_past_midnight( start ) );
        const double need = crop_water_need( seed, *stage_furniture, effective / maturity_turns,
                                             std::max( 0.01f, water_use ) ) * days;
        const double rain = covered ? 0 : day.rain[hour] * to_hours<double>( step );
        moisture = std::min( capacity, moisture + rain * soil.infiltration );
        const double consumed = std::min( irrigation, std::max( 0.0, need - moisture ) );
        irrigation -= consumed;
        const double available = moisture + consumed;
        const double water_ratio = std::clamp( available / need, 0.0, 1.0 );
        moisture = std::clamp( available - need, 0.0, capacity );
        moisture -= std::max( 0.0, moisture - 0.5 * capacity ) *
                    ( 1 - std::pow( 1 - soil.drainage, days ) );

        const double rate = stage_furniture->plant ?
                            growth_speed * stage_furniture->plant->growth_multiplier : growth_speed;
        if( effective >= maturity_turns ) {
            effective += to_turns<double>( step ) * rate;
        } else {
            const double heat_fraction = crop_heat_fraction( here, p, climate, day );
            const double day_fraction = per_model_day / climate.growing_days;
            effective += maturity_turns * std::min( heat_fraction, day_fraction ) * days *
                         water_ratio * rate * soil.root_growth;
        }
        start += step;
        if( effective >= final_growth ) {
            effective = final_growth;
            break;
        }
    }
    if( effective >= final_growth ) {
        start = std::max( start, end );
    }

    if( iexamine::get_plant_max_water( *stage_furniture ) > 0 ) {
        const double charges = irrigation / charge_mm;
        iexamine::set_plant_water( seed, static_cast<int>( charges ) );
        seed.set_var( "crop_irrigation_fraction", charges - static_cast<int>( charges ) );
    }
    seed.set_var( "crop_soil_moisture_mm", moisture );
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
