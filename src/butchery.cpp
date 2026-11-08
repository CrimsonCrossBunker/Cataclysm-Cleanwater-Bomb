#include "butchery.h"

#include <item_location.h>
#include <type_id.h>
#include <algorithm>
#include <array>
#include <climits>
#include <cmath>
#include <cstddef>
#include <functional>
#include <list>
#include <memory>
#include <utility>

#include "activity_handlers.h"
#include "activity_actor_definitions.h"
#include "cata_scope_helpers.h"
#include "character_action_guard.h"
#include "json.h"
#include "mp_client_conn.h"
#include "item_uid.h"
#include <set>
#include "avatar.h"
#include "butchery_requirements.h"
#include "cached_options.h"
#include "calendar.h"
#include "cata_utility.h"
#include "character.h"
#include "color.h"
#include "coordinates.h"
#include "creature.h"
#include "debug.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "flag.h"
#include "game.h"
#include "game_constants.h"
#include "handle_liquid.h"
#include "harvest.h"
#include "item.h"
#include "itype.h"
#include "map.h"
#include "messages.h"
#include "mtype.h"
#include "npc.h"
#include "npc_opinion.h"
#include "output.h"
#include "player_activity.h"
#include "pocket_type.h"
#include "proficiency.h"
#include "requirements.h"
#include "rng.h"
#include "string_formatter.h"
#include "text_snippets.h"
#include "translation.h"
#include "translations.h"
#include "uilist.h"
#include "units.h"
#include "weakpoint.h"

static const activity_id ACT_BLEED( "ACT_BLEED" );
static const activity_id ACT_BUTCHER( "ACT_BUTCHER" );
static const activity_id ACT_BUTCHER_FULL( "ACT_BUTCHER_FULL" );
static const activity_id ACT_DISMEMBER( "ACT_DISMEMBER" );
static const activity_id ACT_DISSECT( "ACT_DISSECT" );
static const activity_id ACT_FIELD_DRESS( "ACT_FIELD_DRESS" );
static const activity_id ACT_MULTIPLE_BUTCHER( "ACT_MULTIPLE_BUTCHER" );
static const activity_id ACT_QUARTER( "ACT_QUARTER" );
static const activity_id ACT_SKIN( "ACT_SKIN" );

static const harvest_drop_type_id harvest_drop_blood( "blood" );
static const harvest_drop_type_id harvest_drop_bone( "bone" );
static const harvest_drop_type_id harvest_drop_flesh( "flesh" );
static const harvest_drop_type_id harvest_drop_offal( "offal" );
static const harvest_drop_type_id harvest_drop_skin( "skin" );

static const itype_id itype_burnt_out_bionic( "burnt_out_bionic" );
static const itype_id itype_demihuman_flesh( "demihuman_flesh" );
static const itype_id itype_human_flesh( "human_flesh" );
static const itype_id itype_mutant_human_flesh( "mutant_human_flesh" );

static const json_character_flag json_flag_INSENSITIVITY( "INSENSITIVITY" );
static const json_character_flag json_flag_INSTANT_BLEED( "INSTANT_BLEED" );

static const morale_type morale_butcher( "morale_butcher" );

static const proficiency_id proficiency_prof_butchering_adv( "prof_butchering_adv" );
static const proficiency_id proficiency_prof_butchering_basic( "prof_butchering_basic" );
static const proficiency_id proficiency_prof_dissect_humans( "prof_dissect_humans" );
static const proficiency_id proficiency_prof_physiology( "prof_physiology" );
static const proficiency_id proficiency_prof_skinning_adv( "prof_skinning_adv" );
static const proficiency_id proficiency_prof_skinning_basic( "prof_skinning_basic" );

static const quality_id qual_BUTCHER( "BUTCHER" );
static const quality_id qual_CUT_FINE( "CUT_FINE" );

static const skill_id skill_firstaid( "firstaid" );
static const skill_id skill_survival( "survival" );

static const species_id species_HUMAN( "HUMAN" );
static const species_id species_ZOMBIE( "ZOMBIE" );

static bool is_human_autopsy_corpse( const mtype &corpse )
{
    // NO A BUG: don't try to be clever and "fix" it.
    if( corpse.id == mtype_id::NULL_ID() || corpse.in_species( species_HUMAN ) ) {
        for( const harvest_entry &entry : corpse.harvest->entries() ) {
            // It also counts if zombie human can be butchered out human flesh.
            if( entry.type == harvest_drop_flesh &&
                ( entry.drop == itype_human_flesh.str() ||
                  entry.drop == itype_mutant_human_flesh.str() ||
                  entry.drop == itype_demihuman_flesh.str() ) ) {
                return true;
            }
        }
    }
    return false;
}

namespace io
{
    // *INDENT-OFF*
    template<>
    std::string enum_to_string<butcher_type>( butcher_type data )
    {
        switch( data ) {
        case butcher_type::BLEED: return "BLEED";
        case butcher_type::DISMEMBER: return "DISMEMBER";
        case butcher_type::DISSECT: return "DISSECT";
        case butcher_type::FIELD_DRESS: return "FIELD_DRESS";
        case butcher_type::FULL: return "FULL";
        case butcher_type::QUARTER: return "QUARTER";
        case butcher_type::QUICK: return "QUICK";
        case butcher_type::SKIN: return "SKIN";
        case butcher_type::NUM_TYPES: break;
        }
        cata_fatal( "Invalid valid_target" );
    }
    // *INDENT-ON*

} // namespace io

static bool check_butcher_dissect( const int roll )
{
    // Failure rates for dissection rolls
    // 100% at roll 0, 66% at roll 1, 50% at roll 2, 40% @ 3, 33% @ 4, 28% @ 5, ... , 16% @ 10
    // Roll is roughly a rng(0, -3 + 1st_aid + fine_cut_quality + 1/2 electronics + small_dex_bonus)
    // Roll is reduced by corpse damage level, but to no less then 0
    add_msg_debug( debugmode::DF_ACT_BUTCHER, "Roll = %i", roll );
    add_msg_debug( debugmode::DF_ACT_BUTCHER, "Failure chance = %f%%",
                   ( 10.0f / ( 10.0f + roll * 5.0f ) ) * 100.0f );
    const bool failed = x_in_y( 10, ( 10 + roll * 5 ) );
    return !failed;
}

struct butchery_product {
    item value;
    tripoint_bub_ms position;
    bool collect_liquid = false;
    bool direct_placement = false;
};

static void butcher_dissect_item( const item &what, const tripoint_bub_ms &pos,
                                  const time_point &age, const int roll, std::vector<butchery_product> &products )
{
    if( roll < 0 ) {
        return;
    }
    const bool success = check_butcher_dissect( roll );
    if( what.is_bionic() && !success ) {
        item burnt_out_cbm( itype_burnt_out_bionic, age );
        add_msg( m_good, _( "You discover a %s!" ), burnt_out_cbm.tname() );
        products.push_back( { std::move( burnt_out_cbm ), pos, false, true } );
    } else if( success ) {
        add_msg( m_good, _( "You discover a %s!" ), what.tname() );
        products.push_back( { what, pos, false, true } );
    }
}

std::string butcher_progress_var( const butcher_type action )
{
    return io::enum_to_string( action ) + "_progress";
}

std::string butcher_progress_time_var()
{
    return "butchery_progress_time";
}

// How much of `butcher_type` has already been completed, in range [0..1], 0=not started yet, 1=completed.
// used for resuming previously started butchery
double butcher_get_progress( const item &corpse_item, const butcher_type action )
{
    return corpse_item.get_var( butcher_progress_var( action ), 0.0 );
}

butcher_type get_butcher_type( player_activity *act )
{
    butcher_type action = butcher_type::QUICK;
    if( act->id() == ACT_BUTCHER ) {
        action = butcher_type::QUICK;
    } else if( act->id() == ACT_BUTCHER_FULL ) {
        action = butcher_type::FULL;
    } else if( act->id() == ACT_FIELD_DRESS ) {
        action = butcher_type::FIELD_DRESS;
    } else if( act->id() == ACT_QUARTER ) {
        action = butcher_type::QUARTER;
    } else if( act->id() == ACT_DISSECT ) {
        action = butcher_type::DISSECT;
    } else if( act->id() == ACT_BLEED ) {
        action = butcher_type::BLEED;
    } else if( act->id() == ACT_SKIN ) {
        action = butcher_type::SKIN;
    } else if( act->id() == ACT_DISMEMBER ) {
        action = butcher_type::DISMEMBER;
    }
    return action;
}

bool character_has_butchery_empathy( const Character &character, const mtype_id &corpse )
{
    return ( corpse == mtype_id::NULL_ID() || !corpse->in_species( species_ZOMBIE ) ) &&
           character.empathizes_with_monster( corpse );
}

