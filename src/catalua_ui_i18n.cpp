#include "catalua_ui_i18n.h"

#include <algorithm>
#include <cstdint>
#include <limits>
#include <stdexcept>
#include <string>

#include "translation.h"
#include "translations.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::size_t maximum_message_bytes = 64U * 1024U;
constexpr std::size_t maximum_context_bytes = 1024U;

void validate_message( const std::string &message, const char *name )
{
    if( message.empty() || message.size() > maximum_message_bytes ) {
        throw std::invalid_argument(
            std::string( name ) + " messages must contain 1 to 65536 bytes" );
    }
}

void validate_context( const std::string &context, const char *name )
{
    if( context.empty() || context.size() > maximum_context_bytes ) {
        throw std::invalid_argument(
            std::string( name ) + " context must contain 1 to 1024 bytes" );
    }
}

int validated_plural_count( const std::int64_t count, const char *name )
{
    if( count < 0 ) {
        throw std::invalid_argument(
            std::string( name ) + " count cannot be negative" );
    }
    return static_cast<int>( std::min<std::int64_t>(
                                 count, std::numeric_limits<int>::max() ) );
}

std::string translate_message( const std::string &message )
{
    validate_message( message, "i18n.gettext" );
    return to_translation( message ).translated();
}

std::string translate_context_message( const std::string &context,
                                       const std::string &message )
{
    validate_context( context, "i18n.pgettext" );
    validate_message( message, "i18n.pgettext" );
    return to_translation( context, message ).translated();
}

std::string translate_plural_message( const std::string &singular,
                                      const std::string &plural,
                                      const std::int64_t count )
{
    validate_message( singular, "i18n.ngettext" );
    validate_message( plural, "i18n.ngettext" );
    return pl_translation( singular, plural ).translated(
               validated_plural_count( count, "i18n.ngettext" ) );
}

std::string translate_context_plural_message(
    const std::string &context, const std::string &singular,
    const std::string &plural, const std::int64_t count )
{
    validate_context( context, "i18n.npgettext" );
    validate_message( singular, "i18n.npgettext" );
    validate_message( plural, "i18n.npgettext" );
    return pl_translation( context, singular, plural ).translated(
               validated_plural_count( count, "i18n.npgettext" ) );
}

} // namespace

void install_i18n_api( sol::state &lua )
{
    sol::table i18n = lua.create_named_table( "i18n" );
    i18n.set_function( "gettext", translate_message );
    i18n.set_function( "pgettext", translate_context_message );
    i18n.set_function( "ngettext", translate_plural_message );
    i18n.set_function( "npgettext", translate_context_plural_message );
    i18n.set_function( "language_revision", []() {
        return detail::get_current_language_version();
    } );
}

} // namespace cata::lua_ui
