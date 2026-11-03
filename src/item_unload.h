#pragma once
#ifndef CATA_SRC_ITEM_UNLOAD_H
#define CATA_SRC_ITEM_UNLOAD_H

#include <functional>

class Character;
class item;
class item_pocket;

/**
 * Drain a selected integral ammo pocket and charge for the quantity actually moved.
 * The receiver handles a copy, returning true if all of it was placed; otherwise
 * its remaining charges describe a partial transfer. The original item is supplied
 * for identity/exclusion only and must not be changed by the receiver.
 * Returns false on cancellation/partial transfer, retaining all untransferred ammo.
 */
bool unload_ammo_pocket( Character &who, item &target, item_pocket &pocket,
                         const std::function<bool( item &, const item & )> &receive );

#endif // CATA_SRC_ITEM_UNLOAD_H
