#pragma once
#ifndef CATA_SRC_CRAFT_RESULT_STATE_H
#define CATA_SRC_CRAFT_RESULT_STATE_H

#include <vector>

class item;
class JsonObject;
class JsonOut;

enum class craft_completion_stage : int {
    not_started = 0,
    primary_results,
    byproducts,
    done
};

/** Owned by the craft so waiting for a destination survives cancellation/save. */
struct craft_result_state {
    craft_completion_stage stage = craft_completion_stage::not_started;
    bool owner_selects_destination = false;
    bool components_pending = false;
    bool inventory_destination = false;
    std::vector<item> pending;
    bool primary_had_results = false;
    bool allow_wield = false;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &data );
};

#endif // CATA_SRC_CRAFT_RESULT_STATE_H
