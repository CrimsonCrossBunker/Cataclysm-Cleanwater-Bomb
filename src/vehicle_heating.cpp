#include "vehicle_heating.h"

#include <algorithm>
#include <climits>
#include <set>

#include "activity_actor.h"
#include "calendar.h"
#include "cached_options.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "flag.h"
#include "game.h"
#include "item.h"
#include "item_unload.h"
#include "itype.h"
#include "iuse.h"
#include "json.h"
#include "liquid_transfer.h"
#include "map.h"
#include "mapdata.h"
#include "mp_inventory_activity.h"
#include "mp_client_conn.h"
#include "player_activity.h"
#include "rng.h"
#include "translations.h"
#include "uilist.h"
#include "string_formatter.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vehicle_control.h"
#include "vpart_position.h"
#include "vpart_range.h"

namespace
{
bool heating_method( const std::string &method )
{
    return method == "HOTPLATE" || method == "HEAT_SOLID_ITEMS" || method == "HEAT_LIQUID_ITEMS" ||
           method == "HEAT_ALL_ITEMS";
}

bool supplies( const vehicle &target, const vehicle_part &part,
               const vehicle_heating_selection &choice )
{
    if( part.removed || !part.is_available() ||
        part.get_base().uid().get_value() != choice.part ) {
        return false;
    }
    if( choice.installed_tool ) {
        const auto &tools = target.get_tools( part );
        return std::any_of( tools.begin(), tools.end(), [&]( const item & tool ) {
            return tool.typeId().str() == choice.tool &&
                   tool.uid().get_value() == choice.installed_tool;
        } );
    }
    const auto tools = part.info().get_pseudo_tools();
    return std::any_of( tools.begin(), tools.end(), [&]( const auto & tool ) {
        return tool.first.str() == choice.tool;
    } );
}

bool heater_at( const vehicle &target, const tripoint_abs_ms &position,
                const vehicle_heating_selection &choice )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() == position && supplies( target, part.part(), choice ) ) {
            return true;
        }
    }
    return false;
}

struct heating_plan {
    heating_requirements required;
    itype_id fuel;
    int cost;
    int startup_cost;
    drop_locations targets;
};

std::optional<heating_plan> plan_heating( Character &who, map &here, vehicle &target,
        const tripoint_abs_ms &position, const vehicle_heating_selection &choice, bool starting = true )
{
    const itype_id type( choice.tool );
    if( !type.is_valid() || !heating_method( choice.method ) || !type->get_use( choice.method ) ||
        !heater_at( target, position, choice ) || who.pos_abs().z() != position.z() ||
        rl_dist( who.pos_abs(), position ) > 1 || who.is_dead_state() || who.is_mounted() ||
        who.fine_detail_vision_mod() > 4 || choice.items.empty() || choice.items.size() > 256 ) {
        return std::nullopt;
    }
    // A tool description is queried here, not spawned into the simulated world.
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const item tool( type, calendar::turn );
    if( !tool.has_quality( quality_id( "HOTPLATE" ) ) ) {
        return std::nullopt;
    }
    const auto [fuel, available] = target.tool_ammo_available( here, type );
    if( fuel.is_null() || ( fuel->ammo->type == ammotype( "battery" ) && target.is_locked ) ) {
        return std::nullopt;
    }
    const bool multiple = tool.has_pocket_type( pocket_type::CONTAINER );
    if( !multiple && choice.items.size() != 1 ) {
        return std::nullopt;
    }
    std::set<int64_t> seen;
    units::mass frozen = 0_gram;
    units::mass other = 0_gram;
    units::volume volume = 0_ml;
    drop_locations targets;
    for( const auto &selected : choice.items ) {
        const item_location source = resolve_item_source( who, here, selected.first,
                                     multiple ? pickup_range : 1 );
        const int count = selected.second;
        if( !source || !source->has_temperature() || source->has_own_flag( flag_HOT ) ||
            !source->is_owned_by( who, true ) || !seen.insert( source->uid().get_value() ).second ||
            count <= 0 || ( !multiple && count != 1 ) ||
            ( source->count_by_charges() ? count > source->charges : count != 1 ) ) {
            return std::nullopt;
        }
        const bool liquid = source->made_of_from_type( phase_id::LIQUID );
        if( multiple ? ( liquid ? ( choice.method == "HEAT_SOLID_ITEMS" || choice.method == "HOTPLATE" ) ||
                         !source.has_parent() :
                         choice.method == "HEAT_LIQUID_ITEMS" ) :
            ( liquid && !source.has_parent() &&
              !here.has_flag_furn( ter_furn_flag::TFLAG_LIQUIDCONT, source.pos_bub( here ) ) ) ) {
            return std::nullopt;
        }
        for( const drop_location &prior : targets ) {
            if( prior.first->has_item( *source ) || source->has_item( *prior.first ) ) {
                return std::nullopt;
            }
        }
        volume += source->volume( false, true, count );
        if( multiple && volume > tool.max_containable_volume() ) {
            return std::nullopt;
        }
        const units::mass weight = source->count_by_charges() ?
                                   source->weight( false, false ) / source->charges * count :
                                   source->weight( false, false );
        if( source->has_own_flag( flag_FROZEN ) && !source->has_own_flag( flag_EATEN_COLD ) ) {
            frozen += weight;
        } else {
            other += weight;
        }
        targets.emplace_back( source, count );
    }
    auto required = heating_requirements_for_weight( frozen, other, volume );
    const int64_t cost = static_cast<int64_t>( required.ammo ) * type->charges_to_use();
    const int startup = choice.method == "HOTPLATE" ? tool.ammo_required() : 0;
    if( required.time < 0 || cost < 0 || cost > INT_MAX || cost > available ||
        ( starting && startup > available ) ||
        ( multiple && volume > tool.max_containable_volume() ) ) {
        return std::nullopt;
    }
    required.time *= 1.0f - who.get_num_crafting_helpers( 3 ) / 10.0f;
    return heating_plan{ required, fuel, static_cast<int>( cost ), startup, std::move( targets ) };
}

