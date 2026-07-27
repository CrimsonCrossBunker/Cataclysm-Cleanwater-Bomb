#include "ui_profile.h"

#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <initializer_list>
#include <iterator>
#include <mutex>
#include <optional>
#include <stdexcept>
#include <string>

#include "android_ui_mode.h"

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
    #include "catalua_sol.h"
    #include "path_info.h"
#endif

namespace cata::ui
{

namespace
{

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
namespace fs = std::filesystem;

constexpr int profile_schema = 1;
constexpr std::size_t profile_file_limit = 64U * 1024U;
constexpr std::size_t profile_memory_limit = 2U * 1024U * 1024U;
constexpr int profile_instruction_limit = 25000;

struct profile_memory_tracker {
    std::size_t used = 0;
};

void *profile_allocator( void *userdata, void *pointer, std::size_t old_size,
                         std::size_t new_size )
{
    profile_memory_tracker &tracker = *static_cast<profile_memory_tracker *>( userdata );
    if( new_size == 0 ) {
        tracker.used = old_size > tracker.used ? 0 : tracker.used - old_size;
        std::free( pointer );
        return nullptr;
    }

    const std::size_t current = pointer == nullptr ? 0 : old_size;
    const std::size_t used_without_current = tracker.used - std::min( tracker.used, current );
    if( new_size > profile_memory_limit - used_without_current ) {
        return nullptr;
    }
    void *result = std::realloc( pointer, new_size );
    if( result != nullptr ) {
        tracker.used = used_without_current + new_size;
    }
    return result;
}

void profile_instruction_hook( lua_State *lua, lua_Debug * )
{
    luaL_error( lua, "UI profile instruction budget exceeded" );
}

class profile_instruction_guard
{
    public:
        explicit profile_instruction_guard( lua_State *lua ) : lua_( lua ),
            old_hook_( lua_gethook( lua ) ), old_mask_( lua_gethookmask( lua ) ),
            old_count_( lua_gethookcount( lua ) ) {
            lua_sethook( lua_, profile_instruction_hook, LUA_MASKCOUNT,
                         profile_instruction_limit );
        }

        profile_instruction_guard( const profile_instruction_guard & ) = delete;
        profile_instruction_guard &operator=( const profile_instruction_guard & ) = delete;

        ~profile_instruction_guard() {
            lua_sethook( lua_, old_hook_, old_mask_, old_count_ );
        }

