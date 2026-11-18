// Tilt-shift-style selective blur for the final 3D terrain composite.
// The central focus band stays sharp; the upper and lower edges soften.

#version 450

layout(set = 2, binding = 0) uniform sampler2D u_atlas;

layout(location = 0) in vec4 v_vertex_color;
layout(location = 1) in vec2 v_uv;
layout(location = 0) out vec4 out_color;

void main()
{
    vec4 sharp = texture( u_atlas, v_uv );
    float edge = abs( v_uv.y - 0.5 ) * 2.0;
    float amount = smoothstep( 0.30, 0.82, edge );
    vec4 result = sharp;
    if( amount > 0.001 ) {
        vec2 offset = 2.0 / vec2( textureSize( u_atlas, 0 ) );
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
    out_color = vec4( result.rgb, sharp.a ) * v_vertex_color;
}
