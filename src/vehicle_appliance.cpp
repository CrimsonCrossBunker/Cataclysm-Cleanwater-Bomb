#include "vehicle_appliance.h"

#include <algorithm>
#include <cmath>
#include <initializer_list>
#include <string>
#include <utility>
#include <vector>

#include "calendar.h"
#include "cata_utility.h"
#include "character.h"
#include "character_action_guard.h"
#include "crafting.h"
#include "flag.h"
#include "game.h"
#include "handle_liquid.h"
#include "item.h"
#include "item_location.h"
#include "item_stack.h"
#include "itype.h"
#include "json.h"
#include "map.h"
#include "mapdata.h"
#include "mp_client_conn.h"
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
#include "weather.h"
#include "weather_gen.h"

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


bool is_hvac_indoors( const map &here, const tripoint_bub_ms &position )
{
    return here.inbounds( position ) &&
           ( position.z() < 0 || here.has_flag( ter_furn_flag::TFLAG_INDOORS, position ) );
}

void set_split_hvac_link( item &unit, const tripoint_abs_ms &outdoor, const itype_id &material,
                          int quantity )
{
    unit.set_var( "hvac_link", outdoor );
    unit.set_var( "hvac_link_material", material.str() );
    unit.set_var( "hvac_link_quantity", quantity );
}

