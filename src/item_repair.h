#pragma once
#ifndef CATA_SRC_ITEM_REPAIR_H
#define CATA_SRC_ITEM_REPAIR_H

#include <string>
#include <vector>

#include "item_location.h"

class Character;
class repair_item_actor;

namespace item_repair
{
struct tool_option {
    item_location tool;
    std::string method;
    const repair_item_actor *actor;
    bool available;
};

// Ordinary damage repairs use the same actors as activating a repair tool.
std::vector<tool_option> tools_for( Character &you, const item_location &target );
bool start( Character &you, const item_location &target, const tool_option &option );
} // namespace item_repair

#endif // CATA_SRC_ITEM_REPAIR_H
