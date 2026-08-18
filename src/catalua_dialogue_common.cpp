#include "catalua_dialogue_common.h"

#include <algorithm>
#include <charconv>
#include <stdexcept>
#include <system_error>
#include <unordered_map>
#include <utility>

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

    dialogue &dialogue_ref() const {
        return *d;
    }
};

context::context( lua_State *const lua_state, dialogue &d, std::string topic_id,
                  const bool allow_write, std::string invalid_context_message )
    : state_( std::make_shared<state>() )
{
    state_->lua_state = lua_state;
    state_->d = &d;
    state_->topic_id = std::move( topic_id );
    state_->allow_write = allow_write;
    state_->invalid_context_message = std::move( invalid_context_message );
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
            "Lua dialogue mutation requires capability 'game.write'" );
    }
    return result;
}

std::string context::topic() const
{
    return require_state().topic_id;
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
                                    const talk_topic &fallback )
{
    const auto found = response_callbacks.find( response_id );
    if( found == response_callbacks.end() ) {
        return fallback;
    }
    response_callback callback = std::move( found->second.callback );
    response_callbacks.erase( found );
    return callback( d, fallback );
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
        if( key != "text" && key != "topic" && key != "on_select" ) {
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
