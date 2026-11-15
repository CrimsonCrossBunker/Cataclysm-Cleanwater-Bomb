#pragma once
#ifndef CATA_SRC_MILL_H
#define CATA_SRC_MILL_H

#include <cstdint>
#include <optional>
#include <vector>

#include "calendar.h"
#include "craft_command.h"
#include "tool_activity_target.h"
#include "units.h"

class Character;
class JsonObject;
class JsonOut;
class item;
class map;

namespace mill
{
inline constexpr units::volume capacity = 20_liter;
inline constexpr time_duration duration = 6_hours;
extern const itype_id clock_type;

enum class operation { start, load, unload, stop, recover };

struct stack_snapshot {
    int64_t uid = 0;
    itype_id type;
    int count = 0;

    bool operator==( const stack_snapshot &other ) const;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct command {
    operation action = operation::start;
    tripoint_abs_ms origin;
    tool_activity_target target;
    std::vector<stack_snapshot> contents;
    std::optional<comp_selection<item_comp>> input;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool is_active( const map &here, const tripoint_bub_ms &tile );
bool needs_recovery( map &here, const tripoint_bub_ms &tile );
bool can_operate( Character &who, map &here, const tripoint_bub_ms &tile );
bool accepts( const item &entry );
command inspect( Character &who, map &here, const tripoint_bub_ms &tile );
bool execute( Character &who, map &here, const command &choice,
              std::vector<tripoint_abs_ms> *changed_tiles = nullptr );
void finish( map &here, const tripoint_bub_ms &tile );
} // namespace mill

#endif // CATA_SRC_MILL_H
