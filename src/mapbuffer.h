#pragma once
#ifndef CATA_SRC_MAPBUFFER_H
#define CATA_SRC_MAPBUFFER_H

#include <cstddef>
#include <functional>
#include <list>
#include <map>
#include <memory>
#include <mutex>
#include <string>
#include <unordered_map>
#include <unordered_set>

#include "coordinates.h"
#include "submap_prefetch.h"
#include "type_id.h"

class JsonArray;
class cata_path;
class map;
class map_storage_context;
class submap;

/**
 * Store, buffer, save and load the entire world map.
 */
class mapbuffer
{
    public:
        // Compatibility adapter for the single active world. Its namespace is
        // captured on first use, including memory-only insertion, until clear().
        mapbuffer();
        using uniform_terrain_lookup = std::function<oter_id( const tripoint_abs_omt & )>;
        // Explicit owners never consult the active world for storage. The optional
        // resolver belongs to the same world and is called only on the owner thread.
        explicit mapbuffer( map_storage_context storage, uniform_terrain_lookup uniform = {} );
        ~mapbuffer();

        std::size_t submap_count() const;

        /** Store all submaps in this instance into savefiles.
         * @param delete_after_save If true, the saved submaps are removed
         * from the mapbuffer (and deleted).
         **/
        // With a residency map, evict successfully saved quads outside that map.
        // Without one, retain them unless delete_after_save was requested.
        void save( bool delete_after_save = false, const map *resident_map = nullptr );

        /** Delete all buffered submaps. **/
        void clear();

        /** Delete all buffered submaps except those inside the reality bubble.
         *
         * This exists for the sake of the tests to reduce their memory
         * consumption; it's probably not sane to use in general gameplay.
         */
        void clear_outside_reality_bubble();

        /** Add a new submap to the buffer.
         *
         * @param p The absolute world position in submap coordinates.
         * Same as the ones in @ref lookup_submap.
         * @param sm The submap. If the submap has been added, the unique_ptr
         * is released (set to NULL).
         * @return true if the submap has been stored here. False if there
         * is already a submap with the specified coordinates. The submap
         * is not stored and the given unique_ptr retains ownsership.
         */
        bool add_submap( const tripoint_abs_sm &p, std::unique_ptr<submap> &sm );
        // Old overload that we should stop using, but it's complicated
        bool add_submap( const tripoint_abs_sm &p, submap *sm );

        /** Get a submap stored in this buffer.
         *
         * @param p The absolute world position in submap coordinates.
         * Same as the ones in @ref add_submap.
         * @return NULL if the submap is not in the mapbuffer
         * and could not be loaded. The mapbuffer takes care of the returned
         * submap object, don't delete it on your own.
         */
        submap *lookup_submap( const tripoint_abs_sm &p );
        // Cheaper version of the above for when you only care about whether the
        // submap exists or not.
        bool submap_exists( const tripoint_abs_sm &p );

        // Cheaper version of the above for when you don't mind some false results
        bool submap_exists_approx( const tripoint_abs_sm &p );

        // Queue a background read+decompress of the quad containing the given OMT,
        // so a later lookup_submap can skip the synchronous disk I/O. No-op if the
        // submap is already in memory. `priority` is the quad's submap-distance from
        // the player: the worker serves the smallest first, so near edges are read
        // before the far frontier. Only the (thread-safe) read happens on the
        // worker; parsing still occurs on the main thread in unserialize_submaps.
        void prefetch_quad( const tripoint_abs_omt &om_addr, int priority );

        // Forward to the background prefetcher: drop buffered/queued quads farther
        // than `max_dist` submaps from `center`, bounding memory by locality.
        void prefetch_evict_beyond( const tripoint_abs_omt &center, int max_dist );
        submap_prefetcher::status prefetch_status() const;

        // Uniform generation must insert into the buffer whose file was read.
        bool generate_uniform( const tripoint_abs_sm &p, const ter_str_id &terrain );
        bool generate_uniform_omt( const tripoint_abs_sm &p, const oter_id &terrain );

    private:
        using submap_map_t = std::map<tripoint_abs_sm, std::unique_ptr<submap>>;

    public:
        inline submap_map_t::iterator begin() {
            return submaps.begin();
        }
        inline submap_map_t::iterator end() {
            return submaps.end();
        }

    private:
        // There's a very good reason this is private,
        // if not handled carefully, this can erase in-use submaps and crash the game.
        void remove_submap( const tripoint_abs_sm &addr );
        submap *unserialize_submaps( const tripoint_abs_sm &p );
        bool submap_file_exists( const tripoint_abs_sm &p );
        const map_storage_context &storage();
        cata_path find_dirname( const tripoint_abs_omt &om_addr );
        bool add_uniform_submap( const tripoint_abs_sm &p, const ter_str_id &terrain );

        /** Guards all accesses to submaps that may overlap with background
         *  worker threads. recursive_mutex allows mapgen code (running under
         *  a held lock) to call lookup_submap/add_submap without deadlocking. */
        mutable std::recursive_mutex submaps_mutex_;

        void deserialize( const JsonArray &ja );
        void save_quad(
            const cata_path &dirname, const cata_path &filename,
            const tripoint_abs_omt &om_addr, std::list<tripoint_abs_sm> &submaps_to_delete,
            bool delete_after_save );
        // Per-zzip listing cache: maps a maps zzip archive's absolute path to the
        // set of entry filenames (e.g. "12.34.-10.map") it contains. Lets the hot
        // existence-check path (submap_exists / unserialize_submaps) answer "is this
        // quad on disk?" without re-opening (mmap + footer parse) the same archive
        // once per submap. Only the surface z-level quad of a column is ever saved
        // for uniform deep terrain, so a walked-back column probes ~84 quads that
        // are absent from the archive; without this each probe paid a fresh
        // zzip::load. Populated lazily from zzip::get_entries(); we deliberately do
        // NOT keep the zzip handle (mmap) open, so a save that rewrites the archive
        // (compact_to + rename) is never blocked on Windows. Invalidated wholesale
        // around save() and on clear(), the only places that mutate these archives.
        std::unordered_map<std::string, std::unordered_set<std::string>> zzip_listing_cache;
        // Return the entry-name set for the archive at zzip_path, loading it once and
        // caching it. Returns nullptr if the archive does not exist / fails to open.
        const std::unordered_set<std::string> *zzip_listing( const cata_path &zzip_path );
        submap_map_t submaps; // NOLINT(cata-serialize)
        const bool active_world_adapter_;
        std::unique_ptr<const map_storage_context> storage_;
        uniform_terrain_lookup uniform_terrain_;
        // Destroy/join the worker before releasing its owner's context and maps.
        submap_prefetcher prefetcher_;
};

extern mapbuffer MAPBUFFER;

#endif // CATA_SRC_MAPBUFFER_H