namespace
{
const tripoint_abs_ms no_hvac_link( tripoint::min );
constexpr int link_range = 8;
constexpr int split_pipe_span = 2;
constexpr int hose_span = 4;

int hvac_part_at( const vehicle &target, const tripoint_abs_ms &p, const std::string &flag )
{
    for( const vpart_reference &part : target.get_avail_parts( flag ) ) {
        if( part.pos_abs() == p ) {
            return part.part_index();
        }
    }
    return -1;
}

bool hvac_power( map &here, vehicle &target, int watts )
{
    const int energy_kj = ( watts * 60 + 999 ) / 1000;
    return energy_kj > 0 && !cata_mp::is_client_mode() &&
           target.battery_left( here ) >= energy_kj &&
           target.discharge_battery( here, energy_kj ) == 0;
}

int hvac_minute()
{
    return to_minutes<int>( calendar::turn - calendar::turn_zero );
}

double update_boiler( map &here, vehicle &target, item &boiler, double ambient )
{
    const int now = hvac_minute();
    const int last = static_cast<int>( boiler.get_var( "hvac_minute", now - 1.0 ) );
    const double liters = boiler.get_var( "hvac_water_l", 0.0 );
    double water_c = boiler.get_var( "hvac_water_c", ambient );
    if( last == now || cata_mp::is_client_mode() ) {
        return water_c;
    }
    const int elapsed = std::max( 0, now - last );
    water_c = ambient + ( water_c - ambient ) * std::exp( -elapsed / 240.0 );
    const bool boil = boiler.get_var( "hvac_mode", 0.0 ) == 2;
    const double target_c = boil ? 100 : 75;
    if( elapsed > 0 && liters > 0 && boiler.get_var( "hvac_mode", 0.0 ) != 0 &&
        water_c < target_c - 0.01 && hvac_power( here, target, 4500 ) ) {
        water_c = std::min( target_c, water_c + 4500.0 * 60 / ( liters * 4184 ) );
        if( boil && water_c >= 100 ) {
            boiler.set_var( "hvac_clean", 1 );
            boiler.set_var( "hvac_mode", 0 );
        }
    }
    boiler.set_var( "hvac_minute", now );
    boiler.set_var( "hvac_water_c", water_c );
    return water_c;
}

void choose_thermostat( item &unit, bool cabin )
{
    const int old_setpoint = static_cast<int>( unit.get_var( "hvac_setpoint", 22.0 ) );
    uilist modes;
    modes.title = string_format( _( "Climate control (set to %d C)" ), old_setpoint );
    modes.addentry( 0, true, 'o', _( "Off" ) );
    modes.addentry( 1, true, 'c', _( "Cooling" ) );
    modes.addentry( 2, true, 'h', _( "Heating" ) );
    modes.addentry( 3, true, 'e', _( "Energy saver (wider temperature range)" ) );
    if( cabin ) {
        modes.addentry( 4, true, 'a', _( "Automatic" ) );
    }
    modes.query();
    if( modes.ret < 0 ) {
        return;
    }
    if( modes.ret == 0 ) {
        unit.set_var( "hvac_mode", 0 );
        return;
    }
    uilist setpoints;
    setpoints.title = _( "Set target temperature" );
    for( int c = 16; c <= 30; ++c ) {
        setpoints.addentry( c, true, 0, string_format( _( "%d C" ), c ) );
    }
    setpoints.selected = std::clamp( old_setpoint, 16, 30 ) - 16;
    setpoints.query();
    if( setpoints.ret >= 16 ) {
        unit.set_var( "hvac_mode", modes.ret );
        unit.set_var( "hvac_setpoint", setpoints.ret );
    }
}

void choose_hvac_link( Character &who, map &here, const tripoint_bub_ms &source,
                      item &unit, bool radiator )
{
    if( !radiator && unit.has_var( "hvac_link" ) ) {
        return;
    }
    if( !radiator && !is_hvac_indoors( here, source ) ) {
        who.add_msg_if_player( _( "Install the indoor air conditioner inside before connecting it." ) );
        return;
    }

    uilist choices;
    choices.title = radiator ? _( "Connect radiator to boiler" ) : _( "Connect indoor and outdoor units" );
    choices.desc_enabled = !radiator;
    if( radiator ) {
        choices.addentry( 0, true, 'd', _( "Disconnect" ) );
    }
    std::vector<tripoint_abs_ms> endpoints;
    for( const tripoint_bub_ms &p : here.points_in_radius( source, link_range ) ) {
        if( !here.inbounds( p ) || p == source || ( !radiator && is_hvac_indoors( here, p ) ) ) {
            continue;
        }
        const optional_vpart_position v = here.veh_at( p );
        const tripoint_abs_ms abs = here.get_abs( p );
        if( v && hvac_part_at( v->vehicle(), abs,
                              radiator ? "HYDRONIC_BOILER" : "SPLIT_HVAC_OUTDOOR" ) >= 0 ) {
            endpoints.push_back( abs );
            const int index = static_cast<int>( endpoints.size() );
            const int distance = square_dist( source.xy(), p.xy() );
            const std::string label = string_format( _( "%s (%d tiles away)" ), v->vehicle().name,
                                      distance );
            if( radiator ) {
                choices.addentry( index, true, 0, label );
            } else {
                choices.addentry_desc( index, true, 0, label,
                                       string_format( _( "Use %d rigid pipe section(s) or %d hose length(s)." ),
                                               divide_round_up( distance, split_pipe_span ),
                                               divide_round_up( distance, hose_span ) ) );
            }
        }
    }
    if( choices.entries.empty() ) {
        who.add_msg_if_player( _( "No unit installed outdoors is in range." ) );
        return;
    }

    choices.query();
    if( radiator && choices.ret == 0 ) {
        unit.erase_var( "hvac_link" );
    } else if( choices.ret > 0 && static_cast<std::size_t>( choices.ret ) <= endpoints.size() ) {
        std::vector<std::pair<itype_id, int>> materials = {
            { itype_id( "pipe" ), radiator ? 1 : split_pipe_span },
            { itype_id( "hose" ), hose_span },
            { itype_id( "makeshift_hose" ), hose_span },
            { itype_id( "hose_garden" ), hose_span }
        };
        if( !radiator ) {
            materials.insert( materials.begin() + 1, {
                { itype_id( "cu_pipe" ), split_pipe_span },
                { itype_id( "hd_pipe" ), split_pipe_span },
                { itype_id( "pipe_cpvc" ), split_pipe_span }
            } );
            const item_location wielded = who.get_wielded_item();
            const auto held_material = std::find_if( materials.begin(), materials.end(),
            [&wielded]( const auto &entry ) {
                return wielded && wielded->typeId() == entry.first;
            } );
            if( held_material != materials.end() ) {
                std::iter_swap( materials.begin(), held_material );
            }
        }
        const tripoint_abs_ms &end = endpoints[choices.ret - 1];
        const int distance = square_dist( source.xy(), here.get_bub( end ).xy() );
        for( const auto &[material, span] : materials ) {
            const int quantity = divide_round_up( distance, span );
            if( who.has_amount( material, quantity ) && !who.use_amount( material, quantity ).empty() ) {
                if( radiator ) {
                    unit.set_var( "hvac_link", end );
                } else {
                    set_split_hvac_link( unit, end, material, quantity );
                }
                return;
            }
        }
        who.add_msg_if_player( _( "You need enough pipe or hose to reach that unit." ) );
    }
}

void disconnect_split_hvac( Character &who, item &unit )
{
    if( !unit.has_var( "hvac_link" ) ) {
        return;
    }

    // Old saves only recorded the destination. Recover one pipe from those links.
    const itype_id material( unit.get_var( "hvac_link_material", "pipe" ) );
    const int quantity = static_cast<int>( std::clamp( unit.get_var( "hvac_link_quantity", 1.0 ),
                         0.0, static_cast<double>( link_range ) ) );
    if( material.is_valid() ) {
        for( int remaining = quantity; remaining > 0; --remaining ) {
            item recovered( material );
            if( !who.i_add_or_drop( recovered ) ) {
                unit.set_var( "hvac_link_quantity", remaining );
                who.add_msg_if_player( _( "Make room for the remaining pipe or hose first." ) );
                return;
            }
        }
    }
    unit.erase_var( "hvac_link" );
    unit.erase_var( "hvac_link_material" );
    unit.erase_var( "hvac_link_quantity" );
    unit.erase_var( "hvac_output" );
}

void operate_boiler( Character &who, map &here, vehicle &target, item &boiler )
{
    const double water_c = update_boiler( here, target, boiler,
                                         units::to_celsius( get_weather().temperature ) );
    const item water_sample( water );
    const int per_liter = water_sample.charges_per_volume( units::from_milliliter( 1000 ) );
    if( per_liter <= 0 ) {
        return;
    }
    const double liters = boiler.get_var( "hvac_water_l", 0.0 );
    const int empty = static_cast<int>( ( 40 - liters ) * per_liter + 0.0001 );
    uilist options;
    options.title = string_format( _( "Boiler: %.1f / 40 L at %.1f C" ), liters, water_c );
    options.addentry( 0, true, 'o', _( "Turn off" ) );
    options.addentry( 1, liters > 0, 'h', _( "Heat the radiator loop" ) );
    options.addentry( 2, liters > 0, 'b', _( "Boil the water, then switch off" ) );
    options.addentry( 3, empty > 0, 'f', _( "Add water from carried containers" ) );
    options.addentry( 4, liters > 0, 'd', _( "Draw water into a container" ) );
    options.query();
    if( options.ret >= 0 && options.ret <= 2 ) {
        boiler.set_var( "hvac_mode", options.ret );
    } else if( options.ret == 3 ) {
        int total = 0;
        for( const itype_id &kind : { clean_water, water } ) {
            const int n = std::min( empty - total, who.charges_of( kind ) );
            if( n > 0 && who.use_charges_if_avail( kind, n ) ) {
                total += n;
                if( kind == water ) {
                    boiler.set_var( "hvac_clean", 0 );
                } else if( liters == 0 && total == n ) {
                    boiler.set_var( "hvac_clean", 1 );
                }
            }
        }
        const double added = total / static_cast<double>( per_liter );
        if( added > 0 ) {
            boiler.set_var( "hvac_water_l", liters + added );
            boiler.set_var( "hvac_water_c", ( water_c * liters + 15.0 * added ) / ( liters + added ) );
        }
    } else if( options.ret == 4 ) {
        const int original = static_cast<int>( liters * per_liter + 0.0001 );
        item drawn( boiler.get_var( "hvac_clean", 0.0 ) == 1 ? clean_water : water,
                    calendar::turn, original );
        if( liquid_handler::consume_liquid( drawn, 0 ) ) {
            boiler.set_var( "hvac_water_l", drawn.charges / static_cast<double>( per_liter ) );
            if( drawn.charges == 0 ) {
                boiler.set_var( "hvac_mode", 0 );
            }
        }
    }
}

void add_hvac_menu( veh_menu &menu, map &here, vehicle &target, const tripoint_abs_ms &pos )
{
    const auto add = [&]( const std::string &label, int index, const std::string &role,
    bool enabled = true ) {
        menu.add( label ).enable( enabled ).on_submit( [&here, &target, pos, index, role] {
            if( cata_mp::is_client_mode() ) {
                get_player_character().add_msg_if_player( _( "Climate controls are only available to the host." ) );
                return;
            }
            item_location unit = target.part_base( index );
            if( !unit ) {
                return;
            }
            Character &who = get_player_character();
            if( role == "HYDRONIC_BOILER" ) {
                operate_boiler( who, here, target, *unit );
            } else if( role == "DISCONNECT_SPLIT_HVAC" ) {
                disconnect_split_hvac( who, *unit );
            } else if( role == "SPLIT_HVAC_INDOOR" || role == "HYDRONIC_RADIATOR" ) {
                choose_hvac_link( who, here, here.get_bub( pos ), *unit, role == "HYDRONIC_RADIATOR" );
            } else {
                choose_thermostat( *unit, true );
            }
        } );
    };
    const int split_index = hvac_part_at( target, pos, "SPLIT_HVAC_INDOOR" );
    if( split_index >= 0 ) {
        if( const item_location unit = target.part_base( split_index ) ) {
            const bool linked = unit->has_var( "hvac_link" );
            add( _( "Connect the split air conditioner" ), split_index, "SPLIT_HVAC_INDOOR", !linked );
            if( linked ) {
                add( _( "Disconnect the split air conditioner" ), split_index, "DISCONNECT_SPLIT_HVAC" );
            }
        }
    }
    for( const auto &[role, label] : std::initializer_list<std::pair<std::string, std::string>> {
             { "HYDRONIC_BOILER", _( "Operate water boiler" ) },
             { "HYDRONIC_RADIATOR", _( "Connect the radiator" ) }
         } ) {
        const int index = hvac_part_at( target, pos, role );
        if( index >= 0 ) {
            add( label, index, role );
        }
    }
    for( const vpart_reference &part : target.get_avail_parts( "CABIN_HVAC" ) ) {
        add( _( "Cabin climate control" ), part.part_index(), "CABIN_HVAC" );
        break;
    }
    std::vector<int> closed_windows;
    std::vector<int> open_windows;
    for( const vpart_reference &window : target.get_avail_parts( "CABIN_WINDOW" ) ) {
        ( window.part().open ? open_windows : closed_windows ).push_back( window.part_index() );
    }
    const auto add_windows = [&]( const std::string &label, std::vector<int> indices, bool opening ) {
        if( !indices.empty() ) {
            menu.add( label ).enable( !cata_mp::is_client_mode() )
            .on_submit( [&here, &target, indices = std::move( indices ), opening] {
                for( const int index : indices ) {
                    if( opening ) {
                        target.open( here, index );
                    } else if( target.can_close( index, get_player_character() ) ) {
                        target.close( here, index );
                    }
                }
            } );
        }
    };
    add_windows( _( "Open cabin windows" ), std::move( closed_windows ), true );
    add_windows( _( "Close cabin windows" ), std::move( open_windows ), false );
}
} // namespace

