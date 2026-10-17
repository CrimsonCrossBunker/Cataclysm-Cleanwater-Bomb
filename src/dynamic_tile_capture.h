#pragma once
#ifndef CATA_SRC_DYNAMIC_TILE_CAPTURE_H
#define CATA_SRC_DYNAMIC_TILE_CAPTURE_H

#include <array>
#include <map>
#include <vector>

#include "coords_fwd.h"
#include "dynamic_tile_view.h"
#include "type_id.h"

class map;

// Immediate owner-only reads. No asset/backend work occurs here. Item capture
// is requested lazily only after a context entry exists in the tileset, so an
// ordinary empty tile does not traverse or allocate an item-stack snapshot.
dynamic_tile_context capture_dynamic_tile_context( const map &here, const tripoint_bub_ms &pos );
std::vector<field_render_view> capture_field_render_views( map &here, const tripoint_bub_ms &pos,
        field_type_id primary, const std::array<bool, 5> &invisible,
        const std::map<tripoint_bub_ms, field_type_id> &overrides );
std::vector<item_layer_view> capture_item_layer_views( const map &here,
        const tripoint_bub_ms &pos );

#endif // CATA_SRC_DYNAMIC_TILE_CAPTURE_H
