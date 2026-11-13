#include "vehicle.h"
#include "vehicle_turret_control.h"
#include "vehicle_control.h"
#include "vehicle_harness.h"
#include "vehicle_electronics.h"
#include "vehicle_appliance.h"
#include "vehicle_water.h"
#include "vehicle_toolstation.h"
#include "vehicle_tool_use.h"
#include "character_action_guard.h"
#include "cata_scope_helpers.h"
#include "mp_client_conn.h"
#include "map_selector.h"
#include "mp_inventory_activity.h"

#include <calendar.h>
#include <cata_bitset.h>
#include <coordinates.h>
#include <effect.h>
#include <item_location.h>
#include <point.h>
#include <talker.h>
#include <type_id.h>
#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <initializer_list>
#include <list>
#include <memory>
#include <optional>
#include <string>
#include <tuple>
#include <vector>

#include "action.h"
#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "avatar.h"
#include "character.h"
#include "clzones.h"
#include "faction.h"
#include "color.h"
#include "craft_reservation.h"
#include "creature.h"
#include "creature_tracker.h"
#include "debug.h"
#include "dialogue.h"
#include "effect_on_condition.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "flat_set.h"
#include "game.h"
#include "game_inventory.h"
#include "gates.h"
#include "handle_liquid.h"
#include "iexamine.h"
#include "item.h"
#include "item_activation.h"
#include "item_pocket.h"
#include "itype.h"
#include "iuse.h"
#include "lua_platform_runtime.h"
#include "map.h"
#include "map_iterator.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "messages.h"
#include "monster.h"
#include "mtype.h"
#include "options.h"
#include "output.h"
#include "overmapbuffer.h"
#include "player_activity.h"
#include "pocket_type.h"
#include "requirements.h"
#include "ret_val.h"
#include "rng.h"
#include "smart_controller_ui.h"
#include "sounds.h"
#include "string_formatter.h"
#include "temp_crafting_inventory.h"
#include "translations.h"
#include "uilist.h"
#include "units.h"
#include "value_ptr.h"
#include "veh_interact.h"
#include "veh_type.h"
#include "veh_utils.h"
#include "vehicle_selector.h"
#include "vpart_position.h"
#include "vpart_range.h"
#include "weather.h"

static const activity_id ACT_REPAIR_ITEM( "ACT_REPAIR_ITEM" );

static const ammotype ammo_battery( "battery" );

static const damage_type_id damage_bash( "bash" );


static const efftype_id effect_tied( "tied" );

static const fault_id fault_engine_starter( "fault_engine_starter" );

static const flag_id json_flag_IRREMOVABLE( "IRREMOVABLE" );
static const flag_id json_flag_PSEUDO( "PSEUDO" );

static const furn_str_id furn_f_plant_seed( "f_plant_seed" );

static const gun_mode_id gun_mode_DEFAULT( "DEFAULT" );

static const itype_id fuel_type_battery( "battery" );
static const itype_id fuel_type_muscle( "muscle" );
static const itype_id fuel_type_none( "null" );
static const itype_id fuel_type_wind( "wind" );
static const itype_id itype_battery( "battery" );
static const itype_id itype_fungal_seeds( "fungal_seeds" );
static const itype_id itype_large_repairkit( "large_repairkit" );
static const itype_id itype_marloss_seed( "marloss_seed" );
static const itype_id itype_power_cord( "power_cord" );
static const itype_id itype_pseudo_magazine( "pseudo_magazine" );
static const itype_id itype_pseudo_magazine_mod( "pseudo_magazine_mod" );
static const itype_id itype_small_repairkit( "small_repairkit" );
static const itype_id itype_soldering_iron( "soldering_iron" );
static const itype_id itype_water( "water" );
static const itype_id itype_water_clean( "water_clean" );
static const itype_id itype_water_faucet( "water_faucet" );
static const itype_id itype_welder( "welder" );
static const itype_id itype_welder_crude( "welder_crude" );
static const itype_id itype_welding_kit( "welding_kit" );

static const quality_id qual_SCREW( "SCREW" );

static const skill_id skill_mechanics( "mechanics" );

static const ter_str_id ter_t_dirt( "t_dirt" );
static const ter_str_id ter_t_dirtmound( "t_dirtmound" );

static const vpart_id vpart_horn_bicycle( "horn_bicycle" );

static const zone_type_id zone_type_VEHICLE_PATROL( "VEHICLE_PATROL" );

void handbrake( map &here )
{
    brake_vehicle( get_player_character(), here );
}

namespace
{
void run_electronics_menu( map &here, vehicle &target, const std::string &submenu,
                           const item_location *remote_source = nullptr )
{
    Character &who = get_player_character();
    const character_action_guard lifetime( who );
    const int64_t id = target.uid().get_value();
    while( lifetime ) {
        vehicle *current = vehicle::find_vehicle_by_uid( here, id );
        if( !current ) {
            return;
        }
        const auto position = vehicle_electronics_position( who, here, *current, remote_source );
        if( !position ) {
            return;
        }
        const auto selection = query_vehicle_electronics( who, here, *current, *position,
                               remote_source, submenu );
        if( !selection || cata_mp::client_vehicle_control( *selection ) ||
            !execute_vehicle_control( who, here, *selection, remote_source ) ) {
            return;
        }
        // Native bulk door actions close their submenu; individual switches stay open.
        if( submenu == "doors" && selection->electronics->part_id == 0 ) {
            return;
        }
    }
}

void submit_electronic_switch( map &here, int64_t vehicle_id,
                               const vehicle_electronics_selection &choice,
                               const item_location *remote_source )
{
    Character &who = get_player_character();
    vehicle *target = vehicle::find_vehicle_by_uid( here, vehicle_id );
    if( !target ) {
        return;
    }
    const auto position = vehicle_electronics_position( who, here, *target, remote_source );
    if( !position ) {
        return;
    }
    auto selection = query_vehicle_control( who, here, *target, *position, "electronics",
                                            remote_source );
    if( selection ) {
        selection->electronics = choice;
        if( !cata_mp::client_vehicle_control( *selection ) ) {
            execute_vehicle_control( who, here, *selection, remote_source );
        }
    }
}
} // namespace

void vehicle::control_doors( map &here )
{
    run_electronics_menu( here, *this, "doors" );
}

void vehicle::build_electronics_menu( map &here, veh_menu &menu )
{
    const int64_t id = uid().get_value();
    for( const vehicle_electronics_option &option :
         vehicle_electronics_options( get_player_character(), here, *this ) ) {
        menu.add( option.label )
        .enable( option.enabled )
        .hotkey( option.hotkey )
        .skip_theft_check()
        .skip_locked_check()
        .keep_menu_open( option.submenu.empty() )
        .on_submit( [&here, id, option, remote_source = menu.remote_controller] {
            if( option.submenu.empty() )
            {
                submit_electronic_switch( here, id, option.choice, remote_source );
            } else if( vehicle *current = vehicle::find_vehicle_by_uid( here, id ) )
            {
                run_electronics_menu( here, *current, option.submenu, remote_source );
            }
        } );
    }

    for( const vpart_reference &arc_vp : get_any_parts( "ARCADE" ) ) {
        if( arc_vp.part().enabled ) {
            item *arc_itm = &arc_vp.part().base;

            menu.add( _( "Play arcade machine" ) )
            .hotkey( "ARCADE" )
            .enable( !!arc_itm )
            .on_submit( [arc_itm] { iuse::portable_game( &get_avatar(), arc_itm, tripoint_bub_ms::zero ); } );
            break;
        }
    }
}

void vehicle::control_reactors( map &here )
{
    run_electronics_menu( here, *this, "reactors" );
}

void vehicle::control_engines( map &here )
{
    Character &who = get_player_character();
    const auto selection = query_vehicle_engines( who, here, *this, who.pos_abs() );
    if( selection && !cata_mp::client_vehicle_control( *selection ) ) {
        execute_vehicle_control( who, here, *selection );
    }
}

void vehicle::smash_security_system( map &here )
{
    Character &who = get_player_character();
    const auto selection = query_vehicle_control( who, here, *this, who.pos_abs(), "smash_alarm" );
    if( selection && !cata_mp::client_vehicle_control( *selection ) ) {
        execute_vehicle_control( who, here, *selection );
    }
}

void vehicle::toggle_autopilot( map &here )
{
    Character &who = get_player_character();
    const auto selection = query_vehicle_autopilot( who, here, *this, who.pos_abs() );
    if( selection && !cata_mp::client_vehicle_control( *selection ) ) {
        execute_vehicle_control( who, here, *selection );
    }
}

void vehicle::toggle_tracking()
{
    if( tracking_on ) {
        overmap_buffer.remove_vehicle( this );
        tracking_on = false;
        add_msg( _( "You stop keeping track of the vehicle position." ) );
    } else {
        overmap_buffer.add_vehicle( this );
        tracking_on = true;
        add_msg( _( "You start keeping track of this vehicle's position." ) );
    }
}

void vehicle::display_effects()
{
    std::string effect_message;
    for( auto &elem : effects ) {
        if( elem.first->is_show_in_info() ) {
            effect_message += elem.second.disp_name() + ": " + elem.second.disp_desc();
            effect_message += '\n';
        }
    }
    add_msg( effect_message );
}

void vehicle::connect( map *here, const tripoint_bub_ms &source_pos,
                       const tripoint_bub_ms &target_pos )
{
    const optional_vpart_position sel_vp = here->veh_at( target_pos );
    const optional_vpart_position prev_vp = here->veh_at( source_pos );

    if( !sel_vp ) {
        return;
    }
    if( &sel_vp->vehicle() == &prev_vp->vehicle() ) {
        return;
    }

    item cord( itype_power_cord );
    if( !cord.link_to( prev_vp, sel_vp, link_state::vehicle_port ).success() ) {
        debugmsg( "Failed to connect the %s, it tried to make an invalid connection!", cord.tname() );
    }
}

double vehicle::engine_cold_factor( map &here, const vehicle_part &vp ) const
{
    if( !vp.info().has_flag( "E_COLD_START" ) ) {
        return 0.0;
    }

    const tripoint_bub_ms pos = bub_part_pos( here, vp );
    double eff_temp = units::to_fahrenheit( get_weather().get_temperature( pos ) );
    if( !vp.has_fault_flag( "BAD_COLD_START" ) ) {
        eff_temp = std::min( eff_temp, 20.0 );
    }

    return 1.0 - ( std::max( 0.0, std::min( 30.0, eff_temp ) ) / 30.0 );
}

time_duration vehicle::engine_start_time( map &here, const vehicle_part &vp ) const
{
    time_duration result = 0_seconds;
    if( !is_engine_on( vp ) || vp.info().has_flag( "E_STARTS_INSTANTLY" ) ||
        !engine_fuel_left( here, vp ) ) {
        return result;
    }

    result += 1_seconds * vp.damage_percent();

    // non-linear range [100-1000]; f(0.0) = 100, f(0.6) = 250, f(0.8) = 500, f(0.9) = 1000
    // diesel engines with working glow plugs always start with f = 0.6 (or better)
    result += 1_seconds / tanh( 1.0 - std::min( engine_cold_factor( here,  vp ), 0.9 ) );

    // divided by magic 16 = watts / 6000
    const double watts_per_time = 6000;
    const double engine_watts = units::to_watt( part_vpower_w( here, vp, true ) );
    result += time_duration::from_moves( engine_watts / watts_per_time );
    return result;
}

// NOLINTNEXTLINE(readability-make-member-function-const)
bool vehicle::auto_select_fuel( map &here, vehicle_part &vp )
{
    const vpart_info &vp_engine_info = vp.info();
    if( !vp.is_available() || !vp.is_engine() ) {
        return false;
    }
    if( vp_engine_info.fuel_type == fuel_type_none || engine_fuel_left( here, vp ) > 0 ) {
        return true;
    }
    for( const itype_id &fuel_id : vp_engine_info.engine_info->fuel_opts ) {
        if( fuel_left( here, fuel_id ) > 0 ) {
            vp.fuel_set( fuel_id );
            return true;
        }
    }
    return false; // not a single fuel type left for this engine
}

