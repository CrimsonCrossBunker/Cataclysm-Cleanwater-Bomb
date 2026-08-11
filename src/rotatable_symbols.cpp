#include "rotatable_symbols.h"

#include <algorithm>
#include <array>
#include <cstdint>
#include <cstdlib>
#include <string>
#include <vector>

#include "catacharset.h"
#include "catalua_platform_content.h"
#include "flexbuffer_json.h"
#include "generic_factory.h"
#include "string_formatter.h"

namespace
{

struct rotatable_symbol {
    uint32_t symbol = 0;
    std::array<uint32_t, 3> rotated_symbol;

    bool operator<( const uint32_t &rhs ) const {
        return symbol < rhs;
    }

    bool operator<( const rotatable_symbol &rhs ) const {
        return symbol < rhs.symbol;
    }
};

std::vector<rotatable_symbol> symbols;

} // anonymous namespace

std::vector<cata::lua_platform::detail::rotatable_symbol_native_entry>
cata::lua_platform::detail::rotatable_symbol_registry_snapshot()
{
    std::vector<rotatable_symbol_native_entry> result;
    result.reserve( symbols.size() );
    for( const rotatable_symbol &entry : symbols ) {
        result.push_back( { entry.symbol, entry.rotated_symbol } );
    }
    return result;
}

std::vector<std::uint32_t> cata::lua_platform::detail::rotatable_symbol_registry_group(
    const std::uint32_t symbol )
{
    const auto found = std::lower_bound( symbols.begin(), symbols.end(), symbol );
    if( found == symbols.end() || found->symbol != symbol ) {
        return {};
    }
    std::vector<std::uint32_t> result = { found->symbol };
    result.insert( result.end(), found->rotated_symbol.begin(), found->rotated_symbol.end() );
    std::sort( result.begin(), result.end() );
    result.erase( std::unique( result.begin(), result.end() ), result.end() );
    return result;
}

void cata::lua_platform::detail::rotatable_symbol_registry_set(
    const std::vector<std::uint32_t> &tuple )
{
    rotatable_symbol temporary;
    for( auto iter = tuple.cbegin(); iter != tuple.cend(); ++iter ) {
        const auto found = std::lower_bound( symbols.begin(), symbols.end(), *iter );
        rotatable_symbol &entry = found != symbols.end() && found->symbol == *iter ?
                                  *found : temporary;
        entry.symbol = *iter;
        auto rotation = iter;
        for( std::uint32_t &value : entry.rotated_symbol ) {
            if( ++rotation == tuple.cend() ) {
                rotation = tuple.cbegin();
            }
            value = *rotation;
        }
        if( found == symbols.end() || found->symbol != *iter ) {
            symbols.insert( found, entry );
        }
    }
}

void cata::lua_platform::detail::rotatable_symbol_registry_restore(
    const std::vector<rotatable_symbol_native_entry> &snapshot )
{
    symbols.clear();
    symbols.reserve( snapshot.size() );
    for( const rotatable_symbol_native_entry &entry : snapshot ) {
        symbols.push_back( { entry.symbol, entry.rotations } );
    }
    std::sort( symbols.begin(), symbols.end() );
}

namespace rotatable_symbols
{

void load( const JsonObject &jo, const std::string &src )
{
    const std::string tuple_key = "tuple";
    const bool strict = src == "dda";

    std::vector<std::string> tuple_temp;

    mandatory( jo, false, tuple_key, tuple_temp );

    if( tuple_temp.size() != 2 && tuple_temp.size() != 4 ) {
        jo.throw_error_at( tuple_key, "Invalid size.  Must be either 2 or 4." );
    }
    std::vector<uint32_t> tuple;
    tuple.reserve( tuple_temp.size() );
    for( std::string &elem : tuple_temp ) {
        tuple.emplace_back( UTF8_getch( elem ) );
    }

    rotatable_symbol temp_entry;

    for( auto iter = tuple.cbegin(); iter != tuple.cend(); ++iter ) {
        const auto entry_iter = std::lower_bound( symbols.begin(), symbols.end(), *iter );
        const bool found = entry_iter != symbols.end() && entry_iter->symbol == *iter;

        if( strict && found ) {
            jo.throw_error_at(
                tuple_key, string_format( "Symbol %ld was already defined.", *iter ) );
        }

        rotatable_symbol &entry = found ? *entry_iter : temp_entry;

        entry.symbol = *iter;

        auto rotation_iter = iter;
        for( unsigned int &element : entry.rotated_symbol ) {
            if( ++rotation_iter == tuple.cend() ) {
                rotation_iter = tuple.cbegin();
            }

            element = *rotation_iter;
        }

        if( !found ) {
            symbols.insert( entry_iter, entry );
        }
    }
}

void reset()
{
    symbols.clear();
}

uint32_t get( const uint32_t &symbol, int n )
{
    n = std::abs( n ) % 4;

    if( n == 0 ) {
        return symbol;
    }

    const auto iter = std::lower_bound( symbols.begin(), symbols.end(), symbol );
    const bool found = iter != symbols.end() && iter->symbol == symbol;

    return found ? iter->rotated_symbol[n - 1] : symbol;
}

} // namespace rotatable_symbols
