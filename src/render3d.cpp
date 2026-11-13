#include "render3d.h"

#if defined(TILES)

#include <algorithm>
#include <array>
#include <bitset>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <limits>
#include <memory>
#include <sstream>
#include <string>
#include <string_view>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include <SDL3/SDL.h>
#include <SDL3/SDL_gpu.h>
#include <SDL3_ttf/SDL_ttf.h>
#include <imgui/imgui.h>

#include "avatar.h"
#include "avatar_action.h"
#include "cached_options.h"
#include "calendar.h"
#include "cata_tiles.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "debug.h"
#include "field.h"
#include "field_type.h"
#include "font_loader.h"
#include "game.h"
#include "game_constants.h"
#include "item.h"
#include "level_cache.h"
#include "lightmap.h"
#include "line.h"
#include "map.h"
#include "map_memory.h"
#include "mapdata.h"
#include "monster.h"
#include "mtype.h"
#include "mutation.h"
#include "npc.h"
#include "path_info.h"
#include "point.h"
#include "render3d_picking.h"
#include "safe_reference.h"
#include "shadowcasting.h"
#include "smooth_lighting.h"
#include "submap.h"
#include "units_utility.h"
#include "vehicle.h"
#include "veh_type.h"
#include "walking.h"
#include "weather.h"
#include "weather_type.h"
#include "world_position.h"

static const vpart_location_id vpart_location_on_roof( "on_roof" );

namespace render3d
{

namespace
{

float position_fraction( int offset )
{
    return static_cast<float>( offset ) / world_position::units_per_tile;
}

point seated_vehicle_offset( const map &here, const Creature &actor )
{
    const Character *who = actor.as_character();
    if( !who || !who->in_vehicle ) {
        return point::zero;
    }
    const auto seat = here.veh_at( actor.pos_abs() ).part_with_feature( VPFLAG_BOARDABLE, false );
    return seat && seat->get_passenger() == who ? seat->vehicle().fractional_offset() : point::zero;
}

// cross-level rendering: all z-levels stacked LEVEL_HEIGHT apart
// (the near ±24 region renders every level; the far ring draws the view level only)
// a tile can yield up to 6 instances (floor + object + furniture + creature + item + item highlight)
constexpr int MAX_DRAW_INSTANCES = VIEW_SIZE * VIEW_SIZE * 6 +
                                   REGION_SIZE * REGION_SIZE * 6 * ( OVERMAP_DEPTH + OVERMAP_HEIGHT );
// float3 pos + float3 scale + float2 uv0 + float2 uv1 + float4 color + float flags + float pad
constexpr int INSTANCE_STRIDE = 64;

constexpr float TREE_HEIGHT = 3.0f;
constexpr float SHRUB_HEIGHT = 0.9f;
constexpr float FURN_QUAD_HEIGHT = 1.2f;
constexpr float PANEL_HEIGHT = 1.4f;
constexpr float PANEL_THICK = 0.1f;
constexpr float FENCE_HEIGHT = 1.5f;
constexpr float CREATURE_BASE_HEIGHT = 1.8f;
// Human paper dolls include many equipment layers; keep the whole doll slightly
// smaller than medium monsters without changing the monster size curve.
constexpr float CHARACTER_SIZE_SCALE = 0.85f;
constexpr float ITEM_HEIGHT = 0.5f;
// fields: liquid/solid traces (blood, bile, acid, web...) draw as thin decals
// just above the floor; gas/plasma effects (smoke, fire, gas...) draw as
// camera-facing billboards. Co-tile entries stagger so they never share a plane.
constexpr float FIELD_DECAL_Z = 0.001f;
constexpr float FIELD_DECAL_STAGGER = 0.0003f;
constexpr float FIELD_RISER_HEIGHT = 1.4f;
constexpr float FIELD_RISER_OFFSET = 0.008f;
// ground-level utility runs sit above the floor and the existing low decals
constexpr float FLAT_UTILITY_Z = 0.006f;
// vehicle parts draw as flat ground decals, above the field decals (2D draws
// vparts after fields/items); they use MODE_FLATQUAD_DECAL (no depth write) so
// co-tile and overlapping decals order by painter's algorithm, never z-fight.
// The one exception to flatness: sprites carrying elevation art (a northward
// spill) also stand upright as a side panel on the vehicle's LEFT flank
// (TP-12 reduced scope — everything else stays flat on the ground).
constexpr float VEH_DECAL_Z = 0.004f;
constexpr float VEH_PANEL_BASE_Z = 0.02f;   // side panel bottom edge
constexpr float VEH_PANEL_ZSCALE = 0.9f;    // panel height per tile of sprite height
constexpr float VEH_WSH_BASE_Z = 0.55f;     // windshield panel bottom edge (roofless fallback)
constexpr float VEH_WSH_H = 0.8f;           // windshield panel height (roofless fallback)
constexpr float VEH_ROOF_Z = 1.35f;         // roof cover: level with the side panel tops
constexpr float VEH_BODY_BASE = 0.35f;      // unroofed tile body height (chassis deck)
constexpr float VEH_BODY_PER_SPILL = 0.9f;  // body rise per tile of sprite spill
// near a vehicle (any of its part tiles on the player's z closer than this)
// the WHOLE vehicle's shell (panels, voxel boxes, roof equipment) hides,
// leaving only the flat 2D decals — working on the car and seeing into cargo
// stays unobstructed, and a long car never loses just its near half
constexpr float VEH_PROX_HIDE_DIST = 5.0f;
// the windshield sprite's footprint splits into the black glass band (top
// 12 of 32 rows, measured on the UC art) and the gray cowl / hood edge
// (bottom 20) — the band stands vertical, the cowl lies flat (TP-22)
constexpr float VEH_WSH_GLASS_FRAC = 12.0f / 32.0f;
// wing mirror flat decal height (TP-26): door beltline, where the stalk
// meets the panel
constexpr float VEH_MIRROR_Z = 0.80f;

// the whole rendered z range must be inside map memory's prepared region; the
// prepare call below anchors that region's z window at 0 (see draw_terrain_window)
static_assert( fov_3d_z_range >= OVERMAP_DEPTH &&fov_3d_z_range >= OVERMAP_HEIGHT,
               "map memory region must cover every rendered z-level" );

// geometry kind of an instance batch (matches `params.x` in terrain3d.vert)
enum draw_mode : int {
    MODE_BOX = 0,      // unit cube (floors, walls)
    MODE_XQUAD = 1,    // two static crossed quads (trees)
    MODE_BILLBOARD = 2, // yaw-only camera-facing quad (creatures, items)
    MODE_BILLBOARD_SNAP = 3, // billboard snapped to the nearest cardinal axis (furniture)
    MODE_LINEQUAD = 4,  // flat vertical quad on a fixed axis (fences); pad = run direction
    MODE_FLATQUAD = 5,   // flat horizontal quad (floor overlays, cutout floor tiles)
    // flat horizontal decal drawn with depth WRITE off (vehicle parts): coplanar
    // decals never z-fight — painter's order (gather order = 2D's row order)
    // decides overlaps, exactly like 2D's back-to-front blits. The depth TEST
    // stays on so walls etc. still occlude decals. Shader-side this is mode 5.
    MODE_FLATQUAD_DECAL = 6,
    // axis-aligned vertical quad (fence geometry) drawn with depth WRITE off
    // (vehicle side panels): corner sprites span two tiles, so neighbouring
    // panels share a plane and must resolve by painter's order. Shader-side
    // this is mode 4.
    MODE_LINEQUAD_DECAL = 7
};

struct mat4 {
    // column-major, matching GLSL's default layout
    float c[16];
};

mat4 mat4_mul( const mat4 &a, const mat4 &b )
{
    mat4 r{};
    for( int col = 0; col < 4; ++col ) {
        for( int row = 0; row < 4; ++row ) {
            float s = 0.0f;
            for( int k = 0; k < 4; ++k ) {
                s += a.c[k * 4 + row] * b.c[col * 4 + k];
            }
            r.c[col * 4 + row] = s;
        }
    }
    return r;
}

// D3D/Vulkan-style depth [0,1]; SDL GPU compositing already maps NDC +Y up
// to the texture's top-left origin, so do NOT negate the Y scale here.
mat4 mat4_perspective( const float fov_y, const float aspect, const float zn, const float zf )
{
    const float f = 1.0f / std::tan( fov_y * 0.5f );
    mat4 r{};
    r.c[0] = f / aspect;
    r.c[5] = f;
    r.c[10] = zf / ( zn - zf );
    r.c[11] = -1.0f;
    r.c[14] = zn * zf / ( zn - zf );
    return r;
}

using vec3 = scene_point;

struct pick_camera {
    SDL_FRect viewport{};
    vec3 eye{};
    vec3 right{};
    vec3 up{};
    vec3 forward{};
    float aspect = 1.0f;
    camera_input movement{};
    tripoint_abs_ms center;
    safe_reference<map> terrain;
};

vec3 vec3_sub( const vec3 &a, const vec3 &b )
{
    return { a.x - b.x, a.y - b.y, a.z - b.z };
}

vec3 vec3_cross( const vec3 &a, const vec3 &b )
{
    return { a.y *b.z - a.z * b.y, a.z *b.x - a.x * b.z, a.x *b.y - a.y * b.x };
}

vec3 vec3_normalize( const vec3 &v )
{
    const float len = std::sqrt( v.x * v.x + v.y * v.y + v.z * v.z );
    return len > 0.0f ? vec3{ v.x / len, v.y / len, v.z / len } :
           vec3{ 0, 0, 1 };
}

float vec3_dot( const vec3 &a, const vec3 &b )
{
    return a.x * b.x + a.y * b.y + a.z * b.z;
}

mat4 mat4_lookat( const vec3 &eye, const vec3 &target, const vec3 &up )
{
    const vec3 f = vec3_normalize( vec3_sub( target, eye ) );
    // The map frame (x east, y south, z up) is left-handed relative to
    // physical space, so the physical screen-right is up x forward, not the
    // right-handed f x up, which would render the world mirrored. The camera
    // up vector is f x r in either convention.
    const vec3 r = vec3_normalize( vec3_cross( up, f ) );
    const vec3 u = vec3_normalize( vec3_cross( f, r ) );
    mat4 m{};
    m.c[0] = r.x;
    m.c[1] = u.x;
    m.c[2] = -f.x;
    m.c[4] = r.y;
    m.c[5] = u.y;
    m.c[6] = -f.y;
    m.c[8] = r.z;
    m.c[9] = u.z;
    m.c[10] = -f.z;
    m.c[12] = -vec3_dot( r, eye );
    m.c[13] = -vec3_dot( u, eye );
    m.c[14] = vec3_dot( f, eye );
    m.c[15] = 1.0f;
    return m;
}

struct view_frustum {
    // a*x + b*y + c*z + d >= 0 is inside. SDL GPU depth is in [0,1].
    std::array<std::array<float, 4>, 6> planes{};
};

view_frustum make_view_frustum( const mat4 &m )
{
    view_frustum out;
    const auto row = [&m]( const int r ) {
        return std::array<float, 4> { m.c[r], m.c[4 + r], m.c[8 + r], m.c[12 + r] };
    };
    const auto add = []( const std::array<float, 4> &a, const std::array<float, 4> &b,
    const float sign ) {
        return std::array<float, 4> { a[0] + sign *b[0], a[1] + sign *b[1],
                                      a[2] + sign *b[2], a[3] + sign *b[3]
                                    };
    };
    const std::array<float, 4> x = row( 0 );
    const std::array<float, 4> y = row( 1 );
    const std::array<float, 4> z = row( 2 );
    const std::array<float, 4> w = row( 3 );
    out.planes = {{
            add( w, x, 1.0f ), add( w, x, -1.0f ),
            add( w, y, 1.0f ), add( w, y, -1.0f ),
            z, add( w, z, -1.0f )
        }
    };
    for( std::array<float, 4> &p : out.planes ) {
        const float len = std::sqrt( p[0] * p[0] + p[1] * p[1] + p[2] * p[2] );
        if( len > 1e-8f ) {
            for( float &v : p ) {
                v /= len;
            }
        }
    }
    return out;
}

bool aabb_in_frustum( const view_frustum &f, const vec3 &min, const vec3 &max )
{
    for( const std::array<float, 4> &p : f.planes ) {
        // The positive vertex gives an AABB its best chance to be inside this
        // plane. If even that vertex is outside, the whole box is outside.
        const vec3 v{ p[0] >= 0.0f ? max.x : min.x,
                      p[1] >= 0.0f ? max.y : min.y,
                      p[2] >= 0.0f ? max.z : min.z };
        if( p[0] * v.x + p[1] * v.y + p[2] * v.z + p[3] < 0.0f ) {
            return false;
        }
    }
    return true;
}

// Generous bounds for every object a tile can emit: the largest current
// creature billboard is 9m wide, and vehicle/sheet art can spill across tiles.
// Conservative culling is preferable here to clipping an edge-case sprite.
constexpr float CULL_XY_MARGIN = 5.0f;
constexpr float CULL_Z_BELOW = 4.0f;
constexpr float CULL_Z_ABOVE = 5.0f;

bool bounds_in_frustum( const view_frustum &f, const float x0, const float y0,
                        const float x1, const float y1, const float wz )
{
    return aabb_in_frustum( f, { x0 - CULL_XY_MARGIN, y0 - CULL_XY_MARGIN, wz - CULL_Z_BELOW },
    { x1 + CULL_XY_MARGIN, y1 + CULL_XY_MARGIN, wz + CULL_Z_ABOVE } );
}

bool tile_in_frustum( const view_frustum &f, const point d, const float wz )
{
    return bounds_in_frustum( f, static_cast<float>( d.x ), static_cast<float>( d.y ),
                              static_cast<float>( d.x + 1 ), static_cast<float>( d.y + 1 ), wz );
}

// Unit cube, corner at origin, spanning [0,1]^3; 36 verts, pos(3f) + normal(3f).
const std::array<float, 36 * 6> &cube_vertices()
{
    static const std::array<float, 36 * 6> verts = [] {
        std::array<float, 36 * 6> v{};
        struct face_definition {
            vec3 origin;
            vec3 edge_1_end;
            vec3 edge_2_end;
            vec3 normal;
        };
        // face: origin corner, two edge endpoints, normal
        const std::array<face_definition, 6> faces = {{
                { {0, 0, 0}, {1, 0, 0}, {0, 1, 0}, {0, 0, -1} }, // bottom (z-)
                { {0, 0, 1}, {1, 0, 1}, {0, 1, 1}, {0, 0, 1} },  // top (z+)
                { {0, 0, 0}, {1, 0, 0}, {0, 0, 1}, {0, -1, 0} }, // south (y-)
                { {0, 1, 0}, {1, 1, 0}, {0, 1, 1}, {0, 1, 0} },  // north (y+)
                { {0, 0, 0}, {0, 1, 0}, {0, 0, 1}, { -1, 0, 0} }, // west (x-)
                { {1, 0, 0}, {1, 1, 0}, {1, 0, 1}, {1, 0, 0} },  // east (x+)
            }
        };
        int i = 0;
        for( const face_definition &f : faces )
        {
            const vec3 o = f.origin;
            const vec3 e1{ f.edge_1_end.x - o.x, f.edge_1_end.y - o.y, f.edge_1_end.z - o.z };
            const vec3 e2{ f.edge_2_end.x - o.x, f.edge_2_end.y - o.y, f.edge_2_end.z - o.z };
            const vec3 n = f.normal;
            // two triangles: (o, o+e1, o+e1+e2) and (o, o+e1+e2, o+e2)
            const vec3 quad[6] = {
                o,
                { o.x + e1.x, o.y + e1.y, o.z + e1.z },
                { o.x + e1.x + e2.x, o.y + e1.y + e2.y, o.z + e1.z + e2.z },
                o,
                { o.x + e1.x + e2.x, o.y + e1.y + e2.y, o.z + e1.z + e2.z },
                { o.x + e2.x, o.y + e2.y, o.z + e2.z },
            };
            for( const vec3 &p : quad ) {
                v[i++] = p.x;
                v[i++] = p.y;
                v[i++] = p.z;
                v[i++] = n.x;
                v[i++] = n.y;
                v[i++] = n.z;
            }
        }
        return v;
    }();
    return verts;
}

// Two quads crossing the tile diagonally (X shape), for cutout sprites (trees,
// furniture). 12 verts, pos(3f) + uv(2f in a_aux.xy, third unused).
const std::array<float, 12 * 6> &xquad_vertices()
{
    static const std::array<float, 12 * 6> verts = {
        // quad A: diagonal (0,0)-(1,1); z=1 top has v=0 (sprite top)
        0, 0, 1,  0, 0, 0,
        1, 1, 1,  1, 0, 0,
        1, 1, 0,  1, 1, 0,
        0, 0, 1,  0, 0, 0,
        1, 1, 0,  1, 1, 0,
        0, 0, 0,  0, 1, 0,
        // quad B: diagonal (0,1)-(1,0)
        0, 1, 1,  0, 0, 0,
        1, 0, 1,  1, 0, 0,
        1, 0, 0,  1, 1, 0,
        0, 1, 1,  0, 0, 0,
        1, 0, 0,  1, 1, 0,
        0, 1, 0,  0, 1, 0,
    };
    return verts;
}

// Bottom-centered unit quad for yaw billboards (creatures, items):
// x in [-0.5, 0.5], y (up along cam_up) in [0, 1]. 6 verts, pos(3f) + uv(2f).
const std::array<float, 6 * 6> &quad_vertices()
{
    static const std::array<float, 6 * 6> verts = {
        -0.5f, 1, 0,  0, 0, 0,
            0.5f, 1, 0,  1, 0, 0,
            0.5f, 0, 0,  1, 1, 0,
            -0.5f, 1, 0,  0, 0, 0,
            0.5f, 0, 0,  1, 1, 0,
            -0.5f, 0, 0,  0, 1, 0,
        };
    return verts;
}

// Flat horizontal quad covering one tile (floor overlays and cutout floor
// tiles): x/y in [0,1] at z=0, uv = xy so sprite v+ runs south like 2D.
// No thickness and no side faces — a box overlay's sides sample the sprite's
// transparent rows and leave dark seams along every tile edge.
const std::array<float, 6 * 6> &flatquad_vertices()
{
    static const std::array<float, 6 * 6> verts = {
        0, 0, 0,  0, 0, 0,
        1, 0, 0,  1, 0, 0,
        1, 1, 0,  1, 1, 0,
        0, 0, 0,  0, 0, 0,
        1, 1, 0,  1, 1, 0,
        0, 1, 0,  0, 1, 0,
    };
    return verts;
}

struct shader_format_artifact {
    SDL_GPUShaderFormat sdl_flag;
    const char *suffix;
};

constexpr std::array<shader_format_artifact, 3> SUPPORTED_FORMATS = {{
        { SDL_GPU_SHADERFORMAT_SPIRV, ".spv" },
        { SDL_GPU_SHADERFORMAT_DXIL, ".dxil" },
        { SDL_GPU_SHADERFORMAT_MSL, ".msl" },
    }
};

std::vector<unsigned char> read_file_bytes( const std::string &path )
{
    std::ifstream in( path, std::ios::binary );
    if( !in.is_open() ) {
        return {};
    }
    return { std::istreambuf_iterator<char>( in ), std::istreambuf_iterator<char>() };
}

SDL_GPUShader *load_shader( SDL_GPUDevice *device, const std::string &basename,
                            const SDL_GPUShaderStage stage, const unsigned int num_uniform_buffers,
                            const unsigned int num_samplers = 0 )
{
    const SDL_GPUShaderFormat available = SDL_GetGPUShaderFormats( device );
    if( available == SDL_GPU_SHADERFORMAT_INVALID ) {
        DebugLog( D_INFO, DC_ALL ) << "render3d: GPU device reports no shader formats";
        return nullptr;
    }
    for( const shader_format_artifact &candidate : SUPPORTED_FORMATS ) {
        if( ( available & candidate.sdl_flag ) == 0 ) {
            continue;
        }
        const std::string path = ( PATH_INFO::datadir() + "shaders/" + basename ) + candidate.suffix;
        const std::vector<unsigned char> bytes = read_file_bytes( path );
        if( bytes.empty() ) {
            continue;
        }
        SDL_GPUShaderCreateInfo info{};
        info.code_size = bytes.size();
        info.code = bytes.data();
        info.entrypoint = nullptr;
        info.format = candidate.sdl_flag;
        info.stage = stage;
        info.num_samplers = num_samplers;
        info.num_storage_textures = 0;
        info.num_storage_buffers = 0;
        info.num_uniform_buffers = num_uniform_buffers;
        SDL_GPUShader *raw = SDL_CreateGPUShader( device, &info );
        if( !raw ) {
            DebugLog( D_ERROR, DC_ALL ) << "render3d: SDL_CreateGPUShader failed for " << path <<
                                        ": " << SDL_GetError();
        }
        return raw;
    }
    DebugLog( D_INFO, DC_ALL ) << "render3d: no shipped artifact for " << basename <<
                               " matches device formats";
    return nullptr;
}

constexpr size_t FRAME_SLOT_COUNT = 2;

enum class frame_slot_state {
    empty,
    recording,
    in_flight,
    ready
};

struct frame_slot {
    SDL_GPUTexture *color_tex = nullptr;
    SDL_GPUTexture *depth_tex = nullptr;
    SDL_Texture *color_tex_sdl = nullptr;
    SDL_GPUBuffer *instance_vb = nullptr;
    SDL_GPUTransferBuffer *instance_tb = nullptr;
    size_t instance_tb_size = 0;
    std::unordered_map<SDL_Texture *, std::shared_ptr<SDL_Texture>> texture_owners;
    SDL_GPUFence *fence = nullptr;
    frame_slot_state state = frame_slot_state::empty;
    uint64_t serial = 0;
    pick_camera camera;
    pick_surfaces surfaces;
};

struct context {
    SDL_GPUDevice *device = nullptr; // owned by the SDL_Renderer
    SDL_GPUGraphicsPipeline *pipeline = nullptr;
    // same pipeline with depth write OFF for MODE_FLATQUAD_DECAL (vehicle
    // decals): coplanar decals resolve by painter's order instead of z-fighting
    SDL_GPUGraphicsPipeline *pipeline_decal = nullptr;
    SDL_GPUGraphicsPipeline *sky_pipeline = nullptr; // far-depth background pass after the world
    SDL_GPUBuffer *cube_vb = nullptr;
    SDL_GPUBuffer *xquad_vb = nullptr;
    SDL_GPUBuffer *quad_vb = nullptr;
    SDL_GPUBuffer *flatquad_vb = nullptr;
    SDL_GPUSampler *sampler = nullptr;
    SDL_GPUTexture *fallback_tex = nullptr; // 1x1 white, bound when a batch has no atlas
    std::array<frame_slot, FRAME_SLOT_COUNT> slots;
    int latest_ready = -1;
    uint64_t latest_ready_serial = 0;
    uint64_t next_serial = 1;
    // ASCII glyph atlas for sprite-less items (the curses-style fallback):
    // printable chars 32..126 in a 16-column grid, white on transparent
    SDL_Texture *glyph_tex = nullptr;
    int glyph_cell_w = 0;
    int glyph_cell_h = 0;
    int glyph_atlas_w = 0;
    int glyph_atlas_h = 0;
    int tex_w = 0;
    int tex_h = 0;

    void teardown();
};

context g_ctx;
frame_slot *g_recording_slot = nullptr;
bool g_available = false;
SDL_Renderer *g_probed_renderer = nullptr;

// top-down orbit camera state (persisted across frames and turns)
float g_yaw = 0.78539816f;   // radians, 0 = +x (east)
float g_pitch = -0.96f;      // radians, negative = looking down
float g_cam_dist = 14.0f;    // orbit distance in meters
bool g_mouse_captured = false;

constexpr float camera_fov = 40.0f * 3.14159265f / 180.0f;
pick_camera presented_camera;
pick_surfaces presented_surfaces;
uint64_t presented_serial = 0;
point g_last_mouse = point::north_west;
// game-driven cursors forwarded from cata_tiles (targeting, construction...);
// cleared after each frame's gather
std::vector<std::pair<tripoint_bub_ms, bool>> g_game_cursors;

// The eight single-step compass directions, clockwise from north (map space:
// +x east, +y south). Movement keys name directions in the screen frame, with
// FORTH = up = index 0, FORTH_RIGHT = 1, ..., FORTH_LEFT = 7.
constexpr point_rel_ms compass8[8] = {
    { 0, -1 }, { 1, -1 }, { 1, 0 }, { 1, 1 }, { 0, 1 }, { -1, 1 }, { -1, 0 }, { -1, -1 }
};

int compass_index( const point_rel_ms &d )
{
    for( int i = 0; i < 8; ++i ) {
        if( d == compass8[i] ) {
            return i;
        }
    }
    return -1;
}

// Compass octant of the camera's ground-plane forward direction, i.e. the map
// direction the top of the screen points at. f = (cos yaw, sin yaw) is the
// horizontal part of the view direction (eye -> target); bearing is measured
// clockwise from north, as the compass table is.
camera_input camera_from_yaw()
{
    constexpr int scale = camera_input::forward_limit;
    static_assert( scale == fractional_walk::max_distance );
    const float x = std::cos( g_yaw );
    const float y = std::sin( g_yaw );
    const float bearing = std::atan2( x, -y );
    const int octant = ( static_cast<int>( std::lround( bearing / ( 3.14159265f / 4.0f ) ) ) + 8 ) % 8;
    return camera_input{ octant, point( static_cast<int>( scale * x ), static_cast<int>( scale * y ) ) };
}

// P0 scaffolding: Release builds filter out D_INFO, so probe results go to a
// status file in the config dir for headless diagnosis.
void write_status( const std::string &msg )
{
    // append: keep the whole probe/draw trail for headless diagnosis
    const cata_path path = PATH_INFO::config_dir_path() / "render3d_status.txt";
    std::ofstream out( std::filesystem::path( path ), std::ios::app );
    out << msg << "\n";
}

bool profiling_enabled()
{
    static const bool enabled = std::getenv( "CATA_RENDER3D_PROFILE" ) != nullptr;
    return enabled;
}

Uint64 profile_ticks( const bool enabled )
{
    return enabled ? SDL_GetPerformanceCounter() : 0;
}

double profile_ms( const Uint64 begin, const Uint64 end )
{
    return static_cast<double>( end - begin ) * 1000.0 /
           static_cast<double>( SDL_GetPerformanceFrequency() );
}

struct frame_profile {
    uint64_t main_tiles = 0;
    uint64_t coarse_tiles = 0;
    uint64_t frustum_tiles = 0;
    uint64_t skipped_submaps = 0;
    uint64_t skipped_levels = 0;
    uint64_t creature_positions = 0;
    uint64_t skipped_submissions = 0;
    uint64_t sprite_cache_hits = 0;
    uint64_t orientation_cache_hits = 0;
    uint64_t instances = 0;
    uint64_t segments = 0;
    uint64_t upload_bytes = 0;
    double memory_ms = 0.0;
    double gather_ms = 0.0;
    double assembly_ms = 0.0;
    double upload_ms = 0.0;
    double record_ms = 0.0;
    double wait_ms = 0.0;
    double composite_ms = 0.0;
    double total_ms = 0.0;

