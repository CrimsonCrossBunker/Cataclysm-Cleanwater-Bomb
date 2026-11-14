#pragma once
#ifndef CATA_SRC_MP_PICKUP_H
#define CATA_SRC_MP_PICKUP_H

#include <cstdint>
#include <optional>
#include <map>
#include <string>

class Character;
class JsonObject;
class item_location;
class map;
class player_id;
namespace Pickup
{
struct selection;
} // namespace Pickup

namespace cata_mp
{
// These are simulation-owned admission-local values, not worker state.
struct pickup_host_state {
    // Shared by all authoritative carried-item changes; request tracking below
    // is shared by ground pickup and giving an owned item.
    int64_t revision = 0;
    int64_t last_request = 0;
    std::string last_result;
};

struct pickup_client_state {
    int64_t revision = 0;
    int64_t next_request = 0;
    int64_t pending_request = 0;
};

std::optional<std::string> make_pickup_request( const Pickup::selection &selection,
        const map &here, pickup_client_state &state );
std::string execute_pickup_request( Character &who, map &here, const JsonObject &request,
                                    pickup_host_state &state );
bool apply_pickup_result( Character &who, const JsonObject &result, pickup_client_state &state );
bool apply_inventory_update( Character &who, const JsonObject &result, pickup_client_state &state );
bool pickup_inventory_revision_matches( const JsonObject &message, const pickup_host_state &state );

struct give_result {
    std::string response;
    bool transferred = false;
};
std::optional<std::string> make_give_request( const item_location &source, const player_id &target,
        pickup_client_state &state );
give_result execute_give_request( Character &giver, Character *receiver, const JsonObject &request,
                                  pickup_host_state &state );
std::string make_inventory_update( const Character &who, pickup_host_state &state );

// A turn-local baseline: topology and cheap counters for all processed items,
// scalar payloads only for items that can change during native processing.
struct inventory_turn_item {
    int64_t parent = 0;
    int pocket = 0;
    int position = 0;
    int charges = 0;
    std::string type;
    std::string state;
};
struct inventory_turn_snapshot {
    std::map<int64_t, inventory_turn_item> items;
};
inventory_turn_snapshot capture_inventory_turn( Character &who );
std::optional<std::string> make_inventory_turn_update( Character &who,
        const inventory_turn_snapshot &before, pickup_host_state &state );
bool apply_inventory_turn_update( Character &who, const JsonObject &message,
                                  pickup_client_state &state );
} // namespace cata_mp

#endif // CATA_SRC_MP_PICKUP_H