bool vehicle::start_engine( map &here, vehicle_part &vp )
{
    return start_engine( here, vp, get_player_character() );
}

bool vehicle::start_engine( map &here, vehicle_part &vp, Character &player_character )
{
    const vpart_info &vpi = vp.info();
    if( !is_engine_on( vp ) ) {
        return false;
    }

    const bool out_of_fuel = !auto_select_fuel( here, vp );
    if( out_of_fuel ) {
        if( vpi.fuel_type == fuel_type_muscle ) {
            // Muscle engines cannot start with broken limbs
            if( vpi.has_flag( "MUSCLE_ARMS" ) && !player_character.has_two_arms_lifting() ) {
                player_character.add_msg_if_player( _( "You cannot use %s with a broken arm." ), vp.name() );
                return false;
            } else if( vpi.has_flag( "MUSCLE_LEGS" ) && ( player_character.get_working_leg_count() < 2 ) ) {
                player_character.add_msg_if_player( _( "You cannot use %s without at least two legs." ),
                                                    vp.name() );
                return false;
            }
        } else {
            player_character.add_msg_if_player( _( "Looks like the %1$s is out of %2$s." ), vp.name(),
                                                item::nname( vpi.fuel_type ) );
            return false;
        }
    }

    if( has_part( player_character.pos_abs(), "NEED_LEG" ) &&
        player_character.get_working_leg_count() < 1 &&
        !has_part( player_character.pos_abs(), "IGNORE_LEG_REQUIREMENT" ) ) {
        player_character.add_msg_if_player( _( "You need at least one leg to control the %s." ),
                                            vp.name() );
        return false;
    }
    if( has_part( player_character.pos_abs(), "INOPERABLE_SMALL" ) &&
        ( player_character.get_size() == creature_size::small ||
          player_character.get_size() == creature_size::tiny ) &&
        !has_part( player_character.pos_abs(), "IGNORE_HEIGHT_REQUIREMENT" ) ) {
        player_character.add_msg_if_player( _( "You are too short to reach the pedals!" ) );
        return false;
    }

    const double dmg = vp.damage_percent();
    const time_duration start_time = engine_start_time( here, vp );
    const tripoint_bub_ms pos = bub_part_pos( here, vp );

    if( !is_engine_type( vp, fuel_type_battery ) &&
        ( 1 - dmg ) < vpi.engine_info->backfire_threshold &&
        one_in( vpi.engine_info->backfire_freq ) ) {
        backfire( &here, vp );
    } else {
        sounds::sound( pos, to_seconds<int>( start_time ) * 10, sounds::sound_t::movement,
                       string_format( _( "the %s bang as it starts!" ), vp.name() ), true, "vehicle",
                       "engine_bangs_start" );
    }

    // Immobilizers need removing before the vehicle can be started
    if( vp.has_fault_flag( "IMMOBILIZER" ) ) {
        sounds::sound( pos, 5, sounds::sound_t::alarm,
                       string_format( _( "the %s making a long beep." ), vp.name() ), true, "vehicle",
                       "fault_immobiliser_beep" );
        return false;
    }

    // Engine with starter motors can fail on both battery and starter motor
    if( vp.faults_potential().count( fault_engine_starter ) ) {
        if( vp.has_fault_flag( "BAD_STARTER" ) ) {
            sounds::sound( pos, vpi.engine_info->noise_factor, sounds::sound_t::alarm,
                           string_format( _( "the %s clicking once." ), vp.name() ), true, "vehicle",
                           "engine_single_click_fail" );
            return false;
        }

        const double cold_factor = engine_cold_factor( here, vp );
        const units::power start_power = -part_epower( vp ) * ( dmg * 5 + cold_factor * 2 + 10 );
        const int start_bat = power_to_energy_bat( start_power, start_time );
        if( discharge_battery( here, start_bat ) != 0 ) {
            sounds::sound( pos, vpi.engine_info->noise_factor, sounds::sound_t::alarm,
                           string_format( _( "the %s rapidly clicking." ), vp.name() ), true, "vehicle",
                           "engine_multi_click_fail" );
            return false;
        }
    }

    // Engines always fail to start with faulty fuel pumps
    if( vp.has_fault_flag( "BAD_FUEL_PUMP" ) ) {
        sounds::sound( pos, vpi.engine_info->noise_factor, sounds::sound_t::movement,
                       string_format( _( "the %s quickly stuttering out." ), vp.name() ), true, "vehicle",
                       "engine_stutter_fail" );
        return false;
    }

    // Damaged non-electric engines have a chance of failing to start
    if( !is_engine_type( vp, fuel_type_battery ) && vpi.fuel_type != fuel_type_muscle &&
        x_in_y( dmg * 100, 120 ) ) {
        sounds::sound( pos, vpi.engine_info->noise_factor, sounds::sound_t::movement,
                       string_format( _( "the %s clanking and grinding." ), vp.name() ), true, "vehicle",
                       "engine_clanking_fail" );
        return false;
    }
    sounds::sound( pos, vpi.engine_info->noise_factor, sounds::sound_t::movement,
                   string_format( _( "the %s starting." ), vp.name() ) );

    std::string variant = vpi.id.str();

    if( sfx::has_variant_sound( "engine_start", variant ) ) {
        // has special sound variant for this vpart id
    } else if( vpi.fuel_type == fuel_type_muscle ) {
        variant = "muscle";
    } else if( is_engine_type( vp, fuel_type_wind ) ) {
        variant = "wind";
    } else if( is_engine_type( vp, fuel_type_battery ) ) {
        variant = "electric";
    } else {
        variant = "combustion";
    }
    sfx::play_variant_sound( "engine_start", variant, vpi.engine_info->noise_factor );
    return true;
}

void vehicle::stop_engines( map &here )
{
    vehicle_noise = 0;
    engine_on = false;
    for( const int p : engines ) {
        const vehicle_part &vp = parts[p];
        if( !is_engine_on( vp ) ) {
            continue;
        }

        sounds::sound( bub_part_pos( here, vp ), 2, sounds::sound_t::movement,
                       _( "the engine go silent" ) );

        std::string variant = vp.info().id.str();

        if( sfx::has_variant_sound( "engine_stop", variant ) ) {
            // has special sound variant for this vpart id
        } else if( is_engine_type( vp, fuel_type_battery ) ) {
            variant = "electric";
        } else if( is_engine_type( vp, fuel_type_muscle ) ) {
            variant = "muscle";
        } else if( is_engine_type( vp, fuel_type_wind ) ) {
            variant = "wind";
        } else {
            variant = "combustion";
        }

        sfx::play_variant_sound( "engine_stop", variant, vp.info().engine_info->noise_factor );
    }
    sfx::do_vehicle_engine_sfx();
    refresh( );
}

void vehicle::start_engines( map &here, Character *driver, const bool take_control,
                             const bool autodrive )
{
    bool has_engine = std::any_of( engines.begin(), engines.end(), [&]( int idx ) {
        return parts[ idx ].enabled && !parts[ idx ].is_broken();
    } );

    // if no engines enabled then enable all before trying to start the vehicle
    if( !has_engine ) {
        for( const int p : engines ) {
            vehicle_part &vp = parts[p];
            vp.enabled = !vp.is_broken();
        }
    }

    time_duration start_time = 0_seconds;
    // record the first usable engine as the referenced position checked at the end of the engine starting activity
    bool has_starting_engine_position = false;
    tripoint_bub_ms starting_engine_position;
    for( const int p : engines ) {
        const vehicle_part &vp = parts[p];
        if( !has_starting_engine_position && !vp.is_broken() && vp.enabled ) {
            starting_engine_position = bub_part_pos( here, vp );
            has_starting_engine_position = true;
        }
        has_engine = has_engine || is_engine_on( vp );
        start_time = std::max( start_time, engine_start_time( here, vp ) );
    }

    if( !has_starting_engine_position ) {
        starting_engine_position = {};
    }

    if( !has_engine ) {
        if( driver ) {
            driver->add_msg_if_player( m_info, _( "The %s doesn't have an engine!" ), name );
        } else {
            add_msg( m_info, _( "The %s doesn't have an engine!" ), name );
        }
        refresh( );
        return;
    }

    if( take_control && driver && !driver->controlling_vehicle ) {
        driver->controlling_vehicle = true;
        driver->add_msg_if_player( _( "You take control of the %s." ), name );
    }
    // Assignment invokes gameplay callbacks. Finish touching this vehicle first.
    refresh();
    if( !autodrive && driver ) {
        driver->assign_activity( start_engines_activity_actor( start_time,
                                 starting_engine_position - driver->pos_bub(), take_control, uid().get_value(),
                                 resolve_remote_vehicle( *driver, here ) == this ) );
    }
}

void vehicle::enable_patrol( map &here, Character &who )
{
    is_following = false;
    following_character.reset();
    patrol_faction = who.get_faction()->id;
    is_patrolling = true;
    autopilot_on = true;
    autodrive_local_target = tripoint_abs_ms::zero;
    if( !engine_on ) {
        start_engines( here, &who );
    }
}

void vehicle::honk_horn( map &here, const Character &who ) const
{
    const bool no_power = !fuel_left( here, fuel_type_battery );
    bool honked = false;

    for( const vpart_reference &vp : get_avail_parts( "HORN" ) ) {
        //Only bicycle horn doesn't need electricity to work
        const vpart_info &horn_type = vp.info();
        if( ( horn_type.id != vpart_horn_bicycle ) && no_power ) {
            continue;
        }
        if( !honked ) {
            who.add_msg_if_player( _( "You honk the horn!" ) );
            honked = true;
        }
        //Get global position of horn
        const tripoint_bub_ms horn_pos = vp.pos_bub( here );
        //Determine sound
        if( horn_type.bonus >= 110 ) {
            //~ Loud horn sound
            sounds::sound( horn_pos, horn_type.bonus, sounds::sound_t::alarm, _( "HOOOOORNK!" ), false,
                           "vehicle", "horn_loud" );
        } else if( horn_type.bonus >= 80 ) {
            //~ Moderate horn sound
            sounds::sound( horn_pos, horn_type.bonus, sounds::sound_t::alarm, _( "BEEEP!" ), false, "vehicle",
                           "horn_medium" );
        } else {
            //~ Weak horn sound
            sounds::sound( horn_pos, horn_type.bonus, sounds::sound_t::alarm, _( "honk." ), false, "vehicle",
                           "horn_low" );
        }
    }

    if( !honked ) {
        who.add_msg_if_player( _( "You honk the horn, but nothing happens." ) );
    }
}

void vehicle::reload_seeds( map *here, const tripoint_bub_ms &pos )
{
    Character &player_character = get_player_character();
    std::vector<item_location> seed_inv = player_character.cache_get_items_with( "is_seed",
                                          &item::is_seed );

    auto seed_entries = iexamine::get_seed_entries( seed_inv );
    seed_entries.emplace( seed_entries.begin(), itype_id::NULL_ID(), _( "No seed" ), 0 );

    int seed_index = iexamine::query_seed( seed_entries );

    if( seed_index > 0 && seed_index < static_cast<int>( seed_entries.size() ) ) {
        const int count = std::get<2>( seed_entries[seed_index] );
        int amount = count;
        query_int( amount, true, _( "Move how many?  (0 to cancel)" ) );

        if( amount > 0 ) {
            int actual_amount = std::min( amount, count );
            itype_id seed_id = std::get<0>( seed_entries[seed_index] );
            std::list<item> used_seed;
            if( item::count_by_charges( seed_id ) ) {
                used_seed = player_character.use_charges( seed_id, actual_amount );
            } else {
                used_seed = player_character.use_amount( seed_id, actual_amount );
            }
            used_seed.front().set_age( 0_turns );
            //place seeds into the planter
            put_into_vehicle_or_drop( player_character, item_drop_reason::deliberate, used_seed,
                                      here, pos );
        }
    }
}

