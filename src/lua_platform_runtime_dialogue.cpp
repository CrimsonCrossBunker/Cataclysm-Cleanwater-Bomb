#include "lua_platform_runtime_internal.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <cstdint>
#include <limits>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "item_category.h"
#include "itype.h"
#include "lua_platform_dialogue.h"
#include "npc_opinion.h"
#include "output.h"
#include "string_input_popup.h"
#include "talker.h"
#include "type_id.h"
#include "uilist.h"

namespace cata::lua_platform
{

talk_topic invoke_platform_dialogue_response_callback(
    std::weak_ptr<runtime> weak_owner, std::string topic_id,
    sol::protected_function callback, ::dialogue &d, const talk_topic &fallback,
    bool trial_success );

namespace
{

constexpr std::size_t maximum_platform_dialogue_extensions = 8192;
constexpr std::size_t maximum_platform_dialogue_responses_per_topic = 1024;
constexpr std::size_t maximum_platform_dialogue_repeat_responses_per_topic = 1024;

void require_presentation_text( const std::string &value,
                                const std::string_view field,
                                const std::size_t maximum = maximum_presentation_text_bytes )
{
    if( value.empty() || value.size() > maximum ||
        value.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument( "presentation " + std::string( field ) +
                                     " is empty or exceeds its native limit" );
    }
}

struct presentation_choice {
    std::string id;
    std::string label;
    std::string description;
    bool enabled = true;
};

std::vector<presentation_choice> presentation_choices_from_lua(
    const sol::table &entries )
{
    const std::size_t count = detail::checked_dense_array(
                                  entries, "presentation choices", 1,
                                  maximum_presentation_choices );

    std::vector<presentation_choice> result;
    result.reserve( count );
    std::set<std::string> ids;
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw = entries.raw_get<sol::object>( index );
        if( raw.get_type() != sol::type::table ) {
            throw std::invalid_argument( "presentation choices must be tables" );
        }
        const sol::table entry = raw.as<sol::table>();
        presentation_choice choice;
        choice.id = entry.get_or( "id", std::string() );
        choice.label = entry.get_or( "label", std::string() );
        choice.description = entry.get_or( "description", std::string() );
        choice.enabled = entry.get_or( "enabled", true );
        require_presentation_text( choice.id, "choice id", 96 );
        require_presentation_text( choice.label, "choice label", 512 );
        if( choice.description.size() > 4096 ||
            choice.description.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "presentation choice description exceeds its native limit" );
        }
        if( !ids.insert( choice.id ).second ) {
            throw std::invalid_argument(
                "presentation choice ids must be unique" );
        }
        result.push_back( std::move( choice ) );
    }
    return result;
}

bool fits_native_int( const std::int64_t value )
{
    return value >= std::numeric_limits<int>::min() &&
           value <= std::numeric_limits<int>::max();
}

using detail::callback_scope;
using detail::platform_callback_payload;
using detail::platform_callback_talker_to_lua;
using detail::platform_talker_to_lua;

bool valid_platform_dialogue_id( const std::string &value )
{
    return cata::lua_platform::dialogue::valid_topic_id( value );
}

void require_platform_dialogue_text( const std::string &value,
                                     const std::string_view field )
{
    cata::lua_platform::dialogue::require_text( value, "ccb.dialogue", field );
}

using platform_dialogue_context = cata::lua_platform::dialogue::context;

std::shared_ptr<platform_dialogue_context> make_platform_dialogue_context(
    runtime &owner, ::dialogue &d, const std::string &topic_id,
    const bool allow_write = true )
{
    if( owner.lua == nullptr ) {
        throw std::runtime_error( "Platform dialogue runtime has no Lua state" );
    }
    const cata::lua_platform::game_handle_runtime runtime_identity =
        owner.handle_runtime();
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::session_for(
            d, topic_id, runtime_identity, detail::runtime_world_generation_storage() );
    return std::make_shared<platform_dialogue_context>(
               owner.lua->lua_state(), d, topic_id, allow_write,
               "Platform dialogue context is no longer valid",
    [&owner]( const cata::lua_platform::native_callback_talker & actor ) {
        return platform_callback_talker_to_lua( owner, actor );
    }, session, runtime_identity, detail::runtime_world_generation_storage() );
}

void validate_platform_dialogue_descriptor_keys( const sol::table &descriptor,
        const std::set<std::string> &allowed, const std::string_view operation )
{
    for( const auto &entry : descriptor ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument( "ccb.dialogue " + std::string( operation ) +
                                         " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( allowed.count( key ) == 0 ) {
            throw std::invalid_argument( "ccb.dialogue " + std::string( operation ) +
                                         " received unknown option '" + key + "'" );
        }
    }
}

std::uint64_t next_platform_dialogue_registration_id( runtime &owner )
{
    if( owner.next_dialogue_registration_id == 0 ) {
        throw std::runtime_error( "ccb.dialogue registration id space is exhausted" );
    }
    return owner.next_dialogue_registration_id++;
}

std::uint64_t register_platform_dialogue_topic( runtime &owner,
        const sol::table &descriptor )
{
    if( owner.world_is_ready ) {
        throw std::runtime_error(
            "ccb.dialogue register_topic is only available during Platform bootstrap" );
    }
    validate_platform_dialogue_descriptor_keys( descriptor, {
        "id", "dynamic_line", "responses", "speaker_effects", "on_enter",
        "repeat_responses", "replace_built_in_responses",
        "insert_before_standard_exits"
    },
    "register_topic" );
    const std::string id = descriptor.get_or( "id", std::string() );
    if( !valid_platform_dialogue_id( id ) ) {
        throw std::invalid_argument(
            "ccb.dialogue register_topic id must contain 1 to 256 non-NUL bytes" );
    }
    if( owner.dialogue_topics.count( id ) != 0 ) {
        throw std::invalid_argument(
            "ccb.dialogue register_topic conflicts with ccb.runtime.dialogue_topic '" +
            id + "'" );
    }
    const sol::object dynamic_line = descriptor.raw_get<sol::object>( "dynamic_line" );
    if( !dynamic_line.valid() || dynamic_line.get_type() == sol::type::nil ) {
        throw std::invalid_argument( "ccb.dialogue register_topic requires dynamic_line" );
    }
    if( dynamic_line.get_type() == sol::type::string ) {
        require_platform_dialogue_text( dynamic_line.as<std::string>(), "dynamic_line" );
    } else if( dynamic_line.get_type() != sol::type::function ) {
        throw std::invalid_argument(
            "ccb.dialogue register_topic dynamic_line must be a string or function" );
    }
    const sol::object responses = descriptor.raw_get<sol::object>( "responses" );
    if( !responses.valid() ||
        ( responses.get_type() != sol::type::table &&
          responses.get_type() != sol::type::function ) ) {
        throw std::invalid_argument(
            "ccb.dialogue register_topic requires table or function responses" );
    }
    sol::object speaker_effects = descriptor.raw_get<sol::object>( "speaker_effects" );
    if( ( !speaker_effects.valid() || speaker_effects.get_type() == sol::type::nil ) &&
        descriptor.raw_get<sol::object>( "on_enter" ).valid() ) {
        speaker_effects = descriptor.raw_get<sol::object>( "on_enter" );
    }
    if( speaker_effects.valid() && speaker_effects.get_type() != sol::type::nil &&
        speaker_effects.get_type() != sol::type::function &&
        speaker_effects.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "ccb.dialogue register_topic speaker_effects must be a function or array table" );
    }
    const sol::object repeat_responses =
        descriptor.raw_get<sol::object>( "repeat_responses" );
    if( repeat_responses.valid() && repeat_responses.get_type() != sol::type::nil &&
        repeat_responses.get_type() != sol::type::function &&
        repeat_responses.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "ccb.dialogue register_topic repeat_responses must be a function or array table" );
    }

    runtime::declarative_dialogue_topic replacement;
    replacement.dynamic_line = dynamic_line;
    replacement.responses = responses;
    replacement.speaker_effects = speaker_effects;
    replacement.repeat_responses = repeat_responses;
    replacement.replace_built_in_responses = descriptor.get_or(
                "replace_built_in_responses", true );
    replacement.insert_before_standard_exits = descriptor.get_or(
                "insert_before_standard_exits", false );
    const auto existing = owner.declarative_dialogue_topics.find( id );
    if( existing != owner.declarative_dialogue_topics.end() ) {
        replacement.registration_id = existing->second.registration_id;
        existing->second = std::move( replacement );
        return existing->second.registration_id;
    }
    if( owner.declarative_dialogue_topics.size() >= maximum_platform_dialogue_topics ) {
        throw std::runtime_error( "ccb.dialogue topic registration limit reached" );
    }
    replacement.registration_id = next_platform_dialogue_registration_id( owner );
    const std::uint64_t registration_id = replacement.registration_id;
    owner.declarative_dialogue_topics.emplace( id, std::move( replacement ) );
    return registration_id;
}

