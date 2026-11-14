#include "vehicle_appliance.h"

#include <algorithm>
#include <string>
#include <vector>

#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "crafting.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_stack.h"
#include "itype.h"
#include "json.h"
#include "map.h"
#include "mp_inventory_activity.h"
#include "pocket_type.h"
#include "string_formatter.h"
#include "temp_crafting_inventory.h"
#include "translations.h"
#include "uilist.h"
#include "veh_type.h"
#include "veh_utils.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "vpart_range.h"

namespace
{
const itype_id water( "water" );
const itype_id clean_water( "water_clean" );
const flag_id filthy( "FILTHY" );
const flag_id unpacked( "NO_PACKED" );
const flag_id detergent_flag( "DETERGENT" );

std::string appliance_kind( const vehicle_part &part )
{
    for( const char *flag : {
             "AUTOCLAVE", "WASHING_MACHINE", "DISHWASHER", "MWS", "AUTO_COOKER", "NL_BOILER"
         } ) {
        if( part.info().has_flag( flag ) ) {
            return flag;
        }
    }
    return {};
}

int appliance_index( const vehicle &target, const tripoint_abs_ms &position, int64_t id )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( !part.part().removed && part.part().is_available() && part.pos_abs() == position &&
            part.part().get_base().uid().get_value() == id && !appliance_kind( part.part() ).empty() ) {
            return part.part_index();
        }
    }
    return -1;
}

bool needs_detergent( const std::string &kind )
{
    return kind == "WASHING_MACHINE" || kind == "DISHWASHER";
}

bool cookable( const item &food )
{
    if( food.is_comestible() && !food.get_comestible()->cook_result.is_null() &&
        !food.get_comestible()->cook_result.is_empty() ) {
        return true;
    }
    for( const item *inside : food.all_items_top( pocket_type::CONTAINER ) ) {
        if( cookable( *inside ) ) {
            return true;
        }
    }
    return false;
}

void reset_cooking( item &food )
{
    if( food.is_comestible() && !food.get_comestible()->cook_result.is_null() &&
        !food.get_comestible()->cook_result.is_empty() ) {
        food.set_var( "cook_energy_done", "0" );
    }
    for( item *inside : food.all_items_top( pocket_type::CONTAINER ) ) {
        reset_cooking( *inside );
    }
}

// Native content and supply rules, shared by menu preparation and execution.
std::string start_failure( map &here, vehicle &target, vehicle_part &part )
{
    const std::string kind = appliance_kind( part );
    vehicle_stack items = target.get_items( part );
    if( kind == "AUTOCLAVE" ) {
        if( items.empty() ) {
            return _( "The autoclave is empty; there's no point in starting it." );
        }
        if( target.fuel_left( here, water ) < 8 && target.fuel_left( here, clean_water ) < 8 ) {
            return string_format(
                       _( "You need 8 charges of water in the tanks of the %s for the autoclave to run." ), target.name );
        }
        if( std::any_of( items.begin(), items.end(), []( const item & i ) {
        return i.has_flag( filthy );
        } ) ) {
            return _( "You need to remove all filthy items from the autoclave to start the sterilizing cycle." );
        }
        if( !std::all_of( items.begin(), items.end(), []( const item & i ) {
        return i.is_bionic();
        } ) ) {
            return _( "Only CBMs can be sterilized in an autoclave." );
        }
        if( std::any_of( items.begin(), items.end(), []( const item & i ) {
        return i.has_flag( unpacked );
        } ) ) {
            return _( "You should put your CBMs in autoclave pouches to keep them sterile." );
        }
    } else if( needs_detergent( kind ) ) {
        const bool washing = kind == "WASHING_MACHINE";
        if( items.empty() ) {
            return washing ? _( "The washing machine is empty; there's no point in starting it." ) :
                   _( "The dishwasher is empty, there's no point in starting it." );
        }
        if( target.fuel_left( here, water ) < 24 && target.fuel_left( here, clean_water ) < 24 ) {
            return string_format( washing ?
                                  _( "You need 24 charges of water in the tanks of the %s to fill the washing machine." ) :
                                  _( "You need 24 charges of water in the tanks of the %s to fill the dishwasher." ), target.name );
        }
        if( !std::all_of( items.begin(), items.end(), []( const item & i ) {
        return i.has_flag( filthy );
        } ) ) {
            return washing ?
                   _( "You need to remove all non-filthy items from the washing machine to start the washing program." )
                   :
                   _( "You need to remove all non-filthy items from the dishwasher to start the washing program." );
        }
        if( washing && std::any_of( items.begin(), items.end(), []( const item & i ) {
        return i.is_bionic();
        } ) ) {
            return _( "CBMs can't be cleaned in a washing machine.  You need to remove them." );
        }
        if( !washing ) {
            std::string soft;
            for( const item &i : items ) {
                if( i.is_soft() ) {
                    soft += " " + i.tname();
                }
            }
            if( !soft.empty() ) {
                return _( "Soft items can't be cleaned in a dishwasher; you should use a washing machine for that.  You need to remove them:" )
                       + soft;
            }
        }
    } else if( kind == "AUTO_COOKER" ) {
        if( !std::any_of( items.begin(), items.end(), cookable ) ) {
            return _( "The electric cooker has no raw food that can be automatically cooked." );
        }
        if( target.connected_battery_power_level( here ).first <= 0 ) {
            return _( "The electric cooker has no power." );
        }
    }
    return {};
}

