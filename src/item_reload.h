#pragma once
#ifndef CATA_SRC_ITEM_RELOAD_H
#define CATA_SRC_ITEM_RELOAD_H

#include <optional>
#include <vector>

#include "item.h"
#include "item_location.h"

// Preview the same contents transition used by item::reload, without consuming
// ammunition, ejecting items, spending linkages or mutating the character/world.
// This is a prospective item, not permission to reload: callers must still
// validate ownership, access, selected ammunition and character requirements.
std::optional<item> preview_reload( const item &target, item_location ammo, int qty,
                                    int pocket_index = -1 );

// Check prospective ancestor capacities, including ammunition removed from a
// shared container. No live item or location is changed.
bool reload_would_fit( const item_location &target, item_location ammo, int qty,
                       int pocket_index = -1 );

// A local path used only while one known item tree is copied/moved. It is not
// a network identity: copied items receive new UIDs.
std::optional<std::vector<size_t>> reload_item_path( const item &root, const item &child );
item_location reload_item_at( item_location root, const std::vector<size_t> &path );

class Character;
bool query_crush_frozen_liquid( Character &who, item_location loc );
bool execute_crush_frozen_liquid( Character &who, item_location loc, bool allow_hammer );

#endif // CATA_SRC_ITEM_RELOAD_H