std::uint64_t extend_platform_dialogue_topic( runtime &owner,
        const sol::table &descriptor )
{
    if( owner.world_is_ready ) {
        throw std::runtime_error(
            "ccb.dialogue extend_topic is only available during Platform bootstrap" );
    }
    validate_platform_dialogue_descriptor_keys( descriptor, {
        "id", "key", "insert_before_standard_exits", "responses",
        "speaker_effects", "on_enter", "repeat_responses"
    }, "extend_topic" );
    const std::string id = descriptor.get_or( "id", std::string() );
    if( !valid_platform_dialogue_id( id ) ) {
        throw std::invalid_argument(
            "ccb.dialogue extend_topic id must contain 1 to 256 non-NUL bytes" );
    }
    const sol::object responses = descriptor.raw_get<sol::object>( "responses" );
    if( responses.valid() && responses.get_type() != sol::type::nil &&
        responses.get_type() != sol::type::table &&
        responses.get_type() != sol::type::function ) {
        throw std::invalid_argument(
            "ccb.dialogue extend_topic responses must be a function or array table" );
    }
    sol::object speaker_effects = descriptor.raw_get<sol::object>( "speaker_effects" );
    if( ( !speaker_effects.valid() || speaker_effects.get_type() == sol::type::nil ) &&
        descriptor.raw_get<sol::object>( "on_enter" ).valid() ) {
        speaker_effects = descriptor.raw_get<sol::object>( "on_enter" );
    }
    if( speaker_effects.valid() && speaker_effects.get_type() != sol::type::nil &&
        speaker_effects.get_type() != sol::type::function &&
        speaker_effects.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "ccb.dialogue extend_topic speaker_effects must be a function or array table" );
    }
    const sol::object repeat_responses =
        descriptor.raw_get<sol::object>( "repeat_responses" );
    if( repeat_responses.valid() && repeat_responses.get_type() != sol::type::nil &&
        repeat_responses.get_type() != sol::type::function &&
        repeat_responses.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "ccb.dialogue extend_topic repeat_responses must be a function or array table" );
    }
    if( ( !responses.valid() || responses.get_type() == sol::type::nil ) &&
        ( !speaker_effects.valid() || speaker_effects.get_type() == sol::type::nil ) &&
        ( !repeat_responses.valid() || repeat_responses.get_type() == sol::type::nil ) ) {
        throw std::invalid_argument(
            "ccb.dialogue extend_topic requires responses, repeat_responses, or speaker_effects" );
    }

    runtime::declarative_dialogue_extension replacement;
    replacement.id = id;
    replacement.key = descriptor.get_or( "key", std::string() );
    if( replacement.key.size() > 256 ||
        replacement.key.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "ccb.dialogue extend_topic key must contain at most 256 non-NUL bytes" );
    }
    replacement.insert_before_standard_exits =
        descriptor.get_or( "insert_before_standard_exits", false );
    replacement.responses = responses;
    replacement.speaker_effects = speaker_effects;
    replacement.repeat_responses = repeat_responses;
    const auto existing = std::find_if(
                              owner.declarative_dialogue_extensions.begin(),
                              owner.declarative_dialogue_extensions.end(),
    [&replacement]( const runtime::declarative_dialogue_extension & entry ) {
        return entry.id == replacement.id && entry.key == replacement.key;
    } );
    if( existing != owner.declarative_dialogue_extensions.end() ) {
        replacement.registration_id = existing->registration_id;
        *existing = std::move( replacement );
        return existing->registration_id;
    }
    if( owner.declarative_dialogue_extensions.size() >=
        maximum_platform_dialogue_extensions ) {
        throw std::runtime_error( "ccb.dialogue extension registration limit reached" );
    }
    replacement.registration_id = next_platform_dialogue_registration_id( owner );
    const std::uint64_t registration_id = replacement.registration_id;
    owner.declarative_dialogue_extensions.emplace_back( std::move( replacement ) );
    return registration_id;
}

} // namespace