    private:
        lua_State *lua_;
        lua_Hook old_hook_;
        int old_mask_;
        int old_count_;
};

bool valid_profile_id( const std::string &id )
{
    return !id.empty() && id.size() <= 64 &&
    std::all_of( id.begin(), id.end(), []( const unsigned char ch ) {
        return std::isalnum( ch ) != 0 || ch == '_' || ch == '-';
    } );
}

sol::object optional_field( const sol::table &table, const char *name )
{
    const sol::object value = table[name];
    return value.valid() && value.get_type() != sol::type::nil ? value : sol::object();
}

void validate_table_keys( const sol::table &table,
                          const std::initializer_list<std::string_view> allowed,
                          const std::string_view context )
{
    for( const auto &entry : table ) {
        const sol::object key = entry.first;
        if( key.get_type() != sol::type::string ) {
            throw std::invalid_argument( std::string( context ) +
                                         " keys must be strings" );
        }
        const std::string name = key.as<std::string>();
        if( std::find( allowed.begin(), allowed.end(), name ) == allowed.end() ) {
            throw std::invalid_argument( std::string( context ) +
                                         " contains unknown field '" + name + "'" );
        }
    }
}

std::string string_field( const sol::table &table, const char *name,
                          const std::string &fallback )
{
    const sol::object value = optional_field( table, name );
    if( !value.valid() ) {
        return fallback;
    }
    if( value.get_type() != sol::type::string ) {
        throw std::invalid_argument( std::string( "UI profile field '" ) + name +
                                     "' must be a string" );
    }
    return value.as<std::string>();
}

bool bool_field( const sol::table &table, const char *name, const bool fallback )
{
    const sol::object value = optional_field( table, name );
    if( !value.valid() ) {
        return fallback;
    }
    if( value.get_type() != sol::type::boolean ) {
        throw std::invalid_argument( std::string( "UI profile field '" ) + name +
                                     "' must be a boolean" );
    }
    return value.as<bool>();
}

float number_field( const sol::table &table, const char *name, const float fallback,
                    const float minimum, const float maximum )
{
    const sol::object value = optional_field( table, name );
    if( !value.valid() ) {
        return fallback;
    }
    if( value.get_type() != sol::type::number ) {
        throw std::invalid_argument( std::string( "UI profile field '" ) + name +
                                     "' must be a number" );
    }
    const double parsed = value.as<double>();
    if( !std::isfinite( parsed ) || parsed < minimum || parsed > maximum ) {
        throw std::invalid_argument( std::string( "UI profile field '" ) + name +
                                     "' is outside its accepted range" );
    }
    return static_cast<float>( parsed );
}

int integer_field( const sol::table &table, const char *name, const int fallback,
                   const int minimum, const int maximum )
{
    const sol::object value = optional_field( table, name );
    if( !value.valid() ) {
        return fallback;
    }
    if( value.get_type() != sol::type::number || !value.is<lua_Integer>() ) {
        throw std::invalid_argument( std::string( "UI profile field '" ) + name +
                                     "' must be an integer" );
    }
    const lua_Integer parsed = value.as<lua_Integer>();
    if( parsed < minimum || parsed > maximum ) {
        throw std::invalid_argument( std::string( "UI profile field '" ) + name +
                                     "' is outside its accepted range" );
    }
    return static_cast<int>( parsed );
}

sol::table table_field( const sol::table &table, const char *name )
{
    const sol::object value = optional_field( table, name );
    if( !value.valid() || value.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( "UI profile field '" ) + name +
                                     "' must be a table" );
    }
    return value.as<sol::table>();
}

input_mode input_mode_from_name( const std::string &name )
{
    if( name == "touch" ) {
        return input_mode::touch;
    }
    if( name == "mouse_keyboard" ) {
        return input_mode::mouse_keyboard;
    }
    if( name == "terminal" ) {
        return input_mode::terminal;
    }
    throw std::invalid_argument( "UI profile input must be touch, mouse_keyboard, or terminal" );
}

density_mode density_mode_from_name( const std::string &name )
{
    if( name == "touch" ) {
        return density_mode::touch;
    }
    if( name == "comfortable" ) {
        return density_mode::comfortable;
    }
    if( name == "compact" ) {
        return density_mode::compact;
    }
    throw std::invalid_argument( "UI profile density must be touch, comfortable, or compact" );
}
#endif

profile fallback_for_build()
{
#if defined(__ANDROID__)
    return make_profile( android_ui_mode::is_new_ui_build() ?
                         input_mode::touch : input_mode::mouse_keyboard );
#elif defined(TILES)
    return make_profile( input_mode::mouse_keyboard );
#else
    return make_profile( input_mode::terminal );
#endif
}

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
std::string selected_profile_id()
{
#if defined(__ANDROID__)
    return android_ui_mode::is_new_ui_build() ? "android_touch" : "pc_legacy";
#elif defined(TILES)
    return "pc_legacy";
#else
    return "terminal_legacy";
#endif
}

bool read_profile_file( const fs::path &path, std::string &source, std::string &error )
{
    std::error_code size_error;
    const std::uintmax_t size = fs::file_size( path, size_error );
    if( size_error ) {
        error = path.string() + ": " + size_error.message();
        return false;
    }
    if( size > profile_file_limit ) {
        error = path.string() + ": UI profile exceeds 64 KiB";
        return false;
    }

    std::ifstream input( path, std::ios::binary );
    if( !input ) {
        error = path.string() + ": unable to open UI profile";
        return false;
    }
    source.assign( std::istreambuf_iterator<char>( input ),
                   std::istreambuf_iterator<char>() );
    if( input.bad() ) {
        error = path.string() + ": unable to read UI profile";
        return false;
    }
    if( source.size() > profile_file_limit ) {
        error = path.string() + ": UI profile exceeds 64 KiB";
        return false;
    }
    return true;
}

bool load_selected_profile( profile &loaded, std::string &error )
{
    const profile fallback = fallback_for_build();
    const std::string expected_id = selected_profile_id();
    const fs::path path = fs::u8path( PATH_INFO::datadir() ) / "lua" / "ui" /
                          "profiles" / ( expected_id + ".lua" );
    std::string source;
    if( !read_profile_file( path, source, error ) ||
        !load_profile_from_lua( source, path.string(), fallback, loaded, error ) ) {
        loaded = fallback;
        return false;
    }
    if( loaded.id != expected_id ) {
        error = path.string() + ": profile id must be '" + expected_id + "'";
        loaded = fallback;
        return false;
    }
    if( loaded.input != fallback.input ) {
        error = path.string() + ": profile input must be '" +
                std::string( input_mode_name( fallback.input ) ) + "'";
        loaded = fallback;
        return false;
    }
    return true;
}
#else
bool load_selected_profile( profile &loaded, std::string &error )
{
    loaded = fallback_for_build();
    error.clear();
    return true;
}
#endif

std::mutex profile_mutex;
std::optional<profile> active_profile;
std::string active_profile_error;

} // namespace

