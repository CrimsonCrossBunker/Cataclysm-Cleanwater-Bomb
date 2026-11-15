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

    static crop_climate_profile load( const JsonObject &jo );
    double heat_units( double low, double high ) const;
};

struct fruit_climate_profile {
    crop_climate_profile growth;
    harvest_id harvest;
    int bearing_days;

    static fruit_climate_profile load( const JsonObject &jo );
};

time_duration update_crop_climate( const map &here, const tripoint_bub_ms &p, item &seed,
                                   const furn_t &furniture, float growth_speed, float water_use );

bool has_local_fruit_climate( const tripoint_abs_ms &pos );

// First ripe day of the current model year. No value if the climate cannot ripen the fruit.
std::optional<int> local_fruit_ripe_day( const fruit_climate_profile &fruit,
        const tripoint_abs_ms &pos );
int fruit_model_day( time_point when );
bool local_fruit_is_ripe( const fruit_climate_profile &fruit, const tripoint_abs_ms &pos,
                          time_point when );
void clear_plant_climate_cache();

#endif // CATA_SRC_PLANT_CLIMATE_H