void vehicle::beeper_sound( map &here ) const
{
    // No power = no sound
    if( fuel_left( here, fuel_type_battery ) == 0 ) {
        return;
    }

    const bool odd_turn = calendar::once_every( 2_turns );
    for( const vpart_reference &vp : get_avail_parts( "BEEPER" ) ) {
        if( ( odd_turn && vp.has_feature( VPFLAG_EVENTURN ) ) ||
            ( !odd_turn && vp.has_feature( VPFLAG_ODDTURN ) ) ) {
            continue;
        }

        //~ Beeper sound
        sounds::sound( vp.pos_bub( here ), vp.info().bonus, sounds::sound_t::alarm, _( "beep!" ), false,
                       "vehicle",
                       "rear_beeper" );
    }
}

void vehicle::play_music( map &here ) const
{
    Character &player_character = get_player_character();
    for( const vpart_reference &vp : get_enabled_parts( "STEREO" ) ) {
        // TODO: Make play_music map aware.
        iuse::play_music( &player_character, vp.pos_bub( here ), 15, 30 );
    }
}

void vehicle::play_chimes( map &here ) const
{
    if( !one_in( 3 ) ) {
        return;
    }

    for( const vpart_reference &vp : get_enabled_parts( "CHIMES" ) ) {
        if( &here == &reality_bubble() ) { // TODO: Make sound handling map aware
            sounds::sound( vp.pos_bub( here ), 40, sounds::sound_t::music,
                           _( "a simple melody blaring from the loudspeakers." ), false, "vehicle", "chimes" );
        }
    }
}

void vehicle::crash_terrain_around( map &here )
{
    if( total_power( here ) <= 0_W ) {
        return;
    }
    for( const vpart_reference &vp : get_enabled_parts( "CRASH_TERRAIN_AROUND" ) ) {
        tripoint_bub_ms crush_target( 0, 0, -OVERMAP_LAYERS );
        const tripoint_bub_ms start_pos = vp.pos_bub( here );
        const vpslot_terrain_transform &ttd = *vp.info().transform_terrain_info;
        for( size_t i = 0; i < eight_horizontal_neighbors.size() &&
             crush_target.z() == -OVERMAP_LAYERS; i++ ) {
            tripoint_bub_ms cur_pos = start_pos + eight_horizontal_neighbors[i];
            bool busy_pos = false;
            for( const vpart_reference &vp_tmp : get_all_parts() ) {
                busy_pos |= vp_tmp.pos_bub( here ) == cur_pos;
            }
            for( const std::string &flag : ttd.pre_flags ) {
                if( here.has_flag( flag, cur_pos ) && !busy_pos ) {
                    crush_target = cur_pos;
                    break;
                }
            }
        }
        //target chosen
        if( crush_target.z() != -OVERMAP_LAYERS ) {
            velocity = 0;
            cruise_velocity = 0;
            here.destroy( crush_target );
            if( &here == &reality_bubble() ) { // TODO: Make sound handling map aware
                sounds::sound( crush_target, 500, sounds::sound_t::combat, _( "Clanggggg!" ), false,
                               "smash_success", "hit_vehicle" );
            }
        }
    }
}

void vehicle::transform_terrain( map &here )
{
    for( const vpart_reference &vp : get_enabled_parts( "TRANSFORM_TERRAIN" ) ) {
        const tripoint_bub_ms start_pos = vp.pos_bub( here );
        const vpslot_terrain_transform &ttd = *vp.info().transform_terrain_info;
        bool prereq_fulfilled = false;
        for( const std::string &flag : ttd.pre_flags ) {
            if( here.has_flag( flag, start_pos ) ) {
                prereq_fulfilled = true;
                break;
            }
        }
        if( prereq_fulfilled ) {
            if( !!ttd.post_terrain ) {
                here.ter_set( start_pos, *ttd.post_terrain );
            }
            if( !!ttd.post_furniture ) {
                here.furn_set( start_pos, *ttd.post_furniture );
            }
            if( !!ttd.post_field ) {
                here.add_field( start_pos, *ttd.post_field, ttd.post_field_intensity, ttd.post_field_age );
            }
        } else {
            const int speed = std::abs( velocity );
            int v_damage = rng( 3, speed );
            damage( here, vp.part_index(), v_damage, damage_bash, false );
            if( &here == &reality_bubble() ) { // TODO: Make sound handling map aware.
                sounds::sound( start_pos, v_damage, sounds::sound_t::combat, _( "Clanggggg!" ), false,
                               "smash_success", "hit_vehicle" );
            }
        }
    }
}

namespace
{
// Part indices and borrowed ranges are invalid after a script removes a part.
// Snapshot only the original enabled tools; callbacks cannot add another pass.
struct farm_part_snapshot {
    int64_t identity;
    tripoint_abs_ms position;

    int resolve( vehicle &machine, map &here, const std::string &feature ) const {
        for( const vpart_reference &part : machine.get_enabled_parts( feature ) ) {
            if( part.part().get_base().uid().get_value() == identity &&
                here.get_abs( part.pos_bub( here ) ) == position ) {
                return part.part_index();
            }
        }
        return -1;
    }
};

std::vector<farm_part_snapshot> farm_parts( vehicle &machine, map &here,
        const std::string &feature )
{
    std::vector<farm_part_snapshot> result;
    for( const vpart_reference &part : machine.get_enabled_parts( feature ) ) {
        result.push_back( { part.part().get_base().uid().get_value(),
                            here.get_abs( part.pos_bub( here ) ) } );
    }
    return result;
}

class farm_operation_context
{
    public:
        farm_operation_context( vehicle &machine, map &here ) :
            machine( machine.get_safe_reference() ), terrain( here.get_context_reference() ),
            origin( machine.pos_abs() ) {
            if( Character *who = vehicle_operator( machine, here ) ) {
                driver.emplace( *who );
            }
        }

        Character *actor() const {
            return driver ? driver->get() : nullptr;
        }

        bool valid() const {
            return machine && terrain && machine->pos_abs() == origin &&
                   ( !driver || *driver ) && vehicle_operator( *machine, *terrain ) == actor();
        }

    private:
        safe_reference<vehicle> machine;
        safe_reference<map> terrain;
        tripoint_abs_ms origin;
        std::optional<character_action_guard> driver;
};
} // namespace

void vehicle::operate_reaper( map &here )
{
    if( cata_mp::is_client_mode() || farming_in_progress ) {
        return;
    }
    const auto lifetime = get_safe_reference();
    const farm_operation_context operation( *this, here );
    farming_in_progress = true;
    const on_out_of_scope finish( [lifetime]() {
        if( lifetime ) {
            lifetime->farming_in_progress = false;
        }
    } );
    for( const farm_part_snapshot &tool : farm_parts( *this, here, "REAPER" ) ) {
        if( !operation.valid() ) {
            return;
        }
        int index = tool.resolve( *this, here, "REAPER" );
        if( index < 0 ) {
            continue;
        }
        const tripoint_bub_ms position = here.get_bub( tool.position );
        const vpart_info &info = part( index ).info();
        // Retain the native mechanical yield draws, including empty tiles.
        int plant_count = std::max( 1, static_cast<int>( rng( 1, info.bonus ) *
                                    ::get_option<float>( "CROP_HARVEST_MULTIPLIER" ) ) );
        int seed_count = rng( 1, 3 );
        const units::volume max_pickup_volume = info.size / 20;
        item *original = iexamine::get_seed_at( here, position );
        const int64_t seed_identity = original ? original->uid().get_value() : 0;
        here.grow_plant( position, operation.actor() );
        if( !operation.valid() ) {
            return;
        }
        index = tool.resolve( *this, here, "REAPER" );
        item *seed = iexamine::get_seed_at( here, position );
        if( index < 0 || !seed || seed->uid().get_value() != seed_identity ||
            seed->typeId() == itype_fungal_seeds || seed->typeId() == itype_marloss_seed ) {
            continue;
        }
        if( iexamine::is_plant_overgrown( here, position ) ) {
            plant_count = 0;
            seed_count = 0;
        } else if( !iexamine::is_plant_harvestable( here, position ) ) {
            continue;
        }
        const item seed_snapshot = *seed;
        const ter_id terrain = here.ter( position );
        const furn_str_id furniture = here.furn( position ).id();
        const int stage_idx = iexamine::get_plant_current_stage_idx_from_effective( here, position );
        const std::string stage = stage_idx >= 0 ?
                                  seed_snapshot.type->seed->get_growth_stages()[stage_idx].first.str() : "";

        here.furn_set( position, furn_str_id::NULL_ID() );
        here.i_clear( position );
        std::vector<item_location> products;
        for( item &value : iexamine::get_harvest_items(
                 *seed_snapshot.type, plant_count, seed_count, false ) ) {
            item &stored = here.add_item_unprocessed( position, std::move( value ) );
            if( !stored.is_null() ) {
                products.emplace_back( map_cursor( tool.position ), &stored );
            }
        }
        // The old crop and its complete yield are settled before any hook.
        // An unattended vehicle has no character to receive these effects.
        if( Character *who = operation.actor() ) {
            get_event_bus().send<event_type::character_harvests_plant>(
                who->getID(), tool.position.raw(), seed_snapshot.typeId(), furniture,
                plant_count, seed_count );
            if( !operation.valid() ) {
                return;
            }
            iexamine::run_plant_lifecycle_event(
            "harvest", *who, here, position, seed_snapshot, stage, stage, {}, {
                { "plant_count", static_cast<double>( plant_count ) },
                { "seed_count", static_cast<double>( seed_count ) },
                { "actor_is_npc", who->is_npc() ? 1.0 : 0.0 }
            }, furniture );
        }
        if( !operation.valid() ) {
            return;
        }
        if( &here == &reality_bubble() ) {
            sounds::sound( position, rng( 10, 25 ), sounds::sound_t::combat,
                           _( "Swish" ), false, "vehicle", "reaper" );
        }
        // Only collect this harvest, never a new crop placed by a callback.
        for( item_location product : products ) {
            if( !operation.valid() ) {
                return;
            }
            if( here.furn( position ) != furn_str_id::NULL_ID() ||
                here.ter( position ) != terrain ) {
                break;
            }
            if( !product || product.where() != item_location::type::map ||
                product.has_parent() || product.pos_abs() != tool.position ) {
                continue;
            }
            item_location placed;
            here.settle_item_on_ground( position, product, operation.actor(), &placed );
            if( !operation.valid() ) {
                return;
            }
            product = placed;
            index = tool.resolve( *this, here, "REAPER" );
            if( index < 0 || !product || product.pos_abs() != tool.position ||
                here.furn( position ) != furn_str_id::NULL_ID() || here.ter( position ) != terrain ) {
                continue;
            }
            // A spilling bucket invokes placement callbacks inside add_item;
            // leave such custom yields on the ground for an explicit pickup.
            if( part( index ).info().has_flag( VPFLAG_CARGO ) &&
                !product->is_bucket_nonempty() && product->volume() <= max_pickup_volume &&
                add_item( here, part( index ), *product ) ) {
                product.remove_item();
            }
        }
    }
}

