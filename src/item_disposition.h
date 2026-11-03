#pragma once
#ifndef CATA_SRC_ITEM_DISPOSITION_H
#define CATA_SRC_ITEM_DISPOSITION_H

#include <cstdint>
#include <optional>
#include <string>

class Character;
class item_location;

// A player's choice, independent of menu order, locale and borrowed pointers.
// Execution rebuilds the available options against the current inventory.
struct item_disposition {
    std::string action;
    int64_t container = 0;
    int64_t pocket = 0;

    bool operator==( const item_disposition &other ) const {
        return action == other.action && container == other.container && pocket == other.pocket;
    }
};

std::optional<item_disposition> query_item_disposition( Character &who, item_location object,
        const std::string &prompt = "" );
bool execute_item_disposition( Character &who, item_location object,
                               const item_disposition &choice );

#endif // CATA_SRC_ITEM_DISPOSITION_H
