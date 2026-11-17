#include "ammo.h"

#include <algorithm>
#include <limits>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

#include "debug.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "type_id.h"

namespace
{
using ammo_map_t = std::unordered_map<ammotype, ammunition_type>;
std::unordered_map<std::string, std::size_t> mod_load_indices;
} //namespace

ammunition_type::registry_type &ammunition_type::registry()
{
    static registry_type the_map;
    return the_map;
}

ammunition_type::ammunition_type() : name_( no_translation( "null" ) )
{
}

void ammunition_type::set_mod_load_order( const std::vector<mod_id> &mods )
{
    mod_load_indices.clear();
    for( std::size_t i = 0; i < mods.size(); ++i ) {
        mod_load_indices.emplace( mods[i].str(), i + 1 );
    }
}

std::size_t ammunition_type::mod_load_index( const std::string &source )
{
    if( source == "core" ) {
        return 0;
    }
    // Mod interactions and world-local JSON run after regular Mod packs.
    const auto found = mod_load_indices.find( source );
    return found == mod_load_indices.end() ? std::numeric_limits<std::size_t>::max() :
           found->second;
}

void ammunition_type::load_ammunition_type( const JsonObject &jsobj, const std::string &source )
{
    ammunition_type &res = registry()[ ammotype( jsobj.get_string( "id" ) ) ];
    const std::size_t load_order = mod_load_index( source );
    if( jsobj.read( "name", res.name_ ) ) {
        res.json_name_order_ = load_order;
    }
    jsobj.read( "default", res.default_ammotype_, true );
    res.json_default_order_ = load_order;
}

/** @relates string_id */
template<>
bool string_id<ammunition_type>::is_valid() const
{
    return ammunition_type::registry().count( *this ) > 0;
}

/** @relates string_id */
template<>
const ammunition_type &string_id<ammunition_type>::obj() const
{
    const ammo_map_t &the_map = ammunition_type::registry();

    const auto it = the_map.find( *this );
    if( it != the_map.end() ) {
        return it->second;
    }

    debugmsg( "Tried to get invalid ammunition: %s", c_str() );
    static const ammunition_type null_ammunition;
    return null_ammunition;
}

std::vector<std::pair<ammotype, ammunition_type>>
        cata::lua_platform::detail::ammunition_type_registry_snapshot()
{
    std::vector<std::pair<ammotype, ammunition_type>> result;
    const ammunition_type::registry_type &registry = ammunition_type::registry();
    result.reserve( registry.size() );
    for( const auto &[id, value] : registry ) {
        result.emplace_back( id, value );
    }
    std::sort( result.begin(), result.end(),
    []( const auto & left, const auto & right ) {
        return left.first.str() < right.first.str();
    } );
    return result;
}

void ammunition_type::reset()
{
    registry().clear();
    mod_load_indices.clear();
}

void ammunition_type::check_consistency()
{
    for( const auto &ammo : registry() ) {
        const auto &id = ammo.first;
        const itype_id &at = ammo.second.default_ammotype_;

        // FIXME: Remove this insane fake ammo stuff.
        if( at.str() == "components" || at.str() == "thrown" ) {
            continue;
        }

        if( !at.is_empty() && !item::type_is_defined( at ) ) {
            debugmsg( "ammo type %s has invalid default ammo %s", id.c_str(), at.c_str() );
        }
    }
}

std::string ammunition_type::name() const
{
    return name_.translated();
}
