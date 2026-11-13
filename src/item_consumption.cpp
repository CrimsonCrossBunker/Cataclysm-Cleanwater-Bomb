#include "item_consumption.h"

#include "activity_actor_definitions.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "item.h"
#include "item_healing.h"
#include "item_pocket.h"
#include "itype.h"
#include "iuse.h"
#include "json.h"
#include "map.h"
#include "mapdata.h"
#include "messages.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "player_activity.h"
#include "ret_val.h"
#include "rng.h"
#include "translations.h"

static const efftype_id effect_hunger_engorged( "hunger_engorged" );
static const itype_id itype_grass( "grass" );
static const itype_id itype_small_plant( "small_plant" );
static const itype_id itype_underbrush( "underbrush" );
static const ter_str_id ter_t_grass( "t_grass" );
static const ter_str_id ter_t_grass_alien( "t_grass_alien" );
static const ter_str_id ter_t_grass_dead( "t_grass_dead" );
static const ter_str_id ter_t_grass_golf( "t_grass_golf" );
static const ter_str_id ter_t_grass_white( "t_grass_white" );
static const trait_id trait_GRAZER( "GRAZER" );
static const trait_id trait_RUMINANT( "RUMINANT" );

namespace
{
enum class ground_food { none, leaves, flowers, grass, short_grass, dead_grass, painted_grass, alien_grass };

ground_food food_underfoot( const Character &who, map &here, const tripoint_bub_ms &position )
{
    const bool grazer = who.has_active_mutation( trait_GRAZER );
    if( !grazer && !who.has_active_mutation( trait_RUMINANT ) ) {
        return ground_food::none;
    }
    if( !here.has_flag( ter_furn_flag::TFLAG_GRAZER_INEDIBLE, position ) ) {
        if( here.has_flag( ter_furn_flag::TFLAG_SHRUB, position ) ) {
            return ground_food::leaves;
        }
        if( here.has_flag( ter_furn_flag::TFLAG_FLOWER, position ) ) {
            return ground_food::flowers;
        }
    }
    if( !grazer ) {
        return ground_food::none;
    }
    if( here.has_flag( ter_furn_flag::TFLAG_GRAZABLE, position ) &&
        !here.has_flag( ter_furn_flag::TFLAG_FUNGUS, position ) ) {
        return ground_food::grass;
    }
    const ter_id terrain = here.ter( position );
    if( terrain == ter_t_grass_golf || terrain == ter_t_grass ) {
        return ground_food::short_grass;
    }
    if( terrain == ter_t_grass_dead ) {
        return ground_food::dead_grass;
    }
    if( terrain == ter_t_grass_white ) {
        return ground_food::painted_grass;
    }
    return terrain == ter_t_grass_alien ? ground_food::alien_grass : ground_food::none;
}

itype_id ground_food_item( ground_food food )
{
    switch( food ) {
        case ground_food::leaves:
            return itype_underbrush;
        case ground_food::flowers:
            return itype_small_plant;
        case ground_food::grass:
            return itype_grass;
        default:
            return itype_id::NULL_ID();
    }
}

bool supports_owned_consumption( const item &source )
{
    if( source.is_food() ) {
        return true;
    }
    if( !source.is_medication() ) {
        return false;
    }
    const use_function *use = source.type->get_default_use();
    return !use || ( use->get_actor_ptr() && use->get_actor_ptr()->is_immediate_consumption() );
}
} // namespace

ground_food_target ground_food_target::capture( map &here, const tripoint_bub_ms &position )
{
    return { here.get_abs( position ), here.ter( position ).id(), here.furn( position ).id() };
}

bool ground_food_target::matches( const Character &who, map &here ) const
{
    if( who.pos_abs() != position || !here.inbounds( position ) ) {
        return false;
    }
    const tripoint_bub_ms local = here.get_bub( position );
    return here.ter( local ).id() == terrain && here.furn( local ).id() == furniture;
}

void ground_food_target::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "position", position );
    out.member( "terrain", terrain );
    out.member( "furniture", furniture );
    out.end_object();
}

void ground_food_target::deserialize( const JsonObject &data )
{
    data.read( "position", position, true );
    data.read( "terrain", terrain, true );
    data.read( "furniture", furniture, true );
}