class vehicle_heating_activity_actor : public activity_actor
{
    public:
        int64_t vehicle_id = 0;
        tripoint_abs_ms position;
        vehicle_heating_selection selection;
        int energy = 0;
        itype_id fuel;
        int duration = 0;
        bool heated = false;
        std::vector<item> pending;

        const activity_id &get_type() const override {
            static const activity_id id( "ACT_HEATING" );
            return id;
        }
        void start( player_activity &act, Character & ) override {
            act.moves_total = act.moves_left = duration;
        }
        std::optional<heating_plan> resolve( Character &who ) const {
            map &here = get_map();
            vehicle *target = vehicle::find_vehicle_by_uid( here, vehicle_id );
            auto plan = target ? plan_heating( who, here, *target, position, selection, false ) : std::nullopt;
            if( !plan || plan->cost != energy || plan->fuel != fuel ) {
                return std::nullopt;
            }
            return plan;
        }
        void do_turn( player_activity &act, Character &who ) override {
            if( heated ) {
                act.moves_left = 1;
                who.set_moves( 0 );
                if( who.is_avatar() && !cata_mp::is_client_mode() ) {
                    local_liquids( who );
                }
            } else if( !resolve( who ) ) {
                who.add_msg_if_player( _( "The heater or selected items are no longer available." ) );
                act.set_to_null();
            }
        }
        void finish( player_activity &act, Character &who ) override {
            if( heated ) {
                act.moves_left = 1;
                return;
            }
            auto plan = resolve( who );
            if( !plan ) {
                act.set_to_null();
                return;
            }
            map &here = get_map();
            vehicle *target = vehicle::find_vehicle_by_uid( here, vehicle_id );
            if( fuel->ammo->type == ammotype( "battery" ) ) {
                target->discharge_battery( here, energy );
            } else {
                target->drain( here, fuel, energy );
            }
            // Own every result before delivery can invoke callbacks or cancel the activity.
            std::vector<item> solids;
            for( const drop_location &entry : plan->targets ) {
                item_location source = entry.first;
                item result = *source;
                if( result.count_by_charges() ) {
                    result.charges = entry.second;
                    source->charges -= entry.second;
                    if( source->charges == 0 ) {
                        source.remove_item();
                    } else {
                        source.on_contents_changed();
                    }
                } else {
                    source.remove_item();
                }
                result.heat_up();
                if( result.made_of( phase_id::LIQUID ) ) {
                    pending.push_back( std::move( result ) );
                } else {
                    solids.push_back( std::move( result ) );
                }
            }
            heated = true;
            act.moves_left = 1;
            const character_action_guard lifetime( who );
            const auto generation = act.identity_generation();
            const tripoint_bub_ms fallback = who.pos_bub();
            for( size_t i = 0; i < solids.size(); ++i ) {
                who.i_add_or_drop( solids[i] );
                if( !lifetime ) {
                    for( ++i; i < solids.size(); ++i ) {
                        here.add_item_or_charges( fallback, solids[i] );
                    }
                    return;
                }
            }
            who.invalidate_crafting_inventory();
            if( who.activity.identity_generation() != generation ) {
                return;
            }
            if( pending.empty() ) {
                act.set_to_null();
            } else if( who.is_avatar() && !cata_mp::is_client_mode() ) {
                local_liquids( who );
            }
        }
        void local_liquids( Character &who ) {
            const character_action_guard lifetime( who );
            while( lifetime ) {
                const item *preview = vehicle_heating_liquid( who.activity );
                if( !preview ) {
                    break;
                }
                const auto generation = who.activity.identity_generation();
                const item liquid = *preview;
                const auto choice = query_liquid_destination( liquid, nullptr, liquid.uid().get_value(), true );
                if( !lifetime || who.activity.identity_generation() != generation ) {
                    break;
                }
                if( choice.kind == LD_NULL ) {
                    who.cancel_activity();
                    break;
                }
                if( choice.kind != LD_CONSUME || who.will_eat( liquid, true ).success() ) {
                    apply_vehicle_heating_liquid( who, choice, true );
                }
            }
        }
        void canceled( player_activity &, Character &who ) override {
            std::vector<item> remaining;
            remaining.swap( pending );
            for( const item &liquid : remaining ) {
                get_map().add_item_or_charges( who.pos_bub(), liquid );
            }
        }
        std::unique_ptr<activity_actor> clone() const override {
            return std::make_unique<vehicle_heating_activity_actor>( *this );
        }
        void serialize( JsonOut &out ) const override {
            out.start_object();
            out.member( "vehicle_heating", true );
            out.member( "vehicle", vehicle_id );
            out.member( "position", position );
            out.member( "selection", selection );
            out.member( "energy", energy );
            out.member( "fuel", fuel );
            out.member( "duration", duration );
            out.member( "heated", heated );
            out.member( "pending", pending );
            out.end_object();
        }
};
} // namespace

