#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_WORLD_H
#define CATA_SRC_LUA_PLATFORM_WORLD_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <optional>
#include <string>

#include "coordinates.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"

namespace cata::lua_platform
{

struct map_tile_token_owner;

/**
 * A value-only identity for one loaded absolute map square.
 *
 * The native coordinate and generation metadata are copied into the token;
 * no map, submap, item, vehicle, or other borrowed native pointer is retained.
 */
class map_tile_token
{
    public:
        map_tile_token() = default;
        map_tile_token( const tripoint_abs_ms &position,
                        const game_handle_runtime &runtime,
                        std::size_t world_generation );

        const tripoint_abs_ms &native_position() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;
        std::size_t owner_generation() const noexcept;
        bool owner_is_current() const noexcept;
        bool runtime_matches( const game_handle_runtime &runtime ) const noexcept;
        bool world_matches( std::size_t world_generation ) const noexcept;
        std::string to_string() const;

        friend bool operator==( const map_tile_token &lhs,
                                const map_tile_token &rhs ) noexcept;

    private:
        tripoint_abs_ms position_ = tripoint_abs_ms::invalid;
        game_handle_runtime runtime_;
        std::size_t world_generation_ = 0;
        std::shared_ptr<const map_tile_token_owner> owner_;
        std::size_t owner_generation_ = 0;
};

// Platform-only compare-and-swap revision for services.map.  Native map
// mutations outside this API deliberately do not advance this epoch.
std::uint64_t map_mutation_epoch() noexcept;
void bump_map_mutation_epoch() noexcept;
void reset_map_tile_tokens() noexcept;

// Validate a token against the active runtime/world and currently loaded map
// bubble without exposing the resolved native map pointer to another domain.
std::optional<game_handle_error> validate_map_tile_token(
    const map_tile_token &token,
    const game_handle_runtime &runtime_generation,
    std::size_t world_generation );

// Install bounded active-map observation and mutation APIs.  Map, item and
// vehicle pointers never cross into Lua; live objects use generation-bound
// GameHandle values and all coordinates are explicitly typed.
void install_world_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

// Install the generation-bound MapTileToken and token-gated map snapshot/edit
// APIs under services.map.
void install_map_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_WORLD_H
