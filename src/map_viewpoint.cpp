#include "map_viewpoint.h"

#include <algorithm>

#include "cached_options.h"
#include "game_constants.h"
#include "character.h"
#include "creature.h"
#include "map.h"

scoped_map_viewpoint::scoped_map_viewpoint( map &here, const Character &observer,
        const tripoint_abs_ms &position, bool standing, int z_range ) : here( here ),
    context( here.get_context_reference() ), previous( here.viewpoint_ )
{
    if( here.inbounds( position ) ) {
        here.viewpoint_ = map_viewpoint{ observer.getID(), observer.pos_abs(), position, standing,
                                         z_range < 0 ? fov_3d_z_range : std::clamp( z_range, 0, OVERMAP_DEPTH + OVERMAP_HEIGHT ) };
        here.invalidate_visibility_cache();
        here.set_seen_cache_dirty( here.get_bub( position ) );
    }
}

scoped_map_viewpoint::~scoped_map_viewpoint()
{
    if( !context ) {
        return;
    }
    if( here.viewpoint_ && here.inbounds( here.viewpoint_->position ) ) {
        here.set_seen_cache_dirty( here.get_bub( here.viewpoint_->position ) );
    }
    here.viewpoint_ = previous;
    here.invalidate_visibility_cache();
}

const map_viewpoint *map::viewpoint_for( const Creature &observer ) const
{
    const Character *who = observer.as_character();
    // A network update or callback may move/replace the real actor while a view
    // is open. Never overwrite that state or reuse the old observation origin.
    return viewpoint_ && who && who->getID() == viewpoint_->observer &&
           observer.pos_abs() == viewpoint_->origin && inbounds( viewpoint_->position ) ?
           &*viewpoint_ : nullptr;
}

tripoint_bub_ms map::observer_position( const Creature &observer ) const
{
    const auto *view = viewpoint_for( observer );
    return view ? get_bub( view->position ) : observer.pos_bub( *this );
}

std::optional<map_viewpoint> map::observer_viewpoint( const Creature &observer ) const
{
    const auto *view = viewpoint_for( observer );
    return view ? std::make_optional( *view ) : std::nullopt;
}

bool map::observer_standing( const Character &observer ) const
{
    const auto *view = viewpoint_for( observer );
    return view && view->standing;
}

int map::observer_z_range( const Creature &observer ) const
{
    const auto *view = viewpoint_for( observer );
    return view ? view->z_range : fov_3d_z_range;
}
