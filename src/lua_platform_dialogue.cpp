#include "lua_platform_dialogue.h"

#include "lua_platform_state.h"
#include <calendar.h>
#include <character_id.h>
#include <coordinates.h>
#include <dialogue.h>
#include <effect.h>
#include <flag.h>
#include <item_uid.h>
#include <lua_platform_bindings_values.h>
#include <lua_platform_handle.h>
#include <lua_platform_hooks.h>
#include <lua_platform_items.h>
#include <npctalk.h>
#include <overmapbuffer.h>
#include <output.h>
#include <point.h>
#include <safe_reference.h>
#include <talker.h>
#include <translation.h>
#include <type_id.h>
#include <cmath>
#include <limits>
#include <stdexcept>
#include <unordered_map>
#include <utility>
#include <vector>

#include "character.h"
#include "creature.h"
#include "item.h"
#include "math_parser_diag_value.h"
#include "npc.h"

namespace cata::lua_platform::dialogue
{

struct dialogue_context_lifetime {
    ::dialogue *native = nullptr;
    bool active = true;

    ::dialogue *dialogue_ptr() const noexcept {
        return active ? native : nullptr;
    }

    void retire() noexcept {
        active = false;
        native = nullptr;
    }
};

struct dialogue_lifetime {
    const ::dialogue *native_dialogue = nullptr;
    bool active = true;
    std::vector<std::weak_ptr<dialogue_session>> sessions;
    std::vector<std::weak_ptr<dialogue_context_lifetime>> contexts;

