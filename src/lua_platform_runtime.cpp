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
#include "lua_platform_content_character.h"
#include "lua_platform_content_creatures.h"
#include "lua_platform_content_items.h"
#include "lua_platform_content_presentation.h"
#include "lua_platform_content_worldgen.h"
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

using detail::callback_scope;
using detail::dispatch_lifecycle;
using detail::invoke_enchantment_condition_handler;
using detail::invoke_enchantment_number_handler;
using detail::invoke_mission_condition_handler;
using detail::invoke_mission_deadline_handler;
using detail::invoke_mission_phase_handler;
using detail::invoke_mission_place_handler;
using detail::invoke_mutation_condition_handler;
using detail::invoke_spell_condition_handler;
using detail::invoke_spell_effect_handler;
using detail::invoke_spell_stat_handler;
using detail::invoke_widget_condition_handler;
using detail::invoke_widget_custom_handler;
using detail::platform_callback_payload;
using detail::platform_callback_talker_to_lua;
using detail::platform_event_dispatch_scope;
using detail::platform_talker_to_lua;
using detail::report_callback_error;
using detail::require_live_runtime;
using detail::runtime_callback_is_active;
using detail::widget_custom_handler_result;

namespace
{

using persistent_state = cata::lua_platform::script_persistent_state;
using persistent_value = cata::lua_platform::script_persistent_value;


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


template<typename Definition>
struct catalog_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<Definition> definition;
};

using terrain_transform_registration = catalog_registration<terrain_transform_definition_data>;
using post_process_generator_registration =
    catalog_registration<post_process_generator_definition_data>;
using scenario_registration = catalog_registration<scenario_definition_data>;
using vehicle_color_palette_registration =
    catalog_registration<vehicle_color_palette_definition_data>;
using monster_group_registration =
    catalog_registration<monster_group_definition_data>;
using overmap_connection_registration =
    catalog_registration<overmap_connection_definition_data>;
using speed_description_registration = catalog_registration<speed_description_definition_data>;
using harvest_drop_type_registration = catalog_registration<harvest_drop_type_definition_data>;
using harvest_registration = catalog_registration<harvest_definition_data>;
using construction_category_registration =
    catalog_registration<construction_category_definition_data>;
using construction_group_registration = catalog_registration<construction_group_definition_data>;
using vehicle_part_location_registration =
    catalog_registration<vehicle_part_location_definition_data>;
using mood_face_registration = catalog_registration<mood_face_definition_data>;
using damage_info_order_registration = catalog_registration<damage_info_order_definition_data>;
using vehicle_part_category_registration =
    catalog_registration<vehicle_part_category_definition_data>;
using named_color_registration = catalog_registration<named_color_definition_data>;
using rotatable_symbol_registration = catalog_registration<rotatable_symbol_definition_data>;
using ascii_art_registration = catalog_registration<ascii_art_definition_data>;
using limb_score_registration = catalog_registration<limb_score_definition_data>;
using hit_range_registration = catalog_registration<hit_range_definition_data>;
using bash_damage_profile_registration =
    catalog_registration<bash_damage_profile_definition_data>;
using clothing_mod_registration = catalog_registration<clothing_mod_definition_data>;
using overmap_land_use_code_registration =
    catalog_registration<overmap_land_use_code_definition_data>;
using overmap_vision_registration = catalog_registration<overmap_vision_definition_data>;
using overmap_location_registration = catalog_registration<overmap_location_definition_data>;
using map_extra_collection_registration =
    catalog_registration<map_extra_collection_definition_data>;
using vehicle_group_registration = catalog_registration<vehicle_group_definition_data>;
using vehicle_placement_registration = catalog_registration<vehicle_placement_definition_data>;
using vehicle_spawn_registration = catalog_registration<vehicle_spawn_definition_data>;
using fault_group_registration = catalog_registration<fault_group_definition_data>;
using explosion_light_registration = catalog_registration<explosion_light_definition_data>;
using addiction_type_registration = catalog_registration<addiction_type_definition_data>;
using character_modifier_registration = catalog_registration<character_modifier_definition_data>;
using start_location_registration = catalog_registration<start_location_definition_data>;
using climbing_aid_registration = catalog_registration<climbing_aid_definition_data>;
using weather_type_registration = catalog_registration<weather_type_definition_data>;
using event_transformation_registration =
    catalog_registration<event_transformation_definition_data>;
using event_statistic_registration = catalog_registration<event_statistic_definition_data>;
using relic_procgen_registration = catalog_registration<relic_procgen_definition_data>;
using attack_vector_registration = catalog_registration<attack_vector_definition_data>;
using trap_registration = catalog_registration<trap_definition_data>;
using construction_registration = catalog_registration<construction_definition_data>;
using furniture_registration = catalog_registration<furniture_definition_data>;
using terrain_registration = catalog_registration<terrain_definition_data>;
using gate_registration = catalog_registration<gate_definition_data>;
using fault_registration = catalog_registration<fault_definition_data>;
using fault_fix_registration = catalog_registration<fault_fix_definition_data>;
using dream_registration = catalog_registration<dream_definition_data>;
using achievement_registration = catalog_registration<achievement_definition_data>;
using blacklist_registration = catalog_registration<detail::platform_blacklist_data>;
using map_extra_registration = catalog_registration<map_extra_definition_data>;
using weather_generator_registration =
    catalog_registration<weather_generator_definition_data>;
using migration_registration =
    catalog_registration<detail::platform_migration_data>;
using shopkeeper_registration =
    catalog_registration<shopkeeper_blacklist_definition_data>;
using trait_group_registration =
    catalog_registration<trait_group_definition_data>;
using monster_adjustment_registration =
    catalog_registration<monster_adjustment_definition_data>;

std::string operation_name( definition_operation operation )
{
    switch( operation ) {
        case definition_operation::add:
            return "add";
        case definition_operation::replace:
            return "replace";
        case definition_operation::edit:
            return "edit";
    }
    return "unknown";
}

void validate_monster_group_entry( const std::string &id,
                                   std::int64_t weight, std::int64_t cost,
                                   std::int64_t pack_minimum, std::int64_t pack_maximum )
{
    if( id.empty() ) {
        throw std::runtime_error( "monster group entry id cannot be empty" );
    }
    const int native_int_max = std::numeric_limits<int>::max();
    if( weight <= 0 || cost < 0 ||
        pack_minimum < 1 || pack_maximum < 1 ||
        pack_minimum > native_int_max || pack_maximum > native_int_max ||
        pack_minimum > pack_maximum ) {
        throw std::runtime_error(
            "monster group entries require a positive weight, a non-negative "
            "cost, and 1..pack-maximum bounds" );
    }
}

std::optional<vfx_easing> platform_vfx_easing( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    if( value == "linear" ) {
        return vfx_easing::linear;
    }
    if( value == "ease_in" ) {
        return vfx_easing::ease_in;
    }
    if( value == "ease_out" ) {
        return vfx_easing::ease_out;
    }
    if( value == "smoothstep" ) {
        return vfx_easing::smoothstep;
    }
    return std::nullopt;
}

std::optional<ot_match_type> platform_ot_match_type( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    if( value == "exact" ) {
        return ot_match_type::exact;
    }
    if( value == "type" ) {
        return ot_match_type::type;
    }
    if( value == "subtype" ) {
        return ot_match_type::subtype;
    }
    if( value == "prefix" ) {
        return ot_match_type::prefix;
    }
    if( value == "contains" ) {
        return ot_match_type::contains;
    }
    return std::nullopt;
}

std::optional<climbing_aid::category> platform_climbing_category( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    if( value == "special" ) {
        return climbing_aid::category::special;
    }
    if( value == "terrain_or_furniture" ) {
        return climbing_aid::category::ter_furn;
    }
    if( value == "vehicle" ) {
        return climbing_aid::category::veh;
    }
    if( value == "item" ) {
        return climbing_aid::category::item;
    }
    if( value == "character" ) {
        return climbing_aid::category::character;
    }
    if( value == "trait" ) {
        return climbing_aid::category::trait;
    }
    return std::nullopt;
}

std::optional<precip_class> platform_precipitation( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    if( value == "none" ) {
        return precip_class::none;
    }
    if( value == "very_light" ) {
        return precip_class::very_light;
    }
    if( value == "light" ) {
        return precip_class::light;
    }
    if( value == "heavy" ) {
        return precip_class::heavy;
    }
    return std::nullopt;
}

std::optional<weather_sound_category> platform_weather_sound_category( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    static const std::map<std::string, weather_sound_category> values = {
        { "silent", weather_sound_category::silent },
        { "drizzle", weather_sound_category::drizzle },
        { "rainy", weather_sound_category::rainy },
        { "rainstorm", weather_sound_category::rainstorm },
        { "thunder", weather_sound_category::thunder },
        { "flurries", weather_sound_category::flurries },
        { "snowstorm", weather_sound_category::snowstorm },
        { "snow", weather_sound_category::snow },
        { "portal_storm", weather_sound_category::portal_storm },
        { "clear", weather_sound_category::clear },
        { "sunny", weather_sound_category::sunny },
        { "cloudy", weather_sound_category::cloudy },
    };
    const auto found = values.find( value );
    return found == values.end() ? std::nullopt : std::optional<weather_sound_category>
           ( found->second );
}

std::uint64_t fnv1a( std::string_view value, std::uint64_t state = 1469598103934665603ULL )
{
    for( const unsigned char byte : value ) {
        state ^= byte;
        state *= 1099511628211ULL;
    }
    return state;
}

void hash_part( std::uint64_t &state, std::string_view value )
{
    state = fnv1a( std::to_string( value.size() ), state );
    state = fnv1a( ":", state );
    state = fnv1a( value, state );
    state = fnv1a( ";", state );
}

bool platform_filesystem_path_is_within(
    const std::filesystem::path &path,
    const std::filesystem::path &directory )
{
    auto path_part = path.begin();
    for( auto directory_part = directory.begin();
         directory_part != directory.end(); ++directory_part, ++path_part ) {
        if( path_part == path.end() || *path_part != *directory_part ) {
            return false;
        }
    }
    return true;
}

} // namespace

runtime::runtime( std::string id, const std::size_t candidate_generation,
                  sol::state &state, std::filesystem::path root ) :
    mod_id( std::move( id ) ),
    generation( candidate_generation ),
    lua( &state ),
    content( mod_id, generation ),
    mod_root( std::move( root ) ),
    random_engine( fnv1a( mod_id ) ^ static_cast<std::uint64_t>( generation ) )
{
}

cata::lua_platform::game_handle_runtime runtime::handle_runtime() const
{
    return cata::lua_platform::game_handle_runtime( game_handle_owner, generation );
}

std::uint64_t detail::runtime_hash( const std::string_view value )
{
    return fnv1a( value );
}

std::size_t detail::checked_dense_array( const sol::table &values,
        const std::string_view description, const std::size_t minimum,
        const std::size_t maximum )
{
    return require_dense_array( values, description, minimum, maximum );
}

bool runtime_has_handler( const runtime &value, const std::string_view handler_id )
{
    return value.handlers.count( std::string( handler_id ) ) != 0;
}

struct content_transaction::impl {
    impl( std::string owner_id, std::size_t owner_generation ) :
        owner( std::move( owner_id ) ), generation( owner_generation ),
        token( std::make_shared<owner_token>( owner_token{ owner, generation,
                                              handle_lifecycle::building } ) ),
        world( owner, generation ), presentation( owner, generation ),
        worldgen( owner, generation ), item_content( owner, generation ),
        creatures( owner, generation ), character( owner, generation ) {}

    std::string owner;
    std::size_t generation = 0;
    std::shared_ptr<owner_token> token;
    world_content_transaction world;
    presentation_content_transaction presentation;
    worldgen_content_transaction worldgen;
    items_content_transaction item_content;
    creatures_content_transaction creatures;
    character_content_transaction character;
    mutable bool finalization_validated = false;
    std::vector<terrain_transform_registration> terrain_transforms;
    std::vector<post_process_generator_registration> post_process_generators;
    std::vector<scenario_registration> scenarios;
    std::vector<vehicle_color_palette_registration> vehicle_color_palettes;
    std::vector<monster_group_registration> monster_groups;
    std::vector<overmap_connection_registration> overmap_connections;
    std::vector<speed_description_registration> speed_descriptions;
    std::vector<harvest_drop_type_registration> harvest_drop_types;
    std::vector<harvest_registration> harvests;
    std::vector<construction_category_registration> construction_categories;
    std::vector<construction_group_registration> construction_groups;
    std::vector<vehicle_part_location_registration> vehicle_part_locations;
    std::vector<mood_face_registration> mood_faces;
    std::vector<damage_info_order_registration> damage_info_orders;
    std::vector<vehicle_part_category_registration> vehicle_part_categories;
    std::vector<named_color_registration> named_colors;
    std::vector<rotatable_symbol_registration> rotatable_symbols;
    std::vector<ascii_art_registration> ascii_arts;
    std::vector<limb_score_registration> limb_scores;
    std::vector<hit_range_registration> hit_ranges;
    std::vector<bash_damage_profile_registration> bash_damage_profiles;
    std::vector<clothing_mod_registration> clothing_mods;
    std::vector<overmap_land_use_code_registration> overmap_land_use_codes;
    std::vector<overmap_vision_registration> overmap_visions;
    std::vector<overmap_location_registration> overmap_locations;
    std::vector<map_extra_collection_registration> map_extra_collections;
    std::vector<vehicle_group_registration> vehicle_groups;
    std::vector<vehicle_placement_registration> vehicle_placements;
    std::vector<vehicle_spawn_registration> vehicle_spawns;
    std::vector<fault_group_registration> fault_groups;
    std::vector<explosion_light_registration> explosion_lights;
    std::vector<addiction_type_registration> addiction_types;
    std::vector<character_modifier_registration> character_modifiers;
    std::vector<start_location_registration> start_locations;
    std::vector<climbing_aid_registration> climbing_aids;
    std::vector<weather_type_registration> weather_types;
    std::vector<event_transformation_registration> event_transformations;
    std::vector<event_statistic_registration> event_statistics;
    std::vector<relic_procgen_registration> relic_procgens;
    std::vector<attack_vector_registration> attack_vectors;
    std::vector<trap_registration> traps;
    std::vector<construction_registration> constructions;
    std::vector<furniture_registration> furniture;
    std::vector<terrain_registration> terrain;
    std::vector<gate_registration> gates;
    std::vector<fault_registration> faults;
    std::vector<fault_fix_registration> fault_fixes;
    std::vector<dream_registration> dreams;
    std::vector<achievement_registration> achievements;
    std::vector<blacklist_registration> blacklists;
    std::vector<map_extra_registration> map_extras;
    std::vector<weather_generator_registration> weather_generators;
    std::vector<migration_registration> migrations;
    std::vector<shopkeeper_registration> shopkeeper_rules;
    std::vector<trait_group_registration> trait_groups;
    std::vector<monster_adjustment_registration> monster_adjustments;
    std::vector<std::pair<ter_furn_transform_id, std::optional<ter_furn_transform>>>
    terrain_transform_undo;
    std::vector<std::pair<pp_generator_id, std::optional<pp_generator>>>
    post_process_generator_undo;
    std::vector<std::pair<string_id<scenario>, std::optional<scenario>>> scenario_undo;
    std::vector<std::pair<vpalette_id, std::optional<VehiclePalette>>>
    vehicle_color_palette_undo;
    std::vector<std::pair<mongroup_id, std::optional<MonsterGroup>>> monster_group_undo;
    std::vector<std::pair<string_id<overmap_connection>,
        std::optional<overmap_connection>>> overmap_connection_undo;
    std::vector<std::pair<speed_description_id, std::optional<speed_description>>>
    speed_description_undo;
    std::vector<std::pair<harvest_drop_type_id, std::optional<harvest_drop_type>>>
    harvest_drop_type_undo;
    std::vector<std::pair<harvest_id, std::optional<harvest_list>>> harvest_undo;
    std::vector<std::pair<construction_category_id,
        std::optional<construction_category>>> construction_category_undo;
    std::vector<std::pair<construction_group_str_id,
        std::optional<construction_group>>> construction_group_undo;
    std::vector<std::pair<vpart_location_id,
        std::optional<vpart_location>>> vehicle_part_location_undo;
    std::vector<std::pair<mood_face_id, std::optional<mood_face>>> mood_face_undo;
    std::vector<std::pair<damage_info_order_id,
        std::optional<damage_info_order>>> damage_info_order_undo;
    std::vector<std::pair<std::string,
        std::optional<vpart_category>>> vehicle_part_category_undo;
    std::optional<std::vector<detail::named_color_native_definition>> named_color_undo;
    std::optional<std::vector<detail::rotatable_symbol_native_entry>> rotatable_symbol_undo;
    std::vector<std::pair<ascii_art_id, std::optional<ascii_art>>> ascii_art_undo;
    std::vector<std::pair<limb_score_id, std::optional<limb_score>>> limb_score_undo;
    std::optional<std::vector<int>> hit_range_undo;
    std::vector<std::pair<bash_damage_profile_id, std::optional<bash_damage_profile>>>
    bash_damage_profile_undo;
    std::vector<std::pair<clothing_mod_id, std::optional<clothing_mod>>> clothing_mod_undo;
    std::vector<std::pair<overmap_land_use_code_id,
        std::optional<overmap_land_use_code>>> overmap_land_use_code_undo;
    std::vector<std::pair<oter_vision_id, std::optional<oter_vision>>> overmap_vision_undo;
    std::vector<std::pair<overmap_location_id, std::optional<overmap_location>>>
    overmap_location_undo;
    std::vector<std::pair<map_extra_collection_id, std::optional<map_extra_collection>>>
    map_extra_collection_undo;
    std::vector<std::pair<std::string, std::optional<VehicleGroup>>> vehicle_group_undo;
    std::vector<std::pair<std::string, std::optional<VehiclePlacement>>>
    vehicle_placement_undo;
    std::vector<std::pair<std::string, std::optional<VehicleSpawn>>> vehicle_spawn_undo;
    std::vector<std::pair<fault_group_id, std::optional<fault_group>>> fault_group_undo;
    std::vector<std::pair<explosion_light_str_id, std::optional<explosion_light>>>
    explosion_light_undo;
    std::vector<std::pair<addiction_id, std::optional<add_type>>> addiction_type_undo;
    std::vector<std::pair<character_modifier_id, std::optional<character_modifier>>>
    character_modifier_undo;
    std::vector<std::pair<start_location_id, std::optional<start_location>>>
    start_location_undo;
    std::vector<std::pair<climbing_aid_id, std::optional<climbing_aid>>>
    climbing_aid_undo;
    std::vector<std::pair<weather_type_id, std::optional<weather_type>>> weather_type_undo;
    std::vector<std::pair<std::string,
        std::shared_ptr<detail::event_transformation_snapshot>>> event_transformation_undo;
    std::vector<std::pair<std::string,
        std::shared_ptr<detail::event_statistic_snapshot>>> event_statistic_undo;
    std::vector<std::pair<relic_procgen_id,
        std::optional<relic_procgen_data>>> relic_procgen_undo;
    std::vector<std::pair<attack_vector_id, std::optional<attack_vector>>>
    attack_vector_undo;
    std::vector<std::pair<trap_str_id, std::optional<trap>>> trap_undo;
    std::vector<std::pair<construction_str_id, std::optional<construction>>>
    construction_undo;
    std::vector<std::pair<requirement_id, std::optional<requirement_data>>>
    construction_requirement_undo;
    std::vector<std::pair<furn_str_id, std::optional<furn_t>>> furniture_undo;
    std::vector<std::pair<ter_str_id, std::optional<ter_t>>> terrain_undo;
    std::vector<std::pair<gate_id, std::optional<gate_data>>> gate_undo;
    std::vector<std::pair<fault_id, std::optional<fault>>> fault_undo;
    std::vector<std::pair<fault_fix_id, std::optional<fault_fix>>> fault_fix_undo;
    std::size_t dream_undo = 0;
    std::vector<achievement_id> achievement_undo;
    std::vector<detail::platform_blacklist_data> blacklist_undo;
    std::size_t item_blacklist_undo = 0;
    std::vector<std::pair<map_extra_id, std::optional<map_extra>>> map_extra_undo;
    std::vector<std::pair<weather_generator_id, std::optional<weather_generator>>>
    weather_generator_undo;
    std::vector<detail::platform_migration_data> migration_undo;
    std::vector<std::pair<std::string, std::optional<std::string>>> shopkeeper_undo;
    std::vector<std::string> trait_group_undo;
    std::size_t monster_adjustment_undo = 0;
    bool applied = false;
};

talk_topic invoke_platform_dialogue_response_callback(
    std::weak_ptr<runtime> owner, std::string topic_id,
    sol::protected_function callback, ::dialogue &d, const talk_topic &fallback,
    bool trial_success );

namespace detail
{

std::vector<std::shared_ptr<runtime>> active_runtimes;
std::size_t active_world_generation = 0;

const std::vector<std::shared_ptr<runtime>> &active_runtime_values()
{
    return active_runtimes;
}

std::size_t &runtime_world_generation_storage()
{
    return active_world_generation;
}

std::shared_ptr<runtime> find_active_runtime( const std::string_view id )
{
    const auto found = std::find_if( active_runtimes.begin(), active_runtimes.end(),
    [id]( const std::shared_ptr<runtime> &value ) {
        return value && value->mod_id == id;
    } );
    return found == active_runtimes.end() ? nullptr : *found;
}

} // namespace detail

content_transaction::content_transaction( std::string owner, std::size_t generation ) :
    pimpl_( std::make_unique<impl>( std::move( owner ), generation ) )
{
}

content_transaction::~content_transaction() = default;

