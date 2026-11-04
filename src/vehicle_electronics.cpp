#include "vehicle_electronics.h"

#include <algorithm>
#include <iterator>
#include <utility>

#include "avatar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "color.h"
#include "game.h"
#include "item.h"
#include "json.h"
#include "map.h"
#include "string_formatter.h"
#include "translations.h"
#include "uilist.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "veh_type.h"
#include "vpart_range.h"

namespace
{
struct device_descriptor {
    const char *flag;
    const char *hotkey;
    translation name;
};

const device_descriptor devices[] = {
    { "CONE_LIGHT", "TOGGLE_HEADLIGHT", to_translation( "electronics menu option", "headlights" ) },
    { "WIDE_CONE_LIGHT", "TOGGLE_WIDE_HEADLIGHT", to_translation( "electronics menu option", "wide angle headlights" ) },
    { "HALF_CIRCLE_LIGHT", "TOGGLE_HALF_OVERHEAD_LIGHT", to_translation( "electronics menu option", "directed overhead lights" ) },
    { "CIRCLE_LIGHT", "TOGGLE_OVERHEAD_LIGHT", to_translation( "electronics menu option", "overhead lights" ) },
    { "AISLE_LIGHT", "TOGGLE_AISLE_LIGHT", to_translation( "electronics menu option", "aisle lights" ) },
    { "DOME_LIGHT", "TOGGLE_DOME_LIGHT", to_translation( "electronics menu option", "dome lights" ) },
    { "ATOMIC_LIGHT", "TOGGLE_ATOMIC_LIGHT", to_translation( "electronics menu option", "atomic lights" ) },
    { "STEREO", "TOGGLE_STEREO", to_translation( "electronics menu option", "stereo" ) },
    { "CHIMES", "TOGGLE_CHIMES", to_translation( "electronics menu option", "chimes" ) },
    { "FRIDGE", "TOGGLE_FRIDGE", to_translation( "electronics menu option", "fridge" ) },
    { "FREEZER", "TOGGLE_FREEZER", to_translation( "electronics menu option", "freezer" ) },
    { "ARCADE", "TOGGLE_ARCADE", to_translation( "electronics menu option", "arcade" ) },
    { "SPACE_HEATER", "TOGGLE_SPACE_HEATER", to_translation( "electronics menu option", "space heater" ) },
    { "HEATED_TANK", "TOGGLE_HEATED_TANK", to_translation( "electronics menu option", "heated tank" ) },
    { "COOLER", "TOGGLE_COOLER", to_translation( "electronics menu option", "cooler" ) },
    { "RECHARGE", "TOGGLE_RECHARGER", to_translation( "electronics menu option", "recharger" ) },
    { "PLOW", "TOGGLE_PLOW", to_translation( "electronics menu option", "plow" ) },
    { "REAPER", "TOGGLE_REAPER", to_translation( "electronics menu option", "reaper" ) },
    { "PLANTER", "TOGGLE_PLANTER", to_translation( "electronics menu option", "planter" ) },
    { "ROCKWHEEL", "TOGGLE_PLOW", to_translation( "electronics menu option", "rockwheel" ) },
    { "ROADHEAD", "TOGGLE_PLOW", to_translation( "electronics menu option", "roadheader" ) },
    { "SCOOP", "TOGGLE_SCOOP", to_translation( "electronics menu option", "scoop" ) },
    { "WATER_PURIFIER", "TOGGLE_WATER_PURIFIER", to_translation( "electronics menu option", "water purifier" ) },
    { "SMART_ENGINE_CONTROLLER", "TOGGLE_SMART_ENGINE_CONTROLLER", to_translation( "electronics menu option", "smart controller" ) }
};

bool device_system( const std::string &system )
{
    return std::any_of( std::begin( devices ), std::end( devices ), [&]( const device_descriptor & d ) {
        return system == d.flag;
    } );
}

bool door_group( const std::string &system )
{
    return system == "curtains_open" || system == "doors_open" ||
           system == "doors_close" || system == "doors_and_curtains_close";
}

int part_by_id( const vehicle &target, int64_t id )
{
    if( id > 0 ) {
        for( const vpart_reference &part : target.get_all_parts() ) {
            if( !part.part().is_fake && part.part().get_base().uid().get_value() == id ) {
                return part.part_index();
            }
        }
    }
    return -1;
}

bool motor_controls( const vehicle &target, int index, const vehicle_electronics_selection &choice )
{
    const vehicle_part &part = target.part( index );
    if( !part.is_available() || !part.info().has_flag( "OPENABLE" ) ) {
        return false;
    }
    const bool lock = choice.system == "door_lock";
    if( lock && ( part.open || !part.info().has_flag( "LOCKABLE_DOOR" ) ||
                  !target.part_has_lock( index ) ) ) {
        return false;
    }
    for( const vpart_reference &motor : target.get_avail_parts( "DOOR_MOTOR" ) ) {
        if( motor.part().mount != part.mount ) {
            continue;
        }
        if( ( lock ? part.locked : part.open ) == choice.enabled ) {
            return true;
        }
        const int next = lock ? ( choice.enabled ? target.next_part_to_lock( motor.part_index() ) :
                                  target.next_part_to_unlock( motor.part_index() ) ) :
                         choice.enabled ? target.next_part_to_open( motor.part_index() ) :
                         target.next_part_to_close( motor.part_index() );
        if( next == index ) {
            return true;
        }
    }
    return false;
}
} // namespace

