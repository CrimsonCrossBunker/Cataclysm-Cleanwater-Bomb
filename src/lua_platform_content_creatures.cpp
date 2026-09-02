#include "lua_platform_content_creatures.h"

#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <cmath>
#include <cstdint>
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

#include "anatomy.h"
#include "behavior.h"
#include "behavior_oracle.h"
#include "behavior_strategy.h"
#include "bodygraph.h"
#include "bodypart.h"
#include "calendar.h"
#include "color.h"
#include "damage.h"
#include "dialogue.h"
#include "disease.h"
#include "effect.h"
#include "emit.h"
#include "enum_conversions.h"
#include "field_type.h"
#include "game.h"
#include "generic_factory.h"
#include "magic_type.h"
#include "mtype.h"
#include "mattack_actors.h"
#include "mattack_common.h"
#include "mondefense.h"
#include "monfaction.h"
#include "monstergenerator.h"
#include "morale_types.h"
#include "mutation.h"
#include "npc.h"
#include "point.h"
#include "profession.h"
#include "rng.h"
#include "subbodypart.h"
#include "translation.h"
#include "type_id.h"
#include "units.h"
#include "weakpoint.h"
#include "wound.h"

namespace cata::lua_platform
{

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

// C++17 cannot name an abbreviated function parameter before the local token
// definition.  Keep the actual overloads below close to the handle types.
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
bool defines_registration( const std::vector<std::pair<definition_operation,
                           std::shared_ptr<Definition>>> &entries,
                           const std::string_view id )
{
    return std::any_of( entries.begin(), entries.end(), [id]( const auto & entry ) {
        return entry.second && entry.second->id == id;
    } );
}

template<typename Definition>
struct catalog_registration {
    definition_operation operation = definition_operation::add;
    std::shared_ptr<Definition> definition;
};

template<typename Registration>
bool has_id( const std::vector<Registration> &entries, const std::string_view id )
{
    return std::any_of( entries.begin(), entries.end(), [id]( const Registration & entry ) {
        return entry.definition && entry.definition->id == id;
    } );
}

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

} // namespace

// Original runtime definition block 1
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



// Original runtime definition block 2
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

// Original runtime definition block 3
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


// Original runtime handle block 1
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



// Original runtime handle block 2
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



// Original runtime handle block 3
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

using behavior_registration = catalog_registration<behavior_definition_data>;
using effect_type_registration = catalog_registration<effect_type_definition_data>;
using monster_attack_registration = catalog_registration<monster_attack_definition_data>;
using weakpoint_set_registration = catalog_registration<weakpoint_set_definition_data>;
using field_type_registration = catalog_registration<field_type_definition_data>;
using sub_body_part_registration = catalog_registration<sub_body_part_definition_data>;
using wound_type_registration = catalog_registration<wound_type_definition_data>;
using body_part_registration = catalog_registration<body_part_definition_data>;
using wound_fix_registration = catalog_registration<wound_fix_definition_data>;
using anatomy_registration = catalog_registration<anatomy_definition_data>;
using body_graph_registration = catalog_registration<body_graph_definition_data>;
using monster_registration = catalog_registration<monster_definition_data>;
using morale_type_registration = catalog_registration<morale_type_definition_data>;
using disease_type_registration = catalog_registration<disease_type_definition_data>;
using monster_flag_registration = catalog_registration<monster_flag_definition_data>;
using species_registration = catalog_registration<species_definition_data>;
using emission_registration = catalog_registration<emission_definition_data>;
using monster_faction_registration = catalog_registration<monster_faction_definition_data>;
using mutation_type_registration = catalog_registration<mutation_type_definition_data>;
using connect_group_registration = catalog_registration<connect_group_definition_data>;
using mutation_category_registration = catalog_registration<mutation_category_definition_data>;
using mutation_registration = catalog_registration<mutation_definition_data>;

struct creatures_content_transaction::impl {
    impl( std::string owner_id, const std::size_t owner_generation ) :
        owner( std::move( owner_id ) ), generation( owner_generation ),
        token( std::make_shared<owner_token>( owner_token{ owner, generation,
                                              handle_lifecycle::building } ) ) {}

    std::string owner;
    std::size_t generation = 0;
    std::shared_ptr<owner_token> token;

    // Registration order is part of the Lua-first contract.  Keep one vector
    // per native catalogue so edit() replaces the latest staged definition.
    std::vector<behavior_registration> behaviors;
    std::vector<effect_type_registration> effect_types;
    std::vector<monster_attack_registration> monster_attacks;
    std::vector<weakpoint_set_registration> weakpoint_sets;
    std::vector<field_type_registration> field_types;
    std::vector<sub_body_part_registration> sub_body_parts;
    std::vector<wound_type_registration> wound_types;
    std::vector<body_part_registration> body_parts;
    std::vector<wound_fix_registration> wound_fixes;
    std::vector<anatomy_registration> anatomies;
    std::vector<body_graph_registration> body_graphs;
    std::vector<monster_registration> monsters;
    std::vector<morale_type_registration> morale_types;
    std::vector<disease_type_registration> disease_types;
    std::vector<monster_flag_registration> monster_flags;
    std::vector<species_registration> species;
    std::vector<emission_registration> emissions;
    std::vector<monster_faction_registration> monster_factions;
    std::vector<mutation_type_registration> mutation_types;
    std::vector<connect_group_registration> connect_groups;
    std::vector<mutation_category_registration> mutation_categories;
    std::vector<mutation_registration> mutations;

    std::vector<std::pair<string_id<behavior::node_t>,
        std::optional<behavior::node_t>>> behavior_undo;
    std::vector<std::pair<std::string, std::optional<effect_type>>> effect_type_undo;
    std::vector<std::pair<std::string, std::optional<mtype_special_attack>>>
    monster_attack_undo;
    std::vector<std::pair<weakpoints_id, std::optional<weakpoints>>> weakpoint_set_undo;
    std::vector<std::pair<field_type_str_id, std::optional<field_type>>> field_type_undo;
    std::vector<std::pair<sub_bodypart_str_id, std::optional<sub_body_part_type>>>
    sub_body_part_undo;
    std::vector<std::pair<wound_type_id, std::optional<wound_type>>> wound_type_undo;
    std::vector<std::pair<bodypart_str_id, std::optional<body_part_type>>> body_part_undo;
    std::vector<std::pair<wound_fix_id, std::optional<wound_fix>>> wound_fix_undo;
    std::vector<std::pair<anatomy_id, std::optional<anatomy>>> anatomy_undo;
    std::vector<std::pair<bodygraph_id, std::optional<bodygraph>>> body_graph_undo;
    std::vector<std::pair<mtype_id, std::optional<mtype>>> monster_undo;
    std::vector<std::pair<morale_type, std::optional<morale_type_data>>> morale_type_undo;
    std::vector<std::pair<diseasetype_id, std::optional<disease_type>>> disease_type_undo;
    std::vector<std::pair<mon_flag_str_id, std::optional<mon_flag>>> monster_flag_undo;
    std::vector<std::pair<species_id, std::optional<species_type>>> species_undo;
    std::vector<std::pair<std::string, std::optional<emit>>> emission_undo;
    std::vector<std::pair<mfaction_str_id, std::optional<monfaction>>>
    monster_faction_undo;
    std::vector<std::pair<std::string, bool>> mutation_type_undo;
    std::vector<std::pair<std::string, std::optional<connect_group>>> connect_group_undo;
    std::vector<std::pair<std::string, std::optional<mutation_category_trait>>>
    mutation_category_undo;
    std::vector<std::pair<trait_id, std::optional<mutation_branch>>> mutation_undo;

    creatures_content_apply_phase next_apply_phase =
        creatures_content_apply_phase::foundations;
    mutable bool finalization_validated = false;
    bool wound_fix_registry_dirty = false;
    bool wound_fix_links_dirty = false;
    bool applied = false;
};

creatures_content_transaction::creatures_content_transaction( std::string owner,
        const std::size_t generation ) :
    pimpl_( std::make_unique<impl>( std::move( owner ), generation ) )
{}

creatures_content_transaction::~creatures_content_transaction() = default;

