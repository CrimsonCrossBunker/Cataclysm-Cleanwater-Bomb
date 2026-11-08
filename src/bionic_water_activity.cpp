#include "bionic_water_activity.h"

#include <algorithm>
#include <utility>
#include <vector>

#include "bionics.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "color.h"
#include "item_uid.h"
#include "item_unload.h"
#include "json.h"
#include "map.h"
#include "map_selector.h"
#include "player_activity.h"
#include "ret_val.h"
#include "rng.h"
#include "translations.h"

namespace
{
int remaining_water( const item &corpse )
{
    return std::max( 0, static_cast<int>( corpse.get_var( "remaining_water",
                                          corpse.volume() / 500_ml ) ) );
}

item water_from_corpse( const item &corpse )
{
    item water( itype_id( "water_clean" ), calendar::turn, remaining_water( corpse ) );
    water.set_item_temperature( corpse.temperature );
    return water;
}
} // namespace

item_location resolve_bionic_water_source( Character &who, const item_source &source )
{
    if( source.kind != "map" || source.path.size() != 1 || source.position != who.pos_abs() ) {
        return item_location();
    }
    item_location target = resolve_item_source( who, get_map(), source );
    return target && target->is_corpse() && remaining_water( *target ) > 0 ? target : item_location();
}

std::optional<item_source> query_bionic_water_source( Character &who )
{
    const character_action_guard lifetime( who );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    std::vector<item_source> sources;
    for( item &entry : get_map().i_at( who.pos_bub() ) ) {
        if( entry.is_corpse() && remaining_water( entry ) > 0 ) {
            sources.push_back( capture_item_source( who,
                                                    item_location( map_cursor( who.pos_bub() ), &entry ) ) );
        }
    }
    if( sources.empty() ) {
        who.add_msg_if_player( m_bad, _( "There is no suitable corpse on this tile." ) );
    }
    for( const item_source &source : sources ) {
        item_location target = resolve_bionic_water_source( who, source );
        if( target && who.query_yn( _( "Extract water from the %s" ),
                                    colorize( target->tname(), target->color_in_inventory() ) ) ) {
            return lifetime && resolve_bionic_water_source( who, source ) ?
                   std::make_optional( source ) : std::nullopt;
        }
        if( !lifetime ) {
            return std::nullopt;
        }
    }
    return std::nullopt;
}

bionic_water_activity_actor::bionic_water_activity_actor( item_source source, unsigned int uid,
        units::energy cost ) : corpse( std::move( source ) ), bionic_uid( uid ),
    refundable_power( cost ) {}

const activity_id &bionic_water_activity_actor::get_type() const
{
    static const activity_id id( "ACT_BIONIC_WATER" );
    return id;
}

void bionic_water_activity_actor::start( player_activity &act, Character &who )
{
    act.moves_total = act.moves_left = 1;
    prepare( who );
}

bool bionic_water_activity_actor::prepare( Character &who )
{
    const auto installed = who.find_bionic_by_uid( bionic_uid );
    if( !installed || ( *installed )->id != bionic_id( "bio_water_extractor" ) ||
        ( *installed )->incapacitated_time > 0_turns ||
        !resolve_bionic_water_source( who, corpse ) ) {
        who.cancel_activity();
        return false;
    }
    return true;
}

std::optional<item> bionic_water_activity_actor::preview( Character &who ) const
{
    const item_location target = resolve_bionic_water_source( who, corpse );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    return target ? std::make_optional( water_from_corpse( *target ) ) : std::nullopt;
}

int64_t bionic_water_activity_actor::source_uid() const
{
    return corpse.path.size() == 1 ? corpse.path.front() : 0;
}

