#pragma once
#ifndef CATA_SRC_ANDROID_HUD_H
#define CATA_SRC_ANDROID_HUD_H

#include <string>
#include <string_view>
#include <vector>

#include "point.h"

class avatar;

/**
 * Android game state is published by the game thread and read as an immutable
 * JSON snapshot by the Android UI thread.  Named HUD actions use the
 * platform-neutral input_context_actions transport instead of living here.
 */
namespace android_hud
{

/** Rectangle in Android HUD-overlay pixels plus the coordinate-space size. */
struct minimap_rect {
    point origin = point::zero;
    int width = 0;
    int height = 0;
    int viewport_width = 0;
    int viewport_height = 0;
    bool visible = false;
};

void set_minimap_rect( const minimap_rect &rect );
minimap_rect get_minimap_rect();
/** Accepts the bounded schema-2 JSON request document produced by Android. */
void set_subscriptions( std::string_view requests_json );

void publish_snapshot( const avatar &player, int safe_mode );
void clear_snapshot();
/**
 * Serialize a frame; the large source catalog is included only when the
 * caller's cached catalog revision is stale.
 */
std::string snapshot_json( int known_catalog_revision = -1 );
/** On-demand Widget tree descriptor for the per-node layout editor. */
std::string layout_schema_json( std::string_view source_id );

} // namespace android_hud

#endif // CATA_SRC_ANDROID_HUD_H
