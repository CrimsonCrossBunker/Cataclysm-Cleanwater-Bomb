#pragma once
#ifndef CATA_SRC_LIQUID_TRANSFER_H
#define CATA_SRC_LIQUID_TRANSFER_H

#include <optional>

class Character;
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
