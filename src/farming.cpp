#include "farming.h"

#include <algorithm>
#include <cmath>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "bodypart.h"
#include "character.h"
#include "character_action_guard.h"
#include "craft_reservation.h"
#include "event.h"
#include "event_bus.h"
#include "flag.h"
#include "fungal_effects.h"
#include "game.h"
#include "cached_options.h"
#include "iexamine.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "itype.h"
#include "json.h"
#include "liquid_transfer.h"
#include "map.h"
#include "map_selector.h"
#include "mapdata.h"
#include "mp_client_conn.h"
#include "player_activity.h"
#include "rng.h"
#include "ret_val.h"
#include "temp_crafting_inventory.h"
#include "translations.h"
#include "weather.h"

maple_tree_items inspect_maple_tree( map &here, const tripoint_abs_ms &position )
{
    maple_tree_items result;
    if( !here.inbounds( position ) ) {
        return result;
    }
    for( item &value : here.i_at( here.get_bub( position ) ) ) {
        if( !result.tap && value.get_quality_nonrecursive( quality_id( "TREE_TAP" ) ) > 0 ) {
            result.tap = item_location( map_cursor( position ), &value );
        }
        if( !result.container && ( value.will_spill() || value.is_watertight_container() ) ) {
            result.container = item_location( map_cursor( position ), &value );
            for( item *contained : value.all_items_top() ) {
                if( contained->typeId() == itype_id( "maple_sap" ) && contained->charges > 0 ) {
                    result.sap = item_location( result.container, contained );
                    break;
                }
            }
        }
    }
    return result;
}