bool bionic_water_activity_actor::apply_choice( Character &who,
        const unload_liquid_choice &choice, bool allow_consequences )
{
    const character_action_guard lifetime( who );
    if( !lifetime || !prepare( who ) ) {
        return false;
    }
    if( choice.source != source_uid() || choice.kind < LD_NULL || choice.kind > LD_GROUND ) {
        return false;
    }
    if( choice.kind == LD_NULL ) {
        who.cancel_activity();
        return false;
    }
    item_location target = resolve_bionic_water_source( who, corpse );
    item water = water_from_corpse( *target );
    if( !water.made_of( phase_id::LIQUID ) ) {
        // The ordinary-item fallback in receive_unloaded_item does not drain
        // charges. Frozen water must retain the native liquid-handler refusal.
        who.add_msg_if_player( _( "The %s froze solid before you could finish." ), water.tname() );
        who.cancel_activity();
        return false;
    }
    if( choice.kind == LD_CONSUME && ( !who.can_eat( water ).success() ||
                                       ( !allow_consequences && !who.will_eat( water, false ).success() ) ) ) {
        return false;
    }
    const auto generation = who.activity.identity_generation();
    const units::energy refund = refundable_power;
    // A transfer may invoke callbacks that cancel/replace this activity. Reserve
    // the water and defer the refund until the actual transferred amount is known.
    refundable_power = 0_kJ;
    const int available = water.charges;
    target->set_var( "remaining_water", 0 );
    if( choice.kind == LD_CONSUME ) {
        const int moves = to_moves<int>( who.get_consume_time( water ) );
        if( who.consume( water, true, true ) != trinary::NONE && lifetime ) {
            who.mod_moves( -moves );
        }
    } else {
        receive_unloaded_item( who, water, *target, nullptr,
                               std::vector<unload_liquid_choice> { choice } );
    }
    // Never use this after native callbacks: only a matching live activity may
    // retain the refundable charge. The corpse location may itself be invalidated.
    if( target ) {
        target->set_var( "remaining_water", remaining_water( *target ) + water.charges );
    }
    const bool transferred = water.charges < available;
    if( !lifetime ) {
        return transferred;
    }
    auto *current = who.activity.identity_generation() == generation ?
                    dynamic_cast<bionic_water_activity_actor *>( who.activity.actor.get() ) : nullptr;
    if( !transferred ) {
        if( current ) {
            current->refundable_power = refund;
        } else {
            who.mod_power_level( refund );
        }
    } else if( refund > 0_kJ ) {
        who.add_msg_if_player( m_neutral, _( "You activate your %s." ),
                               bionic_id( "bio_water_extractor" )->name );
    }
    if( current ) {
        current->prepare( who );
    }
    return transferred;
}

bool run_local_bionic_water( Character &who )
{
    const character_action_guard lifetime( who );
    bool transferred = false;
    while( lifetime ) {
        auto *actor = dynamic_cast<bionic_water_activity_actor *>( who.activity.actor.get() );
        if( !actor || !actor->prepare( who ) ) {
            break;
        }
        const auto water = actor->preview( who );
        if( !water ) {
            who.cancel_activity();
            break;
        }
        const auto generation = who.activity.identity_generation();
        const auto choice = query_liquid_destination( *water, nullptr, actor->source_uid(), true );
        if( !lifetime || who.activity.identity_generation() != generation ) {
            break;
        }
        const bool consume = choice.kind != LD_CONSUME || who.will_eat( *water, true ).success();
        if( !lifetime || who.activity.identity_generation() != generation ) {
            break;
        }
        actor = dynamic_cast<bionic_water_activity_actor *>( who.activity.actor.get() );
        if( actor && consume ) {
            transferred = actor->apply_choice( who, choice, true ) || transferred;
        }
    }
    return transferred;
}

void bionic_water_activity_actor::do_turn( player_activity &act, Character &who )
{
    if( act.execution() == activity_execution::authoritative ) {
        if( prepare( who ) ) {
            // Only an explicit owner choice transfers water. A native activity
            // loop must yield while that choice is outstanding.
            who.set_moves( 0 );
        }
    } else {
        run_local_bionic_water( who );
    }
}

void bionic_water_activity_actor::finish( player_activity &, Character &who )
{
    who.cancel_activity();
}

void bionic_water_activity_actor::canceled( player_activity &, Character &who )
{
    who.mod_power_level( refundable_power );
    refundable_power = 0_kJ;
}

std::unique_ptr<activity_actor> bionic_water_activity_actor::clone() const
{
    return std::make_unique<bionic_water_activity_actor>( *this );
}

void bionic_water_activity_actor::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "corpse", corpse );
    out.member( "bionic_uid", bionic_uid );
    out.member( "refundable_power", refundable_power );
    out.end_object();
}

std::unique_ptr<activity_actor> bionic_water_activity_actor::deserialize( JsonValue &input )
{
    const JsonObject data = input.get_object();
    item_source source;
    unsigned int uid;
    units::energy refund;
    data.read( "corpse", source, true );
    data.read( "bionic_uid", uid, true );
    data.read( "refundable_power", refund, true );
    return std::make_unique<bionic_water_activity_actor>( std::move( source ), uid, refund );
}
