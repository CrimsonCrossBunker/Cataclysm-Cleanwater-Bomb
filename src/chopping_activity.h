#pragma once
#ifndef CATA_SRC_CHOPPING_ACTIVITY_H
#define CATA_SRC_CHOPPING_ACTIVITY_H

#include "tool_activity_target.h"

struct item_activation_choices;
struct lumber_selection;

int chopping_work_moves( Character &who, const item &tool );
void chopping_work_sound( const player_activity &activity );
bool start_chopping_work( Character &who, const item_location &tool,
                          const tripoint_abs_ms &position, bool automatic = false );

// Native plank work spends one log when it starts, including on later cancel.
// Output is chosen by the native caller (operator tile or the zone's log tile).
// No client selects a duration, yield, skill or arbitrary output position.
bool query_lumber_choices( Character &who, item_activation_choices &choices );
bool start_plank_work( Character &who, const item_location &tool, const lumber_selection &selection,
                       std::optional<tripoint_abs_ms> output = std::nullopt, bool automatic = false );

#endif // CATA_SRC_CHOPPING_ACTIVITY_H
