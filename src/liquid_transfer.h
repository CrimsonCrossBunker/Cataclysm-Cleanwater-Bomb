#pragma once
#ifndef CATA_SRC_LIQUID_TRANSFER_H
#define CATA_SRC_LIQUID_TRANSFER_H

#include <memory>
#include <optional>
#include <cstdint>
#include <vector>

#include "coords_fwd.h"

class Character;
class JsonValue;
class activity_actor;
class item_location;
class map;
class player_activity;
struct item_source;
struct tool_activity_target;
struct unload_liquid_choice;

void start_owned_liquid_transfer( Character &who, const item_source &source,
                                  const unload_liquid_choice &destination );
bool start_furniture_liquid_transfer( Character &who, map &here, const item_location &source,
                                      const tool_activity_target &station,
                                      const unload_liquid_choice &destination );
std::unique_ptr<activity_actor> deserialize_owned_liquid_transfer( JsonValue &data );
void append_owned_liquid_transfer_changes( const player_activity &activity,
        std::vector<tripoint_abs_ms> &tiles, std::vector<int64_t> &vehicles );

class item;
struct liquid_dest_opt;

namespace liquid_handler
{
/**
 * Execute a resolved liquid destination without opening a menu or starting an activity.
 * The caller owns source/access validation and removal of an exhausted source item.
 * A vehicle destination requires the previously selected tank part index.
 * Consumption is a separate action and is not accepted by this transfer operation.
 * As with the native handler, true means the destination was handled; inspect the
 * remaining charges for partial/full transfers (a full keg can consume an attempt).
 * Timed activities own movement costs and pass charge_moves=false.
 */
bool transfer_liquid( Character &who, item &liquid, liquid_dest_opt target,
                      std::optional<int> tank_part = std::nullopt, bool silent = true, bool charge_moves = true );
} // namespace liquid_handler
#endif // CATA_SRC_LIQUID_TRANSFER_H
