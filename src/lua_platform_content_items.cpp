#include "lua_platform_content_items.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <body_part_set.h>
#include <character_id.h>
#include <clone_ptr.h>
#include <common_types.h>
#include <damage.h>
#include <enum_bitset.h>
#include <enums.h>
#include <explosion.h>
#include <fire.h>
#include <flat_set.h>
#include <game_constants.h>
#include <iexamine.h>
#include <item_pocket.h>
#include <item_uid.h>
#include <lua_platform_hooks.h>
#include <magic.h>
#include <mapgen_primitives.h>
#include <math_parser_diag_value.h>
#include <memory_fast.h>
#include <monster_uid.h>
#include <npc_opinion.h>
#include <overmap_ui.h>
#include <pimpl.h>
#include <pocket_type.h>
#include <point.h>
#include <sleep.h>
#include <stomach.h>
#include <value_ptr.h>
#include <vehicle_uid.h>
#include <weighted_list.h>
#include <bitset>
#include <exception>
#include <initializer_list>
#include <iterator>
#include <list>

namespace cata::lua_platform::detail
{
struct event_statistic_snapshot;
struct event_transformation_snapshot;
}  // namespace cata::lua_platform::detail

#include <algorithm>
#include <array>
#include <cctype>
#include <cmath>
#include <cstdint>
#include <filesystem>
#include <functional>
#include <iomanip>
extern "C" {
#include <lua.h>
}
#include <limits>
#include <map>
#include <random>
#include <set>
#include <sstream>
#include <stdexcept>
#include <system_error>
#include <tuple>
#include <type_traits>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <variant>

#include "achievement.h"
#include "activity_actor.h"
#include "activity_handlers.h"
#include "activity_type.h"
#include "addiction.h"
#include "ammo.h"
#include "ammo_effect.h"
#include "anatomy.h"
#include "ascii_art.h"
#include "avatar.h"
#include "behavior.h"
#include "behavior_oracle.h"
#include "behavior_strategy.h"
#include "bionics.h"
#include "bodygraph.h"
#include "bodypart.h"
#include "butchery.h"
#include "butchery_requirements.h"
#include "calendar.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "cata_variant.h"
#include "catacharset.h"
#include "character.h"
#include "character_martial_arts.h"
#include "character_modifier.h"
#include "city.h"
#include "climbing.h"
#include "clothing_mod.h"
#include "clzones.h"
#include "color.h"
#include "computer.h"
#include "construction.h"
#include "construction_category.h"
#include "construction_group.h"
#include "coordinates.h"
#include "crafting_gui.h"
#include "creature.h"
#include "creature_tracker.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "disease.h"
#include "effect.h"
#include "emit.h"
#include "end_screen.h"
#include "enum_conversions.h"
#include "event.h"
#include "event_bus.h"
#include "event_field_transformations.h"
#include "event_statistics.h"
#include "event_subscriber.h"
#include "explosion_light.h"
#include "faction_camp.h"
#include "fault.h"
#include "field.h"
#include "field_type.h"
#include "filesystem.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "gates.h"
#include "generic_factory.h"
#include "harvest.h"
#include "help.h"
#include "hsv_color.h"
#include "init.h"
#include "item.h"
#include "item_action.h"
#include "item_category.h"
#include "item_factory.h"
#include "item_group.h"
#include "item_location.h"
#include "item_wakeup.h"
#include "itype.h"
#include "iuse.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_achievements.h"
#include "lua_platform_activities.h"
#include "lua_platform_addictions.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_bionics.h"
#include "lua_platform_camps.h"
#include "lua_platform_content.h"
#include "lua_platform_content_presentation.h"
#include "lua_platform_crafting.h"
#include "lua_platform_creatures.h"
#include "lua_platform_dialogue.h"
#include "lua_platform_effects.h"
#include "lua_platform_factions.h"
#include "lua_platform_handle.h"
#include "lua_platform_hordes.h"
#include "lua_platform_interaction.h"
#include "lua_platform_items.h"
#include "lua_platform_magic.h"
#include "lua_platform_mapgen.h"
#include "lua_platform_martial_arts.h"
#include "lua_platform_missions.h"
#include "lua_platform_mutations.h"
#include "lua_platform_needs.h"
#include "lua_platform_npcs.h"
#include "lua_platform_overmap.h"
#include "lua_platform_proficiencies.h"
#include "lua_platform_registry.h"
#include "lua_platform_skills.h"
#include "lua_platform_snapshots.h"
#include "lua_platform_state.h"
#include "lua_platform_statistics.h"
#include "lua_platform_time.h"
#include "lua_platform_trade.h"
#include "lua_platform_variables.h"
#include "lua_platform_vehicles.h"
#include "lua_platform_vitamins.h"
#include "lua_platform_weather.h"
#include "lua_platform_world.h"
#include "lua_platform_world_content.h"
#include "lua_platform_world_info.h"
#include "lua_platform_world_services.h"
#include "lua_platform_zones.h"
#include "magic_enchantment.h"
#include "magic_ter_furn_transform.h"
#include "magic_type.h"
#include "map.h"
#include "map_accessories.h"
#include "map_extras.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "mapgen.h"
#include "mapgen_functions.h"
#include "mapgen_post_process.h"
#include "mapgendata.h"
#include "martialarts.h"
#include "material.h"
#include "math_parser.h"
#include "math_parser_diag.h"
#include "math_parser_jmath.h"
#include "mattack_actors.h"
#include "mattack_common.h"
#include "messages.h"
#include "mission.h"
#include "mod_tileset.h"
#include "mondefense.h"
#include "monfaction.h"
#include "mongroup.h"
#include "monster.h"
#include "monstergenerator.h"
#include "mood_face.h"
#include "morale_types.h"
#include "move_mode.h"
#include "mtype.h"
#include "mutation.h"
#include "npc.h"
#include "omdata.h"
#include "options.h"
#include "output.h"
#include "overlay_ordering.h"
#include "overmap_connection.h"
#include "overmap_location.h"
#include "overmap_map_data_cache.h"
#include "overmap_worldgen.h"
#include "path_info.h"
#include "player_activity.h"
#include "profession.h"
#include "profession_group.h"
#include "proficiency.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "recipe_groups.h"
#include "regional_settings.h"
#include "relic.h"
#include "requirements.h"
#include "safe_reference.h"
#include "scenario.h"
#include "scent_map.h"
#include "shop_cons_rate.h"
#include "skill.h"
#include "sounds.h"
#include "speech.h"
#include "speed_description.h"
#include "start_location.h"
#include "string_input_popup.h"
#include "subbodypart.h"
#include "talker.h"
#include "text_snippets.h"
#include "translation.h"
#include "trap.h"
#include "type_id.h"
#include "uilist.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vehicle_group.h"
#include "vehicle_palette.h"
#include "vehicle_part_location.h"
#include "vitamin.h"
#include "weakpoint.h"
#include "weather_gen.h"
#include "weather_type.h"
#include "widget.h"
#include "worldfactory.h"
#include "wound.h"

namespace cata::lua_platform
{

namespace
{

enum class definition_operation : int { add, replace, edit, extend };
enum class handle_lifecycle : int { building, committed, discarded };

std::size_t require_dense_array( const sol::table &values,
                                 const std::string_view description,
                                 const std::size_t minimum,
                                 const std::size_t maximum )
{
    const std::size_t count = values.size();
    if( count < minimum || count > maximum ) {
        throw std::invalid_argument( std::string( description ) +
                                     " has an invalid number of entries" );
    }
    std::size_t observed = 0;
    for( const auto &entry : values ) {
        const sol::object key = entry.first;
        if( !key.is<lua_Integer>() ) {
            throw std::invalid_argument( std::string( description ) +
                                         " must be a dense array" );
        }
        const lua_Integer index = key.as<lua_Integer>();
        if( index < 1 || static_cast<std::uint64_t>( index ) > count ) {
            throw std::invalid_argument( std::string( description ) +
                                         " must be a dense array" );
        }
        ++observed;
    }
    if( observed != count ) {
        throw std::invalid_argument( std::string( description ) +
                                     " must be a dense array" );
    }
    return count;
}

struct owner_token {
    std::string mod_id;
    std::size_t generation = 0;
    handle_lifecycle lifecycle = handle_lifecycle::building;
};

struct material_part {
    std::string id;
    std::int64_t portions = 1;
};

struct quality_level {
    std::string id;
    std::int64_t level = 1;
};

struct item_definition_data {
    struct comestible_data {
        std::string type;
        std::int64_t calories = 0;
        std::int64_t fun = 0;
        std::int64_t healthy = 0;
        std::int64_t quench = 0;
        std::int64_t spoils_in_turns = 0;
        std::int64_t charges = 1;
        std::int64_t stack_size = 1;
        std::map<std::string, std::int64_t> vitamins;
    };
    struct book_data {
        std::string skill;
        std::int64_t required_level = 0;
        std::int64_t maximum_level = 0;
        std::int64_t intelligence = 0;
        std::int64_t read_time_turns = 0;
        std::int64_t fun = 0;
    };
    std::string id;
    std::string copy_from;
    std::string name;
    std::string description;
    std::string symbol = "?";
    std::int64_t mass_grams = 0;
    std::int64_t volume_ml = 0;
    std::int64_t price_cents = 0;
    std::int64_t price_postapoc_cents = 0;
    std::string color = "white";
    std::string category;
    std::string looks_like;
    bool has_name = false;
    bool has_description = false;
    bool has_symbol = false;
    bool has_mass = false;
    bool has_volume = false;
    bool has_price = false;
    bool has_price_postapoc = false;
    bool has_color = false;
    bool has_category = false;
    bool has_looks_like = false;
    std::vector<material_part> materials;
    std::vector<quality_level> qualities;
    std::set<std::string> flags;
    std::map<std::string, double> melee_damage;
    std::map<std::string, std::int64_t> magazine_ammo;
    std::int64_t magazine_capacity = 0;
    bool has_magazine_capacity = false;
    std::string use_handler;
    std::string use_label;
    std::string consume_handler;
    std::optional<comestible_data> comestible;
    std::optional<book_data> book;
    bool registered = false;
};

struct component_requirement {
    std::string id;
    std::int64_t count = 1;
    bool requirement = false;
};

struct recipe_definition_data {
    std::string id;
    bool nested_category = false;
    bool practice = false;
    bool uncraft = false;
    std::string result;
    std::string name;
    std::string description;
    std::string category = "CC_OTHER";
    std::string subcategory = "CSC_OTHER_OTHER";
    double activity_level = NO_EXERCISE;
    std::set<std::string> nested_recipes;
    std::string skill;
    std::int64_t difficulty = 0;
    std::int64_t time_moves = 100;
    bool autolearn = true;
    bool reversible = false;
    std::optional<std::int64_t> result_charges;
    std::vector<std::vector<component_requirement>> components;
    std::vector<std::vector<component_requirement>> tools;
    std::map<std::string, std::int64_t> required_skills;
    std::map<std::string, std::int64_t> external_requirements;
    struct proficiency_data {
        std::string id;
        bool required = false;
        double time_multiplier = 0.0;
        double skill_penalty = 0.0;
        bool skill_penalty_assigned = false;
    };
    std::vector<proficiency_data> proficiencies;
    std::map<std::string, std::int64_t> books;
    std::string result_handler;
    bool registered = false;
};

struct plant_lifecycle_definition_data {
    std::string id;
    std::string target = "seed";
    std::map<std::string, std::string> handlers;
    bool registered = false;
};

struct quality_requirement_definition {
    std::string id;
    std::int64_t level = 1;
    std::int64_t count = 1;
};

struct requirement_definition_data {
    std::string id;
    std::string name;
    std::vector<std::vector<component_requirement>> components;
    std::vector<std::vector<component_requirement>> tools;
    std::vector<std::vector<quality_requirement_definition>> qualities;
    bool registered = false;
};

struct recipe_group_terrain_data {
    std::string overmap_terrain;
    std::string match_type = "TYPE";
    std::map<std::string, std::set<std::string>> parameters;
};

struct recipe_group_recipe_data {
    std::string id;
    std::string description;
    std::vector<recipe_group_terrain_data> terrains;
};

struct recipe_group_definition_data {
    std::string id;
    std::string building_type = "NONE";
    std::vector<recipe_group_recipe_data> recipes;
    bool registered = false;
};

struct scent_type_definition_data {
    std::string id;
    std::set<std::string> receptive_species;
    bool registered = false;
};

struct butchery_requirement_definition_data {
    std::string id;
    struct requirement_entry {
        double speed = 0.0;
        std::string size;
        std::string butcher;
        std::string requirement;
    };
    std::vector<requirement_entry> entries;
    bool registered = false;
};

struct item_action_definition_data {
    std::string id;
    std::string name;
    bool registered = false;
};

struct item_group_entry_definition_data {
    std::string id;
    bool group = false;
    std::int64_t probability = 100;
    std::string variant;
    std::int64_t count_min = 1;
    std::int64_t count_max = 1;
    std::int64_t charges_min = -1;
    std::int64_t charges_max = -1;
};

struct item_group_definition_data {
    std::string id;
    std::string kind = "distribution";
    std::int64_t with_ammo = 0;
    std::int64_t with_magazine = 0;
    std::vector<item_group_entry_definition_data> entries;
    bool registered = false;
};

struct ammo_field_definition_data {
    std::string field;
    std::int64_t intensity_min = 1;
    std::int64_t intensity_max = 1;
    std::int64_t radius = 1;
    std::int64_t height = 0;
    std::int64_t chance = 100;
    std::int64_t footprint = 0;
    bool passable_only = false;
};

struct ammo_character_effect_definition_data {
    std::string effect;
    std::int64_t duration_turns = 1;
    std::int64_t intensity_min = 1;
    std::int64_t intensity_max = 1;
    std::int64_t chance = 100;
    std::int64_t radius = 1;
    std::int64_t hits_min = 1;
    std::int64_t hits_max = 1;
    bool touch_skin = false;
    bool all_body_parts = false;
};

struct ammo_spell_definition_data {
    std::string spell;
    std::int64_t level = 0;
    bool self = false;
};

struct ammo_effect_definition_data {
    std::string id;
    std::int64_t trigger_chance = 100;
    std::vector<ammo_field_definition_data> field_bursts;
    std::vector<ammo_field_definition_data> trails;
    std::vector<ammo_character_effect_definition_data> on_hit_effects;
    std::vector<ammo_character_effect_definition_data> area_effects;
    bool has_explosion = false;
    double explosion_power = 0.0;
    double explosion_distance_factor = 0.8;
    std::int64_t explosion_max_noise = 90000000;
    bool explosion_fire = false;
    std::string explosion_light;
    bool has_shrapnel = false;
    std::int64_t casing_mass = 0;
    double fragment_mass = 0.005;
    std::int64_t fragment_recovery = 0;
    std::string fragment_drop = "null";
    bool flashbang = false;
    bool emp = false;
    bool foamcrete = false;
    bool cast_spells_on_miss = false;
    std::vector<ammo_spell_definition_data> spells;
    std::string impact_handler;
    bool registered = false;
};

struct tool_quality_definition_data {
    std::string id;
    std::string name;
    std::vector<std::pair<std::int64_t, std::string>> usages;
    bool registered = false;
};

struct skill_display_definition_data {
    std::string id;
    std::string label;
    bool registered = false;
};

struct skill_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string display_category = "none";
    std::int64_t sort_rank = 1000000;
    std::set<std::string> tags;
    std::map<std::string, std::int64_t> companion_practice;
    std::map<std::int64_t, std::string> theory_descriptions;
    std::map<std::int64_t, std::string> practice_descriptions;
    std::set<std::string> requires_all_traits;
    std::set<std::string> requires_any_traits;
    std::int64_t attack_min_time = 50;
    std::int64_t attack_base_time = 220;
    std::int64_t attack_reduction_per_level = 25;
    std::int64_t companion_combat_rank_factor = 0;
    std::int64_t companion_survival_rank_factor = 0;
    std::int64_t companion_industry_rank_factor = 0;
    bool teachable = true;
    bool obsolete = false;
    bool consumes_focus = true;
    bool registered = false;
};

struct vitamin_definition_data {
    std::string id;
    std::string name;
    std::string type = "vitamin";
    std::string deficiency;
    std::string excess;
    std::int64_t minimum = 0;
    std::int64_t maximum = 0;
    std::int64_t rate_turns = 1;
    std::optional<std::int64_t> weight_micrograms;
    std::vector<std::pair<std::int64_t, std::int64_t>> disease;
    std::vector<std::pair<std::int64_t, std::int64_t>> disease_excess;
    std::vector<std::pair<std::string, std::int64_t>> decays_into;
    std::set<std::string> flags;
    bool registered = false;
};

struct json_flag_definition_data {
    std::string id;
    std::string info;
    std::string restriction;
    std::string name;
    std::string item_prefix;
    std::string item_suffix;
    std::string requires_flag;
    std::set<std::string> conflicts;
    std::int64_t taste_modifier = 0;
    bool inherit = true;
    bool craft_inherit = false;
    bool registered = false;
};

struct math_function_definition_data {
    std::string id;
    std::int64_t num_args = 0;
    std::string expression;
    bool registered = false;
};

struct material_burn_definition {
    bool immune = false;
    std::int64_t volume_ml_per_turn = 0;
    double fuel = 0.0;
    double smoke = 0.0;
    double burn = 0.0;
};

struct material_definition_data {
    std::string id;
    std::string name;
    std::string salvaged_into;
    std::string repaired_with;
    std::string bash_damage_verb = "damages";
    std::string cut_damage_verb = "damages";
    std::vector<std::string> damage_adjectives = {
        "lightly damaged", "damaged", "very damaged", "thoroughly damaged"
    };
    std::map<std::string, double> resistances;
    std::map<std::string, double> vitamins;
    std::vector<material_burn_definition> burn_data;
    std::vector<std::pair<std::string, double>> burn_products;
    std::int64_t chip_resistance = 0;
    std::int64_t breathability = 0;
    std::int64_t repair_difficulty = 10;
    std::optional<std::int64_t> wind_resistance;
    double density = 1.0;
    double sheet_thickness = 0.0;
    double specific_heat_liquid = 4.186;
    double specific_heat_solid = 2.108;
    double latent_heat = 334.0;
    double freezing_point = 0.0;
    bool rotting = false;
    bool soft = false;
    bool uncomfortable = false;
    bool conductive = false;
    bool has_fuel = false;
    std::int64_t fuel_energy_kilojoules = 0;
    std::string fuel_pump_terrain = "t_null";
    bool perpetual_fuel = false;
    std::int64_t explosion_chance_hot = 0;
    std::int64_t explosion_chance_cold = 0;
    double explosion_factor = 0.0;
    bool fiery_explosion = false;
    double fuel_size_factor = 0.0;
    bool registered = false;
};

struct damage_type_definition_data {
    std::string id;
    std::string name;
    std::string skill;
    std::string magic_color = "black";
    std::string derived_from;
    std::string on_hit_handler;
    std::string on_damage_handler;
    double derived_factor = 0.0;
    double bash_conversion_factor = 0.1;
    std::set<std::string> character_immune_flags;
    std::set<std::string> monster_immune_flags;
    bool melee_only = false;
    bool physical = false;
    bool monster_difficulty = false;
    bool no_resist = false;
    bool edged = false;
    bool environmental = false;
    bool material_required = false;
    bool registered = false;
};

struct ammunition_type_definition_data {
    std::string id;
    std::string name;
    std::string default_item;
    bool registered = false;
};

struct item_category_priority_definition {
    std::string zone;
    bool filthy = false;
    std::set<std::string> flags;
};

struct item_category_definition_data {
    std::string id;
    std::string header;
    std::string noun;
    std::int64_t sort_rank = 0;
    double spawn_rate = 1.0;
    std::string zone;
    std::vector<item_category_priority_definition> priority_zones;
    bool registered = false;
};

struct crafting_category_definition_data {
    std::string id;
    std::vector<std::string> subcategories;
    bool hidden = false;
    bool practice = false;
    bool building = false;
    bool wildcard = false;
    bool registered = false;
};

struct proficiency_category_definition_data {
    std::string id;
    std::string name;
    std::string description;
    bool registered = false;
};

struct proficiency_bonus_definition {
    std::string category;
    std::string attribute;
    double value = 0.0;
};

struct proficiency_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string category;
    std::int64_t time_to_learn_turns = 35996400;
    std::set<std::string> required;
    std::vector<proficiency_bonus_definition> bonuses;
    double time_multiplier = 2.0;
    double skill_penalty = 1.0;
    double weakpoint_bonus = 0.0;
    double weakpoint_penalty = 0.0;
    bool can_learn = false;
    bool ignore_focus = false;
    bool teachable = true;
    bool registered = false;
};

struct weapon_category_definition_data {
    std::string id;
    std::string name;
    std::vector<std::string> proficiencies;
    bool registered = false;
};

template<typename Definition>
void require_building_handle( const std::shared_ptr<owner_token> &token,
                              const Definition &definition,
                              const char *kind )
{
    if( !token || token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( std::string( "stale " ) + kind +
                                  " definition handle" );
    }
    if( definition.registered ) {
        throw std::runtime_error( std::string( kind ) +
                                  " definition is already registered" );
    }
}

template<typename Definition>
void require_readable_handle( const std::shared_ptr<owner_token> &token,
                              const Definition &, const char *kind )
{
    if( !token || token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( std::string( "stale " ) + kind +
                                  " definition handle" );
    }
}

struct item_definition_handle {
    std::shared_ptr<item_definition_data> definition;
    std::shared_ptr<owner_token> token;

    item_definition_handle &mass( std::int64_t grams ) {
        require_building_handle( token, *definition, "item" );
        if( grams < 0 || grams > std::numeric_limits<std::int64_t>::max() / 1000 ) {
            throw std::runtime_error( "item mass is outside the native range" );
        }
        definition->mass_grams = grams;
        definition->has_mass = true;
        return *this;
    }

    item_definition_handle &volume( std::int64_t milliliters ) {
        require_building_handle( token, *definition, "item" );
        if( milliliters < 0 ||
            milliliters > std::numeric_limits<units::volume::value_type>::max() ) {
            throw std::runtime_error( "item volume is outside the native range" );
        }
        definition->volume_ml = milliliters;
        definition->has_volume = true;
        return *this;
    }

    item_definition_handle &price( std::int64_t cents ) {
        require_building_handle( token, *definition, "item" );
        if( cents < 0 || cents > std::numeric_limits<units::money::value_type>::max() ) {
            throw std::runtime_error( "item price is outside the native range" );
        }
        definition->price_cents = cents;
        definition->has_price = true;
        return *this;
    }

    item_definition_handle &price_postapoc( std::int64_t cents ) {
        require_building_handle( token, *definition, "item" );
        if( cents < 0 || cents > std::numeric_limits<units::money::value_type>::max() ) {
            throw std::runtime_error( "item post-Cataclysm price is outside the native range" );
        }
        definition->price_postapoc_cents = cents;
        definition->has_price_postapoc = true;
        return *this;
    }

    item_definition_handle &melee( const std::string &damage_type, double amount ) {
        require_building_handle( token, *definition, "item" );
        if( damage_type.empty() || !std::isfinite( amount ) ) {
            throw std::runtime_error( "item melee damage requires a type and finite amount" );
        }
        definition->melee_damage[damage_type] = amount;
        return *this;
    }

    item_definition_handle &magazine_ammo( const std::string &ammo_type,
                                           std::int64_t capacity ) {
        require_building_handle( token, *definition, "item" );
        if( ammo_type.empty() || capacity <= 0 ||
            capacity > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "item magazine ammo requires a type and positive native capacity" );
        }
        definition->magazine_ammo[ammo_type] = capacity;
        return *this;
    }

    item_definition_handle &magazine_capacity( std::int64_t capacity ) {
        require_building_handle( token, *definition, "item" );
        if( capacity <= 0 || capacity > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "item magazine capacity is outside the native range" );
        }
        definition->magazine_capacity = capacity;
        definition->has_magazine_capacity = true;
        return *this;
    }

    item_definition_handle &material( const std::string &id, std::int64_t portions ) {
        require_building_handle( token, *definition, "item" );
        if( id.empty() || portions <= 0 || portions > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "item material requires a non-empty id and positive portions" );
        }
        definition->materials.push_back( { id, portions } );
        return *this;
    }

    item_definition_handle &quality( const std::string &id, std::int64_t level ) {
        require_building_handle( token, *definition, "item" );
        if( id.empty() || level <= 0 || level > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "item quality requires a non-empty id and positive level" );
        }
        definition->qualities.push_back( { id, level } );
        return *this;
    }

    item_definition_handle &flag( const std::string &id ) {
        require_building_handle( token, *definition, "item" );
        if( id.empty() ) {
            throw std::runtime_error( "item flag id cannot be empty" );
        }
        definition->flags.insert( id );
        return *this;
    }

    item_definition_handle &comestible( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        if( definition->book ) {
            throw std::runtime_error( "an item cannot be both comestible and a book" );
        }
        item_definition_data::comestible_data value;
        value.type = options.get_or( "type", std::string() );
        value.calories = options.get_or<std::int64_t>( "calories", -1 );
        value.fun = options.get_or<std::int64_t>( "fun", 0 );
        value.healthy = options.get_or<std::int64_t>( "healthy", 0 );
        value.quench = options.get_or<std::int64_t>( "quench", 0 );
        value.spoils_in_turns = options.get_or<std::int64_t>( "spoils_in_turns", 0 );
        value.charges = options.get_or<std::int64_t>( "charges", 1 );
        value.stack_size = options.get_or<std::int64_t>( "stack_size", value.charges );
        definition->comestible = std::move( value );
        return *this;
    }

    item_definition_handle &vitamin( const std::string &id, std::int64_t amount ) {
        require_building_handle( token, *definition, "item" );
        if( !definition->comestible ) {
            throw std::runtime_error( "item vitamins require a comestible definition" );
        }
        if( id.empty() || amount < std::numeric_limits<int>::min() ||
            amount > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "item vitamin requires a valid id and native amount" );
        }
        definition->comestible->vitamins[id] = amount;
        return *this;
    }

    item_definition_handle &book( const sol::table &options ) {
        require_building_handle( token, *definition, "item" );
        if( definition->comestible ) {
            throw std::runtime_error( "an item cannot be both a book and comestible" );
        }
        item_definition_data::book_data value;
        value.skill = options.get_or( "skill", std::string() );
        value.required_level = options.get_or<std::int64_t>( "required_level", 0 );
        value.maximum_level = options.get_or<std::int64_t>( "maximum_level", 0 );
        value.intelligence = options.get_or<std::int64_t>( "intelligence", 0 );
        value.read_time_turns = options.get_or<std::int64_t>( "read_time_turns", 0 );
        value.fun = options.get_or<std::int64_t>( "fun", 0 );
        definition->book = std::move( value );
        return *this;
    }

    item_definition_handle &on_use( const std::string &handler,
                                    const sol::optional<std::string> &label ) {
        require_building_handle( token, *definition, "item" );
        if( handler.empty() ) {
            throw std::runtime_error( "item use handler id cannot be empty" );
        }
        definition->use_handler = handler;
        definition->use_label = label.value_or( handler );
        return *this;
    }

    item_definition_handle &on_consume( const std::string &handler_id ) {
        require_building_handle( token, *definition, "item" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "item consumption handler id cannot be empty" );
        }
        definition->consume_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "item" );
        return definition->id;
    }
};

struct recipe_definition_handle {
    std::shared_ptr<recipe_definition_data> definition;
    std::shared_ptr<owner_token> token;

    recipe_definition_handle &duration( std::int64_t moves ) {
        require_building_handle( token, *definition, "recipe" );
        if( moves <= 0 ) {
            throw std::runtime_error( "recipe duration must be positive" );
        }
        definition->time_moves = moves;
        return *this;
    }

    recipe_definition_handle &result_charges( std::int64_t charges ) {
        require_building_handle( token, *definition, "recipe" );
        if( charges <= 0 || charges > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "recipe result charges are outside the native range" );
        }
        definition->result_charges = charges;
        return *this;
    }

    recipe_definition_handle &component( const std::string &id, std::int64_t count,
                                         const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "recipe component requires a non-empty id and positive count" );
        }
        definition->components.push_back( { { id, count, requirement.value_or( false ) } } );
        return *this;
    }

    recipe_definition_handle &component_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "recipe" );
        const std::size_t count = require_dense_array(
                                      choices, "recipe component alternatives", 1, 128 );
        std::vector<component_requirement> group;
        group.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = choices.raw_get<sol::object>( index );
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "recipe component alternatives must be tables" );
            }
            const sol::table choice = value.as<sol::table>();
            const std::string id = choice.get_or( "id", std::string() );
            const std::int64_t count = choice.get_or<std::int64_t>( "count", 1 );
            if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
                throw std::runtime_error( "recipe component alternative requires an id and positive count" );
            }
            group.push_back( { id, count, choice.get_or( "requirement", false ) } );
        }
        definition->components.push_back( std::move( group ) );
        return *this;
    }

    recipe_definition_handle &tool( const std::string &id, std::int64_t count,
                                    const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "recipe tool requires a non-empty id and positive instance count" );
        }
        definition->tools.push_back( { { id, -count, requirement.value_or( false ) } } );
        return *this;
    }

    recipe_definition_handle &tool_charges( const std::string &id, std::int64_t charges,
                                            const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || charges <= 0 || charges > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "recipe tool charges require a non-empty id and positive charge count" );
        }
        definition->tools.push_back( { { id, charges, requirement.value_or( false ) } } );
        return *this;
    }

    recipe_definition_handle &tool_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "recipe" );
        const std::size_t count = require_dense_array(
                                      choices, "recipe tool alternatives", 1, 128 );
        std::vector<component_requirement> group;
        group.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = choices.raw_get<sol::object>( index );
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "recipe tool alternatives must be tables" );
            }
            const sol::table choice = value.as<sol::table>();
            const std::string id = choice.get_or( "id", std::string() );
            const sol::object raw_count = choice.raw_get<sol::object>( "count" );
            const sol::object raw_charges = choice.raw_get<sol::object>( "charges" );
            if( raw_count.valid() && raw_count.get_type() != sol::type::nil &&
                raw_charges.valid() && raw_charges.get_type() != sol::type::nil ) {
                throw std::runtime_error(
                    "recipe tool alternative cannot specify both count and charges" );
            }
            const bool consumes_charges = raw_charges.valid() &&
                                          raw_charges.get_type() != sol::type::nil;
            const std::int64_t amount = consumes_charges ?
                                        raw_charges.as<std::int64_t>() :
                                        choice.get_or<std::int64_t>( "count", 1 );
            if( id.empty() || amount <= 0 || amount > std::numeric_limits<int>::max() ) {
                throw std::runtime_error(
                    "recipe tool alternative requires an id and positive amount" );
            }
            group.push_back( { id, consumes_charges ? amount : -amount,
                               choice.get_or( "requirement", false ) } );
        }
        definition->tools.push_back( std::move( group ) );
        return *this;
    }

    recipe_definition_handle &requires_skill( const std::string &id, std::int64_t level ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || level < 0 || level > MAX_SKILL ) {
            throw std::runtime_error( "recipe skill requires a non-empty id and non-negative level" );
        }
        definition->required_skills[id] = level;
        return *this;
    }

    recipe_definition_handle &requirement( const std::string &id,
                                           std::int64_t multiplier ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || multiplier <= 0 || multiplier > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "recipe external requirement needs a non-empty id and positive multiplier" );
        }
        definition->external_requirements[id] = multiplier;
        return *this;
    }

    recipe_definition_handle &proficiency( const std::string &id,
                                           const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() ) {
            throw std::runtime_error( "recipe proficiency id cannot be empty" );
        }
        recipe_definition_data::proficiency_data value;
        value.id = id;
        if( options ) {
            value.required = options->get_or( "required", false );
            value.time_multiplier = options->get_or( "time_multiplier", 0.0 );
            if( const sol::optional<double> penalty =
                    options->get<sol::optional<double>>( "skill_penalty" ) ) {
                value.skill_penalty = *penalty;
                value.skill_penalty_assigned = true;
            }
        }
        definition->proficiencies.push_back( std::move( value ) );
        return *this;
    }

    recipe_definition_handle &book( const std::string &id, std::int64_t skill_level ) {
        require_building_handle( token, *definition, "recipe" );
        if( id.empty() || skill_level < 0 || skill_level > MAX_SKILL ) {
            throw std::runtime_error( "recipe book needs an id and valid skill level" );
        }
        definition->books[id] = skill_level;
        return *this;
    }

    recipe_definition_handle &on_complete( const std::string &handler_id ) {
        require_building_handle( token, *definition, "recipe" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "recipe completion handler id cannot be empty" );
        }
        definition->result_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "recipe" );
        return definition->id;
    }
};

