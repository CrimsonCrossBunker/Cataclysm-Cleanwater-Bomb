#pragma once
#ifndef CATA_SRC_MP_PEEK_H
#define CATA_SRC_MP_PEEK_H

#include <cstdint>
#include <optional>

#include "character_id.h"
#include "coordinates.h"

class Character;
class JsonObject;
class JsonOut;
class map;

namespace cata_mp
{
// Created only after the owner pays. The request identity is scoped to its peer.
struct peek_authorization {
    character_id owner;
    int64_t request = 0;
    tripoint_abs_ms origin;
    tripoint_abs_ms target;
    tripoint_abs_ms viewpoint;
    int z_range = 0;
    bool over_ledge = true;
    int direction = 0;
    bool standing = false;
    bool valid_for( const Character &who, const map &here ) const;
    bool contains( const tripoint_abs_ms &position, int radius ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};
std::optional<peek_authorization> authorize_ledge_peek( Character &who, map &here,
        const tripoint_abs_ms &origin, const tripoint_abs_ms &ledge, int64_t request );
std::optional<peek_authorization> authorize_peek( Character &who, map &here,
        const tripoint_abs_ms &origin, const tripoint_abs_ms &target, int direction, int64_t request );
} // namespace cata_mp

#endif // CATA_SRC_MP_PEEK_H