static std::string butchery_empathy_prompt( const Character &you, const mtype_id &monster )
{
    const map &here = get_map();
    const bool you_empathize = character_has_butchery_empathy( you, monster );
    bool nearby_empathetic_npc = false;
    for( const npc &guy : g->all_npcs() ) {
        if( guy.getID() != you.getID() && guy.is_active() && guy.sees( here, you ) &&
            character_has_butchery_empathy( guy, monster ) ) {
            nearby_empathetic_npc = true;
            break;
        }
    }
    if( you_empathize && nearby_empathetic_npc ) {
        return _( "Really desecrate the mortal remains of this being by butchering them for meat?  You feel others may take issue with your action." );
    }
    if( you_empathize ) {
        return _( "Really desecrate the mortal remains of this being by butchering them for meat?" );
    }
    if( nearby_empathetic_npc ) {
        return _( "Really take this thing apart?  You feel others may take issue with your action." );
    }
    return {};
}

static bool butchery_needs_empathy_check( const Character &who, butcher_type action )
{
    return action != butcher_type::DISMEMBER &&
           !( action == butcher_type::DISSECT && who.has_proficiency( proficiency_prof_dissect_humans ) );
}

static bool check_anger_empathetic_npcs_with_cannibalism( const Character &you,
        const mtype_id &monster, const std::optional<bool> &consent )
{
    if( !you.is_player_controlled() ) {
        return true;
    }
    const std::string prompt = butchery_empathy_prompt( you, monster );
    if( !prompt.empty() && !( consent ? *consent :
                              you.is_avatar() && query_yn( "%s", prompt ) ) ) {
        return false;
    }
    if( !you.is_avatar() ) {
        // Per-player NPC relationships are migrated with the dialogue domain;
        // never apply another player's deed to the host's op_of_u in the interim.
        return true;
    }
    const map &here = get_map();
    for( npc &guy : g->all_npcs() ) {
        if( guy.is_active() && guy.sees( here, you ) &&
            character_has_butchery_empathy( guy, monster ) ) {
            guy.say( _( "<swear!>?  Are you butchering them?  That's not okay, <name_b>." ) );
            // massive opinion penalty
            guy.op_of_u.trust -= 5;
            guy.op_of_u.value -= 5;
            guy.op_of_u.anger += 5;
            if( guy.turned_hostile() ) {
                guy.make_angry();
            }
        }
    }

    return true;
}

void butchery_selection::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "corpse", corpse );
    out.member( "type", type );
    out.member( "action", static_cast<int>( action ) );
    out.member( "allow_theft", allow_theft );
    out.member( "allow_desecration", allow_desecration );
    out.end_object();
}

void butchery_selection::deserialize( const JsonObject &data )
{
    data.read( "corpse", corpse, true );
    data.read( "type", type, true );
    action = static_cast<butcher_type>( data.get_int( "action" ) );
    data.read( "allow_theft", allow_theft );
    data.read( "allow_desecration", allow_desecration );
}

bool accessible_butchery_corpse( Character &who, const item_location &corpse )
{
    map &here = get_map();
    return corpse && corpse->is_corpse() &&
           !activity_handlers::activity_item_reserved_for_other( *corpse, who ) &&
           resolve_item_source( who, here, capture_item_source( who, corpse ) ) == corpse &&
           ( corpse.held_by( who ) || ( here.accessible_items( corpse.pos_bub( here ) ) &&
                                        here.clear_path( who.pos_bub(), corpse.pos_bub( here ), 1, 1, 100 ) ) );
}

bool query_butchery_selection( Character &who, const std::vector<item_location> &corpses,
                               butcher_type action, std::vector<butchery_selection> &selected )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( who );
    map &here = get_map();
    const auto context = here.get_context_reference();
    const auto origin = who.pos_abs();
    selected.clear();
    if( action < butcher_type::BLEED || action >= butcher_type::NUM_TYPES || corpses.empty() ) {
        return false;
    }
    std::set<mtype_id> confirmed;
    for( const item_location &corpse : corpses ) {
        if( !accessible_butchery_corpse( who, corpse ) ||
            !butcher_action_applicable( who, *corpse, action ) ) {
            continue;
        }
        butchery_selection selection;
        selection.corpse = capture_item_source( who, corpse );
        selection.type = corpse->get_mtype()->id;
        selection.action = action;
        selection.allow_theft = !corpse->is_owned_by( who, true );
        if( selection.allow_theft && !who.query_yn(
                _( "Butchering the %s may anger the people who own it, continue?" ), corpse->tname() ) ) {
            return false;
        }
        if( !lifetime || !context || who.pos_abs() != origin || !corpse ) {
            return false;
        }
        if( butchery_needs_empathy_check( who, action ) && confirmed.insert( selection.type ).second ) {
            const std::string prompt = butchery_empathy_prompt( who, selection.type );
            if( !prompt.empty() && !who.query_yn( "%s", prompt ) ) {
                return false;
            }
        }
        if( !lifetime || !context || who.pos_abs() != origin || !corpse ||
            !corpse->is_corpse() || corpse->get_mtype()->id != selection.type ||
            resolve_item_source( who, here, selection.corpse ) != corpse ) {
            return false;
        }
        selection.allow_desecration = true;
        selected.push_back( selection );
    }
    return !selected.empty();
}

bool start_owned_butchery( Character &who, const std::vector<butchery_selection> &selected )
{
    map &here = get_map();
    if( cata_mp::is_client_mode() || who.activity || who.get_moves() <= 0 || who.is_dead_state() ||
        !who.has_morale_to_craft() || selected.empty() ) {
        return false;
    }
    std::set<int64_t> seen;
    std::vector<butchery_data> corpses;
    for( const butchery_selection &selection : selected ) {
        item_location corpse = resolve_item_source( who, here, selection.corpse );
        if( selection.corpse.kind != "map" || selection.corpse.path.size() != 1 ||
            selection.action < butcher_type::BLEED || selection.action >= butcher_type::NUM_TYPES ||
            !accessible_butchery_corpse( who, corpse ) || corpse->get_mtype()->id != selection.type ||
            !seen.insert( corpse->uid().get_value() ).second ||
            !butcher_action_applicable( who, *corpse, selection.action ) ||
            ( !selection.allow_theft && !corpse->is_owned_by( who, true ) ) ||
            ( butchery_needs_empathy_check( who, selection.action ) && !selection.allow_desecration &&
              !butchery_empathy_prompt( who, selection.type ).empty() ) ) {
            return false;
        }
        butchery_data work( corpse, selection.action );
        work.corpse_type = selection.type;
        work.allow_desecration = selection.allow_desecration;
        work.allow_theft = selection.allow_theft;
        corpses.push_back( work );
    }
    who.assign_activity( butchery_activity_actor( std::move( corpses ) ) );
    return true;
}

