#pragma once
#ifndef CATA_SRC_ANDROID_HUD_H
#define CATA_SRC_ANDROID_HUD_H

#include <string>
#include <vector>

class avatar;

/**
 * Android's native HUD is intentionally kept separate from the SDL input path.
 * Java submits named game actions and only the active input_context may consume
 * them.  Game state is published by the game thread and read as an immutable
 * JSON snapshot by the Android UI thread.
 */
namespace android_hud
{

bool enqueue_action( const std::string &action );
bool consume_action_for_context( const std::vector<std::string> &registered_actions,
                                 std::string &action );
void set_active_actions( const std::vector<std::string> &registered_actions );

void publish_snapshot( const avatar &player, int safe_mode );
std::string snapshot_json();

} // namespace android_hud

#endif // CATA_SRC_ANDROID_HUD_H
