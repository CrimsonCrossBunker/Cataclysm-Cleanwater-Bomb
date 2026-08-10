#include "ammo.h"

#include <string>
#include <unordered_map>
#include <utility>

#include "debug.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "type_id.h"

namespace
{
using ammo_map_t = std::unordered_map<ammotype, ammunition_type>;
} //namespace

ammunition_type::registry_type &ammunition_type::registry()
{
    static registry_type the_map;
    return the_map;
}

ammunition_type::ammunition_type() : name_( no_translation( "null" ) )
{
}

void ammunition_type::load_ammunition_type( const JsonObject &jsobj )
{
    ammunition_type &res = registry()[ ammotype( jsobj.get_string( "id" ) ) ];
    jsobj.read( "name", res.name_ );
    jsobj.read( "default", res.default_ammotype_, true );
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

void ammunition_type::reset()
{
    registry().clear();
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
