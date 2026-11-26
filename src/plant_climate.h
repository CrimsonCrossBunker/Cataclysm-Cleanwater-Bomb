#pragma once
#ifndef CATA_SRC_PLANT_CLIMATE_H
#define CATA_SRC_PLANT_CLIMATE_H

#include <optional>

#include "calendar.h"
#include "coordinates.h"
#include "type_id.h"

class JsonObject;
class item;
class map;
struct furn_t;

struct crop_climate_profile {
    double base_c;
    double optimum_c;
    double min_c;
    double max_c;
    double degree_days;
    double water_mm;
    int growing_days;
    double water_peak;
    int vernalization_days;
    double root_zone_water_mm;

    static crop_climate_profile load( const JsonObject &jo );
    double heat_units( double low, double high ) const;
};

struct field_crop {
    itype_id seed;
    int planting_day;
    int harvest_day;
    int planting_year_offset;

    // Dates follow the displayed game calendar and scale with the configured year length.
    std::optional<time_point> sowing_date( time_point when ) const;
};

std::optional<field_crop> regional_field_crop( point_abs_omt field,
        const itype_id &existing_seed = itype_id::NULL_ID() );
std::optional<time_point> regional_field_sowing( const field_crop &crop, point_abs_omt field,
        time_point when );
void repair_regional_field_crop( map &here, const tripoint_bub_ms &p, item &seed );
bool is_primary_crop_seed( const item &value );
item *relay_crop_at( map &here, const tripoint_bub_ms &p );
bool relay_corn_has_planting_weather( const map &here, const tripoint_bub_ms &p );
void release_relay_crop( const map &here, const tripoint_bub_ms &p, item &seed,
                         double soil_water_mm );

struct fruit_climate_profile {
    crop_climate_profile growth;
    harvest_id harvest;
    int bearing_days;

    static fruit_climate_profile load( const JsonObject &jo );
};

struct crop_water_status {
    double soil_moisture_mm;
    double soil_capacity_mm;
    double irrigation_mm;
    double daily_need_mm;
    bool temperature_limited;
    bool dormant;
};

crop_water_status get_crop_water_status( const map &here, const tripoint_bub_ms &p,
        const item &seed );

time_duration update_crop_climate( const map &here, const tripoint_bub_ms &p, item &seed,
                                   const furn_t &furniture, float growth_speed, float water_use,
                                   bool finish_interval = false );

bool has_local_fruit_climate( const tripoint_abs_ms &pos );

// First ripe day of the current model year. No value if the climate cannot ripen the fruit.
std::optional<int> local_fruit_ripe_day( const fruit_climate_profile &fruit,
        const tripoint_abs_ms &pos );
int fruit_model_day( time_point when );
bool local_fruit_is_ripe( const fruit_climate_profile &fruit, const tripoint_abs_ms &pos,
                          time_point when );
void clear_plant_climate_cache();

#endif // CATA_SRC_PLANT_CLIMATE_H
