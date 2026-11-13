#pragma once
#ifndef CATA_SRC_ITEM_REPAIR_H
#define CATA_SRC_ITEM_REPAIR_H

#include <string>
#include <vector>

#include "item_location.h"
#include "item_source.h"
#include "type_id.h"

class Character;
class item;
class map;
class time_duration;
class fault_fix;
class repair_item_actor;

namespace item_repair
{
struct repair_target {
    item_source source;
    tripoint_abs_ms origin;
    faction_id vehicle_owner;
    bool allow_theft = false;

    bool matches( const item_source &candidate ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

repair_target capture_target( Character &who, const item_location &target );
item_location resolve_target( Character &who, map &here, const repair_target &selection );
bool confirm_target_ownership( Character &who, const item_location &target, repair_target &selection );
bool authorize_vehicle_work( Character &who, map &here, repair_target &selection );

struct mending_selection {
    repair_target target;
    fault_id fault;
    fault_fix_id fix;
    bool debug_toggle = false;
    bool expected_fault = false;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool can_mend_fault( Character &who, const fault_fix &fix );
time_duration fault_repair_time( const Character &who, const item &target, const fault_fix &fix );
bool start_owned_mending( Character &who, map &here, mending_selection selection );

struct tool_option {
    item_location tool;
    std::string method;
    const repair_item_actor *actor;
    bool available;
};

// Ordinary damage repairs use the same actors as activating a repair tool.
std::vector<tool_option> tools_for( Character &you, const item_location &target );
bool start( Character &you, const item_location &target, const tool_option &option );
} // namespace item_repair

#endif // CATA_SRC_ITEM_REPAIR_H
