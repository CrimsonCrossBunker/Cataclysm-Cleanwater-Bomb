#include "lua_platform_content_text.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

namespace cata::lua_platform::detail
{

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
