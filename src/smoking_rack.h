#pragma once
#ifndef CATA_SRC_SMOKING_RACK_H
#define CATA_SRC_SMOKING_RACK_H

#include <cstdint>
#include <vector>

#include "item_source.h"
#include "tool_activity_target.h"
#include "type_id.h"
#include "units.h"

class Character;
class JsonObject;
class JsonOut;
class item;
class map;
class time_point;

namespace smoking_rack
{
constexpr int minimum_fuel = 1200;
constexpr int fuel_per_liter = 600;

enum class operation : int {
    fire_bionic, load_food, load_fuel, remove_food, remove_fuel, quench, recover
};
enum class preparation { unready, ready, ejected };

struct portion {
    item_source source;
    int quantity = 0;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct command {
    operation action = operation::recover;
    tripoint_abs_ms origin;
    tool_activity_target target;
    int64_t batch = 0;
    std::vector<portion> items;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool is_idle( const furn_id &furniture );
bool is_active( const furn_id &furniture );
bool is_portable( const furn_id &furniture );
bool is_embers( const item &it );
units::volume food_capacity( const furn_id &furniture );
int fuel_capacity( const furn_id &furniture );
int fuel_required( units::volume food );
preparation prepare( Character &who, map &here, const tripoint_bub_ms &pos,
                     bool eject_invalid = false );
bool ignite( Character &who, map &here, const tripoint_bub_ms &pos );
bool needs_recovery( map &here, const tripoint_bub_ms &pos );
void reconcile( map &here, const tripoint_bub_ms &pos );
void finish( map &here, const tripoint_bub_ms &pos, const time_point &start_time );

command capture( const Character &who, map &here, const tripoint_bub_ms &pos, operation action );
bool execute( Character &who, map &here, const command &request,
              std::vector<tripoint_abs_ms> *changed_tiles = nullptr );
} // namespace smoking_rack

#endif // CATA_SRC_SMOKING_RACK_H