struct plant_lifecycle_definition_handle {
    std::shared_ptr<plant_lifecycle_definition_data> definition;
    std::shared_ptr<owner_token> token;

    plant_lifecycle_definition_handle &on( const std::string &phase,
                                           const std::string &handler_id ) {
        require_building_handle( token, *definition, "plant lifecycle" );
        static const std::set<std::string> phases = {
            "plant", "grow", "mature", "overgrow", "harvest", "fertilize", "water"
        };
        if( phases.count( phase ) == 0 ) {
            throw std::runtime_error( "unknown plant lifecycle phase '" + phase + "'" );
        }
        if( handler_id.empty() ) {
            throw std::runtime_error( "plant lifecycle handler id cannot be empty" );
        }
        definition->handlers[phase] = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "plant lifecycle" );
        return definition->id;
    }
};

struct nested_recipe_category_definition_handle {
    std::shared_ptr<recipe_definition_data> definition;
    std::shared_ptr<owner_token> token;

    nested_recipe_category_definition_handle &recipe( const std::string &id ) {
        require_building_handle( token, *definition, "nested recipe category" );
        if( id.empty() || !definition->nested_recipes.insert( id ).second ) {
            throw std::runtime_error(
                "nested recipe category requires unique non-empty recipe ids" );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "nested recipe category" );
        return definition->id;
    }
};

struct requirement_definition_handle {
    std::shared_ptr<requirement_definition_data> definition;
    std::shared_ptr<owner_token> token;

    requirement_definition_handle &component( const std::string &id, std::int64_t count,
            const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "requirement" );
        if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "requirement component needs an id and positive count" );
        }
        definition->components.push_back( { { id, count, requirement.value_or( false ) } } );
        return *this;
    }

    requirement_definition_handle &component_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "requirement" );
        const std::size_t count = require_dense_array(
                                      choices, "requirement component alternatives", 1, 128 );
        std::vector<component_requirement> group;
        group.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table choice = choices.raw_get<sol::table>( index );
            const std::string id = choice.get_or( "id", std::string() );
            const std::int64_t amount = choice.get_or<std::int64_t>( "count", 1 );
            if( id.empty() || amount <= 0 || amount > std::numeric_limits<int>::max() ) {
                throw std::runtime_error(
                    "requirement component alternative needs an id and positive count" );
            }
            group.push_back( { id, amount, choice.get_or( "requirement", false ) } );
        }
        definition->components.push_back( std::move( group ) );
        return *this;
    }

    requirement_definition_handle &tool( const std::string &id, std::int64_t count,
                                         const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "requirement" );
        if( id.empty() || count <= 0 || count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "requirement tool needs an id and positive count" );
        }
        definition->tools.push_back( { { id, -count, requirement.value_or( false ) } } );
        return *this;
    }

    requirement_definition_handle &tool_charges( const std::string &id,
            std::int64_t charges, const sol::optional<bool> &requirement ) {
        require_building_handle( token, *definition, "requirement" );
        if( id.empty() || charges <= 0 || charges > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "requirement tool charges need an id and positive amount" );
        }
        definition->tools.push_back( { { id, charges, requirement.value_or( false ) } } );
        return *this;
    }

    requirement_definition_handle &tool_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "requirement" );
        const std::size_t count = require_dense_array(
                                      choices, "requirement tool alternatives", 1, 128 );
        std::vector<component_requirement> group;
        group.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table choice = choices.raw_get<sol::table>( index );
            const std::string id = choice.get_or( "id", std::string() );
            const sol::object raw_count = choice.raw_get<sol::object>( "count" );
            const sol::object raw_charges = choice.raw_get<sol::object>( "charges" );
            if( raw_count.valid() && raw_count.get_type() != sol::type::nil &&
                raw_charges.valid() && raw_charges.get_type() != sol::type::nil ) {
                throw std::runtime_error(
                    "requirement tool alternative cannot specify count and charges" );
            }
            const bool charges = raw_charges.valid() &&
                                 raw_charges.get_type() != sol::type::nil;
            const std::int64_t amount = charges ? raw_charges.as<std::int64_t>() :
                                        choice.get_or<std::int64_t>( "count", 1 );
            if( id.empty() || amount <= 0 || amount > std::numeric_limits<int>::max() ) {
                throw std::runtime_error(
                    "requirement tool alternative needs an id and positive amount" );
            }
            group.push_back( { id, charges ? amount : -amount,
                               choice.get_or( "requirement", false ) } );
        }
        definition->tools.push_back( std::move( group ) );
        return *this;
    }

    requirement_definition_handle &quality( const std::string &id,
                                            std::int64_t level, std::int64_t count ) {
        require_building_handle( token, *definition, "requirement" );
        if( id.empty() || level <= 0 || count <= 0 ||
            level > std::numeric_limits<int>::max() ||
            count > std::numeric_limits<int>::max() ) {
            throw std::runtime_error(
                "requirement quality needs an id, positive level, and positive count" );
        }
        definition->qualities.push_back( { { id, level, count } } );
        return *this;
    }

    requirement_definition_handle &quality_any( const sol::table &choices ) {
        require_building_handle( token, *definition, "requirement" );
        const std::size_t count = require_dense_array(
                                      choices, "requirement quality alternatives", 1, 128 );
        std::vector<quality_requirement_definition> group;
        group.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table choice = choices.raw_get<sol::table>( index );
            quality_requirement_definition entry;
            entry.id = choice.get_or( "id", std::string() );
            entry.level = choice.get_or<std::int64_t>( "level", 1 );
            entry.count = choice.get_or<std::int64_t>( "count", 1 );
            if( entry.id.empty() || entry.level <= 0 || entry.count <= 0 ||
                entry.level > std::numeric_limits<int>::max() ||
                entry.count > std::numeric_limits<int>::max() ) {
                throw std::runtime_error(
                    "requirement quality alternative has invalid values" );
            }
            group.push_back( std::move( entry ) );
        }
        definition->qualities.push_back( std::move( group ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "requirement" );
        return definition->id;
    }
};

struct tool_quality_definition_handle {
    std::shared_ptr<tool_quality_definition_data> definition;
    std::shared_ptr<owner_token> token;

    tool_quality_definition_handle &usage( std::int64_t level, const std::string &text ) {
        require_building_handle( token, *definition, "tool quality" );
        if( level < 0 || level > std::numeric_limits<int>::max() || text.empty() ) {
            throw std::runtime_error(
                "tool quality usage requires a non-negative native level and text" );
        }
        definition->usages.emplace_back( level, text );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "tool quality" );
        return definition->id;
    }
};

struct skill_display_definition_handle {
    std::shared_ptr<skill_display_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "skill display category" );
        return definition->id;
    }
};

struct skill_definition_handle {
    std::shared_ptr<skill_definition_data> definition;
    std::shared_ptr<owner_token> token;

    skill_definition_handle &tag( const std::string &value ) {
        require_building_handle( token, *definition, "skill" );
        if( value.empty() ) {
            throw std::runtime_error( "skill tag cannot be empty" );
        }
        definition->tags.insert( value );
        return *this;
    }

    skill_definition_handle &companion_practice( const std::string &id,
            std::int64_t weight ) {
        require_building_handle( token, *definition, "skill" );
        // An empty practice id is a deliberate legacy value: the skill
        // practices itself when no companion skill is specified.
        if( weight < std::numeric_limits<int>::min() ||
            weight > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "skill companion practice entry is outside the native range" );
        }
        definition->companion_practice[id] = weight;
        return *this;
    }

    skill_definition_handle &level_description( std::int64_t level,
            const std::string &theory, const sol::optional<std::string> &practice ) {
        require_building_handle( token, *definition, "skill" );
        if( level < 0 || level > MAX_SKILL || theory.empty() ) {
            throw std::runtime_error( "skill level description is invalid" );
        }
        definition->theory_descriptions[level] = theory;
        // Legacy stores the theory and practice maps independently; only an
        // explicit practice argument fills the practice side.
        if( practice ) {
            definition->practice_descriptions[level] = *practice;
        }
        return *this;
    }

    skill_definition_handle &level_description_practice( std::int64_t level,
            const std::string &practice ) {
        require_building_handle( token, *definition, "skill" );
        if( level < 0 || level > MAX_SKILL || practice.empty() ) {
            throw std::runtime_error( "skill level description is invalid" );
        }
        definition->practice_descriptions[level] = practice;
        return *this;
    }

    skill_definition_handle &requires_all_trait( const std::string &id ) {
        require_building_handle( token, *definition, "skill" );
        if( id.empty() ) {
            throw std::runtime_error( "skill required trait id cannot be empty" );
        }
        definition->requires_all_traits.insert( id );
        return *this;
    }

    skill_definition_handle &requires_any_trait( const std::string &id ) {
        require_building_handle( token, *definition, "skill" );
        if( id.empty() ) {
            throw std::runtime_error( "skill required trait id cannot be empty" );
        }
        definition->requires_any_traits.insert( id );
        return *this;
    }

    skill_definition_handle &attack_time( std::int64_t minimum,
                                          std::int64_t base,
                                          std::int64_t reduction_per_level ) {
        require_building_handle( token, *definition, "skill" );
        if( minimum < 0 || base < minimum ||
            base > std::numeric_limits<int>::max() ||
            reduction_per_level < 0 || reduction_per_level > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "skill attack timing is outside the native range" );
        }
        definition->attack_min_time = minimum;
        definition->attack_base_time = base;
        definition->attack_reduction_per_level = reduction_per_level;
        return *this;
    }

    skill_definition_handle &companion_rank_factors( std::int64_t combat,
            std::int64_t survival, std::int64_t industry ) {
        require_building_handle( token, *definition, "skill" );
        const auto in_range = []( const std::int64_t value ) {
            return value >= std::numeric_limits<int>::min() &&
                   value <= std::numeric_limits<int>::max();
        };
        if( !in_range( combat ) || !in_range( survival ) || !in_range( industry ) ) {
            throw std::runtime_error( "skill companion rank factor is outside the native range" );
        }
        definition->companion_combat_rank_factor = combat;
        definition->companion_survival_rank_factor = survival;
        definition->companion_industry_rank_factor = industry;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "skill" );
        return definition->id;
    }
};

struct vitamin_definition_handle {
    std::shared_ptr<vitamin_definition_data> definition;
    std::shared_ptr<owner_token> token;

    vitamin_definition_handle &weight_micrograms( std::int64_t value ) {
        require_building_handle( token, *definition, "vitamin" );
        if( value <= 0 || value > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "vitamin unit weight is outside the native range" );
        }
        definition->weight_micrograms = value;
        return *this;
    }

    vitamin_definition_handle &deficiency_range( std::int64_t start,
            std::int64_t end ) {
        require_building_handle( token, *definition, "vitamin" );
        if( start < std::numeric_limits<int>::min() || start > std::numeric_limits<int>::max() ||
            end < std::numeric_limits<int>::min() || end > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "vitamin deficiency range is outside the native range" );
        }
        definition->disease.emplace_back( start, end );
        return *this;
    }

    vitamin_definition_handle &excess_range( std::int64_t start, std::int64_t end ) {
        require_building_handle( token, *definition, "vitamin" );
        if( start < std::numeric_limits<int>::min() || start > std::numeric_limits<int>::max() ||
            end < std::numeric_limits<int>::min() || end > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "vitamin excess range is outside the native range" );
        }
        definition->disease_excess.emplace_back( start, end );
        return *this;
    }

    vitamin_definition_handle &decays_into( const std::string &id, std::int64_t rate ) {
        require_building_handle( token, *definition, "vitamin" );
        if( id.empty() || rate <= 0 || rate > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "vitamin decay requires an id and positive native rate" );
        }
        definition->decays_into.emplace_back( id, rate );
        return *this;
    }

    vitamin_definition_handle &flag( const std::string &id ) {
        require_building_handle( token, *definition, "vitamin" );
        if( id.empty() ) {
            throw std::runtime_error( "vitamin flag cannot be empty" );
        }
        definition->flags.insert( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "vitamin" );
        return definition->id;
    }
};

struct json_flag_definition_handle {
    std::shared_ptr<json_flag_definition_data> definition;
    std::shared_ptr<owner_token> token;

    json_flag_definition_handle &conflicts_with( const std::string &id ) {
        require_building_handle( token, *definition, "JSON flag" );
        if( id.empty() ) {
            throw std::runtime_error( "JSON flag conflict id cannot be empty" );
        }
        definition->conflicts.insert( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "JSON flag" );
        return definition->id;
    }
};

struct math_function_definition_handle {
    std::shared_ptr<math_function_definition_data> definition;
    std::shared_ptr<owner_token> token;

    math_function_definition_handle &arguments( const std::int64_t count ) {
        require_building_handle( token, *definition, "math function" );
        definition->num_args = count;
        return *this;
    }

    math_function_definition_handle &returns( const std::string &expression ) {
        require_building_handle( token, *definition, "math function" );
        definition->expression = expression;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "math function" );
        return definition->id;
    }
};

struct material_definition_handle {
    std::shared_ptr<material_definition_data> definition;
    std::shared_ptr<owner_token> token;

    material_definition_handle &resistance( const std::string &damage_id, double value ) {
        require_building_handle( token, *definition, "material" );
        if( damage_id.empty() || !std::isfinite( value ) ) {
            throw std::runtime_error( "material resistance requires a damage id and finite value" );
        }
        definition->resistances[damage_id] = value;
        return *this;
    }

    material_definition_handle &vitamin( const std::string &vitamin_id, double value ) {
        require_building_handle( token, *definition, "material" );
        if( vitamin_id.empty() || !std::isfinite( value ) ) {
            throw std::runtime_error( "material vitamin requires an id and finite value" );
        }
        definition->vitamins[vitamin_id] = value;
        return *this;
    }

    material_definition_handle &damage_adjective( const std::int64_t level,
            const std::string &value ) {
        require_building_handle( token, *definition, "material" );
        if( level < 1 || level > 64 || value.empty() ) {
            throw std::runtime_error( "material damage adjective level is invalid" );
        }
        if( definition->damage_adjectives.size() < static_cast<std::size_t>( level ) ) {
            definition->damage_adjectives.resize( static_cast<std::size_t>( level ) );
        }
        definition->damage_adjectives[static_cast<std::size_t>( level - 1 )] = value;
        return *this;
    }

    material_definition_handle &burn( const std::int64_t intensity,
                                      const bool immune,
                                      const std::int64_t volume_ml_per_turn,
                                      const double fuel, const double smoke,
                                      const double burned ) {
        require_building_handle( token, *definition, "material" );
        if( intensity < 1 || intensity > 64 || volume_ml_per_turn < 0 ||
            volume_ml_per_turn > std::numeric_limits<units::volume::value_type>::max() ||
            !std::isfinite( fuel ) || !std::isfinite( smoke ) || !std::isfinite( burned ) ) {
            throw std::runtime_error( "material burn data is outside the native range" );
        }
        if( definition->burn_data.size() < static_cast<std::size_t>( intensity ) ) {
            definition->burn_data.resize( static_cast<std::size_t>( intensity ) );
        }
        definition->burn_data[static_cast<std::size_t>( intensity - 1 )] = {
            immune, volume_ml_per_turn, fuel, smoke, burned
        };
        return *this;
    }

    material_definition_handle &burn_product( const std::string &item_id,
            const double efficiency ) {
        require_building_handle( token, *definition, "material" );
        if( item_id.empty() || !std::isfinite( efficiency ) ) {
            throw std::runtime_error( "material burn product is invalid" );
        }
        definition->burn_products.emplace_back( item_id, efficiency );
        return *this;
    }

    material_definition_handle &fuel( const std::int64_t energy_kilojoules,
                                      const sol::optional<std::string> &pump_terrain,
                                      const sol::optional<bool> &perpetual ) {
        require_building_handle( token, *definition, "material" );
        if( energy_kilojoules < 0 ||
            energy_kilojoules > std::numeric_limits<std::int64_t>::max() / 1000000 ) {
            throw std::runtime_error( "material fuel energy is outside the native range" );
        }
        definition->has_fuel = true;
        definition->fuel_energy_kilojoules = energy_kilojoules;
        definition->fuel_pump_terrain = pump_terrain.value_or( "t_null" );
        definition->perpetual_fuel = perpetual.value_or( false );
        return *this;
    }

    material_definition_handle &fuel_explosion( const std::int64_t chance_hot,
            const std::int64_t chance_cold, const double factor, const bool fiery,
            const double size_factor ) {
        require_building_handle( token, *definition, "material" );
        if( chance_hot < 0 || chance_hot > std::numeric_limits<int>::max() ||
            chance_cold < 0 || chance_cold > std::numeric_limits<int>::max() ||
            !std::isfinite( factor ) || !std::isfinite( size_factor ) ) {
            throw std::runtime_error( "material fuel explosion data is outside the native range" );
        }
        definition->explosion_chance_hot = chance_hot;
        definition->explosion_chance_cold = chance_cold;
        definition->explosion_factor = factor;
        definition->fiery_explosion = fiery;
        definition->fuel_size_factor = size_factor;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "material" );
        return definition->id;
    }
};

struct damage_type_definition_handle {
    std::shared_ptr<damage_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    damage_type_definition_handle &derived( const std::string &id, const double factor ) {
        require_building_handle( token, *definition, "damage type" );
        if( id.empty() || !std::isfinite( factor ) ) {
            throw std::runtime_error( "derived damage requires an id and finite factor" );
        }
        definition->derived_from = id;
        definition->derived_factor = factor;
        return *this;
    }

    damage_type_definition_handle &immune_character_flag( const std::string &id ) {
        require_building_handle( token, *definition, "damage type" );
        if( id.empty() ) {
            throw std::runtime_error( "damage immunity flag cannot be empty" );
        }
        definition->character_immune_flags.insert( id );
        return *this;
    }

    damage_type_definition_handle &immune_monster_flag( const std::string &id ) {
        require_building_handle( token, *definition, "damage type" );
        if( id.empty() ) {
            throw std::runtime_error( "damage immunity flag cannot be empty" );
        }
        definition->monster_immune_flags.insert( id );
        return *this;
    }

    damage_type_definition_handle &on_hit( const std::string &handler_id ) {
        require_building_handle( token, *definition, "damage type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "damage on-hit handler id cannot be empty" );
        }
        definition->on_hit_handler = handler_id;
        return *this;
    }

    damage_type_definition_handle &on_damage( const std::string &handler_id ) {
        require_building_handle( token, *definition, "damage type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "damage on-damage handler id cannot be empty" );
        }
        definition->on_damage_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "damage type" );
        return definition->id;
    }
};

struct recipe_group_definition_handle {
    std::shared_ptr<recipe_group_definition_data> definition;
    std::shared_ptr<owner_token> token;

    recipe_group_definition_handle &recipe( const std::string &id,
                                            const std::string &description ) {
        require_building_handle( token, *definition, "recipe group" );
        if( id.empty() || description.empty() ) {
            throw std::runtime_error( "recipe-group entry needs an id and description" );
        }
        definition->recipes.push_back( { id, description, {} } );
        return *this;
    }

    recipe_group_definition_handle &terrain( const std::string &recipe_id,
            const std::string &overmap_terrain, const std::string &match_type ) {
        require_building_handle( token, *definition, "recipe group" );
        const auto found = std::find_if(
                               definition->recipes.rbegin(), definition->recipes.rend(),
        [&recipe_id]( const recipe_group_recipe_data & entry ) {
            return entry.id == recipe_id;
        } );
        if( found == definition->recipes.rend() || overmap_terrain.empty() ||
            match_type.empty() ) {
            throw std::runtime_error(
                "recipe-group terrain needs an existing recipe, terrain id, and match type" );
        }
        found->terrains.push_back( { overmap_terrain, match_type, {} } );
        return *this;
    }

    recipe_group_definition_handle &terrain_parameter( const std::string &recipe_id,
            const std::string &parameter, const sol::table &values ) {
        require_building_handle( token, *definition, "recipe group" );
        const auto found = std::find_if(
                               definition->recipes.rbegin(), definition->recipes.rend(),
        [&recipe_id]( const recipe_group_recipe_data & entry ) {
            return entry.id == recipe_id;
        } );
        if( found == definition->recipes.rend() || found->terrains.empty() || parameter.empty() ) {
            throw std::runtime_error(
                "recipe-group terrain parameter needs an existing terrain and parameter name" );
        }
        const std::size_t count = require_dense_array(
                                      values, "recipe-group terrain parameter values", 1, 128 );
        std::set<std::string> &target = found->terrains.back().parameters[parameter];
        for( std::size_t index = 1; index <= count; ++index ) {
            const std::string value = values.raw_get<std::string>( index );
            if( value.empty() ) {
                throw std::runtime_error(
                    "recipe-group terrain parameter value cannot be empty" );
            }
            target.insert( value );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "recipe group" );
        return definition->id;
    }
};

struct scent_type_definition_handle {
    std::shared_ptr<scent_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    scent_type_definition_handle &receptive_species( const std::string &id ) {
        require_building_handle( token, *definition, "scent type" );
        if( id.empty() ) {
            throw std::runtime_error( "scent receptive species id cannot be empty" );
        }
        definition->receptive_species.insert( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "scent type" );
        return definition->id;
    }
};

struct butchery_requirement_definition_handle {
    std::shared_ptr<butchery_requirement_definition_data> definition;
    std::shared_ptr<owner_token> token;

    butchery_requirement_definition_handle &requirement( double speed,
            const std::string &size, const std::string &butcher,
            const std::string &requirement_id ) {
        require_building_handle( token, *definition, "butchery requirement" );
        if( !std::isfinite( speed ) || speed < 0.0 ) {
            throw std::runtime_error(
                "butchery requirement speed must be a finite non-negative number" );
        }
        if( size.empty() || butcher.empty() || requirement_id.empty() ) {
            throw std::runtime_error(
                "butchery requirement size, butcher, and requirement cannot be empty" );
        }
        definition->entries.push_back(
        butchery_requirement_definition_data::requirement_entry{
            speed, size, butcher, requirement_id
        } );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "butchery requirement" );
        return definition->id;
    }
};

struct item_action_definition_handle {
    std::shared_ptr<item_action_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "item action" );
        return definition->id;
    }
};

struct item_group_definition_handle {
        std::shared_ptr<item_group_definition_data> definition;
        std::shared_ptr<owner_token> token;

        item_group_definition_handle &item( const std::string &id,
                                            const sol::optional<std::int64_t> &probability,
                                            const sol::optional<std::string> &variant ) {
            return add_entry( id, false, probability.value_or( 100 ),
                              variant.value_or( std::string() ) );
        }

        item_group_definition_handle &group( const std::string &id,
                                             const sol::optional<std::int64_t> &probability ) {
            return add_entry( id, true, probability.value_or( 100 ), std::string() );
        }

        item_group_definition_handle &entry( const sol::table &options ) {
            const std::string item = options.get_or( "item", std::string() );
            const std::string group_id = options.get_or( "group", std::string() );
            if( item.empty() == group_id.empty() ) {
                throw std::runtime_error(
                    "item-group entry requires exactly one of item or group" );
            }
            item_group_entry_definition_data value;
            value.id = item.empty() ? group_id : item;
            value.group = item.empty();
            value.probability = options.get_or<std::int64_t>( "probability", 100 );
            value.variant = options.get_or( "variant", std::string() );
            if( const sol::optional<sol::table> count =
                    options.get<sol::optional<sol::table>>( "count" ) ) {
                require_dense_array( *count, "item-group count", 2, 2 );
                value.count_min = count->raw_get<std::int64_t>( 1 );
                value.count_max = count->raw_get<std::int64_t>( 2 );
            }
            if( const sol::optional<sol::table> charges =
                    options.get<sol::optional<sol::table>>( "charges" ) ) {
                require_dense_array( *charges, "item-group charges", 2, 2 );
                value.charges_min = charges->raw_get<std::int64_t>( 1 );
                value.charges_max = charges->raw_get<std::int64_t>( 2 );
            }
            if( value.probability <= 0 || value.count_min < 0 ||
                value.count_max < value.count_min ||
                value.count_max > std::numeric_limits<int>::max() ||
                value.charges_min < -1 || value.charges_max < value.charges_min ||
                value.charges_max > std::numeric_limits<int>::max() ||
                ( value.group && value.charges_min != -1 ) ) {
                throw std::runtime_error(
                    "item-group entry has invalid probability, count, or charges" );
            }
            require_building_handle( token, *definition, "item group" );
            definition->entries.push_back( std::move( value ) );
            return *this;
        }

        std::string id() const {
            require_readable_handle( token, *definition, "item group" );
            return definition->id;
        }

    private:
        item_group_definition_handle &add_entry( const std::string &id, const bool group,
                const std::int64_t probability, const std::string &variant ) {
            require_building_handle( token, *definition, "item group" );
            if( id.empty() ) {
                throw std::runtime_error( "item-group entry id cannot be empty" );
            }
            definition->entries.push_back( { id, group, probability, variant } );
            return *this;
        }
};

struct ammo_effect_definition_handle {
    std::shared_ptr<ammo_effect_definition_data> definition;
    std::shared_ptr<owner_token> token;

    ammo_effect_definition_handle &field_burst( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_field_definition_data value;
        value.field = options.get_or( "field", std::string() );
        value.intensity_min = options.get_or<std::int64_t>( "intensity_min", 1 );
        value.intensity_max = options.get_or<std::int64_t>(
                                  "intensity_max", value.intensity_min );
        value.radius = options.get_or<std::int64_t>( "radius", 1 );
        value.height = options.get_or<std::int64_t>( "height", 0 );
        value.chance = options.get_or<std::int64_t>( "chance", 100 );
        value.footprint = options.get_or<std::int64_t>( "footprint", 0 );
        value.passable_only = options.get_or( "passable_only", false );
        definition->field_bursts.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &trail( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_field_definition_data value;
        value.field = options.get_or( "field", std::string() );
        value.intensity_min = options.get_or<std::int64_t>( "intensity_min", 1 );
        value.intensity_max = options.get_or<std::int64_t>(
                                  "intensity_max", value.intensity_min );
        value.chance = options.get_or<std::int64_t>( "chance", 100 );
        definition->trails.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &on_hit( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_character_effect_definition_data value;
        value.effect = options.get_or( "effect", std::string() );
        value.duration_turns = options.get_or<std::int64_t>( "duration_turns", 1 );
        value.intensity_min = options.get_or<std::int64_t>( "intensity", 1 );
        value.intensity_max = value.intensity_min;
        value.touch_skin = options.get_or( "touch_skin", false );
        definition->on_hit_effects.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &area_effect( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_character_effect_definition_data value;
        value.effect = options.get_or( "effect", std::string() );
        value.duration_turns = options.get_or<std::int64_t>( "duration_turns", 1 );
        value.intensity_min = options.get_or<std::int64_t>( "intensity_min", 1 );
        value.intensity_max = options.get_or<std::int64_t>(
                                  "intensity_max", value.intensity_min );
        value.chance = options.get_or<std::int64_t>( "chance", 100 );
        value.radius = options.get_or<std::int64_t>( "radius", 1 );
        value.hits_min = options.get_or<std::int64_t>( "hits_min", 1 );
        value.hits_max = options.get_or<std::int64_t>( "hits_max", value.hits_min );
        value.all_body_parts = options.get_or( "all_body_parts", false );
        definition->area_effects.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &explosion( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        definition->has_explosion = true;
        definition->explosion_power = options.get_or( "power", 0.0 );
        definition->explosion_distance_factor = options.get_or( "distance_factor", 0.8 );
        definition->explosion_max_noise = options.get_or<std::int64_t>(
                                              "max_noise", 90000000 );
        definition->explosion_fire = options.get_or( "fire", false );
        definition->explosion_light = options.get_or( "light", std::string() );
        return *this;
    }

    ammo_effect_definition_handle &shrapnel( const sol::table &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        definition->has_shrapnel = true;
        definition->casing_mass = options.get_or<std::int64_t>( "casing_mass", 0 );
        definition->fragment_mass = options.get_or( "fragment_mass", 0.005 );
        definition->fragment_recovery = options.get_or<std::int64_t>( "recovery", 0 );
        definition->fragment_drop = options.get_or( "drop", std::string( "null" ) );
        return *this;
    }

    ammo_effect_definition_handle &flashbang() {
        require_building_handle( token, *definition, "ammo effect" );
        definition->flashbang = true;
        return *this;
    }

    ammo_effect_definition_handle &emp() {
        require_building_handle( token, *definition, "ammo effect" );
        definition->emp = true;
        return *this;
    }

    ammo_effect_definition_handle &foamcrete() {
        require_building_handle( token, *definition, "ammo effect" );
        definition->foamcrete = true;
        return *this;
    }

    ammo_effect_definition_handle &spell( const std::string &spell_id,
                                          const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "ammo effect" );
        ammo_spell_definition_data value;
        value.spell = spell_id;
        if( options ) {
            value.level = options->get_or<std::int64_t>( "level", 0 );
            value.self = options->get_or( "self", false );
        }
        definition->spells.push_back( std::move( value ) );
        return *this;
    }

    ammo_effect_definition_handle &cast_spells_on_miss( const bool enabled = true ) {
        require_building_handle( token, *definition, "ammo effect" );
        definition->cast_spells_on_miss = enabled;
        return *this;
    }

    ammo_effect_definition_handle &impact_policy( const std::string &handler_id ) {
        require_building_handle( token, *definition, "ammo effect" );
        definition->impact_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "ammo effect" );
        return definition->id;
    }
};

struct ammunition_type_definition_handle {
    std::shared_ptr<ammunition_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "ammunition type" );
        return definition->id;
    }
};

