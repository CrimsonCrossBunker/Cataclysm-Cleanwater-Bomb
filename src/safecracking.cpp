#include "safecracking.h"

#include "activity_actor_definitions.h"
#include "calendar.h"
#include "character.h"
#include "character_action_guard.h"
#include "flag.h"
#include "game.h"
#include "iexamine.h"
#include "json.h"
#include "line.h"
#include "map.h"
#include "mapdata.h"
#include "messages.h"
#include "player_activity.h"
#include "rng.h"
#include "translations.h"
#include "vpart_position.h"

namespace
{
const efftype_id effect_earphones( "earphones" );
const furn_str_id furn_f_safe_o( "f_safe_o" );
const json_character_flag json_flag_SAFECRACK_NO_TOOL( "SAFECRACK_NO_TOOL" );
const proficiency_id proficiency_prof_safecracking( "prof_safecracking" );
} // namespace

bool safe_interaction::matches( const Character &who, const map &here ) const
{
    if( who.is_dead_state() || who.cant_do_mounted( false ) ||
        who.has_effect( efftype_id( "incorporeal" ) ) || who.pos_abs() != origin ||
        origin.z() != position.z() || !here.inbounds( position ) ||
        !here.inbounds( origin ) || square_dist( origin, position ) > 1 ) {
        return false;
    }
    const tripoint_bub_ms tile = here.get_bub( position );
    if( !here.has_loaded_submap( tile ) || !here.has_loaded_submap( who.pos_bub( here ) ) ||
        here.veh_at( tile ) ) {
        return false;
    }
    const furn_id safe = here.furn( tile );
    return safe.id() == furniture &&
           safe->has_examine( action == safe_action::open ? iexamine::open_safe : iexamine::safe );
}

void safe_interaction::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "action", static_cast<int>( action ) );
    out.member( "origin", origin );
    out.member( "position", position );
    out.member( "furniture", furniture );
    out.end_object();
}

void safe_interaction::deserialize( const JsonObject &data )
{
    const int value = data.get_int( "action" );
    if( value < static_cast<int>( safe_action::guess ) ||
        value > static_cast<int>( safe_action::open ) ) {
        data.throw_error_at( "action", "Invalid safe action" );
    }
    action = static_cast<safe_action>( value );
    data.read( "origin", origin, true );
    data.read( "position", position, true );
    data.read( "furniture", furniture, true );
}

bool has_safecracking_tool( const Character &who )
{
    return who.has_flag( json_flag_SAFECRACK_NO_TOOL ) || who.cache_has_item_with( flag_SAFECRACK );
}

bool can_hear_safe_lock( const Character &who )
{
    return !who.is_deaf() && !who.has_effect( effect_earphones );
}

bool execute_safe_interaction( Character &who, map &here, const safe_interaction &choice,
                               activity_execution execution )
{
    if( who.activity || who.get_moves() <= 0 || !choice.matches( who, here ) ) {
        return false;
    }
    if( choice.action == safe_action::crack &&
        ( !has_safecracking_tool( who ) || !can_hear_safe_lock( who ) ) ) {
        return false;
    }
    if( choice.action == safe_action::guess && has_safecracking_tool( who ) ) {
        return false;
    }

    const tripoint_bub_ms tile = here.get_bub( choice.position );
    // The examine menu has already asked the acting player for permission.
    // Apply the corresponding faction cost on the authority for remote actors.
    if( execution == activity_execution::authoritative &&
        !here.has_flag( "FREE_TO_EXAMINE", tile ) ) {
        g->warn_character_maybe_anger_local_faction( who, false, true, true );
    }
    if( choice.action == safe_action::open ) {
        if( !here.furn_set( tile, furn_f_safe_o ) ) {
            return false;
        }
        who.add_msg_if_player( m_info, _( "You open the unlocked safe." ) );
        return true;
    }
    if( choice.action == safe_action::crack ) {
        player_activity work{ safecracking_activity_actor( choice, who.getID() ) };
        work.set_execution( execution );
        const character_action_guard lifetime( who );
        who.assign_activity( work );
        return lifetime && who.activity.id() == work.id();
    }

    who.mod_moves( -to_moves<int>( 10_seconds ) );
    // Three dial settings, two rotation directions, and five dialing procedures.
    const bool proficient = who.has_proficiency( proficiency_prof_safecracking );
    const bool unlocked = one_in( proficient ? 8000 : 80000 );
    if( unlocked ) {
        here.furn_set( tile, furn_f_safe_o );
    }
    if( proficient ) {
        who.add_msg_if_player( unlocked ? m_good : m_info,
                               unlocked ? _( "You carefully dial a combination… and it opens!" ) :
                               _( "You carefully dial a combination." ) );
    } else {
        who.add_msg_if_player( unlocked ? m_good : m_info,
                               unlocked ? _( "You mess with the dial for a little bit… and it opens!" ) :
                               _( "You mess with the dial for a little bit." ) );
    }
    return true;
}