bool profile::is_touch() const
{
    return input == input_mode::touch;
}

bool profile::is_terminal() const
{
    return input == input_mode::terminal;
}

float profile::item_width( const size_token token ) const
{
    switch( token ) {
        case size_token::compact:
            return width_compact;
        case size_token::normal:
            return width_normal;
        case size_token::wide:
            return width_wide;
        case size_token::fill:
            return -1.0F;
    }
    return width_normal;
}

float profile::row_height( const size_token token ) const
{
    switch( token ) {
        case size_token::compact:
            return row_compact;
        case size_token::normal:
            return row_normal;
        case size_token::wide:
            return row_wide;
        case size_token::fill:
            return row_normal;
    }
    return row_normal;
}

float profile::panel_height( const size_token token ) const
{
    switch( token ) {
        case size_token::compact:
            return panel_compact;
        case size_token::normal:
            return panel_normal;
        case size_token::wide:
            return panel_wide;
        case size_token::fill:
            return 0.0F;
    }
    return panel_normal;
}

layout_breakpoint profile::breakpoint_for_width( const float available_width ) const
{
    if( available_width < breakpoint_narrow ) {
        return layout_breakpoint::narrow;
    }
    if( available_width >= breakpoint_wide ) {
        return layout_breakpoint::wide;
    }
    return layout_breakpoint::regular;
}

