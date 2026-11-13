#pragma once
#ifndef CATA_SRC_FERMENTATION_VESSEL_H
#define CATA_SRC_FERMENTATION_VESSEL_H

#include <cstdint>
#include <optional>
#include <vector>

#include "item_unload.h"
#include "tool_activity_target.h"
#include "type_id.h"
#include "units.h"

class Character;
class JsonObject;
class JsonOut;
class item;
class map;
class player_activity;
class time_duration;

namespace fermentation_vessel
{
enum class operation : int { deposit, start, finish, drain, gather_gas, recover };
struct command {
    operation action = operation::recover;
    tripoint_abs_ms origin;
    tool_activity_target target;
    int64_t batch = 0;
    int charges = 0;
    bool start_after_deposit = false;
    std::vector<item_source> supplies;
    std::optional<unload_liquid_choice> destination;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

units::volume capacity( const furn_id &vessel );
bool accepts( const furn_id &vessel, const item &input );
time_duration duration( const furn_id &vessel, const item &input );
int gas_days_available( const item &input );
command capture( const Character &who, map &here, const tripoint_bub_ms &pos, operation action,
                 const item *batch = nullptr );
bool execute( Character &who, map &here, const command &request );
void drain_turn( player_activity &act, Character &who, const item_source &source,
                 const unload_liquid_choice &destination );
} // namespace fermentation_vessel

#endif // CATA_SRC_FERMENTATION_VESSEL_H
