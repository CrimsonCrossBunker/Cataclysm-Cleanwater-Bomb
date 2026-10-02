#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_CONTENT_TEXT_H
#define CATA_SRC_LUA_PLATFORM_CONTENT_TEXT_H

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <optional>
#include <stdexcept>
#include <string>

#include "lua_platform_sol.h"
#include "translation.h"

namespace cata::lua_platform::detail
{

struct localized_text {
    std::string singular;
    std::optional<std::string> plural;
    std::optional<std::string> context;

    translation native() const {
        if( plural ) {
            return context ? translation::pl_translation( *context, singular, *plural ) :
                   translation::pl_translation( singular, *plural );
        }
        return context ? translation::to_translation( *context, singular ) :
               translation::to_translation( singular );
    }
};

inline localized_text make_localized_text( const std::string &singular,
        const std::optional<std::string> &plural,
        const sol::optional<std::string> &context )
{
    if( singular.empty() || singular.find( '\0' ) != std::string::npos ||
        ( plural && ( plural->empty() || plural->find( '\0' ) != std::string::npos ) ) ||
        ( context && context->find( '\0' ) != std::string::npos ) ) {
        throw std::runtime_error( "localized content text requires nonempty source forms without NUL" );
    }
    return { singular, plural, context ? std::optional<std::string>( *context ) : std::nullopt };
}

struct authored_text {
    std::string raw;
    std::optional<localized_text> translated;

    bool empty() const {
        return raw.empty();
    }

    translation native() const {
        return translated ? translated->native() : no_translation( raw );
    }
};

inline authored_text read_singular_text( const sol::object &value, const std::string &fallback,
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

inline authored_text read_singular_text_or( const sol::object &value,
        const authored_text &fallback, const std::string &field )
{
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    return read_singular_text( value, {}, field );
}

} // namespace cata::lua_platform::detail

#endif // CATA_ENABLE_LUA_PLATFORM
#endif // CATA_SRC_LUA_PLATFORM_CONTENT_TEXT_H
