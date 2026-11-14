#pragma once
#ifndef CATA_SRC_HACKSAW_ACTIVITY_H
#define CATA_SRC_HACKSAW_ACTIVITY_H

#include "coords_fwd.h"

class Character;
class item;
class item_location;
struct mounted_tool_source;

// Preview duration/resumed progress without assigning an activity or consuming RNG.
bool query_hacksaw_work( Character &who, const item &tool, const tripoint_abs_ms &target,
                         const mounted_tool_source *mounted = nullptr );
bool start_hacksaw_work( Character &who, const item_location &tool,
                         const tripoint_abs_ms &target, const mounted_tool_source *mounted = nullptr );

#endif // CATA_SRC_HACKSAW_ACTIVITY_H
