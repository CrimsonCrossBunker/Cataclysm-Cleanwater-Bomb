#include "explosion_light.h"

#include <algorithm>
#include <cmath>

#include "generic_factory.h"
#include "json.h"

generic_factory<explosion_light> &get_all_explosion_lights()
{
    static generic_factory<explosion_light> all_explosion_lights( "explosion lights" );
    return all_explosion_lights;
}

/** @relates string_id */
template<>
bool explosion_light_str_id::is_valid() const
{
    return get_all_explosion_lights().is_valid( *this );
}

/** @relates string_id */
template<>
const explosion_light &explosion_light_str_id::obj() const
{
    return get_all_explosion_lights().obj( *this );
}

namespace explosion_lights
{
const explosion_light_str_id default_blast( "default_blast" );
} // namespace explosion_lights

namespace
{
// Read an "[r, g, b]" array (0-255) into an array, leaving the default in place
// when the member is absent.
void read_rgb( const JsonObject &jo, std::string_view key, std::array<uint8_t, 3> &out )
{
    if( !jo.has_member( key ) ) {
        return;
    }
    std::vector<int> tmp = jo.get_int_array( key );
    if( tmp.size() != 3 ) {
        jo.throw_error_at( key, "explosion light colour must be an array of 3 integers (0-255)" );
        return;
    }
    for( int i = 0; i < 3; i++ ) {
        out[i] = static_cast<uint8_t>( std::clamp( tmp[i], 0, 255 ) );
    }
}

// Stable, allocation-free hash → [0,1) used for the per-tile flicker jitter.
float hash01( uint32_t x )
{
    // integer finalizer (xorshift-multiply), then take the top mantissa bits
    x ^= x >> 16;
    x *= 0x7feb352dU;
    x ^= x >> 15;
    x *= 0x846ca68bU;
    x ^= x >> 16;
    return static_cast<float>( x ) / static_cast<float>( 0xffffffffU );
}

// Same hash remapped to [-1, 1) for symmetric jitter offsets.
float hash_signed( uint32_t x )
{
    return hash01( x ) * 2.0f - 1.0f;
}
} // namespace

void explosion_light::load( const JsonObject &jo, std::string_view )
{
    read_rgb( jo, "color_a", color_a );
    read_rgb( jo, "color_b", color_b );

    int aa = alpha_a;
    optional( jo, was_loaded, "alpha_a", aa, aa );
    alpha_a = static_cast<uint8_t>( std::clamp( aa, 0, 255 ) );
    int ab = alpha_b;
    optional( jo, was_loaded, "alpha_b", ab, ab );
    alpha_b = static_cast<uint8_t>( std::clamp( ab, 0, 255 ) );

    optional( jo, was_loaded, "wave_travel", wave_travel, wave_travel );
    optional( jo, was_loaded, "wave_gap", wave_gap, wave_gap );
    optional( jo, was_loaded, "rise", rise, rise );
    optional( jo, was_loaded, "fade", fade, fade );
    optional( jo, was_loaded, "blend", blend, blend );
    optional( jo, was_loaded, "spread_jitter", spread_jitter, spread_jitter );
    optional( jo, was_loaded, "color_jitter", color_jitter, color_jitter );
    optional( jo, was_loaded, "flicker", flicker, flicker );

    // Phase-two shockwave distortion fields (consumed by the present-time warp
    // blit; see shockwave.h).
    optional( jo, was_loaded, "shockwave", shockwave, shockwave );
    optional( jo, was_loaded, "shockwave_strength", shockwave_strength, shockwave_strength );
    optional( jo, was_loaded, "shockwave_speed", shockwave_speed, shockwave_speed );
    optional( jo, was_loaded, "shockwave_thickness", shockwave_thickness, shockwave_thickness );
}

void explosion_light::check() const
{
    if( wave_travel < 0.0f ) {
        debugmsg( "explosion light %s: 'wave_travel' must be >= 0", id.str() );
    }
    if( wave_gap < 0.0f ) {
        debugmsg( "explosion light %s: 'wave_gap' must be >= 0", id.str() );
    }
    if( rise < 0.0f || fade < 0.0f || blend < 0.0f ) {
        debugmsg( "explosion light %s: 'rise'/'fade'/'blend' must be >= 0", id.str() );
    }
    if( spread_jitter < 0.0f || color_jitter < 0.0f || flicker < 0.0f ) {
        debugmsg( "explosion light %s: jitter/flicker values must be >= 0", id.str() );
    }
    if( shockwave_speed <= 0.0f ) {
        debugmsg( "explosion light %s: 'shockwave_speed' must be > 0", id.str() );
    }
    if( shockwave_thickness < 0.0f ) {
        debugmsg( "explosion light %s: 'shockwave_thickness' must be >= 0", id.str() );
    }
}

