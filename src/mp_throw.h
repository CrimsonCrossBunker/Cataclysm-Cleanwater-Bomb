#pragma once
#ifndef CATA_SRC_MP_THROW_H
#define CATA_SRC_MP_THROW_H

#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include "coordinates.h"
#include "item_disposition.h"

class Character;
class item_location;
class map;

namespace cata_mp
{
struct throw_intent {
    tripoint_abs_ms origin;
    std::optional<tripoint_abs_ms> target;
    std::optional<tripoint_abs_ms> blind_from;
    std::string source;
    tripoint_abs_ms source_position;
    std::vector<int64_t> path;
    int64_t wielded = 0;
    bool allow_theft = false;
    std::optional<item_disposition> disposition;
};

// Selection records identities only. The host resolves them in its own world.
throw_intent make_throw_intent( const Character &who, item_location source );
bool throw_keeps_wielded( Character &who, const item_location &source );
bool can_prepare_throw( Character &who, const item_location &source );
bool execute_throw_intent( Character &who, map &here, const throw_intent &intent );
} // namespace cata_mp

#endif // CATA_SRC_MP_THROW_H