void vehicle::operate_planter( map &here )
{
    if( cata_mp::is_client_mode() || farming_in_progress ) {
        return;
    }
    const auto lifetime = get_safe_reference();
    const farm_operation_context operation( *this, here );
    farming_in_progress = true;
    const on_out_of_scope finish( [lifetime]() {
        if( lifetime ) {
            lifetime->farming_in_progress = false;
        }
    } );
    for( const farm_part_snapshot &tool : farm_parts( *this, here, "PLANTER" ) ) {
        if( !operation.valid() ) {
            return;
        }
        int index = tool.resolve( *this, here, "PLANTER" );
        if( index < 0 ) {
            continue;
        }
        const tripoint_bub_ms position = here.get_bub( tool.position );
        if( here.has_flag_furn( ter_furn_flag::TFLAG_PLANT, position ) ) {
            continue;
        }
        vehicle_stack seeds = get_items( part( index ) );
        const auto seed = std::find_if( seeds.begin(), seeds.end(), []( const item & value ) {
            return value.is_seed() && value.count() > 0;
        } );
        if( seed == seeds.end() ) {
            continue;
        }
        const bool plant = here.ter( position ) == ter_t_dirtmound &&
                           here.furn( position ) == furn_str_id::NULL_ID() && here.i_at( position ).empty();
        if( !plant && part( index ).info().has_flag( "ADVANCED_PLANTER" ) ) {
            continue;
        }
        const bool damage_planter = !plant && !here.has_flag( ter_furn_flag::TFLAG_PLOWABLE,
                                    position );
        item planted = *seed;
        if( planted.count_by_charges() ) {
            planted.charges = 1;
        }
        planted.set_age( 0_turns );
        // Debit cargo before placement, damage or event callbacks can reenter.
        if( seed->count_by_charges() && seed->charges > 1 ) {
            --seed->charges;
            invalidate_mass();
        } else {
            seeds.erase( seed );
        }
        if( plant ) {
            here.set( position, ter_t_dirt, furn_f_plant_seed );
        }
        item &stored = here.add_item( position, std::move( planted ) );
        if( !operation.valid() ) {
            return;
        }
        const item_location planted_seed = stored.is_null() ? item_location() :
                                           item_location( map_cursor( tool.position ), &stored );
        index = tool.resolve( *this, here, "PLANTER" );
        if( index < 0 ) {
            continue;
        }
        if( damage_planter ) {
            damage( here, index, rng( 1, 10 ), damage_bash, false );
            if( !operation.valid() ) {
                return;
            }
            if( &here == &reality_bubble() ) {
                sounds::sound( position, rng( 10, 20 ), sounds::sound_t::combat,
                               _( "Clink" ), false, "smash_success", "hit_vehicle" );
            }
        }
        if( !plant || !planted_seed ) {
            continue; // A basic planter can spill seeds on untilled ground.
        }
        Character *who = operation.actor();
        if( !who ) {
            continue;
        }
        const itype_id seed_type = planted_seed->typeId();
        get_event_bus().send<event_type::character_plants_seed>(
            who->getID(), tool.position.raw(), seed_type, furn_f_plant_seed );
        if( !operation.valid() ) {
            return;
        }
        if( !planted_seed || planted_seed->typeId() != seed_type ||
            planted_seed.pos_abs() != tool.position ||
            iexamine::get_seed_at( here, position ) != planted_seed.get_item() ||
            here.furn( position ) != furn_f_plant_seed ) {
            continue;
        }
        iexamine::run_plant_lifecycle_event(
        "plant", *who, here, position, *planted_seed, "GROWTH_SEED", "GROWTH_SEED", {}, {
            { "actor_is_npc", who->is_npc() ? 1.0 : 0.0 }
        } );
    }
}

void vehicle::operate_scoop( map &here )
{
    for( const vpart_reference &vp : get_enabled_parts( "SCOOP" ) ) {
        const size_t scoop = vp.part_index();
        const int chance_to_damage_item = 9;
        const units::volume max_pickup_volume = vp.info().size / 10;
        const std::array<std::string, 4> sound_msgs = {{
                _( "Whirrrr" ), _( "Ker-chunk" ), _( "Swish" ), _( "Cugugugugug" )
            }
        };
        if( &here == &reality_bubble() ) { // TODO: Make sound handling map aware.
            sounds::sound( bub_part_pos( here, scoop ), rng( 20, 35 ), sounds::sound_t::combat,
                           random_entry_ref( sound_msgs ), false, "vehicle", "scoop" );
        }
        std::vector<tripoint_bub_ms> parts_points;
        parts_points.reserve( 8 );
        for( const tripoint_bub_ms &current :
             here.points_in_radius( bub_part_pos( here, scoop ), 1 ) ) {
            parts_points.push_back( current );
        }
        for( const tripoint_bub_ms &position : parts_points ) {
            here.mop_spills( position );
            if( !here.has_items( position ) ) {
                continue;
            }
            item *that_item_there = nullptr;
            map_stack items = here.i_at( position );
            if( here.has_flag( ter_furn_flag::TFLAG_SEALED, position ) ) {
                // Ignore it. Street sweepers are not known for their ability to harvest crops.
                continue;
            }
            for( item &it : items ) {
                if( it.volume() < max_pickup_volume ) {
                    that_item_there = &it;
                    break;
                }
            }
            if( !that_item_there ) {
                continue;
            }
            if( one_in( chance_to_damage_item ) && that_item_there->damage() < that_item_there->max_damage() ) {
                //The scoop will not destroy the item, but it may damage it a bit.
                that_item_there->inc_damage();
                //The scoop gets a lot louder when breaking an item.
                if( &here == &reality_bubble() ) { // TODO: Make sound handling map aware.
                    sounds::sound( position, rng( 10,
                                                  that_item_there->volume() * 2 / 250_ml + 10 ),
                                   sounds::sound_t::combat, _( "BEEEThump" ), false, "vehicle", "scoop_thump" );
                }
            }
            //This attempts to add the item to the scoop inventory and if successful, removes it from the map.
            if( add_item( here, vp.part(), *that_item_there ) ) {
                here.i_rem( position, that_item_there );
            } else {
                break;
            }
        }
    }
}

void vehicle::alarm( map &here )
{
    if( one_in( 4 ) ) {
        //first check if the alarm is still installed
        bool found_alarm = has_security_working( here );

        //if alarm found, make noise, else set alarm disabled
        if( found_alarm ) {
            if( &here == &reality_bubble() ) { // TODO: Make sound handling map aware.
                const std::array<std::string, 4> sound_msgs = { {
                        _( "WHOOP WHOOP" ), _( "NEEeu NEEeu NEEeu" ), _( "BLEEEEEEP" ), _( "WREEP" )
                    }
                };
                sounds::sound( pos_bub( here ), static_cast<int>( rng( 45, 80 ) ),
                               sounds::sound_t::alarm, random_entry_ref( sound_msgs ), false, "vehicle", "car_alarm" );
            }
            if( one_in( 1000 ) ) {
                is_alarm_on = false;
            }
        } else {
            is_alarm_on = false;
        }
    }
}

/**
 * Opens an openable part at the specified index. If it's a multipart, opens
 * all attached parts as well.
 * @param part_index The index in the parts list of the part to open.
 */
void vehicle::open( map &here, int part_index )
{
    vehicle_part &vp = part( part_index );
    if( !vp.info().has_flag( VPFLAG_OPENABLE ) ) {
        debugmsg( "Attempted to open non-openable part %d (%s) on a %s!", part_index, vp.name(), name );
    } else {
        open_or_close( here, part_index, true );
    }
}

/**
 * Closes an openable part at the specified index. If it's a multipart, closes
 * all attached parts as well.
 * @param part_index The index in the parts list of the part to close.
 */
void vehicle::close( map &here, int part_index )
{
    vehicle_part &vp = part( part_index );
    if( !vp.info().has_flag( VPFLAG_OPENABLE ) ) {
        debugmsg( "Attempted to close non-closeable part %d (%s) on a %s!", part_index, vp.name(), name );
    } else {
        open_or_close( here, part_index, false );
    }
}

/**
 * Unlocks a lockable, closed part at the specified index. If it's a multipart, unlocks
 * all attached parts as well. Does not affect vehicle is_locked flag.
 * @param part_index The index in the parts list of the part to unlock.
 */
void vehicle::unlock( int part_index )
{
    vehicle_part &vp = part( part_index );
    if( !vp.info().has_flag( "LOCKABLE_DOOR" ) ) {
        debugmsg( "Attempted to unlock non-lockable part %d (%s) on a %s!", part_index, vp.name(), name );
    } else {
        lock_or_unlock( part_index, false );
    }
}

/**
 * Locks a lockable, closed part at the specified index. If it's a multipart, locks
 * all attached parts as well. Does not affect vehicle is_locked flag.
 * @param part_index The index in the parts list of the part to lock.
 */
void vehicle::lock( int part_index )
{
    vehicle_part &vp = part( part_index );
    if( !vp.info().has_flag( "LOCKABLE_DOOR" ) ) {
        debugmsg( "Attempted to lock non-lockable part %d (%s) on a %s!", part_index, vp.name(), name );
    } else if( vp.open ) {
        debugmsg( "Attempted to lock open part %d (%s) on a %s!", part_index, vp.name(), name );
    } else {
        lock_or_unlock( part_index, true );
    }
}

bool vehicle::can_close( int part_index, Character &who )
{
    part_index = get_non_fake_part( part_index );
    std::vector<std::vector<int>> openable_parts = find_lines_of_parts( part_index, "OPENABLE" );
    if( openable_parts.empty() ) {
        std::vector<int> base_element;
        base_element.push_back( part_index );
        openable_parts.emplace_back( base_element );
    }
    for( const std::vector<int> &vec : openable_parts ) {
        for( int partID : vec ) {
            // Check the part for collisions, then if there's a fake part present check that too.
            while( partID >= 0 ) {
                if( doors::check_mon_blocking_door( who, abs_part_pos( parts[partID] ) ) ) {
                    return false;
                }
                if( parts[partID].has_fake &&
                    parts[partID].fake_part_at < static_cast<int>( parts.size() ) &&
                    parts[parts[partID].fake_part_at].is_active_fake ) {
                    partID = parts[partID].fake_part_at;
                } else {
                    partID = -1;
                }
            }
        }
    }
    return true;
}

void vehicle::open_all_at( map &here, int p )
{
    for( const int elem : parts_at_relative( parts[p].mount, true, true ) ) {
        const vehicle_part &vp = parts[elem];
        if( vp.info().has_flag( VPFLAG_OPENABLE ) ) {
            // Note that this will open multi-square and non-multipart parts in the tile. This
            // means that adjacent open multi-square openables can still have closed stuff
            // on same tile after this function returns
            open( here, elem );
        }
    }
}

/**
 * Opens or closes an openable part at the specified index based on the @opening value passed.
 * If it's a multipart, opens or closes all attached parts as well.
 * @param part_index The index in the parts list of the part to open or close.
 */
void vehicle::open_or_close( map &here, const int part_index, const bool opening )
{
    const auto part_open_or_close = [&]( const int parti, const bool opening ) {
        vehicle_part &prt = parts.at( parti );
        // Open doors should never be locked.
        if( opening && prt.locked ) {
            unlock( parti );
        }
        prt.open = opening;
        if( prt.is_fake ) {
            parts.at( prt.fake_part_to ).open = opening;
        } else if( prt.has_fake ) {
            parts.at( prt.fake_part_at ).open = opening;
        }
    };
    //find_lines_of_parts() doesn't return the part_index we passed, so we set it on its own
    part_open_or_close( part_index, opening );
    insides_dirty = true;
    here.set_transparency_cache_dirty( sm_pos.z() );
    const tripoint_abs_ms part_location = mount_to_tripoint_abs( parts[part_index].mount );
    here.set_seen_cache_dirty( here.get_bub( part_location ) );
    const int dist = rl_dist( get_player_character().pos_abs(), part_location );
    if( dist < 20 ) {
        sfx::play_variant_sound( opening ? "vehicle_open" : "vehicle_close",
                                 parts[ part_index ].info().id.str(), 100 - dist * 3 );
    }
    for( const std::vector<int> &vec : find_lines_of_parts( part_index, "OPENABLE" ) ) {
        for( const int &partID : vec ) {
            part_open_or_close( partID, opening );
        }
    }

    coeff_air_changed = true;
    coeff_air_dirty = true;
}

/**
 * Locks or unlocks a lockable door part at the specified index based on the @locking value passed.
 * Part must have the OPENABLE and LOCKABLE_DOOR flags, and be closed.
 * If it's a multipart, locks or unlocks all attached parts as well.
 * @param part_index The index in the parts list of the part to lock or unlock.
 */
