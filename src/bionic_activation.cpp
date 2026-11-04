#include "bionic_activation.h"

#include "action.h"
#include "bionics.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "field_type.h"
#include "item.h"
#include "line.h"
#include "map.h"
#include "player_activity.h"
#include "tool_activity_target.h"
#include "translations.h"

bool bionic_requires_adjacent_target( const bionic_id &id )
{
    return id == bionic_id( "bio_lockpick" ) || id == bionic_id( "bio_lighter" ) ||
           id == bionic_id( "bio_emp" );
}

bool supports_owned_bionic_action( const bionic &bio, bionic_action action )
{
    if( action == bionic_action::deactivate ) {
        // Remote control still owns a global vehicle/controller handle.
        return bio.id != bionic_id( "bio_remote" );
    }
    if( !bio.info().activated || bio.info().spell_on_activate || bio.info().activate_remove_cbm ||
        bio.info().has_flag( json_character_flag( "BIONIC_WEAPON" ) ) ||
        bio.info().has_flag( json_character_flag( "BIONIC_GUN" ) ) ) {
        return false;
    }
    // These native branches need additional choices, an owner-specific report,
    // or a world/position result beyond an ordinary character-state reply.
    for( const char *id : {
             "bio_water_extractor", "bio_remote",
             "bio_resonator", "bio_teleport",
             "bio_magnet", "bio_flashbang", "bio_shockwave"
         } ) {
        if( bio.id == bionic_id( id ) ) {
            return false;
        }
    }
    return true;
}

bool valid_bionic_activation_choices( const Character &who, const bionic &bio,
                                      const bionic_activation_choices &choices )
{
    if( bio.id == bionic_id( "bio_cqb" ) ) {
        return !choices.target && choices.martial_style &&
               valid_martial_style_choice( who, *choices.martial_style, bio.get_uid() );
    }
    if( choices.martial_style ) {
        return false;
    }
    if( !bionic_requires_adjacent_target( bio.id ) ) {
        return !choices.target;
    }
    map &here = get_map();
    if( !choices.target ||
        !here.inbounds( *choices.target ) || choices.target->z() != who.pos_abs().z() ||
        rl_dist( who.pos_abs(), *choices.target ) > 1 ) {
        return false;
    }
    const tripoint_bub_ms target = here.get_bub( *choices.target );
    if( bio.id == bionic_id( "bio_lockpick" ) ) {
        return valid_adjacent_tool_target( adjacent_tool_action::lockpick, who, here,
                                           null_item_reference(), *choices.target );
    }
    return bio.id != bionic_id( "bio_lighter" ) ||
           ( here.is_flammable( target ) && !here.get_field( target, fd_fire ) );
}

std::optional<bionic_activation_choices> query_bionic_activation_choices(
    Character &who, const bionic &bio )
{
    if( bio.id == bionic_id( "bio_cqb" ) ) {
        bionic_activation_choices result;
        result.martial_style = query_martial_style_choice( who, bio.get_uid() ).value_or(
                                   martial_style_choice{ martial_style_action::cancel, matype_id() } );
        return result;
    }
    if( !bionic_requires_adjacent_target( bio.id ) ) {
        return bionic_activation_choices{};
    }
    const bionic_id type = bio.id;
    const auto target = type == bionic_id( "bio_lockpick" ) ?
                        query_adjacent_tool_target( adjacent_tool_action::lockpick, who, get_map(),
                                null_item_reference() ) :
    [&]() -> std::optional<tripoint_abs_ms> {
        const auto selected = choose_adjacent( who.pos_bub(), type == bionic_id( "bio_lighter" ) ?
                                               _( "Start a fire where?" ) : _( "Create an EMP where?" ) );
        return selected ? std::make_optional( get_map().get_abs( *selected ) ) : std::nullopt;
    }();
    return target ? std::make_optional( bionic_activation_choices{ target } ) : std::nullopt;
}

bool execute_owned_bionic_action( Character &who, unsigned int uid,
                                  const bionic_id &expected_type,
                                  const bionic_activation_choices &choices, bionic_action action )
{
    const character_action_guard lifetime( who );
    const auto bio = who.find_bionic_by_uid( uid );
    if( !lifetime || who.activity || who.get_moves() <= 0 || !bio ||
        ( *bio )->id != expected_type || !supports_owned_bionic_action( **bio, action ) ||
        ( action == bionic_action::activate ? !valid_bionic_activation_choices( who, **bio, choices ) :
          ( choices.target.has_value() || choices.martial_style.has_value() ) ) ) {
        return false;
    }
    const activity_execution previous = who.activity.execution();
    who.activity.set_execution( activity_execution::authoritative );
    const on_out_of_scope restore_role( [&]() {
        if( lifetime ) {
            who.activity.set_execution( who.activity ? activity_execution::authoritative : previous );
        }
    } );
    return action == bionic_action::activate ? who.activate_bionic( **bio, false, nullptr,
            ( bionic_requires_adjacent_target( ( *bio )->id ) ||
              choices.martial_style ) ? &choices : nullptr ) :
           who.deactivate_bionic( **bio );
}
