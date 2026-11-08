#pragma once
#ifndef CATA_SRC_MAP_VIEWPOINT_H
#define CATA_SRC_MAP_VIEWPOINT_H

#include <optional>

#include "character_id.h"
#include "coordinates.h"
#include "safe_reference.h"

class Character;
class map;

// Presentation only. The real actor remains at origin throughout the scope.
struct map_viewpoint {
    character_id observer;
    tripoint_abs_ms origin;
    tripoint_abs_ms position;
    bool standing = false;
    int z_range = -1;
};

class scoped_map_viewpoint
{
    public:
        scoped_map_viewpoint( map &here, const Character &observer,
                              const tripoint_abs_ms &position, bool standing = false, int z_range = -1 );
        ~scoped_map_viewpoint();
        scoped_map_viewpoint( const scoped_map_viewpoint & ) = delete;
        scoped_map_viewpoint &operator=( const scoped_map_viewpoint & ) = delete;
    private:
        map &here;
        safe_reference<map> context;
        std::optional<map_viewpoint> previous;
};

#endif // CATA_SRC_MAP_VIEWPOINT_H
