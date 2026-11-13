#pragma once
#ifndef CATA_SRC_ARC_FURNACE_H
#define CATA_SRC_ARC_FURNACE_H

#include <cstdint>
#include <utility>
#include <vector>

#include "tool_activity_target.h"

class Character;
class JsonObject;
class JsonOut;
class map;

namespace arc_furnace
{
// New arc furnaces use the appliance crafting recipe. This state is retained
// for furnaces that were already firing in a saved world.
struct completion {
    tripoint_abs_ms origin;
    tool_activity_target target;
    std::vector<std::pair<int64_t, int>> batch;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool inspect( Character &who, map &here, const tripoint_bub_ms &tile, completion &choice );
bool finish( Character &who, map &here, const completion &choice );
} // namespace arc_furnace

#endif // CATA_SRC_ARC_FURNACE_H
