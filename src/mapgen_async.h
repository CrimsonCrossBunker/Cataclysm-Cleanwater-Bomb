#pragma once

#include "coordinates.h"
#include "point.h"

class map_extra;
template <typename T> class string_id;

using tripoint_abs_omt =
    coords::coord_point<tripoint, coords::origin::abs, coords::scale::overmap_terrain>;

/**
 * Deferred mapgen hooks and autonotes for worker-thread mapgen.
 *
 * When mapgen runs on a worker thread, side effects that touch non-thread-safe
 * singletons (auto-note, Lua hooks) are deferred here and drained on the main
 * thread.
 *
 * CCB: Lua integration is not yet ported.  The mapgen-hook mechanism is a stub.
 */

namespace mapgen_defer
{

/** Ensure hooks are emptied before new worker dispatch. */
void drain();

/** Push a deferred autonote from a worker thread (thread-safe). */
void push_autonote( const tripoint_abs_omt &pos, const string_id<map_extra> &extra );

} // namespace mapgen_defer
