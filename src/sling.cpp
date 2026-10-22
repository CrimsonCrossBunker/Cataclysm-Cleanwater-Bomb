#include "sling.h"

#include <algorithm>
#include <cmath>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "ballistics.h"
#include "character.h"
#include "creature_tracker.h"
#include "damage.h"
#include "dispersion.h"
#include "event.h"
#include "event_bus.h"
#include "flag.h"
#include "game.h"
#include "game_constants.h"
#include "game_inventory.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "itype.h"
#include "iuse.h"
#include "iuse_actor.h"
#include "lua_platform_hooks.h"
#include "map.h"
#include "messages.h"
#include "monster.h"
#include "mtype.h"
#include "pocket_type.h"
#include "projectile.h"
#include "ranged.h"
#include "translations.h"
#include "type_id.h"
#include "coordinates.h"
#include "creature.h"
#include "enums.h"
#include "item_transformation.h"
#include "point.h"
#include "ret_val.h"
#include "units.h"
#include "weakpoint.h"

static const ammo_effect_str_id ammo_effect_ACT_ON_RANGED_HIT( "ACT_ON_RANGED_HIT" );
static const ammo_effect_str_id ammo_effect_HEAVY_HIT( "HEAVY_HIT" );
static const ammo_effect_str_id ammo_effect_NO_EMBED( "NO_EMBED" );
static const ammo_effect_str_id ammo_effect_NO_ITEM_DAMAGE( "NO_ITEM_DAMAGE" );
static const ammo_effect_str_id ammo_effect_NO_OVERSHOOT( "NO_OVERSHOOT" );
static const ammo_effect_str_id ammo_effect_STOP_ON_CONTACT( "STOP_ON_CONTACT" );
static const ammo_effect_str_id ammo_effect_WIDE( "WIDE" );
static const damage_type_id damage_bash( "bash" );
static const flag_id json_flag_SLING_AMMO( "SLING_AMMO" );
static const flag_id json_flag_SLING_LAUNCHER( "SLING_LAUNCHER" );
static const json_character_flag json_flag_CANNOT_MOVE( "CANNOT_MOVE" );
static const skill_id skill_throw( "throw" );

namespace
{
const iuse_transform *sling_activation( const item &ammo )
{
    const use_function *use = ammo.type->get_use( "transform" );
    return use ? dynamic_cast<const iuse_transform *>( use->get_actor_ptr() ) : nullptr;
}

item single_round( const item &ammo )
{
    item result = ammo;
    if( result.count_by_charges() ) {
        result.charges = 1;
    }
    return result;
}
} // namespace

bool is_sling_launcher( const item &weapon )
{
    return weapon.has_flag( json_flag_SLING_LAUNCHER );
}

bool is_sling_ammunition( const item &ammo )
{
    const iuse_transform *activation = sling_activation( ammo );
    return ammo.has_flag( json_flag_SLING_AMMO ) && !ammo.active && ammo.count() > 0 &&
           activation && !activation->set_timer && !activation->transform.target.is_empty() &&
           activation->transform.target_group.is_empty() && activation->transform.container.is_empty();
}

ret_val<void> can_launch_sling( const Character &who, const item_location &ammo )
{
    const item_location weapon = who.get_wielded_item();
    if( !weapon || !is_sling_launcher( *weapon ) ) {
        return ret_val<void>::make_failure( _( "You need to wield a staff sling." ) );
    }
    if( !ammo || !ammo.held_by( who ) || !is_sling_ammunition( *ammo ) ) {
        return ret_val<void>::make_failure( _( "You need sling-ready ammunition in your inventory." ) );
    }
    for( item_location parent = ammo; parent.has_parent(); parent = parent.parent_item() ) {
        if( !parent.parent_pocket()->is_type( pocket_type::CONTAINER ) ||
            parent.parent_pocket()->sealed() ) {
            return ret_val<void>::make_failure(
                       _( "Take the ammunition out of its sealed container or magazine first." ) );
        }
    }
    if( who.throw_range( single_round( *ammo ) ) <= 0 ) {
        return ret_val<void>::make_failure( _( "That is too heavy to launch." ) );
    }
    iuse_transform activation = *sling_activation( *ammo );
    // The sling holds the round during activation.  Keep the ordinary hand-use
    // action and all its other requirements unchanged.
    activation.need_wielding = false;
    if( activation.need_fire && ( who.is_underwater() || !who.has_fire( activation.need_fire ) ) ) {
        return ret_val<void>::make_failure( _( "You need a usable source of fire to light this fuse." ) );
    }
    const item round = single_round( *ammo );
    return activation.can_use( who, round, &get_map(), who.pos_bub() );
}

