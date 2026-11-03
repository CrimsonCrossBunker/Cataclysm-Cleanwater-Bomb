#pragma once
#ifndef CATA_SRC_MP_RELOAD_H
#define CATA_SRC_MP_RELOAD_H

#include <cstdint>
#include <memory>
#include <string>

class Character;
class item;
class item_location;
class JsonObject;
class map;
class player_activity;

namespace cata_mp
{
struct pickup_host_state;
struct reload_host_state {
    int64_t last_request = 0;
    bool needs_placement = false;
};
struct reload_client_state {
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

bool owns_reload_activity( const Character &who );
bool reload_activity_view( const player_activity &activity );
std::string execute_reload_request( Character &who, map &here, const JsonObject &request,
                                    reload_host_state &state, pickup_host_state &inventory, bool authorized = true );
bool apply_reload_result( const JsonObject &response );
void client_start_reload( const item_location &selected, const item_location &target,
                          const item_location &ammo, int quantity, int pocket,
                          bool allow_theft, bool allow_hammer );
void client_step_reload();
void client_cancel_reload();
void client_update_reload_view();
} // namespace cata_mp
#endif // CATA_SRC_MP_RELOAD_H