void vehicle_heating_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "part", part );
    out.member( "installed_tool", installed_tool );
    out.member( "tool", tool );
    out.member( "method", method );
    out.member( "items", items );
    out.end_object();
}

void vehicle_heating_selection::deserialize( const JsonObject &data )
{
    data.read( "part", part, true );
    data.read( "installed_tool", installed_tool, true );
    data.read( "tool", tool, true );
    data.read( "method", method, true );
    data.read( "items", items, true );
}

bool has_vehicle_heater( const vehicle &target, const tripoint_abs_ms &position )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() != position || !part.part().is_available() ) {
            continue;
        }
        const auto suitable = []( const itype_id & type ) {
            return type->get_use( "HOTPLATE" ) || type->get_use( "HEAT_SOLID_ITEMS" ) ||
                   type->get_use( "HEAT_LIQUID_ITEMS" ) ||
                   type->get_use( "HEAT_ALL_ITEMS" );
        };
        for( const auto &tool : part.part().info().get_pseudo_tools() ) {
            if( suitable( tool.first ) ) {
                return true;
            }
        }
        for( const item &tool : target.get_tools( part.part() ) ) {
            if( suitable( tool.typeId() ) ) {
                return true;
            }
        }
    }
    return false;
}

bool valid_vehicle_heating( Character &who, map &here, vehicle &target,
                            const tripoint_abs_ms &position, const vehicle_heating_selection &selection )
{
    return plan_heating( who, here, target, position, selection ).has_value();
}

