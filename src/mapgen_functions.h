#pragma once
#ifndef CATA_SRC_MAPGEN_FUNCTIONS_H
#define CATA_SRC_MAPGEN_FUNCTIONS_H

#include <array>
#include <cstddef>
#include <functional>
#include <map>
#include <memory>
#include <optional>
#include <string>
#include <utility>

#include "coords_fwd.h"
#include "ret_val.h"
#include "type_id.h"

class map;
class mapgendata;
class mission;
class tinymap;
struct mapgen_arguments;
struct mapgen_parameters;

using mapgen_update_func = std::function<void( const tripoint_abs_omt &map_pos3, mission *miss )>;
class JsonObject;

int terrain_type_to_nesw_array( oter_id terrain_type, std::array<bool, 4> &array );

using building_gen_pointer = void ( * )( mapgendata & );
building_gen_pointer get_mapgen_cfunction( const std::string &ident );
ter_str_id grass_or_dirt();
ter_str_id clay_or_sand();

// helper functions for mapgen.cpp, so that we can avoid having a massive switch statement (sorta)
void mapgen_forest( mapgendata &dat );
void mapgen_river_curved_not( mapgendata &dat );
void mapgen_river_straight( mapgendata &dat );
void mapgen_river_curved( mapgendata &dat );
void mapgen_subway( mapgendata &dat );
void mapgen_lake_shore( mapgendata &dat );
void mapgen_ocean_shore( mapgendata &dat );
void mapgen_ravine_edge( mapgendata &dat );

// Temporary wrappers
void mremove_trap( map *m, const tripoint_bub_ms &, trap_id type );
void mtrap_set( map *m, const tripoint_bub_ms &, trap_id type, bool avoid_creatures = false );
void mtrap_set( tinymap *m, const point_omt_ms &, trap_id type, bool avoid_creatures = false );
void madd_field( map *m, const point_bub_ms &, field_type_id type, int intensity );
void mremove_fields( map *m, const tripoint_bub_ms & );

mapgen_update_func add_mapgen_update_func( const JsonObject &jo, bool &defer );
// Return contains the name of a colliding "vehicle" on failure.
ret_val<void> run_mapgen_update_func(
    const update_mapgen_id &, const tripoint_abs_omt &omt_pos, const mapgen_arguments &,
    mission *miss = nullptr, bool cancel_on_collision = true, bool mirror_horizontal = false,
    bool mirror_vertical = false, int rotation = 0 );

/**
 * The exact bounded footprint a Platform transaction is allowed to touch.
 * The current update-mapgen implementation operates on a 2x2 submap OMT
 * stack; keeping these extents in the predicate result makes the snapshot
 * boundary explicit instead of duplicating an assumed range in the caller.
 */
struct platform_mapgen_transaction_footprint {
    int min_submap_x = 0;
    int max_submap_x = -1;
    int min_submap_y = 0;
    int max_submap_y = -1;
    int min_z = 0;
    int max_z = -1;
    bool complete_omt_z_stack = false;
};

enum platform_mapgen_transaction_state {
    rejected,
    committed,
    rolled_back,
    rollback_failed
};

struct platform_mapgen_transaction_report {
    platform_mapgen_transaction_state state = rejected;
    platform_mapgen_transaction_footprint footprint;
    std::string code;
    std::string message;
};

class platform_mapgen_callback_transaction {
    public:
        platform_mapgen_callback_transaction( mapgendata &,
                                               platform_mapgen_transaction_report * );
        ~platform_mapgen_callback_transaction() noexcept;

        platform_mapgen_callback_transaction( const platform_mapgen_callback_transaction & ) = delete;
        platform_mapgen_callback_transaction &operator=(
            const platform_mapgen_callback_transaction & ) = delete;
        platform_mapgen_callback_transaction( platform_mapgen_callback_transaction && ) = delete;
        platform_mapgen_callback_transaction &operator=(
            platform_mapgen_callback_transaction && ) = delete;

        bool ready() const noexcept;
        void commit() noexcept;
        bool rollback( const std::string &code, const std::string &message ) noexcept;

    private:
        struct impl;
        std::unique_ptr<impl> pimpl_;
};

/**
 * Prove that an update operator is safe for a Platform terminal transaction
 * and report the complete already-loaded submap footprint it may touch.
 * Unknown operator structure, non-map-only operations, or an incomplete
 * target footprint fail closed.
 */
bool platform_transaction_safe(
    const update_mapgen_id &, const tripoint_abs_omt &omt_pos,
    platform_mapgen_transaction_footprint &, std::string &error );
/**
 * Apply one update-mapgen operation as a bounded world transaction.
 *
 * The operator predicate reports the footprint and requires every submap to
 * be present in the map buffer.  A detached snapshot is taken for that exact
 * footprint before invoking the platform-only update wrapper.  If the update
 * reports failure or throws, every reported submap is restored before the
 * failure is returned.  Callers that need to publish additional metadata can
 * therefore commit it only after this map-only transaction succeeds.
 */
ret_val<void> run_mapgen_update_func_transactional(
    const update_mapgen_id &, const tripoint_abs_omt &omt_pos, const mapgen_arguments &,
    mission *miss = nullptr, bool cancel_on_collision = true, bool mirror_horizontal = false,
    bool mirror_vertical = false, int rotation = 0,
    const std::optional<oter_id> &expected_terrain = std::nullopt,
    const std::optional<oter_id> &terrain_publication = std::nullopt,
    platform_mapgen_transaction_report *report = nullptr );
// Return contains the name of a colliding "vehicle" on failure.
ret_val<void> run_mapgen_update_func( const update_mapgen_id &, mapgendata &dat,
                                      bool cancel_on_collision = true );
void set_queued_points();
void queue_mapgen_point( const std::string &name, const tripoint_abs_ms &point );
bool run_mapgen_func( const std::string &mapgen_id, mapgendata &dat );
bool apply_construction_marker( const update_mapgen_id &update_mapgen_id,
                                const tripoint_abs_omt &omt_pos,
                                const mapgen_arguments &args, bool mirror_horizontal,
                                bool mirror_vertical, int rotation, bool apply );
std::pair<std::map<ter_id, int>, std::map<furn_id, int>> get_changed_ids_from_update(
            const update_mapgen_id &, const mapgen_arguments &,
            ter_id const &base_ter = ter_str_id( "t_dirt" ).id() );
mapgen_parameters get_map_special_params( const std::string &mapgen_id );

void resolve_regional_terrain_and_furniture( const mapgendata &dat, int z_offset = 0 );

#endif // CATA_SRC_MAPGEN_FUNCTIONS_H
