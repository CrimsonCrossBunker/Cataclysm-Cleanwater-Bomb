#pragma once
#ifndef CATA_SRC_CATALUA_GAME_HANDLE_H
#define CATA_SRC_CATALUA_GAME_HANDLE_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "catalua_sol.h"
#include "safe_reference.h"

class Creature;
class item;
class vehicle;

namespace cata::lua_ui
{

enum class game_handle_kind : int {
    none,
    creature,
    item,
    vehicle
};

struct game_handle_locator {
    std::string scope;
    std::int64_t stable_id = 0;
    int x = 0;
    int y = 0;
    int z = 0;
    std::vector<int> path;
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

        game_handle_kind kind() const noexcept;
        std::string kind_name() const;
        const game_handle_locator &locator() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;

        native_handle_result<Creature> resolve_creature(
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;
        native_handle_result<item> resolve_item(
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;
        native_handle_result<vehicle> resolve_vehicle(
            const game_handle_runtime &current_runtime,
            std::size_t current_world_generation ) const;
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
        safe_reference<item> item_;
        safe_reference<vehicle> vehicle_;
};

std::string_view game_handle_kind_name( game_handle_kind kind );

// Standard Lua API result envelopes.  Native pointers are never accepted here:
// successful values must already be Lua-owned userdata or detached values.
sol::table make_game_value_result( sol::state_view lua, const sol::object &value );
sol::table make_game_error_result( sol::state_view lua, const game_handle_error &error );

void install_game_handle_api(
    sol::state &lua, sol::table &game,
    std::function<game_handle_runtime()> current_runtime,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_GAME_HANDLE_H