bool execute_vehicle_heating( Character &who, map &here, vehicle &target,
                              const tripoint_abs_ms &position, const vehicle_heating_selection &selection )
{
    auto plan = plan_heating( who, here, target, position, selection );
    if( !plan ) {
        return false;
    }
    vehicle_heating_activity_actor actor;
    actor.vehicle_id = target.uid().get_value();
    actor.position = position;
    actor.selection = selection;
    actor.energy = plan->cost;
    actor.fuel = plan->fuel;
    actor.duration = plan->required.time;
    const character_action_guard lifetime( who );
    who.assign_activity( actor );
    if( !lifetime ) {
        return false;
    }
    // HOTPLATE consumes one initial use after scheduling, in addition to its
    // timed heating cost. Charge the real vehicle once, never the client copy.
    vehicle *current = vehicle::find_vehicle_by_uid( here, actor.vehicle_id );
    if( !current ) {
        who.cancel_activity();
        return false;
    }
    if( plan->startup_cost > 0 ) {
        if( plan->fuel->ammo->type == ammotype( "battery" ) ) {
            current->discharge_battery( here, plan->startup_cost );
        } else {
            current->drain( here, plan->fuel, plan->startup_cost );
        }
    }
    who.activity.set_execution( activity_execution::authoritative );
    return static_cast<bool>( who.activity );
}

static std::optional<vehicle_control_selection> select_mounted_heating( Character &who,
        const item &tool,
        const tripoint_bub_ms &position, const std::string &method )
{
    map &here = get_map();
    const optional_vpart_position vp = here.veh_at( position );
    if( !vp ) {
        return std::nullopt;
    }
    vehicle &target = vp->vehicle();
    vehicle_heating_selection heating;
    heating.tool = tool.typeId().str();
    heating.method = method;
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_bub( here ) != position || !part.part().is_available() ) {
            continue;
        }
        heating.part = part.part().get_base().uid().get_value();
        heating.installed_tool = 0;
        if( supplies( target, part.part(), heating ) ) {
            break;
        }
        const auto &installed = target.get_tools( part.part() );
        const auto found = std::find_if( installed.begin(), installed.end(), [&]( const item & candidate ) {
            return candidate.typeId() == tool.typeId();
        } );
        if( found != installed.end() ) {
            heating.installed_tool = found->uid().get_value();
            break;
        }
        heating.part = 0;
    }
    if( !heating.part ) {
        return std::nullopt;
    }
    const auto request = query_vehicle_control( who, here, target, here.get_abs( position ),
                         "heating" );
    if( !request ) {
        return std::nullopt;
    }
    const auto [fuel, available] = target.tool_ammo_available( here, tool.typeId() );
    const heater source{ {}, true, available, tool.type->charges_to_use(),
        here.get_abs( position ), true, fuel };
    const auto chosen = query_heating_targets( who, tool, source,
                        ( method == "HEAT_LIQUID_ITEMS" || method == "HEAT_ALL_ITEMS" ),
                        method != "HEAT_LIQUID_ITEMS" );
    if( chosen.empty() ) {
        return std::nullopt;
    }
    for( const drop_location &entry : chosen ) {
        heating.items.emplace_back( capture_item_source( who, entry.first ), entry.second );
    }
    auto selected = *request;
    selected.heating = std::move( heating );
    return selected;
}
bool query_mounted_heating( Character &who, const item &tool,
                            const tripoint_bub_ms &position, const std::string &method )
{
    const auto choice = select_mounted_heating( who, tool, position, method );
    return choice && ( cata_mp::client_vehicle_control( *choice ) ||
                       execute_vehicle_control( who, get_map(), *choice ) );
}

