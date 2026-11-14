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
class item_location;
class map;

// Gameplay operations take an explicit actor. Keep these out of ranged.h,
// which is transitively included by the core Character declaration.
bool gunmode_checks_common( Character &you, const map &m,
                            std::vector<std::string> &messages, const gun_mode &gmode );
bool gunmode_checks_weapon( Character &you, const map &m,
                            std::vector<std::string> &messages, const gun_mode &gmode );

// Native firearm operations shared by local UI and authoritative remote input.
bool prepare_gun_to_fire( Character &who, item &it );
int reload_and_shoot_time( const Character &p, const item_location &loc );
bool ready_ranged_ammo( Character &who, item &gun, const item_location &ammo );
bool unload_ready_ranged_ammo( Character &who, item &gun );
void mark_ranged_target( Character &you, bool harmful );
double aim_turning_recoil( const Character &you, const tripoint_bub_ms &src,
                           const std::optional<tripoint_bub_ms> &last_aim_pos,
                           const tripoint_bub_ms &dst );
void aim_gun_for_moves( Character &you, const item &weapon, const tripoint_bub_ms &target_pos,
                        int moves );
bool aim_gun_until_threshold( Character &you, const item &weapon,
                              const tripoint_bub_ms &dst, const std::string &action );
bool aim_gun_until_threshold( Character &you, const item &weapon,
                              const tripoint_bub_ms &dst, int threshold );

#endif // CATA_SRC_RANGED_ACTIONS_H
