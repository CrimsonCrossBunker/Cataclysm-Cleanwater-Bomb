#include "spell_casting_choice.h"

#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "crafting.h"
#include "temp_crafting_inventory.h"
#include "item.h"
#include "json.h"
#include "line.h"
#include "magic.h"
#include "map.h"
#include "rng.h"

void spell_casting_choice::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "target", target );
    out.member( "components", components );
    out.member( "tools", tools );
    out.end_object();
}

void spell_casting_choice::deserialize( const JsonObject &data )
{
    data.read( "target", target );
    data.read( "components", components, true );
    data.read( "tools", tools, true );
}

void spell_casting_prompt::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "spell" );
    preview.store_casting_state( out );
    out.member( "target", target );
    out.member( "components", components );
    out.end_object();
}

void spell_casting_prompt::deserialize( const JsonObject &data )
{
    preview = spell::from_casting_state( data.get_object( "spell" ) );
    data.read( "target", target, true );
    data.read( "components", components, true );
}

bool spell_needs_target_choice( const spell &selected, const Character &who )
{
    return selected.range( who ) > 0 && !selected.is_valid_target( spell_target::none ) &&
           !selected.has_flag( spell_flag::RANDOM_TARGET );
}

bool valid_spell_casting_choice( Character &who, const spell &selected,
                                 spell_casting_choice &choice, bool target, bool components )
{
    const character_action_guard lifetime( who );
    if( !lifetime || who.is_dead_state() || target != choice.target.has_value() ) {
        return false;
    }
    map &here = get_map();
    if( target && ( !here.inbounds( *choice.target ) ||
                    rl_dist( who.pos_abs(), *choice.target ) > selected.range( who ) ||
                    !selected.is_valid_target( who, here.get_bub( *choice.target ) ) || !lifetime ||
                    ( !selected.is_valid_target( spell_target::ground ) &&
                      !who.sees( here, here.get_bub( *choice.target ) ) ) ) ) {
        return false;
    }
    if( !components ) {
        return choice.components.empty() && choice.tools.empty();
    }
    who.invalidate_crafting_inventory();
    return validate_requirement_selection( who, selected.components(), choice.components,
                                           choice.tools, 0, return_true<item>, false ) && lifetime;
}

std::optional<spell_casting_choice> spell_casting_prompt::query( Character &who ) const
{
    if( !who.is_avatar() || !preview.id().is_valid() ) {
        return std::nullopt;
    }
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( who );
    // Restoring experience does not emit level-up events from a display copy.
    spell selected = preview;
    spell_casting_choice choice;
    if( target ) {
        const auto position = selected.select_target( &who );
        if( !lifetime || !position ) {
            return std::nullopt;
        }
        choice.target = get_map().get_abs( *position );
    }
    if( components ) {
        temp_crafting_inventory nearby;
        nearby.form_from_map( who.pos_bub(), 0, &who, false );
        for( const auto &group : selected.components().get_components() ) {
            const auto component = who.select_item_component( group, 1, nearby, true );
            if( !lifetime || component.use_from == usage_from::cancel ) {
                return std::nullopt;
            }
            choice.components.push_back( component );
        }
        for( const auto &group : selected.components().get_tools() ) {
            const auto tool = who.select_tool_component( group, 1, nearby, true );
            if( !lifetime || tool.use_from == usage_from::cancel ) {
                return std::nullopt;
            }
            choice.tools.push_back( tool );
        }
    }
    return valid_spell_casting_choice( who, selected, choice, target, components ) ?
           std::make_optional( choice ) : std::nullopt;
}

void consume_spell_casting_components( Character &who, const spell_casting_choice &choice )
{
    map &here = get_map();
    const std::vector<tripoint_bub_ms> points{ who.pos_bub() };
    for( const auto &component : choice.components ) {
        who.consume_items( here, component, 1, return_true<item>, points );
    }
    for( const auto &tool : choice.tools ) {
        who.consume_tools( here, tool, 1, points );
    }
}