struct item_category_definition_handle {
    std::shared_ptr<item_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    item_category_definition_handle &priority_zone( const std::string &zone,
            const sol::table &flags, bool filthy ) {
        require_building_handle( token, *definition, "item category" );
        if( zone.empty() ) {
            throw std::runtime_error( "item category priority zone id cannot be empty" );
        }
        item_category_priority_definition priority;
        priority.zone = zone;
        priority.filthy = filthy;
        const std::size_t count = require_dense_array(
                                      flags, "item category priority flags", 0, 128 );
        for( std::size_t index = 1; index <= count; ++index ) {
            const std::string flag = flags.raw_get<std::string>( index );
            if( flag.empty() ) {
                throw std::runtime_error( "item category priority flag cannot be empty" );
            }
            priority.flags.insert( flag );
        }
        definition->priority_zones.push_back( std::move( priority ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "item category" );
        return definition->id;
    }
};

struct crafting_category_definition_handle {
    std::shared_ptr<crafting_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    crafting_category_definition_handle &subcategory( const std::string &id ) {
        require_building_handle( token, *definition, "recipe category" );
        if( id.empty() ) {
            throw std::runtime_error( "recipe subcategory id cannot be empty" );
        }
        definition->subcategories.push_back( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "recipe category" );
        return definition->id;
    }
};

struct proficiency_category_definition_handle {
    std::shared_ptr<proficiency_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "proficiency category" );
        return definition->id;
    }
};

struct proficiency_definition_handle {
    std::shared_ptr<proficiency_definition_data> definition;
    std::shared_ptr<owner_token> token;

    proficiency_definition_handle &requires( const std::string &id ) {
        require_building_handle( token, *definition, "proficiency" );
        if( id.empty() || id == definition->id ) {
            throw std::runtime_error( "proficiency prerequisite must be another non-empty id" );
        }
        definition->required.insert( id );
        return *this;
    }

    proficiency_definition_handle &bonus( const std::string &category,
                                          const std::string &attribute, double value ) {
        require_building_handle( token, *definition, "proficiency" );
        if( category.empty() || attribute.empty() || !std::isfinite( value ) ) {
            throw std::runtime_error( "proficiency bonus requires a category, attribute, and finite value" );
        }
        definition->bonuses.push_back( { category, attribute, value } );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "proficiency" );
        return definition->id;
    }
};

struct weapon_category_definition_handle {
    std::shared_ptr<weapon_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    weapon_category_definition_handle &proficiency( const std::string &id ) {
        require_building_handle( token, *definition, "weapon category" );
        if( id.empty() ) {
            throw std::runtime_error( "weapon category proficiency id cannot be empty" );
        }
        definition->proficiencies.push_back( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "weapon category" );
        return definition->id;
    }
};

struct item_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<item_definition_data> definition;
};

struct recipe_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<recipe_definition_data> definition;
};

template<typename Definition>
struct catalog_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<Definition> definition;
};

using plant_lifecycle_registration = catalog_registration<plant_lifecycle_definition_data>;
using tool_quality_registration = catalog_registration<tool_quality_definition_data>;
using skill_display_registration = catalog_registration<skill_display_definition_data>;
using skill_registration = catalog_registration<skill_definition_data>;
using vitamin_registration = catalog_registration<vitamin_definition_data>;
using json_flag_registration = catalog_registration<json_flag_definition_data>;
using math_function_registration = catalog_registration<math_function_definition_data>;
using material_registration = catalog_registration<material_definition_data>;
using damage_type_registration = catalog_registration<damage_type_definition_data>;
using ammunition_type_registration = catalog_registration<ammunition_type_definition_data>;
using item_category_registration = catalog_registration<item_category_definition_data>;
using crafting_category_registration = catalog_registration<crafting_category_definition_data>;
using proficiency_category_registration =
    catalog_registration<proficiency_category_definition_data>;
using proficiency_registration = catalog_registration<proficiency_definition_data>;
using weapon_category_registration = catalog_registration<weapon_category_definition_data>;
using requirement_registration = catalog_registration<requirement_definition_data>;
using recipe_group_registration = catalog_registration<recipe_group_definition_data>;
using scent_type_registration = catalog_registration<scent_type_definition_data>;
using butchery_requirement_registration =
    catalog_registration<butchery_requirement_definition_data>;
using item_action_registration = catalog_registration<item_action_definition_data>;
using item_group_registration = catalog_registration<item_group_definition_data>;
using ammo_effect_registration = catalog_registration<ammo_effect_definition_data>;

std::string operation_name( const definition_operation operation )
{
    return operation == definition_operation::add ? "add" :
           operation == definition_operation::replace ? "replace" :
           operation == definition_operation::extend ? "extend" : "edit";
}

std::optional<creature_size> platform_creature_size( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::toupper( ch ) );
    } );
    if( value == "TINY" ) {
        return creature_size::tiny;
    }
    if( value == "SMALL" ) {
        return creature_size::small;
    }
    if( value == "MEDIUM" ) {
        return creature_size::medium;
    }
    if( value == "LARGE" ) {
        return creature_size::large;
    }
    if( value == "HUGE" ) {
        return creature_size::huge;
    }
    return std::nullopt;
}

std::optional<butcher_type> platform_butcher_type( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::toupper( ch ) );
    } );
    if( value == "BLEED" ) {
        return butcher_type::BLEED;
    }
    if( value == "QUICK" ) {
        return butcher_type::QUICK;
    }
    if( value == "FULL" ) {
        return butcher_type::FULL;
    }
    if( value == "FIELD_DRESS" ) {
        return butcher_type::FIELD_DRESS;
    }
    if( value == "SKIN" ) {
        return butcher_type::SKIN;
    }
    if( value == "QUARTER" ) {
        return butcher_type::QUARTER;
    }
    if( value == "DISMEMBER" ) {
        return butcher_type::DISMEMBER;
    }
    if( value == "DISSECT" ) {
        return butcher_type::DISSECT;
    }
    return std::nullopt;
}

class lua_platform_iuse_actor : public iuse_actor
{
    public:
        lua_platform_iuse_actor( std::string mod_id, std::string handler_id,
                                 std::string label ) :
            iuse_actor( "lua_platform" ), mod_id_( std::move( mod_id ) ),
            handler_id_( std::move( handler_id ) ), label_( std::move( label ) ) {}

        void load( const JsonObject &, const std::string & ) override {}

        std::optional<int> use( Character *character, item &used_item, map *here,
                                const tripoint_bub_ms &position ) const override {
            return invoke_use_handler( mod_id_, handler_id_, character, used_item,
                                       here, position );
        }

        std::unique_ptr<iuse_actor> clone() const override {
            return std::make_unique<lua_platform_iuse_actor>( *this );
        }

        std::string get_name() const override {
            return label_;
        }

    private:
        std::string mod_id_;
        std::string handler_id_;
        std::string label_;
};

void hash_part( std::uint64_t &state, const std::string_view value )
{
    const auto append = [&state]( const std::string_view part ) {
        for( const unsigned char byte : part ) {
            state ^= byte;
            state *= 1099511628211ULL;
        }
    };
    append( std::to_string( value.size() ) );
    append( ":" );
    append( value );
    append( ";" );
}

template<typename Registration>
bool defines_registration(
    const std::vector<Registration> &entries, const std::string_view id )
{
    return std::any_of( entries.begin(), entries.end(), [id]( const Registration & entry ) {
        return entry.definition->id == id;
    } );
}

} // namespace

struct items_content_transaction::impl {
    impl( std::string owner_id, std::size_t owner_generation ) :
        owner( std::move( owner_id ) ), generation( owner_generation ),
        token( std::make_shared<owner_token>( owner_token{ owner, generation,
                                              handle_lifecycle::building } ) ) {}

    std::string owner;
    std::size_t generation = 0;
    std::shared_ptr<owner_token> token;
    std::vector<plant_lifecycle_registration> plant_lifecycles;
    std::vector<tool_quality_registration> tool_qualities;
    std::vector<skill_display_registration> skill_displays;
    std::vector<skill_registration> skills;
    std::vector<vitamin_registration> vitamins;
    std::vector<json_flag_registration> json_flags;
    std::vector<math_function_registration> math_functions;
    std::vector<material_registration> materials;
    std::vector<damage_type_registration> damage_types;
    std::vector<ammunition_type_registration> ammunition_types;
    std::vector<item_category_registration> item_categories;
    std::vector<crafting_category_registration> crafting_categories;
    std::vector<proficiency_category_registration> proficiency_categories;
    std::vector<proficiency_registration> proficiencies;
    std::vector<weapon_category_registration> weapon_categories;
    std::vector<requirement_registration> requirements;
    std::vector<recipe_group_registration> recipe_groups;
    std::vector<scent_type_registration> scent_types;
    std::vector<butchery_requirement_registration> butchery_requirement_entries;
    std::vector<item_action_registration> item_actions;
    std::vector<item_group_registration> item_groups;
    std::vector<ammo_effect_registration> ammo_effects;
    std::vector<item_registration> items;
    std::vector<recipe_registration> recipes;

    std::vector<std::pair<quality_id, std::optional<quality>>> tool_quality_undo;
    std::vector<std::pair<skill_displayType_id, std::optional<SkillDisplayType>>>
    skill_display_undo;
    std::vector<std::pair<skill_id, std::optional<Skill>>> skill_undo;
    std::vector<std::pair<vitamin_id, std::optional<vitamin>>> vitamin_undo;
    std::vector<std::pair<flag_id, std::optional<json_flag>>> json_flag_undo;
    std::vector<std::pair<jmath_func_id, std::optional<jmath_func>>> math_function_undo;
    std::vector<std::pair<damage_type_id, std::optional<damage_type>>> damage_type_undo;
    std::vector<std::pair<material_id, std::optional<material_type>>> material_undo;
    std::vector<std::pair<ammotype, std::optional<ammunition_type>>> ammunition_type_undo;
    std::vector<std::tuple<item_category_id, std::optional<item_category>, float>>
            item_category_undo;
    std::vector<std::pair<crafting_category_id, std::optional<crafting_category>>>
    crafting_category_undo;
    std::vector<std::pair<proficiency_category_id, std::optional<proficiency_category>>>
    proficiency_category_undo;
    std::vector<std::pair<proficiency_id, std::optional<proficiency>>> proficiency_undo;
    std::vector<std::pair<weapon_category_id, std::optional<weapon_category>>>
    weapon_category_undo;
    std::vector<std::pair<requirement_id, std::optional<requirement_data>>> requirement_undo;
    std::vector<std::pair<std::string,
        std::optional<detail::recipe_group_native_definition>>> recipe_group_undo;
    std::vector<std::pair<scenttype_id, std::optional<scent_type>>> scent_type_undo;
    std::vector<std::pair<string_id<butchery_requirements>,
        std::optional<butchery_requirements>>> butchery_requirements_undo;
    std::vector<std::pair<std::string, std::optional<item_action>>> item_action_undo;
    std::vector<std::pair<item_group_id, std::unique_ptr<Item_spawn_data>>> item_group_undo;
    std::vector<std::pair<item_group_id, std::size_t>> item_group_extension_undo;
    std::vector<std::pair<ammo_effect_str_id, std::optional<ammo_effect>>> ammo_effect_undo;
    std::vector<std::pair<itype_id, std::optional<itype>>> item_undo;
    std::vector<std::pair<recipe_id, std::optional<recipe>>> recipe_undo;
    std::vector<std::pair<recipe_id, std::optional<recipe>>> uncraft_undo;

    mutable bool finalization_validated = false;
    items_content_apply_phase next_apply_phase = items_content_apply_phase::foundations;
    // A phase is considered applied only after all of its native writes have
    // completed.  Keeping this separate from `next_apply_phase` lets a
    // failed phase be rolled back without disturbing the strict phase order.
    int applied_phase_count = 0;
    bool requirement_changes = false;
    bool applied = false;
};

items_content_transaction::items_content_transaction( std::string owner,
        const std::size_t generation ) :
    pimpl_( std::make_unique<impl>( std::move( owner ), generation ) )
{}

items_content_transaction::~items_content_transaction() = default;

