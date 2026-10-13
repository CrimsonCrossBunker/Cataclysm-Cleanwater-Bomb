#pragma once
#ifndef CATA_SRC_SPRITE_SUBMISSION_H
#define CATA_SRC_SPRITE_SUBMISSION_H

#if defined(TILES)
#include "sdl_wrappers.h"
#include "sprite_draw_command.h"

class texture;

// Owner-only, immediate GPU binding. The caller pins its tileset and verifies
// bundle identity, pending recovery and current resource epochs before calling.
// This binding is not a worker input and never appears in a semantic view.
struct sprite_asset_binding {
    const SDL_Renderer_Ptr &renderer;
    const texture &sprite;
    const texture *silhouette;
    bool direct3d = false;
};

bool submit_sprite_command( const sprite_draw_command &command, const sprite_asset_binding &binding,
                            render_command_order &order, render_resource_stamp current, int &height_3d );
#endif // TILES
#endif // CATA_SRC_SPRITE_SUBMISSION_H
