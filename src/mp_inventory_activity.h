#pragma once
#ifndef CATA_SRC_MP_INVENTORY_ACTIVITY_H
#define CATA_SRC_MP_INVENTORY_ACTIVITY_H

#include <cstdint>
#include <memory>
#include <string>

struct insert_selection;
class Character;
class item;
class item_location;
class JsonObject;
class map;
class player_activity;

namespace cata_mp
{
struct pickup_host_state;
struct unload_intent;
struct inventory_activity_host_state {
    int64_t last_request = 0;
    bool needs_placement = false;
};
struct inventory_activity_client_state {
    int64_t next_request = 0;
    int64_t pending_request = 0;
    std::string activity;
    bool active = false;
    bool finished = false;
    bool cancel_requested = false;
    bool needs_placement = false;
    bool can_wield = false;
    std::shared_ptr<item> preview;
};

bool owns_inventory_activity( const Character &who );
bool inventory_activity_view( const player_activity &activity );
std::string execute_inventory_activity_request( Character &who, map &here,
        const JsonObject &request,
        inventory_activity_host_state &state, pickup_host_state &inventory, bool authorized = true );
bool apply_inventory_activity_result( const JsonObject &response );
void client_start_reload( const item_location &selected, const item_location &target,
                          const item_location &ammo, int quantity, int pocket,
                          bool allow_theft, bool allow_hammer );
void client_start_unload( const unload_intent &intent );
void client_start_insert( const insert_selection &selection );
void client_step_inventory_activity();
void client_cancel_inventory_activity();
void client_update_inventory_activity_view();
} // namespace cata_mp
#endif // CATA_SRC_MP_INVENTORY_ACTIVITY_H
