#pragma once
#ifndef CATA_SRC_VEHICLE_POWER_CONNECTION_H
#define CATA_SRC_VEHICLE_POWER_CONNECTION_H

#include <cstdint>
#include <optional>
#include <string>

#include "coordinates.h"
#include "enums.h"
#include "item_source.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class item;
class item_location;
class link_up_actor;
class map;
class vehicle;

struct vehicle_cable_endpoint {
    tripoint_abs_ms position;
    int64_t vehicle_id = 0;
    int64_t part_id = 0;
    faction_id owner;
    bool allow_theft = false;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct appliance_connection_selection {
    tripoint_abs_ms origin;
    vehicle_cable_endpoint source;
    vehicle_cable_endpoint destination;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

std::optional<appliance_connection_selection> query_appliance_connection( Character &who,
        map &here, vehicle &source, const point_rel_ms &mount );
bool execute_appliance_connection( Character &who, map &here,
                                   const appliance_connection_selection &selection );

struct cable_link_selection {
    tripoint_abs_ms origin;
    std::string action = "attach";
    link_state expected_source = link_state::no_link;
    link_state expected_target = link_state::no_link;
    int64_t expected_part = 0;
    int64_t expected_device = 0;
    std::optional<vehicle_cable_endpoint> first;
    std::optional<vehicle_cable_endpoint> destination;
    bool to_ports = true;
    bool to_towing = false;
    bool allow_spill = false;
    std::optional<item_source> device;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

std::optional<cable_link_selection> query_cable_link( Character &who, map &here,
        const item_location &cable, const link_up_actor &link );
bool valid_cable_link( Character &who, map &here, const item &cable, const link_up_actor &link,
                      const cable_link_selection &selection );
std::optional<int> execute_cable_link( Character &who, map &here, item_location cable,
                                      const link_up_actor &link, const cable_link_selection &selection );

#endif // CATA_SRC_VEHICLE_POWER_CONNECTION_H