void vehicle::lock_or_unlock( const int part_index, const bool locking )
{
    const auto part_lock_or_unlock = [&]( const int parti, const bool locking ) {
        vehicle_part &prt = parts.at( parti );
        prt.locked = locking;
        if( prt.is_fake ) {
            parts.at( prt.fake_part_to ).locked = locking;
        } else if( prt.has_fake ) {
            parts.at( prt.fake_part_at ).locked = locking;
        }
    };
    //find_lines_of_parts() doesn't return the part_index we passed, so we set it on its own
    part_lock_or_unlock( part_index, locking );
    for( const std::vector<int> &vec : find_lines_of_parts( part_index, "LOCKABLE_DOOR" ) ) {
        for( const int &partID : vec ) {
            part_lock_or_unlock( partID, locking );
        }
    }
}

void vehicle::use_autoclave( map &here, int p )
{
    use_vehicle_appliance( get_player_character(), here, *this, p );
}

void vehicle::use_washing_machine( map &here, int p )
{
    use_vehicle_appliance( get_player_character(), here, *this, p );
}

void vehicle::use_dishwasher( map &here, int p )
{
    use_vehicle_appliance( get_player_character(), here, *this, p );
}

void vehicle::use_mws( map &here, int p )
{
    use_vehicle_appliance( get_player_character(), here, *this, p );
}

void vehicle::use_auto_cooker( map &here, int p )
{
    use_vehicle_appliance( get_player_character(), here, *this, p );
}

void vehicle::use_nl_boiler( map &here, int p )
{
    use_vehicle_appliance( get_player_character(), here, *this, p );
}

void vehicle::use_monster_capture( int part, map */*here*/, const tripoint_bub_ms &pos )
{
    if( parts[part].is_broken() || parts[part].removed ) {
        return;
    }
    item base = item( parts[part].get_base() );
    // TODO: Use map aware invoke when available
    base.type->invoke( &get_avatar(), base, pos );
    if( base.has_var( "contained_name" ) ) {
        parts[part].set_flag( vp_flag::animal_flag );
    } else {
        parts[part].remove_flag( vp_flag::animal_flag );
    }
    parts[part].set_base( std::move( base ) );
    invalidate_mass();
}

static void place_carried_furniture( map &here, vehicle_part &part )
{
    static const std::string item_var_string = "tied_down_furniture";
    furn_str_id tied_down_furniture( part.get_base().get_var( item_var_string ) );
    if( !tied_down_furniture.is_valid() ) {
        debugmsg( "Invalid stored furniture %s", tied_down_furniture.str() );
        item base_copy( part.get_base() );
        base_copy.erase_var( item_var_string ); // to prevent bricking the item
        part.set_base( std::move( base_copy ) );
        return;
    }

    const std::function<bool( const tripoint_bub_ms & )> tile_without_furniture_obstruction =
    [&here]( const tripoint_bub_ms & target ) {
        // target does not have furniture or any vehicle part
        // TODO: Where else can't we place a new furniture? There must be a common function for this
        if( !here.has_furn( target ) && !here.veh_at( target ) ) {
            return true;
        }
        return false;
    };

    // doesn't actually display for choose_adjacent_highlight since we don't allow auto selection
    std::string fail_msg =
        _( "Can't put furniture there.  There is a vehicle or another furniture in the way." );

    std::optional<tripoint_bub_ms> selected_tile = choose_adjacent_highlight( here,
            string_format( _( "Select where to place the %s." ), tied_down_furniture->name() ),
            fail_msg,
            tile_without_furniture_obstruction, false, false );

    if( selected_tile ) {
        part.unload_furniture( here, *selected_tile );
    } else {
        add_msg( fail_msg ); // user cancelled or picked invalid tile
    }
}

static void pickup_furniture_for_carry( map &here, vehicle_part &part )
{
    const std::function<bool( const tripoint_bub_ms & )> tile_with_furniture =
    [&here]( const tripoint_bub_ms & target ) {
        return here.has_furn( target );
    };

    std::optional<tripoint_bub_ms> selected_tile = choose_adjacent_highlight( here,
            _( "Select a furniture to load into the vehicle." ),
            _( "No adjacent furniture." ),
            tile_with_furniture, false, true );

    if( !selected_tile ) {
        return; // no adjacent furniture (they got msg) or they cancelled on purpose, so just return
    }

    const furn_str_id picked_up_furn = here.furn( *selected_tile )->id;

    const Character &you = get_player_character();
    // FURNITURE_LIFT_ASSIST gives 5 bonus strength for the lift check
    const int part_lifting_bonus = part.info().has_flag( "FURNITURE_LIFT_ASSIST" ) ? 5 : 0;
    const int lifting_str_available = you.get_lift_str() + you.get_lift_assist() + part_lifting_bonus;

    // This handles cranes, the actual "LIFT" quality, and all that. Sure, you can boom crane a freezer onto the back of a truck. Why not.
    const bool crane_lift = you.best_nearby_lifting_assist() >= picked_up_furn->mass;

    if( picked_up_furn->move_str_req < 0 ) {
        add_msg( _( "That furniture can't be moved." ) );
        return;
    } else if( !crane_lift && picked_up_furn->move_str_req > lifting_str_available ) {
        if( you.get_lift_assist() > 0 ) {
            add_msg( string_format( _( "Even working together, you are unable to lift the %s." ),
                                    picked_up_furn->name() ) );
        } else {
            add_msg( string_format( _( "You aren't able to lift the %s on your own." ),
                                    picked_up_furn->name() ) );
        }
        return;
    }

    part.load_furniture( here, *selected_tile );
}

void vehicle::use_tiedown_furniture( int part, map *here, const tripoint_bub_ms & )
{
    if( !here ) {
        // should never happen!
        debugmsg( "vehicle::use_tiedown_furniture() called without a map pointer, please report this error" );
        return;
    }

    if( parts[part].is_broken() || parts[part].removed ) {
        add_msg( _( "The %s is broken and cannot be used." ), parts[part].name() );
        return;
    }


    const bool will_unload_furniture = parts[part].get_base().has_var( "tied_down_furniture" );

    if( !get_items( parts[part] ).empty() && !will_unload_furniture ) {
        add_msg( m_warning, _( "Can't store furniture while there are items in the way." ) );
        return;
    }

    if( will_unload_furniture ) {
        place_carried_furniture( *here, parts[part] );
    } else {
        pickup_furniture_for_carry( *here, parts[part] );
    }

    invalidate_mass();
}

void vehicle::use_harness( int part, map *here, const tripoint_bub_ms &pos )
{
    if( !here || part < 0 || part >= part_count() ) {
        debugmsg( "use_harness called on invalid part" );
        return;
    }
    Character &who = get_player_character();
    if( auto choice = query_vehicle_harness( who, *here, *this, here->get_abs( pos ),
                      parts[part].get_base().uid().get_value() ) ) {
        if( !cata_mp::client_vehicle_control( *choice ) ) {
            execute_vehicle_control( who, *here, *choice );
        }
    }
}

void vehicle::build_bike_rack_menu( map &here, veh_menu &menu, int part )
{
    // prevent racking two vehicles with same name on single vehicle
    // @returns true if vehicle already has a vehicle with this name racked
    const auto has_veh_name_racked = [this]( const std::string & name ) {
        for( const vpart_reference &vpr : get_any_parts( "BIKE_RACK_VEH" ) ) {
            for( const unrackable_vehicle &unrackable : find_vehicles_to_unrack( vpr.part_index() ) ) {
                if( unrackable.name == name ) {
                    return true;
                }
            }
        }
        return false;
    };

    menu.desc_lines_hint = std::max( 1, menu.desc_lines_hint );
    bool has_rack_actions = false;

    for( const rackable_vehicle &rackable : find_vehicles_to_rack( &here,  part ) ) {
        const bool has_this_name_racked = has_veh_name_racked( rackable.name );

        menu.add( string_format( _( "Attach the %s to the rack" ), rackable.name ) )
        .desc( has_this_name_racked
               ? string_format( _( "This vehicle already has '%s' racked.  "
                                   "Please rename before racking." ), rackable.name )
               : "" )
        .enable( !has_this_name_racked )
        .hotkey_auto()
        .skip_locked_check()
        .on_submit( [this, rackable] {
            bikerack_racking_activity_actor rack( *this, *rackable.veh, rackable.racks );
            get_player_character().assign_activity( rack );
        } );

        has_rack_actions = true;
    }

    for( const unrackable_vehicle &unrackable : find_vehicles_to_unrack(
             part, /*only_healthy=*/ false ) ) {
        menu.add( string_format( _( "Remove the %s from the rack" ), unrackable.name ) )
        .hotkey_auto()
        .skip_locked_check()
        .on_submit( [this, unrackable] {
            bikerack_unracking_activity_actor unrack( *this, unrackable.parts, unrackable.racks );
            get_player_character().assign_activity( unrack );
        } );

        has_rack_actions = true;
    }

    if( !has_rack_actions ) {
        menu.add( _( "Bike rack is empty" ) )
        .desc( _( "Nothing to take off or put on the rack is nearby." ) )
        .enable( false )
        .skip_locked_check();
    }
}

void vpart_position::form_inventory( map &here, temp_crafting_inventory &inv,
                                     std::set<::vehicle *> &veh ) const
{
    if( const std::optional<vpart_reference> vp_cargo = part_with_feature( VPFLAG_CARGO, true ) ) {
        for( item &it : vp_cargo->items() ) {
            // crafting query walks the whole tree under each entry, so a container
            // holding a reserved provider is hidden with it
            if( craft_reservation::contains_reserved( it ) ) {
                continue;
            }
            if( it.empty_container() && it.is_watertight_container() ) {
                const int count = it.count_by_charges() ? it.charges : 1;
                inv.update_liq_container_count( it.typeId(), count );
            }
            inv.add_item_loc( item_location( vehicle_cursor( vp_cargo->vehicle(), vp_cargo->part_index() ),
                                             &it ) );
        }
    }

    // HACK: water_faucet pseudo tool gives access to liquids in tanks
    const std::optional<vpart_reference> vp_faucet =
        part_with_unreserved_tool( here, itype_water_faucet );
    if( vp_faucet ) {
        if( veh.find( &vehicle() ) == veh.end() ) {
            inv.add_pseudo_item( itype_water_faucet );
            for( const item *it : vehicle().fuel_items_left() ) {
                if( it->made_of( phase_id::LIQUID ) ) {
                    item fuel( *it );
                    inv.add_item_copy( fuel );
                }
            }
            veh.insert( &vehicle() );
        }
    }

    for( const vpart_tool_source &src_tool : get_tools_with_sources( here ) ) {
        if( get_craft_reservations().vehicle_part_reserved( src_tool.part_base_uid ) ) {
            continue;
        }
        inv.add_pseudo_item( src_tool.tool );
    }
}

std::map<std::string, multimag_pocket_state>
vehicle::prepare_multimag_pockets( vehicle &veh, map &here, item &tool )
{
    return prepare_multimag_pockets( veh, here, tool, gun_mode_DEFAULT, itype_id::NULL_ID() );
}