std::optional<int> use_hvac_remote( Character *who, item *, const tripoint_bub_ms & )
{
    if( !who || who->is_npc() || cata_mp::is_client_mode() ) {
        return std::nullopt;
    }
    map &here = get_map();
    uilist choices;
    choices.title = _( "Select an indoor air conditioner" );
    std::vector<item_location> units;
    for( const tripoint_bub_ms &p : here.points_in_radius( who->pos_bub(), link_range ) ) {
        if( !here.inbounds( p ) || !who->sees( here, p ) ) {
            continue;
        }
        const optional_vpart_position v = here.veh_at( p );
        const int index = v ? hvac_part_at( v->vehicle(), here.get_abs( p ), "SPLIT_HVAC_INDOOR" ) : -1;
        if( index >= 0 ) {
            choices.addentry( static_cast<int>( units.size() ), true, 0,
                              string_format( _( "%s (%d tiles away)" ), v->vehicle().name,
                                             square_dist( p.xy(), who->pos_bub().xy() ) ) );
            units.push_back( v->vehicle().part_base( index ) );
        }
    }
    if( units.empty() ) {
        who->add_msg_if_player( _( "No indoor unit is in range." ) );
        return std::nullopt;
    }
    choices.query();
    if( choices.ret >= 0 && static_cast<std::size_t>( choices.ret ) < units.size() && units[choices.ret] ) {
        choose_thermostat( *units[choices.ret], false );
    }
    return 0;
}

