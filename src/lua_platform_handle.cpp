#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_handle.h"

#include <stdexcept>
#include <unordered_map>
#include <utility>

#include "avatar.h"
#include "basecamp.h"
#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "creature.h"
#include "item.h"
#include "monster.h"
#include "npc.h"
#include "vehicle.h"

namespace cata::lua_platform
{

struct item_handle_identity_state {
    // Zero is reserved for handles that do not carry a generation-safe Item
    // identity.  A newly registered live Item therefore starts at generation
    // one, and every retirement advances it from there.
    std::size_t generation = 1;
    // The address-keyed registry must not reconnect a new native object to
    // an identity retained by a stale GameHandle after address reuse.
    safe_reference<item> reference;
};

struct camp_handle_identity_state {
    std::uint64_t stable_id = 0;
    std::size_t generation = 0;
    bool active = false;
    safe_reference<basecamp> reference;
};

struct npc_handle_identity_state {
    std::int64_t stable_id = 0;
    std::size_t generation = 0;
    bool active = false;
    // Keep the native lifetime token with the stable-id registry entry.  A
    // replacement with the same stable id must retire the old generation
    // before the new object can receive a handle.
    safe_reference<Creature> reference;
};

struct vehicle_handle_identity_state {
    std::size_t generation = 0;
    // Vehicle addresses can be reused after unload/destroy.  Keep the native
    // lifetime token alongside the address-keyed registry entry.
    safe_reference<vehicle> reference;
};

namespace
{

struct item_identity_registry {
    std::unordered_map<const item *, std::weak_ptr<item_handle_identity_state>> states;
};

struct vehicle_identity_registry {
    std::unordered_map<const vehicle *, std::weak_ptr<vehicle_handle_identity_state>> states;
};

struct npc_identity_registry {
    std::unordered_map<std::int64_t, std::weak_ptr<npc_handle_identity_state>> states;
};

struct camp_identity_registry {
    std::unordered_map<std::uint64_t, std::weak_ptr<camp_handle_identity_state>> states;
};

item_identity_registry &item_identities()
{
    static item_identity_registry registry;
    return registry;
}

std::shared_ptr<item_handle_identity_state> item_identity_for( item &value )
{
    std::weak_ptr<item_handle_identity_state> &stored =
        item_identities().states[&value];
    if( std::shared_ptr<item_handle_identity_state> identity = stored.lock() ) {
        if( identity->reference.get() == &value ) {
            return identity;
        }
    }
    std::shared_ptr<item_handle_identity_state> identity =
        std::make_shared<item_handle_identity_state>();
    identity->reference = value.get_safe_reference();
    stored = identity;
    return identity;
}

vehicle_identity_registry &vehicle_identities()
{
    static vehicle_identity_registry registry;
    return registry;
}

npc_identity_registry &npc_identities()
{
    static npc_identity_registry registry;
    return registry;
}

camp_identity_registry &camp_identities()
{
    static camp_identity_registry registry;
    return registry;
}

std::shared_ptr<camp_handle_identity_state> camp_identity_for(
    basecamp &value, const bool activate )
{
    const std::uint64_t stable_id = value.platform_id();
    std::weak_ptr<camp_handle_identity_state> &stored =
        camp_identities().states[stable_id];
    if( std::shared_ptr<camp_handle_identity_state> identity = stored.lock() ) {
        if( identity->reference.get() == &value ) {
            if( activate && !identity->active ) {
                ++identity->generation;
                identity->active = true;
            }
            return identity;
        }
        ++identity->generation;
        identity->stable_id = stable_id;
        identity->reference = value.get_safe_reference();
        identity->active = activate;
        return identity;
    }
    std::shared_ptr<camp_handle_identity_state> identity =
        std::make_shared<camp_handle_identity_state>();
    identity->stable_id = stable_id;
    identity->reference = value.get_safe_reference();
    identity->active = activate;
    stored = identity;
    return identity;
}

std::shared_ptr<camp_handle_identity_state> camp_identity_for_retirement(
    const basecamp &value )
{
    const auto found = camp_identities().states.find( value.platform_id() );
    if( found == camp_identities().states.end() ) {
        return nullptr;
    }
    const std::shared_ptr<camp_handle_identity_state> identity =
        found->second.lock();
    if( !identity || identity->reference.get() != &value ) {
        return nullptr;
    }
    return identity;
}

std::shared_ptr<npc_handle_identity_state> npc_identity_for(
    npc &value, const bool activate )
{
    const std::int64_t stable_id = value.getID().get_value();
    std::weak_ptr<npc_handle_identity_state> &stored =
        npc_identities().states[stable_id];
    if( std::shared_ptr<npc_handle_identity_state> identity = stored.lock() ) {
        if( identity->reference.get() == &value ) {
            if( activate && !identity->active ) {
                ++identity->generation;
                identity->active = true;
            }
            return identity;
        }
        // A different object now owns the same stable id.  Retire every
        // handle retaining this identity before rebinding the registry.
        ++identity->generation;
        identity->stable_id = stable_id;
        identity->reference = value.get_safe_reference();
        identity->active = activate;
        return identity;
    }
    std::shared_ptr<npc_handle_identity_state> identity =
        std::make_shared<npc_handle_identity_state>();
    identity->stable_id = stable_id;
    identity->reference = value.get_safe_reference();
    identity->active = activate;
    stored = identity;
    return identity;
}

std::shared_ptr<npc_handle_identity_state> npc_identity_for_retirement(
    npc &value )
{
    const auto found = npc_identities().states.find(
                           value.getID().get_value() );
    if( found == npc_identities().states.end() ) {
        return nullptr;
    }
    const std::shared_ptr<npc_handle_identity_state> identity =
        found->second.lock();
    if( !identity || identity->reference.get() != &value ) {
        // A late unload callback from an old object must never retire the
        // replacement that now owns the same stable id.
        return nullptr;
    }
    return identity;
}

game_handle_error stale_npc_identity_error()
{
    return {
        "stale_identity",
        "The GameHandle no longer identifies the same live NPC instance"
    };
}

game_handle_error stale_camp_identity_error()
{
    return {
        "stale_camp",
        "The GameHandle no longer identifies the same live camp instance"
    };
}

std::shared_ptr<vehicle_handle_identity_state> vehicle_identity_for( vehicle &value )
{
    std::weak_ptr<vehicle_handle_identity_state> &stored =
        vehicle_identities().states[&value];
    if( std::shared_ptr<vehicle_handle_identity_state> identity = stored.lock() ) {
        if( identity->reference.get() == &value ) {
            return identity;
        }
    }
    std::shared_ptr<vehicle_handle_identity_state> identity =
        std::make_shared<vehicle_handle_identity_state>();
    identity->reference = value.get_safe_reference();
    stored = identity;
    return identity;
}

game_handle_error wrong_kind_error( const game_handle_kind expected,
                                    const game_handle_kind actual )
{
    return {
        "wrong_kind",
        "GameHandle kind '" + std::string( game_handle_kind_name( actual ) ) +
        "' cannot be used as '" + std::string( game_handle_kind_name( expected ) ) + "'"
    };
}

game_handle_error destroyed_error( const game_handle_kind kind )
{
    return {
        "destroyed",
        "The native " + std::string( game_handle_kind_name( kind ) ) +
        " referenced by this GameHandle no longer exists"
    };
}

game_handle_error dead_error( const game_handle_kind kind )
{
    return {
        "dead",
        "The native " + std::string( game_handle_kind_name( kind ) ) +
        " referenced by this GameHandle is dead"
    };
}

game_handle_error replaced_item_error()
{
    return {
        "stale_item",
        "The item referenced by this GameHandle was transformed or replaced"
    };
}

game_handle_error stale_vehicle_error()
{
    return {
        "stale_vehicle",
        "The Vehicle referenced by this GameHandle was replaced or retired"
    };
}

game_handle_error stale_vehicle_part_error()
{
    return {
        "stale_vehicle_part",
        "The VehiclePart referenced by this GameHandle was removed or replaced"
    };
}

sol::table locator_to_lua( sol::state_view lua, const game_handle_locator &locator )
{
    sol::table result = lua.create_table();
    result["scope"] = locator.scope;
    result["stable_id"] = locator.stable_id;
    sol::table position = lua.create_table();
    position["x"] = locator.x;
    position["y"] = locator.y;
    position["z"] = locator.z;
    result["owner_generation"] = locator.owner_generation;
    result["position"] = std::move( position );
    sol::table path = lua.create_table();
    for( std::size_t index = 0; index < locator.path.size(); ++index ) {
        path[index + 1] = locator.path[index];
    }
    result["path"] = std::move( path );
    return result;
}

sol::table handle_value_to_lua( sol::state_view lua, const game_handle &handle )
{
    sol::table result = lua.create_table();
    result["kind"] = handle.kind_name();
    result["subtype"] = handle.subtype_name();
    result["identity_generation"] = handle.identity_generation();
    result["locator"] = locator_to_lua( lua, handle.locator() );
    return result;
}

} // namespace

game_handle_runtime_owner_ptr make_game_handle_runtime_owner()
{
    return std::make_shared<game_handle_runtime_owner>();
}

bool game_handle_runtime_owner::is_active() const noexcept
{
    return active_.load( std::memory_order_acquire );
}

void game_handle_runtime_owner::retire() const noexcept
{
    active_.store( false, std::memory_order_release );
}

game_handle_runtime::game_handle_runtime(
    const game_handle_runtime_owner_ptr &owner,
    const std::size_t generation ) : owner_( owner ), generation_( generation )
{
}

std::size_t game_handle_runtime::generation() const noexcept
{
    return generation_;
}

bool game_handle_runtime::has_live_owner() const noexcept
{
    const std::shared_ptr<const game_handle_runtime_owner> owner = owner_.lock();
    return owner != nullptr && owner->is_active();
}

bool game_handle_runtime::same_identity(
    const game_handle_runtime &other ) const noexcept
{
    const std::weak_ptr<const game_handle_runtime_owner> empty;
    const bool has_identity = owner_.owner_before( empty ) ||
                              empty.owner_before( owner_ );
    return has_identity && generation_ == other.generation_ &&
           !owner_.owner_before( other.owner_ ) &&
           !other.owner_.owner_before( owner_ );
}

bool game_handle_runtime::is_active_match(
    const game_handle_runtime &other ) const noexcept
{
    return has_live_owner() && other.has_live_owner() &&
           same_identity( other );
}

game_handle game_handle::from_creature(
    Creature &value, game_handle_locator locator,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    game_handle result;
    result.kind_ = game_handle_kind::creature;
    result.locator_ = std::move( locator );
    result.runtime_owner_ = runtime.owner_;
    result.runtime_generation_ = runtime.generation_;
    result.world_generation_ = world_generation;
    result.creature_ = value.get_safe_reference();
    if( npc *npc_value = value.as_npc();
        npc_value != nullptr && npc_value->getID().is_valid() ) {
        result.npc_identity_ = npc_identity_for( *npc_value, true );
        result.npc_identity_generation_ = result.npc_identity_->generation;
        result.npc_stable_id_ = npc_value->getID().get_value();
        result.locator_.stable_id = *result.npc_stable_id_;
    } else if( monster *monster_value = value.as_monster() ) {
        result.locator_.stable_id = monster_value->uid().get_value();
    }
    return result;
}

game_handle game_handle::from_item(
    item &value, game_handle_locator locator,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    game_handle result;
    result.kind_ = game_handle_kind::item;
    result.locator_ = std::move( locator );
    result.runtime_owner_ = runtime.owner_;
    result.runtime_generation_ = runtime.generation_;
    result.world_generation_ = world_generation;
    result.item_ = value.get_safe_reference();
    result.item_identity_ = item_identity_for( value );
    result.item_identity_generation_ = result.item_identity_->generation;
    result.locator_.stable_id = value.uid().get_value();
    result.item_uid_ = value.uid().get_value();
    result.item_type_id_ = value.typeId().str();
    return result;
}

game_handle game_handle::from_vehicle(
    vehicle &value, game_handle_locator locator,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    game_handle result;
    result.kind_ = game_handle_kind::vehicle;
    result.locator_ = std::move( locator );
    result.runtime_owner_ = runtime.owner_;
    result.runtime_generation_ = runtime.generation_;
    result.world_generation_ = world_generation;
    result.vehicle_ = value.get_safe_reference();
    result.vehicle_uid_ = value.uid().get_value();
    result.vehicle_identity_ = vehicle_identity_for( value );
    result.vehicle_identity_generation_ = result.vehicle_identity_->generation;
    result.locator_.stable_id = *result.vehicle_uid_;
    return result;
}

game_handle game_handle::from_vehicle_part(
    vehicle_part &value, vehicle &owner, game_handle_locator locator,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    const std::int64_t part_uid = value.get_base().uid().get_value();
    if( part_uid <= 0 || value.removed || value.is_fake ||
        owner.index_of_part( &value, true ) < 0 ) {
        return game_handle();
    }
    game_handle result;
    result.kind_ = game_handle_kind::vehicle_part;
    result.locator_ = std::move( locator );
    result.runtime_owner_ = runtime.owner_;
    result.runtime_generation_ = runtime.generation_;
    result.world_generation_ = world_generation;
    result.vehicle_ = owner.get_safe_reference();
    result.vehicle_uid_ = owner.uid().get_value();
    result.vehicle_identity_ = vehicle_identity_for( owner );
    result.vehicle_identity_generation_ = result.vehicle_identity_->generation;
    result.vehicle_part_uid_ = part_uid;
    result.locator_.stable_id = *result.vehicle_part_uid_;
    return result;
}

game_handle game_handle::from_camp(
    basecamp &value, game_handle_locator locator,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    game_handle result;
    result.kind_ = game_handle_kind::camp;
    result.locator_ = std::move( locator );
    result.runtime_owner_ = runtime.owner_;
    result.runtime_generation_ = runtime.generation_;
    result.world_generation_ = world_generation;
    result.camp_ = value.get_safe_reference();
    result.camp_identity_ = camp_identity_for( value, true );
    result.camp_identity_generation_ = result.camp_identity_->generation;
    result.locator_.scope = "camp";
    result.locator_.stable_id = static_cast<std::int64_t>( value.platform_id() );
    const tripoint_abs_omt position = value.camp_omt_pos();
    result.locator_.x = position.x();
    result.locator_.y = position.y();
    result.locator_.z = position.z();
    return result;
}

game_handle_kind game_handle::kind() const noexcept
{
    return kind_;
}

std::string game_handle::kind_name() const
{
    return std::string( game_handle_kind_name( kind_ ) );
}

std::string game_handle::subtype_name() const
{
    if( kind_ != game_handle_kind::creature ) {
        return kind_name();
    }
    return locator_.scope.empty() ? "creature" : locator_.scope;
}

const game_handle_locator &game_handle::locator() const noexcept
{
    return locator_;
}

std::size_t game_handle::runtime_generation() const noexcept
{
    return runtime_generation_;
}

std::size_t game_handle::world_generation() const noexcept
{
    return world_generation_;
}

std::size_t game_handle::identity_generation() const noexcept
{
    switch( kind_ ) {
        case game_handle_kind::creature:
            return npc_identity_ ? npc_identity_generation_ : 0;
        case game_handle_kind::item:
            return item_identity_ ? item_identity_generation_ : 0;
        case game_handle_kind::vehicle:
        case game_handle_kind::vehicle_part:
            return vehicle_identity_ ? vehicle_identity_generation_ : 0;
        case game_handle_kind::camp:
            return camp_identity_ ? camp_identity_generation_ : 0;
        case game_handle_kind::none:
            return 0;
    }
    return 0;
}

std::optional<game_handle_error> game_handle::validation_error(
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation ) const
{
    const std::shared_ptr<const game_handle_runtime_owner> owner =
        runtime_owner_.lock();
    const std::shared_ptr<const game_handle_runtime_owner> current_owner =
        current_runtime.owner_.lock();
    if( !owner || !owner->is_active() ) {
        return game_handle_error{
            "stale_runtime",
            "GameHandle owner runtime is no longer alive"
        };
    }
    if( !current_owner || !current_owner->is_active() || owner != current_owner ) {
        return game_handle_error{
            "stale_runtime",
            "GameHandle belongs to a different Lua runtime owner"
        };
    }
    if( runtime_generation_ != current_runtime.generation_ ) {
        return game_handle_error{
            "stale_runtime",
            "GameHandle belongs to an inactive Lua runtime generation"
        };
    }
    if( world_generation_ != current_world_generation ) {
        return game_handle_error{
            "stale_world",
            "GameHandle belongs to a different world generation"
        };
    }
    switch( kind_ ) {
        case game_handle_kind::creature:
            if( !creature_ || creature_.get() == nullptr ) {
                return destroyed_error( kind_ );
            }
            if( creature_.get()->is_dead_state() ) {
                return dead_error( kind_ );
            }
            if( npc_identity_ ) {
                if( !npc_identity_->active ||
                    npc_identity_generation_ != npc_identity_->generation ) {
                    return stale_npc_identity_error();
                }
                const Character *character = creature_.get()->as_character();
                if( !npc_stable_id_ || character == nullptr ||
                    character->getID().get_value() != *npc_stable_id_ ||
                    npc_identity_->stable_id != *npc_stable_id_ ) {
                    return stale_npc_identity_error();
                }
            }
            break;
        case game_handle_kind::item:
            if( !item_ || item_.get() == nullptr ) {
                return destroyed_error( kind_ );
            }
            if( item_.get()->is_null() ) {
                return game_handle_error{
                    "invalid_item",
                    "The GameHandle does not reference a live item instance"
                };
            }
            if( item_uid_ &&
                item_.get()->uid().get_value() != *item_uid_ ) {
                return replaced_item_error();
            }
            if( !item_type_id_.empty() &&
                item_.get()->typeId().str() != item_type_id_ ) {
                return replaced_item_error();
            }
            if( !item_identity_ ||
                item_identity_generation_ != item_identity_->generation ) {
                return replaced_item_error();
            }
            break;
        case game_handle_kind::vehicle:
            if( !vehicle_ ) {
                return destroyed_error( kind_ );
            }
            if( !vehicle_uid_ || *vehicle_uid_ <= 0 ||
                vehicle_.get()->uid().get_value() != *vehicle_uid_ ) {
                return stale_vehicle_error();
            }
            if( !vehicle_identity_ ||
                vehicle_identity_generation_ != vehicle_identity_->generation ) {
                return stale_vehicle_error();
            }
            break;
        case game_handle_kind::vehicle_part:
            if( !vehicle_ ) {
                return destroyed_error( kind_ );
            }
            if( !vehicle_uid_ || *vehicle_uid_ <= 0 ||
                vehicle_.get()->uid().get_value() != *vehicle_uid_ ) {
                return stale_vehicle_error();
            }
            if( !vehicle_identity_ ||
                vehicle_identity_generation_ != vehicle_identity_->generation ) {
                return stale_vehicle_error();
            }
            if( !vehicle_part_uid_ || *vehicle_part_uid_ <= 0 ) {
                return stale_vehicle_part_error();
            }
            break;
        case game_handle_kind::camp:
            if( !camp_ || camp_.get() == nullptr ) {
                return destroyed_error( kind_ );
            }
            if( !camp_identity_ || !camp_identity_->active ||
                camp_identity_generation_ != camp_identity_->generation ||
                camp_identity_->reference.get() != camp_.get() ||
                camp_identity_->stable_id != camp_->platform_id() ) {
                return stale_camp_identity_error();
            }
            if( !camp_->is_valid() ) {
                return game_handle_error{
                    "invalid_camp",
                    "The GameHandle does not reference a live camp"
                };
            }
            break;
        case game_handle_kind::none:
            return game_handle_error{
                "wrong_kind", "GameHandle does not reference a game object"
            };
    }
    return std::nullopt;
}

native_handle_result<Creature> game_handle::resolve_creature(
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation ) const
{
    if( kind_ != game_handle_kind::creature ) {
        return { nullptr, wrong_kind_error( game_handle_kind::creature, kind_ ) };
    }
    if( const std::optional<game_handle_error> error =
            validation_error( current_runtime, current_world_generation ) ) {
        return { nullptr, error };
    }
    Creature *value = creature_.get();
    return value == nullptr ?
           native_handle_result<Creature> { nullptr, destroyed_error( kind_ ) } :
           native_handle_result<Creature> { value, std::nullopt };
}

native_handle_result<item> game_handle::resolve_item(
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation ) const
{
    if( kind_ != game_handle_kind::item ) {
        return { nullptr, wrong_kind_error( game_handle_kind::item, kind_ ) };
    }
    if( const std::optional<game_handle_error> error =
            validation_error( current_runtime, current_world_generation ) ) {
        return { nullptr, error };
    }
    item *value = item_.get();
    return value == nullptr ?
           native_handle_result<item> { nullptr, destroyed_error( kind_ ) } :
           native_handle_result<item> { value, std::nullopt };
}

native_handle_result<vehicle> game_handle::resolve_vehicle(
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation ) const
{
    if( kind_ != game_handle_kind::vehicle ) {
        return { nullptr, wrong_kind_error( game_handle_kind::vehicle, kind_ ) };
    }
    if( const std::optional<game_handle_error> error =
            validation_error( current_runtime, current_world_generation ) ) {
        return { nullptr, error };
    }
    vehicle *value = vehicle_.get();
    return value == nullptr ?
           native_handle_result<vehicle> { nullptr, destroyed_error( kind_ ) } :
           native_handle_result<vehicle> { value, std::nullopt };
}

native_handle_result<basecamp> game_handle::resolve_camp(
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation ) const
{
    if( kind_ != game_handle_kind::camp ) {
        return { nullptr, wrong_kind_error( game_handle_kind::camp, kind_ ) };
    }
    if( const std::optional<game_handle_error> error =
            validation_error( current_runtime, current_world_generation ) ) {
        return { nullptr, error };
    }
    basecamp *value = camp_.get();
    return value == nullptr ?
           native_handle_result<basecamp> { nullptr, destroyed_error( kind_ ) } :
           native_handle_result<basecamp> { value, std::nullopt };
}

native_handle_result<vehicle_part> game_handle::resolve_vehicle_part(
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation ) const
{
    if( kind_ != game_handle_kind::vehicle_part ) {
        return { nullptr, wrong_kind_error( game_handle_kind::vehicle_part, kind_ ) };
    }
    if( const std::optional<game_handle_error> error =
            validation_error( current_runtime, current_world_generation ) ) {
        return { nullptr, error };
    }
    vehicle *owner = vehicle_.get();
    if( owner == nullptr ) {
        return { nullptr, destroyed_error( kind_ ) };
    }
    vehicle_part *match = nullptr;
    for( int index = 0; index < owner->part_count(); ++index ) {
        vehicle_part &candidate = owner->part( index );
        if( candidate.get_base().uid().get_value() != *vehicle_part_uid_ ) {
            continue;
        }
        if( match != nullptr ) {
            return { nullptr, game_handle_error{
                         "duplicate_vehicle_part_identity",
                         "The Vehicle contains duplicate stable VehiclePart identities"
                     } };
        }
        match = &candidate;
    }
    if( match == nullptr || match->removed || match->is_fake ) {
        return { nullptr, stale_vehicle_part_error() };
    }
    return { match, std::nullopt };
}

native_handle_result<vehicle_part> game_handle::resolve_vehicle_part_for_vehicle(
    const game_handle &owner_handle,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation ) const
{
    const native_handle_result<vehicle> owner = owner_handle.resolve_vehicle(
            current_runtime, current_world_generation );
    if( !owner ) {
        return { nullptr, owner.error };
    }
    const native_handle_result<vehicle_part> part = resolve_vehicle_part(
            current_runtime, current_world_generation );
    if( !part ) {
        return part;
    }
    if( vehicle_.get() != owner.value ) {
        return { nullptr, game_handle_error{
                     "wrong_vehicle",
                     "The VehiclePart does not belong to the requested Vehicle"
                 } };
    }
    return part;
}

Creature *resolve_exact_creature(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature( current_runtime, current_world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    error.reset();
    return resolved.value;
}

Character *resolve_exact_character(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    std::optional<game_handle_error> &error )
{
    Creature *creature = resolve_exact_creature(
                             handle, current_runtime, current_world_generation, error );
    if( creature == nullptr ) {
        return nullptr;
    }
    Character *character = creature->as_character();
    if( character == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The GameHandle does not reference a Character"
        };
        return nullptr;
    }
    error.reset();
    return character;
}

npc *resolve_exact_npc(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved = handle.resolve_creature(
            current_runtime, current_world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    if( handle.subtype_name() != "npc" ) {
        error = game_handle_error{
            "wrong_subtype",
            "The GameHandle does not carry the exact NPC subtype"
        };
        return nullptr;
    }
    Character *character = resolved.value->as_character();
    npc *value = character == nullptr ? nullptr : character->as_npc();
    if( value == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The GameHandle does not reference an NPC"
        };
        return nullptr;
    }
    if( handle.locator().stable_id <= 0 ||
        value->getID().get_value() != handle.locator().stable_id ) {
        error = game_handle_error{
            "stale_identity",
            "The GameHandle no longer identifies the same NPC"
        };
        return nullptr;
    }
    error.reset();
    return value;
}

avatar *resolve_exact_avatar(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved = handle.resolve_creature(
            current_runtime, current_world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    if( handle.subtype_name() != "avatar" ) {
        error = game_handle_error{
            "wrong_subtype",
            "The GameHandle does not carry the exact avatar subtype"
        };
        return nullptr;
    }
    Character *character = resolved.value->as_character();
    avatar *value = character == nullptr ? nullptr : character->as_avatar();
    if( value == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The GameHandle does not reference the avatar"
        };
        return nullptr;
    }
    if( handle.locator().stable_id <= 0 ||
        value->getID().get_value() != handle.locator().stable_id ) {
        error = game_handle_error{
            "stale_identity",
            "The GameHandle no longer identifies the same avatar"
        };
        return nullptr;
    }
    error.reset();
    return value;
}

monster *resolve_exact_monster(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved = handle.resolve_creature(
            current_runtime, current_world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    if( handle.subtype_name() != "monster" ) {
        error = game_handle_error{
            "wrong_subtype",
            "The GameHandle does not carry the exact monster subtype"
        };
        return nullptr;
    }
    monster *value = resolved.value->as_monster();
    if( value == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The GameHandle does not reference a monster"
        };
        return nullptr;
    }
    if( handle.locator().stable_id <= 0 ||
        !value->uid().is_valid() ||
        value->uid().get_value() != handle.locator().stable_id ) {
        error = game_handle_error{
            "stale_identity",
            "The GameHandle no longer identifies the same monster"
        };
        return nullptr;
    }
    error.reset();
    return value;
}

bool resolve_exact_item_for_character(
    const game_handle &character_handle,
    const game_handle &item_handle,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    Character *&character,
    item *&entry,
    std::optional<game_handle_error> &error )
{
    character = resolve_exact_character(
                    character_handle, current_runtime,
                    current_world_generation, error );
    if( character == nullptr ) {
        entry = nullptr;
        return false;
    }
    const native_handle_result<item> resolved = item_handle.resolve_item(
            current_runtime, current_world_generation );
    if( !resolved ) {
        entry = nullptr;
        error = resolved.error;
        return false;
    }
    if( !character->has_item( *resolved.value ) ) {
        entry = nullptr;
        error = game_handle_error{
            "not_owned",
            "The Character does not own the referenced item"
        };
        return false;
    }
    entry = resolved.value;
    error.reset();
    return true;
}

void retire_item_handle_identity( item &value )
{
    const std::shared_ptr<item_handle_identity_state> identity =
        item_identity_for( value );
    ++identity->generation;
}

void register_npc_handle_identity( npc &value )
{
    if( !value.getID().is_valid() || value.is_dead() ) {
        return;
    }
    npc_identity_for( value, true );
}

void retire_npc_handle_identity( npc &value )
{
    if( !value.getID().is_valid() ) {
        return;
    }
    const std::shared_ptr<npc_handle_identity_state> identity =
        npc_identity_for_retirement( value );
    if( identity && identity->active ) {
        ++identity->generation;
        identity->active = false;
    }
}

void register_camp_handle_identity( basecamp &value )
{
    if( !value.is_valid() || value.platform_id() == 0 ) {
        return;
    }
    camp_identity_for( value, true );
}

void retire_camp_handle_identity( const basecamp &value )
{
    const std::shared_ptr<camp_handle_identity_state> identity =
        camp_identity_for_retirement( value );
    if( identity && identity->active ) {
        ++identity->generation;
        identity->active = false;
    }
}

void retire_vehicle_handle_identity( vehicle &value )
{
    const std::shared_ptr<vehicle_handle_identity_state> identity =
        vehicle_identity_for( value );
    ++identity->generation;
}

std::string_view game_handle_kind_name( const game_handle_kind kind )
{
    switch( kind ) {
        case game_handle_kind::none:
            return "none";
        case game_handle_kind::creature:
            return "creature";
        case game_handle_kind::item:
            return "item";
        case game_handle_kind::vehicle:
            return "vehicle";
        case game_handle_kind::vehicle_part:
            return "vehicle_part";
        case game_handle_kind::camp:
            return "camp";
    }
    throw std::invalid_argument( "unknown GameHandle kind" );
}

sol::table make_game_value_result( sol::state_view lua, const sol::object &value )
{
    sol::table result = lua.create_table();
    result["ok"] = true;
    result["value"] = value;
    return result;
}

sol::table make_game_error_result( sol::state_view lua, const game_handle_error &error )
{
    sol::table result = lua.create_table();
    result["ok"] = false;
    sol::table detail = lua.create_table();
    detail["code"] = error.code;
    detail["message"] = error.message;
    result["error"] = std::move( detail );
    return result;
}

void install_game_handle_api(
    sol::state &lua, sol::table &services,
    std::function<game_handle_runtime()> current_runtime,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read )
{
    lua.new_usertype<game_handle>(
        "GameHandle", sol::no_constructor,
        "kind", sol::property( &game_handle::kind_name ),
        "subtype", sol::property( &game_handle::subtype_name ),
        "identity_generation", sol::property( &game_handle::identity_generation ),
    "locator", []( sol::this_state lua_state, const game_handle & self ) {
        return locator_to_lua( sol::state_view( lua_state ), self.locator() );
    },
    "is_valid",
    [current_runtime, current_world_generation]( const game_handle & self ) {
        return !self.validation_error(
                   current_runtime(), current_world_generation() );
    },
    "status",
    [current_runtime, current_world_generation](
        sol::this_state lua_state, const game_handle & self ) {
        sol::state_view state( lua_state );
        if( const std::optional<game_handle_error> error =
                self.validation_error(
                    current_runtime(), current_world_generation() ) ) {
            return make_game_error_result( state, *error );
        }
        return make_game_value_result(
                   state, sol::make_object( state, handle_value_to_lua( state, self ) ) );
    } );

    sol::table handles = lua.create_table();
    handles.set_function( "avatar", [
                           current_runtime,
                           current_world_generation,
                           require_read
    ]() {
        require_read();
        avatar &player = get_avatar();
        const tripoint_abs_ms position = player.pos_abs();
        return game_handle::from_creature(
        player, {
            "avatar", player.getID().get_value(),
            position.x(), position.y(), position.z(), {}
        },
        current_runtime(), current_world_generation() );
    } );
    services["handles"] = std::move( handles );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
