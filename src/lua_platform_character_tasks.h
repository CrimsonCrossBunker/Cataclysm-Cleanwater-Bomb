#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_CHARACTER_TASKS_H
#define CATA_SRC_LUA_PLATFORM_CHARACTER_TASKS_H

#include <string>
#include <string_view>

class Character;
class time_point;

namespace cata::lua_platform
{
void queue_character_task( Character &actor, time_point due, std::string_view mod,
                           std::string_view handler );
void ensure_avatar_turn_task( time_point due, std::string_view mod, std::string_view handler );
bool has_avatar_turn_task( std::string_view mod, std::string_view handler );
void invoke_character_task( Character &actor, time_point due, const std::string &mod,
                            const std::string &handler );
void notify_character_ready( Character &actor, bool new_character );
void notify_character_conditions_changed( Character &actor );
} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_CHARACTER_TASKS_H
