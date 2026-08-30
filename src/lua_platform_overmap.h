#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_OVERMAP_H
#define CATA_SRC_LUA_PLATFORM_OVERMAP_H

#include <point.h>
#include <cstddef>
#include <functional>
#include <memory>
#include <optional>
#include <string>

#include "coordinates.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"

namespace cata::lua_platform
{

struct overmap_tile_token_owner;

/**
 * A value-only identity for one absolute overmap terrain tile.
 *
 * The typed coordinate and generation metadata are copied into the token;
 * no overmap or other borrowed native pointer is retained.
 */
class overmap_tile_token
{
    public:
        overmap_tile_token() = default;
        overmap_tile_token( const tripoint_abs_omt &position,
                            const game_handle_runtime &runtime,
                            std::size_t world_generation );

        const tripoint_abs_omt &native_position() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;
        std::size_t owner_generation() const noexcept;
        bool owner_is_current() const noexcept;
        bool runtime_matches( const game_handle_runtime &runtime ) const noexcept;
        bool world_matches( std::size_t world_generation ) const noexcept;
        std::string to_string() const;

        friend bool operator==( const overmap_tile_token &lhs,
                                const overmap_tile_token &rhs ) noexcept;

    private:
        tripoint_abs_omt position_ = tripoint_abs_omt::invalid;
        game_handle_runtime runtime_;
        std::size_t world_generation_ = 0;
        std::shared_ptr<const overmap_tile_token_owner> owner_;
        std::size_t owner_generation_ = 0;
};

// Invalidate the snapshot revision for one tile.  Call only after the
// mutation has successfully committed.
void notify_overmap_tile_mutation( const tripoint_abs_omt &position );

void reset_overmap_tile_tokens() noexcept;

std::optional<game_handle_error> validate_overmap_tile_token(
    const overmap_tile_token &token,
    const game_handle_runtime &runtime_generation,
    std::size_t world_generation );

// Install bounded, existing-overmap-only observation, search and mutation
// APIs. Calls may load saved overmaps, but never generate new overmaps.
void install_overmap_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<std::size_t( std::size_t )> random_index );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_OVERMAP_H