void vehicle_electronics_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "system", system );
    out.member( "part", part_id );
    out.member( "enabled", enabled );
    out.end_object();
}

void vehicle_electronics_selection::deserialize( const JsonObject &data )
{
    data.read( "system", system, true );
    data.read( "part", part_id, true );
    data.read( "enabled", enabled, true );
}

std::optional<tripoint_abs_ms> vehicle_electronics_position( const Character &who, map &here,
        const vehicle &target, const item_location *remote_source )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( vehicle_control_accessible( who, here, target, part.pos_abs(), "electronics",
                                        remote_source ) ) {
            return part.pos_abs();
        }
    }
    return std::nullopt;
}

bool valid_vehicle_electronics_selection( const Character &who, map &here, const vehicle &target,
        const vehicle_electronics_selection &choice )
{
    if( device_system( choice.system ) ) {
        const auto found = target.get_avail_parts( choice.system );
        return choice.part_id == 0 && !empty( found ) && ( !choice.enabled ||
        std::any_of( found.begin(), found.end(), [&]( const vpart_reference & part ) {
            return can_enable_vehicle_part( who, here, target, part.part() );
        } ) );
    }
    if( choice.system == "camera" ) {
        return choice.part_id == 0 && target.fuel_left( here, itype_id( "battery" ) ) > 0 &&
               ( target.camera_on || ( !empty( target.get_avail_parts( "CAMERA" ) ) &&
                                       !empty( target.get_avail_parts( "CAMERA_CONTROL" ) ) ) );
    }
    if( door_group( choice.system ) ) {
        const bool open = choice.system == "curtains_open" || choice.system == "doors_open";
        return choice.part_id == 0 && choice.enabled == open &&
               !empty( target.get_avail_parts( "DOOR_MOTOR" ) );
    }
    const int index = part_by_id( target, choice.part_id );
    if( index < 0 ) {
        return false;
    }
    const vehicle_part &part = target.part( index );
    if( choice.system == "reactor" ) {
        return part.info().has_flag( "REACTOR" ) && !part.removed &&
               ( !choice.enabled || can_enable_vehicle_part( who, here, target, part ) );
    }
    return ( choice.system == "door_open" || choice.system == "door_lock" ) &&
           motor_controls( target, index, choice );
}

