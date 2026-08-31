#include "lua_platform_content_character.h"

#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <array>
#include <cctype>
#include <cmath>
#include <cstdint>
#include <functional>
#include <initializer_list>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <type_traits>
#include <unordered_map>
#include <utility>
#include <vector>

extern "C" {
#include <lua.h>
}

#include "bionics.h"
#include "avatar.h"
#include "calendar.h"
#include "catacharset.h"
#include "character.h"
#include "character_martial_arts.h"
#include "color.h"
#include "creature.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "field_type.h"
#include "magic_enchantment.h"
#include "enum_conversions.h"
#include "generic_factory.h"
#include "item.h"
#include "item_group.h"
#include "lua_platform_content.h"
#include "magic.h"
#include "magic_type.h"
#include "mission.h"
#include "move_mode.h"
#include "monstergenerator.h"
#include "mtype.h"
#include "npc.h"
#include "profession.h"
#include "profession_group.h"
#include "point.h"
#include "requirements.h"
#include "sounds.h"
#include "translation.h"
#include "type_id.h"
#include "widget.h"

namespace cata::lua_platform
{

using detail::invoke_enchantment_condition_handler;
using detail::invoke_enchantment_number_handler;
using detail::invoke_mission_condition_handler;
using detail::invoke_mission_deadline_handler;
using detail::invoke_mission_phase_handler;
using detail::invoke_mission_place_handler;
using detail::invoke_spell_condition_handler;
using detail::invoke_spell_effect_handler;
using detail::invoke_spell_stat_handler;
using detail::invoke_widget_condition_handler;
using detail::invoke_widget_custom_handler;
using detail::widget_custom_handler_result;

namespace
{

enum class definition_operation : int { add, replace, edit };
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

bool fits_native_int( const std::int64_t value )
{
    return value >= std::numeric_limits<int>::min() &&
           value <= std::numeric_limits<int>::max();
}

struct owner_token {
    std::string mod_id;
    std::size_t generation = 0;
    handle_lifecycle lifecycle = handle_lifecycle::building;
};

template<typename Definition>
void require_building_handle( const std::shared_ptr<owner_token> &token,
                              const Definition &definition, const std::string_view kind )
{
    if( !token || token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( std::string( kind ) +
                                  " handle is no longer building" );
    }
    static_cast<void>( definition );
}

template<typename Definition>
void require_readable_handle( const std::shared_ptr<owner_token> &token,
                              const Definition &definition, const std::string_view kind )
{
    if( !token || token->lifecycle == handle_lifecycle::discarded ) {
        throw std::runtime_error( std::string( kind ) +
                                  " handle is no longer readable" );
    }
    static_cast<void>( definition );
}

template<typename Definition>
struct catalog_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<Definition> definition;
};

const char *operation_name( const definition_operation operation )
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
bool registration_id_exists( const std::vector<Registration> &entries,
                             const std::string_view id )
{
    return std::any_of( entries.begin(), entries.end(), [id]( const Registration & entry ) {
        return entry.definition->id == id;
    } );
}

std::optional<magic_energy_type> platform_magic_energy_type( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    if( value == "hp" ) {
        return magic_energy_type::hp;
    }
    if( value == "mana" ) {
        return magic_energy_type::mana;
    }
    if( value == "stamina" ) {
        return magic_energy_type::stamina;
    }
    if( value == "bionic" ) {
        return magic_energy_type::bionic;
    }
    if( value == "vitamin" ) {
        return magic_energy_type::vitamin;
    }
    if( value == "none" ) {
        return magic_energy_type::none;
    }
    return std::nullopt;
}

std::optional<move_mode_type> platform_movement_mode_type( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    if( value == "prone" ) {
        return move_mode_type::PRONE;
    }
    if( value == "crouching" ) {
        return move_mode_type::CROUCHING;
    }
    if( value == "walking" ) {
        return move_mode_type::WALKING;
    }
    if( value == "running" ) {
        return move_mode_type::RUNNING;
    }
    return std::nullopt;
}

std::optional<steed_type> platform_steed_type( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(), []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    if( value == "none" ) {
        return steed_type::NONE;
    }
    if( value == "animal" ) {
        return steed_type::ANIMAL;
    }
    if( value == "mech" ) {
        return steed_type::MECH;
    }
    return std::nullopt;
}

} // namespace

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

// Character definition handles follow the native Lua-first builders.
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
// Registration storage and transactional operations follow below.
using profession_registration = catalog_registration<profession_definition_data>;
using profession_group_registration = catalog_registration<profession_group_definition_data>;
using widget_registration = catalog_registration<widget_definition_data>;
using enchantment_registration = catalog_registration<enchantment_definition_data>;
using bionic_registration = catalog_registration<bionic_definition_data>;
using spell_registration = catalog_registration<spell_definition_data>;
using mission_definition_registration = catalog_registration<mission_definition_data>;
using profession_item_substitution_registration =
    catalog_registration<profession_item_substitution_definition_data>;
using profession_item_bonus_registration =
    catalog_registration<profession_item_bonus_definition_data>;
using technique_registration = catalog_registration<technique_definition_data>;
using martial_art_registration = catalog_registration<martial_art_definition_data>;
using magic_type_registration = catalog_registration<magic_type_definition_data>;
using movement_mode_registration = catalog_registration<movement_mode_definition_data>;

struct character_content_transaction::impl {
    impl( std::string owner_id, const std::size_t owner_generation ) :
        owner( std::move( owner_id ) ), generation( owner_generation ),
        token( std::make_shared<owner_token>( owner_token{ owner, generation,
                                              handle_lifecycle::building } ) ) {}

    std::string owner;
    std::size_t generation = 0;
    std::shared_ptr<owner_token> token;

    std::vector<profession_registration> professions;
    std::vector<profession_group_registration> profession_groups;
    std::vector<widget_registration> widgets;
    std::vector<enchantment_registration> enchantments;
    std::vector<bionic_registration> bionics;
    std::vector<spell_registration> spells;
    std::vector<mission_definition_registration> mission_definitions;
    std::vector<profession_item_substitution_registration>
    profession_item_substitutions;
    std::vector<profession_item_bonus_registration> profession_item_bonuses;
    std::vector<technique_registration> techniques;
    std::vector<martial_art_registration> martial_arts;
    std::vector<magic_type_registration> magic_types;
    std::vector<movement_mode_registration> movement_modes;

    std::vector<std::pair<profession_id, std::optional<profession>>> profession_undo;
    std::vector<std::pair<profession_group_id, std::optional<profession_group>>>
    profession_group_undo;
    std::vector<std::pair<widget_id, std::optional<widget>>> widget_undo;
    std::vector<std::pair<enchantment_id, std::optional<enchantment>>> enchantment_undo;
    std::vector<std::pair<bionic_id, std::optional<bionic_data>>> bionic_undo;
    std::vector<std::pair<spell_id, std::optional<spell_type>>> spell_undo;
    std::vector<std::pair<mission_type_id, std::optional<mission_type>>>
    mission_definition_undo;
    std::optional<detail::profession_item_substitution_native_snapshot>
    profession_item_substitution_undo;
    std::vector<std::pair<matec_id, std::optional<ma_technique>>> technique_undo;
    std::vector<std::pair<matype_id, std::optional<martialart>>> martial_art_undo;
    std::vector<std::pair<magic_type_id, std::optional<magic_type>>> magic_type_undo;
    std::vector<std::pair<move_mode_id, std::optional<move_mode>>> movement_mode_undo;

    character_content_apply_phase next_apply_phase =
        character_content_apply_phase::profession;
    std::size_t applied_phase_count = 0;
    mutable bool finalization_validated = false;
    bool applied = false;
};

character_content_transaction::character_content_transaction( std::string owner,
        const std::size_t generation ) :
    pimpl_( std::make_unique<impl>( std::move( owner ), generation ) )
{}

character_content_transaction::~character_content_transaction() = default;

bool character_content_transaction::register_definition( const sol::object &value,
        const int raw_operation )
{
    if( raw_operation < 0 || raw_operation > 2 ) {
        throw std::runtime_error( "invalid Platform content operation" );
    }
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        throw std::runtime_error( "content transaction is no longer building" );
    }
    const definition_operation operation = static_cast<definition_operation>( raw_operation );
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
#define CATA_CHARACTER_REGISTER( handle_type, member, kind ) \
    if( value.is<handle_type>() ) { \
        register_catalog( value.as<handle_type>(), pimpl_->member, kind ); \
        return true; \
    }
    CATA_CHARACTER_REGISTER( profession_definition_handle, professions, "profession" )
    CATA_CHARACTER_REGISTER( profession_group_definition_handle, profession_groups,
                             "profession group" )
    CATA_CHARACTER_REGISTER( widget_definition_handle, widgets, "widget" )
    CATA_CHARACTER_REGISTER( enchantment_definition_handle, enchantments, "enchantment" )
    CATA_CHARACTER_REGISTER( bionic_definition_handle, bionics, "bionic" )
    CATA_CHARACTER_REGISTER( spell_definition_handle, spells, "spell" )
    CATA_CHARACTER_REGISTER( mission_definition_handle, mission_definitions,
                             "mission definition" )
    CATA_CHARACTER_REGISTER( profession_item_substitution_definition_handle,
                             profession_item_substitutions, "profession item substitution" )
    CATA_CHARACTER_REGISTER( profession_item_bonus_definition_handle, profession_item_bonuses,
                             "profession item bonus" )
    CATA_CHARACTER_REGISTER( technique_definition_handle, techniques, "technique" )
    CATA_CHARACTER_REGISTER( martial_art_definition_handle, martial_arts, "martial art" )
    CATA_CHARACTER_REGISTER( magic_type_definition_handle, magic_types, "magic type" )
    CATA_CHARACTER_REGISTER( movement_mode_definition_handle, movement_modes, "movement mode" )
#undef CATA_CHARACTER_REGISTER
    return false;
}

