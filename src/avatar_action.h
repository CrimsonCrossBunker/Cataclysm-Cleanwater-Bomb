#pragma once
#ifndef CATA_SRC_AVATAR_ACTION_H
#define CATA_SRC_AVATAR_ACTION_H

#include <optional>
#include <string>

#include "coordinates.h"
#include "walking.h"

class Character;
class avatar;
class item;
class item_location;
class map;
class monster;
class turret_data;
struct walk_move_choices;

namespace avatar_action
{

/** Eat food or fuel  'E' (or 'a') */
void eat( avatar &you, item_location &loc );

// special rules for eating: grazing etc
// returns false if no rules are needed
bool eat_here( avatar &you );
void eat_or_use( avatar &you, item_location loc );

// Standard movement; handles attacks, traps, &c. Returns false if auto move
// should be canceled
bool move( avatar &you, map &m, const tripoint_rel_ms &d );
// Shared native simulation. Explicit choices never open the host player's UI.
bool move( Character &you, map &m, const tripoint_rel_ms &d,
           const walk_move_choices *choices );
bool move_fractional( Character &you, map &m, const point &delta,
                      const walk_move_choices *choices = nullptr );
bool can_move_fractional( const Character &you, const map &here );
std::optional<walk_move_choices> query_walk( avatar &you, map &m, const tripoint_rel_ms &d,
        const fractional_walk *step = nullptr );
/** Handles swimming by the player. Called by avatar_action::move(). */
void swim( map &m, avatar &you, const tripoint_bub_ms &p );
void swim( map &m, Character &you, const tripoint_bub_ms &p,
           const walk_move_choices *choices, const fractional_walk *step = nullptr );

bool confirm_non_hostile_melee_attack( avatar &you, const monster &critter );
void autoattack( avatar &you, map &m );
void active_technique( avatar &you, map &m );
/** Whether the currently wielded weapon offers a usable mounted charge. */
bool mounted_charge_available( const avatar &you );
void mounted_charge( avatar &you );

void mend( avatar &you, item_location loc );

/**
 * Checks if the weapon is valid and if the player meets certain conditions for firing it.
 * Used for validating ACT_AIM and turret weapon
 * @return True if all conditions are true, otherwise false.
 */
bool can_fire_weapon( avatar &you, const map &m, const item &weapon );

/** Checks if the wielded weapon is a gun and can be fired then starts interactive aiming */
void fire_wielded_weapon( avatar &you,
                          const std::optional<tripoint_abs_ms> &initial_target = std::nullopt );

/** Stores fake gun specified by the mutation and starts interactive aiming */
void fire_ranged_mutation( Character &you, const item &fake_gun );

/** Stores fake gun specified by the bionic and starts interactive aiming */
void fire_ranged_bionic( avatar &you, const item &fake_gun, unsigned int uid );

/**
 * Checks if the player can manually (with their 2 hands, not via vehicle controls)
 * fire a turret and then starts interactive aiming.
 * Assumes that the turret is on player position.
 * @return true if attempt to fire was successful (aim then cancel is also considered success)
 */
bool fire_turret_manual( avatar &you, map &m, turret_data &turret );

// Throw an item  't'
void plthrow( avatar &you, item_location loc,
              const std::optional<tripoint_bub_ms> &blind_throw_from_pos = std::nullopt );

// Throw the wielded item
void plthrow_wielded( avatar &you,
                      const std::optional<tripoint_bub_ms> &blind_throw_from_pos = std::nullopt );

/**
 * Opens up a menu to Unload a container, gun, or tool
 * If it's a gun, some gunmods can also be loaded
 */
void unload( avatar &you );

// Use item; also tries E,R,W  'a'
void use_item( avatar &you, item_location &loc, std::string const &method = {} );
void use_item( avatar &you );

/** Check if avatar is stealing a weapon. */
bool check_stealing( Character &who, item &weapon );
} // namespace avatar_action

#endif // CATA_SRC_AVATAR_ACTION_H
