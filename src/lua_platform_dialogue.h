#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_DIALOGUE_H
#define CATA_SRC_LUA_PLATFORM_DIALOGUE_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <optional>
#include <set>
#include <string>
#include <string_view>
#include <vector>

#include "lua_platform_hooks.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "dialogue.h"

namespace cata::lua_platform::dialogue
{

struct dialogue_lifetime;
struct dialogue_context_lifetime;

class dialogue_session
{
    public:
        std::uint64_t generation() const noexcept;
        bool active() const noexcept;
        bool active_for( std::string_view topic ) const noexcept;
        bool active_for( std::string_view topic,
                         const ::dialogue *native_dialogue ) const noexcept;
        bool active_for( std::string_view topic,
                         const game_handle_runtime &runtime_identity,
                         std::size_t world_generation,
                         const ::dialogue *native_dialogue ) const noexcept;
        std::optional<game_handle_error> validation_error(
            const ::dialogue *native_dialogue,
            const game_handle_runtime &runtime_identity,
            std::size_t world_generation ) const;
        bool participants_live() const noexcept;
        const native_callback_talker &speaker_snapshot() const noexcept;
        const native_callback_talker &interlocutor_snapshot() const noexcept;

    private:
        friend struct dialogue_lifetime;
        friend std::shared_ptr<dialogue_session> begin_session(
            ::dialogue &d, const game_handle_runtime &runtime_identity,
            std::size_t world_generation );
        friend std::shared_ptr<dialogue_session> session_for(
            ::dialogue &d, std::string_view topic,
            const game_handle_runtime &runtime_identity,
            std::size_t world_generation );
        friend void end_session( ::dialogue &d ) noexcept;
        friend void retire_sessions_for_runtime(
            const game_handle_runtime &runtime_identity ) noexcept;
        friend void retire_sessions_for_world( std::size_t world_generation ) noexcept;
        friend class context;

        dialogue_session( std::uint64_t generation, std::string topic,
                          game_handle_runtime runtime_identity,
                          std::size_t world_generation,
                          std::shared_ptr<dialogue_lifetime> native_lifetime );
        void set_participants( ::dialogue &d );
        void set_topic( std::string topic );
        void deactivate() noexcept;

        std::uint64_t generation_ = 0;
        bool active_ = true;
        std::string topic_;
        game_handle_runtime runtime_identity_;
        std::size_t world_generation_ = 0;
        const ::dialogue *native_dialogue_ = nullptr;
        std::shared_ptr<dialogue_lifetime> native_lifetime_;
        std::vector<std::weak_ptr<dialogue_context_lifetime>> contexts_;
        native_callback_talker speaker_;
        native_callback_talker interlocutor_;
};

using dialogue_session_ptr = std::shared_ptr<dialogue_session>;

/** Register the native dialogue lifetime used by callback-scoped contexts. */
void begin_dialogue( ::dialogue &d );
/** Begin an owner-, world-, and native-lifetime-bound session. */
dialogue_session_ptr begin_session( ::dialogue &d,
                                    const game_handle_runtime &runtime_identity,
                                    std::size_t world_generation );
dialogue_session_ptr session_for( ::dialogue &d, std::string_view topic,
                                  const game_handle_runtime &runtime_identity,
                                  std::size_t world_generation );
void end_session( ::dialogue &d ) noexcept;
void retire_sessions_for_runtime(
    const game_handle_runtime &runtime_identity ) noexcept;
void retire_sessions_for_world( std::size_t world_generation ) noexcept;
void retire_all_sessions() noexcept;

class context
{
    public:
        using actor_converter =
            std::function<sol::object( const native_callback_talker & )>;

        context( lua_State *lua_state, ::dialogue &d, std::string topic_id,
                 bool allow_write, std::string invalid_context_message,
                 actor_converter convert_actor,
                 dialogue_session_ptr session = {},
                 game_handle_runtime runtime_identity = {},
                 std::size_t world_generation = 0 );

        bool valid() const noexcept;
        std::optional<game_handle_error> validation_error() const;
        void invalidate() noexcept;
        std::uint64_t generation() const;
        std::string topic() const;
        std::string topic_item() const;
        bool has_speaker() const;
        bool has_interlocutor() const;
        bool by_radio() const;
        bool has_reason() const;
        std::string reason() const;
        int trial_chance( const std::string &kind, int difficulty,
                          const std::string &skill_id = {} ) const;
        bool roll_trial( const std::string &kind, int difficulty,
                         const std::string &skill_id = {} ) const;
        std::string expand_text( const std::string &text,
                                 const std::string &item_id = {} ) const;
        sol::object speaker() const;
        sol::object interlocutor() const;
        sol::object get( const std::string &key ) const;
        void set( const std::string &key, const sol::object &value ) const;
        void remove( const std::string &key ) const;

    private:
        struct state;

        state &require_state() const;
        state &require_write_state() const;

        std::shared_ptr<state> state_;
};

bool valid_topic_id( const std::string &value );
void require_text( const std::string &value, std::string_view api_name,
                   std::string_view field );

enum class response_callback_origin : int {
    platform
};

using response_callback = std::function<talk_topic( ::dialogue &,
                          const talk_topic &, bool )>;

std::uint64_t register_response_callback( response_callback_origin origin,
        response_callback callback, dialogue_session_ptr session = {},
        std::string topic = {} );
void clear_response_callbacks();
void clear_response_callbacks( response_callback_origin origin );
talk_topic apply_response_callback( ::dialogue &d, std::uint64_t response_id,
                                    const talk_topic &fallback, bool trial_success );

struct response_descriptor_options {
    std::string_view api_name;
    std::string_view descriptor_name;
    std::string_view unknown_field_verb;
    bool reject_non_string_keys = true;
    std::function<void( const std::string &, std::string_view )> require_text;
    std::function<bool( const std::string & )> valid_topic;
    std::function<std::uint64_t( sol::protected_function )> register_on_select;
    std::set<std::string> additional_fields;
};

talk_response response_from_table( const sol::table &descriptor,
                                   const response_descriptor_options &options );

} // namespace cata::lua_platform::dialogue

#endif // CATA_SRC_LUA_PLATFORM_DIALOGUE_H
