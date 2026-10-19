// Experimental 3D terrain renderer: instanced boxes / cross-quads / yaw-billboards,
// textured from the tileset atlas.
// SDL GPU vertex uniform buffers live in set 1.

#version 450

layout(location = 0) in vec3 a_pos;         // box: [0,1]^3 corner; xquad: [0,1]^2 diag x [0,1] up; billboard: x[-.5,.5], y[0,1]
layout(location = 1) in vec3 a_aux;         // box: face normal; xquad/billboard: (u, v, unused)
layout(location = 2) in vec3 a_inst_pos;    // tile grid coords (player-relative); billboard: bottom-center anchor
layout(location = 3) in vec3 a_inst_scale;  // box/xquad: size in meters; billboard: x=width, y=height
layout(location = 4) in vec2 a_inst_uv0;    // atlas uv, top-left
layout(location = 5) in vec2 a_inst_uv1;    // atlas uv, bottom-right
layout(location = 6) in vec4 a_inst_color;  // rgb = light tint
layout(location = 7) in float a_inst_flags; // bit0: textured; bit1: no cutout; bit2-3: top uv rotation; bit4: side strip
layout(location = 8) in float a_inst_pad;   // bit4 mode: strip v coordinate (sprite bottom edge)

layout(set = 1, binding = 0) uniform UBO {
    mat4 mvp;
    vec4 cam_right;  // xyz: camera right on the ground plane (billboard facing)
    vec4 cam_up;     // xyz: world up (billboard facing)
    vec4 params;     // x = mode: 0 box, 1 static xquad, 2 yaw billboard, 3 cardinal-snapped billboard, 4 axis quad (fence), 5 flat horizontal quad
    vec4 sun_dir;    // xyz = direction toward the sun (world), w = 1 when the sun is up
};

layout(location = 0) out vec4 v_color;
layout(location = 1) out vec2 v_uv;
layout(location = 2) out float v_flags;
layout(location = 3) out float v_shade;
layout(location = 4) out vec3 v_world;

void main()
{
    int mode = int(params.x + 0.5);
    vec3 world;
    vec2 uv_local;
    float shade;
    if( mode == 2 || mode == 3 ) {
        // yaw billboard: rotate the bottom-centered quad around world-up to face
        // the camera; mode 3 snaps the facing to the nearest cardinal axis so
        // furniture steps in 90 degrees instead of rotating continuously
        vec3 rgt = cam_right.xyz;
        if( mode == 3 ) {
            if( abs( rgt.x ) >= abs( rgt.y ) ) {
                rgt = vec3( sign( rgt.x ), 0.0, 0.0 );
            } else {
                rgt = vec3( 0.0, sign( rgt.y ), 0.0 );
            }
        }
        world = a_inst_pos + rgt * ( a_pos.x * a_inst_scale.x )
              + cam_up.xyz * ( a_pos.y * a_inst_scale.y );
        uv_local = a_aux.xy;
        shade = 0.95;
    } else if( mode == 4 ) {
        // flat vertical quad standing on a fixed axis (fences): a_inst_pad
        // > 0.5 = runs N-S (quad spans y), else runs E-W (spans x)
        vec3 axis = a_inst_pad > 0.5 ? vec3( 0.0, 1.0, 0.0 ) : vec3( 1.0, 0.0, 0.0 );
        world = a_inst_pos + axis * ( a_pos.x * a_inst_scale.x )
              + cam_up.xyz * ( a_pos.y * a_inst_scale.y );
        uv_local = a_aux.xy;
        shade = 0.95;
    } else if( mode == 5 ) {
        // flat horizontal quad (floor overlays, cutout floor tiles): no
        // thickness, so no side faces that would sample transparent sprite rows
        world = a_inst_pos + vec3( a_pos.x * a_inst_scale.x, a_pos.y * a_inst_scale.y, 0.0 );
        // same quarter-turn UV rotation as a box top face: 2D rotates a
        // single-sprite connection tile by rota % 4
        int iflags = int( a_inst_flags + 0.5 );
        int rota = ( iflags >> 2 ) & 3;
        vec2 q = a_pos.xy;
        if( rota == 1 ) {
            q = vec2( q.y, 1.0 - q.x );
        } else if( rota == 2 ) {
            q = vec2( 1.0 - q.x, 1.0 - q.y );
        } else if( rota == 3 ) {
            q = vec2( 1.0 - q.y, q.x );
        }
        uv_local = q;
        // same sun shading as a box top face (normal = +z)
        vec3 light_dir = sun_dir.w > 0.5 ? normalize( sun_dir.xyz )
                         : normalize( vec3( 0.4, 0.3, 0.85 ) );
        shade = 0.55 + 0.45 * max( light_dir.z, 0.0 );
    } else if( mode == 1 ) {
        // static crossed quad pair; uv comes from the vertex
        world = a_inst_pos + a_pos * a_inst_scale;
        uv_local = a_aux.xy;
        shade = 0.95;
    } else {
        // box: derive face-local uv from the corner position and the face normal
        world = a_inst_pos + a_pos * a_inst_scale;
        vec3 n = a_aux;
        int iflags = int( a_inst_flags + 0.5 );
        int rota = ( iflags >> 2 ) & 3;
        if( abs( n.z ) > 0.5 ) {
            // top/bottom face: quarter-turn rotation around the tile center
            // (multitile connection orientation, e.g. pool edges, fences)
            vec2 q = a_pos.xy;
            if( rota == 1 ) {
                q = vec2( q.y, 1.0 - q.x );
            } else if( rota == 2 ) {
                q = vec2( 1.0 - q.x, 1.0 - q.y );
            } else if( rota == 3 ) {
                q = vec2( 1.0 - q.y, q.x );
            }
            uv_local = q;
        } else {
            float su = ( abs( n.y ) > 0.5 ) ? a_pos.x : a_pos.y;
            float sv = 1.0 - a_pos.z;
            if( ( iflags & 16 ) != 0 ) {
                // side faces: a horizontal color strip near the sprite's bottom
                // edge instead of the whole sprite stretched over the face
                sv = ( a_inst_pad - a_inst_uv0.y ) / max( a_inst_uv1.y - a_inst_uv0.y, 1e-6 );
            }
            uv_local = vec2( su, sv );
            if( ( iflags & 32 ) != 0 ) {
                // fence slab: the wide side faces show the (canonically N-S
                // drawn) sprite rotated 90 degrees as a frontal fence view
                bool wide = ( abs( n.y ) > 0.5 && a_inst_scale.x >= a_inst_scale.y ) ||
                            ( abs( n.x ) > 0.5 && a_inst_scale.y > a_inst_scale.x );
                if( wide ) {
                    uv_local = vec2( uv_local.y, 1.0 - uv_local.x );
                }
            }
        }
        // sun-lit faces: real sun direction while the sun is up, fixed
        // up-south-east fallback at night so faces stay readable
        vec3 light_dir = sun_dir.w > 0.5 ? normalize( sun_dir.xyz )
                         : normalize( vec3( 0.4, 0.3, 0.85 ) );
        float diff = max( dot( n, light_dir ), 0.0 );
        shade = 0.55 + 0.45 * diff;
    }
    v_world = world;
    gl_Position = mvp * vec4( world, 1.0 );
    v_color = a_inst_color;
    v_uv = mix( a_inst_uv0, a_inst_uv1, uv_local );
    v_flags = a_inst_flags;
    v_shade = shade;
}
