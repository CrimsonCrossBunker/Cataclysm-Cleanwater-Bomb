#pragma once
#ifndef CATA_SRC_MONSTER_LOCAL_CACHE_H
#define CATA_SRC_MONSTER_LOCAL_CACHE_H

#include <array>
#include <optional>

#include "point.h"

// Stack-local memoization for one read-only monster query. Store false/null
// results too, and never reuse entries across movement or gameplay effects.
template<typename T, int RadiusXY, int RadiusZ>
class monster_local_cache
{
    public:
        template<typename Query>
        T get( const tripoint &offset, Query &&query ) {
            if( offset.x < -RadiusXY || offset.x > RadiusXY ||
                offset.y < -RadiusXY || offset.y > RadiusXY ||
                offset.z < -RadiusZ || offset.z > RadiusZ ) {
                return query();
            }
            const int index = ( ( offset.z + RadiusZ ) * width + offset.y + RadiusXY ) * width +
                              offset.x + RadiusXY;
            std::optional<T> &entry = values_[index];
            if( !entry ) {
                entry = query();
            }
            return *entry;
        }
    private:
        static constexpr int width = RadiusXY * 2 + 1;
        std::array < std::optional<T>, width *width *( RadiusZ * 2 + 1 ) > values_{};
};

#endif // CATA_SRC_MONSTER_LOCAL_CACHE_H
