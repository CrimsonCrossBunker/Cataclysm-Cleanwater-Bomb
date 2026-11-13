#pragma once
#ifndef CATA_SRC_MAP_SIMULATION_REGIONS_H
#define CATA_SRC_MAP_SIMULATION_REGIONS_H

#include <functional>
#include <vector>

#include "coords_fwd.h"

class map;

// Borrow the active map views for one simulation phase. They share the
// world's submap storage. The first loaded view owns an overlapping submap;
// the primary map goes first. Views must not be destroyed during the phase.
class map_simulation_regions
{
    public:
        explicit map_simulation_regions( std::vector<std::reference_wrapper<const map>> maps );

        const map *owner_at( const tripoint_abs_sm &pos ) const;
        bool owns( const map &view, const tripoint_abs_sm &pos ) const;

    private:
        std::vector<std::reference_wrapper<const map>> maps_;
};

#endif // CATA_SRC_MAP_SIMULATION_REGIONS_H
