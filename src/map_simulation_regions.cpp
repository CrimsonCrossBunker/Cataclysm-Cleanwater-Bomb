#include "map_simulation_regions.h"

#include <utility>

#include "map.h"

map_simulation_regions::map_simulation_regions(
    std::vector<std::reference_wrapper<const map>> maps ) : maps_( std::move( maps ) )
{
}

const map *map_simulation_regions::owner_at( const tripoint_abs_sm &pos ) const
{
    for( const map &view : maps_ ) {
        if( view.has_loaded_submap( pos ) ) {
            return &view;
        }
    }
    return nullptr;
}

bool map_simulation_regions::owns( const map &view, const tripoint_abs_sm &pos ) const
{
    return owner_at( pos ) == &view;
}
