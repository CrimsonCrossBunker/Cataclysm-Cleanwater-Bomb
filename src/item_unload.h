#pragma once
#ifndef CATA_SRC_ITEM_UNLOAD_H
#define CATA_SRC_ITEM_UNLOAD_H

#include <functional>
#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include "handle_liquid.h"
#include "item_source.h"

class Character;
class item;
class item_pocket;
class JsonObject;
class JsonOut;

struct unload_selection {
    item_location target;
    // Magazine UID or the first live ammo UID identifying an integral pocket.
    std::vector<int64_t> sources;
};

struct unload_source_option {
    int64_t identity;
    std::string label;
};

/** Stable native destination identity, resolved against the acting character when applied. */
struct unload_liquid_choice {
    int64_t source = 0;
    liquid_dest kind = LD_NULL;
    item_source container;
    tripoint_abs_ms position;
    int64_t vehicle = 0;
    int64_t tank = 0;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &object );
};

std::vector<item_location> unload_targets( const item_location &root );
std::vector<unload_source_option> unload_sources( item &target );
std::optional<unload_selection> query_unload_selection( const item_location &root,
        bool all_sources = false );
bool valid_unload_selection( const item_location &root, const unload_selection &selection );
void visit_unload_liquids( const unload_selection &selection,
                           const std::function<void( int64_t, const item & )> &visit );

// Nullopt keeps local liquid UI; an explicit (possibly empty) list never opens it.
using unload_liquid_choices = std::optional<std::vector<unload_liquid_choice>>;
bool receive_unloaded_item( Character &who, item &output, const item &target,
                            const item *original, const unload_liquid_choices &choices );
bool start_item_unload( Character &who, item_location root, const unload_selection &selection,
                        bool bypass_activity = false,
                        const item_location &new_container = item_location::nowhere,
                        const unload_liquid_choices &choices = std::nullopt );

/**
 * Drain a selected integral ammo pocket and charge for the quantity actually moved.
 * The receiver handles a copy, returning true if all of it was placed; otherwise
 * its remaining charges describe a partial transfer. The original item is supplied
 * for identity/exclusion only and must not be changed by the receiver.
 * Returns false on cancellation/partial transfer, retaining all untransferred ammo.
 */
bool unload_ammo_pocket( Character &who, item &target, item_pocket &pocket,
                         const std::function<bool( item &, const item & )> &receive );

#endif // CATA_SRC_ITEM_UNLOAD_H
