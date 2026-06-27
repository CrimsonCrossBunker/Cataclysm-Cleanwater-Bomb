#pragma once
#ifndef CATA_SRC_SCT_EFFECT_H
#define CATA_SRC_SCT_EFFECT_H

#include <string>

#include "coords_fwd.h"
#include "color.h"
#include "transient_effect.h"

// Scrolling Combat Text — a short floating text label that rises from a tile
// and fades out.  Independent of the message log; purely visual.
struct sct_effect {
    effect_handle handle = 0;
    tripoint_bub_ms pos;
    std::string text;
    nc_color color = c_white;
    float duration_ms = 800.0f;      // total life before fade-out
    float elapsed_ms = 0.0f;
    float rise_speed_px_per_s = 30.0f; // screen-space vertical rise
    float screen_y_offset = 0.0f;    // current screen-y offset in pixels
};

#endif
