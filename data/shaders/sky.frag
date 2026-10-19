// Sky pass: procedural sky rendered behind the world (the world pass loads
// over this). Reconstructs the view ray from NDC and the camera basis, then
// paints a daylight-driven gradient, the sun disc (real azimuth/altitude from
// the game calendar), and fbm clouds drifting with the wind. Below the
// horizon: a dark void so the world edge never reads as sky.
// SDL GPU fragment uniform buffers live in set 3.

#version 450

layout(set = 3, binding = 0) uniform SkyUBO {
    vec4 cam_right;    // xyz = camera right basis
    vec4 cam_up;       // xyz = camera up basis
    vec4 cam_forward;  // xyz = camera forward basis
    vec4 sun_dir;      // xyz = direction toward the sun (world), w = daylight 0..1
    vec4 params;       // x = tan(fov/2), y = aspect, z = cloudiness 0..1
    vec4 wind;         // xy = cloud drift offset in noise space
};

layout(location = 0) in vec2 v_ndc;
layout(location = 0) out vec4 out_color;

float hash2( vec2 p )
{
    return fract( sin( dot( p, vec2( 127.1, 311.7 ) ) ) * 43758.5453 );
}

float vnoise( vec2 p )
{
    vec2 i = floor( p );
    vec2 f = fract( p );
    vec2 u = f * f * ( 3.0 - 2.0 * f );
    return mix( mix( hash2( i ), hash2( i + vec2( 1.0, 0.0 ) ), u.x ),
                mix( hash2( i + vec2( 0.0, 1.0 ) ), hash2( i + vec2( 1.0, 1.0 ) ), u.x ),
                u.y );
}

float fbm( vec2 p )
{
    return vnoise( p ) * 0.5 + vnoise( p * 2.03 ) * 0.3 + vnoise( p * 4.09 ) * 0.2;
}

void main()
{
    // NDC -> view ray, same basis convention as the world pass
    vec3 ray = normalize( cam_forward.xyz
                          + cam_right.xyz * ( v_ndc.x * params.x * params.y )
                          + cam_up.xyz * ( v_ndc.y * params.x ) );
    float daylight = clamp( sun_dir.w, 0.0, 1.0 );

    // gradient between horizon and zenith, keyed to daylight
    vec3 zenith = mix( vec3( 0.004, 0.005, 0.012 ), vec3( 0.22, 0.42, 0.75 ), daylight );
    vec3 horizon = mix( vec3( 0.008, 0.009, 0.018 ), vec3( 0.55, 0.66, 0.82 ), daylight );
    vec3 col;
    if( ray.z >= 0.0 ) {
        col = mix( horizon, zenith, pow( ray.z, 0.6 ) );
    } else {
        vec3 voidc = vec3( 0.010, 0.010, 0.014 ) * ( 0.3 + 0.7 * daylight );
        col = mix( horizon, voidc, clamp( -ray.z * 6.0, 0.0, 1.0 ) );
    }

    // sun disc + halo (hidden below the horizon or at night)
    vec3 sd = sun_dir.xyz;
    if( sd.z > -0.05 && daylight > 0.01 ) {
        float d = dot( ray, normalize( sd ) );
        float disc = smoothstep( 0.9994, 0.9998, d );
        float halo = pow( max( d, 0.0 ), 64.0 ) * 0.25;
        col += ( vec3( 1.0, 0.95, 0.8 ) * disc + vec3( 1.0, 0.9, 0.7 ) * halo )
               * daylight * ( 1.0 - params.z * 0.6 );
    }

    // clouds: intersect the ray with a high plane, fbm noise drifting with the
    // wind; coverage scales with the weather-derived cloudiness
    if( ray.z > 0.02 ) {
        vec2 cpos = ray.xy / ray.z * 0.35 + wind.xy;
        float n = fbm( cpos );
        float th = 1.02 - params.z * 0.8;
        float cov = smoothstep( th - 0.10, th + 0.18, n );
        cov *= smoothstep( 0.02, 0.12, ray.z ); // fade out near the horizon
        vec3 cloud_col = mix( vec3( 0.03, 0.03, 0.05 ),
                              vec3( 0.95, 0.96, 1.0 ), daylight );
        // a second noise sample shades the cloud body so it reads as puffy,
        // not a flat sticker
        cloud_col *= 0.6 + 0.5 * fbm( cpos * 1.7 + 3.1 );
        col = mix( col, cloud_col, min( cov * 1.15, 0.95 ) );
    }

    out_color = vec4( col, 1.0 );
}
