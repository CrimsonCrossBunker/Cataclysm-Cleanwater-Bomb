#include <algorithm>
#include <cstddef>
#include <functional>
#include <iterator>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "calendar.h"
#include "character.h"
#include "character_attire.h"
#include "color.h"
#include "coordinates.h"
#include "crafting.h"
#include "debug.h"
#include "enums.h"
#include "flag.h"
#include "gunmod_ui.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "itype.h"
#include "map.h"
#include "map_selector.h"
#include "player_activity.h"
#include "ret_val.h"
#include "string_formatter.h"
#include "translations.h"
#include "type_id.h"
#include "uilist.h"
#include "value_ptr.h"
#include "vehicle_selector.h"
#include "visitable.h"

static const trait_id trait_DEBUG_HS( "DEBUG_HS" );

template <typename T, typename Output>
static void find_ammo_helper( T &src, const item &obj, bool empty, Output out, bool nested,
                              bool now = true )
{
    src.visit_items( [&src, &nested, &out, &obj, empty, now]( item * node, item * parent ) {

        // This stops containers and magazines counting *themselves* as ammo sources
        if( node == &obj ) {
            return VisitResponse::SKIP;
        }

        // Spills are not valid. spilled liquids have no parent.
        if( parent == nullptr && node->made_of_from_type( phase_id::LIQUID ) ) {
            return VisitResponse::SKIP;
        }

        // Frozen liquids can't be loaded
        if( node->is_frozen_liquid() ) {
            return VisitResponse::SKIP;
        }

        // Do not steal ammo from magazines
        if( parent != nullptr && parent->is_magazine() ) {
            return VisitResponse::SKIP;
        }

        // Do not steal magazines from other items
        if( parent != nullptr && node == parent->magazine_current() ) {
            return VisitResponse::SKIP;
        }

        // Do not consider empty mags unless specified
        if( node->is_magazine() && !node->ammo_remaining( ) && !empty ) {
            return VisitResponse::SKIP;
        }

        if( node->has_flag( flag_SPEEDLOADER ) && obj.magazine_integral() ) {
            // Can't reload with empty speedloaders
            if( !node->ammo_remaining( ) ) {
                return VisitResponse::SKIP;
            }
            // All speedloaders are accepted.
            // Ammo check is done somewhere else
            // Ammo check should probably happen here...
            if( obj.can_reload_with( *node, now ) ) {
                if( parent != nullptr ) {
                    out = item_location( item_location( src, parent ), node );
                } else {
                    out = item_location( src, node );
                }
            }
            return VisitResponse::SKIP;
        }

        if( obj.can_reload_with( *node, now ) ) {
            if( parent != nullptr ) {
                out = item_location( item_location( src, parent ), node );
            } else {
                out = item_location( src, node );
            }
        }

        // Not-nested checks only top level containers and their immediate contents.
        return parent == nullptr || nested ? VisitResponse::NEXT : VisitResponse::SKIP;

    } );
}

std::vector<item_location> Character::get_ammo( const ammotype &at ) const
{
    return cache_get_items_with( "is_ammo", &item::is_ammo, [at]( const item_location & it ) {
        return it->ammo_type() == at;
    } );
}

std::vector<item_location> Character::find_ammo( const item &obj, bool empty, int radius,
        bool now ) const
{
    map &here = get_map();

    std::vector<item_location> res = cache_get_items_with( "is_ammo",
    &item::is_ammo, [&obj, now]( const item_location & it ) {
        return obj.can_reload_with( *it, now );
    } );

    std::vector<item_location> mag_locs = cache_get_items_with( "is_magazine",
    &item::is_magazine, [&obj, &empty, now]( const item_location & it ) {
        if( &obj == &*it ) {
            return false;
        }
        if( it.parent_item() && &*it == it.parent_item()->magazine_current() ) {
            return false;
        }
        if( !it->ammo_remaining() && !empty ) {
            return false;
        }
        if( it->has_flag( flag_SPEEDLOADER ) && ( !it->ammo_remaining() || !obj.magazine_integral() ) ) {
            return false;
        }
        return obj.can_reload_with( *it, now );
    } );

    res.insert( res.end(), mag_locs.begin(), mag_locs.end() );

    if( radius >= 0 ) {
        for( map_cursor &cursor : map_selector( pos_bub(), radius ) ) {
            find_ammo_helper( cursor, obj, empty, std::back_inserter( res ), false, now );
        }
        for( vehicle_cursor &cursor : vehicle_selector( here, pos_bub( here ), radius ) ) {
            find_ammo_helper( cursor, obj, empty, std::back_inserter( res ), false, now );
        }
    }

    return res;
}

