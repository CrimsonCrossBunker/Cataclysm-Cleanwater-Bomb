#pragma once
#ifndef CATA_SRC_ANDROID_HUD_H
#define CATA_SRC_ANDROID_HUD_H

#include <string>
#include <vector>

class avatar;

/**
 * Android game state is published by the game thread and read as an immutable
 * JSON snapshot by the Android UI thread.  Named HUD actions use the
 * platform-neutral input_context_actions transport instead of living here.
 */
namespace android_hud
{

struct minimap_rect {
    int x = 0;
    int y = 0;
    int width = 0;
    int height = 0;
    bool visible = false;
};

void set_minimap_rect( const minimap_rect &rect );
minimap_rect get_minimap_rect();
void set_subscriptions( const std::vector<std::string> &sources );

void publish_snapshot( const avatar &player, int safe_mode );
void clear_snapshot();
std::string snapshot_json();

} // namespace android_hud

#endif // CATA_SRC_ANDROID_HUD_H