bool set_up_butchery( Character &you, const butchery_data &bd )
{
    const int factor = you.max_quality( bd.b_type == butcher_type::DISSECT ? qual_CUT_FINE :
                                        qual_BUTCHER, pickup_range );

    const butcher_type action = bd.b_type;
    const item &corpse_item = *bd.corpse;
    const mtype &corpse = *corpse_item.get_mtype();

    if( bd.b_type != butcher_type::DISSECT ) {
        if( factor == INT_MIN ) {
            you.add_msg_if_player( m_info,
                                   _( "None of your cutting tools are suitable for butchering." ) );
            return false;
        } else if( factor < 10 && one_in( 3 ) ) {
            you.add_msg_if_player( m_bad,
                                   _( "You don't trust the quality of your tools, but carry on anyway." ) );
        }
    }

    if( bd.b_type == butcher_type::DISSECT ) {
        switch( factor ) {
            case 0:
                you.add_msg_if_player( m_info, _( "None of your tools are sharp and precise enough to do that." ) );
                return false;
            case 1:
                you.add_msg_if_player( m_info, _( "You could use a better tool, but this will do." ) );
                break;
            case 2:
                you.add_msg_if_player( m_info, _( "This tool is great, but you still would like a scalpel." ) );
                break;
            case 3:
                you.add_msg_if_player( m_info, _( "You dissect the corpse with a trusty scalpel." ) );
                break;
            case 5:
                you.add_msg_if_player( m_info,
                                       _( "You dissect the corpse with a sophisticated system of surgical grade scalpels." ) );
                break;
        }
    }

    // Requirements for the various types
    const requirement_id butchery_requirement = bd.req;

    if( !butchery_requirement->can_make_with_inventory(
            &you, you.crafting_inventory( you.pos_bub(), pickup_range ), is_crafting_component ) ) {
        std::string popup_output = _( "You can't butcher this; you are missing some tools.\n" );

        for( const std::string &str : butchery_requirement->get_folded_components_list(
                 &you, 45, c_light_gray, you.crafting_inventory( you.pos_bub(), pickup_range ),
                 is_crafting_component ) ) {
            popup_output += str + '\n';
        }
        for( const std::string &str : butchery_requirement->get_folded_tools_list(
                 &you, 45, c_light_gray, you.crafting_inventory( you.pos_bub(), pickup_range ) ) ) {
            popup_output += str + '\n';
        }

        if( you.is_avatar() ) {
            popup( popup_output );
        } else {
            you.add_msg_if_player( m_info, "%s", popup_output );
        }
        return false;
    }

    if( bd.b_type == butcher_type::BLEED && ( corpse_item.has_flag( flag_BLED ) ||
            corpse_item.has_flag( flag_QUARTERED ) || corpse_item.has_flag( flag_FIELD_DRESS_FAILED ) ||
            corpse_item.has_flag( flag_FIELD_DRESS ) ) ) {
        you.add_msg_if_player( m_info, _( "This corpse has already been bled." ) );
        return false;
    }

    if( action == butcher_type::DISSECT && ( corpse_item.has_flag( flag_QUARTERED ) ||
            corpse_item.has_flag( flag_FIELD_DRESS_FAILED ) ) ) {
        you.add_msg_if_player( m_info,
                               _( "It would be futile to dissect this badly damaged corpse." ) );
        return false;
    }

    if( action == butcher_type::FIELD_DRESS && ( corpse_item.has_flag( flag_FIELD_DRESS ) ||
            corpse_item.has_flag( flag_FIELD_DRESS_FAILED ) ) ) {
        you.add_msg_if_player( m_info, _( "This corpse is already field dressed." ) );
        return false;
    }

    if( action == butcher_type::SKIN && corpse_item.has_flag( flag_SKINNED ) ) {
        you.add_msg_if_player( m_info, _( "This corpse is already skinned." ) );
        return false;
    }

    if( action == butcher_type::QUARTER ) {
        if( corpse.size == creature_size::tiny ) {
            you.add_msg_if_player( m_bad, _( "This corpse is too small to quarter without damaging." ),
                                   corpse.nname() );
            return false;
        }
        if( corpse_item.has_flag( flag_QUARTERED ) ) {
            you.add_msg_if_player( m_bad, _( "This is already quartered." ), corpse.nname() );
            return false;
        }
        if( !( corpse_item.has_flag( flag_FIELD_DRESS ) ||
               corpse_item.has_flag( flag_FIELD_DRESS_FAILED ) ) &&
            corpse_item.get_mtype()->harvest->has_entry_type( harvest_drop_offal ) ) {
            you.add_msg_if_player( m_bad, _( "You need to perform field dressing before quartering." ),
                                   corpse.nname() );
            return false;
        }
    }

    // Dissections are slightly less angering than other butcher types
    if( action == butcher_type::DISSECT ) {
        if( you.has_proficiency( proficiency_prof_dissect_humans ) ) {
            if( character_has_butchery_empathy( you, corpse.id ) ) {
                // this is a dissection, and we are trained for dissection, so no morale penalty, anger, and lighter flavor text.
                you.add_msg_if_player( m_good, SNIPPET.random_from_category(
                                           "msg_human_dissection_with_prof" ).value_or( translation() ).translated() );
            }
        } else {
            if( check_anger_empathetic_npcs_with_cannibalism( you, corpse.id, bd.allow_desecration ) ) {
                if( character_has_butchery_empathy( you, corpse.id ) ) {
                    // give us a message indicating we are dissecting without the stomach for it, but not actually butchering. lower morale penalty.
                    you.add_msg_if_player( m_good, SNIPPET.random_from_category(
                                               "msg_human_dissection_no_prof" ).value_or( translation() ).translated() );
                    if( you.has_flag( json_flag_INSENSITIVITY ) ) {
                        you.add_morale( morale_butcher, -20, 0, 1_days, 2_hours );
                    } else {
                        you.add_morale( morale_butcher, -40, 0, 1_days, 2_hours );
                    }
                }
            } else {
                // standard refusal to butcher
                you.add_msg_if_player( m_good, _( "It needs a coffin, not a knife." ) );
                return false;
            }
        }
    } else if( action != butcher_type::DISMEMBER ) {
        if( check_anger_empathetic_npcs_with_cannibalism( you, corpse.id, bd.allow_desecration ) ) {
            if( character_has_butchery_empathy( you, corpse.id ) ) {
                // give the player a random message showing their disgust and cause morale penalty.
                you.add_msg_if_player( m_good, SNIPPET.random_from_category(
                                           "msg_human_butchery" ).value_or( translation() ).translated() );
                if( you.has_flag( json_flag_INSENSITIVITY ) ) {
                    you.add_morale( morale_butcher, -25, 0, 2_days, 3_hours );
                } else {
                    you.add_morale( morale_butcher, -50, 0, 2_days, 3_hours );
                }
            }
        } else {
            if( you.has_proficiency( proficiency_prof_dissect_humans ) ) {
                // player has the dissect_humans prof, so they're familiar with dissection. reference this in their refusal to butcher
                you.add_msg_if_player( m_good, _( "You were trained for autopsies, not butchery." ) );
                return false;
            } else {
                // player doesn't have dissect_humans, so just give a regular refusal to mess with the corpse
                you.add_msg_if_player( m_good, _( "It needs a coffin, not a knife." ) );
                return false;
            }
        }
    }

    return true;
}

int butcher_time_to_cut( Character &you, const item &corpse_item, const butcher_type action )
{
    const mtype &corpse = *corpse_item.get_mtype();
    const int factor = you.max_quality( action == butcher_type::DISSECT ? qual_CUT_FINE : qual_BUTCHER,
                                        pickup_range );
    // in moves
    int time_to_cut;
    switch( corpse.size ) {
        // Time (roughly) in turns to cut up the corpse
        case creature_size::tiny:
            time_to_cut = 150;
            break;
        case creature_size::small:
            time_to_cut = 300;
            break;
        case creature_size::medium:
            time_to_cut = 450;
            break;
        case creature_size::large:
            time_to_cut = 600;
            break;
        case creature_size::huge:
            time_to_cut = 1800;
            break;
        default:
            debugmsg( "ERROR: Invalid creature_size on %s", corpse.nname() );
            time_to_cut = 450; // default to medium
            break;
    }

    // At factor 0, base 100 time_to_cut remains 100. At factor 50, it's 50 , at factor 75 it's 25
    time_to_cut *= std::max( 25, 100 - factor );

    switch( action ) {
        case butcher_type::QUICK:
            break;
        case butcher_type::BLEED:
            if( you.has_flag( json_flag_INSTANT_BLEED ) ) {
                time_to_cut = 1;
            }
            break;
        case butcher_type::FULL:
            if( !corpse_item.has_flag( flag_FIELD_DRESS ) || corpse_item.has_flag( flag_FIELD_DRESS_FAILED ) ) {
                time_to_cut *= 6;
            } else {
                time_to_cut *= 4;
            }
            break;
        case butcher_type::FIELD_DRESS:
        case butcher_type::SKIN:
            time_to_cut *= 2;
            break;
        case butcher_type::QUARTER:
            time_to_cut /= 4;
            if( time_to_cut < 1200 ) {
                time_to_cut = 1200;
            }
            break;
        case butcher_type::DISMEMBER:
            time_to_cut /= 10;
            if( time_to_cut < 600 ) {
                time_to_cut = 600;
            }
            break;
        case butcher_type::DISSECT:
            time_to_cut *= 6;
            break;
        case butcher_type::NUM_TYPES:
            debugmsg( "ERROR: Invalid butcher_type" );
            break;
    }

    if( corpse_item.has_flag( flag_QUARTERED ) ) {
        time_to_cut /= 4;
    }

    double butch_basic = you.get_proficiency_practice( proficiency_prof_butchering_basic );
    double butch_adv = you.get_proficiency_practice( proficiency_prof_butchering_adv );
    double skin_basic = you.get_proficiency_practice( proficiency_prof_skinning_basic );
    double penalty_small = 0.5;
    double penalty_big = 1.5;

    int prof_butch_penalty = penalty_big * ( 1 - butch_basic ) + penalty_small * ( 1 - butch_adv );
    int prof_skin_penalty = penalty_small * ( 1 - skin_basic );

    // there supposed to be a code for book mitigation, but we don't have any book fitting for this

    if( action == butcher_type::FULL ) {
        // 40% of butchering and gutting, 40% of skinning, 20% another activities
        time_to_cut *= 0.4 * ( 1 + prof_butch_penalty ) + 0.4 * ( 1 + prof_skin_penalty ) + 0.2;
    }

    if( action == butcher_type::QUICK ) {
        // 70% of butchery, 15% skinning, 15% another activities
        time_to_cut *= 0.7 * ( 1 + prof_butch_penalty ) + 0.15 * ( 1 + prof_skin_penalty ) + 0.15;
    }

    if( action == butcher_type::FIELD_DRESS ) {
        time_to_cut *= 1 + prof_butch_penalty;
    }

    if( action == butcher_type::SKIN ) {
        time_to_cut *= 1 + prof_skin_penalty;
    }

    time_to_cut *= ( 1.0f - ( you.get_num_crafting_helpers( 3 ) / 10.0f ) );
    return time_to_cut;
}

