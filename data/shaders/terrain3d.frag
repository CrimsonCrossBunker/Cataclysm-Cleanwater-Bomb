// Experimental 3D terrain renderer: tileset atlas sampling with alpha cutout,
// plus a screen-door occlusion mask hiding geometry between camera and player.
// SDL GPU fragment samplers live in set 2, fragment uniform buffers in set 3.

#version 450
#extension GL_GOOGLE_include_directive : require

#include "memory_presets.glsl"
#include "nightvision_presets.glsl"

layout(set = 2, binding = 0) uniform sampler2D atlas_tex;

layout(set = 3, binding = 0) uniform FragUBO {
    vec4 eye_pos;      // xyz = camera position (scene coords)
    vec4 player_pos;   // xyz = player position (scene coords)
    vec4 cam_right;    // xyz = camera right basis (screen-horizontal)
    vec4 cam_up;       // xyz = camera up basis (screen-vertical)
    vec4 mask_params;  // x = inner radius along cam_right, y = inner radius along
                       // cam_up, z = player's ground plane z, w = mask enabled
    vec4 memory_params; // x = named memory preset 0..3, y = 1 for the custom mixer
    vec4 memory_dark;   // rgb = custom dark color, w = gamma
    vec4 memory_light;  // rgb = custom light color
    vec4 nv_params;     // x = 1 in a night vision frame (v_color.a then carries
                        // the tile light), y = night floor, z = overexpose start
};

layout(location = 0) in vec4 v_color;
layout(location = 1) in vec2 v_uv;
layout(location = 2) in float v_flags;
layout(location = 3) in float v_shade;
layout(location = 4) in vec3 v_world;

layout(location = 0) out vec4 out_color;

void main()
{
    int flags = int( v_flags + 0.5 );
    float hash = fract( sin( dot( gl_FragCoord.xy,
                                  vec2( 12.9898, 78.233 ) ) ) * 43758.5453 );

    // camera->player occlusion mask: hide geometry near the eye-to-player
    // segment so walls and roofs never block the player. the cross-section is
    // an ellipse aligned with the screen (wider than tall), the edge band is
    // softened with a screen-door dither instead of alpha blending (no sorting
    // needed). only fragments above the player's own floor are masked, so the
    // ground the player stands on stays put
    if( mask_params.w > 0.5 && v_world.z > mask_params.z + 0.15 ) {
        vec3 pa = v_world - eye_pos.xyz;
        vec3 ba = player_pos.xyz - eye_pos.xyz;
        float t_raw = dot( pa, ba ) / max( dot( ba, ba ), 1e-6 );
        float t = clamp( t_raw, 0.0, 1.0 );
        vec3 off = pa - ba * t;
        // offset from the axis in screen-aligned coordinates, normalized by the
        // ellipse radii: de <= 1 fully hidden, >= 1.5 fully visible
        float er = dot( off, cam_right.xyz ) / mask_params.x;
        float eu = dot( off, cam_up.xyz ) / mask_params.y;
        float de = sqrt( er * er + eu * eu );
        // also fade out past the player along the axis: the wall the player is
        // FACING (beyond them from the camera) must stay readable
        float hide = ( 1.0 - smoothstep( 1.0, 1.5, de ) ) *
                     ( 1.0 - smoothstep( 0.9, 1.1, t_raw ) );
        if( hash < hide ) {
            discard;
        }
    }

    // ghost (bit5): dithered 50% transparency for the levels above an indoor
    // column the player can see into — the roof stays perceptible but the
    // interior shows through
    if( ( flags & 32 ) != 0 && hash > 0.5 ) {
        discard;
    }

    bool textured = ( flags & 1 ) != 0;
    bool no_discard = ( flags & 2 ) != 0;
    vec4 sampled = vec4( 1.0 );
    if( textured ) {
        sampled = texture( atlas_tex, v_uv );
        if( !no_discard && sampled.a < 0.1 ) {
            discard;
        }
    }
    vec3 rgb = v_color.rgb * sampled.rgb;
    // remembered terrain (bit6): 2D draws the map-memory overlay unlit, colored
    // by MEMORY_MAP_MODE (a named preset or the custom RGB/gamma mixer), so the
    // normal light tone and face shading do not apply
    if( ( flags & 64 ) != 0 ) {
        vec3 mem = memory_params.y > 0.5
                   ? memory_mixer( rgb, memory_dark.rgb, memory_light.rgb, memory_dark.w )
                   : memory_preset( int( memory_params.x + 0.5 ), rgb );
        out_color = vec4( mem, 1.0 );
        return;
    }
    // night vision goggles (NV_GREEN_TOGGLE): 2D's reference_night_rgb. the
    // sprite color goes through the green ramp, dimmed by the tile light and
    // handing over to the overexposed look past the light threshold; the sun
    // face shade still shapes the surface. v_color.a carries the tile light in
    // an NV frame instead of the saturation
    if( nv_params.x > 0.5 ) {
        vec3 base = textured ? sampled.rgb : v_color.rgb;
        float light = clamp( v_color.a, 0.0, 1.0 );
        float av = ( base.r + base.g + base.b ) / 3.0;
        float night = min( av * ( av * 0.75 + 64.0 / 255.0 ) + 16.0 / 255.0, 1.0 );
        float over = min( 64.0 / 255.0 + av * ( av * 0.25 + 192.0 / 255.0 ), 1.0 );
        vec3 dim = nightvision_green( night * mix( nv_params.y, 1.0, light ) );
        vec3 nv = mix( dim, nightvision_green( over ),
                       smoothstep( nv_params.z, 1.0, light ) );
        out_color = vec4( nv * v_shade, 1.0 );
        return;
    }
    // low light drains color, as 2D's lit shader does; v_color.a carries the
    // tile light's saturation (1 = full color, 0 = grayscale)
    float gray = ( rgb.r + rgb.g + rgb.b ) / 3.0;
    rgb = mix( vec3( gray ), rgb, v_color.a );
    out_color = vec4( rgb * v_shade, 1.0 );
}
