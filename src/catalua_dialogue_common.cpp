#include "catalua_dialogue_common.h"

#include <algorithm>
#include <charconv>
#include <stdexcept>
#include <system_error>
#include <unordered_map>
#include <utility>

#include "avatar.h"
#include "calendar.h"
#include "character.h"
#include "item.h"
#include "item_factory.h"
#include "math_parser_diag_value.h"
#include "npc.h"
#include "npctrade.h"
#include "popup.h"
#include "translations.h"

namespace cata::lua_dialogue
{

struct context::state {
    lua_State *lua_state = nullptr;
    dialogue *d = nullptr;
    std::string topic_id;
    bool allow_write = false;
    std::string invalid_context_message;
    actor_converter convert_actor;

    dialogue &dialogue_ref() const {
        return *d;
    }
};

namespace
{

talk_trial make_native_dialogue_trial(
    const std::string &kind, const int difficulty,
    const std::string &requested_skill )
{
    talk_trial result;
    result.difficulty = difficulty;
    if( kind == "none" ) {
        result.type = TALK_TRIAL_NONE;
    } else if( kind == "lie" ) {
        result.type = TALK_TRIAL_LIE;
    } else if( kind == "persuade" ) {
        result.type = TALK_TRIAL_PERSUADE;
    } else if( kind == "intimidate" ) {
        result.type = TALK_TRIAL_INTIMIDATE;
    } else if( kind == "skill_check" ) {
        const skill_id skill( requested_skill );
        if( requested_skill.empty() || !skill.is_valid() ) {
            throw std::invalid_argument(
                "dialogue skill trial requires a valid skill id" );
        }
        result.type = TALK_TRIAL_SKILL_CHECK;
        result.skill_required = requested_skill;
        return result;
    } else {
        throw std::invalid_argument(
            "dialogue trial kind must be none, lie, persuade, intimidate, or skill_check" );
    }
    if( !requested_skill.empty() ) {
        throw std::invalid_argument(
            "dialogue trial skill is only valid for skill_check" );
    }
    return result;
}

} // namespace

context::context( lua_State *const lua_state, dialogue &d, std::string topic_id,
                  const bool allow_write, std::string invalid_context_message,
                  actor_converter convert_actor )
    : state_( std::make_shared<state>() )
{
    state_->lua_state = lua_state;
    state_->d = &d;
    state_->topic_id = std::move( topic_id );
    state_->allow_write = allow_write;
    state_->invalid_context_message = std::move( invalid_context_message );
    state_->convert_actor = std::move( convert_actor );
}

bool context::valid() const noexcept
{
    return state_ != nullptr && state_->d != nullptr;
}

void context::invalidate() noexcept
{
    if( state_ != nullptr ) {
        state_->d = nullptr;
    }
}

context::state &context::require_state() const
{
    if( !valid() ) {
        throw std::runtime_error( state_ == nullptr ?
                                  "Lua dialogue context is no longer valid" :
                                  state_->invalid_context_message );
    }
    return *state_;
}

context::state &context::require_write_state() const
{
    state &result = require_state();
    if( !result.allow_write ) {
        throw std::runtime_error(
            "Lua dialogue mutation requires an active Platform write callback" );
    }
    return result;
}

std::string context::topic() const
{
    return require_state().topic_id;
}

std::string context::topic_item() const
{
    return require_state().dialogue_ref().cur_item.str();
}

bool context::has_alpha() const
{
    return require_state().dialogue_ref().has_alpha;
}

bool context::has_beta() const
{
    return require_state().dialogue_ref().has_beta;
}

bool context::by_radio() const
{
    return require_state().dialogue_ref().by_radio;
}

bool context::has_reason() const
{
    return !require_state().dialogue_ref().reason.empty();
}

std::string context::reason() const
{
    return require_state().dialogue_ref().reason;
}

int context::trial_chance( const std::string &kind, const int difficulty,
                           const std::string &skill ) const
{
    const talk_trial trial = make_native_dialogue_trial(
                                 kind, difficulty, skill );
    return trial.calc_chance( require_state().dialogue_ref() );
}

bool context::roll_trial( const std::string &kind, const int difficulty,
                          const std::string &skill ) const
{
    talk_trial trial = make_native_dialogue_trial(
                           kind, difficulty, skill );
    return trial.roll( require_write_state().dialogue_ref() );
}

std::string context::expand_text( const std::string &text,
                                  const std::string &item_id ) const
{
    if( text.size() > 32768 || text.find( '\0' ) != std::string::npos ||
        item_id.size() > 256 || item_id.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "dialogue text expansion exceeds its native string limit" );
    }
    dialogue &d = require_state().dialogue_ref();
    std::unique_ptr<const_talker> fallback =
        get_const_talker_for( get_player_character() );
    const const_talker &alpha = d.has_alpha ? *d.const_actor( false ) : *fallback;
    const const_talker &beta = d.has_beta ? *d.const_actor( true ) : *fallback;
    std::string result = text;
    parse_tags( result, alpha, beta, d,
                item_id.empty() ? itype_id::NULL_ID() : itype_id( item_id ) );
    return result;
}