std::pair<int, int> Character::gunmod_installation_odds( const item_location &gun,
        const item &mod ) const
{
    // Mods with INSTALL_DIFFICULT have a chance to fail, potentially damaging the gun
    if( !mod.has_flag( flag_INSTALL_DIFFICULT ) || has_trait( trait_DEBUG_HS ) ) {
        return std::make_pair( 100, 0 );
    }

    int roll = 100; // chance of success (%)
    int risk = 0;   // chance of failure (%)
    float chances = 1.0f; // start with 1 in 6 (~17% chance)

    for( const auto &e : mod.type->min_skills ) {
        // gain an additional chance for every level above the minimum requirement
        skill_id sk = e.first.str() == "weapon" ? gun->gun_skill() : e.first;
        chances += std::max( get_greater_skill_or_knowledge_level( sk )  - e.second, 0.0f );
    }
    // cap success from skill alone to 1 in 5 (~83% chance)
    roll = std::min( static_cast<double>( chances ), 5.0 ) / 6.0 * 100;
    // focus is either a penalty or bonus of at most +/-10%
    roll += ( std::clamp( get_focus(), 60, 140 ) - 100 ) / 4;
    // dexterity and intelligence give +/-2% for each point above or below 12
    roll += ( get_dex() - 12 ) * 2;
    roll += ( get_int() - 12 ) * 2;
    // each level of damage to the base gun reduces success by 10%
    roll -= gun->damage_level() * 10;
    roll = std::min( std::max( roll, 0 ), 100 );

    // risk of causing damage on failure increases with less durable guns
    risk = ( 100 - roll ) * ( ( 10.0 - std::min( gun->type->gun->durability, 9 ) ) / 10.0 );

    return std::make_pair( roll, risk );
}

void Character::gunmod_add( item &gun, item &mod, const std::optional<itype_id> &selected_tool )
{
    if( !gun.is_gunmod_compatible( mod ).success() ) {
        debugmsg( "Tried to add incompatible gunmod" );
        return;
    }

    if( !has_item( gun ) && !has_item( mod ) ) {
        debugmsg( "Tried gunmod installation but mod/gun not in player possession" );
        return;
    }

    // first check at least the minimum requirements are met
    if( !has_trait( trait_DEBUG_HS ) && !can_use( mod, gun ) ) {
        return;
    }

    item_location selected_mod( *this, &mod );
    std::string mod_name = mod.tname();

    const item_location wielded = get_wielded_item();
    if( !is_wielding( gun ) && ( is_wielding( mod ) ||
                                 ( wielded && wielded->has_item( mod ) ) || gun.has_item( mod ) ) ) {
        if( is_wielding( mod ) ) {
            const ret_val<void> can_stow = can_unwield( mod );
            if( !can_stow.success() ) {
                add_msg_if_player( m_info, "%s", can_stow.c_str() );
                return;
            }
        }
        std::pair<item_location, item_pocket *> destination;
        worn.best_pocket( *this, mod, &gun, destination );
        if( !destination.second ) {
            add_msg_if_player( _( "You have no room to store the %s." ), mod_name );
            return;
        }
        const ret_val<item *> stored = destination.second->insert_item( mod );
        if( !stored.success() ) {
            add_msg_if_player( m_info, "%s", stored.c_str() );
            return;
        }
        item_location stowed_mod( destination.first, stored.value() );
        mod_moves( -item_handling_cost( mod ) );
        i_rem( &mod );
        stowed_mod.on_contents_changed();
        stowed_mod->on_pickup( *this );
        craft_relocated( stowed_mod );
        calc_encumbrance();
        selected_mod = stowed_mod;
    }

    if( !is_wielding( gun ) && !wield( gun ) ) {
        add_msg_if_player( _( "You can't wield the %1$s." ), gun.tname() );
        return;
    }

    // Wielding will create a new gun and/or mod when the item changes location.
    item_location wielded_gun = get_wielded_item();
    if( !selected_mod ) {
        add_msg_if_player( _( "You no longer have a %s and can't continue crafting." ), mod_name );
        return;
    }

    item &moved_mod = *selected_mod;
    // any (optional) tool charges that are used during installation
    const auto options = gunmod_ui::installation_options( *this, wielded_gun, moved_mod );
    int option_index = 0;

    std::string tool;
    int qty = 0;

    if( moved_mod.is_irremovable() ) {
        if( !query_yn( _( "Permanently install your %1$s in your %2$s?" ),
                       colorize( moved_mod.tname(), moved_mod.color_in_inventory() ),
                       colorize( wielded_gun->tname(), wielded_gun->color_in_inventory() ) ) ) {
            add_msg_if_player( _( "Never mind." ) );
            return; // player canceled installation
        }
    }

    // if chance of success <100% prompt user to continue
    if( selected_tool ) {
        const auto found = std::find_if( options.begin(), options.end(),
        [&selected_tool]( const gunmod_ui::installation_option & option ) {
            return option.tool == *selected_tool;
        } );
        if( found == options.end() || !found->available ) {
            add_msg_if_player( _( "The selected installation tool is no longer available." ) );
            return;
        }
        option_index = std::distance( options.begin(), found );
    } else if( options.size() > 1 ) {
        uilist prompt;
        prompt.text = string_format( _( "Attach your %1$s to your %2$s?" ), moved_mod.tname(),
                                     wielded_gun->tname() );

        const std::vector<int> hotkeys = { 'w', 'f', 'g' };
        for( size_t index = 0; index < options.size(); ++index ) {
            const gunmod_ui::installation_option &option = options[index];
            prompt.addentry( index, option.available, hotkeys[index],
                             string_format( _( "%1$s (%2$d charges): %3$d%% success, %4$d%% damage on failure" ),
                                            option.name(), option.charges, option.success, option.damage ) );
        }

        prompt.query();
        if( prompt.ret < 0 ) {
            add_msg_if_player( _( "Never mind." ) );
            return; // player canceled installation
        }
        option_index = prompt.ret;
    }

    const gunmod_ui::installation_option &option = options[option_index];
    tool = option.tool.is_null() ? "" : option.tool.str();
    qty = option.charges;

    const int moves = !has_trait( trait_DEBUG_HS ) ? to_moves<int>
                      ( moved_mod.type->gunmod->install_time ) : 0;

    assign_activity( gunmod_add_activity_actor( moves, tool ) );
    activity.targets.emplace_back( wielded_gun );
    activity.targets.emplace_back( *this, &moved_mod );
    activity.values.push_back( 0 ); // dummy value
    activity.values.push_back( option.success ); // chance of success (%)
    activity.values.push_back( option.damage ); // chance of damage (%)
    activity.values.push_back( qty ); // tool charges
}

