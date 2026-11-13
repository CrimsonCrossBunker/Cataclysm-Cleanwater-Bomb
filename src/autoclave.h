#pragma once
#ifndef CATA_SRC_AUTOCLAVE_H
#define CATA_SRC_AUTOCLAVE_H

#include <cstdint>
#include <optional>
#include <utility>
#include <vector>

#include "craft_command.h"
#include "tool_activity_target.h"

class Character;
class JsonObject;
class JsonOut;
class map;

namespace autoclave
{
enum class operation { start, finish };

struct command {
    operation action = operation::start;
    tripoint_abs_ms origin;
    tool_activity_target target;
    std::vector<std::pair<int64_t, itype_id>> batch;
    std::vector<comp_selection<item_comp>> components;
    std::vector<comp_selection<tool_comp>> tools;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

std::optional<command> inspect( Character &who, map &here, const tripoint_bub_ms &tile,
                                operation action );
bool confirm_start( Character &who, command &choice );
bool execute( Character &who, map &here, const command &choice,
              std::vector<tripoint_abs_ms> *changed_tiles = nullptr );
} // namespace autoclave

#endif // CATA_SRC_AUTOCLAVE_H
