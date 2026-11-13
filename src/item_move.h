#pragma once
#ifndef CATA_SRC_ITEM_MOVE_H
#define CATA_SRC_ITEM_MOVE_H

#include <cstdint>
#include <utility>
#include <vector>

#include "item_location.h"
#include "item_source.h"
#include "tool_activity_target.h"

class Character;
class JsonObject;
class JsonOut;
class map;
class player_activity;

enum class item_move_destination { ground, cargo, prefer_cargo };

struct item_move_selection {
    tripoint_abs_ms origin;
    tool_activity_target target;
    int64_t cargo = 0;
    bool dropping = false;
    std::vector<std::pair<item_source, int>> items;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool submit_client_item_move( Character &who, const drop_locations &items,
                              const tripoint_bub_ms &target, item_move_destination mode, bool dropping );
bool start_owned_item_move( Character &who, map &here, item_move_selection selection );
void do_owned_item_move( Character &who, player_activity &activity, item_move_selection &selection );
void append_item_move_tiles( const item_move_selection &selection,
                             std::vector<tripoint_abs_ms> &changed_tiles );

#endif // CATA_SRC_ITEM_MOVE_H