// this function modifies the input weight by its damage level, depending on the bodypart
static int corpse_damage_effect( int weight, const harvest_drop_type_id &entry_type,
                                 int damage_level )
{
    const float slight_damage = 0.9f;
    const float damage = 0.75f;
    const float high_damage = 0.5f;
    const int destroyed = 0;

    switch( damage_level ) {
        case 2:
            // "damaged"
            if( entry_type == harvest_drop_offal ) {
                return std::round( weight * damage );
            }
            if( entry_type == harvest_drop_skin ) {
                return std::round( weight * damage );
            }
            if( entry_type == harvest_drop_flesh ) {
                return std::round( weight * slight_damage );
            }
            break;
        case 3:
            // "mangled"
            if( entry_type == harvest_drop_offal ) {
                return destroyed;
            }
            if( entry_type == harvest_drop_skin ) {
                return std::round( weight * high_damage );
            }
            if( entry_type == harvest_drop_bone ) {
                return std::round( weight * slight_damage );
            }
            if( entry_type == harvest_drop_flesh ) {
                return std::round( weight * damage );
            }
            break;
        case 4:
            // "pulped"
            if( entry_type == harvest_drop_offal ) {
                return destroyed;
            }
            if( entry_type == harvest_drop_skin ) {
                return destroyed;
            }
            if( entry_type == harvest_drop_bone ) {
                return std::round( weight * damage );
            }
            if( entry_type == harvest_drop_flesh ) {
                return std::round( weight * high_damage );
            }
            break;
        default:
            // "bruised" modifier is almost impossible to avoid; also includes no modifier (zero damage)
            break;
    }
    return weight;
}

static int butchery_dissect_skill_level( Character &you, int tool_quality,
        const harvest_drop_type_id &htype )
{
    // DISSECT has special case factor calculation and results.
    if( htype.is_valid() ) {
        float sk_total = 0;
        int sk_count = 0;
        for( const skill_id &sk : htype->get_harvest_skills() ) {
            sk_total += you.get_average_skill_level( sk );
            sk_count++;
        }
        return round( ( sk_total + tool_quality ) / ( sk_count > 0 ? sk_count : 1 ) );
    }
    return round( you.get_average_skill_level( skill_survival ) );
}

int roll_butchery_dissect( int skill_level, int dex, int tool_quality )
{
    double skill_shift = 0.0;
    ///\EFFECT_SURVIVAL randomly increases butcher rolls
    skill_shift += rng_float( 0, skill_level - 3 );
    ///\EFFECT_DEX >8 randomly increases butcher rolls, slightly, <8 decreases
    skill_shift += rng_float( 0, dex - 8 ) / 4.0;

    if( tool_quality < 0 ) {
        skill_shift -= rng_float( 0, -tool_quality / 5.0 );
    } else {
        skill_shift += std::min( tool_quality, 4 );
    }

    return static_cast<int>( std::round( skill_shift ) );
}

// A number between 0 and 1 that represents how much usable material can be harvested
// as a fraction of the maximum possible amount.
static double butchery_dissect_yield_mult( int skill_level, int dex, int tool_quality )
{
    const double skill_score = skill_level / 10.0;
    const double tool_score = ( tool_quality + 50.0 ) / 100.0;
    const double dex_score = dex / 20.0;
    return 0.5 * clamp( skill_score, 0.0, 1.0 ) +
           0.3 * clamp( tool_score, 0.0, 1.0 ) +
           0.2 * clamp( dex_score, 0.0, 1.0 );
}

static std::vector<item> create_charge_items( const itype *drop, int count,
        const harvest_entry &entry, const item *corpse_item, const Character &you )
{
    std::vector<item> objs;
    while( count > 0 ) {
        item obj( drop, calendar::turn, 1 );
        obj.charges = std::min( count, default_tile_volume / obj.volume() );
        count -= obj.charges;

        if( obj.has_temperature() ) {
            obj.set_item_temperature( corpse_item->temperature );
            if( obj.goes_bad() ) {
                obj.set_rot( corpse_item->get_rot() );
            }
        }
        for( const flag_id &flg : entry.flags ) {
            obj.set_flag( flg );
        }
        for( const fault_id &flt : entry.faults ) {
            obj.set_fault( flt, false, nullptr, true );
        }
        if( !you.backlog.empty() && you.backlog.front().id() == ACT_MULTIPLE_BUTCHER ) {
            activity_handlers::mark_activity_item( obj, you );

        }
        objs.push_back( obj );
    }
    return objs;
}