int sling_launch_moves( const Character &who, const item_location &ammo )
{
    const iuse_transform *activation = sling_activation( *ammo );
    return 200 + throw_cost( who, single_round( *ammo ) ) + ammo.obtain_cost( who, 1 ) +
           ( activation ? activation->moves : 0 );
}

std::optional<dealt_projectile_attack> launch_sling( avatar &who, item_location ammo,
        const std::optional<tripoint_bub_ms> &target )
{
    if( !target ) {
        return std::nullopt;
    }
    const ret_val<void> ready = can_launch_sling( who, ammo );
    if( !ready.success() ) {
        who.add_msg_if_player( m_info, "%s", ready.c_str() );
        return std::nullopt;
    }
    item round = single_round( *ammo );
    if( *target == who.pos_bub() || rl_dist( who.pos_bub(), *target ) > who.throw_range( round ) ) {
        return std::nullopt;
    }

    const itype_id launcher_type = who.get_wielded_item()->typeId();
    const tripoint_bub_ms source = who.pos_bub();
    const int moves = sling_launch_moves( who, ammo );
    const int stamina = who.get_standard_stamina_cost( &round );
    const int dispersion = who.throwing_dispersion( round,
                           get_creature_tracker().creature_at( *target ), false );
    projectile proj = who.thrown_item_projectile( round );
    proj.impact = damage_instance( damage_bash, who.thrown_item_total_damage_raw( round ) );
    proj.range = rl_dist( who.pos_bub(), *target );
    proj.critical_multiplier += 0.15f * who.get_skill_level( skill_throw );
    if( who.get_dex() > 8 && who.get_per() > 8 ) {
        proj.critical_multiplier += 0.06f * ( std::min( who.get_dex(), who.get_per() ) - 8 );
    }
    proj.proj_effects = { ammo_effect_HEAVY_HIT, ammo_effect_NO_EMBED,
                          ammo_effect_NO_ITEM_DAMAGE, ammo_effect_NO_OVERSHOOT, ammo_effect_STOP_ON_CONTACT
                        };

    if( round.volume() > 500_ml ) {
        proj.proj_effects.insert( ammo_effect_WIDE );
    }

    iuse_transform activation = *sling_activation( round );
    activation.need_wielding = false;
    const itype_id inactive_type = round.typeId();
    // Only a confirmed, valid shot can consume ignition resources or start the fuse.
    // Do not copy AMMO explosion effects: the dropped live item owns detonation.
    if( !activation.use( &who, round, &get_map(), who.pos_bub() ) ||
        round.typeId() == inactive_type || !round.active ) {
        return std::nullopt;
    }
    if( ammo->count_by_charges() && ammo->charges > 1 ) {
        ammo->mod_charges( -1 );
        ammo.on_contents_changed();
    } else {
        ammo.remove_item();
    }
    who.mod_moves( -( moves - activation.moves ) );
    who.mod_stamina( static_cast<int>( std::round( stamina * who.throw_stamina_multiplier() ) ) );
    if( round.has_flag( flag_ACT_ON_RANGED_HIT ) ) {
        proj.proj_effects.insert( ammo_effect_ACT_ON_RANGED_HIT );
    }
    proj.set_drop( round );

    weakpoint_attack wp;
    wp.weapon = &round;
    wp.is_thrown = true;
    dealt_projectile_attack result;
    projectile_attack( result, proj, who.pos_bub(), *target, dispersion_sources( dispersion ),
                       &who, nullptr, wp );
    for( const auto &hit : result.targets_hit ) {
        if( hit.second.first == 0 ) {
            continue;
        }
        if( monster *mon = hit.first->as_monster() ) {
            const cata::event event = cata::event::make<event_type::character_ranged_attacks_monster>(
                                          who.getID(), launcher_type, inactive_type, true, mon->type->id );
            get_event_bus().send_with_talker( &who, mon, event );
        } else if( Character *person = hit.first->as_character() ) {
            const cata::event event = cata::event::make<event_type::character_ranged_attacks_character>(
                                          who.getID(), launcher_type, inactive_type, true, person->getID(), person->get_name() );
            get_event_bus().send_with_talker( &who, person, event );
        }
    }
    Creature *hit = result.last_hit_critter;
    if( hit && !hit->has_flag( mon_flag_IMMOBILE ) && !hit->has_flag( json_flag_CANNOT_MOVE ) ) {
        const float range_factor = std::min<float>( proj.range, who.get_skill_level( skill_throw ) + 3 );
        const float xp = range_factor * 5.0f * std::sqrt( proj.impact.total_damage() / 5.0f );
        who.practice( skill_throw, xp / ( 1.0f + result.missed_by ), MAX_SKILL );
        if( result.headshot ) {
            get_event_bus().send<event_type::character_gets_headshot>( who.getID() );
        }
    } else {
        who.practice( skill_throw, 5, 2 );
    }
    who.last_target_pos = std::nullopt;
    who.recoil = MAX_RECOIL;
    cata::lua_platform::dispatch_native_hook( "on_throw", {
        { "character", static_cast<const Character *>( &who ) },
        { "item", static_cast<const item *>( &round ) },
        {
            "target", cata::lua_platform::native_callback_point {
                "bub_ms", tripoint_rel_ms( target->x(), target->y(), target->z() ) }
        },
        {
            "origin", cata::lua_platform::native_callback_point {
                "bub_ms", tripoint_rel_ms( source.x(), source.y(), source.z() ) }
        }
    } );
    return result;
}

