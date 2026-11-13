#include "character_action_guard.h"
#include "arc_furnace.h"
#include "stook.h"
#include "autoclave.h"
#include "mill.h"
#include "charcoal_kiln.h"
#include "smoking_rack.h"
#include "fermentation_vessel.h"
#include "safe_reference.h"
#include "vertical_movement.h"
#include "deployed_furniture.h"
#include "iexamine.h"

#include "activity_handlers.h"

#include <ret_val.h>
#include <type_id.h>
#include <algorithm>
#include <array>
#include <climits>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <functional>
#include <iterator>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <utility>

#include "activity_actor_definitions.h"
#include "ammo.h"
#include "avatar.h"
#include "basecamp.h"
#include "bionics.h"
#include "bionic_activation.h"
#include "mp_inventory_activity.h"
#include "mp_client_conn.h"
#include "item_source.h"
#include "item_consumption.h"
#include "item_unload.h"
#include "farming.h"
#include "fireplace.h"
#include "furniture_reload.h"
#include "keg.h"
#include "safecracking.h"
#include "craft_reservation.h"
#include "bodypart.h"
#include "cached_options.h"
#include "calendar.h"
#include "cata_utility.h"
#include "character.h"
#include "color.h"
#include "condition.h"
#include "construction.h"
#include "coordinates.h"
#include "craft_command.h"
#include "crafting.h"
#include "crafting_enums.h"
#include "creature.h"
#include "creature_tracker.h"
#include "damage.h"
#include "cursesdef.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "effect.h"
#include "effect_on_condition.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "faction.h"
#include "field_type.h"
#include "finite_water.h"
#include "flag.h"
#include "flat_set.h" // IWYU pragma: keep
#include "fungal_effects.h"
#include "game.h"
#include "game_constants.h"
#include "game_inventory.h"
#include "handle_liquid.h"
#include "harvest.h"
#include "liquid_transfer.h"
#include "input_context.h"
#include "input_enums.h"
#include "input_popup.h"
#include "inventory.h"
#include "item.h"
#include "item_components.h"
#include "item_location.h"
#include "itype.h"
#include "tool_activity_target.h"
#include "terrain_examine.h"
#include "iuse.h"
#include "iuse_actor.h"
#include "lua_platform_hooks.h"
#include "lua_platform_runtime.h"
#include "magic_teleporter_list.h"
#include "map.h"
#include "map_iterator.h"
#include "map_scale_constants.h"
#include "map_selector.h"
#include "mapdata.h"
#include "memory_fast.h"
#include "messages.h"
#include "mission_companion.h"
#include "mtype.h"
#include "mutation.h"
#include "npc.h"
#include "npc_class.h"
#include "omdata.h"
#include "options.h"
#include "output.h"
#include "overmap.h"
#include "overmap_ui.h"
#include "overmapbuffer.h"
#include "pimpl.h"
#include "player_activity.h"
#include "point.h"
#include "recipe.h"
#include "requirements.h"
#include "rng.h"
#include "sounds.h"
#include "string_formatter.h"
#include "talker.h"  // IWYU pragma: keep
#include "temp_crafting_inventory.h"
#include "tileray.h"
#include "timed_event.h"
#include "translation.h"
#include "translations.h"
#include "trap.h"
#include "try_parse_integer.h"
#include "ui_manager.h"
#include "uilist.h"
#include "uistate.h"
#include "units.h"
#include "units_utility.h"
#include "value_ptr.h"
#include "vehicle.h"
#include "vehicle_selector.h"
#include "visitable.h"
#include "vpart_position.h"
#include "vpart_range.h"
#include "weather.h"
#include "weather_type.h"

static const activity_id ACT_HARVEST( "ACT_HARVEST" );
static const activity_id ACT_OPERATION( "ACT_OPERATION" );


static const bionic_id bio_lighter( "bio_lighter" );
static const bionic_id bio_lockpick( "bio_lockpick" );
static const bionic_id bio_painkiller( "bio_painkiller" );

static const character_modifier_id character_modifier_obstacle_climb_mod( "obstacle_climb_mod" );

static const climbing_aid_id climbing_aid_furn_CLIMBABLE( "furn_CLIMBABLE" );

static const damage_type_id damage_bash( "bash" );

static const efftype_id effect_antibiotic( "antibiotic" );
static const efftype_id effect_bite( "bite" );
static const efftype_id effect_bleed( "bleed" );
static const efftype_id effect_bouldering( "bouldering" );
static const efftype_id effect_disinfected( "disinfected" );
static const efftype_id effect_gliding( "gliding" );
static const efftype_id effect_incorporeal( "incorporeal" );
static const efftype_id effect_infected( "infected" );
static const efftype_id effect_mending( "mending" );
static const efftype_id effect_pblue( "pblue" );
static const efftype_id effect_sleep( "sleep" );
static const efftype_id effect_slow_descent( "slow_descent" );
static const efftype_id effect_strong_antibiotic( "strong_antibiotic" );
static const efftype_id effect_strong_antibiotic_visible( "strong_antibiotic_visible" );
static const efftype_id effect_tetanus( "tetanus" );
static const efftype_id effect_weak_antibiotic( "weak_antibiotic" );

static const faction_id faction_robofac( "robofac" );

static const furn_str_id furn_f_arcfurnace_empty( "f_arcfurnace_empty" );
static const furn_str_id furn_f_arcfurnace_full( "f_arcfurnace_full" );
static const furn_str_id furn_f_diesel_tank( "f_diesel_tank" );
static const furn_str_id furn_f_flower_fungal( "f_flower_fungal" );
static const furn_str_id furn_f_flower_marloss( "f_flower_marloss" );
static const furn_str_id furn_f_gas_tank( "f_gas_tank" );

static const itype_id itype_arm_splint( "arm_splint" );
static const itype_id itype_bot_broken_cyborg( "bot_broken_cyborg" );
static const itype_id itype_bot_prototype_cyborg( "bot_prototype_cyborg" );
static const itype_id itype_cash_card( "cash_card" );
static const itype_id itype_charcoal( "charcoal" );
static const itype_id itype_chem_carbide( "chem_carbide" );
static const itype_id itype_corpse( "corpse" );
static const itype_id itype_disassembly( "disassembly" );
static const itype_id itype_fire( "fire" );
static const itype_id itype_foodperson_mask( "foodperson_mask" );
static const itype_id itype_foodperson_mask_on( "foodperson_mask_on" );
static const itype_id itype_fungal_seeds( "fungal_seeds" );
static const itype_id itype_id_science( "id_science" );
static const itype_id itype_iso_material_disc_ammo( "iso_material_disc_ammo" );
static const itype_id itype_iso_material_disc_basic( "iso_material_disc_basic" );
static const itype_id itype_iso_material_disc_quality( "iso_material_disc_quality" );
static const itype_id itype_leg_splint( "leg_splint" );
static const itype_id itype_maple_sap( "maple_sap" );
static const itype_id itype_marloss_seed( "marloss_seed" );
static const itype_id itype_nanomaterial( "nanomaterial" );
static const itype_id itype_nectar( "nectar" );
static const itype_id itype_petrified_eye( "petrified_eye" );
static const itype_id itype_unfinished_cac2( "unfinished_cac2" );
static const itype_id itype_water( "water" );
static const itype_id itype_water_clean( "water_clean" );

static const json_character_flag json_flag_GLIDE( "GLIDE" );
static const json_character_flag json_flag_LEVITATION( "LEVITATION" );
static const json_character_flag json_flag_PAIN_IMMUNE( "PAIN_IMMUNE" );
static const json_character_flag
json_flag_TEMPORARY_SHAPESHIFT_NO_HANDS( "TEMPORARY_SHAPESHIFT_NO_HANDS" );
static const json_character_flag json_flag_WING_ARMS( "WING_ARMS" );
static const json_character_flag json_flag_WING_GLIDE( "WING_GLIDE" );

static const material_id material_cac2powder( "cac2powder" );
static const material_id material_ch_steel( "ch_steel" );
static const material_id material_hc_steel( "hc_steel" );
static const material_id material_iron( "iron" );
static const material_id material_lc_steel( "lc_steel" );
static const material_id material_mc_steel( "mc_steel" );
static const material_id material_qt_steel( "qt_steel" );
static const material_id material_steel( "steel" );

static const mtype_id mon_broken_cyborg( "mon_broken_cyborg" );
static const mtype_id mon_dark_wyrm( "mon_dark_wyrm" );
static const mtype_id mon_fungal_blossom( "mon_fungal_blossom" );
static const mtype_id mon_prototype_cyborg( "mon_prototype_cyborg" );

static const mutation_category_id mutation_category_CHIMERA( "CHIMERA" );

static const npc_class_id NC_BALTHAZAR_INTERCOM( "NC_BALTHAZAR_INTERCOM" );
static const npc_class_id NC_ROBOFAC_INTERCOM( "NC_ROBOFAC_INTERCOM" );

static const proficiency_id proficiency_prof_disarming( "prof_disarming" );
static const proficiency_id proficiency_prof_parkour( "prof_parkour" );
static const proficiency_id proficiency_prof_traps( "prof_traps" );
static const proficiency_id proficiency_prof_trapsetting( "prof_trapsetting" );

static const quality_id qual_ANESTHESIA( "ANESTHESIA" );
static const quality_id qual_DIG( "DIG" );
static const quality_id qual_DRILL( "DRILL" );
static const quality_id qual_GRASS_CUT( "GRASS_CUT" );
static const quality_id qual_HACK( "HACK" );
static const quality_id qual_HAMMER( "HAMMER" );
static const quality_id qual_LOCKPICK( "LOCKPICK" );
static const quality_id qual_PRY( "PRY" );
static const quality_id qual_TREE_TAP( "TREE_TAP" );

static const requirement_id requirement_data_anesthetic( "anesthetic" );
static const requirement_id requirement_data_cvd_diamond( "cvd_diamond" );
static const requirement_id requirement_data_superalloy_forge( "superalloy_forge" );

static const skill_id skill_chemistry( "chemistry" );
static const skill_id skill_cooking( "cooking" );
static const skill_id skill_fabrication( "fabrication" );
static const skill_id skill_survival( "survival" );
static const skill_id skill_traps( "traps" );

static const ter_str_id ter_t_card_reader_broken( "t_card_reader_broken" );
static const ter_str_id ter_t_diesel_pump( "t_diesel_pump" );
static const ter_str_id ter_t_diesel_pump_a( "t_diesel_pump_a" );
static const ter_str_id ter_t_dirt( "t_dirt" );
static const ter_str_id ter_t_door_metal_c( "t_door_metal_c" );
static const ter_str_id ter_t_door_metal_locked( "t_door_metal_locked" );
static const ter_str_id ter_t_door_metal_o( "t_door_metal_o" );
static const ter_str_id ter_t_floor_blue( "t_floor_blue" );
static const ter_str_id ter_t_floor_green( "t_floor_green" );
static const ter_str_id ter_t_floor_red( "t_floor_red" );
static const ter_str_id ter_t_gas_pump( "t_gas_pump" );
static const ter_str_id ter_t_gas_pump_a( "t_gas_pump_a" );
static const ter_str_id ter_t_marloss( "t_marloss" );
static const ter_str_id ter_t_orifice( "t_orifice" );
static const ter_str_id ter_t_rock_blue( "t_rock_blue" );
static const ter_str_id ter_t_rock_floor( "t_rock_floor" );
static const ter_str_id ter_t_rock_green( "t_rock_green" );
static const ter_str_id ter_t_rock_red( "t_rock_red" );
static const ter_str_id ter_t_switch_even( "t_switch_even" );
static const ter_str_id ter_t_switch_gb( "t_switch_gb" );
static const ter_str_id ter_t_switch_rb( "t_switch_rb" );
static const ter_str_id ter_t_switch_rg( "t_switch_rg" );
static const ter_str_id ter_t_tree_maple_tapped( "t_tree_maple_tapped" );

static const trait_id trait_AMORPHOUS( "AMORPHOUS" );
static const trait_id trait_ARACHNID_ARMS_OK( "ARACHNID_ARMS_OK" );
static const trait_id trait_BADKNEES( "BADKNEES" );
static const trait_id trait_BEAK_HUM( "BEAK_HUM" );
static const trait_id trait_BURROW( "BURROW" );
static const trait_id trait_BURROWLARGE( "BURROWLARGE" );
static const trait_id trait_CANNOT_GAIN_PSIONICS( "CANNOT_GAIN_PSIONICS" );
static const trait_id trait_ESPER_ADVANCEMENT_OKAY( "ESPER_ADVANCEMENT_OKAY" );
static const trait_id trait_ESPER_STARTER_ADVANCEMENT_OKAY( "ESPER_STARTER_ADVANCEMENT_OKAY" );
static const trait_id trait_ILLITERATE( "ILLITERATE" );
static const trait_id trait_INSECT_ARMS_OK( "INSECT_ARMS_OK" );
static const trait_id trait_INTERCOM_OPERATOR( "INTERCOM_OPERATOR" );
static const trait_id trait_M_DEFENDER( "M_DEFENDER" );
static const trait_id trait_M_DEPENDENT( "M_DEPENDENT" );
static const trait_id trait_M_FERTILE( "M_FERTILE" );
static const trait_id trait_M_SPORES( "M_SPORES" );
static const trait_id trait_PROBOSCIS( "PROBOSCIS" );
static const trait_id trait_SHELL2( "SHELL2" );
static const trait_id trait_SHELL3( "SHELL3" );
static const trait_id trait_THRESH_MARLOSS( "THRESH_MARLOSS" );
static const trait_id trait_THRESH_MYCUS( "THRESH_MYCUS" );

static const trap_str_id tr_telepad( "tr_telepad" );

// @TODO maybe make this a property of the item (depend on volume/type)

/**
 * Nothing player can interact with here.
 */
void iexamine::none( Character &/*p*/, const tripoint_bub_ms &examp )
{
    add_msg( _( "That is a %s." ), get_map().name( examp ) );
}

bool iexamine::always_false( const tripoint_bub_ms &/*examp*/ )
{
    return false;
}

bool iexamine::false_and_debugmsg( const tripoint_bub_ms &examp )
{
    debugmsg( "Called false_and_debugmsg on %s - was a terrain with an actor configured incorrectly?",
              get_map().tername( examp ) );
    return false;
}

bool iexamine::always_true( const tripoint_bub_ms &/*examp*/ )
{
    return true;
}

bool iexamine::harvestable_now( const tripoint_bub_ms &examp )
{
    const harvest_id hid = get_map().get_harvest( examp );
    return !hid->is_null() && !hid->empty();
}

/**
 * Pick an appropriate item and apply diamond coating if possible.
 */
void iexamine::cvdmachine( Character &you, const tripoint_bub_ms & )
{
    // Select an item to which it is possible to apply a diamond coating
    item_location loc = g->inv_map_splice( []( const item & e ) {
        return e.has_edged_damage() &&
               !e.has_flag( flag_DIAMOND ) && !e.has_flag( flag_NO_CVD ) &&
               ( e.made_of( material_steel ) || e.made_of( material_ch_steel ) ||
                 e.made_of( material_hc_steel ) || e.made_of( material_lc_steel ) ||
                 e.made_of( material_mc_steel ) || e.made_of( material_qt_steel ) ||
                 e.made_of( material_iron ) );
    }, _( "Apply diamond coating" ), 1, _( "You don't have a suitable item to coat with diamond" ) );

    if( !loc ) {
        return;
    }

    // Require materials proportional to selected item volume
    auto qty = loc->volume() / 250_ml;
    qty = std::max( 1, qty );
    requirement_data reqs = *requirement_data_cvd_diamond * qty;

    if( !reqs.can_make_with_inventory( &you, you.crafting_inventory(), is_crafting_component ) ) {
        popup( "%s", reqs.list_missing() );
        return;
    }

    // Consume materials
    for( const auto &e : reqs.get_components() ) {
        you.consume_items( e, 1, is_crafting_component );
    }
    for( const auto &e : reqs.get_tools() ) {
        you.consume_tools( e );
    }
    you.invalidate_crafting_inventory();

    // Apply flag to item
    loc->set_flag( flag_DIAMOND );
    add_msg( m_good, _( "You apply a diamond coating to your %s" ), loc->type_name() );
    you.mod_moves( -to_moves<int>( 10_seconds ) );
}

/**
 * Change player eye and skin color
 */
void iexamine::change_appearance( Character &you, const tripoint_bub_ms & )
{
    uilist amenu;
    amenu.title = _( "Change what?" );
    amenu.addentry( 0, true, MENU_AUTOASSIGN, _( "Change eye color" ) );
    amenu.addentry( 1, true, MENU_AUTOASSIGN, _( "Change skin color" ) );

    amenu.query();
    if( amenu.ret == 0 ) {
        you.customize_appearance( customize_appearance_choice::EYES );
    } else if( amenu.ret == 1 ) {
        you.customize_appearance( customize_appearance_choice::SKIN );
    }
}

void iexamine::iso_recycler( Character &, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    map_cursor cur = map_cursor( examp );
    std::vector<item_location> recyclables;
    units::mass ammo_mass = 0_gram;
    int basic_count = 0;
    int premium_count = 0;
    bool chastize = false;

    cur.visit_items( [&basic_count, &ammo_mass, &premium_count, &chastize, &recyclables,
                  &cur ]( item * it, item * ) {

        if( it->is_ammo() ) {
            const damage_instance &dam = it->ammo_data()->ammo->damage;
            dam.total_damage() > 12 ? ammo_mass += it->weight() * 0.6 : ammo_mass += it->weight() * 0.05;
            recyclables.emplace_back( cur, it );
        } else if( it->is_gun() || it->is_magazine() ) {
            //Recycling contained ammo
            if( it->has_ammo() ) {
                const item &ammo = it->first_ammo();
                const damage_instance &dam = ammo.ammo_data()->ammo->damage;
                dam.total_damage() > 12 ? ammo_mass += ammo.weight() * 0.6 : ammo_mass += ammo.weight() * 0.05;

            }
            //Recycling the gun
            if( !it->ammo_default().is_null() ) {
                const damage_instance &damd = it->ammo_default()->ammo->damage;
                if( damd.total_damage() > 30 ) {
                    premium_count++;
                    recyclables.emplace_back( cur, it );

                } else if( damd.total_damage() > 5 ) {
                    basic_count++;
                    recyclables.emplace_back( cur, it );

                }
            } else {
                chastize = true;
            }
        } else {
            chastize = true;

        }
        return VisitResponse::NEXT;
    } );

    if( chastize ) {
        add_msg( _( "Non recyclables detected.  Please clasify residues properly." ) );
    }

    for( item_location it : recyclables ) {
        it.remove_item();
    }

    if( premium_count > 0 ) {
        here.spawn_item( examp, itype_iso_material_disc_quality, premium_count, 0, calendar::turn );
    }
    if( basic_count > 0 ) {
        here.spawn_item( examp, itype_iso_material_disc_basic, basic_count, 0, calendar::turn );
    }
    if( ammo_mass / itype_iso_material_disc_ammo->weight > 1 ) {
        here.spawn_item( examp, itype_iso_material_disc_ammo,
                         ammo_mass / itype_iso_material_disc_ammo->weight, 0, calendar::turn );
    }

}


/**
* Remove the current threshold and devolve all post thresh mutations to their pre threshold level, unless the new threshold is compatible.
*/
static void genemill_remove_thresh( Character &you, mutation_category_id highest_id )
{
    int rc = 0;
    for( const trait_id &mut : you.get_mutations( false, true ) ) {
        if( !mut->threshreq.empty() || mut->threshold ) {
            trait_id lastrevert = mut;
            you.remove_mutation( mut );
            do {
                for( const trait_id &c : you.get_mutations( false, true ) ) {
                    if( std::find( c->replacements.begin(), c->replacements.end(),
                                   lastrevert ) != c->replacements.end() && ( !c->threshreq.empty() ||
                                           std::find( c->category.begin(), c->category.end(), highest_id ) != c->category.end() ) ) {
                        lastrevert = c;
                        you.remove_mutation( c );
                    } else {
                        break;
                    }
                }
                rc++;
            } while( rc < 10 );
        }
    }
}

/**
 * GENEMILL: Like a Nanofab, but for your genes.
 * Used in aftershock, and maybe in other mods.
 */
void iexamine::genemill( Character &you, const tripoint_bub_ms & )
{
    uilist genemenu;
    genemenu.title = _( "Select Genetic Treatment" );

    std::vector<trait_id>available_traits;
    std::vector<item_location> genetech;

    for( item_location &loc : you.all_items_loc() ) {
        if( loc->has_flag( flag_GENE_TECH ) ) {
            genetech.push_back( loc );
        }
    }


    if( genetech.empty() ) {
        popup( _( "You aren't carrying any genetic treatments." ) );
        return;
    }
    std::map<int, item_location> item_map;
    int i = 0;
    for( const item_location &it : genetech ) {
        for( trait_id trait : it->template_traits ) {
            item_map[i] = it;
            available_traits.push_back( trait );
            bool can_select = true;
            std::string context_string;

            //if you have the trait we can abort this early since the only thing we can do is remove it
            if( you.has_permanent_trait( trait ) ) {
                context_string = _( "Trait will be reverted to base human morphology." );
                context_string = string_format( "    <color_green>%s</color>", context_string );
                genemenu.addentry_col( i, can_select, input_event(), trait->name(), context_string );
                i++;
                continue;
            }

            const mutation_branch &mut = trait.obj();
            std::vector<trait_id> cancel = mut.cancels;
            std::vector<trait_id> threshreq = mut.threshreq;
            bool c_has_threshreq = threshreq.empty() ? true : false;

            //Bionic Incompatibility
            std::vector<std::string> bionics;
            for( const bionic_id &bid : you.get_bionics() ) {
                if( bid->mutation_conflicts.count( trait ) != 0 ) {
                    bionics.push_back( bid->name.translated() );
                }
            }
            if( !bionics.empty() ) {
                context_string = string_format( "    <color_red>%s %s</color>", _( "Conflicts with installed:" ),
                                                string_join( bionics, ", " ) );
                can_select = false;
                genemenu.addentry_col( i, can_select, input_event(), mut.name(), context_string );
                i++;
                continue;
            }

            //Threshold requirement
            for( const trait_id &c : threshreq ) {
                if( you.has_permanent_trait( c ) ) {
                    c_has_threshreq = true;
                    break;
                }
            }
            if( !c_has_threshreq ) {
                context_string = string_format( "    <color_red>%s ",
                                                _( "Requires any of the following traits:" ) );
                for( size_t i = 0; i < threshreq.size() - 1; i++ ) {
                    context_string += threshreq[i]->name();
                    context_string += ", ";
                }
                context_string += threshreq[threshreq.size() - 1]->name();
                context_string += "</color>";
                can_select = false;
            }

            genemenu.addentry_col( i, can_select, input_event(), mut.name(), context_string );
            i++;
        }
    }

    genemenu.query();

    if( genemenu.ret < 0 ) {
        return;
    }

    //Grant the selected mutation.
    trait_id treatment = available_traits.at( genemenu.ret );
    int rc = 0;
    if( you.has_permanent_trait( treatment ) ) {
        trait_id lastrevert = treatment;
        you.remove_mutation( treatment );
        do {
            for( const trait_id &c : you.get_mutations( false, true ) ) {
                if( std::find( c->replacements.begin(), c->replacements.end(),
                               lastrevert ) != c->replacements.end() ) {
                    lastrevert = c;
                    you.remove_mutation( c );
                }
            }
            rc++;
        } while( rc < 10 );

    } else {
        do {
            you.mutate_towards( treatment );
            rc++;
        } while( !you.has_permanent_trait( treatment ) && rc < 10 );
    }

    // Remove esper potential
    if( you.has_permanent_trait( trait_ESPER_ADVANCEMENT_OKAY ) ) {
        you.remove_mutation( trait_ESPER_ADVANCEMENT_OKAY );
    }
    if( you.has_permanent_trait( trait_ESPER_STARTER_ADVANCEMENT_OKAY ) ) {
        you.remove_mutation( trait_ESPER_STARTER_ADVANCEMENT_OKAY );
    }

    // Add a trait to prevent later esper enkindling
    you.set_mutation( trait_CANNOT_GAIN_PSIONICS );

    //Handle Thesholds changing/removal.
    auto highest_id = std::max_element( you.mutation_category_level.begin(),
                                        you.mutation_category_level.end(),
                                        []( const std::pair<mutation_category_id, int> &p1,
    const std::pair<mutation_category_id, int> &p2 ) {
        return p1.second < p2.second;
    } );
    const mutation_category_trait &highest_mct = mutation_category_trait::get_category(
                highest_id->first );

    //Since chimera grants access to most post thresh traits with little inconvenience, we prevent the player from getting it through genemill.
    if( highest_id->first != mutation_category_CHIMERA &&
        you.get_threshold_category() != mutation_category_CHIMERA ) {
        if( highest_id->second > 30 && !you.has_permanent_trait( highest_mct.threshold_mut ) ) {
            genemill_remove_thresh( you, highest_id->first );
            you.set_mutation( highest_mct.threshold_mut );
            you.add_msg_if_player(
                _( "As you wake, you find yourself much more attuned to your new form than before." ) );

        } else if( highest_id->second < 30 && you.crossed_threshold() ) {
            genemill_remove_thresh( you, mutation_category_id::NULL_ID() );
            you.add_msg_if_player(
                _( "As you wake, you feel like if you have lost a once important part of yourself." ) );
        }
    }
    //Consume the template if its single use.
    item_location selected = item_map[genemenu.ret];
    if( selected->has_flag( flag_NANOFAB_TEMPLATE_SINGLE_USE ) ) {
        selected.remove_item();
    }
}

/**
 * TEMPLATE FABRICATORS
 * Generate items from found blueprints.
 */
void iexamine::nanofab( Character &you, const tripoint_bub_ms &examp )
{
    bool table_exists = false;
    std::list<item_location> on_table;
    item_location nanofab_template;
    tripoint_bub_ms spawn_point;
    map &here = get_map();
    std::set<itype_id> allowed_template = here.ter( examp )->allowed_template_id;
    for( const tripoint_bub_ms &valid_location : here.points_in_radius( examp, 1 ) ) {
        if( here.has_flag( ter_furn_flag::TFLAG_NANOFAB_TABLE, valid_location ) ) {
            spawn_point = valid_location;
            table_exists = true;
            on_table = here.items_with( valid_location, [&]( const item & it ) {
                return it.has_flag( flag_NANOFAB_REPAIR );
            } );
            break;
        }
    }
    if( !table_exists ) {
        return;
    }

    item new_item;
    requirement_data reqs;

    // If there is something on the table that can be repaired suggest to repair that instead of printing something new
    if( !on_table.empty() ) {
        new_item = item( on_table.front()->typeId(), calendar::turn );
        int damage = on_table.front()->damage_level();
        if( damage <= 0 ) {
            popup( _( "FABRICATOR COMPLIANT ITEM %s DETECTED, BUT NOT DAMAGED REMOVE WORKING ITEM FROM FABRICATOR" ),
                   new_item.display_name() );
            sounds::sound( spawn_point, 10, sounds::sound_t::speech,
                           _( "REMOVE WORKING ITEM FROM FABRICATOR." ), true );
            return;
        }

        if( !on_table.front()->empty() ) {
            popup( _( "ITEM %s DETECTED, CONTENTS OF ITEM WILL BE DESTROYED BY FABRICATOR PLEASE EMPTY ITEM AND RETURN" ),
                   new_item.display_name() );
            sounds::sound( spawn_point, 10, sounds::sound_t::speech,
                           _( "PLEASE EMPTY ITEM AND RETURN." ), true );
            return;
        }

        sounds::sound( spawn_point, 10, sounds::sound_t::speech,
                       _( "REPAIR INTEGRITY DAMAGE?" ), true );
        if( !query_yn( _( "FABRICATOR COMPLIANT ITEM %s DETECTED, REPAIR INTEGRITY DAMAGE?" ),
                       new_item.display_name() ) ) {
            return;
        }

        // multiplier for the item being not completely destroyed
        float dam_mult = .05f * damage;

        int qty = std::max( 1, static_cast<int>( dam_mult * new_item.volume() / 250_ml ) );
        std::vector<std::vector<item_comp>> requirement_comp_vector;
        std::vector<std::vector<quality_requirement>> quality_comp_vector;
        std::vector<std::vector<tool_comp>> tool_comp_vector;
        std::vector<item_comp> nano_req = { item_comp( itype_nanomaterial, 5 * qty ) };
        requirement_comp_vector.push_back( nano_req );
        std::vector<item_comp> item_req = { item_comp( on_table.front()->typeId(), 1 ) };
        requirement_comp_vector.push_back( item_req );
        reqs = requirement_data( tool_comp_vector, quality_comp_vector, requirement_comp_vector );
    } else {
        //Create a list of the names of all acceptable templates.
        std::set<std::string> templatenames;
        for( const itype_id &id : allowed_template ) {
            templatenames.insert( id->nname( 1 ) );
        }
        std::string name_list = enumerate_as_string( templatenames );

        //Template selection
        nanofab_template = g->inv_map_splice( [&]( const item & e ) {
            return  std::any_of( allowed_template.begin(), allowed_template.end(),
            [&e]( const itype_id itid ) {
                return e.typeId() == itid;
            } );
        }, _( "Introduce a compatible template." ), pickup_range,
        _( "You don't have any usable templates.\n\nCompatible templates are: " ) + name_list );

        if( !nanofab_template ) {
            return;
        }

        //TODO: Allow variables to be cata_variant ids
        new_item = item( itype_id( nanofab_template->get_var( "NANOFAB_ITEM_ID" ) ), calendar::turn );
        int qty = std::max( 1, new_item.volume() / 250_ml );
        reqs = *nanofab_template->type->template_requirements * qty;
    }

    // either way the new item should have the nanofabricator flag
    if( !new_item.has_flag( flag_NANOFAB_REPAIR ) ) {
        new_item.set_flag( flag_NANOFAB_REPAIR );
    }

    if( !reqs.can_make_with_inventory( &you, you.crafting_inventory(), is_crafting_component ) ) {
        popup( "%s", reqs.list_missing() );
        return;
    }

    // Consume materials
    for( const auto &e : reqs.get_components() ) {
        you.consume_items( e, 1, is_crafting_component );
    }
    for( const auto &e : reqs.get_tools() ) {
        you.consume_tools( e );
    }
    you.invalidate_crafting_inventory();

    if( new_item.is_armor() && new_item.has_flag( flag_VARSIZE ) ) {
        new_item.set_flag( flag_FIT );
    }

    here.add_item_or_charges( spawn_point, new_item );

    // if this template is single use
    // also check if the template exists at all
    if( nanofab_template && nanofab_template->has_flag( flag_NANOFAB_TEMPLATE_SINGLE_USE ) ) {
        nanofab_template.remove_item();
    }
}

/**
 * UI FOR LAB_FINALE SUPERALLOY FORGE.
 */
void iexamine::nanoforge( Character &you, const tripoint_bub_ms &examp )
{
    if( !query_yn(
            _( "Use the superalloy forge?  Requires 4 any small steel sheets and 5 nanomaterial canisters." ) ) ) {
        none( you, examp );
        return;
    }

    bool table_exists = false;
    tripoint_bub_ms spawn_point;
    map &here = get_map();
    for( const auto &valid_location : here.points_in_radius( examp, 1 ) ) {
        if( here.has_flag( ter_furn_flag::TFLAG_NANOFORGE_TABLE, valid_location ) ) {
            spawn_point = valid_location;
            table_exists = true;
            break;
        }
    }
    if( !table_exists ) {
        return;
    }

    std::vector<std::string> recipe_ids;
    recipe_ids.emplace_back( "alloy_sheet" );

    if( recipe_ids.empty() ) {
        return;
    }

    std::string chosen_recipe = recipe_ids.front();

    if( chosen_recipe.empty() ) {
        return;
    }

    item new_item( itype_id( chosen_recipe ), calendar::turn );

    const int qty = 1;
    requirement_data reqs = *requirement_data_superalloy_forge * qty;

    if( !reqs.can_make_with_inventory( &you, you.crafting_inventory(), is_crafting_component ) ) {
        popup( "%s", reqs.list_missing() );
        return;
    }

    for( const auto &e : reqs.get_components() ) {
        you.consume_items( e, 1, is_crafting_component );
    }
    for( const auto &e : reqs.get_tools() ) {
        you.consume_tools( e );
    }
    you.invalidate_crafting_inventory();

    here.add_item_or_charges( spawn_point, new_item );
}