    void add( const frame_profile &other ) {
        main_tiles += other.main_tiles;
        coarse_tiles += other.coarse_tiles;
        frustum_tiles += other.frustum_tiles;
        skipped_submaps += other.skipped_submaps;
        skipped_levels += other.skipped_levels;
        creature_positions += other.creature_positions;
        skipped_submissions += other.skipped_submissions;
        sprite_cache_hits += other.sprite_cache_hits;
        orientation_cache_hits += other.orientation_cache_hits;
        instances += other.instances;
        segments += other.segments;
        upload_bytes += other.upload_bytes;
        memory_ms += other.memory_ms;
        gather_ms += other.gather_ms;
        assembly_ms += other.assembly_ms;
        upload_ms += other.upload_ms;
        record_ms += other.record_ms;
        wait_ms += other.wait_ms;
        composite_ms += other.composite_ms;
        total_ms += other.total_ms;
    }
};

frame_profile g_profile;

void publish_profile( const frame_profile &frame )
{
    if( !profiling_enabled() ) {
        return;
    }
    static frame_profile total;
    static int frames = 0;
    total.add( frame );
    ++frames;
    if( frames < 120 ) {
        return;
    }
    const int sample_count = frames;
    const auto avg = [sample_count]( const auto value ) {
        return static_cast<double>( value ) / sample_count;
    };
    std::ostringstream out;
    out.precision( 3 );
    out << std::fixed
        << "profile 120f: total=" << avg( total.total_ms )
        << "ms memory=" << avg( total.memory_ms )
        << " gather=" << avg( total.gather_ms )
        << " assembly=" << avg( total.assembly_ms )
        << " upload=" << avg( total.upload_ms )
        << " record=" << avg( total.record_ms )
        << " wait=" << avg( total.wait_ms )
        << " composite=" << avg( total.composite_ms )
        << " | tiles=" << avg( total.main_tiles )
        << " coarse_skip=" << avg( total.coarse_tiles )
        << " frustum_skip=" << avg( total.frustum_tiles )
        << " skipped_sm=" << avg( total.skipped_submaps )
        << " skipped_z=" << avg( total.skipped_levels )
        << " creatures=" << avg( total.creature_positions )
        << " skipped_submit=" << avg( total.skipped_submissions )
        << " sprite_hits=" << avg( total.sprite_cache_hits )
        << " orientation_hits=" << avg( total.orientation_cache_hits )
        << " instances=" << avg( total.instances )
        << " segments=" << avg( total.segments )
        << " upload_KiB=" << avg( total.upload_bytes ) / 1024.0;
    write_status( out.str() );
    total = frame_profile{};
    frames = 0;
}

void reset_frame_tracking()
{
    for( frame_slot &slot : g_ctx.slots ) {
        slot.state = frame_slot_state::empty;
        slot.serial = 0;
    }
    g_ctx.latest_ready = -1;
    g_ctx.latest_ready_serial = 0;
    g_ctx.next_serial = 1;
    presented_serial = 0;
    presented_camera = {};
}

void poll_frame_slots()
{
    for( int i = 0; i < static_cast<int>( g_ctx.slots.size() ); ++i ) {
        frame_slot &slot = g_ctx.slots[i];
        if( slot.state != frame_slot_state::in_flight || !slot.fence ) {
            continue;
        }
        if( !SDL_QueryGPUFence( g_ctx.device, slot.fence ) ) {
            continue;
        }
        SDL_ReleaseGPUFence( g_ctx.device, slot.fence );
        slot.fence = nullptr;
        slot.texture_owners.clear();
        slot.state = frame_slot_state::ready;
        if( slot.serial >= g_ctx.latest_ready_serial ) {
            g_ctx.latest_ready = i;
            g_ctx.latest_ready_serial = slot.serial;
        }
    }
}

int begin_frame_slot()
{
    // Prefer a never-used/already-discarded slot, then an older completed one.
    // The newest completed slot stays intact for this frame's composite.
    for( int pass = 0; pass < 2; ++pass ) {
        for( int i = 0; i < static_cast<int>( g_ctx.slots.size() ); ++i ) {
            if( i == g_ctx.latest_ready ) {
                continue;
            }
            frame_slot &slot = g_ctx.slots[i];
            const bool available = pass == 0 ? slot.state == frame_slot_state::empty
                                   : slot.state == frame_slot_state::ready;
            if( available ) {
                slot.state = frame_slot_state::recording;
                slot.serial = g_ctx.next_serial++;
                return i;
            }
        }
    }
    return -1;
}

bool wait_for_frame_slot( const int index )
{
    if( index < 0 ) {
        return false;
    }
    frame_slot &slot = g_ctx.slots[index];
    if( slot.state != frame_slot_state::in_flight || !slot.fence ) {
        return slot.state == frame_slot_state::ready;
    }
    if( !SDL_WaitForGPUFences( g_ctx.device, true, &slot.fence, 1 ) ) {
        return false;
    }
    poll_frame_slots();
    return slot.state == frame_slot_state::ready;
}

void drain_frame_slots()
{
    if( g_ctx.device && !SDL_WaitForGPUIdle( g_ctx.device ) ) {
        write_status( "GPU idle wait failed during frame-slot drain: " +
                      std::string( SDL_GetError() ) );
    }
    for( frame_slot &slot : g_ctx.slots ) {
        slot.texture_owners.clear();
        if( slot.fence ) {
            SDL_ReleaseGPUFence( g_ctx.device, slot.fence );
            slot.fence = nullptr;
        }
    }
    g_recording_slot = nullptr;
    reset_frame_tracking();
}

bool composite_latest_frame( SDL_Renderer *renderer, const SDL_FRect &dest )
{
    if( g_ctx.latest_ready < 0 ) {
        return false;
    }
    frame_slot &slot = g_ctx.slots[g_ctx.latest_ready];
    if( slot.state != frame_slot_state::ready || !slot.color_tex_sdl ) {
        return false;
    }
    if( !slot.camera.terrain || slot.camera.terrain.get() != &get_map() ||
        !SDL_RenderTexture( renderer, slot.color_tex_sdl, nullptr, &dest ) ) {
        return false;
    }
    if( presented_serial != slot.serial ) {
        // The slot can be reused while its image is still on screen. Keep
        // the published surface buffer independently and recycle the old one.
        std::swap( presented_surfaces, slot.surfaces );
        presented_serial = slot.serial;
    }
    presented_camera = slot.camera;
    presented_camera.viewport = dest;
    return true;
}

void context::teardown()
{
    if( device ) {
        drain_frame_slots();
        for( frame_slot &slot : slots ) {
            if( slot.color_tex_sdl ) {
                // The wrapper does not own the wrapped GPU texture.
                SDL_DestroyTexture( slot.color_tex_sdl );
                slot.color_tex_sdl = nullptr;
            }
            if( slot.color_tex ) {
                SDL_ReleaseGPUTexture( device, slot.color_tex );
                slot.color_tex = nullptr;
            }
            if( slot.depth_tex ) {
                SDL_ReleaseGPUTexture( device, slot.depth_tex );
                slot.depth_tex = nullptr;
            }
            if( slot.instance_tb ) {
                SDL_ReleaseGPUTransferBuffer( device, slot.instance_tb );
                slot.instance_tb = nullptr;
                slot.instance_tb_size = 0;
            }
            if( slot.instance_vb ) {
                SDL_ReleaseGPUBuffer( device, slot.instance_vb );
                slot.instance_vb = nullptr;
            }
        }
        if( glyph_tex ) {
            SDL_DestroyTexture( glyph_tex );
            glyph_tex = nullptr;
        }
        if( fallback_tex ) {
            SDL_ReleaseGPUTexture( device, fallback_tex );
            fallback_tex = nullptr;
        }
        if( sampler ) {
            SDL_ReleaseGPUSampler( device, sampler );
            sampler = nullptr;
        }
        if( cube_vb ) {
            SDL_ReleaseGPUBuffer( device, cube_vb );
            cube_vb = nullptr;
        }
        if( xquad_vb ) {
            SDL_ReleaseGPUBuffer( device, xquad_vb );
            xquad_vb = nullptr;
        }
        if( quad_vb ) {
            SDL_ReleaseGPUBuffer( device, quad_vb );
            quad_vb = nullptr;
        }
        if( flatquad_vb ) {
            SDL_ReleaseGPUBuffer( device, flatquad_vb );
            flatquad_vb = nullptr;
        }
        if( pipeline ) {
            SDL_ReleaseGPUGraphicsPipeline( device, pipeline );
            pipeline = nullptr;
        }
        if( pipeline_decal ) {
            SDL_ReleaseGPUGraphicsPipeline( device, pipeline_decal );
            pipeline_decal = nullptr;
        }
        if( sky_pipeline ) {
            SDL_ReleaseGPUGraphicsPipeline( device, sky_pipeline );
            sky_pipeline = nullptr;
        }
    } else {
        reset_frame_tracking();
    }
    tex_w = 0;
    tex_h = 0;
    device = nullptr;
}

bool ensure_targets( SDL_Renderer *renderer, const int w, const int h )
{
    bool ready = g_ctx.tex_w == w && g_ctx.tex_h == h;
    if( ready ) {
        for( const frame_slot &slot : g_ctx.slots ) {
            ready = ready && slot.color_tex && slot.depth_tex && slot.color_tex_sdl;
        }
    }
    if( ready ) {
        return true;
    }

    // Resizing is rare and must not destroy a texture the renderer still reads.
    SDL_FlushRenderer( renderer );
    drain_frame_slots();
    for( frame_slot &slot : g_ctx.slots ) {
        if( slot.color_tex_sdl ) {
            SDL_DestroyTexture( slot.color_tex_sdl );
            slot.color_tex_sdl = nullptr;
        }
        if( slot.color_tex ) {
            SDL_ReleaseGPUTexture( g_ctx.device, slot.color_tex );
            slot.color_tex = nullptr;
        }
        if( slot.depth_tex ) {
            SDL_ReleaseGPUTexture( g_ctx.device, slot.depth_tex );
            slot.depth_tex = nullptr;
        }
    }

    for( frame_slot &slot : g_ctx.slots ) {
        SDL_GPUTextureCreateInfo ci{};
        ci.type = SDL_GPU_TEXTURETYPE_2D;
        ci.format = SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UNORM;
        ci.usage = SDL_GPU_TEXTUREUSAGE_COLOR_TARGET | SDL_GPU_TEXTUREUSAGE_SAMPLER;
        ci.width = static_cast<Uint32>( w );
        ci.height = static_cast<Uint32>( h );
        ci.layer_count_or_depth = 1;
        ci.num_levels = 1;
        ci.sample_count = SDL_GPU_SAMPLECOUNT_1;
        slot.color_tex = SDL_CreateGPUTexture( g_ctx.device, &ci );
        if( !slot.color_tex ) {
            write_status( "ensure_targets failed: color target: " + std::string( SDL_GetError() ) );
            DebugLog( D_ERROR, DC_ALL ) << "render3d: color target creation failed: " << SDL_GetError();
            return false;
        }

        ci.format = SDL_GPU_TEXTUREFORMAT_D32_FLOAT;
        ci.usage = SDL_GPU_TEXTUREUSAGE_DEPTH_STENCIL_TARGET;
        slot.depth_tex = SDL_CreateGPUTexture( g_ctx.device, &ci );
        if( !slot.depth_tex ) {
            write_status( "ensure_targets failed: depth target: " + std::string( SDL_GetError() ) );
            DebugLog( D_ERROR, DC_ALL ) << "render3d: depth target creation failed: " << SDL_GetError();
            return false;
        }

        SDL_PropertiesID props = SDL_CreateProperties();
        SDL_SetPointerProperty( props, SDL_PROP_TEXTURE_CREATE_GPU_TEXTURE_POINTER, slot.color_tex );
        SDL_SetNumberProperty( props, SDL_PROP_TEXTURE_CREATE_FORMAT_NUMBER, SDL_PIXELFORMAT_ABGR8888 );
        SDL_SetNumberProperty( props, SDL_PROP_TEXTURE_CREATE_WIDTH_NUMBER, w );
        SDL_SetNumberProperty( props, SDL_PROP_TEXTURE_CREATE_HEIGHT_NUMBER, h );
        SDL_SetNumberProperty( props, SDL_PROP_TEXTURE_CREATE_ACCESS_NUMBER,
                               SDL_TEXTUREACCESS_STATIC );
        slot.color_tex_sdl = SDL_CreateTextureWithProperties( renderer, props );
        SDL_DestroyProperties( props );
        if( !slot.color_tex_sdl ) {
            write_status( "ensure_targets failed: texture wrap: " + std::string( SDL_GetError() ) );
            DebugLog( D_ERROR, DC_ALL ) << "render3d: wrapping GPU texture failed: " << SDL_GetError();
            return false;
        }
        SDL_SetTextureScaleMode( slot.color_tex_sdl, SDL_SCALEMODE_LINEAR );
    }

    g_ctx.tex_w = w;
    g_ctx.tex_h = h;
    return true;
}

// build the ASCII glyph atlas used for sprite-less items: printable 32..126 in
// a 16-column grid, white glyphs on transparent so the instance color tints them
bool build_glyph_atlas( SDL_Renderer *renderer )
{
    font_loader fl;
    try {
        fl.load();
    } catch( const std::exception &e ) {
        write_status( "glyph atlas: font config load failed: " + std::string( e.what() ) );
        return false;
    }
    if( fl.typeface.empty() ) {
        write_status( "glyph atlas: no typeface configured" );
        return false;
    }
    const float ptsize = static_cast<float>( std::max( 16, fl.fontsize * 3 ) );
    TTF_Font *font = TTF_OpenFont( fl.typeface.front().path.c_str(), ptsize );
    if( !font ) {
        write_status( "glyph atlas: TTF_OpenFont failed: " + std::string( SDL_GetError() ) );
        return false;
    }
    const int cell_h = TTF_GetFontHeight( font );
    const int cell_w = std::max( 1, cell_h * fl.fontwidth / std::max( 1, fl.fontheight ) );
    constexpr int cols = 16;
    constexpr int rows = 6;
    const int atlas_w = cols * cell_w;
    const int atlas_h = rows * cell_h;
    SDL_Surface *atlas = SDL_CreateSurface( atlas_w, atlas_h, SDL_PIXELFORMAT_RGBA32 );
    if( !atlas ) {
        write_status( "glyph atlas: surface creation failed" );
        TTF_CloseFont( font );
        return false;
    }
    SDL_FillSurfaceRect( atlas, nullptr, 0 );
    const SDL_Color white{ 255, 255, 255, 255 };
    const int ascent = TTF_GetFontAscent( font );
    for( int c = 32; c <= 126; ++c ) {
        int minx = 0;
        int maxx = 0;
        int miny = 0;
        int maxy = 0;
        int advance = 0;
        TTF_GetGlyphMetrics( font, c, &minx, &maxx, &miny, &maxy, &advance );
        SDL_Surface *g = TTF_RenderGlyph_Blended( font, c, white );
        if( !g ) {
            continue;
        }
        SDL_Rect dst{ ( c - 32 ) % cols *cell_w + ( cell_w - advance ) / 2 + minx,
                      ( c - 32 ) / cols *cell_h + ascent - maxy, g->w, g->h };
        SDL_BlitSurface( g, nullptr, atlas, &dst );
        SDL_DestroySurface( g );
    }
    TTF_CloseFont( font );
    g_ctx.glyph_tex = SDL_CreateTextureFromSurface( renderer, atlas );
    SDL_DestroySurface( atlas );
    if( !g_ctx.glyph_tex ) {
        write_status( "glyph atlas: texture creation failed: " + std::string( SDL_GetError() ) );
        return false;
    }
    g_ctx.glyph_cell_w = cell_w;
    g_ctx.glyph_cell_h = cell_h;
    g_ctx.glyph_atlas_w = atlas_w;
    g_ctx.glyph_atlas_h = atlas_h;
    write_status( "glyph atlas: built " + std::to_string( atlas_w ) + "x" +
                  std::to_string( atlas_h ) );
    return true;
}

bool probe( SDL_Renderer *renderer )
{
    g_ctx.teardown();
    g_available = false;
    if( std::getenv( "CATA_DISABLE_RENDER3D" ) ) {
        DebugLog( D_INFO, DC_ALL ) << "render3d: CATA_DISABLE_RENDER3D set; disabled";
        write_status( "disabled by CATA_DISABLE_RENDER3D" );
        return false;
    }
    SDL_GPUDevice *device = SDL_GetGPURendererDevice( renderer );
    if( !device ) {
        DebugLog( D_INFO, DC_ALL ) << "render3d: renderer is not GPU-backed; disabled";
        write_status( "unavailable: renderer is not GPU-backed" );
        return false;
    }
    g_ctx.device = device;

    SDL_GPUShader *vs = load_shader( device, "terrain3d.vert", SDL_GPU_SHADERSTAGE_VERTEX, 1 );
    SDL_GPUShader *fs = load_shader( device, "terrain3d.frag", SDL_GPU_SHADERSTAGE_FRAGMENT, 1, 1 );
    if( !vs || !fs ) {
        if( vs ) {
            SDL_ReleaseGPUShader( device, vs );
        }
        if( fs ) {
            SDL_ReleaseGPUShader( device, fs );
        }
        write_status( "unavailable: shader load failed" );
        g_ctx.teardown();
        return false;
    }

    SDL_GPUVertexBufferDescription vb_descs[2] {};
    vb_descs[0].slot = 0;
    vb_descs[0].pitch = 6 * sizeof( float );
    vb_descs[0].input_rate = SDL_GPU_VERTEXINPUTRATE_VERTEX;
    vb_descs[1].slot = 1;
    vb_descs[1].pitch = INSTANCE_STRIDE;
    vb_descs[1].input_rate = SDL_GPU_VERTEXINPUTRATE_INSTANCE;

    SDL_GPUVertexAttribute attrs[9] {};
    attrs[0].location = 0;
    attrs[0].buffer_slot = 0;
    attrs[0].format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT3;
    attrs[0].offset = 0;
    attrs[1].location = 1;
    attrs[1].buffer_slot = 0;
    attrs[1].format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT3;
    attrs[1].offset = 3 * sizeof( float );
    attrs[2].location = 2;
    attrs[2].buffer_slot = 1;
    attrs[2].format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT3;
    attrs[2].offset = 0;
    attrs[3].location = 3;
    attrs[3].buffer_slot = 1;
    attrs[3].format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT3;
    attrs[3].offset = 3 * sizeof( float );
    attrs[4].location = 4;
    attrs[4].buffer_slot = 1;
    attrs[4].format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT2;
    attrs[4].offset = 6 * sizeof( float );
    attrs[5].location = 5;
    attrs[5].buffer_slot = 1;
    attrs[5].format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT2;
    attrs[5].offset = 8 * sizeof( float );
    attrs[6].location = 6;
    attrs[6].buffer_slot = 1;
    attrs[6].format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT4;
    attrs[6].offset = 10 * sizeof( float );
    attrs[7].location = 7;
    attrs[7].buffer_slot = 1;
    attrs[7].format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT;
    attrs[7].offset = 14 * sizeof( float );
    attrs[8].location = 8;
    attrs[8].buffer_slot = 1;
    attrs[8].format = SDL_GPU_VERTEXELEMENTFORMAT_FLOAT;
    attrs[8].offset = 15 * sizeof( float );

    SDL_GPUGraphicsPipelineCreateInfo pi{};
    pi.vertex_shader = vs;
    pi.fragment_shader = fs;
    pi.vertex_input_state.vertex_buffer_descriptions = vb_descs;
    pi.vertex_input_state.num_vertex_buffers = 2;
    pi.vertex_input_state.vertex_attributes = attrs;
    pi.vertex_input_state.num_vertex_attributes = 9;
    pi.primitive_type = SDL_GPU_PRIMITIVETYPE_TRIANGLELIST;
    pi.rasterizer_state.fill_mode = SDL_GPU_FILLMODE_FILL;
    // P0: no culling so a winding/y-flip mismatch can never blank the scene
    pi.rasterizer_state.cull_mode = SDL_GPU_CULLMODE_NONE;
    pi.depth_stencil_state.enable_depth_test = true;
    pi.depth_stencil_state.enable_depth_write = true;
    pi.depth_stencil_state.compare_op = SDL_GPU_COMPAREOP_LESS;
    pi.target_info.num_color_targets = 1;
    SDL_GPUColorTargetDescription color_desc{};
    color_desc.format = SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UNORM;
    pi.target_info.color_target_descriptions = &color_desc;
    pi.target_info.depth_stencil_format = SDL_GPU_TEXTUREFORMAT_D32_FLOAT;
    pi.target_info.has_depth_stencil_target = true;

    g_ctx.pipeline = SDL_CreateGPUGraphicsPipeline( device, &pi );
    // the decal pipeline shares shaders/vertex layout and differs only in
    // depth write: decals never write depth, so coplanar decals (a vehicle's
    // oversized part sprites spilling onto the neighbour tile) resolve by
    // draw order — painter's algorithm, exactly what 2D does
    pi.depth_stencil_state.enable_depth_write = false;
    g_ctx.pipeline_decal = SDL_CreateGPUGraphicsPipeline( device, &pi );
    SDL_ReleaseGPUShader( device, vs );
    SDL_ReleaseGPUShader( device, fs );
    if( !g_ctx.pipeline || !g_ctx.pipeline_decal ) {
        DebugLog( D_ERROR, DC_ALL ) << "render3d: pipeline creation failed: " << SDL_GetError();
        write_status( "unavailable: pipeline creation failed: " + std::string( SDL_GetError() ) );
        g_ctx.teardown();
        return false;
    }

    // sky pass pipeline: a fullscreen triangle at far depth, drawn after the
    // world pass so only uncovered pixels evaluate the procedural sky.
    // optional — if the shaders are missing the world pass just clears to a
    // plain sky color like before
    SDL_GPUShader *sky_vs = load_shader( device, "sky.vert", SDL_GPU_SHADERSTAGE_VERTEX, 0 );
    SDL_GPUShader *sky_fs = load_shader( device, "sky.frag", SDL_GPU_SHADERSTAGE_FRAGMENT, 1 );
    if( sky_vs && sky_fs ) {
        SDL_GPUGraphicsPipelineCreateInfo spi{};
        spi.vertex_shader = sky_vs;
        spi.fragment_shader = sky_fs;
        spi.primitive_type = SDL_GPU_PRIMITIVETYPE_TRIANGLELIST;
        spi.rasterizer_state.fill_mode = SDL_GPU_FILLMODE_FILL;
        spi.rasterizer_state.cull_mode = SDL_GPU_CULLMODE_NONE;
        // sky.vert writes depth 1. After the world pass, LESS_OR_EQUAL leaves
        // only pixels whose depth is still the clear value (also 1).
        spi.depth_stencil_state.enable_depth_test = true;
        spi.depth_stencil_state.enable_depth_write = false;
        spi.depth_stencil_state.compare_op = SDL_GPU_COMPAREOP_LESS_OR_EQUAL;
        spi.target_info.num_color_targets = 1;
        SDL_GPUColorTargetDescription scolor_desc{};
        scolor_desc.format = SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UNORM;
        spi.target_info.color_target_descriptions = &scolor_desc;
        spi.target_info.depth_stencil_format = SDL_GPU_TEXTUREFORMAT_D32_FLOAT;
        spi.target_info.has_depth_stencil_target = true;
        g_ctx.sky_pipeline = SDL_CreateGPUGraphicsPipeline( device, &spi );
        if( !g_ctx.sky_pipeline ) {
            write_status( "sky pipeline creation failed: " + std::string( SDL_GetError() ) );
        }
    } else {
        write_status( "sky shaders missing; procedural sky disabled" );
    }
    if( sky_vs ) {
        SDL_ReleaseGPUShader( device, sky_vs );
    }
    if( sky_fs ) {
        SDL_ReleaseGPUShader( device, sky_fs );
    }

    SDL_GPUBufferCreateInfo bi{};
    bi.usage = SDL_GPU_BUFFERUSAGE_VERTEX;
    bi.size = cube_vertices().size() * sizeof( float );
    g_ctx.cube_vb = SDL_CreateGPUBuffer( device, &bi );
    bi.size = xquad_vertices().size() * sizeof( float );
    g_ctx.xquad_vb = SDL_CreateGPUBuffer( device, &bi );
    bi.size = quad_vertices().size() * sizeof( float );
    g_ctx.quad_vb = SDL_CreateGPUBuffer( device, &bi );
    bi.size = flatquad_vertices().size() * sizeof( float );
    g_ctx.flatquad_vb = SDL_CreateGPUBuffer( device, &bi );
    // slack past MAX_DRAW_INSTANCES: the cap is checked per tile, and one tile
    // (a fence corner with furniture + items) can push several past it. Each
    // slot owns its instance VB so a pending frame never shares it with a new one.
    bi.size = ( MAX_DRAW_INSTANCES + 64 ) * INSTANCE_STRIDE;
    for( frame_slot &slot : g_ctx.slots ) {
        slot.instance_vb = SDL_CreateGPUBuffer( device, &bi );
    }
    bool buffers_ok = g_ctx.cube_vb && g_ctx.xquad_vb && g_ctx.quad_vb && g_ctx.flatquad_vb;
    for( const frame_slot &slot : g_ctx.slots ) {
        buffers_ok = buffers_ok && slot.instance_vb;
    }
    if( !buffers_ok ) {
        DebugLog( D_ERROR, DC_ALL ) << "render3d: buffer creation failed: " << SDL_GetError();
        write_status( "unavailable: buffer creation failed" );
        g_ctx.teardown();
        return false;
    }

    // nearest-neighbor sampling for pixel-art sprites
    SDL_GPUSamplerCreateInfo si{};
    si.min_filter = SDL_GPU_FILTER_NEAREST;
    si.mag_filter = SDL_GPU_FILTER_NEAREST;
    si.mipmap_mode = SDL_GPU_SAMPLERMIPMAPMODE_NEAREST;
    si.address_mode_u = SDL_GPU_SAMPLERADDRESSMODE_CLAMP_TO_EDGE;
    si.address_mode_v = SDL_GPU_SAMPLERADDRESSMODE_CLAMP_TO_EDGE;
    si.address_mode_w = SDL_GPU_SAMPLERADDRESSMODE_CLAMP_TO_EDGE;
    g_ctx.sampler = SDL_CreateGPUSampler( device, &si );
    if( !g_ctx.sampler ) {
        DebugLog( D_ERROR, DC_ALL ) << "render3d: sampler creation failed: " << SDL_GetError();
        write_status( "unavailable: sampler creation failed" );
        g_ctx.teardown();
        return false;
    }

    // 1x1 white texture bound for untextured batches (the fragment shader never
    // samples it there, but the binding slot must hold a valid texture)
    {
        SDL_GPUTextureCreateInfo tci{};
        tci.type = SDL_GPU_TEXTURETYPE_2D;
        tci.format = SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UNORM;
        tci.usage = SDL_GPU_TEXTUREUSAGE_SAMPLER;
        tci.width = 1;
        tci.height = 1;
        tci.layer_count_or_depth = 1;
        tci.num_levels = 1;
        tci.sample_count = SDL_GPU_SAMPLECOUNT_1;
        g_ctx.fallback_tex = SDL_CreateGPUTexture( device, &tci );
        if( !g_ctx.fallback_tex ) {
            DebugLog( D_ERROR, DC_ALL ) << "render3d: fallback texture creation failed: " <<
                                        SDL_GetError();
            write_status( "unavailable: fallback texture creation failed" );
            g_ctx.teardown();
            return false;
        }
    }

    // one-time upload of the static geometry + fallback texel
    const uint32_t white_pixel = 0xFFFFFFFFu;
    const size_t cube_bytes = cube_vertices().size() * sizeof( float );
    const size_t xquad_bytes = xquad_vertices().size() * sizeof( float );
    const size_t quad_bytes = quad_vertices().size() * sizeof( float );
    const size_t flatquad_bytes = flatquad_vertices().size() * sizeof( float );
    SDL_GPUTransferBufferCreateInfo ti{};
    ti.usage = SDL_GPU_TRANSFERBUFFERUSAGE_UPLOAD;
    ti.size = cube_bytes + xquad_bytes + quad_bytes + flatquad_bytes + sizeof( white_pixel );
    SDL_GPUTransferBuffer *tb = SDL_CreateGPUTransferBuffer( device, &ti );
    if( !tb ) {
        DebugLog( D_ERROR, DC_ALL ) << "render3d: transfer buffer creation failed: " << SDL_GetError();
        write_status( "unavailable: transfer buffer creation failed" );
        g_ctx.teardown();
        return false;
    }
    {
        char *mapped = static_cast<char *>( SDL_MapGPUTransferBuffer( device, tb, false ) );
        std::memcpy( mapped, cube_vertices().data(), cube_bytes );
        std::memcpy( mapped + cube_bytes, xquad_vertices().data(), xquad_bytes );
        std::memcpy( mapped + cube_bytes + xquad_bytes, quad_vertices().data(), quad_bytes );
        std::memcpy( mapped + cube_bytes + xquad_bytes + quad_bytes, flatquad_vertices().data(),
                     flatquad_bytes );
        std::memcpy( mapped + cube_bytes + xquad_bytes + quad_bytes + flatquad_bytes,
                     &white_pixel, sizeof( white_pixel ) );
        SDL_UnmapGPUTransferBuffer( device, tb );
    }

    {
        SDL_GPUCommandBuffer *cmd = SDL_AcquireGPUCommandBuffer( device );
        SDL_GPUCopyPass *copy = SDL_BeginGPUCopyPass( cmd );
        SDL_GPUTransferBufferLocation src{};
        src.transfer_buffer = tb;
        SDL_GPUBufferRegion dst{};
        const std::array<std::pair<SDL_GPUBuffer *, size_t>, 4> vb_uploads = {{
                { g_ctx.cube_vb, cube_bytes },
                { g_ctx.xquad_vb, xquad_bytes },
                { g_ctx.quad_vb, quad_bytes },
                { g_ctx.flatquad_vb, flatquad_bytes },
            }
        };
        size_t src_offset = 0;
        for( const auto &[buf, bytes] : vb_uploads ) {
            src.offset = src_offset;
            dst.buffer = buf;
            dst.offset = 0;
            dst.size = bytes;
            SDL_UploadToGPUBuffer( copy, &src, &dst, false );
            src_offset += bytes;
        }
        SDL_GPUTextureTransferInfo tex_src{};
        tex_src.transfer_buffer = tb;
        tex_src.offset = src_offset;
        SDL_GPUTextureRegion tex_dst{};
        tex_dst.texture = g_ctx.fallback_tex;
        tex_dst.w = 1;
        tex_dst.h = 1;
        tex_dst.d = 1;
        SDL_UploadToGPUTexture( copy, &tex_src, &tex_dst, false );
        SDL_EndGPUCopyPass( copy );
        if( !SDL_SubmitGPUCommandBuffer( cmd ) ) {
            DebugLog( D_ERROR, DC_ALL ) << "render3d: static upload submit failed: " << SDL_GetError();
            write_status( "unavailable: static upload submit failed" );
            SDL_ReleaseGPUTransferBuffer( device, tb );
            g_ctx.teardown();
            return false;
        }
    }
    SDL_ReleaseGPUTransferBuffer( device, tb );

    build_glyph_atlas( renderer );

    g_available = true;
    DebugLog( D_INFO, DC_ALL ) << "render3d: probe OK";
    write_status( "probe OK: device + pipeline + buffers created" );
    return true;
}

// hash terrain id -> pleasant-ish pastel hue
void terrain_color( const int id, float &r, float &g, float &b )
{
    const uint32_t h = static_cast<uint32_t>( id ) * 2654435761u;
    const float hue = static_cast<float>( h % 360u ) / 60.0f;
    const float x = 1.0f - std::fabs( std::fmod( hue, 2.0f ) - 1.0f );
    float rr = 0.0f;
    float gg = 0.0f;
    float bb = 0.0f;
    const int sector = static_cast<int>( hue );
    switch( sector ) {
        case 0:
            rr = 1.0f;
            gg = x;
            break;
        case 1:
            rr = x;
            gg = 1.0f;
            break;
        case 2:
            gg = 1.0f;
            bb = x;
            break;
        case 3:
            gg = x;
            bb = 1.0f;
            break;
        case 4:
            rr = x;
            bb = 1.0f;
            break;
        default:
            rr = 1.0f;
            bb = x;
            break;
    }
    // desaturate toward gray so the scene does not look like candy
    const float gray = ( rr + gg + bb ) / 3.0f;
    r = gray + ( rr - gray ) * 0.55f;
    g = gray + ( gg - gray ) * 0.55f;
    b = gray + ( bb - gray ) * 0.55f;
}

// SDL_Texture -> its backing GPU texture (same pattern as cata_shader.cpp's
// gpu_texture_of; valid because our renderer is always the GPU-backed one)
SDL_GPUTexture *gpu_texture_of( SDL_Texture *texture )
{
    return static_cast<SDL_GPUTexture *>( SDL_GetPointerProperty( SDL_GetTextureProperties( texture ),
                                          SDL_PROP_TEXTURE_GPU_TEXTURE_POINTER, nullptr ) );
}

struct sprite_info {
    SDL_Texture *atlas = nullptr;
    float u0 = 0.0f, v0 = 0.0f, u1 = 0.0f, v1 = 0.0f;
    // opaque-cropped uv, used by the ground layer and utility shells:
    // big-section sprites (giant.png trees etc.) are larger than one tile with
    // transparent padding which 2D hides via anchoring; a no-discard floor would
    // show the padding as black margins, and a utility shell must not extrude it
    float gu0 = 0.0f, gv0 = 0.0f, gu1 = 0.0f, gv1 = 0.0f;
    std::shared_ptr<const sprite_alpha_profile> alpha_profile;
    float aspect = 1.0f; // sprite pixel width / height
    // sprite canvas size in tileset pixels; the paper doll uses it (with
    // `offset`) to place overlay layers on the same canvas scale as the body
    int px_w = 0;
    int px_h = 0;
    // tilesheet sprite offset (tile_type::offset), in tileset pixels: 2D draws
    // every sprite at tile origin + offset, which is what aligns a hat with the
    // head instead of dropping its opaque bottom to the ground
    point offset = point::zero;
    // fraction of the sprite's height below which everything is transparent;
    // vertical sprites (trees, furniture, creatures) are dropped by this amount
    // so their opaque base touches the ground instead of floating
    float base_drop = 0.0f;
    // true when the opaque bounds cover much less than the whole sprite —
    // connection sub-sprites (road/roof corners and edges) have genuinely
    // transparent regions that must alpha-cutout instead of rendering black
    bool has_transparency = false;
};

bool fill_sprite_info( const texture_draw_data &d, sprite_info &out )
{
    if( !d.texture || !gpu_texture_of( d.texture ) ) {
        return false;
    }
    out.atlas = d.texture;
    out.u0 = d.uv0.first;
    out.v0 = d.uv0.second;
    out.u1 = d.uv1.first;
    out.v1 = d.uv1.second;
    out.aspect = d.dimensions.h > 0
                 ? static_cast<float>( d.dimensions.w ) / static_cast<float>( d.dimensions.h )
                 : 1.0f;
    out.px_w = d.dimensions.w;
    out.px_h = d.dimensions.h;
    out.alpha_profile = d.alpha_profile;
    if( d.opaque_rect.w > 0 && d.dimensions.w > 0 && d.dimensions.h > 0 ) {
        const float dw = static_cast<float>( d.dimensions.w );
        const float dh = static_cast<float>( d.dimensions.h );
        out.gu0 = out.u0 + ( out.u1 - out.u0 ) *
                  ( static_cast<float>( d.opaque_rect.x ) / dw );
        out.gu1 = out.u0 + ( out.u1 - out.u0 ) *
                  ( static_cast<float>( d.opaque_rect.x + d.opaque_rect.w ) / dw );
        out.gv0 = out.v0 + ( out.v1 - out.v0 ) *
                  ( static_cast<float>( d.opaque_rect.y ) / dh );
        out.gv1 = out.v0 + ( out.v1 - out.v0 ) *
                  ( static_cast<float>( d.opaque_rect.y + d.opaque_rect.h ) / dh );
        out.base_drop = std::clamp( 1.0f - static_cast<float>( d.opaque_rect.y + d.opaque_rect.h ) /
                                    dh, 0.0f, 1.0f );
        // the opaque bbox of an L-shaped corner piece can still span the whole
        // sprite, so compare areas: anything meaningfully hollow counts
        out.has_transparency =
            static_cast<long long>( d.opaque_rect.w ) * d.opaque_rect.h * 20 <
            static_cast<long long>( d.dimensions.w ) * d.dimensions.h * 19;
    } else {
        out.gu0 = out.u0;
        out.gv0 = out.v0;
        out.gu1 = out.u1;
        out.gv1 = out.v1;
        out.base_drop = 0.0f;
    }
    return true;
}

// multitile subtile sprite keys, same order as MULTITILE_TYPE (enums.h)
const std::array<const char *, 8> multitile_keys = {{
        "center", "corner", "edge", "t_connection",
        "end_piece", "unconnected", "open", "broken"
    }
};

constexpr int SUBTILE_EDGE = 2; // enums.h MULTITILE_TYPE::edge

// doors and windows, matching the classification both gather paths use: plain
// doors carry DOOR; closed doors/windows expose an "open" transform; the
// barricadable families cover locked and broken doors; locked doors that can
// only be opened with a keycard or tool (t_door_metal_locked and friends)
// carry neither DOOR nor a transform, just LOCKED. a bare "close" transform is
// NOT enough: WALL-flagged shutter terrains have one too and must stay walls.
// enum flags: this runs per tile per frame (bitflags are much cheaper than the
// string overload); the one flag without an enum keeps a static string.
bool door_or_window( const ter_t &t )
{
    if( t.has_flag( ter_furn_flag::TFLAG_DOOR ) ||
        t.has_flag( ter_furn_flag::TFLAG_WINDOW ) || !t.open.is_null() ||
        t.has_flag( ter_furn_flag::TFLAG_BARRICADABLE_DOOR ) ||
        t.has_flag( ter_furn_flag::TFLAG_BARRICADABLE_DOOR_DAMAGED ) ||
        t.has_flag( ter_furn_flag::TFLAG_BARRICADABLE_DOOR_REINFORCED ) ||
        ( t.has_flag( ter_furn_flag::TFLAG_LOCKED ) &&
          !t.has_flag( ter_furn_flag::TFLAG_THIN_OBSTACLE ) ) ) {
        return true;
    }
    static const std::string broken_reinforced( "BARRICADABLE_DOOR_REINFORCED_DAMAGED" );
    return t.has_flag( broken_reinforced );
}

// does this terrain join the WALL connect line (the terrain's "connects_to")?
bool joins_wall_line( const ter_t &t )
{
    static const int wall_group = get_connect_group( "WALL" ).index;
    return t.connect_to_groups.test( wall_group );
}

// a passable doorway sitting in a wall line: an open door or gate (only a
// "close" transform; open/close never inherit through copy-from), or an empty
// door/window frame — a flat, roof-bearing, wall-connected tile. open windows
// keep WINDOW and stay panels.
bool wall_opening( const ter_t &t )
{
    if( t.has_flag( ter_furn_flag::TFLAG_WINDOW ) ||
        t.has_flag( ter_furn_flag::TFLAG_DOOR ) || t.movecost <= 0 ||
        t.has_flag( ter_furn_flag::TFLAG_WALL ) ||
        t.has_flag( ter_furn_flag::TFLAG_THIN_OBSTACLE ) ||
        !joins_wall_line( t ) ) {
        return false;
    }
    return !t.close.is_null() ||
           ( t.has_flag( ter_furn_flag::TFLAG_FLAT ) &&
             t.has_flag( ter_furn_flag::TFLAG_SUPPORTS_ROOF ) );
}

// a genuinely empty window/door frame: the opening is structural, with no
// terrain sprite standing in it. open doors and closeable windows keep their
// panels and their own fg/bg composition
bool empty_frame_terrain( const ter_t &t )
{
    return t.movecost > 0 && t.open.is_null() && t.close.is_null() &&
           ( t.has_flag( ter_furn_flag::TFLAG_WINDOW ) || wall_opening( t ) );
}

// a solid wall whose sprite can clamp a door/window panel (sill + lintel) or
// back a doorway's lintel: WALL-flagged, impassable, never a panel or a fence
bool wall_terrain( const ter_t &t )
{
    return t.movecost == 0 && t.has_flag( ter_furn_flag::TFLAG_WALL ) &&
           !door_or_window( t ) &&
           !t.has_flag( ter_furn_flag::TFLAG_THIN_OBSTACLE );
}

// ground-level utility runs are horizontal surfaces, not standing barriers.
// Match the terrain's own id, never looks_like: downspouts borrow the metal-post
// sprite, and real posts must remain vertical.
bool flat_utility_terrain( const ter_t &t, const int z )
{
    static constexpr std::array<std::string_view, 7> ground_ids = {{
            "t_sewage_pipe", "t_nl_sewage_pipe", "t_nl_sewage_pipe_border",
            "t_LIXA_tube", "t_LIXA_unfolded_tube", "t_LIXA_unfolded_tube_broken",
            "t_gutter"
        }
    };
    const std::string_view id( t.id.str() );
    if( std::find( ground_ids.begin(), ground_ids.end(), id ) != ground_ids.end() ) {
        return true;
    }
    if( z <= 0 ) {
        return false;
    }
    static constexpr std::array<std::string_view, 4> roof_ids = {{
            "t_gutter_drop", "t_gutter_downspout",
            "t_vitrified_gutter_drop", "t_vitrified_downspout"
        }
    };
    return std::find( roof_ids.begin(), roof_ids.end(), id ) != roof_ids.end();
}

// freestanding recreational equipment has a vertical face, not a floor decal
bool upright_equipment_terrain( const ter_t &t )
{
    static constexpr std::array<std::string_view, 2> ids = {{ "t_monkey_bars", "t_slide" }};
    return std::find( ids.begin(), ids.end(), std::string_view( t.id.str() ) ) != ids.end();
}

// Furniture that is genuinely a ground covering or horizontal walking surface.
// Do not infer this from FLAT_SURF or looks_like: tables and beds have height,
// and cardboard roofs use the same FLAT flag as cardboard floors.
bool flat_furniture( const furn_t &f )
{
    static constexpr std::array<std::string_view, 13> ids = {{
            "f_tatami",
            "f_groundsheet", "f_large_groundsheet", "f_center_groundsheet", "f_fema_groundsheet",
            "f_skin_groundsheet", "f_large_skin_groundsheet", "f_skin_center_groundsheet",
            "f_fiber_mat", "f_leather_tarp", "f_plastic_groundsheet",
            "f_cardboard_floor", "f_scrap_bridge"
        }
    };
    return std::find( ids.begin(), ids.end(), std::string_view( f.id.str() ) ) != ids.end();
}

// 2D composites a tile's bg under its fg. for a few locked/alarmed objects the
// tileset splits the sprite into bg = the body and fg = a small indicator icon
// (UC: key 1778, alarm 8855), so 3D must draw both layers or only the icon
// shows. safes and electronic safes carry no LOCKED flag, only an examine
// action. deliberately NOT "any sprite with a bg": some furniture uses the
// ground texture as bg, which must not be stood up as a billboard
bool wants_layered_face( const map_data_common_t &d )
{
    return d.has_flag( ter_furn_flag::TFLAG_LOCKED ) ||
           d.has_flag( ter_furn_flag::TFLAG_ALARMED ) ||
           d.has_flag( ter_furn_flag::TFLAG_PICKABLE ) ||
           d.has_examine( iexamine::safe ) ||
           d.has_examine( iexamine::gunsafe_el );
}

// one end of the door/window run a panel or doorway sits in. consecutive doors
// and windows — open ones and empty frames included — are one unit, so the
// scan walks over the whole run and returns the first true wall at that end. a
// run that ends in open ground, a fence, the map edge or unknown memory
// (get_ter returns nullptr) has no wall to inherit: nullptr.
template<typename TerAt>
const ter_t *panel_run_end( const tripoint_bub_ms &p, const point &step,
                            const TerAt &get_ter, tripoint_bub_ms &wall_pos )
{
    tripoint_bub_ms q = p;
    for( ;; ) {
        q += step;
        if( !get_map().inbounds( q ) ) {
            return nullptr;
        }
        const ter_t *nt = get_ter( q );
        if( nt == nullptr ) {
            return nullptr;
        }
        if( door_or_window( *nt ) || wall_opening( *nt ) ) {
            continue;
        }
        if( !wall_terrain( *nt ) ) {
            return nullptr;
        }
        wall_pos = q;
        return nt;
    }
}

// the wall sprite's vertical slice between heights z0..z1, as if a full wall
// were cut at those heights — not the whole sprite squashed into a small box
sprite_info wall_slice( const sprite_info &s, const float z0, const float z1 )
{
    sprite_info r = s;
    r.v0 = s.v1 - ( z1 / WALL_HEIGHT ) * ( s.v1 - s.v0 );
    r.v1 = s.v1 - ( z0 / WALL_HEIGHT ) * ( s.v1 - s.v0 );
    return r;
}

// connection mask (S=1, E=2, W=4, N=8) encoded by a memorized multitile
// subtile/rotation pair. The table mirrors cata_tiles::get_rotation_and_subtile:
// a map-memory tile only carries these two numbers, not its neighbors, so a
// remembered fence's bend has to be reconstructed from them.
uint8_t memory_conn_mask( const int subtile, const int rotation )
{
    const int rot = ( ( rotation % 4 ) + 4 ) % 4;
    switch( subtile ) {
        case 0: // center
            return 15;
        case 1: { // corner: 0 = S+E, 1 = S+W, 2 = W+N, 3 = E+N
            static const uint8_t corners[4] = { 1 | 2, 1 | 4, 4 | 8, 2 | 8 };
            return corners[rot];
        }
        case 2: // edge: even = N+S, odd = E+W
            return ( rot % 2 ) ? ( 2 | 4 ) : ( 1 | 8 );
        case 3: { // t_connection: the rotation names the missing arm
            static const uint8_t tees[4] = { 15 & ~8, 15 & ~2, 15 & ~1, 15 & ~4 };
            return tees[rot];
        }
        case 4: { // end_piece: 0 = toward S, 1 = W, 2 = N, 3 = E
            static const uint8_t ends[4] = { 1, 4, 8, 2 };
            return ends[rot];
        }
        default: // unconnected / open / broken
            return 0;
    }
}

// Sprite resolution repeats heavily for floors, walls, roads and remembered
// terrain. Single-variant results are position-independent and can survive
// across frames; multi-variant results still resolve per tile below.
struct sprite_lookup_key {
    std::string_view id;
    std::string_view variant;
    int category = 0;
    int subtile = 0;
    int rota = 0;
    int force = 0;
    int season = 0;
    bool operator==( const sprite_lookup_key &o ) const {
        return category == o.category && subtile == o.subtile && rota == o.rota &&
               force == o.force && season == o.season && id == o.id && variant == o.variant;
    }
};

struct sprite_lookup_hash {
    size_t operator()( const sprite_lookup_key &k ) const {
        size_t h = std::hash<std::string_view> {}( k.id );
        h ^= std::hash<std::string_view> {}( k.variant ) + 0x9e3779b9u + ( h << 6 ) + ( h >> 2 );
        h = h * 1000003u + static_cast<size_t>( k.category );
        h = h * 1000003u + static_cast<size_t>( k.subtile );
        h = h * 1000003u + static_cast<size_t>( k.rota );
        h = h * 1000003u + static_cast<size_t>( k.force );
        h = h * 1000003u + static_cast<size_t>( k.season );
        return h;
    }
};

// 3D-side view of cata_tiles::resolve_sprite_layers_3d: the fg/bg layers plus
// the selected variant info, converted to renderable sprite_info
struct sprite_lookup_3d {
    sprite_info fg;
    bool fg_tex = false;
    sprite_info bg;
    bool bg_tex = false;
    bool multitile = false;
    int fg_count = 0;
    int fg_index = -1;
    int bg_count = 0;
    int bg_index = -1;
    int fg_rot4 = 0;
    point offset; // sheet sprite offset of the resolved tile (sprite pixels)
    std::string resolved_id;
};

struct cached_sprite_lookup_3d {
    // The unordered_map's string_view keys point here. A shared_ptr keeps this
    // entry (and therefore those strings) at a stable address across rehashes.
    std::string id;
    std::string variant;
    sprite_lookup_3d value;
    std::shared_ptr<SDL_Texture> fg_owner;
    std::shared_ptr<SDL_Texture> bg_owner;
};

using sprite_lookup_cache = std::unordered_map<sprite_lookup_key,
      std::shared_ptr<cached_sprite_lookup_3d>, sprite_lookup_hash>;

sprite_lookup_cache &sprite_cache()
{
    static sprite_lookup_cache cache;
    return cache;
}

std::shared_ptr<const tileset> &sprite_cache_tileset()
{
    static std::shared_ptr<const tileset> cached;
    return cached;
}

void clear_sprite_lookup_cache()
{
    sprite_cache().clear();
    sprite_cache_tileset().reset();
}

void retain_frame_texture( const std::shared_ptr<SDL_Texture> &texture )
{
    if( !g_recording_slot || !texture ) {
        return;
    }
    SDL_Texture *const raw = texture.get();
    auto &owners = g_recording_slot->texture_owners;
    if( owners.find( raw ) == owners.end() ) {
        owners.emplace( raw, texture );
    }
}

bool lookup_sprite_layers_3d( cata_tiles *tiles, const std::string &id,
                              const TILE_CATEGORY cat, const tripoint_bub_ms &p,
                              const int subtile, const int rota, const bool force_rota,
                              sprite_lookup_3d &out, const std::string &variant = "" )
{
    out = sprite_lookup_3d{};
    if( !tiles ) {
        return false;
    }

    const std::shared_ptr<const tileset> &current_tileset = tiles->get_tileset_3d();
    if( sprite_cache_tileset() != current_tileset ) {
        clear_sprite_lookup_cache();
        sprite_cache_tileset() = current_tileset;
    }
    sprite_lookup_key key{ id, variant, static_cast<int>( cat ), subtile, rota,
                           force_rota ? 1 : 0,
                           static_cast<int>( season_of_year( calendar::turn ) ) };
    sprite_lookup_cache &cache = sprite_cache();
    if( const auto it = cache.find( key ); it != cache.end() ) {
        const cached_sprite_lookup_3d &cached = *it->second;
        out = cached.value;
        retain_frame_texture( cached.fg_owner );
        retain_frame_texture( cached.bg_owner );
        ++g_profile.sprite_cache_hits;
        return out.fg_tex;
    }

    sprite_layers_3d layers;
    tiles->resolve_sprite_layers_3d( id, cat, p, subtile, rota, force_rota, layers,
                                     variant );
    retain_frame_texture( layers.fg_owner );
    retain_frame_texture( layers.bg_owner );
    out.multitile = layers.multitile;
    out.fg_count = layers.fg_count;
    out.fg_index = layers.fg_index;
    out.bg_count = layers.bg_count;
    out.bg_index = layers.bg_index;
    out.fg_rot4 = layers.rot4;
    out.offset = layers.offset;
    if( layers.resolved_id ) {
        out.resolved_id = *layers.resolved_id;
    }
    if( layers.fg ) {
        out.fg_tex = fill_sprite_info( *layers.fg, out.fg );
    }
    if( layers.bg ) {
        out.bg_tex = fill_sprite_info( *layers.bg, out.bg );
    }
    if( ( layers.fg_found || layers.bg_found ) && layers.fg_variant_count <= 1 &&
        layers.bg_variant_count <= 1 ) {
        constexpr size_t max_entries = 65536;
        if( cache.size() >= max_entries ) {
            cache.clear();
        }
        auto cached = std::make_shared<cached_sprite_lookup_3d>();
        cached->id = id;
        cached->variant = variant;
        cached->value = out;
        cached->fg_owner = layers.fg_owner;
        cached->bg_owner = layers.bg_owner;
        const sprite_lookup_key stored_key{ cached->id, cached->variant, key.category,
                                            key.subtile, key.rota, key.force, key.season };
        cache.emplace( stored_key, std::move( cached ) );
    }
    return out.fg_tex;
}

// fg-only convenience: furniture, items, creatures, cursors, wall flanks
bool lookup_sprite( cata_tiles *tiles, const std::string &id, const TILE_CATEGORY cat,
                    const tripoint_bub_ms &p, sprite_info &out, const int rot = 0,
                    int *rot4_out = nullptr )
{
    sprite_lookup_3d l;
    lookup_sprite_layers_3d( tiles, id, cat, p, -1, rot, true, l );
    out = l.fg;
    out.offset = l.offset;
    if( rot4_out ) {
        *rot4_out = l.fg_rot4;
    }
    return l.fg_tex;
}

// instances grouped by (geometry mode, atlas texture) -> one draw call each
struct instance_bucket {
    int mode = MODE_BOX;
    SDL_Texture *atlas = nullptr; // null -> untextured (hash color)
    std::vector<float> data;      // INSTANCE_STRIDE/4 floats per instance
};

struct bucket_key {
    int mode;
    SDL_Texture *atlas;
    bool operator==( const bucket_key &other ) const {
        return mode == other.mode && atlas == other.atlas;
    }
};

struct bucket_key_hash {
    size_t operator()( const bucket_key &key ) const {
        size_t h = std::hash<SDL_Texture *> {}( key.atlas );
        h ^= std::hash<int> {}( key.mode ) + 0x9e3779b9u + ( h << 6 ) + ( h >> 2 );
        return h;
    }
};

using bucket_index_map = std::unordered_map<bucket_key, size_t, bucket_key_hash>;

// one decal instance in a single painter-ordered stream (push order = the
// gather's row order = 2D's north->south, west->east row order). Unlike the
// buckets, the stream keeps cross-atlas ordering, so overlapping vehicle
// sprites from different tilesheets resolve exactly like 2D's back-to-front
// blits; draw_terrain_window splits it into one segment per run of
// consecutive same-(mode, atlas) instances
struct decal_instance {
    int mode = MODE_FLATQUAD_DECAL;
    SDL_Texture *atlas = nullptr;
    float f[INSTANCE_STRIDE / sizeof( float )] = {};
    // vehicle side panels only: painter key for the camera-relative far->near
    // sort of the panel sub-stream (dot of the center-relative position with
    // the camera's ground forward); unused (0) for the skin decal stream
    float sort_key = 0.0f;
};

struct instance_sink {
    float *data;
    // Intentional implicit conversions keep the instance emission call sites small.
    // NOLINTNEXTLINE(google-explicit-constructor)
    instance_sink( float *data ) : data( data ) {}
    // NOLINTNEXTLINE(google-explicit-constructor)
    instance_sink( std::vector<float> &out ) {
        const size_t offset = out.size();
        out.resize( offset + INSTANCE_STRIDE / sizeof( float ) );
        data = out.data() + offset;
    }
};

void push_instance( instance_sink out, const float dx, const float dy,
                    const float z, const float sx, const float sy, const float sz,
                    const sprite_info &spr, const float r, const float g, const float b,
                    const bool no_discard = false, const int rota4 = 0,
                    const bool side_strip = false, const float pad_value = -1.0f,
                    const bool ghost = false, const float saturation = 1.0f,
                    const bool memory = false, const bool soft_alpha = false,
                    const bool edge_skirt = false )
{
    out.data[0] = dx;
    out.data[1] = dy;
    out.data[2] = z;
    out.data[3] = sx;
    out.data[4] = sy;
    out.data[5] = sz;
    out.data[6] = spr.u0;
    out.data[7] = spr.v0;
    out.data[8] = spr.u1;
    out.data[9] = spr.v1;
    out.data[10] = r;
    out.data[11] = g;
    out.data[12] = b;
    // color alpha carries the tile light's saturation (1 = full color,
    // 0 = grayscale), matching 2D's lit shader low-light drain
    out.data[13] = saturation;
    // bit0: textured, bit1: no alpha cutout (ground layer),
    // bit2-3: top-face uv quarter turns, bit4: side faces sample the
    // horizontal strip at pad (the sprite's opaque bottom edge),
    // bit5: ghost — dithered 50% transparency (levels above an indoor column),
    // bit6: memory — map-memory look, unlit (2D leaves remembered tiles
    // unlit and recolors them through the MEMORY_MAP_MODE preset),
    // bit7: soft alpha — dithered translucency proportional to the sampled
    // alpha, for field sprites whose semi-transparent pixels 2D would blend
    // bit8: silhouette side — transpose linequad UV so the run follows sprite v
    // while sampling a fixed sprite-u edge column (independent of world rotation)
    // pad: side-strip v, or the run direction for MODE_LINEQUAD (0 = E-W)
    out.data[14] = ( spr.atlas ? 1.0f : 0.0f ) + ( no_discard ? 2.0f : 0.0f ) +
                   static_cast<float>( ( rota4 & 3 ) << 2 ) + ( side_strip ? 16.0f : 0.0f ) +
                   ( ghost ? 32.0f : 0.0f ) + ( memory ? 64.0f : 0.0f ) +
                   ( soft_alpha ? 128.0f : 0.0f ) + ( edge_skirt ? 256.0f : 0.0f );
    out.data[15] = pad_value >= 0.0f ? pad_value
                   : ( side_strip ? spr.v1 - 0.02f * ( spr.v1 - spr.v0 ) : 0.0f );
}

// A ground-level utility keeps its full horizontal sprite and extends the
// actual alpha silhouette down to the floor. Runs with the same boundary are
// merged so pixel-art detail does not turn into one instance per pixel.
int push_utility_shell( std::vector<float> &top_out, std::vector<float> &side_out,
                        const float dx, const float dy, const float wz,
                        const sprite_info &spr, const float r, const float g, const float b,
                        const int rota4, const bool ghost, const float saturation,
                        const bool memory )
{
    push_instance( top_out, dx, dy, wz + FLAT_UTILITY_Z, 1.0f, 1.0f, 1.0f, spr,
                   r, g, b, false, rota4, false, -1.0f, ghost, saturation, memory );
    int emitted = 1;
    const float side_base = wz - 0.001f;
    const float side_height = FLAT_UTILITY_Z + 0.001f;
    const int rot = rota4 & 3;

    const auto inverse_point = [rot]( const float u, const float v, float & x, float & y ) {
        if( rot == 1 ) {
            x = 1.0f - v;
            y = u;
        } else if( rot == 2 ) {
            x = 1.0f - u;
            y = 1.0f - v;
        } else if( rot == 3 ) {
            x = v;
            y = 1.0f - u;
        } else {
            x = u;
            y = v;
        }
    };
    const auto inverse_direction = [rot]( const float u, const float v, float & x, float & y ) {
        if( rot == 1 ) {
            x = -v;
            y = u;
        } else if( rot == 2 ) {
            x = -u;
            y = -v;
        } else if( rot == 3 ) {
            x = v;
            y = -u;
        } else {
            x = u;
            y = v;
        }
    };

    const auto emit_edge = [&]( const float lo, const float hi, const float fixed,
                                const float uv_lo, const float uv_hi, const float uv_fixed,
    const bool along_x ) {
        if( hi <= lo ) {
            return;
        }
        sprite_info edge = spr;
        const auto atlas_u = [&]( const float u ) {
            return spr.u0 + u * ( spr.u1 - spr.u0 );
        };
        const auto atlas_v = [&]( const float v ) {
            return spr.v0 + v * ( spr.v1 - spr.v0 );
        };
        if( along_x ) {
            edge.u0 = atlas_u( uv_lo );
            edge.u1 = atlas_u( uv_hi );
            edge.v0 = edge.v1 = atlas_v( uv_fixed );
        } else {
            edge.u0 = edge.u1 = atlas_u( uv_fixed );
            edge.v0 = atlas_v( uv_lo );
            edge.v1 = atlas_v( uv_hi );
        }

        const float cx = along_x ? ( lo + hi ) * 0.5f : fixed;
        const float cy = along_x ? fixed : ( lo + hi ) * 0.5f;
        float wx;
        float wy;
        float dirx;
        float diry;
        inverse_point( cx, cy, wx, wy );
        inverse_direction( along_x ? 1.0f : 0.0f, along_x ? 0.0f : 1.0f, dirx, diry );
        const float run_pad = std::abs( diry ) > 0.5f ? 1.0f : 0.0f;
        const bool reversed = run_pad == 0 ? dirx < 0.0f : diry < 0.0f;
        if( reversed ) {
            if( along_x ) {
                std::swap( edge.u0, edge.u1 );
            } else {
                std::swap( edge.v0, edge.v1 );
            }
        }
        push_instance( side_out, dx + wx, dy + wy, side_base, hi - lo, side_height, 1.0f,
                       edge, r, g, b, false, 0, false, run_pad, ghost, saturation, memory,
                       false, !along_x );
        ++emitted;
    };

    const int w = std::max( spr.px_w, 1 );
    const int h = std::max( spr.px_h, 1 );
    sprite_alpha_profile fallback;
    const sprite_alpha_profile *profile = spr.alpha_profile.get();
    if( profile == nullptr || static_cast<int>( profile->top.size() ) < w ||
        static_cast<int>( profile->bottom.size() ) < w ||
        static_cast<int>( profile->left.size() ) < h ||
        static_cast<int>( profile->right.size() ) < h ) {
        fallback.top.assign( w, 0 );
        fallback.bottom.assign( w, h - 1 );
        fallback.left.assign( h, 0 );
        fallback.right.assign( h, w - 1 );
        profile = &fallback;
    }

    for( int x = 0; x < w; ) {
        const int edge = profile->top[x];
        if( edge < 0 ) {
            ++x;
            continue;
        }
        const int begin = x;
        int end = begin + 1;
        while( end < w && profile->top[end] == edge ) {
            ++end;
        }
        emit_edge( begin / static_cast<float>( w ), end / static_cast<float>( w ),
                   edge / static_cast<float>( h ), ( begin + 0.5f ) / w, ( end - 0.5f ) / w,
                   ( edge + 0.5f ) / h, true );
        x = end;
    }
    for( int x = 0; x < w; ) {
        const int edge = profile->bottom[x];
        if( edge < 0 ) {
            ++x;
            continue;
        }
        const int begin = x;
        int end = begin + 1;
        while( end < w && profile->bottom[end] == edge ) {
            ++end;
        }
        emit_edge( begin / static_cast<float>( w ), end / static_cast<float>( w ),
                   ( edge + 1.0f ) / h, ( begin + 0.5f ) / w, ( end - 0.5f ) / w,
                   ( edge + 0.5f ) / h, true );
        x = end;
    }
    for( int y = 0; y < h; ) {
        const int edge = profile->left[y];
        if( edge < 0 ) {
            ++y;
            continue;
        }
        const int begin = y;
        int end = begin + 1;
        while( end < h && profile->left[end] == edge ) {
            ++end;
        }
        emit_edge( begin / static_cast<float>( h ), end / static_cast<float>( h ),
                   edge / static_cast<float>( w ), ( begin + 0.5f ) / h, ( end - 0.5f ) / h,
                   ( edge + 0.5f ) / w, false );
        y = end;
    }
    for( int y = 0; y < h; ) {
        const int edge = profile->right[y];
        if( edge < 0 ) {
            ++y;
            continue;
        }
        const int begin = y;
        int end = begin + 1;
        while( end < h && profile->right[end] == edge ) {
            ++end;
        }
        emit_edge( begin / static_cast<float>( h ), end / static_cast<float>( h ),
                   ( edge + 1.0f ) / w, ( begin + 0.5f ) / h, ( end - 0.5f ) / h,
                   ( edge + 0.5f ) / w, false );
        y = end;
    }
    return emitted;
}

float creature_size_scale( const creature_size size )
{
    switch( size ) {
        case creature_size::tiny:
            return 0.4f;
        case creature_size::small:
            return 0.7f;
        case creature_size::medium:
            return 1.0f;
        case creature_size::large:
            return 1.4f;
        case creature_size::huge:
            return 2.0f;
        default:
            return 1.0f;
    }
}

std::optional<tripoint_bub_ms> tile_at_pixel( const point &logical_pixel,
        const pick_camera &camera, const pick_surfaces &surfaces )
{
    map *const terrain = camera.terrain.get();
    if( !terrain || terrain != &get_map() || camera.viewport.w <= 0.0f || camera.viewport.h <= 0.0f ) {
        return std::nullopt;
    }
    const float nx = ( ( logical_pixel.x - camera.viewport.x ) / camera.viewport.w ) * 2.0f - 1.0f;
    const float ny = 1.0f - ( ( logical_pixel.y - camera.viewport.y ) / camera.viewport.h ) * 2.0f;
    if( nx < -1.0f || nx >= 1.0f || ny <= -1.0f || ny > 1.0f ) {
        return std::nullopt;
    }
    const float tan_half = std::tan( camera_fov * 0.5f );
    const vec3 ray{
        camera.right.x *nx *tan_half *camera.aspect + camera.up.x *ny *tan_half + camera.forward.x,
        camera.right.y *nx *tan_half *camera.aspect + camera.up.y *ny *tan_half + camera.forward.y,
        camera.right.z *nx *tan_half *camera.aspect + camera.up.z *ny *tan_half + camera.forward.z
    };
    const std::optional<tripoint> hit = surfaces.trace( camera.eye, ray, camera.right );
    if( !hit ) {
        return std::nullopt;
    }
    const tripoint_abs_ms tile( camera.center.xy() + hit->xy(), hit->z );
    const tripoint_bub_ms local = terrain->get_bub( tile );
    return terrain->has_loaded_submap( local ) ? std::optional<tripoint_bub_ms>( local ) : std::nullopt;
}

// 2D's nv_color_active: night vision devices worn and the green overlay not
// switched off. the vision-range bonus (get_vision_threshold) already feeds
// the 3D visibility cache, so only the color transform is missing here.
bool nv_tint_active()
{
    return get_avatar().get_vision_modes()[NV_GOGGLES] &&
           get_option<bool>( "NV_GREEN_TOGGLE" );
}

enum region_cell_state : uint8_t {
    REGION_OUTSIDE = 0,
    REGION_ACTIVE,
    REGION_COARSE_SKIP,
    REGION_FRUSTUM_SKIP
};

struct region_cull_mask {
    std::array<uint8_t, MAPSIZE *MAPSIZE> state{};
    bool any_submaps = false;
    bool any_active = false;
    int skipped_submaps = 0;
};

region_cull_mask build_region_cull_mask( map &here, const avatar &you,
        const tripoint_bub_ms &center, const int zlev, const int lowest_vis_z,
        const visibility_variables &vis_vars, const view_frustum &frustum )
{
    region_cull_mask result;
    const int cz = center.z();
    const int dz = zlev - cz;
    const float wz = dz * LEVEL_HEIGHT;
    const int radius = dz == 0 ? VIEW_RADIUS : REGION_RADIUS;
    const int min_x = std::max( 0, center.x() - radius );
    const int max_x = std::min( MAPSIZE_X - 1, center.x() + radius );
    const int min_y = std::max( 0, center.y() - radius );
    const int max_y = std::min( MAPSIZE_Y - 1, center.y() + radius );
    if( min_x > max_x || min_y > max_y ) {
        return result;
    }
    const level_cache &cache = here.get_cache_ref( zlev );
    const bool stale_lower = dz < 0 && zlev < lowest_vis_z;
    const auto clear_light = []( const lit_level ll ) {
        return ll == lit_level::LOW || ll == lit_level::LIT || ll == lit_level::BRIGHT;
    };

    for( int smy = min_y / SEEY; smy <= max_y / SEEY; ++smy ) {
        for( int smx = min_x / SEEX; smx <= max_x / SEEX; ++smx ) {
            result.any_submaps = true;
            const int x0 = std::max( min_x, smx * SEEX );
            const int x1 = std::min( max_x, smx * SEEX + SEEX - 1 );
            const int y0 = std::max( min_y, smy * SEEY );
            const int y1 = std::min( max_y, smy * SEEY + SEEY - 1 );
            uint8_t &state = result.state[smx + smy * MAPSIZE];
            if( !bounds_in_frustum( frustum, static_cast<float>( x0 - center.x() ),
                                    static_cast<float>( y0 - center.y() ),
                                    static_cast<float>( x1 + 1 - center.x() ),
                                    static_cast<float>( y1 + 1 - center.y() ), wz ) ) {
                state = REGION_FRUSTUM_SKIP;
                ++result.skipped_submaps;
                continue;
            }
            // The view level draws fog for invisible tiles without memory, so
            // only camera culling is valid there. Other levels emit nothing for
            // an invisible tile without memory and can use the coarse rules.
            if( dz == 0 ) {
                state = REGION_ACTIVE;
                result.any_active = true;
                continue;
            }

            bool potentially_visible = false;
            if( !stale_lower ) {
                if( dz > 0 && ( vis_vars.u_clairvoyance > 0 || vis_vars.clairvoyance_field ) ) {
                    potentially_visible = true;
                } else {
                    for( int y = y0; y <= y1 && !potentially_visible; ++y ) {
                        for( int x = x0; x <= x1; ++x ) {
                            if( dz > 0 ) {
                                potentially_visible = cache.seen_cache[x][y] > 0.0f ||
                                                      cache.camera_cache[x][y] > 0.0f;
                            } else {
                                potentially_visible = clear_light( cache.visibility_cache[x][y] );
                            }
                            if( potentially_visible ) {
                                break;
                            }
                        }
                    }
                }
            }

            bool uniform_open_air = false;
            if( potentially_visible ) {
                const tripoint_bub_ms first( x0, y0, zlev );
                const submap *sm = here.maptile_at( first ).wrapped_submap();
                if( sm && sm->is_uniform() ) {
                    const ter_id t = sm->get_ter( point_sm_ms::zero );
                    uniform_open_air = t && t->has_flag( ter_furn_flag::TFLAG_NO_FLOOR );
                }
            }

            if( !potentially_visible || uniform_open_air ) {
                const tripoint_bub_ms first( x0, y0, zlev );
                const tripoint_bub_ms last( x1, y1, zlev );
                if( !you.has_map_memory_in_region( here.get_abs( first ), here.get_abs( last ) ) ) {
                    state = REGION_COARSE_SKIP;
                    ++result.skipped_submaps;
                    continue;
                }
            }
            state = REGION_ACTIVE;
            result.any_active = true;
        }
    }
    return result;
}

// Terrain orientation is mostly camera-independent, but known connections also
// consult visibility, transparency and map memory. Validate all of those inputs
// and clear the cache whenever the 3D memory sweep writes new remembered tiles.
struct orientation_cache_key {
    tripoint_abs_ms pos;
    int query = 0;
    bool operator==( const orientation_cache_key &other ) const {
        return pos == other.pos && query == other.query;
    }
};

struct orientation_cache_hash {
    size_t operator()( const orientation_cache_key &key ) const {
        size_t h = std::hash<int> {}( key.pos.x() );
        h = h * 1000003u + static_cast<size_t>( key.pos.y() );
        h = h * 1000003u + static_cast<size_t>( key.pos.z() );
        h = h * 1000003u + static_cast<size_t>( key.query );
        return h;
    }
};

struct orientation_cache_entry {
    uint64_t draw_cache_revision = 0;
    uint64_t visibility_generation = 0;
    bool memory_visible = false;
    int rota = 0;
    int subtile = 0;
    uint8_t connections = 0;
};

using orientation_cache_map =
    std::unordered_map<orientation_cache_key, orientation_cache_entry, orientation_cache_hash>;

orientation_cache_map &orientation_cache()
{
    static orientation_cache_map cache;
    return cache;
}

void clear_orientation_cache()
{
    orientation_cache().clear();
}

template<typename Compute>
const orientation_cache_entry &cached_orientation( map &here, const avatar &you,
        const tripoint_bub_ms &p, const int query, Compute &&compute )
{
    const orientation_cache_key key{ here.get_abs( p ), query };
    const uint64_t draw_cache_revision = here.draw_cache_revision();
    const level_cache &level = here.get_cache_ref( p.z() );
    const bool memory_visible = you.should_show_map_memory();
    orientation_cache_map &cache = orientation_cache();
    auto it = cache.find( key );
    // Map revisions cover geometry and decoration changes; the per-level
    // generation separately catches visibility rebuilds between invalidations.
    if( it != cache.end() &&
        draw_cache_revision != std::numeric_limits<uint64_t>::max() &&
        it->second.draw_cache_revision == draw_cache_revision &&
        it->second.visibility_generation == level.visibility_generation &&
        it->second.memory_visible == memory_visible ) {
        ++g_profile.orientation_cache_hits;
        return it->second;
    }
    if( it == cache.end() ) {
        constexpr size_t max_entries = 65536;
        if( cache.size() >= max_entries ) {
            cache.clear();
        }
        it = cache.emplace( key, orientation_cache_entry{} ).first;
    }
    it->second = orientation_cache_entry{};
    it->second.draw_cache_revision = draw_cache_revision;
    it->second.visibility_generation = level.visibility_generation;
    it->second.memory_visible = memory_visible;
    compute( it->second );
    return it->second;
}

void terrain_rota_subtile_cached( cata_tiles *tiles, map &here, const avatar &you,
                                  const tripoint_bub_ms &p, int &rota, int &subtile )
{
    const orientation_cache_entry &entry = cached_orientation( here, you, p, 0,
    [&]( orientation_cache_entry & out ) {
        tiles->get_terrain_rota_subtile( p, out.rota, out.subtile );
    } );
    rota = entry.rota;
    subtile = entry.subtile;
}

uint8_t terrain_connections_cached( map &here, const avatar &you,
                                    const tripoint_bub_ms &p,
                                    const std::bitset<NUM_TERCONN> &connect_groups )
{
    return cached_orientation( here, you, p, 1, [&]( orientation_cache_entry & out ) {
        out.connections = here.get_known_connections( p, connect_groups, {} );
    } ).connections;
}

// The scene is gathered in one pass to preserve tile and layer ordering.
// NOLINTNEXTLINE(readability-function-size)
int gather_instances( cata_tiles *tiles, const tripoint_bub_ms &center,
                      std::vector<instance_bucket> &buckets, size_t &bucket_count,
                      std::vector<decal_instance> &decals,
                      std::vector<decal_instance> &panels,
                      const view_frustum &frustum, const pick_camera &camera,
                      pick_surfaces &surfaces )
{
    map &here = get_map();
    bucket_count = 0;
    decals.clear();
    panels.clear();
    static bucket_index_map bucket_index;
    bucket_index.clear();
    auto bucket_for = [&]( const int mode, SDL_Texture * atlas ) -> decltype( auto ) {
        const bucket_key key{ mode, atlas };
        const auto it = bucket_index.find( key );
        if( it != bucket_index.end() ) {
            return ( buckets[it->second].data );
        }
        const size_t index = bucket_count++;
        bucket_index[key] = index;
        if( index < buckets.size() ) {
            instance_bucket &bucket = buckets[index];
            bucket.mode = mode;
            bucket.atlas = atlas;
            bucket.data.clear();
        } else {
            buckets.push_back( instance_bucket{ mode, atlas, {} } );
        }
        return ( buckets[index].data );
    };
    // total instances pushed (all kinds), capped at the buffer capacity
    int count = 0;
    // per-vehicle whole-shell hide verdict (TP-20): approaching ANY tile of a
    // vehicle hides the whole vehicle's shell; many tiles of the same vehicle
    // re-ask the same question every frame, so cache it per gather
    static std::unordered_map<const vehicle *, bool> veh_shell_hidden;
    veh_shell_hidden.clear();
    // camera forward on the ground plane, to stack the item highlight behind the item
    const float fwd_x = std::cos( g_yaw );
    const float fwd_y = std::sin( g_yaw );

    const int cz = center.z();
    surfaces.reset( cz );
    avatar &you = get_avatar();
    const tripoint_bub_ms upos = you.pos_bub();
    const level_cache &center_cache = here.get_cache_ref( cz );
    // update_visibility_cache refreshes exactly [lowest_vision_level, center.z];
    // visibility caches outside that range are stale (same formula as
    // map::lowest_vision_level)
    const int lowest_vis_z = std::max( std::min( cz, upos.z() - fov_3d_z_range ),
                                       -OVERMAP_DEPTH );
    // per-tile visibility, exactly when 2D draws the real tile: LOW/LIT/BRIGHT
    // are the lit levels map::get_visibility maps to CLEAR. everything else
    // draws memory or a vision-effect tile in 2D, so 3D must not show it
    const auto tile_visible = []( const level_cache & c, const tripoint_bub_ms & q ) {
        const lit_level ll = c.visibility_cache[q.x()][q.y()];
        return ll == lit_level::LOW || ll == lit_level::LIT || ll == lit_level::BRIGHT;
    };
    // per-tile light tone, the same model 2D's smooth lighting uses
    // (smooth_lighting::classify_light_cell + data/shaders/lit.frag): light is
    // 0 at the vision threshold and 1 at LIGHT_AMBIENT_LIT; brightness bottoms
    // out at shadow_shade and color drains to gray below full_color_light.
    // every instance on a tile shares this tone.
    struct tile_tone {
        float shade = 1.0f;   // brightness multiplier
        // 1 = full color, 0 = grayscale; in a night vision frame this slot
        // instead carries the tile light (0..1) the NV look dims by
        float sat = 1.0f;
    };
    const bool nv_tint = nv_tint_active();
    const auto tone_from_light = [nv_tint]( const float light ) {
        const float t = std::clamp( light / smooth_lighting::full_color_light, 0.0f, 1.0f );
        return tile_tone{
            smooth_lighting::shadow_shade +
            ( 1.0f - smooth_lighting::shadow_shade ) *light,
            nv_tint ? std::clamp( light, 0.0f, 1.0f ) : t *t *( 3.0f - 2.0f * t ) };
    };
    const visibility_variables &vis_vars = here.get_visibility_variables_cache();
    // upper levels are not refreshed by update_visibility_cache (it stops at
    // center.z), so their lit level is computed on the spot with
    // map::apparent_light_at, the same function the 2D visibility cache is
    // built from. a tile no avatar/camera cast reached and no clairvoyance can
    // light is certainly invisible; this also keeps upper levels, which the
    // cast hides behind their own floor/roof (shadowcasting floor_block),
    // nearly free.
    const auto upper_lit_at = [&]( const level_cache & c, const tripoint_bub_ms & q ) {
        if( c.seen_cache[q.x()][q.y()] <= 0.0f && c.camera_cache[q.x()][q.y()] <= 0.0f &&
            vis_vars.u_clairvoyance <= 0 && !vis_vars.clairvoyance_field ) {
            return lit_level::BLANK;
        }
        return here.apparent_light_at( q, vis_vars );
    };
    // tile light tone from its lit level, the same model 2D's smooth lighting
    // uses (smooth_lighting::classify_light_cell + data/shaders/lit.frag)
    const auto tone_for = [&]( const level_cache & c, const tripoint_bub_ms & q,
    const lit_level ll ) {
        const float apparent = smooth_lighting::needs_apparent_light( ll )
                               ? map::apparent_light_helper( c, q ).apparent_light : 0.0f;
        return tone_from_light( smooth_lighting::classify_light_cell(
                                    ll, apparent, vis_vars.vision_threshold ).light );
    };
    // sprite-less tiles (fields) fall back to the tileset's ASCII symbol, drawn
    // from the shared TTF glyph atlas and tinted with the entity color (the
    // same curses-style fallback 2D uses)
    const auto glyph_sprite = [&]( const char32_t cp, sprite_info & out ) -> bool {
        if( !g_ctx.glyph_tex )
        {
            return false;
        }
        const uint32_t c = static_cast<uint32_t>( cp );
        const int gc = ( c > 32 && c <= 126 ) ? static_cast<int>( c ) - 32 : '?' - 32;
        out = sprite_info{};
        out.atlas = g_ctx.glyph_tex;
        out.u0 = ( gc % 16 ) * g_ctx.glyph_cell_w / static_cast<float>( g_ctx.glyph_atlas_w );
        const int glyph_row = gc / 16;
        out.v0 = glyph_row * g_ctx.glyph_cell_h / static_cast<float>( g_ctx.glyph_atlas_h );
        out.u1 = out.u0 + g_ctx.glyph_cell_w / static_cast<float>( g_ctx.glyph_atlas_w );
        out.v1 = out.v0 + g_ctx.glyph_cell_h / static_cast<float>( g_ctx.glyph_atlas_h );
        out.aspect = g_ctx.glyph_cell_h > 0
                     ? static_cast<float>( g_ctx.glyph_cell_w ) / g_ctx.glyph_cell_h : 1.0f;
        return true;
    };
    // render every z-level: per-level rules (seen-only below, roof mode above,
    // open air skipped) keep the cost proportional to what actually exists
    const int zmin = -OVERMAP_DEPTH;
    const int zmax = OVERMAP_HEIGHT;

    // dollhouse cutout: a column whose view-level tile is seen, indoors and
    // walkable gets a translucent roof, so interiors show from inside. limited
    // to a radius around the player — distant interiors keep their opaque roof
    constexpr int DOLLHOUSE_RADIUS = 12;
    std::array<bool, REGION_SIZE *REGION_SIZE> dollhouse{};
    {
        const point pd( upos.x() - center.x(), upos.y() - center.y() );
        for( int dy = -REGION_RADIUS; dy <= REGION_RADIUS; ++dy ) {
            for( int dx = -REGION_RADIUS; dx <= REGION_RADIUS; ++dx ) {
                const tripoint_bub_ms p = center + tripoint( dx, dy, 0 );
                if( !here.inbounds( p ) || !tile_in_frustum( frustum, point( dx, dy ), 0.0f ) ) {
                    continue;
                }
                const point r = point( dx, dy ) - pd;
                if( r.x * r.x + r.y * r.y <= DOLLHOUSE_RADIUS * DOLLHOUSE_RADIUS &&
                    tile_visible( center_cache, p ) &&
                    !center_cache.outside_cache[p.x()][p.y()] &&
                    here.move_cost( p ) > 0 ) {
                    dollhouse[( dy + REGION_RADIUS ) * REGION_SIZE + ( dx + REGION_RADIUS )] = true;
                }
            }
        }
    }

    // ---- memory layer (2D's memory map) ------------------------------------
    // View-level tiles the avatar cannot see right now draw what it remembers
    // of them instead of the fog slab, exactly where 2D draws its memory
    // overlay. Only memorized data is read here: the live map may have changed
    // since the tile was last seen, and drawing that would leak it.
    // lookup_sprite_layers_3d supplies the cross-frame single-variant cache;
    // multi-variant remembered tiles still resolve with their position seed.
    const auto memory_lookup = [&]( const std::string & id, const TILE_CATEGORY cat,
                                    const tripoint_bub_ms & p, const int subtile,
    const int rota, const bool force ) -> sprite_lookup_3d {
        sprite_lookup_3d l;
        lookup_sprite_layers_3d( tiles, id, cat, p, subtile, rota, force, l );
        return l;
    };
    const auto push_fog_slab = [&]( const tripoint & cell, const float wz ) {
        surfaces.set( cell, pick_surface::memory_floor );
        std::vector<float> &v = bucket_for( MODE_BOX, nullptr );
        push_instance( v, static_cast<float>( cell.x ), static_cast<float>( cell.y ),
                       wz - FLOOR_THICK - 0.001f, 1.0f, 1.0f, FLOOR_THICK, sprite_info{},
                       0.02f, 0.02f, 0.028f, true, 0, false, -1.0f, false,
                       nv_tint ? 0.0f : 1.0f );
        ++count;
    };
    // draws one tile from the avatar's map memory; returns true when it drew
    // (or deliberately left open) the tile, false to fall back to the fog slab.
    // with_furniture is false above the view level: remembered floors and walls
    // read as structure there, while remembered furniture would only clutter
    // the cross-level view.
    const auto gather_memory_tile = [&]( const tripoint_bub_ms & p, const point d,
    const float wz, const bool with_furniture ) -> bool {
        const int &dx = d.x;
        const int &dy = d.y;
        const memorized_tile &mt = get_avatar().get_memorized_tile( here.get_abs( p ) );
        const std::string &mem_ter = mt.get_ter_id();
        const std::string &dec_id = mt.get_dec_id();
        if( mem_ter.empty() && dec_id.empty() )
        {
            return false;
        }
        // the one decoration slot holds furniture ("f_"), a trap ("tr_") or a
        // vehicle part ("vp_"); 3D renders furniture only, as it does live
        const bool has_furn = !dec_id.empty() && dec_id.rfind( "f_", 0 ) == 0;
        furn_str_id fid;
        if( has_furn )
        {
            fid = furn_str_id( dec_id );
        }
        const bool furn_ok = has_furn && fid.is_valid();
        const auto push_memory_furniture = [&]()
        {
            if( !furn_ok || !with_furniture || count >= MAX_DRAW_INSTANCES ) {
                return;
            }
            // 2D's memory draw feeds the stored subtile/rotation back in
            const sprite_lookup_3d fl = memory_lookup( dec_id, TILE_CATEGORY::FURNITURE, p,
                                        mt.get_dec_subtile(), mt.get_dec_rotation(), false );
            // locked/alarmed furniture whose tileset splits bg=body /
            // fg=indicator (key or alarm icon) draws both layers, as 2D does
            const bool layered = fl.bg_tex && wants_layered_face( furn_id( fid ).obj() );
            const sprite_info &fspr = layered ? fl.bg : fl.fg;
            const bool ftex = layered ? fl.bg_tex : fl.fg_tex;
            float fr = 1.0f;
            float fg = 1.0f;
            float fb = 1.0f;
            if( !ftex ) {
                terrain_color( furn_id( fid ).to_i() * 31 + 7, fr, fg, fb );
            }
            const float fw = FURN_QUAD_HEIGHT * std::clamp( fspr.aspect, 0.5f, 2.0f );
            const bool flat = flat_furniture( fid.obj() );
            if( flat ) {
                std::vector<float> &v = bucket_for( MODE_FLATQUAD_DECAL,
                                                    ftex ? fspr.atlas : nullptr );
                push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                               wz + 0.004f, 1.0f, 1.0f, 1.0f, fspr, fr, fg, fb,
                               false, fl.fg_rot4, false, -1.0f, false, 1.0f, true );
            } else {
                std::vector<float> &v = bucket_for( MODE_BILLBOARD_SNAP,
                                                    ftex ? fspr.atlas : nullptr );
                push_instance( v, dx + 0.5f, dy + 0.5f,
                               wz - FURN_QUAD_HEIGHT * fspr.base_drop,
                               fw, FURN_QUAD_HEIGHT, 1.0f, fspr, fr, fg, fb,
                               false, 0, false, -1.0f, false, 1.0f, true );
            }
            ++count;
            if( !flat && layered && fl.fg_tex && count < MAX_DRAW_INSTANCES ) {
                // the indicator rides the body's exact quad, a hair toward the
                // camera so the strict depth test never drops it
                std::vector<float> &vo = bucket_for( MODE_BILLBOARD_SNAP, fl.fg.atlas );
                push_instance( vo, dx + 0.5f - fwd_x * 0.02f, dy + 0.5f - fwd_y * 0.02f,
                               wz - FURN_QUAD_HEIGHT * fspr.base_drop,
                               fw, FURN_QUAD_HEIGHT, 1.0f, fl.fg,
                               1.0f, 1.0f, 1.0f,
                               false, 0, false, -1.0f, false, 1.0f, true );
                ++count;
            }
        };

        const ter_str_id tid( mem_ter );
        if( mem_ter.empty() || !tid.is_valid() )
        {
            // stale memory id (content removed): nothing faithful to draw
            if( furn_ok && with_furniture ) {
                push_fog_slab( tripoint( dx, dy, p.z() ), wz );
                push_memory_furniture();
                return true;
            }
            return !furn_ok;
        }
        const ter_t &t = *tid;
        const int ter_int = ter_id( tid ).to_i();
        if( t.has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) )
        {
            // remembered open air stays open, as the live path draws it; a
            // remembered decoration still gets its dark backdrop
            if( !dec_id.empty() && with_furniture ) {
                push_fog_slab( tripoint( dx, dy, p.z() ), wz );
                push_memory_furniture();
            }
            return true;
        }

