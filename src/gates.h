#pragma once
#ifndef CATA_SRC_GATES_H
#define CATA_SRC_GATES_H

#include <string>
#include <vector>

#include "coords_fwd.h"
#include "translation.h"
#include "type_id.h"

class Character;
class Creature;
class JsonObject;
class map;

namespace cata::lua_platform
{
class content_transaction;
} // namespace cata::lua_platform

struct gate_data;
using gate_id = string_id<gate_data>;

struct gate_data {
    friend class cata::lua_platform::content_transaction;

    gate_data() :
        moves( 0 ),
        bash_dmg( 0 ),
        was_loaded( false ) {}

    gate_id id;
    std::vector<std::pair<gate_id, mod_id>> src;

    ter_str_id door;
    ter_str_id floor;
    std::vector<ter_str_id> walls;

    translation pull_message;
    translation open_message;
    translation close_message;
    translation fail_message;

    int moves;
    int bash_dmg;
    bool was_loaded;

    void load( const JsonObject &jo, std::string_view src );
    void check() const;

    bool is_suitable_wall( const tripoint_bub_ms &pos ) const;
};

namespace gates
{

void load( const JsonObject &jo, const std::string &src );
void finalize();
void check();
void reset();

/** opens the gate via player's activity */
void open_gate( const tripoint_bub_ms &pos, Character &p );
/** opens the gate immediately */
void open_gate( const tripoint_bub_ms &pos );

} // namespace gates

namespace doors
{

/**
 * Checks whether a monster is blocking a position, which will prevent a door from closing.
 * Prints a message if the check is on behalf of the player.
*/
bool check_mon_blocking_door( const Creature &who, const tripoint_abs_ms &p );

/**
 * Handles deducting moves, printing messages (only non-NPCs cause messages), actually closing it,
 * checking if it can be closed, etc.
*/
void close_door( map &m, Creature &who, const tripoint_bub_ms &closep );
/**
 * Forcefully closes a door
 * Checks for creatures/items/vehicles at the door tile and attempts to displace them, dealing bash damage.
 * If something remains that prevents the door from closing
 * (e.g. a very big creatures, a vehicle) the door will not be closed
 * @param p position gate is closed from, usually the player's position
 * @param affected_tiles positions of any tiles that are being closed alongside this one
 * @param bash_dmg controls how much damage the door does to the creatures/items/vehicle.
 * If bash_dmg is smaller than 0, _every_ item on the door tile will prevent the door from closing.
 * If bash_dmg is 0, only very small items will do so
 * If bash_dmg is greater than 0, items won't stop the door from closing at all.
 * @returns true if the door can successfully be closed
*/
bool forced_door_closing( const tripoint_bub_ms &p, std::vector<tripoint_bub_ms> affected_tiles,
                          const ter_id &door_type, int bash_dmg );
/**
 * Locks a door at "lockp" as "who."
 *
 * Involves deducting moves, printing messages (only non-NPCs can cause messages),
 * checking if it is locked, performing the action, making sounds, etc.
 * @param check_only prevents actions and returns whether a door can be locked here
 *
 * @returns whether a door was actually locked
 */
bool lock_door( map &m, Creature &who, const tripoint_bub_ms &lockp );

/**
 * Unlocks a door at "lockp" as "who."
 *
 * Involves printing messages (only non-NPCs can cause messages), actually unlocking it,
 * checking if it is locked, performing the action, making sounds, etc.
 *
 * @returns whether a door was actually unlocked
 */
bool unlock_door( map &m, Creature &who, const tripoint_bub_ms &lockp );

/**
* Whether a door at "lockp" can be locked by "who."
*/
bool can_lock_door( const map &m, const Creature &who, const tripoint_bub_ms &lockp );
/**
* Whether a door at "lockp" can be unlocked by "who."
*/
bool can_unlock_door( const map &m, const Creature &who, const tripoint_bub_ms &lockp );

} // namespace doors

#endif // CATA_SRC_GATES_H
