#pragma once
#ifndef CATA_SRC_ITEM_TEMPERATURE_H
#define CATA_SRC_ITEM_TEMPERATURE_H

#include <cstddef>
#include <cstdint>
#include <optional>
#include <unordered_map>
#include <vector>

class item;

struct item_temperature_input {
    float environment;
    float temperature;
    float energy;
    float mass;
    std::int64_t volume;
    float insulation;
    float liquid_heat;
    float solid_heat;
    float latent_heat;
    float freezing;
    int turns;

    bool operator==( const item_temperature_input &other ) const;
};

struct item_temperature_result {
    float temperature = 0;
    float energy = 0;
    float frozen = 0;
    bool equilibrium = false;
};

// Value-only heat transfer; no item, world, registry or RNG access.
item_temperature_result calculate_item_temperature( const item_temperature_input &input );

class item_temperature_batch
{
    public:
        item_temperature_batch() = default;
        ~item_temperature_batch();
        item_temperature_batch( const item_temperature_batch & ) = delete;
        item_temperature_batch &operator=( const item_temperature_batch & ) = delete;

        bool full() const;
        void add( const item *owner, const item_temperature_input &input );
        void prepare();
        static std::optional<item_temperature_result> find(
            const item *owner, const item_temperature_input &input );

    private:
        struct entry {
            item_temperature_input input;
            item_temperature_result result;
        };
        std::vector<entry> entries_;
        std::unordered_map<const item *, std::size_t> indices_;
        item_temperature_batch *previous_ = nullptr;
        bool published_ = false;
};

#endif // CATA_SRC_ITEM_TEMPERATURE_H
