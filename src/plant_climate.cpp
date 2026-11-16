#include "plant_climate.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <string>
#include <unordered_map>
#include <vector>

#include "cata_path.h"
#include "climate_seasons.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "iexamine.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "mapdata.h"
#include "north_america_soil.h"
#include "options.h"
#include "path_info.h"
#include "units.h"
#include "weather.h"
#include "weather_gen.h"

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
    double rain;
};

struct crop_weather_cell {
    std::optional<regional_climate::normals> normals;
    std::unordered_map<int, crop_day> days;
    std::unordered_map<harvest_id, std::optional<int>> ripening;
};

std::unordered_map<tripoint_abs_omt, crop_weather_cell> cells;

crop_weather_cell &cell_at( const tripoint_abs_omt &cell, const weather_generator &generator )
{
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

crop_day sample_day( const tripoint_abs_ms &pos, time_point date )
{
    const auto &weather = get_weather_const();
    const auto &generator = weather.get_cur_weather_gen();
    const auto cell = snow_climate_cell( project_to<coords::omt>( pos ) );
    crop_weather_cell &cached = cell_at( cell, generator );
    const auto start = date - time_past_midnight( date );
    const int day = to_days<int>( start - calendar::turn_zero );
    const auto found = cached.days.find( day );
    if( found != cached.days.end() ) {
        return found->second;
    }
    if( cached.days.size() >= 768 ) {
        cached.days.clear();
    }
    const auto location = project_to<coords::ms>( cell ) + point( 384, 384 );
    const std::string eternal = get_option<std::string>( "ETERNAL_WEATHER" );
    const weather_type_id forced = eternal == "normal" ? weather.weather_override :
                                   weather_type_id( eternal );
    crop_day result{ 100, -100, 0 };
    for( int hour = 3; hour < 24; hour += 6 ) {
        const w_point sample = generator.get_weather( location, start + hour * 1_hours, g->get_seed(),
                               false, &cached.normals );
        const double c = units::to_celsius( weather.forced_temperature.value_or( sample.temperature ) );
        result.low = std::min( result.low, c );
        result.high = std::max( result.high, c );
        if( c > 1 ) {
            const weather_type_id type = forced == WEATHER_NULL ? generator.get_weather_conditions( sample ) :
                                         forced;
            const double rate = forced == WEATHER_NULL ? sample.climate_precipitation_mm_per_hour.value_or(
                                    precip_mm_per_hour( type->precip ) ) : precip_mm_per_hour( type->precip );
            result.rain += 6 * rate;
        }
    }
    cached.days.emplace( day, result );
    return result;
}
} // namespace

void clear_plant_climate_cache()
{
    cells.clear();
}