std::vector<vehicle_electronics_option> vehicle_electronics_options( const Character &who,
        map &here, const vehicle &target, const std::string &submenu )
{
    std::vector<vehicle_electronics_option> options;
    const auto add = [&]( vehicle_electronics_selection choice, const std::string & label,
    const std::string &hotkey = "", std::optional<tripoint_abs_ms> position = std::nullopt ) {
        options.push_back( {choice, label, hotkey, "",
                            valid_vehicle_electronics_selection( who, here, target, choice ), position} );
    };
    if( submenu == "reactors" ) {
        for( const int index : target.reactors ) {
            const vehicle_part &part = target.part( index );
            add( {"reactor", part.get_base().uid().get_value(), !part.enabled},
                 string_format( "[%s] %s", part.enabled ? "x" : " ", part.name() ) );
        }
        return options;
    }
    if( submenu == "doors" ) {
        add( {"curtains_open", 0, true}, _( "Open all curtains" ), "", who.pos_abs() );
        add( {"doors_open", 0, true}, _( "Open all curtains and doors" ), "", who.pos_abs() );
        add( {"doors_close", 0, false}, _( "Close all doors" ), "", who.pos_abs() );
        add( {"doors_and_curtains_close", 0, false}, _( "Close all curtains and doors" ), "",
             who.pos_abs() );
        const auto add_part = [&]( int index, bool lock ) {
            if( index < 0 ) {
                return;
            }
            const vehicle_part &part = target.part( index );
            const bool state = lock ? !part.locked : !part.open;
            const std::string verb = lock ? ( state ? _( "Lock" ) : _( "Unlock" ) ) :
                                     state ? _( "Open" ) : _( "Close" );
            add( {lock ? "door_lock" : "door_open", part.get_base().uid().get_value(), state},
                 string_format( "%s %s", verb, part.name() ), "", target.abs_part_pos( part ) );
        };
        for( const vpart_reference &motor : target.get_avail_parts( "DOOR_MOTOR" ) ) {
            add_part( target.next_part_to_open( motor.part_index() ), false );
            add_part( target.next_part_to_close( motor.part_index() ), false );
            add_part( target.next_part_to_unlock( motor.part_index() ), true );
            add_part( target.next_part_to_lock( motor.part_index() ), true );
        }
        return options;
    }
    if( !submenu.empty() ) {
        return options;
    }
    if( !empty( target.get_avail_parts( "DOOR_MOTOR" ) ) ) {
        options.push_back( {{}, _( "Control doors and curtains" ), "TOGGLE_DOORS", "doors", true, {}} );
    }
    if( target.camera_on || target.has_parts( {"CAMERA", "CAMERA_CONTROL"} ).all() ) {
        add( {"camera", 0, !target.camera_on}, target.camera_on ?
             colorize( _( "Turn off camera system" ), c_pink ) : _( "Turn on camera system" ), "TOGGLE_CAMERA" );
    }
    if( !target.reactors.empty() ) {
        options.push_back( {{}, _( "Control reactors" ), "TOGGLE_REACTOR", "reactors", true, {}} );
    }
    for( const device_descriptor &device : devices ) {
        const auto parts = target.get_avail_parts( device.flag );
        if( empty( parts ) ) {
            continue;
        }
        const bool state = std::none_of( parts.begin(), parts.end(), []( const vpart_reference & part ) {
            return part.part().enabled;
        } );
        add( {device.flag, 0, state}, string_format( state ? _( "Turn on %s" ) :
                colorize( _( "Turn off %s" ), c_pink ), device.name.translated() ), device.hotkey );
    }
    return options;
}