        const bool is_tree = t.has_flag( "TREE" );
        const bool is_shrub = t.has_flag( "SHRUB" );
        // doorways (open doors, empty frames) render exactly like closed
        // panels: the fg sprite stands on a thin slab over the bg (or t_floor
        // fallback) ground, and the inherited lintel caps the wall line
        const bool is_opening = wall_opening( t );
        const bool is_panel = door_or_window( t ) || is_opening;
        const bool is_empty_frame = is_panel && empty_frame_terrain( t );
        const bool is_fence = !is_panel && t.has_flag( "THIN_OBSTACLE" );
        const bool is_flat_utility = is_fence && flat_utility_terrain( t, p.z() );
        const bool is_upright_equipment = upright_equipment_terrain( t );
        const bool is_wall = !is_tree && !is_shrub && !is_panel && !is_fence &&
                             !is_upright_equipment && t.movecost == 0;
        const bool plain_floor = !is_tree && !is_shrub && !is_panel && !is_fence &&
                                 !is_wall && !is_upright_equipment;
        // an edge segment's stored rotation is 0 for a N-S wall line and 1 for
        // an E-W one (cata_tiles::get_rotation_and_subtile)
        const bool ew_line = ( ( mt.get_ter_rotation() % 2 ) + 2 ) % 2 == 1;

