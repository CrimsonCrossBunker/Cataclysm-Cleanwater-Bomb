#include <coordinates.h>
#include <input_enums.h>
#include <item_disposition.h>
#include <item_uid.h>
#include <memory_fast.h>
#include <monster_uid.h>
#include <mp_peek.h>
#include <player_activity.h>
#include <safe_reference.h>
#include <stdint.h>
#include <translation.h>
#include <algorithm>
#include <climits>
#include <cstdlib>
#include <functional>
#include <map>
#include <memory>
#include <ostream>
#include <set>
#include <string>
#include <unordered_set>
#include <utility>
#include <vector>

#include "action.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "avatar_action.h"
#include "body_part_set.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "color.h"
#include "creature.h"
#include "creature_tracker.h"
#include "debug.h"
#include "distraction_manager.h"
#include "effect.h"
#include "enums.h"
#include "flag.h"
#include "game.h"
#include "game_constants.h"
#include "game_inventory.h"
#include "gun_mode.h"
#include "gunmod_ui.h"
#include "input.h"
#include "input_context.h"
#include "inventory.h"
#include "item.h"
#include "item_consumption.h"
#include "item_healing.h"
#include "item_location.h"
#include "item_pocket.h"
#include "itype.h"
#include "line.h"
#include "lua_platform_runtime.h"
#include "magic_enchantment.h"
#include "map.h"
#include "map_iterator.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "martialarts.h"
#include "math_defines.h"
#include "messages.h"
#include "monster.h"
#include "mounted_charge.h"
#include "move_mode.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "mp_melee.h"
#include "mp_throw.h"
#include "mp_unload.h"
#include "mp_world_session.h"
#include "mtype.h"
#include "npc.h"
#include "options.h"
#include "output.h"
#include "pimpl.h"
#include "point.h"
#include "popup.h"
#include "projectile.h"
#include "ranged.h"
#include "ret_val.h"
#include "rng.h"
#include "sling.h"
#include "sounds.h"
#include "string_formatter.h"
#include "tool_activity_target.h"
#include "translations.h"
#include "type_id.h"
#include "ui_manager.h"
#include "uilist.h"
#include "uistate.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vehicle_turret_control.h"
#include "vehicle_uid.h"
#include "vpart_position.h"
#include "walking.h"

static const efftype_id effect_amigara( "amigara" );
static const efftype_id effect_berserk( "berserk" );
static const efftype_id effect_bile_irritant( "bile_irritant" );
static const efftype_id effect_glowing( "glowing" );
static const efftype_id effect_harnessed( "harnessed" );
static const efftype_id effect_hunger_engorged( "hunger_engorged" );
static const efftype_id effect_incorporeal( "incorporeal" );
static const efftype_id effect_onfire( "onfire" );
static const efftype_id effect_pet( "pet" );
static const efftype_id effect_psi_stunned( "psi_stunned" );
static const efftype_id effect_quadruped_full( "quadruped_full" );
static const efftype_id effect_ridden( "ridden" );
static const efftype_id effect_stunned( "stunned" );
static const efftype_id effect_winded( "winded" );

static const furn_str_id furn_f_safe_c( "f_safe_c" );

static const itype_id itype_grass( "grass" );
static const itype_id itype_small_plant( "small_plant" );
static const itype_id itype_swim_fins( "swim_fins" );
static const itype_id itype_underbrush( "underbrush" );

static const json_character_flag json_flag_CANNOT_ATTACK( "CANNOT_ATTACK" );
static const json_character_flag json_flag_CANNOT_MOVE( "CANNOT_MOVE" );
static const json_character_flag json_flag_FLOTATION( "FLOTATION" );
static const json_character_flag json_flag_ITEM_WATERPROOFING( "ITEM_WATERPROOFING" );
static const json_character_flag json_flag_WATERWALKING( "WATERWALKING" );

static const move_mode_id move_mode_prone( "prone" );

static const skill_id skill_swimming( "swimming" );

static const ter_str_id ter_t_door_bar_locked( "t_door_bar_locked" );
static const ter_str_id ter_t_door_locked( "t_door_locked" );
static const ter_str_id ter_t_door_locked_alarm( "t_door_locked_alarm" );
static const ter_str_id ter_t_door_locked_interior( "t_door_locked_interior" );
static const ter_str_id ter_t_door_locked_peep( "t_door_locked_peep" );
static const ter_str_id ter_t_fault( "t_fault" );
static const ter_str_id ter_t_grass( "t_grass" );
static const ter_str_id ter_t_grass_alien( "t_grass_alien" );
static const ter_str_id ter_t_grass_dead( "t_grass_dead" );
static const ter_str_id ter_t_grass_golf( "t_grass_golf" );
static const ter_str_id ter_t_grass_white( "t_grass_white" );

static const trait_id trait_GRAZER( "GRAZER" );
static const trait_id trait_RUMINANT( "RUMINANT" );
static const trait_id trait_SHELL2( "SHELL2" );
static const trait_id trait_SHELL3( "SHELL3" );

#define dbg(x) DebugLog((x),D_SDL) << __FILE__ << ":" << __LINE__ << ": "

static bool check_water_affect_items( avatar &you )
{
    if( you.has_effect( effect_stunned ) || you.has_effect( effect_psi_stunned ) ) {
        return true;
    }

    std::vector<item_location> dissolved;
    std::vector<item_location> destroyed;
    std::vector<item_location> wet;

    for( item_location &loc : you.all_items_loc() ) {
        if( you.has_flag( json_flag_ITEM_WATERPROOFING ) ) {
            break;
        } else if( loc->has_flag( flag_WATER_DISSOLVE ) && !loc.protected_from_liquids() ) {
            dissolved.emplace_back( loc );
        } else if( loc->has_flag( flag_WATER_BREAK ) && !loc->is_broken()
                   && !loc.protected_from_liquids() ) {
            destroyed.emplace_back( loc );
        } else if( loc->has_flag( flag_WATER_BREAK_ACTIVE ) && !loc->is_broken()
                   && !loc.protected_from_liquids() ) {
            wet.emplace_back( loc );
        }
    }

    if( dissolved.empty() && destroyed.empty() && wet.empty() ) {
        return query_yn( _( "Dive into the water?" ) );
    }

    uilist menu;
    menu.title = _( "Diving will destroy the following items.  Proceed?" );
    menu.text = _( "These items are not inside a waterproof container." );

    menu.addentry( 0, true, 'N', _( "No" ) );
    menu.addentry( 1, true, 'Y', _( "Yes" ) );

    auto add_header = [&menu]( const std::string & str ) {
        menu.addentry( -1, false, -1, "" );
        uilist_entry header( -1, false, -1, str, c_yellow, c_yellow );
        header.force_color = true;
        menu.entries.push_back( header );
    };

    if( !dissolved.empty() ) {
        add_header( _( "Will be dissolved:" ) );
        for( item_location &it : dissolved ) {
            menu.addentry( -1, false, -1, it->display_name() );
        }
    }

    if( !destroyed.empty() ) {
        add_header( _( "Will be destroyed:" ) );
        for( item_location &it : destroyed ) {
            menu.addentry( -1, false, -1, it->display_name() );
        }
    }

    if( !wet.empty() ) {
        add_header( _( "Will get wet:" ) );
        for( item_location &it : wet ) {
            menu.addentry( -1, false, -1, it->display_name() );
        }
    }

    menu.query();
    if( menu.ret != 1 ) {
        you.add_msg_if_player( _( "You back away from the water." ) );
        return false;
    }

    return true;
}

bool avatar_action::confirm_non_hostile_melee_attack( avatar &you, const monster &critter )
{
    if( !uistate.distraction_non_hostile_melee ||
        critter.attitude_to( you ) == Creature::Attitude::HOSTILE ) {
        return true;
    }

    const bool force_uc = get_option<bool>( "FORCE_CAPITAL_YN" );
    const auto &allow_key = force_uc ? input_context::disallow_lower_case_or_non_modified_letters
                            : input_context::allow_all_keys;

    while( uistate.distraction_non_hostile_melee ) {
        const std::string action = query_popup()
                                   .preferred_keyboard_mode( keyboard_mode::keycode )
                                   .context( "CANCEL_ACTIVITY_OR_IGNORE_QUERY" )
                                   .message( force_uc && !is_keycode_mode_supported() ?
                                             pgettext( "non_hostile_melee_query",
                                                     "<color_light_red>Really attack the non-hostile %s?  (Case Sensitive)</color>" ) :
                                             pgettext( "non_hostile_melee_query",
                                                     "<color_light_red>Really attack the non-hostile %s?</color>" ),
                                             critter.name() )
                                   .option( "YES", allow_key )
                                   .option( "NO", allow_key )
                                   .option( "MANAGER", allow_key )
                                   .cursor( 1 )
                                   .query()
                                   .action;

        if( action == "YES" ) {
            return true;
        }
        if( action == "MANAGER" ) {
            get_distraction_manager().show();
            ui_manager::redraw();
            refresh_display();
            continue;
        }
        return false;
    }

    return true;
}

