#pragma once
#ifndef CATA_SRC_MOD_TILESET_H
#define CATA_SRC_MOD_TILESET_H

#include <cstddef>
#include <cstdint>
#include <optional>
#include <string> // IWYU pragma: keep
#include <string_view>
#include <vector>

#include "cata_path.h"

class JsonObject;
class mod_tileset;

struct mod_tileset_sprite_variation {
    std::vector<int> sprites;
    int weight = 1;
};

struct mod_tileset_tile_definition {
    std::vector<std::string> ids;
    std::vector<mod_tileset_sprite_variation> foreground;
    std::vector<mod_tileset_sprite_variation> background;
    bool multitile = false;
    std::optional<bool> rotates;
    bool animated = false;
    int height_3d = 0;
    std::vector<mod_tileset_tile_definition> additional_tiles;
};

enum class mod_tileset_ascii_color : int {
    default_color = -1,
    black,
    red,
    green,
    yellow,
    blue,
    magenta,
    cyan,
    white
};

struct mod_tileset_ascii_definition {
    int offset = 0;
    mod_tileset_ascii_color color = mod_tileset_ascii_color::default_color;
    bool bold = false;
};

struct mod_tileset_atlas_definition {
    std::string file;
    int sprite_width = 0;
    int sprite_height = 0;
    int sprite_offset_x = 0;
    int sprite_offset_y = 0;
    int sprite_offset_x_retracted = 0;
    int sprite_offset_y_retracted = 0;
    float pixelscale = 1.0f;
    int transparency_r = -1;
    int transparency_g = -1;
    int transparency_b = -1;
    std::vector<mod_tileset_tile_definition> tiles;
    std::vector<mod_tileset_ascii_definition> ascii;
};

struct mod_tileset_overlay_ordering {
    std::vector<std::string> ids;
    int order = 9999;
};

struct mod_tileset_definition {
    std::string id;
    std::vector<std::string> compatibility;
    std::vector<mod_tileset_atlas_definition> atlases;
    std::vector<mod_tileset_overlay_ordering> overlay_ordering;
};

extern std::vector<mod_tileset> all_mod_tilesets;

/**
 * A tileset atlas supplied programmatically by a Lua-first Platform Mod.
 *
 * The descriptor intentionally mirrors the ordinary mod-tileset atlas path:
 * tileset_loader owns image decoding, GPU uploads, reset replay, and tile-id
 * mapping.  Lua never receives a renderer or texture handle.
 */
struct platform_sprite_sheet {
    std::string id;
    cata_path image_path;
    int frame_width = 0;
    int frame_height = 0;
    float pixelscale = 1.0F;
    std::vector<std::string> frame_ids;
};

const platform_sprite_sheet *find_platform_sprite_sheet( std::string_view id );
void set_platform_sprite_sheet( platform_sprite_sheet value );
void erase_platform_sprite_sheet( std::string_view id );
std::vector<platform_sprite_sheet> platform_sprite_sheets();
// Monotonically changes whenever the Platform-owned atlas descriptors change.
// Tileset contexts use it to invalidate an otherwise fresh GPU atlas bundle.
uint64_t platform_sprite_sheet_generation();

void load_mod_tileset( const JsonObject &jsobj, std::string_view, const cata_path &base_path,
                       const cata_path &full_path );
void reset_mod_tileset();
void add_native_mod_tileset( const cata_path &base_path,
                             const std::string &owner,
                             std::size_t generation,
                             const mod_tileset_definition &definition );
void remove_native_mod_tilesets( const std::string &owner,
                                 std::size_t generation );

class mod_tileset
{
    public:
        mod_tileset( const cata_path &new_base_path, const cata_path &new_full_path,
                     int new_num_in_file ) :
            base_path_( new_base_path ),
            full_path_( new_full_path ),
            num_in_file_( new_num_in_file ) { }

        mod_tileset( const cata_path &new_base_path, std::string owner,
                     std::size_t generation,
                     const mod_tileset_definition &definition );

        const cata_path &get_base_path() const {
            return base_path_;
        }

        const cata_path &get_full_path() const {
            return full_path_;
        }

        int num_in_file() const {
            return num_in_file_;
        }

        bool is_compatible( const std::string &tileset_id ) const;
        void add_compatible_tileset( const std::string &tileset_id );
        bool is_native() const {
            return native_definition_.has_value();
        }
        const mod_tileset_definition &native_definition() const {
            return *native_definition_;
        }
        const std::string &owner() const {
            return owner_;
        }
        std::size_t generation() const {
            return generation_;
        }

    private:
        cata_path base_path_;
        cata_path full_path_;
        int num_in_file_;
        std::vector<std::string> compatibility;
        std::string owner_;
        std::size_t generation_ = 0;
        std::optional<mod_tileset_definition> native_definition_;
};

#endif // CATA_SRC_MOD_TILESET_H
