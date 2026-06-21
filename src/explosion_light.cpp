#include "explosion_light.h"

#include <algorithm>
#include <cmath>

#include "debug.h"
#include "enum_conversions.h"
#include "generic_factory.h"
#include "json.h"

namespace io
{
template<>
std::string enum_to_string<vfx_easing>( vfx_easing data )
{
    switch( data ) {
        case vfx_easing::linear: return "linear";
        case vfx_easing::ease_in: return "ease_in";
        case vfx_easing::ease_out: return "ease_out";
        case vfx_easing::smoothstep: return "smoothstep";
        case vfx_easing::last: break;
    }
    cata_fatal( "Invalid vfx_easing" );
}
} // namespace io


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
const explosion_light_str_id muzzle_flash( "muzzle_flash" );
const explosion_light_str_id impact_spark( "impact_spark" );
const explosion_light_str_id bullet_tracer( "bullet_tracer" );
const explosion_light_str_id beam_laser( "beam_laser" );
const explosion_light_str_id beam_plasma( "beam_plasma" );
const explosion_light_str_id beam_lightning( "beam_lightning" );
const explosion_light_str_id flashbang_blast( "flashbang_blast" );
const explosion_light_str_id emp_blast( "emp_blast" );
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

// Apply an easing curve to a normalised parameter in [0,1].
float ease( vfx_easing e, float t )
{
    t = std::clamp( t, 0.0f, 1.0f );
    switch( e ) {
        case vfx_easing::linear:
            return t;
        case vfx_easing::ease_in:
            return t * t;
        case vfx_easing::ease_out:
            return 1.0f - ( 1.0f - t ) * ( 1.0f - t );
        case vfx_easing::smoothstep:
            return t * t * ( 3.0f - 2.0f * t );
        case vfx_easing::last:
            break;
    }
    return t;
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

    // N-stop colour ramp. Each entry: { "color": [r,g,b], "alpha": int }. When the
    // member is absent we leave `stops` empty here and synthesise a two-stop ramp
    // from the legacy color_a/color_b fields below, so old recipes are unchanged.
    if( jo.has_member( "stops" ) ) {
        stops.clear();
        for( const JsonObject so : jo.get_array( "stops" ) ) {
            light_stop ls;
            read_rgb( so, "color", ls.color );
            int a = ls.alpha;
            optional( so, false, "alpha", a, a );
            ls.alpha = static_cast<uint8_t>( std::clamp( a, 0, 255 ) );
            stops.push_back( ls );
        }
    }

    optional( jo, was_loaded, "easing", easing, easing );

    optional( jo, was_loaded, "duration_base_ms", duration_base_ms, duration_base_ms );
    optional( jo, was_loaded, "duration_per_tile_ms", duration_per_tile_ms, duration_per_tile_ms );
    optional( jo, was_loaded, "duration_min_ms", duration_min_ms, duration_min_ms );
    optional( jo, was_loaded, "duration_max_ms", duration_max_ms, duration_max_ms );

    optional( jo, was_loaded, "screen_shake_magnitude", screen_shake_magnitude,
              screen_shake_magnitude );
    optional( jo, was_loaded, "screen_shake_duration_ms", screen_shake_duration_ms,
              screen_shake_duration_ms );

    // Synthesise the two-stop compatibility ramp from the legacy fields whenever a
    // recipe doesn't supply its own `stops`, so the rest of the code only ever
    // deals with the `stops` vector. (color_a/alpha_a -> color_b/alpha_b.)
    if( stops.empty() ) {
        stops.push_back( light_stop{ color_a, alpha_a } );
        stops.push_back( light_stop{ color_b, alpha_b } );
    }

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
    if( stops.empty() ) {
        debugmsg( "explosion light %s: must have at least one colour stop", id.str() );
    }
    if( duration_min_ms <= 0.0f || duration_max_ms < duration_min_ms ) {
        debugmsg( "explosion light %s: need 0 < duration_min_ms <= duration_max_ms", id.str() );
    }
    if( screen_shake_magnitude < 0.0f || screen_shake_duration_ms < 0.0f ) {
        debugmsg( "explosion light %s: screen shake values must be >= 0", id.str() );
    }
}