std::optional<walk_move_choices> avatar_action::query_walk( avatar &you, map &m,
        const tripoint_rel_ms &d )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( you );
    if( !lifetime || !g->check_safe_mode_allowed() || d.z() != 0 ||
        std::abs( d.x() ) > 1 || std::abs( d.y() ) > 1 || d == tripoint_rel_ms::zero ) {
        return std::nullopt;
    }
    const tripoint_abs_ms origin = you.pos_abs();
    tripoint_bub_ms destination = you.pos_bub( m ) + d;
    if( !m.inbounds( destination ) ) {
        return std::nullopt;
    }
    if( m.has_flag( ter_furn_flag::TFLAG_RAMP_UP, destination ) ) {
        destination.z() += 1;
    } else if( m.has_flag( ter_furn_flag::TFLAG_RAMP_DOWN, destination ) ) {
        destination.z() -= 1;
    }
    if( !m.inbounds( destination ) ) {
        return std::nullopt;
    }
    walk_move_choices choices;
    choices.destination = m.get_abs( destination );
    const ter_id terrain = m.ter( destination );
    const furn_id furniture = m.furn( destination );
    const auto unchanged = [&]() {
        return lifetime && you.pos_abs() == origin && m.inbounds( *choices.destination ) &&
               m.ter( m.get_bub( *choices.destination ) ) == terrain &&
               m.furn( m.get_bub( *choices.destination ) ) == furniture;
    };
    // Modal UI may pump network updates. Carry identities, never borrowed parts.
    const std::vector<tripoint_abs_ms> targets = { *choices.destination,
                                                   m.get_abs( you.pos_bub( m ) + you.grab_point )
                                                 };
    for( const auto &target : targets ) {
        const optional_vpart_position vp = m.veh_at( m.get_bub( target ) );
        if( !vp || !vp->vehicle().has_owner() || vp->vehicle().is_owned_by( you ) ||
            choices.permits_theft( vp->vehicle() ) ) {
            continue;
        }
        const int64_t identity = vp->vehicle().uid().get_value();
        const std::string owner = vp->vehicle().get_owner_name();
        if( !you.query_yn(
                _( "This vehicle belongs to: %s, there may be consequences if you are observed interacting with it, continue?" ),
                owner ) ||
            !unchanged() ) {
            return std::nullopt;
        }
        const optional_vpart_position current = m.veh_at( m.get_bub( target ) );
        if( !current || current->vehicle().uid().get_value() != identity ) {
            return std::nullopt;
        }
        choices.allow_theft = true;
        choices.theft_vehicles.push_back( identity );
    }
    const optional_vpart_position from = m.veh_at( you.pos_bub( m ) );
    const bool dive_from_vehicle = from && std::abs( from->vehicle().velocity ) > 100 &&
                                   !m.veh_at( destination );
    if( dive_from_vehicle ) {
        choices.allow_dismount = you.query_yn( _( "Dive from moving vehicle?" ) );
        if( !choices.allow_dismount || !unchanged() ) {
            return std::nullopt;
        }
    }
    const bool swimming = m.has_flag( ter_furn_flag::TFLAG_SWIMMABLE, destination ) &&
                          m.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, destination ) &&
                          !m.has_flag_furn( "BRIDGE", destination ) && !m.veh_at( destination ) &&
                          !you.has_flag( json_flag_WATERWALKING );
    if( swimming ) {
        const bool already_swimming = !from &&
                                      m.has_flag( ter_furn_flag::TFLAG_SWIMMABLE, you.pos_bub( m ) ) &&
                                      m.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, you.pos_bub( m ) );
        choices.allow_swimming = already_swimming || check_water_affect_items( you );
        if( !choices.allow_swimming || !unchanged() ) {
            return std::nullopt;
        }
    } else {
        auto dangers = g->get_dangerous_tile( you, destination );
        if( !dangers.empty() ) {
            const std::string policy = get_option<std::string>( "DANGEROUS_TERRAIN_WARNING_PROMPT" );
            const move_mode_id mode = you.can_switch_to( you.get_desired_move_mode() ) ?
                                      you.get_desired_move_mode() : you.current_movement_mode();
            if( ( ( policy == "RUNNING" || policy == "NEVER" ) && mode->type() != move_mode_type::RUNNING ) ||
                ( policy == "CROUCHING" && mode->type() != move_mode_type::CROUCHING ) ) {
                you.add_msg_if_player( m_warning,
                                       _( "Change movement mode before entering dangerous terrain." ) );
                return std::nullopt;
            }
            choices.allow_danger = policy == "NEVER" ||
                                   g->prompt_dangerous_tile( you, destination, &dangers );
            if( !choices.allow_danger ) {
                return std::nullopt;
            }
        }
    }
    return unchanged() ? std::optional<walk_move_choices>( choices ) : std::nullopt;
}

bool avatar_action::move( avatar &you, map &m, const tripoint_rel_ms &d )
{
    return move( static_cast<Character &>( you ), m, d, nullptr );
}

