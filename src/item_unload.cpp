#include "item_unload.h"

#include <algorithm>
#include <optional>
#include <utility>
#include <set>

#include "activity_actor_definitions.h"
#include "calendar.h"
#include "character.h"
#include "flag.h"
#include "game_constants.h"
#include "item.h"
#include "item_pocket.h"
#include "item_uid.h"
#include "json.h"
#include "line.h"
#include "liquid_transfer.h"
#include "map.h"
#include "messages.h"
#include "pocket_type.h"
#include "safe_reference.h"
#include "string_formatter.h"
#include "translations.h"
#include "uilist.h"
#include "vehicle.h"
#include "vpart_range.h"

namespace
{
struct pocket_source {
    item *magazine = nullptr;
    item_pocket *integral = nullptr;
    unload_source_option option;
};

std::vector<pocket_source> pocket_sources( item &target )
{
    std::vector<pocket_source> result;
    for( item *mag : target.magazines_current() ) {
        result.push_back( { mag, nullptr, { mag->uid().get_value(), mag->tname() } } );
    }
    if( target.uses_firing_requirements() ) {
        for( item_pocket *pocket : target.get_pockets( []( const item_pocket & p ) {
        return p.is_type( pocket_type::MAGAZINE );
        } ) ) {
            for( item *ammo : pocket->all_items_top() ) {
                if( ammo->has_flag( flag_CASING ) || !ammo->is_ammo() ) {
                    continue;
                }
                std::string label = ammo->tname();
                if( const pocket_data *data = pocket->get_pocket_data() ) {
                    const std::string name = data->pocket_name.translated();
                    if( !name.empty() || !data->pocket_id.empty() ) {
                        label = string_format( "%s (%s)", label, name.empty() ? data->pocket_id : name );
                    }
                }
                result.push_back( { nullptr, pocket, { ammo->uid().get_value(), label } } );
                break;
            }
        }
    }
    return result;
}

} // namespace

std::vector<item_location> unload_targets( const item_location &root )
{
    if( !root ) {
        return {};
    }
    std::vector<item_location> result{ root };
    if( !root->is_container() ) {
        item_location mutable_root = root;
        for( item *mod : mutable_root->gunmods() ) {
            if( ( mod->is_gun() && !mod->has_flag( flag_NO_UNLOAD ) &&
                  ( mod->magazine_current() || mod->ammo_remaining() > 0 || mod->casings_count() > 0 ) ) ||
                ( mod->has_flag( flag_BRASS_CATCHER ) && !mod->is_container_empty() ) ) {
                result.emplace_back( root, mod );
            }
        }
    }
    return result;
}

std::vector<unload_source_option> unload_sources( item &target )
{
    std::vector<unload_source_option> result;
    if( !target.is_container() && ( !target.is_magazine() || target.uses_firing_requirements() ) ) {
        for( const pocket_source &source : pocket_sources( target ) ) {
            result.push_back( source.option );
        }
    }
    return result;
}

std::optional<unload_selection> query_unload_selection( const item_location &root,
        bool all_sources )
{
    const auto targets = unload_targets( root );
    if( targets.empty() ) {
        return std::nullopt;
    }
    int picked = 0;
    if( targets.size() > 1 ) {
        std::vector<std::string> labels;
        for( const item_location &target : targets ) {
            labels.push_back( target->tname() );
        }
        picked = uilist( _( "Unload what?" ), labels );
        if( picked < 0 || static_cast<size_t>( picked ) >= targets.size() ) {
            return std::nullopt;
        }
    }
    unload_selection result{ targets[picked], {} };
    const auto sources = unload_sources( *result.target );
    if( sources.size() > 1 && !all_sources ) {
        std::vector<std::string> labels;
        for( const unload_source_option &source : sources ) {
            labels.push_back( source.label );
        }
        labels.emplace_back( _( "All" ) );
        picked = uilist( _( "Unload which source?" ), labels );
        if( picked < 0 || static_cast<size_t>( picked ) > sources.size() ) {
            return std::nullopt;
        }
        if( static_cast<size_t>( picked ) < sources.size() ) {
            result.sources.push_back( sources[picked].identity );
            return result;
        }
    }
    for( const unload_source_option &source : sources ) {
        result.sources.push_back( source.identity );
    }
    return result;
}

