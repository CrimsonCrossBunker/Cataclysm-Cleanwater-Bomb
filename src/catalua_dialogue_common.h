#pragma once
#ifndef CATA_SRC_CATALUA_DIALOGUE_COMMON_H
#define CATA_SRC_CATALUA_DIALOGUE_COMMON_H

#include <cstdint>
#include <functional>
#include <memory>
#include <set>
#include <string>
#include <string_view>

#include "catalua_sol.h"
#include "dialogue.h"

namespace cata::lua_dialogue
{

class context
{
    public:
        using actor_converter =
            std::function<sol::object( const const_talker & )>;

        context( lua_State *lua_state, dialogue &d, std::string topic_id,
                 bool allow_write, std::string invalid_context_message,
                 actor_converter convert_actor );

        bool valid() const noexcept;
        void invalidate() noexcept;
        std::string topic() const;
        std::string topic_item() const;
        bool has_alpha() const;
        bool has_beta() const;
        bool by_radio() const;
        bool has_reason() const;
        std::string reason() const;
        int trial_chance( const std::string &kind, int difficulty,
                          const std::string &skill_id = {} ) const;
        bool roll_trial( const std::string &kind, int difficulty,
                         const std::string &skill_id = {} ) const;
        std::string expand_text( const std::string &text,
                                 const std::string &item_id = {} ) const;
        sol::object alpha() const;
        sol::object beta() const;
        sol::object get( const std::string &key ) const;
        void set( const std::string &key, const sol::object &value ) const;
        void remove( const std::string &key ) const;
        bool quote_trade_item( const std::string &item_name, int count,
                               const std::string &prefix ) const;
        bool buy_quoted_item( const std::string &prefix ) const;

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
    game_v5,
    platform
};

using response_callback = std::function<talk_topic( dialogue &,
                          const talk_topic &, bool )>;

std::uint64_t register_response_callback( response_callback_origin origin,
        response_callback callback );
void clear_response_callbacks();
void clear_response_callbacks( response_callback_origin origin );
talk_topic apply_response_callback( dialogue &d, std::uint64_t response_id,
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

} // namespace cata::lua_dialogue

#endif // CATA_SRC_CATALUA_DIALOGUE_COMMON_H
