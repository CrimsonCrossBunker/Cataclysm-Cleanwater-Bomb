#pragma once
#ifndef CATA_SRC_TILE_LOOKUP_H
#define CATA_SRC_TILE_LOOKUP_H

#include <array>
#include <cstddef>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>

#include "cata_tiles.h"

// One renderer-owned query frame. The bundle and season remain fixed while
// requests are resolved; cached misses and borrowed results end with the frame.
// Native looks_like queries still read the owner's loaded content registries.
// Only independent CPU-only metadata bundles may be queried concurrently; a worker must
// not share this mutable cache or query live world registries through it.
class tile_lookup_frame
{
    public:
        tile_lookup_frame( std::shared_ptr<const tileset> bundle, season_type season,
                           bool cache_results = true );
        ~tile_lookup_frame();
        tile_lookup_frame( const tile_lookup_frame & ) = delete;
        tile_lookup_frame &operator=( const tile_lookup_frame & ) = delete;
        std::optional<tile_lookup_res> find( const std::string &id, TILE_CATEGORY category,
                                             const std::string &variant, int jumps_limit = 10 );
        static const std::array<std::string, 8> subtile_keys;
        struct subtile_result {
            // Availability determines whether the legacy draw would recurse.
            // A missing child still needs the owner's ASCII/unknown fallback.
            bool available = false;
            std::optional<tile_lookup_res> resolved;
        };
        // Base metadata must come from this frame's pinned bundle. The result
        // borrows that same bundle; neither cache nor results escape the frame.
        subtile_result find_subtile( const tile_lookup_res &base, TILE_CATEGORY category,
                                     int subtile );
        size_t subtile_requests() const {
            return subtile_requests_;
        }
        size_t subtile_cache_hits() const {
            return subtile_cache_hits_;
        }
        size_t requests() const {
            return requests_;
        }
        size_t cache_hits() const {
            return cache_hits_;
        }
        size_t cached_ids() const {
            return results_.size();
        }

    private:
        struct entry {
            TILE_CATEGORY category;
            std::string variant;
            int jumps_limit;
            std::optional<tile_lookup_res> result;
            bool matches( TILE_CATEGORY requested_category, const std::string &requested_variant,
                          int requested_limit ) const;
        };
        // Most ids use only one category/variant/depth. Keep that entry inline
        // and allocate alternatives only when another request shares the id.
        struct id_results {
            entry first;
            std::vector<entry> alternatives;
        };
        struct subtile_key {
            const std::string *base_id;
            TILE_CATEGORY category;
            int subtile;
            bool operator==( const subtile_key &other ) const;
        };
        struct subtile_key_hash {
            size_t operator()( const subtile_key &key ) const;
        };
        const std::shared_ptr<const tileset> bundle_;
        const season_type season_;
        const bool cache_results_;
        size_t requests_ = 0;
        size_t cache_hits_ = 0;
        std::unordered_map<std::string, id_results> results_;
        size_t subtile_requests_ = 0;
        size_t subtile_cache_hits_ = 0;
        std::unordered_map<subtile_key, subtile_result, subtile_key_hash> subtiles_;
        std::optional<tile_lookup_res> resolve( const std::string &id, TILE_CATEGORY category,
                                                const std::string &variant, int jumps_limit );
        std::optional<tile_lookup_res> find_with_season( const std::string &id ) const;
        template<typename T>
        std::optional<tile_lookup_res> find_by_string_id( std::string_view id,
                TILE_CATEGORY category, int jumps_limit );
};

#endif // CATA_SRC_TILE_LOOKUP_H
