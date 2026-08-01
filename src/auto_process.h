#pragma once
#ifndef CATA_SRC_AUTO_PROCESS_H
#define CATA_SRC_AUTO_PROCESS_H

#include <set>
#include <string>
#include <vector>

#include "type_id.h"
#include "units.h"

/**
 * A single automatic processing rule defined on an item type:
 * when a matching station acts on the item for long enough
 * (accumulated energy reaches energy_cost), the item is
 * transformed into the listed results.
 */
struct auto_process_rule {
    /** Action type this rule responds to (open string, e.g. "COOK", "SMOKE", "DRY").
     *  Must be unique within one item type: rules sharing an action also share
     *  the progress variable and would corrupt each other's progress. */
    std::string action;
    /** Energy that must be accumulated before the item transforms.  Must be
     *  positive: a zero-cost rule can never trigger. */
    units::energy energy_cost = 0_J;
    /** Items produced when the transformation completes.  Must not be empty. */
    std::vector<itype_id> results;
    /** Optional EOC activated on the result item when the transformation completes.
     *  Must not add, remove or relocate items being processed (or vehicle parts);
     *  off-map catch-up fires these after all pending pointers are released.
     *  For items nested inside a container on furniture stations the EOC gets
     *  no item talker (nullptr dialogue). */
    effect_on_condition_id completion_eoc;
};

/**
 * Automatic processing capabilities of a station (vehicle part or furniture):
 * which actions it can perform and how it modifies the energy cost.
 */
struct auto_process_station {
    /** Action types this station can perform. */
    std::set<std::string> actions;
    /** Multiplier applied to the energy cost of processed rules. */
    double energy_mult = 1.0;
    /** Furniture only: power injected into items each turn (abstracts fuel/manual processes). */
    units::power power = 0_W;
    /** Optional EOC activated when this station completes a transformation.
     *  Same restrictions as auto_process_rule::completion_eoc. */
    effect_on_condition_id completion_eoc;
    /** Optional EOC activated each turn while this station is processing an item.
     *  Only fired by on-map per-turn processing; off-map catch-up never fires it. */
    effect_on_condition_id advance_eoc;
};

#endif // CATA_SRC_AUTO_PROCESS_H
