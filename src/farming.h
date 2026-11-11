#pragma once
#ifndef CATA_SRC_FARMING_H
#define CATA_SRC_FARMING_H

#include <optional>
#include <utility>
#include <vector>

#include "item_source.h"
#include "item_unload.h"
#include "tool_activity_target.h"
#include "type_id.h"

class Character;
class JsonObject;
class JsonOut;
class item;
class map;

enum class farming_action {
    plant, fertilize, harvest, water, clear, gather, forage, flower, fungus, marloss,
    hickory_roots, maple_tap, maple_untap, maple_add_container, maple_remove_container, maple_sap
};

// A choice refers to the observed plot and crop, never a client-authored item,
// yield, duration or player ID. The caller supplies the authoritative operator.
struct farming_command {
    farming_action action = farming_action::plant;
    tool_activity_target target;
    std::optional<item_source> seed;
    itype_id seed_type;
    itype_id material;
    bool drink = false;
    bool pick = true;
    std::optional<item_source> tap;
    std::optional<item_source> container;
    std::optional<unload_liquid_choice> sap_destination;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

farming_command capture_farming_command( Character &who, map &here,
        const tripoint_abs_ms &position, farming_action action );
bool execute_farming_command( Character &who, const farming_command &command );

// Resolve the seed stored directly in a plot, including sealed crop furniture.
item *resolve_planted_seed( map &here, const item_source &source );

// The first collecting container matches map::produce_sap, even when other
// unrelated items share the tree tile. These are short-lived frontend handles.
struct maple_tree_items {
    item_location tap;
    item_location container;
    item_location sap;
};
maple_tree_items inspect_maple_tree( map &here, const tripoint_abs_ms &position );

#endif // CATA_SRC_FARMING_H
