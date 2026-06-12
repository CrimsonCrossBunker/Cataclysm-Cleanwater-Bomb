#pragma once
#ifndef CATA_SRC_EXPLOSION_LIGHT_H
#define CATA_SRC_EXPLOSION_LIGHT_H

#include <array>
#include <cstdint>
#include <string>
#include <string_view>
#include <vector>

#include "type_id.h"

class JsonObject;
struct explosion_light;
template <typename T> class generic_factory;

generic_factory<explosion_light> &get_all_explosion_lights();

// Plain RGBA sample, deliberately free of any SDL type so the color math can be
// unit-tested without a renderer. cata_tiles converts this to SDL_Color.
struct explosion_light_sample {
    uint8_t r = 0;
    uint8_t g = 0;
    uint8_t b = 0;
    uint8_t a = 0;
};

// A data-driven recipe for the modern explosion light overlay (phase one:
// colour/alpha light cover, no geometry distortion). Replaces the legacy
// expanding-sprite look with a blended colour block per tile. The blast sends
// three waves expanding outward from the epicentre: wave 1 paints color_a,
// wave 2 repaints color_b, wave 3 clears the tile (fast fade to transparent).
// Each wave's per-tile arrival is its radial distance plus a small random
// offset, so the wavefronts are irregular and — when the waves are spaced out
// in a big blast — read as distinct travelling rings. The light stays bright;
// dissipation is the clear wave sweeping through, not a global dimming.
struct explosion_light {
    public:
        void load( const JsonObject &jo, std::string_view src );
        void check() const;

        // Colours are explicit RGB triples (0-255) so the math stays renderer
        // independent. The blast runs three expanding waves out from the centre:
        // wave 1 paints color_a, wave 2 repaints color_b, wave 3 clears the tile
        // (fades it to transparent). Default = golden-yellow A, red B.
        std::array<uint8_t, 3> color_a = { { 255, 215, 70 } };
        std::array<uint8_t, 3> color_b = { { 210, 40, 0 } };
        // This is a light cover, so it is always translucent — never fully opaque.
        // A lit tile's opacity decays from alpha_a (the bright wave-1 flash) down
        // to alpha_b (the dimmer wave-2 glow) over its lit lifetime: the light
        // dims as it burns out, but stays brighter than the environment until the
        // clear wave takes it to zero. Keep both well under 255.
        uint8_t alpha_a = 150;
        uint8_t alpha_b = 70;
        // Progress a wavefront takes to sweep from the epicentre (d=0) to the rim
        // (d=1). Smaller = faster expansion.
        float wave_travel = 0.38f;
        // Progress gap between consecutive waves (A->B->clear). In a big blast this
        // separation is what makes the three rings read as distinct travelling
        // waves rather than one blink.
        float wave_gap = 0.25f;
        // Quick alpha ramp after a tile is first reached by wave 1 (so it appears
        // bright almost immediately rather than easing in).
        float rise = 0.05f;
        // Quick alpha fall when wave 3 (the clear wave) reaches a tile — the fast
        // "变透明" dissipation.
        float fade = 0.1f;
        // Short window over which the hue blends color_a -> color_b at wave 2.
        float blend = 0.05f;
        // Per-tile random offset on each wave's arrival time. Gives the wavefront
        // an irregular, non-circular edge and makes dissipation pick tiles in a
        // jittered (not perfectly concentric) order. 0 = perfectly concentric.
        float spread_jitter = 0.07f;
        // Small per-tile random colour offset (fraction of 255) for texture/grain.
        // Deliberately tiny — just enough to break up flat fills.
        float color_jitter = 0.05f;
        // Irregular flicker magnitude (0 = smooth, >0 randomises per-tile per-frame
        // alpha/brightness to give the fire an uneven, live edge).
        float flicker = 0.18f;


        // --- Phase two: screen-space shockwave distortion --------------------
        // A CPU-driven refraction ring that warps the already-rendered frame at
        // present time (see shockwave.h / the shockwave-distortion plan). Purely
        // a visual add-on: when unsupported (curses, no RenderGeometryRaw) it is
        // silently skipped and the light overlay still plays.
        bool shockwave = false;
        // Peak UV displacement, as a fraction of a tile's size (converted to
        // pixels at blast time). 0 = no distortion.
        float shockwave_strength = 0.0f;
        // Ring expansion speed relative to the light's own outward sweep. 1 = the
        // ring reaches the rim as the light does; >1 = faster.
        float shockwave_speed = 1.0f;
        // Radial half-width of the refracted band, as a fraction of a tile's size.
        float shockwave_thickness = 1.5f;

        // Compute the light sample for a tile.
        //   radial:    0 at the epicentre, 1 at the rim. Drives wave arrival time.
        //   progress:  0 at blast start, 1 at animation end.
        //   tile_seed: stable per-tile value (constant across frames) — drives the
        //              per-tile spread jitter and colour grain so the wavefront
        //              edge is irregular but doesn't shimmer between frames.
        //   frame_seed:per-tile/per-frame value — drives the live flicker only.
        // Pure function: no SDL, no globals — unit-tested directly.
        explosion_light_sample sample( float radial, float progress, uint32_t tile_seed,
                                       uint32_t frame_seed ) const;

        // Used by generic_factory
        explosion_light_str_id id;
        std::vector<std::pair<explosion_light_str_id, mod_id>> src;
        bool was_loaded = false;
};

namespace explosion_lights
{

void load( const JsonObject &jo, const std::string &src );
void check_consistency();
void reset();

const std::vector<explosion_light> &get_all();

// The built-in recipe used when an explosion does not name one. Resolved lazily
// so it works whether or not data has finished loading.
extern const explosion_light_str_id default_blast;

// Reserved light_effect id that opts a blast back into the legacy expanding-sprite
// animation instead of the modern overlay. Not a real explosion_light definition;
// intercepted by name in draw_custom_explosion. Kept as a single named constant so
// the sentinel can't drift between its use site and the data it documents.
inline constexpr std::string_view legacy_sprite_id = "legacy_sprite";

} // namespace explosion_lights

#endif // CATA_SRC_EXPLOSION_LIGHT_H
