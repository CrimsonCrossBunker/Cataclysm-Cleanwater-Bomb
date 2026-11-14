#pragma once
#ifndef CATA_SRC_LIQUID_TRANSFER_H
#define CATA_SRC_LIQUID_TRANSFER_H

#include <optional>

class Character;
class item;
struct liquid_dest_opt;

namespace liquid_handler
{
// Match the legacy increment-until-full loop, including the final charge that
// reaches or crosses capacity. full_after must be monotonic and non-mutating.
template<typename FullAfter>
int charges_until_full( int available, FullAfter &&full_after )
{
    if( available <= 0 || full_after( 0 ) ) {
        return 0;
    }
    if( !full_after( available ) ) {
        return available;
    }
    int low = 1;
    int high = available;
    while( low < high ) {
        const int mid = low + ( high - low ) / 2;
        if( full_after( mid ) ) {
            high = mid;
        } else {
            low = mid + 1;
        }
    }
    return low;
}

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
