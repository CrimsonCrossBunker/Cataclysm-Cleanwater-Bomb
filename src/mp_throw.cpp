#include "mp_throw.h"

#include <algorithm>

#include "character.h"
#include "creature_tracker.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "map.h"
#include "map_selector.h"
#include "monster.h"
#include "mtype.h"
#include "projectile.h"
#include "ranged_actions.h"
#include "ret_val.h"
#include "safe_reference.h"
#include "translations.h"
#include "vehicle_selector.h"
#include "visitable.h"

namespace cata_mp
{
namespace
{
bool throwing_in_mech( Character &who )
{
    return who.is_mounted() && who.mounted_creature &&
           who.mounted_creature->has_flag( mon_flag_RIDEABLE_MECH );
}

item_location resolve_throw_source( Character &who, map &here, const throw_intent &intent )
{
    if( intent.path.empty() || intent.path.size() > 64 ) {
        return item_location();
    }
    const auto root_matches = [&]( const item & candidate ) {
        return candidate.uid().get_value() == intent.path.front();
    };
    item_location root;
    if( intent.source == "carried" ) {
        const auto items = who.items_with( root_matches );
        if( items.size() == 1 && !who.find_parent( *items.front() ) ) {
            root = item_location( who, items.front() );
        }
    } else if( intent.source == "map" ) {
        for( map_cursor &cursor : map_selector( who.pos_bub(), 1 ) ) {
            if( cursor.pos_abs() == intent.source_position ) {
                const auto items = cursor.items_with( root_matches );
                if( items.size() == 1 && !cursor.find_parent( *items.front() ) ) {
                    root = item_location( cursor, items.front() );
                }
            }
        }
    } else if( intent.source == "vehicle" ) {
        for( vehicle_cursor &cursor : vehicle_selector( here, who.pos_bub(), 1 ) ) {
            const auto items = cursor.items_with( root_matches );
            if( items.size() == 1 && !cursor.find_parent( *items.front() ) ) {
                item_location candidate( cursor, items.front() );
                if( here.get_abs( candidate.pos_bub( here ) ) == intent.source_position ) {
                    root = candidate;
                }
            }
        }
    }
    for( size_t index = 1; root && index < intent.path.size(); ++index ) {
        item *child = nullptr;
        for( item *candidate : root->all_items_top() ) {
            if( candidate->uid().get_value() == intent.path[index] ) {
                if( child ) {
                    return item_location();
                }
                child = candidate;
            }
        }
        root = child ? item_location( root, child ) : item_location();
    }
    return root;
}
} // namespace

throw_intent make_throw_intent( const Character &who, item_location source )
{
    throw_intent intent;
    intent.origin = who.pos_abs();
    const item_location wielded = who.get_wielded_item();
    intent.wielded = wielded ? wielded->uid().get_value() : 0;
    while( source ) {
        intent.path.push_back( source->uid().get_value() );
        if( !source.has_parent() ) {
            break;
        }
        source = source.parent_item();
    }
    std::reverse( intent.path.begin(), intent.path.end() );
    if( source ) {
        intent.source = source.held_by( who ) ? "carried" :
                        source.where() == item_location::type::map ? "map" :
                        source.where() == item_location::type::vehicle ? "vehicle" : "invalid";
        intent.source_position = get_map().get_abs( source.pos_bub( get_map() ) );
    }
    return intent;
}

bool throw_keeps_wielded( Character &who, const item_location &source )
{
    const item_location wielded = who.get_wielded_item();
    return source && !throwing_in_mech( who ) && wielded &&
           !who.is_wielding( *source ) && !who.is_worn( *source ) &&
           wielded->has_flag( flag_THROW_KEEP_WIELDED );
}

bool can_prepare_throw( Character &who, const item_location &source )
{
    if( !source || who.has_active_mutation( trait_id( "SHELL2" ) ) ||
        who.has_active_mutation( trait_id( "SHELL3" ) ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) ||
        who.has_flag( json_character_flag( "CANNOT_ATTACK" ) ) ||
        who.throw_range( *source ) <= 0 ||
        ( who.is_wielding( *source ) && source->has_flag( flag_NO_UNWIELD ) ) ||
        ( who.is_worn( *source ) && !who.can_takeoff( *source ).success() ) ) {
        return false;
    }
    if( throwing_in_mech( who ) ) {
        return who.mounted_creature->check_mech_powered();
    }
    return throw_keeps_wielded( who, source ) || who.can_wield( *source ).success();
}

bool execute_throw_intent( Character &who, map &here, const throw_intent &intent )
{
    if( who.is_dead_state() || who.get_moves() <= 0 || who.pos_abs() != intent.origin ) {
        return false;
    }
    item_location source = resolve_throw_source( who, here, intent );
    item_location wielded = who.get_wielded_item();
    if( !can_prepare_throw( who, source ) ||
        intent.wielded != ( wielded ? wielded->uid().get_value() : 0 ) ) {
        return false;
    }
    std::optional<tripoint_bub_ms> blind;
    if( intent.blind_from ) {
        if( !here.inbounds( *intent.blind_from ) ||
            rl_dist( intent.origin, *intent.blind_from ) > 1 ||
            here.impassable( here.get_bub( *intent.blind_from ) ) ||
            ( *intent.blind_from != intent.origin &&
              !here.valid_move( who.pos_bub(), here.get_bub( *intent.blind_from ), false, true ) ) ) {
            return false;
        }
        blind = here.get_bub( *intent.blind_from );
    }
    if( intent.target && !here.inbounds( *intent.target ) ) {
        return false;
    }
    const bool in_mech = throwing_in_mech( who );
    const bool keep_wielded = throw_keeps_wielded( who, source );
    if( !in_mech && !keep_wielded && !who.is_wielding( *source ) &&
        !source->is_owned_by( who, true ) && !intent.allow_theft ) {
        return false;
    }
    const safe_reference<Creature> actor = who.get_safe_reference();
    item thrown = *source;
    if( blind ) {
        who.mod_moves( -who.get_speed() * 2 );
    }
    if( !who.try_break_relax_gas( _( "You concentrate mightily, and your body obeys!" ),
                                  _( "You can't muster up the effort to throw anything…" ) ) ) {
        return false;
    }
    if( !in_mech && !keep_wielded && !who.is_wielding( *source ) ) {
        if( who.has_wield_conflicts( *source ) ) {
            if( wielded->has_item( *source ) ) {
                return false;
            }
            const bool disposed = wielded->has_flag( flag_NO_UNWIELD ) ? who.unwield() :
                                  intent.disposition && execute_item_disposition( who, wielded, *intent.disposition );
            if( !disposed || !actor ) {
                return false;
            }
            source = resolve_throw_source( who, here, intent );
            if( !source ) {
                return false;
            }
        }
        const bool external = !source.held_by( who );
        // Player-selected disposal is already complete: avoid NPC stow/MA policy.
        if( !who.Character::wield( *source ) || !actor ) {
            return false;
        }
        if( external && source ) {
            source.remove_item();
        }
    }
    item_location weapon = in_mech ? source : ( keep_wielded ? wielded : who.get_wielded_item() );
    if( !weapon || !intent.target || who.pos_abs() != intent.origin ) {
        // Canceling targeting still preserves the native preparation and its AP cost.
        return false;
    }
    if( rl_dist( intent.blind_from.value_or( intent.origin ), *intent.target ) >
        who.throw_range( thrown ) ) {
        return false;
    }
    const tripoint_bub_ms target = here.get_bub( *intent.target );
    who.last_target_pos = *intent.target;
    Creature *victim = get_creature_tracker().creature_at( target, true );
    who.last_target = victim ? g->shared_from( *victim ) : shared_ptr_fast<Creature>();
    mark_ranged_target( who, true );
    if( !actor || !weapon || ( keep_wielded && !source ) ) {
        return false;
    }
    if( keep_wielded ) {
        who.mod_moves( -source.obtain_cost( who ) );
        if( source->count_by_charges() && source->charges > 1 ) {
            source->mod_charges( -1 );
            thrown.charges = 1;
        } else {
            source.remove_item();
        }
    } else if( weapon->count_by_charges() && weapon->charges > 1 ) {
        weapon->mod_charges( -1 );
        thrown.charges = 1;
    } else if( in_mech ) {
        source.remove_item();
    } else {
        who.remove_weapon();
    }
    who.throw_item( target, thrown, blind );
    return true;
}
} // namespace cata_mp
