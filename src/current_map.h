#pragma once
#ifndef CATA_SRC_CURRENT_MAP_H
#define CATA_SRC_CURRENT_MAP_H

#include "safe_reference.h"

class map;
class swap_map;

// The purpose of this class is to contain a reference to the current map.
// This map is typically the reality bubble map, but will differ e.g. when
// mapgen is invoked. Each simulation context owns its own selection/override
// stack. All access is on the owner thread; maps are borrowed and must outlive
// the context and every override that references them.
class current_map
{
        friend class game;
        friend class swap_map;

    public:
        current_map() = default;
        explicit current_map( map &initial );
        current_map( const current_map & ) = delete;
        current_map &operator=( const current_map & ) = delete;
        current_map( current_map && ) = delete;
        current_map &operator=( current_map && ) = delete;
        map &get_map();
    private:
        void set( map *new_map );
        map *current = nullptr;
        map *base = nullptr;
        swap_map *top = nullptr;
        // Expire late guards before any other owner state is destroyed.
        safe_reference_anchor lifetime;
};

// The purpose of this class is to swap out the current map for the duration of
// this object's lifetime. This will typically be for the processing of some map
// that's not the reality bubble one, such as one used during mapgen.
class swap_map
{
    public:
        // Compatibility entry point: capture the active owner once. Destruction
        // never resolves g again, including after a world/context switch.
        explicit swap_map( map &new_map );
        swap_map( current_map &owner, map &new_map );
        ~swap_map();
        swap_map( const swap_map & ) = delete;
        swap_map &operator=( const swap_map & ) = delete;
        swap_map( swap_map && ) = delete;
        swap_map &operator=( swap_map && ) = delete;

    private:
        friend class current_map;
        static current_map &active_context();
        safe_reference<current_map> owner;
        map *target;
        // Intrusive links keep nesting and cancellation allocation-free. Removing
        // an older override leaves newer overrides active until their own exit.
        swap_map *previous = nullptr;
        swap_map *next = nullptr;
};

#endif // CATA_SRC_CURRENT_MAP_H
