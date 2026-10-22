#pragma once
#ifndef CATA_SRC_SLING_H
#define CATA_SRC_SLING_H

#include <optional>
#include <vector>

#include "coordinates.h"
#include "ret_val.h"

class Character;
class avatar;
class item;
class item_location;
struct dealt_projectile_attack;

bool is_sling_launcher( const item &weapon );
bool is_sling_ammunition( const item &ammo );
ret_val<void> can_launch_sling( const Character &who, const item_location &ammo );
int sling_launch_moves( const Character &who, const item_location &ammo );

/** A missing target means aiming was cancelled: no activation, cost or consumption. */
std::optional<dealt_projectile_attack> launch_sling( avatar &who, item_location ammo,
        const std::optional<tripoint_bub_ms> &target );

void aim_sling( avatar &who );

namespace target_handler
{
/** Direct sling launch with its full action cost. */
std::vector<tripoint_bub_ms> mode_sling( avatar &you, item &ammo, int moves );
} // namespace target_handler

#endif // CATA_SRC_SLING_H