void content_transaction::install_lua_api( sol::state &lua, sol::table &ccb,
        const std::shared_ptr<runtime> &owner_runtime )
{
    ccb.new_usertype<terrain_transform_definition_handle>(
        "TerrainTransformDefinition", sol::no_constructor,
        "id", sol::property( &terrain_transform_definition_handle::id ),
        "terrain", &terrain_transform_definition_handle::terrain,
        "furniture", &terrain_transform_definition_handle::furniture,
        "field", &terrain_transform_definition_handle::field,
        "trap", &terrain_transform_definition_handle::trap );
    ccb.new_usertype<post_process_generator_definition_handle>(
        "PostProcessGeneratorDefinition", sol::no_constructor,
        "id", sol::property( &post_process_generator_definition_handle::id ),
        "stage", &post_process_generator_definition_handle::stage );
    ccb.new_usertype<scenario_definition_handle>(
        "ScenarioDefinition", sol::no_constructor,
        "id", sol::property( &scenario_definition_handle::id ),
        "location", &scenario_definition_handle::location,
        "profession", &scenario_definition_handle::profession,
        "allowed_trait", &scenario_definition_handle::allowed_trait,
        "forced_trait", &scenario_definition_handle::forced_trait,
        "forbidden_trait", &scenario_definition_handle::forbidden_trait,
        "flag", &scenario_definition_handle::flag,
        "requirement", &scenario_definition_handle::requirement,
        "on_start", &scenario_definition_handle::on_start );
    ccb.new_usertype<vehicle_color_palette_definition_handle>(
        "VehicleColorPaletteDefinition", sol::no_constructor,
        "id", sol::property( &vehicle_color_palette_definition_handle::id ),
        "group", &vehicle_color_palette_definition_handle::group );
    ccb.new_usertype<monster_group_definition_handle>(
        "MonsterGroupDefinition", sol::no_constructor,
        "id", sol::property( &monster_group_definition_handle::id ),
        "monster", &monster_group_definition_handle::monster,
        "group", &monster_group_definition_handle::group );
    ccb.new_usertype<overmap_connection_definition_handle>(
        "OvermapConnectionDefinition", sol::no_constructor,
        "id", sol::property( &overmap_connection_definition_handle::id ),
        "subtype", &overmap_connection_definition_handle::subtype );
    ccb.new_usertype<speed_description_definition_handle>(
        "SpeedDescriptionDefinition", sol::no_constructor,
        "id", sol::property( &speed_description_definition_handle::id ),
        "value", &speed_description_definition_handle::value );
    ccb.new_usertype<harvest_drop_type_definition_handle>(
        "HarvestDropTypeDefinition", sol::no_constructor,
        "id", sol::property( &harvest_drop_type_definition_handle::id ),
        "skill", &harvest_drop_type_definition_handle::skill );
    ccb.new_usertype<harvest_definition_handle>(
        "HarvestDefinition", sol::no_constructor,
        "id", sol::property( &harvest_definition_handle::id ),
        "drop", &harvest_definition_handle::drop,
        "item_flag", &harvest_definition_handle::item_flag,
        "item_fault", &harvest_definition_handle::item_fault );
    ccb.new_usertype<construction_category_definition_handle>(
        "ConstructionCategoryDefinition", sol::no_constructor,
        "id", sol::property( &construction_category_definition_handle::id ) );
    ccb.new_usertype<construction_group_definition_handle>(
        "ConstructionGroupDefinition", sol::no_constructor,
        "id", sol::property( &construction_group_definition_handle::id ) );
    ccb.new_usertype<vehicle_part_location_definition_handle>(
        "VehiclePartLocationDefinition", sol::no_constructor,
        "id", sol::property( &vehicle_part_location_definition_handle::id ) );
    ccb.new_usertype<mood_face_definition_handle>(
        "MoodFaceDefinition", sol::no_constructor,
        "id", sol::property( &mood_face_definition_handle::id ),
        "value", &mood_face_definition_handle::value );
    ccb.new_usertype<damage_info_order_definition_handle>(
        "DamageInfoOrderDefinition", sol::no_constructor,
        "id", sol::property( &damage_info_order_definition_handle::id ),
        "section", &damage_info_order_definition_handle::section );
    ccb.new_usertype<vehicle_part_category_definition_handle>(
        "VehiclePartCategoryDefinition", sol::no_constructor,
        "id", sol::property( &vehicle_part_category_definition_handle::id ) );
    ccb.new_usertype<named_color_definition_handle>(
        "NamedColorDefinition", sol::no_constructor,
        "name", sol::property( &named_color_definition_handle::name ) );
    ccb.new_usertype<rotatable_symbol_definition_handle>(
        "RotatableSymbolDefinition", sol::no_constructor,
        "key", sol::property( &rotatable_symbol_definition_handle::key ) );
    ccb.new_usertype<ascii_art_definition_handle>(
        "AsciiArtDefinition", sol::no_constructor,
        "id", sol::property( &ascii_art_definition_handle::id ),
        "line", &ascii_art_definition_handle::line );
    ccb.new_usertype<limb_score_definition_handle>(
        "LimbScoreDefinition", sol::no_constructor,
        "id", sol::property( &limb_score_definition_handle::id ) );
    ccb.new_usertype<hit_range_definition_handle>(
        "HitRangeDefinition", sol::no_constructor,
        "id", sol::property( &hit_range_definition_handle::id ) );
    ccb.new_usertype<bash_damage_profile_definition_handle>(
        "BashDamageProfileDefinition", sol::no_constructor,
        "id", sol::property( &bash_damage_profile_definition_handle::id ),
        "factor", &bash_damage_profile_definition_handle::factor );
    ccb.new_usertype<clothing_mod_definition_handle>(
        "ClothingModDefinition", sol::no_constructor,
        "id", sol::property( &clothing_mod_definition_handle::id ),
        "modifier", &clothing_mod_definition_handle::modifier );
    ccb.new_usertype<overmap_land_use_code_definition_handle>(
        "OvermapLandUseCodeDefinition", sol::no_constructor,
        "id", sol::property( &overmap_land_use_code_definition_handle::id ) );
    ccb.new_usertype<overmap_vision_definition_handle>(
        "OvermapVisionDefinition", sol::no_constructor,
        "id", sol::property( &overmap_vision_definition_handle::id ),
        "appearance", &overmap_vision_definition_handle::appearance,
        "blend_adjacent", &overmap_vision_definition_handle::blend_adjacent );
    ccb.new_usertype<overmap_location_definition_handle>(
        "OvermapLocationDefinition", sol::no_constructor,
        "id", sol::property( &overmap_location_definition_handle::id ),
        "terrain", &overmap_location_definition_handle::terrain,
        "terrain_flag", &overmap_location_definition_handle::terrain_flag );
    ccb.new_usertype<map_extra_collection_definition_handle>(
        "MapExtraCollectionDefinition", sol::no_constructor,
        "id", sol::property( &map_extra_collection_definition_handle::id ),
        "extra", &map_extra_collection_definition_handle::extra );
    ccb.new_usertype<vehicle_group_definition_handle>(
        "VehicleGroupDefinition", sol::no_constructor,
        "id", sol::property( &vehicle_group_definition_handle::id ),
        "vehicle", &vehicle_group_definition_handle::vehicle );
    ccb.new_usertype<vehicle_placement_definition_handle>(
        "VehiclePlacementDefinition", sol::no_constructor,
        "id", sol::property( &vehicle_placement_definition_handle::id ),
        "location", &vehicle_placement_definition_handle::location );
    ccb.new_usertype<vehicle_spawn_definition_handle>(
        "VehicleSpawnDefinition", sol::no_constructor,
        "id", sol::property( &vehicle_spawn_definition_handle::id ),
        "builtin", &vehicle_spawn_definition_handle::builtin,
        "vehicle", &vehicle_spawn_definition_handle::vehicle );
    ccb.new_usertype<fault_group_definition_handle>(
        "FaultGroupDefinition", sol::no_constructor,
        "id", sol::property( &fault_group_definition_handle::id ),
        "fault", &fault_group_definition_handle::fault );
    ccb.new_usertype<explosion_light_definition_handle>(
        "ExplosionLightDefinition", sol::no_constructor,
        "id", sol::property( &explosion_light_definition_handle::id ),
        "stop", &explosion_light_definition_handle::stop,
        "waves", &explosion_light_definition_handle::waves,
        "duration", &explosion_light_definition_handle::duration,
        "screen_shake", &explosion_light_definition_handle::screen_shake,
        "shockwave", &explosion_light_definition_handle::shockwave );
    ccb.new_usertype<addiction_type_definition_handle>(
        "AddictionTypeDefinition", sol::no_constructor,
        "id", sol::property( &addiction_type_definition_handle::id ),
        "tick_policy", &addiction_type_definition_handle::tick_policy );
    ccb.new_usertype<character_modifier_definition_handle>(
        "CharacterModifierDefinition", sol::no_constructor,
        "id", sol::property( &character_modifier_definition_handle::id ),
        "evaluate_with", &character_modifier_definition_handle::evaluate_with );
    ccb.new_usertype<start_location_definition_handle>(
        "StartLocationDefinition", sol::no_constructor,
        "id", sol::property( &start_location_definition_handle::id ),
        "terrain", &start_location_definition_handle::terrain,
        "flag", &start_location_definition_handle::flag,
        "city_size", &start_location_definition_handle::city_size,
        "city_distance", &start_location_definition_handle::city_distance,
        "z_levels", &start_location_definition_handle::z_levels );
    ccb.new_usertype<climbing_aid_definition_handle>(
        "ClimbingAidDefinition", sol::no_constructor,
        "id", sol::property( &climbing_aid_definition_handle::id ),
        "available_when", &climbing_aid_definition_handle::available_when,
        "descent", &climbing_aid_definition_handle::descent,
        "cost", &climbing_aid_definition_handle::cost,
        "deploy", &climbing_aid_definition_handle::deploy );
    ccb.new_usertype<weather_type_definition_handle>(
        "WeatherTypeDefinition", sol::no_constructor,
        "id", sol::property( &weather_type_definition_handle::id ),
        "duration", &weather_type_definition_handle::duration,
        "animation", &weather_type_definition_handle::animation,
        "requires", &weather_type_definition_handle::requires,
        "passive_effect", &weather_type_definition_handle::passive_effect,
        "condition", &weather_type_definition_handle::condition );
    ccb.new_usertype<event_transformation_definition_handle>(
        "EventTransformationDefinition", sol::no_constructor,
        "id", sol::property( &event_transformation_definition_handle::id ),
        "derive", &event_transformation_definition_handle::derive,
        "drop", &event_transformation_definition_handle::drop,
        "where_equals", &event_transformation_definition_handle::where_equals,
        "where_any", &event_transformation_definition_handle::where_any,
        "where_statistic", &event_transformation_definition_handle::where_statistic,
        "where_lt", &event_transformation_definition_handle::where_lt,
        "where_lte", &event_transformation_definition_handle::where_lte,
        "where_gte", &event_transformation_definition_handle::where_gte,
        "where_gt", &event_transformation_definition_handle::where_gt );
    ccb.new_usertype<event_statistic_definition_handle>(
        "EventStatisticDefinition", sol::no_constructor,
        "id", sol::property( &event_statistic_definition_handle::id ) );
    ccb.new_usertype<relic_procgen_definition_handle>(
        "RelicProcgenDefinition", sol::no_constructor,
        "id", sol::property( &relic_procgen_definition_handle::id ),
        "passive_add", &relic_procgen_definition_handle::passive_add,
        "passive_multiplier", &relic_procgen_definition_handle::passive_multiplier,
        "activated_spell", &relic_procgen_definition_handle::activated_spell,
        "on_hit_you", &relic_procgen_definition_handle::on_hit_you,
        "on_hit_me", &relic_procgen_definition_handle::on_hit_me,
        "type", &relic_procgen_definition_handle::type,
        "item", &relic_procgen_definition_handle::item,
        "charge", &relic_procgen_definition_handle::charge );
    ccb.new_usertype<attack_vector_definition_handle>(
        "AttackVectorDefinition", sol::no_constructor,
        "id", sol::property( &attack_vector_definition_handle::id ),
        "limb", &attack_vector_definition_handle::limb,
        "contact", &attack_vector_definition_handle::contact,
        "requires_limb", &attack_vector_definition_handle::requires_limb,
        "requires_flag", &attack_vector_definition_handle::requires_flag,
        "forbids_flag", &attack_vector_definition_handle::forbids_flag );
    ccb.new_usertype<trap_definition_handle>(
        "TrapDefinition", sol::no_constructor,
        "id", sol::property( &trap_definition_handle::id ),
        "flag", &trap_definition_handle::flag,
        "drop", &trap_definition_handle::drop,
        "on_trigger", &trap_definition_handle::on_trigger );
    ccb.new_usertype<construction_definition_handle>(
        "ConstructionDefinition", sol::no_constructor,
        "id", sol::property( &construction_definition_handle::id ),
        "requires_skill", &construction_definition_handle::requires_skill,
        "using_requirement", &construction_definition_handle::using_requirement,
        "pre_terrain", &construction_definition_handle::pre_terrain,
        "pre_flag", &construction_definition_handle::pre_flag,
        "post_flag", &construction_definition_handle::post_flag );
    ccb.new_usertype<furniture_definition_handle>(
        "FurnitureDefinition", sol::no_constructor,
        "id", sol::property( &furniture_definition_handle::id ),
        "flag", &furniture_definition_handle::flag,
        "on_examine", &furniture_definition_handle::on_examine );
    ccb.new_usertype<terrain_definition_handle>(
        "TerrainDefinition", sol::no_constructor,
        "id", sol::property( &terrain_definition_handle::id ),
        "flag", &terrain_definition_handle::flag,
        "on_examine", &terrain_definition_handle::on_examine );
    ccb.new_usertype<gate_definition_handle>(
        "GateDefinition", sol::no_constructor,
        "id", sol::property( &gate_definition_handle::id ),
        "wall", &gate_definition_handle::wall );
    ccb.new_usertype<fault_definition_handle>(
        "FaultDefinition", sol::no_constructor,
        "id", sol::property( &fault_definition_handle::id ),
        "flag", &fault_definition_handle::flag,
        "block_fault", &fault_definition_handle::block_fault,
        "fix", &fault_definition_handle::fix );
    ccb.new_usertype<fault_fix_definition_handle>(
        "FaultFixDefinition", sol::no_constructor,
        "id", sol::property( &fault_fix_definition_handle::id ),
        "requires_skill", &fault_fix_definition_handle::requires_skill,
        "removes_fault", &fault_fix_definition_handle::removes_fault,
        "adds_fault", &fault_fix_definition_handle::adds_fault );
    ccb.new_usertype<dream_definition_handle>(
        "DreamDefinition", sol::no_constructor,
        "message", &dream_definition_handle::message );
    ccb.new_usertype<achievement_definition_handle>(
        "AchievementDefinition", sol::no_constructor,
        "id", sol::property( &achievement_definition_handle::id ),
        "hidden_by", &achievement_definition_handle::hidden_by );
    ccb.new_usertype<blacklist_definition_handle>(
        "BlacklistDefinition", sol::no_constructor,
        "entry", &blacklist_definition_handle::entry );
    ccb.new_usertype<map_extra_definition_handle>(
        "MapExtraDefinition", sol::no_constructor,
        "id", sol::property( &map_extra_definition_handle::id ),
        "flag", &map_extra_definition_handle::flag );
    ccb.new_usertype<weather_generator_definition_handle>(
        "WeatherGeneratorDefinition", sol::no_constructor,
        "id", sol::property( &weather_generator_definition_handle::id ),
        "blacklisted_weather",
        &weather_generator_definition_handle::blacklisted_weather,
        "whitelisted_weather",
        &weather_generator_definition_handle::whitelisted_weather );
    ccb.new_usertype<migration_definition_handle>(
        "MigrationDefinition", sol::no_constructor );
    ccb.new_usertype<shopkeeper_definition_handle>(
        "ShopkeeperDefinition", sol::no_constructor,
        "id", sol::property( &shopkeeper_definition_handle::id ),
        "entry", &shopkeeper_definition_handle::entry );
    ccb.new_usertype<trait_group_definition_handle>(
        "TraitGroupDefinition", sol::no_constructor,
        "id", sol::property( &trait_group_definition_handle::id ),
        "trait", &trait_group_definition_handle::trait,
        "group", &trait_group_definition_handle::group );
    ccb.new_usertype<monster_adjustment_definition_handle>(
        "MonsterAdjustmentDefinition", sol::no_constructor );
    impl *const transaction = pimpl_.get();
    sol::table content = lua.create_table();
    content.set_function( "TerrainTransform", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<terrain_transform_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return terrain_transform_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "PostProcessGenerator", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<post_process_generator_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return post_process_generator_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Scenario", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<scenario_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->description = options.get_or( "description", std::string() );
        definition->start_name = options.get_or( "start_name", std::string() );
        definition->points = options.get_or<std::int64_t>( "points", 0 );
        definition->blacklist = options.get_or( "blacklist", false );
        definition->extra_professions = options.get_or( "extra_professions", false );
        definition->reveal_locale = options.get_or( "reveal_locale", true );
        definition->hard_requirement = options.get_or( "hard_requirement", false );
        definition->distance_initial_visibility = options.get_or<std::int64_t>(
                    "distance_initial_visibility", 15 );
        definition->map_extra = options.get_or( "map_extra", std::string() );
        definition->start_handler = options.get_or(
                                        "on_start", options.get_or(
                                            "start_handler", std::string() ) );
        return scenario_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "VehicleColorPalette",
    [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<vehicle_color_palette_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return vehicle_color_palette_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "MonsterGroup", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<monster_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->default_monster = options.get_or( "default_monster", std::string() );
        definition->is_animal = options.get_or( "is_animal", false );
        return monster_group_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "OvermapConnection",
    [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<overmap_connection_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return overmap_connection_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "SpeedDescription", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<speed_description_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return speed_description_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "HarvestDropType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<harvest_drop_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->field_dress_success = options.get_or(
                                              "field_dress_success", std::string() );
        definition->field_dress_failure = options.get_or(
                                              "field_dress_failure", std::string() );
        definition->butcher_success = options.get_or( "butcher_success", std::string() );
        definition->butcher_failure = options.get_or( "butcher_failure", std::string() );
        definition->dissect_success = options.get_or( "dissect_success", std::string() );
        definition->dissect_failure = options.get_or( "dissect_failure", std::string() );
        definition->item_group = options.get_or( "item_group", false );
        definition->dissect_only = options.get_or( "dissect_only", false );
        return harvest_drop_type_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Harvest", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<harvest_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->message = options.get_or( "message", std::string() );
        definition->leftovers = options.get_or(
                                    "leftovers", std::string( "ruined_chunks" ) );
        definition->butchery_requirements = options.get_or(
                                                "butchery_requirements", std::string( "default" ) );
        return harvest_definition_handle{ std::move( definition ), transaction->token };
    } );
    content.set_function( "MapExtraCollection", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<map_extra_collection_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->chance = options.get_or<std::int64_t>( "chance", 0 );
        return map_extra_collection_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "VehicleGroup", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<vehicle_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return vehicle_group_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "VehiclePlacement", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<vehicle_placement_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        vehicle_placement_definition_handle handle{
            std::move( definition ), transaction->token
        };
        if( const sol::optional<sol::table> locations =
                options.get<sol::optional<sol::table>>( "locations" ) ) {
            const std::size_t count = require_dense_array(
                                          *locations, "vehicle placement locations", 1, 1024 );
            for( std::size_t index = 1; index <= count; ++index ) {
                handle.location( locations->raw_get<sol::table>( index ) );
            }
        }
        return handle;
    } );
    content.set_function( "VehicleSpawn", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<vehicle_spawn_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return vehicle_spawn_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "FaultGroup", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<fault_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return fault_group_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "ExplosionLight", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<explosion_light_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return explosion_light_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "AddictionType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<addiction_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->type_name = options.get_or( "type_name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->craving_morale = options.get_or( "craving_morale", std::string() );
        return addiction_type_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "CharacterModifier", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<character_modifier_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->operation = options.get_or( "operation", std::string( "multiply" ) );
        return character_modifier_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "StartLocation", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<start_location_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        return start_location_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "ClimbingAid", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<climbing_aid_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->slip_chance_modifier = options.get_or<std::int64_t>(
                                               "slip_chance_modifier", 0 );
        return climbing_aid_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "WeatherType", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<weather_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->color = options.get_or( "color", std::string( "white" ) );
        definition->map_color = options.get_or( "map_color", std::string( "white" ) );
        definition->symbol = options.get_or( "symbol", std::string( "%" ) );
        definition->sun_symbol = options.get_or( "sun_symbol", std::string( "☼" ) );
        definition->ranged_penalty = options.get_or<std::int64_t>( "ranged_penalty", 0 );
        definition->sight_penalty = options.get_or( "sight_penalty", 1.0 );
        definition->light_modifier = options.get_or<std::int64_t>( "light_modifier", 0 );
        definition->temperature_delta_kelvin = options.get_or( "temperature_delta_kelvin", 0.0 );
        definition->light_multiplier = options.get_or( "light_multiplier", 1.0 );
        definition->sun_multiplier = options.get_or( "sun_multiplier", 1.0 );
        definition->sound_attenuation = options.get_or<std::int64_t>( "sound_attenuation", 0 );
        definition->dangerous = options.get_or( "dangerous", false );
        definition->precipitation = options.get_or( "precipitation", std::string( "none" ) );
        definition->rains = options.get_or( "rains", false );
        definition->tiles_animation = options.get_or( "tiles_animation", std::string() );
        definition->sound_category = options.get_or( "sound_category", std::string( "silent" ) );
        definition->priority = options.get_or<std::int64_t>( "priority", 0 );
        return weather_type_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "EventTransformation", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<event_transformation_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->source = event_transformation_definition_handle::source( options );
        return event_transformation_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "EventStatistic", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<event_statistic_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->statistic_type = options.get_or(
                                         "statistic_type",
                                         options.get_or( "stat_type", std::string() ) );
        definition->source = event_transformation_definition_handle::source( options );
        definition->field = options.get_or( "field", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->description_plural = options.get_or(
                                             "description_plural", std::string() );
        return event_statistic_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "RelicProcgen", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<relic_procgen_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return relic_procgen_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "AttackVector", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<attack_vector_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->weapon = options.get_or( "weapon", false );
        definition->strict_limbs = options.get_or( "strict_limbs", false );
        definition->armor_bonus = options.get_or( "armor_bonus", true );
        definition->encumbrance_limit = options.get_or<std::int64_t>(
                                            "encumbrance_limit", 100 );
        definition->health_percent_limit = options.get_or<std::int64_t>(
                                               "health_percent_limit", 10 );
        return attack_vector_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Trap", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<trap_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->color = options.get_or( "color", std::string() );
        definition->symbol = options.get_or( "symbol", std::string() );
        definition->visibility = options.get_or<std::int64_t>( "visibility", 1 );
        definition->avoidance = options.get_or<std::int64_t>( "avoidance", 0 );
        definition->difficulty = options.get_or<std::int64_t>( "difficulty", 0 );
        definition->action = options.get_or( "action", std::string() );
        definition->trigger_handler = options.get_or(
                                          "on_trigger",
                                          options.get_or( "trigger_handler", std::string() ) );
        if( definition->action.empty() && !definition->trigger_handler.empty() ) {
            definition->action = "none";
        }
        definition->memorial_male = options.get_or( "memorial_male", std::string() );
        definition->memorial_female = options.get_or( "memorial_female", std::string() );
        definition->trigger_message_u = options.get_or( "trigger_message_u", std::string() );
        definition->trigger_message_npc = options.get_or( "trigger_message_npc", std::string() );
        definition->trap_radius = options.get_or<std::int64_t>( "trap_radius", 0 );
        definition->benign = options.get_or( "benign", false );
        definition->always_invisible = options.get_or( "always_invisible", false );
        definition->funnel_radius = options.get_or<std::int64_t>( "funnel_radius", 0 );
        definition->comfort = options.get_or<std::int64_t>( "comfort", 0 );
        definition->trigger_weight_grams =
            options.get_or<std::int64_t>( "trigger_weight_grams", 500 );
        definition->sound_threshold_min =
            options.get_or<std::int64_t>( "sound_threshold_min", 0 );
        definition->sound_threshold_max =
            options.get_or<std::int64_t>( "sound_threshold_max", 0 );
        return trap_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Construction", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<construction_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->group = options.get_or( "group", std::string() );
        definition->category = options.get_or( "category", std::string() );
        definition->pre_note = options.get_or( "pre_note", std::string() );
        definition->post_terrain = options.get_or( "post_terrain", std::string() );
        definition->time_moves = options.get_or<std::int64_t>( "duration_moves", 0 );
        definition->activity_level = options.get_or( "activity_level", 1.0 );
        return construction_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Furniture", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<furniture_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->color = options.get_or( "color", std::string() );
        definition->symbol = options.get_or( "symbol", std::string() );
        definition->movecost = options.get_or<std::int64_t>( "move_cost_mod", 0 );
        definition->required_str = options.get_or<std::int64_t>( "required_str", 0 );
        definition->light_emitted = options.get_or<std::int64_t>( "light_emitted", 0 );
        definition->comfort = options.get_or<std::int64_t>( "comfort", 0 );
        definition->max_volume_ml = options.get_or<std::int64_t>( "max_volume_ml", 0 );
        definition->mass_grams = options.get_or<std::int64_t>( "mass_grams", 0 );
        definition->keg_capacity_ml = options.get_or<std::int64_t>( "keg_capacity_ml", 0 );
        definition->transparent = options.get_or( "transparent", false );
        definition->open = options.get_or( "open", std::string() );
        definition->close = options.get_or( "close", std::string() );
        definition->lockpick_result = options.get_or( "lockpick_result", std::string() );
        definition->crafting_pseudo_item =
            options.get_or( "crafting_pseudo_item", std::string() );
        definition->deployed_item = options.get_or( "deployed_item", std::string() );
        definition->examine_handler = options.get_or(
                                          "on_examine",
                                          options.get_or( "examine_handler", std::string() ) );
        definition->examine_name = options.get_or( "examine_name", std::string() );
        return furniture_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Terrain", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<terrain_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->color = options.get_or( "color", std::string() );
        definition->symbol = options.get_or( "symbol", std::string() );
        definition->movecost = options.get_or<std::int64_t>( "move_cost", 0 );
        definition->light_emitted = options.get_or<std::int64_t>( "light_emitted", 0 );
        definition->comfort = options.get_or<std::int64_t>( "comfort", 0 );
        definition->max_volume_ml = options.get_or<std::int64_t>( "max_volume_ml", 0 );
        definition->heat_radiation = options.get_or<std::int64_t>( "heat_radiation", 0 );
        definition->transparent = options.get_or( "transparent", false );
        definition->open = options.get_or( "open", std::string() );
        definition->close = options.get_or( "close", std::string() );
        definition->transforms_into = options.get_or( "transforms_into", std::string() );
        definition->roof = options.get_or( "roof", std::string() );
        definition->lockpick_result = options.get_or( "lockpick_result", std::string() );
        definition->trap = options.get_or( "trap", std::string() );
        definition->examine_handler = options.get_or(
                                          "on_examine",
                                          options.get_or( "examine_handler", std::string() ) );
        definition->examine_name = options.get_or( "examine_name", std::string() );
        return terrain_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Gate", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<gate_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->door = options.get_or( "door", std::string() );
        definition->floor = options.get_or( "floor", std::string() );
        definition->pull_message = options.get_or( "pull_message", std::string() );
        definition->open_message = options.get_or( "open_message", std::string() );
        definition->close_message = options.get_or( "close_message", std::string() );
        definition->fail_message = options.get_or( "fail_message", std::string() );
        definition->moves = options.get_or<std::int64_t>( "moves", 0 );
        definition->bashing_damage = options.get_or<std::int64_t>( "bashing_damage", 0 );
        return gate_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Fault", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<fault_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->fault_type = options.get_or( "fault_type", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->item_prefix = options.get_or( "item_prefix", std::string() );
        definition->item_suffix = options.get_or( "item_suffix", std::string() );
        definition->message = options.get_or( "message", std::string() );
        // Legacy faults default to the "bad" display color.
        definition->color = options.get_or( "color", std::string( "bad" ) );
        definition->price_modifier = options.get_or( "price_modifier", 1.0 );
        definition->degradation_mod = options.get_or<std::int64_t>( "degradation_mod", 0 );
        definition->instant_damage = options.get_or<std::int64_t>( "instant_damage", 0 );
        definition->contact_area_mod = options.get_or( "contact_area_mod", 1.0 );
        definition->rolling_resistance_mod =
            options.get_or( "rolling_resistance_mod", 1.0 );
        // Legacy faults default to no vehicle move penalty.
        definition->vehicle_move_penalty_mod =
            options.get_or<std::int64_t>( "vehicle_move_penalty_mod", 0 );
        definition->encumbrance_mod_flat =
            options.get_or<std::int64_t>( "encumbrance_mod_flat", 0 );
        definition->encumbrance_mod_mult =
            options.get_or( "encumbrance_mod_mult", 1.0 );
        definition->affected_by_degradation =
            options.get_or( "affected_by_degradation", false );
        return fault_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "FaultFix", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<fault_fix_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->success_msg = options.get_or( "success_msg", std::string() );
        definition->time_seconds = options.get_or<std::int64_t>( "time_seconds", 0 );
        definition->mod_damage = options.get_or<std::int64_t>( "mod_damage", 0 );
        definition->mod_degradation =
            options.get_or<std::int64_t>( "mod_degradation", 0 );
        return fault_fix_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Dream", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<dream_definition_data>();
        definition->category = options.get_or( "category", std::string() );
        definition->strength = options.get_or<std::int64_t>( "strength", 0 );
        return dream_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Achievement", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<achievement_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->is_conduct = options.get_or( "is_conduct", false );
        return achievement_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Blacklist", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<detail::platform_blacklist_data>();
        definition->kind = options.get_or( "kind", std::string() );
        definition->whitelist = options.get_or( "whitelist", false );
        return blacklist_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "MapExtra", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<map_extra_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->generator_id = options.get_or( "generator_id", std::string() );
        definition->symbol = options.get_or( "symbol", std::string() );
        definition->color = options.get_or( "color", std::string() );
        return map_extra_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "WeatherGenerator",
    [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<weather_generator_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->base_temperature =
            options.get_or( "base_temperature", 0.0 );
        definition->base_humidity = options.get_or( "base_humidity", 0.0 );
        definition->base_pressure = options.get_or( "base_pressure", 0.0 );
        definition->base_wind = options.get_or( "base_wind", 0.0 );
        definition->base_wind_distrib_peaks =
            options.get_or<std::int64_t>( "base_wind_distrib_peaks", 0 );
        definition->summer_temp_manual_mod =
            options.get_or<std::int64_t>( "summer_temp_manual_mod", 0 );
        definition->spring_temp_manual_mod =
            options.get_or<std::int64_t>( "spring_temp_manual_mod", 0 );
        definition->autumn_temp_manual_mod =
            options.get_or<std::int64_t>( "autumn_temp_manual_mod", 0 );
        definition->winter_temp_manual_mod =
            options.get_or<std::int64_t>( "winter_temp_manual_mod", 0 );
        definition->spring_humidity_manual_mod =
            options.get_or<std::int64_t>( "spring_humidity_manual_mod", 0 );
        definition->summer_humidity_manual_mod =
            options.get_or<std::int64_t>( "summer_humidity_manual_mod", 0 );
        definition->autumn_humidity_manual_mod =
            options.get_or<std::int64_t>( "autumn_humidity_manual_mod", 0 );
        definition->winter_humidity_manual_mod =
            options.get_or<std::int64_t>( "winter_humidity_manual_mod", 0 );
        return weather_generator_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Migration",
    [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<detail::platform_migration_data>();
        definition->kind = options.get_or( "kind", std::string() );
        definition->from_id = options.get_or( "from", std::string() );
        definition->to_id = options.get_or( "to", std::string() );
        return migration_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    const auto make_shopkeeper = [transaction]( const sol::table & options,
    const std::string & kind ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<shopkeeper_blacklist_definition_data>();
        definition->kind = kind;
        definition->id = options.get_or( "id", std::string() );
        definition->message = options.get_or( "message", std::string() );
        definition->default_rate = options.get_or<std::int64_t>( "default_rate", 0 );
        return shopkeeper_definition_handle{
            std::move( definition ), transaction->token
        };
    };
    content.set_function( "ShopkeeperBlacklist",
    [make_shopkeeper]( const sol::table & options ) {
        return make_shopkeeper( options, "blacklist" );
    } );
    content.set_function( "ShopkeeperWhitelist",
    [make_shopkeeper]( const sol::table & options ) {
        return make_shopkeeper( options, "whitelist" );
    } );
    content.set_function( "ShopkeeperConsumptionRates",
    [make_shopkeeper]( const sol::table & options ) {
        return make_shopkeeper( options, "consumption" );
    } );
    content.set_function( "TraitGroup",
    [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<trait_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return trait_group_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "MonsterAdjustment",
    [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<monster_adjustment_definition_data>();
        definition->species = options.get_or( "species", std::string() );
        definition->stat = options.get_or( "stat", std::string() );
        definition->stat_adjust = options.get_or( "stat_adjust", 1.0 );
        definition->flag = options.get_or( "flag", std::string() );
        definition->flag_val = options.get_or( "flag_val", false );
        definition->special = options.get_or( "special", std::string() );
        return monster_adjustment_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    content.set_function( "Conduct", [transaction]( const sol::table & options ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<achievement_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->is_conduct = true;
        return achievement_definition_handle{
            std::move( definition ), transaction->token
        };
    } );
    auto register_catalog = [transaction]( auto handle, auto & registrations,
    const definition_operation operation, const char *kind ) {
        if( handle.token != transaction->token ) {
            throw std::runtime_error( std::string( "cannot register a " ) + kind +
                                      " definition owned by another Mod" );
        }
        require_building_handle( handle.token, *handle.definition, kind );
        handle.definition->registered = true;
        if( operation == definition_operation::edit ) {
            const auto target = std::find_if(
                                    registrations.rbegin(), registrations.rend(),
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

    auto register_definition = [transaction, register_catalog]( const sol::object & value,
    definition_operation operation ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        if( value.is<terrain_transform_definition_handle>() ) {
            register_catalog( value.as<terrain_transform_definition_handle>(),
                              transaction->terrain_transforms, operation,
                              "terrain transform" );
            return;
        }
        if( value.is<post_process_generator_definition_handle>() ) {
            register_catalog( value.as<post_process_generator_definition_handle>(),
                              transaction->post_process_generators, operation,
                              "post-process generator" );
            return;
        }
        if( value.is<scenario_definition_handle>() ) {
            register_catalog( value.as<scenario_definition_handle>(),
                              transaction->scenarios, operation,
                              "scenario" );
            return;
        }
        if( value.is<vehicle_color_palette_definition_handle>() ) {
            register_catalog( value.as<vehicle_color_palette_definition_handle>(),
                              transaction->vehicle_color_palettes, operation,
                              "vehicle color palette" );
            return;
        }
        if( value.is<monster_group_definition_handle>() ) {
            register_catalog( value.as<monster_group_definition_handle>(),
                              transaction->monster_groups, operation,
                              "monster group" );
            return;
        }
        if( value.is<overmap_connection_definition_handle>() ) {
            register_catalog( value.as<overmap_connection_definition_handle>(),
                              transaction->overmap_connections, operation,
                              "overmap connection" );
            return;
        }
        if( value.is<speed_description_definition_handle>() ) {
            register_catalog( value.as<speed_description_definition_handle>(),
                              transaction->speed_descriptions, operation,
                              "speed description" );
            return;
        }
        if( value.is<harvest_drop_type_definition_handle>() ) {
            register_catalog( value.as<harvest_drop_type_definition_handle>(),
                              transaction->harvest_drop_types, operation,
                              "harvest drop type" );
            return;
        }
        if( value.is<harvest_definition_handle>() ) {
            register_catalog( value.as<harvest_definition_handle>(),
                              transaction->harvests, operation, "harvest" );
            return;
        }
        if( value.is<construction_category_definition_handle>() ) {
            register_catalog( value.as<construction_category_definition_handle>(),
                              transaction->construction_categories, operation,
                              "construction category" );
            return;
        }
        if( value.is<construction_group_definition_handle>() ) {
            register_catalog( value.as<construction_group_definition_handle>(),
                              transaction->construction_groups, operation,
                              "construction group" );
            return;
        }
        if( value.is<vehicle_part_location_definition_handle>() ) {
            register_catalog( value.as<vehicle_part_location_definition_handle>(),
                              transaction->vehicle_part_locations, operation,
                              "vehicle part location" );
            return;
        }
        if( value.is<mood_face_definition_handle>() ) {
            register_catalog( value.as<mood_face_definition_handle>(),
                              transaction->mood_faces, operation, "mood face" );
            return;
        }
        if( value.is<damage_info_order_definition_handle>() ) {
            register_catalog( value.as<damage_info_order_definition_handle>(),
                              transaction->damage_info_orders, operation,
                              "damage info order" );
            return;
        }
        if( value.is<vehicle_part_category_definition_handle>() ) {
            register_catalog( value.as<vehicle_part_category_definition_handle>(),
                              transaction->vehicle_part_categories, operation,
                              "vehicle part category" );
            return;
        }
        if( value.is<named_color_definition_handle>() ) {
            register_catalog( value.as<named_color_definition_handle>(),
                              transaction->named_colors, operation, "named color" );
            return;
        }
        if( value.is<rotatable_symbol_definition_handle>() ) {
            register_catalog( value.as<rotatable_symbol_definition_handle>(),
                              transaction->rotatable_symbols, operation,
                              "rotatable symbol" );
            return;
        }
        if( value.is<ascii_art_definition_handle>() ) {
            register_catalog( value.as<ascii_art_definition_handle>(),
                              transaction->ascii_arts, operation, "ASCII art" );
            return;
        }
        if( value.is<limb_score_definition_handle>() ) {
            register_catalog( value.as<limb_score_definition_handle>(),
                              transaction->limb_scores, operation, "limb score" );
            return;
        }
        if( value.is<hit_range_definition_handle>() ) {
            register_catalog( value.as<hit_range_definition_handle>(),
                              transaction->hit_ranges, operation, "hit range" );
            return;
        }
        if( value.is<bash_damage_profile_definition_handle>() ) {
            register_catalog( value.as<bash_damage_profile_definition_handle>(),
                              transaction->bash_damage_profiles, operation,
                              "bash damage profile" );
            return;
        }
        if( value.is<clothing_mod_definition_handle>() ) {
            register_catalog( value.as<clothing_mod_definition_handle>(),
                              transaction->clothing_mods, operation,
                              "clothing modification" );
            return;
        }
        if( value.is<overmap_land_use_code_definition_handle>() ) {
            register_catalog( value.as<overmap_land_use_code_definition_handle>(),
                              transaction->overmap_land_use_codes, operation,
                              "overmap land-use code" );
            return;
        }
        if( value.is<overmap_vision_definition_handle>() ) {
            register_catalog( value.as<overmap_vision_definition_handle>(),
                              transaction->overmap_visions, operation,
                              "overmap vision" );
            return;
        }
        if( value.is<overmap_location_definition_handle>() ) {
            register_catalog( value.as<overmap_location_definition_handle>(),
                              transaction->overmap_locations, operation,
                              "overmap location" );
            return;
        }
        if( value.is<map_extra_collection_definition_handle>() ) {
            register_catalog( value.as<map_extra_collection_definition_handle>(),
                              transaction->map_extra_collections, operation,
                              "map-extra collection" );
            return;
        }
        if( value.is<vehicle_group_definition_handle>() ) {
            register_catalog( value.as<vehicle_group_definition_handle>(),
                              transaction->vehicle_groups, operation,
                              "vehicle group" );
            return;
        }
        if( value.is<vehicle_placement_definition_handle>() ) {
            register_catalog( value.as<vehicle_placement_definition_handle>(),
                              transaction->vehicle_placements, operation,
                              "vehicle placement" );
            return;
        }
        if( value.is<vehicle_spawn_definition_handle>() ) {
            register_catalog( value.as<vehicle_spawn_definition_handle>(),
                              transaction->vehicle_spawns, operation, "vehicle spawn" );
            return;
        }
        if( value.is<fault_group_definition_handle>() ) {
            register_catalog( value.as<fault_group_definition_handle>(),
                              transaction->fault_groups, operation,
                              "fault group" );
            return;
        }
        if( value.is<explosion_light_definition_handle>() ) {
            register_catalog( value.as<explosion_light_definition_handle>(),
                              transaction->explosion_lights, operation,
                              "explosion light" );
            return;
        }
        if( value.is<addiction_type_definition_handle>() ) {
            register_catalog( value.as<addiction_type_definition_handle>(),
                              transaction->addiction_types, operation,
                              "addiction type" );
            return;
        }
        if( value.is<character_modifier_definition_handle>() ) {
            register_catalog( value.as<character_modifier_definition_handle>(),
                              transaction->character_modifiers, operation,
                              "character modifier" );
            return;
        }
        if( value.is<start_location_definition_handle>() ) {
            register_catalog( value.as<start_location_definition_handle>(),
                              transaction->start_locations, operation,
                              "start location" );
            return;
        }
        if( value.is<climbing_aid_definition_handle>() ) {
            register_catalog( value.as<climbing_aid_definition_handle>(),
                              transaction->climbing_aids, operation,
                              "climbing aid" );
            return;
        }
        if( value.is<weather_type_definition_handle>() ) {
            register_catalog( value.as<weather_type_definition_handle>(),
                              transaction->weather_types, operation,
                              "weather type" );
            return;
        }
        if( value.is<event_transformation_definition_handle>() ) {
            register_catalog( value.as<event_transformation_definition_handle>(),
                              transaction->event_transformations, operation,
                              "event transformation" );
            return;
        }
        if( value.is<event_statistic_definition_handle>() ) {
            register_catalog( value.as<event_statistic_definition_handle>(),
                              transaction->event_statistics, operation,
                              "event statistic" );
            return;
        }
        if( value.is<relic_procgen_definition_handle>() ) {
            register_catalog( value.as<relic_procgen_definition_handle>(),
                              transaction->relic_procgens, operation,
                              "relic procgen" );
            return;
        }
        if( value.is<attack_vector_definition_handle>() ) {
            register_catalog( value.as<attack_vector_definition_handle>(),
                              transaction->attack_vectors, operation,
                              "attack vector" );
            return;
        }
        if( value.is<trap_definition_handle>() ) {
            register_catalog( value.as<trap_definition_handle>(),
                              transaction->traps, operation, "trap" );
            return;
        }
        if( value.is<construction_definition_handle>() ) {
            register_catalog( value.as<construction_definition_handle>(),
                              transaction->constructions, operation, "construction" );
            return;
        }
        if( value.is<furniture_definition_handle>() ) {
            register_catalog( value.as<furniture_definition_handle>(),
                              transaction->furniture, operation, "furniture" );
            return;
        }
        if( value.is<terrain_definition_handle>() ) {
            register_catalog( value.as<terrain_definition_handle>(),
                              transaction->terrain, operation, "terrain" );
            return;
        }
        if( value.is<gate_definition_handle>() ) {
            register_catalog( value.as<gate_definition_handle>(),
                              transaction->gates, operation, "gate" );
            return;
        }
        if( value.is<fault_definition_handle>() ) {
            register_catalog( value.as<fault_definition_handle>(),
                              transaction->faults, operation, "fault" );
            return;
        }
        if( value.is<fault_fix_definition_handle>() ) {
            register_catalog( value.as<fault_fix_definition_handle>(),
                              transaction->fault_fixes, operation, "fault fix" );
            return;
        }
        if( value.is<dream_definition_handle>() ) {
            dream_definition_handle handle = value.as<dream_definition_handle>();
            if( handle.token != transaction->token ) {
                throw std::runtime_error( "cannot register a dream definition owned by another Mod" );
            }
            require_building_handle( handle.token, *handle.definition, "dream" );
            handle.definition->registered = true;
            if( operation == definition_operation::edit ) {
                throw std::runtime_error( "dreams cannot be edited" );
            }
            transaction->dreams.push_back( { operation, handle.definition } );
            return;
        }
        if( value.is<achievement_definition_handle>() ) {
            achievement_definition_handle handle =
                value.as<achievement_definition_handle>();
            if( handle.token != transaction->token ) {
                throw std::runtime_error( "cannot register an achievement definition owned by another Mod" );
            }
            require_building_handle( handle.token, *handle.definition, "achievement" );
            if( operation != definition_operation::add ) {
                throw std::runtime_error( "achievements cannot be edited or replaced" );
            }
            handle.definition->registered = true;
            transaction->achievements.push_back( { operation, handle.definition } );
            return;
        }
        if( value.is<blacklist_definition_handle>() ) {
            blacklist_definition_handle handle =
                value.as<blacklist_definition_handle>();
            if( handle.token != transaction->token ) {
                throw std::runtime_error( "cannot register a blacklist definition owned by another Mod" );
            }
            require_building_handle( handle.token, *handle.definition, "blacklist" );
            if( operation != definition_operation::add ) {
                throw std::runtime_error( "blacklists cannot be edited or replaced" );
            }
            handle.definition->registered = true;
            transaction->blacklists.push_back( { operation, handle.definition } );
            return;
        }
        if( value.is<map_extra_definition_handle>() ) {
            register_catalog( value.as<map_extra_definition_handle>(),
                              transaction->map_extras, operation, "map extra" );
            return;
        }
        if( value.is<weather_generator_definition_handle>() ) {
            register_catalog( value.as<weather_generator_definition_handle>(),
                              transaction->weather_generators, operation,
                              "weather generator" );
            return;
        }
        if( value.is<shopkeeper_definition_handle>() ) {
            register_catalog( value.as<shopkeeper_definition_handle>(),
                              transaction->shopkeeper_rules, operation,
                              "shopkeeper rule" );
            return;
        }
        if( value.is<trait_group_definition_handle>() ) {
            register_catalog( value.as<trait_group_definition_handle>(),
                              transaction->trait_groups, operation,
                              "trait group" );
            return;
        }
        if( value.is<monster_adjustment_definition_handle>() ) {
            monster_adjustment_definition_handle handle =
                value.as<monster_adjustment_definition_handle>();
            if( handle.token != transaction->token ) {
                throw std::runtime_error( "cannot register a monster adjustment owned by another Mod" );
            }
            require_building_handle( handle.token, *handle.definition, "monster adjustment" );
            if( operation != definition_operation::add ) {
                throw std::runtime_error( "monster adjustments cannot be edited or replaced" );
            }
            handle.definition->registered = true;
            transaction->monster_adjustments.push_back( { operation, handle.definition } );
            return;
        }
        if( value.is<migration_definition_handle>() ) {
            migration_definition_handle handle =
                value.as<migration_definition_handle>();
            if( handle.token != transaction->token ) {
                throw std::runtime_error( "cannot register a migration definition owned by another Mod" );
            }
            require_building_handle( handle.token, *handle.definition, "migration" );
            if( operation != definition_operation::add ) {
                throw std::runtime_error( "migrations cannot be edited or replaced" );
            }
            handle.definition->registered = true;
            transaction->migrations.push_back( { operation, handle.definition } );
            return;
        }
        if( transaction->item_content.register_definition(
                value, static_cast<int>( operation ) ) ) {
            return;
        }
        if( transaction->creatures.register_definition(
                value, static_cast<int>( operation ) ) ) {
            return;
        }
        if( transaction->character.register_definition(
                value, static_cast<int>( operation ) ) ) {
            return;
        }
        if( transaction->presentation.register_definition(
                value, static_cast<int>( operation ) ) ) {
            return;
        }
        if( transaction->worldgen.register_definition(
                value, static_cast<int>( operation ) ) ) {
            return;
        }
        if( transaction->world.register_definition(
                value, static_cast<int>( operation ) ) ) {
            return;
        }
        throw std::runtime_error(
            "content registration requires a native Platform definition" );
    };
    content.set_function( "add", [register_definition]( const sol::object & value ) {
        register_definition( value, definition_operation::add );
    } );
    content.set_function( "replace", [register_definition]( const sol::object & value ) {
        register_definition( value, definition_operation::replace );
    } );
    content.set_function( "edit", [register_definition]( const sol::object & value ) {
        register_definition( value, definition_operation::edit );
    } );
    auto edit_catalog = [transaction]( const std::string & id, auto & registrations,
    const char *kind ) {
        if( transaction->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        const auto found = std::find_if(
                               registrations.rbegin(), registrations.rend(),
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
    content.set_function( "edit_terrain_transform", [transaction, edit_catalog](
    const std::string & id ) {
        return terrain_transform_definition_handle{
            edit_catalog( id, transaction->terrain_transforms, "terrain_transform" ),
            transaction->token
        };
    } );
    content.set_function( "edit_post_process_generator", [transaction, edit_catalog](
    const std::string & id ) {
        return post_process_generator_definition_handle{
            edit_catalog( id, transaction->post_process_generators,
                          "post_process_generator" ), transaction->token
        };
    } );
    content.set_function( "edit_speed_description", [transaction, edit_catalog](
    const std::string & id ) {
        return speed_description_definition_handle{
            edit_catalog( id, transaction->speed_descriptions, "speed_description" ),
            transaction->token
        };
    } );
    content.set_function( "edit_harvest_drop_type", [transaction, edit_catalog](
    const std::string & id ) {
        return harvest_drop_type_definition_handle{
            edit_catalog( id, transaction->harvest_drop_types, "harvest_drop_type" ),
            transaction->token
        };
    } );
    content.set_function( "edit_harvest", [transaction, edit_catalog](
    const std::string & id ) {
        return harvest_definition_handle{
            edit_catalog( id, transaction->harvests, "harvest" ), transaction->token
        };
    } );
    content.set_function( "edit_construction_category", [transaction, edit_catalog](
    const std::string & id ) {
        return construction_category_definition_handle{
            edit_catalog( id, transaction->construction_categories, "construction_category" ),
            transaction->token
        };
    } );
    content.set_function( "edit_construction_group", [transaction, edit_catalog](
    const std::string & id ) {
        return construction_group_definition_handle{
            edit_catalog( id, transaction->construction_groups, "construction_group" ),
            transaction->token
        };
    } );
    content.set_function( "edit_vehicle_part_location", [transaction, edit_catalog](
    const std::string & id ) {
        return vehicle_part_location_definition_handle{
            edit_catalog( id, transaction->vehicle_part_locations, "vehicle_part_location" ),
            transaction->token
        };
    } );
    content.set_function( "edit_mood_face", [transaction, edit_catalog](
    const std::string & id ) {
        return mood_face_definition_handle{
            edit_catalog( id, transaction->mood_faces, "mood_face" ), transaction->token
        };
    } );
    content.set_function( "edit_damage_info_order", [transaction, edit_catalog](
    const std::string & id ) {
        return damage_info_order_definition_handle{
            edit_catalog( id, transaction->damage_info_orders, "damage_info_order" ),
            transaction->token
        };
    } );
    content.set_function( "edit_vehicle_part_category", [transaction, edit_catalog](
    const std::string & id ) {
        return vehicle_part_category_definition_handle{
            edit_catalog( id, transaction->vehicle_part_categories,
                          "vehicle_part_category" ), transaction->token
        };
    } );
    content.set_function( "edit_named_color", [transaction, edit_catalog](
    const std::string & name ) {
        return named_color_definition_handle{
            edit_catalog( name, transaction->named_colors, "named_color" ),
            transaction->token
        };
    } );
    content.set_function( "edit_rotatable_symbol", [transaction, edit_catalog](
    const std::string & key ) {
        return rotatable_symbol_definition_handle{
            edit_catalog( key, transaction->rotatable_symbols, "rotatable_symbol" ),
            transaction->token
        };
    } );
    content.set_function( "edit_ascii_art", [transaction, edit_catalog](
    const std::string & id ) {
        return ascii_art_definition_handle{
            edit_catalog( id, transaction->ascii_arts, "ascii_art" ), transaction->token
        };
    } );
    content.set_function( "edit_limb_score", [transaction, edit_catalog](
    const std::string & id ) {
        return limb_score_definition_handle{
            edit_catalog( id, transaction->limb_scores, "limb_score" ), transaction->token
        };
    } );
    content.set_function( "edit_bash_damage_profile", [transaction, edit_catalog](
    const std::string & id ) {
        return bash_damage_profile_definition_handle{
            edit_catalog( id, transaction->bash_damage_profiles, "bash_damage_profile" ),
            transaction->token
        };
    } );
    content.set_function( "edit_clothing_mod", [transaction, edit_catalog](
    const std::string & id ) {
        return clothing_mod_definition_handle{
            edit_catalog( id, transaction->clothing_mods, "clothing_mod" ), transaction->token
        };
    } );
    content.set_function( "edit_overmap_land_use_code", [transaction, edit_catalog](
    const std::string & id ) {
        return overmap_land_use_code_definition_handle{
            edit_catalog( id, transaction->overmap_land_use_codes,
                          "overmap_land_use_code" ), transaction->token
        };
    } );
    content.set_function( "edit_overmap_vision", [transaction, edit_catalog](
    const std::string & id ) {
        return overmap_vision_definition_handle{
            edit_catalog( id, transaction->overmap_visions, "overmap_vision" ),
            transaction->token
        };
    } );
    content.set_function( "edit_overmap_location", [transaction, edit_catalog](
    const std::string & id ) {
        return overmap_location_definition_handle{
            edit_catalog( id, transaction->overmap_locations, "overmap_location" ),
            transaction->token
        };
    } );
    content.set_function( "edit_map_extra_collection", [transaction, edit_catalog](
    const std::string & id ) {
        return map_extra_collection_definition_handle{
            edit_catalog( id, transaction->map_extra_collections, "map_extra_collection" ),
            transaction->token
        };
    } );
    content.set_function( "edit_vehicle_group", [transaction, edit_catalog](
    const std::string & id ) {
        return vehicle_group_definition_handle{
            edit_catalog( id, transaction->vehicle_groups, "vehicle_group" ),
            transaction->token
        };
    } );
    content.set_function( "edit_vehicle_placement", [transaction, edit_catalog](
    const std::string & id ) {
        return vehicle_placement_definition_handle{
            edit_catalog( id, transaction->vehicle_placements, "vehicle_placement" ),
            transaction->token
        };
    } );
    content.set_function( "edit_vehicle_spawn", [transaction, edit_catalog](
    const std::string & id ) {
        return vehicle_spawn_definition_handle{
            edit_catalog( id, transaction->vehicle_spawns, "vehicle_spawn" ),
            transaction->token
        };
    } );
    content.set_function( "edit_fault_group", [transaction, edit_catalog](
    const std::string & id ) {
        return fault_group_definition_handle{
            edit_catalog( id, transaction->fault_groups, "fault_group" ),
            transaction->token
        };
    } );
    content.set_function( "edit_explosion_light", [transaction, edit_catalog](
    const std::string & id ) {
        return explosion_light_definition_handle{
            edit_catalog( id, transaction->explosion_lights, "explosion_light" ),
            transaction->token
        };
    } );
    content.set_function( "edit_addiction_type", [transaction, edit_catalog](
    const std::string & id ) {
        return addiction_type_definition_handle{
            edit_catalog( id, transaction->addiction_types, "addiction_type" ),
            transaction->token
        };
    } );
    content.set_function( "edit_character_modifier", [transaction, edit_catalog](
    const std::string & id ) {
        return character_modifier_definition_handle{
            edit_catalog( id, transaction->character_modifiers, "character_modifier" ),
            transaction->token
        };
    } );
    content.set_function( "edit_start_location", [transaction, edit_catalog](
    const std::string & id ) {
        return start_location_definition_handle{
            edit_catalog( id, transaction->start_locations, "start_location" ),
            transaction->token
        };
    } );
    content.set_function( "edit_climbing_aid", [transaction, edit_catalog](
    const std::string & id ) {
        return climbing_aid_definition_handle{
            edit_catalog( id, transaction->climbing_aids, "climbing_aid" ),
            transaction->token
        };
    } );
    content.set_function( "edit_weather_type", [transaction, edit_catalog](
    const std::string & id ) {
        return weather_type_definition_handle{
            edit_catalog( id, transaction->weather_types, "weather_type" ),
            transaction->token
        };
    } );
    content.set_function( "edit_event_transformation", [transaction, edit_catalog](
    const std::string & id ) {
        return event_transformation_definition_handle{
            edit_catalog( id, transaction->event_transformations,
                          "event_transformation" ), transaction->token
        };
    } );
    content.set_function( "edit_event_statistic", [transaction, edit_catalog](
    const std::string & id ) {
        return event_statistic_definition_handle{
            edit_catalog( id, transaction->event_statistics,
                          "event_statistic" ), transaction->token
        };
    } );
    content.set_function( "edit_relic_procgen", [transaction, edit_catalog](
    const std::string & id ) {
        return relic_procgen_definition_handle{
            edit_catalog( id, transaction->relic_procgens, "relic_procgen" ),
            transaction->token
        };
    } );
    content.set_function( "edit_attack_vector", [transaction, edit_catalog](
    const std::string & id ) {
        return attack_vector_definition_handle{
            edit_catalog( id, transaction->attack_vectors, "attack_vector" ),
            transaction->token
        };
    } );
    transaction->item_content.install_lua_api( lua, ccb, content );
    transaction->creatures.install_lua_api( lua, ccb, content );
    transaction->character.install_lua_api( lua, ccb, content );
    transaction->presentation.install_lua_api( lua, ccb, content );
    transaction->worldgen.install_lua_api( lua, ccb, content );
    transaction->world.install_lua_api( lua, ccb, content );
    ccb["content"] = std::move( content );

    static_cast<void>( owner_runtime );
}

bool content_transaction::validate( const runtime &owner_runtime,
                                    bool check_engine_state,
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
        };

        const items_content_staged_ids staged_items = pimpl_->item_content.staged_ids();
        const auto &skill_ids = staged_items.skills;
        const auto &json_flag_ids = staged_items.json_flags;
        const auto &damage_type_ids = staged_items.damage_types;
        const auto &declared_item_ids = staged_items.items;
        const auto &item_group_ids = staged_items.item_groups;

        items_content_validation_context items_context;
        items_context.defines_furniture = [this]( const std::string_view id ) {
            return std::any_of(
                       pimpl_->furniture.begin(), pimpl_->furniture.end(),
            [id]( const furniture_registration & entry ) {
                return entry.definition->id == id;
            } );
        };
        items_context.defines_explosion_light = [this]( const std::string_view id ) {
            return std::any_of(
                       pimpl_->explosion_lights.begin(), pimpl_->explosion_lights.end(),
            [id]( const explosion_light_registration & entry ) {
                return entry.definition->id == id;
            } );
        };
        if( !pimpl_->item_content.validate(
                owner_runtime, check_engine_state, items_context, error ) ) {
            return false;
        }
        creatures_content_validation_index creatures_index;
        creatures_index.defines_item = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_item( id );
        };
        creatures_index.defines_material = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_material( id );
        };
        creatures_index.defines_damage_type = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_damage_type( id );
        };
        creatures_index.defines_skill = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_skill( id );
        };
        creatures_index.defines_proficiency = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_proficiency( id );
        };
        creatures_index.defines_vitamin = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_vitamin( id );
        };
        creatures_index.defines_trait = []( const std::string_view id ) {
            return trait_id( std::string( id ) ).is_valid();
        };
        creatures_index.validate_scaled_requirements = [this](
                    const std::vector<std::pair<std::string, std::int64_t>> &requirements,
        std::string & requirement_error ) {
            return pimpl_->item_content.validate_scaled_requirement_set(
                       requirements, requirement_error );
        };
        if( !pimpl_->creatures.validate(
                owner_runtime, check_engine_state, creatures_index, error ) ) {
            return false;
        }
        character_content_validation_index character_index;
        character_index.defines_item = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_item( id );
        };
        character_index.defines_item_group = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_item_group( id );
        };
        character_index.defines_skill = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_skill( id );
        };
        character_index.defines_proficiency = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_proficiency( id );
        };
        character_index.defines_recipe = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_recipe( id );
        };
        character_index.defines_requirement = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_requirement( id );
        };
        character_index.defines_material = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_material( id );
        };
        character_index.defines_json_flag = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_json_flag( id );
        };
        character_index.defines_damage_type = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_damage_type( id );
        };
        character_index.defines_vitamin = [this]( const std::string_view id ) {
            return pimpl_->item_content.defines_vitamin( id );
        };
        character_index.defines_weapon_category = [&staged_items]( const std::string_view id ) {
            return staged_items.weapon_categories.count( std::string( id ) ) != 0;
        };
        character_index.defines_monster = [this]( const std::string_view id ) {
            return pimpl_->creatures.defines_monster( id );
        };
        character_index.defines_species = [this]( const std::string_view id ) {
            return pimpl_->creatures.defines_species( id );
        };
        character_index.defines_body_part = [this]( const std::string_view id ) {
            return pimpl_->creatures.defines_body_part( id );
        };
        character_index.defines_body_graph = [this]( const std::string_view id ) {
            return pimpl_->creatures.defines_body_graph( id );
        };
        character_index.defines_effect_type = [this]( const std::string_view id ) {
            return pimpl_->creatures.defines_effect_type( id );
        };
        character_index.defines_emission = [this]( const std::string_view id ) {
            return pimpl_->creatures.defines_emission( id );
        };
        character_index.defines_field_type = [this]( const std::string_view id ) {
            return pimpl_->creatures.defines_field_type( id );
        };
        character_index.defines_trait = [this]( const std::string_view id ) {
            return pimpl_->creatures.defines_mutation( id );
        };
        character_index.defines_addiction = [this]( const std::string_view id ) {
            return std::any_of( pimpl_->addiction_types.begin(), pimpl_->addiction_types.end(),
            [id]( const addiction_type_registration & entry ) {
                return entry.definition->id == id;
            } );
        };
        character_index.defines_achievement = [this]( const std::string_view id ) {
            return std::any_of( pimpl_->achievements.begin(), pimpl_->achievements.end(),
            [id]( const achievement_registration & entry ) {
                return entry.definition->id == id;
            } );
        };
        character_index.defines_trait_group = [this]( const std::string_view id ) {
            return std::any_of( pimpl_->trait_groups.begin(), pimpl_->trait_groups.end(),
            [id]( const trait_group_registration & entry ) {
                return entry.definition->id == id;
            } );
        };
        character_index.defines_attack_vector = [this]( const std::string_view id ) {
            return std::any_of( pimpl_->attack_vectors.begin(), pimpl_->attack_vectors.end(),
            [id]( const attack_vector_registration & entry ) {
                return entry.definition->id == id;
            } );
        };
        character_index.defines_explosion_light = [this]( const std::string_view id ) {
            return std::any_of( pimpl_->explosion_lights.begin(), pimpl_->explosion_lights.end(),
            [id]( const explosion_light_registration & entry ) {
                return entry.definition->id == id;
            } );
        };
        character_index.defines_limb_score = [this]( const std::string_view id ) {
            return std::any_of( pimpl_->limb_scores.begin(), pimpl_->limb_scores.end(),
            [id]( const limb_score_registration & entry ) {
                return entry.definition->id == id;
            } );
        };
        if( !pimpl_->character.validate(
                owner_runtime, check_engine_state, character_index, error ) ) {
            return false;
        }

        std::set<std::string> bash_damage_profile_ids;
        for( const bash_damage_profile_registration &entry :
             pimpl_->bash_damage_profiles ) {
            const bash_damage_profile_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "bash damage profile" );
            if( !bash_damage_profile_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "bash damage profile '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            for( const auto &[damage_id, multiplier] : definition.factors ) {
                if( damage_id.empty() || !std::isfinite( multiplier ) || multiplier < 0.0 ) {
                    throw std::runtime_error( "bash damage profile '" + definition.id +
                                              "' has an invalid factor" );
                }
                if( check_engine_state && damage_type_ids.count( damage_id ) == 0 &&
                    !damage_type_id( damage_id ).is_valid() ) {
                    throw std::runtime_error( "bash damage profile '" + definition.id +
                                              "' references unknown damage type '" +
                                              damage_id + "'" );
                }
            }
            validate_operation( entry.operation,
                                bash_damage_profile_id( definition.id ).is_valid(),
                                definition.id, "bash damage profile" );
        }

        const auto staged_morale_type = [this]( const std::string & id ) {
            return pimpl_->creatures.defines_morale_type( id );
        };

        std::set<std::string> clothing_mod_ids;
        for( const clothing_mod_registration &entry : pimpl_->clothing_mods ) {
            const clothing_mod_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "clothing modification" );
            if( definition.flag.empty() || definition.material_item.empty() ||
                definition.apply_prompt.empty() || definition.remove_prompt.empty() ||
                definition.modifiers.empty() ||
                !clothing_mod_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "clothing modification '" + definition.id +
                                          "' requires flag, material item, prompts, modifiers, and one registration" );
            }
            if( check_engine_state && json_flag_ids.count( definition.flag ) == 0 &&
                !flag_id( definition.flag ).is_valid() ) {
                throw std::runtime_error( "clothing modification '" + definition.id +
                                          "' references unknown flag '" + definition.flag + "'" );
            }
            if( check_engine_state && declared_item_ids.count( definition.material_item ) == 0 &&
                !item::type_is_defined( itype_id( definition.material_item ) ) ) {
                throw std::runtime_error( "clothing modification '" + definition.id +
                                          "' references unknown material item '" +
                                          definition.material_item + "'" );
            }
            static const std::set<std::string> valid_stats = {
                "acid", "fire", "bash", "cut", "bullet", "encumbrance", "warmth"
            };
            for( const clothing_modifier_definition_data &modifier : definition.modifiers ) {
                if( valid_stats.count( modifier.stat ) == 0 ||
                    !std::isfinite( modifier.amount ) ) {
                    throw std::runtime_error( "clothing modification '" + definition.id +
                                              "' has an invalid modifier" );
                }
            }
            validate_operation( entry.operation, clothing_mod_id( definition.id ).is_valid(),
                                definition.id, "clothing modification" );
        }

        std::set<std::string> land_use_code_ids;
        for( const overmap_land_use_code_registration &entry :
             pimpl_->overmap_land_use_codes ) {
            const overmap_land_use_code_definition_data &definition = *entry.definition;
            // The legacy registry holds a real null entry (empty id, code 0)
            // meaning "no land use"; it is migrated verbatim and must stay
            // valid rather than being rejected as an invalid id.
            const bool legacy_null_entry =
                definition.id.empty() && definition.code == 0;
            if( !legacy_null_entry ) {
                require_valid_id( definition.id, "overmap land-use code" );
            }
            if( definition.code < std::numeric_limits<int>::min() ||
                definition.code > std::numeric_limits<int>::max() ||
                ( !legacy_null_entry && definition.name.empty() ) ||
                definition.symbol == 0 ||
                definition.color.empty() ||
                color_from_string( definition.color, report_color_error::no ) == c_unset ||
                !land_use_code_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "overmap land-use code '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            validate_operation( entry.operation,
                                overmap_land_use_code_id( definition.id ).is_valid(),
                                definition.id, "overmap land-use code" );
        }

        std::set<std::string> overmap_vision_ids;
        for( const overmap_vision_registration &entry : pimpl_->overmap_visions ) {
            const overmap_vision_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "overmap vision" );
            if( definition.id.find( '$' ) != std::string::npos ||
                !overmap_vision_ids.insert( definition.id ).second ||
                definition.levels.size() > 3 ) {
                throw std::runtime_error( "overmap vision '" + definition.id +
                                          "' has an invalid id, too many levels, or a duplicate registration" );
            }
            for( const overmap_vision_level_definition_data &level : definition.levels ) {
                if( level.blends_adjacent ) {
                    continue;
                }
                if( level.name.empty() || level.symbol == 0 || level.color.empty() ||
                    color_from_string( level.color,
                                       report_color_error::no ) == c_unset ) {
                    throw std::runtime_error( "overmap vision '" + definition.id +
                                              "' has an invalid appearance level" );
                }
            }
            validate_operation( entry.operation,
                                oter_vision_id( definition.id ).is_valid(),
                                definition.id, "overmap vision" );
        }

        std::set<std::string> overmap_location_ids;
        for( const overmap_location_registration &entry : pimpl_->overmap_locations ) {
            const overmap_location_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "overmap location" );
            if( !overmap_location_ids.insert( definition.id ).second ||
                ( definition.terrains.empty() && definition.terrain_flags.empty() ) ) {
                throw std::runtime_error( "overmap location '" + definition.id +
                                          "' needs a unique id and at least one terrain selector" );
            }
            std::set<std::string> selectors;
            for( const std::string &terrain : definition.terrains ) {
                if( !selectors.insert( "terrain:" + terrain ).second ||
                    ( check_engine_state && !oter_type_str_id( terrain ).is_valid() ) ) {
                    throw std::runtime_error( "overmap location '" + definition.id +
                                              "' has an unknown or duplicate terrain '" + terrain + "'" );
                }
            }
            const std::unordered_map<std::string, oter_flags> &oter_flags_map =
                io::get_enum_lookup_map<oter_flags>();
            for( const std::string &flag : definition.terrain_flags ) {
                if( !selectors.insert( "flag:" + flag ).second ||
                    oter_flags_map.count( flag ) == 0 ) {
                    throw std::runtime_error( "overmap location '" + definition.id +
                                              "' has an unknown or duplicate terrain flag '" + flag + "'" );
                }
            }
            validate_operation( entry.operation,
                                overmap_location_id( definition.id ).is_valid(),
                                definition.id, "overmap location" );
        }

        std::set<std::string> map_extra_collection_ids;
        for( const map_extra_collection_registration &entry : pimpl_->map_extra_collections ) {
            const map_extra_collection_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "map-extra collection" );
            if( !map_extra_collection_ids.insert( definition.id ).second ||
                definition.chance < 0 ||
                static_cast<std::uint64_t>( definition.chance ) >
                std::numeric_limits<unsigned int>::max() || definition.entries.empty() ) {
                throw std::runtime_error( "map-extra collection '" + definition.id +
                                          "' has an invalid chance, no entries, or a duplicate id" );
            }
            std::set<std::string> extras;
            for( const auto &[extra, weight] : definition.entries ) {
                if( !extras.insert( extra ).second || weight <= 0 ||
                    weight > std::numeric_limits<int>::max() ||
                    ( check_engine_state && !map_extra_id( extra ).is_valid() ) ) {
                    throw std::runtime_error( "map-extra collection '" + definition.id +
                                              "' has an unknown, duplicate, or invalidly weighted entry '" +
                                              extra + "'" );
                }
            }
            validate_operation( entry.operation,
                                map_extra_collection_id( definition.id ).is_valid(),
                                definition.id, "map-extra collection" );
        }

        std::set<std::string> vehicle_group_ids;
        for( const vehicle_group_registration &entry : pimpl_->vehicle_groups ) {
            const vehicle_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "vehicle group" );
            if( !vehicle_group_ids.insert( definition.id ).second || definition.entries.empty() ) {
                throw std::runtime_error( "vehicle group '" + definition.id +
                                          "' needs a unique id and at least one vehicle" );
            }
            // Duplicate entries are legal legacy weighted-list semantics:
            // each entry contributes its own weight to the accumulated total.
            for( const auto &[vehicle, weight] : definition.entries ) {
                if( weight <= 0 ||
                    weight > std::numeric_limits<int>::max() ||
                    ( check_engine_state && !vproto_id( vehicle ).is_valid() ) ) {
                    throw std::runtime_error( "vehicle group '" + definition.id +
                                              "' has an unknown or invalidly weighted vehicle '" +
                                              vehicle + "'" );
                }
            }
            validate_operation( entry.operation,
                                detail::vehicle_group_registry_find( definition.id ) != nullptr,
                                definition.id, "vehicle group" );
        }

        std::set<std::string> vehicle_placement_ids;
        for( const vehicle_placement_registration &entry : pimpl_->vehicle_placements ) {
            const vehicle_placement_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "vehicle placement" );
            if( !vehicle_placement_ids.insert( definition.id ).second ||
                definition.locations.empty() ) {
                throw std::runtime_error( "vehicle placement '" + definition.id +
                                          "' needs a unique id and at least one location" );
            }
            for( const vehicle_placement_location_definition_data &location :
                 definition.locations ) {
                const auto valid_coordinate = []( const std::int64_t value ) {
                    return value >= std::numeric_limits<std::int16_t>::min() &&
                           value <= std::numeric_limits<std::int16_t>::max();
                };
                if( !valid_coordinate( location.x_min ) ||
                    !valid_coordinate( location.x_max ) ||
                    !valid_coordinate( location.y_min ) ||
                    !valid_coordinate( location.y_max ) ||
                    location.x_min > location.x_max || location.y_min > location.y_max ||
                    location.facings.empty() || location.facings.size() > 64 ||
                    std::any_of( location.facings.begin(), location.facings.end(),
                []( const std::int64_t facing ) {
                return facing < std::numeric_limits<int>::min() ||
                           facing > std::numeric_limits<int>::max();
                } ) ) {
                    throw std::runtime_error( "vehicle placement '" + definition.id +
                                              "' has an invalid location" );
                }
            }
            validate_operation(
                entry.operation,
                detail::vehicle_placement_registry_find( definition.id ) != nullptr,
                definition.id, "vehicle placement" );
        }

        std::set<std::string> vehicle_spawn_ids;
        for( const vehicle_spawn_registration &entry : pimpl_->vehicle_spawns ) {
            const vehicle_spawn_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "vehicle spawn" );
            if( !vehicle_spawn_ids.insert( definition.id ).second ||
                definition.entries.empty() || definition.entries.size() > 1024 ) {
                throw std::runtime_error( "vehicle spawn '" + definition.id +
                                          "' needs a unique id and bounded entries" );
            }
            for( const vehicle_spawn_entry_definition_data &spawn : definition.entries ) {
                if( !std::isfinite( spawn.weight ) || spawn.weight <= 0.0 ) {
                    throw std::runtime_error( "vehicle spawn '" + definition.id +
                                              "' has an invalid weight" );
                }
                if( spawn.builtin ) {
                    if( spawn.builtin_id.empty() ||
                        !VehicleSpawn::has_builtin( spawn.builtin_id ) ) {
                        throw std::runtime_error( "vehicle spawn '" + definition.id +
                                                  "' references an unknown builtin" );
                    }
                    continue;
                }
                if( spawn.vehicle_group.empty() ||
                    ( check_engine_state &&
                      vehicle_group_ids.count( spawn.vehicle_group ) == 0 &&
                      detail::vehicle_group_registry_find( spawn.vehicle_group ) == nullptr ) ||
                    spawn.number_min < 0 || spawn.number_max < spawn.number_min ||
                    spawn.number_max > std::numeric_limits<std::int16_t>::max() ||
                    spawn.fuel < std::numeric_limits<int>::min() ||
                    spawn.fuel > std::numeric_limits<int>::max() ||
                    spawn.status < std::numeric_limits<int>::min() ||
                    spawn.status > std::numeric_limits<int>::max() ||
                    ( spawn.placement.empty() == !spawn.location.has_value() ) ) {
                    throw std::runtime_error( "vehicle spawn '" + definition.id +
                                              "' has an invalid vehicle entry" );
                }
                if( !spawn.placement.empty() &&
                    spawn.placement.find( "%t" ) == std::string::npos &&
                    check_engine_state &&
                    vehicle_placement_ids.count( spawn.placement ) == 0 &&
                    detail::vehicle_placement_registry_find( spawn.placement ) == nullptr ) {
                    throw std::runtime_error( "vehicle spawn '" + definition.id +
                                              "' references unknown placement '" +
                                              spawn.placement + "'" );
                }
                if( spawn.location ) {
                    const vehicle_placement_location_definition_data &location = *spawn.location;
                    const auto valid_coordinate = []( const std::int64_t value ) {
                        return value >= std::numeric_limits<std::int16_t>::min() &&
                               value <= std::numeric_limits<std::int16_t>::max();
                    };
                    if( !valid_coordinate( location.x_min ) ||
                        !valid_coordinate( location.x_max ) ||
                        !valid_coordinate( location.y_min ) ||
                        !valid_coordinate( location.y_max ) ||
                        location.x_min > location.x_max ||
                        location.y_min > location.y_max ||
                        location.facings.empty() || location.facings.size() > 64 ||
                        std::any_of( location.facings.begin(), location.facings.end(),
                    []( const std::int64_t facing ) {
                    return facing < std::numeric_limits<int>::min() ||
                               facing > std::numeric_limits<int>::max();
                    } ) ) {
                        throw std::runtime_error( "vehicle spawn '" + definition.id +
                                                  "' has an invalid explicit location" );
                    }
                }
            }
            validate_operation(
                entry.operation,
                detail::vehicle_spawn_registry_find( definition.id ) != nullptr,
                definition.id, "vehicle spawn" );
        }

        std::set<std::string> fault_group_ids;
        for( const fault_group_registration &entry : pimpl_->fault_groups ) {
            const fault_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "fault group" );
            if( !fault_group_ids.insert( definition.id ).second || definition.entries.empty() ) {
                throw std::runtime_error( "fault group '" + definition.id +
                                          "' needs a unique id and at least one fault" );
            }
            // Duplicate entries are legal legacy weighted-list semantics:
            // each entry contributes its own weight to the accumulated total.
            for( const auto &[fault, weight] : definition.entries ) {
                if( weight <= 0 ||
                    weight > std::numeric_limits<int>::max() ||
                    ( check_engine_state && !fault_id( fault ).is_valid() ) ) {
                    throw std::runtime_error( "fault group '" + definition.id +
                                              "' has an unknown or invalidly weighted fault '" +
                                              fault + "'" );
                }
            }
            validate_operation( entry.operation, fault_group_id( definition.id ).is_valid(),
                                definition.id, "fault group" );
        }

        std::set<std::string> explosion_light_ids;
        for( const explosion_light_registration &entry : pimpl_->explosion_lights ) {
            const explosion_light_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "explosion light" );
            const auto finite_non_negative = []( const double value ) {
                return std::isfinite( value ) && value >= 0.0 &&
                       value <= std::numeric_limits<float>::max();
            };
            if( !explosion_light_ids.insert( definition.id ).second ||
                definition.stops.empty() || !platform_vfx_easing( definition.easing ) ||
                !finite_non_negative( definition.wave_travel ) ||
                !finite_non_negative( definition.wave_gap ) ||
                !finite_non_negative( definition.rise ) ||
                !finite_non_negative( definition.fade ) ||
                !finite_non_negative( definition.blend ) ||
                !finite_non_negative( definition.spread_jitter ) ||
                !finite_non_negative( definition.color_jitter ) ||
                !finite_non_negative( definition.flicker ) ||
                !finite_non_negative( definition.duration_base_ms ) ||
                !finite_non_negative( definition.duration_per_tile_ms ) ||
                !finite_non_negative( definition.duration_min_ms ) ||
                definition.duration_min_ms <= 0.0 ||
                !finite_non_negative( definition.duration_max_ms ) ||
                definition.duration_max_ms < definition.duration_min_ms ||
                !finite_non_negative( definition.screen_shake_magnitude ) ||
                !finite_non_negative( definition.screen_shake_duration_ms ) ||
                !finite_non_negative( definition.shockwave_strength ) ||
                !std::isfinite( definition.shockwave_speed ) ||
                definition.shockwave_speed <= 0.0 ||
                definition.shockwave_speed > std::numeric_limits<float>::max() ||
                !finite_non_negative( definition.shockwave_thickness ) ) {
                throw std::runtime_error( "explosion light '" + definition.id +
                                          "' has invalid stops, timing, easing, shake, or shockwave values" );
            }
            validate_operation( entry.operation,
                                explosion_light_str_id( definition.id ).is_valid(),
                                definition.id, "explosion light" );
        }


        std::set<std::string> addiction_type_ids;
        for( const addiction_type_registration &entry : pimpl_->addiction_types ) {
            const addiction_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "addiction type" );
            if( !addiction_type_ids.insert( definition.id ).second ||
                definition.name.empty() || definition.type_name.empty() ||
                definition.description.empty() || definition.tick_handler.empty() ||
                ( check_engine_state && !definition.craving_morale.empty() &&
                  !staged_morale_type( definition.craving_morale ) &&
                  !morale_type( definition.craving_morale ).is_valid() ) ) {
                throw std::runtime_error( "addiction type '" + definition.id +
                                          "' needs unique text, an optional valid craving morale, and a tick policy" );
            }
            if( owner_runtime.handlers.count( definition.tick_handler ) == 0 ) {
                throw std::runtime_error( "addiction type '" + definition.id +
                                          "' references missing tick handler '" +
                                          definition.tick_handler + "'" );
            }
            validate_operation( entry.operation, addiction_id( definition.id ).is_valid(),
                                definition.id, "addiction type" );
        }

        std::set<std::string> character_modifier_ids;
        for( const character_modifier_registration &entry : pimpl_->character_modifiers ) {
            const character_modifier_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "character modifier" );
            if( !character_modifier_ids.insert( definition.id ).second ||
                definition.description.empty() ||
                ( definition.operation != "add" && definition.operation != "multiply" &&
                  definition.operation != "none" ) ||
                definition.evaluator_handler.empty() ) {
                throw std::runtime_error( "character modifier '" + definition.id +
                                          "' needs a unique id, description, operation, and evaluator" );
            }
            if( owner_runtime.handlers.count( definition.evaluator_handler ) == 0 ) {
                throw std::runtime_error( "character modifier '" + definition.id +
                                          "' references missing evaluator '" +
                                          definition.evaluator_handler + "'" );
            }
            validate_operation( entry.operation,
                                character_modifier_id( definition.id ).is_valid(),
                                definition.id, "character modifier" );
        }

        std::set<std::string> start_location_ids;
        for( const start_location_registration &entry : pimpl_->start_locations ) {
            const start_location_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "start location" );
            const auto native_bound = []( const std::int64_t value ) {
                return value >= std::numeric_limits<int>::min() &&
                       value <= std::numeric_limits<int>::max();
            };
            if( !start_location_ids.insert( definition.id ).second ||
                definition.name.empty() ||
                // Legacy allows an empty target set (matches everything via
                // other constraints) and any [min, max] interval pair
                // verbatim (sloc_road uses [10, -1] for "no upper bound").
                !native_bound( definition.city_size_min ) ||
                !native_bound( definition.city_size_max ) ||
                definition.city_size_min < 0 ||
                !native_bound( definition.city_distance_min ) ||
                !native_bound( definition.city_distance_max ) ||
                definition.city_distance_min < 0 ||
                !native_bound( definition.z_min ) || !native_bound( definition.z_max ) ||
                definition.z_min < -OVERMAP_DEPTH || definition.z_max > OVERMAP_HEIGHT ) {
                throw std::runtime_error( "start location '" + definition.id +
                                          "' has invalid text, targets, or placement bounds" );
            }
            std::set<std::string> target_keys;
            for( const start_location_target_definition_data &target : definition.targets ) {
                const std::optional<ot_match_type> match = platform_ot_match_type( target.match );
                std::string key = target.terrain + "\x1f" + target.match;
                for( const auto &[parameter, value] : target.parameters ) {
                    key += "\x1f" + parameter + "=" + value;
                    if( parameter.empty() || value.empty() || parameter.size() > 128 ||
                        value.size() > 512 ) {
                        throw std::runtime_error( "start location '" + definition.id +
                                                  "' has an invalid mapgen parameter" );
                    }
                }
                if( target.terrain.empty() || !match || target.parameters.size() > 64 ||
                    !target_keys.insert( key ).second ||
                    ( check_engine_state && *match == ot_match_type::exact &&
                      !oter_str_id( target.terrain ).is_valid() ) ||
                    ( check_engine_state && *match == ot_match_type::type &&
                      !pimpl_->world.defines_overmap_terrain_type( target.terrain ) &&
                      !oter_type_str_id( target.terrain ).is_valid() ) ) {
                    throw std::runtime_error( "start location '" + definition.id +
                                              "' has an invalid or duplicate terrain selector" );
                }
            }
            validate_operation( entry.operation, start_location_id( definition.id ).is_valid(),
                                definition.id, "start location" );
        }

        std::set<std::string> climbing_aid_ids;
        for( const climbing_aid_registration &entry : pimpl_->climbing_aids ) {
            const climbing_aid_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "climbing aid" );
            const auto native_non_negative = []( const std::int64_t value ) {
                return value >= 0 && value <= std::numeric_limits<int>::max();
            };
            const bool deploys = !definition.deploy_furniture.empty();
            const std::optional<climbing_aid::category> category =
                platform_climbing_category( definition.category );
            if( !climbing_aid_ids.insert( definition.id ).second || !category ||
                definition.slip_chance_modifier < std::numeric_limits<int>::min() ||
                definition.slip_chance_modifier > std::numeric_limits<int>::max() ||
                ( *category != climbing_aid::category::special && definition.flag.empty() ) ||
                !native_non_negative( definition.uses ) ||
                !native_non_negative( definition.range ) ||
                definition.max_height < -1 ||
                definition.max_height > std::numeric_limits<int>::max() ||
                !native_non_negative( definition.easy_climb_back_up ) ||
                ( definition.max_height >= 0 &&
                  ( definition.menu_text.empty() || definition.confirm_text.empty() ) ) ||
                definition.hotkey.size() > 1 ||
                !native_non_negative( definition.pain ) ||
                !native_non_negative( definition.damage ) ||
                !native_non_negative( definition.kilocalories ) ||
                !native_non_negative( definition.thirst ) ||
                ( deploys && ( definition.unavailable_text.empty() ||
                               definition.hotkey.size() != 1 ) ) ||
                ( check_engine_state && deploys &&
                  !furn_str_id( definition.deploy_furniture ).is_valid() ) ) {
                throw std::runtime_error( "climbing aid '" + definition.id +
                                          "' has invalid availability, descent, cost, or deployment data" );
            }
            validate_operation( entry.operation, climbing_aid_id( definition.id ).is_valid(),
                                definition.id, "climbing aid" );
        }

        std::set<std::string> weather_type_ids;
        for( const weather_type_registration &entry : pimpl_->weather_types ) {
            require_valid_id( entry.definition->id, "weather type" );
            if( !weather_type_ids.insert( entry.definition->id ).second ) {
                throw std::runtime_error( "weather type '" + entry.definition->id +
                                          "' is registered more than once" );
            }
        }
        for( const weather_type_registration &entry : pimpl_->weather_types ) {
            const weather_type_definition_data &definition = *entry.definition;
            const auto native_int = []( const std::int64_t value ) {
                return value >= std::numeric_limits<int>::min() &&
                       value <= std::numeric_limits<int>::max();
            };
            const auto finite_float = []( const double value ) {
                return std::isfinite( value ) &&
                       std::abs( value ) <= std::numeric_limits<float>::max();
            };
            const auto single_codepoint = []( const std::string & symbol ) {
                if( symbol.empty() ) {
                    return false;
                }
                const std::uint32_t codepoint = UTF8_getch( symbol );
                return codepoint != UNKNOWN_UNICODE && utf32_to_utf8( codepoint ) == symbol;
            };
            if( definition.name.empty() ||
                color_from_string( definition.color, report_color_error::no ) == c_unset ||
                color_from_string( definition.map_color, report_color_error::no ) == c_unset ||
                !single_codepoint( definition.symbol ) ||
                !single_codepoint( definition.sun_symbol ) ||
                !native_int( definition.ranged_penalty ) ||
                !finite_float( definition.sight_penalty ) || definition.sight_penalty < 0.0 ||
                !native_int( definition.light_modifier ) ||
                !finite_float( definition.temperature_delta_kelvin ) ||
                !finite_float( definition.light_multiplier ) ||
                definition.light_multiplier < 0.0 ||
                !finite_float( definition.sun_multiplier ) ||
                definition.sun_multiplier < 0.0 ||
                !native_int( definition.sound_attenuation ) ||
                !platform_precipitation( definition.precipitation ) ||
                !platform_weather_sound_category( definition.sound_category ) ||
                !native_int( definition.priority ) ||
                definition.minimum_duration_turns <= 0 ||
                definition.minimum_duration_turns > std::numeric_limits<int>::max() ||
                definition.maximum_duration_turns < definition.minimum_duration_turns ||
                definition.maximum_duration_turns > std::numeric_limits<int>::max() ||
                definition.condition_handler.empty() ||
                ( definition.has_animation &&
                  ( !finite_float( definition.animation_factor ) ||
                    definition.animation_factor < 0.0 ||
                    color_from_string( definition.animation_color,
                                       report_color_error::no ) == c_unset ||
                    !single_codepoint( definition.animation_symbol ) ) ) ) {
                throw std::runtime_error( "weather type '" + definition.id +
                                          "' has invalid presentation, physics, timing, or condition data" );
            }
            if( owner_runtime.handlers.count( definition.condition_handler ) == 0 ) {
                throw std::runtime_error( "weather type '" + definition.id +
                                          "' references missing condition handler '" +
                                          definition.condition_handler + "'" );
            }
            std::set<std::string> required;
            for( const std::string &weather : definition.required_weathers ) {
                if( weather.empty() || !required.insert( weather ).second ||
                    ( check_engine_state && weather_type_ids.count( weather ) == 0 &&
                      !weather_type_id( weather ).is_valid() ) ) {
                    throw std::runtime_error( "weather type '" + definition.id +
                                              "' has an unknown or duplicate prerequisite" );
                }
            }
            for( const weather_passive_effect_definition_data &effect : definition.passive_effects ) {
                const auto chance = []( const std::int64_t value ) {
                    return value >= 0 && value <= 100;
                };
                if( effect.effect.empty() || effect.minimum_duration_turns <= 0 ||
                    effect.minimum_duration_turns > std::numeric_limits<int>::max() ||
                    effect.maximum_duration_turns < effect.minimum_duration_turns ||
                    effect.maximum_duration_turns > std::numeric_limits<int>::max() ||
                    effect.intensity <= 0 ||
                    effect.intensity > std::numeric_limits<int>::max() ||
                    !chance( effect.chance_in_vehicle ) ||
                    !chance( effect.chance_inside_vehicle ) ||
                    !chance( effect.chance_outside_vehicle ) ||
                    ( check_engine_state && !efftype_id( effect.effect ).is_valid() ) ||
                    ( check_engine_state && !effect.body_part.empty() &&
                      !bodypart_str_id( effect.body_part ).is_valid() ) ) {
                    throw std::runtime_error( "weather type '" + definition.id +
                                              "' has an invalid passive character effect" );
                }
            }
            validate_operation( entry.operation, weather_type_id( definition.id ).is_valid(),
                                definition.id, "weather type" );
        }

        std::set<std::string> event_transformation_ids;
        for( const event_transformation_registration &entry : pimpl_->event_transformations ) {
            require_valid_id( entry.definition->id, "event transformation" );
            if( !event_transformation_ids.insert( entry.definition->id ).second ) {
                throw std::runtime_error( "event transformation '" + entry.definition->id +
                                          "' is registered more than once" );
            }
        }
        std::set<std::string> event_statistic_ids;
        for( const event_statistic_registration &entry : pimpl_->event_statistics ) {
            require_valid_id( entry.definition->id, "event statistic" );
            if( !event_statistic_ids.insert( entry.definition->id ).second ) {
                throw std::runtime_error( "event statistic '" + entry.definition->id +
                                          "' is registered more than once" );
            }
        }
        const auto validate_event_source =
            [&]( const detail::event_source_native_definition & source,
        const std::string & owner ) {
            require_valid_id( source.id, "event source" );
            if( source.kind == "event_type" ) {
                if( !io::enum_is_valid<event_type>( source.id ) ) {
                    throw std::runtime_error( owner + " references unknown event type '" +
                                              source.id + "'" );
                }
                return;
            }
            if( source.kind != "event_transformation" ||
                ( check_engine_state && event_transformation_ids.count( source.id ) == 0 &&
                  !string_id<event_transformation>( source.id ).is_valid() ) ) {
                throw std::runtime_error( owner + " references unknown event transformation '" +
                                          source.id + "'" );
            }
        };

        for( const event_transformation_registration &entry : pimpl_->event_transformations ) {
            const event_transformation_definition_data &definition = *entry.definition;
            const std::string owner = "event transformation '" + definition.id + "'";
            validate_event_source( definition.source, owner );
            if( definition.new_fields.empty() && definition.constraints.empty() &&
                definition.drop_fields.empty() ) {
                throw std::runtime_error( owner + " cannot be a no-op" );
            }
            if( definition.new_fields.size() > 128 || definition.constraints.size() > 256 ||
                definition.drop_fields.size() > 128 ) {
                throw std::runtime_error( owner + " exceeds the Platform field limit" );
            }
            std::set<std::string> output_fields;
            for( const detail::event_new_field_native_definition &field :
                 definition.new_fields ) {
                require_valid_id( field.field, "derived event field" );
                require_valid_id( field.input_field, "source event field" );
                if( !output_fields.insert( field.field ).second ||
                    event_field_transformations.count( field.transformation ) == 0 ) {
                    throw std::runtime_error( owner +
                                              " has a duplicate field or unknown field transformation" );
                }
            }
            std::set<std::string> constrained_fields;
            for( const detail::event_value_constraint_native_definition &constraint :
                 definition.constraints ) {
                require_valid_id( constraint.field, "constrained event field" );
                if( !constrained_fields.insert( constraint.field ).second ) {
                    throw std::runtime_error( owner +
                                              " constrains the same field more than once" );
                }
                if( constraint.kind == "equals_statistic" ) {
                    require_valid_id( constraint.statistic, "event statistic reference" );
                    if( !constraint.values.empty() || !constraint.value_type.empty() ||
                        ( check_engine_state &&
                          event_statistic_ids.count( constraint.statistic ) == 0 &&
                          !event_statistic_id( constraint.statistic ).is_valid() ) ) {
                        throw std::runtime_error( owner +
                                                  " has an invalid statistic constraint" );
                    }
                    continue;
                }
                const bool equality = constraint.kind == "equals" ||
                                      constraint.kind == "equals_any";
                const bool ordered = constraint.kind == "lt" || constraint.kind == "lteq" ||
                                     constraint.kind == "gteq" || constraint.kind == "gt";
                if( ( !equality && !ordered ) || constraint.values.empty() ||
                    constraint.values.size() > 256 ||
                    ( constraint.kind == "equals" && constraint.values.size() != 1 ) ||
                    ( ordered && ( constraint.values.size() != 1 ||
                                   constraint.value_type != "int" ) ) ||
                    ( equality && !io::enum_is_valid<cata_variant_type>(
                          constraint.value_type ) ) ) {
                    throw std::runtime_error( owner + " has an invalid value constraint" );
                }
                for( const std::string &value : constraint.values ) {
                    if( value.size() > 4096 || value.find( '\0' ) != std::string::npos ) {
                        throw std::runtime_error( owner +
                                                  " has an oversized constraint value" );
                    }
                }
            }
            std::set<std::string> dropped_fields;
            for( const std::string &field : definition.drop_fields ) {
                require_valid_id( field, "dropped event field" );
                if( !dropped_fields.insert( field ).second ) {
                    throw std::runtime_error( owner + " drops the same field more than once" );
                }
            }
            validate_operation(
                entry.operation,
                string_id<event_transformation>( definition.id ).is_valid(),
                definition.id, "event transformation" );
        }

        static const std::set<std::string> event_statistic_types = {
            "count", "total", "minimum", "maximum", "unique_value",
            "first_value", "last_value"
        };
        for( const event_statistic_registration &entry : pimpl_->event_statistics ) {
            const event_statistic_definition_data &definition = *entry.definition;
            const std::string owner = "event statistic '" + definition.id + "'";
            validate_event_source( definition.source, owner );
            const bool count = definition.statistic_type == "count";
            if( event_statistic_types.count( definition.statistic_type ) == 0 ||
                ( count && !definition.field.empty() ) ||
                ( !count && definition.field.empty() ) ||
                definition.field.size() > 256 || definition.description.size() > 4096 ||
                definition.description_plural.size() > 4096 ) {
                throw std::runtime_error( owner + " has invalid summary or description data" );
            }
            validate_operation( entry.operation,
                                event_statistic_id( definition.id ).is_valid(),
                                definition.id, "event statistic" );
        }

        std::set<std::string> relic_procgen_ids;
        for( const relic_procgen_registration &entry : pimpl_->relic_procgens ) {
            const relic_procgen_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "relic procgen" );
            if( !relic_procgen_ids.insert( definition.id ).second ||
                definition.type_weights.empty() || definition.item_weights.empty() ) {
                throw std::runtime_error( "relic procgen '" + definition.id +
                                          "' requires unique id, type weights, and items" );
            }
            const auto native_int = []( const std::int64_t value ) {
                return value >= std::numeric_limits<int>::min() &&
                       value <= std::numeric_limits<int>::max();
            };
            const auto positive_weight = [&native_int]( const std::int64_t value ) {
                return native_int( value ) && value > 0;
            };
            const auto native_float = []( const double value ) {
                return std::isfinite( value ) &&
                       std::abs( value ) <= std::numeric_limits<float>::max();
            };
            for( const relic_procgen_passive_definition_data &value :
                 definition.passive_values ) {
                if( ( value.kind != "passive_enchantment_add" &&
                      value.kind != "passive_enchantment_mult" ) ||
                    !io::enum_is_valid<enchant_vals::mod>( value.type ) ||
                    !positive_weight( value.weight ) ||
                    !native_int( value.power_per_increment ) ||
                    value.power_per_increment == 0 || !native_float( value.increment ) ||
                    value.increment == 0.0 || !native_float( value.minimum ) ||
                    !native_float( value.maximum ) || value.minimum > value.maximum ||
                    !io::enum_is_valid<enchantment::has>( value.has ) ) {
                    throw std::runtime_error( "relic procgen '" + definition.id +
                                              "' has an invalid passive value" );
                }
            }
            for( const relic_procgen_active_definition_data &value :
                 definition.active_values ) {
                require_valid_id( value.spell, "relic procgen spell" );
                if( ( value.kind != "active_enchantment" && value.kind != "hit_you" &&
                      value.kind != "hit_me" ) || !positive_weight( value.weight ) ||
                    !native_int( value.base_power ) ||
                    !native_int( value.power_per_increment ) ||
                    !native_int( value.increment ) || value.increment == 0 ||
                    !native_int( value.minimum_level ) || !native_int( value.maximum_level ) ||
                    value.minimum_level > value.maximum_level ||
                    !io::enum_is_valid<enchantment::has>( value.has ) ||
                    ( check_engine_state && !spell_id( value.spell ).is_valid() ) ) {
                    throw std::runtime_error( "relic procgen '" + definition.id +
                                              "' has an invalid active spell value" );
                }
            }
            for( const auto &[kind, weight] : definition.type_weights ) {
                if( !io::enum_is_valid<relic_procgen_data::type>( kind ) ||
                    !positive_weight( weight ) ) {
                    throw std::runtime_error( "relic procgen '" + definition.id +
                                              "' has an invalid type weight" );
                }
            }
            for( const auto &[item_id, weight] : definition.item_weights ) {
                require_valid_id( item_id, "relic procgen item" );
                if( !positive_weight( weight ) ||
                    ( check_engine_state && declared_item_ids.count( item_id ) == 0 &&
                      !item::type_is_defined( itype_id( item_id ) ) ) ) {
                    throw std::runtime_error( "relic procgen '" + definition.id +
                                              "' has an invalid item weight" );
                }
            }
            for( const relic_procgen_charge_definition_data &value : definition.charges ) {
                if( !positive_weight( value.weight ) ||
                    !native_int( value.initial_minimum ) ||
                    !native_int( value.initial_maximum ) ||
                    value.initial_minimum > value.initial_maximum ||
                    !native_int( value.use_minimum ) || !native_int( value.use_maximum ) ||
                    value.use_minimum > value.use_maximum ||
                    !native_int( value.maximum_minimum ) ||
                    !native_int( value.maximum_maximum ) ||
                    value.maximum_minimum > value.maximum_maximum ||
                    !native_int( value.time_minimum_turns ) ||
                    !native_int( value.time_maximum_turns ) ||
                    value.time_minimum_turns < 0 ||
                    value.time_minimum_turns > value.time_maximum_turns ||
                    !native_int( value.power ) ||
                    !io::enum_is_valid<relic_recharge_type>( value.recharge_type ) ) {
                    throw std::runtime_error( "relic procgen '" + definition.id +
                                              "' has an invalid charge template" );
                }
            }
            validate_operation( entry.operation,
                                relic_procgen_id( definition.id ).is_valid(),
                                definition.id, "relic procgen" );
        }

        const std::set<std::string> presentation_field_type_ids =
            pimpl_->creatures.staged_field_type_ids();
        std::set<std::string> presentation_ascii_art_ids;
        for( const ascii_art_registration &entry : pimpl_->ascii_arts ) {
            presentation_ascii_art_ids.insert( entry.definition->id );
        }
        if( !pimpl_->presentation.validate(
                owner_runtime, check_engine_state, event_statistic_ids,
                presentation_field_type_ids, presentation_ascii_art_ids, error ) ) {
            return false;
        }

        std::set<std::string> attack_vector_ids;
        for( const attack_vector_registration &entry : pimpl_->attack_vectors ) {
            const attack_vector_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "attack vector" );
            if( !attack_vector_ids.insert( definition.id ).second ||
                definition.encumbrance_limit < 0 ||
                definition.encumbrance_limit > std::numeric_limits<int>::max() ||
                definition.health_percent_limit < 0 ||
                definition.health_percent_limit > 100 ||
                ( !definition.weapon && definition.limbs.empty() ) ) {
                throw std::runtime_error( "attack vector '" + definition.id +
                                          "' has invalid limits, anatomy, or a duplicate registration" );
            }
            std::set<std::string> limbs;
            for( const std::string &limb : definition.limbs ) {
                if( !limbs.insert( limb ).second || !bodypart_str_id( limb ).is_valid() ) {
                    throw std::runtime_error( "attack vector '" + definition.id +
                                              "' references an invalid or duplicate limb '" +
                                              limb + "'" );
                }
            }
            std::set<std::string> contacts;
            for( const std::string &contact : definition.contacts ) {
                if( !contacts.insert( contact ).second ||
                    !sub_bodypart_str_id( contact ).is_valid() ) {
                    throw std::runtime_error( "attack vector '" + definition.id +
                                              "' references an invalid or duplicate contact '" +
                                              contact + "'" );
                }
            }
            for( const auto &[kind, count] : definition.limb_requirements ) {
                if( !io::enum_is_valid<bp_type>( kind ) || count <= 0 ||
                    count > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "attack vector '" + definition.id +
                                              "' has an invalid limb requirement" );
                }
            }
            for( const std::string &flag : definition.required_flags ) {
                if( definition.forbidden_flags.count( flag ) != 0 ) {
                    throw std::runtime_error( "attack vector '" + definition.id +
                                              "' both requires and forbids flag '" + flag + "'" );
                }
            }
            if( check_engine_state ) {
                const auto validate_flag = [&json_flag_ids, &definition](
                const std::string & flag ) {
                    if( json_flag_ids.count( flag ) == 0 && !flag_id( flag ).is_valid() ) {
                        throw std::runtime_error( "attack vector '" + definition.id +
                                                  "' references unknown limb flag '" + flag + "'" );
                    }
                };
                for( const std::string &flag : definition.required_flags ) {
                    validate_flag( flag );
                }
                for( const std::string &flag : definition.forbidden_flags ) {
                    validate_flag( flag );
                }
            }
            validate_operation( entry.operation, attack_vector_id( definition.id ).is_valid(),
                                definition.id, "attack vector" );
        }

        std::set<std::string> trap_ids;
        for( const trap_registration &entry : pimpl_->traps ) {
            const trap_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "trap" );
            if( definition.name.empty() || definition.color.empty() ||
                definition.symbol.empty() || definition.action.empty() ||
                !trap_ids.insert( definition.id ).second ||
                definition.visibility < 0 ||
                definition.avoidance < 0 ||
                definition.difficulty < 0 || definition.difficulty > 99 ||
                definition.trap_radius < 0 ||
                definition.funnel_radius < 0 ||
                definition.comfort < 0 ||
                definition.trigger_weight_grams < 0 ||
                definition.sound_threshold_min < 0 ||
                definition.sound_threshold_max < definition.sound_threshold_min ) {
                throw std::runtime_error( "trap '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            for( const auto &[item, quantity, charges] : definition.drops ) {
                if( item.empty() || quantity <= 0 || charges <= 0 ||
                    ( check_engine_state && !itype_id( item ).is_valid() ) ) {
                    throw std::runtime_error( "trap '" + definition.id +
                                              "' references an invalid drop item" );
                }
            }
            if( !definition.trigger_handler.empty() &&
                owner_runtime.handlers.count( definition.trigger_handler ) == 0 ) {
                throw std::runtime_error( "trap '" + definition.id +
                                          "' references missing trigger handler '" +
                                          definition.trigger_handler + "'" );
            }
            validate_operation( entry.operation, trap_str_id( definition.id ).is_valid(),
                                definition.id, "trap" );
        }

        std::set<std::string> construction_ids;
        for( const construction_registration &entry : pimpl_->constructions ) {
            const construction_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "construction" );
            if( definition.group.empty() || definition.category.empty() ||
                !construction_ids.insert( definition.id ).second ||
                definition.time_moves < 0 ||
                !std::isfinite( definition.activity_level ) ||
                definition.activity_level < 0.0 ) {
                throw std::runtime_error( "construction '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            for( const auto &[skill, level] : definition.required_skills ) {
                if( skill.empty() || level < 0 ||
                    ( check_engine_state && !skill_id( skill ).is_valid() ) ) {
                    throw std::runtime_error( "construction '" + definition.id +
                                              "' references an invalid skill requirement" );
                }
            }
            for( const auto &[requirement, multiplier] : definition.reqs_using ) {
                if( requirement.empty() || multiplier <= 0 ||
                    ( check_engine_state && !requirement_id( requirement ).is_valid() ) ) {
                    throw std::runtime_error( "construction '" + definition.id +
                                              "' references an invalid requirement" );
                }
            }
            validate_operation( entry.operation,
                                construction_str_id( definition.id ).is_valid(),
                                definition.id, "construction" );
        }

        std::set<std::string> furniture_ids;
        for( const furniture_registration &entry : pimpl_->furniture ) {
            const furniture_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "furniture" );
            if( definition.name.empty() || definition.color.empty() ||
                definition.symbol.empty() ||
                !furniture_ids.insert( definition.id ).second ||
                definition.movecost < 0 ||
                definition.light_emitted < 0 ||
                definition.max_volume_ml < 0 ||
                definition.mass_grams < 0 ||
                definition.keg_capacity_ml < 0 ) {
                throw std::runtime_error( "furniture '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            if( check_engine_state ) {
                for( const std::string &target : {
                         definition.open, definition.close, definition.lockpick_result
                     } ) {
                    if( !target.empty() && !furn_str_id( target ).is_valid() ) {
                        throw std::runtime_error( "furniture '" + definition.id +
                                                  "' references an invalid furniture id '" +
                                                  target + "'" );
                    }
                }
                if( !definition.crafting_pseudo_item.empty() &&
                    !itype_id( definition.crafting_pseudo_item ).is_valid() ) {
                    throw std::runtime_error( "furniture '" + definition.id +
                                              "' references an invalid pseudo item" );
                }
                if( !definition.deployed_item.empty() &&
                    !itype_id( definition.deployed_item ).is_valid() ) {
                    throw std::runtime_error( "furniture '" + definition.id +
                                              "' references an invalid deployed item" );
                }
            }
            if( !definition.examine_handler.empty() &&
                owner_runtime.handlers.count( definition.examine_handler ) == 0 ) {
                throw std::runtime_error( "furniture '" + definition.id +
                                          "' references missing examine handler '" +
                                          definition.examine_handler + "'" );
            }
            validate_operation( entry.operation, furn_str_id( definition.id ).is_valid(),
                                definition.id, "furniture" );
        }

        std::set<std::string> terrain_ids;
        for( const terrain_registration &entry : pimpl_->terrain ) {
            const terrain_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "terrain" );
            if( definition.name.empty() || definition.color.empty() ||
                definition.symbol.empty() ||
                !terrain_ids.insert( definition.id ).second ||
                definition.movecost < 0 ||
                definition.light_emitted < 0 ||
                definition.max_volume_ml < 0 ) {
                throw std::runtime_error( "terrain '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            if( check_engine_state ) {
                for( const std::string &target : {
                         definition.open, definition.close, definition.transforms_into,
                         definition.roof, definition.lockpick_result
                     } ) {
                    if( !target.empty() && !ter_str_id( target ).is_valid() ) {
                        throw std::runtime_error( "terrain '" + definition.id +
                                                  "' references an invalid terrain id '" +
                                                  target + "'" );
                    }
                }
                if( !definition.trap.empty() &&
                    !trap_str_id( definition.trap ).is_valid() ) {
                    throw std::runtime_error( "terrain '" + definition.id +
                                              "' references an invalid trap id '" +
                                              definition.trap + "'" );
                }
            }
            if( !definition.examine_handler.empty() &&
                owner_runtime.handlers.count( definition.examine_handler ) == 0 ) {
                throw std::runtime_error( "terrain '" + definition.id +
                                          "' references missing examine handler '" +
                                          definition.examine_handler + "'" );
            }
            validate_operation( entry.operation, ter_str_id( definition.id ).is_valid(),
                                definition.id, "terrain" );
        }

        std::set<std::string> gate_ids;
        for( const gate_registration &entry : pimpl_->gates ) {
            const gate_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "gate" );
            // An empty walls list is a deliberate legacy value: it matches
            // any terrain with the WALL flag.
            if( definition.door.empty() || definition.floor.empty() ||
                !gate_ids.insert( definition.id ).second ||
                definition.moves < 0 || definition.bashing_damage < 0 ) {
                throw std::runtime_error( "gate '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            if( check_engine_state ) {
                for( const std::string &wall : definition.walls ) {
                    if( !ter_str_id( wall ).is_valid() ) {
                        throw std::runtime_error( "gate '" + definition.id +
                                                  "' references an invalid wall '" +
                                                  wall + "'" );
                    }
                }
            }
            validate_operation( entry.operation, gate_id( definition.id ).is_valid(),
                                definition.id, "gate" );
        }

        std::set<std::string> fault_ids;
        for( const fault_registration &entry : pimpl_->faults ) {
            const fault_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "fault" );
            // Legacy faults may omit fault_type (empty string default).
            if( definition.name.empty() ||
                !fault_ids.insert( definition.id ).second ||
                !std::isfinite( definition.price_modifier ) ||
                !std::isfinite( definition.contact_area_mod ) ||
                !std::isfinite( definition.rolling_resistance_mod ) ||
                !std::isfinite( definition.encumbrance_mod_mult ) ) {
                throw std::runtime_error( "fault '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            validate_operation( entry.operation, fault_id( definition.id ).is_valid(),
                                definition.id, "fault" );
        }

        std::set<std::string> fault_fix_ids;
        for( const fault_fix_registration &entry : pimpl_->fault_fixes ) {
            const fault_fix_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "fault fix" );
            if( definition.name.empty() ||
                !fault_fix_ids.insert( definition.id ).second ||
                definition.time_seconds < 0 ) {
                throw std::runtime_error( "fault fix '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            for( const auto &[skill, level] : definition.skills ) {
                if( skill.empty() || level < 0 ||
                    ( check_engine_state && !skill_id( skill ).is_valid() ) ) {
                    throw std::runtime_error( "fault fix '" + definition.id +
                                              "' references an invalid skill requirement" );
                }
            }
            validate_operation( entry.operation,
                                fault_fix_id( definition.id ).is_valid(),
                                definition.id, "fault fix" );
        }

        for( const dream_registration &entry : pimpl_->dreams ) {
            const dream_definition_data &definition = *entry.definition;
            if( definition.category.empty() || definition.strength < 0 ||
                definition.messages.empty() ) {
                throw std::runtime_error( "dream has invalid category, strength, or empty messages" );
            }
            // Dream categories are matched against trait categories at
            // runtime; legacy loading does not validate them eagerly and
            // unknown categories simply never trigger.
        }

        std::set<std::string> achievement_ids;
        for( const achievement_registration &entry : pimpl_->achievements ) {
            const achievement_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "achievement" );
            if( definition.name.empty() ||
                !achievement_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "achievement '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            validate_operation( entry.operation,
                                detail::platform_achievement_is_valid( definition.id ),
                                definition.id, "achievement" );
        }

        for( const blacklist_registration &entry : pimpl_->blacklists ) {
            const detail::platform_blacklist_data &definition = *entry.definition;
            if( definition.kind.empty() ||
                ( definition.kind != "item" && definition.kind != "trait" &&
                  definition.kind != "monster" && definition.kind != "scenario" &&
                  definition.kind != "profession" &&
                  definition.kind != "charge_removal" &&
                  definition.kind != "temperature_removal" ) ) {
                // An empty entry list is a deliberate legacy value (the core
                // MONSTER_BLACKLIST starts empty) and must stay valid.
                throw std::runtime_error( "blacklist has an invalid kind" );
            }
        }

        std::set<std::string> map_extra_ids;
        for( const map_extra_registration &entry : pimpl_->map_extras ) {
            const map_extra_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "map extra" );
            if( definition.name.empty() ||
                !map_extra_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "map extra '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            validate_operation( entry.operation,
                                map_extra_id( definition.id ).is_valid(),
                                definition.id, "map extra" );
        }

        std::set<std::string> weather_generator_ids;
        for( const weather_generator_registration &entry :
             pimpl_->weather_generators ) {
            const weather_generator_definition_data &definition =
                *entry.definition;
            require_valid_id( definition.id, "weather generator" );
            if( !std::isfinite( definition.base_temperature ) ||
                !std::isfinite( definition.base_humidity ) ||
                !std::isfinite( definition.base_pressure ) ||
                !std::isfinite( definition.base_wind ) ||
                definition.base_wind_distrib_peaks < 0 ||
                !weather_generator_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "weather generator '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            validate_operation( entry.operation,
                                weather_generator_id( definition.id ).is_valid(),
                                definition.id, "weather generator" );
        }

        const std::set<std::string> migration_kinds = {
            "bionic", "effect", "field_type", "furniture", "oter",
            "overmap_special", "proficiency", "terrain", "trap",
            "var", "vehicle_part",
        };
        for( const migration_registration &entry : pimpl_->migrations ) {
            const detail::platform_migration_data &definition = *entry.definition;
            if( migration_kinds.count( definition.kind ) == 0 ||
                definition.from_id.empty() ) {
                throw std::runtime_error( "migration has an invalid kind or empty from id" );
            }
        }

        for( const monster_adjustment_registration &entry :
             pimpl_->monster_adjustments ) {
            const monster_adjustment_definition_data &definition =
                *entry.definition;
            if( definition.species.empty() ||
                ( definition.stat.empty() && definition.flag.empty() &&
                  definition.special.empty() ) ||
                !std::isfinite( definition.stat_adjust ) ) {
                throw std::runtime_error( "monster adjustment has an invalid profile" );
            }
        }

        std::set<std::string> trait_group_ids;
        for( const trait_group_registration &entry : pimpl_->trait_groups ) {
            const trait_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "trait group" );
            if( definition.entries.empty() ||
                !trait_group_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "trait group '" + definition.id +
                                          "' has empty entries or a duplicate registration" );
            }
        }

        std::set<std::string> shopkeeper_ids;
        for( const trait_group_registration &entry : pimpl_->trait_groups ) {
            const trait_group_definition_data &source = *entry.definition;
            pimpl_->trait_group_undo.push_back( source.id );
            detail::insert_platform_trait_group( source.id, source.entries );
        }

        if( !pimpl_->monster_adjustments.empty() ) {
            pimpl_->monster_adjustment_undo =
                detail::platform_monster_adjustment_count();
        }
        for( const monster_adjustment_registration &entry :
             pimpl_->monster_adjustments ) {
            const monster_adjustment_definition_data &source = *entry.definition;
            detail::append_platform_monster_adjustment(
                source.species, source.stat, source.stat_adjust,
                source.flag, source.flag_val, source.special );
        }

        for( const shopkeeper_registration &entry : pimpl_->shopkeeper_rules ) {
            const shopkeeper_blacklist_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "shopkeeper rule" );
            if( !shopkeeper_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "shopkeeper rule '" + definition.id +
                                          "' has a duplicate registration" );
            }
        }

        std::set<std::string> construction_category_ids;
        for( const construction_category_registration &entry :
             pimpl_->construction_categories ) {
            const construction_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "construction category" );
            if( definition.name.empty() ||
                !construction_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "construction category '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            validate_operation( entry.operation,
                                construction_category_id( definition.id ).is_valid(),
                                definition.id, "construction category" );
        }

        std::set<std::string> construction_group_ids;
        for( const construction_group_registration &entry : pimpl_->construction_groups ) {
            const construction_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "construction group" );
            if( definition.name.empty() ||
                !construction_group_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "construction group '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            validate_operation( entry.operation,
                                construction_group_str_id( definition.id ).is_valid(),
                                definition.id, "construction group" );
        }

        std::set<std::string> vehicle_part_location_ids;
        for( const vehicle_part_location_registration &entry :
             pimpl_->vehicle_part_locations ) {
            const vehicle_part_location_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "vehicle part location" );
            if( definition.name.empty() ||
                definition.z_order < std::numeric_limits<int>::min() ||
                definition.z_order > std::numeric_limits<int>::max() ||
                definition.list_order < std::numeric_limits<int>::min() ||
                definition.list_order > std::numeric_limits<int>::max() ||
                !vehicle_part_location_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "vehicle part location '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            validate_operation( entry.operation,
                                vpart_location_id( definition.id ).is_valid(),
                                definition.id, "vehicle part location" );
        }

        std::set<std::string> mood_face_ids;
        for( const mood_face_registration &entry : pimpl_->mood_faces ) {
            const mood_face_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "mood face" );
            std::set<std::int64_t> scores;
            if( definition.values.empty() ||
                !mood_face_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "mood face '" + definition.id +
                                          "' requires values and one registration per transaction" );
            }
            for( const mood_face_value_definition_data &value : definition.values ) {
                if( value.face.empty() || !scores.insert( value.score ).second ) {
                    throw std::runtime_error( "mood face '" + definition.id +
                                              "' has empty text or a duplicate score" );
                }
            }
            validate_operation( entry.operation, mood_face_id( definition.id ).is_valid(),
                                definition.id, "mood face" );
        }

        std::set<std::string> damage_info_order_ids;
        for( const damage_info_order_registration &entry : pimpl_->damage_info_orders ) {
            const damage_info_order_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "damage info order" );
            if( definition.display != "none" && definition.display != "basic" &&
                definition.display != "detailed" ) {
                throw std::runtime_error( "damage info order '" + definition.id +
                                          "' has unknown display mode '" +
                                          definition.display + "'" );
            }
            if( definition.sections.empty() ||
                !damage_info_order_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "damage info order '" + definition.id +
                                          "' requires sections and one registration per transaction" );
            }
            if( damage_type_ids.count( definition.id ) == 0 &&
                !damage_type_id( definition.id ).is_valid() ) {
                throw std::runtime_error( "damage info order '" + definition.id +
                                          "' has no matching damage type" );
            }
            validate_operation( entry.operation,
                                damage_info_order_id( definition.id ).is_valid(),
                                definition.id, "damage info order" );
        }

        std::set<std::string> vehicle_part_category_ids;
        for( const vehicle_part_category_registration &entry :
             pimpl_->vehicle_part_categories ) {
            const vehicle_part_category_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "vehicle part category" );
            if( definition.name.empty() || definition.short_name.empty() ||
                definition.priority < std::numeric_limits<int>::min() ||
                definition.priority > std::numeric_limits<int>::max() ||
                !vehicle_part_category_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "vehicle part category '" + definition.id +
                                          "' has invalid values or a duplicate registration" );
            }
            validate_operation(
                entry.operation,
                detail::vehicle_part_category_registry_find( definition.id ) != nullptr,
                definition.id, "vehicle part category" );
        }

        std::set<std::string> named_color_ids;
        std::set<std::uint32_t> named_color_values;
        for( const named_color_registration &entry : pimpl_->named_colors ) {
            const named_color_definition_data &definition = *entry.definition;
            if( definition.name.empty() || definition.red < 0 || definition.red > 255 ||
                definition.green < 0 || definition.green > 255 ||
                definition.blue < 0 || definition.blue > 255 ||
                definition.alpha < 0 || definition.alpha > 255 ||
                !named_color_ids.insert( definition.name ).second ) {
                throw std::runtime_error( "named color '" + definition.name +
                                          "' has invalid channels or a duplicate registration" );
            }
            const std::uint32_t packed =
                ( static_cast<std::uint32_t>( definition.red ) << 24 ) |
                ( static_cast<std::uint32_t>( definition.green ) << 16 ) |
                ( static_cast<std::uint32_t>( definition.blue ) << 8 ) |
                static_cast<std::uint32_t>( definition.alpha );
            const detail::named_color_native_definition native{
                definition.name,
                static_cast<std::uint8_t>( definition.red ),
                static_cast<std::uint8_t>( definition.green ),
                static_cast<std::uint8_t>( definition.blue ),
                static_cast<std::uint8_t>( definition.alpha )
            };
            if( !named_color_values.insert( packed ).second ||
                ( check_engine_state &&
                  detail::named_color_registry_color_in_use( native, definition.name ) ) ) {
                throw std::runtime_error( "named color '" + definition.name +
                                          "' collides with another color value" );
            }
            validate_operation( entry.operation,
                                detail::named_color_registry_contains( definition.name ),
                                definition.name, "named color" );
        }

        std::set<std::uint32_t> staged_rotatable_symbols;
        for( const rotatable_symbol_registration &entry : pimpl_->rotatable_symbols ) {
            const rotatable_symbol_definition_data &definition = *entry.definition;
            std::set<std::uint32_t> candidate( definition.symbols.begin(),
                                               definition.symbols.end() );
            if( definition.key.empty() ||
                ( definition.symbols.size() != 2 && definition.symbols.size() != 4 ) ||
                candidate.size() != definition.symbols.size() ) {
                throw std::runtime_error( "rotatable symbol '" + definition.key +
                                          "' requires two or four distinct glyphs" );
            }
            for( const std::uint32_t symbol : candidate ) {
                if( !staged_rotatable_symbols.insert( symbol ).second ) {
                    throw std::runtime_error( "rotatable symbol groups overlap in one transaction" );
                }
            }
            std::vector<std::uint32_t> current =
                detail::rotatable_symbol_registry_group( definition.symbols.front() );
            validate_operation( entry.operation, !current.empty(), definition.key,
                                "rotatable symbol" );
            if( check_engine_state && entry.operation == definition_operation::add ) {
                for( const std::uint32_t symbol : candidate ) {
                    if( !detail::rotatable_symbol_registry_group( symbol ).empty() ) {
                        throw std::runtime_error( "rotatable symbol '" + definition.key +
                                                  "' overlaps an existing group" );
                    }
                }
            } else if( check_engine_state ) {
                std::vector<std::uint32_t> expected( candidate.begin(), candidate.end() );
                if( current != expected ) {
                    throw std::runtime_error( "rotatable symbol '" + definition.key +
                                              "' replacement must preserve its glyph set" );
                }
            }
        }

        std::set<std::string> ascii_art_ids;
        for( const ascii_art_registration &entry : pimpl_->ascii_arts ) {
            const ascii_art_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "ASCII art" );
            if( definition.lines.empty() ||
                !ascii_art_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "ASCII art '" + definition.id +
                                          "' requires lines and one registration per transaction" );
            }
            for( const std::string &line : definition.lines ) {
                if( utf8_width( remove_color_tags( line ) ) > 41 ) {
                    throw std::runtime_error( "ASCII art '" + definition.id +
                                              "' contains a line wider than 41 cells" );
                }
            }
            validate_operation( entry.operation, ascii_art_id( definition.id ).is_valid(),
                                definition.id, "ASCII art" );
        }

        std::set<std::string> limb_score_ids;
        for( const limb_score_registration &entry : pimpl_->limb_scores ) {
            const limb_score_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "limb score" );
            if( definition.name.empty() ||
                !limb_score_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "limb score '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            validate_operation( entry.operation, limb_score_id( definition.id ).is_valid(),
                                definition.id, "limb score" );
        }

        if( pimpl_->hit_ranges.size() > 1 ) {
            throw std::runtime_error( "hit range is a singleton and may be registered once" );
        }
        for( const hit_range_registration &entry : pimpl_->hit_ranges ) {
            const hit_range_definition_data &definition = *entry.definition;
            if( definition.id != "global" || definition.even_good.empty() ) {
                throw std::runtime_error( "hit range requires the global singleton and values" );
            }
            if( check_engine_state && entry.operation != definition_operation::replace ) {
                throw std::runtime_error( "hit range is a global singleton and must use replace" );
            }
            for( const std::int64_t value : definition.even_good ) {
                if( value < 0 || value > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "hit-range dispersion is outside the native range" );
                }
            }
        }


        std::set<std::string> scenario_ids;
        for( const scenario_registration &entry : pimpl_->scenarios ) {
            const scenario_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "scenario" );
            if( !definition.start_handler.empty() &&
                !runtime_has_handler( owner_runtime, definition.start_handler ) ) {
                throw std::runtime_error(
                    "scenario '" + definition.id +
                    "' references missing start handler '" +
                    definition.start_handler + "'" );
            }
            if( definition.name.empty() ||
                !scenario_ids.insert( definition.id ).second ) {
                // An empty start_name is a deliberate legacy value (e.g.
                // defense_mode_fortified renders no start label).
                throw std::runtime_error( "scenario '" + definition.id +
                                          "' requires a name and one registration per transaction" );
            }
            for( const std::string &location : definition.locations ) {
                if( start_location_ids.count( location ) == 0 &&
                    !start_location_id( location ).is_valid() ) {
                    throw std::runtime_error( "scenario '" + definition.id +
                                              "' references unknown start location '" + location + "'" );
                }
            }
            for( const std::string &profession : definition.professions ) {
                if( !profession_id( profession ).is_valid() ) {
                    throw std::runtime_error( "scenario '" + definition.id +
                                              "' references unknown profession '" + profession + "'" );
                }
            }
            for( const std::string &trait : definition.allowed_traits ) {
                if( !trait_id( trait ).is_valid() ) {
                    throw std::runtime_error( "scenario '" + definition.id +
                                              "' references unknown trait '" + trait + "'" );
                }
            }
            for( const std::string &trait : definition.forced_traits ) {
                if( !trait_id( trait ).is_valid() ) {
                    throw std::runtime_error( "scenario '" + definition.id +
                                              "' references unknown trait '" + trait + "'" );
                }
            }
            for( const std::string &trait : definition.forbidden_traits ) {
                if( !trait_id( trait ).is_valid() ) {
                    throw std::runtime_error( "scenario '" + definition.id +
                                              "' references unknown trait '" + trait + "'" );
                }
            }
            if( !definition.map_extra.empty() &&
                map_extra_ids.count( definition.map_extra ) == 0 &&
                !map_extra_id( definition.map_extra ).is_valid() ) {
                throw std::runtime_error( "scenario '" + definition.id +
                                          "' references unknown map extra '" +
                                          definition.map_extra + "'" );
            }
            if( !definition.requirement.empty() &&
                !achievement_id( definition.requirement ).is_valid() ) {
                throw std::runtime_error( "scenario '" + definition.id +
                                          "' references unknown achievement '" +
                                          definition.requirement + "'" );
            }
            validate_operation(
                entry.operation, string_id<scenario>( definition.id ).is_valid(),
                definition.id, "scenario" );
        }

        std::set<std::string> vehicle_color_palette_ids;
        for( const vehicle_color_palette_registration &entry :
             pimpl_->vehicle_color_palettes ) {
            const vehicle_color_palette_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "vehicle color palette" );
            if( definition.groups.empty() ||
                !vehicle_color_palette_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "vehicle color palette '" + definition.id +
                                          "' requires groups and one registration per transaction" );
            }
            for( const vehicle_color_palette_group_data &group : definition.groups ) {
                for( const std::string &fuzzy : group.fuzzy_ids ) {
                    if( fuzzy.empty() ) {
                        throw std::runtime_error( "vehicle color palette '" + definition.id +
                                                  "' has an empty fuzzy id" );
                    }
                }
                for( const auto &[name, weight] : group.colors ) {
                    if( !RGBColor::try_parse( name ) ) {
                        throw std::runtime_error( "vehicle color palette '" + definition.id +
                                                  "' references unknown color '" + name + "'" );
                    }
                }
            }
            validate_operation(
                entry.operation,
                detail::vehicle_color_palette_registry_find(
                    vpalette_id( definition.id ) ) != nullptr,
                definition.id, "vehicle color palette" );
        }

        std::set<std::string> monster_group_ids;
        for( const monster_group_registration &entry : pimpl_->monster_groups ) {
            const monster_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "monster group" );
            if( !monster_group_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "monster group '" + definition.id +
                                          "' needs one registration per transaction" );
            }
            if( !definition.default_monster.empty() &&
                !mtype_id( definition.default_monster ).is_valid() ) {
                throw std::runtime_error( "monster group '" + definition.id +
                                          "' references unknown default monster '" +
                                          definition.default_monster + "'" );
            }
            for( const monster_group_entry_definition_data &monster_entry :
                 definition.entries ) {
                if( !monster_entry.monster.empty() &&
                    !mtype_id( monster_entry.monster ).is_valid() ) {
                    throw std::runtime_error( "monster group '" + definition.id +
                                              "' references unknown monster '" +
                                              monster_entry.monster + "'" );
                }
                if( !monster_entry.group.empty() &&
                    !mongroup_id( monster_entry.group ).is_valid() ) {
                    throw std::runtime_error( "monster group '" + definition.id +
                                              "' references unknown group '" +
                                              monster_entry.group + "'" );
                }
            }
            validate_operation(
                entry.operation,
                MonsterGroupManager::isValidMonsterGroup(
                    mongroup_id( definition.id ) ),
                definition.id, "monster group" );
        }

        std::set<std::string> overmap_connection_ids;
        for( const overmap_connection_registration &entry :
             pimpl_->overmap_connections ) {
            const overmap_connection_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "overmap connection" );
            if( definition.subtypes.empty() ||
                !overmap_connection_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "overmap connection '" + definition.id +
                                          "' requires subtypes and one registration per transaction" );
            }
            for( const overmap_connection_subtype_definition_data &subtype :
                 definition.subtypes ) {
                if( !string_id<oter_type_t>( subtype.terrain ).is_valid() ) {
                    throw std::runtime_error( "overmap connection '" + definition.id +
                                              "' references unknown terrain '" +
                                              subtype.terrain + "'" );
                }
                for( const std::string &location : subtype.locations ) {
                    if( !string_id<overmap_location>( location ).is_valid() ) {
                        throw std::runtime_error( "overmap connection '" + definition.id +
                                                  "' references unknown location '" +
                                                  location + "'" );
                    }
                }
            }
            validate_operation(
                entry.operation,
                string_id<overmap_connection>( definition.id ).is_valid(),
                definition.id, "overmap connection" );
        }

        std::set<std::string> speed_description_ids;
        for( const speed_description_registration &entry : pimpl_->speed_descriptions ) {
            const speed_description_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "speed description" );
            if( definition.values.empty() ||
                !speed_description_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "speed description '" + definition.id +
                                          "' requires values and one registration per transaction" );
            }
            for( const speed_description_value_data &value : definition.values ) {
                if( !std::isfinite( value.threshold ) || value.threshold < 0.0 ||
                    value.descriptions.empty() ) {
                    throw std::runtime_error( "speed description '" + definition.id +
                                              "' has an invalid threshold or no text" );
                }
                for( const std::string &description : value.descriptions ) {
                    if( description.empty() ) {
                        throw std::runtime_error( "speed description '" + definition.id +
                                                  "' contains empty text" );
                    }
                }
            }
            validate_operation( entry.operation,
                                speed_description_id( definition.id ).is_valid(),
                                definition.id, "speed description" );
        }

        std::set<std::string> harvest_drop_type_ids;
        std::map<std::string, bool> harvest_drop_type_item_groups;
        for( const harvest_drop_type_registration &entry : pimpl_->harvest_drop_types ) {
            const harvest_drop_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "harvest drop type" );
            if( !harvest_drop_type_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "harvest drop type '" + definition.id +
                                          "' is registered more than once per transaction" );
            }
            const std::vector<std::string> skills = definition.skills.empty() ?
                                                    std::vector<std::string> { "survival" } :
                                                    definition.skills;
            for( const std::string &skill : skills ) {
                if( skill_ids.count( skill ) == 0 && !skill_id( skill ).is_valid() ) {
                    throw std::runtime_error( "harvest drop type '" + definition.id +
                                              "' references unknown skill '" + skill + "'" );
                }
            }
            validate_operation( entry.operation,
                                harvest_drop_type_id( definition.id ).is_valid(),
                                definition.id, "harvest drop type" );
            harvest_drop_type_item_groups[definition.id] = definition.item_group;
        }

        std::set<std::string> harvest_ids;
        for( const harvest_registration &entry : pimpl_->harvests ) {
            const harvest_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "harvest" );
            if( definition.leftovers.empty() || definition.butchery_requirements.empty() ||
                !harvest_ids.insert( definition.id ).second ) {
                throw std::runtime_error( "harvest '" + definition.id +
                                          "' requires leftovers, butchery requirements, and one registration" );
            }
            if( declared_item_ids.count( definition.leftovers ) == 0 &&
                !item::type_is_defined( itype_id( definition.leftovers ) ) ) {
                throw std::runtime_error( "harvest '" + definition.id +
                                          "' references unknown leftovers item '" +
                                          definition.leftovers + "'" );
            }
            if( check_engine_state &&
                !butchery_requirements_id( definition.butchery_requirements ).is_valid() ) {
                throw std::runtime_error( "harvest '" + definition.id +
                                          "' references unknown butchery requirements '" +
                                          definition.butchery_requirements + "'" );
            }
            std::set<std::string> outputs;
            for( const harvest_entry_definition_data &drop : definition.entries ) {
                const auto finite_native_float = []( const double value ) {
                    return std::isfinite( value ) &&
                           std::abs( value ) <= std::numeric_limits<float>::max();
                };
                if( drop.output.empty() || !outputs.insert( drop.output ).second ||
                    !finite_native_float( drop.base_minimum ) ||
                    !finite_native_float( drop.base_maximum ) ||
                    drop.base_maximum < drop.base_minimum ||
                    !finite_native_float( drop.skill_minimum ) ||
                    !finite_native_float( drop.skill_maximum ) ||
                    drop.skill_maximum < drop.skill_minimum ||
                    drop.maximum <= 0 ||
                    drop.maximum > std::numeric_limits<int>::max() ||
                    !std::isfinite( drop.mass_ratio ) || drop.mass_ratio < 0.0 ||
                    drop.mass_ratio > 1.0 ) {
                    throw std::runtime_error( "harvest '" + definition.id +
                                              "' has an invalid drop for '" + drop.output + "'" );
                }

                bool output_is_item_group = false;
                if( !drop.category.empty() ) {
                    const auto staged_category =
                        harvest_drop_type_item_groups.find( drop.category );
                    if( staged_category != harvest_drop_type_item_groups.end() ) {
                        output_is_item_group = staged_category->second;
                    } else {
                        const harvest_drop_type_id category( drop.category );
                        if( !category.is_valid() ) {
                            throw std::runtime_error( "harvest '" + definition.id +
                                                      "' references unknown drop category '" +
                                                      drop.category + "'" );
                        }
                        output_is_item_group = category->is_item_group();
                    }
                }
                if( output_is_item_group ) {
                    if( item_group_ids.count( drop.output ) == 0 && check_engine_state &&
                        !item_group::group_is_defined( item_group_id( drop.output ) ) ) {
                        throw std::runtime_error( "harvest '" + definition.id +
                                                  "' references unknown item group '" +
                                                  drop.output + "'" );
                    }
                } else if( declared_item_ids.count( drop.output ) == 0 &&
                           !item::type_is_defined( itype_id( drop.output ) ) ) {
                    throw std::runtime_error( "harvest '" + definition.id +
                                              "' references unknown item '" + drop.output + "'" );
                }
                for( const std::string &flag : drop.flags ) {
                    if( json_flag_ids.count( flag ) == 0 && !flag_id( flag ).is_valid() ) {
                        throw std::runtime_error( "harvest '" + definition.id +
                                                  "' references unknown item flag '" + flag + "'" );
                    }
                }
                for( const std::string &fault : drop.faults ) {
                    if( check_engine_state && !fault_id( fault ).is_valid() ) {
                        throw std::runtime_error( "harvest '" + definition.id +
                                                  "' references unknown item fault '" + fault + "'" );
                    }
                }
            }
            validate_operation( entry.operation, harvest_id( definition.id ).is_valid(),
                                definition.id, "harvest" );
        }

        if( !pimpl_->world.validate( owner_runtime, check_engine_state, error ) ) {
            return false;
        }


        std::set<std::string> terrain_transform_ids;
        for( const terrain_transform_registration &entry : pimpl_->terrain_transforms ) {
            const terrain_transform_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "terrain transform" );
            if( !terrain_transform_ids.insert( definition.id ).second ||
                definition.rules.empty() || definition.rules.size() > 4096 ) {
                throw std::runtime_error( "terrain transform '" + definition.id +
                                          "' needs a unique id and bounded rules" );
            }
            std::set<std::string> input_keys;
            for( const terrain_transform_rule_definition_data &rule : definition.rules ) {
                if( ( rule.kind != "terrain" && rule.kind != "furniture" &&
                      rule.kind != "field" && rule.kind != "trap" ) ||
                    ( rule.inputs.empty() && rule.flags.empty() ) || rule.results.empty() ||
                    rule.results.size() > 1024 || rule.inputs.size() > 1024 ||
                    rule.flags.size() > 1024 ||
                    rule.message.size() > 16384 ||
                    rule.message.find( '\0' ) != std::string::npos ||
                    ( rule.kind == "field" && !rule.flags.empty() ) ) {
                    throw std::runtime_error( "terrain transform '" + definition.id +
                                              "' has an invalid " + rule.kind + " rule" );
                }
                const auto valid_native_id = [&]( const std::string & id ) {
                    if( rule.kind == "terrain" ) {
                        return terrain_ids.count( id ) != 0 || ter_str_id( id ).is_valid();
                    }
                    if( rule.kind == "furniture" ) {
                        return furniture_ids.count( id ) != 0 || furn_str_id( id ).is_valid();
                    }
                    if( rule.kind == "field" ) {
                        return pimpl_->creatures.defines_field_type( id ) ||
                               field_type_str_id( id ).is_valid();
                    }
                    return trap_ids.count( id ) != 0 || trap_str_id( id ).is_valid();
                };
                for( const std::string &input : rule.inputs ) {
                    require_valid_id( input, "terrain transform input" );
                    if( !input_keys.insert( rule.kind + ":id:" + input ).second ||
                        ( check_engine_state && !valid_native_id( input ) ) ) {
                        throw std::runtime_error( "terrain transform '" + definition.id +
                                                  "' has an unknown or duplicate input '" +
                                                  input + "'" );
                    }
                }
                for( const std::string &flag : rule.flags ) {
                    require_valid_id( flag, "terrain transform flag" );
                    if( !input_keys.insert( rule.kind + ":flag:" + flag ).second ) {
                        throw std::runtime_error( "terrain transform '" + definition.id +
                                                  "' has duplicate flag input '" + flag + "'" );
                    }
                }
                std::set<std::string> results;
                for( const auto &[result, weight] : rule.results ) {
                    require_valid_id( result, "terrain transform result" );
                    if( !results.insert( result ).second || weight <= 0 ||
                        weight > std::numeric_limits<int>::max() ||
                        ( check_engine_state && !valid_native_id( result ) ) ) {
                        throw std::runtime_error( "terrain transform '" + definition.id +
                                                  "' has an unknown, duplicate, or invalid result '" +
                                                  result + "'" );
                    }
                }
            }
            validate_operation(
                entry.operation, ter_furn_transform_id( definition.id ).is_valid(),
                definition.id, "terrain transform" );
        }

        std::set<std::string> post_process_generator_ids;
        for( const post_process_generator_registration &entry :
             pimpl_->post_process_generators ) {
            const post_process_generator_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "post-process generator" );
            if( !post_process_generator_ids.insert( definition.id ).second ||
                definition.stages.size() > 1024 ) {
                throw std::runtime_error( "post-process generator '" + definition.id +
                                          "' has a duplicate id or too many stages" );
            }
            std::map<std::string, std::size_t> kind_counts;
            std::set<std::string> special_kinds;
            for( const post_process_stage_definition_data &stage : definition.stages ) {
                const bool known_kind = stage.kind == "bash_damage" ||
                                        stage.kind == "move_items" ||
                                        stage.kind == "add_fire" ||
                                        stage.kind == "pre_burn" ||
                                        stage.kind == "place_blood" ||
                                        stage.kind == "aftershock_ruin";
                const auto native_int = []( const std::int64_t value ) {
                    return value >= std::numeric_limits<int>::min() &&
                           value <= std::numeric_limits<int>::max();
                };
                if( !known_kind || ( stage.scope != "omt" &&
                                     stage.scope != "overmap_special" ) ||
                    !native_int( stage.attempts ) || !native_int( stage.chance ) ||
                    !native_int( stage.min_intensity ) ||
                    !native_int( stage.max_intensity ) ||
                    !native_int( stage.scaling_days_start ) ||
                    !native_int( stage.scaling_days_end ) || stage.attempts < 0 ||
                    stage.min_intensity < 0 || stage.max_intensity < 0 ||
                    ( stage.max_intensity != 0 &&
                      stage.min_intensity > stage.max_intensity ) ) {
                    throw std::runtime_error( "post-process generator '" + definition.id +
                                              "' has an invalid stage" );
                }
                ++kind_counts[stage.kind];
                if( stage.scope == "overmap_special" ) {
                    if( ( stage.kind != "pre_burn" &&
                          stage.kind != "aftershock_ruin" ) ||
                        ( stage.kind == "pre_burn" && stage.attempts > 1 ) ) {
                        throw std::runtime_error( "post-process generator '" + definition.id +
                                                  "' has an unsupported special scope" );
                    }
                    special_kinds.insert( stage.kind );
                }
                const bool invalid_for_kind =
                    ( stage.kind == "bash_damage" &&
                      ( stage.chance < 0 || stage.chance > 100 ||
                        stage.scaling_days_start != 0 || stage.scaling_days_end != 0 ) ) ||
                    ( stage.kind == "move_items" &&
                      ( stage.chance < 0 || stage.chance > 100 ||
                        stage.min_intensity != 0 || stage.scaling_days_start != 0 ||
                        stage.scaling_days_end != 0 ) ) ||
                    ( stage.kind == "add_fire" &&
                      ( stage.chance != 0 || stage.scaling_days_start != 0 ||
                        stage.scaling_days_end <= 0 ) ) ||
                    ( stage.kind == "pre_burn" &&
                      ( stage.chance != 0 || stage.scaling_days_end <= 0 ||
                        stage.scaling_days_start > stage.scaling_days_end ) ) ||
                    ( stage.kind == "place_blood" &&
                      ( stage.chance < 0 || stage.chance > 1000 ||
                        stage.min_intensity != 0 || stage.max_intensity != 0 ||
                        stage.scaling_days_start != 0 || stage.scaling_days_end != 0 ) ) ||
                    ( stage.kind == "aftershock_ruin" &&
                      ( stage.attempts != 0 || stage.chance != 0 ||
                        stage.min_intensity != 0 || stage.max_intensity != 0 ||
                        stage.scaling_days_start != 0 || stage.scaling_days_end != 0 ) );
                if( invalid_for_kind ) {
                    throw std::runtime_error( "post-process generator '" + definition.id +
                                              "' has values unsupported by stage '" +
                                              stage.kind + "'" );
                }
            }
            for( const std::string &kind : special_kinds ) {
                if( kind_counts[kind] != 1 ) {
                    throw std::runtime_error( "post-process generator '" + definition.id +
                                              "' repeats a special-scoped stage kind" );
                }
            }
            validate_operation(
                entry.operation, pp_generator_id( definition.id ).is_valid(),
                definition.id, "post-process generator" );
        }

        worldgen_validation_index worldgen_index;
        worldgen_index.skill_ids = skill_ids;
        worldgen_index.map_extra_collection_ids = map_extra_collection_ids;
        worldgen_index.furniture_ids = furniture_ids;
        worldgen_index.terrain_ids = terrain_ids;
        worldgen_index.weather_generator_ids = weather_generator_ids;
        worldgen_index.item_group_ids = item_group_ids;
        worldgen_index.overmap_connection_ids = overmap_connection_ids;
        if( !pimpl_->worldgen.validate(
                worldgen_index, check_engine_state, error ) ) {
            return false;
        }

        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool content_transaction::apply( std::string &error )
{
    if( pimpl_->applied ) {
        error = "content transaction for '" + pimpl_->owner + "' was already applied";
        return false;
    }
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        error = "content transaction for '" + pimpl_->owner +
                "' is no longer building";
        return false;
    }
    try {
        const auto apply_character_phase =
        [this, &error]( const character_content_apply_phase phase ) {
            if( !pimpl_->character.apply_phase( phase, error ) ) {
                throw std::runtime_error( error );
            }
        };
        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::foundations, error ) ) {
            throw std::runtime_error( error );
        }

        for( const bash_damage_profile_registration &entry :
             pimpl_->bash_damage_profiles ) {
            const bash_damage_profile_id id( entry.definition->id );
            pimpl_->bash_damage_profile_undo.emplace_back(
                id, id.is_valid() ? std::optional<bash_damage_profile>( id.obj() ) :
                std::nullopt );
            bash_damage_profile native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            for( const auto &[damage_id, factor] : entry.definition->factors ) {
                native.profile[damage_type_id( damage_id )] = factor;
            }
            // Mirrors the legacy finalize fill-in: every damage type not
            // authored explicitly inherits its bash conversion factor.
            native.finalize();
            detail::bash_damage_profile_registry().insert( native );
        }

        for( const damage_info_order_registration &entry : pimpl_->damage_info_orders ) {
            const damage_info_order_id id( entry.definition->id );
            pimpl_->damage_info_order_undo.emplace_back(
                id, id.is_valid() ? std::optional<damage_info_order>( id.obj() ) :
                std::nullopt );
            const damage_info_order_definition_data &source = *entry.definition;
            damage_info_order native;
            native.id = id;
            native.dmg_type = damage_type_id( source.id );
            native.verb = source.verb.empty() ? translation() : no_translation( source.verb );
            native.info_display = source.display == "none" ?
                                  damage_info_order::info_disp::NONE :
                                  source.display == "basic" ?
                                  damage_info_order::info_disp::BASIC :
                                  damage_info_order::info_disp::DETAILED;
            const auto assign_section = []( damage_info_order::damage_info_order_entry & target,
            const damage_info_order_section_definition_data & value ) {
                target.order = static_cast<int>( value.order );
                target.show_type = value.show_type;
            };
            for( const damage_info_order_section_definition_data &value : source.sections ) {
                if( value.section == "bionic" ) {
                    assign_section( native.bionic_info, value );
                } else if( value.section == "protection" ) {
                    assign_section( native.protection_info, value );
                } else if( value.section == "pet_protection" ) {
                    assign_section( native.pet_prot_info, value );
                } else if( value.section == "melee" ) {
                    assign_section( native.melee_combat_info, value );
                } else {
                    assign_section( native.ablative_info, value );
                }
            }
            native.was_loaded = true;
            detail::damage_info_order_registry().insert( native );
        }
        if( !pimpl_->damage_info_orders.empty() ) {
            detail::refresh_damage_info_order_registry();
        }

        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::materials, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::catalogs, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::foundations, error ) ) {
            throw std::runtime_error( error );
        }

        for( const construction_category_registration &entry :
             pimpl_->construction_categories ) {
            const construction_category_id id( entry.definition->id );
            pimpl_->construction_category_undo.emplace_back(
                id, id.is_valid() ? std::optional<construction_category>( id.obj() ) :
                std::nullopt );
            construction_category native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native._name = no_translation( entry.definition->name );
            detail::construction_category_registry().insert( native );
        }

        for( const construction_group_registration &entry : pimpl_->construction_groups ) {
            const construction_group_str_id id( entry.definition->id );
            pimpl_->construction_group_undo.emplace_back(
                id, id.is_valid() ? std::optional<construction_group>( id.obj() ) : std::nullopt );
            construction_group native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native._name = no_translation( entry.definition->name );
            detail::construction_group_registry().insert( native );
        }

        for( const vehicle_part_location_registration &entry :
             pimpl_->vehicle_part_locations ) {
            const vpart_location_id id( entry.definition->id );
            pimpl_->vehicle_part_location_undo.emplace_back(
                id, id.is_valid() ? std::optional<vpart_location>( id.obj() ) : std::nullopt );
            vpart_location native;
            native.id = id;
            native.was_loaded = true;
            native.name = no_translation( entry.definition->name );
            native.description = no_translation( entry.definition->description );
            native.z_order = static_cast<int>( entry.definition->z_order );
            native.list_order = static_cast<int>( entry.definition->list_order );
            detail::vehicle_part_location_registry().insert( native );
        }

        for( const vehicle_part_category_registration &entry :
             pimpl_->vehicle_part_categories ) {
            const std::string &id = entry.definition->id;
            const vpart_category *previous =
                detail::vehicle_part_category_registry_find( id );
            pimpl_->vehicle_part_category_undo.emplace_back(
                id, previous ? std::optional<vpart_category>( *previous ) : std::nullopt );
            vpart_category native;
            native.id_ = id;
            native.name_ = no_translation( entry.definition->name );
            native.short_name_ = no_translation( entry.definition->short_name );
            native.priority_ = static_cast<int>( entry.definition->priority );
            detail::vehicle_part_category_registry_set( native );
        }
        if( !pimpl_->vehicle_part_categories.empty() ) {
            detail::vehicle_part_category_registry_finalize();
        }

        for( const mood_face_registration &entry : pimpl_->mood_faces ) {
            const mood_face_id id( entry.definition->id );
            pimpl_->mood_face_undo.emplace_back(
                id, id.is_valid() ? std::optional<mood_face>( id.obj() ) : std::nullopt );
            mood_face native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            for( const mood_face_value_definition_data &source : entry.definition->values ) {
                mood_face_value value;
                value.was_loaded = true;
                value.value_ = static_cast<int>( source.score );
                value.face_ = source.face;
                native.values_.push_back( std::move( value ) );
            }
            std::sort( native.values_.begin(), native.values_.end(),
            []( const mood_face_value & left, const mood_face_value & right ) {
                return left.value() > right.value();
            } );
            detail::mood_face_registry().insert( native );
        }

        if( !pimpl_->named_colors.empty() ) {
            pimpl_->named_color_undo = detail::named_color_registry_snapshot();
            for( const named_color_registration &entry : pimpl_->named_colors ) {
                const named_color_definition_data &source = *entry.definition;
                detail::named_color_registry_set( {
                    source.name,
                    static_cast<std::uint8_t>( source.red ),
                    static_cast<std::uint8_t>( source.green ),
                    static_cast<std::uint8_t>( source.blue ),
                    static_cast<std::uint8_t>( source.alpha )
                } );
            }
        }

        if( !pimpl_->rotatable_symbols.empty() ) {
            pimpl_->rotatable_symbol_undo = detail::rotatable_symbol_registry_snapshot();
            for( const rotatable_symbol_registration &entry : pimpl_->rotatable_symbols ) {
                detail::rotatable_symbol_registry_set( entry.definition->symbols );
            }
        }

        for( const ascii_art_registration &entry : pimpl_->ascii_arts ) {
            const ascii_art_id id( entry.definition->id );
            pimpl_->ascii_art_undo.emplace_back(
                id, id.is_valid() ? std::optional<ascii_art>( id.obj() ) : std::nullopt );
            ascii_art native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.picture = entry.definition->lines;
            detail::ascii_art_registry().insert( native );
        }

        for( const limb_score_registration &entry : pimpl_->limb_scores ) {
            const limb_score_id id( entry.definition->id );
            pimpl_->limb_score_undo.emplace_back(
                id, id.is_valid() ? std::optional<limb_score>( id.obj() ) : std::nullopt );
            limb_score native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native._name = no_translation( entry.definition->name );
            native.wound_affect = entry.definition->affected_by_wounds;
            native.encumb_affect = entry.definition->affected_by_encumbrance;
            native.was_loaded = true;
            detail::limb_score_registry().insert( native );
        }

        if( !pimpl_->hit_ranges.empty() ) {
            pimpl_->hit_range_undo = Creature::dispersion_for_even_chance_of_good_hit;
            Creature::dispersion_for_even_chance_of_good_hit.clear();
            Creature::dispersion_for_even_chance_of_good_hit.reserve(
                pimpl_->hit_ranges.front().definition->even_good.size() );
            for( const std::int64_t value :
                 pimpl_->hit_ranges.front().definition->even_good ) {
                Creature::dispersion_for_even_chance_of_good_hit.push_back(
                    static_cast<int>( value ) );
            }
        }

        for( const overmap_land_use_code_registration &entry :
             pimpl_->overmap_land_use_codes ) {
            const overmap_land_use_code_id id( entry.definition->id );
            pimpl_->overmap_land_use_code_undo.emplace_back(
                id, id.is_valid() ? std::optional<overmap_land_use_code>( id.obj() ) :
                std::nullopt );
            const overmap_land_use_code_definition_data &source = *entry.definition;
            overmap_land_use_code native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.land_use_code = static_cast<int>( source.code );
            native.name = no_translation( source.name );
            native.detailed_definition = no_translation( source.description );
            native.symbol = source.symbol;
            native.color = color_from_string( source.color, report_color_error::no );
            detail::overmap_land_use_code_registry().insert( native );
        }

        for( const overmap_vision_registration &entry : pimpl_->overmap_visions ) {
            const oter_vision_id id( entry.definition->id );
            pimpl_->overmap_vision_undo.emplace_back(
                id, id.is_valid() ? std::optional<oter_vision>( id.obj() ) : std::nullopt );
            oter_vision native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            for( const overmap_vision_level_definition_data &source :
                 entry.definition->levels ) {
                oter_vision::level level;
                level.blends_adjacent = source.blends_adjacent;
                if( !source.blends_adjacent ) {
                    level.name = no_translation( source.name );
                    level.symbol = source.symbol;
                    level.color = color_from_string(
                                      source.color, report_color_error::no );
                    level.looks_like = source.looks_like;
                }
                native.levels.push_back( std::move( level ) );
            }
            detail::overmap_vision_registry().insert( native );
        }
        if( !pimpl_->overmap_visions.empty() ) {
            detail::overmap_vision_registry().finalize();
        }

        for( const overmap_location_registration &entry : pimpl_->overmap_locations ) {
            const overmap_location_id id( entry.definition->id );
            pimpl_->overmap_location_undo.emplace_back(
                id, id.is_valid() ? std::optional<overmap_location>( id.obj() ) : std::nullopt );
            overmap_location native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            for( const std::string &terrain : entry.definition->terrains ) {
                native.terrains.insert( oter_type_str_id( terrain ) );
            }
            native.flags = entry.definition->terrain_flags;
            detail::overmap_location_registry().insert( native );
        }
        if( !pimpl_->overmap_locations.empty() ) {
            detail::overmap_location_registry().finalize();
        }

        apply_character_phase( character_content_apply_phase::profession );
        apply_character_phase( character_content_apply_phase::profession_group );
        apply_character_phase( character_content_apply_phase::widget );
        apply_character_phase( character_content_apply_phase::enchantment );
        apply_character_phase( character_content_apply_phase::bionic );
        apply_character_phase( character_content_apply_phase::spell );
        apply_character_phase( character_content_apply_phase::mission_definition );
        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::mutation, error ) ) {
            rollback();
            return false;
        }
        apply_character_phase( character_content_apply_phase::profession_item );

        for( const map_extra_collection_registration &entry : pimpl_->map_extra_collections ) {
            const map_extra_collection_id id( entry.definition->id );
            pimpl_->map_extra_collection_undo.emplace_back(
                id, id.is_valid() ? std::optional<map_extra_collection>( id.obj() ) : std::nullopt );
            map_extra_collection native;
            native.id = id;
            native.chance = static_cast<unsigned int>( entry.definition->chance );
            native.was_loaded = true;
            for( const auto &[extra, weight] : entry.definition->entries ) {
                native.values.add( map_extra_id( extra ), static_cast<int>( weight ) );
            }
            detail::map_extra_collection_registry().insert( native );
        }
        if( !pimpl_->map_extra_collections.empty() ) {
            detail::map_extra_collection_registry().finalize();
        }

        for( const vehicle_group_registration &entry : pimpl_->vehicle_groups ) {
            const VehicleGroup *const previous =
                detail::vehicle_group_registry_find( entry.definition->id );
            pimpl_->vehicle_group_undo.emplace_back(
                entry.definition->id,
                previous ? std::optional<VehicleGroup>( *previous ) : std::nullopt );
            VehicleGroup native;
            for( const auto &[vehicle, weight] : entry.definition->entries ) {
                native.add_vehicle( vproto_id( vehicle ), static_cast<int>( weight ) );
            }
            detail::vehicle_group_registry_set( entry.definition->id, native );
        }

        for( const vehicle_placement_registration &entry : pimpl_->vehicle_placements ) {
            const VehiclePlacement *const previous =
                detail::vehicle_placement_registry_find( entry.definition->id );
            pimpl_->vehicle_placement_undo.emplace_back(
                entry.definition->id,
                previous ? std::optional<VehiclePlacement>( *previous ) : std::nullopt );
            VehiclePlacement native;
            for( const vehicle_placement_location_definition_data &location :
                 entry.definition->locations ) {
                std::vector<units::angle> facings;
                facings.reserve( location.facings.size() );
                for( const std::int64_t facing : location.facings ) {
                    facings.push_back( units::from_degrees( static_cast<int>( facing ) ) );
                }
                native.add(
                    jmapgen_int( static_cast<int>( location.x_min ),
                                 static_cast<int>( location.x_max ) ),
                    jmapgen_int( static_cast<int>( location.y_min ),
                                 static_cast<int>( location.y_max ) ),
                    VehicleFacings( std::move( facings ) ) );
            }
            detail::vehicle_placement_registry_set( entry.definition->id, native );
        }

        for( const vehicle_spawn_registration &entry : pimpl_->vehicle_spawns ) {
            const VehicleSpawn *const previous =
                detail::vehicle_spawn_registry_find( entry.definition->id );
            pimpl_->vehicle_spawn_undo.emplace_back(
                entry.definition->id,
                previous ? std::optional<VehicleSpawn>( *previous ) : std::nullopt );
            VehicleSpawn native;
            for( const vehicle_spawn_entry_definition_data &spawn : entry.definition->entries ) {
                if( spawn.builtin ) {
                    native.add( spawn.weight, VehicleSpawn::make_builtin( spawn.builtin_id ) );
                    continue;
                }
                std::optional<VehicleLocation> native_location;
                if( spawn.location ) {
                    const vehicle_placement_location_definition_data &location = *spawn.location;
                    std::vector<units::angle> facings;
                    facings.reserve( location.facings.size() );
                    for( const std::int64_t facing : location.facings ) {
                        facings.push_back( units::from_degrees( static_cast<int>( facing ) ) );
                    }
                    native_location.emplace(
                        jmapgen_int( static_cast<int>( location.x_min ),
                                     static_cast<int>( location.x_max ) ),
                        jmapgen_int( static_cast<int>( location.y_min ),
                                     static_cast<int>( location.y_max ) ),
                        VehicleFacings( std::move( facings ) ) );
                }
                native.add(
                    spawn.weight,
                    std::make_shared<VehicleFunction_json>(
                        vgroup_id( spawn.vehicle_group ),
                        jmapgen_int( static_cast<int>( spawn.number_min ),
                                     static_cast<int>( spawn.number_max ) ),
                        static_cast<int>( spawn.fuel ), static_cast<int>( spawn.status ),
                        spawn.placement, std::move( native_location ) ) );
            }
            detail::vehicle_spawn_registry_set( entry.definition->id, native );
        }

        for( const fault_group_registration &entry : pimpl_->fault_groups ) {
            const fault_group_id id( entry.definition->id );
            pimpl_->fault_group_undo.emplace_back(
                id, id.is_valid() ? std::optional<fault_group>( id.obj() ) : std::nullopt );
            fault_group native;
            native.id = id;
            native.was_loaded = true;
            for( const auto &[fault, weight] : entry.definition->entries ) {
                native.fault_weighted_list.add( fault_id( fault ), static_cast<int>( weight ) );
            }
            detail::fault_group_registry().insert( native );
        }
        if( !pimpl_->fault_groups.empty() ) {
            detail::fault_group_registry().finalize();
        }

        for( const explosion_light_registration &entry : pimpl_->explosion_lights ) {
            const explosion_light_str_id id( entry.definition->id );
            pimpl_->explosion_light_undo.emplace_back(
                id, id.is_valid() ? std::optional<explosion_light>( id.obj() ) : std::nullopt );
            const explosion_light_definition_data &source = *entry.definition;
            explosion_light native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.stops = source.stops;
            native.easing = *platform_vfx_easing( source.easing );
            native.wave_travel = static_cast<float>( source.wave_travel );
            native.wave_gap = static_cast<float>( source.wave_gap );
            native.rise = static_cast<float>( source.rise );
            native.fade = static_cast<float>( source.fade );
            native.blend = static_cast<float>( source.blend );
            native.spread_jitter = static_cast<float>( source.spread_jitter );
            native.color_jitter = static_cast<float>( source.color_jitter );
            native.flicker = static_cast<float>( source.flicker );
            native.duration_base_ms = static_cast<float>( source.duration_base_ms );
            native.duration_per_tile_ms = static_cast<float>( source.duration_per_tile_ms );
            native.duration_min_ms = static_cast<float>( source.duration_min_ms );
            native.duration_max_ms = static_cast<float>( source.duration_max_ms );
            native.screen_shake_magnitude =
                static_cast<float>( source.screen_shake_magnitude );
            native.screen_shake_duration_ms =
                static_cast<float>( source.screen_shake_duration_ms );
            native.shockwave = source.shockwave;
            native.shockwave_strength = static_cast<float>( source.shockwave_strength );
            native.shockwave_speed = static_cast<float>( source.shockwave_speed );
            native.shockwave_thickness = static_cast<float>( source.shockwave_thickness );
            get_all_explosion_lights().insert( native );
        }
        if( !pimpl_->explosion_lights.empty() ) {
            get_all_explosion_lights().finalize();
        }

        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::ammunition_effects, error ) ) {
            throw std::runtime_error( error );
        }

        for( const addiction_type_registration &entry : pimpl_->addiction_types ) {
            const addiction_id id( entry.definition->id );
            pimpl_->addiction_type_undo.emplace_back(
                id, id.is_valid() ? std::optional<add_type>( id.obj() ) : std::nullopt );
            const addiction_type_definition_data &source = *entry.definition;
            add_type native;
            native.id = id;
            native.was_loaded = true;
            native._name = no_translation( source.name );
            native._type_name = no_translation( source.type_name );
            native._desc = no_translation( source.description );
            native._craving_morale = source.craving_morale.empty() ?
                                     morale_type::NULL_ID() : morale_type( source.craving_morale );
            native._effect = effect_on_condition_id::NULL_ID();
            native._builtin.clear();
            native._lua_policy = true;
            detail::addiction_type_registry().insert( native );
        }
        if( !pimpl_->addiction_types.empty() ) {
            detail::addiction_type_registry().finalize();
        }

        for( const character_modifier_registration &entry : pimpl_->character_modifiers ) {
            const character_modifier_id id( entry.definition->id );
            pimpl_->character_modifier_undo.emplace_back(
                id, id.is_valid() ? std::optional<character_modifier>( id.obj() ) : std::nullopt );
            const character_modifier_definition_data &source = *entry.definition;
            character_modifier native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.desc = no_translation( source.description );
            native.modtype = source.operation == "add" ? character_modifier::ADD :
                             source.operation == "multiply" ? character_modifier::MULT :
                             character_modifier::NONE;
            native.builtin.clear();
            native.limbscores.clear();
            detail::character_modifier_registry().insert( native );
        }
        if( !pimpl_->character_modifiers.empty() ) {
            detail::character_modifier_registry().finalize();
        }

        for( const start_location_registration &entry : pimpl_->start_locations ) {
            const start_location_id id( entry.definition->id );
            pimpl_->start_location_undo.emplace_back(
                id, id.is_valid() ? std::optional<start_location>( id.obj() ) : std::nullopt );
            const start_location_definition_data &source = *entry.definition;
            start_location native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native._name = no_translation( source.name );
            native._flags = source.flags;
            native.constraints_.city_size = {
                static_cast<int>( source.city_size_min ),
                static_cast<int>( source.city_size_max )
            };
            native.constraints_.city_distance = {
                static_cast<int>( source.city_distance_min ),
                static_cast<int>( source.city_distance_max )
            };
            native.constraints_.allowed_z_levels = {
                static_cast<int>( source.z_min ), static_cast<int>( source.z_max )
            };
            for( const start_location_target_definition_data &target : source.targets ) {
                omt_types_parameters value;
                value.omt = target.terrain;
                value.omt_type = *platform_ot_match_type( target.match );
                value.parameters = target.parameters;
                native._locations.push_back( std::move( value ) );
            }
            detail::start_location_registry().insert( native );
        }
        if( !pimpl_->start_locations.empty() ) {
            detail::start_location_registry().finalize();
        }

        for( const climbing_aid_registration &entry : pimpl_->climbing_aids ) {
            const climbing_aid_id id( entry.definition->id );
            pimpl_->climbing_aid_undo.emplace_back(
                id, id.is_valid() ? std::optional<climbing_aid>( id.obj() ) : std::nullopt );
            const climbing_aid_definition_data &source = *entry.definition;
            climbing_aid native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.slip_chance_mod = static_cast<int>( source.slip_chance_modifier );
            native.base_condition.cat = *platform_climbing_category( source.category );
            native.base_condition.flag = source.flag;
            native.base_condition.uses_item = static_cast<int>( source.uses );
            native.base_condition.range = static_cast<int>( source.range );
            native.down.was_loaded = true;
            native.down.max_height = static_cast<int>( source.max_height );
            native.down.easy_climb_back_up = static_cast<int>( source.easy_climb_back_up );
            native.down.allow_remaining_height = source.allow_remaining_height;
            native.down.menu_text = no_translation( source.menu_text );
            native.down.menu_cant = source.unavailable_text.empty() ? translation() :
                                    no_translation( source.unavailable_text );
            native.down.menu_hotkey = source.hotkey.empty() ? 0 :
                                      static_cast<unsigned char>( source.hotkey.front() );
            native.down.confirm_text = no_translation( source.confirm_text );
            native.down.msg_before = source.before_message.empty() ? translation() :
                                     no_translation( source.before_message );
            native.down.msg_after = source.after_message.empty() ? translation() :
                                    no_translation( source.after_message );
            native.down.cost.pain = static_cast<int>( source.pain );
            native.down.cost.damage = static_cast<int>( source.damage );
            native.down.cost.kcal = static_cast<int>( source.kilocalories );
            native.down.cost.thirst = static_cast<int>( source.thirst );
            native.down.deploy_furn = furn_str_id( source.deploy_furniture );
            detail::climbing_aid_registry().insert( native );
        }
        if( !pimpl_->climbing_aids.empty() ) {
            detail::refresh_climbing_aid_registry();
        }

        for( const weather_type_registration &entry : pimpl_->weather_types ) {
            const weather_type_id id( entry.definition->id );
            pimpl_->weather_type_undo.emplace_back(
                id, id.is_valid() ? std::optional<weather_type>( id.obj() ) : std::nullopt );
            const weather_type_definition_data &source = *entry.definition;
            weather_type native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.name = no_translation( source.name );
            native.color = color_from_string( source.color, report_color_error::no );
            native.map_color = color_from_string( source.map_color, report_color_error::no );
            native.symbol = UTF8_getch( source.symbol );
            native.sun_symbol = UTF8_getch( source.sun_symbol );
            native.ranged_penalty = static_cast<int>( source.ranged_penalty );
            native.sight_penalty = static_cast<float>( source.sight_penalty );
            native.light_modifier = static_cast<int>( source.light_modifier );
            native.temperature_modifier = units::from_kelvin_delta(
                                              source.temperature_delta_kelvin );
            native.light_multiplier = static_cast<float>( source.light_multiplier );
            native.sun_multiplier = static_cast<float>( source.sun_multiplier );
            native.sound_attn = static_cast<int>( source.sound_attenuation );
            native.dangerous = source.dangerous;
            native.precip = *platform_precipitation( source.precipitation );
            native.rains = source.rains;
            native.tiles_animation = source.tiles_animation;
            native.sound_category = *platform_weather_sound_category( source.sound_category );
            native.priority = static_cast<int>( source.priority );
            native.duration_min = time_duration::from_turns(
                                      static_cast<int>( source.minimum_duration_turns ) );
            native.duration_max = time_duration::from_turns(
                                      static_cast<int>( source.maximum_duration_turns ) );
            if( source.has_animation ) {
                native.weather_animation.factor = static_cast<float>( source.animation_factor );
                native.weather_animation.color = color_from_string(
                                                     source.animation_color, report_color_error::no );
                native.weather_animation.symbol = UTF8_getch( source.animation_symbol );
            }
            for( const std::string &weather : source.required_weathers ) {
                native.required_weathers.emplace_back( weather );
            }
            for( const weather_passive_effect_definition_data &effect_source :
                 source.passive_effects ) {
                field_effect effect;
                effect.id = efftype_id( effect_source.effect );
                effect.min_duration = time_duration::from_turns(
                                          static_cast<int>( effect_source.minimum_duration_turns ) );
                effect.max_duration = time_duration::from_turns(
                                          static_cast<int>( effect_source.maximum_duration_turns ) );
                effect.intensity = static_cast<int>( effect_source.intensity );
                effect.bp = effect_source.body_part.empty() ?
                            bodypart_str_id::NULL_ID() :
                            bodypart_str_id( effect_source.body_part );
                effect.is_environmental = effect_source.environmental;
                effect.immune_in_vehicle = effect_source.immune_in_vehicle;
                effect.immune_inside_vehicle = effect_source.immune_inside_vehicle;
                effect.immune_outside_vehicle = effect_source.immune_outside_vehicle;
                effect.chance_in_vehicle = static_cast<int>( effect_source.chance_in_vehicle );
                effect.chance_inside_vehicle = static_cast<int>(
                                                   effect_source.chance_inside_vehicle );
                effect.chance_outside_vehicle = static_cast<int>(
                                                    effect_source.chance_outside_vehicle );
                effect.message = effect_source.message.empty() ? translation() :
                                 no_translation( effect_source.message );
                effect.message_npc = effect_source.npc_message.empty() ? translation() :
                                     no_translation( effect_source.npc_message );
                native.passive_effect.push_back( std::move( effect ) );
            }
            native.condition = []( const const_dialogue & ) {
                return false;
            };
            native.debug_cause_eoc.reset();
            native.debug_leave_eoc.reset();
            detail::weather_type_registry().insert( native );
        }
        if( !pimpl_->weather_types.empty() ) {
            detail::weather_type_registry().finalize();
        }

        for( const event_transformation_registration &entry : pimpl_->event_transformations ) {
            pimpl_->event_transformation_undo.emplace_back(
                entry.definition->id,
                detail::snapshot_event_transformation( entry.definition->id ) );
            detail::register_event_transformation( *entry.definition, pimpl_->owner );
        }
        if( !pimpl_->event_transformations.empty() ) {
            detail::finalize_event_transformations();
        }

        for( const event_statistic_registration &entry : pimpl_->event_statistics ) {
            pimpl_->event_statistic_undo.emplace_back(
                entry.definition->id,
                detail::snapshot_event_statistic( entry.definition->id ) );
            detail::register_event_statistic( *entry.definition, pimpl_->owner );
        }
        if( !pimpl_->event_statistics.empty() ) {
            detail::finalize_event_statistics();
        }

        for( const relic_procgen_registration &entry : pimpl_->relic_procgens ) {
            const relic_procgen_id id( entry.definition->id );
            pimpl_->relic_procgen_undo.emplace_back(
                id, id.is_valid() ? std::optional<relic_procgen_data>( id.obj() ) :
                std::nullopt );
            relic_procgen_data native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            for( const relic_procgen_passive_definition_data &source :
                 entry.definition->passive_values ) {
                relic_procgen_data::enchantment_value_passive<float> value;
                value.type = io::string_to_enum<enchant_vals::mod>( source.type );
                value.power_per_increment = static_cast<int>( source.power_per_increment );
                value.increment = static_cast<float>( source.increment );
                value.min_value = static_cast<float>( source.minimum );
                value.max_value = static_cast<float>( source.maximum );
                value.ench_has = io::string_to_enum<enchantment::has>( source.has );
                value.was_loaded = true;
                if( source.kind == "passive_enchantment_add" ) {
                    native.passive_add_procgen_values.add(
                        value, static_cast<int>( source.weight ) );
                } else {
                    native.passive_mult_procgen_values.add(
                        value, static_cast<int>( source.weight ) );
                }
            }
            for( const relic_procgen_active_definition_data &source :
                 entry.definition->active_values ) {
                relic_procgen_data::enchantment_active value;
                value.activated_spell = spell_id( source.spell );
                value.base_power = static_cast<int>( source.base_power );
                value.power_per_increment = static_cast<int>( source.power_per_increment );
                value.increment = static_cast<int>( source.increment );
                value.min_level = static_cast<int>( source.minimum_level );
                value.max_level = static_cast<int>( source.maximum_level );
                value.ench_has = io::string_to_enum<enchantment::has>( source.has );
                value.was_loaded = true;
                if( source.kind == "hit_you" ) {
                    native.passive_hit_you.add( value, static_cast<int>( source.weight ) );
                } else if( source.kind == "hit_me" ) {
                    native.passive_hit_me.add( value, static_cast<int>( source.weight ) );
                } else {
                    native.active_procgen_values.add( value, static_cast<int>( source.weight ) );
                }
            }
            for( const auto &[kind, weight] : entry.definition->type_weights ) {
                native.type_weights.add(
                    io::string_to_enum<relic_procgen_data::type>( kind ),
                    static_cast<int>( weight ) );
            }
            for( const auto &[item_id, weight] : entry.definition->item_weights ) {
                native.item_weights.add( itype_id( item_id ), static_cast<int>( weight ) );
            }
            for( const relic_procgen_charge_definition_data &source :
                 entry.definition->charges ) {
                relic_charge_template value;
                value.init_charges = { static_cast<int>( source.initial_minimum ),
                                       static_cast<int>( source.initial_maximum )
                                     };
                value.charges_per_use = { static_cast<int>( source.use_minimum ),
                                          static_cast<int>( source.use_maximum )
                                        };
                value.max_charges = { static_cast<int>( source.maximum_minimum ),
                                      static_cast<int>( source.maximum_maximum )
                                    };
                value.time = {
                    time_duration::from_turns( static_cast<int>( source.time_minimum_turns ) ),
                    time_duration::from_turns( static_cast<int>( source.time_maximum_turns ) )
                };
                value.power_level = static_cast<int>( source.power );
                value.type = io::string_to_enum<relic_recharge_type>( source.recharge_type );
                native.charge_values.add( value, static_cast<int>( source.weight ) );
            }
            detail::relic_procgen_registry().insert( native );
        }
        if( !pimpl_->relic_procgens.empty() ) {
            detail::relic_procgen_registry().finalize();
        }

        if( !pimpl_->presentation.apply( error ) ) {
            throw std::runtime_error( error );
        }

        for( const attack_vector_registration &entry : pimpl_->attack_vectors ) {
            const attack_vector_id id( entry.definition->id );
            pimpl_->attack_vector_undo.emplace_back(
                id, id.is_valid() ? std::optional<attack_vector>( id.obj() ) : std::nullopt );
            const attack_vector_definition_data &source = *entry.definition;
            attack_vector native;
            native.id = id;
            native.weapon = source.weapon;
            native.strict_limb_definition = source.strict_limbs;
            native.armor_bonus = source.armor_bonus;
            native.encumbrance_limit = static_cast<int>( source.encumbrance_limit );
            native.bp_hp_limit = static_cast<int>( source.health_percent_limit );
            for( const std::string &limb : source.limbs ) {
                native.authored_limbs.emplace_back( limb );
            }
            for( const std::string &contact : source.contacts ) {
                native.authored_contact_area.emplace_back( contact );
            }
            native.limbs = native.authored_limbs;
            native.contact_area = native.authored_contact_area;
            for( const auto &[kind, count] : source.limb_requirements ) {
                native.limb_req.emplace_back( io::string_to_enum<bp_type>( kind ),
                                              static_cast<int>( count ) );
            }
            for( const std::string &flag : source.required_flags ) {
                native.required_limb_flags.insert( flag_id( flag ) );
            }
            for( const std::string &flag : source.forbidden_flags ) {
                native.forbidden_limb_flags.insert( flag_id( flag ) );
            }
            native.was_loaded = true;
            detail::attack_vector_registry().insert( native );
        }
        if( !pimpl_->attack_vectors.empty() ) {
            detail::refresh_attack_vector_registry();
        }

        apply_character_phase( character_content_apply_phase::technique );
        apply_character_phase( character_content_apply_phase::martial_art );
        for( const trap_registration &entry : pimpl_->traps ) {
            const trap_str_id id( entry.definition->id );
            pimpl_->trap_undo.emplace_back(
                id, id.is_valid() ? std::optional<trap>( id.obj() ) :
                std::nullopt );
            const trap_definition_data &source = *entry.definition;
            trap native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.name_ = no_translation( source.name );
            native.color = color_from_string( source.color, report_color_error::no );
            native.sym = static_cast<int>( source.symbol[0] );
            native.visibility = static_cast<int>( source.visibility );
            native.avoidance = static_cast<int>( source.avoidance );
            native.difficulty = static_cast<int>( source.difficulty );
            native.act = trap_function_from_string( source.action );
            native.lua_platform_mod = pimpl_->owner;
            native.lua_platform_trigger_handler = source.trigger_handler;
            if( !source.memorial_male.empty() && !source.memorial_female.empty() ) {
                native.memorial_male = no_translation( source.memorial_male );
                native.memorial_female = no_translation( source.memorial_female );
            }
            if( !source.trigger_message_u.empty() ) {
                native.trigger_message_u = no_translation( source.trigger_message_u );
            }
            if( !source.trigger_message_npc.empty() ) {
                native.trigger_message_npc = no_translation( source.trigger_message_npc );
            }
            for( const std::string &flag : source.flags ) {
                native._flags.insert( flag_id( flag ) );
            }
            native.trap_radius = static_cast<int>( source.trap_radius );
            native.benign = source.benign;
            native.always_invisible = source.always_invisible;
            native.funnel_radius_mm = static_cast<int>( source.funnel_radius );
            native.comfort = static_cast<int>( source.comfort );
            native.trigger_weight = units::from_gram(
                                        static_cast<int>( source.trigger_weight_grams ) );
            native.sound_threshold = {
                static_cast<int>( source.sound_threshold_min ),
                static_cast<int>( source.sound_threshold_max )
            };
            for( const auto &[item, quantity, charges] : source.drops ) {
                native.components.push_back( trap::comp{
                    itype_id( item ), static_cast<int>( quantity ),
                    static_cast<int>( charges )
                } );
            }
            native.was_loaded = true;
            detail::trap_registry().insert( native );
        }
        if( !pimpl_->traps.empty() ) {
            detail::trap_registry().finalize();
        }

        for( const construction_registration &entry : pimpl_->constructions ) {
            const construction_str_id id( entry.definition->id );
            pimpl_->construction_undo.emplace_back(
                id, id.is_valid() ? std::optional<construction>( id.obj() ) :
                std::nullopt );
            const construction_definition_data &source = *entry.definition;
            const requirement_id inline_requirement(
                "inline_construction_" + source.id );
            const auto previous_requirement =
                requirement_data::registry().find( inline_requirement );
            pimpl_->construction_requirement_undo.emplace_back(
                inline_requirement,
                previous_requirement == requirement_data::registry().end() ?
                std::optional<requirement_data>() :
                std::optional<requirement_data>( previous_requirement->second ) );
            requirement_data empty_requirement;
            empty_requirement.id_ = inline_requirement;
            requirement_data::registry()[inline_requirement] =
                std::move( empty_requirement );
            construction native;
            native.id = id;
            native.group = construction_group_str_id( source.group );
            native.category = construction_category_id( source.category );
            native.time = static_cast<int>( source.time_moves );
            native.activity_level = static_cast<float>( source.activity_level );
            if( !source.pre_note.empty() ) {
                native.pre_note = no_translation( source.pre_note );
            }
            native.post_terrain = source.post_terrain;
            for( const std::string &terrain : source.pre_terrain ) {
                native.pre_terrain.insert( terrain );
            }
            for( const std::string &flag : source.post_flags ) {
                native.post_flags.insert( flag );
            }
            for( const auto &[flag, force] : source.pre_flags ) {
                native.pre_flags.emplace( flag, force );
            }
            for( const auto &[skill, level] : source.required_skills ) {
                native.required_skills[skill_id( skill )] = static_cast<int>( level );
            }
            for( const auto &[requirement, multiplier] : source.reqs_using ) {
                native.reqs_using.emplace_back( requirement_id( requirement ),
                                                static_cast<int>( multiplier ) );
            }
            native.requirements = inline_requirement;
            native.was_loaded = true;
            detail::construction_registry().insert( native );
        }
        if( !pimpl_->constructions.empty() ) {
            detail::construction_registry().finalize();
        }

        for( const furniture_registration &entry : pimpl_->furniture ) {
            const furn_str_id id( entry.definition->id );
            pimpl_->furniture_undo.emplace_back(
                id, id.is_valid() ? std::optional<furn_t>( id.obj() ) :
                std::nullopt );
            const furniture_definition_data &source = *entry.definition;
            furn_t native;
            native.id = id;
            native.name_ = no_translation( source.name );
            native.description = no_translation( source.description );
            native.color_.fill( color_from_string( source.color,
                                                   report_color_error::no ) );
            native.symbol_.fill( static_cast<int>( source.symbol[0] ) );
            native.movecost = static_cast<int>( source.movecost );
            native.move_str_req = static_cast<int>( source.required_str );
            native.light_emitted = static_cast<int>( source.light_emitted );
            native.comfort = static_cast<int>( source.comfort );
            native.max_volume = units::from_milliliter(
                                    static_cast<int>( source.max_volume_ml ) );
            native.mass = units::from_gram(
                              static_cast<int>( source.mass_grams ) );
            native.keg_capacity = units::from_milliliter(
                                      static_cast<int>( source.keg_capacity_ml ) );
            native.transparent = source.transparent;
            for( const std::string &flag : source.flags ) {
                native.set_flag( flag );
            }
            if( !source.open.empty() ) {
                native.open = furn_str_id( source.open );
            }
            if( !source.close.empty() ) {
                native.close = furn_str_id( source.close );
            }
            if( !source.lockpick_result.empty() ) {
                native.lockpick_result = furn_str_id( source.lockpick_result );
            }
            native.crafting_pseudo_item = itype_id( source.crafting_pseudo_item );
            native.deployed_item = itype_id( source.deployed_item );
            if( !source.examine_handler.empty() ) {
                native.examine_actor.emplace_back(
                    std::make_unique<lua_platform_examine_actor>(
                        "furniture", source.id, pimpl_->owner,
                        source.examine_handler, source.examine_name ) );
            }
            native.was_loaded = true;
            detail::furniture_registry().insert( native );
        }
        if( !pimpl_->furniture.empty() ) {
            detail::furniture_registry().finalize();
        }

        for( const terrain_registration &entry : pimpl_->terrain ) {
            const ter_str_id id( entry.definition->id );
            pimpl_->terrain_undo.emplace_back(
                id, id.is_valid() ? std::optional<ter_t>( id.obj() ) :
                std::nullopt );
            const terrain_definition_data &source = *entry.definition;
            ter_t native;
            native.id = id;
            native.name_ = no_translation( source.name );
            native.description = no_translation( source.description );
            native.color_.fill( color_from_string( source.color,
                                                   report_color_error::no ) );
            native.symbol_.fill( static_cast<int>( source.symbol[0] ) );
            native.movecost = static_cast<int>( source.movecost );
            native.light_emitted = static_cast<int>( source.light_emitted );
            native.comfort = static_cast<int>( source.comfort );
            native.max_volume = units::from_milliliter(
                                    static_cast<int>( source.max_volume_ml ) );
            native.heat_radiation = static_cast<int>( source.heat_radiation );
            native.transparent = source.transparent;
            for( const std::string &flag : source.flags ) {
                native.set_flag( flag );
            }
            if( !source.open.empty() ) {
                native.open = ter_str_id( source.open );
            }
            if( !source.close.empty() ) {
                native.close = ter_str_id( source.close );
            }
            if( !source.transforms_into.empty() ) {
                native.transforms_into = ter_str_id( source.transforms_into );
            }
            if( !source.roof.empty() ) {
                native.roof = ter_str_id( source.roof );
            }
            if( !source.lockpick_result.empty() ) {
                native.lockpick_result = ter_str_id( source.lockpick_result );
            }
            native.trap = trap_str_id( source.trap );
            if( !source.examine_handler.empty() ) {
                native.examine_actor.emplace_back(
                    std::make_unique<lua_platform_examine_actor>(
                        "terrain", source.id, pimpl_->owner,
                        source.examine_handler, source.examine_name ) );
            }
            native.was_loaded = true;
            detail::terrain_registry().insert( native );
        }
        if( !pimpl_->terrain.empty() ) {
            detail::terrain_registry().finalize();
        }

        for( const gate_registration &entry : pimpl_->gates ) {
            const gate_id id( entry.definition->id );
            pimpl_->gate_undo.emplace_back(
                id, id.is_valid() ? std::optional<gate_data>( id.obj() ) :
                std::nullopt );
            const gate_definition_data &source = *entry.definition;
            gate_data native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.door = ter_str_id( source.door );
            native.floor = ter_str_id( source.floor );
            for( const std::string &wall : source.walls ) {
                native.walls.emplace_back( wall );
            }
            if( !source.pull_message.empty() ) {
                native.pull_message = no_translation( source.pull_message );
            }
            if( !source.open_message.empty() ) {
                native.open_message = no_translation( source.open_message );
            }
            if( !source.close_message.empty() ) {
                native.close_message = no_translation( source.close_message );
            }
            if( !source.fail_message.empty() ) {
                native.fail_message = no_translation( source.fail_message );
            }
            native.moves = static_cast<int>( source.moves );
            native.bash_dmg = static_cast<int>( source.bashing_damage );
            native.was_loaded = true;
            detail::gate_registry().insert( native );
        }
        if( !pimpl_->gates.empty() ) {
            detail::gate_registry().finalize();
        }

        for( const fault_registration &entry : pimpl_->faults ) {
            const fault_id id( entry.definition->id );
            pimpl_->fault_undo.emplace_back(
                id, id.is_valid() ? std::optional<fault>( id.obj() ) :
                std::nullopt );
            const fault_definition_data &source = *entry.definition;
            fault native;
            native.id = id;
            native.type_ = source.fault_type;
            native.name_ = no_translation( source.name );
            native.description_ = no_translation( source.description );
            if( !source.item_prefix.empty() ) {
                native.item_prefix_ = no_translation( source.item_prefix );
            }
            if( !source.item_suffix.empty() ) {
                native.item_suffix_ = no_translation( source.item_suffix );
            }
            if( !source.message.empty() ) {
                native.message_ = no_translation( source.message );
            }
            native.color_ = source.color;
            native.price_modifier = source.price_modifier;
            native.degradation_mod_ = static_cast<int>( source.degradation_mod );
            native.instant_damage_ = static_cast<int>( source.instant_damage );
            native.contact_area_mod_ = static_cast<float>( source.contact_area_mod );
            native.rolling_resistance_mod_ =
                static_cast<float>( source.rolling_resistance_mod );
            native.vehicle_move_penalty_mod_ =
                static_cast<int>( source.vehicle_move_penalty_mod );
            native.encumbrance_mod_flat_ =
                static_cast<int>( source.encumbrance_mod_flat );
            native.encumbrance_mod_mult_ =
                static_cast<float>( source.encumbrance_mod_mult );
            native.affected_by_degradation_ = source.affected_by_degradation;
            native.flags = source.flags;
            for( const std::string &blocked : source.block_faults ) {
                native.block_faults.insert( fault_id( blocked ) );
            }
            for( const std::string &fix : source.fixes ) {
                native.fixes.insert( fault_fix_id( fix ) );
            }
            // Legacy derives each fault's fix links at fault-fix finalize
            // time (faults_removed reverse-links into the fault), so a
            // replaced fault must re-derive them from the fault-fix registry
            // or the set would silently drop every linked fix.
            for( const fault_fix &fix :
                 detail::fault_fix_registry().get_all() ) {
                if( fix.faults_removed.count( id ) != 0 ) {
                    native.fixes.insert( fix.id );
                }
            }
            native.was_loaded = true;
            detail::fault_registry().insert( native );
        }
        if( !pimpl_->faults.empty() ) {
            detail::fault_registry().finalize();
        }

        for( const fault_fix_registration &entry : pimpl_->fault_fixes ) {
            const fault_fix_id id( entry.definition->id );
            pimpl_->fault_fix_undo.emplace_back(
                id, id.is_valid() ? std::optional<fault_fix>( id.obj() ) :
                std::nullopt );
            const fault_fix_definition_data &source = *entry.definition;
            fault_fix native;
            native.id = id;
            native.name = no_translation( source.name );
            if( !source.success_msg.empty() ) {
                native.success_msg = no_translation( source.success_msg );
            }
            native.time = time_duration::from_seconds(
                              static_cast<int>( source.time_seconds ) );
            native.mod_damage = static_cast<int>( source.mod_damage );
            native.mod_degradation = static_cast<int>( source.mod_degradation );
            for( const auto &[skill, level] : source.skills ) {
                native.skills[skill_id( skill )] = static_cast<int>( level );
            }
            for( const std::string &removed : source.faults_removed ) {
                native.faults_removed.insert( fault_id( removed ) );
            }
            for( const std::string &added : source.faults_added ) {
                native.faults_added.insert( fault_id( added ) );
            }
            native.was_loaded = true;
            detail::fault_fix_registry().insert( native );
        }
        if( !pimpl_->fault_fixes.empty() ) {
            // Finalize only the staged fixes: fault_fix::finalize accumulates
            // requirement data, so re-running it over the whole registry
            // would double every legacy fix's requirement set.
            for( const fault_fix_registration &entry : pimpl_->fault_fixes ) {
                for( fault_fix &fix : detail::fault_fix_registry().get_all_mod() ) {
                    if( fix.id == fault_fix_id( entry.definition->id ) ) {
                        fix.finalize();
                    }
                }
            }
        }

        if( !pimpl_->dreams.empty() ) {
            pimpl_->dream_undo = detail::dream_count();
        }
        for( const dream_registration &entry : pimpl_->dreams ) {
            const dream_definition_data &source = *entry.definition;
            dream native;
            native.category = mutation_category_id( source.category );
            native.strength = static_cast<int>( source.strength );
            for( const std::string &message : source.messages ) {
                native.raw_messages.emplace_back( no_translation( message ) );
            }
            detail::append_dream( native );
        }

        for( const achievement_registration &entry : pimpl_->achievements ) {
            const achievement_id id( entry.definition->id );
            pimpl_->achievement_undo.push_back( id );
            const achievement_definition_data &source = *entry.definition;
            detail::insert_platform_achievement( detail::platform_achievement_data{
                source.id, source.name, source.description,
                source.is_conduct, source.hidden_by
            } );
        }
        if( !pimpl_->achievements.empty() ) {
            detail::finalize_platform_achievements();
        }

        for( const blacklist_registration &entry : pimpl_->blacklists ) {
            const detail::platform_blacklist_data &source = *entry.definition;
            if( source.kind == "item" ) {
                if( pimpl_->item_blacklist_undo == 0 ) {
                    pimpl_->item_blacklist_undo =
                        detail::platform_item_blacklist_count();
                }
                detail::insert_platform_item_blacklist( source );
            } else {
                pimpl_->blacklist_undo.push_back( source );
                if( source.kind == "trait" ) {
                    detail::insert_platform_trait_blacklist( source.entries );
                } else if( source.kind == "monster" ) {
                    detail::insert_platform_monster_blacklist(
                        source.entries, source.whitelist );
                } else if( source.kind == "scenario" ) {
                    detail::insert_platform_scenario_blacklist( source );
                } else if( source.kind == "profession" ) {
                    detail::insert_platform_profession_blacklist( source );
                } else {
                    detail::insert_platform_savegame_blacklist( source );
                }
            }
        }

        for( const map_extra_registration &entry : pimpl_->map_extras ) {
            const map_extra_id id( entry.definition->id );
            pimpl_->map_extra_undo.emplace_back(
                id, id.is_valid() ? std::optional<map_extra>( id.obj() ) :
                std::nullopt );
            const map_extra_definition_data &source = *entry.definition;
            map_extra native;
            native.id = id;
            native.name_ = no_translation( source.name );
            native.description_ = no_translation( source.description );
            native.generator_id = source.generator_id;
            if( !source.symbol.empty() ) {
                native.symbol = UTF8_getch( source.symbol );
            }
            native.color = color_from_string( source.color,
                                              report_color_error::no );
            for( const std::string &flag : source.flags ) {
                native.flags_.insert( flag );
            }
            native.was_loaded = true;
            detail::map_extra_registry().insert( native );
        }
        if( !pimpl_->map_extras.empty() ) {
            detail::map_extra_registry().finalize();
        }

        for( const weather_generator_registration &entry :
             pimpl_->weather_generators ) {
            const weather_generator_id id( entry.definition->id );
            pimpl_->weather_generator_undo.emplace_back(
                id, id.is_valid() ?
                std::optional<weather_generator>( id.obj() ) : std::nullopt );
            const weather_generator_definition_data &source = *entry.definition;
            weather_generator native;
            native.id = id;
            native.base_temperature = source.base_temperature;
            native.base_humidity = source.base_humidity;
            native.base_pressure = source.base_pressure;
            native.base_wind = source.base_wind;
            native.base_wind_distrib_peaks =
                static_cast<int>( source.base_wind_distrib_peaks );
            native.summer_temp_manual_mod =
                static_cast<int>( source.summer_temp_manual_mod );
            native.spring_temp_manual_mod =
                static_cast<int>( source.spring_temp_manual_mod );
            native.autumn_temp_manual_mod =
                static_cast<int>( source.autumn_temp_manual_mod );
            native.winter_temp_manual_mod =
                static_cast<int>( source.winter_temp_manual_mod );
            native.spring_humidity_manual_mod =
                static_cast<int>( source.spring_humidity_manual_mod );
            native.summer_humidity_manual_mod =
                static_cast<int>( source.summer_humidity_manual_mod );
            native.autumn_humidity_manual_mod =
                static_cast<int>( source.autumn_humidity_manual_mod );
            native.winter_humidity_manual_mod =
                static_cast<int>( source.winter_humidity_manual_mod );
            for( const std::string &weather : source.weather_black_list ) {
                native.weather_black_list.emplace_back( weather );
            }
            for( const std::string &weather : source.weather_white_list ) {
                native.weather_white_list.emplace_back( weather );
            }
            native.was_loaded = true;
            detail::weather_generator_registry().insert( native );
        }
        if( !pimpl_->weather_generators.empty() ) {
            detail::weather_generator_registry().finalize();
        }

        for( const shopkeeper_registration &entry : pimpl_->shopkeeper_rules ) {
            const shopkeeper_blacklist_definition_data &source = *entry.definition;
            pimpl_->shopkeeper_undo.emplace_back( source.kind, source.id );
            if( source.kind == "blacklist" ) {
                shopkeeper_blacklist native;
                native.id = shopkeeper_blacklist_id( source.id );
                for( const shopkeeper_entry_definition_data &entry_data :
                     source.entries ) {
                    icg_entry native_entry;
                    if( !entry_data.item.empty() ) {
                        native_entry.itype = itype_id( entry_data.item );
                    }
                    if( !entry_data.category.empty() ) {
                        native_entry.category = item_category_id( entry_data.category );
                    }
                    if( !entry_data.item_group.empty() ) {
                        native_entry.item_group = item_group_id( entry_data.item_group );
                    }
                    if( !entry_data.message.empty() ) {
                        native_entry.message = no_translation( entry_data.message );
                    }
                    native.entries.push_back( native_entry );
                }
                native.was_loaded = true;
                detail::shopkeeper_blacklist_registry().insert( native );
            } else if( source.kind == "whitelist" ) {
                shopkeeper_whitelist native;
                native.id = shopkeeper_whitelist_id( source.id );
                if( !source.message.empty() ) {
                    native.message = no_translation( source.message );
                }
                for( const shopkeeper_entry_definition_data &entry_data :
                     source.entries ) {
                    icg_entry native_entry;
                    if( !entry_data.item.empty() ) {
                        native_entry.itype = itype_id( entry_data.item );
                    }
                    if( !entry_data.category.empty() ) {
                        native_entry.category = item_category_id( entry_data.category );
                    }
                    if( !entry_data.item_group.empty() ) {
                        native_entry.item_group = item_group_id( entry_data.item_group );
                    }
                    if( !entry_data.message.empty() ) {
                        native_entry.message = no_translation( entry_data.message );
                    }
                    native.entries.push_back( native_entry );
                }
                native.was_loaded = true;
                detail::shopkeeper_whitelist_registry().insert( native );
            } else {
                shopkeeper_cons_rates native;
                native.id = shopkeeper_cons_rates_id( source.id );
                native.default_rate = static_cast<int>( source.default_rate );
                for( const shopkeeper_entry_definition_data &entry_data :
                     source.entries ) {
                    shopkeeper_cons_rate_entry native_entry;
                    if( !entry_data.item.empty() ) {
                        native_entry.itype = itype_id( entry_data.item );
                    }
                    if( !entry_data.category.empty() ) {
                        native_entry.category = item_category_id( entry_data.category );
                    }
                    if( !entry_data.item_group.empty() ) {
                        native_entry.item_group = item_group_id( entry_data.item_group );
                    }
                    if( !entry_data.message.empty() ) {
                        native_entry.message = no_translation( entry_data.message );
                    }
                    native.rates.push_back( native_entry );
                }
                native.was_loaded = true;
                detail::shopkeeper_cons_rates_registry().insert( native );
            }
        }
        if( !pimpl_->shopkeeper_rules.empty() ) {
            detail::shopkeeper_blacklist_registry().finalize();
            detail::shopkeeper_whitelist_registry().finalize();
            detail::shopkeeper_cons_rates_registry().finalize();
        }

        for( const migration_registration &entry : pimpl_->migrations ) {
            const detail::platform_migration_data &source = *entry.definition;
            pimpl_->migration_undo.push_back( source );
            if( source.kind == "bionic" ) {
                detail::insert_platform_bionic_migration( source );
            } else if( source.kind == "effect" ) {
                detail::insert_platform_effect_migration( source );
            } else if( source.kind == "proficiency" ) {
                detail::insert_platform_proficiency_migration( source );
            } else if( source.kind == "vehicle_part" ) {
                detail::insert_platform_vpart_migration( source );
            } else if( source.kind == "var" ) {
                detail::insert_platform_var_migration( source );
            } else if( source.kind == "oter" ) {
                detail::insert_platform_oter_migration( source );
            } else if( source.kind == "overmap_special" ) {
                overmap_special_migration native;
                native.id = overmap_special_migration_id( source.from_id );
                native.new_id = overmap_special_id( source.to_id );
                native.src.emplace_back( native.id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                detail::overmap_special_migration_registry().insert( native );
            } else {
                detail::insert_platform_savegame_migration( source );
            }
        }

        apply_character_phase( character_content_apply_phase::magic_type );
        apply_character_phase( character_content_apply_phase::movement_mode );

        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::metadata, error ) ) {
            throw std::runtime_error( error );
        }

        for( const scenario_registration &entry : pimpl_->scenarios ) {
            const string_id<scenario> id( entry.definition->id );
            pimpl_->scenario_undo.emplace_back(
                id, id.is_valid() ? std::optional<scenario>( id.obj() ) :
                std::nullopt );
            const scenario_definition_data &source = *entry.definition;
            scenario native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native._name_male = no_translation( source.name );
            native._name_female = no_translation( source.name );
            native._description_male = no_translation( source.description );
            native._description_female = no_translation( source.description );
            native._start_name = no_translation( source.start_name );
            native._point_cost = static_cast<int>( source.points );
            native.blacklist = source.blacklist;
            native.extra_professions = source.extra_professions;
            native.reveal_locale = source.reveal_locale;
            native.hard_requirement = source.hard_requirement;
            native.distance_initial_visibility =
                static_cast<int>( source.distance_initial_visibility );
            native._map_extra = source.map_extra.empty() ?
                                map_extra_id::NULL_ID() : map_extra_id( source.map_extra );
            for( const std::string &location : source.locations ) {
                native._allowed_locs.push_back( start_location_id( location ) );
            }
            for( const std::string &profession : source.professions ) {
                native.professions.push_back( profession_id( profession ) );
            }
            for( const std::string &trait : source.allowed_traits ) {
                native._allowed_traits.insert( trait_id( trait ) );
            }
            for( const std::string &trait : source.forced_traits ) {
                native._forced_traits.insert( trait_id( trait ) );
            }
            for( const std::string &trait : source.forbidden_traits ) {
                native._forbidden_traits.insert( trait_id( trait ) );
            }
            for( const std::string &flag : source.flags ) {
                native.flags.insert( flag );
            }
            if( !source.requirement.empty() ) {
                native._requirement = achievement_id( source.requirement );
            }
            if( !source.start_handler.empty() ) {
                native.lua_platform_mod = pimpl_->owner;
                native.lua_platform_start_handler = source.start_handler;
            }
            detail::scenario_registry().insert( native );
        }
        if( !pimpl_->scenarios.empty() ) {
            detail::scenario_registry().finalize();
        }

        for( const vehicle_color_palette_registration &entry :
             pimpl_->vehicle_color_palettes ) {
            const vpalette_id id( entry.definition->id );
            const VehiclePalette *previous =
                detail::vehicle_color_palette_registry_find( id );
            pimpl_->vehicle_color_palette_undo.emplace_back(
                id, previous == nullptr ? std::optional<VehiclePalette>() :
                std::optional<VehiclePalette>( *previous ) );
            VehiclePalette native;
            native.id = id;
            for( const vehicle_color_palette_group_data &group :
                 entry.definition->groups ) {
                for( const std::string &fuzzy : group.fuzzy_ids ) {
                    native.fuzzy_color_match[fuzzy] =
                        static_cast<int>( native.colors.size() );
                }
                weighted_int_list<std::string> weights;
                for( const auto &[name, weight] : group.colors ) {
                    weights.add( name, static_cast<int>( weight ) );
                }
                native.colors.push_back( std::move( weights ) );
            }
            detail::vehicle_color_palette_registry_set( native );
        }

        for( const monster_group_registration &entry : pimpl_->monster_groups ) {
            const mongroup_id id( entry.definition->id );
            auto &groups = MonsterGroupManager::Get_all_Groups();
            const auto previous = groups.find( id );
            pimpl_->monster_group_undo.emplace_back(
                id, previous == groups.end() ?
                std::optional<MonsterGroup>() :
                std::optional<MonsterGroup>( previous->second ) );
            MonsterGroup native;
            native.id = id;
            if( !entry.definition->default_monster.empty() ) {
                native.defaultMonster = mtype_id( entry.definition->default_monster );
            }
            native.is_animal = entry.definition->is_animal;
            mtype_id highest_frequency;
            int highest_frequency_value = 0;
            for( const monster_group_entry_definition_data &monster_entry :
                 entry.definition->entries ) {
                spawn_data data;
                if( !monster_entry.monster.empty() ) {
                    const mtype_id monster( monster_entry.monster );
                    if( monster_entry.weight > highest_frequency_value ) {
                        highest_frequency_value = static_cast<int>( monster_entry.weight );
                        highest_frequency = monster;
                    }
                    native.monsters.emplace_back(
                        monster,
                        static_cast<int>( monster_entry.weight ),
                        static_cast<int>( monster_entry.cost ),
                        static_cast<int>( monster_entry.pack_minimum ),
                        static_cast<int>( monster_entry.pack_maximum ),
                        data, 0_turns, 0_turns, holiday::none );
                } else {
                    native.monsters.emplace_back(
                        mongroup_id( monster_entry.group ),
                        static_cast<int>( monster_entry.weight ),
                        static_cast<int>( monster_entry.cost ),
                        static_cast<int>( monster_entry.pack_minimum ),
                        static_cast<int>( monster_entry.pack_maximum ),
                        data, 0_turns, 0_turns, holiday::none );
                }
            }
            if( native.defaultMonster == mtype_id() && highest_frequency_value > 0 ) {
                // Mirrors the legacy fallback: without an explicit default,
                // the highest-frequency monster entry becomes the default.
                native.defaultMonster = highest_frequency;
            }
            groups[id] = std::move( native );
        }
        if( !pimpl_->monster_groups.empty() ) {
            MonsterGroupManager::FinalizeMonsterGroups();
        }

        for( const overmap_connection_registration &entry :
             pimpl_->overmap_connections ) {
            const string_id<overmap_connection> id( entry.definition->id );
            pimpl_->overmap_connection_undo.emplace_back(
                id, id.is_valid() ?
                std::optional<overmap_connection>( id.obj() ) : std::nullopt );
            overmap_connection native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            for( const overmap_connection_subtype_definition_data &source :
                 entry.definition->subtypes ) {
                overmap_connection::subtype subtype;
                subtype.terrain = string_id<oter_type_t>( source.terrain );
                subtype.basic_cost = static_cast<int>( source.basic_cost );
                for( const std::string &location : source.locations ) {
                    subtype.locations.insert(
                        string_id<overmap_location>( location ) );
                }
                if( source.orthogonal ) {
                    subtype.flags.insert(
                        overmap_connection::subtype::flag::orthogonal );
                }
                if( source.perpendicular_crossing ) {
                    subtype.flags.insert(
                        overmap_connection::subtype::flag::perpendicular_crossing );
                }
                native.subtypes.push_back( std::move( subtype ) );
            }
            detail::overmap_connection_registry().insert( native );
        }
        if( !pimpl_->overmap_connections.empty() ) {
            detail::overmap_connection_registry().finalize();
        }

        for( const speed_description_registration &entry : pimpl_->speed_descriptions ) {
            const speed_description_id id( entry.definition->id );
            pimpl_->speed_description_undo.emplace_back(
                id, id.is_valid() ? std::optional<speed_description>( id.obj() ) : std::nullopt );
            speed_description native;
            native.id = id;
            native.was_loaded = true;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            for( const speed_description_value_data &source_value : entry.definition->values ) {
                speed_description_value value;
                value.was_loaded = true;
                value.value_ = source_value.threshold;
                for( const std::string &description : source_value.descriptions ) {
                    value.descriptions_.push_back( no_translation( description ) );
                }
                native.values_.push_back( std::move( value ) );
            }
            std::sort( native.values_.begin(), native.values_.end(),
            []( const speed_description_value & lhs, const speed_description_value & rhs ) {
                return lhs.value() > rhs.value();
            } );
            detail::speed_description_registry().insert( native );
        }

        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::item_groups, error ) ) {
            throw std::runtime_error( error );
        }

        for( const harvest_drop_type_registration &entry : pimpl_->harvest_drop_types ) {
            const harvest_drop_type_id id( entry.definition->id );
            pimpl_->harvest_drop_type_undo.emplace_back(
                id, id.is_valid() ? std::optional<harvest_drop_type>( id.obj() ) : std::nullopt );
            const harvest_drop_type_definition_data &source = *entry.definition;
            harvest_drop_type native;
            native.id = id;
            native.was_loaded = true;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.is_group_ = source.item_group;
            native.dissect_only_ = source.dissect_only;
            native.msg_fielddress_success = source.field_dress_success;
            native.msg_fielddress_fail = source.field_dress_failure;
            native.msg_butcher_success = source.butcher_success;
            native.msg_butcher_fail = source.butcher_failure;
            native.msg_dissect_success = source.dissect_success;
            native.msg_dissect_fail = source.dissect_failure;
            const std::vector<std::string> skills = source.skills.empty() ?
                                                    std::vector<std::string> { "survival" } :
                                                    source.skills;
            for( const std::string &skill : skills ) {
                native.harvest_skills.emplace_back( skill );
            }
            detail::harvest_drop_type_registry().insert( native );
        }

        for( const harvest_registration &entry : pimpl_->harvests ) {
            const harvest_id id( entry.definition->id );
            pimpl_->harvest_undo.emplace_back(
                id, id.is_valid() ? std::optional<harvest_list>( id.obj() ) : std::nullopt );
            const harvest_definition_data &source = *entry.definition;
            harvest_list native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.message_ = source.message.empty() ? translation() :
                              no_translation( source.message );
            native.leftovers = itype_id( source.leftovers );
            native.butchery_requirements_ = butchery_requirements_id(
                                                source.butchery_requirements );
            for( const harvest_entry_definition_data &source_drop : source.entries ) {
                harvest_entry drop;
                drop.drop = source_drop.output;
                drop.base_num = {
                    static_cast<float>( source_drop.base_minimum ),
                    static_cast<float>( source_drop.base_maximum )
                };
                drop.scale_num = {
                    static_cast<float>( source_drop.skill_minimum ),
                    static_cast<float>( source_drop.skill_maximum )
                };
                drop.max = static_cast<int>( source_drop.maximum );
                drop.type = source_drop.category.empty() ?
                            harvest_drop_type_id::NULL_ID() :
                            harvest_drop_type_id( source_drop.category );
                drop.mass_ratio = static_cast<float>( source_drop.mass_ratio );
                for( const std::string &flag : source_drop.flags ) {
                    drop.flags.emplace_back( flag );
                }
                for( const std::string &fault : source_drop.faults ) {
                    drop.faults.emplace_back( fault );
                }
                drop.was_loaded = true;
                native.entries_.push_back( std::move( drop ) );
            }
            detail::harvest_list_registry().insert( native );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::behavior, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::effect_type, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::sub_body_part, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::wound_type, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::body_part, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::anatomy, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::body_graph, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::field_type, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::monster_attack, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::weakpoint_set, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::morale_type, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::disease_type, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::requirements, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::wound_fix, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::recipe_groups, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::definitions, error ) ) {
            throw std::runtime_error( error );
        }

        for( const clothing_mod_registration &entry : pimpl_->clothing_mods ) {
            const clothing_mod_id id( entry.definition->id );
            pimpl_->clothing_mod_undo.emplace_back(
                id, id.is_valid() ? std::optional<clothing_mod>( id.obj() ) : std::nullopt );
            const clothing_mod_definition_data &source = *entry.definition;
            clothing_mod native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            native.flag = flag_id( source.flag );
            native.item_string = itype_id( source.material_item );
            native.implement_prompt = no_translation( source.apply_prompt );
            native.destroy_prompt = no_translation( source.remove_prompt );
            native.restricted = source.restricted;
            for( const clothing_modifier_definition_data &source_modifier : source.modifiers ) {
                mod_value modifier;
                modifier.type = io::string_to_enum<clothing_mod_type>( source_modifier.stat );
                modifier.value = static_cast<float>( source_modifier.amount );
                modifier.round_up = source_modifier.round_up;
                modifier.thickness_proportion = source_modifier.per_thickness;
                modifier.coverage_proportion = source_modifier.per_coverage;
                native.mod_values.push_back( modifier );
            }
            detail::clothing_mod_registry().insert( native );
        }
        if( !pimpl_->clothing_mods.empty() ) {
            detail::refresh_clothing_mod_registry_cache();
        }

        if( !pimpl_->item_content.apply_phase(
                items_content_apply_phase::recipes, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::monster, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->creatures.apply_phase(
                creatures_content_apply_phase::finalize, error ) ) {
            throw std::runtime_error( error );
        }

        if( !pimpl_->world.apply( error ) ) {
            throw std::runtime_error( error );
        }

        for( const terrain_transform_registration &entry : pimpl_->terrain_transforms ) {
            const ter_furn_transform_id id( entry.definition->id );
            pimpl_->terrain_transform_undo.emplace_back(
                id, id.is_valid() ? std::optional<ter_furn_transform>( id.obj() ) : std::nullopt );
            ter_furn_transform native;
            native.id = id;
            native.src.emplace_back( id, mod_id( pimpl_->owner ) );
            native.was_loaded = true;
            for( const terrain_transform_rule_definition_data &rule : entry.definition->rules ) {
                if( rule.kind == "terrain" ) {
                    ter_furn_data<ter_str_id> result;
                    result.message = no_translation( rule.message );
                    result.message_good = rule.message_good;
                    for( const auto &[result_id, weight] : rule.results ) {
                        result.list.add( ter_str_id( result_id ), static_cast<int>( weight ) );
                    }
                    for( const std::string &input : rule.inputs ) {
                        native.ter_transform.emplace( ter_str_id( input ), result );
                    }
                    for( const std::string &flag : rule.flags ) {
                        native.ter_flag_transform.emplace( flag, result );
                    }
                } else if( rule.kind == "furniture" ) {
                    ter_furn_data<furn_str_id> result;
                    result.message = no_translation( rule.message );
                    result.message_good = rule.message_good;
                    for( const auto &[result_id, weight] : rule.results ) {
                        result.list.add( furn_str_id( result_id ), static_cast<int>( weight ) );
                    }
                    for( const std::string &input : rule.inputs ) {
                        native.furn_transform.emplace( furn_str_id( input ), result );
                    }
                    for( const std::string &flag : rule.flags ) {
                        native.furn_flag_transform.emplace( flag, result );
                    }
                } else if( rule.kind == "field" ) {
                    ter_furn_data<field_type_id> result;
                    result.message = no_translation( rule.message );
                    result.message_good = rule.message_good;
                    for( const auto &[result_id, weight] : rule.results ) {
                        result.list.add( field_type_id( result_id ), static_cast<int>( weight ) );
                    }
                    for( const std::string &input : rule.inputs ) {
                        native.field_transform.emplace( field_type_id( input ), result );
                    }
                } else {
                    ter_furn_data<trap_str_id> result;
                    result.message = no_translation( rule.message );
                    result.message_good = rule.message_good;
                    for( const auto &[result_id, weight] : rule.results ) {
                        result.list.add( trap_str_id( result_id ), static_cast<int>( weight ) );
                    }
                    for( const std::string &input : rule.inputs ) {
                        native.trap_transform.emplace( trap_str_id( input ), result );
                    }
                    for( const std::string &flag : rule.flags ) {
                        native.trap_flag_transform.emplace( flag, result );
                    }
                }
            }
            detail::ter_furn_transform_registry().insert( native );
        }
        if( !pimpl_->terrain_transforms.empty() ) {
            detail::ter_furn_transform_registry().finalize();
        }

        for( const post_process_generator_registration &entry :
             pimpl_->post_process_generators ) {
            const pp_generator_id id( entry.definition->id );
            pimpl_->post_process_generator_undo.emplace_back(
                id, id.is_valid() ? std::optional<pp_generator>( id.obj() ) : std::nullopt );
            pp_generator native;
            native.id = id;
            native.was_loaded = true;
            const auto stage_type = []( const std::string & kind ) {
                if( kind == "bash_damage" ) {
                    return sub_generator_type::bash_damage;
                }
                if( kind == "move_items" ) {
                    return sub_generator_type::move_items;
                }
                if( kind == "add_fire" ) {
                    return sub_generator_type::add_fire;
                }
                if( kind == "pre_burn" ) {
                    return sub_generator_type::pre_burn;
                }
                if( kind == "place_blood" ) {
                    return sub_generator_type::place_blood;
                }
                if( kind == "aftershock_ruin" ) {
                    return sub_generator_type::aftershock_ruin;
                }
                throw std::runtime_error( "unknown post-process stage '" + kind + "'" );
            };
            for( const post_process_stage_definition_data &source : entry.definition->stages ) {
                pp_sub_generator stage;
                stage.type = stage_type( source.kind );
                stage.attempts = static_cast<int>( source.attempts );
                stage.chance = static_cast<int>( source.chance );
                stage.min_intensity = static_cast<int>( source.min_intensity );
                stage.max_intensity = static_cast<int>( source.max_intensity );
                stage.scaling_days_start = static_cast<int>( source.scaling_days_start );
                stage.scaling_days_end = static_cast<int>( source.scaling_days_end );
                stage.scope = source.scope == "overmap_special" ?
                              pp_sub_generator_scope::overmap_special :
                              pp_sub_generator_scope::omt;
                native.sub_generators_.push_back( stage );
            }
            detail::post_process_generator_registry().insert( native );
        }
        if( !pimpl_->post_process_generators.empty() ) {
            detail::post_process_generator_registry().finalize();
        }

        if( !pimpl_->worldgen.apply( error ) ) {
            throw std::runtime_error( error );
        }

        pimpl_->applied = true;
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        rollback();
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool content_transaction::validate_finalized( std::string &error ) const
{
    if( !pimpl_->applied ) {
        error = "content transaction for '" + pimpl_->owner + "' is not applied";
        return false;
    }
    if( pimpl_->finalization_validated ) {
        error = "content finalization for '" + pimpl_->owner +
                "' was already validated";
        return false;
    }
    if( !pimpl_->item_content.validate_finalized( error ) ) {
        return false;
    }
    for( const bash_damage_profile_registration &entry :
         pimpl_->bash_damage_profiles ) {
        if( !bash_damage_profile_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first bash damage profile '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    if( !pimpl_->creatures.validate_finalized( error ) ) {
        return false;
    }
    for( const construction_category_registration &entry :
         pimpl_->construction_categories ) {
        if( !construction_category_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first construction category '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const construction_group_registration &entry : pimpl_->construction_groups ) {
        if( !construction_group_str_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first construction group '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const vehicle_part_location_registration &entry :
         pimpl_->vehicle_part_locations ) {
        if( !vpart_location_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first vehicle part location '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const mood_face_registration &entry : pimpl_->mood_faces ) {
        if( !mood_face_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first mood face '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const damage_info_order_registration &entry : pimpl_->damage_info_orders ) {
        if( !damage_info_order_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first damage info order '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const vehicle_part_category_registration &entry :
         pimpl_->vehicle_part_categories ) {
        if( detail::vehicle_part_category_registry_find( entry.definition->id ) == nullptr ) {
            error = "Lua-first vehicle part category '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const named_color_registration &entry : pimpl_->named_colors ) {
        if( !detail::named_color_registry_contains( entry.definition->name ) ) {
            error = "Lua-first named color '" + entry.definition->name +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const rotatable_symbol_registration &entry : pimpl_->rotatable_symbols ) {
        if( detail::rotatable_symbol_registry_group(
                entry.definition->symbols.front() ).empty() ) {
            error = "Lua-first rotatable symbol '" + entry.definition->key +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const ascii_art_registration &entry : pimpl_->ascii_arts ) {
        if( !ascii_art_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first ASCII art '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const limb_score_registration &entry : pimpl_->limb_scores ) {
        if( !limb_score_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first limb score '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const hit_range_registration &entry : pimpl_->hit_ranges ) {
        const std::vector<std::int64_t> actual(
            Creature::dispersion_for_even_chance_of_good_hit.begin(),
            Creature::dispersion_for_even_chance_of_good_hit.end() );
        if( actual != entry.definition->even_good ) {
            error = "Lua-first hit range did not survive global finalization";
            return false;
        }
    }
    for( const overmap_land_use_code_registration &entry :
         pimpl_->overmap_land_use_codes ) {
        if( !overmap_land_use_code_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first overmap land-use code '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const overmap_vision_registration &entry : pimpl_->overmap_visions ) {
        if( !oter_vision_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first overmap vision '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const overmap_location_registration &entry : pimpl_->overmap_locations ) {
        if( !overmap_location_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first overmap location '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const map_extra_collection_registration &entry : pimpl_->map_extra_collections ) {
        if( !map_extra_collection_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first map-extra collection '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const vehicle_group_registration &entry : pimpl_->vehicle_groups ) {
        if( detail::vehicle_group_registry_find( entry.definition->id ) == nullptr ) {
            error = "Lua-first vehicle group '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const vehicle_placement_registration &entry : pimpl_->vehicle_placements ) {
        if( detail::vehicle_placement_registry_find( entry.definition->id ) == nullptr ) {
            error = "Lua-first vehicle placement '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const vehicle_spawn_registration &entry : pimpl_->vehicle_spawns ) {
        if( detail::vehicle_spawn_registry_find( entry.definition->id ) == nullptr ) {
            error = "Lua-first vehicle spawn '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const fault_group_registration &entry : pimpl_->fault_groups ) {
        if( !fault_group_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first fault group '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const explosion_light_registration &entry : pimpl_->explosion_lights ) {
        if( !explosion_light_str_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first explosion light '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const addiction_type_registration &entry : pimpl_->addiction_types ) {
        if( !addiction_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first addiction type '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const character_modifier_registration &entry : pimpl_->character_modifiers ) {
        if( !character_modifier_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first character modifier '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const start_location_registration &entry : pimpl_->start_locations ) {
        if( !start_location_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first start location '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const climbing_aid_registration &entry : pimpl_->climbing_aids ) {
        if( !climbing_aid_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first climbing aid '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const weather_type_registration &entry : pimpl_->weather_types ) {
        if( !weather_type_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first weather type '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const event_transformation_registration &entry : pimpl_->event_transformations ) {
        if( !string_id<event_transformation>( entry.definition->id ).is_valid() ) {
            error = "Lua-first event transformation '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const event_statistic_registration &entry : pimpl_->event_statistics ) {
        if( !event_statistic_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first event statistic '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const relic_procgen_registration &entry : pimpl_->relic_procgens ) {
        if( !relic_procgen_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first relic procgen '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    if( !pimpl_->character.validate_finalized( error ) ) {
        return false;
    }
    if( !pimpl_->presentation.validate_finalized( error ) ) {
        return false;
    }
    for( const attack_vector_registration &entry : pimpl_->attack_vectors ) {
        if( !attack_vector_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first attack vector '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const trap_registration &entry : pimpl_->traps ) {
        if( !trap_str_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first trap '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const construction_registration &entry : pimpl_->constructions ) {
        if( !construction_str_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first construction '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const furniture_registration &entry : pimpl_->furniture ) {
        if( !furn_str_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first furniture '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const terrain_registration &entry : pimpl_->terrain ) {
        if( !ter_str_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first terrain '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const gate_registration &entry : pimpl_->gates ) {
        if( !gate_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first gate '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const fault_registration &entry : pimpl_->faults ) {
        if( !fault_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first fault '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const fault_fix_registration &entry : pimpl_->fault_fixes ) {
        if( !fault_fix_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first fault fix '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const achievement_registration &entry : pimpl_->achievements ) {
        if( !detail::platform_achievement_is_valid( entry.definition->id ) ) {
            error = "Lua-first achievement '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const map_extra_registration &entry : pimpl_->map_extras ) {
        if( !map_extra_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first map extra '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const weather_generator_registration &entry :
         pimpl_->weather_generators ) {
        if( !weather_generator_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first weather generator '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const speed_description_registration &entry : pimpl_->speed_descriptions ) {
        if( !speed_description_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first speed description '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const harvest_drop_type_registration &entry : pimpl_->harvest_drop_types ) {
        if( !harvest_drop_type_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first harvest drop type '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const harvest_registration &entry : pimpl_->harvests ) {
        const harvest_id id( entry.definition->id );
        if( !id.is_valid() || id->entries().size() != entry.definition->entries.size() ) {
            error = "Lua-first harvest '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const clothing_mod_registration &entry : pimpl_->clothing_mods ) {
        if( !clothing_mod_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first clothing modification '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const terrain_transform_registration &entry : pimpl_->terrain_transforms ) {
        if( !ter_furn_transform_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first terrain transform '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    for( const post_process_generator_registration &entry :
         pimpl_->post_process_generators ) {
        if( !pp_generator_id( entry.definition->id ).is_valid() ) {
            error = "Lua-first post-process generator '" + entry.definition->id +
                    "' did not survive global finalization";
            return false;
        }
    }
    if( !pimpl_->worldgen.validate_finalized( error ) ) {
        return false;
    }
    if( !pimpl_->world.validate_finalized( error ) ) {
        return false;
    }
    pimpl_->finalization_validated = true;
    error.clear();
    return true;
}

void content_transaction::rollback()
{
    pimpl_->creatures.prepare_rollback(
        pimpl_->item_content.has_requirement_changes() ||
        !pimpl_->construction_requirement_undo.empty() );
    pimpl_->world.rollback();
    for( auto it = pimpl_->post_process_generator_undo.rbegin();
         it != pimpl_->post_process_generator_undo.rend(); ++it ) {
        if( it->second ) {
            detail::post_process_generator_registry().restore( *it->second );
        } else {
            detail::post_process_generator_registry().erase( it->first );
        }
    }
    if( !pimpl_->post_process_generator_undo.empty() ) {
        detail::post_process_generator_registry().finalize();
    }
    pimpl_->post_process_generator_undo.clear();
    for( auto it = pimpl_->terrain_transform_undo.rbegin();
         it != pimpl_->terrain_transform_undo.rend(); ++it ) {
        if( it->second ) {
            detail::ter_furn_transform_registry().restore( *it->second );
        } else {
            detail::ter_furn_transform_registry().erase( it->first );
        }
    }
    if( !pimpl_->terrain_transform_undo.empty() ) {
        detail::ter_furn_transform_registry().finalize();
    }
    pimpl_->terrain_transform_undo.clear();
    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::monster );

    pimpl_->item_content.rollback_phase( items_content_rollback_phase::recipes );

    for( auto it = pimpl_->clothing_mod_undo.rbegin();
         it != pimpl_->clothing_mod_undo.rend(); ++it ) {
        if( it->second ) {
            detail::clothing_mod_registry().restore( *it->second );
        } else {
            detail::clothing_mod_registry().erase( it->first );
        }
    }
    if( !pimpl_->clothing_mod_undo.empty() ) {
        detail::refresh_clothing_mod_registry_cache();
    }
    pimpl_->clothing_mod_undo.clear();

    pimpl_->item_content.rollback_phase( items_content_rollback_phase::definitions );

    pimpl_->item_content.rollback_phase( items_content_rollback_phase::recipe_groups );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::wound_fix );

    for( auto it = pimpl_->construction_requirement_undo.rbegin();
         it != pimpl_->construction_requirement_undo.rend(); ++it ) {
        requirement_data::registry().erase( it->first );
        if( it->second ) {
            requirement_data::registry()[it->first] = *it->second;
        }
    }
    pimpl_->construction_requirement_undo.clear();
    pimpl_->item_content.rollback_phase( items_content_rollback_phase::requirements );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::disease_type );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::morale_type );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::weakpoint_set );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::monster_attack );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::field_type );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::body_graph );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::anatomy );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::body_part );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::wound_type );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::sub_body_part );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::effect_type );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::behavior );

    for( auto it = pimpl_->harvest_undo.rbegin();
         it != pimpl_->harvest_undo.rend(); ++it ) {
        if( it->second ) {
            detail::harvest_list_registry().restore( *it->second );
        } else {
            detail::harvest_list_registry().erase( it->first );
        }
    }
    pimpl_->harvest_undo.clear();

    for( auto it = pimpl_->harvest_drop_type_undo.rbegin();
         it != pimpl_->harvest_drop_type_undo.rend(); ++it ) {
        if( it->second ) {
            detail::harvest_drop_type_registry().restore( *it->second );
        } else {
            detail::harvest_drop_type_registry().erase( it->first );
        }
    }
    pimpl_->harvest_drop_type_undo.clear();

    pimpl_->item_content.rollback_phase( items_content_rollback_phase::item_groups );

    for( auto it = pimpl_->speed_description_undo.rbegin();
         it != pimpl_->speed_description_undo.rend(); ++it ) {
        if( it->second ) {
            detail::speed_description_registry().restore( *it->second );
        } else {
            detail::speed_description_registry().erase( it->first );
        }
    }
    pimpl_->speed_description_undo.clear();

    pimpl_->item_content.rollback_phase( items_content_rollback_phase::metadata );

    for( auto it = pimpl_->scenario_undo.rbegin();
         it != pimpl_->scenario_undo.rend(); ++it ) {
        if( it->second ) {
            detail::scenario_registry().restore( *it->second );
        } else {
            detail::scenario_registry().erase( it->first );
        }
    }
    if( !pimpl_->scenario_undo.empty() ) {
        detail::scenario_registry().finalize();
    }
    pimpl_->scenario_undo.clear();

    for( auto it = pimpl_->vehicle_color_palette_undo.rbegin();
         it != pimpl_->vehicle_color_palette_undo.rend(); ++it ) {
        if( it->second ) {
            detail::vehicle_color_palette_registry_set( *it->second );
        } else {
            detail::vehicle_color_palette_registry_erase( it->first );
        }
    }
    pimpl_->vehicle_color_palette_undo.clear();

    for( auto it = pimpl_->monster_group_undo.rbegin();
         it != pimpl_->monster_group_undo.rend(); ++it ) {
        auto &groups = MonsterGroupManager::Get_all_Groups();
        if( it->second ) {
            groups[it->first] = *it->second;
        } else {
            groups.erase( it->first );
        }
    }
    if( !pimpl_->monster_group_undo.empty() ) {
        MonsterGroupManager::FinalizeMonsterGroups();
    }
    pimpl_->monster_group_undo.clear();

    for( auto it = pimpl_->overmap_connection_undo.rbegin();
         it != pimpl_->overmap_connection_undo.rend(); ++it ) {
        if( it->second ) {
            detail::overmap_connection_registry().restore( *it->second );
        } else {
            detail::overmap_connection_registry().erase( it->first );
        }
    }
    if( !pimpl_->overmap_connection_undo.empty() ) {
        detail::overmap_connection_registry().finalize();
    }
    pimpl_->overmap_connection_undo.clear();

    pimpl_->character.rollback_phase( character_content_rollback_phase::movement_mode );
    pimpl_->character.rollback_phase( character_content_rollback_phase::magic_type );
    for( auto it = pimpl_->attack_vector_undo.rbegin();
         it != pimpl_->attack_vector_undo.rend(); ++it ) {
        if( it->second ) {
            detail::attack_vector_registry().restore( *it->second );
        } else {
            detail::attack_vector_registry().erase( it->first );
        }
    }
    if( !pimpl_->attack_vector_undo.empty() ) {
        detail::refresh_attack_vector_registry();
    }
    pimpl_->attack_vector_undo.clear();

    pimpl_->character.rollback_phase( character_content_rollback_phase::technique );
    pimpl_->character.rollback_phase( character_content_rollback_phase::martial_art );

    for( auto it = pimpl_->trap_undo.rbegin();
         it != pimpl_->trap_undo.rend(); ++it ) {
        if( it->second ) {
            detail::trap_registry().insert( *it->second );
        } else {
            detail::trap_registry().erase( it->first );
        }
    }
    if( !pimpl_->trap_undo.empty() ) {
        detail::trap_registry().finalize();
    }
    pimpl_->trap_undo.clear();

    for( auto it = pimpl_->construction_undo.rbegin();
         it != pimpl_->construction_undo.rend(); ++it ) {
        if( it->second ) {
            detail::construction_registry().insert( *it->second );
        } else {
            detail::construction_registry().erase( it->first );
        }
    }
    if( !pimpl_->construction_undo.empty() ) {
        detail::construction_registry().finalize();
    }
    pimpl_->construction_undo.clear();

    for( auto it = pimpl_->furniture_undo.rbegin();
         it != pimpl_->furniture_undo.rend(); ++it ) {
        if( it->second ) {
            detail::furniture_registry().insert( *it->second );
        } else {
            detail::furniture_registry().erase( it->first );
        }
    }
    if( !pimpl_->furniture_undo.empty() ) {
        detail::furniture_registry().finalize();
    }
    pimpl_->furniture_undo.clear();

    for( auto it = pimpl_->terrain_undo.rbegin();
         it != pimpl_->terrain_undo.rend(); ++it ) {
        if( it->second ) {
            detail::terrain_registry().insert( *it->second );
        } else {
            detail::terrain_registry().erase( it->first );
        }
    }
    if( !pimpl_->terrain_undo.empty() ) {
        detail::terrain_registry().finalize();
    }
    pimpl_->terrain_undo.clear();

    for( auto it = pimpl_->gate_undo.rbegin();
         it != pimpl_->gate_undo.rend(); ++it ) {
        if( it->second ) {
            detail::gate_registry().insert( *it->second );
        } else {
            detail::gate_registry().erase( it->first );
        }
    }
    if( !pimpl_->gate_undo.empty() ) {
        detail::gate_registry().finalize();
    }
    pimpl_->gate_undo.clear();

    for( auto it = pimpl_->fault_undo.rbegin();
         it != pimpl_->fault_undo.rend(); ++it ) {
        if( it->second ) {
            detail::fault_registry().insert( *it->second );
        } else {
            detail::fault_registry().erase( it->first );
        }
    }
    if( !pimpl_->fault_undo.empty() ) {
        detail::fault_registry().finalize();
    }
    pimpl_->fault_undo.clear();

    for( auto it = pimpl_->fault_fix_undo.rbegin();
         it != pimpl_->fault_fix_undo.rend(); ++it ) {
        if( it->second ) {
            detail::fault_fix_registry().insert( *it->second );
        } else {
            detail::fault_fix_registry().erase( it->first );
        }
    }
    if( !pimpl_->fault_fix_undo.empty() ) {
        detail::fault_fix_registry().finalize();
    }
    pimpl_->fault_fix_undo.clear();

    if( pimpl_->dream_undo != 0 ) {
        detail::truncate_dreams( pimpl_->dream_undo );
    }
    pimpl_->dream_undo = 0;

    for( auto it = pimpl_->achievement_undo.rbegin();
         it != pimpl_->achievement_undo.rend(); ++it ) {
        detail::erase_platform_achievement( it->str() );
    }
    if( !pimpl_->achievement_undo.empty() ) {
        detail::finalize_platform_achievements();
    }
    pimpl_->achievement_undo.clear();

    for( auto it = pimpl_->blacklist_undo.rbegin();
         it != pimpl_->blacklist_undo.rend(); ++it ) {
        if( it->kind == "trait" ) {
            detail::erase_platform_trait_blacklist( it->entries );
        } else if( it->kind == "monster" ) {
            detail::erase_platform_monster_blacklist(
                it->entries, it->whitelist );
        } else if( it->kind == "scenario" ) {
            detail::erase_platform_scenario_blacklist( *it );
        } else if( it->kind == "profession" ) {
            detail::erase_platform_profession_blacklist( *it );
        } else {
            detail::erase_platform_savegame_blacklist( *it );
        }
    }
    pimpl_->blacklist_undo.clear();

    if( pimpl_->item_blacklist_undo != 0 ) {
        detail::truncate_platform_item_blacklist( pimpl_->item_blacklist_undo );
    }
    pimpl_->item_blacklist_undo = 0;

    for( auto it = pimpl_->map_extra_undo.rbegin();
         it != pimpl_->map_extra_undo.rend(); ++it ) {
        if( it->second ) {
            detail::map_extra_registry().insert( *it->second );
        } else {
            detail::map_extra_registry().erase( it->first );
        }
    }
    if( !pimpl_->map_extra_undo.empty() ) {
        detail::map_extra_registry().finalize();
    }
    pimpl_->map_extra_undo.clear();

    for( auto it = pimpl_->weather_generator_undo.rbegin();
         it != pimpl_->weather_generator_undo.rend(); ++it ) {
        if( it->second ) {
            detail::weather_generator_registry().insert( *it->second );
        } else {
            detail::weather_generator_registry().erase( it->first );
        }
    }
    if( !pimpl_->weather_generator_undo.empty() ) {
        detail::weather_generator_registry().finalize();
    }
    pimpl_->weather_generator_undo.clear();

    for( auto it = pimpl_->trait_group_undo.rbegin();
         it != pimpl_->trait_group_undo.rend(); ++it ) {
        detail::erase_platform_trait_group( *it );
    }
    pimpl_->trait_group_undo.clear();

    if( pimpl_->monster_adjustment_undo != 0 ) {
        detail::truncate_platform_monster_adjustments(
            pimpl_->monster_adjustment_undo );
    }
    pimpl_->monster_adjustment_undo = 0;

    for( auto it = pimpl_->shopkeeper_undo.rbegin();
         it != pimpl_->shopkeeper_undo.rend(); ++it ) {
        if( it->first == "blacklist" ) {
            detail::shopkeeper_blacklist_registry().erase(
                shopkeeper_blacklist_id( it->second.value_or( "" ) ) );
        } else if( it->first == "whitelist" ) {
            detail::shopkeeper_whitelist_registry().erase(
                shopkeeper_whitelist_id( it->second.value_or( "" ) ) );
        } else {
            detail::shopkeeper_cons_rates_registry().erase(
                shopkeeper_cons_rates_id( it->second.value_or( "" ) ) );
        }
    }
    pimpl_->shopkeeper_undo.clear();

    for( auto it = pimpl_->migration_undo.rbegin();
         it != pimpl_->migration_undo.rend(); ++it ) {
        if( it->kind == "bionic" ) {
            detail::erase_platform_bionic_migration( *it );
        } else if( it->kind == "effect" ) {
            detail::erase_platform_effect_migration( *it );
        } else if( it->kind == "proficiency" ) {
            detail::erase_platform_proficiency_migration( *it );
        } else if( it->kind == "vehicle_part" ) {
            detail::erase_platform_vpart_migration( *it );
        } else if( it->kind == "var" ) {
            detail::erase_platform_var_migration( *it );
        } else if( it->kind == "oter" ) {
            detail::erase_platform_oter_migration( *it );
        } else if( it->kind == "overmap_special" ) {
            detail::overmap_special_migration_registry().erase(
                overmap_special_migration_id( it->from_id ) );
        } else {
            detail::erase_platform_savegame_migration( *it );
        }
    }
    pimpl_->migration_undo.clear();


    pimpl_->presentation.rollback();

    for( auto it = pimpl_->relic_procgen_undo.rbegin();
         it != pimpl_->relic_procgen_undo.rend(); ++it ) {
        if( it->second ) {
            detail::relic_procgen_registry().restore( *it->second );
        } else {
            detail::relic_procgen_registry().erase( it->first );
        }
    }
    if( !pimpl_->relic_procgen_undo.empty() ) {
        detail::relic_procgen_registry().finalize();
    }
    pimpl_->relic_procgen_undo.clear();

    for( auto it = pimpl_->event_statistic_undo.rbegin();
         it != pimpl_->event_statistic_undo.rend(); ++it ) {
        detail::restore_event_statistic( it->first, it->second );
    }
    if( !pimpl_->event_statistic_undo.empty() ) {
        detail::finalize_event_statistics();
    }
    pimpl_->event_statistic_undo.clear();

    for( auto it = pimpl_->event_transformation_undo.rbegin();
         it != pimpl_->event_transformation_undo.rend(); ++it ) {
        detail::restore_event_transformation( it->first, it->second );
    }
    if( !pimpl_->event_transformation_undo.empty() ) {
        detail::finalize_event_transformations();
    }
    pimpl_->event_transformation_undo.clear();

    for( auto it = pimpl_->weather_type_undo.rbegin();
         it != pimpl_->weather_type_undo.rend(); ++it ) {
        if( it->second ) {
            detail::weather_type_registry().restore( *it->second );
        } else {
            detail::weather_type_registry().erase( it->first );
        }
    }
    if( !pimpl_->weather_type_undo.empty() ) {
        detail::weather_type_registry().finalize();
    }
    pimpl_->weather_type_undo.clear();

    for( auto it = pimpl_->climbing_aid_undo.rbegin();
         it != pimpl_->climbing_aid_undo.rend(); ++it ) {
        if( it->second ) {
            detail::climbing_aid_registry().restore( *it->second );
        } else {
            detail::climbing_aid_registry().erase( it->first );
        }
    }
    if( !pimpl_->climbing_aid_undo.empty() ) {
        detail::refresh_climbing_aid_registry();
    }
    pimpl_->climbing_aid_undo.clear();

    for( auto it = pimpl_->start_location_undo.rbegin();
         it != pimpl_->start_location_undo.rend(); ++it ) {
        if( it->second ) {
            detail::start_location_registry().restore( *it->second );
        } else {
            detail::start_location_registry().erase( it->first );
        }
    }
    if( !pimpl_->start_location_undo.empty() ) {
        detail::start_location_registry().finalize();
    }
    pimpl_->start_location_undo.clear();

    for( auto it = pimpl_->character_modifier_undo.rbegin();
         it != pimpl_->character_modifier_undo.rend(); ++it ) {
        if( it->second ) {
            detail::character_modifier_registry().restore( *it->second );
        } else {
            detail::character_modifier_registry().erase( it->first );
        }
    }
    if( !pimpl_->character_modifier_undo.empty() ) {
        detail::character_modifier_registry().finalize();
    }
    pimpl_->character_modifier_undo.clear();

    for( auto it = pimpl_->addiction_type_undo.rbegin();
         it != pimpl_->addiction_type_undo.rend(); ++it ) {
        if( it->second ) {
            detail::addiction_type_registry().restore( *it->second );
        } else {
            detail::addiction_type_registry().erase( it->first );
        }
    }
    if( !pimpl_->addiction_type_undo.empty() ) {
        detail::addiction_type_registry().finalize();
    }
    pimpl_->addiction_type_undo.clear();

    pimpl_->item_content.rollback_phase(
        items_content_rollback_phase::ammunition_effects );

    for( auto it = pimpl_->explosion_light_undo.rbegin();
         it != pimpl_->explosion_light_undo.rend(); ++it ) {
        if( it->second ) {
            get_all_explosion_lights().restore( *it->second );
        } else {
            get_all_explosion_lights().erase( it->first );
        }
    }
    if( !pimpl_->explosion_light_undo.empty() ) {
        get_all_explosion_lights().finalize();
    }
    pimpl_->explosion_light_undo.clear();

    for( auto it = pimpl_->fault_group_undo.rbegin();
         it != pimpl_->fault_group_undo.rend(); ++it ) {
        if( it->second ) {
            detail::fault_group_registry().restore( *it->second );
        } else {
            detail::fault_group_registry().erase( it->first );
        }
    }
    if( !pimpl_->fault_group_undo.empty() ) {
        detail::fault_group_registry().finalize();
    }
    pimpl_->fault_group_undo.clear();

    for( auto it = pimpl_->vehicle_spawn_undo.rbegin();
         it != pimpl_->vehicle_spawn_undo.rend(); ++it ) {
        if( it->second ) {
            detail::vehicle_spawn_registry_set( it->first, *it->second );
        } else {
            detail::vehicle_spawn_registry_erase( it->first );
        }
    }
    pimpl_->vehicle_spawn_undo.clear();

    for( auto it = pimpl_->vehicle_placement_undo.rbegin();
         it != pimpl_->vehicle_placement_undo.rend(); ++it ) {
        if( it->second ) {
            detail::vehicle_placement_registry_set( it->first, *it->second );
        } else {
            detail::vehicle_placement_registry_erase( it->first );
        }
    }
    pimpl_->vehicle_placement_undo.clear();

    for( auto it = pimpl_->vehicle_group_undo.rbegin();
         it != pimpl_->vehicle_group_undo.rend(); ++it ) {
        if( it->second ) {
            detail::vehicle_group_registry_set( it->first, *it->second );
        } else {
            detail::vehicle_group_registry_erase( it->first );
        }
    }
    pimpl_->vehicle_group_undo.clear();

    for( auto it = pimpl_->map_extra_collection_undo.rbegin();
         it != pimpl_->map_extra_collection_undo.rend(); ++it ) {
        if( it->second ) {
            detail::map_extra_collection_registry().restore( *it->second );
        } else {
            detail::map_extra_collection_registry().erase( it->first );
        }
    }
    if( !pimpl_->map_extra_collection_undo.empty() ) {
        detail::map_extra_collection_registry().finalize();
    }
    pimpl_->map_extra_collection_undo.clear();

    pimpl_->worldgen.rollback();

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::mutation );

    pimpl_->character.rollback_phase( character_content_rollback_phase::mission_definition );
    pimpl_->character.rollback_phase( character_content_rollback_phase::spell );
    pimpl_->character.rollback_phase( character_content_rollback_phase::bionic );
    pimpl_->character.rollback_phase( character_content_rollback_phase::enchantment );
    pimpl_->character.rollback_phase( character_content_rollback_phase::widget );
    pimpl_->character.rollback_phase( character_content_rollback_phase::profession_group );
    pimpl_->character.rollback_phase( character_content_rollback_phase::profession );
    pimpl_->character.rollback_phase( character_content_rollback_phase::profession_item );

    for( auto it = pimpl_->overmap_location_undo.rbegin();
         it != pimpl_->overmap_location_undo.rend(); ++it ) {
        if( it->second ) {
            detail::overmap_location_registry().restore( *it->second );
        } else {
            detail::overmap_location_registry().erase( it->first );
        }
    }
    if( !pimpl_->overmap_location_undo.empty() ) {
        detail::overmap_location_registry().finalize();
    }
    pimpl_->overmap_location_undo.clear();

    for( auto it = pimpl_->overmap_vision_undo.rbegin();
         it != pimpl_->overmap_vision_undo.rend(); ++it ) {
        if( it->second ) {
            detail::overmap_vision_registry().restore( *it->second );
        } else {
            detail::overmap_vision_registry().erase( it->first );
        }
    }
    if( !pimpl_->overmap_vision_undo.empty() ) {
        detail::overmap_vision_registry().finalize();
    }
    pimpl_->overmap_vision_undo.clear();

    for( auto it = pimpl_->overmap_land_use_code_undo.rbegin();
         it != pimpl_->overmap_land_use_code_undo.rend(); ++it ) {
        if( it->second ) {
            detail::overmap_land_use_code_registry().restore( *it->second );
        } else {
            detail::overmap_land_use_code_registry().erase( it->first );
        }
    }
    pimpl_->overmap_land_use_code_undo.clear();

    if( pimpl_->hit_range_undo ) {
        Creature::dispersion_for_even_chance_of_good_hit = *pimpl_->hit_range_undo;
        pimpl_->hit_range_undo.reset();
    }

    for( auto it = pimpl_->limb_score_undo.rbegin();
         it != pimpl_->limb_score_undo.rend(); ++it ) {
        if( it->second ) {
            detail::limb_score_registry().restore( *it->second );
        } else {
            detail::limb_score_registry().erase( it->first );
        }
    }
    pimpl_->limb_score_undo.clear();

    for( auto it = pimpl_->ascii_art_undo.rbegin();
         it != pimpl_->ascii_art_undo.rend(); ++it ) {
        if( it->second ) {
            detail::ascii_art_registry().restore( *it->second );
        } else {
            detail::ascii_art_registry().erase( it->first );
        }
    }
    pimpl_->ascii_art_undo.clear();

    if( pimpl_->rotatable_symbol_undo ) {
        detail::rotatable_symbol_registry_restore( *pimpl_->rotatable_symbol_undo );
        pimpl_->rotatable_symbol_undo.reset();
    }

    if( pimpl_->named_color_undo ) {
        detail::named_color_registry_restore( *pimpl_->named_color_undo );
        pimpl_->named_color_undo.reset();
    }

    for( auto it = pimpl_->mood_face_undo.rbegin();
         it != pimpl_->mood_face_undo.rend(); ++it ) {
        if( it->second ) {
            detail::mood_face_registry().restore( *it->second );
        } else {
            detail::mood_face_registry().erase( it->first );
        }
    }
    pimpl_->mood_face_undo.clear();

    for( auto it = pimpl_->vehicle_part_category_undo.rbegin();
         it != pimpl_->vehicle_part_category_undo.rend(); ++it ) {
        if( it->second ) {
            detail::vehicle_part_category_registry_set( *it->second );
        } else {
            detail::vehicle_part_category_registry_erase( it->first );
        }
    }
    if( !pimpl_->vehicle_part_category_undo.empty() ) {
        detail::vehicle_part_category_registry_finalize();
    }
    pimpl_->vehicle_part_category_undo.clear();

    for( auto it = pimpl_->vehicle_part_location_undo.rbegin();
         it != pimpl_->vehicle_part_location_undo.rend(); ++it ) {
        if( it->second ) {
            detail::vehicle_part_location_registry().restore( *it->second );
        } else {
            detail::vehicle_part_location_registry().erase( it->first );
        }
    }
    pimpl_->vehicle_part_location_undo.clear();

    for( auto it = pimpl_->construction_group_undo.rbegin();
         it != pimpl_->construction_group_undo.rend(); ++it ) {
        if( it->second ) {
            detail::construction_group_registry().restore( *it->second );
        } else {
            detail::construction_group_registry().erase( it->first );
        }
    }
    pimpl_->construction_group_undo.clear();

    for( auto it = pimpl_->construction_category_undo.rbegin();
         it != pimpl_->construction_category_undo.rend(); ++it ) {
        if( it->second ) {
            detail::construction_category_registry().restore( *it->second );
        } else {
            detail::construction_category_registry().erase( it->first );
        }
    }
    pimpl_->construction_category_undo.clear();

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::mutation_category );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::connect_group );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::mutation_type );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::monster_faction );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::emission );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::species );

    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::monster_flag );

    pimpl_->item_content.rollback_phase( items_content_rollback_phase::catalogs );

    pimpl_->item_content.rollback_phase( items_content_rollback_phase::materials );

    for( auto it = pimpl_->damage_info_order_undo.rbegin();
         it != pimpl_->damage_info_order_undo.rend(); ++it ) {
        if( it->second ) {
            detail::damage_info_order_registry().restore( *it->second );
        } else {
            detail::damage_info_order_registry().erase( it->first );
        }
    }
    if( !pimpl_->damage_info_order_undo.empty() ) {
        detail::refresh_damage_info_order_registry();
    }
    pimpl_->damage_info_order_undo.clear();

    for( auto it = pimpl_->bash_damage_profile_undo.rbegin();
         it != pimpl_->bash_damage_profile_undo.rend(); ++it ) {
        if( it->second ) {
            detail::bash_damage_profile_registry().restore( *it->second );
        } else {
            detail::bash_damage_profile_registry().erase( it->first );
        }
    }
    pimpl_->bash_damage_profile_undo.clear();

    pimpl_->item_content.rollback_phase( items_content_rollback_phase::foundations );
    pimpl_->creatures.rollback_phase( creatures_content_rollback_phase::finalize );
    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

void content_transaction::commit()
{
    if( !pimpl_->applied ) {
        return;
    }
    pimpl_->world.commit();
    pimpl_->item_content.commit();
    pimpl_->creatures.commit();
    pimpl_->character.commit();
    pimpl_->terrain_transform_undo.clear();
    pimpl_->post_process_generator_undo.clear();
    pimpl_->bash_damage_profile_undo.clear();
    pimpl_->scenario_undo.clear();
    pimpl_->vehicle_color_palette_undo.clear();
    pimpl_->monster_group_undo.clear();
    pimpl_->overmap_connection_undo.clear();
    pimpl_->speed_description_undo.clear();
    pimpl_->harvest_drop_type_undo.clear();
    pimpl_->harvest_undo.clear();
    pimpl_->construction_category_undo.clear();
    pimpl_->construction_group_undo.clear();
    pimpl_->vehicle_part_location_undo.clear();
    pimpl_->mood_face_undo.clear();
    pimpl_->damage_info_order_undo.clear();
    pimpl_->vehicle_part_category_undo.clear();
    pimpl_->named_color_undo.reset();
    pimpl_->rotatable_symbol_undo.reset();
    pimpl_->ascii_art_undo.clear();
    pimpl_->limb_score_undo.clear();
    pimpl_->hit_range_undo.reset();
    pimpl_->clothing_mod_undo.clear();
    pimpl_->overmap_land_use_code_undo.clear();
    pimpl_->overmap_vision_undo.clear();
    pimpl_->overmap_location_undo.clear();
    pimpl_->map_extra_collection_undo.clear();
    pimpl_->vehicle_group_undo.clear();
    pimpl_->vehicle_placement_undo.clear();
    pimpl_->vehicle_spawn_undo.clear();
    pimpl_->fault_group_undo.clear();
    pimpl_->explosion_light_undo.clear();
    pimpl_->addiction_type_undo.clear();
    pimpl_->character_modifier_undo.clear();
    pimpl_->start_location_undo.clear();
    pimpl_->climbing_aid_undo.clear();
    pimpl_->weather_type_undo.clear();
    pimpl_->event_transformation_undo.clear();
    pimpl_->event_statistic_undo.clear();
    pimpl_->relic_procgen_undo.clear();
    pimpl_->presentation.commit();
    pimpl_->attack_vector_undo.clear();
    pimpl_->trap_undo.clear();
    pimpl_->construction_undo.clear();
    pimpl_->construction_requirement_undo.clear();
    pimpl_->furniture_undo.clear();
    pimpl_->terrain_undo.clear();
    pimpl_->gate_undo.clear();
    pimpl_->fault_undo.clear();
    pimpl_->fault_fix_undo.clear();
    pimpl_->dream_undo = 0;
    pimpl_->achievement_undo.clear();
    pimpl_->blacklist_undo.clear();
    pimpl_->item_blacklist_undo = 0;
    pimpl_->map_extra_undo.clear();
    pimpl_->weather_generator_undo.clear();
    pimpl_->migration_undo.clear();
    pimpl_->shopkeeper_undo.clear();
    pimpl_->trait_group_undo.clear();
    pimpl_->monster_adjustment_undo = 0;
    pimpl_->worldgen.commit();
    pimpl_->token->lifecycle = handle_lifecycle::committed;
}

void content_transaction::seal()
{
    if( !pimpl_->applied ) {
        return;
    }
    pimpl_->world.seal();
    pimpl_->item_content.seal();
    pimpl_->creatures.seal();
    pimpl_->character.seal();
    pimpl_->presentation.seal();
    pimpl_->worldgen.seal();
    if( pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::committed;
    }
}

void content_transaction::discard()
{
    rollback();
    pimpl_->world.discard();
    pimpl_->item_content.discard();
    pimpl_->creatures.discard();
    pimpl_->character.discard();
    pimpl_->presentation.discard();
    pimpl_->worldgen.discard();
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

std::string content_transaction::fingerprint() const
{
    std::uint64_t state = 1469598103934665603ULL;
    hash_part( state, pimpl_->owner );
    pimpl_->world.append_fingerprint( state );
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::technique, state );
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::martial_art, state );
    for( const furniture_registration &entry : pimpl_->furniture ) {
        hash_part( state, "furniture" );
        hash_part( state, operation_name( entry.operation ) );
        const furniture_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.description );
        hash_part( state, value.color );
        hash_part( state, value.symbol );
        hash_part( state, std::to_string( value.movecost ) );
        hash_part( state, std::to_string( value.required_str ) );
        hash_part( state, std::to_string( value.light_emitted ) );
        hash_part( state, std::to_string( value.comfort ) );
        hash_part( state, std::to_string( value.max_volume_ml ) );
        hash_part( state, std::to_string( value.mass_grams ) );
        hash_part( state, std::to_string( value.keg_capacity_ml ) );
        hash_part( state, value.transparent ? "transparent" : "opaque" );
        hash_part( state, value.open );
        hash_part( state, value.close );
        hash_part( state, value.lockpick_result );
        hash_part( state, value.crafting_pseudo_item );
        hash_part( state, value.deployed_item );
        hash_part( state, value.examine_handler );
        hash_part( state, value.examine_name );
        for( const std::string &flag : value.flags ) {
            hash_part( state, flag );
        }
    }
    for( const terrain_registration &entry : pimpl_->terrain ) {
        hash_part( state, "terrain" );
        hash_part( state, operation_name( entry.operation ) );
        const terrain_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.description );
        hash_part( state, value.color );
        hash_part( state, value.symbol );
        hash_part( state, std::to_string( value.movecost ) );
        hash_part( state, std::to_string( value.light_emitted ) );
        hash_part( state, std::to_string( value.comfort ) );
        hash_part( state, std::to_string( value.max_volume_ml ) );
        hash_part( state, std::to_string( value.heat_radiation ) );
        hash_part( state, value.transparent ? "transparent" : "opaque" );
        hash_part( state, value.open );
        hash_part( state, value.close );
        hash_part( state, value.transforms_into );
        hash_part( state, value.roof );
        hash_part( state, value.lockpick_result );
        hash_part( state, value.trap );
        hash_part( state, value.examine_handler );
        hash_part( state, value.examine_name );
        for( const std::string &flag : value.flags ) {
            hash_part( state, flag );
        }
    }
    for( const trap_registration &entry : pimpl_->traps ) {
        hash_part( state, "trap" );
        hash_part( state, operation_name( entry.operation ) );
        const trap_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.color );
        hash_part( state, value.symbol );
        hash_part( state, std::to_string( value.visibility ) );
        hash_part( state, std::to_string( value.avoidance ) );
        hash_part( state, std::to_string( value.difficulty ) );
        hash_part( state, value.action );
        hash_part( state, value.memorial_male );
        hash_part( state, value.memorial_female );
        hash_part( state, value.trigger_message_u );
        hash_part( state, value.trigger_message_npc );
        hash_part( state, std::to_string( value.trap_radius ) );
        hash_part( state, value.benign ? "benign" : "dangerous" );
        hash_part( state, value.always_invisible ? "invisible" : "visible" );
        hash_part( state, std::to_string( value.funnel_radius ) );
        hash_part( state, std::to_string( value.comfort ) );
        hash_part( state, std::to_string( value.trigger_weight_grams ) );
        hash_part( state, std::to_string( value.sound_threshold_min ) );
        hash_part( state, std::to_string( value.sound_threshold_max ) );
        hash_part( state, value.trigger_handler );
        for( const std::string &flag : value.flags ) {
            hash_part( state, flag );
        }
        for( const auto &[item_id, quantity, charges] : value.drops ) {
            hash_part( state, item_id );
            hash_part( state, std::to_string( quantity ) );
            hash_part( state, std::to_string( charges ) );
        }
    }
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::foundations, state );
    for( const bash_damage_profile_registration &entry :
         pimpl_->bash_damage_profiles ) {
        hash_part( state, "bash_damage_profile" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const auto &[damage_id, factor] : entry.definition->factors ) {
            hash_part( state, damage_id );
            hash_part( state, std::to_string( factor ) );
        }
    }
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::damage_types, state );
    for( const damage_info_order_registration &entry : pimpl_->damage_info_orders ) {
        hash_part( state, "damage_info_order" );
        hash_part( state, operation_name( entry.operation ) );
        const damage_info_order_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.display );
        hash_part( state, value.verb );
        for( const damage_info_order_section_definition_data &section : value.sections ) {
            hash_part( state, section.section );
            hash_part( state, std::to_string( section.order ) );
            hash_part( state, section.show_type ? "shown" : "hidden" );
        }
    }
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::materials, state );
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::catalogs, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::foundations, state );
    for( const construction_category_registration &entry :
         pimpl_->construction_categories ) {
        hash_part( state, "construction_category" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->name );
    }
    for( const construction_group_registration &entry : pimpl_->construction_groups ) {
        hash_part( state, "construction_group" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->name );
    }
    for( const vehicle_part_location_registration &entry :
         pimpl_->vehicle_part_locations ) {
        hash_part( state, "vehicle_part_location" );
        hash_part( state, operation_name( entry.operation ) );
        const vehicle_part_location_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.description );
        hash_part( state, std::to_string( value.z_order ) );
        hash_part( state, std::to_string( value.list_order ) );
    }
    for( const vehicle_part_category_registration &entry :
         pimpl_->vehicle_part_categories ) {
        hash_part( state, "vehicle_part_category" );
        hash_part( state, operation_name( entry.operation ) );
        const vehicle_part_category_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.short_name );
        hash_part( state, std::to_string( value.priority ) );
    }
    for( const mood_face_registration &entry : pimpl_->mood_faces ) {
        hash_part( state, "mood_face" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const mood_face_value_definition_data &value : entry.definition->values ) {
            hash_part( state, std::to_string( value.score ) );
            hash_part( state, value.face );
        }
    }
    for( const named_color_registration &entry : pimpl_->named_colors ) {
        hash_part( state, "named_color" );
        hash_part( state, operation_name( entry.operation ) );
        const named_color_definition_data &value = *entry.definition;
        hash_part( state, value.name );
        hash_part( state, std::to_string( value.red ) );
        hash_part( state, std::to_string( value.green ) );
        hash_part( state, std::to_string( value.blue ) );
        hash_part( state, std::to_string( value.alpha ) );
    }
    for( const rotatable_symbol_registration &entry : pimpl_->rotatable_symbols ) {
        hash_part( state, "rotatable_symbol" );
        hash_part( state, operation_name( entry.operation ) );
        for( const std::uint32_t symbol : entry.definition->symbols ) {
            hash_part( state, std::to_string( symbol ) );
        }
    }
    for( const ascii_art_registration &entry : pimpl_->ascii_arts ) {
        hash_part( state, "ascii_art" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const std::string &line : entry.definition->lines ) {
            hash_part( state, line );
        }
    }
    for( const limb_score_registration &entry : pimpl_->limb_scores ) {
        hash_part( state, "limb_score" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, entry.definition->name );
        hash_part( state, entry.definition->affected_by_wounds ? "wounds" : "no_wounds" );
        hash_part( state, entry.definition->affected_by_encumbrance ?
                   "encumbrance" : "no_encumbrance" );
    }
    for( const hit_range_registration &entry : pimpl_->hit_ranges ) {
        hash_part( state, "hit_range" );
        hash_part( state, operation_name( entry.operation ) );
        for( const std::int64_t value : entry.definition->even_good ) {
            hash_part( state, std::to_string( value ) );
        }
    }
    for( const overmap_land_use_code_registration &entry :
         pimpl_->overmap_land_use_codes ) {
        hash_part( state, "overmap_land_use_code" );
        hash_part( state, operation_name( entry.operation ) );
        const overmap_land_use_code_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, std::to_string( value.code ) );
        hash_part( state, value.name );
        hash_part( state, value.description );
        hash_part( state, std::to_string( value.symbol ) );
        hash_part( state, value.color );
    }
    for( const overmap_vision_registration &entry : pimpl_->overmap_visions ) {
        hash_part( state, "overmap_vision" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const overmap_vision_level_definition_data &level :
             entry.definition->levels ) {
            hash_part( state, level.blends_adjacent ? "blend" : "appearance" );
            hash_part( state, level.name );
            hash_part( state, std::to_string( level.symbol ) );
            hash_part( state, level.color );
            hash_part( state, level.looks_like );
        }
    }
    for( const overmap_location_registration &entry : pimpl_->overmap_locations ) {
        hash_part( state, "overmap_location" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const std::string &terrain : entry.definition->terrains ) {
            hash_part( state, "terrain" );
            hash_part( state, terrain );
        }
        for( const std::string &flag : entry.definition->terrain_flags ) {
            hash_part( state, "flag" );
            hash_part( state, flag );
        }
    }
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::profession, state );
    for( const scenario_registration &entry : pimpl_->scenarios ) {
        hash_part( state, "scenario" );
        hash_part( state, operation_name( entry.operation ) );
        const scenario_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.description );
        hash_part( state, value.start_name );
        hash_part( state, std::to_string( value.points ) );
        hash_part( state, value.blacklist ? "blacklist" : "whitelist" );
        hash_part( state, value.extra_professions ? "extra" : "exclusive" );
        hash_part( state, value.reveal_locale ? "reveal" : "hidden" );
        hash_part( state, value.hard_requirement ? "hard" : "soft" );
        hash_part( state, std::to_string( value.distance_initial_visibility ) );
        for( const std::string &location : value.locations ) {
            hash_part( state, "location" );
            hash_part( state, location );
        }
        for( const std::string &profession : value.professions ) {
            hash_part( state, "profession" );
            hash_part( state, profession );
        }
        for( const std::string &trait : value.allowed_traits ) {
            hash_part( state, "allowed_trait" );
            hash_part( state, trait );
        }
        for( const std::string &trait : value.forced_traits ) {
            hash_part( state, "forced_trait" );
            hash_part( state, trait );
        }
        for( const std::string &trait : value.forbidden_traits ) {
            hash_part( state, "forbidden_trait" );
            hash_part( state, trait );
        }
        for( const std::string &flag : value.flags ) {
            hash_part( state, "flag" );
            hash_part( state, flag );
        }
        hash_part( state, value.map_extra );
        hash_part( state, value.requirement );
        hash_part( state, value.start_handler );
    }
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::profession_group, state );
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::widget, state );
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::enchantment, state );
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::bionic, state );
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::spell, state );
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::mission_definition, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::mutation, state );
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::profession_item, state );
    for( const map_extra_collection_registration &entry : pimpl_->map_extra_collections ) {
        hash_part( state, "map_extra_collection" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        hash_part( state, std::to_string( entry.definition->chance ) );
        for( const auto &[extra, weight] : entry.definition->entries ) {
            hash_part( state, extra );
            hash_part( state, std::to_string( weight ) );
        }
    }
    for( const vehicle_group_registration &entry : pimpl_->vehicle_groups ) {
        hash_part( state, "vehicle_group" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const auto &[vehicle, weight] : entry.definition->entries ) {
            hash_part( state, vehicle );
            hash_part( state, std::to_string( weight ) );
        }
    }
    for( const vehicle_placement_registration &entry : pimpl_->vehicle_placements ) {
        hash_part( state, "vehicle_placement" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const vehicle_placement_location_definition_data &location :
             entry.definition->locations ) {
            hash_part( state, std::to_string( location.x_min ) );
            hash_part( state, std::to_string( location.x_max ) );
            hash_part( state, std::to_string( location.y_min ) );
            hash_part( state, std::to_string( location.y_max ) );
            for( const std::int64_t facing : location.facings ) {
                hash_part( state, std::to_string( facing ) );
            }
        }
    }
    for( const vehicle_spawn_registration &entry : pimpl_->vehicle_spawns ) {
        hash_part( state, "vehicle_spawn" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const vehicle_spawn_entry_definition_data &spawn : entry.definition->entries ) {
            hash_part( state, spawn.builtin ? "builtin" : "vehicle" );
            hash_part( state, std::to_string( spawn.weight ) );
            hash_part( state, spawn.builtin_id );
            hash_part( state, spawn.vehicle_group );
            hash_part( state, std::to_string( spawn.number_min ) );
            hash_part( state, std::to_string( spawn.number_max ) );
            hash_part( state, std::to_string( spawn.fuel ) );
            hash_part( state, std::to_string( spawn.status ) );
            hash_part( state, spawn.placement );
            if( spawn.location ) {
                hash_part( state, std::to_string( spawn.location->x_min ) );
                hash_part( state, std::to_string( spawn.location->x_max ) );
                hash_part( state, std::to_string( spawn.location->y_min ) );
                hash_part( state, std::to_string( spawn.location->y_max ) );
                for( const std::int64_t facing : spawn.location->facings ) {
                    hash_part( state, std::to_string( facing ) );
                }
            }
        }
    }
    for( const fault_group_registration &entry : pimpl_->fault_groups ) {
        hash_part( state, "fault_group" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const auto &[fault, weight] : entry.definition->entries ) {
            hash_part( state, fault );
            hash_part( state, std::to_string( weight ) );
        }
    }
    for( const explosion_light_registration &entry : pimpl_->explosion_lights ) {
        hash_part( state, "explosion_light" );
        hash_part( state, operation_name( entry.operation ) );
        const explosion_light_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        for( const light_stop &stop : value.stops ) {
            hash_part( state, std::to_string( stop.color[0] ) );
            hash_part( state, std::to_string( stop.color[1] ) );
            hash_part( state, std::to_string( stop.color[2] ) );
            hash_part( state, std::to_string( stop.alpha ) );
        }
        hash_part( state, value.easing );
        hash_part( state, std::to_string( value.wave_travel ) );
        hash_part( state, std::to_string( value.wave_gap ) );
        hash_part( state, std::to_string( value.rise ) );
        hash_part( state, std::to_string( value.fade ) );
        hash_part( state, std::to_string( value.blend ) );
        hash_part( state, std::to_string( value.spread_jitter ) );
        hash_part( state, std::to_string( value.color_jitter ) );
        hash_part( state, std::to_string( value.flicker ) );
        hash_part( state, std::to_string( value.duration_base_ms ) );
        hash_part( state, std::to_string( value.duration_per_tile_ms ) );
        hash_part( state, std::to_string( value.duration_min_ms ) );
        hash_part( state, std::to_string( value.duration_max_ms ) );
        hash_part( state, std::to_string( value.screen_shake_magnitude ) );
        hash_part( state, std::to_string( value.screen_shake_duration_ms ) );
        hash_part( state, value.shockwave ? "shockwave" : "no_shockwave" );
        hash_part( state, std::to_string( value.shockwave_strength ) );
        hash_part( state, std::to_string( value.shockwave_speed ) );
        hash_part( state, std::to_string( value.shockwave_thickness ) );
    }
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::ammunition_effects, state );
    for( const addiction_type_registration &entry : pimpl_->addiction_types ) {
        hash_part( state, "addiction_type" );
        hash_part( state, operation_name( entry.operation ) );
        const addiction_type_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.type_name );
        hash_part( state, value.description );
        hash_part( state, value.craving_morale );
        hash_part( state, value.tick_handler );
    }
    for( const character_modifier_registration &entry : pimpl_->character_modifiers ) {
        hash_part( state, "character_modifier" );
        hash_part( state, operation_name( entry.operation ) );
        const character_modifier_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.description );
        hash_part( state, value.operation );
        hash_part( state, value.evaluator_handler );
    }
    for( const start_location_registration &entry : pimpl_->start_locations ) {
        hash_part( state, "start_location" );
        hash_part( state, operation_name( entry.operation ) );
        const start_location_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        for( const start_location_target_definition_data &target : value.targets ) {
            hash_part( state, target.terrain );
            hash_part( state, target.match );
            for( const auto &[parameter, parameter_value] : target.parameters ) {
                hash_part( state, parameter );
                hash_part( state, parameter_value );
            }
        }
        for( const std::string &flag : value.flags ) {
            hash_part( state, flag );
        }
        hash_part( state, std::to_string( value.city_size_min ) );
        hash_part( state, std::to_string( value.city_size_max ) );
        hash_part( state, std::to_string( value.city_distance_min ) );
        hash_part( state, std::to_string( value.city_distance_max ) );
        hash_part( state, std::to_string( value.z_min ) );
        hash_part( state, std::to_string( value.z_max ) );
    }
    for( const climbing_aid_registration &entry : pimpl_->climbing_aids ) {
        hash_part( state, "climbing_aid" );
        hash_part( state, operation_name( entry.operation ) );
        const climbing_aid_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, std::to_string( value.slip_chance_modifier ) );
        hash_part( state, value.category );
        hash_part( state, value.flag );
        hash_part( state, std::to_string( value.uses ) );
        hash_part( state, std::to_string( value.range ) );
        hash_part( state, std::to_string( value.max_height ) );
        hash_part( state, std::to_string( value.easy_climb_back_up ) );
        hash_part( state, value.allow_remaining_height ? "remaining" : "full_height" );
        hash_part( state, value.menu_text );
        hash_part( state, value.unavailable_text );
        hash_part( state, value.hotkey );
        hash_part( state, value.confirm_text );
        hash_part( state, value.before_message );
        hash_part( state, value.after_message );
        hash_part( state, std::to_string( value.pain ) );
        hash_part( state, std::to_string( value.damage ) );
        hash_part( state, std::to_string( value.kilocalories ) );
        hash_part( state, std::to_string( value.thirst ) );
        hash_part( state, value.deploy_furniture );
    }
    for( const weather_type_registration &entry : pimpl_->weather_types ) {
        hash_part( state, "weather_type" );
        hash_part( state, operation_name( entry.operation ) );
        const weather_type_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.name );
        hash_part( state, value.color );
        hash_part( state, value.map_color );
        hash_part( state, value.symbol );
        hash_part( state, value.sun_symbol );
        hash_part( state, std::to_string( value.ranged_penalty ) );
        hash_part( state, std::to_string( value.sight_penalty ) );
        hash_part( state, std::to_string( value.light_modifier ) );
        hash_part( state, std::to_string( value.temperature_delta_kelvin ) );
        hash_part( state, std::to_string( value.light_multiplier ) );
        hash_part( state, std::to_string( value.sun_multiplier ) );
        hash_part( state, std::to_string( value.sound_attenuation ) );
        hash_part( state, value.dangerous ? "dangerous" : "safe" );
        hash_part( state, value.precipitation );
        hash_part( state, value.rains ? "rain" : "not_rain" );
        hash_part( state, value.tiles_animation );
        hash_part( state, value.sound_category );
        hash_part( state, std::to_string( value.priority ) );
        hash_part( state, std::to_string( value.minimum_duration_turns ) );
        hash_part( state, std::to_string( value.maximum_duration_turns ) );
        hash_part( state, value.has_animation ? "animation" : "no_animation" );
        hash_part( state, std::to_string( value.animation_factor ) );
        hash_part( state, value.animation_color );
        hash_part( state, value.animation_symbol );
        for( const std::string &weather : value.required_weathers ) {
            hash_part( state, weather );
        }
        for( const weather_passive_effect_definition_data &effect : value.passive_effects ) {
            hash_part( state, effect.effect );
            hash_part( state, std::to_string( effect.minimum_duration_turns ) );
            hash_part( state, std::to_string( effect.maximum_duration_turns ) );
            hash_part( state, std::to_string( effect.intensity ) );
            hash_part( state, effect.body_part );
            hash_part( state, effect.environmental ? "environmental" : "internal" );
            hash_part( state, effect.immune_in_vehicle ? "immune_vehicle" : "not_immune_vehicle" );
            hash_part( state, effect.immune_inside_vehicle ? "immune_inside" : "not_immune_inside" );
            hash_part( state, effect.immune_outside_vehicle ? "immune_outside" : "not_immune_outside" );
            hash_part( state, std::to_string( effect.chance_in_vehicle ) );
            hash_part( state, std::to_string( effect.chance_inside_vehicle ) );
            hash_part( state, std::to_string( effect.chance_outside_vehicle ) );
            hash_part( state, effect.message );
            hash_part( state, effect.npc_message );
        }
        hash_part( state, value.condition_handler );
    }
    for( const event_transformation_registration &entry : pimpl_->event_transformations ) {
        hash_part( state, "event_transformation" );
        hash_part( state, operation_name( entry.operation ) );
        const event_transformation_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.source.kind );
        hash_part( state, value.source.id );
        for( const detail::event_new_field_native_definition &field : value.new_fields ) {
            hash_part( state, field.field );
            hash_part( state, field.transformation );
            hash_part( state, field.input_field );
        }
        for( const detail::event_value_constraint_native_definition &constraint :
             value.constraints ) {
            hash_part( state, constraint.field );
            hash_part( state, constraint.kind );
            hash_part( state, constraint.value_type );
            for( const std::string &constraint_value : constraint.values ) {
                hash_part( state, constraint_value );
            }
            hash_part( state, constraint.statistic );
        }
        for( const std::string &field : value.drop_fields ) {
            hash_part( state, "drop" );
            hash_part( state, field );
        }
    }
    for( const event_statistic_registration &entry : pimpl_->event_statistics ) {
        hash_part( state, "event_statistic" );
        hash_part( state, operation_name( entry.operation ) );
        const event_statistic_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.statistic_type );
        hash_part( state, value.source.kind );
        hash_part( state, value.source.id );
        hash_part( state, value.field );
        hash_part( state, value.description );
        hash_part( state, value.description_plural );
    }
    for( const relic_procgen_registration &entry : pimpl_->relic_procgens ) {
        hash_part( state, "relic_procgen" );
        hash_part( state, operation_name( entry.operation ) );
        const relic_procgen_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        for( const relic_procgen_passive_definition_data &passive : value.passive_values ) {
            hash_part( state, passive.kind );
            hash_part( state, passive.type );
            hash_part( state, std::to_string( passive.weight ) );
            hash_part( state, std::to_string( passive.power_per_increment ) );
            hash_part( state, std::to_string( passive.increment ) );
            hash_part( state, std::to_string( passive.minimum ) );
            hash_part( state, std::to_string( passive.maximum ) );
            hash_part( state, passive.has );
        }
        for( const relic_procgen_active_definition_data &active : value.active_values ) {
            hash_part( state, active.kind );
            hash_part( state, active.spell );
            hash_part( state, std::to_string( active.weight ) );
            hash_part( state, std::to_string( active.base_power ) );
            hash_part( state, std::to_string( active.power_per_increment ) );
            hash_part( state, std::to_string( active.increment ) );
            hash_part( state, std::to_string( active.minimum_level ) );
            hash_part( state, std::to_string( active.maximum_level ) );
            hash_part( state, active.has );
        }
        for( const auto &[kind, weight] : value.type_weights ) {
            hash_part( state, kind );
            hash_part( state, std::to_string( weight ) );
        }
        for( const auto &[item_id, weight] : value.item_weights ) {
            hash_part( state, item_id );
            hash_part( state, std::to_string( weight ) );
        }
        for( const relic_procgen_charge_definition_data &charge : value.charges ) {
            hash_part( state, std::to_string( charge.weight ) );
            hash_part( state, std::to_string( charge.initial_minimum ) );
            hash_part( state, std::to_string( charge.initial_maximum ) );
            hash_part( state, std::to_string( charge.use_minimum ) );
            hash_part( state, std::to_string( charge.use_maximum ) );
            hash_part( state, std::to_string( charge.maximum_minimum ) );
            hash_part( state, std::to_string( charge.maximum_maximum ) );
            hash_part( state, std::to_string( charge.time_minimum_turns ) );
            hash_part( state, std::to_string( charge.time_maximum_turns ) );
            hash_part( state, std::to_string( charge.power ) );
            hash_part( state, charge.recharge_type );
        }
    }
    pimpl_->presentation.append_fingerprint( state );
    for( const attack_vector_registration &entry : pimpl_->attack_vectors ) {
        hash_part( state, "attack_vector" );
        hash_part( state, operation_name( entry.operation ) );
        const attack_vector_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.weapon ? "weapon" : "unarmed" );
        hash_part( state, value.strict_limbs ? "strict" : "substitutions" );
        hash_part( state, value.armor_bonus ? "armor_bonus" : "natural_only" );
        hash_part( state, std::to_string( value.encumbrance_limit ) );
        hash_part( state, std::to_string( value.health_percent_limit ) );
        for( const std::string &limb : value.limbs ) {
            hash_part( state, limb );
        }
        for( const std::string &contact : value.contacts ) {
            hash_part( state, contact );
        }
        for( const auto &[kind, count] : value.limb_requirements ) {
            hash_part( state, kind );
            hash_part( state, std::to_string( count ) );
        }
        for( const std::string &flag : value.required_flags ) {
            hash_part( state, "requires" );
            hash_part( state, flag );
        }
        for( const std::string &flag : value.forbidden_flags ) {
            hash_part( state, "forbids" );
            hash_part( state, flag );
        }
    }
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::magic_type, state );
    pimpl_->character.append_fingerprint(
        character_content_fingerprint_phase::movement_mode, state );
    for( const terrain_transform_registration &entry : pimpl_->terrain_transforms ) {
        hash_part( state, "terrain_transform" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const terrain_transform_rule_definition_data &rule : entry.definition->rules ) {
            hash_part( state, rule.kind );
            for( const std::string &input : rule.inputs ) {
                hash_part( state, "input" );
                hash_part( state, input );
            }
            for( const std::string &flag : rule.flags ) {
                hash_part( state, "flag" );
                hash_part( state, flag );
            }
            for( const auto &[result, weight] : rule.results ) {
                hash_part( state, result );
                hash_part( state, std::to_string( weight ) );
            }
            hash_part( state, rule.message );
            hash_part( state, rule.message_good ? "good" : "bad" );
        }
    }
    for( const post_process_generator_registration &entry :
         pimpl_->post_process_generators ) {
        hash_part( state, "post_process_generator" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const post_process_stage_definition_data &stage : entry.definition->stages ) {
            hash_part( state, stage.kind );
            hash_part( state, std::to_string( stage.attempts ) );
            hash_part( state, std::to_string( stage.chance ) );
            hash_part( state, std::to_string( stage.min_intensity ) );
            hash_part( state, std::to_string( stage.max_intensity ) );
            hash_part( state, std::to_string( stage.scaling_days_start ) );
            hash_part( state, std::to_string( stage.scaling_days_end ) );
            hash_part( state, stage.scope );
        }
    }
    pimpl_->worldgen.append_fingerprint( state );
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::metadata, state );
    for( const speed_description_registration &entry : pimpl_->speed_descriptions ) {
        hash_part( state, "speed_description" );
        hash_part( state, operation_name( entry.operation ) );
        hash_part( state, entry.definition->id );
        for( const speed_description_value_data &value : entry.definition->values ) {
            hash_part( state, std::to_string( value.threshold ) );
            for( const std::string &description : value.descriptions ) {
                hash_part( state, description );
            }
        }
    }
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::item_groups, state );
    for( const harvest_drop_type_registration &entry : pimpl_->harvest_drop_types ) {
        hash_part( state, "harvest_drop_type" );
        hash_part( state, operation_name( entry.operation ) );
        const harvest_drop_type_definition_data &value = *entry.definition;
        hash_part( state, value.id );
        hash_part( state, value.item_group ? "item_group" : "item" );
        hash_part( state, value.dissect_only ? "dissect_only" : "all_butchery" );
        hash_part( state, value.field_dress_success );
        hash_part( state, value.field_dress_failure );
        hash_part( state, value.butcher_success );
        hash_part( state, value.butcher_failure );
        hash_part( state, value.dissect_success );
        hash_part( state, value.dissect_failure );
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
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::behavior, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::effect_type, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::sub_body_part, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::wound_type, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::body_part, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::anatomy, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::monster, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::field_type, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::monster_attack, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::weakpoint_set, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::morale_type, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::disease_type, state );
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::requirements, state );
    pimpl_->creatures.append_fingerprint(
        creatures_content_fingerprint_phase::wound_fix, state );
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::recipe_groups, state );
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::definitions, state );
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
    pimpl_->item_content.append_fingerprint(
        items_content_fingerprint_phase::recipes, state );
    std::ostringstream result;
    result << std::hex << state;
    return result.str();
}

