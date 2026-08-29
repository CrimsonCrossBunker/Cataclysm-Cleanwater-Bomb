#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_HANDLE_H
#define CATA_SRC_LUA_PLATFORM_HANDLE_H

#include <atomic>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "lua_platform_sol.h"
#include "safe_reference.h"

class Creature;
class Character;
class avatar;
class basecamp;
class item;
class monster;
class npc;
class vehicle;
struct vehicle_part;

namespace cata::lua_platform
{

struct item_handle_identity_state;
struct camp_handle_identity_state;
struct npc_handle_identity_state;
struct vehicle_handle_identity_state;

enum class game_handle_kind : int {
    none,
    creature,
    item,
    vehicle,
    vehicle_part,
    camp
};

struct game_handle_locator {
    std::string scope;
    std::int64_t stable_id = 0;
    int x = 0;
    int y = 0;
    int z = 0;
    std::vector<int> path;
    // Map item locators retain the MapTileToken owner generation separately
    // from the nested-item path.  Other locator kinds leave this at zero.
    std::size_t owner_generation = 0;
};

struct game_handle_error {
    std::string code;
    std::string message;
};

/**
 * Opaque lifetime owner for one native-facing Lua runtime.
 *
 * The token itself is never registered with Lua.  A GameHandle retains only
 * a weak reference, so keeping a handle cannot keep its originating runtime
 * alive.
 */
class game_handle_runtime_owner final
{
    public:
        bool is_active() const noexcept;
        void retire() const noexcept;

    private:
        mutable std::atomic<bool> active_ { true };
};

using game_handle_runtime_owner_ptr =
    std::shared_ptr<const game_handle_runtime_owner>;

game_handle_runtime_owner_ptr make_game_handle_runtime_owner();

/** Explicit owner identity and generation for GameHandle validation. */
class game_handle_runtime
{
    public:
        game_handle_runtime() = default;
        game_handle_runtime( const game_handle_runtime_owner_ptr &owner,
                             std::size_t generation );

        std::size_t generation() const noexcept;
        bool has_live_owner() const noexcept;

        // Compare the complete runtime identity without requiring either
        // owner to still be alive.  weak_ptr ownership ordering keeps this
        // stable for copied handles after their runtime has been destroyed.
        bool same_identity( const game_handle_runtime &other ) const noexcept;

        // True only when both contexts still have a live owner and represent
        // the same owner plus generation.
        bool is_active_match( const game_handle_runtime &other ) const noexcept;

    private:
        friend class game_handle;

        std::weak_ptr<const game_handle_runtime_owner> owner_;
        std::size_t generation_ = 0;
};

template<typename T>
struct native_handle_result {
    T *value = nullptr;
    std::optional<game_handle_error> error;

    explicit operator bool() const {
        return value != nullptr && !error;
    }
};

class game_handle
{
    public:
        game_handle() = default;

        static game_handle from_creature(
            Creature &value, game_handle_locator locator,
            const game_handle_runtime &runtime,
            std::size_t world_generation );
        static game_handle from_item(
            item &value, game_handle_locator locator,
            const game_handle_runtime &runtime,
            std::size_t world_generation );
        static game_handle from_vehicle(
            vehicle &value, game_handle_locator locator,
            const game_handle_runtime &runtime,
            std::size_t world_generation );
        static game_handle from_vehicle_part(
            vehicle_part &value, vehicle &owner, game_handle_locator locator,
            const game_handle_runtime &runtime,
            std::size_t world_generation );
        static game_handle from_camp(
            basecamp &value, game_handle_locator locator,
            const game_handle_runtime &runtime,
            std::size_t world_generation );

        game_handle_kind kind() const noexcept;
        std::string kind_name() const;
        // A bounded identity hint for diagnostics only.  Domain resolvers
        // still validate the native subtype before every access.
        std::string subtype_name() const;
        const game_handle_locator &locator() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;
        std::size_t identity_generation() const noexcept;

