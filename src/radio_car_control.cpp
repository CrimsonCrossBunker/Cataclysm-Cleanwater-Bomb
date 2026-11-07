#include "radio_car_control.h"

#include <charconv>
#include <initializer_list>
#include <limits>
#include <string>
#include <sstream>

#include "bionics.h"
#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "flag.h"
#include "game.h"
#include "game_constants.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "line.h"
#include "map.h"
#include "map_selector.h"
#include "math_parser_diag_value.h"
#include "sounds.h"
#include "translations.h"
#include "units.h"

namespace
{
constexpr const char *car_key = "radio_car_uid";
constexpr const char *position_key = "radio_car_position";
constexpr const char *controller_key = "radio_car_controller_uid";
constexpr const char *bionic_key = "radio_car_bionic_uid";
constexpr const char *legacy_key = "remote_controlling";

int64_t read_id( const Character &who, const char *key )
{
    const diag_value *value = who.maybe_get_value( key );
    if( !value ) {
        return 0;
    }
    const std::string &text = value->str();
    int64_t result = 0;
    const auto parsed = std::from_chars( text.data(), text.data() + text.size(), result );
    return parsed.ec == std::errc() && parsed.ptr == text.data() + text.size() && result > 0 ?
           result : 0;
}

void store_binding( Character &who, const radio_car_binding &binding )
{
    who.remove_value( legacy_key );
    who.set_value( car_key, std::to_string( binding.car ) );
    who.set_value( position_key, binding.position );
    who.set_value( controller_key, std::to_string( binding.controller ) );
    who.set_value( bionic_key, std::to_string( binding.bionic ) );
}

bool powered( const Character &who, const radio_car_binding &binding )
{
    if( who.is_dead_state() ) {
        return false;
    }
    if( binding.bionic ) {
        const auto bio = who.find_bionic_by_uid( binding.bionic );
        return bio && ( *bio )->id == bionic_id( "bio_remote" ) && ( *bio )->powered &&
               ( *bio )->incapacitated_time == 0_turns && who.get_power_level() >= 1_kJ;
    }
    const auto sources = who.items_with( [&]( const item & source ) {
        return source.uid().get_value() == binding.controller;
    } );
    return sources.size() == 1 && sources.front()->active && !sources.front()->is_broken() &&
           sources.front()->type->can_use( "RADIOCONTROL" ) &&
           sources.front()->ammo_sufficient( &who, "RADIOCONTROL" );
}

item_location car_at( map &here, const radio_car_binding &binding )
{
    if( !here.inbounds( binding.position ) ) {
        return item_location();
    }
    const tripoint_bub_ms position = here.get_bub( binding.position );
    for( item &candidate : here.i_at( position ) ) {
        if( candidate.uid().get_value() == binding.car && candidate.active &&
            candidate.has_flag( flag_RADIOCAR ) ) {
            return item_location( map_cursor( position ), &candidate );
        }
    }
    return item_location();
}

bool reachable( const Character &who, const radio_car_binding &binding )
{
    return who.pos_abs().z() == binding.position.z() &&
           rl_dist( who.pos_abs(), binding.position ) <= MAX_VIEW_DISTANCE;
}
} // namespace

std::optional<radio_car_binding> read_radio_car_binding( const Character &who, map &here )
{
    radio_car_binding result;
    result.car = read_id( who, car_key );
    if( result.car ) {
        const diag_value *position = who.maybe_get_value( position_key );
        const int64_t bionic = read_id( who, bionic_key );
        if( !position || bionic > std::numeric_limits<unsigned int>::max() ) {
            return std::nullopt;
        }
        result.position = position->tripoint();
        result.controller = read_id( who, controller_key );
        result.bionic = static_cast<unsigned int>( bionic );
        return result;
    }
    const diag_value *legacy = who.maybe_get_value( legacy_key );
    if( !legacy ) {
        return std::nullopt;
    }
    const tripoint_bub_ms position( legacy->tripoint().raw() );
    if( !here.inbounds( position ) ) {
        return std::nullopt;
    }
    for( item &candidate : here.i_at( position ) ) {
        if( candidate.active && candidate.has_flag( flag_RADIOCAR ) ) {
            result.car = candidate.uid().get_value();
            result.position = here.get_abs( position );
            break;
        }
    }
    if( !result.car ) {
        return std::nullopt;
    }
    const auto controllers = who.items_with( []( const item & source ) {
        return source.active && source.type->can_use( "RADIOCONTROL" );
    } );
    if( !controllers.empty() ) {
        result.controller = controllers.front()->uid().get_value();
    } else {
        for( const bionic &bio : *who.my_bionics ) {
            if( bio.id == bionic_id( "bio_remote" ) && bio.powered ) {
                result.bionic = bio.get_uid();
                break;
            }
        }
    }
    return result;
}

bool has_radio_car_binding( const Character &who )
{
    return who.maybe_get_value( car_key ) || who.maybe_get_value( legacy_key );
}

bool has_radio_car_control( const Character &who, map &here )
{
    const auto binding = read_radio_car_binding( who, here );
    return binding && powered( who, *binding ) && reachable( who, *binding ) &&
           car_at( here, *binding );
}

void disconnect_radio_car( Character &who )
{
    for( const char *key : {
             car_key, position_key, controller_key, bionic_key, legacy_key
         } ) {
        who.remove_value( key );
    }
}

