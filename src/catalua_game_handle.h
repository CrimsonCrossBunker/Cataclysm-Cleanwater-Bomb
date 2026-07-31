#pragma once
#ifndef CATA_SRC_CATALUA_GAME_HANDLE_H
#define CATA_SRC_CATALUA_GAME_HANDLE_H

#include <cstddef>
#include <cstdint>
#include <functional>
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
            std::size_t runtime_generation, std::size_t world_generation );
        static game_handle from_item(
            item &value, game_handle_locator locator,
            std::size_t runtime_generation, std::size_t world_generation );
        static game_handle from_vehicle(
            vehicle &value, game_handle_locator locator,
            std::size_t runtime_generation, std::size_t world_generation );

        game_handle_kind kind() const noexcept;
        std::string kind_name() const;
        const game_handle_locator &locator() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;

        native_handle_result<Creature> resolve_creature(
            std::size_t current_runtime_generation,
            std::size_t current_world_generation ) const;
        native_handle_result<item> resolve_item(
            std::size_t current_runtime_generation,
            std::size_t current_world_generation ) const;
        native_handle_result<vehicle> resolve_vehicle(
            std::size_t current_runtime_generation,
            std::size_t current_world_generation ) const;
        std::optional<game_handle_error> validation_error(
            std::size_t current_runtime_generation,
            std::size_t current_world_generation ) const;

    private:
        game_handle_kind kind_ = game_handle_kind::none;
        game_handle_locator locator_;
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
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_GAME_HANDLE_H
