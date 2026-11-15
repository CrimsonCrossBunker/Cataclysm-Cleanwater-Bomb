#pragma once
#ifndef CATA_SRC_STOOK_H
#define CATA_SRC_STOOK_H

#include <cstdint>
#include <optional>
#include <vector>

#include "tool_activity_target.h"

class Character;
class JsonObject;
class JsonOut;
class map;

namespace stook
{
enum class operation { stand, harvest };

struct grain_stack {
    int64_t uid = 0;
    itype_id type;
    int count = 0;

    bool operator==( const grain_stack &other ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct command {
    operation action = operation::stand;
    tripoint_abs_ms origin;
    tool_activity_target target;
    std::vector<grain_stack> batch;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

std::optional<command> inspect( Character &who, map &here, const tripoint_bub_ms &tile,
                                operation action );
bool execute( Character &who, map &here, const command &choice );
} // namespace stook

#endif // CATA_SRC_STOOK_H
