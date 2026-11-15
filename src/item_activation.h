#pragma once
#ifndef CATA_SRC_ITEM_ACTIVATION_H
#define CATA_SRC_ITEM_ACTIVATION_H

#include <optional>
#include <cstdint>
#include <string>
#include <vector>

#include "coords_fwd.h"
#include "tool_activity_target.h"
#include "vehicle_power_connection.h"

class Character;
class item;
class item_location;

struct salvage_selection {
    item_source target;
    itype_id type;
    bool allow_equipped = false;
    bool allow_theft = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct lumber_selection {
    item_source log;
    bool allow_theft = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

// Player input only; costs and gameplay effects are always computed natively.
struct item_activation_choices {
    std::optional<int> timer_seconds;
    std::optional<int> radio;
    std::string remote_vehicle_action;
    std::optional<int64_t> remote_vehicle_uid;
    std::optional<tool_activity_target> fire_target;
    std::optional<item_source> fire_tinder;
    std::optional<lumber_selection> lumber;
    std::optional<salvage_selection> salvage;
    std::vector<salvage_selection> salvage_batch;
    std::optional<cable_link_selection> cable_link;
    bool empty() const {
        return !timer_seconds && !radio && remote_vehicle_action.empty() && !remote_vehicle_uid &&
               !fire_target && !fire_tinder && !lumber && !salvage && salvage_batch.empty() && !cable_link;
    }
};

bool query_item_activation_choices( const item_location &location, const std::string &method,
                                    item_activation_choices &choices );
bool valid_item_activation_choices( const item &source, const std::string &method,
                                    const item_activation_choices &choices );

// True only when the method can execute on the supplied actor/target without
// collecting another local UI choice during execution. Choices are supplied
// explicitly; empty method selects the Platform v1 use.
bool supports_owned_item_activation( const item &source, const std::string &method );

// Validates native access and applies obtain, activation and charge use once.
// The caller supplies choices, never item payloads or client-computed costs.
// Any activity created by the callback remains authoritative.
bool execute_owned_item_activation( Character &who, item_location source,
                                    const std::string &method, const tripoint_abs_ms &target,
                                    bool allow_theft, bool allow_wet,
                                    const item_activation_choices &choices = {} );

#endif // CATA_SRC_ITEM_ACTIVATION_H
