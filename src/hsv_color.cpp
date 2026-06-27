#include "hsv_color.h"

// Implementation of the vehicle-coloring color primitives (see hsv_color.h).
// hsv2rgb/rgb2hsv use a fixed-point integer HSV representation (HSVColor) ported
// verbatim from CBN so the tint math matches; tint_blend() is the recolor used
// at render time.

#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstdint>
#include <iterator>
#include <sstream>
#include <vector>

#include "debug.h"
#include "rng.h"
#include "string_formatter.h"
#include "translations.h"

#if defined(TILES)
    #include "sdl_utils.h"
#endif

static std::unordered_map<RGBColor, std::string> named_colors = {};
static std::unordered_map<RGBColor, std::string> similar_name_cache = {};

void RGBColor::load_named_color( const JsonObject &jo, std::string_view )
{
    const std::string name = jo.get_string( "name" );
    if( jo.has_member( "value" ) ) {
        RGBColor color;
        color.deserialize( jo.get_member( "value" ) );
        named_colors.insert_or_assign( color, name );
    }
}

void RGBColor::unload_names()
{
    named_colors.clear();
    similar_name_cache.clear();
}

static bool char_cmp_ignore_case( const char a, const char b )
{
    return std::tolower( static_cast<unsigned char>( a ) )
           == std::tolower( static_cast<unsigned char>( b ) );
}

std::pair<RGBColor, std::string> RGBColor::random_named( std::string fuzzy_match )
{
    if( fuzzy_match.empty() ) {
        return random_entry( named_colors );
    }

    std::vector<decltype( named_colors )::value_type> candidates;
    std::copy_if( named_colors.begin(), named_colors.end(), std::back_inserter( candidates ),
    [&]( const std::pair<const RGBColor, std::string> &c ) {
        const std::string::const_iterator it = std::search( c.second.begin(), c.second.end(),
                                               fuzzy_match.begin(), fuzzy_match.end(), char_cmp_ignore_case );
        return it != c.second.end();
    } );
    return random_entry( candidates );
}

std::unordered_map<RGBColor, std::string> RGBColor::get_all_named_colors()
{
    return named_colors;
}

std::string RGBColor::friendly_name() const
{
    const std::unordered_map<RGBColor, std::string>::iterator it = named_colors.find( *this );
    if( it != named_colors.end() ) {
        return it->second;
    }

    // https://www.compuphase.com/cmetric.htm
    const auto distFunc = []( const RGBColor & e1, const RGBColor & e2 ) {
        const uint32_t r_mean = ( static_cast<uint32_t>( e1.r ) + static_cast<uint32_t>( e2.r ) ) / 2;
        const uint32_t r = static_cast<uint32_t>( e1.r ) - static_cast<uint32_t>( e2.r );
        const uint32_t g = static_cast<uint32_t>( e1.g ) - static_cast<uint32_t>( e2.g );
        const uint32_t b = static_cast<uint32_t>( e1.b ) - static_cast<uint32_t>( e2.b );
        return std::sqrt( ( ( ( 512 + r_mean ) * r * r ) >> 8 )
                          + 4 * g * g
                          + ( ( ( 767 - r_mean ) * b * b ) >> 8 ) );
    };

    const std::unordered_map<RGBColor, std::string>::iterator nearest = similar_name_cache.find(
                *this );
    if( nearest != similar_name_cache.end() ) {
        return nearest->second;
    }

    if( named_colors.empty() ) {
        return _( "Unknown color" );
    }

    const std::unordered_map<RGBColor, std::string>::iterator min = std::min_element(
                named_colors.begin(), named_colors.end(),
                [&]( const std::pair<const RGBColor, std::string> &a,
    const std::pair<const RGBColor, std::string> &b ) {
        return distFunc( a.first, *this ) < distFunc( b.first, *this );
    } );
    std::string similar_name = string_format( _( "%s (Off-Brand)" ), min->second );
    similar_name_cache.emplace( *this, similar_name );
    return similar_name;
}

auto curses_color_to_RGB( const nc_color &color ) -> RGBColor
{
#if defined(TILES)
    return RGBColor( curses_color_to_SDL( color ) );
#else
    ( void )color;
    return RGBColor{ 255, 255, 255, 255 };
#endif
}

static uint8_t median( const uint8_t a, const uint8_t b, const uint8_t c )
{
    if( ( a > b ) ^ ( a > c ) ) {
        return a;
    }
    if( ( b < a ) ^ ( b < c ) ) {
        return b;
    }
    return c;
}

