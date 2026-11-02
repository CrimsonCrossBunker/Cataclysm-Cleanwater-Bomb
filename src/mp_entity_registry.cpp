#include "mp_entity_registry.h"

#include <algorithm>
#include <stdexcept>
#include <unordered_map>
#include <utility>

#include "creature_tracker.h"
#include "monster.h"
#include "vehicle.h"

namespace cata_mp
{
namespace
{
template<typename T>
struct incarnation {
    decltype( std::declval<T &>().get_safe_reference() ) reference;
    uint32_t id;

    T *get( int64_t uid ) const {
        auto *value = static_cast<T *>( reference.get() );
        return value && value->uid().get_value() == uid ? value : nullptr;
    }
};

template<typename T>
using native_index = std::unordered_map<int64_t, incarnation<T>>;

template<typename T>
uint32_t known_id( const native_index<T> &index, const T &value )
{
    const auto found = index.find( value.uid().get_value() );
    return found != index.end() && found->second.get( found->first ) == &value ?
           found->second.id : 0;
}
} // namespace

struct entity_registry::impl {
    native_index<monster> monsters;
    native_index<vehicle> vehicles;
    std::unordered_map<uint32_t, int64_t> monster_uids;
    uint32_t next_id = 0;
    uint32_t limit;
    std::size_t assignments_until_prune = 64;

    explicit impl( uint32_t limit ) : limit( limit ) {}

    uint32_t allocate() {
        if( next_id == limit ) {
            throw std::overflow_error( "Multiplayer entity ID space exhausted" );
        }
        return ++next_id;
    }

    void prune() {
        if( --assignments_until_prune != 0 ) {
            return;
        }
        for( auto it = monsters.begin(); it != monsters.end(); ) {
            if( !it->second.get( it->first ) ) {
                monster_uids.erase( it->second.id );
                it = monsters.erase( it );
            } else {
                ++it;
            }
        }
        for( auto it = vehicles.begin(); it != vehicles.end(); ) {
            if( !it->second.get( it->first ) ) {
                it = vehicles.erase( it );
            } else {
                ++it;
            }
        }
        assignments_until_prune = std::max<std::size_t>( 64, monsters.size() + vehicles.size() );
    }
};

entity_registry::entity_registry( uint32_t limit ) : impl_( std::make_unique<impl>( limit ) )
{
    if( limit == 0 || limit > INT_MAX ) {
        throw std::invalid_argument( "Invalid multiplayer entity ID limit" );
    }
}
entity_registry::~entity_registry() = default;
entity_registry::entity_registry( entity_registry && ) noexcept = default;
entity_registry &entity_registry::operator=( entity_registry && ) noexcept = default;

uint32_t entity_registry::assign( monster &value )
{
    if( !value.uid().is_valid() ) {
        throw std::invalid_argument( "Monster has no native UID" );
    }
    if( const uint32_t id = known_id( value ) ) {
        return id;
    }
    impl_->prune();
    const uint32_t id = impl_->allocate();
    const int64_t uid = value.uid().get_value();
    const auto previous = impl_->monsters.find( uid );
    if( previous != impl_->monsters.end() ) {
        impl_->monster_uids.erase( previous->second.id );
    }
    impl_->monsters[uid] = { value.get_safe_reference(), id };
    impl_->monster_uids.emplace( id, uid );
    return id;
}

uint32_t entity_registry::assign( vehicle &value )
{
    if( !value.uid().is_valid() ) {
        throw std::invalid_argument( "Vehicle has no native UID" );
    }
    if( const uint32_t id = cata_mp::known_id( impl_->vehicles, value ) ) {
        return id;
    }
    impl_->prune();
    const uint32_t id = impl_->allocate();
    impl_->vehicles[value.uid().get_value()] = { value.get_safe_reference(), id };
    return id;
}

uint32_t entity_registry::known_id( const monster &value ) const
{
    return cata_mp::known_id( impl_->monsters, value );
}

monster *entity_registry::find_monster( uint32_t id, const creature_tracker &tracker ) const
{
    const auto uid = impl_->monster_uids.find( id );
    if( uid == impl_->monster_uids.end() ) {
        return nullptr;
    }
    const auto found = impl_->monsters.find( uid->second );
    monster *value = found == impl_->monsters.end() ? nullptr : found->second.get( uid->second );
    // Native lifetime alone is insufficient: removed-this-turn monsters may be
    // retained by other owners. Never apply a hit to an unloaded/dead object.
    return value && tracker.is_present( value ) ? value : nullptr;
}

std::size_t entity_registry::retained_entries() const
{
    return impl_->monsters.size() + impl_->vehicles.size();
}
} // namespace cata_mp