bool avatar_action::move( Character &you, map &m, const tripoint_rel_ms &d,
                          const walk_move_choices *choices )
{
    const character_action_guard lifetime( you );
    if( !lifetime || ( choices && ( d.z() != 0 || std::abs( d.x() ) > 1 ||
                                    std::abs( d.y() ) > 1 || d == tripoint_rel_ms::zero ) ) ) {
        return false;
    }
    const bool local_input = you.is_avatar() && !choices;
    const tripoint_abs_ms origin = you.pos_abs();
    const uint64_t route_generation = you.destination_generation();
    const auto movement_context = m.get_context_reference();
    const auto mount = you.mounted_creature;
    const auto at_origin = [&]() {
        return lifetime && movement_context && you.pos_abs() == origin &&
               you.mounted_creature == mount && you.destination_generation() == route_generation;
    };
    map &here = get_map();

    bool in_shell = you.has_active_mutation( trait_SHELL2 ) ||
                    you.has_active_mutation( trait_SHELL3 );
    if( ( local_input && !g->check_safe_mode_allowed() ) || in_shell ) {
        if( in_shell ) {
            you.add_msg_if_player( m_warning,
                                   _( "You can't move while in your shell.  Deactivate it to go mobile." ) );
        }
        return false;
    }

    //TODO: Replace with dirtying vision_transparency_cache
    //TODO: Really ugly bc we're not sure we're moving anywhere yet
    const bool is_crouching = you.is_crouching();
    const bool low_profile = you.has_effect( effect_quadruped_full ) &&
                             you.is_running();
    const bool is_prone = you.is_prone();
    if( is_crouching || is_prone || low_profile ) {
        m.set_transparency_cache_dirty( you.posz() );
    }

    // If any leg broken without crutches and not already on the ground topple over
    if( ( !you.enough_working_legs() && !you.is_prone() &&
          !( you.get_wielded_item() && you.get_wielded_item()->has_flag( flag_CRUTCHES ) ) ) ) {
        you.set_movement_mode( move_mode_prone );
        you.add_msg_if_player( m_bad,
                               _( "Your broken legs can't hold your weight and you fall down in pain." ) );
    }

    const bool is_riding = you.is_mounted();
    tripoint_bub_ms dest_loc;
    const tripoint_bub_ms you_pos = you.pos_bub( m );

    if( d.z() == 0 && ( you.has_effect( effect_stunned ) || you.has_effect( effect_psi_stunned ) ) ) {
        dest_loc.x() = rng( you_pos.x() - 1, you_pos.x() + 1 );
        dest_loc.y() = rng( you_pos.y() - 1, you_pos.y() + 1 );
        dest_loc.z() = you.posz();
    } else {
        dest_loc.x() = you_pos.x() + d.x();
        dest_loc.y() = you_pos.y() + d.y();
        dest_loc.z() = you_pos.z() + d.z();
    }

    if( dest_loc == you.pos_bub() ) {
        // Well that sure was easy
        return true;
    }
    if( !m.inbounds( dest_loc ) ) {
        return false;
    }
    bool via_ramp = false;
    if( m.has_flag( ter_furn_flag::TFLAG_RAMP_UP, dest_loc ) ) {
        dest_loc.z() += 1;
        via_ramp = true;
    } else if( m.has_flag( ter_furn_flag::TFLAG_RAMP_DOWN, dest_loc ) ) {
        dest_loc.z() -= 1;
        via_ramp = true;
    }

    if( !m.inbounds( dest_loc ) ) {
        return false;
    }

    // Berserk creatures cannot voluntarily move farther away from visible hostiles.
    if( you.has_effect( effect_berserk ) ) {
        bool retreating = false;

        get_creature_tracker().for_each_reachable( you, [&]( Creature * critter ) {
            if( retreating || critter == &you ) {
                return;
            }

            if( !you.sees( here, *critter ) ) {
                return;
            }

            if( critter->attitude_to( you ) != Creature::Attitude::HOSTILE ) {
                return;
            }

            const int current_dist = rl_dist( you_pos, critter->pos_bub() );
            const int new_dist = rl_dist( dest_loc, critter->pos_bub() );

            if( new_dist > current_dist ) {
                retreating = true;
            }
        } );

        if( retreating ) {
            you.add_msg_if_player( m_info, _( "You are too enraged to retreat!" ) );
            return false;
        }
    }

    if( local_input && g->mostseen == 0 && get_option<bool>( "AUTO_FEATURES" ) &&
        get_option<bool>( "AUTO_MINING" ) ) {
        const std::string method = automatic_mining_method( you, m, m.get_abs( dest_loc ) );
        if( !method.empty() ) {
            if( cata_mp::client_auto_mine( m.get_abs( dest_loc ) ) ) {
                return true;
            }
            you.invoke_item( &*you.get_wielded_item(), method, dest_loc );
            if( at_origin() && you.activity ) {
                you.defer_move( dest_loc );
            }
            return true;
        }
    }

    // by this point we're either walking, running, crouching, or attacking, so update the activity level to match
    // Riding an animal is less exerting, riding a mech has no exertion level
    if( !is_riding ) {
        you.set_activity_level( you.enchantment_cache->modify_value(
                                    enchant_vals::mod::MOVEMENT_EXERTION_MODIFIER, you.current_movement_mode()->exertion_level() ) );
    } else if( you.get_steed_type() == steed_type::ANIMAL ) {
        you.set_activity_level( you.enchantment_cache->modify_value(
                                    enchant_vals::mod::MOVEMENT_EXERTION_MODIFIER,
                                    you.current_movement_mode()->exertion_level_animal_riding() ) );
    }

    // If the player is *attempting to* move on the X axis, update facing direction of their sprite to match.
    point_rel_ms new_d = dest_loc.xy() - you_pos.xy();

    if( !g->is_tileset_isometric() ) {
        if( new_d.x() > 0 ) {
            you.facing = FacingDirection::RIGHT;
            if( is_riding ) {
                you.mounted_creature->facing = FacingDirection::RIGHT;
            }
        } else if( new_d.x() < 0 ) {
            you.facing = FacingDirection::LEFT;
            if( is_riding ) {
                you.mounted_creature->facing = FacingDirection::LEFT;
            }
        }
    } else {
        //
        // iso:
        //
        // right key            =>  +x -y       FacingDirection::RIGHT
        // left key             =>  -x +y       FacingDirection::LEFT
        // up key               =>  +x +y       ______
        // down key             =>  -x -y       ______
        // y: left-up key       =>  __ +y       FacingDirection::LEFT
        // u: right-up key      =>  +x __       FacingDirection::RIGHT
        // b: left-down key     =>  -x __       FacingDirection::LEFT
        // n: right-down key    =>  __ -y       FacingDirection::RIGHT
        //
        // right key            =>  +x -y       FacingDirection::RIGHT
        // u: right-up key      =>  +x __       FacingDirection::RIGHT
        // n: right-down key    =>  __ -y       FacingDirection::RIGHT
        // up key               =>  +x +y       ______
        // down key             =>  -x -y       ______
        // left key             =>  -x +y       FacingDirection::LEFT
        // y: left-up key       =>  __ +y       FacingDirection::LEFT
        // b: left-down key     =>  -x __       FacingDirection::LEFT
        //
        // right key            =>  +x +y       FacingDirection::RIGHT
        // u: right-up key      =>  +x __       FacingDirection::RIGHT
        // n: right-down key    =>  __ +y       FacingDirection::RIGHT
        // up key               =>  +x -y       ______
        // left key             =>  -x -y       FacingDirection::LEFT
        // b: left-down key     =>  -x __       FacingDirection::LEFT
        // y: left-up key       =>  __ -y       FacingDirection::LEFT
        // down key             =>  -x +y       ______
        //
        if( new_d.x() >= 0 && new_d.y() >= 0 ) {
            you.facing = FacingDirection::RIGHT;
            if( is_riding ) {
                auto *mons = you.mounted_creature.get();
                mons->facing = FacingDirection::RIGHT;
            }
        }
        if( new_d.y() <= 0 && new_d.x() <= 0 ) {
            you.facing = FacingDirection::LEFT;
            if( is_riding ) {
                auto *mons = you.mounted_creature.get();
                mons->facing = FacingDirection::LEFT;
            }
        }
    }

    if( you.has_effect( effect_amigara ) ) {
        int curdist = INT_MAX;
        int newdist = INT_MAX;
        const tripoint_bub_ms minp{ 0, 0, you.posz() };
        const tripoint_bub_ms maxp{ MAPSIZE_X, MAPSIZE_Y, you.posz() };
        for( const tripoint_bub_ms &pt : m.points_in_rectangle( minp, maxp ) ) {
            if( m.ter( pt ) == ter_t_fault ) {
                int dist = rl_dist( pt, you.pos_bub() );
                if( dist < curdist ) {
                    curdist = dist;
                }
                dist = rl_dist( pt, dest_loc );
                if( dist < newdist ) {
                    newdist = dist;
                }
            }
        }
        if( newdist > curdist ) {
            you.add_msg_if_player( m_info, _( "You cannot pull yourself away from the faultline…" ) );
            return false;
        }
    }

    dbg( D_PEDANTIC_INFO ) << "game:plmove: From (" <<
                           you_pos.x() << "," << you_pos.y() << "," << you_pos.z() << ") to (" <<
                           dest_loc.x() << "," << dest_loc.y() << "," << dest_loc.z() << ")";

    if( local_input && g->disable_robot( dest_loc ) ) {
        return false;
    }

    if( !at_origin() ) {
        return false;
    }

    // Check if our movement is actually an attack on a monster or npc
    // Are we displacing a monster?

    creature_tracker &creatures = get_creature_tracker();
    bool attacking = false;
    if( creatures.creature_at( dest_loc ) ) {
        attacking = true;
    }

    if( !you.move_effects( attacking ) ) {
        // move_effects determined we could not move, waste all moves
        if( lifetime ) {
            you.set_moves( 0 );
        }
        return false;
    }

    if( !at_origin() ) {
        return false;
    }
    if( monster *const mon_ptr = creatures.creature_at<monster>( dest_loc, true ) ) {
        monster &critter = *mon_ptr;
        // Creatures swimming under a solid surface don't block surface movement
        if( critter.is_underwater() &&
            m.has_flag( ter_furn_flag::TFLAG_SWIM_UNDER, dest_loc ) ) {
            // They're under the walkway/ice, player walks over them
        } else if( critter.friendly == 0 &&
                   !critter.has_effect( effect_pet ) ) {
            if( you.is_auto_moving() ) {
                you.add_msg_if_player( m_warning, _( "Monster in the way.  Auto move canceled." ) );
                you.add_msg_if_player( m_info, _( "Move into the monster to attack." ) );
                you.abort_automove();
                return false;
            }
            // Moving into a newly arrived creature must not turn an already
            // confirmed network walk into an unrequested attack.
            if( !local_input ) {
                return false;
            }
            if( cata_mp::is_client_mode() ) {
                if( confirm_non_hostile_melee_attack( *you.as_avatar(), critter ) ) {
                    cata_mp::client_request_melee( dest_loc, cata_mp::melee_action::strike );
                }
                return false;
            }
            if( !you.try_break_relax_gas( _( "Your willpower asserts itself, and so do you!" ),
                                          _( "You're too pacified to strike anything…" ) ) ) {
                return false;
            }
            if( !confirm_non_hostile_melee_attack( *you.as_avatar(), critter ) ) {
                return false;
            }
            const int hp_before = critter.get_hp();
            you.melee_attack( critter, true );
            const int dam_dealt = std::max( 0, hp_before - critter.get_hp() );
            if( critter.is_hallucination() ) {
                critter.die( &m, &you );
            }
            g->draw_hit_mon( dest_loc, critter, critter.is_dead(), dam_dealt, &you );
            return false;
        } else if( critter.has_flag( mon_flag_IMMOBILE ) || critter.has_effect( effect_harnessed ) ||
                   critter.has_effect( effect_ridden ) || critter.has_flag( json_flag_CANNOT_MOVE ) ) {
            you.add_msg_if_player( m_info, _( "You can't displace your %s." ), critter.name() );
            return false;
        }
        // Successful displacing is handled (much) later
    }
    // If not a monster, maybe there's an NPC there
    if( npc *const np_ = creatures.creature_at<npc>( dest_loc ) ) {
        npc &np = *np_;
        if( you.is_auto_moving() ) {
            you.add_msg_if_player( _( "NPC in the way, Auto move canceled." ) );
            you.add_msg_if_player( m_info, _( "Move into the NPC to interact or attack." ) );
            you.abort_automove();
            return false;
        }

        if( !local_input ) {
            return false;
        }
        if( !np.is_enemy() ) {
            g->npc_menu( np );
            return false;
        }

        if( cata_mp::is_client_mode() ) {
            cata_mp::client_request_melee( dest_loc, cata_mp::melee_action::strike );
            return false;
        }
        you.melee_attack( np, true );
        np.make_angry();
        return false;
    }

    // CANNOT_MOVE allows melee attacking
    if( you.has_flag( json_flag_CANNOT_MOVE ) ) {
        you.add_msg_if_player( m_bad,
                               _( "You cannot move!" ) );
        return false;
    }

    // GRAB: pre-action checking.
    int dpart = -1;
    const optional_vpart_position vp0 = m.veh_at( you.pos_bub() );
    vehicle *const veh0 = veh_pointer_or_null( vp0 );
    const optional_vpart_position vp1 = m.veh_at( dest_loc );
    vehicle *const veh1 = veh_pointer_or_null( vp1 );

    bool veh_closed_door = false;
    bool outside_vehicle = veh0 == nullptr || veh0 != veh1;
    if( veh1 != nullptr ) {
        dpart = veh1->next_part_to_open( vp1->part_index(), outside_vehicle );
        veh_closed_door = dpart >= 0 && !veh1->part( dpart ).open;
    }

    if( veh0 != nullptr && std::abs( veh0->velocity ) > 100 ) {
        if( veh1 == nullptr ) {
            if( choices ? choices->allow_dismount && choices->confirms( m.get_abs( dest_loc ) ) : local_input &&
                query_yn( _( "Dive from moving vehicle?" ) ) ) {
                if( at_origin() ) {
                    g->moving_vehicle_dismount( you, dest_loc );
                }
            }
            return false;
        } else if( veh1 != veh0 ) {
            you.add_msg_if_player( m_info, _( "There is another vehicle in the way." ) );
            return false;
        } else if( !vp1.part_with_feature( "BOARDABLE", true ) ) {
            you.add_msg_if_player( m_info, _( "That part of the vehicle is currently unsafe." ) );
            return false;
        }
    }
    bool toSwimmable = m.has_flag( ter_furn_flag::TFLAG_SWIMMABLE, dest_loc ) &&
                       !m.has_flag_furn( "BRIDGE", dest_loc );
    bool toDeepWater = m.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, dest_loc ) &&
                       !m.has_flag_furn( "BRIDGE", dest_loc );
    bool fromSwimmable = m.has_flag( ter_furn_flag::TFLAG_SWIMMABLE, you.pos_bub() );
    bool fromDeepWater = m.has_flag( ter_furn_flag::TFLAG_DEEP_WATER, you.pos_bub() );
    bool waterWalking = you.has_flag( json_flag_WATERWALKING );
    bool fromBoat = veh0 != nullptr;
    bool toBoat = veh1 != nullptr;
    if( is_riding ) {
        if( !you.check_mount_will_move( dest_loc ) ) {
            if( you.is_auto_moving() ) {
                you.abort_automove();
            }
            you.mod_moves( -you.get_speed() * 0.2 );
            return false;
        }
    }
    // Dive into water!
    if( toSwimmable && toDeepWater && !toBoat && !waterWalking ) {
        // Requires confirmation if we were on dry land previously
        if( is_riding ) {
            auto *mon = you.mounted_creature.get();
            if( !mon->swims() || mon->get_size() < you.get_size() + 2 ) {
                you.add_msg_if_player( m_warning, _( "The %s cannot swim while it is carrying you!" ),
                                       mon->get_name() );
                return false;
            }
        }
        if( ( fromSwimmable && fromDeepWater && !fromBoat ) ||
            ( choices ? choices->allow_swimming && choices->confirms( m.get_abs( dest_loc ) ) : local_input &&
              check_water_affect_items( *you.as_avatar() ) ) ) {
            if( !at_origin() ) {
                return false;
            }
            if( ( !fromDeepWater || fromBoat ) && you.swim_speed() < 500 ) {
                you.add_msg_if_player( _( "You start swimming." ) );
                you.add_msg_if_player( m_info, _( "%s to dive underwater." ),
                                       press_x( ACTION_MOVE_DOWN ) );
            }
            avatar_action::swim( here, you, dest_loc, choices );
        }

        if( lifetime && you.pos_abs() != origin ) {
            g->on_move_effects( you );
        }
        return true;
    }

    //Wooden Fence Gate (or equivalently walkable doors):
    // open it if we are walking
    // vault over it if we are running
    std::string door_name = m.obstacle_name( dest_loc );
    if( m.passable_ter_furn( dest_loc )
        && you.is_walking()
        && !veh_closed_door
        && m.open_door( you, dest_loc, !m.is_outside( you.pos_bub() ) ) ) {
        if( !at_origin() ) {
            return false;
        }
        you.mod_moves( -you.get_speed() );
        you.add_msg_if_player( _( "You open the %s." ), door_name );
        // if auto move is on, continue moving next turn
        if( you.is_auto_moving() ) {
            you.defer_move( dest_loc );
        }
        return true;
    }

    const tripoint_abs_ms old_abs_pos = you.pos_abs();
    const tripoint_abs_ms abs_dest_loc = here.get_abs( dest_loc );
    if( g->walk_move( you, dest_loc, via_ramp, false, choices ) ) {
        if( !lifetime ) {
            return false;
        }
        // AUTOPEEK: If safe mode would be triggered after the move, look around and move back
        if( local_input && g->safe_mode == SAFE_MODE_ON && !you.is_running() &&
            you.pos_abs() == abs_dest_loc ) {
            here.build_map_cache( dest_loc.z() );
            here.update_visibility_cache( dest_loc.z() );
            g->mon_info_update();
            if( !g->check_safe_mode_allowed() && !you.is_hauling() ) {
                input_context ctxt( "LOOK" );
#if defined(__ANDROID__)
                ctxt.set_hud_scene( "gameplay.look", _( "Look around" ) );
#endif
                static_popup popup;
                popup.message( "%s " + colorize( _( "to go back." ), c_light_gray ) +
                               "\n%s " + colorize( _( "to move anyway." ), c_light_gray ),
                               ctxt.get_desc( "QUIT" ),
                               ctxt.get_desc( "CONFIRM" ) ).on_top( true );
                ui_manager::redraw();
                // Get bub coords again after build_map_cache
                const tripoint_bub_ms src_loc = here.get_bub( old_abs_pos );
                tripoint_bub_ms center( src_loc.x(), src_loc.y(), dest_loc.z() );
                const look_around_result result = g->look_around( false, center, center, false, false, true );
                if( result.peek_action != PA_MOVE ) {
                    g->walk_move( src_loc, via_ramp );
                } else {
                    you.add_msg_if_player( m_info, _( "Ignoring enemy!" ) );
                    for( auto &elem : you.as_avatar()->get_mon_visible().new_seen_mon ) {
                        monster &critter = *elem;
                        critter.ignoring = rl_dist( you.pos_bub(), critter.pos_bub() );
                    }
                    g->set_safe_mode( SAFE_MODE_ON );
                }
                return false; // cancel automove
            }
        }
        return true;
    }
    if( !at_origin() ) {
        return false;
    }
    if( g->phasing_move_enchant( you, dest_loc, you.calculate_by_enchantment( 0,
                                 enchant_vals::mod::PHASE_DISTANCE ) ) ) {
        return true;
    }
    if( !at_origin() ) {
        return false;
    }
    if( g->phasing_move( you, dest_loc, via_ramp ) ) {
        return true;
    }
    if( !at_origin() ) {
        return false;
    }
    // Walking hooks may replace the destination vehicle. Resolve it again.
    const optional_vpart_position door_vp = m.veh_at( dest_loc );
    const optional_vpart_position current_vp = m.veh_at( you.pos_bub( m ) );
    if( door_vp ) {
        vehicle &door_vehicle = door_vp->vehicle();
        const bool outside = !current_vp || &current_vp->vehicle() != &door_vehicle;
        const int door = door_vehicle.next_part_to_open( door_vp->part_index(), outside );
        if( door >= 0 && !door_vehicle.part( door ).open ) {
            if( choices && door_vehicle.has_owner() && !door_vehicle.is_owned_by( you ) &&
                !choices->permits_theft( door_vehicle ) ) {
                return false;
            }
            const int64_t door_vehicle_id = door_vehicle.uid().get_value();
            if( !door_vehicle.handle_potential_theft( you, false, local_input ) || !at_origin() ) {
                return false;
            }
            // Theft callbacks can remove or replace a vehicle; don't retain it.
            const optional_vpart_position refreshed = m.veh_at( dest_loc );
            if( !refreshed || refreshed->vehicle().uid().get_value() != door_vehicle_id ) {
                return false;
            }
            const int current_door = refreshed->vehicle().next_part_to_open( refreshed->part_index(), outside );
            if( current_door < 0 ) {
                return false;
            }
            const std::string vehicle_name = refreshed->vehicle().name;
            door_name = refreshed->vehicle().part( current_door ).name();
            if( outside ) {
                refreshed->vehicle().open_all_at( m, current_door );
            } else {
                refreshed->vehicle().open( m, current_door );
            }
            if( !at_origin() ) {
                return false;
            }
            you.add_msg_if_player( _( "You open the %1$s's %2$s." ), vehicle_name, door_name );
            you.mod_moves( -you.get_speed() );
            if( you.is_auto_moving() ) {
                you.defer_move( dest_loc );
            }
            return true;
        }
    }

    if( m.furn( dest_loc ) != furn_f_safe_c &&
        m.open_door( you, dest_loc, !m.is_outside( you.pos_bub() ) ) ) {
        if( !at_origin() ) {
            return false;
        }
        you.mod_moves( -you.get_speed() );
        you.add_msg_if_player( _( "You open the %s." ), door_name );
        // if auto move is on, continue moving next turn
        if( you.is_auto_moving() ) {
            you.defer_move( dest_loc );
        }
        return true;
    }

    // Invalid move
    const bool waste_moves = you.is_blind() || you.has_effect( effect_stunned );
    if( waste_moves || dest_loc.z() != you.posz() ) {
        you.add_msg_if_player( _( "You bump into the %s!" ), m.obstacle_name( dest_loc ) );
        // Only lose movement if we're blind
        if( waste_moves ) {
            you.mod_moves( -you.get_speed() );
        }
    } else if( const ter_id &t = m.ter( dest_loc ); t == ter_t_door_bar_locked ) {
        you.add_msg_if_player( _( "You rattle the bars but the door is locked!" ) );
    } else if( const std::unordered_set<ter_str_id> locked_doors = { ter_t_door_locked, ter_t_door_locked_peep, ter_t_door_locked_alarm, ter_t_door_locked_interior };
               locked_doors.find( t.id() ) != locked_doors.end() ) {
        // Don't drain move points for learning something you could learn just by looking
        you.add_msg_if_player( _( "That door is locked!" ) );
    }
    return false;
}