void character_content_transaction::install_lua_api( sol::state &lua, sol::table &ccb,
        sol::table &content )
{
    ccb.new_usertype<profession_definition_handle>(
        "ProfessionDefinition", sol::no_constructor,
        "id", sol::property( &profession_definition_handle::id ),
        "items", &profession_definition_handle::items,
        "requirement", &profession_definition_handle::requirement,
        "skill", &profession_definition_handle::skill,
        "addiction", &profession_definition_handle::addiction,
        "cbm", &profession_definition_handle::cbm,
        "proficiency", &profession_definition_handle::proficiency,
        "recipe", &profession_definition_handle::recipe,
        "trait", &profession_definition_handle::trait,
        "forbid_trait", &profession_definition_handle::forbid_trait,
        "flag", &profession_definition_handle::flag,
        "hobby", &profession_definition_handle::hobby,
        "martial_art", &profession_definition_handle::martial_art,
        "martial_art_choice", &profession_definition_handle::martial_art_choice,
        "pet", &profession_definition_handle::pet,
        "spell", &profession_definition_handle::spell,
        "mission", &profession_definition_handle::mission,
        "on_start", &profession_definition_handle::on_start );
    ccb.new_usertype<profession_group_definition_handle>(
        "ProfessionGroupDefinition", sol::no_constructor,
        "id", sol::property( &profession_group_definition_handle::id ),
        "profession", &profession_group_definition_handle::profession );
    ccb.new_usertype<widget_definition_handle>(
        "WidgetDefinition", sol::no_constructor,
        "id", sol::property( &widget_definition_handle::id ),
        "bodypart", &widget_definition_handle::bodypart,
        "color", &widget_definition_handle::color,
        "break_at", &widget_definition_handle::break_at,
        "child", &widget_definition_handle::child,
        "flag", &widget_definition_handle::flag,
        "clause", &widget_definition_handle::clause,
        "default_clause", &widget_definition_handle::default_clause,
        "custom_value", &widget_definition_handle::custom_value );
    ccb.new_usertype<enchantment_definition_handle>(
        "EnchantmentDefinition", sol::no_constructor,
        "id", sol::property( &enchantment_definition_handle::id ),
        "value", &enchantment_definition_handle::value,
        "skill", &enchantment_definition_handle::skill,
        "custom", &enchantment_definition_handle::custom,
        "encumbrance", &enchantment_definition_handle::encumbrance,
        "max_hp", &enchantment_definition_handle::max_hp,
        "limb_score", &enchantment_definition_handle::limb_score,
        "melee_damage", &enchantment_definition_handle::melee_damage,
        "incoming_damage", &enchantment_definition_handle::incoming_damage,
        "post_armor_damage", &enchantment_definition_handle::post_armor_damage,
        "effect", &enchantment_definition_handle::effect,
        "bodypart_change", &enchantment_definition_handle::bodypart_change,
        "mutation", &enchantment_definition_handle::mutation,
        "hit_you", &enchantment_definition_handle::hit_you,
        "hit_me", &enchantment_definition_handle::hit_me,
        "every", &enchantment_definition_handle::every,
        "vision", &enchantment_definition_handle::vision,
        "active_when", &enchantment_definition_handle::active_when );
    ccb.new_usertype<bionic_definition_handle>(
        "BionicDefinition", sol::no_constructor,
        "id", sol::property( &bionic_definition_handle::id ),
        "activation_spell", &bionic_definition_handle::activation_spell,
        "fuel", &bionic_definition_handle::fuel,
        "enchantment", &bionic_definition_handle::enchantment,
        "martial_art", &bionic_definition_handle::martial_art,
        "proficiency", &bionic_definition_handle::proficiency,
        "passive_item", &bionic_definition_handle::passive_item,
        "toggled_item", &bionic_definition_handle::toggled_item,
        "cancel_mutation", &bionic_definition_handle::cancel_mutation,
        "include_bionic", &bionic_definition_handle::include_bionic,
        "auto_deactivate", &bionic_definition_handle::auto_deactivate,
        "flag", &bionic_definition_handle::flag,
        "environment_protection", &bionic_definition_handle::environment_protection,
        "armor", &bionic_definition_handle::armor,
        "occupies", &bionic_definition_handle::occupies,
        "encumbers", &bionic_definition_handle::encumbers,
        "installable_weapon_flag", &bionic_definition_handle::installable_weapon_flag,
        "replace_bodypart", &bionic_definition_handle::replace_bodypart,
        "conflict_mutation", &bionic_definition_handle::conflict_mutation,
        "give_mutation_when_removed", &bionic_definition_handle::give_mutation_when_removed,
        "learn_spell", &bionic_definition_handle::learn_spell,
        "available_upgrade", &bionic_definition_handle::available_upgrade );
    ccb.new_usertype<spell_definition_handle>(
        "SpellDefinition", sol::no_constructor,
        "id", sol::property( &spell_definition_handle::id ),
        "target", &spell_definition_handle::target,
        "flag", &spell_definition_handle::flag,
        "target_monster", &spell_definition_handle::target_monster,
        "target_species", &spell_definition_handle::target_species,
        "ignore_species", &spell_definition_handle::ignore_species,
        "bodypart", &spell_definition_handle::bodypart,
        "extra_spell", &spell_definition_handle::extra_spell,
        "learn_spell", &spell_definition_handle::learn_spell,
        "stat", &spell_definition_handle::stat,
        "stat_range", &spell_definition_handle::stat_range,
        "dynamic_stat", &spell_definition_handle::dynamic_stat,
        "lua_effect", &spell_definition_handle::lua_effect,
        "caster_when", &spell_definition_handle::caster_when,
        "target_when", &spell_definition_handle::target_when );
    ccb.new_usertype<mission_definition_handle>(
        "MissionDefinition", sol::no_constructor,
        "id", sol::property( &mission_definition_handle::id ),
        "origin", &mission_definition_handle::origin,
        "dialogue", &mission_definition_handle::dialogue,
        "reward", &mission_definition_handle::reward,
        "deadline", &mission_definition_handle::deadline,
        "dynamic_deadline", &mission_definition_handle::dynamic_deadline,
        "place_when", &mission_definition_handle::place_when,
        "start_with", &mission_definition_handle::start_with,
        "finish_with", &mission_definition_handle::finish_with,
        "fail_with", &mission_definition_handle::fail_with,
        "complete_when", &mission_definition_handle::complete_when );

    ccb.new_usertype<profession_item_substitution_definition_handle>(
        "ProfessionItemSubstitutionDefinition", sol::no_constructor,
        "id", sol::property( &profession_item_substitution_definition_handle::id ),
        "when", &profession_item_substitution_definition_handle::when );
    ccb.new_usertype<profession_item_bonus_definition_handle>(
        "ProfessionItemBonusDefinition", sol::no_constructor,
        "id", sol::property( &profession_item_bonus_definition_handle::id ),
        "when", &profession_item_bonus_definition_handle::when );
    ccb.new_usertype<technique_definition_handle>(
        "TechniqueDefinition", sol::no_constructor,
        "id", sol::property( &technique_definition_handle::id ),
        "flag", &technique_definition_handle::flag,
        "attack_vector", &technique_definition_handle::attack_vector,
        "requires_skill", &technique_definition_handle::requires_skill,
        "on_apply", &technique_definition_handle::on_apply );
    ccb.new_usertype<martial_art_definition_handle>(
        "MartialArtDefinition", sol::no_constructor,
        "id", sol::property( &martial_art_definition_handle::id ),
        "autolearn", &martial_art_definition_handle::autolearn,
        "technique", &martial_art_definition_handle::technique,
        "weapon", &martial_art_definition_handle::weapon,
        "weapon_category", &martial_art_definition_handle::weapon_category,
        "on", &martial_art_definition_handle::on );
    ccb.new_usertype<magic_type_definition_handle>(
        "MagicTypeDefinition", sol::no_constructor,
        "id", sol::property( &magic_type_definition_handle::id ),
        "cannot_cast_when", &magic_type_definition_handle::cannot_cast_when,
        "progression", &magic_type_definition_handle::progression,
        "casting_experience", &magic_type_definition_handle::casting_experience,
        "failure_chance", &magic_type_definition_handle::failure_chance,
        "failure_cost", &magic_type_definition_handle::failure_cost,
        "failure_experience", &magic_type_definition_handle::failure_experience,
        "on_failure", &magic_type_definition_handle::on_failure );
    ccb.new_usertype<movement_mode_definition_handle>(
        "MovementModeDefinition", sol::no_constructor,
        "id", sol::property( &movement_mode_definition_handle::id ),
        "messages", &movement_mode_definition_handle::messages );

    content.set_function( "Profession", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<profession_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        const std::string common_name = options.get_or( "name", definition->id );
        definition->name_male = options.get_or( "name_male", common_name );
        definition->name_female = options.get_or( "name_female", common_name );
        const std::string common_description =
            options.get_or( "description", std::string() );
        definition->description_male = options.get_or(
                                           "description_male", common_description );
        definition->description_female = options.get_or(
                                             "description_female", common_description );
        definition->points = options.get_or<std::int64_t>( "points", 0 );
        if( const sol::optional<std::int64_t> starting_cash =
                options.get<sol::optional<std::int64_t>>( "starting_cash" ) ) {
            definition->starting_cash = *starting_cash;
        }
        definition->npc_background = options.get_or(
                                         "npc_background", definition->npc_background );
        definition->chargen_allow_npc = options.get_or( "chargen_allow_npc", true );
        definition->age_lower = options.get_or<std::int64_t>(
                                    "age_lower", profession::DEFAULT_PROF_AGE_LOWER );
        definition->age_upper = options.get_or<std::int64_t>(
                                    "age_upper", profession::DEFAULT_PROF_AGE_UPPER );
        definition->starting_vehicle = options.get_or( "vehicle", std::string() );
        definition->items_both = options.get_or( "items_both", definition->items_both );
        definition->items_male = options.get_or( "items_male", definition->items_male );
        definition->items_female = options.get_or( "items_female", definition->items_female );
        definition->no_bonus = options.get_or( "no_bonus", std::string() );
        definition->hard_requirement = options.get_or( "hard_requirement", false );
        definition->hobbies_whitelist = options.get_or( "whitelist_hobbies", true );
        definition->martial_arts_choice_amount = options.get_or<std::int64_t>(
                    "starting_styles_choices_amount", 1 );
        definition->subtype = options.get_or( "subtype", std::string() );
        definition->start_handler = options.get_or(
                                        "on_start", options.get_or(
                                            "start_handler", std::string() ) );

        profession_definition_handle handle{ definition, pimpl_->token };
        const auto each_array_entry = [&options]( const char *key, const char *label,
        const auto & visitor ) {
            const sol::optional<sol::table> values =
                options.get<sol::optional<sol::table>>( key );
            if( !values ) {
                return;
            }
            const std::size_t count = require_dense_array( *values, label, 0, 4096 );
            for( std::size_t index = 1; index <= count; ++index ) {
                visitor( values->raw_get<sol::object>( index ) );
            }
        };
        const auto each_string = [&each_array_entry]( const char *key, const char *label,
        const auto & visitor ) {
            each_array_entry( key, label, [label, &visitor]( const sol::object & value ) {
                if( !value.is<std::string>() ) {
                    throw std::runtime_error( std::string( label ) +
                                              " must contain strings" );
                }
                visitor( value.as<std::string>() );
            } );
        };

        each_string( "requirements", "profession requirements",
        [&handle]( const std::string & value ) {
            handle.requirement( value );
        } );
        each_array_entry( "skills", "profession skills",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "profession skills must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.skill( item.get_or( "id", item.get_or( "name", std::string() ) ),
                          item.get_or<std::int64_t>( "level", 0 ) );
        } );
        each_array_entry( "addictions", "profession addictions",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "profession addictions must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.addiction( item.get_or( "type", std::string() ),
                              item.get_or<std::int64_t>( "intensity", 1 ) );
        } );
        each_string( "cbms", "profession CBMs", [&handle]( const std::string & value ) {
            handle.cbm( value );
        } );
        each_string( "proficiencies", "profession proficiencies",
        [&handle]( const std::string & value ) {
            handle.proficiency( value );
        } );
        each_string( "recipes", "profession recipes", [&handle]( const std::string & value ) {
            handle.recipe( value );
        } );
        each_array_entry( "traits", "profession traits",
        [&handle]( const sol::object & value ) {
            if( value.is<std::string>() ) {
                handle.trait( value.as<std::string>(), std::string() );
                return;
            }
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "profession traits must contain strings or tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.trait( item.get_or( "id", item.get_or( "trait", std::string() ) ),
                          item.get_or( "variant", std::string() ) );
        } );
        each_string( "forbidden_traits", "profession forbidden traits",
        [&handle]( const std::string & value ) {
            handle.forbid_trait( value );
        } );
        each_string( "flags", "profession flags", [&handle]( const std::string & value ) {
            handle.flag( value );
        } );
        each_string( "hobbies", "profession hobbies", [&handle]( const std::string & value ) {
            handle.hobby( value );
        } );
        each_string( "starting_styles", "profession starting styles",
        [&handle]( const std::string & value ) {
            handle.martial_art( value );
        } );
        each_string( "starting_styles_choices", "profession starting style choices",
        [&handle]( const std::string & value ) {
            handle.martial_art_choice( value );
        } );
        each_array_entry( "pets", "profession pets", [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "profession pets must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.pet( item.get_or( "id", item.get_or( "name", std::string() ) ),
                        item.get_or<std::int64_t>( "amount", 1 ) );
        } );
        each_array_entry( "spells", "profession spells", [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "profession spells must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.spell( item.get_or( "id", item.get_or( "spell", std::string() ) ),
                          item.get_or<std::int64_t>( "level", 0 ) );
        } );
        each_string( "missions", "profession missions", [&handle]( const std::string & value ) {
            handle.mission( value );
        } );
        return handle;
    } );
    content.set_function( "ProfessionGroup", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<profession_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return profession_group_definition_handle{
            std::move( definition ), pimpl_->token
        };
    } );
    content.set_function( "Widget", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<widget_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->width = options.get_or<std::int64_t>( "width", 0 );
        definition->height = options.get_or<std::int64_t>( "height", 1 );
        definition->symbols = options.get_or( "symbols", definition->symbols );
        definition->fill = options.get_or( "fill", definition->fill );
        definition->label = options.get_or( "label", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->style = options.get_or( "style", definition->style );
        definition->arrange = options.get_or( "arrange", definition->arrange );
        definition->body_graph = options.get_or( "body_graph", definition->body_graph );
        definition->direction = options.get_or( "direction", std::string() );
        definition->text_align = options.get_or( "text_align", definition->text_align );
        definition->label_align = options.get_or( "label_align", definition->label_align );
        if( const sol::optional<bool> pad_labels =
                options.get<sol::optional<bool>>( "pad_labels" ) ) {
            definition->pad_labels = *pad_labels;

        }
        if( const sol::optional<std::string> separator =
                options.get<sol::optional<std::string>>( "separator" ) ) {
            definition->separator = *separator;
        }
        if( const sol::optional<std::int64_t> padding =
                options.get<sol::optional<std::int64_t>>( "padding" ) ) {
            definition->padding = *padding;
        }
        definition->variable = options.get_or( "var", std::string() );
        definition->custom_handler = options.get_or(
                                         "custom_handler", std::string() );
        definition->text = options.get_or( "string", std::string() );
        widget_definition_handle handle{ definition, pimpl_->token };

        if( !options.get<sol::optional<sol::table>>( "bodyparts" ) ) {
            if( const sol::optional<std::string> bodypart =
                    options.get<sol::optional<std::string>>( "bodypart" ) ) {
                handle.bodypart( *bodypart );
            }
        }
        const auto each_array_entry = [&options]( const char *key, const char *label,
        const auto & visitor ) {
            const sol::optional<sol::table> values =
                options.get<sol::optional<sol::table>>( key );
            if( !values ) {
                return;
            }
            const std::size_t count = require_dense_array( *values, label, 0, 4096 );
            for( std::size_t index = 1; index <= count; ++index ) {
                visitor( values->raw_get<sol::object>( index ) );
            }
        };
        const auto each_string = [&each_array_entry]( const char *key, const char *label,
        const auto & visitor ) {
            each_array_entry( key, label, [label, &visitor]( const sol::object & value ) {
                if( !value.is<std::string>() ) {
                    throw std::runtime_error( std::string( label ) + " must contain strings" );
                }
                visitor( value.as<std::string>() );
            } );
        };
        each_string( "bodyparts", "widget bodyparts", [&handle]( const std::string & value ) {
            handle.bodypart( value );
        } );
        each_string( "colors", "widget colors", [&handle]( const std::string & value ) {
            handle.color( value );
        } );
        each_array_entry( "breaks", "widget breaks", [&handle]( const sol::object & value ) {
            if( !value.is<lua_Integer>() ) {
                throw std::runtime_error( "widget breaks must contain integers" );
            }
            handle.break_at( value.as<std::int64_t>() );
        } );
        each_string( "widgets", "widget children", [&handle]( const std::string & value ) {
            handle.child( value );
        } );
        each_string( "flags", "widget flags", [&handle]( const std::string & value ) {
            handle.flag( value );
        } );
        each_array_entry( "clauses", "widget clauses", [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "widget clauses must contain tables" );
            }
            handle.clause( value.as<sol::table>() );
        } );
        if( const sol::optional<sol::table> default_clause =
                options.get<sol::optional<sol::table>>( "default_clause" ) ) {
            handle.default_clause( *default_clause );
        }
        if( !definition->custom_handler.empty() ) {
            handle.custom_value( definition->custom_handler );
        }
        return handle;
    } );
    content.set_function( "Enchantment", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<enchantment_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->has = options.get_or( "has", definition->has );
        definition->condition = options.get_or( "condition", definition->condition );
        definition->condition_handler = options.get_or(
                                            "condition_handler", std::string() );
        definition->emitter = options.get_or( "emitter", std::string() );
        enchantment_definition_handle handle{ definition, pimpl_->token };
        if( !definition->condition_handler.empty() ) {
            handle.active_when( definition->condition_handler );
        }
        const auto each_array_entry = [&options]( const char *key, const char *label,
        const auto & visitor ) {
            const sol::optional<sol::table> values =
                options.get<sol::optional<sol::table>>( key );
            if( !values ) {
                return;
            }
            const std::size_t count = require_dense_array( *values, label, 0, 4096 );
            for( std::size_t index = 1; index <= count; ++index ) {
                visitor( values->raw_get<sol::object>( index ) );
            }
        };
        const auto modifier_array = [&each_array_entry, &handle](
        const char *key, const char *label, const char *kind, const char *target_key ) {
            each_array_entry( key, label, [&handle, kind, target_key, label](
            const sol::object & value ) {
                if( !value.is<sol::table>() ) {
                    throw std::runtime_error( std::string( label ) + " must contain tables" );
                }
                const sol::table item = value.as<sol::table>();
                handle.modifier( kind, item.get_or( target_key, std::string() ), item );
            } );
        };
        modifier_array( "values", "enchantment values", "value", "value" );
        modifier_array( "skills", "enchantment skills", "skill", "value" );
        modifier_array( "custom", "enchantment custom values", "custom", "value" );
        modifier_array( "encumbrance_modifier", "enchantment encumbrance modifiers",
                        "encumbrance", "part" );
        modifier_array( "max_hp_modifier", "enchantment maximum-HP modifiers",
                        "max_hp", "part" );
        modifier_array( "limb_score_modifier", "enchantment limb-score modifiers",
                        "limb_score", "score" );
        modifier_array( "melee_damage_bonus", "enchantment melee-damage modifiers",
                        "melee_damage", "type" );
        modifier_array( "incoming_damage_mod", "enchantment incoming-damage modifiers",
                        "incoming_damage", "type" );
        modifier_array( "incoming_damage_mod_post_absorbed",
                        "enchantment post-armor damage modifiers",
                        "post_armor_damage", "type" );
        each_array_entry( "ench_effects", "enchantment effects",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "enchantment effects must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.effect( item.get_or( "effect", std::string() ),
                           item.get_or<std::int64_t>( "intensity", 1 ) );
        } );
        each_array_entry( "modified_bodyparts", "enchantment body-part changes",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "enchantment body-part changes must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.bodypart_change( item.get_or( "gain", std::string() ),
                                    item.get_or( "lose", std::string() ) );
        } );
        each_array_entry( "mutations", "enchantment mutations",
        [&handle]( const sol::object & value ) {
            if( !value.is<std::string>() ) {
                throw std::runtime_error( "enchantment mutations must contain strings" );
            }
            handle.mutation( value.as<std::string>() );
        } );
        each_array_entry( "hit_you_effect", "enchantment hit-you effects",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "enchantment hit-you effects must contain tables" );
            }
            handle.hit_you( value.as<sol::table>() );
        } );
        each_array_entry( "hit_me_effect", "enchantment hit-me effects",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "enchantment hit-me effects must contain tables" );
            }
            handle.hit_me( value.as<sol::table>() );
        } );
        each_array_entry( "intermittent_effects", "enchantment intermittent effects",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "enchantment intermittent effects must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            const sol::optional<sol::table> spell =
                item.get<sol::optional<sol::table>>( "spell" );
            if( !spell ) {
                throw std::runtime_error( "enchantment intermittent effect requires a spell table" );

            }
            handle.every( item.get_or<std::int64_t>( "frequency_turns", 0 ), *spell );
        } );
        each_array_entry( "special_vision", "enchantment special vision",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "enchantment special vision must contain tables" );
            }
            handle.vision( value.as<sol::table>() );
        } );
        return handle;
    } );
    content.set_function( "Bionic", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<bionic_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        if( const sol::optional<std::string> reason =
                options.get<sol::optional<std::string>>( "cant_remove_reason" ) ) {
            definition->cant_remove_reason = *reason;
        }
        definition->activation_energy_millijoules = options.get_or<std::int64_t>(
                    "activation_energy_millijoules", 0 );
        definition->deactivation_energy_millijoules = options.get_or<std::int64_t>(
                    "deactivation_energy_millijoules", 0 );
        definition->over_time_energy_millijoules = options.get_or<std::int64_t>(
                    "over_time_energy_millijoules", 0 );
        definition->trigger_energy_millijoules = options.get_or<std::int64_t>(
                    "trigger_energy_millijoules", 0 );
        definition->capacity_energy_millijoules = options.get_or<std::int64_t>(
                    "capacity_energy_millijoules", 0 );
        definition->charge_time_turns = options.get_or<std::int64_t>( "charge_time_turns", 0 );
        definition->power_gen_emission = options.get_or( "power_gen_emission", std::string() );
        definition->fake_weapon = options.get_or( "fake_weapon", std::string() );
        definition->upgraded_bionic = options.get_or( "upgraded_bionic", std::string() );
        definition->required_bionic = options.get_or( "required_bionic", std::string() );
        definition->installation_requirement = options.get_or(
                "installation_requirement", std::string() );
        definition->fuel_efficiency = options.get_or( "fuel_efficiency", 0.0 );
        definition->passive_fuel_efficiency = options.get_or(
                "passive_fuel_efficiency", 0.0 );
        if( const sol::optional<double> penalty =
                options.get<sol::optional<double>>( "coverage_power_gen_penalty" ) ) {
            definition->coverage_power_gen_penalty = *penalty;
        }
        definition->social_lie = options.get_or<std::int64_t>( "social_lie", 0 );
        definition->social_persuade = options.get_or<std::int64_t>( "social_persuade", 0 );
        definition->social_intimidate = options.get_or<std::int64_t>( "social_intimidate", 0 );
        if( const sol::optional<sol::table> social =
                options.get<sol::optional<sol::table>>( "social_modifiers" ) ) {
            definition->social_lie = social->get_or<std::int64_t>(
                                         "lie", definition->social_lie );
            definition->social_persuade = social->get_or<std::int64_t>(
                                              "persuade", definition->social_persuade );
            definition->social_intimidate = social->get_or<std::int64_t>(
                                                "intimidate", definition->social_intimidate );
        }
        definition->dupes_allowed = options.get_or( "dupes_allowed", false );
        definition->activated_on_install = options.get_or( "activated_on_install", false );
        definition->included = options.get_or( "included", false );
        definition->activate_remove_cbm = options.get_or( "activate_remove_cbm", false );
        definition->is_remote_fueled = options.get_or( "is_remote_fueled", false );
        definition->exothermic_power_gen = options.get_or( "exothermic_power_gen", false );
        definition->activated_close_ui = options.get_or( "activated_close_ui", false );
        definition->deactivated_close_ui = options.get_or( "deactivated_close_ui", false );
        bionic_definition_handle handle{ definition, pimpl_->token };

        const auto each_array_entry = [&options]( const char *key, const char *label,
        const auto & visitor ) {
            const sol::optional<sol::table> values =
                options.get<sol::optional<sol::table>>( key );
            if( !values ) {
                return;
            }
            const std::size_t count = require_dense_array( *values, label, 0, 4096 );
            for( std::size_t index = 1; index <= count; ++index ) {
                visitor( values->raw_get<sol::object>( index ) );
            }
        };
        const auto each_string = [&each_array_entry]( const char *key, const char *label,
        const auto & visitor ) {
            each_array_entry( key, label, [label, &visitor]( const sol::object & value ) {
                if( !value.is<std::string>() ) {
                    throw std::runtime_error( std::string( label ) + " must contain strings" );
                }
                visitor( value.as<std::string>() );
            } );
        };
        if( const sol::optional<sol::table> spell =
                options.get<sol::optional<sol::table>>( "activation_spell" ) ) {
            handle.activation_spell( *spell );
        }
        each_string( "fuel_options", "bionic fuel options",
        [&handle]( const std::string & value ) {
            handle.fuel( value );
        } );
        each_string( "enchantments", "bionic enchantments",
        [&handle]( const std::string & value ) {
            handle.enchantment( value );
        } );
        each_string( "martial_arts", "bionic martial arts",
        [&handle]( const std::string & value ) {
            handle.martial_art( value );
        } );
        each_string( "proficiencies", "bionic proficiencies",
        [&handle]( const std::string & value ) {
            handle.proficiency( value );
        } );
        each_string( "passive_pseudo_items", "bionic passive pseudo-items",
        [&handle]( const std::string & value ) {
            handle.passive_item( value );
        } );
        each_string( "toggled_pseudo_items", "bionic toggled pseudo-items",
        [&handle]( const std::string & value ) {
            handle.toggled_item( value );
        } );
        each_string( "canceled_mutations", "bionic canceled mutations",
        [&handle]( const std::string & value ) {
            handle.cancel_mutation( value );
        } );
        each_string( "included_bionics", "bionic included bionics",
        [&handle]( const std::string & value ) {
            handle.include_bionic( value );
        } );
        each_string( "auto_deactivated_bionics", "bionic auto-deactivated bionics",
        [&handle]( const std::string & value ) {
            handle.auto_deactivate( value );
        } );
        each_string( "flags", "bionic flags", [&handle]( const std::string & value ) {
            handle.flag( value, "always" );
        } );
        each_string( "active_flags", "bionic active flags",
        [&handle]( const std::string & value ) {
            handle.flag( value, "active" );
        } );
        each_string( "inactive_flags", "bionic inactive flags",
        [&handle]( const std::string & value ) {
            handle.flag( value, "inactive" );
        } );
        each_array_entry( "environment_protection", "bionic environmental protection",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error(
                    "bionic environmental protection must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.environment_protection(
                item.get_or( "bodypart", std::string() ),
                item.get_or<std::int64_t>( "amount", 0 ) );
        } );
        each_array_entry( "protection", "bionic protection",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "bionic protection must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.armor(
                item.get_or( "bodypart", std::string() ),
                item.get_or( "damage_type", item.get_or( "type", std::string() ) ),
                item.get_or( "amount", 0.0 ) );
        } );
        each_array_entry( "occupied_bodyparts", "bionic occupied body parts",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "bionic occupied body parts must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.occupies( item.get_or( "bodypart", std::string() ),
                             item.get_or<std::int64_t>( "slots", 0 ) );
        } );
        each_array_entry( "encumbrance", "bionic encumbrance",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "bionic encumbrance must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.encumbers( item.get_or( "bodypart", std::string() ),

                              item.get_or<std::int64_t>( "amount", 0 ) );
        } );
        each_string( "installable_weapon_flags", "bionic installable weapon flags",
        [&handle]( const std::string & value ) {
            handle.installable_weapon_flag( value );
        } );
        each_string( "replaced_bodyparts", "bionic replaced body parts",
        [&handle]( const std::string & value ) {
            handle.replace_bodypart( value );
        } );
        each_string( "mutation_conflicts", "bionic mutation conflicts",
        [&handle]( const std::string & value ) {
            handle.conflict_mutation( value );
        } );
        each_string( "give_mutation_on_removal", "bionic removal mutations",
        [&handle]( const std::string & value ) {
            handle.give_mutation_when_removed( value );
        } );
        each_array_entry( "learned_spells", "bionic learned spells",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "bionic learned spells must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.learn_spell( item.get_or( "spell", std::string() ),
                                item.get_or<std::int64_t>( "level", 0 ) );
        } );
        each_string( "available_upgrades", "bionic available upgrades",
        [&handle]( const std::string & value ) {
            handle.available_upgrade( value );
        } );
        return handle;
    } );
    content.set_function( "Spell", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<spell_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->message = options.get_or( "message", definition->message );
        definition->skill = options.get_or( "skill", definition->skill );
        definition->magic_type = options.get_or( "magic_type", std::string() );
        definition->components = options.get_or( "components", std::string() );
        definition->sound_description = options.get_or(
                                            "sound_description", definition->sound_description );
        definition->sound_type = options.get_or( "sound_type", definition->sound_type );
        definition->sound_ambient = options.get_or( "sound_ambient", false );
        definition->sound_id = options.get_or( "sound_id", std::string() );
        definition->sound_variant = options.get_or(
                                        "sound_variant", definition->sound_variant );
        definition->effect = options.get_or( "effect", definition->effect );
        definition->effect_handler = options.get_or( "effect_handler", std::string() );
        definition->shape = options.get_or( "shape", definition->shape );
        definition->effect_data = options.get_or(
                                      "effect_data", options.get_or( "effect_str", std::string() ) );
        definition->explosion_light = options.get_or( "explosion_light", std::string() );
        definition->field = options.get_or(
                                "field", options.get_or( "field_id", std::string() ) );
        definition->spell_class = options.get_or( "spell_class", definition->spell_class );
        definition->energy_source = options.get_or(
                                        "energy_source", definition->energy_source );
        definition->energy_vitamin = options.get_or( "energy_vitamin", std::string() );
        definition->energy_color = options.get_or(
                                       "energy_color", definition->energy_color );
        if( const sol::optional<sol::table> energy =
                options.get<sol::optional<sol::table>>( "energy" ) ) {
            definition->energy_source = energy->get_or(
                                            "source", energy->get_or( "type", definition->energy_source ) );
            definition->energy_vitamin = energy->get_or(
                                             "vitamin", definition->energy_vitamin );
            definition->energy_color = energy->get_or(
                                           "color", definition->energy_color );
        }
        definition->damage_type = options.get_or( "damage_type", std::string() );
        definition->get_level_formula = options.get_or(
                                            "get_level_formula", options.get_or(
                                                "get_level_formula_id", std::string() ) );
        definition->exp_for_level_formula = options.get_or(
                                                "exp_for_level_formula", options.get_or(
                                                        "exp_for_level_formula_id", std::string() ) );
        if( const sol::optional<std::int64_t> maximum =
                options.get<sol::optional<std::int64_t>>( "max_book_level" ) ) {
            definition->max_book_level = *maximum;
        }
        definition->caster_condition_handler = options.get_or(
                "caster_condition", options.get_or( "caster_condition_handler", std::string() ) );
        definition->caster_condition_fail_message = options.get_or(
                    "caster_condition_fail_message", std::string() );
        definition->target_condition_handler = options.get_or(
                "target_condition", options.get_or( "target_condition_handler", std::string() ) );
        definition->target_condition_fail_message = options.get_or(
                    "target_condition_fail_message", std::string() );
        definition->teachable = options.get_or( "teachable", true );
        if( const sol::optional<sol::table> channel =
                options.get<sol::optional<sol::table>>( "channel" ) ) {
            const std::int64_t max_channel_turns = channel->get_or<std::int64_t>(
                    "max_channel_turns", 0 );
            definition->channel_turns = channel->get<sol::optional<std::int64_t>>(
                                            "turns" ).value_or( max_channel_turns );
            definition->channel_spell = channel->get_or( "spell", channel->get_or(
                                            "channel_spell", std::string() ) );
            definition->channel_end_spell = channel->get_or(
                                                "end_spell", channel->get_or(
                                                    "channel_end_spell", std::string() ) );
            definition->channel_interrupt_spell = channel->get_or(
                    "interrupt_spell", channel->get_or(
                        "channel_interrupt_spell", std::string() ) );
            definition->channel_uses_energy = channel->get_or(
                                                  "uses_energy", channel->get_or(
                                                          "channel_uses_energy", true ) );
        }
        const auto has_option = [&options]( const std::string & name ) {
            const sol::object value = options.raw_get<sol::object>( name );
            return value.valid() && value.get_type() != sol::type::nil;
        };
        const bool has_final_energy = has_option( "final_energy_cost" );
        const bool has_final_casting = has_option( "final_casting_time" );
        for( auto &[name, value] : definition->stats ) {
            const sol::object supplied = options.raw_get<sol::object>( name );
            if( !supplied.valid() || supplied.get_type() == sol::type::nil ) {
                continue;
            }
            if( supplied.is<double>() ) {
                value = supplied.as<double>();
                continue;
            }
            if( supplied.is<sol::table>() ) {
                const sol::table range = supplied.as<sol::table>();
                value = range.get_or( "minimum", range.get_or( "min", value ) );
                definition->stat_maximums[name] = range.get_or(
                                                      "maximum", range.get_or( "max", value ) );
                continue;
            }
            throw std::runtime_error( "spell stat '" + name +
                                      "' must be a number or range table" );
        }
        if( !has_final_energy ) {
            definition->stats["final_energy_cost"] = definition->stats["base_energy_cost"];
        }
        if( !has_final_casting ) {
            definition->stats["final_casting_time"] = definition->stats["base_casting_time"];
        }
        spell_definition_handle handle{ definition, pimpl_->token };
        if( !definition->effect_handler.empty() ) {
            handle.lua_effect( definition->effect_handler );
        }

        const auto each_array_entry = [&options]( const char *key, const char *label,
        const auto & visitor ) {
            const sol::optional<sol::table> values =
                options.get<sol::optional<sol::table>>( key );
            if( !values ) {
                return;
            }
            const std::size_t count = require_dense_array( *values, label, 0, 4096 );
            for( std::size_t index = 1; index <= count; ++index ) {
                visitor( values->raw_get<sol::object>( index ) );
            }
        };
        const auto each_string = [&each_array_entry]( const char *key, const char *label,
        const auto & visitor ) {
            each_array_entry( key, label, [label, &visitor]( const sol::object & value ) {
                if( !value.is<std::string>() ) {
                    throw std::runtime_error( std::string( label ) + " must contain strings" );
                }
                visitor( value.as<std::string>() );
            } );
        };
        each_string( "valid_targets", "spell valid targets",
        [&handle]( const std::string & value ) {
            handle.target( value );
        } );
        each_string( "flags", "spell flags", [&handle]( const std::string & value ) {
            handle.flag( value );
        } );
        each_string( "targeted_monsters", "spell targeted monsters",
        [&handle]( const std::string & value ) {
            handle.target_monster( value );

        } );
        each_string( "targeted_species", "spell targeted species",
        [&handle]( const std::string & value ) {
            handle.target_species( value );
        } );
        each_string( "ignored_species", "spell ignored species",
        [&handle]( const std::string & value ) {
            handle.ignore_species( value );
        } );
        each_string( "affected_bodyparts", "spell affected body parts",
        [&handle]( const std::string & value ) {
            handle.bodypart( value );
        } );
        each_array_entry( "additional_spells", "spell additional spells",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "spell additional spells must contain tables" );
            }
            handle.extra_spell( value.as<sol::table>() );
        } );
        each_array_entry( "learned_spells", "spell learned spells",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "spell learned spells must contain tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.learn_spell( item.get_or( "spell", std::string() ),
                                item.get_or<std::int64_t>( "level", 0 ) );
        } );
        if( const sol::optional<sol::table> handlers =
                options.get<sol::optional<sol::table>>( "dynamic_stats" ) ) {
            std::size_t count = 0;
            for( const auto &entry : *handlers ) {
                if( ++count > definition->stats.size() ||
                    !entry.first.is<std::string>() || !entry.second.is<std::string>() ) {
                    throw std::runtime_error(
                        "spell dynamic_stats must map known stat names to handler ids" );
                }
                handle.dynamic_stat( entry.first.as<std::string>(),
                                     entry.second.as<std::string>() );
            }
        }
        return handle;
    } );
    content.set_function( "Mission", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<mission_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->goal = options.get_or( "goal", definition->goal );
        definition->difficulty = options.get_or<std::int64_t>( "difficulty", 0 );
        definition->value = options.get_or<std::int64_t>( "value", 0 );
        definition->urgent = options.get_or( "urgent", false );
        definition->has_generic_rewards = options.get_or( "has_generic_rewards", true );
        definition->item = options.get_or( "item", std::string() );
        definition->item_group = options.get_or( "item_group", std::string() );
        definition->required_container = options.get_or(
                                             "required_container", std::string() );
        definition->empty_container = options.get_or( "empty_container", std::string() );
        const std::int64_t count = options.get_or<std::int64_t>( "count", 1 );
        definition->item_count = options.get<sol::optional<std::int64_t>>(
                                     "item_count" ).value_or( count );
        definition->remove_container = options.get_or( "remove_container", false );
        definition->invisible_on_complete = options.get_or(
                                                "invisible_on_complete", false );
        definition->recruit_class = options.get_or( "recruit_class", std::string() );
        definition->monster_type = options.get_or( "monster_type", std::string() );
        definition->monster_species = options.get_or( "monster_species", std::string() );
        definition->monster_kill_goal = options.get_or<std::int64_t>(
                                            "monster_kill_goal", -1 );
        definition->destination = options.get_or( "destination", std::string() );
        definition->followup = options.get_or( "followup", std::string() );
        definition->place = options.get_or( "place", definition->place );
        definition->place_handler = options.get_or( "place_handler", std::string() );
        definition->start_handler = options.get_or( "start_handler", std::string() );
        definition->end_handler = options.get_or( "end_handler", std::string() );
        definition->fail_handler = options.get_or( "fail_handler", std::string() );
        definition->goal_condition_handler = options.get_or(
                "goal_condition", options.get_or( "goal_condition_handler", std::string() ) );
        definition->deadline_handler = options.get_or( "deadline_handler", std::string() );
        if( const sol::optional<std::int64_t> deadline =
                options.get<sol::optional<std::int64_t>>( "deadline_turns" ) ) {
            definition->deadline_min_turns = *deadline;
        }
        if( const sol::optional<sol::table> deadline =
                options.get<sol::optional<sol::table>>( "deadline" ) ) {
            const std::int64_t min_turns = deadline->get_or<std::int64_t>(
                                               "min_turns", 0 );
            definition->deadline_min_turns = deadline->get<sol::optional<std::int64_t>>(
                                                 "minimum_turns" ).value_or( min_turns );
            if( const sol::optional<std::int64_t> maximum =
                    deadline->get<sol::optional<std::int64_t>>( "maximum_turns" ) ) {
                definition->deadline_max_turns = *maximum;
            } else if( const sol::optional<std::int64_t> maximum =
                           deadline->get<sol::optional<std::int64_t>>( "max_turns" ) ) {
                definition->deadline_max_turns = *maximum;
            }
            definition->deadline_handler = deadline->get_or(
                                               "handler", definition->deadline_handler );
        }
        if( const sol::optional<sol::table> phases =
                options.get<sol::optional<sol::table>>( "phases" ) ) {
            definition->start_handler = phases->get_or( "start", definition->start_handler );
            definition->end_handler = phases->get_or( "success", phases->get_or(
                                          "end", definition->end_handler ) );
            definition->fail_handler = phases->get_or( "failure", phases->get_or(
                                           "fail", definition->fail_handler ) );
        }
        mission_definition_handle handle{ definition, pimpl_->token };
        const auto each_array_entry = [&options]( const char *key, const char *label,
        const auto & visitor ) {
            const sol::optional<sol::table> values =
                options.get<sol::optional<sol::table>>( key );
            if( !values ) {
                return;
            }
            const std::size_t count = require_dense_array( *values, label, 0, 256 );
            for( std::size_t index = 1; index <= count; ++index ) {
                visitor( values->raw_get<sol::object>( index ) );
            }
        };
        each_array_entry( "origins", "mission origins", [&handle]( const sol::object & value ) {
            if( !value.is<std::string>() ) {
                throw std::runtime_error( "mission origins must contain strings" );
            }
            handle.origin( value.as<std::string>() );
        } );
        each_array_entry( "likely_rewards", "mission likely rewards",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "mission likely rewards must contain tables" );
            }
            const sol::table reward = value.as<sol::table>();
            handle.reward( reward.get_or( "value", 0.0 ),
                           reward.get_or( "description", reward.get_or(
                                              "text", std::string() ) ) );
        } );
        if( const sol::optional<sol::table> dialogue =
                options.get<sol::optional<sol::table>>( "dialogue" ) ) {
            std::size_t count = 0;
            for( const auto &entry : *dialogue ) {
                if( ++count > 64 || !entry.first.is<std::string>() ||
                    !entry.second.is<std::string>() ) {
                    throw std::runtime_error(
                        "mission dialogue must map phase names to strings" );
                }
                handle.dialogue( entry.first.as<std::string>(),
                                 entry.second.as<std::string>() );
            }
        }
        if( !definition->place_handler.empty() ) {
            handle.place_when( definition->place_handler );
        }
        if( !definition->goal_condition_handler.empty() ) {
            handle.complete_when( definition->goal_condition_handler );
        }
        return handle;
    } );
    content.set_function( "ProfessionItemSubstitution", [this](
    const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<profession_item_substitution_definition_data>();
        definition->id = options.get_or( "item", options.get_or( "id", std::string() ) );
        return profession_item_substitution_definition_handle{
            std::move( definition ), pimpl_->token
        };
    } );
    content.set_function( "ProfessionItemBonus", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<profession_item_bonus_definition_data>();
        definition->id = options.get_or( "group", options.get_or( "id", std::string() ) );
        return profession_item_bonus_definition_handle{
            std::move( definition ), pimpl_->token
        };
    } );
    content.set_function( "Technique", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<technique_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->avatar_message = options.get_or( "avatar_message", std::string() );
        definition->npc_message = options.get_or( "npc_message", std::string() );
        definition->crit_tec = options.get_or( "crit_tec", false );
        definition->crit_ok = options.get_or( "crit_ok", false );
        definition->wall_adjacent = options.get_or( "wall_adjacent", false );
        definition->reach_tec = options.get_or( "reach_tec", false );
        definition->reach_ok = options.get_or( "reach_ok", false );
        definition->needs_ammo = options.get_or( "needs_ammo", false );
        definition->defensive = options.get_or( "defensive", false );
        definition->disarms = options.get_or( "disarms", false );
        definition->take_weapon = options.get_or( "take_weapon", false );
        definition->side_switch = options.get_or( "side_switch", false );
        definition->dummy = options.get_or( "dummy", false );
        definition->dodge_counter = options.get_or( "dodge_counter", false );
        definition->block_counter = options.get_or( "block_counter", false );
        definition->miss_recovery = options.get_or( "miss_recovery", false );
        definition->grab_break = options.get_or( "grab_break", false );
        definition->weighting = options.get_or<std::int64_t>( "weighting", 1 );
        definition->repeat_min = options.get_or<std::int64_t>( "repeat_min", 1 );
        definition->repeat_max = options.get_or<std::int64_t>( "repeat_max", 1 );
        definition->down_dur = options.get_or<std::int64_t>( "down_dur", 0 );
        definition->stun_dur = options.get_or<std::int64_t>( "stun_dur", 0 );
        definition->knockback_dist = options.get_or<std::int64_t>( "knockback_dist", 0 );
        definition->knockback_spread = options.get_or( "knockback_spread", 0.0 );
        definition->knockback_follow = options.get_or( "knockback_follow", false );
        definition->aoe = options.get_or( "aoe", std::string() );
        definition->unarmed_allowed = options.get_or( "unarmed_allowed", false );
        definition->melee_allowed = options.get_or( "melee_allowed", false );
        definition->strictly_unarmed = options.get_or( "strictly_unarmed", false );
        definition->apply_handler = options.get_or(
                                        "on_apply",
                                        options.get_or( "apply_handler", std::string() ) );
        return technique_definition_handle{
            std::move( definition ), pimpl_->token
        };
    } );
    content.set_function( "MartialArt", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<martial_art_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->initiate_avatar = options.get_or( "initiate_avatar", std::string() );
        definition->initiate_npc = options.get_or( "initiate_npc", std::string() );
        definition->priority = options.get_or<std::int64_t>( "priority", 0 );
        definition->primary_skill = options.get_or( "primary_skill", std::string() );
        definition->learn_difficulty = options.get_or<std::int64_t>( "learn_difficulty", 0 );
        definition->teachable = options.get_or( "teachable", true );
        definition->arm_block = options.get_or<std::int64_t>( "arm_block", 0 );
        definition->leg_block = options.get_or<std::int64_t>( "leg_block", 0 );
        definition->arm_block_with_bio_armor_arms =
            options.get_or( "arm_block_with_bio_armor_arms", false );
        definition->leg_block_with_bio_armor_legs =
            options.get_or( "leg_block_with_bio_armor_legs", false );
        definition->strictly_unarmed = options.get_or( "strictly_unarmed", false );
        definition->strictly_melee = options.get_or( "strictly_melee", false );
        definition->allow_all_weapons = options.get_or( "allow_all_weapons", false );
        definition->force_unarmed = options.get_or( "force_unarmed", false );
        definition->prevent_weapon_blocking =
            options.get_or( "prevent_weapon_blocking", false );
        for( const char *phase : {
                 "static", "move", "pause", "hit", "attack", "dodge",
                 "block", "gethit", "miss", "crit", "kill"
             } ) {
            const std::string handler = options.get_or(
                                            std::string( "on_" ) + phase, std::string() );
            if( !handler.empty() ) {
                definition->handlers.emplace( phase, handler );
            }
        }
        return martial_art_definition_handle{
            std::move( definition ), pimpl_->token

        };
    } );
    content.set_function( "MagicType", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<magic_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->energy_source = options.get_or( "energy", std::string( "none" ) );
        definition->vitamin = options.get_or( "vitamin", std::string() );
        definition->energy_color = options.get_or( "energy_color", std::string( "cyan" ) );
        if( const sol::optional<std::string> message =
                options.get<sol::optional<std::string>>( "cannot_cast_message" ) ) {
            definition->cannot_cast_message = *message;

        }
        if( const sol::optional<std::int64_t> maximum =
                options.get<sol::optional<std::int64_t>>( "max_book_level" ) ) {
            definition->max_book_level = *maximum;
        }
        definition->failure_cost_fraction = options.get_or(
                                                "failure_cost_fraction", 0.0 );
        definition->failure_experience_fraction = options.get_or(
                    "failure_experience_fraction", 0.2 );
        return magic_type_definition_handle{
            std::move( definition ), pimpl_->token
        };
    } );
    content.set_function( "MovementMode", [this]( const sol::table & options ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
        auto definition = std::make_shared<movement_mode_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->kind = options.get_or( "kind", std::string( "walking" ) );
        definition->panel_color = options.get_or( "panel_color", std::string( "white" ) );
        definition->symbol_color = options.get_or( "symbol_color", std::string( "white" ) );
        definition->exertion = options.get_or( "exertion", 1.0 );
        definition->riding_exertion = options.get_or( "riding_exertion", 0.0 );
        definition->stamina_multiplier = options.get_or(
                                             "stamina_multiplier", 1.0 );
        definition->sound_multiplier = options.get_or(
                                           "sound_multiplier", 1.0 );
        definition->speed_multiplier = options.get_or(
                                           "speed_multiplier", 1.0 );
        definition->mech_power_kilojoules = options.get_or<std::int64_t>(
                                                "mech_power_kilojoules", 2 );
        definition->swim_speed_modifier = options.get_or<std::int64_t>(
                                              "swim_speed_modifier", 0 );
        definition->stop_hauling = options.get_or( "stop_hauling", false );
        const auto read_symbol = [&options]( const char *name ) {
            const std::string symbol = options.get_or( name, std::string() );
            const utf8_wrapper wrapped( symbol );
            if( wrapped.size() != 1 ) {
                throw std::runtime_error( std::string( "movement-mode " ) + name +
                                          " must be one Unicode codepoint" );
            }
            return wrapped.at( 0 );
        };
        definition->character_symbol = read_symbol( "character_symbol" );
        definition->panel_symbol = read_symbol( "panel_symbol" );
        return movement_mode_definition_handle{
            std::move( definition ), pimpl_->token
        };
    } );

    const auto edit_catalog = [this]( const std::string & id, auto & registrations,
    const char *kind ) {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
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
#define CATA_CHARACTER_EDIT( lua_name, handle_type, member, kind ) \
    content.set_function( lua_name, [this, edit_catalog]( const std::string &id ) { \
        return handle_type{ edit_catalog( id, pimpl_->member, kind ), pimpl_->token }; \
    } )
    CATA_CHARACTER_EDIT( "edit_profession", profession_definition_handle, professions, "profession" );
    CATA_CHARACTER_EDIT( "edit_profession_group", profession_group_definition_handle,
                         profession_groups, "profession_group" );
    CATA_CHARACTER_EDIT( "edit_widget", widget_definition_handle, widgets, "widget" );
    CATA_CHARACTER_EDIT( "edit_enchantment", enchantment_definition_handle, enchantments,
                         "enchantment" );
    CATA_CHARACTER_EDIT( "edit_bionic", bionic_definition_handle, bionics, "bionic" );
    CATA_CHARACTER_EDIT( "edit_spell", spell_definition_handle, spells, "spell" );
    CATA_CHARACTER_EDIT( "edit_mission", mission_definition_handle,
                         mission_definitions, "mission_definition" );
    CATA_CHARACTER_EDIT( "edit_profession_item_substitution",
                         profession_item_substitution_definition_handle,
                         profession_item_substitutions, "profession_item_substitution" );
    CATA_CHARACTER_EDIT( "edit_profession_item_bonus",
                         profession_item_bonus_definition_handle,
                         profession_item_bonuses, "profession_item_bonus" );
    CATA_CHARACTER_EDIT( "edit_technique", technique_definition_handle, techniques, "technique" );
    CATA_CHARACTER_EDIT( "edit_martial_art", martial_art_definition_handle, martial_arts,
                         "martial_art" );
    CATA_CHARACTER_EDIT( "edit_magic_type", magic_type_definition_handle, magic_types, "magic_type" );
    CATA_CHARACTER_EDIT( "edit_movement_mode", movement_mode_definition_handle,
                         movement_modes, "movement_mode" );
#undef CATA_CHARACTER_EDIT

    static_cast<void>( lua );
}

