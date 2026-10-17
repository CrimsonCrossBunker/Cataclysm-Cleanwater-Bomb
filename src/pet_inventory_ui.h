#pragma once
#ifndef CATA_SRC_PET_INVENTORY_UI_H
#define CATA_SRC_PET_INVENTORY_UI_H

class monster;

namespace pet_inventory_ui
{
void show_equipment( monster &pet );
void show_transfer( monster &pet );
} // namespace pet_inventory_ui

#endif // CATA_SRC_PET_INVENTORY_UI_H
