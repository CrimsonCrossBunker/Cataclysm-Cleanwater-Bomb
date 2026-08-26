#include "emit.h"

#include <map>
#include <utility>

#include "catalua_content.h"
#include "debug.h"
#include "generic_factory.h"

static std::map<emit_id, emit> emits_all;

const emit *cata::lua::detail::emission_registry_find( const std::string &id )
{
    const auto found = emits_all.find( emit_id( id ) );
    return found == emits_all.end() ? nullptr : &found->second;
}

void cata::lua::detail::emission_registry_set( const emit &value )
{
    emits_all[value.id()] = value;
}

void cata::lua::detail::emission_registry_erase( const std::string &id )
{
    emits_all.erase( emit_id( id ) );
}

/** @relates string_id */
template<>
const emit &string_id<emit>::obj() const
{
    const auto found = emits_all.find( *this );
    if( found == emits_all.end() ) {
        debugmsg( "Tried to get invalid emission data: %s", c_str() );
        static const emit null_emit{};
        return null_emit;
    }
    return found->second;
}

/** @relates string_id */
template<>
bool string_id<emit>::is_valid() const
{
    const auto found = emits_all.find( *this );
    return found != emits_all.end();
}

emit::emit() : id_( emit_id::NULL_ID() ) {}

bool emit::is_null() const
{
    return id_ == emit_id::NULL_ID();
}

void emit::load_emit( const JsonObject &jo )
{
    emit et;

    mandatory( jo, false, "id", et.id_ );
    mandatory( jo, false, "field", et.field_ );
    optional( jo, false, "intensity", et.intensity_, 1.0 );
    optional( jo, false, "qty", et.qty_, 1.0 );
    optional( jo, false, "chance", et.chance_, 100.0 );

    emits_all[ et.id_ ] = et;
}

const std::map<emit_id, emit> &emit::all()
{
    return emits_all;
}

void emit::finalize()
{
}

void emit::check_consistency()
{
}

void emit::reset()
{
    emits_all.clear();
}