/// @brief Use "gas pump."
/// @details Will pump any liquids on tile.
void iexamine::gaspump( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    if( !query_yn( _( "Use the %s?" ), here.tername( examp ) ) ) {
        none( you, examp );
        return;
    }

    map_stack items = here.i_at( examp );
    for( auto item_it = items.begin(); item_it != items.end(); ++item_it ) {
        if( item_it->made_of( phase_id::LIQUID ) ) {
            /// @note \EFFECT_DEX decreases chance of spilling gas from a pump
            if( one_in( 10 + you.get_dex() ) ) {
                add_msg( m_bad, _( "You accidentally spill the %s." ), item_it->type_name() );
                static const auto max_spill_volume = units::from_liter( 1 );
                const int max_spill_charges = std::max( 1, item_it->charges_per_volume( max_spill_volume ) );
                /// @note \EFFECT_DEX decreases amount of gas spilled, if gas is spilled from pump
                const int qty = rng( 1, max_spill_charges * 8.0 / std::max( 1, you.get_dex() ) );

                item spill = item_it->split( qty );
                if( spill.is_null() ) {
                    here.add_item_or_charges( you.pos_bub(), *item_it );
                    items.erase( item_it );
                } else {
                    here.add_item_or_charges( you.pos_bub(), spill );
                }

            } else {
                item_location loc( map_cursor( examp ), &*item_it );
                liquid_handler::handle_liquid( loc, nullptr, 1 );
            }
            return;
        }
    }
    add_msg( m_info, _( "Out of order." ) );
}

void iexamine::translocator( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();

    const tripoint_abs_omt omt_loc( coords::project_to<coords::omt>( here.get_abs( examp ) ) );
    avatar &player_character = get_avatar();
    const bool activated = player_character.translocators.knows_translocator( omt_loc );

    if( here.has_flag_furn( ter_furn_flag::TFLAG_TRANSLOCATOR_GREATER, examp ) ) {

        enum options {
            ADJUST_ACTIVATION,
            TELEPORT,
        };

        uilist menu;
        menu.addentry( TELEPORT, true, 't', _( "Translocate" ) );
        menu.addentry( ADJUST_ACTIVATION, true, 'a', _( "Adjust activation status" ) );
        menu.query();

        switch( menu.ret ) {
            case TELEPORT: {
                avatar *av = you.as_avatar();
                if( av == nullptr ) {
                    return;
                }
                av->translocators.translocate( { you.pos_bub() } );
                break;
            }
            case ADJUST_ACTIVATION: {
                if( !activated ) {
                    player_character.translocators.activate_teleporter( omt_loc, examp );
                    add_msg( m_info, _( "Translocator gate active." ) );
                } else {
                    if( query_yn( _( "Do you want to deactivate this active Translocator?" ) ) ) {
                        player_character.translocators.deactivate_teleporter( omt_loc, examp );
                    }
                }
                break;
            }
            default: {
                return;
            }
        }

    } else {
        if( !activated ) {
            player_character.translocators.activate_teleporter( omt_loc, examp );
            add_msg( m_info, _( "Translocator gate active." ) );
        } else {
            if( query_yn( _( "Do you want to deactivate this active Translocator?" ) ) ) {
                player_character.translocators.deactivate_teleporter( omt_loc, examp );
            }
        }
    }
}

namespace
{
//--------------------------------------------------------------------------------------------------
//! Implements iexamine::atm(...)
//--------------------------------------------------------------------------------------------------
class atm_menu
{
    public:
        // menu choices

        atm_menu()                           = delete;
        atm_menu( atm_menu const & )            = delete;
        atm_menu( atm_menu && )                 = delete;
        atm_menu &operator=( atm_menu const & ) = delete;
        atm_menu &operator=( atm_menu && )      = delete;

        explicit atm_menu( Character &you ) : you( you ) {
            reset( false );
        }

        void start() {
            switch( choose_option() ) {
                case purchase_card:
                    do_purchase_card();
                    break;
                case deposit_money:
                    do_deposit_money();
                    break;
                case withdraw_money:
                    do_withdraw_money();
                    break;
                case exchange_cash:
                    do_exchange_cash();
                    break;
                case transfer_all_money:
                    do_transfer_all_money();
                    break;
                default:
                    return;
            }
        }
    private:
        void add_choice( const int i, const char *const title ) {
            amenu.addentry( i, true, -1, title );
        }
        void add_info( const int i, const char *const title ) {
            amenu.addentry( i, false, -1, title );
        }

        atm_options choose_option() {
            amenu.query();
            uistate.iexamine_atm_selected = amenu.selected;
            return amenu.ret < 0 ? cancel : static_cast<atm_options>( amenu.ret );
        }

        //! Reset and repopulate the menu; with a fair bit of work this could be more efficient.
        void reset( const bool clear = true ) {
            const int card_count   = you.amount_of( itype_cash_card );
            const int charge_count = card_count ? you.charges_of( itype_cash_card ) : 0;

            if( clear ) {
                amenu.reset();
            }

            amenu.selected = uistate.iexamine_atm_selected;
            amenu.text = string_format( _( "Welcome to the C.C.B.o.t.T. ATM.  What would you like to do?\n"
                                           "Your current balance is: %s" ),
                                        format_money( you.cash ) );

            if( you.cash >= 1000 ) {
                add_choice( purchase_card, _( "Purchase cash card?" ) );
            } else {
                add_info( purchase_card, _( "You need $10.00 in your account to purchase a card." ) );
            }

            if( card_count && you.cash > 0 ) {
                add_choice( withdraw_money, _( "Withdraw Money" ) );
            } else if( you.cash > 0 ) {
                add_info( withdraw_money, _( "You need a cash card before you can withdraw money!" ) );
            } else if( you.cash < 0 ) {
                add_info( withdraw_money,
                          _( "You need to pay down your debt first!" ) );
            } else {
                add_info( withdraw_money,
                          _( "You need money in your account before you can withdraw money!" ) );
            }

            if( charge_count ) {
                add_choice( deposit_money, _( "Deposit Money" ) );
            } else {
                add_info( deposit_money,
                          _( "You need a charged cash card before you can deposit money!" ) );
            }

            if( card_count >= 1 && you.cache_has_item_with( flag_OLD_CURRENCY ) ) {
                add_choice( exchange_cash, _( "Exchange Cash for eCash (1%% fee)" ) );
            }

            if( card_count >= 2 && charge_count ) {
                add_choice( transfer_all_money, _( "Transfer All Money" ) );
            }
        }

        //! Prompt for an integral value clamped to [0, max].
        static int prompt_for_amount( const char *const msg, const int max ) {
            int amount = max;
            query_int( amount, true, msg, max );
            return clamp( amount, 0, max );
        }

        //!Get a new cash card. $10.00 fine.
        bool do_purchase_card() {
            const char *prompt =
                _( "This will automatically deduct $10.00 from your bank account.  Continue?" );

            if( !query_yn( prompt ) ) {
                return false;
            }

            you.assign_activity( atm_activity_actor( purchase_card ) );
            return true;
        }

        //!Deposit money from cash card into bank account.
        bool do_deposit_money() {
            int money = you.charges_of( itype_cash_card );

            if( !money ) {
                popup( _( "You can only deposit money from charged cash cards!" ) );
                return false;
            }

            const int amount = prompt_for_amount( n_gettext(
                    "Deposit how much?  Max: %d cent.  (0 to cancel) ",
                    "Deposit how much?  Max: %d cents.  (0 to cancel) ", money ), money );

            if( !amount ) {
                return false;
            }

            you.assign_activity( atm_activity_actor( deposit_money, amount ) );
            return true;
        }

        //!Move money from bank account onto cash card.
        bool do_withdraw_money() {
            const int amount = prompt_for_amount( n_gettext(
                    "Withdraw how much?  Max: %d cent.  (0 to cancel) ",
                    "Withdraw how much?  Max: %d cents.  (0 to cancel) ", you.cash ), you.cash );

            if( !amount ) {
                return false;
            }

            you.assign_activity( atm_activity_actor( withdraw_money, amount ) );
            return true;
        }

        //!Deposit pre-Cataclysm currency and receive equivalent amount minus fees on a card.
        bool do_exchange_cash() {

            if( !query_yn( _( "Exchange all paper bills and coins in inventory?" ) ) ) {
                return false;
            }
            you.assign_activity( atm_activity_actor( exchange_cash ) );
            return true;
        }

        //!Move the money from all the cash cards in inventory to a single card.
        bool do_transfer_all_money() {
            you.assign_activity( atm_activity_actor( transfer_all_money ) );
            return true;
        }

        Character &you;
        uilist amenu;
};
} //namespace

/**
 * launches the atm menu class which then handles all the atm interactions.
 */
void iexamine::atm( Character &you, const tripoint_bub_ms & )
{
    atm_menu {you}.start();
}

/**
 * Generates vending machine UI and allows players to purchase contained items with a cash card.
 */
void iexamine::vending( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();

    constexpr int moves_cost = to_moves<int>( 5_seconds );
    int money = you.charges_of( itype_cash_card );
    map_stack vend_items = here.i_at( examp );

    bool use_bank = here.has_flag_furn( "BANK_NETWORKED", examp );

    if( use_bank ) {
        money = you.cash + you.charges_of( itype_cash_card );
    }

    if( vend_items.empty() ) {
        add_msg( m_info, _( "The vending machine is empty." ) );
        return;
    }

    if( !money ) {
        popup( _( "You need some money on a cash card to buy things." ) );
    }

    int w_items_w = 0;
    int w_info_w = 0;
    int list_lines = 0;
    int lines_above = 0;
    int lines_below = 0;
    constexpr int first_item_offset = 3; // header size

    catacurses::window w;
    catacurses::window w_item_info;

    ui_adaptor ui;
    ui.on_screen_resize( [&]( ui_adaptor & ui ) {
        const point padding( std::max( 0, TERMX - FULL_SCREEN_WIDTH ) / 4, std::max( 0,
                             TERMY - FULL_SCREEN_HEIGHT ) / 6 );
        const int window_h   = FULL_SCREEN_HEIGHT + std::max( 0, TERMY - FULL_SCREEN_HEIGHT ) * 2 / 3;
        const int window_w   = FULL_SCREEN_WIDTH + std::max( 0, TERMX - FULL_SCREEN_WIDTH ) / 2;
        w_items_w  = window_w / 2;
        w_info_w   = window_w - w_items_w;
        list_lines = window_h - 4; // minus for header and footer

        lines_above = list_lines / 2;                  // lines above the selector
        lines_below = list_lines / 2 + list_lines % 2; // lines below the selector

        w = catacurses::newwin( window_h, w_items_w,
                                padding );
        w_item_info = catacurses::newwin( window_h, w_info_w,
                                          padding + point( w_items_w, 0 ) );

        ui.position( padding, point( window_w, window_h ) );
    } );
    ui.mark_resize();

    bool used_machine = false;
    input_context ctxt( "VENDING_MACHINE" );
    ctxt.register_navigate_ui_list();
    ctxt.register_action( "SCROLL_ITEM_INFO_UP" );
    ctxt.register_action( "SCROLL_ITEM_INFO_DOWN" );
    ctxt.register_action( "CONFIRM" );
    ctxt.register_action( "QUIT" );
    ctxt.register_action( "HELP_KEYBINDINGS" );

    // Collate identical items.
    // First, build a map {item::tname} => {item_it, item_it, item_it...}
    using iterator_t = decltype( std::begin( vend_items ) ); // map_stack::iterator doesn't exist.

    std::map<std::string, std::vector<iterator_t>> item_map;
    for( auto it = std::begin( vend_items ); it != std::end( vend_items ); ++it ) {
        // |# {name}|
        // 123      4
        std::string suffix = it->count() > 1 ? string_format( " (%d)", it->count() ) : "";
        item_map[it->tname() + suffix].push_back( it );
    }

    // Next, put pointers to the pairs in the map in a vector to allow indexing.
    std::vector<std::map<std::string, std::vector<iterator_t>>::value_type *> item_list;
    item_list.reserve( item_map.size() );
    for( auto &pair : item_map ) {
        item_list.emplace_back( &pair );
    }

    int cur_pos = 0;
    int item_info_scroll_pos = 0;
    const int &item_info_scroll_delta = list_lines;

    ui.on_redraw( [&]( const ui_adaptor & ) {
        const int num_items = item_list.size();
        const int page_size = std::min( num_items, list_lines );

        werase( w );
        draw_border( w );
        wattron( w, BORDER_COLOR );
        mvwhline( w, point( 1, first_item_offset - 1 ), LINE_OXOX, w_items_w - 2 );
        mvwaddch( w, point( 0, first_item_offset - 1 ), LINE_XXXO ); // |-
        mvwaddch( w, point( w_items_w - 1, first_item_offset - 1 ), LINE_XOXX ); // -|
        wattroff( w, BORDER_COLOR );

        trim_and_print( w, point( 2, 1 ), w_items_w - 3, c_light_gray,
                        _( "Money left: %s" ), format_money( money ) );

        // Keep the item selector centered in the page.
        int page_beg;
        if( cur_pos < num_items - cur_pos ) {
            page_beg = std::max( 0, cur_pos - lines_above );
        } else {
            int page_end = std::min( num_items, cur_pos + lines_below );
            page_beg = std::max( 0, page_end - list_lines );
        }

        for( int line = 0; line < page_size; ++line ) {
            const int i = page_beg + line;
            const nc_color color = ( i == cur_pos ) ? h_light_gray : c_light_gray;
            const auto &elem = item_list[i];
            const int count = elem->second.size();
            const char c = ( count < 10 ) ? ( '0' + count ) : '*';
            trim_and_print( w, point( 1, first_item_offset + line ), w_items_w - 3, color, "%c %s", c,
                            elem->first.c_str() );
        }

        draw_scrollbar( w, cur_pos, list_lines, num_items, point( 0, first_item_offset ) );
        wnoutrefresh( w );

        // Item info
        auto &cur_items = item_list[static_cast<size_t>( cur_pos )]->second;
        auto &cur_item  = cur_items.back();

        std::vector<iteminfo> cur_item_info;
        cur_item->info( true, cur_item_info );

        item_info_data data( cur_item->display_name(), "", cur_item_info, {}, item_info_scroll_pos );
        data.without_getch = true;
        draw_item_info( w_item_info, data );
    } );

    for( ;; ) {
        ui_manager::redraw();

        const int num_items = item_list.size();

        // Item info
        auto &cur_items = item_list[static_cast<size_t>( cur_pos )]->second;
        auto &cur_item  = cur_items.back();

        const std::string &action = ctxt.handle_input();
        if( navigate_ui_list( action, cur_pos, 3, num_items, true ) ) {
            item_info_scroll_pos = 0;
        } else if( action == "SCROLL_ITEM_INFO_UP" ) {
            // clamping to min/max is done in draw_item_info
            item_info_scroll_pos -= item_info_scroll_delta;
        } else if( action == "SCROLL_ITEM_INFO_DOWN" ) {
            item_info_scroll_pos += item_info_scroll_delta;
        } else if( action == "CONFIRM" ) {
            const int iprice = cur_item->price( false );

            if( iprice > money ) {
                popup( _( "You can't afford that item." ) );
                continue;
            }

            if( !used_machine ) {
                used_machine = true;
                you.mod_moves( -moves_cost );
            }

            money -= iprice;

            if( iprice < you.charges_of( itype_cash_card ) ) {
                // necessary to check just your cash card charges here because aftershock charges your cards first then your bank
                you.use_charges( itype_cash_card, iprice );
            } else if( use_bank ) {
                you.cash -= iprice;
            }
            you.i_add_or_drop( *cur_item );

            vend_items.erase( cur_item );
            cur_items.pop_back();
            if( !cur_items.empty() ) {
                continue;
            }

            item_info_scroll_pos = 0;
            item_list.erase( std::begin( item_list ) + cur_pos );
            if( item_list.empty() ) {
                add_msg( _( "With a beep, the empty vending machine shuts down." ) );
                return;
            } else if( cur_pos == num_items - 1 ) {
                cur_pos--;
            }
        } else if( action == "QUIT" ) {
            break;
        }
    }
}

namespace
{
int _get_rot_delta( tripoint_abs_omt const &this_omt, tripoint_abs_omt const &that_omt )
{
    om_direction::type const this_dir = overmap_buffer.ter( that_omt )->get_dir();
    om_direction::type const that_dir = overmap_buffer.ter( this_omt )->get_dir();
    int const diff = static_cast<int>( this_dir ) - static_cast<int>( that_dir );
    return diff >= 0 ? diff : 4 + diff;
}

tripoint_bub_ms _rotate_point_sm( tripoint_bub_ms const &p, int erot, tripoint_bub_ms const &orig )
{
    tripoint_rel_ms const p_sm( p - orig.xy() );
    tripoint_rel_ms const rd = p_sm.rotate( erot, {SEEX * 2, SEEY * 2} );
    return rd + orig.xy();
}

constexpr int uilist_positive = 10000; // workaround for uilist retval autoassign when retval == -1

int _choose_elevator_destz( tripoint_bub_ms const &examp, tripoint_abs_omt const &this_omt,
                            tripoint_bub_ms const &sm_orig )
{
    map &here = get_map();
    uilist choice;
    choice.title = _( "Select destination floor" );
    for( int z = OVERMAP_HEIGHT; z >= -OVERMAP_DEPTH; z-- ) {
        tripoint_abs_omt const that_omt( this_omt.xy(), z );
        tripoint_bub_ms const zp =
            _rotate_point_sm( { examp.xy(), z}, _get_rot_delta( this_omt, that_omt ),
                              sm_orig );

        if( here.ter( zp )->has_examine( iexamine::elevator ) ) {
            std::string const omt_name = overmap_buffer.ter_existing( that_omt )->get_name(
                                             om_vision_level::full );
            std::string const name = string_format(
                                         "%i %s%s", z, omt_name, z == examp.z() ? _( " (this floor)" ) : std::string() );
            choice.addentry( z + uilist_positive, z != examp.z(), MENU_AUTOASSIGN, name );
        }
    }
    choice.query();
    return choice.ret;
}

struct elevator_vehicles {
    bool blocking = false;
    std::vector<vehicle *> v;
};

elevator_vehicles _get_vehicles_on_elevator( std::vector<tripoint_bub_ms> const &elevator )
{
    std::vector<vehicle *> ret;
    VehicleList const vehs = get_map().get_vehicles();
    for( wrapped_vehicle const &v : vehs ) {
        bool inbounds = true;
        bool can_block = false;
        for( const vpart_reference &vp : v.v->get_all_parts() ) {
            tripoint_bub_ms const p = tripoint_bub_ms( v.pos ) + vp.part().precalc[0];
            auto const eit = std::find( elevator.cbegin(), elevator.cend(), p );
            inbounds &= eit != elevator.cend();
            if( !inbounds ) {
                break;
            }
            can_block = true;
        }
        if( inbounds ) {
            ret.emplace_back( v.v );
        } else if( can_block ) {
            return { true, { v.v } };
        }
    }

    return { false, ret };
}
} // namespace

void iexamine::elevator( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    tripoint_abs_ms const old_abs_pos = you.pos_abs();
    tripoint_abs_omt const this_omt = project_to<coords::omt>( here.get_abs( examp ) );
    tripoint_bub_ms const sm_orig = here.get_bub( project_to<coords::ms>( this_omt ) );
    std::vector<tripoint_bub_ms> this_elevator;

    for( tripoint_bub_ms const &pos : closest_points_first( examp, SEEX - 1 ) ) {
        if( here.has_flag( ter_furn_flag::TFLAG_ELEVATOR, pos ) ) {
            this_elevator.emplace_back( pos );
        }
    }

    auto const uit = std::find( this_elevator.cbegin(), this_elevator.cend(), you.pos_bub() );
    if( uit == this_elevator.cend() ) {
        popup( _( "You must stand inside the elevator to use it." ) );
        return;
    }

    elevator_vehicles const vehs = _get_vehicles_on_elevator( this_elevator );
    if( vehs.blocking ) {
        popup( string_format( _( "The %s is blocking the elevator" ), vehs.v.front()->name ) );
        return;
    }

    int const movez = _choose_elevator_destz( examp, this_omt, sm_orig ) - uilist_positive;
    if( movez < -OVERMAP_DEPTH ) {
        return;
    }

    tripoint_abs_omt const that_omt( this_omt.xy(), movez );
    const cata::lua_platform::native_callback_point elevator_position = {
        "bub_ms", tripoint_rel_ms( examp.x(), examp.y(), examp.z() )
    };
    const cata::lua_platform::native_callback_point elevator_destination = {
        "abs_omt", tripoint_rel_ms( that_omt.x(), that_omt.y(), that_omt.z() )
    };
    if( !cata::lua_platform::allow_native_elevator_use(
            you, elevator_position, elevator_destination ) ) {
        return;
    }
    int const erot = _get_rot_delta( this_omt, that_omt );
    std::vector<tripoint_bub_ms> that_elevator;
    std::transform( this_elevator.begin(), this_elevator.end(), std::back_inserter( that_elevator ),
    [&erot, &sm_orig, &movez]( tripoint_bub_ms const & p ) {
        return _rotate_point_sm( { p.xy(), movez}, erot, sm_orig );
    } );

    creature_tracker &creatures = get_creature_tracker();
    // first find critters in the destination elevator and move them out of the way
    for( Creature &critter : g->all_creatures() ) {
        tripoint_bub_ms const cr_pos = critter.pos_bub();
        auto const eit = std::find( that_elevator.cbegin(), that_elevator.cend(), cr_pos );
        if( eit != that_elevator.cend() ) {
            for( const tripoint_bub_ms &candidate : closest_points_first( *eit, 10 ) ) {
                if( !here.has_flag( ter_furn_flag::TFLAG_ELEVATOR, candidate ) &&
                    here.passable_through( candidate ) &&
                    creatures.creature_at( candidate ) == nullptr ) {
                    critter.setpos( here, candidate );
                    break;
                }
            }
        }
    }

    const auto move_item = [&]( map_stack & items, const tripoint_bub_ms & src,
    const tripoint_bub_ms & dest ) {
        for( auto it = items.begin(); it != items.end(); ) {
            here.add_item_or_charges( dest, *it );
            it = here.i_rem( src, it );
        }
    };

    // move along every item in the elevator
    for( decltype( this_elevator )::size_type i = 0; i < this_elevator.size(); i++ ) {
        tripoint_bub_ms const &src = tripoint_bub_ms( this_elevator[i] );
        map_stack items = here.i_at( src );
        move_item( items, src, tripoint_bub_ms( that_elevator[i] ) );
    }

    // move along all creatures on the elevator
    for( Creature &critter : g->all_creatures() ) {
        auto const eit = std::find( this_elevator.cbegin(), this_elevator.cend(), critter.pos_bub() );
        if( eit != this_elevator.cend() ) {
            critter.setpos( here, that_elevator[ std::distance( this_elevator.cbegin(), eit ) ] );
        }
    }

    for( vehicle *v : vehs.v ) {
        tripoint_bub_ms const p = _rotate_point_sm( { v->pos_bub( here ).xy(), movez},
                                  erot,
                                  sm_orig );
        here.displace_vehicle( *v, p - v->pos_bub( here ) );
        v->turn( erot * 90_degrees );
        v->face = tileray( v->turn_dir );
        v->precalc_mounts( 0, v->turn_dir, v->pivot_anchor[0] );
    }
    here.rebuild_vehicle_level_caches();
    if( you.is_avatar() ) {
        g->vertical_shift( movez );
        g->update_map( you, true );
        cata_event_dispatch::avatar_moves( old_abs_pos, *you.as_avatar(), here );
    }
}

/**
 * Open gate.
 */
void iexamine::controls_gate( Character &you, const tripoint_bub_ms &examp )
{
    if( !query_yn( _( "Use the %s?" ), get_map().tername( examp ) ) ) {
        none( you, examp );
        return;
    }
    g->open_gate( examp );
}

bool iexamine::can_hack( Character &you )
{
    if( you.has_trait( trait_ILLITERATE ) ) {
        add_msg( _( "You cannot read!" ) );
        return false;
    }
    item &best_hacking = you.best_item_with_quality( qual_HACK );
    if( best_hacking.is_null() || !item_location{you, &best_hacking}->ammo_sufficient( &you ) ) {
        add_msg( _( "You don't have a hacking tool with enough charges!" ) );
        return false;
    }
    return true;
}

bool iexamine::try_start_hacking( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();

    if( !can_hack( you ) ) {
        return false;
    } else {
        item_location hacking_tool = item_location{you, &you.best_item_with_quality( qual_HACK )};
        hacking_tool->consume_tool_uses( 1, here, hacking_tool.pos_bub( here ), &you );
        you.assign_activity( hacking_activity_actor( hacking_tool ) );
        you.activity.placement = here.get_abs( examp );
        return true;
    }
}

void iexamine::cardreader_robofac( Character &you, const tripoint_bub_ms &examp )
{
    itype_id card_type = itype_id_science;
    if( you.has_amount( card_type, 1 ) && query_yn( _( "Swipe your ID card?" ) ) ) {
        you.mod_moves( -100 );
        you.use_amount( card_type, 1 );
        add_msg( m_bad, _( "The card reader short circuits!" ) );
        get_map().ter_set( examp, ter_t_card_reader_broken );
        intercom( you, examp );
    } else {
        add_msg( _( "You have never seen this card reader model before.  Hacking it seems impossible." ) );
    }
}

void iexamine::cardreader_foodplace( Character &you, const tripoint_bub_ms &examp )
{
    bool open = false;
    if( ( you.is_wearing( itype_foodperson_mask ) ||
          you.is_wearing( itype_foodperson_mask_on ) ) &&
        query_yn( _( "Press mask on the reader?" ) ) ) {
        you.mod_moves( -100 );
        map &here = get_map();
        for( const tripoint_bub_ms &tmp : here.points_in_radius( tripoint_bub_ms( examp ), 3 ) ) {
            if( here.ter( tmp ) == ter_t_door_metal_locked ) {
                here.ter_set( tmp, ter_t_door_metal_c );
                open = true;
            }
        }
        if( open ) {
            add_msg( _( "You press your face on the reader." ) );
            add_msg( m_good, _( "The nearby doors are unlocked." ) );
            sounds::sound( examp, 6, sounds::sound_t::electronic_speech,
                           _( "\"Hello Foodperson.  Welcome home.\"" ), true, "speech", "welcome" );
        } else {
            add_msg( _( "The nearby doors are already unlocked." ) );
            if( query_yn( _( "Lock doors?" ) ) ) {
                for( const tripoint_bub_ms &tmp : here.points_in_radius( tripoint_bub_ms( examp ), 3 ) ) {
                    const ter_id &t = here.ter( tmp );
                    if( t == ter_t_door_metal_o || t == ter_t_door_metal_c ) {
                        if( you.pos_bub() == tmp ) {
                            you.add_msg_if_player( m_bad, _( "You are in the way of the door, move before trying again." ) );
                        } else {
                            here.ter_set( tmp, ter_t_door_metal_locked );
                        }
                    }
                }
            }
        }
    } else if( you.has_amount( itype_foodperson_mask, 1 ) ||
               you.has_amount( itype_foodperson_mask_on, 1 ) ) {
        sounds::sound( examp, 6, sounds::sound_t::electronic_speech,
                       _( "\"FOODPERSON DETECTED.  Please make yourself presentable.\"" ), true,
                       "speech", "welcome" );
    } else {
        sounds::sound( examp, 6, sounds::sound_t::electronic_speech,
                       _( "\"Your face is inadequate.  Please go away.\"" ), true,
                       "speech", "welcome" );
        if( can_hack( you ) && query_yn( _( "Attempt to hack this card-reader?" ) ) ) {
            try_start_hacking( you, tripoint_bub_ms( examp ) );
        }
    }
}

void iexamine::intercom_balthazar( Character &you, const tripoint_bub_ms &examp )
{
    const std::vector<npc *> intercom_npcs = g->get_npcs_if( [examp]( const npc & guy ) {
        return guy.myclass == NC_BALTHAZAR_INTERCOM && rl_dist( guy.pos_bub(), examp ) < 10;
    } );
    if( intercom_npcs.empty() ) {
        you.add_msg_if_player( m_info, _( "No one responds." ) );
    } else {
        // TODO: This needs to be converted a talker_console or something
        get_avatar().talk_to( get_talker_for( *intercom_npcs.front() ), false );
    }
}

npc *find_intercom_operator( const trait_id &marker_trait,
                             const faction_id &fac_id )
{
    npc *fallback = nullptr;
    for( npc *guy : g->get_npcs_if( [&marker_trait, &fac_id]( const npc & n ) {
    return n.has_trait( marker_trait ) &&
               n.get_faction() && n.get_faction()->id == fac_id &&
               !n.in_sleep_state();
    } ) ) {
        if( !guy->myclass.is_null() ) {
            const auto &[start, end] = guy->myclass.obj().get_work_hours();
            const int hour = to_hours<int>( time_past_midnight( calendar::turn ) );
            if( is_within_work_hours( hour, start, end ) ) {
                return guy;
            }
        }
        if( !fallback ) {
            fallback = guy;
        }
    }
    return fallback;
}

void iexamine::intercom( Character &you, const tripoint_bub_ms &examp )
{
    // Prefer trait-based operators (new worlds with shift rotation)
    npc *op = find_intercom_operator( trait_INTERCOM_OPERATOR, faction_robofac );
    if( !op ) {
        // Legacy fallback: old class-based NPC (existing saves).
        // Preserves original 10-tile distance check.
        const std::vector<npc *> legacy = g->get_npcs_if( [examp]( const npc & n ) {
            return n.myclass == NC_ROBOFAC_INTERCOM && rl_dist( n.pos_bub(), examp ) < 10;
        } );
        if( !legacy.empty() ) {
            op = legacy.front();
        }
    }
    if( !op ) {
        you.add_msg_if_player( m_info, _( "No one responds." ) );
    } else {
        get_avatar().talk_to( get_talker_for( *op ), false, false, false, "",
                              _( "the intercom" ) );
    }
}

/**
 * Prompt removal of rubble. Select best shovel and invoke "CLEAR_RUBBLE" on tile.
 */
void iexamine::rubble( Character &you, const tripoint_bub_ms &examp )
{
    int moves;
    if( you.has_quality( qual_DIG, 3 ) || you.has_trait( trait_BURROW ) ||
        you.has_trait( trait_BURROWLARGE ) ) {
        moves = to_moves<int>( 1_minutes );
    } else if( you.has_quality( qual_DIG, 2 ) ) {
        moves = to_moves<int>( 2_minutes );
    } else {
        add_msg( m_info, _( "If only you had a shovel…" ) );
        return;
    }
    map &here = get_map();
    if( ( here.veh_at( examp ) || here.can_see_trap_at( examp, you ) ||
          get_creature_tracker().creature_at( examp ) != nullptr ) &&
        !query_yn( _( "Clear up that %s?" ), here.furnname( examp ) ) ) {
        return;
    }
    you.assign_activity( clear_rubble_activity_actor( moves ) );
    you.activity.placement = here.get_abs( examp );
}

/**
 * Prompt climbing over fence. Calculates move cost, applies it to player and moves them.
 */