bool connect_radio_car( Character &who, map &here, const item &controller )
{
    radio_car_binding binding;
    if( who.has_item( controller ) ) {
        binding.controller = controller.uid().get_value();
    } else if( controller.has_flag( flag_USES_BIONIC_POWER ) ) {
        for( const bionic &bio : *who.my_bionics ) {
            if( bio.id == bionic_id( "bio_remote" ) && bio.powered ) {
                binding.bionic = bio.get_uid();
                break;
            }
        }
    }
    if( !binding.controller && !binding.bionic ) {
        return false;
    }
    // Retain the native last-matching-car selection order, but search the
    // operator's floor and radio range rather than the host avatar's floor.
    for( int x = 0; x < here.getmapsize() * SEEX; ++x ) {
        for( int y = 0; y < here.getmapsize() * SEEY; ++y ) {
            const tripoint_bub_ms position( x, y, who.pos_bub().z() );
            if( rl_dist( who.pos_bub(), position ) > MAX_VIEW_DISTANCE ) {
                continue;
            }
            for( item &candidate : here.i_at( position ) ) {
                if( !candidate.active || !candidate.has_flag( flag_RADIOCAR ) ) {
                    continue;
                }
                const int64_t uid = candidate.uid().get_value();
                const bool occupied = !g->get_creatures_if( [&]( const Creature & creature ) {
                    const Character *other = creature.as_character();
                    const auto connection = other && other != &who ? read_radio_car_binding( *other, here ) :
                                            std::nullopt;
                    return connection && connection->car == uid && powered( *other, *connection ) &&
                           reachable( *other, *connection );
                } ).empty();
                if( !occupied ) {
                    binding.car = uid;
                    binding.position = here.get_abs( position );
                }
            }
        }
    }
    if( !binding.car ) {
        return false;
    }
    store_binding( who, binding );
    return true;
}

bool radio_car_uses_controller( const Character &who, map &here, const item &controller )
{
    const auto binding = read_radio_car_binding( who, here );
    return binding && binding->controller == controller.uid().get_value();
}

bool radio_car_uses_bionic( const Character &who, map &here, unsigned int uid )
{
    const auto binding = read_radio_car_binding( who, here );
    return binding && binding->bionic == uid;
}

bool drive_radio_car( Character &who, map &here, const point_rel_ms &direction,
                      const radio_car_binding &expected )
{
    if( who.activity || who.get_moves() <= 0 || direction == point_rel_ms::zero ||
        direction.x() < -1 || direction.x() > 1 || direction.y() < -1 || direction.y() > 1 ) {
        return false;
    }
    const auto binding = read_radio_car_binding( who, here );
    if( !binding || binding->car != expected.car || binding->position != expected.position ) {
        return false;
    }
    item_location source = car_at( here, *binding );
    if( !source || !powered( who, *binding ) || !reachable( who, *binding ) ) {
        disconnect_radio_car( who );
        who.add_msg_if_player( m_warning, _( "No radio car connected." ) );
        return false;
    }
    const tripoint_bub_ms from = here.get_bub( binding->position );
    const tripoint_bub_ms destination = from + direction;
    if( !here.inbounds( destination ) || here.impassable( destination ) ||
        !here.can_put_items_ter_furn( destination ) || here.has_furn( destination ) ) {
        sounds::sound( destination, 7, sounds::sound_t::combat,
                       _( "sound of a collision with an obstacle." ), true, "misc", "rc_car_hits_obstacle" );
        return false;
    }
    store_binding( who, *binding ); // Upgrade legacy coordinates before moving the item.
    const character_action_guard lifetime( who );
    // Current-state reconstruction keeps the car and contained batteries' IDs.
    // Transactional placement rechecks the source after any drop callback.
    std::ostringstream encoded;
    JsonOut out( encoded );
    source->serialize( out );
    item payload = item::from_current_state( json_loader::from_string( encoded.str() ).get_object() );
    if( here.transfer_item_or_charges( destination, source, std::move( payload ), who,
                                       rl_dist( who.pos_abs(), binding->position ), false ) != 1 ) {
        return false;
    }
    if( !lifetime ) {
        return true;
    }
    who.mod_moves( -to_moves<int>( 1_seconds ) / 2 );
    sounds::sound( from, 6, sounds::sound_t::movement, _( "zzz…" ), true, "misc", "rc_car_drives" );
    const auto current = read_radio_car_binding( who, here );
    if( current && current->car == binding->car && current->position == binding->position ) {
        radio_car_binding updated = *binding;
        updated.position = here.get_abs( destination );
        store_binding( who, updated );
    }
    return true;
}

void write_radio_car_binding( const Character &who, map &here, JsonOut &out )
{
    const auto binding = read_radio_car_binding( who, here );
    out.start_object();
    out.member( "car", binding ? binding->car : 0 );
    if( binding ) {
        out.member( "position", binding->position );
        out.member( "controller", binding->controller );
        out.member( "bionic", binding->bionic );
    }
    out.end_object();
}

void apply_radio_car_binding( Character &who, const JsonObject &data )
{
    radio_car_binding binding;
    data.read( "car", binding.car, true );
    if( binding.car > 0 ) {
        data.read( "position", binding.position, true );
        data.read( "controller", binding.controller, true );
        data.read( "bionic", binding.bionic, true );
        store_binding( who, binding );
    } else {
        disconnect_radio_car( who );
    }
}
