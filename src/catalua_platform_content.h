#pragma once
#ifndef CATA_SRC_CATALUA_PLATFORM_CONTENT_H
#define CATA_SRC_CATALUA_PLATFORM_CONTENT_H

#include <array>
#include <cstddef>
#include <cstdint>
#include <string>
#include <utility>
#include <vector>

template<typename T>
class generic_factory;

class ascii_art;
struct add_type;
struct character_modifier;
struct attack_vector;
class bash_damage_profile;
class anatomy;
struct body_part_type;
struct bodygraph;
struct clothing_mod;
struct damage_type;
struct damage_info_order;
struct construction_category;
struct construction_group;
struct connect_group;
struct crafting_category;
class disease_type;
class emit;
class effect_type;
class fault_group;
class harvest_drop_type;
class harvest_list;
class item_category;
class json_flag;
struct map_extra_collection;
class map_extra;
class weather_generator;
struct shopkeeper_blacklist;
struct shopkeeper_whitelist;
struct shopkeeper_cons_rates;
struct overmap_special_migration;
class material_type;
class mattack_actor;
class monfaction;
struct mtype;
struct mtype_special_attack;
struct mon_flag;
struct mutation_category_trait;
class mood_face;
class move_mode;
class overmap_land_use_code;
struct overmap_location;
class oter_vision;
struct limb_score;
class magic_type;
class ma_technique;
class martialart;
struct trap;
struct construction;
struct furn_t;
struct ter_t;
struct gate_data;
class fault;
class fault_fix;
struct dream;
class achievement;
class proficiency;
struct proficiency_category;
struct profession_group;
struct quality;
class butchery_requirements;
class item_action;
class scenario;
class overmap_connection;
class scent_type;
class score;
class start_location;
class climbing_aid;
class speed_description;
class vitamin;
class vpart_category;
class vpart_location;
class weapon_category;
class zone_type;
struct weather_type;
struct end_screen;
class morale_type_data;
class VehicleGroup;
struct species_type;
struct sub_body_part_type;
struct weakpoints;
class wound_fix;
class wound_type;
class faction_template;
class npc_class;
struct oter_t;
struct oter_type_t;
class overmap_special;
class vpart_info;
struct vehicle_prototype;

namespace behavior
{
class node_t;
} // namespace behavior

