#include "charcoal_kiln.h"

#include <algorithm>
#include <array>
#include <set>
#include <utility>
#include <vector>

#include "bionics.h"
#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "iuse_actor.h"
#include "item.h"
#include "item_stack.h"
#include "item_uid.h"
#include "itype.h"
#include "json.h"
#include "map.h"
#include "mapdata.h"
#include "messages.h"
#include "translations.h"
#include "units.h"

namespace charcoal_kiln
{
namespace
{
const itype_id charcoal( "charcoal" );
const itype_id unfinished_charcoal( "unfinished_charcoal" );
const bionic_id lighter( "bio_lighter" );
const skill_id fabrication( "fabrication" );
constexpr time_duration firing_time = 24_hours;

struct kiln_type {
    furn_str_id idle;
    furn_str_id firing;
    int loss;
};

const std::array<kiln_type, 3> types = { {
        { furn_str_id( "f_kiln_empty" ), furn_str_id( "f_kiln_full" ), 60 },
        { furn_str_id( "f_kiln_metal_empty" ), furn_str_id( "f_kiln_metal_full" ), 20 },
        { furn_str_id( "f_kiln_portable_empty" ), furn_str_id( "f_kiln_portable_full" ), 25 }
    }
};

const kiln_type *find_type( const furn_id &furniture, bool firing )
{
    const auto match = std::find_if( types.begin(), types.end(), [&]( const kiln_type & type ) {
        return furniture == ( firing ? type.firing : type.idle );
    } );
    return match == types.end() ? nullptr : &*match;
}

int prepared_charges( Character &who, map &here, const tripoint_bub_ms &pos,
                      const kiln_type &type )
{
    static const std::set<material_id> feedstock{ material_id( "wood" ), material_id( "bone" ) };
    units::volume volume = 0_ml;
    const map_stack items = here.i_at( pos );
    if( items.empty() ) {
        who.add_msg_if_player( _( "This kiln is empty.  Fill it with wood or bone and try again." ) );
        return 0;
    }
    for( const item &it : items ) {
        if( it.typeId() == charcoal ) {
            who.add_msg_if_player( _( "This kiln already contains charcoal." ) );
            who.add_msg_if_player( _( "Remove it before firing the kiln again." ) );
            return 0;
        }
        if( !it.made_of_any( feedstock ) ) {
            who.add_msg_if_player( m_bad, _( "This kiln contains %s, which can't be made into charcoal!" ),
                                   it.tname( 1, false ) );
            return 0;
        }
        volume += it.volume();
    }

    // The native loss rates depend on construction and the operator's fabrication skill.
    const int loss = type.loss - 2 * who.get_skill_level( fabrication );
    const int charges = item::find_type( unfinished_charcoal )->charges_per_volume(
                            ( 100 - loss ) * volume / 100 );
    if( charges < 1 ) {
        who.add_msg_if_player( _( "The batch in this kiln is too small to yield any charcoal." ) );
        return 0;
    }
    return charges;
}

int64_t batch_identity( map &here, const tripoint_bub_ms &pos )
{
    for( const item &it : here.i_at( pos ) ) {
        if( it.typeId() == unfinished_charcoal ) {
            return it.uid().get_value();
        }
    }
    return 0;
}

bool replace_batch( map &here, const tripoint_bub_ms &pos, const furn_str_id &furniture,
                    const std::vector<item *> &inputs, const itype_id &output, int charges )
{
    if( here.has_flag_ter( ter_furn_flag::TFLAG_NO_FLOOR, pos ) ) {
        return false;
    }
    item product( output, calendar::turn );
    product.charges = charges;
    // Solid charcoal needs no placement processing. Keep the feedstock if the
    // output cannot be inserted, and leave unrelated items on the tile alone.
    item &placed = here.add_item_unprocessed( pos, std::move( product ) );
    if( placed.is_null() ) {
        return false;
    }
    if( !here.furn_set( pos, furniture ) ) {
        here.i_rem( pos, &placed );
        return false;
    }
    for( item *input : inputs ) {
        here.i_rem( pos, input );
    }
    return true;
}
} // namespace

bool is_idle( const furn_id &furniture )
{
    return find_type( furniture, false ) != nullptr;
}

bool prepare( Character &who, map &here, const tripoint_bub_ms &pos )
{
    const kiln_type *type = here.inbounds( pos ) ? find_type( here.furn( pos ), false ) : nullptr;
    return type && !here.has_flag_ter( ter_furn_flag::TFLAG_NO_FLOOR, pos ) &&
           prepared_charges( who, here, pos, *type ) > 0;
}

bool fire( Character &who, map &here, const tripoint_bub_ms &pos )
{
    const kiln_type *type = here.inbounds( pos ) ? find_type( here.furn( pos ), false ) : nullptr;
    if( !type ) {
        return false;
    }
    const int charges = prepared_charges( who, here, pos, *type );
    if( charges <= 0 ) {
        return false;
    }
    std::vector<item *> inputs;
    for( item &it : here.i_at( pos ) ) {
        inputs.push_back( &it );
    }
    return replace_batch( here, pos, type->firing, inputs, unfinished_charcoal, charges );
}

bool inspect( Character &who, map &here, const tripoint_bub_ms &pos )
{
    const kiln_type *type = here.inbounds( pos ) ? find_type( here.furn( pos ), true ) : nullptr;
    if( !type ) {
        return false;
    }
    std::vector<item *> inputs;
    units::volume volume = 0_ml;
    time_duration remaining = 0_turns;
    for( item &it : here.i_at( pos ) ) {
        if( it.typeId() == unfinished_charcoal ) {
            remaining = std::max( remaining, firing_time - it.age() );
            inputs.push_back( &it );
            volume += it.volume();
        }
    }
    if( inputs.empty() ) {
        if( here.has_flag_ter( ter_furn_flag::TFLAG_NO_FLOOR, pos ) ) {
            return false;
        }
        who.add_msg_if_player( _( "There is no charcoal burning in this kiln." ) );
        return here.furn_set( pos, type->idle );
    }
    who.add_msg_if_player( _( "There's a charcoal kiln there." ) );
    if( remaining > 0_turns ) {
        const int minutes = to_minutes<int>( remaining ) + 1;
        if( minutes > 60 ) {
            const int hours = to_hours<int>( remaining );
            who.add_msg_if_player( n_gettext( "It will finish burning in about %d hour.",
                                              "It will finish burning in about %d hours.", hours ), hours );
        } else if( minutes > 30 ) {
            who.add_msg_if_player( _( "It will finish burning in less than an hour." ) );
        } else {
            who.add_msg_if_player( n_gettext( "It should take about %d minute to finish burning.",
                                              "It should take about %d minutes to finish burning.",
                                              minutes ), minutes );
        }
        return false;
    }
    const int charges = item::find_type( charcoal )->charges_per_volume( volume );
    if( charges <= 0 || !replace_batch( here, pos, type->idle, inputs, charcoal, charges ) ) {
        return false;
    }
    who.add_msg_if_player( _( "It has finished burning, yielding %d charcoal." ), charges );
    return true;
}

void command::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "target", target );
    out.member( "batch", batch );
    out.end_object();
}