bool valid_unload_selection( const item_location &root, const unload_selection &selection )
{
    const auto targets = unload_targets( root );
    if( std::find( targets.begin(), targets.end(), selection.target ) == targets.end() ) {
        return false;
    }
    item_location target = selection.target;
    const auto sources = unload_sources( *target );
    if( sources.empty() != selection.sources.empty() ) {
        return false;
    }
    std::set<int64_t> seen;
    for( int64_t identity : selection.sources ) {
        if( !seen.insert( identity ).second || std::none_of( sources.begin(), sources.end(),
        [identity]( const unload_source_option & option ) {
        return option.identity == identity;
    } ) ) {
            return false;
        }
    }
    return true;
}

void visit_unload_liquids( const unload_selection &selection,
                           const std::function<void( int64_t, const item & )> &visit )
{
    if( !selection.target ) {
        return;
    }
    item_location location = selection.target;
    item &target = *location;
    const auto inspect = [&]( item * ammo ) {
        if( ammo->made_of( phase_id::LIQUID ) && !ammo->has_flag( flag_CASING ) ) {
            visit( ammo->uid().get_value(), *ammo );
        }
    };
    if( target.is_container() || ( target.is_magazine() && !target.uses_firing_requirements() ) ||
        target.has_flag( flag_BRASS_CATCHER ) ) {
        for( pocket_type type : {
                 pocket_type::CONTAINER, pocket_type::MAGAZINE_WELL, pocket_type::MAGAZINE
             } ) {
            for( item *ammo : target.all_items_top( type, true ) ) {
                inspect( ammo );
            }
        }
    } else if( !selection.sources.empty() ) {
        for( const pocket_source &source : pocket_sources( target ) ) {
            if( source.integral && std::find( selection.sources.begin(), selection.sources.end(),
                                              source.option.identity ) != selection.sources.end() ) {
                for( item *ammo : source.integral->all_items_top() ) {
                    inspect( ammo );
                }
            }
        }
    } else if( target.ammo_remaining() > 0 ) {
        item ammo( target.ammo_current(), calendar::turn, target.ammo_remaining() );
        if( ammo.made_of( phase_id::LIQUID ) ) {
            visit( target.uid().get_value(), ammo );
        }
    }
}

void unload_liquid_choice::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "source", source );
    out.member( "kind", static_cast<int>( kind ) );
    out.member( "container", container );
    out.member( "position", position );
    out.member( "vehicle", vehicle );
    out.member( "tank", tank );
    out.end_object();
}

void unload_liquid_choice::deserialize( const JsonObject &object )
{
    object.read( "source", source, true );
    kind = static_cast<liquid_dest>( object.get_int( "kind" ) );
    object.read( "container", container, true );
    object.read( "position", position, true );
    object.read( "vehicle", vehicle, true );
    object.read( "tank", tank, true );
}

bool receive_unloaded_item( Character &who, item &output, const item &target,
                            const item *original, const unload_liquid_choices &choices )
{
    if( !choices || !output.made_of( phase_id::LIQUID ) ) {
        return who.add_or_drop_with_msg( output, output.count_by_charges() && output.charges > 1,
                                         &target, original );
    }
    const int64_t identity = ( original ? original : &target )->uid().get_value();
    const auto selected = std::find_if( choices->begin(), choices->end(),
    [identity]( const unload_liquid_choice & choice ) {
        return choice.source == identity;
    } );
    if( selected == choices->end() || selected->kind == LD_NULL ) {
        return false;
    }
    liquid_dest_opt destination;
    destination.dest_opt = selected->kind;
    std::optional<int> tank;
    map &here = get_map();
    if( selected->kind == LD_ITEM ) {
        destination.item_loc = resolve_item_source( who, here, selected->container );
        if( !destination.item_loc || &*destination.item_loc == &target ||
            target.has_item( *destination.item_loc ) || destination.item_loc->has_item( target ) ) {
            return false;
        }
    } else if( selected->kind == LD_VEH ) {
        for( const tripoint_bub_ms &pos : here.points_in_radius( who.pos_bub(), 1 ) ) {
            const optional_vpart_position at = here.veh_at( pos );
            if( !at || at->vehicle().uid().get_value() != selected->vehicle ) {
                continue;
            }
            vehicle &veh = at->vehicle();
            for( const vpart_reference &part : veh.get_all_parts() ) {
                if( part.part().get_base().uid().get_value() == selected->tank ) {
                    destination.veh = &veh;
                    tank = part.part_index();
                    break;
                }
            }
            break;
        }
        if( !tank ) {
            return false;
        }
    } else if( selected->kind == LD_GROUND || selected->kind == LD_KEG ) {
        destination.pos = here.get_bub( selected->position );
        if( destination.pos.z() != who.pos_bub().z() ||
            rl_dist( destination.pos, who.pos_bub() ) > 1 ) {
            return false;
        }
    } else {
        return false;
    }
    liquid_handler::transfer_liquid( who, output, destination, tank );
    return output.charges <= 0;
}

