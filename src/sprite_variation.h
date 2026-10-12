#pragma once
#ifndef CATA_SRC_SPRITE_VARIATION_H
#define CATA_SRC_SPRITE_VARIATION_H

#include <cstdint>
#include <utility>

namespace sprite_variation
{
struct seed_request {
    bool has_choices;
    // Legacy weather draws consume gameplay RNG even without sprite choices.
    bool consumes_gameplay_rng;
};

// Call on the renderer owner. Resolve may query live state or gameplay RNG;
// it runs immediately, is never retained, and must not be dispatched to workers.
template<typename Resolver>
std::uint32_t capture_seed( seed_request request, Resolver &&resolve )
{
    if( !request.has_choices && !request.consumes_gameplay_rng ) {
        return 0;
    }
    return std::forward<Resolver>( resolve )();
}

// Pure 32-bit legacy variation key. No world, registry, RNG, clock or SDL input.
// Inline because this small kernel is called for each varied sprite.
inline std::uint32_t mix_seed( std::uint32_t seed ) noexcept
{
    const auto rotate = []( std::uint32_t value, int shift ) {
        return ( value << shift ) | ( value >> ( 32 - shift ) );
    };
    // Public-domain lookup3 final mixing sequence used by the renderer.
    std::uint32_t a = seed;
    std::uint32_t b = -seed;
    std::uint32_t c = seed * seed;
    c ^= b;
    c -= rotate( b, 14 );
    a ^= c;
    a -= rotate( c, 11 );
    b ^= a;
    b -= rotate( a, 25 );
    c ^= b;
    c -= rotate( b, 16 );
    a ^= c;
    a -= rotate( c, 4 );
    b ^= a;
    b -= rotate( a, 14 );
    c ^= b;
    c -= rotate( b, 24 );
    return c;
}
} // namespace sprite_variation

#endif // CATA_SRC_SPRITE_VARIATION_H