void iexamine::chainfence( Character &you, const tripoint_bub_ms &examp )
{
    // If player is grabbed, trapped, or somehow otherwise movement-impeded, first try to break free
    if( !you.move_effects( false ) ) {
        you.mod_moves( -to_moves<int>( 1_seconds ) );
        return;
    }

    if( you.get_working_arm_count() < 1 ) {
        add_msg( m_info, _( "You can't climb because your arms are too damaged or encumbered." ) );
        return;
    }

    const item_location weapon = you.get_wielded_item();
    if( weapon && weapon->is_two_handed( you ) ) {
        if( query_yn(
                _( "You can't climb because you have to wield a %s with both hands.\n\nPut it away?" ),
                weapon->tname() ) ) {
            if( !you.unwield() ) {
                return;
            }
        } else {
            return;
        }
    }

    // We're not going to do anything if we're already on that point.
    // Also prompt the player before taking an action.
    if( you.pos_bub() == examp || !query_yn( _( "Climb obstacle?" ) ) ) {
        none( you, examp );
        return;
    }

    map &here = get_map();
    int move_cost = 400;
    // TODO: Remove hardcoded trait checks when new arthropod bits happen
    if( here.has_flag( ter_furn_flag::TFLAG_CLIMB_SIMPLE, examp ) ) {

        if( you.has_proficiency( proficiency_prof_parkour ) ) {
            add_msg( _( "You vault over the obstacle with ease." ) );
            move_cost = 100; // Not tall enough to warrant spider-climbing, so only relevant trait.
        } else {
            add_msg( _( "You vault over the obstacle." ) );
            move_cost = 300; // Most common move cost for barricades pre-change.
        }
    } else if( you.has_trait( trait_ARACHNID_ARMS_OK ) &&
               !you.wearing_fitting_on( bodypart_id( "torso" ) ) ) {
        add_msg( _( "Climbing this obstacle is trivial for one such as you." ) );
        move_cost = 75; // Yes, faster than walking.  6-8 limbs are impressive.
    } else if( you.has_trait( trait_INSECT_ARMS_OK ) &&
               !you.wearing_fitting_on( bodypart_id( "torso" ) ) ) {
        add_msg( _( "You quickly scale the fence." ) );
        move_cost = 90;
    } else if( you.has_proficiency( proficiency_prof_parkour ) ) {
        add_msg( _( "This obstacle is no match for your freerunning abilities." ) );
        move_cost = 100;
    } else {
        move_cost = you.has_trait( trait_BADKNEES ) ? 800 : 400;
        if( g->slip_down( you, game::climb_maneuver::over_obstacle, climbing_aid_furn_CLIMBABLE ) ) {
            you.mod_moves( -move_cost );
            return;
        }
    }
    Character &player_character = get_player_character();
    sfx::play_variant_sound( "plmove", "clear_obstacle",
                             sfx::get_heard_volume( player_character.pos_bub() ) );
    add_msg_debug( debugmode::DF_IEXAMINE,
                   "Move cost to vault: %d, limb score modifier %.1f", move_cost,
                   you.get_modifier( character_modifier_obstacle_climb_mod ) );
    move_cost /= you.get_modifier( character_modifier_obstacle_climb_mod );
    add_msg_debug( debugmode::DF_IEXAMINE,
                   "Final move cost %d", move_cost );
    you.mod_moves( -move_cost );
    if( you.in_vehicle ) {
        here.unboard_vehicle( you.pos_bub() );
    }
    you.setpos( here, examp );
    if( examp.x() < HALF_MAPSIZE_X || examp.y() < HALF_MAPSIZE_Y ||
        examp.x() >= HALF_MAPSIZE_X + SEEX || examp.y() >= HALF_MAPSIZE_Y + SEEY ) {
        if( you.is_avatar() ) {
            g->update_map( you );
        }
    }
}

/**
 * If player has amorphous trait, slip through the bars.
 */
void iexamine::bars( Character &you, const tripoint_bub_ms &examp )
{
    if( !you.has_trait( trait_AMORPHOUS ) ) {
        none( you, examp );
        return;
    }
    map &here = get_map();
    for( const bodypart_id &bp : you.get_all_body_parts() ) {
        if( you.encumb( bp ) >= 10 ) {
            add_msg( m_info,
                     _( "Your amorphous body could slip though the %s, but your cumbersome gear can't." ),
                     here.tername( examp ) );
            return;
        }
    }
    if( !query_yn( _( "Slip through the %s?" ), here.tername( examp ) ) ) {
        none( you, examp );
        return;
    }
    you.mod_moves( -to_moves<int>( 2_seconds ) );
    add_msg( _( "You slide right between the bars." ) );
    you.setpos( here, examp );
}

void iexamine::deployed_furniture( Character &you, const tripoint_bub_ms &pos )
{
    map &here = get_map();

    const deployed_furniture_selection choice{ you.pos_abs(), here.get_abs( pos ), here.furn( pos ).id() };
    const character_action_guard lifetime( you );
    if( !you.is_avatar() || !can_take_down_deployed_furniture( you, here, choice ) ) {
        return;
    }
    const std::string name = choice.furniture.obj().name();
    if( !you.query_yn( you.posz() != pos.z() ? _( "Pull up the %s?" ) :
                       _( "Take down the %s?" ), name ) || !lifetime ) {
        return;
    }
    if( !cata_mp::client_take_down_furniture( choice ) ) {
        take_down_deployed_furniture( you, here, choice );
    }
}

static std::pair<itype_id, const deploy_tent_actor *> find_tent_itype( const furn_str_id &id )
{
    const itype_id &iid = id->deployed_item;
    if( item::type_is_defined( iid ) ) {
        const itype &type = *item::find_type( iid );
        for( const auto &pair : type.use_methods ) {
            const deploy_tent_actor *actor = dynamic_cast<const deploy_tent_actor *>
                                             ( pair.second.get_actor_ptr() );
            if( !actor ) {
                continue;
            }
            if( ( actor->floor_center && *actor->floor_center == id ) || ( !actor->floor_center &&
                    actor->floor == id ) ) {
                return std::make_pair( iid, actor );
            }
        }
    }
    return std::make_pair( iid, nullptr );
}

/**
 * Determine structure's type and prompts its removal.
 */
void iexamine::portable_structure( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const furn_str_id fid = here.furn( examp ).id();
    const std::pair<itype_id, const deploy_tent_actor *> tent_item_type = find_tent_itype( fid );
    if( tent_item_type.first.is_null() ) {
        debugmsg( "unknown furniture %s: don't know how to transform it into an item", fid.str() );
        return;
    }

    itype_id dropped = tent_item_type.first;
    std::string name = item::nname( dropped );
    int radius;

    if( tent_item_type.second ) {
        const deploy_tent_actor &actor = *tent_item_type.second;
        if( !actor.check_intact( examp ) ) {
            if( !actor.broken_type ) {
                add_msg( _( "The %s is broken and can not be picked up." ), name );
                none( you, examp );
                return;
            }
            dropped = *actor.broken_type;
            name = string_format( _( "damaged %s" ), name );
        }
        radius = actor.radius;
    } else {
        const std::optional<map_furn_bash_info> &furn_bash = fid.obj().bash;
        radius = std::max( 1, furn_bash ? furn_bash->collapse_radius : 0 );
    }

    if( !query_yn( _( "Take down the %s?" ), name ) ) {
        none( you, examp );
        return;
    }

    tent_deconstruct_activity_actor actor( to_moves<int>( 20_minutes ), radius, examp, dropped );
    you.assign_activity( actor );
}

static void submit_terrain_examine( Character &who, map &here,
                                    const terrain_examine_selection &choice )
{
    if( !who.is_avatar() || !cata_mp::client_terrain_examine( choice ) ) {
        execute_terrain_examine( who, here, choice );
    }
}

void iexamine::pit( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    terrain_examine_selection choice{ terrain_examine_action::cover_pit, you.pos_abs(),
                                      here.get_abs( examp ), here.ter( examp ).id(), std::nullopt };
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const item_location plank = game_menus::inv::titled_filter_menu(
    [&]( const item_location & loc ) {
        return lifetime && context && can_use_pit_plank( you, here, loc );
    }, you, _( "Use which plank to cover the pit?" ), pickup_range,
    _( "You have no usable plank nearby." ) );
    if( lifetime && context && plank && you.pos_abs() == choice.origin ) {
        choice.plank = capture_item_source( you, plank );
        submit_terrain_examine( you, here, choice );
    }
}

/**
 * Prompt removing the 2x4 placed across the pit
 */
void iexamine::pit_covered( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const terrain_examine_selection choice{ terrain_examine_action::uncover_pit, you.pos_abs(),
                                            here.get_abs( examp ), here.ter( examp ).id(), std::nullopt };
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    if( !query_yn( _( "Remove cover?" ) ) ) {
        return;
    }
    if( lifetime && context && you.pos_abs() == choice.origin ) {
        submit_terrain_examine( you, here, choice );
    }
}

void iexamine::thin_ice( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const trap &tr = here.tr_at( examp );
    if( !you.knows_trap( examp ) ) {
        you.add_msg_if_player( m_warning, _( "The ice looks thin and won't support your weight." ) );
        you.add_known_trap( examp, tr );
    } else {
        you.add_msg_if_player( m_info, _( "The ice here is thin." ) );
    }
}



static void submit_safe_interaction( Character &who, map &here, const safe_interaction &choice )
{
    if( !who.is_avatar() || !cata_mp::client_safe_interaction( choice ) ) {
        execute_safe_interaction( who, here, choice, activity_execution::local );
    }
}

void iexamine::safe( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const bool has_tool = has_safecracking_tool( you );
    const safe_interaction choice{ has_tool ? safe_action::crack : safe_action::guess,
                                   you.pos_abs(), here.get_abs( examp ), here.furn( examp ).id() };
    if( !has_tool ) {
        submit_safe_interaction( you, here, choice );
        return;
    }

    if( you.is_deaf() ) {
        you.add_msg_if_player( m_info, _( "You can't crack a safe while deaf!" ) );
        return;
    }
    if( !can_hear_safe_lock( you ) ) {
        you.add_msg_if_player( m_info, _( "You can't crack a safe while listening to music!" ) );
        return;
    }
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    if( query_yn( _( "Attempt to crack the safe?" ) ) && lifetime && context &&
        you.pos_abs() == choice.origin ) {
        submit_safe_interaction( you, here, choice );
    }
}

/**
 * Attempt to "hack" the gunsafe's electronic lock and open it.
 */
void iexamine::gunsafe_el( Character &you, const tripoint_bub_ms &examp )
{
    if( query_yn( _( "Attempt to hack this safe?" ) ) ) {
        try_start_hacking( you, examp );
    }
}

/**
 * Checks whether PC has a crowbar then calls iuse.crowbar.
 */
void iexamine::locked_object( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    item &best_prying = you.best_item_with_quality( qual_PRY );
    item &best_lockpick = you.best_item_with_quality( qual_LOCKPICK );
    optional_vpart_position veh = here.veh_at( examp );
    int locked_part = -1;

    // Check if the locked thing is a lockable door part.
    if( veh ) {
        std::vector<vehicle_part *> parts_at_target = veh->vehicle().get_parts_at(
                    &here, examp, "LOCKABLE_DOOR", part_status_flag::available );
        if( !parts_at_target.empty() ) {
            locked_part = veh->vehicle().next_part_to_unlock(
                              veh->vehicle().index_of_part( parts_at_target.front() ) );
        }
    }

    const std::string target_name = here.has_furn( examp ) ? here.furnname( examp ) :
                                    locked_part >= 0 ? veh->vehicle().part( locked_part ).name() :
                                    here.tername( examp );
    const bool has_prying = !best_prying.is_null();
    const bool can_pick = ( here.has_flag( ter_furn_flag::TFLAG_PICKABLE, examp ) ||
                            locked_part >= 0 ) &&
                          ( !best_lockpick.is_null() || you.has_bionic( bio_lockpick ) );
    enum act {
        pick = 0,
        pry = 1,
        none = 2
    };
    int action = act::none;

    if( has_prying && can_pick ) {
        const int pry_has = best_prying.get_quality( qual_PRY );
        const int pry_req = here.has_furn( examp ) ?
                            here.furn( examp )->prying->prying_data().prying_level :
                            here.ter( examp )->prying->prying_data().prying_level;
        if( pry_has < pry_req ) {
            action = act::pick;
        } else {
            uilist amenu;
            amenu.text = string_format( _( "What to do with the %s?" ),
                                        target_name );
            amenu.addentry( 0, true, 'l', _( "Pick the lock" ) );
            amenu.addentry( 1, true, 'p', _( "Pry open" ) );
            amenu.query();
            if( amenu.ret < act::pick || amenu.ret > act::pry ) {
                return;
            }
            action = amenu.ret;
        }
    } else {
        action = has_prying ? act::pry : can_pick ? act::pick : act::none;
    }

    if( action == act::none ) {
        add_msg( m_info, _( "The %s is locked.  You could pry it open with the right tool…" ),
                 target_name );
        return;
    } else if( action == act::pry ) {
        //~ %1$s: terrain/furniture name, %2$s: prying tool name
        you.add_msg_if_player( _( "You attempt to pry open the %1$s using your %2$s…" ),
                               target_name, best_prying.tname() );
        if( you.is_avatar() && cata_mp::client_examine_pry(
                item_location( you, &best_prying ), here.get_abs( examp ) ) ) {
            return;
        }
        iuse::crowbar( &you, &best_prying, examp );
    } else if( action == act::pick ) {
        locked_object_pickable( you, examp );
    }
}

/**
* Checks whether PC has picklocks then calls pick_lock iuse function OR assigns ACT_LOCKPICK
*/
void iexamine::locked_object_pickable( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const optional_vpart_position veh = here.veh_at( examp );
    int locked_part = -1;

    if( veh ) {
        const std::vector<vehicle_part *> parts_at_target = veh->vehicle().get_parts_at(
                    &here, examp, "LOCKABLE_DOOR", part_status_flag::available );
        if( !parts_at_target.empty() ) {
            locked_part = veh->vehicle().next_part_to_unlock(
                              veh->vehicle().index_of_part( parts_at_target.front() ) );
        }
    }

    const std::string target_name = here.has_furn( examp ) ? here.furnname( examp ) :
                                    locked_part >= 0 ? veh->vehicle().part( locked_part ).name() : here.tername( examp );

    if( you.has_bionic( bio_lockpick ) ) {
        if( you.get_power_level() >= bio_lockpick->power_activate ) {
            const auto bio = you.find_bionic_by_type( bio_lockpick );
            const bionic_activation_choices choices{ here.get_abs( examp ) };
            if( bio && you.activate_bionic( **bio, false, nullptr, &choices ) ) {
                return;
            }
        } else {
            you.add_msg_if_player( m_info, _( "You don't have enough power to activate your %s." ),
                                   bio_lockpick->name );
        }
    }

    std::vector<item *> picklocks = you.items_with( [&you]( const item & it ) {
        // Don't include worn items such as hairpins
        if( !you.is_worn( it ) ) {
            return it.type->get_use( "PICK_LOCK" ) != nullptr;
        }
        return false;
    } );

    if( picklocks.empty() ) {
        add_msg( m_info, _( "The %s is locked.  If only you had something to pick its lock with…" ),
                 target_name );
        return;
    }

    // Sort by their picklock level.
    std::sort( picklocks.begin(), picklocks.end(), [&]( const item * a, const item * b ) {
        int a_quality = a->get_quality( qual_LOCKPICK );
        int b_quality = b->get_quality( qual_LOCKPICK );
        // Sort by durability to spend most broken item
        if( a_quality == b_quality ) {
            return a->damage() > b->damage();
        }
        return a_quality > b_quality;
    } );

    for( item *it : picklocks ) {
        int required_moves = lockpick_activity_actor::lockpicking_moves( item_location{you, it}, you );
        time_duration required_time = time_duration::from_turns( required_moves / you.get_speed() );
        const std::string time_string = colorize( to_string( required_time, true ), c_light_gray );
        std::string query = string_format( _( "Pick the lock of %1$s using your %2$s?" ),
                                           target_name, it->tname() );
        query += "\n";
        query += _( "Time to attempt: " );
        query += time_string;
        if( !query_yn( query ) ) {
            return;
        }
        const use_function *iuse_fn = it->type->get_use( "PICK_LOCK" );
        you.add_msg_if_player( _( "You attempt to pick the lock of %1$s using your %2$s…" ),
                               target_name, it->tname() );
        const ret_val<void> can_use = iuse_fn->can_call( you, *it, examp );
        if( can_use.success() ) {
            std::string method = "PICK_LOCK";
            if( you.is_avatar() && cata_mp::client_activate_item(
                    item_location( you, it ), method, here.get_abs( examp ) ) ) {
                return;
            }
            iuse_fn->call( &you, *it, examp );
            return;
        } else {
            you.add_msg_if_player( m_bad, can_use.str() );
        }
    }
}

void iexamine::bulletin_board( Character &you, const tripoint_bub_ms &examp )
{
    g->validate_camps();
    map &here = get_map();
    point_abs_omt omt( coords::project_to<coords::omt>( here.get_abs( examp ) ).xy() );
    std::optional<basecamp *> bcp = overmap_buffer.find_camp( omt );
    if( bcp ) {
        basecamp *temp_camp = *bcp;
        if( !temp_camp->allowed_access_by( you ) ) {
            if( !you.is_avatar() ) {
                return; // One day, NPCs may be able to use bulletin boards
            }
            // Checks the reality bubble for NPCs
            std::vector<shared_ptr_fast<npc>> nearby_npcs = overmap_buffer.get_npcs_near_player( HALF_MAPSIZE );
            bool unoccupied_camp = true;
            for( npc_ptr &some_guy : nearby_npcs ) {
                if( !some_guy ) {
                    continue;
                } else if( some_guy->get_faction()->id == temp_camp->get_owner() ) {
                    unoccupied_camp = false;
                }
            }
            if( unoccupied_camp &&
                query_yn( _( "There's nobody here to protect %s.  Do you want to claim ownership?" ),
                          temp_camp->camp_name() ) ) {
                bool plunder = query_yn(
                                   _( "Take whatever you can find from the stores?  This may anger %s and their allies." ),
                                   temp_camp->get_owner()->get_name() );
                temp_camp->handle_takeover_by( you.get_faction()->id, plunder );
                return;
            }
            you.add_msg_if_player( _( "You don't run this camp, the board is useless to you." ) );
            return;
        }

        temp_camp->validate_bb_pos( here.get_abs( examp ) );
        temp_camp->validate_assignees();
        temp_camp->validate_sort_points();
        temp_camp->scan_pseudo_items();

        const std::string title = "Base Missions";
        mission_data mission_key;
        temp_camp->set_by_radio( false );
        temp_camp->get_available_missions( mission_key, here );
        if( talk_function::display_and_choose_opts( mission_key, temp_camp->camp_omt_pos(),
                "FACTION_CAMP", title ) ) {
            temp_camp->handle_mission( mission_key.cur_key.id );
        }
    } else {
        you.add_msg_if_player( _( "This bulletin board is not inside a camp." ) );
    }
}

/**
 * Spawn 1d4 wyrms and sink pedestal into ground.
 */
void iexamine::pedestal_wyrm( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    map_stack items = here.i_at( examp );
    if( !items.empty() ) {
        if( items.only_item().typeId() == itype_petrified_eye &&
            query_yn( _( "Remove the petrified eye from the pedestal?" ) ) ) {
            here.i_clear( examp );

            item eye( itype_petrified_eye );
            you.i_add_or_drop( eye );

            // Send in a few wyrms to start things off.
            get_event_bus().send<event_type::awakes_dark_wyrms>();
            for( const tripoint_bub_ms &p : here.points_on_zlevel() ) {
                if( here.ter( p ) == ter_t_orifice ) {
                    g->place_critter_around( mon_dark_wyrm, p, 1 );
                }
            }

            sounds::sound( examp, 80, sounds::sound_t::combat, _( "an ominous grinding noise…" ), true,
                           "misc", "stones_grinding" );
            add_msg( _( "The pedestal sinks into the ground…" ) );
            here.ter_set( examp, ter_t_rock_floor );
            get_timed_events().add( timed_event_type::SPAWN_WYRMS,
                                    calendar::turn + rng( 30_seconds, 60_seconds ) );
        } else {
            none( you, examp );
            add_msg( _( "You decided to leave the petrified eye on the pedestal…" ) );
            return;
        }
    }
}

/**
 * Put petrified eye on pedestal causing it to sink into ground and open temple.
 */
void iexamine::pedestal_temple( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    map_stack items = here.i_at( examp );
    if( !items.empty() && items.only_item().typeId() == itype_petrified_eye ) {
        add_msg( _( "The pedestal sinks into the ground…" ) );
        here.ter_set( examp, ter_t_dirt );
        here.i_clear( examp );
        get_timed_events().add( timed_event_type::TEMPLE_OPEN, calendar::turn + 10_seconds );
    } else if( you.has_amount( itype_petrified_eye, 1 ) &&
               query_yn( _( "Place your petrified eye on the pedestal?" ) ) ) {
        you.use_amount( itype_petrified_eye, 1 );
        add_msg( _( "The pedestal sinks into the ground…" ) );
        here.ter_set( examp, ter_t_dirt );
        get_timed_events().add( timed_event_type::TEMPLE_OPEN, calendar::turn + 10_seconds );
    } else {
        add_msg( _( "This pedestal is engraved in eye-shaped diagrams, and has a "
                    "large semi-spherical indentation at the top." ) );
    }
}

/**
 * Unlock/open door or attempt to peek through peephole.
 */
void iexamine::door_peephole( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    if( here.is_outside( you.pos_bub() ) ) {
        // if door is a locked type attempt to open
        if( here.has_flag( ter_furn_flag::TFLAG_OPENCLOSE_INSIDE, examp ) ) {
            locked_object( you, examp );
        } else {
            you.add_msg_if_player( _( "You cannot look through the peephole from the outside." ) );
        }

        return;
    }

    // Peek through the peephole, or open the door.
    const int choice = uilist( _( "Do what with the door?" ), {
        _( "Peek through peephole." ),
        _( "Open door." )
    } );
    if( choice == 0 ) {
        // Peek
        g->peek( examp );
        you.add_msg_if_player( _( "You peek through the peephole." ) );
    } else if( choice == 1 ) {
        here.open_door( you, examp, true, false );
        you.add_msg_if_player( _( "You open the door." ) );
    } else {
        you.add_msg_if_player( _( "Never mind." ) );
    }
}

void iexamine::fswitch( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    if( !query_yn( _( "Flip the %s?" ), here.tername( examp ) ) ) {
        none( you, examp );
        return;
    }
    const ter_id &terid = here.ter( examp );
    you.mod_moves( -to_moves<int>( 1_seconds ) );
    tripoint_bub_ms tmp;
    tmp.z() = examp.z();
    for( tmp.y() = examp.y(); tmp.y() <= examp.y() + 5; tmp.y()++ ) {
        for( tmp.x() = 0; tmp.x() < MAPSIZE_X; tmp.x()++ ) {
            const ter_id &nearby_ter = here.ter( tmp );
            if( terid == ter_t_switch_rg ) {
                if( nearby_ter == ter_t_rock_red ) {
                    here.ter_set( tmp, ter_t_floor_red );
                } else if( nearby_ter == ter_t_floor_red ) {
                    here.ter_set( tmp, ter_t_rock_red );
                } else if( nearby_ter == ter_t_rock_green ) {
                    here.ter_set( tmp, ter_t_floor_green );
                } else if( nearby_ter == ter_t_floor_green ) {
                    here.ter_set( tmp, ter_t_rock_green );
                }
            } else if( terid == ter_t_switch_gb ) {
                if( nearby_ter == ter_t_rock_blue ) {
                    here.ter_set( tmp, ter_t_floor_blue );
                } else if( nearby_ter == ter_t_floor_blue ) {
                    here.ter_set( tmp, ter_t_rock_blue );
                } else if( nearby_ter == ter_t_rock_green ) {
                    here.ter_set( tmp, ter_t_floor_green );
                } else if( nearby_ter == ter_t_floor_green ) {
                    here.ter_set( tmp, ter_t_rock_green );
                }
            } else if( terid == ter_t_switch_rb ) {
                if( nearby_ter == ter_t_rock_blue ) {
                    here.ter_set( tmp, ter_t_floor_blue );
                } else if( nearby_ter == ter_t_floor_blue ) {
                    here.ter_set( tmp, ter_t_rock_blue );
                } else if( nearby_ter == ter_t_rock_red ) {
                    here.ter_set( tmp, ter_t_floor_red );
                } else if( nearby_ter == ter_t_floor_red ) {
                    here.ter_set( tmp, ter_t_rock_red );
                }
            } else if( terid == ter_t_switch_even ) {
                if( ( tmp.y() - examp.y() ) % 2 == 1 ) {
                    if( nearby_ter == ter_t_rock_red ) {
                        here.ter_set( tmp, ter_t_floor_red );
                    } else if( nearby_ter == ter_t_floor_red ) {
                        here.ter_set( tmp, ter_t_rock_red );
                    } else if( nearby_ter == ter_t_rock_green ) {
                        here.ter_set( tmp, ter_t_floor_green );
                    } else if( nearby_ter == ter_t_floor_green ) {
                        here.ter_set( tmp, ter_t_rock_green );
                    } else if( nearby_ter == ter_t_rock_blue ) {
                        here.ter_set( tmp, ter_t_floor_blue );
                    } else if( nearby_ter == ter_t_floor_blue ) {
                        here.ter_set( tmp, ter_t_rock_blue );
                    }
                }
            }
        }
    }
    add_msg( m_warning, _( "You hear the rumble of rock shifting." ) );
    get_timed_events().add( timed_event_type::TEMPLE_SPAWN, calendar::turn + 3_turns );
}

namespace
{
void submit_farming_choice( Character &who, const farming_command &command )
{
    if( who.is_avatar() && cata_mp::client_farming_command( command ) ) {
        return;
    }
    execute_farming_command( who, command );
}
} // namespace

/**
 * If it's winter: show msg and return true. Otherwise return false
 */
static bool dead_plant( bool flower, Character &you, const tripoint_bub_ms &examp )
{
    if( season_of_year( calendar::turn ) == WINTER ) {
        if( flower ) {
            you.add_msg_if_player( m_info, _( "This flower is dead.  You can't get it." ) );
        } else {
            you.add_msg_if_player( m_info, _( "This plant is dead.  You can't get it." ) );
        }

        iexamine::none( you, examp );
        return true;
    }

    return false;
}

/**
 * Helper method to see if player has traits, hunger and mouthwear for drinking nectar.
 */
bool iexamine_helper::can_drink_nectar( const Character &you )
{
    return ( you.has_active_mutation( trait_PROBOSCIS )  ||
             you.has_active_mutation( trait_BEAK_HUM ) ) &&
           ( you.get_hunger() > 0 ) && ( !you.wearing_something_on( bodypart_id( "mouth" ) ) );
}

/**
 * Consume Nectar. -15 hunger.
 */
bool iexamine_helper::drink_nectar( Character &you )
{
    if( can_drink_nectar( you ) ) {
        you.add_msg_if_player( _( "You drink some nectar." ) );
        item nectar( itype_nectar, calendar::turn, 1 );
        you.assign_activity( consume_activity_actor( nectar ) );
        return true;
    }

    return false;
}

/**
 * Spawn an item after harvesting the plant
 */
void iexamine_helper::handle_harvest( Character &you, const itype_id &itemid, bool force_drop )
{
    map &here = get_map();
    item value( itemid );
    if( value.has_temperature() ) {
        value.set_item_temperature( get_weather().get_temperature( you.pos_bub() ) );
    }
    item &stored = here.add_item_unprocessed( you.pos_bub(), std::move( value ) );
    if( !stored.is_null() ) {
        handle_harvest( you, item_location( map_cursor( you.pos_abs() ), &stored ), force_drop );
    }
}

void iexamine_helper::handle_harvest( Character &you, item_location source, bool force_drop )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const tripoint_abs_ms origin = you.pos_abs();
    const auto generation = you.activity.identity_generation();
    if( !source || source.where() != item_location::type::map || source.has_parent() ||
        source.pos_abs() != origin ) {
        return;
    }
    bool self_care = false;
    if( const npc *worker = you.as_npc() ) {
        self_care = worker->get_committed_goal() == "eat_food" ||
                    worker->get_committed_goal() == "drink_water";
    }
    if( self_care && source->is_food() &&
        ( you.get_hunger() > 0 || you.has_calorie_deficit() ) &&
        you.will_eat( *source ).success() ) {
        // Consume a detached native value after debiting the published item.
        // Reentrant eating cannot rediscover the same portion on the ground.
        item portion( *source );
        const time_duration cost = you.get_consume_time( portion );
        source.remove_item();
        const trinary result = you.consume( portion );
        source = item_location();
        if( context && result != trinary::ALL ) {
            item &rest = here.add_item_unprocessed( here.get_bub( origin ), std::move( portion ) );
            if( !rest.is_null() ) {
                source = item_location( map_cursor( origin ), &rest );
            }
        }
        if( !lifetime || !context ) {
            return;
        }
        if( result != trinary::NONE ) {
            you.mod_moves( -to_moves<int>( cost ) );
        }
    }
    if( !lifetime || !context || !source || you.pos_abs() != origin ||
        you.activity.identity_generation() != generation ) {
        return;
    }
    const std::string name = source->tname();
    const bool collect = !force_drop && you.can_pickVolume( *source, true ) &&
                         you.can_pickWeight( *source, self_care );
    if( collect ) {
        you.transfer_item_to_inventory( source, item( *source ) );
    }
    if( !lifetime || !context || you.pos_abs() != origin ||
        you.activity.identity_generation() != generation ) {
        return;
    }
    if( source ) {
        here.settle_item_on_ground( here.get_bub( origin ), source, &you );
        if( lifetime && context ) {
            you.add_msg_if_player( _( "You harvest and drop: %s." ), name );
            you.add_msg_if_npc( _( "<npcname> harvests and drops: %s." ), name );
        }
    } else {
        you.add_msg_if_player( _( "You harvest: %s." ), name );
        you.add_msg_if_npc( _( "<npcname> harvests: %s." ), name );
    }
}

namespace
{
void query_special_flower( Character &who, const tripoint_bub_ms &position )
{
    map &here = get_map();
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    farming_command choice = capture_farming_command( who, here, here.get_abs( position ),
                             farming_action::flower );
    const furn_t &flower = here.furn( position ).obj();
    const bool marloss = flower.has_examine( iexamine::flower_marloss );
    const bool dahlia = flower.has_examine( iexamine::flower_dahlia );
    if( !marloss && dead_plant( true, who, position ) ) {
        return;
    }
    if( marloss && season_of_year( calendar::turn ) == WINTER ) {
        who.add_msg_if_player( m_info, _( "This flower is still alive, despite the harsh conditions…" ) );
    }
    const std::string name = here.furnname( position );
    choice.drink = !flower.has_examine( iexamine::flower_cactus ) &&
                   iexamine_helper::can_drink_nectar( who );
    if( choice.drink && !dahlia && who.is_avatar() &&
        !query_yn( marloss ? _( "You feel out of place as you explore the %s. Drink?" ) :
                   _( "You feel woozy as you explore the %s. Drink?" ), name ) ) {
        return;
    }
    if( !lifetime || !context ) {
        return;
    }
    if( dahlia && choice.drink ) {
        choice.pick = false;
    } else if( who.is_avatar() ) {
        const bool missing_roots = dahlia && !who.has_quality( qual_DIG ) &&
                                   !who.has_trait( trait_BURROW ) && !who.has_trait( trait_BURROWLARGE );
        choice.pick = query_yn( missing_roots ?
                                _( "You don't have a digging tool to dig up roots.  Pick %s anyway?" ) :
                                _( "Pick %s?" ), name );
    }
    if( !lifetime || !context ) {
        return;
    }
    if( choice.pick || choice.drink ) {
        submit_farming_choice( who, choice );
    } else {
        iexamine::none( who, position );
    }
}
} // namespace

void iexamine::flower_poppy( Character &you, const tripoint_bub_ms &examp )
{
    query_special_flower( you, examp );
}

void iexamine::flower_cactus( Character &you, const tripoint_bub_ms &examp )
{
    query_special_flower( you, examp );
}

