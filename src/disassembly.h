#pragma once
#ifndef CATA_SRC_DISASSEMBLY_H
#define CATA_SRC_DISASSEMBLY_H

#include <optional>
#include <vector>

#include "craft_command.h"
#include "item_source.h"
#include "type_id.h"

class Character;
class item_location;
class JsonObject;
class JsonOut;

// The selected originals and consent, independent of inventory/menu indices.
struct disassembly_selection {
    item_source source;
    itype_id type;
    recipe_id recipe;
    int quantity = 1;
    bool allow_favorite = false;
    bool allow_worn = false;
    bool allow_theft = false;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

// Chosen when a workpiece reaches the front of the queue, so a previous
// workpiece cannot silently change which wielded item is put away.
struct disassembly_preparation {
    int64_t source = 0;
    craft_placement placement = craft_placement::automatic;
    item_source weapon;
    std::optional<item_disposition> disposition;
    std::vector<comp_selection<tool_comp>> tools;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

bool accessible_disassembly( Character &who, const item_location &target );
disassembly_selection capture_disassembly( Character &who, const item_location &target,
        int quantity );
item_location resolve_disassembly( Character &who, const disassembly_selection &selected );
std::optional<disassembly_selection> query_disassembly_selection( Character &who,
        item_location target, bool interactive, bool all_charges );
std::optional<disassembly_preparation> query_disassembly_preparation( Character &who,
        const disassembly_selection &selected );
bool validate_disassembly_preparation( Character &who, const disassembly_selection &selected,
                                       disassembly_preparation &preparation );
bool start_owned_disassembly( Character &who, const std::vector<disassembly_selection> &selected,
                              bool recursive = false );

#endif // CATA_SRC_DISASSEMBLY_H