void detail::install_runtime_dialogue_presentation_api(
    const std::shared_ptr<runtime> &value, sol::state &lua, sol::table &ccb )
{
    const std::weak_ptr<runtime> weak = value;
    ccb.new_usertype<platform_dialogue_context>(
        "PlatformDialogueContext", sol::no_constructor,
        "valid", &platform_dialogue_context::valid,
        "generation", &platform_dialogue_context::generation,
        "topic", &platform_dialogue_context::topic,
        "topic_item", &platform_dialogue_context::topic_item,
        "has_speaker", &platform_dialogue_context::has_speaker,
        "has_interlocutor", &platform_dialogue_context::has_interlocutor,
        "by_radio", &platform_dialogue_context::by_radio,
        "has_reason", &platform_dialogue_context::has_reason,
        "reason", &platform_dialogue_context::reason,
        "trial_chance",
        []( const platform_dialogue_context & context,
            const std::string & kind, const int difficulty,
    const sol::optional<std::string> &skill ) {
        return context.trial_chance(
                   kind, difficulty,
                   skill.value_or( std::string() ) );
    },
    "roll_trial",
    []( const platform_dialogue_context & context,
        const std::string & kind, const int difficulty,
        const sol::optional<std::string> &skill ) {
        return context.roll_trial(
                   kind, difficulty,
                   skill.value_or( std::string() ) );
    },
    "expand_text",
    []( const platform_dialogue_context & context,
        const std::string & text,
        const sol::optional<std::string> &item_id ) {
        return context.expand_text(
                   text, item_id.value_or( std::string() ) );
    },
    "speaker", &platform_dialogue_context::speaker,
    "interlocutor", &platform_dialogue_context::interlocutor,
    "get", &platform_dialogue_context::get,
    "set", &platform_dialogue_context::set,
    "remove", &platform_dialogue_context::remove );
    ccb["PlatformDialogueContext"] = sol::lua_nil;

    sol::table dialogue_api = lua.create_table();
    dialogue_api.set_function( "register_topic", [weak]( const sol::table & descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return register_platform_dialogue_topic( *owner, descriptor );
    } );
    dialogue_api.set_function( "extend_topic", [weak]( const sol::table & descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return extend_platform_dialogue_topic( *owner, descriptor );
    } );
    dialogue_api.set_function( "limits", []( sol::this_state state ) {
        sol::state_view lua_state( state );
        return lua_state.create_table_with(
                   "topics", maximum_platform_dialogue_topics,
                   "extensions", maximum_platform_dialogue_extensions,
                   "responses_per_topic",
                   maximum_platform_dialogue_responses_per_topic,
                   "repeat_responses_per_topic",
                   maximum_platform_dialogue_repeat_responses_per_topic,
                   "id_bytes", 256,
                   "text_bytes", 4096 );
    } );
    ccb["dialogue"] = std::move( dialogue_api );

    const auto require_presentation = [weak]() {
        require_live_runtime( weak, "Platform presentation" );
        if( !runtime_callback_is_active( weak ) ) {
            throw std::runtime_error(
                "Platform presentation is only available inside a runtime callback" );
        }
    };
    sol::table presentation = lua.create_table();
    presentation.set_function( "notice", [require_presentation]( const std::string & message ) {
        require_presentation();
        require_presentation_text( message, "notice" );
        ::popup( message );
    } );
    presentation.set_function( "notice_any_key", [require_presentation](
    const std::string & message ) {
        require_presentation();
        require_presentation_text( message, "any-key notice" );
        return ::popup( message, PF_GET_KEY );
    } );
    presentation.set_function( "notice_top", [require_presentation](
    const std::string & message ) {
        require_presentation();
        require_presentation_text( message, "top notice" );
        return ::popup( message, PF_ON_TOP );
    } );
    presentation.set_function( "notice_large", [require_presentation](
    const std::string & message ) {
        require_presentation();
        require_presentation_text( message, "large notice" );
        return ::popup( message, PF_FULLSCREEN );
    } );
    presentation.set_function( "confirm", [require_presentation]( const std::string & question ) {
        require_presentation();
        require_presentation_text( question, "confirmation question" );
        return query_yn( question );
    } );
    presentation.set_function( "choose", [require_presentation](
    sol::this_state state, const std::string & prompt, const sol::table & entries ) {
        require_presentation();
        require_presentation_text( prompt, "choice prompt" );
        const std::vector<presentation_choice> choices =
            presentation_choices_from_lua( entries );
        uilist menu;
        menu.text = prompt;
        menu.desc_enabled = std::any_of( choices.begin(), choices.end(),
        []( const presentation_choice & choice ) {
            return !choice.description.empty();
        } );
        for( std::size_t index = 0; index < choices.size(); ++index ) {
            menu.addentry_desc( static_cast<int>( index ), choices[index].enabled,
                                MENU_AUTOASSIGN, choices[index].label,
                                choices[index].description );
        }
        menu.query();
        sol::state_view lua_state( state );
        if( menu.ret < 0 || static_cast<std::size_t>( menu.ret ) >= choices.size() ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object( lua_state, choices[menu.ret].id );
    } );
    presentation.set_function( "input_text", [require_presentation](
                                   sol::this_state state, const std::string & prompt,
    const sol::optional<sol::table> &options ) {
        require_presentation();
        require_presentation_text( prompt, "input prompt", 4096 );
        std::string initial;
        std::string description;
        std::int64_t width = 0;
        std::int64_t maximum = 1024;
        bool only_digits = false;
        if( options ) {
            initial = options->get_or( "initial", std::string() );
            description = options->get_or( "description", std::string() );
            width = options->get_or<std::int64_t>( "width", 0 );
            maximum = options->get_or<std::int64_t>( "max_length", 1024 );
            only_digits = options->get_or( "only_digits", false );
        }
        if( initial.size() > 32768 || initial.find( '\0' ) != std::string::npos ||
            description.size() > 32768 || description.find( '\0' ) != std::string::npos ||
            width < 0 || width > 240 || maximum <= 0 || maximum > 32768 ) {
            throw std::invalid_argument( "presentation input options exceed native limits" );
        }
        string_input_popup popup;
        popup.title( prompt ).text( initial ).description( description )
        .width( static_cast<int>( width ) ).max_length( static_cast<int>( maximum ) )
        .only_digits( only_digits );
        popup.query();
        sol::state_view lua_state( state );
        if( popup.canceled() ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object( lua_state, popup.text() );
    } );
    ccb["presentation"] = std::move( presentation );

}

namespace
{

struct declarative_platform_dialogue_topic_registration {
    std::shared_ptr<runtime> owner;
    const runtime::declarative_dialogue_topic *definition = nullptr;
};

std::optional<declarative_platform_dialogue_topic_registration>
find_declarative_platform_dialogue_topic( const std::string_view topic_id )
{
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
            continue;
        }
        const auto found = owner->declarative_dialogue_topics.find(
                               std::string( topic_id ) );
        if( found != owner->declarative_dialogue_topics.end() ) {
            return declarative_platform_dialogue_topic_registration{ owner, &found->second };
        }
    }
    return std::nullopt;
}

void report_declarative_platform_dialogue_error(
    const declarative_platform_dialogue_topic_registration &registration,
    const std::string_view topic_id, const std::string &error )
{
    DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << registration.owner->mod_id
                                << "' declarative dialogue topic '" << topic_id
                                << "': " << error;
}

std::string evaluate_declarative_platform_dialogue_line(
    const declarative_platform_dialogue_topic_registration &registration,
    ::dialogue &d, const talk_topic &topic )
{
    const sol::object &source = registration.definition->dynamic_line;
    if( source.get_type() == sol::type::string ) {
        const std::string line = source.as<std::string>();
        require_platform_dialogue_text( line, "dynamic_line" );
        return line;
    }
    const std::shared_ptr<platform_dialogue_context> context =
        make_platform_dialogue_context( *registration.owner, d, topic.id );
    try {
        if( registration.owner->callback_depth >= 16 ) {
            throw std::runtime_error( "dialogue callback recursion limit reached" );
        }
        const sol::protected_function callback = source.as<sol::protected_function>();
        callback_scope scope( *registration.owner );
        const sol::protected_function_result result = callback( context );
        context->invalidate();
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.get_type() != sol::type::string ) {
            throw std::invalid_argument( "dynamic_line callback must return a string" );
        }
        const std::string line = result.get<std::string>();
        require_platform_dialogue_text( line, "dynamic_line" );
        return line;
    } catch( ... ) {
        context->invalidate();
        throw;
    }
}

sol::object evaluate_declarative_platform_dialogue_responses(
    const std::shared_ptr<runtime> &owner, const sol::object &source,
    ::dialogue &d, const std::string &topic_id )
{
    if( source.get_type() == sol::type::table ) {
        return source;
    }
    const std::shared_ptr<platform_dialogue_context> context =
        make_platform_dialogue_context( *owner, d, topic_id );
    try {
        if( owner->callback_depth >= 16 ) {
            throw std::runtime_error( "dialogue callback recursion limit reached" );
        }
        const sol::protected_function callback = source.as<sol::protected_function>();
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( context );
        context->invalidate();
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "dialogue responses callback must return an array table" );
        }
        return result.get<sol::object>();
    } catch( ... ) {
        context->invalidate();
        throw;
    }
}

bool evaluate_platform_dialogue_boolean(
    const std::shared_ptr<runtime> &owner, ::dialogue &d,
    const std::string &topic_id, const sol::object &source,
    const std::string_view field )
{
    if( source.get_type() == sol::type::boolean ) {
        return source.as<bool>();
    }
    if( source.get_type() != sol::type::function ) {
        throw std::invalid_argument( "dialogue " + std::string( field ) +
                                     " must be a boolean or function" );
    }
    const std::shared_ptr<platform_dialogue_context> context =
        make_platform_dialogue_context( *owner, d, topic_id, false );
    try {
        if( owner->callback_depth >= 16 ) {
            throw std::runtime_error( "dialogue callback recursion limit reached" );
        }
        const sol::protected_function callback = source.as<sol::protected_function>();
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( context );
        context->invalidate();
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            throw std::invalid_argument( "dialogue " + std::string( field ) +
                                         " callback must return one boolean" );
        }
        return result.get<bool>();
    } catch( ... ) {
        context->invalidate();
        throw;
    }
}

