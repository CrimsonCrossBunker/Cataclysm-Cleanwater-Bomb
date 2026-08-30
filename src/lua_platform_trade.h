#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_TRADE_H
#define CATA_SRC_LUA_PLATFORM_TRADE_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <string>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class game_handle_runtime;

/**
 * Opaque read-only trade quote identity.
 *
 * The state is retained only by the active Platform trade-quote registry and
 * by Lua userdata.  It contains no save representation and is retired when
 * the owning runtime or world is replaced.
 */
class trade_quote_token
{
    public:
        struct state;

        trade_quote_token() = default;
        explicit trade_quote_token( std::shared_ptr<state> value );

        std::uint64_t quote_id() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;
        std::int64_t seller_stable_id() const noexcept;
        std::int64_t buyer_stable_id() const noexcept;
        std::size_t seller_identity_generation() const noexcept;
        std::size_t buyer_identity_generation() const noexcept;
        std::uint64_t holder_mutation_generation() const noexcept;
        std::uint64_t pricing_generation() const noexcept;
        std::uint64_t faction_generation() const noexcept;
        std::uint64_t debt_generation() const noexcept;
        std::uint64_t opinion_generation() const noexcept;
        std::int64_t issued_turn() const noexcept;
        std::int64_t expires_turn() const noexcept;
        bool registered() const noexcept;
        std::string to_string() const;

        // Internal snapshot access for the native get/validation boundary.
        // The pointed-to value is immutable through this const token view and
        // is never exposed as a borrowed native object to Lua.
        const state *state_ptr() const noexcept;

        friend bool operator==( const trade_quote_token &lhs,
                                const trade_quote_token &rhs ) noexcept;

    private:
        std::shared_ptr<state> state_;
};

// Retire every non-persistent quote owned by the active Platform runtime.
// Runtime lifecycle code calls this on world/runtime replacement and shutdown.
void retire_trade_quote_registry() noexcept;

// Install the generation-checked explicit quote/get/commit boundary.
void install_trade_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_TRADE_H