void iexamine::flower_dahlia( Character &you, const tripoint_bub_ms &examp )
{
    query_special_flower( you, examp );
}

static bool query_pick( Character &who, const tripoint_bub_ms &target )
{
    if( !who.is_avatar() ) {
        // NPCs already decided to harvest via address_needs.
        return true;
    }

    map &here = get_map();
    const harvest_id harvest = here.get_harvest( target );
    if( harvest.is_null() || harvest->empty() ) {
        who.add_msg_if_player( m_info,
                               _( "Nothing can be harvested from this plant in current season." ) );
        iexamine::none( who, target );
        return false;
    }

    std::string query_string;
    if( here.has_furn( target ) ) {
        query_string = string_format( _( "Pick %1$s?" ), here.furnname( target ) );
    } else {
        query_string = string_format( _( "Pick %1$s?" ), here.tername( target ) );
    }

    if( who.is_avatar() && !query_yn( query_string ) ) {
        iexamine::none( who, target );
        return false;
    }

    return true;
}

namespace
{
void query_gathering( Character &who, const tripoint_bub_ms &position, bool automatic )
{
    map &here = get_map();
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const farming_command choice = capture_farming_command( who, here,
                                   here.get_abs( position ), farming_action::gather );
    if( !automatic && !query_pick( who, position ) ) {
        return;
    }
    if( lifetime && context ) {
        submit_farming_choice( who, choice );
    }
}
} // namespace

void iexamine::harvest_furn_nectar( Character &you, const tripoint_bub_ms &examp )
{
    bool auto_forage = get_option<bool>( "AUTO_FEATURES" ) &&
                       get_option<std::string>( "AUTO_FORAGING" ) == "all";
    query_gathering( you, examp, auto_forage );
}

void iexamine::harvest_furn( Character &you, const tripoint_bub_ms &examp )
{
    bool auto_forage = get_option<bool>( "AUTO_FEATURES" ) &&
                       get_option<std::string>( "AUTO_FORAGING" ) == "all";
    query_gathering( you, examp, auto_forage );
}

void iexamine::harvest_ter_nectar( Character &you, const tripoint_bub_ms &examp )
{
    bool auto_forage = get_option<bool>( "AUTO_FEATURES" ) &&
                       ( get_option<std::string>( "AUTO_FORAGING" ) == "all" ||
                         get_option<std::string>( "AUTO_FORAGING" ) == "bushes" ||
                         get_option<std::string>( "AUTO_FORAGING" ) == "trees" );
    query_gathering( you, examp, auto_forage );
}

void iexamine::harvest_ter( Character &you, const tripoint_bub_ms &examp )
{
    bool auto_forage = get_option<bool>( "AUTO_FEATURES" ) &&
                       ( get_option<std::string>( "AUTO_FORAGING" ) == "all" ||
                         get_option<std::string>( "AUTO_FORAGING" ) == "trees" );
    query_gathering( you, examp, auto_forage );
}

void iexamine::fertilize_terrain( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    if( !here.ter( examp )->terrain_growth ) {
        return;
    }
    if( !cata_mp::is_client_mode() ) {
        const auto generation = you.activity.identity_generation();
        const ret_val<void> eligible = multi_farm_activity_actor::can_fertilize( you, examp );
        if( !lifetime || !context || you.activity.identity_generation() != generation ) {
            return;
        }
        if( !eligible.success() ) {
            you.add_msg_if_player( m_info, eligible.str() );
            return;
        }
    }
    farming_command choice = capture_farming_command( you, here, here.get_abs( examp ),
                             farming_action::fertilize );
    choice.material = choose_fertilizer( you, here.ter( examp )->name(), true );
    if( lifetime && context && !choice.material.is_empty() ) {
        submit_farming_choice( you, choice );
    }
}

void iexamine::harvested_plant( Character &you, const tripoint_bub_ms &examp )
{
    you.add_msg_if_player( m_info, _( "Nothing can be harvested from this plant in current season." ) );
    iexamine::none( you, examp );
}

void iexamine::flower_marloss( Character &you, const tripoint_bub_ms &examp )
{
    query_special_flower( you, examp );
}

/**
 * Remove furniture. Add spore effect.
 */
void iexamine::fungus( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    submit_farming_choice( you, capture_farming_command( you, here, here.get_abs( examp ),
                           farming_action::fungus ) );
}

/**
 *  Make lists of unique seed types and names for the menu(no multiple hemp seeds etc)
 */
std::vector<seed_tuple> iexamine::get_seed_entries( const std::vector<item_location> &seed_inv )
{
    std::map<itype_id, int> seed_map;
    for( const item_location &seed : seed_inv ) {
        seed_map[seed->typeId()] += ( seed->charges > 0 ? seed->charges : 1 );
    }

    std::vector<seed_tuple> seed_entries;
    seed_entries.reserve( seed_map.size() );
    for( const auto &pr : seed_map ) {
        seed_entries.emplace_back(
            pr.first, item::nname( pr.first, pr.second ), pr.second );
    }

    // Sort by name
    std::sort( seed_entries.begin(), seed_entries.end(),
    []( const seed_tuple & l, const seed_tuple & r ) {
        return std::get<1>( l ).compare( std::get<1>( r ) ) < 0;
    } );

    return seed_entries;
}

/**
 *  Choose seed for planting
 */
int iexamine::query_seed( const std::vector<seed_tuple> &seed_entries )
{
    uilist smenu;

    smenu.text = _( "Use which seed?" );
    int count = 0;
    for( const auto &entry : seed_entries ) {
        const std::string &seed_name = std::get<1>( entry );
        int seed_count = std::get<2>( entry );

        std::string format = seed_count > 0 ? "%s (%d)" : "%s";

        smenu.addentry( count++, true, MENU_AUTOASSIGN, format.c_str(),
                        seed_name, seed_count );
    }

    smenu.query();

    if( smenu.ret >= 0 ) {
        return smenu.ret;
    } else {
        return seed_entries.size();
    }
}

/**
 *  Actual planting of selected seed
 */
void iexamine::plant_seed( Character &you, const tripoint_bub_ms &examp, const itype_id &seed_id )
{
    plant_seed_activity_actor actor( get_map().get_abs( examp ), seed_id, 30_seconds );
    you.assign_activity( actor );
}

/**
 * If it's warm enough, pick one of the player's seeds and plant it.
 */
void iexamine::dirtmound( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    farming_command choice = capture_farming_command( you, here, here.get_abs( examp ),
                             farming_action::plant );
    std::vector<item_location> seed_inv = you.cache_get_items_with( "is_seed", &item::is_seed );
    seed_inv.erase( std::remove_if( seed_inv.begin(), seed_inv.end(),
    []( const item_location & value ) {
        return !value || !craft_reservation::usable_by_automation( *value );
    } ), seed_inv.end() );
    if( seed_inv.empty() ) {
        add_msg( m_info, _( "You have no seeds to plant." ) );
        return;
    }
    if( !here.i_at( examp ).empty() ) {
        add_msg( _( "Something's lying there…" ) );
        return;
    }

    auto seed_entries = get_seed_entries( seed_inv );

    int seed_index = query_seed( seed_entries );
    if( !lifetime || !context ) {
        return;
    }

    // Did we cancel?
    if( seed_index < 0 || seed_index >= static_cast<int>( seed_entries.size() ) ) {
        add_msg( _( "You saved your seeds for later." ) );
        return;
    }
    const itype_id &seed_id = std::get<0>( seed_entries[seed_index] );

    ret_val<void>can_plant = warm_enough_to_plant( examp, seed_id );
    if( !can_plant.success() ) {
        you.add_msg_if_player( m_info, can_plant.c_str() );
        return;
    }

    if( !here.has_flag_ter_or_furn( seed_id->seed->required_terrain_flag, examp ) ) {
        add_msg( _( "This type of seed can not be planted in this location." ) );
        return;
    }

    choice.material = seed_id;
    submit_farming_choice( you, choice );
}

/**
 * Items that appear when a generic plant is harvested. Seed @ref islot_seed.
 * @param type The seed type, must have a @ref itype::seed slot.
 * @param plant_count Number of fruits to generate. For charge-based items, this
 *     specifies multiples of the default charge.
 * @param seed_count Number of seeds to generate.
 * @param byproducts If true, byproducts (like straw, withered plants, see
 * @ref islot_seed::byproducts) are included.
 */
std::list<item> iexamine::get_harvest_items( const itype &type, const int plant_count,
        const int seed_count, const bool byproducts )
{
    std::list<item> result;
    if( !type.seed ) {
        return result;
    }
    const islot_seed &seed_data = *type.seed;
    // This is a temporary measure, itype should instead provide appropriate accessors
    // to expose data about the seed item to allow harvesting to function.
    const itype_id &seed_type = type.get_id();

    const auto add = [&]( const itype_id & id, const int count ) {
        item new_item( id, calendar::turn );
        if( count > 0 ) {
            result.insert( result.begin(), count, new_item );
        }
    };

    if( seed_data.spawn_seeds ) {
        add( seed_type, seed_count );
    }

    add( seed_data.fruit_id, plant_count );

    if( byproducts ) {
        for( const itype_id &b : seed_data.byproducts ) {
            add( b, 1 );
        }
    }

    return result;
}

namespace
{
bool reachable_crop( const Character &who, map &here, const tripoint_bub_ms &position )
{
    return !cata_mp::is_client_mode() && !who.is_dead_state() && here.inbounds( position ) &&
           position.z() == who.pos_bub().z() && rl_dist( who.pos_bub(), position ) <= 1;
}
} // namespace

// Cleaning up plants that have decayed and overgrown.
void iexamine::clear_overgrown( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    if( you.is_avatar() && cata_mp::is_client_mode() ) {
        cata_mp::client_farming_command( capture_farming_command( you, here,
                                         here.get_abs( examp ), farming_action::clear ) );
        return;
    }
    if( !reachable_crop( you, here, examp ) ) {
        return;
    }
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const auto generation = you.activity.identity_generation();
    here.grow_plant( examp, &you );
    if( !lifetime || !context || you.activity.identity_generation() != generation ||
        !is_plant_overgrown( here, examp ) || !here.furn( examp )->plant ) {
        return;
    }
    const furn_str_id base = here.furn( examp )->plant->base;
    here.i_clear( examp );
    here.furn_set( examp, base );
    player_activity act( ACT_HARVEST, to_moves<int>( 60_seconds ) );
    act.set_execution( activity_execution::authoritative );
    you.assign_activity( act );
    if( lifetime && context ) {
        you.add_msg_if_player( m_neutral,
                               _( "You pull up what's left of the planted crop and trample the rest." ) );
    }
}

// Only harvest, used for autoforaging.
void iexamine::harvest_plant_ex( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    if( you.is_avatar() && cata_mp::is_client_mode() ) {
        cata_mp::client_farming_command( capture_farming_command( you, here,
                                         here.get_abs( examp ), farming_action::harvest ) );
        return;
    }
    if( !reachable_crop( you, here, examp ) ) {
        return;
    }
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const auto generation = you.activity.identity_generation();
    here.grow_plant( examp, &you );
    if( lifetime && context && you.activity.identity_generation() == generation &&
        is_plant_harvestable( here, examp ) ) {
        harvest_plant( you, examp, false );
    }
}

void iexamine::harvest_plant( Character &you, const tripoint_bub_ms &examp, bool from_activity )
{
    map &here = get_map();
    if( !reachable_crop( you, here, examp ) || !here.furn( examp )->plant ) {
        return;
    }
    item *seed = get_seed_at( here, examp );
    if( !seed ) {
        return;
    }
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const tripoint_abs_ms plot = here.get_abs( examp );
    const tripoint_abs_ms origin = you.pos_abs();
    const item seed_snapshot = *seed;
    const itype_id seed_type = seed_snapshot.typeId();
    const furn_str_id furniture = here.furn( examp ).id();
    if( seed_type == itype_fungal_seeds || seed_type == itype_marloss_seed ) {
        const bool marloss = seed_type == itype_marloss_seed;
        const std::string name = here.furnname( examp );
        // Claim the crop before either global events or spore effects run scripts.
        here.i_clear( examp );
        here.furn_set( examp, furn_str_id::NULL_ID() );
        you.mod_moves( -to_moves<int>( 1_seconds ) * 0.5 );
        you.add_msg_if_player( _( "The %s crumbles into spores!" ), name );
        get_event_bus().send<event_type::character_harvests_plant>(
            you.getID(), plot.raw(), seed_type, furniture, 0, 0 );
        if( !lifetime || !context ) {
            return;
        }
        fungal_effects().create_spores( examp, &you );
        if( !marloss || !lifetime || !context || get_seed_at( here, examp ) ||
            here.has_furn( examp ) ) {
            return;
        }
        if( you.has_trait( trait_M_DEPENDENT ) && ( you.get_kcal_percent() < 0.8f ||
                you.get_thirst() > 300 ) ) {
            here.ter_set( examp, ter_t_marloss );
            you.add_msg_if_player( m_info,
                                   _( "We have altered this unit's configuration to extract and provide local nutriment.  The Mycus provides." ) );
        } else if( you.has_trait( trait_M_DEFENDER ) || ( ( you.has_trait( trait_M_SPORES ) ||
                   you.has_trait( trait_M_FERTILE ) ) && one_in( 2 ) ) ) {
            g->place_critter_at( mon_fungal_blossom, examp );
            if( lifetime && context ) {
                you.add_msg_if_player( m_info,
                                       _( "The seed blooms forth!  We have brought true beauty to this world." ) );
            }
        } else if( you.has_trait( trait_THRESH_MYCUS ) || one_in( 4 ) ) {
            here.furn_set( examp, furn_f_flower_marloss );
            you.add_msg_if_player( m_info, _( "The seed blossoms rather rapidly…" ) );
        } else {
            here.furn_set( examp, furn_f_flower_fungal );
            you.add_msg_if_player( m_info, _( "The seed blossoms into a flower-looking fungus." ) );
        }
        return;
    }

    const temp_crafting_inventory &crafting_inv = you.crafting_inventory();
    if( seed_snapshot.has_flag( flag_CUT_HARVEST ) && !crafting_inv.has_quality( qual_GRASS_CUT ) ) {
        you.add_msg_if_player( m_info, _( "You will need a grass-cutting tool to harvest this plant." ) );
        return;
    }
    const int skill_level = round( you.get_skill_level( skill_survival ) );
    ///\EFFECT_SURVIVAL increases number of plants harvested from a seed
    int plant_count = rng( skill_level / 2, skill_level );
    const auto &fp = here.furn( examp )->plant;
    plant_count *= fp->harvest_multiplier * ::get_option<float>( "CROP_HARVEST_MULTIPLIER" );
    plant_count = std::max( plant_count, 1 );
    const int seed_count = std::max( 1, rng( plant_count / 4, plant_count / 2 ) );
    const int stage_idx = get_plant_current_stage_idx_from_effective( here, examp );
    const std::string stage = stage_idx >= 0 ?
                              seed_type->seed->get_growth_stages()[stage_idx].first.str() : "";
    const furn_str_id base = fp->base;
    here.i_clear( examp );
    here.furn_set( examp, base );

    // Materialize the entire native yield before any callback. A callback that
    // removes the farmer or changes their activity cannot lose the remaining yield.
    std::vector<item_location> products;
    for( item &value : get_harvest_items( seed_type.obj(), plant_count, seed_count, true ) ) {
        if( from_activity ) {
            activity_handlers::mark_activity_item( value, you );
        }
        item &stored = here.add_item_unprocessed( here.get_bub( origin ), std::move( value ) );
        if( !stored.is_null() ) {
            products.emplace_back( map_cursor( origin ), &stored );
            if( from_activity ) {
                activity_handlers::reserve_activity_item( you, products.back() );
            }
        }
    }
    player_activity work( ACT_HARVEST, to_moves<int>( 60_seconds ) );
    work.set_execution( activity_execution::authoritative );
    you.assign_activity( work );
    if( !lifetime || !context ) {
        return;
    }
    const auto generation = you.activity.identity_generation();
    you.add_msg_if_player( m_neutral, _( "You harvest the plant." ) );
    get_event_bus().send<event_type::character_harvests_plant>(
        you.getID(), plot.raw(), seed_type, furniture, plant_count, seed_count );
    if( !lifetime || !context ) {
        return;
    }
    run_plant_lifecycle_event( "harvest", you, here, here.get_bub( plot ), seed_snapshot,
    stage, stage, {}, {
        { "plant_count", static_cast<double>( plant_count ) },
        { "seed_count", static_cast<double>( seed_count ) },
        { "actor_is_npc", you.is_npc() ? 1.0 : 0.0 }
    }, furniture );
    for( const item_location &product : products ) {
        if( !lifetime || !context || you.pos_abs() != origin ||
            you.activity.identity_generation() != generation ) {
            return;
        }
        if( product ) {
            item_location placed;
            here.transfer_item_or_charges( here.get_bub( origin ), product, item( *product ),
                                           you, 1, true, &placed );
            if( from_activity && lifetime && context && placed ) {
                activity_handlers::reserve_activity_item( you, placed );
            }
        }
    }
}

ret_val<void> iexamine::can_fertilize( Character &you, const tripoint_bub_ms &tile,
                                       const itype_id &fertilizer )
{
    const character_action_guard lifetime( you );
    const auto context = get_map().get_context_reference();
    if( !fertilizer.is_valid() || !fertilizer->has_flag( flag_FERTILIZER ) ) {
        return ret_val<void>::make_failure( _( "That item is not fertilizer." ) );
    }
    ret_val<void> fertilize_check = multi_farm_activity_actor::can_fertilize( you, tile );
    if( !lifetime || !context ) {
        return ret_val<void>::make_failure( _( "The plant is no longer available." ) );
    }
    if( !fertilize_check.success() ) {
        return fertilize_check;
    }
    const bool has_fertilizer = fertilizer->count_by_charges() ?
                                you.has_charges( fertilizer, 1 ) :
                                you.has_amount( fertilizer, 1 );
    if( !has_fertilizer ) {
        return ret_val<void>::make_failure(
                   _( "Tried to fertilize with %s, but player doesn't have any." ),
                   fertilizer.c_str() );
    }

    return ret_val<void>::make_success();
}

void iexamine::fertilize_plant( Character &you, const tripoint_bub_ms &tile,
                                const itype_id &fertilizer )
{
    const character_action_guard lifetime( you );
    const auto context = get_map().get_context_reference();
    const auto generation = you.activity.identity_generation();
    ret_val<void> can_fert = can_fertilize( you, tile, fertilizer );
    if( !lifetime || !context || you.activity.identity_generation() != generation ) {
        return;
    }
    if( !can_fert.success() ) {
        you.add_msg_if_player( m_info, can_fert.str() );
        return;
    }

    you.assign_activity( fertilize_plant_activity_actor( 10_seconds, tile, fertilizer ) );
}

itype_id iexamine::choose_fertilizer( Character &you, const std::string &pname,
                                      bool ask_player )
{
    std::optional<itype_id> fertilizer_selected = multi_farm_activity_actor::query_fertilizer( you );

    std::vector<item_location> f_inv = you.cache_get_items_with( flag_FERTILIZER );
    if( !fertilizer_selected ) {
        return itype_id();
    }

    if( ask_player && !query_yn( _( "Fertilize the %s?" ), pname ) ) {
        return itype_id();
    }

    return *fertilizer_selected;

}
void iexamine::aggie_plant( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const auto generation = you.activity.identity_generation();
    if( !cata_mp::is_client_mode() ) {
        here.grow_plant( examp, &you );
    }
    if( !lifetime || !context || you.activity.identity_generation() != generation ) {
        return;
    }
    item *seed = get_seed_at( here, examp );
    if( !seed || !here.furn( examp )->plant ) {
        return;
    }
    const std::string pname = seed->get_plant_name();
    const bool can_harvest = is_plant_harvestable( here, examp );
    const bool can_fertilize = !is_plant_mature( here, examp ) &&
                               !is_plant_harvestable( here, examp ) &&
                               !is_plant_overgrown( here, examp ) && !is_plant_fertilized( *seed );
    const bool can_water = get_plant_max_water( here.furn( examp ).obj() ) > 0;
    farming_command choice = capture_farming_command( you, here, here.get_abs( examp ),
                             farming_action::harvest );
    uilist menu;
    menu.text = string_format( _( "What to do with the %s?" ), pname );
    if( can_harvest ) {
        menu.addentry( 0, true, 'h', _( "Harvest" ) );
    }
    if( can_fertilize ) {
        menu.addentry( 1, true, 'f', _( "Fertilize" ) );
    }
    if( can_water ) {
        menu.addentry( 2, true, 'w', _( "Pour water" ) );
    }
    menu.addentry( 3, true, 'q', _( "Cancel" ) );
    menu.query();
    if( !lifetime || !context ) {
        return;
    }
    if( menu.ret == 0 && can_harvest ) {
        choice.action = farming_action::harvest;
    } else if( menu.ret == 1 && can_fertilize ) {
        choice.action = farming_action::fertilize;
        choice.material = choose_fertilizer( you, pname, true );
        if( !lifetime || !context || choice.material.is_empty() ) {
            return;
        }
    } else if( menu.ret == 2 && can_water ) {
        choice.action = farming_action::water;
    } else {
        return;
    }
    submit_farming_choice( you, choice );
}

int iexamine::get_plant_max_water( const furn_t &furn )
{
    if( furn.plant ) {
        if( furn.plant->max_water_storage > 0 ) {
            return furn.plant->max_water_storage;
        }
        if( !furn.plant->base.is_null() && furn.plant->base.is_valid() ) {
            // If base is explicitly set, look up the base furniture's capacity.
            const furn_t &base_furn = furn.plant->base.obj();
            return base_furn.plant ? base_furn.plant->max_water_storage : 0;
        }
    }
    return 0;
}

float iexamine::get_plant_water_consumption_multiplier( const furn_t &furn )
{
    if( !furn.plant ) {
        return 1.0f;
    }
    const float mult = furn.plant->water_consumption_multiplier;
    // A stage-specific non-default multiplier takes precedence.
    if( mult != 1.0f ) {
        return mult;
    }
    // Otherwise inherit from the base furniture, if any.
    if( !furn.plant->base.is_null() && furn.plant->base.is_valid() ) {
        const furn_t &base_furn = furn.plant->base.obj();
        if( base_furn.plant && base_furn.plant->water_consumption_multiplier > 0.0f ) {
            return base_furn.plant->water_consumption_multiplier;
        }
    }
    return 1.0f;
}

item *iexamine::get_seed_at( map &here, const tripoint_bub_ms &p )
{
    map_stack items = here.i_at( p );
    for( item &it : items ) {
        if( it.is_seed() ) {
            return &it;
        }
    }
    return nullptr;
}

item *iexamine::sync_and_get_seed_at( map &here, const tripoint_bub_ms &p )
{
    here.grow_plant( p );
    return get_seed_at( here, p );
}

bool iexamine::is_plant_fertilized( const item &seed )
{
    return static_cast<int>( seed.get_var( "seed_fertilized", 0.0 ) ) != 0;
}

void iexamine::set_plant_fertilized( item &seed, const bool fertilized )
{
    seed.set_var( "seed_fertilized", fertilized ? 1 : 0 );
}

int iexamine::get_plant_water( const item &seed )
{
    return static_cast<int>( seed.get_var( "seed_water", 0.0 ) );
}

void iexamine::set_plant_water( item &seed, int water )
{
    seed.set_var( "seed_water", std::max( 0, water ) );
}

int iexamine::get_seed_water_consumption( const item &seed )
{
    if( seed.type && seed.type->seed ) {
        return seed.type->seed->water_consumption;
    }
    return irrigation::DEFAULT_SEED_WATER_CONSUMPTION;
}

time_point iexamine::get_plant_last_water_check( const item &seed )
{
    return time_point::from_turn(
               static_cast<int>( seed.get_var( "seed_last_water_check", 0.0 ) ) );
}

void iexamine::set_plant_last_water_check( item &seed, const time_point &turn )
{
    seed.set_var( "seed_last_water_check", to_turn<int>( turn ) );
}

int iexamine::get_plant_effective_growth_turns( const item &seed )
{
    return static_cast<int>( seed.get_var( "seed_effective_growth_turns", 0.0 ) );
}

void iexamine::set_plant_effective_growth_turns( item &seed, int turns )
{
    seed.set_var( "seed_effective_growth_turns", std::max( 0, turns ) );
}

void iexamine::set_plant_effective_growth_time( item &seed, time_duration effective,
        float growth_multiplier, float crop_growth_speed )
{
    effective = std::max( 0_seconds, effective );
    set_plant_effective_growth_turns( seed, to_turns<int>( effective ) );
    if( growth_multiplier > 0.0f && crop_growth_speed > 0.0f ) {
        seed.set_birthday( calendar::turn - effective / ( growth_multiplier * crop_growth_speed ) );
    }
}

void iexamine::water_plant( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    if( !reachable_crop( you, here, examp ) ) {
        return;
    }
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const tool_activity_target plot = tool_activity_target::capture( here, here.get_abs( examp ) );
    const furn_t &furn = here.furn( examp ).obj();
    const int max_water = get_plant_max_water( furn );
    if( max_water <= 0 ) {
        you.add_msg_if_player( m_info, _( "This %s cannot hold water." ), furn.name() );
        return;
    }
    item *seed = get_seed_at( here, examp );
    if( !seed ) {
        you.add_msg_if_player( m_info, _( "There is no plant here to water." ) );
        return;
    }
    const item_source original = capture_item_source( you,
                                 item_location( map_cursor( plot.position ), seed ) );
    const int current_water = get_plant_water( *seed );
    if( current_water >= max_water ) {
        you.add_msg_if_player( m_info, _( "The %s is already fully watered." ),
                               seed->get_plant_name() );
        return;
    }
    const itype_id water_type = you.has_charges( itype_water_clean, 1,
                                craft_reservation::usable_by_automation ) ? itype_water_clean : itype_water;
    if( you.use_charges( water_type, 1, craft_reservation::usable_by_automation ).empty() ) {
        if( lifetime ) {
            you.add_msg_if_player( m_info, _( "You have no water to pour." ) );
        }
        return;
    }
    if( !lifetime || !context || !plot.matches( here ) ) {
        return;
    }
    item *watered = resolve_planted_seed( here, original );
    if( !watered ) {
        return;
    }
    if( !watered->has_var( "seed_last_water_check" ) ) {
        set_plant_last_water_check( *watered, calendar::turn );
    }
    set_plant_water( *watered, std::min( max_water,
                                         get_plant_water( *watered ) + irrigation::WATER_PER_POUR ) );
    const itype_id seed_type = watered->typeId();
    const int stage_idx = get_plant_current_stage_idx_from_effective( here,
                          here.get_bub( plot.position ) );
    const std::string stage = stage_idx >= 0 ?
                              seed_type->seed->get_growth_stages()[stage_idx].first.str() : "";
    you.add_msg_if_player( m_good, _( "You pour some water on the %s." ), watered->get_plant_name() );
    get_event_bus().send<event_type::character_waters_plant>(
        you.getID(), plot.position.raw(), seed_type, plot.furniture, irrigation::WATER_PER_POUR );
    if( !lifetime || !context || !plot.matches( here ) ) {
        return;
    }
    item *current = resolve_planted_seed( here, original );
    if( current && current->typeId() == seed_type ) {
        run_plant_lifecycle_event( "water", you, here, here.get_bub( plot.position ), *current,
        stage, stage, {},
        { { "water_added", static_cast<double>( irrigation::WATER_PER_POUR ) } } );
    }
}

bool iexamine::can_water_plant( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const furn_t &furn = here.furn( examp ).obj();
    const int max_water = get_plant_max_water( furn );
    if( max_water <= 0 ) {
        return false;
    }

    item *seed = get_seed_at( here, examp );
    if( seed == nullptr ) {
        return false;
    }

    if( get_plant_water( *seed ) >= max_water ) {
        return false;
    }

    return you.has_charges( itype_water_clean, 1, craft_reservation::usable_by_automation ) ||
           you.has_charges( itype_water, 1, craft_reservation::usable_by_automation );
}

int iexamine::rain_water_for_weather( const weather_type_id &weather )
{
    if( !weather->rains || weather->precip == precip_class::none ) {
        return 0;
    }

    switch( weather->precip ) {
        case precip_class::very_light:
            return irrigation::RAIN_WATER_VERY_LIGHT;
        case precip_class::light:
            return irrigation::RAIN_WATER_LIGHT;
        case precip_class::heavy:
            return irrigation::RAIN_WATER_HEAVY;
        default:
            return 0;
    }
}

std::string iexamine::plant_water_description( map &here, const tripoint_bub_ms &p )
{
    const furn_t &furn = here.furn( p ).obj();
    const int max_water = get_plant_max_water( furn );
    if( max_water <= 0 ) {
        return std::string();
    }

    item *seed = get_seed_at( here, p );
    if( seed != nullptr ) {
        // Defensive sync: make sure displayed water/age matches the authoritative
        // effective growth time before any UI reads it.
        here.grow_plant( p );
        const int current_water = get_plant_water( *seed );
        const int base_consumption = get_seed_water_consumption( *seed );
        const float consumption_mult = get_plant_water_consumption_multiplier( furn );
        const float crop_water_consumption = ::get_option<float>( "CROP_WATER_CONSUMPTION" );
        const int consumption = std::max( 1,
                                          static_cast<int>( base_consumption * consumption_mult *
                                                  crop_water_consumption ) );
        std::string desc = string_format(
                               _( "Water: <color_cyan>%d</color>/<color_cyan>%d</color>\n"
                                  "Daily consumption: <color_cyan>%d</color>\n"
                                  "%s" ),
                               current_water, max_water, consumption,
                               plant_age_description( *seed, furn.plant->growth_multiplier ).c_str() );
        if( current_water >= consumption ) {
            desc += string_format( _( "\n<color_green>Moisture sufficient for accelerated growth.</color>" ) );
        } else if( current_water > 0 ) {
            desc += string_format( _( "\n<color_yellow>Moisture low; growth is normal.</color>" ) );
        } else {
            desc += string_format( _( "\n<color_red>Dry; growth is normal.</color>" ) );
        }
        if( is_plant_fertilized( *seed ) ) {
            desc += string_format( _( "\n<color_green>Fertilized.</color>" ) );
        } else {
            desc += string_format( _( "\n<color_light_gray>Not fertilized.</color>" ) );
        }
        return desc;
    }

    return string_format( _( "Empty planter.  Water capacity: <color_cyan>%d</color>." ),
                          max_water );
}

int iexamine::get_plant_current_stage_idx( const map &here, const tripoint_bub_ms &p,
        const std::vector<std::pair<flag_id, time_duration>> &growth_stages )
{
    for( int i = 0; i < static_cast<int>( growth_stages.size() ); ++i ) {
        if( here.has_flag_furn( growth_stages[i].first.str(), p ) ) {
            return i;
        }
    }
    return -1;
}

int iexamine::get_plant_mature_stage_idx( const islot_seed &seed_data )
{
    return seed_data.get_mature_stage_idx();
}

int iexamine::get_plant_harvest_stage_idx( const islot_seed &seed_data )
{
    return seed_data.get_harvest_stage_idx();
}

int iexamine::get_plant_overgrown_stage_idx( const islot_seed &seed_data )
{
    return seed_data.get_overgrown_stage_idx();
}

time_duration iexamine::get_plant_stage_threshold( const islot_seed &seed_data, int stage_idx )
{
    if( stage_idx <= 0 ) {
        return 0_seconds;
    }
    const std::vector<time_duration> &thresholds = seed_data.get_cumulative_stage_thresholds();
    const int idx = stage_idx - 1;
    if( idx < static_cast<int>( thresholds.size() ) ) {
        return thresholds[idx];
    }
    return thresholds.empty() ? 0_seconds : thresholds.back();
}

time_duration iexamine::get_plant_effective_growth_time( const item &seed, float growth_multiplier )
{
    if( seed.has_var( "seed_effective_growth_turns" ) ) {
        return time_duration::from_turns( get_plant_effective_growth_turns( seed ) );
    }
    return seed.age() * growth_multiplier;
}

