#pragma once
#ifndef CATA_SRC_GUNMOD_UI_H
#define CATA_SRC_GUNMOD_UI_H

#include <string>
#include <vector>

#include "itype.h"
#include "type_id.h"

class Character;
class item;
class item_location;

namespace gunmod_ui
{
struct menu_layout {
    int width;
    int height;
    int left_width;
    int body_height;
    int detail_height;
    bool single_pane;
};

struct slot_preview {
    gunmod_location location;
    int capacity;
    int used;
    int preview_capacity;
    int preview_used;
};

struct installation_option {
    itype_id tool;
    int charges;
    int success;
    int damage;
    bool available;
    std::string name() const;
};

menu_layout layout_for_terminal( int width, int height );
item preview_change( const item &gun, const item &mod, bool installing );
std::vector<slot_preview> preview_slots( const item &gun, const item &preview );
std::string removal_denial( const item &gun, const item &mod );
std::string installation_denial( const Character &who, const item_location &gun,
                                 const item &mod );
std::vector<installation_option> installation_options( const Character &who,
        const item_location &gun, const item &mod );
void show( Character &who, item_location gun, bool resume = false );
} // namespace gunmod_ui

#endif // CATA_SRC_GUNMOD_UI_H

