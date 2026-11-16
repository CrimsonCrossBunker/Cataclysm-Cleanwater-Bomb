#pragma once
#ifndef CATA_SRC_MONSTER_PATH_BATCH_H
#define CATA_SRC_MONSTER_PATH_BATCH_H

#include <array>
#include <chrono>
#include <optional>
#include <unordered_map>
#include <vector>

#include "pathfinding.h"
#include "route_snapshot.h"

class Creature;
class map;

class monster_path_batch
{
    public:
        monster_path_batch() = default;
        ~monster_path_batch();
        monster_path_batch( const monster_path_batch & ) = delete;
        monster_path_batch &operator=( const monster_path_batch & ) = delete;

        void add( const Creature &who, const tripoint_bub_ms &target );
        void prepare( const map &here );
        std::size_t prepared_count() const {
            return published_ ? entries_.size() : 0;
        }
        std::size_t used_count() const {
            return used_count_;
        }
        static bool worth_collecting();
        static void observe_serial( const tripoint_bub_ms &start,
                                    const tripoint_bub_ms &target, double microseconds );
        static std::optional<std::vector<tripoint_bub_ms>> take(
            const map &here, const Creature &who, const pathfinding_target &target );

    private:
        struct candidate {
            const Creature *owner;
            tripoint_bub_ms target;
        };
        struct entry {
            const Creature *owner;
            pathfinding_settings settings;
            route_snapshot snapshot;
            route_snapshot_result result;
            bool used = false;
        };
        struct cost_group {
            pathfinding_settings settings;
            std::unordered_map<tripoint_bub_ms, std::array<int, 8>, std::hash<tripoint_bub_ms>,
                std::equal_to<tripoint_bub_ms>,
                compute_allocator<std::pair<const tripoint_bub_ms, std::array<int, 8>>>> cells;
        };
        static bool simple_route( const map &here, const Creature &who,
                                  const tripoint_bub_ms &target );
        static std::optional<route_snapshot> capture( const map &here, const Creature &who,
                const tripoint_bub_ms &target, std::vector<cost_group> &costs,
                std::size_t &cached_cells, std::size_t remaining_cells,
                std::chrono::steady_clock::time_point deadline );
        std::vector<candidate> candidates_;
        std::vector<entry> entries_;
        std::unordered_map<const Creature *, std::size_t> indices_;
        tripoint_abs_sm origin_;
        const map *map_ = nullptr;
        monster_path_batch *previous_ = nullptr;
        bool published_ = false;
        bool attempted_ = false;
        std::size_t kind_ = 0;
        std::size_t task_count_ = 0;
        double serial_cost_ = 0;
        double overhead_ = 0;
        std::size_t used_count_ = 0;
};

#endif // CATA_SRC_MONSTER_PATH_BATCH_H
