#pragma once
#ifndef CATA_SRC_PET_INVENTORY_UI_H
#define CATA_SRC_PET_INVENTORY_UI_H

#include <optional>
#include <utility>

#include "type_id.h"

class Character;
class item;
class monster;

namespace pet_inventory_ui
{
/** The first missing tool quality needed to install an item, if any. */
std::optional<std::pair<quality_id, int>> missing_install_quality( const Character &who,
                                       const item &equipment );
void show_equipment( monster &pet );
void show_transfer( monster &pet );
} // namespace pet_inventory_ui

#endif // CATA_SRC_PET_INVENTORY_UI_H