time_duration update_crop_climate( const map &here, const tripoint_bub_ms &p, item &seed,
                                   const furn_t &furniture, float growth_speed, float water_use )
{
    const islot_seed &slot = *seed.type->seed;
    const crop_climate_profile &climate = *slot.climate;
    const auto &thresholds = slot.get_cumulative_stage_thresholds();
    const int harvest = slot.get_harvest_stage_idx();
    const time_duration maturity = thresholds[std::max( 0, harvest - 1 )];
    const double per_model_day = model_days / to_days<double>( calendar::year_length() );
    const double average_need = climate.water_mm / climate.growing_days * per_model_day *
                                std::max( 0.01f, water_use ) *
                                iexamine::get_plant_water_consumption_multiplier( furniture );
    const bool covered = here.is_roofed( p ) || p.z() < 0;
    const int max_water = iexamine::get_plant_max_water( furniture );
    const north_america::crop_soil_properties soil = max_water > 0 ?
            north_america::crop_soil_properties{} :
            north_america::crop_soil_at( here.ter( p ) );
    const double capacity = std::max( 12.0, average_need * 5 ) * soil.water_capacity;
    int irrigation = max_water > 0 ? iexamine::get_plant_water( seed ) : 0;
    double moisture = std::clamp( seed.get_var( "crop_soil_moisture_mm", capacity * 0.65 ),
                                  0.0, capacity );
    time_point start = iexamine::get_plant_last_water_check( seed );
    if( start == time_point::from_turn( 0 ) ) {
        start = calendar::turn - seed.age();
    }

    time_duration effective = time_duration::from_turns( iexamine::get_plant_effective_growth_turns(
                                  seed ) );
    const int current_stage = iexamine::get_plant_current_stage_idx( here, p,
                              slot.get_growth_stages() );
    if( current_stage > 0 && current_stage <= static_cast<int>( thresholds.size() ) ) {
        effective = std::max( effective, thresholds[current_stage - 1] );
    }
    start = std::max( start, calendar::turn - crop_history );
    const auto position = here.get_abs( p );
    const double rate = growth_speed * furniture.plant->growth_multiplier;
    double temperature_offset = 0;
    if( &here == &get_map() ) {
        weather_manager &weather = get_weather();
        const units::temperature ambient = weather.forced_temperature.value_or( weather.temperature );
        // Historical weather has no heater state; use the current local temperature offset.
        temperature_offset = units::to_celsius( weather.get_temperature( p ) ) -
                             units::to_celsius( ambient );
    }
    for( ; start + 1_days <= calendar::turn; start += 1_days ) {
        const crop_day day = sample_day( position, start );
        const double stage = std::clamp( effective / maturity, 0.0, 1.0 );
        const double need = average_need * ( 1.25 - 0.6 * std::abs( stage - climate.water_peak ) );
        const double rain = covered ? 0 : day.rain;
        if( max_water > 0 && rain > 0 ) {
            irrigation = std::min( max_water, irrigation + static_cast<int>( rain / charge_mm ) );
        } else {
            moisture = std::min( capacity, moisture + rain * soil.infiltration );
        }
        const int consumed = std::min( irrigation, static_cast<int>( std::ceil( need / charge_mm ) ) );
        irrigation -= consumed;
        const double available = moisture + consumed * charge_mm;
        const double water_ratio = std::clamp( available / need, 0.0, 1.0 );
        moisture = std::clamp( available - need, 0.0, capacity );
        moisture -= std::max( 0.0, moisture - 0.5 * capacity ) * soil.drainage;

        if( effective >= maturity ) {
            effective += 1_days * rate;
            if( effective >= thresholds.back() ) {
                start = calendar::turn;
                break;
            }
            continue;
        }
        const double mean = ( day.low + day.high ) / 2;
        const double restraint = covered ? ( day.high - day.low ) * 0.2 : 0;
        const double low = std::min( mean, day.low + restraint ) + temperature_offset;
        const double high = std::max( mean, day.high - restraint ) + temperature_offset;
        const double heat_fraction = climate.heat_units( low, high ) * per_model_day / climate.degree_days;
        const double day_fraction = per_model_day / climate.growing_days;
        const double progress = std::min( heat_fraction, day_fraction ) * water_ratio * rate *
                                soil.root_growth;
        effective += maturity * progress;
    }

    if( max_water > 0 ) {
        iexamine::set_plant_water( seed, irrigation );
    }
    seed.set_var( "crop_soil_moisture_mm", moisture );
    iexamine::set_plant_last_water_check( seed, start );
    iexamine::set_plant_effective_growth_turns( seed, to_turns<int>( effective ) );
    return effective;
}

int fruit_model_day( time_point when )
{
    const time_duration year = calendar::year_length();
    return static_cast<int>( ( ( time_past_new_year( when ) + year ) % year ) / year * model_days );
}

bool has_local_fruit_climate( const tripoint_abs_ms &pos )
{
    const auto &generator = get_weather_const().get_cur_weather_gen();
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
    const auto &generator = get_weather_const().get_cur_weather_gen();
    crop_weather_cell &cached = cell_at( cell, generator );
    const auto previous = cached.ripening.find( fruit.harvest );
    if( previous != cached.ripening.end() ) {
        return previous->second;
    }
    auto result = cached.ripening.emplace( fruit.harvest, std::nullopt ).first;
    if( !cached.normals ) {
        return std::nullopt;
    }
    const auto &normals = *cached.normals;
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
