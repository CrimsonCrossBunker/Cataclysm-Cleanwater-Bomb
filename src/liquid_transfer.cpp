#include "liquid_transfer.h"

#include <algorithm>
#include <cstddef>
#include <utility>
#include <memory>

#include "activity_actor.h"
#include "activity_handlers.h"
#include "craft_reservation.h"

#include "character.h"
#include "character_action_guard.h"
#include "finite_water.h"
#include "fermentation_vessel.h"
#include "handle_liquid.h"
#include "iexamine.h"
#include "item.h"
#include "item_location.h"
#include "item_source.h"
#include "item_uid.h"
#include "item_unload.h"
#include "line.h"
#include "json.h"
#include "tool_activity_target.h"
#include "map.h"
#include "mapdata.h"
#include "player_activity.h"
#include "vehicle.h"
#include "vehicle_water.h"
#include "vpart_position.h"
#include "vpart_range.h"

namespace
{
bool reachable_furniture( const Character &who, map &here, const tool_activity_target &station )
{
    const tripoint_abs_ms origin = who.pos_abs();
    if( who.is_dead_state() || who.cant_do_mounted( false ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) || origin.z() != station.position.z() ||
        !here.inbounds( station.position ) || square_dist( origin, station.position ) > 1 ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( station.position );
    return here.has_loaded_submap( tile ) && here.has_furn( tile ) && !here.veh_at( tile ) &&
           station.matches( here ) && !get_craft_reservations().provider_tile_reserved( station.position );
}

bool available_furniture_liquid( Character &who, const item_location &batch, const itype_id &type )
{
    return batch && batch.where() == item_location::type::map && !batch.has_parent() &&
           batch->typeId() == type && batch->is_owned_by( who, true ) &&
           !activity_handlers::activity_item_reserved_for_other( *batch, who );
}

bool resolve_furniture_destination( Character &who, map &here, const item &liquid,
                                    const tripoint_abs_ms &source, const unload_liquid_choice &choice,
                                    liquid_dest_opt &destination, std::optional<int> &tank )
{
    if( choice.source != liquid.uid().get_value() || !liquid.made_of( phase_id::LIQUID ) ||
        !liquid.count_by_charges() || liquid.charges <= 0 ||
        ( ( choice.kind == LD_GROUND || choice.kind == LD_KEG ) &&
          ( choice.position == source || !here.inbounds( choice.position ) ||
            !here.has_loaded_submap( here.get_bub( choice.position ) ) ) ) ||
        ( choice.kind == LD_KEG && !iexamine::has_keg( here.get_bub( choice.position ) ) ) ||
        !resolve_liquid_destination( who, choice, liquid, destination, tank ) ) {
        return false;
    }
    if( choice.kind == LD_GROUND ) {
        return !iexamine::has_keg( destination.pos ) && here.can_put_items_ter_furn( destination.pos );
    }
    return choice.kind != LD_ITEM ||
           ( destination.item_loc->is_owned_by( who, true ) &&
             !activity_handlers::activity_item_reserved_for_other( *destination.item_loc, who ) );
}

void dispense_furniture_liquid( player_activity &activity, Character &who,
                                const item_source &source,
                                const tool_activity_target &station, const itype_id &expected_type,
                                const unload_liquid_choice &choice )
{
    map &here = get_map();
    if( source.path.size() != 1 || source.position != station.position ||
        !reachable_furniture( who, here, station ) ) {
        activity.set_to_null();
        return;
    }
    item_location batch = resolve_furniture_item( here, source.position, source.path.front() );
    liquid_dest_opt destination;
    std::optional<int> tank;
    if( !available_furniture_liquid( who, batch, expected_type ) ||
        !resolve_furniture_destination( who, here, *batch, source.position, choice, destination, tank ) ) {
        activity.set_to_null();
        return;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const auto generation = activity.identity_generation();
    const tripoint_abs_ms position = source.position;
    const itype_id type = batch->typeId();
    const int amount = std::min( batch->charges, std::max( 1,
        batch->charges_per_volume( units::from_liter( 4.0F / 6.0F ) ) ) );
    item portion( *batch );
    portion.charges = amount;
    int unpoured;
    if( destination.dest_opt == LD_GROUND &&
        !finite_water::can_pour_into( here.get_abs( destination.pos ) ) ) {
        const tripoint_bub_ms tile = here.get_bub( position );
        const bool sealed = here.furn( tile )->has_flag( ter_furn_flag::TFLAG_SEALED );
        const int moved = sealed ?
                          here.unload_furniture_item( destination.pos, batch, std::move( portion ), who ) :
                          here.transfer_item_or_charges( destination.pos, batch, std::move( portion ), who, 1, true );
        unpoured = amount - moved;
    } else {
        // Reserve the charges before destination callbacks can touch the source stack.
        batch->charges -= amount;
        liquid_handler::transfer_liquid( who, portion, destination, tank, true, false );
        unpoured = std::clamp( portion.charges, 0, amount );
        if( context && batch && batch->typeId() == type ) {
            batch->charges += unpoured;
            if( batch->charges == 0 ) {
                batch.remove_item();
            }
        }
    }
    const bool remains = context && batch && batch->typeId() == type && batch->charges > 0 &&
                         batch.pos_abs() == position;
    if( !lifetime || activity.identity_generation() != generation ) {
        return;
    }
    if( unpoured < amount ) {
        who.set_moves( 0 );
    }
    if( unpoured || !remains ) {
        activity.set_to_null();
    }
}

class owned_liquid_transfer_actor : public activity_actor
{
    public:
        item_source source;
        unload_liquid_choice destination;
        std::optional<tool_activity_target> furniture_source;
        itype_id furniture_liquid_type;
        std::optional<tool_activity_target> keg_destination;
        character_id operator_id;
        const activity_id &get_type() const override {
            static const activity_id id( "ACT_FILL_LIQUID" );
            return id;
        }
        void start( player_activity &act, Character & ) override {
            act.moves_total = act.moves_left = 1;
        }
        void do_turn( player_activity &act, Character &who ) override {
            if( source.kind == "fermentation_vessel" ) {
                fermentation_vessel::drain_turn( act, who, source, destination );
            } else if( is_vehicle_liquid_source( source ) ) {
                vehicle_liquid_transfer_turn( act, who, source, destination );
            } else if( source.kind == "map" && furniture_source && operator_id == who.getID() ) {
                map &here = get_map();
                if( keg_destination &&
                    ( !here.has_loaded_submap( here.get_bub( keg_destination->position ) ) ||
                      !keg_destination->matches( here ) ) ) {
                    act.set_to_null();
                    return;
                }
                dispense_furniture_liquid( act, who, source, *furniture_source, furniture_liquid_type,
                                           destination );
            } else {
                act.set_to_null();
            }
        }
        void assign_to( Character &who ) const {
            player_activity activity( *this );
            activity.set_execution( activity_execution::authoritative );
            who.assign_activity( activity );
        }
        void finish( player_activity &act, Character & ) override {
            act.set_to_null();
        }
        std::unique_ptr<activity_actor> clone() const override {
            return std::make_unique<owned_liquid_transfer_actor>( *this );
        }
        void serialize( JsonOut &out ) const override {
            out.start_object();
            out.member( "source", source );
            out.member( "destination", destination );
            if( furniture_source ) {
                out.member( "furniture_source", furniture_source );
                out.member( "furniture_liquid_type", furniture_liquid_type );
                out.member( "keg_destination", keg_destination );
                out.member( "operator", operator_id );
            }
            out.end_object();
        }
};
} // namespace

void start_owned_liquid_transfer( Character &who, const item_source &source,
                                  const unload_liquid_choice &destination )
{
    owned_liquid_transfer_actor actor;
    actor.source = source;
    actor.destination = destination;
    actor.assign_to( who );
}

bool start_furniture_liquid_transfer( Character &who, map &here, const item_location &source,
                                      const tool_activity_target &station,
                                      const unload_liquid_choice &choice )
{
    const character_action_guard lifetime( who );
    liquid_dest_opt destination;
    std::optional<int> tank;
    if( !lifetime || who.activity || who.get_moves() <= 0 || !source ||
        source.pos_abs() != station.position ||
        !reachable_furniture( who, here, station ) ||
        !available_furniture_liquid( who, source, source->typeId() ) ||
        resolve_furniture_item( here, station.position, source->uid().get_value() ) != source ||
        !resolve_furniture_destination( who, here, *source, station.position, choice, destination,
                                        tank ) ) {
        return false;
    }
    owned_liquid_transfer_actor actor;
    actor.source = capture_item_source( who, source );
    actor.destination = choice;
    actor.furniture_source = station;
    actor.furniture_liquid_type = source->typeId();
    actor.operator_id = who.getID();
    if( choice.kind == LD_KEG ) {
        actor.keg_destination = tool_activity_target::capture( here, choice.position );
    }
    actor.assign_to( who );
    return lifetime && who.activity.id() == actor.get_type();
}

std::unique_ptr<activity_actor> deserialize_owned_liquid_transfer( JsonValue &data )
{
    owned_liquid_transfer_actor actor;
    const JsonObject object = data.get_object();
    object.read( "source", actor.source, true );
    object.read( "destination", actor.destination, true );
    if( object.read( "furniture_source", actor.furniture_source ) ) {
        object.read( "furniture_liquid_type", actor.furniture_liquid_type, true );
        object.read( "keg_destination", actor.keg_destination );
        object.read( "operator", actor.operator_id, true );
    }
    return actor.clone();
}

void append_owned_liquid_transfer_changes( const player_activity &activity,
        std::vector<tripoint_abs_ms> &tiles, std::vector<int64_t> &vehicles )
{
    const auto *actor = dynamic_cast<const owned_liquid_transfer_actor *>( activity.actor.get() );
    if( !actor ) {
        return;
    }
    tiles.push_back( actor->source.position );
    const auto &target = actor->destination;
    if( target.kind == LD_KEG || target.kind == LD_GROUND ) {
        tiles.push_back( target.position );
    } else if( target.kind == LD_ITEM && target.container.kind != "carried" ) {
        tiles.push_back( target.container.position );
    } else if( target.kind == LD_VEH && target.vehicle > 0 ) {
        vehicles.push_back( target.vehicle );
    }
}

namespace liquid_handler
{
bool transfer_liquid( Character &who, item &liquid, liquid_dest_opt target,
                      std::optional<int> tank_part, bool silent, bool charge_moves )
{
    if( !liquid.made_of( phase_id::LIQUID ) || liquid.charges <= 0 ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto context = get_map().get_context_reference();
    switch( target.dest_opt ) {
        case LD_ITEM:
            if( !target.item_loc || target.item_loc.get_item() == &liquid ||
                target.item_loc->has_item( liquid ) ||
                !who.pour_into( target.item_loc, liquid, true, silent ) ) {
                return false;
            }
            if( context && target.item_loc ) {
                target.item_loc.make_active();
            }
            if( charge_moves && lifetime && context ) {
                who.mod_moves( -100 );
            }
            return true;
        case LD_VEH:
            if( !target.veh || !tank_part || *tank_part < 0 ) {
                return false;
            }
            // Resolve the selected index again. Do not dereference an unavailable,
            // incompatible or out-of-range tank, or choose another one.
            for( const vpart_reference &part : target.veh->get_all_parts() ) {
                if( part.part_index() == static_cast<size_t>( *tank_part ) && part.part().is_available() &&
                    part.part().is_tank() && part.part().can_reload( liquid ) ) {
                    if( !who.pour_into( part, liquid ) ) {
                        return false;
                    }
                    if( charge_moves && lifetime && context ) {
                        who.mod_moves( -1000 );
                    }
                    return true;
                }
            }
            return false;
        case LD_KEG:
        case LD_GROUND: {
            map &here = get_map();
            if( !here.inbounds( target.pos ) ||
                ( target.dest_opt == LD_KEG && !iexamine::has_keg( target.pos ) ) ||
                ( target.dest_opt == LD_GROUND && !here.can_put_items_ter_furn( target.pos ) ) ) {
                return false;
            }
            if( target.dest_opt == LD_KEG ) {
                iexamine::pour_into_keg( target.pos, liquid, silent );
            } else if( finite_water::can_pour_into( here.get_abs( target.pos ) ) ) {
                finite_water::pour_into_finite_water( here.get_abs( target.pos ), liquid );
            } else {
                here.add_item_or_charges( target.pos, liquid, true, &who );
                liquid.charges = 0;
            }
            if( charge_moves && lifetime && context ) {
                who.mod_moves( -100 );
            }
            return true;
        }
        case LD_NULL:
        case LD_CONSUME:
        default:
            return false;
    }
}
} // namespace liquid_handler
