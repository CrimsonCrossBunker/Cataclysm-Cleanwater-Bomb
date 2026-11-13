#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_NPC_SERVICES_H
#define CATA_SRC_LUA_PLATFORM_NPC_SERVICES_H

#include <cstddef>
#include <functional>
#include <memory>

#include "lua_platform_sol.h"

struct dialogue;

namespace cata::lua_platform
{

class game_handle_runtime;
namespace dialogue
{
class dialogue_session;
}

// Service calls made by a response use that conversation's native selection.
class scoped_npc_service_dialogue
{
    public:
        scoped_npc_service_dialogue( ::dialogue &conversation,
                                     std::shared_ptr<dialogue::dialogue_session> session );
        ~scoped_npc_service_dialogue();
        scoped_npc_service_dialogue( const scoped_npc_service_dialogue & ) = delete;
        scoped_npc_service_dialogue &operator=( const scoped_npc_service_dialogue & ) = delete;

        static ::dialogue *current( const game_handle_runtime &runtime, std::size_t world );

    private:
        static thread_local const scoped_npc_service_dialogue *current_;
        const scoped_npc_service_dialogue *previous_;
        ::dialogue *conversation_;
        std::shared_ptr<dialogue::dialogue_session> session_;
};

// Add domain-shaped native NPC services without coupling them to EOC names.
void install_npc_domain_services(
    sol::table &npcs,
    const std::function<game_handle_runtime()> &current_runtime_generation,
    const std::function<std::size_t()> &current_world_generation,
    const std::function<void()> &require_read,
    const std::function<void()> &require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_NPC_SERVICES_H
