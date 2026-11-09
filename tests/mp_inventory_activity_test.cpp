#include <algorithm>
#include <climits>
#include <deque>
#include <functional>
#include <initializer_list>
#include <iterator>
#include <limits>
#include <list>
#include <map>
#include <memory>
#include <optional>
#include <random>
#include <set>
#include <sstream>
#include <stddef.h>
#include <stdint.h>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include "action.h"
#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "activity_item_handling.h"
#include "avatar.h"
#include "avatar_action.h"
#include "bionic_activation.h"
#include "bionic_water_activity.h"
#include "bionics.h"
#include "bodypart.h"
#include "butchery.h"
#include "cached_options.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_attire.h"
#include "character_id.h"
#include "character_martial_arts.h"
#include "chopping_activity.h"
#include "clone_ptr.h"
#include "clzones.h"
#include "construction.h"
#include "coordinates.h"
#include "craft_command.h"
#include "craft_result_state.h"
#include "crafting.h"
#include "crafting_enums.h"
#include "creature.h"
#include "creature_tracker.h"
#include "debug.h"
#include "deployed_furniture.h"
#include "dialogue_chatbin.h"
#include "disassembly.h"
#include "effect.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "explosion.h"
#include "faction.h"
#include "farming.h"
#include "field_type.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "game_constants.h"
#include "grab.h"
#include "hacksaw_activity.h"
#include "handle_liquid.h"
#include "hauling.h"
#include "iexamine.h"
#include "item.h"
#include "item_activation.h"
#include "item_components.h"
#include "item_disposition.h"
#include "item_insert.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_reload.h"
#include "item_source.h"
#include "item_transformation.h"
#include "item_uid.h"
#include "item_unload.h"
#include "itype.h"
#include "iuse.h"
#include "iuse_actor.h"
#include "json.h"
#include "json_loader.h"
#include "kill_statistics.h"
#include "level_cache.h"
#include "line.h"
#include "lua_platform_loader.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "lua_platform_state.h"
#include "magic.h"
#include "map.h"
#include "map_entity_stack.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_iterator.h"
#include "map_scale_constants.h"
#include "map_selector.h"
#include "map_viewpoint.h"
#include "mapdata.h"
#include "martial_style_selection.h"
#include "martialarts.h"
#include "math_parser_diag_value.h"
#include "mdarray.h"
#include "memory_fast.h"
#include "message_routing.h"
#include "messages.h"
#include "mission.h"
#include "monster.h"
#include "monster_uid.h"
#include "mp_actor_binding.h"
#include "mp_admission.h"
#include "mp_client_conn.h"
#include "mp_combat_result.h"
#include "mp_entity_registry.h"
#include "mp_gamestate.h"
#include "mp_inventory_activity.h"
#include "mp_item_source.h"
#include "mp_peek.h"
#include "mp_pickup.h"
#include "mp_player_feedback.h"
#include "mp_player_identity.h"
#include "mp_player_view.h"
#include "mp_queue.h"
#include "mp_test_helpers.h"
#include "mp_unload.h"
#include "mp_world_session.h"
#include "mp_world_state.h"
#include "mtype.h"
#include "npc.h"
#include "options_helpers.h"
#include "pimpl.h"
#include "player_activity.h"
#include "player_control.h"
#include "player_helpers.h"
#include "player_identity.h"
#include "pocket_type.h"
#include "point.h"
#include "radio_car_control.h"
#include "recipe.h"
#include "remote_vehicle_activity.h"
#include "repair_activity.h"
#include "requirements.h"
#include "ret_val.h"
#include "rng.h"
#include "rng_helpers.h"
#include "skill.h"
#include "spell_casting_choice.h"
#include "stomach.h"
#include "submap.h"
#include "surroundings_menu.h"
#include "temp_crafting_inventory.h"
#include "tool_activity_target.h"
#include "translation.h"
#include "type_id.h"
#include "uistate.h"
#include "units.h"
#include "value_ptr.h"
#include "veh_interact.h"
#include "veh_type.h"
#include "veh_utils.h"
#include "vehicle.h"
#include "vehicle_appliance.h"
#include "vehicle_control.h"
#include "vehicle_electronics.h"
#include "vehicle_harness.h"
#include "vehicle_heating.h"
#include "vehicle_selector.h"
#include "vehicle_tool_use.h"
#include "vehicle_toolstation.h"
#include "vehicle_turret_control.h"
#include "vehicle_uid.h"
#include "vehicle_water.h"
#include "vertical_movement.h"
#include "view_action.h"
#include "viewer.h"
#include "visitable.h"
#include "vpart_position.h"
#include "vpart_range.h"
#include "walking.h"
#include "weather.h"
#include "weather_gen.h"
#include "zone_edit.h"
#include "zone_work.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    #include "lua_platform_test_support.h"
#endif

static const activity_id ACT_BIONIC_WATER( "ACT_BIONIC_WATER" );
static const activity_id ACT_CHOP_LOGS( "ACT_CHOP_LOGS" );
static const activity_id ACT_CHOP_PLANKS( "ACT_CHOP_PLANKS" );
static const activity_id ACT_CHOP_TREE( "ACT_CHOP_TREE" );
static const activity_id ACT_CHURN( "ACT_CHURN" );
static const activity_id ACT_CONSUME( "ACT_CONSUME" );
static const activity_id ACT_DISASSEMBLE( "ACT_DISASSEMBLE" );
static const activity_id ACT_DISMEMBER( "ACT_DISMEMBER" );
static const activity_id ACT_FERTILIZE_PLANT( "ACT_FERTILIZE_PLANT" );
static const activity_id ACT_FETCH_REQUIRED( "ACT_FETCH_REQUIRED" );
static const activity_id ACT_FILL_LIQUID( "ACT_FILL_LIQUID" );
static const activity_id ACT_FORAGE( "ACT_FORAGE" );
static const activity_id ACT_FURNITURE_MOVE( "ACT_FURNITURE_MOVE" );
static const activity_id ACT_GLIDE( "ACT_GLIDE" );
static const activity_id ACT_HACKSAW( "ACT_HACKSAW" );
static const activity_id ACT_HOTWIRE_CAR( "ACT_HOTWIRE_CAR" );
static const activity_id ACT_INSERT_ITEM( "ACT_INSERT_ITEM" );
static const activity_id ACT_LOCKPICK( "ACT_LOCKPICK" );
static const activity_id ACT_LONGSALVAGE( "ACT_LONGSALVAGE" );
static const activity_id ACT_MOVE_ITEMS( "ACT_MOVE_ITEMS" );
static const activity_id ACT_MOVE_LOOT( "ACT_MOVE_LOOT" );
static const activity_id ACT_MULTIPLE_CONSTRUCTION( "ACT_MULTIPLE_CONSTRUCTION" );
static const activity_id ACT_MULTIPLE_MOP( "ACT_MULTIPLE_MOP" );
static const activity_id ACT_MULTIPLE_STUDY( "ACT_MULTIPLE_STUDY" );
static const activity_id ACT_PRYING( "ACT_PRYING" );
static const activity_id ACT_READ( "ACT_READ" );
static const activity_id ACT_REMOTE_VEHICLE( "ACT_REMOTE_VEHICLE" );
static const activity_id ACT_REPAIR_ITEM( "ACT_REPAIR_ITEM" );
static const activity_id ACT_SPELLCASTING( "ACT_SPELLCASTING" );
static const activity_id ACT_START_ENGINES( "ACT_START_ENGINES" );
static const activity_id ACT_START_FIRE( "ACT_START_FIRE" );
static const activity_id ACT_TEST_OWNED_ITEM( "ACT_TEST_OWNED_ITEM" );
static const activity_id ACT_UNLOAD( "ACT_UNLOAD" );
static const activity_id ACT_VEHICLE( "ACT_VEHICLE" );
static const activity_id ACT_VEHICLE_FOLD( "ACT_VEHICLE_FOLD" );
static const activity_id ACT_VEHICLE_UNFOLD( "ACT_VEHICLE_UNFOLD" );
static const activity_id ACT_WAIT( "ACT_WAIT" );

static const bionic_id bio_blood_anal( "bio_blood_anal" );
static const bionic_id bio_claws( "bio_claws" );
static const bionic_id bio_cqb( "bio_cqb" );
static const bionic_id bio_earplugs( "bio_earplugs" );
static const bionic_id bio_ears( "bio_ears" );
static const bionic_id bio_emp( "bio_emp" );
static const bionic_id bio_evap( "bio_evap" );
static const bionic_id bio_flashbang( "bio_flashbang" );
static const bionic_id bio_geiger( "bio_geiger" );
static const bionic_id bio_lighter( "bio_lighter" );
static const bionic_id bio_lockpick( "bio_lockpick" );
static const bionic_id bio_magnet( "bio_magnet" );
static const bionic_id bio_night_vision( "bio_night_vision" );
static const bionic_id bio_painkiller( "bio_painkiller" );
static const bionic_id bio_power_storage( "bio_power_storage" );
static const bionic_id bio_remote( "bio_remote" );
static const bionic_id bio_resonator( "bio_resonator" );
static const bionic_id bio_shockwave( "bio_shockwave" );
static const bionic_id bio_taser( "bio_taser" );
static const bionic_id bio_teleport( "bio_teleport" );
static const bionic_id bio_water_extractor( "bio_water_extractor" );

static const climbing_aid_id climbing_aid_default( "default" );
static const climbing_aid_id climbing_aid_item_grapnel( "item_grapnel" );

static const construction_str_id construction_constr_veh( "constr_veh" );
static const construction_str_id construction_constr_wall_half( "constr_wall_half" );

static const efftype_id effect_beartrap( "beartrap" );
static const efftype_id effect_bleed( "bleed" );
static const efftype_id effect_blind( "blind" );
static const efftype_id effect_deaf( "deaf" );
static const efftype_id effect_disinfected( "disinfected" );
static const efftype_id effect_downed( "downed" );
static const efftype_id effect_gliding( "gliding" );
static const efftype_id effect_harnessed( "harnessed" );
static const efftype_id effect_incorporeal( "incorporeal" );
static const efftype_id effect_on_roof( "on_roof" );
static const efftype_id effect_onfire( "onfire" );
static const efftype_id effect_pkill1_nsaid( "pkill1_nsaid" );
static const efftype_id effect_pkill3( "pkill3" );
static const efftype_id effect_poison( "poison" );
static const efftype_id effect_sleep( "sleep" );
static const efftype_id effect_slimed( "slimed" );
static const efftype_id effect_spores( "spores" );
static const efftype_id effect_stunned( "stunned" );
static const efftype_id effect_teleglow( "teleglow" );
static const efftype_id effect_tied( "tied" );
static const efftype_id effect_took_prozac( "took_prozac" );
static const efftype_id effect_weed_high( "weed_high" );

static const faction_id faction_free_merchants( "free_merchants" );
static const faction_id faction_hells_raiders( "hells_raiders" );
static const faction_id faction_no_faction( "no_faction" );

static const flag_id json_flag_BLED( "BLED" );
static const flag_id json_flag_NEVER_JAMS( "NEVER_JAMS" );
static const flag_id json_flag_NO_PACKED( "NO_PACKED" );
static const flag_id json_flag_RADIO_MOD( "RADIO_MOD" );
static const flag_id json_flag_REQUIRES_TINDER( "REQUIRES_TINDER" );

static const furn_str_id furn_f_aluminum_stepladder( "f_aluminum_stepladder" );
static const furn_str_id furn_f_chair( "f_chair" );
static const furn_str_id furn_f_console( "f_console" );
static const furn_str_id furn_f_crate_c( "f_crate_c" );
static const furn_str_id furn_f_crate_o( "f_crate_o" );
static const furn_str_id furn_f_flower_fungal( "f_flower_fungal" );
static const furn_str_id furn_f_flower_marloss( "f_flower_marloss" );
static const furn_str_id furn_f_ladder( "f_ladder" );
static const furn_str_id furn_f_machinery_electronic( "f_machinery_electronic" );
static const furn_str_id furn_f_null( "f_null" );
static const furn_str_id furn_f_planter_seed( "f_planter_seed" );
static const furn_str_id furn_f_rope_up( "f_rope_up" );
static const furn_str_id furn_f_smoking_rack( "f_smoking_rack" );
static const furn_str_id furn_test_f_hacksaw1( "test_f_hacksaw1" );
static const furn_str_id furn_test_f_hacksaw2( "test_f_hacksaw2" );
static const furn_str_id furn_test_f_hacksaw3( "test_f_hacksaw3" );
static const furn_str_id furn_test_f_oxytorch1( "test_f_oxytorch1" );
static const furn_str_id furn_test_f_oxytorch2( "test_f_oxytorch2" );

static const gun_mode_id gun_mode_BURST( "BURST" );
static const gun_mode_id gun_mode_DEFAULT( "DEFAULT" );
static const gun_mode_id gun_mode_absent( "absent" );
static const gun_mode_id gun_mode_not_a_gun_mode( "not_a_gun_mode" );

static const itype_id itype_2x4( "2x4" );
static const itype_id itype_556( "556" );
static const itype_id itype_9mm( "9mm" );
static const itype_id itype_ammolink223( "ammolink223" );
static const itype_id itype_apple( "apple" );
static const itype_id itype_aspirin( "aspirin" );
static const itype_id itype_ax( "ax" );
static const itype_id itype_backpack( "backpack" );
static const itype_id itype_battery( "battery" );
static const itype_id itype_belt223( "belt223" );
static const itype_id itype_bfipowder( "bfipowder" );
static const itype_id itype_bio_power_storage( "bio_power_storage" );
static const itype_id itype_blanket( "blanket" );
static const itype_id itype_bottle_plastic( "bottle_plastic" );
static const itype_id itype_butane( "butane" );
static const itype_id itype_c4( "c4" );
static const itype_id itype_c4armed( "c4armed" );
static const itype_id itype_child_book( "child_book" );
static const itype_id itype_chocolate( "chocolate" );
static const itype_id itype_cordless_impact_wrench( "cordless_impact_wrench" );
static const itype_id itype_cotton_patchwork( "cotton_patchwork" );
static const itype_id itype_cudgel( "cudgel" );
static const itype_id itype_detergent( "detergent" );
static const itype_id itype_disassembly( "disassembly" );
static const itype_id itype_fertilizer_commercial( "fertilizer_commercial" );
static const itype_id itype_folded_bicycle( "folded_bicycle" );
static const itype_id itype_frame( "frame" );
static const itype_id itype_gasoline( "gasoline" );
static const itype_id itype_generic_folded_vehicle( "generic_folded_vehicle" );
static const itype_id itype_glockmag( "glockmag" );
static const itype_id itype_grapnel( "grapnel" );
static const itype_id itype_grenade( "grenade" );
static const itype_id itype_grenade_act( "grenade_act" );
static const itype_id itype_hammer( "hammer" );
static const itype_id itype_heavy_battery_cell( "heavy_battery_cell" );
static const itype_id itype_hotplate( "hotplate" );
static const itype_id itype_hygrometer( "hygrometer" );
static const itype_id itype_jackhammer_mining( "jackhammer_mining" );
static const itype_id itype_jar_glass_sealed( "jar_glass_sealed" );
static const itype_id itype_jeans( "jeans" );
static const itype_id itype_jug_plastic( "jug_plastic" );
static const itype_id itype_knife_huge( "knife_huge" );
static const itype_id itype_lc_chain_link( "lc_chain_link" );
static const itype_id itype_lc_chainmail_vest( "lc_chainmail_vest" );
static const itype_id itype_light_battery_cell( "light_battery_cell" );
static const itype_id itype_lighter( "lighter" );
static const itype_id itype_log( "log" );
static const itype_id itype_maple_sap( "maple_sap" );
static const itype_id itype_meat( "meat" );
static const itype_id itype_medium_battery_cell( "medium_battery_cell" );
static const itype_id itype_morphine( "morphine" );
static const itype_id itype_muscle( "muscle" );
static const itype_id itype_mws_weather_data_incomplete( "mws_weather_data_incomplete" );
static const itype_id itype_nail( "nail" );
static const itype_id itype_nail_puller_bronze( "nail_puller_bronze" );
static const itype_id itype_oxy_torch( "oxy_torch" );
static const itype_id itype_oxyacetylene( "oxyacetylene" );
static const itype_id itype_paper( "paper" );
static const itype_id itype_pickaxe( "pickaxe" );
static const itype_id itype_pipe( "pipe" );
static const itype_id itype_pot( "pot" );
static const itype_id itype_power_cord( "power_cord" );
static const itype_id itype_propane( "propane" );
static const itype_id itype_radio_car_on( "radio_car_on" );
static const itype_id itype_radio_mod( "radio_mod" );
static const itype_id itype_radiocontrol( "radiocontrol" );
static const itype_id itype_reciprocating_saw( "reciprocating_saw" );
static const itype_id itype_remotevehcontrol( "remotevehcontrol" );
static const itype_id itype_rock( "rock" );
static const itype_id itype_rope_30( "rope_30" );
static const itype_id itype_rope_6( "rope_6" );
static const itype_id itype_screwdriver( "screwdriver" );
static const itype_id itype_seed_buckwheat( "seed_buckwheat" );
static const itype_id itype_shovel( "shovel" );
static const itype_id itype_soldering_iron_portable( "soldering_iron_portable" );
static const itype_id itype_splinter( "splinter" );
static const itype_id itype_stanag30( "stanag30" );
static const itype_id itype_steel_chunk( "steel_chunk" );
static const itype_id itype_stepladder( "stepladder" );
static const itype_id itype_stick( "stick" );
static const itype_id itype_string_36( "string_36" );
static const itype_id itype_syringe( "syringe" );
static const itype_id itype_test_apple( "test_apple" );
static const itype_id itype_test_battery_disposable( "test_battery_disposable" );
static const itype_id itype_test_ebook_reader( "test_ebook_reader" );
static const itype_id itype_test_goggles_welding( "test_goggles_welding" );
static const itype_id itype_test_hacksaw( "test_hacksaw" );
static const itype_id itype_test_halligan( "test_halligan" );
static const itype_id itype_test_knotted_string_ball( "test_knotted_string_ball" );
static const itype_id itype_test_lamp( "test_lamp" );
static const itype_id itype_test_multimag_gun_integral_ammo( "test_multimag_gun_integral_ammo" );
static const itype_id
itype_test_multimag_turret_flamethrower( "test_multimag_turret_flamethrower" );
static const itype_id itype_test_multimag_turret_gun( "test_multimag_turret_gun" );
static const itype_id itype_test_multitool( "test_multitool" );
static const itype_id itype_test_owned_lua_tool( "test_owned_lua_tool" );
static const itype_id itype_test_owned_multimag_repair_tool( "test_owned_multimag_repair_tool" );
static const itype_id itype_test_owned_repair_tool( "test_owned_repair_tool" );
static const itype_id itype_test_rag( "test_rag" );
static const itype_id itype_test_rag_bundle( "test_rag_bundle" );
static const itype_id itype_test_rock( "test_rock" );
static const itype_id itype_test_seed_eoc( "test_seed_eoc" );
static const itype_id itype_test_sonic_screwdriver( "test_sonic_screwdriver" );
static const itype_id itype_test_textbook_fabrication( "test_textbook_fabrication" );
static const itype_id itype_test_vehicle_hotplate_startup( "test_vehicle_hotplate_startup" );
static const itype_id
itype_test_watertight_open_sealed_container_1L( "test_watertight_open_sealed_container_1L" );
static const itype_id itype_test_weapon1( "test_weapon1" );
static const itype_id itype_test_weapon2( "test_weapon2" );
static const itype_id itype_towel( "towel" );
static const itype_id itype_tree_spile( "tree_spile" );
static const itype_id itype_tshirt( "tshirt" );
static const itype_id itype_twig( "twig" );
static const itype_id itype_water( "water" );
static const itype_id itype_water_clean( "water_clean" );
static const itype_id itype_water_purifier( "water_purifier" );
static const itype_id itype_welder( "welder" );
static const itype_id itype_wrench( "wrench" );

static const json_character_flag json_flag_CARNIVORE_DIET( "CARNIVORE_DIET" );
static const json_character_flag json_flag_DEAF( "DEAF" );
static const json_character_flag json_flag_NIGHT_VISION( "NIGHT_VISION" );

static const matype_id not_a_real_style( "not_a_real_style" );
static const matype_id style_judo( "style_judo" );
static const matype_id style_karate( "style_karate" );
static const matype_id style_none( "style_none" );
static const matype_id test_style_ma1( "test_style_ma1" );

static const mission_type_id mission_TEST_MISSION_GENERIC_REWARD( "TEST_MISSION_GENERIC_REWARD" );

static const move_mode_id move_mode_crouch( "crouch" );
static const move_mode_id move_mode_walk( "walk" );

static const mtype_id mon_deer( "mon_deer" );
static const mtype_id mon_horse( "mon_horse" );
static const mtype_id mon_zombie( "mon_zombie" );

static const proficiency_id proficiency_prof_driver( "prof_driver" );
static const proficiency_id proficiency_prof_wound_care( "prof_wound_care" );

static const quality_id qual_SCREW( "SCREW" );

static const recipe_id
recipe_cudgel_test_charged_fast_stepless( "cudgel_test_charged_fast_stepless" );

static const skill_id skill_computer( "computer" );
static const skill_id skill_cooking( "cooking" );
static const skill_id skill_fabrication( "fabrication" );
static const skill_id skill_mechanics( "mechanics" );
static const skill_id skill_survival( "survival" );
static const skill_id skill_traps( "traps" );

static const spell_id spell_test_eoc_spell( "test_eoc_spell" );
static const spell_id spell_test_spell_json( "test_spell_json" );
static const spell_id spell_test_spell_pew( "test_spell_pew" );

static const ter_str_id ter_t_dirt( "t_dirt" );
static const ter_str_id ter_t_door_c( "t_door_c" );
static const ter_str_id ter_t_door_locked( "t_door_locked" );
static const ter_str_id ter_t_greenhouse_tilled( "t_greenhouse_tilled" );
static const ter_str_id ter_t_pavement( "t_pavement" );
static const ter_str_id ter_t_rock( "t_rock" );
static const ter_str_id ter_t_stump( "t_stump" );
static const ter_str_id ter_t_tree( "t_tree" );
static const ter_str_id ter_t_tree_maple_tapped( "t_tree_maple_tapped" );
static const ter_str_id ter_t_trunk( "t_trunk" );
static const ter_str_id ter_t_underbrush( "t_underbrush" );
static const ter_str_id ter_t_wall( "t_wall" );
static const ter_str_id ter_t_wall_half( "t_wall_half" );
static const ter_str_id ter_test_t_prying1( "test_t_prying1" );

static const trait_id trait_BRAWLER( "BRAWLER" );
static const trait_id trait_CARNIVORE( "CARNIVORE" );
static const trait_id trait_GUNSHY( "GUNSHY" );
static const trait_id trait_HUGE( "HUGE" );
static const trait_id trait_LEG_TENT_BRACE( "LEG_TENT_BRACE" );
static const trait_id trait_MASOCHIST( "MASOCHIST" );
static const trait_id trait_PROBOSCIS( "PROBOSCIS" );
static const trait_id trait_QUICK( "QUICK" );
static const trait_id trait_SMALL2( "SMALL2" );
static const trait_id trait_WEB_WEAVER( "WEB_WEAVER" );
static const trait_id trait_WINGS_BIRD( "WINGS_BIRD" );

static const vpart_id vpart_cam_control( "cam_control" );
static const vpart_id vpart_compact_ASRG_containment( "compact_ASRG_containment" );
static const vpart_id vpart_controls( "controls" );
static const vpart_id vpart_controls_electronic( "controls_electronic" );
static const vpart_id vpart_controls_turret( "controls_turret" );
static const vpart_id vpart_door_lock( "door_lock" );
static const vpart_id vpart_door_motor( "door_motor" );
static const vpart_id vpart_drive_by_wire_controls( "drive_by_wire_controls" );
static const vpart_id vpart_frame( "frame" );
static const vpart_id vpart_ladder_3( "ladder_3" );
static const vpart_id vpart_programmable_autopilot( "programmable_autopilot" );
static const vpart_id vpart_seed_drill( "seed_drill" );
static const vpart_id vpart_tank_test( "tank_test" );
static const vpart_id vpart_trunk( "trunk" );
static const vpart_id vpart_turret_mount( "turret_mount" );
static const vpart_id vpart_turret_test_multimag_turret_gun( "turret_test_multimag_turret_gun" );
static const vpart_id vpart_vehicle_alarm( "vehicle_alarm" );
static const vpart_id vpart_washing_machine( "washing_machine" );
static const vpart_id vpart_yoke_harness( "yoke_harness" );

static const vproto_id vehicle_prototype_( "" );
static const vproto_id vehicle_prototype_car( "car" );
static const vproto_id vehicle_prototype_none( "none" );
#if !defined(CATA_ENABLE_LUA_PLATFORM) || !CATA_ENABLE_LUA_PLATFORM
    static const vproto_id vehicle_prototype_test_shopping_cart( "test_shopping_cart" );
#endif
static const vproto_id vehicle_prototype_test_turret_rig( "test_turret_rig" );

static const zone_type_id zone_type_LOOT_CUSTOM( "LOOT_CUSTOM" );
static const zone_type_id zone_type_LOOT_DEFAULT( "LOOT_DEFAULT" );
static const zone_type_id zone_type_LOOT_UNSORTED( "LOOT_UNSORTED" );
static const zone_type_id zone_type_MOPPING( "MOPPING" );
static const zone_type_id zone_type_STUDY_ZONE( "STUDY_ZONE" );
static const zone_type_id zone_type_UNLOAD_ALL( "UNLOAD_ALL" );
static const zone_type_id zone_type_VEHICLE_PATROL( "VEHICLE_PATROL" );

namespace
{
struct reload_fixture {
    cata_mp::inventory_activity_host_state reload;
    cata_mp::pickup_host_state inventory;
    int64_t sequence = 0;
    restore_on_out_of_scope<cata_default_random_engine> rng{ rng_get_engine() };

    reload_fixture() {
        clear_avatar();
        clear_map();
        g->multiplayer_session().reset();
    }
    ~reload_fixture() {
        g->multiplayer_session().reset();
        cata_mp::get_mp_queue().clear();
        clear_npcs();
        clear_avatar();
        clear_map();
    }
    npc &remote() {
        tripoint_bub_ms spawn( 60, 60, 0 );
        for( const tripoint_bub_ms &candidate : get_map().points_in_radius( spawn, 5 ) ) {
            if( !get_map().veh_at( candidate ) ) {
                spawn = candidate;
                break;
            }
        }
        npc &who = spawn_npc( spawn.xy(), "test_talker" );
        clear_character( who, true );
        who.set_value( "mp_proxy", std::string( "1" ) );
        who.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
        who.set_moves( 100 );
        return who;
    }
    std::string request( Character &who, const std::string &operation,
                         const std::function<void( JsonOut & )> &extra = {},
                         const std::optional<std::string> &activity = std::nullopt ) {
        std::ostringstream stream;
        JsonOut out( stream );
        out.start_object();
        out.member( "request", ++sequence );
        out.member( "operation", operation );
        out.member( "activity", activity.value_or( std::to_string( who.activity.identity_generation() ) ) );
        out.member( "inventory_revision", inventory.revision );
        if( extra ) {
            extra( out );
        }
        out.end_object();
        return stream.str();
    }
    std::string run( Character &who, const std::string &wire, bool authorized = true ) {
        JsonValue value = json_loader::from_string( wire );
        JsonObject input = value.get_object();
        input.allow_omitted_members();
        return cata_mp::execute_inventory_activity_request( who, get_map(), input, reload, inventory,
                authorized );
    }
    std::string start( Character &who, const item_location &target, const item_location &ammo,
                       int quantity ) {
        std::vector<item::reload_option> options;
        who.list_ammo( target, options, true, true );
        const auto selected = std::find_if( options.begin(),
        options.end(), [&]( const item::reload_option & opt ) {
            return opt.ammo == ammo;
        } );
        REQUIRE( selected != options.end() );
        return run( who, request( who, "start", [&]( JsonOut & out ) {
            out.member( "selected", cata_mp::capture_item_source( who, target ) );
            out.member( "target", cata_mp::capture_item_source( who, selected->target ) );
            out.member( "ammo", cata_mp::capture_item_source( who, ammo ) );
            out.member( "quantity", quantity );
            out.member( "pocket", selected->pocket_index );
        } ) );
    }
};

class reload_events : public event_subscriber
{
    public:
        int starts = 0;
        int finishes = 0;
        std::optional<std::string> rng_at_finish;
        reload_events() {
            get_event_bus().subscribe( this );
        }
        void notify( const cata::event &event ) override {
            if( event.type() == event_type::character_starts_activity ) {
                ++starts;
            }
            if( event.type() == event_type::character_finished_activity ) {
                ++finishes;
                rng_at_finish = capture_rng_state();
            }
        }
};

void save_reload_activity( Character &who )
{
    std::ostringstream encoded;
    JsonOut out( encoded );
    who.activity.serialize( out );
    JsonValue value = json_loader::from_string( encoded.str() );
    player_activity restored;
    restored.deserialize( value.get_object() );
    who.activity = std::move( restored );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
}

item_location loose_ammo( Character &who, int quantity )
{
    return get_map().add_item_or_charges_ret_loc( who.pos_bub(),
            item( itype_556, calendar::turn, quantity ) );
}
} // namespace

struct grabbed_vehicle_test_access {
    static bool move( game &world, Character &who, const tripoint_rel_ms &delta ) {
        return world.grabbed_veh_move( who, delta );
    }
};

TEST_CASE( "owned_reload_preserves_native_progress_partial_ammo_and_cancel",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_stanag30 ) );
    const item_location target = who.get_wielded_item();
    const item_location ammo = loose_ammo( who, 30 );
    reload_events events;
    const std::string start_result = fixture.start( who, target, ammo, 30 );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    REQUIRE( who.activity.moves_left > 100 );
    CHECK( target->ammo_remaining() == 0 );
    CHECK( ammo->charges == 30 );
    CHECK( events.starts == 1 );
    const int total = who.activity.moves_left;
    // Legacy proxy ticking must neither inject AP nor reload a round.
    cata_mp::mp_tick_proxy_activity( who );
    CHECK( who.activity.moves_left == total );
    CHECK( who.get_moves() == 100 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    CHECK( who.get_moves() == 0 );
    CHECK( who.activity.moves_left < total );
    CHECK( target->ammo_remaining() == 1 );
    CHECK( ammo->charges == 29 );
    const int remaining = who.activity.moves_left;
    save_reload_activity( who );
    CHECK( who.activity.moves_left == remaining );
    who.set_moves( 100 );
    fixture.run( who, step );
    CHECK( who.activity.moves_left == remaining );
    CHECK( target->ammo_remaining() == 1 );
    CHECK( who.get_moves() == 100 );
    who.set_moves( -80 );
    const std::string cancel = fixture.request( who, "cancel" );
    fixture.run( who, cancel );
    CHECK_FALSE( who.activity );
    CHECK( who.get_moves() == -80 );
    CHECK( target->ammo_remaining() + ammo->charges == 30 );
    CHECK( events.finishes == 1 );
    fixture.run( who, cancel );
    CHECK( events.finishes == 1 );
}

TEST_CASE( "owned_reload_obtains_external_target_and_finishes_once", "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    item_location target = get_map().add_item_or_charges_ret_loc( who.pos_bub(),
                           item( itype_stanag30 ) );
    const item_location ammo = loose_ammo( who, 3 );
    reload_events events;
    fixture.start( who, target, ammo, 3 );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    auto *actor = dynamic_cast<reload_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    target = actor->target();
    CHECK( target.held_by( who ) );
    who.set_moves( 100000 );
    const std::string response = fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( target->ammo_remaining() == 3 );
    CHECK_FALSE( ammo );
    CHECK( events.starts == 1 );
    CHECK( events.finishes == 1 );
    REQUIRE_FALSE( response.empty() );
}

TEST_CASE( "owned_reload_rejects_ungranted_step_and_stale_activity", "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_stanag30 ) );
    const item_location target = who.get_wielded_item();
    const item_location ammo = loose_ammo( who, 10 );
    fixture.start( who, target, ammo, 10 );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    const int before = who.activity.moves_left;
    fixture.run( who, fixture.request( who, "step" ), false );
    CHECK( who.activity.moves_left == before );
    CHECK( ammo->charges == 10 );
    const std::string old_activity = std::to_string( who.activity.identity_generation() );
    who.cancel_activity();
    fixture.start( who, target, ammo, 10 );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    fixture.run( who, fixture.request( who, "cancel", {}, old_activity ) );
    CHECK( cata_mp::owns_inventory_activity( who ) );
    // Moving away from the map source cannot keep remotely loading it.
    who.setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 5, 0, 0 ) );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( ammo->charges == 10 );
}

TEST_CASE( "reload_capacity_preview_accounts_for_consumed_sibling_ammo",
           "[reload_owned][reload][preview]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    item container( itype_backpack );
    REQUIRE( container.put_in( item( itype_stanag30 ), pocket_type::CONTAINER ).success() );
    REQUIRE( container.put_in( item( itype_556, calendar::turn, 30 ),
                               pocket_type::CONTAINER ).success() );
    item_location root = get_map().add_item_or_charges_ret_loc( who.pos_bub(), container );
    item_location target;
    item_location ammo;
    for( item *child : root->all_items_top() ) {
        if( child->typeId() == itype_stanag30 ) {
            target = item_location( root, child );
        } else if( child->typeId() == itype_556 ) {
            ammo = item_location( root, child );
        }
    }
    REQUIRE( target );
    REQUIRE( ammo );
    // Fill precisely the remaining weight budget. An implementation that only
    // adds loaded ammo weight without removing the sibling source would fail.
    const units::mass before = target.parent_pocket()->remaining_weight();
    const item ballast( itype_9mm, calendar::turn, 1 );
    const int charges = units::to_milligram( before ) / units::to_milligram( ballast.weight() );
    REQUIRE( charges > 0 );
    target.parent_pocket()->add( item( itype_9mm, calendar::turn, charges ) );
    REQUIRE( target.check_parent_capacity_recursive() );
    REQUIRE( target.parent_pocket()->remaining_weight() < ammo->weight() );
    CHECK( reload_would_fit( target, ammo, 30 ) );
    CHECK( target->ammo_remaining() == 0 );
    CHECK( ammo->charges == 30 );
    REQUIRE( target->reload( who, ammo, 30 ) );
    CHECK( target.check_parent_capacity_recursive() );
}

TEST_CASE( "owned_reload_overflow_waits_before_ammo_and_supports_drop_or_cancel",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const auto jeans = who.wear_item( item( itype_jeans ), false );
    REQUIRE( jeans );
    item_location clothing( who, & **jeans );
    const auto inserted = clothing->put_in( item( itype_belt223 ), pocket_type::CONTAINER );
    REQUIRE( inserted.success() );
    item_location target( clothing, &clothing->only_item() );
    const item_location ammo = loose_ammo( who, 500 );
    who.i_add( item( itype_ammolink223, calendar::turn, 500 ) );
    REQUIRE( who.has_charges( itype_ammolink223, 500 ) );
    // Use an owned native activity directly to isolate placement from selection.
    item::reload_option option( &who, target, ammo, -1 );
    option.qty( 500 );
    REQUIRE( option.qty() == 500 );
    who.assign_activity( reload_activity_actor( std::move( option ), 0, true ) );
    REQUIRE_FALSE( reload_would_fit( target, ammo, 500 ) );
    const int before = who.activity.moves_left;
    fixture.run( who, fixture.request( who, "step" ) );
    REQUIRE( fixture.reload.needs_placement );
    CHECK( who.activity.moves_left == before );
    CHECK( who.get_moves() == 100 );
    CHECK( target->ammo_remaining() == 0 );
    CHECK( ammo->charges == 500 );
    CHECK( target.check_parent_capacity_recursive() );
    save_reload_activity( who );
    CHECK( who.activity.moves_left == before );
    const int placement = GENERATE( 0, 1, 2 );
    if( placement != 0 ) {
        fixture.run( who, fixture.request( who, "place", [placement]( JsonOut & out ) {
            out.member( "placement", placement == 1 ? "drop" : "wield" );
        } ) );
        CHECK_FALSE( fixture.reload.needs_placement );
        const auto *actor = dynamic_cast<const reload_activity_actor *>( who.activity.actor.get() );
        REQUIRE( actor );
        CHECK( actor->target().held_by( who ) == ( placement == 2 ) );
        if( placement == 2 ) {
            CHECK( who.is_wielding( *actor->target() ) );
        }
        CHECK( actor->target()->ammo_remaining() == 0 );
        CHECK( ammo->charges == 500 );
    }
    fixture.run( who, fixture.request( who, "cancel" ) );
    CHECK_FALSE( who.activity );
    CHECK( ammo->charges == 500 );
}

TEST_CASE( "client_inventory_activity_view_does_not_advance_native_or_emit_lifecycle",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    cata_mp::set_client_mode( true );
    reload_events events;
    who.set_moves( 100 );
    SECTION( "reload" ) {
        who.assign_activity( reload_activity_actor::client_view() );
    }
    SECTION( "unload" ) {
        who.assign_activity( unload_activity_actor::client_view() );
    }
    SECTION( "insert" ) {
        who.assign_activity( insert_item_activity_actor::client_view() );
    }
    SECTION( "consume" ) {
        who.assign_activity( consume_activity_actor::client_view() );
    }
    who.activity.moves_left = 500;
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    const std::string before = capture_rng_state();
    who.activity.do_turn( who );
    CHECK( who.activity.moves_left == 500 );
    CHECK( who.get_moves() == 0 );
    CHECK( capture_rng_state() == before );
    const activity_id view_id = who.activity.id();
    who.cancel_activity();
    g->multiplayer_session().client_turn.client_last_grant_seq = 1;
    REQUIRE_FALSE( cata_mp::is_client_waiting_for_ack() );
    cata_mp::client_dispatch_wait_for_activity( view_id, true );
    cata_mp::mp_client_post_action( 100 );
    CHECK_FALSE( cata_mp::is_client_waiting_for_ack() );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
}

TEST_CASE( "reload_wire_updates_client_progress_inventory_and_completion_once",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_stanag30 ) );
    const item_location target = remote.get_wielded_item();
    const item_location ammo = loose_ammo( remote, 3 );
    const std::string started = fixture.start( remote, target, ammo, 3 );
    const std::string progressed = fixture.run( remote, fixture.request( remote, "step" ) );
    const int remaining = remote.activity.moves_left;
    REQUIRE( remaining > 0 );
    remote.set_moves( 100000 );
    const std::string finished = fixture.run( remote, fixture.request( remote, "step" ) );
    REQUIRE_FALSE( remote.activity );

    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    view.next_request = 1;
    reload_events events;
    local.assign_activity( reload_activity_actor::client_view() );
    const std::string before_rng = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( started ) );
    CHECK( cata_mp::inventory_activity_view( local.activity ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 0 );
    view.pending_request = 2;
    REQUIRE( cata_mp::client_apply_message( progressed ) );
    CHECK( local.activity.moves_left == remaining );
    CHECK( local.get_wielded_item()->ammo_remaining() == 1 );
    view.pending_request = 3;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 3 );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( local.activity );
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 3 );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
    CHECK( capture_rng_state() == before_rng );
}

TEST_CASE( "reload_save_after_source_exhaustion_retains_ammo_name_and_quantity",
           "[multiplayer][reload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_stanag30 ) );
    item_location target = who.get_wielded_item();
    target->set_var( "dirt", 8000 );
    item_location ammo = loose_ammo( who, 3 );
    fixture.start( who, target, ammo, 3 );
    for( int round = 0; round < 3; ++round ) {
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
    }
    REQUIRE( who.activity );
    REQUIRE_FALSE( ammo );
    REQUIRE( target->ammo_remaining() == 3 );
    save_reload_activity( who );
    Messages::clear_messages();
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( target->ammo_remaining() == 3 );
    const auto messages = Messages::recent_messages( 1 );
    REQUIRE( messages.size() == 1 );
    CHECK( messages.front().second.find( item::nname( itype_556, 3 ) ) != std::string::npos );
}

namespace
{
std::string start_unload( reload_fixture &fixture, Character &who,
                          const item_location &root, const unload_selection &selection,
                          const std::vector<unload_liquid_choice> &liquids = {} )
{
    const cata_mp::unload_intent intent = cata_mp::make_unload_intent( who, root, selection, liquids );
    return fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "unload" );
        out.member( "unload", intent );
    } ) );
}
} // namespace

TEST_CASE( "owned_unload_selects_only_the_requested_integral_source",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    get_avatar().set_moves( 517 );
    item gun( itype_test_multimag_gun_integral_ammo );
    item battery( itype_heavy_battery_cell );
    battery.ammo_set( itype_battery, 100 );
    REQUIRE( gun.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    REQUIRE( gun.put_in( item( itype_9mm, calendar::turn, 1 ),
                         pocket_type::MAGAZINE ).success() );
    who.set_wielded_item( gun );
    item_location root = who.get_wielded_item();
    const auto options = unload_sources( *root );
    REQUIRE( options.size() == 2 );
    unload_selection selected{ root, { options.back().identity } };
    bool valid = true;
    SECTION( "integral_only" ) {}
    SECTION( "stale_source" ) {
        selected.sources = { -1 };
        valid = false;
    }
    SECTION( "duplicate_source" ) {
        selected.sources.push_back( selected.sources.front() );
        valid = false;
    }
    const int before = who.get_moves();
    start_unload( fixture, who, root, selected );
    CHECK( root->ammo_remaining_in_pocket( "ammo" ) == ( valid ? 0 : 1 ) );
    REQUIRE( root->magazines_current().size() == 1 );
    CHECK( root->magazines_current().front()->ammo_remaining() == 100 );
    CHECK( ( who.get_moves() < before ) == valid );
    CHECK( get_avatar().get_moves() == 517 );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "owned_unload_uses_explicit_liquid_container_without_host_ui",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_moves( 1500 );
    get_avatar().set_moves( 517 );
    who.set_wielded_item( item( itype_test_multimag_turret_flamethrower ) );
    item_location root = who.get_wielded_item();
    item_pocket *fuel = root->pocket_by_id( "fuel" );
    REQUIRE( fuel );
    item gasoline( itype_gasoline, calendar::turn, 20 );
    REQUIRE( fuel->insert_item( gasoline ).success() );
    item &bottle = get_map().add_item_or_charges( who.pos_bub(), item( itype_bottle_plastic ) );
    item supply = gasoline;
    supply.charges = 10000;
    const int capacity = bottle.get_remaining_capacity_for_liquid( supply, true );
    REQUIRE( capacity > 5 );
    REQUIRE( bottle.fill_with( supply, capacity - 5 ) == capacity - 5 );
    unload_liquid_choice choice;
    choice.source = fuel->all_items_top().front()->uid().get_value();
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, item_location( map_cursor( who.pos_bub() ),
                                            &bottle ) );
    const auto sources = unload_sources( *root );
    REQUIRE( sources.size() == 1 );
    unload_selection selected{ root, { sources.front().identity } };
    const cata_mp::unload_intent intent = cata_mp::make_unload_intent( who, root, selected, { choice } );
    const std::string wire = fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "unload" );
        out.member( "unload", intent );
    } );
    fixture.run( who, wire );
    CHECK( root->ammo_remaining_in_pocket( "fuel" ) == 15 );
    CHECK( bottle.legacy_front().charges == capacity );
    const int after = who.get_moves();
    CHECK( after < 1400 );
    fixture.run( who, wire );
    CHECK( root->ammo_remaining_in_pocket( "fuel" ) == 15 );
    CHECK( bottle.legacy_front().charges == capacity );
    CHECK( who.get_moves() == after );
    CHECK( get_avatar().get_moves() == 517 );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_unload_activity_progress_cancel_and_source_loss",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    item mag( itype_stanag30 );
    mag.ammo_set( itype_556, 30 );
    who.set_wielded_item( mag );
    const item_location root = who.get_wielded_item();
    reload_events events;
    start_unload( fixture, who, root, { root, {} } );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    REQUIRE( who.activity.id() == ACT_UNLOAD );
    const int total = who.activity.moves_left;
    REQUIRE( total > 100 );
    const std::string first_step = fixture.request( who, "step" );
    fixture.run( who, first_step );
    REQUIRE( who.activity );
    CHECK( who.activity.moves_left < total );
    CHECK( root->ammo_remaining() == 30 );
    const int progress = who.activity.moves_left;
    fixture.run( who, first_step );
    CHECK( who.activity.moves_left == progress );
    SECTION( "finish_once" ) {
        who.set_moves( 100000 );
        const std::string finish = fixture.request( who, "step" );
        fixture.run( who, finish );
        CHECK_FALSE( who.activity );
        CHECK( root->ammo_remaining() == 0 );
        const int moves = who.get_moves();
        fixture.run( who, finish );
        CHECK( who.get_moves() == moves );
    }
    SECTION( "cancel_without_ap" ) {
        who.set_moves( 0 );
        fixture.run( who, fixture.request( who, "cancel" ) );
        CHECK_FALSE( who.activity );
        CHECK( root->ammo_remaining() == 30 );
        CHECK( who.get_moves() == 0 );
    }
    SECTION( "removed_source" ) {
        who.remove_weapon();
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == 100 );
    }
    SECTION( "removed_source_after_save" ) {
        save_reload_activity( who );
        who.remove_weapon();
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == 100 );
    }
    CHECK( events.starts == 1 );
    CHECK( events.finishes == 1 );
}

TEST_CASE( "owned_unload_liquid_activity_revalidates_destination_after_save",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_bottle_plastic ) );
    item_location root = who.get_wielded_item();
    item water( itype_water_clean, calendar::turn, 2 );
    REQUIRE( root->fill_with( water, 2 ) == 2 );
    item &bottle = get_map().add_item_or_charges( who.pos_bub(), item( itype_bottle_plastic ) );
    item_location destination( map_cursor( who.pos_bub() ), &bottle );
    unload_liquid_choice choice;
    choice.source = root->legacy_front().uid().get_value();
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, destination );
    start_unload( fixture, who, root, { root, {} }, { choice } );
    REQUIRE( who.activity );
    std::ostringstream saved;
    JsonOut out( saved );
    who.activity.serialize( out );
    JsonValue input = json_loader::from_string( saved.str() );
    player_activity loaded;
    loaded.deserialize( input.get_object() );
    who.activity = std::move( loaded );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    bool missing = false;
    SECTION( "destination_retained" ) {}
    SECTION( "destination_removed" ) {
        destination.remove_item();
        missing = true;
    }
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    if( missing ) {
        CHECK( root->legacy_front().charges == 2 );
    } else {
        CHECK( root->is_container_empty() );
        CHECK( destination->legacy_front().charges == 2 );
    }
}

TEST_CASE( "owned_unload_rejects_another_players_item_and_stale_cancel",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    item mag( itype_stanag30 );
    mag.ammo_set( itype_556, 30 );
    get_avatar().set_wielded_item( mag );
    const item_location foreign = get_avatar().get_wielded_item();
    start_unload( fixture, who, foreign, { foreign, {} } );
    CHECK_FALSE( who.activity );
    CHECK( foreign->ammo_remaining() == 30 );
    CHECK( who.get_moves() == 100 );
    who.set_wielded_item( mag );
    const item_location own = who.get_wielded_item();
    start_unload( fixture, who, own, { own, {} } );
    REQUIRE( who.activity );
    const std::string old_identity = std::to_string( who.activity.identity_generation() );
    fixture.run( who, fixture.request( who, "cancel" ) );
    start_unload( fixture, who, own, { own, {} } );
    REQUIRE( who.activity );
    fixture.run( who, fixture.request( who, "cancel", {}, old_identity ) );
    CHECK( who.activity );
    CHECK( own->ammo_remaining() == 30 );
}

TEST_CASE( "owned_unload_wire_applies_without_client_gameplay_hooks_or_rng",
           "[multiplayer][unload_owned]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    item mag( itype_stanag30 );
    mag.ammo_set( itype_556, 3 );
    remote.set_wielded_item( mag );
    item_location root = remote.get_wielded_item();
    const std::string started = start_unload( fixture, remote, root, { root, {} } );
    REQUIRE( remote.activity );
    remote.set_moves( 100000 );
    const std::string finished = fixture.run( remote, fixture.request( remote, "step" ) );
    REQUIRE_FALSE( remote.activity );
    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    reload_events events;
    local.assign_activity( unload_activity_actor::client_view() );
    const std::string rng = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( started ) );
    REQUIRE( cata_mp::inventory_activity_view( local.activity ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 3 );
    view.pending_request = 2;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 0 );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( local.activity );
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->ammo_remaining() == 0 );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
    CHECK( capture_rng_state() == rng );
}

namespace
{
std::string insert_request( reload_fixture &fixture, Character &who,
                            const item_location &destination, const drop_locations &items )
{
    const insert_selection selection = capture_insert_selection( who, destination, items, true );
    return fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "insert" );
        out.member( "insert", selection );
    } );
}

int container_quantity( const item_location &container, const itype_id &type )
{
    int total = 0;
    for( const item *inside : container->all_items_top( pocket_type::CONTAINER ) ) {
        if( inside->typeId() == type ) {
            total += inside->count();
        }
    }
    return total;
}
} // namespace

TEST_CASE( "owned_insert_advances_native_list_and_saves_between_items",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_backpack ) );
    const item_location destination = who.get_wielded_item();
    const item_location first = loose_ammo( who, 5 );
    const item_location second = get_map().add_item_or_charges_ret_loc( who.pos_bub(),
                                 item( itype_9mm, calendar::turn, 7 ) );
    reload_events events;
    const std::string start = insert_request( fixture, who, destination, {{first, 5}, {second, 7}} );
    fixture.run( who, start );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( events.starts == 1 );
    CHECK( container_quantity( destination, itype_556 ) == 0 );
    const int initial_moves = who.activity.moves_left;
    cata_mp::mp_tick_proxy_activity( who );
    CHECK( who.activity.moves_left == initial_moves );
    who.set_moves( 100000 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    REQUIRE( who.activity );
    CHECK_FALSE( first );
    CHECK( container_quantity( destination, itype_556 ) == 5 );
    const int remaining = who.activity.moves_left;
    const int ap = who.get_moves();
    fixture.run( who, step );
    CHECK( who.activity.moves_left == remaining );
    CHECK( who.get_moves() == ap );
    save_reload_activity( who );
    SECTION( "finish remaining item after save" ) {
        who.set_moves( 100000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( second );
        CHECK( container_quantity( destination, itype_9mm ) == 7 );
        CHECK( events.finishes == 2 );
    }
    SECTION( "cancel keeps earlier insert and remaining source" ) {
        who.set_moves( -10 );
        fixture.run( who, fixture.request( who, "cancel" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == -10 );
        REQUIRE( second );
        CHECK( second->charges == 7 );
        CHECK( container_quantity( destination, itype_9mm ) == 0 );
    }
    CHECK( container_quantity( destination, itype_556 ) == 5 );
}

TEST_CASE( "owned_insert_caps_changed_stack_and_preserves_partial_remainder",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_bottle_plastic ) );
    item_location destination = who.get_wielded_item();
    item jug( itype_jug_plastic );
    REQUIRE( jug.put_in( item( itype_water_clean, calendar::turn, 10 ),
                         pocket_type::CONTAINER ).success() );
    item_location root = get_map().add_item_or_charges_ret_loc( who.pos_bub(), jug );
    item_location water( root, root->all_items_top().front() );
    const std::string start = insert_request( fixture, who, destination, {{water, 10}} );
    fixture.run( who, start );
    REQUIRE( who.activity );
    water->charges = 3;
    save_reload_activity( who );
    who.set_moves( 100000 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    CHECK_FALSE( who.activity );
    CHECK( container_quantity( destination, itype_water_clean ) == 2 );
    CHECK( container_quantity( root, itype_water_clean ) == 1 );
    fixture.run( who, step );
    CHECK( container_quantity( destination, itype_water_clean ) == 2 );
    CHECK( container_quantity( root, itype_water_clean ) == 1 );
}

TEST_CASE( "owned_insert_rejects_invalid_selection_and_lost_targets",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_backpack ) );
    item_location destination = who.get_wielded_item();
    item_location source = loose_ammo( who, 5 );
    SECTION( "duplicate source" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{source, 5}, {source, 5}} ) );
    }
    SECTION( "quantity exceeds source" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{source, 6}} ) );
    }
    SECTION( "other player inventory" ) {
        get_avatar().set_wielded_item( item( itype_556, calendar::turn, 5 ) );
        fixture.run( who, insert_request( fixture, who, destination,
        {{get_avatar().get_wielded_item(), 5}} ) );
        CHECK( get_avatar().get_wielded_item()->charges == 5 );
    }
    SECTION( "loose liquid cannot be picked up through insertion" ) {
        item_location liquid = get_map().add_item_or_charges_ret_loc( who.pos_bub(),
                               item( itype_water_clean, calendar::turn, 5 ) );
        REQUIRE( liquid );
        fixture.run( who, insert_request( fixture, who, destination, {{liquid, 5}} ) );
        CHECK( liquid->charges == 5 );
    }
    SECTION( "self containment" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{destination, 1}} ) );
    }
    SECTION( "source removed after save" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{source, 5}} ) );
        REQUIRE( who.activity );
        save_reload_activity( who );
        source.remove_item();
        fixture.run( who, fixture.request( who, "step" ) );
    }
    SECTION( "destination removed after save" ) {
        fixture.run( who, insert_request( fixture, who, destination, {{source, 5}} ) );
        REQUIRE( who.activity );
        save_reload_activity( who );
        destination.remove_item();
        fixture.run( who, fixture.request( who, "step" ) );
    }
    CHECK_FALSE( who.activity );
    CHECK( who.get_moves() == 100 );
    if( source ) {
        CHECK( source->charges == 5 );
    }
    if( destination ) {
        CHECK( destination->is_container_empty() );
    }
}

TEST_CASE( "owned_unload_to_selected_container_uses_insert_activity",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_backpack ) );
    item_location destination = who.get_wielded_item();
    item bag( itype_backpack );
    REQUIRE( bag.put_in( item( itype_556, calendar::turn, 5 ),
                         pocket_type::CONTAINER ).success() );
    item_location root = get_map().add_item_or_charges_ret_loc( who.pos_bub(), bag );
    cata_mp::unload_intent intent = cata_mp::make_unload_intent( who, root, {root, {}}, {} );
    intent.destination = capture_item_source( who, destination );
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "unload" );
        out.member( "unload", intent );
    } ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( who.activity.id() == ACT_INSERT_ITEM );
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( root->is_container_empty() );
    CHECK( container_quantity( destination, itype_556 ) == 5 );
}

TEST_CASE( "owned_insert_wire_applies_without_duplicate_client_execution",
           "[multiplayer][insert_owned]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_backpack ) );
    const item_location source = loose_ammo( remote, 5 );
    const std::string started = fixture.run( remote, insert_request( fixture, remote,
    remote.get_wielded_item(), {{source, 5}} ) );
    REQUIRE( remote.activity );
    remote.set_moves( 100000 );
    const std::string finished = fixture.run( remote, fixture.request( remote, "step" ) );
    REQUIRE_FALSE( remote.activity );
    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    reload_events events;
    local.assign_activity( insert_item_activity_actor::client_view() );
    const std::string rng = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( started ) );
    CHECK( local.get_wielded_item()->is_container_empty() );
    view.pending_request = 2;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( local.activity );
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( container_quantity( local.get_wielded_item(), itype_556 ) == 5 );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
    CHECK( capture_rng_state() == rng );
}

namespace
{
struct consumption_fixture : reload_fixture {
    restore_on_out_of_scope<time_point> restore_turn{ calendar::turn };
    player_control_registry controls;
    std::optional<player_control> control;
    npc &remote() {
        npc &who = reload_fixture::remote();
        control.emplace( controls.claim( cata_mp::player_id( std::string( 32, '6' ) ), who ) );
        REQUIRE( who.is_player_controlled() );
        who.stomach.empty();
        who.guts.empty();
        who.set_hunger( 100 );
        who.set_thirst( 100 );
        return who;
    }
};

class consumption_events : public event_subscriber
{
    public:
        std::vector<character_id> actors;
        consumption_events() {
            get_event_bus().subscribe( this );
        }
        void notify( const cata::event &event ) override {
            if( event.type() == event_type::character_consumes_item ) {
                actors.push_back( event.get<character_id>( "character" ) );
            }
        }
};

item_location drinking_source( Character &who )
{
    item bottle( itype_bottle_plastic );
    REQUIRE( bottle.put_in( item( itype_water_clean, calendar::turn, 2 ),
                            pocket_type::CONTAINER ).success() );
    who.set_wielded_item( bottle );
    item_location root = who.get_wielded_item();
    return item_location( root, root->all_items_top().front() );
}

std::string consume_request( reload_fixture &fixture, Character &who,
                             const item_location &source, bool consequences = false )
{
    return fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "consume" );
        out.member( "source", capture_item_source( who, source ) );
        out.member( "allow_consequences", consequences );
    } );
}

struct consumption_completion {
    std::string request;
    std::string response;
};

consumption_completion finish_consumption( Character &who, reload_fixture *fixture = nullptr )
{
    REQUIRE( who.activity.id() == ACT_CONSUME );
    consumption_completion result;
    // Player-controlled bodies advance time-based activities once per world turn.
    for( int turn = 0; who.activity && turn < 1000; ++turn ) {
        calendar::turn += 1_seconds;
        who.set_moves( 100 );
        if( fixture ) {
            result.request = fixture->request( who, "step" );
            result.response = fixture->run( who, result.request );
        } else {
            who.activity.do_turn( who );
        }
    }
    REQUIRE_FALSE( who.activity );
    return result;
}

std::string needs_state( const Character &who )
{
    std::ostringstream text;
    JsonOut out( text );
    who.store_needs_state( out );
    return text.str();
}
} // namespace

TEST_CASE( "native_consumption_uses_the_activity_owner_not_the_global_avatar",
           "[multiplayer][consume_owned]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    item_location source = drinking_source( who );
    get_avatar().set_underwater( true );
    const std::string local_before = needs_state( get_avatar() );
    consumption_events events;
    who.assign_activity( consume_activity_actor( source ) );
    REQUIRE( who.activity.moves_left > 0 );
    finish_consumption( who );
    CHECK_FALSE( who.activity );
    CHECK( source->charges == 1 );
    CHECK( who.stomach.get_water() > 0_ml );
    CHECK( who.get_thirst() == who.Character::get_thirst() );
    REQUIRE( events.actors.size() == 1 );
    CHECK( events.actors.front() == who.getID() );
    CHECK( needs_state( get_avatar() ) == local_before );
}

TEST_CASE( "owned_consumption_progress_cancel_and_saved_source",
           "[multiplayer][consume_owned]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    item_location source = drinking_source( who );
    consumption_events events;
    fixture.run( who, consume_request( fixture, who, source ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    const int total = who.activity.moves_left;
    REQUIRE( total > 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( who.activity.moves_left < total );
    CHECK( who.get_moves() == 0 );
    CHECK( source->charges == 2 );
    save_reload_activity( who );
    SECTION( "finish once" ) {
        const consumption_completion finished = finish_consumption( who, &fixture );
        REQUIRE_FALSE( who.activity );
        CHECK( source->charges == 1 );
        const std::string after = needs_state( who );
        fixture.run( who, finished.request );
        CHECK( needs_state( who ) == after );
        CHECK( events.actors.size() == 1 );
    }
    SECTION( "cancel without AP" ) {
        who.set_moves( -5 );
        fixture.run( who, fixture.request( who, "cancel" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == -5 );
        CHECK( source->charges == 2 );
        CHECK( events.actors.empty() );
    }
    SECTION( "source removed after saving" ) {
        source.remove_item();
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( who.get_moves() == 100 );
        CHECK( events.actors.empty() );
    }
}

TEST_CASE( "owned_consumption_validates_actor_food_and_confirmation",
           "[multiplayer][consume_owned]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_apple, calendar::turn, 2 ) );
    item_location source = who.get_wielded_item();
    SECTION( "another player's food" ) {
        get_avatar().set_wielded_item( item( itype_apple ) );
        fixture.run( who, consume_request( fixture, who, get_avatar().get_wielded_item() ) );
        CHECK_FALSE( who.activity );
    }
    SECTION( "hard dietary restriction cannot be confirmed away" ) {
        source->set_flag( flag_DIRTY );
        fixture.run( who, consume_request( fixture, who, source, true ) );
        CHECK_FALSE( who.activity );
    }
    SECTION( "rotten food requires the owner's confirmation" ) {
        source->set_relative_rot( 2.0 );
        fixture.run( who, consume_request( fixture, who, source ) );
        CHECK_FALSE( who.activity );
        fixture.run( who, consume_request( fixture, who, source, true ) );
        CHECK( cata_mp::owns_inventory_activity( who ) );
        fixture.run( who, fixture.request( who, "cancel" ) );
    }
    CHECK( source->charges == 2 );
    CHECK( who.get_moves() == 100 );
    CHECK( who.stomach.contains() == 0_ml );
}

TEST_CASE( "consumption_results_restore_needs_without_client_ingestion_or_stale_overwrite",
           "[multiplayer][consume_owned]" )
{
    consumption_fixture fixture;
    restore_on_out_of_scope restore_menu( uistate.open_menu );
    restore_on_out_of_scope restore_consume_ui( uistate.consume_uistate );
    uistate.open_menu.reset();
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_chocolate, calendar::turn, 2 ) );
    const std::string started = fixture.run( remote, consume_request( fixture, remote,
                                remote.get_wielded_item() ) );
    REQUIRE( remote.activity );
    const std::string finished = finish_consumption( remote, &fixture ).response;
    REQUIRE_FALSE( remote.activity );
    const std::string expected = needs_state( remote );
    const int expected_morale = remote.get_morale_level();
    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    local.assign_activity( consume_activity_actor::client_view( true ) );
    const std::string rng = capture_rng_state();
    consumption_events events;
    REQUIRE( cata_mp::client_apply_message( started ) );
    local.get_morale_level(); // Populate the cache before restoring changed morale.
    view.pending_request = fixture.sequence;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( local.get_wielded_item()->charges == 1 );
    CHECK( needs_state( local ) == expected );
    CHECK( local.get_morale_level() == expected_morale );
    cata_mp::client_update_inventory_activity_view();
    REQUIRE( uistate.open_menu.has_value() );
    uistate.open_menu.reset(); // The UI consumed the deferred menu callback.
    REQUIRE( cata_mp::client_apply_message( finished ) );
    REQUIRE( cata_mp::client_apply_message( started ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( uistate.open_menu.has_value() );
    CHECK( needs_state( local ) == expected );
    CHECK( events.actors.empty() );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "client_consumption_continuation_respects_cancel_and_other_ui",
           "[multiplayer][consume_owned]" )
{
    reload_fixture fixture;
    restore_on_out_of_scope restore_menu( uistate.open_menu );
    restore_on_out_of_scope restore_consume_ui( uistate.consume_uistate );
    uistate.open_menu.reset();
    cata_mp::set_client_mode( true );
    avatar &local = get_avatar();
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    local.assign_activity( consume_activity_actor::client_view( true ) );
    view.active = true;
    view.finished = true;
    view.next_request = 17;
    bool existing_menu_ran = false;
    SECTION( "cancel does not reopen the menu" ) {
        local.cancel_activity();
    }
    SECTION( "single item use does not reopen the menu" ) {
        local.assign_activity( consume_activity_actor::client_view() );
    }
    SECTION( "a pending menu is preserved" ) {
        uistate.open_menu = [&]() {
            existing_menu_ran = true;
        };
    }
    const bool had_menu = uistate.open_menu.has_value();
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( view.active );
    CHECK( view.next_request == 17 );
    CHECK( uistate.open_menu.has_value() == had_menu );
    if( had_menu ) {
        ( *uistate.open_menu )();
        CHECK( existing_menu_ran );
    }
}

TEST_CASE( "shared_save_acknowledgement_requires_explicit_success",
           "[multiplayer][coop_save]" )
{
    reload_fixture fixture;
    cata_mp::set_client_mode( true );
    Messages::clear_messages();
    std::string response;
    bool saved = false;
    SECTION( "successful write" ) {
        response = R"({"type":"save_done","saved":true})";
        saved = true;
    }
    SECTION( "failed write" ) {
        response = R"({"type":"save_done","saved":false})";
    }
    SECTION( "legacy receipt without a write result" ) {
        response = R"({"type":"save_done"})";
    }
    REQUIRE( cata_mp::client_apply_message( response ) );
    const auto messages = Messages::recent_messages( 1 );
    REQUIRE( messages.size() == 1 );
    CHECK( ( messages.front().second.find( "The host saved the shared world" ) != std::string::npos ) ==
           saved );
    CHECK( ( messages.front().second.find( "did not confirm a successful save" ) != std::string::npos )
           ==
           !saved );
}

TEST_CASE( "rejoining_player_restores_saved_inventory_and_needs_without_stale_rollback",
           "[multiplayer][coop_save]" )
{
    consumption_fixture fixture;
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_chocolate, calendar::turn, 3 ) );
    remote.set_thirst( 42 );
    remote.set_str_base( 15 );
    remote.set_skill_level( skill_mechanics, 6 );
    remote.set_mutation( trait_QUICK );
    remote.set_mutation( trait_CARNIVORE );
    remote.set_mutation( trait_MASOCHIST );
    remote.set_pain( 80 );
    const int expected_morale = remote.get_morale_level();
    REQUIRE( expected_morale > 0 );
    // Set the authoritative body after trait setup, which itself recalculates HP.
    // A snapshot must retain this state, rather than recompute it from strength.
    remote.set_part_hp_max( bodypart_id( "arm_l" ), 137 );
    remote.set_part_hp_cur( bodypart_id( "arm_l" ), 17 );
    REQUIRE( remote.get_part_hp_cur( bodypart_id( "arm_l" ) ) == 17 );
    const std::string resumed = cata_mp::make_player_resume_result( remote, fixture.inventory );
    REQUIRE( fixture.inventory.revision > 0 );
    avatar &local = get_avatar();
    cata_mp::set_client_mode( true );
    local.set_wielded_item( item( itype_rock ) );
    local.set_str_base( 8 );
    REQUIRE_FALSE( local.has_trait_flag( json_flag_CARNIVORE_DIET ) );
    const character_id identity = local.getID();
    const tripoint_abs_ms position = local.pos_abs();
    local.activity = player_activity( ACT_WAIT, 400 );
    const std::string rng = capture_rng_state();
    consumption_events events;
    REQUIRE( cata_mp::client_apply_message( resumed ) );
    REQUIRE( local.get_wielded_item() );
    CHECK( local.get_wielded_item()->typeId() == itype_chocolate );
    CHECK( local.get_wielded_item()->charges == 3 );
    CHECK( local.get_thirst() == 42 );
    CHECK( local.get_str_base() == 15 );
    CHECK( local.get_morale_level() == expected_morale );
    CHECK( local.get_part_hp_cur( bodypart_id( "arm_l" ) ) == 17 );
    CHECK( local.get_part_hp_max( bodypart_id( "arm_l" ) ) == 137 );
    CHECK( local.get_skill_level( skill_mechanics ) == 6 );
    CHECK( local.has_trait( trait_QUICK ) );
    CHECK( local.has_trait_flag( json_flag_CARNIVORE_DIET ) );
    CHECK( local.getID() == identity );
    CHECK( local.pos_abs() == position );
    CHECK( local.activity.id() == ACT_WAIT );
    // Bad packets must not leave a half-replaced body or lose carried items.
    std::ostringstream before;
    JsonOut saved( before );
    local.store_player_state( saved );
    std::string malformed = before.str();
    const std::string::size_type body = malformed.find( "\"body\":" );
    REQUIRE( body != std::string::npos );
    malformed.replace( body, 6, "\"missing_body\"" );
    const std::string::size_type strength = malformed.find( "\"str_max\":15" );
    REQUIRE( strength != std::string::npos );
    malformed.replace( strength, 12, "\"str_max\":99" );
    CHECK_THROWS_AS( local.load_player_state( json_loader::from_string( malformed ).get_object() ),
                     JsonError );
    CHECK( local.get_str_base() == 15 );
    CHECK( local.get_morale_level() == expected_morale );
    REQUIRE( local.get_wielded_item() );
    CHECK( local.get_wielded_item()->charges == 3 );
    remote.get_wielded_item()->charges = 2;
    remote.set_thirst( 24 );
    REQUIRE( cata_mp::client_apply_message( cata_mp::make_player_resume_result( remote,
                                            fixture.inventory ) ) );
    REQUIRE( cata_mp::client_apply_message( resumed ) );
    CHECK( local.get_wielded_item()->charges == 2 );
    CHECK( local.get_thirst() == 24 );
    CHECK( events.actors.empty() );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "authoritative_character_turn_frames_preserve_replica_ownership",
           "[multiplayer][body_authority]" )
{
    consumption_fixture fixture;
    npc &owner = fixture.remote();
    owner.set_mutation( trait_CARNIVORE );
    owner.set_mutation( trait_MASOCHIST );
    owner.add_effect( effect_took_prozac, 3_hours );
    owner.set_pain( 80 );
    const int expected_morale = owner.get_morale_level();
    REQUIRE( expected_morale > 0 );
    owner.set_part_hp_max( bodypart_id( "arm_l" ), 137 );
    owner.set_part_hp_cur( bodypart_id( "arm_l" ), 17 );
    owner.set_part_temp_cur( bodypart_id( "arm_l" ), units::from_legacy_bodypart_temp( 3800 ) );
    owner.set_part_wetness( bodypart_id( "arm_l" ), 12 );
    owner.set_stamina( 1234 );
    owner.set_thirst( 42 );
    owner.magic->set_mana( 456 );
    owner.add_effect( effect_bleed, 10_minutes, bodypart_id( "arm_l" ), true );
    owner.add_effect( effect_sleep, 3_hours );
    const auto snapshot = [&]() {
        std::ostringstream encoded;
        JsonOut out( encoded );
        owner.store_turn_state( out );
        return encoded.str();
    };
    const auto frame = [&]( int64_t revision ) {
        return R"({"type":"state","character_revision":)" + std::to_string( revision ) +
               R"(,"character_turn":)" + snapshot() + "}";
    };
    const std::string first = frame( 1 );
    const JsonObject projected = json_loader::from_string( snapshot() ).get_object();
    projected.allow_omitted_members();
    CHECK_FALSE( projected.has_member( "inv" ) );
    CHECK_FALSE( projected.has_member( "worn" ) );
    CHECK_FALSE( projected.has_member( "weapon" ) );
    CHECK_FALSE( projected.has_member( "activity" ) );
    CHECK_FALSE( projected.has_member( "location" ) );

    avatar &replica = get_avatar();
    cata_mp::set_client_mode( true );
    replica.set_wielded_item( item( itype_rock ) );
    const item_location held = replica.get_wielded_item();
    const item *const address = held.get_item();
    const character_id identity = replica.getID();
    const tripoint_abs_ms position = replica.pos_abs();
    replica.activity = player_activity( ACT_WAIT, 400 );
    replica.set_moves( 37 );
    replica.add_effect( effect_poison, 10_minutes );
    REQUIRE_FALSE( replica.has_trait_flag( json_flag_CARNIVORE_DIET ) );
    const std::string rng = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( first ) );
    CHECK( replica.get_part_hp_cur( bodypart_id( "arm_l" ) ) == 17 );
    CHECK( replica.get_part_hp_max( bodypart_id( "arm_l" ) ) == 137 );
    CHECK( replica.get_part_temp_cur( bodypart_id( "arm_l" ) ) ==
           units::from_legacy_bodypart_temp( 3800 ) );
    CHECK( replica.get_part_wetness( bodypart_id( "arm_l" ) ) == 12 );
    CHECK( replica.get_stamina() == 1234 );
    CHECK( replica.get_thirst() == 42 );
    CHECK( replica.magic->available_mana() == 456 );
    CHECK( replica.get_pain() == 80 );
    CHECK( replica.get_morale_level() == expected_morale );
    CHECK( replica.get_effect( effect_sleep ).get_duration() == 3_hours );
    CHECK( replica.get_effect( effect_bleed, bodypart_id( "arm_l" ) ).get_duration() ==
           10_minutes );
    CHECK_FALSE( replica.has_effect( effect_poison ) );
    CHECK( replica.has_trait_flag( json_flag_CARNIVORE_DIET ) );
    CHECK( replica.getID() == identity );
    CHECK( replica.pos_abs() == position );
    CHECK( replica.activity.id() == ACT_WAIT );
    CHECK( replica.activity.moves_left == 400 );
    CHECK( replica.get_moves() == 37 );
    CHECK( held.get_item() == address );
    CHECK( replica.get_wielded_item().get_item() == address );
    CHECK( capture_rng_state() == rng );

    // Two updates may occur without advancing the game calendar. The earlier
    // frame must not undo a more recent effect removal or stamina expenditure.
    owner.set_stamina( 900 );
    owner.remove_effect( effect_bleed );
    REQUIRE( cata_mp::client_apply_message( frame( 2 ) ) );
    REQUIRE( cata_mp::client_apply_message( first ) );
    CHECK( replica.get_stamina() == 900 );
    CHECK_FALSE( replica.has_effect( effect_bleed ) );
    CHECK( held.get_item() == address );

    // A malformed body cannot leave a half-imported character behind.
    owner.set_stamina( 500 );
    std::string malformed = snapshot();
    const std::string::size_type body = malformed.find( "\"body\":" );
    REQUIRE( body != std::string::npos );
    malformed.replace( body, 6, "\"missing_body\"" );
    const std::string before_rejected = capture_rng_state();
    CHECK_THROWS_AS( replica.load_turn_state( json_loader::from_string( malformed ).get_object() ),
                     JsonError );
    CHECK( replica.get_stamina() == 900 );
    CHECK( replica.get_part_hp_cur( bodypart_id( "arm_l" ) ) == 17 );
    CHECK( replica.activity.id() == ACT_WAIT );
    CHECK( held.get_item() == address );
    CHECK( capture_rng_state() == before_rejected );
}


TEST_CASE( "current_item_replica_preserves_zero_charges_and_timers",
           "[multiplayer][item_turn]" )
{
    reload_fixture fixture;
    item ammo( itype_556, calendar::turn, 5 );
    ammo.charges = 0;
    ammo.active = true;
    ammo.item_counter = 7;
    ammo.countdown_point = calendar::turn + 13_turns;
    const auto encode = []( const item & value ) {
        std::ostringstream text;
        JsonOut out( text );
        value.serialize( out );
        return text.str();
    };
    const std::string wire = encode( ammo );
    const std::string rng = capture_rng_state();
    item restored = item::from_current_state( json_loader::from_string( wire ).get_object() );
    CHECK( capture_rng_state() == rng );
    CHECK( restored.uid() == ammo.uid() );
    CHECK( restored.charges == 0 );
    CHECK( restored.active );
    CHECK( restored.item_counter == 7 );
    CHECK( restored.countdown_point == ammo.countdown_point );
    CHECK( ammo.charges == 0 );
    CHECK( encode( restored ) == wire );

    CHECK_THROWS_AS( item::from_current_state( json_loader::from_string(
                         R"({"typeid":"556","uid":0})" ).get_object() ), JsonError );
    item rock( itype_rock );
    rock.charges = -1;
    const std::string rock_wire = encode( rock );
    CHECK( rock.charges == -1 );
    CHECK( item::from_current_state( json_loader::from_string( rock_wire ).get_object() ).charges ==
           -1 );

    // Historical save compatibility still repairs old zero-count ammunition.
    item legacy;
    legacy.deserialize( json_loader::from_string( wire ).get_object() );
    CHECK( legacy.charges > 0 );

    item bag( itype_backpack );
    REQUIRE( bag.put_in( ammo, pocket_type::CONTAINER ).success() );
    item cable( itype_power_cord );
    cable.link().last_processed = calendar::turn - 17_turns;
    REQUIRE( bag.put_in( cable, pocket_type::CONTAINER ).success() );
    const std::string nested = encode( bag );
    const std::string nested_rng = capture_rng_state();
    item restored_bag = item::from_current_state( json_loader::from_string( nested ).get_object() );
    CHECK( capture_rng_state() == nested_rng );
    CHECK( encode( restored_bag ) == nested );
}

TEST_CASE( "native_item_turns_replicate_changes_and_preserve_surviving_locations",
           "[multiplayer][item_turn]" )
{
    reload_fixture fixture;
    npc &owner = fixture.remote();
    owner.set_wielded_item( item( itype_backpack ) );
    item_location bag = owner.get_wielded_item();
    item temporary( itype_rock );
    temporary.ethereal = true;
    temporary.set_var( "ethereal", 2 );
    REQUIRE( bag->put_in( temporary, pocket_type::CONTAINER ).success() );
    REQUIRE( bag->put_in( item( itype_556, calendar::turn, 5 ),
                          pocket_type::CONTAINER ).success() );
    avatar &replica = get_avatar();
    cata_mp::set_client_mode( true );
    const std::string initial = cata_mp::make_inventory_update( owner, fixture.inventory );
    REQUIRE( cata_mp::client_apply_message( initial ) );
    cata_mp::pickup_client_state &client = g->multiplayer_session().client_pickup;
    const item_location replica_bag = replica.get_wielded_item();
    const item *const bag_address = replica_bag.get_item();
    const auto source_ammo = owner.items_with( []( const item & it ) {
        return it.typeId() == itype_556;
    } );
    const auto replica_ammo = replica.items_with( []( const item & it ) {
        return it.typeId() == itype_556;
    } );
    const auto replica_rocks = replica.items_with( []( const item & it ) {
        return it.typeId() == itype_rock;
    } );
    REQUIRE( source_ammo.size() == 1 );
    REQUIRE( replica_ammo.size() == 1 );
    REQUIRE( replica_rocks.size() == 1 );
    const item_location rounds( replica_bag, replica_ammo.front() );
    const item_location disappearing( replica_bag, replica_rocks.front() );
    const item *const rounds_address = rounds.get_item();
    replica.activity = player_activity( ACT_WAIT, 400 );
    replica.activity.targets.push_back( rounds );

    const cata_mp::inventory_turn_snapshot before = cata_mp::capture_inventory_turn( owner );
    CHECK_FALSE( cata_mp::make_inventory_turn_update( owner, before, fixture.inventory ) );
    owner.process_items( &get_map() );
    source_ammo.front()->charges = 3;
    const auto first = cata_mp::make_inventory_turn_update( owner, before, fixture.inventory );
    REQUIRE( first );
    const JsonObject delta = json_loader::from_string( *first ).get_object();
    delta.allow_omitted_members();
    CHECK( delta.get_string( "type" ) == "inventory_delta" );
    CHECK_FALSE( delta.has_member( "carried" ) );
    CHECK( delta.get_array( "items" ).size() == 2 );
    const std::string before_apply = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( *first ) );
    CHECK( capture_rng_state() == before_apply );
    REQUIRE( rounds.get_item() == rounds_address );
    CHECK( rounds->charges == 3 );
    REQUIRE( disappearing );
    CHECK( disappearing->get_var( "ethereal", 0 ) == 1 );
    CHECK( replica_bag.get_item() == bag_address );
    CHECK( replica.activity.targets.front().get_item() == rounds_address );
    CHECK( client.revision == fixture.inventory.revision );
    const JsonObject old_upload = json_loader::from_string(
                                      R"({"inventory_revision":1})" ).get_object();
    CHECK_FALSE( cata_mp::pickup_inventory_revision_matches( old_upload, fixture.inventory ) );

    const cata_mp::inventory_turn_snapshot second_before = cata_mp::capture_inventory_turn( owner );
    owner.process_items( &get_map() );
    source_ammo.front()->charges = 0;
    const auto second = cata_mp::make_inventory_turn_update( owner, second_before, fixture.inventory );
    REQUIRE( second );
    const JsonObject graph = json_loader::from_string( *second ).get_object();
    graph.allow_omitted_members();
    CHECK( graph.get_string( "type" ) == "inventory_update" );
    REQUIRE( cata_mp::client_apply_message( *second ) );
    CHECK_FALSE( disappearing );
    CHECK( replica_bag.get_item() == bag_address );
    REQUIRE( rounds.get_item() == rounds_address );
    CHECK( rounds->charges == 0 );
    CHECK( replica.activity.targets.front().get_item() == rounds_address );
    CHECK( replica.items_with( []( const item & it ) {
        return it.typeId() == itype_rock;
    } ).empty() );
    REQUIRE( cata_mp::client_apply_message( *first ) );
    CHECK( client.revision == fixture.inventory.revision );
    CHECK_FALSE( disappearing );
}

TEST_CASE( "item_delta_rejects_gaps_and_duplicate_ids_before_modifying_items",
           "[multiplayer][item_turn]" )
{
    reload_fixture fixture;
    avatar &replica = get_avatar();
    replica.set_wielded_item( item( itype_556, calendar::turn, 5 ) );
    item_location rounds = replica.get_wielded_item();
    std::ostringstream payload;
    {
        JsonOut out( payload );
        rounds->store_current_state( out );
    }
    const auto request = [&]( int64_t base, bool duplicate ) {
        const std::string entry = R"({"uid":)" + std::to_string( rounds->uid().get_value() ) +
                                  R"(,"state":)" + payload.str() + "}";
        return R"({"base_revision":)" + std::to_string( base ) +
               R"(,"inventory_revision":2,"items":[)" + entry + ( duplicate ? "," + entry : "" ) + "]}";
    };
    rounds->charges = 3;
    cata_mp::pickup_client_state client;
    client.revision = 1;
    const std::string rng = capture_rng_state();
    CHECK_THROWS_AS( cata_mp::apply_inventory_turn_update( replica,
                     json_loader::from_string( request( 0, false ) ).get_object(), client ), JsonError );
    CHECK_THROWS_AS( cata_mp::apply_inventory_turn_update( replica,
                     json_loader::from_string( request( 1, true ) ).get_object(), client ), JsonError );
    CHECK( rounds->charges == 3 );
    CHECK( client.revision == 1 );
    CHECK( capture_rng_state() == rng );
}


TEST_CASE( "owned_medication_applies_one_dose_to_its_actor_and_restores_the_client",
           "[multiplayer][consume_owned][medication_owned]" )
{
    const std::vector<std::pair<std::string, std::string>> medicines = {
        { "aspirin", "pkill1_nsaid" }, { "antibiotics", "antibiotic" },
        { "codeine", "pkill2" }, { "adrenaline_injector", "pkill2" },
        { "flu_shot", "flushot" }
    };
    for( const auto &medicine : medicines ) {
        DYNAMIC_SECTION( medicine.first ) {
            consumption_fixture fixture;
            npc &owner = fixture.remote();
            owner.set_wielded_item( item( itype_backpack ) );
            item_location bag = owner.get_wielded_item();
            REQUIRE( bag->put_in( item( itype_id( medicine.first ), calendar::turn, 2 ),
                                  pocket_type::CONTAINER ).success() );
            item_location source( bag, bag->all_items_top().front() );
            const efftype_id effect( medicine.second );
            const std::string host_before = needs_state( get_avatar() );
            consumption_events events;
            const std::string started = fixture.run( owner, consume_request( fixture, owner, source ) );
            REQUIRE( cata_mp::owns_inventory_activity( owner ) );
            CHECK( source->charges == 2 );
            CHECK_FALSE( owner.has_effect( effect ) );
            save_reload_activity( owner );
            const consumption_completion completed = finish_consumption( owner, &fixture );
            const std::string &step = completed.request;
            const std::string &finished = completed.response;
            REQUIRE_FALSE( owner.activity );
            REQUIRE( owner.has_effect( effect ) );
            CHECK( source->charges == 1 );
            CHECK( events.actors == std::vector<character_id> { owner.getID() } );
            CHECK( needs_state( get_avatar() ) == host_before );
            CHECK_FALSE( get_avatar().has_effect( effect ) );
            const time_duration duration = owner.get_effect_dur( effect );
            const std::string after_dose = capture_rng_state();
            fixture.run( owner, step );
            CHECK( capture_rng_state() == after_dose );
            CHECK( source->charges == 1 );
            CHECK( owner.get_effect_dur( effect ) == duration );
            CHECK( events.actors.size() == 1 );

            avatar &replica = get_avatar();
            cata_mp::set_client_mode( true );
            cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
            view.active = true;
            view.pending_request = 1;
            replica.assign_activity( consume_activity_actor::client_view( false ) );
            const std::string before_restore = capture_rng_state();
            REQUIRE( cata_mp::client_apply_message( started ) );
            view.pending_request = fixture.sequence;
            REQUIRE( cata_mp::client_apply_message( finished ) );
            REQUIRE( replica.has_effect( effect ) );
            CHECK( replica.get_effect_dur( effect ) == duration );
            CHECK( replica.get_pain() == owner.get_pain() );
            CHECK( cata_mp::inventory_activity_view( replica.activity ) );
            CHECK( needs_state( replica ) == needs_state( owner ) );
            const auto remaining = replica.items_with( [&]( const item & it ) {
                return it.typeId() == itype_id( medicine.first );
            } );
            REQUIRE( remaining.size() == 1 );
            CHECK( remaining.front()->charges == 1 );
            REQUIRE( cata_mp::client_apply_message( finished ) );
            REQUIRE( cata_mp::client_apply_message( started ) );
            CHECK( remaining.front()->charges == 1 );
            CHECK( replica.get_effect_dur( effect ) == duration );
            CHECK( events.actors.size() == 1 );
            CHECK( capture_rng_state() == before_restore );
        }
    }
}

TEST_CASE( "owned_injection_requires_the_actors_tool_through_completion",
           "[multiplayer][consume_owned][medication_owned]" )
{
    consumption_fixture fixture;
    npc &owner = fixture.remote();
    owner.set_wielded_item( item( itype_backpack ) );
    item_location bag = owner.get_wielded_item();
    REQUIRE( bag->put_in( item( itype_morphine, calendar::turn, 2 ),
                          pocket_type::CONTAINER ).success() );
    item_location drug( bag, bag->all_items_top().front() );
    get_avatar().set_wielded_item( item( itype_syringe ) );
    fixture.run( owner, consume_request( fixture, owner, drug ) );
    CHECK_FALSE( owner.activity );
    CHECK( drug->charges == 2 );
    CHECK_FALSE( owner.has_effect( effect_pkill3 ) );
    REQUIRE( bag->put_in( item( itype_syringe ), pocket_type::CONTAINER ).success() );
    fixture.run( owner, consume_request( fixture, owner, drug ) );
    REQUIRE( cata_mp::owns_inventory_activity( owner ) );
    bool removed = false;
    SECTION( "tool remains available" ) {}
    SECTION( "tool removed during activity" ) {
        const auto tools = owner.items_with( []( const item & it ) {
            return it.typeId() == itype_syringe;
        } );
        REQUIRE( tools.size() == 1 );
        item_location( bag, tools.front() ).remove_item();
        removed = true;
    }
    finish_consumption( owner, &fixture );
    CHECK_FALSE( owner.activity );
    CHECK( drug->charges == ( removed ? 2 : 1 ) );
    CHECK( owner.has_effect( effect_pkill3 ) == !removed );
    CHECK_FALSE( get_avatar().has_effect( effect_pkill3 ) );
}

TEST_CASE( "owned_consumption_does_not_invoke_targeted_or_scripted_medicine",
           "[multiplayer][consume_owned][medication_owned]" )
{
    for( const char *id : {
             "bfipowder", "myopia_contacts_weekly"
         } ) {
        DYNAMIC_SECTION( id ) {
            consumption_fixture fixture;
            npc &owner = fixture.remote();
            owner.set_wielded_item( item( itype_id( id ), calendar::turn, 2 ) );
            const item_location source = owner.get_wielded_item();
            const std::string rng = capture_rng_state();
            const std::string before = needs_state( owner );
            fixture.run( owner, consume_request( fixture, owner, source, true ) );
            CHECK_FALSE( owner.activity );
            CHECK( source->charges == 2 );
            CHECK( needs_state( owner ) == before );
            CHECK( capture_rng_state() == rng );
        }
    }
}

TEST_CASE( "client_medication_activation_submits_without_obtaining_or_consuming",
           "[multiplayer][consume_owned][medication_owned]" )
{
    reload_fixture fixture;
    avatar &local = get_avatar();
    local.stomach.empty();
    local.set_moves( 100 );
    item_location source = get_map().add_item_or_charges_ret_loc( local.pos_bub(),
                           item( itype_aspirin, calendar::turn, 2 ) );
    REQUIRE( source );
    const int64_t uid = source->uid().get_value();
    const std::string rng = capture_rng_state();
    cata_mp::set_client_mode( true );
    avatar_action::use_item( local, source );
    const cata_mp::inventory_activity_client_state &view =
        g->multiplayer_session().client_inventory_activity;
    CHECK( view.active );
    CHECK( view.pending_request == 1 );
    CHECK( cata_mp::inventory_activity_view( local.activity ) );
    REQUIRE( source );
    CHECK( source.where() == item_location::type::map );
    CHECK( source->uid().get_value() == uid );
    CHECK( source->charges == 2 );
    CHECK_FALSE( local.has_effect( effect_pkill1_nsaid ) );
    CHECK( capture_rng_state() == rng );
}

namespace
{
std::string firstaid_request( reload_fixture &fixture, Character &healer, Character &patient,
                              const item_location &source, const std::string &part = "arm_l" )
{
    return fixture.request( healer, "start", [&]( JsonOut & out ) {
        out.member( "kind", "firstaid" );
        out.member( "source", cata_mp::capture_item_source( healer, source ) );
        out.member( "self", &healer == &patient );
        out.member( "target", patient.pos_abs() );
        out.member( "target_player", cata_mp::partner_identity( patient.getID() ).str() );
        out.member( "target_npc", patient.getID().get_value() );
        out.member( "bodypart", part );
    } );
}

std::string practice_state( const Character &who )
{
    std::ostringstream text;
    JsonOut out( text );
    who.store_practice_state( out );
    return text.str();
}
}

TEST_CASE( "owned_firstaid_treats_the_selected_patient_and_part_once",
           "[multiplayer][firstaid_owned]" )
{
    for( const bool self : {
             true, false
         } ) {
        for( const char *medicine : {
                 "bfipowder", "bandages"
             } ) {
            DYNAMIC_SECTION( medicine << " self=" << self ) {
                consumption_fixture fixture;
                npc &healer = fixture.remote();
                avatar &host = get_avatar();
                host.ensure_player_id();
                host.setpos( get_map(), tripoint_bub_ms( 61, 60, 0 ) );
                Character &patient = self ? static_cast<Character &>( healer ) : host;
                const bodypart_id arm( "arm_l" );
                const bodypart_id torso( "torso" );
                patient.set_part_hp_cur( arm, patient.get_part_hp_max( arm ) - 10 );
                patient.set_part_hp_cur( torso, patient.get_part_hp_max( torso ) - 30 );
                const efftype_id effect( std::string( medicine ) == "bandages" ? "bandaged" :
                                         "disinfected" );
                healer.set_wielded_item( item( itype_backpack ) );
                item_location bag = healer.get_wielded_item();
                item dressing( itype_id( medicine ), calendar::turn );
                if( dressing.count_by_charges() ) {
                    dressing.charges = 2;
                }
                REQUIRE( bag->put_in( dressing,
                                      pocket_type::CONTAINER ).success() );
                item_location source( bag, bag->all_items_top().front() );
                const bool charged = source->count_by_charges();
                const std::string untouched_practice = practice_state( host );
                fixture.run( healer, firstaid_request( fixture, healer, patient, source ) );
                REQUIRE( cata_mp::owns_inventory_activity( healer ) );
                CHECK( cata_mp::is_passive_activity( healer.activity.id().str() ) );
                CHECK( healer.get_moves() == 0 );
                CHECK_FALSE( patient.has_effect( effect, arm ) );
                save_reload_activity( healer );
                healer.set_moves( 100000 );
                const std::string step = fixture.request( healer, "step" );
                fixture.run( healer, step );
                REQUIRE_FALSE( healer.activity );
                REQUIRE( patient.has_effect( effect, arm ) );
                CHECK_FALSE( patient.has_effect( effect, torso ) );
                CHECK( practice_state( host ) == untouched_practice );
                CHECK( healer.get_proficiency_practiced_time( proficiency_prof_wound_care ) >
                       0_turns );
                if( !self ) {
                    CHECK_FALSE( healer.has_effect( effect, arm ) );
                }
                if( charged ) {
                    REQUIRE( source );
                    CHECK( source->charges == 1 );
                } else {
                    CHECK_FALSE( source );
                }
                const time_duration duration = patient.get_effect_dur( effect, arm );
                const std::string progress = practice_state( healer );
                const std::string rng = capture_rng_state();
                fixture.run( healer, step );
                CHECK( patient.get_effect_dur( effect, arm ) == duration );
                CHECK( practice_state( healer ) == progress );
                CHECK( capture_rng_state() == rng );
            }
        }
    }
}

TEST_CASE( "owned_firstaid_revalidates_tools_patients_and_cancellation",
           "[multiplayer][firstaid_owned]" )
{
    consumption_fixture fixture;
    npc &healer = fixture.remote();
    avatar &patient = get_avatar();
    patient.ensure_player_id();
    patient.setpos( get_map(), tripoint_bub_ms( 61, 60, 0 ) );
    const bodypart_id arm( "arm_l" );
    patient.set_part_hp_cur( arm, patient.get_part_hp_max( arm ) - 10 );
    healer.set_wielded_item( item( itype_bfipowder, calendar::turn, 2 ) );
    item_location source = healer.get_wielded_item();
    reload_events events;
    fixture.run( healer, firstaid_request( fixture, healer, patient, source ) );
    REQUIRE( cata_mp::owns_inventory_activity( healer ) );
    std::string operation = "step";
    SECTION( "patient walks away" ) {
        patient.setpos( get_map(), tripoint_bub_ms( 64, 60, 0 ) );
    }
    SECTION( "tool is removed" ) {
        source.remove_item();
    }
    SECTION( "tool changes type" ) {
        source->convert( itype_aspirin );
    }
    SECTION( "tool becomes filthy" ) {
        source->set_flag( flag_FILTHY );
    }
    SECTION( "cancel without action points" ) {
        operation = "cancel";
    }
    healer.set_moves( operation == "cancel" ? -5 : 100000 );
    const std::string request = fixture.request( healer, operation );
    fixture.run( healer, request );
    CHECK_FALSE( healer.activity );
    CHECK_FALSE( patient.has_effect( effect_disinfected, arm ) );
    CHECK( healer.get_proficiency_practiced_time( proficiency_prof_wound_care ) == 0_turns );
    CHECK( events.finishes == 1 );
    if( source ) {
        CHECK( source->charges == 2 );
    }
    // Native cancellation emits a gameplay event whose EOCs may use RNG.
    // A repeated request must not emit it again or advance gameplay RNG.
    const std::string rng = capture_rng_state();
    fixture.run( healer, request );
    CHECK( events.finishes == 1 );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "owned_firstaid_rejects_invalid_or_untreatable_body_parts",
           "[multiplayer][firstaid_owned]" )
{
    consumption_fixture fixture;
    npc &healer = fixture.remote();
    healer.set_wielded_item( item( itype_bfipowder, calendar::turn, 2 ) );
    item_location source = healer.get_wielded_item();
    item_location selected = source;
    std::string part = "arm_l";
    SECTION( "unknown body part" ) {
        part = "no_such_part";
    }
    SECTION( "undamaged body part" ) {}
    SECTION( "another actor owns the tool" ) {
        healer.set_part_hp_cur( bodypart_id( "arm_l" ), 10 );
        get_avatar().set_wielded_item( item( itype_bfipowder, calendar::turn, 2 ) );
        selected = get_avatar().get_wielded_item();
    }
    const std::string rng = capture_rng_state();
    fixture.run( healer, firstaid_request( fixture, healer, healer, selected, part ) );
    CHECK_FALSE( healer.activity );
    CHECK( source->charges == 2 );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "firstaid_results_restore_body_and_practice_without_replaying_treatment",
           "[multiplayer][firstaid_owned]" )
{
    consumption_fixture fixture;
    npc &healer = fixture.remote();
    const bodypart_id arm( "arm_l" );
    healer.set_part_hp_cur( arm, healer.get_part_hp_max( arm ) - 10 );
    healer.set_wielded_item( item( itype_bfipowder, calendar::turn, 2 ) );
    item_location source = healer.get_wielded_item();
    const std::string started = fixture.run( healer, firstaid_request( fixture, healer, healer,
                                source ) );
    REQUIRE( cata_mp::owns_inventory_activity( healer ) );
    healer.set_moves( 100000 );
    const std::string finished = fixture.run( healer, fixture.request( healer, "step" ) );
    REQUIRE_FALSE( healer.activity );
    REQUIRE( healer.has_effect( effect_disinfected, arm ) );
    avatar &replica = get_avatar();
    cata_mp::set_client_mode( true );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = 1;
    replica.assign_activity( firstaid_activity_actor::client_view() );
    reload_events events;
    const std::string rng = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( started ) );
    view.pending_request = 2;
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( replica.get_part_hp_cur( arm ) == healer.get_part_hp_cur( arm ) );
    CHECK( replica.get_effect_dur( effect_disinfected, arm ) ==
           healer.get_effect_dur( effect_disinfected, arm ) );
    CHECK( practice_state( replica ) == practice_state( healer ) );
    REQUIRE( replica.get_wielded_item() );
    CHECK( replica.get_wielded_item()->charges == 1 );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( replica.activity );
    REQUIRE( cata_mp::client_apply_message( started ) );
    REQUIRE( cata_mp::client_apply_message( finished ) );
    CHECK( practice_state( replica ) == practice_state( healer ) );
    CHECK( replica.get_wielded_item()->charges == 1 );
    CHECK( events.finishes == 0 );
    CHECK( capture_rng_state() == rng );
}


TEST_CASE( "owned_craft_request_completes_for_its_player_once_after_activity_reload",
           "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const recipe_id &recipe = recipe_cudgel_test_charged_fast_stepless;
    who.learn_recipe( &recipe.obj() );
    who.set_wielded_item( item( &recipe.obj(), 1, item_components{}, {}, false ) );
    item_location workpiece = who.get_wielded_item();
    workpiece->item_counter = 10000000;
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    save_reload_activity( who );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( workpiece );
    REQUIRE( who.get_wielded_item() );
    CHECK( who.get_wielded_item()->typeId() == itype_cudgel );
    const int64_t result = who.get_wielded_item()->uid().get_value();
    const std::string completed = capture_rng_state();
    fixture.run( who, step );
    CHECK( who.get_wielded_item()->uid().get_value() == result );
    CHECK( capture_rng_state() == completed );
    CHECK_FALSE( get_avatar().get_wielded_item() );
}

TEST_CASE( "owned_craft_pending_outputs_survive_cancel_and_reject_an_old_activity_request",
           "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const recipe_id &recipe = recipe_cudgel_test_charged_fast_stepless;
    who.learn_recipe( &recipe.obj() );
    who.set_wielded_item( item( &recipe.obj(), 1, item_components{}, {}, false ) );
    item_location workpiece = who.get_wielded_item();
    workpiece->item_counter = 10000000;
    craft_result_state &completion = workpiece->get_craft_results();
    completion.stage = craft_completion_stage::primary_results;
    completion.primary_had_results = true;
    completion.pending.emplace_back( itype_gasoline, calendar::turn, 20 );
    const int64_t fuel_id = completion.pending.front().uid().get_value();
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    const std::string old_activity = std::to_string( who.activity.identity_generation() );
    fixture.run( who, fixture.request( who, "step" ) );
    const auto *actor = dynamic_cast<const craft_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for() == "results" );
    fixture.run( who, fixture.request( who, "cancel" ) );
    CHECK_FALSE( who.activity );
    REQUIRE( workpiece );
    REQUIRE( workpiece->get_craft_results().pending.size() == 1 );
    CHECK( workpiece->get_craft_results().pending.front().uid().get_value() == fuel_id );
    who.set_moves( 100 );
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    fixture.run( who, fixture.request( who, "cancel", {}, old_activity ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    fixture.run( who, fixture.request( who, "step" ) );
    item &bottle = get_map().add_item_or_charges( who.pos_bub(), item( itype_bottle_plastic ) );
    unload_liquid_choice choice;
    choice.source = fuel_id;
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, item_location( map_cursor( who.pos_bub() ),
                                            &bottle ) );
    const std::string collect = fixture.request( who, "results", [&]( JsonOut & out ) {
        out.member( "liquids", std::vector<unload_liquid_choice> { choice } );
    } );
    fixture.run( who, collect );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( workpiece );
    REQUIRE_FALSE( bottle.empty() );
    CHECK( bottle.legacy_front().charges == 20 );
    const std::string received = capture_rng_state();
    fixture.run( who, collect );
    CHECK( bottle.legacy_front().charges == 20 );
    CHECK( capture_rng_state() == received );
}


TEST_CASE( "owned_workpiece_cannot_be_claimed_by_two_active_players",
           "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    avatar &other = get_avatar();
    other.setpos( get_map(), who.pos_bub() + tripoint::east );
    const recipe_id &recipe = recipe_cudgel_test_charged_fast_stepless;
    item prepared( &recipe.obj(), 1, item_components{}, {}, false );
    prepared.item_counter = 10000000;
    item_location workpiece = get_map().add_item_or_charges_ret_loc( who.pos_bub(), prepared );
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    other.assign_activity( craft_activity_actor( workpiece, false, &other ) );
    CHECK_FALSE( other.activity );
    CHECK( workpiece->get_crafter_id() == who.getID() );
    CHECK( cata_mp::owns_inventory_activity( who ) );
}

TEST_CASE( "owned_craft_start_resume_and_repeat_consume_each_selection_once",
           "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    set_time( calendar::turn_zero + 12_hours );
    const recipe_id &recipe = recipe_cudgel_test_charged_fast_stepless;
    who.learn_recipe( &recipe.obj() );
    who.set_skill_level( recipe->skill_used, recipe->difficulty );
    who.set_knowledge_level( recipe->skill_used, recipe->difficulty );
    for( const auto &skill : recipe->required_skills ) {
        who.set_skill_level( skill.first, skill.second );
        who.set_knowledge_level( skill.first, skill.second );
    }
    map &here = get_map();
    item_location material = here.add_item_or_charges_ret_loc( who.pos_bub(),
                             item( itype_2x4 ) );
    item_location tool = here.add_item_or_charges_ret_loc( who.pos_bub(),
                         tool_with_ammo( itype_soldering_iron_portable, 100 ) );
    who.invalidate_crafting_inventory();
    craft_command selected( &recipe.obj(), 1, true, &who, who.pos_bub() );
    REQUIRE( selected.prepare() );
    REQUIRE( selected.prepare_owned_start() );
    REQUIRE( material );
    const int initial_ammo = tool->ammo_remaining();
    const std::string start = fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "craft" );
        out.member( "selection" );
        selected.serialize_selection( out );
    } );
    fixture.run( who, start );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    REQUIRE( who.activity.targets.size() == 1 );
    item_location workpiece = who.activity.targets.front();
    REQUIRE( workpiece );
    CHECK_FALSE( material );
    CHECK( tool->ammo_remaining() < initial_ammo );
    const int paid_ammo = tool->ammo_remaining();
    const int paid_buckets = workpiece->get_step_tool_allocs().front().front().consumed_buckets;
    fixture.run( who, start );
    CHECK( who.activity.targets.front() == workpiece );
    CHECK( tool->ammo_remaining() == paid_ammo );

    SECTION( "resume_requires_the_owner_plan_and_keeps_paid_tools" ) {
        fixture.run( who, fixture.request( who, "cancel" ) );
        REQUIRE_FALSE( who.activity );
        REQUIRE( workpiece );
        const int progress = workpiece->item_counter;
        who.set_moves( 1000 );
        const std::string resume = fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", "craft_resume" );
            out.member( "source", capture_item_source( who, workpiece ) );
        } );
        fixture.run( who, resume );
        REQUIRE( cata_mp::owns_inventory_activity( who ) );
        workpiece = who.get_wielded_item();
        REQUIRE( workpiece );
        auto *actor = dynamic_cast<craft_activity_actor *>( who.activity.actor.get() );
        REQUIRE( actor );
        REQUIRE( actor->waiting_for() == "resume" );
        save_reload_activity( who );
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK( workpiece->item_counter == progress );
        CHECK( who.get_moves() == 100 );
        auto plan = craft_resume_selection::prepare( who, *workpiece );
        REQUIRE( plan );
        const std::string choose = fixture.request( who, "choose", [&]( JsonOut & out ) {
            out.member( "decision", "resume" );
            out.member( "selection", *plan );
            out.member( "plans" );
            write_craft_plans( out, workpiece->get_step_plans() );
        } );
        fixture.run( who, choose );
        actor = dynamic_cast<craft_activity_actor *>( who.activity.actor.get() );
        REQUIRE( actor );
        CHECK( actor->waiting_for().empty() );
        CHECK( tool->ammo_remaining() == paid_ammo );
        CHECK( workpiece->get_step_tool_allocs().front().front().consumed_buckets == paid_buckets );
        fixture.run( who, choose );
        CHECK( tool->ammo_remaining() == paid_ammo );
        CHECK( workpiece->item_counter == progress );
    }

    SECTION( "long_craft_restarts_once_with_fresh_materials" ) {
        // Existing progress tests cover ticking; exercise completion and the next
        // command here without a long crafting loop or generated material supply.
        workpiece->item_counter = 10000000;
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        auto *actor = dynamic_cast<craft_activity_actor *>( who.activity.actor.get() );
        REQUIRE( actor );
        REQUIRE( actor->waiting_for() == "repeat" );
        CHECK_FALSE( workpiece );
        item_location next_material = here.add_item_or_charges_ret_loc( who.pos_bub(),
                                      item( itype_2x4 ) );
        who.invalidate_crafting_inventory();
        craft_command next( &recipe.obj(), 1, true, &who, who.pos_bub() );
        REQUIRE( next.prepare() );
        REQUIRE( next.prepare_owned_start() );
        const std::uint64_t previous = who.activity.identity_generation();
        const std::string restart = fixture.request( who, "restart", [&]( JsonOut & out ) {
            out.member( "selection" );
            next.serialize_selection( out );
        } );
        who.set_moves( 100 );
        fixture.run( who, restart );
        REQUIRE( cata_mp::owns_inventory_activity( who ) );
        CHECK( who.activity.identity_generation() != previous );
        REQUIRE( who.activity.targets.size() == 1 );
        workpiece = who.activity.targets.front();
        REQUIRE( workpiece );
        CHECK( workpiece->item_counter == 0 );
        CHECK_FALSE( next_material );
        const int after_restart = tool->ammo_remaining();
        fixture.run( who, restart );
        CHECK( who.activity.targets.front() == workpiece );
        CHECK( tool->ammo_remaining() == after_restart );
    }
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_craft_keeps_component_liquid_until_its_owner_selects_a_container",
           "[multiplayer][craft_owned][liquid]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const recipe_id &recipe = recipe_cudgel_test_charged_fast_stepless;
    item container( itype_bottle_plastic );
    item fuel( itype_gasoline, calendar::turn, 20 );
    REQUIRE( container.fill_with( fuel, 20 ) == 20 );
    item_components components;
    components.add( container );
    who.set_wielded_item( item( &recipe.obj(), 1, components, {}, false ) );
    item_location workpiece = who.get_wielded_item();
    workpiece->get_craft_results().components_pending = true;
    who.assign_activity( craft_activity_actor( workpiece, false, &who ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    const auto *actor = dynamic_cast<const craft_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    CHECK( actor->waiting_for() == "components" );
    save_reload_activity( who );
    fixture.run( who, fixture.request( who, "results", [&]( JsonOut & out ) {
        out.member( "liquids", std::vector<unload_liquid_choice> {} );
    } ) );
    REQUIRE( craft_has_pending_components( *workpiece ) );
    item &remaining = workpiece->components.begin()->second.front().legacy_front();
    CHECK( remaining.charges == 20 );
    CHECK( workpiece->item_counter == 0 );
    item_location destination = get_map().add_item_or_charges_ret_loc( who.pos_bub(),
                                item( itype_bottle_plastic ) );
    unload_liquid_choice choice;
    choice.source = remaining.uid().get_value();
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, destination );
    const std::string pour = fixture.request( who, "results", [&]( JsonOut & out ) {
        out.member( "liquids", std::vector<unload_liquid_choice> { choice } );
    } );
    who.set_moves( 100 );
    fixture.run( who, pour );
    CHECK_FALSE( craft_has_pending_components( *workpiece ) );
    REQUIRE_FALSE( destination->empty() );
    CHECK( destination->legacy_front().charges == 20 );
    fixture.run( who, pour );
    CHECK( destination->legacy_front().charges == 20 );
    fixture.run( who, fixture.request( who, "cancel" ) );
    REQUIRE( workpiece );
    CHECK( workpiece->components.size() == 1 );
}

TEST_CASE( "craft_timers_notify_only_the_owning_player", "[multiplayer][craft_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    cata_mp::world_session &session = g->multiplayer_session();
    const cata_mp::player_id owner( std::string( 32, '7' ) );
    who.set_value( "mp_player_id", owner.str() );
    auto peer = std::make_unique<cata_mp::remote_player_session>();
    peer->actor.bind_player( who, owner, g->npc_lifetimes(),
                             g->player_controls().claim( owner, who ) );
    peer->connected = true;
    session.remote_players.emplace( 7, std::move( peer ) );
    cata_mp::inventory_activity_host_state &notices = session.remote_players.at(
                7 )->inventory_activity;
    cata_mp::notify_craft_owner( who.getID(), "timer", true );
    cata_mp::notify_craft_owner( get_avatar().getID(), "host only" );
    REQUIRE( notices.notices.size() == 1 );
    CHECK( notices.notices.front().alarm );
    const std::string encoded = cata_mp::take_craft_notifications( notices );
    CHECK( notices.notices.empty() );
    const JsonValue value = json_loader::from_string( "{\"craft_notices\":" + encoded + "}" );
    cata_mp::apply_craft_notifications( value.get_object() );
    const auto &received = session.client_inventory_activity.notices;
    REQUIRE( received.size() == 1 );
    CHECK( received.front().message == "timer" );
    CHECK( received.front().alarm );
    CHECK( cata_mp::take_craft_notifications( notices ) == "[]" );
}

TEST_CASE( "owned_construction_start_and_completion_apply_once",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    set_time( calendar::turn_zero + 12_hours );
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.ter_set( target, ter_t_dirt );
    const construction_str_id &id = construction_constr_wall_half;
    for( const auto &[skill, level] : id->required_skills ) {
        who.set_skill_level( skill, level );
        who.set_knowledge_level( skill, level );
    }
    for( int i = 0; i < 10; ++i ) {
        here.add_item_or_charges( who.pos_bub(), item( itype_2x4 ) );
    }
    here.add_item_or_charges( who.pos_bub(), item( itype_nail, calendar::turn, 20 ) );
    here.add_item_or_charges( who.pos_bub(), item( itype_hammer ) );
    who.invalidate_crafting_inventory();
    auto selected = construction_selection::prepare( who, id.obj(), here.get_abs( target ) );
    REQUIRE( selected );
    CHECK_FALSE( here.partial_con_at( target ) );

    SECTION( "invalid_material_quantity_does_not_start_or_consume" ) {
        REQUIRE_FALSE( selected->components.empty() );
        selected->components.front().comp.count = 1;
        fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", "construction" );
            out.member( "selection", *selected );
        } ) );
        CHECK_FALSE( here.partial_con_at( target ) );
        CHECK_FALSE( who.activity );
        int boards = 0;
        for( const item &it : here.i_at( who.pos_bub() ) ) {
            if( it.typeId() == itype_2x4 ) {
                boards += it.count();
            }
        }
        CHECK( boards == 10 );
    }
    SECTION( "automatic_blueprint_selects_materials_on_the_server" ) {
        map_stack ground = here.i_at( who.pos_bub() );
        const auto boards = std::find_if( ground.begin(), ground.end(), []( const item & it ) {
            return it.typeId() == itype_2x4;
        } );
        REQUIRE( boards != ground.end() );
        REQUIRE( boards->count_by_charges() );
        REQUIRE( boards->charges == 10 );
        item carried = *boards;
        carried.charges = 5;
        boards->mod_charges( -5 );
        who.i_add( carried );
        REQUIRE( who.charges_of( itype_2x4 ) == 5 );
        who.invalidate_crafting_inventory();
        // i_add may wield the boards and spend the setup character's moves.
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", "construction_auto" );
            out.member( "construction", id );
            out.member( "position", here.get_abs( target ) );
        } ) );
        REQUIRE( cata_mp::owns_inventory_activity( who ) );
        REQUIRE( here.partial_con_at( target ) );
        int consumed_boards = 0;
        for( const item &it : here.partial_con_at( target )->components ) {
            if( it.typeId() == itype_2x4 ) {
                consumed_boards += it.count();
            }
        }
        CHECK( consumed_boards == 10 );
        CHECK( who.amount_of( itype_2x4 ) == 0 );
    }
    SECTION( "zone_construction_preserves_its_parent_instead_of_an_id_only_duplicate" ) {
        const tripoint_abs_ms origin = who.pos_abs();
        who.assign_activity( multi_build_construction_activity_actor() );
        who.activity.set_execution( activity_execution::authoritative );
        auto *planner = dynamic_cast<multi_build_construction_activity_actor *>( who.activity.actor.get() );
        REQUIRE( planner );
        const activity_reason_info reason = activity_reason_info::build(
                                                do_activity_reason::CAN_DO_CONSTRUCTION,
                                                true, id.id() );
        REQUIRE_FALSE( planner->multi_activity_do( who, reason, here.get_abs( target ), target ) );
        REQUIRE( here.partial_con_at( target ) );
        REQUIRE( who.backlog.size() == 1 );
        const auto *parent = dynamic_cast<const multi_build_construction_activity_actor *>(
                                 who.backlog.front().actor.get() );
        REQUIRE( parent );
        CHECK( parent->query_for( who ).origin == origin );
        auto *building = dynamic_cast<build_construction_activity_actor *>( who.activity.actor.get() );
        REQUIRE( building );
        CHECK( building->is_server_owned() );
        CHECK( active_zone_query( who ).origin == origin );
        CHECK( who.activity.execution() == activity_execution::authoritative );
        int boards = 0;
        for( const item &it : here.partial_con_at( target )->components ) {
            if( it.typeId() == itype_2x4 ) {
                boards += it.count();
            }
        }
        CHECK( boards == 10 );
    }
    SECTION( "start_reload_progress_and_finish" ) {
        const std::string start = fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", "construction" );
            out.member( "selection", *selected );
        } );
        fixture.run( who, start );
        REQUIRE( cata_mp::owns_inventory_activity( who ) );
        partial_con *site = here.partial_con_at( target );
        REQUIRE( site );
        const int64_t uid = site->uid;
        REQUIRE( uid > 0 );
        const std::string::size_type components = site->components.size();
        REQUIRE( components > 0 );
        fixture.run( who, start );
        CHECK( site->uid == uid );
        CHECK( site->components.size() == components );
        save_reload_activity( who );
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        REQUIRE( site->counter > 0 );
        site->counter = 9999999;
        who.set_moves( 100 );
        const std::string finish = fixture.request( who, "step" );
        fixture.run( who, finish );
        CHECK_FALSE( here.partial_con_at( target ) );
        CHECK_FALSE( who.activity );
        CHECK( here.ter( target ) == ter_t_wall_half );
        const std::string rng = capture_rng_state();
        fixture.run( who, finish );
        CHECK( capture_rng_state() == rng );
        CHECK( here.ter( target ) == ter_t_wall_half );
        CHECK_FALSE( get_avatar().activity );
    }
}

TEST_CASE( "owned_construction_rejects_replaced_sites_and_refunds_only_once",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    set_time( calendar::turn_zero + 12_hours );
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    const construction_str_id &id = construction_constr_wall_half;
    for( const auto &[skill, level] : id->required_skills ) {
        who.set_skill_level( skill, level );
    }
    partial_con original;
    original.id = id.id();
    original.components.emplace_back( itype_2x4 );
    here.partial_con_set( target, original );
    const int64_t old_uid = here.partial_con_at( target )->uid;
    auto change = [&]( const std::string & kind, int64_t uid ) {
        return fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", kind );
            out.member( "position", here.get_abs( target ) );
            out.member( "site", uid );
        } );
    };
    fixture.run( who, change( "construction_resume", old_uid ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    save_reload_activity( who );
    here.partial_con_remove( target );
    here.partial_con_set( target, original );
    const int64_t replacement = here.partial_con_at( target )->uid;
    REQUIRE( replacement != old_uid );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( here.partial_con_at( target )->counter == 0 );
    fixture.run( who, change( "construction_cancel", old_uid ) );
    REQUIRE( here.partial_con_at( target ) );
    const std::string cancel = change( "construction_cancel", replacement );
    fixture.run( who, cancel );
    CHECK_FALSE( here.partial_con_at( target ) );
    const auto count = [&]() {
        const map_stack items = here.i_at( who.pos_bub() );
        return std::count_if( items.begin(), items.end(),
        []( const item & it ) {
            return it.typeId() == itype_2x4;
        } );
    };
    CHECK( count() == 1 );
    fixture.run( who, cancel );
    CHECK( count() == 1 );
}

TEST_CASE( "owned_vehicle_construction_waits_for_its_players_name",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    set_time( calendar::turn_zero + 12_hours );
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    partial_con site;
    site.id = construction_constr_veh.id();
    site.counter = 10000000;
    site.components.emplace_back( itype_frame );
    here.partial_con_set( target, site );
    who.assign_activity( build_construction_activity_actor( here.get_abs( target ), &who ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    const auto *actor = dynamic_cast<const build_construction_activity_actor *>
                        ( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for() == "vehicle_name" );
    save_reload_activity( who );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( here.veh_at( target ) );
    CHECK( who.get_moves() == 100 );
    fixture.run( who, fixture.request( who, "choose", [&]( JsonOut & out ) {
        out.member( "decision", "vehicle_name" );
        out.member( "text", "Remote workshop" );
    } ) );
    save_reload_activity( who );
    const std::string finish = fixture.request( who, "step" );
    fixture.run( who, finish );
    REQUIRE( here.veh_at( target ) );
    CHECK( here.veh_at( target )->vehicle().name == "Remote workshop" );
    CHECK_FALSE( here.partial_con_at( target ) );
    CHECK_FALSE( who.activity );
    const std::string rng = capture_rng_state();
    fixture.run( who, finish );
    CHECK( capture_rng_state() == rng );
    CHECK( here.veh_at( target )->vehicle().name == "Remote workshop" );
}

TEST_CASE( "construction_site_save_preserves_identity_and_loads_legacy_layout",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    submap original;
    original.set_all_ter( ter_t_dirt );
    // Two legacy entries exercise the optional metadata delimiter between sites.
    const JsonValue legacy = json_loader::from_string(
                                 R"([0,1,0,5000000,"constr_pit_shallow",[],2,3,0,0,"constr_wall_half",[]])" );
    original.load( legacy, "partial_constructions", 0 );
    REQUIRE( original.partial_constructions.size() == 2 );
    const tripoint_sm_ms first( 0, 1, 0 );
    const tripoint_sm_ms second( 2, 3, 0 );
    const int64_t first_uid = original.partial_constructions.at( first ).uid;
    const int64_t second_uid = original.partial_constructions.at( second ).uid;
    REQUIRE( first_uid > 0 );
    REQUIRE( second_uid > first_uid );
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    original.store( out );
    out.end_object();
    JsonValue saved = json_loader::from_string( stream.str() );
    const JsonObject object = saved.get_object();
    object.allow_omitted_members();
    submap restored;
    restored.load( object.get_member( "partial_constructions" ), "partial_constructions", 0 );
    REQUIRE( restored.partial_constructions.size() == 2 );
    CHECK( restored.partial_constructions.at( first ).uid == first_uid );
    CHECK( restored.partial_constructions.at( second ).uid == second_uid );
    CHECK( restored.partial_constructions.at( first ).counter == 5000000 );
    CHECK( g->assign_construction_uid() > second_uid );
}

TEST_CASE( "blueprint_client_only_requests_work_and_preserves_its_planner",
           "[multiplayer][construction_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    who.assign_activity( multi_build_construction_activity_actor() );
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    map &here = get_map();
    const tripoint_abs_ms target = who.pos_abs() + tripoint::east;
    REQUIRE( cata_mp::client_start_blueprint_construction(
                 construction_constr_wall_half, target ) );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK_FALSE( here.partial_con_at( here.get_bub( target ) ) );
    REQUIRE_FALSE( who.backlog.empty() );
    CHECK( who.backlog.front().id() == ACT_MULTIPLE_CONSTRUCTION );
    CHECK( who.backlog.front().auto_resume );
    partial_con replica;
    replica.id = construction_constr_wall_half.id();
    here.partial_con_set( here.get_bub( target ), replica );
    const std::string upload = cata_mp::client_enrich_action( R"({"action":"wait"})" );
    CHECK( upload.find( "partial_con" ) == std::string::npos );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.pending_request = 0;
    view.finished = true;
    SECTION( "accepted_work_resumes_the_blueprint_planner" ) {
        view.activity = "42";
        cata_mp::client_update_inventory_activity_view();
        CHECK( who.activity.id() == ACT_MULTIPLE_CONSTRUCTION );
        CHECK( who.backlog.empty() );
        CHECK_FALSE( view.active );
    }
    SECTION( "rejected_start_does_not_repeat_automatically" ) {
        cata_mp::client_update_inventory_activity_view();
        CHECK_FALSE( who.activity );
        REQUIRE_FALSE( who.backlog.empty() );
        CHECK_FALSE( who.backlog.front().auto_resume );
        CHECK_FALSE( view.active );
    }
    SECTION( "declined_work_does_not_restart_the_planner" ) {
        view.activity = "42";
        who.backlog.front().auto_resume = false;
        cata_mp::client_update_inventory_activity_view();
        CHECK_FALSE( who.activity );
        CHECK_FALSE( view.active );
    }

}

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <filesystem>
#include <variant>

#include "cata_path.h"
#include "inventory.h"
#include "lua_platform_runtime_internal.h"
#include "path_info.h"
#include "worldfactory.h"

TEST_CASE( "mp_item_activation_keeps_character_state_and_delayed_work_owned",
           "[mp_inventory_activity][mp_item_activation][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    reload_fixture fixture;
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const platform_lua_test_directory directory;
    const std::string old_savedir = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "item_activation_ownership" );
    const on_out_of_scope cleanup( [&]() {
        platform::shutdown();
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
    } );
    PATH_INFO::set_savedir( directory.root.string() + "/" );
    world_generator->active_world = &isolated_world;
    REQUIRE( std::filesystem::create_directory( isolated_world.folder_path().get_unrelative_path() ) );
    directory.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
local state = ccb.state.character
ccb.runtime.handler("start", function(event)
    if event.data.activity == "ACT_TEST_OWNED_ITEM" then
        state.set("starts", state.get("starts", 0) + 1)
    end
end)
ccb.runtime.on("game:character_starts_activity", "start")
ccb.runtime.handler("turn", function(event)
    state.set("turns", state.get("turns", 0) + 1)
end)
ccb.runtime.handler("finish", function(event)
    state.set("finished", state.get("finished", 0) + 1)
end)
ccb.runtime.handler("later", function(event)
    state.set("later", state.get("later", 0) + 1)
end)
ccb.runtime.handler("activate", function(context)
    if state.get("uses", 0) > 0 then return 0 end
    local consumed = ccb.services.inventory.consume_by_type(context.character,
        ccb.services.types.id("item", "apple"), 1, 0)
    assert(consumed.ok and consumed.value.matched)
    state.set("uses", 1)
    if previous_task then
        assert(ccb.tasks.get(previous_task) == nil)
        assert(not ccb.tasks.cancel(previous_task))
    end
    previous_task = ccb.tasks.after(3, "later", {}, 1, "character")
    assert(ccb.tasks.list(nil, "character").total == 1)
    local assigned = ccb.services.activities.assign_timed(context.character,
        ccb.services.types.id("activity", "ACT_TEST_OWNED_ITEM"),
        ccb.services.time.duration(2, "second"))
    assert(assigned.ok)
    return 0
end)
local activity = ccb.content.ActivityType {
    id = "ACT_TEST_OWNED_ITEM", verb = "using an owned tool", based_on = "time"
}
activity:on_turn("turn")
activity:on_finish("finish")
ccb.content.add(activity)
local tool = ccb.content.Item {
    id = "test_owned_lua_tool", name = "owned tool", description = "ownership regression", symbol = "?"
}
tool:mass_grams(1)
tool:volume_ml(1)
tool:on_use("activate", "Activate")
ccb.content.add(tool)
)lua" );
    const std::string mod = "item_activation_ownership";
    std::string error;
    const bool prepared = platform::prepare_mods(
    { { mod, directory.root, directory.root / std::filesystem::u8path( "main.lua" ) } }, error );
    INFO( error );
    REQUIRE( prepared );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    const auto runtime = platform::detail::find_active_runtime( mod );
    REQUIRE( runtime );
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    player_control controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '8' ) ), remote );
    const itype_id &tool = itype_test_owned_lua_tool;
    const itype_id &apple = itype_apple;
    for( Character *actor : { static_cast<Character *>( &host ), static_cast<Character *>( &remote ) } ) {
        actor->lua_character_state = {};
        actor->set_wielded_item( item( tool ) );
        actor->inv->add_item( item( apple ), false, false, false );
        actor->inv->add_item( item( apple ), false, false, false );
        actor->set_moves( 1000 );
    }
    const auto value = [&]( Character &who, const std::string &key ) {
        const cata::lua_platform::script_persistent_state &state = who.lua_character_state.for_mod( mod );
        const auto found = state.find( key );
        return found == state.end() ? int64_t( 0 ) : std::get<int64_t>( found->second );
    };
    const std::string method = "lua_platform:" + mod + ":activate";
    const auto use_request = [&]( const item_source &source ) {
        return fixture.request( remote, "start", [&]( JsonOut &out ) {
            out.member( "kind", "item_use" );
            out.member( "source", source );
            out.member( "item_type", tool );
            out.member( "method", method );
            out.member( "target", remote.pos_abs() );
        } );
    };
    // An item UID in another player's inventory is not an activation grant.
    fixture.run( remote, use_request( capture_item_source( host, host.get_wielded_item() ) ) );
    CHECK( value( host, "uses" ) == 0 );
    CHECK( value( remote, "uses" ) == 0 );
    CHECK( remote.amount_of( apple ) == 2 );
    const std::string denied = use_request( capture_item_source( remote, remote.get_wielded_item() ) );
    fixture.run( remote, denied, false );
    CHECK_FALSE( remote.activity );
    // Even a rejection returns a new inventory revision. Reusing that stale
    // request must still be rejected before a fresh authorized intent starts.
    fixture.run( remote, denied );
    CHECK_FALSE( remote.activity );
    const std::string request = use_request( capture_item_source( remote, remote.get_wielded_item() ) );
    fixture.run( remote, request );
    REQUIRE( remote.activity );
    CHECK( remote.activity.execution() == activity_execution::authoritative );
    CHECK( value( remote, "uses" ) == 1 );
    CHECK( value( remote, "starts" ) == 1 );
    CHECK( value( host, "uses" ) == 0 );
    CHECK( remote.amount_of( apple ) == 1 );
    fixture.run( remote, request );
    CHECK( remote.amount_of( apple ) == 1 );
    CHECK( value( remote, "starts" ) == 1 );

    REQUIRE( execute_owned_item_activation( host, host.get_wielded_item(), method,
                                            host.pos_abs(), false, false ) );
    CHECK( value( host, "uses" ) == 1 );
    CHECK( value( host, "starts" ) == 1 );
    CHECK( host.amount_of( apple ) == 1 );
    REQUIRE( runtime->tasks.size() == 2 );
    CHECK( runtime->tasks.front().state_character_id == remote.getID() );
    CHECK( runtime->tasks.back().state_character_id == host.getID() );

    // Native save data owns the state and activity. The task sidecar owns the
    // pending callback identity; neither may silently rebind to the host.
    std::ostringstream saved_actor;
    JsonOut actor_json( saved_actor );
    remote.serialize( actor_json );
    npc loaded;
    loaded.deserialize( json_loader::from_string( saved_actor.str() ).get_object() );
    CHECK( value( loaded, "uses" ) == 1 );
    CHECK( loaded.activity.execution() == activity_execution::authoritative );
    REQUIRE( platform::runtime_save( error ) );
    runtime->tasks.clear();
    platform::runtime_world_ready( false );
    REQUIRE( runtime->tasks.size() == 2 );
    calendar::turn += 3_seconds;
    platform::runtime_process_tasks();
    CHECK( value( remote, "later" ) == 1 );
    CHECK( value( host, "later" ) == 1 );
    CHECK( runtime->tasks.empty() );

    fixture.reload = {}; // Reconnect reconstructs tracking from saved activity ownership.
    for( int turn = 0; turn < 2; ++turn ) {
        remote.set_moves( 1000 );
        host.set_moves( 1000 );
        fixture.run( remote, fixture.request( remote, "step" ) );
        host.activity.do_turn( host );
        CHECK( remote.activity.moves_left == host.activity.moves_left );
        CHECK( remote.get_moves() == host.get_moves() );
        CHECK( value( remote, "finished" ) == turn );
        CHECK( value( host, "finished" ) == turn );
    }
    CHECK_FALSE( remote.activity );
    CHECK_FALSE( host.activity );
    CHECK( value( host, "finished" ) == 1 );
    CHECK( value( remote, "finished" ) == 1 );

    // A client progress view must not run the Lua activity a second time.
    const int64_t host_starts = value( host, "starts" );
    const int64_t host_turns = value( host, "turns" );
    player_activity view( ACT_TEST_OWNED_ITEM, 100 );
    view.set_execution( activity_execution::presentation );
    host.assign_activity( view );
    host.activity.do_turn( host );
    CHECK( value( host, "starts" ) == host_starts );
    CHECK( value( host, "turns" ) == host_turns );
    CHECK( value( host, "finished" ) == 1 );
    host.assign_activity( view );
    host.cancel_activity();
    CHECK( g->multiplayer_session().client_inventory_activity.cancel_requested );
    CHECK( value( host, "starts" ) == host_starts );

    // Native state wins over stale sidecar values, including deliberate deletion.
    host.lua_character_state.for_mod( mod ).clear();
    host.lua_character_state.migrate_legacy( mod, { { "uses", int64_t( 99 ) } } );
    CHECK( value( host, "uses" ) == 0 );
    CHECK( value( remote, "uses" ) == 1 );
    sol::table ccb = ( *runtime->lua )["package"]["loaded"]["ccb"];
    const sol::protected_function get_state = ccb["state"]["character"]["get"];
    {
        platform::detail::callback_scope actor_scope( *runtime, &remote );
        platform::detail::callback_scope nested_actorless( *runtime, nullptr );
        const sol::protected_function_result inherited = get_state( "uses", 0 );
        REQUIRE( inherited.valid() );
        CHECK( inherited.get<int>() == 1 );
        g->remove_npc( remote.getID() );
        // A stale explicit actor must never fall back to the host's state.
        const sol::protected_function_result expired = get_state( "uses", 0 );
        CHECK_FALSE( expired.valid() );
    }
    CHECK( value( host, "uses" ) == 0 );
}
#endif

TEST_CASE( "mp_native_item_activation_transforms_once", "[mp_inventory_activity][mp_item_activation]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_grenade ) );
    remote.set_moves( 1000 );
    const item_source source = capture_item_source( remote, remote.get_wielded_item() );
    const std::string request = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", source );
        out.member( "item_type", "grenade" );
        out.member( "method", "transform" );
        out.member( "target", remote.pos_abs() );
    } );
    fixture.run( remote, request );
    REQUIRE( remote.get_wielded_item() );
    CHECK( remote.get_wielded_item()->typeId() == itype_grenade_act );
    const int moves = remote.get_moves();
    const time_point countdown = remote.get_wielded_item()->countdown_point;
    fixture.run( remote, request );
    CHECK( remote.get_moves() == moves );
    CHECK( remote.get_wielded_item()->countdown_point == countdown );
    CHECK_FALSE( remote.activity );
}


TEST_CASE( "mp_item_activation_timer_uses_player_choice_once",
           "[mp_inventory_activity][mp_item_activation]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    host.set_moves( 1000 );
    host.set_wielded_item( item( itype_c4 ) );
    remote.set_moves( 1000 );
    remote.set_wielded_item( item( itype_c4 ) );
    const item_source source = capture_item_source( remote, remote.get_wielded_item() );
    const std::string request = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", source );
        out.member( "item_type", "c4" );
        out.member( "method", "transform" );
        out.member( "target", remote.pos_abs() );
        out.member( "timer_seconds", 37 );
    } );
    const std::string before_rng = capture_rng_state();
    fixture.run( remote, request );
    const std::string after_rng = capture_rng_state();
    REQUIRE( remote.get_wielded_item() );
    CHECK( remote.get_wielded_item()->typeId() == itype_c4armed );
    CHECK( remote.get_wielded_item()->countdown_point == calendar::turn + 37_seconds );
    const int moves = remote.get_moves();
    fixture.run( remote, request );
    CHECK( remote.get_moves() == moves );
    CHECK( remote.get_wielded_item()->countdown_point == calendar::turn + 37_seconds );
    CHECK( capture_rng_state() == after_rng );

    // The same explicit choice follows the same native operation on the host.
    restore_rng_state( before_rng );
    item_activation_choices choices;
    choices.timer_seconds = 37;
    REQUIRE( execute_owned_item_activation( host, host.get_wielded_item(), "transform",
                                            host.pos_abs(), false, false, choices ) );
    CHECK( host.get_wielded_item()->typeId() == remote.get_wielded_item()->typeId() );
    CHECK( host.get_wielded_item()->countdown_point == remote.get_wielded_item()->countdown_point );
    CHECK( host.get_moves() == moves );
    CHECK( capture_rng_state() == after_rng );

    // Timer is native item state and survives the normal save format.
    std::ostringstream saved;
    JsonOut out( saved );
    remote.get_wielded_item()->serialize( out );
    item restored;
    JsonValue value = json_loader::from_string( saved.str() );
    restored.deserialize( value.get_object() );
    CHECK( restored.typeId() == itype_c4armed );
    CHECK( restored.countdown_point == calendar::turn + 37_seconds );
}

TEST_CASE( "mp_item_activation_rejects_invalid_choices_before_effects",
           "[mp_inventory_activity][mp_item_activation]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    restore_on_out_of_scope restore_turn( calendar::turn );
    calendar::turn = calendar::turn_zero + 1_days;
    remote.set_moves( 1000 );
    remote.set_wielded_item( item( itype_c4 ) );
    const item_source source = capture_item_source( remote, remote.get_wielded_item() );
    const std::string before_rng = capture_rng_state();
    for( const std::optional<int> seconds : { std::optional<int>(), std::optional<int>( 0 ),
            std::optional<int>( -1 ), std::optional<int>( std::numeric_limits<int>::max() ) } ) {
        const std::string request = fixture.request( remote, "start", [&]( JsonOut &out ) {
            out.member( "kind", "item_use" );
            out.member( "source", source );
            out.member( "item_type", "c4" );
            out.member( "method", "transform" );
            out.member( "target", remote.pos_abs() );
            if( seconds ) {
                out.member( "timer_seconds", *seconds );
            }
        } );
        const std::string result = fixture.run( remote, request );
        JsonValue value = json_loader::from_string( result );
        JsonObject response = value.get_object();
        response.allow_omitted_members();
        CHECK( response.get_string( "activity" ).empty() );
        CHECK( remote.get_moves() == 1000 );
        CHECK( remote.get_wielded_item()->typeId() == itype_c4 );
        CHECK( capture_rng_state() == before_rng );
    }
    // A stale or malicious choice cannot retime a fixed-fuse transformation.
    remote.set_wielded_item( item( itype_grenade ) );
    item_activation_choices choices;
    choices.timer_seconds = 90;
    CHECK_FALSE( execute_owned_item_activation( remote, remote.get_wielded_item(), "transform",
                 remote.pos_abs(), false, false, choices ) );
    CHECK( remote.get_wielded_item()->typeId() == itype_grenade );
    CHECK( remote.get_moves() == 1000 );
    CHECK( capture_rng_state() == before_rng );
}

TEST_CASE( "item_activation_choices_preserve_delayed_readiness_and_npc_defaults",
           "[mp_item_activation]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    restore_on_out_of_scope restore_turn( calendar::turn );
    calendar::turn = calendar::turn_zero + 1_days;
    delayed_transform_iuse action;
    action.transform.target = itype_c4armed;
    action.set_timer = true;
    action.transform_age = 100;
    item explosive( itype_c4, calendar::turn );
    item_activation_choices choices;
    choices.timer_seconds = 23;
    CHECK_FALSE( action.use_with_choices( &remote, explosive, &get_map(), remote.pos_bub(), choices ) );
    CHECK( explosive.typeId() == itype_c4 );
    explosive.set_age( 100_seconds );
    REQUIRE( action.time_to_do( explosive ) == 0 );
    REQUIRE( action.use_with_choices( &remote, explosive, &get_map(), remote.pos_bub(), choices ) );
    CHECK( explosive.typeId() == itype_c4armed );
    CHECK( explosive.countdown_point == calendar::turn + 23_seconds );

    // An ordinary NPC call, with no player choice channel, keeps the type's fuse.
    item automatic( itype_c4 );
    iuse_transform normal;
    normal.transform.target = itype_c4armed;
    normal.set_timer = true;
    REQUIRE( normal.use( &remote, automatic, &get_map(), remote.pos_bub() ) );
    CHECK( automatic.typeId() == itype_c4armed );
    CHECK( automatic.countdown_point == calendar::turn + 6_seconds );
}


TEST_CASE( "mp_adjacent_tools_complete_once_and_cancel_competing_work",
           "[mp_inventory_activity][mp_adjacent_tool]" )
{
    const std::string method = GENERATE( "CROWBAR", "PICKAXE", "JACKHAMMER", "PICK_LOCK" );
    CAPTURE( method );
    reload_fixture fixture;
    map &here = get_map();
    npc &remote = fixture.remote();
    player_control controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 62, 60, 0 ) );
    const tripoint_bub_ms target( 61, 60, 0 );
    const ter_id original = ter_str_id( method == "CROWBAR" ? "test_t_prying1" :
                                        method == "PICK_LOCK" ? "t_door_locked" : "t_rock" ).id();
    here.ter_set( target, original );
    const itype_id tool_id( method == "CROWBAR" ? "test_halligan" :
                            method == "PICKAXE" ? "pickaxe" :
                            method == "JACKHAMMER" ? "jackhammer_mining" : "test_sonic_screwdriver" );
    for( Character *who : { static_cast<Character *>( &host ), static_cast<Character *>( &remote ) } ) {
        item tool( tool_id );
        if( method == "JACKHAMMER" ) {
            tool.ammo_set( itype_gasoline, 1200 );
        }
        who->set_wielded_item( tool );
        who->set_moves( 1000 );
    }
    const std::string start = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( remote, remote.get_wielded_item() ) );
        out.member( "item_type", tool_id );
        out.member( "method", method );
        out.member( "target", here.get_abs( target ) );
    } );
    fixture.run( remote, start );
    REQUIRE( remote.activity );
    CHECK( remote.activity.execution() == activity_execution::authoritative );
    CHECK( remote.activity.moves_total > 0 );
    const int work = remote.activity.moves_left;
    fixture.run( remote, start );
    CHECK( remote.activity.moves_left == work );
    save_reload_activity( remote );
    CHECK( remote.activity.execution() == activity_execution::authoritative );

    REQUIRE( execute_owned_item_activation( host, host.get_wielded_item(), method,
                                            here.get_abs( target ), false, false ) );
    REQUIRE( host.activity );
    const int host_ammo = host.get_wielded_item()->ammo_remaining();
    remote.activity.moves_left = 1;
    remote.set_moves( 100 );
    const std::string finish = fixture.request( remote, "step" );
    fixture.run( remote, finish );
    CHECK_FALSE( remote.activity );
    CHECK( here.ter( target ) != original );
    if( method == "PICK_LOCK" ) {
        CHECK( remote.get_skill_level_object( skill_traps ).exercise() > 0 );
        CHECK( host.get_skill_level_object( skill_traps ).exercise() == 0 );
    }
    if( method == "JACKHAMMER" ) {
        CHECK( remote.get_wielded_item()->ammo_remaining() < host_ammo );
    }
    const std::string after_rng = capture_rng_state();
    const size_t drops = here.i_at( target ).size();
    const int remote_ammo = remote.get_wielded_item()->ammo_remaining();
    fixture.run( remote, finish );
    CHECK( capture_rng_state() == after_rng );
    CHECK( here.i_at( target ).size() == drops );
    CHECK( remote.get_wielded_item()->ammo_remaining() == remote_ammo );

    // The host's old activity must not harvest the replacement surface.
    host.activity.moves_left = 1;
    host.set_moves( 100 );
    host.activity.do_turn( host );
    CHECK_FALSE( host.activity );
    CHECK( here.i_at( target ).size() == drops );
    CHECK( host.get_wielded_item()->ammo_remaining() == host_ammo );
    CHECK( capture_rng_state() == after_rng );
}

TEST_CASE( "mp_adjacent_tools_reject_bad_targets_and_lost_access",
           "[mp_inventory_activity][mp_adjacent_tool]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &remote = fixture.remote();
    remote.set_wielded_item( item( itype_test_halligan ) );
    remote.set_moves( 1000 );
    const std::string before_rng = capture_rng_state();
    for( const tripoint_bub_ms &target : { remote.pos_bub(), tripoint_bub_ms( 64, 60, 0 ),
                                           tripoint_bub_ms( 60, 60, 1 ) } ) {
        here.ter_set( target, ter_test_t_prying1 );
        CHECK_FALSE( execute_owned_item_activation( remote, remote.get_wielded_item(), "CROWBAR",
                     here.get_abs( target ), false, false ) );
        CHECK_FALSE( remote.activity );
        CHECK( remote.get_moves() == 1000 );
        CHECK( capture_rng_state() == before_rng );
    }
    const tripoint_bub_ms target( 61, 60, 0 );
    here.ter_set( target, ter_test_t_prying1 );
    REQUIRE( execute_owned_item_activation( remote, remote.get_wielded_item(), "CROWBAR",
                                            here.get_abs( target ), false, false ) );
    SECTION( "tool_removed" ) {
        remote.remove_weapon();
    }
    SECTION( "actor_moved_away" ) {
        remote.setpos( here, tripoint_bub_ms( 64, 60, 0 ) );
    }
    SECTION( "target_changed_while_saved" ) {
        save_reload_activity( remote );
        here.ter_set( target, ter_t_door_locked );
    }
    remote.activity.moves_left = 1;
    remote.set_moves( 100 );
    remote.activity.do_turn( remote );
    CHECK_FALSE( remote.activity );
    CHECK( here.i_at( target ).empty() );
}

TEST_CASE( "owned_tool_target_tracks_absolute_surface_and_vehicle_identity",
           "[mp_adjacent_tool]" )
{
    reload_fixture fixture;
    map &here = get_map();
    const tripoint_bub_ms target( 61, 60, 0 );
    here.ter_set( target, ter_t_door_locked );
    const tool_activity_target captured = tool_activity_target::capture( here, here.get_abs( target ) );
    std::ostringstream stream;
    JsonOut out( stream );
    captured.serialize( out );
    tool_activity_target restored;
    JsonValue value = json_loader::from_string( stream.str() );
    restored.deserialize( value.get_object() );
    CHECK( restored.position == here.get_abs( target ) );
    CHECK( restored.matches( here ) );
    here.ter_set( target, ter_t_door_c );
    CHECK_FALSE( restored.matches( here ) );
    here.ter_set( target, ter_t_pavement );
    const tool_activity_target empty = tool_activity_target::capture( here, here.get_abs( target ) );
    vehicle *car = here.add_vehicle( vehicle_prototype_car, target, 0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( car );
    const tool_activity_target occupied = tool_activity_target::capture( here, here.get_abs( target ) );
    CHECK( occupied.vehicle == car->uid().get_value() );
    CHECK_FALSE( empty.matches( here ) );
    bool checked_lock = false;
    for( int i = 0; i < car->part_count(); ++i ) {
        if( car->part( i ).info().has_flag( "LOCKABLE_DOOR" ) ) {
            if( !car->part_has_lock( i ) ) {
                const point_rel_ms mount = car->part( i ).mount;
                REQUIRE( car->install_part( here, mount, vpart_door_lock ) >= 0 );
            }
            car->part( i ).locked = true;
            const tool_activity_target door = tool_activity_target::capture( here,
                              here.get_abs( car->bub_part_pos( here, i ) ) );
            REQUIRE( door.locked_part != 0 );
            CHECK( door.matches( here ) );
            car->part( i ).locked = false;
            CHECK_FALSE( door.matches( here ) );
            checked_lock = true;
            break;
        }
    }
    CHECK( checked_lock );
    here.destroy_vehicle( car );
    CHECK_FALSE( occupied.matches( here ) );
}

TEST_CASE( "automatic_mining_is_authoritative_and_only_completed_work_queues_movement",
           "[multiplayer][mp_auto_tool]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &remote = fixture.remote();
    player_control controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    avatar &local = get_avatar();
    local.clear_destination();
    const on_out_of_scope clear_route( [&local]() { local.clear_destination(); } );
    const tripoint_bub_ms target = remote.pos_bub() + tripoint::east;
    here.ter_set( target, ter_t_rock );
    local.setpos( here, remote.pos_bub(), false );
    const auto pending_mining = capture_automove_step( local, here, here.get_abs( target ), true );
    REQUIRE( pending_mining );
    local.setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    remote.set_wielded_item( item( itype_jackhammer_mining ) );
    item_location tool = remote.get_wielded_item();
    tool->ammo_set( itype_gasoline, 1200 );
    const std::string outcome = GENERATE( "finish", "cancel", "empty", "stunned", "lost_tool" );
    CAPTURE( outcome );
    if( outcome == "empty" ) {
        tool->ammo_set( itype_gasoline, 0 );
    } else if( outcome == "stunned" ) {
        remote.add_effect( effect_stunned, 1_minutes );
    }
    const std::string rng_before_start = capture_rng_state();
    const std::string wire = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "auto_mine" );
        out.member( "source", cata_mp::capture_item_source( remote, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", "JACKHAMMER" );
        out.member( "target", here.get_abs( target ) );
    } );
    const std::string started = fixture.run( remote, wire );
    const std::string rng_after_start = capture_rng_state();
    fixture.run( remote, wire );
    const bool accepted = outcome != "empty" && outcome != "stunned";
    CHECK( static_cast<bool>( remote.activity ) == accepted );
    CHECK( static_cast<bool>( fixture.reload.automatic_mining_target ) == accepted );
    CHECK( capture_rng_state() == rng_after_start );
    if( !accepted ) {
        CHECK( capture_rng_state() == rng_before_start );
    }
    CHECK( here.ter( target ) == ter_t_rock.id() );
    std::string result = started;
    if( accepted ) {
        save_reload_activity( remote );
        if( outcome == "lost_tool" ) {
            remote.remove_weapon();
        }
        remote.set_moves( 100 );
        remote.activity.moves_left = 0;
        result = fixture.run( remote, fixture.request( remote, outcome == "cancel" ? "cancel" : "step" ) );
        CHECK_FALSE( remote.activity );
    }
    const bool finished = outcome == "finish";
    CHECK( here.passable( target ) == finished );
    CHECK( ( result.find( "automatic_mining_destination" ) != std::string::npos ) == finished );
    CHECK_FALSE( fixture.reload.automatic_mining_target );
    if( finished ) {
        CHECK( tool->ammo_remaining() < 1200 );
    } else if( outcome != "lost_tool" ) {
        CHECK( tool->ammo_remaining() == ( outcome == "empty" ? 0 : 1200 ) );
    }

    // Apply the real authority result to a client view. It must queue the
    // follow-up step exactly once without executing the mining actor locally.
    local.setpos( here, remote.pos_bub() );
    cata_mp::set_client_mode( true );
    player_activity view_activity{ invoke_item_activity_actor( item_location(), std::string() ) };
    view_activity.set_execution( activity_execution::presentation );
    local.assign_activity( view_activity );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = fixture.sequence;
    view.pending_automove = pending_mining;
    view.automatic_mining = true;
    const std::string rng_before_replica = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( result ) );
    CHECK_FALSE( local.has_destination() );
    REQUIRE( cata_mp::client_apply_message( result ) );
    cata_mp::client_turn_state &turn = g->multiplayer_session().client_turn;
    turn.client_waiting_for_ack = true;
    local.set_moves( 100 );
    cata_mp::client_update_inventory_activity_view();
    CHECK( view.active );
    CHECK_FALSE( local.has_destination() );
    turn.client_waiting_for_ack = false;
    cata_mp::client_update_inventory_activity_view();
    CHECK( local.has_destination() == finished );
    CHECK_FALSE( local.activity );
    CHECK( capture_rng_state() == rng_before_replica );
    if( finished ) {
        CHECK( local.get_next_auto_move_direction() == ACTION_MOVE_RIGHT );
        CHECK_FALSE( local.has_destination() );
    }
}

TEST_CASE( "automatic_and_examine_tool_entries_only_create_client_views",
           "[multiplayer][mp_auto_tool]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    who.clear_destination();
    const on_out_of_scope clear_route( [&who]() { who.clear_destination(); } );
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    const override_option auto_features( "AUTO_FEATURES", "true" );
    const override_option auto_mining( "AUTO_MINING", "true" );
    restore_on_out_of_scope restore_mostseen( g->mostseen );
    g->mostseen = 0;
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    std::string rng_before = capture_rng_state();
    SECTION( "automatic_mining" ) {
        here.ter_set( target, ter_t_rock );
        who.set_wielded_item( item( itype_pickaxe ) );
        rng_before = capture_rng_state();
        REQUIRE( cata_mp::client_auto_mine( here.get_abs( target ) ) );
        REQUIRE( g->multiplayer_session().client_inventory_activity.pending_automove );
        CHECK( g->multiplayer_session().client_inventory_activity.automatic_mining );
        CHECK( here.ter( target ) == ter_t_rock.id() );
        CHECK_FALSE( who.has_destination() );
    }
    SECTION( "examine_pry" ) {
        here.ter_set( target, ter_test_t_prying1 );
        who.set_wielded_item( item( itype_test_halligan ) );
        rng_before = capture_rng_state();
        iexamine::locked_object( who, target );
        CHECK( here.ter( target ) == ter_test_t_prying1.id() );
    }
    SECTION( "explicit_lockpick_target" ) {
        here.ter_set( target, ter_t_door_locked );
        who.set_wielded_item( item( itype_test_sonic_screwdriver ) );
        std::string method = "PICK_LOCK";
        rng_before = capture_rng_state();
        REQUIRE( cata_mp::client_activate_item( who.get_wielded_item(), method, here.get_abs( target ) ) );
        CHECK( here.ter( target ) == ter_t_door_locked.id() );
    }
    CHECK( who.activity.execution() == activity_execution::presentation );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK( capture_rng_state() == rng_before );
    CHECK_FALSE( dynamic_cast<prying_activity_actor *>( who.activity.actor.get() ) );
    CHECK_FALSE( dynamic_cast<lockpick_activity_actor *>( who.activity.actor.get() ) );
}

TEST_CASE( "examine_prying_preserves_tools_without_a_manual_use_action",
           "[multiplayer][mp_auto_tool]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.ter_set( target, ter_test_t_prying1 );
    who.set_wielded_item( item( itype_nail_puller_bronze ) );
    item_location tool = who.get_wielded_item();
    REQUIRE_FALSE( supports_owned_item_activation( *tool, "CROWBAR" ) );
    const std::string start = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "examine_pry" );
        out.member( "source", cata_mp::capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "target", here.get_abs( target ) );
    } );
    fixture.run( who, start );
    REQUIRE( who.activity.id() == ACT_PRYING );
    CHECK( who.activity.execution() == activity_execution::authoritative );
    who.activity.moves_left = 1;
    who.set_moves( 100 );
    const std::string finish = fixture.request( who, "step" );
    fixture.run( who, finish );
    CHECK( here.ter( target ) == ter_t_dirt.id() );
    const size_t count = here.i_at( target ).size();
    const std::string rng_after = capture_rng_state();
    fixture.run( who, finish );
    CHECK( here.i_at( target ).size() == count );
    CHECK( capture_rng_state() == rng_after );
}

namespace
{
unsigned int prepare_targeted_bionic( Character &who, const bionic_id &id )
{
    who.add_bionic( bio_power_storage );
    const unsigned int uid = who.add_bionic( id );
    who.set_max_power_level( 200_kJ );
    who.set_power_level( 200_kJ );
    who.set_moves( 100 );
    return uid;
}
void prepare_bionic_target( map &here, const tripoint_bub_ms &target, const bionic_id &id )
{
    if( id == bio_lockpick ) {
        here.ter_set( target, ter_t_door_locked );
    } else if( id == bio_lighter ) {
        here.add_item_or_charges( target, item( itype_2x4 ) );
        REQUIRE( here.is_flammable( target ) );
    } else {
        here.furn_set( target, furn_f_console );
        REQUIRE( here.has_flag( ter_furn_flag::TFLAG_CONSOLE, target ) );
    }
}
std::string bionic_request( reload_fixture &fixture, Character &who, unsigned int uid,
                            const bionic_id &id, const tripoint_abs_ms &target )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", id );
        out.member( "target", target );
    } );
}
} // namespace

TEST_CASE( "targeted_bionics_execute_once_on_the_owning_player", "[mp_bionic]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    player_control controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    avatar &host = get_avatar();
    map &here = get_map();
    host.setpos( here, tripoint_bub_ms( 65, 60, 0 ) );
    const bionic_id id( GENERATE( "bio_lockpick", "bio_lighter", "bio_emp" ) );
    CAPTURE( id.str() );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    prepare_targeted_bionic( host, id );
    const tripoint_bub_ms target = remote.pos_bub() + tripoint::east;
    prepare_bionic_target( here, target, id );
    const units::energy before = remote.get_power_level();
    const std::string wire = bionic_request( fixture, remote, uid, id, here.get_abs( target ) );
    fixture.run( remote, wire );
    CHECK( remote.get_power_level() == before - id->power_activate );
    CHECK( host.get_power_level() == before );
    const std::string after_start = capture_rng_state();
    fixture.run( remote, wire );
    CHECK( capture_rng_state() == after_start );
    CHECK( remote.get_power_level() == before - id->power_activate );
    if( id == bio_lockpick ) {
        REQUIRE( remote.activity.id() == ACT_LOCKPICK );
        save_reload_activity( remote );
        remote.set_moves( 100 );
        remote.activity.moves_left = 1;
        fixture.run( remote, fixture.request( remote, "step" ) );
        CHECK_FALSE( remote.activity );
        CHECK( here.ter( target ) == ter_t_door_c.id() );
    } else if( id == bio_lighter ) {
        CHECK( here.get_field( target, fd_fire ) );
        CHECK( remote.get_moves() == 0 );
    } else {
        CHECK( here.furn( target ) == furn_f_machinery_electronic.id() );
        CHECK( remote.get_moves() == 0 );
    }
}

TEST_CASE( "targeted_bionics_reject_invalid_intents_and_cancel_removed_implants", "[mp_bionic]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    map &here = get_map();
    const bionic_id &id = bio_lockpick;
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const tripoint_bub_ms target = remote.pos_bub() + tripoint::east;
    prepare_bionic_target( here, target, id );
    const std::string failure = GENERATE( "far", "power", "shorted", "wrong_uid", "wrong_type", "removed_after_load" );
    CAPTURE( failure );
    if( failure == "power" ) {
        remote.set_power_level( 0_kJ );
    } else if( failure == "shorted" ) {
        ( *remote.find_bionic_by_uid( uid ) )->incapacitated_time = 1_minutes;
    }
    const units::energy before_power = remote.get_power_level();
    const std::string before_rng = capture_rng_state();
    fixture.run( remote, bionic_request( fixture, remote,
                                         failure == "wrong_uid" ? uid + 100 : uid,
                                         failure == "wrong_type" ? bio_lighter : id,
                                         here.get_abs( failure == "far" ? target + tripoint::east : target ) ) );
    if( failure == "removed_after_load" ) {
        REQUIRE( remote.activity );
        save_reload_activity( remote );
        remote.remove_bionic( **remote.find_bionic_by_uid( uid ) );
        // Another instance of the same type must not inherit the old work.
        const unsigned int replacement = remote.add_bionic( id );
        REQUIRE( replacement != uid );
        remote.set_moves( 100 );
        remote.activity.moves_left = 1;
        fixture.run( remote, fixture.request( remote, "step" ) );
    } else {
        CHECK( remote.get_power_level() == before_power );
        CHECK( capture_rng_state() == before_rng );
    }
    CHECK_FALSE( remote.activity );
    CHECK( here.ter( target ) == ter_t_door_locked.id() );
}

TEST_CASE( "bionic_identity_is_not_recycled_after_character_restore", "[mp_bionic][bionics]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const bionic_id &id = bio_lockpick;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    who.remove_bionic( **who.find_bionic_by_uid( uid ) );
    const std::string mode = GENERATE( "save", "player_state", "turn_state" );
    CAPTURE( mode );
    std::ostringstream saved;
    JsonOut out( saved );
    if( mode == "save" ) {
        who.serialize( out );
    } else if( mode == "player_state" ) {
        who.store_player_state( out );
    } else {
        who.store_turn_state( out );
    }
    const JsonObject data = json_loader::from_string( saved.str() ).get_object();
    if( mode == "save" ) {
        npc restored;
        restored.deserialize( data );
        CHECK( restored.add_bionic( id ) > uid );
        return;
    } else if( mode == "player_state" ) {
        who.load_player_state( data );
    } else {
        who.load_turn_state( data );
    }
    CHECK( who.add_bionic( id ) > uid );
}

TEST_CASE( "bionic_menu_and_examine_only_queue_client_requests", "[mp_bionic]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const bionic_id &id = bio_lockpick;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    prepare_bionic_target( here, target, id );
    const units::energy before_power = who.get_power_level();
    const std::string before_rng = capture_rng_state();
    cata_mp::set_client_mode( true );
    SECTION( "native_menu_entry" ) {
        bool close_ui = false;
        const bionic_activation_choices choices{ here.get_abs( target ) };
        REQUIRE( who.activate_bionic( **who.find_bionic_by_uid( uid ), false, &close_ui, &choices ) );
        CHECK( close_ui );
    }
    SECTION( "examine_entry" ) {
        iexamine::locked_object_pickable( who, target );
    }
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK( who.activity.execution() == activity_execution::presentation );
    CHECK( who.get_power_level() == before_power );
    CHECK( capture_rng_state() == before_rng );
    CHECK( here.ter( target ) == ter_t_door_locked.id() );
}

TEST_CASE( "bionic_emp_affects_the_character_at_the_target_tile", "[mp_bionic]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    map &here = get_map();
    host.setpos( here, remote.pos_bub() + tripoint::west );
    const bionic_id &id = bio_emp;
    const unsigned int uid = prepare_targeted_bionic( host, id );
    prepare_targeted_bionic( remote, bio_lockpick );
    const units::energy host_power = host.get_power_level();
    const units::energy remote_power = remote.get_power_level();
    REQUIRE( execute_owned_bionic_action( host, uid, id, { remote.pos_abs() } ) );
    CHECK( host.get_power_level() == host_power - id->power_activate );
    CHECK( remote.get_power_level() < remote_power );
}

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
TEST_CASE( "bionic_native_hooks_keep_lua_state_on_the_acting_character", "[mp_bionic][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    reload_fixture fixture;
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::string mod = "owned_bionic_hook";
    const auto runtime = platform::make_runtime( mod, 4110, lua );
    const on_out_of_scope cleanup( []() { platform::shutdown(); } );
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );
    lua["ccb"] = ccb;
    npc &remote = fixture.remote();
    player_control controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 65, 60, 0 ) );
    const bionic_id &id = bio_lockpick;
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const unsigned int host_uid = prepare_targeted_bionic( host, id );
    const bool remove_during_hook = GENERATE( false, true );
    lua.set_function( "mutate_native", [&]() {
        if( remove_during_hook ) {
            const auto bio = remote.find_bionic_by_uid( uid );
            if( bio ) {
                remote.remove_bionic( **bio );
            }
        }
    } );
    const sol::protected_function_result registered = lua.safe_script( R"lua(
ccb.runtime.handler("activated", function(context)
    local state = ccb.state.character
    state.set("uses", state.get("uses", 0) + 1)
    mutate_native()
end)
ccb.runtime.hook("on_bionic_activated", "activated")
)lua", sol::script_pass_on_error );
    REQUIRE( registered.valid() );
    const auto uses = [&]( Character &who ) {
        const cata::lua_platform::script_persistent_state &values = who.lua_character_state.for_mod( mod );
        const auto found = values.find( "uses" );
        return found == values.end() ? int64_t( 0 ) : std::get<int64_t>( found->second );
    };
    const tripoint_bub_ms target = remote.pos_bub() + tripoint::east;
    prepare_bionic_target( get_map(), target, id );
    const std::string wire = bionic_request( fixture, remote, uid, id, get_map().get_abs( target ) );
    fixture.run( remote, wire );
    CHECK( uses( remote ) == 1 );
    CHECK( uses( host ) == 0 );
    CHECK( static_cast<bool>( remote.activity ) == !remove_during_hook );
    fixture.run( remote, wire );
    CHECK( uses( remote ) == 1 );
    const tripoint_bub_ms host_target = host.pos_bub() + tripoint::east;
    prepare_bionic_target( get_map(), host_target, id );
    REQUIRE( execute_owned_bionic_action( host, host_uid, id,
                                          { get_map().get_abs( host_target ) } ) );
    CHECK( uses( host ) == 1 );
    CHECK( uses( remote ) == 1 );
}
#endif


namespace
{
std::string bionic_switch_request( reload_fixture &fixture, Character &who, unsigned int uid,
                                   const bionic_id &id, bool enabled )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", enabled ? "bionic_activation" : "bionic_deactivation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", id );
    } );
}
} // namespace

TEST_CASE( "bionic_switches_set_only_the_owning_players_native_state", "[mp_bionic_switch]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    const bionic_id &id = bio_night_vision;
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const unsigned int host_uid = prepare_targeted_bionic( host, id );
    const units::energy host_power = host.get_power_level();
    const units::energy before = remote.get_power_level();
    const std::string start = bionic_switch_request( fixture, remote, uid, id, true );
    fixture.run( remote, start );
    CHECK( remote.has_active_bionic( id ) );
    CHECK( remote.has_flag( json_flag_NIGHT_VISION ) );
    CHECK_FALSE( host.has_active_bionic( id ) );
    CHECK( host.get_power_level() == host_power );
    CHECK( remote.get_power_level() == before - id->power_activate );
    const std::string after_start = capture_rng_state();
    fixture.run( remote, start );
    CHECK( capture_rng_state() == after_start );
    CHECK( remote.get_power_level() == before - id->power_activate );

    const std::string stop = bionic_switch_request( fixture, remote, uid, id, false );
    const std::string result = fixture.run( remote, stop );
    CHECK_FALSE( remote.has_active_bionic( id ) );
    CHECK_FALSE( remote.has_flag( json_flag_NIGHT_VISION ) );
    CHECK( remote.get_power_level() == before - id->power_activate - id->power_deactivate );
    const std::string after_stop = capture_rng_state();
    fixture.run( remote, stop );
    CHECK( capture_rng_state() == after_stop );
    CHECK( remote.get_power_level() == before - id->power_activate - id->power_deactivate );

    // The real reply updates the replica without rerunning native callbacks.
    const auto host_bionic = host.find_bionic_by_uid( host_uid );
    REQUIRE( host_bionic );
    REQUIRE( host.activate_bionic( **host_bionic ) );
    cata_mp::set_client_mode( true );
    player_activity activity{ invoke_item_activity_actor( item_location(), std::string() ) };
    activity.set_execution( activity_execution::presentation );
    host.assign_activity( activity );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = fixture.sequence;
    const std::string rng_before_reply = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( result ) );
    REQUIRE( cata_mp::client_apply_message( result ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( host.activity );
    CHECK_FALSE( host.has_active_bionic( id ) );
    CHECK_FALSE( host.has_flag( json_flag_NIGHT_VISION ) );
    CHECK( host.get_power_level() == remote.get_power_level() );
    CHECK( capture_rng_state() == rng_before_reply );
}

TEST_CASE( "bionic_switches_preserve_exclusion_and_native_periodic_effects", "[mp_bionic_switch]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    SECTION( "hearing_and_earplugs" ) {
        const bionic_id &hearing = bio_ears;
        const unsigned int hearing_uid = prepare_targeted_bionic( remote, hearing );
        prepare_targeted_bionic( host, hearing );
        if( !host.has_active_bionic( hearing ) ) {
            REQUIRE( host.activate_bionic( **host.find_bionic_by_type( hearing ) ) );
        }
        const bionic_id &plugs = bio_earplugs;
        const auto plug = remote.find_bionic_by_type( plugs );
        REQUIRE( plug );
        fixture.run( remote, bionic_switch_request( fixture, remote, ( *plug )->get_uid(), plugs, true ) );
        CHECK( remote.has_flag( json_flag_DEAF ) );
        CHECK_FALSE( remote.has_active_bionic( hearing ) );
        CHECK( host.has_active_bionic( hearing ) );
        fixture.run( remote, bionic_switch_request( fixture, remote, hearing_uid, hearing, true ) );
        CHECK_FALSE( remote.has_flag( json_flag_DEAF ) );
        CHECK( remote.has_active_bionic( hearing ) );
    }
    SECTION( "painkiller_tick" ) {
        const bionic_id &id = bio_painkiller;
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        prepare_targeted_bionic( host, id );
        remote.set_pain( 100 );
        remote.set_painkiller( 0 );
        host.set_painkiller( 0 );
        fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
        REQUIRE( remote.has_active_bionic( id ) );
        const units::energy before_tick = remote.get_power_level();
        remote.process_bionic( **remote.find_bionic_by_uid( uid ) );
        CHECK( remote.get_painkiller() == 1 );
        CHECK( remote.get_power_level() == before_tick - id->power_trigger );
        CHECK( host.get_painkiller() == 0 );
    }
    SECTION( "retract_existing_weapon" ) {
        const bionic_id &id = bio_claws;
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        REQUIRE( remote.activate_bionic( **remote.find_bionic_by_uid( uid ) ) );
        REQUIRE( remote.is_using_bionic_weapon() );
        host.set_wielded_item( item( itype_hammer ) );
        fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, false ) );
        CHECK_FALSE( remote.has_active_bionic( id ) );
        CHECK_FALSE( remote.is_using_bionic_weapon() );
        CHECK_FALSE( remote.get_wielded_item() );
        REQUIRE( host.get_wielded_item() );
        CHECK( host.get_wielded_item()->typeId() == itype_hammer );
    }
    SECTION( "evaporator_uses_its_owners_environment" ) {
        const bionic_id &id = bio_evap;
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        const bool underwater = GENERATE( true, false );
        remote.set_underwater( underwater );
        host.set_underwater( !underwater );
        const restore_on_out_of_scope humidity( get_weather().weather_precise->humidity );
        get_weather().weather_precise->humidity = 80;
        fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
        CHECK( remote.has_active_bionic( id ) == !underwater );
    }
}

TEST_CASE( "bionic_switch_client_entries_do_not_toggle_the_replica", "[mp_bionic_switch]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    const bionic_id &id = bio_night_vision;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    const bool enabled = GENERATE( true, false );
    if( !enabled ) {
        REQUIRE( who.activate_bionic( **who.find_bionic_by_uid( uid ) ) );
    }
    const units::energy before_power = who.get_power_level();
    const std::string before_rng = capture_rng_state();
    cata_mp::set_client_mode( true );
    if( enabled ) {
        bool close_ui = false;
        REQUIRE( who.activate_bionic( **who.find_bionic_by_uid( uid ), false, &close_ui ) );
        CHECK( close_ui );
    } else {
        REQUIRE( who.deactivate_bionic( **who.find_bionic_by_uid( uid ) ) );
    }
    CHECK( who.has_active_bionic( id ) == !enabled );
    CHECK( who.get_power_level() == before_power );
    CHECK( capture_rng_state() == before_rng );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
}

TEST_CASE( "bionic_switches_reject_missing_choices_and_invalid_stops", "[mp_bionic_switch]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    SECTION( "missing_remote_choice" ) {
        const bionic_id &id = bio_remote;
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        const units::energy power = remote.get_power_level();
        const std::string rng = capture_rng_state();
        fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
        CHECK_FALSE( remote.has_active_bionic( id ) );
        CHECK( remote.get_power_level() == power );
        CHECK( capture_rng_state() == rng );
    }
    SECTION( "shorted_or_wrong_identity" ) {
        const bionic_id &id = bio_night_vision;
        const unsigned int uid = prepare_targeted_bionic( remote, id );
        REQUIRE( remote.activate_bionic( **remote.find_bionic_by_uid( uid ) ) );
        const bool shorted = GENERATE( true, false );
        if( shorted ) {
            ( *remote.find_bionic_by_uid( uid ) )->incapacitated_time = 1_minutes;
        }
        const units::energy power = remote.get_power_level();
        const std::string rng = capture_rng_state();
        fixture.run( remote, bionic_switch_request( fixture, remote, shorted ? uid : uid + 100, id, false ) );
        CHECK( ( *remote.find_bionic_by_uid( uid ) )->powered );
        CHECK( remote.get_power_level() == power );
        CHECK( capture_rng_state() == rng );
    }
}


#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
TEST_CASE( "bionic_switch_hooks_retain_owned_activities_and_safe_deactivation", "[mp_bionic_switch][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    reload_fixture fixture;
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::string mod = "owned_bionic_switch";
    const auto runtime = platform::make_runtime( mod, 4111, lua );
    const on_out_of_scope cleanup( []() { platform::shutdown(); } );
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );
    lua["ccb"] = ccb;
    npc &remote = fixture.remote();
    player_control controller = g->player_controls().claim(
                          cata_mp::player_id( std::string( 32, '9' ) ), remote );
    const bionic_id &id = bio_night_vision;
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const bool remove_on_stop = GENERATE( false, true );
    lua.set_function( "begin_native_work", [&]() {
        remote.assign_activity( player_activity( ACT_WAIT, 100 ) );
    } );
    lua.set_function( "stop_native", [&]() {
        if( remove_on_stop ) {
            const auto bio = remote.find_bionic_by_uid( uid );
            if( bio ) {
                remote.remove_bionic( **bio );
            }
        }
    } );
    const sol::protected_function_result registered = lua.safe_script( R"lua(
ccb.runtime.handler("on", function(context)
    local state = ccb.state.character
    state.set("started", state.get("started", 0) + 1)
    begin_native_work()
end)
ccb.runtime.handler("off", function(context)
    local state = ccb.state.character
    state.set("stopped", state.get("stopped", 0) + 1)
    stop_native()
end)
ccb.runtime.hook("on_bionic_activated", "on")
ccb.runtime.hook("on_bionic_deactivated", "off")
)lua", sol::script_pass_on_error );
    REQUIRE( registered.valid() );
    const auto value = [&]( Character &who, const std::string &key ) {
        const cata::lua_platform::script_persistent_state &values = who.lua_character_state.for_mod( mod );
        const auto found = values.find( key );
        return found == values.end() ? int64_t( 0 ) : std::get<int64_t>( found->second );
    };
    const units::energy before = remote.get_power_level();
    fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
    CHECK( remote.get_power_level() == before - id->power_activate );
    CHECK( remote.has_active_bionic( id ) );
    REQUIRE( remote.activity.id() == ACT_WAIT );
    CHECK( remote.activity.execution() == activity_execution::authoritative );
    CHECK( value( remote, "started" ) == 1 );
    CHECK( value( get_avatar(), "started" ) == 0 );
    remote.cancel_activity();
    remote.set_moves( 100 );
    const std::string stop = bionic_switch_request( fixture, remote, uid, id, false );
    fixture.run( remote, stop );
    CHECK_FALSE( remote.has_active_bionic( id ) );
    CHECK( remote.find_bionic_by_uid( uid ).has_value() == !remove_on_stop );
    CHECK( value( remote, "stopped" ) == 1 );
    CHECK( value( get_avatar(), "stopped" ) == 0 );
    fixture.run( remote, stop );
    CHECK( value( remote, "stopped" ) == 1 );
}
#endif

namespace
{
cata_mp::remote_player_session &bind_feedback_player( npc &actor, char id, uint64_t peer )
{
    cata_mp::remote_player_session &recipient = make_test_remote( g->multiplayer_session(), peer );
    recipient.connected = true;
    recipient.credentials.id = player_id( std::string( 32, id ) );
    actor.set_value( "mp_proxy", std::string( "1" ) );
    actor.set_value( "mp_player_id", recipient.credentials.id.str() );
    recipient.actor.bind_player( actor, recipient.credentials.id, g->npc_lifetimes(),
                                 g->player_controls().claim( recipient.credentials.id, actor ) );
    return recipient;
}
}

TEST_CASE( "native_player_feedback_keeps_private_and_observer_messages_separate", "[mp_feedback]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( remote, 'a', 701 );
    npc &other = spawn_npc( { 62, 60 }, "test_talker" );
    cata_mp::remote_player_session &other_recipient = bind_feedback_player( other, 'b', 702 );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 61, 60, 0 ) );
    get_map().build_map_cache( 0 );
    REQUIRE( get_player_view().sees( get_map(), remote ) );
    Messages::clear_messages();

    remote.add_msg_if_player( m_bad, "private owner failure" );
    REQUIRE( recipient.feedback.pending.size() == 1 );
    CHECK( recipient.feedback.pending.front().params.type == m_bad );
    CHECK( other_recipient.feedback.pending.empty() );
    CHECK( Messages::size() == 0 );
    remote.add_msg_player_or_npc( m_good, "owner success", "<npcname> succeeds" );
    REQUIRE( recipient.feedback.pending.size() == 2 );
    REQUIRE( Messages::size() == 1 );
    CHECK( Messages::recent_messages( 1 ).front().second.find( "succeeds" ) != std::string::npos );
    CHECK( Messages::recent_messages_for_player( 1, recipient.credentials.id ).empty() );
    CHECK( Messages::recent_messages_for_player( 1, other_recipient.credentials.id ).size() == 1 );
    remote.add_msg_player_or_say( m_warning, "owner instruction", "NPC-only speech" );
    CHECK( recipient.feedback.pending.back().text == "owner instruction" );
    CHECK( Messages::size() == 1 );

    // Same displayed text with a different audience must not coalesce.
    const auto observer = Messages::recent_messages( 1 ).front().second;
    Messages::add_msg( m_good, observer );
    CHECK( Messages::size() == 2 );
    CHECK( Messages::recent_messages_for_player( 2, recipient.credentials.id ).size() == 1 );
    Messages::add_observer_msg( m_good, observer, recipient.credentials.id );
    CHECK( Messages::recent_messages_for_player( 1, recipient.credentials.id ).empty() );

    // Tags and copied numeric IDs alone cannot route private messages.
    npc impostor;
    impostor.setID( remote.getID() );
    impostor.set_value( "mp_proxy", std::string( "1" ) );
    impostor.set_value( "mp_player_id", recipient.credentials.id.str() );
    const int64_t before = recipient.feedback.sequence;
    impostor.add_msg_if_player( "must not be delivered" );
    CHECK( recipient.feedback.sequence == before );
    recipient.admission.retire();
    remote.add_msg_if_player( "disconnected" );
    CHECK( recipient.feedback.sequence == before );
    CHECK( cata_mp::take_player_feedback( recipient ) == "[]" );
    CHECK( recipient.feedback.pending.empty() );
}

TEST_CASE( "native_feedback_survives_full_logs_and_replays_without_advancing_gameplay_rng", "[mp_feedback]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( remote, 'a', 701 );
    const override_option options( "MESSAGE_LIMIT", "20" );
    Messages::clear_messages();
    for( int i = 0; i < 40; ++i ) {
        Messages::add_msg( "host log " + std::to_string( i ) );
    }
    const size_t host_size = Messages::size();
    for( int i = 0; i < 140; ++i ) {
        remote.add_msg_if_player( game_message_params( m_bad, gmf_bypass_cooldown ), "owner repeated message" );
    }
    CHECK( Messages::size() == host_size );
    REQUIRE( recipient.feedback.pending.size() == cata_mp::player_feedback_queue::max_pending );
    CHECK( recipient.feedback.pending.front().sequence == 13 );
    CHECK( recipient.feedback.pending.back().sequence == 140 );
    remote.add_msg_if_player( std::string( 8191, 'x' ) + "汽油" );
    CHECK( recipient.feedback.pending.back().text == std::string( 8191, 'x' ) );
    const std::string wire = "{\"player_feedback\":" + cata_mp::take_player_feedback( recipient ) + "}";
    CHECK( recipient.feedback.pending.empty() );
    const JsonValue value = json_loader::from_string( wire );
    const JsonObject data = value.get_object();
    get_avatar().add_effect( effect_weed_high, 3_hours );
    const std::string rng_before = capture_rng_state();
    cata_mp::apply_player_feedback( data );
    CHECK( capture_rng_state() == rng_before );
    CHECK( g->multiplayer_session().client_feedback_sequence == 141 );
    CHECK( g->multiplayer_session().client_turn.client_msg_watermark == Messages::size() );
    const auto first = Messages::recent_messages( Messages::size() );
    cata_mp::apply_player_feedback( data );
    CHECK( Messages::recent_messages( Messages::size() ) == first );
    CHECK( capture_rng_state() == rng_before );

    g->multiplayer_session().reset();
    CHECK( g->multiplayer_session().client_feedback_sequence == 0 );
    cata_mp::apply_player_feedback( data );
    CHECK( g->multiplayer_session().client_feedback_sequence == 141 );
}

TEST_CASE( "informational_bionics_report_the_owning_body_without_host_input", "[mp_feedback]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( remote, 'a', 701 );
    const bionic_id id( GENERATE( "bio_geiger", "bio_blood_anal", "bio_meteorologist" ) );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    remote.set_rad( 53 );
    get_avatar().set_rad( 11 );
    remote.add_effect( effect_poison, 1_hours );
    const units::energy power = remote.get_power_level();
    const std::string request = bionic_switch_request( fixture, remote, uid, id, true );
    Messages::clear_messages();
    fixture.run( remote, request );
    REQUIRE_FALSE( recipient.feedback.pending.empty() );
    CHECK( remote.get_power_level() == power - id->power_activate );
    const int64_t sequence = recipient.feedback.sequence;
    fixture.run( remote, request );
    CHECK( recipient.feedback.sequence == sequence );
    std::string report;
    for( const cata_mp::player_feedback_message &entry : recipient.feedback.pending ) {
        report += entry.text + "\n";
    }
    if( id == bio_geiger ) {
        CHECK( report.find( "53" ) != std::string::npos );
        CHECK( report.find( "11" ) == std::string::npos );
    } else if( id == bio_blood_anal ) {
        CHECK( report.find( "Blood Test Results" ) != std::string::npos );
        CHECK( report.find( "Poison" ) != std::string::npos );
    } else {
        CHECK( report.find( "Temperature:" ) != std::string::npos );
        CHECK( report.find( "Relative Humidity:" ) != std::string::npos );
        CHECK( report.find( "Wind Direction:" ) != std::string::npos );
    }
    const std::string last_line = recipient.feedback.pending.back().text;
    // The actual state producer includes the private channel, then drains it.
    const std::string state = cata_mp::serialize_remote_player_state( recipient );
    const JsonValue state_value = json_loader::from_string( state );
    const JsonObject data = state_value.get_object();
    data.allow_omitted_members();
    REQUIRE( data.has_array( "player_feedback" ) );
    CHECK_FALSE( data.get_array( "player_feedback" ).empty() );
    CHECK( recipient.feedback.pending.empty() );
    Messages::clear_messages();
    cata_mp::apply_player_feedback( data );
    const auto displayed = Messages::recent_messages( Messages::size() );
    REQUIRE_FALSE( displayed.empty() );
    CHECK( displayed.back().second == last_line );
}

namespace
{
std::string martial_choice_request( reload_fixture &fixture, Character &who,
                                    const martial_style_choice &choice )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "martial_style" );
        out.member( "martial_style", choice );
    } );
}

std::string cqb_choice_request( reload_fixture &fixture, Character &who, unsigned int uid,
                                const martial_style_choice &choice )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", "bio_cqb" );
        out.member( "martial_style", choice );
    } );
}
}

TEST_CASE( "martial_style_choices_apply_native_effects_only_to_the_owner", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    avatar &host = get_avatar();
    const matype_id &karate = style_karate;
    const matype_id &none = style_none;
    const martial_style_choice choice{ martial_style_action::select, karate };
    remote.martial_arts_data->add_martialart( karate );
    REQUIRE_FALSE( karate->static_buffs.empty() );
    const efftype_id stance = karate->static_buffs.front()->get_effect_id();
    const int moves = remote.get_moves();
    const std::string request = martial_choice_request( fixture, remote, choice );
    const std::string result = fixture.run( remote, request );
    CHECK( remote.martial_arts_data->selected_style() == karate );
    CHECK( remote.has_effect( stance ) );
    CHECK( remote.get_moves() == moves );
    CHECK( host.martial_arts_data->selected_style() == none );
    CHECK_FALSE( host.has_effect( stance ) );
    const std::string rng = capture_rng_state();
    fixture.run( remote, request );
    CHECK( capture_rng_state() == rng );

    host.martial_arts_data->add_martialart( karate );
    host.set_moves( 100 );
    cata_mp::set_client_mode( true );
    REQUIRE( cata_mp::client_select_martial_style( choice ) );
    CHECK( host.martial_arts_data->selected_style() == none );
    CHECK_FALSE( host.has_effect( stance ) );
    CHECK( host.activity.execution() == activity_execution::presentation );
    g->multiplayer_session().client_inventory_activity.pending_request = fixture.sequence;
    const std::string before_apply = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( result ) );
    REQUIRE( cata_mp::client_apply_message( result ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK( host.martial_arts_data->selected_style() == karate );
    CHECK( host.has_effect( stance ) );
    CHECK( capture_rng_state() == before_apply );
    CHECK_FALSE( host.activity );
}

TEST_CASE( "martial_preferences_are_owned_replay_safe_and_survive_save", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    player_control controller = g->player_controls().claim( player_id( std::string( 32, 'a' ) ), remote );
    character_martial_arts &arts = *remote.martial_arts_data;
    const matype_id &style = test_style_ma1;
    const matype_id &none = style_none;
    arts.add_martialart( style );
    remote.set_wielded_item( item( itype_test_weapon1 ) );
    REQUIRE( style->weapon_valid( remote.get_wielded_item() ) );
    const martial_style_choice automatic{ martial_style_action::toggle_auto, matype_id() };
    const std::string auto_request = martial_choice_request( fixture, remote, automatic );
    fixture.run( remote, auto_request );
    fixture.run( remote, auto_request );
    CHECK( arts.auto_style );
    CHECK( arts.selected_style() == style );
    fixture.run( remote, martial_choice_request( fixture, remote,
                 { martial_style_action::select, none } ) );
    CHECK( arts.selected_style() == none );
    const std::string hands = martial_choice_request( fixture, remote,
                              { martial_style_action::toggle_hands_free, matype_id() } );
    fixture.run( remote, hands );
    fixture.run( remote, hands );
    CHECK( arts.keep_hands_free );
    CHECK_FALSE( get_avatar().martial_arts_data->auto_style );
    CHECK_FALSE( get_avatar().martial_arts_data->keep_hands_free );

    std::ostringstream saved;
    JsonOut out( saved );
    remote.serialize( out );
    npc restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    REQUIRE( restored.martial_arts_data->auto_style );
    REQUIRE( restored.martial_arts_data->keep_hands_free );
    restored.set_wielded_item( item( itype_test_weapon2 ) );
    CHECK( restored.martial_arts_data->selected_style() == style );
    restored.set_wielded_item( item( itype_test_weapon1 ) );
    CHECK( restored.martial_arts_data->selected_style() == none );
}

TEST_CASE( "cqb_choice_uses_installed_styles_and_preserves_native_cancellation_cost", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    player_control controller = g->player_controls().claim( player_id( std::string( 32, 'a' ) ), remote );
    const bionic_id &id = bio_cqb;
    const matype_id &karate = style_karate;
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const units::energy before = remote.get_power_level();
    const auto styles = available_martial_styles( remote, uid );
    REQUIRE( std::find( styles.begin(), styles.end(), karate ) != styles.end() );
    CHECK_FALSE( remote.has_active_bionic( id ) );
    CHECK_FALSE( remote.martial_arts_data->has_martialart( karate ) );
    CHECK( remote.get_power_level() == before );
    const martial_style_action action = GENERATE( martial_style_action::select,
                                        martial_style_action::cancel, martial_style_action::toggle_hands_free );
    const martial_style_choice choice{ action, action == martial_style_action::select ? karate : matype_id() };
    const std::string request = cqb_choice_request( fixture, remote, uid, choice );
    const std::string result = fixture.run( remote, request );
    CHECK( remote.has_active_bionic( id ) == ( action != martial_style_action::cancel ) );
    CHECK( remote.get_power_level() == before - id->power_activate );
    CHECK_FALSE( remote.martial_arts_data->has_martialart( karate ) );
    if( action == martial_style_action::select ) {
        CHECK( remote.martial_arts_data->selected_style() == karate );
        CHECK( remote.has_effect( karate->static_buffs.front()->get_effect_id() ) );
    } else if( action == martial_style_action::toggle_hands_free ) {
        CHECK( remote.martial_arts_data->keep_hands_free );
    }
    const std::string after = capture_rng_state();
    fixture.run( remote, request );
    CHECK( remote.get_power_level() == before - id->power_activate );
    CHECK( capture_rng_state() == after );

    avatar &host = get_avatar();
    const unsigned int local_uid = prepare_targeted_bionic( host, id );
    const units::energy local_power = host.get_power_level();
    bionic_activation_choices input;
    input.martial_style = choice;
    cata_mp::set_client_mode( true );
    REQUIRE( host.activate_bionic( **host.find_bionic_by_uid( local_uid ), false, nullptr, &input ) );
    CHECK_FALSE( host.has_active_bionic( id ) );
    CHECK( host.get_power_level() == local_power );
    CHECK_FALSE( host.martial_arts_data->keep_hands_free );
    g->multiplayer_session().client_inventory_activity.pending_request = fixture.sequence;
    REQUIRE( cata_mp::client_apply_message( result ) );
    cata_mp::client_update_inventory_activity_view();
    CHECK( host.has_active_bionic( id ) == remote.has_active_bionic( id ) );
    CHECK( host.get_power_level() == remote.get_power_level() );
    CHECK( host.martial_arts_data->selected_style() == remote.martial_arts_data->selected_style() );
    CHECK( host.martial_arts_data->keep_hands_free == remote.martial_arts_data->keep_hands_free );
}

TEST_CASE( "martial_and_cqb_choices_reject_unavailable_or_wrong_action_data", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    const matype_id &karate = style_karate;
    const matype_id &none = style_none;
    const martial_style_choice choose{ martial_style_action::select, karate };
    fixture.run( remote, martial_choice_request( fixture, remote, choose ) );
    CHECK( remote.martial_arts_data->selected_style() == none );
    remote.martial_arts_data->add_martialart( karate );
    fixture.run( remote, martial_choice_request( fixture, remote, choose ), false );
    CHECK( remote.martial_arts_data->selected_style() == none );
    fixture.run( remote, martial_choice_request( fixture, remote,
                 { martial_style_action::toggle_hands_free, karate } ) );
    CHECK_FALSE( remote.martial_arts_data->keep_hands_free );
    const bionic_id &id = bio_cqb;
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const units::energy power = remote.get_power_level();
    fixture.run( remote, cqb_choice_request( fixture, remote, uid,
                 { martial_style_action::select, not_a_real_style } ) );
    CHECK_FALSE( remote.has_active_bionic( id ) );
    CHECK( remote.get_power_level() == power );
    bionic_activation_choices extra;
    extra.martial_style = choose;
    const bionic_id &ordinary = bio_night_vision;
    const unsigned int ordinary_uid = prepare_targeted_bionic( remote, ordinary );
    CHECK_FALSE( execute_owned_bionic_action( remote, ordinary_uid, ordinary, extra ) );
    CHECK_FALSE( execute_owned_bionic_action( remote, uid, id, extra, bionic_action::deactivate ) );
}

TEST_CASE( "martial_turn_projection_rejects_unknown_styles_without_partial_changes", "[mp_martial]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    remote.martial_arts_data->add_martialart( style_karate );
    std::ostringstream stream;
    JsonOut out( stream );
    remote.store_turn_state( out );
    std::string invalid = stream.str();
    const size_t position = invalid.find( "style_karate" );
    REQUIRE( position != std::string::npos );
    invalid.replace( position, std::string( "style_karate" ).size(), "nonexistent_martial_style" );
    avatar &host = get_avatar();
    const matype_id &judo = style_judo;
    host.martial_arts_data->add_martialart( judo );
    host.martial_arts_data->set_style( judo );
    host.set_rad( 73 );
    const std::string rng = capture_rng_state();
    const JsonValue value = json_loader::from_string( invalid );
    REQUIRE_THROWS_AS( host.load_turn_state( value.get_object() ), JsonError );
    CHECK( host.martial_arts_data->selected_style() == judo );
    CHECK( host.get_rad() == 73 );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "world_bionics_spare_the_activator_and_project_affected_players", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    npc &other = spawn_npc( { 60, 62 }, "test_talker" );
    clear_character( other, true );
    cata_mp::remote_player_session &observer = bind_feedback_player( other, 'b', 702 );
    const bionic_id id( GENERATE( "bio_flashbang", "bio_shockwave" ) );
    const bool local = GENERATE( false, true );
    CAPTURE( id, local );
    const tripoint_bub_ms origin( 60, 60, 0 );
    host.setpos( here, local ? origin : origin + tripoint( 2, 0, 0 ) );
    remote.setpos( here, local ? origin + tripoint( 2, 0, 0 ) : origin );
    other.setpos( here, origin + tripoint( 0, 2, 0 ) );
    Character &activator = local ? static_cast<Character &>( host ) : remote;
    Character &bystander = local ? static_cast<Character &>( remote ) : host;
    const unsigned int uid = prepare_targeted_bionic( activator, id );
    activator.set_max_power_level( 500_kJ );
    activator.set_power_level( 500_kJ );
    here.build_map_cache( 0 );
    const tripoint_abs_ms other_before = other.pos_abs();
    const tripoint_abs_ms bystander_before = bystander.pos_abs();
    const std::string request = bionic_switch_request( fixture, remote, uid, id, true );
    if( local ) {
        REQUIRE( activator.activate_bionic( **activator.find_bionic_by_uid( uid ) ) );
    } else {
        fixture.run( remote, request );
        CHECK( fixture.reload.refresh_observers );
    }
    CHECK( activator.get_power_level() == 500_kJ - id->power_activate );
    CHECK( activator.get_moves() == 0 );
    CHECK( activator.pos_bub() == origin );
    CHECK_FALSE( activator.has_effect( effect_deaf ) );
    CHECK_FALSE( activator.has_effect( effect_blind ) );
    CHECK_FALSE( activator.has_effect( effect_stunned ) );
    const efftype_id affected( id == bio_flashbang ? "deaf" : "stunned" );
    CHECK( bystander.has_effect( affected ) );
    CHECK( other.has_effect( affected ) );
    if( id == bio_shockwave ) {
        CHECK( other.pos_abs() != other_before );
        CHECK( bystander.pos_abs() != bystander_before );
    }
    if( !local ) {
        const std::string after_rng = capture_rng_state();
        const tripoint_abs_ms after_pos = other.pos_abs();
        fixture.run( remote, request );
        CHECK_FALSE( fixture.reload.refresh_observers );
        CHECK( remote.get_power_level() == 500_kJ - id->power_activate );
        CHECK( other.pos_abs() == after_pos );
        CHECK( capture_rng_state() == after_rng );
    }

    // The same per-recipient producer used by observer delivery carries both
    // knockback coordinates and body effects. Loading its body is effect-free.
    const std::string state = cata_mp::serialize_remote_player_state( observer );
    const JsonValue encoded = json_loader::from_string( state );
    const JsonObject data = encoded.get_object();
    data.allow_omitted_members();
    const JsonObject position = data.get_object( "pos" );
    CHECK( position.get_int( "x" ) == other.pos_abs().x() );
    CHECK( position.get_int( "y" ) == other.pos_abs().y() );
    CHECK( position.get_int( "z" ) == other.pos_abs().z() );
    host.clear_effects();
    CHECK_FALSE( host.has_effect( affected ) );
    const std::string before_apply = capture_rng_state();
    host.load_turn_state( data.get_object( "character_turn" ) );
    CHECK( host.has_effect( affected ) );
    CHECK( capture_rng_state() == before_apply );
}

TEST_CASE( "client_world_bionics_do_not_execute_area_effects_locally", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    avatar &host = get_avatar();
    npc &other = fixture.remote();
    host.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    const bionic_id id( GENERATE( "bio_flashbang", "bio_shockwave", "bio_resonator", "bio_magnet" ) );
    const unsigned int uid = prepare_targeted_bionic( host, id );
    host.set_max_power_level( 500_kJ );
    host.set_power_level( 500_kJ );
    const tripoint_abs_ms position = other.pos_abs();
    const std::string rng = capture_rng_state();
    cata_mp::set_client_mode( true );
    REQUIRE( host.activate_bionic( **host.find_bionic_by_uid( uid ) ) );
    CHECK( g->multiplayer_session().client_inventory_activity.active );
    CHECK( host.activity.execution() == activity_execution::presentation );
    CHECK( host.get_power_level() == 500_kJ );
    CHECK( other.pos_abs() == position );
    CHECK_FALSE( other.has_effect( effect_deaf ) );
    CHECK_FALSE( other.has_effect( effect_stunned ) );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "world_bionic_requests_require_ownership_and_native_power", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    const bionic_id id( GENERATE( "bio_flashbang", "bio_shockwave", "bio_resonator", "bio_magnet" ) );
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const std::string failure = GENERATE( "unauthorized", "power", "wrong_uid" );
    CAPTURE( id, failure );
    remote.set_max_power_level( 500_kJ );
    remote.set_power_level( failure == "power" ? 0_kJ : 500_kJ );
    const units::energy power = remote.get_power_level();
    const tripoint_abs_ms position = host.pos_abs();
    const std::string rng = capture_rng_state();
    fixture.run( remote, bionic_switch_request( fixture, remote,
                 failure == "wrong_uid" ? uid + 10 : uid, id, true ), failure != "unauthorized" );
    CHECK( remote.get_power_level() == power );
    CHECK( remote.get_moves() == 100 );
    CHECK( host.pos_abs() == position );
    CHECK_FALSE( host.has_effect( effect_deaf ) );
    CHECK_FALSE( host.has_effect( effect_stunned ) );
    CHECK( capture_rng_state() == rng );
    if( failure == "unauthorized" ) {
        CHECK_FALSE( fixture.reload.refresh_observers );
    }
}

TEST_CASE( "remote_player_bracing_protects_from_shockwave_like_local_bracing", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    const trait_id &brace = trait_LEG_TENT_BRACE;
    remote.set_mutation( brace );
    host.set_mutation( brace );
    REQUIRE( remote.is_barefoot() );
    REQUIRE( host.is_barefoot() );
    const tripoint_abs_ms host_position = host.pos_abs();
    const tripoint_abs_ms remote_position = remote.pos_abs();
    explosion_handler::shockwave( tripoint_bub_ms( 61, 60, 0 ), 3, 4, 2, 8 );
    CHECK( host.pos_abs() == host_position );
    CHECK( remote.pos_abs() == remote_position );
    CHECK_FALSE( host.has_effect( effect_stunned ) );
    CHECK_FALSE( remote.has_effect( effect_stunned ) );
}

namespace
{
void add_magnet_test_item( map &here, const tripoint_bub_ms &position )
{
    item pipe( itype_pipe );
    pipe.set_var( "ccb_magnet_test", 1 );
    here.add_item( position, std::move( pipe ) );
}

int count_magnet_test_items( map &here, const tripoint_bub_ms &origin )
{
    int count = 0;
    for( const tripoint_bub_ms &p : here.points_in_radius( origin, 12 ) ) {
        for( const item &entry : here.i_at( p ) ) {
            if( entry.has_var( "ccb_magnet_test" ) ) {
                count += entry.count();
            }
        }
    }
    return count;
}
}

TEST_CASE( "owned_resonator_changes_terrain_once_and_projects_the_delta", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATIONS", "false" );
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    npc &other = spawn_npc( { 64, 62 }, "test_talker" );
    cata_mp::remote_player_session &observer = bind_feedback_player( other, 'b', 702 );
    const bool local = GENERATE( false, true );
    const tripoint_bub_ms origin( 60, 60, 0 );
    host.setpos( here, local ? origin : tripoint_bub_ms( 30, 30, 0 ) );
    remote.setpos( here, local ? tripoint_bub_ms( 30, 30, 0 ) : origin );
    Character &activator = local ? static_cast<Character &>( host ) : remote;
    const bionic_id &id = bio_resonator;
    const unsigned int uid = prepare_targeted_bionic( activator, id );
    const tripoint_bub_ms door = origin + tripoint::east;
    here.ter_set( door, ter_t_door_c );
    const tripoint_abs_ms absolute = here.get_abs( door );
    cata_mp::serialize_remote_player_state( observer );
    std::string request;
    if( local ) {
        REQUIRE( activator.activate_bionic( **activator.find_bionic_by_uid( uid ) ) );
    } else {
        request = bionic_switch_request( fixture, remote, uid, id, true );
        fixture.run( remote, request );
        CHECK( fixture.reload.refresh_observers );
    }
    CHECK( activator.get_power_level() == 200_kJ - id->power_activate );
    CHECK( activator.get_moves() == 0 );
    CHECK( here.ter( door ) != ter_t_door_c.id() );
    CHECK( here.passable( door ) );
    const ter_id destroyed = here.ter( door );
    if( !local ) {
        const std::string rng = capture_rng_state();
        fixture.run( remote, request );
        CHECK_FALSE( fixture.reload.refresh_observers );
        CHECK( activator.get_power_level() == 200_kJ - id->power_activate );
        CHECK( here.ter( door ) == destroyed );
        CHECK( capture_rng_state() == rng );
    }
    const JsonValue state = json_loader::from_string( cata_mp::serialize_remote_player_state( observer ) );
    const JsonObject data = state.get_object();
    data.allow_omitted_members();
    bool found = false;
    for( const JsonValue &entry : data.get_array( "tile_changes" ) ) {
        const JsonObject tile = entry.get_object();
        tile.allow_omitted_members();
        if( tile.get_int( "x" ) == absolute.x() && tile.get_int( "y" ) == absolute.y() &&
            tile.get_int( "z" ) == absolute.z() ) {
            found = true;
            CHECK( tile.get_string( "ter" ) == destroyed.id().str() );
        }
    }
    CHECK( found );
}

TEST_CASE( "owned_magnet_preserves_item_counts_and_projects_source_and_landing", "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATION_PROJECTILES", "false" );
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    npc &other = spawn_npc( { 64, 65 }, "test_talker" );
    cata_mp::remote_player_session &observer = bind_feedback_player( other, 'b', 702 );
    const bool local = GENERATE( false, true );
    const tripoint_bub_ms origin( 60, 60, 0 );
    host.setpos( here, local ? origin : tripoint_bub_ms( 30, 30, 0 ) );
    remote.setpos( here, local ? tripoint_bub_ms( 30, 30, 0 ) : origin );
    Character &activator = local ? static_cast<Character &>( host ) : remote;
    const bionic_id &id = bio_magnet;
    const unsigned int uid = prepare_targeted_bionic( activator, id );
    const tripoint_bub_ms source = origin + tripoint( 4, 0, 0 );
    const tripoint_bub_ms landing = origin + tripoint::east;
    const tripoint_bub_ms sealed = origin + tripoint( 0, 4, 0 );
    const tripoint_bub_ms distant = origin + tripoint( 12, 0, 0 );
    here.furn_set( sealed, furn_f_crate_c );
    REQUIRE( here.has_flag( ter_furn_flag::TFLAG_SEALED, sealed ) );
    for( const auto &p : { source, source, sealed, distant, origin } ) {
        add_magnet_test_item( here, p );
    }
    const tripoint_bub_ms nonmetal = origin + tripoint( 4, 2, 0 );
    here.add_item( nonmetal, item( itype_rock ) );
    activator.set_wielded_item( item( itype_pipe ) );
    const int64_t wielded_uid = activator.get_wielded_item()->uid().get_value();
    REQUIRE( count_magnet_test_items( here, origin ) == 5 );
    cata_mp::serialize_remote_player_state( observer );
    std::string request;
    if( local ) {
        REQUIRE( activator.activate_bionic( **activator.find_bionic_by_uid( uid ) ) );
    } else {
        request = bionic_switch_request( fixture, remote, uid, id, true );
        fixture.run( remote, request );
        CHECK( fixture.reload.refresh_observers );
    }
    CHECK( activator.get_power_level() == 200_kJ - id->power_activate );
    CHECK( activator.get_moves() == 0 );
    CHECK( activator.get_wielded_item()->uid().get_value() == wielded_uid );
    CHECK( count_magnet_test_items( here, origin ) == 5 );
    for( const auto &p : { source, landing, sealed, distant, origin, nonmetal } ) {
        CHECK( here.i_at( p ).size() == 1 );
    }
    if( !local ) {
        const std::string rng = capture_rng_state();
        fixture.run( remote, request );
        CHECK_FALSE( fixture.reload.refresh_observers );
        CHECK( activator.get_power_level() == 200_kJ - id->power_activate );
        CHECK( here.i_at( source ).size() == 1 );
        CHECK( here.i_at( landing ).size() == 1 );
        CHECK( count_magnet_test_items( here, origin ) == 5 );
        CHECK( capture_rng_state() == rng );
    }
    const JsonValue state = json_loader::from_string( cata_mp::serialize_remote_player_state( observer ) );
    const JsonObject data = state.get_object();
    data.allow_omitted_members();
    int found = 0;
    for( const JsonValue &entry : data.get_array( "tile_changes" ) ) {
        const JsonObject tile = entry.get_object();
        tile.allow_omitted_members();
        for( const auto &p : { source, landing } ) {
            const tripoint_abs_ms absolute = here.get_abs( p );
            if( tile.get_int( "x" ) == absolute.x() && tile.get_int( "y" ) == absolute.y() &&
                tile.get_int( "z" ) == absolute.z() ) {
                ++found;
                CHECK( tile.get_array( "items" ).size() == 1 );
            }
        }
    }
    CHECK( found == 2 );
}

TEST_CASE( "magnetic_attraction_restores_unlaunched_items_when_a_hit_retires_the_operator",
           "[mp_world_bionic]" )
{
    reload_fixture fixture;
    const override_option animations( "ANIMATION_PROJECTILES", "false" );
    map &here = get_map();
    npc &remote = fixture.remote();
    bind_feedback_player( remote, 'a', 701 );
    avatar &victim = get_avatar();
    victim.setpos( here, tripoint_bub_ms( 58, 60, 0 ) );
    victim.set_dodges_left( 0 );
    victim.set_free_dodges_left( 0 );
    victim.set_mutation( trait_HUGE );
    const bionic_id &id = bio_magnet;
    const unsigned int uid = prepare_targeted_bionic( remote, id );
    const tripoint_bub_ms origin = remote.pos_bub();
    for( int x = 52; x <= 56; ++x ) {
        add_magnet_test_item( here, tripoint_bub_ms( x, 60, 0 ) );
    }
    REQUIRE( count_magnet_test_items( here, origin ) == 5 );
    class retire_on_damage : public event_subscriber
    {
        public:
            character_id source;
            character_id target;
            bool retired = false;
            retire_on_damage( character_id source, character_id target ) : source( source ), target( target ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( !retired && event.type() == event_type::character_takes_damage &&
                    event.get<character_id>( "character" ) == target && event.get<int>( "damage" ) > 0 ) {
                    retired = true;
                    g->remove_npc( source );
                }
            }
    } events( remote.getID(), victim.getID() );
    fixture.run( remote, bionic_switch_request( fixture, remote, uid, id, true ) );
    REQUIRE( events.retired );
    CHECK( fixture.reload.refresh_observers );
    CHECK( count_magnet_test_items( here, origin ) == 5 );
    int returned = 0;
    for( int x = 52; x <= 56; ++x ) {
        returned += here.i_at( tripoint_bub_ms( x, 60, 0 ) ).size();
    }
    CHECK( returned > 0 );
    CHECK( returned < 5 );
}
namespace
{
item_location extraction_corpse( Character &who, int charges )
{
    item corpse = item::make_corpse( mon_zombie, calendar::turn );
    corpse.set_var( "remaining_water", charges );
    corpse.set_item_temperature( units::from_celsius( 20 ) );
    return get_map().add_item_or_charges_ret_loc( who.pos_bub(), corpse );
}

std::string water_start_request( reload_fixture &fixture, Character &who, unsigned int uid,
                                 const item_source &corpse )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", bio_water_extractor );
        out.member( "water_corpse", corpse );
    } );
}

std::string water_choice_request( reload_fixture &fixture, Character &who,
                                  const unload_liquid_choice &choice )
{
    return fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "liquid", choice );
        out.member( "allow_consequences", true );
    } );
}
} // namespace

TEST_CASE( "water_extraction_keeps_one_activation_across_containers_and_save", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    avatar &host = get_avatar();
    const unsigned int uid = prepare_targeted_bionic( who, bio_water_extractor );
    prepare_targeted_bionic( host, bio_water_extractor );
    host.set_moves( 517 );
    const item_location corpse = extraction_corpse( who, 7 );
    const item_source source = capture_item_source( who, corpse );
    const std::string start = water_start_request( fixture, who, uid, source );
    fixture.run( who, start );
    REQUIRE( who.activity.id() == ACT_BIONIC_WATER );
    CHECK( who.get_power_level() == 180_kJ );
    fixture.run( who, start );
    CHECK( who.get_power_level() == 180_kJ );
    save_reload_activity( who );
    who.process_activity();
    CHECK( who.get_moves() == 0 );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 7 );
    who.set_moves( 100 );

    who.set_wielded_item( item( itype_bottle_plastic ) );
    item_location bottle = who.get_wielded_item();
    item water( itype_water_clean, calendar::turn, 7 );
    const int capacity = bottle->get_remaining_capacity_for_liquid( water, true );
    REQUIRE( capacity > 0 );
    REQUIRE( capacity < 7 );
    unload_liquid_choice choice;
    choice.source = corpse->uid().get_value();
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, bottle );
    const std::string pour = water_choice_request( fixture, who, choice );
    fixture.run( who, pour );
    CHECK( fixture.reload.refresh_observers );
    REQUIRE_FALSE( bottle->is_container_empty() );
    CHECK( bottle->legacy_front().charges == capacity );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 7 - capacity );
    CHECK( who.get_moves() == 0 );
    CHECK( who.get_power_level() == 180_kJ );
    const std::string rng = capture_rng_state();
    fixture.run( who, pour );
    CHECK_FALSE( fixture.reload.refresh_observers );
    CHECK( capture_rng_state() == rng );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 7 - capacity );
    save_reload_activity( who );

    const tripoint_bub_ms landing = who.pos_bub() + tripoint::east;
    choice.kind = LD_GROUND;
    choice.position = get_map().get_abs( landing );
    who.set_moves( 100 );
    fixture.run( who, water_choice_request( fixture, who, choice ) );
    CHECK_FALSE( who.activity );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 0 );
    int spilled = 0;
    for( const item &entry : get_map().i_at( landing ) ) {
        if( entry.typeId() == itype_water_clean ) {
            spilled += entry.charges;
        }
    }
    CHECK( spilled == 7 - capacity );
    CHECK( who.get_power_level() == 180_kJ );
    CHECK( host.get_power_level() == 200_kJ );
    CHECK( host.get_moves() == 517 );
    CHECK_FALSE( host.activity );
}

TEST_CASE( "water_extraction_cancel_refunds_only_unused_activation", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const unsigned int uid = prepare_targeted_bionic( who, bio_water_extractor );
    const item_location corpse = extraction_corpse( who, 4 );
    fixture.run( who, water_start_request( fixture, who, uid, capture_item_source( who, corpse ) ) );
    const bool extracted = GENERATE( false, true );
    if( extracted ) {
        who.set_wielded_item( item( itype_bottle_plastic ) );
        unload_liquid_choice choice;
        choice.source = corpse->uid().get_value();
        choice.kind = LD_ITEM;
        choice.container = capture_item_source( who, who.get_wielded_item() );
        fixture.run( who, water_choice_request( fixture, who, choice ) );
        REQUIRE( corpse->get_var( "remaining_water", -1 ) < 4 );
    }
    REQUIRE( who.activity );
    save_reload_activity( who );
    const std::string cancel = fixture.request( who, "cancel" );
    fixture.run( who, cancel );
    fixture.run( who, cancel );
    CHECK_FALSE( who.activity );
    CHECK( who.get_power_level() == ( extracted ? 180_kJ : 200_kJ ) );
    if( !extracted ) {
        CHECK( corpse->get_var( "remaining_water", -1 ) == 4 );
    }
}

TEST_CASE( "water_extraction_revalidates_corpse_and_destination_identity", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const bionic_id &type = bio_water_extractor;
    const unsigned int uid = prepare_targeted_bionic( who, type );
    item_location corpse = extraction_corpse( who, 4 );
    const item_source source = capture_item_source( who, corpse );
    fixture.run( who, water_start_request( fixture, who, uid, source ) );
    save_reload_activity( who );
    unload_liquid_choice choice;
    choice.source = source.path.front();
    choice.kind = LD_GROUND;
    choice.position = who.pos_abs();
    const std::string failure = GENERATE( "replaced_corpse", "moved", "removed_bionic",
                                          "host_container", "far_destination", "wrong_corpse", "unauthorized" );
    CAPTURE( failure );
    if( failure == "replaced_corpse" ) {
        corpse.remove_item();
        extraction_corpse( who, 4 );
    } else if( failure == "moved" ) {
        who.setpos( get_map(), who.pos_bub() + tripoint::east );
    } else if( failure == "removed_bionic" ) {
        who.remove_bionic( **who.find_bionic_by_uid( uid ) );
    } else if( failure == "host_container" ) {
        get_avatar().set_wielded_item( item( itype_bottle_plastic ) );
        choice.kind = LD_ITEM;
        choice.container = capture_item_source( get_avatar(), get_avatar().get_wielded_item() );
    } else if( failure == "far_destination" ) {
        choice.position += tripoint( 4, 0, 0 );
    } else if( failure == "wrong_corpse" ) {
        ++choice.source;
    }
    fixture.run( who, water_choice_request( fixture, who, choice ), failure != "unauthorized" );
    if( corpse ) {
        CHECK( corpse->get_var( "remaining_water", -1 ) == 4 );
    }
    if( who.activity ) {
        fixture.run( who, fixture.request( who, "cancel" ) );
    }
    CHECK_FALSE( who.activity );
    CHECK( who.get_power_level() == 200_kJ );
    for( const item &entry : get_map().i_at( get_map().get_bub( source.position ) ) ) {
        CHECK( entry.typeId() != itype_water_clean );
    }
}

TEST_CASE( "water_extraction_drinks_as_owner_and_survives_callback_cancellation", "[mp_bionic_water]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    const unsigned int uid = prepare_targeted_bionic( who, bio_water_extractor );
    const item_location corpse = extraction_corpse( who, 4 );
    fixture.run( who, water_start_request( fixture, who, uid, capture_item_source( who, corpse ) ) );
    class cancel_on_drink : public event_subscriber {
        public:
            Character &who;
            item_location corpse;
            int count = 0;
            cancel_on_drink( Character &who, item_location corpse ) : who( who ), corpse( std::move( corpse ) ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::character_consumes_item ) {
                    ++count;
                    CHECK( event.get<character_id>( "character" ) == who.getID() );
                    CHECK( corpse->get_var( "remaining_water", -1 ) == 0 );
                    who.cancel_activity();
                }
            }
    } observer( who, corpse );
    consumption_events consumption;
    const units::volume stomach = who.stomach.contains();
    const units::volume host_stomach = get_avatar().stomach.contains();
    unload_liquid_choice choice;
    choice.source = corpse->uid().get_value();
    choice.kind = LD_CONSUME;
    const std::string request = water_choice_request( fixture, who, choice );
    fixture.run( who, request );
    REQUIRE( observer.count == 1 );
    CHECK( consumption.actors == std::vector<character_id>{ who.getID() } );
    CHECK_FALSE( who.activity );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 3 );
    CHECK( who.get_power_level() == 180_kJ );
    CHECK( who.stomach.contains() > stomach );
    CHECK( get_avatar().stomach.contains() == host_stomach );
    CHECK( who.get_moves() < 100 );
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( observer.count == 1 );
    CHECK( capture_rng_state() == rng );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 3 );
}

TEST_CASE( "local_water_extraction_preserves_synchronous_pour_and_cancel", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    const unsigned int uid = prepare_targeted_bionic( who, bio_water_extractor );
    const item_location corpse = extraction_corpse( who, 4 );
    bionic_activation_choices choices;
    choices.water_corpse = capture_item_source( who, corpse );
    const bool pour = GENERATE( true, false );
    const restore_on_out_of_scope restore( test_mode_spilling_action );
    test_mode_spilling_action = pour ? test_mode_spilling_action_t::spill_all :
                                test_mode_spilling_action_t::cancel_spill;
    CHECK( who.activate_bionic( **who.find_bionic_by_uid( uid ), false, nullptr, &choices ) == pour );
    CHECK_FALSE( who.activity );
    CHECK( who.get_power_level() == ( pour ? 180_kJ : 200_kJ ) );
    CHECK( corpse->get_var( "remaining_water", -1 ) == ( pour ? 0 : 4 ) );
}

TEST_CASE( "client_water_selection_is_presentation_only_and_receives_remaining_water", "[mp_bionic_water]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const bionic_id &id = bio_water_extractor;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    const item_location corpse = extraction_corpse( who, 4 );
    const std::string result = fixture.run( who, water_start_request( fixture, who, uid,
                                     capture_item_source( who, corpse ) ) );
    avatar &local = get_avatar();
    local.setpos( get_map(), tripoint_bub_ms( 62, 60, 0 ) );
    const unsigned int local_uid = prepare_targeted_bionic( local, id );
    const item_location local_corpse = extraction_corpse( local, 5 );
    bionic_activation_choices choices;
    choices.water_corpse = capture_item_source( local, local_corpse );
    cata_mp::set_client_mode( true );
    const std::string rng = capture_rng_state();
    REQUIRE( local.activate_bionic( **local.find_bionic_by_uid( local_uid ), false, nullptr, &choices ) );
    CHECK( local.get_power_level() == 200_kJ );
    CHECK( local_corpse->get_var( "remaining_water", -1 ) == 5 );
    CHECK( capture_rng_state() == rng );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.pending_request = fixture.sequence;
    REQUIRE( cata_mp::client_apply_message( result ) );
    CHECK( local.activity.execution() == activity_execution::presentation );
    CHECK( view.liquid_source_uid == corpse->uid().get_value() );
    REQUIRE( view.preview );
    CHECK( view.preview->typeId() == itype_water_clean );
    CHECK( view.preview->charges == 4 );
    CHECK( local.get_power_level() == 180_kJ );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "water_extraction_never_duplicates_frozen_water", "[mp_bionic_water]" )
{
    consumption_fixture fixture;
    npc &who = fixture.remote();
    const unsigned int uid = prepare_targeted_bionic( who, bio_water_extractor );
    item_location corpse = extraction_corpse( who, 4 );
    corpse->set_item_temperature( units::from_celsius( -20 ) );
    fixture.run( who, water_start_request( fixture, who, uid, capture_item_source( who, corpse ) ) );
    const auto *actor = dynamic_cast<bionic_water_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    const auto preview = actor->preview( who );
    REQUIRE( preview );
    REQUIRE_FALSE( preview->made_of( phase_id::LIQUID ) );
    who.set_wielded_item( item( itype_bottle_plastic ) );
    const units::volume stomach = who.stomach.contains();
    consumption_events events;
    unload_liquid_choice choice;
    choice.source = corpse->uid().get_value();
    choice.kind = GENERATE( LD_ITEM, LD_GROUND, LD_CONSUME );
    choice.container = capture_item_source( who, who.get_wielded_item() );
    choice.position = who.pos_abs();
    fixture.run( who, water_choice_request( fixture, who, choice ) );
    CHECK_FALSE( who.activity );
    CHECK( who.get_power_level() == 200_kJ );
    CHECK( who.get_moves() == 100 );
    CHECK( corpse->get_var( "remaining_water", -1 ) == 4 );
    CHECK( who.get_wielded_item()->is_container_empty() );
    CHECK( who.charges_of( itype_water_clean ) == 0 );
    CHECK( who.stomach.contains() == stomach );
    CHECK( events.actors.empty() );
    for( const item &entry : get_map().i_at( who.pos_bub() ) ) {
        CHECK( entry.typeId() != itype_water_clean );
    }
}

namespace
{
struct vehicle_control_fixture : reload_fixture {
    vehicle_control_fixture() {
        // clear_avatar() clears items/body but does not reset driving flags.
        get_avatar().controlling_vehicle = false;
        get_avatar().in_vehicle = false;
    }
    ~vehicle_control_fixture() {
        get_avatar().controlling_vehicle = false;
        get_avatar().in_vehicle = false;
    }
};

vehicle &owned_test_vehicle( Character &who, const tripoint_bub_ms &position,
                             const std::string &prototype = "car" )
{
    map &here = get_map();
    vehicle *target = here.add_vehicle( vproto_id( prototype ), position, 0_degrees, 100,
                                        veh_spawn_status::UNDAMAGED );
    REQUIRE( target );
    target->is_locked = false;
    target->engine_on = false;
    target->set_owner( who.get_faction()->id );
    for( const vpart_reference &part : target->get_avail_parts( "CONTROLS" ) ) {
        who.setpos( here, part.pos_bub( here ) );
        return *target;
    }
    FAIL( "fixture vehicle needs controls" );
    return *target;
}

vehicle_control_selection control_choice( const Character &who, const vehicle &target,
        const std::string &action )
{
    vehicle_control_selection choice;
    choice.vehicle_id = target.uid().get_value();
    choice.position = who.pos_abs();
    choice.action = action;
    return choice;
}

vehicle &owned_foldable_vehicle( Character &who, const tripoint_bub_ms &position )
{
    map &here = get_map();
    vehicle *target = here.add_vehicle( vehicle_prototype_none, position, 0_degrees, 0,
                                        veh_spawn_status::UNDAMAGED, false );
    REQUIRE( target );
    REQUIRE( target->restore_folded_parts( item( itype_folded_bicycle ) ) );
    target->name = "folding fixture";
    target->set_owner( who );
    here.add_vehicle_to_cache( target );
    REQUIRE( target->is_foldable() );
    return *target;
}

std::string control_request( reload_fixture &fixture, Character &who,
                             const vehicle_control_selection &choice )
{
    return fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "vehicle_control" );
        out.member( "vehicle_control", choice );
    } );
}
} // namespace

TEST_CASE( "owned_vehicle_folding_retains_operator_vehicle_and_part_identity",
           "[mp_inventory_activity][vehicle_fold_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
    const tripoint_bub_ms position = who.pos_bub() + tripoint::east;
    vehicle &target = owned_foldable_vehicle( who, position );
    const int64_t original_id = target.uid().get_value();
    vehicle_control_selection choice = control_choice( who, target, "fold" );
    choice.position = here.get_abs( position );
    const std::string request = control_request( fixture, who, choice );
    fixture.run( who, request );
    REQUIRE( who.activity.id() == ACT_VEHICLE_FOLD );
    const int original_time = who.activity.moves_left;
    fixture.run( who, request ); // A replay must not restart the job.
    CHECK( who.activity.moves_left == original_time );
    save_reload_activity( who );
    bool fold = true;
    int64_t replacement_id = 0;
    SECTION( "same saved operator and vehicle" ) {}
    SECTION( "another vehicle replaces it at the same tile" ) {
        fold = false;
        here.destroy_vehicle( &target );
        replacement_id = owned_foldable_vehicle( who, position ).uid().get_value();
    }
    SECTION( "anchor part replaced without changing its type" ) {
        fold = false;
        item replacement( target.part( 0 ).get_base() );
        target.part( 0 ).set_base( std::move( replacement ) );
    }
    SECTION( "vehicle moved away" ) {
        fold = false;
        here.displace_vehicle( target, tripoint_rel_ms( 4, 0, 0 ) );
    }
    SECTION( "operator moved out of reach" ) {
        fold = false;
        who.setpos( here, who.pos_bub() + tripoint( 10, 0, 0 ), false );
    }
    SECTION( "vehicle locked after work began" ) {
        fold = false;
        target.is_locked = true;
    }
    SECTION( "a copied activity cannot fold for another body" ) {
        npc &other = fixture.remote();
        other.setpos( here, who.pos_bub() + tripoint::south, false );
        other.activity = who.activity;
        other.activity.actor->finish( other.activity, other );
        CHECK_FALSE( other.activity );
        REQUIRE( vehicle::find_vehicle_by_uid( here, original_id ) );
        CHECK( here.i_at( position ).empty() );
    }
    SECTION( "legacy position-only activity does not adopt a replacement" ) {
        fold = false;
        std::ostringstream stream;
        JsonOut out( stream );
        out.start_object();
        out.member( "target_pos", position );
        out.member( "folding_time", target.folding_time() );
        out.end_object();
        JsonValue value = json_loader::from_string( stream.str() );
        const auto legacy = vehicle_folding_activity_actor::deserialize( value );
        who.activity = player_activity( *legacy );
    }
    REQUIRE( who.activity.actor );
    who.activity.actor->finish( who.activity, who );
    CHECK_FALSE( who.activity );
    CHECK( here.i_at( position ).size() == ( fold ? 1 : 0 ) );
    if( fold ) {
        CHECK_FALSE( vehicle::find_vehicle_by_uid( here, original_id ) );
        REQUIRE( here.i_at( position ).begin()->typeId() == itype_generic_folded_vehicle );
    } else {
        CHECK( vehicle::find_vehicle_by_uid( here, replacement_id ? replacement_id : original_id ) );
    }
}

TEST_CASE( "folding_settles_cargo_and_vehicle_before_drop_callbacks_can_replace_work",
           "[mp_inventory_activity][vehicle_fold_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
    const tripoint_bub_ms position = who.pos_bub() + tripoint::east;
    vehicle &target = owned_foldable_vehicle( who, position );
    const int64_t original_id = target.uid().get_value();
    const auto cargo_parts = target.get_any_parts( VPFLAG_CARGO );
    REQUIRE_FALSE( empty( cargo_parts ) );
    const vpart_reference cargo = *cargo_parts.begin();
    REQUIRE( target.add_item( here, cargo.part(), item( itype_rock ) ) );
    vehicle_control_selection choice = control_choice( who, target, "fold" );
    choice.position = here.get_abs( position );
    fixture.run( who, control_request( fixture, who, choice ) );
    REQUIRE( who.activity.id() == ACT_VEHICLE_FOLD );
    bool folded = true;
    bool destroyed_by_callback = false;
    SECTION( "cargo consumption interrupts folding without duplicating the cargo" ) {
        folded = false;
        who.set_value( "fold_drop_mode", "interrupt" );
    }
    SECTION( "a cargo callback destroys the source vehicle" ) {
        folded = false;
        destroyed_by_callback = true;
        who.set_value( "fold_drop_mode", "destroy" );
    }
    SECTION( "packed vehicle callback sees the old vehicle already removed" ) {
        who.set_value( "fold_drop_mode", "packed" );
    }
    itype &rock = *const_cast<itype *>( item::find_type( itype_rock ) );
    const restore_on_out_of_scope restore_rock( rock.drop_action );
    rock.drop_action = use_function( "folding_cargo_drop", []( Character *actor, item *,
                                     const tripoint_bub_ms &position ) -> std::optional<int> {
                                         actor->set_value( "fold_cargo_seen", "yes" );
                                         const std::string mode = actor->get_value( "fold_drop_mode" ).str();
    if( mode == "interrupt" ) {
    actor->assign_activity( player_activity( ACT_WAIT, 100 ) );
    } else if( mode == "destroy" ) {
    const optional_vpart_position target = get_map().veh_at( position );
        REQUIRE( target );
        get_map().destroy_vehicle( &target->vehicle() );
    }
    return 1;
                                     } );
    itype &packed = *const_cast<itype *>( item::find_type( itype_generic_folded_vehicle ) );
    const restore_on_out_of_scope restore_packed( packed.drop_action );
    packed.drop_action = use_function( "folding_packed_drop", []( Character *actor, item *,
                                       const tripoint_bub_ms &position ) -> std::optional<int> {
                                           CHECK_FALSE( get_map().veh_at( position ) );
                                           actor->set_value( "fold_packed_seen", "yes" );
                                           actor->assign_activity( player_activity( ACT_WAIT, 100 ) );
                                           return std::nullopt;
                                       } );
    const int host_moves = host.get_moves();
    who.activity.actor->finish( who.activity, who );
    CHECK( who.get_value( "fold_cargo_seen" ).str() == "yes" );
    CHECK( host.get_moves() == host_moves );
    CHECK( here.i_at( position ).size() == ( folded ? 1 : 0 ) );
    if( folded ) {
        CHECK( who.get_value( "fold_packed_seen" ).str() == "yes" );
        CHECK_FALSE( vehicle::find_vehicle_by_uid( here, original_id ) );
    } else if( !destroyed_by_callback ) {
        REQUIRE( vehicle::find_vehicle_by_uid( here, original_id ) );
        CHECK( cargo.items().empty() );
    }
    if( !destroyed_by_callback ) {
        CHECK( who.activity.id() == ACT_WAIT );
    }
}

TEST_CASE( "owned_unfolding_keeps_one_detached_item_and_checks_without_world_or_rng_changes",
           "[mp_inventory_activity][vehicle_fold_owned][rng]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
    item folded( itype_folded_bicycle );
    folded.set_damage( 1000 );
    who.set_wielded_item( folded );
    const item_source source = capture_item_source( who, who.get_wielded_item() );
    const tripoint_bub_ms origin = who.pos_bub();
    const size_t vehicles = here.get_vehicles().size();
    const uint64_t routing = here.pathfinding_cache_revision();
    const std::string start = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", source );
        out.member( "item_type", "folded_bicycle" );
        out.member( "method", "UNFOLD_GENERIC" );
        out.member( "target", who.pos_abs() );
    } );
    fixture.run( who, start );
    REQUIRE( who.activity.id() == ACT_VEHICLE_UNFOLD );
    CHECK_FALSE( who.get_wielded_item() );
    CHECK( here.get_vehicles().size() == vehicles );
    CHECK( here.pathfinding_cache_revision() == routing );
    // Native activity-start callbacks run gameplay effects. The detached
    // layout check itself must be pure, independently of those callbacks.
    const std::string rng = capture_rng_state();
    who.activity.actor->start( who.activity, who );
    CHECK( capture_rng_state() == rng );
    save_reload_activity( who );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    calendar::turn = calendar::turn_zero + 60_seconds;
    who.activity.actor->do_turn( who.activity, who );
    CHECK( here.get_vehicles().size() == vehicles );
    CHECK( here.pathfinding_cache_revision() == routing );
    CHECK( capture_rng_state() == rng );
    bool unfold = true;
    SECTION( "saved owner completes the native unfold" ) {}
    SECTION( "operator moves before completion" ) {
        unfold = false;
        who.setpos( here, origin + tripoint( 5, 0, 0 ), false );
    }
    SECTION( "placement becomes blocked" ) {
        unfold = false;
        here.ter_set( origin + tripoint::east, ter_id( "t_wall" ) );
    }
    SECTION( "another body cannot publish or cancel the owned item" ) {
        npc &other = fixture.remote();
        other.setpos( here, origin + tripoint( 5, 0, 0 ), false );
        other.activity = who.activity;
        other.activity.actor->do_turn( other.activity, other );
        CHECK_FALSE( other.activity );
        CHECK( here.i_at( other.pos_bub() ).empty() );
        CHECK( here.get_vehicles().size() == vehicles );
    }
    who.activity.moves_left = 1;
    who.set_moves( 1000 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    CHECK_FALSE( who.activity );
    fixture.run( who, step ); // The consumed escrow cannot be replayed.
    CHECK( here.get_vehicles().size() == vehicles + ( unfold ? 1 : 0 ) );
    if( unfold ) {
        REQUIRE( here.veh_at( origin ) );
        CHECK( here.veh_at( origin )->vehicle().is_owned_by( who ) );
        CHECK( here.i_at( origin ).empty() );
    } else {
        REQUIRE( here.i_at( who.pos_bub() ).size() == 1 );
        CHECK( here.i_at( who.pos_bub() ).begin()->typeId() == itype_folded_bicycle );
        CHECK( here.i_at( who.pos_bub() ).begin()->damage() == 1000 );
    }
}

TEST_CASE( "unfold_start_events_cannot_leave_a_second_folded_source",
           "[mp_inventory_activity][vehicle_fold_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
    who.set_wielded_item( item( itype_folded_bicycle ) );
    class cancel_on_unfold : public event_subscriber {
        public:
            Character &who;
            bool fired = false;
            explicit cancel_on_unfold( Character &who ) : who( who ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( fired || event.type() != event_type::character_starts_activity ||
                    event.get<character_id>( "character" ) != who.getID() ||
                    who.activity.id() != ACT_VEHICLE_UNFOLD ) {
                    return;
                }
                fired = true;
                CHECK_FALSE( who.get_wielded_item() );
                who.cancel_activity();
                who.assign_activity( player_activity( ACT_WAIT, 100 ) );
            }
    } events( who );
    REQUIRE( iuse::unfold_generic( &who, who.get_wielded_item().get_item(), who.pos_bub() ) );
    REQUIRE( events.fired );
    CHECK( who.activity.id() == ACT_WAIT );
    CHECK_FALSE( who.get_wielded_item() );
    CHECK( here.get_vehicles().empty() );
    REQUIRE( here.i_at( who.pos_bub() ).size() == 1 );
    CHECK( here.i_at( who.pos_bub() ).begin()->typeId() == itype_folded_bicycle );
}

TEST_CASE( "owned_vehicle_start_uses_native_time_survives_save_and_releases_without_unboarding",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    const int host_moves = host.get_moves();
    const int battery = target.fuel_left( here, itype_battery );
    const std::string request = control_request( fixture, who, control_choice( who, target, "take" ) );
    fixture.run( who, request );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( who.activity.id() == ACT_START_ENGINES );
    REQUIRE( who.activity.moves_left > 1 );
    CHECK_FALSE( target.engine_on );
    CHECK( target.fuel_left( here, itype_battery ) == battery );
    CHECK( who.controlling_vehicle );
    CHECK( who.in_vehicle );
    CHECK_FALSE( host.controlling_vehicle );
    CHECK_FALSE( host.activity );
    // Engine starting is time-based. Save the pending native activity before
    // advancing a world turn, which may legitimately complete a warm engine.
    const int total = who.activity.moves_left;
    save_reload_activity( who );
    CHECK( who.activity.moves_left == total );
    const int left = who.activity.moves_left;
    fixture.run( who, request );
    CHECK( who.activity.moves_left == left );
    who.set_moves( 100000 );
    const std::string step = fixture.request( who, "step" );
    const size_t messages_before_start = recipient.feedback.pending.size();
    fixture.run( who, step );
    REQUIRE_FALSE( who.activity );
    REQUIRE( target.engine_on );
    CHECK( recipient.feedback.pending.size() == messages_before_start + 1 );
    const int after_start = target.fuel_left( here, itype_battery );
    fixture.run( who, step );
    CHECK( target.fuel_left( here, itype_battery ) == after_start );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "release" ) ) );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK( who.in_vehicle );
    CHECK( target.engine_on );
    CHECK( target.get_passenger( here.veh_at( who.pos_bub() )->part_index() ) == &who );
    CHECK( host.get_moves() == host_moves );
}

TEST_CASE( "owned_vehicle_controls_reject_wrong_identity_and_competing_driver",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    vehicle_control_selection choice = control_choice( who, target, "take" );
    SECTION( "wrong vehicle identity" ) {
        ++choice.vehicle_id;
    }
    SECTION( "out of reach controls" ) {
        who.setpos( here, who.pos_bub() + tripoint_rel_ms( 6, 0, 0 ) );
    }
    SECTION( "another player already driving" ) {
        avatar &host = get_avatar();
        host.setpos( here, who.pos_bub() );
        host.controlling_vehicle = true;
    }
    SECTION( "locked vehicle" ) {
        target.is_locked = true;
    }
    const std::string before = capture_rng_state();
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK_FALSE( target.engine_on );
    CHECK( capture_rng_state() == before );
}

TEST_CASE( "owned_vehicle_start_cancels_when_controls_are_lost_or_vehicle_replaced",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "take" ) ) );
    REQUIRE( who.activity );
    SECTION( "player cancels startup" ) {
        fixture.run( who, fixture.request( who, "cancel" ) );
        CHECK_FALSE( who.controlling_vehicle );
        CHECK( who.in_vehicle );
        CHECK_FALSE( target.engine_on );
    }
    SECTION( "controls disappear" ) {
        for( const vpart_reference &part : target.get_avail_parts( "CONTROLS" ) ) {
            target.set_hp( part.part(), 0, false );
        }
        who.set_moves( 100000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( target.engine_on );
    }
    SECTION( "replacement vehicle must not inherit cranking" ) {
        const tripoint_bub_ms original = target.pos_bub( here );
        here.destroy_vehicle( &target );
        vehicle &replacement = owned_test_vehicle( who, original );
        who.set_moves( 100000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( replacement.engine_on );
    }
    CHECK_FALSE( who.activity );
}

TEST_CASE( "native_engine_start_checks_actual_driver_limbs",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ), "bicycle" );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    REQUIRE_FALSE( target.engines.empty() );
    vehicle_part &engine = target.part( target.engines.front() );
    engine.enabled = true;
    who.set_part_hp_cur( bodypart_id( "leg_l" ), 0 );
    who.set_part_hp_cur( bodypart_id( "leg_r" ), 0 );
    CHECK_FALSE( target.start_engine( here, engine, who ) );
    who.set_part_hp_cur( bodypart_id( "leg_l" ), who.get_part_hp_max( bodypart_id( "leg_l" ) ) );
    who.set_part_hp_cur( bodypart_id( "leg_r" ), who.get_part_hp_max( bodypart_id( "leg_r" ) ) );
    host.set_part_hp_cur( bodypart_id( "leg_l" ), 0 );
    host.set_part_hp_cur( bodypart_id( "leg_r" ), 0 );
    CHECK( target.start_engine( here, engine, who ) );
}

TEST_CASE( "vehicle_start_client_view_never_executes_native_start",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    avatar &who = get_avatar();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    who.set_moves( 100 );
    cata_mp::set_client_mode( true );
    const std::string before = capture_rng_state();
    const std::string action = GENERATE( "take", "hotwire", "autopilot_follow", "autopilot_patrol",
                                         "precollision_off" );
    const bool hotwire = action == "hotwire";
    target.is_locked = hotwire;
    CHECK( cata_mp::client_vehicle_control( control_choice( who, target, action ) ) );
    REQUIRE( cata_mp::inventory_activity_view( who.activity ) );
    who.activity.do_turn( who );
    CHECK( target.is_locked == hotwire );
    CHECK_FALSE( target.engine_on );
    CHECK_FALSE( target.is_following );
    CHECK_FALSE( target.is_patrolling );
    CHECK( target.precollision_on );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK( capture_rng_state() == before );
}

TEST_CASE( "remote_vehicle_binding_is_per_character_and_rejects_replacement_identity",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    avatar &host = get_avatar();
    npc &remote = fixture.remote();
    vehicle &first = owned_test_vehicle( host, tripoint_bub_ms( 45, 45, 0 ) );
    vehicle &second = owned_test_vehicle( remote, tripoint_bub_ms( 65, 65, 0 ) );
    for( vehicle *target : { &first, &second } ) {
        REQUIRE( target->install_part( here, point_rel_ms::zero,
                                       vpart_drive_by_wire_controls ) >= 0 );
    }
    for( Character *who : { static_cast<Character *>( &host ), static_cast<Character *>( &remote ) } ) {
        item controller( itype_remotevehcontrol );
        controller.active = true;
        who->set_wielded_item( controller );
    }
    REQUIRE( set_remote_vehicle( host, here, &first ) );
    REQUIRE( set_remote_vehicle( remote, here, &second ) );
    CHECK( get_remote_vehicle( host, here ) == &first );
    CHECK( get_remote_vehicle( remote, here ) == &second );
    CHECK_FALSE( first.remote_controlled( remote ) );
    const std::string before = capture_rng_state();
    CHECK( resolve_remote_vehicle( host, here ) == &first );
    CHECK( capture_rng_state() == before );
    SECTION( "old bubble-coordinate save migrates to identity" ) {
        set_remote_vehicle( remote, here, nullptr );
        remote.set_value( "remote_controlling_vehicle", tripoint_abs_ms( second.pos_bub( here ).raw() ) );
        REQUIRE( get_remote_vehicle( remote, here ) == &second );
        CHECK_FALSE( remote.maybe_get_value( "remote_controlling_vehicle" ) );
        CHECK( remote.maybe_get_value( "remote_vehicle_uid" ) );
    }
    SECTION( "stale position hint cannot select another vehicle" ) {
        remote.set_value( "remote_vehicle_position", first.pos_abs() );
        CHECK( get_remote_vehicle( remote, here ) == &second );
    }
    SECTION( "replaced vehicle does not inherit binding" ) {
        const tripoint_bub_ms position = second.pos_bub( here );
        here.destroy_vehicle( &second );
        owned_test_vehicle( remote, position );
        CHECK( get_remote_vehicle( remote, here ) == nullptr );
    }
    SECTION( "one disconnected controller does not clear the other" ) {
        remote.get_wielded_item()->active = false;
        CHECK( get_remote_vehicle( remote, here ) == nullptr );
    }
    CHECK( get_remote_vehicle( host, here ) == &first );
}

TEST_CASE( "vehicle_start_assignment_handles_removed_owner_or_vehicle",
           "[multiplayer][vehicle_control_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    const bool retire_owner = GENERATE( false, true );
    class remove_on_start : public event_subscriber
    {
        public:
            character_id owner;
            vehicle *target;
            bool retire;
            bool fired = false;
            remove_on_start( character_id owner, vehicle *target, bool retire ) :
                owner( owner ), target( target ), retire( retire ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( !fired && event.type() == event_type::character_starts_activity &&
                    event.get<character_id>( "character" ) == owner ) {
                    fired = true;
                    if( retire ) {
                        g->remove_npc( owner );
                    } else {
                        get_map().destroy_vehicle( target );
                    }
                }
            }
    } events( who.getID(), &target, retire_owner );
    const std::string reply = fixture.run( who, control_request( fixture, who,
                                           control_choice( who, target, "take" ) ) );
    REQUIRE( events.fired );
    if( retire_owner ) {
        CHECK( reply.empty() );
        CHECK_FALSE( target.engine_on );
    } else {
        who.set_moves( 100000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( who.controlling_vehicle );
    }
}

TEST_CASE( "vehicle_muscle_power_and_training_belong_to_the_seated_driver",
           "[multiplayer][vehicle_driving_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    avatar &host = get_avatar();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( host, tripoint_bub_ms( 60, 60, 0 ), "bicycle" );
    const tripoint_bub_ms controls = host.pos_bub();
    const proficiency_id &driving = proficiency_prof_driver;
    const float host_training = host.get_proficiency_practice( driving );
    const int host_stamina = host.get_stamina();
    // Merely standing over the pedals does not provide a body's fuel or training.
    CHECK( target.fuel_left( here, itype_muscle ) == 0 );
    target.consume_fuel( here, 1000, false );
    CHECK( host.get_proficiency_practice( driving ) == host_training );
    CHECK( host.get_stamina() == host_stamina );

    host.setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    who.setpos( here, controls );
    here.board_vehicle( controls, &who );
    who.controlling_vehicle = true;
    target.engine_on = true;
    REQUIRE( target.get_driver( here ) == &who );
    REQUIRE( vehicle_operator( target, here ) == &who );
    REQUIRE( target.fuel_left( here, itype_muscle ) > 0 );
    const float training = who.get_proficiency_practice( driving );
    const int stamina = who.get_stamina();
    target.consume_fuel( here, 1000, false );
    CHECK( who.get_stamina() < stamina );
    CHECK( who.get_proficiency_practice( driving ) > training );
    CHECK( host.get_stamina() == host_stamina );
    CHECK( host.get_proficiency_practice( driving ) == host_training );

    who.controlling_vehicle = false;
    const int released_stamina = who.get_stamina();
    const float released_training = who.get_proficiency_practice( driving );
    target.consume_fuel( here, 1000, false );
    CHECK( who.get_stamina() == released_stamina );
    CHECK( who.get_proficiency_practice( driving ) == released_training );
    CHECK( vehicle_operator( target, here ) == nullptr );
}

TEST_CASE( "vehicle_cruise_and_idle_recognize_seated_and_remote_players",
           "[multiplayer][vehicle_driving_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    get_avatar().setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    const bool remote_control = GENERATE( false, true );
    if( remote_control ) {
        REQUIRE( target.install_part( here, point_rel_ms::zero,
                                      vpart_drive_by_wire_controls ) >= 0 );
        item controller( itype_remotevehcontrol );
        controller.active = true;
        who.set_wielded_item( controller );
        who.setpos( here, tripoint_bub_ms( 50, 50, 0 ) );
        REQUIRE( set_remote_vehicle( who, here, &target ) );
        REQUIRE( target.get_driver( here ) == nullptr );
    } else {
        here.board_vehicle( who.pos_bub(), &who );
        who.controlling_vehicle = true;
    }
    REQUIRE( controlled_vehicle( who, here ) == &target );
    target.engine_on = true;
    REQUIRE( adjust_vehicle_cruise( who, here, -1 ) );
    REQUIRE( target.cruise_velocity > 0 );
    const int stamina = who.get_stamina();
    target.gain_moves( here );
    CHECK( target.velocity > 0 );
    REQUIRE_FALSE( target.fuel_used_last_turn.empty() );
    const auto used = target.fuel_used_last_turn;
    target.idle( here, true );
    CHECK( target.fuel_used_last_turn == used );
    CHECK( who.get_stamina() == stamina );
    CHECK( who.get_proficiency_practice( proficiency_prof_driver ) > 0.0f );
    CHECK( get_avatar().get_proficiency_practice( proficiency_prof_driver ) == 0.0f );

    const JsonValue snapshot = json_loader::from_string(
                              cata_mp::serialize_remote_player_state( only_test_remote( g->multiplayer_session() ) ) );
    const JsonObject state = snapshot.get_object();
    state.allow_omitted_members();
    CHECK( state.get_bool( "client_ctrl_veh" ) );
    const JsonObject vehicle_position = state.get_object( "client_veh_pos" );
    vehicle_position.allow_omitted_members();
    CHECK( vehicle_position.get_int( "x" ) == target.pos_abs().x() );
}

TEST_CASE( "vehicle_driving_intents_reject_unowned_controls_and_mutation_uploads",
           "[multiplayer][vehicle_driving_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    g->multiplayer_session().host_mode = true;
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    get_avatar().setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    recipient.turn.granted_this_turn = true;
    const auto send = [&]( const std::string &action, const point &delta ) {
        std::ostringstream stream;
        JsonOut out( stream );
        out.start_object();
        out.member( "type", "action" );
        out.member( "action", action );
        out.member( "dx", delta.x );
        out.member( "dy", delta.y );
        out.member( "grant_seq", recipient.turn.grant_seq );
        out.member( "char_stats" );
        out.start_object();
        out.member( "str", 999 );
        out.end_object();
        out.end_object();
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                               stream.str(), recipient.admission } ) );
        cata_mp::process_mp_events();
    };
    const int strength = who.get_str_base();
    const std::string rng_before = capture_rng_state();
    send( "cruise", point::north );
    send( "pldrive", point::east );
    send( "handbrake", point::zero );
    CHECK( target.cruise_velocity == 0 );
    CHECK( recipient.turn.remote_moves == 100 );
    CHECK( capture_rng_state() == rng_before );
    CHECK( who.get_str_base() == strength );

    here.board_vehicle( who.pos_bub(), &who );
    who.controlling_vehicle = true;
    target.engine_on = true;
    send( "cruise", point( 0, std::numeric_limits<int>::min() ) );
    send( "pldrive", point( 99, 0 ) );
    CHECK( target.cruise_velocity == 0 );
    CHECK( capture_rng_state() == rng_before );
    send( "cruise", point::north );
    REQUIRE( target.cruise_velocity > 0 );
    CHECK( recipient.turn.remote_moves == 100 );
    CHECK( who.get_str_base() == strength );
    target.is_on_ramp = true;
    send( "pldrive", point::east );
    CHECK( recipient.turn.remote_moves == 100 );
    CHECK( capture_rng_state() == rng_before );
    target.is_on_ramp = false;
    send( "pldrive", point::east );
    CHECK( recipient.turn.remote_moves < 100 );
    CHECK( who.get_moves() == recipient.turn.remote_moves );
    CHECK( who.get_str_base() == strength );
    next_test_remote_turn( recipient );
    target.last_turn = 0_degrees;
    target.velocity = 2000;
    send( "handbrake", point::zero );
    CHECK( target.cruise_velocity == 0 );
    CHECK( target.velocity == 0 );
    CHECK( recipient.turn.remote_moves == 0 );
    CHECK( who.get_moves() == 0 );
    CHECK( recipient.turn.client_acted_this_turn );
    const std::string after_brake = capture_rng_state();
    send( "cruise", point::north );
    CHECK( target.cruise_velocity == 0 );
    CHECK( capture_rng_state() == after_brake );
}

TEST_CASE( "remote_driving_feedback_and_sinking_do_not_depend_on_the_host",
           "[multiplayer][vehicle_driving_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    here.board_vehicle( who.pos_bub(), &who );
    who.controlling_vehicle = true;
    get_avatar().setpos( here, tripoint_bub_ms( 100, 100, 0 ) );
    SECTION( "thrust failure reaches its operator" ) {
        target.engine_on = false;
        target.cruise_velocity = 400;
        const std::string::size_type count = recipient.feedback.pending.size();
        target.thrust( here, 1 );
        CHECK( recipient.feedback.pending.size() > count );
    }
    SECTION( "standing at controls still permits driving without boarding" ) {
        here.unboard_vehicle( who.pos_bub() );
        who.controlling_vehicle = true;
        REQUIRE_FALSE( who.in_vehicle );
        CHECK( controlled_vehicle( who, here ) == &target );
        CHECK( drive_vehicle( who, here, tripoint_rel_ms( 0, -1, 0 ) ) );
        CHECK( target.cruise_velocity > 0 );
    }
    SECTION( "broken driving controls stop accepting input" ) {
        const int controls = target.avail_part_with_feature( here.veh_at( who.pos_bub() )->part_index(),
                             VPFLAG_CONTROLS );
        REQUIRE( controls >= 0 );
        target.set_hp( target.part( controls ), 0, false );
        const std::string before = capture_rng_state();
        CHECK_FALSE( drive_vehicle( who, here, tripoint_rel_ms( 1, 0, 0 ) ) );
        CHECK( capture_rng_state() == before );
        CHECK_FALSE( who.controlling_vehicle );
    }
    SECTION( "sinking unboards remote passengers even after releasing controls" ) {
        who.controlling_vehicle = false;
        const int64_t id = target.uid().get_value();
        for( const tripoint_abs_ms &position : target.get_points() ) {
            here.ter_set( here.get_bub( position ), ter_id( "t_water_dp" ) );
        }
        target.check_falling_or_floating();
        REQUIRE_FALSE( target.can_float( here ) );
        CHECK( target.act_on_map( here ) == nullptr );
        CHECK_FALSE( who.in_vehicle );
        CHECK_FALSE( who.controlling_vehicle );
        CHECK( vehicle::find_vehicle_by_uid( here, id ) == nullptr );
    }
}

TEST_CASE( "owned_hotwire_uses_operator_skill_time_save_and_replay",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    target.is_locked = true;
    who.i_add( item( itype_screwdriver ) );
    who.set_skill_level( skill_mechanics, 8 );
    who.set_moves( 100 );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    const int host_moves = host.get_moves();
    const std::string request = control_request( fixture, who, control_choice( who, target, "hotwire" ) );
    fixture.run( who, request );
    REQUIRE( who.activity.id() == ACT_HOTWIRE_CAR );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( who.activity.moves_total == to_moves<int>( 750_seconds ) );
    save_reload_activity( who );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( who.activity.moves_left == to_moves<int>( 750_seconds ) - 100 );
    CHECK( target.is_locked );
    CHECK( host.get_moves() == host_moves );
    CHECK_FALSE( host.activity );
    who.set_moves( who.activity.moves_left );
    const std::string finish = fixture.request( who, "step" );
    fixture.run( who, finish );
    REQUIRE_FALSE( who.activity );
    CHECK_FALSE( target.is_locked );
    CHECK_FALSE( target.engine_on );
    const std::string after = capture_rng_state();
    fixture.run( who, finish );
    CHECK( capture_rng_state() == after );
}

TEST_CASE( "owned_hotwire_cancels_lost_tools_controls_and_replaced_vehicles",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    target.is_locked = true;
    // Prototype cargo can supply extra screwdrivers. This case removes the
    // only available tool, rather than merely the operator's personal one.
    for( const vpart_reference &part : target.get_avail_parts( "CARGO" ) ) {
        target.get_items( part.part() ).clear();
    }
    item_location tool = who.i_add( item( itype_screwdriver ) );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "hotwire" ) ) );
    REQUIRE( who.activity.id() == ACT_HOTWIRE_CAR );
    SECTION( "tool removed" ) {
        tool.remove_item();
        who.invalidate_crafting_inventory();
        REQUIRE_FALSE( who.crafting_inventory( &here ).has_quality( qual_SCREW ) );
    }
    SECTION( "operator moved away" ) {
        who.setpos( here, tripoint_bub_ms( 80, 80, 0 ) );
    }
    SECTION( "controls destroyed" ) {
        const int controls = target.avail_part_with_feature( here.veh_at( who.pos_bub() )->part_index(),
                             VPFLAG_CONTROLS );
        REQUIRE( controls >= 0 );
        target.set_hp( target.part( controls ), 0, false );
    }
    SECTION( "vehicle replaced at the same coordinates" ) {
        const tripoint_bub_ms position = target.pos_bub( here );
        here.destroy_vehicle( &target );
        vehicle &replacement = owned_test_vehicle( who, position );
        replacement.is_locked = true;
        save_reload_activity( who );
    }
    who.set_moves( 1000000 );
    const std::string before = capture_rng_state();
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( capture_rng_state() == before );
    for( const wrapped_vehicle &entry : here.get_vehicles() ) {
        CHECK( entry.v->is_locked );
        CHECK_FALSE( entry.v->engine_on );
    }
}

TEST_CASE( "owned_engine_configuration_validates_all_choices_before_applying",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    REQUIRE_FALSE( target.engines.empty() );
    vehicle_part &engine = target.part( target.engines.front() );
    engine.enabled = true;
    target.engine_on = true;
    vehicle_control_selection selection = control_choice( who, target, "engines" );
    selection.engines.push_back( { engine.get_base().uid().get_value(), engine.fuel_current().str(), false } );
    SECTION( "stale part after a valid choice" ) {
        selection.engines.push_back( { std::numeric_limits<int64_t>::max(), engine.fuel_current().str(), false } );
    }
    SECTION( "duplicate part" ) {
        selection.engines.push_back( selection.engines.front() );
    }
    SECTION( "unsupported fuel" ) {
        selection.engines.front().fuel = "water_clean";
    }
    SECTION( "wrong vehicle identity" ) {
        ++selection.vehicle_id;
    }
    const std::string before = capture_rng_state();
    fixture.run( who, control_request( fixture, who, selection ) );
    CHECK( engine.enabled );
    CHECK( target.engine_on );
    CHECK_FALSE( who.activity );
    CHECK( capture_rng_state() == before );
}

TEST_CASE( "owned_engine_configuration_stops_all_and_restarts_with_native_time",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    get_avatar().setpos( here, tripoint_bub_ms( 40, 40, 0 ) );
    vehicle_control_selection selection = control_choice( who, target, "engines" );
    for( const int index : target.engines ) {
        vehicle_part &part = target.part( index );
        part.enabled = true;
        selection.engines.push_back( { part.get_base().uid().get_value(), part.fuel_current().str(), false } );
    }
    REQUIRE_FALSE( selection.engines.empty() );
    target.engine_on = true;
    const std::string disable = control_request( fixture, who, selection );
    fixture.run( who, disable );
    CHECK_FALSE( target.engine_on );
    CHECK_FALSE( who.activity );
    for( const int index : target.engines ) {
        CHECK_FALSE( target.part( index ).enabled );
    }
    fixture.run( who, disable );
    CHECK_FALSE( target.engine_on );
    selection.engines.front().enabled = true;
    const int battery = target.fuel_left( here, itype_battery );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, selection ) );
    REQUIRE( who.activity.id() == ACT_START_ENGINES );
    CHECK_FALSE( target.engine_on );
    CHECK( target.fuel_left( here, itype_battery ) == battery );
    CHECK_FALSE( get_avatar().activity );
    save_reload_activity( who );
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( target.engine_on );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "obsolete_vehicle_toggles_cannot_upload_state_or_change_engines",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    g->multiplayer_session().host_mode = true;
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    here.board_vehicle( who.pos_bub(), &who );
    who.controlling_vehicle = true;
    target.engine_on = true;
    const int strength = who.get_str_base();
    const std::string before = capture_rng_state();
    for( const char *action : { "control_vehicle", "stop_engine", "toggle_engine" } ) {
        next_test_remote_turn( recipient );
        const std::string wire = test_granted_action( std::string( R"({"action":")" ) + action +
                                 R"(","char_stats":{"str":999}})", recipient.turn.grant_seq );
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player", wire,
                                               recipient.admission } ) );
        cata_mp::process_mp_events();
        CHECK( target.engine_on );
        CHECK( who.in_vehicle );
        CHECK( who.controlling_vehicle );
        CHECK( who.get_str_base() == strength );
        CHECK_FALSE( who.activity );
    }
    CHECK( capture_rng_state() == before );
}

TEST_CASE( "vehicle_alarm_operations_use_the_actual_operator",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    const int controls = target.avail_part_with_feature( here.veh_at( who.pos_bub() )->part_index(),
                         VPFLAG_CONTROLS );
    REQUIRE( controls >= 0 );
    if( !target.has_security_working( here ) ) {
        REQUIRE( target.install_part( here, target.part( controls ).mount,
                                      vpart_vehicle_alarm ) >= 0 );
    }
    REQUIRE( target.has_security_working( here ) );
    get_avatar().set_skill_level( skill_mechanics, 0 );
    who.set_skill_level( skill_mechanics, 10 );
    target.is_locked = false;
    target.is_alarm_on = false;
    const std::string unlocked_rng = capture_rng_state();
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "alarm" ) ) );
    CHECK_FALSE( target.is_alarm_on );
    CHECK( capture_rng_state() == unlocked_rng );
    target.is_locked = true;
    const std::string::size_type count = recipient.feedback.pending.size();
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "alarm" ) ) );
    REQUIRE( target.is_alarm_on );
    CHECK( recipient.feedback.pending.size() > count );
    const int controls_hp = target.part( controls ).hp();
    // Select a roll where a skilled operator stops the alarm, but the unskilled
    // host would damage the controls.  Keep this independent of setup RNG use.
    std::string alarm_rng = capture_rng_state();
    bool selected_roll = false;
    for( int attempt = 0; attempt < 100 && !selected_roll; ++attempt ) {
        alarm_rng = capture_rng_state();
        const int roll = rng( 1, 100 );
        selected_roll = roll >= 10 && roll <= 20;
    }
    REQUIRE( selected_roll );
    restore_rng_state( alarm_rng );
    const std::string request = control_request( fixture, who, control_choice( who, target, "smash_alarm" ) );
    fixture.run( who, request );
    CHECK_FALSE( target.is_alarm_on );
    CHECK( target.part( controls ).hp() == controls_hp );
    CHECK( target.is_locked );
    const std::string after = capture_rng_state();
    fixture.run( who, request );
    CHECK( capture_rng_state() == after );
}

TEST_CASE( "legacy_hotwire_save_binds_nearby_controls_to_vehicle_identity",
           "[multiplayer][vehicle_menu_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    target.is_locked = true;
    who.i_add( item( itype_screwdriver ) );
    who.set_skill_level( skill_mechanics, 8 );
    const tripoint_abs_ms controls = who.pos_abs();
    bool adjacent = false;
    for( const tripoint_abs_ms &position : target.get_points() ) {
        if( rl_dist( controls, position ) == 1 ) {
            who.setpos( here, here.get_bub( position ) );
            adjacent = true;
            break;
        }
    }
    REQUIRE( adjacent );
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    out.member( "target", target.pos_abs() );
    out.member( "moves_total", 100 );
    out.end_object();
    JsonValue value = json_loader::from_string( stream.str() );
    const auto actor = hotwire_car_activity_actor::deserialize( value );
    player_activity activity( *actor );
    actor->start( activity, who );
    REQUIRE( activity );
    CHECK( activity.moves_left == 100 );
    actor->finish( activity, who );
    CHECK_FALSE( target.is_locked );
}

namespace
{
vehicle &owned_autopilot_vehicle( Character &who )
{
    map &here = get_map();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    const optional_vpart_position at = here.veh_at( who.pos_bub() );
    REQUIRE( at );
    if( target.avail_part_with_feature( at->mount_pos(), "CTRL_ELECTRONIC" ) < 0 ) {
        REQUIRE( target.install_part( here, at->mount_pos(), vpart_controls_electronic ) >= 0 );
    }
    REQUIRE( target.install_part( here, at->mount_pos(), vpart_programmable_autopilot ) >= 0 );
    return target;
}
} // namespace

TEST_CASE( "owned_autopilot_follow_uses_operator_startup_and_persists_target",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_autopilot_vehicle( who );
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 40, 40, 0 ) );
    const int host_moves = host.get_moves();
    const std::string request = control_request( fixture, who, control_choice( who, target, "autopilot_follow" ) );
    fixture.run( who, request );
    REQUIRE( target.is_following );
    CHECK( target.get_follow_target() == &who );
    CHECK( target.following_character == who.getID() );
    REQUIRE( who.activity.id() == ACT_START_ENGINES );
    CHECK( cata_mp::owns_inventory_activity( who ) );
    CHECK_FALSE( host.activity );
    CHECK( host.get_moves() == host_moves );
    const int startup = who.activity.moves_left;
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( who.activity.moves_left == startup );
    CHECK( capture_rng_state() == rng );

    std::ostringstream encoded;
    JsonOut out( encoded );
    target.serialize( out );
    vehicle restored( vehicle_prototype_ );
    restored.deserialize( json_loader::from_string( encoded.str() ).get_object() );
    CHECK( restored.following_character == who.getID() );
    CHECK( restored.get_follow_target() == &who );
    save_reload_activity( who );
    who.set_moves( startup );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( target.engine_on );
    CHECK( target.get_follow_target() == &who );
}

TEST_CASE( "autopilot_tracks_remote_player_and_suspends_for_their_boarding",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_autopilot_vehicle( who );
    target.engine_on = true;
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "autopilot_follow" ) ) );
    REQUIRE( target.get_follow_target() == &who );
    avatar &host = get_avatar();
    owned_test_vehicle( host, tripoint_bub_ms( 30, 30, 0 ) );
    here.board_vehicle( host.pos_bub(), &host );
    REQUIRE( host.in_vehicle );
    who.setpos( here, tripoint_bub_ms( 100, 60, 0 ) );
    // Actual movement dispatch must ignore the host's boarded state and target.
    here.vehmove();
    CHECK( target.is_following );
    CHECK( target.cruise_velocity > 0 );
    CHECK( target.get_follow_target() == &who );

    const auto seats = target.get_avail_parts( "BOARDABLE" );
    REQUIRE_FALSE( empty( seats ) );
    who.setpos( here, seats.begin()->pos_bub( here ) );
    here.board_vehicle( who.pos_bub(), &who );
    REQUIRE( who.in_vehicle );
    target.autopilot_follow( here );
    CHECK_FALSE( target.is_following );
    CHECK_FALSE( target.autopilot_on );
    CHECK( target.cruise_velocity == 0 );
}

TEST_CASE( "autopilot_missing_target_never_falls_back_to_host_and_legacy_binds_once",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    vehicle &target = owned_autopilot_vehicle( who );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    who.setpos( here, tripoint_bub_ms( 100, 60, 0 ) );
    target.engine_on = target.autopilot_on = target.is_following = true;
    SECTION( "missing assigned player" ) {
        target.following_character = character_id( 2000000000 );
        CHECK( target.get_follow_target() == nullptr );
        target.autopilot_follow( here );
        CHECK_FALSE( target.is_following );
        CHECK( target.cruise_velocity == 0 );
    }
    SECTION( "assigned player outside loaded map" ) {
        target.following_character = who.getID();
        // Leave the reality bubble without generating distant overmaps.
        const tripoint_bub_ms outside( here.getmapsize() * SEEX, 60, 0 );
        REQUIRE_FALSE( here.inbounds( outside ) );
        who.setpos( here, outside, false );
        target.autopilot_follow( here );
        CHECK_FALSE( target.is_following );
    }
    SECTION( "legacy save without an assigned player" ) {
        target.following_character.reset();
        CHECK( target.get_follow_target() == &get_avatar() );
        target.autopilot_follow( here );
        CHECK( target.following_character == get_avatar().getID() );
    }
}

TEST_CASE( "autopilot_collision_checks_followed_player_and_other_bodies_separately",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    vehicle &target = owned_autopilot_vehicle( who );
    target.is_following = target.autopilot_on = target.engine_on = true;
    target.following_character = who.getID();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    std::optional<tripoint_bub_ms> ahead;
    for( const point_abs_ms &point : target.immediate_path( &here ) ) {
        const tripoint_bub_ms p = here.get_bub( tripoint_abs_ms( point, 0 ) );
        if( !here.veh_at( p ) && here.passable( p ) ) {
            ahead = p;
            break;
        }
    }
    REQUIRE( ahead );
    who.setpos( here, *ahead );
    units::angle angle = 0_degrees;
    CHECK_FALSE( target.precollision_check( angle, here, true ) );
    who.setpos( here, tripoint_bub_ms( 100, 100, 0 ) );
    host.setpos( here, *ahead );
    CHECK( target.precollision_check( angle, here, true ) );
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    npc &other = spawn_npc( { ahead->x(), ahead->y() }, "test_talker" );
    CHECK( target.precollision_check( angle, here, true ) );
    CHECK( other.pos_bub() == *ahead );
}

TEST_CASE( "owned_autopilot_settings_validate_parts_access_and_replay",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = owned_autopilot_vehicle( who );
    target.engine_on = target.autopilot_on = target.is_following = true;
    target.following_character = who.getID();
    const std::string disable = control_request( fixture, who, control_choice( who, target, "precollision_off" ) );
    fixture.run( who, disable );
    REQUIRE_FALSE( target.precollision_on );
    const std::string rng = capture_rng_state();
    fixture.run( who, disable );
    CHECK_FALSE( target.precollision_on );
    CHECK( capture_rng_state() == rng );
    REQUIRE_FALSE( recipient.feedback.pending.empty() );
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "precollision_on" ) ) );
    REQUIRE( target.precollision_on );
    const vehicle_control_selection stop = control_choice( who, target, "autopilot_stop" );
    SECTION( "stopping uses native state and engine shutdown" ) {
        fixture.run( who, control_request( fixture, who, stop ) );
        CHECK_FALSE( target.engine_on );
        CHECK_FALSE( target.is_following );
        CHECK_FALSE( target.is_patrolling );
        CHECK_FALSE( target.following_character );
    }
    SECTION( "lost access" ) {
        who.setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
        fixture.run( who, control_request( fixture, who, stop ) );
        CHECK( target.engine_on );
        CHECK( target.is_following );
    }
    SECTION( "broken autopilot" ) {
        const auto parts = target.get_avail_parts( "AUTOPILOT" );
        REQUIRE_FALSE( empty( parts ) );
        target.set_hp( parts.begin()->part(), 0, false );
        CHECK_FALSE( vehicle_control_accessible( who, here, target, who.pos_abs(), "autopilot_follow" ) );
        fixture.run( who, control_request( fixture, who, stop ) );
        CHECK_FALSE( target.engine_on );
        CHECK_FALSE( target.is_following );
    }
}

TEST_CASE( "owned_autopilot_patrol_uses_initiating_faction_zones_and_survives_save",
           "[multiplayer][vehicle_autopilot_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope clear_zones( [&]() { zones.clear(); } );
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    who.set_fac( faction_free_merchants );
    vehicle &target = owned_autopilot_vehicle( who );
    target.engine_on = true;
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_abs_ms start = here.get_abs( tripoint_bub_ms( 80, 70, 0 ) );
    const tripoint_abs_ms end = here.get_abs( tripoint_bub_ms( 85, 75, 0 ) );
    zones.add( "Host patrol", zone_type_VEHICLE_PATROL, your_fac, false, true, start, end );
    zones.cache_data();
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "autopilot_patrol" ) ) );
    CHECK_FALSE( target.is_patrolling );
    zones.add( "Operator patrol", zone_type_VEHICLE_PATROL, who.get_faction()->id,
               false, true, start, end );
    zones.cache_data();
    fixture.run( who, control_request( fixture, who, control_choice( who, target, "autopilot_patrol" ) ) );
    REQUIRE( target.is_patrolling );
    CHECK_FALSE( target.is_following );
    CHECK( target.patrol_faction == who.get_faction()->id );
    std::ostringstream encoded;
    JsonOut out( encoded );
    target.serialize( out );
    vehicle restored( vehicle_prototype_ );
    restored.deserialize( json_loader::from_string( encoded.str() ).get_object() );
    CHECK( restored.patrol_faction == who.get_faction()->id );
    target.autopilot_patrol( &here );
    const auto points = zones.get_near( zone_type_VEHICLE_PATROL, target.pos_abs(),
                                        MAX_VIEW_DISTANCE, nullptr, who.get_faction()->id );
    std::ostringstream updated;
    JsonOut waypoint_out( updated );
    target.serialize( waypoint_out );
    JsonObject snapshot = json_loader::from_string( updated.str() ).get_object();
    snapshot.allow_omitted_members();
    tripoint_abs_ms waypoint;
    snapshot.read( "autodrive_local_target", waypoint, true );
    CHECK( points.count( waypoint ) == 1 );
    target.enable_patrol( here, who );
    zones.clear();
    target.cruise_velocity = 400;
    target.autopilot_patrol( &here );
    CHECK_FALSE( target.is_patrolling );
    CHECK_FALSE( target.autopilot_on );
    CHECK( target.cruise_velocity == 0 );
}

namespace
{
item_location remote_controller( Character &who )
{
    item controller( itype_remotevehcontrol );
    item battery( itype_light_battery_cell );
    battery.ammo_set( itype_battery, 100 );
    REQUIRE( controller.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    who.set_wielded_item( controller );
    who.set_moves( 1000 );
    REQUIRE( who.get_wielded_item()->ammo_sufficient( &who, "REMOTEVEH" ) );
    return who.get_wielded_item();
}

vehicle &radio_vehicle( Character &who, bool advanced = true )
{
    map &here = get_map();
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    if( empty( target.get_avail_parts( advanced ? "REMOTE_CONTROLS" : "CTRL_ELECTRONIC" ) ) ) {
        REQUIRE( target.install_part( here, point_rel_ms::zero,
                                      vpart_id( advanced ? "drive_by_wire_controls" : "controls_electronic" ) ) >= 0 );
    }
    who.setpos( here, tripoint_bub_ms( 50, 50, 0 ) );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    return target;
}

std::string radio_request( reload_fixture &fixture, Character &who, const std::string &action,
                           std::optional<int64_t> uid = std::nullopt )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, who.get_wielded_item() ) );
        out.member( "item_type", "remotevehcontrol" );
        out.member( "method", "REMOTEVEH" );
        out.member( "target", who.pos_abs() );
        out.member( "remote_vehicle_action", action );
        out.member( "remote_vehicle_uid", uid );
    } );
}

void arrange_security_prompt( Character &who, item &controller, vehicle &target )
{
    map &here = get_map();
    if( !target.has_security_working( here ) ) {
        REQUIRE( target.install_part( here, point_rel_ms::zero, vpart_vehicle_alarm ) >= 0 );
    }
    REQUIRE( target.has_security_working( here ) );
    target.is_locked = true;
    target.is_alarm_on = false;
    who.set_skill_level( skill_computer, 10 );
    who.set_int_bonus( 4 );
    std::string selected = capture_rng_state();
    bool found = false;
    for( int attempt = 0; attempt < 100 && !found; ++attempt ) {
        selected = capture_rng_state();
        REQUIRE( controller.activation_success() );
        const int roll = dice( 12, who.get_int() ) - 50;
        found = roll >= 0 && roll < 20;
    }
    REQUIRE( found );
    restore_rng_state( selected );
}
} // namespace

namespace
{
std::string bionic_radio_request( reload_fixture &fixture, Character &who, unsigned int uid,
                                  const std::string &action, int64_t vehicle_id )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", "bio_remote" );
        out.member( "remote_vehicle_action", action );
        out.member( "remote_vehicle_uid", vehicle_id );
    } );
}
} // namespace

TEST_CASE( "remote_cbm_control_and_deactivation_belong_to_operator", "[mp_bionic_remote]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    const bionic_id &id = bio_remote;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    vehicle &target = radio_vehicle( who );
    target.engine_on = true;
    const units::energy power = who.get_power_level();
    const units::energy host_power = get_avatar().get_power_level();
    const std::string request = bionic_radio_request( fixture, who, uid, "control", target.uid().get_value() );
    fixture.run( who, request );
    CHECK_FALSE( who.activity );
    CHECK( who.has_active_bionic( id ) );
    CHECK( resolve_remote_vehicle( who, get_map() ) == &target );
    CHECK( who.get_power_level() == power - 1_kJ );
    CHECK_FALSE( who.get_wielded_item() );
    CHECK_FALSE( who.has_active_item( itype_remotevehcontrol ) );
    CHECK_FALSE( resolve_remote_vehicle( get_avatar(), get_map() ) );
    CHECK( get_avatar().get_power_level() == host_power );
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( who.get_power_level() == power - 1_kJ );
    CHECK( capture_rng_state() == rng );
    fixture.run( who, bionic_switch_request( fixture, who, uid, id, false ) );
    CHECK_FALSE( who.has_active_bionic( id ) );
    CHECK_FALSE( resolve_remote_vehicle( who, get_map() ) );
    CHECK( who.get_power_level() == power - 1_kJ );
    CHECK( target.engine_on );
}

TEST_CASE( "remote_cbm_security_saves_owner_roll_and_bills_only_success", "[mp_bionic_remote]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    const bionic_id &id = bio_remote;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    vehicle &target = radio_vehicle( who );
    target.engine_on = true;
    item facade( itype_remotevehcontrol, calendar::turn_zero );
    facade.set_flag( flag_USES_BIONIC_POWER );
    facade.charges = 200;
    arrange_security_prompt( who, facade, target );
    who.set_moves( 1000 );
    const units::energy power = who.get_power_level();
    const std::string request = bionic_radio_request( fixture, who, uid, "control", target.uid().get_value() );
    fixture.run( who, request );
    auto *actor = dynamic_cast<remote_vehicle_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->uses_bionic() );
    REQUIRE( actor->waiting_for_security() );
    CHECK( who.get_power_level() == power );
    CHECK_FALSE( who.has_active_bionic( id ) );
    const std::string scanned = capture_rng_state();
    fixture.run( who, request );
    CHECK( capture_rng_state() == scanned );
    save_reload_activity( who );
    CHECK( capture_rng_state() == scanned );
    const bool consent = GENERATE( false, true );
    const std::string answer = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "remote_security", consent );
    } );
    fixture.run( who, answer );
    CHECK_FALSE( who.activity );
    CHECK( who.has_active_bionic( id ) == consent );
    CHECK( who.get_power_level() == power - ( consent ? 1_kJ : 0_kJ ) );
    CHECK( target.is_locked == !consent );
    CHECK( ( resolve_remote_vehicle( who, get_map() ) == &target ) == consent );
    CHECK( who.get_moves() < 1000 );
    const std::string settled = capture_rng_state();
    const int moves = who.get_moves();
    fixture.run( who, answer );
    CHECK( capture_rng_state() == settled );
    CHECK( who.get_moves() == moves );
    CHECK( who.get_power_level() == power - ( consent ? 1_kJ : 0_kJ ) );
}

TEST_CASE( "remote_cbm_one_action_keeps_installed_identity_through_engine_start", "[mp_bionic_remote]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    const unsigned int uid = prepare_targeted_bionic( who, bio_remote );
    vehicle &target = radio_vehicle( who, false );
    const units::energy power = who.get_power_level();
    const std::string reply = fixture.run( who, bionic_radio_request( fixture, who, uid, "action",
                                    target.uid().get_value() ) );
    auto *actor = dynamic_cast<remote_vehicle_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for_action() );
    JsonObject response = json_loader::from_string( reply ).get_object();
    response.allow_omitted_members();
    CHECK( response.has_object( "remote_controller_preview" ) );
    CHECK_FALSE( response.has_member( "remote_controller" ) );
    CHECK( who.get_power_level() == power );
    SECTION( "cancel after access costs once" ) {
        const std::string cancel = fixture.request( who, "cancel" );
        fixture.run( who, cancel );
        CHECK_FALSE( who.activity );
        CHECK( who.get_power_level() == power - 1_kJ );
        fixture.run( who, cancel );
        CHECK( who.get_power_level() == power - 1_kJ );
    }
    SECTION( "engine startup owns the CBM identity rather than a temporary item" ) {
        vehicle_control_selection choice;
        choice.vehicle_id = target.uid().get_value();
        choice.position = target.get_avail_parts( "CTRL_ELECTRONIC" ).begin()->pos_abs();
        choice.action = "start";
        fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
            out.member( "vehicle_control", choice );
        } ) );
        REQUIRE( who.activity.id() == ACT_START_ENGINES );
        CHECK( who.get_power_level() == power - 1_kJ );
        CHECK_FALSE( who.controlling_vehicle );
        CHECK_FALSE( who.has_active_bionic( bio_remote ) );
        save_reload_activity( who );
        const bool shorted = GENERATE( false, true );
        if( shorted ) {
            ( *who.find_bionic_by_uid( uid ) )->incapacitated_time = 1_minutes;
        }
        who.set_moves( who.activity.moves_left );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( target.engine_on == !shorted );
        CHECK( who.get_power_level() == power - 1_kJ );
        CHECK_FALSE( resolve_remote_vehicle( who, get_map() ) );
    }
}

TEST_CASE( "remote_cbm_radio_signals_spend_only_operators_time_and_power", "[mp_bionic_remote]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    const unsigned int uid = prepare_targeted_bionic( who, bio_remote );
    who.set_moves( 1000 );
    const units::energy power = who.get_power_level();
    const units::energy host_power = get_avatar().get_power_level();
    const int host_moves = get_avatar().get_moves();
    const int button = GENERATE( 1, 2, 3, 4 );
    const std::string request = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", "bio_remote" );
        out.member( "radio", button );
    } );
    fixture.run( who, request );
    CHECK( who.get_power_level() == power - ( button < 4 ? 1_kJ : 0_kJ ) );
    CHECK( who.get_moves() == ( button < 4 ? 800 : 1000 ) );
    CHECK_FALSE( who.has_active_bionic( bio_remote ) );
    CHECK( get_avatar().get_power_level() == host_power );
    CHECK( get_avatar().get_moves() == host_moves );
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( capture_rng_state() == rng );
    CHECK( who.get_power_level() == power - ( button < 4 ? 1_kJ : 0_kJ ) );
}

namespace
{
item_location toy_radio_controller( Character &who )
{
    item controller( itype_radiocontrol, calendar::turn_zero );
    item battery( itype_light_battery_cell, calendar::turn_zero );
    battery.ammo_set( itype_battery, 100 );
    REQUIRE( controller.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    who.set_wielded_item( controller );
    who.set_moves( 1000 );
    return who.get_wielded_item();
}

item_location toy_car( map &here, const tripoint_bub_ms &position )
{
    item car( itype_radio_car_on, calendar::turn_zero );
    car.active = true;
    item battery( itype_medium_battery_cell, calendar::turn_zero );
    battery.ammo_set( itype_battery, 100 );
    REQUIRE( car.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    item &placed = here.add_item_or_charges( position, car, false );
    REQUIRE_FALSE( placed.is_null() );
    return item_location( map_cursor( position ), &placed );
}

std::string toy_radio_request( reload_fixture &fixture, Character &who, int choice )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, who.get_wielded_item() ) );
        out.member( "item_type", "radiocontrol" );
        out.member( "method", "RADIOCONTROL" );
        out.member( "target", who.pos_abs() );
        out.member( "radio", choice );
    } );
}

std::string toy_drive_request( reload_fixture &fixture, Character &who,
                               const radio_car_binding &binding, const point_rel_ms &direction )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "radio_car_drive" );
        out.member( "car", binding.car );
        out.member( "position", binding.position );
        out.member( "direction", direction );
    } );
}
} // namespace

TEST_CASE( "radio_car_moves_only_for_its_operator_and_retains_identity", "[mp_radio_car]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    who.setpos( here, tripoint_bub_ms( 50, 50, 0 ) );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    item_location controller = toy_radio_controller( who );
    const tripoint_bub_ms origin( 52, 50, 0 );
    const item_location car = toy_car( here, origin );
    const int64_t uid = car->uid().get_value();
    REQUIRE( car->magazine_current() );
    const int battery_ammo = car->magazine_current()->ammo_remaining();
    const int64_t battery_uid = car->magazine_current()->uid().get_value();
    const tripoint_abs_ms actor_position = who.pos_abs();
    const tripoint_abs_ms host_position = get_avatar().pos_abs();
    const int host_moves = get_avatar().get_moves();
    const std::string start = toy_radio_request( fixture, who, 0 );
    fixture.run( who, start );
    REQUIRE( has_radio_car_control( who, here ) );
    REQUIRE( controller->active );
    const int ammo = controller->ammo_remaining();
    fixture.run( who, start );
    CHECK( controller->ammo_remaining() == ammo );
    const auto binding = read_radio_car_binding( who, here );
    REQUIRE( binding );
    CHECK( binding->car == uid );
    CHECK( binding->position == here.get_abs( origin ) );
    const int moves = who.get_moves();
    const std::string drive = toy_drive_request( fixture, who, *binding, point_rel_ms( 1, 0 ) );
    fixture.run( who, drive );
    const auto moved = read_radio_car_binding( who, here );
    REQUIRE( moved );
    CHECK( moved->car == uid );
    CHECK( moved->position == here.get_abs( origin + point_rel_ms( 1, 0 ) ) );
    CHECK( here.i_at( origin ).empty() );
    REQUIRE( here.i_at( origin + point_rel_ms( 1, 0 ) ).size() == 1 );
    const item &remaining = here.i_at( origin + point_rel_ms( 1, 0 ) ).only_item();
    CHECK( remaining.uid().get_value() == uid );
    CHECK( remaining.active );
    REQUIRE( remaining.magazine_current() );
    CHECK( remaining.magazine_current()->ammo_remaining() == battery_ammo );
    CHECK( remaining.magazine_current()->uid().get_value() == battery_uid );
    CHECK( who.get_moves() == moves - 50 );
    CHECK( who.pos_abs() == actor_position );
    CHECK( get_avatar().pos_abs() == host_position );
    CHECK( get_avatar().get_moves() == host_moves );
    const std::string rng = capture_rng_state();
    fixture.run( who, drive );
    CHECK( who.get_moves() == moves - 50 );
    CHECK( capture_rng_state() == rng );
    fixture.run( who, toy_radio_request( fixture, who, 0 ) );
    CHECK_FALSE( has_radio_car_binding( who ) );
    CHECK_FALSE( controller->active );
}

TEST_CASE( "radio_car_rejects_stale_targets_collisions_and_invalid_directions", "[mp_radio_car]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    toy_radio_controller( who );
    const tripoint_bub_ms origin = who.pos_bub() + point_rel_ms( 2, 0 );
    item_location car = toy_car( here, origin );
    fixture.run( who, toy_radio_request( fixture, who, 0 ) );
    const auto binding = read_radio_car_binding( who, here );
    REQUIRE( binding );
    point_rel_ms direction( 1, 0 );
    SECTION( "replacement at the same tile is not the connected car" ) {
        car.remove_item();
        car = toy_car( here, origin );
        REQUIRE( car->uid().get_value() != binding->car );
    }
    SECTION( "obstacle" ) {
        here.ter_set( origin + direction, ter_t_wall );
    }
    SECTION( "invalid direction including integer minimum" ) {
        direction.x() = std::numeric_limits<int>::min();
    }
    SECTION( "controller lost" ) {
        who.remove_weapon();
    }
    const int moves = who.get_moves();
    fixture.run( who, toy_drive_request( fixture, who, *binding, direction ) );
    CHECK( who.get_moves() == moves );
    REQUIRE( car );
    CHECK( car.pos_bub( here ) == origin );
}

TEST_CASE( "radio_controllers_do_not_steal_or_clear_another_players_car", "[mp_radio_car]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    who.setpos( here, tripoint_bub_ms( 50, 50, 0 ) );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    item_location controller = toy_radio_controller( who );
    const item_location first = toy_car( here, tripoint_bub_ms( 52, 50, 0 ) );
    fixture.run( who, toy_radio_request( fixture, who, 0 ) );
    REQUIRE( has_radio_car_control( who, here ) );
    item_location host_controller = toy_radio_controller( host );
    REQUIRE_FALSE( connect_radio_car( host, here, *host_controller ) );
    const item_location second = toy_car( here, tripoint_bub_ms( 32, 30, 0 ) );
    REQUIRE( connect_radio_car( host, here, *host_controller ) );
    host_controller->active = true;
    REQUIRE( has_radio_car_control( host, here ) );
    const auto host_binding = read_radio_car_binding( host, here );
    REQUIRE( host_binding );
    CHECK( host_binding->car == second->uid().get_value() );
    item dropped = *controller;
    who.remove_weapon();
    iuse::radiocontrol_tick( nullptr, &dropped, who.pos_bub() );
    CHECK_FALSE( dropped.active );
    CHECK( has_radio_car_control( host, here ) );
    CHECK_FALSE( has_radio_car_control( who, here ) );
    CHECK( read_radio_car_binding( host, here )->car == host_binding->car );
    CHECK( first->uid().get_value() != second->uid().get_value() );
}

TEST_CASE( "radio_car_legacy_binding_and_turn_projection_keep_absolute_identity", "[mp_radio_car]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    item_location controller = toy_radio_controller( who );
    controller->active = true;
    const tripoint_bub_ms origin = who.pos_bub() + point_rel_ms( 2, 0 );
    const item_location car = toy_car( here, origin );
    who.set_value( "remote_controlling", tripoint_abs_ms( origin.raw() ) );
    const auto legacy = read_radio_car_binding( who, here );
    REQUIRE( legacy );
    CHECK( legacy->position == here.get_abs( origin ) );
    CHECK( legacy->car == car->uid().get_value() );
    fixture.run( who, toy_drive_request( fixture, who, *legacy, point_rel_ms( 1, 0 ) ) );
    CHECK_FALSE( who.maybe_get_value( "remote_controlling" ) );
    const auto moved = read_radio_car_binding( who, here );
    REQUIRE( moved );
    CHECK( moved->position == here.get_abs( origin + point_rel_ms( 1, 0 ) ) );
    std::ostringstream encoded;
    JsonOut out( encoded );
    who.store_turn_state( out );
    const std::string rng = capture_rng_state();
    disconnect_radio_car( who );
    who.load_turn_state( json_loader::from_string( encoded.str() ).get_object() );
    REQUIRE( read_radio_car_binding( who, here ) );
    CHECK( read_radio_car_binding( who, here )->car == moved->car );
    CHECK( read_radio_car_binding( who, here )->position == moved->position );
    CHECK( read_radio_car_binding( who, here )->controller == controller->uid().get_value() );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "radio_car_cbm_binding_uses_installed_operator_and_deactivates_cleanly", "[mp_radio_car]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    const bionic_id &type = bio_remote;
    const unsigned int uid = prepare_targeted_bionic( who, type );
    const item_location car = toy_car( here, who.pos_bub() + point_rel_ms( 2, 0 ) );
    const units::energy power = who.get_power_level();
    const std::string request = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", type );
        out.member( "radio", 0 );
    } );
    fixture.run( who, request );
    REQUIRE( has_radio_car_control( who, here ) );
    const auto binding = read_radio_car_binding( who, here );
    REQUIRE( binding );
    CHECK( binding->car == car->uid().get_value() );
    CHECK( binding->bionic == uid );
    CHECK( binding->controller == 0 );
    CHECK( who.get_power_level() == power - 1_kJ );
    fixture.run( who, bionic_switch_request( fixture, who, uid, type, false ) );
    CHECK_FALSE( has_radio_car_binding( who ) );
    CHECK_FALSE( who.has_active_bionic( type ) );
    CHECK( who.get_power_level() == power - 1_kJ );
}

TEST_CASE( "radio_car_client_movement_does_not_move_replica_items", "[mp_radio_car]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    avatar &who = get_avatar();
    item_location controller = toy_radio_controller( who );
    const tripoint_bub_ms origin = who.pos_bub() + point_rel_ms( 2, 0 );
    const item_location car = toy_car( here, origin );
    REQUIRE( connect_radio_car( who, here, *controller ) );
    controller->active = true;
    const auto binding = read_radio_car_binding( who, here );
    REQUIRE( binding );
    const std::string rng = capture_rng_state();
    cata_mp::set_client_mode( true );
    REQUIRE( cata_mp::client_drive_radio_car( point_rel_ms( 1, 0 ) ) );
    REQUIRE( car );
    CHECK( car.pos_bub( here ) == origin );
    CHECK( read_radio_car_binding( who, here )->position == binding->position );
    CHECK( capture_rng_state() == rng );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
}

TEST_CASE( "remote_controller_take_and_stop_belong_to_operator_and_replay_once",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    target.engine_on = true;
    const item_location controller = remote_controller( who );
    const int before = controller->ammo_remaining();
    const int host_moves = get_avatar().get_moves();
    const std::string request = radio_request( fixture, who, "control", target.uid().get_value() );
    const std::string result = fixture.run( who, request );
    CHECK( controller->active );
    CHECK( resolve_remote_vehicle( who, get_map() ) == &target );
    CHECK_FALSE( resolve_remote_vehicle( get_avatar(), get_map() ) );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK_FALSE( get_avatar().activity );
    CHECK( controller->ammo_remaining() == before - 1 );
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( controller->ammo_remaining() == before - 1 );
    CHECK( capture_rng_state() == rng );
    JsonObject reply = json_loader::from_string( result ).get_object();
    reply.allow_omitted_members();
    JsonObject binding = reply.get_object( "remote_vehicle" );
    binding.allow_omitted_members();
    CHECK( binding.get_int64( "uid" ) == target.uid().get_value() );
    fixture.run( who, radio_request( fixture, who, "stop" ) );
    CHECK_FALSE( controller->active );
    CHECK_FALSE( resolve_remote_vehicle( who, get_map() ) );
    CHECK( target.engine_on );
}

TEST_CASE( "remote_security_scan_survives_save_and_owner_choice_without_reroll",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    target.engine_on = true;
    item_location controller = remote_controller( who );
    arrange_security_prompt( who, *controller, target );
    const std::string request = radio_request( fixture, who, "control", target.uid().get_value() );
    fixture.run( who, request );
    auto *actor = dynamic_cast<remote_vehicle_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for_security() );
    CHECK( who.get_moves() == 1000 );
    const std::string scanned = capture_rng_state();
    fixture.run( who, request );
    CHECK( capture_rng_state() == scanned );
    save_reload_activity( who );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    actor = dynamic_cast<remote_vehicle_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for_security() );
    CHECK( capture_rng_state() == scanned );
    const bool consent = GENERATE( false, true );
    const int charges = controller->charges;
    const int ammo = controller->ammo_remaining();
    const int battery_ammo = controller->magazine_current()->ammo_remaining();
    std::string canceled_rng = capture_rng_state();
    {
        // TEST_DATA's finished-activity EOC chooses its sole string with rng.
        // Include that native callback, but no second security dice roll.
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        rng( 0, 0 );
        canceled_rng = capture_rng_state();
    }
    const std::string answer = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "remote_security", consent );
    } );
    fixture.run( who, answer );
    CHECK_FALSE( who.activity );
    if( consent ) {
        CHECK_FALSE( target.is_locked );
        CHECK( resolve_remote_vehicle( who, get_map() ) == &target );
        const int effort = ( 1000 - who.get_moves() ) / 100;
        CHECK( controller->charges == charges - effort );
        CHECK( controller->ammo_remaining() == ammo - effort - 1 );
        CHECK( controller->magazine_current()->ammo_remaining() == battery_ammo - 1 );
        CHECK( who.get_moves() <= 800 );
        CHECK( who.get_moves() >= 200 );
    } else {
        CHECK( target.is_locked );
        CHECK_FALSE( controller->active );
        CHECK( who.get_moves() == 900 );
        CHECK( controller->charges == charges - 1 );
        CHECK( controller->ammo_remaining() == ammo - 1 );
        CHECK( controller->magazine_current()->ammo_remaining() == battery_ammo );
        CHECK( capture_rng_state() == canceled_rng );
    }
    const std::string final_rng = capture_rng_state();
    const int final_moves = who.get_moves();
    fixture.run( who, answer );
    CHECK( capture_rng_state() == final_rng );
    CHECK( who.get_moves() == final_moves );
}

TEST_CASE( "one_remote_vehicle_action_keeps_native_startup_without_granting_driving",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who, false );
    const item_location controller = remote_controller( who );
    fixture.run( who, radio_request( fixture, who, "action", target.uid().get_value() ) );
    auto *actor = dynamic_cast<remote_vehicle_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->waiting_for_action() );
    CHECK_FALSE( controller->active );
    CHECK_FALSE( resolve_remote_vehicle( who, here ) );
    vehicle_control_selection choice;
    choice.vehicle_id = target.uid().get_value();
    choice.position = target.get_avail_parts( "CTRL_ELECTRONIC" ).begin()->pos_abs();
    choice.action = "start";
    const std::string action = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "vehicle_control", choice );
    } );
    fixture.run( who, action );
    REQUIRE( who.activity.id() == ACT_START_ENGINES );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK_FALSE( controller->active );
    save_reload_activity( who );
    SECTION( "startup completes with the same controller" ) {
        who.set_moves( who.activity.moves_left );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( target.engine_on );
        CHECK_FALSE( resolve_remote_vehicle( who, here ) );
    }
    SECTION( "dropping the controller cancels the saved startup" ) {
        who.remove_weapon();
        who.set_moves( 1000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( target.engine_on );
    }
}

TEST_CASE( "remote_access_rejects_unreachable_and_replaced_vehicles_before_rng",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    const item_location controller = remote_controller( who );
    const int64_t uid = target.uid().get_value();
    SECTION( "out of radio range" ) {
        who.setpos( get_map(), tripoint_bub_ms( 1, 1, 0 ) );
    }
    SECTION( "original vehicle no longer exists" ) {
        get_map().destroy_vehicle( &target );
    }
    const std::string rng = capture_rng_state();
    const int ammo = controller->ammo_remaining();
    fixture.run( who, radio_request( fixture, who, "control", uid ) );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( controller->active );
    CHECK( controller->ammo_remaining() == ammo );
    CHECK( who.get_moves() == 1000 );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "local_remote_controller_retains_native_invocation_result_and_charge",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &target = radio_vehicle( who );
    target.engine_on = true;
    item_location controller = remote_controller( who );
    const int before = controller->ammo_remaining();
    item_activation_choices choices;
    choices.remote_vehicle_action = "control";
    choices.remote_vehicle_uid = target.uid().get_value();
    // invoke_item returns whether the item itself was consumed, not success.
    CHECK_FALSE( who.Character::invoke_item( controller.get_item(), "REMOTEVEH", who.pos_bub(),
                 who.get_moves(), &choices ) );
    CHECK( controller->ammo_remaining() == before - 1 );
    CHECK( controller->active );
    CHECK( resolve_remote_vehicle( who, get_map() ) == &target );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "local_vehicle_menu_requires_its_live_remote_controller_outside_reach",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    vehicle &target = radio_vehicle( who );
    who.setpos( here, tripoint_bub_ms( 50, 50, 0 ) );
    target.engine_on = true;
    const item_location controller = remote_controller( who );
    const tripoint_bub_ms controls = target.get_avail_parts( "CONTROLS" ).begin()->pos_bub( here );
    REQUIRE( rl_dist( controls, who.pos_bub() ) > 1 );
    const int access = GENERATE( 0, 1, 2 );
    INFO( "0: ordinary menu, 1: authenticated radio, 2: dropped controller; access=" << access );
    veh_menu menu( target, "test remote vehicle menu" );
    if( access != 0 ) {
        menu.remote_controller = &controller;
    }
    target.build_interact_menu( menu, &here, controls, false );
    const std::vector<veh_menu_item> entries = menu.get_items();
    const auto stop = std::find_if( entries.begin(), entries.end(), []( const veh_menu_item &entry ) {
        return entry._hotkey_action == "TOGGLE_ENGINE";
    } );
    REQUIRE( stop != entries.end() );
    REQUIRE( stop->_enabled );
    REQUIRE( stop->_on_submit );
    if( access == 2 ) {
        who.remove_weapon();
    }
    stop->_on_submit();
    CHECK( target.engine_on == ( access != 1 ) );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK_FALSE( resolve_remote_vehicle( who, here ) );
}

TEST_CASE( "saved_remote_security_scan_never_uses_a_replacement_controller",
           "[multiplayer][vehicle_remote_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    item_location controller = remote_controller( who );
    arrange_security_prompt( who, *controller, target );
    fixture.run( who, radio_request( fixture, who, "control", target.uid().get_value() ) );
    REQUIRE( who.activity.id() == ACT_REMOTE_VEHICLE );
    save_reload_activity( who );
    who.remove_weapon();
    controller = remote_controller( who );
    const int ammo = controller->ammo_remaining();
    fixture.run( who, fixture.request( who, "choose", []( JsonOut &out ) {
        out.member( "remote_security", true );
    } ) );
    CHECK_FALSE( who.activity );
    CHECK( target.is_locked );
    CHECK_FALSE( controller->active );
    CHECK( controller->ammo_remaining() == ammo );
    CHECK_FALSE( resolve_remote_vehicle( who, get_map() ) );
}

namespace
{
vehicle &electronic_vehicle( Character &who )
{
    vehicle &target = radio_vehicle( who, false );
    who.setpos( get_map(), target.get_avail_parts( "CTRL_ELECTRONIC" ).begin()->pos_bub( get_map() ) );
    who.set_moves( 100 );
    return target;
}

point_rel_ms next_electronic_mount( const vehicle &target )
{
    point_rel_ms front = point_rel_ms::zero;
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( !part.part().removed && part.mount_pos().x() > front.x() ) {
            front = part.mount_pos();
        }
    }
    return front + point_rel_ms( 1, 0 );
}

vehicle_control_selection electronic_choice( Character &who, vehicle &target,
        const std::string &system, bool enabled, int64_t part = 0 )
{
    vehicle_control_selection choice = control_choice( who, target, "electronics" );
    choice.electronics = vehicle_electronics_selection{ system, part, enabled };
    return choice;
}

void require_lights( const vehicle &target, bool enabled )
{
    REQUIRE_FALSE( empty( target.get_avail_parts( "CONE_LIGHT" ) ) );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        CHECK( part.part().enabled == enabled );
    }
}
} // namespace

TEST_CASE( "owned_vehicle_device_choices_are_read_only_and_replay_once",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        part.part().enabled = false;
    }
    const std::string initial_rng = capture_rng_state();
    const auto options = vehicle_electronics_options( who, here, target );
    const auto lights = std::find_if( options.begin(), options.end(), []( const vehicle_electronics_option &option ) {
        return option.choice.system == "CONE_LIGHT";
    } );
    REQUIRE( lights != options.end() );
    CHECK( lights->enabled );
    CHECK( lights->choice.enabled );
    require_lights( target, false );
    CHECK( capture_rng_state() == initial_rng );
    const std::string request = control_request( fixture, who, electronic_choice( who, target, "CONE_LIGHT", true ) );
    fixture.run( who, request );
    require_lights( target, true );
    CHECK( here.get_cache_ref( who.posz() ).lightmap_dirty );
    CHECK_FALSE( recipient.feedback.pending.empty() );
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    require_lights( target, true );
    CHECK( capture_rng_state() == rng );
    fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "CONE_LIGHT", false ) ) );
    require_lights( target, false );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK_FALSE( get_avatar().controlling_vehicle );
}

TEST_CASE( "owned_vehicle_electronics_rejects_forged_systems_and_lost_access",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        part.part().enabled = false;
    }
    vehicle_control_selection choice = electronic_choice( who, target, "CONE_LIGHT", true );
    SECTION( "engine is not an electronic switch" ) {
        choice.electronics->system = "ENGINE";
    }
    SECTION( "group does not accept arbitrary part IDs" ) {
        choice.electronics->part_id = 123456;
    }
    SECTION( "operator left the controls" ) {
        who.setpos( get_map(), tripoint_bub_ms( 100, 100, 0 ) );
    }
    SECTION( "vehicle was locked" ) {
        target.is_locked = true;
    }
    SECTION( "electronic controls were removed" ) {
        for( const vpart_reference &control : target.get_avail_parts( "CTRL_ELECTRONIC" ) ) {
            target.remove_part( control.part() );
        }
        REQUIRE_FALSE( vehicle_electronics_position( who, get_map(), target ) );
    }
    const std::string rng = capture_rng_state();
    fixture.run( who, control_request( fixture, who, choice ) );
    require_lights( target, false );
    CHECK_FALSE( target.engine_on );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "owned_camera_and_reactor_commands_validate_power_and_hardware_identity",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    SECTION( "camera state is explicit and refreshes visibility" ) {
        REQUIRE( target.install_part( here, point_rel_ms::zero, vpart_cam_control ) >= 0 );
        target.camera_on = false;
        const std::string request = control_request( fixture, who, electronic_choice( who, target, "camera", true ) );
        fixture.run( who, request );
        CHECK( target.camera_on );
        CHECK( here.get_cache_ref( who.posz() ).seen_cache_dirty );
        fixture.run( who, request );
        CHECK( target.camera_on );
        fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "camera", false ) ) );
        CHECK_FALSE( target.camera_on );
        target.discharge_battery( here, target.fuel_left( here, itype_battery ) );
        REQUIRE( target.fuel_left( here, itype_battery ) == 0 );
        fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "camera", true ) ) );
        CHECK_FALSE( target.camera_on );
    }
    SECTION( "removed reactor never addresses its replacement" ) {
        const point_rel_ms mount = next_electronic_mount( target );
        REQUIRE( target.install_part( here, mount, vpart_frame ) >= 0 );
        const int index = target.install_part( here, mount, vpart_compact_ASRG_containment );
        REQUIRE( index >= 0 );
        target.part( index ).enabled = false;
        const int64_t id = target.part( index ).get_base().uid().get_value();
        const vehicle_control_selection choice = electronic_choice( who, target, "reactor", true, id );
        fixture.run( who, control_request( fixture, who, choice ) );
        CHECK( target.part( index ).enabled );
        target.remove_part( target.part( index ) );
        const int replacement = target.install_part( here, mount, vpart_compact_ASRG_containment );
        REQUIRE( replacement >= 0 );
        target.part( replacement ).enabled = false;
        REQUIRE( target.part( replacement ).get_base().uid().get_value() != id );
        fixture.run( who, control_request( fixture, who, choice ) );
        CHECK_FALSE( target.part( replacement ).enabled );
    }
}

TEST_CASE( "owned_motorized_doors_keep_native_blocking_locking_and_group_rules",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const auto doors = target.get_avail_parts( "DOOR" );
    REQUIRE_FALSE( empty( doors ) );
    const int door = doors.begin()->part_index();
    const point_rel_ms mount = target.part( door ).mount;
    const int motor = target.install_part( here, mount, vpart_door_motor );
    REQUIRE( motor >= 0 );
    if( !target.part_has_lock( door ) ) {
        REQUIRE( target.install_part( here, mount, vpart_door_lock ) >= 0 );
    }
    const int64_t id = target.part( door ).get_base().uid().get_value();
    target.open( here, door );
    const vehicle_control_selection close = electronic_choice( who, target, "door_open", false, id );
    get_avatar().setpos( here, here.get_bub( target.abs_part_pos( target.part( door ) ) ) );
    fixture.run( who, control_request( fixture, who, close ) );
    CHECK( target.part( door ).open );
    CHECK_FALSE( recipient.feedback.pending.empty() );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    fixture.run( who, control_request( fixture, who, close ) );
    CHECK_FALSE( target.part( door ).open );
    fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "door_lock", true, id ) ) );
    CHECK( target.part( door ).locked );
    const std::string all_open = control_request( fixture, who, electronic_choice( who, target, "doors_open", true ) );
    fixture.run( who, all_open );
    CHECK_FALSE( target.part( door ).locked );
    CHECK( target.part( door ).open );
    fixture.run( who, all_open );
    CHECK( target.part( door ).open );
    fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "doors_and_curtains_close", false ) ) );
    CHECK_FALSE( target.part( door ).open );
    target.remove_part( target.part( motor ) );
    fixture.run( who, control_request( fixture, who, electronic_choice( who, target, "door_open", true, id ) ) );
    CHECK_FALSE( target.part( door ).open );
}

TEST_CASE( "remote_one_shot_electronics_uses_the_authorized_controller_once",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = radio_vehicle( who );
    const item_location controller = remote_controller( who );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        part.part().enabled = false;
    }
    fixture.run( who, radio_request( fixture, who, "action", target.uid().get_value() ) );
    REQUIRE( who.activity.id() == ACT_REMOTE_VEHICLE );
    vehicle_control_selection choice = electronic_choice( who, target, "CONE_LIGHT", true );
    choice.position = target.get_avail_parts( "REMOTE_CONTROLS" ).begin()->pos_abs();
    const int ammo = controller->ammo_remaining();
    const std::string request = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "vehicle_control", choice );
    } );
    fixture.run( who, request );
    CHECK_FALSE( who.activity );
    require_lights( target, true );
    CHECK( controller->ammo_remaining() == ammo - 1 );
    CHECK_FALSE( resolve_remote_vehicle( who, get_map() ) );
    fixture.run( who, request );
    CHECK( controller->ammo_remaining() == ammo - 1 );
}

TEST_CASE( "native_electronics_menu_dispatches_the_same_operator_command",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    vehicle &target = electronic_vehicle( who );
    for( const vpart_reference &part : target.get_avail_parts( "CONE_LIGHT" ) ) {
        part.part().enabled = false;
    }
    veh_menu menu( target, "test electronics" );
    target.build_electronics_menu( here, menu );
    require_lights( target, false );
    const auto entries = menu.get_items();
    const auto lights = std::find_if( entries.begin(), entries.end(), []( const veh_menu_item &entry ) {
        return entry._hotkey_action == "TOGGLE_HEADLIGHT";
    } );
    REQUIRE( lights != entries.end() );
    REQUIRE( lights->_enabled );
    REQUIRE( lights->_on_submit );
    lights->_on_submit();
    require_lights( target, true );
}

TEST_CASE( "planter_enabling_reads_the_operator_environment_instead_of_the_host",
           "[multiplayer][vehicle_electronics_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    vehicle &target = electronic_vehicle( who );
    const int planter = target.install_part( here, next_electronic_mount( target ), vpart_seed_drill );
    REQUIRE( planter >= 0 );
    who.setpos( here, tripoint_bub_ms( 50, 50, 0 ), false );
    here.ter_set( who.pos_bub(), ter_t_greenhouse_tilled );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, -1 ), false );
    REQUIRE( warm_enough_to_plant( who.pos_bub(), itype_seed_buckwheat ).success() );
    REQUIRE_FALSE( warm_enough_to_plant( get_avatar().pos_bub(), itype_seed_buckwheat ).success() );
    CHECK( can_enable_vehicle_part( who, here, target, target.part( planter ) ) );
    CHECK_FALSE( target.can_enable( here, target.part( planter ) ) );
    // Ordinary soil must forecast temperature without advancing wind or gameplay RNG.
    here.ter_set( who.pos_bub(), ter_t_dirt );
    const std::string rng = capture_rng_state();
    const int wind = weather_generator::current_winddir;
    vehicle_electronics_options( who, here, target );
    CHECK( capture_rng_state() == rng );
    CHECK( weather_generator::current_winddir == wind );
}

namespace
{
struct appliance_fixture : vehicle_control_fixture {
    restore_on_out_of_scope<time_point> saved_turn{ calendar::turn };
    appliance_fixture() {
        calendar::turn = calendar::turn_zero + 1_days;
    }
};

int install_test_appliance( Character &who, vehicle &target, const std::string &type )
{
    map &here = get_map();
    const point_rel_ms mount = next_electronic_mount( target );
    if( vpart_id( type )->location.str() != "structure" ) {
        REQUIRE( target.install_part( here, mount, vpart_frame ) >= 0 );
    }
    const auto allowed = target.can_mount( mount, vpart_id( type ).obj() );
    INFO( allowed.str() );
    REQUIRE( allowed.success() );
    const int index = target.install_part( here, mount, vpart_id( type ) );
    REQUIRE( index >= 0 );
    target.part( index ).enabled = false;
    here.add_vehicle_to_cache( &target );
    who.setpos( here, here.get_bub( target.abs_part_pos( target.part( index ) ) ) + tripoint_rel_ms( 0, 1, 0 ) );
    who.set_moves( 100 );
    return index;
}

void fill_appliance_water( vehicle &target, const itype_id &type = itype_water )
{
    for( const int index : target.fuel_containers ) {
        if( target.part( index ).is_tank() ) {
            target.part( index ).ammo_set( type, 100 );
            break;
        }
    }
    REQUIRE( target.fuel_left( get_map(), type ) == 100 );
}

vehicle_control_selection appliance_choice( Character &who, vehicle &target, int part,
        bool enabled, bool detergent = false, usage_from from = usage_from::player )
{
    vehicle_control_selection choice = control_choice( who, target, "appliance" );
    choice.position = target.abs_part_pos( target.part( part ) );
    choice.appliance = vehicle_appliance_selection{};
    choice.appliance->part_id = target.part( part ).get_base().uid().get_value();
    choice.appliance->enabled = enabled;
    if( detergent ) {
        choice.appliance->detergent = comp_selection<item_comp>{from, item_comp( itype_detergent, 5 )};
    }
    return choice;
}

void add_dirty_cargo( vehicle &target, int part, const itype_id &type = itype_tshirt )
{
    item cargo( type, calendar::turn );
    cargo.set_flag( flag_FILTHY );
    cargo.set_age( 30_minutes );
    REQUIRE( target.add_item( get_map(), target.part( part ), cargo ) );
}
} // namespace

TEST_CASE( "owned_washer_uses_operator_supplies_and_never_duplicates_start_costs",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "washing_machine" );
    fill_appliance_water( target );
    add_dirty_cargo( target, machine );
    who.i_add( item( itype_detergent, calendar::turn, 10 ) );
    // Adding supplies can wield them and spend the fixture's initial moves.
    who.set_moves( 100 );
    get_avatar().i_add( item( itype_detergent, calendar::turn, 20 ) );
    const std::string rng = capture_rng_state();
    const auto query = query_vehicle_appliance( who, get_map(), target,
                       target.abs_part_pos( target.part( machine ) ), target.part( machine ).get_base().uid().get_value() );
    REQUIRE( query );
    REQUIRE( query->appliance );
    REQUIRE( query->appliance->detergent );
    REQUIRE( valid_vehicle_appliance_selection( who, get_map(), target, query->position, *query->appliance ) );
    CHECK_FALSE( target.part( machine ).enabled );
    CHECK( target.fuel_left( get_map(), itype_water ) == 100 );
    CHECK( who.charges_of( itype_detergent ) == 10 );
    CHECK( capture_rng_state() == rng );
    const std::string request = control_request( fixture, who, *query );
    fixture.run( who, request );
    CHECK( target.part( machine ).enabled );
    CHECK( target.get_items( target.part( machine ) ).only_item().age() == 0_turns );
    CHECK( target.fuel_left( get_map(), itype_water ) == 76 );
    CHECK( who.charges_of( itype_detergent ) == 5 );
    CHECK( get_avatar().charges_of( itype_detergent ) == 20 );
    CHECK_FALSE( recipient.feedback.pending.empty() );
    fixture.run( who, request );
    // A new request with the same desired state is also a harmless no-op.
    fixture.run( who, control_request( fixture, who, *query ) );
    CHECK( target.fuel_left( get_map(), itype_water ) == 76 );
    CHECK( who.charges_of( itype_detergent ) == 5 );
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, false ) ) );
    CHECK_FALSE( target.part( machine ).enabled );
    CHECK( who.charges_of( itype_detergent ) == 5 );
}

TEST_CASE( "owned_washer_rejects_forged_or_stale_choices_without_consuming_resources",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "washing_machine" );
    fill_appliance_water( target );
    add_dirty_cargo( target, machine );
    who.i_add( item( itype_detergent, calendar::turn, 5 ) );
    // Adding supplies can wield them and spend the fixture's initial moves.
    who.set_moves( 100 );
    get_avatar().i_add( item( itype_detergent, calendar::turn, 20 ) );
    vehicle_control_selection choice = appliance_choice( who, target, machine, true, true );
    SECTION( "only the host has detergent" ) {
        who.use_charges( itype_detergent, 5 );
    }
    SECTION( "wrong quantity" ) {
        choice.appliance->detergent->comp.count = 0;
    }
    SECTION( "wrong material" ) {
        choice.appliance->detergent->comp.type = itype_water;
    }
    SECTION( "invalid source" ) {
        choice.appliance->detergent->use_from = usage_from::none;
    }
    SECTION( "operator left" ) {
        who.setpos( get_map(), tripoint_bub_ms( 100, 100, 0 ) );
    }
    SECTION( "operator has no moves" ) {
        who.set_moves( 0 );
    }
    SECTION( "locked vehicle" ) {
        target.is_locked = true;
    }
    SECTION( "replacement machine" ) {
        const point_rel_ms mount = target.part( machine ).mount;
        target.remove_part( target.part( machine ) );
        REQUIRE( target.install_part( get_map(), mount, vpart_washing_machine ) >= 0 );
    }
    const int detergent = who.charges_of( itype_detergent );
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK_FALSE( target.part( machine ).enabled );
    CHECK( target.fuel_left( get_map(), itype_water ) == 100 );
    CHECK( who.charges_of( itype_detergent ) == detergent );
    CHECK( get_avatar().charges_of( itype_detergent ) == 20 );
}

TEST_CASE( "owned_dishwasher_preserves_content_rules_and_mixed_source_selection",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "dishwasher" );
    fill_appliance_water( target, itype_water_clean );
    const bool soft = GENERATE( false, true );
    add_dirty_cargo( target, machine, itype_id( soft ? "tshirt" : "bio_power_storage" ) );
    who.i_add( item( itype_detergent, calendar::turn, 2 ) );
    // Adding supplies can wield them and spend the fixture's initial moves.
    who.set_moves( 100 );
    get_map().add_item_or_charges( who.pos_bub(), item( itype_detergent, calendar::turn, 3 ) );
    fixture.run( who, control_request( fixture, who,
                                       appliance_choice( who, target, machine, true, true, usage_from::both ) ) );
    CHECK( target.part( machine ).enabled == !soft );
    CHECK( target.fuel_left( get_map(), itype_water_clean ) == ( soft ? 100 : 76 ) );
    CHECK( who.charges_of( itype_detergent ) == ( soft ? 2 : 0 ) );
    CHECK( get_map().i_at( who.pos_bub() ).empty() == !soft );
}

TEST_CASE( "owned_autoclave_preserves_sterilization_preconditions",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "autoclave" );
    fill_appliance_water( target );
    item cbm( itype_bio_power_storage, calendar::turn );
    cbm.unset_flag( flag_FILTHY );
    cbm.unset_flag( json_flag_NO_PACKED );
    cbm.set_age( 30_minutes );
    bool valid = true;
    SECTION( "packed CBM" ) {}
    SECTION( "unpacked CBM" ) {
        cbm.set_flag( json_flag_NO_PACKED );
        valid = false;
    }
    SECTION( "filthy CBM" ) {
        cbm.set_flag( flag_FILTHY );
        valid = false;
    }
    REQUIRE( target.add_item( get_map(), target.part( machine ), cbm ) );
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, true ) ) );
    CHECK( target.part( machine ).enabled == valid );
    CHECK( target.fuel_left( get_map(), itype_water ) == ( valid ? 92 : 100 ) );
    CHECK( target.get_items( target.part( machine ) ).only_item().age() == ( valid ? 0_turns : 30_minutes ) );
}

TEST_CASE( "owned_cooker_checks_power_and_resets_nested_food_progress",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "app_electric_cooker" );
    item food( itype_meat, calendar::turn );
    food.set_var( "cook_energy_done", "123" );
    item jar( itype_jar_glass_sealed, calendar::turn );
    REQUIRE( jar.put_in( food, pocket_type::CONTAINER ).success() );
    REQUIRE( target.add_item( get_map(), target.part( machine ), jar ) );
    const bool powered = GENERATE( false, true );
    if( !powered ) {
        target.discharge_battery( get_map(), target.fuel_left( get_map(), itype_battery ) );
    }
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, true ) ) );
    CHECK( target.part( machine ).enabled == powered );
    const item &stored = target.get_items( target.part( machine ) ).only_item();
    const item *raw = stored.all_items_top( pocket_type::CONTAINER ).front();
    CHECK( raw->get_var( "cook_energy_done" ) == ( powered ? "0" : "123" ) );
}

TEST_CASE( "owned_weather_station_start_and_cancel_reuse_native_timer",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "veh_mobile_weather_station" );
    const std::string start = control_request( fixture, who, appliance_choice( who, target, machine, true ) );
    fixture.run( who, start );
    CHECK( target.part( machine ).enabled );
    REQUIRE( target.get_items( target.part( machine ) ).size() == 1 );
    CHECK( target.get_items( target.part( machine ) ).only_item().typeId() == itype_mws_weather_data_incomplete );
    CHECK( target.get_items( target.part( machine ) ).only_item().age() == 0_turns );
    fixture.run( who, start );
    CHECK( target.get_items( target.part( machine ) ).size() == 1 );
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, false ) ) );
    CHECK_FALSE( target.part( machine ).enabled );
}

TEST_CASE( "owned_boiler_outside_its_dimension_never_destroys_cargo",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "ap_nl_safehouse_boiler" );
    REQUIRE( target.add_item( get_map(), target.part( machine ), item( itype_rock, calendar::turn ) ) );
    const int battery = target.fuel_left( get_map(), itype_battery );
    fixture.run( who, control_request( fixture, who, appliance_choice( who, target, machine, true ) ) );
    CHECK( target.get_items( target.part( machine ) ).size() == 1 );
    CHECK( target.fuel_left( get_map(), itype_battery ) == battery );
}

TEST_CASE( "native_appliance_callback_uses_owned_command_and_stable_hardware_identity",
           "[multiplayer][vehicle_appliance_owned]" )
{
    appliance_fixture fixture;
    avatar &who = get_avatar();
    vehicle &target = electronic_vehicle( who );
    const int machine = install_test_appliance( who, target, "washing_machine" );
    fill_appliance_water( target );
    add_dirty_cargo( target, machine );
    who.i_add( item( itype_detergent, calendar::turn, 10 ) );
    // Adding supplies can wield them and spend the fixture's initial moves.
    who.set_moves( 100 );
    veh_menu menu( target, "appliances" );
    add_vehicle_appliance_menu( menu, get_map(), target, target.abs_part_pos( target.part( machine ) ) );
    const auto entries = menu.get_items();
    REQUIRE( entries.size() == 1 );
    CHECK_FALSE( target.part( machine ).enabled );
    const bool removed = GENERATE( false, true );
    if( removed ) {
        target.remove_part( target.part( machine ) );
    }
    entries.front()._on_submit();
    CHECK( who.charges_of( itype_detergent ) == ( removed ? 10 : 5 ) );
    CHECK( target.fuel_left( get_map(), itype_water ) == ( removed ? 100 : 76 ) );
}

namespace
{
int test_water_tank( vehicle &target, const itype_id &type = itype_water_clean, int amount = 4 )
{
    for( const vpart_reference &part : target.get_all_parts() ) {
        if( part.part().is_tank() ) {
            part.part().ammo_set( type, amount );
            REQUIRE( part.part().ammo_remaining() == amount );
            return part.part_index();
        }
    }
    FAIL( "water fixture needs a tank" );
    return -1;
}

vehicle_control_selection water_choice( Character &who, vehicle &target, int tool, int tank,
                                        const std::string &operation )
{
    vehicle_control_selection selected = control_choice( who, target, "water" );
    selected.position = target.abs_part_pos( target.part( tool ) );
    selected.water.emplace();
    selected.water->operation = operation;
    selected.water->tool = target.part( tool ).get_base().uid().get_value();
    selected.water->tank = target.part( tank ).get_base().uid().get_value();
    selected.water->liquid = target.part( tank ).get_base().only_item().uid().get_value();
    return selected;
}

vehicle_control_selection fill_water_choice( Character &who, vehicle &target, int tool, int tank,
        const item_location &container )
{
    vehicle_control_selection selected = water_choice( who, target, tool, tank, "fill" );
    selected.water->destination.emplace();
    selected.water->destination->kind = LD_ITEM;
    selected.water->destination->source = selected.water->liquid;
    selected.water->destination->container = capture_item_source( who, container );
    return selected;
}
}

TEST_CASE( "owned_faucet_transfer_keeps_native_rate_save_and_exact_resource_counts",
           "[multiplayer][vehicle_water_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int tap = install_test_appliance( who, target, "water_faucet" );
    const int tank = test_water_tank( target );
    const item_location bottle = who.i_add( item( itype_bottle_plastic, calendar::turn ) );
    REQUIRE( bottle );
    who.set_moves( 100 );
    const vehicle_control_selection choice = fill_water_choice( who, target, tap, tank, bottle );
    const std::string rng = capture_rng_state();
    REQUIRE( valid_vehicle_water_selection( who, get_map(), target, choice.position, *choice.water ) );
    CHECK( capture_rng_state() == rng );
    const std::string request = control_request( fixture, who, choice );
    fixture.run( who, request );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( who.activity.id() == ACT_FILL_LIQUID );
    CHECK( target.part( tank ).ammo_remaining() == 4 );
    CHECK( bottle->empty() );
    fixture.run( who, request );
    CHECK( target.part( tank ).ammo_remaining() == 4 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    REQUIRE_FALSE( bottle->empty() );
    CHECK( bottle->only_item().charges == 1 );
    CHECK( target.part( tank ).ammo_remaining() == 3 );
    CHECK( who.get_moves() == 0 );
    CHECK( fixture.reload.refresh_observers );
    fixture.run( who, step );
    CHECK( target.part( tank ).ammo_remaining() == 3 );
    save_reload_activity( who );
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( target.part( tank ).ammo_remaining() == 2 );
    CHECK( bottle->only_item().charges == 2 );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( target.part( tank ).ammo_remaining() == 2 );
    CHECK( bottle->only_item().charges == 2 );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_faucet_transfer_revalidates_access_and_source_each_turn",
           "[multiplayer][vehicle_water_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    vehicle &target = electronic_vehicle( who );
    const int tap = install_test_appliance( who, target, "water_faucet" );
    const int tank = test_water_tank( target );
    item_location bottle = who.i_add( item( itype_bottle_plastic, calendar::turn ) );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, fill_water_choice( who, target, tap, tank, bottle ) ) );
    REQUIRE( who.activity );
    SECTION( "faucet removed" ) {
        target.remove_part( target.part( tap ) );
    }
    SECTION( "liquid replaced in same tank" ) {
        target.part( tank ).ammo_unset();
        target.part( tank ).ammo_set( itype_water_clean, 4 );
    }
    SECTION( "operator left" ) {
        who.setpos( get_map(), tripoint_bub_ms( 100, 100, 0 ) );
    }
    SECTION( "destination no longer belongs to operator" ) {
        get_avatar().i_add( *bottle );
        bottle.remove_item();
    }
    SECTION( "cancel without moves" ) {
        who.set_moves( -5 );
        fixture.run( who, fixture.request( who, "cancel" ) );
    }
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( target.part( tank ).ammo_remaining() == 4 );
    if( bottle ) {
        CHECK( bottle->empty() );
    }
}

TEST_CASE( "owned_faucet_drinking_uses_remote_tank_and_only_operator_needs",
           "[multiplayer][vehicle_water_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int tap = install_test_appliance( who, target, "water_faucet" );
    const int tank = test_water_tank( target );
    who.set_thirst( 100 );
    target.is_locked = true; // Native faucets remain accessible on a locked car.
    const std::string host = needs_state( get_avatar() );
    vehicle_control_selection choice = water_choice( who, target, tap, tank, "drink" );
    fixture.run( who, control_request( fixture, who, choice ) );
    REQUIRE( cata_mp::owns_inventory_activity( who ) );
    CHECK( who.activity.id() == ACT_CONSUME );
    REQUIRE( who.activity.moves_left > 0 );
    CHECK( target.part( tank ).ammo_remaining() == 4 );
    save_reload_activity( who );
    const bool removed = GENERATE( false, true );
    if( removed ) {
        target.remove_part( target.part( tap ) );
    }
    const consumption_completion completed = finish_consumption( who, &fixture );
    const std::string &step = completed.request;
    REQUIRE_FALSE( who.activity );
    CHECK( target.part( tank ).ammo_remaining() == ( removed ? 4 : 3 ) );
    CHECK( fixture.reload.refresh_observers );
    CHECK( needs_state( get_avatar() ) == host );
    const std::string after = needs_state( who );
    fixture.run( who, step );
    CHECK( needs_state( who ) == after );
    CHECK( target.part( tank ).ammo_remaining() == ( removed ? 4 : 3 ) );
}

TEST_CASE( "owned_vehicle_purification_is_atomic_and_replays_without_power_loss",
           "[multiplayer][vehicle_water_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int tool = install_test_appliance( who, target, "water_purifier" );
    const int tank = test_water_tank( target, itype_water, 100 );
    const bool frozen = GENERATE( false, true );
    if( frozen ) {
        item_location base = item_location::from_vehicle_part( vehicle_cursor( target, tank ) );
        base->only_item().set_item_temperature( units::from_kelvin( 250 ) );
        REQUIRE( base->only_item().made_of( phase_id::SOLID ) );
    }
    const int cost = 100 * itype_water_purifier->charges_to_use();
    target.discharge_battery( get_map(), INT_MAX );
    const bool enough = GENERATE( false, true );
    target.charge_battery( get_map(), enough ? cost : cost - 1 );
    const int battery = target.fuel_left( get_map(), itype_battery );
    REQUIRE( battery == ( enough ? cost : cost - 1 ) );
    const vehicle_control_selection choice = water_choice( who, target, tool, tank, "purify" );
    const std::string request = control_request( fixture, who, choice );
    fixture.run( who, request );
    CHECK( target.part( tank ).ammo_current() == itype_id( enough ? "water_clean" : "water" ) );
    CHECK( target.part( tank ).ammo_remaining() == 100 );
    CHECK( target.fuel_left( get_map(), itype_battery ) == ( enough ? 0 : battery ) );
    fixture.run( who, request );
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK( target.fuel_left( get_map(), itype_battery ) == ( enough ? 0 : battery ) );
    CHECK( target.part( tank ).ammo_remaining() == 100 );
}

TEST_CASE( "owned_vehicle_water_rejects_forged_hardware_sources_and_destinations",
           "[multiplayer][vehicle_water_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    vehicle &target = electronic_vehicle( who );
    const int tap = install_test_appliance( who, target, "water_faucet" );
    const int tank = test_water_tank( target );
    const item_location bottle = who.i_add( item( itype_bottle_plastic, calendar::turn ) );
    who.set_moves( 100 );
    vehicle_control_selection choice = fill_water_choice( who, target, tap, tank, bottle );
    SECTION( "missing hardware identity" ) {
        choice.water->tool = 0;
    }
    SECTION( "wrong liquid identity" ) {
        choice.water->liquid++;
    }
    SECTION( "tank is not faucet" ) {
        choice.water->tool = choice.water->tank;
    }
    SECTION( "no purifier" ) {
        choice.water->operation = "purify";
        choice.water->destination.reset();
    }
    SECTION( "different fuel in tank" ) {
        target.part( tank ).ammo_set( itype_gasoline, 4 );
    }
    SECTION( "destination is source tank" ) {
        unload_liquid_choice &to = *choice.water->destination;
        to.kind = LD_VEH;
        to.vehicle = target.uid().get_value();
        to.tank = choice.water->tank;
    }
    SECTION( "destination outside reach" ) {
        choice.water->destination->kind = LD_GROUND;
        choice.water->destination->position = who.pos_abs() + tripoint_rel_ms( 10, 10, 0 );
    }
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK_FALSE( who.activity );
    CHECK( bottle->empty() );
    CHECK( target.part( tank ).ammo_remaining() == 4 );
}

TEST_CASE( "native_faucet_menu_uses_readonly_queries_and_owned_drinking",
           "[multiplayer][vehicle_water_owned]" )
{
    appliance_fixture fixture;
    avatar &who = get_avatar();
    vehicle &target = electronic_vehicle( who );
    const int tap = install_test_appliance( who, target, "water_faucet" );
    const int tank = test_water_tank( target );
    who.set_thirst( 100 );
    const std::string rng = capture_rng_state();
    veh_menu menu( target, "water" );
    add_vehicle_water_menu( menu, get_map(), target, target.abs_part_pos( target.part( tap ) ) );
    const auto entries = menu.get_items();
    REQUIRE( entries.size() == 2 );
    CHECK( capture_rng_state() == rng );
    CHECK( target.part( tank ).ammo_remaining() == 4 );
    const bool removed = GENERATE( false, true );
    if( removed ) {
        target.remove_part( target.part( tap ) );
    }
    entries[1]._on_submit();
    CHECK( static_cast<bool>( who.activity ) == !removed );
    CHECK( target.part( tank ).ammo_remaining() == 4 );
}

TEST_CASE( "legacy_actorless_liquid_save_still_executes_its_native_transfer",
           "[multiplayer][vehicle_water_owned]" )
{
    appliance_fixture fixture;
    avatar &who = get_avatar();
    vehicle &target = electronic_vehicle( who );
    install_test_appliance( who, target, "water_faucet" );
    const int tank = test_water_tank( target );
    item_location base = item_location::from_vehicle_part( vehicle_cursor( target, tank ) );
    const item_location bottle = who.i_add( item( itype_bottle_plastic, calendar::turn ) );
    who.set_moves( 100 );
    liquid_dest_opt destination;
    destination.dest_opt = LD_ITEM;
    destination.item_loc = bottle;
    REQUIRE( liquid_handler::perform_liquid_transfer( base->only_item(), nullptr, &target,
             tank, nullptr, destination, true ) );
    REQUIRE_FALSE( who.activity.actor );
    std::ostringstream encoded;
    JsonOut out( encoded );
    who.activity.serialize( out );
    JsonValue value = json_loader::from_string( encoded.str() );
    player_activity restored;
    restored.deserialize( value.get_object() );
    who.activity = std::move( restored );
    REQUIRE( who.activity.id() == ACT_FILL_LIQUID );
    REQUIRE_FALSE( who.activity.actor );
    CHECK( who.activity.execution() == activity_execution::local );
    who.activity.do_turn( who );
    REQUIRE_FALSE( bottle->empty() );
    CHECK( bottle->only_item().charges == 1 );
    CHECK( target.part( tank ).ammo_remaining() == 3 );
}

namespace
{
vehicle_control_selection heating_choice( Character &who, vehicle &target,
        const item_location &food, const std::string &tool = "hotplate" )
{
    REQUIRE( who.wear_item( item( itype_backpack ), false ).has_value() );
    const int part = install_test_appliance( who, target, "veh_tools_kitchen" );
    auto &tools = target.get_tools( target.part( part ) );
    tools.emplace_back( itype_id( tool ), calendar::turn );
    target.discharge_battery( get_map(), INT_MAX );
    target.charge_battery( get_map(), 10000 );
    vehicle_control_selection choice = control_choice( who, target, "heating" );
    choice.position = target.abs_part_pos( target.part( part ) );
    choice.heating = vehicle_heating_selection{};
    choice.heating->part = target.part( part ).get_base().uid().get_value();
    choice.heating->installed_tool = tools.back().uid().get_value();
    choice.heating->tool = tool;
    choice.heating->method = itype_id( tool )->get_use( "HEAT_SOLID_ITEMS" ) ?
                             "HEAT_SOLID_ITEMS" : "HOTPLATE";
    choice.heating->items.emplace_back( capture_item_source( who, food ), 1 );
    set_time_to_day();
    REQUIRE( who.fine_detail_vision_mod() <= 4 );
    who.set_moves( 100 );
    return choice;
}

std::pair<std::string, std::string> finish_vehicle_heating( reload_fixture &fixture, Character &who )
{
    REQUIRE( is_vehicle_heating( who.activity ) );
    for( int turn = 0; who.activity.moves_left > 100 && turn < 2000; ++turn ) {
        who.set_moves( 100 );
        calendar::turn += 1_seconds;
        who.activity.do_turn( who );
        REQUIRE( who.activity );
    }
    REQUIRE( who.activity.moves_left <= 100 );
    who.set_moves( 100 );
    const std::string request = fixture.request( who, "step" );
    const std::string response = fixture.run( who, request );
    REQUIRE( ( !who.activity || vehicle_heating_liquid( who.activity ) ) );
    return {request, response};
}
} // namespace

TEST_CASE( "mounted_heating_owns_food_power_duration_and_saved_completion",
           "[multiplayer][vehicle_heating_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_apple, calendar::turn, 2 ) );
    item_location food = who.get_wielded_item();
    food->set_item_temperature( units::from_kelvin( 280 ) );
    vehicle &target = electronic_vehicle( who );
    const vehicle_control_selection choice = heating_choice( who, target, food );
    const std::string host = needs_state( get_avatar() );
    const units::mass mass = food->count_by_charges() ? food->weight( false, false ) / food->charges :
                             food->weight( false, false );
    const heating_requirements required = heating_requirements_for_weight( 0_gram, mass, food->volume( false, true, 1 ) );
    const int battery = target.fuel_left( get_map(), itype_battery );
    const std::string rng = capture_rng_state();
    CHECK( valid_vehicle_heating( who, get_map(), target, choice.position, *choice.heating ) );
    CHECK( capture_rng_state() == rng );
    const std::string start = control_request( fixture, who, choice );
    fixture.run( who, start );
    REQUIRE( is_vehicle_heating( who.activity ) );
    CHECK( who.activity.moves_total == required.time );
    CHECK( target.fuel_left( get_map(), itype_battery ) == battery );
    fixture.run( who, start );
    save_reload_activity( who );
    const auto completed = finish_vehicle_heating( fixture, who );
    CHECK_FALSE( who.activity );
    CHECK( target.fuel_left( get_map(), itype_battery ) ==
           battery - required.ammo * itype_hotplate->charges_to_use() );
    const auto hot = who.items_with( []( const item &it ) {
        return it.typeId() == itype_apple && it.has_own_flag( flag_HOT );
    } );
    REQUIRE( hot.size() == 1 );
    CHECK( hot.front()->count() == 1 );
    const int remaining = target.fuel_left( get_map(), itype_battery );
    fixture.run( who, completed.first );
    CHECK( target.fuel_left( get_map(), itype_battery ) == remaining );
    CHECK( needs_state( get_avatar() ) == host );
}

TEST_CASE( "mounted_heating_cancels_without_loss_when_inputs_or_access_change",
           "[multiplayer][vehicle_heating_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    item_location food = drinking_source( who );
    food->set_item_temperature( units::from_kelvin( 280 ) );
    vehicle &target = electronic_vehicle( who );
    const vehicle_control_selection choice = heating_choice( who, target, food );
    fixture.run( who, control_request( fixture, who, choice ) );
    REQUIRE( is_vehicle_heating( who.activity ) );
    // Resolve by stable identity without retaining a part pointer across mutation.
    int index = -1;
    for( const vpart_reference &entry : target.get_all_parts() ) {
        if( entry.part().get_base().uid().get_value() == choice.heating->part ) {
            index = entry.part_index();
        }
    }
    REQUIRE( index >= 0 );
    SECTION( "heater removed" ) {
        target.remove_part( target.part( index ) );
    }
    SECTION( "installed tool replaced" ) {
        target.get_tools( target.part( index ) ).clear();
        target.get_tools( target.part( index ) ).emplace_back( itype_hotplate );
    }
    SECTION( "operator moved away" ) {
        who.setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 5, 0, 0 ) );
    }
    SECTION( "power exhausted" ) {
        target.discharge_battery( get_map(), INT_MAX );
    }
    SECTION( "selected portion disappeared" ) {
        food->charges = 0;
    }
    SECTION( "cancel without moves" ) {
        who.set_moves( 0 );
        fixture.run( who, fixture.request( who, "cancel" ) );
    }
    const int battery = target.fuel_left( get_map(), itype_battery );
    const int charges = food->charges;
    if( who.activity ) {
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
    }
    CHECK_FALSE( who.activity );
    CHECK( target.fuel_left( get_map(), itype_battery ) == battery );
    CHECK( food->charges == charges );
    CHECK_FALSE( food->has_own_flag( flag_HOT ) );
}

TEST_CASE( "mounted_heating_preserves_liquid_until_owner_choice_and_replays_without_duplication",
           "[multiplayer][vehicle_heating_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    item_location food = drinking_source( who );
    food->set_item_temperature( units::from_kelvin( 280 ) );
    vehicle &target = electronic_vehicle( who );
    const vehicle_control_selection choice = heating_choice( who, target, food );
    fixture.run( who, control_request( fixture, who, choice ) );
    finish_vehicle_heating( fixture, who );
    REQUIRE( food->charges == 1 );
    REQUIRE( vehicle_heating_liquid( who.activity ) );
    CHECK( vehicle_heating_liquid( who.activity )->charges == 1 );
    CHECK( vehicle_heating_liquid( who.activity )->has_own_flag( flag_HOT ) );
    const int battery = target.fuel_left( get_map(), itype_battery );
    save_reload_activity( who );
    const item *pending = vehicle_heating_liquid( who.activity );
    REQUIRE( pending );
    item_location bottle = who.i_add( item( itype_bottle_plastic ) );
    unload_liquid_choice destination;
    destination.source = pending->uid().get_value();
    destination.kind = LD_ITEM;
    destination.container = capture_item_source( who, bottle );
    who.set_moves( 100 );
    const std::string request = fixture.request( who, "choose", [&]( JsonOut & out ) {
        out.member( "liquid", destination );
    } );
    fixture.run( who, request );
    REQUIRE_FALSE( who.activity );
    REQUIRE_FALSE( bottle->empty() );
    CHECK( bottle->only_item().charges == 1 );
    CHECK( bottle->only_item().has_own_flag( flag_HOT ) );
    fixture.run( who, request );
    CHECK( bottle->only_item().charges == 1 );
    CHECK( target.fuel_left( get_map(), itype_battery ) == battery );
}

TEST_CASE( "mounted_heating_rejects_forged_requests_before_consuming_resources",
           "[multiplayer][vehicle_heating_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    item_location food = drinking_source( who );
    vehicle &target = electronic_vehicle( who );
    vehicle_control_selection choice = heating_choice( who, target, food );
    SECTION( "wrong tool identity" ) { ++choice.heating->installed_tool; }
    SECTION( "missing hardware" ) { choice.heating->part = 0; }
    SECTION( "unavailable method" ) { choice.heating->method = "HEAT_ALL_ITEMS"; }
    SECTION( "oversized portion" ) { choice.heating->items.front().second = 999; }
    SECTION( "duplicate item" ) { choice.heating->items.push_back( choice.heating->items.front() ); }
    SECTION( "another player's item" ) {
        choice.heating->items.front().first = capture_item_source( get_avatar(), drinking_source( get_avatar() ) );
    }
    SECTION( "locked electric vehicle" ) { target.is_locked = true; }
    const int battery = target.fuel_left( get_map(), itype_battery );
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK_FALSE( who.activity );
    CHECK( food->charges == 2 );
    CHECK( target.fuel_left( get_map(), itype_battery ) == battery );
}

TEST_CASE( "canceling_saved_heated_liquid_keeps_the_result_and_does_not_refund_spent_energy",
           "[multiplayer][vehicle_heating_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    item_location food = drinking_source( who );
    food->set_item_temperature( units::from_kelvin( 280 ) );
    vehicle &target = electronic_vehicle( who );
    const vehicle_control_selection choice = heating_choice( who, target, food );
    fixture.run( who, control_request( fixture, who, choice ) );
    const auto completed = finish_vehicle_heating( fixture, who );
    REQUIRE( vehicle_heating_liquid( who.activity ) );
    const int64_t output_id = vehicle_heating_liquid( who.activity )->uid().get_value();
    const JsonValue view = json_loader::from_string( completed.second );
    const JsonObject state = view.get_object();
    state.allow_omitted_members();
    CHECK( state.get_int64( "liquid_source_uid" ) == output_id );
    save_reload_activity( who );
    const int battery = target.fuel_left( get_map(), itype_battery );
    who.set_moves( 0 );
    fixture.run( who, fixture.request( who, "cancel" ) );
    CHECK_FALSE( who.activity );
    int spilled = 0;
    for( const item &it : get_map().i_at( who.pos_bub() ) ) {
        if( it.typeId() == itype_water_clean ) {
            spilled += it.charges;
            CHECK( it.has_own_flag( flag_HOT ) );
        }
    }
    CHECK( spilled == 1 );
    CHECK( food->charges == 1 );
    CHECK( target.fuel_left( get_map(), itype_battery ) == battery );
}

TEST_CASE( "legacy_portable_heating_actor_still_loads_and_finishes",
           "[vehicle_heating_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    REQUIRE( who.wear_item( item( itype_backpack ), false ).has_value() );
    who.set_wielded_item( item( itype_hotplate, calendar::turn ) );
    item_location food = who.i_add( item( itype_apple, calendar::turn, 1 ) );
    food->set_item_temperature( units::from_kelvin( 280 ) );
    heating_requirements required{ 0_ml, 0, 100 };
    heater source{ who.get_wielded_item(), false, 0, 0, {}, false };
    who.assign_activity( heat_activity_actor( {{food, 1}}, required, source ) );
    std::ostringstream encoded;
    JsonOut out( encoded );
    who.activity.serialize( out );
    JsonValue value = json_loader::from_string( encoded.str() );
    player_activity restored;
    restored.deserialize( value.get_object() );
    REQUIRE( dynamic_cast<heat_activity_actor *>( restored.actor.get() ) );
    CHECK_FALSE( is_vehicle_heating( restored ) );
    who.activity = std::move( restored );
    who.set_moves( 100 );
    who.activity.do_turn( who );
    CHECK_FALSE( who.activity );
    CHECK( who.items_with( []( const item &it ) {
        return it.typeId() == itype_apple && it.has_own_flag( flag_HOT );
    } ).size() == 1 );
}

TEST_CASE( "item_source_search_range_remains_native_operation_owned",
           "[vehicle_heating_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    const tripoint_bub_ms location = who.pos_bub() + tripoint_rel_ms( 2, 0, 0 );
    item &placed = get_map().add_item_or_charges( location, item( itype_apple, calendar::turn, 1 ) );
    item_location source( map_cursor( location ), &placed );
    const item_source identity = capture_item_source( who, source );
    CHECK_FALSE( resolve_item_source( who, get_map(), identity ) );
    CHECK( resolve_item_source( who, get_map(), identity, 3 ) == source );
    // Ground items are shared by nearby players, but the range belongs to the
    // acting character and cannot be extended by a distant player's request.
    CHECK( resolve_item_source( get_avatar(), get_map(), identity, 3 ) == source );
    get_avatar().setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 10, 0, 0 ) );
    CHECK_FALSE( resolve_item_source( get_avatar(), get_map(), identity, 3 ) );
}

TEST_CASE( "mounted_hotplate_charges_startup_once_and_preserves_legacy_position_handoff",
           "[multiplayer][vehicle_heating_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    item_location food = drinking_source( who );
    food->set_item_temperature( units::from_kelvin( 280 ) );
    vehicle &target = electronic_vehicle( who );
    const int gas_tank = install_test_appliance( who, target, "small_pressure_tank" );
    target.part( gas_tank ).ammo_set( itype_propane, 1000 );
    REQUIRE( target.part( gas_tank ).ammo_remaining() == 1000 );
    const itype_id &tool = itype_test_vehicle_hotplate_startup;
    const vehicle_control_selection choice = heating_choice( who, target, food, tool.str() );
    REQUIRE( choice.heating->method == "HOTPLATE" );
    const int before = target.fuel_left( get_map(), itype_propane );
    const int initial = item( tool ).ammo_required();
    REQUIRE( initial > 0 );
    const heating_requirements required = heating_requirements_for_weight( 0_gram,
                          food->weight( false, false ) / food->charges, food->volume( false, true, 1 ) );
    const std::string start = control_request( fixture, who, choice );
    fixture.run( who, start );
    REQUIRE( is_vehicle_heating( who.activity ) );
    CHECK( target.fuel_left( get_map(), itype_propane ) == before - initial );
    fixture.run( who, start );
    save_reload_activity( who );
    CHECK( target.fuel_left( get_map(), itype_propane ) == before - initial );
    finish_vehicle_heating( fixture, who );
    CHECK( target.fuel_left( get_map(), itype_propane ) ==
           before - initial - required.ammo * tool->charges_to_use() );
    who.cancel_activity();

    avatar &local = get_avatar();
    local.setpos( get_map(), get_map().get_bub( choice.position ) + tripoint_rel_ms( 0, 1, 0 ) );
    heating_requirements legacy_cost{ 0_ml, 0, 100 };
    heater old_source{ {}, false, 0, 0, {}, true };
    local.assign_activity( heat_activity_actor( {}, legacy_cost, old_source ) );
    REQUIRE( vehicle::use_vehicle_tool( target, &get_map(), get_map().get_bub( choice.position ),
                                        tool, true ) );
    REQUIRE( local.activity.coords.size() == 1 );
    CHECK( local.activity.coords.front() == choice.position );
}

namespace
{
item_location repair_fixture_target( Character &who )
{
    REQUIRE( who.wear_item( item( itype_backpack ), false ).has_value() );
    set_time_to_day();
    REQUIRE( who.fine_detail_vision_mod() <= 1 );
    item_location target = who.i_add( item( itype_pot ) );
    REQUIRE( target );
    target->set_damage( 2 * itype::damage_scale );
    target->set_degradation( 0 );
    for( int i = 0; i < 10; ++i ) {
        who.i_add( item( itype_steel_chunk ) );
    }
    REQUIRE( who.charges_of( itype_steel_chunk ) == 10 );
    who.set_moves( 100 );
    return target;
}

item_location repair_fixture_tool( Character &who )
{
    item tool( itype_test_owned_repair_tool );
    tool.ammo_set( itype_battery, 1000 );
    const item_location result = who.i_add( tool );
    REQUIRE( result );
    REQUIRE( result->ammo_remaining() == 1000 );
    who.set_moves( 100 );
    return result;
}

std::string repair_start_request( reload_fixture &fixture, Character &who, const item_location &tool )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", "repair_metal" );
        out.member( "target", who.pos_abs() );
    } );
}

repair_activity_choice repair_choice( Character &who, const item_location &target )
{
    repair_activity_choice result;
    result.target = capture_item_source( who, target );
    result.repeat = static_cast<int>( repair_repeat::ONCE );
    result.material = { usage_from::player, item_comp( itype_steel_chunk, 1 ) };
    return result;
}

std::string repair_choose_request( reload_fixture &fixture, Character &who,
                                   const repair_activity_choice &choice )
{
    return fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "repair_choice", choice );
    } );
}

repair_activity_actor &repair_actor( Character &who )
{
    auto *actor = dynamic_cast<repair_activity_actor *>( who.activity.actor.get() );
    REQUIRE( who.activity );
    REQUIRE( actor );
    return *actor;
}

vehicle_control_selection mounted_repair_choice( Character &who, vehicle &target,
        const itype_id &type = itype_test_owned_repair_tool )
{
    const int part = install_test_appliance( who, target, "veh_tools_workshop" );
    auto &tools = target.get_tools( target.part( part ) );
    tools.emplace_back( type );
    target.discharge_battery( get_map(), INT_MAX );
    target.charge_battery( get_map(), 10000 );
    vehicle_control_selection result = control_choice( who, target, "repair" );
    result.position = target.abs_part_pos( target.part( part ) );
    result.repair.emplace();
    result.repair->vehicle_id = result.vehicle_id;
    result.repair->position = result.position;
    result.repair->part = target.part( part ).get_base().uid().get_value();
    result.repair->installed_tool = tools.back().uid().get_value();
    result.repair->tool = tools.back().typeId().str();
    result.repair->method = "repair_metal";
    who.set_moves( 100 );
    return result;
}
} // namespace

TEST_CASE( "owned_portable_repair_keeps_choices_resources_and_saved_progress_with_its_player",
           "[multiplayer][repair_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    const item_location target = repair_fixture_target( who );
    const item_location tool = repair_fixture_tool( who );
    const std::string host_before = needs_state( get_avatar() );
    const std::string start = repair_start_request( fixture, who, tool );
    const std::string started = fixture.run( who, start );
    REQUIRE( repair_actor( who ).waiting );
    JsonValue response = json_loader::from_string( started );
    JsonObject data = response.get_object();
    data.allow_omitted_members();
    REQUIRE( data.has_object( "repair_prompt" ) );
    repair_activity_actor prompt;
    prompt.read( data.get_object( "repair_prompt" ) );
    CHECK( prompt.source.portable.path == repair_actor( who ).source.portable.path );
    fixture.run( who, start );
    CHECK( tool->ammo_remaining() == 1000 );
    const std::string choose = repair_choose_request( fixture, who, repair_choice( who, target ) );
    fixture.run( who, choose );
    REQUIRE_FALSE( repair_actor( who ).waiting );
    CHECK( who.activity.moves_total == 100 );
    fixture.run( who, choose );
    save_reload_activity( who );
    who.set_moves( 100 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    REQUIRE( repair_actor( who ).waiting );
    CHECK( target->damage() == itype::damage_scale );
    CHECK( who.charges_of( itype_steel_chunk ) == 9 );
    CHECK( tool->ammo_remaining() == 1000 - tool->ammo_required() );
    fixture.run( who, step );
    CHECK( target->damage() == itype::damage_scale );
    CHECK( who.charges_of( itype_steel_chunk ) == 9 );
    CHECK( needs_state( get_avatar() ) == host_before );
    who.set_moves( 0 );
    fixture.run( who, fixture.request( who, "cancel" ) );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "owned_repair_rejects_another_players_items_and_unavailable_material_choices",
           "[multiplayer][repair_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    const item_location target = repair_fixture_target( who );
    const item_location tool = repair_fixture_tool( who );
    fixture.run( who, repair_start_request( fixture, who, tool ) );
    repair_activity_choice choice = repair_choice( who, target );
    SECTION( "another player's target" ) {
        choice.target = capture_item_source( get_avatar(), repair_fixture_target( get_avatar() ) );
    }
    SECTION( "unrelated component type" ) { choice.material.comp.type = itype_apple; }
    SECTION( "unavailable nearby components" ) { choice.material.use_from = usage_from::map; }
    SECTION( "invalid repeat mode" ) { choice.repeat = 2; }
    SECTION( "refitting a rigid pot" ) { choice.repeat = static_cast<int>( repair_repeat::REFIT_ONCE ); }
    const std::string random_before = capture_rng_state();
    fixture.run( who, repair_choose_request( fixture, who, choice ) );
    CHECK( repair_actor( who ).waiting );
    CHECK( capture_rng_state() == random_before );
    CHECK( who.charges_of( itype_steel_chunk ) == 10 );
    CHECK( target->damage() == 2 * itype::damage_scale );
    CHECK( tool->ammo_remaining() == 1000 );
}

TEST_CASE( "mounted_repair_bills_the_selected_vehicle_once_and_keeps_inventory_tool_power",
           "[multiplayer][repair_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    const item_location target = repair_fixture_target( who );
    const item_location carried_tool = repair_fixture_tool( who );
    vehicle &car = electronic_vehicle( who );
    const vehicle_control_selection selected = mounted_repair_choice( who, car );
    const int before = car.fuel_left( get_map(), itype_battery );
    const std::string random_before = capture_rng_state();
    CHECK( valid_vehicle_repair( who, get_map(), car, selected.position, *selected.repair ) );
    CHECK( capture_rng_state() == random_before );
    fixture.run( who, control_request( fixture, who, selected ) );
    fixture.run( who, repair_choose_request( fixture, who, repair_choice( who, target ) ) );
    REQUIRE_FALSE( repair_actor( who ).waiting );
    save_reload_activity( who );
    who.set_moves( 100 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    REQUIRE( repair_actor( who ).waiting );
    CHECK( car.fuel_left( get_map(), itype_battery ) == before - carried_tool->ammo_required() );
    CHECK( carried_tool->ammo_remaining() == 1000 );
    CHECK( who.charges_of( itype_steel_chunk ) == 9 );
    CHECK( target->damage() == itype::damage_scale );
    fixture.run( who, step );
    CHECK( car.fuel_left( get_map(), itype_battery ) == before - carried_tool->ammo_required() );
}

TEST_CASE( "mounted_repair_rechecks_hardware_access_and_materials_before_attempting",
           "[multiplayer][repair_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    const item_location target = repair_fixture_target( who );
    vehicle &car = electronic_vehicle( who );
    const vehicle_control_selection selected = mounted_repair_choice( who, car );
    fixture.run( who, control_request( fixture, who, selected ) );
    fixture.run( who, repair_choose_request( fixture, who, repair_choice( who, target ) ) );
    REQUIRE_FALSE( repair_actor( who ).waiting );
    const int before = car.fuel_left( get_map(), itype_battery );
    SECTION( "owner moved away" ) { who.setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 8, 0, 0 ) ); }
    SECTION( "locked vehicle" ) { car.is_locked = true; }
    SECTION( "removed hardware" ) {
        for( const vpart_reference &part : car.get_all_parts() ) {
            if( part.part().get_base().uid().get_value() == selected.repair->part ) {
                car.remove_part( part.part() );
                break;
            }
        }
    }
    SECTION( "replaced installed tool" ) {
        for( const vpart_reference &part : car.get_all_parts() ) {
            if( part.part().get_base().uid().get_value() == selected.repair->part ) {
                car.get_tools( part.part() ).clear();
                car.get_tools( part.part() ).emplace_back( itype_test_owned_repair_tool );
                break;
            }
        }
    }
    SECTION( "material moved out of reach" ) {
        for( item *component : who.items_with( []( const item &it ) {
        return it.typeId() == itype_steel_chunk;
        } ) ) {
            item_location( who, component ).remove_item();
        }
        who.invalidate_crafting_inventory();
    }
    // TEST_DATA's completion event consumes RNG even without a repair attempt.
    // Observe after its callback, immediately before the actor settles the work.
    reload_events events;
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( target->damage() == 2 * itype::damage_scale );
    CHECK( car.fuel_left( get_map(), itype_battery ) == before );
    REQUIRE( events.finishes == 1 );
    REQUIRE( events.rng_at_finish );
    CHECK( capture_rng_state() == *events.rng_at_finish );
    CHECK( ( !who.activity || repair_actor( who ).waiting ) );
}

TEST_CASE( "owned_repair_preserves_native_attempt_and_random_sequence",
           "[multiplayer][repair_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    item_location target = repair_fixture_target( who );
    item_location tool = repair_fixture_tool( who );
    who.set_skill_level( skill_fabrication, 10 );
    fixture.run( who, repair_start_request( fixture, who, tool ) );
    fixture.run( who, repair_choose_request( fixture, who, repair_choice( who, target ) ) );
    const auto *native = dynamic_cast<const repair_item_actor *>(
                             tool->get_use( "repair_metal" )->get_actor_ptr() );
    REQUIRE( native );
    const std::string random_before = capture_rng_state();
    REQUIRE( native->repair( who, *tool, target ) == repair_item_actor::AS_SUCCESS );
    tool->consume_tool_uses( 1, get_map(), who.pos_bub(), &who );
    const std::string expected_rng = capture_rng_state();
    const int expected_damage = target->damage();
    const int expected_ammo = tool->ammo_remaining();
    const int expected_components = who.charges_of( itype_steel_chunk );
    target->set_damage( 2 * itype::damage_scale );
    tool->ammo_set( itype_battery, 1000 );
    who.i_add( item( itype_steel_chunk ) );
    who.invalidate_crafting_inventory();
    restore_rng_state( random_before );
    repair_actor( who ).finish( who.activity, who );
    CHECK( target->damage() == expected_damage );
    CHECK( tool->ammo_remaining() == expected_ammo );
    CHECK( who.charges_of( itype_steel_chunk ) == expected_components );
    CHECK( capture_rng_state() == expected_rng );
}

TEST_CASE( "actorless_legacy_repair_still_loads_and_completes",
           "[multiplayer][repair_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    const item_location target = repair_fixture_target( who );
    const item_location tool = repair_fixture_tool( who );
    who.assign_activity( ACT_REPAIR_ITEM, 100 );
    who.activity.targets = { tool, target };
    who.activity.str_values = { "repair_metal" };
    who.activity.values = { static_cast<int>( repair_repeat::ONCE ) };
    std::ostringstream encoded;
    JsonOut out( encoded );
    who.activity.serialize( out );
    JsonValue value = json_loader::from_string( encoded.str() );
    player_activity restored;
    restored.deserialize( value.get_object() );
    REQUIRE( restored.id() == ACT_REPAIR_ITEM );
    REQUIRE_FALSE( restored.actor );
    who.activity = std::move( restored );
    repair_item_finish( &who.activity, &who, true );
    CHECK_FALSE( who.activity );
    CHECK( target->damage() == itype::damage_scale );
    CHECK( tool->ammo_remaining() == 1000 - tool->ammo_required() );
}

TEST_CASE( "owned_repair_repeat_and_refit_stop_at_the_native_completion_boundary",
           "[multiplayer][repair_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    item_location target = repair_fixture_target( who );
    const item_location tool = repair_fixture_tool( who );
    const bool refit = GENERATE( false, true );
    if( refit ) {
        target = who.i_add( item( itype_lc_chainmail_vest ) );
        REQUIRE( target );
        target->set_damage( 2 * itype::damage_scale );
        target->set_degradation( 0 );
        target->unset_flag( flag_FIT );
        REQUIRE( target->has_flag( flag_VARSIZE ) );
        who.i_add( item( itype_lc_chain_link ) );
    }
    who.set_moves( 100 );
    fixture.run( who, repair_start_request( fixture, who, tool ) );
    repair_activity_choice choice = repair_choice( who, target );
    choice.repeat = static_cast<int>( refit ? repair_repeat::REFIT_FULL : repair_repeat::FULL );
    if( refit ) {
        choice.material.comp.type = itype_lc_chain_link;
    }
    // Quantities are derived by the server, even if a client supplies a forged one.
    choice.material.comp.count = -999;
    fixture.run( who, repair_choose_request( fixture, who, choice ) );
    REQUIRE_FALSE( repair_actor( who ).waiting );
    const int attempts = refit ? 1 : 2;
    for( int i = 0; i < attempts; ++i ) {
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
    }
    REQUIRE( repair_actor( who ).waiting );
    CHECK( target->damage() == ( refit ? 2 * itype::damage_scale : 0 ) );
    if( refit ) {
        CHECK( target->has_flag( flag_FIT ) );
    }
    CHECK( who.charges_of( itype_steel_chunk ) == ( refit ? 10 : 10 - attempts ) );
    if( refit ) {
        CHECK( who.amount_of( itype_lc_chain_link ) == 0 );
    }
    CHECK( tool->ammo_remaining() == 1000 - attempts * tool->ammo_required() );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( tool->ammo_remaining() == 1000 - attempts * tool->ammo_required() );
}

TEST_CASE( "mounted_multimag_repair_consumes_each_bound_resource_once",
           "[multiplayer][repair_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    const item_location target = repair_fixture_target( who );
    vehicle &car = electronic_vehicle( who );
    test_water_tank( car, itype_gasoline, 1000 );
    const vehicle_control_selection selected = mounted_repair_choice( who, car, itype_test_owned_multimag_repair_tool );
    const int battery = car.fuel_left( get_map(), itype_battery );
    const int fuel = car.fuel_left( get_map(), itype_gasoline );
    fixture.run( who, control_request( fixture, who, selected ) );
    fixture.run( who, repair_choose_request( fixture, who, repair_choice( who, target ) ) );
    REQUIRE_FALSE( repair_actor( who ).waiting );
    save_reload_activity( who );
    who.set_moves( 100 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    CHECK( target->damage() == itype::damage_scale );
    CHECK( car.fuel_left( get_map(), itype_battery ) == battery - 2 );
    CHECK( car.fuel_left( get_map(), itype_gasoline ) == fuel - 5 );
    fixture.run( who, step );
    CHECK( car.fuel_left( get_map(), itype_battery ) == battery - 2 );
    CHECK( car.fuel_left( get_map(), itype_gasoline ) == fuel - 5 );
}

TEST_CASE( "repair_resize_uses_the_operator_body_instead_of_the_host",
           "[multiplayer][repair_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    get_avatar().set_mutation( trait_SMALL2 );
    REQUIRE( get_avatar().get_size() == creature_size::tiny );
    REQUIRE( who.get_size() == creature_size::medium );
    item clothing( itype_lc_chainmail_vest );
    clothing.set_flag( flag_FIT );
    clothing.set_flag( flag_UNDERSIZE );
    REQUIRE( clothing.has_flag( flag_VARSIZE ) );
    item tool( itype_test_owned_repair_tool );
    const auto *native = dynamic_cast<const repair_item_actor *>(
                             tool.get_use( "repair_metal" )->get_actor_ptr() );
    REQUIRE( native );
    CHECK( native->default_action( who, clothing, 10 ) == repair_item_actor::RT_UPSIZING );
    CHECK( native->default_action( get_avatar(), clothing, 10 ) != repair_item_actor::RT_UPSIZING );
}

namespace
{
item empty_station_tool()
{
    item tool( itype_welder );
    tool.clear_items();
    tool.set_damage( itype::damage_scale );
    tool.set_var( "station_test_owner", "remote" );
    REQUIRE( tool.empty() );
    REQUIRE( tool.toolmods().empty() );
    return tool;
}

vehicle_control_selection station_choice( Character &who, vehicle &target, int part )
{
    vehicle_control_selection choice = control_choice( who, target, "toolstation" );
    choice.position = target.abs_part_pos( target.part( part ) );
    choice.toolstation.emplace();
    choice.toolstation->part_id = target.part( part ).get_base().uid().get_value();
    return choice;
}
} // namespace

TEST_CASE( "owned_vehicle_tool_transfers_follow_the_operator_and_ignore_repeated_requests",
           "[multiplayer][vehicle_toolstation_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    REQUIRE( who.wear_item( item( itype_backpack ), false ).has_value() );
    vehicle &target = electronic_vehicle( who );
    const int station = install_test_appliance( who, target, "veh_tools_workshop" );
    target.is_locked = true; // Native tool attachment does not require the ignition key.
    const item_location tool = who.i_add( empty_station_tool() );
    REQUIRE( tool );
    vehicle_control_selection attach = station_choice( who, target, station );
    attach.toolstation->source = capture_item_source( who, tool );
    const std::string request = control_request( fixture, who, attach );
    const int moves = who.get_moves();
    fixture.run( who, request );
    REQUIRE( target.get_tools( target.part( station ) ).size() == 1 );
    CHECK( who.amount_of( itype_welder ) == 0 );
    CHECK( get_avatar().amount_of( itype_welder ) == 0 );
    CHECK( who.get_moves() == moves );
    CHECK_FALSE( resolve_item_source( who, get_map(), *attach.toolstation->source ) );
    CHECK( target.get_tools( target.part( station ) ).front().damage() == itype::damage_scale );
    CHECK( target.get_tools( target.part( station ) ).front().get_var( "station_test_owner" ) == "remote" );
    fixture.run( who, request );
    fixture.run( who, control_request( fixture, who, attach ) );
    REQUIRE( target.get_tools( target.part( station ) ).size() == 1 );

    vehicle_control_selection detach = station_choice( who, target, station );
    detach.toolstation->tool_id = target.get_tools( target.part( station ) ).front().uid().get_value();
    const std::string removal = control_request( fixture, who, detach );
    fixture.run( who, removal );
    CHECK( target.get_tools( target.part( station ) ).empty() );
    REQUIRE( who.amount_of( itype_welder ) == 1 );
    const auto received = who.items_with( []( const item &candidate ) {
        return candidate.typeId() == itype_welder;
    } );
    REQUIRE( received.size() == 1 );
    CHECK( received.front()->damage() == itype::damage_scale );
    CHECK( received.front()->get_var( "station_test_owner" ) == "remote" );
    fixture.run( who, removal );
    fixture.run( who, control_request( fixture, who, detach ) );
    CHECK( who.amount_of( itype_welder ) == 1 );
    CHECK( get_avatar().amount_of( itype_welder ) == 0 );
}

TEST_CASE( "owned_vehicle_tool_attachment_revalidates_item_rules_and_player_access",
           "[multiplayer][vehicle_toolstation_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    REQUIRE( who.wear_item( item( itype_backpack ), false ).has_value() );
    vehicle &target = electronic_vehicle( who );
    const int station = install_test_appliance( who, target, "veh_tools_workshop" );
    item_location tool = who.i_add( empty_station_tool() );
    REQUIRE( tool );
    vehicle_control_selection choice = station_choice( who, target, station );
    choice.toolstation->source = capture_item_source( who, tool );
    REQUIRE( valid_vehicle_tool_selection( who, get_map(), target, choice.position, *choice.toolstation ) );
    SECTION( "another player's tool" ) {
        get_avatar().set_wielded_item( empty_station_tool() );
        choice.toolstation->source = capture_item_source( get_avatar(), get_avatar().get_wielded_item() );
    }
    SECTION( "tool is no longer empty" ) {
        item wrench( itype_cordless_impact_wrench );
        item battery( itype_heavy_battery_cell );
        battery.ammo_set( itype_battery, 20 );
        REQUIRE( wrench.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
        REQUIRE_FALSE( wrench.empty() );
        const item_location loaded = who.i_add( wrench );
        REQUIRE( loaded );
        choice.toolstation->source = capture_item_source( who, loaded );
    }
    SECTION( "unsupported item" ) {
        choice.toolstation->source = capture_item_source( who, who.i_add( item( itype_rock ) ) );
    }
    SECTION( "same tool type already attached" ) {
        target.get_tools( target.part( station ) ).push_back( empty_station_tool() );
    }
    SECTION( "owner moved out of reach" ) {
        who.setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 6, 0, 0 ) );
    }
    SECTION( "station identity changed" ) { ++choice.toolstation->part_id; }
    SECTION( "station removed" ) { target.remove_part( target.part( station ) ); }
    SECTION( "attach and detach supplied together" ) { choice.toolstation->tool_id = tool->uid().get_value(); }
    SECTION( "wrong command action" ) { choice.action = "start"; }
    SECTION( "vehicle belongs to someone else" ) {
        who.set_fac( faction_free_merchants );
        target.set_owner( get_avatar() );
        REQUIRE_FALSE( target.is_owned_by( who ) );
    }
    const size_t installed = target.get_tools( target.part( station ) ).size();
    const std::string random_before = capture_rng_state();
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK( target.get_tools( target.part( station ) ).size() == installed );
    CHECK( who.amount_of( itype_welder ) == 1 );
    CHECK( capture_rng_state() == random_before );
}

TEST_CASE( "owned_vehicle_tool_detachment_rejects_stale_or_foreign_hardware",
           "[multiplayer][vehicle_toolstation_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    vehicle &target = electronic_vehicle( who );
    const int station = install_test_appliance( who, target, "veh_tools_workshop" );
    target.get_tools( target.part( station ) ).push_back( empty_station_tool() );
    vehicle_control_selection choice = station_choice( who, target, station );
    choice.toolstation->tool_id = target.get_tools( target.part( station ) ).front().uid().get_value();
    SECTION( "same type replaced the selected tool" ) {
        target.get_tools( target.part( station ) ).clear();
        target.get_tools( target.part( station ) ).push_back( empty_station_tool() );
        REQUIRE( target.get_tools( target.part( station ) ).front().uid().get_value() != choice.toolstation->tool_id );
    }
    SECTION( "tool belongs to another station" ) {
        const int other = install_test_appliance( who, target, "veh_tools_workshop" );
        target.get_tools( target.part( other ) ).push_back( empty_station_tool() );
        choice.toolstation->tool_id = target.get_tools( target.part( other ) ).front().uid().get_value();
        who.setpos( get_map(), get_map().get_bub( choice.position ) );
    }
    SECTION( "no installed identity" ) { choice.toolstation->tool_id = 0; }
    SECTION( "hardware removed" ) { target.remove_part( target.part( station ) ); }
    SECTION( "out of reach" ) { who.setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 6, 0, 0 ) ); }
    const size_t installed = target.get_tools( target.part( station ) ).size();
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK( target.get_tools( target.part( station ) ).size() == installed );
    CHECK( who.amount_of( itype_welder ) == 0 );
    CHECK( get_avatar().amount_of( itype_welder ) == 0 );
}

TEST_CASE( "owned_vehicle_tool_detachment_keeps_native_overflow_placement",
           "[multiplayer][vehicle_toolstation_owned]" )
{
    appliance_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_rock ) );
    vehicle &target = electronic_vehicle( who );
    const int station = install_test_appliance( who, target, "veh_tools_workshop" );
    target.get_tools( target.part( station ) ).push_back( empty_station_tool() );
    REQUIRE_FALSE( who.can_pickVolume( target.get_tools( target.part( station ) ).front(), false ) );
    vehicle_control_selection choice = station_choice( who, target, station );
    choice.toolstation->tool_id = target.get_tools( target.part( station ) ).front().uid().get_value();
    const std::string request = control_request( fixture, who, choice );
    fixture.run( who, request );
    fixture.run( who, request );
    CHECK( target.get_tools( target.part( station ) ).empty() );
    int found = 0;
    for( const item &tool : get_map().i_at( who.pos_bub() ) ) {
        if( tool.typeId() == itype_welder ) {
            ++found;
            CHECK( tool.damage() == itype::damage_scale );
            CHECK( tool.get_var( "station_test_owner" ) == "remote" );
        }
    }
    CHECK( found == 1 );
    CHECK( get_avatar().amount_of( itype_welder ) == 0 );
}

TEST_CASE( "vehicle_tool_menu_does_not_eject_items_before_an_explicit_detach",
           "[multiplayer][vehicle_toolstation_owned]" )
{
    appliance_fixture fixture;
    avatar &who = get_avatar();
    vehicle &target = electronic_vehicle( who );
    const int station = install_test_appliance( who, target, "veh_tools_workshop" );
    target.get_tools( target.part( station ) ).emplace_back( itype_rock );
    const int64_t identity = target.get_tools( target.part( station ) ).front().uid().get_value();
    veh_menu menu( target, "toolstation" );
    target.build_interact_menu( menu, &get_map(), get_map().get_bub( target.abs_part_pos(
                                    target.part( station ) ) ), false );
    REQUIRE( target.get_tools( target.part( station ) ).size() == 1 );
    CHECK( target.get_tools( target.part( station ) ).front().uid().get_value() == identity );
    CHECK( who.amount_of( itype_rock ) == 0 );
    vehicle_control_selection choice = station_choice( who, target, station );
    choice.toolstation->tool_id = identity;
    REQUIRE( execute_vehicle_control( who, get_map(), choice ) );
    CHECK( target.get_tools( target.part( station ) ).empty() );
}

namespace
{
vehicle_control_selection instant_tool_choice( Character &who, vehicle &target, int part )
{
    vehicle_control_selection choice = control_choice( who, target, "tool_use" );
    choice.position = target.abs_part_pos( target.part( part ) );
    const auto options = vehicle_tool_use_options( target, choice.position );
    REQUIRE( options.size() == 1 );
    choice.tool_use = options.front();
    REQUIRE( valid_vehicle_tool_use( who, get_map(), target, choice.position, *choice.tool_use ) );
    return choice;
}
} // namespace

TEST_CASE( "mounted_towels_clean_only_the_operator_and_do_not_repeat_requests",
           "[multiplayer][vehicle_tool_use_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const bool installed = GENERATE( false, true );
    const int part = install_test_appliance( who, target,
                     installed ? "veh_tools_kitchen" : "towel_hanger" );
    if( installed ) {
        target.get_tools( target.part( part ) ).emplace_back( itype_towel );
    }
    vehicle_control_selection choice = instant_tool_choice( who, target, part );
    CHECK( ( choice.tool_use->installed_tool != 0 ) == installed );
    target.is_locked = true; // Unpowered tools do not require the ignition key.
    who.add_effect( effect_slimed, 10_minutes );
    get_avatar().add_effect( effect_slimed, 10_minutes );
    const int host_moves = get_avatar().get_moves();
    const int power = target.battery_left( get_map() );
    const std::string request = control_request( fixture, who, choice );
    fixture.run( who, request );
    CHECK_FALSE( who.has_effect( effect_slimed ) );
    CHECK( who.get_moves() == 50 );
    CHECK( get_avatar().has_effect( effect_slimed ) );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK( target.battery_left( get_map() ) == power );
    who.add_effect( effect_slimed, 10_minutes );
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( who.has_effect( effect_slimed ) );
    CHECK( who.get_moves() == 50 );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "mounted_weather_readings_charge_the_selected_vehicle_and_reach_the_operator",
           "[multiplayer][vehicle_tool_use_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    vehicle &target = electronic_vehicle( who );
    const int part = install_test_appliance( who, target, "veh_mobile_weather_station" );
    const vehicle_control_selection choice = instant_tool_choice( who, target, part );
    const int power = target.battery_left( get_map() );
    REQUIRE( power > 1 );
    Messages::clear_messages();
    recipient.feedback.pending.clear();
    const std::string request = control_request( fixture, who, choice );
    fixture.run( who, request );
    CHECK( target.battery_left( get_map() ) == power - 1 );
    CHECK_FALSE( recipient.feedback.pending.empty() );
    CHECK( Messages::recent_messages( 10 ).empty() );
    CHECK( who.get_moves() == 100 );
    fixture.run( who, request );
    CHECK( target.battery_left( get_map() ) == power - 1 );
}

TEST_CASE( "mounted_tools_reject_changed_hardware_access_and_forged_actions_before_effects",
           "[multiplayer][vehicle_tool_use_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &target = electronic_vehicle( who );
    const int part = install_test_appliance( who, target, "veh_mobile_weather_station" );
    vehicle_control_selection choice = instant_tool_choice( who, target, part );
    const std::string failure = GENERATE( "part", "installed", "type", "method", "action", "removed",
                                          "distance", "locked", "owner", "power", "incorporeal" );
    CAPTURE( failure );
    if( failure == "part" ) {
        ++choice.tool_use->part;
    } else if( failure == "installed" ) {
        choice.tool_use->installed_tool = target.part( part ).get_base().uid().get_value();
    } else if( failure == "type" ) {
        choice.tool_use->tool = "towel";
    } else if( failure == "method" ) {
        choice.tool_use->method = "HOTPLATE";
    } else if( failure == "action" ) {
        choice.action = "stop";
    } else if( failure == "removed" ) {
        target.remove_part( target.part( part ) );
    } else if( failure == "distance" ) {
        who.setpos( get_map(), tripoint_bub_ms( 30, 30, 0 ) );
    } else if( failure == "locked" ) {
        target.is_locked = true;
    } else if( failure == "owner" ) {
        target.set_owner( faction_no_faction );
    } else if( failure == "power" ) {
        target.discharge_battery( get_map(), target.battery_left( get_map() ) );
    } else if( failure == "incorporeal" ) {
        who.add_effect( effect_incorporeal, 1_hours );
    }
    const std::string rng = capture_rng_state();
    const int power = target.battery_left( get_map() );
    CHECK_FALSE( execute_vehicle_control( who, get_map(), choice ) );
    CHECK( target.battery_left( get_map() ) == power );
    CHECK( who.get_moves() == 100 );
    CHECK_FALSE( who.activity );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "mounted_tool_menu_is_readonly_and_revalidates_installed_identity",
           "[multiplayer][vehicle_tool_use_owned]" )
{
    vehicle_control_fixture fixture;
    avatar &who = get_avatar();
    vehicle &target = electronic_vehicle( who );
    const int part = install_test_appliance( who, target, "veh_tools_kitchen" );
    auto &tools = target.get_tools( target.part( part ) );
    tools.emplace_back( itype_towel );
    const vehicle_control_selection choice = instant_tool_choice( who, target, part );
    who.add_effect( effect_slimed, 10_minutes );
    const std::string rng = capture_rng_state();
    veh_menu menu( target, "tool fixture" );
    add_vehicle_tool_use_menu( menu, get_map(), target, choice.position );
    const auto entries = menu.get_items();
    REQUIRE( entries.size() == 1 );
    REQUIRE( entries.front()._enabled );
    REQUIRE( entries.front()._on_submit );
    CHECK( capture_rng_state() == rng );
    CHECK( who.has_effect( effect_slimed ) );
    SECTION( "native menu uses the same operation" ) {
        entries.front()._on_submit();
        CHECK_FALSE( who.has_effect( effect_slimed ) );
        CHECK( who.get_moves() == 50 );
    }
    SECTION( "a replacement of the same type is not the selected tool" ) {
        tools.clear();
        tools.emplace_back( itype_towel );
        entries.front()._on_submit();
        CHECK( who.has_effect( effect_slimed ) );
        CHECK( who.get_moves() == 100 );
    }
    SECTION( "client submits a choice without applying local gameplay" ) {
        cata_mp::set_client_mode( true );
        const std::string before = capture_rng_state();
        entries.front()._on_submit();
        CHECK( who.has_effect( effect_slimed ) );
        CHECK( capture_rng_state() == before );
        CHECK( g->multiplayer_session().client_inventory_activity.pending_request != 0 );
    }
}

TEST_CASE( "portable_weather_and_towels_use_the_same_owned_native_callbacks",
           "[multiplayer][vehicle_tool_use_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    who.set_wielded_item( item( itype_towel ) );
    who.add_effect( effect_slimed, 10_minutes );
    CHECK( execute_owned_item_activation( who, who.get_wielded_item(), "TOWEL", who.pos_abs(), false, false ) );
    CHECK_FALSE( who.has_effect( effect_slimed ) );
    CHECK( who.get_wielded_item()->is_filthy() );
    CHECK( who.get_wielded_item()->has_flag( flag_WET ) );
    CHECK( who.get_moves() == 50 );
    who.set_wielded_item( item( itype_hygrometer ) );
    CHECK( execute_owned_item_activation( who, who.get_wielded_item(), "WEATHER_TOOL", who.pos_abs(),
                                          false, false ) );
    CHECK( who.get_moves() == 50 );
}

namespace
{
item_location portable_saw( Character &who )
{
    item saw( itype_reciprocating_saw );
    item battery( itype_heavy_battery_cell );
    battery.ammo_set( itype_battery, 100 );
    REQUIRE( saw.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    who.set_wielded_item( saw );
    REQUIRE( who.get_wielded_item()->type->get_use( "HACKSAW" ) );
    return who.get_wielded_item();
}

std::string saw_request( reload_fixture &fixture, Character &who, const tripoint_abs_ms &target )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, who.get_wielded_item() ) );
        out.member( "item_type", who.get_wielded_item()->typeId() );
        out.member( "method", "HACKSAW" );
        out.member( "target", target );
    } );
}

vehicle_control_selection mounted_saw_choice( Character &who, vehicle &car,
        const std::string &type = "reciprocating_saw" )
{
    const int part = install_test_appliance( who, car, "veh_tools_workshop" );
    car.get_tools( car.part( part ) ).emplace_back( itype_id( type ) );
    vehicle_control_selection choice = control_choice( who, car, "tool_use" );
    choice.position = car.abs_part_pos( car.part( part ) );
    const auto source = capture_mounted_tool( car, choice.position, itype_id( type ), "HACKSAW" );
    REQUIRE( source );
    choice.tool_use = source->tool;
    choice.tool_use->target = who.pos_abs() + tripoint::south;
    get_map().furn_set( get_map().get_bub( *choice.tool_use->target ), furn_test_f_hacksaw2 );
    REQUIRE( valid_vehicle_tool_use( who, get_map(), car, choice.position, *choice.tool_use ) );
    return choice;
}
} // namespace

TEST_CASE( "owned_sawing_preserves_progress_and_bills_the_selected_source_once",
           "[multiplayer][hacksaw_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    const item_location carried = portable_saw( who );
    vehicle &car = electronic_vehicle( who );
    const vehicle_control_selection choice = mounted_saw_choice( who, car );
    const bool mounted = GENERATE( false, true );
    const auto target = *choice.tool_use->target;
    const int power = car.battery_left( get_map() );
    const int personal = carried->ammo_remaining();
    const int host_moves = get_avatar().get_moves();
    const std::string request = mounted ? control_request( fixture, who, choice ) : saw_request( fixture, who, target );
    fixture.run( who, request );
    REQUIRE( who.activity.id() == ACT_HACKSAW );
    CHECK( who.activity.execution() == activity_execution::authoritative );
    CHECK( who.activity.moves_left == to_moves<int>( 5_minutes ) / 2 );
    CHECK( who.activity.exertion_level() == LIGHT_EXERCISE );
    const int progress = who.activity.moves_left;
    fixture.run( who, request );
    CHECK( who.activity.moves_left == progress );
    save_reload_activity( who );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( who.activity.moves_left < progress );
    CHECK( car.battery_left( get_map() ) == power - ( mounted ? 1 : 0 ) );
    CHECK( carried->ammo_remaining() == personal - ( mounted ? 0 : 1 ) );
    save_reload_activity( who );
    who.activity.moves_left = 1;
    who.set_moves( 100 );
    const std::string finish = fixture.request( who, "step" );
    fixture.run( who, finish );
    CHECK_FALSE( who.activity );
    CHECK( get_map().furn( get_map().get_bub( target ) ) == furn_test_f_hacksaw1 );
    CHECK( car.battery_left( get_map() ) == power - ( mounted ? 2 : 0 ) );
    CHECK( carried->ammo_remaining() == personal - ( mounted ? 0 : 2 ) );
    const std::string rng = capture_rng_state();
    fixture.run( who, finish );
    CHECK( capture_rng_state() == rng );
    CHECK( get_avatar().get_moves() == host_moves );
}

TEST_CASE( "owned_sawing_cancels_stale_hardware_and_changed_targets_without_charge",
           "[multiplayer][hacksaw_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = electronic_vehicle( who );
    const vehicle_control_selection choice = mounted_saw_choice( who, car );
    fixture.run( who, control_request( fixture, who, choice ) );
    REQUIRE( who.activity );
    save_reload_activity( who );
    const std::string failure = GENERATE( "installed_tool", "part", "target", "range", "locked" );
    CAPTURE( failure );
    if( failure == "installed_tool" || failure == "part" ) {
        for( const vpart_reference &part : car.get_all_parts() ) {
            if( part.part().get_base().uid().get_value() == choice.tool_use->part ) {
                if( failure == "part" ) {
                    car.remove_part( part.part() );
                } else {
                    auto &tools = car.get_tools( part.part() );
                    tools.clear();
                    tools.emplace_back( itype_reciprocating_saw );
                }
                break;
            }
        }
    } else if( failure == "target" ) {
        get_map().furn_set( get_map().get_bub( *choice.tool_use->target ), furn_test_f_hacksaw3 );
    } else if( failure == "range" ) {
        who.setpos( get_map(), tripoint_bub_ms( 30, 30, 0 ) );
    } else {
        car.is_locked = true;
    }
    const int power = car.battery_left( get_map() );
    const furn_id surface = get_map().furn( get_map().get_bub( *choice.tool_use->target ) );
    who.activity.moves_left = 1;
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( car.battery_left( get_map() ) == power );
    CHECK( get_map().furn( get_map().get_bub( *choice.tool_use->target ) ) == surface );
}

TEST_CASE( "owned_sawing_rebinds_resumed_work_between_portable_and_mounted_tools",
           "[multiplayer][hacksaw_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = electronic_vehicle( who );
    const vehicle_control_selection choice = mounted_saw_choice( who, car );
    who.set_wielded_item( item( itype_test_hacksaw ) );
    const auto target = *choice.tool_use->target;
    fixture.run( who, saw_request( fixture, who, target ) );
    REQUIRE( who.activity );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    const int remaining = who.activity.moves_left;
    fixture.run( who, fixture.request( who, "cancel" ) );
    REQUIRE_FALSE( who.activity );
    REQUIRE_FALSE( who.backlog.empty() );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, choice ) );
    REQUIRE( who.activity );
    CHECK( who.activity.moves_left == remaining / 2 );
    save_reload_activity( who );
    const int power = car.battery_left( get_map() );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( car.battery_left( get_map() ) == power - 1 );
    const int mounted_remaining = who.activity.moves_left;
    fixture.run( who, fixture.request( who, "cancel" ) );
    who.set_moves( 100 );
    fixture.run( who, saw_request( fixture, who, target ) );
    REQUIRE( who.activity );
    CHECK( who.activity.moves_left == mounted_remaining * 2 );
    const int after = car.battery_left( get_map() );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( car.battery_left( get_map() ) == after );
}

TEST_CASE( "mounted_sawing_does_not_keep_unpaid_progress_and_bills_all_fuel_pockets",
           "[multiplayer][hacksaw_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = electronic_vehicle( who );
    test_water_tank( car, itype_gasoline, 1000 );
    const vehicle_control_selection choice = mounted_saw_choice( who, car, "test_owned_multimag_saw" );
    fixture.run( who, control_request( fixture, who, choice ) );
    REQUIRE( who.activity );
    const int battery = car.battery_left( get_map() );
    const int fuel = car.fuel_left( get_map(), itype_gasoline );
    who.set_moves( 100 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    CHECK( car.battery_left( get_map() ) == battery - 2 );
    CHECK( car.fuel_left( get_map(), itype_gasoline ) == fuel - 5 );
    const int progress = who.activity.moves_left;
    fixture.run( who, step );
    CHECK( who.activity.moves_left == progress );
    car.discharge_battery( get_map(), car.battery_left( get_map() ) );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    REQUIRE_FALSE( who.backlog.empty() );
    CHECK( who.backlog.front().moves_left == progress );
    CHECK( car.fuel_left( get_map(), itype_gasoline ) == fuel - 5 );
    car.charge_battery( get_map(), 100 );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, choice ) );
    REQUIRE( who.activity );
    CHECK( who.activity.moves_left == progress );
}

TEST_CASE( "owned_portable_sawing_rechecks_saved_sources_and_competing_work",
           "[multiplayer][hacksaw_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    const item_location tool = portable_saw( who );
    const auto pos = who.pos_bub() + tripoint_rel_ms( 0, 1, 0 );
    get_map().furn_set( pos, furn_test_f_hacksaw2 );
    fixture.run( who, saw_request( fixture, who, get_map().get_abs( pos ) ) );
    REQUIRE( who.activity );
    save_reload_activity( who );
    SECTION( "lost tool after saving" ) {
        who.remove_weapon();
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( get_map().furn( pos ) == furn_test_f_hacksaw2 );
    }
    SECTION( "another player completes the same surface" ) {
        avatar &host = get_avatar();
        host.setpos( get_map(), pos + tripoint_rel_ms( 0, 1, 0 ) );
        portable_saw( host );
        REQUIRE( start_hacksaw_work( host, host.get_wielded_item(), get_map().get_abs( pos ) ) );
        host.activity.moves_left = 1;
        host.set_moves( 100 );
        host.activity.do_turn( host );
        CHECK_FALSE( host.activity );
        const int personal = tool->ammo_remaining();
        who.activity.moves_left = 1;
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( get_map().furn( pos ) == furn_test_f_hacksaw1 );
        CHECK( tool->ammo_remaining() == personal );
    }
}

TEST_CASE( "legacy_saw_saves_acquire_owned_sources_and_resume_saved_progress",
           "[multiplayer][hacksaw_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = electronic_vehicle( who );
    const vehicle_control_selection choice = mounted_saw_choice( who, car );
    const bool mounted = GENERATE( false, true );
    const bool already_paused = GENERATE( false, true );
    CAPTURE( mounted, already_paused );
    const item_location portable = mounted ? item_location::nowhere : portable_saw( who );
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    out.member( "target", get_map().get_bub( *choice.tool_use->target ) );
    out.member( "tool", portable );
    out.member( "type", mounted ? std::make_optional( itype_reciprocating_saw ) :
                std::nullopt );
    out.member( "veh_pos", mounted ? std::make_optional( get_map().get_bub( choice.position ) ) :
                std::nullopt );
    out.member( "moves_left", 500 );
    out.end_object();
    JsonValue value = json_loader::from_string( stream.str() );
    const auto actor = hacksaw_activity_actor::deserialize( value );
    who.activity = player_activity( *actor );
    who.activity.moves_total = 1000;
    who.activity.moves_left = 500;
    const int power = car.battery_left( get_map() );
    if( !already_paused ) {
        who.set_moves( 100 );
        who.activity.do_turn( who );
        REQUIRE( who.activity );
        CHECK( who.activity.exertion_level() == LIGHT_EXERCISE );
    }
    CHECK( car.battery_left( get_map() ) == power - ( mounted && !already_paused ? 1 : 0 ) );
    const int remaining = who.activity.moves_left;
    who.cancel_activity();
    who.set_moves( 100 );
    if( mounted ) {
        REQUIRE( execute_vehicle_control( who, get_map(), choice ) );
    } else {
        REQUIRE( start_hacksaw_work( who, portable, *choice.tool_use->target ) );
    }
    CHECK( who.activity.moves_left == remaining );
    save_reload_activity( who );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_saw_target_validation_and_client_selection_do_not_apply_gameplay",
           "[multiplayer][hacksaw_owned]" )
{
    vehicle_control_fixture fixture;
    avatar &who = get_avatar();
    who.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    who.set_moves( 100 );
    const item_location source = portable_saw( who );
    const tripoint_abs_ms pos = who.pos_abs() + tripoint::south;
    get_map().furn_set( get_map().get_bub( pos ), furn_test_f_hacksaw2 );
    const int ammo = source->ammo_remaining();
    SECTION( "invalid target" ) {
        const tripoint_abs_ms own_position = who.pos_abs();
        const auto target = GENERATE_COPY( own_position, pos + tripoint( 0, 8, 0 ),
                                           own_position + tripoint::east );
        const std::string rng = capture_rng_state();
        fixture.run( who, saw_request( fixture, who, target ) );
        CHECK_FALSE( who.activity );
        CHECK( source->ammo_remaining() == ammo );
        CHECK( capture_rng_state() == rng );
    }
    SECTION( "explicit client target submits without local work" ) {
        cata_mp::set_client_mode( true );
        const std::string rng = capture_rng_state();
        std::string method = "HACKSAW";
        REQUIRE( cata_mp::client_activate_item( source, method, pos ) );
        CHECK( source->ammo_remaining() == ammo );
        CHECK( get_map().furn( get_map().get_bub( pos ) ) == furn_test_f_hacksaw2 );
        CHECK( capture_rng_state() == rng );
        CHECK( who.activity.execution() == activity_execution::presentation );
    }
}

TEST_CASE( "saw_resume_progress_is_set_before_callbacks_and_does_not_overwrite_replacement_activity",
           "[multiplayer][hacksaw_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = electronic_vehicle( who );
    const vehicle_control_selection choice = mounted_saw_choice( who, car );
    who.set_wielded_item( item( itype_test_hacksaw ) );
    fixture.run( who, saw_request( fixture, who, *choice.tool_use->target ) );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    const int remaining = who.activity.moves_left;
    fixture.run( who, fixture.request( who, "cancel" ) );
    class replace_on_resume : public event_subscriber {
        public:
            Character &who;
            int expected;
            bool fired = false;
            replace_on_resume( Character &who, int expected ) : who( who ), expected( expected ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::character_starts_activity &&
                    event.get<bool>( "resume" ) && event.get<character_id>( "character" ) == who.getID() ) {
                    fired = true;
                    CHECK( who.activity.moves_left == expected );
                    who.activity = player_activity( ACT_WAIT, 777 );
                }
            }
    } replacement( who, remaining / 2 );
    who.set_moves( 100 );
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK( replacement.fired );
    CHECK( who.activity.id() == ACT_WAIT );
    CHECK( who.activity.moves_left == 777 );
}

namespace
{
struct owned_turret_fixture : vehicle_control_fixture {
    vehicle &rig( Character &who, units::angle direction = 0_degrees ) {
        map &here = get_map();
        vehicle *car = here.add_vehicle( vehicle_prototype_test_turret_rig,
                                         tripoint_bub_ms( 60, 60, 0 ), direction, 0,
                                         veh_spawn_status::PRISTINE, false, true );
        REQUIRE( car );
        REQUIRE( car->install_part( here, point_rel_ms::zero, vpart_controls ) >= 0 );
        car->set_owner( who.get_faction()->id );
        car->is_locked = false;
        car->charge_battery( here, 1000, false );
        who.setpos( here, car->bub_part_pos( here, 0 ) );
        who.set_moves( 100 );
        return *car;
    }
    int install( vehicle &car, const point_rel_ms &mount = point_rel_ms::zero ) {
        map &here = get_map();
        if( mount != point_rel_ms::zero ) {
            REQUIRE( car.install_part( here, mount, vpart_turret_mount ) >= 0 );
        }
        const int index = car.install_part( here, mount, vpart_turret_test_multimag_turret_gun );
        REQUIRE( index >= 0 );
        item gun( car.part( index ).get_base() );
        gun.faults.clear();
        gun.set_flag( json_flag_NEVER_JAMS );
        item magazine( itype_glockmag );
        magazine.ammo_set( itype_9mm, 15 );
        REQUIRE( gun.put_in( magazine, pocket_type::MAGAZINE_WELL ).success() );
        car.part( index ).set_base( std::move( gun ) );
        car.part( index ).enabled = false;
        REQUIRE( car.turret_query( car.part( index ) ).query() == turret_data::status::ready );
        return index;
    }
    vehicle_control_selection choice( Character &who, vehicle &car, int index,
                                      const std::string &operation ) {
        vehicle_control_selection result = control_choice( who, car, operation == "fire_direct" ? "turret_direct" : "turret" );
        result.position = car.abs_part_pos( car.part( index ) );
        vehicle_turret_selection selected;
        selected.operation = operation;
        selected.operator_position = who.pos_abs();
        selected.turrets.push_back( capture_vehicle_turret( car, car.part( index ) ) );
        if( operation != "targeting" && operation != "mode" ) {
            selected.target = result.position + tripoint( 0, 5, 0 );
        }
        result.turret = selected;
        return result;
    }
};
} // namespace

TEST_CASE( "owned_turret_configuration_is_explicit_and_does_not_take_another_drivers_controls",
           "[multiplayer][vehicle_turret_owned]" )
{
    owned_turret_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = fixture.rig( who );
    const int index = fixture.install( car );
    const int control = car.install_part( get_map(), point_rel_ms::zero, vpart_controls_turret );
    REQUIRE( control >= 0 );
    avatar &driver = get_avatar();
    driver.setpos( get_map(), who.pos_bub() );
    driver.controlling_vehicle = true;
    who.setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 1, 0, 0 ) );
    const int driver_moves = driver.get_moves();
    vehicle_control_selection choice = fixture.choice( who, car, index, "targeting" );
    choice.turret->turrets.front().automatic = true;
    const std::string rng = capture_rng_state();
    REQUIRE( valid_vehicle_turret_control( who, get_map(), car, *choice.turret ) );
    CHECK( capture_rng_state() == rng );
    CHECK_FALSE( car.part( index ).enabled );
    const std::string request = control_request( fixture, who, choice );
    fixture.run( who, request );
    CHECK( car.part( index ).enabled );
    CHECK( car.part( control ).enabled );
    fixture.run( who, request );
    CHECK( car.part( index ).enabled );
    CHECK( car.part( index ).target.first == car.part( index ).target.second );
    choice = fixture.choice( who, car, index, "mode" );
    choice.turret->turrets.front().mode = gun_mode_BURST;
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK( car.part( index ).get_base().gun_get_mode_id() == gun_mode_BURST );
    CHECK( driver.controlling_vehicle );
    CHECK_FALSE( who.controlling_vehicle );
    CHECK( driver.get_moves() == driver_moves );
    CHECK( who.get_moves() == 100 );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "owned_console_turrets_bill_the_operator_and_selected_vehicle_once",
           "[multiplayer][vehicle_turret_owned]" )
{
    owned_turret_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = fixture.rig( who );
    const int first = fixture.install( car );
    const std::string operation = GENERATE( "aim_manual", "aim_single" );
    vehicle_control_selection choice = fixture.choice( who, car, first, operation );
    int second = -1;
    if( operation == "aim_manual" ) {
        second = fixture.install( car, point_rel_ms( 1, 0 ) );
        choice.turret->turrets.push_back( capture_vehicle_turret( car, car.part( second ) ) );
    }
    get_avatar().set_mutation( trait_GUNSHY );
    get_avatar().set_moves( 321 );
    const auto host_target = get_avatar().last_target_pos;
    const int battery = car.battery_left( get_map() );
    const std::string wire = control_request( fixture, who, choice );
    fixture.run( who, wire );
    CHECK( who.get_moves() == 0 );
    const int consumed = 15 - car.part( first ).get_base().ammo_remaining() +
                         ( second < 0 ? 0 : 15 - car.part( second ).get_base().ammo_remaining() );
    REQUIRE( consumed > 0 );
    CHECK( battery - car.battery_left( get_map() ) == consumed * 5 );
    CHECK( car.part( first ).target.first == car.part( first ).target.second );
    CHECK( get_avatar().get_moves() == 321 );
    CHECK( get_avatar().last_target_pos == host_target );
    const std::string rng = capture_rng_state();
    const int after = car.battery_left( get_map() );
    fixture.run( who, wire );
    CHECK( car.battery_left( get_map() ) == after );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "owned_direct_turret_fire_uses_the_shooters_selected_mode_and_native_cost",
           "[multiplayer][vehicle_turret_owned]" )
{
    owned_turret_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = fixture.rig( who );
    const int index = fixture.install( car );
    vehicle_control_selection choice = fixture.choice( who, car, index, "fire_direct" );
    choice.turret->turrets.front().mode = gun_mode_BURST;
    // Direct operation of the mounted gun does not acquire locked driving controls.
    car.is_locked = true;
    const int host_moves = get_avatar().get_moves();
    const double host_recoil = get_avatar().recoil;
    const int battery = car.battery_left( get_map() );
    const std::string rng = capture_rng_state();
    REQUIRE( valid_vehicle_turret_control( who, get_map(), car, *choice.turret ) );
    CHECK( capture_rng_state() == rng );
    CHECK( car.part( index ).get_base().gun_get_mode_id() == gun_mode_DEFAULT );
    fixture.run( who, control_request( fixture, who, choice ) );
    REQUIRE( who.get_moves() < 100 );
    CHECK( car.part( index ).get_base().gun_get_mode_id() == gun_mode_BURST );
    const int consumed = 15 - car.part( index ).get_base().ammo_remaining();
    REQUIRE( consumed > 0 );
    CHECK( battery - car.battery_left( get_map() ) == consumed * 5 );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK( get_avatar().recoil == host_recoil );
    CHECK_FALSE( who.has_effect( effect_on_roof ) );
}

TEST_CASE( "owned_automatic_turret_override_schedules_native_fire_without_firing_during_selection",
           "[multiplayer][vehicle_turret_owned]" )
{
    owned_turret_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = fixture.rig( who );
    const int index = fixture.install( car );
    car.part( index ).enabled = true;
    vehicle_control_selection choice = fixture.choice( who, car, index, "aim_auto" );
    const int battery = car.battery_left( get_map() );
    const std::string rng = capture_rng_state();
    REQUIRE( valid_vehicle_turret_control( who, get_map(), car, *choice.turret ) );
    CHECK( car.part( index ).target.second != *choice.turret->target );
    CHECK( capture_rng_state() == rng );
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK( who.get_moves() == 0 );
    CHECK( car.part( index ).target.second == *choice.turret->target );
    CHECK( car.battery_left( get_map() ) == battery );
    CHECK( car.part( index ).get_base().ammo_remaining() == 15 );
    REQUIRE( car.automatic_fire_turret( car.part( index ) ) > 0 );
    CHECK( car.battery_left( get_map() ) < battery );
    CHECK( car.part( index ).target.first == car.part( index ).target.second );
}

TEST_CASE( "owned_turret_rejects_stale_hardware_targets_roles_and_resources_before_side_effects",
           "[multiplayer][vehicle_turret_owned]" )
{
    owned_turret_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = fixture.rig( who );
    const int index = fixture.install( car );
    vehicle_control_selection choice = fixture.choice( who, car, index, "aim_manual" );
    const std::string fault = GENERATE( "hardware", "part_position", "mode", "ammo", "operator",
                                        "range", "locked", "role", "duplicate", "power", "trait", "automatic" );
    CAPTURE( fault );
    auto &selected = choice.turret->turrets.front();
    if( fault == "hardware" ) {
        selected.part += 100000;
    } else if( fault == "part_position" ) {
        selected.position += tripoint::south;
    } else if( fault == "mode" ) {
        selected.mode = gun_mode_not_a_gun_mode;
    } else if( fault == "ammo" ) {
        selected.ammo = itype_gasoline;
    } else if( fault == "operator" ) {
        who.setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 1, 0, 0 ) );
    } else if( fault == "range" ) {
        choice.turret->target = who.pos_abs() + tripoint( 100, 0, 0 );
    } else if( fault == "locked" ) {
        car.is_locked = true;
    } else if( fault == "role" ) {
        choice.action = "turret_direct";
    } else if( fault == "duplicate" ) {
        choice.turret->turrets.push_back( selected );
    } else if( fault == "power" ) {
        car.discharge_battery( get_map(), car.battery_left( get_map() ) );
    } else if( fault == "trait" ) {
        who.set_mutation( trait_BRAWLER );
    } else if( fault == "automatic" ) {
        car.part( index ).enabled = true;
    }
    const std::string rng = capture_rng_state();
    const int battery = car.battery_left( get_map() );
    const auto previous_target = car.part( index ).target;
    CHECK_FALSE( execute_vehicle_control( who, get_map(), choice ) );
    CHECK( capture_rng_state() == rng );
    CHECK( who.get_moves() == 100 );
    CHECK( car.battery_left( get_map() ) == battery );
    CHECK( car.part( index ).get_base().ammo_remaining() == 15 );
    CHECK( car.part( index ).target == previous_target );
}

TEST_CASE( "owned_turret_configuration_validates_the_whole_selection_before_applying_changes",
           "[multiplayer][vehicle_turret_owned]" )
{
    owned_turret_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = fixture.rig( who );
    const int first = fixture.install( car );
    const int second = fixture.install( car, point_rel_ms( 1, 0 ) );
    vehicle_control_selection choice = fixture.choice( who, car, first, "mode" );
    choice.turret->turrets.front().mode = gun_mode_BURST;
    choice.turret->turrets.push_back( capture_vehicle_turret( car, car.part( second ) ) );
    SECTION( "one part has been replaced" ) {
        item replacement( itype_test_multimag_turret_gun );
        car.part( second ).set_base( std::move( replacement ) );
    }
    SECTION( "one mode does not exist" ) {
        choice.turret->turrets.back().mode = gun_mode_absent;
    }
    const std::string rng = capture_rng_state();
    CHECK_FALSE( execute_vehicle_control( who, get_map(), choice ) );
    CHECK( car.part( first ).get_base().gun_get_mode_id() == gun_mode_DEFAULT );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "client_turret_choices_do_not_fire_or_change_live_modes_ammo_and_targets",
           "[multiplayer][vehicle_turret_owned]" )
{
    owned_turret_fixture fixture;
    avatar &who = get_avatar();
    vehicle &car = fixture.rig( who );
    const int index = fixture.install( car );
    vehicle_control_selection choice = fixture.choice( who, car, index, "fire_direct" );
    choice.turret->turrets.front().mode = gun_mode_BURST;
    const int battery = car.battery_left( get_map() );
    const auto previous_target = car.part( index ).target;
    const std::string rng = capture_rng_state();
    REQUIRE( valid_vehicle_turret_control( who, get_map(), car, *choice.turret ) );
    CHECK( who.get_moves() == 100 );
    cata_mp::set_client_mode( true );
    REQUIRE( cata_mp::client_vehicle_control( choice ) );
    CHECK( who.activity.execution() == activity_execution::presentation );
    // The local input grant waits for the server; turret costs are not applied locally.
    CHECK( who.get_moves() == 0 );
    who.activity.do_turn( who );
    CHECK( car.battery_left( get_map() ) == battery );
    CHECK( car.part( index ).get_base().ammo_remaining() == 15 );
    CHECK( car.part( index ).get_base().gun_get_mode_id() == gun_mode_DEFAULT );
    CHECK( car.part( index ).target == previous_target );
    CHECK( capture_rng_state() == rng );
    CHECK( g->multiplayer_session().client_inventory_activity.pending_request != 0 );
}

TEST_CASE( "owned_turret_preview_preserves_rotated_mount_range_without_changing_the_weapon",
           "[multiplayer][vehicle_turret_owned]" )
{
    owned_turret_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = fixture.rig( who, 90_degrees );
    const int index = fixture.install( car, point_rel_ms( 1, 0 ) );
    who.setpos( get_map(), car.bub_part_pos( get_map(), index ) );
    vehicle_control_selection choice = fixture.choice( who, car, index, "fire_direct" );
    const turret_data data = car.turret_query( car.part( index ) );
    choice.turret->target = who.pos_abs() + tripoint( data.range(), 0, 0 );
    REQUIRE( data.in_range( *choice.turret->target ) );
    const std::string rng = capture_rng_state();
    const int battery = car.battery_left( get_map() );
    REQUIRE( valid_vehicle_turret_control( who, get_map(), car, *choice.turret ) );
    CHECK( capture_rng_state() == rng );
    CHECK( car.battery_left( get_map() ) == battery );
    CHECK( car.part( index ).get_base().ammo_remaining() == 15 );
}

TEST_CASE( "owned_console_target_on_the_turret_mount_preserves_native_no_shot_behavior",
           "[multiplayer][vehicle_turret_owned]" )
{
    owned_turret_fixture fixture;
    npc &who = fixture.remote();
    vehicle &car = fixture.rig( who );
    const int index = fixture.install( car );
    who.setpos( get_map(), who.pos_bub() + tripoint_rel_ms( 1, 0, 0 ) );
    vehicle_control_selection choice = fixture.choice( who, car, index, "aim_single" );
    choice.turret->target = choice.turret->turrets.front().position;
    const int battery = car.battery_left( get_map() );
    REQUIRE( execute_vehicle_control( who, get_map(), choice ) );
    CHECK( who.get_moves() == 0 );
    CHECK( car.battery_left( get_map() ) == battery );
    CHECK( car.part( index ).get_base().ammo_remaining() == 15 );
    CHECK( car.part( index ).target.first == car.part( index ).target.second );
}

namespace
{
struct owned_harness_fixture : vehicle_control_fixture {
    vehicle *car = nullptr;
    monster *animal = nullptr;
    int harness = -1;
    void prepare( Character &who ) {
        map &here = get_map();
        car = here.add_vehicle( vehicle_prototype_test_turret_rig, tripoint_bub_ms( 60, 60, 0 ),
                                0_degrees, 0, veh_spawn_status::PRISTINE, false, true );
        REQUIRE( car );
        car->set_owner( who.get_faction()->id );
        harness = car->install_part( here, point_rel_ms( -1, 0 ), vpart_yoke_harness );
        REQUIRE( harness >= 0 );
        who.setpos( here, car->bub_part_pos( here, harness ) + tripoint_rel_ms( 0, 1, 0 ) );
        who.set_moves( 100 );
        animal = g->place_critter_at( mon_horse,
                                      who.pos_bub() + tripoint_rel_ms( 1, 0, 0 ) );
        REQUIRE( animal );
        animal->friendly = -1;
        animal->add_effect( effect_tied, 1_turns, true );
        animal->tied_item = cata::make_value<item>( itype_rope_6 );
    }
    vehicle_control_selection choice( Character &who ) const {
        vehicle_control_selection result = control_choice( who, *car, "harness" );
        result.position = car->abs_part_pos( car->part( harness ) );
        result.harness = vehicle_harness_selection{ car->part( harness ).get_base().uid().get_value(),
                                                    animal->uid().get_value(), animal->pos_abs() };
        return result;
    }
};
} // namespace

TEST_CASE( "owned_harness_returns_the_rope_to_the_operator_once",
           "[multiplayer][vehicle_harness_owned]" )
{
    owned_harness_fixture fixture;
    npc &who = fixture.remote();
    fixture.prepare( who );
    vehicle_control_selection choice = fixture.choice( who );
    const int host_rope = get_avatar().amount_of( itype_rope_6 );
    const int operator_rope = who.amount_of( itype_rope_6 );
    const std::string rng = capture_rng_state();
    REQUIRE( valid_vehicle_harness( who, get_map(), *fixture.car, choice.position, *choice.harness ) );
    CHECK( capture_rng_state() == rng );
    CHECK( fixture.animal->has_effect( effect_tied ) );
    const std::string request = control_request( fixture, who, choice );
    fixture.run( who, request );
    CHECK( fixture.animal->has_effect( effect_harnessed ) );
    CHECK_FALSE( fixture.animal->has_effect( effect_tied ) );
    CHECK( fixture.animal->pos_abs() == choice.position );
    CHECK_FALSE( fixture.animal->tied_item );
    CHECK( who.amount_of( itype_rope_6 ) == operator_rope + 1 );
    CHECK( get_avatar().amount_of( itype_rope_6 ) == host_rope );
    fixture.run( who, request );
    CHECK( who.amount_of( itype_rope_6 ) == operator_rope + 1 );
}

TEST_CASE( "owned_harness_rejects_changed_animals_hardware_and_occupied_positions",
           "[multiplayer][vehicle_harness_owned]" )
{
    owned_harness_fixture fixture;
    npc &who = fixture.remote();
    fixture.prepare( who );
    vehicle_control_selection choice = fixture.choice( who );
    const std::string invalid = GENERATE( "animal", "part", "position", "hostile", "occupied" );
    if( invalid == "animal" ) {
        ++choice.harness->animal;
    } else if( invalid == "part" ) {
        ++choice.harness->part;
    } else if( invalid == "position" ) {
        choice.harness->animal_position += tripoint::east;
    } else if( invalid == "hostile" ) {
        fixture.animal->friendly = 0;
    } else {
        get_avatar().setpos( get_map(), get_map().get_bub( choice.position ) );
    }
    const tripoint_abs_ms position = fixture.animal->pos_abs();
    const std::string rng = capture_rng_state();
    fixture.run( who, control_request( fixture, who, choice ) );
    CHECK( fixture.animal->pos_abs() == position );
    CHECK( fixture.animal->has_effect( effect_tied ) );
    CHECK_FALSE( fixture.animal->has_effect( effect_harnessed ) );
    CHECK( fixture.animal->tied_item );
    CHECK( who.amount_of( itype_rope_6 ) == 0 );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "client_harness_selection_cannot_move_the_animal_or_take_its_rope",
           "[multiplayer][vehicle_harness_owned]" )
{
    owned_harness_fixture fixture;
    avatar &who = get_avatar();
    fixture.prepare( who );
    const vehicle_control_selection choice = fixture.choice( who );
    const tripoint_abs_ms origin = fixture.animal->pos_abs();
    cata_mp::set_client_mode( true );
    REQUIRE( cata_mp::client_vehicle_control( choice ) );
    who.activity.do_turn( who );
    CHECK( fixture.animal->pos_abs() == origin );
    CHECK( fixture.animal->has_effect( effect_tied ) );
    CHECK_FALSE( fixture.animal->has_effect( effect_harnessed ) );
    CHECK( fixture.animal->tied_item );
    CHECK( who.amount_of( itype_rope_6 ) == 0 );
}

TEST_CASE( "owned_bionic_weapon_uses_the_operators_disposition_and_restores_its_binding",
           "[multiplayer][mp_bionic_weapon]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    avatar &host = get_avatar();
    const bionic_id &id = bio_claws;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    who.set_wielded_item( item( itype_hammer ) );
    host.set_wielded_item( item( itype_wrench ) );
    const int64_t held = who.get_wielded_item()->uid().get_value();
    const units::energy power = who.get_power_level();
    const units::energy host_power = host.get_power_level();
    const std::string request = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", id );
        out.member( "weapon", held );
        out.member( "unwield" );
        out.start_object();
        out.member( "action", "drop" );
        out.member( "container", 0 );
        out.member( "pocket", 0 );
        out.end_object();
    } );
    const std::string reply = fixture.run( who, request );
    REQUIRE( who.is_using_bionic_weapon() );
    CHECK( who.get_weapon_bionic_uid() == uid );
    CHECK( who.get_power_level() == power - id->power_activate );
    REQUIRE( host.get_wielded_item() );
    CHECK( host.get_wielded_item()->typeId() == itype_wrench );
    CHECK( host.get_power_level() == host_power );
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( who.get_power_level() == power - id->power_activate );
    CHECK( capture_rng_state() == rng );

    // Body projections can precede the inventory ACK on the other channel.
    std::ostringstream turn;
    JsonOut turn_out( turn );
    who.store_turn_state( turn_out );
    host.load_turn_state( json_loader::from_string( turn.str() ).get_object() );
    CHECK( host.get_weapon_bionic_uid() == uid );
    REQUIRE( host.get_wielded_item() );
    CHECK( host.get_wielded_item()->typeId() == itype_wrench );

    cata_mp::set_client_mode( true );
    player_activity presentation{ invoke_item_activity_actor( item_location(), std::string() ) };
    presentation.set_execution( activity_execution::presentation );
    host.assign_activity( presentation );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = fixture.sequence;
    REQUIRE( cata_mp::client_apply_message( reply ) );
    cata_mp::client_update_inventory_activity_view();
    REQUIRE( host.is_using_bionic_weapon() );
    CHECK( host.get_weapon_bionic_uid() == uid );
    CHECK( capture_rng_state() == rng );
    cata_mp::set_client_mode( false );

    std::ostringstream encoded;
    JsonOut out( encoded );
    who.store_player_state( out );
    host.load_player_state( json_loader::from_string( encoded.str() ).get_object() );
    CHECK( host.is_using_bionic_weapon() );
    CHECK( host.get_weapon_bionic_uid() == uid );
    CHECK( capture_rng_state() == rng );
    REQUIRE( host.deactivate_bionic( **host.find_bionic_by_uid( uid ) ) );
    CHECK_FALSE( host.get_wielded_item() );
    CHECK_FALSE( host.is_using_bionic_weapon() );
    CHECK( who.is_using_bionic_weapon() );
}

TEST_CASE( "owned_bionic_weapon_rejects_changed_hands_before_activation",
           "[multiplayer][mp_bionic_weapon]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const bionic_id &id = bio_claws;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    who.set_wielded_item( item( itype_hammer ) );
    bionic_activation_choices choice;
    choice.weapon = who.get_wielded_item()->uid().get_value();
    choice.unwield = item_disposition{ "drop", 0, 0 };
    const bool invalid_disposition = GENERATE( false, true );
    if( invalid_disposition ) {
        choice.unwield->action = "invalid";
    } else {
        who.set_wielded_item( item( itype_hammer ) );
    }
    const units::energy power = who.get_power_level();
    const std::string rng = capture_rng_state();
    CHECK_FALSE( execute_owned_bionic_action( who, uid, id, choice ) );
    CHECK_FALSE( who.has_active_bionic( id ) );
    CHECK( who.get_power_level() == power );
    CHECK( capture_rng_state() == rng );
    REQUIRE( who.get_wielded_item() );
    CHECK( who.get_wielded_item()->typeId() == itype_hammer );
}

TEST_CASE( "owned_bionic_teleport_moves_only_its_operator_and_does_not_repeat",
           "[multiplayer][mp_bionic_weapon]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const bionic_id &id = bio_teleport;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_abs_ms host_position = get_avatar().pos_abs();
    const units::energy host_power = get_avatar().get_power_level();
    const units::energy power = who.get_power_level();
    const std::string request = bionic_switch_request( fixture, who, uid, id, true );
    fixture.run( who, request );
    CHECK( who.pos_abs() != origin );
    CHECK( who.get_power_level() == power - id->power_activate );
    CHECK( get_avatar().pos_abs() == host_position );
    CHECK( get_avatar().get_power_level() == host_power );
    const tripoint_abs_ms destination = who.pos_abs();
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( who.pos_abs() == destination );
    CHECK( capture_rng_state() == rng );
}

namespace
{
spell &prepare_owned_test_spell( Character &who, const spell_id &id )
{
    if( !who.is_avatar() && who.pos_abs() == get_avatar().pos_abs() ) {
        get_avatar().setpos( get_map(), who.pos_bub() + tripoint( 5, 0, 0 ) );
    }
    who.magic->learn_spell( id, who, true );
    spell &selected = who.magic->get_spell( id );
    selected.set_level( who, 1 );
    who.set_skill_level( selected.skill(), 30 );
    who.magic->set_mana( who.magic->max_mana( who ) );
    who.set_moves( 100 );
    return selected;
}

void finish_owned_casting_time( reload_fixture &fixture, Character &who )
{
    REQUIRE( who.activity.id() == ACT_SPELLCASTING );
    who.set_moves( std::max( 100, who.activity.moves_left + 100 ) );
    fixture.run( who, fixture.request( who, "step" ) );
    const auto *casting = dynamic_cast<const spellcasting_activity_actor *>( who.activity.actor.get() );
    REQUIRE( casting );
    REQUIRE( casting->pending_choice() );
    CHECK( who.activity.moves_left == 0 );
}
} // namespace

TEST_CASE( "owned_spell_waits_for_its_caster_and_finishes_once_after_save_restore",
           "[multiplayer][mp_spell_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    avatar &host = get_avatar();
    const spell_id &id = spell_test_eoc_spell;
    spell &selected = prepare_owned_test_spell( who, id );
    REQUIRE( selected.spell_fail( who ) == 0.0f );
    const int mana = who.magic->available_mana();
    const int cost = selected.energy_cost( who );
    const int health = who.get_hp();
    const int host_health = host.get_hp();
    const int host_mana = host.magic->available_mana();
    reload_events events;
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "spell" );
        out.member( "spell", id );
    } ) );
    finish_owned_casting_time( fixture, who );
    CHECK( events.finishes == 0 );
    CHECK( who.magic->available_mana() == mana );
    CHECK( who.get_hp() == health );
    save_reload_activity( who );
    const std::string rng_before_choice = capture_rng_state();
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( capture_rng_state() == rng_before_choice );
    CHECK( events.finishes == 0 );

    spell_casting_choice choice;
    choice.target = who.pos_abs();
    const std::string request = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "spell_choice", choice );
    } );
    const std::string reply = fixture.run( who, request );
    CHECK_FALSE( who.activity );
    CHECK( events.finishes == 1 );
    CHECK( who.magic->available_mana() == mana - cost );
    CHECK( who.get_hp() < health );
    CHECK( host.get_hp() == host_health );
    CHECK( host.magic->available_mana() == host_mana );
    const int settled_health = who.get_hp();
    const std::string settled_rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( events.finishes == 1 );
    CHECK( who.get_hp() == settled_health );
    CHECK( capture_rng_state() == settled_rng );

    // Apply the real reply to a frontend with a different learned spellbook.
    host.magic->learn_spell( spell_test_spell_pew, host, true );
    cata_mp::set_client_mode( true );
    player_activity presentation{ invoke_item_activity_actor( item_location(), std::string() ) };
    presentation.set_execution( activity_execution::presentation );
    host.assign_activity( presentation );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = fixture.sequence;
    const std::string rng_before_apply = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( reply ) );
    CHECK( host.magic->knows_spell( id ) );
    CHECK_FALSE( host.magic->knows_spell( spell_test_spell_pew ) );
    CHECK( host.magic->get_spell( id ).xp() == who.magic->get_spell( id ).xp() );
    CHECK( capture_rng_state() == rng_before_apply );
    cata_mp::set_client_mode( false );
}

TEST_CASE( "owned_spell_rejects_unlearned_and_stale_targets_without_spending_resources",
           "[multiplayer][mp_spell_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const spell_id &id = spell_test_eoc_spell;
    const int initial_mana = who.magic->available_mana();
    const std::string initial_rng = capture_rng_state();
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "spell" );
        out.member( "spell", id );
        out.member( "always_succeeds", true );
        out.member( "fake_spell_level", 20 );
    } ) );
    CHECK_FALSE( who.activity );
    CHECK( who.magic->available_mana() == initial_mana );
    CHECK( capture_rng_state() == initial_rng );

    prepare_owned_test_spell( who, id );
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "spell" );
        out.member( "spell", id );
    } ) );
    finish_owned_casting_time( fixture, who );
    const int mana = who.magic->available_mana();
    const std::string rng = capture_rng_state();
    spell_casting_choice choice;
    choice.target = get_avatar().pos_abs();
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "spell_choice", choice );
    } ) );
    REQUIRE( who.activity );
    CHECK( who.magic->available_mana() == mana );
    CHECK( capture_rng_state() == rng );
    who.set_moves( 0 );
    fixture.run( who, fixture.request( who, "cancel" ) );
    CHECK_FALSE( who.activity );
    CHECK( who.magic->available_mana() == mana );
}

TEST_CASE( "spell_component_choices_keep_the_native_zero_radius_and_shared_quantity_budget",
           "[multiplayer][mp_spell_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    spell selected( spell_test_spell_json );
    REQUIRE( selected.has_components() );
    item_location rag = get_map().add_item_or_charges_ret_loc(
                            who.pos_bub() + tripoint::east, item( itype_test_rag ) );
    spell_casting_choice choice;
    choice.components.push_back( { usage_from::map, selected.components().get_components().front().front() } );
    const std::string rng = capture_rng_state();
    CHECK_FALSE( valid_spell_casting_choice( who, selected, choice, false, true ) );
    REQUIRE( rag );
    CHECK( capture_rng_state() == rng );
    rag.remove_item();
    get_map().add_item_or_charges( who.pos_bub(), item( itype_test_rag ) );
    REQUIRE( valid_spell_casting_choice( who, selected, choice, false, true ) );
    CHECK( capture_rng_state() == rng );
    consume_spell_casting_components( who, choice );
    CHECK_FALSE( valid_spell_casting_choice( who, selected, choice, false, true ) );

    who.i_add( item( itype_test_rag ) );
    choice.components.front().use_from = usage_from::player;
    choice.components.front().comp.count = 0;
    CHECK_FALSE( valid_spell_casting_choice( who, selected, choice, false, true ) );
    CHECK( who.has_amount( itype_test_rag, 1 ) );
}

TEST_CASE( "spellbook_callbacks_run_once_for_the_requesting_player_and_views_keep_temporary_modifiers",
           "[multiplayer][mp_spell_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const spell_id &id = spell_test_eoc_spell;
    prepare_owned_test_spell( who, id ).set_message( no_translation( "Casting snapshot message" ) );
    prepare_owned_test_spell( get_avatar(), id );
    class spellbook_events : public event_subscriber {
            Character &owner;
        public:
            int count = 0;
            explicit spellbook_events( Character &who ) : owner( who ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::opens_spellbook &&
                    event.get<character_id>( "character" ) == owner.getID() ) {
                    ++count;
                    owner.magic->caster_level_adjustment = 3;
                }
            }
    } events( who );
    const std::string request = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "spellbook" );
        out.member( "recast", false );
    } );
    const std::string reply = fixture.run( who, request );
    CHECK( events.count == 1 );
    CHECK( who.magic->get_spell( id ).get_temp_level_adjustment() == 3 );
    CHECK( get_avatar().magic->get_spell( id ).get_temp_level_adjustment() == 0 );
    fixture.run( who, request );
    CHECK( events.count == 1 );
    cata_mp::set_client_mode( true );
    player_activity presentation{ invoke_item_activity_actor( item_location(), std::string() ) };
    presentation.set_execution( activity_execution::presentation );
    get_avatar().assign_activity( presentation );
    cata_mp::inventory_activity_client_state &view = g->multiplayer_session().client_inventory_activity;
    view.active = true;
    view.pending_request = fixture.sequence;
    const std::string rng = capture_rng_state();
    REQUIRE( cata_mp::client_apply_message( reply ) );
    CHECK( view.spellbook_ready );
    CHECK( get_avatar().magic->get_spell( id ).get_temp_level_adjustment() == 3 );
    CHECK( get_avatar().magic->get_spell( id ).message() == "Casting snapshot message" );
    CHECK( events.count == 1 );
    CHECK( capture_rng_state() == rng );
    cata_mp::set_client_mode( false );
}

TEST_CASE( "client_spell_selection_does_not_cast_or_open_the_authoritative_spellbook",
           "[multiplayer][mp_spell_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    const spell_id &id = spell_test_eoc_spell;
    spell &selected = prepare_owned_test_spell( who, id );
    const int mana = who.magic->available_mana();
    const int health = who.get_hp();
    const std::string rng = capture_rng_state();
    reload_events events;
    cata_mp::set_client_mode( true );
    REQUIRE( who.cast_spell( selected, false, std::nullopt ) );
    REQUIRE( cata_mp::inventory_activity_view( who.activity ) );
    who.activity.do_turn( who );
    CHECK( who.magic->available_mana() == mana );
    CHECK( who.get_hp() == health );
    CHECK( events.starts == 0 );
    CHECK( events.finishes == 0 );
    CHECK( capture_rng_state() == rng );
    cata_mp::set_client_mode( false );
}

TEST_CASE( "bionic_spells_wait_for_the_operators_target_instead_of_using_npc_ai",
           "[multiplayer][mp_spell_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    avatar &host = get_avatar();
    host.setpos( get_map(), who.pos_bub() + tripoint::east );
    const bionic_id &id = bio_taser;
    const unsigned int uid = prepare_targeted_bionic( who, id );
    const units::energy power = who.get_power_level();
    const units::energy host_power = host.get_power_level();
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "bionic_activation" );
        out.member( "bionic_uid", uid );
        out.member( "bionic_type", id );
    } ) );
    finish_owned_casting_time( fixture, who );
    const int health = host.get_hp();
    spell_casting_choice choice;
    choice.target = host.pos_abs();
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "spell_choice", choice );
    } ) );
    CHECK_FALSE( who.activity );
    CHECK( who.get_power_level() < power );
    CHECK( host.get_power_level() == host_power );
    CHECK( host.get_hp() < health );
}

TEST_CASE( "item_spell_completion_consumes_one_unit_and_rejects_a_lost_casting_item",
           "[multiplayer][mp_spell_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    get_avatar().setpos( get_map(), who.pos_bub() + tripoint( 5, 0, 0 ) );
    who.magic->set_mana( who.magic->max_mana( who ) );
    item source_item( itype_aspirin, calendar::turn, 2 );
    source_item.set_flag( flag_SINGLE_USE );
    item_location source = who.i_add( source_item );
    cast_spell_actor caster;
    caster.item_spell = spell_test_eoc_spell;
    caster.spell_level = 1;
    caster.no_fail = true;
    who.activity.set_execution( activity_execution::authoritative );
    REQUIRE( caster.use( &who, *source, &get_map(), who.pos_bub() ) );
    finish_owned_casting_time( fixture, who );
    const int mana = who.magic->available_mana();
    const int health = who.get_hp();
    const bool remove_source = GENERATE( false, true );
    if( remove_source ) {
        source.remove_item();
    }
    who.set_moves( 100 );
    spell_casting_choice choice;
    choice.target = who.pos_abs();
    fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "spell_choice", choice );
    } ) );
    CHECK_FALSE( who.activity );
    if( remove_source ) {
        CHECK( who.magic->available_mana() == mana );
        CHECK( who.get_hp() == health );
    } else {
        REQUIRE( source );
        CHECK( source->charges == 1 );
        CHECK( who.get_hp() < health );
    }
}

namespace
{
item_location equip_cutting_tool( Character &who, bool torch )
{
    if( torch ) {
        REQUIRE( who.wear_item( item( itype_test_goggles_welding ), false ) );
    }
    item tool( itype_id( torch ? "test_oxytorch" : "tin_snips" ) );
    if( torch ) {
        tool.ammo_set( itype_oxyacetylene );
    }
    who.set_wielded_item( tool );
    who.set_moves( 1000 );
    return who.get_wielded_item();
}

std::string cutting_request( reload_fixture &fixture, Character &who,
                             const item_location &tool, bool torch, const tripoint_abs_ms &target )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", torch ? "OXYTORCH" : "BOLTCUTTERS" );
        out.member( "target", target );
    } );
}
} // namespace

TEST_CASE( "owned_metal_cutting_reloads_bills_only_operator_and_cancels_competing_work",
           "[mp_inventory_activity][metal_cutting_owned]" )
{
    const bool torch = GENERATE( false, true );
    CAPTURE( torch );
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 62, 60, 0 ) );
    const item_location tool = equip_cutting_tool( who, torch );
    const item_location host_tool = equip_cutting_tool( host, torch );
    const tripoint_bub_ms target( 61, 60, 0 );
    here.furn_set( target, furn_str_id( torch ? "test_f_oxytorch2" : "test_f_boltcut2" ) );
    const std::string request = cutting_request( fixture, who, tool, torch, here.get_abs( target ) );
    fixture.run( who, request );
    REQUIRE( who.activity );
    CHECK( who.activity.execution() == activity_execution::authoritative );
    const int initial_work = who.activity.moves_left;
    fixture.run( who, request );
    CHECK( who.activity.moves_left == initial_work );
    save_reload_activity( who );

    REQUIRE( execute_owned_item_activation( host, host_tool, torch ? "OXYTORCH" : "BOLTCUTTERS",
                                            here.get_abs( target ), false, false ) );
    REQUIRE( host.activity );
    const int fuel = tool->ammo_remaining();
    const int host_fuel = host_tool->ammo_remaining();
    const int host_moves = host.get_moves();
    who.activity.moves_left = 1;
    who.set_moves( 100 );
    const std::string finish = fixture.request( who, "step" );
    fixture.run( who, finish );
    CHECK_FALSE( who.activity );
    const auto result = furn_str_id( torch ? "test_f_oxytorch1" : "test_f_boltcut1" ).id();
    CHECK( here.furn( target ) == result );
    CHECK( tool->ammo_remaining() == fuel - tool->ammo_required() );
    CHECK( host_tool->ammo_remaining() == host_fuel );
    CHECK( host.get_moves() == host_moves );
    const std::string after_rng = capture_rng_state();
    fixture.run( who, finish );
    CHECK( here.furn( target ) == result );
    CHECK( capture_rng_state() == after_rng );
    host.activity.moves_left = 1;
    host.set_moves( 100 );
    host.activity.do_turn( host );
    CHECK_FALSE( host.activity );
    CHECK( here.furn( target ) == result );
    CHECK( host_tool->ammo_remaining() == host_fuel );
}

TEST_CASE( "owned_metal_cutting_revalidates_saved_source_surface_range_and_tool_method",
           "[mp_inventory_activity][metal_cutting_owned]" )
{
    const bool torch = GENERATE( false, true );
    const std::string change = GENERATE( "source", "surface", "range", "transformed" );
    CAPTURE( torch, change );
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    item_location tool = equip_cutting_tool( who, torch );
    const tripoint_bub_ms target( 61, 60, 0 );
    here.furn_set( target, furn_str_id( torch ? "test_f_oxytorch2" : "test_f_boltcut2" ) );
    fixture.run( who, cutting_request( fixture, who, tool, torch, here.get_abs( target ) ) );
    REQUIRE( who.activity );
    save_reload_activity( who );
    if( change == "source" ) {
        item replacement( tool->typeId() );
        if( torch ) {
            replacement.ammo_set( itype_oxyacetylene );
        }
        who.set_wielded_item( replacement );
        tool = who.get_wielded_item();
    } else if( change == "surface" ) {
        here.furn_set( target, furn_str_id( torch ? "test_f_oxytorch3" : "test_f_boltcut3" ) );
    } else if( change == "range" ) {
        who.setpos( here, tripoint_bub_ms( 60, 62, 0 ) );
    } else {
        tool->convert( itype_rock );
    }
    const int fuel = tool->ammo_remaining();
    const furn_id surface = here.furn( target );
    who.activity.moves_left = 1;
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( here.furn( target ) == surface );
    CHECK( tool->ammo_remaining() == fuel );
}

TEST_CASE( "owned_torch_uses_an_in_place_ground_source_and_requires_operator_glare_protection",
           "[mp_inventory_activity][metal_cutting_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    const item_location host_tool = equip_cutting_tool( get_avatar(), true );
    item torch( itype_oxy_torch );
    torch.ammo_set( itype_oxyacetylene );
    item &placed = here.add_item_or_charges( who.pos_bub( here ), std::move( torch ) );
    const item_location source( map_cursor( who.pos_abs() ), &placed );
    REQUIRE( source->ammo_sufficient( &who ) );
    const tripoint_bub_ms target( 61, 60, 0 );
    here.furn_set( target, furn_test_f_oxytorch2 );
    // The host's welding protection must never authorize the other player.
    fixture.run( who, cutting_request( fixture, who, source, true, here.get_abs( target ) ) );
    CHECK_FALSE( who.activity );
    REQUIRE( who.wear_item( item( itype_test_goggles_welding ), false ) );
    who.set_moves( 1000 );
    fixture.run( who, cutting_request( fixture, who, source, true, here.get_abs( target ) ) );
    REQUIRE( who.activity );
    CHECK( locate_cutting_tool( who, placed ) == source );
    CHECK_FALSE( who.has_item( placed ) );
    save_reload_activity( who );
    const int fuel = source->ammo_remaining();
    const int host_fuel = host_tool->ammo_remaining();
    who.activity.moves_left = 1;
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( who.activity );
    CHECK( here.furn( target ) == furn_test_f_oxytorch1.id() );
    CHECK( source->ammo_remaining() == fuel - source->ammo_required() );
    CHECK( host_tool->ammo_remaining() == host_fuel );
}

TEST_CASE( "personal_zone_queries_keep_each_operator_origin_and_scope_independent",
           "[mp_inventory_activity][zone_sort_owned]" )
{
    reload_fixture fixture;
    npc &first = fixture.remote();
    first.setpos( get_map(), tripoint_bub_ms( 60, 58, 0 ) );
    npc &second = fixture.remote();
    bind_feedback_player( first, 'a', 701 );
    bind_feedback_player( second, 'b', 702 );
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope cleanup( [&]() { zones.clear(); } );
    const faction_id fac = first.get_faction_id();
    REQUIRE( second.get_faction_id() == fac );
    const zone_type_id &type = zone_type_LOOT_UNSORTED;
    const tripoint_rel_ms first_offset( 1, 0, 0 );
    const tripoint_rel_ms second_offset( 2, 0, 0 );
    REQUIRE( zones.add( "First personal", type, fac, false, true, first_offset, first_offset,
                        nullptr, first.getID() ) );
    REQUIRE( zones.add( "Second personal", type, fac, false, true, second_offset, second_offset,
                        nullptr, second.getID() ) );
    const tripoint_abs_ms shared = first.pos_abs() + tripoint( 3, 0, 0 );
    REQUIRE( zones.add( "Shared static", type, fac, false, true, shared, shared,
                        nullptr, true, nullptr, false ) );
    zone_query_context first_query = zone_query_context::for_character( first, first.pos_abs(), zone_scope::personal_only );
    zone_query_context second_query = zone_query_context::for_character( second, second.pos_abs(), zone_scope::personal_only );
    std::ostringstream saved;
    JsonOut saved_out( saved );
    zones.get_zones( fac ).front().get().serialize( saved_out );
    zone_data restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    CHECK( restored.get_personal_owner() == first.getID() );
    CHECK( restored.matches_query( first_query ) );
    CHECK_FALSE( restored.matches_query( second_query ) );
    const auto first_points = zones.get_near( type, first.pos_abs(), 20, nullptr, fac, &first_query );
    const auto second_points = zones.get_near( type, second.pos_abs(), 20, nullptr, fac, &second_query );
    CHECK( first_points == std::unordered_set<tripoint_abs_ms>{ first.pos_abs() + first_offset } );
    CHECK( second_points == std::unordered_set<tripoint_abs_ms>{ second.pos_abs() + second_offset } );
    first_query.scope = zone_scope::static_only;
    CHECK( zones.get_near( type, first.pos_abs(), 20, nullptr, fac, &first_query ) ==
           std::unordered_set<tripoint_abs_ms>{ shared } );
    // A separate operator can recache or move without shifting this job.
    second.setpos( get_map(), tripoint_bub_ms( 62, 62, 0 ) );
    zones.cache_data();
    CHECK( zones.get_near( type, second.pos_abs(), 20, nullptr, fac, &second_query ) == second_points );
    for( const zone_data &zone : zones.get_zones( fac ) ) {
        CHECK( zone.get_enabled() );
        CHECK_FALSE( zone.get_temporarily_disabled() );
    }
}

TEST_CASE( "owned_zone_sort_keeps_personal_anchor_and_scope_across_save_and_travel",
           "[mp_inventory_activity][zone_sort_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope cleanup( [&]() { zones.clear(); } );
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_rel_ms offset( 1, 0, 0 );
    REQUIRE( zones.add( "Mine", zone_type_LOOT_UNSORTED, who.get_faction_id(),
                        false, true, offset, offset, nullptr, who.getID() ) );
    const std::string request = fixture.request( who, "start", []( JsonOut &out ) {
        out.member( "kind", "zone_sort" );
        out.member( "scope", static_cast<int>( zone_scope::personal_only ) );
    } );
    fixture.run( who, request );
    REQUIRE( who.activity.id() == ACT_MOVE_LOOT );
    auto *actor = dynamic_cast<zone_sort_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    actor->stage_init( who.activity, who );
    const std::uint64_t identity = who.activity.identity_generation();
    fixture.run( who, request );
    CHECK( who.activity.identity_generation() == identity );
    save_reload_activity( who );
    who.setpos( get_map(), tripoint_bub_ms( 63, 60, 0 ) );
    actor = dynamic_cast<zone_sort_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    actor->stage_init( who.activity, who );
    CHECK( actor->get_coord_set() == std::unordered_set<tripoint_abs_ms>{ origin + offset } );
    CHECK( who.activity.execution() == activity_execution::authoritative );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_zone_sort_moves_items_once_without_toggling_other_players_zones",
           "[mp_inventory_activity][zone_sort_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    get_avatar().setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope cleanup( [&]() { zones.clear(); } );
    const tripoint_abs_ms source = who.pos_abs() + tripoint::east;
    const tripoint_abs_ms destination = who.pos_abs() + tripoint::south;
    const faction_id fac = who.get_faction_id();
    REQUIRE( zones.add( "Input", zone_type_LOOT_UNSORTED, fac, false, true, source, source,
                        nullptr, true, nullptr, false ) );
    REQUIRE( zones.add( "Output", zone_type_LOOT_DEFAULT, fac, false, true, destination, destination,
                        nullptr, true, nullptr, false ) );
    const tripoint_rel_ms personal( 1, 0, 0 );
    REQUIRE( zones.add( "Host", zone_type_LOOT_UNSORTED, fac, false, true, personal, personal,
                        nullptr, get_avatar().getID() ) );
    here.add_item_or_charges( here.get_bub( source ), item( itype_rock ) );
    const int host_moves = get_avatar().get_moves();
    const std::string start = fixture.request( who, "start", []( JsonOut &out ) {
        out.member( "kind", "zone_sort" );
        out.member( "scope", static_cast<int>( zone_scope::static_only ) );
    } );
    fixture.run( who, start );
    REQUIRE( who.activity );
    for( int step = 0; step < 20 && who.activity; ++step ) {
        who.set_moves( 1000 );
        fixture.run( who, fixture.request( who, "step" ) );
    }
    CHECK_FALSE( who.activity );
    CHECK( here.i_at( here.get_bub( source ) ).empty() );
    REQUIRE( here.i_at( here.get_bub( destination ) ).size() == 1 );
    CHECK( here.i_at( here.get_bub( destination ) ).begin()->typeId() == itype_rock );
    fixture.run( who, start );
    CHECK_FALSE( who.activity );
    CHECK( here.i_at( here.get_bub( destination ) ).size() == 1 );
    CHECK( get_avatar().get_moves() == host_moves );
    for( const zone_data &zone : zones.get_zones( fac ) ) {
        CHECK( zone.get_enabled() );
        CHECK_FALSE( zone.get_temporarily_disabled() );
    }
}

TEST_CASE( "remote_sorting_uses_its_held_cart_without_sorting_transport_cargo",
           "[mp_inventory_activity][zone_sort_owned][grab_owned][vehicle]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    get_avatar().setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope cleanup( [&]() { zones.clear(); } );
    const tripoint_bub_ms source = who.pos_bub() + tripoint::east;
    const tripoint_bub_ms destination = who.pos_bub() + tripoint::south;
    vehicle *cart = here.add_vehicle( vehicle_prototype_test_shopping_cart, source, 0_degrees, 0,
                                      veh_spawn_status::UNDAMAGED );
    REQUIRE( cart );
    cart->set_owner( who.get_faction_id() );
    const auto cargo = here.veh_at( source ).cargo();
    REQUIRE( cargo );
    REQUIRE( cart->add_item( here, cargo->part(), item( itype_test_apple ) ) );
    here.add_item_or_charges( source, item( itype_test_apple ) );
    who.grab( object_type::VEHICLE, tripoint_rel_ms::east );
    REQUIRE( zone_sorting::grabbed_cart( who, here ) == cart );
    const faction_id fac = who.get_faction_id();
    REQUIRE( zones.add( "Ground input", zone_type_LOOT_UNSORTED, fac, false, true,
                        here.get_abs( source ), here.get_abs( source ), nullptr, true, nullptr, false ) );
    REQUIRE( zones.add( "Output", zone_type_LOOT_DEFAULT, fac, false, true,
                        here.get_abs( destination ), here.get_abs( destination ), nullptr, false ) );
    fixture.run( who, fixture.request( who, "start", []( JsonOut &out ) {
        out.member( "kind", "zone_sort" );
        out.member( "scope", static_cast<int>( zone_scope::static_only ) );
    } ) );
    for( int step = 0; step < 20 && who.activity; ++step ) {
        who.set_moves( 1000 );
        fixture.run( who, fixture.request( who, "step" ) );
    }
    CHECK_FALSE( who.activity );
    CHECK( here.i_at( source ).empty() );
    CHECK( here.i_at( destination ).size() == 1 );
    CHECK( cargo->items().size() == 1 );
    CHECK( who.validate_grab( here ) );
}

TEST_CASE( "saved_cart_sorting_batch_requires_the_same_operator_and_live_hold",
           "[mp_inventory_activity][zone_sort_owned][grab_owned][vehicle]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    get_avatar().setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
    who.set_str_base( 50 );
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope cleanup( [&]() { zones.clear(); } );
    const tripoint_bub_ms source = who.pos_bub() + tripoint::east;
    const tripoint_bub_ms destination = who.pos_bub() + tripoint( 5, 0, 0 );
    vehicle *cart = here.add_vehicle( vehicle_prototype_test_shopping_cart, source, 0_degrees, 0,
                                      veh_spawn_status::UNDAMAGED );
    REQUIRE( cart );
    cart->set_owner( who.get_faction_id() );
    const auto cargo = here.veh_at( source ).cargo();
    REQUIRE( cargo );
    REQUIRE( cart->add_item( here, cargo->part(), item( itype_test_apple ) ) );
    who.grab( object_type::VEHICLE, tripoint_rel_ms::east );
    const faction_id fac = who.get_faction_id();
    REQUIRE( zones.add( "Cart input", zone_type_LOOT_UNSORTED, fac, false, true,
                        here.get_abs( source ), here.get_abs( source ), nullptr, true ) );
    REQUIRE( zones.add( "Output", zone_type_LOOT_DEFAULT, fac, false, true,
                        here.get_abs( destination ), here.get_abs( destination ), nullptr, false ) );
    fixture.run( who, fixture.request( who, "start", []( JsonOut &out ) {
        out.member( "kind", "zone_sort" );
        out.member( "scope", static_cast<int>( zone_scope::static_only ) );
    } ) );
    auto *actor = dynamic_cast<zone_sort_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    actor->stage_init( who.activity, who );
    REQUIRE( actor->stage_think( who.activity, who ) );
    who.set_moves( 1 );
    actor->stage_do( who.activity, who );
    REQUIRE( who.get_moves() <= 0 );
    REQUIRE( cargo->items().size() == 1 );
    REQUIRE( activity_handlers::activity_item_owned_by( (*cargo->items().begin()), who ) );
    REQUIRE( here.i_at( destination ).empty() );
    save_reload_activity( who );
    bool deliver = true;
    vehicle *replacement = nullptr;
    SECTION( "same saved batch" ) {}
    SECTION( "another body receives the old activity" ) {
        npc &other = fixture.remote();
        bind_feedback_player( other, 'b', 702 );
        other.setpos( here, who.pos_bub() + tripoint::north );
        other.activity = who.activity;
        other.activity.actor->do_turn( other.activity, other );
        REQUIRE_FALSE( other.activity );
        CHECK( here.i_at( destination ).empty() );
        CHECK( activity_handlers::activity_item_owned_by( (*cargo->items().begin()), who ) );
    }
    SECTION( "cart replaced at the old handhold" ) {
        deliver = false;
        here.displace_vehicle( *cart, tripoint_rel_ms( 10, 0, 0 ) );
        replacement = here.add_vehicle( vehicle_prototype_test_shopping_cart, source, 0_degrees, 0,
                                        veh_spawn_status::UNDAMAGED );
        REQUIRE( replacement );
        replacement->set_owner( fac );
        const auto new_cargo = here.veh_at( source ).cargo();
        REQUIRE( new_cargo );
        REQUIRE( replacement->add_item( here, new_cargo->part(), item( itype_test_apple ) ) );
        zones.cache_vzones();
    }
    SECTION( "cancel releases the batch claim without moving cargo" ) {
        deliver = false;
        who.cancel_activity();
    }
    SECTION( "the held cart already contains the batch at its destination" ) {
        deliver = false; // Finish in the cargo, without creating a ground copy.
        here.displace_vehicle( *cart, tripoint_rel_ms( 4, 0, 0 ) );
        who.setpos( here, destination + tripoint::west, false );
        who.rebind_grab( here, destination );
        REQUIRE( who.grab_matches( here ) );
        zones.cache_vzones();
    }
    if( who.activity ) {
        who.set_moves( 1000 );
        who.activity.actor->do_turn( who.activity, who );
    }
    CHECK( here.i_at( destination ).size() == ( deliver ? 1 : 0 ) );
    CHECK( cargo->items().size() == ( deliver ? 0 : 1 ) );
    if( !deliver ) {
        CHECK_FALSE( (*cargo->items().begin()).has_var( "activity_var" ) );
    } else {
        CHECK_FALSE( here.i_at( destination ).begin()->has_var( "activity_var" ) );
    }
    if( replacement ) {
        REQUIRE( here.veh_at( source ).cargo() );
        CHECK( here.veh_at( source ).cargo()->items().size() == 1 );
    }
}

TEST_CASE( "saved_vehicle_item_locations_follow_identity_after_a_cart_moves",
           "[mp_inventory_activity][zone_sort_owned][vehicle][item_location]" )
{
    reload_fixture fixture;
    map &here = get_map();
    const tripoint_bub_ms source( 65, 60, 0 );
    vehicle *cart = here.add_vehicle( vehicle_prototype_test_shopping_cart, source, 0_degrees, 0,
                                      veh_spawn_status::UNDAMAGED );
    REQUIRE( cart );
    const auto cargo = here.veh_at( source ).cargo();
    REQUIRE( cargo );
    const auto added = cart->add_item( here, cargo->part(), item( itype_test_apple ) );
    REQUIRE( added );
    item_location location( vehicle_cursor( *cart, cargo->part_index() ), &**added );
    std::ostringstream stream;
    JsonOut out( stream );
    location.serialize( out );
    bool exists = true;
    SECTION( "the old cell now contains a different cart" ) {
        here.displace_vehicle( *cart, tripoint_rel_ms( 3, 0, 0 ) );
        REQUIRE( here.add_vehicle( vehicle_prototype_test_shopping_cart, source, 0_degrees, 0,
                                   veh_spawn_status::UNDAMAGED ) );
    }
    SECTION( "the original vehicle was removed" ) {
        exists = false;
        here.destroy_vehicle( cart );
        REQUIRE( here.add_vehicle( vehicle_prototype_test_shopping_cart, source, 0_degrees, 0,
                                   veh_spawn_status::UNDAMAGED ) );
    }
    location.deserialize( json_loader::from_string( stream.str() ).get_object() );
    CHECK( static_cast<bool>( location ) == exists );
    if( exists ) {
        REQUIRE( location.veh_cursor() );
        CHECK( &location.veh_cursor()->veh == cart );
        CHECK( location.pos_bub( here ) == source + tripoint( 3, 0, 0 ) );
    }
}

TEST_CASE( "sorting_route_cache_reacts_to_map_changes_without_moving_the_operator",
           "[zone_sort_owned][pathfinding]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms target = origin + tripoint( 4, 0, 0 );
    REQUIRE( zone_sorting::route_length( who, target ) != INT_MAX );
    for( int x = -1; x <= 1; ++x ) {
        for( int y = -1; y <= 1; ++y ) {
            if( x != 0 || y != 0 ) {
                here.ter_set( origin + tripoint( x, y, 0 ), ter_id( "t_wall" ) );
            }
        }
    }
    CHECK( zone_sorting::route_length( who, target ) == INT_MAX );
}

TEST_CASE( "sorting_map_transfer_keeps_the_unplaced_part_of_a_stack",
           "[mp_inventory_activity][zone_sort_owned][charges]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    const tripoint_bub_ms source_pos = who.pos_bub() + tripoint::east;
    const tripoint_bub_ms destination = who.pos_bub() + tripoint::south;
    item ammunition( itype_556, calendar::turn, 20 );
    const int capacity = ammunition.charges_per_volume( here.free_volume( destination ), true );
    REQUIRE( capacity > 20 );
    int room = 10;
    SECTION( "only half the source fits" ) {}
    SECTION( "none of the source fits" ) { room = 0; }
    item filler( ammunition );
    filler.charges = capacity - room;
    here.add_item( destination, filler );
    item_location source( map_cursor( source_pos ), &here.add_item( source_pos, ammunition ) );
    REQUIRE( source );
    const int placed = here.transfer_item_or_charges( destination, source, *source, who );
    CHECK( placed == room );
    REQUIRE( source );
    CHECK( source->charges == 20 - room );
    int destination_count = 0;
    for( const item &entry : here.i_at( destination ) ) {
        REQUIRE( entry.typeId() == itype_556 );
        destination_count += entry.charges;
    }
    CHECK( destination_count + source->charges == capacity - room + 20 );
    const units::volume stored = here.stored_volume( destination );
    CHECK( stored <= here.max_volume( destination ) );
}

TEST_CASE( "sorting_drop_callbacks_cannot_commit_a_replaced_or_modified_source",
           "[mp_inventory_activity][zone_sort_owned][charges]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    const tripoint_bub_ms source_pos = who.pos_bub() + tripoint::east;
    const tripoint_bub_ms destination = who.pos_bub() + tripoint::south;
    item_location source( map_cursor( source_pos ),
                          &here.add_item( source_pos, item( itype_556, calendar::turn, 20 ) ) );
    int expected = 0;
    bool original_survives = true;
    SECTION( "consumption reports the pre-callback quantity even without an output item" ) {
        who.set_value( "sorting_drop_mode", "consume" );
        expected = 20;
        original_survives = false;
    }
    SECTION( "same-type replacement keeps its own identity" ) {
        who.set_value( "sorting_drop_mode", "replace" );
        original_survives = false;
    }
    SECTION( "changed source payload is not overwritten by an earlier copy" ) {
        who.set_value( "sorting_drop_mode", "modify" );
    }
    SECTION( "map context changes stop insertion" ) {
        who.set_value( "sorting_drop_mode", "context" );
    }
    itype &type = *const_cast<itype *>( item::find_type( itype_556 ) );
    const restore_on_out_of_scope restore_drop( type.drop_action );
    type.drop_action = use_function( "sorting_source_change", []( Character *actor, item *value,
                                     const tripoint_bub_ms & ) -> std::optional<int> {
                                         map &here = get_map();
                                         const tripoint_bub_ms source = actor->pos_bub() + tripoint::east;
                                         const std::string mode = actor->get_value( "sorting_drop_mode" ).str();
    if( mode == "consume" ) {
    value->charges = 0;
    return 1;
}
if( mode == "replace" ) {
    here.i_clear( source );
        here.add_item( source, item( itype_556, calendar::turn, 20 ) );
    } else if( mode == "modify" ) {
    here.i_at( source ).begin()->set_var( "sorting_callback_change", "retained" );
    } else {
        map_meddler::set_abs_sub( here, here.get_abs_sub() );
    }
    return std::nullopt;
                                     } );
    CHECK( here.transfer_item_or_charges( destination, source, *source, who ) == expected );
    CHECK( static_cast<bool>( source ) == original_survives );
    CHECK( here.i_at( destination ).empty() );
    if( expected == 0 ) {
        REQUIRE( here.i_at( source_pos ).size() == 1 );
        CHECK( here.i_at( source_pos ).begin()->charges == 20 );
        if( who.get_value( "sorting_drop_mode" ).str() == "modify" ) {
            CHECK( here.i_at( source_pos ).begin()->get_var( "sorting_callback_change", "" ) == "retained" );
        }
    } else {
        CHECK( here.i_at( source_pos ).empty() );
    }
}

TEST_CASE( "sorting_settles_a_drop_before_leaving_a_callback_replacement_activity",
           "[mp_inventory_activity][zone_sort_owned][vehicle]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope cleanup( [&]() { zones.clear(); } );
    const bool consumed = GENERATE( false, true );
    const bool restart_sorting = GENERATE( false, true );
    who.set_value( "sorting_drop_restart", restart_sorting ? "yes" : "no" );
    who.set_value( "sorting_drop_consumed", consumed ? "yes" : "no" );
    const tripoint_bub_ms source = who.pos_bub() + tripoint::east;
    tripoint_bub_ms destination = who.pos_bub() + tripoint::south;
    vehicle *cart = nullptr;
    item_location original;
    SECTION( "adjacent ground transfer" ) {
        original = item_location( map_cursor( source ), &here.add_item( source, item( itype_rock ) ) );
    }
    SECTION( "saved pending cargo transfer" ) {
        destination = who.pos_bub() + tripoint( 5, 0, 0 );
        cart = here.add_vehicle( vehicle_prototype_test_shopping_cart, source, 0_degrees, 0,
                                 veh_spawn_status::UNDAMAGED );
        REQUIRE( cart );
        cart->set_owner( who.get_faction_id() );
        const auto cargo = here.veh_at( source ).cargo();
        REQUIRE( cargo );
        const auto added = cart->add_item( here, cargo->part(), item( itype_rock ) );
        REQUIRE( added );
        original = item_location( vehicle_cursor( *cart, cargo->part_index() ), &**added );
        who.grab( object_type::VEHICLE, tripoint_rel_ms::east );
    }
    const faction_id faction = who.get_faction_id();
    REQUIRE( zones.add( "Input", zone_type_LOOT_UNSORTED, faction, false, true,
                        here.get_abs( source ), here.get_abs( source ), nullptr, true ) );
    REQUIRE( zones.add( "Output", zone_type_LOOT_DEFAULT, faction, false, true,
                        here.get_abs( destination ), here.get_abs( destination ), nullptr, true ) );
    fixture.run( who, fixture.request( who, "start", []( JsonOut &out ) {
        out.member( "kind", "zone_sort" );
        out.member( "scope", static_cast<int>( zone_scope::static_only ) );
    } ) );
    auto *actor = dynamic_cast<zone_sort_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    actor->stage_init( who.activity, who );
    REQUIRE( actor->stage_think( who.activity, who ) );
    if( cart ) {
        who.set_moves( 1 );
        actor->stage_do( who.activity, who );
        REQUIRE( original );
        REQUIRE( activity_handlers::activity_item_owned_by( *original, who ) );
        save_reload_activity( who );
    }
    itype &type = *const_cast<itype *>( item::find_type( itype_rock ) );
    const restore_on_out_of_scope restore_drop( type.drop_action );
    type.drop_action = use_function( "sorting_activity_replacement", []( Character *actor, item *,
                                     const tripoint_bub_ms & ) -> std::optional<int> {
                                         actor->set_value( "sorting_drop_seen", "yes" );
                                         actor->cancel_activity();
    if( actor->get_value( "sorting_drop_restart" ).str() == "yes" ) {
    actor->assign_activity( zone_sort_activity_actor( zone_scope::static_only ) );
    } else {
        actor->assign_activity( player_activity( ACT_WAIT, 100 ) );
    }
    return actor->get_value( "sorting_drop_consumed" ).str() == "yes" ?
           std::make_optional( 1 ) : std::nullopt;
                                     } );
    const int host_moves = host.get_moves();
    who.set_moves( 1000 );
    REQUIRE( who.activity.actor );
    who.activity.actor->do_turn( who.activity, who );
    CHECK( who.get_value( "sorting_drop_seen" ).str() == "yes" );
    CHECK( who.activity.id() == activity_id( restart_sorting ? "ACT_MOVE_LOOT" : "ACT_WAIT" ) );
    CHECK( who.get_moves() < 1000 );
    CHECK( host.get_moves() == host_moves );
    CHECK_FALSE( original );
    CHECK( here.i_at( source ).empty() );
    if( cart ) {
        REQUIRE( here.veh_at( source ).cargo() );
        CHECK( here.veh_at( source ).cargo()->items().empty() );
    }
    CHECK( here.i_at( destination ).size() == ( consumed ? 0 : 1 ) );
    if( !consumed ) {
        CHECK_FALSE( here.i_at( destination ).begin()->has_var( "activity_var" ) );
    }
}

TEST_CASE( "sorting_auto_wield_commits_its_source_before_acquisition_events",
           "[mp_inventory_activity][zone_sort_owned][wield]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 90, 90, 0 ) );
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope cleanup( [&]() { zones.clear(); } );
    const bool replace_weapon = GENERATE( false, true );
    const tripoint_bub_ms source = who.pos_bub() + tripoint::east;
    const tripoint_bub_ms destination = who.pos_bub() + tripoint( 5, 0, 0 );
    here.add_item( source, item( itype_rock ) );
    REQUIRE_FALSE( who.has_weapon() );
    const faction_id faction = who.get_faction_id();
    REQUIRE( zones.add( "Input", zone_type_LOOT_UNSORTED, faction, false, true,
                        here.get_abs( source ), here.get_abs( source ), nullptr, true ) );
    REQUIRE( zones.add( "Output", zone_type_LOOT_DEFAULT, faction, false, true,
                        here.get_abs( destination ), here.get_abs( destination ), nullptr, true ) );
    fixture.run( who, fixture.request( who, "start", []( JsonOut &out ) {
        out.member( "kind", "zone_sort" );
        out.member( "scope", static_cast<int>( zone_scope::static_only ) );
    } ) );
    class replace_on_wield : public event_subscriber {
        public:
            Character &who;
            tripoint_bub_ms source;
            bool replace_weapon;
            bool fired = false;
            replace_on_wield( Character &who, tripoint_bub_ms source, bool replace_weapon ) :
                who( who ), source( source ), replace_weapon( replace_weapon ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( fired || event.type() != event_type::character_wields_item ||
                    event.get<character_id>( "character" ) != who.getID() ) {
                    return;
                }
                fired = true;
                CHECK( get_map().i_at( source ).empty() );
                who.cancel_activity();
                who.assign_activity( player_activity( ACT_WAIT, 100 ) );
                if( replace_weapon ) {
                    who.set_wielded_item( item( itype_stick ) );
                }
            }
    } events( who, source, replace_weapon );
    who.set_moves( 1000 );
    REQUIRE( who.activity.actor );
    who.activity.actor->do_turn( who.activity, who );
    REQUIRE( events.fired );
    CHECK( who.activity.id() == ACT_WAIT );
    CHECK( here.i_at( source ).empty() );
    CHECK( here.i_at( destination ).empty() );
    const item_location wielded = who.get_wielded_item();
    REQUIRE( wielded );
    CHECK( wielded->typeId() == itype_id( replace_weapon ? "stick" : "rock" ) );
    CHECK_FALSE( wielded->has_var( "activity_var" ) );
}

TEST_CASE( "zone_identity_survives_save_and_does_not_consume_gameplay_rng",
           "[mp_inventory_activity][zone_edit_owned]" )
{
    reload_fixture fixture;
    const std::string rng_before = capture_rng_state();
    zone_data zone( "Saved zone", zone_type_LOOT_UNSORTED, your_fac, false, true,
                    get_avatar().pos_abs(), get_avatar().pos_abs() );
    REQUIRE( zone_data::valid_identity( zone.get_identity() ) );
    const std::string &identity = zone.get_identity();
    std::ostringstream stream;
    JsonOut out( stream );
    zone.serialize( out );
    zone_data restored;
    restored.deserialize( json_loader::from_string( stream.str() ).get_object() );
    CHECK( restored.get_identity() == identity );
    CHECK( restored.make_edit_draft().get_identity() == identity );
    CHECK( capture_rng_state() == rng_before );

    // Old files did not have identities. Loading grants one without changing the layout.
    restored.deserialize( json_loader::from_string(
                              R"({"name":"Legacy","type":"LOOT_UNSORTED","start":[1,2,0],"end":[3,4,0]})" ).get_object() );
    CHECK( zone_data::valid_identity( restored.get_identity() ) );
    CHECK( restored.get_identity() != identity );
    CHECK( restored.get_start_point() == tripoint_abs_ms( 1, 2, 0 ) );
    CHECK( restored.get_end_point() == tripoint_abs_ms( 3, 4, 0 ) );
    CHECK( capture_rng_state() == rng_before );
}

TEST_CASE( "zone_edit_draft_does_not_mutate_world_options_or_cache",
           "[mp_inventory_activity][zone_edit_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    const auto options = make_shared_fast<loot_options>();
    options->set_mark( "rock" );
    const tripoint_abs_ms position = who.pos_abs() + tripoint::east;
    zone_data *live = manager.add( "Original", zone_type_LOOT_CUSTOM, who.get_faction_id(),
                                   false, true, position, position, options, true, nullptr, false );
    REQUIRE( live );
    const zone_edit_definition original = zone_edit_definition::capture( *live );
    const auto original_points = manager.get_near( zone_type_LOOT_CUSTOM, position, 5,
                                 nullptr, who.get_faction_id() );
    {
        zone_edit_session editor( who, manager );
        REQUIRE( editor.finish().empty() );
        const auto drafts = editor.get_zones();
        REQUIRE( drafts.size() == 1 );
        zone_data &draft = drafts.front().get();
        CHECK( draft.get_identity() == live->get_identity() );
        REQUIRE( draft.set_name( "Changed" ) );
        draft.set_enabled( false );
        dynamic_cast<loot_options &>( draft.get_options() ).set_mark( "stick" );
        draft.set_position( std::make_pair( position + tripoint( 2, 0, 0 ), position + tripoint( 2, 0, 0 ) ) );
        draft.toggle_display();
        const zone_edit_batch batch = editor.finish();
        REQUIRE( batch.changes.size() == 1 );
        REQUIRE( batch.changes.front().before );
        REQUIRE( batch.changes.front().after );
        CHECK( *batch.changes.front().before == original );
        CHECK( batch.changes.front().after->name == "Changed" );
        CHECK( batch.changes.front().after->displayed );
        CHECK( zone_edit_definition::capture( *live ) == original );
    }
    // Cancelling only destroys the draft; no temporary zone file or world rollback is needed.
    CHECK( zone_edit_definition::capture( *live ) == original );
    CHECK( manager.get_near( zone_type_LOOT_CUSTOM, position, 5,
                             nullptr, who.get_faction_id() ) == original_points );
    CHECK( dynamic_cast<const loot_options &>( live->get_options() ).get_mark() == "rock" );
}

TEST_CASE( "zone_edit_session_keeps_owners_and_originals_for_combined_submit",
           "[mp_inventory_activity][zone_edit_owned]" )
{
    reload_fixture fixture;
    npc &first = fixture.remote();
    npc &second = fixture.remote();
    bind_feedback_player( first, 'a', 701 );
    bind_feedback_player( second, 'b', 702 );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    const zone_type_id &type = zone_type_LOOT_UNSORTED;
    const faction_id fac = first.get_faction_id();
    const tripoint_rel_ms offset( 1, 0, 0 );
    REQUIRE( manager.add( "First", type, fac, false, true, offset, offset, nullptr, first.getID() ) );
    REQUIRE( manager.add( "Second", type, fac, false, true, offset, offset, nullptr, second.getID() ) );
    const tripoint_abs_ms position = first.pos_abs();
    REQUIRE( manager.add( "Shared", type, fac, false, true, position, position,
                          nullptr, true, nullptr, false ) );
    zone_edit_session editor( first, manager );
    auto drafts = editor.get_zones();
    REQUIRE( drafts.size() == 2 );
    CHECK( drafts.front().get().get_name() == "First" );
    const std::string first_id = drafts.front().get().get_identity();
    const std::string shared_id = drafts.back().get().get_identity();
    REQUIRE( editor.swap( drafts.front(), drafts.back() ) );
    REQUIRE( drafts.front().get().set_name( "Renamed shared" ) );
    const zone_edit_batch reordered = editor.finish();
    CHECK( reordered.expected_order == std::vector<std::string>{ first_id, shared_id } );
    CHECK( reordered.order == std::vector<std::string>{ shared_id, first_id } );
    REQUIRE( reordered.changes.size() == 1 );
    REQUIRE( reordered.changes.front().before );
    CHECK( reordered.changes.front().before->name == "Shared" );

    // A second editor cannot replace the expected state captured by the first editor.
    for( zone_data &live : manager.get_zones( fac ) ) {
        if( live.get_identity() == shared_id ) {
            REQUIRE( live.set_name( "Another player's edit" ) );
        }
    }
    CHECK( editor.finish().changes.front().before->name == "Shared" );
    REQUIRE( editor.remove( drafts.back() ) );
    zone_data added( "New personal", type, fac, false, true, offset, offset );
    zone_data &new_draft = editor.add( added );
    CHECK( new_draft.get_identity() != added.get_identity() );
    CHECK( new_draft.get_personal_owner() == first.getID() );
    const zone_edit_batch batch = editor.finish();
    REQUIRE( batch.changes.size() == 3 );
    std::ostringstream stream;
    JsonOut out( stream );
    batch.serialize( out );
    zone_edit_batch decoded;
    decoded.deserialize( json_loader::from_string( stream.str() ).get_object() );
    CHECK( decoded.expected_order == batch.expected_order );
    CHECK( decoded.order == batch.order );
    REQUIRE( decoded.changes.size() == batch.changes.size() );
    for( size_t i = 0; i < batch.changes.size(); ++i ) {
        CHECK( decoded.changes[i].identity == batch.changes[i].identity );
        CHECK( decoded.changes[i].before == batch.changes[i].before );
        CHECK( decoded.changes[i].after == batch.changes[i].after );
    }
    CHECK( manager.size() == 3 );
}

TEST_CASE( "detached_vehicle_zone_can_be_edited_without_a_live_vehicle_handle",
           "[mp_inventory_activity][zone_edit_owned]" )
{
    reload_fixture fixture;
    zone_data original( "Vehicle", zone_type_LOOT_UNSORTED, your_fac, false, true,
                        get_avatar().pos_abs(), get_avatar().pos_abs() );
    original.set_is_vehicle( true );
    zone_data draft = original.make_edit_draft();
    CHECK( draft.set_name( "Edited vehicle" ) );
    draft.set_enabled( false );
    CHECK( original.get_enabled() );
    CHECK( original.get_name() == "Vehicle" );
    CHECK( draft.get_identity() == original.get_identity() );
}

TEST_CASE( "zone_edit_authority_applies_a_combined_draft_and_preserves_other_owners",
           "[mp_inventory_activity][zone_edit_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    npc &other = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    bind_feedback_player( other, 'b', 702 );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    const zone_type_id &type = zone_type_LOOT_UNSORTED;
    const tripoint_rel_ms offset( 1, 0, 0 );
    const faction_id fac = who.get_faction_id();
    REQUIRE( manager.add( "Mine", type, fac, false, true, offset, offset, nullptr, who.getID() ) );
    const std::string owned_id = manager.get_zones( fac ).back().get().get_identity();
    REQUIRE( manager.add( "Theirs", type, fac, false, true, offset, offset, nullptr, other.getID() ) );
    const std::string other_id = manager.get_zones( fac ).back().get().get_identity();
    REQUIRE( manager.add( "Shared", type, fac, false, true, who.pos_abs(), who.pos_abs(),
                          nullptr, true, nullptr, false ) );
    const std::string shared_id = manager.get_zones( fac ).back().get().get_identity();
    zone_edit_session editor( who, manager );
    auto drafts = editor.get_zones();
    REQUIRE( drafts.size() == 2 );
    REQUIRE( drafts.front().get().set_name( "Renamed mine" ) );
    REQUIRE( editor.remove( drafts.back() ) );
    zone_data layout( "New shared", type, fac, false, true,
                      who.pos_abs() + tripoint( 2, 0, 0 ), who.pos_abs() + tripoint( 2, 0, 0 ) );
    const std::string creation_token = editor.add( layout ).get_identity();
    drafts = editor.get_zones();
    REQUIRE( editor.swap( drafts.front(), drafts.back() ) );
    const std::string rng_before = capture_rng_state();
    const zone_edit_batch batch = editor.finish();
    REQUIRE( zone_edit_session::apply( who, manager, batch ) );
    CHECK( capture_rng_state() == rng_before );
    auto live = manager.get_zones( fac );
    REQUIRE( live.size() == 3 );
    CHECK( live[0].get().get_name() == "New shared" );
    CHECK( live[0].get().get_identity() != creation_token );
    CHECK( live[1].get().get_identity() == other_id );
    CHECK( live[1].get().get_name() == "Theirs" );
    CHECK( live[2].get().get_identity() == owned_id );
    CHECK( live[2].get().get_name() == "Renamed mine" );
    CHECK( live[2].get().get_personal_owner() == who.getID() );
    CHECK( std::none_of( live.begin(), live.end(), [&]( const zone_manager::ref_zone_data &entry ) {
        return entry.get().get_identity() == shared_id;
    } ) );
    CHECK_FALSE( zone_edit_session::apply( who, manager, batch ) );
    CHECK( manager.size() == 3 );
}

TEST_CASE( "zone_edit_rejects_conflicts_and_invalid_choices_before_any_mutation",
           "[mp_inventory_activity][zone_edit_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    npc &other = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    bind_feedback_player( other, 'b', 702 );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    const zone_type_id &type = zone_type_LOOT_UNSORTED;
    const faction_id fac = who.get_faction_id();
    const tripoint_rel_ms offset( 1, 0, 0 );
    REQUIRE( manager.add( "Mine", type, fac, false, true, offset, offset, nullptr, who.getID() ) );
    REQUIRE( manager.add( "Shared", type, fac, false, true, who.pos_abs(), who.pos_abs(),
                          nullptr, true, nullptr, false ) );
    REQUIRE( manager.add( "Theirs", type, fac, false, true, offset, offset, nullptr, other.getID() ) );
    zone_edit_session editor( who, manager );
    auto drafts = editor.get_zones();
    REQUIRE( drafts.size() == 2 );
    REQUIRE( drafts.front().get().set_name( "First valid edit" ) );
    REQUIRE( drafts.back().get().set_name( "Second edit" ) );
    zone_edit_batch batch = editor.finish();
    REQUIRE( batch.changes.size() == 2 );
    auto live = manager.get_zones( fac );
    SECTION( "stale shared zone" ) {
        REQUIRE( live[1].get().set_name( "Concurrent edit" ) );
    }
    SECTION( "foreign personal zone even in local debug mode" ) {
        batch.changes.back().identity = live[2].get().get_identity();
        batch.changes.back().before = zone_edit_definition::capture( live[2] );
        batch.changes.back().after = batch.changes.back().before;
        batch.changes.back().after->name = "Stolen";
        restore_on_out_of_scope restore_debug( debug_mode );
        debug_mode = true;
        CHECK_FALSE( zone_edit_session::apply( who, manager, batch ) );
        CHECK( live.front().get().get_name() == "Mine" );
        return;
    }
    SECTION( "overflowing geometry" ) {
        batch.changes.back().after->start.x = std::numeric_limits<int>::min();
        batch.changes.back().after->end.x = std::numeric_limits<int>::max();
    }
    SECTION( "invalid native option blob" ) {
        batch.changes.back().after->options = R"({"personal_owner":1234})";
    }
    SECTION( "forged faction" ) {
        batch.faction = faction_hells_raiders;
    }
    SECTION( "duplicate identity" ) {
        batch.changes.back().identity = batch.changes.front().identity;
    }
    SECTION( "foreign zone inserted into order" ) {
        batch.order.push_back( live[2].get().get_identity() );
    }
    CHECK_FALSE( zone_edit_session::apply( who, manager, batch ) );
    CHECK( live.front().get().get_name() == "Mine" );
    CHECK( live.back().get().get_name() == "Theirs" );
    CHECK( manager.size() == 3 );
}

TEST_CASE( "zone_editor_projection_and_request_replay_keep_world_authority",
           "[mp_inventory_activity][zone_edit_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    npc &other = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    bind_feedback_player( other, 'b', 702 );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    const zone_type_id &type = zone_type_LOOT_UNSORTED;
    const faction_id fac = who.get_faction_id();
    const tripoint_rel_ms offset( 1, 0, 0 );
    REQUIRE( manager.add( "Mine", type, fac, false, true, offset, offset, nullptr, who.getID() ) );
    REQUIRE( manager.add( "Theirs", type, fac, false, true, offset, offset, nullptr, other.getID() ) );
    const std::string query = fixture.request( who, "start", []( JsonOut &out ) {
        out.member( "kind", "zone_query" );
    } );
    const std::string rng_before = capture_rng_state();
    const JsonObject response = json_loader::from_string( fixture.run( who, query ) ).get_object();
    REQUIRE( response.has_object( "zone_editor" ) );
    auto editor = zone_edit_session::read_view( who, response.get_object( "zone_editor" ) );
    REQUIRE( editor );
    REQUIRE( editor->get_zones().size() == 1 );
    CHECK( editor->finish().empty() );
    REQUIRE( editor->get_zones().front().get().set_name( "Edited from server view" ) );
    CHECK( manager.get_zones( fac ).front().get().get_name() == "Mine" );
    CHECK( capture_rng_state() == rng_before );
    const std::string edit = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "zone_edit" );
        out.member( "zones", editor->finish() );
    } );
    fixture.run( who, edit );
    CHECK( manager.get_zones( fac ).front().get().get_name() == "Edited from server view" );
    CHECK( fixture.reload.refresh_observers );
    REQUIRE( manager.get_zones( fac ).front().get().set_name( "After request" ) );
    fixture.run( who, edit );
    CHECK_FALSE( fixture.reload.refresh_observers );
    CHECK( manager.get_zones( fac ).front().get().get_name() == "After request" );
    CHECK( manager.get_zones( fac ).back().get().get_personal_owner() == other.getID() );
    CHECK( capture_rng_state() == rng_before );
}

TEST_CASE( "vehicle_zone_edits_resolve_exact_cargo_and_do_not_replay_creation",
           "[mp_inventory_activity][zone_edit_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    vehicle &car = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    int cargo_index = -1;
    for( const vpart_reference &part : car.get_avail_parts( "CARGO" ) ) {
        cargo_index = part.part_index();
        break;
    }
    REQUIRE( cargo_index >= 0 );
    const int64_t part_id = car.part( cargo_index ).get_base().uid().get_value();
    const tripoint_abs_ms location = car.abs_part_pos( cargo_index );
    zone_data layout( "Cargo", zone_type_LOOT_UNSORTED, who.get_faction_id(), false, true,
                      location, location );
    zone_edit_session creator( who, manager );
    creator.add( layout, car.uid().get_value(), part_id );
    const std::string create = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "zone_edit" );
        out.member( "zones", creator.finish() );
    } );
    fixture.run( who, create );
    REQUIRE( car.loot_zones.size() == 1 );
    CHECK( manager.size() == 0 );
    fixture.run( who, create );
    CHECK( car.loot_zones.size() == 1 );
    zone_edit_session editor( who, manager );
    auto drafts = editor.get_zones();
    REQUIRE( drafts.size() == 1 );
    REQUIRE( drafts.front().get().set_name( "Renamed cargo" ) );
    const zone_edit_batch batch = editor.finish();
    REQUIRE( batch.changes.front().before );
    CHECK( batch.changes.front().before->vehicle == car.uid().get_value() );
    CHECK( batch.changes.front().before->part == part_id );
    SECTION( "exact cargo accepted" ) {
        REQUIRE( zone_edit_session::apply( who, manager, batch ) );
        REQUIRE( car.loot_zones.size() == 1 );
        CHECK( car.loot_zones.begin()->second.get_name() == "Renamed cargo" );
    }
    SECTION( "same-position replacement rejected" ) {
        const vpart_id part_type = car.part( cargo_index ).info().id;
        const point_rel_ms mount = car.part( cargo_index ).mount;
        car.remove_part( car.part( cargo_index ) );
        const int replacement = car.install_part( here, mount, part_type );
        REQUIRE( replacement >= 0 );
        REQUIRE( car.part( replacement ).get_base().uid().get_value() != part_id );
        CHECK_FALSE( zone_edit_session::apply( who, manager, batch ) );
        for( const auto &zone : car.loot_zones ) {
            CHECK( zone.second.get_name() != "Renamed cargo" );
        }
    }
    SECTION( "owner changed" ) {
        car.set_owner( faction_no_faction );
        CHECK_FALSE( zone_edit_session::apply( who, manager, batch ) );
        CHECK( car.loot_zones.begin()->second.get_name() == "Cargo" );
    }
}

namespace
{
// Count native framework scans without relying on timings or test-only engine hooks.
class counted_zone_scan : public multi_mop_activity_actor
{
    public:
        std::shared_ptr<int> scans = std::make_shared<int>( 0 );
        std::unordered_set<tripoint_abs_ms> multi_activity_locations( Character & ) override {
            ++*scans;
            return {};
        }
        std::unique_ptr<activity_actor> clone() const override {
            return std::make_unique<counted_zone_scan>( *this );
        }
};
} // namespace

TEST_CASE( "zone_work_scan_cache_belongs_to_one_job_and_observes_zone_edits",
           "[mp_inventory_activity][zone_work_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    const tripoint_abs_ms position = who.pos_abs();
    REQUIRE( manager.add( "Work", zone_type_MOPPING, who.get_faction_id(), false, true,
                          position, position, nullptr, true, nullptr, false ) );
    const auto scan = [&]() {
        auto *actor = dynamic_cast<counted_zone_scan *>( who.activity.actor.get() );
        REQUIRE( actor );
        who.set_moves( 100 );
        actor->simulate_turn( who.activity, who, false );
    };
    counted_zone_scan first;
    who.activity = player_activity( first );
    scan();
    CHECK( *first.scans == 1 );
    player_activity continuation = who.activity;
    who.activity = continuation;
    scan();
    CHECK( *first.scans == 1 );

    // Same operator, activity type and position, but a separate work order.
    counted_zone_scan second;
    who.activity = player_activity( second );
    scan();
    CHECK( *second.scans == 1 );
    auto zones = manager.get_zones( who.get_faction_id() );
    REQUIRE( zones.size() == 1 );
    zones.front().get().set_enabled( false );
    scan();
    CHECK( *second.scans == 2 );
    CHECK( *first.scans == 1 );
    zones.front().get().set_enabled( true );
    scan();
    CHECK( *second.scans == 3 );
}

TEST_CASE( "zone_fetch_preserves_parent_origin_and_runtime_requirements_across_save",
           "[mp_inventory_activity][zone_work_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_rel_ms offset( 10, 0, 0 );
    const tripoint_abs_ms source = origin + offset;
    const tripoint_abs_ms destination = origin + tripoint::south;
    REQUIRE( manager.add( "Materials", zone_type_LOOT_DEFAULT, who.get_faction_id(),
                          false, true, offset, offset, nullptr, who.getID() ) );
    here.add_item_or_charges( here.get_bub( source ), item( itype_rock ) );
    who.assign_activity( multi_build_construction_activity_actor() );
    who.activity.set_execution( activity_execution::authoritative );
    save_reload_activity( who );
    who.setpos( here, here.get_bub( origin + tripoint( 0, 2, 0 ) ) );
    const requirement_data requirements( {}, {}, { { item_comp( itype_rock, 1 ) } } );
    const requirement_id requirement = multi_activity_actor::hash_and_cache_requirement_data( requirements );
    who.assign_activity( fetch_required_activity_actor( requirement, do_activity_reason::NO_COMPONENTS,
                         destination, origin ) );
    REQUIRE( who.backlog.size() == 1 );
    REQUIRE( who.backlog.front().id() == ACT_MULTIPLE_CONSTRUCTION );
    CHECK( active_zone_query( who ).origin == origin );
    save_reload_activity( who );
    auto *actor = dynamic_cast<fetch_required_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    CHECK( actor->query_for( who ).origin == origin );
    CHECK( actor->multi_activity_locations( who ) == std::unordered_set<tripoint_abs_ms>{ source } );
    // Travel and a global recache must not move the personal material source.
    who.setpos( here, here.get_bub( source + tripoint::west ) );
    manager.cache_data();
    REQUIRE( actor->fetch_activity( who, here.get_bub( source ), ACT_FETCH_REQUIRED ) );
    CHECK( here.i_at( here.get_bub( source ) ).empty() );
    REQUIRE( here.i_at( here.get_bub( destination ) ).size() == 1 );
    CHECK( here.i_at( here.get_bub( destination ) ).begin()->typeId() == itype_rock );
    CHECK( who.job.fetch_history.empty() );

    // Old actor payloads lacked requirements. The parent can recompute them.
    JsonValue legacy = json_loader::from_string( "{}" );
    auto old_actor = fetch_required_activity_actor::deserialize( legacy );
    const auto *old_fetch = dynamic_cast<fetch_required_activity_actor *>( old_actor.get() );
    REQUIRE( old_fetch );
    CHECK_FALSE( old_fetch->fetch_activity_valid( who ) );
}

TEST_CASE( "zone_action_query_and_dispatch_use_the_actual_owner_and_do_not_replay",
           "[mp_inventory_activity][zone_work_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    npc &other = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    bind_feedback_player( other, 'b', 702 );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    const tripoint_rel_ms offset( 1, 0, 0 );
    const zone_type_id &type = zone_type_MOPPING;
    REQUIRE( manager.add( "Other", type, who.get_faction_id(), false, true,
                          offset, offset, nullptr, other.getID() ) );
    CHECK_FALSE( start_owned_zone_work( who, "mop" ) );
    REQUIRE( manager.add( "Mine", type, who.get_faction_id(), false, true,
                          offset, offset, nullptr, who.getID() ) );
    const int host_moves = get_avatar().get_moves();
    const std::string query = fixture.request( who, "start", []( JsonOut &out ) {
        out.member( "kind", "zone_query" );
        out.member( "zone_actions", true );
    } );
    const JsonObject response = json_loader::from_string( fixture.run( who, query ) ).get_object();
    REQUIRE( response.get_bool( "zone_actions" ) );
    auto menu = zone_edit_session::read_view( who, response.get_object( "zone_editor" ) );
    REQUIRE( menu );
    REQUIRE( menu->get_zones().size() == 1 );
    CHECK( menu->has_near( type, who.pos_abs(), MAX_VIEW_DISTANCE ) );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( start_owned_zone_work( who, "unknown action" ) );
    const std::string request = fixture.request( who, "start", []( JsonOut &out ) {
        out.member( "kind", "zone_work" );
        out.member( "zone_action", "mop" );
    } );
    fixture.run( who, request );
    REQUIRE( who.activity.id() == ACT_MULTIPLE_MOP );
    const std::uint64_t identity = who.activity.identity_generation();
    fixture.run( who, request );
    CHECK( who.activity.identity_generation() == identity );
    CHECK( who.activity.execution() == activity_execution::authoritative );
    CHECK_FALSE( other.activity );
    CHECK_FALSE( get_avatar().activity );
    CHECK( get_avatar().get_moves() == host_moves );
}

TEST_CASE( "zone_unload_rechecks_owner_and_zone_after_planning",
           "[mp_inventory_activity][zone_work_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    npc &other = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    bind_feedback_player( other, 'b', 702 );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    auto options = make_shared_fast<unload_options>();
    options->deserialize( json_loader::from_string(
                              R"({"mark":"","mods":false,"molle":false,"sparse_only":false,"sparse_threshold":20,"always_unload":true})" ).get_object() );
    const tripoint_rel_ms mine( 1, 0, 0 );
    const tripoint_rel_ms theirs( 0, 1, 0 );
    const tripoint_abs_ms origin = who.pos_abs();
    const zone_type_id &type = zone_type_UNLOAD_ALL;
    REQUIRE( manager.add( "Mine", type, who.get_faction_id(), false, true,
                          mine, mine, options, who.getID() ) );
    REQUIRE( manager.add( "Other", type, who.get_faction_id(), false, true,
                          theirs, theirs, options, other.getID() ) );
    item bag( itype_backpack );
    REQUIRE( bag.put_in( item( itype_rock ), pocket_type::CONTAINER ).success() );
    const item_location owned = here.add_item_or_charges_ret_loc( here.get_bub( origin + mine ), bag );
    const item_location foreign = here.add_item_or_charges_ret_loc( here.get_bub( origin + theirs ), bag );
    REQUIRE( owned );
    REQUIRE( foreign );
    REQUIRE( start_owned_zone_work( who, "unload" ) );
    save_reload_activity( who );
    auto *actor = dynamic_cast<unload_loot_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    actor->stage_init( who.activity, who );
    REQUIRE( actor->stage_think( who.activity, who ) );
    bool enabled = true;
    SECTION( "unloads only the operator personal zone" ) {}
    SECTION( "disabled between planning and execution" ) {
        manager.get_zones( who.get_faction_id() ).front().get().set_enabled( false );
        enabled = false;
    }
    actor->stage_do( who.activity, who );
    CHECK( owned->all_items_top( pocket_type::CONTAINER ).empty() == enabled );
    CHECK( foreign->all_items_top( pocket_type::CONTAINER ).size() == 1 );
}

TEST_CASE( "local_zone_construction_completion_resumes_the_original_work_order",
           "[mp_inventory_activity][zone_work_owned][construction_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    who.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    const tripoint_abs_ms origin = who.pos_abs();
    who.assign_activity( multi_build_construction_activity_actor() );
    who.setpos( here, tripoint_bub_ms( 61, 60, 0 ) );
    const tripoint_bub_ms target( 61, 61, 0 );
    here.ter_set( target, ter_t_dirt );
    partial_con site;
    site.id = construction_constr_wall_half.id();
    here.partial_con_set( target, site );
    who.assign_activity( build_construction_activity_actor( here.get_abs( target ) ) );
    REQUIRE( who.backlog.size() == 1 );
    auto *building = dynamic_cast<build_construction_activity_actor *>( who.activity.actor.get() );
    REQUIRE( building );
    building->complete_construction( who.activity, who );
    CHECK_FALSE( here.partial_con_at( target ) );
    CHECK( here.ter( target ) == ter_t_wall_half );
    // This is the same resume performed by player_activity after completion.
    who.resume_backlog_activity();
    const auto *parent = dynamic_cast<const multi_build_construction_activity_actor *>(
                             who.activity.actor.get() );
    REQUIRE( parent );
    CHECK( parent->query_for( who ).origin == origin );
    CHECK( who.backlog.empty() );
}

TEST_CASE( "vehicle_work_keeps_exact_vehicle_and_part_identity_across_save_and_removal",
           "[mp_inventory_activity][zone_work_owned][vehicle]" )
{
    vehicle_control_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    const tripoint_bub_ms position = who.pos_bub() + tripoint::south;
    const vpart_id &tank_type = vpart_tank_test;
    const auto create_vehicle = [&]() {
        vehicle *result = here.add_vehicle( vehicle_prototype_none, position, 0_degrees, 0,
                                            veh_spawn_status::UNDAMAGED );
        REQUIRE( result );
        result->set_owner( who.get_faction_id() );
        REQUIRE( result->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
        REQUIRE( result->install_part( here, point_rel_ms( 1, 0 ), vpart_frame ) >= 0 );
        REQUIRE( result->install_part( here, point_rel_ms::zero, tank_type ) >= 0 );
        REQUIRE( result->install_part( here, point_rel_ms( 1, 0 ), tank_type ) >= 0 );
        result->refresh();
        here.add_vehicle_to_cache( result );
        return result;
    };
    vehicle *target = create_vehicle();
    const int original_index = target->part_count() - 1;
    const int64_t original_part = target->part( original_index ).get_base().uid().get_value();
    item fuel( itype_gasoline, calendar::turn, 100 );
    item container( itype_test_watertight_open_sealed_container_1L );
    REQUIRE( container.fill_with( fuel, 100 ) == 100 );
    const item_location source = here.add_item_or_charges_ret_loc( who.pos_bub(), container );
    who.assign_activity( vehicle_activity_actor( VEHICLE_REFILL, 1_seconds, target,
                         target->abs_part_pos( original_index ), tripoint_rel_ms::zero, original_index,
                         tank_type, source ) );
    who.activity.set_execution( activity_execution::authoritative );
    save_reload_activity( who );
    bool should_refill = false;
    SECTION( "earlier_part_removed_and_indexes_compacted" ) {
        target->remove_part( target->part( original_index - 1 ) );
        target->part_removal_cleanup( here );
        should_refill = true;
    }
    SECTION( "selected_part_replaced_with_same_type" ) {
        target->remove_part( target->part( original_index ) );
        target->part_removal_cleanup( here );
        REQUIRE( target->install_part( here, point_rel_ms( 1, 0 ), tank_type ) >= 0 );
        target->refresh();
        here.add_vehicle_to_cache( target );
    }
    SECTION( "vehicle_replaced_at_same_position" ) {
        here.destroy_vehicle( target );
        target = create_vehicle();
    }
    auto *work = dynamic_cast<vehicle_activity_actor *>( who.activity.actor.get() );
    REQUIRE( work );
    const auto selected = work->target_part_index( *target );
    CHECK( selected.has_value() == should_refill );
    if( selected ) {
        CHECK( *selected != original_index );
        CHECK( target->part( *selected ).get_base().uid().get_value() == original_part );
    }
    work->complete_vehicle( who.activity, who );
    int stored_fuel = 0;
    for( const vpart_reference &part : target->get_all_parts() ) {
        if( part.part().info().id == tank_type ) {
            stored_fuel += part.part().ammo_remaining();
        }
    }
    CHECK( stored_fuel == ( should_refill ? 100 : 0 ) );
    REQUIRE( source );
    if( should_refill ) {
        CHECK( source->empty() );
    } else {
        CHECK_FALSE( who.activity );
        CHECK( source->only_item().charges == 100 );
    }
}

TEST_CASE( "vehicle_work_saved_operator_cannot_be_reassigned_to_another_player",
           "[mp_inventory_activity][zone_work_owned][vehicle]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    npc &other = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    bind_feedback_player( other, 'b', 702 );
    vehicle &target = owned_test_vehicle( who, tripoint_bub_ms( 60, 60, 0 ) );
    const int index = 0;
    who.assign_activity( vehicle_activity_actor( VEHICLE_REPAIR, 1_seconds, &target,
                         target.abs_part_pos( index ), tripoint_rel_ms::zero, index,
                         target.part( index ).info().id ) );
    who.activity.set_execution( activity_execution::authoritative );
    save_reload_activity( who );
    player_activity stolen = who.activity;
    other.assign_activity( stolen );
    CHECK_FALSE( other.activity );
    CHECK( who.activity.id() == ACT_VEHICLE );
}

TEST_CASE( "batch_butchery_skips_a_disappeared_corpse_before_initializing_it",
           "[mp_inventory_activity][zone_work_owned][butchery]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    item_location remaining = here.add_item_or_charges_ret_loc( who.pos_bub(),
                              item::make_corpse( mon_zombie, calendar::turn ) );
    item_location vanished = here.add_item_or_charges_ret_loc( who.pos_bub() + tripoint::east,
                             item::make_corpse( mon_zombie, calendar::turn ) );
    butchery_data continuing( remaining, butcher_type::QUICK );
    continuing.progress = 1_seconds;
    continuing.time_to_butcher = 10_seconds;
    std::vector<butchery_data> corpses{ continuing, butchery_data( vanished, butcher_type::QUICK ) };
    who.assign_activity( butchery_activity_actor( corpses ) );
    who.activity.set_execution( activity_execution::authoritative );
    vanished.remove_item();
    auto *actor = dynamic_cast<butchery_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    actor->do_turn( who.activity, who );
    REQUIRE( who.activity );
    CHECK( who.activity.moves_left == 1 );
    actor->do_turn( who.activity, who );
    CHECK( who.activity.moves_left == to_moves<int>( 8_seconds ) );
    CHECK( remaining );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "zone_item_claims_distinguish_same_named_players_and_survive_renaming",
           "[mp_inventory_activity][zone_work_owned]" )
{
    reload_fixture fixture;
    npc &first = fixture.remote();
    npc &second = fixture.remote();
    bind_feedback_player( first, 'a', 701 );
    bind_feedback_player( second, 'b', 702 );
    first.name = second.name = "Damon";
    map &here = get_map();
    const tripoint_bub_ms at = first.pos_bub() + tripoint::east;
    item_location corpse = here.add_item_or_charges_ret_loc( at,
                           item::make_corpse( mon_zombie, calendar::turn ) );
    activity_handlers::reserve_activity_item( first, corpse );
    multi_butchery_activity_actor planner;
    CHECK( planner.multi_activity_can_do( second, at ).reason == do_activity_reason::NO_COMPONENTS );
    CHECK( planner.multi_activity_can_do( first, at ).reason == do_activity_reason::NEEDS_BUTCHERING );
    std::ostringstream stream;
    JsonOut out( stream );
    corpse->serialize( out );
    item restored;
    restored.deserialize( json_loader::from_string( stream.str() ).get_object() );
    CHECK( activity_handlers::activity_item_owned_by( restored, first ) );
    CHECK_FALSE( activity_handlers::activity_item_owned_by( restored, second ) );
    first.name = "Renamed Damon";
    // A stale handle in someone else's cleanup list must not release this claim.
    second.may_activity_occupancy_after_end_items_loc.push_back( corpse );
    activity_handlers::clean_may_activity_occupancy_items_var( second );
    CHECK( activity_handlers::activity_item_owned_by( *corpse, first ) );
    activity_handlers::clean_may_activity_occupancy_items_var_if_is_avatar_and_no_activity_now( first );
    CHECK_FALSE( corpse->has_var( "activity_owner_id" ) );
    CHECK_FALSE( corpse->has_var( "activity_var" ) );
    CHECK( planner.multi_activity_can_do( second, at ).reason == do_activity_reason::NEEDS_BUTCHERING );
    // Compatibility with a legacy name-only save; re-reserving upgrades the mark.
    corpse->set_var( "activity_var", second.name );
    activity_handlers::reserve_activity_item( second, corpse );
    CHECK( corpse->has_var( "activity_owner_id" ) );
    CHECK( activity_handlers::activity_item_owned_by( *corpse, second ) );
}

TEST_CASE( "different_players_reserved_materials_do_not_merge_into_one_stack",
           "[mp_inventory_activity][zone_work_owned]" )
{
    reload_fixture fixture;
    npc &first = fixture.remote();
    npc &second = fixture.remote();
    first.name = second.name = "Damon";
    item first_material( itype_nail, calendar::turn, 20 );
    item second_material = first_material;
    activity_handlers::mark_activity_item( first_material, first );
    activity_handlers::mark_activity_item( second_material, second );
    map &here = get_map();
    const tripoint_bub_ms position = first.pos_bub() + tripoint::east;
    item_location first_stack = here.add_item_or_charges_ret_loc( position, first_material );
    item_location second_stack = here.add_item_or_charges_ret_loc( position, second_material );
    REQUIRE( first_stack );
    REQUIRE( second_stack );
    REQUIRE( here.i_at( position ).size() == 2 );
    CHECK( first_stack->charges == 20 );
    CHECK( second_stack->charges == 20 );
    activity_handlers::clear_activity_item( *first_stack );
    activity_handlers::clear_activity_item( *second_stack );
    CHECK( first_stack->stacks_with( *second_stack ) );
}

TEST_CASE( "remote_book_discovery_survives_save_and_authoritative_projection",
           "[multiplayer][mp_read_owned][reading]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    const item book( itype_test_textbook_fabrication );
    REQUIRE_FALSE( who.has_identified( book.typeId() ) );
    who.identify( book );
    REQUIRE( who.has_identified( book.typeId() ) );
    CHECK_FALSE( get_avatar().has_identified( book.typeId() ) );

    SECTION( "saved character retains discovery without relying on the NPC default" ) {
        std::ostringstream saved;
        JsonOut out( saved );
        who.serialize( out );
        npc restored;
        restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
        CHECK( restored.Character::has_identified( book.typeId() ) );
        CHECK_FALSE( restored.Character::has_identified( itype_child_book ) );
    }
    SECTION( "full player projection replaces stale local discovery" ) {
        get_avatar().identify( item( itype_child_book ) );
        std::ostringstream saved;
        JsonOut out( saved );
        who.store_player_state( out );
        const std::string before = capture_rng_state();
        get_avatar().load_player_state( json_loader::from_string( saved.str() ).get_object() );
        CHECK( get_avatar().has_identified( book.typeId() ) );
        CHECK_FALSE( get_avatar().has_identified( itype_child_book ) );
        CHECK( capture_rng_state() == before );
    }
    SECTION( "ordinary AI NPCs keep their existing book knowledge" ) {
        npc ai;
        CHECK( ai.has_identified( book.typeId() ) );
        ai.identify( book );
        CHECK_FALSE( ai.Character::has_identified( book.typeId() ) );
    }
}

TEST_CASE( "owned_reading_skims_then_learns_for_the_remote_player_only",
           "[multiplayer][mp_read_owned][reading]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    who.i_add( item( itype_test_lamp ) );
    item_location book = who.i_add( item( itype_test_textbook_fabrication ) );
    const skill_id &skill = skill_fabrication;
    who.set_knowledge_level( skill, 0 );
    const int host_level = get_avatar().get_knowledge_level( skill );
    const auto start = [&]() {
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
            out.member( "kind", "read" );
            out.member( "book", cata_mp::capture_item_source( who, book ) );
        } ) );
        REQUIRE( who.activity.id() == ACT_READ );
        REQUIRE( cata_mp::owns_inventory_activity( who ) );
    };
    start();
    who.activity.actor->finish( who.activity, who );
    CHECK_FALSE( who.activity );
    CHECK( who.has_identified( book->typeId() ) );
    CHECK( who.get_knowledge_level( skill ) == 0 );
    CHECK_FALSE( get_avatar().has_identified( book->typeId() ) );

    const int before = who.get_skill_level_object( skill ).knowledgeExperience();
    start();
    who.activity.actor->finish( who.activity, who );
    CHECK_FALSE( who.activity );
    CHECK( ( who.get_knowledge_level( skill ) > 0 ||
             who.get_skill_level_object( skill ).knowledgeExperience() > before ) );
    CHECK( get_avatar().get_knowledge_level( skill ) == host_level );

    std::ostringstream knowledge;
    JsonOut out( knowledge );
    who.store_practice_state( out, true );
    const std::string rng = capture_rng_state();
    get_avatar().load_practice_state( json_loader::from_string( knowledge.str() ).get_object() );
    CHECK( get_avatar().has_identified( book->typeId() ) );
    CHECK( get_avatar().book_chapters == who.book_chapters );
    CHECK( get_avatar().get_skill_level_object( skill ).knowledgeExperience() ==
           who.get_skill_level_object( skill ).knowledgeExperience() );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "owned_reading_rejects_stale_sources_and_unrelated_learners",
           "[multiplayer][mp_read_owned][reading]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    who.i_add( item( itype_test_lamp ) );
    item_location book = who.i_add( item( itype_test_textbook_fabrication ) );
    who.identify( *book );
    const item_source source = cata_mp::capture_item_source( who, book );
    bool continuous = false;
    SECTION( "book removed after selection" ) {
        book.remove_item();
    }
    SECTION( "book reserved by another player" ) {
        activity_handlers::mark_activity_item( *book, get_avatar() );
    }
    SECTION( "selected learner is not participating" ) {
        continuous = true;
    }
    const std::string before = capture_rng_state();
    const int moves = who.get_moves();
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut & out ) {
        out.member( "kind", "read" );
        out.member( "book", source );
        out.member( "continuous", continuous );
        out.member( "learner", -99 );
    } ) );
    CHECK_FALSE( who.activity );
    CHECK( who.get_moves() == moves );
    CHECK( capture_rng_state() == before );
}

TEST_CASE( "read_completion_stops_when_a_read_event_removes_the_book",
           "[multiplayer][mp_read_owned][reading]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    item_location book = who.i_add( item( itype_test_textbook_fabrication ) );
    const itype_id id = book->typeId();
    item_location ereader;
    who.assign_activity( read_activity_actor( 1_minutes, book, ereader ) );
    REQUIRE( who.activity );
    class remove_book_on_read : public event_subscriber {
        public:
            item_location target;
            character_id owner;
            remove_book_on_read( item_location target, character_id owner ) : target( std::move( target ) ), owner( owner ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::reads_book &&
                    event.get<character_id>( "character" ) == owner && target ) {
                    target.remove_item();
                }
            }
    } remove( book, who.getID() );
    who.activity.actor->finish( who.activity, who );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( who.has_identified( id ) );
    CHECK_FALSE( get_avatar().has_identified( id ) );
}

TEST_CASE( "study_preferences_keep_same_named_players_separate_after_rename_and_save",
           "[zone_work_owned][mp_read_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    npc &other = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    bind_feedback_player( other, 'b', 702 );
    who.name = other.name = "Reader";
    study_zone_options options;
    options.deserialize( json_loader::from_string(
                             R"({"npc_skill_preferences":{"Reader":["cooking"]}})" ).get_object() );
    REQUIRE( options.get_skill_preferences( who ) );
    CHECK( options.get_skill_preferences( who )->count( skill_cooking ) == 1 );
    options.set_skill_preferences( who, { skill_fabrication } );
    options.set_skill_preferences( other, {} );
    who.name = "Renamed reader";
    std::ostringstream stream;
    JsonOut out( stream );
    out.start_object();
    options.serialize( out );
    out.end_object();
    study_zone_options restored;
    restored.deserialize( json_loader::from_string( stream.str() ).get_object() );
    REQUIRE( restored.get_skill_preferences( who ) );
    CHECK( *restored.get_skill_preferences( who ) == std::set<skill_id>{ skill_fabrication } );
    REQUIRE( restored.get_skill_preferences( other ) );
    CHECK( restored.get_skill_preferences( other )->empty() );
}

TEST_CASE( "owned_study_rechecks_preferences_and_zone_before_starting_a_child",
           "[zone_work_owned][mp_read_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    who.i_add( item( itype_test_lamp ) );
    map &here = get_map();
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    auto options = make_shared_fast<study_zone_options>();
    options->set_skill_preferences( who, { skill_fabrication } );
    const tripoint_abs_ms position = who.pos_abs();
    REQUIRE( manager.add( "Study", zone_type_STUDY_ZONE, who.get_faction_id(), false, true,
                          position, position, options, true, nullptr, false ) );
    const item_location book = here.add_item_or_charges_ret_loc( who.pos_bub(),
                               item( itype_test_textbook_fabrication ) );
    REQUIRE( start_owned_zone_work( who, "study" ) );
    auto *planner = dynamic_cast<multi_study_activity_actor *>( who.activity.actor.get() );
    REQUIRE( planner );
    const activity_reason_info reason = planner->multi_activity_can_do( who, who.pos_bub() );
    REQUIRE( reason.reason == do_activity_reason::NEEDS_BOOK_TO_LEARN );
    bool start_child = true;
    SECTION( "native child keeps authority and original work order" ) {}
    SECTION( "zone disabled after selection" ) {
        manager.get_zones( who.get_faction_id() ).front().get().set_enabled( false );
        start_child = false;
    }
    SECTION( "skill deselected after selection" ) {
        options->set_skill_preferences( who, {} );
        start_child = false;
    }
    CHECK( planner->multi_activity_do( who, reason, position, who.pos_bub() ) == !start_child );
    if( start_child ) {
        REQUIRE( who.activity.id() == ACT_READ );
        CHECK( who.activity.execution() == activity_execution::authoritative );
        REQUIRE_FALSE( who.backlog.empty() );
        CHECK( who.backlog.front().id() == ACT_MULTIPLE_STUDY );
        who.activity.actor->finish( who.activity, who );
        CHECK( who.has_identified( book->typeId() ) );
        CHECK_FALSE( get_avatar().has_identified( book->typeId() ) );
    } else {
        CHECK( who.activity.id() == ACT_MULTIPLE_STUDY );
        CHECK_FALSE( who.has_identified( book->typeId() ) );
    }
}

TEST_CASE( "automatic_study_uses_the_selected_ebook_reader_battery",
           "[zone_work_owned][mp_read_owned][reading]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    who.i_add( item( itype_test_lamp ) );
    zone_manager &manager = zone_manager::get_manager();
    manager.clear();
    const on_out_of_scope cleanup( [&]() { manager.clear(); } );
    auto options = make_shared_fast<study_zone_options>();
    const tripoint_abs_ms position = who.pos_abs();
    REQUIRE( manager.add( "Study", zone_type_STUDY_ZONE, who.get_faction_id(), false, true,
                          position, position, options, true, nullptr, false ) );
    item device( itype_test_ebook_reader );
    item battery( itype_test_battery_disposable );
    battery.ammo_set( battery.ammo_default(), 100 );
    REQUIRE( device.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    REQUIRE( device.put_in( item( itype_test_textbook_fabrication ),
                            pocket_type::E_FILE_STORAGE ).success() );
    const item_location ereader = get_map().add_item_or_charges_ret_loc( who.pos_bub(), device );
    REQUIRE( start_owned_zone_work( who, "study" ) );
    auto *planner = dynamic_cast<multi_study_activity_actor *>( who.activity.actor.get() );
    REQUIRE( planner );
    const activity_reason_info reason = planner->multi_activity_can_do( who, who.pos_bub() );
    REQUIRE( reason.reason == do_activity_reason::NEEDS_BOOK_TO_LEARN );
    REQUIRE_FALSE( planner->multi_activity_do( who, reason, position, who.pos_bub() ) );
    REQUIRE( who.activity.id() == ACT_READ );
    CHECK( ereader->ammo_remaining() == 99 );
    who.activity.actor->finish( who.activity, who );
    CHECK( who.has_identified( itype_test_textbook_fabrication ) );
}

TEST_CASE( "zone_item_movement_cost_uses_the_operator_capacity",
           "[zone_work_owned][multiplayer]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    const item load( itype_rock );
    const tripoint_bub_ms source = who.pos_bub();
    const tripoint_bub_ms destination = source + tripoint( 5, 0, 0 );
    const int empty_capacity = activity_handlers::move_cost( who, load, source, destination );
    get_avatar().worn.wear_item( get_avatar(), item( itype_backpack ), false, false );
    CHECK( activity_handlers::move_cost( who, load, source, destination ) == empty_capacity );
    who.worn.wear_item( who, item( itype_backpack ), false, false );
    CHECK( activity_handlers::move_cost( who, load, source, destination ) < empty_capacity );
}

TEST_CASE( "grab_state_belongs_to_the_character_and_survives_save_and_projection",
           "[multiplayer][grab_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    who.grab( object_type::VEHICLE, tripoint_rel_ms::east );
    REQUIRE( who.get_grab_type() == object_type::VEHICLE );
    CHECK( who.grab_point == tripoint_rel_ms::east );
    CHECK( get_avatar().get_grab_type() == object_type::NONE );
    const std::string mode = GENERATE( "save", "player_state", "turn_state" );
    std::ostringstream stream;
    JsonOut out( stream );
    if( mode == "save" ) {
        who.serialize( out );
        npc restored;
        restored.deserialize( json_loader::from_string( stream.str() ).get_object() );
        CHECK( restored.get_grab_type() == object_type::VEHICLE );
        CHECK( restored.grab_point == tripoint_rel_ms::east );
    } else {
        if( mode == "player_state" ) {
            who.store_player_state( out );
        } else {
            who.store_turn_state( out );
        }
        const std::string rng = capture_rng_state();
        const JsonObject state = json_loader::from_string( stream.str() ).get_object();
        if( mode == "player_state" ) {
            get_avatar().load_player_state( state );
        } else {
            get_avatar().load_turn_state( state );
        }
        CHECK( get_avatar().get_grab_type() == object_type::VEHICLE );
        CHECK( get_avatar().grab_point == tripoint_rel_ms::east );
        CHECK( capture_rng_state() == rng );
    }
    who.grab( object_type::NONE );
    CHECK( who.grab_point == tripoint_rel_ms::zero );
}

TEST_CASE( "native_hauling_setup_and_completion_use_the_operator",
           "[multiplayer][hauling][grab_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms source = who.pos_bub();
    item_location load = here.add_item_or_charges_ret_loc( source, item( itype_test_rock ) );
    who.start_hauling( { load } );
    who.setpos( here, source + tripoint::east );
    who.activity.set_execution( activity_execution::authoritative );
    g->start_hauling( who, source );
    REQUIRE( who.activity.id() == ACT_MOVE_ITEMS );
    CHECK( who.activity.execution() == activity_execution::authoritative );
    CHECK_FALSE( get_avatar().activity );
    CHECK_FALSE( get_avatar().is_hauling() );
    who.set_moves( 100000 );
    who.activity.actor->do_turn( who.activity, who );
    CHECK_FALSE( who.activity );
    CHECK( here.get_haulable_items( source ).empty() );
    REQUIRE( who.haul_list.size() == 1 );
    CHECK( who.haul_list.front().pos_bub( here ) == who.pos_bub() );
}

TEST_CASE( "hauling_rejects_foreign_sources_and_reassigned_jobs",
           "[multiplayer][hauling][grab_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    npc &other = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    bind_feedback_player( other, 'b', 702 );
    map &here = get_map();
    const tripoint_bub_ms source = who.pos_bub() + tripoint::west;
    item_location load = here.add_item_or_charges_ret_loc( source, item( itype_test_rock ) );
    SECTION( "another character carries the selected item" ) {
        other.set_wielded_item( item( itype_test_rock ) );
        load = other.get_wielded_item();
    }
    SECTION( "another player reserved the ground item" ) {
        activity_handlers::mark_activity_item( *load, other );
    }
    SECTION( "serialized job assigned to a different operator" ) {
        who.assign_activity( move_items_activity_actor( { load }, { 0 }, false,
                             tripoint_rel_ms::zero, true ) );
        who.set_moves( 0 );
        who.activity.actor->do_turn( who.activity, who );
        save_reload_activity( who );
        other.activity = who.activity;
        other.set_moves( 100000 );
        other.activity.actor->do_turn( other.activity, other );
        CHECK_FALSE( other.activity );
        CHECK( load );
        CHECK( here.get_haulable_items( source ).size() == 1 );
        return;
    }
    who.assign_activity( move_items_activity_actor( { load }, { 0 }, false,
                         tripoint_rel_ms::zero, true ) );
    who.set_moves( 100000 );
    who.activity.actor->do_turn( who.activity, who );
    CHECK_FALSE( who.activity );
    CHECK( load );
    CHECK( who.haul_list.empty() );
}

TEST_CASE( "grab_commands_resolve_the_selected_object_on_the_authority",
           "[mp_inventory_activity][grab_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().grab( object_type::NONE );
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.furn_set( target, furn_f_chair );
    const auto choice = query_grab( who, here, target );
    REQUIRE( choice );
    CHECK( who.get_grab_type() == object_type::NONE );
    const std::string wire = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "grab" );
        out.member( "grab", *choice );
    } );
    bool accepted = false;
    bool authorized = true;
    SECTION( "current adjacent furniture" ) { accepted = true; }
    SECTION( "target changed while choosing" ) { here.furn_set( target, furn_f_crate_o ); }
    SECTION( "operator walked away" ) { who.setpos( here, who.pos_bub() + tripoint( -3, 0, 0 ) ); }
    SECTION( "unowned connection" ) { authorized = false; }
    fixture.run( who, wire, authorized );
    CHECK( ( who.get_grab_type() == object_type::FURNITURE ) == accepted );
    CHECK( get_avatar().get_grab_type() == object_type::NONE );
    if( accepted ) {
        who.grab( object_type::NONE );
        fixture.run( who, wire );
        CHECK( who.get_grab_type() == object_type::NONE );
    }
}

TEST_CASE( "grab_vehicle_choice_rejects_replacement_at_the_same_tile",
           "[mp_inventory_activity][grab_owned][vehicle]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    const auto create = [&]() {
        vehicle *veh = here.add_vehicle( vehicle_prototype_none, target, 0_degrees, 0,
                                         veh_spawn_status::UNDAMAGED );
        REQUIRE( veh );
        veh->set_owner( who.get_faction_id() );
        REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
        veh->refresh();
        here.add_vehicle_to_cache( veh );
        return veh;
    };
    vehicle *veh = create();
    auto choice = query_grab( who, here, target );
    REQUIRE( choice );
    bool accepted = false;
    SECTION( "unchanged part" ) { accepted = true; }
    SECTION( "another vehicle with identical parts" ) {
        here.destroy_vehicle( veh );
        veh = create();
    }
    SECTION( "another part ID" ) { ++choice->part_id; }
    CHECK( execute_grab( who, here, *choice ) == accepted );
    CHECK( ( who.get_grab_type() == object_type::VEHICLE ) == accepted );
    CHECK( here.veh_at( target ) );
}

TEST_CASE( "native_furniture_drag_uses_operator_strength_and_moves_container_contents",
           "[grab_owned][multiplayer]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    host.set_str_base( 1 );
    host.grab( object_type::VEHICLE, tripoint_rel_ms::north );
    const int host_moves = host.get_moves();
    who.set_str_base( 50 );
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.furn_set( target, furn_f_crate_o );
    here.add_item_or_charges( target, item( itype_test_rock ) );
    who.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    REQUIRE( g->can_move_furniture( who, who.pos_bub(), tripoint_rel_ms::west ) );
    const int cost = g->grabbed_furn_move_time( who, tripoint_rel_ms::west );
    host.set_str_base( 50 );
    CHECK( g->grabbed_furn_move_time( who, tripoint_rel_ms::west ) == cost );
    REQUIRE_FALSE( g->grabbed_furn_move( who, tripoint_rel_ms::west ) );
    CHECK( here.furn( who.pos_bub() ) == furn_f_crate_o );
    CHECK_FALSE( here.has_furn( target ) );
    CHECK( here.i_at( target ).empty() );
    REQUIRE( here.i_at( who.pos_bub() ).size() == 1 );
    CHECK( here.i_at( who.pos_bub() ).begin()->typeId() == itype_test_rock );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
    CHECK( host.get_moves() == host_moves );
    CHECK( host.grab_point == tripoint_rel_ms::north );
    CHECK( host.get_grab_type() == object_type::VEHICLE );
}

TEST_CASE( "furniture_drag_cannot_push_into_another_player",
           "[grab_owned][multiplayer]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.furn_set( target, furn_f_chair );
    who.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    get_avatar().setpos( here, target + tripoint::east );
    CHECK_FALSE( g->can_move_furniture( who, target + tripoint::east, tripoint_rel_ms::east ) );
}

TEST_CASE( "hauling_selection_splits_only_on_authority_and_rejects_stale_or_duplicate_sources",
           "[mp_inventory_activity][grab_owned][hauling]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms position = who.pos_bub();
    item_location load = here.add_item_or_charges_ret_loc( position,
                         item( itype_nail, calendar::turn, 100 ) );
    hauling_selection choice;
    choice.action = "select";
    choice.position = who.pos_abs();
    choice.items.push_back( { capture_item_source( who, load ), 25 } );
    CHECK( load->charges == 100 );
    CHECK_FALSE( who.is_hauling() );
    bool accepted = false;
    SECTION( "partial ground stack" ) { accepted = true; }
    SECTION( "same source twice" ) { choice.items.push_back( choice.items.front() ); }
    SECTION( "more than available" ) { choice.items.front().quantity = 101; }
    SECTION( "another player reserved it" ) {
        activity_handlers::mark_activity_item( *load, get_avatar() );
    }
    SECTION( "source is now carried" ) {
        who.set_wielded_item( *load );
        load.remove_item();
        load = who.get_wielded_item();
    }
    const std::string wire = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "haul" );
        out.member( "haul", choice );
    } );
    fixture.run( who, wire );
    CHECK( who.is_hauling() == accepted );
    CHECK( load->charges == ( accepted ? 75 : 100 ) );
    if( accepted ) {
        REQUIRE( who.haul_list.size() == 1 );
        CHECK( who.haul_list.front()->charges == 25 );
        CHECK( who.suppress_autohaul );
        CHECK( here.i_at( position ).size() == 2 );
        fixture.run( who, wire );
        CHECK( load->charges == 75 );
        CHECK( here.i_at( position ).size() == 2 );
    } else {
        CHECK( who.haul_list.empty() );
    }
}

TEST_CASE( "hauling_preferences_and_turn_projection_do_not_toggle_native_gameplay",
           "[mp_inventory_activity][grab_owned][hauling]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().stop_hauling();
    get_avatar().setpos( here, who.pos_bub() );
    const item_location load = here.add_item_or_charges_ret_loc( who.pos_bub(),
                               item( itype_test_rock ) );
    hauling_selection choice;
    choice.position = who.pos_abs();
    choice.action = "all";
    choice.enable_autohaul = true;
    REQUIRE( execute_hauling( who, here, choice ) );
    choice.action = "filter";
    choice.filter = "rock";
    REQUIRE( execute_hauling( who, here, choice ) );
    const item_location extra = here.add_item_or_charges_ret_loc( who.pos_bub(),
                                item( itype_nail, calendar::turn, 100 ) );
    std::ostringstream stream;
    JsonOut out( stream );
    who.store_turn_state( out );
    const std::string rng = capture_rng_state();
    get_avatar().load_turn_state( json_loader::from_string( stream.str() ).get_object() );
    CHECK( capture_rng_state() == rng );
    CHECK( get_avatar().is_hauling() );
    CHECK( get_avatar().is_autohauling() );
    CHECK( get_avatar().hauling_filter == "rock" );
    REQUIRE( get_avatar().haul_list.size() == 1 );
    CHECK( get_avatar().haul_list.front() == load );
    CHECK( extra->charges == 100 );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "native_vehicle_drag_bills_and_moves_the_actual_operator_object",
           "[grab_owned][multiplayer][vehicle]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    host.grab( object_type::NONE );
    host.set_str_base( 1 );
    who.set_str_base( 50 );
    const int host_moves = host.get_moves();
    const tripoint_bub_ms position = who.pos_bub() + tripoint::east;
    vehicle *target = here.add_vehicle( vehicle_prototype_none, position, 0_degrees, 0,
                                        veh_spawn_status::UNDAMAGED );
    REQUIRE( target );
    target->set_owner( who.get_faction_id() );
    REQUIRE( target->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
    target->refresh();
    here.add_vehicle_to_cache( target );
    const int64_t identity = target->uid().get_value();
    const auto choice = query_grab( who, here, position );
    REQUIRE( choice );
    REQUIRE( execute_grab( who, here, *choice ) );
    const int moves = who.get_moves();
    REQUIRE_FALSE( grabbed_vehicle_test_access::move( *g, who, tripoint_rel_ms::west ) );
    target = vehicle::find_vehicle_by_uid( here, identity );
    REQUIRE( target );
    CHECK( target->pos_bub( here ) == position + tripoint::west );
    CHECK( who.get_moves() < moves );
    CHECK( host.get_moves() == host_moves );
    CHECK( host.get_grab_type() == object_type::NONE );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
}

TEST_CASE( "continued_vehicle_drag_keeps_the_saved_vehicle_and_part_identity",
           "[grab_owned][multiplayer][vehicle]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    who.set_str_base( 50 );
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    const auto create = [&]() {
        vehicle *veh = here.add_vehicle( vehicle_prototype_none, target, 0_degrees, 0,
                                         veh_spawn_status::UNDAMAGED );
        REQUIRE( veh );
        veh->set_owner( who.get_faction_id() );
        REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
        veh->refresh();
        here.add_vehicle_to_cache( veh );
        return veh;
    };
    vehicle *veh = create();
    who.grab( object_type::VEHICLE, tripoint_rel_ms::east );
    REQUIRE( who.validate_grab( here ) );
    const uint64_t generation = who.grab_generation();
    const int held_part = who.grabbed_vehicle_part( here );
    REQUIRE( held_part >= 0 );
    std::ostringstream stream;
    JsonOut out( stream );
    who.store_turn_state( out );
    std::ostringstream saved;
    JsonOut save_out( saved );
    who.serialize( save_out );
    bool unchanged = false;
    SECTION( "the same saved handhold" ) { unchanged = true; }
    SECTION( "a replacement vehicle at the same point" ) {
        here.destroy_vehicle( veh );
        veh = create();
    }
    SECTION( "a replacement part on the same vehicle" ) {
        veh->part( held_part ).set_base( item( veh->part( held_part ).info().base_item ) );
    }
    SECTION( "the removed part is still waiting for cache cleanup" ) {
        veh->part( held_part ).removed = true;
    }
    npc restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    CHECK( restored.grab_generation() == generation );
    CHECK( restored.validate_grab( here ) == unchanged );
    const std::string rng = capture_rng_state();
    who.load_turn_state( json_loader::from_string( stream.str() ).get_object() );
    CHECK( capture_rng_state() == rng );
    CHECK( who.grab_generation() == generation );
    CHECK( who.validate_grab( here ) == unchanged );
    const int moves = who.get_moves();
    REQUIRE_FALSE( grabbed_vehicle_test_access::move( *g, who, tripoint_rel_ms::west ) );
    if( unchanged ) {
        CHECK( veh->pos_bub( here ) == target + tripoint::west );
        who.setpos( here, who.pos_bub() + tripoint::west );
        CHECK( who.validate_grab( here ) );
    } else {
        CHECK( veh->pos_bub( here ) == target );
        CHECK( who.get_grab_type() == object_type::NONE );
        CHECK( who.get_moves() == moves );
        CHECK( capture_rng_state() == rng );
    }
}

TEST_CASE( "moving_shared_furniture_invalidates_other_players_old_hold",
           "[grab_owned][multiplayer][walking_owned]" )
{
    reload_fixture fixture;
    npc &first = fixture.remote();
    bind_feedback_player( first, 'a', 701 );
    npc &second = fixture.remote();
    bind_feedback_player( second, 'b', 702 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms target( 62, 60, 0 );
    first.setpos( here, target + tripoint::west );
    second.setpos( here, target + tripoint::north );
    first.set_str_base( 50 );
    second.set_str_base( 50 );
    here.furn_set( target, furn_f_chair );
    first.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    second.grab( object_type::FURNITURE, tripoint_rel_ms::south );
    first.assign_activity( move_furniture_activity_actor( tripoint_rel_ms::east, false,
                           walk_move_choices{} ) );
    second.assign_activity( move_furniture_activity_actor( tripoint_rel_ms::south, false,
                            walk_move_choices{} ) );
    REQUIRE( first.activity );
    REQUIRE( second.activity );
    save_reload_activity( second );
    first.activity.actor->finish( first.activity, first );
    REQUIRE( here.furn( target + tripoint::east ) == furn_f_chair );
    REQUIRE( first.pos_bub() == target );
    REQUIRE( first.validate_grab( here ) );
    // Another chair arriving at the original cell must not revive the old job.
    here.furn_set( target, furn_f_chair );
    CHECK_FALSE( second.validate_grab( here ) );
    const std::string rng = capture_rng_state();
    second.activity.actor->finish( second.activity, second );
    CHECK_FALSE( second.activity );
    CHECK( second.get_grab_type() == object_type::NONE );
    CHECK( second.pos_bub() == target + tripoint::north );
    CHECK( here.furn( target ) == furn_f_chair );
    CHECK_FALSE( here.has_furn( target + tripoint::south ) );
    CHECK( first.validate_grab( here ) );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "saved_furniture_activity_does_not_take_over_a_new_grab",
           "[grab_owned][multiplayer][walking_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms target = origin + tripoint::east;
    here.furn_set( target, furn_f_chair );
    who.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    who.assign_activity( move_furniture_activity_actor( tripoint_rel_ms::east, false ) );
    save_reload_activity( who );
    player_activity stale = who.activity;
    who.cancel_activity();
    who.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    const uint64_t generation = who.grab_generation();
    who.activity = std::move( stale );
    const std::string rng = capture_rng_state();
    who.activity.actor->finish( who.activity, who );
    CHECK_FALSE( who.activity );
    CHECK( who.pos_bub() == origin );
    CHECK( who.grab_generation() == generation );
    CHECK( who.validate_grab( here ) );
    CHECK( here.furn( target ) == furn_f_chair );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "shared_native_walk_moves_and_bills_only_its_operator",
           "[multiplayer][walking_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    host.grab( object_type::NONE );
    who.grab( object_type::NONE );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms destination = origin + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( destination, ter_id( "t_floor" ) );
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    const int host_moves = host.get_moves();
    const int host_stamina = host.get_stamina();
    who.set_moves( 1000 );
    const int expected_cost = who.run_cost( here.combined_movecost( origin, destination ), false );
    const walk_move_choices choices;
    REQUIRE( g->walk_move( who, destination, false, false, &choices ) );
    CHECK( who.pos_bub() == destination );
    CHECK( who.get_moves() == 1000 - expected_cost );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
    CHECK( host.get_moves() == host_moves );
    CHECK( host.get_stamina() == host_stamina );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "owned_furniture_finish_preserves_the_next_hauling_activity",
           "[multiplayer][walking_owned][grab_owned][hauling]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    get_avatar().grab( object_type::NONE );
    who.set_str_base( 50 );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms destination = origin + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( destination, ter_id( "t_floor" ) );
    here.ter_set( destination + tripoint::east, ter_id( "t_floor" ) );
    here.furn_set( destination, furn_f_chair );
    const item_location load = here.add_item_or_charges_ret_loc( origin, item( itype_test_rock ) );
    who.start_hauling( { load } );
    who.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    who.activity.set_execution( activity_execution::authoritative );
    const walk_move_choices choices;
    REQUIRE( g->walk_move( who, destination, false, false, &choices ) );
    REQUIRE( who.activity.id() == ACT_FURNITURE_MOVE );
    CHECK( who.pos_bub() == origin );
    save_reload_activity( who );
    who.activity.actor->finish( who.activity, who );
    CHECK( who.pos_bub() == destination );
    CHECK( here.furn( destination + tripoint::east ) == furn_f_chair );
    REQUIRE( who.activity.id() == ACT_MOVE_ITEMS );
    CHECK( who.activity.execution() == activity_execution::authoritative );
    who.set_moves( 100000 );
    who.activity.actor->do_turn( who.activity, who );
    CHECK( here.i_at( origin ).empty() );
    REQUIRE( here.i_at( destination ).size() == 1 );
    CHECK( here.i_at( destination ).begin()->typeId() == itype_test_rock );
    CHECK_FALSE( get_avatar().activity );
    CHECK( get_avatar().pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
}

TEST_CASE( "furniture_activity_rejects_reassignment_and_replaced_target_after_reload",
           "[multiplayer][walking_owned][grab_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    host.grab( object_type::VEHICLE, tripoint_rel_ms::north );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms target = origin + tripoint::east;
    here.furn_set( target, furn_f_chair );
    who.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    who.assign_activity( move_furniture_activity_actor( tripoint_rel_ms::east, false ) );
    save_reload_activity( who );
    SECTION( "another body receives the saved job" ) {
        npc &other = fixture.remote();
        bind_feedback_player( other, 'b', 702 );
        other.grab( object_type::FURNITURE, tripoint_rel_ms::east );
        other.activity = who.activity;
        other.activity.actor->finish( other.activity, other );
        CHECK_FALSE( other.activity );
        CHECK( other.pos_bub() == origin );
        CHECK( here.furn( target ) == furn_f_chair );
    }
    SECTION( "the furniture was replaced" ) {
        here.furn_set( target, furn_f_crate_o );
        who.activity.actor->finish( who.activity, who );
        CHECK_FALSE( who.activity );
        CHECK( who.pos_bub() == origin );
        CHECK( here.furn( target ) == furn_f_crate_o );
    }
    SECTION( "cancel belongs to the operator" ) {
        who.cancel_activity();
        CHECK( who.get_grab_type() == object_type::NONE );
    }
    CHECK( host.get_grab_type() == object_type::VEHICLE );
    CHECK( host.grab_point == tripoint_rel_ms::north );
}

TEST_CASE( "vehicle_loaded_furniture_uses_the_same_saved_activity_and_operator",
           "[multiplayer][walking_owned][grab_owned][vehicle]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms target = origin + tripoint::east;
    const tripoint_bub_ms destination = target + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( target, ter_id( "t_floor" ) );
    here.ter_set( destination, ter_id( "t_floor" ) );
    vehicle *veh = here.add_vehicle( vehicle_prototype_none, target, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    veh->set_owner( who.get_faction_id() );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
    const int part = veh->install_part( here, point_rel_ms::zero, vpart_trunk );
    REQUIRE( part >= 0 );
    item base = veh->part( part ).get_base();
    base.set_var( "tied_down_furniture", "f_chair" );
    veh->part( part ).set_base( std::move( base ) );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    who.set_str_base( 50 );
    who.grab( object_type::FURNITURE_ON_VEHICLE, tripoint_rel_ms::east );
    who.assign_activity( move_furniture_activity_actor( tripoint_rel_ms::east, false,
                         walk_move_choices{} ) );
    REQUIRE( who.activity );
    save_reload_activity( who );
    who.activity.actor->finish( who.activity, who );
    CHECK( who.pos_bub() == target );
    CHECK( here.furn( destination ) == furn_f_chair );
    CHECK_FALSE( veh->part( part ).get_base().has_var( "tied_down_furniture" ) );
    CHECK( who.get_grab_type() == object_type::FURNITURE );
    CHECK( who.validate_grab( here ) );
    CHECK( get_avatar().pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
}

TEST_CASE( "furniture_hold_follows_loading_and_unloading_across_consecutive_steps",
           "[multiplayer][walking_owned][grab_owned][vehicle]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    who.set_str_base( 50 );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms target = origin + tripoint::east;
    const tripoint_bub_ms deck = target + tripoint::east;
    for( int x = 0; x < 4; ++x ) {
        here.ter_set( origin + tripoint( x, 0, 0 ), ter_id( "t_floor" ) );
    }
    vehicle *veh = here.add_vehicle( vehicle_prototype_none, deck, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    veh->set_owner( who.get_faction_id() );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
    const int trunk = veh->install_part( here, point_rel_ms::zero, vpart_trunk );
    REQUIRE( trunk >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    here.furn_set( target, furn_f_chair );
    who.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    who.assign_activity( move_furniture_activity_actor( tripoint_rel_ms::east, false,
                         walk_move_choices{} ) );
    REQUIRE( who.activity );
    who.activity.actor->finish( who.activity, who );
    REQUIRE( who.pos_bub() == target );
    REQUIRE( who.get_grab_type() == object_type::FURNITURE_ON_VEHICLE );
    REQUIRE( who.validate_grab( here ) );
    CHECK( veh->part( trunk ).get_base().get_var( "tied_down_furniture" ) == "f_chair" );
    who.assign_activity( move_furniture_activity_actor( tripoint_rel_ms::east, false,
                         walk_move_choices{} ) );
    REQUIRE( who.activity );
    save_reload_activity( who );
    who.activity.actor->finish( who.activity, who );
    CHECK( who.pos_bub() == deck );
    CHECK( who.get_grab_type() == object_type::FURNITURE );
    CHECK( who.validate_grab( here ) );
    CHECK( here.furn( deck + tripoint::east ) == furn_f_chair );
    CHECK_FALSE( veh->part( trunk ).get_base().has_var( "tied_down_furniture" ) );
}

TEST_CASE( "walking_hazard_queries_and_consent_belong_to_the_operator",
           "[multiplayer][walking_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    host.add_effect( effect_blind, 1_hours );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms destination = origin + tripoint::east;
    here.add_field( destination, field_type_id( "fd_fire" ), 3 );
    REQUIRE( host.is_blind() );
    CHECK( g->get_dangerous_tile( host, destination ).empty() );
    REQUIRE_FALSE( g->get_dangerous_tile( who, destination ).empty() );
    const int moves = who.get_moves();
    walk_move_choices choices;
    REQUIRE_FALSE( g->walk_move( who, destination, false, false, &choices ) );
    CHECK( who.pos_bub() == origin );
    CHECK( who.get_moves() == moves );
    choices.allow_danger = true;
    REQUIRE( g->walk_move( who, destination, false, false, &choices ) );
    CHECK( who.pos_bub() == destination );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
}

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
TEST_CASE( "shared_walking_hooks_bind_the_operator_and_revalidate_hook_mutations",
           "[multiplayer][walking_owned][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    reload_fixture fixture;
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::string mod = "owned_walking_hook";
    const auto runtime = platform::make_runtime( mod, 4111, lua );
    const on_out_of_scope cleanup( []() { platform::shutdown(); } );
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );
    lua["ccb"] = ccb;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms destination = origin + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( destination, ter_id( "t_floor" ) );
    const bool replace_destination = GENERATE( false, true );
    lua.set_function( "mutate_destination", [&]() {
        if( replace_destination ) {
            here.ter_set( destination, ter_id( "t_wall" ) );
        }
    } );
    const sol::protected_function_result registered = lua.safe_script( R"lua(
ccb.runtime.handler("move_player", function(context)
    local state = ccb.state.character
    state.set("player_moves", state.get("player_moves", 0) + 1)
    mutate_destination()
    return true
end)
ccb.runtime.handler("move_character", function(context)
    local state = ccb.state.character
    state.set("character_moves", state.get("character_moves", 0) + 1)
    return true
end)
ccb.runtime.hook("on_player_try_move", "move_player")
ccb.runtime.hook("on_character_try_move", "move_character")
)lua", sol::script_pass_on_error );
    REQUIRE( registered.valid() );
    const walk_move_choices choices;
    CHECK( g->walk_move( who, destination, false, false, &choices ) == !replace_destination );
    CHECK( who.pos_bub() == ( replace_destination ? origin : destination ) );
    const cata::lua_platform::script_persistent_state &values = who.lua_character_state.for_mod( mod );
    REQUIRE( values.count( "player_moves" ) == 1 );
    REQUIRE( values.count( "character_moves" ) == 1 );
    CHECK( std::get<int64_t>( values.at( "player_moves" ) ) == 1 );
    CHECK( std::get<int64_t>( values.at( "character_moves" ) ) == 1 );
    CHECK( host.lua_character_state.for_mod( mod ).empty() );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
}
#endif

TEST_CASE( "walking_intents_validate_authority_origin_and_unit_direction_before_moving",
           "[mp_inventory_activity][walking_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_bub_ms destination = who.pos_bub() + tripoint::east;
    here.ter_set( who.pos_bub(), ter_id( "t_floor" ) );
    here.ter_set( destination, ter_id( "t_floor" ) );
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    tripoint_abs_ms submitted_origin = origin;
    tripoint_rel_ms direction = tripoint_rel_ms::east;
    bool authorized = true;
    bool accepted = false;
    std::string mode = "walk";
    SECTION( "current request and duplicate replay" ) { accepted = true; }
    SECTION( "unowned player" ) { authorized = false; }
    SECTION( "stale source tile" ) { submitted_origin += tripoint_rel_ms::west; }
    SECTION( "multi tile teleport" ) { direction = tripoint_rel_ms( 5, 0, 0 ); }
    SECTION( "client supplied vertical motion" ) { direction = tripoint_rel_ms( 1, 0, 1 ); }
    SECTION( "unknown movement mode" ) { mode = "not_a_movement_mode"; }
    who.set_moves( 1000 );
    const int stamina = who.get_stamina();
    const int host_moves = host.get_moves();
    const int host_stamina = host.get_stamina();
    const int cost = who.run_cost( here.combined_movecost( who.pos_bub(), destination ), false );
    walk_move_choices choices;
    choices.destination = here.get_abs( destination );
    const std::string wire = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "walk" );
        out.member( "origin", submitted_origin );
        out.member( "direction", direction );
        out.member( "mode", mode );
        out.member( "choices", choices );
        out.member( "dz", 10 ); // An obsolete field must never override the map.
    } );
    fixture.run( who, wire, authorized );
    CHECK( who.pos_abs() == ( accepted ? here.get_abs( destination ) : origin ) );
    CHECK( who.get_moves() == ( accepted ? 1000 - cost : 1000 ) );
    if( !accepted ) {
        CHECK( who.get_stamina() == stamina );
    }
    const tripoint_abs_ms settled_position = who.pos_abs();
    const int settled_moves = who.get_moves();
    const int settled_stamina = who.get_stamina();
    fixture.run( who, wire, authorized );
    CHECK( who.pos_abs() == settled_position );
    CHECK( who.get_moves() == settled_moves );
    CHECK( who.get_stamina() == settled_stamina );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
    CHECK( host.get_moves() == host_moves );
    CHECK( host.get_stamina() == host_stamina );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "walking_authority_derives_ramp_height_from_terrain",
           "[mp_inventory_activity][walking_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms lower = origin + tripoint::east;
    const tripoint_bub_ms upper = lower + tripoint::above;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( lower, ter_id( "t_ramp_up_high" ) );
    here.ter_set( upper, ter_id( "t_floor" ) );
    here.build_map_cache( 0 );
    here.build_map_cache( 1 );
    walk_move_choices choices;
    choices.destination = here.get_abs( upper );
    who.set_moves( 1000 );
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "walk" );
        out.member( "origin", who.pos_abs() );
        out.member( "direction", tripoint_rel_ms::east );
        out.member( "mode", "walk" );
        out.member( "choices", choices );
        out.member( "dz", -7 );
    } ) );
    CHECK( who.pos_bub() == upper );
    CHECK( get_avatar().posz() == 0 );
}

TEST_CASE( "walking_request_runs_native_furniture_activity_on_the_requesting_player",
           "[mp_inventory_activity][walking_owned][grab_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms chair = origin + tripoint::east;
    const tripoint_bub_ms destination = chair + tripoint::east;
    for( const auto &p : { origin, chair, destination } ) {
        here.ter_set( p, ter_id( "t_floor" ) );
    }
    here.furn_set( chair, furn_f_chair );
    who.set_str_base( 50 );
    who.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    walk_move_choices choices;
    choices.destination = here.get_abs( chair );
    who.set_moves( 1000 );
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "walk" );
        out.member( "origin", who.pos_abs() );
        out.member( "direction", tripoint_rel_ms::east );
        out.member( "mode", "walk" );
        out.member( "choices", choices );
    } ) );
    REQUIRE( who.activity.id() == ACT_FURNITURE_MOVE );
    CHECK( who.activity.execution() == activity_execution::authoritative );
    save_reload_activity( who );
    who.set_moves( 100000 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( who.pos_bub() == chair );
    CHECK( here.furn( destination ) == furn_f_chair );
    CHECK_FALSE( get_avatar().activity );
    CHECK( get_avatar().pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
}

TEST_CASE( "remote_swimming_requires_consent_and_changes_only_the_swimmer",
           "[multiplayer][walking_owned][swimming]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms destination = origin + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( destination, ter_id( "t_water_dp" ) );
    who.add_effect( effect_onfire, 1_minutes, bodypart_id( "torso" ) );
    who.set_moves( 1000 );
    const int host_moves = host.get_moves();
    const int host_stamina = host.get_stamina();
    walk_move_choices choices;
    choices.destination = here.get_abs( destination );
    avatar_action::move( who, here, tripoint_rel_ms::east, &choices );
    CHECK( who.pos_bub() == origin );
    CHECK( who.has_effect( effect_onfire ) );
    CHECK( who.get_moves() == 1000 );
    choices.allow_swimming = true;
    avatar_action::move( who, here, tripoint_rel_ms::east, &choices );
    CHECK( who.pos_bub() == destination );
    CHECK_FALSE( who.has_effect( effect_onfire ) );
    CHECK( who.get_moves() < 1000 );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
    CHECK( host.get_moves() == host_moves );
    CHECK( host.get_stamina() == host_stamina );
}

TEST_CASE( "walking_uses_native_injured_leg_and_player_mode_transition_rules",
           "[mp_inventory_activity][walking_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms destination = origin + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( destination, ter_id( "t_floor" ) );
    std::string requested_mode = "crouch";
    SECTION( "mode change is charged once before native walking" ) {}
    SECTION( "broken legs force prone movement" ) {
        requested_mode = "walk";
        who.set_part_hp_cur( bodypart_id( "leg_l" ), 0 );
        who.set_part_hp_cur( bodypart_id( "leg_r" ), 0 );
    }
    const int switch_cost = who.move_mode_switch_cost( who.current_movement_mode(),
                            move_mode_id( requested_mode ) );
    walk_move_choices choices;
    choices.destination = here.get_abs( destination );
    who.set_moves( 1000 );
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "walk" );
        out.member( "origin", who.pos_abs() );
        out.member( "direction", tripoint_rel_ms::east );
        out.member( "mode", requested_mode );
        out.member( "choices", choices );
    } ) );
    REQUIRE( who.pos_bub() == destination );
    if( requested_mode == "walk" ) {
        CHECK( who.is_prone() );
    } else {
        CHECK( who.is_crouching() );
    }
    const int walking_cost = who.run_cost( here.combined_movecost( origin, destination ), false );
    CHECK( who.get_moves() == 1000 - switch_cost - walking_cost );
    CHECK( get_avatar().is_walking() );
}

TEST_CASE( "native_vertical_movement_uses_operator_height_without_recentring_host",
           "[multiplayer][vertical_movement_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 2 );
    const tripoint_bub_ms destination = origin + tripoint::below;
    here.ter_set( origin, ter_id( "t_stairs_down" ) );
    here.ter_set( destination, ter_id( "t_stairs_up" ) );
    who.setpos( here, origin, false );
    who.set_moves( 1000 );
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    const int host_moves = host.get_moves();
    const int host_stamina = host.get_stamina();
    vertical_move_choices choices;
    choices.landing = here.get_abs( destination );
    g->vertical_move( who, -1, false, false, &choices );
    CHECK( who.pos_bub() == destination );
    CHECK( who.get_moves() == 900 );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
    CHECK( host.get_moves() == host_moves );
    CHECK( host.get_stamina() == host_stamina );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "stair_search_is_relative_to_operator_not_host",
           "[multiplayer][vertical_movement_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 1 );
    here.ter_set( origin, ter_id( "t_stairs_down" ) );
    who.setpos( here, origin, false );
    const tripoint_bub_ms near_operator = tripoint_bub_ms( 61, 60, 0 );
    const tripoint_bub_ms far_operator = tripoint_bub_ms( 70, 60, 0 );
    here.ter_set( near_operator, ter_id( "t_stairs_up" ) );
    here.ter_set( far_operator, ter_id( "t_stairs_up" ) );
    get_avatar().setpos( here, tripoint_bub_ms( 71, 60, 0 ) );
    REQUIRE( g->find_stairs( here, 0, origin ) );
    CHECK( *g->find_stairs( here, 0, origin ) == near_operator );
    // A host looking through open air must not suppress the operator's stairs.
    get_avatar().setpos( here, tripoint_bub_ms( 71, 60, 2 ), false );
    here.ter_set( get_avatar().pos_bub(), ter_id( "t_open_air" ) );
    REQUIRE( g->find_stairs( here, 0, origin ) );
    CHECK( *g->find_stairs( here, 0, origin ) == near_operator );
}

TEST_CASE( "vertical_movement_does_not_push_another_player_or_accept_changed_landing",
           "[multiplayer][vertical_movement_owned]" )
{
    reload_fixture fixture;
    player_control_registry controls;
    player_control host_control = controls.claim( player_id( std::string( 32, 'b' ) ), get_avatar() );
    REQUIRE( get_avatar().is_player_controlled() );
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms destination = origin + tripoint::above;
    here.ter_set( origin, ter_id( "t_stairs_up" ) );
    here.ter_set( destination, ter_id( "t_stairs_down" ) );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    vertical_move_choices choices;
    choices.landing = here.get_abs( destination );
    choices.allow_blocker = true;
    SECTION( "another player occupies the stairs" ) {
        get_avatar().setpos( here, destination, false );
    }
    SECTION( "stairs changed while owner chose" ) {
        choices.landing = here.get_abs( destination + tripoint::east );
    }
    who.set_moves( 1000 );
    const tripoint_abs_ms host_position = get_avatar().pos_abs();
    g->vertical_move( who, 1, false, false, &choices );
    CHECK( who.pos_bub() == origin );
    CHECK( who.get_moves() == 1000 );
    CHECK( get_avatar().pos_abs() == host_position );
}

TEST_CASE( "missing_stairs_consume_only_the_operators_selected_rope",
           "[multiplayer][vertical_movement_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms destination = origin + tripoint::below;
    here.ter_set( origin, ter_id( "t_stairs_down" ) );
    here.ter_set( destination, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const itype_id &rope = itype_rope_30;
    who.i_add( item( rope ) );
    get_avatar().i_add( item( rope ) );
    REQUIRE_FALSE( g->find_stairs( here, 0, origin ) );
    bool deployed = false;
    vertical_move_choices choices;
    choices.landing = here.get_abs( destination );
    SECTION( "selected rope remains available" ) {
        choices.drop_aid = "rope";
        REQUIRE( g->find_or_make_stairs( who, here, 0, deployed, false, origin, &choices ) );
        CHECK( deployed );
        CHECK_FALSE( who.has_amount( rope, 1 ) );
    }
    SECTION( "a different aid was selected" ) {
        choices.drop_aid = "grapnel";
        CHECK_FALSE( g->find_or_make_stairs( who, here, 0, deployed, false, origin, &choices ) );
        CHECK_FALSE( deployed );
        CHECK( who.has_amount( rope, 1 ) );
    }
    CHECK( get_avatar().has_amount( rope, 1 ) );
}

TEST_CASE( "climbing_slip_risk_uses_operator_limbs_strength_and_stamina",
           "[multiplayer][vertical_movement_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    const auto risk = [&]() {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        return g->slip_down_chance( who, game::climb_maneuver::up,
                                    climbing_aid_default, false );
    };
    who.set_str_base( 4 );
    who.set_dex_base( 4 );
    const float weak = risk();
    get_avatar().set_str_base( 80 );
    get_avatar().set_dex_base( 80 );
    get_avatar().set_stamina( 0 );
    CHECK( risk() == Approx( weak ) );
    who.set_str_base( 40 );
    who.set_dex_base( 40 );
    const float strong = risk();
    CHECK( strong < weak );
    who.set_stamina( 0 );
    CHECK( risk() > strong );
}

TEST_CASE( "climb_descent_revalidates_and_consumes_the_operators_aid",
           "[multiplayer][vertical_movement_owned][climbing]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms ledge = origin + tripoint::east;
    const tripoint_bub_ms bottom = ledge + tripoint::below;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( bottom, ter_id( "t_floor" ) );
    here.furn_set( ledge, furn_f_null );
    here.furn_set( bottom, furn_f_null );
    who.setpos( here, origin, false );
    who.set_str_base( 40 );
    who.set_dex_base( 40 );
    const itype_id &grapnel = itype_grapnel;
    const climbing_aid_id &aid = climbing_aid_item_grapnel;
    host.i_add( item( grapnel ) );
    bool accepted = false;
    SECTION( "operator has the selected aid" ) {
        who.i_add( item( grapnel ) );
        accepted = true;
    }
    SECTION( "only host has the selected aid" ) {}
    SECTION( "deployment would overwrite existing furniture" ) {
        who.i_add( item( grapnel ) );
        here.furn_set( bottom, furn_f_chair );
    }
    CHECK( g->can_climb_down_using( who, ledge, aid ) == accepted );
    const int host_moves = host.get_moves();
    g->climb_down_using( who, ledge, aid, true, true );
    CHECK( who.pos_bub() == ( accepted ? bottom : origin ) );
    if( accepted ) {
        CHECK_FALSE( who.has_amount( grapnel, 1 ) );
        CHECK( here.furn( bottom ) == furn_f_rope_up );
    }
    CHECK( host.has_amount( grapnel, 1 ) );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
    CHECK( host.get_moves() == host_moves );
}

TEST_CASE( "vertical_intents_revalidate_stairs_and_cannot_force_client_teleports",
           "[mp_inventory_activity][vertical_movement_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 2 );
    const tripoint_bub_ms destination = origin + tripoint::below;
    here.ter_set( origin, ter_id( "t_stairs_down" ) );
    here.ter_set( destination, ter_id( "t_stairs_up" ) );
    who.setpos( here, origin, false );
    who.set_moves( 1000 );
    vertical_move_selection choice;
    choice.origin = who.pos_abs();
    choice.target = choice.origin;
    choice.direction = -1;
    choice.choices.landing = here.get_abs( destination );
    bool authorized = true;
    bool accepted = false;
    std::string mode = "walk";
    SECTION( "current stairs and replay" ) { accepted = true; }
    SECTION( "unowned player" ) { authorized = false; }
    SECTION( "stale source" ) { choice.origin += tripoint_rel_ms::east; }
    SECTION( "multi floor direction" ) { choice.direction = -2; }
    SECTION( "horizontal movement is not a vertical operation" ) { choice.direction = 0; }
    SECTION( "unknown movement mode" ) { mode = "not_a_movement_mode"; }
    SECTION( "changed landing" ) { choice.choices.landing = here.get_abs( destination + tripoint::east ); }
    SECTION( "removed stairs cannot be bypassed by a client force flag" ) {
        here.ter_set( origin, ter_id( "t_floor" ) );
    }
    const tripoint_abs_ms host_position = host.pos_abs();
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    const int host_moves = host.get_moves();
    const std::string wire = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "vertical_move" );
        out.member( "vertical", choice );
        out.member( "mode", mode );
        out.member( "force", true );
        out.member( "dz", -8 );
    } );
    fixture.run( who, wire, authorized );
    CHECK( who.pos_bub() == ( accepted ? destination : origin ) );
    CHECK( who.get_moves() == ( accepted ? 900 : 1000 ) );
    const tripoint_abs_ms settled_position = who.pos_abs();
    const int settled_moves = who.get_moves();
    fixture.run( who, wire, authorized );
    CHECK( who.pos_abs() == settled_position );
    CHECK( who.get_moves() == settled_moves );
    CHECK( host.pos_abs() == host_position );
    CHECK( host.get_moves() == host_moves );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "vertical_client_request_does_not_simulate_movement_or_consume_randomness",
           "[mp_inventory_activity][vertical_movement_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 2 );
    here.ter_set( origin, ter_id( "t_stairs_down" ) );
    here.ter_set( origin + tripoint::below, ter_id( "t_stairs_up" ) );
    who.setpos( here, origin, false );
    who.set_moves( 1000 );
    vertical_move_selection choice;
    choice.origin = who.pos_abs();
    choice.target = choice.origin;
    choice.direction = -1;
    choice.choices.landing = here.get_abs( origin + tripoint::below );
    const std::string state = capture_rng_state();
    const int stamina = who.get_stamina();
    cata_mp::set_client_mode( true );
    REQUIRE( cata_mp::client_vertical_move( choice ) );
    CHECK( who.pos_bub() == origin );
    CHECK( who.get_stamina() == stamina );
    CHECK( capture_rng_state() == state );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
}

TEST_CASE( "vehicle_ladder_requests_bind_the_part_and_recompute_the_descent",
           "[mp_inventory_activity][vertical_movement_owned]" )
{
    vehicle_control_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 2 );
    const tripoint_bub_ms bottom = origin + tripoint( 0, 0, -2 );
    here.ter_set( origin, ter_id( "t_open_air" ) );
    here.ter_set( origin + tripoint::below, ter_id( "t_open_air" ) );
    here.ter_set( bottom, ter_id( "t_floor" ) );
    vehicle *veh = here.add_vehicle( vehicle_prototype_none, origin, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
    const int part = veh->install_part( here, point_rel_ms::zero, vpart_ladder_3 );
    REQUIRE( part >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    who.setpos( here, origin, false );
    who.set_moves( 1000 );
    REQUIRE( here.vehicle_ladder_destination( origin, -1 ) == bottom );
    vertical_move_selection choice;
    choice.origin = who.pos_abs();
    choice.target = here.get_abs( bottom );
    choice.action = "ladder";
    choice.direction = -1;
    choice.vehicle = veh->uid().get_value();
    choice.part = veh->part( part ).get_base().uid().get_value();
    choice.choices.landing = choice.target;
    bool accepted = false;
    SECTION( "current three story ladder derives a two level landing" ) { accepted = true; }
    SECTION( "part replaced at the same mount" ) {
        veh->remove_part( veh->part( part ) );
        REQUIRE( veh->part( part ).removed );
        veh->part_removal_cleanup( here );
        REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_ladder_3 ) >= 0 );
        veh->refresh();
        here.add_vehicle_to_cache( veh );
    }
    SECTION( "new obstruction below the ladder" ) {
        here.ter_set( origin + tripoint::below, ter_id( "t_wall" ) );
    }
    const int host_moves = get_avatar().get_moves();
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "vertical_move" );
        out.member( "vertical", choice );
        out.member( "mode", "walk" );
    } ) );
    CHECK( who.pos_bub() == ( accepted ? bottom : origin ) );
    if( accepted ) {
        CHECK( who.get_moves() < 1000 );
    } else {
        CHECK( who.get_moves() == 1000 );
    }
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "climb_preview_is_read_only_and_request_rechecks_the_selected_owners_aid",
           "[mp_inventory_activity][vertical_movement_owned][climbing]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms ledge = origin + tripoint::east;
    const tripoint_bub_ms bottom = ledge + tripoint::below;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( bottom, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    who.set_str_base( 40 );
    who.set_dex_base( 40 );
    who.set_moves( 1000 );
    const itype_id &grapnel = itype_grapnel;
    host.i_add( item( grapnel ) );
    who.i_add( item( grapnel ) );
    who.set_moves( 1000 );
    vertical_move_selection choice;
    choice.origin = who.pos_abs();
    choice.target = here.get_abs( ledge );
    choice.direction = -1;
    choice.action = "climb";
    choice.aid = climbing_aid_item_grapnel;
    const std::string before = capture_rng_state();
    REQUIRE( g->climb_down_prompt( who, ledge, choice.aid ) );
    CHECK( capture_rng_state() == before );
    CHECK( who.pos_bub() == origin );
    CHECK( who.get_moves() == 1000 );
    CHECK( who.has_amount( grapnel, 1 ) );
    CHECK_FALSE( here.has_furn( bottom ) );
    bool accepted = true;
    SECTION( "same operator completes the descent" ) {}
    SECTION( "selected aid removed after preview" ) {
        who.use_amount( grapnel, 1 );
        accepted = false;
    }
    const std::string wire = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "vertical_move" );
        out.member( "vertical", choice );
        out.member( "mode", "walk" );
    } );
    fixture.run( who, wire );
    CHECK( who.pos_bub() == ( accepted ? bottom : origin ) );
    CHECK_FALSE( who.has_amount( grapnel, 1 ) );
    CHECK( host.has_amount( grapnel, 1 ) );
    if( accepted ) {
        CHECK( here.furn( bottom ) == furn_f_rope_up );
    } else {
        CHECK_FALSE( here.has_furn( bottom ) );
        CHECK( who.get_moves() == 1000 );
    }
    const tripoint_abs_ms settled = who.pos_abs();
    const int moves = who.get_moves();
    fixture.run( who, wire );
    CHECK( who.pos_abs() == settled );
    CHECK( who.get_moves() == moves );
}

TEST_CASE( "vertical_preview_uses_authoritative_geometry_without_spending_a_turn",
           "[mp_inventory_activity][vertical_movement_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 2 );
    const tripoint_bub_ms destination( 61, 60, 1 );
    here.ter_set( origin, ter_id( "t_stairs_down" ) );
    here.ter_set( destination, ter_id( "t_stairs_up" ) );
    who.setpos( here, origin, false );
    who.set_moves( 1000 );
    bool authorized = true;
    bool accepted = true;
    tripoint_abs_ms submitted_origin = who.pos_abs();
    SECTION( "native destination differs from the tile directly below" ) {}
    SECTION( "unowned query" ) { authorized = false; accepted = false; }
    SECTION( "moved while query was pending" ) {
        submitted_origin += tripoint_rel_ms::east;
        accepted = false;
    }
    const std::string before = capture_rng_state();
    const int stamina = who.get_stamina();
    const std::string result = fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "vertical_query" );
        out.member( "origin", submitted_origin );
        out.member( "direction", -1 );
    } ), authorized );
    JsonValue result_json = json_loader::from_string( result );
    JsonObject response = result_json.get_object();
    response.allow_omitted_members();
    CHECK( response.has_object( "vertical_prompt" ) == accepted );
    CHECK( who.pos_bub() == origin );
    CHECK( who.get_moves() == 1000 );
    CHECK( who.get_stamina() == stamina );
    CHECK_FALSE( who.activity );
    CHECK( capture_rng_state() == before );
    if( accepted ) {
        vertical_move_prompt prompt;
        response.read( "vertical_prompt", prompt, true );
        REQUIRE( prompt.options.size() == 1 );
        const vertical_move_selection choice = prompt.options.front().selection;
        CHECK( prompt.origin == who.pos_abs() );
        CHECK( choice.choices.landing == here.get_abs( destination ) );
        fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
            out.member( "kind", "vertical_move" );
            out.member( "vertical", choice );
            out.member( "mode", "walk" );
        } ) );
        CHECK( who.pos_bub() == destination );
        CHECK( who.get_moves() == 900 );
    }
}

TEST_CASE( "ledge_jump_intents_recheck_the_gap_and_use_only_the_requesting_player",
           "[mp_inventory_activity][vertical_movement_owned][ledge]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    host.set_str_base( 1 );
    who.set_str_base( 20 );
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms ledge = origin + tripoint::east;
    const tripoint_bub_ms landing = ledge + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( landing, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    who.set_moves( 1000 );
    vertical_move_prompt prompt = make_ledge_move_prompt( who, here, ledge );
    const auto jump = std::find_if( prompt.options.begin(), prompt.options.end(), []( const auto &entry ) {
        return entry.selection.action == "ledge_jump";
    } );
    REQUIRE( jump != prompt.options.end() );
    vertical_move_selection choice = jump->selection;
    bool accepted = false;
    bool authorized = true;
    SECTION( "native jump" ) { accepted = true; }
    SECTION( "unowned jump" ) { authorized = false; }
    SECTION( "landing disappeared" ) { here.ter_set( landing, ter_id( "t_open_air" ) ); }
    SECTION( "landing is obstructed" ) { here.ter_set( landing, ter_id( "t_wall" ) ); }
    SECTION( "client changed the landing" ) { choice.choices.landing = here.get_abs( landing + tripoint::east ); }
    SECTION( "operator is too weak even when host is strong" ) {
        who.set_str_base( 1 );
        host.set_str_base( 40 );
    }
    const int host_moves = host.get_moves();
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    const std::string wire = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "vertical_move" );
        out.member( "vertical", choice );
        out.member( "mode", "walk" );
    } );
    fixture.run( who, wire, authorized );
    CHECK( who.pos_bub() == ( accepted ? landing : origin ) );
    const tripoint_abs_ms settled = who.pos_abs();
    fixture.run( who, wire, authorized );
    CHECK( who.pos_abs() == settled );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
    CHECK( host.get_moves() == host_moves );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "ordinary_walking_cannot_replace_a_ledge_choice_with_danger_consent",
           "[mp_inventory_activity][vertical_movement_owned][ledge]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms ledge = origin + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( ledge + tripoint::below, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    const auto hazards = g->get_dangerous_tile( who, ledge );
    REQUIRE( hazards == std::vector<std::string>{ "ledge" } );
    walk_move_choices choice;
    choice.destination = here.get_abs( ledge );
    choice.allow_danger = true;
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "walk" );
        out.member( "origin", who.pos_abs() );
        out.member( "direction", tripoint_rel_ms::east );
        out.member( "choices", choice );
        out.member( "mode", "walk" );
    } ) );
    CHECK( who.pos_bub() == origin );
}

TEST_CASE( "ledge_fall_requires_explicit_consent_and_runs_the_operators_native_gravity",
           "[mp_inventory_activity][vertical_movement_owned][ledge]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms ledge = origin + tripoint::east;
    const tripoint_bub_ms bottom = ledge + tripoint::below;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( bottom, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    who.set_moves( 1000 );
    vertical_move_selection choice;
    choice.origin = who.pos_abs();
    choice.target = here.get_abs( ledge );
    choice.direction = -1;
    choice.action = "ledge_fall";
    const bool confirmed = GENERATE( false, true );
    choice.choices.allow_one_way = confirmed;
    const int host_moves = host.get_moves();
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    const std::string wire = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "vertical_move" );
        out.member( "vertical", choice );
        out.member( "mode", "walk" );
    } );
    fixture.run( who, wire );
    CHECK( who.pos_bub() == ( confirmed ? bottom : origin ) );
    if( confirmed ) {
        CHECK( who.get_moves() <= 800 ); // Fall choice plus native forced vertical movement.
    } else {
        CHECK( who.get_moves() == 1000 );
    }
    const int moves = who.get_moves();
    const int torso_hp = who.get_part_hp_cur( bodypart_id( "torso" ) );
    fixture.run( who, wire );
    CHECK( who.get_moves() == moves );
    CHECK( who.get_part_hp_cur( bodypart_id( "torso" ) ) == torso_hp );
    CHECK( host.get_moves() == host_moves );
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "glide_choice_preview_does_not_try_to_escape_restraints",
           "[mp_inventory_activity][vertical_movement_owned][glide]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms ledge = origin + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( ledge + tripoint::below, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    who.set_mutation( trait_WINGS_BIRD );
    REQUIRE( who.can_glide() );
    who.add_effect( effect_beartrap, 1_hours, bodypart_id( "leg_l" ), true );
    const std::string rng_before = capture_rng_state();
    const int moves = who.get_moves();
    const int leg_hp = who.get_part_hp_cur( bodypart_id( "leg_l" ) );
    glide_activity_actor unused( who, here.get_abs( ledge ), 6, 5 );
    CHECK( unused.get_type() == ACT_GLIDE );
    CHECK_FALSE( who.has_effect( effect_gliding ) );
    const vertical_move_prompt prompt = make_ledge_move_prompt( who, here, ledge );
    CHECK( std::any_of( prompt.options.begin(), prompt.options.end(), []( const auto &entry ) {
        return entry.selection.action == "ledge_glide";
    } ) );
    CHECK( capture_rng_state() == rng_before );
    CHECK( who.has_effect( effect_beartrap ) );
    CHECK( who.get_moves() == moves );
    CHECK( who.get_part_hp_cur( bodypart_id( "leg_l" ) ) == leg_hp );
    CHECK( who.pos_bub() == origin );
}

TEST_CASE( "saved_glide_belongs_to_its_operator_and_cancel_cleans_only_that_flight",
           "[mp_inventory_activity][vertical_movement_owned][glide]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 1 );
    here.ter_set( origin, ter_id( "t_floor" ) );
    for( int x = 61; x <= 67; ++x ) {
        here.ter_set( tripoint_bub_ms( x, 60, 1 ), ter_id( "t_open_air" ) );
        here.ter_set( tripoint_bub_ms( x, 60, 0 ), ter_id( "t_floor" ) );
    }
    who.setpos( here, origin, false );
    who.set_mutation( trait_WINGS_BIRD );
    REQUIRE( who.can_glide() );
    who.set_moves( 1000 );
    vertical_move_selection choice;
    choice.origin = who.pos_abs();
    choice.target = here.get_abs( origin + tripoint::east );
    choice.direction = -1;
    choice.action = "ledge_glide";
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "vertical_move" );
        out.member( "vertical", choice );
        out.member( "mode", "walk" );
        out.member( "glide_distance", 100000 ); // Flight physics is derived on the server.
    } ) );
    REQUIRE( who.activity.id() == ACT_GLIDE );
    REQUIRE( who.has_effect( effect_gliding ) );
    REQUIRE( who.pos_bub() == origin + tripoint::east );
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    const int host_moves = host.get_moves();
    save_reload_activity( who );
    SECTION( "resume one tick then cancel" ) {
        fixture.run( who, fixture.request( who, "step" ) );
        REQUIRE( who.pos_bub() == origin + tripoint( 2, 0, 0 ) );
        const std::string wire = fixture.request( who, "cancel" );
        fixture.run( who, wire );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( who.has_effect( effect_gliding ) );
        CHECK( who.pos_bub() == origin + tripoint( 2, 0, -1 ) );
        const int settled_moves = who.get_moves();
        fixture.run( who, wire );
        CHECK( who.get_moves() == settled_moves );
    }
    SECTION( "a copied activity cannot operate another character" ) {
        host.activity = who.activity;
        host.add_effect( effect_gliding, 1_turns, true );
        host.activity.actor->do_turn( host.activity, host );
        CHECK_FALSE( host.activity );
        CHECK( host.has_effect( effect_gliding ) );
        CHECK( who.activity.id() == ACT_GLIDE );
        CHECK( who.pos_bub() == origin + tripoint::east );
    }
    SECTION( "relocation does not continue the old flight" ) {
        const tripoint_bub_ms relocated( 64, 62, 1 );
        here.ter_set( relocated, ter_id( "t_floor" ) );
        who.setpos( here, relocated, false );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( who.has_effect( effect_gliding ) );
        CHECK( who.pos_bub() == relocated );
    }
    CHECK( host.pos_bub() == tripoint_bub_ms( 30, 30, 0 ) );
    CHECK( host.get_moves() == host_moves );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "glide_start_callback_preserves_its_replacement_activity_and_removes_flight_effect",
           "[mp_inventory_activity][vertical_movement_owned][glide]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms ledge = origin + tripoint::east;
    const tripoint_bub_ms bottom = ledge + tripoint::below;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( bottom, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    who.set_mutation( trait_WINGS_BIRD );
    REQUIRE( who.can_glide() );
    who.set_moves( 1000 );
    class replace_on_start : public event_subscriber {
        public:
            Character &owner;
            bool replaced = false;
            explicit replace_on_start( Character &owner ) : owner( owner ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( !replaced && event.type() == event_type::character_starts_activity &&
                    event.get<character_id>( "character" ) == owner.getID() ) {
                    replaced = true;
                    owner.assign_activity( wait_activity_actor( 4_seconds ) );
                }
            }
    } events( who );
    vertical_move_selection choice;
    choice.origin = who.pos_abs();
    choice.target = here.get_abs( ledge );
    choice.direction = -1;
    choice.action = "ledge_glide";
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "vertical_move" );
        out.member( "vertical", choice );
        out.member( "mode", "walk" );
    } ) );
    REQUIRE( events.replaced );
    CHECK( who.activity.id() == ACT_WAIT );
    CHECK_FALSE( who.has_effect( effect_gliding ) );
    CHECK( who.pos_bub() == bottom );
}

TEST_CASE( "reaching_deployed_furniture_below_uses_owned_choices_and_rejects_stale_requests",
           "[mp_inventory_activity][deployed_furniture_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_abs_ms host_origin = host.pos_abs();
    const int host_moves = host.get_moves();
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms ledge = origin + tripoint::east;
    const tripoint_bub_ms below = ledge + tripoint::below;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( below, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    const furn_str_id furniture( GENERATE( "f_ladder", "f_aluminum_stepladder", "f_rope_up" ) );
    REQUIRE( here.furn_set( below, furniture ) );
    const itype_id recovered = furniture.obj().deployed_item;
    const std::string rng = capture_rng_state();
    const vertical_move_prompt prompt = make_ledge_move_prompt( who, here, ledge );
    CHECK( capture_rng_state() == rng );
    const auto reach = std::find_if( prompt.options.begin(), prompt.options.end(), []( const auto &entry ) {
        return entry.selection.action == "ledge_reach";
    } );
    REQUIRE( reach != prompt.options.end() );
    CHECK( reach->enabled );
    CHECK_FALSE( reach->confirmation.empty() );
    CHECK( reach->selection.furniture == furniture );
    CHECK( reach->selection.target == here.get_abs( below ) );
    deployed_furniture_selection choice{ reach->selection.origin, reach->selection.target, reach->selection.furniture };
    bool accepted = false;
    bool authorized = true;
    SECTION( "owner pulls up one item" ) { accepted = true; }
    SECTION( "no authority" ) { authorized = false; }
    SECTION( "no action grant" ) { who.set_moves( 0 ); }
    SECTION( "operator moved since selection" ) { who.setpos( here, origin + tripoint::west, false ); }
    SECTION( "furniture replaced" ) { here.furn_set( below, furn_f_chair ); }
    SECTION( "floor now blocks reach" ) { here.ter_set( ledge, ter_id( "t_floor" ) ); }
    SECTION( "target forged two floors down" ) { choice.target += tripoint::below; }
    SECTION( "arbitrary furniture is not recoverable" ) {
        here.furn_set( below, furn_f_chair );
        choice.furniture = furn_f_chair;
    }
    const auto expected_furniture = here.furn( below ).id();
    const tripoint_abs_ms actor_origin = who.pos_abs();
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    const int moves = who.get_moves();
    const std::string wire = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "take_down_furniture" );
        out.member( "furniture", choice );
    } );
    fixture.run( who, wire, authorized );
    CHECK( fixture.reload.refresh_observers == accepted );
    CHECK( fixture.reload.changed_tiles.size() == ( accepted ? 1 : 0 ) );
    CHECK( here.furn( below ).id() == ( accepted ? furn_str_id::NULL_ID() : expected_furniture ) );
    const auto count_recovered = [&]() {
        const map_stack items = here.i_at( origin );
        return std::count_if( items.begin(), items.end(), [&]( const item &it ) { return it.typeId() == recovered; } );
    };
    CHECK( count_recovered() == ( accepted ? 1 : 0 ) );
    fixture.run( who, wire, authorized );
    CHECK( count_recovered() == ( accepted ? 1 : 0 ) );
    CHECK( who.pos_abs() == actor_origin );
    CHECK( who.get_moves() == moves );
    CHECK( host.pos_abs() == host_origin );
    CHECK( host.get_moves() == host_moves );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "deployed_furniture_drop_callbacks_use_operator_and_cannot_recover_the_source_twice",
           "[mp_inventory_activity][deployed_furniture_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    cata_mp::remote_player_session &recipient = bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 1 );
    const tripoint_bub_ms below = origin + tripoint( 1, 0, -1 );
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( below + tripoint::above, ter_id( "t_open_air" ) );
    here.ter_set( below, ter_id( "t_floor" ) );
    here.furn_set( below, furn_f_ladder );
    who.setpos( here, origin, false );
    const deployed_furniture_selection choice{ who.pos_abs(), here.get_abs( below ), furn_f_ladder };
    // Populate the real recipient delta cache, including the lower floor.
    cata_mp::serialize_remote_player_state( recipient, { choice.target } );
    itype &ladder = *const_cast<itype *>( item::find_type( itype_stepladder ) );
    const restore_on_out_of_scope restore_drop( ladder.drop_action );
    ladder.drop_action = use_function( "owned_furniture_drop", []( Character *actor, item *,
                                       const tripoint_bub_ms &pos ) -> std::optional<int> {
    if( !actor->maybe_get_value( "furniture_drop_seen" ) ) {
    actor->set_value( "furniture_drop_seen", "1" );
        actor->mod_moves( -7 );
        map &here = get_map();
        const tripoint_bub_ms below = pos + tripoint( 1, 0, -1 );
        const deployed_furniture_selection again{ actor->pos_abs(), here.get_abs( below ), furn_f_ladder };
        actor->set_value( "furniture_recovered_twice", take_down_deployed_furniture( *actor, here, again ) ? "1" : "0" );
        // A callback's replacement must survive completion of the old action.
        here.furn_set( below, furn_f_aluminum_stepladder );
    }
    return std::nullopt;
                                       } );
    const int host_moves = host.get_moves();
    const int actor_moves = who.get_moves();
    const std::string wire = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "take_down_furniture" );
        out.member( "furniture", choice );
    } );
    fixture.run( who, wire );
    CHECK( who.get_moves() == actor_moves - 7 );
    CHECK( who.get_value( "furniture_recovered_twice" ).str() == "0" );
    CHECK( host.get_moves() == host_moves );
    CHECK_FALSE( host.maybe_get_value( "furniture_drop_seen" ) );
    CHECK( here.furn( below ).id() == furn_f_aluminum_stepladder );
    const map_stack items = here.i_at( origin );
    CHECK( std::count_if( items.begin(), items.end(), []( const item &it ) {
        return it.typeId() == itype_stepladder;
    } ) == 1 );
    const JsonValue value = json_loader::from_string( cata_mp::serialize_remote_player_state( recipient,
                       fixture.reload.changed_tiles ) );
    const JsonObject message = value.get_object();
    message.allow_omitted_members();
    bool received = false;
    for( const JsonObject cell : message.get_array( "tile_changes" ) ) {
        cell.allow_omitted_members();
        if( cell.get_int( "x" ) == choice.target.x() && cell.get_int( "y" ) == choice.target.y() &&
            cell.get_int( "z" ) == choice.target.z() ) {
            CHECK( cell.get_string( "furn" ) == "f_aluminum_stepladder" );
            received = true;
        }
    }
    CHECK( received );
}

TEST_CASE( "client_furniture_selection_does_not_mutate_the_replica_or_gameplay_rng",
           "[mp_inventory_activity][deployed_furniture_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub( here ) + tripoint::east;
    here.furn_set( target, furn_f_ladder );
    const deployed_furniture_selection choice{ who.pos_abs(), here.get_abs( target ), furn_f_ladder };
    const std::string rng = capture_rng_state();
    cata_mp::set_client_mode( true );
    REQUIRE( cata_mp::client_take_down_furniture( choice ) );
    CHECK( here.furn( target ).id() == choice.furniture );
    CHECK( here.i_at( target ).empty() );
    CHECK( capture_rng_state() == rng );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
}

TEST_CASE( "peek_viewpoints_belong_to_the_map_and_never_restore_a_stale_character_position",
           "[mp_inventory_activity][peek_owned][vision]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    npc &other = fixture.remote();
    other.setpos( here, tripoint_bub_ms( 70, 70, 0 ), false );
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms first( 62, 60, 0 );
    const tripoint_bub_ms second( 64, 60, 0 );
    who.setpos( here, origin, false );
    who.activate_crouch_mode();
    const move_mode_id mode = who.current_movement_mode();
    const std::string rng = capture_rng_state();
    const int moves = who.get_moves();
    const tripoint_abs_sm map_origin = here.get_abs_sub();
    tripoint_bub_ms expected_position = origin;
    struct isolated_map : map {
        isolated_map() : map( 1, true ) {}
    } separate;
    const tripoint_bub_ms separate_position = separate.observer_position( who );
    {
        const scoped_map_viewpoint outer( here, who, here.get_abs( first ), true );
        CHECK( who.pos_bub( here ) == origin );
        CHECK( here.observer_position( who ) == first );
        CHECK( here.observer_standing( who ) );
        CHECK( who.current_movement_mode() == mode );
        CHECK( here.observer_position( other ) == other.pos_bub( here ) );
        CHECK( separate.observer_position( who ) == separate_position );
        {
            const scoped_map_viewpoint inner( here, who, here.get_abs( second ) );
            CHECK( here.observer_position( who ) == second );
            CHECK_FALSE( here.observer_standing( who ) );
        }
        CHECK( here.observer_position( who ) == first );
        SECTION( "normal scope exit" ) {}
        SECTION( "actor relocated by a callback or replica update" ) {
            expected_position = origin + tripoint::south;
            who.setpos( here, expected_position, false );
            CHECK( here.observer_position( who ) == who.pos_bub( here ) );
            CHECK_FALSE( here.observer_standing( who ) );
        }
        SECTION( "map context replaced" ) {
            map_meddler::set_abs_sub( here, map_origin );
            CHECK( here.observer_position( who ) == origin );
            CHECK_FALSE( here.observer_standing( who ) );
        }
    }
    CHECK( who.pos_bub( here ) == expected_position );
    CHECK( here.observer_position( who ) == expected_position );
    CHECK_FALSE( here.observer_standing( who ) );
    CHECK( who.current_movement_mode() == mode );
    CHECK( who.get_moves() == moves );
    CHECK( capture_rng_state() == rng );
    CHECK( here.get_abs_sub() == map_origin );
}

TEST_CASE( "peek_visibility_and_target_range_follow_the_viewpoint_without_moving_the_actor",
           "[mp_inventory_activity][peek_owned][vision]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms viewpoint( 62, 60, 0 );
    const tripoint_bub_ms target( 63, 60, 0 );
    who.setpos( here, origin, false );
    for( int y = 0; y < MAPSIZE_Y; ++y ) {
        here.ter_set( tripoint_bub_ms( 61, y, 0 ), ter_id( "t_wall" ) );
    }
    monster *critter = g->place_critter_at( mon_zombie, target );
    REQUIRE( critter );
    here.build_map_cache( 0 );
    CHECK( here.get_cache_ref( 0 ).seen_cache[target.x()][target.y()] == 0.0f );
    CHECK_FALSE( who.sees( here, *critter ) );
    {
        const scoped_map_viewpoint view( here, who, here.get_abs( viewpoint ) );
        here.build_map_cache( 0 );
        CHECK( here.get_cache_ref( 0 ).seen_cache[target.x()][target.y()] > 0.0f );
        CHECK( who.sees( here, *critter ) );
        const auto targets = who.get_targetable_creatures( 1, false );
        CHECK( std::find( targets.begin(), targets.end(), critter ) != targets.end() );
        CHECK( who.pos_bub( here ) == origin );
    }
    here.build_map_cache( 0 );
    CHECK( here.get_cache_ref( 0 ).seen_cache[target.x()][target.y()] == 0.0f );
    CHECK_FALSE( who.sees( here, *critter ) );
    CHECK( who.pos_bub( here ) == origin );
}

TEST_CASE( "ledge_peek_derives_a_deep_viewpoint_without_moving_or_paying_during_preview",
           "[mp_inventory_activity][peek_owned][vision]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 2 );
    const tripoint_bub_ms ledge = origin + tripoint::east;
    const tripoint_bub_ms bottom( 61, 60, -3 );
    here.ter_set( origin, ter_id( "t_floor" ) );
    for( int z = bottom.z() + 1; z <= ledge.z(); ++z ) {
        here.ter_set( tripoint_bub_ms( ledge.xy(), z ), ter_id( "t_open_air" ) );
    }
    here.ter_set( bottom, ter_id( "t_floor" ) );
    const tripoint_bub_ms target = bottom + tripoint::east;
    here.ter_set( target, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    const std::string rng = capture_rng_state();
    const int moves = who.get_moves();
    const auto viewpoint = ledge_peek_position( who, here, here.get_abs( ledge ) );
    REQUIRE( viewpoint == here.get_abs( bottom ) );
    CHECK( capture_rng_state() == rng );
    monster *critter = g->place_critter_at( mon_zombie, target );
    REQUIRE( critter );
    {
        const scoped_map_viewpoint view( here, who, *viewpoint );
        here.build_map_cache( bottom.z() );
        CHECK( who.sees( here, *critter ) );
        CHECK( who.pos_bub( here ) == origin );
    }
    CHECK( who.get_moves() == moves );
    // Creature creation uses RNG; the pure ledge query is checked separately below.
    const std::string rng_after_spawn = capture_rng_state();
    here.ter_set( ledge, ter_id( "t_floor" ) );
    CHECK_FALSE( ledge_peek_position( who, here, here.get_abs( ledge ) ) );
    CHECK( capture_rng_state() == rng_after_spawn );
}

TEST_CASE( "owned_ledge_peek_pays_once_and_synchronizes_the_selected_floor",
           "[mp_inventory_activity][peek_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    cata_mp::remote_player_session &peer = bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms ledge( 61, 60, 0 );
    const tripoint_bub_ms bottom( 61, 60, -2 );
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( ledge + tripoint::below, ter_id( "t_open_air" ) );
    here.ter_set( bottom, ter_id( "t_floor" ) );
    const tripoint_bub_ms target = bottom + tripoint::east;
    here.ter_set( target, ter_id( "t_floor" ) );
    here.add_item_or_charges( target, item( itype_rock ) );
    monster *critter = g->place_critter_at( mon_zombie, target );
    REQUIRE( critter );
    const tripoint_abs_ms origin = who.pos_abs();
    const int moves = who.get_moves();
    const int host_moves = get_avatar().get_moves();
    const std::string rng = capture_rng_state();
    const auto request = [&]( JsonOut &out ) {
        out.member( "kind", "ledge_peek" );
        out.member( "origin", origin );
        out.member( "ledge", here.get_abs( ledge ) );
    };
    fixture.run( who, fixture.request( who, "start", request ), false );
    CHECK_FALSE( fixture.reload.peek );
    CHECK( who.get_moves() == moves );
    const std::string wire = fixture.request( who, "start", request );
    const JsonValue result = json_loader::from_string( fixture.run( who, wire ) );
    const JsonObject message = result.get_object();
    message.allow_omitted_members();
    REQUIRE( message.has_object( "peek" ) );
    REQUIRE( fixture.reload.peek );
    CHECK( fixture.reload.peek->owner == who.getID() );
    CHECK( fixture.reload.peek->origin == origin );
    CHECK( fixture.reload.peek->viewpoint == here.get_abs( bottom ) );
    CHECK( who.get_moves() == moves - 2 * who.get_speed() );
    fixture.run( who, wire );
    CHECK( who.get_moves() == moves - 2 * who.get_speed() );
    CHECK( who.pos_abs() == origin );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK( capture_rng_state() == rng );

    // A remote view must receive live entities and items from that floor, not
    // the replica's unrelated mapgen population. Restrict the fixture to one floor.
    peer.inventory_activity.peek = fixture.reload.peek;
    peer.inventory_activity.peek->z_range = 0;
    const JsonValue snapshot = json_loader::from_string( cata_mp::serialize_remote_player_state( peer ) );
    const JsonObject state = snapshot.get_object();
    state.allow_omitted_members();
    REQUIRE( state.has_object( "peek" ) );
    bool received_monster = false;
    for( const JsonObject mon : state.get_array( "monsters" ) ) {
        mon.allow_omitted_members();
        if( mon.get_int( "x" ) == critter->pos_abs().x() &&
            mon.get_int( "y" ) == critter->pos_abs().y() &&
            mon.get_int( "z" ) == critter->pos_abs().z() ) {
            received_monster = true;
        }
    }
    CHECK( received_monster );
    bool received_item = false;
    for( const JsonObject cell : state.get_array( "tile_changes" ) ) {
        cell.allow_omitted_members();
        if( cell.get_int( "x" ) == here.get_abs( target ).x() &&
            cell.get_int( "y" ) == here.get_abs( target ).y() && cell.get_int( "z" ) == target.z() ) {
            CHECK_FALSE( cell.get_array( "items" ).empty() );
            received_item = true;
        }
    }
    CHECK( received_item );
    // Revalidate the path on every state delivery, not only at the initial request.
    here.ter_set( ledge, ter_id( "t_floor" ) );
    const JsonValue closed = json_loader::from_string( cata_mp::serialize_remote_player_state( peer ) );
    const JsonObject closed_state = closed.get_object();
    closed_state.allow_omitted_members();
    CHECK_FALSE( closed_state.has_object( "peek" ) );
    CHECK_FALSE( peer.inventory_activity.peek );
}

TEST_CASE( "client_ledge_peek_waits_for_the_authoritative_scene_and_cancel_releases_the_view",
           "[mp_inventory_activity][peek_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    const tripoint_abs_ms origin = who.pos_abs();
    const tripoint_abs_ms ledge = origin + tripoint::east;
    const std::string rng = capture_rng_state();
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    REQUIRE( cata_mp::client_peek_over_ledge( origin, ledge ) );
    CHECK( who.pos_abs() == origin );
    CHECK( capture_rng_state() == rng );
    cata_mp::world_session &session = g->multiplayer_session();
    cata_mp::inventory_activity_client_state &view = session.client_inventory_activity;
    view.pending_request = 0;
    view.finished = true;
    view.peek = cata_mp::peek_authorization{ who.getID(), 7, origin, ledge, ledge, 0 };
    session.client_turn.client_waiting_for_ack = true;
    who.set_moves( 100 );
    cata_mp::client_update_inventory_activity_view();
    CHECK( view.active );
    CHECK( view.peek.has_value() );
    session.client_turn.client_waiting_for_ack = false;
    who.set_moves( 0 );
    cata_mp::client_update_inventory_activity_view();
    CHECK( view.active );
    view.cancel_requested = true;
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( view.active );
    CHECK_FALSE( view.peek );
    CHECK( who.pos_abs() == origin );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "stair_peek_query_and_payment_never_execute_vertical_movement",
           "[mp_inventory_activity][peek_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 2 );
    const tripoint_bub_ms destination( 61, 60, 1 );
    here.ter_set( origin, ter_id( "t_stairs_down" ) );
    here.ter_set( destination, ter_id( "t_stairs_up" ) );
    who.setpos( here, origin, false );
    who.set_moves( 1000 );
    // Native movement would try to get up before proceeding. A peek must not
    // run move_effects, move the actor/mount, or fire movement/landing callbacks.
    who.add_effect( effect_downed, 1_hours );
    const std::string rng = capture_rng_state();
    const int stamina = who.get_stamina();
    const JsonValue result = json_loader::from_string( fixture.run( who,
    fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "vertical_query" );
        out.member( "origin", who.pos_abs() );
        out.member( "direction", -1 );
        out.member( "peeking", true );
    } ) ) );
    const JsonObject response = result.get_object();
    response.allow_omitted_members();
    vertical_move_prompt prompt;
    response.read( "vertical_prompt", prompt, true );
    REQUIRE( prompt.options.size() == 1 );
    const vertical_move_selection choice = prompt.options.front().selection;
    CHECK( choice.action == "peek" );
    CHECK( choice.target == here.get_abs( destination ) );
    CHECK( who.get_moves() == 1000 );
    fixture.run( who, fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "peek" );
        out.member( "origin", choice.origin );
        out.member( "target", choice.target );
        out.member( "direction", choice.direction );
    } ) );
    REQUIRE( fixture.reload.peek );
    CHECK( fixture.reload.peek->valid_for( who, here ) );
    CHECK( who.get_moves() == 1000 - 2 * who.get_speed() );
    CHECK( who.pos_bub( here ) == origin );
    CHECK( who.has_effect( effect_downed ) );
    CHECK( who.get_stamina() == stamina );
    CHECK( capture_rng_state() == rng );
    here.ter_set( origin, ter_id( "t_floor" ) );
    CHECK_FALSE( fixture.reload.peek->valid_for( who, here ) );
}

TEST_CASE( "ordinary_peek_rechecks_adjacent_geometry_and_preserves_crouching",
           "[mp_inventory_activity][peek_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    who.set_movement_mode( move_mode_crouch );
    const tripoint_abs_ms origin = who.pos_abs();
    const std::string rng = capture_rng_state();
    const auto peek = cata_mp::authorize_peek( who, here, origin, origin, 0, 1 );
    REQUIRE( peek );
    CHECK( peek->standing );
    CHECK( who.is_crouching() );
    CHECK( who.pos_abs() == origin );
    CHECK( capture_rng_state() == rng );
    who.set_moves( 1000 );
    const auto distant_target = origin + tripoint_rel_ms( 3, 0, 0 );
    CHECK_FALSE( cata_mp::authorize_peek( who, here, origin, distant_target, 0, 2 ) );
    const auto adjacent = origin + tripoint_rel_ms::east;
    here.ter_set( here.get_bub( adjacent ), ter_id( "t_wall" ) );
    CHECK_FALSE( cata_mp::authorize_peek( who, here, origin, adjacent, 0, 3 ) );
    CHECK( who.get_moves() == 1000 );
    CHECK( capture_rng_state() == rng );
    who.set_movement_mode( move_mode_walk );
    CHECK_FALSE( peek->valid_for( who, here ) );
}

TEST_CASE( "peek_travel_is_deferred_and_starts_at_the_real_actor",
           "[mp_inventory_activity][peek_owned][automove]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms viewpoint( 62, 60, 0 );
    const tripoint_bub_ms target( 63, 60, 0 );
    who.setpos( here, origin, false );
    here.ter_set( origin + tripoint::east, ter_id( "t_wall" ) );
    const int moves = who.get_moves();
    const std::string rng = capture_rng_state();
    view_action selection;
    {
        const scoped_map_viewpoint view( here, who, here.get_abs( viewpoint ) );
        here.build_map_cache( 0 );
        selection = select_view_action( view_action::kind::travel, who, here, target );
        CHECK_FALSE( g->apply_view_action( selection ) );
        CHECK_FALSE( who.has_destination() );
    }
    REQUIRE( g->apply_view_action( selection ) );
    REQUIRE( who.has_destination() );
    const auto &route = who.get_auto_move_route();
    CHECK( square_dist( origin, route.front() ) == 1 );
    CHECK( route.front() != viewpoint );
    CHECK( route.back() == target );
    CHECK( who.pos_bub( here ) == origin );
    CHECK( who.get_moves() == moves );
    CHECK( capture_rng_state() == rng );
    who.clear_destination();
    who.setpos( here, origin + tripoint::south, false );
    CHECK_FALSE( g->apply_view_action( selection ) );
    CHECK_FALSE( who.has_destination() );
}

TEST_CASE( "peek_item_list_uses_the_view_floor_and_deferred_names_recheck_subject_identity",
           "[mp_inventory_activity][peek_owned][vision]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms viewpoint( 61, 60, -2 );
    const tripoint_bub_ms target = viewpoint + tripoint::east;
    here.ter_set( viewpoint, ter_id( "t_floor" ) );
    here.ter_set( target, ter_id( "t_floor" ) );
    who.setpos( here, origin, false );
    here.add_item_or_charges( target, item( itype_rock ) );
    monster *critter = g->place_critter_at( mon_zombie, target );
    REQUIRE( critter );
    view_action selected;
    {
        const scoped_map_viewpoint view( here, who, here.get_abs( viewpoint ) );
        here.build_map_cache( viewpoint.z() );
        item_tab_data items;
        items.init( who, here );
        REQUIRE( items.item_list.size() == 1 );
        CHECK( items.item_list.front()->get_selected_pos() == target - viewpoint );
        selected = select_view_action( view_action::kind::rename, who, here, target, critter );
        selected.name = "ledge observer";
        CHECK_FALSE( g->apply_view_action( selected ) );
        CHECK( critter->nickname.empty() );
    }
    REQUIRE( g->apply_view_action( selected ) );
    CHECK( critter->nickname == "ledge observer" );
    CHECK( who.pos_bub( here ) == origin );
    get_creature_tracker().remove( *critter );
    monster *replacement = g->place_critter_at( mon_zombie, target );
    REQUIRE( replacement );
    CHECK_FALSE( g->apply_view_action( selected ) );
    CHECK( replacement->nickname.empty() );
}

TEST_CASE( "remote_monster_names_require_a_live_observation_and_replicate_without_an_action_cost",
           "[mp_inventory_activity][peek_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    cata_mp::remote_player_session &peer = bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms ledge( 61, 60, 0 );
    const tripoint_bub_ms viewpoint = ledge + tripoint::below;
    const tripoint_bub_ms target = viewpoint + tripoint::east;
    here.ter_set( ledge, ter_id( "t_open_air" ) );
    here.ter_set( viewpoint, ter_id( "t_floor" ) );
    here.ter_set( target, ter_id( "t_floor" ) );
    monster *critter = g->place_critter_at( mon_zombie, target );
    REQUIRE( critter );
    const uint32_t nid = g->multiplayer_session().replication.entity_ids.assign( *critter );
    peer.inventory_activity.peek = cata_mp::authorize_ledge_peek( who, here, who.pos_abs(),
                                   here.get_abs( ledge ), 31 );
    REQUIRE( peer.inventory_activity.peek );
    peer.inventory_activity.peek->z_range = 0;
    peer.turn.granted_this_turn = false; // A nickname is free even while AP recovers.
    const int moves = who.get_moves();
    const std::string rng = capture_rng_state();
    const std::string name = "watcher \"below\"";
    const auto send = [&]( int64_t request, const std::string &nickname ) {
        std::ostringstream text;
        JsonOut out( text );
        out.start_object();
        out.member( "type", "action" );
        out.member( "action", "monster_name" );
        out.member( "subject", nid );
        out.member( "origin", who.pos_abs() );
        out.member( "target", here.get_abs( target ) );
        out.member( "peek_request", request );
        out.member( "name", nickname );
        out.end_object();
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player", text.str(), peer.admission } ) );
        cata_mp::process_mp_events();
    };
    send( 32, name );
    CHECK( critter->nickname.empty() );
    send( 31, name );
    CHECK( critter->nickname == name );
    CHECK( who.get_moves() == moves );
    CHECK( capture_rng_state() == rng );
    const JsonValue snapshot = json_loader::from_string( cata_mp::serialize_remote_player_state( peer ) );
    const JsonObject state = snapshot.get_object();
    state.allow_omitted_members();
    bool received = false;
    for( const JsonObject mon : state.get_array( "monsters" ) ) {
        mon.allow_omitted_members();
        if( mon.get_int( "nid" ) == static_cast<int>( nid ) ) {
            CHECK( mon.get_string( "nickname" ) == name );
            received = true;
        }
    }
    CHECK( received );
    here.ter_set( ledge, ter_id( "t_floor" ) );
    send( 31, "stale view" );
    CHECK( critter->nickname == name );
    CHECK( who.get_moves() == moves );
}

TEST_CASE( "authoritative_automove_result_retries_an_opened_door_but_not_a_blocked_or_replaced_route",
           "[mp_inventory_activity][automove]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms door = origin + tripoint::east;
    const tripoint_bub_ms goal = door + tripoint::east;
    who.setpos( here, origin, false );
    here.ter_set( door, ter_id( "t_door_c" ) );
    who.set_destination( { door, goal } );
    REQUIRE( who.get_next_auto_move_direction() != ACTION_NULL );
    const auto pending = capture_automove_step( who, here, here.get_abs( door ) );
    REQUIRE( pending );
    const std::string rng = capture_rng_state();
    const int moves = who.get_moves();
    SECTION( "door_opened_without_moving_retries_that_same_step" ) {
        here.ter_set( door, ter_id( "t_door_o" ) );
        pending->finish( who, here, false );
        REQUIRE( who.get_auto_move_route().size() == 2 );
        CHECK( who.get_auto_move_route().front() == door );
        CHECK( who.get_auto_move_route().back() == goal );
    }
    SECTION( "blocked_action_does_not_skip_a_tile_or_start_destination_work" ) {
        pending->finish( who, here, false );
        CHECK_FALSE( who.has_destination() );
        CHECK_FALSE( who.destination_point );
    }
    SECTION( "a_canceled_route_cannot_be_resurrected" ) {
        who.clear_destination();
        here.ter_set( door, ter_id( "t_door_o" ) );
        pending->finish( who, here, false );
        CHECK_FALSE( who.has_destination() );
    }
    SECTION( "a_new_route_to_the_same_goal_keeps_its_own_steps" ) {
        const std::vector<tripoint_bub_ms> replacement{ origin + tripoint::south,
                door + tripoint::south, goal };
        who.set_destination( replacement );
        here.ter_set( door, ter_id( "t_door_o" ) );
        pending->finish( who, here, false );
        CHECK( who.get_auto_move_route() == replacement );
    }
    CHECK( who.pos_bub( here ) == origin );
    CHECK( who.get_moves() == moves );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "client_automove_continuation_waits_for_the_position_and_tile_ack",
           "[mp_inventory_activity][automove]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms door = origin + tripoint::east;
    const tripoint_bub_ms goal = door + tripoint::east;
    who.setpos( here, origin, false );
    here.ter_set( door, ter_id( "t_door_c" ) );
    who.set_destination( { door, goal } );
    REQUIRE( who.get_next_auto_move_direction() != ACTION_NULL );
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    walk_move_choices choices;
    choices.destination = here.get_abs( door );
    REQUIRE( cata_mp::client_walk( tripoint_rel_ms::east, choices ) );
    cata_mp::world_session &session = g->multiplayer_session();
    cata_mp::inventory_activity_client_state &view = session.client_inventory_activity;
    REQUIRE( view.pending_automove );
    view.pending_request = 0;
    view.finished = true;
    session.client_turn.client_waiting_for_ack = true;
    who.set_moves( 100 );
    cata_mp::client_update_inventory_activity_view();
    CHECK( view.active );
    CHECK( who.get_auto_move_route().front() == goal );
    // The following ordered player-state message delivers changed tiles and AP.
    here.ter_set( door, ter_id( "t_door_o" ) );
    session.client_turn.client_waiting_for_ack = false;
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( view.active );
    REQUIRE( who.get_auto_move_route().size() == 2 );
    CHECK( who.get_auto_move_route().front() == door );
    CHECK( who.pos_bub( here ) == origin );
    CHECK( who.get_moves() == 100 );
}

TEST_CASE( "automove_arrival_requires_the_destination_tile_and_new_routes_reset_old_expectations",
           "[mp_inventory_activity][automove]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms destination = origin + tripoint::east;
    who.setpos( here, origin, false );
    who.set_destination( { destination }, player_activity( ACT_WAIT, 100 ) );
    REQUIRE( who.get_next_auto_move_direction() != ACTION_NULL );
    REQUIRE_FALSE( who.has_destination() );

    SECTION( "last_step_in_flight_is_not_arrival" ) {
        CHECK_FALSE( who.has_destination_activity() );
        CHECK_FALSE( who.activity );
        CHECK( who.is_auto_moving() );
    }
    SECTION( "displacement_is_not_arrival" ) {
        who.setpos( here, origin + tripoint::south, false );
        CHECK_FALSE( who.has_destination_activity() );
    }
    SECTION( "actual_arrival_starts_the_activity_once" ) {
        who.setpos( here, destination, false );
        REQUIRE( who.has_destination_activity() );
        who.start_destination_activity();
        CHECK( who.activity.id() == ACT_WAIT );
        CHECK_FALSE( who.has_destination_activity() );
        CHECK_FALSE( who.is_auto_moving() );
    }
    SECTION( "replacement_route_does_not_inherit_an_old_expected_position" ) {
        const tripoint_bub_ms relocated = origin + tripoint( 5, 5, 0 );
        who.setpos( here, relocated, false );
        who.set_destination( { relocated + tripoint::east } );
        CHECK( who.get_next_auto_move_direction() != ACTION_NULL );
    }
    SECTION( "a_distant_xy_step_with_a_z_difference_is_not_a_stair_command" ) {
        const tripoint_bub_ms invalid = origin + tripoint( 2, 0, 1 );
        who.set_destination( { invalid } );
        CHECK( who.get_next_auto_move_direction() == ACTION_NULL );
        REQUIRE( who.get_auto_move_route().size() == 1 );
        CHECK( who.get_auto_move_route().front() == invalid );
    }
    SECTION( "an_adjacent_ramp_step_keeps_its_horizontal_direction" ) {
        who.set_destination( { origin + tripoint( 1, 0, 1 ) } );
        CHECK( who.get_next_auto_move_direction() ==
               get_movement_action_from_delta( tripoint_rel_ms::east, iso_rotate::yes ) );
    }
}

TEST_CASE( "destination_activity_start_callbacks_keep_their_new_route",
           "[mp_inventory_activity][automove]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    const tripoint_bub_ms arrived = who.pos_bub() + tripoint::east;
    const tripoint_bub_ms next = arrived + tripoint::south;
    who.set_destination( { arrived }, player_activity( ACT_WAIT, 100 ) );
    REQUIRE( who.get_next_auto_move_direction() != ACTION_NULL );
    who.setpos( here, arrived, false );
    class route_on_start : public event_subscriber
    {
        public:
            Character &who;
            tripoint_bub_ms target;
            bool fired = false;
            route_on_start( Character &who, const tripoint_bub_ms &target ) : who( who ), target( target ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( !fired && event.type() == event_type::character_starts_activity &&
                    event.get<character_id>( "character" ) == who.getID() ) {
                    fired = true;
                    CHECK_FALSE( who.is_auto_moving() );
                    who.set_destination( { target } );
                }
            }
    } events( who, next );
    REQUIRE( who.has_destination_activity() );
    who.start_destination_activity();
    REQUIRE( events.fired );
    REQUIRE( who.get_auto_move_route().size() == 1 );
    CHECK( who.get_auto_move_route().front() == next );
    CHECK( who.destination_point == here.get_abs( next ) );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "native_automove_result_retries_doors_once_and_stops_at_collisions",
           "[mp_inventory_activity][automove][walking_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    const tripoint_bub_ms origin = who.pos_bub();
    const tripoint_bub_ms target = origin + tripoint::east;
    here.ter_set( origin, ter_id( "t_floor" ) );
    here.ter_set( target, ter_id( "t_floor" ) );
    bool blocked = false;
    SECTION( "closed_door" ) {
        here.ter_set( target, ter_id( "t_door_c" ) );
    }
    SECTION( "wall" ) {
        here.ter_set( target, ter_id( "t_wall" ) );
        blocked = true;
    }
    SECTION( "npc_in_the_last_step" ) {
        npc &other = spawn_npc( { target.x(), target.y() }, "test_talker" );
        other.setpos( here, target, false );
        blocked = true;
    }
    who.set_moves( 1000 );
    who.set_destination( { target }, player_activity( ACT_WAIT, 100 ) );
    REQUIRE( who.get_next_auto_move_direction() != ACTION_NULL );
    const auto pending = capture_automove_step( who, here, here.get_abs( target ) );
    REQUIRE( pending );
    walk_move_choices choices;
    choices.destination = here.get_abs( target );
    const bool handled = avatar_action::move( who, here, tripoint_rel_ms::east, &choices );
    pending->finish( who, here, !handled );
    CHECK( who.pos_bub() == origin );
    CHECK_FALSE( who.has_destination_activity() );
    if( blocked ) {
        CHECK_FALSE( handled );
        CHECK_FALSE( who.is_auto_moving() );
        CHECK_FALSE( who.activity );
    } else {
        REQUIRE( handled );
        REQUIRE( here.ter( target ) == ter_id( "t_door_o" ) );
        REQUIRE( who.get_auto_move_route().size() == 1 );
        CHECK( who.get_auto_move_route().front() == target );
        // The native door code already deferred the step. Reconciliation must
        // neither append a duplicate nor reject that existing retry.
        REQUIRE( who.get_next_auto_move_direction() != ACTION_NULL );
        const auto retry = capture_automove_step( who, here, here.get_abs( target ) );
        REQUIRE( retry );
        const bool walked = avatar_action::move( who, here, tripoint_rel_ms::east, &choices );
        retry->finish( who, here, !walked );
        CHECK( who.pos_bub() == target );
        CHECK( who.has_destination_activity() );
    }
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "client_last_automove_step_waits_for_position_before_destination_work",
           "[mp_inventory_activity][automove]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    const tripoint_bub_ms target = origin + tripoint::east;
    who.setpos( here, origin, false );
    who.set_destination( { target }, player_activity( ACT_WAIT, 100 ) );
    REQUIRE( who.get_next_auto_move_direction() != ACTION_NULL );
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    walk_move_choices choices;
    choices.destination = here.get_abs( target );
    REQUIRE( cata_mp::client_walk( tripoint_rel_ms::east, choices ) );
    cata_mp::world_session &session = g->multiplayer_session();
    cata_mp::inventory_activity_client_state &view = session.client_inventory_activity;
    REQUIRE( view.pending_automove );
    view.pending_request = 0;
    view.finished = true;
    session.client_turn.client_waiting_for_ack = true;
    who.set_moves( 100 );
    cata_mp::client_update_inventory_activity_view();
    CHECK( view.active );
    CHECK_FALSE( who.has_destination_activity() );
    const bool arrived = GENERATE( false, true );
    if( arrived ) {
        who.setpos( here, target, false );
    }
    session.client_turn.client_waiting_for_ack = false;
    cata_mp::client_update_inventory_activity_view();
    CHECK_FALSE( view.active );
    CHECK( who.has_destination_activity() == arrived );
    CHECK( who.is_auto_moving() == arrived );
    CHECK_FALSE( who.activity );
    CHECK( who.get_moves() == 100 );
}

TEST_CASE( "native_deferred_work_preserves_the_retry_without_reviving_a_replaced_route",
           "[mp_inventory_activity][automove]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.ter_set( target, ter_id( "t_rock" ) );
    who.set_destination( { target } );
    REQUIRE( who.get_next_auto_move_direction() != ACTION_NULL );
    const auto pending = capture_automove_step( who, here, here.get_abs( target ) );
    REQUIRE( pending );
    who.assign_activity( player_activity( ACT_WAIT, 100 ) );
    REQUIRE( who.defer_move( target ) );
    SECTION( "native_work_has_already_deferred_the_step" ) {
        pending->finish( who, here, false );
        REQUIRE( who.get_auto_move_route().size() == 1 );
        CHECK( who.get_auto_move_route().front() == target );
        CHECK( who.activity.id() == ACT_WAIT );
    }
    SECTION( "a_replacement_route_survives_an_old_failed_movement" ) {
        const tripoint_bub_ms replacement = who.pos_bub() + tripoint::south;
        who.set_destination( { replacement } );
        pending->finish( who, here, true );
        REQUIRE( who.get_auto_move_route().size() == 1 );
        CHECK( who.get_auto_move_route().front() == replacement );
    }
    SECTION( "manual_deferred_mining_also_has_a_real_route" ) {
        who.clear_destination();
        REQUIRE( who.defer_move( target ) );
        CHECK( who.is_auto_moving() );
        CHECK( who.destination_point == here.get_abs( target ) );
        CHECK_FALSE( who.has_destination_activity() );
    }
}

namespace
{
std::string fire_request( reload_fixture &fixture, Character &who, const item_location &tool,
                          const tripoint_bub_ms &target, const item_location &tinder = item_location() )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", "firestarter" );
        out.member( "target", get_map().get_abs( target ) );
        out.member( "fire_target", tool_activity_target::capture( get_map(), get_map().get_abs( target ) ) );
        if( tinder ) {
            out.member( "fire_tinder", capture_item_source( who, tinder ) );
        }
    } );
}
}

TEST_CASE( "owned_fire_start_keeps_its_operator_source_and_surface_across_save_load",
           "[mp_inventory_activity][fire_start_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    avatar &host = get_avatar();
    host.setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    const int host_moves = host.get_moves();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.ter_set( target, ter_id( "t_floor" ) );
    item fuel( itype_paper );
    fuel.charges = 200;
    here.add_item( target, fuel );
    REQUIRE( here.is_flammable( target ) );
    who.set_wielded_item( item( itype_lighter ) );
    item_location tool = who.get_wielded_item();
    tool->ammo_set( itype_butane, 100 );
    const std::string start = fire_request( fixture, who, tool, target );
    fixture.run( who, start );
    REQUIRE( who.activity.id() == ACT_START_FIRE );
    const std::uint64_t generation = who.activity.identity_generation();
    fixture.run( who, start );
    CHECK( who.activity.identity_generation() == generation );
    CHECK( tool->ammo_remaining() == 100 );
    save_reload_activity( who );
    bool success = false;
    bool copy = false;
    SECTION( "complete_and_replay" ) {
        success = true;
    }
    SECTION( "same_type_replacement_tool" ) {
        who.remove_weapon();
        who.set_wielded_item( item( itype_lighter ) );
        tool = who.get_wielded_item();
        tool->ammo_set( itype_butane, 100 );
    }
    SECTION( "changed_furniture" ) {
        here.furn_set( target, furn_f_chair );
    }
    SECTION( "operator_moved_out_of_reach" ) {
        who.setpos( here, who.pos_bub() + tripoint( 0, 3, 0 ), false );
    }
    SECTION( "operator_underwater" ) {
        who.set_underwater( true );
    }
    SECTION( "activity_copied_to_another_player" ) {
        npc &other = spawn_npc( { 60, 61 }, "test_talker" );
        clear_character( other, true );
        other.setpos( here, who.pos_bub(), false );
        other.activity = who.activity;
        other.activity.actor->do_turn( other.activity, other );
        CHECK_FALSE( other.activity );
        CHECK( who.activity.id() == ACT_START_FIRE );
        copy = true;
    }
    if( !copy ) {
        who.activity.moves_left = 1;
        who.set_moves( 100 );
        const std::string step = fixture.request( who, "step" );
        fixture.run( who, step );
        fixture.run( who, step );
        CHECK_FALSE( who.activity );
    }
    CHECK( static_cast<bool>( here.get_field( target, field_type_id( "fd_fire" ) ) ) == success );
    CHECK( tool->ammo_remaining() == ( success ? 99 : 100 ) );
    CHECK( host.get_moves() == host_moves );
    CHECK_FALSE( host.activity );
}

TEST_CASE( "owned_fire_uses_the_selected_tinder_once_and_rejects_replaced_tinder",
           "[mp_inventory_activity][fire_start_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    const tripoint_bub_ms supply = who.pos_bub() + tripoint::south;
    item fuel( itype_paper );
    fuel.charges = 200;
    here.add_item( target, fuel );
    REQUIRE( here.is_flammable( target ) );
    who.set_wielded_item( item( itype_lighter ) );
    item_location tool = who.get_wielded_item();
    tool->ammo_set( itype_butane, 100 );
    tool->set_flag( json_flag_REQUIRES_TINDER );
    item_location tinder( map_cursor( supply ), &here.add_item( supply, item( itype_twig ) ) );
    const std::string outcome = GENERATE( "finish", "replace", "cancel", "missing_choice" );
    const item_location selected = outcome == "missing_choice" ? item_location() : tinder;
    fixture.run( who, fire_request( fixture, who, tool, target, selected ) );
    if( outcome == "missing_choice" ) {
        CHECK_FALSE( who.activity );
        CHECK( tinder );
    } else {
        REQUIRE( who.activity.id() == ACT_START_FIRE );
        CHECK( tinder );
        save_reload_activity( who );
        if( outcome == "replace" ) {
            tinder.remove_item();
            tinder = item_location( map_cursor( supply ), &here.add_item( supply, item( itype_twig ) ) );
        }
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, outcome == "cancel" ? "cancel" : "step" ) );
        if( outcome == "finish" ) {
            REQUIRE( who.activity.id() == ACT_START_FIRE );
            CHECK_FALSE( tinder );
            CHECK( here.i_at( supply ).empty() );
            save_reload_activity( who );
            who.activity.moves_left = 1;
            who.set_moves( 100 );
            const std::string finish = fixture.request( who, "step" );
            fixture.run( who, finish );
            fixture.run( who, finish );
        } else {
            CHECK( tinder );
        }
        CHECK_FALSE( who.activity );
    }
    CHECK( static_cast<bool>( here.get_field( target, field_type_id( "fd_fire" ) ) ) == ( outcome == "finish" ) );
    CHECK( tool->ammo_remaining() == ( outcome == "finish" ? 99 : 100 ) );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "client_fire_selection_does_not_clear_or_spend_from_a_smoking_rack",
           "[mp_inventory_activity][fire_start_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms target = who.pos_bub() + tripoint::east;
    here.furn_set( target, furn_f_smoking_rack );
    item_location contents( map_cursor( target ), &here.add_item( target, item( itype_rock ) ) );
    who.set_wielded_item( item( itype_lighter ) );
    item_location tool = who.get_wielded_item();
    tool->ammo_set( itype_butane, 100 );
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    const std::string rng = capture_rng_state();
    std::string method = "firestarter";
    REQUIRE( cata_mp::client_activate_item( tool, method, here.get_abs( target ) ) );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK( contents );
    CHECK( contents.pos_bub( here ) == target );
    CHECK( tool->ammo_remaining() == 100 );
    CHECK( capture_rng_state() == rng );
    CHECK( here.furn( target ) == furn_f_smoking_rack );
    CHECK_FALSE( here.get_field( target, field_type_id( "fd_fire" ) ) );
}

namespace
{
std::string salvage_request( reload_fixture &fixture, Character &who, const item_location &tool,
                             const salvage_selection &selection )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", "salvage" );
        out.member( "target", who.pos_abs() );
        out.member( "salvage", selection );
    } );
}

int salvage_count( Character *who, map &here, const tripoint_bub_ms &position, const itype_id &type )
{
    int count = 0;
    if( who ) {
        who->visit_items( [&]( item *it, item * ) {
            if( it->typeId() == type ) {
                count += it->count();
            }
            return VisitResponse::NEXT;
        } );
    }
    for( const item &it : here.i_at( position ) ) {
        if( it.typeId() == type ) {
            count += it.count();
        }
    }
    if( const auto cargo = here.veh_at( position ).cargo() ) {
        for( const item &it : cargo->items() ) {
            if( it.typeId() == type ) {
                count += it.count();
            }
        }
    }
    return count;
}
}

TEST_CASE( "owned_salvage_consumes_only_the_selected_item_and_publishes_yield_once",
           "[mp_inventory_activity][salvage_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    const int host_moves = get_avatar().get_moves();
    who.set_skill_level( skill_fabrication, 10 );
    who.set_dex_base( 12 );
    REQUIRE( who.wear_item( item( itype_backpack ), false ).has_value() );
    who.set_wielded_item( item( itype_knife_huge ) );
    item_location tool = who.get_wielded_item();
    tripoint_bub_ms position = who.pos_bub() + tripoint::east;
    item_location original;
    SECTION( "ground" ) {
        original = item_location( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    }
    SECTION( "carried" ) {
        position = who.pos_bub();
        original = who.i_add( item( itype_blanket ) );
        REQUIRE( original.held_by( who ) );
    }
    SECTION( "vehicle_cargo" ) {
        vehicle *cart = here.add_vehicle( vehicle_prototype_test_shopping_cart, position, 0_degrees, 0,
                                          veh_spawn_status::UNDAMAGED );
        REQUIRE( cart );
        cart->set_owner( who.get_faction_id() );
        const auto cargo = here.veh_at( position ).cargo();
        REQUIRE( cargo );
        const auto added = cart->add_item( here, cargo->part(), item( itype_blanket ) );
        REQUIRE( added );
        original = item_location( vehicle_cursor( *cart, cargo->part_index() ), &**added );
    }
    REQUIRE( original );
    const auto expected = salvage_actor::salvage_results( original, 1.0 );
    REQUIRE_FALSE( expected.empty() );
    salvage_selection selection;
    selection.target = capture_item_source( who, original );
    selection.type = original->typeId();
    who.set_moves( 10000 );
    const std::string request = salvage_request( fixture, who, tool, selection );
    fixture.run( who, request );
    CHECK_FALSE( original );
    const int moves = who.get_moves();
    const std::string rng = capture_rng_state();
    fixture.run( who, request );
    CHECK( who.get_moves() == moves );
    CHECK( capture_rng_state() == rng );
    for( const auto &[type, amount] : expected ) {
        CHECK( salvage_count( &who, here, position, type ) == amount );
    }
    CHECK( who.has_item( *tool ) );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_salvage_rejects_a_changed_source_or_unconfirmed_equipment",
           "[mp_inventory_activity][salvage_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    REQUIRE( who.wear_item( item( itype_backpack ), false ).has_value() );
    item_location tool = who.i_add( item( itype_knife_huge ) );
    REQUIRE( tool.held_by( who ) );
    const tripoint_bub_ms position = who.pos_bub() + tripoint::east;
    item_location original( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    salvage_selection selection;
    selection.target = capture_item_source( who, original );
    selection.type = original->typeId();
    SECTION( "same_type_replacement" ) {
        original.remove_item();
        original = item_location( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    }
    SECTION( "transformed_original" ) {
        original->convert( itype_tshirt );
    }
    SECTION( "out_of_reach" ) {
        who.setpos( here, who.pos_bub() + tripoint( 0, 4, 0 ), false );
    }
    SECTION( "equipped_without_confirmation" ) {
        original.remove_item();
        who.set_wielded_item( item( itype_blanket ) );
        original = who.get_wielded_item();
        selection.target = capture_item_source( who, original );
    }
    who.set_moves( 10000 );
    fixture.run( who, salvage_request( fixture, who, tool, selection ) );
    CHECK( original );
    CHECK_FALSE( who.activity );
    CHECK( who.has_item( *tool ) );
}

TEST_CASE( "salvage_yield_survives_a_wield_event_replacing_or_retiring_the_operator",
           "[mp_inventory_activity][salvage_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    who.set_skill_level( skill_fabrication, 10 );
    who.set_dex_base( 12 );
    REQUIRE( who.wear_item( item( itype_backpack ), false ).has_value() );
    item_location tool = who.i_add( item( itype_knife_huge ) );
    REQUIRE( tool.held_by( who ) );
    who.set_wielded_item( item( itype_blanket ) );
    const item_location original = who.get_wielded_item();
    const auto expected = salvage_actor::salvage_results( original, 1.0 );
    const tripoint_bub_ms position = who.pos_bub();
    const bool retire = GENERATE( false, true );
    class on_unwield : public event_subscriber
    {
        public:
            Character &who;
            bool retire;
            bool fired = false;
            on_unwield( Character &who, bool retire ) : who( who ), retire( retire ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( !fired && event.type() == event_type::character_wields_item &&
                    event.get<character_id>( "character" ) == who.getID() && !who.has_weapon() ) {
                    fired = true;
                    if( retire ) {
                        g->remove_npc( who.getID() );
                    } else {
                        who.assign_activity( player_activity( ACT_WAIT, 100 ) );
                    }
                }
            }
    } events( who, retire );
    salvage_selection selection;
    selection.target = capture_item_source( who, original );
    selection.type = original->typeId();
    selection.allow_equipped = true;
    who.set_moves( 10000 );
    fixture.run( who, salvage_request( fixture, who, tool, selection ) );
    REQUIRE( events.fired );
    for( const auto &[type, amount] : expected ) {
        CHECK( salvage_count( nullptr, here, position, type ) == amount );
    }
    if( !retire ) {
        CHECK_FALSE( who.has_weapon() );
        CHECK( who.activity.id() == ACT_WAIT );
    }
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "salvage_drop_callbacks_leave_the_complete_yield_after_replacing_work",
           "[mp_inventory_activity][salvage_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    who.set_skill_level( skill_fabrication, 10 );
    who.set_dex_base( 12 );
    who.set_wielded_item( item( itype_knife_huge ) );
    item_location tool = who.get_wielded_item();
    const tripoint_bub_ms position = who.pos_bub() + tripoint::east;
    item_location original( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    const auto expected = salvage_actor::salvage_results( original, 1.0 );
    const auto chosen = std::find_if( expected.begin(), expected.end(), []( const auto &entry ) {
        return entry.second > 0;
    } );
    REQUIRE( chosen != expected.end() );
    itype &material = *const_cast<itype *>( item::find_type( chosen->first ) );
    const restore_on_out_of_scope restore_drop( material.drop_action );
    material.drop_action = use_function( "salvage_drop_interruption", []( Character *actor, item *,
                                         const tripoint_bub_ms &where ) -> std::optional<int> {
    for( const item &it : get_map().i_at( where ) ) {
    CHECK( it.typeId() != itype_blanket );
    }
    actor->set_value( "salvage_drop_seen", "yes" );
    actor->assign_activity( player_activity( ACT_WAIT, 100 ) );
    return std::nullopt;
                                         } );
    salvage_selection selection;
    selection.target = capture_item_source( who, original );
    selection.type = original->typeId();
    who.set_moves( 10000 );
    const std::string request = salvage_request( fixture, who, tool, selection );
    fixture.run( who, request );
    CHECK_FALSE( original );
    CHECK( who.get_value( "salvage_drop_seen" ).str() == "yes" );
    CHECK( who.activity.id() == ACT_WAIT );
    fixture.run( who, request );
    for( const auto &[type, amount] : expected ) {
        CHECK( salvage_count( &who, here, position, type ) == amount );
    }
    CHECK_FALSE( get_avatar().activity );
}

namespace
{
// Exercise the real tool charge path with a native salvage actor. No production
// item needs a power requirement merely to test long salvage's settlement.
struct powered_salvage_tool {
    itype &type = *const_cast<itype *>( item::find_type( itype_lighter ) );
    restore_on_out_of_scope<decltype( type.use_methods )> restore{ type.use_methods };
    powered_salvage_tool() {
        type.use_methods.emplace( "salvage", use_function( std::make_unique<salvage_actor>() ) );
    }
};

salvage_selection select_salvage( Character &who, const item_location &target )
{
    salvage_selection selection;
    selection.target = capture_item_source( who, target );
    selection.type = target->typeId();
    return selection;
}

std::string salvage_batch_request( reload_fixture &fixture, Character &who,
                                   const item_location &tool, const std::vector<salvage_selection> &targets )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", "salvage" );
        out.member( "target", who.pos_abs() );
        out.member( "salvage_batch", targets );
    } );
}
}

TEST_CASE( "bulk_salvage_saves_the_original_queue_and_pays_each_cut_once",
           "[mp_inventory_activity][salvage_owned]" )
{
    reload_fixture fixture;
    powered_salvage_tool powered;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    const int host_moves = get_avatar().get_moves();
    who.set_skill_level( skill_fabrication, 10 );
    who.set_dex_base( 12 );
    who.set_wielded_item( item( itype_lighter ) );
    item_location tool = who.get_wielded_item();
    tool->ammo_set( itype_butane, 100 );
    const tripoint_bub_ms position = who.pos_bub();
    item_location first( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    item_location second( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    const auto expected = salvage_actor::salvage_results( first, 1.0 );
    const std::string start = salvage_batch_request( fixture, who, tool,
                              { select_salvage( who, first ), select_salvage( who, second ) } );
    fixture.run( who, start );
    REQUIRE( who.activity.id() == ACT_LONGSALVAGE );
    CHECK( first );
    CHECK( second );
    CHECK( tool->ammo_remaining() == 100 );
    fixture.run( who, start );
    item_location later( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    save_reload_activity( who );
    const std::string first_step = fixture.request( who, "step" );
    fixture.run( who, first_step );
    CHECK_FALSE( first );
    CHECK( second );
    CHECK( later );
    CHECK( tool->ammo_remaining() == 99 );
    const int moves = who.get_moves();
    const std::string rng = capture_rng_state();
    fixture.run( who, first_step );
    CHECK( who.get_moves() == moves );
    CHECK( capture_rng_state() == rng );
    CHECK( tool->ammo_remaining() == 99 );
    save_reload_activity( who );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK_FALSE( second );
    CHECK( later );
    CHECK_FALSE( who.activity );
    CHECK( tool->ammo_remaining() == 98 );
    for( const auto &[type, count] : expected ) {
        CHECK( salvage_count( &who, here, position, type ) == count * 2 );
    }
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "bulk_salvage_cancels_without_redirecting_the_tool_or_sources",
           "[mp_inventory_activity][salvage_owned]" )
{
    reload_fixture fixture;
    powered_salvage_tool powered;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    who.set_wielded_item( item( itype_lighter ) );
    item_location tool = who.get_wielded_item();
    tool->ammo_set( itype_butane, 100 );
    const tripoint_bub_ms position = who.pos_bub();
    item_location first( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    item_location second( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    fixture.run( who, salvage_batch_request( fixture, who, tool,
                 { select_salvage( who, first ), select_salvage( who, second ) } ) );
    REQUIRE( who.activity.id() == ACT_LONGSALVAGE );
    save_reload_activity( who );
    bool copied = false;
    SECTION( "same_slot_tool_replacement" ) {
        tool.remove_item();
        who.set_wielded_item( item( itype_lighter ) );
        tool = who.get_wielded_item();
        tool->ammo_set( itype_butane, 100 );
    }
    SECTION( "source_replacement" ) {
        first.remove_item();
        first = item_location( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    }
    SECTION( "operator_left_work_tile" ) {
        who.setpos( here, position + tripoint::east, false );
    }
    SECTION( "cancel_keeps_pending_sources" ) {
        fixture.run( who, fixture.request( who, "cancel" ) );
    }
    SECTION( "legacy_inventory_index_is_not_a_tool_identity" ) {
        JsonValue old = json_loader::from_string( R"({"index":-1})" );
        who.activity.actor = longsalvage_activity_actor::deserialize( old );
    }
    SECTION( "copied_activity_cannot_use_another_body" ) {
        npc &other = spawn_npc( { 61, 60 }, "test_talker" );
        clear_character( other, true );
        other.setpos( here, position, false );
        other.set_moves( 100 );
        other.activity = who.activity;
        other.activity.actor->do_turn( other.activity, other );
        CHECK_FALSE( other.activity );
        CHECK( who.activity.id() == ACT_LONGSALVAGE );
        copied = true;
    }
    if( !copied ) {
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
    }
    CHECK( first );
    CHECK( second );
    CHECK( tool->ammo_remaining() == 100 );
}

TEST_CASE( "bulk_salvage_keeps_remaining_items_when_a_drop_callback_replaces_work",
           "[mp_inventory_activity][salvage_owned]" )
{
    reload_fixture fixture;
    powered_salvage_tool powered;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    who.set_skill_level( skill_fabrication, 10 );
    who.set_dex_base( 12 );
    who.set_wielded_item( item( itype_lighter ) );
    item_location tool = who.get_wielded_item();
    tool->ammo_set( itype_butane, 100 );
    const tripoint_bub_ms position = who.pos_bub();
    item_location first( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    item_location second( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    const auto expected = salvage_actor::salvage_results( first, 1.0 );
    const auto chosen = std::find_if( expected.begin(), expected.end(), []( const auto &entry ) {
        return entry.second > 0;
    } );
    REQUIRE( chosen != expected.end() );
    itype &material = *const_cast<itype *>( item::find_type( chosen->first ) );
    const restore_on_out_of_scope restore_drop( material.drop_action );
    bool replaced_tool = false;
    SECTION( "successor_activity_keeps_one_tool_charge" ) {}
    SECTION( "removed_tool_does_not_charge_the_replacement" ) {
        who.set_value( "replace_salvage_tool", "yes" );
        replaced_tool = true;
    }
    material.drop_action = use_function( "bulk_salvage_interruption", []( Character *actor, item *,
                                         const tripoint_bub_ms & ) -> std::optional<int> {
    if( actor->get_value( "replace_salvage_tool" ).str() == "yes" ) {
    item_location old = actor->get_wielded_item();
        old.remove_item();
        actor->set_wielded_item( item( itype_lighter ) );
        actor->get_wielded_item()->ammo_set( itype_butane, 100 );
    }
    actor->assign_activity( player_activity( ACT_WAIT, 100 ) );
    return std::nullopt;
                                         } );
    fixture.run( who, salvage_batch_request( fixture, who, tool,
                 { select_salvage( who, first ), select_salvage( who, second ) } ) );
    REQUIRE( who.activity.id() == ACT_LONGSALVAGE );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    fixture.run( who, step );
    CHECK_FALSE( first );
    CHECK( second );
    CHECK( who.activity.id() == ACT_WAIT );
    CHECK( who.get_wielded_item()->ammo_remaining() == ( replaced_tool ? 100 : 99 ) );
    for( const auto &[type, count] : expected ) {
        CHECK( salvage_count( &who, here, position, type ) == count );
    }
}

TEST_CASE( "client_bulk_salvage_sends_choices_without_cutting_or_spending_charges",
           "[mp_inventory_activity][salvage_owned]" )
{
    reload_fixture fixture;
    powered_salvage_tool powered;
    avatar &who = get_avatar();
    map &here = get_map();
    who.set_wielded_item( item( itype_lighter ) );
    item_location tool = who.get_wielded_item();
    tool->ammo_set( itype_butane, 100 );
    const tripoint_bub_ms position = who.pos_bub();
    item_location target( map_cursor( position ), &here.add_item( position, item( itype_blanket ) ) );
    item_activation_choices choices;
    choices.salvage_batch = { select_salvage( who, target ) };
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    const std::string rng = capture_rng_state();
    std::string method = "salvage";
    REQUIRE( cata_mp::client_activate_item( tool, method, std::nullopt, &choices ) );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK( target );
    CHECK( tool->ammo_remaining() == 100 );
    CHECK( capture_rng_state() == rng );
}

namespace
{
butchery_selection select_butchery( Character &who, const item_location &corpse,
                                    butcher_type action = butcher_type::DISMEMBER )
{
    butchery_selection selection;
    selection.corpse = capture_item_source( who, corpse );
    selection.type = corpse->get_mtype()->id;
    selection.action = action;
    return selection;
}

std::string butchery_request( reload_fixture &fixture, Character &who,
                              const std::vector<butchery_selection> &corpses )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "butcher" );
        out.member( "corpses", corpses );
    } );
}
}

TEST_CASE( "owned_butchery_reserves_and_processes_only_its_operators_corpse",
           "[mp_inventory_activity][butchery_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ), false );
    const int host_moves = get_avatar().get_moves();
    who.set_wielded_item( item( itype_knife_huge ) );
    item_location corpse = here.add_item_or_charges_ret_loc( who.pos_bub(),
                           item::make_corpse( mon_zombie, calendar::turn ) );
    const butchery_selection selection = select_butchery( who, corpse );
    const std::string start = butchery_request( fixture, who, { selection } );
    fixture.run( who, start );
    REQUIRE( who.activity.id() == ACT_DISMEMBER );
    CHECK( activity_handlers::activity_item_owned_by( *corpse, who ) );
    const std::uint64_t generation = who.activity.identity_generation();
    fixture.run( who, start );
    CHECK( who.activity.identity_generation() == generation );
    save_reload_activity( who );
    npc &other = spawn_npc( { 61, 60 }, "test_talker" );
    clear_character( other, true );
    other.setpos( here, who.pos_bub(), false );
    other.set_moves( 100 );
    other.set_wielded_item( item( itype_knife_huge ) );
    CHECK_FALSE( start_owned_butchery( other, { select_butchery( other, corpse ) } ) );
    CHECK_FALSE( other.activity );
    std::string last;
    for( int turn = 0; who.activity && turn < 500; ++turn ) {
        who.set_moves( 100 );
        last = fixture.request( who, "step" );
        fixture.run( who, last );
    }
    CHECK_FALSE( who.activity );
    CHECK_FALSE( corpse );
    const std::string rng = capture_rng_state();
    const int moves = who.get_moves();
    fixture.run( who, last );
    CHECK( capture_rng_state() == rng );
    CHECK( who.get_moves() == moves );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_butchery_rejects_stale_or_forged_selections_before_mutation",
           "[mp_inventory_activity][butchery_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    who.set_wielded_item( item( itype_knife_huge ) );
    item_location corpse = here.add_item_or_charges_ret_loc( who.pos_bub(),
                           item::make_corpse( mon_zombie, calendar::turn ) );
    std::vector<butchery_selection> selected{ select_butchery( who, corpse ) };
    SECTION( "replaced_original" ) {
        corpse.remove_item();
        corpse = here.add_item_or_charges_ret_loc( who.pos_bub(),
                 item::make_corpse( mon_zombie, calendar::turn ) );
    }
    SECTION( "wrong_monster_type" ) {
        selected.front().type = mon_deer;
    }
    SECTION( "invalid_action" ) {
        selected.front().action = static_cast<butcher_type>( -1 );
    }
    SECTION( "duplicate_corpse" ) {
        selected.push_back( selected.front() );
    }
    SECTION( "out_of_reach" ) {
        who.setpos( here, who.pos_bub() + tripoint( 4, 0, 0 ), false );
    }
    const std::string rng = capture_rng_state();
    const int moves = who.get_moves();
    fixture.run( who, butchery_request( fixture, who, selected ) );
    CHECK_FALSE( who.activity );
    CHECK( corpse );
    CHECK_FALSE( activity_handlers::activity_item_owned_by( *corpse, who ) );
    CHECK( capture_rng_state() == rng );
    CHECK( who.get_moves() == moves );
}

TEST_CASE( "saved_butchery_stops_for_wrong_body_location_or_corpse_and_releases_claims",
           "[mp_inventory_activity][butchery_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    who.set_wielded_item( item( itype_knife_huge ) );
    item_location corpse = here.add_item_or_charges_ret_loc( who.pos_bub(),
                           item::make_corpse( mon_zombie, calendar::turn ) );
    fixture.run( who, butchery_request( fixture, who, { select_butchery( who, corpse ) } ) );
    REQUIRE( who.activity );
    save_reload_activity( who );
    bool copied = false;
    SECTION( "operator_moved" ) {
        who.setpos( here, who.pos_bub() + tripoint::east, false );
    }
    SECTION( "corpse_changed_in_place" ) {
        corpse->set_mtype( &mon_deer.obj() );
    }
    SECTION( "cancel_before_initialization" ) {
        fixture.run( who, fixture.request( who, "cancel" ) );
    }
    SECTION( "cancel_after_source_disappeared" ) {
        corpse.remove_item();
        fixture.run( who, fixture.request( who, "cancel" ) );
    }
    SECTION( "activity_copied_to_another_body" ) {
        npc &other = spawn_npc( { 61, 60 }, "test_talker" );
        clear_character( other, true );
        other.setpos( here, who.pos_bub(), false );
        other.activity = who.activity;
        other.activity.actor->do_turn( other.activity, other );
        CHECK_FALSE( other.activity );
        CHECK( who.activity );
        CHECK( activity_handlers::activity_item_owned_by( *corpse, who ) );
        copied = true;
    }
    if( !copied ) {
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        if( corpse ) {
            CHECK_FALSE( activity_handlers::activity_item_owned_by( *corpse, who ) );
            CHECK( corpse->is_corpse() );
        }
    }
}

TEST_CASE( "client_butchery_choice_does_not_start_native_work_or_claim_a_corpse",
           "[mp_inventory_activity][butchery_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    who.set_wielded_item( item( itype_knife_huge ) );
    item_location corpse = here.add_item_or_charges_ret_loc( who.pos_bub(),
                           item::make_corpse( mon_zombie, calendar::turn ) );
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    const std::string rng = capture_rng_state();
    std::vector<butchery_selection> choices;
    REQUIRE( query_butchery_selection( who, { corpse }, butcher_type::DISMEMBER, choices ) );
    REQUIRE( cata_mp::client_start_butchery( choices ) );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK( corpse );
    CHECK_FALSE( activity_handlers::activity_item_owned_by( *corpse, who ) );
    CHECK( capture_rng_state() == rng );
}

TEST_CASE( "harvest_drop_interruption_keeps_the_complete_yield_and_consumes_the_original_once",
           "[mp_inventory_activity][butchery_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    who.set_wielded_item( item( itype_knife_huge ) );
    who.set_skill_level( skill_survival, 10 );
    who.set_dex_base( 12 );
    for( const char *id : { "prof_butchering_basic", "prof_butchering_adv",
                            "prof_skinning_basic", "prof_skinning_adv" } ) {
        who.add_proficiency( proficiency_id( id ) );
    }
    const tripoint_bub_ms position = who.pos_bub();
    const auto prepare = [&]() {
        item_location corpse = here.add_item_or_charges_ret_loc( position,
                               item::make_corpse( mon_deer, calendar::turn ) );
        butchery_data work( corpse, butcher_type::QUICK );
        butchery_activity_actor calculation( work );
        calculation.calculate_butchery_data( who, work );
        return work;
    };
    butchery_data baseline = prepare();
    const std::string rng = capture_rng_state();
    destroy_the_carcass( baseline, who );
    REQUIRE_FALSE( baseline.corpse );
    std::map<itype_id, int> expected;
    for( const item &value : here.i_at( position ) ) {
        expected[value.typeId()] += value.count();
    }
    REQUIRE_FALSE( expected.empty() );
    const itype_id chosen = expected.begin()->first;
    here.i_clear( position );
    butchery_data work = prepare();
    itype &material = *const_cast<itype *>( item::find_type( chosen ) );
    const restore_on_out_of_scope restore_drop( material.drop_action );
    bool retired = false;
    SECTION( "replacement_activity" ) {}
    SECTION( "retired_operator" ) {
        who.set_value( "retire_harvester", "yes" );
        retired = true;
    }
    material.drop_action = use_function( "harvest_source_settled", []( Character *actor, item *,
                                         const tripoint_bub_ms &pos ) -> std::optional<int> {
                                             REQUIRE( actor );
                                             CHECK( actor->is_npc() );
    for( const item &value : get_map().i_at( pos ) ) {
    CHECK_FALSE( value.is_corpse() );
    }
    if( actor->get_value( "retire_harvester" ).str() == "yes" ) {
    g->remove_npc( actor->getID() );
    } else {
        actor->assign_activity( player_activity( ACT_WAIT, 100 ) );
    }
    return std::nullopt;
                                         } );
    restore_rng_state( rng );
    destroy_the_carcass( work, who );
    CHECK_FALSE( work.corpse );
    std::map<itype_id, int> actual;
    for( const item &value : here.i_at( position ) ) {
        actual[value.typeId()] += value.count();
    }
    CHECK( actual == expected );
    if( !retired ) {
        CHECK( who.activity.id() == ACT_WAIT );
    }
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "bleeding_marks_the_original_and_returns_real_saved_blood_sources",
           "[mp_inventory_activity][butchery_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    map &here = get_map();
    who.set_wielded_item( item( itype_knife_huge ) );
    who.set_skill_level( skill_survival, 10 );
    who.set_dex_base( 12 );
    item_location corpse = here.add_item_or_charges_ret_loc( who.pos_bub(),
                           item::make_corpse( mon_deer, calendar::turn ) );
    butchery_data work( corpse, butcher_type::BLEED );
    butchery_activity_actor calculation( work );
    calculation.calculate_butchery_data( who, work );
    const auto blood = destroy_the_carcass( work, who );
    REQUIRE( corpse );
    CHECK( corpse->has_flag( json_flag_BLED ) );
    REQUIRE_FALSE( blood.empty() );
    int amount = 0;
    for( const item_location &liquid : blood ) {
        REQUIRE( liquid );
        CHECK( liquid.where() == item_location::type::map );
        CHECK( liquid->made_of( phase_id::LIQUID ) );
        amount += liquid->charges;
    }
    const std::string rng = capture_rng_state();
    CHECK( destroy_the_carcass( work, who ).empty() );
    CHECK( capture_rng_state() == rng );
    int remaining = 0;
    for( const item_location &liquid : blood ) {
        REQUIRE( liquid );
        remaining += liquid->charges;
    }
    CHECK( remaining == amount );
}

TEST_CASE( "unprocessed_result_publication_defers_item_processing_until_native_placement",
           "[mp_inventory_activity][butchery_owned][salvage_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    map &here = get_map();
    itype &type = *const_cast<itype *>( item::find_type( itype_meat ) );
    const restore_on_out_of_scope restore_countdown( type.countdown_action );
    type.countdown_action = use_function( "result_processing_probe", []( Character *, item *,
                                          const tripoint_bub_ms & ) -> std::optional<int> {
                                              get_avatar().set_value( "processed_result", "yes" );
                                              return std::nullopt;
                                          } );
    item result( itype_meat, calendar::turn );
    result.active = true;
    result.countdown_point = calendar::turn;
    const tripoint_bub_ms pos = who.pos_bub();
    item_location staged( map_cursor( pos ), &here.add_item_unprocessed( pos, result ) );
    REQUIRE( staged );
    CHECK( who.get_value( "processed_result" ).is_empty() );
    item_location placed;
    CHECK( here.transfer_item_or_charges( pos, staged, item( *staged ), who, 1, true, &placed ) > 0 );
    CHECK( who.get_value( "processed_result" ).str() == "yes" );
    CHECK_FALSE( staged );
    CHECK( placed );
}

TEST_CASE( "owned_bleeding_saves_real_liquid_and_revalidates_partial_destination_choices",
           "[mp_inventory_activity][butchery_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    who.set_wielded_item( item( itype_knife_huge ) );
    who.set_skill_level( skill_survival, 10 );
    who.set_dex_base( 12 );
    const tripoint_bub_ms position = who.pos_bub();
    item_location corpse = here.add_item_or_charges_ret_loc( position,
                           item::make_corpse( mon_deer, calendar::turn ) );
    // Resume the native saved progress at completion; no timing shortcut in production.
    corpse->set_var( butcher_progress_var( butcher_type::BLEED ), 1.0 );
    fixture.run( who, butchery_request( fixture, who,
                                        { select_butchery( who, corpse, butcher_type::BLEED ) } ) );
    REQUIRE( who.activity );
    who.set_moves( 100 );
    const std::string response = fixture.run( who, fixture.request( who, "step" ) );
    REQUIRE( who.activity );
    auto *actor = dynamic_cast<butchery_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    const item *preview = actor->pending_liquid( who );
    REQUIRE( preview );
    const int initial = preview->charges;
    const itype_id blood_type = preview->typeId();
    const int64_t original_id = preview->uid().get_value();
    CHECK( corpse->has_flag( json_flag_BLED ) );
    const JsonValue wire = json_loader::from_string( response );
    const JsonObject view = wire.get_object();
    view.allow_omitted_members();
    CHECK( view.get_int64( "liquid_source_uid" ) == original_id );
    save_reload_activity( who );
    actor = dynamic_cast<butchery_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->pending_liquid( who ) );
    CHECK( actor->pending_liquid( who )->uid().get_value() == original_id );
    const auto remaining_on_ground = [&]() {
        int count = 0;
        for( const item &value : here.i_at( position ) ) {
            if( value.typeId() == blood_type ) {
                count += value.charges;
            }
        }
        return count;
    };
    REQUIRE( remaining_on_ground() == initial );
    unload_liquid_choice choice;
    choice.source = original_id;
    choice.kind = LD_ITEM;
    item_location bottle( map_cursor( position ),
                          &here.add_item( position, item( itype_bottle_plastic ) ) );
    choice.container = capture_item_source( who, bottle );
    who.set_moves( 100 );
    SECTION( "partial_fill_save_then_cancel_preserves_every_charge" ) {
        const int capacity = bottle->get_remaining_capacity_for_liquid( *actor->pending_liquid( who ), true );
        REQUIRE( capacity > 0 );
        REQUIRE( capacity < initial );
        const std::string choose = fixture.request( who, "choose", [&]( JsonOut &out ) {
            out.member( "liquid", choice );
        } );
        fixture.run( who, choose );
        const int moves = who.get_moves();
        CHECK( moves < 100 );
        REQUIRE_FALSE( bottle->empty() );
        CHECK( bottle->only_item().charges == capacity );
        CHECK( remaining_on_ground() == initial - capacity );
        fixture.run( who, choose );
        CHECK( who.get_moves() == moves );
        CHECK( bottle->only_item().charges == capacity );
        save_reload_activity( who );
        who.set_moves( 100 );
        // A fresh request carrying the old source identity must also be harmless.
        item_location second_bottle( map_cursor( position ),
                                     &here.add_item( position, item( itype_bottle_plastic ) ) );
        choice.container = capture_item_source( who, second_bottle );
        fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
            out.member( "liquid", choice );
        } ) );
        CHECK( who.get_moves() == 100 );
        CHECK( second_bottle->empty() );
        who.set_moves( 0 );
        fixture.run( who, fixture.request( who, "cancel" ) );
        CHECK_FALSE( who.activity );
        CHECK( remaining_on_ground() + bottle->only_item().charges == initial );
    }
    SECTION( "wrong_identity_or_other_players_container_cannot_receive_blood" ) {
        const bool foreign = GENERATE( false, true );
        if( foreign ) {
            get_avatar().set_wielded_item( item( itype_bottle_plastic ) );
            choice.container = capture_item_source( get_avatar(), get_avatar().get_wielded_item() );
        } else {
            ++choice.source;
        }
        fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
            out.member( "liquid", choice );
        } ) );
        CHECK( bottle->empty() );
        CHECK( remaining_on_ground() == initial );
        CHECK( who.get_moves() == 100 );
    }
    SECTION( "copied_activity_cannot_choose_for_another_body" ) {
        npc &other = spawn_npc( { 61, 60 }, "test_talker" );
        clear_character( other, true );
        other.setpos( here, position, false );
        other.activity = who.activity;
        auto *copy = dynamic_cast<butchery_activity_actor *>( other.activity.actor.get() );
        REQUIRE( copy );
        CHECK_FALSE( copy->apply_liquid_choice( other, choice, false ) );
        CHECK_FALSE( copy->pending_liquid( other ) );
        CHECK( remaining_on_ground() == initial );
        CHECK( bottle->empty() );
    }
    SECTION( "moved_source_is_not_replaced_by_a_same_type_stack" ) {
        item_location source( map_cursor( position ), const_cast<item *>( actor->pending_liquid( who ) ) );
        item replacement( *source );
        source.remove_item();
        here.add_item_unprocessed( position, std::move( replacement ), true );
        fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
            out.member( "liquid", choice );
        } ) );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( remaining_on_ground() == initial );
        CHECK( bottle->empty() );
    }
    CHECK_FALSE( get_avatar().activity );
}


namespace
{
std::string disassembly_request( reload_fixture &fixture, Character &who,
                                 const std::vector<disassembly_selection> &selected, bool recursive = false )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "disassemble" );
        out.member( "disassembly", selected );
        out.member( "recursive", recursive );
    } );
}

item_location disassembly_original( Character &who )
{
    map &here = get_map();
    return item_location( map_cursor( who.pos_abs() ),
                          &here.add_item( who.pos_bub(), item( itype_test_rag_bundle ) ) );
}
}

TEST_CASE( "owned_disassembly_saves_original_queue_and_preparation_without_host_interaction",
           "[mp_inventory_activity][disassembly_owned]" )
{
    reload_fixture fixture;
    set_time( calendar::turn_zero + 12_hours );
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    item_location first = disassembly_original( who );
    item_location second = disassembly_original( who );
    const int64_t first_id = first->uid().get_value();
    const int64_t second_id = second->uid().get_value();
    const disassembly_selection first_choice = capture_disassembly( who, first, 1 );
    const disassembly_selection second_choice = capture_disassembly( who, second, 1 );
    const std::string start = disassembly_request( fixture, who, { first_choice, second_choice } );
    const std::string response = fixture.run( who, start );
    REQUIRE( who.activity.id() == ACT_DISASSEMBLE );
    const std::uint64_t generation = who.activity.identity_generation();
    fixture.run( who, start );
    CHECK( who.activity.identity_generation() == generation );
    CHECK( first );
    CHECK( second );
    CHECK( activity_handlers::activity_item_owned_by( *first, who ) );
    CHECK_FALSE( activity_handlers::activity_item_owned_by( *second, who ) );
    const JsonValue value = json_loader::from_string( response );
    const JsonObject state = value.get_object();
    state.allow_omitted_members();
    CHECK( state.has_object( "disassembly_prompt" ) );
    save_reload_activity( who );
    auto *actor = dynamic_cast<disassemble_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->pending_preparation( who ) );
    CHECK( actor->pending_preparation( who )->source.path.back() == first_id );
    disassembly_preparation preparation;
    preparation.source = first_id;
    preparation.placement = craft_placement::work_on_ground;
    const std::string choose = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "disassembly_choice", preparation );
    } );
    fixture.run( who, choose );
    REQUIRE( actor->target );
    const int64_t work_id = actor->target->uid().get_value();
    CHECK_FALSE( first );
    CHECK( second );
    CHECK( actor->target->typeId() == itype_disassembly );
    fixture.run( who, choose );
    CHECK( actor->target->uid().get_value() == work_id );
    save_reload_activity( who );
    actor = dynamic_cast<disassemble_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->target );
    // Resume a saved completed counter through the real native settlement path.
    actor->target->item_counter = 10000000;
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    REQUIRE( who.activity );
    actor = dynamic_cast<disassemble_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->pending_preparation( who ) );
    CHECK( actor->pending_preparation( who )->source.path.back() == second_id );
    CHECK( activity_handlers::activity_item_owned_by( *second, who ) );
    who.set_moves( 0 );
    fixture.run( who, fixture.request( who, "cancel" ) );
    CHECK_FALSE( who.activity );
    CHECK( second );
    CHECK_FALSE( activity_handlers::activity_item_owned_by( *second, who ) );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "owned_disassembly_rejects_forged_originals_and_preparation_before_consuming_them",
           "[mp_inventory_activity][disassembly_owned]" )
{
    reload_fixture fixture;
    set_time( calendar::turn_zero + 12_hours );
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    item_location original = disassembly_original( who );
    disassembly_selection selected = capture_disassembly( who, original, 1 );
    const std::string failure = GENERATE( "quantity", "type", "recipe", "favorite", "duplicate",
                                          "tool_payload", "placement", "source_identity" );
    CAPTURE( failure );
    bool prepare = false;
    if( failure == "quantity" ) {
        selected.quantity = 2;
    } else if( failure == "type" ) {
        selected.type = itype_test_knotted_string_ball;
    } else if( failure == "recipe" ) {
        selected.recipe = recipe_id::NULL_ID();
    } else if( failure == "favorite" ) {
        original->is_favorite = true;
    } else if( failure != "duplicate" ) {
        prepare = true;
    }
    fixture.run( who, disassembly_request( fixture, who, failure == "duplicate" ?
                                           std::vector<disassembly_selection>{ selected, selected } : std::vector<disassembly_selection>{ selected } ) );
    if( prepare ) {
        REQUIRE( who.activity );
        disassembly_preparation choice;
        choice.source = original->uid().get_value();
        choice.placement = craft_placement::work_on_ground;
        if( failure == "tool_payload" ) {
            comp_selection<tool_comp> tool;
            tool.comp.type = itype_test_multitool;
            tool.comp.count = -1;
            choice.tools.push_back( tool );
        } else if( failure == "placement" ) {
            choice.placement = static_cast<craft_placement>( 999 );
        } else {
            ++choice.source;
        }
        fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
            out.member( "disassembly_choice", choice );
        } ) );
        const auto *actor = dynamic_cast<disassemble_activity_actor *>( who.activity.actor.get() );
        REQUIRE( actor );
        CHECK_FALSE( actor->target );
    } else {
        CHECK_FALSE( who.activity );
    }
    CHECK( original );
    CHECK( who.get_moves() == 100 );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "saved_disassembly_claims_belong_to_one_operator_and_release_after_displacement",
           "[mp_inventory_activity][disassembly_owned]" )
{
    reload_fixture fixture;
    set_time( calendar::turn_zero + 12_hours );
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    item_location original = disassembly_original( who );
    fixture.run( who, disassembly_request( fixture, who, { capture_disassembly( who, original, 1 ) } ) );
    REQUIRE( who.activity );
    save_reload_activity( who );
    SECTION( "another_body_cannot_prepare_or_cancel_the_owners_claim" ) {
        npc &other = spawn_npc( { 61, 60 }, "test_talker" );
        clear_character( other, true );
        other.setpos( get_map(), who.pos_bub(), false );
        other.activity = who.activity;
        auto *copy = dynamic_cast<disassemble_activity_actor *>( other.activity.actor.get() );
        REQUIRE( copy );
        disassembly_preparation choice;
        choice.source = original->uid().get_value();
        choice.placement = craft_placement::work_on_ground;
        CHECK_FALSE( copy->apply_preparation( other, choice ) );
        other.activity.actor->do_turn( other.activity, other );
        CHECK_FALSE( other.activity );
        CHECK( activity_handlers::activity_item_owned_by( *original, who ) );
        CHECK( who.activity );
    }
    SECTION( "moving_beyond_interaction_range_releases_the_original_claim" ) {
        who.setpos( get_map(), who.pos_bub() + tripoint( 4, 0, 0 ), false );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK_FALSE( activity_handlers::activity_item_owned_by( *original, who ) );
    }
    CHECK( original );
}

TEST_CASE( "client_disassembly_selects_without_wielding_consuming_or_claiming",
           "[mp_inventory_activity][disassembly_owned]" )
{
    reload_fixture fixture;
    set_time( calendar::turn_zero + 12_hours );
    avatar &who = get_avatar();
    item_location original = disassembly_original( who );
    cata_mp::set_client_mode( true );
    who.set_moves( 100 );
    const std::string rng = capture_rng_state();
    REQUIRE( who.disassemble( original, false, true ) );
    CHECK( original );
    CHECK( cata_mp::inventory_activity_view( who.activity ) );
    CHECK_FALSE( activity_handlers::activity_item_owned_by( *original, who ) );
    CHECK_FALSE( who.has_weapon() );
    CHECK( who.get_moves() == 100 );
    CHECK( capture_rng_state() == rng );
}


namespace
{
item_location prepare_disassembly_work( reload_fixture &fixture, Character &who,
                                        const item_location &original )
{
    fixture.run( who, disassembly_request( fixture, who, { capture_disassembly( who, original, 1 ) } ) );
    REQUIRE( who.activity );
    disassembly_preparation choice;
    choice.source = original->uid().get_value();
    choice.placement = craft_placement::work_on_ground;
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "disassembly_choice", choice );
    } ) );
    auto *actor = dynamic_cast<disassemble_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->target );
    return actor->target;
}
}

TEST_CASE( "disassembly_publishes_workpiece_and_removed_mod_before_unwield_callbacks",
           "[mp_inventory_activity][disassembly_owned]" )
{
    reload_fixture fixture;
    set_time( calendar::turn_zero + 12_hours );
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms position = who.pos_bub();
    who.set_wielded_item( item( itype_test_rag_bundle ) );
    item_location original = who.get_wielded_item();
    original->set_flag( json_flag_RADIO_MOD );
    const disassembly_selection selection = capture_disassembly( who, original, 1 );
    fixture.run( who, disassembly_request( fixture, who, { selection } ) );
    REQUIRE( who.activity );
    const bool retire = GENERATE( false, true );
    class on_unwield : public event_subscriber
    {
        public:
            Character &who;
            bool retire;
            bool fired = false;
            on_unwield( Character &who, bool retire ) : who( who ), retire( retire ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( !fired && event.type() == event_type::character_wields_item &&
                    event.get<character_id>( "character" ) == who.getID() && !who.has_weapon() ) {
                    fired = true;
                    CHECK( salvage_count( nullptr, get_map(), who.pos_bub(), itype_disassembly ) == 1 );
                    CHECK( salvage_count( nullptr, get_map(), who.pos_bub(), itype_radio_mod ) == 1 );
                    if( retire ) {
                        g->remove_npc( who.getID() );
                    } else {
                        who.assign_activity( player_activity( ACT_WAIT, 100 ) );
                    }
                }
            }
    } events( who, retire );
    disassembly_preparation choice;
    choice.source = original->uid().get_value();
    choice.placement = craft_placement::work_on_ground;
    fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "disassembly_choice", choice );
    } ) );
    REQUIRE( events.fired );
    CHECK( salvage_count( nullptr, here, position, itype_disassembly ) == 1 );
    CHECK( salvage_count( nullptr, here, position, itype_radio_mod ) == 1 );
    for( const item &value : here.i_at( position ) ) {
        CHECK_FALSE( value.has_var( "activity_owner_id" ) );
        if( value.typeId() == itype_disassembly ) {
            CHECK_FALSE( value.components.only_item().has_flag( json_flag_RADIO_MOD ) );
        }
    }
    if( !retire ) {
        CHECK_FALSE( who.has_weapon() );
        CHECK( who.activity.id() == ACT_WAIT );
    }
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "disassembly_drop_interruption_keeps_complete_native_yield_after_source_debit",
           "[mp_inventory_activity][disassembly_owned]" )
{
    reload_fixture fixture;
    set_time( calendar::turn_zero + 12_hours );
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms position = who.pos_bub();
    item_location original = disassembly_original( who );
    item_location work = prepare_disassembly_work( fixture, who, original );
    work->item_counter = 10000000;
    itype &cotton = *const_cast<itype *>( item::find_type( itype_cotton_patchwork ) );
    const restore_on_out_of_scope restore_drop( cotton.drop_action );
    const bool retire = GENERATE( false, true );
    if( retire ) {
        who.set_value( "retire_disassembly", "yes" );
    }
    cotton.drop_action = use_function( "settled_disassembly", []( Character *actor, item *,
                                       const tripoint_bub_ms &position ) -> std::optional<int> {
                                           REQUIRE( actor );
                                           CHECK( actor->is_npc() );
                                           CHECK( salvage_count( nullptr, get_map(), position, itype_disassembly ) == 0 );
                                           CHECK( salvage_count( nullptr, get_map(), position, itype_cotton_patchwork ) == 100 );
                                           CHECK( salvage_count( nullptr, get_map(), position, itype_string_36 ) == 1 );
                                           get_avatar().set_value( "disassembly_drop_callback", "yes" );
    if( actor->get_value( "retire_disassembly" ).str() == "yes" ) {
    g->remove_npc( actor->getID() );
    } else {
        actor->assign_activity( player_activity( ACT_WAIT, 100 ) );
    }
    return std::nullopt;
                                       } );
    who.set_moves( 100 );
    fixture.run( who, fixture.request( who, "step" ) );
    CHECK( get_avatar().get_value( "disassembly_drop_callback" ).str() == "yes" );
    CHECK_FALSE( work );
    CHECK( salvage_count( nullptr, here, position, itype_cotton_patchwork ) == 100 );
    CHECK( salvage_count( nullptr, here, position, itype_string_36 ) == 1 );
    if( !retire ) {
        CHECK( who.activity.id() == ACT_WAIT );
    }
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "disassembly_liquid_components_save_and_fill_once_with_remainder_on_cancel",
           "[mp_inventory_activity][disassembly_owned]" )
{
    reload_fixture fixture;
    set_time( calendar::turn_zero + 12_hours );
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    map &here = get_map();
    const tripoint_bub_ms position = who.pos_bub();
    item_location original = disassembly_original( who );
    item water( itype_water_clean, calendar::turn );
    water.charges = 8;
    original->components.add( water );
    item cotton( itype_cotton_patchwork, calendar::turn );
    cotton.charges = 3;
    original->components.add( cotton );
    item_location work = prepare_disassembly_work( fixture, who, original );
    work->item_counter = 10000000;
    who.set_moves( 100 );
    const std::string finish = fixture.request( who, "step" );
    const std::string response = fixture.run( who, finish );
    REQUIRE_FALSE( work );
    fixture.run( who, finish );
    REQUIRE( who.activity );
    auto *actor = dynamic_cast<disassemble_activity_actor *>( who.activity.actor.get() );
    REQUIRE( actor );
    REQUIRE( actor->pending_liquid( who ) );
    const int64_t source = actor->pending_liquid( who )->uid().get_value();
    CHECK( actor->pending_liquid( who )->charges == 8 );
    const JsonValue value = json_loader::from_string( response );
    const JsonObject view = value.get_object();
    view.allow_omitted_members();
    CHECK( view.get_int64( "liquid_source_uid" ) == source );
    CHECK( salvage_count( nullptr, here, position, itype_cotton_patchwork ) == 3 );
    save_reload_activity( who );
    item_location bottle( map_cursor( position ),
                          &here.add_item( position, item( itype_bottle_plastic ) ) );
    unload_liquid_choice choice;
    choice.source = source;
    choice.kind = LD_ITEM;
    choice.container = capture_item_source( who, bottle );
    who.set_moves( 100 );
    const std::string fill = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "liquid", choice );
    } );
    fixture.run( who, fill );
    REQUIRE_FALSE( bottle->empty() );
    const int filled = bottle->only_item().charges;
    REQUIRE( filled > 0 );
    REQUIRE( filled < 8 );
    fixture.run( who, fill );
    CHECK( bottle->only_item().charges == filled );
    CHECK( salvage_count( nullptr, here, position, itype_water_clean ) == 8 - filled );
    save_reload_activity( who );
    who.set_moves( 0 );
    fixture.run( who, fixture.request( who, "cancel" ) );
    CHECK_FALSE( who.activity );
    CHECK( salvage_count( nullptr, here, position, itype_water_clean ) + filled == 8 );
    CHECK_FALSE( get_avatar().activity );
}

namespace
{
item_location chopping_tool( Character &who )
{
    who.set_wielded_item( item( itype_ax ) );
    who.set_moves( 1000 );
    return who.get_wielded_item();
}

std::string chopping_request( reload_fixture &fixture, Character &who,
                              const item_location &tool, bool tree, const tripoint_bub_ms &position )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", tree ? "CHOP_TREE" : "CHOP_LOGS" );
        out.member( "target", get_map().get_abs( position ) );
    } );
}
} // namespace

TEST_CASE( "remote_tree_chopping_waits_for_saved_owner_direction_then_finishes_once",
           "[mp_inventory_activity][chopping_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    bind_feedback_player( who, 'a', 701 );
    item_location tool = chopping_tool( who );
    const tripoint_bub_ms position( 61, 60, 0 );
    here.ter_set( position, ter_t_tree );
    const int host_moves = get_avatar().get_moves();
    fixture.run( who, chopping_request( fixture, who, tool, true, position ) );
    REQUIRE( who.activity.id() == ACT_CHOP_TREE );
    CHECK( who.activity.moves_total == chopping_work_moves( who, *tool ) );
    save_reload_activity( who );
    who.activity.moves_left = 1;
    who.set_moves( 1000 );
    const std::string pending = fixture.run( who, fixture.request( who, "step" ) );
    REQUIRE( who.activity );
    const auto *tree = dynamic_cast<const chop_tree_activity_actor *>( who.activity.actor.get() );
    REQUIRE( tree );
    CHECK( tree->pending_direction() );
    CHECK_FALSE( tree->ready_to_finish() );
    CHECK( json_loader::from_string( pending ).get_object().get_bool( "tree_direction_prompt" ) );
    CHECK( here.ter( position ) == ter_t_tree );
    save_reload_activity( who );
    const int moves = who.get_moves();
    for( const auto &direction : {
             tripoint_rel_ms::zero, tripoint_rel_ms( 2, 0, 0 ), tripoint_rel_ms( 1, 0, 1 ),
             tripoint_rel_ms( std::numeric_limits<int>::min(), 0, 0 )
         } ) {
        fixture.run( who, fixture.request( who, "choose", [&]( JsonOut &out ) {
            out.member( "tree_direction", direction );
        } ) );
        CHECK( who.activity );
        CHECK( who.get_moves() == moves );
        CHECK( here.ter( position ) == ter_t_tree );
    }
    class tree_events : public event_subscriber {
            character_id owner;
        public:
            int cuts = 0;
            explicit tree_events( const Character &who ) : owner( who.getID() ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::cuts_tree ) {
                    CHECK( event.get<character_id>( "character" ) == owner );
                    ++cuts;
                }
            }
    } events( who );
    const std::string choice = fixture.request( who, "choose", [&]( JsonOut &out ) {
        out.member( "tree_direction", tripoint_rel_ms( 1, 0, 0 ) );
    } );
    fixture.run( who, choice );
    CHECK_FALSE( who.activity );
    CHECK( events.cuts == 1 );
    CHECK( here.ter( position ) == ter_t_stump );
    who.assign_activity( player_activity( ACT_WAIT, 100 ) );
    fixture.run( who, choice );
    CHECK( events.cuts == 1 );
    CHECK( who.activity.id() == ACT_WAIT );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "saved_chopping_cancels_on_changed_surface_tool_operator_or_origin",
           "[mp_inventory_activity][chopping_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    const bool tree = GENERATE( false, true );
    const std::string change = GENERATE( "surface", "tool", "operator", "origin" );
    item_location tool = chopping_tool( who );
    const tripoint_bub_ms position( 61, 60, 0 );
    here.ter_set( position, ter_str_id( tree ? "t_tree" : "t_trunk" ) );
    fixture.run( who, chopping_request( fixture, who, tool, tree, position ) );
    REQUIRE( who.activity );
    save_reload_activity( who );
    if( change == "surface" ) {
        here.ter_set( position, ter_t_dirt );
    } else if( change == "tool" ) {
        who.set_wielded_item( item( itype_ax ) );
    } else if( change == "origin" ) {
        who.setpos( here, tripoint_bub_ms( 60, 61, 0 ) );
    }
    who.activity.moves_left = 0;
    who.set_moves( 100 );
    if( change == "operator" ) {
        avatar &other = get_avatar();
        other.setpos( here, who.pos_bub() );
        other.activity = who.activity;
        other.set_moves( 100 );
        other.activity.do_turn( other );
        CHECK_FALSE( other.activity );
        CHECK( who.activity );
    } else {
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
    }
    CHECK( here.ter( position ) == ter_str_id( change == "surface" ? "t_dirt" :
            tree ? "t_tree" : "t_trunk" ) );
    CHECK( salvage_count( nullptr, here, position, itype_log ) == 0 );
}

TEST_CASE( "chopping_logs_publishes_native_yield_before_interrupted_drop_and_cannot_replay",
           "[mp_inventory_activity][chopping_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    const bool retire = GENERATE( false, true );
    item_location tool = chopping_tool( who );
    const tripoint_bub_ms position( 61, 60, 0 );
    here.ter_set( position, ter_t_trunk );
    fixture.run( who, chopping_request( fixture, who, tool, false, position ) );
    REQUIRE( who.activity.id() == ACT_CHOP_LOGS );
    save_reload_activity( who );
    who.set_value( "retire_chopper", retire ? "yes" : "no" );
    itype &log = *const_cast<itype *>( item::find_type( itype_log ) );
    const restore_on_out_of_scope restore_drop( log.drop_action );
    log.drop_action = use_function( "settled_chopping", []( Character *actor, item *,
                                    const tripoint_bub_ms &position ) -> std::optional<int> {
                                        REQUIRE( actor );
                                        CHECK( actor->is_npc() );
                                        CHECK( get_map().ter( position ) == ter_t_dirt );
                                        const int logs = salvage_count( nullptr, get_map(), position, itype_log );
                                        CHECK( logs >= 2 );
                                        CHECK( logs <= 3 );
                                        get_avatar().set_value( "chopping_drop_callback", std::to_string( logs ) );
    if( actor->get_value( "retire_chopper" ).str() == "yes" ) {
    g->remove_npc( actor->getID() );
    } else {
        actor->assign_activity( player_activity( ACT_WAIT, 100 ) );
    }
    return std::nullopt;
                                    } );
    who.activity.moves_left = 1;
    who.set_moves( 1000 );
    const std::string step = fixture.request( who, "step" );
    fixture.run( who, step );
    const int logs = salvage_count( nullptr, here, position, itype_log );
    CHECK( logs >= 2 );
    CHECK( logs <= 3 );
    CHECK( get_avatar().get_value( "chopping_drop_callback" ).str() == std::to_string( logs ) );
    CHECK( here.ter( position ) == ter_t_dirt );
    if( !retire ) {
        fixture.run( who, step );
        CHECK( salvage_count( nullptr, here, position, itype_log ) == logs );
        CHECK( who.activity.id() == ACT_WAIT );
    }
}

TEST_CASE( "zone_chopping_keeps_automatic_direction_and_client_entry_only_sends_selection",
           "[mp_inventory_activity][chopping_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    const tripoint_bub_ms position( 61, 60, 0 );
    here.ter_set( position, ter_t_tree );
    SECTION( "automatic work uses the actual remote operator" ) {
        npc &who = fixture.remote();
        bind_feedback_player( who, 'a', 701 );
        item_location tool = chopping_tool( who );
        REQUIRE( start_chopping_work( who, tool, here.get_abs( position ), true ) );
        who.activity.moves_left = 1;
        who.set_moves( 1000 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( here.ter( position ) == ter_t_stump );
    }
    SECTION( "frontend does not cut or consume time" ) {
        avatar &who = get_avatar();
        who.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
        item_location tool = chopping_tool( who );
        const int moves = who.get_moves();
        const std::string rng = capture_rng_state();
        cata_mp::set_client_mode( true );
        std::string method = "CHOP_TREE";
        REQUIRE( cata_mp::client_activate_item( tool, method, here.get_abs( position ) ) );
        CHECK( here.ter( position ) == ter_t_tree );
        CHECK( who.get_moves() == moves );
        CHECK( capture_rng_state() == rng );
        CHECK( who.activity.execution() == activity_execution::presentation );
        cata_mp::set_client_mode( false );
    }
}

namespace
{
std::string plank_request( reload_fixture &fixture, Character &who, const item_location &tool,
                           const lumber_selection &selection )
{
    return fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", "LUMBER" );
        out.member( "target", who.pos_abs() );
        out.member( "lumber", selection );
    } );
}

item_location plank_log( Character &who )
{
    item &log = get_map().add_item_or_charges( who.pos_bub(), item( itype_log ) );
    return item_location( map_cursor( who.pos_abs() ), &log );
}
} // namespace

TEST_CASE( "plank_work_spends_only_the_selected_log_once_and_retains_native_cancellation_cost",
           "[mp_inventory_activity][chopping_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    item_location tool = chopping_tool( who );
    item_location first = plank_log( who );
    item_location selected = plank_log( who );
    const lumber_selection choice{ capture_item_source( who, selected ), false };
    const int host_moves = get_avatar().get_moves();
    const std::string start = plank_request( fixture, who, tool, choice );
    fixture.run( who, start );
    REQUIRE( who.activity.id() == ACT_CHOP_PLANKS );
    CHECK( who.activity.moves_total == to_moves<int>( 20_minutes ) );
    CHECK( first );
    CHECK_FALSE( selected );
    fixture.run( who, start );
    CHECK( first );
    save_reload_activity( who );
    who.set_moves( 0 );
    const std::string cancel = fixture.request( who, "cancel" );
    fixture.run( who, cancel );
    fixture.run( who, cancel );
    CHECK_FALSE( who.activity );
    CHECK( salvage_count( nullptr, get_map(), who.pos_bub(), itype_log ) == 1 );
    CHECK( salvage_count( nullptr, get_map(), who.pos_bub(), itype_2x4 ) == 0 );
    CHECK( get_avatar().get_moves() == host_moves );
}

TEST_CASE( "plank_choices_and_saved_work_do_not_adopt_another_source_or_operator",
           "[mp_inventory_activity][chopping_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    item_location tool = chopping_tool( who );
    const item_location log = plank_log( who );
    lumber_selection choice{ capture_item_source( who, log ), false };
    SECTION( "a missing log is rejected without spending the nearby one" ) {
        choice.log.path.back() += 1000000;
        fixture.run( who, plank_request( fixture, who, tool, choice ) );
        CHECK_FALSE( who.activity );
        CHECK( log );
    }
    SECTION( "another character's log cannot be submitted as the operator's" ) {
        avatar &other = get_avatar();
        other.set_wielded_item( item( itype_log ) );
        const item_location foreign = other.get_wielded_item();
        choice.log = capture_item_source( other, foreign );
        fixture.run( who, plank_request( fixture, who, tool, choice ) );
        CHECK_FALSE( who.activity );
        CHECK( foreign );
        CHECK( log );
    }
    SECTION( "unrelated choices cannot be smuggled into lumber activation" ) {
        item_activation_choices selected;
        selected.lumber = choice;
        selected.radio = 1;
        CHECK_FALSE( execute_owned_item_activation( who, tool, "LUMBER", who.pos_abs(), false,
                     false, selected ) );
        CHECK( log );
    }
    SECTION( "saved work cancels on source or owner displacement" ) {
        fixture.run( who, plank_request( fixture, who, tool, choice ) );
        REQUIRE( who.activity );
        save_reload_activity( who );
        const std::string changed = GENERATE( "tool", "origin", "operator" );
        who.activity.moves_left = 0;
        who.set_moves( 100 );
        if( changed == "operator" ) {
            avatar &other = get_avatar();
            other.setpos( here, who.pos_bub() );
            other.activity = who.activity;
            other.set_moves( 100 );
            other.activity.do_turn( other );
            CHECK_FALSE( other.activity );
            CHECK( who.activity );
        } else {
            if( changed == "tool" ) {
                who.set_wielded_item( item( itype_ax ) );
            } else {
                who.setpos( here, who.pos_bub() + point::east );
            }
            fixture.run( who, fixture.request( who, "step" ) );
            CHECK_FALSE( who.activity );
        }
        CHECK( salvage_count( nullptr, here, tripoint_bub_ms( 60, 60, 0 ), itype_2x4 ) == 0 );
    }
}

TEST_CASE( "plank_completion_keeps_native_yields_when_drop_callbacks_replace_or_retire_the_operator",
           "[mp_inventory_activity][chopping_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    const bool retire = GENERATE( false, true );
    item_location tool = chopping_tool( who );
    const item_location log = plank_log( who );
    fixture.run( who, plank_request( fixture, who, tool,
                                     { capture_item_source( who, log ), false } ) );
    REQUIRE( who.activity );
    save_reload_activity( who );
    const tripoint_bub_ms position = who.pos_bub();
    const std::string before_roll = capture_rng_state();
    int planks = normal_roll( 2 + who.get_skill_level( skill_fabrication ), 1 );
    const int waste = 10 - planks;
    const int scraps = rng( waste, waste * 3 );
    planks = std::max( 0, std::min( planks, 10 ) );
    restore_rng_state( before_roll );
    get_avatar().set_value( "expected_planks", std::to_string( planks ) );
    get_avatar().set_value( "expected_splinters", std::to_string( std::max( 0, scraps ) ) );
    who.set_value( "retire_plank_worker", retire ? "yes" : "no" );
    itype &plank = *const_cast<itype *>( item::find_type( itype_2x4 ) );
    itype &splinter = *const_cast<itype *>( item::find_type( itype_splinter ) );
    const restore_on_out_of_scope restore_plank( plank.drop_action );
    const restore_on_out_of_scope restore_splinter( splinter.drop_action );
    const use_function drop( "settled_planks", []( Character *actor, item *,
                             const tripoint_bub_ms &position ) -> std::optional<int> {
                                 REQUIRE( actor );
                                 CHECK( salvage_count( nullptr, get_map(), position, itype_log ) == 0 );
                                 CHECK( std::to_string( salvage_count( nullptr, get_map(), position, itype_2x4 ) ) ==
                                        get_avatar().get_value( "expected_planks" ).str() );
                                 CHECK( std::to_string( salvage_count( nullptr, get_map(), position, itype_splinter ) ) ==
                                        get_avatar().get_value( "expected_splinters" ).str() );
                                 get_avatar().set_value( "plank_drop_callback", "yes" );
    if( actor->get_value( "retire_plank_worker" ).str() == "yes" ) {
    g->remove_npc( actor->getID() );
    } else {
        actor->assign_activity( player_activity( ACT_WAIT, 100 ) );
    }
    return std::nullopt;
                             } );
    plank.drop_action = drop;
    splinter.drop_action = drop;
    // Invoke completion directly so the comparison uses the native yield rolls,
    // without unrelated turn processing consuming RNG before those two rolls.
    who.activity.actor->finish( who.activity, who );
    CHECK( get_avatar().get_value( "plank_drop_callback" ).str() == "yes" );
    CHECK( salvage_count( nullptr, here, position, itype_2x4 ) == planks );
    CHECK( salvage_count( nullptr, here, position, itype_splinter ) == std::max( 0, scraps ) );
    if( !retire ) {
        CHECK( who.activity.id() == ACT_WAIT );
    }
}

TEST_CASE( "plank_native_entry_and_client_selection_share_the_original_ground_log_preference",
           "[mp_inventory_activity][chopping_owned]" )
{
    reload_fixture fixture;
    avatar &who = get_avatar();
    item_location tool = chopping_tool( who );
    const item_location log = plank_log( who );
    SECTION( "native tool activation starts paid work without another material menu" ) {
        who.invoke_item( tool.get_item(), "LUMBER" );
        REQUIRE( who.activity.id() == ACT_CHOP_PLANKS );
        CHECK_FALSE( log );
        who.activity.moves_left = 1;
        who.set_moves( 1000 );
        who.activity.do_turn( who );
        CHECK_FALSE( who.activity );
        CHECK( salvage_count( nullptr, get_map(), who.pos_bub(), itype_log ) == 0 );
    }
    SECTION( "client sends the material identity without spending it" ) {
        const std::string before = capture_rng_state();
        const int moves = who.get_moves();
        cata_mp::set_client_mode( true );
        std::string method = "LUMBER";
        REQUIRE( cata_mp::client_activate_item( tool, method ) );
        CHECK( log );
        CHECK( who.get_moves() == moves );
        CHECK( capture_rng_state() == before );
        CHECK( who.activity.execution() == activity_execution::presentation );
        cata_mp::set_client_mode( false );
    }
    SECTION( "already-paid old saves can finish without spending another log" ) {
        JsonValue data = json_loader::from_string( R"({"moves":100})" );
        auto actor = chop_planks_activity_actor::deserialize( data );
        player_activity old( *actor );
        old.placement = who.pos_abs();
        who.assign_activity( old );
        REQUIRE( who.activity );
        who.activity.moves_left = 1;
        who.set_moves( 1000 );
        who.activity.do_turn( who );
        CHECK_FALSE( who.activity );
        CHECK( log );
    }
}

TEST_CASE( "plank_start_does_not_overwrite_an_activity_created_by_consuming_the_wielded_log",
           "[mp_inventory_activity][chopping_owned]" )
{
    reload_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_log ) );
    const item_location log = who.get_wielded_item();
    item_location tool = who.i_add( item( itype_ax ) );
    class replace_on_unwield : public event_subscriber {
            Character &owner;
        public:
            bool called = false;
            explicit replace_on_unwield( Character &who ) : owner( who ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( event.type() == event_type::character_wields_item &&
                    event.get<character_id>( "character" ) == owner.getID() &&
                    !owner.get_wielded_item() ) {
                    called = true;
                    owner.assign_activity( player_activity( ACT_WAIT, 100 ) );
                }
            }
    } events( who );
    const std::string start = plank_request( fixture, who, tool,
                              { capture_item_source( who, log ), false } );
    fixture.run( who, start );
    CHECK( events.called );
    CHECK_FALSE( log );
    CHECK( tool );
    CHECK( who.activity.id() == ACT_WAIT );
    fixture.run( who, start );
    CHECK( who.activity.id() == ACT_WAIT );
    CHECK( salvage_count( nullptr, get_map(), who.pos_bub(), itype_2x4 ) == 0 );
}

TEST_CASE( "tilling_uses_the_requesting_operator_and_original_ground_after_save",
           "[mp_inventory_activity][tilling_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_shovel ) );
    const item_location tool = who.get_wielded_item();
    const bool greenhouse = GENERATE( false, true );
    const tripoint_bub_ms position( 61, 60, 0 );
    here.ter_set( position, ter_str_id( greenhouse ? "t_greenhouse" : "t_dirt" ) );
    const int host_moves = get_avatar().get_moves();
    const std::string request = fixture.request( who, "start", [&]( JsonOut &out ) {
        out.member( "kind", "item_use" );
        out.member( "source", capture_item_source( who, tool ) );
        out.member( "item_type", tool->typeId() );
        out.member( "method", "MAKEMOUND" );
        out.member( "target", here.get_abs( position ) );
    } );
    fixture.run( who, request );
    REQUIRE( who.activity.id() == ACT_CHURN );
    CHECK( who.activity.moves_total == 18000 );
    save_reload_activity( who );
    SECTION( "complete and replay" ) {
        who.activity.moves_left = 1;
        who.set_moves( 1000 );
        const std::string step = fixture.request( who, "step" );
        fixture.run( who, step );
        CHECK_FALSE( who.activity );
        CHECK( here.ter( position ) == ter_str_id( greenhouse ? "t_greenhouse_tilled" : "t_dirtmound" ) );
        here.ter_set( position, ter_t_pavement );
        fixture.run( who, step );
        CHECK( here.ter( position ) == ter_t_pavement );
    }
    SECTION( "replaced ground is not overwritten by completed work" ) {
        here.ter_set( position, ter_t_pavement );
        who.activity.moves_left = 0;
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( here.ter( position ) == ter_t_pavement );
    }
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK_FALSE( get_avatar().activity );
}

TEST_CASE( "automatic_tilling_rechecks_native_capability_and_client_tilling_only_sends_a_target",
           "[mp_inventory_activity][tilling_owned]" )
{
    reload_fixture fixture;
    map &here = get_map();
    const tripoint_bub_ms position( 61, 60, 0 );
    here.ter_set( position, ter_t_dirt );
    SECTION( "automated work retains the native tool-independent DIG capability check" ) {
        npc &who = fixture.remote();
        who.set_wielded_item( item( itype_shovel ) );
        REQUIRE( start_tilling_work( who, item_location(), here.get_abs( position ), true ) );
        save_reload_activity( who );
        const bool lose_quality = GENERATE( false, true );
        if( lose_quality ) {
            who.set_wielded_item( item( itype_rock ) );
        }
        who.activity.moves_left = 1;
        who.set_moves( 100 );
        fixture.run( who, fixture.request( who, "step" ) );
        CHECK_FALSE( who.activity );
        CHECK( here.ter( position ) == ter_str_id( lose_quality ? "t_dirt" : "t_dirtmound" ) );
    }
    SECTION( "frontend neither changes soil nor starts native work" ) {
        avatar &who = get_avatar();
        who.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
        who.set_wielded_item( item( itype_shovel ) );
        who.set_moves( 100 );
        const item_location tool = who.get_wielded_item();
        const std::string rng = capture_rng_state();
        cata_mp::set_client_mode( true );
        std::string method = "MAKEMOUND";
        REQUIRE( cata_mp::client_activate_item( tool, method, here.get_abs( position ) ) );
        CHECK( here.ter( position ) == ter_t_dirt );
        CHECK( who.get_moves() == 100 );
        CHECK( capture_rng_state() == rng );
        CHECK( who.activity.execution() == activity_execution::presentation );
        cata_mp::set_client_mode( false );
    }
}

TEST_CASE( "kill_statistics_projection_is_private_and_changes_only_when_needed",
           "[multiplayer][mission]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    npc &other = spawn_npc( point_bub_ms( 64, 62 ), "test_talker" );
    cata_mp::remote_player_session &first = bind_feedback_player( remote, 'a', 701 );
    cata_mp::remote_player_session &second = bind_feedback_player( other, 'b', 702 );
    const mtype_id &killed = mon_zombie;
    get_avatar().get_kill_statistics().reset( { { killed, 8 } }, {} );
    remote.get_kill_statistics().reset( { { killed, 2 } }, {} );
    other.get_kill_statistics().reset( { { killed, 5 } }, {} );
    remote.kill_xp = 33;
    const auto read_count = []( const JsonObject & frame ) {
        return frame.get_object( "kill_tracker" ).get_object( "kills" ).get_int( "mon_zombie" );
    };
    const JsonObject first_frame = json_loader::from_string(
                                       cata_mp::serialize_remote_player_state( first ) ).get_object();
    CHECK( read_count( first_frame ) == 2 );
    CHECK( first_frame.get_object( "character_turn" ).get_int( "kill_xp" ) == 33 );
    const JsonObject second_frame = json_loader::from_string(
                                        cata_mp::serialize_remote_player_state( second ) ).get_object();
    CHECK( read_count( second_frame ) == 5 );
    remote.kill_xp = 34; // Other native effects can award XP without a kill.
    const JsonObject unchanged = json_loader::from_string(
                                     cata_mp::serialize_remote_player_state( first ) ).get_object();
    CHECK_FALSE( unchanged.has_member( "kill_tracker" ) );
    CHECK( unchanged.get_object( "character_turn" ).get_int( "kill_xp" ) == 34 );
    remote.get_kill_statistics().record_monster( killed );
    const JsonObject changed = json_loader::from_string(
                                   cata_mp::serialize_remote_player_state( first ) ).get_object();
    CHECK( read_count( changed ) == 3 );
    const JsonObject other_unchanged = json_loader::from_string(
                                           cata_mp::serialize_remote_player_state( second ) ).get_object();
    CHECK_FALSE( other_unchanged.has_member( "kill_tracker" ) );
    CHECK( get_avatar().get_kill_statistics().kill_count( killed ) == 8 );
}

TEST_CASE( "farming_requests_spend_the_operator_resources_and_reject_stale_or_replayed_choices",
           "[mp_inventory_activity][plant]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms plot = remote.pos_bub() + tripoint::east;
    const itype_id &seed_type = itype_test_seed_eoc;
    const itype_id &clean_water = itype_water_clean;
    const itype_id &fertilizer_type = itype_fertilizer_commercial;
    here.add_item( plot, item( seed_type ) );
    here.furn_set( plot, furn_f_planter_seed );
    item bottle( itype_bottle_plastic );
    REQUIRE( bottle.put_in( item( clean_water, calendar::turn, 2 ),
                            pocket_type::CONTAINER ).success() );
    remote.i_add( bottle );
    host.i_add( bottle );
    const farming_command choice = capture_farming_command( remote, here, here.get_abs( plot ),
                        farming_action::water );
    REQUIRE( choice.seed );
    const auto encode = [&]( const farming_command & command ) {
        return fixture.request( remote, "start", [&]( JsonOut & out ) {
            out.member( "kind", "farming" );
            out.member( "farm", command );
        } );
    };
    SECTION( "accepted_request_and_duplicate" ) {
        const std::string request = encode( choice );
        fixture.run( remote, request );
        CHECK( remote.charges_of( clean_water ) == 1 );
        CHECK( host.charges_of( clean_water ) == 2 );
        REQUIRE( iexamine::get_seed_at( here, plot ) );
        const int watered = iexamine::get_plant_water( *iexamine::get_seed_at( here, plot ) );
        CHECK( watered > 0 );
        fixture.run( remote, request );
        CHECK( remote.charges_of( clean_water ) == 1 );
        CHECK( iexamine::get_plant_water( *iexamine::get_seed_at( here, plot ) ) == watered );
    }
    SECTION( "same_type_replacement_is_a_different_crop" ) {
        here.i_clear( plot );
        here.add_item( plot, item( seed_type ) );
        fixture.run( remote, encode( choice ) );
        CHECK( remote.charges_of( clean_water ) == 2 );
        CHECK( iexamine::get_plant_water( *iexamine::get_seed_at( here, plot ) ) == 0 );
    }
    SECTION( "unauthorized_request_is_inert" ) {
        fixture.run( remote, encode( choice ), false );
        CHECK( remote.charges_of( clean_water ) == 2 );
        CHECK( iexamine::get_plant_water( *iexamine::get_seed_at( here, plot ) ) == 0 );
    }
    SECTION( "fertilizing_starts_an_authoritative_activity_without_host_ui" ) {
        item fertilizer( fertilizer_type );
        fertilizer.charges = 2;
        remote.i_add( fertilizer );
        farming_command fertilize = choice;
        fertilize.action = farming_action::fertilize;
        fertilize.material = fertilizer_type;
        fixture.run( remote, encode( fertilize ) );
        REQUIRE( remote.activity.id() == ACT_FERTILIZE_PLANT );
        CHECK( remote.activity.execution() == activity_execution::authoritative );
        CHECK_FALSE( host.activity );
        remote.activity.actor->finish( remote.activity, remote );
        CHECK( remote.charges_of( fertilizer_type ) == 1 );
        CHECK( iexamine::is_plant_fertilized( *iexamine::get_seed_at( here, plot ) ) );
    }
}

TEST_CASE( "wild_plant_requests_create_owned_work_and_reject_replayed_or_stale_targets",
           "[mp_inventory_activity][plant][forage]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms plot = remote.pos_bub() + tripoint::east;
    here.ter_set( plot, ter_t_underbrush );
    const farming_command choice = capture_farming_command( remote, here, here.get_abs( plot ),
                        farming_action::forage );
    const std::string request = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "farming" );
        out.member( "farm", choice );
    } );
    SECTION( "request_creates_only_the_remote_activity_and_duplicate_does_not_restart_it" ) {
        fixture.run( remote, request );
        REQUIRE( remote.activity.id() == ACT_FORAGE );
        CHECK( remote.activity.execution() == activity_execution::authoritative );
        CHECK_FALSE( host.activity );
        const std::uint64_t generation = remote.activity.identity_generation();
        const std::string random_before = capture_rng_state();
        fixture.run( remote, request );
        CHECK( remote.activity.identity_generation() == generation );
        CHECK( capture_rng_state() == random_before );
        remote.activity.actor->finish( remote.activity, remote );
        CHECK( here.ter( plot ) != ter_t_underbrush );
        CHECK_FALSE( host.activity );
    }
    SECTION( "changed_surface_is_rejected_before_any_work_or_random_draw" ) {
        here.ter_set( plot, ter_t_dirt );
        const std::string random_before = capture_rng_state();
        fixture.run( remote, request );
        CHECK_FALSE( remote.activity );
        CHECK( here.ter( plot ) == ter_t_dirt );
        CHECK( capture_rng_state() == random_before );
    }
    SECTION( "an_unauthorized_request_cannot_start_native_foraging" ) {
        fixture.run( remote, request, false );
        CHECK_FALSE( remote.activity );
        CHECK_FALSE( host.activity );
        CHECK( here.ter( plot ) == ter_t_underbrush );
    }
}

TEST_CASE( "special_vegetation_requests_settle_the_remote_choice_only_once",
           "[mp_inventory_activity][plant][ownership]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    map &here = get_map();
    host.setpos( here, remote.pos_bub() + tripoint( 5, 0, 0 ) );
    const tripoint_bub_ms plot = remote.pos_bub() + tripoint::east;
    SECTION( "nectar_choice_transfers_effects_and_cost_without_picking_the_flower" ) {
        const trait_id &proboscis = trait_PROBOSCIS;
        remote.set_mutation( proboscis );
        remote.activate_mutation( proboscis );
        remote.set_hunger( 100 );
        REQUIRE( iexamine_helper::can_drink_nectar( remote ) );
        here.furn_set( plot, furn_f_flower_marloss );
        farming_command choice = capture_farming_command( remote, here, here.get_abs( plot ),
                                 farming_action::flower );
        choice.drink = true;
        choice.pick = false;
        remote.set_moves( 100 );
        const std::string request = fixture.request( remote, "start", [&]( JsonOut &out ) {
            out.member( "kind", "farming" );
            out.member( "farm", choice );
        } );
        fixture.run( remote, request );
        const efftype_id &teleglow = effect_teleglow;
        CHECK( remote.get_moves() == 100 - to_moves<int>( 30_seconds ) );
        CHECK( remote.get_effect_dur( teleglow ) == 10_minutes );
        CHECK_FALSE( host.has_effect( teleglow ) );
        CHECK( here.furn( plot ) == furn_f_flower_marloss );
        CHECK( here.i_at( remote.pos_bub() ).empty() );
        const int moves_after = remote.get_moves();
        const std::string random_after = capture_rng_state();
        fixture.run( remote, request );
        CHECK( remote.get_moves() == moves_after );
        CHECK( capture_rng_state() == random_after );
    }
    SECTION( "fungal_flower_is_removed_before_native_spores_and_cannot_be_replayed" ) {
        here.furn_set( plot, furn_f_flower_fungal );
        const farming_command choice = capture_farming_command( remote, here, here.get_abs( plot ),
                            farming_action::fungus );
        const std::string request = fixture.request( remote, "start", [&]( JsonOut &out ) {
            out.member( "kind", "farming" );
            out.member( "farm", choice );
        } );
        fixture.run( remote, request );
        CHECK_FALSE( here.has_furn( plot ) );
        CHECK( remote.get_moves() == 100 - to_moves<int>( 1_seconds ) / 2 );
        CHECK_FALSE( host.has_effect( effect_spores ) );
        const std::string random_after = capture_rng_state();
        fixture.run( remote, request );
        CHECK( capture_rng_state() == random_after );
        CHECK( remote.get_moves() == 100 - to_moves<int>( 1_seconds ) / 2 );
    }
}


TEST_CASE( "maple_requests_refresh_selected_supplies_and_sap_destination",
           "[mp_inventory_activity][plant][maple][ownership]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    map &here = get_map();
    host.setpos( here, remote.pos_bub() + tripoint( 5, 0, 0 ) );
    const tripoint_bub_ms tree = remote.pos_bub() + tripoint::east;
    const tripoint_bub_ms supply = remote.pos_bub() + tripoint::west;
    const tripoint_bub_ms destination = remote.pos_bub() + tripoint::north;
    here.ter_set( tree, ter_t_tree_maple_tapped );
    here.add_item_unprocessed( tree, item( itype_tree_spile ) );
    item &bottle = here.add_item_unprocessed( supply, item( itype_bottle_plastic ) );
    item_location selected( map_cursor( supply ), &bottle );
    farming_command choice = capture_farming_command( remote, here, here.get_abs( tree ),
                                           farming_action::maple_add_container );
    const maple_tree_items before = inspect_maple_tree( here, here.get_abs( tree ) );
    REQUIRE( before.tap );
    choice.tap = capture_item_source( remote, before.tap );
    choice.container = capture_item_source( remote, selected );
    const int handling_cost = remote.item_handling_cost( *selected );
    const std::string add = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "farming" );
        out.member( "farm", choice );
    } );
    fixture.run( remote, add );
    REQUIRE( here.i_at( supply ).empty() );
    maple_tree_items installed = inspect_maple_tree( here, here.get_abs( tree ) );
    REQUIRE( installed.container );
    CHECK( remote.get_moves() == 100 - handling_cost );
    CHECK( std::find( fixture.reload.changed_tiles.begin(), fixture.reload.changed_tiles.end(),
                      here.get_abs( supply ) ) != fixture.reload.changed_tiles.end() );
    fixture.run( remote, add );
    CHECK( here.i_at( tree ).size() == 2 );
    CHECK( remote.get_moves() == 100 - handling_cost );

    // A second, freshly submitted selection cannot install another container.
    item &competitor = here.add_item_unprocessed( supply, item( itype_bottle_plastic ) );
    item_location competing( map_cursor( supply ), &competitor );
    choice.container = capture_item_source( remote, competing );
    remote.set_moves( 100 );
    fixture.run( remote, fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "farming" );
        out.member( "farm", choice );
    } ) );
    REQUIRE( competing );
    CHECK( remote.get_moves() == 100 );
    CHECK( here.i_at( tree ).size() == 2 );

    item sap( itype_maple_sap, calendar::turn, 2 );
    REQUIRE( installed.container->fill_with( sap, 2, true ) == 2 );
    const maple_tree_items filled = inspect_maple_tree( here, here.get_abs( tree ) );
    REQUIRE( filled.sap );
    item &receiver = here.add_item_unprocessed( destination, item( itype_bottle_plastic ) );
    item_location receiver_location( map_cursor( destination ), &receiver );
    choice.action = farming_action::maple_sap;
    choice.container = capture_item_source( remote, filled.container );
    unload_liquid_choice liquid;
    liquid.source = filled.sap->uid().get_value();
    liquid.kind = LD_ITEM;
    liquid.container = capture_item_source( remote, receiver_location );
    choice.sap_destination = liquid;
    const std::string collect = fixture.request( remote, "start", [&]( JsonOut &out ) {
        out.member( "kind", "farming" );
        out.member( "farm", choice );
    } );
    fixture.run( remote, collect );
    CHECK_FALSE( inspect_maple_tree( here, here.get_abs( tree ) ).sap );
    CHECK( receiver.charges_of( itype_maple_sap ) == 2 );
    CHECK( remote.get_moves() == 0 );
    CHECK( std::find( fixture.reload.changed_tiles.begin(), fixture.reload.changed_tiles.end(),
                      here.get_abs( destination ) ) != fixture.reload.changed_tiles.end() );
    fixture.run( remote, collect );
    CHECK( receiver.charges_of( itype_maple_sap ) == 2 );
    CHECK( remote.get_moves() == 0 );
}

TEST_CASE( "server_owned_dialogue_session_drives_mission_assignment_and_synchronizes_views",
           "[mp_inventory_activity][dialogue][mission]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    avatar &host = get_avatar();
    map &here = get_map();
    host.reset_all_missions();
    remote.reset_all_missions();
    mission::clear_all();
    const on_out_of_scope cleanup_missions( [&]() {
        remote.reset_all_missions();
        host.reset_all_missions();
        mission::clear_all();
    } );

    npc &provider = spawn_npc( { 60, 61 }, "test_talker" );
    provider.setpos( here, remote.pos_bub() + tripoint::east );
    provider.set_hunger( 0 );
    provider.set_thirst( 0 );
    provider.set_sleepiness( 0 );
    provider.set_mutation( trait_WEB_WEAVER );
    provider.chatbin.first_topic = "TALK_MISSION_LIST";

    const mission_type_id &test_mission_id = mission_TEST_MISSION_GENERIC_REWARD;
    mission_type &definition = const_cast<mission_type &>( test_mission_id.obj() );
    const restore_on_out_of_scope restore_start( definition.start );
    const restore_on_out_of_scope restore_dialogue( definition.dialogue );
    definition.start = []( mission *, Character & ) {};
    definition.dialogue["offer"] = no_translation( "Test mission offer" );
    definition.dialogue["accepted"] = no_translation( "Test mission accepted" );
    mission *task = mission::reserve_new( test_mission_id, provider.getID() );
    REQUIRE( task != nullptr );
    provider.chatbin.missions = { task };
    const uint64_t initial_generation = task->identity_generation();

    std::ostringstream npc_view_stream;
    JsonOut npc_view_out( npc_view_stream );
    std::string cached_appearance;
    cata_mp::write_npc_view( npc_view_out, provider, remote, cached_appearance );
    const JsonValue parsed_npc = json_loader::from_string( npc_view_stream.str() );
    auto &replica_ptr = g->multiplayer_session().client_npc_views[provider.getID()];
    replica_ptr = std::make_unique<cata_mp::npc_view>();
    cata_mp::npc_view &replica_entry = *replica_ptr;
    replica_entry.host_id = provider.getID();
    cata_mp::apply_npc_view( parsed_npc.get_object(), replica_entry );
    npc *replica_actor = replica_entry.actor.retained( g->npc_lifetimes() );
    REQUIRE( replica_actor != nullptr );
    CHECK( cata_mp::host_npc_identity( *replica_actor ) == provider.getID() );
    cata_mp::remove_npc_view( replica_entry );
    g->multiplayer_session().client_npc_views.clear();

    const std::string start_req = fixture.request( remote, "start", [&]( JsonOut & out ) {
        out.member( "kind", "dialogue" );
        out.member( "target_npc", provider.getID().get_value() );
        out.member( "target", provider.pos_abs() );
    } );
    const std::string start_reply = fixture.run( remote, start_req );
    REQUIRE( fixture.reload.dialogue_session != nullptr );
    JsonValue start_val = json_loader::from_string( start_reply );
    JsonObject start_obj = start_val.get_object();
    start_obj.allow_omitted_members();
    const std::string activity_id = start_obj.get_string( "activity" );
    CHECK( activity_id == "dialogue:1" );
    REQUIRE( start_obj.has_object( "dialogue_prompt" ) );
    cata_mp::dialogue_view_prompt prompt1;
    start_obj.read( "dialogue_prompt", prompt1, true );
    CHECK( prompt1.session_id == 1 );
    CHECK( prompt1.response_revision > 0 );
    REQUIRE_FALSE( prompt1.options.empty() );
    CHECK( prompt1.options.front().text == "Tell me about it." );
    CHECK( prompt1.options.front().selectable );

    const std::string opinion_req = fixture.request( remote, "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( prompt1.session_id ) );
        out.member( "response_revision", static_cast<int64_t>( prompt1.response_revision ) );
        out.member( "special_action", "CHECK_OPINION" );
    }, activity_id );
    const std::string opinion_reply = fixture.run( remote, opinion_req );
    REQUIRE( fixture.reload.dialogue_session != nullptr );
    JsonValue opinion_val = json_loader::from_string( opinion_reply );
    JsonObject opinion_obj = opinion_val.get_object();
    opinion_obj.allow_omitted_members();
    cata_mp::dialogue_view_prompt opinion_prompt;
    opinion_obj.read( "dialogue_prompt", opinion_prompt, true );
    CHECK( opinion_prompt.response_revision > prompt1.response_revision );
    REQUIRE_FALSE( opinion_prompt.options.empty() );

    const std::string back_req = fixture.request( remote, "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( opinion_prompt.session_id ) );
        out.member( "response_revision", static_cast<int64_t>( opinion_prompt.response_revision ) );
        out.member( "response_index", 0 );
    }, activity_id );
    const std::string back_reply = fixture.run( remote, back_req );
    JsonValue back_val = json_loader::from_string( back_reply );
    JsonObject back_obj = back_val.get_object();
    back_obj.allow_omitted_members();
    cata_mp::dialogue_view_prompt list_prompt;
    back_obj.read( "dialogue_prompt", list_prompt, true );
    REQUIRE_FALSE( list_prompt.options.empty() );
    CHECK( list_prompt.options.front().text == "Tell me about it." );

    const std::string offer_req = fixture.request( remote, "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( list_prompt.session_id ) );
        out.member( "response_revision", static_cast<int64_t>( list_prompt.response_revision ) );
        out.member( "response_index", 0 );
    }, activity_id );
    const std::string offer_reply = fixture.run( remote, offer_req );
    JsonValue offer_val = json_loader::from_string( offer_reply );
    JsonObject offer_obj = offer_val.get_object();
    offer_obj.allow_omitted_members();
    cata_mp::dialogue_view_prompt offer_prompt;
    offer_obj.read( "dialogue_prompt", offer_prompt, true );
    REQUIRE_FALSE( offer_prompt.options.empty() );
    CHECK( offer_prompt.options.front().text == "I'll do it!" );

    const std::string accept_req = fixture.request( remote, "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( offer_prompt.session_id ) );
        out.member( "response_revision", static_cast<int64_t>( offer_prompt.response_revision ) );
        out.member( "response_index", 0 );
    }, activity_id );
    const std::string accept_reply = fixture.run( remote, accept_req );
    CHECK( task->get_assigned_player_id() == remote.getID() );
    CHECK( remote.get_active_missions() == std::vector<mission *> { task } );
    CHECK( host.get_active_missions().empty() );

    JsonValue accept_val = json_loader::from_string( accept_reply );
    JsonObject accept_obj = accept_val.get_object();
    accept_obj.allow_omitted_members();
    REQUIRE( accept_obj.has_object( "missions" ) );
    cata_mp::apply_mission_view( accept_obj.get_object( "missions" ), host );
    CHECK( host.get_active_missions() == std::vector<mission *> { task } );
    CHECK( task->identity_generation() == initial_generation );

    cata_mp::dialogue_view_prompt accepted_prompt;
    accept_obj.read( "dialogue_prompt", accepted_prompt, true );
    const auto done_it = std::find_if( accepted_prompt.options.begin(), accepted_prompt.options.end(),
    []( const cata_mp::dialogue_view_option & opt ) {
        return opt.quit_candidate;
    } );
    REQUIRE( done_it != accepted_prompt.options.end() );
    const int done_index = static_cast<int>( std::distance( accepted_prompt.options.begin(),
                           done_it ) );
    const std::string done_req = fixture.request( remote, "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( accepted_prompt.session_id ) );
        out.member( "response_revision", static_cast<int64_t>( accepted_prompt.response_revision ) );
        out.member( "response_index", done_index );
    }, activity_id );
    const std::string done_reply = fixture.run( remote, done_req );
    CHECK( fixture.reload.dialogue_session == nullptr );
    JsonValue done_val = json_loader::from_string( done_reply );
    JsonObject done_obj = done_val.get_object();
    done_obj.allow_omitted_members();
    CHECK( done_obj.get_string( "activity" ).empty() );
    CHECK_FALSE( done_obj.has_object( "dialogue_prompt" ) );
}

TEST_CASE( "server_owned_dialogue_rejects_stale_revisions_debug_bypass_and_proxy_targets",
           "[mp_inventory_activity][dialogue][security]" )
{
    reload_fixture fixture;
    npc &remote = fixture.remote();
    map &here = get_map();

    npc &proxy_peer = spawn_npc( { 60, 61 }, "test_talker" );
    proxy_peer.set_value( "mp_proxy", std::string( "1" ) );
    proxy_peer.setpos( here, remote.pos_bub() + tripoint::east );

    fixture.run( remote, fixture.request( remote, "start", [&]( JsonOut & out ) {
        out.member( "kind", "dialogue" );
        out.member( "target_npc", proxy_peer.getID().get_value() );
    } ) );
    CHECK( fixture.reload.dialogue_session == nullptr );

    npc &provider = spawn_npc( { 60, 62 }, "test_talker" );
    provider.setpos( here, remote.pos_bub() + tripoint::north );
    provider.set_hunger( 0 );
    provider.set_thirst( 0 );
    provider.set_sleepiness( 0 );
    provider.set_mutation( trait_WEB_WEAVER );
    provider.chatbin.first_topic = "TALK_TEST_SHOW_ALWAYS";

    fixture.run( remote, fixture.request( remote, "start", [&]( JsonOut & out ) {
        out.member( "kind", "dialogue" );
        out.member( "target_npc", provider.getID().get_value() );
        out.member( "debug_topic", "TALK_DONE" );
    } ) );
    CHECK( fixture.reload.dialogue_session == nullptr );

    const std::string start_reply = fixture.run( remote, fixture.request( remote, "start",
    [&]( JsonOut & out ) {
        out.member( "kind", "dialogue" );
        out.member( "target_npc", provider.getID().get_value() );
    } ) );
    REQUIRE( fixture.reload.dialogue_session != nullptr );
    JsonValue start_val = json_loader::from_string( start_reply );
    JsonObject start_obj = start_val.get_object();
    start_obj.allow_omitted_members();
    const std::string activity_id = start_obj.get_string( "activity" );
    cata_mp::dialogue_view_prompt prompt;
    start_obj.read( "dialogue_prompt", prompt, true );
    REQUIRE( prompt.options.size() >= 2 );
    CHECK_FALSE( prompt.options[0].selectable );
    CHECK( prompt.options[1].selectable );

    const auto read_revision = []( const std::string & reply ) {
        JsonValue val = json_loader::from_string( reply );
        JsonObject obj = val.get_object();
        obj.allow_omitted_members();
        cata_mp::dialogue_view_prompt next;
        obj.read( "dialogue_prompt", next, true );
        return next.response_revision;
    };

    const std::string rng_before = capture_rng_state();
    const std::string unselectable_reply = fixture.run( remote,
    fixture.request( remote, "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( prompt.session_id ) );
        out.member( "response_revision", static_cast<int64_t>( prompt.response_revision ) );
        out.member( "response_index", 0 );
    }, activity_id ) );
    REQUIRE( fixture.reload.dialogue_session != nullptr );
    CHECK( read_revision( unselectable_reply ) == prompt.response_revision );
    CHECK( capture_rng_state() == rng_before );

    const std::string bypass_reply = fixture.run( remote,
    fixture.request( remote, "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( prompt.session_id ) );
        out.member( "response_revision", static_cast<int64_t>( prompt.response_revision ) );
        out.member( "response_index", 0 );
        out.member( "debug_allow_unavailable", true );
    }, activity_id ) );
    REQUIRE( fixture.reload.dialogue_session != nullptr );
    CHECK( read_revision( bypass_reply ) == prompt.response_revision );

    const std::string stale_reply = fixture.run( remote,
    fixture.request( remote, "choose", [&]( JsonOut & out ) {
        out.member( "dialogue_session", static_cast<int64_t>( prompt.session_id ) );
        out.member( "response_revision", static_cast<int64_t>( prompt.response_revision + 99 ) );
        out.member( "response_index", 1 );
    }, activity_id ) );
    REQUIRE( fixture.reload.dialogue_session != nullptr );
    CHECK( read_revision( stale_reply ) == prompt.response_revision );

    remote.set_moves( 0 );
    const std::string cancel_reply = fixture.run( remote,
                                     fixture.request( remote, "cancel", {}, activity_id ) );
    CHECK( fixture.reload.dialogue_session == nullptr );
    JsonValue cancel_val = json_loader::from_string( cancel_reply );
    JsonObject cancel_obj = cancel_val.get_object();
    cancel_obj.allow_omitted_members();
    CHECK( cancel_obj.get_string( "activity" ).empty() );
}