void items_content_transaction::install_lua_api( sol::state &lua, sol::table &ccb,
        sol::table &content )
{
    ccb.new_usertype<tool_quality_definition_handle>(
        "ToolQualityDefinition", sol::no_constructor,
        "id", sol::property( &tool_quality_definition_handle::id ),
        "usage", &tool_quality_definition_handle::usage );
    ccb.new_usertype<skill_display_definition_handle>(
        "SkillDisplayDefinition", sol::no_constructor,
        "id", sol::property( &skill_display_definition_handle::id ) );
    ccb.new_usertype<skill_definition_handle>(
        "SkillDefinition", sol::no_constructor,
        "id", sol::property( &skill_definition_handle::id ),
        "tag", &skill_definition_handle::tag,
        "companion_practice", &skill_definition_handle::companion_practice,
        "level_description", &skill_definition_handle::level_description,
        "level_description_practice", &skill_definition_handle::level_description_practice,
        "requires_all_trait", &skill_definition_handle::requires_all_trait,
        "requires_any_trait", &skill_definition_handle::requires_any_trait,
        "attack_time", &skill_definition_handle::attack_time,
        "companion_rank_factors", &skill_definition_handle::companion_rank_factors );
    ccb.new_usertype<vitamin_definition_handle>(
        "VitaminDefinition", sol::no_constructor,
        "id", sol::property( &vitamin_definition_handle::id ),
        "weight_micrograms", &vitamin_definition_handle::weight_micrograms,
        "deficiency_range", &vitamin_definition_handle::deficiency_range,
        "excess_range", &vitamin_definition_handle::excess_range,
        "decays_into", &vitamin_definition_handle::decays_into,
        "flag", &vitamin_definition_handle::flag );
    ccb.new_usertype<json_flag_definition_handle>(
        "JsonFlagDefinition", sol::no_constructor,
        "id", sol::property( &json_flag_definition_handle::id ),
        "conflicts_with", &json_flag_definition_handle::conflicts_with );
    ccb.new_usertype<math_function_definition_handle>(
        "MathFunctionDefinition", sol::no_constructor,
        "id", sol::property( &math_function_definition_handle::id ),
        "arguments", &math_function_definition_handle::arguments,
        "returns", &math_function_definition_handle::returns );
    ccb.new_usertype<damage_type_definition_handle>(
        "DamageTypeDefinition", sol::no_constructor,
        "id", sol::property( &damage_type_definition_handle::id ),
        "derived", &damage_type_definition_handle::derived,
        "immune_character_flag", &damage_type_definition_handle::immune_character_flag,
        "immune_monster_flag", &damage_type_definition_handle::immune_monster_flag,
        "on_hit", &damage_type_definition_handle::on_hit,
        "on_damage", &damage_type_definition_handle::on_damage );
    ccb.new_usertype<material_definition_handle>(
        "MaterialDefinition", sol::no_constructor,
        "id", sol::property( &material_definition_handle::id ),
        "resistance", &material_definition_handle::resistance,
        "vitamin", &material_definition_handle::vitamin,
        "damage_adjective", &material_definition_handle::damage_adjective,
        "burn", &material_definition_handle::burn,
        "burn_product", &material_definition_handle::burn_product,
        "fuel", &material_definition_handle::fuel,
        "fuel_explosion", &material_definition_handle::fuel_explosion );
    ccb.new_usertype<ammunition_type_definition_handle>(
        "AmmunitionTypeDefinition", sol::no_constructor,
        "id", sol::property( &ammunition_type_definition_handle::id ) );
    ccb.new_usertype<item_category_definition_handle>(
        "ItemCategoryDefinition", sol::no_constructor,
        "id", sol::property( &item_category_definition_handle::id ),
        "priority_zone", &item_category_definition_handle::priority_zone );
    ccb.new_usertype<crafting_category_definition_handle>(
        "RecipeCategoryDefinition", sol::no_constructor,
        "id", sol::property( &crafting_category_definition_handle::id ),
        "subcategory", &crafting_category_definition_handle::subcategory );
    ccb.new_usertype<proficiency_category_definition_handle>(
        "ProficiencyCategoryDefinition", sol::no_constructor,
        "id", sol::property( &proficiency_category_definition_handle::id ) );
    ccb.new_usertype<proficiency_definition_handle>(
        "ProficiencyDefinition", sol::no_constructor,
        "id", sol::property( &proficiency_definition_handle::id ),
        "requires", &proficiency_definition_handle::requires,
        "bonus", &proficiency_definition_handle::bonus );
    ccb.new_usertype<weapon_category_definition_handle>(
        "WeaponCategoryDefinition", sol::no_constructor,
        "id", sol::property( &weapon_category_definition_handle::id ),
        "proficiency", &weapon_category_definition_handle::proficiency );
    ccb.new_usertype<item_definition_handle>(
        "ItemDefinition", sol::no_constructor,
        "id", sol::property( &item_definition_handle::id ),
        "mass_grams", &item_definition_handle::mass,
        "volume_ml", &item_definition_handle::volume,
        "price_cents", &item_definition_handle::price,
        "price_postapoc_cents", &item_definition_handle::price_postapoc,
        "melee_damage", &item_definition_handle::melee,
        "magazine_ammo", &item_definition_handle::magazine_ammo,
        "magazine_capacity", &item_definition_handle::magazine_capacity,
        "material", &item_definition_handle::material,
        "quality", &item_definition_handle::quality,
        "flag", &item_definition_handle::flag,
        "comestible", &item_definition_handle::comestible,
        "vitamin", &item_definition_handle::vitamin,
        "book", &item_definition_handle::book,
        "on_use", &item_definition_handle::on_use,
        "on_consume", &item_definition_handle::on_consume );
    ccb.new_usertype<recipe_definition_handle>(
        "RecipeDefinition", sol::no_constructor,
        "id", sol::property( &recipe_definition_handle::id ),
        "duration_moves", &recipe_definition_handle::duration,
        "result_charges", &recipe_definition_handle::result_charges,
        "component", &recipe_definition_handle::component,
        "component_any", &recipe_definition_handle::component_any,
        "tool", &recipe_definition_handle::tool,
        "tool_charges", &recipe_definition_handle::tool_charges,
        "tool_any", &recipe_definition_handle::tool_any,
        "requires_skill", &recipe_definition_handle::requires_skill,
        "requirement", &recipe_definition_handle::requirement,
        "proficiency", &recipe_definition_handle::proficiency,
        "book", &recipe_definition_handle::book,
        "on_complete", &recipe_definition_handle::on_complete );
    ccb.new_usertype<plant_lifecycle_definition_handle>(
        "PlantLifecycleDefinition", sol::no_constructor,
        "id", sol::property( &plant_lifecycle_definition_handle::id ),
        "on", &plant_lifecycle_definition_handle::on );
    ccb.new_usertype<nested_recipe_category_definition_handle>(
        "NestedRecipeCategoryDefinition", sol::no_constructor,
        "id", sol::property( &nested_recipe_category_definition_handle::id ),
        "recipe", &nested_recipe_category_definition_handle::recipe );
    ccb.new_usertype<requirement_definition_handle>(
        "RequirementDefinition", sol::no_constructor,
        "id", sol::property( &requirement_definition_handle::id ),
        "component", &requirement_definition_handle::component,
        "component_any", &requirement_definition_handle::component_any,
        "tool", &requirement_definition_handle::tool,
        "tool_charges", &requirement_definition_handle::tool_charges,
        "tool_any", &requirement_definition_handle::tool_any,
        "quality", &requirement_definition_handle::quality,
        "quality_any", &requirement_definition_handle::quality_any );
    ccb.new_usertype<recipe_group_definition_handle>(
        "RecipeGroupDefinition", sol::no_constructor,
        "id", sol::property( &recipe_group_definition_handle::id ),
        "recipe", &recipe_group_definition_handle::recipe,
        "terrain", &recipe_group_definition_handle::terrain,
        "terrain_parameter", &recipe_group_definition_handle::terrain_parameter );
    ccb.new_usertype<scent_type_definition_handle>(
        "ScentTypeDefinition", sol::no_constructor,
        "id", sol::property( &scent_type_definition_handle::id ),
        "receptive_species", &scent_type_definition_handle::receptive_species );
    ccb.new_usertype<butchery_requirement_definition_handle>(
        "ButcheryRequirementDefinition", sol::no_constructor,
        "id", sol::property( &butchery_requirement_definition_handle::id ),
        "requirement", &butchery_requirement_definition_handle::requirement );
    ccb.new_usertype<item_action_definition_handle>(
        "ItemActionDefinition", sol::no_constructor,
        "id", sol::property( &item_action_definition_handle::id ) );
    ccb.new_usertype<item_group_definition_handle>(
        "ItemGroupDefinition", sol::no_constructor,
        "id", sol::property( &item_group_definition_handle::id ),
        "item", &item_group_definition_handle::item,
        "group", &item_group_definition_handle::group,
        "entry", &item_group_definition_handle::entry );
    ccb.new_usertype<ammo_effect_definition_handle>(
        "AmmoEffectDefinition", sol::no_constructor,
        "id", sol::property( &ammo_effect_definition_handle::id ),
        "field_burst", &ammo_effect_definition_handle::field_burst,
        "trail", &ammo_effect_definition_handle::trail,
        "on_hit", &ammo_effect_definition_handle::on_hit,
        "area_effect", &ammo_effect_definition_handle::area_effect,
        "explosion", &ammo_effect_definition_handle::explosion,
        "shrapnel", &ammo_effect_definition_handle::shrapnel,
        "flashbang", &ammo_effect_definition_handle::flashbang,
        "emp", &ammo_effect_definition_handle::emp,
        "foamcrete", &ammo_effect_definition_handle::foamcrete,
        "spell", &ammo_effect_definition_handle::spell,
        "cast_spells_on_miss", &ammo_effect_definition_handle::cast_spells_on_miss,
        "impact_policy", &ammo_effect_definition_handle::impact_policy );
    impl *const transaction = pimpl_.get();
    content.set_function( "ToolQuality", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<tool_quality_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        return tool_quality_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "SkillDisplay", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<skill_display_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->label = options.get_or( "label", definition->id );
        return skill_display_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Skill", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<skill_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->description = options.get_or( "description", std::string() );
        definition->display_category = options.get_or( "display_category", std::string( "none" ) );
        definition->sort_rank = options.get_or<std::int64_t>( "sort_rank", 1000000 );
        definition->teachable = options.get_or( "teachable", true );
        definition->obsolete = options.get_or( "obsolete", false );
        definition->consumes_focus = options.get_or( "consumes_focus", true );
        return skill_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Vitamin", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<vitamin_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->type = options.get_or( "kind", std::string( "vitamin" ) );
        definition->deficiency = options.get_or( "deficiency", std::string() );
        definition->excess = options.get_or( "excess", std::string() );
        definition->minimum = options.get_or<std::int64_t>( "minimum", 0 );
        definition->maximum = options.get_or<std::int64_t>( "maximum", 0 );
        definition->rate_turns = options.get_or<std::int64_t>( "rate_turns", 1 );
        return vitamin_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "JsonFlag", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<json_flag_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->info = options.get_or( "info", std::string() );
        definition->restriction = options.get_or( "restriction", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->item_prefix = options.get_or( "item_prefix", std::string() );
        definition->item_suffix = options.get_or( "item_suffix", std::string() );
        definition->requires_flag = options.get_or( "requires_flag", std::string() );
        definition->taste_modifier = options.get_or<std::int64_t>( "taste_modifier", 0 );
        definition->inherit = options.get_or( "inherit", true );
        definition->craft_inherit = options.get_or( "craft_inherit", false );
        return json_flag_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "MathFunction", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<math_function_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->num_args = options.get_or<std::int64_t>( "arguments", 0 );
        definition->expression = options.get_or( "expression", std::string() );
        return math_function_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "DamageType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<damage_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->skill = options.get_or( "skill", std::string() );
        definition->magic_color = options.get_or( "magic_color", std::string( "black" ) );
        definition->melee_only = options.get_or( "melee_only", false );
        definition->physical = options.get_or( "physical", false );
        definition->monster_difficulty = options.get_or( "monster_difficulty", false );
        definition->no_resist = options.get_or( "no_resist", false );
        definition->edged = options.get_or( "edged", false );
        definition->environmental = options.get_or( "environmental", false );
        definition->material_required = options.get_or( "material_required", false );
        definition->bash_conversion_factor = options.get_or(
                "bash_conversion_factor", definition->physical ? 0.5 : 0.1 );
        return damage_type_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Material", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<material_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->salvaged_into = options.get_or( "salvaged_into", std::string() );
        definition->repaired_with = options.get_or( "repaired_with", std::string() );
        definition->bash_damage_verb = options.get_or( "bash_damage_verb", std::string( "damages" ) );
        definition->cut_damage_verb = options.get_or( "cut_damage_verb", std::string( "damages" ) );
        definition->chip_resistance = options.get_or<std::int64_t>( "chip_resistance", 0 );
        definition->breathability = options.get_or<std::int64_t>( "breathability", 0 );
        definition->repair_difficulty = options.get_or<std::int64_t>( "repair_difficulty", 10 );
        definition->density = options.get_or( "density", 1.0 );
        definition->sheet_thickness = options.get_or( "sheet_thickness", 0.0 );
        definition->specific_heat_liquid = options.get_or( "specific_heat_liquid", 4.186 );
        definition->specific_heat_solid = options.get_or( "specific_heat_solid", 2.108 );
        definition->latent_heat = options.get_or( "latent_heat", 334.0 );
        definition->freezing_point = options.get_or( "freezing_point", 0.0 );
        definition->rotting = options.get_or( "rotting", false );
        definition->soft = options.get_or( "soft", false );
        definition->uncomfortable = options.get_or( "uncomfortable", false );
        definition->conductive = options.get_or( "conductive", false );
        if( const sol::optional<std::int64_t> wind =
                options.get<sol::optional<std::int64_t>>( "wind_resistance" ) ) {
            definition->wind_resistance = *wind;
        }
        return material_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "AmmunitionType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<ammunition_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->default_item = options.get_or( "default_item", std::string() );
        return ammunition_type_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ItemCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<item_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->header = options.get_or( "header", definition->id );
        definition->noun = options.get_or( "noun", definition->header );
        definition->sort_rank = options.get_or<std::int64_t>( "sort_rank", 0 );
        definition->spawn_rate = options.get_or( "spawn_rate", 1.0 );
        definition->zone = options.get_or( "zone", std::string() );
        return item_category_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "RecipeCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<crafting_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->hidden = options.get_or( "hidden", false );
        definition->practice = options.get_or( "practice", false );
        definition->building = options.get_or( "building", false );
        definition->wildcard = options.get_or( "wildcard", false );
        return crafting_category_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ProficiencyCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<proficiency_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->description = options.get_or( "description", std::string() );
        return proficiency_category_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Proficiency", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<proficiency_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->description = options.get_or( "description", std::string() );
        definition->category = options.get_or( "category", std::string() );
        definition->time_to_learn_turns = options.get_or<std::int64_t>(
                                              "time_to_learn_turns", 35996400 );
        definition->time_multiplier = options.get_or( "time_multiplier", 2.0 );
        definition->skill_penalty = options.get_or( "skill_penalty", 1.0 );
        definition->weakpoint_bonus = options.get_or( "weakpoint_bonus", 0.0 );
        definition->weakpoint_penalty = options.get_or( "weakpoint_penalty", 0.0 );
        definition->can_learn = options.get_or( "can_learn", false );
        definition->ignore_focus = options.get_or( "ignore_focus", false );
        definition->teachable = options.get_or( "teachable", true );
        return proficiency_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "WeaponCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<weapon_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        return weapon_category_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Item", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<item_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->copy_from = options.get_or( "copy_from", std::string() );
        const auto read_string = [&options]( const char *key, std::string & target,
        bool & present ) {
            if( const sol::optional<std::string> value =
                    options.get<sol::optional<std::string>>( key ) ) {
                target = *value;
                present = true;
            }
        };
        read_string( "name", definition->name, definition->has_name );
        read_string( "description", definition->description, definition->has_description );
        read_string( "symbol", definition->symbol, definition->has_symbol );
        read_string( "color", definition->color, definition->has_color );
        read_string( "category", definition->category, definition->has_category );
        read_string( "looks_like", definition->looks_like, definition->has_looks_like );
        definition->consume_handler = options.get_or(
                                          "on_consume",
                                          options.get_or( "consume_handler", std::string() ) );
        if( !definition->has_name && definition->copy_from.empty() ) {
            definition->name = definition->id;
            definition->has_name = true;
        }
        if( const sol::optional<std::int64_t> mass =
                options.get<sol::optional<std::int64_t>>( "mass_grams" ) ) {
            definition->mass_grams = *mass;
            definition->has_mass = true;
        }
        if( const sol::optional<std::int64_t> volume =
                options.get<sol::optional<std::int64_t>>( "volume_ml" ) ) {
            definition->volume_ml = *volume;
            definition->has_volume = true;
        }
        if( const sol::optional<std::int64_t> price =
                options.get<sol::optional<std::int64_t>>( "price_cents" ) ) {
            definition->price_cents = *price;
            definition->has_price = true;
        }
        if( const sol::optional<std::int64_t> price_postapoc =
                options.get<sol::optional<std::int64_t>>( "price_postapoc_cents" ) ) {
            definition->price_postapoc_cents = *price_postapoc;
            definition->has_price_postapoc = true;
        }
        if( const sol::optional<std::int64_t> magazine_capacity =
                options.get<sol::optional<std::int64_t>>( "magazine_capacity" ) ) {
            if( *magazine_capacity <= 0 ||
                *magazine_capacity > std::numeric_limits<int>::max() ) {
                throw std::runtime_error( "item magazine capacity is outside the native range" );
            }
            definition->magazine_capacity = *magazine_capacity;
            definition->has_magazine_capacity = true;
        }
        return item_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "Recipe", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<recipe_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->result = options.get_or( "result", std::string() );
        definition->category = options.get_or( "category", std::string( "CC_OTHER" ) );
        definition->subcategory = options.get_or(
                                      "subcategory", std::string( "CSC_OTHER_OTHER" ) );
        definition->skill = options.get_or( "skill", std::string() );
        definition->difficulty = options.get_or<std::int64_t>( "difficulty", 0 );
        definition->time_moves = options.get_or<std::int64_t>( "duration_moves", 100 );
        definition->autolearn = options.get_or( "autolearn", true );
        definition->reversible = options.get_or( "reversible", false );
        definition->practice = options.get_or( "practice", false );
        definition->uncraft = options.get_or( "uncraft", false );
        definition->activity_level = options.get_or( "activity_level", 1.0 );
        definition->result_handler = options.get_or(
                                         "on_complete",
                                         options.get_or( "result_handler", std::string() ) );
        return recipe_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "PlantLifecycle", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<plant_lifecycle_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->target = options.get_or( "target", std::string( "seed" ) );
        for( const char *phase : {
                 "plant", "grow", "mature", "overgrow", "harvest", "fertilize", "water"
             } ) {
            const std::string handler = options.get_or(
                                            std::string( "on_" ) + phase, std::string() );
            if( !handler.empty() ) {
                definition->handlers.emplace( phase, handler );
            }
        }
        return plant_lifecycle_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "NestedRecipeCategory", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<recipe_definition_data>();
        definition->nested_category = true;
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->category = options.get_or( "category", std::string() );
        definition->subcategory = options.get_or( "subcategory", std::string() );
        definition->activity_level = options.get_or( "activity_level", 1.0 );
        return nested_recipe_category_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Requirement", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<requirement_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        return requirement_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "RecipeGroup", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<recipe_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->building_type = options.get_or( "building_type", std::string( "NONE" ) );
        return recipe_group_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ScentType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<scent_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return scent_type_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ButcheryRequirement",
    [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<butchery_requirement_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return butchery_requirement_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "ItemAction", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<item_action_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        return item_action_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "ItemGroup", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<item_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->kind = options.get_or( "kind", std::string( "distribution" ) );
        definition->with_ammo = options.get_or<std::int64_t>( "with_ammo", 0 );
        definition->with_magazine = options.get_or<std::int64_t>( "with_magazine", 0 );
        return item_group_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "extend_item_group", [transaction]( item_group_definition_handle handle ) {
        if( handle.token != transaction->token ) {
            throw std::runtime_error( "cannot register an item group definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, "item group" );
        handle.definition->registered = true;
        transaction->item_groups.push_back( { definition_operation::extend, handle.definition } );
    } );
    content.set_function( "AmmoEffect", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<ammo_effect_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->trigger_chance = options.get_or<std::int64_t>( "trigger_chance", 100 );
        return ammo_effect_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    auto edit_catalog = [transaction]( const std::string & id, auto & registrations,
    const char *kind ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if( registrations.rbegin(), registrations.rend(),
        [&id]( const auto & entry ) {
            return entry.definition->id == id;
        } );
        if( found == registrations.rend() ) {
            throw std::runtime_error( std::string( "edit_" ) + kind +
                                      " requires a definition staged earlier by this Mod" );
        }
        auto definition = std::make_shared < std::decay_t < decltype( *found->definition ) >> (
                              *found->definition );
        definition->registered = false;
        return definition;
    };
    content.set_function( "edit_tool_quality", [transaction, edit_catalog]( const std::string & id ) {
        return tool_quality_definition_handle{
            edit_catalog( id, transaction->tool_qualities, "tool_quality" ), transaction->token
        };
    } );
    content.set_function( "edit_skill_display", [transaction, edit_catalog]( const std::string & id ) {
        return skill_display_definition_handle{
            edit_catalog( id, transaction->skill_displays, "skill_display" ), transaction->token
        };
    } );
    content.set_function( "edit_skill", [transaction, edit_catalog]( const std::string & id ) {
        return skill_definition_handle{
            edit_catalog( id, transaction->skills, "skill" ), transaction->token
        };
    } );
    content.set_function( "edit_vitamin", [transaction, edit_catalog]( const std::string & id ) {
        return vitamin_definition_handle{
            edit_catalog( id, transaction->vitamins, "vitamin" ), transaction->token
        };
    } );
    content.set_function( "edit_json_flag", [transaction, edit_catalog]( const std::string & id ) {
        return json_flag_definition_handle{
            edit_catalog( id, transaction->json_flags, "json_flag" ), transaction->token
        };
    } );
    content.set_function( "edit_math_function", [transaction, edit_catalog](
    const std::string & id ) {
        return math_function_definition_handle{
            edit_catalog( id, transaction->math_functions, "math_function" ), transaction->token
        };
    } );
    content.set_function( "edit_damage_type", [transaction, edit_catalog]( const std::string & id ) {
        return damage_type_definition_handle{
            edit_catalog( id, transaction->damage_types, "damage_type" ), transaction->token
        };
    } );
    content.set_function( "edit_material", [transaction, edit_catalog]( const std::string & id ) {
        return material_definition_handle{
            edit_catalog( id, transaction->materials, "material" ), transaction->token
        };
    } );
    content.set_function( "edit_ammunition_type", [transaction, edit_catalog](
    const std::string & id ) {
        return ammunition_type_definition_handle{
            edit_catalog( id, transaction->ammunition_types, "ammunition_type" ),
            transaction->token
        };
    } );
    content.set_function( "edit_item_category", [transaction, edit_catalog](
    const std::string & id ) {
        return item_category_definition_handle{
            edit_catalog( id, transaction->item_categories, "item_category" ), transaction->token
        };
    } );
    content.set_function( "edit_recipe_category", [transaction, edit_catalog](
    const std::string & id ) {
        return crafting_category_definition_handle{
            edit_catalog( id, transaction->crafting_categories, "recipe_category" ),
            transaction->token
        };
    } );
    content.set_function( "edit_proficiency_category", [transaction, edit_catalog](
    const std::string & id ) {
        return proficiency_category_definition_handle{
            edit_catalog( id, transaction->proficiency_categories, "proficiency_category" ),
            transaction->token
        };
    } );
    content.set_function( "edit_proficiency", [transaction, edit_catalog](
    const std::string & id ) {
        return proficiency_definition_handle{
            edit_catalog( id, transaction->proficiencies, "proficiency" ), transaction->token
        };
    } );
    content.set_function( "edit_weapon_category", [transaction, edit_catalog](
    const std::string & id ) {
        return weapon_category_definition_handle{
            edit_catalog( id, transaction->weapon_categories, "weapon_category" ),
            transaction->token
        };
    } );
    content.set_function( "edit_requirement", [transaction, edit_catalog](
    const std::string & id ) {
        return requirement_definition_handle{
            edit_catalog( id, transaction->requirements, "requirement" ), transaction->token
        };
    } );
    content.set_function( "edit_recipe_group", [transaction, edit_catalog](
    const std::string & id ) {
        return recipe_group_definition_handle{
            edit_catalog( id, transaction->recipe_groups, "recipe_group" ), transaction->token
        };
    } );
    content.set_function( "edit_scent_type", [transaction, edit_catalog](
    const std::string & id ) {
        return scent_type_definition_handle{
            edit_catalog( id, transaction->scent_types, "scent_type" ), transaction->token
        };
    } );
    content.set_function( "edit_item_group", [transaction, edit_catalog](
    const std::string & id ) {
        return item_group_definition_handle{
            edit_catalog( id, transaction->item_groups, "item_group" ),
            transaction->token
        };
    } );
    content.set_function( "edit_ammo_effect", [transaction, edit_catalog](
    const std::string & id ) {
        return ammo_effect_definition_handle{
            edit_catalog( id, transaction->ammo_effects, "ammo_effect" ),
            transaction->token
        };
    } );
    content.set_function( "edit_item", [transaction]( const std::string & id ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if(
                               transaction->items.rbegin(), transaction->items.rend(),
        [&id]( const item_registration & entry ) {
            return entry.definition->id == id;
        } );
        if( found == transaction->items.rend() ) {
            throw std::runtime_error(
                "edit_item requires an item staged earlier by this Mod" );
        }
        auto definition = std::make_shared<item_definition_data>( *found->definition );
        definition->registered = false;
        return item_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "edit_recipe", [transaction]( const std::string & id ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if(
                               transaction->recipes.rbegin(), transaction->recipes.rend(),
        [&id]( const recipe_registration & entry ) {
            return entry.definition->id == id;
        } );
        if( found == transaction->recipes.rend() ) {
            throw std::runtime_error(
                "edit_recipe requires a recipe staged earlier by this Mod" );
        }
        auto definition = std::make_shared<recipe_definition_data>( *found->definition );
        if( definition->nested_category ) {
            throw std::runtime_error(
                "edit_recipe cannot edit a nested category; use edit_nested_recipe_category" );
        }
        definition->registered = false;
        return recipe_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "edit_nested_recipe_category", [transaction](
    const std::string & id ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if(
                               transaction->recipes.rbegin(), transaction->recipes.rend(),
        [&id]( const recipe_registration & entry ) {
            return entry.definition->id == id;
        } );
        if( found == transaction->recipes.rend() || !found->definition->nested_category ) {
            throw std::runtime_error(
                "edit_nested_recipe_category requires a nested category staged earlier by this Mod" );
        }
        auto definition = std::make_shared<recipe_definition_data>( *found->definition );
        definition->registered = false;
        return nested_recipe_category_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    static_cast<void>( lua );
}

bool items_content_transaction::register_definition( const sol::object &value,
        const int raw_operation )
{
    if( raw_operation < 0 || raw_operation > 2 ) {
        throw std::runtime_error( "invalid Platform content operation" );
    }
    const definition_operation operation = static_cast<definition_operation>( raw_operation );
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( "content transaction is no longer building" );
    }
    const auto register_catalog = [this, operation]( auto handle, auto & registrations,
    const char *kind ) {
        if( handle.token != pimpl_->token ) {
            throw std::runtime_error( std::string( "cannot register a " ) + kind +
                                      " definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, kind );
        handle.definition->registered = true;
        if( operation == definition_operation::edit ) {
            const auto target = std::find_if( registrations.rbegin(), registrations.rend(),
            [&handle]( const auto & entry ) {
                return entry.definition->id == handle.definition->id;
            } );
            if( target == registrations.rend() ) {
                handle.definition->registered = false;
                throw std::runtime_error( std::string( "edit requires a " ) + kind +
                                          " staged earlier by this Mod" );
            }
            target->definition = handle.definition;
            return;
        }
        registrations.push_back( { operation, handle.definition } );
    };
    if( value.is<item_definition_handle>() ) {
        item_definition_handle handle = value.as<item_definition_handle>();
        register_catalog( handle, pimpl_->items, "item" );
        return true;
    }
    if( value.is<tool_quality_definition_handle>() ) {
        register_catalog( value.as<tool_quality_definition_handle>(), pimpl_->tool_qualities,
                          "tool quality" );
        return true;
    }
    if( value.is<skill_display_definition_handle>() ) {
        register_catalog( value.as<skill_display_definition_handle>(), pimpl_->skill_displays,
                          "skill display category" );
        return true;
    }
    if( value.is<skill_definition_handle>() ) {
        register_catalog( value.as<skill_definition_handle>(), pimpl_->skills, "skill" );
        return true;
    }
    if( value.is<vitamin_definition_handle>() ) {
        register_catalog( value.as<vitamin_definition_handle>(), pimpl_->vitamins, "vitamin" );
        return true;
    }
    if( value.is<json_flag_definition_handle>() ) {
        register_catalog( value.as<json_flag_definition_handle>(), pimpl_->json_flags, "JSON flag" );
        return true;
    }
    if( value.is<math_function_definition_handle>() ) {
        register_catalog( value.as<math_function_definition_handle>(), pimpl_->math_functions,
                          "math function" );
        return true;
    }
    if( value.is<damage_type_definition_handle>() ) {
        register_catalog( value.as<damage_type_definition_handle>(), pimpl_->damage_types, "damage type" );
        return true;
    }
    if( value.is<material_definition_handle>() ) {
        register_catalog( value.as<material_definition_handle>(), pimpl_->materials, "material" );
        return true;
    }
    if( value.is<ammunition_type_definition_handle>() ) {
        register_catalog( value.as<ammunition_type_definition_handle>(), pimpl_->ammunition_types,
                          "ammunition type" );
        return true;
    }
    if( value.is<item_category_definition_handle>() ) {
        register_catalog( value.as<item_category_definition_handle>(), pimpl_->item_categories,
                          "item category" );
        return true;
    }
    if( value.is<crafting_category_definition_handle>() ) {
        register_catalog( value.as<crafting_category_definition_handle>(), pimpl_->crafting_categories,
                          "recipe category" );
        return true;
    }
    if( value.is<proficiency_category_definition_handle>() ) {
        register_catalog( value.as<proficiency_category_definition_handle>(),
                          pimpl_->proficiency_categories, "proficiency category" );
        return true;
    }
    if( value.is<proficiency_definition_handle>() ) {
        register_catalog( value.as<proficiency_definition_handle>(), pimpl_->proficiencies, "proficiency" );
        return true;
    }
    if( value.is<weapon_category_definition_handle>() ) {
        register_catalog( value.as<weapon_category_definition_handle>(), pimpl_->weapon_categories,
                          "weapon category" );
        return true;
    }
    if( value.is<requirement_definition_handle>() ) {
        register_catalog( value.as<requirement_definition_handle>(), pimpl_->requirements, "requirement" );
        return true;
    }
    if( value.is<recipe_group_definition_handle>() ) {
        register_catalog( value.as<recipe_group_definition_handle>(), pimpl_->recipe_groups,
                          "recipe group" );
        return true;
    }
    if( value.is<scent_type_definition_handle>() ) {
        register_catalog( value.as<scent_type_definition_handle>(), pimpl_->scent_types, "scent type" );
        return true;
    }
    if( value.is<butchery_requirement_definition_handle>() ) {
        register_catalog( value.as<butchery_requirement_definition_handle>(),
                          pimpl_->butchery_requirement_entries, "butchery requirement" );
        return true;
    }
    if( value.is<item_action_definition_handle>() ) {
        register_catalog( value.as<item_action_definition_handle>(), pimpl_->item_actions, "item action" );
        return true;
    }
    if( value.is<item_group_definition_handle>() ) {
        register_catalog( value.as<item_group_definition_handle>(), pimpl_->item_groups, "item group" );
        return true;
    }
    if( value.is<ammo_effect_definition_handle>() ) {
        register_catalog( value.as<ammo_effect_definition_handle>(), pimpl_->ammo_effects, "ammo effect" );
        return true;
    }
    if( value.is<nested_recipe_category_definition_handle>() ) {
        register_catalog( value.as<nested_recipe_category_definition_handle>(),
                          pimpl_->recipes, "nested recipe category" );
        return true;
    }
    if( value.is<recipe_definition_handle>() ) {
        register_catalog( value.as<recipe_definition_handle>(), pimpl_->recipes, "recipe" );
        return true;
    }
    if( value.is<plant_lifecycle_definition_handle>() ) {
        if( operation != definition_operation::add ) {
            throw std::runtime_error( "plant lifecycle definitions can only be added" );
        }
        register_catalog( value.as<plant_lifecycle_definition_handle>(),
                          pimpl_->plant_lifecycles, "plant lifecycle" );
        return true;
    }
    return false;
}

bool items_content_transaction::validate( const runtime &owner_runtime,
        const bool check_engine_state, const items_content_validation_context &context,
        std::string &error ) const
{
    try {
        const auto require_valid_id = []( const std::string & id, const char *kind ) {
            if( id.empty() || id.find( '#' ) != std::string::npos ||
                id.find( '\0' ) != std::string::npos || id.size() > 256 ) {
                throw std::runtime_error( std::string( "invalid " ) + kind + " id '" + id + "'" );
            }
        };
        const auto validate_operation = [check_engine_state]( const definition_operation operation,
        const bool exists, const std::string & id, const char *kind ) {
            if( !check_engine_state ) {
                return;
            }
            if( operation == definition_operation::add && exists ) {
                throw std::runtime_error( std::string( "add would overwrite existing " ) +
                                          kind + " '" + id + "'; use replace explicitly" );
            }
            if( operation == definition_operation::replace && !exists ) {
                throw std::runtime_error( std::string( "replace requires existing " ) +
                                          kind + " '" + id + "'" );
            }
            if( operation == definition_operation::extend && !exists ) {
                throw std::runtime_error( std::string( "extend requires existing " ) +
                                          kind + " '" + id + "'" );
            }
        };
        const auto native_int = []( const std::int64_t value ) {
            return value >= std::numeric_limits<int>::min() &&
                   value <= std::numeric_limits<int>::max();
        };
        const auto native_nonnegative_int = []( const std::int64_t value ) {
            return value >= 0 && value <= std::numeric_limits<int>::max();
        };
        const auto finite_native_float = []( const double value ) {
            return std::isfinite( value ) &&
                   std::abs( value ) <= std::numeric_limits<float>::max();
        };

        std::set<std::string> tool_quality_ids;
        for( const tool_quality_registration &entry : pimpl_->tool_qualities ) {
            const tool_quality_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "tool quality" );
            if( definition.name.empty() || !tool_quality_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "tool quality '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            for( const auto &[level, text] : definition.usages ) {
                if( level <= 0 || !native_int( level ) || text.empty() ) {
                    throw std::runtime_error( "tool quality '" + definition.id +
                                              "' has an invalid usage" );
                }
            }
            validate_operation( entry.operation, quality_id( definition.id ).is_valid(),
                                definition.id, "tool quality" );
        }

        std::set<std::string> skill_display_ids;
        for( const skill_display_registration &entry : pimpl_->skill_displays ) {
            const skill_display_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "skill display category" );
            if( definition.label.empty() || !skill_display_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "skill display category '" + definition.id +
                                          "' requires a label and one registration per transaction" );
            }
            validate_operation( entry.operation, skill_displayType_id( definition.id ).is_valid(),
                                definition.id, "skill display category" );
        }

        std::set<std::string> skill_ids;
        for( const skill_registration &entry : pimpl_->skills ) {
            const skill_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "skill" );
            if( definition.name.empty() || definition.description.empty() ||
                !skill_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "skill '" + definition.id +
                                          "' requires name, description, and one registration per transaction" );
            }
            if( !native_int( definition.sort_rank ) || !native_nonnegative_int( definition.attack_min_time ) ||
                !native_nonnegative_int( definition.attack_base_time ) ||
                !native_nonnegative_int( definition.attack_reduction_per_level ) ||
                definition.attack_base_time < definition.attack_min_time ||
                !native_int( definition.companion_combat_rank_factor ) ||
                !native_int( definition.companion_survival_rank_factor ) ||
                !native_int( definition.companion_industry_rank_factor ) ) {
                throw std::runtime_error( "skill '" + definition.id +
                                          "' has values outside the native range" );
            }
            if( definition.tags.count( "contextual_skill" ) == 0 &&
                skill_display_ids.count( definition.display_category ) == 0 &&
                !skill_displayType_id( definition.display_category ).is_valid() ) {
                throw std::runtime_error( "skill '" + definition.id +
                                          "' references unknown display category '" +
                                          definition.display_category + "'" );
            }
            for( const auto &[id, weight] : definition.companion_practice ) {
                if( id.empty() || !native_int( weight ) ) {
                    throw std::runtime_error( "skill '" + definition.id +
                                              "' has an invalid companion practice" );
                }
            }
            validate_operation( entry.operation, skill_id( definition.id ).is_valid(),
                                definition.id, "skill" );
        }

        std::set<std::string> vitamin_ids;
        for( const vitamin_registration &entry : pimpl_->vitamins ) {
            const vitamin_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "vitamin" );
            if( definition.name.empty() || !vitamin_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            if( definition.type != "vitamin" && definition.type != "toxin" &&
                definition.type != "drug" && definition.type != "counter" ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' has unknown kind '" + definition.type + "'" );
            }
            if( !native_int( definition.minimum ) || !native_int( definition.maximum ) ||
                definition.rate_turns <= 0 || !native_int( definition.rate_turns ) ||
                ( definition.weight_micrograms &&
                  ( *definition.weight_micrograms <= 0 || !native_int( *definition.weight_micrograms ) ) ) ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' bounds or rate are outside the native range" );
            }
            if( !definition.deficiency.empty() && !efftype_id( definition.deficiency ).is_valid() ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' references unknown deficiency effect '" +
                                          definition.deficiency + "'" );
            }
            if( !definition.excess.empty() && !efftype_id( definition.excess ).is_valid() ) {
                throw std::runtime_error( "vitamin '" + definition.id +
                                          "' references unknown excess effect '" + definition.excess + "'" );
            }
            for( const auto &[decay_id, rate] : definition.decays_into ) {
                if( decay_id.empty() || rate <= 0 || !native_int( rate ) ||
                    ( vitamin_ids.count( decay_id ) == 0 && !vitamin_id( decay_id ).is_valid() ) ) {
                    throw std::runtime_error( "vitamin '" + definition.id +
                                              "' decays into unknown vitamin '" + decay_id + "'" );
                }
            }
            validate_operation( entry.operation, vitamin_id( definition.id ).is_valid(),
                                definition.id, "vitamin" );
        }

        std::set<std::string> json_flag_ids;
        for( const json_flag_registration &entry : pimpl_->json_flags ) {
            const json_flag_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "JSON flag" );
            if( !json_flag_ids.insert( definition.id ).second ||
                !native_int( definition.taste_modifier ) ) {
                throw std::runtime_error( "JSON flag '" + definition.id +
                                          "' is registered more than once or has an invalid taste modifier" );
            }
            validate_operation( entry.operation, flag_id( definition.id ).is_valid(),
                                definition.id, "JSON flag" );
        }
        for( const json_flag_registration &entry : pimpl_->json_flags ) {
            const json_flag_definition_data &definition = *entry.definition;
            if( !definition.requires_flag.empty() &&
                json_flag_ids.count( definition.requires_flag ) == 0 &&
                !flag_id( definition.requires_flag ).is_valid() ) {
                throw std::runtime_error( "JSON flag '" + definition.id +
                                          "' requires unknown flag '" + definition.requires_flag + "'" );
            }
            for( const std::string &conflict : definition.conflicts ) {
                if( conflict.empty() || ( json_flag_ids.count( conflict ) == 0 &&
                                          !flag_id( conflict ).is_valid() ) ) {
                    throw std::runtime_error( "JSON flag '" + definition.id +
                                              "' conflicts with unknown flag '" + conflict + "'" );
                }
            }
        }

        std::set<std::string> math_function_ids;
        for( const math_function_registration &entry : pimpl_->math_functions ) {
            const math_function_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "math function" );
            if( !math_function_ids.insert( definition.id ).second || definition.num_args < 0 ||
                definition.num_args > 1024 || definition.expression.empty() ||
                definition.expression.size() > 65536 ||
                definition.expression.find( '\0' ) != std::string::npos ||
                get_all_diag_funcs().find( definition.id ) != get_all_diag_funcs().end() ) {
                throw std::runtime_error( "math function '" + definition.id +
                                          "' has invalid or duplicate definition data" );
            }
            validate_operation( entry.operation, jmath_func_id( definition.id ).is_valid(),
                                definition.id, "math function" );
        }

        std::set<std::string> damage_type_ids;
        for( const damage_type_registration &entry : pimpl_->damage_types ) {
            const damage_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "damage type" );
            if( definition.name.empty() || !finite_native_float( definition.bash_conversion_factor ) ||
                definition.bash_conversion_factor < 0.0 ||
                !damage_type_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            if( !definition.skill.empty() && skill_ids.count( definition.skill ) == 0 &&
                !skill_id( definition.skill ).is_valid() ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' references unknown skill '" + definition.skill + "'" );
            }
            if( !definition.on_hit_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.on_hit_handler ) ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' references missing on-hit handler '" +
                                          definition.on_hit_handler + "'" );
            }
            if( !definition.on_damage_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.on_damage_handler ) ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' references missing on-damage handler '" +
                                          definition.on_damage_handler + "'" );
            }
            validate_operation( entry.operation, damage_type_id( definition.id ).is_valid(),
                                definition.id, "damage type" );
        }
        for( const damage_type_registration &entry : pimpl_->damage_types ) {
            const damage_type_definition_data &definition = *entry.definition;
            if( !definition.derived_from.empty() &&
                damage_type_ids.count( definition.derived_from ) == 0 &&
                !damage_type_id( definition.derived_from ).is_valid() ) {
                throw std::runtime_error( "damage type '" + definition.id +
                                          "' derives from unknown damage type '" +
                                          definition.derived_from + "'" );
            }
        }

        std::set<std::string> declared_item_ids;
        for( const item_registration &entry : pimpl_->items ) {
            declared_item_ids.insert( entry.definition->id );
        }
        std::set<std::string> declared_recipe_ids;
        for( const recipe_registration &entry : pimpl_->recipes ) {
            declared_recipe_ids.insert( entry.definition->id );
        }

        std::set<std::string> material_ids;
        for( const material_registration &entry : pimpl_->materials ) {
            const material_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "material" );
            if( definition.name.empty() || definition.bash_damage_verb.empty() ||
                definition.cut_damage_verb.empty() || definition.damage_adjectives.size() < 4 ||
                definition.chip_resistance < 0 || !native_int( definition.chip_resistance ) ||
                definition.breathability < 0 ||
                definition.breathability >= static_cast<std::int64_t>( breathability_rating::last ) ||
                definition.repair_difficulty < 0 || definition.repair_difficulty > MAX_SKILL ||
                !finite_native_float( definition.density ) || definition.density <= 0.0 ||
                !finite_native_float( definition.sheet_thickness ) || definition.sheet_thickness < 0.0 ||
                !finite_native_float( definition.specific_heat_liquid ) ||
                !finite_native_float( definition.specific_heat_solid ) ||
                !finite_native_float( definition.latent_heat ) ||
                !finite_native_float( definition.freezing_point ) ||
                !material_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "material '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            if( definition.wind_resistance && ( *definition.wind_resistance < 0 ||
                                                *definition.wind_resistance > 100 ) ) {
                throw std::runtime_error( "material '" + definition.id +
                                          "' has invalid wind resistance" );
            }
            for( const std::string &adjective : definition.damage_adjectives ) {
                if( adjective.empty() ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' has an empty damage adjective" );
                }
            }
            for( const auto &[damage_id, amount] : definition.resistances ) {
                if( damage_type_ids.count( damage_id ) == 0 &&
                    !damage_type_id( damage_id ).is_valid() ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' references unknown damage type '" + damage_id + "'" );
                }
                if( !finite_native_float( amount ) ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' has an invalid resistance" );
                }
            }
            for( const auto &[vitamin_key, amount] : definition.vitamins ) {
                if( vitamin_ids.count( vitamin_key ) == 0 && !vitamin_id( vitamin_key ).is_valid() ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' references unknown vitamin '" + vitamin_key + "'" );
                }
                if( !finite_native_float( amount ) ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' has an invalid vitamin amount" );
                }
            }
            const auto known_item = [&declared_item_ids]( const std::string & id ) {
                return id.empty() || declared_item_ids.count( id ) != 0 ||
                       item::type_is_defined( itype_id( id ) );
            };
            if( !known_item( definition.salvaged_into ) || !known_item( definition.repaired_with ) ) {
                throw std::runtime_error( "material '" + definition.id +
                                          "' references an unknown repair or salvage item" );
            }
            for( const auto &[product, efficiency] : definition.burn_products ) {
                if( !known_item( product ) || !finite_native_float( efficiency ) ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' references an invalid burn product '" + product + "'" );
                }
            }
            for( const material_burn_definition &burn : definition.burn_data ) {
                if( burn.volume_ml_per_turn < 0 || !native_int( burn.volume_ml_per_turn ) ||
                    !finite_native_float( burn.fuel ) || !finite_native_float( burn.smoke ) ||
                    !finite_native_float( burn.burn ) ) {
                    throw std::runtime_error( "material '" + definition.id +
                                              "' has invalid burn data" );
                }
            }
            validate_operation( entry.operation, material_id( definition.id ).is_valid(),
                                definition.id, "material" );
        }

        std::set<std::string> proficiency_category_ids;
        for( const proficiency_category_registration &entry : pimpl_->proficiency_categories ) {
            const proficiency_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "proficiency category" );
            if( definition.name.empty() || definition.description.empty() ||
                !proficiency_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "proficiency category '" + definition.id +
                                          "' requires name, description, and one registration per transaction" );
            }
            validate_operation( entry.operation, proficiency_category_id( definition.id ).is_valid(),
                                definition.id, "proficiency category" );
        }
        std::set<std::string> proficiency_ids;
        static const std::set<std::string> proficiency_attributes = {
            "strength", "dexterity", "intelligence", "perception", "stamina"
        };
        for( const proficiency_registration &entry : pimpl_->proficiencies ) {
            const proficiency_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "proficiency" );
            if( definition.name.empty() || definition.description.empty() || definition.category.empty() ||
                definition.time_to_learn_turns <= 0 || !native_int( definition.time_to_learn_turns ) ||
                !finite_native_float( definition.time_multiplier ) || definition.time_multiplier < 0.0 ||
                !finite_native_float( definition.skill_penalty ) || definition.skill_penalty < 0.0 ||
                !finite_native_float( definition.weakpoint_bonus ) ||
                !finite_native_float( definition.weakpoint_penalty ) ||
                !proficiency_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "proficiency '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            if( proficiency_category_ids.count( definition.category ) == 0 &&
                !proficiency_category_id( definition.category ).is_valid() ) {
                throw std::runtime_error( "proficiency '" + definition.id +
                                          "' references unknown category '" + definition.category + "'" );
            }
            for( const proficiency_bonus_definition &bonus : definition.bonuses ) {
                if( proficiency_attributes.count( bonus.attribute ) == 0 || bonus.category.empty() ||
                    !finite_native_float( bonus.value ) ) {
                    throw std::runtime_error( "proficiency '" + definition.id + "' has an invalid bonus" );
                }
            }
            validate_operation( entry.operation, proficiency_id( definition.id ).is_valid(),
                                definition.id, "proficiency" );
        }
        for( const proficiency_registration &entry : pimpl_->proficiencies ) {
            for( const std::string &required : entry.definition->required ) {
                if( proficiency_ids.count( required ) == 0 && !proficiency_id( required ).is_valid() ) {
                    throw std::runtime_error( "proficiency '" + entry.definition->id +
                                              "' requires unknown proficiency '" + required + "'" );
                }
            }
        }

        std::set<std::string> weapon_category_ids;
        for( const weapon_category_registration &entry : pimpl_->weapon_categories ) {
            const weapon_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "weapon category" );
            if( definition.name.empty() || !weapon_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "weapon category '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            for( const std::string &proficiency : definition.proficiencies ) {
                if( proficiency_ids.count( proficiency ) == 0 && !proficiency_id( proficiency ).is_valid() ) {
                    throw std::runtime_error( "weapon category '" + definition.id +
                                              "' references unknown proficiency '" + proficiency + "'" );
                }
            }
            validate_operation( entry.operation, weapon_category_id( definition.id ).is_valid(),
                                definition.id, "weapon category" );
        }

        std::set<std::string> item_category_ids;
        for( const item_category_registration &entry : pimpl_->item_categories ) {
            const item_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "item category" );
            if( definition.header.empty() || definition.noun.empty() || !native_int( definition.sort_rank ) ||
                !finite_native_float( definition.spawn_rate ) || definition.spawn_rate < 0.0 ||
                !item_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "item category '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            for( const item_category_priority_definition &priority : definition.priority_zones ) {
                if( priority.zone.empty() || ( !priority.filthy && priority.flags.empty() ) ) {
                    throw std::runtime_error( "item category '" + definition.id +
                                              "' has an unusable priority-zone rule" );
                }
                for( const std::string &flag : priority.flags ) {
                    if( json_flag_ids.count( flag ) == 0 && !flag_id( flag ).is_valid() ) {
                        throw std::runtime_error( "item category '" + definition.id +
                                                  "' references unknown flag '" + flag + "'" );
                    }
                }
            }
            validate_operation( entry.operation, item_category_id( definition.id ).is_valid(),
                                definition.id, "item category" );
        }

        std::set<std::string> crafting_category_ids;
        for( const crafting_category_registration &entry : pimpl_->crafting_categories ) {
            const crafting_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "recipe category" );
            if( definition.id.rfind( "CC_", 0 ) != 0 || definition.subcategories.empty() ||
                !crafting_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "recipe category '" + definition.id +
                                          "' requires a CC_ id, subcategories, and one registration per transaction" );
            }
            const std::string prefix = "CSC_" + definition.id.substr( 3 ) + "_";
            std::set<std::string> subcategory_ids;
            for( const std::string &subcategory : definition.subcategories ) {
                if( ( subcategory != "CSC_ALL" && subcategory.rfind( prefix, 0 ) != 0 ) ||
                    !subcategory_ids.insert( subcategory ).second ) {
                    throw std::runtime_error( "recipe category '" + definition.id +
                                              "' has an invalid or duplicate subcategory '" + subcategory + "'" );
                }
            }
            validate_operation( entry.operation, crafting_category_id( definition.id ).is_valid(),
                                definition.id, "recipe category" );
        }

        std::set<std::string> ammunition_type_ids;
        for( const ammunition_type_registration &entry : pimpl_->ammunition_types ) {
            const ammunition_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "ammunition type" );
            if( definition.name.empty() || !ammunition_type_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "ammunition type '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            if( !definition.default_item.empty() && definition.default_item != "components" &&
                definition.default_item != "thrown" && declared_item_ids.count( definition.default_item ) == 0 &&
                !item::type_is_defined( itype_id( definition.default_item ) ) ) {
                throw std::runtime_error( "ammunition type '" + definition.id +
                                          "' references unknown default item '" + definition.default_item + "'" );
            }
            validate_operation( entry.operation, ammotype( definition.id ).is_valid(),
                                definition.id, "ammunition type" );
        }

        std::set<std::string> requirement_ids;
        for( const requirement_registration &entry : pimpl_->requirements ) {
            const requirement_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "requirement" );
            if( definition.components.empty() && definition.tools.empty() && definition.qualities.empty() ) {
                throw std::runtime_error( "requirement '" + definition.id + "' must contain native requirements" );
            }
            if( !requirement_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "requirement '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
        }
        const auto validate_requirement_groups = [&]( const std::string & id,
                const std::vector<std::vector<component_requirement>> &groups,
        const char *kind, const bool tools ) {
            for( const std::vector<component_requirement> &group : groups ) {
                if( group.empty() ) {
                    throw std::runtime_error( "requirement '" + id +
                                              "' has an empty alternative group" );
                }
                for( const component_requirement &component : group ) {
                    if( component.id.empty() || ( tools ? component.count == 0 : component.count <= 0 ) ||
                        !native_int( component.count ) ) {
                        throw std::runtime_error( "requirement '" + id + "' has an invalid " + kind );
                    }
                    const bool valid = component.requirement ?
                                       requirement_ids.count( component.id ) != 0 ||
                                       requirement_data::registry().count( requirement_id( component.id ) ) != 0 :
                                       declared_item_ids.count( component.id ) != 0 ||
                                       item::type_is_defined( itype_id( component.id ) );
                    if( !valid ) {
                        throw std::runtime_error( "requirement '" + id + "' references unknown " +
                                                  ( component.requirement ? std::string( "requirement" ) : kind ) +
                                                  " '" + component.id + "'" );
                    }
                }
            }
        };
        for( const requirement_registration &entry : pimpl_->requirements ) {
            const requirement_definition_data &definition = *entry.definition;
            validate_requirement_groups( definition.id, definition.components, "component", false );
            validate_requirement_groups( definition.id, definition.tools, "tool", true );
            for( const std::vector<quality_requirement_definition> &group : definition.qualities ) {
                if( group.empty() ) {
                    throw std::runtime_error( "requirement '" + definition.id +
                                              "' has an empty quality alternative group" );
                }
                for( const quality_requirement_definition &quality : group ) {
                    if( quality.id.empty() || quality.level <= 0 || !native_int( quality.level ) ||
                        quality.count <= 0 || !native_int( quality.count ) ||
                        ( tool_quality_ids.count( quality.id ) == 0 && !quality_id( quality.id ).is_valid() ) ) {
                        throw std::runtime_error( "requirement '" + definition.id +
                                                  "' references an invalid quality" );
                    }
                }
            }
            validate_operation( entry.operation,
                                requirement_data::registry().count( requirement_id( definition.id ) ) != 0,
                                definition.id, "requirement" );
        }

        std::set<std::string> recipe_group_ids;
        static const std::set<std::string> recipe_group_match_types = {
            "EXACT", "TYPE", "SUBTYPE", "PREFIX", "CONTAINS"
        };
        for( const recipe_group_registration &entry : pimpl_->recipe_groups ) {
            const recipe_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "recipe group" );
            if( definition.building_type.empty() || !recipe_group_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "recipe group '" + definition.id +
                                          "' requires a building type and one registration per transaction" );
            }
            std::set<std::string> group_recipe_ids;
            for( const recipe_group_recipe_data &recipe : definition.recipes ) {
                if( recipe.id.empty() || recipe.description.empty() ||
                    !group_recipe_ids.insert( recipe.id ).second ) {
                    throw std::runtime_error( "recipe group '" + definition.id +
                                              "' has an invalid or duplicate recipe entry" );
                }
                if( declared_recipe_ids.count( recipe.id ) == 0 && !recipe_id( recipe.id ).is_valid() ) {
                    throw std::runtime_error( "recipe group '" + definition.id +
                                              "' references unknown recipe '" + recipe.id + "'" );
                }
                for( const recipe_group_terrain_data &terrain : recipe.terrains ) {
                    std::string match_type = terrain.match_type;
                    std::transform( match_type.begin(), match_type.end(), match_type.begin(),
                    []( const unsigned char ch ) {
                        return static_cast<char>( std::toupper( ch ) );
                    } );
                    if( terrain.overmap_terrain.empty() || recipe_group_match_types.count( match_type ) == 0 ) {
                        throw std::runtime_error( "recipe group '" + definition.id +
                                                  "' has an invalid overmap-terrain matcher" );
                    }
                    for( const auto &[parameter, values] : terrain.parameters ) {
                        if( parameter.empty() || values.empty() || values.count( "" ) != 0 ) {
                            throw std::runtime_error( "recipe group '" + definition.id +
                                                      "' has an invalid terrain parameter" );
                        }
                    }
                }
            }
            validate_operation( entry.operation, detail::recipe_group_exists( definition.id ),
                                definition.id, "recipe group" );
        }

        std::set<std::string> scent_type_ids;
        for( const scent_type_registration &entry : pimpl_->scent_types ) {
            const scent_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "scent type" );
            if( definition.receptive_species.empty() || !scent_type_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "scent type '" + definition.id +
                                          "' requires receptive species and one registration per transaction" );
            }
            for( const std::string &species : definition.receptive_species ) {
                if( !species_id( species ).is_valid() ) {
                    throw std::runtime_error( "scent type '" + definition.id +
                                              "' references unknown species '" + species + "'" );
                }
            }
            validate_operation( entry.operation, scenttype_id( definition.id ).is_valid(),
                                definition.id, "scent type" );
        }

        std::set<std::string> butchery_requirement_ids;
        for( const butchery_requirement_registration &entry : pimpl_->butchery_requirement_entries ) {
            const butchery_requirement_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "butchery requirement" );
            if( definition.entries.empty() || !butchery_requirement_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "butchery requirement '" + definition.id +
                                          "' requires entries and one registration per transaction" );
            }
            for( const auto &requirement : definition.entries ) {
                if( !finite_native_float( requirement.speed ) || requirement.speed < 0.0 ||
                    !platform_creature_size( requirement.size ) || !platform_butcher_type( requirement.butcher ) ||
                    !requirement_id( requirement.requirement ).is_valid() ) {
                    throw std::runtime_error( "butchery requirement '" + definition.id +
                                              "' has an invalid entry" );
                }
            }
            validate_operation( entry.operation,
                                string_id<butchery_requirements>( definition.id ).is_valid(),
                                definition.id, "butchery requirement" );
        }

        std::set<std::string> item_action_ids;
        for( const item_action_registration &entry : pimpl_->item_actions ) {
            const item_action_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "item action" );
            if( definition.name.empty() || !item_action_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "item action '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            validate_operation( entry.operation,
                                detail::item_action_registry_find( definition.id ) != nullptr,
                                definition.id, "item action" );
        }

        std::set<std::string> item_group_ids;
        std::map<std::string, std::vector<std::string>> item_group_children;
        for( const item_group_registration &entry : pimpl_->item_groups ) {
            const item_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "item group" );
            if( !item_group_ids.insert( definition.id ).second ||
                ( definition.kind != "collection" && definition.kind != "distribution" ) ||
                definition.with_ammo < 0 || definition.with_ammo > 100 ||
                definition.with_magazine < 0 || definition.with_magazine > 100 ) {
                throw std::runtime_error( "item group '" + definition.id +
                                          "' has invalid kind, chances, or duplicate registration" );
            }
            item_group_children.emplace( definition.id, std::vector<std::string>() );
            validate_operation( entry.operation,
                                item_group::group_is_defined( item_group_id( definition.id ) ),
                                definition.id, "item group" );
            if( entry.operation == definition_operation::extend ) {
                if( definition.with_ammo != 0 || definition.with_magazine != 0 ) {
                    throw std::runtime_error( "item group extension '" + definition.id +
                                              "' may only append entries" );
                }
                if( check_engine_state ) {
                    const auto existing = item_controller->m_template_groups.find(
                                              item_group_id( definition.id ) );
                    const Item_group *const native = existing == item_controller->m_template_groups.end() ?
                                                     nullptr : dynamic_cast<const Item_group *>( existing->second.get() );
                    const Item_group::Type expected = definition.kind == "collection" ?
                                                      Item_group::G_COLLECTION : Item_group::G_DISTRIBUTION;
                    if( native == nullptr || native->type != expected ) {
                        throw std::runtime_error( "item group extension '" + definition.id +
                                                  "' must match the existing group kind" );
                    }
                }
            }
        }
        for( const item_group_registration &entry : pimpl_->item_groups ) {
            const item_group_definition_data &definition = *entry.definition;
            for( const item_group_entry_definition_data &group_entry : definition.entries ) {
                const bool probability_valid = definition.kind == "collection" ?
                                               group_entry.probability > 0 && group_entry.probability <= 100 :
                                               group_entry.probability > 0 && native_int( group_entry.probability );
                if( group_entry.id.empty() || !probability_valid || group_entry.variant.size() > 256 ||
                    group_entry.variant.find( '\0' ) != std::string::npos || group_entry.count_min < 0 ||
                    group_entry.count_max < group_entry.count_min || !native_int( group_entry.count_max ) ||
                    group_entry.charges_min < -1 || group_entry.charges_max < group_entry.charges_min ||
                    !native_int( group_entry.charges_max ) ||
                    ( group_entry.group && ( !group_entry.variant.empty() ||
                                             group_entry.charges_min != -1 || group_entry.charges_max != -1 ) ) ) {
                    throw std::runtime_error( "item group '" + definition.id + "' contains an invalid entry" );
                }
                if( group_entry.group ) {
                    if( group_entry.id == definition.id ||
                        ( item_group_ids.count( group_entry.id ) == 0 && check_engine_state &&
                          !item_group::group_is_defined( item_group_id( group_entry.id ) ) ) ) {
                        throw std::runtime_error( "item group '" + definition.id +
                                                  "' references unknown or recursive group '" + group_entry.id + "'" );
                    }
                    if( item_group_ids.count( group_entry.id ) != 0 ) {
                        item_group_children[definition.id].push_back( group_entry.id );
                    }
                }
            }
        }
        std::set<std::string> visiting_item_groups;
        std::set<std::string> visited_item_groups;
        std::function<void( const std::string & )> visit_item_group;
        visit_item_group = [&]( const std::string & id ) {
            if( visited_item_groups.count( id ) != 0 ) {
                return;
            }
            if( !visiting_item_groups.insert( id ).second ) {
                throw std::runtime_error( "item-group graph contains a cycle at '" + id + "'" );
            }
            for( const std::string &child : item_group_children.at( id ) ) {
                visit_item_group( child );
            }
            visiting_item_groups.erase( id );
            visited_item_groups.insert( id );
        };
        for( const auto &[id, children] : item_group_children ) {
            static_cast<void>( children );
            visit_item_group( id );
        }

        std::set<std::string> ammo_effect_ids;
        const auto defines_explosion_light = [&context]( const std::string & id ) {
            return id.empty() || ( context.defines_explosion_light && context.defines_explosion_light( id ) ) ||
                   explosion_light_str_id( id ).is_valid();
        };
        for( const ammo_effect_registration &entry : pimpl_->ammo_effects ) {
            const ammo_effect_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "ammo effect" );
            const auto percent = []( const std::int64_t value ) {
                return value >= 0 && value <= 100;
            };
            if( !ammo_effect_ids.insert( definition.id ).second || !percent( definition.trigger_chance ) ) {
                throw std::runtime_error( "ammo effect '" + definition.id +
                                          "' has a duplicate id or invalid trigger chance" );
            }
            const auto validate_field = [&]( const ammo_field_definition_data & field, const bool trail ) {
                if( field.field.empty() || !native_nonnegative_int( field.intensity_min ) ||
                    !native_nonnegative_int( field.intensity_max ) || field.intensity_max < field.intensity_min ||
                    !percent( field.chance ) || ( !trail && ( !native_nonnegative_int( field.radius ) ||
                                                  !native_nonnegative_int( field.height ) || !native_nonnegative_int( field.footprint ) ) ) ||
                    ( check_engine_state && !field_type_str_id( field.field ).is_valid() ) ) {
                    throw std::runtime_error( "ammo effect '" + definition.id + "' has an invalid " +
                                              ( trail ? "trail" : "field burst" ) );
                }
            };
            for( const ammo_field_definition_data &field : definition.field_bursts ) {
                validate_field( field, false );
            }
            for( const ammo_field_definition_data &field : definition.trails ) {
                validate_field( field, true );
            }
            const auto validate_character_effect = [&]( const ammo_character_effect_definition_data & effect,
            const bool area ) {
                if( effect.effect.empty() || effect.duration_turns <= 0 || !native_int( effect.duration_turns ) ||
                    effect.intensity_min <= 0 || !native_nonnegative_int( effect.intensity_max ) ||
                    effect.intensity_max < effect.intensity_min || ( area && ( !percent( effect.chance ) ||
                            !native_nonnegative_int( effect.radius ) || effect.hits_min <= 0 ||
                            effect.hits_max < effect.hits_min || !native_nonnegative_int( effect.hits_max ) ) ) ||
                    ( check_engine_state && !efftype_id( effect.effect ).is_valid() ) ) {
                    throw std::runtime_error( "ammo effect '" + definition.id + "' has an invalid " +
                                              ( area ? "area effect" : "on-hit effect" ) );
                }
            };
            for( const ammo_character_effect_definition_data &effect : definition.on_hit_effects ) {
                validate_character_effect( effect, false );
            }
            for( const ammo_character_effect_definition_data &effect : definition.area_effects ) {
                validate_character_effect( effect, true );
            }
            if( definition.has_explosion && ( !finite_native_float( definition.explosion_power ) ||
                                              definition.explosion_power < 0.0 || !finite_native_float( definition.explosion_distance_factor ) ||
                                              definition.explosion_distance_factor < 0.0 || definition.explosion_distance_factor > 1.0 ||
                                              !native_nonnegative_int( definition.explosion_max_noise ) ||
                                              !native_nonnegative_int( definition.casing_mass ) ||
                                              !finite_native_float( definition.fragment_mass ) ||
                                              definition.fragment_mass <= 0.0 || !percent( definition.fragment_recovery ) ||
                                              ( check_engine_state && !defines_explosion_light( definition.explosion_light ) ) ||
                                              ( check_engine_state && definition.fragment_drop != "null" &&
                                                declared_item_ids.count( definition.fragment_drop ) == 0 &&
                                                !item::type_is_defined( itype_id( definition.fragment_drop ) ) ) ) ) {
                throw std::runtime_error( "ammo effect '" + definition.id +
                                          "' has invalid explosion or shrapnel values" );
            }
            if( definition.has_shrapnel && !definition.has_explosion ) {
                throw std::runtime_error( "ammo effect '" + definition.id +
                                          "' attaches shrapnel without an explosion" );
            }
            for( const ammo_spell_definition_data &spell : definition.spells ) {
                if( spell.spell.empty() || spell.level < 0 || !native_int( spell.level ) ||
                    ( check_engine_state && !spell_id( spell.spell ).is_valid() ) ) {
                    throw std::runtime_error( "ammo effect '" + definition.id + "' has an invalid spell" );
                }
            }
            if( !definition.impact_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.impact_handler ) ) {
                throw std::runtime_error( "ammo effect '" + definition.id +
                                          "' references missing impact handler '" + definition.impact_handler + "'" );
            }
            validate_operation( entry.operation, ammo_effect_str_id( definition.id ).is_valid(),
                                definition.id, "ammo effect" );
        }

        std::vector<std::size_t> item_order;
        std::string inheritance_error;
        if( !detail::resolve_platform_inheritance_order( pimpl_->items,
        []( const item_registration & entry ) {
        return entry.definition->id;
    },
    []( const item_registration & entry ) {
        return entry.definition->copy_from;
    },
    [check_engine_state]( const std::string & id ) {
        if( !check_engine_state ) {
                return true;
            }
            const itype_id native_id( id );
            const generic_factory<itype> &factory = item_controller->get_generic_factory();
            return item::type_is_defined( native_id ) || factory.is_valid( native_id ) ||
                   factory.find_abstract( id ) != nullptr;
        }, item_order, inheritance_error, "item" ) ) {
            throw std::runtime_error( inheritance_error );
        }
        std::set<std::string> item_ids;
        for( const std::size_t index : item_order ) {
            const item_registration &entry = pimpl_->items[index];
            const item_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "item" );
            if( definition.copy_from.empty() && ( definition.name.empty() || definition.symbol.empty() ) ) {
                throw std::runtime_error( "item '" + definition.id + "' requires a name and symbol" );
            }
            if( !item_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "item '" + definition.id +
                                          "' is registered more than once in one transaction" );
            }
            if( !definition.copy_from.empty() && check_engine_state &&
                declared_item_ids.count( definition.copy_from ) == 0 &&
                !item::type_is_defined( itype_id( definition.copy_from ) ) &&
                item_controller->get_generic_factory().find_abstract( definition.copy_from ) == nullptr ) {
                throw std::runtime_error( "item '" + definition.id +
                                          "' copies unknown item '" + definition.copy_from + "'" );
            }
            if( definition.has_color &&
                color_from_string( definition.color, report_color_error::no ) == c_unset ) {
                throw std::runtime_error( "item '" + definition.id + "' has an invalid color" );
            }
            std::int64_t material_portions = 0;
            std::map<std::string, std::int64_t> portions_by_material;
            for( const material_part &material : definition.materials ) {
                if( material_ids.count( material.id ) == 0 && !material_id( material.id ).is_valid() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' references unknown material '" + material.id + "'" );
                }
                material_portions += material.portions;
                portions_by_material[material.id] += material.portions;
                if( material_portions > std::numeric_limits<int>::max() ||
                    portions_by_material[material.id] > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "item '" + definition.id + "' has too many material portions" );
                }
            }
            for( const quality_level &quality : definition.qualities ) {
                if( tool_quality_ids.count( quality.id ) == 0 && !quality_id( quality.id ).is_valid() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' references unknown quality '" + quality.id + "'" );
                }
                if( quality.level <= 0 || !native_int( quality.level ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has an invalid quality level" );
                }
            }
            for( const std::string &flag : definition.flags ) {
                if( json_flag_ids.count( flag ) == 0 && !flag_id( flag ).is_valid() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' references unknown flag '" + flag + "'" );
                }
            }
            for( const auto &[damage, amount] : definition.melee_damage ) {
                if( damage_type_ids.count( damage ) == 0 && !damage_type_id( damage ).is_valid() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' references unknown damage type '" + damage + "'" );
                }
                if( !finite_native_float( amount ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has invalid melee damage" );
                }
            }
            for( const auto &[ammo, capacity] : definition.magazine_ammo ) {
                if( ammo.empty() || capacity <= 0 || !native_int( capacity ) ||
                    ( ammunition_type_ids.count( ammo ) == 0 && !ammotype( ammo ).is_valid() ) ) {
                    throw std::runtime_error( "item '" + definition.id + "' has invalid magazine ammo" );
                }
            }
            if( definition.has_magazine_capacity &&
                ( definition.magazine_capacity <= 0 || !native_int( definition.magazine_capacity ) ) ) {
                throw std::runtime_error( "item '" + definition.id + "' has an invalid magazine capacity" );
            }
            if( definition.has_category && item_category_ids.count( definition.category ) == 0 &&
                !item_category_id( definition.category ).is_valid() ) {
                throw std::runtime_error( "item '" + definition.id +
                                          "' references unknown category '" + definition.category + "'" );
            }
            if( definition.has_looks_like && check_engine_state &&
                !item::type_is_defined( itype_id( definition.looks_like ) ) &&
                declared_item_ids.count( definition.looks_like ) == 0 ) {
                throw std::runtime_error( "item '" + definition.id +
                                          "' references unknown looks_like item '" + definition.looks_like + "'" );
            }
            if( definition.comestible ) {
                const item_definition_data::comestible_data &food = *definition.comestible;
                if( ( food.type != "FOOD" && food.type != "DRINK" ) ||
                    food.calories < 0 || food.calories > std::numeric_limits<int>::max() ||
                    food.fun < std::numeric_limits<int>::min() ||
                    food.fun > std::numeric_limits<int>::max() ||
                    food.healthy < std::numeric_limits<int>::min() ||
                    food.healthy > std::numeric_limits<int>::max() ||
                    food.quench < std::numeric_limits<int>::min() ||
                    food.quench > std::numeric_limits<int>::max() ||
                    food.spoils_in_turns < 0 ||
                    food.spoils_in_turns > std::numeric_limits<int>::max() ||
                    food.charges <= 0 || food.charges > std::numeric_limits<int>::max() ||
                    food.stack_size <= 0 ||
                    food.stack_size > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' has invalid comestible values" );
                }
                for( const auto &[vitamin_key, amount] : food.vitamins ) {
                    if( ( vitamin_ids.count( vitamin_key ) == 0 &&
                          !vitamin_id( vitamin_key ).is_valid() ) ||
                        amount < std::numeric_limits<int>::min() ||
                        amount > std::numeric_limits<int>::max() ) {
                        throw std::runtime_error( "item '" + definition.id +
                                                  "' references an invalid vitamin '" +
                                                  vitamin_key + "'" );
                    }
                }
            }
            if( definition.book ) {
                const item_definition_data::book_data &book = *definition.book;
                if( book.skill.empty() ||
                    ( skill_ids.count( book.skill ) == 0 &&
                      !skill_id( book.skill ).is_valid() ) ||
                    book.required_level < 0 || book.required_level > MAX_SKILL ||
                    book.maximum_level < book.required_level ||
                    book.maximum_level > MAX_SKILL || book.intelligence < 0 ||
                    book.intelligence > std::numeric_limits<int>::max() ||
                    book.read_time_turns <= 0 ||
                    book.read_time_turns > std::numeric_limits<int>::max() ||
                    book.fun < std::numeric_limits<int>::min() ||
                    book.fun > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' has invalid book values" );
                }
            }
            validate_operation( entry.operation,
                                item_controller->has_template( itype_id( definition.id ) ),
                                definition.id, "item" );
            if( !definition.use_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.use_handler ) ) {
                throw std::runtime_error( "item '" + definition.id +
                                          "' references missing handler '" + definition.use_handler + "'" );
            }
            if( !definition.consume_handler.empty() ) {
                if( !runtime_has_handler( owner_runtime, definition.consume_handler ) ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' references missing consumption handler '" +
                                              definition.consume_handler + "'" );
                }
                const itype *base = nullptr;
                if( !definition.copy_from.empty() ) {
                    base = item::find_type( itype_id( definition.copy_from ) );
                } else if( item::type_is_defined( itype_id( definition.id ) ) ) {
                    base = item::find_type( itype_id( definition.id ) );
                }
                if( check_engine_state && !definition.comestible && base != nullptr &&
                    !base->comestible ) {
                    throw std::runtime_error( "item '" + definition.id +
                                              "' attaches on_consume to a non-comestible item" );
                }
            }
        }

        std::set<std::string> recipe_ids;
        for( const recipe_registration &entry : pimpl_->recipes ) {
            const recipe_definition_data &definition = *entry.definition;
            require_valid_id( definition.id,
                              definition.nested_category ? "nested recipe category" : "recipe" );
            if( !recipe_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' is registered more than once in one transaction" );
            }
            const bool exists = definition.uncraft ?
                                recipe_dict.uncraft.count( recipe_id( definition.result ) ) != 0 :
                                recipe_dict.recipes.count( recipe_id( definition.id ) ) != 0;
            validate_operation( entry.operation, exists, definition.id,
                                definition.nested_category ? "nested recipe category" : "recipe" );
            if( definition.nested_category ) {
                if( definition.name.empty() || definition.category.empty() || definition.subcategory.empty() ||
                    definition.nested_recipes.empty() || !finite_native_float( definition.activity_level ) ||
                    definition.activity_level <= 0.0 ) {
                    throw std::runtime_error( "nested recipe category '" + definition.id +
                                              "' has invalid presentation, activity, or members" );
                }
                if( crafting_category_ids.count( definition.category ) == 0 &&
                    !crafting_category_id( definition.category ).is_valid() ) {
                    throw std::runtime_error( "nested recipe category '" + definition.id +
                                              "' references unknown category '" + definition.category + "'" );
                }
                if( check_engine_state ) {
                    for( const std::string &member : definition.nested_recipes ) {
                        if( declared_recipe_ids.count( member ) == 0 &&
                            recipe_dict.recipes.count( recipe_id( member ) ) == 0 ) {
                            throw std::runtime_error( "nested recipe category '" + definition.id +
                                                      "' references unknown recipe '" + member + "'" );
                        }
                    }
                }
                continue;
            }
            if( definition.result.empty() || definition.time_moves <= 0 ||
                definition.difficulty < 0 || definition.difficulty > MAX_SKILL ||
                !finite_native_float( definition.activity_level ) || definition.activity_level <= 0.0 ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' has invalid result, duration, difficulty, or activity" );
            }
            if( crafting_category_ids.count( definition.category ) == 0 &&
                !crafting_category_id( definition.category ).is_valid() ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' references unknown category '" + definition.category + "'" );
            }
            if( !definition.skill.empty() && skill_ids.count( definition.skill ) == 0 &&
                !skill_id( definition.skill ).is_valid() ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' references unknown skill '" + definition.skill + "'" );
            }
            for( const auto &[skill, level] : definition.required_skills ) {
                if( ( skill_ids.count( skill ) == 0 && !skill_id( skill ).is_valid() ) ||
                    level < 0 || level > MAX_SKILL ) {
                    throw std::runtime_error( "recipe '" + definition.id +
                                              "' has an invalid required skill '" + skill + "'" );
                }
            }
            for( const auto &[requirement, multiplier] : definition.external_requirements ) {
                if( multiplier <= 0 || !native_int( multiplier ) ||
                    ( requirement_ids.count( requirement ) == 0 &&
                      requirement_data::registry().count( requirement_id( requirement ) ) == 0 ) ) {
                    throw std::runtime_error( "recipe '" + definition.id +
                                              "' references invalid requirement '" + requirement + "'" );
                }
            }
            const auto validate_recipe_groups = [&]( const std::vector<std::vector<component_requirement>>
                                                &groups,
            const char *kind, const bool tools ) {
                for( const std::vector<component_requirement> &group : groups ) {
                    if( group.empty() ) {
                        throw std::runtime_error( "recipe '" + definition.id +
                                                  "' has an empty " + kind + " group" );
                    }
                    for( const component_requirement &component : group ) {
                        if( component.id.empty() || ( tools ? component.count == 0 : component.count <= 0 ) ||
                            !native_int( component.count ) ) {
                            throw std::runtime_error( "recipe '" + definition.id + "' has an invalid " + kind );
                        }
                        const bool valid = component.requirement ?
                                           requirement_ids.count( component.id ) != 0 ||
                                           requirement_data::registry().count( requirement_id( component.id ) ) != 0 :
                                           declared_item_ids.count( component.id ) != 0 ||
                                           item::type_is_defined( itype_id( component.id ) );
                        if( !valid ) {
                            throw std::runtime_error( "recipe '" + definition.id +
                                                      "' references unknown " +
                                                      ( component.requirement ? std::string( "requirement" ) : kind ) +
                                                      " '" + component.id + "'" );
                        }
                    }
                }
            };
            if( definition.result_charges &&
                ( *definition.result_charges <= 0 ||
                  *definition.result_charges > std::numeric_limits<int>::max() ) ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' has invalid result charges" );
            }
            validate_recipe_groups( definition.components, "component", false );
            validate_recipe_groups( definition.tools, "tool", true );
            for( const recipe_definition_data::proficiency_data &proficiency : definition.proficiencies ) {
                if( proficiency.id.empty() ||
                    ( check_engine_state && !proficiency_id( proficiency.id ).is_valid() ) ||
                    !finite_native_float( proficiency.time_multiplier ) ||
                    !finite_native_float( proficiency.skill_penalty ) ) {
                    throw std::runtime_error( "recipe '" + definition.id + "' has an invalid proficiency" );
                }
            }
            for( const auto &[book, level] : definition.books ) {
                if( book.empty() || level < 0 || level > MAX_SKILL ||
                    ( check_engine_state && !item::type_is_defined( itype_id( book ) ) &&
                      declared_item_ids.count( book ) == 0 ) ) {
                    throw std::runtime_error( "recipe '" + definition.id + "' has an invalid book" );
                }
            }
            if( !definition.result_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.result_handler ) ) {
                throw std::runtime_error( "recipe '" + definition.id +
                                          "' references missing completion handler '" + definition.result_handler + "'" );
            }
        }

        static const std::set<std::string> plant_lifecycle_phases = {
            "plant", "grow", "mature", "overgrow", "harvest", "fertilize", "water"
        };
        std::set<std::pair<std::string, std::string>> plant_lifecycle_targets;
        for( const plant_lifecycle_registration &entry : pimpl_->plant_lifecycles ) {
            const plant_lifecycle_definition_data &definition = *entry.definition;
            if( entry.operation != definition_operation::add || definition.id.empty() ||
                definition.id.find( '#' ) != std::string::npos ||
                ( definition.target != "seed" && definition.target != "furniture" ) ||
                definition.handlers.empty() ||
                !plant_lifecycle_targets.emplace( definition.target, definition.id ).second ) {
                throw std::runtime_error( "plant lifecycle definition has an invalid or duplicate target" );
            }
            if( check_engine_state ) {
                if( definition.target == "seed" ) {
                    if( declared_item_ids.count( definition.id ) == 0 &&
                        !item::type_is_defined( itype_id( definition.id ) ) ) {
                        throw std::runtime_error( "plant lifecycle references unknown seed item '" +
                                                  definition.id + "'" );
                    }
                } else if( context.defines_furniture && !context.defines_furniture( definition.id ) &&
                           !furn_str_id( definition.id ).is_valid() ) {
                    throw std::runtime_error( "plant lifecycle references unknown furniture '" +
                                              definition.id + "'" );
                }
            }
            for( const auto &[phase, handler] : definition.handlers ) {
                if( plant_lifecycle_phases.count( phase ) == 0 || handler.empty() ||
                    !runtime_has_handler( owner_runtime, handler ) ) {
                    throw std::runtime_error( "plant lifecycle '" + definition.target + ":" + definition.id +
                                              "' has an invalid " + phase + " handler" );
                }
            }
        }
    } catch( const std::exception &exception ) {
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
    error.clear();
    return true;
}