    void retire() noexcept;
};

namespace
{

struct dialogue_session_registry {
    std::unordered_map<const ::dialogue *, std::shared_ptr<dialogue_lifetime>> lifetimes;
    std::uint64_t next_generation = 1;
};

dialogue_session_registry &session_registry()
{
    static dialogue_session_registry registry;
    return registry;
}

std::uint64_t next_session_generation()
{
    dialogue_session_registry &registry = session_registry();
    if( registry.next_generation == 0 ) {
        throw std::runtime_error( "dialogue session generation space is exhausted" );
    }
    return registry.next_generation++;
}

std::shared_ptr<dialogue_lifetime> active_lifetime_for( const ::dialogue &d )
{
    const dialogue_session_registry &registry = session_registry();
    const auto found = registry.lifetimes.find( &d );
    if( found == registry.lifetimes.end() || !found->second ||
        !found->second->active || found->second->native_dialogue != &d ) {
        return nullptr;
    }
    return found->second;
}

void retire_lifetime( const std::shared_ptr<dialogue_lifetime> &lifetime ) noexcept
{
    if( !lifetime ) {
        return;
    }
    lifetime->retire();
}

} // namespace

void dialogue_lifetime::retire() noexcept
{
    active = false;
    for( const std::weak_ptr<dialogue_session> &stored : sessions ) {
        if( const std::shared_ptr<dialogue_session> session = stored.lock() ) {
            session->deactivate();
        }
    }
    for( const std::weak_ptr<dialogue_context_lifetime> &stored : contexts ) {
        if( const std::shared_ptr<dialogue_context_lifetime> context = stored.lock() ) {
            context->retire();
        }
    }
    sessions.clear();
    contexts.clear();
    native_dialogue = nullptr;
}

dialogue_session::dialogue_session(
    const std::uint64_t generation, std::string topic,
    game_handle_runtime runtime_identity, const std::size_t world_generation,
    std::shared_ptr<dialogue_lifetime> native_lifetime ) :
    generation_( generation ), topic_( std::move( topic ) ),
    runtime_identity_( std::move( runtime_identity ) ),
    world_generation_( world_generation ),
    native_dialogue_( native_lifetime ? native_lifetime->native_dialogue : nullptr ),
    native_lifetime_( std::move( native_lifetime ) )
{
}

std::uint64_t dialogue_session::generation() const noexcept
{
    return generation_;
}

bool dialogue_session::active() const noexcept
{
    return active_ && native_lifetime_ && native_lifetime_->active &&
           runtime_identity_.has_live_owner();
}

bool dialogue_session::participants_live() const noexcept
{
    if( !active() ) {
        return false;
    }

    const auto participant_live = []( const native_callback_talker & participant ) {
        if( !participant.present ) {
            return true;
        }
        if( !participant.entity || !participant.entity->valid() ) {
            return !participant.entity;
        }
        switch( participant.entity->kind() ) {
            case native_callback_entity_kind::creature: {
                Creature *creature = participant.entity->creature_reference().get();
                if( creature == nullptr || creature->is_dead_state() ) {
                    return false;
                }
                if( participant.kind == "avatar" && !creature->is_avatar() ) {
                    return false;
                }
                if( participant.kind == "npc" && !creature->is_npc() ) {
                    return false;
                }
                if( participant.kind == "monster" && !creature->is_monster() ) {
                    return false;
                }
                if( participant.stable_id ) {
                    const Character *character = creature->as_character();
                    if( character == nullptr ||
                        character->getID().get_value() != *participant.stable_id ) {
                        return false;
                    }
                }
                return true;
            }
            case native_callback_entity_kind::item: {
                item *value = participant.entity->item_reference().get();
                return value != nullptr && !value->is_null() &&
                       ( !participant.stable_id ||
                         value->uid().get_value() == *participant.stable_id );
            }
            case native_callback_entity_kind::vehicle:
                return participant.entity->vehicle_reference().get() != nullptr;
            case native_callback_entity_kind::none:
                return false;
        }
        return false;
    };

    return participant_live( speaker_ ) && participant_live( interlocutor_ );
}

bool dialogue_session::active_for( const std::string_view topic ) const noexcept
{
    return active() && topic_ == topic && participants_live();
}

bool dialogue_session::active_for( const std::string_view topic,
                                   const ::dialogue *native_dialogue ) const noexcept
{
    return active() && topic_ == topic && native_dialogue_ == native_dialogue &&
           participants_live();
}

bool dialogue_session::active_for(
    const std::string_view topic, const game_handle_runtime &runtime_identity,
    const std::size_t world_generation, const ::dialogue *native_dialogue ) const noexcept
{
    return active_ && topic_ == topic && native_dialogue_ == native_dialogue &&
           native_lifetime_ && native_lifetime_->active &&
           runtime_identity_.is_active_match( runtime_identity ) &&
           world_generation_ == world_generation && participants_live();
}

std::optional<game_handle_error> dialogue_session::validation_error(
    const ::dialogue *native_dialogue, const game_handle_runtime &runtime_identity,
    const std::size_t world_generation ) const
{
    if( !runtime_identity_.has_live_owner() ) {
        return game_handle_error {
            "stale_runtime", "Dialogue session owner runtime is no longer alive"
        };
    }
    if( !runtime_identity.has_live_owner() ||
        !runtime_identity_.same_identity( runtime_identity ) ) {
        return game_handle_error {
            "stale_runtime", "Dialogue session belongs to a different Lua runtime owner"
        };
    }
    if( world_generation_ != world_generation ) {
        return game_handle_error {
            "stale_world", "Dialogue session belongs to a different world generation"
        };
    }
    if( !native_lifetime_ || !native_lifetime_->active ||
        native_dialogue_ != native_dialogue ) {
        return game_handle_error {
            "destroyed", "Dialogue session native dialogue lifetime is no longer valid"
        };
    }
    if( !active_ ) {
        return game_handle_error {
            "stale_identity", "Dialogue session is no longer active"
        };
    }
    if( !participants_live() ) {
        return game_handle_error {
            "stale_identity", "Dialogue session participant identity is no longer live"
        };
    }
    return std::nullopt;
}

const native_callback_talker &dialogue_session::speaker_snapshot() const noexcept
{
    return speaker_;
}

const native_callback_talker &dialogue_session::interlocutor_snapshot() const noexcept
{
    return interlocutor_;
}

void dialogue_session::set_participants( ::dialogue &d )
{
    speaker_ = d.has_actor( false ) ?
               snapshot_native_callback_talker( *d.const_actor( false ) ) :
               native_callback_talker{};
    interlocutor_ = d.has_actor( true ) ?
                    snapshot_native_callback_talker( *d.const_actor( true ) ) :
                    native_callback_talker{};
}

void dialogue_session::set_topic( std::string topic )
{
    topic_ = std::move( topic );
}

void dialogue_session::deactivate() noexcept
{
    active_ = false;
    for( const std::weak_ptr<dialogue_context_lifetime> &stored : contexts_ ) {
        if( const std::shared_ptr<dialogue_context_lifetime> context = stored.lock() ) {
            context->retire();
        }
    }
    contexts_.clear();
}

void begin_dialogue( ::dialogue &d )
{
    dialogue_session_registry &registry = session_registry();
    if( const auto found = registry.lifetimes.find( &d );
        found != registry.lifetimes.end() ) {
        retire_lifetime( found->second );
    }
    const std::shared_ptr<dialogue_lifetime> lifetime =
        std::make_shared<dialogue_lifetime>();
    lifetime->native_dialogue = &d;
    registry.lifetimes[&d] = lifetime;
}

dialogue_session_ptr begin_session(
    ::dialogue &d, const game_handle_runtime &runtime_identity,
    const std::size_t world_generation )
{
    if( !runtime_identity.has_live_owner() ) {
        return nullptr;
    }
    begin_dialogue( d );
    const std::shared_ptr<dialogue_lifetime> lifetime = active_lifetime_for( d );
    dialogue_session_ptr result( new dialogue_session(
                                     next_session_generation(), std::string(),
                                     runtime_identity, world_generation, lifetime ) );
    result->set_participants( d );
    lifetime->sessions.push_back( result );
    return result;
}

dialogue_session_ptr session_for(
    ::dialogue &d, const std::string_view topic,
    const game_handle_runtime &runtime_identity,
    const std::size_t world_generation )
{
    if( !runtime_identity.has_live_owner() ) {
        return nullptr;
    }
    const std::shared_ptr<dialogue_lifetime> lifetime = active_lifetime_for( d );
    if( !lifetime ) {
        return nullptr;
    }
    for( const std::weak_ptr<dialogue_session> &stored : lifetime->sessions ) {
        const dialogue_session_ptr result = stored.lock();
        if( !result || !result->runtime_identity_.same_identity( runtime_identity ) ) {
            continue;
        }
        if( result->validation_error( &d, runtime_identity, world_generation ) ||
            ( !result->topic_.empty() && result->topic_ != topic ) ) {
            result->deactivate();
            continue;
        }
        if( result->topic_.empty() ) {
            result->set_topic( std::string( topic ) );
        }
        return result;
    }

    dialogue_session_ptr result( new dialogue_session(
                                     next_session_generation(), std::string( topic ),
                                     runtime_identity, world_generation, lifetime ) );
    result->set_participants( d );
    lifetime->sessions.push_back( result );
    return result;
}

void end_session( ::dialogue &d ) noexcept
{
    dialogue_session_registry &registry = session_registry();
    const auto found = registry.lifetimes.find( &d );
    if( found == registry.lifetimes.end() ) {
        return;
    }
    retire_lifetime( found->second );
    registry.lifetimes.erase( found );
}

void retire_sessions_for_runtime(
    const game_handle_runtime &runtime_identity ) noexcept
{
    dialogue_session_registry &registry = session_registry();
    for( const auto &[native_dialogue, lifetime] : registry.lifetimes ) {
        ( void )native_dialogue;
        if( !lifetime ) {
            continue;
        }
        for( const std::weak_ptr<dialogue_session> &stored : lifetime->sessions ) {
            if( const dialogue_session_ptr session = stored.lock();
                session && session->runtime_identity_.same_identity( runtime_identity ) ) {
                session->deactivate();
            }
        }
    }
}

void retire_sessions_for_world( const std::size_t world_generation ) noexcept
{
    dialogue_session_registry &registry = session_registry();
    for( const auto &[native_dialogue, lifetime] : registry.lifetimes ) {
        ( void )native_dialogue;
        if( !lifetime ) {
            continue;
        }
        for( const std::weak_ptr<dialogue_session> &stored : lifetime->sessions ) {
            if( const dialogue_session_ptr session = stored.lock();
                session && session->world_generation_ == world_generation ) {
                session->deactivate();
            }
        }
    }
}

void retire_all_sessions() noexcept
{
    dialogue_session_registry &registry = session_registry();
    for( const auto &[native_dialogue, lifetime] : registry.lifetimes ) {
        ( void )native_dialogue;
        retire_lifetime( lifetime );
    }
    registry.lifetimes.clear();
}

struct context::state {
    lua_State *lua_state = nullptr;
    std::string topic_id;
    bool allow_write = false;
    bool response_action_phase = false;
    std::string invalid_context_message;
    actor_converter convert_actor;
    dialogue_session_ptr session;
    game_handle_runtime runtime_identity;
    std::size_t world_generation = 0;
    std::shared_ptr<dialogue_context_lifetime> context_lifetime;
    native_callback_talker speaker_snapshot;
    native_callback_talker interlocutor_snapshot;