std::string iexamine::plant_age_description( const item &seed, float growth_multiplier )
{
    time_duration effective_age;
    if( seed.has_var( "seed_effective_growth_turns" ) ) {
        // Effective growth time is stored in base growth units.  Divide by the
        // furniture's growth multiplier to show an equivalent "default-speed" age
        // that matches the growth stage computed from seed_effective_growth_turns.
        effective_age = get_plant_effective_growth_time( seed, growth_multiplier ) /
                        growth_multiplier;
    } else {
        // Old saves: show real age as a fallback.
        effective_age = seed.age();
    }
    return string_format( _( "Effective age: <color_cyan>%s</color>" ),
                          to_string( effective_age ) );
}

int iexamine::get_plant_stage_idx_from_effective_time( const islot_seed &seed_data,
        const time_duration &effective_time )
{
    const std::vector<time_duration> &thresholds = seed_data.get_cumulative_stage_thresholds();
    int stage_idx = 0;
    for( int i = 0; i < static_cast<int>( thresholds.size() ); ++i ) {
        if( effective_time >= thresholds[i] ) {
            stage_idx = i + 1;
        } else {
            break;
        }
    }
    return std::min( stage_idx, static_cast<int>( seed_data.get_growth_stages().size() ) - 1 );
}

int iexamine::get_plant_current_stage_idx_from_effective( map &here, const tripoint_bub_ms &p )
{
    item *seed = get_seed_at( here, p );
    const furn_t &furn = here.furn( p ).obj();
    if( seed == nullptr || seed->type == nullptr || seed->type->seed == nullptr || !furn.plant ) {
        return -1;
    }
    const time_duration effective_time = get_plant_effective_growth_time( *seed,
                                         furn.plant->growth_multiplier );
    return get_plant_stage_idx_from_effective_time( *seed->type->seed, effective_time );
}

bool iexamine::is_plant_harvestable( map &here, const tripoint_bub_ms &p )
{
    item *seed = get_seed_at( here, p );
    const furn_t &furn = here.furn( p ).obj();
    if( seed == nullptr || seed->type == nullptr || seed->type->seed == nullptr || !furn.plant ) {
        return false;
    }
    const int harvest_stage_idx = get_plant_harvest_stage_idx( *seed->type->seed );
    if( harvest_stage_idx < 0 ) {
        return false;
    }
    // Effective growth time is the authoritative progress measure; furniture is
    // just its visual representation. Callers should synchronize with grow_plant()
    // before querying if they need the latest visual stage.
    const int current_stage_idx = get_plant_current_stage_idx_from_effective( here, p );
    return current_stage_idx >= harvest_stage_idx;
}

bool iexamine::is_plant_mature( map &here, const tripoint_bub_ms &p )
{
    item *seed = get_seed_at( here, p );
    const furn_t &furn = here.furn( p ).obj();
    if( seed == nullptr || seed->type == nullptr || seed->type->seed == nullptr || !furn.plant ) {
        return false;
    }
    const int mature_stage_idx = get_plant_mature_stage_idx( *seed->type->seed );
    if( mature_stage_idx < 0 ) {
        return false;
    }
    // Effective growth time is the authoritative progress measure; furniture is
    // just its visual representation. Callers should synchronize with grow_plant()
    // before querying if they need the latest visual stage.
    const int current_stage_idx = get_plant_current_stage_idx_from_effective( here, p );
    return current_stage_idx >= mature_stage_idx;
}

bool iexamine::is_plant_overgrown( map &here, const tripoint_bub_ms &p )
{
    item *seed = get_seed_at( here, p );
    const furn_t &furn = here.furn( p ).obj();
    if( seed == nullptr || seed->type == nullptr || seed->type->seed == nullptr || !furn.plant ) {
        return false;
    }
    const std::vector<std::pair<flag_id, time_duration>> &growth_stages =
                seed->type->seed->get_growth_stages();
    const int overgrown_stage_idx = get_plant_overgrown_stage_idx( *seed->type->seed );
    if( overgrown_stage_idx < 0 ) {
        return false;
    }
    // Overgrowth is a visible furniture stage.  When CROP_OVERGROWN_ENABLED is false
    // grow_plant clamps the furniture at mature, so this check must reflect the
    // actual furniture rather than the unclamped effective growth time.
    const int current_stage_idx = get_plant_current_stage_idx( here, p, growth_stages );
    return current_stage_idx >= overgrown_stage_idx;
}

void iexamine::run_plant_eocs(
    const std::vector<effect_on_condition_id> &eocs,
    Character &alpha,
    map &here,
    const tripoint_bub_ms &plant_pos,
    const item &seed,
    const std::string &old_stage,
    const std::string &new_stage,
    const std::map<std::string, std::string> &string_context,
    const std::map<std::string, double> &num_context )
{
    if( eocs.empty() ) {
        return;
    }

    const character_action_guard lifetime( alpha );
    const auto context = here.get_context_reference();
    if( !lifetime || !context ) {
        return;
    }
    const tripoint_abs_ms abs_pos = here.get_abs( plant_pos );
    dialogue d( get_talker_for( alpha ), nullptr );

    write_var_value( var_type::context, "plant_pos", &d, abs_pos );
    write_var_value( var_type::context, "plant_pos_x", &d, static_cast<double>( abs_pos.x() ) );
    write_var_value( var_type::context, "plant_pos_y", &d, static_cast<double>( abs_pos.y() ) );
    write_var_value( var_type::context, "plant_pos_z", &d, static_cast<double>( abs_pos.z() ) );
    write_var_value( var_type::context, "seed_id", &d, seed.typeId().str() );
    write_var_value( var_type::context, "furniture_id", &d, here.furn( plant_pos ).id().str() );
    write_var_value( var_type::context, "old_stage", &d, old_stage );
    write_var_value( var_type::context, "new_stage", &d, new_stage );
    write_var_value( var_type::context, "effective_growth_time", &d,
                     static_cast<double>( get_plant_effective_growth_turns( seed ) ) );
    write_var_value( var_type::context, "water", &d,
                     static_cast<double>( get_plant_water( seed ) ) );

    for( const auto &kv : string_context ) {
        write_var_value( var_type::context, kv.first, &d, kv.second );
    }
    for( const auto &kv : num_context ) {
        write_var_value( var_type::context, kv.first, &d, kv.second );
    }

    for( const effect_on_condition_id &eoc : eocs ) {
        if( !lifetime || !context ) {
            return;
        }
        eoc->activate_activation_only( d, "a plant lifecycle event", "plant event", "plant" );
    }
}

void iexamine::run_plant_lifecycle_event(
    const std::string_view phase,
    Character &alpha,
    map &here,
    const tripoint_bub_ms &plant_pos,
    const item &seed,
    const std::string &old_stage,
    const std::string &new_stage,
    const std::map<std::string, std::string> &string_context,
    const std::map<std::string, double> &num_context,
    const std::optional<furn_str_id> source_furniture )
{
    using eoc_collection = std::vector<effect_on_condition_id>;
    const auto select_eocs = [phase]( const auto & source ) -> const eoc_collection * {
        if( phase == "plant" )
        {
            return &source.eoc_on_plant;
        }
        if( phase == "grow" )
        {
            return &source.eoc_on_grow;
        }
        if( phase == "mature" )
        {
            return &source.eoc_on_mature;
        }
        if( phase == "overgrow" )
        {
            return &source.eoc_on_overgrow;
        }
        if( phase == "harvest" )
        {
            return &source.eoc_on_harvest;
        }
        if( phase == "fertilize" )
        {
            return &source.eoc_on_fertilize;
        }
        if( phase == "water" )
        {
            return &source.eoc_on_water;
        }
        return nullptr;
    };
    if( !seed.type->seed ) {
        debugmsg( "plant lifecycle event '%s' has no seed data", phase );
        return;
    }
    const std::vector<effect_on_condition_id> *seed_eocs =
        select_eocs( *seed.type->seed );
    if( seed_eocs == nullptr ) {
        debugmsg( "unknown plant lifecycle phase '%s'", phase );
        return;
    }
    const character_action_guard lifetime( alpha );
    const auto context = here.get_context_reference();
    if( !lifetime || !context ) {
        return;
    }
    // Lifecycle handlers can erase the plant and actor. All payload and hook
    // selection belongs to this phase, not references into the mutable map.
    const item snapshot = seed;
    const eoc_collection seed_hooks = *seed_eocs;
    const furn_t &furniture = source_furniture ? source_furniture->obj() :
                              here.furn( plant_pos ).obj();
    const eoc_collection furniture_hooks = furniture.plant ?
                                           *select_eocs( *furniture.plant ) : eoc_collection{};
    auto strings = string_context;
    strings["furniture_id"] = furniture.id.str();
    const std::string seed_id = snapshot.typeId().str();
    const int effective_growth_turns = get_plant_effective_growth_turns( snapshot );
    const int water = get_plant_water( snapshot );
    run_plant_eocs( furniture_hooks, alpha, here, plant_pos,
                    snapshot, old_stage, new_stage, strings, num_context );
    if( !lifetime || !context ) {
        return;
    }
    run_plant_eocs( seed_hooks, alpha, here, plant_pos, snapshot,
                    old_stage, new_stage, strings, num_context );
    if( !lifetime || !context ) {
        return;
    }
    cata::lua_platform::invoke_plant_lifecycle_handlers(
        phase, alpha, here, plant_pos, seed_id, old_stage, new_stage,
        effective_growth_turns, water, strings, num_context );
}

static void add_firestarter( item *it, std::multimap<int, safe_reference<item>> &firestarters,
                             Character &you, const tripoint_bub_ms &examp )
{
    const use_function *usef = it->type->get_use( "firestarter" );
    const auto *actor = usef ? dynamic_cast<const firestarter_actor *>( usef->get_actor_ptr() ) :
                        nullptr;
    if( actor && actor->can_use( you, *it, &get_map(), examp ).success() ) {
        firestarters.emplace( actor->moves_cost_fast, it->get_safe_reference() );
    }
}


static void submit_smoking_rack_choice( Character &who, map &here,
                                        const smoking_rack::command &command )
{
    if( !who.is_avatar() || !cata_mp::client_smoking_rack_command( command ) ) {
        smoking_rack::execute( who, here, command );
    }
}

static void pick_firestarter_and_fire( Character &you, const tripoint_bub_ms &examp,
                                       firestarter_actor::start_type st )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const tripoint_abs_ms origin = you.pos_abs();
    const auto observed = tool_activity_target::capture( here, here.get_abs( examp ) );
    const auto still_at_station = [&]() {
        return lifetime && context && you.pos_abs() == origin && observed.matches( here );
    };
    std::string f_name = here.furnname( examp );

    if( !you.has_charges( itype_fire, 1 ) ) {
        add_msg( _( "This %s is ready to be fired, but you have no fire source." ), f_name );
        return;
    } else if( !query_yn( _( "Fire the %s?" ), f_name ) || !still_at_station() ) {
        return;
    }

    // Determine the fire starter to use.
    auto is_firestarter = []( const item & it ) {
        return it.has_flag( flag_FIRESTARTER ) || it.has_flag( flag_FIRE );
    };

    std::multimap<int, safe_reference<item>> firestarters;

    for( item *it : you.items_with( is_firestarter ) ) {
        add_firestarter( it, firestarters, you, examp );
    }

    const bool has_bionic_firestarter = you.has_bionic( bio_lighter ) &&
                                        you.enough_power_for( bio_lighter );

    bool use_cbm = false;

    // Query to use a CBM over another firestarter only if the firestarters list isn't empty.
    if( has_bionic_firestarter && !firestarters.empty() ) {
        use_cbm = query_yn( _( "Use a CBM to start a fire" ) );
    } else if( has_bionic_firestarter ) {
        use_cbm = true;
    }

    if( !still_at_station() ) {
        return;
    }
    // Try to start the smoking rack/kiln.
    if( !use_cbm ) {
        for( auto &firestarter : firestarters ) {
            item *it = firestarter.second.get();
            if( !it || !you.has_item( *it ) ) {
                continue;
            }
            const use_function *usef = it->type->get_use( "firestarter" );
            const auto *actor = usef ? dynamic_cast<const firestarter_actor *>( usef->get_actor_ptr() ) :
                                nullptr;
            if( !actor ) {
                continue;
            }
            you.add_msg_if_player( _( "You attempt to start a fire with your %s…" ), it->tname() );
            const ret_val<void> can_use = actor->can_use( you, *it, &get_map(), examp );
            if( can_use.success() ) {
                std::string method = "firestarter";
                if( you.is_avatar() && cata_mp::is_client_mode() ) {
                    cata_mp::client_activate_item( locate_cutting_tool( you, *it ), method, observed.position );
                    return;
                }
                you.invoke_item( it, method, examp, you.get_moves() );
                return;
            } else {
                you.add_msg_if_player( m_bad, can_use.str() );
            }
        }
    } else if( st == firestarter_actor::start_type::KILN ) {
        const auto command = charcoal_kiln::capture( you, here, examp,
                             charcoal_kiln::operation::fire_bionic );
        if( !you.is_avatar() || !cata_mp::client_kiln_command( command ) ) {
            charcoal_kiln::execute( you, here, command );
        }
    } else {
        submit_smoking_rack_choice( you, here, smoking_rack::capture( you, here, examp,
                                    smoking_rack::operation::fire_bionic ) );
    }
}

// Highly modified fermenting vat functions
void iexamine::kiln_empty( Character &you, const tripoint_bub_ms &examp )
{
    if( !charcoal_kiln::prepare( you, get_map(), examp ) ) {
        return;
    }

    pick_firestarter_and_fire( you, examp, firestarter_actor::start_type::KILN );
}

void iexamine::kiln_full( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    if( you.is_avatar() && cata_mp::client_kiln_command(
            charcoal_kiln::capture( you, here, examp, charcoal_kiln::operation::inspect ) ) ) {
        return;
    }
    charcoal_kiln::inspect( you, here, examp );
}

//arc furnance start
void iexamine::arcfurnace_empty( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const furn_id &cur_arcfurnace_type = here.furn( examp );
    furn_id next_arcfurnace_type = furn_str_id::NULL_ID();
    if( cur_arcfurnace_type == furn_f_arcfurnace_empty ) {
        next_arcfurnace_type = furn_f_arcfurnace_full;
    } else {
        debugmsg( "Examined furniture has action arcfurnace_empty, but is of type %s",
                  cur_arcfurnace_type.id().c_str() );
        return;
    }

    static const std::set<material_id> arcfurnaceable{ material_cac2powder };
    bool fuel_present = false;
    map_stack items = here.i_at( examp );
    for( const item &i : items ) {
        if( i.typeId() == itype_chem_carbide ) {
            add_msg( _( "This furnace already contains calcium carbide." ) );
            add_msg( _( "Remove it before activating the arc furnace again." ) );
            return;
        } else if( i.made_of_any( arcfurnaceable ) ) {
            fuel_present = true;
        } else {
            add_msg( m_bad, _( "This furnace contains %s, which can't be made into calcium carbide!" ),
                     i.tname( 1, false ) );
            return;
        }
    }

    if( !fuel_present ) {
        add_msg( _( "This furnace is empty.  Fill it with powdered coke and lime mix, and try again." ) );
        return;
    }

    ///\EFFECT_FABRICATION decreases loss when firing a furnace
    const float skill = you.get_skill_level( skill_fabrication );
    int loss = 60 - 2 *
               skill; // Inefficiency is still fine, coal and limestone is abundant

    // Burn stuff that should get charred, leave out the rest
    units::volume total_volume = 0_ml;
    for( const item &i : items ) {
        total_volume += i.volume();
    }

    const itype *char_type = item::find_type( itype_unfinished_cac2 );
    int char_charges = char_type->charges_per_volume( ( 100 - loss ) * total_volume / 100 );
    if( char_charges < 1 ) {
        add_msg( _( "The batch in this furnace is too small to yield usable calcium carbide." ) );
        return;
    }
    //arc furnaces require a huge amount of current, so 1 full storage battery would work as a stand in
    if( you.available_ups() < 1250_kJ ) {
        add_msg( _( "This furnace is ready to be turned on, but you lack a UPS with sufficient power." ) );
        return;
    } else {
        add_msg( _( "This furnace contains %s %s of material, and is ready to be turned on." ),
                 format_volume( total_volume ), volume_units_abbr() );
        if( !query_yn( _( "Turn on the furnace?" ) ) ) {
            return;
        }
    }

    you.consume_ups( 1250_kJ );
    here.i_clear( examp );
    here.furn_set( examp, next_arcfurnace_type );
    item result( itype_unfinished_cac2, calendar::turn );
    result.charges = char_charges;
    here.add_item( examp, result );
    add_msg( _( "You turn on the furnace." ) );
}

void iexamine::arcfurnace_full( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    arc_furnace::completion choice;
    if( arc_furnace::inspect( you, here, examp, choice ) &&
        ( !you.is_avatar() || !cata_mp::client_finish_arc_furnace( choice ) ) ) {
        arc_furnace::finish( you, here, choice );
    }
}