dialogue_consequence platform_dialogue_consequence( const std::string &value )
{
    if( value.empty() || value == "none" ) {
        return dialogue_consequence::none;
    }
    if( value == "hostile" ) {
        return dialogue_consequence::hostile;
    }
    if( value == "helpless" ) {
        return dialogue_consequence::helpless;
    }
    if( value == "action" ) {
        return dialogue_consequence::action;
    }
    throw std::invalid_argument(
        "dialogue consequence must be none, hostile, helpless, or action" );
}

npc_opinion platform_dialogue_opinion( const sol::object &source,
                                       const std::string_view field )
{
    npc_opinion result;
    if( !source.valid() || source.get_type() == sol::type::nil ) {
        return result;
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( "dialogue " + std::string( field ) +
                                     " must be a table" );
    }
    const sol::table values = source.as<sol::table>();
    for( const auto &entry : values ) {
        if( !entry.first.is<std::string>() || !entry.second.is<lua_Integer>() ) {
            throw std::invalid_argument( "dialogue opinion fields require integer values" );
        }
        const std::string key = entry.first.as<std::string>();
        const std::int64_t native_value = entry.second.as<std::int64_t>();
        if( !fits_native_int( native_value ) ) {
            throw std::invalid_argument(
                "dialogue opinion value is outside the native integer range" );
        }
        const int value = static_cast<int>( native_value );
        if( key == "trust" ) {
            result.trust = value;
        } else if( key == "fear" ) {
            result.fear = value;
        } else if( key == "value" ) {
            result.value = value;
        } else if( key == "anger" ) {
            result.anger = value;
        } else if( key == "owed" ) {
            result.owed = value;
        } else if( key == "sold" ) {
            result.sold = value;
        } else {
            throw std::invalid_argument( "dialogue opinion has unknown field '" + key + "'" );
        }
    }
    return result;
}

struct declarative_platform_dialogue_response {
    talk_response response;
    bool condition_exists = false;
    bool condition_result = true;
    bool switch_response = false;
    bool default_response = false;
};