std::map<std::string, multimag_pocket_state>
vehicle::prepare_multimag_pockets( vehicle &veh, map &here, item &tool,
                                   const gun_mode_id &mode, const itype_id &preferred_primary )
{
    using state_t = multimag_pocket_state;
    std::map<std::string, state_t> out;
    if( !tool.uses_firing_requirements() ) {
        return out;
    }
    // TODO(multimag): this reads the base itype firing_requirements and raw
    // per-pocket qty. It does not resolve gunmod-owned modes
    // (mode_firing_requirements), nor apply consumption_mods / capacity_mods.
    // Mods on a vehicle-mounted multimag host are out of scope here.
    const std::vector<pocket_consumption_entry> *entries =
        tool.type->firing_requirements.for_mode( mode );
    if( entries == nullptr ) {
        return out;
    }
    // Accumulate "claimed" budget per source so two pockets cannot double-load
    // the same store. Battery network is a single global pool; tanks track
    // per vpart index so live per-part reads stay accurate.
    int battery_claimed = 0;
    std::map<int, int> tank_claimed_by_vpart;

    for( const pocket_consumption_entry &pce : *entries ) {
        item_pocket *pkt = tool.pocket_by_id( pce.pocket );
        if( pkt == nullptr ) {
            continue;
        }
        const pocket_data *pdat = pkt->get_pocket_data();
        if( pdat == nullptr ) {
            continue;
        }
        // Any existing content blocks prep, else drain_back would bill the
        // vehicle for player-owned charges via the initial_qty delta.
        if( !pkt->empty() ) {
            continue;
        }

        if( tool.pocket_accepts_battery( pkt ) ) {
            const int batt_total = static_cast<int>(
                                       std::min<int64_t>( veh.battery_left( here ), INT_MAX ) );
            const int batt_avail = std::max( 0, batt_total - battery_claimed );
            if( pdat->type == pocket_type::MAGAZINE_WELL ) {
                itype_id mag_type = pdat->default_magazine;
                if( mag_type.is_null() && !pdat->item_id_restriction.empty() ) {
                    mag_type = *pdat->item_id_restriction.begin();
                }
                if( mag_type.is_null() ) {
                    continue;
                }
                item mag( mag_type );
                mag.clear_items();
                const int cap = mag.ammo_capacity( ammo_battery );
                const int set_qty = std::min( batt_avail, cap );
                mag.ammo_set( itype_battery, set_qty );
                if( pkt->insert_item( mag ).success() ) {
                    battery_claimed += set_qty;
                    state_t st;
                    st.kind = state_t::source_kind::BATTERY;
                    st.initial_qty = tool.ammo_remaining_in_pocket( pce.pocket );
                    out.emplace( pce.pocket, st );
                }
            } else if( pdat->type == pocket_type::MAGAZINE ) {
                // Direct MAGAZINE battery pocket: insert raw battery items
                // capped by the pocket's own capacity (no synthesized mag).
                const int set_qty = std::min( batt_avail,
                                              pkt->remaining_ammo_capacity( ammo_battery ) );
                if( set_qty > 0 ) {
                    item ammo_it( itype_battery, calendar::turn, set_qty );
                    if( pkt->insert_item( ammo_it ).success() ) {
                        battery_claimed += set_qty;
                        state_t st;
                        st.kind = state_t::source_kind::BATTERY;
                        st.initial_qty = tool.ammo_remaining_in_pocket( pce.pocket );
                        out.emplace( pce.pocket, st );
                    }
                }
            }
            continue;
        }
        // Resolve which ammo_restriction map to feed from a vehicle tank.
        // - Direct MAGAZINE: pocket's own ammo_restriction.
        // - MAGAZINE_WELL: synthesize a magazine of the well's accepted itype
        //   and use that magazine's MAGAZINE pocket ammo_restriction.
        const std::map<ammotype, int> *target_restriction = nullptr;
        itype_id synth_mag_type = itype_id::NULL_ID();
        if( pdat->type == pocket_type::MAGAZINE && !pdat->ammo_restriction.empty() ) {
            target_restriction = &pdat->ammo_restriction;
        } else if( pdat->type == pocket_type::MAGAZINE_WELL && !pdat->item_id_restriction.empty() ) {
            synth_mag_type = pdat->default_magazine.is_null() ?
                             *pdat->item_id_restriction.begin() : pdat->default_magazine;
            if( !synth_mag_type->magazine ) {
                continue;
            }
            for( const pocket_data &mp : synth_mag_type->pockets ) {
                if( mp.type == pocket_type::MAGAZINE && !mp.ammo_restriction.empty() ) {
                    target_restriction = &mp.ammo_restriction;
                    break;
                }
            }
            if( target_restriction == nullptr ) {
                continue;
            }
        } else {
            continue;
        }

        bool placed = false;
        // Two-pass tank picker: first pass honors `preferred_primary` if set
        // (ammo_select preference for multi-tank turrets). Second pass falls
        // back to first-match. Skips entirely if preference is not set.
        for( int pass = 0; pass < 2 && !placed; pass++ ) {
            const bool prefer_only = pass == 0 && !preferred_primary.is_null();
            if( pass == 0 && preferred_primary.is_null() ) {
                continue;
            }
            for( const std::pair<const ammotype, int> &ar : *target_restriction ) {
                // Scan tanks; record the exact vpart and ammo itype so
                // drain_back_multimag bills the same store with no re-search.
                for( const vpart_reference &tvp :
                     veh.get_avail_parts( vpart_bitflags::VPFLAG_FLUIDTANK ) ) {
                    const itype_id &tank_ammo = tvp.part().ammo_current();
                    if( tank_ammo.is_null() || !tank_ammo->ammo ) {
                        continue;
                    }
                    if( tank_ammo->ammo->type != ar.first ) {
                        continue;
                    }
                    if( prefer_only && tank_ammo != preferred_primary ) {
                        continue;
                    }
                    const int vp_idx = static_cast<int>( tvp.part_index() );
                    // Per-part ammo so two same-fuel tanks each have their own
                    // budget; whole-vehicle fuel_left would let two pockets
                    // double-claim the same global total.
                    const int total = tvp.part().ammo_remaining();
                    const int avail = std::max( 0, total - tank_claimed_by_vpart[vp_idx] );
                    // Skip tanks that cannot fully cover one shot's requirement.
                    // Otherwise a low tank would bind the pocket and starve a
                    // sibling tank that could feed the gun. Use effective_qty
                    // so gunmod ammo_to_fire / energy_drain modifiers count.
                    if( avail < tool.effective_qty( pce ) ) {
                        continue;
                    }
                    const int set_qty = std::min( avail, ar.second );
                    bool inserted = false;
                    if( synth_mag_type.is_null() ) {
                        item ammo_it( tank_ammo, calendar::turn, set_qty );
                        inserted = pkt->insert_item( ammo_it ).success();
                    } else {
                        item mag( synth_mag_type );
                        mag.clear_items();
                        mag.ammo_set( tank_ammo, set_qty );
                        inserted = pkt->insert_item( mag ).success();
                    }
                    if( inserted ) {
                        tank_claimed_by_vpart[vp_idx] += set_qty;
                        state_t st;
                        st.kind = state_t::source_kind::TANK;
                        st.vpart_index = vp_idx;
                        st.initial_qty = tool.ammo_remaining_in_pocket( pce.pocket );
                        out.emplace( pce.pocket, st );
                        placed = true;
                        break;
                    }
                }
                if( placed ) {
                    break;
                }
            }
        }
    }
    return out;
}

void vehicle::drain_back_multimag( vehicle &veh, map &here, const item &tool,
                                   const std::map<std::string, multimag_pocket_state> &bindings )
{
    using state_t = multimag_pocket_state;
    if( !tool.uses_firing_requirements() ) {
        return;
    }
    for( const std::pair<const std::string, state_t> &b : bindings ) {
        const std::string &pocket_id = b.first;
        const state_t &st = b.second;
        const int after = tool.ammo_remaining_in_pocket( pocket_id );
        const int delta = st.initial_qty - after;
        if( delta <= 0 ) {
            continue;
        }
        switch( st.kind ) {
            case state_t::source_kind::BATTERY:
                veh.discharge_battery( here, delta );
                break;
            case state_t::source_kind::TANK:
                if( st.vpart_index >= 0 ) {
                    veh.drain( here, st.vpart_index, delta );
                }
                break;
        }
    }
}

int vehicle::run_legacy_charge_tool_uses( map &here, const itype_id &tool_type, int uses )
{
    if( uses <= 0 || !tool_type->tool ) {
        return 0;
    }
    const int per_use = tool_type->charges_to_use();
    if( per_use <= 0 ) {
        return 0;
    }
    item tool( tool_type, calendar::turn );
    const int ammo_in_tool = prepare_tool( here, tool );
    const int max_uses = ammo_in_tool / per_use;
    const int do_uses = std::min( uses, max_uses );
    if( do_uses <= 0 ) {
        return 0;
    }
    const int got_uses = tool.consume_tool_uses( do_uses, here,
                         tripoint_bub_ms::zero, nullptr );
    const int consumed = ammo_in_tool - tool.ammo_remaining_linked( here, nullptr );
    if( consumed > 0 ) {
        discharge_battery( here, consumed );
    }
    return got_uses;
}

std::pair<const itype_id &, int> vehicle::tool_ammo_available( map &here,
        const itype_id &tool_type ) const
{
    if( !tool_type->tool ) {
        return { itype_id::NULL_ID(), 0 };
    }
    const itype_id &ft = tool_type->tool_slot_first_ammo();
    if( ft.is_null() ) {
        return { itype_id::NULL_ID(), 0 };
    }
    // 2 bil ought to be enough for everyone, and hopefully not overflow int
    const int64_t max = 2000000000;
    if( ft->ammo->type == ammo_battery ) {
        return { ft, static_cast<int>( std::min<int64_t>( battery_left( here ), max ) ) };
    } else {
        return { ft, static_cast<int>( std::min<int64_t>( fuel_left( here, ft ), max ) ) };
    }
}

int vehicle::prepare_tool( map &here, item &tool ) const
{
    tool.set_flag( json_flag_PSEUDO );

    if( tool.uses_firing_requirements() ) {
        // const_cast is safe: prepare_multimag_pockets only mutates the tool
        // and re-reads vehicle state. It does not modify vehicle storage.
        const std::map<std::string, multimag_pocket_state> bindings =
            vehicle::prepare_multimag_pockets( const_cast<vehicle &>( *this ), here, tool );
        int total = 0;
        for( const std::pair<const std::string, multimag_pocket_state> &b : bindings ) {
            total = std::min( INT_MAX - b.second.initial_qty, total ) + b.second.initial_qty;
        }
        return total;
    }

    const auto &[ammo_itype_id, ammo_amount] = tool_ammo_available( here, tool.typeId() );
    if( ammo_itype_id.is_null() ) {
        return 0; // likely tool needs no ammo
    }
    item mag_mod( itype_pseudo_magazine_mod );
    mag_mod.set_flag( json_flag_IRREMOVABLE );
    if( !tool.put_in( mag_mod, pocket_type::MOD ).success() ) {
        debugmsg( "tool %s has no space for a %s, this is likely a bug",
                  tool.typeId().str(), mag_mod.type->nname( 1 ) );
    }
    itype_id mag_type;
    if( tool.can_link_up() ) {
        mag_type = itype_pseudo_magazine;
    } else {
        mag_type = tool.magazine_default();
    }
    item mag( mag_type );
    mag.clear_items(); // no initial ammo
    if( !tool.put_in( mag, pocket_type::MAGAZINE_WELL ).success() ) {
        debugmsg( "inserting %s into %s's MAGAZINE_WELL pocket failed",
                  mag.typeId().str(), tool.typeId().str() );
        return 0;
    }

    const int ammo_capacity = tool.ammo_capacity( ammo_itype_id->ammo->type );
    const int ammo_count = std::min( ammo_amount, ammo_capacity );

    tool.ammo_set( ammo_itype_id, ammo_count );

    add_msg_debug( debugmode::DF_VEHICLE, "prepared vehtool %s with %d %s",
                   tool.typeId().str(), ammo_count, ammo_itype_id.str() );

    return ammo_count;
}

bool vehicle::use_vehicle_tool( vehicle &veh, map *here, const tripoint_bub_ms &vp_pos,
                                const itype_id &tool_type, bool no_invoke )
{
    return invoke_vehicle_tool( get_player_character(), veh, *here, vp_pos, tool_type, {}, no_invoke );
}