auto hsv2rgb( HSVColor color ) -> RGBColor
{
    constexpr int E = ( 1 << 16 ) - 1;

    const uint32_t H = color.H;
    const uint16_t S = color.S;
    const uint8_t V = color.V;
    const uint8_t A = color.A;

    if( S == 0 || V == 0 ) {
        return RGBColor{V, V, V, A};
    }

    uint8_t I;
    if( H < E ) {
        I = 0;
    } else if( H < 2 * E ) {
        I = 1;
    } else if( H < 3 * E ) {
        I = 2;
    } else if( H < 4 * E ) {
        I = 3;
    } else if( H < 5 * E ) {
        I = 4;
    } else {
        I = 5;
    }

    uint32_t F = ( H - static_cast<uint32_t>( E * I ) );
    if( F == 0 ) {
        ++F;
    }

    if( I % 2 != 0 ) {
        F = ( E - F );
    }

    const int d = ( ( S * V ) >> 16 ) + 1;
    const uint8_t m = static_cast<uint8_t>( V - d );
    const uint8_t c = static_cast<uint8_t>( ( ( F * static_cast<uint32_t>( d ) ) >> 16 ) + m );

    switch( I ) {
        case 0:
            return {V, c, m, A};
        case 1:
            return {c, V, m, A};
        case 2:
            return {m, V, c, A};
        case 3:
            return {m, c, V, A};
        case 4:
            return {c, m, V, A};
        case 5:
            return {V, m, c, A};
        default:
            return {0, 0, 0, A};
    }
}

auto rgb2hsv( RGBColor color ) -> HSVColor
{
    const uint8_t R = color.r;
    const uint8_t G = color.g;
    const uint8_t B = color.b;
    const uint8_t A = color.a;
    const uint8_t min = std::min( {R, G, B } );
    const uint8_t max = std::max( {R, G, B } );
    const uint8_t med = median( R, G, B );

    const uint8_t V = max;

    const int d = max - min;
    if( d == 0 || max == 0 ) {
        return HSVColor{0, 0, V, A};
    }

    const uint16_t S = static_cast<uint16_t>( ( ( d << 16 ) - 1 ) / V );

    int I;
    if( max == R && min == B ) {
        I = 0;
    } else if( max == G && min == B ) {
        I = 1;
    } else if( max == G && min == R ) {
        I = 2;
    } else if( max == B && min == R ) {
        I = 3;
    } else if( max == B && min == G ) {
        I = 4;
    } else {
        I = 5;
    }

    constexpr int E = ( 1 << 16 ) - 1;
    int F = ( ( ( med - min ) << 16 ) / d ) + 1;
    if( I % 2 != 0 ) {
        F = E - F;
    }

    const uint32_t H = static_cast<uint32_t>( ( E * I ) + F );

    return HSVColor{H, S, V, A};
}

RGBColor tint_blend( const RGBColor &base, const RGBColor &tint )
{
    HSVColor base_hsv = rgb2hsv( base );
    const HSVColor dest_hsv = rgb2hsv( tint );

    const auto lerp16 = []( const uint16_t a, const uint16_t b, const uint8_t t ) -> uint16_t {
        return static_cast<uint16_t>( a + ( ( static_cast<int>( b ) - static_cast<int>( a ) ) * t ) / 255 );
    };
    const auto lerp8 = []( const uint8_t a, const uint8_t b, const uint8_t t ) -> uint8_t {
        return static_cast<uint8_t>( a + ( ( static_cast<int>( b ) - static_cast<int>( a ) ) * t ) / 255 );
    };
    // Pegtop-style overlay used by CBN to preserve the source sprite's shading.
    const auto overlay = []( const uint8_t b, const uint8_t blend ) -> uint8_t {
        if( b > 127 )
        {
            return static_cast<uint8_t>( std::clamp<int>( 255 - ( std::max( 255 - blend, 1 ) ) *
                                         ( ( 255 - b ) * 255 / 127 ) / 255, 0, 255 ) );
        }
        return static_cast<uint8_t>( std::clamp<int>( blend * ( b * 255 / 127 ) / 255, 0, 255 ) );
    };

    base_hsv.H = dest_hsv.H;
    base_hsv.S = lerp16( std::min( base_hsv.S, dest_hsv.S ), dest_hsv.S, 127 );
    base_hsv.V = lerp8( base_hsv.V, overlay( base_hsv.V, dest_hsv.V ), 127 );

    RGBColor out = hsv2rgb( base_hsv );
    out.a = base.a;
    return out;
}

void RGBColor::serialize( JsonOut &jsout ) const
{
    jsout.start_array();
    jsout.write( r );
    jsout.write( g );
    jsout.write( b );
    if( a != 255 ) {
        jsout.write( a );
    }
    jsout.end_array();
}