bool unload_ammo_pocket( Character &who, item &target, item_pocket &pocket,
                         const std::function<bool( item &, const item & )> &receive )
{
    const auto pockets = target.get_pockets( []( const item_pocket & p ) {
        return p.is_type( pocket_type::MAGAZINE );
    } );
    if( !receive || std::find( pockets.begin(), pockets.end(), &pocket ) == pockets.end() ) {
        return false;
    }

    const auto actor_lifetime = who.get_safe_reference();
    const auto target_lifetime = target.get_safe_reference();
    int moved = 0;
    std::optional<item> representative;
    bool complete = true;
    for( item *source : pocket.all_items_top() ) {
        if( source->has_flag( flag_CASING ) || !source->is_ammo() ) {
            continue;
        }
        const auto source_lifetime = source->get_safe_reference();
        const int quantity = source->count_by_charges() ? source->charges : 1;
        if( quantity <= 0 ) {
            continue;
        }
        item dropped = *source;
        if( target.is_filthy() ) {
            dropped.set_flag( flag_FILTHY );
        }
        const bool accepted = receive( dropped, *source );
        if( !actor_lifetime || !target_lifetime || !source_lifetime ) {
            return false;
        }
        const int transferred = accepted ? quantity : source->count_by_charges() ?
                                std::clamp( quantity - dropped.charges, 0, quantity ) : 0;
        if( transferred > 0 ) {
            moved += transferred;
            if( !representative ) {
                representative.emplace( std::move( dropped ) );
            }
            // Settle each transfer immediately: a later cancellation must not
            // leave a second copy of ammo already placed by the receiver.
            if( transferred == quantity ) {
                pocket.remove_item( *source );
            } else {
                source->charges -= transferred;
            }
        }
        if( !accepted ) {
            complete = false;
            break;
        }
    }
    if( moved > 0 ) {
        // item_reload_cost clamps to the supplied stack's charges. The stack
        // passed to the receiver may now be empty or only a partial remainder.
        representative->charges = moved;
        who.mod_moves( -who.item_reload_cost( target, *representative, moved ) / 2 );
        pocket.on_contents_changed();
        target.on_contents_changed();
        who.invalidate_weight_carried_cache();
    }
    return complete;
}

