#pragma once
#ifndef CATA_SRC_ITEM_CONSUMPTION_H
#define CATA_SRC_ITEM_CONSUMPTION_H

#include "item_location.h"

class Character;
class item;

// Confirmation only; witnessing theft and consumption remain native mutations.
bool query_consumption_ownership( const item &target, Character &who );
bool owned_consumption_allowed( Character &who, item_location source,
                                bool allow_consequences, bool allow_theft );
void start_item_consumption( Character &who, const item_location &source,
                             bool reprompt = false );

#endif // CATA_SRC_ITEM_CONSUMPTION_H