double room_appliance_watts( map &here, vehicle &target, const tripoint_bub_ms &position,
                             double outside_c, double room_c )
{
    const tripoint_abs_ms abs = here.get_abs( position );
    const int boiler_index = hvac_part_at( target, abs, "HYDRONIC_BOILER" );
    if( boiler_index >= 0 ) {
        item_location boiler = target.part_base( boiler_index );
        if( boiler ) {
            update_boiler( here, target, *boiler, outside_c );
        }
        return 0;
    }
    if( !is_hvac_indoors( here, position ) ) {
        return 0;
    }
    const int heater_index = hvac_part_at( target, abs, "SPACE_HEATER" );
    if( heater_index >= 0 && target.part( heater_index ).enabled ) {
        return std::max( 0.0, -static_cast<double>( units::to_watt(
                             target.part( heater_index ).info().epower ) ) );
    }
    const int radiator_index = hvac_part_at( target, abs, "HYDRONIC_RADIATOR" );
    const bool radiator = radiator_index >= 0;
    const int index = radiator ? radiator_index : hvac_part_at( target, abs, "SPLIT_HVAC_INDOOR" );
    if( index < 0 ) {
        return 0;
    }
    item_location unit = target.part_base( index );
    if( !unit ) {
        return 0;
    }
    const tripoint_abs_ms link = unit->get_var( "hvac_link", no_hvac_link );
    if( link == no_hvac_link || abs == link || abs.z() != link.z() ||
        square_dist( abs.xy(), link.xy() ) > link_range ) {
        return 0;
    }
    const tripoint_bub_ms connected = here.get_bub( link );
    if( !here.inbounds( connected ) || ( !radiator && is_hvac_indoors( here, connected ) ) ) {
        return 0;
    }
    const optional_vpart_position vp = here.veh_at( connected );
    const int other_index = vp ? hvac_part_at( vp->vehicle(), link,
                            radiator ? "HYDRONIC_BOILER" : "SPLIT_HVAC_OUTDOOR" ) : -1;
    if( other_index < 0 ) {
        return 0;
    }
    vehicle &supply = vp->vehicle();
    item_location other = supply.part_base( other_index );
    if( !other ) {
        return 0;
    }
    const int now = hvac_minute();
    if( unit->get_var( "hvac_minute", -1.0 ) == now || cata_mp::is_client_mode() ) {
        return unit->get_var( "hvac_output", 0.0 );
    }
    double output = 0;
    if( radiator ) {
        const double liters = other->get_var( "hvac_water_l", 0.0 );
        if( liters > 0 ) {
            const double water_c = update_boiler( here, supply, *other, outside_c );
            const double difference = std::max( 0.0, water_c - room_c );
            output = std::min( { 2000.0, 35 * difference, liters * 4184 * difference / 60 } );
            other->set_var( "hvac_water_c", water_c - 60 * output / ( liters * 4184 ) );
        }
    } else {
        const int mode = static_cast<int>( unit->get_var( "hvac_mode", 0.0 ) );
        const double demand = unit->get_var( "hvac_setpoint", 22.0 ) - room_c;
        const double deadband = mode == 3 ? 2.0 : 0.75;
        const bool heat = ( mode == 2 || mode == 3 ) && demand > deadband && outside_c > -12;
        const bool cool = ( mode == 1 || mode == 3 ) && demand < -deadband &&
                          outside_c > 5 && outside_c < 55;
        const double capacity = heat ? 3500 * std::clamp( ( outside_c + 12 ) / 19, 0.0, 1.0 ) :
                                3500 * std::clamp( ( 55 - outside_c ) / 20, 0.0, 1.0 );
        const double cop = heat ? std::clamp( 2.0 + 0.07 * outside_c, 1.05, 3.6 ) :
                           std::clamp( 4.3 - 0.065 * ( outside_c - 25 ), 1.8, 4.5 );
        if( ( heat || cool ) && other->get_var( "hvac_minute", -1.0 ) != now ) {
            const double watts = std::min( capacity, std::abs( demand ) * 700 );
            if( hvac_power( here, supply, static_cast<int>( std::ceil( watts / cop + 35 ) ) ) ) {
                other->set_var( "hvac_minute", now );
                output = heat ? watts : -watts;
            }
        }
    }
    unit->set_var( "hvac_minute", now );
    unit->set_var( "hvac_output", output );
    return output;
}