bool invoke_vehicle_tool( Character &who, vehicle &veh, map &terrain,
                          const tripoint_bub_ms &vp_pos, const itype_id &tool_type,
                          const std::string &method, bool no_invoke )
{
    map *here = &terrain;
    const character_action_guard lifetime( who );
    const int64_t vehicle_id = veh.uid().get_value();
    item tool( tool_type, calendar::turn );
    const bool is_multimag = !tool_type->firing_requirements.empty();
    std::map<std::string, multimag_pocket_state> mm_bindings;
    int ammo_in_tool = 0;
    int avail_ammo_amount = 0;
    itype_id ammo_type_id = itype_id::NULL_ID();
    if( is_multimag ) {
        tool.set_flag( json_flag_PSEUDO );
        mm_bindings = vehicle::prepare_multimag_pockets( veh, *here, tool );
        if( tool.feasible_tool_uses( /*external_pool=*/0 ) < 1 ) {
            return false;
        }
    } else {
        const auto &[type_id, amount] = veh.tool_ammo_available( *here, tool_type );
        ammo_type_id = type_id;
        avail_ammo_amount = amount;
        ammo_in_tool = veh.prepare_tool( *here, tool );
        if( tool.ammo_required() > avail_ammo_amount ) {
            return false;
        }
    }
    const bool is_battery_tool = !ammo_type_id.is_null() && ammo_type_id->ammo->type == ammo_battery;
    if( !no_invoke ) {
        // TODO: pass map or go abs
        if( method.empty() ) {
            who.invoke_item( &tool, vp_pos );
        } else {
            const item_activation_choices choices;
            who.invoke_item( &tool, method, vp_pos, who.get_moves(), &choices );
        }
    }

    if( !lifetime || vehicle::find_vehicle_by_uid( terrain, vehicle_id ) != &veh ) {
        return true;
    }

    // HACK: Evil hack incoming
    player_activity &act = who.activity;
    if( !act.actor && act.id() == ACT_REPAIR_ITEM &&
        ( tool_type == itype_welder ||
          tool_type == itype_welder_crude ||
          tool_type == itype_welding_kit ||
          tool_type == itype_soldering_iron ||
          tool_type == itype_small_repairkit ||
          tool_type == itype_large_repairkit
        ) ) {
        act.index = INT_MIN; // tell activity the item doesn't really exist
        act.coords.push_back( here->get_abs( vp_pos ) ); // tell it to search for the tool on `pos`
        act.str_values.push_back( tool_type.str() ); // specific tool on the rig
    }


    // Older heater actors still receive the mounted position here. The owned
    // heater already retains the vehicle, hardware and tool identities.
    if( dynamic_cast<heat_activity_actor *>( act.actor.get() ) ) {
        act.coords.push_back( here->get_abs( vp_pos ) );
    }

    if( is_multimag ) {
        vehicle::drain_back_multimag( veh, *here, tool, mm_bindings );
    } else {
        const int used_charges = ammo_in_tool - tool.ammo_remaining_linked( *here, nullptr );
        if( used_charges > 0 ) {
            if( is_battery_tool ) {
                // if tool has less battery charges than it started with - discharge from vehicle batteries
                veh.discharge_battery( *here, used_charges );
            } else {
                veh.drain( here, tool.ammo_current(), used_charges );
            }
        }
    }
    return true;
}

