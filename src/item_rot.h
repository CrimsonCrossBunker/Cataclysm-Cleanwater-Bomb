#pragma once
#ifndef CATA_SRC_ITEM_ROT_H
#define CATA_SRC_ITEM_ROT_H

#include <array>
#include <cstddef>
#include <optional>
#include <unordered_map>
#include <vector>

#include "calendar.h"
#include "units.h"

class item;

struct item_rot_rates {
    bool cryogenic = false;
    float normal = 0;
    float cold = 0;
};

float hourly_item_rotpoints( const units::temperature &temp, bool cryogenic );

struct item_rot_input {
    units::temperature temperature;
    float spoil_modifier;
    time_duration elapsed;
    bool field_dressed;
    bool irradiated;
    bool cryogenic;

    bool operator==( const item_rot_input &other ) const;
};

// Cold/mushy flags can change during the preceding temperature update.
using item_rot_increments = std::array<time_duration, 4>;
item_rot_increments calculate_item_rot_increments( const item_rot_input &input );

class item_rot_batch
{
    public:
        item_rot_batch() = default;
        ~item_rot_batch();
        item_rot_batch( const item_rot_batch & ) = delete;
        item_rot_batch &operator=( const item_rot_batch & ) = delete;
        bool full() const;
        void add( const item *owner, const item_rot_input &input );
        void prepare();
        static std::optional<time_duration> find( const item *owner,
                const item_rot_input &input, bool cold, bool mushy );

    private:
        struct entry {
            item_rot_input input;
            item_rot_increments increments;
        };
        std::vector<entry> entries_;
        std::unordered_map<const item *, std::size_t> indices_;
        item_rot_batch *previous_ = nullptr;
        bool published_ = false;
};

#endif // CATA_SRC_ITEM_ROT_H
