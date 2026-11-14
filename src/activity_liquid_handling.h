#pragma once
#ifndef CATA_SRC_ACTIVITY_LIQUID_HANDLING_H
#define CATA_SRC_ACTIVITY_LIQUID_HANDLING_H

#include <vector>

class Character;
class item;
class item_location;
struct unload_liquid_choice;

namespace activity_handlers
{
// Results are real saved map items. The owning activity validates its operator
// before calling these helpers; cancellation never deletes unhandled liquid.
const item *pending_activity_liquid( Character &who, const std::vector<item_location> &pending );
bool apply_activity_liquid_choice( Character &who, std::vector<item_location> &pending,
                                   const unload_liquid_choice &choice, bool allow_consequences );
// Prune stale handles and handle or wait for one choice. True means the caller
// must return without accessing actor state that a callback may have retired.
bool process_activity_liquids( Character &who, std::vector<item_location> &pending );
}

#endif // CATA_SRC_ACTIVITY_LIQUID_HANDLING_H