bool items_content_transaction::validate_scaled_requirement_set(
    const std::vector<std::pair<std::string, std::int64_t>> &requirements,
    std::string &error ) const
{
    try {
        struct scaled_requirement_component {
            std::string type;
            bool is_requirement = false;
            std::int64_t count = 0;
        };
        using scaled_requirement_groups =
            std::vector<std::vector<scaled_requirement_component>>;
        scaled_requirement_groups scaled_component_groups;
        scaled_requirement_groups scaled_tool_groups;
        std::set<std::string> ids;
        for( const std::pair<std::string, std::int64_t> &requirement : requirements ) {
            const std::string &id = requirement.first;
            const std::int64_t count = requirement.second;
            if( id.empty() || id.size() > 256 || id.find( '\0' ) != std::string::npos ||
                count <= 0 || count > std::numeric_limits<int>::max() ||
                !ids.insert( id ).second ) {
                throw std::runtime_error( "has invalid requirement '" + id + "'" );
            }
            const auto staged = std::find_if(
                                    pimpl_->requirements.begin(), pimpl_->requirements.end(),
            [&id]( const requirement_registration & entry ) {
                return entry.definition->id == id;
            } );
            const auto existing = requirement_data::registry().find( requirement_id( id ) );
            if( staged == pimpl_->requirements.end() &&
                existing == requirement_data::registry().end() ) {
                throw std::runtime_error( "has invalid requirement '" + id + "'" );
            }
            const auto scaled_counts_fit = [count]( const auto & groups ) {
                constexpr std::int64_t native_min = std::numeric_limits<int>::min();
                constexpr std::int64_t native_max = std::numeric_limits<int>::max();
                for( const auto &group : groups ) {
                    for( const auto &component : group ) {
                        const std::int64_t component_count = component.count;
                        if( ( component_count < 0 && component_count < native_min / count ) ||
                            ( component_count > 0 && component_count > native_max / count ) ) {
                            return false;
                        }
                    }
                }
                return true;
            };
            const auto append_scaled_groups = [count](
                                                  const auto & groups,
                                                  scaled_requirement_groups & target,
            const auto & type_of, const auto & is_requirement ) {
                for( const auto &group : groups ) {
                    std::vector<scaled_requirement_component> scaled_group;
                    scaled_group.reserve( group.size() );
                    for( const auto &component : group ) {
                        const std::int64_t scaled_count =
                            static_cast<std::int64_t>( component.count ) * count;
                        scaled_group.push_back( {
                            type_of( component ), is_requirement( component ),
                            std::max<std::int64_t>( scaled_count, -1 )
                        } );
                    }
                    target.push_back( std::move( scaled_group ) );
                }
            };
            bool counts_fit = false;
            if( staged != pimpl_->requirements.end() ) {
                counts_fit = scaled_counts_fit( staged->definition->components ) &&
                             scaled_counts_fit( staged->definition->tools );
                if( counts_fit ) {
                    append_scaled_groups(
                        staged->definition->components, scaled_component_groups,
                    []( const component_requirement & component ) {
                        return component.id;
                    }, []( const component_requirement & component ) {
                        return component.requirement;
                    } );
                    append_scaled_groups(
                        staged->definition->tools, scaled_tool_groups,
                    []( const component_requirement & component ) {
                        return component.id;
                    }, []( const component_requirement & component ) {
                        return component.requirement;
                    } );
                }
            } else {
                counts_fit = scaled_counts_fit( existing->second.get_components() ) &&
                             scaled_counts_fit( existing->second.get_tools() );
                if( counts_fit ) {
                    append_scaled_groups(
                        existing->second.get_components(), scaled_component_groups,
                    []( const item_comp & component ) {
                        return component.type.str();
                    }, []( const item_comp & component ) {
                        return component.requirement;
                    } );
                    append_scaled_groups(
                        existing->second.get_tools(), scaled_tool_groups,
                    []( const tool_comp & component ) {
                        return component.type.str();
                    }, []( const tool_comp & component ) {
                        return component.requirement;
                    } );
                }
            }
            if( !counts_fit ) {
                throw std::runtime_error(
                    "requirement '" + id +
                    "' exceeds the native component/tool count range when scaled" );
            }
        }
        const auto consolidated_counts_fit = []( scaled_requirement_groups old_groups,
        const bool tools ) {
            const auto type_less = []( const scaled_requirement_component & lhs,
            const scaled_requirement_component & rhs ) {
                return std::tie( lhs.type, lhs.is_requirement ) <
                       std::tie( rhs.type, rhs.is_requirement );
            };
            for( std::vector<scaled_requirement_component> &group : old_groups ) {
                std::sort( group.begin(), group.end(), type_less );
            }
            std::sort( old_groups.begin(), old_groups.end(),
            [&type_less]( const auto & lhs, const auto & rhs ) {
                return std::lexicographical_compare(
                           lhs.begin(), lhs.end(), rhs.begin(), rhs.end(), type_less );
            } );
            std::vector<std::vector<scaled_requirement_component>> consolidated;
            for( std::vector<scaled_requirement_component> &old_group : old_groups ) {
                bool match = false;
                for( std::vector<scaled_requirement_component> &new_group : consolidated ) {
                    if( std::includes( new_group.begin(), new_group.end(),
                                       old_group.begin(), old_group.end(), type_less ) ) {
                        match = true;
                        std::swap( old_group, new_group );
                    } else if( std::includes( old_group.begin(), old_group.end(),
                                              new_group.begin(), new_group.end(), type_less ) ) {
                        match = true;
                    }
                    if( !match ) {
                        continue;
                    }
                    auto old_component = old_group.begin();
                    for( auto new_component = new_group.begin();
                         new_component != new_group.end(); ++old_component ) {
                        if( !type_less( *old_component, *new_component ) ) {
                            if( tools ) {
                                if( new_component->count < 0 && old_component->count < 0 ) {
                                    new_component->count = std::min(
                                                               new_component->count,
                                                               old_component->count );
                                } else if( new_component->count > 0 && old_component->count > 0 ) {
                                    const std::int64_t sum =
                                        new_component->count + old_component->count;
                                    if( sum > std::numeric_limits<int>::max() ) {
                                        return false;
                                    }
                                    new_component->count = sum;
                                }
                            } else {
                                const std::int64_t sum =
                                    new_component->count + old_component->count;
                                if( sum < std::numeric_limits<int>::min() ||
                                    sum > std::numeric_limits<int>::max() ) {
                                    return false;
                                }
                                new_component->count = sum;
                            }
                            ++new_component;
                        }
                    }
                    break;
                }
                if( !match ) {
                    consolidated.push_back( std::move( old_group ) );
                }
            }
            return true;
        };
        if( !consolidated_counts_fit( std::move( scaled_component_groups ), false ) ||
            !consolidated_counts_fit( std::move( scaled_tool_groups ), true ) ) {
            throw std::runtime_error(
                "combined requirements exceed the native count range during consolidation" );
        }
    } catch( const std::exception &exception ) {
        error = exception.what();
        return false;
    }
    error.clear();
    return true;
}

