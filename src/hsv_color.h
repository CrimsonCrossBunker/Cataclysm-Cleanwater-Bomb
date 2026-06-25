#pragma once

// Color primitives for the vehicle part coloring feature (ported from
// Cataclysm: Bright Nights). Feature overview:
//   - named_colors.json + load_named_color() define palette colors by name.
//   - VehiclePalette (vehicle_palette.h) rolls per-part colors when a vehicle
//     spawns; the color is stored in the part's base item variables.
//   - Rendering recolors sprites in HSV space via tint_blend() (used by
//     cata_tiles_color.cpp::get_tinted_tile).
// Note: unlike CBN we store the color as a hex string in item variables (see
// to_hex/from_hex) because this fork's item vars are backed by diag_value, which
// has no generic serializable-type support.

#include <cstdint>
#include <functional>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>

#include "color.h"
#include "hash_utils.h"
#include "json.h"

#if defined(TILES)
    #include "sdl_wrappers.h"
#endif

/**
 * Simple 32-bit RGBA color, used for vehicle part tinting.
 *
 * Ported from Cataclysm: Bright Nights. Unlike CBN this fork stores the color
 * in item variables as a hex string (see @ref to_hex / @ref from_hex) instead
 * of the data_vars converter, because this fork's item variables are backed by
 * diag_value which has no generic serializable-type support.
 */
struct RGBColor {
    uint8_t r = 0;
    uint8_t g = 0;
    uint8_t b = 0;
    uint8_t a = 0;

    constexpr RGBColor() = default;
    constexpr RGBColor( const uint8_t r, const uint8_t g, const uint8_t b, const uint8_t a )
        : r{r}, g{g}, b{b}, a{a} {}
#if defined(TILES)
    explicit constexpr RGBColor( const SDL_Color &c ) : r( c.r ), g( c.g ), b( c.b ), a( c.a ) {}
    explicit constexpr operator SDL_Color() const {
        return SDL_Color{ r, g, b, a };
    }
#endif

    void serialize( JsonOut & ) const;
    void deserialize( const JsonValue & );

    /** Encode as "#RRGGBB" (or "#RRGGBBAA" when not fully opaque) for item-var storage. */
    std::string to_hex() const;
    /** Decode a string produced by @ref to_hex (also accepts any @ref try_parse form). */
    static RGBColor from_hex( const std::string &str );

    /**
     * Parse a color from a string. Accepts:
     *  - "#RGB" / "#RGBA" / "#RRGGBB" / "#RRGGBBAA" hex
     *  - "!fuzzy" for a random named color whose name contains "fuzzy"
     *  - a curses color name (e.g. "red")
     *  - a named color loaded from named_colors.json (e.g. "Cataclysm Red")
     */
    static std::optional<RGBColor> try_parse( const std::string &str );
    static std::pair<RGBColor, std::string> random_named( std::string fuzzy_match = "" );
    static std::unordered_map<RGBColor, std::string> get_all_named_colors();

    static void load_named_color( const JsonObject &jo, std::string_view src );
    static void unload_names();

    std::string friendly_name() const;

    bool operator==( const RGBColor &other ) const {
        return r == other.r && g == other.g && b == other.b && a == other.a;
    }
    bool operator!=( const RGBColor &other ) const {
        return !( *this == other );
    }
};

struct RGBColorPair {
    RGBColor bg;
    RGBColor fg;
};

struct HSVColor {
    /// Hue: 0 ~ ( ( 1 << 16 ) - 1 ) * 6
    uint32_t H;
    /// Saturation: 0 ~ 65535
    uint16_t S;
    /// Value: 0 ~ 255
    uint8_t V;
    /// Alpha: 0 ~ 255
    uint8_t A;
};

auto curses_color_to_RGB( const nc_color &color ) -> RGBColor;
auto hsv2rgb( HSVColor color ) -> RGBColor;
auto rgb2hsv( RGBColor color ) -> HSVColor;

/**
 * Recolor a source pixel toward a tint, in HSV space (CBN's "tint" blend mode,
 * mask-less variant): take the tint's hue, pull saturation toward the tint, and
 * keep the source's value/shading (via an overlay). The source alpha is kept.
 * This is what makes one sprite render in many colors while preserving detail.
 */
RGBColor tint_blend( const RGBColor &base, const RGBColor &tint );

template<> struct std::hash<RGBColor> {
    std::size_t operator()( const RGBColor &color ) const noexcept {
        std::size_t hash = 0;
        cata::hash_combine( hash, color.r );
        cata::hash_combine( hash, color.g );
        cata::hash_combine( hash, color.b );
        cata::hash_combine( hash, color.a );
        return hash;
    }
};

template<> struct std::hash<HSVColor> {
    std::size_t operator()( const HSVColor &color ) const noexcept {
        std::size_t hash = 0;
        cata::hash_combine( hash, color.H );
        cata::hash_combine( hash, color.S );
        cata::hash_combine( hash, color.V );
        cata::hash_combine( hash, color.A );
        return hash;
    }
};
