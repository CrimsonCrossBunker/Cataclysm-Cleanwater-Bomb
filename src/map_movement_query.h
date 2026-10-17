#pragma once
#ifndef CATA_SRC_MAP_MOVEMENT_QUERY_H
#define CATA_SRC_MAP_MOVEMENT_QUERY_H

#include <optional>

#include "field.h"
#include "map.h"
#include "mapdata.h"
#include "submap.h"
#include "vpart_position.h"

/**
 * Borrowed tile facts for one synchronous owner-thread movement query.
 * This is not a snapshot: do not retain it across map/vehicle changes or send it
 * to workers. Lazy lookups preserve terrain/furniture short-circuiting.
 */
class map_movement_query
{
    public:
        map_movement_query( const map &world, const tripoint_bub_ms &position ) :
            world_( world ), position_( position ), in_bounds_( world.inbounds( position ) ),
            tile_( in_bounds_ ? world.maptile_at_internal( position ) : world.maptile_at( position ) ),
            vehicle_( std::nullopt ) {}
        map_movement_query( const map_movement_query & ) = delete;
        map_movement_query &operator=( const map_movement_query & ) = delete;

        const field &fields() const {
            return available() ? tile_.get_field() : world_.field_at( position_ );
        }

        bool has_flag( ter_furn_flag flag ) const {
            return available() ? terrain().has_flag( flag ) || furniture().has_flag( flag ) :
                   world_.has_flag( flag, position_ );
        }

        bool has_terrain_flag( ter_furn_flag flag ) const {
            return available() ? terrain().has_flag( flag ) : world_.has_flag_ter( flag, position_ );
        }

        bool passable_skip_fields() const {
            if( !available() ) {
                return world_.passable_skip_fields( position_ );
            }
            static const field no_fields;
            const optional_vpart_position &vp = vehicle_position();
            return world_.move_cost_internal( furniture(), terrain(), no_fields,
                                              vp ? &vp->vehicle() : nullptr,
                                              vp ? static_cast<int>( vp->part_index() ) : -1 ) != 0;
        }

        bool has_vehicle_floor() const {
            const optional_vpart_position &vp = vehicle_position();
            return vp.part_with_feature( "BOARDABLE", false ) ||
                   vp.part_with_feature( "OBSTACLE", false );
        }

    private:
        bool available() const {
            return in_bounds_ && tile_.wrapped_submap();
        }
        const ter_t &terrain() const {
            if( !terrain_ ) {
                terrain_ = &tile_.get_ter_t();
            }
            return *terrain_;
        }
        const furn_t &furniture() const {
            if( !furniture_ ) {
                furniture_ = &tile_.get_furn_t();
            }
            return *furniture_;
        }
        const optional_vpart_position &vehicle_position() const {
            if( !vehicle_loaded_ ) {
                vehicle_ = world_.veh_at( position_ );
                vehicle_loaded_ = true;
            }
            return vehicle_;
        }

        const map &world_;
        const tripoint_bub_ms position_;
        const bool in_bounds_;
        const const_maptile tile_;
        mutable const ter_t *terrain_ = nullptr;
        mutable const furn_t *furniture_ = nullptr;
        mutable optional_vpart_position vehicle_;
        mutable bool vehicle_loaded_ = false;
};

#endif // CATA_SRC_MAP_MOVEMENT_QUERY_H
