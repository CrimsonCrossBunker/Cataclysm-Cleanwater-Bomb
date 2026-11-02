#pragma once
#ifndef CATA_SRC_MONSTER_PATH_BATCH_H
#define CATA_SRC_MONSTER_PATH_BATCH_H

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
        static bool simple_route( const map &here, const Creature &who,
                                  const tripoint_bub_ms &target );
        static std::optional<route_snapshot> capture( const map &here, const Creature &who,
                const tripoint_bub_ms &target );
        std::vector<candidate> candidates_;
        std::vector<entry> entries_;
        std::unordered_map<const Creature *, std::size_t> indices_;
        tripoint_abs_sm origin_;
        const map *map_ = nullptr;
        monster_path_batch *previous_ = nullptr;
        bool published_ = false;
};

#endif // CATA_SRC_MONSTER_PATH_BATCH_H