void avatar_action::swim( map &m, avatar &you, const tripoint_bub_ms &p )
{
    swim( m, static_cast<Character &>( you ), p, nullptr );
}

void avatar_action::swim( map &m, Character &you, const tripoint_bub_ms &p,
                          const walk_move_choices *choices )
{
    const character_action_guard lifetime( you );
    if( !lifetime || !m.inbounds( p ) ) {
        return;
    }
    const tripoint_abs_ms origin = you.pos_abs();
    const auto at_origin = [&]() {
        return lifetime && you.pos_abs() == origin;
    };
    if( const Creature *occupant = get_creature_tracker().creature_at( p ) ) {
        if( occupant != &you ) {
            return;
        }
    }

    if( !m.has_flag( ter_furn_flag::TFLAG_SWIMMABLE, p ) ) {
        dbg( D_ERROR ) << "game:plswim: Tried to swim in "
                       << m.tername( p ) << "!";
        debugmsg( "Tried to swim in %s!", m.tername( p ) );
        return;
    }
    if( you.has_effect( effect_onfire ) ) {
        you.add_msg_if_player( _( "The water puts out the flames!" ) );
        you.remove_effect( effect_onfire );
        if( you.is_mounted() ) {
            monster *mon = you.mounted_creature.get();
            if( mon->has_effect( effect_onfire ) ) {
                mon->remove_effect( effect_onfire );
            }
        }
    }
    if( you.has_effect( effect_glowing ) ) {
        you.add_msg_if_player( _( "The water washes off the glowing goo!" ) );
        you.remove_effect( effect_glowing );
    }
    if( you.has_effect( effect_bile_irritant ) ) {
        you.add_msg_if_player( _( "The water washes off the acidic bile!" ) );
        you.remove_effect( effect_bile_irritant );
    }

    if( !at_origin() ) {
        return;
    }
    g->water_affect_items( you );
    if( !at_origin() ) {
        return;
    }

    int movecost = you.swim_speed();
    you.practice( skill_swimming, you.is_underwater() ? 2 : 1 );
    if( !at_origin() ) {
        return;
    }
    if( ( movecost >= 500 || you.has_effect( effect_winded ) ) &&
        !you.has_flag( json_flag_WATERWALKING ) && !you.worn_with_flag( json_flag_FLOTATION ) ) {
        if( !you.is_underwater() &&
            !( you.shoe_type_count( itype_swim_fins ) == 2 ||
               ( you.shoe_type_count( itype_swim_fins ) == 1 && one_in( 2 ) ) ) ) {
            you.add_msg_if_player( m_bad, _( "You sink like a rock!" ) );
            you.set_underwater( true );
        }
    }
    if( you.oxygen <= 5 && you.is_underwater() ) {
        if( movecost < 500 ) {
            you.add_msg_if_player( m_warning, _( "You need to breathe!  (%s to surface.)" ),
                                   press_x( ACTION_MOVE_UP ) );
        } else {
            you.add_msg_if_player( m_warning,
                                   _( "You need to breathe but you can't swim!  Get to dry land, quick!" ) );
        }
    }
    const tripoint_bub_ms you_pos = you.pos_bub( m );
    bool diagonal = p.x() != you_pos.x() && p.y() != you_pos.y();
    if( you.in_vehicle ) {
        m.unboard_vehicle( you.pos_bub() );
    }
    if( you.is_mounted() && m.veh_at( you.pos_bub() ).part_with_feature( VPFLAG_BOARDABLE, true ) ) {
        you.add_msg_if_player( m_warning, _( "You cannot board a vehicle while mounted." ) );
        return;
    }
    if( const auto vp = m.veh_at( p ).part_with_feature( VPFLAG_BOARDABLE, true ) ) {
        if( choices && vp->vehicle().has_owner() && !vp->vehicle().is_owned_by( you ) &&
            !choices->permits_theft( vp->vehicle() ) ) {
            return;
        }
        if( !vp->vehicle().handle_potential_theft( you, false, you.is_avatar() && !choices ) ||
            !at_origin() ) {
            return;
        }
    }
    if( !at_origin() ) {
        return;
    }
    tripoint_abs_ms old_abs_pos = you.pos_abs();
    you.setpos( m, p );
    if( !lifetime ) {
        return;
    }
    if( you.is_avatar() ) {
        g->update_map( *you.as_avatar() );
    }
    cata_event_dispatch::character_moves( old_abs_pos, you, m );
    if( !lifetime ) {
        return;
    }

    if( m.veh_at( you.pos_bub() ).part_with_feature( VPFLAG_BOARDABLE, true ) ) {
        m.board_vehicle( you.pos_bub(), &you );
    }
    you.mod_moves( -( ( movecost > 200 ? 200 : movecost ) * ( trigdist && diagonal ? M_SQRT2 : 1 ) ) );
    you.inv->rust_iron_items();

    if( !you.is_mounted() ) {
        you.burn_move_stamina( movecost );
    }

    body_part_set flags;
    if( !you.is_underwater() ) {
        flags = you.get_drenching_body_parts( false, true, true );
    } else {
        flags = you.get_drenching_body_parts();
    }

    you.drench( 100, flags, false );
}