declarative_platform_dialogue_response declarative_platform_dialogue_response_from_table(
    const std::shared_ptr<runtime> &owner, const std::string &topic_id,
    ::dialogue &d, const sol::table &descriptor )
{
    std::optional<sol::protected_function> on_select;
    declarative_platform_dialogue_response generated;
    generated.response = cata::lua_platform::dialogue::response_from_table( descriptor, {
        "dialogue", "response descriptor", "has", true,
        []( const std::string & text, const std::string_view field )
        {
            require_platform_dialogue_text( text, field );
        },
        []( const std::string & id )
        {
            return valid_platform_dialogue_id( id );
        },
        [&on_select]( sol::protected_function callback )
        {
            on_select = std::move( callback );
            return std::uint64_t{ 0 };
        },
        {
            "condition", "show_always", "show_condition", "show_reason",
            "failure_explanation", "failure_topic", "switch", "default",
            "false_text", "text_condition", "trial", "success_topic",
            "on_success", "on_failure", "success_consequence",
            "failure_consequence", "success_opinion", "failure_opinion",
            "success_mission_opinion", "failure_mission_opinion",
            "topic_item", "topic_reason", "success_item", "failure_item",
            "success_reason", "failure_reason", "skill", "style", "spell",
            "proficiency"
        }
    } );
    generated.response.lua_response_id.reset();

    const sol::object condition = descriptor.raw_get<sol::object>( "condition" );
    if( condition.valid() && condition.get_type() != sol::type::nil ) {
        generated.condition_exists = true;
        generated.condition_result = evaluate_platform_dialogue_boolean(
                                         owner, d, topic_id, condition, "response condition" );
    }
    bool show_anyway = descriptor.get_or( "show_always", false );
    const sol::object show_condition = descriptor.raw_get<sol::object>( "show_condition" );
    if( show_condition.valid() && show_condition.get_type() != sol::type::nil ) {
        show_anyway = show_anyway || evaluate_platform_dialogue_boolean(
                          owner, d, topic_id, show_condition, "response show_condition" );
    }
    generated.response.show_reason = descriptor.get_or(
                                         "show_reason", descriptor.get_or(
                                                 "failure_explanation", std::string() ) );
    generated.response.ignore_conditionals = generated.condition_exists &&
            !generated.condition_result && show_anyway;
    if( generated.condition_exists && !generated.condition_result && !show_anyway ) {
        const std::string failure_topic = descriptor.get_or(
                                              "failure_topic", std::string() );
        const std::string explanation = descriptor.get_or(
                                            "failure_explanation", std::string() );
        if( failure_topic.empty() && explanation.empty() ) {
            generated.response.truetext = translation();
            return generated;
        }
        if( !failure_topic.empty() && !valid_platform_dialogue_id( failure_topic ) ) {
            throw std::invalid_argument( "dialogue failure_topic has an invalid id" );
        }
        if( !explanation.empty() ) {
            require_platform_dialogue_text( explanation, "failure_explanation" );
            generated.response.truetext = no_translation(
                                              "*" + explanation + ": " + generated.response.truetext.translated() );
        }
        generated.response.success.next_topic = talk_topic(
                failure_topic.empty() ? "TALK_NONE" : failure_topic );
        generated.condition_exists = false;
        generated.condition_result = true;
    }

    const sol::object text_condition = descriptor.raw_get<sol::object>( "text_condition" );
    const sol::object false_text = descriptor.raw_get<sol::object>( "false_text" );
    if( text_condition.valid() && text_condition.get_type() != sol::type::nil ) {
        if( !false_text.valid() || false_text.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "dialogue text_condition requires string field false_text" );
        }
        if( !evaluate_platform_dialogue_boolean(
                owner, d, topic_id, text_condition, "response text_condition" ) ) {
            const std::string text = false_text.as<std::string>();
            require_platform_dialogue_text( text, "response false_text" );
            generated.response.truetext = no_translation( text );
        }
    } else if( false_text.valid() && false_text.get_type() != sol::type::nil ) {
        throw std::invalid_argument(
            "dialogue false_text requires text_condition" );
    }

    const sol::object trial_object = descriptor.raw_get<sol::object>( "trial" );
    if( trial_object.valid() && trial_object.get_type() != sol::type::nil ) {
        if( trial_object.get_type() != sol::type::table ) {
            throw std::invalid_argument( "dialogue trial must be a table" );
        }
        const sol::table trial = trial_object.as<sol::table>();
        validate_platform_dialogue_descriptor_keys( trial, {
            "kind", "type", "difficulty", "skill", "skill_required",
            "condition", "modifiers", "mod"
        }, "trial" );
        const std::string kind = trial.get_or( "kind", trial.get_or(
                "type", std::string( "none" ) ) );
        if( kind == "none" ) {
            generated.response.trial.type = TALK_TRIAL_NONE;
        } else if( kind == "lie" ) {
            generated.response.trial.type = TALK_TRIAL_LIE;
        } else if( kind == "persuade" ) {
            generated.response.trial.type = TALK_TRIAL_PERSUADE;
        } else if( kind == "intimidate" ) {
            generated.response.trial.type = TALK_TRIAL_INTIMIDATE;
        } else if( kind == "skill_check" ) {
            generated.response.trial.type = TALK_TRIAL_SKILL_CHECK;
        } else if( kind == "condition" ) {
            generated.response.trial.type = TALK_TRIAL_CONDITION;
        } else {
            throw std::invalid_argument( "dialogue trial has unknown kind '" + kind + "'" );
        }
        const std::int64_t difficulty = trial.get_or<std::int64_t>( "difficulty", 0 );
        if( !fits_native_int( difficulty ) ) {
            throw std::invalid_argument( "dialogue trial difficulty is outside native range" );
        }
        generated.response.trial.difficulty = static_cast<int>( difficulty );
        generated.response.trial.skill_required = trial.get_or(
                    "skill", trial.get_or( "skill_required", std::string() ) );
        if( generated.response.trial.type == TALK_TRIAL_SKILL_CHECK &&
            ( generated.response.trial.skill_required.empty() ||
              !skill_id( generated.response.trial.skill_required ).is_valid() ) ) {
            throw std::invalid_argument( "dialogue skill trial requires a valid skill" );
        }
        const sol::object trial_condition = trial.raw_get<sol::object>( "condition" );
        if( generated.response.trial.type == TALK_TRIAL_CONDITION ) {
            if( !trial_condition.valid() || trial_condition.get_type() == sol::type::nil ) {
                throw std::invalid_argument( "dialogue condition trial requires condition" );
            }
            const bool result = evaluate_platform_dialogue_boolean(
                                    owner, d, topic_id, trial_condition, "trial condition" );
            generated.response.trial.condition = [result]( const const_dialogue & ) {
                return result;
            };
        } else if( trial_condition.valid() && trial_condition.get_type() != sol::type::nil ) {
            throw std::invalid_argument(
                "dialogue trial condition is only valid for condition trials" );
        }
        sol::object modifiers = trial.raw_get<sol::object>( "modifiers" );
        if( ( !modifiers.valid() || modifiers.get_type() == sol::type::nil ) &&
            trial.raw_get<sol::object>( "mod" ).valid() ) {
            modifiers = trial.raw_get<sol::object>( "mod" );
        }
        if( modifiers.valid() && modifiers.get_type() != sol::type::nil ) {
            if( modifiers.get_type() != sol::type::table ) {
                throw std::invalid_argument( "dialogue trial modifiers must be an array table" );
            }
            const sol::table entries = modifiers.as<sol::table>();
            const std::size_t count = detail::checked_dense_array(
                                          entries, "dialogue trial modifiers", 0, 64 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::object raw_entry = entries.raw_get<sol::object>( index );
                if( raw_entry.get_type() != sol::type::table ) {
                    throw std::invalid_argument(
                        "dialogue trial modifiers must contain tables" );
                }
                const sol::table entry = raw_entry.as<sol::table>();
                std::string modifier;
                std::int64_t factor = 0;
                const sol::object named_modifier = entry.raw_get<sol::object>( "kind" );
                if( named_modifier.valid() && named_modifier.get_type() != sol::type::nil ) {
                    validate_platform_dialogue_descriptor_keys(
                        entry, { "kind", "factor" }, "trial modifier" );
                    if( named_modifier.get_type() != sol::type::string ) {
                        throw std::invalid_argument(
                            "dialogue trial modifier kind must be a string" );
                    }
                    modifier = named_modifier.as<std::string>();
                    const sol::object named_factor = entry.raw_get<sol::object>( "factor" );
                    if( !named_factor.is<lua_Integer>() ) {
                        throw std::invalid_argument(
                            "dialogue trial modifier factor must be an integer" );
                    }
                    factor = named_factor.as<std::int64_t>();
                } else {
                    detail::checked_dense_array( entry, "dialogue trial modifier", 2, 2 );
                    const sol::object raw_modifier = entry.raw_get<sol::object>( 1 );
                    const sol::object raw_factor = entry.raw_get<sol::object>( 2 );
                    if( raw_modifier.get_type() != sol::type::string ||
                        !raw_factor.is<lua_Integer>() ) {
                        throw std::invalid_argument(
                            "dialogue trial modifier requires a string and integer" );
                    }
                    modifier = raw_modifier.as<std::string>();
                    factor = raw_factor.as<std::int64_t>();
                }
                if( modifier.empty() || modifier.size() > 64 ||
                    modifier.find( '\0' ) != std::string::npos ||
                    !fits_native_int( factor ) ) {
                    throw std::invalid_argument(
                        "dialogue trial modifier is outside native limits" );
                }
                generated.response.trial.modifiers.emplace_back(
                    modifier, static_cast<int>( factor ) );
            }
        }
    }

    const std::string success_topic = descriptor.get_or(
                                          "success_topic", generated.response.success.next_topic.id );
    const std::string failure_topic = descriptor.get_or(
                                          "failure_topic", std::string( "TALK_NONE" ) );
    if( !valid_platform_dialogue_id( success_topic ) ||
        !valid_platform_dialogue_id( failure_topic ) ) {
        throw std::invalid_argument( "dialogue response result topic has an invalid id" );
    }
    const std::string topic_item = descriptor.get_or( "topic_item", std::string() );
    const std::string success_item = descriptor.get_or( "success_item", topic_item );
    const std::string failure_item = descriptor.get_or( "failure_item", topic_item );
    const std::string topic_reason = descriptor.get_or( "topic_reason", std::string() );
    const std::string success_reason = descriptor.get_or( "success_reason", topic_reason );
    const std::string failure_reason = descriptor.get_or( "failure_reason", topic_reason );
    const auto validate_topic_payload = []( const std::string & item_id,
    const std::string & reason, const char *phase ) {
        if( ( !item_id.empty() && !itype_id( item_id ).is_valid() ) ||
            reason.size() > 4096 || reason.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( std::string( "dialogue " ) + phase +
                                         " topic payload is invalid" );
        }
    };
    validate_topic_payload( success_item, success_reason, "success" );
    validate_topic_payload( failure_item, failure_reason, "failure" );
    generated.response.success.next_topic = talk_topic(
            success_topic, success_item.empty() ? itype_id::NULL_ID() :
            itype_id( success_item ), success_reason );
    generated.response.failure.next_topic = talk_topic(
            failure_topic, failure_item.empty() ? itype_id::NULL_ID() :
            itype_id( failure_item ), failure_reason );
    generated.response.success.opinion = platform_dialogue_opinion(
            descriptor.raw_get<sol::object>( "success_opinion" ), "success_opinion" );
    generated.response.failure.opinion = platform_dialogue_opinion(
            descriptor.raw_get<sol::object>( "failure_opinion" ), "failure_opinion" );
    generated.response.success.mission_opinion = platform_dialogue_opinion(
                descriptor.raw_get<sol::object>( "success_mission_opinion" ),
                "success_mission_opinion" );
    generated.response.failure.mission_opinion = platform_dialogue_opinion(
                descriptor.raw_get<sol::object>( "failure_mission_opinion" ),
                "failure_mission_opinion" );

    const dialogue_consequence success_consequence = platform_dialogue_consequence(
                descriptor.get_or( "success_consequence", std::string() ) );
    const dialogue_consequence failure_consequence = platform_dialogue_consequence(
                descriptor.get_or( "failure_consequence", std::string() ) );
    if( success_consequence != dialogue_consequence::none ) {
        generated.response.success.set_effect_consequence(
        talk_effect_fun_t( []( ::dialogue & ) {} ), success_consequence );
    }
    if( failure_consequence != dialogue_consequence::none ) {
        generated.response.failure.set_effect_consequence(
        talk_effect_fun_t( []( ::dialogue & ) {} ), failure_consequence );
    }

    const auto read_training_id = [&descriptor]( const char *field ) {
        return descriptor.get_or( field, std::string() );
    };
    const std::string skill = read_training_id( "skill" );
    const std::string style = read_training_id( "style" );
    const std::string spell = read_training_id( "spell" );
    const std::string proficiency = read_training_id( "proficiency" );
    if( !skill.empty() ) {
        generated.response.skill = skill_id( skill );
    }
    if( !style.empty() ) {
        generated.response.style = matype_id( style );
    }
    if( !spell.empty() ) {
        generated.response.dialogue_spell = spell_id( spell );
    }
    if( !proficiency.empty() ) {
        generated.response.proficiency = proficiency_id( proficiency );
    }

    const sol::object on_success = descriptor.raw_get<sol::object>( "on_success" );
    const sol::object on_failure = descriptor.raw_get<sol::object>( "on_failure" );
    const auto optional_callback = []( const sol::object & value,
    const char *field ) -> std::optional<sol::protected_function> {
        if( !value.valid() || value.get_type() == sol::type::nil )
        {
            return std::nullopt;
        }
        if( value.get_type() != sol::type::function )
        {
            throw std::invalid_argument( std::string( "dialogue " ) + field +
                                         " must be a function" );
        }
        return value.as<sol::protected_function>();
    };
    const std::optional<sol::protected_function> success_callback =
        optional_callback( on_success, "on_success" );
    const std::optional<sol::protected_function> failure_callback =
        optional_callback( on_failure, "on_failure" );
    if( on_select || success_callback || failure_callback ) {
        const std::weak_ptr<runtime> weak_owner( owner );
        const cata::lua_platform::game_handle_runtime runtime_identity =
            owner->handle_runtime();
        const cata::lua_platform::dialogue::dialogue_session_ptr session =
            cata::lua_platform::dialogue::session_for(
                d, topic_id, runtime_identity,
                detail::runtime_world_generation_storage() );
        generated.response.lua_response_id =
            cata::lua_platform::dialogue::register_response_callback(
                cata::lua_platform::dialogue::response_callback_origin::platform,
                [weak_owner, topic_id, session, on_select, success_callback, failure_callback](
                    ::dialogue & active_dialogue, const talk_topic & fallback,
        const bool trial_success ) mutable {
            const std::shared_ptr<runtime> active_owner = weak_owner.lock();
            if( !active_owner || !active_owner->world_is_ready || !session ||
                !session->active_for( topic_id, &active_dialogue ) ||
                session->validation_error( &active_dialogue,
                                           active_owner->handle_runtime(),
                                           detail::runtime_world_generation_storage() ) )
            {
                return fallback;
            }
            talk_topic result = fallback;
            const std::optional<sol::protected_function> &phase_callback =
            trial_success ? success_callback : failure_callback;
            if( phase_callback )
            {
                result = invoke_platform_dialogue_response_callback(
                    weak_owner, topic_id, *phase_callback, active_dialogue,
                    result, trial_success );
            }
            if( on_select )
            {
                result = invoke_platform_dialogue_response_callback(
                    weak_owner, topic_id, *on_select, active_dialogue,
                    result, trial_success );
            }
            return result;
        }, session, topic_id );
    }
    generated.switch_response = descriptor.get_or( "switch", false );
    generated.default_response = descriptor.get_or( "default", false );
    return generated;
}

