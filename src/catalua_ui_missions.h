#pragma once
#ifndef CATA_SRC_CATALUA_UI_MISSIONS_H
#define CATA_SRC_CATALUA_UI_MISSIONS_H

#include <cstddef>
#include <functional>
#include <string>

#include "catalua_sol.h"

namespace cata::lua_ui
{

class mission_token
{
    public:
        mission_token(
            int uid, std::size_t runtime_generation,
            std::size_t world_generation );

        int uid() const noexcept;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;
        std::string to_string() const;

        friend bool operator==(
            const mission_token &lhs, const mission_token &rhs ) {
            return lhs.uid_ == rhs.uid_ &&
                   lhs.runtime_generation_ ==
                   rhs.runtime_generation_ &&
                   lhs.world_generation_ ==
                   rhs.world_generation_;
        }

    private:
        int uid_ = 0;
        std::size_t runtime_generation_ = 0;
        std::size_t world_generation_ = 0;
};

// Install detached mission definitions plus generation-bound mission tokens.
// Mission pointers and mutable mission_type objects never cross into Lua.
void install_mission_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MISSIONS_H