        int lookup_subtile = -1;
        int lookup_rota = 0;
        bool force_rota = false;
        if( plain_floor || is_tree || is_shrub || is_flat_utility || is_upright_equipment )
        {
            // 2D's memory draw uses the stored subtile and rotation as-is
            lookup_subtile = mt.get_ter_subtile();
            lookup_rota = mt.get_ter_rotation();
        } else
        {
            lookup_subtile = SUBTILE_EDGE;
            lookup_rota = ( is_wall || is_fence ) ? 1 : ( ew_line ? 1 : 0 );
            force_rota = true;
        }
        const sprite_lookup_3d tl = memory_lookup( mem_ter, TILE_CATEGORY::TERRAIN, p,
                                    lookup_subtile, lookup_rota, force_rota );
        // a subtile without its own bg falls back to the base tile's bg
        sprite_info bspr = tl.bg;
        bool btex = tl.bg_tex;
        if( !btex && lookup_subtile != -1 )
        {
            const sprite_lookup_3d base_l = memory_lookup( mem_ter, TILE_CATEGORY::TERRAIN, p,
                                            -1, lookup_rota, false );
            if( base_l.bg_tex ) {
                bspr = base_l.bg;
                btex = true;
            }
        }
        // locked/alarmed doors and windows whose tileset splits the face into
        // layers: bg is the board/glass and fg only an indicator (key / alarm
        // icon); both layers stand on the panel and the floor falls back to
        // t_floor
        const bool is_window_panel = t.has_flag( "WINDOW" ) && !t.has_flag( "DOOR" );
        const bool layered_face = is_panel && !is_empty_frame && btex && !is_opening &&
                                  wants_layered_face( t );
        // diagnostic: remembered door-family classification trace, once per id
        if( is_panel || t.has_flag( "LOCKED" ) )
        {
            static std::unordered_set<std::string> logged_mem_doors;
            if( logged_mem_doors.size() < 300 && logged_mem_doors.insert( mem_ter ).second ) {
                write_status( std::string( "memdoor: " ) + mem_ter +
                              " panel=" + std::to_string( is_panel ? 1 : 0 ) +
                              " opening=" + std::to_string( wall_opening( t ) ? 1 : 0 ) +
                              " layered=" + std::to_string( layered_face ? 1 : 0 ) +
                              " wall=" + std::to_string( is_wall ? 1 : 0 ) +
                              " strlock=" + std::to_string( t.has_flag( "LOCKED" ) ? 1 : 0 ) +
                              " ftex=" + std::to_string( tl.fg_tex ? 1 : 0 ) +
                              " bg=" + std::to_string( btex ? 1 : 0 ) +
                              " ew=" + std::to_string( ew_line ? 1 : 0 ) );
            }
        }
        // doors and windows stand on a floor the tileset doesn't supply
        static const std::string t_floor_id = "t_floor";
        sprite_info dfspr;
        bool dtex = false;
        if( is_panel && ( !btex || layered_face ) )
        {
            const sprite_lookup_3d dl = memory_lookup( t_floor_id, TILE_CATEGORY::TERRAIN, p,
                                        -1, 0, false );
            if( dl.fg_tex ) {
                dfspr = dl.fg;
                dtex = true;
            }
        }
        const sprite_info &ground_spr = ( btex && !layered_face ) ? bspr
                                        : ( dtex ? dfspr : tl.fg );
        const bool ground_tex = ( btex && !layered_face ) || dtex ||
                                ( tl.fg_tex && plain_floor );
        const int ground_rot4 = ( !btex && !dtex ) ? tl.fg_rot4 : 0;
        float gr = 1.0f;
        float gg = 1.0f;
        float gb = 1.0f;
        if( !ground_tex )
        {
            terrain_color( ter_int, gr, gg, gb );
        }
        if( plain_floor && !btex && !dtex && ground_spr.has_transparency )
        {
            surfaces.set( tripoint( d, p.z() ), pick_surface::memory_floor );
            std::vector<float> &v = bucket_for( MODE_FLATQUAD,
                                                ground_tex ? ground_spr.atlas : nullptr );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                           wz - 0.001f, 1.0f, 1.0f, 1.0f, ground_spr, gr, gg, gb,
                           false, ground_rot4, false, -1.0f, false, 1.0f, true );
            ++count;
        } else if( !is_empty_frame && ( !is_flat_utility || ground_tex ) )
        {
            surfaces.set( tripoint( d, p.z() ), pick_surface::memory_floor );
            // Horizontal objects without a bg must not acquire an unrelated
            // hash-colored floor box beneath their textured top and silhouette.
            sprite_info gspr = ground_spr;
            gspr.u0 = ground_spr.gu0;
            gspr.v0 = ground_spr.gv0;
            gspr.u1 = ground_spr.gu1;
            gspr.v1 = ground_spr.gv1;
            std::vector<float> &v = bucket_for( MODE_BOX, ground_tex ? gspr.atlas : nullptr );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                           wz - FLOOR_THICK - 0.001f, 1.0f, 1.0f, FLOOR_THICK, gspr,
                           gr, gg, gb, true, ground_rot4, false, -1.0f, false, 1.0f, true );
            ++count;
        }

        const sprite_info &fspr = tl.fg;
        const bool ftex = tl.fg_tex;
        float or_ = 1.0f;
        float og = 1.0f;
        float ob = 1.0f;
        if( !ftex )
        {
            terrain_color( ter_int, or_, og, ob );
        }
        // the wall sprite clamping a panel or backing a doorway's lintel:
        // consecutive doors/windows/openings are one run, scanned along the
        // wall line to the first wall at either end
        const auto mem_clamp_wall = [&]( sprite_info & out )
        {
            const auto mem_ter_at = [&]( const tripoint_bub_ms & q ) -> const ter_t * {
                const std::string &nid =
                get_avatar().get_memorized_tile( here.get_abs( q ) ).get_ter_id();
                if( nid.empty() )
                {
                    return nullptr;
                }
                const ter_str_id ntid( nid );
                return ntid.is_valid() ? & *ntid : nullptr;
            };
            const point line_step = ew_line ? point::east : point::north;
            for( const int dir : {
                     1, -1
                 } ) {
                tripoint_bub_ms wall_pos;
                const ter_t *wt = panel_run_end( p, line_step * dir, mem_ter_at, wall_pos );
                if( wt == nullptr ) {
                    continue;
                }
                const sprite_lookup_3d nl = memory_lookup( wt->id.str(),
                                            TILE_CATEGORY::TERRAIN, wall_pos, SUBTILE_EDGE, 1, true );
                if( nl.fg_tex ) {
                    out = nl.fg;
                    return true;
                }
            }
            return false;
        };
        if( is_tree )
        {
            std::vector<float> &v = bucket_for( MODE_XQUAD, ftex ? fspr.atlas : nullptr );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                           wz - TREE_HEIGHT * fspr.base_drop,
                           1.0f, 1.0f, TREE_HEIGHT, fspr, or_, og, ob,
                           false, 0, false, -1.0f, false, 1.0f, true );
            ++count;
        } else if( is_shrub )
        {
            std::vector<float> &v = bucket_for( MODE_XQUAD, ftex ? fspr.atlas : nullptr );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                           wz - SHRUB_HEIGHT * fspr.base_drop,
                           0.9f, 0.9f, SHRUB_HEIGHT, fspr, or_, og, ob,
                           false, 0, false, -1.0f, false, 1.0f, true );
            ++count;
        } else if( is_panel )
        {
            const float px = ew_line ? static_cast<float>( dx )
                             : dx + 0.5f - PANEL_THICK * 0.5f;
            const float py = ew_line ? dy + 0.5f - PANEL_THICK * 0.5f
                             : static_cast<float>( dy );
            const float psx = ew_line ? 1.0f : PANEL_THICK;
            const float psy = ew_line ? PANEL_THICK : 1.0f;
            // a layered locked door stands both layers up: bg is the board,
            // fg (the key/lock indicator) rides on top of it
            const sprite_info &facespr = layered_face ? bspr : fspr;
            const bool factex = layered_face || ftex;
            const float pr = layered_face ? 1.0f : or_;
            const float pg = layered_face ? 1.0f : og;
            const float pb = layered_face ? 1.0f : ob;
            std::vector<float> &v = bucket_for( MODE_BOX, factex ? facespr.atlas : nullptr );
            // the clamping voxels take a remembered wall's sprite; without one
            // the sill/lintel are left out entirely (no gray placeholder)
            sprite_info wspr;
            const bool wok = mem_clamp_wall( wspr );
            if( is_window_panel ) {
                constexpr float SILL_H = 0.85f;
                if( !is_empty_frame ) {
                    push_instance( v, px, py, wz + SILL_H, psx, psy, SILL_H, facespr,
                                   pr, pg, pb, false, 0, false, -1.0f, false, 1.0f, true );
                    ++count;
                }
                if( layered_face && ftex && count < MAX_DRAW_INSTANCES ) {
                    // the indicator layer rides a hair proud of the glass so
                    // it never z-fights the face it composites over; grow
                    // symmetrically about the centre and shift back half the
                    // growth so it reads from either side
                    std::vector<float> &vo = bucket_for( MODE_BOX, fspr.atlas );
                    const float grow = 0.01f; // 5 mm on each face
                    const float osx = ew_line ? psx : psx + grow;
                    const float osy = ew_line ? psy + grow : psy;
                    const float opx = ew_line ? px : px - grow * 0.5f;
                    const float opy = ew_line ? py - grow * 0.5f : py;
                    push_instance( vo, opx, opy, wz + SILL_H, osx, osy, SILL_H, fspr,
                                   1.0f, 1.0f, 1.0f,
                                   false, 0, false, -1.0f, false, 1.0f, true );
                    ++count;
                }
                if( wok && count + 2 <= MAX_DRAW_INSTANCES ) {
                    // memory instances bypass the light tone, so the inherited
                    // wall sprite is sampled at full color
                    std::vector<float> &vb = bucket_for( MODE_BOX, wspr.atlas );
                    const sprite_info sill = wall_slice( wspr, 0.0f, SILL_H );
                    const sprite_info lintel = wall_slice( wspr, SILL_H * 2.0f, WALL_HEIGHT );
                    push_instance( vb, static_cast<float>( dx ), static_cast<float>( dy ),
                                   wz, 1.0f, 1.0f, SILL_H, sill,
                                   1.0f, 1.0f, 1.0f,
                                   false, 0, false, -1.0f, false, 1.0f, true );
                    push_instance( vb, static_cast<float>( dx ), static_cast<float>( dy ),
                                   wz + SILL_H * 2.0f, 1.0f, 1.0f, WALL_HEIGHT - SILL_H * 2.0f,
                                   lintel, 1.0f, 1.0f, 1.0f,
                                   false, 0, false, -1.0f, false, 1.0f, true );
                    count += 2;
                }
            } else {
                if( !is_empty_frame ) {
                    push_instance( v, px, py, wz, psx, psy, PANEL_HEIGHT, facespr,
                                   pr, pg, pb, false, 0, false, -1.0f, false, 1.0f, true );
                    ++count;
                }
                if( layered_face && ftex && count < MAX_DRAW_INSTANCES ) {
                    // the indicator layer rides a hair proud of the board so it
                    // never z-fights the face it composites over. the box grows
                    // symmetrically about its centre: push_instance anchors at
                    // the min corner, so shift back by half the growth to stay
                    // proud on BOTH faces (the key must read from either side)
                    std::vector<float> &vo = bucket_for( MODE_BOX, fspr.atlas );
                    const float grow = 0.01f; // 5 mm on each face
                    const float osx = ew_line ? psx : psx + grow;
                    const float osy = ew_line ? psy + grow : psy;
                    const float opx = ew_line ? px : px - grow * 0.5f;
                    const float opy = ew_line ? py - grow * 0.5f : py;
                    push_instance( vo, opx, opy, wz, osx, osy, PANEL_HEIGHT, fspr,
                                   1.0f, 1.0f, 1.0f, false, 0, false, -1.0f, false, 1.0f, true );
                    ++count;
                }
                if( wok && count + 1 <= MAX_DRAW_INSTANCES ) {
                    std::vector<float> &vb = bucket_for( MODE_BOX, wspr.atlas );
                    const sprite_info lintel = wall_slice( wspr, PANEL_HEIGHT, WALL_HEIGHT );
                    push_instance( vb, static_cast<float>( dx ), static_cast<float>( dy ),
                                   wz + PANEL_HEIGHT, 1.0f, 1.0f, WALL_HEIGHT - PANEL_HEIGHT,
                                   lintel, 1.0f, 1.0f, 1.0f,
                                   false, 0, false, -1.0f, false, 1.0f, true );
                    ++count;
                }
            }
        } else if( is_upright_equipment )
        {
            std::vector<float> &v = bucket_for( MODE_BILLBOARD_SNAP, ftex ? fspr.atlas : nullptr );
            push_instance( v, dx + 0.5f, dy + 0.5f, wz - FENCE_HEIGHT * fspr.base_drop,
                           1.0f, FENCE_HEIGHT, 1.0f, fspr, or_, og, ob,
                           false, 0, false, -1.0f, false, 1.0f, true );
            ++count;
        } else if( is_flat_utility )
        {
            std::vector<float> &top = bucket_for( MODE_FLATQUAD, ftex ? fspr.atlas : nullptr );
            std::vector<float> &sides = bucket_for( MODE_LINEQUAD, ftex ? fspr.atlas : nullptr );
            count += push_utility_shell( top, sides, dx, dy, wz, fspr, or_, og, ob, tl.fg_rot4,
                                         false, 1.0f, true );
        } else if( is_fence )
        {
            const float fh = t.has_flag( "TINY" ) ? 0.35f : FENCE_HEIGHT;
            std::vector<float> &v = bucket_for( MODE_LINEQUAD, ftex ? fspr.atlas : nullptr );
            // the stored subtile/rotation encode the fence run; a memory tile
            // has no neighbors to consult
            const uint8_t conn = memory_conn_mask( mt.get_ter_subtile(),
                                                   mt.get_ter_rotation() );
            const bool cn = ( conn & 8 ) != 0;
            const bool cs = ( conn & 1 ) != 0;
            const bool ce = ( conn & 2 ) != 0;
            const bool cw = ( conn & 4 ) != 0;
            const bool straight = ( cn && cs && !ce && !cw ) ||
                                  ( ce && cw && !cn && !cs );
            if( straight || ( !cn && !cs && !ce && !cw ) ) {
                const bool run_ns = ( cn && cs ) ? true : ( ce && cw ) ? false : !ew_line;
                push_instance( v, dx + 0.5f, dy + 0.5f, wz, 1.0f, fh, 1.0f,
                               fspr, or_, og, ob, false, 0, false, run_ns ? 1.0f : 0.0f,
                               false, 1.0f, true );
                ++count;
            } else {
                sprite_info hspr = fspr;
                hspr.u1 = fspr.u0 + ( fspr.u1 - fspr.u0 ) * 0.5f;
                const float fcx = dx + 0.5f;
                const float fcy = dy + 0.5f;
                if( cn ) {
                    push_instance( v, fcx, fcy - 0.25f, wz, 0.5f, fh, 1.0f, hspr,
                                   or_, og, ob, false, 0, false, 1.0f, false, 1.0f, true );
                    ++count;
                }
                if( cs ) {
                    push_instance( v, fcx, fcy + 0.25f, wz, 0.5f, fh, 1.0f, hspr,
                                   or_, og, ob, false, 0, false, 1.0f, false, 1.0f, true );
                    ++count;
                }
                if( ce ) {
                    push_instance( v, fcx + 0.25f, fcy, wz, 0.5f, fh, 1.0f, hspr,
                                   or_, og, ob, false, 0, false, 0.0f, false, 1.0f, true );
                    ++count;
                }
                if( cw ) {
                    push_instance( v, fcx - 0.25f, fcy, wz, 0.5f, fh, 1.0f, hspr,
                                   or_, og, ob, false, 0, false, 0.0f, false, 1.0f, true );
                    ++count;
                }
            }
        } else if( is_wall )
        {
            surfaces.set( tripoint( d, p.z() ), pick_surface::memory_wall );
            std::vector<float> &v = bucket_for( MODE_BOX, ftex ? fspr.atlas : nullptr );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ), wz,
                           1.0f, 1.0f, WALL_HEIGHT, fspr, or_, og, ob,
                           false, 0, false, -1.0f, false, 1.0f, true );
            ++count;
        }

        // plain floor with a bg and an fg composites them like live/2D
        if( plain_floor && ftex && btex && count < MAX_DRAW_INSTANCES )
        {
            std::vector<float> &v = bucket_for( MODE_FLATQUAD, fspr.atlas );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                           wz + 0.004f, 1.0f, 1.0f, 1.0f, fspr, or_, og, ob,
                           false, 0, false, -1.0f, false, 1.0f, true );
            ++count;
        }

        push_memory_furniture();
        return true;
    };

    for( int zlev = zmin; zlev <= zmax; ++zlev ) {
        const int dz = zlev - cz;
        const float wz = dz * LEVEL_HEIGHT;
        const level_cache &cache = here.get_cache_ref( zlev );
        const region_cull_mask cull_mask = build_region_cull_mask( here, you, center, zlev,
                                           lowest_vis_z, vis_vars, frustum );
        g_profile.skipped_submaps += cull_mask.skipped_submaps;
        if( cull_mask.any_submaps && !cull_mask.any_active ) {
            ++g_profile.skipped_levels;
            continue;
        }

        for( int dy = -VIEW_RADIUS; dy <= VIEW_RADIUS; ++dy ) {
            for( int dx = -VIEW_RADIUS; dx <= VIEW_RADIUS; ++dx ) {
                if( count >= MAX_DRAW_INSTANCES ) {
                    return count;
                }
                // two-tier gather: only the near region (±REGION_RADIUS) renders
                // other z-levels; the far ring draws the view level alone
                if( dz != 0 &&
                    ( std::abs( dx ) > REGION_RADIUS || std::abs( dy ) > REGION_RADIUS ) ) {
                    continue;
                }
                const tripoint_bub_ms p = center + tripoint( dx, dy, dz );
                if( !here.inbounds( p ) ) {
                    continue;
                }
                const uint8_t cull_state = cull_mask.state[p.x() / SEEX + p.y() / SEEY * MAPSIZE];
                if( cull_state == REGION_FRUSTUM_SKIP ) {
                    ++g_profile.frustum_tiles;
                    continue;
                }
                if( cull_state == REGION_COARSE_SKIP ) {
                    ++g_profile.coarse_tiles;
                    continue;
                }
                if( !tile_in_frustum( frustum, point( dx, dy ), wz ) ) {
                    ++g_profile.frustum_tiles;
                    continue;
                }
                ++g_profile.main_tiles;
                // per-tile lit level, the same one 2D draws from: fresh
                // visibility_cache for the view level and below within the
                // refreshed range; upper levels have no fresh cache
                // (update_visibility_cache stops at center.z), so it is
                // computed with map::apparent_light_at. levels below the
                // refreshed range have stale caches: they count as invisible
                // but still draw their map memory.
                const bool stale_lower = dz < 0 && zlev < lowest_vis_z;
                lit_level ll = lit_level::BLANK;
                if( !stale_lower ) {
                    ll = dz > 0 ? upper_lit_at( cache, p )
                         : cache.visibility_cache[p.x()][p.y()];
                }
                const bool visible = ll == lit_level::LOW || ll == lit_level::LIT ||
                                     ll == lit_level::BRIGHT;
                // direct line of sight to an upper tile only decides whether
                // its detail is drawn (roof mode) when a camera or clairvoyance
                // made it visible
                const bool seen = cache.seen_cache[p.x()][p.y()] > 0.0f;
                // do not reveal what the player cannot see (visual = mechanics):
                // an invisible tile draws the avatar's memory of it, on every
                // level, so previously explored floors stay readable across
                // z-levels. the view level keeps a featureless near-black
                // ground slab (fog of war) where nothing was ever seen; other
                // levels draw memory only, nothing where there is none.
                if( !visible ) {
                    if( dz == 0 ) {
                        if( !gather_memory_tile( p, point( dx, dy ), wz, true ) ) {
                            push_fog_slab( tripoint( dx, dy, p.z() ), wz );
                        }
                    } else if( !( dz > 0 &&
                                  dollhouse[( dy + REGION_RADIUS ) * REGION_SIZE + ( dx + REGION_RADIUS )] ) ) {
                        // the dollhouse cutout stays clear: remembered walls on
                        // the floors above an interior must not block it.
                        // upper floors keep their remembered structure only:
                        // remembered furniture there is deliberately not drawn
                        gather_memory_tile( p, point( dx, dy ), wz, dz < 0 );
                    }
                    continue;
                }
                // levels above an indoor column the player can see into are drawn
                // translucent (ghost) instead of being cut out entirely, so the
                // roof stays perceptible from inside
                const bool ghost = dz > 0 &&
                                   dollhouse[( dy + REGION_RADIUS ) * REGION_SIZE + ( dx + REGION_RADIUS )];
                // roof mode: an upper tile made visible by a camera or
                // clairvoyance but not by direct line of sight draws only its
                // floor + walls (the building outline), no furniture/items
                const bool roof_unseen = dz > 0 && !seen;
                const maptile mt = here.maptile_at( p );
                const ter_id t = mt.get_ter();
                const furn_id f = mt.get_furn();
                if( t == t_null ) {
                    continue;
                }
                // open air / holes: nothing stands here on this level (water is
                // NO_FLOOR_WATER, not NO_FLOOR, and still draws). furniture can
                // bridge a gap, so its tile is not open air
                if( t->has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) &&
                    f == furn_str_id::NULL_ID() ) {
                    continue;
                }
                // the whole tile shares one light tone, from the same light
                // level classification 2D uses: bright tiles stay full color,
                // dim ones darken and drain toward grayscale
                const tile_tone tone = tone_for( cache, p, ll );

                const bool is_tree = t->has_flag( "TREE" );
                const bool is_shrub = t->has_flag( "SHRUB" );
                // door/window classification: closed doors/windows (DOOR/WINDOW
                // flags or an "open" transform, plus the locked/broken families)
                // and passable doorways (open doors, empty frames) all draw as
                // standing slabs on the bg/t_floor ground
                const bool is_opening = wall_opening( *t );
                const bool is_panel = door_or_window( *t ) || is_opening;
                const bool is_empty_frame = is_panel && empty_frame_terrain( *t );
                const bool is_fence = !is_panel && t->has_flag( "THIN_OBSTACLE" );
                const bool is_flat_utility = is_fence && flat_utility_terrain( *t, p.z() );
                const bool is_upright_equipment = upright_equipment_terrain( *t );
                const bool is_wall = !is_tree && !is_shrub && !is_panel && !is_fence &&
                                     !is_upright_equipment && t->movecost == 0;
                // wall-line connections orient door/window panels and fence slabs
                // (bit order S=1, E=2, W=4, N=8)
                const uint8_t wall_conn = ( is_panel || ( is_fence && !is_flat_utility ) )
                                          ? terrain_connections_cached( here, you, p, t->connect_to_groups ) : 0;
                const bool ew_line = ( wall_conn & 0x06 ) != 0; // true: the line runs E-W

                // terrain sprite: one faithful call mirrors 2D's selection for
                // this tile — looks_like/season resolution, multitile subtile
                // re-resolution on the RESOLVED id, the rotates gate, the
                // variant seed and the rotation/variant rule. Every plain
                // floor gets the true connection subtile (connect groups, else
                // same-id neighborhood, exactly as 2D's draw_terrain per tile);
                // walls, ordinary fences and panels keep the straight "edge" middle
                // segment since they are drawn as vertical faces; flat utility runs
                // instead use their true top-down connection shape
                const bool plain_floor = !is_tree && !is_shrub && !is_panel && !is_fence &&
                                         !is_wall && !is_upright_equipment;
                const bool shaped = plain_floor || is_flat_utility || is_upright_equipment;
                int rota = 0;
                int subtile = 0;
                if( tiles && shaped ) {
                    terrain_rota_subtile_cached( tiles, here, you, p, rota, subtile );
                } else if( is_wall || ( is_fence && !is_flat_utility ) || is_panel ) {
                    subtile = SUBTILE_EDGE;
                }
                const bool force_rota = is_wall || ( is_fence && !is_flat_utility ) || is_panel;
                const int lookup_subtile = shaped ? subtile : ( force_rota ? SUBTILE_EDGE : -1 );
                const int lookup_rota = shaped ? rota
                                        : ( is_fence || is_wall ) ? 1
                                        : ( is_panel ? ( ew_line ? 1 : 0 ) : 0 );
                sprite_lookup_3d tspr;
                lookup_sprite_layers_3d( tiles, t->id.str(), TILE_CATEGORY::TERRAIN, p,
                                         lookup_subtile, lookup_rota, force_rota, tspr );
                const sprite_info fspr = tspr.fg;
                const bool ftex = tspr.fg_tex;
                const int frot4 = tspr.fg_rot4;
                // ground layer: the tileset's bg sprite when defined (trees, fences
                // sit on grass in 2D); the fg sprite only for plain floors, so
                // doors/windows/fences never leave a top-down sticker on the ground.
                // a subtile without its own bg falls back to the base tile's bg
                sprite_info bspr = tspr.bg;
                bool btex = tspr.bg_tex;
                if( !btex && lookup_subtile != -1 ) {
                    sprite_lookup_3d base_l;
                    lookup_sprite_layers_3d( tiles, t->id.str(), TILE_CATEGORY::TERRAIN, p,
                                             -1, lookup_rota, false, base_l );
                    if( base_l.bg_tex ) {
                        bspr = base_l.bg;
                        btex = true;
                    }
                }
                // locked/alarmed doors and windows whose tileset splits the
                // face into layers: bg is the board/glass and fg only an
                // indicator (key / alarm icon); both layers stand on the
                // panel, floor falls back to t_floor
                const bool is_window_panel = t->has_flag( "WINDOW" ) &&
                                             !t->has_flag( "DOOR" );
                const bool layered_face = is_panel && !is_empty_frame && btex && !is_opening &&
                                          wants_layered_face( *t );
                // diagnostic: door-family classification trace, once per
                // terrain id (strlock = raw flag string, doorenum = bitflag),
                // so a missing slab can be traced from render3d_status.txt
                if( door_or_window( *t ) || wall_opening( *t ) || t->has_flag( "LOCKED" ) ) {
                    static std::unordered_set<std::string> logged_doors;
                    if( logged_doors.size() < 300 && logged_doors.insert( t->id.str() ).second ) {
                        write_status( std::string( "door: " ) + t->id.str() +
                                      " panel=" + std::to_string( is_panel ? 1 : 0 ) +
                                      " opening=" + std::to_string( wall_opening( *t ) ? 1 : 0 ) +
                                      " layered=" + std::to_string( layered_face ? 1 : 0 ) +
                                      " wall=" + std::to_string( is_wall ? 1 : 0 ) +
                                      " strlock=" + std::to_string( t->has_flag( "LOCKED" ) ? 1 : 0 ) +
                                      " doorenum=" + std::to_string(
                                          t->has_flag( ter_furn_flag::TFLAG_DOOR ) ? 1 : 0 ) +
                                      " ftex=" + std::to_string( ftex ? 1 : 0 ) +
                                      " fg=" + std::to_string( tspr.fg_count ) +
                                      " bg=" + std::to_string( btex ? 1 : 0 ) +
                                      " ew=" + std::to_string( ew_line ? 1 : 0 ) +
                                      " sub=" + std::to_string( lookup_subtile ) +
                                      " rota=" + std::to_string( lookup_rota ) );
                    }
                }
                // diagnostic: record the resolver's pick for each distinct
                // (terrain, subtile, rota) so a wrong corner can be traced from
                // render3d_status.txt instead of guessed at
                if( shaped && tspr.multitile && subtile >= 0 &&
                    subtile < static_cast<int>( multitile_keys.size() ) ) {
                    static std::unordered_set<uint64_t> logged_shapes;
                    static int shape_log_count = 0;
                    const uint64_t shape_key =
                        ( static_cast<uint64_t>( static_cast<uint32_t>( t.to_i() ) ) << 16 ) |
                        ( static_cast<uint64_t>( subtile ) << 8 ) |
                        static_cast<uint64_t>( rota & 0xFF );
                    if( shape_log_count < 400 && logged_shapes.insert( shape_key ).second ) {
                        ++shape_log_count;
                        write_status( std::string( "shape: " ) + t->id.str() +
                                      " sub=" + multitile_keys[subtile] +
                                      " rota=" + std::to_string( rota ) +
                                      " -> " + tspr.resolved_id +
                                      " list=" + std::to_string( tspr.fg_count ) +
                                      " pick=" + std::to_string( tspr.fg_index ) +
                                      " rot4=" + std::to_string( tspr.fg_rot4 ) +
                                      " bg=" + ( tspr.bg_tex ? "yes" : "no" ) );
                    }
                }
                // doors and windows stand on a floor the tileset doesn't supply:
                // fall back to the generic wood floor so the doorway isn't a hole
                sprite_info dfspr;
                const bool dtex = is_panel && ( !btex || layered_face ) &&
                                  lookup_sprite( tiles, "t_floor", TILE_CATEGORY::TERRAIN, p, dfspr );
                const sprite_info &ground_spr = ( btex && !layered_face ) ? bspr
                                                : ( dtex ? dfspr : fspr );
                const bool ground_tex = ( btex && !layered_face ) || dtex ||
                                        ( ftex && plain_floor );

                // untextured fallback: hash color; textured: white, the atlas supplies the color
                float gr = tone.shade;
                float gg = tone.shade;
                float gb = tone.shade;
                if( !ground_tex ) {
                    terrain_color( t.to_i(), gr, gg, gb );
                    gr *= tone.shade;
                    gg *= tone.shade;
                    gb *= tone.shade;
                }
                float or_ = tone.shade;
                float og = tone.shade;
                float ob = tone.shade;
                if( !ftex ) {
                    terrain_color( t.to_i(), or_, og, ob );
                    or_ *= tone.shade;
                    og *= tone.shade;
                    ob *= tone.shade;
                }

                // every tile gets a floor slab (slightly below the level base so
                // coplanar box bottoms never z-fight it); no alpha cutout on the
                // ground layer, and sample the sprite's opaque bounds so oversized
                // sprites with transparent padding still fill the tile.
                // exception: shaped sprites with real holes (connection corners and
                // edges, e.g. roof corner trim) sample the FULL sprite with alpha
                // cutout, so the transparent regions show what is below instead of
                // rendering black.
                // upper levels: no sprite means nothing real to stand on (tree
                // canopies are spriteless terrain) — skip instead of painting a
                // hash-colored floor in the sky. Horizontal utilities likewise
                // get no hash-colored base when their tile has no real bg.
                if( !is_empty_frame && ( ( dz <= 0 && !is_flat_utility ) || ground_tex ) ) {
                    if( !ghost ) {
                        surfaces.set( tripoint( dx, dy, zlev ), pick_surface::floor );
                    }
                    // the base-id / wood-floor fallbacks have no connection
                    // rotation: only a shaped fg sprite carries one
                    const int ground_rot4 = ( !btex && !dtex ) ? frot4 : 0;
                    if( plain_floor && !btex && !dtex && ground_spr.has_transparency ) {
                        // transparent floor sprite with no bg (roof corner trim):
                        // a flat cutout quad — a box's side faces would sample the
                        // sprite's transparent rows and leave dark seams
                        std::vector<float> &v = bucket_for( MODE_FLATQUAD,
                                                            ground_tex ? ground_spr.atlas : nullptr );
                        push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                                       wz - 0.001f, 1.0f, 1.0f, 1.0f, ground_spr,
                                       gr, gg, gb, false, ground_rot4, false, -1.0f, ghost,
                                       tone.sat );
                        ++count;
                    } else {
                        sprite_info gspr = ground_spr;
                        gspr.u0 = ground_spr.gu0;
                        gspr.v0 = ground_spr.gv0;
                        gspr.u1 = ground_spr.gu1;
                        gspr.v1 = ground_spr.gv1;
                        std::vector<float> &v = bucket_for( MODE_BOX, ground_tex ? gspr.atlas : nullptr );
                        push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                                       wz - FLOOR_THICK - 0.001f, 1.0f, 1.0f, FLOOR_THICK, gspr,
                                       gr, gg, gb, true, ground_rot4, false, -1.0f, ghost,
                                       tone.sat );
                        ++count;
                    }
                }

                // levels above an indoor column near the player show ONLY their
                // (translucent) floor slab: drawing the walls/furniture up there
                // too would read as seeing the upper story from inside. Horizontal
                // utilities are part of that roof surface and must not be cut out.
                if( ghost ) {
                    if( is_flat_utility ) {
                        std::vector<float> &top = bucket_for( MODE_FLATQUAD, ftex ? fspr.atlas : nullptr );
                        std::vector<float> &sides = bucket_for( MODE_LINEQUAD, ftex ? fspr.atlas : nullptr );
                        count += push_utility_shell( top, sides, dx, dy, wz, fspr, or_, og, ob, frot4,
                                                     ghost, tone.sat, false );
                    }
                    continue;
                }

                // every plain floor with both a bg and an fg composites them like
                // 2D (grass under road edges, shores under water, turf under grass
                // tufts): the box above carries the bg; add the fg back as a flat
                // cutout quad so the transparent parts show the bg through. flat —
                // a box's side faces would sample transparent sprite rows and
                // leave dark seams along every tile edge
                if( plain_floor && ftex && btex && !roof_unseen &&
                    count < MAX_DRAW_INSTANCES ) {
                    std::vector<float> &v = bucket_for( MODE_FLATQUAD, fspr.atlas );
                    push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                                   wz + 0.004f, 1.0f, 1.0f, 1.0f, fspr, or_, og, ob,
                                   false, 0, false, -1.0f, ghost, tone.sat );
                    ++count;
                }

                // the wall sprite clamping a door/window panel or backing a
                // doorway's lintel: consecutive doors/windows/openings are one
                // run, scanned along the wall line to the first wall at either end
                const auto live_clamp_wall = [&]( sprite_info & out ) {
                    const auto live_ter_at = [&]( const tripoint_bub_ms & q ) -> const ter_t * {
                        const ter_id nt = here.ter( q );
                        return nt ? & *nt : nullptr;
                    };
                    const point line_step = ew_line ? point::east : point::north;
                    for( const int dir : {
                             1, -1
                         } ) {
                        tripoint_bub_ms wall_pos;
                        const ter_t *wt = panel_run_end( p, line_step * dir, live_ter_at, wall_pos );
                        if( wt == nullptr ) {
                            continue;
                        }
                        sprite_lookup_3d nl;
                        lookup_sprite_layers_3d( tiles, wt->id.str(), TILE_CATEGORY::TERRAIN,
                                                 wall_pos, SUBTILE_EDGE, 1, true, nl );
                        if( nl.fg_tex ) {
                            out = nl.fg;
                            return true;
                        }
                    }
                    return false;
                };

                // object layer on top of the ground; roof mode draws only the
                // building outline (walls/panels/fences), no trees or shrubs
                if( is_tree && !roof_unseen ) {
                    // cutout crossed quads; the sprite's transparent margins read as foliage.
                    // drop by the sprite's transparent bottom band so the trunk touches ground
                    std::vector<float> &v = bucket_for( MODE_XQUAD, ftex ? fspr.atlas : nullptr );
                    push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                                   wz - TREE_HEIGHT * fspr.base_drop,
                                   1.0f, 1.0f, TREE_HEIGHT, fspr, or_, og, ob,
                                   false, 0, false, -1.0f, ghost, tone.sat );
                    ++count;
                } else if( is_shrub && !roof_unseen ) {
                    // same crossed quads, but shrub-sized
                    std::vector<float> &v = bucket_for( MODE_XQUAD, ftex ? fspr.atlas : nullptr );
                    push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                                   wz - SHRUB_HEIGHT * fspr.base_drop,
                                   0.9f, 0.9f, SHRUB_HEIGHT, fspr, or_, og, ob,
                                   false, 0, false, -1.0f, ghost, tone.sat );
                    ++count;
                } else if( is_panel ) {
                    // doors and windows are planar: a thin cutout panel standing in
                    // the wall line, oriented along the wall (walls E/W of it mean
                    // the wall line runs E-W, so the panel spans x and is thin in y)
                    const float px = ew_line ? static_cast<float>( dx )
                                     : dx + 0.5f - PANEL_THICK * 0.5f;
                    const float py = ew_line ? dy + 0.5f - PANEL_THICK * 0.5f
                                     : static_cast<float>( dy );
                    const float psx = ew_line ? 1.0f : PANEL_THICK;
                    const float psy = ew_line ? PANEL_THICK : 1.0f;
                    // a layered locked door stands both layers up: bg is the
                    // board, fg (the key/lock indicator) rides on top of it
                    const sprite_info &facespr = layered_face ? bspr : fspr;
                    const float pr = layered_face ? tone.shade : or_;
                    const float pg = layered_face ? tone.shade : og;
                    const float pb = layered_face ? tone.shade : ob;
                    std::vector<float> &v = bucket_for( MODE_BOX,
                                                        layered_face || ftex ? facespr.atlas : nullptr );
                    // the solid voxels clamping the panel (window sill + lintel,
                    // door lintel) take a wall's middle-segment sprite; without
                    // one they are left out entirely (no gray placeholder)
                    sprite_info wspr;
                    const bool wok = live_clamp_wall( wspr );
                    if( is_window_panel ) {
                        // window = glass band at middle height, clamped by a sill
                        // voxel below and a lintel voxel above
                        constexpr float SILL_H = 0.85f;
                        if( !is_empty_frame ) {
                            push_instance( v, px, py, wz + SILL_H, psx, psy, SILL_H, facespr,
                                           pr, pg, pb, false, 0, false, -1.0f, ghost, tone.sat );
                            ++count;
                        }
                        if( layered_face && ftex && count < MAX_DRAW_INSTANCES ) {
                            // the indicator layer rides a hair proud of the
                            // glass so it never z-fights the face it
                            // composites over; grow symmetrically about the
                            // centre and shift back half the growth so it
                            // reads from either side
                            std::vector<float> &vo = bucket_for( MODE_BOX, fspr.atlas );
                            const float grow = 0.01f; // 5 mm on each face
                            const float osx = ew_line ? psx : psx + grow;
                            const float osy = ew_line ? psy + grow : psy;
                            const float opx = ew_line ? px : px - grow * 0.5f;
                            const float opy = ew_line ? py - grow * 0.5f : py;
                            push_instance( vo, opx, opy, wz + SILL_H, osx, osy, SILL_H, fspr,
                                           tone.shade, tone.shade, tone.shade,
                                           false, 0, false, -1.0f, ghost, tone.sat );
                            ++count;
                        }
                        if( wok && count + 2 <= MAX_DRAW_INSTANCES ) {
                            std::vector<float> &vb = bucket_for( MODE_BOX, wspr.atlas );
                            const sprite_info sill = wall_slice( wspr, 0.0f, SILL_H );
                            const sprite_info lintel = wall_slice( wspr, SILL_H * 2.0f, WALL_HEIGHT );
                            push_instance( vb, static_cast<float>( dx ), static_cast<float>( dy ),
                                           wz, 1.0f, 1.0f, SILL_H, sill,
                                           tone.shade, tone.shade, tone.shade,
                                           false, 0, false, -1.0f, ghost, tone.sat );
                            push_instance( vb, static_cast<float>( dx ), static_cast<float>( dy ),
                                           wz + SILL_H * 2.0f, 1.0f, 1.0f, WALL_HEIGHT - SILL_H * 2.0f,
                                           lintel, tone.shade, tone.shade, tone.shade,
                                           false, 0, false, -1.0f, ghost, tone.sat );
                            count += 2;
                        }
                    } else {
                        // door = grounded panel + a lintel voxel up to the wall top
                        if( !is_empty_frame ) {
                            push_instance( v, px, py, wz, psx, psy, PANEL_HEIGHT, facespr,
                                           pr, pg, pb, false, 0, false, -1.0f, ghost, tone.sat );
                            ++count;
                        }
                        if( layered_face && ftex && count < MAX_DRAW_INSTANCES ) {
                            // the indicator layer rides a hair proud of the board
                            // so it never z-fights the face it composites over.
                            // push_instance anchors at the min corner, so grow
                            // symmetrically about the centre and shift back half
                            // the growth: the key must read from either face
                            std::vector<float> &vo = bucket_for( MODE_BOX, fspr.atlas );
                            const float grow = 0.01f; // 5 mm on each face
                            const float osx = ew_line ? psx : psx + grow;
                            const float osy = ew_line ? psy + grow : psy;
                            const float opx = ew_line ? px : px - grow * 0.5f;
                            const float opy = ew_line ? py - grow * 0.5f : py;
                            push_instance( vo, opx, opy, wz, osx, osy, PANEL_HEIGHT, fspr,
                                           tone.shade, tone.shade, tone.shade,
                                           false, 0, false, -1.0f, ghost, tone.sat );
                            ++count;
                        }
                        if( wok && count + 1 <= MAX_DRAW_INSTANCES ) {
                            std::vector<float> &vb = bucket_for( MODE_BOX, wspr.atlas );
                            const sprite_info lintel = wall_slice( wspr, PANEL_HEIGHT, WALL_HEIGHT );
                            push_instance( vb, static_cast<float>( dx ), static_cast<float>( dy ),
                                           wz + PANEL_HEIGHT, 1.0f, 1.0f, WALL_HEIGHT - PANEL_HEIGHT,
                                           lintel, tone.shade, tone.shade, tone.shade,
                                           false, 0, false, -1.0f, ghost, tone.sat );
                            ++count;
                        }
                    }
                } else if( is_upright_equipment && !roof_unseen ) {
                    std::vector<float> &v = bucket_for( MODE_BILLBOARD_SNAP, ftex ? fspr.atlas : nullptr );
                    push_instance( v, dx + 0.5f, dy + 0.5f, wz - FENCE_HEIGHT * fspr.base_drop,
                                   1.0f, FENCE_HEIGHT, 1.0f, fspr, or_, og, ob,
                                   false, 0, false, -1.0f, ghost, tone.sat );
                    ++count;
                } else if( is_flat_utility ) {
                    std::vector<float> &top = bucket_for( MODE_FLATQUAD, ftex ? fspr.atlas : nullptr );
                    std::vector<float> &sides = bucket_for( MODE_LINEQUAD, ftex ? fspr.atlas : nullptr );
                    count += push_utility_shell( top, sides, dx, dy, wz, fspr, or_, og, ob, frot4,
                                                 ghost, tone.sat, false );
                } else if( is_fence ) {
                    // fences are flat vertical quads standing on the fence line — a
                    // box would smear the sprite's transparent margins over its end
                    // and top faces. pad encodes the run direction for the shader.
                    // Remaining TINY thin obstacles (dock rails) are low strips,
                    // not full-height fences
                    const float fh = t->has_flag( "TINY" ) ? 0.35f : FENCE_HEIGHT;
                    std::vector<float> &v = bucket_for( MODE_LINEQUAD, ftex ? fspr.atlas : nullptr );
                    // connection mask (S=1, E=2, W=4, N=8): straight runs stay one
                    // quad; corners, T-junctions, crossings and dead ends bend —
                    // one half-length quad from the tile center toward each
                    // connected edge
                    const bool cn = ( wall_conn & 8 ) != 0;
                    const bool cs = ( wall_conn & 1 ) != 0;
                    const bool ce = ( wall_conn & 2 ) != 0;
                    const bool cw = ( wall_conn & 4 ) != 0;
                    const bool straight = ( cn && cs && !ce && !cw ) ||
                                          ( ce && cw && !cn && !cs );
                    if( straight || ( !cn && !cs && !ce && !cw ) ) {
                        push_instance( v, dx + 0.5f, dy + 0.5f, wz, 1.0f, fh, 1.0f,
                                       fspr, or_, og, ob, false, 0, false, ew_line ? 0.0f : 1.0f,
                                       ghost, tone.sat );
                        ++count;
                    } else {
                        // half quads sample half the sprite width so the texel
                        // density matches the full-length segments
                        sprite_info hspr = fspr;
                        hspr.u1 = fspr.u0 + ( fspr.u1 - fspr.u0 ) * 0.5f;
                        const float fcx = dx + 0.5f;
                        const float fcy = dy + 0.5f;
                        if( cn ) {
                            push_instance( v, fcx, fcy - 0.25f, wz, 0.5f, fh, 1.0f, hspr,
                                           or_, og, ob, false, 0, false, 1.0f, ghost, tone.sat );
                            ++count;
                        }
                        if( cs ) {
                            push_instance( v, fcx, fcy + 0.25f, wz, 0.5f, fh, 1.0f, hspr,
                                           or_, og, ob, false, 0, false, 1.0f, ghost, tone.sat );
                            ++count;
                        }
                        if( ce ) {
                            push_instance( v, fcx + 0.25f, fcy, wz, 0.5f, fh, 1.0f, hspr,
                                           or_, og, ob, false, 0, false, 0.0f, ghost, tone.sat );
                            ++count;
                        }
                        if( cw ) {
                            push_instance( v, fcx - 0.25f, fcy, wz, 0.5f, fh, 1.0f, hspr,
                                           or_, og, ob, false, 0, false, 0.0f, ghost, tone.sat );
                            ++count;
                        }
                    }
                } else if( is_wall ) {
                    // solid walls: full-height box with the base sprite, no rotation
                    surfaces.set( tripoint( dx, dy, zlev ), pick_surface::wall );
                    std::vector<float> &v = bucket_for( MODE_BOX, ftex ? fspr.atlas : nullptr );
                    push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ), wz,
                                   1.0f, 1.0f, WALL_HEIGHT, fspr, or_, og, ob,
                                   false, 0, false, -1.0f, ghost, tone.sat );
                    ++count;
                }

                // fields (blood, bile, smoke, fire, web...): 2D draws every
                // displayable field entry of the tile in field-map order, below
                // items. Liquid/solid traces become thin decals on the floor;
                // gas/plasma effects (smoke, fire, gas) become camera-facing
                // billboards, matching what their sprites depict.
                {
                    const field &fld_here = mt.get_field();
                    if( fld_here.field_count() > 0 ) {
                        // the neighbour must carry the same field type AND be
                        // visible by the same rule as the tile itself (2D drops
                        // connection edges toward unseen neighbours)
                        const auto neighbor_same_field = [&]( const field_type_id & fid,
                        const tripoint_bub_ms & q ) -> int {
                            if( !here.inbounds( q ) )
                            {
                                return -1;
                            }
                            const tripoint qd( q.x() - center.x(), q.y() - center.y(), q.z() - cz );
                            if( std::abs( qd.x ) > VIEW_RADIUS || std::abs( qd.y ) > VIEW_RADIUS )
                            {
                                return -1;
                            }
                            if( qd.z != 0 && ( std::abs( qd.x ) > REGION_RADIUS ||
                                               std::abs( qd.y ) > REGION_RADIUS ) )
                            {
                                return -1;
                            }
                            const level_cache &qc = here.get_cache_ref( q.z() );
                            lit_level qll = lit_level::BLANK;
                            if( !( qd.z < 0 && q.z() < lowest_vis_z ) )
                            {
                                qll = qd.z > 0 ? upper_lit_at( qc, q )
                                : qc.visibility_cache[q.x()][q.y()];
                            }
                            if( qll != lit_level::LOW && qll != lit_level::LIT &&
                                qll != lit_level::BRIGHT )
                            {
                                return -1;
                            }
                            return here.field_at( q ).find_field( fid ) ?
                            static_cast<int>( fid ) : -1;
                        };
                        // render phase, following looks_like through valid
                        // field ids (fd_fog -> fd_smoke, ...); PNULL stays a
                        // ground decal
                        const auto field_render_phase = []( field_type_id id ) {
                            for( int hop = 0; hop < 4 && id.is_valid(); ++hop ) {
                                const field_type &st = id.obj();
                                if( st.phase != phase_id::PNULL ) {
                                    return st.phase;
                                }
                                const field_type_str_id ll( st.looks_like );
                                if( !ll.is_valid() ) {
                                    break;
                                }
                                id = ll.id();
                            }
                            return phase_id::PNULL;
                        };
                        int ordinal = 0;
                        for( const std::pair<const field_type_id, field_entry> &fd_pr :
                             fld_here ) {
                            const field_type_id &fid = fd_pr.first;
                            const field_type &ft = fid.obj();
                            if( !ft.display_field ) {
                                ++ordinal;
                                continue;
                            }
                            if( count >= MAX_DRAW_INSTANCES ) {
                                break;
                            }
                            const int intensity = fd_pr.second.get_field_intensity();
                            const std::array<int, 4> nb = {{
                                    neighbor_same_field( fid, p + point::south ),
                                    neighbor_same_field( fid, p + point::east ),
                                    neighbor_same_field( fid, p + point::west ),
                                    neighbor_same_field( fid, p + point::north )
                                }
                            };
                            int fsubtile = 0;
                            int frota = 0;
                            if( tiles ) {
                                tiles->get_field_rota_subtile_3d( static_cast<int>( fid ), nb,
                                                                  fsubtile, frota );
                            }
                            // intensity sprite first, then the base sprite, the
                            // same order draw_from_id_string_internal uses
                            const std::string fid_str = ft.id.str();
                            sprite_lookup_3d l;
                            bool found = false;
                            if( tiles && intensity > 0 ) {
                                found = lookup_sprite_layers_3d(
                                            tiles, fid_str + "_int" + std::to_string( intensity ),
                                            TILE_CATEGORY::FIELD, p, fsubtile, frota, false, l );
                            }
                            if( tiles && !found ) {
                                found = lookup_sprite_layers_3d( tiles, fid_str,
                                                                 TILE_CATEGORY::FIELD, p,
                                                                 fsubtile, frota, false, l );
                            }
                            const sprite_info *spr = nullptr;
                            if( found && l.fg_tex ) {
                                spr = &l.fg;
                            } else if( found && l.bg_tex ) {
                                spr = &l.bg;
                            }
                            sprite_info gspr;
                            bool gtex = false;
                            float fr = tone.shade;
                            float fgn = tone.shade;
                            float fb = tone.shade;
                            if( spr == nullptr ) {
                                // ASCII fallback: the level-0 symbol and colour,
                                // exactly the FIELD fallback draw_from_id_string
                                // uses when no sprite resolves
                                const field_intensity_level &il = ft.get_intensity_level();
                                if( glyph_sprite( static_cast<char32_t>( il.symbol ), gspr ) ) {
                                    const ImVec4 col = il.color;
                                    fr = col.x * tone.shade;
                                    fgn = col.y * tone.shade;
                                    fb = col.z * tone.shade;
                                    gtex = true;
                                }
                            }
                            const sprite_info &s = spr != nullptr ? *spr : gspr;
                            if( spr == nullptr && !gtex ) {
                                ++ordinal;
                                continue;
                            }
                            const phase_id ph = field_render_phase( fid );
                            const bool riser = ph == phase_id::GAS ||
                                               ph == phase_id::PLASMA;
                            if( riser ) {
                                // camera-facing billboard; co-tile risers step
                                // toward the camera so they never share a plane
                                const float w = FIELD_RISER_HEIGHT *
                                                std::clamp( s.aspect, 0.5f, 2.0f );
                                const float off = FIELD_RISER_OFFSET *
                                                  ( ordinal % 4 );
                                std::vector<float> &v = bucket_for( MODE_BILLBOARD, s.atlas );
                                push_instance( v, static_cast<float>( dx ) + 0.5f - fwd_x * off,
                                               static_cast<float>( dy ) + 0.5f - fwd_y * off,
                                               wz + 0.01f, w, FIELD_RISER_HEIGHT, 1.0f, s,
                                               fr, fgn, fb, false, 0, false, -1.0f, ghost,
                                               tone.sat, false, spr != nullptr );
                                ++count;
                            } else {
                                // thin ground decal; later fields (map order)
                                // sit a hair higher, reproducing 2D's overdraw
                                const float ox = spr != nullptr ? s.offset.x / 32.0f : 0.0f;
                                const float oy = spr != nullptr ? s.offset.y / 32.0f : 0.0f;
                                const float sx = spr != nullptr ? s.px_w / 32.0f : 1.0f;
                                const float sy = spr != nullptr ? s.px_h / 32.0f : 1.0f;
                                std::vector<float> &v = bucket_for( MODE_FLATQUAD, s.atlas );
                                push_instance( v, static_cast<float>( dx ) + ox,
                                               static_cast<float>( dy ) + oy,
                                               wz + FIELD_DECAL_Z +
                                               FIELD_DECAL_STAGGER * ( ordinal % 8 ),
                                               sx, sy, 1.0f, s, fr, fgn, fb,
                                               false, 0, false, -1.0f, ghost, tone.sat,
                                               false, spr != nullptr );
                                ++count;
                            }
                            ++ordinal;
                        }
                    }
                }

                if( !roof_unseen && f != furn_str_id::NULL_ID() && count < MAX_DRAW_INSTANCES ) {
                    sprite_lookup_3d fl;
                    lookup_sprite_layers_3d( tiles, f->id.str(), TILE_CATEGORY::FURNITURE, p,
                                             -1, 0, true, fl );
                    // locked/alarmed furniture whose tileset splits bg=body /
                    // fg=indicator (key or alarm icon) draws both layers, as
                    // 2D does; ordinary furniture keeps its fg-only billboard
                    const bool layered = fl.bg_tex && wants_layered_face( f.obj() );
                    const sprite_info &fspr = layered ? fl.bg : fl.fg;
                    const bool ftex = layered ? fl.bg_tex : fl.fg_tex;
                    float fr = tone.shade;
                    float fg = tone.shade;
                    float fb = tone.shade;
                    if( !ftex ) {
                        terrain_color( f.to_i() * 31 + 7, fr, fg, fb );
                        fr *= tone.shade;
                        fg *= tone.shade;
                        fb *= tone.shade;
                    }
                    // furniture is a billboard snapped to 90-degree steps: always
                    // roughly facing the camera without continuously rotating
                    const float fw = FURN_QUAD_HEIGHT * std::clamp( fspr.aspect, 0.5f, 2.0f );
                    const bool flat = flat_furniture( f.obj() );
                    if( flat ) {
                        std::vector<float> &v = bucket_for( MODE_FLATQUAD_DECAL,
                                                            ftex ? fspr.atlas : nullptr );
                        push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                                       wz + 0.004f, 1.0f, 1.0f, 1.0f, fspr, fr, fg, fb,
                                       false, fl.fg_rot4, false, -1.0f, ghost, tone.sat );
                    } else {
                        std::vector<float> &v = bucket_for( MODE_BILLBOARD_SNAP,
                                                            ftex ? fspr.atlas : nullptr );
                        push_instance( v, dx + 0.5f, dy + 0.5f,
                                       wz - FURN_QUAD_HEIGHT * fspr.base_drop,
                                       fw, FURN_QUAD_HEIGHT, 1.0f, fspr, fr, fg, fb,
                                       false, 0, false, -1.0f, ghost, tone.sat );
                    }
                    ++count;
                    if( !flat && layered && fl.fg_tex && count < MAX_DRAW_INSTANCES ) {
                        // the indicator rides the body's exact quad, a hair
                        // toward the camera so the strict depth test never
                        // drops it
                        std::vector<float> &vo = bucket_for( MODE_BILLBOARD_SNAP, fl.fg.atlas );
                        push_instance( vo, dx + 0.5f - fwd_x * 0.02f,
                                       dy + 0.5f - fwd_y * 0.02f,
                                       wz - FURN_QUAD_HEIGHT * fspr.base_drop,
                                       fw, FURN_QUAD_HEIGHT, 1.0f, fl.fg,
                                       tone.shade, tone.shade, tone.shade,
                                       false, 0, false, -1.0f, ghost, tone.sat );
                        ++count;
                    }
                }

                if( !roof_unseen && count < MAX_DRAW_INSTANCES ) {
                    if( mt.get_item_count() > 0 ) {
                        const item &itm = mt.get_uppermost_item();
                        sprite_info ispr;
                        bool itex = lookup_sprite( tiles, itm.typeId().str(), TILE_CATEGORY::ITEM,
                                                   p, ispr );
                        float ir = tone.shade;
                        float ig = tone.shade;
                        float ib = tone.shade;
                        if( !itex && g_ctx.glyph_tex ) {
                            // sprite-less item: its ASCII symbol tinted with the
                            // item's own color (curses-style fallback) instead of
                            // a white blob
                            const std::string &sym = itm.symbol();
                            const uint32_t cp = sym.empty() ? '?'
                                                : static_cast<unsigned char>( sym[0] );
                            const int gc = ( cp > 32 && cp <= 126 ) ? static_cast<int>( cp ) - 32
                                           : '?' - 32;
                            ispr.atlas = g_ctx.glyph_tex;
                            ispr.u0 = ( gc % 16 ) * g_ctx.glyph_cell_w /
                                      static_cast<float>( g_ctx.glyph_atlas_w );
                            const int glyph_row = gc / 16;
                            ispr.v0 = glyph_row * g_ctx.glyph_cell_h /
                                      static_cast<float>( g_ctx.glyph_atlas_h );
                            ispr.u1 = ispr.u0 + g_ctx.glyph_cell_w /
                                      static_cast<float>( g_ctx.glyph_atlas_w );
                            ispr.v1 = ispr.v0 + g_ctx.glyph_cell_h /
                                      static_cast<float>( g_ctx.glyph_atlas_h );
                            ispr.aspect = g_ctx.glyph_cell_h > 0
                                          ? static_cast<float>( g_ctx.glyph_cell_w ) / g_ctx.glyph_cell_h
                                          : 1.0f;
                            ispr.base_drop = 0.0f;
                            itex = true;
                            const ImVec4 ic = itm.color();
                            ir = ic.x * tone.shade;
                            ig = ic.y * tone.shade;
                            ib = ic.z * tone.shade;
                        }
                        const float iw = ITEM_HEIGHT * std::clamp( ispr.aspect, 0.5f, 2.0f );
                        // separate co-tile quads along the camera axis so items,
                        // their highlight and furniture billboards never z-fight:
                        // item 0.06 toward the camera, highlight 0.03, furniture 0
                        const float cx = dx + 0.5f - fwd_x * 0.06f;
                        const float cy = dy + 0.5f - fwd_y * 0.06f;
                        const float iz = wz + 0.02f - ITEM_HEIGHT * ispr.base_drop;
                        // tileset highlight sprite behind the item, slightly enlarged
                        sprite_info hspr;
                        if( itex &&
                            lookup_sprite( tiles, "highlight_item", TILE_CATEGORY::NONE, p, hspr ) ) {
                            std::vector<float> &v = bucket_for( MODE_BILLBOARD, hspr.atlas );
                            push_instance( v, cx + fwd_x * 0.03f, cy + fwd_y * 0.03f, iz,
                                           iw * 1.35f, ITEM_HEIGHT * 1.35f, 1.0f, hspr,
                                           tone.shade, tone.shade, tone.shade,
                                           false, 0, false, -1.0f, ghost, tone.sat );
                            ++count;
                        }
                        std::vector<float> &v = bucket_for( MODE_BILLBOARD, itex ? ispr.atlas : nullptr );
                        push_instance( v, cx, cy, iz, iw, ITEM_HEIGHT, 1.0f, ispr,
                                       ir, ig, ib, false, 0, false, -1.0f, ghost, tone.sat );
                        ++count;
                    }
                }

                // vehicles (TP-11 + TP-12 reduced): the display part is exactly
                // 2D's pick (get_display_of_tile: z_order stacking, hidden/fake
                // parts and the passenger roof rule all live inside it) and the
                // sprite resolves with 2D's rules (variant chop, open_/broken
                // subtile, rotation frames / single-sprite quarter turns). The
                // whole sprite — footprint and spill from its pixel size and
                // sheet offset, exactly like 2D draws it — lies flat on the
                // ground as a decal. The single 3D addition: sprites carrying
                // elevation art (a northward spill: UC's 32x48 doors/seats spill
                // half a tile, 32x64 a full one, 64x64 corners one tile north +
                // half west) also stand upright as a side panel on the vehicle's
                // LEFT exterior flank — the sprite IS the side elevation (wheel
                // arches, windows baked in). Everything goes into the decal
                // stream (no depth write, painter order = 2D's row order), so
                // coplanar overlaps resolve exactly like 2D and never z-fight.
                if( !roof_unseen && count < MAX_DRAW_INSTANCES ) {
                    const optional_vpart_position ovp = here.veh_at( p );
                    if( ovp ) {
                        const vehicle &veh = ovp->vehicle();
                        const point offset = veh.fractional_offset();
                        const float shift_x = position_fraction( offset.x );
                        const float shift_y = position_fraction( offset.y );
                        const point_rel_ms mount = ovp->mount_pos();
                        // the identical call 2D makes: part stacking, hidden
                        // parts, fake parts and the passenger roof rule all
                        // live inside it
                        const vpart_display vd = veh.get_display_of_tile( mount );
                        if( !vd.id.is_null() ) {
                            const int vsub = vd.is_open ? open_ : vd.is_broken ? broken : 0;
                            const int vrota = angle_to_dir4( veh.face.dir() - 270_degrees );
                            sprite_lookup_3d vl;
                            lookup_sprite_layers_3d( tiles, "vp_" + vd.id.str(),
                                                     TILE_CATEGORY::VEHICLE_PART, p, vsub, vrota,
                                                     false, vl, vd.variant.id );
                            // the decal's footprint/offset come from the sprite's
                            // pixel size and sheet offset (32 px = one tile), so
                            // oversized part sprites spill over their tile exactly
                            // like 2D draws them
                            const float ox = vl.offset.x / 32.0f;
                            const float oy = vl.offset.y / 32.0f;
                            // the sprite carries side-elevation art iff it
                            // spills north of its tile
                            const bool has_elevation = vl.offset.y < 0;
                            // body height signal (TP-18): the northward spill
                            // in tiles — 32x32 frame/bed 0, 32x48 door/hood 0.5,
                            // 32x64 tall body 1.0
                            const float spill = std::max( 0.0f,
                                                          -static_cast<float>( vl.offset.y ) ) / 32.0f;
                            // near the player the WHOLE vehicle's shell
                            // (panels, voxel body, roof gear) hides and only
                            // the flat 2D skin stays, so working on the car /
                            // seeing into cargo is unobstructed (TP-20: the
                            // verdict is per-vehicle — closest part tile to the
                            // player — not per-tile, so a long car never loses
                            // just its front half)
                            bool near_hide;
                            const auto hidden_it = veh_shell_hidden.find( &veh );
                            if( hidden_it != veh_shell_hidden.end() ) {
                                near_hide = hidden_it->second;
                            } else {
                                near_hide = false;
                                for( int pi = 0;
                                     pi < veh.part_count() && !near_hide; ++pi ) {
                                    if( veh.part( pi ).removed ) {
                                        continue;
                                    }
                                    const tripoint_bub_ms pp = veh.bub_part_pos( here, pi );
                                    if( pp.z() == upos.z() &&
                                        std::hypot( static_cast<float>( pp.x() - upos.x() ),
                                                    static_cast<float>( pp.y() - upos.y() ) )
                                        < VEH_PROX_HIDE_DIST ) {
                                        near_hide = true;
                                    }
                                }
                                veh_shell_hidden[&veh] = near_hide;
                            }
                            // row roof scan (TP-17 row coverage rule, hoisted so
                            // the panels can use it too): any ROOF part anywhere
                            // in the mount row covers every vehicle tile in the
                            // row; removed parts don't count
                            const auto row_has_roof = [&]( const point_rel_ms & m ) -> bool {
                                for( int row_dy = -10; row_dy <= 10; ++row_dy )
                                {
                                    for( const int rpi :
                                         veh.parts_at_relative( m + point_rel_ms( 0, row_dy ),
                                                                true, false ) ) {
                                        const vehicle_part &rp = veh.part( rpi );
                                        if( !rp.removed && rp.info().has_flag( VPFLAG_ROOF ) ) {
                                            return true;
                                        }
                                    }
                                }
                                return false;
                            };
                            const bool roof_covered = row_has_roof( mount );
                            // row width scan (TP-25): columns in this mount
                            // row holding any real part. The side-line
                            // tightening below only applies to rows at least
                            // 3 tiles wide — a 1-wide bike has no "inward"
                            // to tighten into, and a 2-wide row's two cells
                            // are both flank cells (tightening both would
                            // hollow the whole row)
                            const auto row_width = [&]( const point_rel_ms & m ) -> int {
                                int w = 0;
                                for( int row_dy = -10; row_dy <= 10; ++row_dy )
                                {
                                    if( !veh.parts_at_relative( m + point_rel_ms( 0, row_dy ),
                                                                true, false ).empty() ) {
                                        ++w;
                                    }
                                }
                                return w;
                            };
                            const bool wide_enough = row_width( mount ) >= 3;
                            // wing mirrors (TP-26): VISION+PROTRUSION is
                            // wing_mirror alone in the whole parts data.
                            // Protrusions mounted OUTSIDE the hull — no voxel
                            // box, the sprite lies flat facing up against the
                            // side panel instead
                            const bool is_mirror = vd.id.is_valid() &&
                                                   vd.id->has_flag( "VISION" ) &&
                                                   vd.id->has_flag( "PROTRUSION" );
                            // this tile's body box top (TP-18 height tiers)
                            const float box_top = roof_covered ? VEH_ROOF_Z
                                                  : VEH_BODY_BASE +
                                                  VEH_BODY_PER_SPILL * spill;
                            // mount-space delta -> map delta for the car's
                            // facing. vrota is 2D's frame index,
                            // angle_to_dir4(face.dir()-270°) — the dir4 labels
                            // name the ANGLE, not the facing; unrolled the frame
                            // index maps to facing N,E,S,W as 0,1,2,3 (a car
                            // facing east has vrota 1)
                            const auto rot_mount = []( const point & dm, const int k ) -> point {
                                switch( k & 3 )
                                {
                                    case 0:
                                        return point( dm.y, -dm.x );   // facing N
                                    case 1:
                                        return dm;                     // facing E
                                    case 2:
                                        return point( -dm.y, dm.x );   // facing S
                                    default:
                                        return point( -dm.x, -dm.y ); // facing W
                                }
                            };
                            const point front_dir = rot_mount( point::east, vrota );
                            const point rear_dir = rot_mount( point::west, vrota );
                            // a flank is exterior when no real part sits on that
                            // side (fake parts project out of turned wheels and
                            // must not punch holes in the hull)
                            const auto exterior = [&]( const point & dm ) -> bool {
                                return veh.parts_at_relative( mount + point_rel_ms( dm.x, dm.y ),
                                                              true, false ).empty();
                            };
                            const auto push_decal = [&]( SDL_Texture * datlas, const float ddx,
                                                         const float ddy, const float dz,
                                                         const float sx, const float sy,
                                                         const sprite_info & dspr, const float dr, const float dg,
                            const float db, const int drot4 ) {
                                decal_instance di;
                                di.atlas = datlas;
                                push_instance( di.f, ddx + shift_x, ddy + shift_y, dz, sx, sy, 1.0f, dspr, dr, dg, db,
                                               false, drot4, false, -1.0f, ghost, tone.sat );
                                decals.push_back( di );
                                ++count;
                            };
                            const auto push_skin = [&]( const sprite_info & vspr, const int rot4 ) {
                                push_decal( vspr.atlas, static_cast<float>( dx ) + ox,
                                            static_cast<float>( dy ) + oy, wz + VEH_DECAL_Z,
                                            vspr.px_w / 32.0f, vspr.px_h / 32.0f, vspr,
                                            tone.shade, tone.shade, tone.shade, rot4 );
                            };
                            // upright panel on a tile's edge plane whose outward
                            // normal is the world delta d. swap_u mirrors the
                            // sprite left-right; anchor_front anchors the span
                            // at the car's front (side panels run along the
                            // front-rear axis and corner sprites spill toward
                            // the front), otherwise the span is centered on the
                            // tile (front face panels run along the left-right
                            // axis). proud scales the 5mm offset along d that
                            // keeps the panel off the voxel body box face
                            // sharing this plane (the box writes depth, the
                            // panel (decal) does not, so a coplanar panel would
                            // lose the strict-LESS tie and vanish); -1 stands
                            // the panel off the OPPOSITE side — used by glass
                            // laid back onto the cabin box face. Panels go into
                            // the panels sub-stream (camera-sorted at
                            // assembly): the nearer panel always overdraws the
                            // farther one, whose mirrored backface then reads
                            // as the interior view.
                            // these vehicle sprites are 32x48 with a fully
                            // TRANSPARENT north spill zone (the (0,-16) sheet
                            // offset rows): the art exactly fills the 32x32
                            // footprint. Squashing the whole sprite into a
                            // footprint-sized quad wastes 1/3 of it on
                            // discarded pixels (the hood read as a short
                            // strip, the glass as a sliver) — crop the spill
                            // rows off the v range so the art fills the quad
                            const auto crop_spill = []( const sprite_info & s,
                            const point & soff ) {
                                sprite_info c = s;
                                if( s.px_h > 0 && soff.y < 0 ) {
                                    c.v0 += ( s.v1 - s.v0 ) *
                                            ( static_cast<float>( -soff.y ) /
                                              static_cast<float>( s.px_h ) );
                                }
                                return c;
                            };
                            // windshield footprint split (TP-22): the upright
                            // panel takes only the glass band (top of the
                            // footprint) — the gray cowl below it is flat
                            // gray153, invisible against the box top, so the
                            // cover surface comes from the hood decal instead
                            // (TP-23)
                            const auto glass_band = [&crop_spill]( const sprite_info & s,
                            const point & soff ) {
                                sprite_info c = crop_spill( s, soff );
                                c.v1 = c.v0 + ( c.v1 - c.v0 ) * VEH_WSH_GLASS_FRAC;
                                return c;
                            };
                            const auto push_panel = [&]( const sprite_info & pspr, const point & d,
                                                         const bool swap_u, const float base_z,
                                                         const float ph, const bool anchor_front,
                            const float proud = 1.0f ) {
                                if( count >= MAX_DRAW_INSTANCES ) {
                                    return;
                                }
                                const float plen = pspr.px_w / 32.0f;
                                sprite_info uspr = pspr;
                                if( swap_u ) {
                                    std::swap( uspr.u0, uspr.u1 );
                                }
                                float pcx;
                                float pcy;
                                bool run_ns;
                                if( d.x != 0 ) {
                                    // plane x = edge, runs N-S
                                    run_ns = true;
                                    pcx = static_cast<float>( dx ) + ( d.x > 0 ? 1.0f : 0.0f );
                                    if( anchor_front ) {
                                        const float sgn = front_dir.y > 0 ? 1.0f : -1.0f;
                                        const float fedge = static_cast<float>( dy ) +
                                                            ( sgn > 0.0f ? 1.0f : 0.0f );
                                        pcy = fedge - sgn * ox - sgn * plen * 0.5f;
                                    } else {
                                        pcy = static_cast<float>( dy ) +
                                              ( swap_u ? 1.0f - ox - plen * 0.5f
                                                : ox + plen * 0.5f );
                                    }
                                } else {
                                    // plane y = edge, runs E-W
                                    run_ns = false;
                                    pcy = static_cast<float>( dy ) + ( d.y > 0 ? 1.0f : 0.0f );
                                    if( anchor_front ) {
                                        const float sgn = front_dir.x > 0 ? 1.0f : -1.0f;
                                        const float fedge = static_cast<float>( dx ) +
                                                            ( sgn > 0.0f ? 1.0f : 0.0f );
                                        pcx = fedge - sgn * ox - sgn * plen * 0.5f;
                                    } else {
                                        pcx = static_cast<float>( dx ) +
                                              ( swap_u ? 1.0f - ox - plen * 0.5f
                                                : ox + plen * 0.5f );
                                    }
                                }
                                // stand proud of the voxel body box face
                                // sharing this plane (see above)
                                pcx += d.x * 0.005f * proud + shift_x;
                                pcy += d.y * 0.005f * proud + shift_y;
                                decal_instance di;
                                di.mode = MODE_LINEQUAD_DECAL;
                                di.atlas = uspr.atlas;
                                push_instance( di.f, pcx, pcy, base_z, plen, ph, 1.0f, uspr,
                                               tone.shade, tone.shade, tone.shade,
                                               false, 0, false, run_ns ? 1.0f : 0.0f,
                                               ghost, tone.sat );
                                di.sort_key = pcx * fwd_x + pcy * fwd_y;
                                panels.push_back( di );
                                ++count;
                            };

                            // skin: the flat 2D composite on the ground — bg
                            // first (the broken subtile carries the oriented
                            // base sprites there), fg second, 2D's order.
                            // TP-27: the skin is the car's NEAR-field
                            // appearance only — it draws exactly when the
                            // shell is hidden (near_hide, TP-20); past
                            // VEH_PROX_HIDE_DIST the 3D shell alone carries
                            // the car and the 2D floor sprites hide. vdrew
                            // (the gate every block below shares) only means
                            // "this tile has drawable art" and is decoupled
                            // from actually pushing the skin — otherwise the
                            // whole car would vanish at distance
                            bool vdrew = false; // 2D's ret: highlight/carried furniture gate
                            if( vl.bg_tex ) {
                                if( near_hide && count < MAX_DRAW_INSTANCES ) {
                                    push_skin( vl.bg, 0 );
                                }
                                vdrew = true;
                            }
                            if( vl.fg_tex ) {
                                if( near_hide && count < MAX_DRAW_INSTANCES ) {
                                    push_skin( vl.fg, vl.fg_rot4 );
                                }
                                vdrew = true;
                            }
                            if( !vl.fg_tex && !vl.bg_tex ) {
                                // no sprite: the ASCII fallback
                                // draw_from_id_string_internal uses — the variant's
                                // direction-aware symbol in the part's color
                                const vpart_id &vpid = vd.id;
                                if( vpid.is_valid() &&
                                    vpid->variants.count( vd.variant.id ) ) {
                                    const vpart_variant &vv = vpid->variants.at( vd.variant.id );
                                    const char32_t vsym = vd.is_open ? U'\''
                                                          : vv.get_symbol_curses(
                                                              90_degrees * vrota, vd.is_broken );
                                    sprite_info vspr;
                                    if( glyph_sprite( vsym, vspr ) ) {
                                        if( near_hide && count < MAX_DRAW_INSTANCES ) {
                                            const ImVec4 vc = vpid->color;
                                            push_decal( vspr.atlas, static_cast<float>( dx ),
                                                        static_cast<float>( dy ), wz + VEH_DECAL_Z,
                                                        1.0f, 1.0f, vspr,
                                                        vc.x * tone.shade, vc.y * tone.shade,
                                                        vc.z * tone.shade, 0 );
                                        }
                                        vdrew = true;
                                    }
                                }
                            }
                            if( near_hide && vdrew && offset != point::zero ) {
                                surfaces.add_vehicle_box( tripoint( dx, dy, zlev ),
                                { dx + shift_x, dy + shift_y, wz + VEH_DECAL_Z - 0.002f },
                                { dx + shift_x + 1.0f, dy + shift_y + 1.0f, wz + VEH_DECAL_Z + 0.002f } );
                            }
                            // side panels on both exterior flanks (mount left
                            // (0,-1) and right (0,+1)), each resolved with its
                            // fixed frame (left: vrota 3, right: vrota 1 — the
                            // facings whose flank art is the full side
                            // elevation); the broken subtile's two layers
                            // become two panels in 2D order
                            bool got_side_panel = false;
                            if( vdrew && has_elevation && !near_hide ) {
                                for( const point dm : {
                                         point::north, point::south
                                     } ) {
                                    if( !exterior( dm ) ) {
                                        continue;
                                    }
                                    const bool is_left = dm.y < 0;
                                    const point d = rot_mount( dm, vrota );
                                    // TP-25: on rows at least 3 tiles wide the
                                    // side line tightens one tile inward — the
                                    // panel stands on the flank tile's INNER
                                    // edge against the cabin box's outer face
                                    // (passing -d moves the plane; proud -1
                                    // keeps the 5mm standoff pointing OUT of
                                    // that face) — closing the blank strip of
                                    // flank-tile box tops between the voxel
                                    // body and the panels. Narrow rows keep
                                    // the outer edge (nothing to tighten into)
                                    const point pd = wide_enough ? point( -d.x, -d.y ) : d;
                                    const float pproud = wide_enough ? -1.0f : 1.0f;
                                    const float sgn = d.x != 0
                                                      ? ( front_dir.y > 0 ? 1.0f : -1.0f )
                                                      : ( front_dir.x > 0 ? 1.0f : -1.0f );
                                    const bool swap_u = is_left == ( sgn > 0.0f );
                                    sprite_lookup_3d pl;
                                    lookup_sprite_layers_3d( tiles, "vp_" + vd.id.str(),
                                                             TILE_CATEGORY::VEHICLE_PART, p, vsub,
                                                             is_left ? 3 : 1, false, pl,
                                                             vd.variant.id );
                                    if( pl.bg_tex ) {
                                        push_panel( pl.bg, pd, swap_u, wz + VEH_PANEL_BASE_Z,
                                                    pl.bg.px_h / 32.0f * VEH_PANEL_ZSCALE, true,
                                                    pproud );
                                    }
                                    if( pl.fg_tex ) {
                                        push_panel( pl.fg, pd, swap_u, wz + VEH_PANEL_BASE_Z,
                                                    pl.fg.px_h / 32.0f * VEH_PANEL_ZSCALE, true,
                                                    pproud );
                                    }
                                    got_side_panel = true;
                                }
                            }
                            // TP-25: a tightened flank tile (panel moved to
                            // its inner edge) gets NO voxel box — the box
                            // would bury the moved panel; the strip reads as
                            // the under-car gap instead (ground skin near,
                            // terrain past the proximity radius). Corner tiles
                            // tighten the same way; their hood/rear art is
                            // not drawn at all (TP-28 — stacking it on the
                            // middle column doubled that column's own art)
                            const bool flank_tightened = got_side_panel && wide_enough;
                            // the front face (TP-13, relaid flat in TP-19): the
                            // hood cover no longer stands at the front edge —
                            // it lies ON TOP of the hood row's body box,
                            // exactly covering the 1x1 top face; the box's gray
                            // front face is the fascia. The sprite still
                            // resolves with the fixed vrota=2 frame (the car
                            // faces the 2D camera there, so the art is the
                            // front view with the grille band at the image's
                            // bottom); flat-decal rot4 turns that bottom edge
                            // toward the real front (rot4 k puts the image
                            // bottom to S,W,N,E for k=0,1,2,3 — facings
                            // N,E,S,W = vrota 0,1,2,3 need k = (vrota+2)&3;
                            // fg additionally carries the lookup's own
                            // quarter-turn, like the skin does)
                            const point left_dir = rot_mount( point::north, vrota );
                            const point front_axis = front_dir.x != 0 ? point::south
                                                     : point::east;
                            const bool front_swap = front_axis != left_dir;
                            // TP-28: a tightened corner tile draws NO hood
                            // art — its decal shifted onto the middle column
                            // (TP-25) doubled that column's own cover even
                            // when cropped to the light strip, so the corner
                            // cover art is simply omitted (user decision);
                            // the cover's width is the middle columns' own
                            if( vdrew && has_elevation && !near_hide && !flank_tightened &&
                                exterior( point::east ) ) {
                                // hood cover: front-exterior tile, laid flat on
                                // the body box top
                                sprite_lookup_3d ql;
                                lookup_sprite_layers_3d( tiles, "vp_" + vd.id.str(),
                                                         TILE_CATEGORY::VEHICLE_PART, p, vsub,
                                                         2, false, ql, vd.variant.id );
                                const int hood_rot4 = ( vrota + 2 ) & 3;
                                // TP-23: windshield#cover sprites are glass +
                                // front cover in one tile — in 2D the cover
                                // visually spans the hood row AND the
                                // windshield row behind it. The windshield
                                // sprite's cowl half is flat gray153 (=
                                // the box top color, invisible laid flat), so
                                // when an unroofed windshield row sits right
                                // behind, stretch this decal over BOTH rows'
                                // box tops (same 0.80 height: UC windshield
                                // sprites are 32x48 spill tiles like the
                                // hood's): the grille stays at the front edge
                                // and the diagonal streaks cross onto the
                                // windshield row — one continuous two-row
                                // cover, like 2D. Roofed windshield rows
                                // (fire truck: windshield+roof on one tile,
                                // box top 1.35) and non-windshield neighbors
                                // keep the 1x1 footprint.
                                const point_rel_ms behind_mount = mount +
                                                                  point_rel_ms( -1, 0 );
                                const vpart_display vd_behind =
                                    veh.get_display_of_tile( behind_mount );
                                const bool hood_two_rows =
                                    vd_behind.id.is_valid() &&
                                    vd_behind.id->has_flag( VPFLAG_WINDOW ) &&
                                    !vd_behind.id->has_flag( VPFLAG_OPENABLE ) &&
                                    !vd_behind.id->has_flag( "DOOR" ) &&
                                    !row_has_roof( behind_mount );
                                float hdx = dx;
                                float hdy = dy;
                                float hsx = 1.0f;
                                float hsy = 1.0f;
                                if( hood_two_rows ) {
                                    hdx += rear_dir.x < 0 ? -1.0f : 0.0f;
                                    hdy += rear_dir.y < 0 ? -1.0f : 0.0f;
                                    hsx += std::abs( rear_dir.x );
                                    hsy += std::abs( rear_dir.y );
                                }
                                if( ql.bg_tex ) {
                                    push_decal( ql.bg.atlas, hdx, hdy,
                                                wz + box_top + 0.005f,
                                                hsx, hsy, crop_spill( ql.bg, ql.offset ),
                                                tone.shade, tone.shade, tone.shade,
                                                hood_rot4 );
                                }
                                if( ql.fg_tex ) {
                                    push_decal( ql.fg.atlas, hdx, hdy,
                                                wz + box_top + 0.005f,
                                                hsx, hsy, crop_spill( ql.fg, ql.offset ),
                                                tone.shade, tone.shade, tone.shade,
                                                ( ql.fg_rot4 + hood_rot4 ) & 3 );
                                }
                            }
                            // windshield panel: glass parts that got no side panel
                            // (the A-pillar corner pieces live on the flanks and
                            // are covered by the side panels). TP-19: when the
                            // cabin row behind/ahead is roofed, the glass lies
                            // back onto the cabin body box's EXPOSED vertical
                            // face — the stretch between this tile's box top and
                            // the roof line — flush against it (proud -1 keeps
                            // it off the box face it covers); the old position
                            // (own tile's edge toward the nearer end, 0.55-1.35)
                            // dangled a tile away from the cabin and its lower
                            // band sank into the neighbor box. Roofless cars
                            // (no cabin wall to stick to) keep the old
                            // placement. Front/rear split: the glass nearer the
                            // rear (sedans' rear windshield) uses the
                            // rear-facing frame and sticks to the cabin box's
                            // rear face
                            const point right_dir = rot_mount( point::south, vrota );
                            const point rear_axis = rear_dir.x != 0 ? point::south
                                                    : point::east;
                            const bool rear_swap = rear_axis != right_dir;
                            const bool is_windshield = vd.id.is_valid() &&
                                                       vd.id->has_flag( VPFLAG_WINDOW ) &&
                                                       !vd.id->has_flag( VPFLAG_OPENABLE ) &&
                                                       !vd.id->has_flag( "DOOR" );
                            if( vdrew && is_windshield && !got_side_panel &&
                                !near_hide ) {
                                int dist_front = 0;
                                for( point_rel_ms m = mount + point_rel_ms( 1, 0 );
                                     dist_front < 40 &&
                                     !veh.parts_at_relative( m, true, false ).empty();
                                     m += point_rel_ms( 1, 0 ) ) {
                                    ++dist_front;
                                }
                                int dist_rear = 0;
                                for( point_rel_ms m = mount + point_rel_ms( -1, 0 );
                                     dist_rear < 40 &&
                                     !veh.parts_at_relative( m, true, false ).empty();
                                     m += point_rel_ms( -1, 0 ) ) {
                                    ++dist_rear;
                                }
                                const bool rear_glass = dist_rear < dist_front;
                                sprite_lookup_3d ql;
                                lookup_sprite_layers_3d( tiles, "vp_" + vd.id.str(),
                                                         TILE_CATEGORY::VEHICLE_PART, p, vsub,
                                                         rear_glass ? 0 : 2, false, ql,
                                                         vd.variant.id );
                                // the cabin sits on the far side from the
                                // nearer end: behind the front glass, ahead of
                                // the rear glass
                                const bool cabin_roofed = row_has_roof( mount +
                                                                        ( rear_glass ? point_rel_ms( 1, 0 )
                                                                                : point_rel_ms( -1, 0 ) ) );
                                const bool flush_cabin = cabin_roofed && !roof_covered;
                                const point glass_dir = flush_cabin
                                                        ? ( rear_glass ? front_dir : rear_dir )
                                                        : ( rear_glass ? rear_dir : front_dir );
                                const bool glass_swap = rear_glass ? rear_swap : front_swap;
                                const float glass_z = flush_cabin ? wz + box_top
                                                      : wz + VEH_WSH_BASE_Z;
                                const float glass_h = flush_cabin
                                                      ? VEH_ROOF_Z - box_top
                                                      : VEH_WSH_H;
                                const float glass_proud = flush_cabin ? -1.0f : 1.0f;
                                // TP-21/22 sprite split: crop the empty spill
                                // rows everywhere; flush panels take only the
                                // black glass band (stretched over the exposed
                                // cabin face — TP-19's exact-fit intent);
                                // roofless panels keep the whole footprint.
                                // The gray cowl half is NOT laid flat here:
                                // it is gray153-on-gray153 against the box
                                // top (invisible) — the cover surface comes
                                // from the hood decal stretched over both
                                // rows (TP-23)
                                if( ql.bg_tex ) {
                                    push_panel( flush_cabin
                                                ? glass_band( ql.bg, ql.offset )
                                                : crop_spill( ql.bg, ql.offset ),
                                                glass_dir, glass_swap,
                                                glass_z, glass_h, false, glass_proud );
                                }
                                if( ql.fg_tex ) {
                                    push_panel( flush_cabin
                                                ? glass_band( ql.fg, ql.offset )
                                                : crop_spill( ql.fg, ql.offset ),
                                                glass_dir, glass_swap,
                                                glass_z, glass_h, false, glass_proud );
                                }
                            }
                            // rear fascia (TP-14): the mirror of the front face —
                            // rear-exterior tiles with elevation art stand their
                            // rear-facing frame (vrota=0, drawn for the car
                            // facing away from the 2D camera) on the rear edge
                            // plane, at full side-panel height (tailgates and
                            // rear boards reach the roof line). Rear corner tiles
                            // also carry a side panel — the two form the corner.
                            // TP-28: a TIGHTENED rear corner tile draws no
                            // fascia at all — shifted onto the middle column
                            // (TP-25) it doubled that column's own panel even
                            // when cropped to the light strip, so the corner
                            // art is simply omitted (user decision); the rear
                            // face's width is the middle columns' own
                            if( vdrew && has_elevation && !near_hide && !flank_tightened &&
                                exterior( point::west ) ) {
                                sprite_lookup_3d rl;
                                lookup_sprite_layers_3d( tiles, "vp_" + vd.id.str(),
                                                         TILE_CATEGORY::VEHICLE_PART, p, vsub,
                                                         0, false, rl, vd.variant.id );
                                if( rl.bg_tex ) {
                                    push_panel( rl.bg, rear_dir, rear_swap,
                                                wz + VEH_PANEL_BASE_Z + 0.30f,
                                                rl.bg.px_h / 32.0f * VEH_PANEL_ZSCALE,
                                                false );
                                }
                                if( rl.fg_tex ) {
                                    push_panel( rl.fg, rear_dir, rear_swap,
                                                wz + VEH_PANEL_BASE_Z + 0.30f,
                                                rl.fg.px_h / 32.0f * VEH_PANEL_ZSCALE,
                                                false );
                                }
                            }
                            // box-top art (TP-24): a body tile that is none of
                            // the four paneled roles (side panel / rear fascia /
                            // hood cover / windshield) and has no roof shows
                            // its 2D sprite on the voxel box top — pickup beds,
                            // roadster seats, bike frames... The sprite is the
                            // skin's own lookup (real facing frame, open/broken
                            // variants match 2D), cropped to the footprint and
                            // laid 1x1 on the box top, same rule as the hood
                            // decal. Role tests reuse the paneled blocks'
                            // conditions (a front/rear-exterior tile WITHOUT
                            // elevation art stands no panel — a bike head tube,
                            // a pickup bed's tail row — and falls through to
                            // here, which is exactly the intent).
                            const bool hood_tile = has_elevation &&
                                                   exterior( point::east );
                            const bool rear_tile = has_elevation &&
                                                   exterior( point::west );
                            if( vdrew && !near_hide && !roof_covered &&
                                !got_side_panel && !is_windshield &&
                                !hood_tile && !rear_tile && !is_mirror ) {
                                if( vl.bg_tex ) {
                                    push_decal( vl.bg.atlas, static_cast<float>( dx ),
                                                static_cast<float>( dy ),
                                                wz + box_top + 0.005f,
                                                1.0f, 1.0f, crop_spill( vl.bg, vl.offset ),
                                                tone.shade, tone.shade, tone.shade, 0 );
                                }
                                if( vl.fg_tex ) {
                                    push_decal( vl.fg.atlas, static_cast<float>( dx ),
                                                static_cast<float>( dy ),
                                                wz + box_top + 0.005f,
                                                1.0f, 1.0f, crop_spill( vl.fg, vl.offset ),
                                                tone.shade, tone.shade, tone.shade,
                                                vl.fg_rot4 );
                                }
                            }
                            // wing mirror (TP-26): a protrusion mounted
                            // OUTSIDE the hull. No voxel box (excluded
                            // below); the sprite lies flat FACING UP at
                            // beltline height on the body tile just inboard
                            // (the tile whose side panel the mirror is glued
                            // to): its inner edge touches the panel, the art
                            // reaches outboard like the real mirror on its
                            // stalk. Falls back to the mirror's own tile if
                            // no inboard body tile exists
                            if( is_mirror && vdrew && !near_hide ) {
                                point minv;
                                for( const point dm : {
                                         point::north, point::south,
                                         point::west, point::east
                                     } ) {
                                    if( !veh.parts_at_relative( mount + point_rel_ms( dm.x, dm.y ),
                                                                true, false ).empty() ) {
                                        minv = rot_mount( dm, vrota );
                                        break;
                                    }
                                }
                                const float mdx = static_cast<float>( dx + minv.x );
                                const float mdy = static_cast<float>( dy + minv.y );
                                if( vl.bg_tex && count < MAX_DRAW_INSTANCES ) {
                                    push_decal( vl.bg.atlas, mdx, mdy,
                                                wz + VEH_MIRROR_Z + 0.005f,
                                                1.0f, 1.0f, vl.bg,
                                                tone.shade, tone.shade, tone.shade, 0 );
                                }
                                if( vl.fg_tex && count < MAX_DRAW_INSTANCES ) {
                                    push_decal( vl.fg.atlas, mdx, mdy,
                                                wz + VEH_MIRROR_Z + 0.005f,
                                                1.0f, 1.0f, vl.fg,
                                                tone.shade, tone.shade, tone.shade,
                                                vl.fg_rot4 );
                                }
                            }
                            // voxel body (TP-17 + TP-18): every vehicle tile
                            // with a display part gets a solid box, so the
                            // whole car has a body — not just the roofed cabin.
                            // Height by part kind (roof_covered / box_top
                            // computed above): roofed rows reach the roof line;
                            // unroofed tiles rise with the sprite's northward
                            // spill (the part's height): 32x32 frame/bed a low
                            // chassis deck, 32x48 door/hood mid-height, 32x64
                            // tall body high. The box top faces form the
                            // roof/deck, the side faces are the body at the
                            // outline. Adjacent boxes' shared faces are exactly
                            // coplanar with identical corners, so the
                            // strict-LESS loser is stable — no shimmer; the
                            // panel stream stands 5mm proud of these faces. No
                            // roof art exists (vp_roof is a placeholder solid;
                            // part colors are ASCII colors), so the box is
                            // untextured flat gray x tile light — 0.6 = the
                            // gray153 the body part sprites themselves use
                            // (TP-21). BOX is in the
                            // camera->player soft mask list: the body carves
                            // open around a passenger like a building roof.
                            // Near the player the box hides with the rest of
                            // the shell (near_hide above). Two tiles never
                            // get a box: a tightened flank tile (TP-25 — the
                            // panel moved to its inner edge, a box here would
                            // bury it; the gap reads as the under-car space)
                            // and a wing mirror tile (TP-26 — a protrusion on
                            // a stalk, its flat art is drawn above instead).
                            if( !near_hide && !flank_tightened && !is_mirror &&
                                count < MAX_DRAW_INSTANCES ) {
                                constexpr float body_bottom = VEH_PANEL_BASE_Z + 0.30f;
                                const tripoint cell( dx, dy, zlev );
                                const float left = dx + shift_x;
                                const float top = dy + shift_y;
                                if( offset == point::zero ) {
                                    surfaces.set_vehicle_body( cell, body_bottom, box_top );
                                } else {
                                    surfaces.add_vehicle_box( cell, { left, top, wz + body_bottom },
                                    { left + 1.0f, top + 1.0f, wz + box_top } );
                                }
                                sprite_info rspr; // untextured -> white fallback x color
                                std::vector<float> &v = bucket_for( MODE_BOX, nullptr );
                                push_instance( v, left, top, wz + body_bottom,
                                               1.0f, 1.0f, box_top - body_bottom, rspr,
                                               0.6f * tone.shade, 0.6f * tone.shade,
                                               0.6f * tone.shade,
                                               false, 0, false, -1.0f, ghost, tone.sat );
                                ++count;
                            }
                            // roof-mounted equipment (TP-16): police lights,
                            // solar panels, floodlights, turrets... live at
                            // location on_roof and are the tile's display part
                            // (z_order 9; hidden from passengers inside, exactly
                            // like 2D). Draw their sprite ON the roof cover with
                            // the SAME footprint+sheet offset as the ground skin
                            // (TP-21: TP-17's centered 1x1 squash shrank the art
                            // into a floating fragment per tile — the police
                            // light bar's red/blue halves mount on adjacent
                            // tiles and must touch like 2D, slight spill offset
                            // included). Near the player the ground skin also
                            // stays (TP-27), so a torn-open roof still shows
                            // something on the floor there.
                            // TP-29: the sheet spill points world NORTH — for an
                            // E/W-facing car that's LATERAL, and the E/W frames
                            // draw the equipment standing up INTO the spill rows
                            // (the light bar's art reaches half a tile out).
                            // With the flank boxes gone (TP-25) that half tile
                            // hangs in the air off the tightened roof edge.
                            // Drop the spill for E/W-facing cars: the quad top
                            // starts at the tile's north edge and the art lands
                            // centered on the tile. N/S frames keep their art
                            // inside the tile already, so they keep the 2D
                            // footprint unchanged
                            if( roof_covered && vdrew && !near_hide &&
                                vd.id->location == vpart_location_on_roof ) {
                                const float eq_oy = ( vrota & 1 ) ? 0.0f : oy;
                                if( vl.bg_tex && count < MAX_DRAW_INSTANCES ) {
                                    push_decal( vl.bg.atlas, static_cast<float>( dx ) + ox,
                                                static_cast<float>( dy ) + eq_oy,
                                                wz + VEH_ROOF_Z + 0.005f,
                                                vl.bg.px_w / 32.0f, vl.bg.px_h / 32.0f,
                                                vl.bg,
                                                tone.shade, tone.shade, tone.shade, 0 );
                                }
                                if( vl.fg_tex && count < MAX_DRAW_INSTANCES ) {
                                    push_decal( vl.fg.atlas, static_cast<float>( dx ) + ox,
                                                static_cast<float>( dy ) + eq_oy,
                                                wz + VEH_ROOF_Z + 0.005f,
                                                vl.fg.px_w / 32.0f, vl.fg.px_h / 32.0f,
                                                vl.fg,
                                                tone.shade, tone.shade, tone.shade,
                                                vl.fg_rot4 );
                                }
                            }
                            if( vdrew && vd.has_cargo && count < MAX_DRAW_INSTANCES ) {
                                // cargo contents marker, the same highlight_item
                                // tile 2D draws over cargo-carrying part tiles
                                sprite_info hspr;
                                if( lookup_sprite( tiles, "highlight_item", TILE_CATEGORY::NONE,
                                                   p, hspr ) ) {
                                    push_decal( hspr.atlas, static_cast<float>( dx ),
                                                static_cast<float>( dy ), wz + VEH_DECAL_Z,
                                                1.0f, 1.0f, hspr,
                                                tone.shade, tone.shade, tone.shade, 0 );
                                }
                            }
                            if( vdrew && !vd.carried_furn.empty() && count < MAX_DRAW_INSTANCES ) {
                                // furniture tied down on the part (bike racks...):
                                // 2D draws it after the vpart with subtile 0 / rota 0
                                sprite_lookup_3d fl;
                                lookup_sprite_layers_3d( tiles, vd.carried_furn,
                                                         TILE_CATEGORY::FURNITURE, p, 0, 0,
                                                         false, fl );
                                if( fl.fg_tex ) {
                                    const float fox = fl.offset.x / 32.0f;
                                    const float foy = fl.offset.y / 32.0f;
                                    const float fsx = fl.fg.px_w / 32.0f;
                                    const float fsy = fl.fg.px_h / 32.0f;
                                    push_decal( fl.fg.atlas, static_cast<float>( dx ) + fox,
                                                static_cast<float>( dy ) + foy, wz + VEH_DECAL_Z,
                                                fsx, fsy, fl.fg,
                                                tone.shade, tone.shade, tone.shade,
                                                fl.fg_rot4 );
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // paper doll: the base body billboard plus every overlay layer 2D's
    // draw_entity_with_overlays draws, with exactly its ids and order
    // (Character::get_overlay_ids / monster::get_overlay_ids resolved through
    // find_overlay_looks_like). Overlay canvases are placed with the same
    // tile-origin + sheet-offset rule 2D uses, scaled to the body's pixel size,
    // and nudged toward the camera per layer so the strict-LESS depth test
    // stacks them correctly even across tilesheet draw calls.
    auto push_entity = [&]( const Creature & critter, const tripoint_bub_ms & p,
                            const float dx, const float dy, const float wz,
    const tile_tone & tone ) {
        std::string sprite_id;
        TILE_CATEGORY cat = TILE_CATEGORY::NONE;
        float size_scale = 1.0f;
        bool male = true;
        std::vector<std::pair<std::string, std::string>> overlays;
        if( const monster *m = critter.as_monster() ) {
            sprite_id = m->type->id.str();
            cat = TILE_CATEGORY::MONSTER;
            size_scale = creature_size_scale( m->get_size() );
            overlays = m->get_overlay_ids();
        } else if( const Character *ch = critter.as_character() ) {
            size_scale = CHARACTER_SIZE_SCALE;
            male = ch->male;
            const std::vector<trait_id> look_muts = ch->get_functioning_mutations( true, false,
            []( const mutation_branch & mut ) {
                return mut.override_look.has_value();
            } );
            if( look_muts.empty() ) {
                sprite_id = ch->is_npc() ? ( male ? "npc_male" : "npc_female" )
                            : ( male ? "player_male" : "player_female" );
                overlays = ch->get_overlay_ids();
            } else {
                // 2D draws the mutation's override tile instead of a body and
                // keeps only effect/move-mode overlays
                const mutation_branch::OverrideLook &look =
                    look_muts.front().obj().override_look.value();
                sprite_id = look.id;
                const auto cat_it = to_TILE_CATEGORY.find( look.tile_category );
                cat = cat_it != to_TILE_CATEGORY.end() ? cat_it->second : TILE_CATEGORY::NONE;
                overlays = ch->get_overlay_ids_when_override_look();
            }
        } else {
            return;
        }
        sprite_info cspr;
        const bool ctex = lookup_sprite( tiles, sprite_id, cat, p, cspr );
        const float ch = CREATURE_BASE_HEIGHT * size_scale;
        const float cw = ch * std::clamp( cspr.aspect, 0.4f, 2.5f );
        // canvas bottom of the body sprite, as the single-billboard path placed it
        const float zbase = wz - ch * cspr.base_drop;
        if( &critter != &you ) {
            const tripoint d( p.x() - center.x(), p.y() - center.y(), p.z() );
            surfaces.add_actor( d, scene_point{ dx + 0.5f, dy + 0.5f, zbase },
                                point( cspr.px_w, cspr.px_h ), cw, ch, cspr.alpha_profile );
        }
        {
            std::vector<float> &v = bucket_for( MODE_BILLBOARD, ctex ? cspr.atlas : nullptr );
            push_instance( v, dx + 0.5f, dy + 0.5f, zbase, cw, ch, 1.0f, cspr,
                           tone.shade, tone.shade, tone.shade,
                           false, 0, false, -1.0f, false, tone.sat );
            ++count;
        }
        if( !ctex || cspr.px_h <= 0 || cspr.px_w <= 0 ) {
            return;
        }
        // meters per sprite pixel: the body canvas sets the scale every layer
        // shares, so an overlay canvas lands exactly where 2D draws it
        const float px_scale = ch / static_cast<float>( cspr.px_h );
        const float base_center_px = cspr.offset.x + cspr.px_w * 0.5f;
        const float rgt_x = std::sin( g_yaw );
        const float rgt_y = -std::cos( g_yaw );
        int layer = 0;
        int resolved = 0;
        std::string resolved_ids;
        for( const std::pair<std::string, std::string> &overlay : overlays ) {
            if( count >= MAX_DRAW_INSTANCES ) {
                return;
            }
            std::string draw_id;
            if( !tiles->find_overlay_looks_like_3d( male, overlay.first, overlay.second, draw_id ) ) {
                continue;
            }
            sprite_info ospr;
            if( !lookup_sprite( tiles, draw_id, TILE_CATEGORY::NONE, p, ospr ) ||
                ospr.px_h <= 0 || ospr.px_w <= 0 ) {
                continue;
            }
            ++layer;
            ++resolved;
            if( resolved <= 8 ) {
                resolved_ids += resolved_ids.empty() ? "" : ",";
                resolved_ids += draw_id;
            }
            const float oh = ospr.px_h * px_scale;
            const float ow = oh * std::clamp( ospr.aspect, 0.4f, 2.5f );
            // 2D places each layer at tile origin + its sheet sprite offset, so
            // the canvas-bottom/center difference to the body canvas is the
            // layer's displacement (a hat must not drop its opaque bottom to
            // the ground, so per-sprite base_drop is NOT usable here)
            const float zbot = zbase - static_cast<float>(
                                   ( ospr.offset.y + ospr.px_h ) - ( cspr.offset.y + cspr.px_h ) ) *
                               px_scale;
            const float dpx = ( ospr.offset.x + ospr.px_w * 0.5f ) - base_center_px;
            // strict-LESS depth: each later layer sits a bit closer to the camera
            const float off = 0.004f * std::min( layer, 24 );
            const float ax = dx + 0.5f + rgt_x * dpx * px_scale - fwd_x * off;
            const float ay = dy + 0.5f + rgt_y * dpx * px_scale - fwd_y * off;
            std::vector<float> &v = bucket_for( MODE_BILLBOARD, ospr.atlas );
            push_instance( v, ax, ay, zbot, ow, oh, 1.0f, ospr,
                           tone.shade, tone.shade, tone.shade,
                           false, 0, false, -1.0f, false, tone.sat );
            ++count;
        }
        // TEMP paper-doll bring-up diagnostic: one line per base sprite
        static std::unordered_set<std::string> doll_logged;
        if( doll_logged.size() < 120 && doll_logged.insert( sprite_id ).second ) {
            write_status( "doll: " + sprite_id + " overlays=" +
                          std::to_string( overlays.size() ) + " resolved=" +
                          std::to_string( resolved ) + " ids=" + resolved_ids );
        }
    };

    // Creatures live in the tracker, not the map. Visit their actual occupied
    // positions instead of scanning every tile (and every active NPC per empty
    // tile). Sort back into the old z/y/x order, and still ask creature_at for
    // the displayed occupant so riding and hallucination rules stay unchanged.
    if( count >= MAX_DRAW_INSTANCES ) {
        return count;
    }
    creature_tracker &tracker = get_creature_tracker();
    static std::unordered_set<tripoint_bub_ms> occupied;
    occupied.clear();
    for( const Creature &candidate : g->all_creatures() ) {
        const tripoint_bub_ms p = candidate.pos_bub();
        const int dz = p.z() - cz;
        const point d( p.x() - center.x(), p.y() - center.y() );
        if( p.z() < zmin || p.z() > zmax || std::abs( d.x ) > VIEW_RADIUS ||
            std::abs( d.y ) > VIEW_RADIUS || !here.inbounds( p ) ) {
            continue;
        }
        if( dz != 0 && ( std::abs( d.x ) > REGION_RADIUS || std::abs( d.y ) > REGION_RADIUS ) ) {
            continue;
        }
        if( dz < 0 && p.z() < lowest_vis_z ) {
            continue;
        }
        if( dz > 0 && dollhouse[( d.y + REGION_RADIUS ) * REGION_SIZE + ( d.x + REGION_RADIUS )] ) {
            continue;
        }
        if( !tile_in_frustum( frustum, d, dz * LEVEL_HEIGHT ) ) {
            continue;
        }
        occupied.insert( p );
    }
    static std::vector<tripoint_bub_ms> creature_positions;
    creature_positions.assign( occupied.begin(), occupied.end() );
    std::sort( creature_positions.begin(), creature_positions.end(),
    []( const tripoint_bub_ms & a, const tripoint_bub_ms & b ) {
        if( a.z() != b.z() ) {
            return a.z() < b.z();
        }
        if( a.y() != b.y() ) {
            return a.y() < b.y();
        }
        return a.x() < b.x();
    } );
    g_profile.creature_positions += creature_positions.size();
    for( const tripoint_bub_ms &p : creature_positions ) {
        if( count >= MAX_DRAW_INSTANCES ) {
            return count;
        }
        const int dz = p.z() - cz;
        const float wz = dz * LEVEL_HEIGHT;
        const level_cache &cache = here.get_cache_ref( p.z() );
        const Creature *critter = tracker.creature_at( p );
        if( !critter ) {
            continue;
        }
        // the same test 2D's draw_critter_at uses: light, line of
        // sight, distance, invisibility and ALWAYS_VISIBLE are all
        // handled there; the avatar itself is always visible
        if( !you.sees( here, *critter ) ) {
            continue;
        }
        // the creature takes its tile's light tone, exactly like 2D's
        // critter sprites do through the lit shader. a creature 2D draws
        // on an otherwise invisible tile (ALWAYS_VISIBLE, special
        // vision) uses fixed lighting there, so keep it full color.
        const lit_level cll = dz > 0 ? upper_lit_at( cache, p )
                              : cache.visibility_cache[p.x()][p.y()];
        const bool cll_clear = cll == lit_level::LOW || cll == lit_level::LIT ||
                               cll == lit_level::BRIGHT;
        const tile_tone tone = cll_clear ? tone_for( cache, p, cll )
                               : tile_tone{ 1.0f, nv_tint ? 0.0f : 1.0f };
        const tripoint offset = critter->pos_world().offset() + seated_vehicle_offset( here, *critter );
        push_entity( *critter, p, p.x() - center.x() + position_fraction( offset.x ) - 0.5f,
                     p.y() - center.y() + position_fraction( offset.y ) - 0.5f,
                     wz + position_fraction( offset.z ) * LEVEL_HEIGHT, tone );
    }

    // hover preselection box + game-driven cursors (targeting, construction...):
    // a thin slab carrying the tileset's highlight/cursor sprite
    auto push_cursor_slab = [&]( const tripoint_bub_ms & tp, const char *sprite ) {
        if( count >= MAX_DRAW_INSTANCES || !here.inbounds( tp ) ) {
            return;
        }
        const tripoint_rel_ms rel = tp - center;
        sprite_info cspr;
        const bool ctex = lookup_sprite( tiles, sprite, TILE_CATEGORY::NONE, tp, cspr );
        std::vector<float> &v = bucket_for( MODE_BOX, ctex ? cspr.atlas : nullptr );
        push_instance( v, static_cast<float>( rel.x() ), static_cast<float>( rel.y() ),
                       rel.z() * LEVEL_HEIGHT + 0.002f, 1.0f, 1.0f, 0.05f, cspr, 1.0f, 1.0f, 1.0f );
        ++count;
    };
    // Mark the gameplay cell that the next forward input would enter.
    const auto has_game_cursor = [&]( const tripoint_bub_ms & tp ) {
        for( const auto &c : g_game_cursors ) {
            if( c.first == tp ) {
                return true;
            }
        }
        return false;
    };
    std::optional<tripoint_bub_ms> move_marker;
    if( !you.controlling_vehicle && upos.z() == center.z() ) {
        tripoint_bub_ms tp = upos + compass8[camera.movement.octant];
        if( avatar_action::can_move_fractional( you, here ) ) {
            const point delta = fractional_walk::camera_delta( point::north, camera.movement.forward );
            if( const auto step = fractional_walk::resolve( you.pos_world(), delta ) ) {
                const tripoint_bub_ms next = here.get_bub( step->target.tile() );
                tp = step->clears_obstacles( here, you, next ) ? next : upos;
            }
        }
        if( tp != upos && here.inbounds( tp ) && !has_game_cursor( tp ) ) {
            push_cursor_slab( tp, "line_target" );
            move_marker = tp;
        }
    }
    // a game-driven cursor is the authoritative marker (look-around, targeting,
    // the V menu's selected tile); the raw mouse hover would duplicate it, and
    // while a menu pans the view to a distant focus the stale mouse pixel would
    // sweep across the map, so skip hover whenever one is present. the hover is
    // also skipped where the movement marker already sits: two slabs at the same
    // spot would z-fight, and the movement meaning wins there.
    if( !g_mouse_captured && g_game_cursors.empty() ) {
        if( const std::optional<tripoint_bub_ms> hov = tile_at_pixel( g_last_mouse, camera, surfaces ) ) {
            if( !move_marker || *move_marker != *hov ) {
                push_cursor_slab( *hov, "highlight" );
            }
        }
    }
    for( const auto &[tp, hl] : g_game_cursors ) {
        push_cursor_slab( tp, hl ? "highlight" : "cursor" );
    }
    return count;
}

} // namespace

void note_mouse_look( const float dx, const float dy )
{
    // drag right orbits so the scene follows the cursor; the sign matches the
    // now-unmirrored camera basis (east is screen-right when facing north)
    g_yaw -= dx * 0.0032f;
    // looking down only, but nearly horizontal at the top end (~-4.6°..-80°)
    // so the sky pass is visible
    g_pitch = std::clamp( g_pitch - dy * 0.0032f, -1.40f, -0.08f );
}

void note_mouse_wheel( const float ticks )
{
    g_cam_dist = std::clamp( g_cam_dist - ticks * 1.5f, 6.0f, 30.0f );
}

bool mouse_captured()
{
    return g_mouse_captured;
}

std::optional<tripoint_bub_ms> screen_to_tile( const point &logical_pixel )
{
    g_last_mouse = logical_pixel;
    return tile_at_pixel( logical_pixel, presented_camera, presented_surfaces );
}

void push_cursor( const tripoint_bub_ms &p, const bool highlight )
{
    // consumed per frame by gather; the cap prevents unbounded growth while
    // the 3D view is not being drawn
    if( !g_available || !get_option<bool>( "RENDER3D_EXPERIMENTAL" ) ||
        g_game_cursors.size() >= 64 ) {
        return;
    }
    g_game_cursors.emplace_back( p, highlight );
}

namespace
{
// rotate a single compass step by `steps` octants (clockwise on the compass)
bool camera_rotate_step( int &dx, int &dy, const int steps )
{
    if( replay_mode == replay_mode_t::replay || !view_active() ) {
        return false;
    }
    const int idx = compass_index( point_rel_ms( dx, dy ) );
    if( idx < 0 ) {
        return false;
    }
    const point_rel_ms &w = compass8[( idx + steps + 16 ) % 8];
    dx = w.x();
    dy = w.y();
    return true;
}
} // namespace

bool camera_screen_to_map_delta( int &dx, int &dy )
{
    // screen frame -> map: the screen up direction is the camera forward
    // (octant k), screen right sits two octants clockwise of it (up x forward;
    // facing east, screen right is south), so the movement key's octant a maps
    // to k + a.
    return camera_rotate_step( dx, dy, presented_camera.movement.octant );
}

bool camera_map_to_screen_delta( int &dx, int &dy )
{
    // inverse of the above: map octant m -> key octant m - k
    return camera_rotate_step( dx, dy, -presented_camera.movement.octant );
}

std::optional<camera_input> movement_camera()
{
    if( !view_active() ) {
        return std::nullopt;
    }
    return presented_camera.movement;
}

void sync_mouse_capture( SDL_Renderer *renderer, const bool want )
{
    if( !renderer ) {
        return;
    }
    if( want == g_mouse_captured ) {
        return;
    }
    SDL_Window *win = SDL_GetRenderWindow( renderer );
    if( !win ) {
        return;
    }
    if( SDL_SetWindowRelativeMouseMode( win, want ) ) {
        g_mouse_captured = want;
    }
}

void on_renderer_created( SDL_Renderer *renderer )
{
    presented_camera = {};
    g_ctx.teardown();
    clear_sprite_lookup_cache();
    clear_orientation_cache();
    g_probed_renderer = renderer;
    if( renderer ) {
        probe( renderer );
    }
}

void on_renderer_destroyed()
{
    presented_camera = {};
    g_ctx.teardown();
    clear_sprite_lookup_cache();
    clear_orientation_cache();
    g_probed_renderer = nullptr;
    g_available = false;
    g_mouse_captured = false;
}

bool view_active()
{
    return use_tiles && g_available && get_option<bool>( "RENDER3D_EXPERIMENTAL" ) &&
           presented_camera.terrain && presented_camera.terrain.get() == &get_map();
}

bool contains_pixel( const point &logical_pixel )
{
    const SDL_FRect &rect = presented_camera.viewport;
    return logical_pixel.x >= rect.x && logical_pixel.y >= rect.y &&
           logical_pixel.x < rect.x + rect.w && logical_pixel.y < rect.y + rect.h;
}

void leave_view( SDL_Renderer *renderer )
{
    sync_mouse_capture( renderer, false );
    presented_camera = {};
    g_game_cursors.clear();
    g_last_mouse = point::north_west;
}

bool draw_terrain_window( SDL_Renderer *renderer, const SDL_FRect &dest,
                          const tripoint_bub_ms &center, cata_tiles *tiles )
{
    static int call_count = 0;
    if( call_count < 3 ) {
        ++call_count;
        write_status( "draw_terrain_window called #" + std::to_string( call_count ) +
                      " available=" + ( g_available ? std::string( "yes" ) : std::string( "no" ) ) +
                      " renderer_match=" + ( renderer == g_probed_renderer ? std::string( "yes" ) :
                                             std::string( "no" ) ) );
    }
    if( !renderer || dest.w <= 0.0f || dest.h <= 0.0f ) {
        return false;
    }
    if( renderer != g_probed_renderer ) {
        on_renderer_created( renderer );
    }
    if( !g_available ) {
        return false;
    }
    const int w = std::max( 64, static_cast<int>( dest.w ) );
    const int h = std::max( 64, static_cast<int>( dest.h ) );
    if( !ensure_targets( renderer, w, h ) ) {
        g_available = false;
        return false;
    }
    const bool profile = profiling_enabled();
    g_profile = frame_profile{};
    const Uint64 total_begin = profile_ticks( profile );
    const Uint64 memory_begin = profile_ticks( profile );

    // CCB writes map memory in map::update_map_memory during simulation. The
    // 3D renderer only prepares the all-z read window and invalidates its own
    // orientation cache when the current view inputs change.
    map &here = get_map();
    if( tiles ) {
        avatar &you = get_avatar();
        const tripoint_bub_ms upos = you.pos_bub();
        // prepare_region caches p1.z +/- fov_3d_z_range; anchoring the window
        // at z=0 makes it cover the whole rendered range
        // [-OVERMAP_DEPTH, +OVERMAP_HEIGHT] no matter which level the player is
        // on (the static_assert above keeps that invariant)
        you.prepare_map_memory_region(
            here.get_abs( tripoint_bub_ms( 0, 0, 0 ) ),
            here.get_abs( tripoint_bub_ms( MAPSIZE_X - 1, MAPSIZE_Y - 1, 0 ) ) );
        const level_cache &mem_level = here.get_cache_ref( upos.z() );
        static tripoint_bub_ms last_sweep_pos = tripoint_bub_ms( -1, -1, -1 );
        static time_point last_sweep_turn = calendar::turn_zero;
        static uint64_t last_draw_cache_revision = 0;
        static uint64_t last_visibility_generation = 0;
        const uint64_t draw_cache_revision = here.draw_cache_revision();
        if( mem_level.map_memory_sweep_pending || upos != last_sweep_pos ||
            calendar::turn != last_sweep_turn ||
            draw_cache_revision == std::numeric_limits<uint64_t>::max() ||
            draw_cache_revision != last_draw_cache_revision ||
            mem_level.visibility_generation != last_visibility_generation ) {
            clear_orientation_cache();
            last_sweep_pos = upos;
            last_sweep_turn = calendar::turn;
            last_draw_cache_revision = draw_cache_revision;
            last_visibility_generation = mem_level.visibility_generation;
        }
    }

    if( profile ) {
        g_profile.memory_ms = profile_ms( memory_begin, profile_ticks( true ) );
    }

    // The camera is needed by the gather as well as the draw. Building it here
    // lets invisible/offscreen tiles avoid map and sprite work entirely.
    const avatar &observer = get_avatar();
    const tripoint_bub_ms observer_tile = observer.pos_bub( here );
    const tripoint observer_offset = observer.pos_world().offset() + seated_vehicle_offset( here,
        observer );
    const vec3 player_position{ observer_tile.x() - center.x() + position_fraction( observer_offset.x ),
                                observer_tile.y() - center.y() + position_fraction( observer_offset.y ),
                                ( observer_tile.z() - center.z() + position_fraction( observer_offset.z ) ) *
                                LEVEL_HEIGHT
                              };
    const vec3 target = observer_tile == center ?
                        vec3{ player_position.x, player_position.y, player_position.z + 1.0f } :
                        vec3{ 0.5f, 0.5f, 1.0f };
    const vec3 dir{
        std::cos( g_pitch ) *std::cos( g_yaw ),
        std::cos( g_pitch ) *std::sin( g_yaw ),
        std::sin( g_pitch )
    };
    const vec3 eye{ target.x - dir.x * g_cam_dist,
                    target.y - dir.y * g_cam_dist,
                    target.z - dir.z * g_cam_dist };
    const mat4 view = mat4_lookat( eye, target, { 0.0f, 0.0f, 1.0f } );
    const float aspect = static_cast<float>( w ) / static_cast<float>( h );
    const mat4 proj = mat4_perspective( camera_fov, aspect, 0.05f, 300.0f );
    const mat4 mvp = mat4_mul( proj, view );
    const view_frustum frustum = make_view_frustum( mvp );

    // The picking transform travels with the image that used it, including
    // when an asynchronous submission is one frame behind current input.
    const vec3 right = vec3_normalize( vec3_cross( { 0.0f, 0.0f, 1.0f }, dir ) );
    const vec3 up = vec3_cross( dir, right );
    const pick_camera camera{ dest, eye, right, up, dir, aspect, camera_from_yaw(),
                              here.get_abs( center ), here.get_context_reference() };

    // top-down: anchor the scene to the view center (ter_view_p follows the
    // player; look-around mode pans it for free)
    g_recording_slot = nullptr;
    poll_frame_slots();
    const int slot_index = begin_frame_slot();
    if( slot_index < 0 ) {
        // Both slots are still needed. Do not gather or queue unbounded work;
        // show the newest completed image and try again next frame.
        ++g_profile.skipped_submissions;
        g_game_cursors.clear();
        if( g_ctx.latest_ready < 0 || !g_mouse_captured ) {
            // On a final/non-captured presentation, wait for the NEWEST
            // in-flight submission, not merely the first slot in the array.
            int wait_index = -1;
            for( int i = 0; i < static_cast<int>( g_ctx.slots.size() ); ++i ) {
                if( g_ctx.slots[i].state == frame_slot_state::in_flight &&
                    ( wait_index < 0 || g_ctx.slots[i].serial > g_ctx.slots[wait_index].serial ) ) {
                    wait_index = i;
                }
            }
            if( wait_index >= 0 ) {
                const Uint64 wait_begin = profile_ticks( profile );
                wait_for_frame_slot( wait_index );
                if( profile ) {
                    g_profile.wait_ms += profile_ms( wait_begin, profile_ticks( true ) );
                }
            }
        }
        const Uint64 composite_begin = profile_ticks( profile );
        const bool composited = composite_latest_frame( renderer, dest );
        if( profile ) {
            const Uint64 frame_end = profile_ticks( true );
            g_profile.composite_ms = profile_ms( composite_begin, frame_end );
            g_profile.total_ms = profile_ms( total_begin, frame_end );
        }
        publish_profile( g_profile );
        return composited;
    }
    frame_slot &slot = g_ctx.slots[slot_index];
    slot.texture_owners.clear();
    g_recording_slot = &slot;

    // Main-thread frame workspace: clear logical contents but retain capacity.
    static std::vector<instance_bucket> buckets;
    static std::vector<decal_instance> decals;
    static std::vector<decal_instance> panels;
    size_t bucket_count = 0;
    const Uint64 gather_begin = profile_ticks( profile );
    const int count = gather_instances( tiles, center, buckets, bucket_count, decals, panels,
                                        frustum, camera, slot.surfaces );
    if( profile ) {
        g_profile.gather_ms = profile_ms( gather_begin, profile_ticks( true ) );
    }
    g_game_cursors.clear();
    static bool gather_logged = false;
    if( !gather_logged ) {
        gather_logged = true;
        write_status( "first gather: instances=" + std::to_string( count ) +
                      " buckets=" + std::to_string( bucket_count ) );
    }
    g_profile.instances = count;

    // flatten the buckets into one contiguous instance upload; record segments
    const Uint64 assembly_begin = profile_ticks( profile );
    struct draw_segment {
        int mode;
        SDL_Texture *atlas;
        int first_instance;
        int num_instances;
    };
    static std::vector<draw_segment> segments;
    static std::vector<float> inst;
    segments.clear();
    inst.clear();
    inst.reserve( count * INSTANCE_STRIDE / sizeof( float ) );
    for( size_t bucket_index = 0; bucket_index < bucket_count; ++bucket_index ) {
        const instance_bucket &b = buckets[bucket_index];
        if( b.data.empty() ) {
            continue;
        }
        segments.push_back( draw_segment{ b.mode, b.atlas,
                                          static_cast<int>( inst.size() / ( INSTANCE_STRIDE / sizeof( float ) ) ),
                                          static_cast<int>( b.data.size() / ( INSTANCE_STRIDE / sizeof( float ) ) ) } );
        inst.insert( inst.end(), b.data.begin(), b.data.end() );
    }
    // decals draw after every bucket segment, as one segment per run of
    // consecutive same-(mode, atlas) instances — the stream's push order is the
    // gather's row order, so cross-atlas overlaps resolve in exactly 2D's
    // painter order (rows north->south, west->east)
    constexpr size_t stride_floats = INSTANCE_STRIDE / sizeof( float );
    for( size_t i = 0; i < decals.size(); ) {
        size_t j = i + 1;
        while( j < decals.size() && decals[j].atlas == decals[i].atlas &&
               decals[j].mode == decals[i].mode ) {
            ++j;
        }
        segments.push_back( draw_segment{ decals[i].mode, decals[i].atlas,
                                          static_cast<int>( inst.size() / stride_floats ),
                                          static_cast<int>( j - i ) } );
        for( size_t k = i; k < j; ++k ) {
            inst.insert( inst.end(), decals[k].f, decals[k].f + stride_floats );
        }
        i = j;
    }
    // vehicle side panels come after the skins, sorted far->near along the
    // camera's ground forward (the stream's painter order is camera-relative
    // here, not row order): the nearer flank's panel always overdraws the
    // farther one's, whose mirrored backface then reads as the interior view
    std::stable_sort( panels.begin(), panels.end(),
    []( const decal_instance & a, const decal_instance & b ) {
        return a.sort_key > b.sort_key;
    } );
    for( size_t i = 0; i < panels.size(); ) {
        size_t j = i + 1;
        while( j < panels.size() && panels[j].atlas == panels[i].atlas &&
               panels[j].mode == panels[i].mode ) {
            ++j;
        }
        segments.push_back( draw_segment{ panels[i].mode, panels[i].atlas,
                                          static_cast<int>( inst.size() / stride_floats ),
                                          static_cast<int>( j - i ) } );
        for( size_t k = i; k < j; ++k ) {
            inst.insert( inst.end(), panels[k].f, panels[k].f + stride_floats );
        }
        i = j;
    }

    if( profile ) {
        g_profile.assembly_ms = profile_ms( assembly_begin, profile_ticks( true ) );
    }
    g_profile.segments = segments.size();
    g_profile.upload_bytes = inst.size() * sizeof( float );

    // daylight + sun position from the game calendar. azimuth is measured FROM
    // the south, positive toward the west (calendar.cpp); scene coords are
    // x = east, y = south, z = up
    const level_cache &cache = here.get_cache_ref( center.z() );
    const float daylight = std::clamp( cache.natural_light_level_cache / LIGHT_AMBIENT_LIT,
                                       0.0f, 1.0f );
    const auto sun_aa = sun_azimuth_altitude( calendar::turn );
    const float sun_az = static_cast<float>( units::to_degrees( sun_aa.first ) ) *
                         3.14159265f / 180.0f;
    const float sun_alt = static_cast<float>( units::to_degrees( sun_aa.second ) ) *
                          3.14159265f / 180.0f;
    const vec3 sun_dir{ -std::sin( sun_az ) *std::cos( sun_alt ),
                        std::cos( sun_az ) *std::cos( sun_alt ),
                        std::sin( sun_alt ) };
    const bool sun_up = sun_alt > 0.0f && daylight > 0.05f;

    // weather-driven cloud cover: how much of the clear-sky sunlight the
    // current weather blocks. at night the ratio is meaningless; the sky is
    // dark either way, so any mid value is fine
    const weather_manager &weather = get_weather_const();
    const float clear_sun = incident_sunlight( WEATHER_CLEAR );
    const float cur_sun = incident_sunlight( weather.weather_id );
    const float cloudiness = clear_sun > 1e-3f
                             ? std::clamp( 1.0f - cur_sun / clear_sun, 0.0f, 1.0f ) : 0.5f;
    // cloud drift in noise space, following the wind
    const rl_vec2d wind_dir = convert_wind_to_coord( weather.winddirection );
    const float drift_scale = weather.windspeed * 0.01f * ( SDL_GetTicks() / 1000.0f );

    // vertex-shader uniforms: mvp + billboard basis + geometry mode + sun
    struct vert_uniforms {
        mat4 mvp;
        std::array<float, 4> cam_right;
        std::array<float, 4> cam_up;
        std::array<float, 4> params; // x = draw_mode
        std::array<float, 4> sun_dir; // xyz = toward sun, w = sun is up
    };
    vert_uniforms uniforms{};
    uniforms.mvp = mvp;
    // physical camera right on the ground plane: cross( up, forward ) with
    // up = +z (the map frame is left-handed, see mat4_lookat)
    uniforms.cam_right = { -std::sin( g_yaw ), std::cos( g_yaw ), 0.0f, 0.0f };
    uniforms.cam_up = { 0.0f, 0.0f, 1.0f, 0.0f };
    uniforms.sun_dir = { sun_dir.x, sun_dir.y, sun_dir.z, sun_up ? 1.0f : 0.0f };

    // sky pass uniforms: the camera basis reconstructs a world-space view ray
    // per pixel; the fragment shader paints gradient + sun + clouds
    struct sky_uniforms {
        std::array<float, 4> cam_right;
        std::array<float, 4> cam_up;
        std::array<float, 4> cam_forward;
        std::array<float, 4> sun_dir; // xyz = toward sun, w = daylight
        std::array<float, 4> params;  // x = tan(fov/2), y = aspect, z = cloudiness,
        // w = 1 in a night vision frame
        std::array<float, 4> wind;    // xy = cloud drift offset
    };
    const bool nv_tint = nv_tint_active();
    sky_uniforms sky_ub{};
    sky_ub.cam_right = { right.x, right.y, right.z, 0.0f };
    sky_ub.cam_up = { up.x, up.y, up.z, 0.0f };
    sky_ub.cam_forward = { dir.x, dir.y, dir.z, 0.0f };
    sky_ub.sun_dir = { sun_dir.x, sun_dir.y, sun_dir.z, daylight };
    sky_ub.params = { std::tan( camera_fov * 0.5f ), aspect, cloudiness,
                      nv_tint ? 1.0f : 0.0f
                    };
    sky_ub.wind = { wind_dir.x * drift_scale, wind_dir.y * drift_scale, 0.0f, 0.0f };

    // fragment-shader uniforms: the camera->player occlusion mask. walls and
    // roofs on the eye-to-player segment fade out with a soft dithered edge so
    // they never block the player; only box instances (terrain geometry) mask
    struct frag_uniforms {
        std::array<float, 4> eye_pos;
        std::array<float, 4> player_pos;
        std::array<float, 4> cam_right;
        std::array<float, 4> cam_up;
        std::array<float, 4> mask_params; // r_x, r_y, ground_z, enabled
        // memory-map look (2D's MEMORY_MAP_MODE): x = named preset 0..3,
        // y = 1 for the custom mixer; dark rgb + gamma, light rgb
        std::array<float, 4> memory_params;
        std::array<float, 4> memory_dark;
        std::array<float, 4> memory_light;
        // night vision look: x = 1 in an NV frame (v_color.a then carries the
        // tile light), y = night floor brightness, z = overexpose start
        std::array<float, 4> nv_params;
    };
    frag_uniforms frag_ub{};
    const float player_gz = player_position.z;
    frag_ub.eye_pos = { eye.x, eye.y, eye.z, 0.0f };
    frag_ub.player_pos = { player_position.x,
                           player_position.y,
                           player_gz + 1.0f, 0.0f
                         };
    frag_ub.cam_right = { right.x, right.y, right.z, 0.0f };
    frag_ub.cam_up = { up.x, up.y, up.z, 0.0f };
    frag_ub.mask_params = { 3.2f, 2.2f, player_gz, 1.0f };
    // same memory look 2D's lit shader uses: a named preset, else the custom
    // MEMORY_RGB_* / MEMORY_GAMMA mixer
    const cata_shader::memory_look mem_look = cata_tiles::memory_look_from_options(
                cata_shader::memory_preset_from_option_value(
                    get_option<std::string>( "MEMORY_MAP_MODE" ) ) );
    frag_ub.memory_params = { mem_look.preset ? static_cast<float>( *mem_look.preset ) : 0.0f,
                              mem_look.preset ? 0.0f : 1.0f, 0.0f, 0.0f
                            };
    frag_ub.memory_dark = { mem_look.custom_dark[0], mem_look.custom_dark[1],
                            mem_look.custom_dark[2], mem_look.custom_gamma
                          };
    frag_ub.memory_light = { mem_look.custom_light[0], mem_look.custom_light[1],
                             mem_look.custom_light[2], 0.0f
                           };
    // 2D's reference_night_rgb constants travel to the shader so the two
    // implementations cannot drift apart (nv_tint was resolved with the sky)
    frag_ub.nv_params = { nv_tint ? 1.0f : 0.0f, smooth_lighting::night_floor,
                          smooth_lighting::overexpose_start, 0.0f
                        };

    // fallback clear color when the sky pass is unavailable
    const SDL_FColor sky{ 0.02f + 0.35f * daylight, 0.02f + 0.45f * daylight,
                          0.05f + 0.65f * daylight, 1.0f };

    // Drain pending 2D batches before touching the device ourselves. This also
    // submits any earlier composite before a completed slot is reused.
    SDL_FlushRenderer( renderer );

    SDL_GPUDevice *device = g_ctx.device;
    const Uint64 record_begin = profile_ticks( profile );
    SDL_GPUCommandBuffer *cmd = SDL_AcquireGPUCommandBuffer( device );
    if( !cmd ) {
        static bool acquire_logged = false;
        if( !acquire_logged ) {
            acquire_logged = true;
            write_status( "acquire command buffer failed: " + std::string( SDL_GetError() ) );
        }
        DebugLog( D_ERROR, DC_ALL ) << "render3d: acquire command buffer failed: " << SDL_GetError();
        slot.state = frame_slot_state::empty;
        slot.texture_owners.clear();
        g_recording_slot = nullptr;
        const bool composited = composite_latest_frame( renderer, dest );
        if( profile ) {
            g_profile.total_ms = profile_ms( total_begin, profile_ticks( true ) );
        }
        publish_profile( g_profile );
        return composited;
    }

    // upload instance data. A fully culled scene still renders the sky/clear,
    // but must not create a zero-sized transfer buffer or upload.
    const Uint64 upload_begin = profile_ticks( profile );
    SDL_GPUTransferBuffer *tb = nullptr;
    bool upload_ok = true;
    if( !inst.empty() ) {
        const size_t bytes = inst.size() * sizeof( float );
        if( bytes > slot.instance_tb_size ) {
            // begin_frame_slot only reuses a slot whose previous submission
            // completed, so growing its upload buffer cannot race that upload.
            if( slot.instance_tb ) {
                SDL_ReleaseGPUTransferBuffer( device, slot.instance_tb );
                slot.instance_tb = nullptr;
                slot.instance_tb_size = 0;
            }
            size_t new_size = 64 * 1024;
            while( new_size < bytes ) {
                new_size *= 2;
            }
            SDL_GPUTransferBufferCreateInfo ti{};
            ti.usage = SDL_GPU_TRANSFERBUFFERUSAGE_UPLOAD;
            ti.size = static_cast<Uint32>( new_size );
            slot.instance_tb = SDL_CreateGPUTransferBuffer( device, &ti );
            if( slot.instance_tb ) {
                slot.instance_tb_size = new_size;
            }
        }
        tb = slot.instance_tb;
        if( tb ) {
            void *mapped = SDL_MapGPUTransferBuffer( device, tb, false );
            if( mapped ) {
                std::memcpy( mapped, inst.data(), inst.size() * sizeof( float ) );
                SDL_UnmapGPUTransferBuffer( device, tb );
                SDL_GPUCopyPass *copy = SDL_BeginGPUCopyPass( cmd );
                SDL_GPUTransferBufferLocation src{};
                src.transfer_buffer = tb;
                src.offset = 0;
                SDL_GPUBufferRegion dst{};
                dst.buffer = slot.instance_vb;
                dst.offset = 0;
                dst.size = inst.size() * sizeof( float );
                SDL_UploadToGPUBuffer( copy, &src, &dst, false );
                SDL_EndGPUCopyPass( copy );
            } else {
                upload_ok = false;
            }
        } else {
            upload_ok = false;
        }
    }
    if( profile ) {
        g_profile.upload_ms = profile_ms( upload_begin, profile_ticks( true ) );
    }
    const auto discard_submission = [&]() {
        SDL_CancelGPUCommandBuffer( cmd );
        slot.state = frame_slot_state::empty;
        slot.texture_owners.clear();
        g_recording_slot = nullptr;
        if( profile ) {
            g_profile.total_ms = profile_ms( total_begin, profile_ticks( true ) );
        }
        publish_profile( g_profile );
        return composite_latest_frame( renderer, dest );
    };
    if( !upload_ok ) {
        static bool upload_failure_logged = false;
        if( !upload_failure_logged ) {
            upload_failure_logged = true;
            write_status( "instance upload failed; discarding incomplete 3D frame" );
        }
        return discard_submission();
    }

    // pass 1: the world clears color/depth and writes all scene geometry.
    SDL_GPUColorTargetInfo color_target{};
    color_target.texture = slot.color_tex;
    color_target.load_op = SDL_GPU_LOADOP_CLEAR;
    color_target.store_op = SDL_GPU_STOREOP_STORE;
    color_target.clear_color = sky;
    SDL_GPUDepthStencilTargetInfo depth_target{};
    depth_target.texture = slot.depth_tex;
    depth_target.load_op = SDL_GPU_LOADOP_CLEAR;
    depth_target.store_op = g_ctx.sky_pipeline ? SDL_GPU_STOREOP_STORE : SDL_GPU_STOREOP_DONT_CARE;
    depth_target.clear_depth = 1.0f;

    SDL_GPURenderPass *pass = SDL_BeginGPURenderPass( cmd, &color_target, 1, &depth_target );
    if( !pass ) {
        return discard_submission();
    }
    SDL_BindGPUGraphicsPipeline( pass, g_ctx.pipeline );
    SDL_GPUBufferBinding inst_bind{};
    inst_bind.buffer = slot.instance_vb;
    inst_bind.offset = 0;
    SDL_GPUGraphicsPipeline *bound_pipeline = g_ctx.pipeline;
    for( const draw_segment &seg : segments ) {
        // decals draw with the depth-write-off pipeline: painter's order
        // (instance order = 2D's row order) resolves decal-vs-decal overlaps,
        // so coplanar vehicle part sprites can never z-fight
        const bool decal_seg = seg.mode == MODE_FLATQUAD_DECAL ||
                               seg.mode == MODE_LINEQUAD_DECAL;
        SDL_GPUGraphicsPipeline *want = decal_seg ? g_ctx.pipeline_decal : g_ctx.pipeline;
        if( want != bound_pipeline ) {
            SDL_BindGPUGraphicsPipeline( pass, want );
            bound_pipeline = want;
        }
        SDL_GPUBufferBinding geom_bind{};
        int verts_per_instance = 36;
        if( seg.mode == MODE_XQUAD ) {
            geom_bind.buffer = g_ctx.xquad_vb;
            verts_per_instance = 12;
        } else if( seg.mode == MODE_FLATQUAD || seg.mode == MODE_FLATQUAD_DECAL ) {
            geom_bind.buffer = g_ctx.flatquad_vb;
            verts_per_instance = 6;
        } else if( seg.mode == MODE_BILLBOARD || seg.mode == MODE_BILLBOARD_SNAP ||
                   seg.mode == MODE_LINEQUAD || seg.mode == MODE_LINEQUAD_DECAL ) {
            geom_bind.buffer = g_ctx.quad_vb;
            verts_per_instance = 6;
        } else {
            geom_bind.buffer = g_ctx.cube_vb;
        }
        const SDL_GPUBufferBinding vbs[2] = { geom_bind, inst_bind };
        SDL_BindGPUVertexBuffers( pass, 0, vbs, 2 );
        SDL_GPUTexture *atlas_gpu = seg.atlas ? gpu_texture_of( seg.atlas ) : g_ctx.fallback_tex;
        SDL_GPUTextureSamplerBinding sampler_bind{};
        sampler_bind.texture = atlas_gpu ? atlas_gpu : g_ctx.fallback_tex;
        sampler_bind.sampler = g_ctx.sampler;
        SDL_BindGPUFragmentSamplers( pass, 0, &sampler_bind, 1 );
        // decal modes share their geometry path with the plain modes
        // (6 -> flatquad 5, 7 -> fence linequad 4); the shader never sees them
        const int shader_mode = seg.mode == MODE_FLATQUAD_DECAL ? MODE_FLATQUAD :
                                seg.mode == MODE_LINEQUAD_DECAL ? MODE_LINEQUAD : seg.mode;
        uniforms.params = { static_cast<float>( shader_mode ), 0.0f, 0.0f, 0.0f };
        SDL_PushGPUVertexUniformData( cmd, 0, &uniforms, sizeof( uniforms ) );
        // the camera->player occlusion mask covers terrain geometry (boxes),
        // fence quads (incl. low thin obstacles like downspouts), vehicle side
        // panels (the mask cuts a soft hole so the rider stays visible) and the
        // flat floor quads (roof corner cutouts above the player)
        frag_ub.mask_params[3] = ( seg.mode == MODE_BOX || seg.mode == MODE_LINEQUAD ||
                                   seg.mode == MODE_FLATQUAD ||
                                   seg.mode == MODE_LINEQUAD_DECAL )
                                 ? 1.0f : 0.0f;
        SDL_PushGPUFragmentUniformData( cmd, 0, &frag_ub, sizeof( frag_ub ) );
        SDL_DrawGPUPrimitives( pass, verts_per_instance, seg.num_instances, 0, seg.first_instance );
    }
    SDL_EndGPURenderPass( pass );

    // pass 2: sky only where the world left depth at 1. The color and depth
    // contents are loaded, and the far-depth sky shader never writes depth.
    if( g_ctx.sky_pipeline ) {
        SDL_GPUColorTargetInfo sky_target{};
        sky_target.texture = slot.color_tex;
        sky_target.load_op = SDL_GPU_LOADOP_LOAD;
        sky_target.store_op = SDL_GPU_STOREOP_STORE;
        SDL_GPUDepthStencilTargetInfo sky_depth{};
        sky_depth.texture = slot.depth_tex;
        sky_depth.load_op = SDL_GPU_LOADOP_LOAD;
        sky_depth.store_op = SDL_GPU_STOREOP_DONT_CARE;
        SDL_GPURenderPass *sky_pass = SDL_BeginGPURenderPass( cmd, &sky_target, 1, &sky_depth );
        if( !sky_pass ) {
            return discard_submission();
        }
        SDL_BindGPUGraphicsPipeline( sky_pass, g_ctx.sky_pipeline );
        SDL_PushGPUFragmentUniformData( cmd, 0, &sky_ub, sizeof( sky_ub ) );
        SDL_DrawGPUPrimitives( sky_pass, 3, 1, 0, 0 );
        SDL_EndGPURenderPass( sky_pass );
    }

    if( profile ) {
        g_profile.record_ms = profile_ms( record_begin, profile_ticks( true ) );
    }
    SDL_GPUFence *fence = SDL_SubmitGPUCommandBufferAndAcquireFence( cmd );
    if( !fence ) {
        static bool submit_logged = false;
        if( !submit_logged ) {
            submit_logged = true;
            write_status( "submit failed: " + std::string( SDL_GetError() ) );
        }
        DebugLog( D_ERROR, DC_ALL ) << "render3d: submit failed: " << SDL_GetError();
        slot.state = frame_slot_state::empty;
        slot.texture_owners.clear();
        g_recording_slot = nullptr;
        const bool composited = composite_latest_frame( renderer, dest );
        if( profile ) {
            g_profile.total_ms = profile_ms( total_begin, profile_ticks( true ) );
        }
        publish_profile( g_profile );
        return composited;
    }
    slot.camera = camera;
    slot.fence = fence;
    slot.state = frame_slot_state::in_flight;
    g_recording_slot = nullptr;

    // Camera drags stay asynchronous. A non-captured frame (notably the middle
    // button release) is a final presentation: wait for its own submission so
    // the view cannot stop one completed frame behind the requested angle.
    poll_frame_slots();
    if( g_ctx.latest_ready < 0 || !g_mouse_captured ) {
        const Uint64 wait_begin = profile_ticks( profile );
        wait_for_frame_slot( slot_index );
        if( profile ) {
            g_profile.wait_ms += profile_ms( wait_begin, profile_ticks( true ) );
        }
    }

    const Uint64 composite_begin = profile_ticks( profile );
    const bool composited = composite_latest_frame( renderer, dest );
    if( profile ) {
        const Uint64 frame_end = profile_ticks( true );
        g_profile.composite_ms = profile_ms( composite_begin, frame_end );
        g_profile.total_ms = profile_ms( total_begin, frame_end );
    }
    publish_profile( g_profile );

    static bool first_draw_logged = false;
    if( !first_draw_logged && composited ) {
        first_draw_logged = true;
        write_status( "drawing: first frame composited, instances=" + std::to_string( count ) );
    }
    return composited;
}

} // namespace render3d

#endif // TILES