static float rate_critter( const Creature &c )
{
    const npc *np = dynamic_cast<const npc *>( &c );
    if( np != nullptr ) {
        item_location wielded = np->get_wielded_item();
        if( wielded ) {
            return np->evaluate_weapon( *wielded );
        } else {
            return np->unarmed_value();
        }
    }

    const monster *m = dynamic_cast<const monster *>( &c );
    return m->type->get_total_difficulty();
}

void avatar_action::autoattack( avatar &you, map &m )
{
    if( you.has_flag( json_flag_CANNOT_ATTACK ) ) {
        add_msg( m_info, _( "You are incapable of attacking!" ) );
        return;
    }
    const item_location weapon = you.get_wielded_item();
    int reach = weapon ? weapon->reach_range( you ).first : std::max( 1,
                static_cast<int>( you.calculate_by_enchantment( 1, enchant_vals::mod::MELEE_RANGE_MODIFIER ) ) );
    std::vector<Creature *> critters = you.get_targetable_creatures( reach, true );
    critters.erase( std::remove_if( critters.begin(), critters.end(), [&you,
    reach]( const Creature * c ) {
        if( reach == 1 && !you.is_adjacent( c, true ) ) {
            return true;
        }
        if( !you.can_reach_attack( *c ) ) { // target on different z-level
            return true;
        }
        if( !c->is_npc() ) {
            return false;
        }
        return !dynamic_cast<const npc &>( *c ).is_enemy();
    } ), critters.end() );
    if( critters.empty() ) {
        add_msg( m_info, _( "No hostile creature in reach.  Waiting a turn." ) );
        if( g->check_safe_mode_allowed() ) {
            you.pause();
        }
        return;
    }

    Creature &best = **std::max_element( critters.begin(), critters.end(),
    []( const Creature * l, const Creature * r ) {
        return rate_critter( *l ) > rate_critter( *r );
    } );

    const tripoint_rel_ms diff = best.pos_bub() - you.pos_bub();
    if( cata_mp::is_client_mode() ) {
        const bool adjacent = std::abs( diff.x() ) <= 1 && std::abs( diff.y() ) <= 1 && diff.z() == 0;
        cata_mp::client_request_melee( best.pos_bub(), adjacent ? cata_mp::melee_action::strike :
                                       cata_mp::melee_action::reach );
        return;
    }

    if( std::abs( diff.x() ) <= 1 && std::abs( diff.y() ) <= 1 && diff.z() == 0 ) {
        move( you, m, tripoint_rel_ms( diff.xy(), 0 ) );
        return;
    }

    if( weapon && !you.used_weapon() && !weapon->is_gun() ) {
        add_msg( m_info, _( "You can't use reach attacks while forcing yourself to fight unarmed." ) );
        return;
    } else {
        you.reach_attack( best.pos_bub() );
    }
}

