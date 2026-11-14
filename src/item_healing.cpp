#include "item_healing.h"

#include <algorithm>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "bodypart.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "creature_tracker.h"
#include "game.h"
#include "item.h"
#include "item_consumption.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_source.h"
#include "itype.h"
#include "iuse.h"
#include "iuse_actor.h"
#include "map.h"
#include "line.h"
#include "mp_gamestate.h"
#include "mp_client_conn.h"
#include "mp_inventory_activity.h"
#include "npc.h"
#include "rng.h"
#include "safe_reference.h"
#include "translations.h"
#include "uilist.h"

const heal_actor *healing_action( const item_location &source )
{
    if( !source ) {
        return nullptr;
    }
    const use_function *use = source->type->get_use( "heal" );
    return use ? dynamic_cast<const heal_actor *>( use->get_actor_ptr() ) : nullptr;
}

Character *find_healing_patient( Character &healer, character_id id )
{
    if( id == healer.getID() ) {
        return &healer;
    }
    if( id == get_avatar().getID() ) {
        return &get_avatar();
    }
    // Loaded actors only: treatment must never reach an unloaded NPC by ID.
    return g->critter_by_id<npc>( id );
}

bool healing_allowed( Character &healer, Character &patient, const item_location &source,
                      const bodypart_id &part, bool allow_theft )
{
    map &here = get_map();
    if( healer.is_dead_state() || patient.is_dead_state() || !source ||
        !healing_action( source ) || source->is_filthy() || source->is_broken() ||
        source->count() <= 0 || !source->ammo_sufficient( &healer, "heal" ) ||
        healer.cant_do_underwater( false ) || healer.cant_do_mounted( false ) ||
        !patient.can_use_heal_item( *source ) || !part.is_valid() || !patient.has_part( part ) ||
        ( !source->is_owned_by( healer, true ) && !allow_theft ) ||
        ( source->is_container() && !source->is_container_empty() ) ) {
        return false;
    }
    const auto parts = patient.get_all_body_parts( get_body_part_flags::only_main );
    if( std::find( parts.begin(), parts.end(), part ) == parts.end() ||
        healer.pos_abs().z() != patient.pos_abs().z() ||
        square_dist( healer.pos_abs().xy(), patient.pos_abs().xy() ) > 1 ||
        !here.inbounds( patient.pos_abs() ) ||
        resolve_item_source( healer, here, capture_item_source( healer, source ) ) != source ) {
        return false;
    }
    // Preserve an explicit source; opening an upright container must not spill
    // unrelated contents as a side effect of the remote player's treatment.
    item_location parent = source;
    while( parent.has_parent() ) {
        const item_pocket *pocket = parent.parent_pocket();
        parent = parent.parent_item();
        if( pocket && pocket->will_spill_if_unsealed() && !pocket->empty() &&
            parent.where() != item_location::type::map && !healer.is_wielding( *parent ) ) {
            return false;
        }
    }
    return true;
}

bool start_owned_healing( Character &healer, Character &patient, const item_location &source,
                          const bodypart_id &part, bool allow_theft )
{
    if( healer.activity || healer.get_moves() <= 0 ||
        !healing_allowed( healer, patient, source, part, allow_theft ) ) {
        return false;
    }
    const heal_actor *use = healing_action( source );
    if( !use->can_treat_part( patient, part ) ) {
        return false;
    }
    firstaid_activity_actor activity( use->healing_cost( healer ), source->tname(), patient.getID() );
    activity.set_owned_target( capture_item_source( healer, source ), source->typeId(), part.id(),
                               allow_theft );
    healer.last_item = source->typeId();
    healer.assign_activity( activity );
    healer.set_moves( 0 );
    return cata_mp::owns_inventory_activity( healer );
}

void select_client_healing( Character &healer, const item_location &source,
                            Character *patient, bool reprompt )
{
    if( !healer.is_avatar() || !cata_mp::is_client_mode() ||
        cata_mp::is_client_waiting_for_ack() || healer.get_moves() <= 0 ) {
        return;
    }
    const heal_actor *use = healing_action( source );
    if( !use ) {
        return;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    if( !patient ) {
        std::vector<safe_reference<Creature>> candidates{ healer.get_safe_reference() };
        uilist menu;
        menu.title = _( "Treat whom?" );
        menu.addentry( 0, true, -1, _( "Yourself" ) );
        map &here = get_map();
        for( const tripoint_bub_ms &pos : here.points_in_radius( healer.pos_bub(), 1 ) ) {
            Character *other = get_creature_tracker().creature_at<Character>( pos );
            if( other && other != &healer && !other->is_dead_state() ) {
                menu.addentry( static_cast<int>( candidates.size() ), true, -1, other->disp_name() );
                candidates.push_back( other->get_safe_reference() );
            }
        }
        if( candidates.size() > 1 ) {
            menu.query();
            if( menu.ret < 0 || static_cast<size_t>( menu.ret ) >= candidates.size() ||
                !candidates[menu.ret] ) {
                return;
            }
            patient = candidates[menu.ret]->as_character();
        } else {
            patient = &healer;
        }
    }
    if( !patient || !source ) {
        return;
    }
    const safe_reference<Creature> patient_lifetime = patient->get_safe_reference();
    item_location selected = source;
    const bodypart_id part = use->use_healing_item( healer, *patient, *selected, false );
    if( source && patient_lifetime && part.is_valid() &&
        query_consumption_ownership( *source, healer ) ) {
        cata_mp::client_start_firstaid( source, *patient, part.id(),
                                        !source->is_owned_by( healer, true ), reprompt );
    }
}