bool Character::gunmod_remove( item &gun, item &mod )
{
    return gunmod_remove( item_location( *this, &gun ), mod );
}

bool Character::gunmod_remove( item_location gun_loc, item &mod )
{
    if( !gun_loc ) {
        return false;
    }
    item &gun = *gun_loc.get_item();
    std::vector<item *> mods = gun.gunmods();
    size_t gunmod_idx = mods.size();
    for( size_t i = 0; i < mods.size(); i++ ) {
        if( mods[i] == &mod ) {
            gunmod_idx = i;
            break;
        }
    }
    if( gunmod_idx == mods.size() ) {
        debugmsg( "Cannot remove non-existent gunmod" );
        return false;
    }

    const std::string denial = gunmod_ui::removal_denial( gun, mod );
    if( !denial.empty() ) {
        add_msg_if_player( m_info, "%s", denial );
        return false;
    }

    if( !gunmod_remove_activity_actor::gunmod_unload( *this, mod ) ) {
        return false;
    }

    // Removing gunmod takes only half as much time as installing it
    const int moves = has_trait( trait_DEBUG_HS ) ? 0 : to_moves<int>
                      ( mod.type->gunmod->install_time ) / 2;
    assign_activity( gunmod_remove_activity_actor( moves, gun_loc, static_cast<int>( gunmod_idx ) ) );
    return true;
}

bool Character::has_gun_for_ammo( const ammotype &at ) const
{
    return cache_has_item_with( "is_gun", &item::is_gun, [&at]( const item & it ) {
        return it.ammo_types().count( at );
    } );
}

bool Character::has_magazine_for_ammo( const ammotype &at ) const
{
    if( cache_has_item_with( "is_magazine", &item::is_magazine, [&at]( const item & it ) {
    return !it.has_flag( flag_NO_RELOAD ) && it.ammo_types().count( at );
    } ) ) {
        return true;
    }
    return cache_has_item_with( "is_gun", &item::is_gun, [&at]( const item & it ) {
        return !it.has_flag( flag_NO_RELOAD ) &&
               ( ( it.magazine_integral() && it.ammo_types().count( at ) ) ||
                 ( it.magazine_current() != nullptr && it.magazine_current()->ammo_types().count( at ) ) );
    } );
}