void avatar_action::active_technique( avatar &you, map &m )
{
    if( you.is_mounted() && you.mounted_creature &&
        you.mounted_creature->has_flag( mon_flag_RIDEABLE_MECH ) ) {
        add_msg( m_info, _( "You cannot use an active technique while piloting a mech." ) );
        return;
    }
    const std::vector<matec_id> available = you.active_techniques( true );
    if( available.empty() ) {
        add_msg( m_info,
                 _( "You have no active techniques available with your current style and weapon." ) );
        return;
    }

    uilist menu;
    menu.title = _( "Use which active technique?" );
    menu.input_category = "ACTIVE_TECHNIQUE_MENU";
    menu.desc_enabled = true;
    menu.hilight_disabled = true;
    for( size_t i = 0; i < available.size(); ++i ) {
        const matec_id technique = available[i];
        const ret_val<void> status = you.active_technique_availability( technique );
        const bool enabled = status.success() && ( technique != tec_mounted_charge ||
                             ( !cata_mp::is_client_mode() && mounted_charge_available( you ) ) );
        const std::string state = status.success() ? _( "Ready" ) : status.str();
        const std::string description = technique->get_description() + "\n" + state;
        menu.addentry_desc( i, enabled, MENU_AUTOASSIGN,
                            technique->name.translated() + "  [" + state + "]", description );
    }
    for( size_t i = 0; i < available.size(); ++i ) {
        if( available[i]->grapple_action.empty() ) {
            continue;
        }
        uilist_entry &entry = menu.entries[i];
        entry.enabled = entry.enabled && available[i]->activation_allowed( you, "start" );
        if( you.has_effect( available[i]->grapple_cooldown_effect() ) ) {
            const effect &cooldown = you.get_effect( available[i]->grapple_cooldown_effect() );
            entry.desc += string_format( _( "\nRecovering: %s remaining.\n" ),
                                         to_string( cooldown.get_duration() ) );
        }
    }
    menu.query( true, 50, true );
    if( menu.ret < 0 ) {
        return;
    }
    if( static_cast<size_t>( menu.ret ) >= available.size() ) {
        return;
    }
    const matec_id technique = available[menu.ret];
    if( technique == tec_mounted_charge ) {
        mounted_charge( you );
        return;
    }

    const auto eligible_target = [&you, &m]( const tripoint_bub_ms & p ) {
        Creature *const target = get_creature_tracker().creature_at( p, true );
        if( !target || !you.sees( m, *target ) ) {
            return false;
        }
        if( const npc *const np = target->as_npc() ) {
            return np->is_enemy();
        }
        return target->attitude_to( you ) == Creature::Attitude::HOSTILE;
    };
    bool has_target = false;
    for( const tripoint_bub_ms &p : m.points_in_radius( you.pos_bub( m ), 1 ) ) {
        if( eligible_target( p ) ) {
            has_target = true;
            break;
        }
    }
    if( !has_target && you.active_technique_range( technique ) <= 1 ) {
        add_msg( m_info, _( "No hostile creature is adjacent." ) );
        return;
    }
    std::optional<tripoint_bub_ms> target_pos;
    if( you.active_technique_range( technique ) > 1 ) {
        const target_handler::trajectory trajectory = target_handler::mode_select_only(
                    you, you.active_technique_range( technique ) );
        if( !trajectory.empty() ) {
            target_pos = trajectory.back();
        }
    } else {
        target_pos = choose_adjacent_highlight(
                         m, _( "Use the technique on whom?" ), _( "No hostile creature is adjacent." ),
                         eligible_target, false, false );
    }
    if( !target_pos || !eligible_target( *target_pos ) ) {
        return;
    }

    Creature *const target = get_creature_tracker().creature_at( *target_pos, true );
    if( !target ) {
        return;
    }
    if( cata_mp::is_client_mode() ) {
        cata_mp::client_request_melee( *target_pos, cata_mp::melee_action::technique, technique );
        return;
    }
    if( !you.try_break_relax_gas( _( "Your willpower asserts itself, and so do you!" ),
                                  _( "You're too pacified to strike anything." ) ) ) {
        return;
    }
    if( !you.use_active_technique( *target, technique ) ) {
        add_msg( m_info, _( "You cannot use that technique on this target right now." ) );
        return;
    }
    if( npc *const np = target->as_npc() ) {
        np->make_angry();
    }
}

bool avatar_action::mounted_charge_available( const avatar &you )
{
    const item_location weapon = you.get_wielded_item();
    if( !weapon || !weapon->has_technique( tec_mounted_charge ) ||
        !weapon->type->mounted_charge || !weapon->type->mounted_charge->valid() ||
        !you.mounted_creature ||
        !you.active_technique_availability( tec_mounted_charge ).success() ) {
        return false;
    }
    return tec_mounted_charge->activation_allowed( you, "start" );
}

void avatar_action::mounted_charge( avatar &you )
{
    if( !mounted_charge_available( you ) ) {
        add_msg( m_info, _( "You cannot begin a mounted charge right now." ) );
        return;
    }
    const item_location weapon = you.get_wielded_item();
    const target_handler::trajectory trajectory =
        target_handler::mode_select_only( you, weapon->type->mounted_charge->max_steps );
    if( trajectory.empty() ) {
        return;
    }

    map &here = get_map();
    const tripoint_bub_ms destination = trajectory.back();
    if( destination == you.pos_bub( here ) || destination.z() != you.pos_bub( here ).z() ) {
        return;
    }

    you.assign_activity( mounted_charge_activity_actor( here.get_abs( destination ),
                         you.mounted_creature->uid().get_value(), weapon->uid().get_value(), you.pos_abs(),
                         weapon->typeId() ) );
}

// TODO: Move data/functions related to targeting out of game class
bool avatar_action::can_fire_weapon( avatar &you, const map &m, const item &weapon )
{
    if( !weapon.is_gun() ) {
        debugmsg( "Expected item to be a gun" );
        return false;
    }

    if( !cata_mp::client_uses_firearm_intents( weapon ) &&
        !you.try_break_relax_gas( _( "Your eyes steel, and you raise your weapon!" ),
                                  _( "You can't fire your weapon, it's too heavy…" ) ) ) {
        return false;
    }

    std::vector<std::string> messages;
    bool selected_mode_is_empty = false;

    for( const std::pair<const gun_mode_id, gun_mode> &mode_map : weapon.gun_all_modes() ) {
        bool check_common = gunmode_checks_common( you, m, messages, mode_map.second );
        bool check_weapon = gunmode_checks_weapon( you, m, messages, mode_map.second );
        if( mode_map.first == weapon.gun_get_mode_id() ) {
            selected_mode_is_empty = check_common &&
                                     !mode_map.second->ammo_sufficient( &you ) &&
                                     !mode_map.second->has_flag( flag_RELOAD_AND_SHOOT ) &&
                                     !mode_map.second->ammo_remaining();
        }
        bool can_use_mode = check_common && check_weapon;
        if( can_use_mode ) {
            return true;
        }
    }

    if( selected_mode_is_empty ) {
        sfx::play_variant_sound( "fire_gun", "empty", sfx::get_heard_volume( you.pos_bub() ) );
    }
    for( const std::string &message : messages ) {
        add_msg( m_info, message );
    }
    return false;
}

void avatar_action::fire_wielded_weapon( avatar &you )
{
    const item_location weapon = you.get_wielded_item();

    if( !weapon ) {
        return;
    }

    if( is_sling_launcher( *weapon ) ) {
        aim_sling( you );
        return;
    }

    if( weapon->is_gunmod() ) {
        add_msg( m_info,
                 _( "The %s must be attached to a gun, it can not be fired separately." ),
                 weapon->tname() );
        return;
    } else if( !weapon->is_gun() ) {
        return;
    } else if( !weapon->uses_firing_requirements() && weapon->has_ammo_data() &&
               !weapon->ammo_types().count( weapon->loaded_ammo().ammo_type() ) ) {
        // Multimag guns enforce per-pocket ammo at load time; this gate is for
        // single-mag guns whose accepted ammo can shift via gunmod conversion.
        add_msg( m_info, _( "The %s can't be fired while loaded with incompatible ammunition %s" ),
                 weapon->tname(), weapon->ammo_current()->nname( 1 ) );
        return;
    }

    you.assign_activity( aim_activity_actor::use_wielded() );
}

void avatar_action::fire_ranged_mutation( Character &you, const item &fake_gun )
{
    you.assign_activity( aim_activity_actor::use_mutation( fake_gun ) );
}

void avatar_action::fire_ranged_bionic( avatar &you, const item &fake_gun, unsigned int uid )
{
    you.assign_activity( aim_activity_actor::use_bionic( fake_gun, uid ) );
}

bool avatar_action::fire_turret_manual( avatar &you, map &m, turret_data &turret )
{
    const optional_vpart_position at = m.veh_at( you.pos_abs() );
    return turret && at && use_vehicle_turrets( you, m, at->vehicle(), you.pos_abs(), "fire_direct" );
}