sol::object context::alpha() const
{
    state &current = require_state();
    dialogue &d = current.dialogue_ref();
    if( !d.has_alpha ) {
        return sol::make_object(
                   sol::state_view( current.lua_state ),
                   sol::lua_nil );
    }
    if( !current.convert_actor ) {
        throw std::runtime_error(
            "Lua dialogue actor conversion is unavailable" );
    }
    return current.convert_actor( *d.const_actor( false ) );
}

sol::object context::beta() const
{
    state &current = require_state();
    dialogue &d = current.dialogue_ref();
    if( !d.has_beta ) {
        return sol::make_object(
                   sol::state_view( current.lua_state ),
                   sol::lua_nil );
    }
    if( !current.convert_actor ) {
        throw std::runtime_error(
            "Lua dialogue actor conversion is unavailable" );
    }
    return current.convert_actor( *d.const_actor( true ) );
}

sol::object context::get( const std::string &key ) const
{
    const dialogue &d = require_state().dialogue_ref();
    const diag_value *value = d.maybe_get_value( key );
    sol::state_view lua( require_state().lua_state );
    if( value == nullptr || value->is_empty() ) {
        return sol::make_object( lua, sol::lua_nil );
    }
    if( value->is_dbl() ) {
        return sol::make_object( lua, value->dbl() );
    }
    if( value->is_str() ) {
        return sol::make_object( lua, value->str() );
    }
    return sol::make_object( lua, value->to_string() );
}

void context::set( const std::string &key, const sol::object &value ) const
{
    dialogue &d = require_write_state().dialogue_ref();
    if( value.get_type() == sol::type::nil ) {
        d.remove_value( key );
    } else if( value.get_type() == sol::type::number ) {
        d.set_value( key, value.as<double>() );
    } else if( value.get_type() == sol::type::string ) {
        d.set_value( key, value.as<std::string>() );
    } else if( value.get_type() == sol::type::boolean ) {
        d.set_value( key, value.as<bool>() ? "true" : "false" );
    } else {
        throw std::invalid_argument(
            "dialogue context values must be nil, string, number, or boolean" );
    }
}

void context::remove( const std::string &key ) const
{
    require_write_state().dialogue_ref().remove_value( key );
}