static std::optional<bool> collect_butchery_products( const butchery_data &bt, Character &you,
        std::vector<butchery_product> &products )
{
    const character_action_guard lifetime( you );
    map &here = get_map();
    const auto context = here.get_context_reference();
    const auto generation = you.activity.identity_generation();
    const auto origin = you.pos_abs();
    const auto continuing = [&]() {
        return lifetime && context && you.activity.identity_generation() == generation &&
               you.pos_abs() == origin && bt.corpse;
    };
    const butcher_type action = bt.b_type;
    item corpse_item = *bt.corpse.get_item();
    const mtype &mt = *corpse_item.get_mtype();
    const time_duration moves_total = bt.time_to_butcher;

    const int tool_quality = you.max_quality( action == butcher_type::DISSECT ? qual_CUT_FINE :
                             qual_BUTCHER, pickup_range );

    //all BUTCHERY types - FATAL FAILURE
    if( action != butcher_type::DISSECT &&
        roll_butchery_dissect( round( you.get_average_skill_level( skill_survival ) ), you.get_dex(),
                               tool_quality ) <= ( -15 ) && one_in( 2 ) ) {
        return false;
    }

    you.add_msg_if_player( m_neutral, mt.harvest->message() );
    int monster_weight = to_gram( mt.weight );
    monster_weight += std::round( monster_weight * rng_float( -0.1, 0.1 ) );
    if( corpse_item.has_flag( flag_QUARTERED ) ) {
        monster_weight *= 0.95;
    }
    if( corpse_item.has_flag( flag_GIBBED ) ) {
        monster_weight = std::round( 0.85 * monster_weight );
        if( action != butcher_type::FIELD_DRESS ) {
            you.add_msg_if_player( m_bad,
                                   _( "You salvage what you can from the corpse, but it is badly damaged." ) );
        }
    }
    if( corpse_item.has_flag( flag_SKINNED ) ) {
        monster_weight = std::round( 0.85 * monster_weight );
    }
    const int entry_count = ( action == butcher_type::DISSECT &&
                              !mt.dissect.is_empty() ) ? mt.dissect->entries().size() : mt.harvest->entries().size();
    int monster_weight_remaining = monster_weight;
    int practice = 0;

    if( mt.harvest.is_null() ) {
        debugmsg( "ERROR: %s has no harvest entry.", mt.id.c_str() );
        return false;
    }

    if( action == butcher_type::DISSECT )    {
        int dissectable_practice = 0;
        int dissectable_num = 0;
        for( item *item : corpse_item.all_items_top( pocket_type::CORPSE ) ) {
            dissectable_num++;
            const int skill_level = butchery_dissect_skill_level( you, tool_quality,
                                    item->dropped_from );
            const int butchery = roll_butchery_dissect( skill_level, you.get_dex(), tool_quality );
            dissectable_practice += ( 4 + butchery );
            int roll = butchery - corpse_item.damage_level();
            roll = roll < 0 ? 0 : roll;
            add_msg_debug( debugmode::DF_ACT_BUTCHER, "Roll penalty for corpse damage = %s",
                           0 - corpse_item.damage_level() );
            butcher_dissect_item( *item, you.pos_bub(), calendar::turn, roll, products );
        }
        if( dissectable_num > 0 ) {
            practice += dissectable_practice / dissectable_num;
        }
    }

    const tripoint_bub_ms corpse_loc = bt.corpse.pos_bub( here );

    for( const harvest_entry &entry : ( action == butcher_type::DISSECT &&
                                        !mt.dissect.is_empty() ) ? *mt.dissect : *mt.harvest ) {
        const int skill_level = butchery_dissect_skill_level( you, tool_quality, entry.type );
        const int butchery = roll_butchery_dissect( skill_level, you.get_dex(), tool_quality );
        practice += ( 4 + butchery ) / entry_count;
        const float min_num = entry.base_num.first + butchery * entry.scale_num.first;
        const float max_num = entry.base_num.second + butchery * entry.scale_num.second;

        int roll = 0;
        // mass_ratio will override the use of base_num, scale_num, and max
        if( entry.mass_ratio != 0.00f ) {
            roll = static_cast<int>( std::round( entry.mass_ratio * monster_weight ) );
            roll = corpse_damage_effect( roll, entry.type, corpse_item.damage_level() );
        } else {
            roll = std::min<int>( entry.max, std::round( rng_float( min_num, max_num ) ) );
            // will not give less than min_num defined in the JSON
            roll = std::max<int>( corpse_damage_effect( roll, entry.type, corpse_item.damage_level() ),
                                  entry.base_num.first );
        }

        itype_id drop_id = itype_id::NULL_ID();
        const itype *drop = nullptr;
        if( entry.type->is_itype() ) {
            drop_id = itype_id( entry.drop );
            drop = item::find_type( drop_id );
        }

        // Check if monster was gibbed, and handle accordingly
        if( corpse_item.has_flag( flag_GIBBED ) && ( entry.type == harvest_drop_flesh ||
                entry.type == harvest_drop_bone ) ) {
            roll /= 2;
        }

        if( ( corpse_item.has_flag( flag_SKINNED ) || corpse_item.has_flag( flag_QUARTERED ) ) &&
            entry.type == harvest_drop_skin ) {
            continue;
        }

        const double butch_basic = you.get_proficiency_practice( proficiency_prof_butchering_basic );
        const double skin_basic = you.get_proficiency_practice( proficiency_prof_skinning_basic );
        const double skin_adv = you.get_proficiency_practice( proficiency_prof_skinning_adv );
        const double penalty_small = 0.15;
        const double penalty_big = 2;

        if( entry.type == harvest_drop_flesh || entry.type == harvest_drop_offal ) {
            roll /= 1 + ( penalty_small * ( 1 - butch_basic ) );
        }

        if( entry.type == harvest_drop_skin ) {
            roll /= 1 + ( penalty_big * ( 1 - skin_basic ) );
            roll /= 1 + ( penalty_small * ( 1 - skin_adv ) );
        }

        // QUICK BUTCHERY
        if( action == butcher_type::QUICK ) {
            if( entry.type == harvest_drop_flesh ) {
                roll /= 4;
            } else if( entry.type == harvest_drop_bone ) { // NOLINT(bugprone-branch-clone)
                roll /= 2;
            } else if( mt.size >= creature_size::medium &&
                       entry.type == harvest_drop_skin ) {
                roll /= 2;
            } else if( entry.type == harvest_drop_offal ) {
                roll /= 5;
            } else {
                continue;
            }
        }
        // RIP AND TEAR
        if( action == butcher_type::DISMEMBER ) {
            roll = 0;
        }
        // field dressing ignores skin, flesh, and blood
        if( action == butcher_type::FIELD_DRESS ) {
            if( entry.type == harvest_drop_bone ) {
                roll = rng( 0, roll / 2 );
            }
            if( entry.type == harvest_drop_flesh ) {
                continue;
            }
            if( entry.type == harvest_drop_skin ) {
                continue;
            }
        }

        // you only get the blood from bleeding
        if( action == butcher_type::BLEED ) {
            if( entry.type != harvest_drop_blood ) {
                continue;
            }
        }

        // you only get the skin from skinning
        if( action == butcher_type::SKIN ) {
            if( entry.type != harvest_drop_skin ) {
                continue;
            }
            if( corpse_item.has_flag( flag_FIELD_DRESS_FAILED ) ) {
                roll = rng( 0, roll );
            }
        }

        // field dressing removed innards and bones from meatless limbs
        if( ( action == butcher_type::FULL || action == butcher_type::QUICK ) &&
            corpse_item.has_flag( flag_FIELD_DRESS ) ) {
            if( entry.type == harvest_drop_offal ) {
                continue;
            }
            if( entry.type == harvest_drop_bone ) {
                roll = ( roll / 2 ) + rng( roll / 2, roll );
            }
        }
        // unskillfull field dressing may damage the skin, meat, and other parts
        if( ( action == butcher_type::FULL || action == butcher_type::QUICK ) &&
            corpse_item.has_flag( flag_FIELD_DRESS_FAILED ) ) {
            if( entry.type == harvest_drop_offal ) {
                continue;
            }
            if( entry.type == harvest_drop_bone ) {
                roll = ( roll / 2 ) + rng( roll / 2, roll );
            }
            if( entry.type == harvest_drop_flesh || entry.type == harvest_drop_skin ) {
                roll = rng( 0, roll );
            }
        }
        if( corpse_item.has_flag( flag_QUARTERED ) ) {
            roll /= 4;
        }

        if( drop != nullptr ) {
            // divide total dropped weight by drop's weight to get amount
            if( entry.mass_ratio != 0.00f ) {
                // apply skill before converting to items, but only if mass_ratio is defined
                roll *= butchery_dissect_yield_mult( skill_level, you.get_dex(), tool_quality );
                monster_weight_remaining -= roll;
                // use milligrams to avoid truncation for sub-gram items
                roll = std::ceil( static_cast<double>( roll ) * 1000.0 /
                                  to_milligram( drop->weight ) );
            } else {
                monster_weight_remaining -= roll * to_gram( drop->weight );
            }

            const translation msg = action == butcher_type::FIELD_DRESS ?
                                    entry.type->field_dress_msg( roll > 0 ) :
                                    action == butcher_type::QUICK || action == butcher_type::FULL ||
                                    action == butcher_type::DISMEMBER ? entry.type->butcher_msg( roll > 0 ) : translation();
            if( !msg.empty() ) {
                you.add_msg_if_player( m_bad, msg.translated() );
            }

            if( roll <= 0 ) {
                you.add_msg_if_player( m_bad, _( "You fail to harvest: %s" ), drop->nname( 1 ) );
                continue;
            }
            if( drop->phase == phase_id::LIQUID ) {
                item obj( drop, calendar::turn, roll );
                if( obj.has_temperature() ) {
                    obj.set_item_temperature( corpse_item.temperature );
                    if( obj.goes_bad() ) {
                        obj.set_rot( corpse_item.get_rot() );
                    }
                }
                for( const flag_id &flg : entry.flags ) {
                    obj.set_flag( flg );
                }
                for( const fault_id &flt : entry.faults ) {
                    obj.remove_fault( flt );
                }

                // If we're not bleeding the animal we don't care about the blood being wasted
                if( action != butcher_type::BLEED ) {
                    if( !corpse_item.has_flag( flag_BLED ) ) {
                        products.push_back( { std::move( obj ), corpse_loc } );
                    }
                } else {
                    products.push_back( { std::move( obj ), corpse_loc, true } );
                }
            } else if( drop->count_by_charges() ) {
                std::vector<item> objs = create_charge_items( drop, roll, entry, &corpse_item, you );
                for( item &obj : objs ) {
                    products.push_back( { obj, corpse_loc } );
                }
            } else {
                item obj( drop, calendar::turn );
                obj.set_mtype( &mt );
                if( obj.has_temperature() ) {
                    obj.set_item_temperature( corpse_item.temperature );
                    if( obj.goes_bad() ) {
                        obj.set_rot( corpse_item.get_rot() );
                    }
                }
                for( const flag_id &flg : entry.flags ) {
                    obj.set_flag( flg );
                }
                for( const fault_id &flt : entry.faults ) {
                    obj.remove_fault( flt );
                }
                if( !you.backlog.empty() && you.backlog.front().id() == ACT_MULTIPLE_BUTCHER ) {
                    activity_handlers::mark_activity_item( obj, you );
                }
                for( int i = 0; i != roll; ++i ) {
                    products.push_back( { obj, corpse_loc } );
                }
            }
            if( drop->phase != phase_id::LIQUID || action == butcher_type::BLEED ) {
                you.add_msg_if_player( m_good, _( "You harvest: %s" ), drop->nname( roll ) );
            }
        }
        practice++;
    }
    // 20% of the original corpse weight is not an item, but liquid gore
    monster_weight_remaining -= monster_weight / 5;
    // add the remaining unusable weight as rotting garbage
    if( monster_weight_remaining > 0 && action != butcher_type::BLEED ) {
        if( action == butcher_type::FIELD_DRESS ) {
            // 25% of the corpse weight is what's removed during field dressing
            monster_weight_remaining -= monster_weight * 3 / 4;
        } else if( action == butcher_type::SKIN ) {
            monster_weight_remaining -= monster_weight * 0.85;
        } else {
            // a carcass is 75% of the weight of the unmodified creature's weight
            if( ( corpse_item.has_flag( flag_FIELD_DRESS ) ||
                  corpse_item.has_flag( flag_FIELD_DRESS_FAILED ) ) &&
                !corpse_item.has_flag( flag_QUARTERED ) ) {
                monster_weight_remaining -= monster_weight / 4;
            } else if( corpse_item.has_flag( flag_QUARTERED ) ) {
                monster_weight_remaining -= ( monster_weight - ( monster_weight * 3 / 4 / 4 ) );
            }
            if( corpse_item.has_flag( flag_SKINNED ) ) {
                monster_weight_remaining -= monster_weight * 0.15;
            }
        }
        const itype_id &leftover_id = mt.harvest->leftovers;
        const int item_charges = monster_weight_remaining / to_gram( item::find_type(
                                     leftover_id )->weight );
        if( item_charges > 0 ) {
            item ruined_parts( leftover_id, calendar::turn );
            ruined_parts.set_mtype( &mt );
            ruined_parts.set_item_temperature( corpse_item.temperature );
            ruined_parts.set_rot( corpse_item.get_rot() );
            if( !you.backlog.empty() && you.backlog.front().id() == ACT_MULTIPLE_BUTCHER ) {
                activity_handlers::mark_activity_item( ruined_parts, you );
            }
            for( int i = 0; i < item_charges; ++i ) {
                products.push_back( { ruined_parts, corpse_loc } );
            }
        }
    }

    if( action == butcher_type::DISSECT ) {
        you.practice( skill_firstaid, std::max( 0, practice ), mt.size + std::min( tool_quality, 3 ) + 2 );
        if( !continuing() ) {
            return std::nullopt;
        }
        mt.families.practice_dissect( you );
        if( !continuing() ) {
            return std::nullopt;
        }
        if( is_human_autopsy_corpse( mt ) ) {
            // Dissecting a zombie used to trigger feelings of guilt, but that has since
            // been removed. To prevent any unforeseen issues, 15% of the training—based
            // on the fact that their physiological structure remains somewhat similar—
            // has been retained for the time being.
            if( you.has_proficiency( proficiency_prof_physiology ) ) {
                if( mt.in_species( species_ZOMBIE ) ) {
                    you.practice_proficiency( proficiency_prof_dissect_humans, moves_total * 0.15 );
                    if( !continuing() ) {
                        return std::nullopt;
                    }
                } else {
                    you.practice_proficiency( proficiency_prof_dissect_humans, moves_total );
                    if( !continuing() ) {
                        return std::nullopt;
                    }
                }
            } else {
                you.practice_proficiency( proficiency_prof_physiology, moves_total * 0.15 );
                if( !continuing() ) {
                    return std::nullopt;
                }
            }
        }
    } else {
        you.practice( skill_survival, std::max( 0, practice ), std::max( mt.size - creature_size::medium,
                      0 ) + 4 );
        if( !continuing() ) {
            return std::nullopt;
        }
    }

    // handle our prof training
    if( action == butcher_type::FULL && ( mt.harvest->has_entry_type( harvest_drop_flesh ) ||
                                          mt.harvest->has_entry_type( harvest_drop_offal ) ) ) {
        // 40% of butchering and gutting, 40% of skinning, 20% another activities
        if( you.has_proficiency( proficiency_prof_butchering_basic ) ) {
            you.practice_proficiency( proficiency_prof_butchering_adv, moves_total * 0.4 );
            if( !continuing() ) {
                return std::nullopt;
            }
        } else {
            you.practice_proficiency( proficiency_prof_butchering_basic, moves_total * 0.4 );
            if( !continuing() ) {
                return std::nullopt;
            }
        }
    }

    if( action == butcher_type::FULL && mt.harvest->has_entry_type( harvest_drop_skin ) ) {
        // 40% of butchering and gutting, 40% of skinning, 20% another activities
        if( you.has_proficiency( proficiency_prof_skinning_basic ) ) {
            you.practice_proficiency( proficiency_prof_skinning_adv, moves_total * 0.4 );
            if( !continuing() ) {
                return std::nullopt;
            }
        } else {
            you.practice_proficiency( proficiency_prof_skinning_basic, moves_total * 0.4 );
            if( !continuing() ) {
                return std::nullopt;
            }
        }
    }

    if( action == butcher_type::QUICK && ( mt.harvest->has_entry_type( harvest_drop_flesh ) ||
                                           mt.harvest->has_entry_type( harvest_drop_offal ) ) ) {
        // 70% of butchery, 15% skinning, 15% another activities
        if( you.has_proficiency( proficiency_prof_butchering_basic ) ) {
            you.practice_proficiency( proficiency_prof_butchering_adv, moves_total * 0.7 );
            if( !continuing() ) {
                return std::nullopt;
            }
        } else {
            you.practice_proficiency( proficiency_prof_butchering_basic, moves_total * 0.7 );
            if( !continuing() ) {
                return std::nullopt;
            }
        }
    }

    if( action == butcher_type::QUICK && mt.harvest->has_entry_type( harvest_drop_skin ) ) {
        // 70% of butchery, 15% skinning, 15% another activities
        if( you.has_proficiency( proficiency_prof_skinning_basic ) ) {
            you.practice_proficiency( proficiency_prof_skinning_adv, moves_total * 0.15 );
            if( !continuing() ) {
                return std::nullopt;
            }
        } else {
            you.practice_proficiency( proficiency_prof_skinning_basic, moves_total * 0.15 );
            if( !continuing() ) {
                return std::nullopt;
            }
        }
    }

    if( action == butcher_type::FIELD_DRESS && ( mt.harvest->has_entry_type( harvest_drop_flesh ) ||
            mt.harvest->has_entry_type( harvest_drop_offal ) ) ) {
        if( you.has_proficiency( proficiency_prof_butchering_basic ) ) {
            you.practice_proficiency( proficiency_prof_butchering_adv, moves_total );
            if( !continuing() ) {
                return std::nullopt;
            }
        } else {
            you.practice_proficiency( proficiency_prof_butchering_basic, moves_total );
            if( !continuing() ) {
                return std::nullopt;
            }
        }
    }

    if( action == butcher_type::SKIN && mt.harvest->has_entry_type( harvest_drop_skin ) ) {
        // 70% of butchery, 15% skinning, 15% another activities
        if( you.has_proficiency( proficiency_prof_skinning_basic ) ) {
            you.practice_proficiency( proficiency_prof_skinning_adv, moves_total );
            if( !continuing() ) {
                return std::nullopt;
            }
        } else {
            you.practice_proficiency( proficiency_prof_skinning_basic, moves_total );
            if( !continuing() ) {
                return std::nullopt;
            }
        }
    }

    // Training retains its native position before hidden-item discovery.
    // Publication and destination callbacks happen after the complete result is known.
    // reveal hidden items / hidden content
    if( action != butcher_type::FIELD_DRESS && action != butcher_type::SKIN &&
        action != butcher_type::BLEED && action != butcher_type:: DISMEMBER ) {
        for( item *content : corpse_item.all_items_top( pocket_type::CONTAINER ) ) {
            if( ( roll_butchery_dissect( round( you.get_average_skill_level( skill_survival ) ), you.get_dex(),
                                         tool_quality ) + 10 ) * 5 > rng( 0, 100 ) ) {
                //~ %1$s - item name, %2$s - monster name
                you.add_msg_if_player( m_good, _( "You discover a %1$s in the %2$s!" ), content->tname(),
                                       corpse_item.get_mtype()->nname() );
                products.push_back( { *content, you.pos_bub() } );
            } else if( content->is_bionic() ) {
                products.push_back( { item( itype_burnt_out_bionic, calendar::turn ), you.pos_bub() } );
            }
        }
    }

    you.invalidate_crafting_inventory();
    return true;
}