void avatar_action::mend( avatar &you, item_location loc )
{

    if( you.fine_detail_vision_mod() > 4 ) {
        add_msg( m_bad, _( "It's too dark to work on mending this." ) );
        return;
    }

    if( !loc ) {
        if( you.is_armed() ) {
            loc = you.get_wielded_item();
        } else {
            add_msg( m_info, _( "You're not wielding anything." ) );
            return;
        }
    }

    if( you.has_item( *loc ) ) {
        you.mend_item( item_location( loc ) );
    }
}

bool avatar_action::eat_here( avatar &you )
{
    map &here = get_map();
    if( ( you.has_active_mutation( trait_RUMINANT ) || you.has_active_mutation( trait_GRAZER ) ) &&
        ( here.has_flag( ter_furn_flag::TFLAG_SHRUB, you.pos_bub() ) &&
          !here.has_flag( ter_furn_flag::TFLAG_GRAZER_INEDIBLE, you.pos_bub() ) ) ) {
        if( you.has_effect( effect_hunger_engorged ) ) {
            add_msg( _( "You're too full to eat the leaves from the %s." ), here.ter( you.pos_bub() )->name() );
            return true;
        } else {
            here.ter_set( you.pos_bub(), ter_t_grass );
            item food( itype_underbrush, calendar::turn, 1 );
            you.assign_activity( consume_activity_actor( food ) );
            return true;
        }
    }
    if( ( you.has_active_mutation( trait_RUMINANT ) || you.has_active_mutation( trait_GRAZER ) ) &&
        ( here.has_flag( ter_furn_flag::TFLAG_FLOWER, you.pos_bub() ) &&
          !here.has_flag( ter_furn_flag::TFLAG_GRAZER_INEDIBLE, you.pos_bub() ) ) ) {
        if( you.has_effect( effect_hunger_engorged ) ) {
            add_msg( _( "You're too full to eat the %s." ), here.ter( you.pos_bub() )->name() );
            return true;
        } else {
            here.furn_set( you.pos_bub(), furn_str_id::NULL_ID() );
            item food( itype_small_plant, calendar::turn, 1 );
            you.assign_activity( consume_activity_actor( food ) );
            return true;
        }
    }
    if( you.has_active_mutation( trait_GRAZER ) &&
        ( here.has_flag( ter_furn_flag::TFLAG_GRAZABLE, you.pos_bub() ) &&
          !here.has_flag( ter_furn_flag::TFLAG_FUNGUS, you.pos_bub() ) ) ) {
        if( you.has_effect( effect_hunger_engorged ) ) {
            add_msg( _( "You're too full to graze." ) );
            return true;
        } else {
            item food( item( itype_grass, calendar::turn, 1 ) );
            you.assign_activity( consume_activity_actor( food ) );
            here.ter_set( you.pos_bub(), here.get_ter_transforms_into( you.pos_bub() ) );
            return true;
        }
    }
    if( you.has_active_mutation( trait_GRAZER ) ) {
        const ter_id &ter_underfoot = here.ter( you.pos_bub() );
        if( ter_underfoot == ter_t_grass_golf || ter_underfoot == ter_t_grass ) {
            add_msg( _( "This grass is too short to graze." ) );
            return true;
        } else if( ter_underfoot == ter_t_grass_dead ) {
            add_msg( _( "This grass is dead and too mangled for you to graze." ) );
            return true;
        } else if( ter_underfoot == ter_t_grass_white ) {
            add_msg( _( "This grass is tainted with paint and thus inedible." ) );
            return true;
        } else if( ter_underfoot == ter_t_grass_alien ) {
            add_msg( _( "This grass is razor sharp and would probably shred your mouth." ) );
            return true;
        }
    }
    return false;
}

void avatar_action::eat( avatar &you, item_location &loc )
{
    map &here = get_map();

    if( !loc ) {
        you.cancel_activity();
        add_msg( _( "Never mind." ) );
        return;
    }
    if( !cata_mp::is_client_mode() ) {
        loc.overflow( here );
        you.last_item = loc->typeId();
    }
    start_item_consumption( you, loc, true );
}

void avatar_action::eat_or_use( avatar &you, item_location loc )
{
    if( loc && loc->is_medical_tool() ) {
        avatar_action::use_item( you, loc, "heal" );
    } else {
        avatar_action::eat( you, loc );
    }
}

void avatar_action::plthrow( avatar &you, item_location loc,
                             const std::optional<tripoint_bub_ms> &blind_throw_from_pos )
{
    map &here = get_map();

    bool in_shell = you.has_active_mutation( trait_SHELL2 ) ||
                    you.has_active_mutation( trait_SHELL3 );
    if( in_shell ) {
        add_msg( m_info, _( "You can't effectively throw while you're in your shell." ) );
        return;
    } else if( you.has_effect( effect_incorporeal ) ) {
        add_msg( m_info, _( "You lack the substance to affect anything." ) );
        return;
    } else if( you.has_flag( json_flag_CANNOT_ATTACK ) ) {
        add_msg( m_info, _( "You are incapable of throwing anything!" ) );
        return;
    }

    bool in_mech = false;
    if( you.is_mounted() ) {
        monster *mons = get_player_character().mounted_creature.get();
        if( mons->has_flag( mon_flag_RIDEABLE_MECH ) ) {
            if( !mons->check_mech_powered() ) {
                add_msg( m_bad, _( "Your %s refuses to move as its batteries have been drained." ),
                         mons->get_name() );
                return;
            }
            in_mech = true;
        }
    }

    if( !loc ) {
        loc = game_menus::inv::titled_menu( you,  _( "Throw item" ),
                                            _( "You don't have any items to throw." ) );
    }

    if( !loc ) {
        add_msg( _( "Never mind." ) );
        return;
    }

    if( cata_mp::is_client_mode() ) {
        if( !cata_mp::can_prepare_throw( you, loc ) ) {
            add_msg( m_info, _( "You can't throw that item right now." ) );
            return;
        }
        cata_mp::throw_intent intent = cata_mp::make_throw_intent( you, loc );
        if( !in_mech && !cata_mp::throw_keeps_wielded( you, loc ) && !you.is_wielding( *loc ) ) {
            if( !avatar_action::check_stealing( you, *loc ) ) {
                return;
            }
            intent.allow_theft = !loc->is_owned_by( you, true );
        }
        if( !in_mech && !cata_mp::throw_keeps_wielded( you, loc ) &&
            !you.is_wielding( *loc ) && you.has_wield_conflicts( *loc ) &&
            !you.get_wielded_item()->has_flag( flag_NO_UNWIELD ) ) {
            intent.disposition = query_item_disposition( you, you.get_wielded_item() );
            if( !intent.disposition ) {
                return;
            }
        }
        if( blind_throw_from_pos ) {
            intent.blind_from = here.get_abs( *blind_throw_from_pos );
        }
        g->temp_exit_fullscreen();
        const on_out_of_scope restore_view( [&]() {
            g->reenter_fullscreen();
        } );
        item preview = *loc;
        const auto peek = cata_mp::client_peek_authorization();
        if( intent.blind_from ) {
            if( !peek || peek->origin != intent.origin || peek->viewpoint != *intent.blind_from ) {
                return;
            }
            intent.peek_request = peek->request;
        }
        const int z_range = peek && intent.blind_from && peek->origin == intent.origin &&
                            peek->viewpoint == *intent.blind_from ? peek->z_range : -1;
        const target_handler::trajectory trajectory = target_handler::mode_throw( you, preview,
                blind_throw_from_pos, z_range );
        if( !trajectory.empty() ) {
            intent.target = here.get_abs( trajectory.back() );
        }
        cata_mp::client_request_throw( intent );
        return;
    }

    // make a copy and get the original.
    // the copy is thrown and has its and the originals charges set appropriately
    // or deleted from inventory if its charges(1) or not stackable.
    item *orig = loc.get_item();
    item thrown = *orig;

    // Throwing aids such as slings can stay wielded while hurling another item.
    const item_location wielded_item = you.get_wielded_item();
    const bool keep_wielded = !in_mech && wielded_item &&
                              !you.is_wielding( *orig ) && !you.is_worn( *orig ) &&
                              wielded_item->has_flag( flag_THROW_KEEP_WIELDED );

    // Bypass check for whether we can wield an item if we're inside a mech
    // or if a throwing aid is already wielded.
    if( !in_mech && !keep_wielded ) {
        const ret_val<void> ret = you.can_wield( *loc );
        if( !ret.success() ) {
            add_msg( m_info, "%s", ret.c_str() );
            return;
        }
    }

    int range = you.throw_range( thrown );
    if( range < 0 ) {
        add_msg( m_info, _( "You don't have that item." ) );
        return;
    } else if( range == 0 ) {
        add_msg( m_info, _( "That is too heavy to throw." ) );
        return;
    }

    if( you.is_wielding( *orig ) && orig->has_flag( flag_NO_UNWIELD ) ) {
        // pos == -1 is the weapon, NO_UNWIELD is used for bio_claws_weapon
        add_msg( m_info, _( "That's part of your body, you can't throw that!" ) );
        return;
    }

    if( !you.try_break_relax_gas( _( "You concentrate mightily, and your body obeys!" ),
                                  _( "You can't muster up the effort to throw anything…" ) ) ) {
        return;
    }
    // if you're wearing the item you need to be able to take it off
    if( you.is_worn( *orig ) ) {
        ret_val<void> ret = you.can_takeoff( *orig );
        if( !ret.success() ) {
            add_msg( m_info, "%s", ret.c_str() );
            return;
        }
    }
    // You must wield the item to throw it, unless a throwing aid is already wielded.
    // If we're in the mech, let's assume the mech wields the item.
    if( !in_mech && !keep_wielded ) {
        if( !you.is_wielding( *orig ) ) {
            if( !you.wield( *orig ) ) {
                return;
            }
        }
    }

    item_location weapon = in_mech ? loc : ( keep_wielded ? wielded_item : you.get_wielded_item() );
    if( !weapon ) {
        return;
    }
    g->temp_exit_fullscreen();
    const on_out_of_scope restore_view( [&]() {
        g->reenter_fullscreen();
    } );
    const tripoint_abs_ms throw_origin = you.pos_abs();
    item &relevant = thrown;
    const target_handler::trajectory trajectory = target_handler::mode_throw( you, relevant,
            blind_throw_from_pos );

    if( trajectory.empty() || you.pos_abs() != throw_origin || !weapon ||
        ( keep_wielded && !loc ) ) {
        return;
    }

    if( keep_wielded ) {
        // Throwing aids let us keep the aid wielded, but we still pay the cost to retrieve
        // the projectile from inventory/container/ground.  Pay it only after the throw is
        // confirmed so that previewing/canceling the target UI doesn't consume moves.
        you.mod_moves( -loc.obtain_cost( you ) );
        if( orig->count_by_charges() && orig->charges > 1 ) {
            orig->mod_charges( -1 );
            thrown.charges = 1;
        } else {
            loc.remove_item();
        }
    } else if( weapon->count_by_charges() && weapon->charges > 1 ) {
        weapon->mod_charges( -1 );
        thrown.charges = 1;
    } else {
        if( in_mech ) {
            loc.remove_item();
        } else {
            you.remove_weapon();
        }
    }
    you.throw_item( trajectory.back(), thrown, blind_throw_from_pos );
}