bool context::quote_trade_item( const std::string &item_name, const int count,
                                const std::string &prefix ) const
{
    dialogue &d = require_write_state().dialogue_ref();
    const auto set_quote = [&d, &prefix]( const std::string & item_id,
                                          const std::string & display_name,
    const int item_count, const int cost ) {
        d.set_value( prefix + "_item_id", item_id );
        d.set_value( prefix + "_item_name", display_name );
        d.set_value( prefix + "_count", item_count );
        d.set_value( prefix + "_cost", cost );
    };

    // Match native item spawning: dialogue-authored legacy IDs resolve through
    // the active item migrations before their definition and price are read.
    const itype_id item_id = item_controller->migrate_id( itype_id( item_name ) );
    const int stored_count = count > 0 ? count : 0;
    Character *buyer = d.actor( false )->get_character();
    Character *seller = d.actor( true )->get_character();
    if( npc *seller_npc = d.actor( true )->get_npc() ) {
        seller = &seller_npc->get_trade_delegate();
    }

    if( buyer == nullptr || seller == nullptr || count <= 0 || !item_id.is_valid() ) {
        set_quote( item_name, item_name, stored_count, -1 );
        return false;
    }

    item quote_item( item_id, calendar::turn );
    if( quote_item.count_by_charges() ) {
        quote_item.charges = count;
    }
    const int quoted_cost = npc_trading::trading_price_for_order(
                                *buyer, *seller, quote_item, count );
    set_quote( item_id.str(), item::nname( item_id, count ), count,
               quoted_cost > 0 ? quoted_cost : -1 );
    return quoted_cost > 0;
}

namespace
{

std::string context_string( dialogue &d, const std::string &key )
{
    const diag_value *value = d.maybe_get_value( key );
    if( value == nullptr || value->is_empty() ) {
        return {};
    }
    if( value->is_str() ) {
        return value->str();
    }
    return value->to_string();
}

int context_int( dialogue &d, const std::string &key, const int fallback )
{
    const diag_value *value = d.maybe_get_value( key );
    if( value == nullptr || value->is_empty() ) {
        return fallback;
    }
    if( value->is_dbl() ) {
        return static_cast<int>( value->dbl() );
    }
    if( value->is_str() ) {
        int parsed = fallback;
        const std::string &text = value->str();
        const char *begin = text.data();
        const char *end = begin + text.size();
        const std::from_chars_result result = std::from_chars( begin, end, parsed );
        if( result.ec == std::errc() && result.ptr == end ) {
            return parsed;
        }
    }
    return fallback;
}

struct stored_response_callback {
    response_callback_origin origin;
    response_callback callback;
};

std::unordered_map<std::uint64_t, stored_response_callback> response_callbacks;
std::uint64_t next_response_callback_id = 1;

} // namespace

bool context::buy_quoted_item( const std::string &prefix ) const
{
    dialogue &d = require_write_state().dialogue_ref();
    const std::string item_name = context_string( d, prefix + "_item_id" );
    const int count = context_int( d, prefix + "_count", 1 );
    const int cost = context_int( d, prefix + "_cost", 0 );
    const itype_id item_id( item_name );
    if( count <= 0 || cost <= 0 || !item_id.is_valid() ) {
        return false;
    }
    if( !d.actor( true )->buy_from( cost ) ) {
        popup( _( "You can't afford it!" ) );
        return false;
    }

    item new_item( item_id, calendar::turn );
    if( new_item.count_by_charges() ) {
        new_item.charges = count;
        d.actor( false )->i_add_or_drop( new_item );
    } else {
        for( int index = 0; index < count; ++index ) {
            d.actor( false )->i_add_or_drop( new_item );
        }
    }
    if( d.has_beta && !d.actor( true )->disp_name().empty() ) {
        if( count == 1 ) {
            popup( _( "%1$s gives you a %2$s." ),
                   d.actor( true )->disp_name(), new_item.tname() );
        } else {
            popup( _( "%1$s gives you %2$d %3$s." ),
                   d.actor( true )->disp_name(), count,
                   new_item.tname() );
        }
    }
    return true;
}

bool valid_topic_id( const std::string &value )
{
    return !value.empty() && value.size() <= 256 &&
           value.find( '\0' ) == std::string::npos;
}