std::vector<item_location> destroy_the_carcass( const butchery_data &bd, Character &you )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const auto generation = you.activity.identity_generation();
    const auto origin = you.pos_abs();
    item_location target = bd.corpse;
    if( !lifetime || !accessible_butchery_corpse( you, target ) ||
        !butcher_action_applicable( you, *target, bd.b_type ) ) {
        return {};
    }
    const item original( *target );
    const item_source source = capture_item_source( you, target );
    const auto corpse_pos = target.pos_bub( here );
    const butcher_type action = bd.b_type;
    const mtype *corpse = original.get_mtype();
    const auto continuing = [&]() {
        return lifetime && context && you.activity.identity_generation() == generation &&
               you.pos_abs() == origin;
    };
    std::vector<butchery_product> products;
    std::optional<bool> result = true;
    if( action == butcher_type::QUARTER ) {
        item quarter( original );
        quarter.set_flag( flag_QUARTERED );
        quarter.set_flag( flag_SKINNED );
        activity_handlers::clear_activity_item( quarter );
        quarter.erase_var( butcher_progress_var( action ) );
        quarter.erase_var( butcher_progress_time_var() );
        for( int i = 0; i < 3; ++i ) {
            products.push_back( { quarter, you.pos_bub() } );
        }
    } else {
        result = collect_butchery_products( bd, you, products );
    }
    // Training/proficiency callbacks retain their native calculation order.
    // If they interrupt preparation, the original corpse is still untouched.
    if( !result || !continuing() || !target || resolve_item_source( you, here, source ) != target ||
        target->count() != original.count() ||
        !target->stacks_with( original, true, false, false, 0, 999, true ) ) {
        return {};
    }
    bool field_dress_success = false;
    if( *result && action == butcher_type::FIELD_DRESS ) {
        field_dress_success = roll_butchery_dissect( round( you.get_average_skill_level( skill_survival ) ),
                              you.get_dex(), you.max_quality( qual_BUTCHER, pickup_range ) ) > 0;
    }
    target->erase_var( butcher_progress_var( action ) );
    target->erase_var( butcher_progress_time_var() );
    bool remove_corpse = !*result;
    if( *result ) {
        switch( action ) {
            case butcher_type::QUARTER:
                target->set_flag( flag_QUARTERED );
                target->set_flag( flag_SKINNED );
                break;
            case butcher_type::FIELD_DRESS:
                target->set_flag( field_dress_success ? flag_FIELD_DRESS : flag_FIELD_DRESS_FAILED );
                break;
            case butcher_type::SKIN:
                target->set_flag( flag_SKINNED );
                break;
            case butcher_type::BLEED:
                target->set_flag( flag_BLED );
                break;
            default:
                remove_corpse = true;
                break;
        }
    }
    struct placed_product {
        item_location location;
        bool direct = false;
    };
    std::vector<item_location> claimed;
    const character_id owner = you.getID();
    const on_out_of_scope retire_claims( [&]() {
        if( !lifetime ) {
            for( item_location &location : claimed ) {
                if( location && activity_handlers::activity_item_owned_by( *location, owner ) ) {
                    activity_handlers::clear_activity_item( *location );
                }
            }
        }
    } );
    std::vector<placed_product> placed;
    std::vector<item_location> blood;
    for( butchery_product &product : products ) {
        item &value = here.add_item_unprocessed( product.position, std::move( product.value ),
                      product.collect_liquid );
        if( value.is_null() ) {
            continue; // Native blacklist, unloaded tile or destructive terrain.
        }
        item_location location( map_cursor( product.position ), &value );
        if( activity_handlers::activity_item_owned_by( *location, owner ) ) {
            claimed.push_back( location );
            you.may_activity_occupancy_after_end_items_loc.push_back( location );
        }
        if( product.collect_liquid ) {
            blood.push_back( location );
        } else {
            placed.push_back( { location, product.direct_placement } );
        }
    }
    if( remove_corpse ) {
        target.remove_item();
    }
    if( !continuing() ) {
        return blood;
    }
    // All results are now real items, and the source is consumed or marked.
    // A drop callback may replace the activity; it cannot replay the harvest.
    for( placed_product &product : placed ) {
        if( !continuing() ) {
            return blood;
        }
        item_location &location = product.location;
        if( !location ) {
            continue;
        }
        if( product.direct ) {
            if( location->has_temperature() && !location->is_corpse() ) {
                location->process( here, nullptr, location.pos_bub( here ) );
            }
        } else {
            item_location destination;
            here.transfer_item_or_charges( location.pos_bub( here ), location, item( *location ), you, 1, true,
                                           &destination );
            if( destination && activity_handlers::activity_item_owned_by( *destination, owner ) ) {
                claimed.push_back( destination );
                if( lifetime ) {
                    you.may_activity_occupancy_after_end_items_loc.push_back( destination );
                }
            }
        }
        if( !continuing() ) {
            return blood;
        }
        if( location && activity_handlers::activity_item_owned_by( *location, you ) ) {
            you.may_activity_occupancy_after_end_items_loc.push_back( location );
        }
    }
    const field_type_id type_blood = corpse->bloodType();
    const field_type_id type_gib = corpse->gibType();
    if( action == butcher_type::DISMEMBER ) {
        here.add_splatter( type_gib, corpse_pos, rng( corpse->size + 2, ( corpse->size + 1 ) * 2 ) );
        if( !continuing() ) {
            return blood;
        }
    }
    if( !*result || action == butcher_type::FIELD_DRESS ) {
        here.add_splatter( type_gib, corpse_pos, rng( corpse->size + 2, ( corpse->size + 1 ) * 2 ) );
        if( !continuing() ) {
            return blood;
        }
        here.add_splatter( type_blood, corpse_pos, rng( corpse->size + 2, ( corpse->size + 1 ) * 2 ) );
        for( int i = 1; continuing() && i <= corpse->size; ++i ) {
            here.add_splatter_trail( type_gib, corpse_pos,
                                     random_entry( here.points_in_radius( corpse_pos, corpse->size + 1 ) ) );
            if( !continuing() ) {
                return blood;
            }
            here.add_splatter_trail( type_blood, corpse_pos,
                                     random_entry( here.points_in_radius( corpse_pos, corpse->size + 1 ) ) );
        }
    }
    if( !continuing() ) {
        return blood;
    }
    if( !*result ) {
        you.add_msg_if_player( m_warning, SNIPPET.random_from_category(
                                   "harvest_drop_default_dissect_failed" ).value_or( translation() ).translated() );
        return blood;
    }
    if( action == butcher_type::QUARTER ) {
        you.add_msg_if_player( m_good,
                               _( "You roughly slice the corpse of %s into four parts and set them aside." ),
                               corpse->nname() );
        return blood;
    }
    const char *message = action == butcher_type::QUICK ? "harvest_drop_default_quick_butcher" :
                          action == butcher_type::FULL ? "harvest_drop_default_full_butcher" :
                          action == butcher_type::FIELD_DRESS ? ( field_dress_success ?
                                  "harvest_drop_default_field_dress_success" : "harvest_drop_default_field_dress_failed" ) :
                          action == butcher_type::SKIN ? "harvest_drop_default_skinning" :
                          action == butcher_type::BLEED ? "harvest_drop_default_bleed" :
                          action == butcher_type::DISMEMBER ? "harvest_drop_default_dismember" :
                          "harvest_drop_default_dissect_success";
    you.add_msg_if_player( action == butcher_type::FIELD_DRESS &&
                           !field_dress_success ? m_warning : m_good,
                           SNIPPET.random_from_category( message ).value_or( translation() ).translated() );
    if( action == butcher_type::DISSECT &&
        ( corpse->id == mtype_id::NULL_ID() || corpse->in_species( species_HUMAN ) ) ) {
        you.record_mental_metric_human_dissection();
    }
    if( continuing() ) {
        you.recoil = MAX_RECOIL;
        get_event_bus().send<event_type::character_butchered_corpse>( you.getID(),
                corpse->id, "ACT_" + io::enum_to_string<butcher_type>( action ) );
    }
    return blood;
}