void creatures_content_transaction::install_lua_api( sol::state &lua, sol::table &ccb,
        sol::table &content )
{
    ccb.new_usertype<behavior_definition_handle>(
        "BehaviorDefinition", sol::no_constructor,
        "id", sol::property( &behavior_definition_handle::id ),
        "child", &behavior_definition_handle::child,
        "when", &behavior_definition_handle::when,
        "when_native", &behavior_definition_handle::when_native,
        "score", &behavior_definition_handle::score,
        "score_native", &behavior_definition_handle::score_native );
    ccb.new_usertype<effect_type_definition_handle>(
        "EffectTypeDefinition", sol::no_constructor,
        "id", sol::property( &effect_type_definition_handle::id ),
        "name", &effect_type_definition_handle::name,
        "description", &effect_type_definition_handle::description,
        "reduced_description", &effect_type_definition_handle::reduced_description,
        "flag", &effect_type_definition_handle::flag,
        "immune_character_flag", &effect_type_definition_handle::immune_character_flag,
        "immune_bodypart_flag", &effect_type_definition_handle::immune_bodypart_flag,
        "resist_trait", &effect_type_definition_handle::resist_trait,
        "resist_effect", &effect_type_definition_handle::resist_effect,
        "removes_effect", &effect_type_definition_handle::removes_effect,
        "blocks_effect", &effect_type_definition_handle::blocks_effect );
    ccb.new_usertype<monster_attack_definition_handle>(
        "MonsterAttackDefinition", sol::no_constructor,
        "id", sol::property( &monster_attack_definition_handle::id ),
        "policy", &monster_attack_definition_handle::policy );
    ccb.new_usertype<weakpoint_set_definition_handle>(
        "WeakpointSetDefinition", sol::no_constructor,
        "id", sol::property( &weakpoint_set_definition_handle::id ),
        "weakpoint", &weakpoint_set_definition_handle::weakpoint,
        "armor_multiplier", &weakpoint_set_definition_handle::armor_multiplier,
        "armor_penalty", &weakpoint_set_definition_handle::armor_penalty,
        "damage_multiplier", &weakpoint_set_definition_handle::damage_multiplier,
        "critical_multiplier", &weakpoint_set_definition_handle::critical_multiplier,
        "effect", &weakpoint_set_definition_handle::effect );
    ccb.new_usertype<field_type_definition_handle>(
        "FieldTypeDefinition", sol::no_constructor,
        "id", sol::property( &field_type_definition_handle::id ),
        "intensity", &field_type_definition_handle::intensity,
        "effect", &field_type_definition_handle::effect,
        "immune_monster", &field_type_definition_handle::immune_monster,
        "block_monster", &field_type_definition_handle::block_monster );
    ccb.new_usertype<sub_body_part_definition_handle>(
        "SubBodyPartDefinition", sol::no_constructor,
        "id", sol::property( &sub_body_part_definition_handle::id ),
        "location_under", &sub_body_part_definition_handle::location_under,
        "unarmed_damage", &sub_body_part_definition_handle::unarmed_damage );
    ccb.new_usertype<wound_type_definition_handle>(
        "WoundDefinition", sol::no_constructor,
        "id", sol::property( &wound_type_definition_handle::id ),
        "damage_type", &wound_type_definition_handle::damage_type,
        "limb_score", &wound_type_definition_handle::limb_score,
        "progression", &wound_type_definition_handle::progression,
        "require_body_part_type", &wound_type_definition_handle::require_body_part_type,
        "forbid_body_part_type", &wound_type_definition_handle::forbid_body_part_type );
    ccb.new_usertype<body_part_definition_handle>(
        "BodyPartDefinition", sol::no_constructor,
        "id", sol::property( &body_part_definition_handle::id ),
        "sub_part", &body_part_definition_handle::sub_part,
        "limb_type", &body_part_definition_handle::limb_type,
        "armor", &body_part_definition_handle::armor,
        "unarmed_damage", &body_part_definition_handle::unarmed_damage,
        "flag", &body_part_definition_handle::flag,
        "limb_score", &body_part_definition_handle::limb_score,
        "quality", &body_part_definition_handle::quality );
    ccb.new_usertype<wound_fix_definition_handle>(
        "WoundFixDefinition", sol::no_constructor,
        "id", sol::property( &wound_fix_definition_handle::id ),
        "skill", &wound_fix_definition_handle::skill,
        "proficiency", &wound_fix_definition_handle::proficiency,
        "removes", &wound_fix_definition_handle::removes,
        "adds", &wound_fix_definition_handle::adds,
        "requires", &wound_fix_definition_handle::requires );
    ccb.new_usertype<anatomy_definition_handle>(
        "AnatomyDefinition", sol::no_constructor,
        "id", sol::property( &anatomy_definition_handle::id ),
        "part", &anatomy_definition_handle::part );
    ccb.new_usertype<body_graph_definition_handle>(
        "BodyGraphDefinition", sol::no_constructor,
        "id", sol::property( &body_graph_definition_handle::id ),
        "row", &body_graph_definition_handle::row,
        "part", &body_graph_definition_handle::part );
    ccb.new_usertype<monster_definition_handle>(
        "MonsterDefinition", sol::no_constructor,
        "id", sol::property( &monster_definition_handle::id ),
        "material", &monster_definition_handle::material,
        "species", &monster_definition_handle::species,
        "category", &monster_definition_handle::category,
        "flag", &monster_definition_handle::flag,
        "armor", &monster_definition_handle::armor,
        "melee_damage", &monster_definition_handle::melee_damage,
        "attack", &monster_definition_handle::attack,
        "on_attack", &monster_definition_handle::on_attack,
        "weakpoint_set", &monster_definition_handle::weakpoint_set,
        "emission", &monster_definition_handle::emission,
        "starting_ammo", &monster_definition_handle::starting_ammo,
        "track_scent", &monster_definition_handle::track_scent,
        "ignore_scent", &monster_definition_handle::ignore_scent,
        "regeneration_modifier", &monster_definition_handle::regeneration_modifier,
        "goal", &monster_definition_handle::goal,
        "anger_trigger", &monster_definition_handle::anger_trigger,
        "fear_trigger", &monster_definition_handle::fear_trigger,
        "placate_trigger", &monster_definition_handle::placate_trigger,
        "on_death", &monster_definition_handle::on_death );
    ccb.new_usertype<morale_type_definition_handle>(
        "MoraleTypeDefinition", sol::no_constructor,
        "id", sol::property( &morale_type_definition_handle::id ) );
    ccb.new_usertype<disease_type_definition_handle>(
        "DiseaseTypeDefinition", sol::no_constructor,
        "id", sol::property( &disease_type_definition_handle::id ),
        "affected_body_part", &disease_type_definition_handle::affected_body_part );
    ccb.new_usertype<monster_flag_definition_handle>(
        "MonsterFlagDefinition", sol::no_constructor,
        "id", sol::property( &monster_flag_definition_handle::id ) );
    ccb.new_usertype<species_definition_handle>(
        "SpeciesDefinition", sol::no_constructor,
        "id", sol::property( &species_definition_handle::id ),
        "flag", &species_definition_handle::flag,
        "anger", &species_definition_handle::anger,
        "fear", &species_definition_handle::fear,
        "placate", &species_definition_handle::placate );
    ccb.new_usertype<emission_definition_handle>(
        "EmissionDefinition", sol::no_constructor,
        "id", sol::property( &emission_definition_handle::id ),
        "profile", &emission_definition_handle::profile );
    ccb.new_usertype<monster_faction_definition_handle>(
        "MonsterFactionDefinition", sol::no_constructor,
        "id", sol::property( &monster_faction_definition_handle::id ),
        "attitude", &monster_faction_definition_handle::attitude );
    ccb.new_usertype<mutation_type_definition_handle>(
        "MutationTypeDefinition", sol::no_constructor,
        "id", sol::property( &mutation_type_definition_handle::id ) );
    ccb.new_usertype<connect_group_definition_handle>(
        "ConnectGroupDefinition", sol::no_constructor,
        "id", sol::property( &connect_group_definition_handle::id ) );
    ccb.new_usertype<mutation_category_definition_handle>(
        "MutationCategoryDefinition", sol::no_constructor,
        "id", sol::property( &mutation_category_definition_handle::id ) );
    ccb.new_usertype<mutation_definition_handle>(
        "MutationDefinition", sol::no_constructor,
        "id", sol::property( &mutation_definition_handle::id ),
        "variant", &mutation_definition_handle::variant,
        "transform", &mutation_definition_handle::transform,
        "personality", &mutation_definition_handle::personality,
        "relationship", &mutation_definition_handle::relationship,
        "integer_value", &mutation_definition_handle::integer_value,
        "decimal_value", &mutation_definition_handle::decimal_value,
        "vitamin_absorption", &mutation_definition_handle::vitamin_absorption,
        "wet_protection", &mutation_definition_handle::wet_protection,
        "armor", &mutation_definition_handle::armor,
        "attack", &mutation_definition_handle::attack,
        "reflex", &mutation_definition_handle::reflex,
        "comfort", &mutation_definition_handle::comfort );

    const auto require_building_transaction = [this]() {
        if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
            throw std::runtime_error( "content transaction is no longer building" );
        }
    };
    const auto each_string = [&require_building_transaction]( const sol::table & options,
    const char *key, const char *label, const auto & visitor ) {
        const sol::optional<sol::table> values =
            options.get<sol::optional<sol::table>>( key );
        if( !values ) {
            return;
        }
        const std::size_t count = require_dense_array( *values, label, 0, 4096 );
        for( std::size_t index = 1; index <= count; ++index ) {
            const sol::object value = values->raw_get<sol::object>( index );
            if( !value.is<std::string>() ) {
                throw std::runtime_error( std::string( label ) + " must contain strings" );
            }
            visitor( value.as<std::string>() );
        }
        require_building_transaction();
    };
    const auto each_table = [&require_building_transaction]( const sol::table & options,
    const char *key, const char *label, const auto & visitor ) {
        const sol::optional<sol::table> values =
            options.get<sol::optional<sol::table>>( key );
        if( !values ) {
            return;
        }
        const std::size_t count = require_dense_array( *values, label, 0, 4096 );
        for( std::size_t index = 1; index <= count; ++index ) {
            visitor( values->raw_get<sol::object>( index ) );
        }
        require_building_transaction();
    };

    content.set_function( "Behavior", [this]( const sol::table & options ) {
        auto definition = std::make_shared<behavior_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->strategy = options.get_or( "strategy", std::string() );
        definition->goal = options.get_or( "goal", std::string() );
        return behavior_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "EffectType", [this]( const sol::table & options ) {
        auto definition = std::make_shared<effect_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        if( const std::string value = options.get_or( "name", std::string() ); !value.empty() ) {
            definition->names.push_back( value );
        }
        if( const std::string value = options.get_or( "description", std::string() );
            !value.empty() ) {
            definition->descriptions.push_back( value );
        }
        definition->remove_message = options.get_or( "remove_message", std::string() );
        definition->apply_memorial_log = options.get_or( "apply_memorial_log", std::string() );
        definition->remove_memorial_log = options.get_or( "remove_memorial_log", std::string() );
        definition->blood_analysis_description = options.get_or(
                    "blood_analysis_description", std::string() );
        definition->maximum_intensity = options.get_or<std::int64_t>(
                                            "maximum_intensity", 1 );
        definition->maximum_duration_turns = options.get_or<std::int64_t>(
                "maximum_duration_turns", 31536000 );
        definition->intensity_duration_turns = options.get_or<std::int64_t>(
                "intensity_duration_turns", 0 );
        definition->duration_add_percent = options.get_or<std::int64_t>(
                                               "duration_add_percent", 100 );
        definition->intensity_add_value = options.get_or<std::int64_t>(
                                              "intensity_add_value", 0 );
        definition->intensity_decay_step = options.get_or<std::int64_t>(
                                               "intensity_decay_step", -1 );
        definition->intensity_decay_tick = options.get_or<std::int64_t>(
                                               "intensity_decay_tick", 0 );
        definition->intensity_decay_removes = options.get_or(
                "intensity_decay_removes", false );
        definition->main_parts_only = options.get_or( "main_parts_only", false );
        definition->show_in_info = options.get_or( "show_in_info", false );
        definition->show_intensity = options.get_or( "show_intensity", true );
        definition->part_descriptions = options.get_or( "part_descriptions", false );
        return effect_type_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "MonsterAttack", [this]( const sol::table & options ) {
        auto definition = std::make_shared<monster_attack_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->cooldown = options.get_or( "cooldown", 1.0 );
        definition->handler = options.get_or( "policy", std::string() );
        return monster_attack_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "WeakpointSet", [this]( const sol::table & options ) {
        auto definition = std::make_shared<weakpoint_set_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return weakpoint_set_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "FieldType", [this]( const sol::table & options ) {
        auto definition = std::make_shared<field_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->underwater_age_speedup_turns = options.get_or<std::int64_t>(
                    "underwater_age_speedup_turns", 0 );
        definition->outdoor_age_speedup_turns = options.get_or<std::int64_t>(
                "outdoor_age_speedup_turns", 0 );
        definition->decay_amount_factor = options.get_or<std::int64_t>(
                                              "decay_amount_factor", 0 );
        definition->percent_spread = options.get_or<std::int64_t>( "percent_spread", 0 );
        definition->gas_absorption_turns = options.get_or<std::int64_t>(
                                               "gas_absorption_turns", 0 );
        definition->priority = options.get_or<std::int64_t>( "priority", 0 );
        definition->half_life_turns = options.get_or<std::int64_t>( "half_life_turns", 0 );
        definition->phase = options.get_or( "phase", std::string( "null" ) );
        definition->description_affix = options.get_or(
                                            "description_affix", std::string( "in" ) );
        definition->wandering_field = options.get_or( "wandering_field", std::string() );
        definition->looks_like = options.get_or( "looks_like", std::string() );
        definition->splattering = options.get_or( "splattering", false );
        definition->has_fire = options.get_or( "has_fire", false );
        definition->has_acid = options.get_or( "has_acid", false );
        definition->has_electricity = options.get_or( "has_electricity", false );
        definition->has_fume = options.get_or( "has_fume", false );
        definition->moppable = options.get_or( "moppable", false );
        definition->accelerated_decay = options.get_or( "accelerated_decay", false );
        definition->display_items = options.get_or( "display_items", true );
        definition->display_field = options.get_or( "display_field", false );
        definition->linear_half_life = options.get_or( "linear_half_life", false );
        definition->indestructible = options.get_or( "indestructible", false );
        definition->mopsafe = options.get_or( "mopsafe", false );
        definition->decrease_intensity_on_contact = options.get_or(
                    "decrease_intensity_on_contact", false );
        return field_type_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "SubBodyPart", [this]( const sol::table & options ) {
        auto definition = std::make_shared<sub_body_part_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->plural_name = options.get_or( "plural_name", std::string() );
        definition->parent = options.get_or( "parent", std::string() );
        definition->opposite = options.get_or( "opposite", definition->id );
        definition->side = options.get_or( "side", std::string( "both" ) );
        definition->secondary = options.get_or( "secondary", false );
        definition->maximum_coverage = options.get_or<std::int64_t>( "maximum_coverage", 0 );
        definition->similar_body_part = options.get_or(
                                            "similar_body_part", std::string() );
        return sub_body_part_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "Wound", [this]( const sol::table & options ) {
        auto definition = std::make_shared<wound_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->plural_name = options.get_or( "plural_name", definition->name );
        definition->description = options.get_or( "description", std::string() );
        definition->pain_min = options.get_or<std::int64_t>( "pain_min", 0 );
        definition->pain_max = options.get_or<std::int64_t>( "pain_max", 0 );
        definition->healing_min_turns = options.get_or<std::int64_t>(
                                            "healing_min_turns", 1 );
        definition->healing_max_turns = options.get_or<std::int64_t>(
                                            "healing_max_turns", 1 );
        definition->damage_min = options.get_or<std::int64_t>( "damage_min", 0 );
        definition->damage_max = options.get_or<std::int64_t>( "damage_max", 0 );
        definition->weight = options.get_or<std::int64_t>( "weight", 1 );
        definition->per_part_limit = options.get_or<std::int64_t>( "per_part_limit", 0 );
        definition->required_body_part_flag = options.get_or(
                "required_body_part_flag", std::string() );
        definition->forbidden_body_part_flag = options.get_or(
                "forbidden_body_part_flag", std::string() );
        return wound_type_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "WoundFix", [this]( const sol::table & options ) {
        auto definition = std::make_shared<wound_fix_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->description = options.get_or( "description", std::string() );
        definition->success_message = options.get_or( "success_message", std::string() );
        definition->duration_turns = options.get_or<std::int64_t>( "duration_turns", 0 );
        definition->health_delta = options.get_or<std::int64_t>( "health_delta", 0 );
        return wound_fix_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "BodyPart", [this]( const sol::table & options ) {
        auto definition = std::make_shared<body_part_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->plural_name = options.get_or( "plural_name", definition->name );
        definition->accusative = options.get_or( "accusative", definition->name );
        definition->plural_accusative = options.get_or(
                                            "plural_accusative", definition->plural_name );
        definition->heading = options.get_or( "heading", definition->name );
        definition->plural_heading = options.get_or(
                                         "plural_heading", definition->plural_name );
        definition->encumbrance_text = options.get_or(
                                           "encumbrance_text", definition->name );
        definition->hp_bar_text = options.get_or( "hp_bar_text", definition->name );
        definition->main_part = options.get_or( "main_part", definition->id );
        definition->connected_to = options.get_or(
                                       "connected_to", definition->main_part );
        definition->opposite = options.get_or( "opposite", definition->id );
        definition->side = options.get_or( "side", std::string( "both" ) );
        definition->hit_size = options.get_or( "hit_size", 1.0 );
        definition->hit_difficulty = options.get_or( "hit_difficulty", 1.0 );
        definition->base_health = options.get_or<std::int64_t>( "base_health", 60 );
        definition->drench_capacity = options.get_or<std::int64_t>(
                                          "drench_capacity", 0 );
        definition->limb = options.get_or( "limb", true );
        definition->vital = options.get_or( "vital", false );
        return body_part_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "Anatomy", [this]( const sol::table & options ) {
        auto definition = std::make_shared<anatomy_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return anatomy_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "BodyGraph", [this]( const sol::table & options ) {
        auto definition = std::make_shared<body_graph_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->parent_body_part = options.get_or(
                                           "parent_body_part", std::string() );
        definition->mirror = options.get_or( "mirror", std::string() );
        definition->label_fill = options.get_or( "label_fill", std::string() );
        definition->fill_symbol = options.get_or( "fill_symbol", std::string( " " ) );
        definition->fill_color = options.get_or( "fill_color", std::string( "white" ) );
        return body_graph_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "Monster", [this]( const sol::table & options ) {
        auto definition = std::make_shared<monster_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->plural_name = options.get_or( "plural_name", definition->name );
        definition->description = options.get_or( "description", std::string() );
        definition->symbol = options.get_or( "symbol", std::string( "?" ) );
        definition->color = options.get_or( "color", std::string( "white" ) );
        definition->looks_like = options.get_or( "looks_like", std::string() );
        definition->body_type = options.get_or( "body_type", std::string() );
        definition->default_faction = options.get_or( "default_faction", std::string() );
        definition->harvest = options.get_or( "harvest", std::string( "human" ) );
        definition->dissect = options.get_or( "dissect", std::string() );
        definition->decay = options.get_or( "decay", std::string() );
        definition->speed_description = options.get_or(
                                            "speed_description", std::string( "DEFAULT" ) );
        definition->death_drops = options.get_or( "death_drops", std::string() );
        definition->volume_ml = options.get_or<std::int64_t>( "volume_ml", 62499 );
        definition->weight_grams = options.get_or<std::int64_t>( "weight_grams", 81499 );
        definition->phase = options.get_or( "phase", std::string( "solid" ) );
        definition->difficulty_adjustment = options.get_or<std::int64_t>(
                                                "difficulty_adjustment", 0 );
        definition->hp = options.get_or<std::int64_t>( "hp", 1 );
        definition->speed = options.get_or<std::int64_t>( "speed", 100 );
        definition->aggression = options.get_or<std::int64_t>( "aggression", 0 );
        definition->morale = options.get_or<std::int64_t>( "morale", 0 );
        definition->tracking_distance = options.get_or<std::int64_t>(
                                            "tracking_distance", 8 );
        definition->attack_cost = options.get_or<std::int64_t>( "attack_cost", 100 );
        definition->melee_skill = options.get_or<std::int64_t>( "melee_skill", 0 );
        definition->melee_dice = options.get_or<std::int64_t>( "melee_dice", 0 );
        definition->melee_sides = options.get_or<std::int64_t>( "melee_sides", 0 );
        definition->melee_armor_penetration = options.get_or<std::int64_t>(
                "melee_armor_penetration", 0 );
        definition->dodge = options.get_or<std::int64_t>( "dodge", 0 );
        definition->vision_day = options.get_or<std::int64_t>( "vision_day", 40 );
        definition->vision_night = options.get_or<std::int64_t>( "vision_night", 1 );
        definition->regenerates = options.get_or<std::int64_t>( "regenerates", 0 );
        definition->bleed_rate = options.get_or<std::int64_t>( "bleed_rate", 100 );
        definition->status_chance_multiplier = options.get_or(
                "status_chance_multiplier", 1.0 );
        definition->luminance = options.get_or( "luminance", 0.0 );
        definition->regenerates_in_dark = options.get_or(
                                              "regenerates_in_dark", false );
        definition->regenerates_morale = options.get_or(
                                             "regenerates_morale", false );
        definition->aggressive_to_characters = options.get_or(
                "aggressive_to_characters", true );
        definition->death_handler = options.get_or(
                                        "on_death", options.get_or( "death_handler", std::string() ) );
        return monster_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "MoraleType", [this]( const sol::table & options ) {
        auto definition = std::make_shared<morale_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->text = options.get_or( "text", std::string() );
        definition->permanent = options.get_or( "permanent", false );
        return morale_type_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "DiseaseType", [this]( const sol::table & options ) {
        auto definition = std::make_shared<disease_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->symptoms = options.get_or( "symptoms", std::string() );
        definition->minimum_duration_turns = options.get_or<std::int64_t>(
                "minimum_duration_turns", 1 );
        definition->maximum_duration_turns = options.get_or<std::int64_t>(
                "maximum_duration_turns", definition->minimum_duration_turns );
        definition->minimum_intensity = options.get_or<std::int64_t>(
                                            "minimum_intensity", 1 );
        definition->maximum_intensity = options.get_or<std::int64_t>(
                                            "maximum_intensity", definition->minimum_intensity );
        if( const sol::optional<std::int64_t> value = options.get<sol::optional<std::int64_t>>(
                    "health_threshold" ) ) {
            definition->health_threshold = *value;
        }
        return disease_type_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "MonsterFlag", [this]( const sol::table & options ) {
        auto definition = std::make_shared<monster_flag_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return monster_flag_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "Species", [this]( const sol::table & options ) {
        auto definition = std::make_shared<species_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->footsteps = options.get_or( "footsteps", std::string( "footsteps." ) );
        definition->bleeds = options.get_or( "bleeds", std::string( "fd_null" ) );
        return species_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "Emission", [this]( const sol::table & options ) {
        auto definition = std::make_shared<emission_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->field = options.get_or( "field", std::string() );
        definition->intensity = options.get_or<std::int64_t>( "intensity", 1 );
        definition->quantity = options.get_or<std::int64_t>( "quantity", 1 );
        definition->chance = options.get_or<std::int64_t>( "chance", 100 );
        definition->profile_handler = options.get_or(
                                          "profile", options.get_or( "profile_handler", std::string() ) );
        return emission_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "MonsterFaction", [this]( const sol::table & options ) {
        auto definition = std::make_shared<monster_faction_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->base = options.get_or( "base", std::string() );
        return monster_faction_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "MutationType", [this]( const sol::table & options ) {
        auto definition = std::make_shared<mutation_type_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return mutation_type_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "ConnectGroup", [this]( const sol::table & options ) {
        auto definition = std::make_shared<connect_group_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        return connect_group_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "MutationCategory", [this]( const sol::table & options ) {
        auto definition = std::make_shared<mutation_category_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", definition->id );
        definition->threshold_mutation = options.get_or(
                                             "threshold_mutation", std::string() );
        definition->mutagen_message = options.get_or(
                                          "mutagen_message", std::string() );
        definition->memorial_message = options.get_or(
                                           "memorial_message", std::string( "Crossed a threshold" ) );
        definition->vitamin = options.get_or( "vitamin", std::string( "null" ) );
        definition->threshold_minimum = options.get_or<std::int64_t>(
                                            "threshold_minimum", 2200 );
        definition->base_removal_chance = options.get_or<std::int64_t>(
                                              "base_removal_chance", 100 );
        definition->base_removal_cost_multiplier = options.get_or(
                    "base_removal_cost_multiplier", 3.0 );
        definition->work_in_progress = options.get_or( "work_in_progress", false );
        definition->skip_consistency_test = options.get_or(
                                                "skip_consistency_test", false );
        return mutation_category_definition_handle{ std::move( definition ), pimpl_->token };
    } );
    content.set_function( "Mutation", [this, each_string, each_table](
    const sol::table & options ) {
        auto definition = std::make_shared<mutation_definition_data>();
        definition->id = options.get_or( "id", std::string() );
        definition->name = options.get_or( "name", std::string() );
        definition->description = options.get_or( "description", std::string() );
        definition->points = options.get_or<std::int64_t>( "points", 0 );
        definition->vitamin_cost = options.get_or<std::int64_t>( "vitamin_cost", 100 );
        definition->visibility = options.get_or<std::int64_t>( "visibility", 0 );
        definition->ugliness = options.get_or<std::int64_t>( "ugliness", 0 );
        definition->activation_cost = options.get_or<std::int64_t>( "activation_cost", 0 );
        definition->cooldown_turns = options.get_or<std::int64_t>( "cooldown_turns", 0 );
        definition->bodytemp_min = options.get_or<std::int64_t>( "bodytemp_min", 0 );
        definition->bodytemp_max = options.get_or<std::int64_t>( "bodytemp_max", 0 );
        definition->starting_trait = options.get_or( "starting_trait", false );
        definition->chargen_allow_npc = options.get_or( "chargen_allow_npc", true );
        definition->random_start_allowed = options.get_or( "random_start_allowed", true );
        definition->mixed_effect = options.get_or( "mixed_effect", false );
        definition->active = options.get_or( "active", false );
        definition->starts_active = options.get_or( "starts_active", false );
        definition->destroys_gear = options.get_or( "destroys_gear", false );
        definition->allow_soft_gear = options.get_or( "allow_soft_gear", false );
        definition->consumes_kcal = options.get_or( "consumes_kcal", false );
        definition->consumes_thirst = options.get_or( "consumes_thirst", false );
        definition->consumes_sleepiness = options.get_or( "consumes_sleepiness", false );
        definition->consumes_mana = options.get_or( "consumes_mana", false );
        definition->consumes_stamina = options.get_or( "consumes_stamina", false );
        definition->valid = options.get_or( "valid", true );
        definition->purifiable = options.get_or( "purifiable", true );
        definition->threshold = options.get_or( "threshold", false );
        definition->strict_threshold_requirement = options.get_or(
                    "strict_threshold_requirement", false );
        definition->profession = options.get_or( "profession", false );
        definition->debug = options.get_or( "debug", false );
        definition->player_display = options.get_or( "player_display", true );
        definition->vanity = options.get_or( "vanity", false );
        definition->dummy = options.get_or( "dummy", false );
        definition->activation_message = options.get_or(
                                             "activation_message", std::string() );
        definition->scent_type = options.get_or( "scent_type", std::string() );
        definition->spawn_item = options.get_or( "spawn_item", std::string() );
        definition->spawn_item_message = options.get_or(
                                             "spawn_item_message", std::string() );
        definition->ranged_mutation = options.get_or( "ranged_mutation", std::string() );
        definition->ranged_mutation_message = options.get_or(
                "ranged_mutation_message", std::string() );
        definition->override_look_id = options.get_or( "override_look_id", std::string() );
        definition->override_look_category = options.get_or(
                "override_look_category", std::string() );
        if( const sol::optional<std::int64_t> value = options.get<sol::optional<std::int64_t>>(
                    "scent_intensity" ) ) {
            definition->scent_intensity = *value;
        }
        if( const sol::optional<bool> value = options.get<sol::optional<bool>>(
                "hide_on_activated" ) ) {
            definition->hide_on_activated = *value;
        }
        if( const sol::optional<bool> value = options.get<sol::optional<bool>>(
                "hide_on_deactivated" ) ) {
            definition->hide_on_deactivated = *value;
        }
        mutation_definition_handle handle{ definition, pimpl_->token };
        if( const sol::optional<sol::table> value = options.get<sol::optional<sol::table>>(
                    "transform" ) ) {
            handle.transform( *value );
        }
        if( const sol::optional<sol::table> value = options.get<sol::optional<sol::table>>(
                    "personality" ) ) {
            handle.personality( *value );
        }
        each_string( options, "flags", "mutation flags", [&handle]( const std::string & id ) {
            handle.relationship( "flag", id );
        } );
        each_string( options, "active_flags", "mutation active flags",
        [&handle]( const std::string & id ) {
            handle.relationship( "active_flag", id );
        } );
        each_string( options, "inactive_flags", "mutation inactive flags",
        [&handle]( const std::string & id ) {
            handle.relationship( "inactive_flag", id );
        } );
        each_string( options, "types", "mutation types", [&handle]( const std::string & id ) {
            handle.relationship( "type", id );
        } );
        each_string( options, "categories", "mutation categories",
        [&handle]( const std::string & id ) {
            handle.relationship( "category", id );
        } );
        each_table( options, "variants", "mutation variants", [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "mutation variants require tables" );
            }
            handle.variant( value.as<sol::table>() );
        } );
        each_table( options, "armor", "mutation armor", [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "mutation armor requires tables" );
            }
            const sol::table item = value.as<sol::table>();
            handle.armor( item.get_or( "bodypart", item.get_or( "part", std::string() ) ),
                          item.get_or( "damage_type", item.get_or( "type", std::string() ) ),
                          item.get_or( "amount", 0.0 ) );
        } );
        each_table( options, "attacks", "mutation attacks", [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "mutation attacks require tables" );
            }
            handle.attack( value.as<sol::table>() );
        } );
        each_table( options, "reflex_triggers", "mutation reflex triggers",
        [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "mutation reflex triggers require tables" );
            }
            handle.reflex( value.as<sol::table>() );
        } );
        each_table( options, "comfort", "mutation comfort", [&handle]( const sol::object & value ) {
            if( !value.is<sol::table>() ) {
                throw std::runtime_error( "mutation comfort requires tables" );
            }
            handle.comfort( value.as<sol::table>() );
        } );
        return handle;
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
#define CATA_CREATURES_EDIT( lua_name, handle_type, member, kind ) \
    content.set_function( lua_name, [this, edit_catalog]( const std::string &id ) { \
        return handle_type{ edit_catalog( id, pimpl_->member, kind ), pimpl_->token }; \
    } )
    CATA_CREATURES_EDIT( "edit_behavior", behavior_definition_handle, behaviors, "behavior" );
    CATA_CREATURES_EDIT( "edit_effect_type", effect_type_definition_handle, effect_types,
                         "effect_type" );
    CATA_CREATURES_EDIT( "edit_monster_attack", monster_attack_definition_handle, monster_attacks,
                         "monster_attack" );
    CATA_CREATURES_EDIT( "edit_weakpoint_set", weakpoint_set_definition_handle, weakpoint_sets,
                         "weakpoint_set" );
    CATA_CREATURES_EDIT( "edit_field_type", field_type_definition_handle, field_types, "field_type" );
    CATA_CREATURES_EDIT( "edit_sub_body_part", sub_body_part_definition_handle, sub_body_parts,
                         "sub_body_part" );
    CATA_CREATURES_EDIT( "edit_wound", wound_type_definition_handle, wound_types, "wound" );
    CATA_CREATURES_EDIT( "edit_body_part", body_part_definition_handle, body_parts, "body_part" );
    CATA_CREATURES_EDIT( "edit_wound_fix", wound_fix_definition_handle, wound_fixes, "wound_fix" );
    CATA_CREATURES_EDIT( "edit_anatomy", anatomy_definition_handle, anatomies, "anatomy" );
    CATA_CREATURES_EDIT( "edit_body_graph", body_graph_definition_handle, body_graphs, "body_graph" );
    CATA_CREATURES_EDIT( "edit_monster", monster_definition_handle, monsters, "monster" );
    CATA_CREATURES_EDIT( "edit_morale_type", morale_type_definition_handle, morale_types,
                         "morale_type" );
    CATA_CREATURES_EDIT( "edit_disease_type", disease_type_definition_handle, disease_types,
                         "disease_type" );
    CATA_CREATURES_EDIT( "edit_monster_flag", monster_flag_definition_handle, monster_flags,
                         "monster_flag" );
    CATA_CREATURES_EDIT( "edit_species", species_definition_handle, species, "species" );
    CATA_CREATURES_EDIT( "edit_emission", emission_definition_handle, emissions, "emission" );
    CATA_CREATURES_EDIT( "edit_monster_faction", monster_faction_definition_handle, monster_factions,
                         "monster_faction" );
    CATA_CREATURES_EDIT( "edit_mutation_type", mutation_type_definition_handle, mutation_types,
                         "mutation_type" );
    CATA_CREATURES_EDIT( "edit_connect_group", connect_group_definition_handle, connect_groups,
                         "connect_group" );
    CATA_CREATURES_EDIT( "edit_mutation_category", mutation_category_definition_handle,
                         mutation_categories, "mutation_category" );
    CATA_CREATURES_EDIT( "edit_mutation", mutation_definition_handle, mutations, "mutation" );
#undef CATA_CREATURES_EDIT

    static_cast<void>( lua );
}

bool creatures_content_transaction::register_definition( const sol::object &value,
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

#define CATA_CREATURES_REGISTER( handle_type, member, kind ) \
    if( value.is<handle_type>() ) { \
        register_catalog( value.as<handle_type>(), pimpl_->member, kind ); \
        return true; \
    }
    CATA_CREATURES_REGISTER( behavior_definition_handle, behaviors, "behavior" )
    CATA_CREATURES_REGISTER( effect_type_definition_handle, effect_types, "effect type" )
    CATA_CREATURES_REGISTER( monster_attack_definition_handle, monster_attacks, "monster attack" )
    CATA_CREATURES_REGISTER( weakpoint_set_definition_handle, weakpoint_sets, "weakpoint set" )
    CATA_CREATURES_REGISTER( field_type_definition_handle, field_types, "field type" )
    CATA_CREATURES_REGISTER( sub_body_part_definition_handle, sub_body_parts, "sub body part" )
    CATA_CREATURES_REGISTER( wound_type_definition_handle, wound_types, "wound" )
    CATA_CREATURES_REGISTER( body_part_definition_handle, body_parts, "body part" )
    CATA_CREATURES_REGISTER( wound_fix_definition_handle, wound_fixes, "wound fix" )
    CATA_CREATURES_REGISTER( anatomy_definition_handle, anatomies, "anatomy" )
    CATA_CREATURES_REGISTER( body_graph_definition_handle, body_graphs, "body graph" )
    CATA_CREATURES_REGISTER( monster_definition_handle, monsters, "monster" )
    CATA_CREATURES_REGISTER( morale_type_definition_handle, morale_types, "morale type" )
    CATA_CREATURES_REGISTER( disease_type_definition_handle, disease_types, "disease type" )
    CATA_CREATURES_REGISTER( monster_flag_definition_handle, monster_flags, "monster flag" )
    CATA_CREATURES_REGISTER( species_definition_handle, species, "species" )
    CATA_CREATURES_REGISTER( emission_definition_handle, emissions, "emission" )
    CATA_CREATURES_REGISTER( monster_faction_definition_handle, monster_factions,
                             "monster faction" )
    CATA_CREATURES_REGISTER( mutation_type_definition_handle, mutation_types, "mutation type" )
    CATA_CREATURES_REGISTER( connect_group_definition_handle, connect_groups, "connect group" )
    CATA_CREATURES_REGISTER( mutation_category_definition_handle, mutation_categories,
                             "mutation category" )
    CATA_CREATURES_REGISTER( mutation_definition_handle, mutations, "mutation" )
#undef CATA_CREATURES_REGISTER
    return false;
}

bool creatures_content_transaction::validate( const runtime &owner_runtime,
        const bool check_engine_state, const creatures_content_validation_index &index,
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
        const auto validate_catalog = [&require_valid_id, &validate_operation]( const auto & entries,
        const char *kind, const auto & native_exists ) {
            using registration_type = typename std::decay_t<decltype( entries )>::value_type;
            static_cast<void>( sizeof( registration_type ) );
            std::set<std::string> ids;
            for( const auto &entry : entries ) {
                if( !entry.definition ) {
                    throw std::runtime_error( std::string( kind ) + " has null definition" );
                }
                const auto &definition = *entry.definition;
                require_valid_id( definition.id, kind );
                if( !ids.insert( definition.id ).second ) {
                    throw std::runtime_error( std::string( kind ) + " '" + definition.id +
                                              "' is registered more than once per transaction" );
                }
                validate_operation( entry.operation, native_exists( definition.id ),
                                    definition.id, kind );
            }
        };

        const auto native_behavior = []( const std::string & id ) {
            return string_id<behavior::node_t>( id ).is_valid();
        };
        const auto native_effect = []( const std::string & id ) {
            return detail::effect_type_registry_find( id ) != nullptr;
        };
        const auto native_attack = []( const std::string & id ) {
            return detail::monster_attack_registry_find( id ) != nullptr;
        };
        const auto native_weakpoint = []( const std::string & id ) {
            return weakpoints_id( id ).is_valid();
        };
        const auto native_field = []( const std::string & id ) {
            return field_type_str_id( id ).is_valid();
        };
        const auto native_sub_body = []( const std::string & id ) {
            return sub_bodypart_str_id( id ).is_valid();
        };
        const auto native_wound = []( const std::string & id ) {
            return wound_type_id( id ).is_valid();
        };
        const auto native_body = []( const std::string & id ) {
            return bodypart_str_id( id ).is_valid();
        };
        const auto native_wound_fix = []( const std::string & id ) {
            return wound_fix_id( id ).is_valid();
        };
        const auto native_anatomy = []( const std::string & id ) {
            return anatomy_id( id ).is_valid();
        };
        const auto native_graph = []( const std::string & id ) {
            return bodygraph_id( id ).is_valid();
        };
        const auto native_monster = []( const std::string & id ) {
            return mtype_id( id ).is_valid();
        };
        const auto native_morale = []( const std::string & id ) {
            return morale_type( id ).is_valid();
        };
        const auto native_disease = []( const std::string & id ) {
            return diseasetype_id( id ).is_valid();
        };
        const auto native_monster_flag = []( const std::string & id ) {
            return mon_flag_str_id( id ).is_valid();
        };
        const auto native_species = []( const std::string & id ) {
            return species_id( id ).is_valid();
        };
        const auto native_emission = []( const std::string & id ) {
            return detail::emission_registry_find( id ) != nullptr;
        };
        const auto native_faction = []( const std::string & id ) {
            return mfaction_str_id( id ).is_valid();
        };
        const auto native_mutation_type = []( const std::string & id ) {
            return detail::mutation_type_registry_contains( id );
        };
        const auto native_connect_group = []( const std::string & id ) {
            return detail::connect_group_registry_find( id ) != nullptr;
        };
        const auto native_mutation_category = []( const std::string & id ) {
            return detail::mutation_category_registry_find( id ) != nullptr;
        };
        const auto native_mutation = []( const std::string & id ) {
            return trait_id( id ).is_valid();
        };

        validate_catalog( pimpl_->behaviors, "behavior", native_behavior );
        validate_catalog( pimpl_->effect_types, "effect type", native_effect );
        validate_catalog( pimpl_->monster_attacks, "monster attack", native_attack );
        validate_catalog( pimpl_->weakpoint_sets, "weakpoint set", native_weakpoint );
        validate_catalog( pimpl_->field_types, "field type", native_field );
        validate_catalog( pimpl_->sub_body_parts, "sub body part", native_sub_body );
        validate_catalog( pimpl_->wound_types, "wound", native_wound );
        validate_catalog( pimpl_->body_parts, "body part", native_body );
        validate_catalog( pimpl_->wound_fixes, "wound fix", native_wound_fix );
        validate_catalog( pimpl_->anatomies, "anatomy", native_anatomy );
        validate_catalog( pimpl_->body_graphs, "body graph", native_graph );
        validate_catalog( pimpl_->monsters, "monster", native_monster );
        validate_catalog( pimpl_->morale_types, "morale type", native_morale );
        validate_catalog( pimpl_->disease_types, "disease type", native_disease );
        validate_catalog( pimpl_->monster_flags, "monster flag", native_monster_flag );
        validate_catalog( pimpl_->species, "species", native_species );
        validate_catalog( pimpl_->emissions, "emission", native_emission );
        validate_catalog( pimpl_->monster_factions, "monster faction", native_faction );
        validate_catalog( pimpl_->mutation_types, "mutation type", native_mutation_type );
        validate_catalog( pimpl_->connect_groups, "connect group", native_connect_group );
        validate_catalog( pimpl_->mutation_categories, "mutation category",
                          native_mutation_category );
        validate_catalog( pimpl_->mutations, "mutation", native_mutation );

        const auto staged = [check_engine_state]( const auto & entries,
        const std::string_view id, const auto & native_exists ) {
            return std::any_of( entries.begin(), entries.end(), [id]( const auto & entry ) {
                return entry.definition->id == id;
            } ) || ( check_engine_state && native_exists( std::string( id ) ) );
        };
        const auto item_exists = [&index, check_engine_state]( const std::string & id ) {
            return ( index.defines_item && index.defines_item( id ) ) ||
                   ( check_engine_state && itype_id( id ).is_valid() );
        };
        const auto material_exists = [&index, check_engine_state]( const std::string & id ) {
            return ( index.defines_material && index.defines_material( id ) ) ||
                   !check_engine_state || material_id( id ).is_valid();
        };
        const auto damage_exists = [&index, check_engine_state]( const std::string & id ) {
            return ( index.defines_damage_type && index.defines_damage_type( id ) ) ||
                   ( check_engine_state && damage_type_id( id ).is_valid() );
        };
        const auto skill_exists = [&index, check_engine_state]( const std::string & id ) {
            return ( index.defines_skill && index.defines_skill( id ) ) ||
                   ( check_engine_state && skill_id( id ).is_valid() );
        };
        const auto proficiency_exists = [&index, check_engine_state]( const std::string & id ) {
            return ( index.defines_proficiency && index.defines_proficiency( id ) ) ||
                   ( check_engine_state && proficiency_id( id ).is_valid() );
        };
        const auto vitamin_exists = [&index, check_engine_state]( const std::string & id ) {
            return ( index.defines_vitamin && index.defines_vitamin( id ) ) ||
                   ( check_engine_state && vitamin_id( id ).is_valid() );
        };
        const auto behavior_exists = [&]( const std::string & id ) {
            return staged( pimpl_->behaviors, id, native_behavior );
        };
        const auto effect_exists = [&]( const std::string & id ) {
            return staged( pimpl_->effect_types, id, native_effect );
        };
        const auto field_exists = [&]( const std::string & id ) {
            return staged( pimpl_->field_types, id, native_field );
        };
        const auto body_exists = [&]( const std::string & id ) {
            return staged( pimpl_->body_parts, id, native_body );
        };
        const auto sub_body_exists = [&]( const std::string & id ) {
            return staged( pimpl_->sub_body_parts, id, native_sub_body );
        };
        const auto graph_exists = [&]( const std::string & id ) {
            return staged( pimpl_->body_graphs, id, native_graph );
        };
        const auto wound_exists = [&]( const std::string & id ) {
            return staged( pimpl_->wound_types, id, native_wound );
        };
        const auto monster_exists = [&]( const std::string & id ) {
            return staged( pimpl_->monsters, id, native_monster );
        };
        const auto species_exists = [&]( const std::string & id ) {
            return staged( pimpl_->species, id, native_species );
        };
        const auto emission_exists = [&]( const std::string & id ) {
            return staged( pimpl_->emissions, id, native_emission );
        };
        const auto attack_exists = [&]( const std::string & id ) {
            return staged( pimpl_->monster_attacks, id, native_attack );
        };
        const auto weakpoint_exists = [&]( const std::string & id ) {
            return staged( pimpl_->weakpoint_sets, id, native_weakpoint );
        };
        const auto mutation_exists = [&]( const std::string & id ) {
            return staged( pimpl_->mutations, id, native_mutation );
        };

        for( const auto &entry : pimpl_->behaviors ) {
            const auto &definition = *entry.definition;
            if( !definition.strategy.empty() && behavior::strategy_map.count( definition.strategy ) == 0 ) {
                throw std::runtime_error( "behavior '" + definition.id + "' has unknown strategy" );
            }
            for( const std::string &child : definition.children ) {
                if( child.empty() || !behavior_exists( child ) ) {
                    throw std::runtime_error( "behavior '" + definition.id +
                                              "' references unknown child '" + child + "'" );
                }
            }
            for( const auto &condition : definition.conditions ) {
                if( condition.policy.empty() ||
                    ( !condition.native && owner_runtime.handlers.count( condition.policy ) == 0 ) ) {
                    throw std::runtime_error( "behavior '" + definition.id +
                                              "' references missing condition policy '" +
                                              condition.policy + "'" );
                }
                if( condition.native && behavior::predicate_map.count( condition.policy ) == 0 ) {
                    throw std::runtime_error( "behavior '" + definition.id +
                                              "' has unknown native predicate '" +
                                              condition.policy + "'" );
                }
            }
            if( definition.score ) {
                if( definition.score->policy.empty() ||
                    ( !definition.score->native && owner_runtime.handlers.count(
                          definition.score->policy ) == 0 ) ||
                    ( definition.score->native && behavior::score_predicate_map.count(
                          definition.score->policy ) == 0 ) ) {
                    throw std::runtime_error( "behavior '" + definition.id +
                                              "' has an unknown score policy" );
                }
            }
        }
        for( const auto &entry : pimpl_->effect_types ) {
            const auto &definition = *entry.definition;
            for( const std::string &id : definition.resist_effects ) {
                if( !effect_exists( id ) ) {
                    throw std::runtime_error( "effect type '" + definition.id +
                                              "' references unknown resistance effect '" + id + "'" );
                }
            }
            for( const std::string &id : definition.removes_effects ) {
                if( !effect_exists( id ) ) {
                    throw std::runtime_error( "effect type '" + definition.id +
                                              "' references unknown removed effect '" + id + "'" );
                }
            }
            for( const std::string &id : definition.blocks_effects ) {
                if( !effect_exists( id ) ) {
                    throw std::runtime_error( "effect type '" + definition.id +
                                              "' references unknown blocked effect '" + id + "'" );
                }
            }
        }
        for( const auto &entry : pimpl_->monster_attacks ) {
            const auto &definition = *entry.definition;
            if( !std::isfinite( definition.cooldown ) || definition.cooldown < 0.0 ) {
                throw std::runtime_error( "monster attack '" + definition.id +
                                          "' has an invalid cooldown" );
            }
            if( !definition.handler.empty() && owner_runtime.handlers.count( definition.handler ) == 0 ) {
                throw std::runtime_error( "monster attack '" + definition.id +
                                          "' references missing handler '" + definition.handler + "'" );
            }
        }
        for( const auto &entry : pimpl_->weakpoint_sets ) {
            const auto &definition = *entry.definition;
            std::set<std::string> ids;
            for( const auto &point : definition.weakpoints ) {
                if( point.id.empty() || !ids.insert( point.id ).second ||
                    !std::isfinite( point.coverage ) || point.coverage < 0.0 ) {
                    throw std::runtime_error( "weakpoint set '" + definition.id +
                                              "' has invalid weakpoint metadata" );
                }
                for( const auto &effect : point.effects ) {
                    if( !effect.effect.empty() && !effect_exists( effect.effect ) ) {
                        throw std::runtime_error( "weakpoint '" + point.id +
                                                  "' references unknown effect '" + effect.effect + "'" );
                    }
                    if( !effect.handler.empty() && owner_runtime.handlers.count( effect.handler ) == 0 ) {
                        throw std::runtime_error( "weakpoint '" + point.id +
                                                  "' references missing handler '" + effect.handler + "'" );
                    }
                }
            }
        }
        for( const auto &entry : pimpl_->field_types ) {
            const auto &definition = *entry.definition;
            if( definition.intensity_levels.empty() ) {
                throw std::runtime_error( "field type '" + definition.id +
                                          "' requires at least one intensity" );
            }
            if( !definition.wandering_field.empty() && !field_exists( definition.wandering_field ) ) {
                throw std::runtime_error( "field type '" + definition.id +
                                          "' references unknown wandering field" );
            }
            for( const auto &level : definition.intensity_levels ) {
                for( const auto &effect : level.effects ) {
                    if( !effect.effect.empty() && !effect_exists( effect.effect ) ) {
                        throw std::runtime_error( "field type '" + definition.id +
                                                  "' references unknown effect '" + effect.effect + "'" );
                    }
                    if( !effect.body_part.empty() && !body_exists( effect.body_part ) ) {
                        throw std::runtime_error( "field type '" + definition.id +
                                                  "' references unknown body part '" + effect.body_part + "'" );
                    }
                }
            }
            for( const std::string &id : definition.immune_monsters ) {
                if( !monster_exists( id ) ) {
                    throw std::runtime_error( "field type '" + definition.id +
                                              "' references unknown immune monster '" + id + "'" );
                }
            }
            for( const std::string &id : definition.blocked_monsters ) {
                if( !monster_exists( id ) ) {
                    throw std::runtime_error( "field type '" + definition.id +
                                              "' references unknown blocked monster '" + id + "'" );
                }
            }
        }
        for( const auto &entry : pimpl_->sub_body_parts ) {
            const auto &definition = *entry.definition;
            if( !definition.parent.empty() && !body_exists( definition.parent ) ) {
                throw std::runtime_error( "sub body part '" + definition.id +
                                          "' references unknown parent" );
            }
            if( !definition.opposite.empty() && !sub_body_exists( definition.opposite ) ) {
                throw std::runtime_error( "sub body part '" + definition.id +
                                          "' references unknown opposite" );
            }
            if( !definition.similar_body_part.empty() &&
                !sub_body_exists( definition.similar_body_part ) ) {
                throw std::runtime_error( "sub body part '" + definition.id +
                                          "' references unknown similar part" );
            }
            for( const auto &damage : definition.unarmed_damage ) {
                if( !damage_exists( damage.first ) ) {
                    throw std::runtime_error( "sub body part '" + definition.id +
                                              "' references unknown damage type '" + damage.first + "'" );
                }
            }
        }
        for( const auto &entry : pimpl_->body_parts ) {
            const auto &definition = *entry.definition;
            if( !definition.main_part.empty() && !body_exists( definition.main_part ) ) {
                throw std::runtime_error( "body part '" + definition.id +
                                          "' references unknown main part" );
            }
            if( !definition.connected_to.empty() && !body_exists( definition.connected_to ) ) {
                throw std::runtime_error( "body part '" + definition.id +
                                          "' references unknown connected part" );
            }
            if( !definition.opposite.empty() && !body_exists( definition.opposite ) ) {
                throw std::runtime_error( "body part '" + definition.id +
                                          "' references unknown opposite" );
            }
            for( const std::string &id : definition.sub_parts ) {
                if( !sub_body_exists( id ) ) {
                    throw std::runtime_error( "body part '" + definition.id +
                                              "' references unknown sub part '" + id + "'" );
                }
            }
            for( const auto &damage : definition.armor ) {
                if( !damage_exists( damage.first ) ) {
                    throw std::runtime_error( "body part '" + definition.id +
                                              "' references unknown damage type '" + damage.first + "'" );
                }
            }
            for( const auto &damage : definition.unarmed_damage ) {
                if( !damage_exists( damage.first ) ) {
                    throw std::runtime_error( "body part '" + definition.id +
                                              "' references unknown damage type '" + damage.first + "'" );
                }
            }
        }
        for( const auto &entry : pimpl_->wound_types ) {
            const auto &definition = *entry.definition;
            if( definition.pain_min > definition.pain_max ||
                definition.healing_min_turns > definition.healing_max_turns ||
                definition.damage_min > definition.damage_max || definition.weight <= 0 ) {
                throw std::runtime_error( "wound '" + definition.id + "' has invalid bounds" );
            }
            for( const std::string &id : definition.damage_types ) {
                if( !damage_exists( id ) ) {
                    throw std::runtime_error( "wound '" + definition.id +
                                              "' references unknown damage type '" + id + "'" );
                }
            }
            for( const auto &progression : definition.progressions ) {
                if( !wound_exists( progression.id ) ) {
                    throw std::runtime_error( "wound '" + definition.id +
                                              "' references unknown progression '" + progression.id + "'" );
                }
            }
        }
        for( const auto &entry : pimpl_->wound_fixes ) {
            const auto &definition = *entry.definition;
            for( const auto &[id, level] : definition.skills ) {
                if( !skill_exists( id ) || !fits_native_int( level ) ) {
                    throw std::runtime_error( "wound fix '" + definition.id +
                                              "' has an invalid skill" );
                }
            }
            for( const auto &proficiency : definition.proficiencies ) {
                if( !proficiency_exists( proficiency.id ) ||
                    !std::isfinite( proficiency.multiplier ) || proficiency.multiplier < 0.0 ) {
                    throw std::runtime_error( "wound fix '" + definition.id +
                                              "' has an invalid proficiency" );
                }
            }
            for( const std::string &id : definition.wounds_removed ) {
                if( !wound_exists( id ) ) {
                    throw std::runtime_error( "wound fix '" + definition.id +
                                              "' references unknown removed wound '" + id + "'" );
                }
            }
            for( const std::string &id : definition.wounds_added ) {
                if( !wound_exists( id ) ) {
                    throw std::runtime_error( "wound fix '" + definition.id +
                                              "' references unknown added wound '" + id + "'" );
                }
            }
            std::vector<std::pair<std::string, std::int64_t>> scaled_requirements;
            scaled_requirements.reserve( definition.requirements.size() );
            for( const wound_fix_requirement_definition_data &requirement :
                 definition.requirements ) {
                scaled_requirements.emplace_back( requirement.id, requirement.count );
            }
            std::string requirement_error;
            if( !index.validate_scaled_requirements ||
                !index.validate_scaled_requirements(
                    scaled_requirements, requirement_error ) ) {
                throw std::runtime_error( "wound fix '" + definition.id + "' " +
                                          requirement_error );
            }
        }
        for( const auto &entry : pimpl_->anatomies ) {
            for( const std::string &id : entry.definition->parts ) {
                if( !body_exists( id ) ) {
                    throw std::runtime_error( "anatomy '" + entry.definition->id +
                                              "' references unknown body part '" + id + "'" );
                }
            }
        }
        for( const auto &entry : pimpl_->body_graphs ) {
            const auto &definition = *entry.definition;
            if( !definition.parent_body_part.empty() && !body_exists( definition.parent_body_part ) ) {
                throw std::runtime_error( "body graph '" + definition.id +
                                          "' references unknown parent body part" );
            }
            if( !definition.mirror.empty() && !graph_exists( definition.mirror ) ) {
                throw std::runtime_error( "body graph '" + definition.id +
                                          "' references unknown mirror graph" );
            }
            for( const auto &part : definition.parts ) {
                if( !part.nested_graph.empty() && !graph_exists( part.nested_graph ) ) {
                    throw std::runtime_error( "body graph '" + definition.id +
                                              "' references unknown nested graph" );
                }
                for( const std::string &id : part.body_parts ) {
                    if( !body_exists( id ) ) {
                        throw std::runtime_error( "body graph '" + definition.id +
                                                  "' references unknown body part '" + id + "'" );
                    }
                }
                for( const std::string &id : part.sub_body_parts ) {
                    if( !sub_body_exists( id ) ) {
                        throw std::runtime_error( "body graph '" + definition.id +
                                                  "' references unknown sub body part '" + id + "'" );
                    }
                }
            }
        }
        for( const auto &entry : pimpl_->monsters ) {
            const auto &definition = *entry.definition;
            if( !std::isfinite( definition.status_chance_multiplier ) ||
                definition.status_chance_multiplier < 0.0 || !std::isfinite( definition.luminance ) ) {
                throw std::runtime_error( "monster '" + definition.id + "' has invalid numeric values" );
            }
            for( const auto &[id, portions] : definition.materials ) {
                if( !material_exists( id ) || portions <= 0 || !fits_native_int( portions ) ) {
                    throw std::runtime_error( "monster '" + definition.id + "' has invalid material" );
                }
            }
            for( const std::string &id : definition.species ) {
                if( !species_exists( id ) ) {
                    throw std::runtime_error( "monster '" + definition.id +
                                              "' references unknown species '" + id + "'" );
                }
            }
            for( const auto &[id, value] : definition.melee_damage ) {
                if( !damage_exists( id ) || value.amount < 0.0 || value.armor_penetration < 0.0 ) {
                    throw std::runtime_error( "monster '" + definition.id + "' has invalid melee damage" );
                }
            }
            for( const auto &attack : definition.attacks ) {
                if( !attack_exists( attack.id ) ||
                    ( attack.cooldown && ( !std::isfinite( *attack.cooldown ) || *attack.cooldown < 0.0 ) ) ) {
                    throw std::runtime_error( "monster '" + definition.id +
                                              "' references invalid attack '" + attack.id + "'" );
                }
                const auto callback = definition.attack_handlers.find( attack.id );
                if( callback != definition.attack_handlers.end() &&
                    owner_runtime.handlers.count( callback->second ) == 0 ) {
                    throw std::runtime_error( "monster '" + definition.id +
                                              "' references missing attack handler" );
                }
            }
            for( const std::string &id : definition.weakpoint_sets ) {
                if( !weakpoint_exists( id ) ) {
                    throw std::runtime_error( "monster '" + definition.id +
                                              "' references unknown weakpoint set '" + id + "'" );
                }
            }
            for( const auto &[id, interval] : definition.emissions ) {
                if( !emission_exists( id ) || interval <= 0 || !fits_native_int( interval ) ) {
                    throw std::runtime_error( "monster '" + definition.id + "' has invalid emission" );
                }
            }
            for( const auto &[id, amount] : definition.starting_ammo ) {
                if( !item_exists( id ) || amount <= 0 || !fits_native_int( amount ) ) {
                    throw std::runtime_error( "monster '" + definition.id + "' has invalid starting ammo" );
                }
            }
            for( const auto &[id, amount] : definition.regeneration_modifiers ) {
                if( !effect_exists( id ) || !fits_native_int( amount ) ) {
                    throw std::runtime_error( "monster '" + definition.id + "' has invalid regeneration modifier" );
                }
            }
            if( !definition.death_handler.empty() &&
                owner_runtime.handlers.count( definition.death_handler ) == 0 ) {
                throw std::runtime_error( "monster '" + definition.id +
                                          "' references missing death handler" );
            }
        }
        for( const auto &entry : pimpl_->disease_types ) {
            const auto &definition = *entry.definition;
            if( definition.minimum_duration_turns < 0 ||
                definition.maximum_duration_turns < definition.minimum_duration_turns ||
                definition.minimum_intensity < 0 ||
                definition.maximum_intensity < definition.minimum_intensity ) {
                throw std::runtime_error( "disease type '" + definition.id + "' has invalid bounds" );
            }
            if( !definition.symptoms.empty() && !effect_exists( definition.symptoms ) ) {
                throw std::runtime_error( "disease type '" + definition.id +
                                          "' references unknown symptoms effect" );
            }
            for( const std::string &id : definition.affected_body_parts ) {
                if( !body_exists( id ) ) {
                    throw std::runtime_error( "disease type '" + definition.id +
                                              "' references unknown body part" );
                }
            }
        }
        for( const auto &entry : pimpl_->species ) {
            const auto &definition = *entry.definition;
            for( const std::string &id : definition.flags ) {
                if( id.empty() ) {
                    throw std::runtime_error( "species '" + definition.id + "' has an empty flag" );
                }
            }
        }
        for( const auto &entry : pimpl_->emissions ) {
            const auto &definition = *entry.definition;
            if( definition.field.empty() || definition.field == "fd_null" ||
                ( check_engine_state && !field_exists( definition.field ) ) ||
                definition.intensity <= 0 || !fits_native_int( definition.intensity ) ||
                definition.quantity <= 0 || !fits_native_int( definition.quantity ) ||
                definition.chance <= 0 || definition.chance > 100 ) {
                throw std::runtime_error( "emission '" + definition.id + "' has invalid profile" );
            }
            if( !definition.profile_handler.empty() &&
                owner_runtime.handlers.count( definition.profile_handler ) == 0 ) {
                throw std::runtime_error( "emission '" + definition.id +
                                          "' references missing profile handler" );
            }
        }
        for( const auto &entry : pimpl_->mutation_categories ) {
            const auto &definition = *entry.definition;
            if( definition.threshold_minimum < 0 || definition.base_removal_chance < 0 ||
                definition.base_removal_chance > 100 ||
                !std::isfinite( definition.base_removal_cost_multiplier ) ||
                definition.base_removal_cost_multiplier < 0.0 ) {
                throw std::runtime_error( "mutation category '" + definition.id +
                                          "' has invalid thresholds" );
            }
            if( !definition.threshold_mutation.empty() &&
                !mutation_exists( definition.threshold_mutation ) ) {
                throw std::runtime_error( "mutation category '" + definition.id +
                                          "' references unknown threshold mutation" );
            }
            if( !definition.vitamin.empty() && definition.vitamin != "null" &&
                !vitamin_exists( definition.vitamin ) ) {
                throw std::runtime_error( "mutation category '" + definition.id +
                                          "' references unknown vitamin" );
            }
        }
        for( const auto &entry : pimpl_->mutations ) {
            const auto &definition = *entry.definition;
            for( const std::string &id : definition.prereqs ) {
                if( !mutation_exists( id ) ) {
                    throw std::runtime_error( "mutation '" + definition.id +
                                              "' references unknown prerequisite" );
                }
            }
            for( const std::string &id : definition.replacements ) {
                if( !mutation_exists( id ) ) {
                    throw std::runtime_error( "mutation '" + definition.id +
                                              "' references unknown replacement" );
                }
            }
            for( const std::string &id : definition.categories ) {
                if( id.empty() ) {
                    throw std::runtime_error( "mutation '" + definition.id +
                                              "' has an empty category" );
                }
            }
            for( const auto &[id, amount] : definition.vitamin_rates ) {
                if( !vitamin_exists( id ) || !fits_native_int( amount ) ) {
                    throw std::runtime_error( "mutation '" + definition.id +
                                              "' has an invalid vitamin rate" );
                }
            }
            for( const auto &[id, amount] : definition.provided_qualities ) {
                if( id.empty() || !fits_native_int( amount ) ) {
                    throw std::runtime_error( "mutation '" + definition.id +
                                              "' has an invalid quality" );
                }
            }
            for( const auto &armor : definition.armor ) {
                if( !body_exists( armor.bodypart ) || !damage_exists( armor.damage_type ) ||
                    !std::isfinite( armor.amount ) ) {
                    throw std::runtime_error( "mutation '" + definition.id +
                                              "' has invalid armor" );
                }
            }
            for( const auto &attack : definition.attacks ) {
                for( const std::string &id : attack.required_mutations ) {
                    if( !mutation_exists( id ) ) {
                        throw std::runtime_error( "mutation '" + definition.id +
                                                  "' has unknown attack prerequisite" );
                    }
                }
                for( const std::string &id : attack.blocker_mutations ) {
                    if( !mutation_exists( id ) ) {
                        throw std::runtime_error( "mutation '" + definition.id +
                                                  "' has unknown attack blocker" );
                    }
                }
                for( const auto &damage : attack.base_damage ) {
                    if( !damage_exists( damage.damage_type ) ) {
                        throw std::runtime_error( "mutation '" + definition.id +
                                                  "' has unknown attack damage type" );
                    }
                }
                for( const auto &damage : attack.strength_damage ) {
                    if( !damage_exists( damage.damage_type ) ) {
                        throw std::runtime_error( "mutation '" + definition.id +
                                                  "' has unknown strength damage type" );
                    }
                }
            }
            for( const auto &group : definition.reflex_triggers ) {
                for( const auto &trigger : group ) {
                    if( !trigger.handler.empty() && owner_runtime.handlers.count( trigger.handler ) == 0 ) {
                        throw std::runtime_error( "mutation '" + definition.id +
                                                  "' references missing reflex handler" );
                    }
                }
            }
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool creatures_content_transaction::apply_phase( const creatures_content_apply_phase phase,
        std::string &error )
{
    if( pimpl_->token->lifecycle != handle_lifecycle::building ) {
        error = "creature content transaction is no longer building";
        return false;
    }
    if( phase != pimpl_->next_apply_phase ) {
        error = "creature content apply phases must be executed in order";
        return false;
    }
    try {
        if( phase == creatures_content_apply_phase::foundations ) {
            for( const monster_flag_registration &entry : pimpl_->monster_flags ) {
                const mon_flag_str_id id( entry.definition->id );
                pimpl_->monster_flag_undo.emplace_back(
                    id, id.is_valid() ? std::optional<mon_flag>( id.obj() ) : std::nullopt );
                mon_flag native;
                native.id = id;
                native.was_loaded = true;
                detail::monster_flag_registry().insert( native );
            }
            if( !pimpl_->monster_flags.empty() ) {
                detail::monster_flag_registry().finalize();
            }

            for( const species_registration &entry : pimpl_->species ) {
                const species_id id( entry.definition->id );
                pimpl_->species_undo.emplace_back(
                    id, id.is_valid() ? std::optional<species_type>( id.obj() ) : std::nullopt );
                const species_definition_data &source = *entry.definition;
                species_type native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                native.description = no_translation( source.description );
                native.footsteps = no_translation( source.footsteps );
                native.bleeds = field_type_str_id( source.bleeds );
                for( const std::string &flag : source.flags ) {
                    native.flags.insert( mon_flag_str_id( flag ) );
                }
                for( const std::string &trigger : source.anger ) {
                    native.anger.set( io::string_to_enum<mon_trigger>( trigger ) );
                }
                for( const std::string &trigger : source.fear ) {
                    native.fear.set( io::string_to_enum<mon_trigger>( trigger ) );
                }
                for( const std::string &trigger : source.placate ) {
                    native.placate.set( io::string_to_enum<mon_trigger>( trigger ) );
                }
                detail::species_registry().insert( native );
            }
            if( !pimpl_->species.empty() ) {
                detail::species_registry().finalize();
            }

            for( const emission_registration &entry : pimpl_->emissions ) {
                const std::string &id = entry.definition->id;
                const emit *const previous = detail::emission_registry_find( id );
                pimpl_->emission_undo.emplace_back(
                    id, previous == nullptr ? std::optional<emit>() :
                    std::optional<emit>( *previous ) );
                const emission_definition_data &source = *entry.definition;
                emit native;
                native.id_ = emit_id( id );
                native.native_profile_ = emit::native_profile{
                    field_type_str_id( source.field ),
                    static_cast<int>( source.intensity ),
                    static_cast<int>( source.quantity ),
                    static_cast<int>( source.chance )
                };
                detail::emission_registry_set( native );
            }

            for( const monster_faction_registration &entry : pimpl_->monster_factions ) {
                const mfaction_str_id id( entry.definition->id );
                pimpl_->monster_faction_undo.emplace_back(
                    id, id.is_valid() ? std::optional<monfaction>( id.obj() ) : std::nullopt );
                const monster_faction_definition_data &source = *entry.definition;
                monfaction native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                native.base_faction = mfaction_str_id( source.base );
                for( const auto &[target, attitude] : source.attitudes ) {
                    const mfaction_str_id target_id( target );
                    if( attitude == "by_mood" ) {
                        native._att_by_mood.insert( target_id );
                    } else if( attitude == "neutral" ) {
                        native._att_neutral.insert( target_id );
                    } else if( attitude == "friendly" ) {
                        native._att_friendly.insert( target_id );
                    } else {
                        native._att_hate.insert( target_id );
                    }
                }
                native.rebuild_attitude_map();
                detail::monster_faction_registry().insert( native );
            }
            if( !pimpl_->monster_factions.empty() ) {
                monfactions::finalize();
            }

            for( const mutation_type_registration &entry : pimpl_->mutation_types ) {
                const std::string &id = entry.definition->id;
                pimpl_->mutation_type_undo.emplace_back(
                    id, detail::mutation_type_registry_contains( id ) );
                detail::mutation_type_registry_set( id );
            }

            for( const connect_group_registration &entry : pimpl_->connect_groups ) {
                const std::string &id = entry.definition->id;
                const connect_group *const previous = detail::connect_group_registry_find( id );
                pimpl_->connect_group_undo.emplace_back(
                    id, previous == nullptr ? std::optional<connect_group>() :
                    std::optional<connect_group>( *previous ) );
                connect_group native;
                native.id = connect_group_id( id );
                native.index = 0;
                detail::connect_group_registry_set( native );
            }

            for( const mutation_category_registration &entry : pimpl_->mutation_categories ) {
                const std::string &id = entry.definition->id;
                const mutation_category_trait *const previous =
                    detail::mutation_category_registry_find( id );
                pimpl_->mutation_category_undo.emplace_back(
                    id, previous == nullptr ? std::optional<mutation_category_trait>() :
                    std::optional<mutation_category_trait>( *previous ) );
                const mutation_category_definition_data &source = *entry.definition;
                mutation_category_trait native;
                native.id = mutation_category_id( id );
                native.raw_name = no_translation( source.name );
                native.raw_mutagen_message = no_translation( source.mutagen_message );
                native.raw_memorial_message = source.memorial_message;
                native.threshold_mut = trait_id( source.threshold_mutation );
                native.vitamin = vitamin_id( source.vitamin );
                native.threshold_min = static_cast<int>( source.threshold_minimum );
                native.base_removal_chance = static_cast<int>( source.base_removal_chance );
                native.base_removal_cost_mul = static_cast<float>(
                                                   source.base_removal_cost_multiplier );
                native.wip = source.work_in_progress;
                native.skip_test = source.skip_consistency_test;
                detail::mutation_category_registry_set( native );
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::mutation;
        } else if( phase == creatures_content_apply_phase::behavior ) {

            for( const behavior_registration &entry : pimpl_->behaviors ) {
                const string_id<behavior::node_t> id( entry.definition->id );
                pimpl_->behavior_undo.emplace_back(
                    id, id.is_valid() ? std::optional<behavior::node_t>( id.obj() ) : std::nullopt );
                const behavior_definition_data &source = *entry.definition;
                behavior::node_t native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                if( !source.strategy.empty() ) {
                    native.set_strategy( behavior::strategy_map.at( source.strategy ) );
                }
                if( !source.goal.empty() ) {
                    native.set_goal( source.goal );
                }
                for( const std::string &child : source.children ) {
                    native.add_child_id( child );
                }
                for( const behavior_condition_definition_data &condition : source.conditions ) {
                    if( condition.native ) {
                        native.add_predicate( behavior::predicate_map.at( condition.policy ),
                                              condition.argument, condition.inverted );
                    } else {
                        const std::string owner = pimpl_->owner;
                        const std::string behavior_id = source.id;
                        const std::string handler_id = condition.policy;
                        native.add_predicate(
                            [owner, behavior_id, handler_id]( const behavior::oracle_t *oracle,
                        const std::string & argument ) {
                            const Creature *subject = oracle == nullptr ? nullptr : oracle->get_subject();
                            const std::optional<bool> result = invoke_behavior_condition_handler(
                                                                   owner, behavior_id, handler_id, subject, argument );
                            return result.value_or( false ) ? behavior::status_t::running :
                                   behavior::status_t::failure;
                        }, condition.argument, condition.inverted );
                    }
                }
                if( source.score ) {
                    const behavior_score_definition_data &score = *source.score;
                    if( score.native ) {
                        native.set_score_function( behavior::score_predicate_map.at( score.policy ),
                                                   score.argument );
                    } else {
                        const std::string owner = pimpl_->owner;
                        const std::string behavior_id = source.id;
                        const std::string handler_id = score.policy;
                        native.set_score_function(
                            [owner, behavior_id, handler_id]( const behavior::oracle_t *oracle,
                        const std::string_view argument ) {
                            const Creature *subject = oracle == nullptr ? nullptr : oracle->get_subject();
                            return static_cast<float>( invoke_behavior_score_handler(
                                                           owner, behavior_id, handler_id, subject, argument ).value_or( 0.0 ) );
                        }, score.argument );
                    }
                }
                detail::behavior_registry().insert( native );
            }
            if( !pimpl_->behaviors.empty() ) {
                behavior::finalize();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::effect_type;
        } else if( phase == creatures_content_apply_phase::effect_type ) {

            for( const effect_type_registration &entry : pimpl_->effect_types ) {
                const effect_type_definition_data &source = *entry.definition;
                const effect_type *const previous = detail::effect_type_registry_find( source.id );
                pimpl_->effect_type_undo.emplace_back(
                    source.id, previous == nullptr ? std::optional<effect_type>() :
                    std::optional<effect_type>( *previous ) );
                effect_type native;
                native.id = efftype_id( source.id );
                native.src.emplace_back( native.id, mod_id( pimpl_->owner ) );
                for( const std::string &value : source.names ) {
                    native.name.push_back( no_translation( value ) );
                }
                for( const std::string &value : source.descriptions ) {
                    native.desc.push_back( no_translation( value ) );
                }
                if( source.reduced_descriptions.empty() ) {
                    native.reduced_desc = native.desc;
                } else {
                    for( const std::string &value : source.reduced_descriptions ) {
                        native.reduced_desc.push_back( no_translation( value ) );
                    }
                }
                native.remove_message = source.remove_message.empty() ? translation() :
                                        no_translation( source.remove_message );
                native.apply_memorial_log = source.apply_memorial_log;
                native.remove_memorial_log = source.remove_memorial_log;
                native.blood_analysis_description = source.blood_analysis_description.empty() ?
                                                    translation() : no_translation( source.blood_analysis_description );
                native.max_intensity = static_cast<int>( source.maximum_intensity );
                native.max_duration = time_duration::from_turns(
                                          static_cast<int>( source.maximum_duration_turns ) );
                native.int_dur_factor = time_duration::from_turns(
                                            static_cast<int>( source.intensity_duration_turns ) );
                native.dur_add_perc = static_cast<int>( source.duration_add_percent );
                native.int_add_val = static_cast<int>( source.intensity_add_value );
                native.int_decay_step = static_cast<int>( source.intensity_decay_step );
                native.int_decay_tick = static_cast<int>( source.intensity_decay_tick );
                native.int_decay_remove = source.intensity_decay_removes;
                native.main_parts_only = source.main_parts_only;
                native.show_in_info = source.show_in_info;
                native.show_intensity = source.show_intensity;
                native.part_descs = source.part_descriptions;
                for( const std::string &id : source.flags ) {
                    native.flags.emplace( id );
                }
                for( const std::string &id : source.immune_character_flags ) {
                    native.immune_flags.insert( json_character_flag( id ) );
                }
                for( const std::string &id : source.immune_bodypart_flags ) {
                    native.immune_bp_flags.insert( json_character_flag( id ) );
                }
                for( const std::string &id : source.resist_traits ) {
                    native.resist_traits.emplace_back( id );
                }
                for( const std::string &id : source.resist_effects ) {
                    native.resist_effects.emplace_back( id );
                }
                for( const std::string &id : source.removes_effects ) {
                    native.removes_effects.emplace_back( id );
                }
                for( const std::string &id : source.blocks_effects ) {
                    native.blocks_effects.emplace_back( id );
                }
                detail::effect_type_registry_set( native );
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::sub_body_part;
        } else if( phase == creatures_content_apply_phase::sub_body_part ) {
            static const std::map<std::string, side> platform_body_sides = {
                { "left", side::LEFT }, { "right", side::RIGHT }, { "both", side::BOTH }
            };
            for( const sub_body_part_registration &entry : pimpl_->sub_body_parts ) {
                const sub_bodypart_str_id id( entry.definition->id );
                pimpl_->sub_body_part_undo.emplace_back(
                    id, id.is_valid() ? std::optional<sub_body_part_type>( id.obj() ) :
                    std::nullopt );
                const sub_body_part_definition_data &source = *entry.definition;
                sub_body_part_type native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.opposite = sub_bodypart_str_id( source.opposite );
                native.was_loaded = true;
                native.name = no_translation( source.name );
                native.name_multiple = no_translation( source.plural_name );
                native.part_side = platform_body_sides.at( source.side );
                native.parent = bodypart_str_id( source.parent );
                native.secondary = source.secondary;
                native.max_coverage = static_cast<int>( source.maximum_coverage );
                if( source.locations_under.empty() ) {
                    native.locations_under.push_back( id );
                } else {
                    for( const std::string &location : source.locations_under ) {
                        native.locations_under.emplace_back( location );
                    }
                }
                if( !source.similar_body_part.empty() ) {
                    native.similar_bodypart = sub_bodypart_str_id( source.similar_body_part );
                }
                for( const auto &[damage_id, amount] : source.unarmed_damage ) {
                    native.unarmed_damage.add_damage( damage_type_id( damage_id ),
                                                      static_cast<float>( amount ) );
                }
                detail::sub_body_part_registry().insert( native ).finalize();
            }
            if( !pimpl_->sub_body_parts.empty() ) {
                detail::refresh_sub_body_part_similarity_cache();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::wound_type;
        } else if( phase == creatures_content_apply_phase::wound_type ) {
            for( const wound_type_registration &entry : pimpl_->wound_types ) {
                const wound_type_id id( entry.definition->id );
                pimpl_->wound_type_undo.emplace_back(
                    id, id.is_valid() ? std::optional<wound_type>( id.obj() ) : std::nullopt );
                const wound_type_definition_data &source = *entry.definition;
                wound_type native;
                native.id = id;
                native.was_loaded = true;
                native.name_ = pl_translation( source.name, source.plural_name );
                native.description_ = no_translation( source.description );
                native.pain_ = { static_cast<int>( source.pain_min ),
                                 static_cast<int>( source.pain_max )
                               };
                native.healing_time_ = {
                    time_duration::from_turns( static_cast<int>( source.healing_min_turns ) ),
                    time_duration::from_turns( static_cast<int>( source.healing_max_turns ) )
                };
                native.damage_required = { static_cast<int>( source.damage_min ),
                                           static_cast<int>( source.damage_max )
                                         };
                native.weight = static_cast<int>( source.weight );
                native.limit = static_cast<unsigned int>( source.per_part_limit );
                if( !source.required_body_part_flag.empty() ) {
                    native.whitelist_bp_with_flag = json_character_flag(
                                                        source.required_body_part_flag );
                }
                if( !source.forbidden_body_part_flag.empty() ) {
                    native.blacklist_bp_with_flag = json_character_flag(
                                                        source.forbidden_body_part_flag );
                }
                for( const std::string &damage_id : source.damage_types ) {
                    native.damage_types.emplace_back( damage_id );
                }
                for( const wound_limb_score_definition_data &score : source.limb_scores ) {
                    native.limb_scores.push_back( { limb_score_id( score.id ),
                                                    static_cast<float>( score.penalty ) } );
                }
                for( const wound_progression_definition_data &progression : source.progressions ) {
                    native.wound_progression.push_back( {
                        wound_type_id( progression.id ), static_cast<int>( progression.chance )
                    } );
                }
                for( const std::string &kind : source.required_body_part_types ) {
                    native.whitelist_body_part_types.push_back( io::string_to_enum<bp_type>( kind ) );
                }
                for( const std::string &kind : source.forbidden_body_part_types ) {
                    native.blacklist_body_part_types.push_back( io::string_to_enum<bp_type>( kind ) );
                }
                detail::wound_type_registry().insert( native ).finalize();
            }
            if( !pimpl_->wound_types.empty() ) {
                detail::refresh_body_part_wound_cache();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::body_part;
        } else if( phase == creatures_content_apply_phase::body_part ) {

            static const std::map<std::string, side> platform_body_sides = {
                { "left", side::LEFT }, { "right", side::RIGHT }, { "both", side::BOTH }
            };
            static const std::map<std::string, bp_type> platform_body_part_types = {
                { "head", bp_type::head }, { "torso", bp_type::torso },
                { "sensor", bp_type::sensor }, { "mouth", bp_type::mouth },
                { "arm", bp_type::arm }, { "hand", bp_type::hand },
                { "leg", bp_type::leg }, { "foot", bp_type::foot },
                { "wing", bp_type::wing }, { "tail", bp_type::tail },
                { "other", bp_type::other }
            };
            for( const body_part_registration &entry : pimpl_->body_parts ) {
                const bodypart_str_id id( entry.definition->id );
                pimpl_->body_part_undo.emplace_back(
                    id, id.is_valid() ? std::optional<body_part_type>( id.obj() ) :
                    std::nullopt );
                const body_part_definition_data &source = *entry.definition;
                body_part_type native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                native.legacy_id = "BP_NULL";
                native.token = num_bp;
                native.name = no_translation( source.name );
                native.name_multiple = no_translation( source.plural_name );
                native.accusative = no_translation( source.accusative );
                native.accusative_multiple = no_translation( source.plural_accusative );
                native.name_as_heading = no_translation( source.heading );
                native.name_as_heading_multiple = no_translation( source.plural_heading );
                native.encumb_text = no_translation( source.encumbrance_text );
                native.hp_bar_ui_text = no_translation( source.hp_bar_text );
                native.main_part = bodypart_str_id( source.main_part );
                native.connected_to = bodypart_str_id( source.connected_to );
                native.opposite_part = bodypart_str_id( source.opposite );
                native.part_side = platform_body_sides.at( source.side );
                native.hit_size = static_cast<float>( source.hit_size );
                native.hit_difficulty = static_cast<float>( source.hit_difficulty );
                native.base_hp = static_cast<int>( source.base_health );
                native.drench_max = static_cast<int>( source.drench_capacity );
                native.is_limb = source.limb;
                native.is_vital = source.vital;
                for( const std::string &sub_part : source.sub_parts ) {
                    native.sub_parts.emplace_back( sub_part );
                }
                double highest_weight = -1.0;
                for( const auto &[kind, weight] : source.limb_types ) {
                    const bp_type type = platform_body_part_types.at( kind );
                    native.limbtypes[type] = static_cast<float>( weight );
                    if( weight > highest_weight ) {
                        highest_weight = weight;
                        native._primary_limb_type = type;
                    }
                }
                for( const auto &[damage_id, amount] : source.armor ) {
                    native.armor.set_resist( damage_type_id( damage_id ),
                                             static_cast<float>( amount ) );
                }
                for( const auto &[damage_id, amount] : source.unarmed_damage ) {
                    native.damage.add_damage( damage_type_id( damage_id ),
                                              static_cast<float>( amount ) );
                }
                for( const std::string &flag : source.flags ) {
                    native.flags.insert( json_character_flag( flag ) );
                }
                for( const auto &[score_id, score] : source.limb_scores ) {
                    native.limb_scores[limb_score_id( score_id )] = {
                        static_cast<float>( score.score ), static_cast<float>( score.maximum )
                    };
                }
                for( const body_part_quality_definition_data &quality : source.qualities ) {
                    native.qualities.push_back( {
                        quality_id( quality.id ), static_cast<int>( quality.level ),
                        static_cast<float>( quality.disable_fraction )
                    } );
                }
                detail::body_part_registry().insert( native ).finalize();
            }
            if( !pimpl_->body_parts.empty() ) {
                detail::refresh_body_part_similarity_cache();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::anatomy;
        } else if( phase == creatures_content_apply_phase::anatomy ) {

            for( const anatomy_registration &entry : pimpl_->anatomies ) {
                const anatomy_id id( entry.definition->id );
                pimpl_->anatomy_undo.emplace_back(
                    id, id.is_valid() ? std::optional<anatomy>( id.obj() ) : std::nullopt );
                anatomy native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                for( const std::string &part : entry.definition->parts ) {
                    native.unloaded_bps.emplace_back( part );
                }
                detail::anatomy_registry().insert( native ).finalize();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::body_graph;
        } else if( phase == creatures_content_apply_phase::body_graph ) {

            for( const body_graph_registration &entry : pimpl_->body_graphs ) {
                const bodygraph_id id( entry.definition->id );
                pimpl_->body_graph_undo.emplace_back(
                    id, id.is_valid() ? std::optional<bodygraph>( id.obj() ) : std::nullopt );
                const body_graph_definition_data &source = *entry.definition;
                bodygraph native;
                native.id = id;
                native.was_loaded = true;
                if( !source.parent_body_part.empty() ) {
                    native.parent_bp = bodypart_str_id( source.parent_body_part ).id();
                }
                if( !source.mirror.empty() ) {
                    native.mirror = bodygraph_id( source.mirror );
                }
                for( const std::string &row : source.rows ) {
                    native.rows.push_back( utf8_display_split( row ) );
                }
                for( const std::string &row : source.fill_rows ) {
                    native.fill_rows.push_back( utf8_display_split( row ) );
                }
                native.label_fill = source.label_fill;
                native.fill_sym = source.fill_symbol;
                native.fill_color = color_from_string( source.fill_color,
                                                       report_color_error::no );
                for( const body_graph_part_definition_data &source_part : source.parts ) {
                    bodygraph_part part;
                    for( const std::string &body_part : source_part.body_parts ) {
                        part.bodyparts.push_back( bodypart_str_id( body_part ).id() );
                    }
                    for( const std::string &sub_part : source_part.sub_body_parts ) {
                        part.sub_bodyparts.push_back( sub_bodypart_str_id( sub_part ).id() );
                    }
                    part.nested_graph = source_part.nested_graph.empty() ?
                                        bodygraph_id::NULL_ID() : bodygraph_id( source_part.nested_graph );
                    part.sel_color = color_from_string( source_part.selected_color,
                                                        report_color_error::no );
                    part.sym = source_part.display_symbol.empty() ?
                               native.fill_sym : source_part.display_symbol;
                    native.parts.emplace( source_part.symbol, std::move( part ) );
                }
                detail::bodygraph_registry().insert( native ).finalize();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::field_type;
        } else if( phase == creatures_content_apply_phase::field_type ) {
            for( const field_type_registration &entry : pimpl_->field_types ) {
                const field_type_str_id id( entry.definition->id );
                pimpl_->field_type_undo.emplace_back(
                    id, id.is_valid() ? std::optional<field_type>( id.obj() ) : std::nullopt );
                const field_type_definition_data &source = *entry.definition;
                field_type native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                for( const field_intensity_definition_data &source_level :
                     source.intensity_levels ) {
                    field_intensity_level level;
                    level.name = no_translation( source_level.name );
                    level.symbol = UTF8_getch( source_level.symbol );
                    level.color = color_from_string( source_level.color,
                                                     report_color_error::no );
                    level.dangerous = source_level.dangerous;
                    level.transparent = source_level.transparent;
                    level.move_cost = static_cast<int>( source_level.move_cost );
                    level.intensity_upgrade_chance = static_cast<int>(
                                                         source_level.upgrade_chance );
                    level.intensity_upgrade_duration = time_duration::from_turns(
                                                           static_cast<int>( source_level.upgrade_duration_turns ) );
                    level.light_emitted = static_cast<float>( source_level.light_emitted );
                    level.local_light_override = static_cast<float>(
                                                     source_level.local_light_override );
                    level.translucency = static_cast<float>( source_level.translucency );
                    level.concentration = static_cast<int>( source_level.concentration );
                    level.convection_temperature_mod = static_cast<int>(
                                                           source_level.convection_temperature_modifier );
                    level.scent_neutralization = static_cast<int>(
                                                     source_level.scent_neutralization );
                    for( const field_effect_definition_data &source_effect :
                         source_level.effects ) {
                        field_effect effect;
                        effect.id = efftype_id( source_effect.effect );
                        effect.src.emplace_back( effect.id, mod_id( pimpl_->owner ) );
                        effect.min_duration = time_duration::from_turns(
                                                  static_cast<int>( source_effect.duration_min_turns ) );
                        effect.max_duration = time_duration::from_turns(
                                                  static_cast<int>( source_effect.duration_max_turns ) );
                        effect.intensity = static_cast<int>( source_effect.intensity );
                        effect.bp = source_effect.body_part.empty() ?
                                    bodypart_str_id::NULL_ID() :
                                    bodypart_str_id( source_effect.body_part );
                        effect.is_environmental = source_effect.environmental;
                        effect.message = source_effect.message.empty() ? translation() :
                                         no_translation( source_effect.message );
                        effect.message_npc = source_effect.npc_message.empty() ? translation() :
                                             no_translation( source_effect.npc_message );
                        level.field_effects.push_back( std::move( effect ) );
                    }
                    native.intensity_levels.push_back( std::move( level ) );
                }
                native.underwater_age_speedup = time_duration::from_turns(
                                                    static_cast<int>( source.underwater_age_speedup_turns ) );
                native.outdoor_age_speedup = time_duration::from_turns(
                                                 static_cast<int>( source.outdoor_age_speedup_turns ) );
                native.decay_amount_factor = static_cast<int>( source.decay_amount_factor );
                native.percent_spread = static_cast<int>( source.percent_spread );
                native.gas_absorption_factor = time_duration::from_turns(
                                                   static_cast<int>( source.gas_absorption_turns ) );
                native.priority = static_cast<int>( source.priority );
                native.half_life = time_duration::from_turns(
                                       static_cast<int>( source.half_life_turns ) );
                static const std::map<std::string, phase_id> phases = {
                    { "null", phase_id::PNULL }, { "solid", phase_id::SOLID },
                    { "liquid", phase_id::LIQUID }, { "gas", phase_id::GAS },
                    { "plasma", phase_id::PLASMA }
                };
                static const std::map<std::string, description_affix> affixes = {
                    { "in", description_affix::DESCRIPTION_AFFIX_IN },
                    { "covered_in", description_affix::DESCRIPTION_AFFIX_COVERED_IN },
                    { "on", description_affix::DESCRIPTION_AFFIX_ON },
                    { "under", description_affix::DESCRIPTION_AFFIX_UNDER },
                    { "illuminated_by", description_affix::DESCRIPTION_AFFIX_ILLUMINATED_BY }
                };
                native.phase = phases.at( source.phase );
                native.desc_affix = affixes.at( source.description_affix );
                native.wandering_field = source.wandering_field.empty() ?
                                         field_type_str_id::NULL_ID() :
                                         field_type_str_id( source.wandering_field );
                native.looks_like = source.looks_like;
                native.is_splattering = source.splattering;
                native.has_fire = source.has_fire;
                native.has_acid = source.has_acid;
                native.has_elec = source.has_electricity;
                native.has_fume = source.has_fume;
                native.moppable = source.moppable;
                native.accelerated_decay = source.accelerated_decay;
                native.display_items = source.display_items;
                native.display_field = source.display_field;
                native.linear_half_life = source.linear_half_life;
                native.indestructible = source.indestructible;
                native.mopsafe = source.mopsafe;
                native.decrease_intensity_on_contact = source.decrease_intensity_on_contact;
                for( const std::string &monster_id : source.immune_monsters ) {
                    native.immune_mtypes.emplace( monster_id );
                }
                for( const std::string &monster_id : source.blocked_monsters ) {
                    native.block_mtypes.emplace( monster_id );
                }
                get_all_field_types().insert( native );
            }
            if( !pimpl_->field_types.empty() ) {
                get_all_field_types().finalize();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::monster_attack;
        } else if( phase == creatures_content_apply_phase::monster_attack ) {

            for( const monster_attack_registration &entry : pimpl_->monster_attacks ) {
                const monster_attack_definition_data &source = *entry.definition;
                const mtype_special_attack *previous =
                    detail::monster_attack_registry_find( source.id );
                pimpl_->monster_attack_undo.emplace_back(
                    source.id, previous == nullptr ? std::optional<mtype_special_attack>() :
                    std::optional<mtype_special_attack>( *previous ) );
                auto actor = std::make_unique<lua_monster_attack_actor>(
                                 source.id, source.cooldown, pimpl_->owner, source.handler );
                detail::monster_attack_registry_set( mtype_special_attack( std::move( actor ) ) );
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::weakpoint_set;
        } else if( phase == creatures_content_apply_phase::weakpoint_set ) {

            for( const weakpoint_set_registration &entry : pimpl_->weakpoint_sets ) {
                const weakpoints_id id( entry.definition->id );
                pimpl_->weakpoint_set_undo.emplace_back(
                    id, id.is_valid() ? std::optional<weakpoints>( id.obj() ) : std::nullopt );
                weakpoints native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                for( const weakpoint_definition_data &source_point :
                     entry.definition->weakpoints ) {
                    weakpoint point;
                    point.id = source_point.id;
                    point.name = source_point.name.empty() ? translation() :
                                 no_translation( source_point.name );
                    point.coverage = static_cast<float>( source_point.coverage );
                    point.is_good = source_point.good;
                    point.is_head = source_point.head;
                    const auto copy_damage_map = []( const std::map<std::string, double> &source,
                    std::unordered_map<damage_type_id, float> &target ) {
                        for( const auto &[damage_id, value] : source ) {
                            target[damage_type_id( damage_id )] = static_cast<float>( value );
                        }
                    };
                    copy_damage_map( source_point.armor_multipliers, point.armor_mult );
                    copy_damage_map( source_point.armor_penalties, point.armor_penalty );
                    copy_damage_map( source_point.damage_multipliers, point.damage_mult );
                    copy_damage_map( source_point.critical_multipliers, point.crit_mult );
                    for( const weakpoint_effect_definition_data &source_effect :
                         source_point.effects ) {
                        weakpoint_effect effect;
                        effect.effect = efftype_id( source_effect.effect );
                        effect.chance = static_cast<float>( source_effect.chance );
                        effect.permanent = source_effect.permanent;
                        effect.duration = {
                            time_duration::from_turns(
                                static_cast<int>( source_effect.duration_min_turns ) ),
                            time_duration::from_turns(
                                static_cast<int>( source_effect.duration_max_turns ) )
                        };
                        effect.intensity = {
                            static_cast<int>( source_effect.intensity_min ),
                            static_cast<int>( source_effect.intensity_max )
                        };
                        effect.damage_required = {
                            static_cast<float>( source_effect.damage_required_min ),
                            static_cast<float>( source_effect.damage_required_max )
                        };
                        effect.message = source_effect.message.empty() ? translation() :
                                         no_translation( source_effect.message );
                        effect.lua_platform_mod = pimpl_->owner;
                        effect.lua_platform_handler = source_effect.handler;
                        effect.lua_platform_set_id = entry.definition->id;
                        effect.lua_platform_weakpoint_id = source_point.id;
                        point.effects.push_back( std::move( effect ) );
                    }
                    native.weakpoint_list.push_back( std::move( point ) );
                }
                std::sort( native.weakpoint_list.begin(), native.weakpoint_list.end(),
                []( const weakpoint & lhs, const weakpoint & rhs ) {
                    return lhs.coverage < rhs.coverage;
                } );
                detail::weakpoint_set_registry().insert( native ).finalize();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::morale_type;
        } else if( phase == creatures_content_apply_phase::morale_type ) {
            for( const morale_type_registration &entry : pimpl_->morale_types ) {
                const morale_type id( entry.definition->id );
                pimpl_->morale_type_undo.emplace_back(
                    id, id.is_valid() ? std::optional<morale_type_data>( id.obj() ) :
                    std::nullopt );
                morale_type_data native;
                native.id = id;
                native.was_loaded = true;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.text = no_translation( entry.definition->text );
                native.permanent = entry.definition->permanent;
                detail::morale_type_registry().insert( native );
            }
            if( !pimpl_->morale_types.empty() ) {
                detail::morale_type_registry().finalize();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::disease_type;
        } else if( phase == creatures_content_apply_phase::disease_type ) {

            for( const disease_type_registration &entry : pimpl_->disease_types ) {
                const diseasetype_id id( entry.definition->id );
                pimpl_->disease_type_undo.emplace_back(
                    id, id.is_valid() ? std::optional<disease_type>( id.obj() ) :
                    std::nullopt );
                const disease_type_definition_data &source = *entry.definition;
                disease_type native;
                native.id = id;
                native.was_loaded = true;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.min_duration = time_duration::from_turns(
                                          static_cast<int>( source.minimum_duration_turns ) );
                native.max_duration = time_duration::from_turns(
                                          static_cast<int>( source.maximum_duration_turns ) );
                native.min_intensity = static_cast<int>( source.minimum_intensity );
                native.max_intensity = static_cast<int>( source.maximum_intensity );
                native.symptoms = efftype_id( source.symptoms );
                if( source.health_threshold ) {
                    native.health_threshold = static_cast<int>( *source.health_threshold );
                }
                for( const std::string &body_part : source.affected_body_parts ) {
                    native.affected_bodyparts.insert( bodypart_str_id( body_part ) );
                }
                detail::disease_type_registry().insert( native );
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::wound_fix;
        } else if( phase == creatures_content_apply_phase::wound_fix ) {

            for( const wound_fix_registration &entry : pimpl_->wound_fixes ) {
                const wound_fix_id id( entry.definition->id );
                pimpl_->wound_fix_undo.emplace_back(
                    id, id.is_valid() ? std::optional<wound_fix>( id.obj() ) : std::nullopt );
                const wound_fix_definition_data &source = *entry.definition;
                wound_fix native;
                native.id = id;
                native.was_loaded = true;
                native.name = no_translation( source.name );
                native.description = no_translation( source.description );
                native.success_msg = no_translation( source.success_message );
                native.time = time_duration::from_turns( static_cast<int>( source.duration_turns ) );
                native.mod_hp = static_cast<int>( source.health_delta );
                for( const auto &[skill, level] : source.skills ) {
                    native.skills.emplace( skill_id( skill ), static_cast<int>( level ) );
                }
                for( const wound_fix_proficiency_definition_data &proficiency :
                     source.proficiencies ) {
                    native.proficiencies.push_back( {
                        proficiency_id( proficiency.id ),
                        static_cast<float>( proficiency.multiplier ), proficiency.mandatory
                    } );
                }
                for( const std::string &wound_id : source.wounds_removed ) {
                    native.wounds_removed.emplace( wound_id );
                }
                for( const std::string &wound_id : source.wounds_added ) {
                    native.wounds_added.emplace( wound_id );
                }
                for( const wound_fix_requirement_definition_data &requirement :
                     source.requirements ) {
                    native.requirement_refs.emplace_back(
                        requirement_id( requirement.id ), static_cast<int>( requirement.count ) );
                }
                detail::wound_fix_registry().insert( native ).finalize();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::monster;

        } else if( phase == creatures_content_apply_phase::monster ) {
            static const std::map<std::string, phase_id> monster_phases = {
                { "null", phase_id::PNULL }, { "solid", phase_id::SOLID },
                { "liquid", phase_id::LIQUID }, { "gas", phase_id::GAS },
                { "plasma", phase_id::PLASMA }
            };
            static const std::map<std::string, mon_trigger> monster_triggers = {
                { "STALK", mon_trigger::STALK },
                { "PLAYER_WEAK", mon_trigger::HOSTILE_WEAK },
                { "PLAYER_CLOSE", mon_trigger::HOSTILE_CLOSE },
                { "HOSTILE_SEEN", mon_trigger::HOSTILE_SEEN },
                { "HURT", mon_trigger::HURT }, { "FIRE", mon_trigger::FIRE },
                { "FRIEND_DIED", mon_trigger::FRIEND_DIED },
                { "FRIEND_ATTACKED", mon_trigger::FRIEND_ATTACKED },
                { "SOUND", mon_trigger::SOUND },
                { "PLAYER_NEAR_BABY", mon_trigger::PLAYER_NEAR_BABY },
                { "MATING_SEASON", mon_trigger::MATING_SEASON },
                { "BRIGHT_LIGHT", mon_trigger::BRIGHT_LIGHT }
            };
            for( const monster_registration &entry : pimpl_->monsters ) {
                const mtype_id id( entry.definition->id );
                pimpl_->monster_undo.emplace_back(
                    id, id.is_valid() ? std::optional<mtype>( id.obj() ) : std::nullopt );
                const monster_definition_data &source = *entry.definition;
                mtype native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                native.name = pl_translation( source.name, source.plural_name );
                native.description = source.description.empty() ? translation() :
                                     no_translation( source.description );
                native.sym = source.symbol;
                native.color = color_from_string( source.color, report_color_error::no );
                native.looks_like = source.looks_like;
                native.bodytype = source.body_type;
                native.default_faction = mfaction_str_id( source.default_faction );
                native.harvest = harvest_id( source.harvest );
                native.dissect = source.dissect.empty() ? harvest_id::NULL_ID() :
                                 harvest_id( source.dissect );
                native.decay = source.decay.empty() ? harvest_id::NULL_ID() :
                               harvest_id( source.decay );
                native.speed_desc = speed_description_id( source.speed_description );
                native.death_drops = source.death_drops.empty() ? item_group_id::NULL_ID() :
                                     item_group_id( source.death_drops );
                native.volume = units::from_milliliter<std::int64_t>( source.volume_ml );
                native.weight = units::from_gram<std::int64_t>( source.weight_grams );
                native.phase = monster_phases.at( source.phase );
                native.difficulty_adjustment = static_cast<int>( source.difficulty_adjustment );
                native.hp = static_cast<int>( source.hp );
                native.speed = static_cast<int>( source.speed );
                native.agro = static_cast<int>( source.aggression );
                native.morale = static_cast<int>( source.morale );
                native.tracking_distance = static_cast<int>( source.tracking_distance );
                native.attack_cost = static_cast<int>( source.attack_cost );
                native.melee_skill = static_cast<int>( source.melee_skill );
                native.melee_dice = static_cast<int>( source.melee_dice );
                native.melee_sides = static_cast<int>( source.melee_sides );
                native.melee_dice_ap = static_cast<int>( source.melee_armor_penetration );
                native.sk_dodge = static_cast<int>( source.dodge );
                native.vision_day = static_cast<int>( source.vision_day );
                native.vision_night = static_cast<int>( source.vision_night );
                native.regenerates = static_cast<int>( source.regenerates );
                native.bleed_rate = static_cast<int>( source.bleed_rate );
                native.status_chance_multiplier = static_cast<float>(
                                                      source.status_chance_multiplier );
                native.luminance = static_cast<float>( source.luminance );
                native.regenerates_in_dark = source.regenerates_in_dark;
                native.regen_morale = source.regenerates_morale;
                native.aggro_character = source.aggressive_to_characters;
                native.sp_defense = &mdefense::none;
                native.mdeath_effect.lua_platform_mod = pimpl_->owner;
                native.mdeath_effect.lua_platform_handler = source.death_handler;
                native.mat.clear();
                native.mat_portion_total = 0;
                if( source.materials.empty() ) {
                    native.mat.emplace( material_id( "flesh" ), 1 );
                    native.mat_portion_total = 1;
                } else {
                    for( const auto &[material, portions] : source.materials ) {
                        native.mat.emplace( material_id( material ), static_cast<int>( portions ) );
                        native.mat_portion_total += static_cast<int>( portions );
                    }
                }
                for( const std::string &species : source.species ) {
                    native.species.emplace( species_id( species ) );
                }
                native.categories = source.categories;
                native.pre_flags_.clear();
                for( const std::string &flag : source.flags ) {
                    native.pre_flags_.emplace( flag );
                }
                for( const auto &[damage_id, value] : source.armor ) {
                    native.armor.set_resist( damage_type_id( damage_id ),
                                             static_cast<float>( value ) );
                }
                for( const auto &[damage_id, value] : source.melee_damage ) {
                    native.melee_damage.add_damage( damage_type_id( damage_id ),
                                                    static_cast<float>( value.amount ),
                                                    static_cast<float>( value.armor_penetration ) );
                }
                for( const monster_attack_reference_definition_data &source_attack :
                     source.attacks ) {
                    const mtype_special_attack *prototype =
                        detail::monster_attack_registry_find( source_attack.id );
                    std::unique_ptr<mattack_actor> actor = prototype->get()->clone();
                    if( source_attack.cooldown ) {
                        actor->cooldown = *source_attack.cooldown;
                    }
                    const auto callback = source.attack_handlers.find( source_attack.id );
                    if( callback != source.attack_handlers.end() &&
                        dynamic_cast<melee_actor *>( actor.get() ) == nullptr ) {
                        actor = std::make_unique<lua_monster_attack_result_actor>(
                                    std::move( actor ), source.id, pimpl_->owner,
                                    callback->second );
                    }
                    native.special_attacks.emplace( source_attack.id,
                                                    mtype_special_attack( std::move( actor ) ) );
                    native.special_attacks_names.push_back( source_attack.id );
                }
                native.lua_platform_attack_mod = pimpl_->owner;
                native.lua_platform_attack_handlers = source.attack_handlers;
                for( const std::string &set : source.weakpoint_sets ) {
                    native.weakpoints_deferred.emplace_back( set );
                }
                for( const auto &[emission, interval_turns] : source.emissions ) {
                    native.emit_fields.emplace( emit_id( emission ),
                                                time_duration::from_turns( static_cast<int>( interval_turns ) ) );
                }
                for( const auto &[item_id, amount] : source.starting_ammo ) {
                    native.starting_ammo.emplace( itype_id( item_id ),
                                                  static_cast<int>( amount ) );
                }
                for( const std::string &scent : source.tracked_scents ) {
                    native.scents_tracked.emplace( scent );
                }
                for( const std::string &scent : source.ignored_scents ) {
                    native.scents_ignored.emplace( scent );
                }
                for( const auto &[effect, amount] : source.regeneration_modifiers ) {
                    native.regeneration_modifiers.emplace( efftype_id( effect ),
                                                           static_cast<int>( amount ) );
                }
                for( const std::string &goal : source.goals ) {
                    native.add_goal( goal );
                }
                for( const std::string &trigger : source.anger_triggers ) {
                    native.anger.set( monster_triggers.at( trigger ) );
                }
                for( const std::string &trigger : source.fear_triggers ) {
                    native.fear.set( monster_triggers.at( trigger ) );
                }
                for( const std::string &trigger : source.placate_triggers ) {
                    native.placate.set( monster_triggers.at( trigger ) );
                }
                mtype &inserted = detail::monster_type_registry().insert( native );
                MonsterGenerator::generator().finalize_lua_first_mtype_if_ready(
                    inserted, DynamicDataLoader::get_instance().is_data_finalized() );
            }
            if( !pimpl_->monsters.empty() ) {
                MonsterGenerator::generator().refresh_hallucination_monsters();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::finalize;
        } else if( phase == creatures_content_apply_phase::mutation ) {
            for( const mutation_registration &entry : pimpl_->mutations ) {
                const trait_id id( entry.definition->id );
                pimpl_->mutation_undo.emplace_back(
                    id, id.is_valid() ? std::optional<mutation_branch>( id.obj() ) : std::nullopt );
                const mutation_definition_data &source = *entry.definition;
                mutation_branch native;
                native.id = id;
                native.src.emplace_back( id, mod_id( pimpl_->owner ) );
                native.was_loaded = true;
                native.set_platform_text( source.name, source.description );
                native.points = static_cast<int>( source.points );
                native.vitamin_cost = static_cast<int>( source.vitamin_cost );
                native.visibility = static_cast<int>( source.visibility );
                native.ugliness = static_cast<int>( source.ugliness );
                native.cost = static_cast<int>( source.activation_cost );
                native.cooldown = time_duration::from_turns( source.cooldown_turns );
                native.bodytemp_min = units::from_legacy_bodypart_temp_delta(
                                          static_cast<int>( source.bodytemp_min ) );
                native.bodytemp_max = units::from_legacy_bodypart_temp_delta(
                                          static_cast<int>( source.bodytemp_max ) );
                if( source.scent_intensity ) {
                    native.scent_intensity = static_cast<int>( *source.scent_intensity );
                }
                native.social_mods.lie = static_cast<int>( source.social_lie );
                native.social_mods.persuade = static_cast<int>( source.social_persuade );
                native.social_mods.intimidate = static_cast<int>( source.social_intimidate );
                native.startingtrait = source.starting_trait;
                native.chargen_allow_npc = source.chargen_allow_npc;
                native.random_start_allowed = source.random_start_allowed;
                native.mixed_effect = source.mixed_effect;
                native.activated = source.active;
                native.starts_active = source.starts_active;
                native.destroys_gear = source.destroys_gear;
                native.allow_soft_gear = source.allow_soft_gear;
                native.hunger = source.consumes_kcal;
                native.thirst = source.consumes_thirst;
                native.sleepiness = source.consumes_sleepiness;
                native.mana = source.consumes_mana;
                native.stamina = source.consumes_stamina;
                native.valid = source.valid;
                native.purifiable = source.purifiable;
                native.threshold = source.threshold;
                native.strict_threshreq = source.strict_threshold_requirement;
                native.profession = source.profession;
                native.debug = source.debug;
                native.player_display = source.player_display;
                native.vanity = source.vanity;
                native.dummy = source.dummy;
                native.hide_on_activated = source.hide_on_activated;
                native.hide_on_deactivated = source.hide_on_deactivated;
                native.activation_msg = no_translation(
                                            source.activation_message.empty() ?
                                            "You activate your %s." : source.activation_message );
                if( !source.scent_type.empty() ) {
                    native.scent_typeid = scenttype_id( source.scent_type );
                }
                if( !source.spawn_item.empty() ) {
                    native.set_platform_spawn_item(
                        source.spawn_item, source.spawn_item_message );
                }
                if( !source.ranged_mutation.empty() ) {
                    native.set_platform_ranged_mutation(
                        source.ranged_mutation, source.ranged_mutation_message );
                }
                if( !source.override_look_id.empty() ) {
                    native.override_look.emplace(
                        source.override_look_id, source.override_look_category );
                }
                if( source.transform ) {
                    native.transform = cata::make_value<mut_transform>();
                    native.transform->target = trait_id( source.transform->target );
                    native.transform->msg_transform = no_translation( source.transform->message );
                    native.transform->active = source.transform->active;
                    native.transform->safe = source.transform->safe;
                    native.transform->moves = static_cast<int>( source.transform->moves );
                }
                if( source.personality ) {
                    native.personality_score = cata::make_value<mut_personality_score>();
                    native.personality_score->min_aggression = static_cast<int>(
                                source.personality->min_aggression );
                    native.personality_score->max_aggression = static_cast<int>(
                                source.personality->max_aggression );
                    native.personality_score->min_bravery = static_cast<int>(
                            source.personality->min_bravery );
                    native.personality_score->max_bravery = static_cast<int>(
                            source.personality->max_bravery );
                    native.personality_score->min_collector = static_cast<int>(
                                source.personality->min_collector );
                    native.personality_score->max_collector = static_cast<int>(
                                source.personality->max_collector );
                    native.personality_score->min_altruism = static_cast<int>(
                                source.personality->min_altruism );
                    native.personality_score->max_altruism = static_cast<int>(
                                source.personality->max_altruism );
                }
                for( const mutation_variant_definition_data &variant : source.variants ) {
                    mutation_variant value;
                    value.id = variant.id;
                    value.alt_name = no_translation( variant.name );
                    value.alt_description = no_translation( variant.description );
                    value.append_desc = variant.append_description;
                    value.weight = static_cast<int>( variant.weight );
                    value.parent = id;
                    native.variants.emplace( value.id, std::move( value ) );
                }
                for( const std::string &value : source.initial_martial_arts ) {
                    native.initial_ma_styles.emplace_back( value );
                }
                for( const std::string &value : source.threshold_substitutes ) {
                    native.threshold_substitutes.emplace_back( value );
                }
                for( const auto &[vitamin, turns] : source.vitamin_rates ) {
                    native.vitamin_rates.emplace(
                        vitamin_id( vitamin ), time_duration::from_turns( turns ) );
                }
                for( const auto &[material, vitamin, multiplier] : source.vitamin_absorption ) {
                    native.vitamin_absorb_multi[material_id( material )].emplace(
                        vitamin_id( vitamin ), multiplier );
                }
                for( const auto &[quality, amount] : source.provided_qualities ) {
                    native.provided_qualities.emplace(
                        quality_id( quality ), static_cast<int>( amount ) );
                }
                for( const std::string &value : source.ignored_by ) {
                    native.ignored_by.emplace_back( value );
                }
                for( const std::string &value : source.empathize_with ) {
                    native.empathize_with.emplace_back( value );
                }
                for( const std::string &value : source.no_empathize_with ) {
                    native.no_empathize_with.emplace_back( value );
                }
                for( const std::string &value : source.can_only_eat ) {
                    native.can_only_eat.emplace( value );
                }
                for( const std::string &value : source.can_only_heal_with ) {
                    native.can_only_heal_with.emplace( value );
                }
                for( const std::string &value : source.can_heal_with ) {
                    native.can_heal_with.emplace( value );
                }
                for( const std::string &value : source.allowed_categories ) {
                    native.allowed_category.emplace( value );
                }
                for( const std::string &value : source.prereqs ) {
                    native.prereqs.emplace_back( value );
                }
                for( const std::string &value : source.prereqs2 ) {
                    native.prereqs2.emplace_back( value );
                }
                for( const std::string &value : source.threshold_requirements ) {
                    native.threshreq.emplace_back( value );
                }
                for( const std::string &value : source.cancels ) {
                    native.cancels.emplace_back( value );
                }
                for( const std::string &value : source.replacements ) {
                    native.replacements.emplace_back( value );
                }
                for( const std::string &value : source.additions ) {
                    native.additions.emplace_back( value );
                }
                native.types.insert( source.types.begin(), source.types.end() );
                for( const std::string &value : source.categories ) {
                    native.category.emplace_back( value );
                }
                for( const std::string &value : source.flags ) {
                    native.flags.emplace( value );
                }
                for( const std::string &value : source.active_flags ) {
                    native.active_flags.emplace( value );
                }
                for( const std::string &value : source.inactive_flags ) {
                    native.inactive_flags.emplace( value );
                }
                for( const auto &[monster, amount] : source.monster_cameras ) {
                    native.moncams.emplace( mtype_id( monster ), static_cast<int>( amount ) );
                }
                for( const std::string &value : source.enchantments ) {
                    native.enchantments.emplace_back( value );
                }
                for( const std::string &value : source.no_cbm_bodyparts ) {
                    native.no_cbm_on_bp.emplace( value );
                }
                for( const auto &[spell, level] : source.learned_spells ) {
                    native.spells_learned.emplace( spell_id( spell ), static_cast<int>( level ) );
                }
                for( const auto &[skill, amount] : source.craft_skill_bonuses ) {
                    native.craft_skill_bonus.emplace( skill_id( skill ), static_cast<int>( amount ) );
                }
                for( const auto &[bodypart, amount] : source.lumination ) {
                    native.lumination.emplace( bodypart_str_id( bodypart ), static_cast<float>( amount ) );
                }
                for( const auto &[species, amount] : source.anger_relations ) {
                    native.anger_relations.emplace( species_id( species ), static_cast<int>( amount ) );
                }
                for( const mutation_wet_protection_definition_data &value :
                     source.wet_protection ) {
                    native.protection.emplace(
                        bodypart_str_id( value.bodypart ),
                        tripoint( static_cast<int>( value.ignored ),
                                  static_cast<int>( value.neutral ),
                                  static_cast<int>( value.good ) ) );
                }
                for( const auto &[bodypart, amount] : source.encumbrance_always ) {
                    native.encumbrance_always.emplace(
                        bodypart_str_id( bodypart ), static_cast<int>( amount ) );
                }
                for( const auto &[bodypart, amount] : source.encumbrance_covered ) {
                    native.encumbrance_covered.emplace(
                        bodypart_str_id( bodypart ), static_cast<int>( amount ) );
                }
                for( const auto &[bodypart, amount] : source.encumbrance_multipliers ) {
                    native.encumbrance_multiplier_always.emplace(
                        bodypart_str_id( bodypart ), static_cast<float>( amount ) );
                }
                for( const std::string &value : source.restricts_gear ) {
                    if( bodypart_str_id( value ).is_valid() ) {
                        native.restricts_gear.emplace( value );
                    } else {
                        native.restricts_gear_subparts.emplace( value );
                    }
                }
                for( const std::string &value : source.remove_rigid ) {
                    if( bodypart_str_id( value ).is_valid() ) {
                        native.remove_rigid.emplace( value );
                    } else {
                        native.remove_rigid_subparts.emplace( value );
                    }
                }
                for( const std::string &value : source.allowed_item_flags ) {
                    native.allowed_items.emplace( value );
                }
                for( const mutation_armor_definition_data &value : source.armor ) {
                    native.armor[bodypart_str_id( value.bodypart )].set_resist(
                        damage_type_id( value.damage_type ), static_cast<float>( value.amount ) );
                }
                for( const std::string &value : source.integrated_armor ) {
                    native.integrated_armor.emplace_back( value );
                }
                for( const auto &[bodypart, amount] : source.bionic_slot_bonuses ) {
                    native.set_platform_bionic_slot_bonus(
                        bodypart_str_id( bodypart ), static_cast<int>( amount ) );
                }
                const auto add_damage = []( damage_instance & target,
                const mutation_damage_definition_data & value ) {
                    target.add_damage(
                        damage_type_id( value.damage_type ), static_cast<float>( value.amount ),
                        static_cast<float>( value.armor_penetration ),
                        static_cast<float>( value.armor_penetration_multiplier ),
                        static_cast<float>( value.damage_multiplier ),
                        static_cast<float>( value.unconditional_armor_penetration_multiplier ),
                        static_cast<float>( value.unconditional_damage_multiplier ) );
                };
                for( const mutation_attack_definition_data &value : source.attacks ) {
                    mut_attack attack;
                    attack.attack_text_u = no_translation( value.player_message );
                    attack.attack_text_npc = no_translation( value.npc_message );
                    for( const std::string &required : value.required_mutations ) {
                        attack.required_mutations.emplace( required );
                    }
                    for( const std::string &blocker : value.blocker_mutations ) {
                        attack.blocker_mutations.emplace( blocker );
                    }
                    if( !value.bodypart.empty() ) {
                        attack.bp = bodypart_str_id( value.bodypart );
                    }
                    attack.chance = static_cast<int>( value.chance );
                    attack.hardcoded_effect = value.hardcoded;
                    for( const mutation_damage_definition_data &damage : value.base_damage ) {
                        add_damage( attack.base_damage, damage );
                    }
                    for( const mutation_damage_definition_data &damage : value.strength_damage ) {
                        add_damage( attack.strength_damage, damage );
                    }
                    native.attacks_granted.push_back( std::move( attack ) );
                }
                for( const std::vector<mutation_reflex_definition_data> &group :
                     source.reflex_triggers ) {
                    std::vector<reflex_activation_data> native_group;
                    native_group.reserve( group.size() );
                    for( const mutation_reflex_definition_data &value : group ) {
                        reflex_activation_data trigger;
                        const std::string owner = pimpl_->owner;
                        const std::string mutation_id = source.id;
                        const std::string handler = value.handler;
                        trigger.trigger = [owner, mutation_id, handler](
                        const const_dialogue & dialogue ) {
                            return detail::invoke_mutation_condition_handler(
                                       owner, mutation_id, handler, dialogue ).value_or( false );
                        };
                        trigger.msg_on = {
                            no_translation( value.message_on ),
                            *io::string_to_enum_optional<game_message_type>( value.message_on_type )
                        };
                        trigger.msg_off = {
                            no_translation( value.message_off ),
                            *io::string_to_enum_optional<game_message_type>( value.message_off_type )
                        };
                        trigger.was_loaded = true;
                        native_group.push_back( std::move( trigger ) );
                    }
                    native.trigger_list.push_back( std::move( native_group ) );
                }
                for( const mutation_comfort_definition_data &value : source.comfort ) {
                    comfort_data comfort;
                    comfort.conditions_or = value.conditions_or;
                    comfort.base_comfort = static_cast<int>( value.base_comfort );
                    comfort.add_human_comfort = value.add_human_comfort;
                    comfort.use_better_comfort = value.use_better_comfort;
                    comfort.add_sleep_aids = value.add_sleep_aids;
                    comfort.msg_try.text = no_translation( value.try_message );
                    comfort.msg_try.type = *io::string_to_enum_optional<game_message_type>(
                                               value.try_message_type );
                    comfort.msg_hint.text = no_translation( value.hint_message );
                    comfort.msg_hint.type = *io::string_to_enum_optional<game_message_type>(
                                                value.hint_message_type );
                    comfort.msg_sleep.text = no_translation( value.sleep_message );
                    comfort.msg_sleep.type = *io::string_to_enum_optional<game_message_type>(
                                                 value.sleep_message_type );
                    for( const mutation_comfort_condition_definition_data &condition :
                         value.conditions ) {
                        comfort_data::condition native_condition;
                        native_condition.ccategory =
                            *io::string_to_enum_optional<comfort_data::category>( condition.type );
                        native_condition.id = condition.id;
                        native_condition.flag = condition.flag;
                        native_condition.intensity = static_cast<int>( condition.intensity );
                        native_condition.active = condition.active;
                        native_condition.invert = condition.invert;
                        comfort.conditions.push_back( std::move( native_condition ) );
                    }
                    comfort.was_loaded = true;
                    native.comfort.push_back( std::move( comfort ) );
                }
                detail::mutation_registry().insert( native );
            }

            if( !pimpl_->mutations.empty() ) {
                detail::mutation_registry().finalize();
                detail::refresh_mutation_registry_cache();
            }
            pimpl_->next_apply_phase = creatures_content_apply_phase::behavior;
        } else if( phase == creatures_content_apply_phase::finalize ) {
            for( const field_type_registration &entry : pimpl_->field_types ) {
                field_type &native = const_cast<field_type &>(
                                         field_type_str_id( entry.definition->id ).obj() );
                native.finalize();
            }
            if( !pimpl_->wound_fixes.empty() ) {
                detail::wound_fix_registry().finalize();
                for( const wound_fix_registration &entry : pimpl_->wound_fixes ) {
                    const wound_fix &native = wound_fix_id( entry.definition->id ).obj();
                    if( native.requirement_refs.size() != entry.definition->requirements.size() ) {
                        throw std::runtime_error( "wound fix '" + entry.definition->id +
                                                  "' changed its requirement references while applying" );
                    }
                }
            }
            if( !pimpl_->wound_types.empty() || !pimpl_->wound_fixes.empty() ||
                !pimpl_->body_parts.empty() ) {
                detail::refresh_wound_fix_links();
                detail::refresh_body_part_wound_cache();
            }
            pimpl_->applied = true;
            pimpl_->next_apply_phase = creatures_content_apply_phase::finalize;
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        rollback_all();
        error = "Lua-first Mod '" + pimpl_->owner + "': " + exception.what();
        return false;
    }
}

bool creatures_content_transaction::validate_finalized( std::string &error ) const
{
    if( !pimpl_->applied ) {
        error = "creature content transaction for '" + pimpl_->owner + "' is not applied";
        return false;
    }
    if( pimpl_->finalization_validated ) {
        error = "creature content finalization for '" + pimpl_->owner +
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
    for( const auto &entry : pimpl_->behaviors ) {
        if( !require_valid( string_id<behavior::node_t>( entry.definition->id ).is_valid(),
                            "behavior", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->effect_types ) {
        if( !require_valid( detail::effect_type_registry_find( entry.definition->id ) != nullptr,
                            "effect type", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->monster_attacks ) {
        if( !require_valid( detail::monster_attack_registry_find( entry.definition->id ) != nullptr,
                            "monster attack", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->weakpoint_sets ) {
        if( !require_valid( weakpoints_id( entry.definition->id ).is_valid(),
                            "weakpoint set", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->field_types ) {
        if( !require_valid( field_type_str_id( entry.definition->id ).is_valid(),
                            "field type", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->sub_body_parts ) {
        if( !require_valid( sub_bodypart_str_id( entry.definition->id ).is_valid(),
                            "sub body part", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->wound_types ) {
        if( !require_valid( wound_type_id( entry.definition->id ).is_valid(),
                            "wound", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->body_parts ) {
        if( !require_valid( bodypart_str_id( entry.definition->id ).is_valid(),
                            "body part", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->wound_fixes ) {
        if( !require_valid( wound_fix_id( entry.definition->id ).is_valid(),
                            "wound fix", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->anatomies ) {
        if( !require_valid( anatomy_id( entry.definition->id ).is_valid(),
                            "anatomy", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->body_graphs ) {
        if( !require_valid( bodygraph_id( entry.definition->id ).is_valid(),
                            "body graph", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->monsters ) {
        if( !require_valid( mtype_id( entry.definition->id ).is_valid(),
                            "monster", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->morale_types ) {
        if( !require_valid( morale_type( entry.definition->id ).is_valid(),
                            "morale type", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->disease_types ) {
        if( !require_valid( diseasetype_id( entry.definition->id ).is_valid(),
                            "disease type", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->monster_flags ) {
        if( !require_valid( mon_flag_str_id( entry.definition->id ).is_valid(),
                            "monster flag", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->species ) {
        if( !require_valid( species_id( entry.definition->id ).is_valid(),
                            "species", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->emissions ) {
        if( !require_valid( detail::emission_registry_find( entry.definition->id ) != nullptr,
                            "emission", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->monster_factions ) {
        if( !require_valid( mfaction_str_id( entry.definition->id ).is_valid(),
                            "monster faction", entry.definition->id ) ) {
            return false;
        }
    }
    for( const auto &entry : pimpl_->mutations ) {
        if( !require_valid( trait_id( entry.definition->id ).is_valid(),
                            "mutation", entry.definition->id ) ) {
            return false;
        }
    }
    pimpl_->finalization_validated = true;
    error.clear();
    return true;
}

void creatures_content_transaction::prepare_rollback(
    const bool external_requirement_changes )
{
    if( external_requirement_changes ) {
        pimpl_->wound_fix_registry_dirty = true;
    }
}

void creatures_content_transaction::rollback_phase( const creatures_content_rollback_phase phase )
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
        case creatures_content_rollback_phase::monster: {
            const bool had_monsters = !pimpl_->monster_undo.empty();
            restore_factory( detail::monster_type_registry(), pimpl_->monster_undo );
            if( had_monsters ) {
                MonsterGenerator::generator().refresh_hallucination_monsters();
                MonsterGenerator::generator().refresh_behavior_goals();
            }
            break;
        }
        case creatures_content_rollback_phase::wound_fix:
            if( !pimpl_->wound_fix_undo.empty() ) {
                pimpl_->wound_fix_registry_dirty = true;
                pimpl_->wound_fix_links_dirty = true;
            }
            restore_factory( detail::wound_fix_registry(), pimpl_->wound_fix_undo );
            break;
        case creatures_content_rollback_phase::disease_type:
            restore_factory( detail::disease_type_registry(), pimpl_->disease_type_undo );
            break;
        case creatures_content_rollback_phase::morale_type:
            restore_factory( detail::morale_type_registry(), pimpl_->morale_type_undo );
            break;
        case creatures_content_rollback_phase::weakpoint_set:
            restore_factory( detail::weakpoint_set_registry(), pimpl_->weakpoint_set_undo );
            break;
        case creatures_content_rollback_phase::monster_attack:
            for( auto it = pimpl_->monster_attack_undo.rbegin();
                 it != pimpl_->monster_attack_undo.rend(); ++it ) {
                if( it->second ) {
                    detail::monster_attack_registry_set( *it->second );
                } else {
                    detail::monster_attack_registry_erase( it->first );
                }
            }
            pimpl_->monster_attack_undo.clear();
            break;
        case creatures_content_rollback_phase::field_type:
            restore_factory( get_all_field_types(), pimpl_->field_type_undo );
            break;
        case creatures_content_rollback_phase::body_graph:
            restore_factory( detail::bodygraph_registry(), pimpl_->body_graph_undo );
            break;
        case creatures_content_rollback_phase::anatomy:
            restore_factory( detail::anatomy_registry(), pimpl_->anatomy_undo );
            break;
        case creatures_content_rollback_phase::body_part: {
            const bool had_body_parts = !pimpl_->body_part_undo.empty();
            if( had_body_parts ) {
                pimpl_->wound_fix_links_dirty = true;
            }
            restore_factory( detail::body_part_registry(), pimpl_->body_part_undo );
            if( had_body_parts ) {
                detail::refresh_body_part_similarity_cache();
            }
            break;
        }
        case creatures_content_rollback_phase::wound_type:
            if( !pimpl_->wound_type_undo.empty() ) {
                pimpl_->wound_fix_links_dirty = true;
            }
            restore_factory( detail::wound_type_registry(), pimpl_->wound_type_undo );
            break;
        case creatures_content_rollback_phase::sub_body_part: {
            const bool had_sub_body_parts = !pimpl_->sub_body_part_undo.empty();
            restore_factory( detail::sub_body_part_registry(), pimpl_->sub_body_part_undo );
            if( had_sub_body_parts ) {
                detail::refresh_sub_body_part_similarity_cache();
            }
            break;
        }
        case creatures_content_rollback_phase::effect_type:
            for( auto it = pimpl_->effect_type_undo.rbegin();
                 it != pimpl_->effect_type_undo.rend(); ++it ) {
                if( it->second ) {
                    detail::effect_type_registry_set( *it->second );
                } else {
                    detail::effect_type_registry_erase( it->first );
                }
            }
            pimpl_->effect_type_undo.clear();
            break;
        case creatures_content_rollback_phase::behavior: {
            const bool had_behaviors = !pimpl_->behavior_undo.empty();
            restore_factory( detail::behavior_registry(), pimpl_->behavior_undo );
            if( had_behaviors ) {
                behavior::finalize();
            }
            break;
        }
        case creatures_content_rollback_phase::mutation: {
            const bool had_mutations = !pimpl_->mutation_undo.empty();
            restore_factory( detail::mutation_registry(), pimpl_->mutation_undo );
            if( had_mutations ) {
                detail::mutation_registry().finalize();
                detail::refresh_mutation_registry_cache();
            }
            break;
        }
        case creatures_content_rollback_phase::mutation_category:
            for( auto it = pimpl_->mutation_category_undo.rbegin();
                 it != pimpl_->mutation_category_undo.rend(); ++it ) {
                if( it->second ) {
                    detail::mutation_category_registry_set( *it->second );
                } else {
                    detail::mutation_category_registry_erase( it->first );
                }
            }
            pimpl_->mutation_category_undo.clear();
            break;
        case creatures_content_rollback_phase::connect_group:
            for( auto it = pimpl_->connect_group_undo.rbegin();
                 it != pimpl_->connect_group_undo.rend(); ++it ) {
                if( it->second ) {
                    detail::connect_group_registry_set( *it->second );
                } else {
                    detail::connect_group_registry_erase( it->first );
                }
            }
            pimpl_->connect_group_undo.clear();
            break;
        case creatures_content_rollback_phase::mutation_type:
            for( auto it = pimpl_->mutation_type_undo.rbegin();
                 it != pimpl_->mutation_type_undo.rend(); ++it ) {
                if( !it->second ) {
                    detail::mutation_type_registry_erase( it->first );
                }
            }
            pimpl_->mutation_type_undo.clear();
            break;
        case creatures_content_rollback_phase::monster_faction: {
            const bool had_factions = !pimpl_->monster_faction_undo.empty();
            restore_factory( detail::monster_faction_registry(), pimpl_->monster_faction_undo );
            if( had_factions ) {
                monfactions::finalize();
            }
            break;
        }
        case creatures_content_rollback_phase::emission:
            for( auto it = pimpl_->emission_undo.rbegin();
                 it != pimpl_->emission_undo.rend(); ++it ) {
                if( it->second ) {
                    detail::emission_registry_set( *it->second );
                } else {
                    detail::emission_registry_erase( it->first );
                }
            }
            pimpl_->emission_undo.clear();
            break;
        case creatures_content_rollback_phase::species: {
            const bool had_species = !pimpl_->species_undo.empty();
            restore_factory( detail::species_registry(), pimpl_->species_undo );
            if( had_species ) {
                detail::species_registry().finalize();
            }
            break;
        }
        case creatures_content_rollback_phase::monster_flag:
            restore_factory( detail::monster_flag_registry(), pimpl_->monster_flag_undo );
            break;
        case creatures_content_rollback_phase::finalize:
            if( pimpl_->wound_fix_registry_dirty ) {
                detail::wound_fix_registry().finalize();
            }
            if( pimpl_->wound_fix_links_dirty ) {
                detail::refresh_wound_fix_links();
                detail::refresh_body_part_wound_cache();
            }
            pimpl_->wound_fix_registry_dirty = false;
            pimpl_->wound_fix_links_dirty = false;
            break;
    }

    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    if( pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::discarded;
    }
}

void creatures_content_transaction::rollback_all()
{
    rollback_phase( creatures_content_rollback_phase::monster );
    rollback_phase( creatures_content_rollback_phase::wound_fix );
    rollback_phase( creatures_content_rollback_phase::disease_type );
    rollback_phase( creatures_content_rollback_phase::morale_type );
    rollback_phase( creatures_content_rollback_phase::weakpoint_set );
    rollback_phase( creatures_content_rollback_phase::monster_attack );
    rollback_phase( creatures_content_rollback_phase::field_type );
    rollback_phase( creatures_content_rollback_phase::body_graph );
    rollback_phase( creatures_content_rollback_phase::anatomy );
    rollback_phase( creatures_content_rollback_phase::body_part );
    rollback_phase( creatures_content_rollback_phase::wound_type );
    rollback_phase( creatures_content_rollback_phase::sub_body_part );
    rollback_phase( creatures_content_rollback_phase::effect_type );
    rollback_phase( creatures_content_rollback_phase::behavior );
    rollback_phase( creatures_content_rollback_phase::mutation );
    rollback_phase( creatures_content_rollback_phase::mutation_category );
    rollback_phase( creatures_content_rollback_phase::connect_group );
    rollback_phase( creatures_content_rollback_phase::mutation_type );
    rollback_phase( creatures_content_rollback_phase::monster_faction );
    rollback_phase( creatures_content_rollback_phase::emission );
    rollback_phase( creatures_content_rollback_phase::species );
    rollback_phase( creatures_content_rollback_phase::monster_flag );
    rollback_phase( creatures_content_rollback_phase::finalize );
    pimpl_->next_apply_phase = creatures_content_apply_phase::foundations;
    pimpl_->applied = false;
    pimpl_->finalization_validated = false;
    if( pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::discarded;
    }
}

void creatures_content_transaction::commit()
{
    if( !pimpl_->applied ) {
        return;
    }
    pimpl_->behavior_undo.clear();
    pimpl_->effect_type_undo.clear();
    pimpl_->monster_attack_undo.clear();
    pimpl_->weakpoint_set_undo.clear();
    pimpl_->field_type_undo.clear();
    pimpl_->sub_body_part_undo.clear();
    pimpl_->wound_type_undo.clear();
    pimpl_->body_part_undo.clear();
    pimpl_->wound_fix_undo.clear();
    pimpl_->anatomy_undo.clear();
    pimpl_->body_graph_undo.clear();
    pimpl_->monster_undo.clear();
    pimpl_->morale_type_undo.clear();
    pimpl_->disease_type_undo.clear();
    pimpl_->monster_flag_undo.clear();
    pimpl_->species_undo.clear();
    pimpl_->emission_undo.clear();
    pimpl_->monster_faction_undo.clear();
    pimpl_->mutation_type_undo.clear();
    pimpl_->connect_group_undo.clear();
    pimpl_->mutation_category_undo.clear();
    pimpl_->mutation_undo.clear();
    pimpl_->token->lifecycle = handle_lifecycle::committed;
}

void creatures_content_transaction::seal()
{
    if( pimpl_->applied && pimpl_->token->lifecycle == handle_lifecycle::building ) {
        pimpl_->token->lifecycle = handle_lifecycle::committed;
    }
}

void creatures_content_transaction::discard()
{
    rollback_all();
    pimpl_->token->lifecycle = handle_lifecycle::discarded;
}

void creatures_content_transaction::append_fingerprint(
    const creatures_content_fingerprint_phase phase, std::uint64_t &state ) const
{
    const auto hash_number = [&state]( const auto value ) {
        hash_part( state, std::to_string( value ) );
    };
    const auto hash_strings = [&state]( const auto & values ) {
        for( const auto &value : values ) {
            hash_part( state, value );
        }
    };
    if( phase == creatures_content_fingerprint_phase::foundations ) {
        for( const auto &entry : pimpl_->monster_flags ) {
            hash_part( state, "monster_flag" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, entry.definition->id );
        }
        for( const auto &entry : pimpl_->species ) {
            const auto &value = *entry.definition;
            hash_part( state, "species" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, value.id );
            hash_part( state, value.description );
            hash_part( state, value.footsteps );
            hash_part( state, value.bleeds );
            for( const std::string &flag : value.flags ) {
                hash_part( state, flag );
            }
            for( const std::string &trigger : value.anger ) {
                hash_part( state, "anger" );
                hash_part( state, trigger );
            }
            for( const std::string &trigger : value.fear ) {
                hash_part( state, "fear" );
                hash_part( state, trigger );
            }
            for( const std::string &trigger : value.placate ) {
                hash_part( state, "placate" );
                hash_part( state, trigger );
            }
        }
        for( const auto &entry : pimpl_->emissions ) {
            const auto &value = *entry.definition;
            hash_part( state, "emission" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, value.id );
            hash_part( state, value.field );
            hash_number( value.intensity );
            hash_number( value.quantity );
            hash_number( value.chance );
            hash_part( state, value.profile_handler );
        }
        for( const auto &entry : pimpl_->monster_factions ) {
            const auto &value = *entry.definition;
            hash_part( state, "monster_faction" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, value.id );
            hash_part( state, value.base );
            for( const auto &[target, attitude] : value.attitudes ) {
                hash_part( state, target );
                hash_part( state, attitude );
            }
        }
        for( const auto &entry : pimpl_->mutation_types ) {
            hash_part( state, "mutation_type" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, entry.definition->id );
        }
        for( const auto &entry : pimpl_->connect_groups ) {
            hash_part( state, "connect_group" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, entry.definition->id );
        }
        for( const auto &entry : pimpl_->mutation_categories ) {
            const auto &value = *entry.definition;
            hash_part( state, "mutation_category" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, value.id );
            hash_part( state, value.name );
            hash_part( state, value.threshold_mutation );
            hash_part( state, value.mutagen_message );
            hash_part( state, value.memorial_message );
            hash_part( state, value.vitamin );
            hash_number( value.threshold_minimum );
            hash_number( value.base_removal_chance );
            hash_number( value.base_removal_cost_multiplier );
            hash_part( state, value.work_in_progress ? "wip" : "complete" );
            hash_part( state, value.skip_consistency_test ? "skip_test" : "check" );
        }
    } else if( phase == creatures_content_fingerprint_phase::behavior ) {
        for( const auto &entry : pimpl_->behaviors ) {
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
    } else if( phase == creatures_content_fingerprint_phase::effect_type ) {
        for( const auto &entry : pimpl_->effect_types ) {
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
    } else if( phase == creatures_content_fingerprint_phase::sub_body_part ) {
        for( const auto &entry : pimpl_->sub_body_parts ) {
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
    } else if( phase == creatures_content_fingerprint_phase::wound_type ) {
        for( const auto &entry : pimpl_->wound_types ) {
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
    } else if( phase == creatures_content_fingerprint_phase::body_part ) {
        for( const auto &entry : pimpl_->body_parts ) {
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
    } else if( phase == creatures_content_fingerprint_phase::anatomy ) {
        for( const auto &entry : pimpl_->anatomies ) {
            hash_part( state, "anatomy" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, entry.definition->id );
            for( const std::string &part : entry.definition->parts ) {
                hash_part( state, part );
            }
        }
        for( const auto &entry : pimpl_->body_graphs ) {
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
    } else if( phase == creatures_content_fingerprint_phase::monster ) {
        for( const auto &entry : pimpl_->monsters ) {
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
    } else if( phase == creatures_content_fingerprint_phase::field_type ) {
        for( const auto &entry : pimpl_->field_types ) {
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
    } else if( phase == creatures_content_fingerprint_phase::monster_attack ) {
        for( const auto &entry : pimpl_->monster_attacks ) {
            hash_part( state, "monster_attack" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, entry.definition->id );
            hash_part( state, std::to_string( entry.definition->cooldown ) );
            hash_part( state, entry.definition->handler );
        }
    } else if( phase == creatures_content_fingerprint_phase::weakpoint_set ) {
        for( const auto &entry : pimpl_->weakpoint_sets ) {
            hash_part( state, "weakpoint_set" );
            hash_part( state, operation_name( entry.operation ) );
            const weakpoint_set_definition_data &value = *entry.definition;
            hash_part( state, value.id );
            for( const auto &point : value.weakpoints ) {
                hash_part( state, point.id );
                hash_part( state, point.name );
                hash_part( state, std::to_string( point.coverage ) );
                hash_part( state, point.good ? "good" : "neutral" );
                hash_part( state, point.head ? "head" : "not_head" );
                const auto hash_damage_map = [&]( const std::string_view kind,
                const std::map<std::string, double> &values ) {
                    for( const auto &[damage_id, amount] : values ) {
                        hash_part( state, kind );
                        hash_part( state, damage_id );
                        hash_part( state, std::to_string( amount ) );
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
    } else if( phase == creatures_content_fingerprint_phase::morale_type ) {
        for( const auto &entry : pimpl_->morale_types ) {
            hash_part( state, "morale_type" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, entry.definition->id );
            hash_part( state, entry.definition->text );
            hash_part( state, entry.definition->permanent ? "permanent" : "temporary" );
        }
    } else if( phase == creatures_content_fingerprint_phase::disease_type ) {
        for( const auto &entry : pimpl_->disease_types ) {
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
    } else if( phase == creatures_content_fingerprint_phase::wound_fix ) {
        for( const auto &entry : pimpl_->wound_fixes ) {
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
    } else if( phase == creatures_content_fingerprint_phase::mutation ) {
        for( const auto &entry : pimpl_->mutations ) {
            const auto &value = *entry.definition;
            hash_part( state, "mutation" );
            hash_part( state, operation_name( entry.operation ) );
            hash_part( state, value.id );
            hash_part( state, value.name );
            hash_part( state, value.description );
            hash_number( value.points );
            hash_number( value.vitamin_cost );
            hash_number( value.visibility );
            hash_number( value.ugliness );
            hash_number( value.activation_cost );
            hash_number( value.cooldown_turns );
            hash_number( value.bodytemp_min );
            hash_number( value.bodytemp_max );
            hash_part( state, value.starting_trait ? "starting" : "not_starting" );
            hash_part( state, value.active ? "active" : "inactive" );
            hash_part( state, value.threshold ? "threshold" : "normal" );
            hash_strings( value.initial_martial_arts );
            hash_strings( value.threshold_substitutes );
            hash_strings( value.prereqs );
            hash_strings( value.prereqs2 );
            hash_strings( value.threshold_requirements );
            hash_strings( value.cancels );
            hash_strings( value.replacements );
            hash_strings( value.additions );
            hash_strings( value.flags );
            hash_strings( value.active_flags );
            hash_strings( value.inactive_flags );
            hash_strings( value.types );
            hash_strings( value.enchantments );
            hash_strings( value.categories );
            hash_strings( value.no_cbm_bodyparts );
            hash_strings( value.restricts_gear );
            hash_strings( value.remove_rigid );
            for( const auto &[id, amount] : value.vitamin_rates ) {
                hash_part( state, id );
                hash_number( amount );
            }
            for( const auto &attack : value.attacks ) {
                hash_part( state, attack.player_message );
                hash_part( state, attack.npc_message );
                hash_strings( attack.required_mutations );
                hash_strings( attack.blocker_mutations );
                hash_part( state, attack.bodypart );
                hash_number( attack.chance );
            }
        }
    }
}

bool creatures_content_transaction::was_applied() const
{
    return pimpl_->applied;
}

std::set<std::string> creatures_content_transaction::staged_field_type_ids() const
{
    std::set<std::string> ids;
    for( const auto &entry : pimpl_->field_types ) {
        ids.insert( entry.definition->id );
    }
    return ids;
}

#define CATA_CREATURES_DEFINE_QUERY( name, member ) \
    bool creatures_content_transaction::name( const std::string_view id ) const { \
        return has_id( pimpl_->member, id ); \
    }
CATA_CREATURES_DEFINE_QUERY( defines_behavior, behaviors )
CATA_CREATURES_DEFINE_QUERY( defines_effect_type, effect_types )
CATA_CREATURES_DEFINE_QUERY( defines_monster_attack, monster_attacks )
CATA_CREATURES_DEFINE_QUERY( defines_weakpoint_set, weakpoint_sets )
CATA_CREATURES_DEFINE_QUERY( defines_field_type, field_types )
CATA_CREATURES_DEFINE_QUERY( defines_sub_body_part, sub_body_parts )
CATA_CREATURES_DEFINE_QUERY( defines_body_part, body_parts )
CATA_CREATURES_DEFINE_QUERY( defines_wound, wound_types )
CATA_CREATURES_DEFINE_QUERY( defines_wound_fix, wound_fixes )
CATA_CREATURES_DEFINE_QUERY( defines_anatomy, anatomies )
CATA_CREATURES_DEFINE_QUERY( defines_body_graph, body_graphs )
CATA_CREATURES_DEFINE_QUERY( defines_monster, monsters )
CATA_CREATURES_DEFINE_QUERY( defines_morale_type, morale_types )
CATA_CREATURES_DEFINE_QUERY( defines_disease_type, disease_types )
CATA_CREATURES_DEFINE_QUERY( defines_monster_flag, monster_flags )
CATA_CREATURES_DEFINE_QUERY( defines_species, species )
CATA_CREATURES_DEFINE_QUERY( defines_emission, emissions )
CATA_CREATURES_DEFINE_QUERY( defines_monster_faction, monster_factions )
CATA_CREATURES_DEFINE_QUERY( defines_mutation_type, mutation_types )
CATA_CREATURES_DEFINE_QUERY( defines_connect_group, connect_groups )
CATA_CREATURES_DEFINE_QUERY( defines_mutation_category, mutation_categories )
CATA_CREATURES_DEFINE_QUERY( defines_mutation, mutations )
#undef CATA_CREATURES_DEFINE_QUERY

bool creatures_content_transaction::find_behavior_handler( const std::string_view behavior_id,
        const std::string_view phase, std::string &handler_id ) const
{
    for( auto it = pimpl_->behaviors.rbegin(); it != pimpl_->behaviors.rend(); ++it ) {
        if( it->definition->id != behavior_id ) {
            continue;
        }
        if( phase == "score" && it->definition->score && !it->definition->score->native ) {
            handler_id = it->definition->score->policy;
            return true;
        }
        if( phase == "condition" ) {
            for( const auto &condition : it->definition->conditions ) {
                if( !condition.native ) {
                    handler_id = condition.policy;
                    return true;
                }
            }
        }
        handler_id.clear();
        return true;
    }
    handler_id.clear();
    return false;
}

bool creatures_content_transaction::find_monster_attack_handler(
    const std::string_view monster_id, const std::string_view attack_id,
    std::string &handler_id ) const
{
    for( auto it = pimpl_->monsters.rbegin(); it != pimpl_->monsters.rend(); ++it ) {
        if( it->definition->id != monster_id ) {
            continue;
        }
        const auto found = it->definition->attack_handlers.find( std::string( attack_id ) );
        if( found == it->definition->attack_handlers.end() ) {
            handler_id.clear();
            return false;
        }
        handler_id = found->second;
        return true;
    }
    handler_id.clear();
    return false;
}

bool creatures_content_transaction::find_monster_death_handler(
    const std::string_view monster_id, std::string &handler_id ) const
{
    for( auto it = pimpl_->monsters.rbegin(); it != pimpl_->monsters.rend(); ++it ) {
        if( it->definition->id == monster_id ) {
            handler_id = it->definition->death_handler;
            return true;
        }
    }
    handler_id.clear();
    return false;
}

bool creatures_content_transaction::find_emission_handler(
    const std::string_view emission_id, std::string &handler_id ) const
{
    for( auto it = pimpl_->emissions.rbegin(); it != pimpl_->emissions.rend(); ++it ) {
        if( it->definition->id == emission_id ) {
            handler_id = it->definition->profile_handler;
            return true;
        }
    }
    handler_id.clear();
    return false;
}

bool creatures_content_transaction::find_weakpoint_handler(
    const std::string_view weakpoint_set_id, const std::string_view weakpoint_id,
    const std::size_t effect_index, std::string &handler_id ) const
{
    for( auto it = pimpl_->weakpoint_sets.rbegin(); it != pimpl_->weakpoint_sets.rend(); ++it ) {
        if( it->definition->id != weakpoint_set_id ) {
            continue;
        }
        const auto point = std::find_if( it->definition->weakpoints.begin(),
                                         it->definition->weakpoints.end(),
        [weakpoint_id]( const weakpoint_definition_data & value ) {
            return value.id == weakpoint_id;
        } );
        if( point == it->definition->weakpoints.end() || effect_index >= point->effects.size() ) {
            handler_id.clear();
            return false;
        }
        handler_id = point->effects[effect_index].handler;
        return true;
    }
    handler_id.clear();
    return false;
}



} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM

#if !defined(CATA_ENABLE_LUA_PLATFORM) || !CATA_ENABLE_LUA_PLATFORM

namespace cata::lua_platform
{

struct creatures_content_transaction::impl {};

creatures_content_transaction::creatures_content_transaction( std::string, std::size_t ) :
    pimpl_( std::make_unique<impl>() )
{}

creatures_content_transaction::~creatures_content_transaction() = default;

bool creatures_content_transaction::validate( const runtime &, bool,
        const creatures_content_validation_index &, std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool creatures_content_transaction::apply_phase( creatures_content_apply_phase,
        std::string &error )
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

bool creatures_content_transaction::validate_finalized( std::string &error ) const
{
    error = "Lua-first Platform is not enabled in this build";
    return false;
}

void creatures_content_transaction::rollback_phase( creatures_content_rollback_phase ) {}
void creatures_content_transaction::prepare_rollback( bool ) {}
void creatures_content_transaction::rollback_all() {}
void creatures_content_transaction::commit() {}
void creatures_content_transaction::seal() {}
void creatures_content_transaction::discard() {}
void creatures_content_transaction::append_fingerprint(
    creatures_content_fingerprint_phase, std::uint64_t & ) const {}
bool creatures_content_transaction::was_applied() const
{
    return false;
}
std::set<std::string> creatures_content_transaction::staged_field_type_ids() const
{
    return {};
}

#define CATA_CREATURES_FALSE_QUERY( name ) \
    bool creatures_content_transaction::name( std::string_view ) const { return false; }
CATA_CREATURES_FALSE_QUERY( defines_behavior )
CATA_CREATURES_FALSE_QUERY( defines_effect_type )
CATA_CREATURES_FALSE_QUERY( defines_monster_attack )
CATA_CREATURES_FALSE_QUERY( defines_weakpoint_set )
CATA_CREATURES_FALSE_QUERY( defines_field_type )
CATA_CREATURES_FALSE_QUERY( defines_sub_body_part )
CATA_CREATURES_FALSE_QUERY( defines_body_part )
CATA_CREATURES_FALSE_QUERY( defines_wound )
CATA_CREATURES_FALSE_QUERY( defines_wound_fix )
CATA_CREATURES_FALSE_QUERY( defines_anatomy )
CATA_CREATURES_FALSE_QUERY( defines_body_graph )
CATA_CREATURES_FALSE_QUERY( defines_monster )
CATA_CREATURES_FALSE_QUERY( defines_morale_type )
CATA_CREATURES_FALSE_QUERY( defines_disease_type )
CATA_CREATURES_FALSE_QUERY( defines_monster_flag )
CATA_CREATURES_FALSE_QUERY( defines_species )
CATA_CREATURES_FALSE_QUERY( defines_emission )
CATA_CREATURES_FALSE_QUERY( defines_monster_faction )
CATA_CREATURES_FALSE_QUERY( defines_mutation_type )
CATA_CREATURES_FALSE_QUERY( defines_connect_group )
CATA_CREATURES_FALSE_QUERY( defines_mutation_category )
CATA_CREATURES_FALSE_QUERY( defines_mutation )
#undef CATA_CREATURES_FALSE_QUERY

bool creatures_content_transaction::find_behavior_handler( std::string_view,
        std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool creatures_content_transaction::find_monster_attack_handler( std::string_view,
        std::string_view, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool creatures_content_transaction::find_monster_death_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool creatures_content_transaction::find_emission_handler( std::string_view,
        std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}
bool creatures_content_transaction::find_weakpoint_handler( std::string_view,
        std::string_view, std::size_t, std::string &handler_id ) const
{
    handler_id.clear();
    return false;
}

} // namespace cata::lua_platform

#endif // !CATA_ENABLE_LUA_PLATFORM