void update_vehicle_climate( map &here, vehicle &target )
{
    if( cata_mp::is_client_mode() ) {
        return;
    }
    const double ambient_c = units::to_celsius( get_weather().weather_precise->temperature );
    for( const vpart_reference &part : target.get_avail_parts( "HYDRONIC_BOILER" ) ) {
        item_location boiler = target.part_base( part.part_index() );
        if( boiler && boiler->get_var( "hvac_water_l", 0.0 ) > 0 ) {
            update_boiler( here, target, *boiler, ambient_c );
        }
    }
    for( const vpart_reference &part : target.get_avail_parts( "CABIN_HVAC" ) ) {
        item_location unit = target.part_base( part.part_index() );
        if( !unit ) {
            continue;
        }
        const int now = hvac_minute();
        const int last = static_cast<int>( unit->get_var( "hvac_minute", now - 1.0 ) );
        double delta = unit->get_var( "hvac_cabin_delta", 0.0 );
        if( last == now ) {
            return;
        }
        const auto openings = target.get_any_parts( "OPENABLE" );
        const int open = std::count_if( openings.begin(), openings.end(), []( const vpart_reference &p ) {
            return ( p.part().open || p.part().is_broken() ) &&
                   ( p.has_feature( "CABIN_WINDOW" ) || p.has_feature( VPFLAG_OBSTACLE ) );
        } );
        const double retention = 1.0 / ( 1.0 + 0.7 * open );
        const int elapsed = std::max( 0, now - last );
        delta *= std::exp( -elapsed / ( 8.0 * retention ) );
        const int mode = static_cast<int>( unit->get_var( "hvac_mode", 0.0 ) );
        const double demand = unit->get_var( "hvac_setpoint", 22.0 ) - ambient_c - delta;
        const double deadband = mode == 3 ? 2.5 : 0.75;
        const bool heat = mode >= 2 && demand > deadband;
        const bool cool = mode != 0 && mode != 2 && demand < -deadband;
        if( elapsed > 0 && ( heat || cool ) ) {
            const bool combustion_running = target.engine_on &&
                                            ( target.has_engine_type( itype_id( "gasoline" ), true ) ||
                                              target.has_engine_type( itype_id( "diesel" ), true ) );
            const int peak_watts = cool ? ( combustion_running ? 550 : 950 ) :
                                   ( combustion_running ? 120 : 1200 );
            const double duty = std::clamp( std::abs( demand ) / 5, 0.20, 1.0 );
            if( hvac_power( here, target, static_cast<int>( std::ceil( peak_watts * duty ) ) ) ) {
                delta += std::clamp( demand, -2.5 * duty, 2.0 * duty ) * retention;
            }
        }
        unit->set_var( "hvac_minute", now );
        unit->set_var( "hvac_cabin_delta", delta );
        return;
    }
}

double cabin_temperature_delta( const map &here, const tripoint_bub_ms &position )
{
    const optional_vpart_position seat = here.veh_at( position );
    if( seat && !seat->vehicle().is_appliance() && seat->is_inside() ) {
        vehicle &target = seat->vehicle();
        for( const vpart_reference &part : target.get_avail_parts( "CABIN_HVAC" ) ) {
            if( item_location unit = target.part_base( part.part_index() ) ) {
                return unit->get_var( "hvac_cabin_delta", 0.0 );
            }
        }
    }
    return 0;
}

void add_vehicle_appliance_menu( veh_menu &menu, map &here, vehicle &target,
                                 const tripoint_abs_ms &position )
{
    add_hvac_menu( menu, here, target, position );
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
