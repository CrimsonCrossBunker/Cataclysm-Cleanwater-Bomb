#pragma once
#ifndef CATA_SRC_RANGED_ACTIONS_H
#define CATA_SRC_RANGED_ACTIONS_H

#include <optional>
#include <string>
#include <vector>

#include "coordinates.h"

class Character;
class gun_mode;
class item;
class map;

// Gameplay operations take an explicit actor. Keep these out of ranged.h,
// which is transitively included by the core Character declaration.
bool gunmode_checks_common( Character &who, const map &here,
                            std::vector<std::string> &messages, const gun_mode &mode );
bool gunmode_checks_weapon( Character &who, const map &here,
                            std::vector<std::string> &messages, const gun_mode &mode );

// Native firearm operations shared by local UI and authoritative remote input.
bool prepare_gun_to_fire( Character &who, item &gun );
void mark_ranged_target( Character &who, bool harmful );
double aim_turning_recoil( const Character &who, const tripoint_bub_ms &origin,
                           const std::optional<tripoint_bub_ms> &previous,
                           const tripoint_bub_ms &target );
void aim_gun_for_moves( Character &who, const item &gun, const tripoint_bub_ms &target,
                        int moves );
bool aim_gun_until_threshold( Character &who, const item &gun,
                              const tripoint_bub_ms &target, const std::string &action );

#endif // CATA_SRC_RANGED_ACTIONS_H
