// Experimental 3D terrain renderer: tileset atlas sampling with alpha cutout,
// plus a screen-door occlusion mask hiding geometry between camera and player.
// SDL GPU fragment samplers live in set 2, fragment uniform buffers in set 3.

#version 450

layout(set = 2, binding = 0) uniform sampler2D atlas_tex;

layout(set = 3, binding = 0) uniform FragUBO {
    vec4 eye_pos;      // xyz = camera position (scene coords)
    vec4 player_pos;   // xyz = player position (scene coords)
    vec4 cam_right;    // xyz = camera right basis (screen-horizontal)
    vec4 cam_up;       // xyz = camera up basis (screen-vertical)
    vec4 mask_params;  // x = inner radius along cam_right, y = inner radius along
                       // cam_up, z = player's ground plane z, w = mask enabled
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
    if( textured ) {
        vec4 t = texture( atlas_tex, v_uv );
        if( !no_discard && t.a < 0.1 ) {
            discard;
        }
        out_color = vec4( t.rgb * v_color.rgb * v_shade, 1.0 );
    } else {
        // no tileset sprite: flat instance color (hash fallback)
        out_color = vec4( v_color.rgb * v_shade, 1.0 );
    }
}