profile make_profile( const input_mode input )
{
    profile result;
    result.input = input;
    switch( input ) {
        case input_mode::touch:
            result.id = "android_touch";
            result.density = density_mode::touch;
            result.text_scale = 1.20F;
            result.minimum_target = 48.0F;
            result.frame_padding_x = 12.0F;
            result.frame_padding_y = 8.0F;
            result.item_spacing_x = 8.0F;
            result.item_spacing_y = 7.0F;
            result.corner_radius = 8.0F;
            result.page_width = 1.0F;
            result.page_height = 1.0F;
            result.width_compact = 160.0F;
            result.width_normal = 260.0F;
            result.width_wide = 420.0F;
            result.row_compact = 48.0F;
            result.row_normal = 56.0F;
            result.row_wide = 68.0F;
            result.panel_compact = 180.0F;
            result.panel_normal = 320.0F;
            result.panel_wide = 520.0F;
            result.breakpoint_narrow = 720.0F;
            result.breakpoint_wide = 1200.0F;
            result.allow_hover = false;
            result.allow_swipe = true;
            result.native_text_input = true;
            result.keyboard_navigation = false;
            result.pointer_activation = false;
            result.tap_activation = true;
            result.long_press_dangerous = true;
            result.use_touch_main_menu = true;
            break;
        case input_mode::mouse_keyboard:
            result.id = "pc_legacy";
            result.density = density_mode::comfortable;
            result.text_scale = 1.0F;
            result.minimum_target = 34.0F;
            result.frame_padding_x = 9.0F;
            result.frame_padding_y = 5.0F;
            result.item_spacing_x = 8.0F;
            result.item_spacing_y = 5.0F;
            result.corner_radius = 5.0F;
            result.page_width = 0.88F;
            result.page_height = 0.88F;
            result.width_compact = 160.0F;
            result.width_normal = 240.0F;
            result.width_wide = 360.0F;
            result.row_compact = 28.0F;
            result.row_normal = 34.0F;
            result.row_wide = 42.0F;
            result.panel_compact = 160.0F;
            result.panel_normal = 280.0F;
            result.panel_wide = 440.0F;
            result.breakpoint_narrow = 720.0F;
            result.breakpoint_wide = 1280.0F;
            result.allow_hover = true;
            result.allow_swipe = false;
            result.native_text_input = false;
            result.keyboard_navigation = true;
            result.pointer_activation = true;
            result.tap_activation = false;
            result.long_press_dangerous = false;
            result.use_touch_main_menu = false;
            break;
        case input_mode::terminal:
            result.id = "terminal_legacy";
            result.density = density_mode::compact;
            result.text_scale = 1.0F;
            result.minimum_target = 1.0F;
            result.frame_padding_x = 1.0F;
            result.frame_padding_y = 0.0F;
            result.item_spacing_x = 1.0F;
            result.item_spacing_y = 0.0F;
            result.corner_radius = 0.0F;
            result.page_width = 0.92F;
            result.page_height = 0.92F;
            result.width_compact = 18.0F;
            result.width_normal = 28.0F;
            result.width_wide = 42.0F;
            result.row_compact = 1.0F;
            result.row_normal = 1.0F;
            result.row_wide = 2.0F;
            result.panel_compact = 8.0F;
            result.panel_normal = 14.0F;
            result.panel_wide = 22.0F;
            result.breakpoint_narrow = 80.0F;
            result.breakpoint_wide = 132.0F;
            result.allow_hover = false;
            result.allow_swipe = false;
            result.native_text_input = false;
            result.keyboard_navigation = true;
            result.pointer_activation = false;
            result.tap_activation = false;
            result.long_press_dangerous = false;
            result.use_touch_main_menu = false;
            break;
    }
    return result;
}

profile current_profile()
{
    std::scoped_lock lock( profile_mutex );
    if( !active_profile ) {
        profile loaded;
        load_selected_profile( loaded, active_profile_error );
        active_profile = std::move( loaded );
    }
    return *active_profile;
}

bool reload_profile( std::string &error )
{
    profile loaded;
    const bool valid = load_selected_profile( loaded, error );
    std::scoped_lock lock( profile_mutex );
    active_profile = std::move( loaded );
    active_profile_error = error;
    return valid;
}

std::string profile_last_error()
{
    std::scoped_lock lock( profile_mutex );
    return active_profile_error;
}