explosion_light_sample explosion_light::sample( float radial, float progress,
        uint32_t tile_seed, uint32_t frame_seed, float blast_radius_tiles ) const
{
    radial = std::clamp( radial, 0.0f, 1.0f );
    progress = std::max( progress, 0.0f );

    // Per-tile stable arrival jitter: shifts this tile's wave times a little so
    // the expanding fronts are irregular rather than perfectly concentric. Same
    // every frame (keyed on tile_seed only), so the edge doesn't crawl. Tapered
    // to zero across the outermost ring so the blast's final outline stays round
    // — but only for blasts big enough for that ring to matter. The taper band's
    // width scales from 0 (a 1-2 tile blast: no taper, so its handful of tiles
    // keep full jitter and don't collapse to a fixed symmetric shape) up to the
    // full 0.18 for a blast of ~5+ tiles' radius. Without this, a small blast is
    // almost entirely "rim" and the taper kills all of its randomness.
    const float taper_band = 0.18f * std::clamp( ( blast_radius_tiles - 1.5f ) / 4.0f, 0.0f, 1.0f );
    const float rim_taper = taper_band <= 0.0f
                            ? 1.0f
                            : std::clamp( ( 1.0f - radial ) / taper_band, 0.0f, 1.0f );
    const float jitter = hash_signed( tile_seed ) * spread_jitter * rim_taper;

    // Resolve the colour ramp. After load() `stops` is always populated, but
    // sample() is also exercised by unit tests that build the recipe directly and
    // leave it empty — fall back to the legacy two-stop ramp so both paths agree.
    light_stop compat[2];
    const light_stop *sp = stops.data();
    int n = static_cast<int>( stops.size() );
    if( n == 0 ) {
        compat[0] = light_stop{ color_a, alpha_a };
        compat[1] = light_stop{ color_b, alpha_b };
        sp = compat;
        n = 2;
    }

    // Wave arrival at this tile: it travels out from the centre (radial *
    // wave_travel), then one front per stop separated by wave_gap, all nudged by
    // the per-tile jitter. front_i = t0 + i*wave_gap; the clear front is i == n.
    const float t0 = radial * wave_travel + jitter;
    const float t_clear = t0 + static_cast<float>( n ) * wave_gap;

    // Before the first wave reaches the tile it is dark.
    if( progress < t0 ) {
        return explosion_light_sample{ 0, 0, 0, 0 };
    }

    // Hue: hold the most recently arrived stop's colour; at each front blend from
    // the previous stop to the new one over `blend`, shaped by the easing curve.
    int f = 0;
    for( int i = 1; i < n; i++ ) {
        if( progress >= t0 + static_cast<float>( i ) * wave_gap ) {
            f = i;
        } else {
            break;
        }
    }
    float hue_mix = 0.0f;
    if( f > 0 ) {
        const float front = t0 + static_cast<float>( f ) * wave_gap;
        const float bt = blend <= 0.0f ? 1.0f : std::clamp( ( progress - front ) / blend, 0.0f, 1.0f );
        hue_mix = ease( easing, bt );
    }
    const int lo = f > 0 ? f - 1 : 0;
    const auto mix = [&]( int ch ) -> float {
        const float a = static_cast<float>( sp[lo].color[ch] );
        const float b = static_cast<float>( sp[f].color[ch] );
        return a + ( b - a ) * hue_mix;
    };
    float r = mix( 0 );
    float g = mix( 1 );
    float b = mix( 2 );


    // Alpha (a translucent light cover, never opaque): a quick rise to the first
    // stop's alpha after the first front, then the stop alphas as keyframes spread
    // evenly across the lit span (so the cover morphs through them as it burns),
    // then a quick fall to zero when the clear front arrives. With two stops this
    // is exactly the historical alpha_a -> alpha_b decay across the whole lit life.
    const float a_first = static_cast<float>( sp[0].alpha );
    float alpha;
    if( progress < t0 + rise ) {
        alpha = rise <= 0.0f ? a_first : a_first * ease( easing, ( progress - t0 ) / rise );
    } else if( progress < t_clear ) {
        const float lit_span = std::max( t_clear - ( t0 + rise ), 0.0001f );
        // Position in [0,1] across the lit span, mapped onto the n stop keyframes.
        const float u = std::clamp( ( progress - ( t0 + rise ) ) / lit_span, 0.0f, 1.0f );
        if( n == 1 ) {
            alpha = a_first;
        } else {
            const float scaled = u * static_cast<float>( n - 1 );
            const int k = std::min( static_cast<int>( scaled ), n - 2 );
            const float seg = ease( easing, scaled - static_cast<float>( k ) );
            const float ka = static_cast<float>( sp[k].alpha );
            const float kb = static_cast<float>( sp[k + 1].alpha );
            alpha = ka + ( kb - ka ) * seg;
        }
    } else if( fade <= 0.0f || progress >= t_clear + fade ) {
        alpha = 0.0f;
    } else {
        const float last_a = static_cast<float>( sp[n - 1].alpha );
        alpha = last_a * ( 1.0f - ease( easing, ( progress - t_clear ) / fade ) );
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

float explosion_light::duration_ms( float blast_radius_tiles ) const
{
    // check() warns on a malformed recipe (min<=0 or max<min) but does not repair
    // it, so guard the bounds here: std::clamp with lo>hi is undefined behaviour.
    const float hi = std::max( duration_min_ms, duration_max_ms );
    return std::clamp( duration_base_ms + blast_radius_tiles * duration_per_tile_ms,
                       duration_min_ms, hi );
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
