#pragma once
#ifndef CATA_SRC_SPRITE_DRAW_COMMAND_H
#define CATA_SRC_SPRITE_DRAW_COMMAND_H

#include <array>
#include <cstdint>
#include <optional>

#include "render_command_order.h"
#include "sprite_geometry.h"

// Owned output of resource/geometry preparation. Texture handles and bindings
// stay with the renderer owner; neither a world object nor an SDL handle enters
// the command. Destination/bounds are before platform-specific SDL adjustments.
struct sprite_draw_command {
    render_command_ticket ticket;
    int sprite_index = 0;
    sprite_geometry_result geometry;
    int height_delta = 0;
    std::optional<std::array<std::uint8_t, 4>> gray_overlay;
};

#endif // CATA_SRC_SPRITE_DRAW_COMMAND_H
