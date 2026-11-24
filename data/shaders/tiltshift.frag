// Tilt-shift-style selective blur for the final 3D terrain composite.
// Only distant structural LOD softens; detailed terrain and UI stay sharp.
// The offscreen alpha channel also carries creature relations for outlines.

#version 450

layout(set = 2, binding = 0) uniform sampler2D u_atlas;

layout(location = 0) in vec4 v_vertex_color;
layout(location = 1) in vec2 v_uv;
layout(location = 0) out vec4 out_color;

int creature_class( float alpha )
{
    if( alpha >= 0.125 && alpha < 0.375 ) {
        return 1;
    }
    if( alpha >= 0.375 && alpha < 0.625 ) {
        return 2;
    }
    if( alpha >= 0.625 && alpha < 0.875 ) {
        return 3;
    }
    return 0;
}

vec3 creature_outline_color( int relation )
{
    if( relation == 1 ) {
        return vec3( 1.0, 0.08, 0.08 );
    }
    if( relation == 2 ) {
        return vec3( 1.0, 0.85, 0.05 );
    }
    return vec3( 0.08, 1.0, 0.18 );
}

void main()
{
    vec4 sharp = texture( u_atlas, v_uv );
    const ivec2 size = textureSize( u_atlas, 0 );
    const ivec2 pixel = clamp( ivec2( v_uv * vec2( size ) ), ivec2( 0 ), size - 1 );
    // Read the mask by texel rather than interpolating distinct alpha markers.
    const float mask_alpha = texelFetch( u_atlas, pixel, 0 ).a;
    float edge = abs( v_uv.y - 0.5 ) * 2.0;
    float lod_mask = mask_alpha < 0.125 ? 1.0 : 0.0;
    float amount = smoothstep( 0.30, 0.82, edge ) * lod_mask;
    vec4 result = sharp;
    if( amount > 0.001 ) {
        vec2 offset = 2.0 / vec2( size );
        vec4 soft = sharp * 0.4;
        soft += texture( u_atlas, v_uv + vec2( offset.x, 0.0 ) ) * 0.1;
        soft += texture( u_atlas, v_uv - vec2( offset.x, 0.0 ) ) * 0.1;
        soft += texture( u_atlas, v_uv + vec2( 0.0, offset.y ) ) * 0.1;
        soft += texture( u_atlas, v_uv - vec2( 0.0, offset.y ) ) * 0.1;
        soft += texture( u_atlas, v_uv + offset ) * 0.05;
        soft += texture( u_atlas, v_uv - offset ) * 0.05;
        soft += texture( u_atlas, v_uv + vec2( offset.x, -offset.y ) ) * 0.05;
        soft += texture( u_atlas, v_uv + vec2( -offset.x, offset.y ) ) * 0.05;
        result = mix( sharp, soft, amount );
    }

    // Outline only the visible silhouette: existing creature pixels retain
    // their own color, and depth-occluded creatures never reach this mask.
    if( creature_class( mask_alpha ) == 0 ) {
        const ivec2 directions[8] = ivec2[8](
            ivec2( -1, 0 ), ivec2( 1, 0 ), ivec2( 0, -1 ), ivec2( 0, 1 ),
            ivec2( -1, -1 ), ivec2( 1, -1 ), ivec2( -1, 1 ), ivec2( 1, 1 ) );
        bool outlined = false;
        vec3 outline_color = vec3( 0.0 );
        for( int i = 0; i < 8 && !outlined; ++i ) {
            const ivec2 sample_pos = clamp( pixel + directions[i] * 2, ivec2( 0 ), size - 1 );
            const int relation = creature_class( texelFetch( u_atlas, sample_pos, 0 ).a );
            if( relation != 0 ) {
                outline_color = creature_outline_color( relation );
                outlined = true;
            }
        }
        if( outlined ) {
            result.rgb = outline_color;
        }
    }
    out_color = vec4( result.rgb, 1.0 ) * v_vertex_color;
}
