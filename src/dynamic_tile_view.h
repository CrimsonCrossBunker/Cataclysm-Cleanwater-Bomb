#pragma once
#ifndef CATA_SRC_DYNAMIC_TILE_VIEW_H
#define CATA_SRC_DYNAMIC_TILE_VIEW_H

#include <string>
#include <vector>

// Values captured by the world owner. Context metadata selection and sprite
// submission can retain these without retaining a field, item or maptile.
struct dynamic_tile_context {
    std::string furniture;
    std::string terrain;
    std::vector<std::string> furniture_flags;
    std::vector<std::string> terrain_flags;
};

struct field_render_view {
    std::string id;
    int intensity = 0;
    int subtile = 0;
    int rotation = 0;
    // Context layers historically connect using the primary displayed field,
    // even while walking another field. Preserve that separate decision.
    int context_subtile = 0;
    int context_rotation = 0;
};

struct item_layer_view {
    std::string id;
    std::string category;
    std::string variant;
    int seed = 0;
    bool same_type_as_uppermost = false;
};

#endif // CATA_SRC_DYNAMIC_TILE_VIEW_H