bool items_content_transaction::apply_phase( const items_content_apply_phase phase,
        std::string &error )
{
    if( pimpl_->applied ) {
        error = "items content transaction for '" + pimpl_->owner + "' was already applied";
        return false;
    }
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        error = "items content transaction for '" + pimpl_->owner + "' is no longer building";
        return false;
    }
    if( static_cast<int>( phase ) != pimpl_->applied_phase_count ) {
        error = "items content phases must be applied in declaration order";
        return false;
    }
    try {
        switch( phase ) {
            case items_content_apply_phase::foundations: {
                for( const json_flag_registration &entry : pimpl_->json_flags ) {
                    const flag_id id( entry.definition->id );
                    pimpl_->json_flag_undo.emplace_back(
                        id, id.is_valid() ? std::optional<json_flag>( id.obj() ) : std::nullopt );
                    const json_flag_definition_data &source = *entry.definition;
                    json_flag native;
                    native.id = id;
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.info_ = no_translation( source.info );
                    native.restriction_ = no_translation( source.restriction );
                    native.name_ = no_translation( source.name );
                    native.item_prefix_ = no_translation( source.item_prefix );
                    native.item_suffix_ = no_translation( source.item_suffix );
                    native.conflicts_ = source.conflicts;
                    native.inherit_ = source.inherit;
                    native.craft_inherit_ = source.craft_inherit;
                    native.requires_flag_ = source.requires_flag;
                    native.taste_mod_ = static_cast<int>( source.taste_modifier );
                    detail::json_flag_registry().insert( native );
                }

                for( const math_function_registration &entry : pimpl_->math_functions ) {
                    const jmath_func_id id( entry.definition->id );
                    pimpl_->math_function_undo.emplace_back(
                        id, id.is_valid() ? std::optional<jmath_func>( id.obj() ) : std::nullopt );
                    const math_function_definition_data &source = *entry.definition;
                    jmath_func native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native.num_params = static_cast<int>( source.num_args );
                    native._str = source.expression;
                    detail::jmath_func_registry().insert( native );
                }
                if( !pimpl_->math_functions.empty() ) {
                    detail::jmath_func_registry().finalize();
                }

                for( const tool_quality_registration &entry : pimpl_->tool_qualities ) {
                    const quality_id id( entry.definition->id );
                    pimpl_->tool_quality_undo.emplace_back(
                        id, id.is_valid() ? std::optional<quality>( id.obj() ) : std::nullopt );
                    quality native;
                    native.id = id;
                    native.name = no_translation( entry.definition->name );
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    for( const auto &[level, text] : entry.definition->usages ) {
                        native.usages.emplace_back( static_cast<int>( level ), text );
                    }
                    detail::tool_quality_registry().insert( native );
                }

                for( const skill_display_registration &entry : pimpl_->skill_displays ) {
                    const skill_displayType_id id( entry.definition->id );
                    pimpl_->skill_display_undo.emplace_back(
                        id, id.is_valid() ? std::optional<SkillDisplayType>( id.obj() ) : std::nullopt );
                    SkillDisplayType::skillTypes.erase(
                        std::remove_if( SkillDisplayType::skillTypes.begin(),
                                        SkillDisplayType::skillTypes.end(),
                    [&id]( const SkillDisplayType & value ) {
                        return value.ident() == id;
                    } ),
                    SkillDisplayType::skillTypes.end() );
                    SkillDisplayType::skillTypes.emplace_back(
                        id, no_translation( entry.definition->label ) );
                }

                for( const skill_registration &entry : pimpl_->skills ) {
                    const skill_id id( entry.definition->id );
                    pimpl_->skill_undo.emplace_back(
                        id, id.is_valid() ? std::optional<Skill>( id.obj() ) : std::nullopt );
                    Skill::skills.erase( std::remove_if( Skill::skills.begin(), Skill::skills.end(),
                    [&id]( const Skill & value ) {
                        return value.ident() == id;
                    } ), Skill::skills.end() );
                    Skill::contextual_skills.erase( id );
                    const skill_definition_data &source = *entry.definition;
                    Skill native( id, no_translation( source.name ), no_translation( source.description ),
                                  source.tags, skill_displayType_id( source.display_category ) );
                    native._sort_rank = static_cast<int>( source.sort_rank );
                    native.consumes_focus = source.consumes_focus;
                    native._teachable = source.teachable;
                    native._obsolete = source.obsolete;
                    native._time_to_attack = {
                        static_cast<int>( source.attack_min_time ),
                        static_cast<int>( source.attack_base_time ),
                        static_cast<int>( source.attack_reduction_per_level )
                    };
                    native._companion_combat_rank_factor =
                        static_cast<int>( source.companion_combat_rank_factor );
                    native._companion_survival_rank_factor =
                        static_cast<int>( source.companion_survival_rank_factor );
                    native._companion_industry_rank_factor =
                        static_cast<int>( source.companion_industry_rank_factor );
                    for( const auto &[practice_id, weight] : source.companion_practice ) {
                        native._companion_skill_practice[practice_id] = static_cast<int>( weight );
                    }
                    for( const auto &[level, description] : source.theory_descriptions ) {
                        native._level_descriptions_theory[static_cast<int>( level )] =
                            no_translation( description );
                    }
                    for( const auto &[level, description] : source.practice_descriptions ) {
                        native._level_descriptions_practice[static_cast<int>( level )] =
                            no_translation( description );
                    }
                    native._requires_all_traits = source.requires_all_traits;
                    native._requires_any_traits = source.requires_any_traits;
                    if( native.is_contextual_skill() ) {
                        Skill::contextual_skills[id] = std::move( native );
                    } else {
                        Skill::skills.push_back( std::move( native ) );
                    }
                }

                for( const vitamin_registration &entry : pimpl_->vitamins ) {
                    const vitamin_id id( entry.definition->id );
                    pimpl_->vitamin_undo.emplace_back(
                        id, id.is_valid() ? std::optional<vitamin>( id.obj() ) : std::nullopt );
                    const vitamin_definition_data &source = *entry.definition;
                    vitamin native;
                    native.id = id;
                    native.was_loaded = true;
                    native.name_ = no_translation( source.name );
                    native.type_ = source.type == "vitamin" ? vitamin_type::VITAMIN :
                                   source.type == "toxin" ? vitamin_type::TOXIN :
                                   source.type == "drug" ? vitamin_type::DRUG : vitamin_type::COUNTER;
                    native.deficiency_ = source.deficiency.empty() ? efftype_id::NULL_ID() :
                                         efftype_id( source.deficiency );
                    native.excess_ = source.excess.empty() ? efftype_id::NULL_ID() :
                                     efftype_id( source.excess );
                    native.min_ = static_cast<int>( source.minimum );
                    native.max_ = static_cast<int>( source.maximum );
                    native.rate_ = time_duration::from_turns( source.rate_turns );
                    if( source.weight_micrograms ) {
                        native.weight_per_unit = vitamin_units::mass(
                                                     static_cast<int>( *source.weight_micrograms ), {} );
                    }
                    for( const auto &[start, end] : source.disease ) {
                        native.disease_.emplace_back( static_cast<int>( start ), static_cast<int>( end ) );
                    }
                    for( const auto &[start, end] : source.disease_excess ) {
                        native.disease_excess_.emplace_back( static_cast<int>( start ), static_cast<int>( end ) );
                    }
                    for( const auto &[decay_id, rate] : source.decays_into ) {
                        native.decays_into_.emplace_back( vitamin_id( decay_id ), static_cast<int>( rate ) );
                    }
                    native.flags_ = source.flags;
                    detail::vitamin_registry().insert( native );
                }

                for( const damage_type_registration &entry : pimpl_->damage_types ) {
                    const damage_type_id id( entry.definition->id );
                    pimpl_->damage_type_undo.emplace_back(
                        id, id.is_valid() ? std::optional<damage_type>( id.obj() ) : std::nullopt );
                    const damage_type_definition_data &source = *entry.definition;
                    damage_type native;
                    native.id = id;
                    native.name = no_translation( source.name );
                    native.skill = source.skill.empty() ? skill_id::NULL_ID() : skill_id( source.skill );
                    native.magic_color = color_from_string( source.magic_color );
                    native.bash_conversion_factor = source.bash_conversion_factor;
                    native.melee_only = source.melee_only;
                    native.physical = source.physical;
                    native.mon_difficulty = source.monster_difficulty;
                    native.no_resist = source.no_resist;
                    native.edged = source.edged;
                    native.env = source.environmental;
                    native.material_required = source.material_required;
                    native.immune_flags = cata::flat_set<std::string>(
                                              source.character_immune_flags.begin(),
                                              source.character_immune_flags.end() );
                    native.mon_immune_flags = cata::flat_set<std::string>(
                                                  source.monster_immune_flags.begin(),
                                                  source.monster_immune_flags.end() );
                    if( !source.derived_from.empty() ) {
                        native.derived_from = {
                            damage_type_id( source.derived_from ),
                            static_cast<float>( source.derived_factor )
                        };
                    }
                    native.was_loaded = true;
                    detail::damage_type_registry().insert( native );
                }

                break;
            }
            case items_content_apply_phase::materials: {
                for( const material_registration &entry : pimpl_->materials ) {
                    const material_id id( entry.definition->id );
                    pimpl_->material_undo.emplace_back(
                        id, id.is_valid() ? std::optional<material_type>( id.obj() ) : std::nullopt );
                    const material_definition_data &source = *entry.definition;
                    material_type native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native._name = no_translation( source.name );
                    if( !source.salvaged_into.empty() ) {
                        native._salvaged_into = itype_id( source.salvaged_into );
                    }
                    native._repaired_with = source.repaired_with.empty() ? itype_id::NULL_ID() :
                                            itype_id( source.repaired_with );
                    native._chip_resist = static_cast<int>( source.chip_resistance );
                    native._density = static_cast<float>( source.density );
                    native._breathability = static_cast<breathability_rating>( source.breathability );
                    native._wind_resist = source.wind_resistance ?
                                          std::optional<int>( static_cast<int>( *source.wind_resistance ) ) :
                                          std::nullopt;
                    native._specific_heat_liquid = static_cast<float>( source.specific_heat_liquid );
                    native._specific_heat_solid = static_cast<float>( source.specific_heat_solid );
                    native._latent_heat = static_cast<float>( source.latent_heat );
                    native._freeze_point = static_cast<float>( source.freezing_point );
                    native._rotting = source.rotting;
                    native._soft = source.soft;
                    native._uncomfortable = source.uncomfortable;
                    native._conductive = source.conductive;
                    native._sheet_thickness = static_cast<float>( source.sheet_thickness );
                    native._repair_difficulty = static_cast<int>( source.repair_difficulty );
                    native._bash_dmg_verb = no_translation( source.bash_damage_verb );
                    native._cut_dmg_verb = no_translation( source.cut_damage_verb );
                    native._dmg_adj.clear();
                    for( const std::string &adjective : source.damage_adjectives ) {
                        native._dmg_adj.push_back( no_translation( adjective ) );
                    }
                    for( const auto &[damage_id, amount] : source.resistances ) {
                        const damage_type_id damage_key( damage_id );
                        native._resistances.set_resist( damage_key, static_cast<float>( amount ) );
                        native._res_was_loaded.push_back( damage_key );
                    }
                    for( const auto &[vitamin_key, amount] : source.vitamins ) {
                        native._vitamins[vitamin_id( vitamin_key )] = amount;
                    }
                    for( const material_burn_definition &burn : source.burn_data ) {
                        native._burn_data.push_back( {
                            burn.immune,
                            units::from_milliliter<std::int64_t>( burn.volume_ml_per_turn ),
                            static_cast<float>( burn.fuel ), static_cast<float>( burn.smoke ),
                            static_cast<float>( burn.burn )
                        } );
                    }
                    if( native._burn_data.empty() ) {
                        mat_burn_data default_burn;
                        default_burn.burn = native._resistances.type_resist(
                                                damage_type_id( "heat" ) ) <= 0.0F;
                        native._burn_data.push_back( default_burn );
                    }
                    for( const auto &[product, efficiency] : source.burn_products ) {
                        native._burn_products.emplace_back( itype_id( product ),
                                                            static_cast<float>( efficiency ) );
                    }
                    if( source.has_fuel ) {
                        native.fuel.energy = units::from_kilojoule<std::int64_t>(
                                                 source.fuel_energy_kilojoules );
                        native.fuel.pump_terrain = source.fuel_pump_terrain;
                        native.fuel.is_perpetual_fuel = source.perpetual_fuel;
                        native.fuel.explosion_data.explosion_chance_hot =
                            static_cast<int>( source.explosion_chance_hot );
                        native.fuel.explosion_data.explosion_chance_cold =
                            static_cast<int>( source.explosion_chance_cold );
                        native.fuel.explosion_data.explosion_factor =
                            static_cast<float>( source.explosion_factor );
                        native.fuel.explosion_data.fiery_explosion = source.fiery_explosion;
                        native.fuel.explosion_data.fuel_size_factor =
                            static_cast<float>( source.fuel_size_factor );
                    }
                    detail::material_registry().insert( native );
                }
                break;
            }
            case items_content_apply_phase::catalogs: {
                for( const proficiency_category_registration &entry : pimpl_->proficiency_categories ) {
                    const proficiency_category_id id( entry.definition->id );
                    pimpl_->proficiency_category_undo.emplace_back(
                        id, id.is_valid() ? std::optional<proficiency_category>( id.obj() ) : std::nullopt );
                    proficiency_category native;
                    native.id = id;
                    native._name = no_translation( entry.definition->name );
                    native._description = no_translation( entry.definition->description );
                    native.was_loaded = true;
                    detail::proficiency_category_registry().insert( native );
                }
                const auto proficiency_attribute = []( const std::string & attribute ) {
                    if( attribute == "strength" ) {
                        return proficiency_bonus_type::strength;
                    }
                    if( attribute == "dexterity" ) {
                        return proficiency_bonus_type::dexterity;
                    }
                    if( attribute == "intelligence" ) {
                        return proficiency_bonus_type::intelligence;
                    }
                    if( attribute == "perception" ) {
                        return proficiency_bonus_type::perception;
                    }
                    return proficiency_bonus_type::stamina;
                };
                for( const proficiency_registration &entry : pimpl_->proficiencies ) {
                    const proficiency_id id( entry.definition->id );
                    pimpl_->proficiency_undo.emplace_back(
                        id, id.is_valid() ? std::optional<proficiency>( id.obj() ) : std::nullopt );
                    const proficiency_definition_data &source = *entry.definition;
                    proficiency native;
                    native.id = id;
                    native._category = proficiency_category_id( source.category );
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native._name = no_translation( source.name );
                    native._description = no_translation( source.description );
                    native._can_learn = source.can_learn;
                    native._ignore_focus = source.ignore_focus;
                    native._teachable = source.teachable;
                    native._default_time_multiplier = static_cast<float>( source.time_multiplier );
                    native._default_skill_penalty = static_cast<float>( source.skill_penalty );
                    native._default_weakpoint_bonus = static_cast<float>( source.weakpoint_bonus );
                    native._default_weakpoint_penalty = static_cast<float>( source.weakpoint_penalty );
                    native._time_to_learn = time_duration::from_turns(
                                                static_cast<int>( source.time_to_learn_turns ) );
                    for( const std::string &required : source.required ) {
                        native._required.insert( proficiency_id( required ) );
                    }
                    for( const proficiency_bonus_definition &bonus : source.bonuses ) {
                        native._bonuses[bonus.category].push_back( {
                            proficiency_attribute( bonus.attribute ), static_cast<float>( bonus.value )
                        } );
                    }
                    detail::proficiency_registry().insert( native );
                }
                for( const weapon_category_registration &entry : pimpl_->weapon_categories ) {
                    const weapon_category_id id( entry.definition->id );
                    pimpl_->weapon_category_undo.emplace_back(
                        id, id.is_valid() ? std::optional<weapon_category>( id.obj() ) : std::nullopt );
                    weapon_category native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native.name_ = no_translation( entry.definition->name );
                    for( const std::string &proficiency : entry.definition->proficiencies ) {
                        native.proficiencies_.emplace_back( proficiency );
                    }
                    detail::weapon_category_registry().insert( native );
                }
                for( const item_category_registration &entry : pimpl_->item_categories ) {
                    const item_category_id id( entry.definition->id );
                    pimpl_->item_category_undo.emplace_back(
                        id, id.is_valid() ? std::optional<item_category>( id.obj() ) : std::nullopt,
                        id.is_valid() ? id.obj().get_spawn_rate() : 1.0F );
                    const item_category_definition_data &source = *entry.definition;
                    item_category native( id, no_translation( source.header ),
                                          no_translation( source.noun ),
                                          static_cast<int>( source.sort_rank ) );
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    if( !source.zone.empty() ) {
                        native.zone_ = zone_type_id( source.zone );
                    }
                    for( const item_category_priority_definition &priority : source.priority_zones ) {
                        zone_priority_data rule;
                        rule.was_loaded = true;
                        rule.id = zone_type_id( priority.zone );
                        rule.filthy = priority.filthy;
                        for( const std::string &flag : priority.flags ) {
                            rule.flags.insert( flag_id( flag ) );
                        }
                        native.zone_priority_.push_back( std::move( rule ) );
                    }
                    detail::item_category_registry().insert( native );
                    if( id.is_valid() ) {
                        id.obj().set_spawn_rate( static_cast<float>( source.spawn_rate ) );
                    }
                }
                for( const crafting_category_registration &entry : pimpl_->crafting_categories ) {
                    const crafting_category_id id( entry.definition->id );
                    pimpl_->crafting_category_undo.emplace_back(
                        id, id.is_valid() ? std::optional<crafting_category>( id.obj() ) : std::nullopt );
                    crafting_category native;
                    native.id = id;
                    native.was_loaded = true;
                    native.is_hidden = entry.definition->hidden;
                    native.is_practice = entry.definition->practice;
                    native.is_building = entry.definition->building;
                    native.is_wildcard = entry.definition->wildcard;
                    native.subcategories = entry.definition->subcategories;
                    detail::crafting_category_registry().insert( native );
                }
                for( const ammunition_type_registration &entry : pimpl_->ammunition_types ) {
                    const ammotype id( entry.definition->id );
                    const auto previous = ammunition_type::registry().find( id );
                    pimpl_->ammunition_type_undo.emplace_back(
                        id, previous == ammunition_type::registry().end() ?
                        std::optional<ammunition_type>() : std::optional<ammunition_type>( previous->second ) );
                    ammunition_type native;
                    native.name_ = no_translation( entry.definition->name );
                    native.default_ammotype_ = itype_id( entry.definition->default_item );
                    ammunition_type::registry()[id] = std::move( native );
                }
                break;
            }
            case items_content_apply_phase::ammunition_effects: {
                for( const ammo_effect_registration &entry : pimpl_->ammo_effects ) {
                    const ammo_effect_str_id id( entry.definition->id );
                    pimpl_->ammo_effect_undo.emplace_back(
                        id, id.is_valid() ? std::optional<ammo_effect>( id.obj() ) : std::nullopt );
                    const ammo_effect_definition_data &source = *entry.definition;
                    ammo_effect native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native.trigger_chance = static_cast<int>( source.trigger_chance );
                    for( const ammo_field_definition_data &field : source.field_bursts ) {
                        aoe_field_effect value;
                        value.field_type = field_type_str_id( field.field );
                        value.intensity_min = static_cast<int>( field.intensity_min );
                        value.intensity_max = static_cast<int>( field.intensity_max );
                        value.radius = static_cast<int>( field.radius );
                        value.radius_z = static_cast<int>( field.height );
                        value.chance = static_cast<int>( field.chance );
                        value.size = static_cast<int>( field.footprint );
                        value.check_passable = field.passable_only;
                        native.aoe_field_types.push_back( std::move( value ) );
                    }
                    for( const ammo_field_definition_data &field : source.trails ) {
                        trail_field_effect value;
                        value.field_type = field_type_str_id( field.field );
                        value.intensity_min = static_cast<int>( field.intensity_min );
                        value.intensity_max = static_cast<int>( field.intensity_max );
                        value.chance = static_cast<int>( field.chance );
                        native.trail_field_types.push_back( std::move( value ) );
                    }
                    for( const ammo_character_effect_definition_data &effect : source.on_hit_effects ) {
                        on_hit_effect value;
                        value.effect = efftype_id( effect.effect );
                        value.duration = time_duration::from_turns(
                                             static_cast<int>( effect.duration_turns ) );
                        value.intensity = static_cast<int>( effect.intensity_min );
                        value.need_touch_skin = effect.touch_skin;
                        native.on_hit_effects.push_back( std::move( value ) );
                    }
                    for( const ammo_character_effect_definition_data &effect : source.area_effects ) {
                        aoe_effect value;
                        value.effect = efftype_id( effect.effect );
                        value.duration = time_duration::from_turns(
                                             static_cast<int>( effect.duration_turns ) );
                        value.intensity_min = static_cast<int>( effect.intensity_min );
                        value.intensity_max = static_cast<int>( effect.intensity_max );
                        value.chance = static_cast<int>( effect.chance );
                        value.radius = static_cast<int>( effect.radius );
                        value.hits_amount = { static_cast<int>( effect.hits_min ),
                                              static_cast<int>( effect.hits_max )
                                            };
                        value.all_bp = effect.all_body_parts;
                        native.aoe_effects.push_back( std::move( value ) );
                    }
                    if( source.has_explosion ) {
                        native.aoe_explosion_data.power = static_cast<float>( source.explosion_power );
                        native.aoe_explosion_data.distance_factor =
                            static_cast<float>( source.explosion_distance_factor );
                        native.aoe_explosion_data.max_noise = static_cast<int>( source.explosion_max_noise );
                        native.aoe_explosion_data.fire = source.explosion_fire;
                        native.aoe_explosion_data.light_effect = explosion_light_str_id( source.explosion_light );
                        if( source.has_shrapnel ) {
                            native.aoe_explosion_data.shrapnel = shrapnel_data(
                                    static_cast<int>( source.casing_mass ),
                                    static_cast<float>( source.fragment_mass ),
                                    static_cast<int>( source.fragment_recovery ),
                                    itype_id( source.fragment_drop ) );
                        }
                    }
                    native.do_flashbang = source.flashbang;
                    native.do_emp_blast = source.emp;
                    native.foamcrete_build = source.foamcrete;
                    native.always_cast_spell = source.cast_spells_on_miss;
                    for( const ammo_spell_definition_data &spell_source : source.spells ) {
                        fake_spell spell( spell_id( spell_source.spell ), spell_source.self );
                        spell.level = static_cast<int>( spell_source.level );
                        native.spell_data.push_back( std::move( spell ) );
                    }
                    get_all_ammo_effects().insert( native );
                }
                if( !pimpl_->ammo_effects.empty() ) {
                    get_all_ammo_effects().finalize();
                }
                break;
            }
            case items_content_apply_phase::metadata: {
                for( const scent_type_registration &entry : pimpl_->scent_types ) {
                    const scenttype_id id( entry.definition->id );
                    pimpl_->scent_type_undo.emplace_back(
                        id, id.is_valid() ? std::optional<scent_type>( id.obj() ) : std::nullopt );
                    scent_type native;
                    native.id = id;
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    for( const std::string &species : entry.definition->receptive_species ) {
                        native.receptive_species.insert( species_id( species ) );
                    }
                    detail::scent_type_registry().insert( native );
                }
                for( const butchery_requirement_registration &entry : pimpl_->butchery_requirement_entries ) {
                    const string_id<butchery_requirements> id( entry.definition->id );
                    pimpl_->butchery_requirements_undo.emplace_back(
                        id, id.is_valid() ? std::optional<butchery_requirements>( id.obj() ) : std::nullopt );
                    butchery_requirements native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    for( const auto &requirement : entry.definition->entries ) {
                        native.requirements[static_cast<float>( requirement.speed )]
                        [*platform_creature_size( requirement.size )]
                        [*platform_butcher_type( requirement.butcher )] =
                            requirement_id( requirement.requirement );
                    }
                    detail::butchery_requirements_registry().insert( native );
                }
                for( const item_action_registration &entry : pimpl_->item_actions ) {
                    const item_action_definition_data &source = *entry.definition;
                    const item_action *previous = detail::item_action_registry_find( source.id );
                    pimpl_->item_action_undo.emplace_back(
                        source.id, previous == nullptr ? std::optional<item_action>() :
                        std::optional<item_action>( *previous ) );
                    item_action native;
                    native.id = source.id;
                    native.name = no_translation( source.name );
                    detail::item_action_registry_set( native );
                }
                break;
            }
            case items_content_apply_phase::item_groups: {
                for( const item_group_registration &entry : pimpl_->item_groups ) {
                    const item_group_id id( entry.definition->id );
                    auto previous = item_controller->m_template_groups.find( id );
                    const item_group_definition_data &source = *entry.definition;
                    const Item_group::Type kind = source.kind == "collection" ?
                                                  Item_group::G_COLLECTION : Item_group::G_DISTRIBUTION;
                    std::unique_ptr<Item_group> replacement;
                    Item_group *native = nullptr;
                    if( entry.operation == definition_operation::extend ) {
                        native = previous == item_controller->m_template_groups.end() ?
                                 nullptr : dynamic_cast<Item_group *>( previous->second.get() );
                        if( native == nullptr || native->type != kind ) {
                            throw std::runtime_error( "cannot extend missing or mismatched item group '" +
                                                      source.id + "'" );
                        }
                        pimpl_->item_group_extension_undo.emplace_back( id, native->entry_count() );
                    } else {
                        std::unique_ptr<Item_spawn_data> snapshot;
                        if( previous != item_controller->m_template_groups.end() ) {
                            snapshot = std::move( previous->second );
                        }
                        pimpl_->item_group_undo.emplace_back( id, std::move( snapshot ) );
                        replacement = std::make_unique<Item_group>(
                                          kind, 100, static_cast<int>( source.with_ammo ),
                                          static_cast<int>( source.with_magazine ),
                                          "Lua-first item group " + source.id );
                        native = replacement.get();
                    }
                    for( const item_group_entry_definition_data &source_entry : source.entries ) {
                        const Single_item_creator::Type entry_type = source_entry.group ?
                                Single_item_creator::S_ITEM_GROUP : Single_item_creator::S_ITEM;
                        std::string entry_id = source_entry.id;
                        if( !source_entry.group ) {
                            const bool declared_in_transaction = std::any_of(
                                    pimpl_->items.begin(), pimpl_->items.end(),
                            [&source_entry]( const item_registration & item_entry ) {
                                return item_entry.definition->id == source_entry.id;
                            } );
                            if( !declared_in_transaction ) {
                                const itype_id migrated_item = item_controller->migrate_id(
                                                                   itype_id( source_entry.id ) );
                                if( !item::type_is_defined( migrated_item ) ) {
                                    DebugLog( D_WARNING, D_MAIN ) << "Lua-first item group '" << source.id
                                                                  << "' skipped unavailable item '"
                                                                  << source_entry.id << "'";
                                    continue;
                                }
                                entry_id = migrated_item.str();
                            }
                        }
                        auto native_entry = std::make_unique<Single_item_creator>(
                                                entry_id, entry_type,
                                                static_cast<int>( source_entry.probability ),
                                                "Lua-first item-group entry " + source.id );
                        if( source_entry.count_min != 1 || source_entry.count_max != 1 ||
                            !source_entry.variant.empty() || source_entry.charges_min != -1 ) {
                            native_entry->modifier.emplace();
                            native_entry->modifier->count = {
                                static_cast<int>( source_entry.count_min ),
                                static_cast<int>( source_entry.count_max )
                            };
                            native_entry->modifier->variant = source_entry.variant;
                            native_entry->modifier->charges = {
                                static_cast<int>( source_entry.charges_min ),
                                static_cast<int>( source_entry.charges_max )
                            };
                        }
                        native->add_entry( std::move( native_entry ) );
                    }
                    if( replacement ) {
                        item_controller->m_template_groups[id] = std::move( replacement );
                    }
                }
                break;
            }
            case items_content_apply_phase::requirements: {
                pimpl_->requirement_changes = !pimpl_->requirements.empty();
                for( const requirement_registration &entry : pimpl_->requirements ) {
                    const requirement_id id( entry.definition->id );
                    const auto previous = requirement_data::registry().find( id );
                    pimpl_->requirement_undo.emplace_back(
                        id, previous == requirement_data::registry().end() ?
                        std::optional<requirement_data>() : std::optional<requirement_data>( previous->second ) );
                    const requirement_definition_data &source = *entry.definition;
                    requirement_data::alter_item_comp_vector components;
                    for( const std::vector<component_requirement> &source_group : source.components ) {
                        std::vector<item_comp> group;
                        for( const component_requirement &component : source_group ) {
                            item_comp native_component( itype_id( component.id ),
                                                        static_cast<int>( component.count ) );
                            native_component.requirement = component.requirement;
                            group.push_back( std::move( native_component ) );
                        }
                        components.push_back( std::move( group ) );
                    }
                    requirement_data::alter_tool_comp_vector tools;
                    for( const std::vector<component_requirement> &source_group : source.tools ) {
                        std::vector<tool_comp> group;
                        for( const component_requirement &tool : source_group ) {
                            tool_comp native_tool( itype_id( tool.id ), static_cast<int>( tool.count ) );
                            native_tool.requirement = tool.requirement;
                            group.push_back( std::move( native_tool ) );
                        }
                        tools.push_back( std::move( group ) );
                    }
                    requirement_data::alter_quali_req_vector qualities;
                    for( const std::vector<quality_requirement_definition> &source_group : source.qualities ) {
                        std::vector<quality_requirement> group;
                        for( const quality_requirement_definition &quality : source_group ) {
                            group.emplace_back( quality_id( quality.id ),
                                                static_cast<int>( quality.count ),
                                                static_cast<int>( quality.level ) );
                        }
                        qualities.push_back( std::move( group ) );
                    }
                    requirement_data native( tools, qualities, components );
                    native.id_ = id;
                    native.name_ = no_translation( source.name );
                    requirement_data::registry()[id] = std::move( native );
                }
                break;
            }
            case items_content_apply_phase::recipe_groups: {
                for( const recipe_group_registration &entry : pimpl_->recipe_groups ) {
                    pimpl_->recipe_group_undo.emplace_back(
                        entry.definition->id, detail::recipe_group_get( entry.definition->id ) );
                    detail::recipe_group_native_definition native;
                    native.id = entry.definition->id;
                    native.building_type = entry.definition->building_type;
                    native.sources.emplace_back( native.id, mod_id( pimpl_->owner ) );
                    for( const recipe_group_recipe_data &recipe_entry : entry.definition->recipes ) {
                        detail::recipe_group_recipe_definition native_recipe;
                        native_recipe.id = recipe_entry.id;
                        native_recipe.description = no_translation( recipe_entry.description );
                        for( const recipe_group_terrain_data &terrain : recipe_entry.terrains ) {
                            detail::recipe_group_terrain_definition native_terrain;
                            native_terrain.overmap_terrain = terrain.overmap_terrain;
                            native_terrain.match_type = terrain.match_type;
                            native_terrain.parameters = terrain.parameters;
                            native_recipe.overmap_terrains.push_back( std::move( native_terrain ) );
                        }
                        native.recipes.push_back( std::move( native_recipe ) );
                    }
                    detail::recipe_group_set( native );
                }
                break;
            }
            case items_content_apply_phase::definitions: {
                std::vector<std::size_t> item_order;
                std::string inheritance_error;
                if( !detail::resolve_platform_inheritance_order( pimpl_->items,
                []( const item_registration & entry ) {
                return entry.definition->id;
            },
            []( const item_registration & entry ) {
                return entry.definition->copy_from;
            },
            []( const std::string & id ) {
                const itype_id native_id( id );
                    const generic_factory<itype> &factory = item_controller->get_generic_factory();
                    return item::type_is_defined( native_id ) || factory.is_valid( native_id ) ||
                           factory.find_abstract( id ) != nullptr;
                }, item_order, inheritance_error, "item" ) ) {
                    throw std::runtime_error( inheritance_error );
                }
                for( const std::size_t index : item_order ) {
                    const item_registration &entry = pimpl_->items[index];
                    const itype_id id( entry.definition->id );
                    const auto previous = item_controller->m_runtimes.find( id );
                    pimpl_->item_undo.emplace_back(
                        id, previous == item_controller->m_runtimes.end() ?
                        std::optional<itype>() : std::optional<itype>( *previous->second ) );
                    const item_definition_data &definition = *entry.definition;
                    std::unique_ptr<itype> native;
                    if( definition.copy_from.empty() ) {
                        native = std::make_unique<itype>();
                    } else {
                        const itype_id source_id( definition.copy_from );
                        const itype *source = nullptr;
                        const auto runtime_source = item_controller->m_runtimes.find( source_id );
                        if( runtime_source != item_controller->m_runtimes.end() ) {
                            source = runtime_source->second.get();
                        } else {
                            generic_factory<itype> &factory = item_controller->get_generic_factory();
                            if( factory.is_valid( source_id ) ) {
                                source = &factory.obj( source_id );
                            } else {
                                source = factory.find_abstract( definition.copy_from );
                            }
                        }
                        if( source == nullptr ) {
                            throw std::runtime_error( "item '" + definition.id +
                                                      "' lost its copy-from source '" +
                                                      definition.copy_from + "' while being applied" );
                        }
                        native = std::make_unique<itype>( *source );
                    }
                    native->id = id;
                    if( definition.has_name ) {
                        native->name = no_translation( definition.name );
                    }
                    if( definition.has_description ) {
                        native->description = no_translation( definition.description );
                    }
                    if( definition.has_symbol ) {
                        native->sym = definition.symbol;
                    }
                    if( definition.has_mass ) {
                        native->weight = units::from_gram<std::int64_t>( definition.mass_grams );
                    }
                    if( definition.has_volume ) {
                        native->volume = units::from_milliliter<std::int64_t>( definition.volume_ml );
                    }
                    if( definition.has_price ) {
                        native->price = units::from_cent<std::int64_t>( definition.price_cents );
                    }
                    if( definition.has_price_postapoc ) {
                        native->price_post = units::from_cent<std::int64_t>( definition.price_postapoc_cents );
                    }
                    if( definition.has_color ) {
                        native->color = color_from_string( definition.color, report_color_error::no );
                    }
                    if( definition.has_category ) {
                        native->category_force = item_category_id( definition.category );
                    }
                    if( definition.has_looks_like ) {
                        native->looks_like = itype_id( definition.looks_like );
                    }
                    native->was_loaded = true;
                    native->src.clear();
                    native->src.emplace_back( id, mod_id( pimpl_->owner ) );
                    bool first_material = true;
                    if( !definition.materials.empty() ) {
                        native->materials.clear();
                        native->mat_portion_total = 0;
                    }
                    for( const material_part &material : definition.materials ) {
                        const material_id material_key( material.id );
                        native->materials[material_key] += static_cast<int>( material.portions );
                        native->mat_portion_total += static_cast<int>( material.portions );
                        if( first_material ) {
                            native->default_mat = material_key;
                            first_material = false;
                        }
                    }
                    if( native->materials.empty() ) {
                        native->default_mat = material_id::NULL_ID();
                    }
                    for( const quality_level &quality : definition.qualities ) {
                        native->qualities[quality_id( quality.id )] = {
                            static_cast<int>( quality.level ), 1.0F
                        };
                    }
                    for( const std::string &flag : definition.flags ) {
                        native->item_tags.insert( flag_id( flag ) );
                    }
                    if( entry.definition->comestible ) {
                        const item_definition_data::comestible_data &source =
                            *entry.definition->comestible;
                        native->book.reset();
                        native->comestible = cata::make_value<islot_comestible>();
                        native->comestible->was_loaded = true;
                        native->comestible->comesttype = source.type;
                        native->comestible->def_charges = static_cast<int>( source.charges );
                        native->comestible->stack_size = static_cast<int>( source.stack_size );
                        native->comestible->quench = static_cast<int>( source.quench );
                        native->comestible->healthy = static_cast<int>( source.healthy );
                        native->comestible->spoils = time_duration::from_turns(
                                                        static_cast<int>( source.spoils_in_turns ) );
                        native->comestible->set_fun( static_cast<int>( source.fun ) );
                        nutrients nutrition;
                        nutrition.calories = source.calories * 1000;
                        for( const auto &[vitamin_key, amount] : source.vitamins ) {
                            nutrition.set_vitamin( vitamin_id( vitamin_key ),
                                                   static_cast<int>( amount ) );
                        }
                        native->comestible->set_default_nutrition( std::move( nutrition ) );
                    }
                    if( entry.definition->book ) {
                        const item_definition_data::book_data &source = *entry.definition->book;
                        native->comestible.reset();
                        native->book = cata::make_value<islot_book>();
                        native->book->was_loaded = true;
                        native->book->skill = skill_id( source.skill );
                        native->book->req = static_cast<int>( source.required_level );
                        native->book->level = static_cast<int>( source.maximum_level );
                        native->book->intel = static_cast<int>( source.intelligence );
                        native->book->time = time_duration::from_turns(
                                                 static_cast<int>( source.read_time_turns ) );
                        native->book->fun = static_cast<int>( source.fun );
                    }
                    for( const auto &[damage, amount] : definition.melee_damage ) {
                        native->melee.damage_map[damage_type_id( damage )] = static_cast<float>( amount );
                    }
                    if( !definition.magazine_ammo.empty() ) {
                        if( !native->magazine ) {
                            native->magazine = cata::make_value<islot_magazine>();
                        }
                        native->magazine->was_loaded = true;
                        native->magazine->type.clear();
                        native->magazine->capacity = 0;
                        pocket_data pocket( pocket_type::MAGAZINE );
                        for( const auto &[ammo, capacity] : definition.magazine_ammo ) {
                            native->magazine->type.emplace( ammo );
                            native->magazine->capacity = std::max(
                                                             native->magazine->capacity,
                                                             static_cast<int>( capacity ) );
                            pocket.ammo_restriction.emplace(
                                ammotype( ammo ), static_cast<int>( capacity ) );
                        }
                        if( definition.has_magazine_capacity ) {
                            native->magazine->capacity = static_cast<int>( definition.magazine_capacity );
                        }
                        native->pockets.erase( std::remove_if( native->pockets.begin(), native->pockets.end(),
                        []( const pocket_data & value ) {
                            return value.type == pocket_type::MAGAZINE;
                        } ),
                        native->pockets.end() );
                        native->pockets.push_back( std::move( pocket ) );
                    }
                    if( !definition.use_handler.empty() ) {
                        const std::string action_id = "lua_platform:" + pimpl_->owner + ":" +
                                                      definition.use_handler;
                        native->use_methods.emplace(
                            action_id,
                            use_function( std::make_unique<lua_platform_iuse_actor>(
                                              pimpl_->owner, definition.use_handler, definition.use_label ) ) );
                    }
                    if( !definition.consume_handler.empty() ) {
                        if( !native->comestible ) {
                            throw std::runtime_error( "item '" + definition.id +
                                                      "' has on_consume but no comestible slot" );
                        }
                        native->comestible->lua_platform_mod = pimpl_->owner;
                        native->comestible->lua_platform_consume_handler = definition.consume_handler;
                    }
                    item_controller->m_runtimes[id] = std::move( native );
                    item_controller->m_runtimes_dirty = true;
                    item_controller->templates_all_cache.clear();
                    item_controller->armor_containers.clear();
                }
                break;
            }
            case items_content_apply_phase::recipes: {
                for( const recipe_registration &entry : pimpl_->recipes ) {
                    const bool targets_uncraft = entry.definition->uncraft;
                    const recipe_id id( targets_uncraft ? recipe_id( entry.definition->result ) :
                                        recipe_id( entry.definition->id ) );
                    auto &native_dict = targets_uncraft ? recipe_dict.uncraft : recipe_dict.recipes;
                    auto &undo_list = targets_uncraft ? pimpl_->uncraft_undo : pimpl_->recipe_undo;
                    const auto previous = native_dict.find( id );
                    undo_list.emplace_back(
                        id, previous == native_dict.end() ? std::optional<recipe>() :
                        std::optional<recipe>( previous->second ) );
                    recipe native;
                    native.id = id;
                    if( entry.definition->nested_category ) {
                        native.name_ = no_translation( entry.definition->name );
                        native.description = entry.definition->description.empty() ? translation() :
                                             no_translation( entry.definition->description );
                        native.category = crafting_category_id( entry.definition->category );
                        native.subcategory = entry.definition->subcategory;
                        native.exertion = static_cast<float>( entry.definition->activity_level );
                        for( const std::string &member : entry.definition->nested_recipes ) {
                            native.nested_category_data.emplace( member );
                        }
                        native.was_loaded = true;
                        native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                        recipe_dict.recipes[id] = std::move( native );
                        continue;
                    }
                    native.result_ = itype_id( entry.definition->result );
                    if( entry.definition->result_charges ) {
                        native.charges = static_cast<int>( *entry.definition->result_charges );
                    }
                    native.time = entry.definition->time_moves;
                    native.category = crafting_category_id( entry.definition->category );
                    native.subcategory = entry.definition->subcategory;
                    native.difficulty = static_cast<int>( entry.definition->difficulty );
                    native.skill_used = entry.definition->skill.empty() ? skill_id::NULL_ID() :
                                        skill_id( entry.definition->skill );
                    native.autolearn = entry.definition->autolearn;
                    native.reversible = entry.definition->reversible;
                    native.exertion = static_cast<float>( entry.definition->activity_level );
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.lua_platform_mod = pimpl_->owner;
                    native.lua_platform_result_handler = entry.definition->result_handler;
                    for( const auto &[skill, level] : entry.definition->required_skills ) {
                        native.required_skills[skill_id( skill )] = static_cast<int>( level );
                    }
                    for( const recipe_definition_data::proficiency_data &source : entry.definition->proficiencies ) {
                        recipe_proficiency native_proficiency;
                        native_proficiency.id = proficiency_id( source.id );
                        native_proficiency.required = source.required;
                        native_proficiency.time_multiplier = static_cast<float>( source.time_multiplier );
                        native_proficiency.skill_penalty = static_cast<float>( source.skill_penalty );
                        native_proficiency._skill_penalty_assigned = source.skill_penalty_assigned;
                        native.proficiencies.push_back( std::move( native_proficiency ) );
                    }
                    for( const auto &[book, level] : entry.definition->books ) {
                        native.booksets[itype_id( book )].skill_req = static_cast<int>( level );
                    }
                    requirement_data::alter_item_comp_vector components;
                    for( const std::vector<component_requirement> &group : entry.definition->components ) {
                        std::vector<item_comp> alternatives;
                        for( const component_requirement &component : group ) {
                            item_comp native_component( itype_id( component.id ),
                                                        static_cast<int>( component.count ) );
                            native_component.requirement = component.requirement;
                            alternatives.push_back( std::move( native_component ) );
                        }
                        components.push_back( std::move( alternatives ) );
                    }
                    requirement_data::alter_tool_comp_vector tools;
                    for( const std::vector<component_requirement> &group : entry.definition->tools ) {
                        std::vector<tool_comp> alternatives;
                        for( const component_requirement &tool : group ) {
                            tool_comp native_tool( itype_id( tool.id ), static_cast<int>( tool.count ) );
                            native_tool.requirement = tool.requirement;
                            alternatives.push_back( std::move( native_tool ) );
                        }
                        tools.push_back( std::move( alternatives ) );
                    }
                    native.requirements_ = requirement_data( tools, {}, components );
                    if( !entry.definition->external_requirements.empty() ) {
                        std::map<requirement_id, int> external;
                        for( const auto &[requirement_key, multiplier] : entry.definition->external_requirements ) {
                            external[requirement_id( requirement_key )] = static_cast<int>( multiplier );
                        }
                        native.requirements_ = native.requirements_ + requirement_data( external );
                    }
                    native.root_requirements_ = native.requirements_;
                    native_dict[id] = std::move( native );
                }
                for( const plant_lifecycle_registration &entry : pimpl_->plant_lifecycles ) {
                    // Plant lifecycle definitions are consumed by the Lua
                    // lookup path and deliberately have no native registry.
                    static_cast<void>( entry );
                }
                break;
            }
        }
        ++pimpl_->applied_phase_count;
        pimpl_->next_apply_phase = pimpl_->applied_phase_count == 10 ?
                                   items_content_apply_phase::recipes :
                                   static_cast<items_content_apply_phase>( pimpl_->applied_phase_count );
        if( pimpl_->applied_phase_count == 10 ) {
            pimpl_->applied = true;
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        rollback_phase( static_cast<items_content_rollback_phase>( static_cast<int>( phase ) ) );
        rollback_all();
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool items_content_transaction::validate_finalized( std::string &error ) const
{
    if( !pimpl_->applied ) {
        error = "items content transaction is not fully applied";
        return false;
    }
    if( pimpl_->finalization_validated ) {
        error = "items content finalization was already validated";
        return false;
    }
    const auto check = [&error]( const bool valid, const std::string & kind,
    const std::string & id ) {
        if( !valid ) {
            error = "Lua-first " + kind + " '" + id + "' did not survive global finalization";
            return false;
        }
        return true;
    };
    for( const tool_quality_registration &entry : pimpl_->tool_qualities ) {
        if( !check( quality_id( entry.definition->id ).is_valid(), "tool quality",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const skill_display_registration &entry : pimpl_->skill_displays ) {
        if( !check( skill_displayType_id( entry.definition->id ).is_valid(), "skill display category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const skill_registration &entry : pimpl_->skills ) {
        if( !check( skill_id( entry.definition->id ).is_valid(), "skill", entry.definition->id ) ) {
            return false;
        }
    }
    for( const vitamin_registration &entry : pimpl_->vitamins ) {
        if( !check( vitamin_id( entry.definition->id ).is_valid(), "vitamin", entry.definition->id ) ) {
            return false;
        }
    }
    for( const json_flag_registration &entry : pimpl_->json_flags ) {
        if( !check( flag_id( entry.definition->id ).is_valid(), "JSON flag", entry.definition->id ) ) {
            return false;
        }
    }
    for( const math_function_registration &entry : pimpl_->math_functions ) {
        if( !check( jmath_func_id( entry.definition->id ).is_valid(), "math function",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const damage_type_registration &entry : pimpl_->damage_types ) {
        if( !check( damage_type_id( entry.definition->id ).is_valid(), "damage type",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const material_registration &entry : pimpl_->materials ) {
        if( !check( material_id( entry.definition->id ).is_valid(), "material", entry.definition->id ) ) {
            return false;
        }
    }
    for( const ammunition_type_registration &entry : pimpl_->ammunition_types ) {
        if( !check( ammotype( entry.definition->id ).is_valid(), "ammunition type",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const item_category_registration &entry : pimpl_->item_categories ) {
        if( !check( item_category_id( entry.definition->id ).is_valid(), "item category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const crafting_category_registration &entry : pimpl_->crafting_categories ) {
        if( !check( crafting_category_id( entry.definition->id ).is_valid(), "recipe category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const proficiency_category_registration &entry : pimpl_->proficiency_categories ) {
        if( !check( proficiency_category_id( entry.definition->id ).is_valid(), "proficiency category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const proficiency_registration &entry : pimpl_->proficiencies ) {
        if( !check( proficiency_id( entry.definition->id ).is_valid(), "proficiency",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const weapon_category_registration &entry : pimpl_->weapon_categories ) {
        if( !check( weapon_category_id( entry.definition->id ).is_valid(), "weapon category",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const requirement_registration &entry : pimpl_->requirements ) {
        if( !check( requirement_data::registry().count( requirement_id( entry.definition->id ) ) != 0,
                    "requirement", entry.definition->id ) ) {
            return false;
        }
    }
    for( const recipe_group_registration &entry : pimpl_->recipe_groups ) {
        if( !check( detail::recipe_group_exists( entry.definition->id ), "recipe group",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const scent_type_registration &entry : pimpl_->scent_types ) {
        if( !check( scenttype_id( entry.definition->id ).is_valid(), "scent type",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const butchery_requirement_registration &entry : pimpl_->butchery_requirement_entries ) {
        if( !check( string_id<butchery_requirements>( entry.definition->id ).is_valid(),
                    "butchery requirement", entry.definition->id ) ) {
            return false;
        }
    }
    for( const item_action_registration &entry : pimpl_->item_actions ) {
        if( !check( detail::item_action_registry_find( entry.definition->id ) != nullptr,
                    "item action", entry.definition->id ) ) {
            return false;
        }
    }
    for( const item_group_registration &entry : pimpl_->item_groups ) {
        if( !check( item_group::group_is_defined( item_group_id( entry.definition->id ) ),
                    "item group", entry.definition->id ) ) {
            return false;
        }
    }
    for( const ammo_effect_registration &entry : pimpl_->ammo_effects ) {
        if( !check( ammo_effect_str_id( entry.definition->id ).is_valid(), "ammo effect",
                    entry.definition->id ) ) {
            return false;
        }
    }
    for( const item_registration &entry : pimpl_->items ) {
        if( !check( item_controller->m_runtimes.count( itype_id( entry.definition->id ) ) != 0,
                    "item", entry.definition->id ) ) {
            return false;
        }
    }
    for( const recipe_registration &entry : pimpl_->recipes ) {
        const auto &native_dict = entry.definition->uncraft ? recipe_dict.uncraft : recipe_dict.recipes;
        const recipe_id id( entry.definition->uncraft ? recipe_id( entry.definition->result ) :
                            recipe_id( entry.definition->id ) );
        if( !check( native_dict.count( id ) != 0, "recipe", entry.definition->id ) ) {
            return false;
        }
    }
    pimpl_->finalization_validated = true;
    error.clear();
    return true;
}

void items_content_transaction::rollback_phase( const items_content_rollback_phase phase )
{
    auto restore_factory = []( auto & factory, auto & undo ) {
        for( auto it = undo.rbegin(); it != undo.rend(); ++it ) {
            if( it->second ) {
                factory.restore( *it->second );
            } else {
                factory.erase( it->first );
            }
        }
        undo.clear();
    };
    switch( phase ) {
        case items_content_rollback_phase::foundations:
            restore_factory( detail::damage_type_registry(), pimpl_->damage_type_undo );
            restore_factory( detail::vitamin_registry(), pimpl_->vitamin_undo );
            for( auto it = pimpl_->skill_undo.rbegin(); it != pimpl_->skill_undo.rend(); ++it ) {
                const skill_id id = it->first;
                Skill::skills.erase( std::remove_if( Skill::skills.begin(), Skill::skills.end(),
                [&id]( const Skill & value ) {
                    return value.ident() == id;
                } ), Skill::skills.end() );
                Skill::contextual_skills.erase( id );
                if( it->second ) {
                    if( it->second->is_contextual_skill() ) {
                        Skill::contextual_skills[id] = *it->second;
                    } else {
                        Skill::skills.push_back( *it->second );
                    }
                }
            }
            pimpl_->skill_undo.clear();
            for( auto it = pimpl_->skill_display_undo.rbegin(); it != pimpl_->skill_display_undo.rend();
                 ++it ) {
                const skill_displayType_id id = it->first;
                SkillDisplayType::skillTypes.erase(
                    std::remove_if( SkillDisplayType::skillTypes.begin(), SkillDisplayType::skillTypes.end(),
                [&id]( const SkillDisplayType & value ) {
                    return value.ident() == id;
                } ),
                SkillDisplayType::skillTypes.end() );
                if( it->second ) {
                    SkillDisplayType::skillTypes.push_back( *it->second );
                }
            }
            pimpl_->skill_display_undo.clear();
            restore_factory( detail::tool_quality_registry(), pimpl_->tool_quality_undo );
            restore_factory( detail::jmath_func_registry(), pimpl_->math_function_undo );
            restore_factory( detail::json_flag_registry(), pimpl_->json_flag_undo );
            break;
        case items_content_rollback_phase::materials:
            restore_factory( detail::material_registry(), pimpl_->material_undo );
            break;
        case items_content_rollback_phase::recipes:
            for( auto it = pimpl_->recipe_undo.rbegin(); it != pimpl_->recipe_undo.rend(); ++it ) {
                if( it->second ) {
                    recipe_dict.recipes[it->first] = *it->second;
                } else {
                    recipe_dict.recipes.erase( it->first );
                }
            }
            pimpl_->recipe_undo.clear();
            for( auto it = pimpl_->uncraft_undo.rbegin(); it != pimpl_->uncraft_undo.rend(); ++it ) {
                if( it->second ) {
                    recipe_dict.uncraft[it->first] = *it->second;
                } else {
                    recipe_dict.uncraft.erase( it->first );
                }
            }
            pimpl_->uncraft_undo.clear();
            break;
        case items_content_rollback_phase::definitions:
            for( auto it = pimpl_->item_undo.rbegin(); it != pimpl_->item_undo.rend(); ++it ) {
                if( it->second ) {
                    item_controller->m_runtimes[it->first] = std::make_unique<itype>( *it->second );
                } else {
                    item_controller->m_runtimes.erase( it->first );
                }
            }
            if( !pimpl_->item_undo.empty() ) {
                item_controller->m_runtimes_dirty = true;
                item_controller->templates_all_cache.clear();
                item_controller->armor_containers.clear();
            }
            pimpl_->item_undo.clear();
            break;
        case items_content_rollback_phase::requirements:
            for( auto it = pimpl_->requirement_undo.rbegin(); it != pimpl_->requirement_undo.rend(); ++it ) {
                requirement_data::registry().erase( it->first );
                if( it->second ) {
                    requirement_data::registry()[it->first] = *it->second;
                }
            }
            pimpl_->requirement_undo.clear();
            break;
        case items_content_rollback_phase::recipe_groups:
            for( auto it = pimpl_->recipe_group_undo.rbegin(); it != pimpl_->recipe_group_undo.rend(); ++it ) {
                detail::recipe_group_erase( it->first );
                if( it->second ) {
                    detail::recipe_group_set( *it->second );
                }
            }
            pimpl_->recipe_group_undo.clear();
            break;
        case items_content_rollback_phase::item_groups:
            for( auto it = pimpl_->item_group_extension_undo.rbegin();
                 it != pimpl_->item_group_extension_undo.rend(); ++it ) {
                const auto existing = item_controller->m_template_groups.find( it->first );
                if( existing != item_controller->m_template_groups.end() ) {
                    Item_group *const native = dynamic_cast<Item_group *>( existing->second.get() );
                    if( native != nullptr ) {
                        native->truncate_entries( it->second );
                    }
                }
            }
            pimpl_->item_group_extension_undo.clear();
            for( auto it = pimpl_->item_group_undo.rbegin(); it != pimpl_->item_group_undo.rend(); ++it ) {
                item_controller->m_template_groups.erase( it->first );
                if( it->second ) {
                    item_controller->m_template_groups[it->first] = std::move( it->second );
                }
            }
            pimpl_->item_group_undo.clear();
            break;
        case items_content_rollback_phase::metadata:
            for( auto it = pimpl_->item_action_undo.rbegin(); it != pimpl_->item_action_undo.rend(); ++it ) {
                detail::item_action_registry_erase( it->first );
                if( it->second ) {
                    detail::item_action_registry_set( *it->second );
                }
            }
            pimpl_->item_action_undo.clear();
            restore_factory( detail::butchery_requirements_registry(), pimpl_->butchery_requirements_undo );
            restore_factory( detail::scent_type_registry(), pimpl_->scent_type_undo );
            break;
        case items_content_rollback_phase::ammunition_effects:
            restore_factory( get_all_ammo_effects(), pimpl_->ammo_effect_undo );
            if( !pimpl_->ammo_effects.empty() ) {
                get_all_ammo_effects().finalize();
            }
            break;
        case items_content_rollback_phase::catalogs:
            for( auto it = pimpl_->ammunition_type_undo.rbegin(); it != pimpl_->ammunition_type_undo.rend();
                 ++it ) {
                if( it->second ) {
                    ammunition_type::registry()[it->first] = *it->second;
                } else {
                    ammunition_type::registry().erase( it->first );
                }
            }
            pimpl_->ammunition_type_undo.clear();
            restore_factory( detail::crafting_category_registry(), pimpl_->crafting_category_undo );
            for( auto it = pimpl_->item_category_undo.rbegin(); it != pimpl_->item_category_undo.rend();
                 ++it ) {
                const item_category_id &id = std::get<0>( *it );
                if( std::get<1>( *it ) ) {
                    detail::item_category_registry().restore( *std::get<1>( *it ) );
                } else {
                    detail::item_category_registry().erase( id );
                }
                item_category_spawn_rates::get_item_category_spawn_rates().set_spawn_rate(
                    id, std::get<2>( *it ) );
            }
            pimpl_->item_category_undo.clear();
            restore_factory( detail::weapon_category_registry(), pimpl_->weapon_category_undo );
            restore_factory( detail::proficiency_registry(), pimpl_->proficiency_undo );
            restore_factory( detail::proficiency_category_registry(), pimpl_->proficiency_category_undo );
            break;
    }
    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

void items_content_transaction::rollback_all()
{
    while( pimpl_->applied_phase_count > 0 ) {
        rollback_phase( static_cast<items_content_rollback_phase>( pimpl_->applied_phase_count - 1 ) );
        --pimpl_->applied_phase_count;
    }
    pimpl_->next_apply_phase = items_content_apply_phase::foundations;
    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

void items_content_transaction::commit()
{
    if( !pimpl_->applied ) {
        return;
    }
    pimpl_->tool_quality_undo.clear();
    pimpl_->skill_display_undo.clear();
    pimpl_->skill_undo.clear();
    pimpl_->vitamin_undo.clear();
    pimpl_->json_flag_undo.clear();
    pimpl_->math_function_undo.clear();
    pimpl_->damage_type_undo.clear();
    pimpl_->material_undo.clear();
    pimpl_->ammunition_type_undo.clear();
    pimpl_->item_category_undo.clear();
    pimpl_->crafting_category_undo.clear();
    pimpl_->proficiency_category_undo.clear();
    pimpl_->proficiency_undo.clear();
    pimpl_->weapon_category_undo.clear();
    pimpl_->requirement_undo.clear();
    pimpl_->recipe_group_undo.clear();
    pimpl_->scent_type_undo.clear();
    pimpl_->butchery_requirements_undo.clear();
    pimpl_->item_action_undo.clear();
    pimpl_->item_group_undo.clear();
    pimpl_->item_group_extension_undo.clear();
    pimpl_->ammo_effect_undo.clear();
    pimpl_->item_undo.clear();
    pimpl_->recipe_undo.clear();
    pimpl_->uncraft_undo.clear();
    pimpl_->token->lifecycle = handle_lifecycle::committed;
}

void items_content_transaction::seal()
{
    if( pimpl_->applied && pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::committed;
    }
}

void items_content_transaction::discard()
{
    rollback_all();
}

bool items_content_transaction::was_applied() const
{
    return pimpl_->applied;
}

bool items_content_transaction::has_requirements() const
{
    return !pimpl_->requirements.empty();
}

bool items_content_transaction::has_requirement_changes() const
{
    return pimpl_->requirement_changes;
}

bool items_content_transaction::defines_tool_quality( const std::string_view id ) const
{
    return defines_registration( pimpl_->tool_qualities, id );
}

items_content_staged_ids items_content_transaction::staged_ids() const
{
    items_content_staged_ids result;
    const auto collect = []( const auto & registrations, std::set<std::string> &ids ) {
        for( const auto &entry : registrations ) {
            ids.insert( entry.definition->id );
        }
    };
    collect( pimpl_->tool_qualities, result.tool_qualities );
    collect( pimpl_->skill_displays, result.skill_displays );
    collect( pimpl_->skills, result.skills );
    collect( pimpl_->vitamins, result.vitamins );
    collect( pimpl_->json_flags, result.json_flags );
    collect( pimpl_->math_functions, result.math_functions );
    collect( pimpl_->damage_types, result.damage_types );
    collect( pimpl_->materials, result.materials );
    collect( pimpl_->proficiencies, result.proficiencies );
    collect( pimpl_->proficiency_categories, result.proficiency_categories );
    collect( pimpl_->weapon_categories, result.weapon_categories );
    collect( pimpl_->ammunition_types, result.ammunition_types );
    collect( pimpl_->item_categories, result.item_categories );
    collect( pimpl_->crafting_categories, result.crafting_categories );
    collect( pimpl_->items, result.items );
    collect( pimpl_->item_groups, result.item_groups );
    collect( pimpl_->recipes, result.recipes );
    collect( pimpl_->requirements, result.requirements );
    collect( pimpl_->scent_types, result.scent_types );
    collect( pimpl_->ammo_effects, result.ammo_effects );
    collect( pimpl_->butchery_requirement_entries, result.butchery_requirements );
    collect( pimpl_->item_actions, result.item_actions );
    return result;
}
bool items_content_transaction::defines_skill( const std::string_view id ) const
{
    return defines_registration( pimpl_->skills, id );
}
bool items_content_transaction::defines_vitamin( const std::string_view id ) const
{
    return defines_registration( pimpl_->vitamins, id );
}
bool items_content_transaction::defines_json_flag( const std::string_view id ) const
{
    return defines_registration( pimpl_->json_flags, id );
}
bool items_content_transaction::defines_math_function( const std::string_view id ) const
{
    return defines_registration( pimpl_->math_functions, id );
}
bool items_content_transaction::defines_damage_type( const std::string_view id ) const
{
    return defines_registration( pimpl_->damage_types, id );
}
bool items_content_transaction::defines_material( const std::string_view id ) const
{
    return defines_registration( pimpl_->materials, id );
}
bool items_content_transaction::defines_proficiency( const std::string_view id ) const
{
    return defines_registration( pimpl_->proficiencies, id );
}
bool items_content_transaction::defines_item( const std::string_view id ) const
{
    return defines_registration( pimpl_->items, id );
}
bool items_content_transaction::defines_item_group( const std::string_view id ) const
{
    return defines_registration( pimpl_->item_groups, id );
}
bool items_content_transaction::defines_recipe( const std::string_view id ) const
{
    return defines_registration( pimpl_->recipes, id );
}
bool items_content_transaction::defines_requirement( const std::string_view id ) const
{
    return defines_registration( pimpl_->requirements, id );
}
bool items_content_transaction::defines_scent_type( const std::string_view id ) const
{
    return defines_registration( pimpl_->scent_types, id );
}

bool items_content_transaction::find_item_handler( const std::string_view item_id,
        const std::string_view phase, std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->items.rbegin(), pimpl_->items.rend(),
    [item_id]( const item_registration & entry ) {
        return entry.definition->id == item_id;
    } );
    if( found == pimpl_->items.rend() ) {
        handler_id.clear();
        return false;
    }
    handler_id = phase == "use" ? found->definition->use_handler :
                 phase == "consume" ? found->definition->consume_handler : std::string();
    return true;
}

bool items_content_transaction::find_damage_handler( const std::string_view damage_id,
        const std::string_view phase, std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->damage_types.rbegin(), pimpl_->damage_types.rend(),
    [damage_id]( const damage_type_registration & entry ) {
        return entry.definition->id == damage_id;
    } );
    if( found == pimpl_->damage_types.rend() ) {
        return false;
    }
    handler_id = phase == "on_hit" ? found->definition->on_hit_handler :
                 phase == "on_damage" ? found->definition->on_damage_handler : std::string();
    return true;
}

bool items_content_transaction::find_ammo_effect_handler( const std::string_view ammo_effect_id,
        std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->ammo_effects.rbegin(), pimpl_->ammo_effects.rend(),
    [ammo_effect_id]( const ammo_effect_registration & entry ) {
        return entry.definition->id == ammo_effect_id;
    } );
    if( found == pimpl_->ammo_effects.rend() ) {
        return false;
    }
    handler_id = found->definition->impact_handler;
    return true;
}

bool items_content_transaction::find_plant_lifecycle_handler( const std::string_view target,
        const std::string_view target_id, const std::string_view phase,
        std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->plant_lifecycles.rbegin(), pimpl_->plant_lifecycles.rend(),
    [target, target_id]( const plant_lifecycle_registration & entry ) {
        return entry.definition->target == target && entry.definition->id == target_id;
    } );
    if( found == pimpl_->plant_lifecycles.rend() ) {
        handler_id.clear();
        return false;
    }
    const auto handler = found->definition->handlers.find( std::string( phase ) );
    handler_id = handler == found->definition->handlers.end() ? std::string() : handler->second;
    return true;
}

void items_content_transaction::append_fingerprint( const items_content_fingerprint_phase phase,
        std::uint64_t &state ) const
{
    // Keep each phase's encoding identical to the old monolithic transaction.
    // The order of registrations is intentional: maps/sets retain their
    // deterministic iteration order while vectors retain Lua declaration order.
    switch( phase ) {
        case items_content_fingerprint_phase::foundations:
            for( const json_flag_registration &entry : pimpl_->json_flags ) {
                hash_part( state, "json_flag" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.info );
                hash_part( state, v.restriction );
                hash_part( state, v.name );
                hash_part( state, v.item_prefix );
                hash_part( state, v.item_suffix );
                hash_part( state, v.requires_flag );
                hash_part( state, std::to_string( v.taste_modifier ) );
                hash_part( state, v.inherit ? "inherit" : "local" );
                hash_part( state, v.craft_inherit ? "craft_inherit" : "no_craft_inherit" );
                for( const auto &id : v.conflicts ) {
                    hash_part( state, id );
                }
            }
            for( const math_function_registration &entry : pimpl_->math_functions ) {
                hash_part( state, "math_function" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, std::to_string( entry.definition->num_args ) );
                hash_part( state, entry.definition->expression );
            }
            for( const tool_quality_registration &entry : pimpl_->tool_qualities ) {
                hash_part( state, "tool_quality" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->name );
                for( const auto &[level, text] : entry.definition->usages ) {
                    hash_part( state, std::to_string( level ) );
                    hash_part( state, text );
                }
            }
            for( const skill_display_registration &entry : pimpl_->skill_displays ) {
                hash_part( state, "skill_display" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->label );
            }
            for( const skill_registration &entry : pimpl_->skills ) {
                hash_part( state, "skill" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.description );
                hash_part( state, v.display_category );
                hash_part( state, std::to_string( v.sort_rank ) );
                hash_part( state, v.consumes_focus ? "focus" : "no_focus" );
                hash_part( state, v.teachable ? "teachable" : "not_teachable" );
                hash_part( state, v.obsolete ? "obsolete" : "current" );
                hash_part( state, std::to_string( v.attack_min_time ) );
                hash_part( state, std::to_string( v.attack_base_time ) );
                hash_part( state, std::to_string( v.attack_reduction_per_level ) );
                hash_part( state, std::to_string( v.companion_combat_rank_factor ) );
                hash_part( state, std::to_string( v.companion_survival_rank_factor ) );
                hash_part( state, std::to_string( v.companion_industry_rank_factor ) );
                for( const auto &tag : v.tags ) {
                    hash_part( state, tag );
                }
                for( const auto &[id, weight] : v.companion_practice ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( weight ) );
                }
                for( const auto &[level, description] : v.theory_descriptions ) {
                    hash_part( state, std::to_string( level ) );
                    hash_part( state, description );
                }
                for( const auto &[level, description] : v.practice_descriptions ) {
                    hash_part( state, std::to_string( level ) );
                    hash_part( state, description );
                }
                for( const auto &id : v.requires_all_traits ) {
                    hash_part( state, "all" );
                    hash_part( state, id );
                }
                for( const auto &id : v.requires_any_traits ) {
                    hash_part( state, "any" );
                    hash_part( state, id );
                }
            }
            for( const vitamin_registration &entry : pimpl_->vitamins ) {
                hash_part( state, "vitamin" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.type );
                hash_part( state, v.deficiency );
                hash_part( state, v.excess );
                hash_part( state, std::to_string( v.minimum ) );
                hash_part( state, std::to_string( v.maximum ) );
                hash_part( state, std::to_string( v.rate_turns ) );
                hash_part( state, v.weight_micrograms ? std::to_string( *v.weight_micrograms ) : "no_weight" );
                for( const auto &[start, end] : v.disease ) {
                    hash_part( state, std::to_string( start ) );
                    hash_part( state, std::to_string( end ) );
                }
                for( const auto &[start, end] : v.disease_excess ) {
                    hash_part( state, std::to_string( start ) );
                    hash_part( state, std::to_string( end ) );
                }
                for( const auto &[id, rate] : v.decays_into ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( rate ) );
                }
                for( const auto &id : v.flags ) {
                    hash_part( state, id );
                }
            }
            break;
        case items_content_fingerprint_phase::damage_types:
            for( const damage_type_registration &entry : pimpl_->damage_types ) {
                hash_part( state, "damage_type" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.skill );
                hash_part( state, v.magic_color );
                hash_part( state, v.derived_from );
                hash_part( state, v.on_hit_handler );
                hash_part( state, v.on_damage_handler );
                hash_part( state, std::to_string( v.derived_factor ) );
                hash_part( state, std::to_string( v.bash_conversion_factor ) );
                hash_part( state, v.melee_only ? "melee" : "ranged" );
                hash_part( state, v.physical ? "physical" : "nonphysical" );
                hash_part( state, v.monster_difficulty ? "monster_difficulty" : "ordinary" );
                hash_part( state, v.no_resist ? "no_resist" : "resisted" );
                hash_part( state, v.edged ? "edged" : "blunt" );
                hash_part( state, v.environmental ? "environmental" : "direct" );
                hash_part( state, v.material_required ? "material_required" : "material_optional" );
                for( const auto &id : v.character_immune_flags ) {
                    hash_part( state, "character" );
                    hash_part( state, id );
                }
                for( const auto &id : v.monster_immune_flags ) {
                    hash_part( state, "monster" );
                    hash_part( state, id );
                }
            }
            break;
        case items_content_fingerprint_phase::materials:
            for( const material_registration &entry : pimpl_->materials ) {
                hash_part( state, "material" );
                hash_part( state, operation_name( entry.operation ) );
                const auto &v = *entry.definition;
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.salvaged_into );
                hash_part( state, v.repaired_with );
                hash_part( state, v.bash_damage_verb );
                hash_part( state, v.cut_damage_verb );
                hash_part( state, std::to_string( v.chip_resistance ) );
                hash_part( state, std::to_string( v.breathability ) );
                hash_part( state, std::to_string( v.repair_difficulty ) );
                hash_part( state, v.wind_resistance ? std::to_string( *v.wind_resistance ) : "no_wind" );
                hash_part( state, std::to_string( v.density ) );
                hash_part( state, std::to_string( v.sheet_thickness ) );
                hash_part( state, std::to_string( v.specific_heat_liquid ) );
                hash_part( state, std::to_string( v.specific_heat_solid ) );
                hash_part( state, std::to_string( v.latent_heat ) );
                hash_part( state, std::to_string( v.freezing_point ) );
                hash_part( state, v.rotting ? "rotting" : "stable" );
                hash_part( state, v.soft ? "soft" : "hard" );
                hash_part( state, v.uncomfortable ? "uncomfortable" : "comfortable" );
                hash_part( state, v.conductive ? "conductive" : "insulating" );
                for( const auto &id : v.damage_adjectives ) {
                    hash_part( state, id );
                }
                for( const auto &[id, amount] : v.resistances ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                for( const auto &[id, amount] : v.vitamins ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                for( const auto &burn : v.burn_data ) {
                    hash_part( state, burn.immune ? "immune" : "burnable" );
                    hash_part( state, std::to_string( burn.volume_ml_per_turn ) );
                    hash_part( state, std::to_string( burn.fuel ) );
                    hash_part( state, std::to_string( burn.smoke ) );
                    hash_part( state, std::to_string( burn.burn ) );
                }
                for( const auto &[id, amount] : v.burn_products ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                hash_part( state, v.has_fuel ? "fuel" : "no_fuel" );
                hash_part( state, std::to_string( v.fuel_energy_kilojoules ) );
                hash_part( state, v.fuel_pump_terrain );
                hash_part( state, v.perpetual_fuel ? "perpetual" : "consumed" );
                hash_part( state, std::to_string( v.explosion_chance_hot ) );
                hash_part( state, std::to_string( v.explosion_chance_cold ) );
                hash_part( state, std::to_string( v.explosion_factor ) );
                hash_part( state, v.fiery_explosion ? "fiery" : "ordinary" );
                hash_part( state, std::to_string( v.fuel_size_factor ) );
            }
            break;
        case items_content_fingerprint_phase::catalogs:
            for( const auto &entry : pimpl_->proficiency_categories ) {
                hash_part( state, "proficiency_category" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->name );
                hash_part( state, entry.definition->description );
            }
            for( const auto &entry : pimpl_->proficiencies ) {
                const auto &v = *entry.definition;
                hash_part( state, "proficiency" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.name );
                hash_part( state, v.description );
                hash_part( state, v.category );
                hash_part( state, std::to_string( v.time_to_learn_turns ) );
                hash_part( state, std::to_string( v.time_multiplier ) );
                hash_part( state, std::to_string( v.skill_penalty ) );
                hash_part( state, std::to_string( v.weakpoint_bonus ) );
                hash_part( state, std::to_string( v.weakpoint_penalty ) );
                hash_part( state, v.can_learn ? "learnable" : "fixed" );
                hash_part( state, v.ignore_focus ? "ignore_focus" : "use_focus" );
                hash_part( state, v.teachable ? "teachable" : "not_teachable" );
                for( const auto &id : v.required ) {
                    hash_part( state, id );
                }
                for( const auto &bonus : v.bonuses ) {
                    hash_part( state, bonus.category );
                    hash_part( state, bonus.attribute );
                    hash_part( state, std::to_string( bonus.value ) );
                }
            }
            for( const auto &entry : pimpl_->weapon_categories ) {
                hash_part( state, "weapon_category" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->name );
                for( const auto &id : entry.definition->proficiencies ) {
                    hash_part( state, id );
                }
            }
            for( const auto &entry : pimpl_->item_categories ) {
                const auto &v = *entry.definition;
                hash_part( state, "item_category" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.header );
                hash_part( state, v.noun );
                hash_part( state, std::to_string( v.sort_rank ) );
                hash_part( state, std::to_string( v.spawn_rate ) );
                hash_part( state, v.zone );
                for( const auto &p : v.priority_zones ) {
                    hash_part( state, p.zone );
                    hash_part( state, p.filthy ? "filthy" : "flagged" );
                    for( const auto &id : p.flags ) {
                        hash_part( state, id );
                    }
                }
            }
            for( const auto &entry : pimpl_->crafting_categories ) {
                const auto &v = *entry.definition;
                hash_part( state, "recipe_category" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.hidden ? "hidden" : "visible" );
                hash_part( state, v.practice ? "practice" : "ordinary" );
                hash_part( state, v.building ? "building" : "not_building" );
                hash_part( state, v.wildcard ? "wildcard" : "concrete" );
                for( const auto &id : v.subcategories ) {
                    hash_part( state, id );
                }
            }
            for( const auto &entry : pimpl_->ammunition_types ) {
                hash_part( state, "ammunition_type" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                hash_part( state, entry.definition->name );
                hash_part( state, entry.definition->default_item );
            }
            break;
        case items_content_fingerprint_phase::ammunition_effects:
            for( const auto &entry : pimpl_->ammo_effects ) {
                const auto &v = *entry.definition;
                hash_part( state, "ammo_effect" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, std::to_string( v.trigger_chance ) );
                const auto field = [&state]( const auto & f ) {
                    hash_part( state, f.field );
                    hash_part( state, std::to_string( f.intensity_min ) );
                    hash_part( state, std::to_string( f.intensity_max ) );
                    hash_part( state, std::to_string( f.radius ) );
                    hash_part( state, std::to_string( f.height ) );
                    hash_part( state, std::to_string( f.chance ) );
                    hash_part( state, std::to_string( f.footprint ) );
                    hash_part( state, f.passable_only ? "passable" : "any_tile" );
                };
                for( const auto &f : v.field_bursts ) {
                    hash_part( state, "field_burst" );
                    field( f );
                }
                for( const auto &f : v.trails ) {
                    hash_part( state, "trail" );
                    field( f );
                }
                const auto effect = [&state]( const auto & e ) {
                    hash_part( state, e.effect );
                    hash_part( state, std::to_string( e.duration_turns ) );
                    hash_part( state, std::to_string( e.intensity_min ) );
                    hash_part( state, std::to_string( e.intensity_max ) );
                    hash_part( state, std::to_string( e.chance ) );
                    hash_part( state, std::to_string( e.radius ) );
                    hash_part( state, std::to_string( e.hits_min ) );
                    hash_part( state, std::to_string( e.hits_max ) );
                    hash_part( state, e.touch_skin ? "touch_skin" : "through_armor" );
                    hash_part( state, e.all_body_parts ? "all_body_parts" : "random_parts" );
                };
                for( const auto &e : v.on_hit_effects ) {
                    hash_part( state, "on_hit" );
                    effect( e );
                }
                for( const auto &e : v.area_effects ) {
                    hash_part( state, "area_effect" );
                    effect( e );
                }
                hash_part( state, v.has_explosion ? "explosion" : "no_explosion" );
                hash_part( state, std::to_string( v.explosion_power ) );
                hash_part( state, std::to_string( v.explosion_distance_factor ) );
                hash_part( state, std::to_string( v.explosion_max_noise ) );
                hash_part( state, v.explosion_fire ? "fire" : "no_fire" );
                hash_part( state, v.explosion_light );
                hash_part( state, v.has_shrapnel ? "shrapnel" : "no_shrapnel" );
                hash_part( state, std::to_string( v.casing_mass ) );
                hash_part( state, std::to_string( v.fragment_mass ) );
                hash_part( state, std::to_string( v.fragment_recovery ) );
                hash_part( state, v.fragment_drop );
                hash_part( state, v.flashbang ? "flashbang" : "no_flashbang" );
                hash_part( state, v.emp ? "emp" : "no_emp" );
                hash_part( state, v.foamcrete ? "foamcrete" : "no_foamcrete" );
                hash_part( state, v.cast_spells_on_miss ? "spells_always" : "spells_on_damage" );
                for( const auto &s : v.spells ) {
                    hash_part( state, s.spell );
                    hash_part( state, std::to_string( s.level ) );
                    hash_part( state, s.self ? "self" : "impact" );
                }
                hash_part( state, v.impact_handler );
            }
            break;
        case items_content_fingerprint_phase::metadata:
            for( const auto &entry : pimpl_->scent_types ) {
                hash_part( state, "scent_type" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                for( const auto &id : entry.definition->receptive_species ) {
                    hash_part( state, id );
                }
            }
            break;
        case items_content_fingerprint_phase::item_groups:
            for( const auto &entry : pimpl_->item_groups ) {
                const auto &v = *entry.definition;
                hash_part( state, "item_group" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.kind );
                hash_part( state, std::to_string( v.with_ammo ) );
                hash_part( state, std::to_string( v.with_magazine ) );
                for( const auto &e : v.entries ) {
                    hash_part( state, e.group ? "group" : "item" );
                    hash_part( state, e.id );
                    hash_part( state, std::to_string( e.probability ) );
                    hash_part( state, e.variant );
                    hash_part( state, std::to_string( e.count_min ) );
                    hash_part( state, std::to_string( e.count_max ) );
                    hash_part( state, std::to_string( e.charges_min ) );
                    hash_part( state, std::to_string( e.charges_max ) );
                }
            }
            break;
        case items_content_fingerprint_phase::requirements:
            for( const auto &entry : pimpl_->requirements ) {
                const auto &v = *entry.definition;
                hash_part( state, "requirement" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.name );
                for( const auto &g : v.components ) {
                    hash_part( state, "components" );
                    for( const auto &e : g ) {
                        hash_part( state, e.id );
                        hash_part( state, std::to_string( e.count ) );
                        hash_part( state, e.requirement ? "requirement" : "item" );
                    }
                }
                for( const auto &g : v.tools ) {
                    hash_part( state, "tools" );
                    for( const auto &e : g ) {
                        hash_part( state, e.id );
                        hash_part( state, std::to_string( e.count ) );
                        hash_part( state, e.requirement ? "requirement" : "item" );
                    }
                }
                for( const auto &g : v.qualities ) {
                    hash_part( state, "qualities" );
                    for( const auto &e : g ) {
                        hash_part( state, e.id );
                        hash_part( state, std::to_string( e.level ) );
                        hash_part( state, std::to_string( e.count ) );
                    }
                }
            }
            break;
        case items_content_fingerprint_phase::recipe_groups:
            for( const auto &entry : pimpl_->recipe_groups ) {
                const auto &v = *entry.definition;
                hash_part( state, "recipe_group" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.building_type );
                for( const auto &r : v.recipes ) {
                    hash_part( state, r.id );
                    hash_part( state, r.description );
                    for( const auto &t : r.terrains ) {
                        hash_part( state, t.overmap_terrain );
                        hash_part( state, t.match_type );
                        for( const auto &[p, values] : t.parameters ) {
                            hash_part( state, p );
                            for( const auto &value : values ) {
                                hash_part( state, value );
                            }
                        }
                    }
                }
            }
            break;
        case items_content_fingerprint_phase::definitions:
            for( const auto &entry : pimpl_->items ) {
                const auto &v = *entry.definition;
                hash_part( state, "item" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.copy_from );
                hash_part( state, v.name );
                hash_part( state, v.description );
                hash_part( state, v.symbol );
                hash_part( state, std::to_string( v.mass_grams ) );
                hash_part( state, std::to_string( v.volume_ml ) );
                hash_part( state, std::to_string( v.price_cents ) );
                hash_part( state, std::to_string( v.price_postapoc_cents ) );
                hash_part( state, v.color );
                hash_part( state, v.category );
                hash_part( state, v.looks_like );
                hash_part( state, std::to_string( v.magazine_capacity ) );
                hash_part( state, v.use_handler );
                hash_part( state, v.use_label );
                hash_part( state, v.consume_handler );
                if( v.comestible ) {
                    const item_definition_data::comestible_data &food = *v.comestible;
                    hash_part( state, "comestible" );
                    hash_part( state, food.type );
                    hash_part( state, std::to_string( food.calories ) );
                    hash_part( state, std::to_string( food.fun ) );
                    hash_part( state, std::to_string( food.healthy ) );
                    hash_part( state, std::to_string( food.quench ) );
                    hash_part( state, std::to_string( food.spoils_in_turns ) );
                    hash_part( state, std::to_string( food.charges ) );
                    hash_part( state, std::to_string( food.stack_size ) );
                    for( const auto &[vitamin_key, amount] : food.vitamins ) {
                        hash_part( state, vitamin_key );
                        hash_part( state, std::to_string( amount ) );
                    }
                }
                if( v.book ) {
                    const item_definition_data::book_data &book = *v.book;
                    hash_part( state, "book" );
                    hash_part( state, book.skill );
                    hash_part( state, std::to_string( book.required_level ) );
                    hash_part( state, std::to_string( book.maximum_level ) );
                    hash_part( state, std::to_string( book.intelligence ) );
                    hash_part( state, std::to_string( book.read_time_turns ) );
                    hash_part( state, std::to_string( book.fun ) );
                }
                for( const auto &m : v.materials ) {
                    hash_part( state, m.id );
                    hash_part( state, std::to_string( m.portions ) );
                }
                for( const auto &q : v.qualities ) {
                    hash_part( state, q.id );
                    hash_part( state, std::to_string( q.level ) );
                }
                for( const auto &id : v.flags ) {
                    hash_part( state, id );
                }
                for( const auto &[id, amount] : v.melee_damage ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                for( const auto &[id, amount] : v.magazine_ammo ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
            }
            break;
        case items_content_fingerprint_phase::recipes:
            for( const auto &entry : pimpl_->recipes ) {
                const auto &v = *entry.definition;
                hash_part( state, "recipe" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, v.id );
                hash_part( state, v.nested_category ? "nested_category" : "craft_recipe" );
                hash_part( state, v.result );
                hash_part( state, v.result_charges ?
                           std::to_string( *v.result_charges ) : "default_charges" );
                hash_part( state, v.name );
                hash_part( state, v.description );
                hash_part( state, v.category );
                hash_part( state, v.subcategory );
                hash_part( state, std::to_string( v.activity_level ) );
                for( const auto &id : v.nested_recipes ) {
                    hash_part( state, id );
                }
                hash_part( state, v.skill );
                hash_part( state, std::to_string( v.difficulty ) );
                hash_part( state, std::to_string( v.time_moves ) );
                hash_part( state, v.autolearn ? "autolearn" : "manual" );
                hash_part( state, v.reversible ? "reversible" : "irreversible" );
                for( const auto &g : v.components ) {
                    hash_part( state, "and" );
                    for( const auto &e : g ) {
                        hash_part( state, e.id );
                        hash_part( state, std::to_string( e.count ) );
                        hash_part( state, e.requirement ? "requirement" : "item" );
                    }
                }
                for( const auto &g : v.tools ) {
                    hash_part( state, "tool" );
                    for( const auto &e : g ) {
                        hash_part( state, e.id );
                        hash_part( state, std::to_string( e.count ) );
                        hash_part( state, e.requirement ? "requirement" : "item" );
                    }
                }
                for( const auto &[id, level] : v.required_skills ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( level ) );
                }
                for( const auto &[id, amount] : v.external_requirements ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( amount ) );
                }
                for( const auto &p : v.proficiencies ) {
                    hash_part( state, p.id );
                    hash_part( state, p.required ? "required" : "optional" );
                    hash_part( state, std::to_string( p.time_multiplier ) );
                    hash_part( state, std::to_string( p.skill_penalty ) );
                }
                for( const auto &[id, level] : v.books ) {
                    hash_part( state, id );
                    hash_part( state, std::to_string( level ) );
                }
                hash_part( state, v.result_handler );
            }
            for( const auto &entry : pimpl_->plant_lifecycles ) {
                hash_part( state, "plant_lifecycle" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->target );
                hash_part( state, entry.definition->id );
                for( const auto &[id, handler] : entry.definition->handlers ) {
                    hash_part( state, id );
                    hash_part( state, handler );
                }
            }
            break;
    }
}

} // namespace cata::lua_platform

#else

namespace cata::lua_platform
{

struct items_content_transaction::impl {};

items_content_transaction::items_content_transaction( std::string, std::size_t ) :
    pimpl_( std::make_unique<impl>() )
{}

items_content_transaction::~items_content_transaction() = default;

bool items_content_transaction::validate( const runtime &, bool,
        const items_content_validation_context &, std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool items_content_transaction::validate_scaled_requirement_set(
    const std::vector<std::pair<std::string, std::int64_t>> &, std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool items_content_transaction::apply_phase( items_content_apply_phase, std::string &error )
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool items_content_transaction::validate_finalized( std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

void items_content_transaction::rollback_phase( items_content_rollback_phase ) {}
void items_content_transaction::rollback_all() {}
void items_content_transaction::commit() {}
void items_content_transaction::seal() {}
void items_content_transaction::discard() {}
void items_content_transaction::append_fingerprint( items_content_fingerprint_phase,
        std::uint64_t & ) const {}
bool items_content_transaction::was_applied() const
{
    return false;
}
bool items_content_transaction::has_requirements() const
{
    return false;
}
bool items_content_transaction::has_requirement_changes() const
{
    return false;
}
items_content_staged_ids items_content_transaction::staged_ids() const
{
    return {};
}
bool items_content_transaction::defines_tool_quality( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_skill( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_vitamin( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_json_flag( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_math_function( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_damage_type( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_material( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_proficiency( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_item( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_item_group( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_recipe( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_requirement( std::string_view ) const
{
    return false;
}
bool items_content_transaction::defines_scent_type( std::string_view ) const
{
    return false;
}
bool items_content_transaction::find_item_handler( std::string_view, std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool items_content_transaction::find_damage_handler( std::string_view, std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool items_content_transaction::find_ammo_effect_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool items_content_transaction::find_plant_lifecycle_handler( std::string_view, std::string_view,
        std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

} // namespace cata::lua_platform

#endif