std::vector<itype_id> available_detergents( Character &who, const std::string &kind )
{
    const temp_crafting_inventory &inventory = who.crafting_inventory();
    std::vector<itype_id> types;
    for( const item *candidate : inventory.items_with( [&]( const item & it ) {
    return it.has_flag( detergent_flag ) && inventory.has_charges( it.typeId(), 5 );
    } ) ) {
        if( ( kind != "DISHWASHER" || candidate->typeId() == itype_id( "detergent" ) ) &&
            std::find( types.begin(), types.end(), candidate->typeId() ) == types.end() ) {
            types.push_back( candidate->typeId() );
        }
    }
    return types;
}
} // namespace

void vehicle_appliance_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "part", part_id );
    out.member( "enabled", enabled );
    if( detergent ) {
        out.member( "detergent", *detergent );
    }
    out.end_object();
}

void vehicle_appliance_selection::deserialize( const JsonObject &data )
{
    data.read( "part", part_id, true );
    data.read( "enabled", enabled, true );
    detergent.reset();
    data.read( "detergent", detergent );
}

bool has_vehicle_appliance( const vehicle &target, const tripoint_abs_ms &position )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( !part.part().removed && part.part().is_available() && part.pos_abs() == position &&
            !appliance_kind( part.part() ).empty() ) {
            return true;
        }
    }
    return false;
}

bool valid_vehicle_appliance_selection( Character &who, map &/*here*/, const vehicle &target,
                                        const tripoint_abs_ms &position, const vehicle_appliance_selection &choice )
{
    const int index = appliance_index( target, position, choice.part_id );
    if( index < 0 ) {
        return false;
    }
    const vehicle_part &part = target.part( index );
    const std::string kind = appliance_kind( part );
    if( kind == "NL_BOILER" && !choice.enabled ) {
        return false;
    }
    if( !needs_detergent( kind ) || !choice.enabled ) {
        return !choice.detergent;
    }
    if( !choice.detergent || !choice.detergent->comp.type.is_valid() ||
        choice.detergent->comp.count != 5 ||
        ( kind == "DISHWASHER" ? choice.detergent->comp.type != itype_id( "detergent" ) :
          !choice.detergent->comp.type->has_flag( detergent_flag ) ) ||
        ( choice.detergent->use_from != usage_from::player &&
          choice.detergent->use_from != usage_from::map &&
          choice.detergent->use_from != usage_from::both ) ) {
        return false;
    }
    if( part.enabled ) {
        return true;
    }
    std::vector<comp_selection<item_comp>> components{ *choice.detergent };
    std::vector<comp_selection<tool_comp>> tools;
    const requirement_data requirements( {}, {}, { { item_comp( choice.detergent->comp.type, 5 ) } } );
    return validate_requirement_selection( who, requirements, components, tools );
}