void command::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value < static_cast<int>( operation::fire_bionic ) ||
        value > static_cast<int>( operation::inspect ) ) {
        data.throw_error_at( "action", "Invalid kiln operation" );
    }
    action = static_cast<operation>( value );
    data.read( "origin", origin, true );
    data.read( "target", target, true );
    batch = data.get_int64( "batch" );
}

command capture( const Character &who, map &here, const tripoint_bub_ms &pos, operation action )
{
    return { action, who.pos_abs(), tool_activity_target::capture( here, here.get_abs( pos ) ),
             action == operation::inspect ? batch_identity( here, pos ) : 0 };
}

bool execute( Character &who, map &here, const command &request )
{
    const tripoint_abs_ms position = request.target.position;
    const tripoint_abs_ms origin = who.pos_abs();
    const int64_t dx = static_cast<int64_t>( position.x() ) - origin.x();
    const int64_t dy = static_cast<int64_t>( position.y() ) - origin.y();
    if( who.activity || who.get_moves() <= 0 || who.is_dead_state() || origin != request.origin ||
        origin.z() != position.z() || dx < -1 || dx > 1 || dy < -1 || dy > 1 ||
        ( dx == 0 && dy == 0 ) || request.target.tool_source || !request.target.matches( here ) ) {
        return false;
    }
    const tripoint_bub_ms pos = here.get_bub( request.target.position );
    if( request.action == operation::inspect ) {
        return request.batch == batch_identity( here, pos ) && inspect( who, here, pos );
    }
    if( request.action != operation::fire_bionic || request.batch != 0 ||
        !who.has_bionic( lighter ) || !who.enough_power_for( lighter ) ||
        !prepare( who, here, pos ) ) {
        return false;
    }
    const character_action_guard lifetime( who );
    const units::energy power = lighter->power_activate;
    const int moves = to_moves<int>( 1_seconds );
    who.mod_power_level( -power );
    who.mod_moves( -moves );
    const bool started = firestarter_actor::resolve_firestarter_use( &who, &here, pos,
                         firestarter_actor::start_type::KILN );
    if( !started && lifetime ) {
        who.mod_power_level( power );
        who.mod_moves( moves );
    }
    return started;
}
} // namespace charcoal_kiln