        native_handle_result<Creature> resolve_creature(
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;
        native_handle_result<item> resolve_item(
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;
        native_handle_result<vehicle> resolve_vehicle(
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;
        native_handle_result<vehicle_part> resolve_vehicle_part(
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;
        native_handle_result<basecamp> resolve_camp(
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;
        native_handle_result<vehicle_part> resolve_vehicle_part_for_vehicle(
            const game_handle &owner,
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;

        /**
         * Resolve an exact live subtype from a generation-safe creature
         * handle.  Domain services use the shared free helpers below rather
         * than reinterpreting Creature locally.
         */
        std::optional<game_handle_error> validation_error(
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;

    private:
        game_handle_kind kind_ = game_handle_kind::none;
        game_handle_locator locator_;
        std::weak_ptr<const game_handle_runtime_owner> runtime_owner_;
        std::size_t runtime_generation_ = 0;
        std::size_t world_generation_ = 0;
        safe_reference<Creature> creature_;
        // NPC handles are bound to the stable Character id as well as the
        // native safe reference.  The generation is retired when an NPC is
        // unloaded, dies, or is replaced, so a later object with the same id
        // cannot inherit an older handle.
        std::shared_ptr<npc_handle_identity_state> npc_identity_;
        std::size_t npc_identity_generation_ = 0;
        std::optional<std::int64_t> npc_stable_id_;
        safe_reference<basecamp> camp_;
        std::shared_ptr<camp_handle_identity_state> camp_identity_;
        std::size_t camp_identity_generation_ = 0;
        safe_reference<item> item_;
        safe_reference<vehicle> vehicle_;
        std::optional<std::int64_t> vehicle_uid_;
        std::shared_ptr<vehicle_handle_identity_state> vehicle_identity_;
        std::size_t vehicle_identity_generation_ = 0;
        std::optional<std::int64_t> vehicle_part_uid_;
        // Item handles are invalidated when the stable item identity changes,
        // including an in-place type transform that preserves the address.
        std::shared_ptr<item_handle_identity_state> item_identity_;
        std::size_t item_identity_generation_ = 0;
        std::optional<std::int64_t> item_uid_;
        std::string item_type_id_;
};

Creature *resolve_exact_creature(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    std::optional<game_handle_error> &error );
Character *resolve_exact_character(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    std::optional<game_handle_error> &error );
npc *resolve_exact_npc(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    std::optional<game_handle_error> &error );
avatar *resolve_exact_avatar(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    std::optional<game_handle_error> &error );
monster *resolve_exact_monster(
    const game_handle &handle,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    std::optional<game_handle_error> &error );

/** Resolve an exact item and its exact Character holder in one operation. */
bool resolve_exact_item_for_character(
    const game_handle &character_handle,
    const game_handle &item_handle,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    Character *&character,
    item *&entry,
    std::optional<game_handle_error> &error );

/** Retire all handles for an in-place item transformation. */
void retire_item_handle_identity( item &value );

/** Register the live identity boundary for one exact NPC instance. */
void register_npc_handle_identity( npc &value );

/** Retire all handles for an NPC unload, death, or replacement boundary. */
void retire_npc_handle_identity( npc &value );

/** Register the live identity boundary for one exact basecamp instance. */
void register_camp_handle_identity( basecamp &value );

/** Retire all handles for camp removal, relocation, or replacement. */
void retire_camp_handle_identity( const basecamp &value );

/** Retire all handles for a vehicle replacement or destruction boundary. */
void retire_vehicle_handle_identity( vehicle &value );

std::string_view game_handle_kind_name( game_handle_kind kind );

// Standard Lua API result envelopes.  Native pointers are never accepted here:
// successful values must already be Lua-owned userdata or detached values.
sol::table make_game_value_result( sol::state_view lua, const sol::object &value );
sol::table make_game_error_result( sol::state_view lua, const game_handle_error &error );

void install_game_handle_api(
    sol::state &lua, sol::table &services,
    std::function<game_handle_runtime()> current_runtime,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_HANDLE_H