void add_declarative_platform_dialogue_response(
    ::dialogue &d, const std::shared_ptr<runtime> &owner,
    const std::string &topic_id, const sol::table &descriptor,
    const bool insert_before_standard_exits, const bool insert_front,
    const std::optional<itype_id> &repeat_item, bool &switch_done )
{
    declarative_platform_dialogue_response generated =
        declarative_platform_dialogue_response_from_table(
            owner, topic_id, d, descriptor );
    if( repeat_item ) {
        generated.response.success.next_topic.item_type = *repeat_item;
        generated.response.failure.next_topic.item_type = *repeat_item;
    }
    if( generated.response.truetext.empty() ||
        ( generated.switch_response && switch_done &&
          !d.debug_ignore_conditionals ) ) {
        return;
    }
    d.add_gen_response( generated.response, insert_front,
                        generated.condition_exists,
                        generated.condition_result,
                        insert_before_standard_exits );
    if( generated.switch_response && !generated.default_response &&
        generated.condition_result ) {
        switch_done = true;
    }
}

void add_declarative_platform_dialogue_responses(
    ::dialogue &d, const std::shared_ptr<runtime> &owner,
    const std::string &topic_id, const sol::object &responses_object,
    const bool insert_before_standard_exits, bool &switch_done )
{
    if( responses_object.get_type() != sol::type::table ) {
        throw std::invalid_argument( "dialogue responses must be an array table" );
    }
    const sol::table responses = responses_object.as<sol::table>();
    const std::size_t count = detail::checked_dense_array(
                                  responses, "dialogue responses", 0,
                                  maximum_platform_dialogue_responses_per_topic );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw_response = responses.raw_get<sol::object>( index );
        if( !raw_response.valid() || raw_response.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "dialogue responses must contain descriptor tables" );
        }
        add_declarative_platform_dialogue_response(
            d, owner, topic_id, raw_response.as<sol::table>(),
            insert_before_standard_exits, false, std::nullopt, switch_done );
    }
}

void append_platform_dialogue_repeat_ids(
    const sol::table &descriptor, const char *singular_field,
    const char *plural_field, const std::string_view label,
    std::vector<std::string> &ids )
{
    const sol::object singular = descriptor.raw_get<sol::object>( singular_field );
    if( singular.valid() && singular.get_type() != sol::type::nil ) {
        if( singular.get_type() != sol::type::string ) {
            throw std::invalid_argument( "dialogue " + std::string( label ) +
                                         " must be a string" );
        }
        ids.push_back( singular.as<std::string>() );
    }
    const sol::object plural = descriptor.raw_get<sol::object>( plural_field );
    if( !plural.valid() || plural.get_type() == sol::type::nil ) {
        return;
    }
    if( plural.get_type() != sol::type::table ) {
        throw std::invalid_argument( "dialogue " + std::string( label ) +
                                     " list must be an array table" );
    }
    const sol::table values = plural.as<sol::table>();
    const std::size_t count = detail::checked_dense_array(
                                  values, label, 0, 1024 );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = values.raw_get<sol::object>( index );
        if( value.get_type() != sol::type::string ) {
            throw std::invalid_argument( "dialogue " + std::string( label ) +
                                         " list must contain strings" );
        }
        ids.push_back( value.as<std::string>() );
    }
}

void add_declarative_platform_dialogue_repeat_responses(
    ::dialogue &d, const std::shared_ptr<runtime> &owner,
    const std::string &topic_id, const sol::object &source,
    const bool insert_before_standard_exits, bool &switch_done )
{
    if( !source.valid() || source.get_type() == sol::type::nil ) {
        return;
    }
    const sol::object evaluated = evaluate_declarative_platform_dialogue_responses(
                                      owner, source, d, topic_id );
    if( evaluated.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "dialogue repeat_responses must be an array table" );
    }
    const sol::table repeat_responses = evaluated.as<sol::table>();
    const std::size_t count = detail::checked_dense_array(
                                  repeat_responses, "dialogue repeat_responses", 0,
                                  maximum_platform_dialogue_repeat_responses_per_topic );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw_repeat = repeat_responses.raw_get<sol::object>( index );
        if( raw_repeat.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "dialogue repeat_responses must contain descriptor tables" );
        }
        const sol::table repeat = raw_repeat.as<sol::table>();
        validate_platform_dialogue_descriptor_keys( repeat, {
            "actor", "include_containers", "item", "items", "category",
            "categories", "response"
        }, "repeat response" );
        const std::string actor_name = repeat.get_or( "actor", std::string( "speaker" ) );
        bool beta = false;
        if( actor_name == "speaker" ) {
            beta = false;
        } else if( actor_name == "interlocutor" ) {
            beta = true;
        } else {
            throw std::invalid_argument(
                "dialogue repeat response actor must be speaker or interlocutor" );
        }
        if( !d.has_actor( beta ) ) {
            continue;
        }
        const sol::object raw_response = repeat.raw_get<sol::object>( "response" );
        if( raw_response.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "dialogue repeat response requires a response descriptor table" );
        }

        std::vector<std::string> item_ids;
        std::vector<std::string> category_ids;
        append_platform_dialogue_repeat_ids(
            repeat, "item", "items", "repeat response items", item_ids );
        append_platform_dialogue_repeat_ids(
            repeat, "category", "categories", "repeat response categories", category_ids );
        if( item_ids.empty() && category_ids.empty() ) {
            throw std::invalid_argument(
                "dialogue repeat response requires items or categories" );
        }

        const_talker *actor = d.const_actor( beta );
        std::set<itype_id> matches;
        for( const std::string &item_id_string : item_ids ) {
            const itype_id item_id( item_id_string );
            if( !item_id.is_valid() ) {
                throw std::invalid_argument(
                    "dialogue repeat response has an invalid item id" );
            }
            if( actor->charges_of( item_id ) > 0 || actor->has_amount( item_id, 1 ) ) {
                matches.insert( item_id );
            }
        }
        const bool include_containers = repeat.get_or( "include_containers", false );
        for( const std::string &category_id_string : category_ids ) {
            const item_category_id category_id( category_id_string );
            if( !category_id.is_valid() ) {
                throw std::invalid_argument(
                    "dialogue repeat response has an invalid item category id" );
            }
            const std::vector<const item *> items = actor->const_items_with(
            [category_id, include_containers]( const item & candidate ) {
                if( include_containers ) {
                    return candidate.get_category_of_contents().get_id() == category_id;
                }
                return candidate.type && candidate.type->category_force == category_id;
            } );
            for( const item *candidate : items ) {
                if( candidate != nullptr ) {
                    matches.insert( candidate->typeId() );
                }
            }
        }
        for( const itype_id &item_id : matches ) {
            add_declarative_platform_dialogue_response(
                d, owner, topic_id, raw_response.as<sol::table>(),
                insert_before_standard_exits, true, item_id, switch_done );
        }
    }
}