namespace
{
bool maple_container_accepts_sap( const item_location &container )
{
    return container && container->get_remaining_capacity_for_liquid(
               item( itype_id( "maple_sap" ), calendar::turn_zero ), true ) > 0;
}

bool can_move_maple_item( Character &who, const item_location &source )
{
    return source && ( !source.held_by( who ) ||
                       ( who.can_drop( *source ).success() &&
                         ( !who.is_worn( *source ) || who.can_takeoff( *source ).success() ) ) );
}

// Detach before placement callbacks. Installing/removing a tap may move two
// objects; both must be committed before either object's drop action runs.
item_location stage_maple_item( map &here, item_location source,
                                const tripoint_abs_ms &destination )
{
    const auto context = here.get_context_reference();
    item value( *source );
    source.remove_item();
    if( !context ) {
        return item_location();
    }
    item &placed = here.add_item_unprocessed( here.get_bub( destination ), std::move( value ) );
    return placed.is_null() ? item_location() : item_location( map_cursor( destination ), &placed );
}

bool work_maple_tree( Character &who, map &here, const farming_command &command )
{
    const tripoint_abs_ms position = command.target.position;
    const tripoint_bub_ms tile = here.get_bub( position );
    const bool installing = command.action == farming_action::maple_tap;
    if( here.has_furn( tile ) || !here.ter( tile )->has_examine(
            installing ? iexamine::tree_maple : iexamine::tree_maple_tapped ) ) {
        return false;
    }
    const maple_tree_items installed = inspect_maple_tree( here, position );
    item_location tap = command.tap ? resolve_item_source( who, here, *command.tap, pickup_range ) :
                        item_location();
    item_location container = command.container ?
                              resolve_item_source( who, here, *command.container, pickup_range ) : item_location();
    if( !tap || ( command.container && !container ) ||
        ( installing && !can_move_maple_item( who, tap ) ) ||
        ( container && command.action != farming_action::maple_sap &&
          !can_move_maple_item( who, container ) ) ) {
        return false;
    }
    if( installing ) {
        if( installed.tap || installed.container ||
            tap->get_quality_nonrecursive( quality_id( "TREE_TAP" ) ) <= 0 ||
            ( tap.where_recursive() == item_location::type::map &&
              here.ter( tap.pos_bub( here ) ) == ter_str_id( "t_tree_maple_tapped" ) ) ||
            !who.crafting_inventory().has_quality( quality_id( "DRILL" ) ) ||
            !who.crafting_inventory().has_quality( quality_id( "HAMMER" ) ) ||
            !craft_reservation::usable_by_automation( *tap ) ||
            ( container && ( !maple_container_accepts_sap( container ) || tap == container ||
                             tap->has_item( *container ) || container->has_item( *tap ) ) ) ) {
            return false;
        }
    } else if( tap != installed.tap ) {
        return false;
    }
    if( !installing && command.action != farming_action::maple_add_container &&
        container != installed.container ) {
        return false;
    }
    if( command.action == farming_action::maple_untap &&
        !who.crafting_inventory().has_quality( quality_id( "HAMMER" ) ) ) {
        return false;
    }
    if( command.action == farming_action::maple_add_container &&
        ( installed.container || !maple_container_accepts_sap( container ) ||
          container == tap || container->has_item( *tap ) ) ) {
        return false;
    }
    if( container && !craft_reservation::usable_by_automation( *container ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const tripoint_abs_ms origin = who.pos_abs();
    const auto generation = who.activity.identity_generation();
    const auto valid = [&]() {
        return lifetime && context && who.pos_abs() == origin &&
               who.activity.identity_generation() == generation;
    };
    if( command.action == farming_action::maple_sap ) {
        const auto &choice = command.sap_destination;
        item_location sap = installed.sap;
        if( !sap || !choice || sap->uid().get_value() != choice->source ||
            !sap->made_of( phase_id::LIQUID ) ) {
            return false;
        }
        liquid_dest_opt destination;
        std::optional<int> tank;
        if( !resolve_liquid_destination( who, *choice, *container, destination, tank ) ) {
            return false;
        }
        item liquid( *sap );
        const int before = liquid.charges;
        sap.remove_item();
        liquid_handler::transfer_liquid( who, liquid, destination, tank );
        const bool handled = liquid.charges < before;
        if( handled && ( destination.dest_opt == LD_KEG ||
                         ( destination.dest_opt == LD_ITEM && destination.item_loc &&
                           destination.item_loc->is_watertight_container() ) ) ) {
            liquid.unset_flag( flag_id( "FROM_FROZEN_LIQUID" ) );
        }
        // A destination callback may remove or fill the original container.
        // Restore only what still fits; any remainder stays on the tree tile.
        if( context && liquid.charges > 0 ) {
            if( container ) {
                liquid.charges -= container->fill_with( liquid, liquid.charges, true );
            }
            if( liquid.charges > 0 ) {
                here.add_item_unprocessed( tile, std::move( liquid ), true );
            }
        }
        return handled;
    }
    if( ( command.action == farming_action::maple_add_container ||
          command.action == farming_action::maple_remove_container ) && !container ) {
        return false;
    }
    std::vector<item_location> moved;
    const bool removing = command.action == farming_action::maple_untap ||
                          command.action == farming_action::maple_remove_container;
    const tripoint_abs_ms destination = removing ? origin : position;
    const std::string tap_name = tap->tname();
    const bool adding_container = static_cast<bool>( container );
    if( installing || command.action == farming_action::maple_untap ) {
        who.mod_moves( -to_moves<int>( 20_seconds ) );
        here.ter_set( tile, ter_str_id( installing ? "t_tree_maple_tapped" : "t_tree_maple" ) );
        moved.push_back( stage_maple_item( here, tap, destination ) );
    } else {
        who.mod_moves( -who.item_handling_cost( *container ) );
    }
    if( valid() && container ) {
        moved.push_back( stage_maple_item( here, container, destination ) );
    }
    for( const item_location &value : moved ) {
        if( !valid() ) {
            return true;
        }
        if( value && value.pos_abs() == destination ) {
            here.settle_item_on_ground( here.get_bub( destination ), value, &who );
        }
    }
    if( valid() && installing ) {
        who.add_msg_if_player( m_info,
                               _( "You drill the maple tree crust and tap a %s into the prepared hole." ), tap_name );
        if( !adding_container ) {
            who.add_msg_if_player( m_info, _( "No container added.  The sap will just spill on the ground." ) );
        }
    }
    return true;
}

// Publish all output before callbacks can interrupt or reenter harvesting.
// Flower products are collected; native spawn_item products stay on the map.
using vegetation_products = std::vector<std::pair<item_location, bool>>;

void stage_vegetation_product( map &here, const tripoint_abs_ms &origin,
                               const itype_id &type, bool collect, vegetation_products &products,
                               int count = 1, int charges = 0 )
{
    const tripoint_bub_ms tile = here.get_bub( origin );
    for( int i = 0; i < count; ++i ) {
        std::optional<item> value;
        if( collect ) {
            value.emplace( type );
            if( value->has_temperature() ) {
                value->set_item_temperature( get_weather().get_temperature( tile ) );
            }
        } else {
            value = here.prepare_spawn_item( tile, type, charges, calendar::turn );
        }
        if( value ) {
            item &stored = here.add_item_unprocessed( tile, std::move( *value ) );
            if( !stored.is_null() ) {
                products.emplace_back( item_location( map_cursor( origin ), &stored ), collect );
            }
        }
    }
}

void deliver_vegetation_products( Character &who, map &here, const tripoint_abs_ms &origin,
                                  const vegetation_products &products )
{
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const auto generation = who.activity.identity_generation();
    for( const auto &product : products ) {
        if( !lifetime || !context || who.pos_abs() != origin ||
            who.activity.identity_generation() != generation ) {
            return;
        }
        if( product.first && product.first.pos_abs() == origin ) {
            if( product.second ) {
                iexamine_helper::handle_harvest( who, product.first, false );
            } else {
                here.settle_item_on_ground( here.get_bub( origin ), product.first, &who );
            }
        }
    }
}

bool harvest_flower( Character &who, map &here, const farming_command &command )
{
    const tripoint_bub_ms tile = here.get_bub( command.target.position );
    const furn_t &flower = here.furn( tile ).obj();
    const bool poppy = flower.has_examine( iexamine::flower_poppy );
    const bool cactus = flower.has_examine( iexamine::flower_cactus );
    const bool dahlia = flower.has_examine( iexamine::flower_dahlia );
    const bool marloss = flower.has_examine( iexamine::flower_marloss );
    const bool nectar = !cactus && iexamine_helper::can_drink_nectar( who );
    if( !( poppy || cactus || dahlia || marloss ) ||
        ( !marloss && season_of_year( calendar::turn ) == WINTER ) ||
        ( command.drink && !nectar ) || ( nectar && !command.drink ) ||
        ( !command.pick && !command.drink ) || ( dahlia && nectar && command.pick ) ) {
        return false;
    }
    if( dahlia && command.drink ) {
        return iexamine_helper::drink_nectar( who );
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const tripoint_abs_ms origin = who.pos_abs();
    auto generation = who.activity.identity_generation();
    const auto valid = [&]() {
        return lifetime && context && who.pos_abs() == origin &&
               who.activity.identity_generation() == generation;
    };
    vegetation_products products;
    if( command.pick ) {
        here.furn_set( tile, furn_str_id::NULL_ID() );
        if( poppy ) {
            stage_vegetation_product( here, origin, itype_id( "poppy_bud" ), true, products );
        } else if( cactus ) {
            stage_vegetation_product( here, origin, itype_id( "cactus_pad" ), true, products );
            stage_vegetation_product( here, origin, itype_id( "seed_cactus" ), true, products );
        } else if( dahlia ) {
            if( who.has_quality( quality_id( "DIG" ) ) || who.has_trait( trait_id( "BURROW" ) ) ||
                who.has_trait( trait_id( "BURROWLARGE" ) ) ) {
                stage_vegetation_product( here, origin, itype_id( "dahlia_root" ), true, products );
            }
            stage_vegetation_product( here, origin, itype_id( "seed_dahlia" ), true, products );
        } else {
            stage_vegetation_product( here, origin, itype_id( "marloss_seed" ), false, products, 1, 3 );
        }
        if( !cactus ) {
            stage_vegetation_product( here, origin, itype_id( "withered" ), true, products );
        }
    }
    if( command.drink ) {
        if( poppy ) {
            who.add_msg_if_player( _( "You slowly suck up the nectar." ) );
            who.assign_activity( consume_activity_actor( item( itype_id( "poppy_nectar" ),
                                 calendar::turn, 1 ) ) );
            if( !lifetime || !context || who.pos_abs() != origin ||
                who.activity.id() != activity_id( "ACT_CONSUME" ) ) {
                return true;
            }
            generation = who.activity.identity_generation();
            who.mod_sleepiness( 20 );
            if( !valid() ) {
                return true;
            }
            who.add_effect( efftype_id( "pkill2" ), 7_minutes );
            if( !valid() ) {
                return true;
            }
            if( one_in( 20 ) ) {
                who.add_addiction( addiction_id( "opiate" ), 1 );
            }
        } else {
            who.mod_moves( -to_moves<int>( 30_seconds ) );
            who.add_msg_if_player( m_bad, _( "This flower tastes very wrong…" ) );
            who.add_effect( efftype_id( "teleglow" ), 10_minutes );
        }
        if( !valid() || !command.pick ) {
            return true;
        }
    }
    if( poppy ) {
        const int resist = who.get_env_resist( bodypart_id( "mouth" ) );
        if( resist < 10 ) {
            who.add_msg_if_player( m_warning, _( "This flower has a heady aroma." ) );
        }
        const weather_sum recent = sum_conditions( calendar::turn - 10_minutes, calendar::turn,
                                   origin );
        if( one_in( recent.rain_amount > 1 ? 6 : 3 ) && resist < 5 ) {
            who.add_msg_if_player( m_bad, _( "The flower's fragrance makes you extremely drowsy…" ) );
            who.fall_asleep( 2_hours );
            // Falling asleep cancels our nectar activity. A callback-created
            // replacement activity belongs to that callback and must survive.
            if( !lifetime || !context || who.pos_abs() != origin || who.activity ) {
                return true;
            }
            generation = who.activity.identity_generation();
            who.add_msg_if_player( m_bad, _( "Your legs are covered in the poppy's roots!" ) );
            who.apply_damage( nullptr, bodypart_id( "leg_l" ), 4 );
            if( !valid() ) {
                return true;
            }
            who.apply_damage( nullptr, bodypart_id( "leg_r" ), 4 );
            if( !valid() ) {
                return true;
            }
            who.mod_moves( -to_moves<int>( 1_seconds ) / 2 );
        }
    } else if( cactus && one_in( 6 ) ) {
        who.add_msg_if_player( m_bad, _( "The cactus' nettles sting you!" ) );
        who.apply_damage( nullptr, bodypart_id( "arm_l" ), 4 );
        if( !valid() ) {
            return true;
        }
        who.apply_damage( nullptr, bodypart_id( "arm_r" ), 4 );
    } else if( marloss ) {
        get_event_bus().send<event_type::character_harvests_plant>( who.getID(),
                command.target.position.raw(), itype_id( "marloss_seed" ),
                command.target.furniture, 0, 0 );
    }
    if( valid() ) {
        deliver_vegetation_products( who, here, origin, products );
    }
    return true;
}

bool harvest_special_tree( Character &who, map &here, const farming_command &command )
{
    const tripoint_bub_ms tile = here.get_bub( command.target.position );
    const ter_t &terrain = here.ter( tile ).obj();
    const bool roots = command.action == farming_action::hickory_roots;
    const bool tree = terrain.has_examine( iexamine::tree_marloss );
    if( here.has_furn( tile ) ||
        ( roots ? ( !terrain.has_examine( iexamine::tree_hickory ) ||
                    !who.has_quality( quality_id( "DIG" ) ) ) :
          ( !tree && !terrain.has_examine( iexamine::shrub_marloss ) ) ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const tripoint_abs_ms origin = who.pos_abs();
    const auto generation = who.activity.identity_generation();
    const auto valid = [&]() {
        return lifetime && context && who.pos_abs() == origin &&
               who.activity.identity_generation() == generation;
    };
    const bool mycus = who.has_trait( trait_id( "THRESH_MYCUS" ) );
    const bool offering = !mycus && who.has_trait( trait_id( "THRESH_MARLOSS" ) );
    const float survival = who.get_skill_level( skill_id( "survival" ) );
    const itype_id product = roots ? itype_id( "hickory_root" ) :
                             itype_id( mycus || offering ? "mycus_fruit" : "marloss_berry" );
    const ter_str_id depleted( roots ? "t_tree_hickory_dead" :
                               tree ? "t_tree_fungal" : offering ? "t_fungus" : "t_shrub_fungal" );
    int count = 1;
    if( roots ) {
        count = rng( 1, std::round( 3 + survival ) );
        who.mod_moves( -to_moves<int>( 20_seconds ) / ( survival + 1 ) + 100 );
    } else if( !offering ) {
        const int base = rng( 2, 5 );
        count = std::min( rng( base, std::round( base + survival / 2 ) ), 12 );
    }
    here.ter_set( tile, depleted );
    vegetation_products products;
    stage_vegetation_product( here, origin, product, false, products, count );
    const bool replenish = !roots && tree && mycus && who.has_trait( trait_id( "M_DEPENDENT" ) ) &&
                           one_in( 3 );
    deliver_vegetation_products( who, here, origin, products );
    if( !valid() ) {
        return true;
    }
    if( !roots && !offering ) {
        who.practice( skill_id( "survival" ), 6 );
    }
    if( !valid() ) {
        return true;
    }
    if( !roots && offering ) {
        who.add_msg_if_player( m_info, tree ?
                               _( "The tree offers up a fruit, then shrivels into a fungal tree." ) :
                               _( "The shrub offers up a fruit, then crumbles into a fungal bed." ) );
    }
    if( replenish && here.ter( tile ) == depleted && !here.has_furn( tile ) ) {
        who.add_msg_if_player( m_info,
                               _( "We have located a particularly vital nutrient deposit underneath this location." ) );
        who.add_msg_if_player( m_good, _( "Additional nourishment is available." ) );
        here.ter_set( tile, command.target.terrain );
    }
    return true;
}
} // namespace

void farming_command::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "target", target );
    out.member( "seed", seed );
    out.member( "seed_type", seed_type );
    out.member( "material", material );
    out.member( "drink", drink );
    out.member( "pick", pick );
    out.member( "tap", tap );
    out.member( "container", container );
    out.member( "sap_destination", sap_destination );
    out.end_object();
}

void farming_command::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value < static_cast<int>( farming_action::plant ) ||
        value > static_cast<int>( farming_action::maple_sap ) ) {
        data.throw_error_at( "action", "Invalid farming operation" );
    }
    action = static_cast<farming_action>( value );
    data.read( "target", target, true );
    data.read( "seed", seed );
    data.read( "seed_type", seed_type );
    data.read( "material", material );
    drink = data.get_bool( "drink", false );
    pick = data.get_bool( "pick", true );
    data.read( "tap", tap );
    data.read( "container", container );
    data.read( "sap_destination", sap_destination );
}

farming_command capture_farming_command( Character &who, map &here,
        const tripoint_abs_ms &position, farming_action action )
{
    farming_command result;
    result.action = action;
    if( !here.inbounds( position ) ) {
        result.target.position = position;
        return result;
    }
    result.target = tool_activity_target::capture( here, position );
    const tripoint_bub_ms tile = here.get_bub( position );
    if( here.inbounds( tile ) && here.furn( tile )->plant ) {
        if( item *seed = iexamine::get_seed_at( here, tile ) ) {
            result.seed = capture_item_source( who, item_location( map_cursor( position ), seed ) );
            result.seed_type = seed->typeId();
        }
    }
    return result;
}

item *resolve_planted_seed( map &here, const item_source &source )
{
    if( source.kind != "map" || source.path.size() != 1 || !here.inbounds( source.position ) ) {
        return nullptr;
    }
    const tripoint_bub_ms position = here.get_bub( source.position );
    if( !here.furn( position )->plant ) {
        return nullptr;
    }
    // Crop furniture is sealed to keep its seed out of pickup and crafting.
    // Resolve only the planted seed, never other contents of the sealed tile.
    item *seed = iexamine::get_seed_at( here, position );
    return seed && seed->uid().get_value() == source.path.front() ? seed : nullptr;
}

bool execute_farming_command( Character &who, const farming_command &command )
{
    map &here = get_map();
    const tripoint_abs_ms position = command.target.position;
    if( cata_mp::is_client_mode() || who.activity || who.get_moves() <= 0 || who.is_dead_state() ||
        !here.inbounds( position ) ||
        position.z() != who.pos_abs().z() || rl_dist( who.pos_abs(), position ) > 1 ||
        !command.target.matches( here ) ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( position );
    if( command.seed ) {
        if( command.seed->position != position ) {
            return false;
        }
        const item *original = resolve_planted_seed( here, *command.seed );
        if( !original || original->typeId() != command.seed_type ) {
            return false;
        }
    } else if( here.furn( tile )->plant && iexamine::get_seed_at( here, tile ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    switch( command.action ) {
        case farming_action::maple_tap:
        case farming_action::maple_untap:
        case farming_action::maple_add_container:
        case farming_action::maple_remove_container:
        case farming_action::maple_sap:
            return !command.seed && work_maple_tree( who, here, command );
        case farming_action::flower:
            return !command.seed && harvest_flower( who, here, command );
        case farming_action::fungus:
            if( command.seed || !here.furn( tile )->has_examine( iexamine::fungus ) ) {
                return false;
            }
            who.add_msg_if_player( _( "The %s crumbles into spores!" ), here.furnname( tile ) );
            here.furn_set( tile, furn_str_id::NULL_ID() );
            who.mod_moves( -to_moves<int>( 1_seconds ) / 2 );
            fungal_effects().create_spores( tile, &who );
            return true;
        case farming_action::marloss:
        case farming_action::hickory_roots:
            return !command.seed && harvest_special_tree( who, here, command );
        case farming_action::gather: {
            const furn_t &furn = here.furn( tile ).obj();
            const ter_t &terrain = here.ter( tile ).obj();
            const bool allowed = here.has_furn( tile ) ?
                                 ( furn.has_examine( iexamine::harvest_furn ) ||
                                   furn.has_examine( iexamine::harvest_furn_nectar ) ) :
                                 ( terrain.has_examine( iexamine::harvest_ter ) ||
                                   terrain.has_examine( iexamine::harvest_ter_nectar ) ||
                                   terrain.has_examine( iexamine::tree_hickory ) );
            if( command.seed || !allowed || who.is_mounted() ) {
                return false;
            }
            who.assign_activity( harvest_activity_actor( tile ) );
            return lifetime && who.activity.id() == activity_id( "ACT_HARVEST" );
        }
        case farming_action::forage:
            if( command.seed || who.is_mounted() ||
                !here.ter( tile )->has_examine( iexamine::shrub_wildveggies ) ) {
                return false;
            }
            who.assign_activity( forage_activity_actor( position ) );
            return lifetime && who.activity.id() == activity_id( "ACT_FORAGE" );
        case farming_action::plant: {
            if( command.seed || !command.material.is_valid() || !command.material->seed ||
                !here.i_at( tile ).empty() ||
                !here.has_flag_ter_or_furn( command.material->seed->required_terrain_flag, tile ) ||
                !warm_enough_to_plant( tile, command.material ).success() ) {
                return false;
            }
            const bool available = command.material->count_by_charges() ?
                                   who.has_charges( command.material, 1, craft_reservation::usable_by_automation ) :
                                   who.has_amount( command.material, 1, false, craft_reservation::usable_by_automation );
            if( !available ) {
                return false;
            }
            iexamine::plant_seed( who, tile, command.material );
            return lifetime && who.activity.id() == activity_id( "ACT_PLANT_SEED" );
        }
        case farming_action::fertilize:
            if( !command.seed && !here.ter( tile )->terrain_growth ) {
                return false;
            }
            iexamine::fertilize_plant( who, tile, command.material );
            return lifetime && who.activity.id() == activity_id( "ACT_FERTILIZE_PLANT" );
        case farming_action::harvest:
        case farming_action::clear: {
            if( !command.seed ) {
                return false;
            }
            const auto generation = who.activity.identity_generation();
            here.grow_plant( tile, &who );
            if( !lifetime || !context || who.activity.identity_generation() != generation ||
                !resolve_planted_seed( here, *command.seed ) ) {
                return false;
            }
            const tripoint_bub_ms current_tile = here.get_bub( position );
            if( command.action == farming_action::harvest ) {
                if( !iexamine::is_plant_harvestable( here, current_tile ) ) {
                    return false;
                }
                iexamine::harvest_plant( who, current_tile, false );
            } else {
                if( !iexamine::is_plant_overgrown( here, current_tile ) ) {
                    return false;
                }
                iexamine::clear_overgrown( who, current_tile );
            }
            return true;
        }
        case farming_action::water:
            if( !command.seed || !iexamine::can_water_plant( who, tile ) ) {
                return false;
            }
            iexamine::water_plant( who, tile );
            return true;
    }
    return false;
}
