#pragma once
#ifndef CATA_SRC_RENDER3D_H
#define CATA_SRC_RENDER3D_H

#if defined(TILES)

#include <optional>

#include "coords_fwd.h"
#include "point.h"

struct SDL_Renderer;
struct SDL_FRect;
class cata_tiles;

// Experimental 3D terrain renderer (P0). Renders the terrain around the view
// center as instanced cubes into an offscreen GPU texture, then composites it
// into the terrain window via SDL_Renderer. Everything it reads from the game
// is read-only; simulation code is untouched.
namespace render3d
{

// Call after the SDL_Renderer is (re)created and before it is destroyed.
void on_renderer_created( SDL_Renderer *renderer );
void on_renderer_destroyed();

// True once probing succeeded: GPU-device renderer plus loadable shaders.
bool available();

// available(), re-probing first if the renderer object changed (runtime
// renderer rebuild, or the option was toggled on after startup).
bool ensure_available( SDL_Renderer *renderer );

// Draws the 3D scene into the given pixel rect of the current render target.
// tiles provides tileset sprite lookups (atlas texture + uv); may be null,
// in which case everything falls back to flat hash colors.
void draw_terrain_window( SDL_Renderer *renderer, const SDL_FRect &dest,
                          const tripoint_bub_ms &center, cata_tiles *tiles );

// Top-down orbit camera: feed relative mouse motion (pixels) here.
void note_mouse_look( float dx, float dy );

// Camera zoom: feed mouse wheel ticks (+1/-1) here.
void note_mouse_wheel( float ticks );

// True while a middle-mouse drag holds relative mouse mode for orbiting.
bool mouse_captured();

// Converts a logical pixel (same space as the dest rect of draw_terrain_window)
// to the map tile under the cursor by unprojecting a camera ray onto the view
// level's ground plane. Also remembers the pixel as the hover position for the
// next frame's preselection box. Nullopt before the first frame / ray misses.
std::optional<tripoint_bub_ms> screen_to_tile( const point &logical_pixel );

// Game-driven cursors (targeting, construction, zones): cata_tiles forwards
// init_draw_cursor/init_draw_highlight here; consumed and cleared by the next
// draw_terrain_window call.
void push_cursor( const tripoint_bub_ms &p, bool highlight );

// Remaps one compass step between the screen frame (north = up on screen,
// east = screen right, what the movement keys name) and the map frame for
// the current camera yaw. Returns false (leaving dx/dy alone) when the 3D
// renderer is not the active view or the delta is not a unit compass step.
bool camera_screen_to_map_delta( int &dx, int &dy );
// The inverse: a map-frame step to the movement keys' screen frame.
bool camera_map_to_screen_delta( int &dx, int &dy );

// Enable/disable relative mouse mode for FP look. Idempotent.
void sync_mouse_capture( SDL_Renderer *renderer, bool want );

} // namespace render3d

#endif // TILES
#endif // CATA_SRC_RENDER3D_H