void avatar_action::plthrow_wielded( avatar &you,
                                     const std::optional<tripoint_bub_ms> &blind_throw_from_pos )
{
    item_location weapon = you.get_wielded_item();
    if( !weapon ) {
        add_msg( _( "You aren't holding something you can throw." ) );
        return;
    }
    avatar_action::plthrow( you, weapon, blind_throw_from_pos );
}

static void update_lum( item_location loc, bool add )
{
    switch( loc.where() ) {
        case item_location::type::map:
            get_map().update_lum( loc, add );
            break;
        default:
            break;
    }
}

void avatar_action::use_item( avatar &you )
{
    item_location loc;
    avatar_action::use_item( you, loc );
}

void avatar_action::use_item( avatar &you, item_location &loc, std::string const &method )
{
    map &here = get_map();
    std::string selected_method = method;

    if( you.has_effect( effect_incorporeal ) ) {
        you.add_msg_if_player( m_bad, _( "You can't use anything while incorporeal." ) );
        return;
    }

    // Some items may be used without being picked up first
    bool use_in_place = false;

    if( !loc ) {
        loc = game_menus::inv::use();

        if( !loc ) {
            add_msg( _( "Never mind." ) );
            return;
        }
    }

    if( loc->is_gun() && !loc->is_gunmod() && method.empty() ) {
        // Keep the client activation guard ahead of either gun action.
        if( cata_mp::is_client_mode() &&
            ( cata_mp::is_client_waiting_for_ack() || you.get_moves() <= 0 ||
              g->multiplayer_session().client_inventory_activity.active ) ) {
            return;
        }
        bool manage = true;
        if( loc->type->has_use() || loc->has_relic_activation() ) {
            uilist actions;
            actions.text = loc->tname();
            actions.addentry( 0, true, 'm', _( "Manage gun modifications" ) );
            actions.addentry( 1, true, 'a', _( "Activate item" ) );
            actions.query();
            if( actions.ret < 0 ) {
                return;
            }
            manage = actions.ret == 0;
        }
        if( manage ) {
            if( avatar_action::check_stealing( get_player_character(), *loc.get_item() ) ) {
                gunmod_ui::show( you, loc );
            }
            return;
        }
    }

    // Submit the original source before obtain/overflow can mutate the replica.
    // Native medication use already follows the consumption activity path.
    if( cata_mp::is_client_mode() && loc->is_craft() ) {
        cata_mp::client_resume_craft( loc );
        return;
    }
    if( cata_mp::is_client_mode() && method == "heal" && healing_action( loc ) ) {
        select_client_healing( you, loc );
        return;
    }
    if( cata_mp::is_client_mode() &&
        ( !loc->is_medication() ||
          cata::lua_platform::has_platform_item_use_handler( loc->typeId().str() ) ) &&
        cata_mp::client_activate_item( loc, selected_method ) ) {
        return;
    }
    if( cata_mp::is_client_mode() && loc->is_medication() ) {
        start_item_consumption( you, loc );
        return;
    }

    if( !avatar_action::check_stealing( get_player_character(), *loc.get_item() ) ) {
        return;
    }

    loc.overflow( here );

    if( loc->wetness && loc->has_flag( flag_WATER_BREAK_ACTIVE ) ) {
        if( query_yn( _( "This item is still wet and it will break if you turn it on.  Proceed?" ) ) ) {
            loc->deactivate();
            loc.get_item()->set_random_fault_of_type( "wet", true );
            // An electronic item in water is also shorted.
            if( loc->has_flag( flag_ELECTRONIC ) ) {
                loc.get_item()->set_random_fault_of_type( "shorted", true );
            }
        } else {
            return;
        }
    }

    item_pocket *parent_pocket = nullptr;
    bool on_person = true;
    int pre_obtain_moves = you.get_moves();
    if( loc->has_flag( flag_ALLOWS_REMOTE_USE ) || you.is_worn( *loc ) ) {
        use_in_place = true;
        // Activate holster on map only if hands are free.
    } else if( you.can_wield( *loc ).success() && loc->is_holster() && !loc.held_by( you ) ) {
        use_in_place = true;
        // Adjustment because in player::wield_contents this amount is refunded.
        you.mod_moves( -loc.obtain_cost( you ) );
    } else {
        item_location::type loc_where = loc.where_recursive();
        std::string const name = loc->display_name();
        if( loc_where != item_location::type::character ) {
            pre_obtain_moves = -1;
            on_person = false;
        }

        // Get the parent pocket before the item is obtained.
        if( loc.has_parent() ) {
            parent_pocket = loc.parent_pocket();
        }

        loc = loc.obtain( you, 1 );

        if( parent_pocket ) {
            parent_pocket->on_contents_changed();
        }
        if( pre_obtain_moves == -1 ) {
            pre_obtain_moves = you.get_moves();
        }
        if( !loc ) {
            you.add_msg_if_player( _( "Couldn't pick up the %s." ), name );
            return;
        }
        if( loc_where != item_location::type::character ) {
            you.add_msg_if_player( _( "You pick up the %s." ), name );
        }
    }

    if( use_in_place ) {
        update_lum( loc, false );
        you.use( loc, pre_obtain_moves, selected_method );
        if( loc ) {
            update_lum( loc, true );
            loc.make_active();
        }
    } else {
        you.use( loc, pre_obtain_moves, selected_method );

        if( parent_pocket && on_person && parent_pocket->will_spill() ) {
            parent_pocket->handle_liquid_or_spill( you, loc.parent_item().get_item() );
        }
    }
    if( loc ) {
        loc.on_contents_changed();
    }

    you.recoil = MAX_RECOIL;

    you.invalidate_crafting_inventory();
}

void avatar_action::unload( avatar &you )
{
    std::pair<item_location, bool> ret = game_menus::inv::unload( you );
    if( !ret.first ) {
        add_msg( _( "Never mind." ) );
        return;
    }

    if( ret.second || !ret.first->is_container() ) {
        // Auto contain
        if( cata_mp::is_client_mode() ) {
            cata_mp::client_select_unload( ret.first );
        } else {
            you.unload( ret.first );
        }
    } else {
        // Manual contain
        item_location new_container = g->inv_map_splice( [&you]( const item_location & it ) {
            return it->is_container() && !it->is_corpse() && you.rate_action_insert( it ) == hint_rating::good;
        }, _( "Insert item" ), 1, _( "You have no container to insert items." ) );

        if( !new_container ) {
            add_msg( _( "Never mind." ) );
            return;
        }
        if( cata_mp::is_client_mode() ) {
            cata_mp::client_select_unload( ret.first, new_container );
        } else {
            you.unload( ret.first, false, new_container );
        }
    }
}