bool content_transaction::was_applied() const
{
    return pimpl_->applied;
}

bool content_transaction::find_item_handler(
    const std::string_view item_id, const std::string_view phase,
    std::string &handler_id ) const
{
    return pimpl_->item_content.find_item_handler( item_id, phase, handler_id );
}

bool content_transaction::find_damage_handler(
    const std::string_view damage_id, const std::string_view phase,
    std::string &handler_id ) const
{
    return pimpl_->item_content.find_damage_handler( damage_id, phase, handler_id );
}

bool content_transaction::find_ammo_effect_handler(
    const std::string_view ammo_effect_id, std::string &handler_id ) const
{
    return pimpl_->item_content.find_ammo_effect_handler(
               ammo_effect_id, handler_id );
}

bool content_transaction::find_plant_lifecycle_handler(
    const std::string_view target, const std::string_view target_id,
    const std::string_view phase, std::string &handler_id ) const
{
    return pimpl_->item_content.find_plant_lifecycle_handler(
               target, target_id, phase, handler_id );
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
    return pimpl_->presentation.find_end_screen_handler(
               end_screen_id_value, handler_id );
}

bool content_transaction::find_activity_type_handler(
    const std::string_view activity_type_id_value, const std::string_view phase,
    std::string &handler_id ) const
{
    return pimpl_->presentation.find_activity_type_handler(
               activity_type_id_value, phase, handler_id );
}