explosion_light_sample explosion_light::sample( float radial, float progress,
        uint32_t tile_seed, uint32_t frame_seed ) const
{
    radial = std::clamp( radial, 0.0f, 1.0f );
    progress = std::max( progress, 0.0f );

    // Per-tile stable arrival jitter: shifts this tile's wave times a little so
    // the expanding fronts are irregular rather than perfectly concentric. Same
    // every frame (keyed on tile_seed only), so the edge doesn't crawl. Tapered
    // to zero across the outermost ring so the blast's final outline stays round.
    const float rim_taper = std::clamp( ( 1.0f - radial ) / 0.18f, 0.0f, 1.0f );
    const float jitter = hash_signed( tile_seed ) * spread_jitter * rim_taper;

    // Arrival progress of each wave at this tile: it travels out from the centre
    // (radial * wave_travel), the three waves separated by wave_gap, all nudged
    // by the per-tile jitter.
    const float t1 = radial * wave_travel + jitter;                 // color_a front
    const float t2 = t1 + wave_gap;                                 // color_b front
    const float t3 = t2 + wave_gap;                                 // clear front

    // Before wave 1 reaches the tile it is dark.
    if( progress < t1 ) {
        return explosion_light_sample{ 0, 0, 0, 0 };
    }

    // Hue: A until wave 2 arrives, then a short blend to B, then hold B.
    float hue_mix;
    if( progress < t2 ) {
        hue_mix = 0.0f;
    } else if( blend <= 0.0f || progress >= t2 + blend ) {
        hue_mix = 1.0f;
    } else {
        hue_mix = ( progress - t2 ) / blend;
    }
    const auto mix = [&]( uint8_t a, uint8_t b ) -> float {
        return static_cast<float>( a ) + ( static_cast<float>( b ) - static_cast<float>( a ) ) * hue_mix;
    };
    float r = mix( color_a[0], color_b[0] );
    float g = mix( color_a[1], color_b[1] );
    float b = mix( color_a[2], color_b[2] );

    // Alpha (a translucent light cover, never opaque): quick rise to alpha_a
    // after wave 1, then a steady decay alpha_a -> alpha_b while the tile stays
    // lit (the light dims as it burns, but stays brighter than the environment),
    // then a quick fall to zero when wave 3 (the clear wave) arrives.
    const float fa = static_cast<float>( alpha_a );
    const float fb = static_cast<float>( alpha_b );
    float alpha;
    if( progress < t1 + rise ) {
        alpha = rise <= 0.0f ? fa : fa * ( progress - t1 ) / rise;
    } else if( progress < t3 ) {
        const float lit_span = std::max( t3 - ( t1 + rise ), 0.0001f );
        const float k = std::clamp( ( progress - ( t1 + rise ) ) / lit_span, 0.0f, 1.0f );
        alpha = fa + ( fb - fa ) * k;
    } else if( fade <= 0.0f || progress >= t3 + fade ) {
        alpha = 0.0f;
    } else {
        alpha = fb * ( 1.0f - ( progress - t3 ) / fade );
    }
    alpha = std::max( alpha, 0.0f );

    // Small stable per-tile colour grain for texture (keyed on tile_seed so it
    // doesn't shimmer). Deliberately tiny.
    if( color_jitter > 0.0f ) {
        const float gr = hash_signed( tile_seed * 2654435761U + 7U ) * color_jitter * 255.0f;
        r += gr;
        g += gr;
        b += gr;
    }

    // Flicker: live per-frame jitter on brightness and alpha for an uneven edge.
    if( flicker > 0.0f ) {
        const float j = hash_signed( frame_seed ) * flicker;
        alpha *= std::clamp( 1.0f + j, 0.0f, 1.5f );
        const float jb = hash_signed( frame_seed * 2654435761U + 1U ) * flicker;
        const float bright = std::clamp( 1.0f + jb, 0.6f, 1.4f );
        r *= bright;
        g *= bright;
        b *= bright;
    }

    explosion_light_sample out;
    out.r = static_cast<uint8_t>( std::clamp( r, 0.0f, 255.0f ) );
    out.g = static_cast<uint8_t>( std::clamp( g, 0.0f, 255.0f ) );
    out.b = static_cast<uint8_t>( std::clamp( b, 0.0f, 255.0f ) );
    out.a = static_cast<uint8_t>( std::clamp( alpha, 0.0f, 255.0f ) );
    return out;
}

void explosion_lights::load( const JsonObject &jo, const std::string &src )
{
    get_all_explosion_lights().load( jo, src );
}

void explosion_lights::check_consistency()
{
    get_all_explosion_lights().check();
}

void explosion_lights::reset()
{
    get_all_explosion_lights().reset();
}

const std::vector<explosion_light> &explosion_lights::get_all()
{
    return get_all_explosion_lights().get_all();
}
