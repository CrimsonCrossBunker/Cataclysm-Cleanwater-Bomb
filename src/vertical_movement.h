#pragma once
#ifndef CATA_SRC_VERTICAL_MOVEMENT_H
#define CATA_SRC_VERTICAL_MOVEMENT_H

#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include "coordinates.h"
#include "item_disposition.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class map;

// Owner-selected decisions only. Native movement derives destinations, costs,
// available aids and collisions again; force is never a client-supplied choice.
struct vertical_move_choices {
    std::optional<tripoint_abs_ms> landing;
    std::optional<tripoint_rel_ms> drag_direction;
    int64_t wielded_uid = 0;
    std::optional<item_disposition> unwield;
    bool allow_danger = false;
    bool allow_blocker = false;
    bool allow_one_way = false;
    std::string drop_aid;
    bool detach_vine = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct vertical_move_selection {
    tripoint_abs_ms origin;
    tripoint_abs_ms target;
    std::string action = "stairs";
    int direction = 0;
    int64_t vehicle = 0;
    int64_t part = 0;
    climbing_aid_id aid;
    furn_str_id furniture;
    vertical_move_choices choices;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

// A bounded, read-only description of native choices. It contains no map replica:
// a client can choose stairs even when the destination floor is not synchronized.
struct vertical_move_option {
    vertical_move_selection selection;
    std::string label;
    std::string confirmation;
    bool enabled = true;
    bool unwield = false;
    bool blocker = false;
    bool danger = false;
    bool one_way = false;
    bool detach_vine = false;
    bool drag = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

struct vertical_move_prompt {
    tripoint_abs_ms origin;
    std::string title;
    std::vector<vertical_move_option> options;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
    std::optional<vertical_move_selection> query( Character &who ) const;
};

vertical_move_prompt make_vertical_move_prompt( Character &who, map &here, int direction );
std::optional<tripoint_abs_ms> ledge_peek_position( const Character &who, const map &here,
        const tripoint_abs_ms &ledge );
std::vector<tripoint_abs_ms> peek_destinations( const Character &who, const map &here,
        int direction );
vertical_move_prompt make_peek_prompt( const Character &who, const map &here, int direction );
vertical_move_prompt make_ledge_move_prompt( Character &who, map &here,
        const tripoint_bub_ms &ledge );
vertical_move_prompt make_climb_down_prompt( Character &who, map &here,
        const tripoint_bub_ms &ledge );

std::vector<tripoint_bub_ms> climb_up_destinations( const Character &who, const map &here,
        const tripoint_bub_ms &above );
std::optional<vertical_move_selection> query_vertical_move( Character &who, map &here,
        int direction );
std::optional<vertical_move_selection> query_climb_down( Character &who, map &here,
        const tripoint_bub_ms &ledge );
bool execute_vertical_move( Character &who, map &here, const vertical_move_selection &choice );

#endif // CATA_SRC_VERTICAL_MOVEMENT_H
