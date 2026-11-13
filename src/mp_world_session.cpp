#include "mp_world_session.h"

#include <algorithm>
#include <cstdlib>
#include <stdexcept>
#include <utility>

#include "coordinates.h"
#include "current_map.h"
#include "map.h"
#include "map_scale_constants.h"
#include "scent_map.h"

namespace cata_mp
{
resident_region::resident_region( const game &owner, const player_id &identity ) :
    player( identity ), terrain( std::make_unique<map>() ),
    scent( std::make_unique<scent_map>( owner ) )
{
    terrain->main_cleanup_override( false );
    scent->reset();
}

resident_region::~resident_region() = default;

world_session::world_session() = default;

world_session::~world_session()
{
    reset();
}

void world_session::reset()
{
    reset_state( false );
}

void world_session::prepare_for_world_load()
{
    reset_state( true );
}

remote_player_session *world_session::find_remote( const peer_admission &admission ) const
{
    const auto found = remote_players.find( admission.peer_id() );
    if( found == remote_players.end() || !found->second->connected ||
        !found->second->admission.matches( admission ) ) {
        return nullptr;
    }
    // Retirement stops network delivery immediately. Events already queued
    // before disconnect remain ordered and valid until owner-thread detach.
    return found->second.get();
}

remote_player_session *world_session::find_remote( character_id actor ) const
{
    for( const auto &entry : remote_players ) {
        if( entry.second->connected && entry.second->actor.id() == actor ) {
            return entry.second.get();
        }
    }
    return nullptr;
}

bool world_session::accepts_remote_event( const peer_admission &admission ) const
{
    return find_remote( admission ) != nullptr;
}

resident_region &world_session::load_region( const game &owner, map &primary,
        const player_id &player, const tripoint_abs_sm &center )
{
    if( !player.valid() ) {
        throw std::invalid_argument( "A resident region requires a player identity" );
    }
    if( resident_region *existing = find_region( player ) ) {
        return *existing;
    }
    auto region = std::make_unique<resident_region>( owner, player );
    map &terrain = *region->terrain;
    // Shared submaps are already live and must not age twice.
    const map_simulation_regions loaded = simulation_regions( primary );
    {
        const swap_map context( terrain );
        terrain.load( center - point_rel_sm( HALF_MAPSIZE, HALF_MAPSIZE ), true, false, &loaded );
    }
    if( !terrain.has_loaded_submap( center ) ) {
        throw std::runtime_error( "Could not load the center of the resident region" );
    }
    return *regions_.emplace( player, std::move( region ) ).first->second;
}

resident_region *world_session::find_region( const player_id &player ) const
{
    const auto found = regions_.find( player );
    return found == regions_.end() ? nullptr : found->second.get();
}

void world_session::recenter_region( map &primary, resident_region &region,
                                     const tripoint_abs_sm &center )
{
    map &terrain = *region.terrain;
    const tripoint_abs_sm origin = center - point_rel_sm( HALF_MAPSIZE, HALF_MAPSIZE );
    const point_rel_sm displacement = origin.xy() - terrain.get_abs_sub().xy();
    const swap_map context( terrain );
    const map_simulation_regions loaded = simulation_regions( primary );
    if( std::abs( displacement.x() ) >= MAPSIZE || std::abs( displacement.y() ) >= MAPSIZE ) {
        // Preserve the old window until its cells have been stamped. The
        // existing map object then takes ownership of the newly loaded window.
        terrain.save( &loaded );
        terrain.load( origin, true, false, &loaded );
        region.scent->reset();
        return;
    }
    for( point_rel_sm remaining = displacement; remaining != point_rel_sm::zero; ) {
        const point_rel_sm step( std::clamp( remaining.x(), -1, 1 ),
                                 std::clamp( remaining.y(), -1, 1 ) );
        terrain.shift( step, &loaded );
        remaining -= step;
    }
    if( displacement != point_rel_sm::zero ) {
        region.scent->shift( project_to<coords::ms>( displacement ) );
    }
    if( terrain.get_abs_sub().z() != center.z() ) {
        terrain.vertical_shift( center.z() );
        region.scent->reset();
    }
}

void world_session::retire_region( map &primary, const player_id &player )
{
    const auto retiring = regions_.find( player );
    if( retiring == regions_.end() ) {
        return;
    }
    map &terrain = *retiring->second->terrain;
    std::vector<std::reference_wrapper<const map>> views;
    views.reserve( 1 + regions_.size() );
    visit_resident_maps( primary, [&]( const map &view ) {
        if( &view != &terrain ) {
            views.emplace_back( view );
        }
    } );
    // Only stamp storage no longer covered by any other active window.
    views.emplace_back( terrain );
    const map_simulation_regions remaining( std::move( views ) );
    terrain.save( &remaining );
    regions_.erase( retiring );
}

scent_map *world_session::scent_for( const map &terrain ) const
{
    for( const auto &entry : regions_ ) {
        if( entry.second->terrain.get() == &terrain ) {
            return entry.second->scent.get();
        }
    }
    return nullptr;
}

std::vector<std::reference_wrapper<resident_region>> world_session::active_regions() const
{
    std::vector<std::reference_wrapper<resident_region>> result;
    result.reserve( regions_.size() );
    for( const auto &entry : regions_ ) {
        result.emplace_back( *entry.second );
    }
    return result;
}

std::vector<std::reference_wrapper<map>> world_session::active_maps( map &primary ) const
{
    std::vector<std::reference_wrapper<map>> result;
    result.reserve( 1 + regions_.size() );
    visit_resident_maps( primary, [&]( map & terrain ) {
        result.emplace_back( terrain );
    } );
    return result;
}

map_simulation_regions world_session::simulation_regions( const map &primary ) const
{
    std::vector<std::reference_wrapper<const map>> views{ std::cref( primary ) };
    views.reserve( 1 + regions_.size() );
    for( const auto &entry : regions_ ) {
        views.emplace_back( *entry.second->terrain );
    }
    return map_simulation_regions( std::move( views ) );
}

map *world_session::loaded_map_at( map &primary, const tripoint_abs_sm &position ) const
{
    if( primary.has_loaded_submap( position ) ) {
        return &primary;
    }
    for( const auto &entry : regions_ ) {
        if( entry.second->terrain->has_loaded_submap( position ) ) {
            return entry.second->terrain.get();
        }
    }
    return nullptr;
}

map &world_session::map_for( map &primary, const tripoint_abs_sm &position ) const
{
    map *const owner = loaded_map_at( primary, position );
    return owner ? *owner : primary;
}

bool world_session::has_regions() const
{
    return !regions_.empty();
}

void world_session::reset_state( bool preserve_pending_client )
{
    const bool keep_admission = preserve_pending_client && client.pending_admission();
    client_apply_watchdog.stop();
    hosting.stop();
    host_info = {};
    if( preserve_pending_client ) {
        client.prepare_for_world_load();
    } else {
        client.reset();
        server_mode = false;
        host_mode = false;
    }
    // Only a successful, unjoined probe may cross initial setup. Loaded-world
    // replication, timers, interaction continuations and UI never cross it.
    if( !keep_admission ) {
        admission = {};
    }
    replication = {};
    remote_players.clear();
    regions_.clear();
    pending_support.clear();
    host_waiting_for_clients = false;
    last_monmove_ms = 0;
    host_wait_elapsed_ms = 0;
    grant_sequence = 0;
    client_turn = {};
    client_feedback_sequence = 0;
    client_pickup = {};
    client_firearm = {};
    client_inventory_activity = {};
    host_observation = {};
    presentation = session_presentation();
    last_marked_world.clear();
    local_player.reset();
    players.reset();
    client_host_actor.reset();
    client_host_player_id = {};
    client_player_views.clear();
    client_npc_views.clear();
    client_radio_contacts.clear();
    client_host_spawned = false;
    stale_proxy_cleanup_done = false;
}
} // namespace cata_mp
