Warning: truncated output (original token count: 614421)
... 1409107 bytes omitted ...

#include "catalua_platform_runtime.h"

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI

#include <algorithm>
#include <array>
#include <cctype>
#include <charconv>
#include <cmath>
#include <cstdint>
#include <filesystem>
#include <functional>
#include <iomanip>
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

#include "calendar.h"
#include "addiction.h"
#include "achievement.h"
#include "activity_actor.h"
#include "activity_handlers.h"
#include "activity_type.h"
#include "activity_actor_definitions.h"
#include "ammo.h"
#include "ammo_effect.h"
#include "anatomy.h"
#include "ascii_art.h"
#include "avatar.h"
#include "behavior.h"
#include "behavior_oracle.h"
#include "behavior_strategy.h"
#include "bodypart.h"
#include "bodygraph.h"
#include "bionics.h"
#include "butchery_requirements.h"
#include "butchery.h"
#include "cata_path.h"
#include "catacharset.h"
#include "cata_utility.h"
#include "cata_variant.h"
#include "catalua_platform_content.h"
#include "catalua_platform_world_content.h"
#include "catalua_dialogue_common.h"
#include "catalua_ui_state.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catacharset.h"
#include "catalua_game_handle.h"
#include "catalua_ui_achievements.h"
#include "catalua_ui_activities.h"
#include "catalua_ui_addictions.h"
#include "catalua_ui_bionics.h"
#include "catalua_ui_camps.h"
#include "catalua_ui_crafting.h"
#include "catalua_ui_creatures.h"
#include "catalua_ui_effects.h"
#include "catalua_ui_eocs.h"
#include "catalua_ui_factions.h"
#include "catalua_ui_game.h"
#include "catalua_ui_game_info.h"
#include "catalua_ui_hordes.h"
#include "catalua_ui_interaction.h"
#include "catalua_ui_items.h"
#include "catalua_ui_magic.h"
#include "catalua_ui_mapgen.h"
#include "catalua_ui_martial_arts.h"
#include "catalua_ui_missions.h"
#include "catalua_ui_mutations.h"
#include "catalua_ui_needs.h"
#include "catalua_ui_npcs.h"
#include "catalua_ui_overmap.h"
#include "catalua_ui_proficiencies.h"
#include "catalua_ui_registry.h"
#include "catalua_ui_skills.h"
#include "catalua_ui_statistics.h"
#include "catalua_ui_time.h"
#include "catalua_ui_trade.h"
#include "catalua_ui_vehicles.h"
#include "catalua_ui_vitamins.h"
#include "catalua_ui_weather.h"
#include "catalua_ui_world.h"
#include "catalua_ui_world_services.h"
#include "catalua_ui_zones.h"
#include "character.h"
#include "character_martial_arts.h"
#include "character_modifier.h"
#include "climbing.h"
#include "city.h"
#include "clothing_mod.h"
#include "clzones.h"
#include "color.h"
#include "computer.h"
#include "construction.h"
#include "coordinates.h"
#include "creature.h"
#include "construction_category.h"
#include "construction_group.h"
#include "crafting_gui.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "disease.h"
#include "emit.h"
#include "effect.h"
#include "enum_conversions.h"
#include "end_screen.h"
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
#include "generic_factory.h"
#include "game.h"
#include "gates.h"
#include "harvest.h"
#include "help.h"
#include "hsv_color.h"
#include "init.h"
#include "item.h"
#include "item_group.h"
#include "item_category.h"
#include "item_factory.h"
#include "item_action.h"
#include "item_location.h"
#include "itype.h"
#include "iuse.h"
#include "iexamine_actors.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_accessories.h"
#include "mapgen.h"
#include "mapgen_functions.h"
#include "mapgendata.h"
#include "mapgen_post_process.h"
#include "mapdata.h"
#include "map_extras.h"
#include "map_scale_constants.h"
#include "magic_type.h"
#include "magic_enchantment.h"
#include "magic_ter_furn_transform.h"
#include "mattack_common.h"
#include "mattack_actors.h"
#include "material.h"
#include "martialarts.h"
#include "math_parser_diag.h"
#include "math_parser_jmath.h"
#include "messages.h"
#include "mission.h"
#include "math_parser.h"
#include "morale_types.h"
#include "mood_face.h"
#include "mod_tracker.h"
#include "monfaction.h"
#include "mondefense.h"
#include "monster.h"
#include "monstergenerator.h"
#include "move_mode.h"
#include "mod_tileset.h"
#include "mongroup.h"
#include "mtype.h"
#include "mutation.h"
#include "npc.h"
#include "npctrade.h"
#include "omdata.h"
#include "options.h"
#include "overmap_location.h"
#include "overmap_map_data_cache.h"
#include "overmap_connection.h"
#include "overmap_worldgen.h"
#include "output.h"
#include "overlay_ordering.h"
#include "proficiency.h"
#include "profession_group.h"
#include "profession.h"
#include "player_activity.h"
#include "path_info.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "recipe_groups.h"
#include "regional_settings.h"
#include "relic.h"
#include "requirements.h"
#include "trap.h"
#include "rotatable_symbols.h"
#include "scent_map.h"
#include "scenario.h"
#include "skill.h"
#include "sounds.h"
#include "shop_cons_rate.h"
#include "speech.h"
#include "speed_description.h"
#include "start_location.h"
#include "string_input_popup.h"
#include "string_formatter.h"
#include "subbodypart.h"
#include "translation.h"
#include "talker.h"
#include "talker_topic.h"
#include "npctalk.h"
#include "text_snippets.h"
#include "timed_event.h"
#include "type_id.h"
#include "units.h"
#include "uilist.h"
#include "vehicle.h"
#include "vehicle_group.h"
#include "vehicle_part_location.h"
#include "veh_type.h"
#include "vehicle_palette.h"
#include "vitamin.h"
#include "weather_gen.h"
#include "weather_type.h"
#include "widget.h"
#include "weakpoint.h"
#include "wound.h"
#include "worldfactory.h"

namespace cata::lua_platform
{

namespace
{

using persistent_state = cata::lua_ui::script_persistent_state;
using persistent_value = cata::lua_ui::script_persistent_value;

constexpr std::size_t maximum_platform_dialogue_topics = 8192;
constexpr std::size_t maximum_platform_dialogue_extensions = 8192;
constexpr std::size_t maximum_platform_dialogue_responses_per_topic = 1024;
constexpr std::size_t maximum_platform_dialogue_repeat_responses_per_topic = 1024;

enum class definition_operation : int {
    add,
    replace,
    edit
};

enum class handle_lifecycle : int {
    building,
    committed,
    discarded
};

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

bool fits_native_int( const std::int64_t value )
{
    return value >= std::numeric_limits<int>::min() &&
           value <= std::numeric_limits<int>::max();
}

std::pair<std::int64_t, std::int64_t> read_exact_coordinate_table(
    const sol::table &table, const std::string_view description )
{
    bool has_x = false;
    bool has_y = false;
    bool named_coordinate = true;
    std::size_t observed = 0;
    for( const auto &entry : table ) {
        ++observed;
        const sol::object key = entry.first;
        if( !key.is<std::string>() ) {
            named_coordinate = false;
            continue;
        }
        const std::string name = key.as<std::string>();
        if( name == "x" ) {
            has_x = true;
        } else if( name == "y" ) {
            has_y = true;
        } else {
            throw std::runtime_error( std::string( description ) +
                                      " contains an unknown coordinate member" );
        }
    }

    sol::object x;
    sol::object y;
    if( named_coordinate ) {
        if( observed != 2 || !has_x || !has_y ) {
            throw std::runtime_error( std::string( description ) +
                                      " must contain exactly x and y" );
        }
        x = table.raw_get<sol::object>( "x" );
        y = table.raw_get<sol::object>( "y" );
    } else {
        require_dense_array( table, description, 2, 2 );
        x = table.raw_get<sol::object>( 1 );
        y = table.raw_get<sol::object>( 2 );
    }
    if( !x.is<lua_Integer>() || !y.is<lua_Integer>() ) {
        throw std::runtime_error( std::string( description ) +
                                  " coordinates must be native integers" );
    }
    const std::int64_t native_x = x.as<std::int64_t>();
    const std::int64_t native_y = y.as<std::int64_t>();
    if( !fits_native_int( native_x ) || !fits_native_int( native_y ) ) {
        throw std::runtime_error( std::string( description ) +
                                  " coordinate is outside the native integer range" );
    }
    return { native_x, native_y };
}

void add_or_replace_weighted_entry(
    std::vector<std::pair<std::string, std::int64_t>> &entries,
    const std::string &id,
    const std::int64_t weight )
{
    const auto existing = std::find_if( entries.begin(), entries.end(), [&id]( const auto & entry ) {
        return entry.first == id;
    } );
    if( existing != entries.end() ) {
        existing->second = weight;
    } else {
        entries.emplace_back( id, weight );
    }
}

void parse_weighted_table_entries(
    const sol::table &table,
    const std::string &label,
    std::vector<std::pair<std::string, std::int64_t>> &out_entries )
{
    const std::size_t count = require_dense_array( table, label.c_str(), 0, 1024 );
    for( std::size_t i = 1; i <= count; ++i ) {
        const sol::object elem = table.raw_get<sol::object>( i );
        std::string id;
        std::int64_t weight = 1;
        if( elem.is<std::string>() ) {
            id = elem.as<std::string>();
        } else if( elem.is<sol::table>() ) {
            const sol::table item = elem.as<sol::table>();
            if( require_dense_array( item, ( label + " entry" ).c_str(), 2, 2 ) != 2 ) {
                throw std::runtime_error( label + " entries must contain exactly an id and weight" );
            }
            const sol::object id_value = item.raw_get<sol::object>( 1 );
            const sol::object weight_value = item.raw_get<sol::object>( 2 );
            if( !id_value.is<std::string>() || !weight_value.is<lua_Integer>() ) {
                throw std::runtime_error( label + " entries must contain a string id and integer weight" );
            }
            id = id_value.as<std::string>();
            weight = weight_value.as<std::int64_t>();
        } else {
            throw std::runtime_error( label + " entries must be strings or { id, weight } arrays" );
        }
        if( id.empty() || weight <= 0 ) {
            throw std::runtime_error( label + " entries need a non-empty id and positive weight" );
        }
        add_or_replace_weighted_entry( out_entries, id, weight );
    }
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

struct scenario_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string start_name;
    std::int64_t points = 0;
    bool blacklist = false;
    bool extra_professions = false;
    bool reveal_locale = true;
    bool hard_requirement = false;
    // Legacy scenarios default to the 15-tile initial visibility radius.
    std::int64_t distance_initial_visibility = 15;
    std::vector<std::string> locations;
    std::vector<std::string> professions;
    std::vector<std::string> allowed_traits;
    std::vector<std::string> forced_traits;
    std::vector<std::string> forbidden_traits;
    std::vector<std::string> flags;
    std::string map_extra;
    std::string requirement;
    std::string start_handler;
    bool registered = false;
};

struct vehicle_color_palette_group_data {
    std::vector<std::string> fuzzy_ids;
    std::vector<std::pair<std::string, std::int64_t>> colors;
};

struct vehicle_color_palette_definition_data {
    std::string id;
    std::vector<vehicle_color_palette_group_data> groups;
    bool registered = false;
};

struct monster_group_entry_definition_data {
    std::string monster;
    std::string group;
    std::int64_t weight = 0;
    std::int64_t cost = 0;
    std::int64_t pack_minimum = 1;
    std::int64_t pack_maximum = 1;
};

struct monster_group_definition_data {
    std::string id;
    std::string default_monster;
    bool is_animal = false;
    std::vector<monster_group_entry_definition_data> entries;
    bool registered = false;
};

struct overmap_connection_subtype_definition_data {
    std::string terrain;
    std::int64_t basic_cost = 0;
    bool orthogonal = false;
    bool perpendicular_crossing = false;
    std::vector<std::string> locations;
};

struct overmap_connection_definition_data {
    std::string id;
    std::vector<overmap_connection_subtype_definition_data> subtypes;
    bool registered = false;
};

void validate_monster_group_entry( const std::string &id,
                                   std::int64_t weight, std::int64_t cost,
                                   std::int64_t pack_minimum, std::int64_t pack_maximum );

struct speed_description_value_data {
    double threshold = 0.0;
    std::vector<std::string> descriptions;
};

struct speed_description_definition_data {
    std::string id;
    std::vector<speed_description_value_data> values;
    bool registered = false;
};

struct harvest_drop_type_definition_data {
    std::string id;
    std::vector<std::string> skills;
    std::string field_dress_success;
    std::string field_dress_failure;
    std::string butcher_success;
    std::string butcher_failure;
    std::string dissect_success;
    std::string dissect_failure;
    bool item_group = false;
    bool dissect_only = false;
    bool registered = false;
};

struct harvest_entry_definition_data {
    std::string output;
    std::string category;
    double base_minimum = 1.0;
    double base_maximum = 1.0;
    double skill_minimum = 0.0;
    double skill_maximum = 0.0;
    std::int64_t maximum = 1000;
    double mass_ratio = 0.0;
    std::set<std::string> flags;
    std::set<std::string> faults;
};

struct harvest_definition_data {
    std::string id;
    std::string message;
    std::string leftovers = "ruined_chunks";
    std::string butchery_requirements = "default";
    std::vector<harvest_entry_definition_data> entries;
    bool registered = false;
};

struct behavior_condition_definition_data {
    std::string policy;
    std::string argument;
    bool native = false;
    bool inverted = false;
};

struct behavior_score_definition_data {
    std::string policy;
    std::string argument;
    bool native = false;
};

struct behavior_definition_data {
    std::string id;
    std::string strategy;
    std::string goal;
    std::vector<std::string> children;
    std::vector<behavior_condition_definition_data> conditions;
    std::optional<behavior_score_definition_data> score;
    bool registered = false;
};

struct effect_type_definition_data {
    std::string id;
    std::vector<std::string> names;
    std::vector<std::string> descriptions;
    std::vector<std::string> reduced_descriptions;
    std::string remove_message;
    std::string apply_memorial_log;
    std::string remove_memorial_log;
    std::string blood_analysis_description;
    std::int64_t maximum_intensity = 1;
    std::int64_t maximum_duration_turns = 31536000;
    std::int64_t intensity_duration_turns = 0;
    std::int64_t duration_add_percent = 100;
    std::int64_t intensity_add_value = 0;
    std::int64_t intensity_decay_step = -1;
    std::int64_t intensity_decay_tick = 0;
    bool intensity_decay_removes = false;
    bool main_parts_only = false;
    bool show_in_info = false;
    bool show_intensity = true;
    bool part_descriptions = false;
    std::set<std::string> flags;
    std::set<std::string> immune_character_flags;
    std::set<std::string> immune_bodypart_flags;
    std::set<std::string> resist_traits;
    std::set<std::string> resist_effects;
    std::set<std::string> removes_effects;
    std::set<std::string> blocks_effects;
    bool registered = false;
};

struct monster_attack_definition_data {
    std::string id;
    double cooldown = 1.0;
    std::string handler;
    bool registered = false;
};

struct weakpoint_effect_definition_data {
    std::string effect;
    double chance = 100.0;
    bool permanent = false;
    std::int64_t duration_min_turns = 0;
    std::int64_t duration_max_turns = 0;
    std::int64_t intensity_min = 1;
    std::int64_t intensity_max = 1;
    double damage_required_min = 0.0;
    double damage_required_max = 100.0;
    std::string message;
    std::string handler;
};

struct weakpoint_definition_data {
    std::string id;
    std::string name;
    double coverage = 100.0;
    bool good = true;
    bool head = false;
    std::map<std::string, double> armor_multipliers;
    std::map<std::string, double> armor_penalties;
    std::map<std::string, double> damage_multipliers;
    std::map<std::string, double> critical_multipliers;
    std::vector<weakpoint_effect_definition_data> effects;
};

struct weakpoint_set_definition_data {
    std::string id;
    std::vector<weakpoint_definition_data> weakpoints;
    bool registered = false;
};

struct field_effect_definition_data {
    std::string effect;
    std::int64_t duration_min_turns = 0;
    std::int64_t duration_max_turns = 0;
    std::int64_t intensity = 1;
    std::string body_part;
    bool environmental = true;
    std::string message;
    std::string npc_message;
};

struct field_intensity_definition_data {
    std::string name;
    std::string symbol = "%";
    std::string color = "white";
    bool dangerous = false;
    bool transparent = true;
    std::int64_t move_cost = 0;
    std::int64_t upgrade_chance = 0;
    std::int64_t upgrade_duration_turns = 0;
    double light_emitted = 0.0;
    double local_light_override = -1.0;
    double translucency = 0.0;
    std::int64_t concentration = 1;
    std::int64_t convection_temperature_modifier = 0;
    std::int64_t scent_neutralization = 0;
    std::vector<field_effect_definition_data> effects;
};

struct field_type_definition_data {
    std::string id;
    std::vector<field_intensity_definition_data> intensity_levels;
    std::int64_t underwater_age_speedup_turns = 0;
    std::int64_t outdoor_age_speedup_turns = 0;
    std::int64_t decay_amount_factor = 0;
    std::int64_t percent_spread = 0;
    std::int64_t gas_absorption_turns = 0;
    std::int64_t priority = 0;
    std::int64_t half_life_turns = 0;
    std::string phase = "null";
    std::string description_affix = "in";
    std::string wandering_field;
    std::string looks_like;
    bool splattering = false;
    bool has_fire = false;
    bool has_acid = false;
    bool has_electricity = false;
    bool has_fume = false;
    bool moppable = false;
    bool accelerated_decay = false;
    bool display_items = true;
    bool display_field = false;
    bool linear_half_life = false;
    bool indestructible = false;
    bool mopsafe = false;
    bool decrease_intensity_on_contact = false;
    std::set<std::string> immune_monsters;
    std::set<std::string> blocked_monsters;
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

struct sub_body_part_definition_data {
    std::string id;
    std::string name;
    std::string plural_name;
    std::string parent;
    std::string opposite;
    std::string side = "both";
    bool secondary = false;
    // Legacy sub body parts default to zero maximum coverage.
    std::int64_t maximum_coverage = 0;
    std::vector<std::string> locations_under;
    std::string similar_body_part;
    std::map<std::string, double> unarmed_damage;
    bool registered = false;
};

struct body_part_limb_score_definition_data {
    double score = 0.0;
    double maximum = 0.0;
};

struct body_part_quality_definition_data {
    std::string id;
    std::int64_t level = 1;
    double disable_fraction = 0.0;
};

struct body_part_definition_data {
    std::string id;
    std::string name;
    std::string plural_name;
    std::string accusative;
    std::string plural_accusative;
    std::string heading;
    std::string plural_heading;
    std::string encumbrance_text;
    std::string hp_bar_text;
    std::string main_part;
    std::string connected_to;
    std::string opposite;
    std::string side = "both";
    double hit_size = 1.0;
    double hit_difficulty = 1.0;
    std::int64_t base_health = 60;
    std::int64_t drench_capacity = 0;
    bool limb = true;
    bool vital = false;
    std::vector<std::string> sub_parts;
    std::map<std::string, double> limb_types;
    std::map<std::string, double> armor;
    std::map<std::string, double> unarmed_damage;
    std::set<std::string> flags;
    std::map<std::string, body_part_limb_score_definition_data> limb_scores;
    std::vector<body_part_quality_definition_data> qualities;
    bool registered = false;
};

struct wound_limb_score_definition_data {
    std::string id;
    double penalty = 0.0;
};

struct wound_progression_definition_data {
    std::string id;
    std::int64_t chance = 0;
};

struct wound_type_definition_data {
    std::string id;
    std::string name;
    std::string plural_name;
    std::string description;
    std::int64_t pain_min = 0;
    std::int64_t pain_max = 0;
    std::int64_t healing_min_turns = 1;
    std::int64_t healing_max_turns = 1;
    std::int64_t damage_min = 0;
    std::int64_t damage_max = 0;
    std::int64_t weight = 1;
    std::int64_t per_part_limit = 0;
    std::string required_body_part_flag;
    std::string forbidden_body_part_flag;
    std::vector<std::string> damage_types;
    std::vector<wound_limb_score_definition_data> limb_scores;
    std::vector<wound_progression_definition_data> progressions;
    std::vector<std::string> required_body_part_types;
    std::vector<std::string> forbidden_body_part_types;
    bool registered = false;
};

struct wound_fix_proficiency_definition_data {
    std::string id;
    double multiplier = 1.0;
    bool mandatory = false;
};

struct wound_fix_requirement_definition_data {
    std::string id;
    std::int64_t count = 1;
};

struct wound_fix_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string success_message;
    std::int64_t duration_turns = 0;
    std::int64_t health_delta = 0;
    std::map<std::string, std::int64_t> skills;
    std::vector<wound_fix_proficiency_definition_data> proficiencies;
    std::set<std::string> wounds_removed;
    std::set<std::string> wounds_added;
    std::vector<wound_fix_requirement_definition_data> requirements;
    bool registered = false;
};

struct anatomy_definition_data {
    std::string id;
    std::vector<std::string> parts;
    bool registered = false;
};

struct body_graph_part_definition_data {
    std::string symbol;
    std::vector<std::string> body_parts;
    std::vector<std::string> sub_body_parts;
    std::string nested_graph;
    std::string selected_color = "white";
    std::string display_symbol;
};

struct body_graph_definition_data {
    std::string id;
    std::string parent_body_part;
    std::string mirror;
    std::vector<std::string> rows;
    std::vector<std::string> fill_rows;
    std::vector<body_graph_part_definition_data> parts;
    std::string label_fill;
    std::string fill_symbol = " ";
    std::string fill_color = "white";
    bool registered = false;
};

struct monster_damage_definition_data {
    double amount = 0.0;
    double armor_penetration = 0.0;
};

struct monster_attack_reference_definition_data {
    std::string id;
    std::optional<double> cooldown;
};

struct monster_definition_data {
    std::string id;
    std::string name;
    std::string plural_name;
    std::string description;
    std::string symbol = "?";
    std::string color = "white";
    std::string looks_like;
    std::string body_type;
    std::string default_faction;
    std::string harvest = "human";
    std::string dissect;
    std::string decay;
    std::string speed_description = "DEFAULT";
    std::string death_drops;
    std::int64_t volume_ml = 62499;
    std::int64_t weight_grams = 81499;
    std::string phase = "solid";
    std::int64_t difficulty_adjustment = 0;
    std::int64_t hp = 1;
    std::int64_t speed = 100;
    std::int64_t aggression = 0;
    std::int64_t morale = 0;
    std::int64_t tracking_distance = 8;
    std::int64_t attack_cost = 100;
    std::int64_t melee_skill = 0;
    std::int64_t melee_dice = 0;
    std::int64_t melee_sides = 0;
    std::int64_t melee_armor_penetration = 0;
    std::int64_t dodge = 0;
    std::int64_t vision_day = 40;
    std::int64_t vision_night = 1;
    std::int64_t regenerates = 0;
    std::int64_t bleed_rate = 100;
    double status_chance_multiplier = 1.0;
    double luminance = 0.0;
    bool regenerates_in_dark = false;
    bool regenerates_morale = false;
    bool aggressive_to_characters = true;
    std::map<std::string, std::int64_t> materials;
    std::set<std::string> species;
    std::set<std::string> categories;
    std::set<std::string> flags;
    std::map<std::string, double> armor;
    std::map<std::string, monster_damage_definition_data> melee_damage;
    std::vector<monster_attack_reference_definition_data> attacks;
    std::map<std::string, std::string> attack_handlers;
    std::vector<std::string> weakpoint_sets;
    std::map<std::string, std::int64_t> emissions;
    std::map<std::string, std::int64_t> starting_ammo;
    std::set<std::string> tracked_scents;
    std::set<std::string> ignored_scents;
    std::map<std::string, std::int64_t> regeneration_modifiers;
    std::vector<std::string> goals;
    std::set<std::string> anger_triggers;
    std::set<std::string> fear_triggers;
    std::set<std::string> placate_triggers;
    std::string death_handler;
    bool registered = false;
};

class lua_platform_examine_actor final : public iexamine_actor
{
    public:
        lua_platform_examine_actor( std::string target_kind, std::string target_id,
                                    std::string owner, std::string handler,
                                    std::string label ) :
            iexamine_actor( "lua_platform" ), target_kind_( std::move( target_kind ) ),
            target_id_( std::move( target_id ) ), owner_( std::move( owner ) ),
            handler_( std::move( handler ) ) {
            name = no_translation( label.empty() ? "Examine" : label );
        }

        void load( const JsonObject &, const std::string & ) override {}

        void call( Character &character, const tripoint_bub_ms &position ) const override {
            invoke_examine_handler( target_kind_, target_id_, owner_, handler_,
                                    character, position );
        }

        void finalize() const override {}

        std::unique_ptr<iexamine_actor> clone() const override {
            return std::make_unique<lua_platform_examine_actor>( *this );
        }

    private:
        std::string target_kind_;
        std::string target_id_;
        std::string owner_;
        std::string handler_;
};

class lua_monster_attack_actor final : public mattack_actor
{
    public:
        lua_monster_attack_actor( std::string id_value, const double cooldown_value,
                                  std::string owner_value, std::string handler_value ) :
            mattack_actor( id_value ), owner_( std::move( owner_value ) ),
            handler_( std::move( handler_value ) ) {
            cooldown = cooldown_value;
            was_loaded = true;
        }

        bool call( monster &attacker ) const override {
            return invoke_monster_attack_handler(
                       owner_, id, handler_, attacker ).value_or( false );
        }

        std::unique_ptr<mattack_actor> clone() const override {
            return std::make_unique<lua_monster_attack_actor>( *this );
        }

        void load_internal( const JsonObject &, const std::string & ) override {}

    private:
        std::string owner_;
        std::string handler_;
};

class lua_monster_attack_result_actor final : public mattack_actor
{
    public:
        lua_monster_attack_result_actor(
            std::unique_ptr<mattack_actor> inner, std::string monster_type,
            std::string owner, std::string handler ) :
            mattack_actor( inner->id ), inner_( std::move( inner ) ),
            monster_type_( std::move( monster_type ) ),
            owner_( std::move( owner ) ), handler_( std::move( handler ) ) {
            cooldown = inner_->cooldown;
            was_loaded = true;
        }

        bool call( monster &attacker ) const override {
            Creature *target = attacker.attack_target();
            if( !inner_->call( attacker ) ) {
                return false;
            }
            invoke_monster_attack_result_handler(
                monster_type_, id, owner_, handler_, attacker, target, -1 );
            return true;
        }

        std::unique_ptr<mattack_actor> clone() const override {
            return std::make_unique<lua_monster_attack_result_actor>(
                       inner_->clone(), monster_type_, owner_, handler_ );
        }

        void load_internal( const JsonObject &, const std::string & ) override {}

    private:
        std::unique_ptr<mattack_actor> inner_;
        std::string monster_type_;
        std::string owner_;
        std::string handler_;
};

struct morale_type_definition_data {
    std::string id;
    std::string text;
    bool permanent = false;
    bool registered = false;
};

struct disease_type_definition_data {
    std::string id;
    std::string symptoms;
    std::int64_t minimum_duration_turns = 1;
    std::int64_t maximum_duration_turns = 1;
    std::int64_t minimum_intensity = 1;
    std::int64_t maximum_intensity = 1;
    std::optional<std::int64_t> health_threshold;
    std::set<std::string> affected_body_parts;
    bool registered = false;
};

struct monster_flag_definition_data {
    std::string id;
    bool registered = false;
};

struct species_definition_data {
    std::string id;
    std::string description;
    std::string footsteps = "footsteps.";
    std::string bleeds = "fd_null";
    std::set<std::string> flags;
    std::set<std::string> anger;
    std::set<std::string> fear;
    std::set<std::string> placate;
    bool registered = false;
};

struct emission_definition_data {
    std::string id;
    std::string field;
    std::int64_t intensity = 1;
    std::int64_t quantity = 1;
    std::int64_t chance = 100;
    std::string profile_handler;
    bool registered = false;
};

struct monster_faction_definition_data {
    std::string id;
    std::string base;
    std::map<std::string, std::string> attitudes;
    bool registered = false;
};

struct mutation_type_definition_data {
    std::string id;
    bool registered = false;
};

struct connect_group_definition_data {
    std::string id;
    bool registered = false;
};

struct mutation_category_definition_data {
    std::string id;
    std::string name;
    std::string threshold_mutation;
    std::string mutagen_message;
    std::string memorial_message = "Crossed a threshold";
    std::string vitamin = "null";
    std::int64_t threshold_minimum = 2200;
    std::int64_t base_removal_chance = 100;
    double base_removal_cost_multiplier = 3.0;
    bool work_in_progress = false;
    bool skip_consistency_test = false;
    bool registered = false;
};

struct construction_category_definition_data {
    std::string id;
    std::string name;
    bool registered = false;
};

struct construction_group_definition_data {
    std::string id;
    std::string name;
    bool registered = false;
};

struct vehicle_part_location_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::int64_t z_order = 0;
    std::int64_t list_order = 5;
    bool registered = false;
};

struct mood_face_value_definition_data {
    std::int64_t score = 0;
    std::string face;
};

struct mood_face_definition_data {
    std::string id;
    std::vector<mood_face_value_definition_data> values;
    bool registered = false;
};

struct damage_info_order_section_definition_data {
    std::string section;
    std::int64_t order = -1;
    bool show_type = true;
};

struct damage_info_order_definition_data {
    std::string id;
    std::string display = "detailed";
    std::string verb;
    std::vector<damage_info_order_section_definition_data> sections;
    bool registered = false;
};

struct vehicle_part_category_definition_data {
    std::string id;
    std::string name;
    std::string short_name;
    std::int64_t priority = 0;
    bool registered = false;
};

struct named_color_definition_data {
    std::string id;
    std::string name;
    std::int64_t red = 0;
    std::int64_t green = 0;
    std::int64_t blue = 0;
    std::int64_t alpha = 255;
    bool registered = false;
};

struct rotatable_symbol_definition_data {
    std::string id;
    std::string key;
    std::vector<std::uint32_t> symbols;
    bool registered = false;
};

struct ascii_art_definition_data {
    std::string id;
    std::vector<std::string> lines;
    bool registered = false;
};

struct limb_score_definition_data {
    std::string id;
    std::string name;
    bool affected_by_wounds = true;
    bool affected_by_encumbrance = true;
    bool registered = false;
};

struct hit_range_definition_data {
    std::string id = "global";
    std::vector<std::int64_t> even_good;
    bool registered = false;
};

struct bash_damage_profile_definition_data {
    std::string id;
    std::map<std::string, double> factors;
    bool registered = false;
};

struct clothing_modifier_definition_data {
    std::string stat;
    double amount = 0.0;
    bool round_up = false;
    bool per_thickness = false;
    bool per_coverage = false;
};

struct clothing_mod_definition_data {
    std::string id;
    std::string flag;
    std::string material_item;
    std::string apply_prompt;
    std::string remove_prompt;
    bool restricted = false;
    std::vector<clothing_modifier_definition_data> modifiers;
    bool registered = false;
};

struct overmap_land_use_code_definition_data {
    std::string id;
    std::int64_t code = 0;
    std::string name;
    std::string description;
    std::uint32_t symbol = 0;
    std::string color = "black";
    bool registered = false;
};

struct overmap_vision_level_definition_data {
    std::string name;
    std::uint32_t symbol = 0;
    std::string color = "black";
    std::string looks_like;
    bool blends_adjacent = false;
};

struct overmap_vision_definition_data {
    std::string id;
    std::vector<overmap_vision_level_definition_data> levels;
    bool registered = false;
};

struct overmap_location_definition_data {
    std::string id;
    std::vector<std::string> terrains;
    std::vector<std::string> terrain_flags;
    bool registered = false;
};

struct profession_addiction_definition_data {
    std::string type;
    std::int64_t intensity = 1;
};

struct profession_trait_definition_data {
    std::string trait;
    std::string variant;
};

struct profession_definition_data {
    std::string id;
    std::string name_male;
    std::string name_female;
    std::string description_male;
    std::string description_female;
    std::int64_t points = 0;
    std::optional<std::int64_t> starting_cash;
    std::string npc_background = "BG_survival_story_UNIVERSAL";
    bool chargen_allow_npc = true;
    std::int64_t age_lower = profession::DEFAULT_PROF_AGE_LOWER;
    std::int64_t age_upper = profession::DEFAULT_PROF_AGE_UPPER;
    std::string starting_vehicle;
    std::string items_both = "EMPTY_GROUP";
    std::string items_male = "EMPTY_GROUP";
    std::string items_female = "EMPTY_GROUP";
    std::string no_bonus;
    std::vector<std::string> requirements;
    bool hard_requirement = false;
    std::vector<std::pair<std::string, std::int64_t>> skills;
    std::vector<profession_addiction_definition_data> addictions;
    std::vector<std::string> cbms;
    std::vector<std::string> proficiencies;
    std::vector<std::string> recipes;
    std::vector<profession_trait_definition_data> traits;
    std::vector<std::string> forbidden_traits;
    std::vector<std::string> flags;
    std::vector<std::string> hobbies;
    bool hobbies_whitelist = true;
    std::vector<std::string> martial_arts;
    std::vector<std::string> martial_arts_choices;
    std::int64_t martial_arts_choice_amount = 1;
    std::vector<std::pair<std::string, std::int64_t>> pets;
    std::vector<std::pair<std::string, std::int64_t>> spells;
    std::vector<std::string> missions;
    std::string subtype;
    std::string start_handler;
    bool registered = false;
};

struct profession_group_definition_data {
    std::string id;
    std::vector<std::string> professions;
    bool registered = false;
};

struct widget_clause_definition_data {
    std::string id;
    std::string symbol;
    std::string text;
    std::string color;
    std::int64_t value = std::numeric_limits<int>::min();
    std::vector<std::string> widgets;
    std::string condition_handler;
    bool parse_tags = false;
};

struct widget_definition_data {
    std::string id;
    std::int64_t width = 0;
    std::int64_t height = 1;
    std::string symbols = "-";
    std::string fill = "bucket";
    std::string label;
    std::string description;
    std::string style = "number";
    std::string arrange = "columns";
    std::string body_graph = "full_body_widget";
    std::string direction;
    std::string text_align = "left";
    std::string label_align = "left";
    std::optional<bool> pad_labels;
    std::optional<std::string> separator;
    std::optional<std::int64_t> padding;
    std::string variable;
    std::string custom_handler;
    std::vector<std::string> bodyparts;
    std::vector<std::string> colors;
    std::vector<std::int64_t> breaks;
    std::vector<widget_clause_definition_data> clauses;
    std::optional<widget_clause_definition_data> default_clause;
    std::string text;
    std::vector<std::string> widgets;
    std::vector<std::string> flags;
    bool registered = false;
};

struct enchantment_modifier_definition_data {
    std::string kind;
    std::string target;
    std::string part;
    std::optional<double> add;
    std::optional<double> multiply;
    std::string add_handler;
    std::string multiply_handler;
};

struct enchantment_fake_spell_definition_data {
    std::string spell;
    std::optional<std::int64_t> max_level;
    std::int64_t level = 0;
    bool self = false;
    std::int64_t trigger_once_in = 1;
    std::string trigger_message;
    std::string npc_trigger_message;
};

struct enchantment_vision_description_definition_data {
    std::string id = "infrared_creature";
    std::string color = "red";
    std::string symbol = "?";
    std::string text;
    std::string condition_handler;
};

struct enchantment_vision_definition_data {
    double distance = 0.0;
    std::string distance_handler;
    std::string condition_handler;
    bool precise = false;
    bool ignores_aiming_cone = false;
    std::vector<enchantment_vision_description_definition_data> descriptions;
};

struct enchantment_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string has = "HELD";
    std::string condition = "ALWAYS";
    std::string condition_handler;
    std::string emitter;
    std::vector<std::pair<std::string, std::int64_t>> effects;
    std::vector<std::pair<std::string, std::string>> modified_bodyparts;
    std::vector<std::string> mutations;
    std::vector<enchantment_modifier_definition_data> modifiers;
    std::vector<enchantment_fake_spell_definition_data> hit_you_effects;
    std::vector<enchantment_fake_spell_definition_data> hit_me_effects;
    std::vector<std::pair<std::int64_t, enchantment_fake_spell_definition_data>>
    intermittent_effects;
    std::vector<enchantment_vision_definition_data> visions;
    bool registered = false;
};

struct bionic_protection_definition_data {
    std::string bodypart;
    std::string damage_type;
    double amount = 0.0;
};

struct bionic_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::optional<std::string> cant_remove_reason;
    std::int64_t activation_energy_millijoules = 0;
    std::int64_t deactivation_energy_millijoules = 0;
    std::int64_t over_time_energy_millijoules = 0;
    std::int64_t trigger_energy_millijoules = 0;
    std::int64_t capacity_energy_millijoules = 0;
    std::int64_t charge_time_turns = 0;
    std::optional<enchantment_fake_spell_definition_data> activation_spell;
    std::string power_gen_emission;
    std::string fake_weapon;
    std::string upgraded_bionic;
    std::string required_bionic;
    std::string installation_requirement;
    std::vector<std::string> fuel_options;
    std::vector<std::string> enchantments;
    std::vector<std::string> martial_arts;
    std::vector<std::string> proficiencies;
    std::vector<std::string> passive_pseudo_items;
    std::vector<std::string> toggled_pseudo_items;
    std::vector<std::string> canceled_mutations;
    std::vector<std::string> included_bionics;
    std::vector<std::string> auto_deactivated_bionics;
    std::vector<std::string> flags;
    std::vector<std::string> active_flags;
    std::vector<std::string> inactive_flags;
    std::vector<std::pair<std::string, std::int64_t>> environment_protection;
    std::vector<bionic_protection_definition_data> protection;
    std::vector<std::pair<std::string, std::int64_t>> occupied_bodyparts;
    std::vector<std::pair<std::string, std::int64_t>> encumbrance;
    std::vector<std::string> installable_weapon_flags;
    std::vector<std::string> replaced_bodyparts;
    std::vector<std::string> mutation_conflicts;
    std::vector<std::string> give_mutation_on_removal;
    std::vector<std::pair<std::string, std::int64_t>> learned_spells;
    std::vector<std::string> available_upgrades;
    double fuel_efficiency = 0.0;
    double passive_fuel_efficiency = 0.0;
    std::optional<double> coverage_power_gen_penalty;
    std::int64_t social_lie = 0;
    std::int64_t social_persuade = 0;
    std::int64_t social_intimidate = 0;
    bool dupes_allowed = false;
    bool activated_on_install = false;
    bool included = false;
    bool activate_remove_cbm = false;
    bool is_remote_fueled = false;
    bool exothermic_power_gen = false;
    bool activated_close_ui = false;
    bool deactivated_close_ui = false;
    bool registered = false;
};

struct spell_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string message = "You cast %s!";
    std::string skill = "spellcraft";
    std::string magic_type;
    std::string components;
    std::string sound_description = "an explosion.";
    std::string sound_type = "combat";
    bool sound_ambient = false;
    std::string sound_id;
    std::string sound_variant = "default";
    std::string effect = "none";
    std::string effect_handler;
    std::string shape = "line";
    std::string effect_data;
    std::string explosion_light;
    std::string field;
    std::string spell_class = "NONE";
    std::string energy_source;
    std::string energy_vitamin;
    std::string energy_color = "cyan";
    std::string damage_type;
    std::string get_level_formula;
    std::string exp_for_level_formula;
    std::optional<std::int64_t> max_book_level;
    std::string caster_condition_handler;
    std::string caster_condition_fail_message;
    std::string target_condition_handler;
    std::string target_condition_fail_message;
    std::vector<std::string> valid_targets;
    std::vector<std::string> flags;
    std::vector<std::string> targeted_monsters;
    std::vector<std::string> targeted_species;
    std::vector<std::string> ignored_species;
    std::vector<std::string> affected_bodyparts;
    std::vector<enchantment_fake_spell_definition_data> additional_spells;
    std::vector<std::pair<std::string, std::int64_t>> learned_spells;
    std::int64_t channel_turns = 0;
    std::string channel_spell;
    std::string channel_end_spell;
    std::string channel_interrupt_spell;
    bool channel_uses_energy = true;
    bool teachable = true;
    std::map<std::string, double> stats = {
        { "field_chance", 1.0 },
        { "min_field_intensity", 0.0 },
        { "field_intensity_increment", 0.0 },
        { "max_field_intensity", 0.0 },
        { "field_intensity_variance", 0.0 },
        { "min_accuracy", 20.0 },
        { "accuracy_increment", 0.0 },
        { "max_accuracy", 20.0 },
        { "min_damage", 0.0 },
        { "damage_increment", 0.0 },
        { "max_damage", 0.0 },
        { "min_range", 0.0 },
        { "range_increment", 0.0 },
        { "max_range", 0.0 },
        { "min_aoe", 0.0 },
        { "aoe_increment", 0.0 },
        { "max_aoe", 0.0 },
        { "min_dot", 0.0 },
        { "dot_increment", 0.0 },
        { "max_dot", 0.0 },
        { "min_duration", 0.0 },
        { "duration_increment", 0.0 },
        { "max_duration", 0.0 },
        { "min_pierce", 0.0 },
        { "pierce_increment", 0.0 },
        { "max_pierce", 0.0 },
        { "min_bash_scaling", 0.0 },
        { "bash_scaling_increment", 0.0 },
        { "max_bash_scaling", 0.0 },
        { "base_energy_cost", 0.0 },
        { "energy_increment", 0.0 },
        { "final_energy_cost", 0.0 },
        { "difficulty", 0.0 },
        { "multiple_projectiles", 0.0 },
        { "max_level", 0.0 },
        { "base_casting_time", 0.0 },
        { "casting_time_increment", 0.0 },
        { "final_casting_time", 0.0 }
    };
    std::map<std::string, double> stat_maximums;
    std::map<std::string, std::string> stat_handlers;
    bool registered = false;
};

struct mission_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string goal = "MGOAL_NULL";
    std::int64_t difficulty = 0;
    std::int64_t value = 0;
    std::int64_t deadline_min_turns = 0;
    std::optional<std::int64_t> deadline_max_turns;
    std::string deadline_handler;
    bool urgent = false;
    bool has_generic_rewards = true;
    std::vector<std::string> origins;
    std::string item;
    std::string item_group;
    std::string required_container;
    std::string empty_container;
    std::int64_t item_count = 1;
    bool remove_container = false;
    bool invisible_on_complete = false;
    std::string recruit_class;
    std::string monster_type;
    std::string monster_species;
    std::int64_t monster_kill_goal = -1;
    std::string destination;
    std::string followup;
    std::string place = "always";
    std::string place_handler;
    std::string start_handler;
    std::string end_handler;
    std::string fail_handler;
    std::string goal_condition_handler;
    std::map<std::string, std::string> dialogue;
    std::vector<std::pair<double, std::string>> likely_rewards;
    bool registered = false;
};

struct mutation_variant_definition_data {
    std::string id;
    std::string name;
    std::string description;
    bool append_description = false;
    std::int64_t weight = 0;
};

struct mutation_transform_definition_data {
    std::string target;
    std::string message;
    bool active = false;
    bool safe = false;
    std::int64_t moves = 0;
};

struct mutation_personality_definition_data {
    std::int64_t min_aggression = NPC_PERSONALITY_MIN;
    std::int64_t max_aggression = NPC_PERSONALITY_MAX;
    std::int64_t min_bravery = NPC_PERSONALITY_MIN;
    std::int64_t max_bravery = NPC_PERSONALITY_MAX;
    std::int64_t min_collector = NPC_PERSONALITY_MIN;
    std::int64_t max_collector = NPC_PERSONALITY_MAX;
    std::int64_t min_altruism = NPC_PERSONALITY_MIN;
    std::int64_t max_altruism = NPC_PERSONALITY_MAX;
};

struct mutation_wet_protection_definition_data {
    std::string bodypart;
    std::int64_t ignored = 0;
    std::int64_t neutral = 0;
    std::int64_t good = 0;
};

struct mutation_armor_definition_data {
    std::string bodypart;
    std::string damage_type;
    double amount = 0.0;
};

struct mutation_damage_definition_data {
    std::string damage_type;
    double amount = 0.0;
    double armor_penetration = 0.0;
    double armor_penetration_multiplier = 1.0;
    double damage_multiplier = 1.0;
    double unconditional_armor_penetration_multiplier = 1.0;
    double unconditional_damage_multiplier = 1.0;
};

struct mutation_attack_definition_data {
    std::string player_message;
    std::string npc_message;
    std::vector<std::string> required_mutations;
    std::vector<std::string> blocker_mutations;
    std::string bodypart;
    std::int64_t chance = 0;
    bool hardcoded = false;
    std::vector<mutation_damage_definition_data> base_damage;
    std::vector<mutation_damage_definition_data> strength_damage;
};

struct mutation_reflex_definition_data {
    std::string handler;
    std::string message_on;
    std::string message_on_type = "neutral";
    std::string message_off;
    std::string message_off_type = "neutral";
};

struct mutation_comfort_condition_definition_data {
    std::string type;
    std::string id;
    std::string flag;
    std::int64_t intensity = 1;
    bool active = false;
    bool invert = false;
};

struct mutation_comfort_definition_data {
    std::vector<mutation_comfort_condition_definition_data> conditions;
    bool conditions_or = false;
    std::int64_t base_comfort = comfort_data::COMFORT_NEUTRAL;
    bool add_human_comfort = false;
    bool use_better_comfort = false;
    bool add_sleep_aids = false;
    std::string try_message;
    std::string try_message_type = "neutral";
    std::string hint_message;
    std::string hint_message_type = "neutral";
    std::string sleep_message;
    std::string sleep_message_type = "neutral";
};

struct mutation_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::int64_t points = 0;
    std::int64_t vitamin_cost = 100;
    std::int64_t visibility = 0;
    std::int64_t ugliness = 0;
    std::int64_t activation_cost = 0;
    std::int64_t cooldown_turns = 0;
    std::int64_t bodytemp_min = 0;
    std::int64_t bodytemp_max = 0;
    std::optional<std::int64_t> scent_intensity;
    std::int64_t social_lie = 0;
    std::int64_t social_persuade = 0;
    std::int64_t social_intimidate = 0;
    bool starting_trait = false;
    bool chargen_allow_npc = true;
    bool random_start_allowed = true;
    bool mixed_effect = false;
    bool active = false;
    bool starts_active = false;
    bool destroys_gear = false;
    bool allow_soft_gear = false;
    bool consumes_kcal = false;
    bool consumes_thirst = false;
    bool consumes_sleepiness = false;
    bool consumes_mana = false;
    bool consumes_stamina = false;
    bool valid = true;
    bool purifiable = true;
    bool threshold = false;
    bool strict_threshold_requirement = false;
    bool profession = false;
    bool debug = false;
    bool player_display = true;
    bool vanity = false;
    bool dummy = false;
    std::optional<bool> hide_on_activated;
    std::optional<bool> hide_on_deactivated;
    std::optional<mutation_transform_definition_data> transform;
    std::optional<mutation_personality_definition_data> personality;
    std::string activation_message;
    std::string scent_type;
    std::string spawn_item;
    std::string spawn_item_message;
    std::string ranged_mutation;
    std::string ranged_mutation_message;
    std::string override_look_id;
    std::string override_look_category;
    std::vector<mutation_variant_definition_data> variants;
    std::vector<std::string> initial_martial_arts;
    std::vector<std::string> threshold_substitutes;
    std::vector<std::pair<std::string, std::int64_t>> vitamin_rates;
    std::vector<std::tuple<std::string, std::string, double>> vitamin_absorption;
    std::vector<std::pair<std::string, std::int64_t>> provided_qualities;
    std::vector<std::string> ignored_by;
    std::vector<std::string> empathize_with;
    std::vector<std::string> no_empathize_with;
    std::vector<std::string> can_only_eat;
    std::vector<std::string> can_only_heal_with;
    std::vector<std::string> can_heal_with;
    std::vector<std::string> allowed_categories;
    std::vector<std::string> prereqs;
    std::vector<std::string> prereqs2;
    std::vector<std::string> threshold_requirements;
    std::vector<std::string> cancels;
    std::vector<std::string> replacements;
    std::vector<std::string> additions;
    std::vector<std::string> flags;
    std::vector<std::string> active_flags;
    std::vector<std::string> inactive_flags;
    std::vector<std::string> types;
    std::vector<std::pair<std::string, std::int64_t>> monster_cameras;
    std::vector<std::string> enchantments;
    std::vector<std::string> no_cbm_bodyparts;
    std::vector<std::string> categories;
    std::vector<std::pair<std::string, std::int64_t>> learned_spells;
    std::vector<std::pair<std::string, std::int64_t>> craft_skill_bonuses;
    std::vector<std::pair<std::string, double>> lumination;
    std::vector<std::pair<std::string, std::int64_t>> anger_relations;
    std::vector<mutation_wet_protection_definition_data> wet_protection;
    std::vector<std::pair<std::string, std::int64_t>> encumbrance_always;
    std::vector<std::pair<std::string, std::int64_t>> encumbrance_covered;
    std::vector<std::pair<std::string, double>> encumbrance_multipliers;
    std::vector<std::string> restricts_gear;
    std::vector<std::string> remove_rigid;
    std::vector<std::string> allowed_item_flags;
    std::vector<mutation_armor_definition_data> armor;
    std::vector<std::string> integrated_armor;
    std::vector<std::pair<std::string, std::int64_t>> bionic_slot_bonuses;
    std::vector<mutation_attack_definition_data> attacks;
    std::vector<std::vector<mutation_reflex_definition_data>> reflex_triggers;
    std::vector<mutation_comfort_definition_data> comfort;
    bool registered = false;
};

struct profession_item_substitution_definition_data {
    std::string id;
    std::vector<detail::profession_item_substitution_native_rule> rules;
    bool registered = false;
};

struct profession_item_bonus_definition_data {
    std::string id;
    std::vector<detail::profession_item_substitution_native_requirement> requirements;
    bool registered = false;
};

struct map_extra_collection_definition_data {
    std::string id;
    std::int64_t chance = 0;
    std::vector<std::pair<std::string, std::int64_t>> entries;
    bool registered = false;
};

struct vehicle_group_definition_data {
    std::string id;
    std::vector<std::pair<std::string, std::int64_t>> entries;
    bool registered = false;
};

struct vehicle_placement_location_definition_data {
    std::int64_t x_min = 0;
    std::int64_t x_max = 0;
    std::int64_t y_min = 0;
    std::int64_t y_max = 0;
    std::vector<std::int64_t> facings;
};

struct vehicle_placement_definition_data {
    std::string id;
    std::vector<vehicle_placement_location_definition_data> locations;
    bool registered = false;
};

struct vehicle_spawn_entry_definition_data {
    bool builtin = false;
    double weight = 0.0;
    std::string builtin_id;
    std::string vehicle_group;
    std::int64_t number_min = 1;
    std::int64_t number_max = 1;
    std::int64_t fuel = -1;
    std::int64_t status = -1;
    std::string placement;
    std::optional<vehicle_placement_location_definition_data> location;
};

struct vehicle_spawn_definition_data {
    std::string id;
    std::vector<vehicle_spawn_entry_definition_data> entries;
    bool registered = false;
};

struct fault_group_definition_data {
    std::string id;
    std::vector<std::pair<std::string, std::int64_t>> entries;
    bool registered = false;
};

struct explosion_light_definition_data {
    std::string id;
    std::vector<light_stop> stops;
    std::string easing = "linear";
    double wave_travel = 0.38;
    double wave_gap = 0.25;
    double rise = 0.05;
    double fade = 0.1;
    double blend = 0.05;
    double spread_jitter = 0.07;
    double color_jitter = 0.05;
    double flicker = 0.18;
    double duration_base_ms = 120.0;
    double duration_per_tile_ms = 45.0;
    double duration_min_ms = 150.0;
    double duration_max_ms = 900.0;
    double screen_shake_magnitude = 0.0;
    double screen_shake_duration_ms = 0.0;
    bool shockwave = false;
    double shockwave_strength = 0.0;
    double shockwave_speed = 1.0;
    double shockwave_thickness = 1.5;
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

struct addiction_type_definition_data {
    std::string id;
    std::string name;
    std::string type_name;
    std::string description;
    std::string craving_morale;
    std::string tick_handler;
    bool registered = false;
};

struct character_modifier_definition_data {
    std::string id;
    std::string description;
    std::string operation = "multiply";
    std::string evaluator_handler;
    bool registered = false;
};

struct start_location_target_definition_data {
    std::string terrain;
    std::string match = "type";
    std::unordered_map<std::string, std::string> parameters;
};

struct start_location_definition_data {
    std::string id;
    std::string name;
    std::vector<start_location_target_definition_data> targets;
    std::set<std::string> flags;
    std::int64_t city_size_min = 0;
    std::int64_t city_size_max = std::numeric_limits<int>::max();
    std::int64_t city_distance_min = 0;
    std::int64_t city_distance_max = std::numeric_limits<int>::max();
    std::int64_t z_min = -OVERMAP_DEPTH;
    std::int64_t z_max = OVERMAP_HEIGHT;
    bool registered = false;
};

struct climbing_aid_definition_data {
    std::string id;
    std::int64_t slip_chance_modifier = 0;
    std::string category;
    std::string flag;
    std::int64_t uses = 0;
    std::int64_t range = 1;
    std::int64_t max_height = 1;
    std::int64_t easy_climb_back_up = 0;
    bool allow_remaining_height = true;
    std::string menu_text;
    std::string unavailable_text;
    std::string hotkey;
    std::string confirm_text;
    std::string before_message;
    std::string after_message;
    std::int64_t pain = 0;
    std::int64_t damage = 0;
    std::int64_t kilocalories = 0;
    std::int64_t thirst = 0;
    std::string deploy_furniture;
    bool registered = false;
};

struct weather_passive_effect_definition_data {
    std::string effect;
    std::int64_t minimum_duration_turns = 1;
    std::int64_t maximum_duration_turns = 1;
    std::int64_t intensity = 1;
    std::string body_part;
    bool environmental = true;
    bool immune_in_vehicle = false;
    bool immune_inside_vehicle = false;
    bool immune_outside_vehicle = false;
    std::int64_t chance_in_vehicle = 0;
    std::int64_t chance_inside_vehicle = 0;
    std::int64_t chance_outside_vehicle = 0;
    std::string message;
    std::string npc_message;
};

struct weather_type_definition_data {
    std::string id;
    std::string name;
    std::string color = "white";
    std::string map_color = "white";
    std::string symbol = "%";
    std::string sun_symbol = "☼";
    std::int64_t ranged_penalty = 0;
    double sight_penalty = 1.0;
    std::int64_t light_modifier = 0;
    double temperature_delta_kelvin = 0.0;
    double light_multiplier = 1.0;
    double sun_multiplier = 1.0;
    std::int64_t sound_attenuation = 0;
    bool dangerous = false;
    std::string precipitation = "none";
    bool rains = false;
    std::string tiles_animation;
    std::string sound_category = "silent";
    std::int64_t priority = 0;
    std::int64_t minimum_duration_turns = 300;
    std::int64_t maximum_duration_turns = 300;
    bool has_animation = false;
    double animation_factor = 0.0;
    std::string animation_color = "white";
    std::string animation_symbol;
    std::vector<std::string> required_weathers;
    std::vector<weather_passive_effect_definition_data> passive_effects;
    std::string condition_handler;
    bool registered = false;
};

struct event_transformation_definition_data :
    detail::event_transformation_native_definition {
    bool registered = false;
};

struct event_statistic_definition_data : detail::event_statistic_native_definition {
    bool registered = false;
};

struct relic_procgen_passive_definition_data {
    std::string kind;
    std::string type;
    std::int64_t weight = 0;
    std::int64_t power_per_increment = 1;
    double increment = 1.0;
    double minimum = 0.0;
    double maximum = 0.0;
    std::string has = "HELD";
};

struct relic_procgen_active_definition_data {
    std::string kind = "active_enchantment";
    std::string spell;
    std::int64_t weight = 0;
    std::int64_t base_power = 0;
    std::int64_t power_per_increment = 1;
    std::int64_t increment = 1;
    std::int64_t minimum_level = 0;
    std::int64_t maximum_level = 0;
    std::string has = "HELD";
};

struct relic_procgen_charge_definition_data {
    std::int64_t weight = 0;
    std::int64_t initial_minimum = 0;
    std::int64_t initial_maximum = 0;
    std::int64_t use_minimum = 0;
    std::int64_t use_maximum = 0;
    std::int64_t maximum_minimum = 0;
    std::int64_t maximum_maximum = 0;
    std::int64_t time_minimum_turns = 0;
    std::int64_t time_maximum_turns = 0;
    std::int64_t power = 0;
    std::string recharge_type = "none";
};

struct relic_procgen_definition_data {
    std::string id;
    std::vector<relic_procgen_passive_definition_data> passive_values;
    std::vector<relic_procgen_active_definition_data> active_values;
    std::vector<std::pair<std::string, std::int64_t>> type_weights;
    std::vector<std::pair<std::string, std::int64_t>> item_weights;
    std::vector<relic_procgen_charge_definition_data> charges;
    bool registered = false;
};

struct score_definition_data {
    std::string id;
    std::string statistic;
    std::string description;
    bool registered = false;
};

struct overlay_order_definition_data {
    std::string id = "global";
    std::map<std::string, std::int64_t> orders;
    bool registered = false;
};

struct zone_type_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string display_field;
    bool can_be_personal = false;
    bool hidden = false;
    bool registered = false;
};

struct speech_pool_definition_data {
    std::string id;
    std::vector<std::pair<std::string, std::int64_t>> lines;
    bool registered = false;
};

struct end_screen_definition_data {
    std::string id;
    std::string picture;
    std::int64_t priority = 0;
    std::vector<std::tuple<std::int64_t, std::int64_t, std::string>> information;
    std::string last_words_label;
    std::string condition_handler;
    bool registered = false;
};

struct activity_type_definition_data {
    std::string id;
    std::string verb;
    bool rooted = false;
    bool interruptable = true;
    bool interruptable_with_keyboard = true;
    std::string based_on = "speed";
    bool can_resume = true;
    bool multi_activity = false;
    bool fetch_items_to_zone = true;
    bool refuel_fires = false;
    bool auto_needs = false;
    double activity_level = NO_EXERCISE;
    std::set<std::string> ignored_distractions;
    std::string do_turn_handler;
    std::string completion_handler;
    bool registered = false;
};

struct help_topic_definition_data {
    std::string id;
    std::string title;
    std::optional<std::int64_t> order;
    std::vector<std::string> paragraphs;
    bool registered = false;
};

struct snippet_entry_definition_data {
    std::string id;
    std::string text;
    std::string name;
    std::int64_t weight = 1;
    std::string examine_handler;
};

struct snippet_category_definition_data {
    std::string id;
    std::vector<snippet_entry_definition_data> entries;
    bool registered = false;
};

struct playlist_definition_data {
    std::string id;
    bool shuffle = false;
    std::vector<std::pair<std::string, std::int64_t>> tracks;
    bool registered = false;
};

struct sound_effect_definition_data {
    std::string id;
    std::string variant = "default";
    std::string season;
    std::optional<bool> indoors;
    std::optional<bool> night;
    std::int64_t volume = 100;
    std::vector<std::string> files;
    bool registered = false;
};

struct technique_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string avatar_message;
    std::string npc_message;
    bool crit_tec = false;
    bool crit_ok = false;
    bool wall_adjacent = false;
    bool reach_tec = false;
    bool reach_ok = false;
    bool needs_ammo = false;
    bool defensive = false;
    bool disarms = false;
    bool take_weapon = false;
    bool side_switch = false;
    bool dummy = false;
    bool dodge_counter = false;
    bool block_counter = false;
    bool miss_recovery = false;
    bool grab_break = false;
    std::int64_t weighting = 1;
    std::int64_t repeat_min = 1;
    std::int64_t repeat_max = 1;
    std::int64_t down_dur = 0;
    std::int64_t stun_dur = 0;
    std::int64_t knockback_dist = 0;
    double knockback_spread = 0.0;
    bool knockback_follow = false;
    std::string aoe;
    std::set<std::string> flags;
    std::vector<std::string> attack_vectors;
    bool unarmed_allowed = false;
    bool melee_allowed = false;
    bool strictly_unarmed = false;
    std::vector<std::pair<std::string, std::int64_t>> min_skills;
    std::string apply_handler;
    bool registered = false;
};

struct martial_art_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string initiate_avatar;
    std::string initiate_npc;
    std::int64_t priority = 0;
    std::string primary_skill;
    std::int64_t learn_difficulty = 0;
    bool teachable = true;
    std::int64_t arm_block = 0;
    std::int64_t leg_block = 0;
    bool arm_block_with_bio_armor_arms = false;
    bool leg_block_with_bio_armor_legs = false;
    bool strictly_unarmed = false;
    bool strictly_melee = false;
    bool allow_all_weapons = false;
    bool force_unarmed = false;
    bool prevent_weapon_blocking = false;
    std::vector<std::pair<std::string, std::int64_t>> autolearn_skills;
    std::vector<std::string> techniques;
    std::vector<std::string> weapons;
    std::vector<std::string> weapon_categories;
    std::map<std::string, std::string> handlers;
    bool registered = false;
};

struct trap_definition_data {
    std::string id;
    std::string name;
    std::string color;
    std::string symbol;
    std::int64_t visibility = 1;
    std::int64_t avoidance = 0;
    std::int64_t difficulty = 0;
    std::string action;
    std::string memorial_male;
    std::string memorial_female;
    std::string trigger_message_u;
    std::string trigger_message_npc;
    std::set<std::string> flags;
    std::int64_t trap_radius = 0;
    bool benign = false;
    bool always_invisible = false;
    std::int64_t funnel_radius = 0;
    std::int64_t comfort = 0;
    std::int64_t trigger_weight_grams = 500;
    std::int64_t sound_threshold_min = 0;
    std::int64_t sound_threshold_max = 0;
    std::vector<std::tuple<std::string, std::int64_t, std::int64_t>> drops;
    std::string trigger_handler;
    bool registered = false;
};

struct construction_definition_data {
    std::string id;
    std::string group;
    std::string category;
    std::string pre_note;
    std::string post_terrain;
    std::int64_t time_moves = 0;
    double activity_level = 1.0;
    std::vector<std::pair<std::string, std::int64_t>> required_skills;
    std::vector<std::pair<std::string, std::int64_t>> reqs_using;
    std::vector<std::string> pre_terrain;
    std::vector<std::pair<std::string, bool>> pre_flags;
    std::vector<std::string> post_flags;
    bool registered = false;
};

struct furniture_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string color;
    std::string symbol;
    std::int64_t movecost = 0;
    std::int64_t required_str = 0;
    std::int64_t light_emitted = 0;
    std::int64_t comfort = 0;
    std::int64_t max_volume_ml = 0;
    std::int64_t mass_grams = 0;
    std::int64_t keg_capacity_ml = 0;
    bool transparent = false;
    std::set<std::string> flags;
    std::string open;
    std::string close;
    std::string lockpick_result;
    std::string crafting_pseudo_item;
    std::string deployed_item;
    std::string examine_handler;
    std::string examine_name;
    bool registered = false;
};

struct terrain_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string color;
    std::string symbol;
    std::int64_t movecost = 0;
    std::int64_t light_emitted = 0;
    std::int64_t comfort = 0;
    std::int64_t max_volume_ml = 0;
    std::int64_t heat_radiation = 0;
    bool transparent = false;
    std::set<std::string> flags;
    std::string open;
    std::string close;
    std::string transforms_into;
    std::string roof;
    std::string lockpick_result;
    std::string trap;
    std::string examine_handler;
    std::string examine_name;
    bool registered = false;
};

struct fault_definition_data {
    std::string id;
    std::string fault_type;
    std::string name;
    std::string description;
    std::string item_prefix;
    std::string item_suffix;
    std::string message;
    std::string color = "bad";
    double price_modifier = 1.0;
    std::int64_t degradation_mod = 0;
    std::int64_t instant_damage = 0;
    double contact_area_mod = 1.0;
    double rolling_resistance_mod = 1.0;
    std::int64_t vehicle_move_penalty_mod = 0;
    std::int64_t encumbrance_mod_flat = 0;
    double encumbrance_mod_mult = 1.0;
    bool affected_by_degradation = false;
    std::set<std::string> flags;
    std::vector<std::string> block_faults;
    std::vector<std::string> fixes;
    bool registered = false;
};

struct fault_fix_definition_data {
    std::string id;
    std::string name;
    std::string success_msg;
    std::int64_t time_seconds = 0;
    std::int64_t mod_damage = 0;
    std::int64_t mod_degradation = 0;
    std::vector<std::pair<std::string, std::int64_t>> skills;
    std::vector<std::string> faults_removed;
    std::vector<std::string> faults_added;
    bool registered = false;
};

struct dream_definition_data {
    std::string category;
    std::int64_t strength = 0;
    std::vector<std::string> messages;
    bool registered = false;
};

struct achievement_definition_data {
    std::string id;
    std::string name;
    std::string description;
    bool is_conduct = false;
    std::vector<std::string> hidden_by;
    bool registered = false;
};

struct gate_definition_data {
    std::string id;
    std::string door;
    std::string floor;
    std::vector<std::string> walls;
    std::string pull_message;
    std::string open_message;
    std::string close_message;
    std::string fail_message;
    std::int64_t moves = 0;
    std::int64_t bashing_damage = 0;
    bool registered = false;
};

struct attack_vector_definition_data {
    std::string id;
    bool weapon = false;
    bool strict_limbs = false;
    bool armor_bonus = true;
    std::int64_t encumbrance_limit = 100;
    std::int64_t health_percent_limit = 10;
    std::vector<std::string> limbs;
    std::vector<std::string> contacts;
    std::vector<std::pair<std::string, std::int64_t>> limb_requirements;
    std::set<std::string> required_flags;
    std::set<std::string> forbidden_flags;
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

struct terrain_transform_rule_definition_data {
    std::string kind;
    std::vector<std::string> inputs;
    std::vector<std::string> flags;
    std::vector<std::pair<std::string, std::int64_t>> results;
    std::string message;
    bool message_good = true;
};

struct terrain_transform_definition_data {
    std::string id;
    std::vector<terrain_transform_rule_definition_data> rules;
    bool registered = false;
};

struct post_process_stage_definition_data {
    std::string kind;
    std::int64_t attempts = 0;
    std::int64_t chance = 0;
    std::int64_t min_intensity = 0;
    std::int64_t max_intensity = 0;
    std::int64_t scaling_days_start = 0;
    std::int64_t scaling_days_end = 0;
    std::string scope = "omt";
};

struct post_process_generator_definition_data {
    std::string id;
    std::vector<post_process_stage_definition_data> stages;
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

struct magic_type_definition_data {
    std::string id;
    std::string energy_source = "none";
    std::string vitamin;
    std::string energy_color = "cyan";
    std::set<std::string> cannot_cast_flags;
    std::optional<std::string> cannot_cast_message;
    std::optional<std::int64_t> max_book_level;
    double failure_cost_fraction = 0.0;
    double failure_experience_fraction = 0.2;
    std::string level_for_experience_handler;
    std::string experience_for_level_handler;
    std::string casting_experience_handler;
    std::string failure_chance_handler;
    std::string failure_cost_handler;
    std::string failure_experience_handler;
    std::string failure_handler;
    bool registered = false;
};

struct movement_mode_message_definition_data {
    std::string steed;
    std::string prepare;
    std::string success;
    std::string failure = "You feel bugs crawl over your skin.";
};

struct movement_mode_definition_data {
    std::string id;
    std::string name;
    std::string kind = "walking";
    std::uint32_t character_symbol = 0;
    std::uint32_t panel_symbol = 0;
    std::string panel_color = "white";
    std::string symbol_color = "white";
    double exertion = 1.0;
    double riding_exertion = 0.0;
    double stamina_multiplier = 1.0;
    double sound_multiplier = 1.0;
    double speed_multiplier = 1.0;
    std::int64_t mech_power_kilojoules = 2;
    std::int64_t swim_speed_modifier = 0;
    bool stop_hauling = false;
    std::vector<movement_mode_message_definition_data> messages;
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

struct terrain_transform_definition_handle {
    std::shared_ptr<terrain_transform_definition_data> definition;
    std::shared_ptr<owner_token> token;

    static std::vector<std::string> string_array( const sol::table &options,
            const std::string &key ) {
        const sol::optional<sol::table> values =
            options.get<sol::optional<sol::table>>( key );
        if( !values ) {
            return {};
        }
        const std::size_t count = require_dense_array(
                                      *values, "terrain transform " + key, 0, 1024 );
        std::vector<std::string> result;
        result.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = values->raw_get<sol::object>( index );
            if( !value.is<std::string>() ) {
                throw std::runtime_error( "terrain transform " + key +
                                          " must contain strings" );
            }
            result.push_back( value.as<std::string>() );
        }
        return result;
    }

    terrain_transform_definition_handle &rule( const std::string &kind,
            const sol::table &options ) {
        require_building_handle( token, *definition, "terrain transform" );
        if( definition->rules.size() >= 4096 ) {
            throw std::runtime_error( "terrain transform exceeds the Platform rule limit" );
        }
        terrain_transform_rule_definition_data value;
        value.kind = kind;
        value.inputs = string_array( options, "inputs" );
        value.flags = string_array( options, "flags" );
        value.message = options.get_or( "message", std::string() );
        value.message_good = options.get_or( "message_good", true );
        const sol::optional<sol::table> results =
            options.get<sol::optional<sol::table>>( "results" );
        if( !results ) {
            throw std::runtime_error( "terrain transform rule requires results" );
        }
        parse_weighted_table_entries(
            *results, "terrain transform results", value.results );
        definition->rules.push_back( std::move( value ) );
        return *this;
    }

    terrain_transform_definition_handle &terrain( const sol::table &options ) {
        return rule( "terrain", options );
    }

    terrain_transform_definition_handle &furniture( const sol::table &options ) {
        return rule( "furniture", options );
    }

    terrain_transform_definition_handle &field( const sol::table &options ) {
        return rule( "field", options );
    }

    terrain_transform_definition_handle &trap( const sol::table &options ) {
        return rule( "trap", options );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "terrain transform" );
        return definition->id;
    }
};

struct post_process_generator_definition_handle {
    std::shared_ptr<post_process_generator_definition_data> definition;
    std::shared_ptr<owner_token> token;

    post_process_generator_definition_handle &stage( const std::string &kind,
            const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "post-process generator" );
        if( definition->stages.size() >= 1024 ) {
            throw std::runtime_error(
                "post-process generator exceeds the Platform stage limit" );
        }
        post_process_stage_definition_data value;
        value.kind = kind;
        if( options ) {
            value.attempts = options->get_or<std::int64_t>( "attempts", 0 );
            value.chance = options->get_or<std::int64_t>( "chance", 0 );
            value.min_intensity = options->get_or<std::int64_t>( "min_intensity", 0 );
            value.max_intensity = options->get_or<std::int64_t>( "max_intensity", 0 );
            value.scaling_days_start =
                options->get_or<std::int64_t>( "scaling_days_start", 0 );
            value.scaling_days_end =
                options->get_or<std::int64_t>( "scaling_days_end", 0 );
            value.scope = options->get_or( "scope", std::string( "omt" ) );
        }
        definition->stages.push_back( std::move( value ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "post-process generator" );
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

struct magic_type_definition_handle {
    std::shared_ptr<magic_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    magic_type_definition_handle &cannot_cast_when( const std::string &flag ) {
        require_building_handle( token, *definition, "magic type" );
        if( flag.empty() ) {
            throw std::runtime_error( "magic-type casting flag cannot be empty" );
        }
        definition->cannot_cast_flags.insert( flag );
        return *this;
    }

    magic_type_definition_handle &progression( const std::string &level_handler,
            const std::string &experience_handler ) {
        require_building_handle( token, *definition, "magic type" );
        if( level_handler.empty() || experience_handler.empty() ) {
            throw std::runtime_error( "magic-type progression needs two named handlers" );
        }
        definition->level_for_experience_handler = level_handler;
        definition->experience_for_level_handler = experience_handler;
        return *this;
    }

    magic_type_definition_handle &casting_experience( const std::string &handler_id ) {
        require_building_handle( token, *definition, "magic type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "magic-type casting-experience handler cannot be empty" );
        }
        definition->casting_experience_handler = handler_id;
        return *this;
    }

    magic_type_definition_handle &failure_chance( const std::string &handler_id ) {
        require_building_handle( token, *definition, "magic type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "magic-type failure-chance handler cannot be empty" );
        }
        definition->failure_chance_handler = handler_id;
        return *this;
    }

    magic_type_definition_handle &failure_cost( const std::string &handler_id ) {
        require_building_handle( token, *definition, "magic type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "magic-type failure-cost handler cannot be empty" );
        }
        definition->failure_cost_handler = handler_id;
        return *this;
    }

    magic_type_definition_handle &failure_experience( const std::string &handler_id ) {
        require_building_handle( token, *definition, "magic type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "magic-type failure-experience handler cannot be empty" );
        }
        definition->failure_experience_handler = handler_id;
        return *this;
    }

    magic_type_definition_handle &on_failure( const std::string &handler_id ) {
        require_building_handle( token, *definition, "magic type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "magic-type failure handler cannot be empty" );
        }
        definition->failure_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "magic type" );
        return definition->id;
    }
};

struct movement_mode_definition_handle {
    std::shared_ptr<movement_mode_definition_data> definition;
    std::shared_ptr<owner_token> token;

    movement_mode_definition_handle &messages( const std::string &steed,
            const sol::table &options ) {
        require_building_handle( token, *definition, "movement mode" );
        movement_mode_message_definition_data messages;
        messages.steed = steed;
        messages.prepare = options.get_or( "prepare", std::string() );
        messages.success = options.get_or( "success", std::string() );
        messages.failure = options.get_or(
                               "failure", std::string( "You feel bugs crawl over your skin." ) );
        if( messages.prepare.empty() || messages.success.empty() || messages.failure.empty() ) {
            throw std::runtime_error( "movement-mode messages cannot be empty" );
        }
        definition->messages.push_back( std::move( messages ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "movement mode" );
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

struct scenario_definition_handle {
    std::shared_ptr<scenario_definition_data> definition;
    std::shared_ptr<owner_token> token;

    scenario_definition_handle &location( const std::string &id ) {
        require_building_handle( token, *definition, "scenario" );
        if( id.empty() ) {
            throw std::runtime_error( "scenario location id cannot be empty" );
        }
        definition->locations.push_back( id );
        return *this;
    }

    scenario_definition_handle &profession( const std::string &id ) {
        require_building_handle( token, *definition, "scenario" );
        if( id.empty() ) {
            throw std::runtime_error( "scenario profession id cannot be empty" );
        }
        definition->professions.push_back( id );
        return *this;
    }

    scenario_definition_handle &allowed_trait( const std::string &id ) {
        require_building_handle( token, *definition, "scenario" );
        if( id.empty() ) {
            throw std::runtime_error( "scenario trait id cannot be empty" );
        }
        definition->allowed_traits.push_back( id );
        return *this;
    }

    scenario_definition_handle &forced_trait( const std::string &id ) {
        require_building_handle( token, *definition, "scenario" );
        if( id.empty() ) {
            throw std::runtime_error( "scenario trait id cannot be empty" );
        }
        definition->forced_traits.push_back( id );
        return *this;
    }

    scenario_definition_handle &forbidden_trait( const std::string &id ) {
        require_building_handle( token, *definition, "scenario" );
        if( id.empty() ) {
            throw std::runtime_error( "scenario trait id cannot be empty" );
        }
        definition->forbidden_traits.push_back( id );
        return *this;
    }

    scenario_definition_handle &flag( const std::string &name ) {
        require_building_handle( token, *definition, "scenario" );
        if( name.empty() ) {
            throw std::runtime_error( "scenario flag cannot be empty" );
        }
        definition->flags.push_back( name );
        return *this;
    }

    scenario_definition_handle &requirement( const std::string &id ) {
        require_building_handle( token, *definition, "scenario" );
        if( id.empty() ) {
            throw std::runtime_error( "scenario requirement id cannot be empty" );
        }
        definition->requirement = id;
        return *this;
    }

    scenario_definition_handle &on_start( const std::string &handler_id ) {
        require_building_handle( token, *definition, "scenario" );
        if( handler_id.empty() ) {
            throw std::runtime_error(
                "scenario start handler id cannot be empty" );
        }
        definition->start_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "scenario" );
        return definition->id;
    }
};

struct vehicle_color_palette_definition_handle {
    std::shared_ptr<vehicle_color_palette_definition_data> definition;
    std::shared_ptr<owner_token> token;

    vehicle_color_palette_definition_handle &group( const sol::table &fuzzy_ids,
            const sol::table &colors ) {
        require_building_handle( token, *definition, "vehicle color palette" );
        const std::size_t fuzzy_count = require_dense_array(
                                            fuzzy_ids, "vehicle color palette fuzzy ids", 1, 4096 );
        const std::size_t color_count = require_dense_array(
                                            colors, "vehicle color palette colors", 1, 4096 );
        if( color_count == 0 ) {
            throw std::runtime_error(
                "vehicle color palette groups require at least one color" );
        }
        vehicle_color_palette_group_data group;
        for( std::size_t index = 1; index <= fuzzy_count; ++index ) {
            const std::string fuzzy = fuzzy_ids.raw_get<std::string>( index );
            if( fuzzy.empty() ) {
                throw std::runtime_error(
                    "vehicle color palette fuzzy ids cannot be empty" );
            }
            group.fuzzy_ids.push_back( fuzzy );
        }
        for( std::size_t index = 1; index <= color_count; ++index ) {
            const sol::table entry = colors.raw_get<sol::table>( index );
            require_dense_array( entry, "vehicle color palette color entry", 2, 2 );
            const std::string name = entry.raw_get<std::string>( 1 );
            const std::int64_t weight = entry.raw_get<std::int64_t>( 2 );
            if( name.empty() || weight <= 0 ) {
                throw std::runtime_error(
                    "vehicle color palette colors require a name and a positive weight" );
            }
            group.colors.emplace_back( name, weight );
        }
        definition->groups.push_back( std::move( group ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "vehicle color palette" );
        return definition->id;
    }
};

struct monster_group_definition_handle {
    std::shared_ptr<monster_group_definition_data> definition;
    std::shared_ptr<owner_token> token;

    monster_group_definition_handle &monster( const std::string &id,
            std::int64_t weight, std::int64_t cost,
            std::int64_t pack_minimum, std::int64_t pack_maximum ) {
        require_building_handle( token, *definition, "monster group" );
        validate_monster_group_entry( id, weight, cost, pack_minimum, pack_maximum );
        definition->entries.push_back( monster_group_entry_definition_data{
            id, std::string(), weight, cost, pack_minimum, pack_maximum
        } );
        return *this;
    }

    monster_group_definition_handle &group( const std::string &id,
                                            std::int64_t weight, std::int64_t cost,
                                            std::int64_t pack_minimum, std::int64_t pack_maximum ) {
        require_building_handle( token, *definition, "monster group" );
        validate_monster_group_entry( id, weight, cost, pack_minimum, pack_maximum );
        definition->entries.push_back( monster_group_entry_definition_data{
            std::string(), id, weight, cost, pack_minimum, pack_maximum
        } );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "monster group" );
        return definition->id;
    }
};

struct overmap_connection_definition_handle {
    std::shared_ptr<overmap_connection_definition_data> definition;
    std::shared_ptr<owner_token> token;

    overmap_connection_definition_handle &subtype( const std::string &terrain,
            std::int64_t basic_cost, const sol::table &locations,
            bool orthogonal, bool perpendicular_crossing ) {
        require_building_handle( token, *definition, "overmap connection" );
        if( terrain.empty() || basic_cost < 0 ) {
            throw std::runtime_error(
                "overmap connection subtypes require a terrain and a "
                "non-negative basic cost" );
        }
        const std::size_t location_count = require_dense_array(
                                               locations, "overmap connection subtype locations", 0, 4096 );
        overmap_connection_subtype_definition_data subtype;
        subtype.terrain = terrain;
        subtype.basic_cost = basic_cost;
        subtype.orthogonal = orthogonal;
        subtype.perpendicular_crossing = perpendicular_crossing;
        for( std::size_t index = 1; index <= location_count; ++index ) {
            const std::string location = locations.raw_get<std::string>( index );
            if( location.empty() ) {
                throw std::runtime_error(
                    "overmap connection subtype locations cannot be empty" );
            }
            subtype.locations.push_back( location );
        }
        definition->subtypes.push_back( std::move( subtype ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "overmap connection" );
        return definition->id;
    }
};

struct speed_description_definition_handle {
    std::shared_ptr<speed_description_definition_data> definition;
    std::shared_ptr<owner_token> token;

    speed_description_definition_handle &value( const double threshold,
            const sol::table &descriptions ) {
        require_building_handle( token, *definition, "speed description" );
        if( !std::isfinite( threshold ) || threshold < 0.0 ) {
            throw std::runtime_error(
                "speed-description threshold must be finite and non-negative" );
        }
        speed_description_value_data entry;
        entry.threshold = threshold;
        const std::size_t count = require_dense_array(
                                      descriptions, "speed descriptions", 1, 128 );
        entry.descriptions.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const std::string description = descriptions.raw_get<std::string>( index );
            if( description.empty() ) {
                throw std::runtime_error( "speed description text cannot be empty" );
            }
            entry.descriptions.push_back( description );
        }
        definition->values.push_back( std::move( entry ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "speed description" );
        return definition->id;
    }
};

struct harvest_drop_type_definition_handle {
    std::shared_ptr<harvest_drop_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    harvest_drop_type_definition_handle &skill( const std::string &id ) {
        require_building_handle( token, *definition, "harvest drop type" );
        if( id.empty() ) {
            throw std::runtime_error( "harvest-drop skill id cannot be empty" );
        }
        definition->skills.push_back( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "harvest drop type" );
        return definition->id;
    }
};

struct harvest_definition_handle {
        std::shared_ptr<harvest_definition_data> definition;
        std::shared_ptr<owner_token> token;

        harvest_definition_handle &drop( const sol::table &options ) {
            require_building_handle( token, *definition, "harvest" );
            harvest_entry_definition_data entry;
            entry.output = options.get_or( "output", std::string() );
            entry.category = options.get_or( "category", std::string() );
            entry.base_minimum = options.get_or( "base_minimum", 1.0 );
            entry.base_maximum = options.get_or( "base_maximum", entry.base_minimum );
            entry.skill_minimum = options.get_or( "skill_minimum", 0.0 );
            entry.skill_maximum = options.get_or( "skill_maximum", entry.skill_minimum );
            entry.maximum = options.get_or<std::int64_t>( "maximum", 1000 );
            entry.mass_ratio = options.get_or( "mass_ratio", 0.0 );
            if( entry.output.empty() || std::any_of(
                    definition->entries.begin(), definition->entries.end(),
            [&entry]( const harvest_entry_definition_data & existing ) {
            return existing.output == entry.output;
        } ) ) {
                throw std::runtime_error( "harvest drop needs a unique non-empty output id" );
            }
            definition->entries.push_back( std::move( entry ) );
            return *this;
        }

        harvest_definition_handle &item_flag( const std::string &output,
                                              const std::string &flag ) {
            require_building_handle( token, *definition, "harvest" );
            harvest_entry_definition_data &entry = require_drop( output );
            if( flag.empty() ) {
                throw std::runtime_error( "harvest item flag cannot be empty" );
            }
            entry.flags.insert( flag );
            return *this;
        }

        harvest_definition_handle &item_fault( const std::string &output,
                                               const std::string &fault ) {
            require_building_handle( token, *definition, "harvest" );
            harvest_entry_definition_data &entry = require_drop( output );
            if( fault.empty() ) {
                throw std::runtime_error( "harvest item fault cannot be empty" );
            }
            entry.faults.insert( fault );
            return *this;
        }

        std::string id() const {
            require_readable_handle( token, *definition, "harvest" );
            return definition->id;
        }

    private:
        harvest_entry_definition_data &require_drop( const std::string &output ) {
            const auto found = std::find_if(
                                   definition->entries.rbegin(), definition->entries.rend(),
            [&output]( const harvest_entry_definition_data & entry ) {
                return entry.output == output;
            } );
            if( found == definition->entries.rend() ) {
                throw std::runtime_error(
                    "harvest item metadata requires an output staged earlier on this definition" );
            }
            return *found;
        }
};

struct behavior_definition_handle {
        std::shared_ptr<behavior_definition_data> definition;
        std::shared_ptr<owner_token> token;

        behavior_definition_handle &child( const std::string &id ) {
            require_building_handle( token, *definition, "behavior" );
            if( id.empty() || std::find( definition->children.begin(),
                                         definition->children.end(), id ) !=
                definition->children.end() ) {
                throw std::runtime_error( "behavior child needs a unique non-empty id" );
            }
            definition->children.push_back( id );
            return *this;
        }

        behavior_definition_handle &when( const std::string &handler,
                                          const sol::optional<std::string> &argument,
                                          const sol::optional<bool> &inverted ) {
            return add_condition( handler, argument.value_or( std::string() ), false,
                                  inverted.value_or( false ) );
        }

        behavior_definition_handle &when_native(
            const std::string &predicate, const sol::optional<std::string> &argument,
            const sol::optional<bool> &inverted ) {
            return add_condition( predicate, argument.value_or( std::string() ), true,
                                  inverted.value_or( false ) );
        }

        behavior_definition_handle &score( const std::string &handler,
                                           const sol::optional<std::string> &argument ) {
            return set_score( handler, argument.value_or( std::string() ), false );
        }

        behavior_definition_handle &score_native(
            const std::string &predicate, const sol::optional<std::string> &argument ) {
            return set_score( predicate, argument.value_or( std::string() ), true );
        }

        std::string id() const {
            require_readable_handle( token, *definition, "behavior" );
            return definition->id;
        }

    private:
        behavior_definition_handle &add_condition( const std::string &policy,
                const std::string &argument, const bool native, const bool inverted ) {
            require_building_handle( token, *definition, "behavior" );
            if( policy.empty() ) {
                throw std::runtime_error( "behavior condition policy cannot be empty" );
            }
            definition->conditions.push_back( { policy, argument, native, inverted } );
            return *this;
        }

        behavior_definition_handle &set_score( const std::string &policy,
                                               const std::string &argument,
                                               const bool native ) {
            require_building_handle( token, *definition, "behavior" );
            if( policy.empty() ) {
                throw std::runtime_error( "behavior score policy cannot be empty" );
            }
            definition->score = behavior_score_definition_data{ policy, argument, native };
            return *this;
        }
};

struct effect_type_definition_handle {
        std::shared_ptr<effect_type_definition_data> definition;
        std::shared_ptr<owner_token> token;

        effect_type_definition_handle &name( const std::string &text ) {
            return append_text( definition->names, text, "effect name" );
        }

        effect_type_definition_handle &description( const std::string &text ) {
            return append_text( definition->descriptions, text, "effect description" );
        }

        effect_type_definition_handle &reduced_description( const std::string &text ) {
            return append_text( definition->reduced_descriptions, text,
                                "reduced effect description" );
        }

        effect_type_definition_handle &flag( const std::string &id ) {
            return insert_id( definition->flags, id, "effect flag" );
        }

        effect_type_definition_handle &immune_character_flag( const std::string &id ) {
            return insert_id( definition->immune_character_flags, id,
                              "effect immunity character flag" );
        }

        effect_type_definition_handle &immune_bodypart_flag( const std::string &id ) {
            return insert_id( definition->immune_bodypart_flags, id,
                              "effect immunity body-part flag" );
        }

        effect_type_definition_handle &resist_trait( const std::string &id ) {
            return insert_id( definition->resist_traits, id, "effect resistance trait" );
        }

        effect_type_definition_handle &resist_effect( const std::string &id ) {
            return insert_id( definition->resist_effects, id, "resistance effect" );
        }

        effect_type_definition_handle &removes_effect( const std::string &id ) {
            return insert_id( definition->removes_effects, id, "removed effect" );
        }

        effect_type_definition_handle &blocks_effect( const std::string &id ) {
            return insert_id( definition->blocks_effects, id, "blocked effect" );
        }

        std::string id() const {
            require_readable_handle( token, *definition, "effect type" );
            return definition->id;
        }

    private:
        effect_type_definition_handle &append_text( std::vector<std::string> &target,
                const std::string &text, const std::string_view label ) {
            require_building_handle( token, *definition, "effect type" );
            if( text.empty() ) {
                throw std::runtime_error( std::string( label ) + " cannot be empty" );
            }
            target.push_back( text );
            return *this;
        }

        effect_type_definition_handle &insert_id( std::set<std::string> &target,
                const std::string &id, const std::string_view label ) {
            require_building_handle( token, *definition, "effect type" );
            if( id.empty() ) {
                throw std::runtime_error( std::string( label ) + " cannot be empty" );
            }
            target.insert( id );
            return *this;
        }
};

struct monster_attack_definition_handle {
    std::shared_ptr<monster_attack_definition_data> definition;
    std::shared_ptr<owner_token> token;

    monster_attack_definition_handle &policy( const std::string &handler ) {
        require_building_handle( token, *definition, "monster attack" );
        if( handler.empty() ) {
            throw std::runtime_error( "monster attack policy cannot be empty" );
        }
        definition->handler = handler;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "monster attack" );
        return definition->id;
    }
};

struct weakpoint_set_definition_handle {
        using damage_value_map = std::map<std::string, double>;

        std::shared_ptr<weakpoint_set_definition_data> definition;
        std::shared_ptr<owner_token> token;

        weakpoint_set_definition_handle &weakpoint( const sol::table &options ) {
            require_building_handle( token, *definition, "weakpoint set" );
            weakpoint_definition_data value;
            value.id = options.get_or( "id", std::string() );
            value.name = options.get_or( "name", std::string() );
            value.coverage = options.get_or( "coverage", 100.0 );
            value.good = options.get_or( "good", true );
            value.head = options.get_or( "head", false );
            if( value.id.empty() || std::any_of(
                    definition->weakpoints.begin(), definition->weakpoints.end(),
            [&value]( const weakpoint_definition_data & existing ) {
            return existing.id == value.id;
        } ) ) {
                throw std::runtime_error( "weakpoint needs a unique non-empty id" );
            }
            definition->weakpoints.push_back( std::move( value ) );
            return *this;
        }

        weakpoint_set_definition_handle &armor_multiplier(
            const std::string &weakpoint_id, const std::string &damage_type,
            const double value ) {
            return set_damage_value( weakpoint_id, damage_type, value,
            []( weakpoint_definition_data & point ) -> damage_value_map & {
                return point.armor_multipliers;
            }, "armor multiplier" );
        }

        weakpoint_set_definition_handle &armor_penalty(
            const std::string &weakpoint_id, const std::string &damage_type,
            const double value ) {
            return set_damage_value( weakpoint_id, damage_type, value,
            []( weakpoint_definition_data & point ) -> damage_value_map & {
                return point.armor_penalties;
            }, "armor penalty" );
        }

        weakpoint_set_definition_handle &damage_multiplier(
            const std::string &weakpoint_id, const std::string &damage_type,
            const double value ) {
            return set_damage_value( weakpoint_id, damage_type, value,
            []( weakpoint_definition_data & point ) -> damage_value_map & {
                return point.damage_multipliers;
            }, "damage multiplier" );
        }

        weakpoint_set_definition_handle &critical_multiplier(
            const std::string &weakpoint_id, const std::string &damage_type,
            const double value ) {
            return set_damage_value( weakpoint_id, damage_type, value,
            []( weakpoint_definition_data & point ) -> damage_value_map & {
                return point.critical_multipliers;
            }, "critical multiplier" );
        }

        weakpoint_set_definition_handle &effect( const std::string &weakpoint_id,
                const sol::table &options ) {
            require_building_handle( token, *definition, "weakpoint set" );
            weakpoint_effect_definition_data value;
            value.effect = options.get_or( "effect", std::string() );
            value.chance = options.get_or( "chance", 100.0 );
            value.permanent = options.get_or( "permanent", false );
            value.duration_min_turns = options.get_or<std::int64_t>(
                                           "duration_min_turns", 0 );
            value.duration_max_turns = options.get_or<std::int64_t>(
                                           "duration_max_turns", value.duration_min_turns );
            value.intensity_min = options.get_or<std::int64_t>( "intensity_min", 1 );
            value.intensity_max = options.get_or<std::int64_t>(
                                      "intensity_max", value.intensity_min );
            value.damage_required_min = options.get_or( "damage_required_min", 0.0 );
            value.damage_required_max = options.get_or(
                                            "damage_required_max", 100.0 );
            value.message = options.get_or( "message", std::string() );
            value.handler = options.get_or(
                                "on_apply",
                                options.get_or( "handler", std::string() ) );
            require_weakpoint( weakpoint_id ).effects.push_back( std::move( value ) );
            return *this;
        }

        std::string id() const {
            require_readable_handle( token, *definition, "weakpoint set" );
            return definition->id;
        }

    private:
        weakpoint_definition_data &require_weakpoint( const std::string &id ) {
            const auto found = std::find_if(
                                   definition->weakpoints.begin(), definition->weakpoints.end(),
            [&id]( const weakpoint_definition_data & point ) {
                return point.id == id;
            } );
            if( found == definition->weakpoints.end() ) {
                throw std::runtime_error(
                    "weakpoint metadata requires an id staged earlier on this definition" );
            }
            return *found;
        }

        template<typename Select>
        weakpoint_set_definition_handle &set_damage_value(
            const std::string &weakpoint_id, const std::string &damage_type,
            const double value, Select select, const std::string_view label ) {
            require_building_handle( token, *definition, "weakpoint set" );
            if( damage_type.empty() || !std::isfinite( value ) ) {
                throw std::runtime_error( "weakpoint " + std::string( label ) +
                                          " needs a damage type and finite value" );
            }
            select( require_weakpoint( weakpoint_id ) )[damage_type] = value;
            return *this;
        }
};

struct sub_body_part_definition_handle {
    std::shared_ptr<sub_body_part_definition_data> definition;
    std::shared_ptr<owner_token> token;

    sub_body_part_definition_handle &location_under( const std::string &id ) {
        require_building_handle( token, *definition, "sub body part" );
        if( id.empty() ) {
            throw std::runtime_error( "sub-body-part lower location cannot be empty" );
        }
        definition->locations_under.push_back( id );
        return *this;
    }

    sub_body_part_definition_handle &unarmed_damage( const std::string &damage_type,
            const double amount ) {
        require_building_handle( token, *definition, "sub body part" );
        if( damage_type.empty() || !std::isfinite( amount ) || amount < 0.0 ) {
            throw std::runtime_error( "sub-body-part unarmed damage is invalid" );
        }
        definition->unarmed_damage[damage_type] = amount;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "sub body part" );
        return definition->id;
    }
};

struct body_part_definition_handle {
        std::shared_ptr<body_part_definition_data> definition;
        std::shared_ptr<owner_token> token;

        body_part_definition_handle &sub_part( const std::string &id ) {
            require_building_handle( token, *definition, "body part" );
            if( id.empty() ) {
                throw std::runtime_error( "body-part sub location cannot be empty" );
            }
            definition->sub_parts.push_back( id );
            return *this;
        }

        body_part_definition_handle &limb_type( const std::string &kind,
                                                const sol::optional<double> &weight ) {
            require_building_handle( token, *definition, "body part" );
            const double value = weight.value_or( 1.0 );
            if( kind.empty() || !std::isfinite( value ) || value <= 0.0 ) {
                throw std::runtime_error( "body-part limb type is invalid" );
            }
            definition->limb_types[kind] = value;
            return *this;
        }

        body_part_definition_handle &armor( const std::string &damage_type,
                                            const double amount ) {
            return set_damage( definition->armor, damage_type, amount, "armor" );
        }

        body_part_definition_handle &unarmed_damage( const std::string &damage_type,
                const double amount ) {
            return set_damage( definition->unarmed_damage, damage_type, amount,
                               "unarmed damage" );
        }

        body_part_definition_handle &flag( const std::string &id ) {
            require_building_handle( token, *definition, "body part" );
            if( id.empty() ) {
                throw std::runtime_error( "body-part flag cannot be empty" );
            }
            definition->flags.insert( id );
            return *this;
        }

        body_part_definition_handle &limb_score( const std::string &id,
                const double score, const sol::optional<double> &maximum ) {
            require_building_handle( token, *definition, "body part" );
            const double maximum_value = maximum.value_or( score );
            if( id.empty() || !std::isfinite( score ) || !std::isfinite( maximum_value ) ||
                score < 0.0 || maximum_value < score ) {
                throw std::runtime_error( "body-part limb score is invalid" );
            }
            definition->limb_scores[id] = { score, maximum_value };
            return *this;
        }

        body_part_definition_handle &quality( const std::string &id,
                                              const std::int64_t level,
                                              const sol::optional<double> &disable_fraction ) {
            require_building_handle( token, *definition, "body part" );
            definition->qualities.push_back( {
                id, level, disable_fraction.value_or( 0.0 )
            } );
            return *this;
        }

        std::string id() const {
            require_readable_handle( token, *definition, "body part" );
            return definition->id;
        }

    private:
        body_part_definition_handle &set_damage( std::map<std::string, double> &target,
                const std::string &damage_type, const double amount,
                const std::string_view label ) {
            require_building_handle( token, *definition, "body part" );
            if( damage_type.empty() || !std::isfinite( amount ) || amount < 0.0 ) {
                throw std::runtime_error( "body-part " + std::string( label ) + " is invalid" );
            }
            target[damage_type] = amount;
            return *this;
        }
};

struct wound_type_definition_handle {
        std::shared_ptr<wound_type_definition_data> definition;
        std::shared_ptr<owner_token> token;

        wound_type_definition_handle &damage_type( const std::string &id ) {
            require_building_handle( token, *definition, "wound" );
            require_reference( id, "damage type" );
            if( std::find( definition->damage_types.begin(), definition->damage_types.end(), id ) !=
                definition->damage_types.end() ) {
                throw std::runtime_error( "wound damage type must be unique" );
            }
            definition->damage_types.push_back( id );
            return *this;
        }

        wound_type_definition_handle &limb_score( const std::string &id,
                const double penalty ) {
            require_building_handle( token, *definition, "wound" );
            require_reference( id, "limb score" );
            if( !std::isfinite( penalty ) || penalty < 0.0 || penalty > 1.0 ||
                std::any_of( definition->limb_scores.begin(), definition->limb_scores.end(),
            [&id]( const wound_limb_score_definition_data & value ) {
            return value.id == id;
        } ) ) {
                throw std::runtime_error(
                    "wound limb score requires a unique id and finite 0..1 penalty" );
            }
            definition->limb_scores.push_back( { id, penalty } );
            return *this;
        }

        wound_type_definition_handle &progression( const std::string &id,
                const std::int64_t chance ) {
            require_building_handle( token, *definition, "wound" );
            require_reference( id, "progression wound" );
            if( id == definition->id || chance < 0 || chance > 100 ||
                std::any_of( definition->progressions.begin(), definition->progressions.end(),
            [&id]( const wound_progression_definition_data & value ) {
            return value.id == id;
        } ) ) {
                throw std::runtime_error(
                    "wound progression requires a unique non-self id and integer 0..100 chance" );
            }
            definition->progressions.push_back( { id, chance } );
            return *this;
        }

        wound_type_definition_handle &require_body_part_type( const std::string &kind ) {
            return body_part_type( kind, true );
        }

        wound_type_definition_handle &forbid_body_part_type( const std::string &kind ) {
            return body_part_type( kind, false );
        }

        std::string id() const {
            require_readable_handle( token, *definition, "wound" );
            return definition->id;
        }

    private:
        static void require_reference( const std::string &id, const char *kind ) {
            if( id.empty() || id.size() > 256 || id.find( '\0' ) != std::string::npos ) {
                throw std::runtime_error( std::string( "wound " ) + kind +
                                          " id is invalid" );
            }
        }

        wound_type_definition_handle &body_part_type( const std::string &kind,
                const bool required ) {
            require_building_handle( token, *definition, "wound" );
            if( kind.empty() || kind.size() > 64 ||
                kind.find( '\0' ) != std::string::npos ||
                !io::string_to_enum_optional<bp_type>( kind ) ) {
                throw std::runtime_error( "wound body-part type is invalid" );
            }
            std::vector<std::string> &target = required ?
                                               definition->required_body_part_types :
                                               definition->forbidden_body_part_types;
            const std::vector<std::string> &opposite = required ?
                    definition->forbidden_body_part_types :
                    definition->required_body_part_types;
            if( std::find( target.begin(), target.end(), kind ) != target.end() ) {
                throw std::runtime_error( "wound body-part type must be unique" );
            }
            if( std::find( opposite.begin(), opposite.end(), kind ) != opposite.end() ) {
                throw std::runtime_error(
                    "wound cannot both require and forbid one body-part type" );
            }
            target.push_back( kind );
            return *this;
        }
};

struct wound_fix_definition_handle {
        std::shared_ptr<wound_fix_definition_data> definition;
        std::shared_ptr<owner_token> token;

        wound_fix_definition_handle &skill( const std::string &id,
                                            const std::int64_t level ) {
            require_building_handle( token, *definition, "wound fix" );
            require_reference( id, "skill" );
            if( level < 0 || level > MAX_SKILL ||
                !definition->skills.emplace( id, level ).second ) {
                throw std::runtime_error(
                    "wound-fix skill requires a unique id and level within the native range" );
            }
            return *this;
        }

        wound_fix_definition_handle &proficiency( const std::string &id,
                const double multiplier, const bool mandatory ) {
            require_building_handle( token, *definition, "wound fix" );
            require_reference( id, "proficiency" );
            if( !std::isfinite( multiplier ) || multiplier <= 0.0 ||
                multiplier > std::numeric_limits<float>::max() ||
                static_cast<float>( multiplier ) <= 0.0f ||
                std::any_of( definition->proficiencies.begin(), definition->proficiencies.end(),
            [&id]( const wound_fix_proficiency_definition_data & value ) {
            return value.id == id;
        } ) ) {
                throw std::runtime_error(
                    "wound-fix proficiency requires a unique id and positive finite multiplier" );
            }
            definition->proficiencies.push_back( { id, multiplier, mandatory } );
            return *this;
        }

        wound_fix_definition_handle &removes( const std::string &id ) {
            return wound_reference( id, true );
        }

        wound_fix_definition_handle &adds( const std::string &id ) {
            return wound_reference( id, false );
        }

        wound_fix_definition_handle &requires( const std::string &id,
                                               const std::int64_t count ) {
            require_building_handle( token, *definition, "wound fix" );
            require_reference( id, "requirement" );
            if( count <= 0 || count > std::numeric_limits<int>::max() ||
                std::any_of( definition->requirements.begin(), definition->requirements.end(),
            [&id]( const wound_fix_requirement_definition_data & value ) {
            return value.id == id;
        } ) ) {
                throw std::runtime_error(
                    "wound-fix requirement requires a unique id and positive native count" );
            }
            definition->requirements.push_back( { id, count } );
            return *this;
        }

        std::string id() const {
            require_readable_handle( token, *definition, "wound fix" );
            return definition->id;
        }

    private:
        static void require_reference( const std::string &id, const char *kind ) {
            if( id.empty() || id.size() > 256 || id.find( '\0' ) != std::string::npos ) {
                throw std::runtime_error( std::string( "wound-fix " ) + kind +
                                          " id is invalid" );
            }
        }

        wound_fix_definition_handle &wound_reference( const std::string &id,
                const bool removed ) {
            require_building_handle( token, *definition, "wound fix" );
            require_reference( id, "wound" );
            std::set<std::string> &target = removed ? definition->wounds_removed :
                                            definition->wounds_added;
            const std::set<std::string> &opposite = removed ? definition->wounds_added :
                                                    definition->wounds_removed;
            if( opposite.count( id ) != 0 ) {
                throw std::runtime_error(
                    "wound fix cannot both remove and add one wound type" );
            }
            if( !target.insert( id ).second ) {
                throw std::runtime_error( "wound-fix wound reference must be unique" );
            }
            return *this;
        }
};

struct anatomy_definition_handle {
    std::shared_ptr<anatomy_definition_data> definition;
    std::shared_ptr<owner_token> token;

    anatomy_definition_handle &part( const std::string &id ) {
        require_building_handle( token, *definition, "anatomy" );
        if( id.empty() || std::find( definition->parts.begin(),
                                     definition->parts.end(), id ) != definition->parts.end() ) {
            throw std::runtime_error( "anatomy part needs a unique non-empty id" );
        }
        definition->parts.push_back( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "anatomy" );
        return definition->id;
    }
};

struct body_graph_definition_handle {
    std::shared_ptr<body_graph_definition_data> definition;
    std::shared_ptr<owner_token> token;

    body_graph_definition_handle &row( const std::string &value,
                                       const sol::optional<std::string> &fill ) {
        require_building_handle( token, *definition, "body graph" );
        if( value.empty() ) {
            throw std::runtime_error( "body-graph row cannot be empty" );
        }
        definition->rows.push_back( value );
        if( fill ) {
            if( definition->fill_rows.size() + 1 != definition->rows.size() ) {
                throw std::runtime_error(
                    "body-graph fill rows must be supplied for every row" );
            }
            definition->fill_rows.push_back( *fill );
        } else if( !definition->fill_rows.empty() ) {
            throw std::runtime_error(
                "body-graph fill rows must be supplied for every row" );
        }
        return *this;
    }

    body_graph_definition_handle &part( const std::string &symbol,
                                        const sol::table &options ) {
        require_building_handle( token, *definition, "body graph" );
        body_graph_part_definition_data value;
        value.symbol = symbol;
        value.nested_graph = options.get_or( "nested_graph", std::string() );
        value.selected_color = options.get_or(
                                   "selected_color", std::string( "white" ) );
        value.display_symbol = options.get_or( "display_symbol", std::string() );
        const auto read_ids = []( const sol::optional<sol::table> &source,
        const std::string_view label ) {
            std::vector<std::string> ids;
            if( !source ) {
                return ids;
            }
            const std::size_t count = require_dense_array( *source, label, 0, 256 );
            ids.reserve( count );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::object raw = source->raw_get<sol::object>( index );
                if( raw.get_type() != sol::type::string ) {
                    throw std::invalid_argument( std::string( label ) +
                                                 " must contain strings" );
                }
                ids.push_back( raw.as<std::string>() );
            }
            return ids;
        };
        value.body_parts = read_ids(
                               options.get<sol::optional<sol::table>>( "body_parts" ),
                               "body graph body parts" );
        value.sub_body_parts = read_ids(
                                   options.get<sol::optional<sol::table>>( "sub_body_parts" ),
                                   "body graph sub body parts" );
        if( symbol.empty() || std::any_of( definition->parts.begin(),
                                           definition->parts.end(),
        [&symbol]( const body_graph_part_definition_data & existing ) {
        return existing.symbol == symbol;
    } ) ) {
            throw std::runtime_error( "body-graph part needs a unique symbol" );
        }
        definition->parts.push_back( std::move( value ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "body graph" );
        return definition->id;
    }
};

struct monster_definition_handle {
        std::shared_ptr<monster_definition_data> definition;
        std::shared_ptr<owner_token> token;

        monster_definition_handle &material( const std::string &id,
                                             const sol::optional<std::int64_t> &portions ) {
            require_building_handle( token, *definition, "monster" );
            const std::int64_t value = portions.value_or( 1 );
            if( id.empty() || value <= 0 ) {
                throw std::runtime_error( "monster material needs an id and positive portions" );
            }
            definition->materials[id] = value;
            return *this;
        }

        monster_definition_handle &species( const std::string &id ) {
            return insert_id( definition->species, id, "species" );
        }

        monster_definition_handle &category( const std::string &id ) {
            return insert_id( definition->categories, id, "category" );
        }

        monster_definition_handle &flag( const std::string &id ) {
            return insert_id( definition->flags, id, "flag" );
        }

        monster_definition_handle &armor( const std::string &damage_type,
                                          const double amount ) {
            require_building_handle( token, *definition, "monster" );
            if( damage_type.empty() || !std::isfinite( amount ) || amount < 0.0 ) {
                throw std::runtime_error( "monster armor is invalid" );
            }
            definition->armor[damage_type] = amount;
            return *this;
        }

        monster_definition_handle &melee_damage(
            const std::string &damage_type, const double amount,
            const sol::optional<double> &armor_penetration ) {
            require_building_handle( token, *definition, "monster" );
            const double penetration = armor_penetration.value_or( 0.0 );
            if( damage_type.empty() || !std::isfinite( amount ) || amount < 0.0 ||
                !std::isfinite( penetration ) || penetration < 0.0 ) {
                throw std::runtime_error( "monster melee damage is invalid" );
            }
            definition->melee_damage[damage_type] = { amount, penetration };
            return *this;
        }

        monster_definition_handle &attack( const std::string &id,
                                           const sol::optional<double> &cooldown ) {
            require_building_handle( token, *definition, "monster" );
            if( id.empty() || std::any_of( definition->attacks.begin(),
                                           definition->attacks.end(),
            [&id]( const monster_attack_reference_definition_data & value ) {
            return value.id == id;
        } ) ) {
                throw std::runtime_error( "monster attack reference needs a unique id" );
            }
            monster_attack_reference_definition_data attack;
            attack.id = id;
            if( cooldown ) {
                attack.cooldown = *cooldown;
            }
            definition->attacks.push_back( std::move( attack ) );
            return *this;
        }

        monster_definition_handle &on_attack( const std::string &attack_id,
                                               const std::string &handler_id ) {
            require_building_handle( token, *definition, "monster" );
            if( attack_id.empty() || handler_id.empty() ) {
                throw std::runtime_error(
                    "monster attack callback needs attack and handler ids" );
            }
            definition->attack_handlers[attack_id] = handler_id;
            return *this;
        }

        monster_definition_handle &weakpoint_set( const std::string &id ) {
            require_building_handle( token, *definition, "monster" );
            if( id.empty() || std::find( definition->weakpoint_sets.begin(),
                                         definition->weakpoint_sets.end(), id ) !=
                definition->weakpoint_sets.end() ) {
                throw std::runtime_error( "monster weakpoint set needs a unique id" );
            }
            definition->weakpoint_sets.push_back( id );
            return *this;
        }

        monster_definition_handle &emission( const std::string &id,
                                             const std::int64_t interval_turns ) {
            require_building_handle( token, *definition, "monster" );
            if( id.empty() || interval_turns <= 0 ) {
                throw std::runtime_error( "monster emission needs an id and positive interval" );
            }
            definition->emissions[id] = interval_turns;
            return *this;
        }

        monster_definition_handle &starting_ammo( const std::string &id,
                const std::int64_t amount ) {
            require_building_handle( token, *definition, "monster" );
            if( id.empty() || amount <= 0 ) {
                throw std::runtime_error( "monster starting ammo needs an id and positive amount" );
            }
            definition->starting_ammo[id] = amount;
            return *this;
        }

        monster_definition_handle &track_scent( const std::string &id ) {
            return insert_id( definition->tracked_scents, id, "tracked scent" );
        }

        monster_definition_handle &ignore_scent( const std::string &id ) {
            return insert_id( definition->ignored_scents, id, "ignored scent" );
        }

        monster_definition_handle &regeneration_modifier( const std::string &effect,
                const std::int64_t amount ) {
            require_building_handle( token, *definition, "monster" );
            if( effect.empty() || amount < std::numeric_limits<int>::min() ||
                amount > std::numeric_limits<int>::max() ) {
                throw std::runtime_error( "monster regeneration modifier is invalid" );
            }
            definition->regeneration_modifiers[effect] = amount;
            return *this;
        }

        monster_definition_handle &goal( const std::string &id ) {
            require_building_handle( token, *definition, "monster" );
            if( id.empty() || std::find( definition->goals.begin(), definition->goals.end(), id ) !=
                definition->goals.end() ) {
                throw std::runtime_error( "monster behavior goal needs a unique id" );
            }
            definition->goals.push_back( id );
            return *this;
        }

        monster_definition_handle &anger_trigger( const std::string &id ) {
            return insert_id( definition->anger_triggers, id, "anger trigger" );
        }

        monster_definition_handle &fear_trigger( const std::string &id ) {
            return insert_id( definition->fear_triggers, id, "fear trigger" );
        }

        monster_definition_handle &placate_trigger( const std::string &id ) {
            return insert_id( definition->placate_triggers, id, "placate trigger" );
        }

        monster_definition_handle &on_death( const std::string &handler_id ) {
            require_building_handle( token, *definition, "monster" );
            if( handler_id.empty() ) {
                throw std::runtime_error( "monster death handler id cannot be empty" );
            }
            definition->death_handler = handler_id;
            return *this;
        }

        std::string id() const {
            require_readable_handle( token, *definition, "monster" );
            return definition->id;
        }

    private:
        monster_definition_handle &insert_id( std::set<std::string> &target,
                                              const std::string &id, const std::string_view label ) {
            require_building_handle( token, *definition, "monster" );
            if( id.empty() ) {
                throw std::runtime_error( "monster " + std::string( label ) +
                                          " cannot be empty" );
            }
            target.insert( id );
            return *this;
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

struct field_type_definition_handle {
        std::shared_ptr<field_type_definition_data> definition;
        std::shared_ptr<owner_token> token;

        field_type_definition_handle &intensity( const sol::table &options ) {
            require_building_handle( token, *definition, "field type" );
            field_intensity_definition_data value;
            value.name = options.get_or( "name", std::string() );
            value.symbol = options.get_or( "symbol", std::string( "%" ) );
            value.color = options.get_or( "color", std::string( "white" ) );
            value.dangerous = options.get_or( "dangerous", false );
            value.transparent = options.get_or( "transparent", true );
            value.move_cost = options.get_or<std::int64_t>( "move_cost", 0 );
            value.upgrade_chance = options.get_or<std::int64_t>( "upgrade_chance", 0 );
            value.upgrade_duration_turns = options.get_or<std::int64_t>(
                                               "upgrade_duration_turns", 0 );
            value.light_emitted = options.get_or( "light_emitted", 0.0 );
            value.local_light_override = options.get_or( "local_light_override", -1.0 );
            value.translucency = options.get_or( "translucency", 0.0 );
            value.concentration = options.get_or<std::int64_t>( "concentration", 1 );
            value.convection_temperature_modifier = options.get_or<std::int64_t>(
                    "convection_temperature_modifier", 0 );
            value.scent_neutralization = options.get_or<std::int64_t>(
                                             "scent_neutralization", 0 );
            definition->intensity_levels.push_back( std::move( value ) );
            return *this;
        }

        field_type_definition_handle &effect( const std::int64_t intensity_index,
                                              const sol::table &options ) {
            require_building_handle( token, *definition, "field type" );
            if( intensity_index <= 0 ||
                static_cast<std::size_t>( intensity_index ) >
                definition->intensity_levels.size() ) {
                throw std::runtime_error( "field effect needs an existing one-based intensity" );
            }
            field_effect_definition_data value;
            value.effect = options.get_or( "effect", std::string() );
            value.duration_min_turns = options.get_or<std::int64_t>(
                                           "duration_min_turns", 0 );
            value.duration_max_turns = options.get_or<std::int64_t>(
                                           "duration_max_turns", value.duration_min_turns );
            value.intensity = options.get_or<std::int64_t>( "intensity", 1 );
            value.body_part = options.get_or( "body_part", std::string() );
            value.environmental = options.get_or( "environmental", true );
            value.message = options.get_or( "message", std::string() );
            value.npc_message = options.get_or( "npc_message", std::string() );
            definition->intensity_levels[static_cast<std::size_t>( intensity_index - 1 )].
            effects.push_back( std::move( value ) );
            return *this;
        }

        field_type_definition_handle &immune_monster( const std::string &id ) {
            return insert_monster( definition->immune_monsters, id, "immune monster" );
        }

        field_type_definition_handle &block_monster( const std::string &id ) {
            return insert_monster( definition->blocked_monsters, id, "blocked monster" );
        }

        std::string id() const {
            require_readable_handle( token, *definition, "field type" );
            return definition->id;
        }

    private:
        field_type_definition_handle &insert_monster( std::set<std::string> &target,
                const std::string &id, const std::string_view label ) {
            require_building_handle( token, *definition, "field type" );
            if( id.empty() ) {
                throw std::runtime_error( std::string( label ) + " cannot be empty" );
            }
            target.insert( id );
            return *this;
        }
};

struct morale_type_definition_handle {
    std::shared_ptr<morale_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "morale type" );
        return definition->id;
    }
};

struct disease_type_definition_handle {
    std::shared_ptr<disease_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    disease_type_definition_handle &affected_body_part( const std::string &id ) {
        require_building_handle( token, *definition, "disease type" );
        if( id.empty() ) {
            throw std::runtime_error( "disease affected body-part id cannot be empty" );
        }
        definition->affected_body_parts.insert( id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "disease type" );
        return definition->id;
    }
};

struct monster_flag_definition_handle {
    std::shared_ptr<monster_flag_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "monster flag" );
        return definition->id;
    }
};

struct species_definition_handle {
    std::shared_ptr<species_definition_data> definition;
    std::shared_ptr<owner_token> token;

    species_definition_handle &flag( const std::string &id ) {
        require_building_handle( token, *definition, "species" );
        if( id.empty() ) {
            throw std::runtime_error( "species flag id cannot be empty" );
        }
        definition->flags.insert( id );
        return *this;
    }

    species_definition_handle &anger( const std::string &trigger ) {
        require_building_handle( token, *definition, "species" );
        if( trigger.empty() ) {
            throw std::runtime_error( "species anger trigger cannot be empty" );
        }
        definition->anger.insert( trigger );
        return *this;
    }

    species_definition_handle &fear( const std::string &trigger ) {
        require_building_handle( token, *definition, "species" );
        if( trigger.empty() ) {
            throw std::runtime_error( "species fear trigger cannot be empty" );
        }
        definition->fear.insert( trigger );
        return *this;
    }

    species_definition_handle &placate( const std::string &trigger ) {
        require_building_handle( token, *definition, "species" );
        if( trigger.empty() ) {
            throw std::runtime_error( "species placate trigger cannot be empty" );
        }
        definition->placate.insert( trigger );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "species" );
        return definition->id;
    }
};

struct emission_definition_handle {
    std::shared_ptr<emission_definition_data> definition;
    std::shared_ptr<owner_token> token;

    emission_definition_handle &profile( const std::string &handler_id ) {
        require_building_handle( token, *definition, "emission" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "emission profile handler id cannot be empty" );
        }
        definition->profile_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "emission" );
        return definition->id;
    }
};

struct monster_faction_definition_handle {
    std::shared_ptr<monster_faction_definition_data> definition;
    std::shared_ptr<owner_token> token;

    monster_faction_definition_handle &attitude( const std::string &kind,
            const std::string &target ) {
        require_building_handle( token, *definition, "monster faction" );
        if( target.empty() ) {
            throw std::runtime_error( "monster faction attitude target cannot be empty" );
        }
        if( kind != "by_mood" && kind != "neutral" &&
            kind != "friendly" && kind != "hate" ) {
            throw std::runtime_error( "monster faction attitude must be by_mood, neutral, friendly, or hate" );
        }
        definition->attitudes[target] = kind;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "monster faction" );
        return definition->id;
    }
};

struct mutation_type_definition_handle {
    std::shared_ptr<mutation_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "mutation type" );
        return definition->id;
    }
};

struct connect_group_definition_handle {
    std::shared_ptr<connect_group_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "connect group" );
        return definition->id;
    }
};

struct mutation_category_definition_handle {
    std::shared_ptr<mutation_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "mutation category" );
        return definition->id;
    }
};

struct construction_category_definition_handle {
    std::shared_ptr<construction_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "construction category" );
        return definition->id;
    }
};

struct construction_group_definition_handle {
    std::shared_ptr<construction_group_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "construction group" );
        return definition->id;
    }
};

struct vehicle_part_location_definition_handle {
    std::shared_ptr<vehicle_part_location_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "vehicle part location" );
        return definition->id;
    }
};

struct mood_face_definition_handle {
    std::shared_ptr<mood_face_definition_data> definition;
    std::shared_ptr<owner_token> token;

    mood_face_definition_handle &value( const std::int64_t score,
                                        const std::string &face ) {
        require_building_handle( token, *definition, "mood face" );
        if( score < std::numeric_limits<int>::min() ||
            score > std::numeric_limits<int>::max() || face.empty() ) {
            throw std::runtime_error( "mood-face value is outside the native range" );
        }
        definition->values.push_back( { score, face } );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "mood face" );
        return definition->id;
    }
};

struct damage_info_order_definition_handle {
    std::shared_ptr<damage_info_order_definition_data> definition;
    std::shared_ptr<owner_token> token;

    damage_info_order_definition_handle &section( const std::string &section,
            const std::int64_t order, const bool show_type ) {
        require_building_handle( token, *definition, "damage info order" );
        static const std::set<std::string> supported = {
            "bionic", "protection", "pet_protection", "melee", "ablative"
        };
        if( supported.count( section ) == 0 ||
            order < std::numeric_limits<int>::min() ||
            order > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "damage-info section is unknown or outside the native range" );
        }
        const auto duplicate = std::find_if(
                                   definition->sections.begin(), definition->sections.end(),
        [&section]( const damage_info_order_section_definition_data & value ) {
            return value.section == section;
        } );
        if( duplicate != definition->sections.end() ) {
            throw std::runtime_error( "damage-info section is already defined" );
        }
        definition->sections.push_back( { section, order, show_type } );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "damage info order" );
        return definition->id;
    }
};

struct vehicle_part_category_definition_handle {
    std::shared_ptr<vehicle_part_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "vehicle part category" );
        return definition->id;
    }
};

struct named_color_definition_handle {
    std::shared_ptr<named_color_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string name() const {
        require_readable_handle( token, *definition, "named color" );
        return definition->name;
    }
};

struct rotatable_symbol_definition_handle {
    std::shared_ptr<rotatable_symbol_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string key() const {
        require_readable_handle( token, *definition, "rotatable symbol" );
        return definition->key;
    }
};

struct ascii_art_definition_handle {
    std::shared_ptr<ascii_art_definition_data> definition;
    std::shared_ptr<owner_token> token;

    ascii_art_definition_handle &line( const std::string &text ) {
        require_building_handle( token, *definition, "ASCII art" );
        if( utf8_width( remove_color_tags( text ) ) > 41 ) {
            throw std::runtime_error( "ASCII-art line exceeds the native display width" );
        }
        definition->lines.push_back( text );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "ASCII art" );
        return definition->id;
    }
};

struct limb_score_definition_handle {
    std::shared_ptr<limb_score_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "limb score" );
        return definition->id;
    }
};

struct hit_range_definition_handle {
    std::shared_ptr<hit_range_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "hit range" );
        return definition->id;
    }
};

struct bash_damage_profile_definition_handle {
    std::shared_ptr<bash_damage_profile_definition_data> definition;
    std::shared_ptr<owner_token> token;

    bash_damage_profile_definition_handle &factor( const std::string &damage_type,
            const double multiplier ) {
        require_building_handle( token, *definition, "bash damage profile" );
        if( damage_type.empty() || !std::isfinite( multiplier ) || multiplier < 0.0 ) {
            throw std::runtime_error( "bash damage factor requires a damage type and non-negative multiplier" );
        }
        definition->factors[damage_type] = multiplier;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "bash damage profile" );
        return definition->id;
    }
};

struct clothing_mod_definition_handle {
    std::shared_ptr<clothing_mod_definition_data> definition;
    std::shared_ptr<owner_token> token;

    clothing_mod_definition_handle &modifier( const sol::table &options ) {
        require_building_handle( token, *definition, "clothing modification" );
        clothing_modifier_definition_data value;
        value.stat = options.get_or( "stat", std::string() );
        value.amount = options.get_or( "amount", 0.0 );
        value.round_up = options.get_or( "round_up", false );
        if( value.stat.empty() || !std::isfinite( value.amount ) ) {
            throw std::runtime_error( "clothing modifier requires a stat and finite amount" );
        }
        const sol::optional<sol::table> scaling =
            options.get<sol::optional<sol::table>>( "scale" );
        if( scaling ) {
            const std::size_t count = require_dense_array(
                                          *scaling, "clothing modifier scale", 0, 2 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const std::string dimension = scaling->raw_get<std::string>( index );
                if( dimension == "thickness" ) {
                    value.per_thickness = true;
                } else if( dimension == "coverage" ) {
                    value.per_coverage = true;
                } else {
                    throw std::runtime_error( "clothing modifier scale must use thickness or coverage" );
                }
            }
        }
        definition->modifiers.push_back( std::move( value ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "clothing modification" );
        return definition->id;
    }
};

struct overmap_land_use_code_definition_handle {
    std::shared_ptr<overmap_land_use_code_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "overmap land-use code" );
        return definition->id;
    }
};

struct overmap_vision_definition_handle {
    std::shared_ptr<overmap_vision_definition_data> definition;
    std::shared_ptr<owner_token> token;

    overmap_vision_definition_handle &appearance( const sol::table &options ) {
        require_building_handle( token, *definition, "overmap vision" );
        overmap_vision_level_definition_data level;
        level.name = options.get_or( "name", std::string() );
        level.color = options.get_or( "color", std::string( "black" ) );
        level.looks_like = options.get_or( "looks_like", std::string() );
        const std::string symbol = options.get_or( "symbol", std::string() );
        const utf8_wrapper wrapped( symbol );
        if( level.name.empty() || wrapped.size() != 1 ) {
            throw std::runtime_error(
                "overmap-vision appearance needs a name and one Unicode symbol" );
        }
        level.symbol = wrapped.at( 0 );
        definition->levels.push_back( std::move( level ) );
        return *this;
    }

    overmap_vision_definition_handle &blend_adjacent() {
        require_building_handle( token, *definition, "overmap vision" );
        overmap_vision_level_definition_data level;
        level.blends_adjacent = true;
        definition->levels.push_back( std::move( level ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "overmap vision" );
        return definition->id;
    }
};

struct overmap_location_definition_handle {
    std::shared_ptr<overmap_location_definition_data> definition;
    std::shared_ptr<owner_token> token;

    overmap_location_definition_handle &terrain( const std::string &terrain_id ) {
        require_building_handle( token, *definition, "overmap location" );
        if( terrain_id.empty() ) {
            throw std::runtime_error( "overmap-location terrain id cannot be empty" );
        }
        definition->terrains.push_back( terrain_id );
        return *this;
    }

    overmap_location_definition_handle &terrain_flag( const std::string &flag ) {
        require_building_handle( token, *definition, "overmap location" );
        if( flag.empty() ) {
            throw std::runtime_error( "overmap-location terrain flag cannot be empty" );
        }
        definition->terrain_flags.push_back( flag );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "overmap location" );
        return definition->id;
    }
};

struct profession_definition_handle {
    std::shared_ptr<profession_definition_data> definition;
    std::shared_ptr<owner_token> token;

    profession_definition_handle &items( const std::string &both,
                                         const std::string &male,
                                         const std::string &female ) {
        require_building_handle( token, *definition, "profession" );
        definition->items_both = both.empty() ? "EMPTY_GROUP" : both;
        definition->items_male = male.empty() ? "EMPTY_GROUP" : male;
        definition->items_female = female.empty() ? "EMPTY_GROUP" : female;
        return *this;
    }

    profession_definition_handle &requirement( const std::string &achievement ) {
        require_building_handle( token, *definition, "profession" );
        definition->requirements.push_back( achievement );
        return *this;
    }

    profession_definition_handle &skill( const std::string &skill,
                                          const std::int64_t level ) {
        require_building_handle( token, *definition, "profession" );
        definition->skills.emplace_back( skill, level );
        return *this;
    }

    profession_definition_handle &addiction( const std::string &type,
            const std::int64_t intensity ) {
        require_building_handle( token, *definition, "profession" );
        definition->addictions.push_back( { type, intensity } );
        return *this;
    }

    profession_definition_handle &cbm( const std::string &bionic ) {
        require_building_handle( token, *definition, "profession" );
        definition->cbms.push_back( bionic );
        return *this;
    }

    profession_definition_handle &proficiency( const std::string &proficiency ) {
        require_building_handle( token, *definition, "profession" );
        definition->proficiencies.push_back( proficiency );
        return *this;
    }

    profession_definition_handle &recipe( const std::string &recipe ) {
        require_building_handle( token, *definition, "profession" );
        definition->recipes.push_back( recipe );
        return *this;
    }

    profession_definition_handle &trait( const std::string &trait,
                                          const std::string &variant ) {
        require_building_handle( token, *definition, "profession" );
        definition->traits.push_back( { trait, variant } );
        return *this;
    }

    profession_definition_handle &forbid_trait( const std::string &trait ) {
        require_building_handle( token, *definition, "profession" );
        definition->forbidden_traits.push_back( trait );
        return *this;
    }

    profession_definition_handle &flag( const std::string &flag ) {
        require_building_handle( token, *definition, "profession" );
        definition->flags.push_back( flag );
        return *this;
    }

    profession_definition_handle &hobby( const std::string &profession ) {
        require_building_handle( token, *definition, "profession" );
        definition->hobbies.push_back( profession );
        return *this;
    }

    profession_definition_handle &martial_art( const std::string &style ) {
        require_building_handle( token, *definition, "profession" );
        definition->martial_arts.push_back( style );
        return *this;
    }

    profession_definition_handle &martial_art_choice( const std::string &style ) {
        require_building_handle( token, *definition, "profession" );
        definition->martial_arts_choices.push_back( style );
        return *this;
    }

    profession_definition_handle &pet( const std::string &monster,
                                        const std::int64_t amount ) {
        require_building_handle( token, *definition, "profession" );
        definition->pets.emplace_back( monster, amount );
        return *this;
    }

    profession_definition_handle &spell( const std::string &spell,
                                          const std::int64_t level ) {
        require_building_handle( token, *definition, "profession" );
        definition->spells.emplace_back( spell, level );
        return *this;
    }

    profession_definition_handle &mission( const std::string &mission ) {
        require_building_handle( token, *definition, "profession" );
        definition->missions.push_back( mission );
        return *this;
    }

    profession_definition_handle &on_start( const std::string &handler_id ) {
        require_building_handle( token, *definition, "profession" );
        if( handler_id.empty() ) {
            throw std::runtime_error(
                "profession start handler id cannot be empty" );
        }
        definition->start_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "profession" );
        return definition->id;
    }
};

struct profession_group_definition_handle {
    std::shared_ptr<profession_group_definition_data> definition;
    std::shared_ptr<owner_token> token;

    profession_group_definition_handle &profession( const std::string &profession_id ) {
        require_building_handle( token, *definition, "profession group" );
        if( profession_id.empty() ) {
            throw std::runtime_error( "profession-group entry id cannot be empty" );
        }
        definition->professions.push_back( profession_id );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "profession group" );
        return definition->id;
    }
};

struct widget_definition_handle {
    std::shared_ptr<widget_definition_data> definition;
    std::shared_ptr<owner_token> token;

    static widget_clause_definition_data parse_clause( const sol::table &options ) {
        widget_clause_definition_data clause;
        clause.id = options.get_or( "id", std::string() );
        clause.symbol = options.get_or( "symbol", options.get_or( "sym", std::string() ) );
        clause.text = options.get_or( "text", std::string() );
        clause.color = options.get_or( "color", std::string() );
        clause.value = options.get_or<std::int64_t>(
                           "value", std::numeric_limits<int>::min() );
        clause.condition_handler = options.get_or(
                                       "condition", options.get_or( "condition_handler", std::string() ) );
        clause.parse_tags = options.get_or( "parse_tags", false );
        if( const sol::optional<sol::table> children =
                options.get<sol::optional<sol::table>>( "widgets" ) ) {
            const std::size_t count = require_dense_array(
                                          *children, "widget clause children", 0, 1024 );
            clause.widgets.reserve( count );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::object value = children->raw_get<sol::object>( index );
                if( !value.is<std::string>() ) {
                    throw std::runtime_error( "widget clause children must contain widget ids" );
                }
                clause.widgets.push_back( value.as<std::string>() );
            }
        }
        return clause;
    }

    widget_definition_handle &bodypart( const std::string &bodypart ) {
        require_building_handle( token, *definition, "widget" );
        definition->bodyparts.push_back( bodypart );
        return *this;
    }

    widget_definition_handle &color( const std::string &color ) {
        require_building_handle( token, *definition, "widget" );
        definition->colors.push_back( color );
        return *this;
    }

    widget_definition_handle &break_at( const std::int64_t percentage ) {
        require_building_handle( token, *definition, "widget" );
        definition->breaks.push_back( percentage );
        return *this;
    }

    widget_definition_handle &child( const std::string &widget ) {
        require_building_handle( token, *definition, "widget" );
        definition->widgets.push_back( widget );
        return *this;
    }

    widget_definition_handle &flag( const std::string &flag ) {
        require_building_handle( token, *definition, "widget" );
        definition->flags.push_back( flag );
        return *this;
    }

    widget_definition_handle &clause( const sol::table &options ) {
        require_building_handle( token, *definition, "widget" );
        definition->clauses.push_back( parse_clause( options ) );
        return *this;
    }

    widget_definition_handle &default_clause( const sol::table &options ) {
        require_building_handle( token, *definition, "widget" );
        definition->default_clause = parse_clause( options );
        return *this;
    }

    widget_definition_handle &custom_value( const std::string &handler ) {
        require_building_handle( token, *definition, "widget" );
        definition->variable = "custom";
        definition->custom_handler = handler;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "widget" );
        return definition->id;
    }
};

struct enchantment_definition_handle {
    std::shared_ptr<enchantment_definition_data> definition;
    std::shared_ptr<owner_token> token;

    static enchantment_fake_spell_definition_data parse_spell( const sol::table &options ) {
        enchantment_fake_spell_definition_data spell;
        spell.spell = options.get_or( "id", options.get_or( "spell", std::string() ) );
        if( const sol::optional<std::int64_t> maximum =
                options.get<sol::optional<std::int64_t>>( "max_level" ) ) {
            spell.max_level = *maximum;
        }
        spell.level = options.get_or<std::int64_t>( "level", fake_spell::level_default );
        spell.self = options.get_or( "self", fake_spell::self_default );
        spell.trigger_once_in = options.get_or<std::int64_t>(
                                    "trigger_once_in", fake_spell::trigger_once_in_default );
        spell.trigger_message = options.get_or( "trigger_message", std::string() );
        spell.npc_trigger_message = options.get_or(
                                        "npc_trigger_message", std::string() );
        return spell;
    }

    enchantment_definition_handle &modifier( const std::string &kind,
            const std::string &target, const sol::table &options ) {
        require_building_handle( token, *definition, "enchantment" );
        enchantment_modifier_definition_data value;
        value.kind = kind;
        value.target = target;
        value.part = options.get_or( "part", std::string() );
        if( const sol::optional<double> add = options.get<sol::optional<double>>( "add" ) ) {
            value.add = *add;
        }
        if( const sol::optional<double> multiply =
                options.get<sol::optional<double>>( "multiply" ) ) {
            value.multiply = *multiply;
        }
        value.add_handler = options.get_or( "add_handler", std::string() );
        value.multiply_handler = options.get_or( "multiply_handler", std::string() );
        definition->modifiers.push_back( std::move( value ) );
        return *this;
    }

    enchantment_definition_handle &value( const std::string &target,
                                           const sol::table &options ) {
        return modifier( "value", target, options );
    }

    enchantment_definition_handle &skill( const std::string &target,
                                           const sol::table &options ) {
        return modifier( "skill", target, options );
    }

    enchantment_definition_handle &custom( const std::string &target,
                                            const sol::table &options ) {
        return modifier( "custom", target, options );
    }

    enchantment_definition_handle &encumbrance( const std::string &bodypart,
            const sol::table &options ) {
        return modifier( "encumbrance", bodypart, options );
    }

    enchantment_definition_handle &max_hp( const std::string &bodypart,
                                            const sol::table &options ) {
        return modifier( "max_hp", bodypart, options );
    }

    enchantment_definition_handle &limb_score( const std::string &score,
            const sol::table &options ) {
        return modifier( "limb_score", score, options );
    }

    enchantment_definition_handle &melee_damage( const std::string &damage_type,
            const sol::table &options ) {
        return modifier( "melee_damage", damage_type, options );
    }

    enchantment_definition_handle &incoming_damage( const std::string &damage_type,
            const sol::table &options ) {
        return modifier( "incoming_damage", damage_type, options );
    }

    enchantment_definition_handle &post_armor_damage( const std::string &damage_type,
            const sol::table &options ) {
        return modifier( "post_armor_damage", damage_type, options );
    }

    enchantment_definition_handle &effect( const std::string &effect,
                                            const std::int64_t intensity ) {
        require_building_handle( token, *definition, "enchantment" );
        definition->effects.emplace_back( effect, intensity );
        return *this;
    }

    enchantment_definition_handle &bodypart_change( const std::string &gain,
            const std::string &lose ) {
        require_building_handle( token, *definition, "enchantment" );
        definition->modified_bodyparts.emplace_back( gain, lose );
        return *this;
    }

    enchantment_definition_handle &mutation( const std::string &mutation ) {
        require_building_handle( token, *definition, "enchantment" );
        definition->mutations.push_back( mutation );
        return *this;
    }

    enchantment_definition_handle &hit_you( const sol::table &options ) {
        require_building_handle( token, *definition, "enchantment" );
        definition->hit_you_effects.push_back( parse_spell( options ) );
        return *this;
    }

    enchantment_definition_handle &hit_me( const sol::table &options ) {
        require_building_handle( token, *definition, "enchantment" );
        definition->hit_me_effects.push_back( parse_spell( options ) );
        return *this;
    }

    enchantment_definition_handle &every( const std::int64_t turns,
                                           const sol::table &options ) {
        require_building_handle( token, *definition, "enchantment" );
        definition->intermittent_effects.emplace_back( turns, parse_spell( options ) );
        return *this;
    }

    enchantment_definition_handle &vision( const sol::table &options ) {
        require_building_handle( token, *definition, "enchantment" );
        enchantment_vision_definition_data vision;
        vision.distance = options.get_or( "distance", 0.0 );
        vision.distance_handler = options.get_or( "distance_handler", std::string() );
        vision.condition_handler = options.get_or( "condition", options.get_or(
                                       "condition_handler", std::string() ) );
        vision.precise = options.get_or( "precise", false );
        vision.ignores_aiming_cone = options.get_or( "ignores_aiming_cone", false );
        if( const sol::optional<sol::table> descriptions =
                options.get<sol::optional<sol::table>>( "descriptions" ) ) {
            const std::size_t count = require_dense_array(
                                          *descriptions, "enchantment vision descriptions", 1, 256 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::object value = descriptions->raw_get<sol::object>( index );
                if( !value.is<sol::table>() ) {
                    throw std::runtime_error(
                        "enchantment vision descriptions must contain tables" );
                }
                const sol::table item = value.as<sol::table>();
                enchantment_vision_description_definition_data description;
                description.id = item.get_or( "id", description.id );
                description.color = item.get_or( "color", description.color );
                description.symbol = item.get_or(
                                         "symbol", item.get_or( "sym", description.symbol ) );
                description.text = item.get_or( "text", std::string() );
                description.condition_handler = item.get_or(
                                                    "condition", item.get_or( "condition_handler", std::string() ) );
                vision.descriptions.push_back( std::move( description ) );
            }
        }
        definition->visions.push_back( std::move( vision ) );
        return *this;
    }

    enchantment_definition_handle &active_when( const std::string &handler ) {
        require_building_handle( token, *definition, "enchantment" );
        definition->condition = "DIALOG_CONDITION";
        definition->condition_handler = handler;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "enchantment" );
        return definition->id;
    }
};

struct bionic_definition_handle {
    std::shared_ptr<bionic_definition_data> definition;
    std::shared_ptr<owner_token> token;

    bionic_definition_handle &activation_spell( const sol::table &options ) {
        require_building_handle( token, *definition, "bionic" );
        definition->activation_spell = enchantment_definition_handle::parse_spell( options );
        return *this;
    }

    bionic_definition_handle &fuel( const std::string &material ) {
        require_building_handle( token, *definition, "bionic" );
        definition->fuel_options.push_back( material );
        return *this;
    }

    bionic_definition_handle &enchantment( const std::string &enchantment ) {
        require_building_handle( token, *definition, "bionic" );
        definition->enchantments.push_back( enchantment );
        return *this;
    }

    bionic_definition_handle &martial_art( const std::string &style ) {
        require_building_handle( token, *definition, "bionic" );
        definition->martial_arts.push_back( style );
        return *this;
    }

    bionic_definition_handle &proficiency( const std::string &proficiency ) {
        require_building_handle( token, *definition, "bionic" );
        definition->proficiencies.push_back( proficiency );
        return *this;
    }

    bionic_definition_handle &passive_item( const std::string &item ) {
        require_building_handle( token, *definition, "bionic" );
        definition->passive_pseudo_items.push_back( item );
        return *this;
    }

    bionic_definition_handle &toggled_item( const std::string &item ) {
        require_building_handle( token, *definition, "bionic" );
        definition->toggled_pseudo_items.push_back( item );
        return *this;
    }

    bionic_definition_handle &cancel_mutation( const std::string &trait ) {
        require_building_handle( token, *definition, "bionic" );
        definition->canceled_mutations.push_back( trait );
        return *this;
    }

    bionic_definition_handle &include_bionic( const std::string &bionic ) {
        require_building_handle( token, *definition, "bionic" );
        definition->included_bionics.push_back( bionic );
        return *this;
    }

    bionic_definition_handle &auto_deactivate( const std::string &bionic ) {
        require_building_handle( token, *definition, "bionic" );
        definition->auto_deactivated_bionics.push_back( bionic );
        return *this;
    }

    bionic_definition_handle &flag( const std::string &flag,
                                     const std::string &state ) {
        require_building_handle( token, *definition, "bionic" );
        if( state.empty() || state == "always" ) {
            definition->flags.push_back( flag );
        } else if( state == "active" ) {
            definition->active_flags.push_back( flag );
        } else if( state == "inactive" ) {
            definition->inactive_flags.push_back( flag );
        } else {
            throw std::runtime_error( "bionic flag state must be always, active, or inactive" );
        }
        return *this;
    }

    bionic_definition_handle &environment_protection( const std::string &bodypart,
            const std::int64_t amount ) {
        require_building_handle( token, *definition, "bionic" );
        definition->environment_protection.emplace_back( bodypart, amount );
        return *this;
    }

    bionic_definition_handle &armor( const std::string &bodypart,
                                      const std::string &damage_type,
                                      const double amount ) {
        require_building_handle( token, *definition, "bionic" );
        definition->protection.push_back( { bodypart, damage_type, amount } );
        return *this;
    }

    bionic_definition_handle &occupies( const std::string &bodypart,
                                        const std::int64_t slots ) {
        require_building_handle( token, *definition, "bionic" );
        definition->occupied_bodyparts.emplace_back( bodypart, slots );
        return *this;
    }

    bionic_definition_handle &encumbers( const std::string &bodypart,
                                         const std::int64_t amount ) {
        require_building_handle( token, *definition, "bionic" );
        definition->encumbrance.emplace_back( bodypart, amount );
        return *this;
    }

    bionic_definition_handle &installable_weapon_flag( const std::string &flag ) {
        require_building_handle( token, *definition, "bionic" );
        definition->installable_weapon_flags.push_back( flag );
        return *this;
    }

    bionic_definition_handle &replace_bodypart( const std::string &bodypart ) {
        require_building_handle( token, *definition, "bionic" );
        definition->replaced_bodyparts.push_back( bodypart );
        return *this;
    }

    bionic_definition_handle &conflict_mutation( const std::string &trait ) {
        require_building_handle( token, *definition, "bionic" );
        definition->mutation_conflicts.push_back( trait );
        return *this;
    }

    bionic_definition_handle &give_mutation_when_removed( const std::string &trait ) {
        require_building_handle( token, *definition, "bionic" );
        definition->give_mutation_on_removal.push_back( trait );
        return *this;
    }

    bionic_definition_handle &learn_spell( const std::string &spell,
                                            const std::int64_t level ) {
        require_building_handle( token, *definition, "bionic" );
        definition->learned_spells.emplace_back( spell, level );
        return *this;
    }

    bionic_definition_handle &available_upgrade( const std::string &bionic ) {
        require_building_handle( token, *definition, "bionic" );
        definition->available_upgrades.push_back( bionic );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "bionic" );
        return definition->id;
    }
};

struct spell_definition_handle {
    std::shared_ptr<spell_definition_data> definition;
    std::shared_ptr<owner_token> token;

    spell_definition_handle &target( const std::string &target ) {
        require_building_handle( token, *definition, "spell" );
        definition->valid_targets.push_back( target );
        return *this;
    }

    spell_definition_handle &flag( const std::string &flag ) {
        require_building_handle( token, *definition, "spell" );
        definition->flags.push_back( flag );
        return *this;
    }

    spell_definition_handle &target_monster( const std::string &monster ) {
        require_building_handle( token, *definition, "spell" );
        definition->targeted_monsters.push_back( monster );
        return *this;
    }

    spell_definition_handle &target_species( const std::string &species ) {
        require_building_handle( token, *definition, "spell" );
        definition->targeted_species.push_back( species );
        return *this;
    }

    spell_definition_handle &ignore_species( const std::string &species ) {
        require_building_handle( token, *definition, "spell" );
        definition->ignored_species.push_back( species );
        return *this;
    }

    spell_definition_handle &bodypart( const std::string &bodypart ) {
        require_building_handle( token, *definition, "spell" );
        definition->affected_bodyparts.push_back( bodypart );
        return *this;
    }

    spell_definition_handle &extra_spell( const sol::table &options ) {
        require_building_handle( token, *definition, "spell" );
        definition->additional_spells.push_back(
            enchantment_definition_handle::parse_spell( options ) );
        return *this;
    }

    spell_definition_handle &learn_spell( const std::string &spell,
                                           const std::int64_t level ) {
        require_building_handle( token, *definition, "spell" );
        definition->learned_spells.emplace_back( spell, level );
        return *this;
    }

    spell_definition_handle &stat( const std::string &name, const double value ) {
        require_building_handle( token, *definition, "spell" );
        const auto found = definition->stats.find( name );
        if( found == definition->stats.end() ) {
            throw std::runtime_error( "unknown spell stat '" + name + "'" );
        }
        found->second = value;
        definition->stat_maximums.erase( name );
        definition->stat_handlers.erase( name );
        return *this;
    }

    spell_definition_handle &stat_range( const std::string &name,
                                          const double minimum,
                                          const double maximum ) {
        require_building_handle( token, *definition, "spell" );
        const auto found = definition->stats.find( name );
        if( found == definition->stats.end() ) {
            throw std::runtime_error( "unknown spell stat '" + name + "'" );
        }
        found->second = minimum;
        definition->stat_maximums[name] = maximum;
        definition->stat_handlers.erase( name );
        return *this;
    }

    spell_definition_handle &dynamic_stat( const std::string &name,
                                            const std::string &handler ) {
        require_building_handle( token, *definition, "spell" );
        if( definition->stats.count( name ) == 0 ) {
            throw std::runtime_error( "unknown spell stat '" + name + "'" );
        }
        definition->stat_maximums.erase( name );
        definition->stat_handlers[name] = handler;
        return *this;
    }

    spell_definition_handle &lua_effect( const std::string &handler ) {
        require_building_handle( token, *definition, "spell" );
        definition->effect = "lua";
        definition->effect_handler = handler;
        return *this;
    }

    spell_definition_handle &caster_when( const std::string &handler,
                                           const std::string &failure_message ) {
        require_building_handle( token, *definition, "spell" );
        definition->caster_condition_handler = handler;
        definition->caster_condition_fail_message = failure_message;
        return *this;
    }

    spell_definition_handle &target_when( const std::string &handler,
                                           const std::string &failure_message ) {
        require_building_handle( token, *definition, "spell" );
        definition->target_condition_handler = handler;
        definition->target_condition_fail_message = failure_message;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "spell" );
        return definition->id;
    }
};

struct mission_definition_handle {
    std::shared_ptr<mission_definition_data> definition;
    std::shared_ptr<owner_token> token;

    mission_definition_handle &origin( const std::string &origin ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->origins.push_back( origin );
        return *this;
    }

    mission_definition_handle &dialogue( const std::string &phase,
                                          const std::string &text ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->dialogue[phase] = text;
        return *this;
    }

    mission_definition_handle &reward( const double value,
                                        const std::string &description ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->likely_rewards.emplace_back( value, description );
        return *this;
    }

    mission_definition_handle &deadline( const std::int64_t minimum_turns,
                                          const sol::optional<std::int64_t> &maximum_turns ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->deadline_min_turns = minimum_turns;
        definition->deadline_max_turns = maximum_turns ?
                std::optional<std::int64_t>( *maximum_turns ) : std::nullopt;
        definition->deadline_handler.clear();
        return *this;
    }

    mission_definition_handle &dynamic_deadline( const std::string &handler ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->deadline_handler = handler;
        definition->deadline_max_turns.reset();
        return *this;
    }

    mission_definition_handle &place_when( const std::string &handler ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->place_handler = handler;
        return *this;
    }

    mission_definition_handle &start_with( const std::string &handler ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->start_handler = handler;
        return *this;
    }

    mission_definition_handle &finish_with( const std::string &handler ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->end_handler = handler;
        return *this;
    }

    mission_definition_handle &fail_with( const std::string &handler ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->fail_handler = handler;
        return *this;
    }

    mission_definition_handle &complete_when( const std::string &handler ) {
        require_building_handle( token, *definition, "mission definition" );
        definition->goal = "MGOAL_CONDITION";
        definition->goal_condition_handler = handler;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "mission definition" );
        return definition->id;
    }
};

struct mutation_definition_handle {
    std::shared_ptr<mutation_definition_data> definition;
    std::shared_ptr<owner_token> token;

    mutation_definition_handle &variant( const sol::table &options ) {
        require_building_handle( token, *definition, "mutation" );
        mutation_variant_definition_data value;
        value.id = options.get_or( "id", std::string() );
        value.name = options.get_or( "name", std::string() );
        value.description = options.get_or( "description", std::string() );
        value.append_description = options.get_or(
                                       "append_description", options.get_or( "append_desc", false ) );
        value.weight = options.get_or<std::int64_t>( "weight", 0 );
        definition->variants.push_back( std::move( value ) );
        return *this;
    }

    mutation_definition_handle &transform( const sol::table &options ) {
        require_building_handle( token, *definition, "mutation" );
        mutation_transform_definition_data value;
        value.target = options.get_or( "target", std::string() );
        value.message = options.get_or(
                            "message", options.get_or( "msg_transform", std::string() ) );
        value.active = options.get_or( "active", false );
        value.safe = options.get_or( "safe", false );
        value.moves = options.get_or<std::int64_t>( "moves", 0 );
        definition->transform = std::move( value );
        return *this;
    }

    mutation_definition_handle &personality( const sol::table &options ) {
        require_building_handle( token, *definition, "mutation" );
        mutation_personality_definition_data value;
        value.min_aggression = options.get_or<std::int64_t>(
                                   "min_aggression", value.min_aggression );
        value.max_aggression = options.get_or<std::int64_t>(
                                   "max_aggression", value.max_aggression );
        value.min_bravery = options.get_or<std::int64_t>(
                                "min_bravery", value.min_bravery );
        value.max_bravery = options.get_or<std::int64_t>(
                                "max_bravery", value.max_bravery );
        value.min_collector = options.get_or<std::int64_t>(
                                  "min_collector", value.min_collector );
        value.max_collector = options.get_or<std::int64_t>(
                                  "max_collector", value.max_collector );
        value.min_altruism = options.get_or<std::int64_t>(
                                "min_altruism", value.min_altruism );
        value.max_altruism = options.get_or<std::int64_t>(
                                "max_altruism", value.max_altruism );
        definition->personality = value;
        return *this;
    }

    mutation_definition_handle &relationship( const std::string &kind,
            const std::string &id ) {
        require_building_handle( token, *definition, "mutation" );
        static const std::map<std::string, std::vector<std::string> mutation_definition_data::*>
        fields = {
            { "threshold_substitute", &mutation_definition_data::threshold_substitutes },
            { "ignored_by", &mutation_definition_data::ignored_by },
            { "empathize_with", &mutation_definition_data::empathize_with },
            { "no_empathize_with", &mutation_definition_data::no_empathize_with },
            { "can_only_eat", &mutation_definition_data::can_only_eat },
            { "can_only_heal_with", &mutation_definition_data::can_only_heal_with },
            { "can_heal_with", &mutation_definition_data::can_heal_with },
            { "allowed_category", &mutation_definition_data::allowed_categories },
            { "prereq", &mutation_definition_data::prereqs },
            { "prereq2", &mutation_definition_data::prereqs2 },
            { "threshold_requirement", &mutation_definition_data::threshold_requirements },
            { "cancel", &mutation_definition_data::cancels },
            { "replace_with", &mutation_definition_data::replacements },
            { "lead_to", &mutation_definition_data::additions },
            { "flag", &mutation_definition_data::flags },
            { "active_flag", &mutation_definition_data::active_flags },
            { "inactive_flag", &mutation_definition_data::inactive_flags },
            { "type", &mutation_definition_data::types },
            { "enchantment", &mutation_definition_data::enchantments },
            { "no_cbm_bodypart", &mutation_definition_data::no_cbm_bodyparts },
            { "category", &mutation_definition_data::categories },
            { "restricts_gear", &mutation_definition_data::restricts_gear },
            { "remove_rigid", &mutation_definition_data::remove_rigid },
            { "allowed_item_flag", &mutation_definition_data::allowed_item_flags },
            { "integrated_armor", &mutation_definition_data::integrated_armor },
            { "martial_art", &mutation_definition_data::initial_martial_arts }
        };
        const auto found = fields.find( kind );
        if( found == fields.end() ) {
            throw std::runtime_error( "unknown mutation relationship kind '" + kind + "'" );
        }
        ( definition.get()->*( found->second ) ).push_back( id );
        return *this;
    }

    mutation_definition_handle &integer_value( const std::string &kind,
            const std::string &id, const std::int64_t amount ) {
        require_building_handle( token, *definition, "mutation" );
        static const std::map<std::string,
               std::vector<std::pair<std::string, std::int64_t>> mutation_definition_data::*>
        fields = {
            { "quality", &mutation_definition_data::provided_qualities },
            { "vitamin_rate", &mutation_definition_data::vitamin_rates },
            { "monster_camera", &mutation_definition_data::monster_cameras },
            { "spell", &mutation_definition_data::learned_spells },
            { "craft_skill_bonus", &mutation_definition_data::craft_skill_bonuses },
            { "anger_relation", &mutation_definition_data::anger_relations },
            { "encumbrance_always", &mutation_definition_data::encumbrance_always },
            { "encumbrance_covered", &mutation_definition_data::encumbrance_covered },
            { "bionic_slot_bonus", &mutation_definition_data::bionic_slot_bonuses }
        };
        const auto found = fields.find( kind );
        if( found == fields.end() ) {
            throw std::runtime_error( "unknown mutation integer-value kind '" + kind + "'" );
        }
        ( definition.get()->*( found->second ) ).emplace_back( id, amount );
        return *this;
    }

    mutation_definition_handle &decimal_value( const std::string &kind,
            const std::string &id, const double amount ) {
        require_building_handle( token, *definition, "mutation" );
        if( kind == "lumination" ) {
            definition->lumination.emplace_back( id, amount );
        } else if( kind == "encumbrance_multiplier" ) {
            definition->encumbrance_multipliers.emplace_back( id, amount );
        } else {
            throw std::runtime_error( "unknown mutation decimal-value kind '" + kind + "'" );
        }
        return *this;
    }

    mutation_definition_handle &vitamin_absorption( const std::string &material,
            const std::string &vitamin, const double multiplier ) {
        require_building_handle( token, *definition, "mutation" );
        definition->vitamin_absorption.emplace_back( material, vitamin, multiplier );
        return *this;
    }

    mutation_definition_handle &wet_protection( const std::string &bodypart,
            const std::int64_t ignored, const std::int64_t neutral,
            const std::int64_t good ) {
        require_building_handle( token, *definition, "mutation" );
        definition->wet_protection.push_back( { bodypart, ignored, neutral, good } );
        return *this;
    }

    mutation_definition_handle &armor( const std::string &bodypart,
                                        const std::string &damage_type,
                                        const double amount ) {
        require_building_handle( token, *definition, "mutation" );
        definition->armor.push_back( { bodypart, damage_type, amount } );
        return *this;
    }

    static mutation_damage_definition_data parse_damage( const sol::table &options ) {
        mutation_damage_definition_data damage;
        damage.damage_type = options.get_or(
                                 "damage_type", options.get_or( "type", std::string() ) );
        damage.amount = options.get_or( "amount", 0.0 );
        damage.armor_penetration = options.get_or(
                                      "armor_penetration", options.get_or( "arpen", 0.0 ) );
        damage.armor_penetration_multiplier = options.get_or(
                    "armor_penetration_multiplier", options.get_or( "arpen_mult", 1.0 ) );
        damage.damage_multiplier = options.get_or(
                                       "damage_multiplier", options.get_or( "damage_mult", 1.0 ) );
        damage.unconditional_armor_penetration_multiplier = options.get_or(
                    "unconditional_armor_penetration_multiplier",
                    options.get_or( "unc_arpen_mult", 1.0 ) );
        damage.unconditional_damage_multiplier = options.get_or(
                    "unconditional_damage_multiplier", options.get_or( "unc_damage_mult", 1.0 ) );
        return damage;
    }

    mutation_definition_handle &attack( const sol::table &options ) {
        require_building_handle( token, *definition, "mutation" );
        mutation_attack_definition_data attack;
        attack.player_message = options.get_or(
                                    "player_message", options.get_or( "attack_text_u", std::string() ) );
        attack.npc_message = options.get_or(
                                 "npc_message", options.get_or( "attack_text_npc", std::string() ) );
        attack.bodypart = options.get_or(
                              "bodypart", options.get_or( "body_part", std::string() ) );
        attack.chance = options.get_or<std::int64_t>( "chance", 0 );
        attack.hardcoded = options.get_or(
                               "hardcoded", options.get_or( "hardcoded_effect", false ) );
        const auto read_strings = [&options]( const char *key, std::vector<std::string> &result ) {
            const sol::optional<sol::table> values =
                options.get<sol::optional<sol::table>>( key );
            if( !values ) {
                return;
            }
            const std::size_t count = require_dense_array(
                                          *values, std::string( "mutation attack " ) + key, 0, 256 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::object value = values->raw_get<sol::object>( index );
                if( !value.is<std::string>() ) {
                    throw std::runtime_error( "mutation attack id lists require strings" );
                }
                result.push_back( value.as<std::string>() );
            }
        };
        read_strings( "required_mutations", attack.required_mutations );
        read_strings( "blocker_mutations", attack.blocker_mutations );
        const auto read_damage = [&options]( const char *key,
        std::vector<mutation_damage_definition_data> &result ) {
            const sol::optional<sol::table> values =
                options.get<sol::optional<sol::table>>( key );
            if( !values ) {
                return;
            }
            const std::size_t count = require_dense_array(
                                          *values, std::string( "mutation attack " ) + key, 0, 64 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::object value = values->raw_get<sol::object>( index );
                if( !value.is<sol::table>() ) {
                    throw std::runtime_error( "mutation attack damage requires tables" );
                }
                result.push_back( parse_damage( value.as<sol::table>() ) );
            }
        };
        read_damage( "base_damage", attack.base_damage );
        read_damage( "strength_damage", attack.strength_damage );
        definition->attacks.push_back( std::move( attack ) );
        return *this;
    }

    mutation_definition_handle &reflex( const sol::table &options ) {
        require_building_handle( token, *definition, "mutation" );
        std::vector<mutation_reflex_definition_data> group;
        const sol::optional<sol::table> entries =
            options.get<sol::optional<sol::table>>( "conditions" );
        const sol::table source = entries ? *entries : options;
        const std::size_t count = require_dense_array(
                                      source, "mutation reflex conditions", 1, 64 );
        group.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object object = source.raw_get<sol::object>( index );
            if( !object.is<sol::table>() ) {
                throw std::runtime_error( "mutation reflex conditions require tables" );
            }
            const sol::table entry = object.as<sol::table>();
            mutation_reflex_definition_data condition;
            condition.handler = entry.get_or(
                                    "handler", entry.get_or( "condition", std::string() ) );
            condition.message_on = entry.get_or( "message_on", entry.get_or(
                                       "msg_on", std::string() ) );
            condition.message_on_type = entry.get_or(
                                            "message_on_type", entry.get_or( "msg_on_type", std::string( "neutral" ) ) );
            condition.message_off = entry.get_or( "message_off", entry.get_or(
                                        "msg_off", std::string() ) );
            condition.message_off_type = entry.get_or(
                                             "message_off_type", entry.get_or( "msg_off_type", std::string( "neutral" ) ) );
            group.push_back( std::move( condition ) );
        }
        definition->reflex_triggers.push_back( std::move( group ) );
        return *this;
    }

    mutation_definition_handle &comfort( const sol::table &options ) {
        require_building_handle( token, *definition, "mutation" );
        mutation_comfort_definition_data value;
        value.conditions_or = options.get_or( "conditions_or", false );
        value.base_comfort = options.get_or<std::int64_t>( "base_comfort", 0 );
        value.add_human_comfort = options.get_or( "add_human_comfort", false );
        value.use_better_comfort = options.get_or( "use_better_comfort", false );
        value.add_sleep_aids = options.get_or( "add_sleep_aids", false );
        value.try_message = options.get_or( "try_message", std::string() );
        value.try_message_type = options.get_or( "try_message_type", std::string( "neutral" ) );
        value.hint_message = options.get_or( "hint_message", std::string() );
        value.hint_message_type = options.get_or( "hint_message_type", std::string( "neutral" ) );
        value.sleep_message = options.get_or( "sleep_message", std::string() );
        value.sleep_message_type = options.get_or( "sleep_message_type", std::string( "neutral" ) );
        if( const sol::optional<sol::table> conditions =
                options.get<sol::optional<sol::table>>( "conditions" ) ) {
            const std::size_t count = require_dense_array(
                                          *conditions, "mutation comfort conditions", 0, 64 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::object object = conditions->raw_get<sol::object>( index );
                if( !object.is<sol::table>() ) {
                    throw std::runtime_error( "mutation comfort conditions require tables" );
                }
                const sol::table condition = object.as<sol::table>();
                mutation_comfort_condition_definition_data parsed;
                parsed.type = condition.get_or( "type", std::string() );
                parsed.id = condition.get_or( "id", std::string() );
                parsed.flag = condition.get_or( "flag", std::string() );
                parsed.intensity = condition.get_or<std::int64_t>( "intensity", 1 );
                parsed.active = condition.get_or( "active", false );
                parsed.invert = condition.get_or( "invert", false );
                value.conditions.push_back( std::move( parsed ) );
            }
        }
        definition->comfort.push_back( std::move( value ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "mutation" );
        return definition->id;
    }
};

struct profession_item_substitution_definition_handle {
    std::shared_ptr<profession_item_substitution_definition_data> definition;
    std::shared_ptr<owner_token> token;

    static std::vector<std::string> traits( const sol::table &options,
                                            const std::string &key ) {
        const sol::optional<sol::table> values =
            options.get<sol::optional<sol::table>>( key );
        if( !values ) {
            return {};
        }
        const std::size_t count = require_dense_array(
                                      *values, "profession item substitution " + key, 0, 64 );
        std::vector<std::string> result;
        result.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = values->raw_get<sol::object>( index );
            if( !value.is<std::string>() ) {
                throw std::runtime_error(
                    "profession item substitution trait lists require strings" );
            }
            result.push_back( value.as<std::string>() );
        }
        return result;
    }

    profession_item_substitution_definition_handle &when(
        const sol::table &conditions, const sol::table &replacements ) {
        require_building_handle( token, *definition, "profession item substitution" );
        if( definition->rules.size() >= 256 ) {
            throw std::runtime_error(
                "profession item substitution exceeds the Platform rule limit" );
        }
        detail::profession_item_substitution_native_rule rule;
        rule.requirements.present = traits( conditions, "present" );
        rule.requirements.absent = traits( conditions, "absent" );
        const std::size_t count = require_dense_array(
                                      replacements,
                                      "profession item substitution replacements", 1, 64 );
        rule.replacements.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = replacements.raw_get<sol::object>( index );
            detail::profession_item_substitution_native_replacement replacement;
            if( value.is<std::string>() ) {
                replacement.item = value.as<std::string>();
            } else if( value.is<sol::table>() ) {
                const sol::table options = value.as<sol::table>();
                replacement.item = options.get_or( "item", std::string() );
                replacement.ratio = options.get_or( "ratio", 1.0 );
            } else {
                throw std::runtime_error(
                    "profession item replacements require item ids or option tables" );
            }
            rule.replacements.push_back( std::move( replacement ) );
        }
        definition->rules.push_back( std::move( rule ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "profession item substitution" );
        return definition->id;
    }
};

struct profession_item_bonus_definition_handle {
    std::shared_ptr<profession_item_bonus_definition_data> definition;
    std::shared_ptr<owner_token> token;

    profession_item_bonus_definition_handle &when( const sol::table &conditions ) {
        require_building_handle( token, *definition, "profession item bonus" );
        if( definition->requirements.size() >= 256 ) {
            throw std::runtime_error(
                "profession item bonus exceeds the Platform condition limit" );
        }
        detail::profession_item_substitution_native_requirement requirements;
        requirements.present = profession_item_substitution_definition_handle::traits(
                                   conditions, "present" );
        requirements.absent = profession_item_substitution_definition_handle::traits(
                                  conditions, "absent" );
        definition->requirements.push_back( std::move( requirements ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "profession item bonus" );
        return definition->id;
    }
};

struct map_extra_collection_definition_handle {
    std::shared_ptr<map_extra_collection_definition_data> definition;
    std::shared_ptr<owner_token> token;

    map_extra_collection_definition_handle &extra( const std::string &extra_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "map-extra collection" );
        if( extra_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "map-extra collection entries need an id and positive weight" );
        }
        definition->entries.emplace_back( extra_id, weight );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "map-extra collection" );
        return definition->id;
    }
};

struct vehicle_group_definition_handle {
    std::shared_ptr<vehicle_group_definition_data> definition;
    std::shared_ptr<owner_token> token;

    vehicle_group_definition_handle &vehicle( const std::string &vehicle_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "vehicle group" );
        if( vehicle_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "vehicle-group entries need an id and positive weight" );
        }
        definition->entries.emplace_back( vehicle_id, weight );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "vehicle group" );
        return definition->id;
    }
};

struct vehicle_placement_definition_handle {
    std::shared_ptr<vehicle_placement_definition_data> definition;
    std::shared_ptr<owner_token> token;

    static std::pair<std::int64_t, std::int64_t> coordinate_range(
        const sol::object &value, const std::string_view axis ) {
        if( value.is<std::int64_t>() ) {
            const std::int64_t coordinate = value.as<std::int64_t>();
            return { coordinate, coordinate };
        }
        if( value.is<sol::table>() ) {
            const sol::table range = value.as<sol::table>();
            require_dense_array( range, "vehicle placement " + std::string( axis ) + " range",
                                 2, 2 );
            return { range.raw_get<std::int64_t>( 1 ), range.raw_get<std::int64_t>( 2 ) };
        }
        throw std::runtime_error( "vehicle placement " + std::string( axis ) +
                                  " must be an integer or two-value range" );
    }

    static std::vector<std::int64_t> facing_values( const sol::object &facing ) {
        std::vector<std::int64_t> result;
        if( facing.is<std::int64_t>() ) {
            result.push_back( facing.as<std::int64_t>() );
            return result;
        }
        if( facing.is<sol::table>() ) {
            const sol::table facings = facing.as<sol::table>();
            const std::size_t count = require_dense_array(
                                          facings, "vehicle facings", 1, 64 );
            result.reserve( count );
            for( std::size_t index = 1; index <= count; ++index ) {
                result.push_back( facings.raw_get<std::int64_t>( index ) );
            }
            return result;
        }
        throw std::runtime_error( "vehicle facings must be an integer or dense array" );
    }

    vehicle_placement_definition_handle &location( const sol::table &options ) {
        require_building_handle( token, *definition, "vehicle placement" );
        if( definition->locations.size() >= 1024 ) {
            throw std::runtime_error( "vehicle placement exceeds the Platform location limit" );
        }
        const auto [x_min, x_max] = coordinate_range(
                                        options.raw_get<sol::object>( "x" ), "x" );
        const auto [y_min, y_max] = coordinate_range(
                                        options.raw_get<sol::object>( "y" ), "y" );
        vehicle_placement_location_definition_data value;
        value.x_min = x_min;
        value.x_max = x_max;
        value.y_min = y_min;
        value.y_max = y_max;
        value.facings = facing_values( options.raw_get<sol::object>( "facings" ) );
        definition->locations.push_back( std::move( value ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "vehicle placement" );
        return definition->id;
    }
};

struct vehicle_spawn_definition_handle {
    std::shared_ptr<vehicle_spawn_definition_data> definition;
    std::shared_ptr<owner_token> token;

    vehicle_spawn_definition_handle &builtin( const std::string &function_id,
            const double weight ) {
        require_building_handle( token, *definition, "vehicle spawn" );
        vehicle_spawn_entry_definition_data value;
        value.builtin = true;
        value.weight = weight;
        value.builtin_id = function_id;
        definition->entries.push_back( std::move( value ) );
        return *this;
    }

    vehicle_spawn_definition_handle &vehicle( const std::string &group_id,
            const double weight, const sol::table &options ) {
        require_building_handle( token, *definition, "vehicle spawn" );
        vehicle_spawn_entry_definition_data value;
        value.weight = weight;
        value.vehicle_group = group_id;
        const sol::object number = options.raw_get<sol::object>( "number" );
        if( number.valid() && number.get_type() != sol::type::lua_nil &&
            number.get_type() != sol::type::none ) {
            const auto [minimum, maximum] =
                vehicle_placement_definition_handle::coordinate_range( number, "number" );
            value.number_min = minimum;
            value.number_max = maximum;
        }
        value.fuel = options.get_or<std::int64_t>( "fuel", -1 );
        value.status = options.get_or<std::int64_t>( "status", -1 );
        value.placement = options.get_or( "placement", std::string() );
        if( const sol::optional<sol::table> location =
                options.get<sol::optional<sol::table>>( "location" ) ) {
            vehicle_placement_location_definition_data position;
            const auto [x_min, x_max] =
                vehicle_placement_definition_handle::coordinate_range(
                    location->raw_get<sol::object>( "x" ), "x" );
            const auto [y_min, y_max] =
                vehicle_placement_definition_handle::coordinate_range(
                    location->raw_get<sol::object>( "y" ), "y" );
            position.x_min = x_min;
            position.x_max = x_max;
            position.y_min = y_min;
            position.y_max = y_max;
            position.facings = vehicle_placement_definition_handle::facing_values(
                                   location->raw_get<sol::object>( "facings" ) );
            value.location = std::move( position );
        }
        definition->entries.push_back( std::move( value ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "vehicle spawn" );
        return definition->id;
    }
};

struct fault_group_definition_handle {
    std::shared_ptr<fault_group_definition_data> definition;
    std::shared_ptr<owner_token> token;

    fault_group_definition_handle &fault( const std::string &fault_id,
                                          const std::int64_t weight ) {
        require_building_handle( token, *definition, "fault group" );
        if( fault_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "fault-group entries need an id and positive weight" );
        }
        definition->entries.emplace_back( fault_id, weight );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "fault group" );
        return definition->id;
    }
};

struct explosion_light_definition_handle {
    std::shared_ptr<explosion_light_definition_data> definition;
    std::shared_ptr<owner_token> token;

    explosion_light_definition_handle &stop( const std::int64_t red,
            const std::int64_t green, const std::int64_t blue,
            const std::int64_t alpha ) {
        require_building_handle( token, *definition, "explosion light" );
        const auto component = []( const std::int64_t value, const char *name ) {
            if( value < 0 || value > 255 ) {
                throw std::runtime_error( std::string( "explosion-light " ) + name +
                                          " must be from zero through 255" );
            }
            return static_cast<std::uint8_t>( value );
        };
        light_stop value;
        value.color = { {
                component( red, "red" ), component( green, "green" ),
                component( blue, "blue" )
            }
        };
        value.alpha = component( alpha, "alpha" );
        definition->stops.push_back( value );
        return *this;
    }

    explosion_light_definition_handle &waves( const sol::table &options ) {
        require_building_handle( token, *definition, "explosion light" );
        definition->wave_travel = options.get_or( "travel", definition->wave_travel );
        definition->wave_gap = options.get_or( "gap", definition->wave_gap );
        definition->rise = options.get_or( "rise", definition->rise );
        definition->fade = options.get_or( "fade", definition->fade );
        definition->blend = options.get_or( "blend", definition->blend );
        definition->spread_jitter = options.get_or(
                                        "spread_jitter", definition->spread_jitter );
        definition->color_jitter = options.get_or(
                                       "color_jitter", definition->color_jitter );
        definition->flicker = options.get_or( "flicker", definition->flicker );
        definition->easing = options.get_or( "easing", definition->easing );
        return *this;
    }

    explosion_light_definition_handle &duration( const sol::table &options ) {
        require_building_handle( token, *definition, "explosion light" );
        definition->duration_base_ms = options.get_or(
                                           "base_ms", definition->duration_base_ms );
        definition->duration_per_tile_ms = options.get_or(
                                               "per_tile_ms", definition->duration_per_tile_ms );
        definition->duration_min_ms = options.get_or(
                                          "minimum_ms", definition->duration_min_ms );
        definition->duration_max_ms = options.get_or(
                                          "maximum_ms", definition->duration_max_ms );
        return *this;
    }

    explosion_light_definition_handle &screen_shake( const double magnitude,
            const double duration_ms ) {
        require_building_handle( token, *definition, "explosion light" );
        definition->screen_shake_magnitude = magnitude;
        definition->screen_shake_duration_ms = duration_ms;
        return *this;
    }

    explosion_light_definition_handle &shockwave( const sol::table &options ) {
        require_building_handle( token, *definition, "explosion light" );
        definition->shockwave = options.get_or( "enabled", true );
        definition->shockwave_strength = options.get_or(
                                             "strength", definition->shockwave_strength );
        definition->shockwave_speed = options.get_or(
                                          "speed", definition->shockwave_speed );
        definition->shockwave_thickness = options.get_or(
                                              "thickness", definition->shockwave_thickness );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "explosion light" );
        return definition->id;
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

struct addiction_type_definition_handle {
    std::shared_ptr<addiction_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    addiction_type_definition_handle &tick_policy( const std::string &handler_id ) {
        require_building_handle( token, *definition, "addiction type" );
        definition->tick_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "addiction type" );
        return definition->id;
    }
};

struct character_modifier_definition_handle {
    std::shared_ptr<character_modifier_definition_data> definition;
    std::shared_ptr<owner_token> token;

    character_modifier_definition_handle &evaluate_with( const std::string &handler_id ) {
        require_building_handle( token, *definition, "character modifier" );
        definition->evaluator_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "character modifier" );
        return definition->id;
    }
};

struct start_location_definition_handle {
    std::shared_ptr<start_location_definition_data> definition;
    std::shared_ptr<owner_token> token;

    start_location_definition_handle &terrain( const std::string &terrain_id,
            const sol::optional<sol::table> &options ) {
        require_building_handle( token, *definition, "start location" );
        start_location_target_definition_data value;
        value.terrain = terrain_id;
        if( options ) {
            value.match = options->get_or( "match", std::string( "type" ) );
            const sol::object raw_parameters = options->raw_get<sol::object>( "parameters" );
            if( raw_parameters.valid() && raw_parameters.get_type() != sol::type::nil ) {
                if( raw_parameters.get_type() != sol::type::table ) {
                    throw std::runtime_error( "start-location parameters must be a string table" );
                }
                for( const auto &entry : raw_parameters.as<sol::table>() ) {
                    if( !entry.first.is<std::string>() || !entry.second.is<std::string>() ) {
                        throw std::runtime_error(
                            "start-location parameter keys and values must be strings" );
                    }
                    value.parameters.emplace( entry.first.as<std::string>(),
                                              entry.second.as<std::string>() );
                }
            }
        }
        definition->targets.push_back( std::move( value ) );
        return *this;
    }

    start_location_definition_handle &flag( const std::string &flag_id ) {
        require_building_handle( token, *definition, "start location" );
        if( flag_id.empty() || !definition->flags.insert( flag_id ).second ) {
            throw std::runtime_error( "start-location flags must be non-empty and unique" );
        }
        return *this;
    }

    start_location_definition_handle &city_size( const std::int64_t minimum,
            const std::int64_t maximum ) {
        require_building_handle( token, *definition, "start location" );
        definition->city_size_min = minimum;
        definition->city_size_max = maximum;
        return *this;
    }

    start_location_definition_handle &city_distance( const std::int64_t minimum,
            const std::int64_t maximum ) {
        require_building_handle( token, *definition, "start location" );
        definition->city_distance_min = minimum;
        definition->city_distance_max = maximum;
        return *this;
    }

    start_location_definition_handle &z_levels( const std::int64_t minimum,
            const std::int64_t maximum ) {
        require_building_handle( token, *definition, "start location" );
        definition->z_min = minimum;
        definition->z_max = maximum;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "start location" );
        return definition->id;
    }
};

struct climbing_aid_definition_handle {
    std::shared_ptr<climbing_aid_definition_data> definition;
    std::shared_ptr<owner_token> token;

    climbing_aid_definition_handle &available_when( const sol::table &options ) {
        require_building_handle( token, *definition, "climbing aid" );
        definition->category = options.get_or( "category", std::string() );
        definition->flag = options.get_or( "flag", std::string() );
        definition->uses = options.get_or<std::int64_t>( "uses", 0 );
        definition->range = options.get_or<std::int64_t>( "range", 1 );
        return *this;
    }

    climbing_aid_definition_handle &descent( const sol::table &options ) {
        require_building_handle( token, *definition, "climbing aid" );
        definition->max_height = options.get_or<std::int64_t>( "max_height", 1 );
        definition->easy_climb_back_up = options.get_or<std::int64_t>(
                                             "easy_climb_back_up", 0 );
        definition->allow_remaining_height = options.get_or(
                "allow_remaining_height", true );
        definition->menu_text = options.get_or( "menu_text", std::string() );
        definition->unavailable_text = options.get_or(
                                           "unavailable_text", std::string() );
        definition->hotkey = options.get_or( "hotkey", std::string() );
        definition->confirm_text = options.get_or( "confirm_text", std::string() );
        definition->before_message = options.get_or(
                                         "before_message", std::string() );
        definition->after_message = options.get_or( "after_message", std::string() );
        return *this;
    }

    climbing_aid_definition_handle &cost( const sol::table &options ) {
        require_building_handle( token, *definition, "climbing aid" );
        definition->pain = options.get_or<std::int64_t>( "pain", 0 );
        definition->damage = options.get_or<std::int64_t>( "damage", 0 );
        definition->kilocalories = options.get_or<std::int64_t>( "kilocalories", 0 );
        definition->thirst = options.get_or<std::int64_t>( "thirst", 0 );
        return *this;
    }

    climbing_aid_definition_handle &deploy( const std::string &furniture_id ) {
        require_building_handle( token, *definition, "climbing aid" );
        definition->deploy_furniture = furniture_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "climbing aid" );
        return definition->id;
    }
};

struct weather_type_definition_handle {
    std::shared_ptr<weather_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    weather_type_definition_handle &duration( const std::int64_t minimum_turns,
            const std::int64_t maximum_turns ) {
        require_building_handle( token, *definition, "weather type" );
        definition->minimum_duration_turns = minimum_turns;
        definition->maximum_duration_turns = maximum_turns;
        return *this;
    }

    weather_type_definition_handle &animation( const sol::table &options ) {
        require_building_handle( token, *definition, "weather type" );
        definition->has_animation = true;
        definition->animation_factor = options.get_or( "factor", 0.0 );
        definition->animation_color = options.get_or( "color", std::string( "white" ) );
        definition->animation_symbol = options.get_or( "symbol", std::string() );
        return *this;
    }

    weather_type_definition_handle &requires( const std::string &weather_id ) {
        require_building_handle( token, *definition, "weather type" );
        definition->required_weathers.push_back( weather_id );
        return *this;
    }

    weather_type_definition_handle &passive_effect( const sol::table &options ) {
        require_building_handle( token, *definition, "weather type" );
        weather_passive_effect_definition_data value;
        value.effect = options.get_or( "effect", std::string() );
        value.minimum_duration_turns = options.get_or<std::int64_t>(
                                           "minimum_duration_turns", 1 );
        value.maximum_duration_turns = options.get_or<std::int64_t>(
                                           "maximum_duration_turns", value.minimum_duration_turns );
        value.intensity = options.get_or<std::int64_t>( "intensity", 1 );
        value.body_part = options.get_or( "body_part", std::string() );
        value.environmental = options.get_or( "environmental", true );
        value.immune_in_vehicle = options.get_or( "immune_in_vehicle", false );
        value.immune_inside_vehicle = options.get_or( "immune_inside_vehicle", false );
        value.immune_outside_vehicle = options.get_or( "immune_outside_vehicle", false );
        value.chance_in_vehicle = options.get_or<std::int64_t>( "chance_in_vehicle", 0 );
        value.chance_inside_vehicle = options.get_or<std::int64_t>(
                                          "chance_inside_vehicle", 0 );
        value.chance_outside_vehicle = options.get_or<std::int64_t>(
                                           "chance_outside_vehicle", 0 );
        value.message = options.get_or( "message", std::string() );
        value.npc_message = options.get_or( "npc_message", std::string() );
        definition->passive_effects.push_back( std::move( value ) );
        return *this;
    }

    weather_type_definition_handle &condition( const std::string &handler_id ) {
        require_building_handle( token, *definition, "weather type" );
        definition->condition_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "weather type" );
        return definition->id;
    }
};

struct event_transformation_definition_handle {
    std::shared_ptr<event_transformation_definition_data> definition;
    std::shared_ptr<owner_token> token;

    static detail::event_source_native_definition source( const sol::table &options ) {
        const std::string event = options.get_or( "event_type", std::string() );
        const std::string transformation = options.get_or(
                                               "event_transformation", std::string() );
        if( event.empty() == transformation.empty() ) {
            throw std::runtime_error(
                "event content requires exactly one event_type or event_transformation source" );
        }
        return event.empty() ?
               detail::event_source_native_definition{ "event_transformation", transformation } :
               detail::event_source_native_definition{ "event_type", event };
    }

    static std::string scalar_string( const sol::object &value ) {
        if( value.is<std::string>() ) {
            return value.as<std::string>();
        }
        if( value.is<std::int64_t>() ) {
            return std::to_string( value.as<std::int64_t>() );
        }
        if( value.is<bool>() ) {
            return value.as<bool>() ? "true" : "false";
        }
        throw std::runtime_error( "event constraint values must be strings, integers, or booleans" );
    }

    event_transformation_definition_handle &derive( const std::string &field,
            const std::string &transformation, const std::string &input_field ) {
        require_building_handle( token, *definition, "event transformation" );
        if( definition->new_fields.size() >= 128 ) {
            throw std::runtime_error( "event transformation exceeds the derived-field limit" );
        }
        definition->new_fields.push_back( { field, transformation, input_field } );
        return *this;
    }

    event_transformation_definition_handle &drop( const std::string &field ) {
        require_building_handle( token, *definition, "event transformation" );
        if( definition->drop_fields.size() >= 128 ) {
            throw std::runtime_error( "event transformation exceeds the dropped-field limit" );
        }
        definition->drop_fields.push_back( field );
        return *this;
    }

    event_transformation_definition_handle &add_constraint(
        detail::event_value_constraint_native_definition value ) {
        require_building_handle( token, *definition, "event transformation" );
        if( definition->constraints.size() >= 256 ) {
            throw std::runtime_error( "event transformation exceeds the constraint limit" );
        }
        definition->constraints.push_back( std::move( value ) );
        return *this;
    }

    event_transformation_definition_handle &where_equals( const std::string &field,
            const std::string &value_type, const sol::object &value ) {
        return add_constraint( {
            field, "equals", value_type, { scalar_string( value ) }, {}
        } );
    }

    event_transformation_definition_handle &where_any( const std::string &field,
            const std::string &value_type, const sol::table &values ) {
        require_building_handle( token, *definition, "event transformation" );
        const std::size_t count = require_dense_array(
                                      values, "event transformation constraint values", 1, 256 );
        detail::event_value_constraint_native_definition constraint;
        constraint.field = field;
        constraint.kind = "equals_any";
        constraint.value_type = value_type;
        constraint.values.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            constraint.values.push_back( scalar_string(
                                             values.raw_get<sol::object>( index ) ) );
        }
        return add_constraint( std::move( constraint ) );
    }

    event_transformation_definition_handle &where_statistic( const std::string &field,
            const std::string &statistic ) {
        return add_constraint( {
            field, "equals_statistic", {}, {}, statistic
        } );
    }

    event_transformation_definition_handle &ordered_constraint( const std::string &kind,
            const std::string &field, const std::int64_t value ) {
        return add_constraint( {
            field, kind, "int", { std::to_string( value ) }, {}
        } );
    }

    event_transformation_definition_handle &where_lt( const std::string &field,
            const std::int64_t value ) {
        return ordered_constraint( "lt", field, value );
    }

    event_transformation_definition_handle &where_lte( const std::string &field,
            const std::int64_t value ) {
        return ordered_constraint( "lteq", field, value );
    }

    event_transformation_definition_handle &where_gte( const std::string &field,
            const std::int64_t value ) {
        return ordered_constraint( "gteq", field, value );
    }

    event_transformation_definition_handle &where_gt( const std::string &field,
            const std::int64_t value ) {
        return ordered_constraint( "gt", field, value );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "event transformation" );
        return definition->id;
    }
};

struct event_statistic_definition_handle {
    std::shared_ptr<event_statistic_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "event statistic" );
        return definition->id;
    }
};

struct relic_procgen_definition_handle {
    std::shared_ptr<relic_procgen_definition_data> definition;
    std::shared_ptr<owner_token> token;

    static std::pair<std::int64_t, std::int64_t> integer_range(
        const sol::object &value, const std::string &kind ) {
        if( value.is<std::int64_t>() ) {
            const std::int64_t number = value.as<std::int64_t>();
            return { number, number };
        }
        if( value.is<sol::table>() ) {
            const sol::table range = value.as<sol::table>();
            require_dense_array( range, "relic procgen " + kind + " range", 2, 2 );
            return { range.raw_get<std::int64_t>( 1 ),
                     range.raw_get<std::int64_t>( 2 ) };
        }
        throw std::runtime_error( "relic procgen " + kind +
                                  " requires an integer or two-value range" );
    }

    relic_procgen_definition_handle &passive( const std::string &kind,
            const sol::table &options ) {
        require_building_handle( token, *definition, "relic procgen" );
        if( definition->passive_values.size() >= 2048 ) {
            throw std::runtime_error( "relic procgen exceeds the passive-value limit" );
        }
        relic_procgen_passive_definition_data value;
        value.kind = kind;
        value.type = options.get_or( "type", std::string() );
        value.weight = options.get_or<std::int64_t>( "weight", 0 );
        value.power_per_increment = options.get_or<std::int64_t>(
                                        "power_per_increment", 1 );
        value.increment = options.get_or( "increment", 1.0 );
        value.minimum = options.get_or( "min_value", 0.0 );
        value.maximum = options.get_or( "max_value", 0.0 );
        value.has = options.get_or( "has", options.get_or(
                                        "ench_has", std::string( "HELD" ) ) );
        definition->passive_values.push_back( std::move( value ) );
        return *this;
    }

    relic_procgen_definition_handle &passive_add( const sol::table &options ) {
        return passive( "passive_enchantment_add", options );
    }

    relic_procgen_definition_handle &passive_multiplier( const sol::table &options ) {
        return passive( "passive_enchantment_mult", options );
    }

    relic_procgen_definition_handle &active( const std::string &kind,
            const sol::table &options ) {
        require_building_handle( token, *definition, "relic procgen" );
        if( definition->active_values.size() >= 2048 ) {
            throw std::runtime_error( "relic procgen exceeds the active-value limit" );
        }
        relic_procgen_active_definition_data value;
        value.kind = kind;
        value.spell = options.get_or( "spell", options.get_or(
                                         "spell_id", std::string() ) );
        value.weight = options.get_or<std::int64_t>( "weight", 0 );
        value.base_power = options.get_or<std::int64_t>( "base_power", 0 );
        value.power_per_increment = options.get_or<std::int64_t>(
                                        "power_per_increment", 1 );
        value.increment = options.get_or<std::int64_t>( "increment", 1 );
        value.minimum_level = options.get_or<std::int64_t>( "min_level", 0 );
        value.maximum_level = options.get_or<std::int64_t>( "max_level", 0 );
        value.has = options.get_or( "has", options.get_or(
                                        "ench_has", std::string( "HELD" ) ) );
        definition->active_values.push_back( std::move( value ) );
        return *this;
    }

    relic_procgen_definition_handle &activated_spell( const sol::table &options ) {
        return active( "active_enchantment", options );
    }

    relic_procgen_definition_handle &on_hit_you( const sol::table &options ) {
        return active( "hit_you", options );
    }

    relic_procgen_definition_handle &on_hit_me( const sol::table &options ) {
        return active( "hit_me", options );
    }

    relic_procgen_definition_handle &type( const std::string &kind,
                                           const std::int64_t weight ) {
        require_building_handle( token, *definition, "relic procgen" );
        if( definition->type_weights.size() >= 64 ) {
            throw std::runtime_error( "relic procgen exceeds the type-weight limit" );
        }
        definition->type_weights.emplace_back( kind, weight );
        return *this;
    }

    relic_procgen_definition_handle &item( const std::string &item_id,
                                           const std::int64_t weight ) {
        require_building_handle( token, *definition, "relic procgen" );
        if( definition->item_weights.size() >= 2048 ) {
            throw std::runtime_error( "relic procgen exceeds the item-weight limit" );
        }
        definition->item_weights.emplace_back( item_id, weight );
        return *this;
    }

    relic_procgen_definition_handle &charge( const sol::table &options ) {
        require_building_handle( token, *definition, "relic procgen" );
        if( definition->charges.size() >= 128 ) {
            throw std::runtime_error( "relic procgen exceeds the charge-template limit" );
        }
        relic_procgen_charge_definition_data value;
        value.weight = options.get_or<std::int64_t>( "weight", 0 );
        const auto [initial_minimum, initial_maximum] = integer_range(
                    options.raw_get<sol::object>( "charges" ), "initial charges" );
        value.initial_minimum = initial_minimum;
        value.initial_maximum = initial_maximum;
        const auto [use_minimum, use_maximum] = integer_range(
                    options.raw_get<sol::object>( "charges_per_use" ), "charges per use" );
        value.use_minimum = use_minimum;
        value.use_maximum = use_maximum;
        const auto [maximum_minimum, maximum_maximum] = integer_range(
                    options.raw_get<sol::object>( "max_charges" ), "maximum charges" );
        value.maximum_minimum = maximum_minimum;
        value.maximum_maximum = maximum_maximum;
        const sol::object recharge_time = options.raw_get<sol::object>( "time_turns" );
        if( recharge_time.valid() && recharge_time.get_type() != sol::type::lua_nil &&
            recharge_time.get_type() != sol::type::none ) {
            const auto [time_minimum, time_maximum] = integer_range(
                        recharge_time, "recharge time" );
            value.time_minimum_turns = time_minimum;
            value.time_maximum_turns = time_maximum;
        }
        value.power = options.get_or<std::int64_t>( "power", 0 );
        value.recharge_type = options.get_or(
                                  "recharge_type", std::string( "none" ) );
        definition->charges.push_back( std::move( value ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "relic procgen" );
        return definition->id;
    }
};

struct score_definition_handle {
    std::shared_ptr<score_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "score" );
        return definition->id;
    }
};

struct overlay_order_definition_handle {
    std::shared_ptr<overlay_order_definition_data> definition;
    std::shared_ptr<owner_token> token;

    overlay_order_definition_handle &mutation( const std::string &mutation_id,
            const std::int64_t order ) {
        require_building_handle( token, *definition, "overlay order" );
        if( mutation_id.empty() || !definition->orders.emplace( mutation_id, order ).second ) {
            throw std::runtime_error( "overlay order requires unique non-empty mutation ids" );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "overlay order" );
        return definition->id;
    }
};

struct zone_type_definition_handle {
    std::shared_ptr<zone_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    std::string id() const {
        require_readable_handle( token, *definition, "zone type" );
        return definition->id;
    }
};

struct speech_pool_definition_handle {
    std::shared_ptr<speech_pool_definition_data> definition;
    std::shared_ptr<owner_token> token;

    speech_pool_definition_handle &line( const std::string &sound,
                                         const std::int64_t volume ) {
        require_building_handle( token, *definition, "speech pool" );
        if( sound.empty() ) {
            throw std::runtime_error( "speech-pool line cannot be empty" );
        }
        definition->lines.emplace_back( sound, volume );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "speech pool" );
        return definition->id;
    }
};

struct end_screen_definition_handle {
    std::shared_ptr<end_screen_definition_data> definition;
    std::shared_ptr<owner_token> token;

    end_screen_definition_handle &info( const std::int64_t column,
                                        const std::int64_t row,
                                        const std::string &text ) {
        require_building_handle( token, *definition, "end screen" );
        if( text.empty() ) {
            throw std::runtime_error( "end-screen information text cannot be empty" );
        }
        definition->information.emplace_back( column, row, text );
        return *this;
    }

    end_screen_definition_handle &condition( const std::string &handler_id ) {
        require_building_handle( token, *definition, "end screen" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "end-screen condition handler cannot be empty" );
        }
        definition->condition_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "end screen" );
        return definition->id;
    }
};

struct activity_type_definition_handle {
    std::shared_ptr<activity_type_definition_data> definition;
    std::shared_ptr<owner_token> token;

    activity_type_definition_handle &ignore( const std::string &distraction ) {
        require_building_handle( token, *definition, "activity type" );
        if( distraction.empty() ||
            !definition->ignored_distractions.insert( distraction ).second ) {
            throw std::runtime_error(
                "activity type requires unique non-empty ignored distractions" );
        }
        return *this;
    }

    activity_type_definition_handle &on_turn( const std::string &handler_id ) {
        require_building_handle( token, *definition, "activity type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "activity-type turn handler cannot be empty" );
        }
        definition->do_turn_handler = handler_id;
        return *this;
    }

    activity_type_definition_handle &on_finish( const std::string &handler_id ) {
        require_building_handle( token, *definition, "activity type" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "activity-type completion handler cannot be empty" );
        }
        definition->completion_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "activity type" );
        return definition->id;
    }
};

struct help_topic_definition_handle {
    std::shared_ptr<help_topic_definition_data> definition;
    std::shared_ptr<owner_token> token;

    help_topic_definition_handle &paragraph( const std::string &text ) {
        require_building_handle( token, *definition, "help topic" );
        if( text.empty() ) {
            throw std::runtime_error( "help-topic paragraph cannot be empty" );
        }
        definition->paragraphs.push_back( text );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "help topic" );
        return definition->id;
    }
};

struct snippet_category_definition_handle {
    std::shared_ptr<snippet_category_definition_data> definition;
    std::shared_ptr<owner_token> token;

    snippet_category_definition_handle &text( const std::string &value,
            const sol::optional<std::int64_t> &weight ) {
        require_building_handle( token, *definition, "snippet category" );
        if( value.empty() ) {
            throw std::runtime_error( "snippet text cannot be empty" );
        }
        definition->entries.push_back( snippet_entry_definition_data{
            std::string(), value, std::string(), weight.value_or( 1 ), std::string()
        } );
        return *this;
    }

    snippet_category_definition_handle &entry( const sol::table &options ) {
        require_building_handle( token, *definition, "snippet category" );
        snippet_entry_definition_data value;
        value.id = options.get_or( "id", std::string() );
        value.text = options.get_or( "text", std::string() );
        value.name = options.get_or( "name", std::string() );
        value.weight = options.get_or<std::int64_t>( "weight", 1 );
        value.examine_handler = options.get_or( "on_examine", std::string() );
        if( value.id.empty() || value.text.empty() ) {
            throw std::runtime_error(
                "named snippet entries require non-empty id and text" );
        }
        definition->entries.push_back( std::move( value ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "snippet category" );
        return definition->id;
    }
};

struct playlist_definition_handle {
    std::shared_ptr<playlist_definition_data> definition;
    std::shared_ptr<owner_token> token;

    playlist_definition_handle &track( const std::string &file,
                                       const sol::optional<std::int64_t> &volume ) {
        require_building_handle( token, *definition, "playlist" );
        if( file.empty() ) {
            throw std::runtime_error( "playlist track file cannot be empty" );
        }
        definition->tracks.emplace_back( file, volume.value_or( 100 ) );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "playlist" );
        return definition->id;
    }
};

struct sound_effect_definition_handle {
    std::shared_ptr<sound_effect_definition_data> definition;
    std::shared_ptr<owner_token> token;

    sound_effect_definition_handle &file( const std::string &path ) {
        require_building_handle( token, *definition, "sound effect" );
        if( path.empty() ) {
            throw std::runtime_error( "sound effect file cannot be empty" );
        }
        definition->files.push_back( path );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "sound effect" );
        return definition->id;
    }
};

struct technique_definition_handle {
    std::shared_ptr<technique_definition_data> definition;
    std::shared_ptr<owner_token> token;

    technique_definition_handle &flag( const std::string &value ) {
        require_building_handle( token, *definition, "technique" );
        if( value.empty() ) {
            throw std::runtime_error( "technique flag id cannot be empty" );
        }
        definition->flags.insert( value );
        return *this;
    }

    technique_definition_handle &attack_vector( const std::string &value ) {
        require_building_handle( token, *definition, "technique" );
        if( value.empty() ) {
            throw std::runtime_error( "technique attack-vector id cannot be empty" );
        }
        definition->attack_vectors.push_back( value );
        return *this;
    }

    technique_definition_handle &requires_skill( const std::string &skill,
            const std::int64_t level ) {
        require_building_handle( token, *definition, "technique" );
        if( skill.empty() || level < 0 ) {
            throw std::runtime_error( "technique skill requirement must be non-negative" );
        }
        definition->min_skills.emplace_back( skill, level );
        return *this;
    }

    technique_definition_handle &on_apply( const std::string &handler_id ) {
        require_building_handle( token, *definition, "technique" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "technique application handler id cannot be empty" );
        }
        definition->apply_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "technique" );
        return definition->id;
    }
};

struct martial_art_definition_handle {
    std::shared_ptr<martial_art_definition_data> definition;
    std::shared_ptr<owner_token> token;

    martial_art_definition_handle &autolearn( const std::string &skill,
            const std::int64_t level ) {
        require_building_handle( token, *definition, "martial art" );
        if( skill.empty() || level < 0 ) {
            throw std::runtime_error( "martial-art autolearn skill must be non-negative" );
        }
        definition->autolearn_skills.emplace_back( skill, level );
        return *this;
    }

    martial_art_definition_handle &technique( const std::string &value ) {
        require_building_handle( token, *definition, "martial art" );
        if( value.empty() ) {
            throw std::runtime_error( "martial-art technique id cannot be empty" );
        }
        definition->techniques.push_back( value );
        return *this;
    }

    martial_art_definition_handle &weapon( const std::string &value ) {
        require_building_handle( token, *definition, "martial art" );
        if( value.empty() ) {
            throw std::runtime_error( "martial-art weapon id cannot be empty" );
        }
        definition->weapons.push_back( value );
        return *this;
    }

    martial_art_definition_handle &weapon_category( const std::string &value ) {
        require_building_handle( token, *definition, "martial art" );
        if( value.empty() ) {
            throw std::runtime_error( "martial-art weapon-category id cannot be empty" );
        }
        definition->weapon_categories.push_back( value );
        return *this;
    }

    martial_art_definition_handle &on( const std::string &phase,
                                       const std::string &handler_id ) {
        require_building_handle( token, *definition, "martial art" );
        static const std::set<std::string> phases = {
            "static", "move", "pause", "hit", "attack", "dodge",
            "block", "gethit", "miss", "crit", "kill"
        };
        if( phases.count( phase ) == 0 ) {
            throw std::runtime_error( "unknown martial-art phase '" + phase + "'" );
        }
        if( handler_id.empty() ) {
            throw std::runtime_error( "martial-art handler id cannot be empty" );
        }
        definition->handlers[phase] = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "martial art" );
        return definition->id;
    }
};

struct trap_definition_handle {
    std::shared_ptr<trap_definition_data> definition;
    std::shared_ptr<owner_token> token;

    trap_definition_handle &flag( const std::string &value ) {
        require_building_handle( token, *definition, "trap" );
        if( value.empty() ) {
            throw std::runtime_error( "trap flag id cannot be empty" );
        }
        definition->flags.insert( value );
        return *this;
    }

    trap_definition_handle &drop( const std::string &item,
                                  const sol::optional<std::int64_t> &quantity,
                                  const sol::optional<std::int64_t> &charges ) {
        require_building_handle( token, *definition, "trap" );
        if( item.empty() ) {
            throw std::runtime_error( "trap drop item id cannot be empty" );
        }
        definition->drops.emplace_back( item, quantity.value_or( 1 ),
                                        charges.value_or( 1 ) );
        return *this;
    }

    trap_definition_handle &on_trigger( const std::string &handler_id ) {
        require_building_handle( token, *definition, "trap" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "trap trigger handler id cannot be empty" );
        }
        definition->trigger_handler = handler_id;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "trap" );
        return definition->id;
    }
};

struct construction_definition_handle {
    std::shared_ptr<construction_definition_data> definition;
    std::shared_ptr<owner_token> token;

    construction_definition_handle &requires_skill( const std::string &skill,
            const std::int64_t level ) {
        require_building_handle( token, *definition, "construction" );
        if( skill.empty() || level < 0 ) {
            throw std::runtime_error( "construction skill requirement must be non-negative" );
        }
        definition->required_skills.emplace_back( skill, level );
        return *this;
    }

    construction_definition_handle &using_requirement( const std::string &requirement,
            const std::int64_t multiplier ) {
        require_building_handle( token, *definition, "construction" );
        if( requirement.empty() || multiplier <= 0 ) {
            throw std::runtime_error( "construction requirement multiplier must be positive" );
        }
        definition->reqs_using.emplace_back( requirement, multiplier );
        return *this;
    }

    construction_definition_handle &pre_terrain( const std::string &value ) {
        require_building_handle( token, *definition, "construction" );
        if( value.empty() ) {
            throw std::runtime_error( "construction pre-terrain id cannot be empty" );
        }
        definition->pre_terrain.push_back( value );
        return *this;
    }

    construction_definition_handle &pre_flag( const std::string &flag,
            const bool force_terrain ) {
        require_building_handle( token, *definition, "construction" );
        if( flag.empty() ) {
            throw std::runtime_error( "construction pre-flag id cannot be empty" );
        }
        definition->pre_flags.emplace_back( flag, force_terrain );
        return *this;
    }

    construction_definition_handle &post_flag( const std::string &flag ) {
        require_building_handle( token, *definition, "construction" );
        if( flag.empty() ) {
            throw std::runtime_error( "construction post-flag id cannot be empty" );
        }
        definition->post_flags.push_back( flag );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "construction" );
        return definition->id;
    }
};

struct furniture_definition_handle {
    std::shared_ptr<furniture_definition_data> definition;
    std::shared_ptr<owner_token> token;

    furniture_definition_handle &flag( const std::string &value ) {
        require_building_handle( token, *definition, "furniture" );
        if( value.empty() ) {
            throw std::runtime_error( "furniture flag id cannot be empty" );
        }
        definition->flags.insert( value );
        return *this;
    }

    furniture_definition_handle &on_examine(
        const std::string &handler_id, const sol::optional<std::string> &name ) {
        require_building_handle( token, *definition, "furniture" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "furniture examine handler id cannot be empty" );
        }
        definition->examine_handler = handler_id;
        definition->examine_name = name.value_or( std::string() );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "furniture" );
        return definition->id;
    }
};

struct terrain_definition_handle {
    std::shared_ptr<terrain_definition_data> definition;
    std::shared_ptr<owner_token> token;

    terrain_definition_handle &flag( const std::string &value ) {
        require_building_handle( token, *definition, "terrain" );
        if( value.empty() ) {
            throw std::runtime_error( "terrain flag id cannot be empty" );
        }
        definition->flags.insert( value );
        return *this;
    }

    terrain_definition_handle &on_examine(
        const std::string &handler_id, const sol::optional<std::string> &name ) {
        require_building_handle( token, *definition, "terrain" );
        if( handler_id.empty() ) {
            throw std::runtime_error( "terrain examine handler id cannot be empty" );
        }
        definition->examine_handler = handler_id;
        definition->examine_name = name.value_or( std::string() );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "terrain" );
        return definition->id;
    }
};

struct gate_definition_handle {
    std::shared_ptr<gate_definition_data> definition;
    std::shared_ptr<owner_token> token;

    gate_definition_handle &wall( const std::string &value ) {
        require_building_handle( token, *definition, "gate" );
        if( value.empty() ) {
            throw std::runtime_error( "gate wall id cannot be empty" );
        }
        definition->walls.push_back( value );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "gate" );
        return definition->id;
    }
};

struct fault_definition_handle {
    std::shared_ptr<fault_definition_data> definition;
    std::shared_ptr<owner_token> token;

    fault_definition_handle &flag( const std::string &value ) {
        require_building_handle( token, *definition, "fault" );
        if( value.empty() ) {
            throw std::runtime_error( "fault flag id cannot be empty" );
        }
        definition->flags.insert( value );
        return *this;
    }

    fault_definition_handle &block_fault( const std::string &value ) {
        require_building_handle( token, *definition, "fault" );
        if( value.empty() ) {
            throw std::runtime_error( "fault block id cannot be empty" );
        }
        definition->block_faults.push_back( value );
        return *this;
    }

    fault_definition_handle &fix( const std::string &value ) {
        require_building_handle( token, *definition, "fault" );
        if( value.empty() ) {
            throw std::runtime_error( "fault fix id cannot be empty" );
        }
        definition->fixes.push_back( value );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "fault" );
        return definition->id;
    }
};

struct fault_fix_definition_handle {
    std::shared_ptr<fault_fix_definition_data> definition;
    std::shared_ptr<owner_token> token;

    fault_fix_definition_handle &requires_skill( const std::string &skill,
            const std::int64_t level ) {
        require_building_handle( token, *definition, "fault fix" );
        if( skill.empty() || level < 0 ) {
            throw std::runtime_error( "fault-fix skill requirement must be non-negative" );
        }
        definition->skills.emplace_back( skill, level );
        return *this;
    }

    fault_fix_definition_handle &removes_fault( const std::string &value ) {
        require_building_handle( token, *definition, "fault fix" );
        if( value.empty() ) {
            throw std::runtime_error( "fault-fix removed fault id cannot be empty" );
        }
        definition->faults_removed.push_back( value );
        return *this;
    }

    fault_fix_definition_handle &adds_fault( const std::string &value ) {
        require_building_handle( token, *definition, "fault fix" );
        if( value.empty() ) {
            throw std::runtime_error( "fault-fix added fault id cannot be empty" );
        }
        definition->faults_added.push_back( value );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "fault fix" );
        return definition->id;
    }
};

struct dream_definition_handle {
    std::shared_ptr<dream_definition_data> definition;
    std::shared_ptr<owner_token> token;

    dream_definition_handle &message( const std::string &text ) {
        require_building_handle( token, *definition, "dream" );
        if( text.empty() ) {
            throw std::runtime_error( "dream message cannot be empty" );
        }
        definition->messages.push_back( text );
        return *this;
    }
};

struct blacklist_definition_handle {
    std::shared_ptr<detail::platform_blacklist_data> definition;
    std::shared_ptr<owner_token> token;

    blacklist_definition_handle &entry( const std::string &value ) {
        require_building_handle( token, *definition, "blacklist" );
        if( value.empty() ) {
            throw std::runtime_error( "blacklist entry id cannot be empty" );
        }
        definition->entries.push_back( value );
        return *this;
    }
};

struct map_extra_definition_data {
    std::string id;
    std::string name;
    std::string description;
    std::string generator_id;
    std::string symbol;
    std::string color;
    std::set<std::string> flags;
    bool registered = false;
};

struct shopkeeper_entry_definition_data {
    std::string item;
    std::string category;
    std::string item_group;
    std::string message;
};

struct shopkeeper_blacklist_definition_data {
    std::string kind;  // "blacklist" | "whitelist" | "consumption"
    std::string id;
    std::vector<shopkeeper_entry_definition_data> entries;
    std::string message;
    std::int64_t default_rate = 0;
    bool registered = false;
};

struct monster_adjustment_definition_data {
    std::string species;
    std::string stat;
    double stat_adjust = 1.0;
    std::string flag;
    bool flag_val = false;
    std::string special;
    bool registered = false;
};

struct trait_group_definition_data {
    std::string id;
    std::vector<detail::platform_trait_group_entry> entries;
    bool registered = false;
};

struct weather_generator_definition_data {
    std::string id;
    double base_temperature = 0;
    double base_humidity = 0;
    double base_pressure = 0;
    double base_wind = 0;
    std::int64_t base_wind_distrib_peaks = 0;
    std::int64_t summer_temp_manual_mod = 0;
    std::int64_t spring_temp_manual_mod = 0;
    std::int64_t autumn_temp_manual_mod = 0;
    std::int64_t winter_temp_manual_mod = 0;
    std::int64_t spring_humidity_manual_mod = 0;
    std::int64_t summer_humidity_manual_mod = 0;
    std::int64_t autumn_humidity_manual_mod = 0;
    std::int64_t winter_humidity_manual_mod = 0;
    std::vector<std::string> weather_black_list;
    std::vector<std::string> weather_white_list;
    bool registered = false;
};

struct map_extra_definition_handle {
    std::shared_ptr<map_extra_definition_data> definition;
    std::shared_ptr<owner_token> token;

    map_extra_definition_handle &flag( const std::string &value ) {
        require_building_handle( token, *definition, "map extra" );
        if( value.empty() ) {
            throw std::runtime_error( "map-extra flag id cannot be empty" );
        }
        definition->flags.insert( value );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "map extra" );
        return definition->id;
    }
};

struct weather_generator_definition_handle {
    std::shared_ptr<weather_generator_definition_data> definition;
    std::shared_ptr<owner_token> token;

    weather_generator_definition_handle &blacklisted_weather(
        const std::string &value ) {
        require_building_handle( token, *definition, "weather generator" );
        if( value.empty() ) {
            throw std::runtime_error( "weather blacklist id cannot be empty" );
        }
        definition->weather_black_list.push_back( value );
        return *this;
    }

    weather_generator_definition_handle &whitelisted_weather(
        const std::string &value ) {
        require_building_handle( token, *definition, "weather generator" );
        if( value.empty() ) {
            throw std::runtime_error( "weather whitelist id cannot be empty" );
        }
        definition->weather_white_list.push_back( value );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "weather generator" );
        return definition->id;
    }
};

struct migration_definition_handle {
    std::shared_ptr<detail::platform_migration_data> definition;
    std::shared_ptr<owner_token> token;
};

struct monster_adjustment_definition_handle {
    std::shared_ptr<monster_adjustment_definition_data> definition;
    std::shared_ptr<owner_token> token;
};

struct trait_group_definition_handle {
    std::shared_ptr<trait_group_definition_data> definition;
    std::shared_ptr<owner_token> token;

    trait_group_definition_handle &trait( const std::string &trait,
                                          const std::int64_t weight,
                                          const sol::optional<std::string> &variant ) {
        require_building_handle( token, *definition, "trait group" );
        if( trait.empty() || weight <= 0 ) {
            throw std::runtime_error( "trait-group entry must be positive" );
        }
        definition->entries.push_back( {
            trait, weight, false, variant.value_or( std::string() )
        } );
        return *this;
    }

    trait_group_definition_handle &group( const std::string &group,
                                          const std::int64_t weight ) {
        require_building_handle( token, *definition, "trait group" );
        if( group.empty() || weight <= 0 ) {
            throw std::runtime_error( "trait-group subgroup must be positive" );
        }
        definition->entries.push_back( { group, weight, true, std::string() } );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "trait group" );
        return definition->id;
    }
};

struct shopkeeper_definition_handle {
    std::shared_ptr<shopkeeper_blacklist_definition_data> definition;
    std::shared_ptr<owner_token> token;

    shopkeeper_definition_handle &entry(
        const std::string &item, const std::string &category,
        const std::string &item_group, const std::string &message ) {
        require_building_handle( token, *definition, "shopkeeper entry" );
        definition->entries.push_back( shopkeeper_entry_definition_data{
            item, category, item_group, message
        } );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "shopkeeper rule" );
        return definition->id;
    }
};

struct achievement_definition_handle {
    std::shared_ptr<achievement_definition_data> definition;
    std::shared_ptr<owner_token> token;

    achievement_definition_handle &hidden_by( const std::string &value ) {
        require_building_handle( token, *definition, "achievement" );
        if( value.empty() ) {
            throw std::runtime_error( "achievement hidden-by id cannot be empty" );
        }
        definition->hidden_by.push_back( value );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "achievement" );
        return definition->id;
    }
};

struct attack_vector_definition_handle {
    std::shared_ptr<attack_vector_definition_data> definition;
    std::shared_ptr<owner_token> token;

    attack_vector_definition_handle &limb( const std::string &body_part ) {
        require_building_handle( token, *definition, "attack vector" );
        if( body_part.empty() ) {
            throw std::runtime_error( "attack-vector limb id cannot be empty" );
        }
        definition->limbs.push_back( body_part );
        return *this;
    }

    attack_vector_definition_handle &contact( const std::string &sub_body_part ) {
        require_building_handle( token, *definition, "attack vector" );
        if( sub_body_part.empty() ) {
            throw std::runtime_error( "attack-vector contact id cannot be empty" );
        }
        definition->contacts.push_back( sub_body_part );
        return *this;
    }

    attack_vector_definition_handle &requires_limb( const std::string &kind,
            const std::int64_t count ) {
        require_building_handle( token, *definition, "attack vector" );
        if( kind.empty() || count <= 0 ) {
            throw std::runtime_error( "attack-vector limb requirement must be positive" );
        }
        definition->limb_requirements.emplace_back( kind, count );
        return *this;
    }

    attack_vector_definition_handle &requires_flag( const std::string &flag ) {
        require_building_handle( token, *definition, "attack vector" );
        if( flag.empty() ) {
            throw std::runtime_error( "attack-vector required flag cannot be empty" );
        }
        definition->required_flags.insert( flag );
        return *this;
    }

    attack_vector_definition_handle &forbids_flag( const std::string &flag ) {
        require_building_handle( token, *definition, "attack vector" );
        if( flag.empty() ) {
            throw std::runtime_error( "attack-vector forbidden flag cannot be empty" );
        }
        definition->forbidden_flags.insert( flag );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "attack vector" );
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

struct region_settings_ravine_definition_data {
    std::string id;
    std::int64_t num_ravines = 0;
    std::int64_t ravine_range = 45;
    std::int64_t ravine_width = 1;
    std::int64_t ravine_depth = -3;
    bool registered = false;
};

struct region_settings_ravine_definition_handle {
    std::shared_ptr<region_settings_ravine_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_ravine_definition_handle &num_ravines( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ravine" );
        definition->num_ravines = value;
        return *this;
    }

    region_settings_ravine_definition_handle &ravine_range( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ravine" );
        definition->ravine_range = value;
        return *this;
    }

    region_settings_ravine_definition_handle &ravine_width( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ravine" );
        definition->ravine_width = value;
        return *this;
    }

    region_settings_ravine_definition_handle &ravine_depth( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ravine" );
        definition->ravine_depth = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings ravine" );
        return definition->id;
    }
};

std::optional<ot_match_type> platform_ot_match_type( std::string value );

struct region_settings_lake_alias_data {
    std::string om_terrain;
    std::string alias;
    std::string match_type = "exact";
};

struct region_settings_lake_definition_data {
    std::string id;
    double noise_threshold_lake = 0.25;
    std::int64_t lake_size_min = 20;
    std::int64_t lake_depth = -5;
    bool invert_lakes = false;
    std::string surface = "lake_surface";
    std::string shore = "lake_shore";
    std::string interior = "lake_water_cube";
    std::string bed = "lake_bed";
    std::vector<std::string> shore_extendable_overmap_terrain;
    std::vector<region_settings_lake_alias_data> shore_extendable_overmap_terrain_aliases;
    bool registered = false;
};

struct region_settings_lake_definition_handle {
    std::shared_ptr<region_settings_lake_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_lake_definition_handle &noise_threshold_lake( const double value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "lake noise threshold must be finite" );
        }
        definition->noise_threshold_lake = value;
        return *this;
    }

    region_settings_lake_definition_handle &lake_size_min( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings lake" );
        definition->lake_size_min = value;
        return *this;
    }

    region_settings_lake_definition_handle &lake_depth( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings lake" );
        definition->lake_depth = value;
        return *this;
    }

    region_settings_lake_definition_handle &invert_lakes( const bool value ) {
        require_building_handle( token, *definition, "region settings lake" );
        definition->invert_lakes = value;
        return *this;
    }

    region_settings_lake_definition_handle &surface_ter( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "lake surface terrain cannot be empty" );
        }
        definition->surface = value;
        return *this;
    }

    region_settings_lake_definition_handle &shore_ter( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "lake shore terrain cannot be empty" );
        }
        definition->shore = value;
        return *this;
    }

    region_settings_lake_definition_handle &interior_ter( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "lake interior terrain cannot be empty" );
        }
        definition->interior = value;
        return *this;
    }

    region_settings_lake_definition_handle &bed_ter( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "lake bed terrain cannot be empty" );
        }
        definition->bed = value;
        return *this;
    }

    region_settings_lake_definition_handle &shore_extendable_terrain( const std::string &value ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( value.empty() ) {
            throw std::runtime_error( "shore extendable terrain cannot be empty" );
        }
        definition->shore_extendable_overmap_terrain.push_back( value );
        return *this;
    }

    region_settings_lake_definition_handle &shore_extendable_alias(
        const sol::object &om_terrain_or_options,
        sol::optional<std::string> alias = sol::nullopt,
        sol::optional<std::string> match_type = sol::nullopt ) {
        require_building_handle( token, *definition, "region settings lake" );
        if( om_terrain_or_options.is<sol::table>() ) {
            const sol::table options = om_terrain_or_options.as<sol::table>();
            const std::string om_terrain =
                options.get<std::optional<std::string>>( "om_terrain" ).value_or( "" );
            const std::string alias_str = options.get<std::optional<std::string>>( "alias" ).value_or( "" );
            const std::string match = options.get<std::optional<std::string>>( "om_terrain_match_type" )
                                      .value_or( options.get<std::optional<std::string>>( "match_type" ).value_or( "exact" ) );
            if( om_terrain.empty() || alias_str.empty() ) {
                throw std::runtime_error( "shore extendable alias requires non-empty om_terrain and alias" );
            }
            if( !platform_ot_match_type( match ).has_value() ) {
                throw std::runtime_error( "invalid overmap terrain match type: " + match );
            }
            definition->shore_extendable_overmap_terrain_aliases.push_back( {
                om_terrain, alias_str, match
            } );
            return *this;
        }
        if( om_terrain_or_options.is<std::string>() && alias.has_value() ) {
            const std::string om_terrain = om_terrain_or_options.as<std::string>();
            const std::string alias_str = *alias;
            const std::string match = match_type.value_or( "exact" );
            if( om_terrain.empty() || alias_str.empty() ) {
                throw std::runtime_error( "shore extendable alias requires non-empty om_terrain and alias" );
            }
            if( !platform_ot_match_type( match ).has_value() ) {
                throw std::runtime_error( "invalid overmap terrain match type: " + match );
            }
            definition->shore_extendable_overmap_terrain_aliases.push_back( {
                om_terrain, alias_str, match
            } );
            return *this;
        }
        throw std::runtime_error(
            "shore_extendable_alias expects a table { om_terrain = ..., alias = ..., [om_terrain_match_type = ...] } or positional strings" );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings lake" );
        return definition->id;
    }
};

struct region_settings_ocean_definition_data {
    std::string id;
    double noise_threshold_ocean = 0.25;
    std::int64_t ocean_size_min = 100;
    std::int64_t ocean_depth = -9;
    std::optional<std::int64_t> ocean_start_north;
    std::optional<std::int64_t> ocean_start_east;
    std::optional<std::int64_t> ocean_start_west;
    std::optional<std::int64_t> ocean_start_south;
    std::int64_t sandy_beach_width = 2;
    bool registered = false;
};

struct region_settings_ocean_definition_handle {
    std::shared_ptr<region_settings_ocean_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_ocean_definition_handle &noise_threshold_ocean( const double value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "ocean noise threshold must be finite" );
        }
        definition->noise_threshold_ocean = value;
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_size_min( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        definition->ocean_size_min = value;
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_depth( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        definition->ocean_depth = value;
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_start_north( const sol::object &value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( value.is<std::int64_t>() ) {
            definition->ocean_start_north = value.as<std::int64_t>();
        } else if( value.get_type() == sol::type::lua_nil || value.get_type() == sol::type::none ) {
            definition->ocean_start_north.reset();
        } else {
            throw std::runtime_error( "ocean_start_north must be an integer or nil" );
        }
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_start_east( const sol::object &value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( value.is<std::int64_t>() ) {
            definition->ocean_start_east = value.as<std::int64_t>();
        } else if( value.get_type() == sol::type::lua_nil || value.get_type() == sol::type::none ) {
            definition->ocean_start_east.reset();
        } else {
            throw std::runtime_error( "ocean_start_east must be an integer or nil" );
        }
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_start_west( const sol::object &value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( value.is<std::int64_t>() ) {
            definition->ocean_start_west = value.as<std::int64_t>();
        } else if( value.get_type() == sol::type::lua_nil || value.get_type() == sol::type::none ) {
            definition->ocean_start_west.reset();
        } else {
            throw std::runtime_error( "ocean_start_west must be an integer or nil" );
        }
        return *this;
    }

    region_settings_ocean_definition_handle &ocean_start_south( const sol::object &value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        if( value.is<std::int64_t>() ) {
            definition->ocean_start_south = value.as<std::int64_t>();
        } else if( value.get_type() == sol::type::lua_nil || value.get_type() == sol::type::none ) {
            definition->ocean_start_south.reset();
        } else {
            throw std::runtime_error( "ocean_start_south must be an integer or nil" );
        }
        return *this;
    }

    region_settings_ocean_definition_handle &sandy_beach_width( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings ocean" );
        definition->sandy_beach_width = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings ocean" );
        return definition->id;
    }
};

struct region_settings_forest_definition_data {
    std::string id;
    double noise_threshold_forest = 0.25;
    double noise_threshold_forest_thick = 0.3;
    double noise_threshold_swamp_adjacent_water = 0.3;
    double noise_threshold_swamp_isolated = 0.6;
    std::int64_t river_floodplain_buffer_distance_min = 3;
    std::int64_t river_floodplain_buffer_distance_max = 15;
    double forest_threshold_limit = 0.395;
    std::array<float, 4> forest_threshold_increase = { { 0.0f, 0.0f, 0.0f, 0.0f } };
    bool registered = false;
};

struct region_settings_forest_definition_handle {
    std::shared_ptr<region_settings_forest_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_forest_definition_handle &noise_threshold_forest( const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "forest noise threshold must be finite" );
        }
        definition->noise_threshold_forest = value;
        return *this;
    }

    region_settings_forest_definition_handle &noise_threshold_forest_thick( const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "thick forest noise threshold must be finite" );
        }
        definition->noise_threshold_forest_thick = value;
        return *this;
    }

    region_settings_forest_definition_handle &noise_threshold_swamp_adjacent_water(
        const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "swamp adjacent water noise threshold must be finite" );
        }
        definition->noise_threshold_swamp_adjacent_water = value;
        return *this;
    }

    region_settings_forest_definition_handle &noise_threshold_swamp_isolated( const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "swamp isolated noise threshold must be finite" );
        }
        definition->noise_threshold_swamp_isolated = value;
        return *this;
    }

    region_settings_forest_definition_handle &river_floodplain_buffer_distance_min(
        const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest" );
        definition->river_floodplain_buffer_distance_min = value;
        return *this;
    }

    region_settings_forest_definition_handle &river_floodplain_buffer_distance_max(
        const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest" );
        definition->river_floodplain_buffer_distance_max = value;
        return *this;
    }

    region_settings_forest_definition_handle &forest_threshold_limit( const double value ) {
        require_building_handle( token, *definition, "region settings forest" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "forest threshold limit must be finite" );
        }
        definition->forest_threshold_limit = value;
        return *this;
    }

    region_settings_forest_definition_handle &forest_threshold_increase( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings forest" );
        const std::size_t count = require_dense_array( values, "forest threshold increase", 4, 4 );
        for( std::size_t i = 1; i <= count; ++i ) {
            const double val = values.get<double>( i );
            if( !std::isfinite( val ) ) {
                throw std::runtime_error( "forest threshold increase entries must be finite" );
            }
            definition->forest_threshold_increase[i - 1] = static_cast<float>( val );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings forest" );
        return definition->id;
    }
};

struct region_settings_river_definition_data {
    std::string id;
    std::int64_t river_scale = 1;
    double river_frequency = 1.5;
    double river_branch_chance = 64.0;
    double river_branch_remerge_chance = 4.0;
    double river_branch_scale_decrease = 1.0;
    bool registered = false;
};

struct region_settings_river_definition_handle {
    std::shared_ptr<region_settings_river_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_river_definition_handle &river_scale( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( value < std::numeric_limits<int>::min() || value > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "river_scale out of range of int" );
        }
        definition->river_scale = value;
        return *this;
    }

    region_settings_river_definition_handle &river_frequency( const double value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "river_frequency must be finite" );
        }
        definition->river_frequency = value;
        return *this;
    }

    region_settings_river_definition_handle &river_branch_chance( const double value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "river_branch_chance must be finite" );
        }
        definition->river_branch_chance = value;
        return *this;
    }

    region_settings_river_definition_handle &river_branch_remerge_chance( const double value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "river_branch_remerge_chance must be finite" );
        }
        definition->river_branch_remerge_chance = value;
        return *this;
    }

    region_settings_river_definition_handle &river_branch_scale_decrease( const double value ) {
        require_building_handle( token, *definition, "region settings river" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "river_branch_scale_decrease must be finite" );
        }
        definition->river_branch_scale_decrease = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings river" );
        return definition->id;
    }
};

struct region_settings_forest_mapgen_definition_data {
    std::string id;
    std::vector<std::string> biomes;
    bool registered = false;
};

struct region_settings_forest_mapgen_definition_handle {
    std::shared_ptr<region_settings_forest_mapgen_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_forest_mapgen_definition_handle &biome( const std::string &value ) {
        require_building_handle( token, *definition, "region settings forest mapgen" );
        if( value.empty() ) {
            throw std::runtime_error( "forest biome mapgen id must be non-empty" );
        }
        if( std::find( definition->biomes.begin(), definition->biomes.end(), value ) !=
            definition->biomes.end() ) {
            throw std::runtime_error( "duplicate biome in region settings forest mapgen: " + value );
        }
        definition->biomes.push_back( value );
        return *this;
    }

    region_settings_forest_mapgen_definition_handle &biomes( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings forest mapgen" );
        const std::size_t count = require_dense_array( values, "region settings forest mapgen biomes", 0,
                                  1024 );
        for( std::size_t i = 1; i <= count; ++i ) {
            const std::string val = values.get<std::string>( i );
            if( val.empty() ) {
                throw std::runtime_error( "forest biome mapgen id must be non-empty" );
            }
            if( std::find( definition->biomes.begin(), definition->biomes.end(), val ) !=
                definition->biomes.end() ) {
                throw std::runtime_error( "duplicate biome in region settings forest mapgen: " + val );
            }
            definition->biomes.push_back( val );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings forest mapgen" );
        return definition->id;
    }
};

struct region_settings_map_extras_definition_data {
    std::string id;
    std::vector<std::string> extras;
    bool registered = false;
};

struct region_settings_map_extras_definition_handle {
    std::shared_ptr<region_settings_map_extras_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_map_extras_definition_handle &extra( const std::string &value ) {
        require_building_handle( token, *definition, "region settings map extras" );
        if( value.empty() ) {
            throw std::runtime_error( "map extra collection id must be non-empty" );
        }
        if( std::find( definition->extras.begin(), definition->extras.end(), value ) !=
            definition->extras.end() ) {
            throw std::runtime_error( "duplicate extra in region settings map extras: " + value );
        }
        definition->extras.push_back( value );
        return *this;
    }

    region_settings_map_extras_definition_handle &extras( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings map extras" );
        const std::size_t count = require_dense_array( values, "region settings map extras", 0, 1024 );
        for( std::size_t i = 1; i <= count; ++i ) {
            const std::string val = values.get<std::string>( i );
            if( val.empty() ) {
                throw std::runtime_error( "map extra collection id must be non-empty" );
            }
            if( std::find( definition->extras.begin(), definition->extras.end(), val ) !=
                definition->extras.end() ) {
                throw std::runtime_error( "duplicate extra in region settings map extras: " + val );
            }
            definition->extras.push_back( val );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings map extras" );
        return definition->id;
    }
};

struct region_settings_terrain_furniture_definition_data {
    std::string id;
    std::vector<std::string> ter_furn;
    bool registered = false;
};

struct region_settings_terrain_furniture_definition_handle {
    std::shared_ptr<region_settings_terrain_furniture_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_terrain_furniture_definition_handle &terrain_furniture( const std::string &value ) {
        require_building_handle( token, *definition, "region settings terrain furniture" );
        if( value.empty() ) {
            throw std::runtime_error( "region terrain furniture id must be non-empty" );
        }
        if( std::find( definition->ter_furn.begin(), definition->ter_furn.end(), value ) !=
            definition->ter_furn.end() ) {
            throw std::runtime_error(
                "duplicate terrain furniture in region settings terrain furniture: " + value );
        }
        definition->ter_furn.push_back( value );
        return *this;
    }

    region_settings_terrain_furniture_definition_handle &ter_furn( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings terrain furniture" );
        const std::size_t count = require_dense_array( values, "region settings terrain furniture", 0,
                                  1024 );
        for( std::size_t i = 1; i <= count; ++i ) {
            const std::string val = values.get<std::string>( i );
            if( val.empty() ) {
                throw std::runtime_error( "region terrain furniture id must be non-empty" );
            }
            if( std::find( definition->ter_furn.begin(), definition->ter_furn.end(), val ) !=
                definition->ter_furn.end() ) {
                throw std::runtime_error(
                    "duplicate terrain furniture in region settings terrain furniture: " + val );
            }
            definition->ter_furn.push_back( val );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings terrain furniture" );
        return definition->id;
    }
};

struct region_settings_forest_trail_definition_data {
    std::string id;
    std::int64_t chance = 1;
    std::int64_t border_point_chance = 2;
    std::int64_t minimum_forest_size = 50;
    std::int64_t random_point_min = 4;
    std::int64_t random_point_max = 50;
    std::int64_t random_point_size_scalar = 100;
    std::int64_t trailhead_chance = 1;
    std::int64_t trailhead_road_distance = 6;
    std::vector<std::pair<std::string, std::int64_t>> trailheads;
    bool registered = false;
};

struct region_settings_forest_trail_definition_handle {
    std::shared_ptr<region_settings_forest_trail_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_forest_trail_definition_handle &chance( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->chance = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &border_point_chance( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->border_point_chance = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &minimum_forest_size( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->minimum_forest_size = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &random_point_min( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->random_point_min = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &random_point_max( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->random_point_max = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &random_point_size_scalar(
        const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->random_point_size_scalar = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &trailhead_chance( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->trailhead_chance = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &trailhead_road_distance(
        const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        definition->trailhead_road_distance = value;
        return *this;
    }

    region_settings_forest_trail_definition_handle &trailhead( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings forest trail" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "region settings forest trail trailhead needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->trailheads, special_id, weight );
        return *this;
    }

    region_settings_forest_trail_definition_handle &add_trailhead( const std::string &special_id,
            const std::int64_t weight ) {
        return trailhead( special_id, weight );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings forest trail" );
        return definition->id;
    }
};

struct region_settings_highway_definition_data {
    std::string id;
    std::int64_t width_of_segments = 2;
    double straightness_chance = 0.6;
    std::string reserved_terrain_id;
    std::string reserved_terrain_water_id;
    std::string segment_flat_special;
    std::string segment_ramp_special;
    std::string segment_road_bridge_special;
    std::string segment_bridge_special;
    std::string segment_bridge_supports_special;
    std::string segment_overpass_special;
    std::string clockwise_slant_special;
    std::string counterclockwise_slant_special;
    std::string fallback_onramp_special;
    std::string fallback_bend_special;
    std::string fallback_three_way_intersection_special;
    std::string fallback_four_way_intersection_special;
    std::string fallback_supports;
    std::vector<std::pair<std::string, std::int64_t>> four_way_intersections;
    std::vector<std::pair<std::string, std::int64_t>> three_way_intersections;
    std::vector<std::pair<std::string, std::int64_t>> bends;
    std::vector<std::pair<std::string, std::int64_t>> road_connections;
    std::vector<std::pair<std::string, std::int64_t>> interchanges;
    bool registered = false;
};

struct region_settings_highway_definition_handle {
    std::shared_ptr<region_settings_highway_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_highway_definition_handle &width_of_segments( const std::int64_t value ) {
        require_building_handle( token, *definition, "region settings highway" );
        definition->width_of_segments = value;
        return *this;
    }

    region_settings_highway_definition_handle &straightness_chance( const double value ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "highway straightness chance must be finite" );
        }
        definition->straightness_chance = value;
        return *this;
    }

#define CCB_HIGHWAY_STRING_SETTER( name ) \
    region_settings_highway_definition_handle &name( const std::string &value ) { \
        require_building_handle( token, *definition, "region settings highway" ); \
        definition->name = value; \
        return *this; \
    }

    CCB_HIGHWAY_STRING_SETTER( reserved_terrain_id )
    CCB_HIGHWAY_STRING_SETTER( reserved_terrain_water_id )
    CCB_HIGHWAY_STRING_SETTER( segment_flat_special )
    CCB_HIGHWAY_STRING_SETTER( segment_ramp_special )
    CCB_HIGHWAY_STRING_SETTER( segment_road_bridge_special )
    CCB_HIGHWAY_STRING_SETTER( segment_bridge_special )
    CCB_HIGHWAY_STRING_SETTER( segment_bridge_supports_special )
    CCB_HIGHWAY_STRING_SETTER( segment_overpass_special )
    CCB_HIGHWAY_STRING_SETTER( clockwise_slant_special )
    CCB_HIGHWAY_STRING_SETTER( counterclockwise_slant_special )
    CCB_HIGHWAY_STRING_SETTER( fallback_onramp_special )
    CCB_HIGHWAY_STRING_SETTER( fallback_bend_special )
    CCB_HIGHWAY_STRING_SETTER( fallback_three_way_intersection_special )
    CCB_HIGHWAY_STRING_SETTER( fallback_four_way_intersection_special )
    CCB_HIGHWAY_STRING_SETTER( fallback_supports )

#undef CCB_HIGHWAY_STRING_SETTER

    region_settings_highway_definition_handle &four_way_intersection( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway four_way_intersection needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->four_way_intersections, special_id, weight );
        return *this;
    }

    region_settings_highway_definition_handle &three_way_intersection( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway three_way_intersection needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->three_way_intersections, special_id, weight );
        return *this;
    }

    region_settings_highway_definition_handle &bend( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway bend needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->bends, special_id, weight );
        return *this;
    }

    region_settings_highway_definition_handle &road_connection( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway road_connection needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->road_connections, special_id, weight );
        return *this;
    }

    region_settings_highway_definition_handle &interchange( const std::string &special_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings highway" );
        if( special_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "highway interchange needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->interchanges, special_id, weight );
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings highway" );
        return definition->id;
    }
};

struct region_settings_definition_data {
    std::string id;
    std::vector<std::string> default_oter;
    std::vector<std::pair<std::string, std::int64_t>> default_groundcover;
    bool default_groundcover_set = false;
    std::string cities;
    std::string forest_composition;
    std::string forest_trails;
    std::string weather;
    std::string forests;
    std::string rivers;
    std::string lakes;
    std::string ocean;
    std::string highways;
    std::string ravines;
    std::string map_extras;
    std::string terrain_furniture;
    std::vector<std::string> feature_blacklist;
    std::vector<std::string> feature_whitelist;
    std::string trail_connection;
    std::string sewer_connection;
    std::string subway_connection;
    std::string rail_connection;
    std::string intra_city_road_connection;
    std::string inter_city_road_connection;
    bool place_swamps = true;
    bool place_roads = true;
    bool place_railroads = false;
    bool place_railroads_before_roads = false;
    bool place_specials = true;
    bool neighbor_connections = true;
    double max_urbanity = 8.0;
    std::array<float, 4> urbanity_increase = { 0.0f, 0.0f, 0.0f, 0.0f };
    bool registered = false;
};

struct region_settings_definition_handle {
    std::shared_ptr<region_settings_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_settings_definition_handle &default_oter( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings" );
        const std::size_t count = require_dense_array(
                                      values, "region settings default_oter",
                                      OVERMAP_LAYERS, OVERMAP_LAYERS );
        definition->default_oter.clear();
        definition->default_oter.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            definition->default_oter.push_back( values.get<std::string>( index ) );
        }
        return *this;
    }

    region_settings_definition_handle &default_groundcover( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings" );
        definition->default_groundcover.clear();
        definition->default_groundcover_set = true;
        parse_weighted_table_entries( values, "region settings default_groundcover",
                                      definition->default_groundcover );
        return *this;
    }

    region_settings_definition_handle &groundcover( const std::string &terrain_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region settings" );
        if( terrain_id.empty() || weight <= 0 ) {
            throw std::runtime_error(
                "region settings groundcover needs a terrain id and positive weight" );
        }
        definition->default_groundcover_set = true;
        add_or_replace_weighted_entry( definition->default_groundcover,
                                       terrain_id, weight );
        return *this;
    }

    region_settings_definition_handle &feature_blacklisted( const std::string &flag ) {
        require_building_handle( token, *definition, "region settings" );
        if( flag.empty() ) {
            throw std::runtime_error( "region settings feature flag cannot be empty" );
        }
        if( std::find( definition->feature_blacklist.begin(),
                      definition->feature_blacklist.end(), flag ) ==
            definition->feature_blacklist.end() ) {
            definition->feature_blacklist.push_back( flag );
        }
        return *this;
    }

    region_settings_definition_handle &feature_whitelisted( const std::string &flag ) {
        require_building_handle( token, *definition, "region settings" );
        if( flag.empty() ) {
            throw std::runtime_error( "region settings feature flag cannot be empty" );
        }
        if( std::find( definition->feature_whitelist.begin(),
                      definition->feature_whitelist.end(), flag ) ==
            definition->feature_whitelist.end() ) {
            definition->feature_whitelist.push_back( flag );
        }
        return *this;
    }

#define CCB_REGION_SETTINGS_STRING_SETTER( name ) \
    region_settings_definition_handle &name( const std::string &value ) { \
        require_building_handle( token, *definition, "region settings" ); \
        definition->name = value; \
        return *this; \
    }

    CCB_REGION_SETTINGS_STRING_SETTER( cities )
    CCB_REGION_SETTINGS_STRING_SETTER( forest_composition )
    CCB_REGION_SETTINGS_STRING_SETTER( forest_trails )
    CCB_REGION_SETTINGS_STRING_SETTER( weather )
    CCB_REGION_SETTINGS_STRING_SETTER( forests )
    CCB_REGION_SETTINGS_STRING_SETTER( rivers )
    CCB_REGION_SETTINGS_STRING_SETTER( lakes )
    CCB_REGION_SETTINGS_STRING_SETTER( ocean )
    CCB_REGION_SETTINGS_STRING_SETTER( highways )
    CCB_REGION_SETTINGS_STRING_SETTER( ravines )
    CCB_REGION_SETTINGS_STRING_SETTER( map_extras )
    CCB_REGION_SETTINGS_STRING_SETTER( terrain_furniture )
    CCB_REGION_SETTINGS_STRING_SETTER( trail_connection )
    CCB_REGION_SETTINGS_STRING_SETTER( sewer_connection )
    CCB_REGION_SETTINGS_STRING_SETTER( subway_connection )
    CCB_REGION_SETTINGS_STRING_SETTER( rail_connection )
    CCB_REGION_SETTINGS_STRING_SETTER( intra_city_road_connection )
    CCB_REGION_SETTINGS_STRING_SETTER( inter_city_road_connection )

#undef CCB_REGION_SETTINGS_STRING_SETTER

#define CCB_REGION_SETTINGS_BOOL_SETTER( name ) \
    region_settings_definition_handle &name( const bool value ) { \
        require_building_handle( token, *definition, "region settings" ); \
        definition->name = value; \
        return *this; \
    }

    CCB_REGION_SETTINGS_BOOL_SETTER( place_swamps )
    CCB_REGION_SETTINGS_BOOL_SETTER( place_roads )
    CCB_REGION_SETTINGS_BOOL_SETTER( place_railroads )
    CCB_REGION_SETTINGS_BOOL_SETTER( place_railroads_before_roads )
    CCB_REGION_SETTINGS_BOOL_SETTER( place_specials )
    CCB_REGION_SETTINGS_BOOL_SETTER( neighbor_connections )

#undef CCB_REGION_SETTINGS_BOOL_SETTER

    region_settings_definition_handle &max_urbanity( const double value ) {
        require_building_handle( token, *definition, "region settings" );
        if( !std::isfinite( value ) ) {
            throw std::runtime_error( "region settings max urbanity must be finite" );
        }
        definition->max_urbanity = value;
        return *this;
    }

    region_settings_definition_handle &urbanity_increase( const sol::table &values ) {
        require_building_handle( token, *definition, "region settings" );
        const std::size_t count = require_dense_array(
                                      values, "region settings urbanity_increase", 4, 4 );
        for( std::size_t index = 1; index <= count; ++index ) {
            const double value = values.get<double>( index );
            if( !std::isfinite( value ) ||
                value < std::numeric_limits<float>::lowest() ||
                value > std::numeric_limits<float>::max() ) {
                throw std::runtime_error(
                    "region settings urbanity increase must contain finite native floats" );
            }
            definition->urbanity_increase[index - 1] = static_cast<float>( value );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region settings" );
        return definition->id;
    }
};

detail::option_slider_native_level read_option_slider_level(
    const sol::table &value )
{
    detail::option_slider_native_level result;
    const sol::object level_value = value.raw_get<sol::object>( "level" );
    const sol::object name_value = value.raw_get<sol::object>( "name" );
    if( !level_value.is<lua_Integer>() || !name_value.is<std::string>() ) {
        throw std::runtime_error(
            "option slider levels require a native integer level and string name" );
    }
    result.level = level_value.as<std::int64_t>();
    result.name = name_value.as<std::string>();
    result.description = value.get_or( "description", std::string() );

    const sol::optional<sol::table> options =
        value.get<sol::optional<sol::table>>( "options" );
    if( !options ) {
        return result;
    }
    const std::size_t count = require_dense_array(
                                  *options, "option slider level options", 0, 512 );
    result.options.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object entry = options->raw_get<sol::object>( index );
        if( !entry.is<sol::table>() ) {
            throw std::runtime_error( "option slider options must be tables" );
        }
        const sol::table option = entry.as<sol::table>();
        detail::option_slider_native_option native_option;
        native_option.option = option.get_or( "option", std::string() );
        native_option.type = option.get_or( "type", std::string() );
        const sol::object option_value = option.raw_get<sol::object>( "value" );
        if( native_option.type == "int" ) {
            if( !option_value.is<lua_Integer>() ) {
                throw std::runtime_error(
                    "option slider int values must be native integers" );
            }
            const std::int64_t integer = option_value.as<std::int64_t>();
            if( !fits_native_int( integer ) ) {
                throw std::runtime_error(
                    "option slider int value is outside the native range" );
            }
            native_option.value = std::to_string( integer );
        } else if( native_option.type == "float" ) {
            if( !option_value.is<double>() ) {
                throw std::runtime_error( "option slider float values must be numbers" );
            }
            const double number = option_value.as<double>();
            if( !std::isfinite( number ) ) {
                throw std::runtime_error( "option slider float values must be finite" );
            }
            std::ostringstream stream;
            stream << std::setprecision( std::numeric_limits<double>::max_digits10 ) << number;
            native_option.value = stream.str();
        } else if( native_option.type == "bool" ) {
            if( !option_value.is<bool>() ) {
                throw std::runtime_error( "option slider bool values must be booleans" );
            }
            native_option.value = option_value.as<bool>() ? "true" : "false";
        } else if( native_option.type == "string" ) {
            if( !option_value.is<std::string>() ) {
                throw std::runtime_error( "option slider string values must be strings" );
            }
            native_option.value = option_value.as<std::string>();
        } else {
            throw std::runtime_error( "option slider option has unknown value type '" +
                                      native_option.type + "'" );
        }
        result.options.push_back( std::move( native_option ) );
    }
    return result;
}

struct option_slider_definition_handle {
    std::shared_ptr<detail::option_slider_native_definition> definition;
    std::shared_ptr<owner_token> token;

    option_slider_definition_handle &name( const std::string &value ) {
        require_building_handle( token, *definition, "option slider" );
        definition->name = value;
        return *this;
    }

    option_slider_definition_handle &context( const std::string &value ) {
        require_building_handle( token, *definition, "option slider" );
        definition->context = value;
        return *this;
    }

    option_slider_definition_handle &default_level( const std::int64_t value ) {
        require_building_handle( token, *definition, "option slider" );
        definition->default_level = value;
        return *this;
    }

    option_slider_definition_handle &levels( const sol::table &values ) {
        require_building_handle( token, *definition, "option slider" );
        const std::size_t count = require_dense_array(
                                      values, "option slider levels", 1, 256 );
        definition->levels.clear();
        definition->levels.reserve( count );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = values.raw_get<sol::object>( index );
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "option slider levels must be tables" );
            }
            definition->levels.push_back(
                read_option_slider_level( value.as<sol::table>() ) );
        }
        return *this;
    }

    option_slider_definition_handle &level( const sol::table &value ) {
        require_building_handle( token, *definition, "option slider" );
        detail::option_slider_native_level replacement = read_option_slider_level( value );
        const auto found = std::find_if(
                               definition->levels.begin(), definition->levels.end(),
        [&replacement]( const detail::option_slider_native_level & existing ) {
            return existing.level == replacement.level;
        } );
        if( found == definition->levels.end() ) {
            if( definition->levels.size() >= 256 ) {
                throw std::runtime_error( "option slider exceeds the Platform level limit" );
            }
            definition->levels.push_back( std::move( replacement ) );
        } else {
            *found = std::move( replacement );
        }
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "option slider" );
        return definition->id;
    }
};

struct dimension_definition_handle {
    std::shared_ptr<detail::dimension_native_definition> definition;
    std::shared_ptr<owner_token> token;

    dimension_definition_handle &region_layout( const std::string &value ) {
        require_building_handle( token, *definition, "dimension" );
        definition->region_layout = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "dimension" );
        return definition->id;
    }
};

struct dimension_region_layout_definition_handle {
    std::shared_ptr<detail::dimension_region_layout_native_definition> definition;
    std::shared_ptr<owner_token> token;

    dimension_region_layout_definition_handle &generation_mode(
        const std::string &value ) {
        require_building_handle( token, *definition, "dimension region layout" );
        definition->generation_mode = value;
        return *this;
    }

    dimension_region_layout_definition_handle &uniform_region(
        const std::string &value ) {
        require_building_handle( token, *definition, "dimension region layout" );
        definition->uniform_region = value;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "dimension region layout" );
        return definition->id;
    }
};

struct omt_placeholder_definition_data {
    std::string id;
    std::array<std::string, 24> grid;
    bool grid_set = false;
    bool registered = false;
};

struct omt_placeholder_definition_handle {
    std::shared_ptr<omt_placeholder_definition_data> definition;
    std::shared_ptr<owner_token> token;

    omt_placeholder_definition_handle &grid( const sol::table &values ) {
        require_building_handle( token, *definition, "overmap terrain placeholder" );
        require_dense_array( values, "overmap terrain placeholder grid", 24, 24 );
        for( std::size_t index = 1; index <= definition->grid.size(); ++index ) {
            const std::string row = values.get<std::string>( index );
            if( row.size() != 24 ||
                std::any_of( row.begin(), row.end(), []( const char value ) {
                return value != '0' && value != '1';
            } ) ) {
                throw std::runtime_error(
                    "overmap terrain placeholder grid rows need exactly 24 binary cells" );
            }
            definition->grid[index - 1] = row;
        }
        definition->grid_set = true;
        return *this;
    }

    std::string id() const {
        require_readable_handle( token, *definition, "overmap terrain placeholder" );
        return definition->id;
    }
};

struct region_terrain_furniture_definition_data {
    std::string id;
    std::string ter_id;
    std::string furn_id;
    std::vector<std::pair<std::string, std::int64_t>> replace_with_terrain;
    std::vector<std::pair<std::string, std::int64_t>> replace_with_furniture;
    bool registered = false;
};

struct region_terrain_furniture_definition_handle {
    std::shared_ptr<region_terrain_furniture_definition_data> definition;
    std::shared_ptr<owner_token> token;

    region_terrain_furniture_definition_handle &ter_id( const std::string &value ) {
        require_building_handle( token, *definition, "region terrain furniture" );
        definition->ter_id = value;
        return *this;
    }

    region_terrain_furniture_definition_handle &furn_id( const std::string &value ) {
        require_building_handle( token, *definition, "region terrain furniture" );
        definition->furn_id = value;
        return *this;
    }

    region_terrain_furniture_definition_handle &replace_terrain( const std::string &terrain_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region terrain furniture" );
        if( terrain_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "region terrain furniture replace_terrain needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->replace_with_terrain, terrain_id, weight );
        return *this;
    }

    region_terrain_furniture_definition_handle &replace_with_terrain( const std::string &terrain_id,
            const std::int64_t weight ) {
        return replace_terrain( terrain_id, weight );
    }

    region_terrain_furniture_definition_handle &replace_furniture( const std::string &furniture_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "region terrain furniture" );
        if( furniture_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "region terrain furniture replace_furniture needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->replace_with_furniture, furniture_id, weight );
        return *this;
    }

    region_terrain_furniture_definition_handle &replace_with_furniture( const std::string &furniture_id,
            const std::int64_t weight ) {
        return replace_furniture( furniture_id, weight );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "region terrain furniture" );
        return definition->id;
    }
};

struct forest_biome_component_definition_data {
    std::string id;
    std::int64_t chance = 0;
    std::int64_t sequence = 0;
    std::vector<std::pair<std::string, std::int64_t>> types;
    bool registered = false;
};

struct forest_biome_component_definition_handle {
    std::shared_ptr<forest_biome_component_definition_data> definition;
    std::shared_ptr<owner_token> token;

    forest_biome_component_definition_handle &chance( const std::int64_t value ) {
        require_building_handle( token, *definition, "forest biome component" );
        definition->chance = value;
        return *this;
    }

    forest_biome_component_definition_handle &sequence( const std::int64_t value ) {
        require_building_handle( token, *definition, "forest biome component" );
        definition->sequence = value;
        return *this;
    }

    forest_biome_component_definition_handle &type( const std::string &ter_furn_id,
            const std::int64_t weight ) {
        require_building_handle( token, *definition, "forest biome component" );
        if( ter_furn_id.empty() || weight <= 0 ) {
            throw std::runtime_error( "forest biome component type needs an id and positive weight" );
        }
        add_or_replace_weighted_entry( definition->types, ter_furn_id, weight );
        return *this;
    }

    forest_biome_component_definition_handle &add_type( const std::string &ter_furn_id,
            const std::int64_t weight ) {
        return type( ter_furn_id, weight );
    }

    std::string id() const {
        require_readable_handle( token, *definition, "forest biome component" );
        return definition->id;
    }
};

struct city_definition_data {
    std::string id;
    std::int64_t database_id = 0;
    bool database_id_set = false;
    std::string name;
    std::int64_t population = 0;
    std::int64_t size = -1;
    std::int64_t pos_om_x = 0;
    std::int64_t pos_om_y = 0;
    bool pos_om_set = false;
    std::int64_t pos_x = 0;
    std::int64_t pos_y = 0;
    bool pos_set = false;
    bool registered = false;
};

struct city_definition_handle {
    std::shared_ptr<city_definition_data> definition;
    std::shared_ptr<owner_token> token;

    city_definition_handle &database_id( const std::int64_t value ) {
        require_building_handle( token, *definition, "city" );
        if( !fits_native_int( value ) ) {
            throw std::runtime_error( "city database_id outside native integer range" );
        }
        definition->database_id = value;
        definition->datab…62152 tokens truncated…issect_failure );
        for( const std::string &skill : value.skills ) {
            hash_part( state, skill );
        }
    }
    for( const harvest_registration &entry : pimpl_->harvests ) {
        hash_part( state, "harvest" );
        hash_part( state, operation_name( entry.operation ) );
        const harvest_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.message );
        hash_part( state, value.leftovers );
        hash_part( state, value.butchery_requirements );
        for( const harvest_entry_definition_data &drop : value.entries ) {
            hash_part( state, drop.output );
            hash_part( state, drop.category );
            hash_part( state, std::to_string( drop.base_minimum ) );
            hash_part( state, std::to_string( drop.base_maximum ) );
            hash_part( state, std::to_string( drop.skill_minimum ) );
            hash_part( state, std::to_string( drop.skill_maximum ) );
            hash_part( state, std::to_string( drop.maximum ) );
            hash_part( state, std::to_string( drop.mass_ratio ) );
            for( const std::string &flag : drop.flags ) {
                hash_part( state, "flag" );
                hash_part( state, flag );
            }
            for( const std::string &fault : drop.faults ) {
                hash_part( state, "fault" );
                hash_part( state, fault );
            }
        }
    }
    for( const behavior_registration &entry : pimpl_->behaviors ) {
        hash_part( state, "behavior" );
        hash_part( state, operation_name( entry.operation ) );
        const behavior_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.strategy );
        hash_part( state, value.goal );
        for( const std::string &child : value.children ) {
            hash_part( state, "child" );
            hash_part( state, child );
        }
        for( const behavior_condition_definition_data &condition : value.conditions ) {
            hash_part( state, condition.native ? "native_condition" : "lua_condition" );
            hash_part( state, condition.policy );
            hash_part( state, condition.argument );
            hash_part( state, condition.inverted ? "inverted" : "direct" );
        }
        if( value.score ) {
            hash_part( state, value.score->native ? "native_score" : "lua_score" );
            hash_part( state, value.score->policy );
            hash_part( state, value.score->argument );
        } else {
            hash_part( state, "no_score" );
        }
    }
    for( const effect_type_registration &entry : pimpl_->effect_types ) {
        hash_part( state, "effect_type" );
        hash_part( state, operation_name( entry.operation ) );
        const effect_type_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        for( const std::string &text : value.names ) {
            hash_part( state, "name" );
            hash_part( state, text );
        }
        for( const std::string &text : value.descriptions ) {
            hash_part( state, "description" );
            hash_part( state, text );
        }
        for( const std::string &text : value.reduced_descriptions ) {
            hash_part( state, "reduced_description" );
            hash_part( state, text );
        }
        hash_part( state, value.remove_message );
        hash_part( state, value.apply_memorial_log );
        hash_part( state, value.remove_memorial_log );
        hash_part( state, value.blood_analysis_description );
        hash_part( state, std::to_string( value.maximum_intensity ) );
        hash_part( state, std::to_string( value.maximum_duration_turns ) );
        hash_part( state, std::to_string( value.intensity_duration_turns ) );
        hash_part( state, std::to_string( value.duration_add_percent ) );
        hash_part( state, std::to_string( value.intensity_add_value ) );
        hash_part( state, std::to_string( value.intensity_decay_step ) );
        hash_part( state, std::to_string( value.intensity_decay_tick ) );
        hash_part( state, value.intensity_decay_removes ? "decay_removes" : "decay_keeps" );
        hash_part( state, value.main_parts_only ? "main_parts" : "all_parts" );
        hash_part( state, value.show_in_info ? "show_info" : "hide_info" );
        hash_part( state, value.show_intensity ? "show_intensity" : "hide_intensity" );
        hash_part( state, value.part_descriptions ? "part_descriptions" : "global_descriptions" );
        const auto hash_ids = [&]( const std::string_view kind,
        const std::set<std::string> &ids ) {
            for( const std::string &id : ids ) {
                hash_part( state, kind );
                hash_part( state, id );
            }
        };
        hash_ids( "flag", value.flags );
        hash_ids( "immune_character_flag", value.immune_character_flags );
        hash_ids( "immune_bodypart_flag", value.immune_bodypart_flags );
        hash_ids( "resist_trait", value.resist_traits );
        hash_ids( "resist_effect", value.resist_effects );
        hash_ids( "removes_effect", value.removes_effects );
        hash_ids( "blocks_effect", value.blocks_effects );
    }
    for( const sub_body_part_registration &entry : pimpl_->sub_body_parts ) {
        hash_part( state, "sub_body_part" );
        hash_part( state, operation_name( entry.operation ) );
        const sub_body_part_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.plural_name );
        hash_part( state, value.parent );
        hash_part( state, value.opposite );
        hash_part( state, value.side );
        hash_part( state, value.secondary ? "secondary" : "primary" );
        hash_part( state, std::to_string( value.maximum_coverage ) );
        hash_part( state, value.similar_body_part );
        for( const std::string &location : value.locations_under ) {
            hash_part( state, "under" );
            hash_part( state, location );
        }
        for( const auto &[damage_id, amount] : value.unarmed_damage ) {
            hash_part( state, damage_id );
            hash_part( state, std::to_string( amount ) );
        }
    }
    for( const wound_type_registration &entry : pimpl_->wound_types ) {
        hash_part( state, "wound" );
        hash_part( state, operation_name( entry.operation ) );
        const wound_type_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.plural_name );
        hash_part( state, value.description );
        hash_part( state, std::to_string( value.pain_min ) );
        hash_part( state, std::to_string( value.pain_max ) );
        hash_part( state, std::to_string( value.healing_min_turns ) );
        hash_part( state, std::to_string( value.healing_max_turns ) );
        hash_part( state, std::to_string( value.damage_min ) );
        hash_part( state, std::to_string( value.damage_max ) );
        hash_part( state, std::to_string( value.weight ) );
        hash_part( state, std::to_string( value.per_part_limit ) );
        hash_part( state, value.required_body_part_flag );
        hash_part( state, value.forbidden_body_part_flag );
        for( const std::string &damage_type : value.damage_types ) {
            hash_part( state, "damage_type" );
            hash_part( state, damage_type );
        }
        for( const wound_limb_score_definition_data &score : value.limb_scores ) {
            hash_part( state, "limb_score" );
            hash_part( state, score.id );
            hash_part( state, std::to_string( score.penalty ) );
        }
        for( const wound_progression_definition_data &progression : value.progressions ) {
            hash_part( state, "progression" );
            hash_part( state, progression.id );
            hash_part( state, std::to_string( progression.chance ) );
        }
        for( const std::string &kind : value.required_body_part_types ) {
            hash_part( state, "require_body_part_type" );
            hash_part( state, kind );
        }
        for( const std::string &kind : value.forbidden_body_part_types ) {
            hash_part( state, "forbid_body_part_type" );
            hash_part( state, kind );
        }
    }
    for( const body_part_registration &entry : pimpl_->body_parts ) {
        hash_part( state, "body_part" );
        hash_part( state, operation_name( entry.operation ) );
        const body_part_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.plural_name );
        hash_part( state, value.accusative );
        hash_part( state, value.plural_accusative );
        hash_part( state, value.heading );
        hash_part( state, value.plural_heading );
        hash_part( state, value.encumbrance_text );
        hash_part( state, value.hp_bar_text );
        hash_part( state, value.main_part );
        hash_part( state, value.connected_to );
        hash_part( state, value.opposite );
        hash_part( state, value.side );
        hash_part( state, std::to_string( value.hit_size ) );
        hash_part( state, std::to_string( value.hit_difficulty ) );
        hash_part( state, std::to_string( value.base_health ) );
        hash_part( state, std::to_string( value.drench_capacity ) );
        hash_part( state, value.limb ? "limb" : "not_limb" );
        hash_part( state, value.vital ? "vital" : "not_vital" );
        for( const std::string &sub_part : value.sub_parts ) {
            hash_part( state, "sub_part" );
            hash_part( state, sub_part );
        }
        for( const auto &[kind, weight] : value.limb_types ) {
            hash_part( state, kind );
            hash_part( state, std::to_string( weight ) );
        }
        const auto hash_damage_values = [&]( const std::string_view label,
        const std::map<std::string, double> &values ) {
            for( const auto &[damage_id, amount] : values ) {
                hash_part( state, label );
                hash_part( state, damage_id );
                hash_part( state, std::to_string( amount ) );
            }
        };
        hash_damage_values( "armor", value.armor );
        hash_damage_values( "unarmed", value.unarmed_damage );
        for( const std::string &flag : value.flags ) {
            hash_part( state, "flag" );
            hash_part( state, flag );
        }
        for( const auto &[score_id, score] : value.limb_scores ) {
            hash_part( state, score_id );
            hash_part( state, std::to_string( score.score ) );
            hash_part( state, std::to_string( score.maximum ) );
        }
        for( const body_part_quality_definition_data &quality : value.qualities ) {
            hash_part( state, quality.id );
            hash_part( state, std::to_string( quality.level ) );
            hash_part( state, std::to_string( quality.disable_fraction ) );
        }
    }
    for( const anatomy_registration &entry : pimpl_->anatomies ) {
        hash_part( state, "anatomy" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const std::string &part : entry.definition->parts ) {
            hash_part( state, part );
        }
    }
    for( const body_graph_registration &entry : pimpl_->body_graphs ) {
        hash_part( state, "body_graph" );
        hash_part( state, operation_name( entry.operation ) );
        const body_graph_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.parent_body_part );
        hash_part( state, value.mirror );
        hash_part( state, value.label_fill );
        hash_part( state, value.fill_symbol );
        hash_part( state, value.fill_color );
        for( const std::string &row : value.rows ) {
            hash_part( state, "row" );
            hash_part( state, row );
        }
        for( const std::string &row : value.fill_rows ) {
            hash_part( state, "fill_row" );
            hash_part( state, row );
        }
        for( const body_graph_part_definition_data &part : value.parts ) {
            hash_part( state, part.symbol );
            hash_part( state, part.nested_graph );
            hash_part( state, part.selected_color );
            hash_part( state, part.display_symbol );
            for( const std::string &id : part.body_parts ) {
                hash_part( state, "body" );
                hash_part( state, id );
            }
            for( const std::string &id : part.sub_body_parts ) {
                hash_part( state, "sub_body" );
                hash_part( state, id );
            }
        }
    }
    for( const monster_registration &entry : pimpl_->monsters ) {
        hash_part( state, "monster" );
        hash_part( state, operation_name( entry.operation ) );
        const monster_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.plural_name );
        hash_part( state, value.description );
        hash_part( state, value.symbol );
        hash_part( state, value.color );
        hash_part( state, value.looks_like );
        hash_part( state, value.body_type );
        hash_part( state, value.default_faction );
        hash_part( state, value.harvest );
        hash_part( state, value.dissect );
        hash_part( state, value.decay );
        hash_part( state, value.speed_description );
        hash_part( state, value.death_drops );
        hash_part( state, std::to_string( value.volume_ml ) );
        hash_part( state, std::to_string( value.weight_grams ) );
        hash_part( state, value.phase );
        hash_part( state, std::to_string( value.difficulty_adjustment ) );
        hash_part( state, std::to_string( value.hp ) );
        hash_part( state, std::to_string( value.speed ) );
        hash_part( state, std::to_string( value.aggression ) );
        hash_part( state, std::to_string( value.morale ) );
        hash_part( state, std::to_string( value.tracking_distance ) );
        hash_part( state, std::to_string( value.attack_cost ) );
        hash_part( state, std::to_string( value.melee_skill ) );
        hash_part( state, std::to_string( value.melee_dice ) );
        hash_part( state, std::to_string( value.melee_sides ) );
        hash_part( state, std::to_string( value.melee_armor_penetration ) );
        hash_part( state, std::to_string( value.dodge ) );
        hash_part( state, std::to_string( value.vision_day ) );
        hash_part( state, std::to_string( value.vision_night ) );
        hash_part( state, std::to_string( value.regenerates ) );
        hash_part( state, std::to_string( value.bleed_rate ) );
        hash_part( state, std::to_string( value.status_chance_multiplier ) );
        hash_part( state, std::to_string( value.luminance ) );
        hash_part( state, value.regenerates_in_dark ? "dark_regen" : "no_dark_regen" );
        hash_part( state, value.regenerates_morale ? "morale_regen" : "no_morale_regen" );
        hash_part( state, value.aggressive_to_characters ? "character_aggro" : "selective_aggro" );
        for( const auto &[id, portions] : value.materials ) {
            hash_part( state, "material" );
            hash_part( state, id );
            hash_part( state, std::to_string( portions ) );
        }
        const auto hash_ids = [&]( const std::string_view label,
        const std::set<std::string> &ids ) {
            for( const std::string &id : ids ) {
                hash_part( state, label );
                hash_part( state, id );
            }
        };
        hash_ids( "species", value.species );
        hash_ids( "category", value.categories );
        hash_ids( "flag", value.flags );
        hash_ids( "track_scent", value.tracked_scents );
        hash_ids( "ignore_scent", value.ignored_scents );
        hash_ids( "anger", value.anger_triggers );
        hash_ids( "fear", value.fear_triggers );
        hash_ids( "placate", value.placate_triggers );
        for( const auto &[id, amount] : value.armor ) {
            hash_part( state, "armor" );
            hash_part( state, id );
            hash_part( state, std::to_string( amount ) );
        }
        for( const auto &[id, damage] : value.melee_damage ) {
            hash_part( state, "melee_damage" );
            hash_part( state, id );
            hash_part( state, std::to_string( damage.amount ) );
            hash_part( state, std::to_string( damage.armor_penetration ) );
        }
        for( const monster_attack_reference_definition_data &attack : value.attacks ) {
            hash_part( state, "attack" );
            hash_part( state, attack.id );
            hash_part( state, attack.cooldown ? std::to_string( *attack.cooldown ) :
                       "native_cooldown" );
        }
        for( const auto &[attack_id, handler_id] : value.attack_handlers ) {
            hash_part( state, attack_id );
            hash_part( state, handler_id );
        }
        for( const std::string &set : value.weakpoint_sets ) {
            hash_part( state, "weakpoint_set" );
            hash_part( state, set );
        }
        const auto hash_int_map = [&]( const std::string_view label,
        const std::map<std::string, std::int64_t> &values ) {
            for( const auto &[id, amount] : values ) {
                hash_part( state, label );
                hash_part( state, id );
                hash_part( state, std::to_string( amount ) );
            }
        };
        hash_int_map( "emission", value.emissions );
        hash_int_map( "starting_ammo", value.starting_ammo );
        hash_int_map( "regeneration_modifier", value.regeneration_modifiers );
        for( const std::string &goal : value.goals ) {
            hash_part( state, "goal" );
            hash_part( state, goal );
        }
        hash_part( state, value.death_handler );
    }
    for( const field_type_registration &entry : pimpl_->field_types ) {
        hash_part( state, "field_type" );
        hash_part( state, operation_name( entry.operation ) );
        const field_type_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, std::to_string( value.underwater_age_speedup_turns ) );
        hash_part( state, std::to_string( value.outdoor_age_speedup_turns ) );
        hash_part( state, std::to_string( value.decay_amount_factor ) );
        hash_part( state, std::to_string( value.percent_spread ) );
        hash_part( state, std::to_string( value.gas_absorption_turns ) );
        hash_part( state, std::to_string( value.priority ) );
        hash_part( state, std::to_string( value.half_life_turns ) );
        hash_part( state, value.phase );
        hash_part( state, value.description_affix );
        hash_part( state, value.wandering_field );
        hash_part( state, value.looks_like );
        hash_part( state, value.splattering ? "splattering" : "not_splattering" );
        hash_part( state, value.has_fire ? "fire" : "not_fire" );
        hash_part( state, value.has_acid ? "acid" : "not_acid" );
        hash_part( state, value.has_electricity ? "electricity" : "not_electricity" );
        hash_part( state, value.has_fume ? "fume" : "not_fume" );
        hash_part( state, value.moppable ? "moppable" : "not_moppable" );
        hash_part( state, value.accelerated_decay ? "accelerated" : "normal_decay" );
        hash_part( state, value.display_items ? "display_items" : "hide_items" );
        hash_part( state, value.display_field ? "display_field" : "hide_field" );
        hash_part( state, value.linear_half_life ? "linear" : "nonlinear" );
        hash_part( state, value.indestructible ? "indestructible" : "destructible" );
        hash_part( state, value.mopsafe ? "mopsafe" : "not_mopsafe" );
        hash_part( state, value.decrease_intensity_on_contact ?
                   "contact_decrease" : "contact_stable" );
        for( const std::string &id : value.immune_monsters ) {
            hash_part( state, "immune_monster" );
            hash_part( state, id );
        }
        for( const std::string &id : value.blocked_monsters ) {
            hash_part( state, "blocked_monster" );
            hash_part( state, id );
        }
        for( const field_intensity_definition_data &level : value.intensity_levels ) {
            hash_part( state, level.name );
            hash_part( state, level.symbol );
            hash_part( state, level.color );
            hash_part( state, level.dangerous ? "dangerous" : "safe" );
            hash_part( state, level.transparent ? "transparent" : "opaque" );
            hash_part( state, std::to_string( level.move_cost ) );
            hash_part( state, std::to_string( level.upgrade_chance ) );
            hash_part( state, std::to_string( level.upgrade_duration_turns ) );
            hash_part( state, std::to_string( level.light_emitted ) );
            hash_part( state, std::to_string( level.local_light_override ) );
            hash_part( state, std::to_string( level.translucency ) );
            hash_part( state, std::to_string( level.concentration ) );
            hash_part( state, std::to_string( level.convection_temperature_modifier ) );
            hash_part( state, std::to_string( level.scent_neutralization ) );
            for( const field_effect_definition_data &effect : level.effects ) {
                hash_part( state, effect.effect );
                hash_part( state, std::to_string( effect.duration_min_turns ) );
                hash_part( state, std::to_string( effect.duration_max_turns ) );
                hash_part( state, std::to_string( effect.intensity ) );
                hash_part( state, effect.body_part );
                hash_part( state, effect.environmental ? "environmental" : "direct" );
                hash_part( state, effect.message );
                hash_part( state, effect.npc_message );
            }
        }
    }
    for( const monster_attack_registration &entry : pimpl_->monster_attacks ) {
        hash_part( state, "monster_attack" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->cooldown ) );
        hash_part( state, entry.definition->handler );
    }
    for( const weakpoint_set_registration &entry : pimpl_->weakpoint_sets ) {
        hash_part( state, "weakpoint_set" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const weakpoint_definition_data &point : entry.definition->weakpoints ) {
            hash_part( state, point.id );
            hash_part( state, point.name );
            hash_part( state, std::to_string( point.coverage ) );
            hash_part( state, point.good ? "good" : "neutral" );
            hash_part( state, point.head ? "head" : "not_head" );
            const auto hash_damage_map = [&]( const std::string_view kind,
            const std::map<std::string, double> &values ) {
                for( const auto &[damage_id, value] : values ) {
                    hash_part( state, kind );
                    hash_part( state, damage_id );
                    hash_part( state, std::to_string( value ) );
                }
            };
            hash_damage_map( "armor_multiplier", point.armor_multipliers );
            hash_damage_map( "armor_penalty", point.armor_penalties );
            hash_damage_map( "damage_multiplier", point.damage_multipliers );
            hash_damage_map( "critical_multiplier", point.critical_multipliers );
            for( const weakpoint_effect_definition_data &effect : point.effects ) {
                hash_part( state, effect.effect );
                hash_part( state, std::to_string( effect.chance ) );
                hash_part( state, effect.permanent ? "permanent" : "temporary" );
                hash_part( state, std::to_string( effect.duration_min_turns ) );
                hash_part( state, std::to_string( effect.duration_max_turns ) );
                hash_part( state, std::to_string( effect.intensity_min ) );
                hash_part( state, std::to_string( effect.intensity_max ) );
                hash_part( state, std::to_string( effect.damage_required_min ) );
                hash_part( state, std::to_string( effect.damage_required_max ) );
                hash_part( state, effect.message );
                hash_part( state, effect.handler );
            }
        }
    }
    for( const morale_type_registration &entry : pimpl_->morale_types ) {
        hash_part( state, "morale_type" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->text );
        hash_part( state, entry.definition->permanent ? "permanent" : "temporary" );
    }
    for( const disease_type_registration &entry : pimpl_->disease_types ) {
        hash_part( state, "disease_type" );
        hash_part( state, operation_name( entry.operation ) );
        const disease_type_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.symptoms );
        hash_part( state, std::to_string( value.minimum_duration_turns ) );
        hash_part( state, std::to_string( value.maximum_duration_turns ) );
        hash_part( state, std::to_string( value.minimum_intensity ) );
        hash_part( state, std::to_string( value.maximum_intensity ) );
        hash_part( state, value.health_threshold ?
                   std::to_string( *value.health_threshold ) : "no_health_threshold" );
        for( const std::string &body_part : value.affected_body_parts ) {
            hash_part( state, body_part );
        }
    }
    for( const requirement_registration &entry : pimpl_->requirements ) {
        hash_part( state, "requirement" );
        hash_part( state, operation_name( entry.operation ) );
        const requirement_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        for( const auto &group : value.components ) {
            hash_part( state, "components" );
            for( const component_requirement &component : group ) {
                hash_part( state, component.id );
                hash_part( state, std::to_string( component.count ) );
                hash_part( state, component.requirement ? "requirement" : "item" );
            }
        }
        for( const auto &group : value.tools ) {
            hash_part( state, "tools" );
            for( const component_requirement &tool : group ) {
                hash_part( state, tool.id );
                hash_part( state, std::to_string( tool.count ) );
                hash_part( state, tool.requirement ? "requirement" : "item" );
            }
        }
        for( const auto &group : value.qualities ) {
            hash_part( state, "qualities" );
            for( const quality_requirement_definition &quality : group ) {
                hash_part( state, quality.id );
                hash_part( state, std::to_string( quality.level ) );
                hash_part( state, std::to_string( quality.count ) );
            }
        }
    }
    for( const wound_fix_registration &entry : pimpl_->wound_fixes ) {
        hash_part( state, "wound_fix" );
        hash_part( state, operation_name( entry.operation ) );
        const wound_fix_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.description );
        hash_part( state, value.success_message );
        hash_part( state, std::to_string( value.duration_turns ) );
        hash_part( state, std::to_string( value.health_delta ) );
        for( const auto &[skill, level] : value.skills ) {
            hash_part( state, "skill" );
            hash_part( state, skill );
            hash_part( state, std::to_string( level ) );
        }
        for( const wound_fix_proficiency_definition_data &proficiency : value.proficiencies ) {
            hash_part( state, "proficiency" );
            hash_part( state, proficiency.id );
            hash_part( state, std::to_string( proficiency.multiplier ) );
            hash_part( state, proficiency.mandatory ? "mandatory" : "optional" );
        }
        for( const std::string &wound_id : value.wounds_removed ) {
            hash_part( state, "removes" );
            hash_part( state, wound_id );
        }
        for( const std::string &wound_id : value.wounds_added ) {
            hash_part( state, "adds" );
            hash_part( state, wound_id );
        }
        for( const wound_fix_requirement_definition_data &requirement : value.requirements ) {
            hash_part( state, "requires" );
            hash_part( state, requirement.id );
            hash_part( state, std::to_string( requirement.count ) );
        }
    }
    for( const recipe_group_registration &entry : pimpl_->recipe_groups ) {
        hash_part( state, "recipe_group" );
        hash_part( state, operation_name( entry.operation ) );
        const recipe_group_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.building_type );
        for( const recipe_group_recipe_data &recipe_entry : value.recipes ) {
            hash_part( state, recipe_entry.id );
            hash_part( state, recipe_entry.description );
            for( const recipe_group_terrain_data &terrain : recipe_entry.terrains ) {
                hash_part( state, terrain.overmap_terrain );
                hash_part( state, terrain.match_type );
                for( const auto &[parameter, values] : terrain.parameters ) {
                    hash_part( state, parameter );
                    for( const std::string &parameter_value : values ) {
                        hash_part( state, parameter_value );
                    }
                }
            }
        }
    }
    for( const item_registration &entry : pimpl_->items ) {
        hash_part( state, "item" );
        hash_part( state, operation_name( entry.operation ) );
        const item_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.copy_from );
        hash_part( state, value.name );
        hash_part( state, value.description );
        hash_part( state, value.symbol );
        hash_part( state, std::to_string( value.mass_grams ) );
        hash_part( state, std::to_string( value.volume_ml ) );
        hash_part( state, std::to_string( value.price_cents ) );
        hash_part( state, std::to_string( value.price_postapoc_cents ) );
        hash_part( state, value.color );
        hash_part( state, value.category );
        hash_part( state, value.looks_like );
        hash_part( state, std::to_string( value.magazine_capacity ) );
        hash_part( state, value.use_handler );
        hash_part( state, value.use_label );
        hash_part( state, value.consume_handler );
        for( const material_part &material : value.materials ) {
            hash_part( state, material.id );
            hash_part( state, std::to_string( material.portions ) );
        }
        for( const quality_level &quality : value.qualities ) {
            hash_part( state, quality.id );
            hash_part( state, std::to_string( quality.level ) );
        }
        for( const std::string &flag : value.flags ) {
            hash_part( state, flag );
        }
        for( const auto &[damage, amount] : value.melee_damage ) {
            hash_part( state, damage );
            hash_part( state, std::to_string( amount ) );
        }
        for( const auto &[ammo, capacity] : value.magazine_ammo ) {
            hash_part( state, ammo );
            hash_part( state, std::to_string( capacity ) );
        }
    }
    for( const clothing_mod_registration &entry : pimpl_->clothing_mods ) {
        hash_part( state, "clothing_mod" );
        hash_part( state, operation_name( entry.operation ) );
        const clothing_mod_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.flag );
        hash_part( state, value.material_item );
        hash_part( state, value.apply_prompt );
        hash_part( state, value.remove_prompt );
        hash_part( state, value.restricted ? "restricted" : "unrestricted" );
        for( const clothing_modifier_definition_data &modifier : value.modifiers ) {
            hash_part( state, modifier.stat );
            hash_part( state, std::to_string( modifier.amount ) );
            hash_part( state, modifier.round_up ? "round_up" : "exact" );
            hash_part( state, modifier.per_thickness ? "thickness" : "no_thickness" );
            hash_part( state, modifier.per_coverage ? "coverage" : "no_coverage" );
        }
    }
    for( const recipe_registration &entry : pimpl_->recipes ) {
        hash_part( state, "recipe" );
        hash_part( state, operation_name( entry.operation ) );
        const recipe_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.nested_category ? "nested_category" : "craft_recipe" );
        hash_part( state, value.result );
        hash_part( state, value.name );
        hash_part( state, value.description );
        hash_part( state, value.category );
        hash_part( state, value.subcategory );
        hash_part( state, std::to_string( value.activity_level ) );
        for( const std::string &member : value.nested_recipes ) {
            hash_part( state, member );
        }
        hash_part( state, value.skill );
        hash_part( state, std::to_string( value.difficulty ) );
        hash_part( state, std::to_string( value.time_moves ) );
        hash_part( state, value.autolearn ? "autolearn" : "manual" );
        hash_part( state, value.reversible ? "reversible" : "irreversible" );
        for( const auto &group : value.components ) {
            hash_part( state, "and" );
            for( const component_requirement &component : group ) {
                hash_part( state, component.id );
                hash_part( state, std::to_string( component.count ) );
                hash_part( state, component.requirement ? "requirement" : "item" );
            }
        }
        for( const auto &group : value.tools ) {
            hash_part( state, "tool" );
            for( const component_requirement &tool : group ) {
                hash_part( state, tool.id );
                hash_part( state, std::to_string( tool.count ) );
                hash_part( state, tool.requirement ? "requirement" : "item" );
            }
        }
        for( const auto &[skill, level] : value.required_skills ) {
            hash_part( state, skill );
            hash_part( state, std::to_string( level ) );
        }
        for( const auto &[requirement_key, multiplier] : value.external_requirements ) {
            hash_part( state, requirement_key );
            hash_part( state, std::to_string( multiplier ) );
        }
        for( const recipe_definition_data::proficiency_data &proficiency :
             value.proficiencies ) {
            hash_part( state, proficiency.id );
            hash_part( state, proficiency.required ? "required" : "optional" );
            hash_part( state, std::to_string( proficiency.time_multiplier ) );
            hash_part( state, std::to_string( proficiency.skill_penalty ) );
        }
        for( const auto &[book, level] : value.books ) {
            hash_part( state, book );
            hash_part( state, std::to_string( level ) );
        }
        hash_part( state, value.result_handler );
    }
    for( const plant_lifecycle_registration &entry : pimpl_->plant_lifecycles ) {
        hash_part( state, "plant_lifecycle" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->target );
        hash_part( state, entry.definition->id );
        for( const auto &[phase, handler_id] : entry.definition->handlers ) {
            hash_part( state, phase );
            hash_part( state, handler_id );
        }
    }
    std::ostringstream result;
    result << std::hex << state;
    return result.str();
}

bool content_transaction::was_applied() const
{
    return pimpl_->applied;
}

bool content_transaction::find_damage_handler( const std::string_view damage_id,
        const std::string_view phase, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->damage_types.rbegin(), pimpl_->damage_types.rend(),
    [damage_id]( const damage_type_registration & entry ) {
        return entry.definition->id == damage_id;
    } );
    if( found == pimpl_->damage_types.rend() ) {
        return false;
    }
    if( phase == "on_hit" ) {
        handler_id = found->definition->on_hit_handler;
    } else if( phase == "on_damage" ) {
        handler_id = found->definition->on_damage_handler;
    } else {
        handler_id.clear();
    }
    return true;
}

bool content_transaction::find_ammo_effect_handler(
    const std::string_view ammo_effect_id, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->ammo_effects.rbegin(), pimpl_->ammo_effects.rend(),
    [ammo_effect_id]( const ammo_effect_registration & entry ) {
        return entry.definition->id == ammo_effect_id;
    } );
    if( found == pimpl_->ammo_effects.rend() ) {
        return false;
    }
    handler_id = found->definition->impact_handler;
    return true;
}

bool content_transaction::find_addiction_type_handler(
    const std::string_view addiction_type_id, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->addiction_types.rbegin(), pimpl_->addiction_types.rend(),
    [addiction_type_id]( const addiction_type_registration & entry ) {
        return entry.definition->id == addiction_type_id;
    } );
    if( found == pimpl_->addiction_types.rend() ) {
        return false;
    }
    handler_id = found->definition->tick_handler;
    return true;
}

bool content_transaction::find_character_modifier_handler(
    const std::string_view modifier_id, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->character_modifiers.rbegin(), pimpl_->character_modifiers.rend(),
    [modifier_id]( const character_modifier_registration & entry ) {
        return entry.definition->id == modifier_id;
    } );
    if( found == pimpl_->character_modifiers.rend() ) {
        return false;
    }
    handler_id = found->definition->evaluator_handler;
    return true;
}

bool content_transaction::find_weather_type_handler(
    const std::string_view weather_type_id_value, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->weather_types.rbegin(), pimpl_->weather_types.rend(),
    [weather_type_id_value]( const weather_type_registration & entry ) {
        return entry.definition->id == weather_type_id_value;
    } );
    if( found == pimpl_->weather_types.rend() ) {
        return false;
    }
    handler_id = found->definition->condition_handler;
    return true;
}

bool content_transaction::find_end_screen_handler(
    const std::string_view end_screen_id_value, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->end_screens.rbegin(), pimpl_->end_screens.rend(),
    [end_screen_id_value]( const end_screen_registration & entry ) {
        return entry.definition->id == end_screen_id_value;
    } );
    if( found == pimpl_->end_screens.rend() ) {
        return false;
    }
    handler_id = found->definition->condition_handler;
    return true;
}

bool content_transaction::find_activity_type_handler(
    const std::string_view activity_type_id_value, const std::string_view phase,
    std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->activity_types.rbegin(), pimpl_->activity_types.rend(),
    [activity_type_id_value]( const activity_type_registration & entry ) {
        return entry.definition->id == activity_type_id_value;
    } );
    if( found == pimpl_->activity_types.rend() ) {
        return false;
    }
    if( phase == "do_turn" ) {
        handler_id = found->definition->do_turn_handler;
    } else if( phase == "completion" ) {
        handler_id = found->definition->completion_handler;
    } else {
        handler_id.clear();
    }
    return true;
}

bool content_transaction::find_snippet_handler( const std::string_view snippet_id_value,
        std::string &category_id, std::string &handler_id ) const
{
    for( auto category = pimpl_->snippet_categories.rbegin();
         category != pimpl_->snippet_categories.rend(); ++category ) {
        const auto found = std::find_if(
                               category->definition->entries.begin(),
                               category->definition->entries.end(),
        [snippet_id_value]( const snippet_entry_definition_data & entry ) {
            return entry.id == snippet_id_value;
        } );
        if( found != category->definition->entries.end() ) {
            category_id = category->definition->id;
            handler_id = found->examine_handler;
            return true;
        }
    }
    return false;
}

bool content_transaction::find_magic_type_handler( const std::string_view magic_type_id,
        const std::string_view phase, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->magic_types.rbegin(), pimpl_->magic_types.rend(),
    [magic_type_id]( const magic_type_registration & entry ) {
        return entry.definition->id == magic_type_id;
    } );
    if( found == pimpl_->magic_types.rend() ) {
        return false;
    }
    const magic_type_definition_data &definition = *found->definition;
    if( phase == "level_for_experience" ) {
        handler_id = definition.level_for_experience_handler;
    } else if( phase == "experience_for_level" ) {
        handler_id = definition.experience_for_level_handler;
    } else if( phase == "casting_experience" ) {
        handler_id = definition.casting_experience_handler;
    } else if( phase == "failure_chance" ) {
        handler_id = definition.failure_chance_handler;
    } else if( phase == "failure_cost" ) {
        handler_id = definition.failure_cost_handler;
    } else if( phase == "failure_experience" ) {
        handler_id = definition.failure_experience_handler;
    } else if( phase == "on_failure" ) {
        handler_id = definition.failure_handler;
    } else {
        handler_id.clear();
    }
    return true;
}

bool content_transaction::find_emission_handler(
    const std::string_view emission_id, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->emissions.rbegin(), pimpl_->emissions.rend(),
    [emission_id]( const emission_registration & entry ) {
        return entry.definition->id == emission_id;
    } );
    if( found == pimpl_->emissions.rend() ) {
        return false;
    }
    handler_id = found->definition->profile_handler;
    return true;
}

bool content_transaction::find_overmap_terrain_handler(
    const std::string_view terrain_id, const std::string_view phase,
    std::string &handler_id ) const
{
    return pimpl_->world.find_overmap_terrain_handler(
               std::string( terrain_id ), std::string( phase ), handler_id );
}

bool content_transaction::find_overmap_special_handler(
    const std::string_view special_id, const std::string_view phase,
    std::string &handler_id ) const
{
    return pimpl_->world.find_overmap_special_handler(
               std::string( special_id ), std::string( phase ), handler_id );
}

bool content_transaction::find_vehicle_part_handler(
    const std::string_view part_id, const std::string_view phase,
    std::string &handler_id ) const
{
    return pimpl_->world.find_vehicle_part_handler(
               std::string( part_id ), std::string( phase ), handler_id );
}

bool content_transaction::find_plant_lifecycle_handler(
    const std::string_view target, const std::string_view target_id,
    const std::string_view phase, std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->plant_lifecycles.rbegin(),
                           pimpl_->plant_lifecycles.rend(),
    [target, target_id]( const plant_lifecycle_registration & entry ) {
        return entry.definition->target == target &&
               entry.definition->id == target_id;
    } );
    if( found == pimpl_->plant_lifecycles.rend() ) {
        handler_id.clear();
        return false;
    }
    const auto handler = found->definition->handlers.find( std::string( phase ) );
    handler_id = handler == found->definition->handlers.end() ?
                 std::string() : handler->second;
    return true;
}

bool content_transaction::find_martial_art_handler(
    const std::string_view martial_art_id, const std::string_view phase,
    std::string &handler_id ) const
{
    const auto found = std::find_if(
                           pimpl_->martial_arts.rbegin(), pimpl_->martial_arts.rend(),
    [martial_art_id]( const martial_art_registration & entry ) {
        return entry.definition->id == martial_art_id;
    } );
    if( found == pimpl_->martial_arts.rend() ) {
        handler_id.clear();
        return false;
    }
    const auto handler = found->definition->handlers.find( std::string( phase ) );
    handler_id = handler == found->definition->handlers.end() ?
                 std::string() : handler->second;
    return true;
}

std::shared_ptr<runtime> make_runtime( const std::string &mod_id,
                                       std::size_t generation,
                                       sol::state &lua,
                                       const std::filesystem::path &mod_root )
{
    return std::make_shared<runtime>( mod_id, generation, lua, mod_root );
}

void install_runtime_api( const std::shared_ptr<runtime> &value,
                          sol::state &lua, sol::table &ccb )
{
    value->content.install_lua_api( lua, ccb, value );
    cata::lua_ui::install_script_mapgen_context_api( lua );

    ccb.new_usertype<use_context_data>(
        "ItemUseContext", sol::no_constructor,
        "message", &use_context_data::message,
        "player_name", sol::property( &use_context_data::player_name ),
        "item_id", sol::property( &use_context_data::item_id ),
        "character", sol::property( &use_context_data::character_handle ),
        "item", sol::property( &use_context_data::item_handle ),
        "position", sol::property( &use_context_data::use_position ),
        "charges", sol::property( &use_context_data::charges,
                                  &use_context_data::set_charges ) );
    ccb.new_usertype<computer_access_context>(
        "ComputerAccessContext", sol::no_constructor,
        "message", &computer_access_context::message,
        "name", sol::property( &computer_access_context::name,
                               &computer_access_context::set_name ),
        "access_denied", sol::property( &computer_access_context::access_denied,
                                        &computer_access_context::set_access_denied ),
        "security", sol::property( &computer_access_context::security,
                                   &computer_access_context::set_security ),
        "alerts", sol::property( &computer_access_context::alerts,
                                 &computer_access_context::set_alerts ),
        "mission_id", sol::property( &computer_access_context::mission_id,
                                     &computer_access_context::set_mission_id ),
        "character", sol::property( &computer_access_context::character_handle ),
        "position", sol::property( &computer_access_context::position ),
        "get_value", &computer_access_context::get_value,
        "set_value", &computer_access_context::set_value,
        "remove_value", &computer_access_context::remove_value );
    ccb.new_usertype<platform_dialogue_context>(
        "PlatformDialogueContext", sol::no_constructor,
        "valid", &platform_dialogue_context::valid,
        "topic", &platform_dialogue_context::topic,
        "topic_item", &platform_dialogue_context::topic_item,
        "has_alpha", &platform_dialogue_context::has_alpha,
        "has_beta", &platform_dialogue_context::has_beta,
        "by_radio", &platform_dialogue_context::by_radio,
        "has_reason", &platform_dialogue_context::has_reason,
        "reason", &platform_dialogue_context::reason,
        "trial_chance",
        []( const platform_dialogue_context &context,
            const std::string &kind, const int difficulty,
        const sol::optional<std::string> &skill ) {
            return context.trial_chance(
                       kind, difficulty,
                       skill.value_or( std::string() ) );
        },
        "roll_trial",
        []( const platform_dialogue_context &context,
            const std::string &kind, const int difficulty,
        const sol::optional<std::string> &skill ) {
            return context.roll_trial(
                       kind, difficulty,
                       skill.value_or( std::string() ) );
        },
        "expand_text",
        []( const platform_dialogue_context &context,
            const std::string &text,
        const sol::optional<std::string> &item_id ) {
            return context.expand_text(
                       text, item_id.value_or( std::string() ) );
        },
        "alpha", &platform_dialogue_context::alpha,
        "beta", &platform_dialogue_context::beta,
        "get", &platform_dialogue_context::get,
        "set", &platform_dialogue_context::set,
        "remove", &platform_dialogue_context::remove,
        "quote_trade_item", &platform_dialogue_context::quote_trade_item,
        "buy_quoted_item", &platform_dialogue_context::buy_quoted_item );
    ccb["PlatformDialogueContext"] = sol::lua_nil;

    const std::weak_ptr<runtime> weak = value;
    sol::table runtime_api = lua.create_table();
    runtime_api.set_function( "handler", [weak]( const std::string & id,
    const sol::object & callback, const sol::optional<std::int64_t> &payload_version ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( id.empty() || id.find( '#' ) != std::string::npos ) {
            throw std::runtime_error( "handler id must be non-empty and cannot contain '#'" );
        }
        if( callback.get_type() != sol::type::function ) {
            throw std::runtime_error( "handler callback must be a Lua function" );
        }
        const std::int64_t requested_version = payload_version.value_or( 1 );
        if( requested_version <= 0 || requested_version > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "handler payload version is outside the native range" );
        }
        const int version = static_cast<int>( requested_version );
        if( !owner->handlers.emplace( id, handler_definition{
        version, callback.as<sol::protected_function>()
        } ).second ) {
            throw std::runtime_error( "duplicate handler id '" + id + "'" );
        }
    } );
    runtime_api.set_function( "character_recurring", [weak](
                                  const std::string &effect_handler,
    const std::string &interval_handler ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( effect_handler.empty() || interval_handler.empty() ) {
            throw std::runtime_error(
                "character recurring handler ids cannot be empty" );
        }
        if( owner->handlers.count( effect_handler ) == 0 ) {
            throw std::runtime_error(
                "character recurring effect references missing handler '" +
                effect_handler + "'" );
        }
        if( owner->handlers.count( interval_handler ) == 0 ) {
            throw std::runtime_error(
                "character recurring interval references missing handler '" +
                interval_handler + "'" );
        }
        if( owner->character_recurring_handlers.size() >=
            maximum_character_recurring_handlers_per_mod ) {
            throw std::runtime_error(
                "character recurring handler registration limit reached" );
        }
        if( std::any_of(
                owner->character_recurring_handlers.begin(),
                owner->character_recurring_handlers.end(),
        [&effect_handler]( const runtime::character_recurring_registration & entry ) {
        return entry.effect_handler == effect_handler;
    } ) ) {
            throw std::runtime_error(
                "duplicate character recurring effect handler '" +
                effect_handler + "'" );
        }
        const std::string identity = owner->mod_id + '\0' + effect_handler +
                                     '\0' + interval_handler;
        runtime::character_recurring_registration registration;
        registration.effect_handler = effect_handler;
        registration.interval_handler = interval_handler;
        registration.due_variable = "__ccb_recurring_" +
                                    std::to_string( fnv1a( identity ) );
        if( std::any_of(
                owner->character_recurring_handlers.begin(),
                owner->character_recurring_handlers.end(),
        [&registration]( const runtime::character_recurring_registration & entry ) {
        return entry.due_variable == registration.due_variable;
    } ) ) {
            throw std::runtime_error(
                "character recurring state-key collision" );
        }
        owner->character_recurring_handlers.push_back(
            std::move( registration ) );
    } );
    runtime_api.set_function( "on", [weak]( const std::string & event_name,
    const std::string & handler_id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( event_name.empty() || handler_id.empty() ) {
            throw std::runtime_error( "event and handler ids cannot be empty" );
        }
        const bool lifecycle = event_name == "world_ready" || event_name == "before_save" ||
                               event_name == "after_save" || event_name == "shutdown";
        if( !lifecycle && ( event_name.size() <= 5 || event_name.compare( 0, 5, "game:" ) != 0 ) ) {
            throw std::runtime_error( "event must be a lifecycle name or game:<event>" );
        }
        if( !lifecycle && !platform_event_contract_exists(
                std::string_view( event_name ).substr( 5 ) ) ) {
            throw std::runtime_error( "unknown native event '" + event_name + "'" );
        }
        std::vector<std::string> &subscriptions = owner->subscriptions[event_name];
        if( std::find( subscriptions.begin(), subscriptions.end(), handler_id ) !=
            subscriptions.end() ) {
            throw std::runtime_error( "duplicate event subscription '" + event_name +
                                      "' for handler '" + handler_id + "'" );
        }
        subscriptions.push_back( handler_id );
    } );
    runtime_api.set_function( "migrate_task_payload", [weak](
                                  const std::string & handler_id, const std::int64_t from_version,
    const std::int64_t to_version, const sol::object & callback ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( handler_id.empty() || handler_id.find( '#' ) != std::string::npos ) {
            throw std::runtime_error(
                "task migration handler id must be non-empty and cannot contain '#'" );
        }
        if( from_version <= 0 || to_version <= 0 ||
            from_version > std::numeric_limits<int>::max() ||
            to_version > std::numeric_limits<int>::max() ||
            from_version == to_version ) {
            throw std::runtime_error( "task migration versions are outside the native range" );
        }
        if( callback.get_type() != sol::type::function ) {
            throw std::runtime_error( "task migration callback must be a Lua function" );
        }
        std::map<int, task_payload_migration> &migrations =
            owner->task_migrations[handler_id];
        const int source = static_cast<int>( from_version );
        if( !migrations.emplace( source, task_payload_migration{
        static_cast<int>( to_version ), callback.as<sol::protected_function>()
        } ).second ) {
            throw std::runtime_error(
                "duplicate task payload migration for handler '" + handler_id +
                "' from version " + std::to_string( from_version ) );
        }
    } );
    runtime_api.set_function( "hook", [weak]( const std::string & hook_name,
    const std::string & handler_id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( hook_name.empty() || !cata::lua_ui::native_hook_contract_exists( hook_name ) ) {
            throw std::runtime_error( "unknown native hook '" + hook_name + "'" );
        }
        if( handler_id.empty() ) {
            throw std::runtime_error( "native hook handler id cannot be empty" );
        }
        std::vector<std::string> &handlers = owner->hooks[hook_name];
        if( std::find( handlers.begin(), handlers.end(), handler_id ) != handlers.end() ) {
            throw std::runtime_error( "duplicate native hook subscription '" + hook_name +
                                      "' for handler '" + handler_id + "'" );
        }
        handlers.push_back( handler_id );
    } );
    runtime_api.set_function( "dialogue_topic", [weak]( const std::string & topic_id,
    const std::string & handler_id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( topic_id.empty() || topic_id.size() > 256 ||
            topic_id.find( '\0' ) != std::string::npos ) {
            throw std::runtime_error( "dialogue topic id must contain 1 to 256 non-NUL bytes" );
        }
        if( handler_id.empty() ) {
            throw std::runtime_error( "dialogue topic handler id cannot be empty" );
        }
        if( owner->declarative_dialogue_topics.count( topic_id ) != 0 ) {
            throw std::runtime_error(
                "dialogue topic conflicts with ccb.dialogue.register_topic '" +
                topic_id + "'" );
        }
        if( owner->dialogue_topics.size() >= maximum_platform_dialogue_topics ) {
            throw std::runtime_error( "dialogue topic registration limit reached" );
        }
        if( !owner->dialogue_topics.emplace( topic_id, handler_id ).second ) {
            throw std::runtime_error( "duplicate dialogue topic '" + topic_id + "'" );
        }
    } );
    ccb["runtime"] = std::move( runtime_api );

    sol::table dialogue_api = lua.create_table();
    dialogue_api.set_function( "register_topic", [weak]( const sol::table & descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return register_platform_dialogue_topic( *owner, descriptor );
    } );
    dialogue_api.set_function( "extend_topic", [weak]( const sol::table & descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return extend_platform_dialogue_topic( *owner, descriptor );
    } );
    dialogue_api.set_function( "limits", []( sol::this_state state ) {
        sol::state_view lua_state( state );
        return lua_state.create_table_with(
                   "topics", maximum_platform_dialogue_topics,
                   "extensions", maximum_platform_dialogue_extensions,
                   "responses_per_topic",
                   maximum_platform_dialogue_responses_per_topic,
                   "repeat_responses_per_topic",
                   maximum_platform_dialogue_repeat_responses_per_topic,
                   "id_bytes", 256,
                   "text_bytes", 4096 );
    } );
    ccb["dialogue"] = std::move( dialogue_api );

    auto install_state_scope = [&lua, weak]( persistent_state runtime::*member,
    const std::string & name ) {
        sol::table scope = lua.create_table();
        scope.set_function( "get", [weak, member, name]( sol::this_state state,
        const std::string & key, const sol::optional<sol::object> &fallback ) {
            const std::shared_ptr<runtime> owner = weak.lock();
            if( !owner || !owner->world_is_ready ) {
                throw std::runtime_error( "state." + name + " is only available after world_ready" );
            }
            return get_persistent_value( owner.get()->*member, state, key, fallback );
        } );
        scope.set_function( "set", [weak, member, name]( const std::string & key,
        const sol::object & entry ) {
            const std::shared_ptr<runtime> owner = weak.lock();
            if( !owner || !owner->world_is_ready ) {
                throw std::runtime_error( "state." + name + " is only available after world_ready" );
            }
            set_persistent_value( owner.get()->*member, key, entry,
                                  "state." + name + ".set" );
        } );
        return scope;
    };
    sol::table state_api = lua.create_table();
    state_api["character"] = install_state_scope( &runtime::character_state, "character" );
    state_api["world"] = install_state_scope( &runtime::world_state, "world" );
    ccb["state"] = std::move( state_api );

    const auto schedule_persistent_task = [weak](
            const std::int64_t delay_turns,
            const std::int64_t interval_turns,
            const std::string &handler_id,
            const sol::optional<sol::table> &payload,
            const sol::optional<std::int64_t> &payload_version,
            const sol::optional<std::string> &scope,
            const std::string &api_name ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( delay_turns < 0 ) {
            throw std::runtime_error( "task delay cannot be negative" );
        }
        if( interval_turns < 0 ) {
            throw std::runtime_error( "task interval cannot be negative" );
        }
        if( owner->tasks.size() >= maximum_tasks_per_mod ) {
            throw std::runtime_error( "persistent task limit of 1024 per Mod reached" );
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            throw std::runtime_error( "task references missing handler '" + handler_id + "'" );
        }
        const std::string owner_scope = scope.value_or( "world" );
        if( owner_scope != "world" && owner_scope != "character" ) {
            throw std::runtime_error( "task owner must be 'world' or 'character'" );
        }
        if( owner->next_task_id > static_cast<std::uint64_t>(
                std::numeric_limits<std::int64_t>::max() ) ) {
            throw std::runtime_error( "persistent task id space exhausted" );
        }
        const std::int64_t now = to_turn<std::int64_t>( calendar::turn );
        if( delay_turns > 0 &&
            now > std::numeric_limits<std::int64_t>::max() - delay_turns ) {
            throw std::runtime_error( "persistent task due turn overflows" );
        }
        persistent_task task;
        task.handler_id = handler_id;
        task.due_turn = now + delay_turns;
        task.interval_turns = interval_turns;
        task.owner = owner_scope;
        const std::int64_t requested_version = payload_version.value_or(
                handler->second.payload_version );
        if( requested_version <= 0 || requested_version > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "task payload version is outside the native range" );
        }
        if( requested_version != handler->second.payload_version ) {
            throw std::runtime_error(
                "new tasks must use the registered handler payload version" );
        }
        task.payload_version = static_cast<int>( requested_version );
        task.payload = persistent_table_from_lua( payload, api_name );
        task.id = owner->next_task_id++;
        owner->tasks.push_back( task );
        return static_cast<std::int64_t>( task.id );
    };

    sol::table tasks = lua.create_table();
    const auto task_snapshot = []( runtime &owner,
    const persistent_task &task ) {
        sol::table result = owner.lua->create_table();
        const std::int64_t now =
            to_turn<std::int64_t>( calendar::turn );
        const auto handler = owner.handlers.find( task.handler_id );
        result["id"] = static_cast<std::int64_t>( task.id );
        result["handler"] = task.handler_id;
        result["due_turn"] = task.due_turn;
        result["remaining_turns"] =
            nonnegative_turn_difference( task.due_turn, now );
        result["overdue_turns"] =
            nonnegative_turn_difference( now, task.due_turn );
        result["recurring"] = task.interval_turns > 0;
        result["interval_turns"] = task.interval_turns;
        result["owner"] = task.owner;
        result["payload_version"] = task.payload_version;
        result["handler_available"] = handler != owner.handlers.end();
        result["payload_current"] =
            handler != owner.handlers.end() &&
            handler->second.payload_version == task.payload_version;
        result["payload"] = persistent_table( *owner.lua, task.payload );
        return result;
    };
    tasks.set_function( "after", [schedule_persistent_task](
            const std::int64_t turns,
            const std::string &handler_id,
            const sol::optional<sol::table> &payload,
            const sol::optional<std::int64_t> &payload_version,
            const sol::optional<std::string> &scope ) {
        return schedule_persistent_task(
                   turns, 0, handler_id, payload,
                   payload_version, scope, "tasks.after" );
    } );
    tasks.set_function( "every", [schedule_persistent_task](
            const std::int64_t interval_turns,
            const std::string &handler_id,
            const sol::optional<sol::table> &payload,
            const sol::optional<std::int64_t> &payload_version,
            const sol::optional<std::string> &scope ) {
        if( interval_turns <= 0 ) {
            throw std::runtime_error( "task interval must be positive" );
        }
        return schedule_persistent_task(
                   interval_turns, interval_turns,
                   handler_id, payload, payload_version,
                   scope, "tasks.every" );
    } );
    tasks.set_function( "cancel", [weak]( std::int64_t id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( id <= 0 ) {
            throw std::runtime_error( "persistent task id must be positive" );
        }
        const std::uint64_t task_id = static_cast<std::uint64_t>( id );
        const std::size_t old_size = owner->tasks.size();
        owner->tasks.erase( std::remove_if( owner->tasks.begin(), owner->tasks.end(),
        [task_id]( const persistent_task & task ) {
            return task.id == task_id;
        } ), owner->tasks.end() );
        owner->reported_task_migration_failures.erase( task_id );
        return owner->tasks.size() != old_size;
    } );
    tasks.set_function( "get", [weak, task_snapshot](
    sol::this_state state, const std::int64_t id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( id <= 0 ) {
            throw std::runtime_error( "persistent task id must be positive" );
        }
        const std::uint64_t task_id = static_cast<std::uint64_t>( id );
        const auto found = std::find_if(
                               owner->tasks.begin(), owner->tasks.end(),
        [task_id]( const persistent_task & task ) {
            return task.id == task_id;
        } );
        sol::state_view lua_state( state );
        if( found == owner->tasks.end() ) {
            return sol::make_object( lua_state, sol::nil );
        }
        return sol::make_object(
                   lua_state, task_snapshot( *owner, *found ) );
    } );
    tasks.set_function( "next", [weak, task_snapshot](
        sol::this_state state, const std::string &handler_id,
    const sol::optional<std::string> &scope ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( handler_id.empty() || handler_id.size() > 256 ) {
            throw std::runtime_error( "persistent task handler id must be a bounded non-empty string" );
        }
        if( scope && *scope != "world" && *scope != "character" ) {
            throw std::runtime_error( "task owner must be 'world' or 'character'" );
        }
        const persistent_task *next = nullptr;
        for( const persistent_task &task : owner->tasks ) {
            if( task.handler_id != handler_id ||
                ( scope && task.owner != *scope ) ) {
                continue;
            }
            if( next == nullptr ||
                std::tie( task.due_turn, task.id ) <
                std::tie( next->due_turn, next->id ) ) {
                next = &task;
            }
        }
        sol::state_view lua_state( state );
        if( next == nullptr ) {
            return sol::make_object( lua_state, sol::nil );
        }
        return sol::make_object(
                   lua_state, task_snapshot( *owner, *next ) );
    } );
    tasks.set_function( "list", [weak, task_snapshot](
        sol::this_state state,
        const sol::optional<std::string> &handler_id,
        const sol::optional<std::string> &scope,
    const sol::optional<std::int64_t> &requested_limit ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( handler_id && ( handler_id->empty() || handler_id->size() > 256 ) ) {
            throw std::runtime_error( "persistent task handler id must be a bounded non-empty string" );
        }
        if( scope && *scope != "world" && *scope != "character" ) {
            throw std::runtime_error( "task owner must be 'world' or 'character'" );
        }
        const std::int64_t limit = requested_limit.value_or( 128 );
        if( limit < 0 || limit > static_cast<std::int64_t>( maximum_tasks_per_mod ) ) {
            throw std::runtime_error( "persistent task list limit must be within 0..1024" );
        }
        std::vector<const persistent_task *> matches;
        matches.reserve( owner->tasks.size() );
        for( const persistent_task &task : owner->tasks ) {
            if( ( !handler_id || task.handler_id == *handler_id ) &&
                ( !scope || task.owner == *scope ) ) {
                matches.push_back( &task );
            }
        }
        std::sort( matches.begin(), matches.end(),
        []( const persistent_task * lhs, const persistent_task * rhs ) {
            return std::tie( lhs->due_turn, lhs->id ) <
                   std::tie( rhs->due_turn, rhs->id );
        } );
        const std::size_t returned = std::min(
                                         matches.size(),
                                         static_cast<std::size_t>( limit ) );
        sol::state_view lua_state( state );
        sol::table entries = lua_state.create_table(
                                 static_cast<int>( returned ), 0 );
        for( std::size_t index = 0; index < returned; ++index ) {
            entries[index + 1] =
                task_snapshot( *owner, *matches[index] );
        }
        sol::table result = lua_state.create_table();
        result["items"] = std::move( entries );
        result["total"] = matches.size();
        result["returned"] = returned;
        result["limit"] = limit;
        result["truncated"] = returned < matches.size();
        return result;
    } );
    ccb["tasks"] = std::move( tasks );

    const auto require_presentation = [weak]() {
        require_live_runtime( weak, "Platform presentation" );
        if( !runtime_callback_is_active( weak ) ) {
            throw std::runtime_error(
                "Platform presentation is only available inside a runtime callback" );
        }
    };
    sol::table presentation = lua.create_table();
    presentation.set_function( "notice", [require_presentation]( const std::string & message ) {
        require_presentation();
        require_presentation_text( message, "notice" );
        ::popup( message );
    } );
    presentation.set_function( "notice_any_key", [require_presentation](
    const std::string & message ) {
        require_presentation();
        require_presentation_text( message, "any-key notice" );
        return ::popup( message, PF_GET_KEY );
    } );
    presentation.set_function( "notice_top", [require_presentation](
    const std::string & message ) {
        require_presentation();
        require_presentation_text( message, "top notice" );
        return ::popup( message, PF_ON_TOP );
    } );
    presentation.set_function( "notice_large", [require_presentation](
    const std::string & message ) {
        require_presentation();
        require_presentation_text( message, "large notice" );
        return ::popup( message, PF_FULLSCREEN );
    } );
    presentation.set_function( "confirm", [require_presentation]( const std::string & question ) {
        require_presentation();
        require_presentation_text( question, "confirmation question" );
        return query_yn( question );
    } );
    presentation.set_function( "choose", [require_presentation](
    sol::this_state state, const std::string & prompt, const sol::table & entries ) {
        require_presentation();
        require_presentation_text( prompt, "choice prompt" );
        const std::vector<presentation_choice> choices =
            presentation_choices_from_lua( entries );
        uilist menu;
        menu.text = prompt;
        menu.desc_enabled = std::any_of( choices.begin(), choices.end(),
        []( const presentation_choice & choice ) {
            return !choice.description.empty();
        } );
        for( std::size_t index = 0; index < choices.size(); ++index ) {
            menu.addentry_desc( static_cast<int>( index ), choices[index].enabled,
                                MENU_AUTOASSIGN, choices[index].label,
                                choices[index].description );
        }
        menu.query();
        sol::state_view lua_state( state );
        if( menu.ret < 0 || static_cast<std::size_t>( menu.ret ) >= choices.size() ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object( lua_state, choices[menu.ret].id );
    } );
    presentation.set_function( "input_text", [require_presentation](
                                   sol::this_state state, const std::string & prompt,
    const sol::optional<sol::table> &options ) {
        require_presentation();
        require_presentation_text( prompt, "input prompt", 4096 );
        std::string initial;
        std::string description;
        std::int64_t width = 0;
        std::int64_t maximum = 1024;
        bool only_digits = false;
        if( options ) {
            initial = options->get_or( "initial", std::string() );
            description = options->get_or( "description", std::string() );
            width = options->get_or<std::int64_t>( "width", 0 );
            maximum = options->get_or<std::int64_t>( "max_length", 1024 );
            only_digits = options->get_or( "only_digits", false );
        }
        if( initial.size() > 32768 || initial.find( '\0' ) != std::string::npos ||
            description.size() > 32768 || description.find( '\0' ) != std::string::npos ||
            width < 0 || width > 240 || maximum <= 0 || maximum > 32768 ) {
            throw std::invalid_argument( "presentation input options exceed native limits" );
        }
        string_input_popup popup;
        popup.title( prompt ).text( initial ).description( description )
        .width( static_cast<int>( width ) ).max_length( static_cast<int>( maximum ) )
        .only_digits( only_digits );
        popup.query();
        sol::state_view lua_state( state );
        if( popup.canceled() ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object( lua_state, popup.text() );
    } );
    ccb["presentation"] = std::move( presentation );

    sol::table services = lua.create_table();
    services.set_function( "message", [weak]( const std::string & message ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "game services are only available after world_ready" );
        }
        ::add_msg( message );
    } );
    services.set_function( "turn", [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "game services are only available after world_ready" );
        }
        return to_turn<std::int64_t>( calendar::turn );
    } );
    sol::table mapgen = lua.create_table();
    const auto register_mapgen = [weak](
                                           const std::string &handler_id,
                                           const sol::optional<sol::table> &options,
                                           const bool primary,
                                           const std::string_view api_name ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        if( handler_id.empty() ) {
            throw std::invalid_argument(
                std::string( api_name ) + " requires a handler id" );
        }
        runtime::mapgen_registration registration;
        registration.handler_id = handler_id;
        registration.primary = primary;
        if( options ) {
            if( const sol::optional<int> z_min =
                    options->get<sol::optional<int>>( "z_min" ) ) {
                registration.z_min = *z_min;
            }
            if( const sol::optional<int> z_max =
                    options->get<sol::optional<int>>( "z_max" ) ) {
                registration.z_max = *z_max;
            }
            const sol::object terrain_ids = options->raw_get<sol::object>(
                                                "terrain_ids" );
            if( terrain_ids.valid() && terrain_ids.get_type() != sol::type::nil ) {
                if( terrain_ids.get_type() != sol::type::table ) {
                    throw std::invalid_argument(
                        "mapgen terrain_ids must be a dense string array" );
                }
                const sol::table values = terrain_ids.as<sol::table>();
                const std::size_t count = require_dense_array(
                                              values, "mapgen terrain_ids", 1, 256 );
                registration.terrain_ids.reserve( count );
                for( std::size_t index = 1; index <= count; ++index ) {
                    const sol::object entry = values.raw_get<sol::object>( index );
                    if( entry.get_type() != sol::type::string ) {
                        throw std::invalid_argument(
                            "mapgen terrain_ids must contain only strings" );
                    }
                    registration.terrain_ids.push_back( entry.as<std::string>() );
                }
                std::sort( registration.terrain_ids.begin(),
                           registration.terrain_ids.end() );
                if( std::adjacent_find( registration.terrain_ids.begin(),
                                        registration.terrain_ids.end() ) !=
                    registration.terrain_ids.end() ) {
                    throw std::invalid_argument(
                        "mapgen terrain_ids cannot contain duplicates" );
                }
            }
        }
        if( registration.z_min > registration.z_max ) {
            throw std::invalid_argument( "mapgen z_min cannot exceed z_max" );
        }
        owner->mapgen_handlers.push_back( std::move( registration ) );
    };
    mapgen.set_function( "on_generate", [register_mapgen](
    const std::string &handler_id, const sol::optional<sol::table> &options ) {
        register_mapgen( handler_id, options, true,
                         "services.mapgen.on_generate" );
    } );
    mapgen.set_function( "on_postprocess", [register_mapgen](
    const std::string &handler_id, const sol::optional<sol::table> &options ) {
        register_mapgen( handler_id, options, false,
                         "services.mapgen.on_postprocess" );
    } );
    mapgen.set_function( "register_palette", [weak]( const sol::table &descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return register_platform_mapgen_palette( *owner, descriptor );
    } );
    mapgen.set_function( "define", [weak]( const sol::table &descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return register_platform_declarative_mapgen( *owner, descriptor );
    } );
    mapgen.set_function( "limits", []( sol::this_state state ) {
        sol::state_view lua_state( state );
        return lua_state.create_table_with(
                   "palettes", 4096,
                   "definitions", 4096,
                   "symbols_per_palette", 4096,
                   "palettes_per_definition", 256,
                   "terrain_ids_per_definition", 4096,
                   "width", cata::lua_ui::script_mapgen_context::map_width,
                   "height", cata::lua_ui::script_mapgen_context::map_height );
    } );
    services["mapgen"] = std::move( mapgen );

    sol::table tileset = lua.create_table();
    tileset.set_function( "register", [weak]( const sol::table &descriptor ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return register_platform_tileset( *owner, descriptor );
    } );
    tileset.set_function( "limits", []( sol::this_state state ) {
        sol::state_view lua_state( state );
        return lua_state.create_table_with(
                   "definitions", 256,
                   "atlases_per_definition", 64,
                   "tiles_per_atlas", 65536,
                   "ids_per_tile", 256,
                   "variations_per_layer", 1024,
                   "additional_tiles_per_tile", 256,
                   "overlay_entries_per_definition", 4096 );
    } );
    services["tileset"] = std::move( tileset );

    // Platform and the capability-scoped v5 runtime share these native domain
    // implementations, but not an authoring contract or Lua state.  Platform
    // installs only the domain-shaped services: it deliberately omits the
    // legacy EOC bridge, JSON registry, and v5 capability tables.
    const auto runtime_generation = [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        return owner ? owner->handle_runtime() :
               cata::lua_ui::game_handle_runtime();
    };
    const auto world_generation = []() {
        return active_world_generation;
    };
    const auto require_read = [weak]() {
        require_live_runtime( weak, "Platform domain services" );
    };
    const auto require_write = [weak]() {
        require_live_runtime( weak, "Platform domain mutations" );
        if( !runtime_callback_is_active( weak ) ) {
            throw std::runtime_error(
                "Platform domain mutations are only available inside a runtime callback" );
        }
    };
    const auto has_callback = [weak]() {
        return runtime_callback_is_active( weak );
    };
    const auto source_id = [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        return owner->mod_id;
    };
    const auto random_index = [weak]( const std::size_t count ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready || owner->callback_depth <= 0 ) {
            throw std::runtime_error(
                "Platform gameplay randomness is only available inside a runtime callback" );
        }
        if( count == 0 ) {
            throw std::invalid_argument( "Platform random selection requires a non-empty range" );
        }
        std::uniform_int_distribution<std::size_t> distribution( 0, count - 1 );
        return distribution( owner->random_engine );
    };

    cata::lua_ui::install_value_type_api( lua, services, require_read );
    cata::lua_ui::install_registry_api( lua, services, require_read, require_read );
    // install_registry_api retains its v5 global `registry` surface.  Platform
    // exposes that same bounded native snapshot through ccb.services instead.
    sol::table registry = lua["registry"];
    services["registry"] = std::move( registry );
    cata::lua_ui::install_time_api( services, require_read, require_write );
    cata::lua_ui::install_game_handle_api( lua, services, runtime_generation,
                                           world_generation, require_read );
    cata::lua_ui::install_creature_api( services, runtime_generation, world_generation,
                                        require_read, require_write );
    cata::lua_ui::install_effect_api( services, runtime_generation, world_generation,
                                      require_read, require_write );
    cata::lua_ui::install_bionic_api( services, runtime_generation, world_generation,
                                      require_read, require_write );
    sol::table bionics = services["bionics"];
    bionics.set_function( "summary", [require_read, runtime_generation, world_generation](
    sol::this_state state, const cata::lua_ui::game_handle & handle ) {
        require_read();
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.bionics.summary requires a character handle"
            } );
        }
        const auto energy_value = []( const units::energy & value ) {
            return cata::lua_ui::script_unit_value::from_canonical_integer(
                       "energy", "millijoule", value.value() );
        };
        sol::table value = lua_state.create_table();
        value["installed_count"] = character->num_bionics();
        value["power"] = energy_value( character->get_power_level() );
        value["maximum_power"] = energy_value( character->get_max_power_level() );
        value["has_capacity"] = character->has_max_power();
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    bionics.set_function( "grant", [require_write, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & id ) {
        require_write();
        if( id.kind() != "bionic" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.bionics.grant requires a valid GameId<bionic>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.bionics.grant requires a character handle"
            } );
        }
        const int before = character->num_bionics();
        const bionic_uid uid = character->add_bionic( bionic_id( id.value() ) );
        sol::table value = lua_state.create_table();
        value["changed"] = character->num_bionics() != before;
        value["uid"] = static_cast<std::uint64_t>( uid );
        value["count"] = character->num_bionics();
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    bionics.set_function( "remove_type", [require_write, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & id ) {
        require_write();
        if( id.kind() != "bionic" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.bionics.remove_type requires a valid GameId<bionic>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.bionics.remove_type requires a character handle"
            } );
        }
        bool changed = false;
        if( const std::optional<bionic *> installed =
                character->find_bionic_by_type( bionic_id( id.value() ) ) ) {
            character->remove_bionic( **installed );
            changed = true;
        }
        sol::table value = lua_state.create_table();
        value["changed"] = changed;
        value["count"] = character->num_bionics();
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    services["bionics"] = std::move( bionics );
    const auto make_wound_snapshot = []( sol::state_view lua_state,
    const bodypart & part ) {
        sol::table snapshot = lua_state.create_table();
        const std::vector<wound> &native_wounds = part.get_wounds();
        for( std::size_t index = 0; index < native_wounds.size(); ++index ) {
            const wound &entry = native_wounds[index];
            double healing_fraction = static_cast<double>( entry.healing_percentage() );
            if( !std::isfinite( healing_fraction ) ) {
                healing_fraction = 0.0;
            }
            healing_fraction = std::clamp( healing_fraction, 0.0, 1.0 );
            sol::table value = lua_state.create_table();
            value["id"] = cata::lua_ui::script_game_id( "wound", entry.type.str() );
            value["base_pain"] = entry.get_base_pain();
            value["current_pain"] = entry.get_pain();
            value["healing_time"] =
                cata::lua_ui::script_time_duration::from_native( entry.get_healing_time() );
            value["healing_progress"] =
                cata::lua_ui::script_time_duration::from_native( entry.get_healing_progress() );
            value["healing_fraction"] = healing_fraction;
            snapshot[index + 1] = std::move( value );
        }
        return snapshot;
    };
    const auto same_wounds = []( const std::vector<wound> &lhs,
    const std::vector<wound> &rhs ) {
        if( lhs.size() != rhs.size() ) {
            return false;
        }
        for( std::size_t index = 0; index < lhs.size(); ++index ) {
            if( lhs[index].type != rhs[index].type ||
                lhs[index].get_base_pain() != rhs[index].get_base_pain() ||
                lhs[index].get_pain() != rhs[index].get_pain() ||
                lhs[index].get_healing_time() != rhs[index].get_healing_time() ||
                lhs[index].get_healing_progress() != rhs[index].get_healing_progress() ) {
                return false;
            }
        }
        return true;
    };
    sol::table wounds = lua.create_table();
    wounds.set_function( "snapshot", [require_read, runtime_generation, world_generation,
                                                    make_wound_snapshot]( sol::this_state state,
                                              const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & body_part_id ) {
        require_read();
        if( body_part_id.kind() != "body_part" || !body_part_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.snapshot requires a valid GameId<body_part>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.wounds.snapshot requires a character handle"
            } );
        }
        const bodypart_id native_part_id = bodypart_str_id( body_part_id.value() ).id();
        if( !character->has_part( native_part_id, body_part_filter::strict ) ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "missing_part", "services.wounds.snapshot requires an exact character body part"
            } );
        }
        const bodypart *part = character->get_part( native_part_id );
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state,
                                                make_wound_snapshot( lua_state, *part ) ) );
    } );
    wounds.set_function( "add", [require_write, runtime_generation, world_generation,
                                                make_wound_snapshot, same_wounds]( sol::this_state state,
                                         const cata::lua_ui::game_handle & handle,
                                         const cata::lua_ui::script_game_id & body_part_id,
    const cata::lua_ui::script_game_id & wound_id ) {
        require_write();
        if( body_part_id.kind() != "body_part" || !body_part_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.add requires a valid GameId<body_part>" );
        }
        if( wound_id.kind() != "wound" || !wound_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.add requires a valid GameId<wound>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.wounds.add requires a character handle"
            } );
        }
        const bodypart_id native_part_id = bodypart_str_id( body_part_id.value() ).id();
        if( !character->has_part( native_part_id, body_part_filter::strict ) ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "missing_part", "services.wounds.add requires an exact character body part"
            } );
        }
        bodypart *part = character->get_part( native_part_id );
        const std::vector<wound> before_native = part->get_wounds();
        sol::table before = make_wound_snapshot( lua_state, *part );
        const wound_type_id native_wound_id( wound_id.value() );
        const int limit = native_wound_id->get_limit();
        const std::size_t existing_count = std::count_if(
                                               before_native.begin(), before_native.end(),
        [&native_wound_id]( const wound & existing ) {
            return existing.type == native_wound_id;
        } );
        if( limit == 0 || existing_count < static_cast<std::size_t>( limit ) ) {
            character->apply_wound( native_part_id, native_wound_id );
        }
        sol::table after = make_wound_snapshot( lua_state, *part );
        sol::table value = lua_state.create_table();
        value["changed"] = !same_wounds( before_native, part->get_wounds() );
        value["before"] = std::move( before );
        value["after"] = std::move( after );
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    wounds.set_function( "remove", [require_write, runtime_generation, world_generation,
                                                   make_wound_snapshot]( sol::this_state state,
                                            const cata::lua_ui::game_handle & handle,
                                            const cata::lua_ui::script_game_id & body_part_id,
    const cata::lua_ui::script_game_id & wound_id ) {
        require_write();
        if( body_part_id.kind() != "body_part" || !body_part_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.remove requires a valid GameId<body_part>" );
        }
        if( wound_id.kind() != "wound" || !wound_id.is_valid() ) {
            throw std::invalid_argument(
                "services.wounds.remove requires a valid GameId<wound>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.wounds.remove requires a character handle"
            } );
        }
        const bodypart_id native_part_id = bodypart_str_id( body_part_id.value() ).id();
        if( !character->has_part( native_part_id, body_part_filter::strict ) ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "missing_part", "services.wounds.remove requires an exact character body part"
            } );
        }
        bodypart *part = character->get_part( native_part_id );
        sol::table before = make_wound_snapshot( lua_state, *part );
        const std::size_t count_before = part->get_wounds().size();
        part->remove_all_wounds_of_type( wound_type_id( wound_id.value() ) );
        sol::table after = make_wound_snapshot( lua_state, *part );
        sol::table value = lua_state.create_table();
        const bool changed = part->get_wounds().size() != count_before;
        if( changed ) {
            character->on_stat_change(
                "perceived_pain", character->get_perceived_pain() );
        }
        value["changed"] = changed;
        value["before"] = std::move( before );
        value["after"] = std::move( after );
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    services["wounds"] = std::move( wounds );
    cata::lua_ui::install_mutation_api( services, runtime_generation, world_generation,
                                        require_read, require_write );
    cata::lua_ui::install_skill_api( services, runtime_generation, world_generation,
                                     require_read, require_write );
    cata::lua_ui::install_proficiency_api( services, runtime_generation, world_generation,
                                           require_read, require_write );
    cata::lua_ui::install_vitamin_api( services, runtime_generation, world_generation,
                                       require_read, require_write );
    cata::lua_ui::install_addiction_api( services, runtime_generation, world_generation,
                                         require_read, require_write );
    cata::lua_ui::install_need_api( services, runtime_generation, world_generation,
                                    require_read, require_write );
    cata::lua_ui::install_activity_api(
        services, runtime_generation, world_generation,
        require_read, require_write );
    sol::table morale = lua.create_table();
    morale.set_function( "add", [require_write, runtime_generation, world_generation](
                             sol::this_state state, const cata::lua_ui::game_handle & handle,
                             const cata::lua_ui::script_game_id & id, const std::int64_t bonus,
    const std::int64_t max_bonus, const sol::optional<sol::table> &options ) {
        require_write();
        if( id.kind() != "morale" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.morale.add requires a valid GameId<morale>" );
        }
        if( bonus < std::numeric_limits<int>::min() ||
            bonus > std::numeric_limits<int>::max() ||
            max_bonus < std::numeric_limits<int>::min() ||
            max_bonus > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument(
                "services.morale.add bonus values exceed native integer bounds" );
        }
        time_duration duration = 1_hours;
        time_duration decay_start = 30_minutes;
        bool capped = false;
        if( options ) {
            for( const auto &entry : *options ) {
                const sol::object key_object = entry.first;
                if( key_object.get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "services.morale.add option keys must be strings" );
                }
                const std::string key = key_object.as<std::string>();
                const sol::object value = entry.second;
                if( key == "duration" || key == "decay_start" ) {
                    if( !value.is<cata::lua_ui::script_time_duration>() ) {
                        throw std::invalid_argument(
                            "services.morale.add time options must be TimeDuration values" );
                    }
                    const time_duration native =
                        value.as<cata::lua_ui::script_time_duration>().to_native();
                    if( native < 0_turns ) {
                        throw std::invalid_argument(
                            "services.morale.add time options cannot be negative" );
                    }
                    if( key == "duration" ) {
                        duration = native;
                    } else {
                        decay_start = native;
                    }
                } else if( key == "capped" ) {
                    if( !value.is<bool>() ) {
                        throw std::invalid_argument(
                            "services.morale.add capped must be a boolean" );
                    }
                    capped = value.as<bool>();
                } else {
                    throw std::invalid_argument(
                        "services.morale.add received unknown option '" + key + "'" );
                }
            }
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.morale.add requires a character handle"
            } );
        }
        const morale_type native_id( id.value() );
        const int before = character->has_morale( native_id );
        character->add_morale( native_id, static_cast<int>( bonus ),
                               static_cast<int>( max_bonus ), duration, decay_start, capped );
        const int after = character->has_morale( native_id );
        sol::table result = lua_state.create_table();
        result["changed"] = after != before;
        result["before"] = before;
        result["after"] = after;
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( result ) ) );
    } );
    morale.set_function( "remove", [require_write, runtime_generation, world_generation](
                             sol::this_state state, const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & id ) {
        require_write();
        if( id.kind() != "morale" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.morale.remove requires a valid GameId<morale>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.morale.remove requires a character handle"
            } );
        }
        const morale_type native_id( id.value() );
        const int before = character->has_morale( native_id );
        character->rem_morale( native_id );
        const int after = character->has_morale( native_id );
        sol::table result = lua_state.create_table();
        result["changed"] = after != before;
        result["before"] = before;
        result["after"] = after;
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( result ) ) );
    } );
    services["morale"] = std::move( morale );
    cata::lua_ui::install_martial_art_api( services, runtime_generation, world_generation,
                                           require_read, require_write );
    sol::table martial_arts = services["martial_arts"];
    martial_arts.set_function( "learn", [require_write, runtime_generation, world_generation](
                                   sol::this_state state, const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & id ) {
        require_write();
        if( id.kind() != "martial_art" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.martial_arts.learn requires a valid GameId<martial_art>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.martial_arts.learn requires a character handle"
            } );
        }
        const matype_id native_id( id.value() );
        const bool before = character->has_martialart( native_id );
        character->martial_arts_data->add_martialart( native_id );
        const bool known = character->has_martialart( native_id );
        sol::table value = lua_state.create_table();
        value["changed"] = known != before;
        value["known"] = known;
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    martial_arts.set_function( "forget", [require_write, runtime_generation, world_generation](
                                   sol::this_state state, const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & id ) {
        require_write();
        if( id.kind() != "martial_art" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.martial_arts.forget requires a valid GameId<martial_art>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.martial_arts.forget requires a character handle"
            } );
        }
        const matype_id native_id( id.value() );
        const bool before = character->has_martialart( native_id );
        character->martial_arts_data->clear_style( native_id );
        const bool known = character->has_martialart( native_id );
        sol::table value = lua_state.create_table();
        value["changed"] = known != before;
        value["known"] = known;
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    services["martial_arts"] = std::move( martial_arts );
    cata::lua_ui::install_vehicle_api( services, runtime_generation, world_generation,
                                       require_read, require_write );
    cata::lua_ui::install_npc_api(
        services, runtime_generation, world_generation,
        require_read, require_write, []() {
        if( active_world_generation ==
            std::numeric_limits<std::size_t>::max() ) {
            active_world_generation = 1;
        } else {
            ++active_world_generation;
        }
    } );
    cata::lua_ui::install_trade_api( services, runtime_generation, world_generation,
                                     require_read, require_write );
    cata::lua_ui::install_magic_api( services, runtime_generation, world_generation,
                                     require_read, require_write );
    cata::lua_ui::install_mission_api( services, runtime_generation, world_generation,
                                       require_read, require_write );
    cata::lua_ui::install_horde_api( services, runtime_generation, world_generation,
                                     require_read, require_write );
    cata::lua_ui::install_world_api( services, runtime_generation, world_generation,
                                     require_read, require_write );
    cata::lua_ui::install_item_api( services, runtime_generation, world_generation,
                                    require_read, require_write );
    sol::table inventory = services["inventory"];
    inventory.set_function( "wielded", [require_read, runtime_generation,
                                                      world_generation]( sol::this_state state,
    const cata::lua_ui::game_handle & handle ) {
        require_read();
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.inventory.wielded requires a character handle"
            } );
        }
        item_location wielded = character->get_wielded_item();
        if( !wielded ) {
            return cata::lua_ui::make_game_value_result(
                       lua_state, sol::make_object( lua_state, sol::lua_nil ) );
        }
        const tripoint_abs_ms position = character->pos_abs();
        cata::lua_ui::game_handle_locator locator;
        locator.scope = "character_wielded";
        locator.stable_id = wielded->uid().get_value();
        locator.x = position.x();
        locator.y = position.y();
        locator.z = position.z();
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object(
                       lua_state, cata::lua_ui::game_handle::from_item(
                           *wielded, std::move( locator ), runtime_generation(),
                           world_generation() ) ) );
    } );
    inventory.set_function( "is_wearing", [require_read, runtime_generation,
                                                    world_generation]( sol::this_state state,
    const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & id ) {
        require_read();
        if( id.kind() != "item" ) {
            throw std::invalid_argument(
                "services.inventory.is_wearing requires a GameId<item>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.inventory.is_wearing requires a character handle"
            } );
        }
        const itype_id native_id( id.value() );
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object(
                       lua_state, character->is_wearing( native_id ) ) );
    } );
    services["inventory"] = std::move( inventory );
    cata::lua_ui::install_zone_api( lua, services, runtime_generation, world_generation,
                                    require_read, require_write );
    cata::lua_ui::install_achievement_api( services, require_read, require_write );
    sol::table achievements = services["achievements"];
    achievements.set_function( "complete", [require_write](
    sol::this_state state, const cata::lua_ui::script_game_id & id ) {
        require_write();
        if( id.kind() != "achievement" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.achievements.complete requires a valid GameId<achievement>" );
        }
        const achievement_id native_id( id.value() );
        achievements_tracker &tracker = get_achievements();
        const std::vector<const achievement *> valid = tracker.valid_achievements();
        const auto found = std::find_if( valid.begin(), valid.end(), [&native_id](
        const achievement * entry ) {
            return entry != nullptr && entry->id == native_id;
        } );
        bool changed = false;
        if( found != valid.end() &&
            tracker.is_completed( native_id ) == achievement_completion::pending ) {
            tracker.report_achievement( *found, achievement_completion::completed );
            changed = true;
        }
        sol::state_view lua_state( state );
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, changed ) );
    } );
    services["achievements"] = std::move( achievements );
    cata::lua_ui::install_statistics_api( services, require_read );
    cata::lua_ui::install_faction_api( services, require_read, require_write );
    cata::lua_ui::install_camp_api(
        services, runtime_generation, world_generation,
        require_read, require_write );
    cata::lua_ui::install_weather_api( services, require_read, require_write );
    cata::lua_ui::install_crafting_api(
        services, runtime_generation, world_generation,
        require_read, require_write, has_callback, source_id );
    sol::table recipes = services["recipes"];
    recipes.set_function( "knows", [require_read, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & id ) {
        require_read();
        if( id.kind() != "recipe" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.recipes.knows requires a valid GameId<recipe>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.recipes.knows requires a character handle"
            } );
        }
        const bool known = character->knows_recipe( &recipe_id( id.value() ).obj() );
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, known ) );
    } );
    recipes.set_function( "learn", [require_write, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & id ) {
        require_write();
        if( id.kind() != "recipe" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.recipes.learn requires a valid GameId<recipe>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.recipes.learn requires a character handle"
            } );
        }
        const recipe *target = &recipe_id( id.value() ).obj();
        const bool before = character->knows_recipe( target );
        character->learn_recipe( target );
        const bool known = character->knows_recipe( target );
        sol::table value = lua_state.create_table();
        value["changed"] = known != before;
        value["known"] = known;
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    recipes.set_function( "forget", [require_write, runtime_generation, world_generation](
                              sol::this_state state, const cata::lua_ui::game_handle & handle,
    const cata::lua_ui::script_game_id & id ) {
        require_write();
        if( id.kind() != "recipe" || !id.is_valid() ) {
            throw std::invalid_argument(
                "services.recipes.forget requires a valid GameId<recipe>" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target", "services.recipes.forget requires a character handle"
            } );
        }
        const recipe *target = &recipe_id( id.value() ).obj();
        const bool before = character->knows_recipe( target );
        character->forget_recipe( target );
        const bool known = character->knows_recipe( target );
        sol::table value = lua_state.create_table();
        value["changed"] = known != before;
        value["known"] = known;
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    recipes.set_function( "forget_category", [require_write, runtime_generation,
                                         world_generation]( sol::this_state state,
                                  const cata::lua_ui::game_handle & handle,
                                  const cata::lua_ui::script_game_id & category,
    const sol::optional<std::string> &subcategory ) {
        require_write();
        if( category.kind() != "crafting_category" || !category.is_valid() ) {
            throw std::invalid_argument(
                "services.recipes.forget_category requires a valid "
                "GameId<crafting_category>" );
        }
        const std::string native_subcategory = subcategory.value_or( std::string() );
        if( native_subcategory.size() > 256 ||
            native_subcategory.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.recipes.forget_category subcategory exceeds its native limit" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> resolved =
            handle.resolve_creature( runtime_generation(), world_generation() );
        if( !resolved ) {
            return cata::lua_ui::make_game_error_result( lua_state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return cata::lua_ui::make_game_error_result( lua_state, {
                "wrong_target",
                "services.recipes.forget_category requires a character handle"
            } );
        }
        const recipe_subset &known_recipes = character->get_learned_recipes();
        const std::size_t known_before = known_recipes.size();
        const std::vector<const recipe *> recipes_to_forget =
            recipes_from_cat( known_recipes, crafting_category_id( category.value() ),
                              native_subcategory ).first;
        for( const recipe *entry : recipes_to_forget ) {
            character->forget_recipe( entry );
        }
        const std::size_t known_after = character->get_learned_recipes().size();
        const std::size_t forgotten_count = known_before > known_after ?
                                            known_before - known_after : 0;
        sol::table value = lua_state.create_table();
        value["changed"] = forgotten_count > 0;
        value["forgotten_count"] = forgotten_count;
        value["known_before"] = known_before;
        value["known_after"] = known_after;
        value["category"] = cata::lua_ui::script_game_id(
                                "crafting_category", category.value() );
        if( subcategory ) {
            value["subcategory"] = *subcategory;
        } else {
            value["subcategory"] = sol::nil;
        }
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, std::move( value ) ) );
    } );
    services["recipes"] = std::move( recipes );
    cata::lua_ui::install_overmap_api( services, require_read, require_write,
                                       random_index );
    cata::lua_ui::install_game_snapshot_api( services, require_read );
    cata::lua_ui::install_game_info_api( services, require_read, require_write,
                                         has_callback );

    const auto require_snippet_key = []( const std::string &value,
    const std::string_view api_name ) {
        if( value.empty() || value.size() > 512 ||
            value.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " requires 1 to 512 non-NUL bytes" );
        }
    };
    const auto next_snippet_seed = [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready || owner->callback_depth <= 0 ) {
            throw std::runtime_error(
                "Platform snippet randomness is only available inside a runtime callback" );
        }
        return static_cast<unsigned int>( owner->random_engine() );
    };
    const auto snippet_record = []( sol::state_view state,
    const snippet_id &id ) {
        sol::table record = state.create_table();
        record["id"] = id.str();
        const std::optional<translation> text =
            SNIPPET.get_snippet_by_id( id );
        record["text"] = text ? text->translated() : std::string();
        const std::optional<translation> name =
            SNIPPET.get_name_by_id( id );
        if( name ) {
            record["name"] = name->translated();
        } else {
            record["name"] = sol::nil;
        }
        return record;
    };

    sol::table snippets = lua.create_table();
    snippets.set_function( "has_category", [require_read, require_snippet_key](
    const std::string &category ) {
        require_read();
        require_snippet_key( category, "services.snippets.has_category" );
        return SNIPPET.has_category( category );
    } );
    snippets.set_function( "has", [require_read, require_snippet_key](
    const std::string &id ) {
        require_read();
        require_snippet_key( id, "services.snippets.has" );
        return SNIPPET.has_snippet_with_id( snippet_id( id ) );
    } );
    snippets.set_function( "get", [require_read, require_snippet_key,
                                     snippet_record](
    sol::this_state state, const std::string &id ) {
        require_read();
        require_snippet_key( id, "services.snippets.get" );
        sol::state_view lua_state( state );
        const snippet_id native_id( id );
        if( !SNIPPET.has_snippet_with_id( native_id ) ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object(
                   lua_state, snippet_record( lua_state, native_id ) );
    } );
    snippets.set_function( "expand", [require_read, next_snippet_seed](
    const std::string &text ) {
        require_read();
        if( text.size() > maximum_presentation_text_bytes ||
            text.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.snippets.expand text exceeds its native string limit" );
        }
        return SNIPPET.expand( text, next_snippet_seed() );
    } );
    snippets.set_function( "random", [require_read, require_snippet_key,
                                        next_snippet_seed](
    sol::this_state state, const std::string &category ) {
        require_read();
        require_snippet_key( category, "services.snippets.random" );
        sol::state_view lua_state( state );
        const std::optional<translation> selected =
            SNIPPET.random_from_category(
                category, next_snippet_seed() );
        if( !selected ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object(
                   lua_state, SNIPPET.expand(
                       selected->translated(), next_snippet_seed() ) );
    } );
    snippets.set_function( "random_named", [require_read, require_snippet_key,
            next_snippet_seed, snippet_record](
    sol::this_state state, const std::string &category ) {
        require_read();
        require_snippet_key( category, "services.snippets.random_named" );
        sol::state_view lua_state( state );
        const snippet_id selected = SNIPPET.random_id_from_category(
                                        category, next_snippet_seed() );
        if( selected.is_null() ) {
            return sol::make_object( lua_state, sol::lua_nil );
        }
        return sol::make_object(
                   lua_state, snippet_record( lua_state, selected ) );
    } );
    services["snippets"] = std::move( snippets );

    sol::table text_services = lua.create_table();
    text_services.set_function( "expand_for", [require_read, next_snippet_seed,
            runtime_generation, world_generation](
                sol::this_state state, const std::string &text,
                const cata::lua_ui::game_handle &alpha_handle,
                const sol::optional<cata::lua_ui::game_handle> &beta_handle,
    const sol::optional<std::string> &item_id ) {
        require_read();
        if( text.size() > maximum_presentation_text_bytes ||
            text.find( '\0' ) != std::string::npos ||
            ( item_id && ( item_id->size() > 256 ||
                           item_id->find( '\0' ) != std::string::npos ) ) ) {
            throw std::invalid_argument(
                "services.text.expand_for input exceeds its native string limit" );
        }
        sol::state_view lua_state( state );
        const cata::lua_ui::native_handle_result<Creature> alpha =
            alpha_handle.resolve_creature(
                runtime_generation(), world_generation() );
        if( !alpha ) {
            return cata::lua_ui::make_game_error_result(
                       lua_state, *alpha.error );
        }
        const Creature *beta = nullptr;
        if( beta_handle ) {
            const cata::lua_ui::native_handle_result<Creature> resolved =
                beta_handle->resolve_creature(
                    runtime_generation(), world_generation() );
            if( !resolved ) {
                return cata::lua_ui::make_game_error_result(
                           lua_state, *resolved.error );
            }
            beta = resolved.value;
        }
        const_dialogue dialogue_context(
            get_const_talker_for( *alpha.value ),
            beta == nullptr ? nullptr : get_const_talker_for( *beta ) );
        std::unique_ptr<const_talker> fallback =
            get_const_talker_for( get_player_character() );
        std::string expanded = SNIPPET.expand(
                                   text, next_snippet_seed() );
        parse_tags(
            expanded, *dialogue_context.const_actor( false ),
            dialogue_context.has_beta ?
            *dialogue_context.const_actor( true ) : *fallback,
            dialogue_context,
            item_id && !item_id->empty() ?
            itype_id( *item_id ) : itype_id::NULL_ID() );
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object(
                       lua_state, std::move( expanded ) ) );
    } );
    services["text"] = std::move( text_services );

    sol::table lore = lua.create_table();
    lore.set_function( "knows_snippet", [require_read, require_snippet_key](
    const std::string &id ) {
        require_read();
        require_snippet_key( id, "services.lore.knows_snippet" );
        return get_avatar().has_seen_snippet( snippet_id( id ) );
    } );
    lore.set_function( "remember_snippet", [require_write, require_snippet_key](
    const std::string &id ) {
        require_write();
        require_snippet_key( id, "services.lore.remember_snippet" );
        const snippet_id native_id( id );
        if( !SNIPPET.has_snippet_with_id( native_id ) ) {
            throw std::invalid_argument(
                "services.lore.remember_snippet requires an existing identified snippet" );
        }
        avatar &player = get_avatar();
        const bool known = player.has_seen_snippet( native_id );
        player.add_snippet( native_id );
        return !known;
    } );
    lore.set_function( "known_snippets", [require_read]( sol::this_state state ) {
        require_read();
        sol::state_view lua_state( state );
        const std::set<snippet_id> &known = get_avatar().get_snippets();
        sol::table result = lua_state.create_table(
                                static_cast<int>( known.size() ), 0 );
        std::size_t index = 0;
        for( const snippet_id &id : known ) {
            result[++index] = id.str();
        }
        return result;
    } );
    services["lore"] = std::move( lore );

    const auto platform_message_type = []( const std::string &name ) {
        if( name == "good" ) {
            return m_good;
        }
        if( name == "bad" ) {
            return m_bad;
        }
        if( name == "mixed" ) {
            return m_mixed;
        }
        if( name == "warning" ) {
            return m_warning;
        }
        if( name == "info" ) {
            return m_info;
        }
        if( name == "neutral" ) {
            return m_neutral;
        }
        if( name == "debug" ) {
            return m_debug;
        }
        if( name == "headshot" ) {
            return m_headshot;
        }
        if( name == "critical" ) {
            return m_critical;
        }
        if( name == "grazing" ) {
            return m_grazing;
        }
        throw std::invalid_argument(
            "services.messages received unknown message type '" + name + "'" );
    };
    const auto add_audible_message = [weak, require_write,
            platform_message_type]( const std::string &message,
                                    const sol::optional<std::string> &type,
    const bool from_outdoors ) {
        require_write();
        if( message.size() > 8192 ||
            message.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.messages audible message exceeds its native string limit" );
        }
        avatar &player = get_avatar();
        static const efftype_id effect_sleep( "sleep" );
        if( player.has_effect( effect_sleep ) || player.is_deaf() ) {
            return false;
        }
        if( from_outdoors ) {
            const int depth = std::max( 0, -get_map().get_abs_sub().z() );
            if( depth > 0 ) {
                const double hearing = std::max(
                                           0.01, static_cast<double>( player.hearing_ability() ) );
                const int denominator = std::max(
                                            1, static_cast<int>( std::ceil(
                                                    2.0 * depth / hearing ) ) );
                const std::shared_ptr<runtime> owner = weak.lock();
                if( !owner ) {
                    throw std::runtime_error( "stale Platform runtime" );
                }
                std::uniform_int_distribution<int> distribution( 1, denominator );
                if( distribution( owner->random_engine ) != 1 ) {
                    return false;
                }
            }
        }
        player.add_msg_if_player(
            game_message_params( platform_message_type(
                                     type.value_or( "neutral" ) ) ), message );
        return true;
    };
    sol::table platform_messages = services["messages"];
    platform_messages.set_function( "add", [weak, platform_message_type](
    const std::string &message, const sol::optional<std::string> &type ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error(
                "services.messages.add is only available after world_ready" );
        }
        if( message.size() > 8192 || message.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.messages.add message exceeds its native string limit" );
        }
        ::add_msg(
            game_message_params( platform_message_type(
                                     type.value_or( "neutral" ) ) ), message );
        return true;
    } );
    platform_messages.set_function( "add_if_audible", [add_audible_message](
    const std::string &message, const sol::optional<std::string> &type ) {
        return add_audible_message( message, type, false );
    } );
    platform_messages.set_function( "add_from_outdoors", [add_audible_message](
    const std::string &message, const sol::optional<std::string> &type ) {
        return add_audible_message( message, type, true );
    } );
    services["messages"] = std::move( platform_messages );

    sol::table dialogue_services = lua.create_table();
    dialogue_services.set_function( "open_topic", [require_write](
    const std::string &topic ) {
        require_write();
        if( topic.empty() || topic.size() > 256 ||
            std::any_of( topic.begin(), topic.end(), []( const unsigned char value ) {
            return value < 0x20U || value == 0x7fU;
        } ) ) {
            throw std::invalid_argument(
                "services.dialogue.open_topic requires 1 to 256 non-control bytes" );
        }
        if( get_talk_topic( topic ) == nullptr ) {
            throw std::invalid_argument(
                "services.dialogue.open_topic received an unknown dialogue topic" );
        }
        get_avatar().talk_to(
            get_talker_for( std::vector<std::string> { topic } ),
            false, false, true );
        return true;
    } );
    services["dialogue"] = std::move( dialogue_services );

    // Platform owns an isolated gameplay random stream.  The shared v5
    // implementation above intentionally uses the engine stream, so replace
    // only the Platform table with callbacks backed by runtime::random_engine.
    // This keeps ordinary Lua composition deterministic across runtime-only
    // hot reloads without changing the v5 contract.
    sol::table random = services["random"];
    const auto require_random_runtime = [weak]() {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready || owner->callback_depth <= 0 ) {
            throw std::runtime_error(
                "Platform gameplay randomness is only available inside a runtime callback" );
        }
        return owner;
    };
    const auto random_integer = [require_random_runtime]( const std::int64_t minimum,
    const std::int64_t maximum ) {
        if( minimum < -1000000000LL || maximum > 1000000000LL || minimum > maximum ) {
            throw std::invalid_argument(
                "services.random.int requires an ordered range within -1000000000..1000000000" );
        }
        const std::shared_ptr<runtime> owner = require_random_runtime();
        std::uniform_int_distribution<std::int64_t> distribution( minimum, maximum );
        return distribution( owner->random_engine );
    };
    random.set_function( "int", random_integer );
    random.set_function( "chance", [require_random_runtime]( const std::int64_t numerator,
    const std::int64_t denominator ) {
        const std::shared_ptr<runtime> owner = require_random_runtime();
        if( denominator <= 0 || denominator > 1000000000LL || numerator < 0 ||
            numerator > denominator ) {
            throw std::invalid_argument(
                "services.random.chance requires 0 <= numerator <= denominator <= 1000000000" );
        }
        if( numerator == 0 ) {
            return false;
        }
        if( numerator == denominator ) {
            return true;
        }
        std::uniform_int_distribution<std::int64_t> distribution( 1, denominator );
        return distribution( owner->random_engine ) <= numerator;
    } );
    random.set_function( "one_in", [require_random_runtime]( const double raw_denominator ) {
        const std::shared_ptr<runtime> owner = require_random_runtime();
        if( !std::isfinite( raw_denominator ) || raw_denominator < -1000000000.0 ||
            raw_denominator > 1000000000.0 ) {
            throw std::invalid_argument(
                "services.random.one_in requires a finite denominator within native bounds" );
        }
        const std::int64_t denominator = static_cast<std::int64_t>( raw_denominator );
        if( denominator <= 1 ) {
            return true;
        }
        std::uniform_int_distribution<std::int64_t> distribution( 0, denominator - 1 );
        return distribution( owner->random_engine ) == 0;
    } );
    random.set_function( "probability", [require_random_runtime]( const double numerator,
    const double denominator ) {
        const std::shared_ptr<runtime> owner = require_random_runtime();
        if( !std::isfinite( numerator ) || !std::isfinite( denominator ) ||
            denominator <= 0.0 || numerator < 0.0 || numerator > denominator ) {
            throw std::invalid_argument(
                "services.random.probability requires finite 0 <= numerator <= denominator" );
        }
        if( numerator == 0.0 ) {
            return false;
        }
        if( numerator == denominator ) {
            return true;
        }
        std::uniform_real_distribution<double> distribution( 0.0, 1.0 );
        return distribution( owner->random_engine ) <= numerator / denominator;
    } );
    random.set_function( "sample_integers", [require_random_runtime](
                             sol::this_state state, const std::int64_t minimum, const std::int64_t maximum,
    const std::int64_t requested_count, const sol::optional<bool> &with_replacement ) {
        if( minimum < -1000000000LL || maximum > 1000000000LL || minimum > maximum ||
            requested_count < 0 || requested_count > 1024 ) {
            throw std::invalid_argument(
                "services.random.sample_integers requires an ordered bounded range and 0..1024 samples" );
        }
        const bool replace = with_replacement.value_or( false );
        const std::uint64_t population = static_cast<std::uint64_t>( maximum - minimum ) + 1;
        if( !replace && static_cast<std::uint64_t>( requested_count ) > population ) {
            throw std::invalid_argument(
                "services.random.sample_integers cannot exceed the range without replacement" );
        }
        const std::shared_ptr<runtime> owner = require_random_runtime();
        std::uniform_int_distribution<std::int64_t> distribution( minimum, maximum );
        sol::state_view lua_state( state );
        sol::table result = lua_state.create_table( requested_count, 0 );
        std::unordered_set<std::int64_t> selected;
        for( std::int64_t index = 1; index <= requested_count; ++index ) {
            std::int64_t value = distribution( owner->random_engine );
            if( !replace ) {
                while( !selected.insert( value ).second ) {
                    value = distribution( owner->random_engine );
                }
            }
            result[index] = value;
        }
        return result;
    } );
    random.set_function( "contested", [random_integer]( const double check,
    const double difficulty, const sol::optional<std::int64_t> &optional_die_size ) {
        const std::int64_t die_size = optional_die_size.value_or( 10 );
        if( !std::isfinite( check ) || !std::isfinite( difficulty ) ||
            die_size <= 0 || die_size > 1000000000LL ) {
            throw std::invalid_argument(
                "services.random.contested requires finite values and a die size within 1..1000000000" );
        }
        return static_cast<double>( random_integer( 1, die_size ) ) + check > difficulty;
    } );
    services["random"] = std::move( random );

    sol::table gameplay = lua.create_table();
    const auto make_math_dialogue = [runtime_generation, world_generation](
        const sol::optional<cata::lua_ui::game_handle> &requested_actor,
        const sol::optional<sol::table> &requested_context ) {
        std::unique_ptr<talker> alpha;
        if( requested_actor ) {
            const cata::lua_ui::native_handle_result<Creature> resolved =
                requested_actor->resolve_creature(
                    runtime_generation(), world_generation() );
            if( !resolved ) {
                throw std::invalid_argument( resolved.error->message );
            }
            alpha = get_talker_for( *resolved.value );
        } else {
            alpha = get_talker_for( get_avatar() );
        }
        auto result = std::make_unique<dialogue>( std::move( alpha ), nullptr );
        if( requested_context ) {
            for( const auto &entry : *requested_context ) {
                if( !entry.first.is<std::string>() ) {
                    throw std::invalid_argument(
                        "services.gameplay.math context keys must be strings" );
                }
                const std::string key = entry.first.as<std::string>();
                if( key.empty() || key.size() > 128 ||
                    std::any_of( key.begin(), key.end(), []( const unsigned char ch ) {
                    return ch == '\0' || ch < 0x20U || ch == 0x7fU;
                } ) ) {
                    throw std::invalid_argument(
                        "services.gameplay.math context keys must be printable and bounded" );
                }
                const sol::object value = entry.second;
                if( value.is<bool>() ) {
                    result->set_value( key, value.as<bool>() ? 1.0 : 0.0 );
                } else if( value.get_type() == sol::type::number ) {
                    const double number = value.as<double>();
                    if( !std::isfinite( number ) ) {
                        throw std::invalid_argument(
                            "services.gameplay.math context numbers must be finite" );
                    }
                    result->set_value( key, number );
                } else if( value.is<std::string>() ) {
                    result->set_value( key, value.as<std::string>() );
                } else if( value.is<cata::lua_ui::script_tripoint_coord>() ) {
                    const cata::lua_ui::script_tripoint_coord position =
                        value.as<cata::lua_ui::script_tripoint_coord>();
                    if( position.native_origin() != coords::origin::abs ||
                        position.native_scale() != coords::scale::map_square ) {
                        throw std::invalid_argument(
                            "services.gameplay.math context coordinates must be absolute map-square" );
                    }
                    result->set_value( key, tripoint_abs_ms( position.to_native() ) );
                } else {
                    throw std::invalid_argument(
                        "services.gameplay.math context values must be scalar or Tripoint" );
                }
            }
        }
        return result;
    };
    sol::table math = lua.create_table();
    math.set_function( "evaluate", [require_read, make_math_dialogue](
        sol::this_state state, const std::string &source,
        const sol::optional<cata::lua_ui::game_handle> &actor,
        const sol::optional<sol::table> &context ) {
        require_read();
        if( source.empty() || source.size() > 8192 || source.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.math.evaluate expression must be 1..8192 bytes" );
        }
        math_exp expression;
        if( !expression.parse( source, true ) ) {
            throw std::invalid_argument(
                "services.gameplay.math.evaluate could not parse expression" );
        }
        std::unique_ptr<dialogue> conversation = make_math_dialogue( actor, context );
        const double result = expression.eval( *conversation );
        if( !std::isfinite( result ) ) {
            throw std::runtime_error(
                "services.gameplay.math.evaluate produced a non-finite result" );
        }
        sol::state_view lua_state( state );
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, result ) );
    } );
    math.set_function( "apply", [require_write, make_math_dialogue](
        sol::this_state state, const std::string &source,
        const sol::optional<cata::lua_ui::game_handle> &actor,
        const sol::optional<sol::table> &context ) {
        require_write();
        if( source.empty() || source.size() > 8192 || source.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.math.apply expression must be 1..8192 bytes" );
        }
        math_exp expression;
        if( !expression.parse( source, true ) ) {
            throw std::invalid_argument(
                "services.gameplay.math.apply could not parse expression" );
        }
        std::unique_ptr<dialogue> conversation = make_math_dialogue( actor, context );
        const double result = expression.eval( *conversation );
        if( !std::isfinite( result ) ) {
            throw std::runtime_error(
                "services.gameplay.math.apply produced a non-finite result" );
        }
        sol::state_view lua_state( state );
        return cata::lua_ui::make_game_value_result(
                   lua_state, sol::make_object( lua_state, result ) );
    } );
    gameplay["math"] = std::move( math );
    sol::table strings = lua.create_table();
    strings.set_function( "any_equal", []( const sol::table & values ) {
        const std::size_t count = require_dense_array(
                                      values, "services.gameplay.strings.any_equal values", 2, 1024 );
        std::unordered_set<std::string> seen;
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = values[index];
            if( !value.is<std::string>() ) {
                throw std::invalid_argument(
                    "services.gameplay.strings.any_equal accepts only strings" );
            }
            if( !seen.insert( value.as<std::string>() ).second ) {
                return true;
            }
        }
        return false;
    } );
    strings.set_function( "all_equal", []( const sol::table & values ) {
        const std::size_t count = require_dense_array(
                                      values, "services.gameplay.strings.all_equal values", 1, 1024 );
        const sol::object first = values[1];
        if( !first.is<std::string>() ) {
            throw std::invalid_argument(
                "services.gameplay.strings.all_equal accepts only strings" );
        }
        const std::string expected = first.as<std::string>();
        for( std::size_t index = 2; index <= count; ++index ) {
            const sol::object value = values[index];
            if( !value.is<std::string>() ) {
                throw std::invalid_argument(
                    "services.gameplay.strings.all_equal accepts only strings" );
            }
            if( value.as<std::string>() != expected ) {
                return false;
            }
        }
        return true;
    } );
    gameplay["strings"] = std::move( strings );

    sol::table mods = lua.create_table();
    mods.set_function( "is_loaded", [require_read]( const std::string & id ) {
        require_read();
        if( id.empty() || id.size() > 256 || id.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.mods.is_loaded requires a bounded non-empty Mod id" );
        }
        if( find_active_runtime( id ) ) {
            return true;
        }
        if( !world_generator || world_generator->active_world == nullptr ) {
            return false;
        }
        const mod_id requested( id );
        const std::vector<mod_id> &order = world_generator->active_world->active_mod_order;
        return std::find( order.begin(), order.end(), requested ) != order.end();
    } );
    mods.set_function( "load_order", [require_read]( const std::string & id ) {
        require_read();
        if( id.empty() || id.size() > 256 || id.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.mods.load_order requires a bounded non-empty Mod id" );
        }
        if( !world_generator || world_generator->active_world == nullptr ) {
            return -1;
        }
        const mod_id requested( id );
        const std::vector<mod_id> &order =
            world_generator->active_world->active_mod_order;
        const auto found = std::find(
                               order.begin(), order.end(), requested );
        return found == order.end() ? -1 :
               static_cast<int>( std::distance( order.begin(), found ) );
    } );
    gameplay["mods"] = std::move( mods );

    const auto require_option_id = []( const std::string &id ) {
        if( id.empty() || id.size() > 256 ||
            !std::all_of(
                id.begin(), id.end(),
        []( const unsigned char ch ) {
            return ch >= 0x20U && ch != 0x7fU;
        } ) ) {
            throw std::invalid_argument(
                "services.gameplay.options requires a 1..256 byte "
                "non-control option id" );
        }
    };
    const auto option_snapshot = []( sol::state_view state,
                                     const std::string &id ) {
        options_manager::cOpt &entry =
            get_options().get_option( id );
        sol::table value = state.create_table();
        value["id"] = id;
        value["type"] = entry.getType();
        value["value"] = entry.getValue();
        value["display_value"] = entry.getValueName();
        value["default_value"] = entry.getDefaultText( false );
        value["name"] = entry.getMenuText();
        value["description"] = entry.getTooltip();
        value["page"] = entry.getPage();
        value["hidden"] = entry.is_hidden();
        value["prerequisite_satisfied"] =
            entry.checkPrerequisite();
        return value;
    };
    sol::table gameplay_options = lua.create_table();
    gameplay_options.set_function(
        "has", [require_read, require_option_id]( const std::string &id ) {
        require_read();
        require_option_id( id );
        return get_options().has_option( id );
    } );
    gameplay_options.set_function(
        "get", [require_read, require_option_id, option_snapshot](
            sol::this_state lua_state, const std::string &id ) {
        require_read();
        require_option_id( id );
        sol::state_view state( lua_state );
        if( !get_options().has_option( id ) ) {
            return sol::make_object( state, sol::lua_nil );
        }
        return sol::make_object(
                   state, option_snapshot( state, id ) );
    } );
    gameplay_options.set_function(
        "value", [require_read, require_option_id](
            sol::this_state lua_state, const std::string &id ) {
        require_read();
        require_option_id( id );
        sol::state_view state( lua_state );
        if( !get_options().has_option( id ) ) {
            return sol::make_object( state, sol::lua_nil );
        }
        return sol::make_object(
                   state, get_options().get_option( id ).getValue() );
    } );
    gameplay["options"] = std::move( gameplay_options );

    sol::table environment = lua.create_table();
    environment.set_function( "dimension", [require_read]() {
        require_read();
        if( g == nullptr ) {
            throw std::runtime_error(
                "services.gameplay.environment.dimension requires an active game" );
        }
        return g->get_dimension_prefix().str();
    } );
    environment.set_function(
        "clear_saved_dimension",
        [require_write]( sol::this_state lua_state,
    const std::string &dimension ) {
        require_write();
        if( g == nullptr ) {
            throw std::runtime_error(
                "services.gameplay.environment.clear_saved_dimension requires an active game" );
        }
        if( dimension.empty() || dimension.size() > 128 ||
            !std::all_of(
                dimension.begin(), dimension.end(),
        []( const unsigned char ch ) {
            return std::isalnum( ch ) || ch == '_' || ch == '-';
        } ) ) {
            throw std::invalid_argument(
                "services.gameplay.environment.clear_saved_dimension requires a safe 1..128 byte dimension id" );
        }
        if( dimension == g->get_dimension_prefix().str() ) {
            throw std::invalid_argument(
                "services.gameplay.environment.clear_saved_dimension cannot clear the active dimension" );
        }
        const cata_path target =
            PATH_INFO::dimensions_save_path() / dimension;
        const std::filesystem::path native_target =
            target.get_unrelative_path();
        const bool existed =
            std::filesystem::is_directory( native_target );
        std::uintmax_t removed = 0;
        if( existed ) {
            removed = std::filesystem::remove_all(
                          native_target );
        }
        sol::state_view state( lua_state );
        sol::table value = state.create_table();
        value["dimension"] = dimension;
        value["existed"] = existed;
        value["removed_entries"] = removed;
        value["removed"] = removed > 0;
        return cata::lua_ui::make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );
    environment.set_function( "set_light_override",
    [require_write]( sol::this_state lua_state, const std::int64_t level,
                     const cata::lua_ui::script_time_duration &duration,
    const sol::optional<std::string> &requested_key ) {
        require_write();
        if( g == nullptr ) {
            throw std::runtime_error(
                "services.gameplay.environment.set_light_override requires an active game" );
        }
        if( level < 0 || level > 125 ) {
            throw std::invalid_argument(
                "services.gameplay.environment.set_light_override level must be within 0..125" );
        }
        const std::int64_t duration_turns = duration.turns();
        if( duration_turns < 0 || duration_turns > 864000000 ) {
            throw std::invalid_argument(
                "services.gameplay.environment.set_light_override duration must be within 0..864000000 turns" );
        }
        const std::string key = requested_key.value_or( "" );
        if( key.size() > 256 || key.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.environment.set_light_override key must be at most 256 bytes" );
        }
        get_timed_events().add(
            timed_event_type::CUSTOM_LIGHT_LEVEL,
            calendar::turn + duration.to_native() + 1_seconds,
            -1, static_cast<int>( level ), key );
        sol::state_view state( lua_state );
        sol::table value = state.create_table();
        value["level"] = level;
        value["duration"] = duration;
        value["key"] = key;
        value["changed"] = true;
        return cata::lua_ui::make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    } );
    environment.set_function( "is_night", [require_read]() {
        require_read();
        return ::is_night( calendar::turn );
    } );
    const auto require_environment_position = []( const cata::lua_ui::script_tripoint_coord &
    position, const std::string & api_name ) {
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                api_name + " requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        if( !here.inbounds( absolute ) ) {
            throw std::invalid_argument( api_name + " position is outside the active map" );
        }
        return here.get_bub( absolute );
    };
    environment.set_function( "is_outside", [require_read, require_environment_position](
    const cata::lua_ui::script_tripoint_coord & position ) {
        require_read();
        map &here = get_map();
        return here.is_outside( require_environment_position(
                                    position, "services.gameplay.environment.is_outside" ) );
    } );
    environment.set_function( "line_of_sight", [require_read, require_environment_position](
                                  const cata::lua_ui::script_tripoint_coord & from,
                                  const cata::lua_ui::script_tripoint_coord & to, const std::int64_t range,
    const sol::optional<bool> &with_fields ) {
        require_read();
        if( range < 0 || range > 100000 ) {
            throw std::invalid_argument(
                "services.gameplay.environment.line_of_sight range must be within 0..100000" );
        }
        map &here = get_map();
        const tripoint_bub_ms first = require_environment_position(
                                          from, "services.gameplay.environment.line_of_sight" );
        const tripoint_bub_ms second = require_environment_position(
                                           to, "services.gameplay.environment.line_of_sight" );
        return here.sees( first, second, static_cast<int>( range ),
                          with_fields.value_or( true ) );
    } );
    environment.set_function( "furniture_has_flag", [require_read](
    const cata::lua_ui::script_tripoint_coord & position, const std::string &flag ) {
        require_read();
        if( flag.empty() || flag.size() > 256 || flag.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.environment.furniture_has_flag requires a bounded non-empty furniture flag" );
        }
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.furniture_has_flag requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        if( !here.inbounds( absolute ) ) {
            return false;
        }
        return here.furn( here.get_bub( absolute ) )->has_flag( flag );
    } );
    environment.set_function( "terrain_id", [require_read](
    const cata::lua_ui::script_tripoint_coord & position ) {
        require_read();
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.terrain_id requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        return here.ter( here.get_bub( absolute ) ).id().str();
    } );
    environment.set_function( "furniture_id", [require_read](
    const cata::lua_ui::script_tripoint_coord & position ) {
        require_read();
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.furniture_id requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        return here.furn( here.get_bub( absolute ) ).id().str();
    } );
    environment.set_function( "field_exists", [require_read](
    const cata::lua_ui::script_tripoint_coord & position, const std::string &field_id ) {
        require_read();
        if( field_id.empty() || field_id.size() > 256 || field_id.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.environment.field_exists requires a bounded non-empty field id" );
        }
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.field_exists requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        return !!here.field_at( here.get_bub( absolute ) ).find_field(
                   field_type_id( field_id ) );
    } );
    environment.set_function( "terrain_has_flag", [require_read](
    const cata::lua_ui::script_tripoint_coord & position, const std::string &flag ) {
        require_read();
        if( flag.empty() || flag.size() > 256 || flag.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.gameplay.environment.terrain_has_flag requires a bounded non-empty terrain flag" );
        }
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.terrain_has_flag requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_abs_ms absolute( position.to_native() );
        return here.ter( here.get_bub( absolute ) )->has_flag( flag );
    } );
    environment.set_function( "is_indoor_tile", [require_read](
    const cata::lua_ui::script_tripoint_coord & position ) {
        require_read();
        if( position.native_origin() != coords::origin::abs ||
            position.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.gameplay.environment.is_indoor_tile requires an absolute map-square Tripoint" );
        }
        map &here = get_map();
        const tripoint_bub_ms bub = here.get_bub(
                                        tripoint_abs_ms( position.to_native() ) );
        if( !here.inbounds( bub ) ) {
            return false;
        }
        return !here.is_outside( bub );
    } );
    environment.set_function( "safe_mode_dangerous", [require_read](
    const std::string &direction ) {
        require_read();
        const std::optional<cardinal_direction> dir =
            io::string_to_enum_optional<cardinal_direction>( direction );
        if( !dir ) {
            throw std::invalid_argument(
                "services.gameplay.environment.safe_mode_dangerous requires a valid cardinal direction" );
        }
        return get_avatar().get_mon_visible().dangerous[
                   static_cast<int>( *dir )];
    } );
    gameplay["environment"] = std::move( environment );
    services["gameplay"] = std::move( gameplay );

    sol::table native_events = lua.create_table();
    native_events.set_function(
        "emit",
        [require_write]( const std::string &type_name,
    const sol::optional<sol::table> &requested_args ) {
        require_write();
        if( type_name.empty() || type_name.size() > 128 ) {
            throw std::invalid_argument(
                "services.native_events.emit type must contain 1..128 bytes" );
        }
        const std::optional<event_type> type =
            io::string_to_enum_optional<event_type>( type_name );
        if( !type ) {
            throw std::invalid_argument(
                "services.native_events.emit received an unknown event type" );
        }
        std::map<std::size_t, std::string> indexed_args;
        if( requested_args ) {
            for( const auto &entry : *requested_args ) {
                if( !entry.first.is<lua_Integer>() ||
                    !entry.second.is<std::string>() ) {
                    throw std::invalid_argument(
                        "services.native_events.emit args must be a dense string array" );
                }
                const lua_Integer raw_index =
                    entry.first.as<lua_Integer>();
                if( raw_index <= 0 || raw_index > 64 ) {
                    throw std::invalid_argument(
                        "services.native_events.emit arg index must be within 1..64" );
                }
                std::string value =
                    entry.second.as<std::string>();
                if( value.size() > 1024 ) {
                    throw std::invalid_argument(
                        "services.native_events.emit args cannot exceed 1024 bytes" );
                }
                indexed_args.emplace(
                    static_cast<std::size_t>( raw_index ),
                    std::move( value ) );
            }
        }
        if( !indexed_args.empty() &&
            indexed_args.rbegin()->first != indexed_args.size() ) {
            throw std::invalid_argument(
                "services.native_events.emit args must not contain holes" );
        }
        std::vector<std::string> args;
        args.reserve( indexed_args.size() );
        for( auto &[index, value] : indexed_args ) {
            static_cast<void>( index );
            args.push_back( std::move( value ) );
        }
        get_event_bus().send(
            cata::event::make_dyn( *type, args ) );
        return true;
    } );
    services["native_events"] = std::move( native_events );

    cata::lua_ui::install_game_interaction_api( services, require_write, has_callback );
    const auto play_audible_sound = [weak, require_write](
            const std::string &id, const std::string &variant,
            const sol::optional<int> &requested_volume,
    const bool from_outdoors ) {
        require_write();
        if( id.empty() || id.size() > 128 || id.find( '\0' ) != std::string::npos ||
            variant.empty() || variant.size() > 128 ||
            variant.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.sound audible playback requires bounded sound and variant ids" );
        }
        const int requested = requested_volume.value_or( 80 );
        if( requested < 0 || requested > 128 ) {
            throw std::invalid_argument(
                "services.sound audible playback volume must be within 0..128" );
        }
        avatar &player = get_avatar();
        static const efftype_id effect_sleep( "sleep" );
        if( player.has_effect( effect_sleep ) || player.is_deaf() ) {
            return false;
        }
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner ) {
            throw std::runtime_error( "stale Platform runtime" );
        }
        int volume = requested;
        if( from_outdoors ) {
            const int depth = std::max( 0, -get_map().get_abs_sub().z() );
            if( depth > 0 ) {
                const double hearing = std::max(
                                           0.01, static_cast<double>( player.hearing_ability() ) );
                const int denominator = std::max(
                                            1, static_cast<int>( std::ceil(
                                                    2.0 * depth / hearing ) ) );
                std::uniform_int_distribution<int> gate( 1, denominator );
                if( gate( owner->random_engine ) != 1 ) {
                    return false;
                }
                if( !requested_volume ) {
                    volume = std::clamp(
                                 static_cast<int>( std::round( 80.0 * hearing ) ),
                                 0, 128 );
                }
            }
        }
        std::uniform_real_distribution<double> direction( 0.0, 360.0 );
        sfx::play_variant_sound(
            id, variant, volume,
            units::from_degrees( direction( owner->random_engine ) ) );
        return true;
    };
    sol::table platform_sound = services["sound"];
    platform_sound.set_function( "play_if_audible", [play_audible_sound](
            const std::string &id, const std::string &variant,
    const sol::optional<int> &volume ) {
        return play_audible_sound( id, variant, volume, false );
    } );
    platform_sound.set_function( "play_from_outdoors", [play_audible_sound](
            const std::string &id, const std::string &variant,
    const sol::optional<int> &volume ) {
        return play_audible_sound( id, variant, volume, true );
    } );
    services["sound"] = std::move( platform_sound );
    cata::lua_ui::install_game_world_service_api(
        services, runtime_generation, world_generation, require_read, require_write,
        require_write, has_callback );
    cata::lua_ui::install_variable_api( services, runtime_generation, world_generation,
                                        require_read, require_write, has_callback );
    ccb["services"] = std::move( services );
}

bool validate_runtime( const std::shared_ptr<runtime> &value,
                       bool check_engine_state,
                       std::string &error )
{
    if( !value ) {
        error = "missing Platform runtime";
        return false;
    }
    for( const auto &[event_name, handler_ids] : value->subscriptions ) {
        for( const std::string &handler_id : handler_ids ) {
            if( value->handlers.count( handler_id ) == 0 ) {
                error = "Lua-first Mod '" + value->mod_id + "' event '" + event_name +
                        "' references missing handler '" + handler_id + "'";
                return false;
            }
        }
    }
    for( const auto &[handler_id, migrations] : value->task_migrations ) {
        const auto handler = value->handlers.find( handler_id );
        if( handler == value->handlers.end() ) {
            error = "Lua-first Mod '" + value->mod_id +
                    "' registers task migrations for missing handler '" + handler_id + "'";
            return false;
        }
        for( const auto &[source_version, migration] : migrations ) {
            std::set<int> visited;
            int version = source_version;
            while( version != handler->second.payload_version ) {
                if( !visited.insert( version ).second ) {
                    error = "Lua-first Mod '" + value->mod_id + "' task migration for '" +
                            handler_id + "' contains a cycle at version " +
                            std::to_string( version );
                    return false;
                }
                const auto transition = migrations.find( version );
                if( transition == migrations.end() ) {
                    error = "Lua-first Mod '" + value->mod_id + "' task migration for '" +
                            handler_id + "' has no route from version " +
                            std::to_string( source_version ) + " to handler version " +
                            std::to_string( handler->second.payload_version );
                    return false;
                }
                version = transition->second.target_version;
            }
            static_cast<void>( migration );
        }
    }
    for( const auto &[hook_name, handler_ids] : value->hooks ) {
        for( const std::string &handler_id : handler_ids ) {
            if( value->handlers.count( handler_id ) == 0 ) {
                error = "Lua-first Mod '" + value->mod_id + "' native hook '" +
                        hook_name + "' references missing handler '" + handler_id + "'";
                return false;
            }
        }
    }
    for( const runtime::mapgen_registration &registration :
         value->mapgen_handlers ) {
        if( value->handlers.count( registration.handler_id ) == 0 ) {
            error = "Lua-first Mod '" + value->mod_id +
                    "' mapgen registration references missing handler '" +
                    registration.handler_id + "'";
            return false;
        }
    }
    std::set<std::string> resolved_palettes;
    std::set<std::string> resolving_palettes;
    std::function<bool( const std::string & )> validate_palette =
    [&]( const std::string & id ) {
        if( resolved_palettes.count( id ) != 0 ) {
            return true;
        }
        const auto found = value->mapgen_palettes.find( id );
        if( found == value->mapgen_palettes.end() ) {
            error = "Lua-first Mod '" + value->mod_id +
                    "' references missing mapgen palette '" + id + "'";
            return false;
        }
        if( !resolving_palettes.insert( id ).second ) {
            error = "Lua-first Mod '" + value->mod_id +
                    "' mapgen palette inheritance contains a cycle at '" + id + "'";
            return false;
        }
        for( const std::string &parent : found->second.parents ) {
            if( !validate_palette( parent ) ) {
                return false;
            }
        }
        resolving_palettes.erase( id );
        resolved_palettes.insert( id );
        return true;
    };
    for( const auto &entry : value->mapgen_palettes ) {
        if( !validate_palette( entry.first ) ) {
            return false;
        }
    }
    for( const runtime::declarative_mapgen_definition &definition :
         value->declarative_mapgens ) {
        for( const std::string &palette : definition.palettes ) {
            if( !validate_palette( palette ) ) {
                return false;
            }
        }
        if( check_engine_state && !definition.fill_terrain.empty() &&
            !ter_str_id( definition.fill_terrain ).is_valid() ) {
            error = "Lua-first Mod '" + value->mod_id + "' mapgen definition '" +
                    definition.id + "' references unknown fill terrain '" +
                    definition.fill_terrain + "'";
            return false;
        }
        if( check_engine_state ) {
            for( const std::string &terrain : definition.terrain_ids ) {
                if( !oter_str_id( terrain ).is_valid() ) {
                    error = "Lua-first Mod '" + value->mod_id +
                            "' mapgen definition '" + definition.id +
                            "' references unknown overmap terrain '" + terrain + "'";
                    return false;
                }
            }
        }
    }
    for( const auto &[topic_id, handler_id] : value->dialogue_topics ) {
        if( value->handlers.count( handler_id ) == 0 ) {
            error = "Lua-first Mod '" + value->mod_id +
                    "' dialogue topic '" + topic_id +
                    "' references missing handler '" + handler_id + "'";
            return false;
        }
    }
    if( check_engine_state && !value->native_tilesets.empty() ) {
        std::error_code filesystem_error;
        const std::filesystem::path canonical_root = std::filesystem::canonical(
                    value->mod_root, filesystem_error );
        if( filesystem_error ||
            !std::filesystem::is_directory( canonical_root, filesystem_error ) ||
            filesystem_error ) {
            error = "Lua-first Mod '" + value->mod_id +
                    "' tileset root cannot be resolved";
            return false;
        }
        for( const mod_tileset_definition &definition : value->native_tilesets ) {
            for( const mod_tileset_atlas_definition &atlas : definition.atlases ) {
                filesystem_error.clear();
                const std::filesystem::path image = std::filesystem::canonical(
                            canonical_root / std::filesystem::u8path( atlas.file ),
                            filesystem_error );
                if( filesystem_error ||
                    !platform_filesystem_path_is_within( image, canonical_root ) ||
                    !std::filesystem::is_regular_file( image, filesystem_error ) ||
                    filesystem_error ) {
                    error = "Lua-first Mod '" + value->mod_id +
                            "' tileset '" + definition.id +
                            "' image escapes its Mod root or is not a regular file: " +
                            atlas.file;
                    return false;
                }
            }
        }
    }
    return value->content.validate( *value, check_engine_state, error );
}

namespace
{

bool platform_declarative_mapgen_matches(
    const runtime::declarative_mapgen_definition &definition,
    const mapgendata &data, const bool primary )
{
    if( definition.primary != primary || data.zlevel() < definition.z_min ||
        data.zlevel() > definition.z_max ) {
        return false;
    }
    if( definition.terrain_ids.empty() ) {
        return true;
    }
    const std::string terrain_id = data.terrain_type().id().str();
    return std::binary_search( definition.terrain_ids.begin(),
                               definition.terrain_ids.end(), terrain_id );
}

std::uint64_t platform_mapgen_seed(
    const runtime &owner, const mapgendata &data,
    const std::string_view salt )
{
    std::uint64_t seed = fnv1a( owner.mod_id );
    seed = fnv1a( data.terrain_type().id().str(), seed );
    seed = fnv1a( std::to_string( data.pos().x() ), seed );
    seed = fnv1a( std::to_string( data.pos().y() ), seed );
    seed = fnv1a( std::to_string( data.pos().z() ), seed );
    seed = fnv1a( salt, seed );
    if( g != nullptr ) {
        seed ^= static_cast<std::uint64_t>( g->get_seed() );
    }
    return seed;
}

void merge_platform_mapgen_palette(
    const runtime &owner, const std::string &id,
    std::map<std::string, sol::object> &symbols,
    std::set<std::string> &active )
{
    const auto found = owner.mapgen_palettes.find( id );
    if( found == owner.mapgen_palettes.end() ) {
        throw std::runtime_error( "missing mapgen palette '" + id + "'" );
    }
    if( !active.insert( id ).second ) {
        throw std::runtime_error( "mapgen palette inheritance cycle at '" + id + "'" );
    }
    for( const std::string &parent : found->second.parents ) {
        merge_platform_mapgen_palette( owner, parent, symbols, active );
    }
    active.erase( id );
    for( const auto &entry : found->second.symbols ) {
        symbols[entry.first] = entry.second;
    }
}

sol::object select_platform_mapgen_value(
    const std::shared_ptr<cata::lua_ui::script_mapgen_context> &context,
    const sol::object &source, const std::string_view label )
{
    if( source.get_type() == sol::type::string ) {
        return source;
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( label ) +
                                     " must be a string or choices array" );
    }
    const sol::table choices = source.as<sol::table>();
    const std::size_t count = require_dense_array( choices, label, 1, 1024 );
    std::vector<std::pair<sol::object, std::int64_t>> weighted;
    weighted.reserve( count );
    std::int64_t total = 0;
    for( std::size_t index = 1; index <= count; ++index ) {
        sol::object value = choices.raw_get<sol::object>( index );
        std::int64_t weight = 1;
        if( value.get_type() == sol::type::table ) {
            const sol::table weighted_value = value.as<sol::table>();
            const sol::object raw_value = weighted_value.raw_get<sol::object>( "value" );
            const sol::object raw_weight = weighted_value.raw_get<sol::object>( "weight" );
            if( raw_value.valid() && raw_value.get_type() != sol::type::nil ) {
                validate_platform_mapgen_descriptor_keys(
                    weighted_value, { "value", "weight" }, "weighted choice" );
                value = raw_value;
                if( raw_weight.valid() && raw_weight.get_type() != sol::type::nil ) {
                    if( !raw_weight.is<lua_Integer>() ) {
                        throw std::invalid_argument(
                            std::string( label ) + " weight must be an integer" );
                    }
                    weight = raw_weight.as<std::int64_t>();
                }
            } else {
                require_dense_array( weighted_value, "mapgen weighted choice", 2, 2 );
                value = weighted_value.raw_get<sol::object>( 1 );
                const sol::object raw_tuple_weight =
                    weighted_value.raw_get<sol::object>( 2 );
                if( !raw_tuple_weight.is<lua_Integer>() ) {
                    throw std::invalid_argument(
                        std::string( label ) + " weight must be an integer" );
                }
                weight = raw_tuple_weight.as<std::int64_t>();
            }
        }
        if( value.get_type() != sol::type::string || weight <= 0 ||
            weight > 1000000 || total > 1000000000 - weight ) {
            throw std::invalid_argument( std::string( label ) +
                                         " contains an invalid weighted choice" );
        }
        total += weight;
        weighted.emplace_back( std::move( value ), weight );
    }
    std::int64_t roll = context->random_int( 1, static_cast<int>( total ) );
    for( const auto &entry : weighted ) {
        roll -= entry.second;
        if( roll <= 0 ) {
            return entry.first;
        }
    }
    throw std::runtime_error( "mapgen weighted choice failed to select a value" );
}

void invoke_platform_mapgen_callback(
    runtime &owner, sol::protected_function callback,
    const std::shared_ptr<cata::lua_ui::script_mapgen_context> &context,
    const std::optional<int> x = std::nullopt,
    const std::optional<int> y = std::nullopt,
    const std::string &glyph = {} )
{
    if( owner.callback_depth >= 16 ) {
        throw std::runtime_error( "mapgen callback recursion limit reached" );
    }
    callback_scope scope( owner );
    sol::protected_function_result result = x && y ?
            callback( context, *x, *y, glyph ) : callback( context );
    if( !result.valid() ) {
        const sol::error error = result;
        throw std::runtime_error( error.what() );
    }
}

sol::object platform_mapgen_field(
    const sol::table &descriptor, const std::string_view name )
{
    return descriptor.raw_get<sol::object>( std::string( name ) );
}

std::string platform_mapgen_string(
    const sol::table &descriptor, const std::string_view name,
    const std::string &fallback = {} )
{
    const sol::object value = platform_mapgen_field( descriptor, name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( value.get_type() != sol::type::string ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' must be a string" );
    }
    return value.as<std::string>();
}

std::int64_t platform_mapgen_integer(
    const sol::table &descriptor, const std::string_view name,
    const std::int64_t fallback, const std::int64_t minimum,
    const std::int64_t maximum )
{
    const sol::object value = platform_mapgen_field( descriptor, name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' must be an integer" );
    }
    const std::int64_t result = value.as<std::int64_t>();
    if( result < minimum || result > maximum ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' is outside its supported range" );
    }
    return result;
}

double platform_mapgen_number(
    const sol::table &descriptor, const std::string_view name,
    const double fallback, const double minimum, const double maximum )
{
    const sol::object value = platform_mapgen_field( descriptor, name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( value.get_type() != sol::type::number ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' must be a number" );
    }
    const double result = value.as<double>();
    if( !std::isfinite( result ) || result < minimum || result > maximum ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' is outside its supported range" );
    }
    return result;
}

bool platform_mapgen_boolean(
    const sol::table &descriptor, const std::string_view name,
    const bool fallback )
{
    const sol::object value = platform_mapgen_field( descriptor, name );
    if( !value.valid() || value.get_type() == sol::type::nil ) {
        return fallback;
    }
    if( value.get_type() != sol::type::boolean ) {
        throw std::invalid_argument( "mapgen symbol '" + std::string( name ) +
                                     "' must be a boolean" );
    }
    return value.as<bool>();
}

sol::table platform_mapgen_table(
    const sol::object &source, const std::string_view label )
{
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( std::string( label ) + " must be a table" );
    }
    return source.as<sol::table>();
}

void apply_platform_mapgen_computer(
    runtime &owner,
    const std::shared_ptr<cata::lua_ui::script_mapgen_context> &context,
    const sol::object &source, const int x, const int y )
{
    const sol::table descriptor = platform_mapgen_table(
                                      source, "mapgen symbol computer" );
    validate_platform_mapgen_descriptor_keys(
        descriptor,
    { "name", "security", "access_denied", "mission_target", "options",
      "failures", "eocs", "chat_topics", "on_access", "access_handler" },
        "symbol computer" );
    const std::string name = platform_mapgen_string( descriptor, "name" );
    const int security = static_cast<int>( platform_mapgen_integer(
                                              descriptor, "security", 0, -1000000, 1000000 ) );
    context->place_computer(
        x, y, name, security,
        platform_mapgen_string( descriptor, "access_denied" ),
        platform_mapgen_boolean( descriptor, "mission_target", false ) );

    const sol::object options = platform_mapgen_field( descriptor, "options" );
    if( options.valid() && options.get_type() != sol::type::nil ) {
        const sol::table values = platform_mapgen_table(
                                      options, "mapgen computer options" );
        const std::size_t count = require_dense_array(
                                      values, "mapgen computer options", 0, 256 );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::table option = platform_mapgen_table(
                                          values.raw_get<sol::object>( index ),
                                          "mapgen computer option" );
            validate_platform_mapgen_descriptor_keys(
                option, { "name", "action", "security" },
                "symbol computer option" );
            context->add_computer_option(
                x, y, platform_mapgen_string( option, "name" ),
                platform_mapgen_string( option, "action" ),
                static_cast<int>( platform_mapgen_integer(
                                      option, "security", 0, -1000000, 1000000 ) ) );
        }
    }
    for( const std::string &failure : platform_mapgen_string_array(
             platform_mapgen_field( descriptor, "failures" ),
             "mapgen computer failures", 256, true, false ) ) {
        context->add_computer_failure( x, y, failure );
    }
    for( const std::string &eoc : platform_mapgen_string_array(
             platform_mapgen_field( descriptor, "eocs" ),
             "mapgen computer eocs", 256, true, false ) ) {
        context->add_computer_eoc( x, y, eoc );
    }
    const std::string on_access = platform_mapgen_string(
                                      descriptor, "on_access" );
    const std::string access_handler = platform_mapgen_string(
                                           descriptor, "access_handler" );
    if( !on_access.empty() && !access_handler.empty() &&
        on_access != access_handler ) {
        throw std::invalid_argument(
            "mapgen computer on_access and access_handler must identify the same handler" );
    }
    const std::string &handler_id = on_access.empty() ? access_handler : on_access;
    if( !handler_id.empty() ) {
        if( owner.handlers.count( handler_id ) == 0 ) {
            throw std::invalid_argument(
                "mapgen computer references missing handler '" + handler_id + "'" );
        }
        context->set_computer_access_handler( x, y, handler_id );
    }
    for( const std::string &topic : platform_mapgen_string_array(
             platform_mapgen_field( descriptor, "chat_topics" ),
             "mapgen computer chat topics", 256, true, false ) ) {
        context->add_computer_chat_topic( x, y, topic );
    }
}

void apply_platform_mapgen_sealed_item(
    const std::shared_ptr<cata::lua_ui::script_mapgen_context> &context,
    const sol::object &source, const int x, const int y )
{
    const sol::table descriptor = platform_mapgen_table(
                                      source, "mapgen symbol sealed_item" );
    validate_platform_mapgen_descriptor_keys(
        descriptor,
    { "furniture", "item", "quantity", "charges", "item_group",
      "item_group_chance", "faction" }, "symbol sealed_item" );
    context->place_sealed_item(
        x, y, platform_mapgen_string( descriptor, "furniture" ),
        platform_mapgen_string( descriptor, "item" ),
        static_cast<int>( platform_mapgen_integer(
                              descriptor, "quantity", 1, 0, 10000 ) ),
        static_cast<int>( platform_mapgen_integer(
                              descriptor, "charges", 0, 0, 1000000000 ) ),
        platform_mapgen_string( descriptor, "item_group" ),
        static_cast<int>( platform_mapgen_integer(
                              descriptor, "item_group_chance", 100, 1, 100 ) ),
        platform_mapgen_string( descriptor, "faction" ) );
}

void apply_platform_mapgen_zone(
    const std::shared_ptr<cata::lua_ui::script_mapgen_context> &context,
    const sol::object &source, const int x, const int y )
{
    const sol::table descriptor = platform_mapgen_table(
                                      source, "mapgen symbol zone" );
    validate_platform_mapgen_descriptor_keys(
        descriptor, { "type", "faction", "name", "filter" },
        "symbol zone" );
    context->place_zone(
        x, y, x, y, platform_mapgen_string( descriptor, "type" ),
        platform_mapgen_string( descriptor, "faction" ),
        platform_mapgen_string( descriptor, "name" ),
        platform_mapgen_string( descriptor, "filter" ) );
}

void apply_platform_mapgen_symbol(
    runtime &owner,
    const std::shared_ptr<cata::lua_ui::script_mapgen_context> &context,
    const sol::object &source, const int x, const int y,
    const std::string &glyph, const std::size_t depth = 0 )
{
    if( depth >= 16 ) {
        throw std::runtime_error( "mapgen symbol descriptor nesting limit reached" );
    }
    if( source.get_type() == sol::type::string ) {
        context->set_terrain_id( x, y, source.as<std::string>() );
        return;
    }
    if( source.get_type() == sol::type::function ) {
        invoke_platform_mapgen_callback(
            owner, source.as<sol::protected_function>(), context, x, y, glyph );
        return;
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "mapgen symbol descriptor must be a string, function, or table" );
    }
    const sol::table descriptor = source.as<sol::table>();
    const sol::object first = descriptor.raw_get<sol::object>( 1 );
    if( first.valid() && first.get_type() != sol::type::nil ) {
        const std::size_t count = require_dense_array(
                                      descriptor, "mapgen symbol sequence", 1, 256 );
        for( std::size_t index = 1; index <= count; ++index ) {
            apply_platform_mapgen_symbol(
                owner, context, descriptor.raw_get<sol::object>( index ),
                x, y, glyph, depth + 1 );
        }
        return;
    }
    validate_platform_mapgen_descriptor_keys( descriptor,
    { "chance", "repeat", "one_of", "sequence", "terrain", "furniture",
      "trap", "field", "field_intensity", "field_age_turns", "field_remove",
      "item", "item_quantity", "item_charges", "item_group",
      "item_group_chance", "item_faction", "liquid", "liquid_charges",
      "toilet", "sign", "sign_furniture", "graffiti", "vending",
      "vending_reinforced", "vending_lootable", "vending_powered",
      "vending_networked", "gas_pump", "gas_pump_charges",
      "monster_group", "monster_group_chance", "monster_density",
      "monster_individual", "monster_friendly", "monster_name",
      "monster_mission_target", "monster", "monster_count", "monster_chance",
      "corpse", "corpse_group", "corpse_age_days", "rubble", "rubble_floor",
      "rubble_items", "rubble_overwrite", "computer", "sealed_item", "npc",
      "npc_unique_id", "npc_traits", "npc_mission_target", "vehicle",
      "vehicle_rotation", "vehicle_fuel",
      "vehicle_status", "vehicle_faction", "faction", "zone", "transform",
      "remove_vehicles", "remove_npcs", "remove_all", "queue_point", "nested",
      "generator", "callback" }, "symbol" );
    const std::int64_t chance = platform_mapgen_integer(
                                    descriptor, "chance", 100, 0, 100 );
    const std::int64_t repeat = platform_mapgen_integer(
                                    descriptor, "repeat", 1, 1, 64 );
    if( !context->random_chance( static_cast<std::uint64_t>( chance ), 100 ) ) {
        return;
    }
    const sol::object one_of = descriptor.raw_get<sol::object>( "one_of" );
    if( one_of.valid() && one_of.get_type() != sol::type::nil ) {
        if( one_of.get_type() != sol::type::table ) {
            throw std::invalid_argument( "mapgen symbol one_of must be an array table" );
        }
        const sol::table choices = one_of.as<sol::table>();
        const std::size_t count = require_dense_array(
                                      choices, "mapgen symbol one_of", 1, 256 );
        const int selected = context->random_int( 1, static_cast<int>( count ) );
        apply_platform_mapgen_symbol(
            owner, context, choices.raw_get<sol::object>( selected ),
            x, y, glyph, depth + 1 );
    }
    const sol::object sequence = descriptor.raw_get<sol::object>( "sequence" );
    if( sequence.valid() && sequence.get_type() != sol::type::nil ) {
        if( sequence.get_type() != sol::type::table ) {
            throw std::invalid_argument( "mapgen symbol sequence must be an array table" );
        }
        const sol::table values = sequence.as<sol::table>();
        const std::size_t count = require_dense_array(
                                      values, "mapgen symbol sequence", 0, 256 );
        for( std::size_t index = 1; index <= count; ++index ) {
            apply_platform_mapgen_symbol(
                owner, context, values.raw_get<sol::object>( index ),
                x, y, glyph, depth + 1 );
        }
    }
    for( std::int64_t iteration = 0; iteration < repeat; ++iteration ) {
        const sol::object remove_all = platform_mapgen_field( descriptor, "remove_all" );
        if( remove_all.valid() && remove_all.get_type() != sol::type::nil ) {
            if( remove_all.get_type() != sol::type::boolean ) {
                throw std::invalid_argument( "mapgen symbol remove_all must be a boolean" );
            }
            if( remove_all.as<bool>() ) {
                context->remove_all( x, y, x, y );
            }
        }
        const sol::object remove_vehicles =
            platform_mapgen_field( descriptor, "remove_vehicles" );
        if( remove_vehicles.valid() && remove_vehicles.get_type() != sol::type::nil ) {
            std::vector<std::string> prototypes;
            if( remove_vehicles.get_type() == sol::type::boolean ) {
                if( !remove_vehicles.as<bool>() ) {
                    prototypes.clear();
                } else {
                    context->remove_vehicles( x, y, x, y, prototypes );
                }
            } else {
                prototypes = platform_mapgen_string_array(
                                 remove_vehicles, "mapgen remove_vehicles", 1024, true );
                context->remove_vehicles( x, y, x, y, prototypes );
            }
        }
        const sol::object remove_npcs =
            platform_mapgen_field( descriptor, "remove_npcs" );
        if( remove_npcs.valid() && remove_npcs.get_type() != sol::type::nil ) {
            if( remove_npcs.get_type() == sol::type::boolean ) {
                if( remove_npcs.as<bool>() ) {
                    context->remove_npcs( "", "" );
                }
            } else {
                const sol::table removal = platform_mapgen_table(
                                               remove_npcs, "mapgen remove_npcs" );
                validate_platform_mapgen_descriptor_keys(
                    removal, { "template", "unique_id" }, "symbol remove_npcs" );
                context->remove_npcs(
                    platform_mapgen_string( removal, "template" ),
                    platform_mapgen_string( removal, "unique_id" ) );
            }
        }
        const sol::object terrain = descriptor.raw_get<sol::object>( "terrain" );
        if( terrain.valid() && terrain.get_type() != sol::type::nil ) {
            context->set_terrain_id( x, y,
                                     select_platform_mapgen_value(
                                         context, terrain, "mapgen terrain choices" ).as<std::string>() );
        }
        const sol::object furniture = descriptor.raw_get<sol::object>( "furniture" );
        if( furniture.valid() && furniture.get_type() != sol::type::nil ) {
            context->set_furniture_id( x, y,
                                       select_platform_mapgen_value(
                                           context, furniture,
                                           "mapgen furniture choices" ).as<std::string>() );
        }
        const sol::object trap = descriptor.raw_get<sol::object>( "trap" );
        if( trap.valid() && trap.get_type() != sol::type::nil ) {
            context->set_trap_id( x, y,
                                  select_platform_mapgen_value(
                                      context, trap, "mapgen trap choices" ).as<std::string>() );
        }
        const sol::object field = platform_mapgen_field( descriptor, "field" );
        if( field.valid() && field.get_type() != sol::type::nil ) {
            const std::string id = select_platform_mapgen_value(
                                       context, field, "mapgen field choices" ).as<std::string>();
            if( platform_mapgen_boolean( descriptor, "field_remove", false ) ) {
                context->remove_field( x, y, id );
            } else {
                context->add_field(
                    x, y, id,
                    static_cast<int>( platform_mapgen_integer(
                                          descriptor, "field_intensity", 1, 1, 100 ) ),
                    platform_mapgen_integer(
                        descriptor, "field_age_turns", 0, 0,
                        INT64_C( 1000000000000 ) ) );
            }
        }
        const std::string item_faction =
            platform_mapgen_string( descriptor, "item_faction" );
        const sol::object item = platform_mapgen_field( descriptor, "item" );
        if( item.valid() && item.get_type() != sol::type::nil ) {
            context->place_item(
                x, y, select_platform_mapgen_value(
                    context, item, "mapgen item choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "item_quantity", 1, 1, 10000 ) ),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "item_charges", 0, 0, 1000000000 ) ),
                item_faction );
        }
        const sol::object item_group =
            platform_mapgen_field( descriptor, "item_group" );
        if( item_group.valid() && item_group.get_type() != sol::type::nil ) {
            context->place_item_group(
                x, y, x, y, select_platform_mapgen_value(
                    context, item_group, "mapgen item group choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "item_group_chance", 100, 1, 100 ) ),
                item_faction );
        }
        const sol::object liquid = platform_mapgen_field( descriptor, "liquid" );
        if( liquid.valid() && liquid.get_type() != sol::type::nil ) {
            context->place_liquid(
                x, y, select_platform_mapgen_value(
                    context, liquid, "mapgen liquid choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "liquid_charges", 1, 1, 1000000000 ) ) );
        }
        const sol::object toilet = platform_mapgen_field( descriptor, "toilet" );
        if( toilet.valid() && toilet.get_type() != sol::type::nil ) {
            int charges = 0;
            if( toilet.get_type() == sol::type::boolean ) {
                if( !toilet.as<bool>() ) {
                    charges = -1;
                }
            } else if( toilet.is<lua_Integer>() ) {
                const std::int64_t raw_charges = toilet.as<std::int64_t>();
                if( raw_charges < 0 || raw_charges > 1000000000 ) {
                    throw std::invalid_argument( "mapgen toilet charges are invalid" );
                }
                charges = static_cast<int>( raw_charges );
            } else {
                throw std::invalid_argument(
                    "mapgen symbol toilet must be a boolean or integer" );
            }
            if( charges >= 0 ) {
                context->place_toilet( x, y, charges );
            }
        }
        const sol::object sign = platform_mapgen_field( descriptor, "sign" );
        if( sign.valid() && sign.get_type() != sol::type::nil ) {
            if( sign.get_type() != sol::type::string ) {
                throw std::invalid_argument( "mapgen symbol sign must be a string" );
            }
            context->place_sign(
                x, y, sign.as<std::string>(),
                platform_mapgen_string( descriptor, "sign_furniture" ) );
        }
        const sol::object graffiti = platform_mapgen_field( descriptor, "graffiti" );
        if( graffiti.valid() && graffiti.get_type() != sol::type::nil ) {
            if( graffiti.get_type() != sol::type::string ) {
                throw std::invalid_argument( "mapgen symbol graffiti must be a string" );
            }
            context->set_graffiti( x, y, graffiti.as<std::string>() );
        }
        const sol::object vending = platform_mapgen_field( descriptor, "vending" );
        if( vending.valid() && vending.get_type() != sol::type::nil ) {
            context->place_vending_machine(
                x, y, select_platform_mapgen_value(
                    context, vending, "mapgen vending choices" ).as<std::string>(),
                platform_mapgen_boolean( descriptor, "vending_reinforced", false ),
                platform_mapgen_boolean( descriptor, "vending_lootable", false ),
                platform_mapgen_boolean( descriptor, "vending_powered", false ),
                platform_mapgen_boolean( descriptor, "vending_networked", false ) );
        }
        const sol::object gas_pump = platform_mapgen_field( descriptor, "gas_pump" );
        if( gas_pump.valid() && gas_pump.get_type() != sol::type::nil ) {
            std::string fuel;
            bool place = true;
            if( gas_pump.get_type() == sol::type::boolean ) {
                place = gas_pump.as<bool>();
            } else if( gas_pump.get_type() == sol::type::string ) {
                fuel = gas_pump.as<std::string>();
            } else {
                throw std::invalid_argument(
                    "mapgen symbol gas_pump must be a boolean or fuel id string" );
            }
            if( place ) {
                context->place_gas_pump(
                    x, y, static_cast<int>( platform_mapgen_integer(
                                               descriptor, "gas_pump_charges", 10000,
                                               1, 1000000000 ) ), fuel );
            }
        }
        const sol::object monster_group =
            platform_mapgen_field( descriptor, "monster_group" );
        if( monster_group.valid() && monster_group.get_type() != sol::type::nil ) {
            context->place_monster_group(
                x, y, x, y, select_platform_mapgen_value(
                    context, monster_group,
                    "mapgen monster group choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "monster_group_chance", 1,
                                      1, 1000000 ) ),
                platform_mapgen_number(
                    descriptor, "monster_density", -1.0, -1.0, 1000000.0 ),
                platform_mapgen_boolean( descriptor, "monster_individual", false ),
                platform_mapgen_boolean( descriptor, "monster_friendly", false ),
                platform_mapgen_string( descriptor, "monster_name" ),
                platform_mapgen_boolean(
                    descriptor, "monster_mission_target", false ) );
        }
        const sol::object monster = platform_mapgen_field( descriptor, "monster" );
        if( monster.valid() && monster.get_type() != sol::type::nil &&
            context->random_chance(
                static_cast<std::uint64_t>( platform_mapgen_integer(
                                                descriptor, "monster_chance", 100, 0, 100 ) ),
                100 ) ) {
            context->place_monster(
                x, y, select_platform_mapgen_value(
                    context, monster, "mapgen monster choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "monster_count", 1, 1, 10000 ) ),
                platform_mapgen_boolean( descriptor, "monster_friendly", false ),
                platform_mapgen_string( descriptor, "monster_name" ),
                platform_mapgen_boolean(
                    descriptor, "monster_mission_target", false ) );
        }
        const int corpse_age_days = static_cast<int>( platform_mapgen_integer(
                                        descriptor, "corpse_age_days", 0, 0, 1000000 ) );
        const sol::object corpse = platform_mapgen_field( descriptor, "corpse" );
        if( corpse.valid() && corpse.get_type() != sol::type::nil ) {
            context->place_corpse(
                x, y, select_platform_mapgen_value(
                    context, corpse, "mapgen corpse choices" ).as<std::string>(),
                corpse_age_days );
        }
        const sol::object corpse_group =
            platform_mapgen_field( descriptor, "corpse_group" );
        if( corpse_group.valid() && corpse_group.get_type() != sol::type::nil ) {
            context->place_corpse_from_group(
                x, y, select_platform_mapgen_value(
                    context, corpse_group,
                    "mapgen corpse group choices" ).as<std::string>(),
                corpse_age_days );
        }
        const sol::object rubble = platform_mapgen_field( descriptor, "rubble" );
        if( rubble.valid() && rubble.get_type() != sol::type::nil ) {
            std::string rubble_id;
            bool place = true;
            if( rubble.get_type() == sol::type::boolean ) {
                place = rubble.as<bool>();
            } else if( rubble.get_type() == sol::type::string ) {
                rubble_id = rubble.as<std::string>();
            } else {
                throw std::invalid_argument(
                    "mapgen symbol rubble must be a boolean or furniture id string" );
            }
            if( place ) {
                context->make_rubble(
                    x, y, rubble_id,
                    platform_mapgen_boolean( descriptor, "rubble_items", false ),
                    platform_mapgen_string( descriptor, "rubble_floor" ),
                    platform_mapgen_boolean( descriptor, "rubble_overwrite", false ) );
            }
        }
        const sol::object computer = platform_mapgen_field( descriptor, "computer" );
        if( computer.valid() && computer.get_type() != sol::type::nil ) {
            apply_platform_mapgen_computer( owner, context, computer, x, y );
        }
        const sol::object sealed_item =
            platform_mapgen_field( descriptor, "sealed_item" );
        if( sealed_item.valid() && sealed_item.get_type() != sol::type::nil ) {
            apply_platform_mapgen_sealed_item( context, sealed_item, x, y );
        }
        const sol::object npc = platform_mapgen_field( descriptor, "npc" );
        if( npc.valid() && npc.get_type() != sol::type::nil ) {
            context->place_npc_configured(
                x, y, select_platform_mapgen_value(
                    context, npc, "mapgen npc choices" ).as<std::string>(),
                platform_mapgen_string( descriptor, "npc_unique_id" ),
                platform_mapgen_string_array(
                    platform_mapgen_field( descriptor, "npc_traits" ),
                    "mapgen npc traits", 256, true, false ),
                platform_mapgen_boolean(
                    descriptor, "npc_mission_target", false ) );
        }
        const sol::object vehicle = platform_mapgen_field( descriptor, "vehicle" );
        if( vehicle.valid() && vehicle.get_type() != sol::type::nil ) {
            context->place_vehicle(
                x, y, select_platform_mapgen_value(
                    context, vehicle, "mapgen vehicle choices" ).as<std::string>(),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "vehicle_rotation", 0,
                                      -1000000, 1000000 ) ),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "vehicle_fuel", -1, -1, 100 ) ),
                static_cast<int>( platform_mapgen_integer(
                                      descriptor, "vehicle_status", -1, -1, 2 ) ),
                platform_mapgen_string( descriptor, "vehicle_faction" ) );
        }
        const sol::object faction = platform_mapgen_field( descriptor, "faction" );
        if( faction.valid() && faction.get_type() != sol::type::nil ) {
            context->apply_faction_ownership(
                x, y, x, y, select_platform_mapgen_value(
                    context, faction, "mapgen faction choices" ).as<std::string>() );
        }
        const sol::object zone = platform_mapgen_field( descriptor, "zone" );
        if( zone.valid() && zone.get_type() != sol::type::nil ) {
            apply_platform_mapgen_zone( context, zone, x, y );
        }
        const sol::object transform = platform_mapgen_field( descriptor, "transform" );
        if( transform.valid() && transform.get_type() != sol::type::nil ) {
            context->transform(
                x, y, x, y, select_platform_mapgen_value(
                    context, transform, "mapgen transform choices" ).as<std::string>() );
        }
        const sol::object queue_point =
            platform_mapgen_field( descriptor, "queue_point" );
        if( queue_point.valid() && queue_point.get_type() != sol::type::nil ) {
            if( queue_point.get_type() != sol::type::string ) {
                throw std::invalid_argument( "mapgen symbol queue_point must be a string" );
            }
            context->queue_point( queue_point.as<std::string>(), x, y );
        }
        const sol::object nested = platform_mapgen_field( descriptor, "nested" );
        if( nested.valid() && nested.get_type() != sol::type::nil ) {
            context->nest(
                select_platform_mapgen_value(
                    context, nested, "mapgen nested choices" ).as<std::string>(),
                x, y );
        }
        const sol::object generator = platform_mapgen_field( descriptor, "generator" );
        if( generator.valid() && generator.get_type() != sol::type::nil ) {
            context->generate(
                select_platform_mapgen_value(
                    context, generator, "mapgen generator choices" ).as<std::string>() );
        }
        const sol::object callback = descriptor.raw_get<sol::object>( "callback" );
        if( callback.valid() && callback.get_type() != sol::type::nil ) {
            if( callback.get_type() != sol::type::function ) {
                throw std::invalid_argument( "mapgen symbol callback must be a function" );
            }
            invoke_platform_mapgen_callback(
                owner, callback.as<sol::protected_function>(), context, x, y, glyph );
        }
    }
}

void apply_platform_declarative_mapgen(
    const std::shared_ptr<runtime> &owner,
    const runtime::declarative_mapgen_definition &definition,
    mapgendata &data )
{
    const std::uint64_t seed = platform_mapgen_seed(
                                   *owner, data, definition.id );
    const std::shared_ptr<cata::lua_ui::script_mapgen_context> context =
        std::make_shared<cata::lua_ui::script_mapgen_context>(
            data, true, seed, owner->mod_id );
    try {
        if( definition.before_generate.valid() &&
            definition.before_generate.get_type() != sol::type::nil ) {
            invoke_platform_mapgen_callback(
                *owner, definition.before_generate.as<sol::protected_function>(), context );
        }
        if( !definition.fill_terrain.empty() ) {
            context->reset( definition.fill_terrain );
        }
        std::map<std::string, sol::object> symbols;
        std::set<std::string> active_palettes;
        for( const std::string &palette : definition.palettes ) {
            merge_platform_mapgen_palette(
                *owner, palette, symbols, active_palettes );
        }
        for( const auto &entry : definition.symbols ) {
            symbols[entry.first] = entry.second;
        }
        for( std::size_t y = 0; y < definition.rows.size(); ++y ) {
            for( std::size_t x = 0; x < definition.rows[y].size(); ++x ) {
                const std::string &glyph = definition.rows[y][x];
                const auto found = symbols.find( glyph );
                if( found == symbols.end() ) {
                    if( glyph == " " || !definition.fill_terrain.empty() ) {
                        continue;
                    }
                    throw std::runtime_error( "mapgen definition '" + definition.id +
                                              "' has no symbol mapping for '" + glyph + "'" );
                }
                apply_platform_mapgen_symbol(
                    *owner, context, found->second,
                    definition.offset_x + static_cast<int>( x ),
                    definition.offset_y + static_cast<int>( y ), glyph );
            }
        }
        if( definition.after_generate.valid() &&
            definition.after_generate.get_type() != sol::type::nil ) {
            invoke_platform_mapgen_callback(
                *owner, definition.after_generate.as<sol::protected_function>(), context );
        }
        set_queued_points();
        context->invalidate();
    } catch( ... ) {
        set_queued_points();
        context->invalidate();
        throw;
    }
}

bool dispatch_platform_mapgen_phase( mapgendata &data, const bool primary )
{
    if( platform_event_dispatch_depth >= 4 ) {
        DebugLog( D_ERROR, D_MAP_GEN ) <<
                "Lua-first Platform mapgen recursion limit reached";
        return false;
    }
    platform_event_dispatch_scope dispatch_scope;
    bool matched = false;
    const std::vector<std::shared_ptr<runtime>> runtimes = active_runtimes;
    for( const std::shared_ptr<runtime> &owner : runtimes ) {
        if( !owner || owner->lua == nullptr ) {
            continue;
        }
        for( const runtime::declarative_mapgen_definition &definition :
             owner->declarative_mapgens ) {
            if( !platform_declarative_mapgen_matches( definition, data, primary ) ) {
                continue;
            }
            matched = true;
            try {
                apply_platform_declarative_mapgen( owner, definition, data );
            } catch( const std::exception &exception ) {
                DebugLog( D_ERROR, D_MAP_GEN ) << "Lua-first Mod '" << owner->mod_id
                                               << "' mapgen definition '"
                                               << definition.id << "': "
                                               << exception.what();
            }
        }
        for( const runtime::mapgen_registration &registration :
             owner->mapgen_handlers ) {
            if( registration.primary != primary ||
                data.zlevel() < registration.z_min ||
                data.zlevel() > registration.z_max ) {
                continue;
            }
            const std::string terrain_id = data.terrain_type().id().str();
            if( !registration.terrain_ids.empty() &&
                !std::binary_search( registration.terrain_ids.begin(),
                                     registration.terrain_ids.end(), terrain_id ) ) {
                continue;
            }
            matched = true;
            const auto handler = owner->handlers.find( registration.handler_id );
            if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
                continue;
            }
            const std::uint64_t seed = platform_mapgen_seed(
                                           *owner, data, registration.handler_id );
            const std::shared_ptr<cata::lua_ui::script_mapgen_context> context =
                std::make_shared<cata::lua_ui::script_mapgen_context>(
                    data, true, seed, owner->mod_id );
            sol::table payload = owner->lua->create_table();
            payload["context"] = context;
            sol::protected_function callback = handler->second.callback;
            callback_scope scope( *owner );
            const sol::protected_function_result result = callback( payload );
            set_queued_points();
            context->invalidate();
            if( !result.valid() ) {
                report_callback_error( *owner, registration.handler_id, result );
            }
        }
    }
    return matched;
}

} // namespace

bool runtime_has_primary_mapgen_for( const std::shared_ptr<runtime> &value,
                                     const std::string_view terrain_id )
{
    if( !value ) {
        return false;
    }
    const bool declarative = std::any_of(
    value->declarative_mapgens.begin(), value->declarative_mapgens.end(),
    [terrain_id]( const runtime::declarative_mapgen_definition & definition ) {
        return definition.primary &&
               ( definition.terrain_ids.empty() ||
                 std::binary_search( definition.terrain_ids.begin(),
                                     definition.terrain_ids.end(),
                                     std::string( terrain_id ) ) );
    } );
    return declarative || std::any_of(
               value->mapgen_handlers.begin(), value->mapgen_handlers.end(),
    [terrain_id]( const runtime::mapgen_registration & registration ) {
        return registration.primary &&
               ( registration.terrain_ids.empty() ||
                 std::binary_search( registration.terrain_ids.begin(),
                                     registration.terrain_ids.end(), std::string( terrain_id ) ) );
    } );
}

namespace
{

struct declarative_platform_dialogue_topic_registration {
    std::shared_ptr<runtime> owner;
    const runtime::declarative_dialogue_topic *definition = nullptr;
};

std::optional<declarative_platform_dialogue_topic_registration>
find_declarative_platform_dialogue_topic( const std::string_view topic_id )
{
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
            continue;
        }
        const auto found = owner->declarative_dialogue_topics.find(
                               std::string( topic_id ) );
        if( found != owner->declarative_dialogue_topics.end() ) {
            return declarative_platform_dialogue_topic_registration{ owner, &found->second };
        }
    }
    return std::nullopt;
}

void report_declarative_platform_dialogue_error(
    const declarative_platform_dialogue_topic_registration &registration,
    const std::string_view topic_id, const std::string &error )
{
    DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << registration.owner->mod_id
                                << "' declarative dialogue topic '" << topic_id
                                << "': " << error;
}

std::string evaluate_declarative_platform_dialogue_line(
    const declarative_platform_dialogue_topic_registration &registration,
    dialogue &d, const talk_topic &topic )
{
    const sol::object &source = registration.definition->dynamic_line;
    if( source.get_type() == sol::type::string ) {
        const std::string line = source.as<std::string>();
        require_platform_dialogue_text( line, "dynamic_line" );
        return line;
    }
    const std::shared_ptr<platform_dialogue_context> context =
        make_platform_dialogue_context( *registration.owner, d, topic.id );
    try {
        if( registration.owner->callback_depth >= 16 ) {
            throw std::runtime_error( "dialogue callback recursion limit reached" );
        }
        const sol::protected_function callback = source.as<sol::protected_function>();
        callback_scope scope( *registration.owner );
        const sol::protected_function_result result = callback( context );
        context->invalidate();
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.get_type() != sol::type::string ) {
            throw std::invalid_argument( "dynamic_line callback must return a string" );
        }
        const std::string line = result.get<std::string>();
        require_platform_dialogue_text( line, "dynamic_line" );
        return line;
    } catch( ... ) {
        context->invalidate();
        throw;
    }
}

sol::object evaluate_declarative_platform_dialogue_responses(
    const std::shared_ptr<runtime> &owner, const sol::object &source,
    dialogue &d, const std::string &topic_id )
{
    if( source.get_type() == sol::type::table ) {
        return source;
    }
    const std::shared_ptr<platform_dialogue_context> context =
        make_platform_dialogue_context( *owner, d, topic_id );
    try {
        if( owner->callback_depth >= 16 ) {
            throw std::runtime_error( "dialogue callback recursion limit reached" );
        }
        const sol::protected_function callback = source.as<sol::protected_function>();
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( context );
        context->invalidate();
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "dialogue responses callback must return an array table" );
        }
        return result.get<sol::object>();
    } catch( ... ) {
        context->invalidate();
        throw;
    }
}

bool evaluate_platform_dialogue_boolean(
    const std::shared_ptr<runtime> &owner, dialogue &d,
    const std::string &topic_id, const sol::object &source,
    const std::string_view field )
{
    if( source.get_type() == sol::type::boolean ) {
        return source.as<bool>();
    }
    if( source.get_type() != sol::type::function ) {
        throw std::invalid_argument( "dialogue " + std::string( field ) +
                                     " must be a boolean or function" );
    }
    const std::shared_ptr<platform_dialogue_context> context =
        make_platform_dialogue_context( *owner, d, topic_id, false );
    try {
        if( owner->callback_depth >= 16 ) {
            throw std::runtime_error( "dialogue callback recursion limit reached" );
        }
        const sol::protected_function callback = source.as<sol::protected_function>();
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( context );
        context->invalidate();
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            throw std::invalid_argument( "dialogue " + std::string( field ) +
                                         " callback must return one boolean" );
        }
        return result.get<bool>();
    } catch( ... ) {
        context->invalidate();
        throw;
    }
}

dialogue_consequence platform_dialogue_consequence( const std::string &value )
{
    if( value.empty() || value == "none" ) {
        return dialogue_consequence::none;
    }
    if( value == "hostile" ) {
        return dialogue_consequence::hostile;
    }
    if( value == "helpless" ) {
        return dialogue_consequence::helpless;
    }
    if( value == "action" ) {
        return dialogue_consequence::action;
    }
    throw std::invalid_argument(
        "dialogue consequence must be none, hostile, helpless, or action" );
}

npc_opinion platform_dialogue_opinion( const sol::object &source,
                                       const std::string_view field )
{
    npc_opinion result;
    if( !source.valid() || source.get_type() == sol::type::nil ) {
        return result;
    }
    if( source.get_type() != sol::type::table ) {
        throw std::invalid_argument( "dialogue " + std::string( field ) +
                                     " must be a table" );
    }
    const sol::table values = source.as<sol::table>();
    for( const auto &entry : values ) {
        if( !entry.first.is<std::string>() || !entry.second.is<lua_Integer>() ) {
            throw std::invalid_argument( "dialogue opinion fields require integer values" );
        }
        const std::string key = entry.first.as<std::string>();
        const std::int64_t native_value = entry.second.as<std::int64_t>();
        if( !fits_native_int( native_value ) ) {
            throw std::invalid_argument(
                "dialogue opinion value is outside the native integer range" );
        }
        const int value = static_cast<int>( native_value );
        if( key == "trust" ) {
            result.trust = value;
        } else if( key == "fear" ) {
            result.fear = value;
        } else if( key == "value" ) {
            result.value = value;
        } else if( key == "anger" ) {
            result.anger = value;
        } else if( key == "owed" ) {
            result.owed = value;
        } else if( key == "sold" ) {
            result.sold = value;
        } else {
            throw std::invalid_argument( "dialogue opinion has unknown field '" + key + "'" );
        }
    }
    return result;
}

struct declarative_platform_dialogue_response {
    talk_response response;
    bool condition_exists = false;
    bool condition_result = true;
    bool switch_response = false;
    bool default_response = false;
};

declarative_platform_dialogue_response declarative_platform_dialogue_response_from_table(
    const std::shared_ptr<runtime> &owner, const std::string &topic_id,
    dialogue &d, const sol::table &descriptor )
{
    std::optional<sol::protected_function> on_select;
    declarative_platform_dialogue_response generated;
    generated.response = cata::lua_dialogue::response_from_table( descriptor, {
        "dialogue", "response descriptor", "has", true,
        []( const std::string & text, const std::string_view field ) {
            require_platform_dialogue_text( text, field );
        },
        []( const std::string & id ) {
            return valid_platform_dialogue_id( id );
        },
        [&on_select]( sol::protected_function callback ) {
            on_select = std::move( callback );
            return std::uint64_t{ 0 };
        },
        {
            "condition", "show_always", "show_condition", "show_reason",
            "failure_explanation", "failure_topic", "switch", "default",
            "false_text", "text_condition", "trial", "success_topic",
            "on_success", "on_failure", "success_consequence",
            "failure_consequence", "success_opinion", "failure_opinion",
            "success_mission_opinion", "failure_mission_opinion",
            "topic_item", "topic_reason", "success_item", "failure_item",
            "success_reason", "failure_reason", "skill", "style", "spell",
            "proficiency"
        }
    } );
    generated.response.lua_response_id.reset();

    const sol::object condition = descriptor.raw_get<sol::object>( "condition" );
    if( condition.valid() && condition.get_type() != sol::type::nil ) {
        generated.condition_exists = true;
        generated.condition_result = evaluate_platform_dialogue_boolean(
                                         owner, d, topic_id, condition, "response condition" );
    }
    bool show_anyway = descriptor.get_or( "show_always", false );
    const sol::object show_condition = descriptor.raw_get<sol::object>( "show_condition" );
    if( show_condition.valid() && show_condition.get_type() != sol::type::nil ) {
        show_anyway = show_anyway || evaluate_platform_dialogue_boolean(
                          owner, d, topic_id, show_condition, "response show_condition" );
    }
    generated.response.show_reason = descriptor.get_or(
                                         "show_reason", descriptor.get_or(
                                             "failure_explanation", std::string() ) );
    generated.response.ignore_conditionals = generated.condition_exists &&
            !generated.condition_result && show_anyway;
    if( generated.condition_exists && !generated.condition_result && !show_anyway ) {
        const std::string failure_topic = descriptor.get_or(
                                              "failure_topic", std::string() );
        const std::string explanation = descriptor.get_or(
                                            "failure_explanation", std::string() );
        if( failure_topic.empty() && explanation.empty() ) {
            generated.response.truetext = translation();
            return generated;
        }
        if( !failure_topic.empty() && !valid_platform_dialogue_id( failure_topic ) ) {
            throw std::invalid_argument( "dialogue failure_topic has an invalid id" );
        }
        if( !explanation.empty() ) {
            require_platform_dialogue_text( explanation, "failure_explanation" );
            generated.response.truetext = no_translation(
                "*" + explanation + ": " + generated.response.truetext.translated() );
        }
        generated.response.success.next_topic = talk_topic(
                    failure_topic.empty() ? "TALK_NONE" : failure_topic );
        generated.condition_exists = false;
        generated.condition_result = true;
    }

    const sol::object text_condition = descriptor.raw_get<sol::object>( "text_condition" );
    const sol::object false_text = descriptor.raw_get<sol::object>( "false_text" );
    if( text_condition.valid() && text_condition.get_type() != sol::type::nil ) {
        if( !false_text.valid() || false_text.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "dialogue text_condition requires string field false_text" );
        }
        if( !evaluate_platform_dialogue_boolean(
                owner, d, topic_id, text_condition, "response text_condition" ) ) {
            const std::string text = false_text.as<std::string>();
            require_platform_dialogue_text( text, "response false_text" );
            generated.response.truetext = no_translation( text );
        }
    } else if( false_text.valid() && false_text.get_type() != sol::type::nil ) {
        throw std::invalid_argument(
            "dialogue false_text requires text_condition" );
    }

    const sol::object trial_object = descriptor.raw_get<sol::object>( "trial" );
    if( trial_object.valid() && trial_object.get_type() != sol::type::nil ) {
        if( trial_object.get_type() != sol::type::table ) {
            throw std::invalid_argument( "dialogue trial must be a table" );
        }
        const sol::table trial = trial_object.as<sol::table>();
        validate_platform_dialogue_descriptor_keys( trial,
        { "kind", "type", "difficulty", "skill", "skill_required",
          "condition", "modifiers", "mod" }, "trial" );
        const std::string kind = trial.get_or( "kind", trial.get_or(
                                     "type", std::string( "none" ) ) );
        if( kind == "none" ) {
            generated.response.trial.type = TALK_TRIAL_NONE;
        } else if( kind == "lie" ) {
            generated.response.trial.type = TALK_TRIAL_LIE;
        } else if( kind == "persuade" ) {
            generated.response.trial.type = TALK_TRIAL_PERSUADE;
        } else if( kind == "intimidate" ) {
            generated.response.trial.type = TALK_TRIAL_INTIMIDATE;
        } else if( kind == "skill_check" ) {
            generated.response.trial.type = TALK_TRIAL_SKILL_CHECK;
        } else if( kind == "condition" ) {
            generated.response.trial.type = TALK_TRIAL_CONDITION;
        } else {
            throw std::invalid_argument( "dialogue trial has unknown kind '" + kind + "'" );
        }
        const std::int64_t difficulty = trial.get_or<std::int64_t>( "difficulty", 0 );
        if( !fits_native_int( difficulty ) ) {
            throw std::invalid_argument( "dialogue trial difficulty is outside native range" );
        }
        generated.response.trial.difficulty = static_cast<int>( difficulty );
        generated.response.trial.skill_required = trial.get_or(
                    "skill", trial.get_or( "skill_required", std::string() ) );
        if( generated.response.trial.type == TALK_TRIAL_SKILL_CHECK &&
            ( generated.response.trial.skill_required.empty() ||
              !skill_id( generated.response.trial.skill_required ).is_valid() ) ) {
            throw std::invalid_argument( "dialogue skill trial requires a valid skill" );
        }
        const sol::object trial_condition = trial.raw_get<sol::object>( "condition" );
        if( generated.response.trial.type == TALK_TRIAL_CONDITION ) {
            if( !trial_condition.valid() || trial_condition.get_type() == sol::type::nil ) {
                throw std::invalid_argument( "dialogue condition trial requires condition" );
            }
            const bool result = evaluate_platform_dialogue_boolean(
                                    owner, d, topic_id, trial_condition, "trial condition" );
            generated.response.trial.condition = [result]( const const_dialogue & ) {
                return result;
            };
        } else if( trial_condition.valid() && trial_condition.get_type() != sol::type::nil ) {
            throw std::invalid_argument(
                "dialogue trial condition is only valid for condition trials" );
        }
        sol::object modifiers = trial.raw_get<sol::object>( "modifiers" );
        if( ( !modifiers.valid() || modifiers.get_type() == sol::type::nil ) &&
            trial.raw_get<sol::object>( "mod" ).valid() ) {
            modifiers = trial.raw_get<sol::object>( "mod" );
        }
        if( modifiers.valid() && modifiers.get_type() != sol::type::nil ) {
            if( modifiers.get_type() != sol::type::table ) {
                throw std::invalid_argument( "dialogue trial modifiers must be an array table" );
            }
            const sol::table entries = modifiers.as<sol::table>();
            const std::size_t count = require_dense_array(
                                          entries, "dialogue trial modifiers", 0, 64 );
            for( std::size_t index = 1; index <= count; ++index ) {
                const sol::object raw_entry = entries.raw_get<sol::object>( index );
                if( raw_entry.get_type() != sol::type::table ) {
                    throw std::invalid_argument(
                        "dialogue trial modifiers must contain tables" );
                }
                const sol::table entry = raw_entry.as<sol::table>();
                std::string modifier;
                std::int64_t factor = 0;
                const sol::object named_modifier = entry.raw_get<sol::object>( "kind" );
                if( named_modifier.valid() && named_modifier.get_type() != sol::type::nil ) {
                    validate_platform_dialogue_descriptor_keys(
                        entry, { "kind", "factor" }, "trial modifier" );
                    if( named_modifier.get_type() != sol::type::string ) {
                        throw std::invalid_argument(
                            "dialogue trial modifier kind must be a string" );
                    }
                    modifier = named_modifier.as<std::string>();
                    const sol::object named_factor = entry.raw_get<sol::object>( "factor" );
                    if( !named_factor.is<lua_Integer>() ) {
                        throw std::invalid_argument(
                            "dialogue trial modifier factor must be an integer" );
                    }
                    factor = named_factor.as<std::int64_t>();
                } else {
                    require_dense_array( entry, "dialogue trial modifier", 2, 2 );
                    const sol::object raw_modifier = entry.raw_get<sol::object>( 1 );
                    const sol::object raw_factor = entry.raw_get<sol::object>( 2 );
                    if( raw_modifier.get_type() != sol::type::string ||
                        !raw_factor.is<lua_Integer>() ) {
                        throw std::invalid_argument(
                            "dialogue trial modifier requires a string and integer" );
                    }
                    modifier = raw_modifier.as<std::string>();
                    factor = raw_factor.as<std::int64_t>();
                }
                if( modifier.empty() || modifier.size() > 64 ||
                    modifier.find( '\0' ) != std::string::npos ||
                    !fits_native_int( factor ) ) {
                    throw std::invalid_argument(
                        "dialogue trial modifier is outside native limits" );
                }
                generated.response.trial.modifiers.emplace_back(
                    modifier, static_cast<int>( factor ) );
            }
        }
    }

    const std::string success_topic = descriptor.get_or(
                                          "success_topic", generated.response.success.next_topic.id );
    const std::string failure_topic = descriptor.get_or(
                                          "failure_topic", std::string( "TALK_NONE" ) );
    if( !valid_platform_dialogue_id( success_topic ) ||
        !valid_platform_dialogue_id( failure_topic ) ) {
        throw std::invalid_argument( "dialogue response result topic has an invalid id" );
    }
    const std::string topic_item = descriptor.get_or( "topic_item", std::string() );
    const std::string success_item = descriptor.get_or( "success_item", topic_item );
    const std::string failure_item = descriptor.get_or( "failure_item", topic_item );
    const std::string topic_reason = descriptor.get_or( "topic_reason", std::string() );
    const std::string success_reason = descriptor.get_or( "success_reason", topic_reason );
    const std::string failure_reason = descriptor.get_or( "failure_reason", topic_reason );
    const auto validate_topic_payload = []( const std::string & item_id,
    const std::string & reason, const char *phase ) {
        if( ( !item_id.empty() && !itype_id( item_id ).is_valid() ) ||
            reason.size() > 4096 || reason.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( std::string( "dialogue " ) + phase +
                                         " topic payload is invalid" );
        }
    };
    validate_topic_payload( success_item, success_reason, "success" );
    validate_topic_payload( failure_item, failure_reason, "failure" );
    generated.response.success.next_topic = talk_topic(
                success_topic, success_item.empty() ? itype_id::NULL_ID() :
                itype_id( success_item ), success_reason );
    generated.response.failure.next_topic = talk_topic(
                failure_topic, failure_item.empty() ? itype_id::NULL_ID() :
                itype_id( failure_item ), failure_reason );
    generated.response.success.opinion = platform_dialogue_opinion(
            descriptor.raw_get<sol::object>( "success_opinion" ), "success_opinion" );
    generated.response.failure.opinion = platform_dialogue_opinion(
            descriptor.raw_get<sol::object>( "failure_opinion" ), "failure_opinion" );
    generated.response.success.mission_opinion = platform_dialogue_opinion(
                descriptor.raw_get<sol::object>( "success_mission_opinion" ),
                "success_mission_opinion" );
    generated.response.failure.mission_opinion = platform_dialogue_opinion(
                descriptor.raw_get<sol::object>( "failure_mission_opinion" ),
                "failure_mission_opinion" );

    const dialogue_consequence success_consequence = platform_dialogue_consequence(
                descriptor.get_or( "success_consequence", std::string() ) );
    const dialogue_consequence failure_consequence = platform_dialogue_consequence(
                descriptor.get_or( "failure_consequence", std::string() ) );
    if( success_consequence != dialogue_consequence::none ) {
        generated.response.success.set_effect_consequence(
            talk_effect_fun_t( []( dialogue & ) {} ), success_consequence );
    }
    if( failure_consequence != dialogue_consequence::none ) {
        generated.response.failure.set_effect_consequence(
            talk_effect_fun_t( []( dialogue & ) {} ), failure_consequence );
    }

    const auto read_training_id = [&descriptor]( const char *field ) {
        return descriptor.get_or( field, std::string() );
    };
    const std::string skill = read_training_id( "skill" );
    const std::string style = read_training_id( "style" );
    const std::string spell = read_training_id( "spell" );
    const std::string proficiency = read_training_id( "proficiency" );
    if( !skill.empty() ) {
        generated.response.skill = skill_id( skill );
    }
    if( !style.empty() ) {
        generated.response.style = matype_id( style );
    }
    if( !spell.empty() ) {
        generated.response.dialogue_spell = spell_id( spell );
    }
    if( !proficiency.empty() ) {
        generated.response.proficiency = proficiency_id( proficiency );
    }

    const sol::object on_success = descriptor.raw_get<sol::object>( "on_success" );
    const sol::object on_failure = descriptor.raw_get<sol::object>( "on_failure" );
    const auto optional_callback = []( const sol::object &value,
    const char *field ) -> std::optional<sol::protected_function> {
        if( !value.valid() || value.get_type() == sol::type::nil ) {
            return std::nullopt;
        }
        if( value.get_type() != sol::type::function ) {
            throw std::invalid_argument( std::string( "dialogue " ) + field +
                                         " must be a function" );
        }
        return value.as<sol::protected_function>();
    };
    const std::optional<sol::protected_function> success_callback =
        optional_callback( on_success, "on_success" );
    const std::optional<sol::protected_function> failure_callback =
        optional_callback( on_failure, "on_failure" );
    if( on_select || success_callback || failure_callback ) {
        const std::weak_ptr<runtime> weak_owner( owner );
        generated.response.lua_response_id =
            cata::lua_dialogue::register_response_callback(
                cata::lua_dialogue::response_callback_origin::platform,
        [weak_owner, topic_id, on_select, success_callback, failure_callback](
        dialogue & active_dialogue, const talk_topic & fallback,
        const bool trial_success ) mutable {
            talk_topic result = fallback;
            const std::optional<sol::protected_function> &phase_callback =
                trial_success ? success_callback : failure_callback;
            if( phase_callback ) {
                result = invoke_platform_dialogue_response_callback(
                             weak_owner, topic_id, *phase_callback, active_dialogue,
                             result, trial_success );
            }
            if( on_select ) {
                result = invoke_platform_dialogue_response_callback(
                             weak_owner, topic_id, *on_select, active_dialogue,
                             result, trial_success );
            }
            return result;
        } );
    }
    generated.switch_response = descriptor.get_or( "switch", false );
    generated.default_response = descriptor.get_or( "default", false );
    return generated;
}

void add_declarative_platform_dialogue_response(
    dialogue &d, const std::shared_ptr<runtime> &owner,
    const std::string &topic_id, const sol::table &descriptor,
    const bool insert_before_standard_exits, const bool insert_front,
    const std::optional<itype_id> &repeat_item, bool &switch_done )
{
    declarative_platform_dialogue_response generated =
        declarative_platform_dialogue_response_from_table(
            owner, topic_id, d, descriptor );
    if( repeat_item ) {
        generated.response.success.next_topic.item_type = *repeat_item;
        generated.response.failure.next_topic.item_type = *repeat_item;
    }
    if( generated.response.truetext.empty() ||
        ( generated.switch_response && switch_done &&
          !d.debug_ignore_conditionals ) ) {
        return;
    }
    d.add_gen_response( generated.response, insert_front,
                        generated.condition_exists,
                        generated.condition_result,
                        insert_before_standard_exits );
    if( generated.switch_response && !generated.default_response &&
        generated.condition_result ) {
        switch_done = true;
    }
}

void add_declarative_platform_dialogue_responses(
    dialogue &d, const std::shared_ptr<runtime> &owner,
    const std::string &topic_id, const sol::object &responses_object,
    const bool insert_before_standard_exits, bool &switch_done )
{
    if( responses_object.get_type() != sol::type::table ) {
        throw std::invalid_argument( "dialogue responses must be an array table" );
    }
    const sol::table responses = responses_object.as<sol::table>();
    const std::size_t count = require_dense_array(
                                  responses, "dialogue responses", 0,
                                  maximum_platform_dialogue_responses_per_topic );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw_response = responses.raw_get<sol::object>( index );
        if( !raw_response.valid() || raw_response.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "dialogue responses must contain descriptor tables" );
        }
        add_declarative_platform_dialogue_response(
            d, owner, topic_id, raw_response.as<sol::table>(),
            insert_before_standard_exits, false, std::nullopt, switch_done );
    }
}

void append_platform_dialogue_repeat_ids(
    const sol::table &descriptor, const char *singular_field,
    const char *plural_field, const std::string_view label,
    std::vector<std::string> &ids )
{
    const sol::object singular = descriptor.raw_get<sol::object>( singular_field );
    if( singular.valid() && singular.get_type() != sol::type::nil ) {
        if( singular.get_type() != sol::type::string ) {
            throw std::invalid_argument( "dialogue " + std::string( label ) +
                                         " must be a string" );
        }
        ids.push_back( singular.as<std::string>() );
    }
    const sol::object plural = descriptor.raw_get<sol::object>( plural_field );
    if( !plural.valid() || plural.get_type() == sol::type::nil ) {
        return;
    }
    if( plural.get_type() != sol::type::table ) {
        throw std::invalid_argument( "dialogue " + std::string( label ) +
                                     " list must be an array table" );
    }
    const sol::table values = plural.as<sol::table>();
    const std::size_t count = require_dense_array(
                                  values, label, 0, 1024 );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = values.raw_get<sol::object>( index );
        if( value.get_type() != sol::type::string ) {
            throw std::invalid_argument( "dialogue " + std::string( label ) +
                                         " list must contain strings" );
        }
        ids.push_back( value.as<std::string>() );
    }
}

void add_declarative_platform_dialogue_repeat_responses(
    dialogue &d, const std::shared_ptr<runtime> &owner,
    const std::string &topic_id, const sol::object &source,
    const bool insert_before_standard_exits, bool &switch_done )
{
    if( !source.valid() || source.get_type() == sol::type::nil ) {
        return;
    }
    const sol::object evaluated = evaluate_declarative_platform_dialogue_responses(
                                      owner, source, d, topic_id );
    if( evaluated.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            "dialogue repeat_responses must be an array table" );
    }
    const sol::table repeat_responses = evaluated.as<sol::table>();
    const std::size_t count = require_dense_array(
                                  repeat_responses, "dialogue repeat_responses", 0,
                                  maximum_platform_dialogue_repeat_responses_per_topic );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw_repeat = repeat_responses.raw_get<sol::object>( index );
        if( raw_repeat.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "dialogue repeat_responses must contain descriptor tables" );
        }
        const sol::table repeat = raw_repeat.as<sol::table>();
        validate_platform_dialogue_descriptor_keys( repeat,
        { "actor", "include_containers", "item", "items", "category",
          "categories", "response" }, "repeat response" );
        const std::string actor_name = repeat.get_or( "actor", std::string( "alpha" ) );
        bool beta = false;
        if( actor_name == "alpha" || actor_name == "player" ) {
            beta = false;
        } else if( actor_name == "beta" || actor_name == "npc" ) {
            beta = true;
        } else {
            throw std::invalid_argument(
                "dialogue repeat response actor must be alpha or beta" );
        }
        if( !d.has_actor( beta ) ) {
            continue;
        }
        const sol::object raw_response = repeat.raw_get<sol::object>( "response" );
        if( raw_response.get_type() != sol::type::table ) {
            throw std::invalid_argument(
                "dialogue repeat response requires a response descriptor table" );
        }

        std::vector<std::string> item_ids;
        std::vector<std::string> category_ids;
        append_platform_dialogue_repeat_ids(
            repeat, "item", "items", "repeat response items", item_ids );
        append_platform_dialogue_repeat_ids(
            repeat, "category", "categories", "repeat response categories", category_ids );
        if( item_ids.empty() && category_ids.empty() ) {
            throw std::invalid_argument(
                "dialogue repeat response requires items or categories" );
        }

        const_talker *actor = d.const_actor( beta );
        std::set<itype_id> matches;
        for( const std::string &item_id_string : item_ids ) {
            const itype_id item_id( item_id_string );
            if( !item_id.is_valid() ) {
                throw std::invalid_argument(
                    "dialogue repeat response has an invalid item id" );
            }
            if( actor->charges_of( item_id ) > 0 || actor->has_amount( item_id, 1 ) ) {
                matches.insert( item_id );
            }
        }
        const bool include_containers = repeat.get_or( "include_containers", false );
        for( const std::string &category_id_string : category_ids ) {
            const item_category_id category_id( category_id_string );
            if( !category_id.is_valid() ) {
                throw std::invalid_argument(
                    "dialogue repeat response has an invalid item category id" );
            }
            const std::vector<const item *> items = actor->const_items_with(
            [category_id, include_containers]( const item & candidate ) {
                if( include_containers ) {
                    return candidate.get_category_of_contents().get_id() == category_id;
                }
                return candidate.type && candidate.type->category_force == category_id;
            } );
            for( const item *candidate : items ) {
                if( candidate != nullptr ) {
                    matches.insert( candidate->typeId() );
                }
            }
        }
        for( const itype_id &item_id : matches ) {
            add_declarative_platform_dialogue_response(
                d, owner, topic_id, raw_response.as<sol::table>(),
                insert_before_standard_exits, true, item_id, switch_done );
        }
    }
}

struct platform_dialogue_handler {
    std::shared_ptr<runtime> owner;
    std::string handler_id;
};

std::optional<platform_dialogue_handler> find_platform_dialogue_handler(
    const std::string_view topic_id )
{
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
            continue;
        }
        const auto registration = owner->dialogue_topics.find(
                                      std::string( topic_id ) );
        if( registration == owner->dialogue_topics.end() ) {
            continue;
        }
        return platform_dialogue_handler{ owner, registration->second };
    }
    return std::nullopt;
}

sol::protected_function_result invoke_platform_dialogue_handler(
    const platform_dialogue_handler &registration, dialogue &d,
    const talk_topic &topic, const std::string_view phase )
{
    runtime &owner = *registration.owner;
    const auto handler = owner.handlers.find( registration.handler_id );
    if( handler == owner.handlers.end() ) {
        throw std::runtime_error( "missing dialogue handler '" +
                                  registration.handler_id + "'" );
    }
    if( owner.callback_depth >= 16 ) {
        throw std::runtime_error( "dialogue callback recursion limit reached" );
    }
    const const_talker *alpha = d.has_alpha ?
                                  d.const_actor( false ) : nullptr;
    const const_talker *beta = d.has_beta ?
                                 d.const_actor( true ) : nullptr;
    sol::table payload = platform_callback_payload( owner, {
        { "avatar", alpha },
        { "interlocutor", beta },
        { "alpha", alpha },
        { "beta", beta },
        { "has_alpha", d.has_alpha },
        { "has_beta", d.has_beta },
        { "by_radio", d.by_radio },
        { "reason", d.reason },
        { "topic", topic.id },
        { "phase", std::string( phase ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( owner );
    return callback( payload );
}

void report_platform_dialogue_error( const platform_dialogue_handler &registration,
                                     const std::string_view topic_id,
                                     const std::string &error )
{
    DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << registration.owner->mod_id
                                << "' dialogue topic '" << topic_id << "': " << error;
}

void add_platform_dialogue_response( dialogue &d, const std::string &text,
                                     const std::string &next_topic )
{
    talk_response response;
    response.truetext = no_translation( text );
    response.truefalse_condition = []( const_dialogue const & ) {
        return true;
    };
    response.success.next_topic = talk_topic( next_topic );
    d.add_gen_response( response, false );
}

} // namespace

std::optional<std::string> platform_dialogue_dynamic_line( dialogue &d,
        const talk_topic &topic )
{
    const std::optional<declarative_platform_dialogue_topic_registration>
    declarative_registration = find_declarative_platform_dialogue_topic( topic.id );
    if( declarative_registration ) {
        try {
            return evaluate_declarative_platform_dialogue_line(
                       *declarative_registration, d, topic );
        } catch( const std::exception &exception ) {
            report_declarative_platform_dialogue_error(
                *declarative_registration, topic.id, exception.what() );
            return "&This dialogue is unavailable because its Lua handler failed.";
        }
    }
    const std::optional<platform_dialogue_handler> registration =
        find_platform_dialogue_handler( topic.id );
    if( !registration ) {
        return std::nullopt;
    }
    try {
        const sol::protected_function_result result =
            invoke_platform_dialogue_handler( *registration, d, topic, "line" );
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.get_type() != sol::type::string ) {
            throw std::runtime_error( "line phase must return a string" );
        }
        std::string line = result.get<std::string>();
        if( line.empty() || line.size() > 16384 ||
            line.find( '\0' ) != std::string::npos ) {
            throw std::runtime_error( "line must contain 1 to 16384 non-NUL bytes" );
        }
        return line;
    } catch( const std::exception &exception ) {
        report_platform_dialogue_error( *registration, topic.id, exception.what() );
        return "&This dialogue is unavailable because its Lua handler failed.";
    }
}

void apply_platform_dialogue_speaker_effects( dialogue &d,
        const talk_topic &topic )
{
    const auto apply_source = [&d, &topic](
    const std::shared_ptr<runtime> &owner, const sol::object &source,
    const std::string_view label ) {
        if( !owner || !source.valid() || source.get_type() == sol::type::nil ) {
            return;
        }
        try {
            std::vector<sol::protected_function> callbacks;
            if( source.get_type() == sol::type::function ) {
                callbacks.push_back( source.as<sol::protected_function>() );
            } else if( source.get_type() == sol::type::table ) {
                const sol::table values = source.as<sol::table>();
                const std::size_t count = require_dense_array(
                                              values, "dialogue speaker effects", 0, 256 );
                callbacks.reserve( count );
                for( std::size_t index = 1; index <= count; ++index ) {
                    const sol::object value = values.raw_get<sol::object>( index );
                    if( value.get_type() != sol::type::function ) {
                        throw std::invalid_argument(
                            "dialogue speaker effects must contain functions" );
                    }
                    callbacks.push_back( value.as<sol::protected_function>() );
                }
            } else {
                throw std::invalid_argument(
                    "dialogue speaker effects must be a function or array table" );
            }
            for( sol::protected_function &callback : callbacks ) {
                const std::shared_ptr<platform_dialogue_context> context =
                    make_platform_dialogue_context( *owner, d, topic.id, true );
                if( owner->callback_depth >= 16 ) {
                    context->invalidate();
                    throw std::runtime_error(
                        "dialogue callback recursion limit reached" );
                }
                callback_scope scope( *owner );
                const sol::protected_function_result result = callback( context );
                context->invalidate();
                if( !result.valid() ) {
                    const sol::error error = result;
                    throw std::runtime_error( error.what() );
                }
            }
        } catch( const std::exception &exception ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << owner->mod_id
                                        << "' dialogue " << label << " '"
                                        << topic.id << "': " << exception.what();
        }
    };

    const std::optional<declarative_platform_dialogue_topic_registration>
    registration = find_declarative_platform_dialogue_topic( topic.id );
    if( registration ) {
        apply_source( registration->owner,
                      registration->definition->speaker_effects, "topic" );
    }
    const std::vector<std::shared_ptr<runtime>> runtimes = active_runtimes;
    for( const std::shared_ptr<runtime> &owner : runtimes ) {
        if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
            continue;
        }
        for( const runtime::declarative_dialogue_extension &extension :
             owner->declarative_dialogue_extensions ) {
            if( extension.id == topic.id ) {
                apply_source( owner, extension.speaker_effects, "extension" );
            }
        }
    }
}

bool gen_platform_dialogue_responses( dialogue &d, const talk_topic &topic )
{
    const std::optional<declarative_platform_dialogue_topic_registration>
    declarative_registration = find_declarative_platform_dialogue_topic( topic.id );
    if( declarative_registration ) {
        try {
            const sol::object responses =
                evaluate_declarative_platform_dialogue_responses(
                    declarative_registration->owner,
                    declarative_registration->definition->responses,
                    d, topic.id );
            bool switch_done = false;
            add_declarative_platform_dialogue_responses(
                d, declarative_registration->owner, topic.id, responses,
                declarative_registration->definition->insert_before_standard_exits,
                switch_done );
            add_declarative_platform_dialogue_repeat_responses(
                d, declarative_registration->owner, topic.id,
                declarative_registration->definition->repeat_responses,
                declarative_registration->definition->insert_before_standard_exits,
                switch_done );
            return declarative_registration->definition->replace_built_in_responses;
        } catch( const std::exception &exception ) {
            report_declarative_platform_dialogue_error(
                *declarative_registration, topic.id, exception.what() );
            add_platform_dialogue_response( d, "End the conversation.", "TALK_DONE" );
            return true;
        }
    }
    const std::optional<platform_dialogue_handler> registration =
        find_platform_dialogue_handler( topic.id );
    if( !registration ) {
        return false;
    }
    try {
        const sol::protected_function_result result =
            invoke_platform_dialogue_handler( *registration, d, topic, "responses" );
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.get_type() != sol::type::table ) {
            throw std::runtime_error( "responses phase must return an array table" );
        }
        const sol::table responses = result.get<sol::table>();
        const std::size_t count = require_dense_array(
                                      responses, "dialogue responses", 1,
                                      maximum_platform_dialogue_responses_per_topic );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object entry = responses.raw_get<sol::object>( index );
            if( entry.get_type() != sol::type::table ) {
                throw std::runtime_error( "dialogue responses must contain tables" );
            }
            const sol::table descriptor = entry.as<sol::table>();
            for( const auto &field : descriptor ) {
                if( field.first.get_type() != sol::type::string ) {
                    throw std::runtime_error(
                        "dialogue response descriptor keys must be strings" );
                }
                const std::string key = field.first.as<std::string>();
                if( key != "text" && key != "topic" ) {
                    throw std::runtime_error(
                        "dialogue response descriptor has unknown field '" + key + "'" );
                }
            }
            const sol::object text_value = descriptor.raw_get<sol::object>( "text" );
            if( text_value.get_type() != sol::type::string ) {
                throw std::runtime_error(
                    "dialogue response descriptor requires string field 'text'" );
            }
            const std::string text = text_value.as<std::string>();
            const sol::object topic_value = descriptor.raw_get<sol::object>( "topic" );
            if( topic_value.valid() && topic_value.get_type() != sol::type::nil &&
                topic_value.get_type() != sol::type::string ) {
                throw std::runtime_error(
                    "dialogue response descriptor field 'topic' must be a string" );
            }
            const std::string next_topic = topic_value.valid() &&
                                           topic_value.get_type() == sol::type::string ?
                                           topic_value.as<std::string>() : "TALK_NONE";
            if( text.empty() || text.size() > 16384 ||
                text.find( '\0' ) != std::string::npos ) {
                throw std::runtime_error( "dialogue response text is invalid" );
            }
            if( next_topic.empty() || next_topic.size() > 256 ||
                next_topic.find( '\0' ) != std::string::npos ) {
                throw std::runtime_error( "dialogue response topic is invalid" );
            }
            add_platform_dialogue_response( d, text, next_topic );
        }
        return true;
    } catch( const std::exception &exception ) {
        report_platform_dialogue_error( *registration, topic.id, exception.what() );
        add_platform_dialogue_response( d, "End the conversation.", "TALK_DONE" );
        return true;
    }
}

void extend_platform_dialogue_responses( dialogue &d, const talk_topic &topic )
{
    const std::vector<std::shared_ptr<runtime>> runtimes = active_runtimes;
    for( const std::shared_ptr<runtime> &owner : runtimes ) {
        if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
            continue;
        }
        for( const runtime::declarative_dialogue_extension &extension :
             owner->declarative_dialogue_extensions ) {
            if( extension.id != topic.id ) {
                continue;
            }
            try {
                bool switch_done = false;
                if( extension.responses.valid() &&
                    extension.responses.get_type() != sol::type::nil ) {
                    const sol::object responses =
                        evaluate_declarative_platform_dialogue_responses(
                            owner, extension.responses, d, topic.id );
                    add_declarative_platform_dialogue_responses(
                        d, owner, topic.id, responses,
                        extension.insert_before_standard_exits, switch_done );
                }
                add_declarative_platform_dialogue_repeat_responses(
                    d, owner, topic.id, extension.repeat_responses,
                    extension.insert_before_standard_exits, switch_done );
            } catch( const std::exception &exception ) {
                DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << owner->mod_id
                                            << "' declarative dialogue extension '"
                                            << topic.id << "': " << exception.what();
            }
        }
    }
}

talk_topic invoke_platform_dialogue_response_callback(
    const std::weak_ptr<runtime> weak_owner, const std::string topic_id,
    sol::protected_function callback, dialogue &d, const talk_topic &fallback,
    const bool trial_success )
{
    const std::shared_ptr<runtime> owner = weak_owner.lock();
    if( !owner || !owner->world_is_ready || owner->lua == nullptr ) {
        return fallback;
    }
    const std::shared_ptr<platform_dialogue_context> context =
        make_platform_dialogue_context( *owner, d, topic_id );
    try {
        if( owner->callback_depth >= 16 ) {
            throw std::runtime_error( "dialogue callback recursion limit reached" );
        }
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback(
                    context, trial_success, fallback.id );
        context->invalidate();
        if( !result.valid() ) {
            const sol::error error = result;
            throw std::runtime_error( error.what() );
        }
        if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
            return fallback;
        }
        if( result.get_type() == sol::type::string ) {
            const std::string next_topic = result.get<std::string>();
            if( valid_platform_dialogue_id( next_topic ) ) {
                return talk_topic( next_topic );
            }
            throw std::invalid_argument(
                "dialogue on_select returned an invalid topic id" );
        }
        if( result.get_type() == sol::type::table ) {
            const sol::table table = result.get<sol::table>();
            validate_platform_dialogue_descriptor_keys(
                table, { "topic", "item", "reason" }, "callback result" );
            const sol::object raw_topic = table.raw_get<sol::object>( "topic" );
            std::string next_topic = fallback.id;
            if( raw_topic.valid() && raw_topic.get_type() != sol::type::nil ) {
                if( raw_topic.get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "dialogue on_select result topic must be a string" );
                }
                next_topic = raw_topic.as<std::string>();
            }
            if( !valid_platform_dialogue_id( next_topic ) ) {
                throw std::invalid_argument(
                    "dialogue on_select returned an invalid topic id" );
            }
            const std::string item_id = table.get_or(
                                            "item", fallback.item_type.is_null() ?
                                            std::string() : fallback.item_type.str() );
            const std::string reason = table.get_or( "reason", fallback.reason );
            if( ( !item_id.empty() && !itype_id( item_id ).is_valid() ) ||
                reason.size() > 4096 || reason.find( '\0' ) != std::string::npos ) {
                throw std::invalid_argument(
                    "dialogue on_select returned an invalid topic payload" );
            }
            return talk_topic( next_topic,
                               item_id.empty() ? itype_id::NULL_ID() : itype_id( item_id ),
                               reason );
        }
        throw std::invalid_argument(
            "dialogue callback must return nil, a string, or a topic table" );
    } catch( const std::exception &exception ) {
        context->invalidate();
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first Mod '" << owner->mod_id
                                    << "' dialogue on_select '" << topic_id
                                    << "': " << exception.what();
        return fallback;
    }
}

bool dispatch_platform_mapgen_generate( mapgendata &data )
{
    return dispatch_platform_mapgen_phase( data, true );
}

void dispatch_platform_mapgen_postprocess( mapgendata &data )
{
    static_cast<void>( dispatch_platform_mapgen_phase( data, false ) );
}

bool apply_runtime_content( const std::shared_ptr<runtime> &value, std::string &error )
{
    if( !value ) {
        error = "missing Platform runtime";
        return false;
    }
    if( !value->content.apply( error ) ) {
        return false;
    }
    try {
        const cata_path base_path(
            cata_path::root_path::unknown, value->mod_root );
        for( const mod_tileset_definition &definition : value->native_tilesets ) {
            add_native_mod_tileset(
                base_path, value->mod_id, value->generation, definition );
        }
        if( !value->native_tilesets.empty() ) {
            value->tileset_registry_generation = value->generation;
        }
    } catch( const std::exception &exception ) {
        remove_native_mod_tilesets( value->mod_id, value->generation );
        value->content.rollback();
        error = "Lua-first Mod '" + value->mod_id +
                "' could not register its native tileset: " + exception.what();
        return false;
    }
    error.clear();
    return true;
}

bool validate_finalized_runtime_content( const std::shared_ptr<runtime> &value,
        std::string &error )
{
    if( !value ) {
        error = "missing Platform runtime";
        return false;
    }
    return value->content.validate_finalized( error );
}

void rollback_runtime_content( const std::shared_ptr<runtime> &value )
{
    if( value ) {
        if( value->tileset_registry_generation ) {
            remove_native_mod_tilesets(
                value->mod_id, *value->tileset_registry_generation );
            value->tileset_registry_generation.reset();
        }
        value->content.rollback();
    }
}

void commit_runtime( const std::shared_ptr<runtime> &value )
{
    if( value ) {
        value->content.commit();
    }
}

void seal_runtime_content( const std::shared_ptr<runtime> &value )
{
    if( value ) {
        value->content.seal();
    }
}

void discard_runtime( const std::shared_ptr<runtime> &value )
{
    if( value ) {
        if( value->tileset_registry_generation ) {
            remove_native_mod_tilesets(
                value->mod_id, *value->tileset_registry_generation );
            value->tileset_registry_generation.reset();
        }
        value->content.discard();
    }
}

std::string runtime_fingerprint( const std::shared_ptr<runtime> &value )
{
    if( !value ) {
        return {};
    }
    const std::string content_fingerprint = value->content.fingerprint();
    if( value->native_tilesets.empty() ) {
        return content_fingerprint;
    }
    std::uint64_t state = fnv1a( content_fingerprint );
    const auto hash_variations = [&state](
    const std::vector<mod_tileset_sprite_variation> &variations ) {
        hash_part( state, std::to_string( variations.size() ) );
        for( const mod_tileset_sprite_variation &variation : variations ) {
            hash_part( state, std::to_string( variation.weight ) );
            hash_part( state, std::to_string( variation.sprites.size() ) );
            for( const int sprite : variation.sprites ) {
                hash_part( state, std::to_string( sprite ) );
            }
        }
    };
    std::function<void( const mod_tileset_tile_definition & )> hash_tile;
    hash_tile = [&state, &hash_variations, &hash_tile](
    const mod_tileset_tile_definition &tile ) {
        hash_part( state, std::to_string( tile.ids.size() ) );
        for( const std::string &id : tile.ids ) {
            hash_part( state, id );
        }
        hash_variations( tile.foreground );
        hash_variations( tile.background );
        hash_part( state, tile.multitile ? "multitile" : "single" );
        hash_part( state, tile.rotates ? ( *tile.rotates ? "rotates" : "fixed" ) :
                   "default_rotation" );
        hash_part( state, tile.animated ? "animated" : "static" );
        hash_part( state, std::to_string( tile.height_3d ) );
        hash_part( state, std::to_string( tile.additional_tiles.size() ) );
        for( const mod_tileset_tile_definition &subtile : tile.additional_tiles ) {
            hash_tile( subtile );
        }
    };
    hash_part( state, "native_tilesets" );
    hash_part( state, std::to_string( value->native_tilesets.size() ) );
    for( const mod_tileset_definition &definition : value->native_tilesets ) {
        hash_part( state, definition.id );
        hash_part( state, std::to_string( definition.compatibility.size() ) );
        for( const std::string &compatible : definition.compatibility ) {
            hash_part( state, compatible );
        }
        hash_part( state, std::to_string( definition.atlases.size() ) );
        for( const mod_tileset_atlas_definition &atlas : definition.atlases ) {
            hash_part( state, atlas.file );
            hash_part( state, std::to_string( atlas.sprite_width ) );
            hash_part( state, std::to_string( atlas.sprite_height ) );
            hash_part( state, std::to_string( atlas.sprite_offset_x ) );
            hash_part( state, std::to_string( atlas.sprite_offset_y ) );
            hash_part( state, std::to_string( atlas.sprite_offset_x_retracted ) );
            hash_part( state, std::to_string( atlas.sprite_offset_y_retracted ) );
            hash_part( state, std::to_string( atlas.pixelscale ) );
            hash_part( state, std::to_string( atlas.transparency_r ) );
            hash_part( state, std::to_string( atlas.transparency_g ) );
            hash_part( state, std::to_string( atlas.transparency_b ) );
            hash_part( state, std::to_string( atlas.tiles.size() ) );
            for( const mod_tileset_tile_definition &tile : atlas.tiles ) {
                hash_tile( tile );
            }
            hash_part( state, std::to_string( atlas.ascii.size() ) );
            for( const mod_tileset_ascii_definition &entry : atlas.ascii ) {
                hash_part( state, std::to_string( entry.offset ) );
                hash_part( state, std::to_string( static_cast<int>( entry.color ) ) );
                hash_part( state, entry.bold ? "bold" : "normal" );
            }
        }
        hash_part( state, std::to_string( definition.overlay_ordering.size() ) );
        for( const mod_tileset_overlay_ordering &ordering :
             definition.overlay_ordering ) {
            hash_part( state, std::to_string( ordering.ids.size() ) );
            for( const std::string &id : ordering.ids ) {
                hash_part( state, id );
            }
            hash_part( state, std::to_string( ordering.order ) );
        }
    }
    std::ostringstream result;
    result << std::hex << state;
    return result.str();
}

void set_active_runtimes( const std::vector<std::shared_ptr<runtime>> &values )
{
    cata::lua_dialogue::clear_response_callbacks(
        cata::lua_dialogue::response_callback_origin::platform );
    active_runtimes = values;
}

void hot_swap_active_runtimes(
    const std::vector<std::shared_ptr<runtime>> &values )
{
    cata::lua_dialogue::clear_response_callbacks(
        cata::lua_dialogue::response_callback_origin::platform );
    std::unordered_map<std::string, std::shared_ptr<runtime>> previous;
    std::set<std::string> previously_ready;
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( owner ) {
            previous.emplace( owner->mod_id, owner );
            if( owner->world_is_ready ) {
                previously_ready.insert( owner->mod_id );
            }
        }
    }
    for( auto owner = active_runtimes.rbegin(); owner != active_runtimes.rend(); ++owner ) {
        const std::shared_ptr<runtime> &value = *owner;
        if( value && value->world_is_ready ) {
            dispatch_lifecycle( *value, "shutdown" );
            value->world_is_ready = false;
        }
    }
    for( const std::shared_ptr<runtime> &owner : values ) {
        if( !owner ) {
            continue;
        }
        const auto found = previous.find( owner->mod_id );
        if( found == previous.end() || !found->second ) {
            continue;
        }
        runtime &old = *found->second;
        owner->character_state = std::move( old.character_state );
        owner->world_state = std::move( old.world_state );
        owner->tasks = std::move( old.tasks );
        owner->reported_task_migration_failures =
            std::move( old.reported_task_migration_failures );
        owner->next_task_id = old.next_task_id;
        owner->random_engine = std::move( old.random_engine );
        owner->world_is_ready = previously_ready.count( owner->mod_id ) != 0;
        owner->tileset_registry_generation = old.tileset_registry_generation;
        old.tileset_registry_generation.reset();
    }
    active_runtimes = values;
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        sol::table payload = owner->lua->create_table();
        payload["new_game"] = false;
        payload["reloaded"] = true;
        dispatch_lifecycle( *owner, "world_ready", payload );
    }
    runtime_process_tasks();
}

void clear_active_runtimes()
{
    cata::lua_dialogue::clear_response_callbacks(
        cata::lua_dialogue::response_callback_origin::platform );
    const bool had_active_world = !active_runtimes.empty();
    for( auto owner = active_runtimes.rbegin(); owner != active_runtimes.rend(); ++owner ) {
        const std::shared_ptr<runtime> &value = *owner;
        if( value && value->world_is_ready ) {
            dispatch_lifecycle( *value, "shutdown" );
            value->world_is_ready = false;
        }
        if( value && value->tileset_registry_generation ) {
            remove_native_mod_tilesets(
                value->mod_id, *value->tileset_registry_generation );
            value->tileset_registry_generation.reset();
        }
    }
    if( event_bridge ) {
        get_event_bus().unsubscribe( event_bridge.get() );
        event_bridge.reset();
    }
    active_runtimes.clear();
    orphan_character_records.clear();
    orphan_world_records.clear();
    if( had_active_world &&
        active_world_generation != std::numeric_limits<std::size_t>::max() ) {
        ++active_world_generation;
    }
}

bool has_runtime_hook( const std::string_view name )
{
    return std::any_of( active_runtimes.begin(), active_runtimes.end(),
    [name]( const std::shared_ptr<runtime> &owner ) {
        if( !owner || !owner->world_is_ready ) {
            return false;
        }
        const auto found = owner->hooks.find( std::string( name ) );
        return found != owner->hooks.end() && !found->second.empty();
    } );
}

cata::lua_ui::native_hook_result dispatch_runtime_hook(
    const std::string_view name,
    const cata::lua_ui::native_callback_arguments &arguments,
    const cata::lua_ui::native_hook_result &initial )
{
    cata::lua_ui::native_hook_result aggregate = initial;
    const cata::lua_ui::native_callback_arguments platform_arguments =
        platform_callback_arguments( name, arguments );
    if( cata::lua_ui::native_hook_supports_result_field( name, "allow" ) &&
        !aggregate.allowed ) {
        return aggregate;
    }
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        const auto subscription = owner->hooks.find( std::string( name ) );
        if( subscription == owner->hooks.end() ) {
            continue;
        }
        const std::vector<std::string> handler_ids = subscription->second;
        sol::object previous = sol::make_object( *owner->lua, sol::lua_nil );
        for( const std::string &handler_id : handler_ids ) {
            const auto handler = owner->handlers.find( handler_id );
            if( handler == owner->handlers.end() ) {
                continue;
            }
            if( owner->callback_depth >= 16 ) {
                DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook recursion limit reached for '"
                                            << owner->mod_id << ':' << name << "'";
                continue;
            }
            sol::table payload = platform_callback_payload( *owner, platform_arguments );
            payload["hook"] = std::string( name );
            payload["cancellable"] =
                cata::lua_ui::native_hook_supports_result_field( name, "allow" );
            sol::table shared = owner->lua->create_table();
            shared["allowed"] = aggregate.allowed;
            shared["handled"] = aggregate.handled;
            shared["text"] = aggregate.text;
            if( aggregate.result ) {
                shared["result"] = *aggregate.result;
            }
            sol::table strings = owner->lua->create_table();
            for( std::size_t index = 0; index < aggregate.results.size(); ++index ) {
                strings[index + 1] = aggregate.results[index];
            }
            shared["results"] = std::move( strings );
            payload["results"] = shared;
            payload["prev"] = previous;

            sol::protected_function callback = handler->second.callback;
            callback_scope scope( *owner );
            const sol::protected_function_result result = callback( payload );
            if( !result.valid() ) {
                report_callback_error( *owner, handler_id, result );
                continue;
            }

            bool stop = false;
            cata::lua_ui::native_hook_result candidate = aggregate;
            try {
                apply_platform_hook_table( name, shared, candidate, stop, true );
            } catch( const std::exception &exception ) {
                DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook '" << owner->mod_id
                                            << ':' << handler_id
                                            << "' mutated invalid shared results: "
                                            << exception.what();
                continue;
            }
            sol::object returned = sol::make_object( *owner->lua, sol::lua_nil );
            bool accept_candidate = true;
            if( result.return_count() > 0 ) {
                returned = result.get<sol::object>();
                if( returned.get_type() == sol::type::boolean ) {
                    if( !cata::lua_ui::native_hook_supports_result_field( name, "allow" ) ) {
                        DebugLog( D_ERROR, D_MAIN ) << "Lua-first signal hook '" << name
                                                    << "' ignored a boolean result from '"
                                                    << owner->mod_id << ':' << handler_id << "'";
                    } else {
                        const bool allowed = returned.as<bool>();
                        candidate.allowed = candidate.allowed && allowed;
                        stop = stop || !allowed;
                    }
                } else if( returned.get_type() == sol::type::string &&
                           cata::lua_ui::native_hook_supports_result_field( name, "result" ) ) {
                    const std::string replacement = returned.as<std::string>();
                    if( replacement.size() > 512 ) {
                        DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook result exceeds 512 bytes";
                        accept_candidate = false;
                    } else {
                        candidate.result = replacement;
                    }
                } else if( returned.get_type() == sol::type::table ) {
                    try {
                        apply_platform_hook_table( name, returned.as<sol::table>(),
                                                   candidate, stop, false );
                    } catch( const std::exception &exception ) {
                        DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook '" << owner->mod_id
                                                    << ':' << handler_id << "' returned invalid data: "
                                                    << exception.what();
                        accept_candidate = false;
                    }
                } else if( returned.get_type() != sol::type::nil ) {
                    DebugLog( D_ERROR, D_MAIN ) << "Lua-first native hook '" << owner->mod_id
                                                << ':' << handler_id
                                                << "' must return nil, boolean, string, or table";
                    accept_candidate = false;
                }
            }
            if( !accept_candidate ) {
                continue;
            }
            aggregate = std::move( candidate );
            previous = std::move( returned );
            if( stop ) {
                return aggregate;
            }
        }
    }
    return aggregate;
}

std::optional<int> invoke_use_handler( std::string_view mod_id,
                                       std::string_view handler_id,
                                       Character *character, item &used_item,
                                       map *, const tripoint_bub_ms &position )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( character == nullptr ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first item handler '" << mod_id << ':'
                                    << handler_id << "' was invoked without a Character";
        return std::nullopt;
    }
    if( !owner || !owner->world_is_ready ) {
        character->add_msg_if_player( "Lua-first Mod runtime is not ready." );
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() ) {
        character->add_msg_if_player( "Lua-first item handler is no longer registered." );
        return std::nullopt;
    }
    auto context = std::make_shared<use_context_data>();
    context->character = character;
    context->used_item = &used_item;
    context->position = position;
    context->handle_runtime = owner->handle_runtime();
    context->world_generation = active_world_generation;
    use_context_lease context_lease( *context );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( context );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() == 0 ) {
        return 0;
    }
    const sol::object returned = result.get<sol::object>();
    if( returned.get_type() == sol::type::nil ) {
        return std::nullopt;
    }
    if( returned.get_type() != sol::type::number || !returned.is<lua_Integer>() ) {
        ::add_msg( m_bad, "Lua-first item handler must return an integer or nil." );
        return std::nullopt;
    }
    const lua_Integer native_result = returned.as<lua_Integer>();
    if( native_result < std::numeric_limits<int>::min() ||
        native_result > std::numeric_limits<int>::max() ) {
        ::add_msg( m_bad, "Lua-first item handler result is outside the native range." );
        return std::nullopt;
    }
    return static_cast<int>( native_result );
}

std::optional<bool> invoke_shop_condition_handler(
    const std::string_view mod_id, const std::string_view owner_id,
    const std::string_view policy_kind, const std::string_view selector_kind,
    const std::string_view selector_id, const std::string_view handler_id,
    const item *candidate, const npc &shopkeeper )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first shop policy unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }

    sol::table payload = platform_callback_payload( *owner, {
        { "avatar", static_cast<const Character *>( &get_avatar() ) },
        { "shopkeeper", static_cast<const Character *>( &shopkeeper ) },
        { "item", candidate },
        { "owner_id", std::string( owner_id ) },
        { "policy_kind", std::string( policy_kind ) },
        { "selector_kind", std::string( selector_kind ) },
        { "selector_id", std::string( selector_id ) }
    } );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first shop policy '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

void invoke_overmap_terrain_handler(
    const std::string_view terrain_id, const std::string_view phase,
    const tripoint_abs_omt &old_position, const tripoint_abs_omt &new_position,
    const Character &character )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_overmap_terrain_handler( terrain_id, phase, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first overmap terrain policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["terrain_id"] = std::string( terrain_id );
        payload["phase"] = std::string( phase );
        payload["character"] = platform_creature_handle( *owner, character );
        const auto add_position = [&payload, &owner](
        const char *name, const tripoint_abs_omt & value ) {
            sol::table point = owner->lua->create_table();
            point["coordinate_space"] = "abs_omt";
            point["x"] = value.x();
            point["y"] = value.y();
            point["z"] = value.z();
            payload[name] = std::move( point );
        };
        add_position( "old_position", old_position );
        add_position( "new_position", new_position );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

namespace
{

sol::table overmap_special_handler_payload(
    runtime &owner, const std::string_view special_id,
    const std::string_view phase, const tripoint_abs_omt &position,
    const int rotation, const std::string_view city_name,
    const int city_size, const int city_population )
{
    sol::table payload = owner.lua->create_table();
    payload["special_id"] = std::string( special_id );
    payload["phase"] = std::string( phase );
    payload["rotation"] = rotation;
    payload["city_name"] = std::string( city_name );
    payload["city_size"] = city_size;
    payload["city_population"] = city_population;
    sol::table point = owner.lua->create_table();
    point["coordinate_space"] = "abs_omt";
    point["x"] = position.x();
    point["y"] = position.y();
    point["z"] = position.z();
    payload["position"] = std::move( point );
    return payload;
}

} // namespace

std::optional<bool> invoke_overmap_special_condition_handler(
    const std::string_view special_id, const tripoint_abs_omt &position,
    const int rotation, const std::string_view city_name, const int city_size,
    const int city_population )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_overmap_special_handler(
                special_id, "condition", handler_id ) ) {
            continue;
        }
        if( handler_id.empty() ) {
            return true;
        }
        if( !owner->world_is_ready ) {
            return false;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first overmap-special condition unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return false;
        }
        sol::table payload = overmap_special_handler_payload(
                                 *owner, special_id, "condition", position, rotation,
                                 city_name, city_size, city_population );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return false;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first overmap-special condition '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return exactly one boolean";
            return false;
        }
        return result.get<bool>();
    }
    return std::nullopt;
}

void invoke_overmap_special_placement_handler(
    const std::string_view special_id, const tripoint_abs_omt &position,
    const int rotation, const std::string_view city_name, const int city_size,
    const int city_population )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_overmap_special_handler(
                special_id, "placement", handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first overmap-special placement unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = overmap_special_handler_payload(
                                 *owner, special_id, "placement", position, rotation,
                                 city_name, city_size, city_population );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

void invoke_vehicle_part_activation_handler(
    const std::string_view part_id, vehicle &subject, vehicle_part &part,
    Character &character )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_vehicle_part_handler(
                part_id, "activation", handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first vehicle-part activation unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }

        const tripoint_abs_ms position = subject.pos_abs();
        sol::table payload = owner->lua->create_table();
        payload["part_id"] = std::string( part_id );
        payload["part_index"] = subject.index_of_part( &part, true );
        payload["character"] = platform_creature_handle( *owner, character );
        payload["vehicle"] = cata::lua_ui::game_handle::from_vehicle(
                                 subject, {
            "platform_vehicle_part_activation", 0,
            position.x(), position.y(), position.z(), {}
        }, owner->handle_runtime(), active_world_generation );
        sol::table mount = owner->lua->create_table();
        mount["coordinate_space"] = "vehicle_mount_ms";
        mount["x"] = part.mount.x();
        mount["y"] = part.mount.y();
        mount["z"] = 0;
        payload["mount"] = std::move( mount );

        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

std::optional<bool> invoke_computer_access_handler(
    computer &terminal, Character &character )
{
    if( !terminal.has_platform_access_handler() ) {
        return std::nullopt;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime(
                                               terminal.platform_access_mod() );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first computer runtime unavailable for '"
                                    << terminal.platform_access_mod() << ':'
                                    << terminal.platform_access_handler() << "'";
        return false;
    }
    const auto handler = owner->handlers.find(
                             terminal.platform_access_handler() );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first computer handler unavailable for '"
                                    << terminal.platform_access_mod() << ':'
                                    << terminal.platform_access_handler() << "'";
        return false;
    }

    auto context = std::make_shared<computer_access_context>();
    context->terminal = &terminal;
    context->character = &character;
    context->handle_runtime = owner->handle_runtime();
    context->world_generation = active_world_generation;
    computer_access_context_lease lease( *context );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( context );
    if( !result.valid() ) {
        report_callback_error(
            *owner, terminal.platform_access_handler(), result );
        return false;
    }
    if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
        return false;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first computer handler '"
                                    << terminal.platform_access_mod() << ':'
                                    << terminal.platform_access_handler()
                                    << "' must return nil or exactly one boolean";
        return false;
    }
    return result.get<bool>();
}

void invoke_character_start_handler(
    const std::string_view kind, const std::string_view definition_id,
    const std::string_view mod_id, const std::string_view handler_id,
    Character &character )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first " << kind
                                    << " start runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first " << kind
                                    << " start handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["kind"] = std::string( kind );
    payload["definition_id"] = std::string( definition_id );
    payload["character"] = platform_creature_handle( *owner, character );
    payload["is_avatar"] = character.is_avatar();
    if( const profession *selected = character.get_profession() ) {
        payload["profession_id"] = selected->ident().str();
    } else {
        payload["profession_id"] = sol::lua_nil;
    }
    if( const scenario *selected = get_scenario() ) {
        payload["scenario_id"] = selected->ident().str();
    } else {
        payload["scenario_id"] = sol::lua_nil;
    }
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_recipe_completion_handler(
    const std::string_view recipe_id, const std::string_view mod_id,
    const std::string_view handler_id, Character &character, const int batch )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first recipe completion runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first recipe completion handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["recipe_id"] = std::string( recipe_id );
    payload["character"] = platform_creature_handle( *owner, character );
    payload["batch"] = batch;
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

std::optional<bool> invoke_trap_trigger_handler(
    const std::string_view trap_id, const std::string_view mod_id,
    const std::string_view handler_id, const tripoint_abs_ms &position,
    Creature *creature, const item *triggering_item )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return std::nullopt;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first trap runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return false;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first trap handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return false;
    }
    sol::table payload = owner->lua->create_table();
    payload["trap_id"] = std::string( trap_id );
    sol::table point = owner->lua->create_table();
    point["coordinate_space"] = "abs_ms";
    point["x"] = position.x();
    point["y"] = position.y();
    point["z"] = position.z();
    payload["position"] = std::move( point );
    if( creature != nullptr ) {
        payload["trigger_kind"] = "creature";
        payload["creature"] = platform_creature_handle( *owner, *creature );
    } else {
        payload["creature"] = sol::lua_nil;
        payload["trigger_kind"] = triggering_item != nullptr ? "item" : "environment";
    }
    if( triggering_item != nullptr ) {
        payload["item_id"] = triggering_item->typeId().str();
    } else {
        payload["item_id"] = sol::lua_nil;
    }
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return false;
    }
    if( result.return_count() == 0 ) {
        return false;
    }
    const sol::object returned = result.get<sol::object>();
    if( returned.get_type() == sol::type::nil ) {
        return false;
    }
    if( returned.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first trap handler '" << mod_id << ':'
                                    << handler_id << "' must return nil or one boolean";
        return false;
    }
    return returned.as<bool>();
}

void invoke_plant_lifecycle_handlers(
    const std::string_view phase, Character &character, map &here,
    const tripoint_bub_ms &position, const std::string_view seed_id_value,
    const std::string_view old_stage, const std::string_view new_stage,
    const int effective_growth_turns, const int water,
    const std::map<std::string, std::string> &string_context,
    const std::map<std::string, double> &number_context )
{
    const std::string seed_id( seed_id_value );
    const std::string furniture_id = here.furn( position ).id().str();
    const tripoint_abs_ms absolute = here.get_abs( position );
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        const auto dispatch_target = [&]( const std::string_view target,
        const std::string & target_id ) {
            std::string handler_id;
            if( !owner->content.find_plant_lifecycle_handler(
                    target, target_id, phase, handler_id ) || handler_id.empty() ) {
                return;
            }
            const auto handler = owner->handlers.find( handler_id );
            if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
                DebugLog( D_ERROR, D_MAIN )
                        << "Lua-first plant lifecycle handler unavailable for '"
                        << owner->mod_id << ':' << handler_id << "'";
                return;
            }
            sol::table payload = owner->lua->create_table();
            payload["phase"] = std::string( phase );
            payload["target"] = std::string( target );
            payload["target_id"] = target_id;
            payload["seed_id"] = seed_id;
            payload["furniture_id"] = furniture_id;
            payload["old_stage"] = std::string( old_stage );
            payload["new_stage"] = std::string( new_stage );
            payload["effective_growth_turns"] = effective_growth_turns;
            payload["water"] = water;
            payload["character"] = platform_creature_handle( *owner, character );
            sol::table position_value = owner->lua->create_table();
            position_value["coordinate_space"] = "abs_ms";
            position_value["x"] = absolute.x();
            position_value["y"] = absolute.y();
            position_value["z"] = absolute.z();
            payload["position"] = std::move( position_value );
            sol::table strings = owner->lua->create_table();
            for( const auto &[key, value] : string_context ) {
                strings[key] = value;
            }
            payload["strings"] = std::move( strings );
            sol::table numbers = owner->lua->create_table();
            for( const auto &[key, value] : number_context ) {
                numbers[key] = value;
            }
            payload["numbers"] = std::move( numbers );
            sol::protected_function callback = handler->second.callback;
            callback_scope scope( *owner );
            const sol::protected_function_result result = callback( payload );
            if( !result.valid() ) {
                report_callback_error( *owner, handler_id, result );
            }
        };
        dispatch_target( "furniture", furniture_id );
        dispatch_target( "seed", seed_id );
    }
}

void invoke_martial_art_handler( const std::string_view martial_art_id,
                                 const std::string_view phase,
                                 Character &character )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_martial_art_handler(
                martial_art_id, phase, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN )
                    << "Lua-first martial-art handler unavailable for '"
                    << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["martial_art_id"] = std::string( martial_art_id );
        payload["phase"] = std::string( phase );
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

void invoke_technique_application_handler(
    const std::string_view technique_id, const std::string_view mod_id,
    const std::string_view handler_id, Character &attacker, Creature &target,
    const int repeat_index, const int repeat_count, const double total_damage,
    const std::string_view weapon_id )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first technique runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first technique handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["technique_id"] = std::string( technique_id );
    payload["attacker"] = platform_creature_handle( *owner, attacker );
    payload["target"] = platform_creature_handle( *owner, target );
    payload["repeat_index"] = repeat_index;
    payload["repeat_count"] = repeat_count;
    if( total_damage < 0 ) {
        payload["total_damage"] = sol::lua_nil;
    } else {
        payload["total_damage"] = total_damage;
    }
    if( weapon_id.empty() ) {
        payload["weapon_id"] = sol::lua_nil;
    } else {
        payload["weapon_id"] = std::string( weapon_id );
    }
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_item_consumption_handler(
    const std::string_view item_id, const std::string_view mod_id,
    const std::string_view handler_id, Character &character, item &consumed_item )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first consumption runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first consumption handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["item_id"] = std::string( item_id );
    payload["character"] = platform_creature_handle( *owner, character );
    payload["item"] = cata::lua_ui::game_handle::from_item(
                          consumed_item, {
        "platform_item_consumption", consumed_item.uid().get_value(), 0, 0, 0, {}
    }, owner->handle_runtime(), active_world_generation );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_weakpoint_effect_handler(
    const std::string_view set_id, const std::string_view weakpoint_id,
    const std::string_view mod_id, const std::string_view handler_id,
    Creature &target, const int total_damage, const weakpoint_attack &attack )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first weakpoint runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first weakpoint handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto attack_type_name = []( const weakpoint_attack::attack_type type ) {
        switch( type ) {
            case weakpoint_attack::attack_type::NONE:
                return "none";
            case weakpoint_attack::attack_type::MELEE_BASH:
                return "melee_bash";
            case weakpoint_attack::attack_type::MELEE_CUT:
                return "melee_cut";
            case weakpoint_attack::attack_type::MELEE_STAB:
                return "melee_stab";
            case weakpoint_attack::attack_type::PROJECTILE:
                return "projectile";
            case weakpoint_attack::attack_type::NUM:
                break;
        }
        return "unknown";
    };
    sol::table payload = owner->lua->create_table();
    payload["set_id"] = std::string( set_id );
    payload["weakpoint_id"] = std::string( weakpoint_id );
    payload["target"] = platform_creature_handle( *owner, target );
    if( attack.source != nullptr ) {
        payload["source"] = platform_creature_handle( *owner, *attack.source );
    } else {
        payload["source"] = sol::lua_nil;
    }
    if( attack.weapon != nullptr ) {
        payload["weapon_id"] = attack.weapon->typeId().str();
    } else {
        payload["weapon_id"] = sol::lua_nil;
    }
    payload["attack_type"] = attack_type_name( attack.type );
    payload["total_damage"] = total_damage;
    payload["is_thrown"] = attack.is_thrown;
    payload["accuracy"] = attack.accuracy;
    payload["is_critical"] = attack.is_crit;
    payload["weakpoint_skill"] = attack.wp_skill;
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

std::optional<bool> invoke_behavior_condition_handler(
    const std::string_view mod_id, const std::string_view behavior_id,
    const std::string_view handler_id, const Creature *subject,
    const std::string_view argument )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior condition unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }

    sol::table payload = owner->lua->create_table();
    payload["behavior_id"] = std::string( behavior_id );
    payload["argument"] = std::string( argument );
    if( subject == nullptr ) {
        payload["subject_kind"] = "none";
        payload["subject"] = sol::lua_nil;
    } else {
        payload["subject_kind"] = subject->is_avatar() ? "avatar" :
                                  subject->is_npc() ? "npc" :
                                  subject->is_monster() ? "monster" : "creature";
        payload["subject"] = platform_creature_handle( *owner, *subject );
    }

    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior condition '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

std::optional<double> invoke_behavior_score_handler(
    const std::string_view mod_id, const std::string_view behavior_id,
    const std::string_view handler_id, const Creature *subject,
    const std::string_view argument )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior score unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }

    sol::table payload = owner->lua->create_table();
    payload["behavior_id"] = std::string( behavior_id );
    payload["argument"] = std::string( argument );
    if( subject == nullptr ) {
        payload["subject_kind"] = "none";
        payload["subject"] = sol::lua_nil;
    } else {
        payload["subject_kind"] = subject->is_avatar() ? "avatar" :
                                  subject->is_npc() ? "npc" :
                                  subject->is_monster() ? "monster" : "creature";
        payload["subject"] = platform_creature_handle( *owner, *subject );
    }

    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::number ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior score '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one finite number";
        return std::nullopt;
    }
    const double value = result.get<double>();
    if( !std::isfinite( value ) ||
        std::abs( value ) > std::numeric_limits<float>::max() ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first behavior score '"
                                    << mod_id << ':' << handler_id
                                    << "' returned a value outside the native float range";
        return std::nullopt;
    }
    return value;
}

std::optional<bool> invoke_monster_attack_handler(
    const std::string_view mod_id, const std::string_view attack_id,
    const std::string_view handler_id, Creature &attacker )
{
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        return std::nullopt;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster attack unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return std::nullopt;
    }

    sol::table payload = owner->lua->create_table();
    payload["attack_id"] = std::string( attack_id );
    payload["attacker"] = platform_creature_handle( *owner, attacker );
    Creature *target = nullptr;
    if( monster *attacking_monster = attacker.as_monster() ) {
        target = attacking_monster->attack_target();
    }
    payload["target"] = target == nullptr ?
                        sol::make_object( *owner->lua, sol::lua_nil ) :
                        sol::make_object( *owner->lua,
                                          platform_creature_handle( *owner, *target ) );

    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return std::nullopt;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster attack '"
                                    << mod_id << ':' << handler_id
                                    << "' must return exactly one boolean";
        return std::nullopt;
    }
    return result.get<bool>();
}

void invoke_monster_attack_result_handler(
    const std::string_view monster_type_id, const std::string_view attack_id,
    const std::string_view mod_id, const std::string_view handler_id,
    Creature &attacker, Creature *target, const int total_damage )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster attack result runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster attack result handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["monster_type_id"] = std::string( monster_type_id );
    payload["attack_id"] = std::string( attack_id );
    payload["attacker"] = platform_creature_handle( *owner, attacker );
    payload["target"] = target == nullptr ?
                        sol::make_object( *owner->lua, sol::lua_nil ) :
                        sol::make_object( *owner->lua,
                                          platform_creature_handle( *owner, *target ) );
    payload["total_damage"] = total_damage;
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_monster_death_handler(
    const std::string_view monster_type_id, const std::string_view mod_id,
    const std::string_view handler_id, Creature &monster, Creature *killer,
    const tripoint_abs_ms &position )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster death runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first monster death handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    sol::table payload = owner->lua->create_table();
    payload["monster_type_id"] = std::string( monster_type_id );
    payload["monster"] = platform_creature_handle( *owner, monster );
    payload["killer"] = killer == nullptr ?
                        sol::make_object( *owner->lua, sol::lua_nil ) :
                        sol::make_object( *owner->lua,
                                          platform_creature_handle( *owner, *killer ) );
    sol::table point = owner->lua->create_table();
    point["coordinate_space"] = "abs_ms";
    point["x"] = position.x();
    point["y"] = position.y();
    point["z"] = position.z();
    payload["position"] = std::move( point );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

std::optional<bool> invoke_npc_death_handler(
    const std::string_view npc_template_id, const std::string_view mod_id,
    const std::string_view handler_id, npc &subject, Creature *killer,
    const tripoint_abs_ms &position )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return std::nullopt;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first NPC death runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return false;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first NPC death handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return false;
    }
    sol::table payload = owner->lua->create_table();
    payload["npc_template_id"] = std::string( npc_template_id );
    payload["npc"] = platform_creature_handle( *owner, subject );
    payload["killer"] = killer == nullptr ?
                        sol::make_object( *owner->lua, sol::lua_nil ) :
                        sol::make_object( *owner->lua,
                                          platform_creature_handle( *owner, *killer ) );
    sol::table point = owner->lua->create_table();
    point["coordinate_space"] = "abs_ms";
    point["x"] = position.x();
    point["y"] = position.y();
    point["z"] = position.z();
    payload["position"] = std::move( point );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
        return false;
    }
    if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
        return true;
    }
    if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first NPC death handler '"
                                    << mod_id << ':' << handler_id
                                    << "' must return a boolean or nil";
        return false;
    }
    return result.get<bool>();
}

void invoke_examine_handler(
    const std::string_view target_kind, const std::string_view target_id,
    const std::string_view mod_id, const std::string_view handler_id,
    Character &character, const tripoint_bub_ms &position )
{
    if( mod_id.empty() || handler_id.empty() ) {
        return;
    }
    const std::shared_ptr<runtime> owner = find_active_runtime( mod_id );
    if( !owner || !owner->world_is_ready ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first examine runtime unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    const auto handler = owner->handlers.find( std::string( handler_id ) );
    if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first examine handler unavailable for '"
                                    << mod_id << ':' << handler_id << "'";
        return;
    }
    map &here = get_map();
    const tripoint_abs_ms absolute = here.get_abs( position );
    sol::table payload = owner->lua->create_table();
    payload["target_kind"] = std::string( target_kind );
    payload["target_id"] = std::string( target_id );
    payload["terrain_id"] = here.ter( position ).id().str();
    payload["furniture_id"] = here.furn( position ).id().str();
    payload["character"] = platform_creature_handle( *owner, character );
    sol::table point = owner->lua->create_table();
    point["coordinate_space"] = "abs_ms";
    point["x"] = absolute.x();
    point["y"] = absolute.y();
    point["z"] = absolute.z();
    payload["position"] = std::move( point );
    sol::protected_function callback = handler->second.callback;
    callback_scope scope( *owner );
    const sol::protected_function_result result = callback( payload );
    if( !result.valid() ) {
        report_callback_error( *owner, handler_id, result );
    }
}

void invoke_damage_type_handler( const std::string_view damage_id,
                                 const std::string_view phase,
                                 Creature *source, Creature *target,
                                 const std::string_view body_part,
                                 const double total_damage,
                                 const double damage_taken )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_damage_handler( damage_id, phase, handler_id ) ) {
            continue;
        }
        // A later replacement owns the definition even when it deliberately
        // omits this callback, so an earlier layer must not leak through.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first damage handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' is no longer registered";
            return;
        }
        if( owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first damage handler recursion limit reached for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["damage_type_id"] = std::string( damage_id );
        payload["phase"] = std::string( phase );
        payload["body_part"] = std::string( body_part );
        payload["total_damage"] = total_damage;
        payload["damage_taken"] = damage_taken;
        payload["source"] = source ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *source ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        payload["target"] = target ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *target ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

void invoke_ammo_effect_handler( const std::string_view ammo_effect_id,
                                 Creature *source, Creature *target,
                                 const tripoint_bub_ms &position,
                                 const int dealt_damage )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_ammo_effect_handler( ammo_effect_id, handler_id ) ) {
            continue;
        }
        // The most recent replacement owns the effect even if it deliberately
        // has no Lua impact policy.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first ammo-effect handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' is no longer registered";
            return;
        }
        if( owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first ammo-effect handler recursion limit reached for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["ammo_effect_id"] = std::string( ammo_effect_id );
        payload["dealt_damage"] = dealt_damage;
        payload["source"] = source ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *source ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        payload["target"] = target ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *target ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        sol::table point = owner->lua->create_table();
        point["coordinate_space"] = "bub_ms";
        point["x"] = position.x();
        point["y"] = position.y();
        point["z"] = position.z();
        payload["position"] = std::move( point );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

std::optional<bool> invoke_addiction_type_handler(
    const std::string_view addiction_type_id, Character &character,
    const int intensity, const std::int64_t sated_turns )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_addiction_type_handler( addiction_type_id, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return false;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first addiction policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return false;
        }
        sol::table payload = owner->lua->create_table();
        payload["addiction_type_id"] = std::string( addiction_type_id );
        payload["intensity"] = intensity;
        payload["sated_turns"] = sated_turns;
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return false;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first addiction policy '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one boolean";
            return false;
        }
        return result.get<bool>();
    }
    return std::nullopt;
}

std::optional<double> invoke_character_modifier_handler(
    const std::string_view modifier_id, const Character &character,
    const std::string_view skill_id_value )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_character_modifier_handler( modifier_id, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return 0.0;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first character-modifier evaluator unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return 0.0;
        }
        sol::table payload = owner->lua->create_table();
        payload["modifier_id"] = std::string( modifier_id );
        payload["skill_id"] = std::string( skill_id_value );
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return 0.0;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::number ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first character-modifier evaluator '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one finite number";
            return 0.0;
        }
        const double value = result.get<double>();
        if( !std::isfinite( value ) ||
            std::abs( value ) > std::numeric_limits<float>::max() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first character-modifier evaluator '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' returned a value outside the native float range";
            return 0.0;
        }
        return value;
    }
    return std::nullopt;
}

std::optional<bool> invoke_weather_type_handler(
    const std::string_view weather_type_id_value, const w_point &sample )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_weather_type_handler(
                weather_type_id_value, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return false;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first weather condition unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return false;
        }
        sol::table payload = owner->lua->create_table();
        payload["weather_type_id"] = std::string( weather_type_id_value );
        payload["temperature_kelvin"] = units::to_kelvin( sample.temperature );
        payload["humidity"] = sample.humidity;
        payload["pressure"] = sample.pressure;
        payload["windpower"] = sample.windpower;
        payload["wind_description"] = sample.wind_desc;
        payload["wind_direction"] = sample.winddirection;
        payload["turn"] = to_turn<std::int64_t>( sample.time.t );
        sol::table location = owner->lua->create_table();
        location["coordinate_space"] = "abs_ms";
        location["x"] = sample.location.x();
        location["y"] = sample.location.y();
        location["z"] = sample.location.z();
        payload["location"] = std::move( location );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return false;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first weather condition '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one boolean";
            return false;
        }
        return result.get<bool>();
    }
    return std::nullopt;
}

std::optional<bool> invoke_end_screen_handler(
    const std::string_view end_screen_id_value, const Character &character )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_end_screen_handler(
                end_screen_id_value, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return false;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first end-screen policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return false;
        }
        sol::table payload = owner->lua->create_table();
        payload["end_screen_id"] = std::string( end_screen_id_value );
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return false;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::boolean ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first end-screen policy '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one boolean";
            return false;
        }
        return result.get<bool>();
    }
    return std::nullopt;
}

bool invoke_activity_type_handler(
    const std::string_view activity_type_id_value, const std::string_view phase,
    player_activity &activity, Character &character )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_activity_type_handler(
                activity_type_id_value, phase, handler_id ) ) {
            continue;
        }
        // The newest Lua-first definition owns both policy slots.  An omitted
        // slot intentionally suppresses the legacy EOC rather than exposing a
        // callback from an older replacement layer.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return true;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first activity policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return true;
        }

        sol::table payload = owner->lua->create_table();
        payload["activity_type_id"] = std::string( activity_type_id_value );
        payload["phase"] = std::string( phase );
        payload["character"] = platform_creature_handle( *owner, character );
        payload["moves_total"] = activity.moves_total;
        payload["moves_left"] = activity.moves_left;
        payload["index"] = activity.index;
        payload["position"] = activity.position;
        payload["name"] = activity.name;

        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return true;
        }
        if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
            return true;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::table ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first activity policy '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return nil or one result table";
            return true;
        }

        try {
            const sol::table returned = result.get<sol::table>();
            const auto integer_field = [&returned]( const std::string & field,
            const int fallback ) {
                const sol::optional<sol::object> candidate =
                    returned.get<sol::optional<sol::object>>( field );
                if( !candidate ) {
                    return fallback;
                }
                if( candidate->get_type() != sol::type::number ||
                    !candidate->is<lua_Integer>() ) {
                    throw std::invalid_argument( "activity result field '" + field +
                                                 "' must be an integer" );
                }
                const lua_Integer value = candidate->as<lua_Integer>();
                if( value < std::numeric_limits<int>::min() ||
                    value > std::numeric_limits<int>::max() ) {
                    throw std::invalid_argument( "activity result field '" + field +
                                                 "' is outside the native integer range" );
                }
                return static_cast<int>( value );
            };

            const int moves_total = integer_field( "moves_total", activity.moves_total );
            const int moves_left = integer_field( "moves_left", activity.moves_left );
            const int index = integer_field( "index", activity.index );
            const int position = integer_field( "position", activity.position );
            if( moves_total < 0 ) {
                throw std::invalid_argument(
                    "activity result field 'moves_total' cannot be negative" );
            }

            bool cancel = false;
            if( const sol::optional<sol::object> candidate =
                    returned.get<sol::optional<sol::object>>( "cancel" ) ) {
                if( candidate->get_type() != sol::type::boolean ) {
                    throw std::invalid_argument(
                        "activity result field 'cancel' must be a boolean" );
                }
                cancel = candidate->as<bool>();
            }

            std::string name = activity.name;
            if( const sol::optional<sol::object> candidate =
                    returned.get<sol::optional<sol::object>>( "name" ) ) {
                if( candidate->get_type() != sol::type::string ) {
                    throw std::invalid_argument(
                        "activity result field 'name' must be a string" );
                }
                name = candidate->as<std::string>();
                if( name.size() > 1024 || name.find( '\0' ) != std::string::npos ) {
                    throw std::invalid_argument(
                        "activity result field 'name' exceeds its native bound" );
                }
            }

            activity.moves_total = moves_total;
            activity.moves_left = moves_left;
            activity.index = index;
            activity.position = position;
            activity.name = std::move( name );
            if( cancel ) {
                activity.set_to_null();
            }
        } catch( const std::exception &exception ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first activity policy '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' returned invalid data: " << exception.what();
        }
        return true;
    }
    return false;
}

bool invoke_snippet_examine_handler( const std::string_view snippet_id_value,
                                     const std::string_view item_type_id,
                                     Character &character )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string category_id;
        std::string handler_id;
        if( !owner->content.find_snippet_handler(
                snippet_id_value, category_id, handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return true;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first snippet examine policy unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return true;
        }
        sol::table payload = owner->lua->create_table();
        payload["snippet_id"] = std::string( snippet_id_value );
        payload["category_id"] = category_id;
        payload["item_type_id"] = std::string( item_type_id );
        payload["character"] = platform_creature_handle( *owner, character );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return true;
    }
    return false;
}

std::optional<double> invoke_magic_type_number_handler(
    const std::string_view magic_type_id, const std::string_view phase,
    const std::string_view spell_id, const Creature *caster, const double input )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_magic_type_handler( magic_type_id, phase, handler_id ) ) {
            continue;
        }
        // A later replacement owns the policy even if it intentionally uses
        // the engine default for this phase.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return std::nullopt;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' is no longer registered";
            return std::nullopt;
        }
        if( owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler recursion limit reached for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return std::nullopt;
        }
        sol::table payload = owner->lua->create_table();
        payload["magic_type_id"] = std::string( magic_type_id );
        payload["spell_id"] = std::string( spell_id );
        payload["phase"] = std::string( phase );
        payload["input"] = input;
        if( phase == "level_for_experience" ) {
            payload["experience"] = input;
        } else if( phase == "experience_for_level" ) {
            payload["level"] = input;
        }
        payload["caster"] = caster ?
                            sol::make_object( *owner->lua,
                                              platform_creature_handle( *owner, *caster ) ) :
                            sol::make_object( *owner->lua, sol::lua_nil );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return std::nullopt;
        }
        if( result.return_count() != 1 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one finite number";
            return std::nullopt;
        }
        const sol::object returned = result.get<sol::object>();
        if( returned.get_type() != sol::type::number ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return one finite number";
            return std::nullopt;
        }
        const double value = returned.as<double>();
        const bool integral_domain = phase == "level_for_experience" ||
                                     phase == "experience_for_level" ||
                                     phase == "casting_experience";
        const bool fraction_domain = phase == "failure_chance";
        if( !std::isfinite( value ) || value < 0.0 ||
            ( integral_domain && value > std::numeric_limits<int>::max() ) ||
            ( fraction_domain && value > 1.0 ) ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' returned a value outside the " << phase << " domain";
            return std::nullopt;
        }
        return value;
    }
    return std::nullopt;
}

void invoke_magic_type_failure_handler( const std::string_view magic_type_id,
                                        const std::string_view spell_id,
                                        Character &caster )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_magic_type_handler(
                magic_type_id, "on_failure", handler_id ) ) {
            continue;
        }
        if( handler_id.empty() || !owner->world_is_ready ) {
            return;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type failure handler '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' is no longer registered";
            return;
        }
        if( owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first magic-type failure handler recursion limit reached for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return;
        }
        sol::table payload = owner->lua->create_table();
        payload["magic_type_id"] = std::string( magic_type_id );
        payload["spell_id"] = std::string( spell_id );
        payload["caster"] = platform_creature_handle( *owner, caster );
        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
        }
        return;
    }
}

std::optional<emission_profile> invoke_emission_profile_handler(
    const std::string_view emission_id, const tripoint_bub_ms &position,
    const emission_profile &fallback )
{
    for( auto iterator = active_runtimes.rbegin(); iterator != active_runtimes.rend(); ++iterator ) {
        const std::shared_ptr<runtime> &owner = *iterator;
        if( !owner ) {
            continue;
        }
        std::string handler_id;
        if( !owner->content.find_emission_handler( emission_id, handler_id ) ) {
            continue;
        }
        // A later static replacement owns the emission even when it omits a
        // dynamic profile, so an older replacement's callback must not leak.
        if( handler_id.empty() || !owner->world_is_ready ) {
            return std::nullopt;
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() || owner->callback_depth >= 16 ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first emission profile unavailable for '"
                                        << owner->mod_id << ':' << handler_id << "'";
            return std::nullopt;
        }

        sol::table payload = owner->lua->create_table();
        payload["emission_id"] = std::string( emission_id );
        sol::table point = owner->lua->create_table();
        point["coordinate_space"] = "bub_ms";
        point["x"] = position.x();
        point["y"] = position.y();
        point["z"] = position.z();
        payload["position"] = std::move( point );
        sol::table fallback_value = owner->lua->create_table();
        fallback_value["field"] = fallback.field;
        fallback_value["intensity"] = fallback.intensity;
        fallback_value["quantity"] = fallback.quantity;
        fallback_value["chance"] = fallback.chance;
        payload["fallback"] = std::move( fallback_value );

        sol::protected_function callback = handler->second.callback;
        callback_scope scope( *owner );
        const sol::protected_function_result result = callback( payload );
        if( !result.valid() ) {
            report_callback_error( *owner, handler_id, result );
            return std::nullopt;
        }
        if( result.return_count() == 0 || result.get_type() == sol::type::nil ) {
            return std::nullopt;
        }
        if( result.return_count() != 1 || result.get_type() != sol::type::table ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first emission profile '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' must return nil or one complete profile table";
            return std::nullopt;
        }

        try {
            const sol::table returned = result.get<sol::table>();
            const sol::object field_value = returned.raw_get<sol::object>( "field" );
            if( field_value.get_type() != sol::type::string ) {
                throw std::invalid_argument( "field must be a string" );
            }
            emission_profile profile;
            profile.field = field_value.as<std::string>();
            const auto integer_field = [&returned]( const char *name ) {
                const sol::object candidate = returned.raw_get<sol::object>( name );
                if( candidate.get_type() != sol::type::number ||
                    !candidate.is<lua_Integer>() ) {
                    throw std::invalid_argument( std::string( name ) + " must be an integer" );
                }
                const lua_Integer value = candidate.as<lua_Integer>();
                if( value < std::numeric_limits<int>::min() ||
                    value > std::numeric_limits<int>::max() ) {
                    throw std::invalid_argument( std::string( name ) +
                                                 " is outside the native integer range" );
                }
                return static_cast<int>( value );
            };
            profile.intensity = integer_field( "intensity" );
            profile.quantity = integer_field( "quantity" );
            profile.chance = integer_field( "chance" );

            const field_type_str_id field( profile.field );
            if( profile.field.empty() || profile.field == "fd_null" ||
                profile.field.find( '\0' ) != std::string::npos || !field.is_valid() ||
                profile.intensity <= 0 ||
                profile.intensity > field->get_max_intensity() ||
                profile.quantity < 0 || profile.chance < 0 || profile.chance > 100 ) {
                throw std::invalid_argument( "field profile is outside native bounds" );
            }
            return profile;
        } catch( const std::exception &exception ) {
            DebugLog( D_ERROR, D_MAIN ) << "Lua-first emission profile '"
                                        << owner->mod_id << ':' << handler_id
                                        << "' returned invalid data: " << exception.what();
            return std::nullopt;
        }
    }
    return std::nullopt;
}

void runtime_world_ready( bool new_game )
{
    if( active_runtimes.empty() ) {
        return;
    }
    if( active_world_generation != std::numeric_limits<std::size_t>::max() ) {
        ++active_world_generation;
    }
    std::string character_error;
    load_scope( character_state_path(), "character", character_error );
    std::string world_error;
    if( const std::optional<cata_path> path = world_state_path() ) {
        load_scope( *path, "world", world_error );
    }
    if( !event_bridge ) {
        event_bridge = std::make_unique<platform_event_bridge>();
        get_event_bus().subscribe( event_bridge.get() );
    }
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( owner ) {
            owner->world_is_ready = true;
        }
    }
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( !owner ) {
            continue;
        }
        sol::table payload = owner->lua->create_table();
        payload["new_game"] = new_game;
        dispatch_lifecycle( *owner, "world_ready", payload );
    }
    if( !character_error.empty() ) {
        ::add_msg( m_warning, "Lua-first character state was not loaded: " + character_error );
    }
    if( !world_error.empty() ) {
        ::add_msg( m_warning, "Lua-first world state was not loaded: " + world_error );
    }
    runtime_process_tasks();
}

void runtime_before_save()
{
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( owner && owner->world_is_ready ) {
            dispatch_lifecycle( *owner, "before_save" );
        }
    }
}

bool runtime_save( std::string &error )
{
    if( active_runtimes.empty() ) {
        error.clear();
        return true;
    }
    try {
        write_scope( character_state_path(), "character" );
        if( const std::optional<cata_path> path = world_state_path() ) {
            write_scope( *path, "world" );
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = exception.what();
        return false;
    }
}

void runtime_after_save( bool success, std::string_view error )
{
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        sol::table payload = owner->lua->create_table();
        payload["success"] = success;
        payload["error"] = std::string( error );
        dispatch_lifecycle( *owner, "after_save", payload );
    }
}

void runtime_process_character_recurring( Character &character )
{
    const std::int64_t now = to_turn<std::int64_t>( calendar::turn );
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        for( const runtime::character_recurring_registration &registration :
             owner->character_recurring_handlers ) {
            const std::string failure_key = registration.due_variable + ':' +
                                            std::to_string( character.getID().get_value() );
            std::optional<std::int64_t> due;
            if( const diag_value *stored = character.maybe_get_value(
                        registration.due_variable ) ) {
                const double raw = stored->dbl();
                if( std::isfinite( raw ) && raw >= 0.0 &&
                    raw <= static_cast<double>( std::numeric_limits<std::int64_t>::max() ) &&
                    std::trunc( raw ) == raw ) {
                    due = static_cast<std::int64_t>( raw );
                }
            }
            const bool first_schedule = !due.has_value();
            if( due && *due > now ) {
                continue;
            }
            if( owner->callback_depth >= 16 ) {
                continue;
            }
            sol::table payload = owner->lua->create_table();
            payload["character"] = platform_creature_handle( *owner, character );
            payload["first_schedule"] = first_schedule;
            if( due ) {
                payload["due_turn"] = *due;
                payload["overdue_turns"] = nonnegative_turn_difference( now, *due );
            } else {
                payload["due_turn"] = sol::nil;
                payload["overdue_turns"] = 0;
            }
            if( !first_schedule ) {
                const auto effect = owner->handlers.find(
                                        registration.effect_handler );
                if( effect == owner->handlers.end() ) {
                    continue;
                }
                sol::protected_function callback = effect->second.callback;
                callback_scope scope( *owner );
                const sol::protected_function_result result = callback( payload );
                if( !result.valid() ) {
                    report_callback_error(
                        *owner, registration.effect_handler, result );
                }
            }
            const auto interval = owner->handlers.find(
                                      registration.interval_handler );
            if( interval == owner->handlers.end() ) {
                continue;
            }
            sol::protected_function interval_callback = interval->second.callback;
            callback_scope scope( *owner );
            const sol::protected_function_result interval_result =
                interval_callback( payload );
            std::optional<std::int64_t> interval_turns;
            if( interval_result.valid() && interval_result.return_count() == 1 &&
                interval_result.get_type() == sol::type::number ) {
                const double raw = interval_result.get<double>();
                if( std::isfinite( raw ) && raw >= 1.0 &&
                    raw <= static_cast<double>( maximum_character_recurrence_turns ) &&
                    std::trunc( raw ) == raw ) {
                    interval_turns = static_cast<std::int64_t>( raw );
                }
            } else if( !interval_result.valid() ) {
                report_callback_error(
                    *owner, registration.interval_handler, interval_result );
            }
            if( !interval_turns ) {
                if( owner->reported_character_recurring_failures.insert(
                            failure_key ).second ) {
                    DebugLog( D_ERROR, D_MAIN )
                            << "Lua-first character recurrence '" << owner->mod_id
                            << ':' << registration.interval_handler
                            << "' must return one integral interval from 1 through "
                            << maximum_character_recurrence_turns;
                }
                character.set_value(
                    registration.due_variable,
                    static_cast<double>(
                        now > std::numeric_limits<std::int64_t>::max() -
                        maximum_character_recurrence_turns ?
                        std::numeric_limits<std::int64_t>::max() :
                        now + maximum_character_recurrence_turns ) );
                continue;
            }
            owner->reported_character_recurring_failures.erase( failure_key );
            if( now > std::numeric_limits<std::int64_t>::max() -
                *interval_turns ) {
                character.set_value(
                    registration.due_variable,
                    static_cast<double>( std::numeric_limits<std::int64_t>::max() ) );
            } else {
                character.set_value(
                    registration.due_variable,
                    static_cast<double>( now + *interval_turns ) );
            }
        }
    }
}

void runtime_process_tasks()
{
    const std::int64_t now = to_turn<std::int64_t>( calendar::turn );
    for( const std::shared_ptr<runtime> &owner : active_runtimes ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        for( persistent_task &task : owner->tasks ) {
            const auto handler = owner->handlers.find( task.handler_id );
            if( handler == owner->handlers.end() ) {
                if( owner->reported_task_migration_failures.insert( task.id ).second ) {
                    DebugLog( D_WARNING, D_MAIN ) << "Keeping Lua-first task " << task.id
                                                  << " for missing handler '" << owner->mod_id
                                                  << ':' << task.handler_id << "'";
                }
                continue;
            }
            if( handler->second.payload_version == task.payload_version ) {
                owner->reported_task_migration_failures.erase( task.id );
                continue;
            }
            std::string migration_error;
            if( !migrate_task_payload( *owner, task, migration_error ) ) {
                if( owner->reported_task_migration_failures.insert( task.id ).second ) {
                    DebugLog( D_WARNING, D_MAIN ) << "Keeping Lua-first task " << task.id
                                                  << " with unmigrated payload for '"
                                                  << owner->mod_id << ':' << task.handler_id
                                                  << "': " << migration_error;
                }
            } else {
                owner->reported_task_migration_failures.erase( task.id );
            }
        }
        std::vector<persistent_task> due;
        owner->tasks.erase( std::remove_if( owner->tasks.begin(), owner->tasks.end(),
        [&due, &owner, now]( const persistent_task & task ) {
            const auto handler = owner->handlers.find( task.handler_id );
            if( task.due_turn <= now && handler != owner->handlers.end() &&
                handler->second.payload_version == task.payload_version ) {
                due.push_back( task );
                return true;
            }
            return false;
        } ), owner->tasks.end() );
        for( const persistent_task &task : due ) {
            owner->reported_task_migration_failures.erase( task.id );
        }
        std::sort( due.begin(), due.end(), []( const persistent_task & lhs,
        const persistent_task & rhs ) {
            return std::tie( lhs.due_turn, lhs.id ) < std::tie( rhs.due_turn, rhs.id );
        } );
        for( const persistent_task &task : due ) {
            const auto handler = owner->handlers.find( task.handler_id );
            if( handler == owner->handlers.end() ) {
                DebugLog( D_ERROR, D_MAIN ) << "Discarding Lua-first task " << task.id
                                            << " for missing handler '" << owner->mod_id
                                            << ":" << task.handler_id << "'";
                continue;
            }
            if( handler->second.payload_version != task.payload_version ) {
                // Unmigrated tasks remain in owner->tasks and cannot reach the
                // due list.  Keep this guard for corrupted in-memory input.
                DebugLog( D_ERROR, D_MAIN ) << "Keeping Lua-first task " << task.id
                                            << " because payload version "
                                            << task.payload_version << " does not match handler version "
                                            << handler->second.payload_version;
                continue;
            }
            std::optional<std::int64_t> next_due_turn;
            if( task.interval_turns > 0 ) {
                if( now > std::numeric_limits<std::int64_t>::max() -
                    task.interval_turns ) {
                    DebugLog( D_ERROR, D_MAIN )
                            << "Stopping Lua-first recurring task " << task.id
                            << " because its next due turn would overflow";
                } else {
                    persistent_task next = task;
                    next.due_turn = now + task.interval_turns;
                    next_due_turn = next.due_turn;
                    owner->tasks.push_back( std::move( next ) );
                }
            }
            sol::table payload = owner->lua->create_table();
            payload["id"] = static_cast<std::int64_t>( task.id );
            payload["due_turn"] = task.due_turn;
            payload["overdue_turns"] = nonnegative_turn_difference( now, task.due_turn );
            payload["recurring"] = task.interval_turns > 0;
            payload["interval_turns"] = task.interval_turns;
            if( next_due_turn ) {
                payload["next_due_turn"] = *next_due_turn;
            } else {
                payload["next_due_turn"] = sol::nil;
            }
            payload["owner"] = task.owner;
            payload["payload_version"] = task.payload_version;
            payload["payload"] = persistent_table( *owner->lua, task.payload );
            sol::protected_function callback = handler->second.callback;
            callback_scope scope( *owner );
            const sol::protected_function_result result = callback( payload );
            if( !result.valid() ) {
                report_callback_error( *owner, task.handler_id, result );
            } else if( next_due_turn && result.return_count() > 0 &&
                       result.get_type() == sol::type::boolean &&
                       !result.get<bool>() ) {
                owner->tasks.erase( std::remove_if(
                                        owner->tasks.begin(), owner->tasks.end(),
                [&task]( const persistent_task & candidate ) {
                    return candidate.id == task.id;
                } ), owner->tasks.end() );
            }
        }
    }
}

} // namespace cata::lua_platform

#else

namespace cata::lua_platform
{

struct content_transaction::impl {};

content_transaction::content_transaction( std::string, std::size_t ) :
    pimpl_( std::make_unique<impl>() )
{
}

content_transaction::~content_transaction() = default;

bool content_transaction::validate( const runtime &, bool, std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool content_transaction::apply( std::string &error )
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool content_transaction::validate_finalized( std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

void content_transaction::rollback() {}
void content_transaction::commit() {}
void content_transaction::seal() {}
void content_transaction::discard() {}
std::string content_transaction::fingerprint() const
{
    return {};
}
bool content_transaction::was_applied() const
{
    return false;
}
bool content_transaction::find_damage_handler( std::string_view, std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_ammo_effect_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_addiction_type_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_character_modifier_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_weather_type_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_end_screen_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_activity_type_handler( std::string_view,
        std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_snippet_handler( std::string_view,
        std::string &category_id, std::string &handler_id ) const
{
    category_id.clear();
    handler_id.clear();
    return false;
}
bool content_transaction::find_magic_type_handler( std::string_view, std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_emission_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_overmap_terrain_handler(
    std::string_view, std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_overmap_special_handler(
    std::string_view, std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_vehicle_part_handler(
    std::string_view, std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_plant_lifecycle_handler(
    std::string_view, std::string_view, std::string_view,
    std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool content_transaction::find_martial_art_handler(
    std::string_view, std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

void invoke_damage_type_handler( std::string_view, std::string_view,
                                 Creature *, Creature *, std::string_view,
                                 double, double )
{
}

void invoke_ammo_effect_handler( std::string_view, Creature *, Creature *,
                                 const tripoint_bub_ms &, int )
{
}

std::optional<bool> invoke_addiction_type_handler(
    std::string_view, Character &, int, std::int64_t )
{
    return std::nullopt;
}

std::optional<double> invoke_character_modifier_handler(
    std::string_view, const Character &, std::string_view )
{
    return std::nullopt;
}

std::optional<bool> invoke_shop_condition_handler(
    std::string_view, std::string_view, std::string_view, std::string_view,
    std::string_view, std::string_view, const item *, const npc & )
{
    return std::nullopt;
}

void invoke_overmap_terrain_handler(
    std::string_view, std::string_view, const tripoint_abs_omt &,
    const tripoint_abs_omt &, const Character & )
{
}

std::optional<bool> invoke_overmap_special_condition_handler(
    std::string_view, const tripoint_abs_omt &, int, std::string_view, int, int )
{
    return std::nullopt;
}

void invoke_overmap_special_placement_handler(
    std::string_view, const tripoint_abs_omt &, int, std::string_view, int, int )
{
}

void invoke_vehicle_part_activation_handler(
    std::string_view, vehicle &, vehicle_part &, Character & )
{
}

std::optional<bool> invoke_computer_access_handler( computer &, Character & )
{
    return std::nullopt;
}

void invoke_character_start_handler(
    std::string_view, std::string_view, std::string_view, std::string_view,
    Character & )
{
}

void invoke_recipe_completion_handler(
    std::string_view, std::string_view, std::string_view, Character &, int )
{
}

std::optional<bool> invoke_trap_trigger_handler(
    std::string_view, std::string_view, std::string_view,
    const tripoint_abs_ms &, Creature *, const item * )
{
    return std::nullopt;
}

void invoke_plant_lifecycle_handlers(
    std::string_view, Character &, map &, const tripoint_bub_ms &,
    std::string_view, std::string_view, std::string_view, int, int,
    const std::map<std::string, std::string> &,
    const std::map<std::string, double> & )
{
}

void invoke_martial_art_handler( std::string_view, std::string_view,
                                 Character & )
{
}

void invoke_technique_application_handler(
    std::string_view, std::string_view, std::string_view,
    Character &, Creature &, int, int, double, std::string_view )
{
}

void invoke_item_consumption_handler(
    std::string_view, std::string_view, std::string_view, Character &, item & )
{
}

void invoke_weakpoint_effect_handler(
    std::string_view, std::string_view, std::string_view, std::string_view,
    Creature &, int, const weakpoint_attack & )
{
}

std::optional<bool> invoke_behavior_condition_handler(
    std::string_view, std::string_view, std::string_view,
    const Creature *, std::string_view )
{
    return std::nullopt;
}

std::optional<double> invoke_behavior_score_handler(
    std::string_view, std::string_view, std::string_view,
    const Creature *, std::string_view )
{
    return std::nullopt;
}

std::optional<bool> invoke_monster_attack_handler(
    std::string_view, std::string_view, std::string_view, Creature & )
{
    return std::nullopt;
}

void invoke_monster_attack_result_handler(
    std::string_view, std::string_view, std::string_view, std::string_view,
    Creature &, Creature *, int )
{
}

void invoke_monster_death_handler(
    std::string_view, std::string_view, std::string_view,
    Creature &, Creature *, const tripoint_abs_ms & )
{
}

std::optional<bool> invoke_npc_death_handler(
    std::string_view, std::string_view, std::string_view,
    npc &, Creature *, const tripoint_abs_ms & )
{
    return std::nullopt;
}

void invoke_examine_handler(
    std::string_view, std::string_view, std::string_view, std::string_view,
    Character &, const tripoint_bub_ms & )
{
}

std::optional<bool> invoke_weather_type_handler( std::string_view, const w_point & )
{
    return std::nullopt;
}

std::optional<bool> invoke_end_screen_handler( std::string_view, const Character & )
{
    return std::nullopt;
}

bool invoke_activity_type_handler( std::string_view, std::string_view,
                                   player_activity &, Character & )
{
    return false;
}

bool invoke_snippet_examine_handler( std::string_view, std::string_view,
                                     Character & )
{
    return false;
}

std::optional<double> invoke_magic_type_number_handler(
    std::string_view, std::string_view, std::string_view, const Creature *, double )
{
    return std::nullopt;
}

void invoke_magic_type_failure_handler( std::string_view, std::string_view,
                                        Character & )
{
}

std::optional<emission_profile> invoke_emission_profile_handler(
    std::string_view, const tripoint_bub_ms &, const emission_profile & )
{
    return std::nullopt;
}

} // namespace cata::lua_platform

#endif