bool butcher_action_applicable( Character &you, const item &corpse_item,
                                const butcher_type action )
{
    const mtype *corpse = corpse_item.get_mtype();
    if( !corpse || action < butcher_type::BLEED || action >= butcher_type::NUM_TYPES ) {
        return false;
    }
    const bool field_dressed = corpse_item.has_flag( flag_FIELD_DRESS ) ||
                               corpse_item.has_flag( flag_FIELD_DRESS_FAILED );
    const bool quartered = corpse_item.has_flag( flag_QUARTERED );
    switch( action ) {
        case butcher_type::FIELD_DRESS:
            if( field_dressed || quartered || !corpse->harvest->has_entry_type( harvest_drop_offal ) ) {
                return false;
            }
            break;
        case butcher_type::SKIN:
            if( corpse_item.has_flag( flag_SKINNED ) ||
                !corpse->harvest->has_entry_type( harvest_drop_skin ) ) {
                return false;
            }
            break;
        case butcher_type::BLEED:
            if( field_dressed || quartered || corpse_item.has_flag( flag_BLED ) ||
                corpse->bleed_rate <= 0 || !corpse->harvest->has_entry_type( harvest_drop_blood ) ) {
                return false;
            }
            break;
        case butcher_type::QUARTER:
            if( quartered || corpse->size == creature_size::tiny ||
                ( !field_dressed && corpse->harvest->has_entry_type( harvest_drop_offal ) ) ) {
                return false;
            }
            break;
        case butcher_type::DISSECT:
            if( quartered || corpse_item.has_flag( flag_FIELD_DRESS_FAILED ) ) {
                return false;
            }
            break;
        case butcher_type::DISMEMBER:
            return true;
        default:
            break;
    }
    for( int i = 0; i < static_cast<int>( butcher_type::NUM_TYPES ); ++i ) {
        const butcher_type other = static_cast<butcher_type>( i );
        if( butcher_get_progress( corpse_item, other ) > 0 &&
            butcher_time_to_cut( you, corpse_item, other ) <
            butcher_time_to_cut( you, corpse_item, action ) ) {
            return false;
        }
    }
    return true;
}

