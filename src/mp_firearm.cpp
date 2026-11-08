#include "mp_firearm.h"

#include <algorithm>
#include <cmath>
#include <vector>

#include "calendar.h"
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
#include "safe_reference.h"
#include "sling.h"
#include "translations.h"

namespace cata_mp
{
void finish_firearm_activity( Character &who, firearm_state &state, bool canceled )
{
    if( state.weapon != 0 ) {
        state = {};
        get_event_bus().send<event_type::character_finished_activity>(
            who.getID(), activity_id( "ACT_AIM" ), canceled );
    }
}

bool supports_firearm_intents( const item &weapon )
{
    const gun_mode mode = weapon.gun_current_mode();
    return weapon.is_gun() && !is_sling_launcher( weapon ) && mode && !mode.melee() &&
           mode->gun_skill() != skill_id( "archery" ) &&
           !mode->has_flag( flag_RELOAD_AND_SHOOT );
}

firearm_outcome execute_firearm_intent( Character &who, map &here,
                                        firearm_state &state, const firearm_intent &intent )
{
    const safe_reference<Creature> actor = who.get_safe_reference();
    item_location weapon = who.get_wielded_item();
    if( who.is_dead_state() || who.get_moves() <= 0 || who.pos_abs() != intent.origin ||
        !weapon || weapon->uid().get_value() != intent.weapon ||
        !supports_firearm_intents( *weapon ) ||
        who.has_flag( json_character_flag( "CANNOT_ATTACK" ) ) ||
        who.has_flag( json_character_flag( "TEMPORARY_SHAPESHIFT_NO_HANDS" ) ) ||
        ( weapon->is_firearm() && who.has_flag( json_character_flag( "HANDS_CANNOT_USE_FIREARMS" ) ) ) ) {
        return firearm_outcome::rejected;
    }
    const auto modes = weapon->gun_all_modes();
    const auto selected = modes.find( intent.mode );
    if( selected == modes.end() || selected->second.melee() ||
        selected->second->has_flag( flag_RELOAD_AND_SHOOT ) ) {
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
        ( !prepare && state.weapon != intent.weapon ) ) {
        return firearm_outcome::rejected;
    }
    if( !prepare && ( !here.inbounds( intent.target ) || intent.origin == intent.target ||
                      std::round( rl_dist_exact( intent.origin, intent.target ) ) >
                      selected->second->gun_range( &who ) ) ) {
        return firearm_outcome::rejected;
    }
    weapon->gun_set_mode( intent.mode );
    gun_mode gun = weapon->gun_current_mode();
    if( prepare ) {
        finish_firearm_activity( who, state, true );
        if( !actor ) {
            return firearm_outcome::rejected;
        }
        weapon = who.get_wielded_item();
        if( !weapon || weapon->uid().get_value() != intent.weapon ||
            !supports_firearm_intents( *weapon ) ) {
            return firearm_outcome::rejected;
        }
        // The fire key checks pacification before activity startup, which then
        // handles a jam. Keep those native steps on the simulation owner.
        if( !who.try_break_relax_gas( _( "Your willpower asserts itself, and so do you!" ),
                                      _( "You're too pacified to strike anything…" ) ) ||
            !prepare_gun_to_fire( who, *weapon ) ) {
            return firearm_outcome::rejected;
        }
        state.weapon = intent.weapon;
        get_event_bus().send<event_type::character_starts_activity>(
            who.getID(), activity_id( "ACT_AIM" ), false );
        if( !actor || who.is_dead_state() ) {
            state = {};
            return firearm_outcome::rejected;
        }
        weapon = who.get_wielded_item();
        if( !weapon || weapon->uid().get_value() != intent.weapon ||
            !supports_firearm_intents( *weapon ) ) {
            finish_firearm_activity( who, state, true );
            return firearm_outcome::rejected;
        }
        gun = weapon->gun_current_mode();
        if( who.get_moves() <= 0 ) {
            return firearm_outcome::aiming;
        }
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
        return firearm_outcome::aiming;
    }
    if( threshold && !aim_gun_until_threshold( who, *weapon, target, intent.action ) ) {
        return firearm_outcome::aiming;
    }
    mark_ranged_target( who, true );
    if( !actor ) {
        state = {};
        return firearm_outcome::rejected;
    }
    finish_firearm_activity( who, state, false );
    if( !actor || who.is_dead_state() ) {
        return firearm_outcome::rejected;
    }
    weapon = who.get_wielded_item();
    if( !weapon || weapon->uid().get_value() != intent.weapon ||
        !supports_firearm_intents( *weapon ) ) {
        return firearm_outcome::rejected;
    }
    gun = weapon->gun_current_mode();
    who.fire_gun( here, target, gun.qty, *gun, item_location() );
    return firearm_outcome::finished;
}
} // namespace cata_mp