static void examine_stook( Character &who, const tripoint_bub_ms &tile, stook::operation action )
{
    map &here = get_map();
    const auto choice = stook::inspect( who, here, tile, action );
    if( !choice ) {
        return;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    if( action == stook::operation::stand && !who.query_yn( _( "Stand the grain up to dry?" ) ) ) {
        return;
    }
    if( lifetime && context && who.pos_abs() == choice->origin &&
        ( !who.is_avatar() || !cata_mp::client_stook_command( *choice ) ) ) {
        stook::execute( who, here, *choice );
    }
}

void iexamine::stook_empty( Character &you, const tripoint_bub_ms &examp )
{
    examine_stook( you, examp, stook::operation::stand );
}

void iexamine::stook_full( Character &you, const tripoint_bub_ms &examp )
{
    examine_stook( you, examp, stook::operation::harvest );
}

static void examine_autoclave( Character &who, const tripoint_bub_ms &tile,
                               autoclave::operation action )
{
    map &here = get_map();
    auto choice = autoclave::inspect( who, here, tile, action );
    if( !choice ) {
        return;
    }
    if( action == autoclave::operation::start && !autoclave::confirm_start( who, *choice ) ) {
        return;
    }
    if( !who.is_avatar() || !cata_mp::client_autoclave_command( *choice ) ) {
        autoclave::execute( who, here, *choice );
    }
}

void iexamine::autoclave_empty( Character &you, const tripoint_bub_ms &examp )
{
    examine_autoclave( you, examp, autoclave::operation::start );
}

void iexamine::autoclave_full( Character &you, const tripoint_bub_ms &examp )
{
    examine_autoclave( you, examp, autoclave::operation::finish );
}

void iexamine::fireplace( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    fireplace_selection choice{ fireplace_action::light_with_tool, you.pos_abs(),
                                tool_activity_target::capture( here, here.get_abs( examp ) ),
                                std::nullopt, std::nullopt };
    const bool burning = here.get_field( examp, fd_fire ) != nullptr;
    const bool hot = here.has_nearby_fire( examp, 0 );
    const bool can_pack = item::type_is_defined( here.furn( examp )->deployed_item );
    const item_location tool = hot ? item_location() : find_fireplace_firestarter( you, here, examp );
    uilist menu;
    menu.text = _( "Select an action" );
    if( here.has_items( examp ) ) {
        menu.addentry( 0, true, 'g', _( "Get items" ) );
    }
    if( !hot ) {
        menu.addentry( 1, !!tool, 'f', tool ? _( "Start a fire" ) :
                       _( "Start a fire… you'll need a fire source." ) );
        if( can_light_fireplace_with_bionic( you ) ) {
            menu.addentry( 2, true, 'b', _( "Use a CBM to start a fire" ) );
        }
    } else if( burning ) {
        const bool can_quench = has_fireplace_quencher( you, here, examp );
        menu.addentry( 4, can_quench, 'e', can_quench ? _( "Extinguish fire" ) :
                       _( "Extinguish fire (bashing item required)" ) );
    }
    if( can_pack ) {
        menu.addentry( 3, true, 't', _( "Take down the %s" ), here.furnname( examp ) );
    }
    menu.query();
    if( !lifetime || !context || you.pos_abs() != choice.origin || !choice.target.matches( here ) ) {
        return;
    }
    switch( menu.ret ) {
        case 0:
            none( you, examp );
            g->pickup( examp );
            return;
        case 1:
            if( !query_fireplace_ignition( you, here, tool, choice ) ) {
                return;
            }
            break;
        case 2:
            choice.action = fireplace_action::light_with_bionic;
            break;
        case 3: {
            const bool burning_now = here.get_field( examp, fd_fire ) != nullptr;
            if( burning_now && !query_yn( _( "Really take down the %s while it's on fire?" ),
                                          here.furnname( examp ) ) ) {
                return;
            }
            const deployed_furniture_selection teardown{ choice.origin, choice.target.position,
                                                          choice.target.furniture, burning_now };
            if( lifetime && context && can_take_down_deployed_furniture( you, here, teardown ) &&
                ( !you.is_avatar() || !cata_mp::client_take_down_furniture( teardown ) ) ) {
                take_down_deployed_furniture( you, here, teardown );
            }
            return;
        }
        case 4:
            choice.action = fireplace_action::extinguish;
            break;
        default:
            none( you, examp );
            return;
    }
    if( !you.is_avatar() || !cata_mp::client_fireplace_selection( choice ) ) {
        execute_fireplace_selection( you, here, choice, activity_execution::local );
    }
}

namespace
{
using fermentation_vessel::operation;

void submit_vessel_command( Character &who, map &here, const fermentation_vessel::command &command )
{
    if( !who.is_avatar() || !cata_mp::client_fermentation_command( command ) ) {
        fermentation_vessel::execute( who, here, command );
    }
}

void examine_fermentation_vessel( Character &who, const tripoint_bub_ms &pos, bool closed,
                                  bool compost )
{
    map &here = get_map();
    const furn_id vessel = here.furn( pos );
    const units::volume capacity = fermentation_vessel::capacity( vessel );
    if( capacity <= 0_ml ) {
        return;
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const auto observed = fermentation_vessel::capture( who, here, pos, operation::recover );
    const auto still_there = [&]() {
        return lifetime && context && who.pos_abs() == observed.origin &&
               observed.target.matches( here );
    };

    const map_stack contents = here.i_at( pos );
    item_location input;
    std::vector<item_location> liquids;
    for( item &it : here.i_at( pos ) ) {
        item_location location( map_cursor( observed.target.position ), &it );
        if( !input && fermentation_vessel::accepts( vessel, it ) ) {
            input = location;
        }
        if( it.made_of( phase_id::LIQUID ) &&
            ( !closed || !fermentation_vessel::accepts( vessel, it ) ) ) {
            liquids.push_back( location );
        } else if( !it.made_of_from_type( phase_id::LIQUID ) &&
                   !fermentation_vessel::accepts( vessel, it ) ) {
            // Recover a stray object without emptying unrelated contents.
            submit_vessel_command( who, here, fermentation_vessel::capture( who, here, pos,
                                   operation::recover, &it ) );
            return;
        }
    }
    if( closed && contents.empty() ) {
        submit_vessel_command( who, here, observed );
        return;
    }
    if( closed && input ) {
        auto command = fermentation_vessel::capture( who, here, pos, operation::finish, &*input );
        const time_duration remaining = fermentation_vessel::duration( vessel, *input ) - input->age();
        who.add_msg_if_player( compost ? _( "There's a tank of %s set to ferment there." ) :
                               _( "There's a vat of %s set to ferment there." ), input->tname() );
        if( remaining <= 0_turns ) {
            if( who.query_yn( compost ? _( "Finish fermenting?" ) : _( "Finish brewing?" ) ) && still_there() ) {
                submit_vessel_command( who, here, command );
            }
        } else {
            const int hours = to_hours<int>( remaining );
            const int days = to_days<int>( remaining );
            if( hours < 1 ) {
                who.add_msg_if_player( compost ? _( "It will finish fermenting in less than an hour." ) :
                                       _( "It will finish brewing in less than an hour." ) );
            } else if( compost && days > 0 ) {
                who.add_msg_if_player( n_gettext( "It will finish fermenting in about %d day.",
                                                  "It will finish fermenting in about %d days.", days ), days );
            } else if( compost ) {
                who.add_msg_if_player( n_gettext( "It will finish fermenting in about %d hour.",
                                                  "It will finish fermenting in about %d hours.", hours ), hours );
            } else {
                who.add_msg_if_player( n_gettext( "It will finish brewing in about %d hour.",
                                                  "It will finish brewing in about %d hours.", hours ), hours );
            }
            if( compost && fermentation_vessel::gas_days_available( *input ) > 0 &&
                who.query_yn( _( "Gather biogas?  Can't stop once releasing started." ) ) && still_there() ) {
                command.action = operation::gather_gas;
                submit_vessel_command( who, here, command );
            }
        }
        return;
    }

    const auto drain = [&]() {
        if( liquids.empty() ) {
            return;
        }
        item_location source = liquids.front();
        if( liquids.size() > 1 ) {
            std::vector<std::string> choices;
            for( const item_location &liquid : liquids ) {
                choices.push_back( liquid->display_name() );
            }
            const int index = uilist( _( "Which liquid do you want to remove?" ), choices );
            if( index < 0 || static_cast<size_t>( index ) >= liquids.size() || !still_there() ) {
                return;
            }
            source = liquids[index];
        }
        if( !source ) {
            return;
        }
        auto command = fermentation_vessel::capture( who, here, pos, operation::drain, &*source );
        const auto choice = query_liquid_destination( *source, &*source, command.batch, true );
        if( !still_there() || !source || choice.kind == LD_NULL ||
            ( choice.kind == LD_CONSUME && !who.will_eat( *source, true ).success() ) ||
            !still_there() ) {
            return;
        }
        command.destination = choice;
        submit_vessel_command( who, here, command );
    };
    if( closed || ( !contents.empty() && ( !input || contents.size() != 1 ) ) ) {
        drain();
        return;
    }

    auto command = fermentation_vessel::capture( who, here, pos, operation::deposit,
                   input ? &*input : nullptr );
    std::map<itype_id, std::vector<item_source>> supplies;
    const auto carried = compost ? who.cache_get_items_with( "is_compostable", &item::is_compostable ) :
                         who.cache_get_items_with( "is_brewable", &item::is_brewable );
    for( const item_location &candidate : carried ) {
        if( candidate && candidate.held_by( who ) && ( !input || candidate->typeId() == input->typeId() ) ) {
            supplies[candidate->typeId()].push_back( capture_item_source( who, candidate ) );
        }
    }
    if( input ) {
        enum { add_input, remove_input, start };
        const std::string name = input->tname();
        who.add_msg_if_player( compost ? _( "This tank contains %s (%d), %0.f%% full." ) :
                               _( "This keg contains %s (%d), %0.f%% full." ),
                               name, input->charges, input->volume() * 100.0 / capacity );
        uilist choices;
        choices.text = _( "Select an action" );
        choices.addentry( add_input, !supplies.empty(), MENU_AUTOASSIGN,
                          compost ? _( "Add more %s to the tank" ) : _( "Add more %s to the vat" ), name );
        choices.addentry( remove_input, !liquids.empty(), MENU_AUTOASSIGN,
                          compost ? _( "Remove %s from the tank" ) : _( "Remove %s from the vat" ), name );
        choices.addentry( start, true, MENU_AUTOASSIGN,
                          compost ? _( "Start anaerobic digestion" ) : _( "Start fermenting cycle" ) );
        choices.query();
        if( !still_there() || !input ) {
            return;
        }
        if( choices.ret == remove_input ) {
            drain();
            return;
        }
        if( choices.ret == start ) {
            command.action = operation::start;
            submit_vessel_command( who, here, command );
            return;
        }
        if( choices.ret != add_input || supplies.empty() ) {
            return;
        }
        command.supplies = std::move( supplies.begin()->second );
    } else {
        who.add_msg_if_player( compost ? _( "This tank is empty." ) : _( "This keg is empty." ) );
        if( supplies.empty() ) {
            who.add_msg_if_player( m_info, compost ? _( "You have nothing that could be used as biomass to ferment." ) :
                                   _( "You have no brew to ferment." ) );
            return;
        }
        std::vector<std::string> names;
        std::vector<itype_id> types;
        for( const auto &entry : supplies ) {
            types.push_back( entry.first );
            names.push_back( item::nname( entry.first ) );
        }
        int index = 0;
        if( names.size() > 1 ) {
            index = uilist( compost ? _( "What do you want to use as biomass?" ) : _( "Use which brew?" ),
                            names );
        } else if( !who.query_yn( compost ? _( "Set %s in the tank?" ) : _( "Set %s in the vat?" ),
                                  names.front() ) ) {
            return;
        }
        if( index < 0 || static_cast<size_t>( index ) >= types.size() || !still_there() ) {
            return;
        }
        command.supplies = std::move( supplies.at( types[index] ) );
    }
    command.start_after_deposit = who.query_yn( compost ? _( "Start anaerobic digestion?" ) :
                                   _( "Start fermenting cycle?" ) );
    if( still_there() ) {
        submit_vessel_command( who, here, command );
    }
}
} // namespace

void iexamine::fvat_empty( Character &who, const tripoint_bub_ms &pos )
{
    examine_fermentation_vessel( who, pos, false, false );
}

void iexamine::fvat_full( Character &who, const tripoint_bub_ms &pos )
{
    examine_fermentation_vessel( who, pos, true, false );
}

void iexamine::compost_empty( Character &who, const tripoint_bub_ms &pos )
{
    examine_fermentation_vessel( who, pos, false, true );
}

void iexamine::compost_full( Character &who, const tripoint_bub_ms &pos )
{
    examine_fermentation_vessel( who, pos, true, true );
}

bool iexamine::has_keg( const tripoint_bub_ms &pos )
{
    return ::keg::capacity( get_map(), pos ) > 0_ml;
}

void iexamine::keg( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    ::keg::command choice;
    choice.origin = you.pos_abs();
    choice.target = tool_activity_target::capture( here, here.get_abs( examp ) );
    const std::string name = here.name( examp );
    const auto still_there = [&]() {
        return lifetime && context && you.pos_abs() == choice.origin && choice.target.matches( here );
    };
    const auto submit = [&]() {
        if( still_there() && ( !you.is_avatar() || !cata_mp::client_keg_command( choice ) ) ) {
            ::keg::execute( you, here, choice, false );
        }
    };
    std::vector<item_location> batches;
    item_location stray;
    for( item &entry : here.i_at( examp ) ) {
        if( entry.made_of_from_type( phase_id::LIQUID ) ) {
            if( entry.charges > 0 ) {
                batches.emplace_back( map_cursor( choice.target.position ), &entry );
            }
        } else if( !stray ) {
            stray = item_location( map_cursor( choice.target.position ), &entry );
        }
    }
    item_location batch;
    if( !batches.empty() ) {
        size_t index = 0;
        if( batches.size() > 1 ) {
            std::vector<std::string> names;
            for( const item_location &liquid : batches ) {
                names.push_back( liquid->tname() );
            }
            const int selected = uilist( _( "Which liquid?" ), names );
            if( selected < 0 || static_cast<size_t>( selected ) >= batches.size() || !still_there() ) {
                return;
            }
            index = selected;
        }
        batch = batches[index];
        if( !batch ) {
            return;
        }
        choice.batch = batch->uid().get_value();
    }

    const auto fill = [&]() {
        std::map<itype_id, std::vector<item_source>> supplies;
        for( const item_location &source : you.all_items_loc() ) {
            if( ::keg::available_supply( you, source ) && ( !batch || source->typeId() == batch->typeId() ) ) {
                supplies[source->typeId()].push_back( capture_item_source( you, source ) );
            }
        }
        if( supplies.empty() ) {
            you.add_msg_if_player( m_info, _( "You have no compatible liquid to fill the %s with." ), name );
            return;
        }
        auto selected = supplies.begin();
        if( supplies.size() > 1 ) {
            std::vector<std::string> names;
            for( const auto &entry : supplies ) {
                names.push_back( item::nname( entry.first ) );
            }
            const int index = uilist( _( "Store which liquid?" ), names );
            if( index < 0 || static_cast<size_t>( index ) >= supplies.size() ) {
                return;
            }
            std::advance( selected, index );
        } else if( !batch && !you.query_yn( _( "Fill the %1$s with %2$s?" ), name,
                                           item::nname( selected->first ) ) ) {
            return;
        }
        choice.action = ::keg::operation::fill;
        choice.supplies = std::move( selected->second );
        submit();
    };

    if( !batch && !stray ) {
        fill();
        return;
    }
    const units::volume capacity = ::keg::capacity( here, examp );
    const bool liquid = batch && batch->made_of( phase_id::LIQUID );
    uilist menu;
    menu.text = batch ? string_format( _( "%1$s with %2$s (%3$d)    %4$s / %5$s" ),
                                      uppercase_first_letter( name ), batch->tname(), batch->charges,
                                      vol_to_string( batch->volume(), true, true ),
                                      vol_to_string( capacity, true, true ) ) :
                string_format( _( "The %s is empty." ), name );
    if( batch ) {
        menu.addentry( 0, liquid, MENU_AUTOASSIGN, _( "Dispense or dump %s" ), batch->tname() );
        menu.addentry( 1, liquid && batch->is_food(), MENU_AUTOASSIGN, _( "Have a drink" ) );
    }
    menu.addentry( 2, !batch || ( liquid && batches.size() == 1 && batch->volume() < capacity ),
                   MENU_AUTOASSIGN, batch ? _( "Refill" ) : _( "Fill" ) );
    if( stray ) {
        menu.addentry( 3, true, MENU_AUTOASSIGN, _( "Remove %s" ), stray->tname() );
    }
    menu.query();
    if( !still_there() ) {
        return;
    }
    switch( menu.ret ) {
        case 0:
            if( batch ) {
                choice.action = ::keg::operation::dispense;
                choice.destination = query_liquid_destination( *batch, batch.get_item(), choice.batch, false );
                if( choice.destination->kind != LD_NULL ) {
                    submit();
                }
            }
            break;
        case 1:
            if( !batch ) {
                break;
            }
            if( you.is_avatar() && cata_mp::is_client_mode() ) {
                const restore_on_out_of_scope restore_rng( rng_get_engine() );
                if( !you.will_eat( *batch, true ).success() ) {
                    break;
                }
            }
            choice.action = ::keg::operation::drink;
            choice.allow_consequences = true;
            submit();
            break;
        case 2:
            fill();
            break;
        case 3:
            if( stray ) {
                choice.action = ::keg::operation::recover;
                choice.batch = stray->uid().get_value();
                submit();
            }
            break;
        default:
            break;
    }
}

bool iexamine::pour_into_keg( const tripoint_bub_ms &pos, item &liquid, bool silent )
{
    map &here = get_map();
    const std::string liquid_name = silent ? std::string() : liquid.tname();
    if( !::keg::pour( here, pos, liquid ) ) {
        return false;
    }
    if( !silent ) {
        add_msg( _( "You pour %1$s into the %2$s." ), liquid_name, here.name( pos ) );
    }
    return true;
}

namespace
{
void query_marloss_harvest( Character &who, const tripoint_bub_ms &position )
{
    map &here = get_map();
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const farming_command choice = capture_farming_command( who, here, here.get_abs( position ),
                                   farming_action::marloss );
    const bool offering = !who.has_trait( trait_THRESH_MYCUS ) &&
                          who.has_trait( trait_THRESH_MARLOSS );
    const bool automatic = get_option<bool>( "AUTO_FEATURES" ) &&
                           get_option<std::string>( "AUTO_FORAGING" ) != "off";
    if( who.is_avatar() && !offering && !automatic &&
        !query_yn( _( "Harvest the %s?" ), here.tername( position ) ) ) {
        if( lifetime && context ) {
            iexamine::none( who, position );
        }
        return;
    }
    if( lifetime && context ) {
        submit_farming_choice( who, choice );
    }
}
} // namespace

void iexamine::tree_hickory( Character &you, const tripoint_bub_ms &examp )
{
    const bool automatic = get_option<bool>( "AUTO_FEATURES" ) &&
                           ( get_option<std::string>( "AUTO_FORAGING" ) == "all" ||
                             get_option<std::string>( "AUTO_FORAGING" ) == "trees" );
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    farming_command choice = capture_farming_command( you, here, here.get_abs( examp ),
                             farming_action::gather );
    if( !automatic && you.is_avatar() && you.has_quality( qual_DIG ) &&
        query_yn( _( "Dig up %s?  This kills the tree!" ), here.tername( examp ) ) ) {
        choice.action = farming_action::hickory_roots;
        if( lifetime && context ) {
            submit_farming_choice( you, choice );
        }
        return;
    }
    if( !lifetime || !context ) {
        return;
    }
    if( !automatic ) {
        you.add_msg_if_player( _( "You could dig this tree up for roots…" ) );
        if( !query_pick( you, examp ) ) {
            return;
        }
    }
    if( lifetime && context ) {
        submit_farming_choice( you, choice );
    }
}

namespace
{
item_location maple_tree_sap_container()
{
    const item maple_sap( itype_maple_sap, calendar::turn_zero );
    return g->inv_map_splice( [&]( const item & it ) {
        return it.get_remaining_capacity_for_liquid( maple_sap, true ) > 0;
    }, _( "Use which container to collect sap?" ), pickup_range,
    _( "You don't have a container at hand." ) );
}

std::optional<farming_command> query_maple_work( Character &who,
        const tripoint_bub_ms &position, bool installing )
{
    if( !who.is_avatar() ) {
        return std::nullopt;
    }
    // All previews and menus are display work; the caller executes only after
    // this scope has restored gameplay RNG.
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( who );
    map &here = get_map();
    const auto context = here.get_context_reference();
    const auto origin = who.pos_abs();
    const auto generation = who.activity.identity_generation();
    farming_command choice = capture_farming_command( who, here, here.get_abs( position ),
                             farming_action::maple_tap );
    const auto valid = [&]() {
        return lifetime && context && who.pos_abs() == origin &&
               who.activity.identity_generation() == generation && choice.target.matches( here );
    };
    if( installing ) {
        if( !who.crafting_inventory().has_quality( qual_DRILL ) ) {
            who.add_msg_if_player( m_info, _( "You need a tool to drill the crust to tap this maple tree." ) );
            return std::nullopt;
        }
        if( !who.crafting_inventory().has_quality( qual_HAMMER ) ) {
            who.add_msg_if_player( m_info,
                                   _( "You need a tool to hammer the spile into the crust to tap this maple tree." ) );
            return std::nullopt;
        }
        item_location tap = g->inv_map_splice( [&here]( const item_location & it ) {
            return it->get_quality_nonrecursive( qual_TREE_TAP ) > 0 &&
                   !( here.ter( it.pos_bub( here ) ) == ter_t_tree_maple_tapped );
        }, _( "Use which tapping tool?" ), pickup_range,
        _( "You don't have a tapping tool at hand." ) );
        if( !valid() || !tap ) {
            return std::nullopt;
        }
        choice.tap = capture_item_source( who, tap );
        const item_location container = maple_tree_sap_container();
        if( !valid() ) {
            return std::nullopt;
        }
        if( container ) {
            choice.container = capture_item_source( who, container );
        }
        return choice;
    }
    const maple_tree_items items = inspect_maple_tree( here, choice.target.position );
    if( !items.tap ) {
        return std::nullopt;
    }
    choice.tap = capture_item_source( who, items.tap );
    if( items.container ) {
        choice.container = capture_item_source( who, items.container );
    }
    const std::string sap_name = item::nname( itype_maple_sap );
    uilist menu;
    menu.addentry( static_cast<int>( farming_action::maple_untap ), true, MENU_AUTOASSIGN,
                   _( "Remove tap" ) );
    menu.addentry( static_cast<int>( farming_action::maple_add_container ), !items.container,
                   MENU_AUTOASSIGN, _( "Add a container to receive the %s" ), sap_name );
    menu.addentry( static_cast<int>( farming_action::maple_sap ), static_cast<bool>( items.sap ),
                   MENU_AUTOASSIGN, _( "Harvest current %s (%d)" ), sap_name,
                   items.sap ? items.sap->charges : 0 );
    menu.addentry( static_cast<int>( farming_action::maple_remove_container ),
                   static_cast<bool>( items.container ), MENU_AUTOASSIGN, _( "Remove container" ) );
    menu.text = _( "Select an action" );
    menu.query();
    if( !valid() ) {
        return std::nullopt;
    }
    choice.action = static_cast<farming_action>( menu.ret );
    switch( choice.action ) {
        case farming_action::maple_untap:
            if( !items.tap ) {
                return std::nullopt;
            }
            if( !who.crafting_inventory().has_quality( qual_HAMMER ) ) {
                who.add_msg_if_player( m_info, _( "You need a hammer to remove the spile." ) );
                return std::nullopt;
            }
            break;
        case farming_action::maple_add_container: {
            const item_location container = maple_tree_sap_container();
            if( !valid() || !container ) {
                return std::nullopt;
            }
            choice.container = capture_item_source( who, container );
            break;
        }
        case farming_action::maple_remove_container:
            if( !items.container ) {
                return std::nullopt;
            }
            break;
        case farming_action::maple_sap:
            if( !items.sap || !items.container || !liquid_handler::can_handle_liquid( *items.sap ) ) {
                return std::nullopt;
            }
            choice.sap_destination = query_liquid_destination( *items.sap, &*items.container,
                                     items.sap->uid().get_value(), true );
            if( !valid() || choice.sap_destination->kind == LD_NULL ) {
                return std::nullopt;
            }
            break;
        default:
            return std::nullopt;
    }
    return choice;
}

void examine_maple( Character &who, const tripoint_bub_ms &position, bool installing )
{
    const auto choice = query_maple_work( who, position, installing );
    if( !choice ) {
        return;
    }
    if( choice->sap_destination && choice->sap_destination->kind == LD_CONSUME ) {
        // Drinking sap uses the existing owned consumption command/activity.
        // The farming transfer command never executes an unconfirmed meal.
        const maple_tree_items current = inspect_maple_tree( get_map(), choice->target.position );
        if( current.sap && current.sap->uid().get_value() == choice->sap_destination->source ) {
            start_item_consumption( who, current.sap );
        }
    } else {
        submit_farming_choice( who, *choice );
    }
}
} // namespace

void iexamine::tree_maple( Character &you, const tripoint_bub_ms &examp )
{
    examine_maple( you, examp, true );
}

void iexamine::tree_maple_tapped( Character &you, const tripoint_bub_ms &examp )
{
    examine_maple( you, examp, false );
}

void iexamine::shrub_marloss( Character &you, const tripoint_bub_ms &examp )
{
    query_marloss_harvest( you, examp );
}

void iexamine::tree_marloss( Character &you, const tripoint_bub_ms &examp )
{
    query_marloss_harvest( you, examp );
}

void iexamine::shrub_wildveggies( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const farming_command choice = capture_farming_command( you, here,
                                   here.get_abs( examp ), farming_action::forage );
    // NPCs already chose to forage via address_needs; the local frontend owns prompts.
    if( you.is_avatar() &&
        ( !here.i_at( examp ).empty() || here.veh_at( examp ) ||
          here.can_see_trap_at( examp, you ) || get_creature_tracker().creature_at( examp ) ) &&
        !query_yn( _( "Forage through %s?" ), here.tername( examp ) ) ) {
        none( you, examp );
        return;
    }
    if( !lifetime || !context ) {
        return;
    }
    you.add_msg_if_player( _( "You forage through the %s." ), here.tername( examp ) );
    you.add_msg_if_npc( _( "<npcname> forages through the %s." ), here.tername( examp ) );
    submit_farming_choice( you, choice );
}

void trap::examine( const tripoint_bub_ms &examp ) const
{
    avatar &player_character = get_avatar();
    map &here = get_map();

    // If the player can't see the trap, they can't interact with it.
    if( !can_see( examp, player_character ) ) {
        return;
    }

    if( player_character.cant_do_mounted() ) {
        return;
    }

    if( can_not_be_disarmed() ) {
        add_msg( m_info, _( "That %s looks too dangerous to mess with.  Best leave it alone." ), name() );
        return;
    }

    // Some traps are not actual traps. Those should get a different query, no skill checks, and the option to grab it right away.
    // If there is a telepad and we are anchored, there is no risk involved in disarming it also.
    if( easy_take_down() || ( id == tr_telepad &&
                              player_character.worn_with_flag(
                                  flag_DIMENSIONAL_ANCHOR ) ) ) { // Separated so saying no doesn't trigger the other query.
        if( !query_yn( _( "There is a %s there.  Take down?" ), name() ) ) {
            return;
        }
        add_msg( _( "The %s is taken down." ), name() );
        on_disarmed( here, examp );
        return;
    }

    if( query_yn( _( "There is a %s there.  Disarm?" ), name() ) ) {
        const float traps_skill_level = player_character.get_skill_level( skill_traps );
        const float traps_knowledge_level = player_character.get_knowledge_level( skill_traps );
        const float weighted_stat_average = ( 2.0f * player_character.get_per() + 3.0f *
                                              player_character.get_dex() +
                                              player_character.get_int() ) / 6.0f;
        int proficiency_effect = -2;
        // Without at least a basic traps proficiency, your skill level is effectively 2 levels lower.
        if( player_character.has_proficiency( proficiency_prof_traps ) ) {
            proficiency_effect = 0;
            // If you have the basic traps prof, negate the above penalty
        }
        if( player_character.has_proficiency( proficiency_prof_disarming ) ) {
            proficiency_effect = 4;
            // If you have the disarming proficiency, your skill level is effectively 4 levels higher.
        }
        if( player_character.has_proficiency( proficiency_prof_trapsetting ) ) {
            proficiency_effect += 1;
            // Knowing how to set traps does give you a small bonus to disarming them as well, regardless of your other bonuses.
        }
        const float mean_roll = ( ( traps_skill_level + traps_knowledge_level ) / 2 ) +
                                ( weighted_stat_average / 4.0f ) + proficiency_effect;

        int roll = std::round( normal_roll( mean_roll, 3 ) );

        add_msg_debug( debugmode::DF_IEXAMINE, "Rolled %i, mean_roll %g. difficulty %i.", roll,
                       mean_roll, difficulty );

        //Difficulty 0 traps should succeed regardless of proficiencies. (i.e caltrops and nailboards)
        if( roll >= difficulty || difficulty == 0 ) {
            add_msg( _( "You disarm the trap!" ) );
            on_disarmed( here, examp );
            if( difficulty > 1.25 * traps_skill_level ) { // failure might have set off trap
                player_character.practice( skill_traps, 1.5 * ( difficulty - traps_skill_level ) );
            }
        } else if( roll >= ( difficulty * .8 ) ) {
            add_msg( _( "You fail to disarm the trap." ) );
            if( difficulty > 1.25 * traps_skill_level ) {
                player_character.practice( skill_traps, 1.5 * ( difficulty - traps_skill_level ) );
            }
        } else {
            add_msg( m_bad, _( "You fail to disarm the trap, and you set it off!" ) );
            trigger( examp, player_character );
            if( difficulty - roll <= 6 ) {
                // Give xp for failing, but not if we failed terribly (in which
                // case the trap may not be disarmable).
                player_character.practice( skill_traps, 2 * difficulty );
            }
        }
        //Picking up bubble wrap continuously could powerlevel trap proficiencies, with no risk involved.
        if( difficulty != 0 ) {
            player_character.practice_proficiency( proficiency_prof_traps, 5_minutes );
            // Disarming a trap gives you a token bonus to learning to set them properly.
            player_character.practice_proficiency( proficiency_prof_trapsetting, 30_seconds );
            player_character.practice_proficiency( proficiency_prof_disarming, 5_minutes );
        }

        return;
    }
}

void iexamine::part_con( Character &you, tripoint_bub_ms const &examp )
{
    prompt_partial_construction( you, examp );
}

void iexamine::water_source( Character &you, const tripoint_bub_ms &examp )
{
    finite_water_source( you, examp );
}

void iexamine::finite_water_source( Character &, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    finite_water::refresh_connected_water( here.get_abs( examp ) );
    item endless = here.liquid_from( examp );
    if( !endless.is_null() ) {
        liquid_dest_opt liquid_target;
        liquid_handler::handle_liquid( endless, liquid_target, nullptr, 0, &examp );
        return;
    }

    item finite = finite_water::finite_liquid_from( here.get_abs( examp ) );
    if( !finite.is_null() ) {
        const int before = finite.charges;
        liquid_dest_opt liquid_target;
        liquid_handler::handle_liquid( finite, liquid_target, nullptr, 0, &examp );
        const int transferred = std::max( 0, before - finite.charges );
        if( transferred > 0 ) {
            finite_water::withdraw_finite_liquid( here.get_abs( examp ), transferred );
        }
        return;
    }

    // Puddles, toilets, tide pools and water dispensers keep their liquid as
    // an ordinary map item rather than shared finite-water state.
    itype_id source_id = here.ter( examp )->liquid_source_item_id;
    if( source_id.is_null() ) {
        source_id = here.furn( examp )->liquid_source_item_id;
    }
    map_stack items = here.i_at( examp );
    for( item &it : items ) {
        if( it.made_of( phase_id::LIQUID ) && ( source_id.is_null() || it.typeId() == source_id ) ) {
            item_location loc( map_cursor( examp ), &it );
            liquid_handler::handle_liquid( loc );
            break;
        }
    }
}

const itype *furn_t::crafting_pseudo_item_type() const
{
    if( crafting_pseudo_item.is_empty() ) {
        return nullptr;
    }
    return item::find_type( crafting_pseudo_item );
}

std::vector<const itype *> furn_t::crafting_ammo_item_types() const
{
    const itype *pseudo = crafting_pseudo_item_type();
    std::vector<const itype *> output;
    if( pseudo && pseudo->tool && !pseudo->tool->ammo_id.empty() ) {
        for( const ammotype &atype : pseudo->tool->ammo_id ) {
            const itype *itype = item::find_type( atype->default_ammotype() );
            if( itype != nullptr ) {
                output.push_back( itype );
            }
        }
    }
    return output;
}

void iexamine::reload_furniture( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    furniture_reload::command choice;
    choice.origin = you.pos_abs();
    choice.target = tool_activity_target::capture( here, here.get_abs( examp ) );
    const std::string name = here.furnname( examp );
    const auto still_there = [&]() {
        return lifetime && context && you.pos_abs() == choice.origin && choice.target.matches( here );
    };
    const auto submit = [&]() {
        if( still_there() && ( !you.is_avatar() || !cata_mp::client_furniture_reload( choice ) ) ) {
            furniture_reload::execute( you, here, choice );
        }
    };
    item tool = furniture_reload::reload_tool( here, examp );
    if( tool.is_null() ) {
        you.add_msg_if_player( m_info, _( "This %s can not be reloaded!" ), name );
        return;
    }
    const auto loaded = furniture_reload::loaded_ammo( here, examp );
    if( !loaded.empty() ) {
        uilist menu;
        menu.text = name;
        menu.addentry( 0, true, MENU_AUTOASSIGN, _( "Reload" ) );
        for( size_t i = 0; i < loaded.size(); ++i ) {
            menu.addentry( static_cast<int>( i ) + 1, true, MENU_AUTOASSIGN, _( "Unload %s" ),
                           loaded[i]->tname() );
        }
        menu.query();
        if( menu.ret < 0 || static_cast<size_t>( menu.ret ) > loaded.size() || !still_there() ) {
            return;
        }
        if( menu.ret > 0 ) {
            const item_location &source = loaded[menu.ret - 1];
            if( !source ) {
                return;
            }
            choice.action = furniture_reload::operation::unload;
            choice.type = source->typeId();
            choice.source = capture_item_source( you, source );
            if( source->made_of( phase_id::LIQUID ) ) {
                choice.destination = query_liquid_destination( *source, source.get_item(),
                                     source->uid().get_value(), false );
                if( choice.destination->kind == LD_NULL ) {
                    return;
                }
            }
            submit();
            return;
        }
    }
    const item_location pseudo( map_cursor( choice.target.position ), &tool );
    const item::reload_option selected = game_menus::inv::select_ammo( you, pseudo );
    if( !selected || !still_there() ) {
        return;
    }
    const int limit = std::min( selected.qty(), furniture_reload::remaining_capacity( here, examp,
                                *selected.ammo ) );
    if( limit <= 0 ) {
        you.add_msg_if_player( m_info, _( "The %s has no room for this ammunition." ), name );
        return;
    }
    choice.source = capture_item_source( you, selected.ammo );
    choice.type = selected.ammo->typeId();
    choice.quantity = limit;
    if( query_int( choice.quantity, true, _( "Put how many of the %s into the %s?" ),
                   item::nname( choice.type, limit ), name ) &&
        choice.quantity > 0 && choice.quantity <= limit ) {
        submit();
    }
}

void iexamine::curtains( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    const bool closed_window_with_curtains = here.has_flag(
                ter_furn_flag::TFLAG_BARRICADABLE_WINDOW_CURTAINS,
                examp );
    if( !can_access_curtains( you, here, examp ) ) {
        locked_object( you, examp );
        return;
    }

    const ter_id ter = here.ter( examp );
    const terrain_examine_selection teardown{ terrain_examine_action::remove_curtains, you.pos_abs(),
                                               here.get_abs( examp ), ter.id(), std::nullopt };
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();

    // Peek through the curtains, or tear them down.
    uilist window_menu;
    window_menu.text = _( "Do what with the curtains?" );
    window_menu.addentry( 0, ( !ter.obj().close &&
                               closed_window_with_curtains ), 'p', _( "Peek through the closed curtains." ) );
    window_menu.addentry( 1, true, 't', _( "Tear down the curtains." ) );
    window_menu.query();
    if( !lifetime || !context || you.pos_abs() != teardown.origin ) {
        return;
    }
    const int choice = window_menu.ret;

    if( choice == 0 ) {
        // Peek
        g->peek( examp );
        you.add_msg_if_player( _( "You carefully peek through the curtains." ) );
    } else if( choice == 1 ) {
        submit_terrain_examine( you, here, teardown );
    } else {
        you.add_msg_if_player( _( "Never mind." ) );
    }
}

void iexamine::sign( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    std::string existing_signage = here.get_signage( examp );
    bool previous_signage_exists = !existing_signage.empty();

    // Display existing message, or lack thereof.
    if( here.furn( examp )->has_flag( ter_furn_flag::TFLAG_SIGN_ALWAYS ) || previous_signage_exists ) {
        if( you.has_trait( trait_ILLITERATE ) ) {
            popup( _( "You can't make sense of the message on the sign." ) );
        } else if( previous_signage_exists ) {
            popup( existing_signage );
        } else {
            you.add_msg_if_player( m_neutral, _( "Nothing legible on the sign." ) );
        }

        // Allow chance to modify message.
        std::vector<tool_comp> tools;
        std::vector<const item *> filter = you.crafting_inventory().items_with( []( const item & it ) {
            return it.has_flag( flag_WRITE_MESSAGE ) && it.charges > 0;
        } );
        tools.reserve( filter.size() );
        for( const item *writing_item : filter ) {
            tools.emplace_back( writing_item->typeId(), 1 );
        }
        if( !tools.empty() ) {
            // Different messages if the sign already has writing associated with it.
            std::string query_message = previous_signage_exists ?
                                        _( "Overwrite the existing message on the sign?" ) :
                                        _( "Add a message to the sign?" );
            std::string ignore_message = _( "You leave the sign alone." );
            if( query_yn( query_message ) ) {
                string_input_popup_imgui write_popup( 50 );
                write_popup.set_label( _( "Write what?" ) );
                write_popup.set_identifier( "signage" );
                std::string signage = write_popup.query();
                if( signage.empty() ) {
                    you.add_msg_if_player( m_neutral, ignore_message );
                } else {
                    std::string spray_painted_message = previous_signage_exists ?
                                                        _( "You overwrite the previous message on the sign with your graffiti." ) :
                                                        _( "You graffiti a message onto the sign." );
                    here.set_signage( examp, signage );
                    you.add_msg_if_player( m_info, spray_painted_message );
                    you.mod_moves( - 20 * signage.length() );
                    you.consume_tools( tools, 1 );
                }
            } else {
                you.add_msg_if_player( m_neutral, ignore_message );
            }
        }
    }
}

static int getNearPumpCount( const tripoint_bub_ms &p, fuel_station_fuel_type &fuel_type )
{
    int result = 0;
    map &here = get_map();
    for( const tripoint_bub_ms &tmp : here.points_in_radius( p, 12 ) ) {
        const ter_id &t = here.ter( tmp );
        if( t == ter_t_gas_pump || t == ter_t_gas_pump_a ) {
            result++;
            fuel_type = FUEL_TYPE_GASOLINE;
        } else if( t == ter_t_diesel_pump || t == ter_t_diesel_pump_a ) {
            result++;
            fuel_type = FUEL_TYPE_DIESEL;
        }
    }
    return result;
}

std::optional<tripoint_bub_ms> iexamine::getNearFilledGasTank( const tripoint_bub_ms &center,
        int &fuel_units,
        fuel_station_fuel_type &fuel_type )
{
    std::optional<tripoint_bub_ms> tank_loc;
    int distance = INT_MAX;
    fuel_units = 0;

    map &here = get_map();
    for( const tripoint_bub_ms &tmp : here.points_in_radius( center, SEEX * 2 ) ) {

        const furn_id &check_for_fuel_tank = here.furn( tmp );

        if( ( fuel_type == FUEL_TYPE_GASOLINE && check_for_fuel_tank != furn_f_gas_tank ) ||
            ( fuel_type == FUEL_TYPE_DIESEL && check_for_fuel_tank != furn_f_diesel_tank ) ) {
            continue;
        }

        const int new_distance = rl_dist( center, tmp );

        if( new_distance >= distance ) {
            continue;
        }
        if( !tank_loc ) {
            // Return a potentially empty tank, but only if we don't find a closer full one.
            tank_loc.emplace( tmp );
        }
        for( item &k : here.i_at( tmp ) ) {
            if( k.made_of( phase_id::LIQUID ) ) {
                distance = new_distance;
                tank_loc.emplace( tmp );
                fuel_units = k.charges;
                break;
            }
        }
    }
    return tank_loc;
}

static int getGasDiscountCardQuality( const item &it )
{
    for( const flag_id &tag : it.type->get_flags() ) {
        if( string_starts_with( tag->id.str(), "DISCOUNT_VALUE_" ) ) {
            ret_val<int> discount_value =
                try_parse_integer<int>( tag->id.str().substr( 15 ), false );
            if( discount_value.success() ) {
                return discount_value.value();
            } else {
                debugmsg( "Error parsing ammo DISCOUNT_VALUE_ suffix: %s", discount_value.str() );
            }
        }
    }
    return 0;
}

static int findBestGasDiscount( Character &you )
{
    int discount = 0;

    you.cache_visit_items_with( flag_GAS_DISCOUNT, [&discount]( const item_location & it ) {
        discount = std::max( discount, getGasDiscountCardQuality( *it ) );
    } );

    return discount;
}

static std::string str_to_illiterate_str( std::string s )
{
    if( !get_player_character().has_trait( trait_ILLITERATE ) ) {
        return s;
    } else {
        for( char &i : s ) {
            i = i + rng( 0, 5 ) - rng( 0, 5 );
            if( i < ' ' ) {
                // some control character, most likely not handled correctly be the print functions
                i = ' ';
            } else if( i == '%' ) {
                // avoid characters that trigger formatting in the various print functions
                i++;
            }
        }
        return s;
    }
}

static std::string getGasDiscountName( int discount )
{
    if( discount == 3 ) {
        return str_to_illiterate_str( _( "Platinum member" ) );
    } else if( discount == 2 ) {
        return str_to_illiterate_str( _( "Gold member" ) );
    } else if( discount == 1 ) {
        return str_to_illiterate_str( _( "Silver member" ) );
    } else {
        return str_to_illiterate_str( _( "Beloved customer" ) );
    }
}

static int getGasPricePerLiter( int discount )
{
    // Those prices are in cents
    static constexpr std::array<int, 4> prices = { 1400, 1320, 1200, 1000 };
    if( discount < 0 || discount > 3 ) {
        return prices[0];
    } else {
        return prices[discount];
    }
}

std::optional<tripoint_bub_ms> iexamine::getGasPumpByNumber( const tripoint_bub_ms &p, int number )
{
    int k = 0;
    map &here = get_map();
    for( const tripoint_bub_ms &tmp : here.points_in_radius( p, 12 ) ) {
        const ter_id &t = here.ter( tmp );
        if( ( t == ter_t_gas_pump || t == ter_t_gas_pump_a
              || t == ter_t_diesel_pump || t == ter_t_diesel_pump_a ) && number == k++ ) {
            return tmp;
        }
    }
    return std::nullopt;
}

bool iexamine::toPumpFuel( const tripoint_bub_ms &src, const tripoint_bub_ms &dst, int units )
{
    map &here = get_map();
    map_stack items = here.i_at( src );
    for( auto item_it = items.begin(); item_it != items.end(); ++item_it ) {
        if( item_it->made_of( phase_id::LIQUID ) ) {
            if( item_it->charges < units ) {
                return false;
            }

            item_it->charges -= units;

            item liq_d( item_it->type, calendar::turn, units );

            here.add_item_or_charges( dst, liq_d );

            if( item_it->charges < 1 ) {
                items.erase( item_it );
            }

            return true;
        }
    }

    return false;
}

static int fromPumpFuel( const tripoint_bub_ms &dst, const tripoint_bub_ms &src )
{
    map &here = get_map();
    map_stack items = here.i_at( src );
    for( auto item_it = items.begin(); item_it != items.end(); ++item_it ) {
        if( item_it->made_of( phase_id::LIQUID ) ) {
            // how much do we have in the pump?
            const int amount = item_it->charges;
            item liq_d( item_it->type, calendar::turn, amount );

            // add the charges to the destination
            const ter_id &backup_ter = here.ter( dst );
            const furn_id &backup_furn = here.furn( dst );
            here.ter_set( dst, ter_str_id::NULL_ID() );
            here.furn_set( dst, furn_str_id::NULL_ID() );
            here.add_item_or_charges( dst, liq_d );
            here.ter_set( dst, backup_ter );
            here.furn_set( dst, backup_furn );

            // remove the liquid from the pump
            items.erase( item_it );
            return amount;
        }
    }
    return -1;
}

static void turnOnSelectedPump( const tripoint_bub_ms &p, int number,
                                fuel_station_fuel_type &fuel_type )
{
    int k = 0;
    map &here = get_map();
    for( const tripoint_bub_ms &tmp : here.points_in_radius( p, 12 ) ) {
        const ter_id &t = here.ter( tmp );
        if( fuel_type == FUEL_TYPE_GASOLINE ) {
            if( t == ter_t_gas_pump || t == ter_t_gas_pump_a ) {
                if( number == k++ ) {
                    here.ter_set( tmp, ter_t_gas_pump_a );
                } else {
                    here.ter_set( tmp, ter_t_gas_pump );
                }
            }
        } else if( fuel_type == FUEL_TYPE_DIESEL ) {
            if( t == ter_t_diesel_pump || t == ter_t_diesel_pump_a ) {
                if( number == k++ ) {
                    here.ter_set( tmp, ter_t_diesel_pump_a );
                } else {
                    here.ter_set( tmp, ter_t_diesel_pump );
                }
            }
        }
    }
}

void iexamine::pay_gas( Character &you, const tripoint_bub_ms &examp )
{
    int choice = -1;
    const int buy_gas = 1;
    const int choose_pump = 2;
    const int hack = 3;
    const int refund = 4;

    if( you.has_trait( trait_ILLITERATE ) ) {
        popup( _( "You can't make sense of the text on the screen." ) );
    }

    fuel_station_fuel_type fuelType = FUEL_TYPE_NONE;
    std::string fuelTypeStr;
    int pumpCount = getNearPumpCount( examp, fuelType );
    fuelTypeStr = fuelType == FUEL_TYPE_GASOLINE ? _( "gasoline" ) : fuelType == FUEL_TYPE_DIESEL ?
                  _( "diesel" ) : "";
    if( pumpCount == 0 ) {
        popup( str_to_illiterate_str( string_format( _( "Failure!  No %s pumps found!" ), fuelTypeStr ) ) );
        return;
    }

    int tankUnits;
    const std::optional<tripoint_bub_ms> pTank_ = getNearFilledGasTank( examp, tankUnits, fuelType );
    if( !pTank_ ) {
        popup( str_to_illiterate_str( string_format( _( "Failure!  No %s tank found!" ), fuelTypeStr ) ) );
        return;
    }
    const tripoint_bub_ms pTank = *pTank_;

    if( tankUnits == 0 ) {
        popup( str_to_illiterate_str(
                   string_format( _( "This station is out of %s.  We apologize for the inconvenience." ),
                                  fuelTypeStr ) ) );
        return;
    }

    if( uistate.ags_pay_gas_selected_pump + 1 > pumpCount ) {
        uistate.ags_pay_gas_selected_pump = 0;
    }

    int discount = findBestGasDiscount( you );
    std::string discountName = getGasDiscountName( discount );

    int pricePerUnit = getGasPricePerLiter( discount );

    uilist amenu;
    amenu.selected = 1;
    amenu.text = str_to_illiterate_str( _( "Welcome to AutoGas!" ) );
    amenu.addentry( 0, false, -1, str_to_illiterate_str( _( "What would you like to do?" ) ) );

    amenu.addentry( buy_gas, true, 'b', str_to_illiterate_str( string_format( _( "Buy %s." ),
                    fuelTypeStr ) ) );
    amenu.addentry( refund, true, 'r', str_to_illiterate_str( _( "Refund cash." ) ) );

    std::string gaspumpselected = str_to_illiterate_str( string_format( _( "Current %s pump: " ),
                                  fuelTypeStr ) + std::to_string( uistate.ags_pay_gas_selected_pump + 1 ) );
    amenu.addentry( 0, false, -1, gaspumpselected );
    amenu.addentry( choose_pump, true, 'p',
                    str_to_illiterate_str( string_format( _( "Choose a %s pump." ), fuelTypeStr ) ) );

    amenu.addentry( 0, false, -1, str_to_illiterate_str( _( "Your discount: " ) ) + discountName );
    amenu.addentry( 0, false, -1, string_format( str_to_illiterate_str(
                        _( "Your price per %s unit: " ) ), fuelTypeStr )
                    +
                    format_money( pricePerUnit ) );

    if( can_hack( you ) ) {
        amenu.addentry( hack, true, 'h', _( "Hack console." ) );
    }

    amenu.query();
    choice = amenu.ret;

    if( choose_pump == choice ) {
        uilist amenu;
        amenu.selected = uistate.ags_pay_gas_selected_pump;
        amenu.text = str_to_illiterate_str( string_format( _( "Please choose %s pump:" ), fuelTypeStr ) );

        std::vector<tripoint_bub_ms> pumps;
        for( int i = 0; i < pumpCount; i++ ) {
            amenu.addentry( i, true, -1,
                            str_to_illiterate_str( _( "Pump " ) ) + std::to_string( i + 1 ) );
            pumps.emplace_back( getGasPumpByNumber( examp, i ).value_or( examp ) );
        }
        pointmenu_cb callback( pumps );
        amenu.callback = &callback;
        amenu.query();
        choice = amenu.ret;

        if( choice < 0 ) {
            return;
        }

        uistate.ags_pay_gas_selected_pump = choice;

        turnOnSelectedPump( examp, uistate.ags_pay_gas_selected_pump, fuelType );

        return;

    }

    if( buy_gas == choice ) {
        int money = you.charges_of( itype_cash_card );

        if( money < pricePerUnit ) {
            popup( str_to_illiterate_str(
                       _( "Not enough money, please refill your cash card." ) ) ); //or ride on a solar car, ha ha ha
            return;
        }

        int maximum_liters = std::min( money / pricePerUnit, tankUnits / 1000 );

        int liters = maximum_liters;
        if( !query_int( liters, true, str_to_illiterate_str(
                            _( "How many liters of %s to buy?  Max: %d L." ) ).c_str(),
                        fuelTypeStr, maximum_liters ) || liters <= 0 ) {
            return;
        }
        clamp( liters, 0, maximum_liters );

        const std::optional<tripoint_bub_ms> pGasPump = getGasPumpByNumber( examp,
                uistate.ags_pay_gas_selected_pump );
        if( !pGasPump || !toPumpFuel( pTank, *pGasPump, liters * 1000 ) ) {
            return;
        }

        sounds::sound( you.pos_bub(), 6, sounds::sound_t::activity, _( "Glug Glug Glug" ), true, "tool",
                       "gaspump" );

        int cost = liters * pricePerUnit;
        money -= cost;
        you.use_charges( itype_cash_card, cost );

        add_msg( m_info, _( "Your cash cards now hold %s." ), format_money( money ) );
        you.mod_moves( -to_moves<int>( 5_seconds ) );
        return;
    }

    if( hack == choice ) {
        try_start_hacking( you, examp );
    }

    if( refund == choice ) {
        std::vector<item_location> cash_cards = you.cache_get_items_with( "is_cash_card",
                                                &item::is_cash_card );
        if( cash_cards.empty() ) {
            popup( _( "You do not have a cash card to refund money!" ) );
            return;
        }

        const std::optional<tripoint_bub_ms> pGasPump = getGasPumpByNumber( examp,
                uistate.ags_pay_gas_selected_pump );
        int amount_fuel = pGasPump ? fromPumpFuel( pTank, *pGasPump ) : -1;
        if( amount_fuel < 0 ) {
            popup( _( "Unable to refund, no fuel in pump." ) );
            return;
        }
        sounds::sound( you.pos_bub(), 6, sounds::sound_t::activity, _( "Glug Glug Glug" ), true, "tool",
                       "gaspump" );

        // getGasPricePerLiter( platinum_discount) min price to avoid exploit
        int amount_money = amount_fuel * getGasPricePerLiter( 3 ) / 1000.0f;
        std::sort( cash_cards.begin(), cash_cards.end(), []( item_location & l, const item_location & r ) {
            return l->ammo_remaining( ) > r->ammo_remaining( );
        } );
        for( item_location &cc : cash_cards ) {
            if( amount_money == 0 ) {
                break;
            }
            const int transfer = std::min( amount_money, cc->remaining_ammo_capacity() );
            cc->ammo_set( cc->ammo_default(), transfer + cc->ammo_remaining( ) );
            amount_money -= transfer;
        }
        if( amount_money ) {
            add_msg( m_info, _( "All cash cards at maximum capacity." ) );
            // all fuel already removed from pump, so remaining amount_money simply ignored
        }
        add_msg( m_info, _( "Your cash cards now hold %s." ),
                 format_money( you.charges_of( itype_cash_card ) ) );
        you.mod_moves( -to_moves<int>( 5_seconds ) );
        return;
    }
}

void iexamine::ledge( Character &you, const tripoint_bub_ms &examp )
{
    enum ledge_actions {
        ledge_peek_down = 1,
        ledge_jump_across,
        ledge_fall_down,
        ledge_examine_furniture_below,
        ledge_glide,
    };

    map &here = get_map();
    if( !you.is_avatar() || cata_mp::client_query_ledge_move( here.get_abs( examp ) ) ) {
        return;
    }
    const character_action_guard lifetime( you );
    const auto origin = you.pos_abs();
    const auto ledge_position = here.get_abs( examp );
    const tripoint_bub_ms pos = you.pos_bub( here );

    tripoint_bub_ms jump_target( pos.x() + 2 * sgn( examp.x() - pos.x() ),
                                 pos.y() + 2 * sgn( examp.y() - pos.y() ),
                                 pos.z() );
    bool jump_target_valid = !here.is_open_air( jump_target );
    tripoint_bub_ms just_below = examp + tripoint::below;

    uilist cmenu;
    cmenu.text = _( "There is a ledge here.  What do you want to do?" );

    // NOTE this menu is merged with the climb down menu, manage keys carefully.
    cmenu.addentry( ledge_peek_down, true, 'p', _( "Peek down." ) );
    g->climb_down_menu_gen( you, examp, cmenu );
    if( here.has_flag_furn( "EXAMINE_FROM_ABOVE", just_below ) ) {
        cmenu.addentry( ledge_examine_furniture_below, true, 'e',
                        _( "Reach for the %s below." ), here.furn( just_below ).obj().name() );
    }
    cmenu.addentry( ledge_jump_across, jump_target_valid, 'j',
                    ( jump_target_valid ? _( "Jump across." ) : _( "Can't jump across (need a small gap)." ) ) );
    cmenu.addentry( ledge_fall_down, true, 'f', _( "Fall down." ) );
    if( you.has_flag( json_flag_GLIDE ) || you.has_flag( json_flag_WING_GLIDE ) ||
        you.has_bodypart_with_flag( json_flag_WING_ARMS ) ) {
        cmenu.addentry( ledge_glide, you.can_glide(), 'g',
                        ( you.can_glide() ? _( "Glide away." ) : _( "You can't glide in your current state" ) ) );
    }
    cmenu.query();


    if( !lifetime || you.pos_abs() != origin || !here.inbounds( ledge_position ) ||
        here.get_abs( examp ) != ledge_position ) {
        return;
    }
    vertical_move_selection choice;
    choice.origin = origin;
    choice.target = ledge_position;
    choice.direction = -1;
    if( g->climb_down_menu_pick( examp, cmenu.ret ) ) {
        // This branch means the player chose some option generated by the climb menu.
        return;
    }
    switch( cmenu.ret ) {
        case ledge_jump_across:
            choice.action = "ledge_jump";
            choice.choices.landing = here.get_abs( jump_target );
            execute_vertical_move( you, here, choice );
            break;
        case ledge_peek_down: {
            const auto where = ledge_peek_position( you, here, ledge_position );
            if( !where ) {
                you.add_msg_if_player( _( "You can't peek down there." ) );
                return;
            }
            g->peek( here.get_bub( *where ) );
            if( lifetime ) {
                you.add_msg_if_player( _( "You peek over the ledge." ) );
            }
            break;
        }
        case ledge_examine_furniture_below: {
            // Examine the furniture below.
            here.furn( just_below ).obj().examine( you, just_below );
            break;
        }
        case ledge_glide:
            choice.action = "ledge_glide";
            execute_vertical_move( you, here, choice );
            break;
        case ledge_fall_down:
            choice.action = "ledge_fall";
            choice.choices.allow_one_way = you.query_yn(
                                               _( "Climbing might be safer.  Really fall from the ledge?" ) );
            if( lifetime ) {
                execute_vertical_move( you, here, choice );
            }
            break;
        default:
            popup( _( "You decided to step back from the ledge." ) );
            break;
    }
}

static Character &player_on_couch( Character &you, const tripoint_bub_ms &autodoc_loc,
                                   Character &null_patient, bool &adjacent_couch, tripoint_bub_ms &couch_pos )
{
    map &here = get_map();
    for( const tripoint_bub_ms &couch_loc : here.points_in_radius( autodoc_loc, 1 ) ) {
        if( here.has_flag_furn( ter_furn_flag::TFLAG_AUTODOC_COUCH, couch_loc ) ) {
            adjacent_couch = true;
            couch_pos = couch_loc;
            if( you.pos_bub() == couch_loc ) {
                return you;
            }
            for( const npc *e : g->allies() ) {
                if( e->pos_bub() == couch_loc ) {
                    return  *g->critter_by_id<Character>( e->getID() );
                }
            }
        }
    }
    return null_patient;
}

static Character &operator_present( Character &you, const tripoint_bub_ms &autodoc_loc,
                                    Character &null_patient )
{
    map &here = get_map();
    for( const tripoint_bub_ms &loc : here.points_in_radius( autodoc_loc, 1 ) ) {
        if( !here.has_flag_furn( ter_furn_flag::TFLAG_AUTODOC_COUCH, loc ) ) {
            if( you.pos_bub() == loc ) {
                return you;
            }
            for( const npc *e : g->allies() ) {
                if( e->pos_bub() == loc ) {
                    return  *g->critter_by_id<Character>( e->getID() );
                }
            }
        }
    }
    return null_patient;
}

static item &cyborg_on_couch( const tripoint_bub_ms &couch_pos, item &null_cyborg )
{
    for( item &it : get_map().i_at( couch_pos ) ) {
        if( it.typeId() == itype_bot_broken_cyborg || it.typeId() == itype_bot_prototype_cyborg ) {
            return it;
        }
        if( it.typeId() == itype_corpse ) {
            if( it.get_mtype()->id == mon_broken_cyborg || it.get_mtype()->id == mon_prototype_cyborg ) {
                return it;
            }
        }
    }
    return null_cyborg;
}

static Character &best_installer( Character &you, Character &null_player, int difficulty )
{
    std::vector< std::pair<int, int>> ally_chances;
    ally_chances.reserve( g->allies().size() );
    for( size_t i = 0; i < g->allies().size() ; i ++ ) {
        std::pair<int, int> ally_skill;
        const npc *e = g->allies()[ i ];

        Character &ally = *g->critter_by_id<Character>( e->getID() );
        ally_skill.second = i;
        ally_skill.first = bionic_success_chance( true, -1, difficulty, ally );
        ally_chances.push_back( ally_skill );
    }
    std::sort( ally_chances.begin(), ally_chances.end(), [&]( const std::pair<int, int> &lhs,
    const std::pair<int, int> &rhs ) {
        return rhs.first < lhs.first;
    } );
    int player_cos = bionic_success_chance( true, -1, difficulty, you );
    avatar &player_character = get_avatar();
    for( size_t i = 0; i < g->allies().size() ; i ++ ) {
        if( ally_chances[ i ].first > player_cos ) {
            const npc *e = g->allies()[ ally_chances[ i ].second ];
            Character &ally = *g->critter_by_id<Character>( e->getID() );
            if( e->has_effect( effect_sleep ) ) {
                if( !player_character.query_yn(
                        //~ %1$s is the name of the ally
                        _( "<color_white>%1$s is asleep, but has a <color_green>%2$d<color_white> chance of success compared to your <color_red>%3$d<color_white> chance of success.  Continue with a higher risk of failure?</color>" ),
                        ally.disp_name(), ally_chances[i].first, player_cos ) ) {
                    return null_player;
                } else {
                    continue;
                }
            }
            //~ %1$s is the name of the ally
            add_msg( _( "%1$s will perform the operation with a %2$d chance of success." ), ally.disp_name(),
                     ally_chances[i].first );
            return ally;
        } else {
            break;
        }
    }

    return you;
}

template<typename ...Args>
static inline void popup_player_or_npc( Character &you, const char *player_mes, const char *npc_mes,
                                        Args &&... args )
{
    if( you.is_avatar() ) {
        popup( player_mes, std::forward<Args>( args )... );
    } else {
        popup( you.replace_with_npc_name( string_format( npc_mes, std::forward<Args>( args )... ) ) );
    }
}

void iexamine::autodoc( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    enum options {
        INSTALL_CBM,
        UNINSTALL_CBM,
        BONESETTING,
        TREAT_WOUNDS,
        RAD_AWAY,
        BLOOD_ANALYSIS,
    };

    bool adjacent_couch = false;
    static avatar null_player;
    tripoint_bub_ms couch_pos;
    Character &patient = player_on_couch( you, examp, null_player, adjacent_couch, couch_pos );
    Character &Operator = operator_present( you, examp, null_player );

    static item null_cyborg;
    item &cyborg = cyborg_on_couch( couch_pos, null_cyborg );

    if( !adjacent_couch ) {
        popup( _( "No connected couches found.  Operation impossible.  Exiting." ) );
        return;
    }
    if( &patient == &null_player ) {
        if( &cyborg != &null_cyborg ) {
            if( cyborg.typeId() == itype_corpse && !cyborg.active ) {
                popup( _( "Patient is dead.  Please remove corpse to proceed.  Exiting." ) );
                return;
            } else if( cyborg.typeId() == itype_bot_broken_cyborg ||
                       cyborg.typeId() == itype_corpse ) {
                popup( _( "ERROR Bionic Level Assessment: FULL CYBORG.  Autodoc Mk. XI can't operate.  Please move patient to appropriate facility.  Exiting." ) );
                return;
            }

            uilist cmenu;
            cmenu.text = _( "Autodoc Mk. XI.  Status: Online.  Please choose operation." );
            cmenu.addentry( 1, true, 'i', _( "Choose Compact Bionic Module to install." ) );
            cmenu.addentry( 2, true, 'u', _( "Choose installed bionic to uninstall." ) );
            cmenu.query();

            switch( cmenu.ret ) {
                case 1: {
                    popup( _( "ERROR NO SPACE AVAILABLE.  Operation impossible.  Exiting." ) );
                    break;
                }
                case 2: {
                    std::vector<std::string> choice_names;
                    choice_names.emplace_back( _( "Personality_Override" ) );
                    for( size_t i = 0; i < 6; i++ ) {
                        choice_names.emplace_back( _( "C0RR#PTED?D#TA" ) );
                    }
                    int choice_index = uilist( _( "Choose bionic to uninstall" ), choice_names );
                    if( choice_index == 0 ) {
                        g->save_cyborg( &cyborg, couch_pos, you );
                    } else {
                        popup( _( "UNKNOWN COMMAND.  Autodoc Mk. XI. Crashed." ) );
                        return;
                    }
                    break;
                }
                default:
                    return;
            }
            return;
        } else {
            popup( _( "No patient found located on the connected couches.  Operation impossible.  Exiting." ) );
            return;
        }
    } else if( patient.activity.id() == ACT_OPERATION ) {
        popup( _( "Operation underway.  Please wait until the end of the current procedure.  Estimated time remaining: %s." ),
               to_string( time_duration::from_moves( patient.activity.moves_left ) ) );
        you.add_msg_if_player( m_info, _( "The Autodoc is working on %s." ), patient.disp_name() );
        return;
    }

    const bool unsafe_usage = &Operator == &null_player || ( &Operator == &you && &patient == &you );
    std::string autodoc_header = _( "Autodoc Mk. XI.  Status: Online.  Please choose operation." );
    if( unsafe_usage ) {
        const std::string &warning_sign = colorize( " /", c_yellow ) + colorize( "!",
                                          c_red ) + colorize( "\\", c_yellow );
        const std::string &warning = warning_sign + colorize( _( " WARNING: Operator missing" ),
                                     c_red ) + warning_sign;
        autodoc_header = warning +
                         _( "\n Using the Autodoc without an operator can lead to <color_light_cyan>serious injuries</color> or <color_light_cyan>death</color>.\n By continuing with the operation you accept the risks and acknowledge that you will not take any legal actions against this facility in case of an accident. " );
    }

    std::vector<item> arm_splints;
    std::vector<item> leg_splints;

    for( const item &supplies : here.i_at( examp ) ) {
        if( supplies.typeId() == itype_arm_splint ) {
            arm_splints.push_back( supplies );
        }
        if( supplies.typeId() == itype_leg_splint ) {
            leg_splints.push_back( supplies );
        }
    }

    autodoc_header +=
        string_format(
            _( "\n\n<color_white>Internal supplies:</color>\n Arm splints: %d\n Leg splints: %d" ),
            arm_splints.size(), leg_splints.size() );

    uilist amenu;
    amenu.text = autodoc_header;
    amenu.addentry( INSTALL_CBM, true, 'i', _( "Choose Compact Bionic Module to install" ) );
    amenu.addentry( UNINSTALL_CBM, true, 'u', _( "Choose installed bionic to uninstall" ) );
    amenu.addentry( BONESETTING, true, 's', _( "Splint broken limbs" ) );
    amenu.addentry( TREAT_WOUNDS, true, 'w', _( "Treat wounds" ) );
    amenu.addentry( RAD_AWAY, true, 'r', _( "Check radiation level" ) );
    amenu.addentry( BLOOD_ANALYSIS, true, 'b', _( "Conduct blood analysis" ) );

    amenu.query();

    bool needs_anesthesia = true;
    std::vector<tool_comp> anesth_kit;

    if( patient.has_flag( json_flag_PAIN_IMMUNE ) || patient.has_bionic( bio_painkiller ) ||
        amenu.ret > 1 ) {
        needs_anesthesia = false;
    } else {
        const temp_crafting_inventory &crafting_inv = you.crafting_inventory();
        std::vector<const item *> a_filter = crafting_inv.items_with( []( const item & it ) {
            return it.has_quality( qual_ANESTHESIA );
        } );
        for( const item *anesthesia_item : a_filter ) {
            if( anesthesia_item->ammo_remaining( ) >= 1 ) {
                anesth_kit.emplace_back( anesthesia_item->typeId(), 1 );
            }
        }
    }

    switch( amenu.ret ) {
        case INSTALL_CBM: {
            item_location bionic = game_menus::inv::install_bionic( you, you, patient );

            if( !bionic ) {
                return;
            }

            const itype *itemtype = bionic.get_item()->type;
            const std::string bionic_name = bionic.get_item()->typeId().c_str();

            Character &installer = best_installer( you, null_player, itemtype->bionic->difficulty );
            if( &installer == &null_player ) {
                return;
            }

            std::vector<item_comp> progs;
            bool has_install_program = false;

            std::vector<const item *> install_programs = you.crafting_inventory().items_with( [itemtype](
                        const item & it ) -> bool { return it.typeId() == itemtype->bionic->installation_data; } );

            if( !install_programs.empty() ) {
                has_install_program = true;
                progs.emplace_back( install_programs[0]->typeId(), 1 );
            }

            const int weight = units::to_kilogram( patient.bodyweight() ) / 10;
            const int surgery_duration = itemtype->bionic->difficulty * 2;
            const requirement_data req_anesth = *requirement_data_anesthetic *
                                                surgery_duration * weight;

            if( patient.can_install_bionics( ( *itemtype ), installer, true, has_install_program ? 10 : -1 ) ) {
                const time_duration duration = itemtype->bionic->difficulty * 20_minutes;
                patient.introduce_into_anesthesia( duration, installer, needs_anesthesia );
                std::optional<item> source_item = *bionic.get_item();
                bionic.remove_item();
                if( needs_anesthesia ) {
                    for( const auto &e : req_anesth.get_components() ) {
                        you.consume_items( e, 1, is_crafting_component );
                    }
                    for( const auto &e : req_anesth.get_tools() ) {
                        you.consume_tools( e );
                    }
                    you.invalidate_crafting_inventory();
                }
                installer.mod_moves( -to_moves<int>( 1_minutes ) );

                patient.install_bionics( ( *itemtype ), installer, true, has_install_program ? 10 : -1,
                                         source_item );

                if( has_install_program ) {
                    you.consume_items( progs );
                }
            }
            break;
        }

        case UNINSTALL_CBM: {
            const bionic_collection &installed_bionics = *patient.my_bionics;
            if( installed_bionics.empty() ) {
                popup_player_or_npc( patient, _( "You don't have any bionics installed." ),
                                     _( "<npcname> doesn't have any bionics installed." ) );
                return;
            }

            std::vector<bionic_id> bio_list;
            std::vector<std::string> bionic_names;
            std::vector<const bionic *> bionics;
            for( const bionic &bio : installed_bionics ) {
                if( item::type_is_defined( bio.info().itype() ) ) {
                    bio_list.emplace_back( bio.id );
                    bionic_names.emplace_back( bio.info().name.translated() );
                    bionics.push_back( &bio );
                }
            }
            int bionic_index = uilist( _( "Choose bionic to uninstall" ), bionic_names );
            if( bionic_index < 0 ) {
                return;
            }

            const bionic_id &bid = bio_list[bionic_index];
            const int difficulty =  bid->itype()->bionic->difficulty;
            const float volume_anesth = difficulty * 20 * 2; // 2ml/min

            Character &installer = best_installer( you, null_player, difficulty );
            if( &installer == &null_player ) {
                return;
            }

            if( patient.can_uninstall_bionic( *bionics[bionic_index], installer, true ) ) {
                const time_duration duration = difficulty * 20_minutes;
                patient.introduce_into_anesthesia( duration, installer, needs_anesthesia );
                if( needs_anesthesia ) {
                    you.consume_tools( anesth_kit, volume_anesth );
                }
                installer.mod_moves( -to_moves<int>( 1_minutes ) );
                patient.uninstall_bionic( *bionics[bionic_index], installer, true );
            }
            break;
        }

        case BONESETTING: {
            if( arm_splints.empty() && leg_splints.empty() ) {
                popup( _( "Internal supply of splints exhausted.  Operation impossible.  Exiting." ) );
                return;
            }

            int broken_limbs_count = 0;
            for( const bodypart_id &part :
                 patient.get_all_body_parts( get_body_part_flags::only_main ) ) {
                const bool broken = patient.is_limb_broken( part );
                effect &existing_effect = patient.get_effect( effect_mending, part );
                // Skip part if not broken or already healed 50%
                if( !broken || ( !existing_effect.is_null() &&
                                 existing_effect.get_duration() >
                                 existing_effect.get_max_duration() - 5_days - 1_turns ) ) {
                    continue;
                }
                broken_limbs_count++;
                patient.mod_moves( -to_moves<int>( 5_seconds ) );
                // TODO: fail here if unable to perform the action, i.e. can't wear more, trait mismatch.
                int quantity = 1;
                if( part == bodypart_id( "arm_l" ) || part == bodypart_id( "arm_r" ) ) {
                    if( !arm_splints.empty() ) {
                        for( const item &it : here.use_amount( examp, 1, itype_arm_splint, quantity ) ) {
                            patient.wear_item( it, false );
                        }
                    } else {
                        popup( _( "Internal supply of arm splints exhausted.  Splinting broken arms impossible.  Exiting." ) );
                        continue;
                    }
                } else if( part == bodypart_id( "leg_l" ) || part == bodypart_id( "leg_r" ) ) {
                    if( !leg_splints.empty() ) {
                        for( const item &it : here.use_amount( examp, 1, itype_leg_splint, quantity ) ) {
                            patient.wear_item( it, false );
                        }
                    } else {
                        popup( _( "Internal supply of leg splints exhausted.  Splinting broken legs impossible.  Exiting." ) );
                        continue;
                    }
                }

                if( patient.worn_with_flag( flag_SPLINT, part ) ) {
                    patient.add_msg_player_or_npc( m_good, _( "The machine rapidly sets and splints your broken %s." ),
                                                   _( "The machine rapidly sets and splints <npcname>'s broken %s." ),
                                                   body_part_name( part ) );
                    patient.add_effect( effect_mending, 0_turns, part, true );
                    effect &mending_effect = patient.get_effect( effect_mending, part );
                    mending_effect.set_duration( mending_effect.get_max_duration() - 5_days );
                }
            }
            if( broken_limbs_count == 0 ) {
                popup_player_or_npc( patient, _( "You have no limbs that require splinting." ),
                                     _( "<npcname> doesn't have limbs that require splinting." ) );
            }
            break;
        }

        case TREAT_WOUNDS: {
            if( !patient.has_effect( effect_bleed ) && !patient.has_effect( effect_infected ) &&
                !patient.has_effect( effect_bite ) ) {
                you.add_msg_player_or_npc( m_info, _( "You don't have any wounds that need treatment." ),
                                           _( "<npcname> doesn't have any wounds that need treatment." ) );
                return;
            }

            if( patient.has_effect( effect_infected ) || patient.has_effect( effect_tetanus ) ) {
                if( patient.has_effect( effect_strong_antibiotic ) ||
                    patient.has_effect( effect_antibiotic ) ||
                    patient.has_effect( effect_weak_antibiotic ) ) {
                    patient.add_msg_player_or_npc( m_info,
                                                   _( "The Autodoc detected a bacterial infection in your body, but as it also detected you've already taken antibiotics, it decided not to apply another dose right now." ),
                                                   _( "The Autodoc detected a bacterial infection in <npcname>'s body, but as it also detected they've already taken antibiotics, it decided not to apply another dose right now." ) );
                } else {
                    patient.add_effect( effect_strong_antibiotic, 12_hours );
                    patient.add_effect( effect_strong_antibiotic_visible, rng( 9_hours, 15_hours ) );
                    patient.mod_pain( 3 );
                    patient.add_msg_player_or_npc( m_good,
                                                   _( "The Autodoc detected a bacterial infection in your body and injected antibiotics to treat it." ),
                                                   _( "The Autodoc detected a bacterial infection in <npcname>'s body and injected antibiotics to treat it." ) );

                    if( patient.has_effect( effect_tetanus ) ) {
                        if( one_in( 3 ) ) {
                            patient.remove_effect( effect_tetanus );
                            patient.add_msg_if_player( m_good, _( "The muscle spasms start to go away." ) );
                        } else {
                            patient.add_msg_if_player( m_warning, _( "The medication does nothing to help the spasms." ) );
                        }
                    }
                }
            }

            for( const bodypart_id &bp_healed :
                 patient.get_all_body_parts( get_body_part_flags::only_main ) ) {
                if( patient.has_effect( effect_bleed, bp_healed.id() ) ) {
                    patient.remove_effect( effect_bleed, bp_healed );
                    patient.add_msg_player_or_npc( m_good,
                                                   _( "The Autodoc detected ongoing blood loss from your %s and administered you hemostatic drugs to stop it." ),
                                                   _( "The Autodoc detected ongoing blood loss from <npcname>'s %s and administered them hemostatic drugs to stop it." ),
                                                   body_part_name( bp_healed ) );
                }

                if( patient.has_effect( effect_bite, bp_healed.id() ) ) {
                    patient.remove_effect( effect_bite, bp_healed );
                    patient.add_msg_player_or_npc( m_good,
                                                   _( "The Autodoc detected an open wound on your %s and applied disinfectant to sterilize it." ),
                                                   _( "The Autodoc detected an open wound on <npcname>'s %s and applied disinfectant to sterilize it." ),
                                                   body_part_name( bp_healed ) );

                    // Fixed disinfectant intensity of 4 disinfectant_power + 10 first aid skill level of Autodoc.
                    const int disinfectant_intensity = 14;
                    patient.add_effect( effect_disinfected, 1_turns, bp_healed );
                    effect &e = patient.get_effect( effect_disinfected, bp_healed );
                    e.set_duration( e.get_int_dur_factor() * disinfectant_intensity );
                    patient.set_part_damage_disinfected( bp_healed,
                                                         patient.get_part_hp_max( bp_healed ) - patient.get_part_hp_cur( bp_healed ) );
                }
            }
            patient.mod_moves( -to_moves<int>( 5_seconds ) );
            break;
        }

        case RAD_AWAY: {
            patient.mod_moves( -to_moves<int>( 5_seconds ) );
            patient.add_msg_player_or_npc( m_info,
                                           _( "The Autodoc scanned you and detected a radiation level of %d mSv." ),
                                           _( "The Autodoc scanned <npcname> and detected a radiation level of %d mSv." ),
                                           patient.get_rad() );
            if( patient.get_rad() ) {
                if( patient.has_effect( effect_pblue ) ) {
                    patient.add_msg_player_or_npc( m_info,
                                                   _( "The Autodoc detected an anti-radiation drug in your bloodstream, so it decided not to administer you another dose right now." ),
                                                   _( "The Autodoc detected an anti-radiation drug in <npcname>'s bloodstream, so it decided not to administer them another dose right now." ) );
                } else {
                    add_msg( m_good,
                             _( "The Autodoc administered an anti-radiation drug to treat radiation poisoning." ) );
                    patient.mod_pain( 3 );
                    patient.add_effect( effect_pblue, 1_hours );
                }
            }
            if( static_cast<int>( patient.get_leak_level() ) ) {
                popup( _( "Warning!  Autodoc detected a radiation leak of %d mSv from items in patient's possession.  Urgent decontamination procedures highly recommended." ),
                       static_cast<int>( patient.get_leak_level() ) );
            }
            break;
        }

        case BLOOD_ANALYSIS: {
            patient.mod_moves( -to_moves<int>( 5_seconds ) );
            patient.conduct_blood_analysis();
            patient.add_msg_player_or_npc( m_info,
                                           _( "The Autodoc analyzed your blood." ),
                                           _( "The Autodoc analyzed <npcname>'s blood." ) );
            break;
        }

        default:
            return;
    }
}

static std::optional<comp_selection<item_comp>> choose_mill_input(
        Character &who, map &here, units::volume remaining )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    const tripoint_abs_ms origin = who.pos_abs();
    const auto filter = [&]( const item &entry ) {
        return mill::accepts( entry ) && entry.is_owned_by( who, true ) &&
               !craft_reservation::contains_reserved( entry );
    };
    temp_crafting_inventory combined = who.crafting_inventory();
    combined.remove_items_with( [&]( const item &entry ) {
        return !filter( entry );
    } );

    uilist menu;
    menu.text = _( "Load mill with what kind of product?" );
    std::vector<item_comp> choices;
    std::set<itype_id> listed;
    for( const item *entry : combined.items_with( []( const item & ) { return true; } ) ) {
        const itype_id &type = entry->typeId();
        if( !listed.insert( type ).second ) {
            continue;
        }
        const int available = entry->count_by_charges() ? combined.charges_of( type ) :
                              combined.amount_of( type );
        const units::volume unit_volume = entry->base_volume();
        const int fitting = unit_volume > 0_ml ? std::min<int>( available, remaining / unit_volume ) :
                            available;
        menu.addentry( static_cast<int>( choices.size() ), fitting > 0, MENU_AUTOASSIGN,
                       "%d %s", available, item::nname( type, available ) );
        choices.emplace_back( type, fitting );
    }
    if( choices.empty() ) {
        who.add_msg_if_player( _( "You don't have any products that can be milled." ) );
        return std::nullopt;
    }
    menu.query();
    if( !lifetime || !context || who.pos_abs() != origin ||
        menu.ret < 0 || static_cast<size_t>( menu.ret ) >= choices.size() ) {
        return std::nullopt;
    }
    item_comp choice = choices[menu.ret];
    int amount = choice.count;
    if( !query_int( amount, true, _( "Insert how many %s into the mill?" ),
                    item::nname( choice.type, choice.count ) ) || !lifetime || !context ||
        who.pos_abs() != origin || amount <= 0 ) {
        return std::nullopt;
    }
    if( amount > choice.count ) {
        who.add_msg_if_player( m_info, _( "You can't place that many." ) );
        return std::nullopt;
    }
    choice.count = amount;
    temp_crafting_inventory nearby;
    nearby.form_from_map( who.pos_bub( here ), pickup_range, &who );
    const auto selected = who.select_item_component( { choice }, 1, nearby, true, filter );
    if( selected.use_from == usage_from::cancel || !lifetime || !context || who.pos_abs() != origin ) {
        return std::nullopt;
    }
    return selected;
}

void iexamine::quern_examine( Character &who, const tripoint_bub_ms &tile )
{
    map &here = get_map();
    if( !mill::can_operate( who, here, tile ) ) {
        return;
    }
    mill::command choice = mill::inspect( who, here, tile );
    const auto dispatch = [&]() {
        if( !who.is_avatar() || !cata_mp::client_mill_command( choice ) ) {
            mill::execute( who, here, choice );
        }
    };
    if( mill::needs_recovery( here, tile ) ) {
        choice.action = mill::operation::recover;
        dispatch();
        return;
    }

    const bool active = mill::is_active( here, tile );
    time_duration time_left = 0_turns;
    units::volume occupied = 0_ml;
    for( const item &entry : here.i_at( tile ) ) {
        if( entry.typeId() == mill::clock_type ) {
            time_left = time_duration::from_turns( entry.item_counter );
        } else {
            occupied += entry.volume();
        }
    }
    const bool empty = choice.contents.empty();
    const units::volume remaining = mill::capacity - occupied;

    uilist menu;
    menu.text = _( "What to do with the mill?" );
    menu.desc_enabled = true;
    menu.addentry( 0, true, 'i', _( "Inspect mill" ) );
    if( active ) {
        menu.addentry_desc( 4, true, 'x', _( "Apply brake to mill" ),
                            _( "Applying the brake will stop milling process." ) );
    } else {
        menu.addentry_desc( 1, !empty, 'r', _( "Remove brake and start milling" ),
                            string_format( _( "Remove brake and start milling, milling will take about %s." ),
                                           to_string( mill::duration ) ) );
        menu.addentry_desc( 2, remaining > 0_ml, 'p',
                            remaining <= 0_ml ? _( "Insert products for milling… mill is full" ) :
                            string_format( _( "Insert products for milling… remaining capacity is %s %s" ),
                                           format_volume( remaining ), volume_units_abbr() ),
                            _( "Fill the mill with starchy products such as wheat, barley or oats." ) );
        menu.addentry( 3, !empty, 'e', _( "Remove products from mill" ) );
    }
    const character_action_guard lifetime( who );
    const auto context = here.get_context_reference();
    menu.query();
    if( !lifetime || !context || who.pos_abs() != choice.origin ) {
        return;
    }
    switch( menu.ret ) {
        case 0: {
            const restore_on_out_of_scope restore_rng( rng_get_engine() );
            std::string details = colorize( active ? _( "There's a mill here.  It is turning and milling." ) :
                                             _( "There's a mill here." ), c_green ) + "\n";
            if( active && time_left > 0_turns ) {
                details += string_format( _( "It should take about %s to finish milling." ),
                                          to_string_clipped( time_left ) ) + "\n";
            }
            details += colorize( _( "You inspect its contents and find: " ), c_green ) + "\n\n";
            const map_stack contents = here.i_at( tile );
            if( contents.empty() ) {
                details += _( "…that it is empty." );
            }
            for( const item &entry : contents ) {
                if( entry.typeId() != mill::clock_type ) {
                    details += "-> " + entry.display_name() + "\n";
                }
            }
            popup( details, PF_NONE );
            return;
        }
        case 1:
            choice.action = mill::operation::start;
            break;
        case 2:
            choice.action = mill::operation::load;
            choice.input = choose_mill_input( who, here, remaining );
            if( !choice.input ) {
                return;
            }
            break;
        case 3:
            choice.action = mill::operation::unload;
            break;
        case 4:
            choice.action = mill::operation::stop;
            break;
        default:
            return;
    }
    dispatch();
}

void iexamine::smoker_options( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    using smoking_rack::operation;
    const bool remote = you.is_avatar() && cata_mp::is_client_mode();
    if( smoking_rack::needs_recovery( here, examp ) ) {
        if( remote ) {
            submit_smoking_rack_choice( you, here, smoking_rack::capture( you, here, examp,
                                        operation::recover ) );
            return;
        }
        smoking_rack::reconcile( here, examp );
    }
    const furn_id f = here.furn( examp );
    const bool active = smoking_rack::is_active( f );
    const bool portable = smoking_rack::is_portable( f );
    if( !active && !smoking_rack::is_idle( f ) ) {
        return;
    }
    const character_action_guard lifetime( you );
    const auto context = here.get_context_reference();
    const auto observed = smoking_rack::capture( you, here, examp, operation::recover );
    const auto still_at_rack = [&]() {
        return lifetime && context && you.pos_abs() == observed.origin &&
               observed.target.matches( here ) &&
               smoking_rack::capture( you, here, examp, operation::recover ).batch == observed.batch;
    };
    const auto submit = [&]( operation action ) {
        if( still_at_rack() ) {
            submit_smoking_rack_choice( you, here, smoking_rack::capture( you, here, examp, action ) );
        }
    };
    const map_stack items_here = here.i_at( examp );

    time_duration time_left = 0_turns;
    int hours_left = 0;
    int minutes_left = 0;
    units::volume f_volume = 0_ml;
    bool f_check = false;

    for( const item &it : items_here ) {
        if( it.is_food() ) {
            f_check = true;
            f_volume += it.volume();
        }
        if( active && smoking_rack::is_embers( it ) ) {
            time_left = time_duration::from_turns( it.item_counter );
            hours_left = to_hours<int>( time_left );
            minutes_left = to_minutes<int>( time_left ) + 1;
        }
    }

    const units::volume capacity = smoking_rack::food_capacity( f );
    const auto remaining_capacity = capacity - f_volume;
    const bool empty = f_volume == 0_ml;
    const bool full = remaining_capacity <= 0_ml;
    const bool has_coal_in_inventory = you.crafting_inventory().charges_of( itype_charcoal ) > 0;
    const int coal_charges = count_charges_in_list( item::find_type( itype_charcoal ), items_here );
    const int need_charges = smoking_rack::fuel_required( f_volume );
    const int max_charges = smoking_rack::fuel_capacity( f );
    const bool has_coal = coal_charges > 0;
    const bool has_enough_coal = coal_charges >= need_charges;

    uilist smenu;
    smenu.text = _( "What to do with the smoking rack:" );
    smenu.desc_enabled = true;

    smenu.addentry( 0, true, 'i', _( "Inspect smoking rack" ) );

    if( !active ) {
        smenu.addentry_desc( 1, !empty && has_enough_coal, 'l',
                             empty ?  _( "Light up and smoke food… insert some food for smoking first" ) :
                             !has_enough_coal ? string_format(
                                 _( "Light up and smoke food… need extra %d charges of charcoal" ),
                                 need_charges - coal_charges ) :
                             _( "Light up and smoke food" ),
                             _( "Light up the smoking rack and start smoking.  Smoking will take about 6 hours." ) );
        smenu.addentry_desc( 2, !full, 'f',
                             full ? _( "Insert food for smoking… smoking rack is full" ) :
                             string_format( _( "Insert food for smoking… remaining capacity is %s %s" ),
                                            format_volume( remaining_capacity ), volume_units_abbr() ),
                             _( "Fill the smoking rack with raw meat, fish or sausages for smoking or fruit or vegetable or smoked meat for drying." ) );
        if( portable ) {
            smenu.addentry_desc( 8, true, 'z', _( "Disassemble the smoking rack" ), "" );
        }

        if( f_check ) {
            smenu.addentry( 4, f_check, 'e', _( "Remove food from smoking rack" ) );
        }

        smenu.addentry_desc( 3, has_coal_in_inventory && coal_charges < max_charges, 'r',
                             !has_coal_in_inventory ? _( "Reload with charcoal… you don't have any" ) :
                             ( coal_charges >= max_charges ? _( "Reload with charcoal… at maximum capacity" ) :
                               _( "Reload with charcoal" ) ),
                             string_format(
                                 _( "You need %d charges of charcoal for %s %s of food.  Minimal amount of charcoal is %d charges." ),
                                 smoking_rack::fuel_per_liter, format_volume( 1_liter ), volume_units_long(),
                                 smoking_rack::minimum_fuel ) );

    } else {
        smenu.addentry_desc( 7, true, 'x',
                             _( "Quench burning charcoal" ),
                             _( "Quenching will stop smoking process, but also destroy all used charcoal." ) );
    }

    if( has_coal ) {
        smenu.addentry( 5, true, 'c',
                        active ? string_format( _( "Rake out %d excess charges of charcoal from smoking rack" ),
                                                coal_charges ) :
                        string_format( _( "Remove %d charges of charcoal from smoking rack" ), coal_charges ) );
    }

    smenu.query();
    if( !still_at_rack() ) {
        return;
    }

    switch( smenu.ret ) {
        case 0: { //inspect smoking rack
            std::string pop;
            if( active ) {
                pop += colorize( _( "There's a smoking rack here.  It is lit and smoking." ), c_green ) + "\n";
                if( time_left > 0_turns ) {
                    if( minutes_left > 60 ) {
                        pop += string_format( n_gettext( "It will finish smoking in about %d hour.",
                                                         "It will finish smoking in about %d hours.",
                                                         hours_left ), hours_left ) + "\n\n";
                    } else if( minutes_left > 30 ) {
                        pop += _( "It will finish smoking in less than an hour." ) + std::string( "\n" );
                    } else {
                        pop += string_format( n_gettext( "It should take about %d minute to finish smoking.",
                                                         "It should take about %d minutes to finish smoking.",
                                                         minutes_left ), minutes_left ) + "\n ";
                    }
                }
            } else {
                pop += colorize( _( "There's a smoking rack here." ), c_green ) + "\n";
            }
            pop += colorize( _( "You inspect its contents and find: " ), c_green ) + "\n";
            if( items_here.empty() ) {
                pop += _( "…that it is empty." );
            } else {
                for( const item &it : items_here ) {
                    if( smoking_rack::is_embers( it ) ) {
                        pop += "\n" + colorize( _( "You see some smoldering embers there." ), c_red ) + "\n";
                        continue;
                    }
                    pop += "-> " + it.display_name() + "\n";
                }
            }
            popup( pop, PF_NONE );
            break;
        }
        case 1:
            if( !active && ( remote || smoking_rack::prepare( you, here, examp, true ) ==
                             smoking_rack::preparation::ready ) ) {
                pick_firestarter_and_fire( you, examp, firestarter_actor::start_type::SMOKER );
            }
            break;
        case 2: {
            const drop_locations selected = game_menus::inv::smoke_food( you, capacity, f_volume );
            if( !still_at_rack() ) {
                return;
            }
            auto command = observed;
            command.action = operation::load_food;
            for( const auto &selection : selected ) {
                if( selection.first ) {
                    command.items.push_back( { capture_item_source( you, selection.first ), selection.second } );
                }
            }
            if( !command.items.empty() ) {
                submit_smoking_rack_choice( you, here, command );
            }
            break;
        }
        case 3: {
            const itype *type = f->crafting_pseudo_item_type();
            if( !type ) {
                return;
            }
            item pseudo( type );
            item_location target( map_cursor( observed.target.position ), &pseudo );
            const item::reload_option selected = game_menus::inv::select_ammo( you, target );
            if( !still_at_rack() || !selected || selected.ammo->typeId() != itype_charcoal ) {
                return;
            }
            const int maximum = std::min( selected.qty(), max_charges - coal_charges );
            int quantity = maximum;
            const item_source source = capture_item_source( you, selected.ammo );
            if( maximum > 0 &&
                query_int( quantity, true, _( "Put how many of the %s into the %s?" ),
                           itype_charcoal->nname( maximum ), f->name() ) &&
                still_at_rack() && quantity > 0 && quantity <= maximum ) {
                auto command = observed;
                command.action = operation::load_fuel;
                command.items.push_back( { source, quantity } );
                submit_smoking_rack_choice( you, here, command );
            }
            break;
        }
        case 4:
            submit( operation::remove_food );
            break;
        case 5:
            submit( operation::remove_fuel );
            break;
        default:
            add_msg( m_info, _( "Never mind." ) );
            break;
        case 7:
            submit( operation::quench );
            break;
        case 8:
            deployed_furniture( you, examp );
            break;
    }
}

void iexamine::open_safe( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();
    submit_safe_interaction( you, here, { safe_action::open, you.pos_abs(),
                                        here.get_abs( examp ), here.furn( examp ).id() } );
}

void iexamine::workbench( Character &you, const tripoint_bub_ms &examp )
{
    map &here = get_map();

    if( get_option<bool>( "WORKBENCH_ALL_OPTIONS" ) ) {
        workbench_internal( you, examp, std::nullopt );
    } else {
        if( !here.i_at( examp ).empty() ) {
            g->pickup( examp );
        }
        if( item::type_is_defined( here.furn( examp ).obj().deployed_item ) ) {
            deployed_furniture( you, examp );
        }
    }
}

void iexamine::workbench_internal( Character &you, const tripoint_bub_ms &examp,
                                   const std::optional<vpart_reference> &part )
{
    std::vector<item_location> crafts;
    std::string name;
    bool is_undeployable = false;
    bool items_at_loc = false;
    map &here = get_map();

    if( part ) {
        name = part->part().name();
        for( item &it : part->items() ) {
            if( it.is_craft() ) {
                crafts.emplace_back( vehicle_cursor( part->vehicle(), part->part_index() ), &it );
            }
        }
    } else {
        const furn_t &fo = here.furn( examp ).obj();
        name = fo.name();
        if( item::type_is_defined( fo.deployed_item ) ) {
            is_undeployable = true;
        }

        map_stack items_at_furn = here.i_at( examp );
        items_at_loc = !items_at_furn.empty();

        for( item &it : items_at_furn ) {
            if( it.is_craft() ) {
                crafts.emplace_back( map_cursor( tripoint_bub_ms( examp ) ), &it );
            }
        }
    }

    uilist amenu;

    enum option : int {
        start_craft = 0,
        repeat_craft,
        start_long_craft,
        work_on_craft,
        get_items,
        undeploy
    };

    amenu.text = string_format( pgettext( "furniture", "What to do at the %s?" ), name );
    amenu.addentry( start_craft,      true,            '1', _( "Craft items" ) );
    amenu.addentry( repeat_craft,     true,            '2', _( "Recraft last recipe" ) );
    amenu.addentry( start_long_craft, true,            '3', _( "Craft as long as possible" ) );
    amenu.addentry( work_on_craft,    !crafts.empty(), '4', _( "Work on craft or disassembly" ) );
    if( !part && here.has_items( examp ) ) {
        amenu.addentry( get_items,    items_at_loc,    'g', _( "Get items" ) );
    }
    if( is_undeployable ) {
        amenu.addentry( undeploy,     true,            't', _( "Take down the %s" ), name );
    }

    amenu.query();

    const option choice = static_cast<option>( amenu.ret );
    bool in_shell = you.has_active_mutation( trait_SHELL2 ) ||
                    you.has_active_mutation( trait_SHELL3 );
    bool shapeshift_handless = you.has_flag( json_flag_TEMPORARY_SHAPESHIFT_NO_HANDS );
    switch( choice ) {
        case start_craft: {
            if( in_shell ) {
                you.add_msg_if_player( m_info, _( "You can't craft while you're in your shell." ) );
            } else if( you.has_effect( effect_incorporeal ) ) {
                add_msg( m_info, _( "You lack the substance to affect anything." ) );
            } else if( shapeshift_handless ) {
                add_msg( m_info, _( "You don't have proper hands to do that." ) );
            } else {
                you.craft( examp );
            }
            break;
        }
        case repeat_craft: {
            if( in_shell ) {
                you.add_msg_if_player( m_info, _( "You can't craft while you're in your shell." ) );
            } else if( you.has_effect( effect_incorporeal ) ) {
                add_msg( m_info, _( "You lack the substance to affect anything." ) );
            } else if( shapeshift_handless ) {
                add_msg( m_info, _( "You don't have proper hands to do that." ) );
            } else {
                you.recraft( examp );
            }
            break;
        }
        case start_long_craft: {
            if( in_shell ) {
                you.add_msg_if_player( m_info, _( "You can't craft while you're in your shell." ) );
            } else if( you.has_effect( effect_incorporeal ) ) {
                add_msg( m_info, _( "You lack the substance to affect anything." ) );
            } else if( shapeshift_handless ) {
                add_msg( m_info, _( "You don't have proper hands to do that." ) );
            } else {
                you.long_craft( examp );
            }
            break;
        }
        case work_on_craft: {
            std::vector<std::string> item_names;
            for( item_location &it : crafts ) {
                if( it ) {
                    item_names.emplace_back( it.get_item()->tname() );
                }
            }
            uilist amenu2( _( "Which craft or disassembly to work on?" ), item_names );

            if( amenu2.ret == UILIST_CANCEL ) {
                break;
            }

            item *selected_craft = crafts[amenu2.ret].get_item();

            if( !selected_craft ) {
                break;
            }

            if( selected_craft->typeId() == itype_disassembly ) {
                you.disassemble( crafts[amenu2.ret], true );
            } else {
                craft_resolve_overdue_passive( *selected_craft, calendar::turn, crafts[amenu2.ret] );
                if( !crafts[amenu2.ret] || !crafts[amenu2.ret].get_item() ) {
                    break;
                }
                selected_craft = crafts[amenu2.ret].get_item();
                if( selected_craft->is_awaiting_collection() ) {
                    craft_collect_finalized( crafts[amenu2.ret] );
                    break;
                }
                const recipe &rec = selected_craft->get_making();
                std::optional<std::vector<attention_plan>> chosen;
                if( rec.has_remaining_attention_steps( selected_craft->get_current_step() )
                    && you.is_avatar() ) {
                    chosen = show_craft_planning_modal( rec, you,
                                                        selected_craft->get_making_batch_size(),
                                                        selected_craft->get_current_step(),
                                                        selected_craft->get_step_plans(),
                                                        selected_craft );
                    if( !chosen ) {
                        break;
                    }
                }
                if( !you.can_continue_craft( *selected_craft ) ) {
                    break;
                }
                if( !you.has_recipe( &rec ) ) {
                    you.add_msg_player_or_npc(
                        _( "You don't know the recipe for the %s and can't continue crafting." ),
                        _( "<npcname> doesn't know the recipe for the %s and can't continue crafting." ),
                        rec.result_name() );
                    break;
                }
                if( chosen ) {
                    selected_craft->set_step_plans( std::move( *chosen ) );
                    selected_craft->set_crafter_id( you.getID() );
                    craft_apply_resume_replan( crafts[amenu2.ret] );
                }
                you.add_msg_player_or_npc(
                    pgettext( "in progress craft", "You start working on the %s." ),
                    pgettext( "in progress craft", "<npcname> starts working on the %s." ),
                    selected_craft->tname() );
                you.assign_activity( craft_activity_actor( crafts[amenu2.ret], false ) );
            }
            break;
        }
        case get_items: {
            g->pickup( examp );
            break;
        }
        case undeploy: {
            deployed_furniture( you, examp );
            break;
        }
    }
}

void iexamine::workout( Character &you, const tripoint_bub_ms &examp )
{
    if( !query_yn( _( "Use the %s to exercise?" ), get_map().furnname( examp ) ) ) {
        none( you, examp );
        return;
    }
    you.assign_activity( workout_activity_actor( examp ) );
}

void iexamine::invalid( Character &/*you*/, const tripoint_bub_ms &examp )
{
    debugmsg( "Called invalid iexamine function on %s!", get_map().tername( examp ) );
}

/**
 * Given then name of one of the above functions, returns the matching function
 * pointer. If no match is found, defaults to iexamine::none but prints out a
 * debug message as a warning.
 * @param function_name The name of the function to get.
 * @return A function pointer to the specified function.
 */
iexamine_functions iexamine_functions_from_string( const std::string &function_name )
{
    struct function_data {
        translation name;
        iexamine_examine_function function;
    };

    static const std::map<std::string, function_data> function_map = {{
            { "none", { no_translation( "none" ), &iexamine::none } },
            { "deployed_furniture", { to_translation( "Take down or deploy furniture" ), &iexamine::deployed_furniture } },
            { "cvdmachine", { to_translation( "Use CVD machine" ), &iexamine::cvdmachine } },
            { "iso_recycler", { to_translation( "Use recycler" ), &iexamine::iso_recycler } },
            { "change_appearance", { to_translation( "Change your appearance" ), &iexamine::change_appearance } },
            { "genemill", { to_translation( "Use genemill" ), &iexamine::genemill } },
            { "nanofab", { to_translation( "Use nanofab" ), &iexamine::nanofab } },
            { "nanoforge", { to_translation( "Use nanoforge" ), &iexamine::nanoforge } },
            { "gaspump", { to_translation( "Use gas pump" ), &iexamine::gaspump } },
            { "atm", { to_translation( "Use ATM" ), &iexamine::atm } },
            { "vending", { to_translation( "Use vending machine" ), &iexamine::vending } },
            { "elevator", { to_translation( "Use elevator" ), &iexamine::elevator } },
            { "controls_gate", { to_translation( "Use control gate" ), &iexamine::controls_gate } },
            { "cardreader_robofac", { to_translation( "Use card reader" ), &iexamine::cardreader_robofac } },
            { "cardreader_fp", { to_translation( "Use card reader" ), &iexamine::cardreader_foodplace } },
            { "intercom", { to_translation( "Use intercom" ), &iexamine::intercom } },
            { "intercom_balthazar", { to_translation( "Use intercom" ), &iexamine::intercom_balthazar } },
            { "rubble", { to_translation( "Clear rubble" ), &iexamine::rubble } },
            { "chainfence", { to_translation( "Hop over" ), &iexamine::chainfence } },
            { "bars", { to_translation( "Try to slip through the bars" ), &iexamine::bars } },
            { "portable_structure", { to_translation( "Take down" ), &iexamine::portable_structure } },
            { "pit", { to_translation( "Cover the pit" ), &iexamine::pit } },
            { "pit_covered", { to_translation( "Uncover the pit" ), &iexamine::pit_covered } },
            { "thin_ice", { to_translation( "Check the thickness of ice" ), &iexamine::thin_ice } },
            { "safe", { to_translation( "Attempt to crack a safe" ), &iexamine::safe } },
            { "bulletin_board", { to_translation( "Arrange tasks of faction camp" ), &iexamine::bulletin_board } },
            { "pedestal_wyrm", { to_translation( "Interact with pedestal" ), &iexamine::pedestal_wyrm } },
            { "pedestal_temple", { to_translation( "Interact with pedestal" ), &iexamine::pedestal_temple } },
            { "door_peephole", { to_translation( "Use a peephole" ), &iexamine::door_peephole } },
            { "fswitch", { to_translation( "Flip the switch" ), &iexamine::fswitch } },
            { "flower_poppy", { to_translation( "Pick the poppy" ), &iexamine::flower_poppy } },
            { "flower_cactus", { to_translation( "Pick the cactus" ), &iexamine::flower_cactus } },
            { "fungus", { to_translation( "Touch the fungus" ), &iexamine::fungus } },
            { "flower_dahlia", { to_translation( "Check the dahlia" ), &iexamine::flower_dahlia } },
            { "flower_marloss", { to_translation( "Pick the marloss flower" ), &iexamine::flower_marloss } },
            { "dirtmound", { to_translation( "Plant seeds" ), &iexamine::dirtmound } },
            { "aggie_plant", { to_translation( "Harvest plants" ), &iexamine::aggie_plant } },
            { "fvat_empty", { to_translation( "Use fermenting vat (empty)" ), &iexamine::fvat_empty } },
            { "fvat_full", { to_translation( "Use fermenting vat (full)" ), &iexamine::fvat_full } },
            { "compost_empty", { to_translation( "Use composter (empty)" ), &iexamine::compost_empty } },
            { "compost_full", { to_translation( "Use composter (full)" ), &iexamine::compost_full } },
            { "keg", { to_translation( "Use keg" ), &iexamine::keg } },
            { "harvest_furn_nectar", { to_translation( "Harvest nectar" ), &iexamine::harvest_furn_nectar } },
            { "harvest_furn", { to_translation( "Harvest" ), &iexamine::harvest_furn } },
            { "harvest_ter_nectar", { to_translation( "Harvest nectar" ), &iexamine::harvest_ter_nectar } },
            { "harvest_ter", { to_translation( "Harvest" ), &iexamine::harvest_ter } },
            { "fertilize_terrain", { to_translation( "Fertilize" ), &iexamine::fertilize_terrain } },
            { "clear_overgrown", { to_translation( "Clear overgrown plants" ), &iexamine::clear_overgrown } },
            { "harvest_plant_ex", { to_translation( "Harvest" ), &iexamine::harvest_plant_ex } },
            { "harvested_plant", { to_translation( "Harvest" ), &iexamine::harvested_plant } },
            { "shrub_marloss", { to_translation( "Pick marloss bush" ), &iexamine::shrub_marloss } },
            { "translocator", { to_translation( "Use translocator" ), &iexamine::translocator } },
            { "tree_marloss", { to_translation( "Pick marloss tree" ), &iexamine::tree_marloss } },
            { "tree_hickory", { to_translation( "Pick hickory tree" ), &iexamine::tree_hickory } },
            { "tree_maple", { to_translation( "Tap the maple tree" ), &iexamine::tree_maple } },
            { "tree_maple_tapped", { to_translation( "Harvest maple sap" ), &iexamine::tree_maple_tapped } },
            { "shrub_wildveggies", { to_translation( "Harvest wild veggies" ), &iexamine::shrub_wildveggies } },
            { "water_source", { to_translation( "Use provided liquid" ), &iexamine::water_source } },
            { "finite_water_source", { to_translation( "Use provided liquid" ), &iexamine::finite_water_source } },
            { "reload_furniture", { to_translation( "Reload" ), &iexamine::reload_furniture } },
            { "curtains", { to_translation( "Use curtains" ), &iexamine::curtains } },
            { "sign", { to_translation( "Read sign" ), &iexamine::sign } },
            { "pay_gas", { to_translation( "Pay for fuel" ), &iexamine::pay_gas } },
            { "gunsafe_el", { to_translation( "Try to hack e-safe" ), &iexamine::gunsafe_el } },
            { "locked_object", { to_translation( "Try to open" ), &iexamine::locked_object } },
            { "locked_object_pickable", { to_translation( "Try to lockpick" ), &iexamine::locked_object_pickable } },
            { "kiln_empty", { to_translation( "Use kiln (empty)" ), &iexamine::kiln_empty } },
            { "kiln_full", { to_translation( "Use kiln (full)" ), &iexamine::kiln_full } },
            { "stook_empty", { to_translation( "Use stook" ), &iexamine::stook_empty } },
            { "stook_full", { to_translation( "Use stook" ), &iexamine::stook_full } },
            { "arcfurnace_empty", { to_translation( "Use arc furnace (empty)" ), &iexamine::arcfurnace_empty } },
            { "arcfurnace_full", { to_translation( "Use arc furnace (full)" ), &iexamine::arcfurnace_full } },
            { "autoclave_empty", { to_translation( "Use autoclave (empty)" ), &iexamine::autoclave_empty } },
            { "autoclave_full", { to_translation( "Use autoclave (full)" ), &iexamine::autoclave_full } },
            { "fireplace", { to_translation( "Set some fire" ), &iexamine::fireplace } },
            { "ledge", { to_translation( "Check the ledge" ), &iexamine::ledge } },
            { "autodoc", { to_translation( "Use autodoc" ), &iexamine::autodoc } },
            { "quern_examine", { to_translation( "Use quern" ), &iexamine::quern_examine } },
            { "smoker_options", { to_translation( "Use smoker" ), &iexamine::smoker_options } },
            { "open_safe", { to_translation( "Open the safe" ), &iexamine::open_safe } },
            { "workbench", { to_translation( "Craft something" ), &iexamine::workbench } },
            { "workout", { to_translation( "Workout" ), &iexamine::workout } },
            { "invalid", { no_translation( "invalid" ), &iexamine::invalid } },
        }
    };

    static const std::set<std::string> harvestable_functions = {
        "harvest_furn_nectar",
        "harvest_furn",
        "harvest_ter_nectar",
        "harvest_ter",
        "harvest_plant",
    };

    auto iter = function_map.find( function_name );
    if( iter != function_map.end() ) {
        function_data func = iter->second;
        if( function_name == "none" ) {
            return iexamine_functions{&iexamine::always_false, func.function, func.name};
        } else if( function_name == "invalid" ) {
            return iexamine_functions{&iexamine::false_and_debugmsg, func.function, func.name};
        } else if( harvestable_functions.find( function_name ) != harvestable_functions.end() ) {
            return iexamine_functions{&iexamine::harvestable_now, func.function, func.name};
        } else {
            return iexamine_functions{&iexamine::always_true, func.function, func.name};
        }
    }

    //No match found
    debugmsg( "Could not find an iexamine function matching '%s'!", function_name );
    return iexamine_functions{&iexamine::always_false, &iexamine::none, no_translation( "invalid" ) };
}

void iexamine::practice_survival_while_foraging( Character &who )
{
    ///\EFFECT_INT Intelligence caps survival skill gains from foraging
    const int max_forage_skill = who.get_int() / 3 + 1;
    ///\EFFECT_SURVIVAL decreases survival skill gain from foraging (NEGATIVE)
    const int max_exp = 2 * ( max_forage_skill - static_cast<int>( who.get_skill_level(
                                  skill_survival ) ) );
    // Award experience for foraging attempt regardless of success
    who.practice( skill_survival, rng( 1, max_exp ), max_forage_skill );
}
