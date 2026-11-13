#pragma once
#ifndef CATA_SRC_CHARCOAL_KILN_H
#define CATA_SRC_CHARCOAL_KILN_H

#include <cstdint>

#include "coordinates.h"
#include "tool_activity_target.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class map;

namespace charcoal_kiln
{
enum class operation : int { fire_bionic, inspect };

// A completed batch is identified by its unfinished charcoal. A stale
// examination cannot open a later batch in the same piece of furniture.
struct command {
    operation action = operation::inspect;
    tripoint_abs_ms origin;
    tool_activity_target target;
    int64_t batch = 0;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool is_idle( const furn_id &furniture );
bool prepare( Character &who, map &here, const tripoint_bub_ms &pos );
bool fire( Character &who, map &here, const tripoint_bub_ms &pos );
bool inspect( Character &who, map &here, const tripoint_bub_ms &pos );
command capture( const Character &who, map &here, const tripoint_bub_ms &pos, operation action );
bool execute( Character &who, map &here, const command &request );
} // namespace charcoal_kiln

#endif // CATA_SRC_CHARCOAL_KILN_H
