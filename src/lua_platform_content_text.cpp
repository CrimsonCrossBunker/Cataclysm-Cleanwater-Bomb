#include "lua_platform_content_text.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

namespace cata::lua_platform::detail
{

void install_content_text( sol::table &content )
{
    content.set_function( "text", []( std::string text,
    sol::optional<std::string> context ) {
        std::optional<std::string> ctx = context ? std::optional<std::string>( std::move( *context ) ) :
                                         std::nullopt;
        return make_localized_text( std::move( text ), std::nullopt, std::move( ctx ) );
    } );
    content.set_function( "plural_text", []( std::string singular, std::string plural,
    sol::optional<std::string> context ) {
        std::optional<std::string> ctx = context ? std::optional<std::string>( std::move( *context ) ) :
                                         std::nullopt;
        return make_localized_text( std::move( singular ), std::move( plural ), std::move( ctx ) );
    } );
    content.set_function( "text_without_extraction", []( std::string singular,
    sol::optional<std::string> plural, sol::optional<std::string> context ) {
        std::optional<std::string> pl = plural ? std::optional<std::string>( std::move( *plural ) ) :
                                        std::nullopt;
        std::optional<std::string> ctx = context ? std::optional<std::string>( std::move( *context ) ) :
                                         std::nullopt;
        return make_localized_text( std::move( singular ), std::move( pl ), std::move( ctx ) );
    } );
}

authored_text read_singular_text( const sol::object &value, const std::string &fallback,
                                  const std::string &field )
{
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return { fallback, std::nullopt };
    }
    if( value.is<localized_text>() ) {
        const localized_text &text = value.as<const localized_text &>();
        if( text.plural ) {
            throw std::runtime_error( field + " does not accept plural text" );
        }
        return { text.singular, text };
    }
    return { value.as<std::string>(), std::nullopt };
}

} // namespace cata::lua_platform::detail

#endif