void RGBColor::deserialize( const JsonValue &jv )
{
    if( jv.test_string() ) {
        const std::string str = jv.get_string();
        const std::optional<RGBColor> col = try_parse( str );
        if( col.has_value() ) {
            *this = col.value();
        } else {
            debugmsg( "Unknown color value: %s", str );
        }
    } else if( jv.test_array() ) {
        JsonArray arr = jv.get_array();
        if( arr.size() == 3 ) {
            r = static_cast<uint8_t>( std::clamp( arr.get_int( 0 ), 0, 255 ) );
            g = static_cast<uint8_t>( std::clamp( arr.get_int( 1 ), 0, 255 ) );
            b = static_cast<uint8_t>( std::clamp( arr.get_int( 2 ), 0, 255 ) );
            a = 255;
        } else if( arr.size() == 4 ) {
            r = static_cast<uint8_t>( std::clamp( arr.get_int( 0 ), 0, 255 ) );
            g = static_cast<uint8_t>( std::clamp( arr.get_int( 1 ), 0, 255 ) );
            b = static_cast<uint8_t>( std::clamp( arr.get_int( 2 ), 0, 255 ) );
            a = static_cast<uint8_t>( std::clamp( arr.get_int( 3 ), 0, 255 ) );
        } else {
            jv.throw_error( "Invalid color value, expected 3 or 4 element array" );
        }
    } else {
        jv.throw_error( "Invalid color value, expected string or array" );
    }
}

static RGBColor rgb_from_hex_string( std::string str )
{
    if( !str.empty() && str.front() == '#' ) {
        str = str.substr( 1 );
    }

    if( str.empty() || std::any_of( str.begin(), str.end(), []( const char &c ) {
    return !std::isxdigit( static_cast<unsigned char>( c ) );
    } ) ) {
        debugmsg( "Invalid color value: %s", str );
        return {};
    }

    uint32_t d = 0;
    std::istringstream is( str );
    is >> std::hex >> d;
    switch( str.size() ) {
        case 3: {
            const uint8_t nr = static_cast<uint8_t>( ( d >> 8 ) & 0x0F );
            const uint8_t ng = static_cast<uint8_t>( ( d >> 4 ) & 0x0F );
            const uint8_t nb = static_cast<uint8_t>( ( d >> 0 ) & 0x0F );
            return RGBColor{static_cast<uint8_t>( nr | nr << 4 ),
                            static_cast<uint8_t>( ng | ng << 4 ),
                            static_cast<uint8_t>( nb | nb << 4 ),
                            static_cast<uint8_t>( 255 )};
        }
        case 4: {
            const uint8_t nr = static_cast<uint8_t>( ( d >> 12 ) & 0x0F );
            const uint8_t ng = static_cast<uint8_t>( ( d >> 8 ) & 0x0F );
            const uint8_t nb = static_cast<uint8_t>( ( d >> 4 ) & 0x0F );
            const uint8_t na = static_cast<uint8_t>( ( d >> 0 ) & 0x0F );
            return RGBColor{
                static_cast<uint8_t>( nr | nr << 4 ),
                static_cast<uint8_t>( ng | ng << 4 ),
                static_cast<uint8_t>( nb | nb << 4 ),
                static_cast<uint8_t>( na | na << 4 ),
            };
        }
        case 6: {
            return RGBColor{
                static_cast<uint8_t>( d >> 16 ), static_cast<uint8_t>( d >> 8 ),
                static_cast<uint8_t>( d >> 0 ), static_cast<uint8_t>( 255 )};
        }
        case 8: {
            return RGBColor{
                static_cast<uint8_t>( d >> 24 ),
                static_cast<uint8_t>( d >> 16 ),
                static_cast<uint8_t>( d >> 8 ),
                static_cast<uint8_t>( d >> 0 ),
            };
        }
        default:
            debugmsg( "Invalid color value: %s", str );
            return {};
    }
}

std::string RGBColor::to_hex() const
{
    if( a == 255 ) {
        return string_format( "#%02x%02x%02x", r, g, b );
    }
    return string_format( "#%02x%02x%02x%02x", r, g, b, a );
}

RGBColor RGBColor::from_hex( const std::string &str )
{
    return try_parse( str ).value_or( RGBColor{} );
}

std::optional<RGBColor> RGBColor::try_parse( const std::string &str )
{
    if( !str.empty() && str.front() == '#' ) {
        return rgb_from_hex_string( str );
    }

    if( !str.empty() && str.front() == '!' ) {
        return random_named( str.substr( 1 ) ).first;
    }

    const color_manager &cm = get_all_colors();
    const color_id nc_id = cm.name_to_id( str, report_color_error::no );
    if( nc_id != def_c_unset ) {
        return curses_color_to_RGB( cm.get( nc_id ) );
    }

    for( const std::pair<const RGBColor, std::string> &entry : named_colors ) {
        if( str.size() == entry.second.size() &&
            std::equal( str.begin(), str.end(), entry.second.begin(), char_cmp_ignore_case ) ) {
            return entry.first;
        }
    }

    return std::nullopt;
}
