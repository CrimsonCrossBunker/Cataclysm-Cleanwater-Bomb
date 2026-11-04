#pragma once
#ifndef CATA_SRC_ITEM_ACTIVATION_H
#define CATA_SRC_ITEM_ACTIVATION_H

#include <optional>
#include <string>

#include "coords_fwd.h"

class Character;
class item;
class item_location;

// Player input only; costs and gameplay effects are always computed natively.
struct item_activation_choices {
    std::optional<int> timer_seconds;
    bool empty() const {
        return !timer_seconds;
    }
};

bool query_item_activation_choices( const item &source, const std::string &method,
                                    item_activation_choices &choices );
bool valid_item_activation_choices( const item &source, const std::string &method,
                                    const item_activation_choices &choices );

// True only when the method can execute on the supplied actor/target without
// collecting another local UI choice during execution. Choices are supplied
// explicitly; empty method selects the Platform v1 use.
bool supports_owned_item_activation( const item &source, const std::string &method );

// Validates native access and applies obtain, activation and charge use once.
// The caller supplies choices, never item payloads or client-computed costs.
// Any activity created by the callback remains authoritative.
bool execute_owned_item_activation( Character &who, item_location source,
                                    const std::string &method, const tripoint_abs_ms &target,
                                    bool allow_theft, bool allow_wet,
                                    const item_activation_choices &choices = {} );

#endif // CATA_SRC_ITEM_ACTIVATION_H