bool load_profile_from_lua( const std::string_view source, const std::string_view source_name,
                            const profile &fallback, profile &result, std::string &error )
{
#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
    try {
        profile_memory_tracker memory;
        sol::state lua( sol::default_at_panic, profile_allocator, &memory );
        const sol::load_result loaded = lua.load( std::string( source ),
                                        std::string( source_name ), sol::load_mode::text );
        if( !loaded.valid() ) {
            const sol::error load_error = loaded;
            throw std::runtime_error( load_error.what() );
        }
        sol::protected_function function = loaded;
        profile_instruction_guard guard( lua.lua_state() );
        const sol::protected_function_result returned = function();
        if( !returned.valid() ) {
            const sol::error runtime_error = returned;
            throw std::runtime_error( runtime_error.what() );
        }
        if( returned.return_count() != 1 || returned.get_type() != sol::type::table ) {
            throw std::invalid_argument( "UI profile must return exactly one table" );
        }

        const sol::table root = returned;
        validate_table_keys(
            root, { "schema", "id", "input", "density", "metrics", "interaction" },
            "UI profile" );
        profile parsed = fallback;
        parsed.schema = integer_field( root, "schema", 0, profile_schema, profile_schema );
        if( parsed.schema != profile_schema ) {
            throw std::invalid_argument( "UI profile schema must be 1" );
        }
        parsed.id = string_field( root, "id", "" );
        if( !valid_profile_id( parsed.id ) ) {
            throw std::invalid_argument(
                "UI profile id must contain 1 to 64 letters, digits, '-' or '_'" );
        }
        parsed.input = input_mode_from_name(
                           string_field( root, "input", std::string( input_mode_name( fallback.input ) ) ) );
        parsed.density = density_mode_from_name(
                             string_field( root, "density",
                                           std::string( density_mode_name( fallback.density ) ) ) );

        const sol::table metrics = table_field( root, "metrics" );
        validate_table_keys(
        metrics, {
            "text_scale", "minimum_target", "frame_padding_x", "frame_padding_y",
            "item_spacing_x", "item_spacing_y", "corner_radius", "page_width",
            "page_height", "width_compact", "width_normal", "width_wide",
            "row_compact", "row_normal", "row_wide", "panel_compact",
            "panel_normal", "panel_wide", "breakpoint_narrow", "breakpoint_wide"
        },
        "UI profile metrics" );
        parsed.text_scale = number_field( metrics, "text_scale", parsed.text_scale, 0.5F, 3.0F );
        parsed.minimum_target = number_field(
                                    metrics, "minimum_target", parsed.minimum_target, 1.0F, 256.0F );
        parsed.frame_padding_x = number_field(
                                     metrics, "frame_padding_x", parsed.frame_padding_x, 0.0F, 128.0F );
        parsed.frame_padding_y = number_field(
                                     metrics, "frame_padding_y", parsed.frame_padding_y, 0.0F, 128.0F );
        parsed.item_spacing_x = number_field(
                                    metrics, "item_spacing_x", parsed.item_spacing_x, 0.0F, 128.0F );
        parsed.item_spacing_y = number_field(
                                    metrics, "item_spacing_y", parsed.item_spacing_y, 0.0F, 128.0F );
        parsed.corner_radius = number_field(
                                   metrics, "corner_radius", parsed.corner_radius, 0.0F, 128.0F );
        parsed.page_width = number_field(
                                metrics, "page_width", parsed.page_width, 0.25F, 1.0F );
        parsed.page_height = number_field(
                                 metrics, "page_height", parsed.page_height, 0.25F, 1.0F );
        parsed.width_compact = number_field(
                                   metrics, "width_compact", parsed.width_compact, 1.0F, 4096.0F );
        parsed.width_normal = number_field(
                                  metrics, "width_normal", parsed.width_normal, 1.0F, 4096.0F );
        parsed.width_wide = number_field(
                                metrics, "width_wide", parsed.width_wide, 1.0F, 4096.0F );
        parsed.row_compact = number_field(
                                 metrics, "row_compact", parsed.row_compact, 1.0F, 512.0F );
        parsed.row_normal = number_field(
                                metrics, "row_normal", parsed.row_normal, 1.0F, 512.0F );
        parsed.row_wide = number_field(
                              metrics, "row_wide", parsed.row_wide, 1.0F, 512.0F );
        parsed.panel_compact = number_field(
                                   metrics, "panel_compact", parsed.panel_compact, 1.0F, 4096.0F );
        parsed.panel_normal = number_field(
                                  metrics, "panel_normal", parsed.panel_normal, 1.0F, 4096.0F );
        parsed.panel_wide = number_field(
                                metrics, "panel_wide", parsed.panel_wide, 1.0F, 4096.0F );
        parsed.breakpoint_narrow = number_field(
                                       metrics, "breakpoint_narrow", parsed.breakpoint_narrow,
                                       1.0F, 8192.0F );
        parsed.breakpoint_wide = number_field(
                                     metrics, "breakpoint_wide", parsed.breakpoint_wide,
                                     1.0F, 8192.0F );

        if( parsed.width_compact > parsed.width_normal ||
            parsed.width_normal > parsed.width_wide ) {
            throw std::invalid_argument( "UI profile widths must be ordered compact <= normal <= wide" );
        }
        if( parsed.row_compact > parsed.row_normal ||
            parsed.row_normal > parsed.row_wide ) {
            throw std::invalid_argument( "UI profile rows must be ordered compact <= normal <= wide" );
        }
        if( parsed.panel_compact > parsed.panel_normal ||
            parsed.panel_normal > parsed.panel_wide ) {
            throw std::invalid_argument( "UI profile panels must be ordered compact <= normal <= wide" );
        }
        if( parsed.breakpoint_narrow >= parsed.breakpoint_wide ) {
            throw std::invalid_argument( "UI profile narrow breakpoint must be below wide breakpoint" );
        }

        const sol::table interaction = table_field( root, "interaction" );
        validate_table_keys(
        interaction, {
            "hover", "swipe_scroll", "native_text_input", "keyboard_navigation",
            "pointer_activation", "tap_activation", "long_press_dangerous",
            "touch_main_menu"
        },
        "UI profile interaction" );
        parsed.allow_hover = bool_field( interaction, "hover", parsed.allow_hover );
        parsed.allow_swipe = bool_field( interaction, "swipe_scroll", parsed.allow_swipe );
        parsed.native_text_input = bool_field(
                                       interaction, "native_text_input", parsed.native_text_input );
        parsed.keyboard_navigation = bool_field(
                                         interaction, "keyboard_navigation",
                                         parsed.keyboard_navigation );
        parsed.pointer_activation = bool_field(
                                        interaction, "pointer_activation",
                                        parsed.pointer_activation );
        parsed.tap_activation = bool_field(
                                    interaction, "tap_activation", parsed.tap_activation );
        parsed.long_press_dangerous = bool_field(
                                          interaction, "long_press_dangerous",
                                          parsed.long_press_dangerous );
        parsed.use_touch_main_menu = bool_field(
                                         interaction, "touch_main_menu",
                                         parsed.use_touch_main_menu );

        if( parsed.tap_activation && parsed.input != input_mode::touch ) {
            throw std::invalid_argument( "tap_activation requires input='touch'" );
        }
        if( parsed.input == input_mode::touch && !parsed.tap_activation ) {
            throw std::invalid_argument( "touch profiles must enable tap_activation" );
        }

        result = std::move( parsed );
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        result = fallback;
        error = std::string( source_name ) + ": " + exception.what();
        return false;
    }
#else
    ( void )source;
    result = fallback;
    error = std::string( source_name ) + ": Lua UI is not enabled in this build";
    return false;
#endif
}