// Butchery sub-menu and time calculation
std::optional<butcher_type> butcher_submenu( const std::vector<map_stack::iterator> &corpses,
        int index )
{
    avatar &player_character = get_avatar();
    constexpr int num_butcher_types = static_cast<int>( butcher_type::NUM_TYPES );

    std::array<time_duration, num_butcher_types> cut_times;
    std::array<int, num_butcher_types> eligible_counts = {};
    for( int bt_i = 0; bt_i < num_butcher_types; bt_i++ ) {
        const butcher_type bt = static_cast<butcher_type>( bt_i );
        int time_to_cut = 0;
        for( std::size_t i = 0; i < corpses.size(); ++i ) {
            if( index != -1 && i != static_cast<std::size_t>( index ) ) {
                continue;
            }
            const map_stack::iterator &it = corpses[i];
            if( butcher_action_applicable( player_character, *it, bt ) ) {
                ++eligible_counts[bt_i];
                const mtype &corpse = *it->get_mtype();
                const float factor = corpse.harvest->get_butchery_requirements().get_fastest_requirements(
                                         &player_character, player_character.crafting_inventory(),
                                         corpse.size, bt ).first;
                time_to_cut += butcher_time_to_cut( player_character, *it, bt ) * factor *
                               ( 1.0 - butcher_get_progress( *it, bt ) );
            }
        }
        cut_times[bt_i] = time_duration::from_moves( time_to_cut );
    }
    auto cut_time = [&]( butcher_type bt ) {
        const int bt_i = static_cast<int>( bt );
        const std::string duration = to_string_clipped( cut_times[bt_i] );
        if( index != -1 ) {
            return duration;
        }
        return string_format( n_gettext( "%d corpse, %s", "%d corpses, %s", eligible_counts[bt_i] ),
                              eligible_counts[bt_i], duration );
    };
    auto progress_str = [&]( butcher_type bt ) {
        std::string result;
        if( index != -1 ) {
            const double progress = butcher_get_progress( *corpses[index], bt );
            if( progress > 0 ) {
                result = string_format( _( "%d%% complete" ), static_cast<int>( 100 * progress ) );
            }
        } else {
            for( const map_stack::iterator &it : corpses ) {
                const double progress = butcher_get_progress( *it, bt );
                if( progress > 0 && butcher_action_applicable( player_character, *it, bt ) ) {
                    result = _( "partially complete" );
                }
            }
        }
        return result.empty() ? "" : ( " " + colorize( result, c_dark_gray ) );
    };
    const bool enough_light = player_character.fine_detail_vision_mod() <= 4;

    const int factor = player_character.max_quality( qual_BUTCHER, pickup_range );
    const std::string msgFactor = factor > INT_MIN
                                  ? string_format( _( "Your best tool has <color_cyan>%d butchering</color>." ), factor )
                                  :  _( "You have no butchering tool." );

    const int factorD = player_character.max_quality( qual_CUT_FINE, pickup_range );
    const std::string msgFactorD = factorD > INT_MIN
                                   ? string_format( _( "Your best tool has <color_cyan>%d fine cutting</color>." ), factorD )
                                   :  _( "You have no fine cutting tool." );

    std::string dissect_wp_hint; // dissection weakpoint proficiencies training hint

    if( index != -1 ) {
        const mtype *dead_mon = corpses[index]->get_mtype();
        if( dead_mon ) {
            if( !dead_mon->families.families.empty() ) {
                dissect_wp_hint += std::string( "\n\n" ) + _( "Dissecting may yield knowledge of:" );
                for( const weakpoint_family &wf : dead_mon->families.families ) {
                    std::string prof_status;
                    if( !player_character.has_prof_prereqs( wf.proficiency ) ) {
                        prof_status += colorize( string_format( " (%s)", _( "missing proficiencies" ) ), c_red );
                    } else if( player_character.has_proficiency( wf.proficiency ) ) {
                        prof_status += colorize( string_format( " (%s)", _( "already known" ) ), c_dark_gray );
                    }
                    dissect_wp_hint += string_format( "\n  %s%s", wf.proficiency->name(), prof_status );
                }
            }
        }
    }

    auto is_enabled = [&]( butcher_type bt ) {
        return eligible_counts[static_cast<int>( bt )] > 0 &&
               ( bt == butcher_type::DISMEMBER || enough_light );
    };

    const std::string cannot_see = colorize( _( "can't see!" ), c_red );
    auto time_or_disabledreason = [&]( butcher_type bt ) {
        if( bt == butcher_type::DISMEMBER ) {
            return cut_time( bt );
        } else if( !enough_light ) {
            return cannot_see;
        } else if( eligible_counts[static_cast<int>( bt )] == 0 ) {
            return colorize( _( "no eligible corpses" ), c_red );
        }
        return cut_time( bt );
    };

    uilist smenu;
    smenu.desc_enabled = true;
    smenu.title = _( "Choose type of butchery:" );

    smenu.addentry_col( static_cast<int>( butcher_type::QUICK ), is_enabled( butcher_type::QUICK ),
                        'B', _( "Quick butchery" )
                        + progress_str( butcher_type::QUICK ),
                        time_or_disabledreason( butcher_type::QUICK ),
                        wrap60( string_format( "%s  %s",
                                _( "This technique is used when you are in a hurry, "
                                   "but still want to harvest something from the corpse. "
                                   " Yields are lower as you don't try to be precise, "
                                   "but it's useful if you don't want to set up a workshop.  "
                                   "Prevents zombies from raising." ),
                                msgFactor ) ) );
    smenu.addentry_col( static_cast<int>( butcher_type::FULL ),
                        is_enabled( butcher_type::FULL ),
                        'b', _( "Full butchery" )
                        + progress_str( butcher_type::FULL ),
                        time_or_disabledreason( butcher_type::FULL ),
                        wrap60( string_format( "%s  %s",
                                _( "This technique is used to properly butcher a corpse, "
                                   "and requires a rope & a tree or a butchering rack, "
                                   "a flat surface (for ex. a table, a leather tarp, etc.) "
                                   "and good tools.  Yields are plentiful and varied, "
                                   "but it is time consuming." ),
                                msgFactor ) ) );
    smenu.addentry_col( static_cast<int>( butcher_type::FIELD_DRESS ),
                        is_enabled( butcher_type::FIELD_DRESS ),
                        'f', _( "Field dress corpse" )
                        + progress_str( butcher_type::FIELD_DRESS ),
                        time_or_disabledreason( butcher_type::FIELD_DRESS ),
                        wrap60( string_format( "%s  %s",
                                _( "Technique that involves removing internal organs and "
                                   "viscera to protect the corpse from rotting from inside.  "
                                   "Yields internal organs.  Carcass will be lighter and will "
                                   "stay fresh longer.  Can be combined with other methods for "
                                   "better effects." ),
                                msgFactor ) ) );
    smenu.addentry_col( static_cast<int>( butcher_type::SKIN ),
                        is_enabled( butcher_type::SKIN ),
                        's', _( "Skin corpse" )
                        + progress_str( butcher_type::SKIN ),
                        time_or_disabledreason( butcher_type::SKIN ),
                        wrap60( string_format( "%s  %s",
                                _( "Skinning a corpse is an involved and careful process that "
                                   "usually takes some time.  You need skill and an appropriately "
                                   "sharp and precise knife to do a good job.  Some corpses are "
                                   "too small to yield a full-sized hide and will instead produce "
                                   "scraps that can be used in other ways." ),
                                msgFactor ) ) );
    smenu.addentry_col( static_cast<int>( butcher_type::BLEED ),
                        is_enabled( butcher_type::BLEED ),
                        'e', _( "Bleed corpse" )
                        + progress_str( butcher_type::BLEED ),
                        time_or_disabledreason( butcher_type::BLEED ),
                        wrap60( string_format( "%s  %s",
                                _( "Bleeding involves severing the carotid arteries and jugular "
                                   "veins, or the blood vessels from which they arise.  "
                                   "You need skill and an appropriately sharp and precise knife "
                                   "to do a good job." ),
                                msgFactor ) ) );
    smenu.addentry_col( static_cast<int>( butcher_type::QUARTER ),
                        is_enabled( butcher_type::QUARTER ),
                        'q', _( "Quarter corpse" )
                        + progress_str( butcher_type::QUARTER ),
                        time_or_disabledreason( butcher_type::QUARTER ),
                        wrap60( string_format( "%s  %s",
                                _( "By quartering a previously field dressed corpse you will "
                                   "acquire four parts with reduced weight and volume.  It "
                                   "may help in transporting large game.  This action destroys "
                                   "skin, hide, pelt, etc., so don't use it if you want to "
                                   "harvest them later." ),
                                msgFactor ) ) );
    smenu.addentry_col( static_cast<int>( butcher_type::DISMEMBER ),
                        is_enabled( butcher_type::DISMEMBER ),
                        'm', _( "Dismember corpse" )
                        + progress_str( butcher_type::DISMEMBER ),
                        time_or_disabledreason( butcher_type::DISMEMBER ),
                        wrap60( string_format( "%s  %s",
                                _( "If you're aiming to just destroy a body outright and don't "
                                   "care about harvesting it, dismembering it will hack it apart "
                                   "in a very short amount of time but yields little to no usable flesh." ),
                                msgFactor ) ) );
    smenu.addentry_col( static_cast<int>( butcher_type::DISSECT ),
                        is_enabled( butcher_type::DISSECT ),
                        'd', _( "Dissect corpse" )
                        + progress_str( butcher_type::DISSECT ),
                        time_or_disabledreason( butcher_type::DISSECT ),
                        wrap60( string_format( "%s  %s%s",
                                _( "By careful dissection of the corpse, you will examine it for "
                                   "possible bionic implants, or discrete organs and harvest them "
                                   "if possible.  Requires scalpel-grade cutting tools, ruins "
                                   "corpse, and consumes a lot of time.  Your medical knowledge "
                                   "is most useful here." ),
                                msgFactorD, dissect_wp_hint ) ) );
    smenu.query();
    switch( smenu.ret ) {
        case static_cast<int>( butcher_type::QUICK ):
            return butcher_type::QUICK;
            break;
        case static_cast<int>( butcher_type::FULL ):
            return butcher_type::FULL;
            break;
        case static_cast<int>( butcher_type::FIELD_DRESS ):
            return butcher_type::FIELD_DRESS;
            break;
        case static_cast<int>( butcher_type::SKIN ):
            return butcher_type::SKIN;
            break;
        case static_cast<int>( butcher_type::BLEED ) :
            return butcher_type::BLEED;
            break;
        case static_cast<int>( butcher_type::QUARTER ):
            return butcher_type::QUARTER;
            break;
        case static_cast<int>( butcher_type::DISMEMBER ):
            return butcher_type::DISMEMBER;
            break;
        case static_cast<int>( butcher_type::DISSECT ):
            return butcher_type::DISSECT;
            break;
        default:
            return std::nullopt;
    }
}