void vehicle::build_interact_menu( veh_menu &menu, map *here, const tripoint_bub_ms &p,
                                   bool with_pickup )
{
    const optional_vpart_position ovp = here->veh_at( p );
    if( !ovp ) {
        debugmsg( "vehicle::build_interact_menu couldn't find vehicle at %s", p.to_string() );
        return;
    }
    const vpart_position vp = *ovp;
    const tripoint_bub_ms vppos = vp.pos_bub( *here );

    std::vector<vehicle_part *> vp_parts = get_parts_at( here, vppos, "", part_status_flag::working );

    // @returns true if pos contains available part with a flag
    const auto has_part_here = [vp_parts]( const std::string & flag ) {
        return std::any_of( vp_parts.begin(), vp_parts.end(), [flag]( const vehicle_part * vp_part ) {
            return vp_part->info().has_flag( flag );
        } );
    };

    const bool remote = g->remoteveh() == this;
    const bool has_electronic_controls = remote
                                         ? has_parts( {"CTRL_ELECTRONIC", "REMOTE_CONTROL"} ).any()
                                         : has_part_here( "CTRL_ELECTRONIC" );
    const bool controls_here = has_part_here( "CONTROLS" );
    const bool player_is_driving = player_in_control( *here, get_player_character() );
    const bool player_inside = here->veh_at( get_player_character().pos_abs() ) ?
                               &here->veh_at( get_player_character().pos_abs() )->vehicle() == this :
                               false;
    const auto control_action = [this, here, vppos,
          remote_source = menu.remote_controller]( const std::string & action ) {
        Character &who = get_player_character();
        const auto selection = action == "autopilot" ?
                               query_vehicle_autopilot( who, *here, *this, here->get_abs( vppos ), remote_source ) :
                               action == "engines" ? query_vehicle_engines( who, *here, *this, here->get_abs( vppos ),
                                       remote_source ) :
                               query_vehicle_control( who, *here, *this, here->get_abs( vppos ), action, remote_source );
        if( selection && !cata_mp::client_vehicle_control( *selection ) ) {
            execute_vehicle_control( who, *here, *selection, remote_source );
        }
    };
    bool power_linked = false;
    bool item_linked = false;
    bool tow_linked = false;
    for( vehicle_part *vp_part : vp_parts ) {
        power_linked = power_linked || vp_part->info().has_flag( VPFLAG_POWER_TRANSFER );
        item_linked = item_linked || vp_part->has_flag( vp_flag::linked_flag );
        tow_linked = tow_linked || vp_part->info().has_flag( "TOW_CABLE" );
    }

    if( !is_appliance() ) {
        menu.add( _( "Examine vehicle" ) )
        .skip_theft_check()
        .skip_locked_check()
        .hotkey( "EXAMINE_VEHICLE" )
        .on_submit( [this, vp] {
            const vpart_position non_fake( *this, get_non_fake_part( vp.part_index() ) );
            const point_rel_ms start_pos = non_fake.mount_pos().rotate( 2 );
            g->exam_vehicle( *this, start_pos );
        } );

        menu.add( tracking_on ? _( "Forget vehicle position" ) : _( "Remember vehicle position" ) )
        .skip_theft_check()
        .skip_locked_check()
        .keep_menu_open()
        .hotkey( "TOGGLE_TRACKING" )
        .on_submit( [this] { toggle_tracking(); } );
    }

    if( has_visible_effect() ) {
        menu.add( _( "Examine vehicle effects" ) )
        .skip_theft_check()
        .skip_locked_check()
        .on_submit( [this] { display_effects(); } );
    }

    bool has_immobilizer = false;
    for( const vehicle_part *vp : vp_parts ) {
        if( vp->has_fault_flag( "IMMOBILIZER" ) ) {
            has_immobilizer = true;
        }
    }

    if( ( is_locked || has_immobilizer ) && controls_here ) {
        if( player_inside ) {
            ///\EFFECT_MECHANICS speeds up vehicle hotwiring
            const float skill = std::max( 1.0f, get_player_character().get_skill_level( skill_mechanics ) );
            const time_duration required_time = 6000_seconds / skill;
            const std::string time_string = colorize( to_string( required_time, true ), c_light_gray );
            std::string description = _( "Attempt to hotwire the car using a screwdriver." );
            description += "\n";
            description += _( "Time to complete: " );
            description += time_string;

            menu.add( _( "Hotwire" ) )
            .skip_theft_check()
            .enable( get_player_character().crafting_inventory().has_quality( qual_SCREW ) )
            .desc( description )
            .skip_locked_check()
            .hotkey( "HOTWIRE" )
            .on_submit( [control_action] { control_action( "hotwire" ); } );
        }

        if( !is_alarm_on && has_security_working( *here ) ) {
            menu.add( _( "Trigger the alarm" ) )
            .skip_theft_check()
            .desc( _( "Trigger the alarm to make noise." ) )
            .skip_locked_check()
            .hotkey( "TOGGLE_ALARM" )
            .on_submit( [control_action] { control_action( "alarm" ); } );
        }
    }

    if( is_alarm_on && controls_here && !is_moving() && player_inside ) {
        menu.add( _( "Try to smash alarm" ) )
        .skip_theft_check()
        .skip_locked_check()
        .hotkey( "TOGGLE_ALARM" )
        .on_submit( [control_action] { control_action( "smash_alarm" ); } );
    }
    for( const vpart_reference &vp : this->get_avail_parts( "EOC_ACTIVATION" ) ) {
        vehicle_part &part = vp.part();
        menu.add( string_format( _( "Activate  %s" ), vp.part().name() ) )
        .on_submit( [this, &part] {
            if( part.info().activatable_eoc )
            {
                dialogue newDialog( get_talker_for( get_player_character() ), nullptr );
                part.info().activatable_eoc.value()->activate( newDialog );
            }
            cata::lua_platform::invoke_vehicle_part_activation_handler(
                part.info().id.str(), *this, part, get_player_character() );
        } );
    }


    if( remote ) {
        menu.add( _( "Stop controlling" ) )
        .hotkey( "RELEASE_CONTROLS" )
        .skip_theft_check()
        .on_submit( [control_action] {
            control_action( "release" );
        } );
    } else {
        if( has_part( "ENGINE" ) ) {
            if( ( controls_here && player_is_driving ) || ( remote && engine_on ) ) {
                menu.add( _( "Stop driving" ) )
                .hotkey( "TOGGLE_ENGINE" )
                .skip_theft_check()
                .on_submit( [control_action] {
                    control_action( "stop_driving" );
                } );
            } else if( controls_here && has_engine_type_not( fuel_type_muscle, true ) ) {
                menu.add( engine_on ? colorize( _( "Turn off the engine" ), c_pink ) : _( "Turn on the engine" ) )
                .hotkey( "TOGGLE_ENGINE" )
                .skip_theft_check()
                .on_submit( [this, control_action] {
                    control_action( engine_on ? "stop" : "start" );
                } );
            }
        }

        if( player_is_driving ) {
            menu.add( _( "Let go of controls" ) )
            .hotkey( "RELEASE_CONTROLS" )
            .skip_locked_check() // in case player somehow controls locked vehicle
            .skip_theft_check()
            .on_submit( [control_action] {
                control_action( "release" );
            } );

            menu.add( _( "Pull handbrake" ) )
            .hotkey( "PULL_HANDBRAKE" )
            .on_submit( [here] { handbrake( *here ); } );

            menu.add( turning_arc ? _( "Cancel turning assistance" ) :
                      _( "Choose turning control point" ) )
            .skip_theft_check()
            .on_submit( [] { g->vehicle_turning_assist(); } );

            menu.add( g->vehicle_guidance ? _( "Hide driving guidance" ) :
                      _( "Show driving guidance" ) )
            .skip_theft_check()
            .on_submit( [] { g->vehicle_guidance = !g->vehicle_guidance; } );
        }

        const bool has_engine_or_fuel_controls = ( engines.size() > 1 ) ||
        std::any_of( engines.begin(), engines.end(), [&]( int engine_idx ) {
            return parts[engine_idx].info().engine_info->fuel_opts.size() > 1;
        } );

        if( controls_here && has_engine_or_fuel_controls ) {
            menu.add( _( "Control individual engines" ) )
            .skip_theft_check()
            .hotkey( "CONTROL_ENGINES" )
            .on_submit( [control_action] { control_action( "engines" ); } );
        }
    }

    if( controls_here && has_part( "AUTOPILOT" ) && has_electronic_controls ) {
        menu.add( _( "Control autopilot" ) )
        .skip_theft_check()
        .hotkey( "CONTROL_AUTOPILOT" )
        .on_submit( [control_action] { control_action( "autopilot" ); } );
    }

    if( is_appliance() || vp.avail_part_with_feature( "CTRL_ELECTRONIC" ) ) {
        build_electronics_menu( *here, menu );
    }

    if( has_electronic_controls && has_part( "SMART_ENGINE_CONTROLLER" ) ) {
        menu.add( _( "Smart controller settings" ) )
        .hotkey( "CONTROL_SMART_ENGINE" )
        .on_submit( [this] {
            if( !smart_controller_cfg )
            {
                smart_controller_cfg = smart_controller_config();
            }

            smart_controller_settings cfg_view = smart_controller_settings(
                has_enabled_smart_controller,
                smart_controller_cfg -> battery_lo,
                smart_controller_cfg -> battery_hi );
            smart_controller_ui( cfg_view ).control();
            for( const vpart_reference &vp : get_avail_parts( "SMART_ENGINE_CONTROLLER" ) )
            {
                vp.part().enabled = cfg_view.enabled;
            }
        } );
    }

    const turret_data turret = turret_query( vp.pos_abs( ) );

    if( turret.can_unload() ) {
        menu.add( string_format( _( "Unload %s" ), turret.name() ) )
        .hotkey( "UNLOAD_TURRET" )
        .skip_locked_check()
        .on_submit( [this, vppos, here] {
            item_location loc = turret_query( here, vppos ).base();
            get_player_character().unload( loc );
        } );
    }

    if( turret.can_reload() ) {
        menu.add( string_format( _( "Reload %s" ), turret.name() ) )
        .hotkey( "RELOAD_TURRET" )
        .skip_locked_check()
        .on_submit( [this, vppos, here] {
            item_location loc = turret_query( here, vppos ).base();
            item::reload_option opt = get_player_character().select_ammo( loc, true );
            if( opt )
            {
                reload_activity_actor reload_act( std::move( opt ) );
                get_player_character().assign_activity( reload_act );
            }
        } );
    }

    if( controls_here && has_part( "TURRET" ) ) {
        menu.add( _( "Set turret targeting modes" ) )
        .hotkey( "TURRET_TARGET_MODE" )
        .skip_theft_check()
        .on_submit( [this, here, vppos] {
            use_vehicle_turrets( get_player_character(), *here, *this, here->get_abs( vppos ), "targeting" );
        } );

        menu.add( _( "Set turret firing modes" ) )
        .hotkey( "TURRET_FIRE_MODE" )
        .skip_theft_check()
        .on_submit( [this, here, vppos] {
            use_vehicle_turrets( get_player_character(), *here, *this, here->get_abs( vppos ), "mode" );
        } );

        // We can also fire manual turrets with ACTION_FIRE while standing at the controls.
        menu.add( _( "Aim turrets manually" ) )
        .hotkey( "TURRET_MANUAL_AIM" )
        .skip_theft_check()
        .on_submit( [this, here, vppos] {
            use_vehicle_turrets( get_player_character(), *here, *this, here->get_abs( vppos ), "aim_manual" );
        } );

        // This lets us manually override and set the target for the automatic turrets instead.
        menu.add( _( "Aim automatic turrets" ) )
        .hotkey( "TURRET_MANUAL_OVERRIDE" )
        .skip_theft_check()
        .on_submit( [this, here, vppos] {
            use_vehicle_turrets( get_player_character(), *here, *this, here->get_abs( vppos ), "aim_auto" );
        } );

        menu.add( _( "Aim individual turret" ) )
        .hotkey( "TURRET_SINGLE_FIRE" )
        .skip_theft_check()
        .on_submit( [this, here, vppos] {
            use_vehicle_turrets( get_player_character(), *here, *this, here->get_abs( vppos ), "aim_single" );
        } );
    }

    if( controls_here ) {
        if( has_part( "HORN" ) ) {
            menu.add( _( "Honk horn" ) )
            .skip_theft_check()
            .skip_locked_check()
            .hotkey( "SOUND_HORN" )
            .on_submit( [control_action] { control_action( "horn" ); } );
        }
    }

    if( power_linked ) {
        menu.add( _( "Disconnect power connections" ) )
        .enable( !item_linked && !tow_linked )
        .desc( string_format( !item_linked && !tow_linked ? "" : _( "Remove other cables first" ) ) )
        .skip_locked_check()
        .hotkey( "DISCONNECT_CABLES" )
        .on_submit( [here, this, vp] {
            unlink_cables( *here, vp.mount_pos(), get_player_character(), true, true, true );
            get_player_character().pause();
        } );
    }
    if( item_linked || tow_linked ) {
        std::string menu_text = item_linked && tow_linked ? _( "Disconnect items and tow cables" ) :
                                item_linked ? _( "Disconnect items" ) : _( "Disconnect tow cables" );
        menu.add( menu_text )
        .skip_locked_check()
        .hotkey( "DISCONNECT_CABLES" )
        .on_submit( [here, this, vp] {
            unlink_cables( *here, vp.mount_pos(), get_player_character(), true, true, false );
            get_player_character().pause();
        } );
    }

    for( const auto&[tool_item, hk] : vp.get_tools( *here ) ) {
        const itype_id &tool_type = tool_item.typeId();
        if( !tool_type->has_use() ) {
            continue; // passive tool
        }
        if( hk == -1 ) {
            continue; // skip old passive tools
        }
        if( tool_type->use_methods.size() == 1 &&
            immediate_vehicle_tool_method( tool_type->use_methods.begin()->first ) ) {
            continue; // Stable owner-aware entries are added below.
        }
        const auto &[tool_ammo, ammo_amount ] = tool_ammo_available( *here, tool_type );
        bool enabled;
        if( !tool_type->firing_requirements.empty() ) {
            item tmp( tool_type, calendar::turn );
            prepare_tool( *here, tmp );
            enabled = tmp.feasible_tool_uses( /*external_pool=*/0 ) >= 1;
        } else {
            enabled = ammo_amount >= tool_item.typeId()->charges_to_use();
        }
        menu.add( string_format( _( "Use %s" ), tool_type->nname( 1 ) ) )
        .enable( enabled )
        .hotkey( hk )
        .skip_locked_check( tool_ammo.is_null() || tool_ammo->ammo->type != ammo_battery )
        .on_submit( [this, vppos, tool_type, here] { use_vehicle_tool( *this, here, vppos, tool_type ); } );
    }

    add_vehicle_tool_use_menu( menu, *here, *this, here->get_abs( vppos ) );
    add_vehicle_appliance_menu( menu, *here, *this, here->get_abs( vppos ) );

    const std::optional<vpart_reference> vp_cargo = vp.cargo();
    // Whether vehicle part (cargo) contains items, and whether map tile (ground) has items
    if( with_pickup && (
            here->has_items( vp.pos_bub( *here ) ) ||
            ( vp_cargo && !vp_cargo->items().empty() ) ) ) {
        menu.add( _( "Get items" ) )
        .hotkey( "GET_ITEMS" )
        .skip_locked_check()
        .skip_theft_check()
        .on_submit( [vppos] { g->pickup( vppos ); } );
    }

    const std::optional<vpart_reference> vp_curtain = vp.avail_part_with_feature( "CURTAIN" );
    if( vp_curtain && !vp_curtain->part().open ) {
        menu.add( _( "Peek through the closed curtains" ) )
        .hotkey( "CURTAIN_PEEK" )
        .skip_locked_check()
        .on_submit( [vppos] {
            add_msg( _( "You carefully peek through the curtains." ) );
            g->peek( vppos );
        } );
    }

    add_vehicle_water_menu( menu, *here, *this, here->get_abs( vppos ) );

    const std::optional<vpart_reference> vp_monster_capture =
        vp.avail_part_with_feature( "CAPTURE_MONSTER_VEH" );
    if( vp_monster_capture ) {
        const size_t mc_idx = vp_monster_capture->part_index();
        menu.add( _( "Capture or release a creature" ) )
        .hotkey( "USE_CAPTURE_MONSTER_VEH" )
        .on_submit( [this, mc_idx, vppos, here] { use_monster_capture( mc_idx, here, vppos ); } );
    }

    const std::optional<vpart_reference> vp_furniture_tiedown =
        vp.avail_part_with_feature( "FURNITURE_TIEDOWN" );
    if( vp_furniture_tiedown ) {
        const size_t mc_idx = vp_furniture_tiedown->part_index();
        menu.add( _( "Tie down or remove a furniture" ) )
        .hotkey( "USE_TIEDOWN_FURNITURE_VEH" )
        .on_submit( [this, mc_idx, vppos, here] { use_tiedown_furniture( mc_idx, here, vppos ); } );
    }

    const std::optional<vpart_reference> vp_bike_rack = vp.avail_part_with_feature( "BIKE_RACK_VEH" );
    if( vp_bike_rack ) {
        build_bike_rack_menu( *here, menu, vp_bike_rack->part_index() );
    }

    const std::optional<vpart_reference> vp_harness = vp.avail_part_with_feature( "ANIMAL_CTRL" );
    if( vp_harness ) {
        const size_t hn_idx = vp_harness->part_index();
        menu.add( _( "Harness an animal" ) )
        .hotkey( "USE_ANIMAL_CTRL" )
        .on_submit( [this, hn_idx, here, vppos] { use_harness( hn_idx, here, vppos ); } )
        .skip_theft_check();
    }

    if( vp.avail_part_with_feature( "PLANTER" ) ) {
        menu.add( _( "Reload seed drill with seeds" ) )
        .hotkey( "USE_PLANTER" )
        .on_submit( [this, vppos, here] { reload_seeds( here, vppos ); } );
    }

    const std::optional<vpart_reference> vp_workbench = vp.avail_part_with_feature( "WORKBENCH" );
    if( vp_workbench ) {
        const size_t wb_idx = vp_workbench->part_index();
        menu.add( string_format( _( "Craft at the %s" ), vp_workbench->part().name() ) )
        .hotkey( "USE_WORKBENCH" )
        .skip_locked_check()
        .on_submit( [this, wb_idx, vppos] {
            const vpart_reference vp_workbench( *this, wb_idx );
            iexamine::workbench_internal( get_player_character(), vppos, vp_workbench );
        } );
    }

    // Browsing is not a transfer: incompatible legacy tools remain detachable
    // instead of being silently moved into the menu viewer's inventory.
    add_vehicle_toolstation_menu( menu, *here, *this, here->get_abs( vppos ) );

    if( is_foldable() && !remote ) {
        menu.add( string_format( _( "Fold %s" ), name ) )
        .hotkey( "FOLD_VEHICLE" )
        .skip_theft_check()
        .skip_locked_check()
        .on_submit( [control_action] { control_action( "fold" ); } );
    }

    const std::optional<vpart_reference> vp_lockable_door =
        vp.avail_part_with_feature( "LOCKABLE_DOOR" );
    const std::optional<vpart_reference> vp_door_lock = vp.avail_part_with_feature( "DOOR_LOCKING" );
    if( vp_lockable_door && vp_door_lock && !vp_lockable_door->part().open ) {
        if( doors::can_lock_door( *here, get_player_character(), p ) ) {
            menu.add( string_format( _( "Lock %s" ), vp_lockable_door->part().name() ) )
            .hotkey( "LOCK_DOOR" )
            .on_submit( [p, here] {
                doors::lock_door( *here, get_player_character(), p );
            } );
        } else if( doors::can_unlock_door( *here, get_player_character(), p ) ) {
            menu.add( string_format( _( "Unlock %s" ), vp_lockable_door->part().name() ) )
            .hotkey( "UNLOCK_DOOR" )
            .on_submit( [p, here] {
                doors::unlock_door( *here, get_player_character(), p );
            } );
        } else if( vp_lockable_door->part().locked ) {
            menu.add( string_format( _( "Check the lock on %s" ), vp_lockable_door->part().name() ) )
            .hotkey( "LOCKPICK" )
            .on_submit( [p] {
                iexamine::locked_object( get_player_character(), p );
            } );
        }
    }
}

void vehicle::interact_with( map *here, const tripoint_bub_ms &p, bool with_pickup )
{
    const optional_vpart_position ovp = here->veh_at( p );
    if( !ovp ) {
        debugmsg( "interact_with called at %s and no vehicle is found", p.to_string() );
        return;
    }

    veh_menu menu( *this, _( "Select an action" ) );
    do {
        menu.reset();
        build_interact_menu( menu, here, p, with_pickup );
    } while( menu.query() );
}
