#pragma once
#ifndef CATA_SRC_MP_FIREARM_H
#define CATA_SRC_MP_FIREARM_H

#include <cstdint>
#include <string>
#include <optional>
#include <memory>

#include "coordinates.h"
#include "type_id.h"
#include "mp_item_source.h"

class Character;
class item;
class map;

namespace cata_mp
{
enum class firearm_outcome { rejected, aiming, finished };

struct firearm_intent {
    std::string action;
    int64_t weapon = 0;
    gun_mode_id mode;
    tripoint_abs_ms origin;
    tripoint_abs_ms target;
    std::optional<item_source> ammo;
    unsigned int bionic = 0;
    int64_t request = 0;
    int burst_rounds = 0;
};

// One owned shooter's aiming session; never shared between peers or worlds.
struct firearm_state {
    int64_t weapon = 0;
    int64_t checked_turn = -1;
    bool activity_started = false;
    unsigned int bionic = 0;
    // Keep the native fake gun across AIM_AFTER_FIRING, never in inventory.
    std::shared_ptr<item> bionic_weapon;
    // Installed source identity is distinct from the temporary gun copy.
    int64_t bionic_weapon_source = 0;
    int64_t last_request = 0;
};

enum class firearm_view_phase { inactive, preparing, pending, aiming, finished, rejected };
struct firearm_view_state {
    int64_t weapon = 0;
    firearm_view_phase phase = firearm_view_phase::inactive;
    unsigned int bionic = 0;
    int64_t next_request = 1;
    int64_t pending_request = 0;
    std::shared_ptr<item> bionic_preview;
};

bool supports_firearm_intents( const item &weapon );
const item *bionic_firearm_source( const Character &who, unsigned int uid );
void finish_firearm_activity( Character &who, firearm_state &state, bool canceled,
                              bool unload_ras = false );
firearm_outcome execute_firearm_intent( Character &who, map &here,
                                        firearm_state &state, const firearm_intent &intent );
} // namespace cata_mp
#endif // CATA_SRC_MP_FIREARM_H