struct platform_dialogue_handler {
    std::shared_ptr<runtime> owner;
    std::string handler_id;
};

std::optional<platform_dialogue_handler> find_platform_dialogue_handler(
    const std::string_view topic_id )
{
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
            continue;
        }
        const auto registration = owner->dialogue_topics.find(
                                      std::string( topic_id ) );
        if( registration == owner->dialogue_topics.end() ) {
            continue;
        }
        return platform_dialogue_handler{ owner, registration->second };
    }
    return std::nullopt;
}

sol::protected_function_result invoke_platform_dialogue_handler(
    const platform_dialogue_handler &registration, ::dialogue &d,
    const talk_topic &topic, const std::string_view phase )
{
    runtime &owner = *registration.owner;
    const auto handler = owner.handlers.find( registration.handler_id );
    if( handler == owner.handlers.end() ) {
        throw std::runtime_error( "missing dialogue handler '" +
                                  registration.handler_id + "'" );
    }
    if( owner.callback_depth >= 16 ) {
        throw std::runtime_error( "dialogue callback recursion limit reached" );
    }
    const const_talker *speaker = d.has_alpha ?
                                  d.const_actor( false ) : nullptr;
    const const_talker *interlocutor = d.has_beta ?
                                       d.const_actor( true ) : nullptr;
    sol::table payload = platform_callback_payload( owner, {
        { "speaker", speaker },
        { "interlocutor", interlocutor },
        { "has_speaker", d.has_alpha },
        { "has_interlocutor", d.has_beta },
        { "by_radio", d.by_radio },
        { "reason", d.reason },
        { "topic", topic.id },
        { "phase", std::string( phase ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( owner );
    return callback( payload );
}

void report_platform_dialogue_error( const platform_dialogue_handler &registration,
                                     const std::string_view topic_id,
                                     const std::string &error )
{
    DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << registration.owner->mod_id
                                << "' dialogue topic '" << topic_id << "': " << error;
}

void add_platform_dialogue_response( ::dialogue &d, const std::string &text,
                                     const std::string &next_topic )
{
    talk_response response;
    response.truetext = no_translation( text );
    response.truefalse_condition = []( const_dialogue const & ) {
        return true;
    };
    response.success.next_topic = talk_topic( next_topic );
    d.add_gen_response( response, false );
}

} // namespace

std::optional<std::string> platform_dialogue_dynamic_line( ::dialogue &d,
        const talk_topic &topic )
{
    const std::optional<declarative_platform_dialogue_topic_registration>
    declarative_registration = find_declarative_platform_dialogue_topic( topic.id );
    if( declarative_registration ) {
        try {
            return evaluate_declarative_platform_dialogue_line(
                       *declarative_registration, d, topic );
        } catch( const std::exception &exception ) {
            report_declarative_platform_dialogue_error(
                *declarative_registration, topic.id, exception.what() );
            return "&This dialogue is unavailable because its Lua handler failed.";
        }
    }
    const std::optional<platform_dialogue_handler> registration =
        find_platform_dialogue_handler( topic.id );
    if( !registration ) {
        return std::nullopt;
    }
    try {
        const sol::protected_function_result result =
            invoke_platform_dialogue_handler( *registration, d, topic, "line" );
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.get_type() != sol::type::string ) {
            throw std::runtime_error( "line phase must return a string" );
        }
        std::string line = result.get<std::string>();
        if( line.empty() || line.size() > 16384 ||
            line.find( '\0' ) != std::string::npos ) {
            throw std::runtime_error( "line must contain 1 to 16384 non-NUL bytes" );
        }
        return line;
    } catch( const std::exception &exception ) {
        report_platform_dialogue_error( *registration, topic.id, exception.what() );
        return "&This dialogue is unavailable because its Lua handler failed.";
    }
}

void apply_platform_dialogue_speaker_effects( ::dialogue &d,
        const talk_topic &topic )
{
    const auto apply_source = [&d, &topic](
                                  const std::shared_ptr<runtime> &owner, const sol::object & source,
    const std::string_view label ) {
        if( !owner || !source.valid() || source.get_type() == sol::type::nil ) {
            return;
        }
        try {
            std::vector<sol::protected_function> callbacks;
            if( source.get_type() == sol::type::function ) {
                callbacks.push_back( source.as<sol::protected_function>() );
            } else if( source.get_type() == sol::type::table ) {
                const sol::table values = source.as<sol::table>();
                const std::size_t count = detail::checked_dense_array(
                                              values, "dialogue speaker effects", 0, 256 );
                callbacks.reserve( count );
                for( std::size_t index = 1; index <= count; ++index ) {
                    const sol::object value = values.raw_get<sol::object>( index );
                    if( value.get_type() != sol::type::function ) {
                        throw std::invalid_argument(
                            "dialogue speaker effects must contain functions" );
                    }
                    callbacks.push_back( value.as<sol::protected_function>() );
                }
            } else {
                throw std::invalid_argument(
                    "dialogue speaker effects must be a function or array table" );
            }
            for( sol::protected_function &callback : callbacks ) {
                const std::shared_ptr<platform_dialogue_context> context =
                    make_platform_dialogue_context( *owner, d, topic.id, true );
                if( owner->callback_depth >= 16 ) {
                    context->invalidate();
                    throw std::runtime_error(
                        "dialogue callback recursion limit reached" );
                }
                callback_scope scope( *owner );
                const sol::protected_function_result result = callback( context );
                context->invalidate();
                if( !result.valid() ) {
                    const sol::error error = result;
                    throw std::runtime_error( error.what() );
                }
            }
        } catch( const std::exception &exception ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << owner->mod_id
                                        << "' dialogue " << label << " '"
                                        << topic.id << "': " << exception.what();
        }
    };

    const std::optional<declarative_platform_dialogue_topic_registration>
    registration = find_declarative_platform_dialogue_topic( topic.id );
    if( registration ) {
        apply_source( registration->owner,
                      registration->definition->speaker_effects, "topic" );
    }
    const std::vector<std::shared_ptr<runtime>> runtimes = detail::active_runtime_values();
    for( const std::shared_ptr<runtime> &owner : runtimes ) {
        if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
            continue;
        }
        for( const runtime::declarative_dialogue_extension &extension :
             owner->declarative_dialogue_extensions ) {
            if( extension.id == topic.id ) {
                apply_source( owner, extension.speaker_effects, "extension" );
            }
        }
    }
}

bool gen_platform_dialogue_responses( ::dialogue &d, const talk_topic &topic )
{
    const std::optional<declarative_platform_dialogue_topic_registration>
    declarative_registration = find_declarative_platform_dialogue_topic( topic.id );
    if( declarative_registration ) {
        try {
            const sol::object responses =
                evaluate_declarative_platform_dialogue_responses(
                    declarative_registration->owner,
                    declarative_registration->definition->responses,
                    d, topic.id );
            bool switch_done = false;
            add_declarative_platform_dialogue_responses(
                d, declarative_registration->owner, topic.id, responses,
                declarative_registration->definition->insert_before_standard_exits,
                switch_done );
            add_declarative_platform_dialogue_repeat_responses(
                d, declarative_registration->owner, topic.id,
                declarative_registration->definition->repeat_responses,
                declarative_registration->definition->insert_before_standard_exits,
                switch_done );
            return declarative_registration->definition->replace_built_in_responses;
        } catch( const std::exception &exception ) {
            report_declarative_platform_dialogue_error(
                *declarative_registration, topic.id, exception.what() );
            add_platform_dialogue_response( d, "End the conversation.", "TALK_DONE" );
            return true;
        }
    }
    const std::optional<platform_dialogue_handler> registration =
        find_platform_dialogue_handler( topic.id );
    if( !registration ) {
        return false;
    }
    try {
        const sol::protected_function_result result =
            invoke_platform_dialogue_handler( *registration, d, topic, "responses" );
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.get_type() != sol::type::table ) {
            throw std::runtime_error( "responses phase must return an array table" );
        }
        const sol::table responses = result.get<sol::table>();
        const std::size_t count = detail::checked_dense_array(
                                      responses, "dialogue responses", 1,
                                      maximum_platform_dialogue_responses_per_topic );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object entry = responses.raw_get<sol::object>( index );
            if( entry.get_type() != sol::type::table ) {
                throw std::runtime_error( "dialogue responses must contain tables" );
            }
            const sol::table descriptor = entry.as<sol::table>();
            for( const auto &field : descriptor ) {
                if( field.first.get_type() != sol::type::string ) {
                    throw std::runtime_error(
                        "dialogue response descriptor keys must be strings" );
                }
                const std::string key = field.first.as<std::string>();
                if( key != "text" && key != "topic" ) {
                    throw std::runtime_error(
                        "dialogue response descriptor has unknown field '" + key + "'" );
                }
            }
            const sol::object text_value = descriptor.raw_get<sol::object>( "text" );
            if( text_value.get_type() != sol::type::string ) {
                throw std::runtime_error(
                    "dialogue response descriptor requires string field 'text'" );
            }
            const std::string text = text_value.as<std::string>();
            const sol::object topic_value = descriptor.raw_get<sol::object>( "topic" );
            if( topic_value.valid() && topic_value.get_type() != sol::type::nil &&
                topic_value.get_type() != sol::type::string ) {
                throw std::runtime_error(
                    "dialogue response descriptor field 'topic' must be a string" );
            }
            const std::string next_topic = topic_value.valid() &&
                                           topic_value.get_type() == sol::type::string ?
                                           topic_value.as<std::string>() : "TALK_NONE";
            if( text.empty() || text.size() > 16384 ||
                text.find( '\0' ) != std::string::npos ) {
                throw std::runtime_error( "dialogue response text is invalid" );
            }
            if( next_topic.empty() || next_topic.size() > 256 ||
                next_topic.find( '\0' ) != std::string::npos ) {
                throw std::runtime_error( "dialogue response topic is invalid" );
            }
            add_platform_dialogue_response( d, text, next_topic );
        }
        return true;
    } catch( const std::exception &exception ) {
        report_platform_dialogue_error( *registration, topic.id, exception.what() );
        add_platform_dialogue_response( d, "End the conversation.", "TALK_DONE" );
        return true;
    }
}