std::optional<vehicle_control_selection> query_vehicle_electronics( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position, const item_location *remote_source,
        const std::string &submenu )
{
    if( !vehicle_control_accessible( who, here, target, position, "electronics", remote_source ) ) {
        return std::nullopt;
    }
    const auto options = vehicle_electronics_options( who, here, target, submenu );
    if( options.empty() ) {
        return std::nullopt;
    }
    uilist menu;
    menu.title = submenu == "doors" ? _( "Select door to toggle" ) :
                 submenu == "reactors" ? _( "Toggle which?" ) : _( "Vehicle electronics" );
    std::vector<tripoint_bub_ms> points;
    for( size_t i = 0; i < options.size(); ++i ) {
        menu.addentry( i, options[i].enabled, MENU_AUTOASSIGN, options[i].label );
        points.push_back( here.get_bub( options[i].position.value_or( who.pos_abs() ) ) );
    }
    const restore_on_out_of_scope restore_view( get_avatar().view_offset );
    pointmenu_cb preview( points );
    if( submenu == "doors" ) {
        menu.callback = &preview;
    }
    menu.query();
    if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= options.size() ) {
        return std::nullopt;
    }
    const auto &option = options[menu.ret];
    if( !option.submenu.empty() ) {
        return query_vehicle_electronics( who, here, target, position, remote_source, option.submenu );
    }
    auto selection = query_vehicle_control( who, here, target, position, "electronics", remote_source );
    if( selection ) {
        selection->electronics = option.choice;
    }
    return selection;
}

bool execute_vehicle_electronics( Character &who, map &here, vehicle &target,
                                  const vehicle_electronics_selection &choice )
{
    if( !valid_vehicle_electronics_selection( who, here, target, choice ) ) {
        return false;
    }
    if( device_system( choice.system ) ) {
        for( const vpart_reference &part : target.get_avail_parts( choice.system ) ) {
            if( part.part().enabled != choice.enabled ) {
                who.add_msg_if_player( choice.enabled ? _( "Turned on %s." ) : _( "Turned off %s." ),
                                       part.part().name() );
                part.part().enabled = choice.enabled;
            }
            here.set_lightmap_cache_dirty( part.pos_bub( here ).z() );
        }
        return true;
    }
    if( choice.system == "camera" ) {
        if( target.camera_on != choice.enabled ) {
            who.add_msg_if_player( choice.enabled ? _( "Camera system enabled" ) :
                                   _( "Camera system disabled" ) );
            target.camera_on = choice.enabled;
            here.set_seen_cache_dirty( target.pos_bub( here ) );
        }
        return true;
    }
    if( door_group( choice.system ) ) {
        const bool open = choice.system == "curtains_open" || choice.system == "doors_open";
        const std::string flag = choice.system == "curtains_open" ? "CURTAIN" :
                                 choice.system == "doors_close" ? "DOOR" : "";
        if( choice.system == "doors_open" ) {
            for( const vpart_reference &motor : target.get_avail_parts( "DOOR_MOTOR" ) ) {
                const int index = target.next_part_to_unlock( motor.part_index() );
                if( index >= 0 && target.part( index ).info().has_flag( "LOCKABLE_DOOR" ) ) {
                    target.unlock( index );
                }
            }
        }
        for( const vpart_reference &motor : target.get_avail_parts( "DOOR_MOTOR" ) ) {
            const int index = open ? target.next_part_to_open( motor.part_index() ) :
                              target.next_part_to_close( motor.part_index() );
            if( index >= 0 && ( flag.empty() || target.part( index ).info().has_flag( flag ) ) &&
                ( open || target.can_close( index, who ) ) ) {
                if( open ) {
                    target.open( here, index );
                } else {
                    target.close( here, index );
                }
            }
        }
        return true;
    }
    const int index = part_by_id( target, choice.part_id );
    if( choice.system == "reactor" ) {
        target.part( index ).enabled = choice.enabled;
    } else if( choice.system == "door_lock" ) {
        if( choice.enabled ) {
            target.lock( index );
        } else {
            target.unlock( index );
        }
    } else if( target.part( index ).open != choice.enabled ) {
        if( !target.can_close( index, who ) ) {
            return false;
        }
        if( choice.enabled ) {
            target.open( here, index );
        } else {
            target.close( here, index );
        }
    }
    return true;
}