std::optional<vehicle_control_selection> query_vehicle_appliance( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, int64_t part_id )
{
    if( !vehicle_control_accessible( who, here, target, position, "appliance" ) ) {
        return std::nullopt;
    }
    if( part_id == 0 ) {
        std::vector<int64_t> choices;
        uilist menu;
        menu.title = _( "Use installed appliance" );
        for( const vpart_reference &part : target.get_all_parts() ) {
            if( !part.part().removed && part.part().is_available() && part.pos_abs() == position &&
                !appliance_kind( part.part() ).empty() ) {
                menu.addentry( choices.size(), true, MENU_AUTOASSIGN, part.part().name() );
                choices.push_back( part.part().get_base().uid().get_value() );
            }
        }
        menu.query();
        if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= choices.size() ) {
            return std::nullopt;
        }
        part_id = choices[menu.ret];
    }
    const int index = appliance_index( target, position, part_id );
    if( index < 0 ) {
        return std::nullopt;
    }
    vehicle_part &part = target.part( index );
    const std::string kind = appliance_kind( part );
    vehicle_appliance_selection choice;
    choice.part_id = part_id;
    choice.enabled = kind == "NL_BOILER" || !part.enabled;
    if( choice.enabled ) {
        const std::string failure = start_failure( here, target, part );
        if( !failure.empty() ) {
            who.add_msg_if_player( m_bad, failure );
            return std::nullopt;
        }
        if( needs_detergent( kind ) ) {
            const auto types = available_detergents( who, kind );
            if( types.empty() ) {
                who.add_msg_if_player( m_bad, kind == "WASHING_MACHINE" ?
                                       _( "You need 5 charges of a detergent for the washing machine." ) :
                                       _( "You need 5 charges of a detergent for the dishwasher." ) );
                return std::nullopt;
            }
            size_t selected = 0;
            if( types.size() > 1 ) {
                uilist menu;
                menu.text = _( "Use what detergent?" );
                for( size_t i = 0; i < types.size(); ++i ) {
                    menu.addentry( i, true, MENU_AUTOASSIGN, item::nname( types[i] ) );
                }
                menu.query();
                if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= types.size() ) {
                    return std::nullopt;
                }
                selected = menu.ret;
            }
            temp_crafting_inventory nearby;
            nearby.form_from_map( who.pos_bub(), pickup_range, &who );
            choice.detergent = who.select_item_component( { item_comp( types[selected], 5 ) }, 1,
                               nearby, true, is_crafting_component );
            if( choice.detergent->use_from == usage_from::cancel ) {
                return std::nullopt;
            }
        }
    }
    auto request = query_vehicle_control( who, here, target, position, "appliance" );
    if( request ) {
        request->appliance = choice;
    }
    return request;
}

bool execute_vehicle_appliance( Character &who, map &here, vehicle &target,
                                const tripoint_abs_ms &position, const vehicle_appliance_selection &choice )
{
    if( !valid_vehicle_appliance_selection( who, here, target, position, choice ) ) {
        return false;
    }
    const int index = appliance_index( target, position, choice.part_id );
    vehicle_part &initial_part = target.part( index );
    const std::string kind = appliance_kind( initial_part );
    if( kind != "NL_BOILER" && initial_part.enabled == choice.enabled ) {
        return true;
    }
    if( !choice.enabled ) {
        initial_part.enabled = false;
        if( kind == "AUTOCLAVE" ) {
            who.add_msg_if_player( m_bad,
                                   _( "You turn the autoclave off before it's finished the program, and open its door." ) );
        } else if( kind == "WASHING_MACHINE" ) {
            who.add_msg_if_player( m_bad,
                                   _( "You turn the washing machine off before it's finished its cycle, and open its lid." ) );
        } else if( kind == "DISHWASHER" ) {
            who.add_msg_if_player( m_bad,
                                   _( "You turn the dishwasher off before it's finished its cycle, and open its lid." ) );
        } else if( kind == "MWS" ) {
            who.add_msg_if_player( m_bad,
                                   _( "You switch off the sensor array before it is finished its recording." ) );
        } else {
            who.add_msg_if_player( m_bad, _( "You turn off the electric cooker." ) );
        }
        return true;
    }
    const std::string failure = start_failure( here, target, initial_part );
    if( !failure.empty() ) {
        who.add_msg_if_player( m_bad, failure );
        return false;
    }
    if( choice.detergent ) {
        const character_action_guard lifetime( who );
        const int64_t vehicle_id = target.uid().get_value();
        who.consume_items( *choice.detergent, 1, is_crafting_component );
        if( !lifetime || vehicle::find_vehicle_by_uid( here, vehicle_id ) != &target ||
            appliance_index( target, position, choice.part_id ) != index ) {
            return false;
        }
    }
    vehicle_part &part = target.part( index );
    vehicle_stack items = target.get_items( part );
    if( kind == "NL_BOILER" ) {
        if( g->get_dimension_prefix() != dimension_id( "netherum_labyrinth_safehouse" ) ) {
            who.add_msg_if_player( m_bad, _( "You turn the crank and nothing happens." ) );
            return false;
        }
        units::mass weight = 0_gram;
        // Erasing while iterating invalidates the current stack iterator.
        while( !items.empty() ) {
            item &fuel = *items.begin();
            weight += fuel.weight();
            target.remove_item( part, &fuel );
        }
        target.charge_battery( here, weight / 10_gram, false );
        who.add_msg_if_player( m_good,
                               _( "You turn the crank and the combustion chamber flashes, leaving behind not but an acrid smell." ) );
        return true;
    }
    if( kind == "MWS" && items.empty() ) {
        target.add_item( here, part, item( itype_id( "mws_weather_data_incomplete" ),
                                           calendar::turn_zero ) );
    }
    for( item &i : items ) {
        if( kind == "AUTO_COOKER" ) {
            reset_cooking( i );
        } else {
            i.set_age( 0_turns );
        }
    }
    if( kind == "AUTOCLAVE" || needs_detergent( kind ) ) {
        const int amount = kind == "AUTOCLAVE" ? 8 : 24;
        target.drain( here, target.fuel_left( here, water ) >= amount ? water : clean_water, amount );
    }
    part.enabled = true;
    if( kind == "AUTOCLAVE" ) {
        who.add_msg_if_player( m_good, _( "You turn the autoclave on and it starts its cycle." ) );
    } else if( kind == "WASHING_MACHINE" ) {
        who.add_msg_if_player( m_good,
                               _( "You pour some detergent into the washing machine, close its lid, and turn it on.  The washing machine is being filled from the water tanks." ) );
    } else if( kind == "DISHWASHER" ) {
        who.add_msg_if_player( m_good,
                               _( "You pour some detergent into the dishwasher, close its lid, and turn it on.  The dishwasher is being filled from the water tanks." ) );
    } else if( kind == "MWS" ) {
        who.add_msg_if_player( m_good,
                               _( "The printer whirs and the instruments start to spin as you switch on the sensor array." ) );
    } else {
        who.add_msg_if_player( m_good, _( "You turn on the electric cooker." ) );
    }
    return true;
}

