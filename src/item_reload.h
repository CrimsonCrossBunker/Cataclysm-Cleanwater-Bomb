#pragma once
#ifndef CATA_SRC_ITEM_RELOAD_H
#define CATA_SRC_ITEM_RELOAD_H

#include <optional>

#include "item.h"
#include "item_location.h"

// Preview the same contents transition used by item::reload, without consuming
// ammunition, ejecting items, spending linkages or mutating the character/world.
// This is a prospective item, not permission to reload: callers must still
// validate ownership, access, selected ammunition and character requirements.
std::optional<item> preview_reload( const item &target, item_location ammo, int qty,
                                    int pocket_index = -1 );

#endif // CATA_SRC_ITEM_RELOAD_H