std::optional<vehicle_control_selection> query_vehicle_heating( Character &who, map &here,
        vehicle &target, const tripoint_abs_ms &position )
{
    std::set<std::pair<itype_id, std::string>> found;
    const auto add = [&]( const itype_id & type ) {
        for( const std::string method : {
                 "HOTPLATE", "HEAT_SOLID_ITEMS", "HEAT_LIQUID_ITEMS", "HEAT_ALL_ITEMS"
             } ) {
            if( type->get_use( method ) ) {
                found.emplace( type, method );
            }
        }
    };
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.pos_abs() != position || !part.part().is_available() ) {
            continue;
        }
        for( const auto &tool : part.part().info().get_pseudo_tools() ) {
            add( tool.first );
        }
        for( const item &tool : target.get_tools( part.part() ) ) {
            add( tool.typeId() );
        }
    }
    if( found.empty() ) {
        return std::nullopt;
    }
    const std::vector<std::pair<itype_id, std::string>> options( found.begin(), found.end() );
    int selected = 0;
    if( options.size() > 1 ) {
        uilist menu;
        menu.title = _( "Select a heater" );
        for( size_t i = 0; i < options.size(); ++i ) {
            menu.addentry( i, true, MENU_AUTOASSIGN,
                           string_format( "%s: %s", options[i].first->nname( 1 ),
                                          options[i].first->get_use( options[i].second )->get_name() ) );
        }
        menu.query();
        selected = menu.ret;
    }
    if( selected < 0 || static_cast<size_t>( selected ) >= options.size() ) {
        return std::nullopt;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const item tool( options[selected].first, calendar::turn );
    return select_mounted_heating( who, tool, here.get_bub( position ), options[selected].second );
}

bool is_vehicle_heating( const player_activity &activity )
{
    return dynamic_cast<const vehicle_heating_activity_actor *>( activity.actor.get() ) != nullptr;
}

const item *vehicle_heating_liquid( const player_activity &activity )
{
    const auto *actor = dynamic_cast<const vehicle_heating_activity_actor *>( activity.actor.get() );
    return actor && !actor->pending.empty() ? &actor->pending.front() : nullptr;
}

bool apply_vehicle_heating_liquid( Character &who, const unload_liquid_choice &choice,
                                   bool allow_consequences )
{
    auto *actor = dynamic_cast<vehicle_heating_activity_actor *>( who.activity.actor.get() );
    if( !actor || actor->pending.empty() ||
        choice.source != actor->pending.front().uid().get_value() ) {
        return false;
    }
    if( choice.kind == LD_NULL ) {
        who.cancel_activity();
        return false;
    }
    if( choice.kind == LD_CONSUME && ( !who.can_eat( actor->pending.front() ).success() ||
                                       ( !allow_consequences && !who.will_eat( actor->pending.front(), false ).success() ) ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto generation = who.activity.identity_generation();
    const tripoint_bub_ms fallback = who.pos_bub();
    item liquid = std::move( actor->pending.front() );
    actor->pending.erase( actor->pending.begin() );
    const int before = liquid.charges;
    if( choice.kind == LD_CONSUME ) {
        const int moves = to_moves<int>( who.get_consume_time( liquid ) );
        if( who.consume( liquid, true, true ) != trinary::NONE && lifetime ) {
            who.mod_moves( -moves );
        }
    } else {
        receive_unloaded_item( who, liquid, liquid, nullptr, std::vector<unload_liquid_choice> { choice } );
    }
    auto *current = lifetime && who.activity.identity_generation() == generation ?
                    dynamic_cast<vehicle_heating_activity_actor *>( who.activity.actor.get() ) : nullptr;
    const bool transferred = liquid.charges < before;
    if( liquid.charges > 0 ) {
        if( current ) {
            current->pending.insert( current->pending.begin(), std::move( liquid ) );
        } else {
            get_map().add_item_or_charges( fallback, liquid );
        }
    }
    if( current && current->pending.empty() ) {
        who.activity.set_to_null();
    }
    return transferred;
}

std::unique_ptr<activity_actor> deserialize_vehicle_heating( JsonValue &data )
{
    const JsonObject object = data.get_object();
    if( !object.get_bool( "vehicle_heating" ) ) {
        return nullptr;
    }
    vehicle_heating_activity_actor actor;
    object.read( "vehicle", actor.vehicle_id, true );
    object.read( "position", actor.position, true );
    object.read( "selection", actor.selection, true );
    object.read( "energy", actor.energy, true );
    object.read( "fuel", actor.fuel, true );
    object.read( "duration", actor.duration, true );
    object.read( "heated", actor.heated, true );
    object.read( "pending", actor.pending, true );
    return actor.clone();
}