void require_text( const std::string &value, const std::string_view api_name,
                   const std::string_view field )
{
    if( value.empty() || value.size() > 4096 ||
        value.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument( std::string( api_name ) + " " +
                                     std::string( field ) +
                                     " must contain 1 to 4096 non-NUL bytes" );
    }
}

std::uint64_t register_response_callback( const response_callback_origin origin,
        response_callback callback )
{
    if( next_response_callback_id == 0 ) {
        throw std::runtime_error( "dialogue response callback id space is exhausted" );
    }
    const std::uint64_t id = next_response_callback_id++;
    response_callbacks.emplace( id, stored_response_callback{ origin, std::move( callback ) } );
    return id;
}

void clear_response_callbacks()
{
    response_callbacks.clear();
}

void clear_response_callbacks( const response_callback_origin origin )
{
    for( auto iter = response_callbacks.begin(); iter != response_callbacks.end(); ) {
        if( iter->second.origin == origin ) {
            iter = response_callbacks.erase( iter );
        } else {
            ++iter;
        }
    }
}

talk_topic apply_response_callback( dialogue &d, const std::uint64_t response_id,
                                    const talk_topic &fallback, const bool trial_success )
{
    const auto found = response_callbacks.find( response_id );
    if( found == response_callbacks.end() ) {
        return fallback;
    }
    response_callback callback = std::move( found->second.callback );
    response_callbacks.erase( found );
    return callback( d, fallback, trial_success );
}

talk_response response_from_table( const sol::table &descriptor,
                                   const response_descriptor_options &options )
{
    for( const auto &entry : descriptor ) {
        if( entry.first.get_type() != sol::type::string ) {
            if( options.reject_non_string_keys ) {
                throw std::invalid_argument( std::string( options.api_name ) + " " +
                                             std::string( options.descriptor_name ) +
                                             " keys must be strings" );
            }
            continue;
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "text" && key != "topic" && key != "on_select" &&
            options.additional_fields.count( key ) == 0 ) {
            throw std::invalid_argument( std::string( options.api_name ) + " " +
                                         std::string( options.descriptor_name ) + " " +
                                         std::string( options.unknown_field_verb ) +
                                         " unknown field '" + key + "'" );
        }
    }

    const sol::object raw_text = descriptor.raw_get<sol::object>( "text" );
    if( !raw_text.valid() || raw_text.get_type() != sol::type::string ) {
        throw std::invalid_argument( std::string( options.api_name ) +
                                     " response requires string field 'text'" );
    }
    const std::string text = raw_text.as<std::string>();
    options.require_text( text, "response text" );

    std::string next_topic = "TALK_NONE";
    const sol::object raw_topic = descriptor.raw_get<sol::object>( "topic" );
    if( raw_topic.valid() && raw_topic.get_type() != sol::type::nil ) {
        if( raw_topic.get_type() != sol::type::string ) {
            throw std::invalid_argument( std::string( options.api_name ) +
                                         " response field 'topic' must be a string" );
        }
        next_topic = raw_topic.as<std::string>();
        if( !options.valid_topic( next_topic ) ) {
            throw std::invalid_argument( std::string( options.api_name ) +
                                         " response topic has an invalid id" );
        }
    }

    talk_response response;
    response.truetext = no_translation( text );
    response.truefalse_condition = []( const_dialogue const & ) {
        return true;
    };
    response.success.next_topic = talk_topic( next_topic );

    const sol::object raw_on_select = descriptor.raw_get<sol::object>( "on_select" );
    if( raw_on_select.valid() && raw_on_select.get_type() != sol::type::nil ) {
        if( raw_on_select.get_type() != sol::type::function ) {
            throw std::invalid_argument( std::string( options.api_name ) +
                                         " response field 'on_select' must be a function" );
        }
        response.lua_response_id = options.register_on_select(
                                      raw_on_select.as<sol::protected_function>() );
    }
    return response;
}

} // namespace cata::lua_dialogue
