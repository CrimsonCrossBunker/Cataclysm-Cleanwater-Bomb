#pragma once
#ifndef CATA_SRC_ITEM_ACTIVATION_H
#define CATA_SRC_ITEM_ACTIVATION_H

#include <string>

#include "coords_fwd.h"

class Character;
class item;
class item_location;

// True only when the method can execute on the supplied actor/target without
// collecting another local UI choice. Empty method selects the Platform v1 use.
bool supports_owned_item_activation( const item &source, const std::string &method );

// Validates native access and applies obtain, activation and charge use once.
// The caller supplies choices, never item payloads or client-computed costs.
// Any activity created by the callback remains authoritative.
bool execute_owned_item_activation( Character &who, item_location source,
                                    const std::string &method, const tripoint_abs_ms &target,
                                    bool allow_theft, bool allow_wet );

#endif // CATA_SRC_ITEM_ACTIVATION_H
