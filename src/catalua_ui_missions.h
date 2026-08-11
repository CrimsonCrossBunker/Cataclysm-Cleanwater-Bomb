#pragma once
#ifndef CATA_SRC_CATALUA_UI_MISSIONS_H
#define CATA_SRC_CATALUA_UI_MISSIONS_H

#include <cstddef>
#include <functional>
#include <string>

#include "catalua_game_handle.h"
#include "catalua_sol.h"

namespace cata::lua_ui
{

class mission_token
{
    public:
        mission_token(
            int uid, const game_handle_runtime &runtime,
            std::size_t world_generation );

        int uid() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;
        bool belongs_to( const game_handle_runtime &runtime ) const noexcept;
        std::string to_string() const;

        friend bool operator==(
            const mission_token &lhs, const mission_token &rhs ) {
            return lhs.uid_ == rhs.uid_ &&
                   lhs.runtime_.same_identity( rhs.runtime_ ) &&
                   lhs.world_generation_ ==
                   rhs.world_generation_;
        }

    private:
        int uid_ = 0;
        game_handle_runtime runtime_;
        std::size_t world_generation_ = 0;
};

// Install detached mission definitions plus runtime-owner- and generation-bound
// mission tokens.
// Mission pointers and mutable mission_type objects never cross into Lua.
void install_mission_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MISSIONS_H