bool start_ground_food( Character &who, map &here, const ground_food_target *selection,
                        bool allow_consequences )
{
    const tripoint_bub_ms position = who.pos_bub( here );
    if( !here.inbounds( position ) || ( selection && !selection->matches( who, here ) ) ) {
        return false;
    }
    const ground_food kind = food_underfoot( who, here, position );
    const itype_id food_type = ground_food_item( kind );
    if( food_type.is_null() ) {
        switch( kind ) {
            case ground_food::short_grass:
                who.add_msg_if_player( _( "This grass is too short to graze." ) );
                break;
            case ground_food::dead_grass:
                who.add_msg_if_player( _( "This grass is dead and too mangled for you to graze." ) );
                break;
            case ground_food::painted_grass:
                who.add_msg_if_player( _( "This grass is tainted with paint and thus inedible." ) );
                break;
            case ground_food::alien_grass:
                who.add_msg_if_player( _( "This grass is razor sharp and would probably shred your mouth." ) );
                break;
            default:
                return false;
        }
        return true;
    }
    if( who.has_effect( effect_hunger_engorged ) ) {
        if( kind == ground_food::leaves ) {
            who.add_msg_if_player( _( "You're too full to eat the leaves from the %s." ),
                                   here.tername( position ) );
        } else if( kind == ground_food::flowers ) {
            who.add_msg_if_player( _( "You're too full to eat the %s." ), here.tername( position ) );
        } else {
            who.add_msg_if_player( _( "You're too full to graze." ) );
        }
        return true;
    }

    const item food( food_type, calendar::turn, 1 );
    if( selection ) {
        const auto edibility = allow_consequences ? who.can_eat( food ) : who.will_eat( food, false );
        if( !edibility.success() ) {
            who.add_msg_if_player( m_info, "%s", edibility.c_str() );
            return true;
        }
    }
    if( !selection && kind == ground_food::grass ) {
        // Keep the local activity-start callback before the grass changes.
        const auto context = here.get_context_reference();
        who.assign_activity( consume_activity_actor( food ) );
        if( context ) {
            here.ter_set( position, here.get_ter_transforms_into( position ) );
        }
        return true;
    }
    if( kind == ground_food::leaves ) {
        here.ter_set( position, ter_t_grass );
    } else if( kind == ground_food::flowers ) {
        here.furn_set( position, furn_str_id::NULL_ID() );
    } else {
        here.ter_set( position, here.get_ter_transforms_into( position ) );
    }

    player_activity activity{ selection ?
                              consume_activity_actor( food, ground_food_target::capture( here, position ),
                                                      allow_consequences ) :
                              consume_activity_actor( food ) };
    if( selection ) {
        activity.set_execution( activity_execution::authoritative );
    }
    who.assign_activity( activity );
    return true;
}

bool select_client_ground_food( Character &who, map &here )
{
    const tripoint_bub_ms position = who.pos_bub( here );
    if( !here.inbounds( position ) ) {
        return false;
    }
    const ground_food kind = food_underfoot( who, here, position );
    if( kind == ground_food::none ) {
        return false;
    }
    const character_action_guard actor( who );
    const auto context = here.get_context_reference();
    const ground_food_target target = ground_food_target::capture( here, position );
    const itype_id food_type = ground_food_item( kind );
    const bool preview = !food_type.is_null() && !who.has_effect( effect_hunger_engorged );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const bool accepted = !preview || who.will_eat( item( food_type, calendar::turn, 1 ), true ).success();
    if( accepted && actor && context ) {
        cata_mp::client_start_consume_ground( target, preview );
    }
    return true;
}

bool owned_consumption_allowed( Character &who, item_location source,
                                bool allow_consequences, bool allow_theft )
{
    if( !source || !supports_owned_consumption( *source ) || source->count() <= 0 ||
        !who.can_eat( *source ).success() ||
        ( !allow_consequences && !who.will_eat( *source, false ).success() ) ||
        ( !source->is_owned_by( who, true ) && !allow_theft ) ||
        ( source->is_container() && !source->is_container_empty() ) ) {
        return false;
    }
    // Unsealing must not silently spill as a proxy NPC. Explicit extra spill
    // destinations belong to the container interaction work, not consumption.
    while( source.has_parent() ) {
        const item_pocket *pocket = source.parent_pocket();
        source = source.parent_item();
        if( pocket && pocket->will_spill_if_unsealed() && !pocket->empty() &&
            source.where() != item_location::type::map && !who.is_wielding( *source ) ) {
            return false;
        }
    }
    return true;
}

void start_item_consumption( Character &who, const item_location &source, bool reprompt )
{
    if( who.is_avatar() && cata_mp::is_client_mode() ) {
        if( !source || cata_mp::is_client_waiting_for_ack() || who.get_moves() <= 0 ) {
            return;
        }
        if( healing_action( source ) ) {
            select_client_healing( who, source, nullptr, reprompt );
            return;
        }
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        if( !supports_owned_consumption( *source ) ) {
            add_msg( m_info,
                     _( "This item requires a targeted or scripted use action that is not yet available in multiplayer." ) );
            return;
        }
        if( who.will_eat( *source, true ).success() &&
            query_consumption_ownership( *source, who ) ) {
            cata_mp::client_start_consume( source, true, !source->is_owned_by( who, true ), reprompt );
        }
        return;
    }
    who.assign_activity( consume_activity_actor( source, reprompt ) );
}
