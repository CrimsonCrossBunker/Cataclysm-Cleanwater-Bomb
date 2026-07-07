#pragma once
#ifndef CATA_SRC_SCT_EFFECT_H
#define CATA_SRC_SCT_EFFECT_H

#include <string>

#include "color.h"
#include "coords_fwd.h"
#include "transient_effect.h"

/** Floating combat-text label that rises from a tile and fades out over real
 *  time.  Managed asynchronously by cata_tiles so the caller can fire-and-
 *  forget (no blocking wait).  Independent of the legacy overlay_strings SCT
 *  path and the message log.
 */
struct sct_effect {
    tripoint_bub_ms pos;       // world tile the label floats above
    std::string    text;       // displayed string
    nc_color       color = c_white;
    float duration_ms   = 800.0f;  // total life before expiry
    float elapsed_ms    = 0.0f;    // wall-clock ms since creation
    float rise_speed_px_per_s = 30.0f;
    float screen_y_offset     = 0.0f;  // current vertical offset in screen px

    effect_handle handle = 0;  // for cancel_effect(); zero until registered
};

#endif // CATA_SRC_SCT_EFFECT_H
