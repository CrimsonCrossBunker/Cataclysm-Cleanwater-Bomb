#pragma once
#ifndef CATA_SRC_MONSTER_SCENT_BATCH_H
#define CATA_SRC_MONSTER_SCENT_BATCH_H

#include <cstdint>
#include <optional>
#include <unordered_map>
#include <vector>

#include "coordinates.h"
#include "monster_scent_search.h"

class map;
class scent_map;

class monster_scent_batch
{
    public:
        monster_scent_batch() = default;
        monster_scent_batch( const monster_scent_batch & ) = delete;
        monster_scent_batch &operator=( const monster_scent_batch & ) = delete;
        ~monster_scent_batch();

        static void observe_serial( double microseconds );
        static bool worth_collecting();
        void add( const tripoint_bub_ms &position );
        void prepare( const map &here, const scent_map &scents );
        std::size_t used_count() const {
            return used_count_;
        }
        static std::optional<std::vector<tripoint_bub_ms>> directions(
            const map &here, const scent_map &scents, const tripoint_bub_ms &position, int minimum );

    private:
        struct entry {
            tripoint_bub_ms min;
            tripoint_bub_ms max;
            monster_scent_ranking ranking;
        };
        std::unordered_map<tripoint_bub_ms, std::size_t> indices_;
        std::vector<entry, compute_allocator<entry>> entries_;
        const map *map_ = nullptr;
        const scent_map *scents_ = nullptr;
        tripoint_abs_sm origin_;
        std::uint64_t revision_ = 0;
        monster_scent_batch *previous_ = nullptr;
        bool published_ = false;
        bool attempted_ = false;
        std::size_t task_count_ = 0;
        double overhead_ = 0;
        double serial_cost_ = 0;
        std::size_t used_count_ = 0;
};

#endif // CATA_SRC_MONSTER_SCENT_BATCH_H