void reset_profile_cache_for_tests()
{
    std::scoped_lock lock( profile_mutex );
    active_profile.reset();
    active_profile_error.clear();
}

std::string_view input_mode_name( const input_mode input )
{
    switch( input ) {
        case input_mode::touch:
            return "touch";
        case input_mode::mouse_keyboard:
            return "mouse_keyboard";
        case input_mode::terminal:
            return "terminal";
    }
    return "terminal";
}

std::string_view density_mode_name( const density_mode density )
{
    switch( density ) {
        case density_mode::touch:
            return "touch";
        case density_mode::comfortable:
            return "comfortable";
        case density_mode::compact:
            return "compact";
    }
    return "compact";
}

std::string_view layout_breakpoint_name( const layout_breakpoint breakpoint )
{
    switch( breakpoint ) {
        case layout_breakpoint::narrow:
            return "narrow";
        case layout_breakpoint::regular:
            return "regular";
        case layout_breakpoint::wide:
            return "wide";
    }
    return "regular";
}

std::string_view size_token_name( const size_token token )
{
    switch( token ) {
        case size_token::compact:
            return "compact";
        case size_token::normal:
            return "normal";
        case size_token::wide:
            return "wide";
        case size_token::fill:
            return "fill";
    }
    return "normal";
}

bool size_token_from_name( const std::string_view name, size_token &result )
{
    if( name == "compact" ) {
        result = size_token::compact;
    } else if( name == "normal" ) {
        result = size_token::normal;
    } else if( name == "wide" ) {
        result = size_token::wide;
    } else if( name == "fill" ) {
        result = size_token::fill;
    } else {
        return false;
    }
    return true;
}

} // namespace cata::ui
