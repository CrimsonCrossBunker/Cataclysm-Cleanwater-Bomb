#include "mp_firearm.h"

#include <algorithm>
#include <cmath>
#include <vector>

#include "bionics.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character_action_guard.h"
#include "character.h"
#include "creature_tracker.h"
#include "event.h"
#include "event_bus.h"
#include "flag.h"
#include "game.h"
#include "game_constants.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "map.h"
#include "ranged.h"
#include "ranged_actions.h"
#include "player_activity.h"
#include "sling.h"
#include "translations.h"

namespace cata_mp
{
namespace
{
void reset_firearm_state( firearm_state &state )
{
    const int64_t request = state.last_request;
    state = {};
    state.last_request = request;
}

item_location firearm_source( Character &who, firearm_state &state, const firearm_intent &intent )
{
    if( !intent.bionic ) {
        return who.get_wielded_item();
    }
    const item *installed = bionic_firearm_source( who, intent.bionic );
    if( !installed || installed->uid().get_value() != intent.weapon ) {
        return item_location();
    }
    if( state.bionic == intent.bionic && state.bionic_weapon &&
        state.bionic_weapon_source == intent.weapon ) {
        return item_location( who, state.bionic_weapon.get() );
    }
    return item_location();
}
} // namespace

const item *bionic_firearm_source( const Character &who, unsigned int uid )
{
    const auto bio = who.find_bionic_by_uid( uid );
    return !who.is_dead_state() && bio && ( *bio )->incapacitated_time == 0_turns &&
           ( *bio )->info().has_flag( json_character_flag( "BIONIC_GUN" ) ) && ( *bio )->has_weapon() ?
           &( *bio )->weapon_view() : nullptr;
}

void finish_firearm_activity( Character &who, firearm_state &state, bool canceled,
                              bool unload_ras )
{
    const int64_t weapon_id = state.weapon;
    const bool started = state.activity_started;
    const auto virtual_weapon = state.bionic_weapon;
    const unsigned int bionic = state.bionic;
    const int64_t bionic_weapon_source = state.bionic_weapon_source;
    reset_firearm_state( state );
    if( !canceled && virtual_weapon ) {
        state.bionic = bionic;
        state.bionic_weapon = virtual_weapon;
        state.bionic_weapon_source = bionic_weapon_source;
    }
    const character_action_guard actor( who );
    item_location weapon = virtual_weapon ? item_location( who, virtual_weapon.get() ) :
                           who.get_wielded_item();
    if( actor && unload_ras && weapon &&
        ( virtual_weapon ? bionic_weapon_source : weapon->uid().get_value() ) == weapon_id ) {
        gun_mode mode = weapon->gun_current_mode();
        if( mode ) {
            unload_ready_ranged_ammo( who, *mode );
        }
    }
    if( actor && started ) {
        get_event_bus().send<event_type::character_finished_activity>(
            who.getID(), activity_id( "ACT_AIM" ), canceled );
    }
}

bool supports_firearm_intents( const item &weapon )
{
    const gun_mode mode = weapon.gun_current_mode();
    return is_sling_launcher( weapon ) || ( weapon.is_gun() && mode && !mode.melee() );
}

firearm_outcome execute_firearm_intent( Character &who, map &here,
                                        firearm_state &state, const firearm_intent &intent )
{
    if( intent.request > 0 ) {
        if( intent.request <= state.last_request ) {
            return firearm_outcome::rejected;
        }
        state.last_request = intent.request;
    }
    const character_action_guard actor( who );
    std::optional<item> initial_weapon;
    item_location weapon = firearm_source( who, state, intent );
    if( intent.bionic && intent.action == "prepare" && !weapon ) {
        if( const item *installed = bionic_firearm_source( who, intent.bionic );
            installed && installed->uid().get_value() == intent.weapon ) {
            initial_weapon = *installed;
            weapon = item_location( who, &*initial_weapon );
        }
    }
    if( !actor || who.activity || who.is_dead_state() || who.get_moves() <= 0 ||
        who.pos_abs() != intent.origin ||
        !weapon || ( !intent.bionic && weapon->uid().get_value() != intent.weapon ) ||
        !supports_firearm_intents( *weapon ) ||
        who.has_flag( json_character_flag( "CANNOT_ATTACK" ) ) ||
        who.has_flag( json_character_flag( "TEMPORARY_SHAPESHIFT_NO_HANDS" ) ) ||
        ( weapon->is_firearm() && who.has_flag( json_character_flag( "HANDS_CANNOT_USE_FIREARMS" ) ) ) ) {
        return firearm_outcome::rejected;
    }
    if( is_sling_launcher( *weapon ) ) {
        if( intent.action != "prepare" || who.has_trait( trait_id( "BRAWLER" ) ) ) {
            return firearm_outcome::rejected;
        }
        finish_firearm_activity( who, state, true );
        if( !actor || !who.try_break_relax_gas( _( "Your willpower asserts itself, and so do you!" ),
                                                _( "You're too pacified to strike anything…" ) ) ) {
            return firearm_outcome::rejected;
        }
        state.weapon = intent.weapon;
        return firearm_outcome::aiming;
    }
    const auto modes = weapon->gun_all_modes();
    const auto selected = modes.find( intent.mode );
    if( selected == modes.end() || selected->second.melee() ) {
        return firearm_outcome::rejected;
    }
    const bool prepare = intent.action == "prepare";
    const bool aim = intent.action == "AIM";
    const bool drop = intent.action == "DROP_AIM";
    const bool fire = intent.action == "FIRE";
    const auto aim_modes = who.get_aim_types( *weapon );
    const bool threshold = std::any_of( aim_modes.begin(), aim_modes.end(),
    [&]( const aim_type & mode ) {
        return mode.has_threshold && mode.action == intent.action;
    } );
    if( !( prepare || aim || drop || fire || threshold ) ||
        ( !prepare && ( state.weapon != intent.weapon || state.bionic != intent.bionic ) ) ) {
        return firearm_outcome::rejected;
    }
    item_location ammo;
    const bool reload_and_shoot = selected->second->has_flag( flag_RELOAD_AND_SHOOT );
    const bool needs_ammo = reload_and_shoot && !selected->second->ammo_remaining();
    if( !prepare && needs_ammo ) {
        if( !intent.ammo ) {
            return firearm_outcome::rejected;
        }
        ammo = resolve_item_source( who, here, *intent.ammo );
        item_location used_gun = selected->second.target == &*weapon ? weapon :
                                 item_location( weapon, selected->second.target );
        std::vector<item::reload_option> options;
        who.list_ammo( used_gun, options, false );
        if( !ammo || std::none_of( options.begin(), options.end(),
        [&]( const item::reload_option & option ) {
        return option.ammo == ammo;
    } ) ) {
            return firearm_outcome::rejected;
        }
    }
    int range = selected->second->gun_range( &who );
    if( ammo ) {
        item loaded = *selected->second;
        loaded.ammo_set( ammo->typeId(), 1 );
        range = loaded.gun_range( &who );
    }
    if( !prepare && ( !here.inbounds( intent.target ) || intent.origin == intent.target ||
                      std::round( rl_dist_exact( intent.origin, intent.target ) ) > range ) ) {
        return firearm_outcome::rejected;
    }
    if( prepare ) {
        const bool continuing = intent.bionic && state.weapon == 0 &&
                                state.bionic == intent.bionic && state.bionic_weapon;
        if( !continuing ) {
            finish_firearm_activity( who, state, true );
            if( !actor || who.activity ) {
                return firearm_outcome::rejected;
            }
            if( intent.bionic ) {
                const auto bio = who.find_bionic_by_uid( intent.bionic );
                const item *installed = bionic_firearm_source( who, intent.bionic );
                if( !bio || !installed || installed->uid().get_value() != intent.weapon ) {
                    return firearm_outcome::rejected;
                }
                const auto previous = who.activity.execution();
                who.activity.set_execution( activity_execution::authoritative );
                const on_out_of_scope restore_role( [&]() {
                    if( actor ) {
                        who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
                    }
                } );
                if( !who.activate_bionic( **bio ) || !actor || who.activity ) {
                    return firearm_outcome::rejected;
                }
                installed = bionic_firearm_source( who, intent.bionic );
                if( !installed || installed->uid().get_value() != intent.weapon ) {
                    return firearm_outcome::rejected;
                }
                state.bionic = intent.bionic;
                state.bionic_weapon = std::make_shared<item>( *installed );
                state.bionic_weapon_source = intent.weapon;
            }
        }
        weapon = firearm_source( who, state, intent );
        if( !weapon || ( !intent.bionic && weapon->uid().get_value() != intent.weapon ) ||
            !supports_firearm_intents( *weapon ) ) {
            finish_firearm_activity( who, state, true );
            return firearm_outcome::rejected;
        }
        weapon->gun_set_mode( intent.mode );
        // Native CBM activation enters aiming directly; the wielded fire key
        // additionally checks pacification before startup.
        if( ( !intent.bionic && !who.try_break_relax_gas(
                  _( "Your willpower asserts itself, and so do you!" ),
                  _( "You're too pacified to strike anything…" ) ) ) ||
            !prepare_gun_to_fire( who, *weapon ) ) {
            finish_firearm_activity( who, state, true );
            return firearm_outcome::rejected;
        }
        if( !actor || who.activity ) {
            reset_firearm_state( state );
            return firearm_outcome::rejected;
        }
        state.weapon = intent.weapon;
        state.activity_started = true;
        get_event_bus().send<event_type::character_starts_activity>(
            who.getID(), activity_id( "ACT_AIM" ), false );
        if( !actor || who.activity ) {
            reset_firearm_state( state );
            return firearm_outcome::rejected;
        }
        weapon = firearm_source( who, state, intent );
        if( !weapon || ( !intent.bionic && weapon->uid().get_value() != intent.weapon ) ||
            !supports_firearm_intents( *weapon ) ) {
            finish_firearm_activity( who, state, true );
            return firearm_outcome::rejected;
        }
    }
    if( weapon->gun_all_modes().count( intent.mode ) == 0 ) {
        finish_firearm_activity( who, state, true );
        return firearm_outcome::rejected;
    }
    weapon->gun_set_mode( intent.mode );
    gun_mode gun = weapon->gun_current_mode();
    if( !gun || gun.melee() ) {
        finish_firearm_activity( who, state, true );
        return firearm_outcome::rejected;
    }
    if( prepare && who.get_moves() <= 0 ) {
        return firearm_outcome::aiming;
    }
    std::vector<std::string> messages;
    if( !gunmode_checks_common( who, here, messages, gun ) ||
        !gunmode_checks_weapon( who, here, messages, gun ) ) {
        finish_firearm_activity( who, state, true );
        return firearm_outcome::rejected;
    }
    const int64_t turn = to_turn<int64_t>( calendar::turn );
    if( state.checked_turn != turn ) {
        if( !who.try_break_relax_gas( _( "Your eyes steel, and you raise your weapon!" ),
                                      _( "You can't fire your weapon, it's too heavy…" ) ) ) {
            finish_firearm_activity( who, state, true );
            return firearm_outcome::rejected;
        }
        if( gun->has_flag( flag_id( "ALWAYS_AIMED" ) ) ) {
            who.recoil = 0;
        }
        state.checked_turn = turn;
    }
    if( prepare ) {
        return firearm_outcome::aiming;
    }
    if( drop ) {
        who.recoil = MAX_RECOIL;
        return firearm_outcome::aiming;
    }
    const tripoint_bub_ms target = here.get_bub( intent.target );
    if( aim || threshold ) {
        const auto previous = who.last_target_pos ?
                              std::optional<tripoint_bub_ms>( here.get_bub( *who.last_target_pos ) ) : std::nullopt;
        who.recoil = aim_turning_recoil( who, who.pos_bub(), previous, target );
    }
    who.last_target_pos = intent.target;
    Creature *victim = get_creature_tracker().creature_at( target, true );
    who.last_target = victim ? g->shared_from( *victim ) : shared_ptr_fast<Creature>();
    if( aim ) {
        aim_gun_for_moves( who, *weapon, target, 10 );
        if( who.get_moves() > 0 && ammo ) {
            ready_ranged_ammo( who, *gun, ammo );
        }
        return firearm_outcome::aiming;
    }
    if( threshold && !aim_gun_until_threshold( who, *weapon, target, intent.action ) ) {
        return firearm_outcome::aiming;
    }
    mark_ranged_target( who, true );
    if( !actor ) {
        reset_firearm_state( state );
        return firearm_outcome::rejected;
    }
    const auto firing_weapon = state.bionic_weapon;
    finish_firearm_activity( who, state, false );
    if( !actor || who.is_dead_state() ) {
        return firearm_outcome::rejected;
    }
    weapon = firearm_source( who, state, intent );
    if( !weapon || ( !intent.bionic && weapon->uid().get_value() != intent.weapon ) ||
        !supports_firearm_intents( *weapon ) ) {
        return firearm_outcome::rejected;
    }
    gun = weapon->gun_current_mode();
    if( gun->has_flag( flag_RELOAD_AND_SHOOT ) && !gun->ammo_remaining() && !ammo ) {
        return firearm_outcome::rejected;
    }
    who.fire_gun( here, target, gun.qty, *gun, ammo );
    return firearm_outcome::finished;
}
} // namespace cata_mp
