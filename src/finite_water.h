#pragma once

#include "coords_fwd.h"

class item;

enum class water_source_kind {
    none,
    fresh_infinite,
    salt_infinite,
    fresh_finite,
    conflict,
};

namespace finite_water
{

// Trace the excavated waterway at p.  Dry channels remain open parts of the
// route and can carry water again when a source is connected.  If
// connect_target is true, pretend that p is one proposed channel tile joining
// its four neighbors.
water_source_kind check_connection( const tripoint_abs_ms &p, bool connect_target );

// Return a temporary liquid item representing the shared amount in the
// connected finite body.  The liquid remains in the map until explicitly
// withdrawn, so canceling a transfer does not consume it.
item finite_liquid_from( const tripoint_abs_ms &p );
int withdraw_finite_liquid( const tripoint_abs_ms &p, int amount );

// Pour fresh water into the connected finite pond or conventional swimming
// pool at p.  Excess liquid remains in its original container.
int pour_into_finite_water( const tripoint_abs_ms &p, item &liquid );

// Recompute water across the whole excavated route.  Endless sources fill all
// connected channels; finite bodies redistribute their existing amount
// without creating water.
void refresh_connected_water( const tripoint_abs_ms &p );

// Complete a newly dug connector and refresh every open channel it reaches.
void fill_channel_at( const tripoint_abs_ms &p );

bool is_pond_or_pool_tile( const tripoint_abs_ms &p );

} // namespace finite_water