    ::dialogue *dialogue_ptr() const noexcept {
        return context_lifetime ? context_lifetime->dialogue_ptr() : nullptr;
    }

    ::dialogue &dialogue_ref() const {
        return *dialogue_ptr();
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

context::context( lua_State *const lua_state, ::dialogue &d, std::string topic_id,
                  const bool allow_write, std::string invalid_context_message,
                  actor_converter convert_actor,
                  dialogue_session_ptr session,
                  game_handle_runtime runtime_identity,
                  const std::size_t world_generation,
                  const bool response_action_phase )
    : state_( std::make_shared<state>() )
{
    state_->lua_state = lua_state;
    state_->topic_id = std::move( topic_id );
    state_->allow_write = allow_write;
    state_->response_action_phase = response_action_phase;
    state_->invalid_context_message = std::move( invalid_context_message );
    state_->convert_actor = std::move( convert_actor );
    state_->session = session ? std::move( session ) :
                      session_for( d, state_->topic_id, runtime_identity,
                                   world_generation );
    state_->runtime_identity = std::move( runtime_identity );
    state_->world_generation = world_generation;
    state_->context_lifetime = std::make_shared<dialogue_context_lifetime>();
    state_->context_lifetime->native = &d;
    if( const std::shared_ptr<dialogue_lifetime> lifetime = active_lifetime_for( d ) ) {
        lifetime->contexts.push_back( state_->context_lifetime );
    } else {
        state_->context_lifetime->retire();
    }
    if( state_->session ) {
        state_->session->contexts_.push_back( state_->context_lifetime );
        if( !state_->session->active() ) {
            state_->context_lifetime->retire();
        }
    }
    if( state_->session ) {
        state_->speaker_snapshot = state_->session->speaker_snapshot();
        state_->interlocutor_snapshot = state_->session->interlocutor_snapshot();
    }
}

bool context::valid() const noexcept
{
    return state_ != nullptr && state_->dialogue_ptr() != nullptr &&
           state_->session != nullptr &&
           state_->session->active_for( state_->topic_id, state_->runtime_identity,
                                        state_->world_generation, state_->dialogue_ptr() );
}

std::optional<game_handle_error> context::validation_error() const
{
    if( state_ == nullptr || state_->session == nullptr ) {
        return game_handle_error {
            "stale_identity", "Lua dialogue context is no longer valid"
        };
    }
    const ::dialogue *native_dialogue = state_->dialogue_ptr();
    if( native_dialogue == nullptr ) {
        return game_handle_error {
            "destroyed", "Lua dialogue context native dialogue lifetime is no longer valid"
        };
    }
    if( const std::optional<game_handle_error> error = state_->session->validation_error(
                native_dialogue, state_->runtime_identity, state_->world_generation ) ) {
        return error;
    }
    if( !state_->session->active_for( state_->topic_id, state_->runtime_identity,
                                      state_->world_generation, native_dialogue ) ) {
        return game_handle_error {
            "stale_identity", "Lua dialogue context topic or participant is no longer live"
        };
    }
    return std::nullopt;
}

void context::invalidate() noexcept
{
    if( state_ != nullptr && state_->context_lifetime ) {
        state_->context_lifetime->retire();
    }
}

std::uint64_t context::generation() const
{
    return require_state().session->generation();
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

context::state &context::require_action_write_state() const
{
    state &result = require_write_state();
    if( !result.response_action_phase ) {
        throw std::runtime_error(
            "native dialogue effects require an active on_action callback" );
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

bool context::has_speaker() const
{
    return require_state().speaker_snapshot.present;
}

bool context::has_interlocutor() const
{
    return require_state().interlocutor_snapshot.present;
}

bool context::interlocutor_at_safe_space() const
{
    const ::dialogue &d = require_state().dialogue_ref();
    if( !d.has_beta ) {
        return false;
    }
    const const_talker *const beta = d.const_actor( true );
    return beta != nullptr && overmap_buffer.is_safe( beta->pos_abs_omt() ) &&
           beta->is_safe();
}

std::size_t context::assigned_mission_count() const
{
    return require_state().dialogue_ref().missions_assigned.size();
}

void context::clear_selected_mission() const
{
    ::dialogue &d = require_action_write_state().dialogue_ref();
    if( !d.has_beta ) {
        return;
    }
    talker *const interlocutor = d.actor( true );
    if( interlocutor == nullptr ) {
        return;
    }
    npc *const provider = interlocutor->get_npc();
    if( provider != nullptr ) {
        talk_function::clear_mission( *provider );
    }
}

void context::succeed_selected_mission() const
{
    ::dialogue &d = require_action_write_state().dialogue_ref();
    if( !d.has_beta ) {
        return;
    }
    talker *const interlocutor = d.actor( true );
    if( interlocutor == nullptr ) {
        return;
    }
    npc *const provider = interlocutor->get_npc();
    if( provider != nullptr ) {
        talk_function::mission_success( *provider );
    }
}

void context::fail_selected_mission() const
{
    ::dialogue &d = require_action_write_state().dialogue_ref();
    if( !d.has_beta ) {
        return;
    }
    talker *const interlocutor = d.actor( true );
    if( interlocutor == nullptr ) {
        return;
    }
    npc *const provider = interlocutor->get_npc();
    if( provider != nullptr ) {
        talk_function::mission_failure( *provider );
    }
}

void context::end_interlocutor_conversation() const
{
    ::dialogue &d = require_action_write_state().dialogue_ref();
    if( !d.has_beta ) {
        return;
    }
    talker *const interlocutor = d.actor( true );
    if( interlocutor == nullptr ) {
        return;
    }
    npc *const provider = interlocutor->get_npc();
    if( provider != nullptr ) {
        talk_function::end_conversation( *provider );
    }
}

void context::grant_item_to_speaker( const script_game_id &item_type ) const
{
    ::dialogue &d = require_action_write_state().dialogue_ref();
    if( item_type.kind() != "item" || item_type.value().empty() ||
        item_type.value().size() > 256 ||
        item_type.value().find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "dialogue grant_item_to_speaker requires a bounded GameId<item>" );
    }
    const itype_id native_type( item_type.value() );
    if( !native_type.is_valid() ) {
        throw std::invalid_argument(
            "dialogue grant_item_to_speaker requires a registered item type" );
    }
    talker *const speaker = d.actor( false );
    if( speaker == nullptr ) {
        throw std::runtime_error(
            "dialogue grant_item_to_speaker requires a live native speaker" );
    }

    // This is the no-parameter TALK u_spawn_item path: count defaults to one,
    // the actor is dialogue alpha, and Character talkers own native
    // i_add_or_drop (including its inventory/map fallback).
    item received( native_type, calendar::turn );
    if( received.has_flag( flag_PRESERVE_SPAWN_LOC ) ) {
        received.preserve_location( speaker->pos_abs() );
    }
    if( received.count_by_charges() ) {
        received.charges = 1;
    } else {
        const itype_id default_ammo = received.ammo_default();
        if( !default_ammo.is_null() ) {
            received.ammo_set( default_ammo );
        }
    }
    speaker->i_add_or_drop( received );

    if( d.has_beta ) {
        talker *const interlocutor = d.actor( true );
        if( interlocutor != nullptr && !interlocutor->disp_name().empty() ) {
            //~ %1$s is the NPC name, %2$s is an item
            popup( _( "%1$s gives you a %2$s." ), interlocutor->disp_name(),
                   received.tname() );
        }
    }
    bump_item_query_mutation_epoch();
}

bool context::purchase_pet(
    const script_game_id &monster_type,
    const sol::optional<sol::table> &requested_options ) const
{
    ::dialogue &d = require_action_write_state().dialogue_ref();
    if( monster_type.kind() != "monster" || monster_type.value().empty() ||
        monster_type.value().size() > 256 ||
        monster_type.value().find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "dialogue purchase_pet requires a bounded GameId<monster>" );
    }
    const mtype_id native_type( monster_type.value() );
    if( !native_type.is_valid() ) {
        throw std::invalid_argument(
            "dialogue purchase_pet requires a registered monster type" );
    }
    if( !d.has_beta ) {
        throw std::runtime_error(
            "dialogue purchase_pet requires a native interlocutor" );
    }

    int cost = 0;
    int count = 1;
    bool pacified = false;
    std::string name;
    if( requested_options ) {
        for( const auto &entry : *requested_options ) {
            const sol::object key_object = entry.first;
            if( key_object.get_type() != sol::type::string ) {
                throw std::invalid_argument(
                    "dialogue purchase_pet option keys must be strings" );
            }
            const std::string key = key_object.as<std::string>();
            const sol::object value = entry.second;
            if( key == "cost" || key == "count" ) {
                if( value.get_type() != sol::type::number ) {
                    throw std::invalid_argument(
                        "dialogue purchase_pet cost and count must be numbers" );
                }
                const double number = value.as<double>();
                if( !std::isfinite( number ) ||
                    number < std::numeric_limits<int>::min() ||
                    number > std::numeric_limits<int>::max() ) {
                    throw std::invalid_argument(
                        "dialogue purchase_pet cost and count must fit a native integer" );
                }
                // Native TALK's dbl_or_var values are implicitly converted to
                // the int arguments of talker::buy_monster (truncation toward zero).
                const int native_value = static_cast<int>( number );
                if( key == "cost" ) {
                    cost = native_value;
                } else {
                    count = native_value;
                }
            } else if( key == "pacified" ) {
                if( value.get_type() != sol::type::boolean ) {
                    throw std::invalid_argument(
                        "dialogue purchase_pet pacified must be a boolean" );
                }
                pacified = value.as<bool>();
            } else if( key == "name" ) {
                if( value.get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "dialogue purchase_pet name must be a string" );
                }
                name = value.as<std::string>();
            } else {
                throw std::invalid_argument(
                    "dialogue purchase_pet received unknown option '" + key + "'" );
            }
        }
    }

    talker *const buyer = d.actor( false );
    talker *const seller = d.actor( true );
    if( buyer == nullptr || seller == nullptr ) {
        throw std::runtime_error(
            "dialogue purchase_pet requires live alpha and beta talkers" );
    }

    // The native operation owns payment, placement, disposition, naming, and
    // feedback. In particular, a partial placement still returns its native
    // successful result, and an empty name remains untranslated and empty.
    return buyer->buy_monster( *seller, native_type, cost, count, pacified,
                               no_translation( name ) );
}

bool context::has_interlocutor_effect( const script_game_id &effect_type ) const
{
    const ::dialogue &d = require_state().dialogue_ref();
    if( effect_type.kind() != "effect" || effect_type.value().empty() ||
        effect_type.value().size() > 256 ||
        effect_type.value().find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "dialogue has_interlocutor_effect requires a bounded GameId<effect>" );
    }
    if( !effect_type.is_valid() ) {
        throw std::invalid_argument(
            "dialogue has_interlocutor_effect requires a registered effect type" );
    }
    if( !d.has_beta ) {
        return false;
    }
    const const_talker *const interlocutor = d.const_actor( true );
    if( interlocutor == nullptr ) {
        return false;
    }

    // Native TALK npc_has_effect uses dialogue.reason as an implicit body part
    // when the condition has no explicit bodypart member.
    bodypart_id body_part = bodypart_str_id::NULL_ID();
    if( !d.reason.empty() ) {
        body_part = bodypart_id( d.reason );
        if( !body_part.is_valid() ) {
            body_part = bodypart_str_id::NULL_ID();
        }
    }
    const effect active = interlocutor->get_effect(
                              efftype_id( effect_type.value() ), body_part );
    return !active.is_null() && active.get_intensity() >= -1;
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

std::string context::offer_item_to_interlocutor( const bool use_item ) const
{
    ::dialogue &d = require_action_write_state().dialogue_ref();
    if( !d.has_beta ) {
        throw std::runtime_error(
            "dialogue item offer requires a native interlocutor" );
    }
    talker *const interlocutor = d.actor( true );
    if( interlocutor == nullptr ) {
        throw std::runtime_error(
            "dialogue item offer requires a live native interlocutor" );
    }
    d.reason = interlocutor->give_item_to( use_item );
    return d.reason;
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
    ::dialogue &d = require_state().dialogue_ref();
    const_talker empty_participant;
    const const_talker &speaker = d.has_alpha ? *d.const_actor( false ) :
                                  empty_participant;
    const const_talker &interlocutor = d.has_beta ? *d.const_actor( true ) :
                                       empty_participant;
    std::string result = text;
    parse_tags( result, speaker, interlocutor, d,
                item_id.empty() ? itype_id::NULL_ID() : itype_id( item_id ) );
    return result;
}

sol::object context::speaker() const
{
    state &current = require_state();
    if( !current.speaker_snapshot.present ) {
        return sol::make_object(
                   sol::state_view( current.lua_state ),
                   sol::lua_nil );
    }
    if( !current.convert_actor ) {
        throw std::runtime_error(
            "Lua dialogue actor conversion is unavailable" );
    }
    return current.convert_actor( current.speaker_snapshot );
}

sol::object context::interlocutor() const
{
    state &current = require_state();
    if( !current.interlocutor_snapshot.present ) {
        return sol::make_object(
                   sol::state_view( current.lua_state ),
                   sol::lua_nil );
    }
    if( !current.convert_actor ) {
        throw std::runtime_error(
            "Lua dialogue actor conversion is unavailable" );
    }
    return current.convert_actor( current.interlocutor_snapshot );
}

sol::object context::get( const std::string &key ) const
{
    const ::dialogue &d = require_state().dialogue_ref();
    const diag_value *value = d.maybe_get_value( key );
    sol::state_view lua( require_state().lua_state );
    if( value == nullptr ) {
        return sol::make_object( lua, sol::lua_nil );
    }
    if( value->is_empty() ) {
        return sol::make_object( lua, script_null_value{} );
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
    ::dialogue &d = require_write_state().dialogue_ref();
    if( value.get_type() == sol::type::nil ) {
        d.remove_value( key );
    } else if( value.is<script_null_value>() ) {
        d.set_value( key, diag_value{} );
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

namespace
{

struct stored_response_callback {
    response_callback_origin origin;
    response_callback callback;
    dialogue_session_ptr session;
    std::string topic;
};

struct stored_response_action_callback {
    response_callback_origin origin;
    response_action_callback callback;
    dialogue_session_ptr session;
    std::string topic;
};

std::unordered_map<std::uint64_t, stored_response_callback> response_callbacks;
std::uint64_t next_response_callback_id = 1;
std::unordered_map<std::uint64_t, stored_response_action_callback>
response_action_callbacks;
std::uint64_t next_response_action_callback_id = 1;

} // namespace


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
        response_callback callback, dialogue_session_ptr session,
        std::string topic )
{
    if( next_response_callback_id == 0 ) {
        throw std::runtime_error( "dialogue response callback id space is exhausted" );
    }
    const std::uint64_t id = next_response_callback_id++;
    response_callbacks.emplace( id, stored_response_callback{
        origin, std::move( callback ), std::move( session ), std::move( topic )
    } );
    return id;
}

std::uint64_t register_response_action_callback( const response_callback_origin origin,
        response_action_callback callback, dialogue_session_ptr session,
        std::string topic )
{
    if( next_response_action_callback_id == 0 ) {
        throw std::runtime_error( "dialogue response action callback id space is exhausted" );
    }
    const std::uint64_t id = next_response_action_callback_id++;
    response_action_callbacks.emplace( id, stored_response_action_callback{
        origin, std::move( callback ), std::move( session ), std::move( topic )
    } );
    return id;
}

void clear_response_callbacks()
{
    response_callbacks.clear();
    response_action_callbacks.clear();
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
    for( auto iter = response_action_callbacks.begin();
         iter != response_action_callbacks.end(); ) {
        if( iter->second.origin == origin ) {
            iter = response_action_callbacks.erase( iter );
        } else {
            ++iter;
        }
    }
}

talk_topic apply_response_callback( ::dialogue &d, const std::uint64_t response_id,
                                    const talk_topic &fallback, const bool trial_success )
{
    const auto found = response_callbacks.find( response_id );
    if( found == response_callbacks.end() ) {
        return fallback;
    }
    stored_response_callback stored = std::move( found->second );
    response_callbacks.erase( found );
    if( stored.session && !stored.session->active_for( stored.topic, &d ) ) {
        return fallback;
    }
    return stored.callback( d, fallback, trial_success );
}

void apply_response_action_callback( ::dialogue &d, const std::uint64_t response_id,
                                     const bool trial_success )
{
    const auto found = response_action_callbacks.find( response_id );
    if( found == response_action_callbacks.end() ) {
        return;
    }
    stored_response_action_callback stored = std::move( found->second );
    response_action_callbacks.erase( found );
    if( stored.session && !stored.session->active_for( stored.topic, &d ) ) {
        return;
    }
    stored.callback( d, trial_success );
}

translation deferred_translation_from_descriptor(
    const sol::table &descriptor, const std::string_view field_name,
    const std::string &text, const std::string_view api_name )
{
    const std::string field( field_name );
    const sol::object raw_translation = descriptor.raw_get<sol::object>( field );
    if( !raw_translation.valid() || raw_translation.get_type() == sol::type::nil ) {
        return no_translation( text );
    }
    const std::string field_label = std::string( api_name ) + " field '" + field + "'";
    if( raw_translation.get_type() != sol::type::table ) {
        throw std::invalid_argument( field_label + " must be a table" );
    }

    const sol::table translation_options = raw_translation.as<sol::table>();
    for( const auto &entry : translation_options ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument( field_label + " keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "context" ) {
            throw std::invalid_argument( field_label + " has unknown field '" + key + "'" );
        }
    }

    const sol::object raw_context = translation_options.raw_get<sol::object>( "context" );
    if( !raw_context.valid() || raw_context.get_type() == sol::type::nil ) {
        return to_translation( text );
    }
    if( raw_context.get_type() != sol::type::string ) {
        throw std::invalid_argument( field_label + ".context must be a string" );
    }
    const std::string context = raw_context.as<std::string>();
    if( context.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument( field_label + ".context must not contain NUL" );
    }
    return to_translation( context, text );
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
            key != "text_translation" && options.additional_fields.count( key ) == 0 ) {
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
    response.truetext = deferred_translation_from_descriptor(
                            descriptor, "text_translation", text, options.api_name );
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

} // namespace cata::lua_platform::dialogue