namespace cata::lua_platform::detail
{

/** Internal native registries used by the Lua-first content transaction. */
generic_factory<ascii_art> &ascii_art_registry();
generic_factory<add_type> &addiction_type_registry();
generic_factory<character_modifier> &character_modifier_registry();
generic_factory<start_location> &start_location_registry();
generic_factory<climbing_aid> &climbing_aid_registry();
void refresh_climbing_aid_registry();
generic_factory<weather_type> &weather_type_registry();
generic_factory<end_screen> &end_screen_registry();
generic_factory<attack_vector> &attack_vector_registry();
void refresh_attack_vector_registry();
generic_factory<ma_technique> &ma_technique_registry();
generic_factory<martialart> &martialart_registry();
generic_factory<trap> &trap_registry();
generic_factory<construction> &construction_registry();
generic_factory<furn_t> &furniture_registry();
generic_factory<ter_t> &terrain_registry();
generic_factory<gate_data> &gate_registry();
generic_factory<fault> &fault_registry();
generic_factory<fault_fix> &fault_fix_registry();
void append_dream( const dream &value );
std::size_t dream_count();
void truncate_dreams( std::size_t count );
struct platform_achievement_data {
    std::string id;
    std::string name;
    std::string description;
    bool is_conduct = false;
    std::vector<std::string> hidden_by;
};
struct platform_blacklist_data {
    std::string kind;
    bool whitelist = false;
    std::vector<std::string> entries;
    bool registered = false;
};
struct platform_migration_data {
    std::string kind;
    std::string from_id;
    std::string to_id;
    bool registered = false;
};
void insert_platform_savegame_migration( const platform_migration_data &value );
void erase_platform_savegame_migration( const platform_migration_data &value );
void insert_platform_bionic_migration( const platform_migration_data &value );
void erase_platform_bionic_migration( const platform_migration_data &value );
void insert_platform_effect_migration( const platform_migration_data &value );
void erase_platform_effect_migration( const platform_migration_data &value );
void insert_platform_proficiency_migration( const platform_migration_data &value );
void erase_platform_proficiency_migration( const platform_migration_data &value );
void insert_platform_vpart_migration( const platform_migration_data &value );
void erase_platform_vpart_migration( const platform_migration_data &value );
void insert_platform_var_migration( const platform_migration_data &value );
void erase_platform_var_migration( const platform_migration_data &value );
void insert_platform_oter_migration( const platform_migration_data &value );
void erase_platform_oter_migration( const platform_migration_data &value );

// Deterministic whole-registry snapshots (sorted by from id) of the legacy
// migration tables, used by the semantic parity gate to compare the
// JSON-loaded maps against the committed Migrated_Core replacements.
std::vector<std::pair<std::string, std::string>> effect_migration_snapshot();
std::vector<std::pair<std::string, std::string>> oter_migration_snapshot();
std::vector<std::pair<std::string, std::string>> proficiency_migration_snapshot();
std::vector<std::pair<std::string, std::string>> vehicle_part_migration_snapshot();
std::vector<std::pair<std::string, std::string>> terrain_migration_snapshot();
std::vector<std::pair<std::string, std::string>> furniture_migration_snapshot();
std::vector<std::pair<std::string, std::string>> trap_migration_snapshot();
std::vector<std::pair<std::string, std::string>> var_migration_snapshot();
std::vector<std::string> charge_removal_blacklist_snapshot();
std::vector<std::string> temperature_removal_blacklist_snapshot();

void insert_platform_trait_blacklist( const std::vector<std::string> &entries );
void insert_platform_item_blacklist( const platform_blacklist_data &value );
void truncate_platform_item_blacklist( std::size_t count );
std::size_t platform_item_blacklist_count();
void insert_platform_scenario_blacklist( const platform_blacklist_data &value );
void insert_platform_profession_blacklist( const platform_blacklist_data &value );
void erase_platform_profession_blacklist( const platform_blacklist_data &value );
struct platform_trait_group_entry {
    std::string id;
    std::int64_t weight = 100;
    bool group = false;
    std::string variant;
};
void insert_platform_trait_group(
    const std::string &id,
    const std::vector<platform_trait_group_entry> &entries );
void erase_platform_trait_group( const std::string &id );
void append_platform_monster_adjustment( const std::string &species,
                                         const std::string &stat,
                                         double stat_adjust,
                                         const std::string &flag, bool flag_val,
                                         const std::string &special );
std::size_t platform_monster_adjustment_count();
void truncate_platform_monster_adjustments( std::size_t count );
void erase_platform_scenario_blacklist( const platform_blacklist_data &value );
void insert_platform_savegame_blacklist( const platform_blacklist_data &value );
void erase_platform_savegame_blacklist( const platform_blacklist_data &value );
void erase_platform_trait_blacklist( const std::vector<std::string> &entries );
void insert_platform_monster_blacklist( const std::vector<std::string> &entries,
                                        bool whitelist );
void erase_platform_monster_blacklist( const std::vector<std::string> &entries,
                                       bool whitelist );
generic_factory<map_extra> &map_extra_registry();
generic_factory<weather_generator> &weather_generator_registry();
generic_factory<shopkeeper_blacklist> &shopkeeper_blacklist_registry();
generic_factory<shopkeeper_whitelist> &shopkeeper_whitelist_registry();
generic_factory<shopkeeper_cons_rates> &shopkeeper_cons_rates_registry();
generic_factory<overmap_special_migration> &overmap_special_migration_registry();
generic_factory<achievement> &achievement_registry();
generic_factory<magic_type> &magic_type_registry();
generic_factory<bash_damage_profile> &bash_damage_profile_registry();
generic_factory<clothing_mod> &clothing_mod_registry();
void refresh_clothing_mod_registry_cache();
generic_factory<overmap_land_use_code> &overmap_land_use_code_registry();
generic_factory<oter_vision> &overmap_vision_registry();
generic_factory<overmap_location> &overmap_location_registry();
generic_factory<profession_group> &profession_group_registry();
generic_factory<map_extra_collection> &map_extra_collection_registry();
generic_factory<fault_group> &fault_group_registry();
generic_factory<quality> &tool_quality_registry();
generic_factory<vitamin> &vitamin_registry();
generic_factory<material_type> &material_registry();
generic_factory<damage_type> &damage_type_registry();
generic_factory<damage_info_order> &damage_info_order_registry();
void refresh_damage_info_order_registry();
generic_factory<json_flag> &json_flag_registry();
generic_factory<item_category> &item_category_registry();
generic_factory<crafting_category> &crafting_category_registry();
generic_factory<weapon_category> &weapon_category_registry();
generic_factory<proficiency_category> &proficiency_category_registry();
generic_factory<proficiency> &proficiency_registry();
generic_factory<scent_type> &scent_type_registry();
generic_factory<butchery_requirements> &butchery_requirements_registry();
generic_factory<scenario> &scenario_registry();
generic_factory<overmap_connection> &overmap_connection_registry();
generic_factory<score> &score_registry();
generic_factory<speed_description> &speed_description_registry();
generic_factory<harvest_drop_type> &harvest_drop_type_registry();
generic_factory<harvest_list> &harvest_list_registry();
generic_factory<behavior::node_t> &behavior_registry();
generic_factory<weakpoints> &weakpoint_set_registry();
generic_factory<body_part_type> &body_part_registry();
void refresh_body_part_similarity_cache();
void refresh_body_part_wound_cache();
generic_factory<sub_body_part_type> &sub_body_part_registry();
void refresh_sub_body_part_similarity_cache();
generic_factory<wound_type> &wound_type_registry();
generic_factory<wound_fix> &wound_fix_registry();
void refresh_wound_fix_links();
generic_factory<anatomy> &anatomy_registry();
generic_factory<bodygraph> &bodygraph_registry();
generic_factory<morale_type_data> &morale_type_registry();
generic_factory<move_mode> &movement_mode_registry();
std::vector<faction_template> &faction_template_registry();
generic_factory<npc_class> &npc_class_registry();
generic_factory<oter_type_t> &overmap_terrain_type_registry();
generic_factory<oter_t> &overmap_terrain_registry();
generic_factory<overmap_special> &overmap_special_registry();
generic_factory<vpart_info> &vehicle_part_registry();
generic_factory<vehicle_prototype> &vehicle_prototype_registry();
void refresh_movement_mode_registry();
generic_factory<zone_type> &zone_type_registry();
generic_factory<disease_type> &disease_type_registry();
generic_factory<mon_flag> &monster_flag_registry();
generic_factory<species_type> &species_registry();
generic_factory<mtype> &monster_type_registry();
const mtype_special_attack *monster_attack_registry_find( const std::string &id );
void monster_attack_registry_set( const mtype_special_attack &value );
void monster_attack_registry_erase( const std::string &id );
generic_factory<monfaction> &monster_faction_registry();
const emit *emission_registry_find( const std::string &id );
void emission_registry_set( const emit &value );
void emission_registry_erase( const std::string &id );
const effect_type *effect_type_registry_find( const std::string &id );
void effect_type_registry_set( const effect_type &value );
void effect_type_registry_erase( const std::string &id );
generic_factory<mood_face> &mood_face_registry();
generic_factory<limb_score> &limb_score_registry();
generic_factory<construction_category> &construction_category_registry();
generic_factory<construction_group> &construction_group_registry();
const connect_group *connect_group_registry_find( const std::string &id );
std::size_t connect_group_registry_size();
void connect_group_registry_set( const connect_group &value );
void connect_group_registry_erase( const std::string &id );
const mutation_category_trait *mutation_category_registry_find( const std::string &id );
void mutation_category_registry_set( const mutation_category_trait &value );
void mutation_category_registry_erase( const std::string &id );
generic_factory<vpart_location> &vehicle_part_location_registry();
const vpart_category *vehicle_part_category_registry_find( const std::string &id );
void vehicle_part_category_registry_set( const vpart_category &value );
void vehicle_part_category_registry_erase( const std::string &id );
void vehicle_part_category_registry_finalize();
bool mutation_type_registry_contains( const std::string &id );
void mutation_type_registry_set( const std::string &id );
void mutation_type_registry_erase( const std::string &id );

const VehicleGroup *vehicle_group_registry_find( const std::string &id );
void vehicle_group_registry_set( const std::string &id, const VehicleGroup &value );
void vehicle_group_registry_erase( const std::string &id );

struct named_color_native_definition {
    std::string name;
    std::uint8_t red = 0;
    std::uint8_t green = 0;
    std::uint8_t blue = 0;
    std::uint8_t alpha = 255;
};

std::vector<named_color_native_definition> named_color_registry_snapshot();
bool named_color_registry_contains( const std::string &name );
bool named_color_registry_color_in_use( const named_color_native_definition &value,
                                        const std::string &except_name );
void named_color_registry_set( const named_color_native_definition &value );
void named_color_registry_restore(
    const std::vector<named_color_native_definition> &snapshot );

struct rotatable_symbol_native_entry {
    std::uint32_t symbol = 0;
    std::array<std::uint32_t, 3> rotations = {};
};

std::vector<rotatable_symbol_native_entry> rotatable_symbol_registry_snapshot();
std::vector<std::uint32_t> rotatable_symbol_registry_group( std::uint32_t symbol );
void rotatable_symbol_registry_set( const std::vector<std::uint32_t> &symbols );
void rotatable_symbol_registry_restore(
    const std::vector<rotatable_symbol_native_entry> &snapshot );

} // namespace cata::lua_platform::detail

#endif // CATA_SRC_CATALUA_PLATFORM_CONTENT_H
