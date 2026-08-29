#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_CAMPS_H
#define CATA_SRC_LUA_PLATFORM_CAMPS_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <string>

#include "lua_platform_handle.h"
#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class camp_task_token
{
    public:
        camp_task_token( std::uint64_t task_id, std::uint64_t task_generation,
                         const game_handle &camp, const game_handle &manager,
                         const game_handle &worker,
                         std::uint64_t manager_identity_generation,
                         std::uint64_t worker_identity_generation,
                         const game_handle_runtime &runtime,
                         std::size_t world_generation );

        std::uint64_t task_id() const noexcept;
        std::uint64_t identity_generation() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;
        std::int64_t camp_stable_id() const noexcept;
        std::size_t camp_identity_generation() const noexcept;
        std::int64_t manager_stable_id() const noexcept;
        std::int64_t worker_stable_id() const noexcept;
        std::uint64_t manager_identity_generation() const noexcept;
        std::uint64_t worker_identity_generation() const noexcept;
        bool belongs_to( const game_handle_runtime &runtime ) const noexcept;
        bool matches_context( const game_handle &camp, const game_handle &manager,
                              const game_handle &worker ) const noexcept;
        std::string to_string() const;

        const game_handle &camp_handle() const noexcept {
            return camp_;
        }
        const game_handle &manager_handle() const noexcept {
            return manager_;
        }
        const game_handle &worker_handle() const noexcept {
            return worker_;
        }

        friend bool operator==( const camp_task_token &lhs,
                                const camp_task_token &rhs ) noexcept;

    private:
        std::uint64_t task_id_ = 0;
        std::uint64_t task_generation_ = 0;
        game_handle_runtime runtime_;
        std::size_t world_generation_ = 0;
        game_handle camp_;
        game_handle manager_;
        game_handle worker_;
        std::uint64_t manager_identity_generation_ = 0;
        std::uint64_t worker_identity_generation_ = 0;
};

/**
 * Opaque, generation-safe identity for one exact Platform camp expansion.
 * The token retains the camp context and owner snapshot so an owner change,
 * camp replacement, world reload, or expansion retirement cannot be
 * mistaken for the same expansion.
 */
class camp_expansion_token
{
    public:
        camp_expansion_token( std::uint64_t expansion_id,
                              std::uint64_t expansion_generation,
                              const game_handle &camp,
                              std::string owner_faction,
                              const game_handle_runtime &runtime,
                              std::size_t world_generation );

        std::uint64_t expansion_id() const noexcept;
        std::uint64_t identity_generation() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;
        std::int64_t camp_stable_id() const noexcept;
        std::size_t camp_identity_generation() const noexcept;
        const std::string &owner_faction() const noexcept;
        bool belongs_to( const game_handle_runtime &runtime ) const noexcept;
        bool matches_context( const game_handle &camp ) const noexcept;
        std::string to_string() const;

        const game_handle &camp_handle() const noexcept {
            return camp_;
        }

        friend bool operator==( const camp_expansion_token &lhs,
                                const camp_expansion_token &rhs ) noexcept;

    private:
        std::uint64_t expansion_id_ = 0;
        std::uint64_t expansion_generation_ = 0;
        game_handle_runtime runtime_;
        std::size_t world_generation_ = 0;
        game_handle camp_;
        std::string owner_faction_;
};

// Install bounded faction-camp discovery and control services.
void install_camp_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_CAMPS_H