void extend_platform_dialogue_responses( ::dialogue &d, const talk_topic &topic )
{
    const std::vector<std::shared_ptr<runtime>> runtimes = detail::active_runtime_values();
    for( const std::shared_ptr<runtime> &owner : runtimes ) {
        if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
            continue;
        }
        for( const runtime::declarative_dialogue_extension &extension :
             owner->declarative_dialogue_extensions ) {
            if( extension.id != topic.id ) {
                continue;
            }
            try {
                bool switch_done = false;
                if( extension.responses.valid() &&
                    extension.responses.get_type() != sol::type::nil ) {
                    const sol::object responses =
                        evaluate_declarative_platform_dialogue_responses(
                            owner, extension.responses, d, topic.id );
                    add_declarative_platform_dialogue_responses(
                        d, owner, topic.id, responses,
                        extension.insert_before_standard_exits, switch_done );
                }
                add_declarative_platform_dialogue_repeat_responses(
                    d, owner, topic.id, extension.repeat_responses,
                    extension.insert_before_standard_exits, switch_done );
            } catch( const std::exception &exception ) {
                DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << owner->mod_id
                                            << "' declarative dialogue extension '"
                                            << topic.id << "': " << exception.what();
            }
        }
    }
}

talk_topic invoke_platform_dialogue_response_callback(
    const std::weak_ptr<runtime> weak_owner, const std::string topic_id,
    sol::protected_function callback, ::dialogue &d, const talk_topic &fallback,
    const bool trial_success )
{
    const std::shared_ptr<runtime> owner = weak_owner.lock();
    if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
        return fallback;
    }
    const std::shared_ptr<platform_dialogue_context> context =
        make_platform_dialogue_context( *owner, d, topic_id );
    try {
        if( owner->callback_depth >= 16 ) {
            throw std::runtime_error( "dialogue callback recursion limit reached" );
        }
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback(
                    context, trial_success, fallback.id );
        context->invalidate();
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
            return fallback;
        }
        if( result.get_type() == sol::type::string ) {
            const std::string next_topic = result.get<std::string>();
            if( valid_platform_dialogue_id( next_topic ) ) {
                return talk_topic( next_topic );
            }
            throw std::invalid_argument(
                "dialogue on_select returned an invalid topic id" );
        }
        if( result.get_type() == sol::type::table ) {
            const sol::table table = result.get<sol::table>();
            validate_platform_dialogue_descriptor_keys(
                table, { "topic", "item", "reason" }, "callback result" );
            const sol::object raw_topic = table.raw_get<sol::object>( "topic" );
            std::string next_topic = fallback.id;
            if( raw_topic.valid() && raw_topic.get_type() != sol::type::nil ) {
                if( raw_topic.get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "dialogue on_select result topic must be a string" );
                }
                next_topic = raw_topic.as<std::string>();
            }
            if( !valid_platform_dialogue_id( next_topic ) ) {
                throw std::invalid_argument(
                    "dialogue on_select returned an invalid topic id" );
            }
            const std::string item_id = table.get_or(
                                            "item", fallback.item_type.is_null() ?
                                            std::string() : fallback.item_type.str() );
            const std::string reason = table.get_or( "reason", fallback.reason );
            if( ( !item_id.empty() && !itype_id( item_id ).is_valid() ) ||
                reason.size() > 4096 || reason.find( '\0' ) != std::string::npos ) {
                throw std::invalid_argument(
                    "dialogue on_select returned an invalid topic payload" );
            }
            return talk_topic( next_topic,
                               item_id.empty() ? itype_id::NULL_ID() : itype_id( item_id ),
                               reason );
        }
        throw std::invalid_argument(
            "dialogue callback must return nil, a string, or a topic table" );
    } catch( const std::exception &exception ) {
        context->invalidate();
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << owner->mod_id
                                    << "' dialogue on_select '" << topic_id
                                    << "': " << exception.what();
        return fallback;
    }
}


} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