void aim_sling( avatar &who )
{
    std::vector<item_location> candidates;
    for( const item_location &loc : who.all_items_loc() ) {
        if( is_sling_ammunition( *loc ) ) {
            candidates.push_back( loc );
        }
    }
    if( candidates.empty() ) {
        add_msg( m_info, _( "You need sling-ready ammunition in your inventory." ) );
        return;
    }
    const auto ready_ammo = std::find_if( candidates.begin(), candidates.end(),
    [&]( const item_location & loc ) {
        return can_launch_sling( who, loc ).success();
    } );
    item_location ammo = ready_ammo == candidates.end() ? candidates.front() : *ready_ammo;
    const bool multiple_types = std::any_of( candidates.begin(), candidates.end(),
    [&]( const item_location & loc ) {
        return loc->typeId() != ammo->typeId();
    } );
    if( multiple_types ) {
        ammo = game_menus::inv::titled_filter_menu( is_sling_ammunition, who,
                _( "Select sling ammunition" ) );
    }
    if( !ammo ) {
        return;
    }
    const ret_val<void> ready = can_launch_sling( who, ammo );
    if( !ready.success() ) {
        add_msg( m_info, "%s", ready.c_str() );
        return;
    }
    item round = single_round( *ammo );
    g->temp_exit_fullscreen();
    const target_handler::trajectory trajectory = target_handler::mode_sling( who, round,
            sling_launch_moves( who, ammo ) );
    launch_sling( who, ammo, trajectory.empty() ? std::nullopt :
                  std::make_optional( trajectory.back() ) );
    g->reenter_fullscreen();
}
