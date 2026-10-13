#pragma once
#ifndef CATA_SRC_TILE_LAYER_CAPTURE_H
#define CATA_SRC_TILE_LAYER_CAPTURE_H

#if defined(TILES)
#include <array>
#include <map>
#include <optional>

#include "tile_layer_view.h"
#include "type_id.h"
#include "view_snapshot.h"

class avatar;
class map;

// Immediate owner query context. References never enter a view or a worker.
// Connection helpers address the current game map; this is not an interface for
// concurrent world traversal or for an independently constructed map.
struct tile_layer_capture_input {
    tripoint_bub_ms position;
    lit_level light;
    std::array<bool, 5> invisible;
    const tile_render_info::sprite &cached;
    bool night_vision = false;
    bool legacy_no_fog = false;
};

std::optional<tile_layer_view> capture_terrain_layer( map &here, const avatar &observer,
        const tile_layer_capture_input &input, const std::map<tripoint_bub_ms, ter_id> &overrides );
std::optional<tile_layer_view> capture_furniture_layer( map &here, const avatar &observer,
        const tile_layer_capture_input &input, const std::map<tripoint_bub_ms, furn_id> &overrides );
std::optional<tile_layer_view> capture_trap_layer( map &here, const avatar &observer,
        const tile_layer_capture_input &input, const std::map<tripoint_bub_ms, trap_id> &overrides );
#endif // TILES
#endif // CATA_SRC_TILE_LAYER_CAPTURE_H
