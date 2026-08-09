#pragma once

#include "coords_fwd.h"

class item;

enum class water_source_kind {
    none,
    fresh_infinite,
    salt_infinite,
    fresh_finite,
    salt_finite,
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

// Stable key for de-duplicating one connected finite body when several of its
// tiles are scanned for crafting sources.
tripoint_abs_ms finite_liquid_body_anchor( const tripoint_abs_ms &p );

// Pour matching liquid into a connected finite body at p.  Excavated channels
// accept fresh or salt water.  Excess remains in its original container.
int pour_into_finite_water( const tripoint_abs_ms &p, item &liquid );

// True when liquid poured onto p should be stored in a finite body or
// excavated channel instead of becoming a loose ground item.
bool can_pour_into( const tripoint_abs_ms &p );

// Core lake/river/ocean tiles and finite bodies have source behavior decided
// by this module.  Item-backed sources such as toilets and puddles retain
// their ordinary map behavior.
bool manages_liquid_source( const tripoint_abs_ms &p );

// Recompute water across the whole excavated route.  Endless sources fill all
// connected channels; finite bodies redistribute their existing amount
// without creating water.
void refresh_connected_water( const tripoint_abs_ms &p );

// Complete a newly dug connector and refresh every open channel it reaches.
void fill_channel_at( const tripoint_abs_ms &p );

// Re-evaluate each water route adjoining a tile that has just been filled in
// or otherwise closed.
void refresh_adjacent_waterways( const tripoint_abs_ms &p );

} // namespace finite_water
