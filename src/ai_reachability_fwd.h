#pragma once
#ifndef CATA_SRC_AI_REACHABILITY_FWD_H
#define CATA_SRC_AI_REACHABILITY_FWD_H

class map;

namespace ai_reachability
{
class geometry_view;
struct snapshot;

// Owner-thread boundary; unsupported maps or invalid storage identities refuse
// admission. No borrowed map/submap pointers enter snapshot or worker outputs.
bool capture_geometry( const map &world, snapshot &values );
bool geometry_matches( const map &world, const snapshot &values );
} // namespace ai_reachability

#endif // CATA_SRC_AI_REACHABILITY_FWD_H
