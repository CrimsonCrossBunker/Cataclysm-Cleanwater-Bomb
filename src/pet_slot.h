#pragma once
#ifndef CATA_SRC_PET_SLOT_H
#define CATA_SRC_PET_SLOT_H

#include <optional>
#include <set>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "translation.h"
#include "type_id.h"
#include "units.h"

class item;
class JsonObject;
class monster;
enum class creature_size : int;

class pet_slot;
using pet_slot_id = string_id<pet_slot>;

/**
 * A data-driven equipment position on a friendly creature.
 *
 * Slot definitions are passive content. Core data and mods may add or amend
 * them without adding another hard-coded equipment branch to the pet menu.
 */
class pet_slot
{
    public:
        pet_slot() = default;

        pet_slot_id id;
        std::vector<std::pair<pet_slot_id, mod_id>> src;
        bool was_loaded = false;

        translation name;
        translation description;

        /** The item must have at least one required flag when this is non-empty. */
        std::vector<flag_id> required_flags;
        /** Any matching flag rejects the item. */
        std::vector<flag_id> forbidden_flags;

        /** Inclusive creature-volume range accepted by this slot. */
        units::volume min_creature_volume = 0_ml;
        units::volume max_creature_volume = units::volume::max();
        std::optional<std::pair<creature_size, creature_size>> creature_size_range;
        std::set<std::string> bodytypes;

        /** Minimum container capacity required for bag-like equipment. */
        units::volume min_storage = 0_ml;
        /** Use the legacy pet-armor body shape and volume compatibility checks. */
        bool pet_armor = false;
        bool mount_only = false;

        /** Effects are applied while this slot contains an item. */
        std::vector<efftype_id> passive_effects;

        /** Riding modifiers contributed while this slot contains an item. */
        int mount_threshold_delta = 0;
        double melee_hit_multiplier = 1.0;
        double melee_damage_multiplier = 1.0;
        double fear_multiplier = 1.0;

        /** Child slots become available only while this slot is occupied. */
        std::vector<pet_slot_id> sub_slots;

        void load( const JsonObject &jo, std::string_view src );
        bool accepts( const item &candidate, const monster &pet,
                      std::string *failure_reason = nullptr ) const;

        static void check_consistency();
        static void finalize_all();
};

void load_pet_slots( const JsonObject &jo, const std::string &src );
void reset_pet_slots();
const std::vector<pet_slot> &get_all_pet_slots();
std::optional<pet_slot_id> get_pet_slot_parent( const pet_slot_id &slot );

#endif // CATA_SRC_PET_SLOT_H
