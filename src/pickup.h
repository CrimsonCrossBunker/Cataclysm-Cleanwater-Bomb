#pragma once
#ifndef CATA_SRC_PICKUP_H
#define CATA_SRC_PICKUP_H

#include <vector>

#include "coordinates.h"
#include "item_location.h"
#include "point.h"
#include "units.h"

class Character;
class JsonObject;
class JsonOut;
class item;

namespace Pickup
{
// Simulation callers must not open a menu on somebody else's frontend.
enum class interaction {
    interactive,
    unattended
};

// Selection is owned by the simulation/UI thread. Network adapters must turn
// these locations into value identities before publishing a request.
struct selection {
    std::vector<item_location> targets;
    std::vector<int> quantities;
    bool autopickup = false;
};

/** Pick up information */
struct pick_info {
    explicit pick_info( int extra_moves_per_distance = 0, units::volume max_volume = -1_ml,
                        units::mass max_mass = -1_gram ) : extra_moves_per_distance( extra_moves_per_distance ),
        max_volume( max_volume ), max_mass( max_mass ) {}

    void serialize( JsonOut &jsout ) const;
    void deserialize( const JsonObject &jsobj );
    void set_src( const item_location &src_ );
    void set_dst( const item_location &dst_ );

    units::volume total_bulk_volume = 0_ml;
    item_location::type src_type = item_location::type::invalid;
    tripoint_bub_ms src_pos;
    item_location src_container;
    item_location dst;

    item_location highlight;

    int extra_moves_per_distance = 0;

    units::volume picked_up_volume = 0_ml;
    units::volume max_volume = -1_ml;
    units::mass picked_up_mass = 0_gram;
    units::mass max_mass = -1_gram;
};

/**
 * Returns `false` if the player was presented a prompt and decided to cancel the pickup.
 * `true` in other cases.
 */
bool do_pickup( std::vector<item_location> &targets, std::vector<int> &quantities,
                bool autopickup, bool &stash_successful, Pickup::pick_info &info );
bool do_pickup( Character &who, std::vector<item_location> &targets,
                std::vector<int> &quantities, bool autopickup, bool &stash_successful,
                Pickup::pick_info &info, interaction prompts );
bool query_thief( const item &it );

// Transfer a complete owned item to an adjacent character without a prompt on
// the receiver's frontend. Uses native obtain/relocation and charges the giver.
bool give_item( Character &giver, Character &receiver, item_location source );

enum from_where : int {
    from_cargo = 0,
    from_ground,
    prompt
};

/** Pick up items; 'g' or ',' or via examine() */
void autopickup( const tripoint_bub_ms &p );
/** Determines the cost of moving an item by a character. */
int cost_to_move_item( const Character &who, const item &it );
} // namespace Pickup
#endif // CATA_SRC_PICKUP_H