bool start_item_unload( Character &who, item_location loc, const unload_selection &selection,
                        bool bypass_activity, const item_location &new_container,
                        const unload_liquid_choices &choices )
{
    if( !valid_unload_selection( loc, selection ) || ( choices && new_container ) ) {
        return false;
    }
    item &it = *loc;
    drop_locations locs;
    // Unload a container consuming moves per item successfully removed
    if( it.is_container() ) {
        if( it.empty() ) {
            add_msg( m_info, _( "The %s is already empty!" ), it.tname() );
            return false;
        }
        if( !it.can_unload() ) {
            add_msg( m_info, _( "The item can't be unloaded in its current state!" ) );
            return false;
        }

        int moves = 0;
        item *prev_contained = nullptr;

        for( pocket_type ptype : {
                 pocket_type::CONTAINER,
                 pocket_type::MAGAZINE_WELL,
                 pocket_type::MAGAZINE
             } ) {

            for( item *contained : it.all_items_top( ptype, true ) ) {
                if( new_container == item_location::nowhere ) {
                    if( prev_contained && prev_contained->stacks_with( *contained ) ) {
                        moves += std::max( who.item_handling_cost( *contained, true, 0, -1, true ), 1 );
                    } else {
                        moves += who.item_handling_cost( *contained );
                    }
                    prev_contained = contained;
                } else {
                    // redirect to insert actor
                    const int count = contained->count_by_charges() ? contained->charges : 1;
                    locs.emplace_back( item_location( loc, contained ), count );
                }
            }

        }
        if( new_container == item_location::nowhere ) {
            who.assign_activity( unload_activity_actor( moves, loc, choices ) );
        } else if( !locs.empty() ) {
            who.assign_activity( insert_item_activity_actor( new_container, locs, true ) );
        }

        return true;
    }

    item_location targloc = selection.target;
    item *target = targloc.get_item();
    const auto receive = [&]( item & output, const item *original = nullptr ) {
        return receive_unloaded_item( who, output, *target, original, choices );
    };

    // Next check for any reasons why the item cannot be unloaded
    if( !target->has_flag( flag_BRASS_CATCHER ) ) {
        if( !target->is_magazine() && !target->uses_magazine() ) {
            add_msg( m_info, _( "You can't unload a %s!" ), target->tname() );
            return false;
        }

        if( target->has_flag( flag_NO_UNLOAD ) ) {
            if( target->has_flag( flag_RECHARGE ) || target->has_flag( flag_USE_UPS ) ) {
                add_msg( m_info, _( "You can't unload a rechargeable %s!" ), target->tname() );
            } else {
                add_msg( m_info, _( "You can't unload a %s!" ), target->tname() );
            }
            return false;
        }

        if( !target->magazine_current() && target->ammo_remaining( ) <= 0 &&
            target->casings_count() <= 0 ) {
            if( target->is_tool() ) {
                add_msg( m_info, _( "Your %s isn't charged." ), target->tname() );
            } else {
                add_msg( m_info, _( "Your %s isn't loaded." ), target->tname() );
            }
            return false;
        }
    }

    target->casings_handle( [&]( item & e ) {
        return who.i_add_or_drop( e );
    } );

    who.invalidate_weight_carried_cache();

    // is_magazine() includes guns/tools with integral MAGAZINE pockets. Their
    // multi-source selection must not be preempted by ordinary magazine unload.
    if( target->is_magazine() && !target->uses_firing_requirements() ) {
        if( bypass_activity ) {
            unload_activity_actor::unload( who, targloc, choices );
        } else {
            int mv = 0;
            for( const item *content : target->all_items_top() ) {
                // We use the same cost for both reloading and unloading
                mv += who.item_reload_cost( it, *content, content->charges );
            }
            if( it.is_ammo_belt() ) {
                // Disassembling ammo belts is easier than assembling them
                mv /= 2;
            }
            who.assign_activity( unload_activity_actor( mv, targloc, choices ) );
        }
        return true;

    } else if( !selection.sources.empty() ) {
        const auto sources = pocket_sources( *target );
        for( const pocket_source &source : sources ) {
            if( std::find( selection.sources.begin(), selection.sources.end(),
                           source.option.identity ) == selection.sources.end() ) {
                continue;
            }
            if( source.magazine ) {
                item *magazine = source.magazine;
                if( !receive( *magazine, magazine ) ) {
                    return false;
                }
                who.mod_moves( -who.item_reload_cost( *target, *magazine, -1 ) / 2 );
                target->remove_items_with( [magazine]( const item & candidate ) {
                    return &candidate == magazine;
                } );
            } else if( !unload_ammo_pocket( who, *target, *source.integral,
            [&]( item & output, const item & original ) {
            return receive( output, &original );
            } ) ) {
                return false;
            }
        }

    } else if( target->ammo_remaining( ) ) {
        int qty = target->ammo_remaining( );

        // Construct a new ammo item and try to drop it
        item ammo( target->ammo_current(), calendar::turn, qty );
        if( target->is_filthy() ) {
            ammo.set_flag( flag_FILTHY );
        }

        if( ammo.made_of_from_type( phase_id::LIQUID ) ) {
            if( !receive( ammo ) ) {
                qty -= ammo.charges; // only handled part (or none) of the liquid
            }
            if( qty <= 0 ) {
                return false; // no liquid was moved
            }

        } else if( !receive( ammo ) ) {
            return false;
        }

        // If successful remove appropriate qty of ammo consuming half as much time as required to load it
        who.mod_moves( -who.item_reload_cost( *target, ammo, qty ) / 2 );

        target->ammo_set( target->ammo_current(), target->ammo_remaining( ) - qty );
    } else if( target->has_flag( flag_BRASS_CATCHER ) ) {
        // Container completion may relocate or invalidate the source. Do not
        // access its gunmod pointer after handling changed contents.
        who.recoil = MAX_RECOIL;
        unload_activity_actor::unload( who, targloc, choices );
        return true;
    }

    // Turn off any active tools
    if( target->is_tool() && target->active && target->ammo_remaining( ) == 0 ) {
        target->deactivate( &who );
    }

    add_msg( _( "You unload your %s." ), target->tname() );

    if( it.has_flag( flag_MAG_DESTROY ) && it.ammo_remaining( ) == 0 ) {
        loc.remove_item();
    }

    who.recoil = MAX_RECOIL;

    return true;
}
