#include "render3d.h"

#if defined(TILES)

#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <map>
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
#include "shadowcasting.h"
#include "smooth_lighting.h"
#include "submap.h"
#include "weather.h"
#include "weather_type.h"

namespace render3d
{

namespace
{

// P0: a square region around the view center, single z-level.
constexpr int REGION_RADIUS = 24;
constexpr int REGION_SIZE = REGION_RADIUS * 2 + 1;
// full view distance (MAX_VIEW_DISTANCE): the far ring beyond REGION_RADIUS is
// drawn on the view level only, the near region renders all z-levels
constexpr int VIEW_RADIUS = 60;
constexpr int VIEW_SIZE = VIEW_RADIUS * 2 + 1;
// cross-level rendering: all z-levels stacked LEVEL_HEIGHT apart
// (the near ±24 region renders every level; the far ring draws the view level only)
// a tile can yield up to 6 instances (floor + object + furniture + creature + item + item highlight)
constexpr int MAX_DRAW_INSTANCES = VIEW_SIZE * VIEW_SIZE * 6 +
                                   REGION_SIZE * REGION_SIZE * 6 * ( OVERMAP_DEPTH + OVERMAP_HEIGHT );
// float3 pos + float3 scale + float2 uv0 + float2 uv1 + float4 color + float flags + float pad
constexpr int INSTANCE_STRIDE = 64;

constexpr float LEVEL_HEIGHT = 2.6f;
constexpr float FLOOR_THICK = 0.1f;
// walls stop just under the next level's floor slab (slab bottom is
// LEVEL_HEIGHT - FLOOR_THICK) so the two never intersect and z-fight
constexpr float WALL_HEIGHT = LEVEL_HEIGHT - FLOOR_THICK - 0.01f;
constexpr float TREE_HEIGHT = 3.0f;
constexpr float SHRUB_HEIGHT = 0.9f;
constexpr float FURN_QUAD_HEIGHT = 1.2f;
constexpr float PANEL_HEIGHT = 1.4f;
constexpr float PANEL_THICK = 0.1f;
constexpr float FENCE_HEIGHT = 1.5f;
constexpr float FENCE_THICK = 0.15f;
constexpr float CREATURE_BASE_HEIGHT = 1.8f;
constexpr float ITEM_HEIGHT = 0.5f;
// fields: liquid/solid traces (blood, bile, acid, web...) draw as thin decals
// just above the floor; gas/plasma effects (smoke, fire, gas...) draw as
// camera-facing billboards. Co-tile entries stagger so they never share a plane.
constexpr float FIELD_DECAL_Z = 0.001f;
constexpr float FIELD_DECAL_STAGGER = 0.0003f;
constexpr float FIELD_RISER_HEIGHT = 1.4f;
constexpr float FIELD_RISER_OFFSET = 0.008f;

// the whole rendered z range must be inside map memory's prepared region; the
// prepare call below anchors that region's z window at 0 (see draw_terrain_window)
static_assert( fov_3d_z_range >= OVERMAP_DEPTH && fov_3d_z_range >= OVERMAP_HEIGHT,
               "map memory region must cover every rendered z-level" );

// geometry kind of an instance batch (matches `params.x` in terrain3d.vert)
enum draw_mode : int {
    MODE_BOX = 0,      // unit cube (floors, walls)
    MODE_XQUAD = 1,    // two static crossed quads (trees)
    MODE_BILLBOARD = 2, // yaw-only camera-facing quad (creatures, items)
    MODE_BILLBOARD_SNAP = 3, // billboard snapped to the nearest cardinal axis (furniture)
    MODE_LINEQUAD = 4,  // flat vertical quad on a fixed axis (fences); pad = run direction
    MODE_FLATQUAD = 5   // flat horizontal quad (floor overlays, cutout floor tiles)
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

struct vec3 {
    float x, y, z;
};

vec3 vec3_sub( const vec3 &a, const vec3 &b )
{
    return { a.x - b.x, a.y - b.y, a.z - b.z };
}

vec3 vec3_cross( const vec3 &a, const vec3 &b )
{
    return { a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x };
}

vec3 vec3_normalize( const vec3 &v )
{
    const float len = std::sqrt( v.x * v.x + v.y * v.y + v.z * v.z );
    return len > 0.0f ? vec3{ v.x / len, v.y / len, v.z / len } : vec3{ 0, 0, 1 };
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

// Unit cube, corner at origin, spanning [0,1]^3; 36 verts, pos(3f) + normal(3f).
const std::array<float, 36 * 6> &cube_vertices()
{
    static const std::array<float, 36 * 6> verts = [] {
        std::array<float, 36 * 6> v{};
        // face: origin corner, two edge vectors, normal
        const float faces[6][4][3] = {
            { {0, 0, 0}, {1, 0, 0}, {0, 1, 0}, {0, 0, -1} }, // bottom (z-)
            { {0, 0, 1}, {1, 0, 1}, {0, 1, 1}, {0, 0, 1} },  // top (z+)
            { {0, 0, 0}, {1, 0, 0}, {0, 0, 1}, {0, -1, 0} }, // south (y-)
            { {0, 1, 0}, {1, 1, 0}, {0, 1, 1}, {0, 1, 0} },  // north (y+)
            { {0, 0, 0}, {0, 1, 0}, {0, 0, 1}, { -1, 0, 0} }, // west (x-)
            { {1, 0, 0}, {1, 1, 0}, {1, 0, 1}, {1, 0, 0} },  // east (x+)
        };
        int i = 0;
        for( const auto &f : faces ) {
            const vec3 o{ f[0][0], f[0][1], f[0][2] };
            const vec3 e1{ f[1][0] - o.x, f[1][1] - o.y, f[1][2] - o.z };
            const vec3 e2{ f[2][0] - o.x, f[2][1] - o.y, f[2][2] - o.z };
            const vec3 n{ f[3][0], f[3][1], f[3][2] };
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

struct context {
    SDL_GPUDevice *device = nullptr; // owned by the SDL_Renderer
    SDL_GPUGraphicsPipeline *pipeline = nullptr;
    SDL_GPUGraphicsPipeline *sky_pipeline = nullptr; // fullscreen sky pass (no VBs, no depth)
    SDL_GPUBuffer *cube_vb = nullptr;
    SDL_GPUBuffer *xquad_vb = nullptr;
    SDL_GPUBuffer *quad_vb = nullptr;
    SDL_GPUBuffer *flatquad_vb = nullptr;
    SDL_GPUBuffer *instance_vb = nullptr;
    SDL_GPUSampler *sampler = nullptr;
    SDL_GPUTexture *fallback_tex = nullptr; // 1x1 white, bound when a batch has no atlas
    SDL_GPUTexture *color_tex = nullptr; // wrapped by color_tex_sdl, do not release directly
    SDL_GPUTexture *depth_tex = nullptr;
    SDL_Texture *color_tex_sdl = nullptr; // renderer-side wrapper of color_tex
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
bool g_available = false;
SDL_Renderer *g_probed_renderer = nullptr;

// top-down orbit camera state (persisted across frames and turns)
float g_yaw = 0.78539816f;   // radians, 0 = +x (east)
float g_pitch = -0.96f;      // radians, negative = looking down
float g_cam_dist = 14.0f;    // orbit distance in meters
bool g_mouse_captured = false;

// cached frame state for screen_to_tile + the hover preselection box
SDL_FRect g_dest = { 0.0f, 0.0f, 0.0f, 0.0f };
vec3 g_eye{ 0.0f, 0.0f, 0.0f };
vec3 g_basis_r{ 1.0f, 0.0f, 0.0f };
vec3 g_basis_u{ 0.0f, 1.0f, 0.0f };
vec3 g_basis_f{ 0.0f, 0.0f, 1.0f };
float g_fov_y = 40.0f * 3.14159265f / 180.0f;
float g_aspect = 1.0f;
tripoint_bub_ms g_center;
bool g_cam_valid = false;
point g_last_mouse{ -1, -1 };
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
int camera_forward_octant()
{
    const float bearing = std::atan2( std::cos( g_yaw ), -std::sin( g_yaw ) );
    int k = static_cast<int>( std::lround( bearing / ( 3.14159265f / 4.0f ) ) ) % 8;
    return k < 0 ? k + 8 : k;
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

void context::teardown()
{
    if( !device ) {
        return;
    }
    if( color_tex_sdl ) {
        // Destroying the wrapper does not own the wrapped GPU texture (the
        // renderer only wraps it), so release the GPU texture ourselves.
        SDL_DestroyTexture( color_tex_sdl );
        color_tex_sdl = nullptr;
    }
    if( glyph_tex ) {
        SDL_DestroyTexture( glyph_tex );
        glyph_tex = nullptr;
    }
    if( color_tex ) {
        SDL_ReleaseGPUTexture( device, color_tex );
        color_tex = nullptr;
    }
    if( fallback_tex ) {
        SDL_ReleaseGPUTexture( device, fallback_tex );
        fallback_tex = nullptr;
    }
    if( sampler ) {
        SDL_ReleaseGPUSampler( device, sampler );
        sampler = nullptr;
    }
    if( depth_tex ) {
        SDL_ReleaseGPUTexture( device, depth_tex );
        depth_tex = nullptr;
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
    if( instance_vb ) {
        SDL_ReleaseGPUBuffer( device, instance_vb );
        instance_vb = nullptr;
    }
    if( pipeline ) {
        SDL_ReleaseGPUGraphicsPipeline( device, pipeline );
        pipeline = nullptr;
    }
    if( sky_pipeline ) {
        SDL_ReleaseGPUGraphicsPipeline( device, sky_pipeline );
        sky_pipeline = nullptr;
    }
    device = nullptr;
}

bool ensure_targets( SDL_Renderer *renderer, const int w, const int h )
{
    if( g_ctx.color_tex && g_ctx.tex_w == w && g_ctx.tex_h == h ) {
        return true;
    }
    if( g_ctx.color_tex_sdl ) {
        SDL_DestroyTexture( g_ctx.color_tex_sdl );
        g_ctx.color_tex_sdl = nullptr;
    }
    if( g_ctx.color_tex ) {
        SDL_ReleaseGPUTexture( g_ctx.device, g_ctx.color_tex );
        g_ctx.color_tex = nullptr;
    }
    if( g_ctx.depth_tex ) {
        SDL_ReleaseGPUTexture( g_ctx.device, g_ctx.depth_tex );
        g_ctx.depth_tex = nullptr;
    }

    SDL_GPUTextureCreateInfo ci{};
    ci.type = SDL_GPU_TEXTURETYPE_2D;
    ci.format = SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UNORM;
    ci.usage = SDL_GPU_TEXTUREUSAGE_COLOR_TARGET | SDL_GPU_TEXTUREUSAGE_SAMPLER;
    ci.width = static_cast<Uint32>( w );
    ci.height = static_cast<Uint32>( h );
    ci.layer_count_or_depth = 1;
    ci.num_levels = 1;
    ci.sample_count = SDL_GPU_SAMPLECOUNT_1;
    g_ctx.color_tex = SDL_CreateGPUTexture( g_ctx.device, &ci );
    if( !g_ctx.color_tex ) {
        write_status( "ensure_targets failed: color target: " + std::string( SDL_GetError() ) );
        DebugLog( D_ERROR, DC_ALL ) << "render3d: color target creation failed: " << SDL_GetError();
        return false;
    }

    ci.format = SDL_GPU_TEXTUREFORMAT_D32_FLOAT;
    ci.usage = SDL_GPU_TEXTUREUSAGE_DEPTH_STENCIL_TARGET;
    g_ctx.depth_tex = SDL_CreateGPUTexture( g_ctx.device, &ci );
    if( !g_ctx.depth_tex ) {
        write_status( "ensure_targets failed: depth target: " + std::string( SDL_GetError() ) );
        DebugLog( D_ERROR, DC_ALL ) << "render3d: depth target creation failed: " << SDL_GetError();
        return false;
    }

    SDL_PropertiesID props = SDL_CreateProperties();
    SDL_SetPointerProperty( props, SDL_PROP_TEXTURE_CREATE_GPU_TEXTURE_POINTER, g_ctx.color_tex );
    SDL_SetNumberProperty( props, SDL_PROP_TEXTURE_CREATE_FORMAT_NUMBER, SDL_PIXELFORMAT_ABGR8888 );
    SDL_SetNumberProperty( props, SDL_PROP_TEXTURE_CREATE_WIDTH_NUMBER, w );
    SDL_SetNumberProperty( props, SDL_PROP_TEXTURE_CREATE_HEIGHT_NUMBER, h );
    SDL_SetNumberProperty( props, SDL_PROP_TEXTURE_CREATE_ACCESS_NUMBER,
                           SDL_TEXTUREACCESS_STATIC );
    g_ctx.color_tex_sdl = SDL_CreateTextureWithProperties( renderer, props );
    SDL_DestroyProperties( props );
    if( !g_ctx.color_tex_sdl ) {
        write_status( "ensure_targets failed: texture wrap: " + std::string( SDL_GetError() ) );
        DebugLog( D_ERROR, DC_ALL ) << "render3d: wrapping GPU texture failed: " << SDL_GetError();
        return false;
    }
    SDL_SetTextureScaleMode( g_ctx.color_tex_sdl, SDL_SCALEMODE_LINEAR );

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
        int minx = 0, maxx = 0, miny = 0, maxy = 0, advance = 0;
        TTF_GetGlyphMetrics( font, c, &minx, &maxx, &miny, &maxy, &advance );
        SDL_Surface *g = TTF_RenderGlyph_Blended( font, c, white );
        if( !g ) {
            continue;
        }
        SDL_Rect dst{ ( c - 32 ) % cols * cell_w + ( cell_w - advance ) / 2 + minx,
                      ( c - 32 ) / cols * cell_h + ascent - maxy, g->w, g->h };
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

    SDL_GPUVertexBufferDescription vb_descs[2]{};
    vb_descs[0].slot = 0;
    vb_descs[0].pitch = 6 * sizeof( float );
    vb_descs[0].input_rate = SDL_GPU_VERTEXINPUTRATE_VERTEX;
    vb_descs[1].slot = 1;
    vb_descs[1].pitch = INSTANCE_STRIDE;
    vb_descs[1].input_rate = SDL_GPU_VERTEXINPUTRATE_INSTANCE;

    SDL_GPUVertexAttribute attrs[9]{};
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
    SDL_ReleaseGPUShader( device, vs );
    SDL_ReleaseGPUShader( device, fs );
    if( !g_ctx.pipeline ) {
        DebugLog( D_ERROR, DC_ALL ) << "render3d: pipeline creation failed: " << SDL_GetError();
        write_status( "unavailable: pipeline creation failed: " + std::string( SDL_GetError() ) );
        g_ctx.teardown();
        return false;
    }

    // sky pass pipeline: a fullscreen triangle (no vertex buffers, no depth),
    // drawn before the world pass so the sky shows wherever no geometry covers.
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
        spi.target_info.num_color_targets = 1;
        SDL_GPUColorTargetDescription scolor_desc{};
        scolor_desc.format = SDL_GPU_TEXTUREFORMAT_R8G8B8A8_UNORM;
        spi.target_info.color_target_descriptions = &scolor_desc;
        spi.target_info.has_depth_stencil_target = false;
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
    // (a fence corner with furniture + items) can push several past it
    bi.size = ( MAX_DRAW_INSTANCES + 64 ) * INSTANCE_STRIDE;
    g_ctx.instance_vb = SDL_CreateGPUBuffer( device, &bi );
    if( !g_ctx.cube_vb || !g_ctx.xquad_vb || !g_ctx.quad_vb || !g_ctx.flatquad_vb ||
        !g_ctx.instance_vb ) {
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
    float rr = 0.0f, gg = 0.0f, bb = 0.0f;
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
    // opaque-cropped uv, used ONLY by the ground layer: big-section sprites
    // (giant.png trees etc.) are larger than one tile with transparent padding
    // which 2D hides via anchoring; a no-discard floor would show the padding
    // as black margins, so the floor samples just the opaque bounds
    float gu0 = 0.0f, gv0 = 0.0f, gu1 = 0.0f, gv1 = 0.0f;
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

// a solid wall whose sprite can clamp a door/window panel (sill + lintel) or
// back a doorway's lintel: WALL-flagged, impassable, never a panel or a fence
bool wall_terrain( const ter_t &t )
{
    return t.movecost == 0 && t.has_flag( ter_furn_flag::TFLAG_WALL ) &&
           !door_or_window( t ) &&
           !t.has_flag( ter_furn_flag::TFLAG_THIN_OBSTACLE );
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

// map-memory sprite lookups repeat heavily (floors, walls, roads); cache the
// single-variant ones for the frame. multi-variant tiles keep their per-tile
// variant seed, so they resolve every time and stay varied.
struct memory_lookup_key {
    std::string_view id;
    int category = 0;
    int subtile = 0;
    int rota = 0;
    int force = 0;
    bool operator==( const memory_lookup_key &o ) const {
        return category == o.category && subtile == o.subtile && rota == o.rota &&
               force == o.force && id == o.id;
    }
};

struct memory_lookup_hash {
    size_t operator()( const memory_lookup_key &k ) const {
        size_t h = std::hash<std::string_view>{}( k.id );
        h = h * 1000003u + static_cast<size_t>( k.category );
        h = h * 1000003u + static_cast<size_t>( k.subtile );
        h = h * 1000003u + static_cast<size_t>( k.rota );
        h = h * 1000003u + static_cast<size_t>( k.force );
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

bool lookup_sprite_layers_3d( cata_tiles *tiles, const std::string &id,
                              const TILE_CATEGORY cat, const tripoint_bub_ms &p,
                              const int subtile, const int rota, const bool force_rota,
                              sprite_lookup_3d &out )
{
    out = sprite_lookup_3d{};
    if( !tiles ) {
        return false;
    }
    sprite_layers_3d layers;
    tiles->resolve_sprite_layers_3d( id, cat, p, subtile, rota, force_rota, layers );
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

void push_instance( std::vector<float> &out, const float dx, const float dy,
                    const float z, const float sx, const float sy, const float sz,
                    const sprite_info &spr, const float r, const float g, const float b,
                    const bool no_discard = false, const int rota4 = 0,
                    const bool side_strip = false, const float pad_value = -1.0f,
                    const bool ghost = false, const float saturation = 1.0f,
                    const bool memory = false, const bool soft_alpha = false )
{
    out.push_back( dx );
    out.push_back( dy );
    out.push_back( z );
    out.push_back( sx );
    out.push_back( sy );
    out.push_back( sz );
    out.push_back( spr.u0 );
    out.push_back( spr.v0 );
    out.push_back( spr.u1 );
    out.push_back( spr.v1 );
    out.push_back( r );
    out.push_back( g );
    out.push_back( b );
    // color alpha carries the tile light's saturation (1 = full color,
    // 0 = grayscale), matching 2D's lit shader low-light drain
    out.push_back( saturation );
    // bit0: textured, bit1: no alpha cutout (ground layer),
    // bit2-3: top-face uv quarter turns, bit4: side faces sample the
    // horizontal strip at pad (the sprite's opaque bottom edge),
    // bit5: ghost — dithered 50% transparency (levels above an indoor column),
    // bit6: memory — map-memory look, unlit (2D leaves remembered tiles
    // unlit and recolors them through the MEMORY_MAP_MODE preset),
    // bit7: soft alpha — dithered translucency proportional to the sampled
    // alpha, for field sprites whose semi-transparent pixels 2D would blend
    // pad: side-strip v, or the run direction for MODE_LINEQUAD (0 = E-W)
    out.push_back( ( spr.atlas ? 1.0f : 0.0f ) + ( no_discard ? 2.0f : 0.0f ) +
                   static_cast<float>( ( rota4 & 3 ) << 2 ) + ( side_strip ? 16.0f : 0.0f ) +
                   ( ghost ? 32.0f : 0.0f ) + ( memory ? 64.0f : 0.0f ) +
                   ( soft_alpha ? 128.0f : 0.0f ) );
    out.push_back( pad_value >= 0.0f ? pad_value
                   : ( side_strip ? spr.v1 - 0.02f * ( spr.v1 - spr.v0 ) : 0.0f ) );
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

// unproject a logical pixel through the cached camera onto the view level's
// ground plane (z = 0 in scene space)
std::optional<tripoint_bub_ms> tile_at_pixel( const point &logical_pixel )
{
    if( !g_cam_valid || g_dest.w <= 0.0f || g_dest.h <= 0.0f ) {
        return std::nullopt;
    }
    const float nx = ( ( logical_pixel.x - g_dest.x ) / g_dest.w ) * 2.0f - 1.0f;
    const float ny = 1.0f - ( ( logical_pixel.y - g_dest.y ) / g_dest.h ) * 2.0f;
    const float tan_half = std::tan( g_fov_y * 0.5f );
    const vec3 ray{
        g_basis_r.x * nx * tan_half * g_aspect + g_basis_u.x * ny * tan_half + g_basis_f.x,
        g_basis_r.y * nx * tan_half * g_aspect + g_basis_u.y * ny * tan_half + g_basis_f.y,
        g_basis_r.z * nx * tan_half * g_aspect + g_basis_u.z * ny * tan_half + g_basis_f.z
    };
    if( ray.z >= -1e-5f ) {
        return std::nullopt;
    }
    const float t = -g_eye.z / ray.z;
    const float wx = g_eye.x + ray.x * t;
    const float wy = g_eye.y + ray.y * t;
    return g_center + tripoint( static_cast<int>( std::floor( wx ) ),
                                static_cast<int>( std::floor( wy ) ), 0 );
}

// 2D's nv_color_active: night vision devices worn and the green overlay not
// switched off. the vision-range bonus (get_vision_threshold) already feeds
// the 3D visibility cache, so only the color transform is missing here.
bool nv_tint_active()
{
    return get_avatar().get_vision_modes()[NV_GOGGLES] &&
           get_option<bool>( "NV_GREEN_TOGGLE" );
}

int gather_instances( cata_tiles *tiles, const tripoint_bub_ms &center,
                      std::vector<instance_bucket> &buckets )
{
    map &here = get_map();
    buckets.clear();
    std::map<std::pair<int, SDL_Texture *>, size_t> bucket_index;
    auto bucket_for = [&]( const int mode, SDL_Texture * atlas ) -> std::vector<float> & {
        const auto key = std::make_pair( mode, atlas );
        const auto it = bucket_index.find( key );
        if( it != bucket_index.end() ) {
            return buckets[it->second].data;
        }
        bucket_index[key] = buckets.size();
        buckets.push_back( instance_bucket{ mode, atlas, {} } );
        return buckets.back().data;
    };
    // total instances pushed (all kinds), capped at the buffer capacity
    int count = 0;
    // camera forward on the ground plane, to stack the item highlight behind the item
    const float fwd_x = std::cos( g_yaw );
    const float fwd_y = std::sin( g_yaw );

    const int cz = center.z();
    const tripoint_bub_ms upos = get_avatar().pos_bub();
    const level_cache &center_cache = here.get_cache_ref( cz );
    // update_visibility_cache refreshes exactly [lowest_vision_level, center.z];
    // visibility caches outside that range are stale (same formula as
    // map::lowest_vision_level)
    const int lowest_vis_z = std::max( std::min( cz, upos.z() - fov_3d_z_range ),
                                       -OVERMAP_DEPTH );
    // per-tile visibility, exactly when 2D draws the real tile: LOW/LIT/BRIGHT
    // are the lit levels map::get_visibility maps to CLEAR. everything else
    // draws memory or a vision-effect tile in 2D, so 3D must not show it
    const auto tile_visible = []( const level_cache &c, const tripoint_bub_ms &q ) {
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
            ( 1.0f - smooth_lighting::shadow_shade ) * light,
            nv_tint ? std::clamp( light, 0.0f, 1.0f ) : t * t * ( 3.0f - 2.0f * t ) };
    };
    const visibility_variables &vis_vars = here.get_visibility_variables_cache();
    // upper levels are not refreshed by update_visibility_cache (it stops at
    // center.z), so their lit level is computed on the spot with
    // map::apparent_light_at, the same function the 2D visibility cache is
    // built from. a tile no avatar/camera cast reached and no clairvoyance can
    // light is certainly invisible; this also keeps upper levels, which the
    // cast hides behind their own floor/roof (shadowcasting floor_block),
    // nearly free.
    const auto upper_lit_at = [&]( const level_cache &c, const tripoint_bub_ms &q ) {
        if( c.seen_cache[q.x()][q.y()] <= 0.0f && c.camera_cache[q.x()][q.y()] <= 0.0f &&
            vis_vars.u_clairvoyance <= 0 && !vis_vars.clairvoyance_field ) {
            return lit_level::BLANK;
        }
        return here.apparent_light_at( q, vis_vars );
    };
    // tile light tone from its lit level, the same model 2D's smooth lighting
    // uses (smooth_lighting::classify_light_cell + data/shaders/lit.frag)
    const auto tone_for = [&]( const level_cache &c, const tripoint_bub_ms &q,
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
        if( !g_ctx.glyph_tex ) {
            return false;
        }
        const uint32_t c = static_cast<uint32_t>( cp );
        const int gc = ( c > 32 && c <= 126 ) ? static_cast<int>( c ) - 32 : '?' - 32;
        out = sprite_info{};
        out.atlas = g_ctx.glyph_tex;
        out.u0 = ( gc % 16 ) * g_ctx.glyph_cell_w / static_cast<float>( g_ctx.glyph_atlas_w );
        out.v0 = ( gc / 16 ) * g_ctx.glyph_cell_h / static_cast<float>( g_ctx.glyph_atlas_h );
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
        const int pdx = upos.x() - center.x();
        const int pdy = upos.y() - center.y();
        for( int dy = -REGION_RADIUS; dy <= REGION_RADIUS; ++dy ) {
            for( int dx = -REGION_RADIUS; dx <= REGION_RADIUS; ++dx ) {
                const tripoint_bub_ms p = center + tripoint( dx, dy, 0 );
                if( !here.inbounds( p ) ) {
                    continue;
                }
                const int rx = dx - pdx;
                const int ry = dy - pdy;
                if( rx * rx + ry * ry <= DOLLHOUSE_RADIUS * DOLLHOUSE_RADIUS &&
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
    std::unordered_map<memory_lookup_key, sprite_lookup_3d, memory_lookup_hash> mem_cache;
    const auto memory_lookup = [&]( const std::string & id, const TILE_CATEGORY cat,
    const tripoint_bub_ms &p, const int subtile,
    const int rota, const bool force ) -> sprite_lookup_3d {
        const memory_lookup_key key{ id, static_cast<int>( cat ), subtile, rota, force ? 1 : 0 };
        const auto it = mem_cache.find( key );
        if( it != mem_cache.end() )
        {
            return it->second;
        }
        sprite_lookup_3d l;
        lookup_sprite_layers_3d( tiles, id, cat, p, subtile, rota, force, l );
        // multi-variant sprites pick by a position seed, so caching them would
        // make whole remembered regions identical; resolve those per tile
        if( l.fg_count <= 1 && l.bg_count <= 1 ) {
            mem_cache.emplace( key, l );
        }
        return l;
    };
    const auto push_fog_slab = [&]( const int dx, const int dy, const float wz ) {
        std::vector<float> &v = bucket_for( MODE_BOX, nullptr );
        push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
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
    const auto gather_memory_tile = [&]( const tripoint_bub_ms & p, const int dx,
    const int dy, const float wz, const bool with_furniture ) -> bool {
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
        if( has_furn ) {
            fid = furn_str_id( dec_id );
        }
        const bool furn_ok = has_furn && fid.is_valid();
        const auto push_memory_furniture = [&]() {
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
            float fr = 1.0f, fg = 1.0f, fb = 1.0f;
            if( !ftex ) {
                terrain_color( furn_id( fid ).to_i() * 31 + 7, fr, fg, fb );
            }
            const float fw = FURN_QUAD_HEIGHT * std::clamp( fspr.aspect, 0.5f, 2.0f );
            std::vector<float> &v = bucket_for( MODE_BILLBOARD_SNAP,
                                                ftex ? fspr.atlas : nullptr );
            push_instance( v, dx + 0.5f, dy + 0.5f,
                           wz - FURN_QUAD_HEIGHT * fspr.base_drop,
                           fw, FURN_QUAD_HEIGHT, 1.0f, fspr, fr, fg, fb,
                           false, 0, false, -1.0f, false, 1.0f, true );
            ++count;
            if( layered && fl.fg_tex && count < MAX_DRAW_INSTANCES ) {
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
        if( mem_ter.empty() || !tid.is_valid() ) {
            // stale memory id (content removed): nothing faithful to draw
            if( furn_ok && with_furniture ) {
                push_fog_slab( dx, dy, wz );
                push_memory_furniture();
                return true;
            }
            return !furn_ok;
        }
        const ter_t &t = *tid;
        const int ter_int = ter_id( tid ).to_i();
        if( t.has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) ) {
            // remembered open air stays open, as the live path draws it; a
            // remembered decoration still gets its dark backdrop
            if( !dec_id.empty() && with_furniture ) {
                push_fog_slab( dx, dy, wz );
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
        const bool is_fence = !is_panel && t.has_flag( "THIN_OBSTACLE" );
        const bool is_wall = !is_tree && !is_shrub && !is_panel && !is_fence &&
                             t.movecost == 0;
        const bool plain_floor = !is_tree && !is_shrub && !is_panel && !is_fence &&
                                 !is_wall;
        // an edge segment's stored rotation is 0 for a N-S wall line and 1 for
        // an E-W one (cata_tiles::get_rotation_and_subtile)
        const bool ew_line = ( ( mt.get_ter_rotation() % 2 ) + 2 ) % 2 == 1;

        int lookup_subtile = -1;
        int lookup_rota = 0;
        bool force_rota = false;
        if( plain_floor || is_tree || is_shrub ) {
            // 2D's memory draw uses the stored subtile and rotation as-is
            lookup_subtile = mt.get_ter_subtile();
            lookup_rota = mt.get_ter_rotation();
        } else {
            lookup_subtile = SUBTILE_EDGE;
            lookup_rota = ( is_wall || is_fence ) ? 1 : ( ew_line ? 1 : 0 );
            force_rota = true;
        }
        const sprite_lookup_3d tl = memory_lookup( mem_ter, TILE_CATEGORY::TERRAIN, p,
                                    lookup_subtile, lookup_rota, force_rota );
        // a subtile without its own bg falls back to the base tile's bg
        sprite_info bspr = tl.bg;
        bool btex = tl.bg_tex;
        if( !btex && lookup_subtile != -1 ) {
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
        const bool layered_face = is_panel && btex && !is_opening && wants_layered_face( t );
        // diagnostic: remembered door-family classification trace, once per id
        if( is_panel || t.has_flag( "LOCKED" ) ) {
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
        if( is_panel && ( !btex || layered_face ) ) {
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
        float gr = 1.0f, gg = 1.0f, gb = 1.0f;
        if( !ground_tex ) {
            terrain_color( ter_int, gr, gg, gb );
        }
        if( plain_floor && !btex && !dtex && ground_spr.has_transparency ) {
            std::vector<float> &v = bucket_for( MODE_FLATQUAD,
                                                ground_tex ? ground_spr.atlas : nullptr );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                           wz - 0.001f, 1.0f, 1.0f, 1.0f, ground_spr, gr, gg, gb,
                           false, ground_rot4, false, -1.0f, false, 1.0f, true );
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
                           gr, gg, gb, true, ground_rot4, false, -1.0f, false, 1.0f, true );
            ++count;
        }

        const sprite_info &fspr = tl.fg;
        const bool ftex = tl.fg_tex;
        float or_ = 1.0f, og = 1.0f, ob = 1.0f;
        if( !ftex ) {
            terrain_color( ter_int, or_, og, ob );
        }
        // the wall sprite clamping a panel or backing a doorway's lintel:
        // consecutive doors/windows/openings are one run, scanned along the
        // wall line to the first wall at either end
        const auto mem_clamp_wall = [&]( sprite_info & out ) {
            const auto mem_ter_at = [&]( const tripoint_bub_ms & q ) -> const ter_t * {
                const std::string &nid =
                    get_avatar().get_memorized_tile( here.get_abs( q ) ).get_ter_id();
                if( nid.empty() ) {
                    return nullptr;
                }
                const ter_str_id ntid( nid );
                return ntid.is_valid() ? &*ntid : nullptr;
            };
            const point line_step = ew_line ? point::east : point::north;
            for( const int dir : { 1, -1 } ) {
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
        if( is_tree ) {
            std::vector<float> &v = bucket_for( MODE_XQUAD, ftex ? fspr.atlas : nullptr );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                           wz - TREE_HEIGHT * fspr.base_drop,
                           1.0f, 1.0f, TREE_HEIGHT, fspr, or_, og, ob,
                           false, 0, false, -1.0f, false, 1.0f, true );
            ++count;
        } else if( is_shrub ) {
            std::vector<float> &v = bucket_for( MODE_XQUAD, ftex ? fspr.atlas : nullptr );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ),
                           wz - SHRUB_HEIGHT * fspr.base_drop,
                           0.9f, 0.9f, SHRUB_HEIGHT, fspr, or_, og, ob,
                           false, 0, false, -1.0f, false, 1.0f, true );
            ++count;
        } else if( is_panel ) {
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
                push_instance( v, px, py, wz + SILL_H, psx, psy, SILL_H, facespr,
                               pr, pg, pb, false, 0, false, -1.0f, false, 1.0f, true );
                ++count;
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
                push_instance( v, px, py, wz, psx, psy, PANEL_HEIGHT, facespr,
                               pr, pg, pb, false, 0, false, -1.0f, false, 1.0f, true );
                ++count;
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
        } else if( is_fence ) {
            const float fh = t.has_flag( "TINY" ) ? 0.35f : FENCE_HEIGHT;
            std::vector<float> &v = bucket_for( MODE_LINEQUAD, ftex ? fspr.atlas : nullptr );
            // the stored subtile/rotation encode the fence run; a memory tile
            // has no neighbors to consult
            const uint8_t conn = memory_conn_mask( mt.get_ter_subtile(),
                                                   mt.get_ter_rotation() );
            const bool cn = ( conn & 8 ) != 0, cs = ( conn & 1 ) != 0;
            const bool ce = ( conn & 2 ) != 0, cw = ( conn & 4 ) != 0;
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
                const float fcx = dx + 0.5f, fcy = dy + 0.5f;
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
        } else if( is_wall ) {
            std::vector<float> &v = bucket_for( MODE_BOX, ftex ? fspr.atlas : nullptr );
            push_instance( v, static_cast<float>( dx ), static_cast<float>( dy ), wz,
                           1.0f, 1.0f, WALL_HEIGHT, fspr, or_, og, ob,
                           false, 0, false, -1.0f, false, 1.0f, true );
            ++count;
        }

        // plain floor with a bg and an fg composites them like live/2D
        if( plain_floor && ftex && btex && count < MAX_DRAW_INSTANCES ) {
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
                        if( !gather_memory_tile( p, dx, dy, wz, true ) ) {
                            push_fog_slab( dx, dy, wz );
                        }
                    } else if( !( dz > 0 &&
                                  dollhouse[( dy + REGION_RADIUS ) * REGION_SIZE + ( dx + REGION_RADIUS )] ) ) {
                        // the dollhouse cutout stays clear: remembered walls on
                        // the floors above an interior must not block it.
                        // upper floors keep their remembered structure only:
                        // remembered furniture there is deliberately not drawn
                        gather_memory_tile( p, dx, dy, wz, dz < 0 );
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
                const ter_id t = here.ter( p );
                if( t == t_null ) {
                    continue;
                }
                // open air / holes: nothing stands here on this level (water is
                // NO_FLOOR_WATER, not NO_FLOOR, and still draws). furniture can
                // bridge a gap, so its tile is not open air
                if( t->has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) && !here.has_furn( p ) ) {
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
                const bool is_fence = !is_panel && t->has_flag( "THIN_OBSTACLE" );
                const bool is_wall = !is_tree && !is_shrub && !is_panel && !is_fence &&
                                     t->movecost == 0;
                // wall-line connections orient door/window panels and fence slabs
                // (bit order S=1, E=2, W=4, N=8)
                const uint8_t wall_conn = ( is_panel || is_fence )
                                          ? here.get_known_connections( p, t->connect_to_groups, {} ) : 0;
                const bool ew_line = ( wall_conn & 0x06 ) != 0; // true: the line runs E-W

                // terrain sprite: one faithful call mirrors 2D's selection for
                // this tile — looks_like/season resolution, multitile subtile
                // re-resolution on the RESOLVED id, the rotates gate, the
                // variant seed and the rotation/variant rule. Every plain
                // floor gets the true connection subtile (connect groups, else
                // same-id neighborhood, exactly as 2D's draw_terrain per tile);
                // walls, fences and panels keep the straight "edge" middle
                // segment since they are drawn as vertical faces
                const bool plain_floor = !is_tree && !is_shrub && !is_panel && !is_fence &&
                                         !is_wall;
                const bool shaped = plain_floor;
                int rota = 0, subtile = 0;
                if( tiles && shaped ) {
                    tiles->get_terrain_rota_subtile( p, rota, subtile );
                } else if( is_wall || is_fence || is_panel ) {
                    subtile = SUBTILE_EDGE;
                }
                const bool force_rota = is_wall || is_fence || is_panel;
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
                const bool layered_face = is_panel && btex && !is_opening &&
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
                float gr = tone.shade, gg = tone.shade, gb = tone.shade;
                if( !ground_tex ) {
                    terrain_color( t.to_i(), gr, gg, gb );
                    gr *= tone.shade;
                    gg *= tone.shade;
                    gb *= tone.shade;
                }
                float or_ = tone.shade, og = tone.shade, ob = tone.shade;
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
                // hash-colored floor in the sky
                if( dz <= 0 || ground_tex ) {
                    // the base-id / wood-floor fallbacks have no connection
                    // rotation: only a shaped fg sprite carries one
                    const int ground_rot4 = ( !btex && !dtex ) ? frot4 : 0;
                    if( shaped && !btex && !dtex && ground_spr.has_transparency ) {
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
                // too would read as seeing the upper story from inside
                if( ghost ) {
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
                        return nt ? &*nt : nullptr;
                    };
                    const point line_step = ew_line ? point::east : point::north;
                    for( const int dir : { 1, -1 } ) {
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
                        push_instance( v, px, py, wz + SILL_H, psx, psy, SILL_H, facespr,
                                       pr, pg, pb, false, 0, false, -1.0f, ghost, tone.sat );
                        ++count;
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
                        push_instance( v, px, py, wz, psx, psy, PANEL_HEIGHT, facespr,
                                       pr, pg, pb, false, 0, false, -1.0f, ghost, tone.sat );
                        ++count;
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
                } else if( is_fence ) {
                    // fences are flat vertical quads standing on the fence line — a
                    // box would smear the sprite's transparent margins over its end
                    // and top faces. pad encodes the run direction for the shader.
                    // TINY thin obstacles (rain gutters, dock rails) are low strips,
                    // not full-height fences
                    const float fh = t->has_flag( "TINY" ) ? 0.35f : FENCE_HEIGHT;
                    std::vector<float> &v = bucket_for( MODE_LINEQUAD, ftex ? fspr.atlas : nullptr );
                    // connection mask (S=1, E=2, W=4, N=8): straight runs stay one
                    // quad; corners, T-junctions, crossings and dead ends bend —
                    // one half-length quad from the tile center toward each
                    // connected edge
                    const bool cn = ( wall_conn & 8 ) != 0, cs = ( wall_conn & 1 ) != 0;
                    const bool ce = ( wall_conn & 2 ) != 0, cw = ( wall_conn & 4 ) != 0;
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
                        const float fcx = dx + 0.5f, fcy = dy + 0.5f;
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
                    const field &fld_here = here.field_at( p );
                    if( fld_here.field_count() > 0 ) {
                        // the neighbour must carry the same field type AND be
                        // visible by the same rule as the tile itself (2D drops
                        // connection edges toward unseen neighbours)
                        const auto neighbor_same_field = [&]( const field_type_id & fid,
                        const tripoint_bub_ms & q ) -> int {
                            if( !here.inbounds( q ) ) {
                                return -1;
                            }
                            const int qdx = q.x() - center.x();
                            const int qdy = q.y() - center.y();
                            const int qdz = q.z() - cz;
                            if( std::abs( qdx ) > VIEW_RADIUS || std::abs( qdy ) > VIEW_RADIUS ) {
                                return -1;
                            }
                            if( qdz != 0 && ( std::abs( qdx ) > REGION_RADIUS ||
                                              std::abs( qdy ) > REGION_RADIUS ) ) {
                                return -1;
                            }
                            const level_cache &qc = here.get_cache_ref( q.z() );
                            lit_level qll = lit_level::BLANK;
                            if( !( qdz < 0 && q.z() < lowest_vis_z ) ) {
                                qll = qdz > 0 ? upper_lit_at( qc, q )
                                      : qc.visibility_cache[q.x()][q.y()];
                            }
                            if( qll != lit_level::LOW && qll != lit_level::LIT &&
                                qll != lit_level::BRIGHT ) {
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
                            float fr = tone.shade, fgn = tone.shade, fb = tone.shade;
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

                if( !roof_unseen && here.has_furn( p ) && count < MAX_DRAW_INSTANCES ) {
                    const furn_id f = here.furn( p );
                    sprite_lookup_3d fl;
                    lookup_sprite_layers_3d( tiles, f->id.str(), TILE_CATEGORY::FURNITURE, p,
                                             -1, 0, true, fl );
                    // locked/alarmed furniture whose tileset splits bg=body /
                    // fg=indicator (key or alarm icon) draws both layers, as
                    // 2D does; ordinary furniture keeps its fg-only billboard
                    const bool layered = fl.bg_tex && wants_layered_face( f.obj() );
                    const sprite_info &fspr = layered ? fl.bg : fl.fg;
                    const bool ftex = layered ? fl.bg_tex : fl.fg_tex;
                    float fr = tone.shade, fg = tone.shade, fb = tone.shade;
                    if( !ftex ) {
                        terrain_color( f.to_i() * 31 + 7, fr, fg, fb );
                        fr *= tone.shade;
                        fg *= tone.shade;
                        fb *= tone.shade;
                    }
                    // furniture is a billboard snapped to 90-degree steps: always
                    // roughly facing the camera without continuously rotating
                    const float fw = FURN_QUAD_HEIGHT * std::clamp( fspr.aspect, 0.5f, 2.0f );
                    std::vector<float> &v = bucket_for( MODE_BILLBOARD_SNAP,
                                                        ftex ? fspr.atlas : nullptr );
                    push_instance( v, dx + 0.5f, dy + 0.5f,
                                   wz - FURN_QUAD_HEIGHT * fspr.base_drop,
                                   fw, FURN_QUAD_HEIGHT, 1.0f, fspr, fr, fg, fb,
                                   false, 0, false, -1.0f, ghost, tone.sat );
                    ++count;
                    if( layered && fl.fg_tex && count < MAX_DRAW_INSTANCES ) {
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
                    const maptile mt = here.maptile_at( p );
                    if( mt.get_item_count() > 0 ) {
                        const item &itm = mt.get_uppermost_item();
                        sprite_info ispr;
                        bool itex = lookup_sprite( tiles, itm.typeId().str(), TILE_CATEGORY::ITEM,
                                                   p, ispr );
                        float ir = tone.shade, ig = tone.shade, ib = tone.shade;
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
                            ispr.v0 = ( gc / 16 ) * g_ctx.glyph_cell_h /
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

    // creatures live in the tracker, not the map; add them per tile position
    creature_tracker &tracker = get_creature_tracker();
    for( int zlev = zmin; zlev <= zmax; ++zlev ) {
        const int dz = zlev - cz;
        const float wz = dz * LEVEL_HEIGHT;
        const level_cache &cache = here.get_cache_ref( zlev );
        for( int dy = -VIEW_RADIUS; dy <= VIEW_RADIUS; ++dy ) {
            for( int dx = -VIEW_RADIUS; dx <= VIEW_RADIUS; ++dx ) {
                if( count >= MAX_DRAW_INSTANCES ) {
                    return count;
                }
                if( dz != 0 &&
                    ( std::abs( dx ) > REGION_RADIUS || std::abs( dy ) > REGION_RADIUS ) ) {
                    continue;
                }
                const tripoint_bub_ms p = center + tripoint( dx, dy, dz );
                if( !here.inbounds( p ) ) {
                    continue;
                }
                if( dz < 0 && zlev < lowest_vis_z ) {
                    continue;
                }
                // levels above an indoor column near the player show nothing
                // but the translucent roof slab
                if( dz > 0 &&
                    dollhouse[( dy + REGION_RADIUS ) * REGION_SIZE + ( dx + REGION_RADIUS )] ) {
                    continue;
                }
                const Creature *critter = tracker.creature_at( p );
                if( !critter ) {
                    continue;
                }
                // the same test 2D's draw_critter_at uses: light, line of
                // sight, distance, invisibility and ALWAYS_VISIBLE are all
                // handled there; the avatar itself is always visible
                if( !get_avatar().sees( here, *critter ) ) {
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
                push_entity( *critter, p, static_cast<float>( dx ), static_cast<float>( dy ), wz,
                             tone );
            }
        }
    }

    // hover preselection box + game-driven cursors (targeting, construction...):
    // a thin slab carrying the tileset's highlight/cursor sprite
    auto push_cursor_slab = [&]( const tripoint_bub_ms & tp, const char *sprite ) {
        if( count >= MAX_DRAW_INSTANCES || tp.z() != center.z() ) {
            return;
        }
        const tripoint_rel_ms rel = tp - center;
        sprite_info cspr;
        const bool ctex = lookup_sprite( tiles, sprite, TILE_CATEGORY::NONE, tp, cspr );
        std::vector<float> &v = bucket_for( MODE_BOX, ctex ? cspr.atlas : nullptr );
        push_instance( v, static_cast<float>( rel.x() ), static_cast<float>( rel.y() ),
                       0.002f, 1.0f, 1.0f, 0.05f, cspr, 1.0f, 1.0f, 1.0f );
        ++count;
    };
    // forward movement marker: the tile the "up" key steps to, i.e. screen
    // forward. the tileset's line_target brackets (yellow in UC) mark it as a
    // destination, visibly distinct from the white mouse hover below; its
    // position next to the player shows whether the step is orthogonal or
    // diagonal. while controlling a vehicle the direction keys steer, so the
    // marker would lie.
    const auto has_game_cursor = [&]( const tripoint_bub_ms & tp ) {
        for( const auto &c : g_game_cursors ) {
            if( c.first == tp ) {
                return true;
            }
        }
        return false;
    };
    std::optional<tripoint_bub_ms> move_marker;
    if( !get_avatar().controlling_vehicle && upos.z() == center.z() ) {
        const point_rel_ms w = compass8[camera_forward_octant()];
        const tripoint_bub_ms tp = upos + tripoint( w.x(), w.y(), 0 );
        if( here.inbounds( tp ) && !has_game_cursor( tp ) ) {
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
        if( const std::optional<tripoint_bub_ms> hov = tile_at_pixel( g_last_mouse ) ) {
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
    return tile_at_pixel( logical_pixel );
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
    if( !g_available || !get_option<bool>( "RENDER3D_EXPERIMENTAL" ) ) {
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
    return camera_rotate_step( dx, dy, camera_forward_octant() );
}

bool camera_map_to_screen_delta( int &dx, int &dy )
{
    // inverse of the above: map octant m -> key octant m - k
    return camera_rotate_step( dx, dy, -camera_forward_octant() );
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
    g_ctx.teardown();
    g_probed_renderer = renderer;
    if( renderer ) {
        probe( renderer );
    }
}

void on_renderer_destroyed()
{
    g_ctx.teardown();
    g_probed_renderer = nullptr;
    g_available = false;
    g_mouse_captured = false;
}

bool available()
{
    return g_available;
}

bool ensure_available( SDL_Renderer *renderer )
{
    if( renderer && renderer != g_probed_renderer ) {
        on_renderer_created( renderer );
    }
    return g_available;
}

void draw_terrain_window( SDL_Renderer *renderer, const SDL_FRect &dest,
                          const tripoint_bub_ms &center, cata_tiles *tiles )
{
    static int call_count = 0;
    if( call_count < 3 ) {
        ++call_count;
        write_status( "draw_terrain_window called #" + std::to_string( call_count ) +
                      " available=" + ( g_available ? std::string( "yes" ) : std::string( "no" ) ) +
                      " renderer_match=" + ( renderer == g_probed_renderer ? std::string( "yes" ) : std::string( "no" ) ) );
    }
    if( !renderer ) {
        return;
    }
    if( renderer != g_probed_renderer ) {
        on_renderer_created( renderer );
    }
    if( !g_available ) {
        return;
    }
    const int w = std::max( 64, static_cast<int>( dest.w ) );
    const int h = std::max( 64, static_cast<int>( dest.h ) );
    if( !ensure_targets( renderer, w, h ) ) {
        g_available = false;
        return;
    }

    // map memory: remembered terrain is drawn for tiles the player cannot see
    // right now. Render3D bypasses cata_tiles::draw, which normally prepares
    // the memory region and sweeps what is visible into it, so do both here:
    // the whole reality bubble (the same region 2D prepares; prepare_region
    // early-outs until the bubble shifts) and a sweep once per turn, player
    // position or visibility-cache change.
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
        static uint64_t last_sight_revision = 0;
        if( mem_level.map_memory_sweep_pending || upos != last_sweep_pos ||
            calendar::turn != last_sweep_turn ||
            mem_level.sight_revision != last_sight_revision ) {
            tiles->memorize_map_memory( center );
            last_sweep_pos = upos;
            last_sweep_turn = calendar::turn;
            last_sight_revision = mem_level.sight_revision;
        }
    }

    // top-down: anchor the scene to the view center (ter_view_p follows the
    // player; look-around mode pans it for free)
    std::vector<instance_bucket> buckets;
    const int count = gather_instances( tiles, center, buckets );
    g_game_cursors.clear();
    static bool gather_logged = false;
    if( !gather_logged ) {
        gather_logged = true;
        write_status( "first gather: instances=" + std::to_string( count ) +
                      " buckets=" + std::to_string( buckets.size() ) );
    }
    if( count == 0 ) {
        return;
    }

    // flatten the buckets into one contiguous instance upload; record segments
    struct draw_segment {
        int mode;
        SDL_Texture *atlas;
        int first_instance;
        int num_instances;
    };
    std::vector<draw_segment> segments;
    std::vector<float> inst;
    inst.reserve( count * INSTANCE_STRIDE / sizeof( float ) );
    for( const instance_bucket &b : buckets ) {
        if( b.data.empty() ) {
            continue;
        }
        segments.push_back( draw_segment{ b.mode, b.atlas,
                                          static_cast<int>( inst.size() / ( INSTANCE_STRIDE / sizeof( float ) ) ),
                                          static_cast<int>( b.data.size() / ( INSTANCE_STRIDE / sizeof( float ) ) ) } );
        inst.insert( inst.end(), b.data.begin(), b.data.end() );
    }

    // top-down orbit camera: the scene is rebuilt relative to the view center
    // every frame, so the target is constant; the camera sits behind and above
    // it along the yaw/pitch direction
    const vec3 target{ 0.5f, 0.5f, 1.0f };
    const vec3 dir{
        std::cos( g_pitch ) * std::cos( g_yaw ),
        std::cos( g_pitch ) * std::sin( g_yaw ),
        std::sin( g_pitch )
    };
    const vec3 eye{ target.x - dir.x * g_cam_dist,
                    target.y - dir.y * g_cam_dist,
                    target.z - dir.z * g_cam_dist };
    const mat4 view = mat4_lookat( eye, target, { 0.0f, 0.0f, 1.0f } );
    const mat4 proj = mat4_perspective( 40.0f * 3.14159265f / 180.0f,
                                        static_cast<float>( w ) / static_cast<float>( h ),
                                        0.05f, 300.0f );

    // cache the camera for screen_to_tile + the hover preselection box
    {
        g_dest = dest;
        g_eye = eye;
        // physical screen-right in the left-handed map frame: up x forward
        const vec3 rgt = vec3_normalize( vec3_cross( { 0.0f, 0.0f, 1.0f }, dir ) );
        g_basis_r = rgt;
        g_basis_u = vec3_cross( dir, rgt );
        g_basis_f = dir;
        g_aspect = static_cast<float>( w ) / static_cast<float>( h );
        g_center = center;
        g_cam_valid = true;
    }
    const mat4 mvp = mat4_mul( proj, view );

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
    const vec3 sun_dir{ -std::sin( sun_az ) * std::cos( sun_alt ),
                        std::cos( sun_az ) * std::cos( sun_alt ),
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
    sky_ub.cam_right = { g_basis_r.x, g_basis_r.y, g_basis_r.z, 0.0f };
    sky_ub.cam_up = { g_basis_u.x, g_basis_u.y, g_basis_u.z, 0.0f };
    sky_ub.cam_forward = { g_basis_f.x, g_basis_f.y, g_basis_f.z, 0.0f };
    sky_ub.sun_dir = { sun_dir.x, sun_dir.y, sun_dir.z, daylight };
    sky_ub.params = { std::tan( g_fov_y * 0.5f ), g_aspect, cloudiness,
                      nv_tint ? 1.0f : 0.0f };
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
    const tripoint_bub_ms upos = get_avatar().pos_bub();
    const float player_gz = ( upos.z() - center.z() ) * LEVEL_HEIGHT;
    frag_ub.eye_pos = { eye.x, eye.y, eye.z, 0.0f };
    frag_ub.player_pos = { ( upos.x() - center.x() ) + 0.5f,
                           ( upos.y() - center.y() ) + 0.5f,
                           player_gz + 1.0f, 0.0f };
    frag_ub.cam_right = { g_basis_r.x, g_basis_r.y, g_basis_r.z, 0.0f };
    frag_ub.cam_up = { g_basis_u.x, g_basis_u.y, g_basis_u.z, 0.0f };
    frag_ub.mask_params = { 3.2f, 2.2f, player_gz, 1.0f };
    // same memory look 2D's lit shader uses: a named preset, else the custom
    // MEMORY_RGB_* / MEMORY_GAMMA mixer
    const cata_shader::memory_look mem_look = cata_tiles::memory_look_from_options(
                cata_shader::memory_preset_from_option_value(
                    get_option<std::string>( "MEMORY_MAP_MODE" ) ) );
    frag_ub.memory_params = { mem_look.preset ? static_cast<float>( *mem_look.preset ) : 0.0f,
                              mem_look.preset ? 0.0f : 1.0f, 0.0f, 0.0f };
    frag_ub.memory_dark = { mem_look.custom_dark[0], mem_look.custom_dark[1],
                            mem_look.custom_dark[2], mem_look.custom_gamma };
    frag_ub.memory_light = { mem_look.custom_light[0], mem_look.custom_light[1],
                             mem_look.custom_light[2], 0.0f };
    // 2D's reference_night_rgb constants travel to the shader so the two
    // implementations cannot drift apart (nv_tint was resolved with the sky)
    frag_ub.nv_params = { nv_tint ? 1.0f : 0.0f, smooth_lighting::night_floor,
                          smooth_lighting::overexpose_start, 0.0f };

    // fallback clear color when the sky pass is unavailable
    const SDL_FColor sky{ 0.02f + 0.35f * daylight, 0.02f + 0.45f * daylight,
                          0.05f + 0.65f * daylight, 1.0f };

    // drain pending 2D batches before touching the device ourselves
    SDL_FlushRenderer( renderer );

    SDL_GPUDevice *device = g_ctx.device;
    SDL_GPUCommandBuffer *cmd = SDL_AcquireGPUCommandBuffer( device );
    if( !cmd ) {
        static bool acquire_logged = false;
        if( !acquire_logged ) {
            acquire_logged = true;
            write_status( "acquire command buffer failed: " + std::string( SDL_GetError() ) );
        }
        DebugLog( D_ERROR, DC_ALL ) << "render3d: acquire command buffer failed: " << SDL_GetError();
        return;
    }

    // upload instance data
    SDL_GPUTransferBufferCreateInfo ti{};
    ti.usage = SDL_GPU_TRANSFERBUFFERUSAGE_UPLOAD;
    ti.size = inst.size() * sizeof( float );
    SDL_GPUTransferBuffer *tb = SDL_CreateGPUTransferBuffer( device, &ti );
    if( tb ) {
        void *mapped = SDL_MapGPUTransferBuffer( device, tb, false );
        std::memcpy( mapped, inst.data(), inst.size() * sizeof( float ) );
        SDL_UnmapGPUTransferBuffer( device, tb );
        SDL_GPUCopyPass *copy = SDL_BeginGPUCopyPass( cmd );
        SDL_GPUTransferBufferLocation src{};
        src.transfer_buffer = tb;
        src.offset = 0;
        SDL_GPUBufferRegion dst{};
        dst.buffer = g_ctx.instance_vb;
        dst.offset = 0;
        dst.size = inst.size() * sizeof( float );
        SDL_UploadToGPUBuffer( copy, &src, &dst, false );
        SDL_EndGPUCopyPass( copy );
    }

    // pass 1: the sky — a fullscreen triangle clearing the color target and
    // painting gradient/sun/clouds wherever the world won't cover
    if( g_ctx.sky_pipeline ) {
        SDL_GPUColorTargetInfo sky_target{};
        sky_target.texture = g_ctx.color_tex;
        sky_target.load_op = SDL_GPU_LOADOP_CLEAR;
        sky_target.store_op = SDL_GPU_STOREOP_STORE;
        sky_target.clear_color = sky;
        SDL_GPURenderPass *sky_pass = SDL_BeginGPURenderPass( cmd, &sky_target, 1, nullptr );
        SDL_BindGPUGraphicsPipeline( sky_pass, g_ctx.sky_pipeline );
        SDL_PushGPUFragmentUniformData( cmd, 0, &sky_ub, sizeof( sky_ub ) );
        SDL_DrawGPUPrimitives( sky_pass, 3, 1, 0, 0 );
        SDL_EndGPURenderPass( sky_pass );
    }

    // pass 2: the world — loads over the sky when the sky pass ran
    SDL_GPUColorTargetInfo color_target{};
    color_target.texture = g_ctx.color_tex;
    color_target.load_op = g_ctx.sky_pipeline ? SDL_GPU_LOADOP_LOAD : SDL_GPU_LOADOP_CLEAR;
    color_target.store_op = SDL_GPU_STOREOP_STORE;
    color_target.clear_color = sky;
    SDL_GPUDepthStencilTargetInfo depth_target{};
    depth_target.texture = g_ctx.depth_tex;
    depth_target.load_op = SDL_GPU_LOADOP_CLEAR;
    depth_target.store_op = SDL_GPU_STOREOP_DONT_CARE;
    depth_target.clear_depth = 1.0f;

    SDL_GPURenderPass *pass = SDL_BeginGPURenderPass( cmd, &color_target, 1, &depth_target );
    SDL_BindGPUGraphicsPipeline( pass, g_ctx.pipeline );
    SDL_GPUBufferBinding inst_bind{};
    inst_bind.buffer = g_ctx.instance_vb;
    inst_bind.offset = 0;
    for( const draw_segment &seg : segments ) {
        SDL_GPUBufferBinding geom_bind{};
        int verts_per_instance = 36;
        if( seg.mode == MODE_XQUAD ) {
            geom_bind.buffer = g_ctx.xquad_vb;
            verts_per_instance = 12;
        } else if( seg.mode == MODE_FLATQUAD ) {
            geom_bind.buffer = g_ctx.flatquad_vb;
            verts_per_instance = 6;
        } else if( seg.mode == MODE_BILLBOARD || seg.mode == MODE_BILLBOARD_SNAP ||
                   seg.mode == MODE_LINEQUAD ) {
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
        uniforms.params = { static_cast<float>( seg.mode ), 0.0f, 0.0f, 0.0f };
        SDL_PushGPUVertexUniformData( cmd, 0, &uniforms, sizeof( uniforms ) );
        // the camera->player occlusion mask covers terrain geometry (boxes),
        // fence quads (incl. low thin obstacles like downspouts) and the flat
        // floor quads (roof corner cutouts above the player)
        frag_ub.mask_params[3] = ( seg.mode == MODE_BOX || seg.mode == MODE_LINEQUAD ||
                                   seg.mode == MODE_FLATQUAD )
                                 ? 1.0f : 0.0f;
        SDL_PushGPUFragmentUniformData( cmd, 0, &frag_ub, sizeof( frag_ub ) );
        SDL_DrawGPUPrimitives( pass, verts_per_instance, seg.num_instances, 0, seg.first_instance );
    }
    SDL_EndGPURenderPass( pass );

    SDL_GPUFence *fence = SDL_SubmitGPUCommandBufferAndAcquireFence( cmd );
    if( tb ) {
        SDL_ReleaseGPUTransferBuffer( device, tb );
    }
    if( !fence ) {
        static bool submit_logged = false;
        if( !submit_logged ) {
            submit_logged = true;
            write_status( "submit failed: " + std::string( SDL_GetError() ) );
        }
        DebugLog( D_ERROR, DC_ALL ) << "render3d: submit failed: " << SDL_GetError();
        return;
    }
    // P0: synchronous; the renderer must not sample color_tex before we finish.
    SDL_WaitForGPUFences( device, true, &fence, 1 );
    SDL_ReleaseGPUFence( device, fence );

    SDL_RenderTexture( renderer, g_ctx.color_tex_sdl, nullptr, &dest );

    static bool first_draw_logged = false;
    if( !first_draw_logged ) {
        first_draw_logged = true;
        write_status( "drawing: first frame composited, instances=" + std::to_string( count ) );
    }
}

} // namespace render3d

#endif // TILES