bool character_content_transaction::validate( const runtime &owner_runtime,
        const bool check_engine_state, const character_content_validation_index &index,
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
        std::set<std::string> profession_ids;

        const auto index_defines = []( const std::function<bool( std::string_view )> &predicate,
        const std::string & id ) {
            return predicate && predicate( id );
        };
        const auto staged_item_group = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_item_group, id );
        };
        const auto staged_proficiency = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_proficiency, id );
        };
        const auto staged_addiction = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_addiction, id );
        };
        const auto staged_achievement = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_achievement, id );
        };
        const auto staged_monster = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_monster, id );
        };
        const auto staged_martial_art = [this]( const std::string & id ) {
            return registration_id_exists( pimpl_->martial_arts, id );
        };
        const auto staged_trait_group = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_trait_group, id );
        };
        const auto staged_body_part = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_body_part, id );
        };
        const auto staged_body_graph = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_body_graph, id );
        };
        const auto staged_emission = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_emission, id );
        };
        const auto staged_effect = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_effect_type, id );
        };
        const auto staged_limb_score = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_limb_score, id );
        };
        const auto staged_material = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_material, id );
        };
        const auto staged_requirement = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_requirement, id );
        };
        const auto staged_bionic = [this]( const std::string & id ) {
            return registration_id_exists( pimpl_->bionics, id );
        };
        const auto staged_spell = [this]( const std::string & id ) {
            return registration_id_exists( pimpl_->spells, id );
        };
        const auto staged_magic_type = [this]( const std::string & id ) {
            return registration_id_exists( pimpl_->magic_types, id );
        };
        const auto staged_explosion_light = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_explosion_light, id );
        };
        const auto staged_field = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_field_type, id );
        };
        const auto staged_species = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_species, id );
        };
        const auto staged_monster_for_spell = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_monster, id );
        };
        const auto staged_spell_id = [this]( const std::string & id ) {
            return registration_id_exists( pimpl_->spells, id );
        };
        const auto staged_item_group_for_mission = [&index_defines, &index](
        const std::string & id ) {
            return index_defines( index.defines_item_group, id );
        };

        for( const profession_registration &entry : pimpl_->professions ) {
            if( !profession_ids.insert( entry.definition->id ).second ) {
                throw std::runtime_error( "profession '" + entry.definition->id +
                                          "' is registered more than once per transaction" );
            }
        }
        for( const profession_registration &entry : pimpl_->professions ) {
            const profession_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "profession" );
            if( !definition.start_handler.empty() &&
                owner_runtime.handlers.count( definition.start_handler ) == 0 ) {
                throw std::runtime_error(
                    "profession '" + definition.id +
                    "' references missing start handler '" +
                    definition.start_handler + "'" );
            }
            if( definition.name_male.empty() || definition.name_female.empty() ||
                definition.description_male.empty() || definition.description_female.empty() ) {
                throw std::runtime_error( "profession '" + definition.id +
                                          "' requires gendered names, descriptions, and one registration" );
            }
            if( !fits_native_int( definition.points ) ||
                ( definition.starting_cash && !fits_native_int( *definition.starting_cash ) ) ||
                !fits_native_int( definition.age_lower ) ||
                !fits_native_int( definition.age_upper ) ||
                definition.age_lower < 0 || definition.age_upper < definition.age_lower ||
                !fits_native_int( definition.martial_arts_choice_amount ) ||
                definition.martial_arts_choice_amount < 0 ) {
                throw std::runtime_error( "profession '" + definition.id +
                                          "' has values outside the native range" );
            }
            if( definition.hard_requirement && definition.requirements.empty() ) {
                throw std::runtime_error( "profession '" + definition.id +
                                          "' cannot have a hard requirement without achievements" );
            }
            for( const std::string *group : {
                     &definition.items_both, &definition.items_male, &definition.items_female
                 } ) {
                require_valid_id( *group, "profession item group" );
                if( check_engine_state && !staged_item_group( *group ) &&
                    !item_group::group_is_defined( item_group_id( *group ) ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' references unknown item group '" + *group + "'" );
                }
            }
            if( check_engine_state && !definition.no_bonus.empty() &&
                !index_defines( index.defines_item,  definition.no_bonus ) &&
                !item::type_is_defined( itype_id( definition.no_bonus ) ) ) {
                throw std::runtime_error( "profession '" + definition.id +
                                          "' references unknown no-bonus item '" +
                                          definition.no_bonus + "'" );
            }
            if( check_engine_state && !definition.starting_vehicle.empty() &&
                !vproto_id( definition.starting_vehicle ).is_valid() ) {
                throw std::runtime_error( "profession '" + definition.id +
                                          "' references unknown vehicle '" +
                                          definition.starting_vehicle + "'" );
            }
            if( check_engine_state && !staged_trait_group( definition.npc_background ) &&
                mutation_branch::get_group(
                    trait_group::Trait_group_tag( definition.npc_background ) ) == nullptr ) {
                throw std::runtime_error( "profession '" + definition.id +
                                          "' references unknown NPC background '" +
                                          definition.npc_background + "'" );
            }

            std::set<std::string> unique;
            for( const std::string &achievement : definition.requirements ) {
                require_valid_id( achievement, "profession achievement" );
                if( !unique.insert( achievement ).second ||
                    ( check_engine_state && !staged_achievement( achievement ) &&
                      !achievement_id( achievement ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown or duplicate achievement '" +
                                              achievement + "'" );
                }
            }
            unique.clear();
            for( const auto &[skill, level] : definition.skills ) {
                require_valid_id( skill, "profession skill" );
                if( !fits_native_int( level ) || level < 0 ||
                    !unique.insert( skill ).second ||
                    ( check_engine_state && !index_defines( index.defines_skill,  skill ) &&
                      !skill_id( skill ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown, duplicate, or invalid skill '" +
                                              skill + "'" );
                }
            }
            unique.clear();
            for( const profession_addiction_definition_data &value : definition.addictions ) {
                require_valid_id( value.type, "profession addiction" );
                if( !fits_native_int( value.intensity ) || value.intensity <= 0 ||
                    !unique.insert( value.type ).second ||
                    ( check_engine_state && !staged_addiction( value.type ) &&
                      !addiction_id( value.type ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown, duplicate, or invalid addiction '" +
                                              value.type + "'" );
                }
            }
            unique.clear();
            for( const std::string &bionic : definition.cbms ) {
                require_valid_id( bionic, "profession CBM" );
                if( !unique.insert( bionic ).second ||
                    ( check_engine_state && !bionic_id( bionic ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown or duplicate CBM '" + bionic + "'" );
                }
            }
            unique.clear();
            for( const std::string &proficiency : definition.proficiencies ) {
                require_valid_id( proficiency, "profession proficiency" );
                if( !unique.insert( proficiency ).second ||
                    ( check_engine_state && !staged_proficiency( proficiency ) &&
                      !proficiency_id( proficiency ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown or duplicate proficiency '" +
                                              proficiency + "'" );
                }
            }
            unique.clear();
            for( const std::string &recipe : definition.recipes ) {
                require_valid_id( recipe, "profession recipe" );
                if( !unique.insert( recipe ).second ||
                    ( check_engine_state && !index_defines( index.defines_recipe,  recipe ) &&
                      !recipe_id( recipe ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown or duplicate recipe '" + recipe + "'" );
                }
            }

            unique.clear();
            for( const profession_trait_definition_data &value : definition.traits ) {
                require_valid_id( value.trait, "profession trait" );
                const trait_id trait( value.trait );
                if( !unique.insert( value.trait ).second ||
                    ( check_engine_state && !trait.is_valid() ) ||
                    ( check_engine_state && !value.variant.empty() && trait.is_valid() &&
                      trait->variant( value.variant ) == nullptr ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown, duplicate, or invalid trait '" +
                                              value.trait + "'" );
                }
            }
            for( const std::string &trait : definition.forbidden_traits ) {
                require_valid_id( trait, "profession forbidden trait" );
                if( !unique.insert( trait ).second ||
                    ( check_engine_state && !trait_id( trait ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown, duplicate, or contradictory trait '" +
                                              trait + "'" );
                }
            }
            unique.clear();
            for( const std::string &flag : definition.flags ) {
                if( flag.empty() || !unique.insert( flag ).second ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an empty or duplicate flag" );
                }
            }
            unique.clear();
            for( const std::string &hobby : definition.hobbies ) {
                require_valid_id( hobby, "profession hobby" );
                if( !unique.insert( hobby ).second ||
                    ( check_engine_state && profession_ids.count( hobby ) == 0 &&
                      !profession_id( hobby ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown or duplicate hobby '" + hobby + "'" );
                }
            }
            unique.clear();
            for( const std::string &style : definition.martial_arts ) {
                require_valid_id( style, "profession martial art" );
                if( !unique.insert( style ).second ||
                    ( check_engine_state && !staged_martial_art( style ) &&
                      !matype_id( style ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown or duplicate martial art '" + style + "'" );
                }
            }
            for( const std::string &style : definition.martial_arts_choices ) {
                require_valid_id( style, "profession martial-art choice" );
                if( !unique.insert( style ).second ||
                    ( check_engine_state && !staged_martial_art( style ) &&
                      !matype_id( style ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown, duplicate, or contradictory martial-art choice '" +
                                              style + "'" );
                }
            }
            if( !definition.martial_arts_choices.empty() &&
                definition.martial_arts_choice_amount >
                static_cast<std::int64_t>( definition.martial_arts_choices.size() ) ) {
                throw std::runtime_error( "profession '" + definition.id +
                                          "' requests more martial arts than it offers" );
            }
            unique.clear();
            std::int64_t total_pets = 0;
            for( const auto &[monster, amount] : definition.pets ) {
                require_valid_id( monster, "profession pet" );
                if( !fits_native_int( amount ) || amount <= 0 || amount > 4096 ||
                    total_pets > 4096 - amount || !unique.insert( monster ).second ||
                    ( check_engine_state && !staged_monster( monster ) &&
                      !mtype_id( monster ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown, duplicate, or invalid pet '" + monster + "'" );
                }
                total_pets += amount;
            }
            unique.clear();
            for( const auto &[spell, level] : definition.spells ) {
                require_valid_id( spell, "profession spell" );
                if( !fits_native_int( level ) || level < 0 ||
                    !unique.insert( spell ).second ||
                    ( check_engine_state && !spell_id( spell ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown, duplicate, or invalid spell '" + spell + "'" );
                }
            }
            unique.clear();
            for( const std::string &mission : definition.missions ) {
                require_valid_id( mission, "profession mission" );
                if( !unique.insert( mission ).second ||
                    ( check_engine_state && !mission_type_id( mission ).is_valid() ) ) {
                    throw std::runtime_error( "profession '" + definition.id +
                                              "' has an unknown or duplicate mission '" + mission + "'" );
                }
            }
            validate_operation( entry.operation, profession_id( definition.id ).is_valid(),
                                definition.id, "profession" );
        }

        std::set<std::string> profession_group_ids;
        for( const profession_group_registration &entry : pimpl_->profession_groups ) {
            const profession_group_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "profession group" );
            if( !profession_group_ids.insert( definition.id ).second ||
                definition.professions.empty() ) {
                throw std::runtime_error( "profession group '" + definition.id +
                                          "' needs a unique id and at least one profession" );
            }
            std::set<std::string> professions;
            for( const std::string &profession : definition.professions ) {
                if( !professions.insert( profession ).second ||
                    ( check_engine_state && profession_ids.count( profession ) == 0 &&
                      !profession_id( profession ).is_valid() ) ) {
                    throw std::runtime_error( "profession group '" + definition.id +
                                              "' has an unknown or duplicate profession '" +
                                              profession + "'" );
                }
            }
            validate_operation( entry.operation,
                                profession_group_id( definition.id ).is_valid(),
                                definition.id, "profession group" );
        }

        std::set<std::string> widget_ids;
        for( const widget_registration &entry : pimpl_->widgets ) {
            if( !widget_ids.insert( entry.definition->id ).second ) {
                throw std::runtime_error( "widget '" + entry.definition->id +
                                          "' is registered more than once per transaction" );
            }
        }
        const auto validate_widget_reference = [check_engine_state, &widget_ids](
        const std::string & owner, const std::string & child ) {
            if( child.empty() ||
                ( check_engine_state && widget_ids.count( child ) == 0 &&
                  !widget_id( child ).is_valid() ) ) {
                throw std::runtime_error( "widget '" + owner +
                                          "' references unknown child widget '" + child + "'" );
            }
        };
        const auto validate_widget_clause = [&owner_runtime, &validate_widget_reference](
                                                const std::string & owner,
        const widget_clause_definition_data & clause ) {
            if( !fits_native_int( clause.value ) ) {
                throw std::runtime_error( "widget '" + owner +
                                          "' has a clause value outside the native range" );
            }
            if( !clause.color.empty() &&
                color_from_string( clause.color, report_color_error::no ) == c_unset ) {
                throw std::runtime_error( "widget '" + owner +
                                          "' has an unknown clause color '" + clause.color + "'" );
            }
            if( !clause.condition_handler.empty() &&
                owner_runtime.handlers.count( clause.condition_handler ) == 0 ) {
                throw std::runtime_error( "widget '" + owner +
                                          "' references missing condition handler '" +
                                          clause.condition_handler + "'" );
            }
            for( const std::string &child : clause.widgets ) {
                validate_widget_reference( owner, child );
            }
        };
        for( const widget_registration &entry : pimpl_->widgets ) {
            const widget_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "widget" );

            if( !fits_native_int( definition.width ) || definition.width < 0 ||
                !fits_native_int( definition.height ) || definition.height < 0 ||
                ( definition.padding &&
                  ( !fits_native_int( *definition.padding ) || *definition.padding < 0 ) ) ) {
                throw std::runtime_error( "widget '" + definition.id +
                                          "' has dimensions outside the native range" );
            }
            static const std::set<std::string> styles = {
                "number", "graph", "text", "symbol", "legend", "widget",
                "layout", "sidebar", "clause"
            };
            static const std::set<std::string> arrangements = {
                "columns", "minimum_columns", "rows"
            };
            if( styles.count( definition.style ) == 0 ||
                arrangements.count( definition.arrange ) == 0 ||
                ( definition.fill != "bucket" && definition.fill != "pool" ) ) {
                throw std::runtime_error( "widget '" + definition.id +
                                          "' has an unknown style, arrangement, or fill mode" );
            }
            if( definition.style == "sidebar" &&
                ( !definition.separator || !definition.padding ) ) {
                throw std::runtime_error( "sidebar widget '" + definition.id +
                                          "' requires an explicit separator and padding" );
            }
            if( !definition.variable.empty() &&
                !io::string_to_enum_optional<widget_var>( definition.variable ) ) {
                throw std::runtime_error( "widget '" + definition.id +
                                          "' has unknown variable '" + definition.variable + "'" );
            }
            if( definition.variable == "custom" ) {
                if( definition.custom_handler.empty() ||
                    owner_runtime.handlers.count( definition.custom_handler ) == 0 ) {
                    throw std::runtime_error( "custom widget '" + definition.id +
                                              "' requires a registered Lua value handler" );
                }
            } else if( !definition.custom_handler.empty() ) {
                throw std::runtime_error( "widget '" + definition.id +
                                          "' has a custom handler but is not a custom variable" );
            }
            if( !definition.direction.empty() &&
                !io::string_to_enum_optional<cardinal_direction>( definition.direction ) ) {
                throw std::runtime_error( "widget '" + definition.id +
                                          "' has unknown direction '" + definition.direction + "'" );
            }
            if( !io::string_to_enum_optional<widget_alignment>( definition.text_align ) ||
                !io::string_to_enum_optional<widget_alignment>( definition.label_align ) ) {
                throw std::runtime_error( "widget '" + definition.id +
                                          "' has an unknown alignment" );
            }
            std::set<std::string> unique;
            for( const std::string &bodypart : definition.bodyparts ) {
                require_valid_id( bodypart, "widget body part" );
                if( !unique.insert( bodypart ).second ||
                    ( check_engine_state && !staged_body_part( bodypart ) &&
                      !bodypart_str_id( bodypart ).is_valid() ) ) {
                    throw std::runtime_error( "widget '" + definition.id +
                                              "' has an unknown or duplicate body part '" + bodypart + "'" );
                }
            }
            if( check_engine_state && !definition.body_graph.empty() &&
                !staged_body_graph( definition.body_graph ) &&
                !bodygraph_id( definition.body_graph ).is_valid() ) {
                throw std::runtime_error( "widget '" + definition.id +
                                          "' references unknown body graph '" +
                                          definition.body_graph + "'" );
            }
            for( const std::string &color : definition.colors ) {
                if( color.empty() ||
                    color_from_string( color, report_color_error::no ) == c_unset ) {
                    throw std::runtime_error( "widget '" + definition.id +
                                              "' has unknown color '" + color + "'" );
                }
            }
            if( !definition.breaks.empty() &&
                ( definition.colors.empty() ||
                  definition.breaks.size() + 1 != definition.colors.size() ) ) {
                throw std::runtime_error( "widget '" + definition.id +
                                          "' requires one fewer break than colors" );
            }
            std::int64_t previous_break = std::numeric_limits<std::int64_t>::min();
            for( const std::int64_t value : definition.breaks ) {
                if( !fits_native_int( value ) || value <= previous_break ) {
                    throw std::runtime_error( "widget '" + definition.id +
                                              "' requires increasing native-integer breaks" );
                }
                previous_break = value;
            }
            unique.clear();
            for( const std::string &flag : definition.flags ) {
                require_valid_id( flag, "widget flag" );
                if( !unique.insert( flag ).second ||
                    ( check_engine_state && !index_defines( index.defines_json_flag,  flag ) &&
                      !flag_id( flag ).is_valid() ) ) {
                    throw std::runtime_error( "widget '" + definition.id +
                                              "' has an unknown or duplicate flag '" + flag + "'" );
                }
            }
            for( const std::string &child : definition.widgets ) {
                validate_widget_reference( definition.id, child );
            }
            for( const widget_clause_definition_data &clause : definition.clauses ) {
                validate_widget_clause( definition.id, clause );
            }
            if( definition.default_clause ) {
                validate_widget_clause( definition.id, *definition.default_clause );
            }
            validate_operation( entry.operation, widget_id( definition.id ).is_valid(),
                                definition.id, "widget" );
        }
        if( check_engine_state && !pimpl_->widgets.empty() ) {
            std::map<std::string, std::vector<std::string>> graph;
            for( const widget &value : widget::get_all() ) {
                std::vector<std::string> &children = graph[value.getId().str()];
                for( const widget_id &child : value._widgets ) {
                    children.push_back( child.str() );
                }
                for( const widget_clause &clause : value._clauses ) {
                    for( const widget_id &child : clause.widgets ) {
                        children.push_back( child.str() );
                    }
                }
                for( const widget_id &child : value._default_clause.widgets ) {
                    children.push_back( child.str() );
                }
            }
            for( const widget_registration &entry : pimpl_->widgets ) {
                const widget_definition_data &definition = *entry.definition;
                std::vector<std::string> &children = graph[definition.id];
                children = definition.widgets;
                for( const widget_clause_definition_data &clause : definition.clauses ) {
                    children.insert( children.end(), clause.widgets.begin(), clause.widgets.end() );
                }
                if( definition.default_clause ) {
                    children.insert( children.end(), definition.default_clause->widgets.begin(),
                                     definition.default_clause->widgets.end() );
                }
            }
            std::map<std::string, int> state;
            std::function<void( const std::string & )> visit = [&]( const std::string & id ) {
                if( state[id] == 2 ) {
                    return;
                }
                if( state[id] == 1 ) {
                    throw std::runtime_error( "widget layout graph contains a cycle at '" + id + "'" );
                }
                state[id] = 1;
                const auto found = graph.find( id );
                if( found != graph.end() ) {
                    for( const std::string &child : found->second ) {
                        visit( child );
                    }
                }
                state[id] = 2;
            };
            for( const widget_registration &entry : pimpl_->widgets ) {
                visit( entry.definition->id );
            }
        }

        std::set<std::string> enchantment_ids;
        for( const enchantment_registration &entry : pimpl_->enchantments ) {
            if( !enchantment_ids.insert( entry.definition->id ).second ) {
                throw std::runtime_error( "enchantment '" + entry.definition->id +
                                          "' is registered more than once per transaction" );
            }
        }
        const auto validate_enchantment_handler = [&owner_runtime](
        const std::string & owner, const std::string & handler ) {
            if( !handler.empty() && owner_runtime.handlers.count( handler ) == 0 ) {
                throw std::runtime_error( "enchantment '" + owner +
                                          "' references missing Lua handler '" + handler + "'" );
            }
        };
        const auto validate_fake_spell = [check_engine_state](
        const std::string & owner, const enchantment_fake_spell_definition_data & spell ) {
            if( spell.spell.empty() || !fits_native_int( spell.level ) || spell.level < 0 ||
                !fits_native_int( spell.trigger_once_in ) || spell.trigger_once_in <= 0 ||
                ( spell.max_level &&
                  ( !fits_native_int( *spell.max_level ) || *spell.max_level < spell.level ) ) ||
                ( check_engine_state && !spell_id( spell.spell ).is_valid() ) ) {
                throw std::runtime_error( "enchantment '" + owner +
                                          "' has an unknown or invalid fake spell '" +
                                          spell.spell + "'" );
            }
        };
        for( const enchantment_registration &entry : pimpl_->enchantments ) {
            const enchantment_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "enchantment" );
            if( !io::string_to_enum_optional<enchantment::has>( definition.has ) ||
                !io::string_to_enum_optional<enchantment::condition>( definition.condition ) ) {
                throw std::runtime_error( "enchantment '" + definition.id +
                                          "' has an unknown location or activation condition" );
            }
            if( definition.condition == "DIALOG_CONDITION" ) {
                if( definition.condition_handler.empty() ) {
                    throw std::runtime_error( "conditional enchantment '" + definition.id +
                                              "' requires a Lua condition handler" );
                }
                validate_enchantment_handler( definition.id, definition.condition_handler );
            } else if( !definition.condition_handler.empty() ) {
                throw std::runtime_error( "enchantment '" + definition.id +
                                          "' has a Lua condition handler but no dynamic condition" );
            }
            if( check_engine_state && !definition.emitter.empty() &&
                !staged_emission( definition.emitter ) &&
                !emit_id( definition.emitter ).is_valid() ) {
                throw std::runtime_error( "enchantment '" + definition.id +
                                          "' references unknown emitter '" + definition.emitter + "'" );
            }
            std::set<std::string> unique;
            for( const auto &[effect, intensity] : definition.effects ) {
                require_valid_id( effect, "enchantment effect" );
                if( !fits_native_int( intensity ) || intensity <= 0 ||
                    !unique.insert( effect ).second ||
                    ( check_engine_state && !staged_effect( effect ) &&
                      !efftype_id( effect ).is_valid() ) ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' has an unknown, duplicate, or invalid effect '" + effect + "'" );
                }
            }
            unique.clear();
            for( const auto &[gain, lose] : definition.modified_bodyparts ) {
                if( gain.empty() && lose.empty() ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' has an empty body-part change" );
                }
                for( const std::string *part : {
                         &gain, &lose
                     } ) {
                    if( part->empty() ) {
                        continue;
                    }
                    require_valid_id( *part, "enchantment body part" );
                    if( check_engine_state && !staged_body_part( *part ) &&
                        !bodypart_str_id( *part ).is_valid() ) {
                        throw std::runtime_error( "enchantment '" + definition.id +
                                                  "' references unknown body part '" + *part + "'" );
                    }
                }
            }
            for( const std::string &mutation : definition.mutations ) {
                require_valid_id( mutation, "enchantment mutation" );
                if( !unique.insert( mutation ).second ||
                    ( check_engine_state && !trait_id( mutation ).is_valid() ) ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' has an unknown or duplicate mutation '" + mutation + "'" );
                }
            }
            unique.clear();
            static const std::set<std::string> modifier_kinds = {
                "value", "skill", "custom", "encumbrance", "max_hp",
                "limb_score", "melee_damage", "incoming_damage", "post_armor_damage"
            };
            for( const enchantment_modifier_definition_data &modifier : definition.modifiers ) {
                if( modifier_kinds.count( modifier.kind ) == 0 || modifier.target.empty() ||
                    ( !modifier.add && !modifier.multiply && modifier.add_handler.empty() &&
                      modifier.multiply_handler.empty() ) ||
                    ( modifier.add && !std::isfinite( *modifier.add ) ) ||
                    ( modifier.multiply && !std::isfinite( *modifier.multiply ) ) ||
                    !unique.insert( modifier.kind + "\n" + modifier.target + "\n" +
                                    modifier.part ).second ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' has an invalid or duplicate modifier" );
                }
                validate_enchantment_handler( definition.id, modifier.add_handler );
                validate_enchantment_handler( definition.id, modifier.multiply_handler );
                if( modifier.kind == "value" &&
                    !io::string_to_enum_optional<enchant_vals::mod>( modifier.target ) ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' has unknown engine value '" + modifier.target + "'" );
                }
                if( modifier.kind == "skill" && check_engine_state &&
                    !index_defines( index.defines_skill,  modifier.target ) &&
                    !skill_id( modifier.target ).is_valid() ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' references unknown skill '" + modifier.target + "'" );
                }
                if( ( modifier.kind == "encumbrance" || modifier.kind == "max_hp" ) &&
                    modifier.target != "all" && check_engine_state &&
                    !staged_body_part( modifier.target ) &&
                    !bodypart_str_id( modifier.target ).is_valid() ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' references unknown body part '" + modifier.target + "'" );
                }
                if( modifier.kind == "limb_score" ) {
                    if( check_engine_state && !staged_limb_score( modifier.target ) &&
                        !limb_score_id( modifier.target ).is_valid() ) {
                        throw std::runtime_error( "enchantment '" + definition.id +
                                                  "' references unknown limb score '" + modifier.target + "'" );
                    }
                    if( !modifier.part.empty() && check_engine_state &&
                        !staged_body_part( modifier.part ) &&
                        !bodypart_str_id( modifier.part ).is_valid() ) {
                        throw std::runtime_error( "enchantment '" + definition.id +
                                                  "' references unknown limb-score body part '" +
                                                  modifier.part + "'" );
                    }
                }
                if( ( modifier.kind == "melee_damage" ||
                      modifier.kind == "incoming_damage" ||
                      modifier.kind == "post_armor_damage" ) && check_engine_state &&
                    !index_defines( index.defines_damage_type,  modifier.target ) &&
                    !damage_type_id( modifier.target ).is_valid() ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' references unknown damage type '" + modifier.target + "'" );
                }
            }
            for( const enchantment_fake_spell_definition_data &spell :
                 definition.hit_you_effects ) {
                validate_fake_spell( definition.id, spell );
            }
            for( const enchantment_fake_spell_definition_data &spell :
                 definition.hit_me_effects ) {
                validate_fake_spell( definition.id, spell );
            }
            for( const auto &[turns, spell] : definition.intermittent_effects ) {
                if( turns <= 0 ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' has a non-positive intermittent frequency" );
                }
                validate_fake_spell( definition.id, spell );
            }
            for( const enchantment_vision_definition_data &vision : definition.visions ) {
                if( !std::isfinite( vision.distance ) || vision.distance < 0.0 ||
                    ( vision.descriptions.empty() && vision.condition_handler.empty() ) ) {
                    throw std::runtime_error( "enchantment '" + definition.id +
                                              "' has invalid special vision" );
                }
                validate_enchantment_handler( definition.id, vision.distance_handler );
                validate_enchantment_handler( definition.id, vision.condition_handler );
                std::set<std::string> description_ids;
                for( const enchantment_vision_description_definition_data &description :
                     vision.descriptions ) {
                    if( description.id.empty() || description.text.empty() ||
                        !description_ids.insert( description.id ).second ||
                        color_from_string( description.color,
                                           report_color_error::no ) == c_unset ) {
                        throw std::runtime_error( "enchantment '" + definition.id +
                                                  "' has an invalid vision description" );
                    }
                    validate_enchantment_handler(

                        definition.id, description.condition_handler );
                }
            }
            validate_operation( entry.operation,
                                enchantment_id( definition.id ).is_valid(),
                                definition.id, "enchantment" );
        }

        std::set<std::string> bionic_ids;
        for( const bionic_registration &entry : pimpl_->bionics ) {
            if( !bionic_ids.insert( entry.definition->id ).second ) {
                throw std::runtime_error( "bionic '" + entry.definition->id +
                                          "' is registered more than once per transaction" );
            }
        }
        const auto require_bionic_reference = [&]( const std::string & owner,
        const std::string & id, const char *kind, const auto & exists ) {
            require_valid_id( id, kind );
            if( check_engine_state && !exists( id ) ) {
                throw std::runtime_error( "bionic '" + owner + "' references unknown " +
                                          kind + " '" + id + "'" );
            }
        };
        const auto validate_bionic_list = [&]( const std::string & owner,
        const std::vector<std::string> &values, const char *kind, const auto & exists ) {
            std::set<std::string> unique;
            for( const std::string &value : values ) {
                if( !unique.insert( value ).second ) {
                    throw std::runtime_error( "bionic '" + owner + "' has duplicate " +
                                              kind + " '" + value + "'" );
                }
                require_bionic_reference( owner, value, kind, exists );
            }
        };
        const auto item_exists = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_item, id ) || item::type_is_defined( itype_id( id ) );
        };
        const auto material_exists = [&staged_material]( const std::string & id ) {
            return staged_material( id ) || material_id( id ).is_valid();
        };
        const auto enchantment_exists = [&enchantment_ids]( const std::string & id ) {
            return enchantment_ids.count( id ) != 0 || enchantment_id( id ).is_valid();
        };
        const auto martial_art_exists = [&staged_martial_art]( const std::string & id ) {
            return staged_martial_art( id ) || matype_id( id ).is_valid();
        };
        const auto proficiency_exists = [&staged_proficiency]( const std::string & id ) {
            return staged_proficiency( id ) || proficiency_id( id ).is_valid();
        };
        const auto trait_exists = []( const std::string & id ) {
            return trait_id( id ).is_valid();
        };
        const auto body_part_exists = [&staged_body_part]( const std::string & id ) {
            return staged_body_part( id ) || bodypart_str_id( id ).is_valid();
        };
        const auto character_flag_exists = [&index_defines, &index]( const std::string & id ) {
            return index_defines( index.defines_json_flag, id ) ||
                   json_character_flag( id ).is_valid();
        };
        const auto bionic_exists = [&staged_bionic]( const std::string & id ) {
            return staged_bionic( id ) || bionic_id( id ).is_valid();
        };
        for( const bionic_registration &entry : pimpl_->bionics ) {
            const bionic_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "bionic" );
            if( definition.name.empty() || definition.description.empty() ) {
                throw std::runtime_error( "bionic '" + definition.id +
                                          "' requires a name and description" );
            }
            if( definition.activation_energy_millijoules < 0 ||
                definition.deactivation_energy_millijoules < 0 ||
                definition.over_time_energy_millijoules < 0 ||
                definition.trigger_energy_millijoules < 0 ||
                definition.capacity_energy_millijoules < 0 ||
                definition.charge_time_turns < 0 ||
                !fits_native_int( definition.charge_time_turns ) ) {
                throw std::runtime_error( "bionic '" + definition.id +
                                          "' has negative energy or an invalid charge time" );
            }
            const auto native_nonnegative_float = []( const double value ) {
                return std::isfinite( value ) && value >= 0.0 &&
                       value <= std::numeric_limits<float>::max();
            };
            if( !native_nonnegative_float( definition.fuel_efficiency ) ||
                !native_nonnegative_float( definition.passive_fuel_efficiency ) ||
                ( definition.coverage_power_gen_penalty &&
                  !native_nonnegative_float( *definition.coverage_power_gen_penalty ) ) ) {
                throw std::runtime_error( "bionic '" + definition.id +
                                          "' has an invalid fuel efficiency" );
            }
            if( !fits_native_int( definition.social_lie ) ||
                !fits_native_int( definition.social_persuade ) ||
                !fits_native_int( definition.social_intimidate ) ) {
                throw std::runtime_error( "bionic '" + definition.id +
                                          "' has social modifiers outside the native range" );
            }
            if( definition.activation_spell ) {
                const enchantment_fake_spell_definition_data &spell =
                    *definition.activation_spell;
                require_valid_id( spell.spell, "bionic activation spell" );
                if( !fits_native_int( spell.level ) || spell.level < 0 ||
                    !fits_native_int( spell.trigger_once_in ) || spell.trigger_once_in <= 0 ||
                    ( spell.max_level &&
                      ( !fits_native_int( *spell.max_level ) || *spell.max_level < spell.level ) ) ||
                    ( check_engine_state && !staged_spell( spell.spell ) &&
                      !spell_id( spell.spell ).is_valid() ) ) {
                    throw std::runtime_error( "bionic '" + definition.id +
                                              "' has an unknown or invalid activation spell '" +
                                              spell.spell + "'" );
                }
            }
            if( !definition.power_gen_emission.empty() ) {
                require_bionic_reference( definition.id, definition.power_gen_emission,
                "emission", [&staged_emission]( const std::string & id ) {
                    return staged_emission( id ) || emit_id( id ).is_valid();
                } );
            }
            if( !definition.fake_weapon.empty() ) {
                require_bionic_reference( definition.id, definition.fake_weapon,
                                          "fake weapon", item_exists );
            }
            const auto validate_optional_bionic = [&]( const std::string & id,
            const char *kind ) {
                if( id.empty() ) {
                    return;
                }
                require_bionic_reference( definition.id, id, kind, bionic_exists );
                if( id == definition.id ) {
                    throw std::runtime_error( "bionic '" + definition.id + "' cannot reference " +
                                              "itself as its " + kind );
                }
            };
            validate_optional_bionic( definition.upgraded_bionic, "upgraded bionic" );
            validate_optional_bionic( definition.required_bionic, "required bionic" );
            if( !definition.installation_requirement.empty() ) {
                require_bionic_reference(
                    definition.id, definition.installation_requirement,
                "installation requirement", [&staged_requirement]( const std::string & id ) {
                    return staged_requirement( id ) || requirement_id( id ).is_valid();
                } );
            }
            validate_bionic_list( definition.id, definition.fuel_options,
                                  "fuel material", material_exists );
            validate_bionic_list( definition.id, definition.enchantments,
                                  "enchantment", enchantment_exists );
            validate_bionic_list( definition.id, definition.martial_arts,
                                  "martial art", martial_art_exists );
            validate_bionic_list( definition.id, definition.proficiencies,
                                  "proficiency", proficiency_exists );
            validate_bionic_list( definition.id, definition.passive_pseudo_items,
                                  "passive pseudo-item", item_exists );
            validate_bionic_list( definition.id, definition.toggled_pseudo_items,
                                  "toggled pseudo-item", item_exists );
            validate_bionic_list( definition.id, definition.canceled_mutations,
                                  "canceled mutation", trait_exists );
            validate_bionic_list( definition.id, definition.included_bionics,
                                  "included bionic", bionic_exists );
            validate_bionic_list( definition.id, definition.auto_deactivated_bionics,
                                  "auto-deactivated bionic", bionic_exists );
            validate_bionic_list( definition.id, definition.flags,

                                  "flag", character_flag_exists );
            validate_bionic_list( definition.id, definition.active_flags,
                                  "active flag", character_flag_exists );
            validate_bionic_list( definition.id, definition.inactive_flags,
                                  "inactive flag", character_flag_exists );
            validate_bionic_list( definition.id, definition.installable_weapon_flags,
                                  "installable weapon flag", character_flag_exists );
            validate_bionic_list( definition.id, definition.replaced_bodyparts,
                                  "replaced body part", body_part_exists );
            validate_bionic_list( definition.id, definition.mutation_conflicts,
                                  "mutation conflict", trait_exists );
            validate_bionic_list( definition.id, definition.give_mutation_on_removal,
                                  "removal mutation", trait_exists );
            validate_bionic_list( definition.id, definition.available_upgrades,
                                  "available upgrade", bionic_exists );

            for( const std::vector<std::string> *references : {
                     &definition.included_bionics, &definition.auto_deactivated_bionics,
                     &definition.available_upgrades
                 } ) {
                if( std::find( references->begin(), references->end(), definition.id ) !=
                    references->end() ) {
                    throw std::runtime_error( "bionic '" + definition.id +
                                              "' cannot reference itself" );
                }
            }
            std::set<std::string> keyed_bodyparts;
            for( const auto &[bodypart, amount] : definition.environment_protection ) {
                require_bionic_reference( definition.id, bodypart,
                                          "environmental-protection body part", body_part_exists );
                if( amount < 0 ||
                    static_cast<std::uint64_t>( amount ) >
                    std::numeric_limits<std::size_t>::max() ||
                    !keyed_bodyparts.insert( bodypart ).second ) {
                    throw std::runtime_error( "bionic '" + definition.id +
                                              "' has invalid or duplicate environmental protection" );
                }
            }
            keyed_bodyparts.clear();
            for( const auto &[bodypart, slots] : definition.occupied_bodyparts ) {
                require_bionic_reference( definition.id, bodypart,
                                          "occupied body part", body_part_exists );
                if( slots < 0 ||
                    static_cast<std::uint64_t>( slots ) >
                    std::numeric_limits<std::size_t>::max() ||
                    !keyed_bodyparts.insert( bodypart ).second ) {
                    throw std::runtime_error( "bionic '" + definition.id +
                                              "' has invalid or duplicate occupied body parts" );
                }
            }
            keyed_bodyparts.clear();
            for( const auto &[bodypart, amount] : definition.encumbrance ) {
                require_bionic_reference( definition.id, bodypart,
                                          "encumbered body part", body_part_exists );
                if( !fits_native_int( amount ) || amount < 0 ||
                    !keyed_bodyparts.insert( bodypart ).second ) {
                    throw std::runtime_error( "bionic '" + definition.id +
                                              "' has invalid or duplicate encumbrance" );
                }
            }
            std::set<std::string> protection_keys;
            for( const bionic_protection_definition_data &protection : definition.protection ) {
                require_bionic_reference( definition.id, protection.bodypart,
                                          "protection body part", body_part_exists );
                require_bionic_reference(
                    definition.id, protection.damage_type, "protection damage type",
                [&index_defines, &index]( const std::string & id ) {
                    return index_defines( index.defines_damage_type, id ) ||
                           damage_type_id( id ).is_valid();
                } );
                if( !native_nonnegative_float( protection.amount ) ||
                    !protection_keys.insert( protection.bodypart + "\n" +
                                             protection.damage_type ).second ) {
                    throw std::runtime_error( "bionic '" + definition.id +
                                              "' has invalid or duplicate damage protection" );
                }
            }
            std::set<std::string> learned_spell_ids;
            for( const auto &[spell, level] : definition.learned_spells ) {
                require_valid_id( spell, "bionic learned spell" );
                if( !fits_native_int( level ) || level < 0 ||
                    !learned_spell_ids.insert( spell ).second ||
                    ( check_engine_state && !staged_spell( spell ) &&
                      !spell_id( spell ).is_valid() ) ) {
                    throw std::runtime_error( "bionic '" + definition.id +
                                              "' has an unknown, duplicate, or invalid learned spell '" +
                                              spell + "'" );
                }
            }
            const bool is_gun = std::find( definition.flags.begin(), definition.flags.end(),
                                           "BIONIC_GUN" ) != definition.flags.end();
            const bool is_weapon = std::find( definition.flags.begin(), definition.flags.end(),
                                              "BIONIC_WEAPON" ) != definition.flags.end();
            const bool is_toggled = std::find( definition.flags.begin(), definition.flags.end(),
                                               "BIONIC_TOGGLED" ) != definition.flags.end();
            if( ( is_gun && is_weapon ) || ( ( is_gun || is_weapon ) &&
                                             definition.fake_weapon.empty() ) ||
                ( is_weapon && !is_toggled ) ) {
                throw std::runtime_error( "bionic '" + definition.id +
                                          "' has inconsistent weapon flags or fake weapon" );
            }
            validate_operation( entry.operation, bionic_id( definition.id ).is_valid(),
                                definition.id, "bionic" );
        }

        std::set<std::string> spell_ids;
        for( const spell_registration &entry : pimpl_->spells ) {
            if( !spell_ids.insert( entry.definition->id ).second ) {
                throw std::runtime_error( "spell '" + entry.definition->id +
                                          "' is registered more than once per transaction" );
            }
        }
        const auto validate_spell_handler = [&owner_runtime](
        const std::string & owner, const std::string & handler, const char *kind ) {
            if( !handler.empty() && owner_runtime.handlers.count( handler ) == 0 ) {
                throw std::runtime_error( "spell '" + owner + "' references missing " +
                                          kind + " handler '" + handler + "'" );
            }
        };
        for( const spell_registration &entry : pimpl_->spells ) {
            const spell_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "spell" );
            if( definition.name.empty() || definition.description.empty() ||
                definition.message.empty() || definition.valid_targets.empty() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' requires name, description, message, and targets" );
            }
            if( check_engine_state && !index_defines( index.defines_skill,  definition.skill ) &&
                !skill_id( definition.skill ).is_valid() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' references unknown skill '" + definition.skill + "'" );
            }
            if( !definition.magic_type.empty() && check_engine_state &&
                !staged_magic_type( definition.magic_type ) &&
                !magic_type_id( definition.magic_type ).is_valid() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' references unknown magic type '" +
                                          definition.magic_type + "'" );
            }
            if( !definition.components.empty() && check_engine_state &&
                !staged_requirement( definition.components ) &&
                !requirement_id( definition.components ).is_valid() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' references unknown component requirement '" +
                                          definition.components + "'" );
            }
            if( !io::string_to_enum_optional<sounds::sound_t>( definition.sound_type ) ) {
                throw std::runtime_error( "spell '" + definition.id +

                                          "' has unknown sound type '" +
                                          definition.sound_type + "'" );
            }
            if( !io::string_to_enum_optional<spell_shape>( definition.shape ) ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' has unknown shape '" + definition.shape + "'" );
            }
            if( definition.effect == "lua" ) {
                if( definition.effect_handler.empty() ) {
                    throw std::runtime_error( "Lua spell '" + definition.id +
                                              "' requires an effect handler" );
                }
                validate_spell_handler( definition.id, definition.effect_handler, "effect" );
            } else {
                if( !definition.effect_handler.empty() ||
                    spell_effect::effect_map.count( definition.effect ) == 0 ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' has an unknown or inconsistent effect '" +
                                              definition.effect + "'" );
                }
            }
            if( !definition.explosion_light.empty() && check_engine_state &&
                !staged_explosion_light( definition.explosion_light ) &&
                !explosion_light_str_id( definition.explosion_light ).is_valid() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' references unknown explosion light '" +
                                          definition.explosion_light + "'" );
            }
            if( !definition.field.empty() && check_engine_state &&
                !staged_field( definition.field ) &&
                !field_type_id( definition.field ).is_valid() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' references unknown field '" + definition.field + "'" );
            }
            if( definition.spell_class != "NONE" && check_engine_state &&
                !trait_id( definition.spell_class ).is_valid() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' references unknown spell class '" +
                                          definition.spell_class + "'" );
            }
            const std::optional<magic_energy_type> energy = definition.energy_source.empty() ?
                    std::optional<magic_energy_type>() :
                    io::string_to_enum_optional<magic_energy_type>( definition.energy_source );
            if( !definition.energy_source.empty() && !energy ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' has unknown energy source '" +
                                          definition.energy_source + "'" );
            }
            if( energy && *energy == magic_energy_type::vitamin ) {
                if( definition.energy_vitamin.empty() ||
                    ( check_engine_state &&
                      !vitamin_id( definition.energy_vitamin ).is_valid() ) ||
                    color_from_string( definition.energy_color,
                                       report_color_error::no ) == c_unset ) {
                    throw std::runtime_error( "vitamin-powered spell '" + definition.id +
                                              "' requires a valid vitamin and color" );
                }
            } else if( !definition.energy_vitamin.empty() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' specifies a vitamin for a non-vitamin energy source" );
            }
            if( !definition.damage_type.empty() && check_engine_state &&
                !index_defines( index.defines_damage_type,  definition.damage_type ) &&
                !damage_type_id( definition.damage_type ).is_valid() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' references unknown damage type '" +
                                          definition.damage_type + "'" );
            }
            if( definition.get_level_formula.empty() !=
                definition.exp_for_level_formula.empty() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' must define both progression formulas or neither" );
            }
            for( const std::string *formula : {
                     &definition.get_level_formula, &definition.exp_for_level_formula
                 } ) {
                if( !formula->empty() && check_engine_state &&
                    !jmath_func_id( *formula ).is_valid() ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' references unknown progression formula '" +
                                              *formula + "'" );
                }
            }
            if( definition.max_book_level &&
                ( !fits_native_int( *definition.max_book_level ) ||
                  *definition.max_book_level < 0 ) ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' has an invalid maximum book level" );
            }
            validate_spell_handler( definition.id,
                                    definition.caster_condition_handler, "caster-condition" );
            validate_spell_handler( definition.id,
                                    definition.target_condition_handler, "target-condition" );
            for( const auto &[stat, value] : definition.stats ) {
                if( !std::isfinite( value ) ||
                    std::abs( value ) > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' has invalid stat '" + stat + "'" );
                }
            }
            for( const auto &[stat, value] : definition.stat_maximums ) {
                if( definition.stats.count( stat ) == 0 || !std::isfinite( value ) ||
                    std::abs( value ) > std::numeric_limits<int>::max() ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' has invalid stat range '" + stat + "'" );
                }
            }
            for( const auto &[stat, handler] : definition.stat_handlers ) {
                if( definition.stats.count( stat ) == 0 || handler.empty() ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' has unknown dynamic stat '" + stat + "'" );
                }
                validate_spell_handler( definition.id, handler, "dynamic-stat" );
            }
            if( definition.stats.at( "field_chance" ) <= 0.0 ||
                definition.stats.at( "multiple_projectiles" ) < 0.0 ||
                definition.stats.at( "max_level" ) < 0.0 ||
                definition.stats.at( "base_casting_time" ) < 0.0 ||
                definition.stats.at( "final_casting_time" ) < 0.0 ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' has an invalid nonnegative or chance stat" );
            }
            std::set<std::string> unique;
            for( const std::string &target : definition.valid_targets ) {
                if( !unique.insert( target ).second ||
                    !io::string_to_enum_optional<spell_target>( target ) ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' has unknown or duplicate target '" + target + "'" );
                }
            }
            unique.clear();
            for( const std::string &flag : definition.flags ) {
                if( flag.empty() || !unique.insert( flag ).second ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' has an empty or duplicate flag" );
                }
            }
            if( unique.count( "TOUCH_REQUIRED" ) != 0 &&
                unique.count( "NO_HANDS" ) != 0 ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' cannot require touch while forbidding hands" );
            }
            if( unique.count( "WONDER" ) != 0 && definition.additional_spells.empty() ) {
                throw std::runtime_error( "wonder spell '" + definition.id +
                                          "' requires additional spells" );
            }
            const auto validate_spell_string_list = [&]( const std::vector<std::string> &values,
            const char *kind, const auto & exists ) {
                std::set<std::string> ids;
                for( const std::string &value : values ) {
                    require_valid_id( value, kind );
                    if( !ids.insert( value ).second ||
                        ( check_engine_state && !exists( value ) ) ) {
                        throw std::runtime_error( "spell '" + definition.id +
                                                  "' has unknown or duplicate " + kind +
                                                  " '" + value + "'" );
                    }
                }
            };
            validate_spell_string_list(
                definition.targeted_monsters, "targeted monster",
            [&staged_monster_for_spell]( const std::string & id ) {
                return staged_monster_for_spell( id ) || mtype_id( id ).is_valid();
            } );
            validate_spell_string_list(
                definition.targeted_species, "targeted species",
            [&staged_species]( const std::string & id ) {
                return staged_species( id ) || species_id( id ).is_valid();
            } );
            validate_spell_string_list(
                definition.ignored_species, "ignored species",
            [&staged_species]( const std::string & id ) {
                return staged_species( id ) || species_id( id ).is_valid();
            } );
            validate_spell_string_list(
                definition.affected_bodyparts, "affected body part", body_part_exists );
            const auto spell_exists = [&staged_spell_id]( const std::string & id ) {
                return staged_spell_id( id ) || spell_id( id ).is_valid();
            };

            for( const enchantment_fake_spell_definition_data &spell :
                 definition.additional_spells ) {
                require_valid_id( spell.spell, "additional spell" );
                if( !fits_native_int( spell.level ) || spell.level < 0 ||
                    !fits_native_int( spell.trigger_once_in ) || spell.trigger_once_in <= 0 ||
                    ( spell.max_level &&
                      ( !fits_native_int( *spell.max_level ) || *spell.max_level < spell.level ) ) ||
                    ( check_engine_state && !spell_exists( spell.spell ) ) ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' has an unknown or invalid additional spell '" +
                                              spell.spell + "'" );
                }
            }
            std::set<std::string> learned;
            for( const auto &[spell, level] : definition.learned_spells ) {
                require_valid_id( spell, "learned spell" );
                if( !fits_native_int( level ) || level < 0 ||
                    !learned.insert( spell ).second ||
                    ( check_engine_state && !spell_exists( spell ) ) ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' has an unknown, duplicate, or invalid learned spell '" +
                                              spell + "'" );
                }
            }
            if( definition.channel_turns < 0 || !fits_native_int( definition.channel_turns ) ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' has invalid channel duration" );
            }
            if( definition.channel_turns > 0 ) {
                for( const std::string *channel_spell : {
                         &definition.channel_spell, &definition.channel_end_spell
                     } ) {
                    require_valid_id( *channel_spell, "channel spell" );
                    if( check_engine_state && !spell_exists( *channel_spell ) ) {
                        throw std::runtime_error( "spell '" + definition.id +
                                                  "' references unknown channel spell '" +
                                                  *channel_spell + "'" );
                    }
                }
                if( !definition.channel_interrupt_spell.empty() && check_engine_state &&
                    !spell_exists( definition.channel_interrupt_spell ) ) {
                    throw std::runtime_error( "spell '" + definition.id +
                                              "' references unknown channel interrupt spell '" +
                                              definition.channel_interrupt_spell + "'" );
                }
            } else if( !definition.channel_spell.empty() ||
                       !definition.channel_end_spell.empty() ||
                       !definition.channel_interrupt_spell.empty() ) {
                throw std::runtime_error( "spell '" + definition.id +
                                          "' has channel spells without a positive duration" );
            }
            validate_operation( entry.operation, spell_id( definition.id ).is_valid(),
                                definition.id, "spell" );
        }
        if( !pimpl_->spells.empty() ) {
            std::map<std::string, std::vector<std::string>> graph;
            for( const spell_registration &entry : pimpl_->spells ) {
                std::vector<std::string> &edges = graph[entry.definition->id];
                for( const enchantment_fake_spell_definition_data &spell :
                     entry.definition->additional_spells ) {
                    if( spell_ids.count( spell.spell ) != 0 ) {
                        edges.push_back( spell.spell );
                    }
                }
            }
            std::map<std::string, int> visited;
            std::function<void( const std::string & )> visit_spell =
            [&]( const std::string & id ) {
                if( visited[id] == 2 ) {
                    return;
                }
                if( visited[id] == 1 ) {
                    throw std::runtime_error(
                        "spell additional-effect graph contains a cycle at '" + id + "'" );
                }
                visited[id] = 1;
                for( const std::string &next : graph[id] ) {
                    visit_spell( next );
                }
                visited[id] = 2;
            };
            for( const spell_registration &entry : pimpl_->spells ) {
                visit_spell( entry.definition->id );
            }
        }

        std::set<std::string> mission_definition_ids;
        for( const mission_definition_registration &entry : pimpl_->mission_definitions ) {
            if( !mission_definition_ids.insert( entry.definition->id ).second ) {
                throw std::runtime_error( "mission definition '" + entry.definition->id +
                                          "' is registered more than once per transaction" );
            }
        }
        const auto mission_definition_exists = [&mission_definition_ids](
        const std::string & id ) {
            return mission_definition_ids.count( id ) != 0 || mission_type_id( id ).is_valid();
        };
        const auto validate_mission_handler = [&owner_runtime](
        const std::string & owner, const std::string & handler, const char *kind ) {
            if( !handler.empty() && owner_runtime.handlers.count( handler ) == 0 ) {
                throw std::runtime_error( "mission definition '" + owner +
                                          "' references missing " + kind + " handler '" +
                                          handler + "'" );
            }
        };
        static const std::set<std::string> mission_dialogue_phases = {
            "describe", "offer", "accepted", "rejected", "advice",
            "inquire", "success", "success_lie", "failure"
        };
        for( const mission_definition_registration &entry : pimpl_->mission_definitions ) {
            const mission_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "mission definition" );
            if( definition.name.empty() || !fits_native_int( definition.difficulty ) ||
                !fits_native_int( definition.value ) || definition.value < 0 ||
                !fits_native_int( definition.item_count ) || definition.item_count <= 0 ||
                !fits_native_int( definition.monster_kill_goal ) ) {
                throw std::runtime_error( "mission definition '" + definition.id +
                                          "' has missing text or values outside native ranges" );
            }
            if( !io::string_to_enum_optional<mission_goal>( definition.goal ) ) {
                throw std::runtime_error( "mission definition '" + definition.id +
                                          "' has unknown goal '" + definition.goal + "'" );
            }
            std::set<std::string> origins;
            bool needs_dialogue = false;
            for( const std::string &origin : definition.origins ) {
                const std::optional<mission_origin> parsed =
                    io::string_to_enum_optional<mission_origin>( origin );
                if( !parsed || !origins.insert( origin ).second ) {
                    throw std::runtime_error( "mission definition '" + definition.id +
                                              "' has unknown or duplicate origin '" + origin + "'" );
                }
                needs_dialogue = needs_dialogue || *parsed == ORIGIN_ANY_NPC ||
                                 *parsed == ORIGIN_OPENER_NPC || *parsed == ORIGIN_SECONDARY;
            }
            if( needs_dialogue ) {
                for( const std::string &phase : mission_dialogue_phases ) {
                    const auto found = definition.dialogue.find( phase );
                    if( found == definition.dialogue.end() || found->second.empty() ) {
                        throw std::runtime_error( "NPC mission definition '" + definition.id +
                                                  "' is missing dialogue phase '" + phase + "'" );
                    }
                }
            }
            for( const auto &[phase, text] : definition.dialogue ) {
                if( mission_dialogue_phases.count( phase ) == 0 || text.empty() ||
                    text.size() > 32768 || text.find( '\0' ) != std::string::npos ) {
                    throw std::runtime_error( "mission definition '" + definition.id +
                                              "' has invalid dialogue" );
                }
            }
            if( definition.deadline_min_turns < 0 ||
                !fits_native_int( definition.deadline_min_turns ) ||
                ( definition.deadline_max_turns &&
                  ( !fits_native_int( *definition.deadline_max_turns ) ||
                    *definition.deadline_max_turns < definition.deadline_min_turns ) ) ) {
                throw std::runtime_error( "mission definition '" + definition.id +
                                          "' has an invalid deadline" );
            }
            validate_mission_handler( definition.id, definition.deadline_handler, "deadline" );
            validate_mission_handler( definition.id, definition.place_handler, "place" );
            validate_mission_handler( definition.id, definition.start_handler, "start" );
            validate_mission_handler( definition.id, definition.end_handler, "success" );
            validate_mission_handler( definition.id, definition.fail_handler, "failure" );
            validate_mission_handler( definition.id,
                                      definition.goal_condition_handler, "goal-condition" );
            if( definition.place_handler.empty() && definition.place != "always" &&
                definition.place != "never" && definition.place != "near_town" ) {
                throw std::runtime_error( "mission definition '" + definition.id +
                                          "' has unknown place selector '" + definition.place + "'" );
            }
            if( definition.goal == "MGOAL_CONDITION" &&
                definition.goal_condition_handler.empty() ) {
                throw std::runtime_error( "conditional mission definition '" + definition.id +

                                          "' requires a Lua goal-condition handler" );
            }
            const auto validate_item_reference = [&]( const std::string & id,
            const char *kind ) {
                if( id.empty() ) {
                    return;
                }
                require_valid_id( id, kind );
                if( check_engine_state && !index_defines( index.defines_item,  id ) &&
                    !item::type_is_defined( itype_id( id ) ) ) {
                    throw std::runtime_error( "mission definition '" + definition.id +
                                              "' references unknown " + kind + " '" + id + "'" );
                }
            };
            validate_item_reference( definition.item, "item" );
            validate_item_reference( definition.required_container, "required container" );
            validate_item_reference( definition.empty_container, "empty container" );
            if( !definition.item_group.empty() && check_engine_state &&
                !staged_item_group_for_mission( definition.item_group ) &&
                !item_group_id( definition.item_group ).is_valid() ) {
                throw std::runtime_error( "mission definition '" + definition.id +
                                          "' references unknown item group '" +
                                          definition.item_group + "'" );
            }
            if( !definition.recruit_class.empty() && check_engine_state &&
                !npc_class_id( definition.recruit_class ).is_valid() ) {
                throw std::runtime_error( "mission definition '" + definition.id +
                                          "' references unknown NPC class '" +
                                          definition.recruit_class + "'" );
            }
            if( !definition.monster_type.empty() && check_engine_state &&
                !staged_monster_for_spell( definition.monster_type ) &&
                !mtype_id( definition.monster_type ).is_valid() ) {
                throw std::runtime_error( "mission definition '" + definition.id +
                                          "' references unknown monster '" +
                                          definition.monster_type + "'" );
            }
            if( !definition.monster_species.empty() && check_engine_state &&
                !staged_species( definition.monster_species ) &&
                !species_id( definition.monster_species ).is_valid() ) {
                throw std::runtime_error( "mission definition '" + definition.id +
                                          "' references unknown monster species '" +
                                          definition.monster_species + "'" );
            }
            if( !definition.destination.empty() && check_engine_state &&
                !oter_type_str_id( definition.destination ).is_valid() ) {
                throw std::runtime_error( "mission definition '" + definition.id +
                                          "' references unknown destination '" +
                                          definition.destination + "'" );
            }
            if( !definition.followup.empty() ) {
                require_valid_id( definition.followup, "mission followup" );
                if( definition.followup == definition.id ||
                    ( check_engine_state &&
                      !mission_definition_exists( definition.followup ) ) ) {
                    throw std::runtime_error( "mission definition '" + definition.id +
                                              "' has an unknown or self-referential followup '" +
                                              definition.followup + "'" );
                }
            }
            for( const auto &[reward, description] : definition.likely_rewards ) {
                if( !std::isfinite( reward ) ||
                    std::abs( reward ) > std::numeric_limits<int>::max() ||
                    description.empty() || description.size() > 16384 ) {
                    throw std::runtime_error( "mission definition '" + definition.id +
                                              "' has an invalid likely reward" );
                }
            }
            if( definition.goal == "MGOAL_FIND_ITEM" && definition.item.empty() ) {
                throw std::runtime_error( "find-item mission definition '" + definition.id +
                                          "' requires an item" );
            }
            if( definition.goal == "MGOAL_FIND_ITEM_GROUP" &&
                definition.item_group.empty() ) {
                throw std::runtime_error( "find-item-group mission definition '" +
                                          definition.id + "' requires an item group" );
            }
            if( definition.goal == "MGOAL_KILL_MONSTER_TYPE" &&
                definition.monster_type.empty() ) {
                throw std::runtime_error( "kill-monster-type mission definition '" +
                                          definition.id + "' requires a monster type" );
            }
            if( definition.goal == "MGOAL_KILL_MONSTER_SPEC" &&
                definition.monster_species.empty() ) {
                throw std::runtime_error( "kill-species mission definition '" +
                                          definition.id + "' requires a monster species" );
            }
            if( definition.goal == "MGOAL_RECRUIT_NPC_CLASS" &&
                definition.recruit_class.empty() ) {
                throw std::runtime_error( "recruit-class mission definition '" +
                                          definition.id + "' requires an NPC class" );
            }
            validate_operation( entry.operation,
                                mission_type_id( definition.id ).is_valid(),
                                definition.id, "mission definition" );
        }

        const auto validate_profession_item_requirements =
            [&]( const detail::profession_item_substitution_native_requirement & requirements,
        const std::string & owner ) {
            std::set<std::string> traits;
            for( const std::string &trait : requirements.present ) {
                require_valid_id( trait, "profession item substitution trait" );
                if( !traits.insert( trait ).second ||
                    ( check_engine_state && !index_defines( index.defines_trait, trait ) &&
                      !trait_id( trait ).is_valid() ) ) {
                    throw std::runtime_error( owner +
                                              " has an unknown, duplicate, or contradictory trait '" +
                                              trait + "'" );
                }
            }
            for( const std::string &trait : requirements.absent ) {
                require_valid_id( trait, "profession item substitution trait" );
                if( !traits.insert( trait ).second ||
                    ( check_engine_state && !index_defines( index.defines_trait, trait ) &&
                      !trait_id( trait ).is_valid() ) ) {
                    throw std::runtime_error( owner +
                                              " has an unknown, duplicate, or contradictory trait '" +
                                              trait + "'" );
                }
            }
        };
        std::set<std::string> profession_item_substitution_ids;
        for( const profession_item_substitution_registration &entry :
             pimpl_->profession_item_substitutions ) {
            const profession_item_substitution_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "profession item substitution" );
            if( !profession_item_substitution_ids.insert( definition.id ).second ||
                definition.rules.empty() || definition.rules.size() > 256 ||
                ( check_engine_state && !index_defines( index.defines_item, definition.id ) &&
                  !item::type_is_defined( itype_id( definition.id ) ) ) ) {
                throw std::runtime_error( "profession item substitution '" + definition.id +
                                          "' has an unknown item, no rules, or a duplicate id" );
            }
            for( const detail::profession_item_substitution_native_rule &rule :
                 definition.rules ) {
                validate_profession_item_requirements(
                    rule.requirements, "profession item substitution '" + definition.id + "'" );
                if( rule.replacements.empty() || rule.replacements.size() > 64 ) {
                    throw std::runtime_error( "profession item substitution '" + definition.id +
                                              "' requires bounded replacement lists" );
                }
                for( const detail::profession_item_substitution_native_replacement &replacement :
                     rule.replacements ) {
                    require_valid_id( replacement.item, "profession item replacement" );
                    if( !std::isfinite( replacement.ratio ) || replacement.ratio <= 0.0 ||
                        ( check_engine_state &&
                          !index_defines( index.defines_item, replacement.item ) &&
                          !item::type_is_defined( itype_id( replacement.item ) ) ) ) {
                        throw std::runtime_error( "profession item substitution '" + definition.id +
                                                  "' has an invalid replacement '" +
                                                  replacement.item + "'" );
                    }
                }
            }
            validate_operation(
                entry.operation,
                detail::profession_item_substitution_registry_contains( definition.id ),
                definition.id, "profession item substitution" );
        }

        std::set<std::string> profession_item_bonus_ids;
        for( const profession_item_bonus_registration &entry : pimpl_->profession_item_bonuses ) {
            const profession_item_bonus_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "profession item bonus group" );
            if( !profession_item_bonus_ids.insert( definition.id ).second ||
                definition.requirements.empty() || definition.requirements.size() > 256 ||
                ( check_engine_state && !index_defines( index.defines_item_group, definition.id ) &&
                  !item_group::group_is_defined( item_group_id( definition.id ) ) ) ) {
                throw std::runtime_error( "profession item bonus '" + definition.id +
                                          "' has an unknown group, no conditions, or a duplicate id" );
            }
            for( const detail::profession_item_substitution_native_requirement &requirements :
                 definition.requirements ) {
                validate_profession_item_requirements(
                    requirements, "profession item bonus '" + definition.id + "'" );
            }
            validate_operation(
                entry.operation,
                detail::profession_item_bonus_registry_contains( definition.id ),
                definition.id, "profession item bonus" );
        }

        std::set<std::string> technique_ids;
        for( const technique_registration &entry : pimpl_->techniques ) {
            const technique_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "technique" );
            if( definition.name.empty() ||
                !technique_ids.insert( definition.id ).second ||
                definition.weighting < 0 ||
                definition.repeat_min < 1 ||
                definition.repeat_max < definition.repeat_min ||
                definition.down_dur < 0 ||
                definition.stun_dur < 0 ||
                definition.knockback_dist < 0 ||
                !std::isfinite( definition.knockback_spread ) ||
                definition.knockback_spread < 0.0 ) {
                throw std::runtime_error( "technique '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            for( const std::string &vector : definition.attack_vectors ) {
                if( vector.empty() ||
                    ( check_engine_state && !index_defines( index.defines_attack_vector, vector ) &&
                      !attack_vector_id( vector ).is_valid() ) ) {
                    throw std::runtime_error( "technique '" + definition.id +
                                              "' references an invalid attack vector '" +
                                              vector + "'" );
                }
            }
            for( const auto &[skill, level] : definition.min_skills ) {
                if( skill.empty() || level < 0 ||
                    level > std::numeric_limits<int>::max() ||
                    ( check_engine_state && !index_defines( index.defines_skill, skill ) &&
                      !skill_id( skill ).is_valid() ) ) {
                    throw std::runtime_error( "technique '" + definition.id +
                                              "' references an invalid skill requirement" );
                }
            }
            if( !definition.apply_handler.empty() &&
                owner_runtime.handlers.count( definition.apply_handler ) == 0 ) {
                throw std::runtime_error( "technique '" + definition.id +
                                          "' references missing application handler '" +
                                          definition.apply_handler + "'" );
            }
            validate_operation( entry.operation, matec_id( definition.id ).is_valid(),
                                definition.id, "technique" );
        }

        std::set<std::string> martial_art_ids;
        for( const martial_art_registration &entry : pimpl_->martial_arts ) {
            const martial_art_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "martial art" );
            if( definition.name.empty() ||
                !martial_art_ids.insert( definition.id ).second ||
                definition.learn_difficulty < 0 ||
                definition.arm_block < 0 || definition.arm_block > 100 ||
                definition.leg_block < 0 || definition.leg_block > 100 ) {
                throw std::runtime_error( "martial art '" + definition.id +
                                          "' has invalid ranges or a duplicate registration" );
            }
            for( const auto &[skill, level] : definition.autolearn_skills ) {
                if( skill.empty() || level < 0 ||
                    ( check_engine_state && !index_defines( index.defines_skill, skill ) &&
                      !skill_id( skill ).is_valid() ) ) {
                    throw std::runtime_error( "martial art '" + definition.id +
                                              "' references an invalid autolearn skill" );
                }
            }
            if( check_engine_state ) {
                for( const std::string &technique : definition.techniques ) {
                    if( !registration_id_exists( pimpl_->techniques, technique ) &&
                        !matec_id( technique ).is_valid() ) {
                        throw std::runtime_error( "martial art '" + definition.id +
                                                  "' references an invalid technique '" +
                                                  technique + "'" );
                    }
                }
                for( const std::string &weapon : definition.weapons ) {
                    if( !index_defines( index.defines_item, weapon ) && !itype_id( weapon ).is_valid() ) {
                        throw std::runtime_error( "martial art '" + definition.id +
                                                  "' references an invalid weapon '" +
                                                  weapon + "'" );
                    }
                }
                for( const std::string &category : definition.weapon_categories ) {
                    if( !index_defines( index.defines_weapon_category, category ) &&
                        !weapon_category_id( category ).is_valid() ) {
                        throw std::runtime_error( "martial art '" + definition.id +
                                                  "' references an invalid weapon category '" +
                                                  category + "'" );
                    }
                }
            }
            for( const auto &[phase, handler_id] : definition.handlers ) {
                static const std::set<std::string> phases = {
                    "static", "move", "pause", "hit", "attack", "dodge",
                    "block", "gethit", "miss", "crit", "kill"
                };
                if( phases.count( phase ) == 0 || handler_id.empty() ||
                    owner_runtime.handlers.count( handler_id ) == 0 ) {
                    throw std::runtime_error( "martial art '" + definition.id +
                                              "' has an invalid " + phase + " handler" );
                }
            }
            validate_operation( entry.operation, matype_id( definition.id ).is_valid(),
                                definition.id, "martial art" );
        }

        std::set<std::string> magic_type_ids;
        for( const magic_type_registration &entry : pimpl_->magic_types ) {
            const magic_type_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "magic type" );
            const std::optional<magic_energy_type> energy =
                platform_magic_energy_type( definition.energy_source );
            if( !magic_type_ids.insert( definition.id ).second || !energy ||
                !std::isfinite( definition.failure_cost_fraction ) ||
                definition.failure_cost_fraction < 0.0 ||
                !std::isfinite( definition.failure_experience_fraction ) ||
                definition.failure_experience_fraction < 0.0 ||
                color_from_string( definition.energy_color,
                                   report_color_error::no ) == c_unset ||
                ( definition.max_book_level &&
                  ( *definition.max_book_level < 0 ||
                    *definition.max_book_level > std::numeric_limits<int>::max() ) ) ||
                definition.level_for_experience_handler.empty() !=
                definition.experience_for_level_handler.empty() ) {
                throw std::runtime_error( "magic type '" + definition.id +
                                          "' has invalid energy, progression, limits, or fractions" );
            }
            if( *energy == magic_energy_type::vitamin ) {
                if( definition.vitamin.empty() ||
                    ( !index_defines( index.defines_vitamin, definition.vitamin ) &&
                      !vitamin_id( definition.vitamin ).is_valid() ) ) {
                    throw std::runtime_error( "magic type '" + definition.id +
                                              "' needs a valid vitamin energy source" );
                }
            } else if( !definition.vitamin.empty() ) {
                throw std::runtime_error( "magic type '" + definition.id +
                                          "' declares a vitamin for non-vitamin energy" );
            }
            for( const std::string &flag : definition.cannot_cast_flags ) {
                if( flag.empty() ) {
                    throw std::runtime_error( "magic type '" + definition.id +
                                              "' has an empty casting restriction" );
                }
            }
            const std::array<std::pair<const char *, const std::string *>, 7> handlers = { {
                    { "level-for-experience", &definition.level_for_experience_handler },
                    { "experience-for-level", &definition.experience_for_level_handler },
                    { "casting-experience", &definition.casting_experience_handler },
                    { "failure-chance", &definition.failure_chance_handler },
                    { "failure-cost", &definition.failure_cost_handler },
                    { "failure-experience", &definition.failure_experience_handler },
                    { "failure", &definition.failure_handler },
                }
            };
            for( const auto &[label, handler_id] : handlers ) {
                if( !handler_id->empty() && owner_runtime.handlers.count( *handler_id ) == 0 ) {
                    throw std::runtime_error( "magic type '" + definition.id +
                                              "' references missing " + label +
                                              " handler '" + *handler_id + "'" );
                }
            }
            validate_operation( entry.operation, magic_type_id( definition.id ).is_valid(),
                                definition.id, "magic type" );
        }

        std::set<std::string> movement_mode_ids;
        for( const movement_mode_registration &entry : pimpl_->movement_modes ) {
            const movement_mode_definition_data &definition = *entry.definition;
            require_valid_id( definition.id, "movement mode" );
            if( !movement_mode_ids.insert( definition.id ).second ||
                definition.name.empty() ||
                !platform_movement_mode_type( definition.kind ) ||
                definition.character_symbol == 0 || definition.panel_symbol == 0 ||
                color_from_string( definition.panel_color,
                                   report_color_error::no ) == c_unset ||
                color_from_string( definition.symbol_color,
                                   report_color_error::no ) == c_unset ||
                !std::isfinite( definition.exertion ) || definition.exertion < 0.0 ||
                definition.exertion > std::numeric_limits<float>::max() ||
                !std::isfinite( definition.riding_exertion ) ||
                definition.riding_exertion < 0.0 ||
                definition.riding_exertion > std::numeric_limits<float>::max() ||
                !std::isfinite( definition.stamina_multiplier ) ||
                definition.stamina_multiplier < 0.0 ||
                definition.stamina_multiplier > std::numeric_limits<float>::max() ||
                !std::isfinite( definition.sound_multiplier ) ||
                definition.sound_multiplier < 0.0 ||
                definition.sound_multiplier > std::numeric_limits<float>::max() ||
                !std::isfinite( definition.speed_multiplier ) ||
                definition.speed_multiplier <= 0.0 ||
                definition.speed_multiplier > std::numeric_limits<float>::max() ||
                definition.mech_power_kilojoules < 0 ||
                definition.mech_power_kilojoules > std::numeric_limits<int>::max() ||
                definition.swim_speed_modifier < std::numeric_limits<int>::min() ||
                definition.swim_speed_modifier > std::numeric_limits<int>::max() ) {
                throw std::runtime_error( "movement mode '" + definition.id +
                                          "' has invalid symbols, colors, type, or movement values" );
            }
            std::set<steed_type> steed_messages;
            for( const movement_mode_message_definition_data &messages :
                 definition.messages ) {
                const std::optional<steed_type> steed =
                    platform_steed_type( messages.steed );
                if( !steed || !steed_messages.insert( *steed ).second ||
                    messages.prepare.empty() || messages.success.empty() ||
                    messages.failure.empty() ) {
                    throw std::runtime_error( "movement mode '" + definition.id +
                                              "' has invalid or duplicate steed messages" );
                }
            }
            if( steed_messages.size() != 3 ) {
                throw std::runtime_error( "movement mode '" + definition.id +
                                          "' needs messages for none, animal, and mech" );
            }
            validate_operation( entry.operation, move_mode_id( definition.id ).is_valid(),
                                definition.id, "movement mode" );
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool character_content_transaction::validate_finalized( std::string &error ) const
{
    if( !pimpl_->applied ) {
        error = "character content transaction for '" + pimpl_->owner + "' is not applied";
        return false;
    }
    if( pimpl_->finalization_validated ) {
        error = "character content finalization for '" + pimpl_->owner +
                "' was already validated";
        return false;
    }
    const auto require_valid = [&error]( const bool valid, const std::string & kind,
    const std::string & id ) {
        if( !valid ) {
            error = "Lua-first " + kind + " '" + id +
                    "' did not survive global finalization";
            return false;
        }
        return true;
    };
    for( const profession_registration &entry : pimpl_->professions ) {
        if( !require_valid( profession_id( entry.definition->id ).is_valid(),
                            "profession", entry.definition->id ) ) {
            return false;
        }
    }
    for( const profession_group_registration &entry : pimpl_->profession_groups ) {
        if( !require_valid( profession_group_id( entry.definition->id ).is_valid(),
                            "profession group", entry.definition->id ) ) {
            return false;
        }
    }
    for( const widget_registration &entry : pimpl_->widgets ) {
        if( !require_valid( widget_id( entry.definition->id ).is_valid(),
                            "widget", entry.definition->id ) ) {
            return false;
        }
    }
    for( const enchantment_registration &entry : pimpl_->enchantments ) {
        if( !require_valid( enchantment_id( entry.definition->id ).is_valid(),
                            "enchantment", entry.definition->id ) ) {
            return false;
        }
    }
    for( const bionic_registration &entry : pimpl_->bionics ) {
        if( !require_valid( bionic_id( entry.definition->id ).is_valid(),
                            "bionic", entry.definition->id ) ) {
            return false;
        }
    }
    for( const spell_registration &entry : pimpl_->spells ) {
        if( !require_valid( spell_id( entry.definition->id ).is_valid(),
                            "spell", entry.definition->id ) ) {
            return false;
        }
    }
    for( const mission_definition_registration &entry : pimpl_->mission_definitions ) {
        if( !require_valid( mission_type_id( entry.definition->id ).is_valid(),
                            "mission definition", entry.definition->id ) ) {
            return false;
        }
    }
    for( const profession_item_substitution_registration &entry :
         pimpl_->profession_item_substitutions ) {
        if( !require_valid( detail::profession_item_substitution_registry_contains(
                                entry.definition->id ),
                            "profession item substitution", entry.definition->id ) ) {
            return false;
        }
    }
    for( const profession_item_bonus_registration &entry : pimpl_->profession_item_bonuses ) {
        if( !require_valid( detail::profession_item_bonus_registry_contains(
                                entry.definition->id ),
                            "profession item bonus", entry.definition->id ) ) {
            return false;
        }
    }
    for( const technique_registration &entry : pimpl_->techniques ) {
        if( !require_valid( matec_id( entry.definition->id ).is_valid(),
                            "technique", entry.definition->id ) ) {
            return false;
        }
    }
    for( const martial_art_registration &entry : pimpl_->martial_arts ) {
        if( !require_valid( matype_id( entry.definition->id ).is_valid(),
                            "martial art", entry.definition->id ) ) {
            return false;
        }
    }
    for( const magic_type_registration &entry : pimpl_->magic_types ) {
        if( !require_valid( magic_type_id( entry.definition->id ).is_valid(),
                            "magic type", entry.definition->id ) ) {
            return false;
        }
    }
    for( const movement_mode_registration &entry : pimpl_->movement_modes ) {
        if( !require_valid( move_mode_id( entry.definition->id ).is_valid(),
                            "movement mode", entry.definition->id ) ) {
            return false;
        }
    }
    pimpl_->finalization_validated = true;
    error.clear();
    return true;
}

void character_content_transaction::rollback_phase(
    const character_content_rollback_phase phase )
{
    const auto restore_factory = []( auto & factory, auto & undo ) {
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
        case character_content_rollback_phase::movement_mode: {
            const bool had_movement_modes = !pimpl_->movement_mode_undo.empty();
            restore_factory( detail::movement_mode_registry(), pimpl_->movement_mode_undo );
            if( had_movement_modes ) {
                detail::refresh_movement_mode_registry();
            }
        }
        break;
        case character_content_rollback_phase::magic_type: {
            const bool had_magic_types = !pimpl_->magic_type_undo.empty();
            restore_factory( detail::magic_type_registry(), pimpl_->magic_type_undo );
            if( had_magic_types ) {
                detail::magic_type_registry().finalize();
            }
        }
        break;
        case character_content_rollback_phase::martial_art:
            for( auto it = pimpl_->martial_art_undo.rbegin();
                 it != pimpl_->martial_art_undo.rend(); ++it ) {
                if( it->second ) {
                    detail::martialart_registry().insert( *it->second );
                } else {
                    detail::martialart_registry().erase( it->first );
                }
            }
            if( !pimpl_->martial_art_undo.empty() ) {
                detail::martialart_registry().finalize();
            }
            pimpl_->martial_art_undo.clear();
            break;
        case character_content_rollback_phase::technique:
            for( auto it = pimpl_->technique_undo.rbegin();
                 it != pimpl_->technique_undo.rend(); ++it ) {
                if( it->second ) {
                    detail::ma_technique_registry().insert( *it->second );
                } else {
                    detail::ma_technique_registry().erase( it->first );
                }
            }
            if( !pimpl_->technique_undo.empty() ) {
                detail::ma_technique_registry().finalize();
            }
            pimpl_->technique_undo.clear();
            break;
        case character_content_rollback_phase::profession_item:
            if( pimpl_->profession_item_substitution_undo ) {
                detail::profession_item_substitution_registry_restore(
                    *pimpl_->profession_item_substitution_undo );
            }
            pimpl_->profession_item_substitution_undo.reset();
            break;
        case character_content_rollback_phase::mission_definition: {
            const bool had_missions = !pimpl_->mission_definition_undo.empty();
            restore_factory( detail::mission_type_registry(), pimpl_->mission_definition_undo );
            if( had_missions ) {
                detail::mission_type_registry().finalize();
            }
        }
        break;
        case character_content_rollback_phase::spell: {
            const bool had_spells = !pimpl_->spell_undo.empty();
            restore_factory( detail::spell_registry(), pimpl_->spell_undo );
            if( had_spells ) {
                detail::spell_registry().finalize();
            }
        }
        break;
        case character_content_rollback_phase::bionic: {
            const bool had_bionics = !pimpl_->bionic_undo.empty();
            restore_factory( detail::bionic_registry(), pimpl_->bionic_undo );
            if( had_bionics ) {
                detail::bionic_registry().finalize();
                detail::refresh_bionic_registry_cache();
            }
        }
        break;
        case character_content_rollback_phase::enchantment: {
            const bool had_enchantments = !pimpl_->enchantment_undo.empty();
            restore_factory( detail::enchantment_registry(), pimpl_->enchantment_undo );
            if( had_enchantments ) {
                detail::enchantment_registry().finalize();
            }
        }
        break;
        case character_content_rollback_phase::widget: {
            const bool had_widgets = !pimpl_->widget_undo.empty();
            restore_factory( detail::widget_registry(), pimpl_->widget_undo );
            if( had_widgets ) {
                detail::widget_registry().finalize();
            }
        }
        break;
        case character_content_rollback_phase::profession_group: {
            const bool had_profession_groups = !pimpl_->profession_group_undo.empty();
            restore_factory( detail::profession_group_registry(), pimpl_->profession_group_undo );
            if( had_profession_groups ) {
                detail::profession_group_registry().finalize();
            }
        }
        break;
        case character_content_rollback_phase::profession: {
            const bool had_professions = !pimpl_->profession_undo.empty();
            restore_factory( detail::profession_registry(), pimpl_->profession_undo );
            if( had_professions ) {
                detail::profession_registry().finalize();
            }
        }
        break;
    }
    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    if( pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::discarded;
    }
}

void character_content_transaction::rollback_all()
{
    rollback_phase( character_content_rollback_phase::movement_mode );
    rollback_phase( character_content_rollback_phase::magic_type );
    rollback_phase( character_content_rollback_phase::technique );
    rollback_phase( character_content_rollback_phase::martial_art );
    rollback_phase( character_content_rollback_phase::mission_definition );
    rollback_phase( character_content_rollback_phase::spell );
    rollback_phase( character_content_rollback_phase::bionic );
    rollback_phase( character_content_rollback_phase::enchantment );
    rollback_phase( character_content_rollback_phase::widget );
    rollback_phase( character_content_rollback_phase::profession_group );
    rollback_phase( character_content_rollback_phase::profession );
    rollback_phase( character_content_rollback_phase::profession_item );
    pimpl_->applied_phase_count = 0;
    pimpl_->next_apply_phase = character_content_apply_phase::profession;
    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    if( pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::discarded;
    }
}

void character_content_transaction::commit()
{
    if( !pimpl_->applied ) {
        return;
    }
    pimpl_->profession_undo.clear();
    pimpl_->profession_group_undo.clear();
    pimpl_->widget_undo.clear();
    pimpl_->enchantment_undo.clear();
    pimpl_->bionic_undo.clear();
    pimpl_->spell_undo.clear();
    pimpl_->mission_definition_undo.clear();
    pimpl_->profession_item_substitution_undo.reset();
    pimpl_->technique_undo.clear();
    pimpl_->martial_art_undo.clear();
    pimpl_->magic_type_undo.clear();
    pimpl_->movement_mode_undo.clear();
    pimpl_->token->lifecycle = handle_lifecycle::committed;
}

void character_content_transaction::seal()
{
    if( pimpl_->applied && pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::committed;
    }
}

void character_content_transaction::discard()
{
    rollback_all();
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

bool character_content_transaction::apply_phase(
    const character_content_apply_phase phase, std::string &error )
{
    if( pimpl_->applied ) {
        error = "character content transaction for '" + pimpl_->owner + "' was already applied";
        return false;
    }
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        error = "character content transaction for '" + pimpl_->owner +
                "' is no longer building";
        return false;
    }
    if( static_cast<int>( phase ) != static_cast<int>( pimpl_->applied_phase_count ) ) {
        error = "character content apply phases must be executed in order";
        return false;
    }
    try {
        switch( phase ) {
            case character_content_apply_phase::profession: {
                for( const profession_registration &entry : pimpl_->professions ) {
                    const profession_id id( entry.definition->id );
                    pimpl_->profession_undo.emplace_back(
                        id, id.is_valid() ? std::optional<profession>( id.obj() ) : std::nullopt );
                    const profession_definition_data &source = *entry.definition;
                    profession native;
                    native.id = id;
                    native.was_loaded = true;
                    native._name_male = no_translation( source.name_male );
                    native._name_female = no_translation( source.name_female );
                    native._description_male = no_translation( source.description_male );
                    native._description_female = no_translation( source.description_female );
                    native._point_cost = static_cast<int>( source.points );
                    if( source.starting_cash ) {
                        native._starting_cash = static_cast<int>( *source.starting_cash );
                    }
                    native._starting_npc_background =
                        trait_group::Trait_group_tag( source.npc_background );
                    native._chargen_allow_npc = source.chargen_allow_npc;
                    native.age_lower = static_cast<int>( source.age_lower );
                    native.age_upper = static_cast<int>( source.age_upper );
                    native._starting_vehicle = source.starting_vehicle.empty() ?
                                               vproto_id::NULL_ID() : vproto_id( source.starting_vehicle );
                    native._starting_items = item_group_id( source.items_both );
                    native._starting_items_male = item_group_id( source.items_male );
                    native._starting_items_female = item_group_id( source.items_female );
                    native.no_bonus = itype_id( source.no_bonus );
                    for( const std::string &achievement : source.requirements ) {
                        native._requirements.emplace_back( achievement );
                    }
                    native.hard_requirement = source.hard_requirement;
                    for( const auto &[skill, level] : source.skills ) {
                        native._starting_skills.emplace_back(
                            skill_id( skill ), static_cast<int>( level ) );
                    }
                    for( const profession_addiction_definition_data &value : source.addictions ) {
                        native._starting_addictions.emplace_back(
                            addiction_id( value.type ), static_cast<int>( value.intensity ) );
                    }
                    for( const std::string &bionic : source.cbms ) {
                        native._starting_CBMs.emplace_back( bionic );
                    }
                    for( const std::string &proficiency : source.proficiencies ) {
                        native._starting_proficiencies.emplace_back( proficiency );
                    }
                    for( const std::string &recipe : source.recipes ) {
                        native._starting_recipes.emplace_back( recipe );
                    }
                    for( const profession_trait_definition_data &value : source.traits ) {
                        native._starting_traits.emplace_back(
                            trait_id( value.trait ), value.variant );
                    }
                    for( const std::string &trait : source.forbidden_traits ) {
                        native._forbidden_traits.emplace( trait );
                    }
                    native.flags.insert( source.flags.begin(), source.flags.end() );
                    for( const std::string &hobby : source.hobbies ) {
                        native._hobby_exclusion.emplace( hobby );
                    }
                    native.hobbies_whitelist = source.hobbies_whitelist;
                    for( const std::string &style : source.martial_arts ) {
                        native._starting_martialarts.emplace_back( style );
                    }
                    for( const std::string &style : source.martial_arts_choices ) {
                        native._starting_martialarts_choices.emplace_back( style );
                    }
                    native.ma_choice_amount = static_cast<int>( source.martial_arts_choice_amount );
                    for( const auto &[monster, amount] : source.pets ) {
                        for( std::int64_t count = 0; count < amount; ++count ) {
                            native._starting_pets.emplace_back( monster );
                        }
                    }
                    for( const auto &[spell, level] : source.spells ) {
                        native._starting_spells.emplace(
                            spell_id( spell ), static_cast<int>( level ) );
                    }
                    for( const std::string &mission : source.missions ) {
                        native._missions.emplace_back( mission );
                    }
                    native._subtype = source.subtype;
                    if( !source.start_handler.empty() ) {
                        native.lua_platform_mod = pimpl_->owner;
                        native.lua_platform_start_handler = source.start_handler;
                    }
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    detail::profession_registry().insert( native );
                }
                if( !pimpl_->professions.empty() ) {
                    detail::profession_registry().finalize();
                }
                break;
            }

            case character_content_apply_phase::profession_group: {
                for( const profession_group_registration &entry : pimpl_->profession_groups ) {
                    const profession_group_id id( entry.definition->id );
                    pimpl_->profession_group_undo.emplace_back(
                        id, id.is_valid() ? std::optional<profession_group>( id.obj() ) : std::nullopt );
                    profession_group native;
                    native.id = id;
                    native.was_loaded = true;
                    for( const std::string &profession : entry.definition->professions ) {
                        native.profession_list.emplace_back( profession );
                    }
                    detail::profession_group_registry().insert( native );
                }
                if( !pimpl_->profession_groups.empty() ) {
                    detail::profession_group_registry().finalize();
                }
                break;
            }

            case character_content_apply_phase::widget: {
                for( const widget_registration &entry : pimpl_->widgets ) {
                    const widget_id id( entry.definition->id );
                    pimpl_->widget_undo.emplace_back(
                        id, id.is_valid() ? std::optional<widget>( id.obj() ) : std::nullopt );
                    const widget_definition_data &source = *entry.definition;
                    widget native;
                    native.id = id;
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native._width = static_cast<int>( source.width );
                    native._height_max = static_cast<int>( source.height );
                    native._height = native._height_max;
                    native._symbols = source.symbols;

                    native._fill = source.fill;
                    native._label = no_translation( source.label );
                    native._description = source.description;
                    native._style = source.style;
                    native._arrange = source.arrange;
                    native._body_graph = source.body_graph;
                    native._direction = source.direction.empty() ?
                                        cardinal_direction::num_cardinal_directions :
                                        *io::string_to_enum_optional<cardinal_direction>( source.direction );
                    native._text_align =
                        *io::string_to_enum_optional<widget_alignment>( source.text_align );
                    native._label_align =
                        *io::string_to_enum_optional<widget_alignment>( source.label_align );
                    native._pad_labels = source.pad_labels.value_or(
                                             source.style != "layout" || source.arrange == "rows" );
                    native.explicit_separator = source.separator.has_value();
                    native.explicit_padding = source.padding.has_value();
                    native._separator = source.separator.value_or( ": " );
                    native._padding = static_cast<int>( source.padding.value_or( 2 ) );
                    native._var = source.variable.empty() ? widget_var::last :
                                  *io::string_to_enum_optional<widget_var>( source.variable );
                    for( const std::string &bodypart : source.bodyparts ) {
                        native._bps.emplace( bodypart_str_id( bodypart ).id() );
                    }
                    for( const std::string &color : source.colors ) {
                        native._colors.push_back(
                            color_from_string( color, report_color_error::no ) );
                    }
                    for( const std::int64_t value : source.breaks ) {
                        native._breaks.push_back( static_cast<int>( value ) );
                    }
                    for( const std::string &child : source.widgets ) {
                        native._widgets.emplace_back( child );
                    }
                    for( const std::string &flag : source.flags ) {
                        native._flags.emplace( flag );
                    }
                    native._string = no_translation( source.text );
                    const auto make_clause = [this, &source](
                    const widget_clause_definition_data & value ) {
                        widget_clause result;
                        result.id = value.id;
                        result.sym = value.symbol;
                        result.text = no_translation( value.text );
                        result.color = value.color.empty() ? c_unset :
                                       color_from_string( value.color, report_color_error::no );
                        result.value = static_cast<int>( value.value );
                        result.should_parse_tags = value.parse_tags;
                        for( const std::string &child : value.widgets ) {
                            result.widgets.emplace_back( child );
                        }
                        if( !value.condition_handler.empty() ) {
                            result.has_condition = true;
                            const std::string owner = pimpl_->owner;
                            const std::string widget_name = source.id;
                            const std::string clause_name = value.id;
                            const std::string handler = value.condition_handler;
                            result.condition = [owner, widget_name, clause_name, handler](
                            const const_dialogue & d ) {
                                return invoke_widget_condition_handler(
                                           owner, widget_name, clause_name, handler, d.reason ).value_or( false );
                            };
                        }
                        return result;
                    };
                    for( const widget_clause_definition_data &clause : source.clauses ) {
                        native._clauses.push_back( make_clause( clause ) );
                    }
                    if( source.default_clause ) {
                        native._default_clause = make_clause( *source.default_clause );
                    }
                    if( !source.custom_handler.empty() ) {
                        const std::string owner = pimpl_->owner;
                        const std::string widget_name = source.id;
                        const std::string handler = source.custom_handler;
                        native.platform_custom_value = [owner, widget_name, handler]( const avatar & subject ) {
                            const std::optional<widget_custom_handler_result> value =
                                invoke_widget_custom_handler( owner, widget_name, handler, subject );
                            return value ? value->value : 0;
                        };
                        native.platform_custom_range = [owner, widget_name, handler](
                        const avatar & subject, widget & target ) {
                            const std::optional<widget_custom_handler_result> value =
                                invoke_widget_custom_handler( owner, widget_name, handler, subject );
                            if( value ) {
                                target._var_min = value->minimum;
                                target._var_norm = { value->normal_minimum, value->normal_maximum };
                                target._var_max = value->maximum;
                            }
                        };
                    }
                    native._label_width = native._label.empty() ||
                                          native._flags.count( flag_id( "W_LABEL_NONE" ) ) != 0 ?
                                          0 : utf8_width( native._label.translated() );
                    detail::widget_registry().insert( native );
                }
                if( !pimpl_->widgets.empty() ) {
                    detail::widget_registry().finalize();
                }
                break;
            }

            case character_content_apply_phase::enchantment: {
                for( const enchantment_registration &entry : pimpl_->enchantments ) {
                    const enchantment_id id( entry.definition->id );
                    pimpl_->enchantment_undo.emplace_back(
                        id, id.is_valid() ? std::optional<enchantment>( id.obj() ) : std::nullopt );
                    const enchantment_definition_data &source = *entry.definition;
                    enchantment native;
                    native.id = id;
                    native.was_loaded = true;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.name = no_translation( source.name );
                    native.description = no_translation( source.description );
                    native.active_conditions.first =
                        *io::string_to_enum_optional<enchantment::has>( source.has );
                    native.active_conditions.second =
                        *io::string_to_enum_optional<enchantment::condition>( source.condition );
                    if( !source.condition_handler.empty() ) {
                        const std::string owner = pimpl_->owner;
                        const std::string enchantment_name = source.id;
                        const std::string handler = source.condition_handler;
                        native.dialog_condition = [owner, enchantment_name, handler](

                        const const_dialogue & dialogue ) {
                            return invoke_enchantment_condition_handler(
                                       owner, enchantment_name, "activation", std::string_view(),
                                       handler, dialogue ).value_or( false );
                        };
                    }
                    if( !source.emitter.empty() ) {
                        native.emitter = emit_id( source.emitter );
                    }
                    for( const auto &[effect, intensity] : source.effects ) {
                        native.ench_effects.emplace(
                            efftype_id( effect ), static_cast<int>( intensity ) );
                    }
                    for( const auto &[gain, lose] : source.modified_bodyparts ) {
                        enchantment::bodypart_changes change;
                        change.gain = bodypart_str_id( gain );
                        change.lose = bodypart_str_id( lose );
                        change.was_loaded = true;
                        native.modified_bodyparts.push_back( std::move( change ) );
                    }
                    for( const std::string &mutation : source.mutations ) {
                        native.mutations.emplace_back( mutation );
                    }
                    for( const enchantment_modifier_definition_data &modifier : source.modifiers ) {
                        const auto static_value = []( const std::optional<double> &number,
                        auto & map, const auto & key ) {
                            if( number ) {
                                map.emplace( key, dbl_or_var( *number ) );
                            }
                        };
                        if( modifier.kind == "value" ) {
                            const enchant_vals::mod key =
                                *io::string_to_enum_optional<enchant_vals::mod>( modifier.target );
                            static_value( modifier.add, native.values_add, key );
                            static_value( modifier.multiply, native.values_multiply, key );
                        } else if( modifier.kind == "skill" ) {
                            static_value( modifier.add, native.skill_values_add,
                                          skill_id( modifier.target ) );
                            static_value( modifier.multiply, native.skill_values_multiply,
                                          skill_id( modifier.target ) );
                        } else if( modifier.kind == "custom" ) {
                            static_value( modifier.add, native.custom_values_add, modifier.target );
                            static_value( modifier.multiply, native.custom_values_multiply,
                                          modifier.target );
                        } else if( modifier.kind == "encumbrance" ) {
                            static_value( modifier.add, native.encumbrance_values_add,
                                          bodypart_str_id( modifier.target ) );
                            static_value( modifier.multiply, native.encumbrance_values_multiply,
                                          bodypart_str_id( modifier.target ) );
                        } else if( modifier.kind == "max_hp" ) {
                            static_value( modifier.add, native.max_hp_values_add,
                                          bodypart_str_id( modifier.target ) );
                            static_value( modifier.multiply, native.max_hp_values_multiply,
                                          bodypart_str_id( modifier.target ) );
                        } else if( modifier.kind == "limb_score" ) {
                            enchantment::limb_score_mod_bp value;
                            value.score = limb_score_id( modifier.target );
                            value.part = modifier.part.empty() ? bodypart_str_id::NULL_ID() :
                                         bodypart_str_id( modifier.part );
                            if( modifier.add ) {
                                value.add = *modifier.add;
                            }
                            if( modifier.multiply ) {
                                value.mult = *modifier.multiply;
                            }
                            native.limb_score_mods.push_back( std::move( value ) );
                        } else {
                            std::map<damage_type_id, dbl_or_var> *add_map = nullptr;
                            std::map<damage_type_id, dbl_or_var> *multiply_map = nullptr;
                            if( modifier.kind == "melee_damage" ) {
                                add_map = &native.damage_values_add;
                                multiply_map = &native.damage_values_multiply;
                            } else if( modifier.kind == "incoming_damage" ) {
                                add_map = &native.armor_values_add;
                                multiply_map = &native.armor_values_multiply;
                            } else if( modifier.kind == "post_armor_damage" ) {
                                add_map = &native.extra_damage_add;
                                multiply_map = &native.extra_damage_multiply;
                            }
                            if( add_map != nullptr ) {
                                static_value( modifier.add, *add_map,
                                              damage_type_id( modifier.target ) );
                                static_value( modifier.multiply, *multiply_map,
                                              damage_type_id( modifier.target ) );
                            }
                        }
                        if( !modifier.add_handler.empty() || !modifier.multiply_handler.empty() ) {
                            enchantment::platform_modifier value;
                            value.kind = modifier.kind;
                            value.target = modifier.target;
                            value.part = modifier.part;
                            const std::string owner = pimpl_->owner;
                            const std::string enchantment_name = source.id;
                            if( !modifier.add_handler.empty() ) {
                                const std::string handler = modifier.add_handler;
                                const std::string kind = modifier.kind;
                                const std::string target = modifier.target;
                                const std::string part = modifier.part;
                                value.add = [owner, enchantment_name, kind, target, part, handler](
                                const const_dialogue & dialogue ) {
                                    return invoke_enchantment_number_handler(
                                               owner, enchantment_name, kind + ":add", target, part,
                                               handler, dialogue ).value_or( 0.0 );
                                };
                            }
                            if( !modifier.multiply_handler.empty() ) {
                                const std::string handler = modifier.multiply_handler;
                                const std::string kind = modifier.kind;
                                const std::string target = modifier.target;
                                const std::string part = modifier.part;
                                value.multiply = [owner, enchantment_name, kind, target, part, handler](
                                const const_dialogue & dialogue ) {
                                    return invoke_enchantment_number_handler(
                                               owner, enchantment_name, kind + ":multiply", target, part,
                                               handler, dialogue ).value_or( 0.0 );
                                };
                            }
                            native.platform_modifiers.push_back( std::move( value ) );
                        }
                    }

                    const auto make_fake_spell = []( const enchantment_fake_spell_definition_data & source ) {
                        fake_spell result( spell_id( source.spell ), source.self );
                        if( source.max_level ) {
                            result.max_level = static_cast<int>( *source.max_level );
                        }
                        result.level = static_cast<int>( source.level );
                        result.trigger_once_in = static_cast<int>( source.trigger_once_in );
                        result.trigger_message = no_translation( source.trigger_message );
                        result.npc_trigger_message = no_translation( source.npc_trigger_message );
                        return result;
                    };
                    for( const enchantment_fake_spell_definition_data &spell : source.hit_you_effects ) {
                        native.hit_you_effect.push_back( make_fake_spell( spell ) );
                    }
                    for( const enchantment_fake_spell_definition_data &spell : source.hit_me_effects ) {
                        native.hit_me_effect.push_back( make_fake_spell( spell ) );
                    }
                    for( const auto &[turns, spell] : source.intermittent_effects ) {
                        native.add_activation(
                            time_duration::from_turns( turns ), make_fake_spell( spell ) );
                    }
                    for( const enchantment_vision_definition_data &vision : source.visions ) {
                        enchantment::special_vision value;
                        value.range = dbl_or_var( vision.distance );
                        value.precise = vision.precise;
                        value.ignores_aiming_cone = vision.ignores_aiming_cone;
                        const std::string owner = pimpl_->owner;
                        const std::string enchantment_name = source.id;
                        if( vision.condition_handler.empty() ) {
                            value.condition = []( const const_dialogue & ) {
                                return true;
                            };
                        } else {
                            const std::string handler = vision.condition_handler;
                            value.condition = [owner, enchantment_name, handler](
                            const const_dialogue & dialogue ) {
                                return invoke_enchantment_condition_handler(
                                           owner, enchantment_name, "vision", std::string_view(),
                                           handler, dialogue ).value_or( false );
                            };
                        }
                        if( !vision.distance_handler.empty() ) {
                            const std::string handler = vision.distance_handler;
                            value.platform_range = [owner, enchantment_name, handler](
                            const const_dialogue & dialogue ) {
                                return std::max( 0.0, invoke_enchantment_number_handler(
                                                     owner, enchantment_name, "vision_range",
                                                     std::string_view(), std::string_view(), handler,
                                                     dialogue ).value_or( 0.0 ) );
                            };
                        }
                        for( const enchantment_vision_description_definition_data &description :
                             vision.descriptions ) {
                            enchantment::special_vision_descriptions result;
                            result.id = description.id;
                            result.color = color_from_string(
                                               description.color, report_color_error::no );
                            result.symbol = description.symbol;
                            result.text = description.text;
                            result.description = no_translation( description.text );
                            if( description.condition_handler.empty() ) {
                                result.condition = []( const const_dialogue & ) {
                                    return true;
                                };
                            } else {
                                const std::string handler = description.condition_handler;
                                const std::string description_id = description.id;
                                result.condition = [owner, enchantment_name, handler, description_id](
                                const const_dialogue & dialogue ) {
                                    return invoke_enchantment_condition_handler(
                                               owner, enchantment_name, "vision_description",
                                               description_id, handler, dialogue ).value_or( false );
                                };
                            }
                            value.special_vision_descriptions_vector.push_back( std::move( result ) );
                        }
                        native.special_vision_vector.push_back( std::move( value ) );
                    }
                    detail::enchantment_registry().insert( native );
                }
                if( !pimpl_->enchantments.empty() ) {
                    detail::enchantment_registry().finalize();
                }
                break;
            }

            case character_content_apply_phase::bionic: {
                for( const bionic_registration &entry : pimpl_->bionics ) {
                    const bionic_id id( entry.definition->id );
                    pimpl_->bionic_undo.emplace_back(
                        id, id.is_valid() ? std::optional<bionic_data>( id.obj() ) : std::nullopt );
                    const bionic_definition_data &source = *entry.definition;
                    bionic_data native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native.name = no_translation( source.name );
                    native.description = no_translation( source.description );
                    if( source.cant_remove_reason ) {
                        native.cant_remove_reason = no_translation( *source.cant_remove_reason );
                    }
                    native.power_activate = units::from_millijoule(
                                                source.activation_energy_millijoules );
                    native.power_deactivate = units::from_millijoule(
                                                  source.deactivation_energy_millijoules );
                    native.power_over_time = units::from_millijoule(
                                                 source.over_time_energy_millijoules );
                    native.power_trigger = units::from_millijoule(
                                               source.trigger_energy_millijoules );
                    native.capacity = units::from_millijoule(
                                          source.capacity_energy_millijoules );
                    native.charge_time = time_duration::from_turns( source.charge_time_turns );
                    const auto make_fake_spell = []( const enchantment_fake_spell_definition_data & value ) {
                        fake_spell result( spell_id( value.spell ), value.self );
                        if( value.max_level ) {
                            result.max_level = static_cast<int>( *value.max_level );
                        }
                        result.level = static_cast<int>( value.level );
                        result.trigger_once_in = static_cast<int>( value.trigger_once_in );
                        result.trigger_message = no_translation( value.trigger_message );
                        result.npc_trigger_message = no_translation( value.npc_trigger_message );
                        return result;
                    };

                    if( source.activation_spell ) {
                        native.spell_on_activate = cata::make_value<fake_spell>(
                                                       make_fake_spell( *source.activation_spell ) );
                    }
                    if( !source.power_gen_emission.empty() ) {
                        native.power_gen_emission = emit_id( source.power_gen_emission );
                    }
                    native.fake_weapon = itype_id( source.fake_weapon );
                    native.upgraded_bionic = bionic_id( source.upgraded_bionic );
                    native.required_bionic = bionic_id( source.required_bionic );
                    native.installation_requirement = requirement_id( source.installation_requirement );
                    for( const std::string &material : source.fuel_options ) {
                        native.fuel_opts.emplace_back( material );
                    }
                    for( const std::string &enchantment : source.enchantments ) {
                        native.enchantments.emplace_back( enchantment );
                    }
                    for( const std::string &style : source.martial_arts ) {
                        native.ma_styles.emplace_back( style );
                    }
                    for( const std::string &proficiency : source.proficiencies ) {
                        native.proficiencies.emplace_back( proficiency );
                    }
                    for( const std::string &item : source.passive_pseudo_items ) {
                        native.passive_pseudo_items.emplace_back( item );
                    }
                    for( const std::string &item : source.toggled_pseudo_items ) {
                        native.toggled_pseudo_items.emplace_back( item );
                    }
                    for( const std::string &trait : source.canceled_mutations ) {
                        native.canceled_mutations.emplace_back( trait );
                    }
                    for( const std::string &bionic : source.included_bionics ) {
                        native.included_bionics.emplace_back( bionic );
                    }
                    for( const std::string &bionic : source.auto_deactivated_bionics ) {
                        native.autodeactivated_bionics.emplace_back( bionic );
                    }
                    for( const std::string &flag : source.flags ) {
                        native.flags.insert( json_character_flag( flag ) );
                    }
                    for( const std::string &flag : source.active_flags ) {
                        native.active_flags.insert( json_character_flag( flag ) );
                    }
                    for( const std::string &flag : source.inactive_flags ) {
                        native.inactive_flags.insert( json_character_flag( flag ) );
                    }
                    for( const auto &[bodypart, amount] : source.environment_protection ) {
                        native.env_protec.emplace(
                            bodypart_str_id( bodypart ), static_cast<std::size_t>( amount ) );
                    }
                    for( const bionic_protection_definition_data &protection : source.protection ) {
                        native.protec[bodypart_str_id( protection.bodypart )].set_resist(
                            damage_type_id( protection.damage_type ),
                            static_cast<float>( protection.amount ) );
                    }
                    for( const auto &[bodypart, slots] : source.occupied_bodyparts ) {
                        native.occupied_bodyparts.emplace(
                            bodypart_str_id( bodypart ), static_cast<std::size_t>( slots ) );
                    }
                    for( const auto &[bodypart, amount] : source.encumbrance ) {
                        native.encumbrance.emplace(
                            bodypart_str_id( bodypart ), static_cast<int>( amount ) );
                    }
                    for( const std::string &flag : source.installable_weapon_flags ) {
                        native.installable_weapon_flags.emplace( flag );
                    }
                    for( const std::string &bodypart : source.replaced_bodyparts ) {
                        native.replaced_bodyparts.emplace( bodypart );
                    }
                    for( const std::string &trait : source.mutation_conflicts ) {
                        native.mutation_conflicts.emplace( trait );
                    }
                    for( const std::string &trait : source.give_mutation_on_removal ) {
                        native.give_mut_on_removal.emplace( trait );
                    }
                    for( const auto &[spell, level] : source.learned_spells ) {
                        native.learned_spells.emplace( spell_id( spell ), static_cast<int>( level ) );
                    }
                    for( const std::string &bionic : source.available_upgrades ) {
                        native.available_upgrades.emplace( bionic );
                    }
                    native.fuel_efficiency = static_cast<float>( source.fuel_efficiency );
                    native.passive_fuel_efficiency = static_cast<float>( source.passive_fuel_efficiency );
                    if( source.coverage_power_gen_penalty ) {
                        native.coverage_power_gen_penalty = static_cast<float>(
                                                                *source.coverage_power_gen_penalty );
                    }
                    native.social_mods.lie = static_cast<int>( source.social_lie );
                    native.social_mods.persuade = static_cast<int>( source.social_persuade );
                    native.social_mods.intimidate = static_cast<int>( source.social_intimidate );
                    native.dupes_allowed = source.dupes_allowed;
                    native.activated_on_install = source.activated_on_install;
                    native.included = source.included;
                    native.activate_remove_cbm = source.activate_remove_cbm;
                    native.is_remote_fueled = source.is_remote_fueled;
                    native.exothermic_power_gen = source.exothermic_power_gen;
                    native.activated_close_ui = source.activated_close_ui || source.activate_remove_cbm;
                    native.deactivated_close_ui = source.deactivated_close_ui;
                    static const json_character_flag toggled_flag( "BIONIC_TOGGLED" );
                    static const json_character_flag removable_flag( "BIONIC_REMOVABLE" );
                    static const json_character_flag gun_flag( "BIONIC_GUN" );
                    native.activated = native.has_flag( toggled_flag ) ||
                                       native.has_flag( removable_flag ) ||
                                       native.has_flag( gun_flag ) ||
                                       native.power_activate > 0_kJ ||
                                       native.spell_on_activate ||
                                       native.charge_time > 0_turns;
                    detail::bionic_registry().insert( native );
                }
                if( !pimpl_->bionics.empty() ) {
                    detail::bionic_registry().finalize();
                    detail::refresh_bionic_registry_cache();
                }
                break;
            }

            case character_content_apply_phase::spell: {
                for( const spell_registration &entry : pimpl_->spells ) {
                    const spell_id id( entry.definition->id );
                    pimpl_->spell_undo.emplace_back(
                        id, id.is_valid() ? std::optional<spell_type>( id.obj() ) : std::nullopt );
                    const spell_definition_data &source = *entry.definition;

                    spell_type native;
                    native.id = id;
                    native.src_mod = mod_id( pimpl_->owner );
                    native.src.emplace_back( id, native.src_mod );
                    native.was_loaded = true;
                    native.name = no_translation( source.name );
                    native.description = no_translation( source.description );
                    native.message = no_translation( source.message );
                    native.skill = skill_id( source.skill );
                    native.teachable = source.teachable;
                    native.spell_components = requirement_id( source.components );
                    native.sound_description = no_translation( source.sound_description );
                    native.sound_type = *io::string_to_enum_optional<sounds::sound_t>( source.sound_type );
                    native.sound_ambient = source.sound_ambient;
                    native.sound_id = source.sound_id;
                    native.sound_variant = source.sound_variant;
                    native.effect_name = source.effect;
                    if( source.effect_handler.empty() ) {
                        native.effect = spell_effect::effect_map.at( source.effect );
                    } else {
                        const std::string owner = pimpl_->owner;
                        const std::string spell_name = source.id;
                        const std::string handler = source.effect_handler;
                        native.effect = [owner, spell_name, handler](
                        const spell & cast_spell, Creature & caster, const tripoint_bub_ms & target ) {
                            invoke_spell_effect_handler(
                                owner, spell_name, handler, cast_spell, caster, target );
                        };
                    }
                    native.spell_area = *io::string_to_enum_optional<spell_shape>( source.shape );
                    native.spell_area_function = spell_effect::shape_map.at( native.spell_area );
                    native.effect_str = source.effect_data;
                    native.explosion_light = explosion_light_str_id( source.explosion_light );
                    if( !source.field.empty() ) {
                        native.field = field_type_id( source.field );
                    }
                    native.spell_class = trait_id( source.spell_class );
                    native.dmg_type = damage_type_id( source.damage_type );
                    if( !source.magic_type.empty() ) {
                        native.magic_type = magic_type_id( source.magic_type );
                    }
                    const std::optional<magic_energy_type> energy = source.energy_source.empty() ?
                            std::optional<magic_energy_type>() :
                            io::string_to_enum_optional<magic_energy_type>( source.energy_source );
                    native.set_platform_energy_source(
                        energy,
                        source.energy_vitamin.empty() ? std::optional<vitamin_id>() :
                        std::optional<vitamin_id>( vitamin_id( source.energy_vitamin ) ),
                        energy && *energy == magic_energy_type::vitamin ?
                        std::optional<nc_color>( color_from_string(
                                                     source.energy_color, report_color_error::no ) ) :
                        std::optional<nc_color>() );
                    native.set_platform_progression(
                        source.get_level_formula.empty() ? std::optional<jmath_func_id>() :
                        std::optional<jmath_func_id>( jmath_func_id( source.get_level_formula ) ),
                        source.exp_for_level_formula.empty() ? std::optional<jmath_func_id>() :
                        std::optional<jmath_func_id>( jmath_func_id( source.exp_for_level_formula ) ),
                        source.max_book_level ?
                        std::optional<int>( static_cast<int>( *source.max_book_level ) ) :
                        std::optional<int>() );
                    for( const std::string &target : source.valid_targets ) {
                        native.valid_targets.set(
                            *io::string_to_enum_optional<spell_target>( target ) );
                    }
                    for( const std::string &flag : source.flags ) {
                        native.flags.insert( flag );
                        if( const std::optional<spell_flag> parsed =
                                io::string_to_enum_optional<spell_flag>( flag ) ) {
                            native.spell_tags.set( *parsed );
                        }
                    }
                    for( const std::string &monster : source.targeted_monsters ) {
                        native.targeted_monster_ids.emplace( monster );
                    }
                    for( const std::string &species : source.targeted_species ) {
                        native.targeted_species_ids.emplace( species );
                    }
                    for( const std::string &species : source.ignored_species ) {
                        native.ignored_species_ids.emplace( species );
                    }
                    for( const std::string &bodypart : source.affected_bodyparts ) {
                        native.affected_bps.set( bodypart_str_id( bodypart ) );
                    }
                    const auto make_fake_spell = []( const enchantment_fake_spell_definition_data & value ) {
                        fake_spell result( spell_id( value.spell ), value.self );
                        if( value.max_level ) {
                            result.max_level = static_cast<int>( *value.max_level );
                        }
                        result.level = static_cast<int>( value.level );
                        result.trigger_once_in = static_cast<int>( value.trigger_once_in );
                        result.trigger_message = no_translation( value.trigger_message );
                        result.npc_trigger_message = no_translation( value.npc_trigger_message );
                        return result;
                    };
                    for( const enchantment_fake_spell_definition_data &spell :
                         source.additional_spells ) {
                        native.additional_spells.push_back( make_fake_spell( spell ) );
                    }
                    for( const auto &[spell, level] : source.learned_spells ) {
                        native.learn_spells.emplace( spell, static_cast<int>( level ) );
                    }
                    native.channelling_turns = static_cast<int>( source.channel_turns );
                    native.channel_spell = source.channel_spell;
                    native.channel_end_spell = source.channel_end_spell;
                    native.channel_interrupt_spell = source.channel_interrupt_spell;
                    native.channel_uses_energy = source.channel_uses_energy;
                    if( !source.caster_condition_handler.empty() ) {
                        const std::string owner = pimpl_->owner;
                        const std::string spell_name = source.id;
                        const std::string handler = source.caster_condition_handler;
                        native.has_caster_condition = true;
                        native.caster_condition = [owner, spell_name, handler](
                        const const_dialogue & dialogue ) {
                            return invoke_spell_condition_handler(
                                       owner, spell_name, "caster", handler, dialogue ).value_or( false );
                        };
                    }
                    native.caster_condition_fail_message_ = no_translation(
                            source.caster_condition_fail_message );
                    if( !source.target_condition_handler.empty() ) {

                        const std::string owner = pimpl_->owner;
                        const std::string spell_name = source.id;
                        const std::string handler = source.target_condition_handler;
                        native.has_target_condition = true;
                        native.target_condition = [owner, spell_name, handler](
                        const const_dialogue & dialogue ) {
                            return invoke_spell_condition_handler(
                                       owner, spell_name, "target", handler, dialogue ).value_or( false );
                        };
                    }
                    native.target_condition_fail_message_ = no_translation(
                            source.target_condition_fail_message );
                    const auto make_stat = [&]( const std::string & name ) {
                        dbl_or_var result( source.stats.at( name ) );
                        const auto maximum = source.stat_maximums.find( name );
                        if( maximum != source.stat_maximums.end() ) {
                            result.max.emplace( maximum->second );
                        }
                        const auto dynamic = source.stat_handlers.find( name );
                        if( dynamic != source.stat_handlers.end() ) {
                            const std::string owner = pimpl_->owner;
                            const std::string spell_name = source.id;
                            const std::string handler = dynamic->second;
                            const double fallback = source.stats.at( name );
                            runtime_dbl_provider provider;
                            provider.callback = [owner, spell_name, name, handler, fallback](
                            const const_dialogue & dialogue ) {
                                return invoke_spell_stat_handler(
                                           owner, spell_name, name, handler, dialogue ).value_or( fallback );
                            };
                            result.min.val = std::move( provider );
                        }
                        return result;
                    };
                    native.field_chance = make_stat( "field_chance" );
                    native.min_field_intensity = make_stat( "min_field_intensity" );
                    native.field_intensity_increment = make_stat( "field_intensity_increment" );
                    native.max_field_intensity = make_stat( "max_field_intensity" );
                    native.field_intensity_variance = make_stat( "field_intensity_variance" );
                    native.min_accuracy = make_stat( "min_accuracy" );
                    native.accuracy_increment = make_stat( "accuracy_increment" );
                    native.max_accuracy = make_stat( "max_accuracy" );
                    native.min_damage = make_stat( "min_damage" );
                    native.damage_increment = make_stat( "damage_increment" );
                    native.max_damage = make_stat( "max_damage" );
                    native.min_range = make_stat( "min_range" );
                    native.range_increment = make_stat( "range_increment" );
                    native.max_range = make_stat( "max_range" );
                    native.min_aoe = make_stat( "min_aoe" );
                    native.aoe_increment = make_stat( "aoe_increment" );
                    native.max_aoe = make_stat( "max_aoe" );
                    native.min_dot = make_stat( "min_dot" );
                    native.dot_increment = make_stat( "dot_increment" );
                    native.max_dot = make_stat( "max_dot" );
                    native.min_duration = make_stat( "min_duration" );
                    native.duration_increment = make_stat( "duration_increment" );
                    native.max_duration = make_stat( "max_duration" );
                    native.min_pierce = make_stat( "min_pierce" );
                    native.pierce_increment = make_stat( "pierce_increment" );
                    native.max_pierce = make_stat( "max_pierce" );
                    native.min_bash_scaling = make_stat( "min_bash_scaling" );
                    native.bash_scaling_increment = make_stat( "bash_scaling_increment" );
                    native.max_bash_scaling = make_stat( "max_bash_scaling" );
                    native.base_energy_cost = make_stat( "base_energy_cost" );
                    native.energy_increment = make_stat( "energy_increment" );
                    native.final_energy_cost = make_stat( "final_energy_cost" );
                    native.difficulty = make_stat( "difficulty" );
                    native.multiple_projectiles = make_stat( "multiple_projectiles" );
                    native.max_level = make_stat( "max_level" );
                    native.base_casting_time = make_stat( "base_casting_time" );
                    native.casting_time_increment = make_stat( "casting_time_increment" );
                    native.final_casting_time = make_stat( "final_casting_time" );
                    detail::spell_registry().insert( native );
                }
                if( !pimpl_->spells.empty() ) {
                    detail::spell_registry().finalize();
                }
                break;
            }

            case character_content_apply_phase::mission_definition: {
                for( const mission_definition_registration &entry : pimpl_->mission_definitions ) {
                    const mission_type_id id( entry.definition->id );
                    pimpl_->mission_definition_undo.emplace_back(
                        id, id.is_valid() ? std::optional<mission_type>( id.obj() ) : std::nullopt );
                    const mission_definition_data &source = *entry.definition;
                    mission_type native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native.set_platform_name( source.name );
                    native.description = no_translation( source.description );
                    native.goal = *io::string_to_enum_optional<mission_goal>( source.goal );
                    native.difficulty = static_cast<int>( source.difficulty );
                    native.value = static_cast<int>( source.value );
                    native.urgent = source.urgent;
                    native.has_generic_rewards = source.has_generic_rewards;
                    for( const std::string &origin : source.origins ) {
                        native.origins.push_back(
                            *io::string_to_enum_optional<mission_origin>( origin ) );
                    }
                    native.item_id = source.item.empty() ? itype_id::NULL_ID() : itype_id( source.item );
                    native.group_id = source.item_group.empty() ? item_group_id::NULL_ID() :
                                      item_group_id( source.item_group );
                    native.container_id = source.required_container.empty() ? itype_id::NULL_ID() :
                                          itype_id( source.required_container );
                    native.empty_container = source.empty_container.empty() ? itype_id::NULL_ID() :
                                             itype_id( source.empty_container );
                    native.item_count = static_cast<int>( source.item_count );
                    native.remove_container = source.remove_container;
                    native.invisible_on_complete = source.invisible_on_complete;
                    native.recruit_class = source.recruit_class.empty() ? npc_class_id::NULL_ID() :
                                           npc_class_id( source.recruit_class );
                    native.monster_type = source.monster_type.empty() ? mtype_id::NULL_ID() :
                                          mtype_id( source.monster_type );
                    if( !source.monster_species.empty() ) {
                        native.monster_species = species_id( source.monster_species );
                    }
                    native.monster_kill_goal = static_cast<int>( source.monster_kill_goal );
                    if( !source.destination.empty() ) {
                        native.target_id = oter_type_str_id( source.destination );
                    }
                    native.follow_up = source.followup.empty() ? mission_type_id::NULL_ID() :

                                       mission_type_id( source.followup );
                    for( const auto &[phase, text] : source.dialogue ) {
                        native.dialogue.emplace( phase, no_translation( text ) );
                    }
                    for( const auto &[value, description] : source.likely_rewards ) {
                        native.likely_rewards.emplace_back(
                            dbl_or_var( value ), str_or_var( description ) );
                    }

                    native.deadline = duration_or_var(
                                          time_duration::from_turns( source.deadline_min_turns ) );
                    if( source.deadline_max_turns ) {
                        native.deadline.max.emplace(
                            time_duration::from_turns( *source.deadline_max_turns ) );
                    }
                    if( !source.deadline_handler.empty() ) {
                        const std::string owner = pimpl_->owner;
                        const std::string mission_id = source.id;
                        const std::string handler = source.deadline_handler;
                        runtime_duration_provider provider;
                        provider.callback = [owner, mission_id, handler](
                        const const_dialogue & dialogue ) {
                            return time_duration::from_turns(
                                       invoke_mission_deadline_handler(
                                           owner, mission_id, handler, dialogue ).value_or( 0 ) );
                        };
                        native.deadline.min.val = std::move( provider );
                        native.deadline.max.reset();
                    }

                    if( !source.place_handler.empty() ) {
                        const std::string owner = pimpl_->owner;
                        const std::string mission_id = source.id;
                        const std::string handler = source.place_handler;
                        native.place = [owner, mission_id, handler]( const tripoint_abs_omt & position ) {
                            return invoke_mission_place_handler(
                                       owner, mission_id, handler, position ).value_or( false );
                        };
                    } else if( source.place == "never" ) {
                        native.place = mission_place::never;
                    } else if( source.place == "near_town" ) {
                        native.place = mission_place::near_town;
                    } else {
                        native.place = mission_place::always;
                    }
                    const auto make_phase = [this, &source](
                                                const std::string & phase,
                    const std::string & handler ) {
                        const std::string owner = pimpl_->owner;
                        const std::string mission_id = source.id;
                        return [owner, mission_id, phase, handler]( mission * active_mission ) {
                            invoke_mission_phase_handler(
                                owner, mission_id, phase, handler, active_mission );
                        };
                    };
                    if( !source.start_handler.empty() ) {
                        native.start = make_phase( "start", source.start_handler );
                    }
                    if( !source.end_handler.empty() ) {
                        native.end = make_phase( "success", source.end_handler );
                    }
                    if( !source.fail_handler.empty() ) {
                        native.fail = make_phase( "failure", source.fail_handler );
                    }
                    if( !source.goal_condition_handler.empty() ) {
                        const std::string owner = pimpl_->owner;
                        const std::string mission_id = source.id;
                        const std::string handler = source.goal_condition_handler;
                        native.goal_condition = [owner, mission_id, handler](
                        const const_dialogue & dialogue ) {
                            return invoke_mission_condition_handler(
                                       owner, mission_id, "goal", handler, dialogue ).value_or( false );
                        };
                    }
                    detail::mission_type_registry().insert( native );
                }
                if( !pimpl_->mission_definitions.empty() ) {
                    detail::mission_type_registry().finalize();
                }
                break;
            }
            case character_content_apply_phase::profession_item: {
                if( !pimpl_->profession_item_substitutions.empty() ||
                    !pimpl_->profession_item_bonuses.empty() ) {
                    pimpl_->profession_item_substitution_undo =
                        detail::profession_item_substitution_registry_snapshot();
                }
                for( const profession_item_substitution_registration &entry :
                     pimpl_->profession_item_substitutions ) {
                    detail::profession_item_substitution_native_entry native;
                    native.item = entry.definition->id;
                    native.rules = entry.definition->rules;
                    detail::profession_item_substitution_registry_set( native );
                }
                for( const profession_item_bonus_registration &entry :
                     pimpl_->profession_item_bonuses ) {
                    detail::profession_item_bonus_native_entry native;
                    native.group = entry.definition->id;
                    native.requirements = entry.definition->requirements;
                    detail::profession_item_bonus_registry_set( native );
                }
                break;
            }

            case character_content_apply_phase::technique: {
                for( const technique_registration &entry : pimpl_->techniques ) {
                    const matec_id id( entry.definition->id );
                    pimpl_->technique_undo.emplace_back(
                        id, id.is_valid() ? std::optional<ma_technique>( id.obj() ) :
                        std::nullopt );
                    const technique_definition_data &source = *entry.definition;
                    ma_technique native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.name = no_translation( source.name );
                    native.description = source.description.empty() ? translation() :
                                         no_translation( source.description );
                    if( !source.avatar_message.empty() ) {
                        native.avatar_message = no_translation( source.avatar_message );
                    }
                    if( !source.npc_message.empty() ) {
                        native.npc_message = no_translation( source.npc_message );
                    }
                    native.crit_tec = source.crit_tec;
                    native.crit_ok = source.crit_ok;
                    native.wall_adjacent = source.wall_adjacent;
                    native.reach_tec = source.reach_tec;
                    native.reach_ok = source.reach_ok;
                    native.needs_ammo = source.needs_ammo;
                    native.defensive = source.defensive;
                    native.disarms = source.disarms;
                    native.take_weapon = source.take_weapon;
                    native.side_switch = source.side_switch;
                    native.dummy = source.dummy;
                    native.dodge_counter = source.dodge_counter;
                    native.block_counter = source.block_counter;
                    native.miss_recovery = source.miss_recovery;
                    native.grab_break = source.grab_break;
                    native.weighting = static_cast<int>( source.weighting );
                    native.repeat_min = static_cast<int>( source.repeat_min );
                    native.repeat_max = static_cast<int>( source.repeat_max );
                    native.down_dur = static_cast<int>( source.down_dur );
                    native.stun_dur = static_cast<int>( source.stun_dur );
                    native.knockback_dist = static_cast<int>( source.knockback_dist );
                    native.knockback_spread = static_cast<float>( source.knockback_spread );
                    native.knockback_follow = source.knockback_follow;
                    native.aoe = source.aoe;
                    native.flags = source.flags;
                    native.reqs.unarmed_allowed = source.unarmed_allowed;
                    native.reqs.melee_allowed = source.melee_allowed;
                    native.reqs.strictly_unarmed = source.strictly_unarmed;
                    for( const std::string &vector : source.attack_vectors ) {
                        native.attack_vectors.emplace_back( vector );
                    }
                    for( const auto &[skill, level] : source.min_skills ) {
                        native.reqs.min_skill.emplace_back( skill_id( skill ),
                                                            static_cast<int>( level ) );
                    }
                    native.lua_platform_mod = pimpl_->owner;
                    native.lua_platform_apply_handler = source.apply_handler;
                    native.was_loaded = true;
                    detail::ma_technique_registry().insert( native );
                }
                if( !pimpl_->techniques.empty() ) {
                    detail::ma_technique_registry().finalize();
                }
                break;
            }

            case character_content_apply_phase::martial_art: {
                for( const martial_art_registration &entry : pimpl_->martial_arts ) {
                    const matype_id id( entry.definition->id );
                    pimpl_->martial_art_undo.emplace_back(
                        id, id.is_valid() ? std::optional<martialart>( id.obj() ) :
                        std::nullopt );
                    const martial_art_definition_data &source = *entry.definition;
                    martialart native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.name = no_translation( source.name );
                    native.description = source.description.empty() ? translation() :
                                         no_translation( source.description );
                    if( !source.initiate_avatar.empty() ) {
                        native.initiate.emplace_back( no_translation( source.initiate_avatar ) );
                    }
                    if( !source.initiate_npc.empty() ) {
                        native.initiate.emplace_back( no_translation( source.initiate_npc ) );
                    }
                    native.priority = static_cast<int>( source.priority );
                    native.primary_skill = source.primary_skill.empty() ?
                                           skill_id::NULL_ID() : skill_id( source.primary_skill );
                    native.learn_difficulty = static_cast<int>( source.learn_difficulty );
                    native.teachable = source.teachable;
                    native.arm_block = static_cast<int>( source.arm_block );
                    native.leg_block = static_cast<int>( source.leg_block );
                    native.arm_block_with_bio_armor_arms = source.arm_block_with_bio_armor_arms;
                    native.leg_block_with_bio_armor_legs = source.leg_block_with_bio_armor_legs;
                    native.strictly_unarmed = source.strictly_unarmed;
                    native.strictly_melee = source.strictly_melee;
                    native.allow_all_weapons = source.allow_all_weapons;
                    native.force_unarmed = source.force_unarmed;
                    native.prevent_weapon_blocking = source.prevent_weapon_blocking;
                    for( const auto &[skill, level] : source.autolearn_skills ) {
                        native.autolearn_skills.emplace_back( skill, static_cast<int>( level ) );
                    }
                    for( const std::string &technique : source.techniques ) {
                        native.techniques.insert( matec_id( technique ) );
                    }
                    for( const std::string &weapon : source.weapons ) {
                        native.weapons.insert( itype_id( weapon ) );
                    }
                    for( const std::string &category : source.weapon_categories ) {
                        native.weapon_category.insert( weapon_category_id( category ) );
                    }
                    native.was_loaded = true;
                    detail::martialart_registry().insert( native );
                }
                if( !pimpl_->martial_arts.empty() ) {
                    detail::martialart_registry().finalize();
                }
                break;
            }

            case character_content_apply_phase::magic_type: {
                for( const magic_type_registration &entry : pimpl_->magic_types ) {
                    const magic_type_id id( entry.definition->id );
                    pimpl_->magic_type_undo.emplace_back(
                        id, id.is_valid() ? std::optional<magic_type>( id.obj() ) : std::nullopt );
                    const magic_type_definition_data &source = *entry.definition;
                    magic_type native;
                    native.id = id;
                    native.src_mod = mod_id( pimpl_->owner );
                    native.was_loaded = true;
                    native.energy_source = *platform_magic_energy_type( source.energy_source );
                    if( !source.vitamin.empty() ) {
                        native.vitamin_energy_source_ = vitamin_id( source.vitamin );
                    }
                    native.energy_color_ = color_from_string(
                                               source.energy_color, report_color_error::no );
                    native.cannot_cast_flags = source.cannot_cast_flags;
                    native.cannot_cast_message = source.cannot_cast_message;
                    if( source.max_book_level ) {
                        native.max_book_level = static_cast<int>( *source.max_book_level );
                    }
                    native.failure_cost_percent = source.failure_cost_fraction;
                    native.failure_exp_percent = source.failure_experience_fraction;
                    detail::magic_type_registry().insert( native );
                }
                if( !pimpl_->magic_types.empty() ) {
                    detail::magic_type_registry().finalize();
                }
                break;
            }

            case character_content_apply_phase::movement_mode: {
                for( const movement_mode_registration &entry : pimpl_->movement_modes ) {
                    const move_mode_id id( entry.definition->id );
                    pimpl_->movement_mode_undo.emplace_back(
                        id, id.is_valid() ? std::optional<move_mode>( id.obj() ) : std::nullopt );
                    const movement_mode_definition_data &source = *entry.definition;
                    move_mode native;
                    native.id = id;
                    native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                    native.was_loaded = true;
                    native._name = no_translation( source.name );
                    native._type = *platform_movement_mode_type( source.kind );
                    native._letter = source.character_symbol;
                    native._panel_letter = source.panel_symbol;
                    native._panel_color = color_from_string(
                                              source.panel_color, report_color_error::no );
                    native._symbol_color = color_from_string(
                                               source.symbol_color, report_color_error::no );
                    native._exertion_level = static_cast<float>( source.exertion );
                    native._exertion_level_animal_riding =
                        static_cast<float>( source.riding_exertion );
                    native._stamina_multiplier = static_cast<float>( source.stamina_multiplier );
                    native._sound_multiplier = static_cast<float>( source.sound_multiplier );
                    native._move_speed_mult = static_cast<float>( source.speed_multiplier );
                    native._mech_power_use = static_cast<int>( source.mech_power_kilojoules );
                    native._swim_speed_mod = static_cast<int>( source.swim_speed_modifier );
                    native._stop_hauling = source.stop_hauling;
                    for( const movement_mode_message_definition_data &messages : source.messages ) {
                        const steed_type steed = *platform_steed_type( messages.steed );
                        native.prepare_messages[steed] = no_translation( messages.prepare );
                        native.change_messages_success[steed] = no_translation( messages.success );
                        native.change_messages_fail[steed] = no_translation( messages.failure );
                    }
                    detail::movement_mode_registry().insert( native );
                }
                if( !pimpl_->movement_modes.empty() ) {
                    detail::refresh_movement_mode_registry();
                }
                break;
            }
        }
        ++pimpl_->applied_phase_count;
        if( pimpl_->applied_phase_count ==
            static_cast<std::size_t>( character_content_apply_phase::movement_mode ) + 1 ) {
            pimpl_->applied = true;
        }
        pimpl_->next_apply_phase =
            static_cast<character_content_apply_phase>( pimpl_->applied_phase_count );
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        rollback_all();
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

void character_content_transaction::append_fingerprint(
    const character_content_fingerprint_phase phase, std::uint64_t &state ) const
{
    switch( phase ) {
        case character_content_fingerprint_phase::technique: {
            for( const technique_registration &entry : pimpl_->techniques ) {
                hash_part( state, "technique" );
                hash_part( state, operation_name( entry.operation ) );
                const technique_definition_data &value = *entry.definition;
                hash_part( state, value.id );
                hash_part( state, value.name );
                hash_part( state, value.description );
                hash_part( state, value.avatar_message );
                hash_part( state, value.npc_message );
                hash_part( state, value.crit_tec ? "crit_tec" : "not_crit_tec" );
                hash_part( state, value.crit_ok ? "crit_ok" : "not_crit_ok" );
                hash_part( state, value.wall_adjacent ? "wall_adjacent" : "not_wall_adjacent" );
                hash_part( state, value.reach_tec ? "reach_tec" : "not_reach_tec" );
                hash_part( state, value.reach_ok ? "reach_ok" : "not_reach_ok" );
                hash_part( state, value.needs_ammo ? "needs_ammo" : "no_ammo" );
                hash_part( state, value.defensive ? "defensive" : "offensive" );
                hash_part( state, value.disarms ? "disarms" : "no_disarm" );
                hash_part( state, value.take_weapon ? "take_weapon" : "leave_weapon" );
                hash_part( state, value.side_switch ? "side_switch" : "no_side_switch" );
                hash_part( state, value.dummy ? "dummy" : "real" );
                hash_part( state, value.dodge_counter ? "dodge_counter" : "no_dodge_counter" );
                hash_part( state, value.block_counter ? "block_counter" : "no_block_counter" );
                hash_part( state, value.miss_recovery ? "miss_recovery" : "no_miss_recovery" );
                hash_part( state, value.grab_break ? "grab_break" : "no_grab_break" );
                hash_part( state, std::to_string( value.weighting ) );
                hash_part( state, std::to_string( value.repeat_min ) );
                hash_part( state, std::to_string( value.repeat_max ) );
                hash_part( state, std::to_string( value.down_dur ) );
                hash_part( state, std::to_string( value.stun_dur ) );
                hash_part( state, std::to_string( value.knockback_dist ) );
                hash_part( state, std::to_string( value.knockback_spread ) );
                hash_part( state, value.knockback_follow ? "knockback_follow" : "no_knockback_follow" );
                hash_part( state, value.aoe );
                hash_part( state, value.unarmed_allowed ? "unarmed_allowed" : "no_unarmed" );
                hash_part( state, value.melee_allowed ? "melee_allowed" : "no_melee" );
                hash_part( state, value.strictly_unarmed ? "strict_unarmed" : "not_strict_unarmed" );
                for( const std::string &flag : value.flags ) {
                    hash_part( state, flag );
                }
                for( const std::string &vector : value.attack_vectors ) {
                    hash_part( state, vector );
                }
                for( const auto &[skill, level] : value.min_skills ) {
                    hash_part( state, skill );
                    hash_part( state, std::to_string( level ) );
                }
                hash_part( state, value.apply_handler );
            }
            break;
        }

        case character_content_fingerprint_phase::martial_art: {
            for( const martial_art_registration &entry : pimpl_->martial_arts ) {
                hash_part( state, "martial_art" );
                hash_part( state, operation_name( entry.operation ) );
                const martial_art_definition_data &value = *entry.definition;
                hash_part( state, value.id );
                hash_part( state, value.name );
                hash_part( state, value.description );
                hash_part( state, value.initiate_avatar );
                hash_part( state, value.initiate_npc );
                hash_part( state, std::to_string( value.priority ) );
                hash_part( state, value.primary_skill );
                hash_part( state, std::to_string( value.learn_difficulty ) );
                hash_part( state, value.teachable ? "teachable" : "not_teachable" );
                hash_part( state, std::to_string( value.arm_block ) );
                hash_part( state, std::to_string( value.leg_block ) );
                hash_part( state, value.arm_block_with_bio_armor_arms ? "bio_arm_block" : "no_bio_arm_block" );
                hash_part( state, value.leg_block_with_bio_armor_legs ? "bio_leg_block" : "no_bio_leg_block" );
                hash_part( state, value.strictly_unarmed ? "strict_unarmed" : "not_strict_unarmed" );
                hash_part( state, value.strictly_melee ? "strict_melee" : "not_strict_melee" );
                hash_part( state, value.allow_all_weapons ? "all_weapons" : "limited_weapons" );
                hash_part( state, value.force_unarmed ? "force_unarmed" : "allow_weapon" );
                hash_part( state, value.prevent_weapon_blocking ? "no_weapon_block" : "weapon_block" );
                for( const auto &[skill, level] : value.autolearn_skills ) {
                    hash_part( state, skill );
                    hash_part( state, std::to_string( level ) );
                }
                for( const std::string &technique : value.techniques ) {
                    hash_part( state, technique );
                }
                for( const std::string &weapon : value.weapons ) {
                    hash_part( state, weapon );
                }
                for( const std::string &category : value.weapon_categories ) {
                    hash_part( state, category );
                }
                for( const auto &[phase, handler_id] : value.handlers ) {
                    hash_part( state, phase );
                    hash_part( state, handler_id );
                }
            }
            break;
        }

        case character_content_fingerprint_phase::profession: {
            for( const profession_registration &entry : pimpl_->professions ) {
                hash_part( state, "profession" );
                hash_part( state, operation_name( entry.operation ) );
                const profession_definition_data &value = *entry.definition;
                hash_part( state, value.id );
                hash_part( state, value.name_male );
                hash_part( state, value.name_female );
                hash_part( state, value.description_male );
                hash_part( state, value.description_female );
                hash_part( state, std::to_string( value.points ) );
                hash_part( state, value.starting_cash ?
                           std::to_string( *value.starting_cash ) : "no_starting_cash" );
                hash_part( state, value.npc_background );
                hash_part( state, value.chargen_allow_npc ? "npc" : "no_npc" );
                hash_part( state, std::to_string( value.age_lower ) );
                hash_part( state, std::to_string( value.age_upper ) );
                hash_part( state, value.starting_vehicle );
                hash_part( state, value.items_both );
                hash_part( state, value.items_male );
                hash_part( state, value.items_female );
                hash_part( state, value.no_bonus );
                for( const std::string &achievement : value.requirements ) {
                    hash_part( state, "requirement" );
                    hash_part( state, achievement );
                }
                hash_part( state, value.hard_requirement ? "hard" : "soft" );
                for( const auto &[skill, level] : value.skills ) {
                    hash_part( state, "skill" );
                    hash_part( state, skill );
                    hash_part( state, std::to_string( level ) );
                }
                for( const profession_addiction_definition_data &addiction : value.addictions ) {
                    hash_part( state, "addiction" );
                    hash_part( state, addiction.type );
                    hash_part( state, std::to_string( addiction.intensity ) );
                }
                for( const std::string &bionic : value.cbms ) {
                    hash_part( state, "cbm" );
                    hash_part( state, bionic );
                }
                for( const std::string &proficiency : value.proficiencies ) {
                    hash_part( state, "proficiency" );
                    hash_part( state, proficiency );
                }
                for( const std::string &recipe : value.recipes ) {
                    hash_part( state, "recipe" );
                    hash_part( state, recipe );
                }
                for( const profession_trait_definition_data &trait : value.traits ) {
                    hash_part( state, "trait" );
                    hash_part( state, trait.trait );
                    hash_part( state, trait.variant );
                }
                for( const std::string &trait : value.forbidden_traits ) {
                    hash_part( state, "forbidden_trait" );
                    hash_part( state, trait );
                }
                for( const std::string &flag : value.flags ) {
                    hash_part( state, "flag" );
                    hash_part( state, flag );
                }
                hash_part( state, value.hobbies_whitelist ? "hobby_whitelist" : "hobby_blacklist" );
                for( const std::string &hobby : value.hobbies ) {
                    hash_part( state, hobby );
                }
                for( const std::string &style : value.martial_arts ) {
                    hash_part( state, "martial_art" );
                    hash_part( state, style );
                }
                hash_part( state, std::to_string( value.martial_arts_choice_amount ) );
                for( const std::string &style : value.martial_arts_choices ) {
                    hash_part( state, "martial_art_choice" );
                    hash_part( state, style );
                }
                for( const auto &[monster, amount] : value.pets ) {
                    hash_part( state, "pet" );
                    hash_part( state, monster );
                    hash_part( state, std::to_string( amount ) );
                }
                for( const auto &[spell, level] : value.spells ) {
                    hash_part( state, "spell" );
                    hash_part( state, spell );
                    hash_part( state, std::to_string( level ) );
                }
                for( const std::string &mission : value.missions ) {
                    hash_part( state, "mission" );
                    hash_part( state, mission );
                }
                hash_part( state, value.subtype );
                hash_part( state, value.start_handler );
            }
            break;
        }

        case character_content_fingerprint_phase::profession_group: {
            for( const profession_group_registration &entry : pimpl_->profession_groups ) {
                hash_part( state, "profession_group" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                for( const std::string &profession : entry.definition->professions ) {
                    hash_part( state, profession );
                }
            }
            break;
        }

        case character_content_fingerprint_phase::widget: {
            for( const widget_registration &entry : pimpl_->widgets ) {
                hash_part( state, "widget" );
                hash_part( state, operation_name( entry.operation ) );
                const widget_definition_data &value = *entry.definition;
                hash_part( state, value.id );
                hash_part( state, std::to_string( value.width ) );
                hash_part( state, std::to_string( value.height ) );
                hash_part( state, value.symbols );
                hash_part( state, value.fill );
                hash_part( state, value.label );
                hash_part( state, value.description );
                hash_part( state, value.style );
                hash_part( state, value.arrange );
                hash_part( state, value.body_graph );
                hash_part( state, value.direction );
                hash_part( state, value.text_align );
                hash_part( state, value.label_align );
                hash_part( state, value.pad_labels ?
                           ( *value.pad_labels ? "pad_labels" : "no_pad_labels" ) :
                           "default_pad_labels" );
                hash_part( state, value.separator ? *value.separator : "default_separator" );
                hash_part( state, value.padding ?
                           std::to_string( *value.padding ) : "default_padding" );
                hash_part( state, value.variable );
                hash_part( state, value.custom_handler );
                for( const std::string &bodypart : value.bodyparts ) {
                    hash_part( state, "bodypart" );
                    hash_part( state, bodypart );
                }
                for( const std::string &color : value.colors ) {
                    hash_part( state, "color" );
                    hash_part( state, color );
                }
                for( const std::int64_t threshold : value.breaks ) {
                    hash_part( state, "break" );
                    hash_part( state, std::to_string( threshold ) );
                }
                const auto hash_clause = [&state]( const char *kind,
                const widget_clause_definition_data & clause ) {
                    hash_part( state, kind );
                    hash_part( state, clause.id );
                    hash_part( state, clause.symbol );
                    hash_part( state, clause.text );
                    hash_part( state, clause.color );
                    hash_part( state, std::to_string( clause.value ) );
                    hash_part( state, clause.condition_handler );
                    hash_part( state, clause.parse_tags ? "parse_tags" : "literal_tags" );
                    for( const std::string &child : clause.widgets ) {
                        hash_part( state, child );
                    }
                };
                for( const widget_clause_definition_data &clause : value.clauses ) {
                    hash_clause( "clause", clause );
                }
                if( value.default_clause ) {
                    hash_clause( "default_clause", *value.default_clause );
                }
                hash_part( state, value.text );
                for( const std::string &child : value.widgets ) {
                    hash_part( state, "child" );
                    hash_part( state, child );
                }
                for( const std::string &flag : value.flags ) {
                    hash_part( state, "flag" );
                    hash_part( state, flag );
                }
            }
            break;
        }

        case character_content_fingerprint_phase::enchantment: {
            for( const enchantment_registration &entry : pimpl_->enchantments ) {
                hash_part( state, "enchantment" );
                hash_part( state, operation_name( entry.operation ) );
                const enchantment_definition_data &value = *entry.definition;
                hash_part( state, value.id );
                hash_part( state, value.name );
                hash_part( state, value.description );
                hash_part( state, value.has );
                hash_part( state, value.condition );
                hash_part( state, value.condition_handler );
                hash_part( state, value.emitter );
                for( const auto &[effect, intensity] : value.effects ) {
                    hash_part( state, "effect" );
                    hash_part( state, effect );
                    hash_part( state, std::to_string( intensity ) );
                }
                for( const auto &[gain, lose] : value.modified_bodyparts ) {
                    hash_part( state, "bodypart_change" );
                    hash_part( state, gain );
                    hash_part( state, lose );
                }
                for( const std::string &mutation : value.mutations ) {
                    hash_part( state, "mutation" );
                    hash_part( state, mutation );
                }
                for( const enchantment_modifier_definition_data &modifier : value.modifiers ) {
                    hash_part( state, "modifier" );
                    hash_part( state, modifier.kind );
                    hash_part( state, modifier.target );
                    hash_part( state, modifier.part );
                    hash_part( state, modifier.add ? std::to_string( *modifier.add ) : "no_add" );
                    hash_part( state, modifier.multiply ?

                               std::to_string( *modifier.multiply ) : "no_multiply" );
                    hash_part( state, modifier.add_handler );
                    hash_part( state, modifier.multiply_handler );
                }
                const auto hash_fake_spell = [&state]( const char *kind,
                const enchantment_fake_spell_definition_data & spell ) {
                    hash_part( state, kind );
                    hash_part( state, spell.spell );
                    hash_part( state, spell.max_level ?
                               std::to_string( *spell.max_level ) : "default_max_level" );
                    hash_part( state, std::to_string( spell.level ) );
                    hash_part( state, spell.self ? "self" : "target" );
                    hash_part( state, std::to_string( spell.trigger_once_in ) );
                    hash_part( state, spell.trigger_message );
                    hash_part( state, spell.npc_trigger_message );
                };
                for( const enchantment_fake_spell_definition_data &spell : value.hit_you_effects ) {
                    hash_fake_spell( "hit_you", spell );
                }
                for( const enchantment_fake_spell_definition_data &spell : value.hit_me_effects ) {
                    hash_fake_spell( "hit_me", spell );
                }
                for( const auto &[turns, spell] : value.intermittent_effects ) {
                    hash_part( state, "intermittent" );
                    hash_part( state, std::to_string( turns ) );
                    hash_fake_spell( "spell", spell );
                }
                for( const enchantment_vision_definition_data &vision : value.visions ) {
                    hash_part( state, "vision" );
                    hash_part( state, std::to_string( vision.distance ) );
                    hash_part( state, vision.distance_handler );
                    hash_part( state, vision.condition_handler );
                    hash_part( state, vision.precise ? "precise" : "imprecise" );
                    hash_part( state, vision.ignores_aiming_cone ?
                               "ignores_aiming_cone" : "uses_aiming_cone" );
                    for( const enchantment_vision_description_definition_data &description :
                         vision.descriptions ) {
                        hash_part( state, "vision_description" );
                        hash_part( state, description.id );
                        hash_part( state, description.color );
                        hash_part( state, description.symbol );
                        hash_part( state, description.text );
                        hash_part( state, description.condition_handler );
                    }
                }
            }
            break;
        }

        case character_content_fingerprint_phase::bionic: {
            for( const bionic_registration &entry : pimpl_->bionics ) {
                hash_part( state, "bionic" );
                hash_part( state, operation_name( entry.operation ) );
                const bionic_definition_data &value = *entry.definition;
                hash_part( state, value.id );
                hash_part( state, value.name );
                hash_part( state, value.description );
                hash_part( state, value.cant_remove_reason ?
                           *value.cant_remove_reason : "no_cant_remove_reason" );
                hash_part( state, std::to_string( value.activation_energy_millijoules ) );
                hash_part( state, std::to_string( value.deactivation_energy_millijoules ) );
                hash_part( state, std::to_string( value.over_time_energy_millijoules ) );
                hash_part( state, std::to_string( value.trigger_energy_millijoules ) );
                hash_part( state, std::to_string( value.capacity_energy_millijoules ) );
                hash_part( state, std::to_string( value.charge_time_turns ) );
                if( value.activation_spell ) {
                    const enchantment_fake_spell_definition_data &spell = *value.activation_spell;
                    hash_part( state, "activation_spell" );
                    hash_part( state, spell.spell );
                    hash_part( state, spell.max_level ?
                               std::to_string( *spell.max_level ) : "default_max_level" );
                    hash_part( state, std::to_string( spell.level ) );
                    hash_part( state, spell.self ? "self" : "target" );
                    hash_part( state, std::to_string( spell.trigger_once_in ) );
                    hash_part( state, spell.trigger_message );
                    hash_part( state, spell.npc_trigger_message );
                } else {
                    hash_part( state, "no_activation_spell" );
                }
                hash_part( state, value.power_gen_emission );
                hash_part( state, value.fake_weapon );
                hash_part( state, value.upgraded_bionic );
                hash_part( state, value.required_bionic );
                hash_part( state, value.installation_requirement );
                const auto hash_strings = [&state]( const char *kind,
                const std::vector<std::string> &values ) {
                    for( const std::string &item : values ) {
                        hash_part( state, kind );
                        hash_part( state, item );
                    }
                };
                hash_strings( "fuel", value.fuel_options );
                hash_strings( "enchantment", value.enchantments );
                hash_strings( "martial_art", value.martial_arts );
                hash_strings( "proficiency", value.proficiencies );
                hash_strings( "passive_item", value.passive_pseudo_items );
                hash_strings( "toggled_item", value.toggled_pseudo_items );
                hash_strings( "canceled_mutation", value.canceled_mutations );
                hash_strings( "included_bionic", value.included_bionics );
                hash_strings( "auto_deactivated_bionic", value.auto_deactivated_bionics );
                hash_strings( "flag", value.flags );
                hash_strings( "active_flag", value.active_flags );
                hash_strings( "inactive_flag", value.inactive_flags );
                for( const auto &[bodypart, amount] : value.environment_protection ) {
                    hash_part( state, "environment_protection" );
                    hash_part( state, bodypart );
                    hash_part( state, std::to_string( amount ) );
                }
                for( const bionic_protection_definition_data &protection : value.protection ) {
                    hash_part( state, "protection" );
                    hash_part( state, protection.bodypart );
                    hash_part( state, protection.damage_type );
                    hash_part( state, std::to_string( protection.amount ) );
                }
                for( const auto &[bodypart, slots] : value.occupied_bodyparts ) {
                    hash_part( state, "occupied_bodypart" );
                    hash_part( state, bodypart );
                    hash_part( state, std::to_string( slots ) );
                }
                for( const auto &[bodypart, amount] : value.encumbrance ) {
                    hash_part( state, "encumbrance" );
                    hash_part( state, bodypart );
                    hash_part( state, std::to_string( amount ) );
                }

                hash_strings( "installable_weapon_flag", value.installable_weapon_flags );
                hash_strings( "replaced_bodypart", value.replaced_bodyparts );
                hash_strings( "mutation_conflict", value.mutation_conflicts );
                hash_strings( "removal_mutation", value.give_mutation_on_removal );
                for( const auto &[spell, level] : value.learned_spells ) {
                    hash_part( state, "learned_spell" );
                    hash_part( state, spell );
                    hash_part( state, std::to_string( level ) );
                }
                hash_strings( "available_upgrade", value.available_upgrades );
                hash_part( state, std::to_string( value.fuel_efficiency ) );
                hash_part( state, std::to_string( value.passive_fuel_efficiency ) );
                hash_part( state, value.coverage_power_gen_penalty ?
                           std::to_string( *value.coverage_power_gen_penalty ) :
                           "no_coverage_power_gen_penalty" );
                hash_part( state, std::to_string( value.social_lie ) );
                hash_part( state, std::to_string( value.social_persuade ) );
                hash_part( state, std::to_string( value.social_intimidate ) );
                hash_part( state, value.dupes_allowed ? "dupes_allowed" : "no_dupes" );
                hash_part( state, value.activated_on_install ?
                           "activated_on_install" : "not_activated_on_install" );
                hash_part( state, value.included ? "included" : "not_included" );
                hash_part( state, value.activate_remove_cbm ?
                           "activate_remove_cbm" : "no_activate_remove_cbm" );
                hash_part( state, value.is_remote_fueled ?
                           "remote_fueled" : "not_remote_fueled" );
                hash_part( state, value.exothermic_power_gen ?
                           "exothermic" : "not_exothermic" );
                hash_part( state, value.activated_close_ui ?
                           "activated_close_ui" : "keep_ui_on_activation" );
                hash_part( state, value.deactivated_close_ui ?
                           "deactivated_close_ui" : "keep_ui_on_deactivation" );
            }
            break;
        }

        case character_content_fingerprint_phase::spell: {
            for( const spell_registration &entry : pimpl_->spells ) {
                hash_part( state, "spell" );
                hash_part( state, operation_name( entry.operation ) );
                const spell_definition_data &value = *entry.definition;
                hash_part( state, value.id );
                hash_part( state, value.name );
                hash_part( state, value.description );
                hash_part( state, value.message );
                hash_part( state, value.skill );
                hash_part( state, value.magic_type );
                hash_part( state, value.components );
                hash_part( state, value.sound_description );
                hash_part( state, value.sound_type );
                hash_part( state, value.sound_ambient ? "ambient" : "nonambient" );
                hash_part( state, value.sound_id );
                hash_part( state, value.sound_variant );
                hash_part( state, value.effect );
                hash_part( state, value.effect_handler );
                hash_part( state, value.shape );
                hash_part( state, value.effect_data );
                hash_part( state, value.explosion_light );
                hash_part( state, value.field );
                hash_part( state, value.spell_class );
                hash_part( state, value.energy_source );
                hash_part( state, value.energy_vitamin );
                hash_part( state, value.energy_color );
                hash_part( state, value.damage_type );
                hash_part( state, value.get_level_formula );
                hash_part( state, value.exp_for_level_formula );
                hash_part( state, value.max_book_level ?
                           std::to_string( *value.max_book_level ) : "no_max_book_level" );
                hash_part( state, value.caster_condition_handler );
                hash_part( state, value.caster_condition_fail_message );
                hash_part( state, value.target_condition_handler );
                hash_part( state, value.target_condition_fail_message );
                const auto hash_spell_strings = [&state]( const char *kind,
                const std::vector<std::string> &values ) {
                    for( const std::string &item : values ) {
                        hash_part( state, kind );
                        hash_part( state, item );
                    }
                };
                hash_spell_strings( "target", value.valid_targets );
                hash_spell_strings( "flag", value.flags );
                hash_spell_strings( "targeted_monster", value.targeted_monsters );
                hash_spell_strings( "targeted_species", value.targeted_species );
                hash_spell_strings( "ignored_species", value.ignored_species );
                hash_spell_strings( "bodypart", value.affected_bodyparts );
                for( const enchantment_fake_spell_definition_data &spell : value.additional_spells ) {
                    hash_part( state, "additional_spell" );
                    hash_part( state, spell.spell );
                    hash_part( state, spell.max_level ?
                               std::to_string( *spell.max_level ) : "default_max_level" );
                    hash_part( state, std::to_string( spell.level ) );
                    hash_part( state, spell.self ? "self" : "target" );
                    hash_part( state, std::to_string( spell.trigger_once_in ) );
                    hash_part( state, spell.trigger_message );
                    hash_part( state, spell.npc_trigger_message );
                }
                for( const auto &[spell, level] : value.learned_spells ) {
                    hash_part( state, "learned_spell" );
                    hash_part( state, spell );
                    hash_part( state, std::to_string( level ) );
                }
                hash_part( state, std::to_string( value.channel_turns ) );
                hash_part( state, value.channel_spell );
                hash_part( state, value.channel_end_spell );
                hash_part( state, value.channel_interrupt_spell );
                hash_part( state, value.channel_uses_energy ?
                           "channel_uses_energy" : "free_channel" );
                hash_part( state, value.teachable ? "teachable" : "unteachable" );
                for( const auto &[stat, number] : value.stats ) {
                    hash_part( state, stat );
                    hash_part( state, std::to_string( number ) );
                    const auto maximum = value.stat_maximums.find( stat );
                    hash_part( state, maximum == value.stat_maximums.end() ?
                               "no_maximum" : std::to_string( maximum->second ) );
                    const auto handler = value.stat_handlers.find( stat );
                    hash_part( state, handler == value.stat_handlers.end() ?
                               "static" : handler->second );
                }
            }
            break;
        }

        case character_content_fingerprint_phase::mission_definition: {
            for( const mission_definition_registration &entry : pimpl_->mission_definitions ) {
                hash_part( state, "mission_definition" );
                hash_part( state, operation_name( entry.operation ) );
                const mission_definition_data &value = *entry.definition;
                hash_part( state, value.id );

                hash_part( state, value.name );
                hash_part( state, value.description );
                hash_part( state, value.goal );
                hash_part( state, std::to_string( value.difficulty ) );
                hash_part( state, std::to_string( value.value ) );
                hash_part( state, std::to_string( value.deadline_min_turns ) );
                hash_part( state, value.deadline_max_turns ?
                           std::to_string( *value.deadline_max_turns ) : "no_deadline_maximum" );
                hash_part( state, value.deadline_handler );
                hash_part( state, value.urgent ? "urgent" : "not_urgent" );
                hash_part( state, value.has_generic_rewards ?
                           "generic_rewards" : "no_generic_rewards" );
                for( const std::string &origin : value.origins ) {
                    hash_part( state, "origin" );
                    hash_part( state, origin );
                }
                hash_part( state, value.item );
                hash_part( state, value.item_group );
                hash_part( state, value.required_container );
                hash_part( state, value.empty_container );
                hash_part( state, std::to_string( value.item_count ) );
                hash_part( state, value.remove_container ?
                           "remove_container" : "keep_container" );
                hash_part( state, value.invisible_on_complete ?
                           "invisible_on_complete" : "visible_on_complete" );
                hash_part( state, value.recruit_class );
                hash_part( state, value.monster_type );
                hash_part( state, value.monster_species );
                hash_part( state, std::to_string( value.monster_kill_goal ) );
                hash_part( state, value.destination );
                hash_part( state, value.followup );
                hash_part( state, value.place );
                hash_part( state, value.place_handler );
                hash_part( state, value.start_handler );
                hash_part( state, value.end_handler );
                hash_part( state, value.fail_handler );
                hash_part( state, value.goal_condition_handler );
                for( const auto &[phase, text] : value.dialogue ) {
                    hash_part( state, phase );
                    hash_part( state, text );
                }
                for( const auto &[reward, description] : value.likely_rewards ) {
                    hash_part( state, "likely_reward" );
                    hash_part( state, std::to_string( reward ) );
                    hash_part( state, description );
                }
            }
            break;
        }

        case character_content_fingerprint_phase::profession_item: {
            for( const profession_item_substitution_registration &entry :
                 pimpl_->profession_item_substitutions ) {
                hash_part( state, "profession_item_substitution" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                for( const detail::profession_item_substitution_native_rule &rule :
                     entry.definition->rules ) {
                    for( const std::string &trait : rule.requirements.present ) {
                        hash_part( state, "present" );
                        hash_part( state, trait );
                    }
                    for( const std::string &trait : rule.requirements.absent ) {
                        hash_part( state, "absent" );
                        hash_part( state, trait );
                    }
                    for( const detail::profession_item_substitution_native_replacement &replacement :
                         rule.replacements ) {
                        hash_part( state, replacement.item );
                        hash_part( state, std::to_string( replacement.ratio ) );
                    }
                }
            }
            for( const profession_item_bonus_registration &entry : pimpl_->profession_item_bonuses ) {
                hash_part( state, "profession_item_bonus" );
                hash_part( state, operation_name( entry.operation ) );
                hash_part( state, entry.definition->id );
                for( const detail::profession_item_substitution_native_requirement &requirements :
                     entry.definition->requirements ) {
                    for( const std::string &trait : requirements.present ) {
                        hash_part( state, "present" );
                        hash_part( state, trait );
                    }
                    for( const std::string &trait : requirements.absent ) {
                        hash_part( state, "absent" );
                        hash_part( state, trait );
                    }
                }
            }
            break;
        }

        case character_content_fingerprint_phase::magic_type: {
            for( const magic_type_registration &entry : pimpl_->magic_types ) {
                hash_part( state, "magic_type" );
                hash_part( state, operation_name( entry.operation ) );
                const magic_type_definition_data &value = *entry.definition;
                hash_part( state, value.id );
                hash_part( state, value.energy_source );
                hash_part( state, value.vitamin );
                hash_part( state, value.energy_color );
                hash_part( state, value.cannot_cast_message.value_or( "no_message" ) );
                hash_part( state, value.max_book_level ?
                           std::to_string( *value.max_book_level ) : "no_book_limit" );
                hash_part( state, std::to_string( value.failure_cost_fraction ) );
                hash_part( state, std::to_string( value.failure_experience_fraction ) );
                for( const std::string &flag : value.cannot_cast_flags ) {
                    hash_part( state, flag );
                }
                hash_part( state, value.level_for_experience_handler );
                hash_part( state, value.experience_for_level_handler );
                hash_part( state, value.casting_experience_handler );
                hash_part( state, value.failure_chance_handler );
                hash_part( state, value.failure_cost_handler );
                hash_part( state, value.failure_experience_handler );
                hash_part( state, value.failure_handler );
            }
            break;
        }

        case character_content_fingerprint_phase::movement_mode: {
            for( const movement_mode_registration &entry : pimpl_->movement_modes ) {
                hash_part( state, "movement_mode" );
                hash_part( state, operation_name( entry.operation ) );
                const movement_mode_definition_data &value = *entry.definition;
                hash_part( state, value.id );
                hash_part( state, value.name );
                hash_part( state, value.kind );
                hash_part( state, std::to_string( value.character_symbol ) );
                hash_part( state, std::to_string( value.panel_symbol ) );
                hash_part( state, value.panel_color );
                hash_part( state, value.symbol_color );
                hash_part( state, std::to_string( value.exertion ) );
                hash_part( state, std::to_string( value.riding_exertion ) );
                hash_part( state, std::to_string( value.stamina_multiplier ) );
                hash_part( state, std::to_string( value.sound_multiplier ) );
                hash_part( state, std::to_string( value.speed_multiplier ) );
                hash_part( state, std::to_string( value.mech_power_kilojoules ) );
                hash_part( state, std::to_string( value.swim_speed_modifier ) );
                hash_part( state, value.stop_hauling ? "stop_hauling" : "keep_hauling" );
                for( const movement_mode_message_definition_data &messages : value.messages ) {
                    hash_part( state, messages.steed );
                    hash_part( state, messages.prepare );
                    hash_part( state, messages.success );
                    hash_part( state, messages.failure );
                }
            }
            break;
        }
    }
}

bool character_content_transaction::was_applied() const
{
    return pimpl_->applied;
}

#define CATA_CHARACTER_DEFINES( name, member ) \
    bool character_content_transaction::name( const std::string_view id ) const { \
        return registration_id_exists( pimpl_->member, id ); \
    }
CATA_CHARACTER_DEFINES( defines_profession, professions )
CATA_CHARACTER_DEFINES( defines_profession_group, profession_groups )
CATA_CHARACTER_DEFINES( defines_widget, widgets )
CATA_CHARACTER_DEFINES( defines_enchantment, enchantments )
CATA_CHARACTER_DEFINES( defines_bionic, bionics )
CATA_CHARACTER_DEFINES( defines_spell, spells )
CATA_CHARACTER_DEFINES( defines_mission_definition, mission_definitions )
CATA_CHARACTER_DEFINES( defines_profession_item_substitution, profession_item_substitutions )
CATA_CHARACTER_DEFINES( defines_profession_item_bonus, profession_item_bonuses )
CATA_CHARACTER_DEFINES( defines_technique, techniques )
CATA_CHARACTER_DEFINES( defines_martial_art, martial_arts )
CATA_CHARACTER_DEFINES( defines_magic_type, magic_types )
CATA_CHARACTER_DEFINES( defines_movement_mode, movement_modes )
#undef CATA_CHARACTER_DEFINES

bool character_content_transaction::find_magic_type_handler(
    const std::string_view magic_type_id, const std::string_view phase,
    std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->magic_types.rbegin(),
                                     pimpl_->magic_types.rend(),
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

bool character_content_transaction::find_martial_art_handler(
    const std::string_view martial_art_id, const std::string_view phase,
    std::string &handler_id ) const
{
    const auto found = std::find_if( pimpl_->martial_arts.rbegin(),
                                     pimpl_->martial_arts.rend(),
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

} // namespace cata::lua_platform

#else

namespace cata::lua_platform
{

struct character_content_transaction::impl {};

character_content_transaction::character_content_transaction( std::string, std::size_t ) :
    pimpl_( std::make_unique<impl>() )
{}

character_content_transaction::~character_content_transaction() = default;

bool character_content_transaction::validate( const runtime &, bool,
        const character_content_validation_index &, std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool character_content_transaction::apply_phase( character_content_apply_phase,
        std::string &error )
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool character_content_transaction::validate_finalized( std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

void character_content_transaction::rollback_phase( character_content_rollback_phase ) {}
void character_content_transaction::rollback_all() {}
void character_content_transaction::commit() {}
void character_content_transaction::seal() {}
void character_content_transaction::discard() {}
void character_content_transaction::append_fingerprint(
    character_content_fingerprint_phase, std::uint64_t & ) const {}
bool character_content_transaction::was_applied() const
{
    return false;
}

#define CATA_CHARACTER_FALSE_QUERY( name ) \
    bool character_content_transaction::name( std::string_view ) const { return false; }
CATA_CHARACTER_FALSE_QUERY( defines_profession )
CATA_CHARACTER_FALSE_QUERY( defines_profession_group )
CATA_CHARACTER_FALSE_QUERY( defines_widget )
CATA_CHARACTER_FALSE_QUERY( defines_enchantment )
CATA_CHARACTER_FALSE_QUERY( defines_bionic )
CATA_CHARACTER_FALSE_QUERY( defines_spell )
CATA_CHARACTER_FALSE_QUERY( defines_mission_definition )
CATA_CHARACTER_FALSE_QUERY( defines_profession_item_substitution )
CATA_CHARACTER_FALSE_QUERY( defines_profession_item_bonus )
CATA_CHARACTER_FALSE_QUERY( defines_technique )
CATA_CHARACTER_FALSE_QUERY( defines_martial_art )
CATA_CHARACTER_FALSE_QUERY( defines_magic_type )
CATA_CHARACTER_FALSE_QUERY( defines_movement_mode )
#undef CATA_CHARACTER_FALSE_QUERY

bool character_content_transaction::find_magic_type_handler(
    std::string_view, std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

bool character_content_transaction::find_martial_art_handler(
    std::string_view, std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