bool content_transaction::find_snippet_handler(
    const std::string_view snippet_id_value, std::string &category_id,
    std::string &handler_id ) const
{
    return pimpl_->presentation.find_snippet_handler(
               snippet_id_value, category_id, handler_id );
}


bool content_transaction::find_magic_type_handler( const std::string_view magic_type_id,
        const std::string_view phase, std::string &handler_id ) const
{
    return pimpl_->character.find_magic_type_handler(
               magic_type_id, phase, handler_id );
}

bool content_transaction::find_emission_handler(
    const std::string_view emission_id, std::string &handler_id ) const
{
    return pimpl_->creatures.find_emission_handler( emission_id, handler_id );
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


bool content_transaction::find_martial_art_handler(
    const std::string_view martial_art_id, const std::string_view phase,
    std::string &handler_id ) const
{
    return pimpl_->character.find_martial_art_handler(
               martial_art_id, phase, handler_id );
}

std::shared_ptr<runtime> make_runtime( const std::string &mod_id,
                                       std::size_t generation,
                                       sol::state &lua,
                                       const std::filesystem::path &mod_root )
{
    return std::make_shared<runtime>( mod_id, generation, lua, mod_root );
}

cata::lua_platform::game_handle_runtime detail::runtime_handle_identity(
    const std::shared_ptr<runtime> &value )
{
    return value ? value->handle_runtime() :
           cata::lua_platform::game_handle_runtime();
}

bool detail::runtime_has_dialogue_topic(
    const std::string_view topic_id,
    const cata::lua_platform::game_handle_runtime &current_runtime,
    const std::size_t current_world_generation )
{
    if( current_world_generation != active_world_generation ||
        !current_runtime.has_live_owner() ) {
        return false;
    }
    const auto owner = std::find_if(
                           active_runtimes.begin(), active_runtimes.end(),
    [&current_runtime]( const std::shared_ptr<runtime> &candidate ) {
        return candidate && candidate->lua != nullptr &&
               candidate->handle_runtime().is_active_match( current_runtime );
    } );
    if( owner == active_runtimes.end() ) {
        return false;
    }
    const std::string id( topic_id );
    return ( *owner )->declarative_dialogue_topics.count( id ) != 0 ||
           ( *owner )->dialogue_topics.count( id ) != 0;
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
bool content_transaction::find_item_handler( std::string_view, std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
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

bool has_platform_item_use_handler( std::string_view )
{
    return false;
}

std::optional<int> invoke_platform_item_use_handler(
    Character *, item &, map *, const tripoint_bub_ms & )
{
    return std::nullopt;
}

} // namespace cata::lua_platform

#endif