void use_vehicle_appliance( Character &who, map &here, vehicle &target, int part )
{
    const auto request = query_vehicle_appliance( who, here, target,
                         target.abs_part_pos( target.part( part ) ),
                         target.part( part ).get_base().uid().get_value() );
    if( request && !cata_mp::client_vehicle_control( *request ) ) {
        execute_vehicle_control( who, here, *request );
    }
}

void add_vehicle_appliance_menu( veh_menu &menu, map &here, vehicle &target,
                                 const tripoint_abs_ms &position )
{
    struct entry {
        const char *flag;
        const char *hotkey;
        std::string on;
        std::string off;
    };
    const entry entries[] = {
        { "AUTOCLAVE", "TOGGLE_AUTOCLAVE", _( "Activate the autoclave (1.5 hours)" ), _( "Deactivate the autoclave" ) },
        { "WASHING_MACHINE", "TOGGLE_WASHING_MACHINE", _( "Activate the washing machine (1.5 hours)" ), _( "Deactivate the washing machine" ) },
        { "DISHWASHER", "TOGGLE_DISHWASHER", _( "Activate the dishwasher (1.5 hours)" ), _( "Deactivate the dishwasher" ) },
        { "MWS", "TOGGLE_MWS", _( "Activate the recording subroutine (1 hour)" ), _( "Deactivate the sensor array" ) },
        { "AUTO_COOKER", "TOGGLE_AUTO_COOKER", _( "Activate the electric cooker" ), _( "Deactivate the electric cooker" ) },
        { "NL_BOILER", "", _( "Activate the boiler" ), _( "Activate the boiler" ) }
    };
    for( const entry &option : entries ) {
        for( const vpart_reference &part : target.get_avail_parts( option.flag ) ) {
            if( part.pos_abs() != position ) {
                continue;
            }
            const int64_t vehicle_id = target.uid().get_value();
            const int64_t part_id = part.part().get_base().uid().get_value();
            auto &entry = menu.add( part.part().enabled ? option.off : option.on )
                          .skip_locked_check().skip_theft_check();
            if( *option.hotkey ) {
                entry.hotkey( option.hotkey );
            }
            entry.on_submit( [&here, vehicle_id, part_id, position] {
                vehicle *current = vehicle::find_vehicle_by_uid( here, vehicle_id );
                if( !current )
                {
                    return;
                }
                Character &who = get_player_character();
                const auto request = query_vehicle_appliance( who, here, *current, position, part_id );
                if( request && !cata_mp::client_vehicle_control( *request ) )
                {
                    execute_vehicle_control( who, here, *request );
                }
            } );
            break;
        }
    }
}
