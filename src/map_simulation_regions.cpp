#include "map_simulation_regions.h"

#include <utility>

#include "map.h"

map_simulation_regions::map_simulation_regions(
    std::vector<std::reference_wrapper<const map>> maps ) : maps_( std::move( maps ) )
{
}

const map *map_simulation_regions::owner_at( const tripoint_abs_sm &pos ) const
{
    for( const auto &view : maps_ ) {
        if( view.get().has_loaded_submap( pos ) ) {
            return &view.get();
        }
    }
    return nullptr;
}

bool map_simulation_regions::owns( const map &view, const tripoint_abs_sm &pos ) const
{
    return owner_at( pos ) == &view;
}

bool map_simulation_regions::loaded_elsewhere( const map &view, const tripoint_abs_sm &pos ) const
{
    for( const auto &other : maps_ ) {
        if( &other.get() != &view && other.get().has_loaded_submap( pos ) ) {
            return true;
        }
    }
    return false;
}
