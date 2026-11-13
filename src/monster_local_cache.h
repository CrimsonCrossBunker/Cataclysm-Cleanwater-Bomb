#pragma once
#ifndef CATA_SRC_MONSTER_LOCAL_CACHE_H
#define CATA_SRC_MONSTER_LOCAL_CACHE_H

#include <array>
#include <optional>

// Stack-local memoization for one read-only monster query. Store false/null
// results too, and never reuse entries across movement or gameplay effects.
template<typename T, int RadiusXY, int RadiusZ>
class monster_local_cache
{
    public:
        template<typename Query>
        T get( int x, int y, int z, Query &&query ) {
            if( x < -RadiusXY || x > RadiusXY || y < -RadiusXY || y > RadiusXY ||
                z < -RadiusZ || z > RadiusZ ) {
                return query();
            }
            auto &entry = values_[( ( z + RadiusZ ) * width + y + RadiusXY ) * width + x + RadiusXY];
            if( !entry ) {
                entry = query();
            }
            return *entry;
        }
    private:
        static constexpr int width = RadiusXY * 2 + 1;
        std::array<std::optional<T>, width * width * ( RadiusZ * 2 + 1 )> values_{};
};

#endif // CATA_SRC_MONSTER_LOCAL_CACHE_H
