#pragma once
#ifndef CATA_SRC_WALKING_H
#define CATA_SRC_WALKING_H

#include <cstdint>
#include <optional>
#include <utility>
#include <vector>

#include "coordinates.h"
#include "character_id.h"
#include "safe_reference.h"
#include "type_id.h"
#include "world_position.h"

class JsonOut;
class JsonObject;
class vehicle;
class Character;
class map;

// Horizontal movement intent in fixed-point units. One input can traverse
// at most half a tile and can enter only one new gameplay cell.
struct fractional_walk {
    static constexpr int max_distance = world_position::tile_center;
    world_position target;
    point displacement;
    int distance;

    static bool is_valid( const point &delta );
    static point camera_delta( const point &screen, const point &forward );
    static std::optional<fractional_walk> resolve( const world_position &from, const point &delta );
    bool clears_obstacles( const map &here, const Character &who,
                           const tripoint_bub_ms &landing ) const;
    int scale_cost( int full_tile_cost ) const;
};

// Local route continuation waiting for one authoritative movement result.
// The route generation prevents an old response from reviving a canceled or
// replaced route, even when the player selects the same destination again.
struct automove_step {
    character_id owner;
    uint64_t generation = 0;
    tripoint_abs_ms origin;
    tripoint_abs_ms target;
    safe_reference<map> context;
    ter_id terrain;
    furn_id furniture;
    std::pair<int64_t, int64_t> vehicle_door;
    void finish( Character &who, map &here, bool cancelled ) const;
};
std::optional<automove_step> capture_automove_step( Character &who, map &here,
        const tripoint_abs_ms &target, bool allow_unrouted = false );

// Choices collected by the operator's UI. The movement code still checks the
// current actor, tile and vehicle; these flags never authorize another actor.
// A remote operation must supply choices instead of opening a host-side prompt.
struct walk_move_choices {
    bool allow_danger = false;
    bool allow_theft = false;
    bool allow_swimming = false;
    bool allow_dismount = false;
    std::optional<tripoint_abs_ms> destination;
    std::vector<int64_t> theft_vehicles;

    bool permits_theft( const vehicle &target ) const;
    bool confirms( const tripoint_abs_ms &target ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

#endif // CATA_SRC_WALKING_H
