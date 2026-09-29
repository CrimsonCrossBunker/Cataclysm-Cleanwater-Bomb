#include "riding_config.h"

#include "json.h"

namespace
{
riding_config config;
} // namespace

const riding_config &get_riding_config()
{
    return config;
}

void load_riding_config( const JsonObject &jo, const std::string & )
{
    config.saddled_mount_difficulty = jo.get_int( "saddled_mount_difficulty",
                                      config.saddled_mount_difficulty );
    config.unsaddled_mount_difficulty = jo.get_int( "unsaddled_mount_difficulty",
                                        config.unsaddled_mount_difficulty );
    config.mount_skill_weight = jo.get_float( "mount_skill_weight", config.mount_skill_weight );
    config.mount_dexterity_weight = jo.get_float( "mount_dexterity_weight",
                                    config.mount_dexterity_weight );
    config.legacy_survival_conversion_cap = jo.get_int( "legacy_survival_conversion_cap",
                                            config.legacy_survival_conversion_cap );
    config.legacy_survival_conversion_ratio = jo.get_float( "legacy_survival_conversion_ratio",
            config.legacy_survival_conversion_ratio );
    config.move_practice_chance = jo.get_int( "move_practice_chance", config.move_practice_chance );
    config.move_practice = jo.get_int( "move_practice", config.move_practice );
    config.melee_practice = jo.get_int( "melee_practice", config.melee_practice );
    config.ranged_practice = jo.get_int( "ranged_practice", config.ranged_practice );
    config.spook_skill_reduction = jo.get_float( "spook_skill_reduction",
                                   config.spook_skill_reduction );
    config.balance_skill_reduction = jo.get_float( "balance_skill_reduction",
                                     config.balance_skill_reduction );
    config.melee_fall_base_chance = jo.get_float( "melee_fall_base_chance",
                                    config.melee_fall_base_chance );
    config.melee_fall_damage_scale = jo.get_float( "melee_fall_damage_scale",
                                     config.melee_fall_damage_scale );
    config.mounted_move_cost_penalty = jo.get_float( "mounted_move_cost_penalty",
                                       config.mounted_move_cost_penalty );
    config.move_cost_skill_reduction = jo.get_float( "move_cost_skill_reduction",
                                       config.move_cost_skill_reduction );
    config.minimum_move_cost_multiplier = jo.get_float( "minimum_move_cost_multiplier",
                                          config.minimum_move_cost_multiplier );
    config.mounted_melee_hit_penalty = jo.get_float( "mounted_melee_hit_penalty",
                                       config.mounted_melee_hit_penalty );
    config.melee_hit_skill_reduction = jo.get_float( "melee_hit_skill_reduction",
                                       config.melee_hit_skill_reduction );
    config.mounted_melee_proficiency_hit_bonus = jo.get_float(
                "mounted_melee_proficiency_hit_bonus", config.mounted_melee_proficiency_hit_bonus );
    config.mounted_melee_proficiency_damage_bonus = jo.get_float(
                "mounted_melee_proficiency_damage_bonus", config.mounted_melee_proficiency_damage_bonus );
    config.mounted_ranged_dispersion_penalty = jo.get_int( "mounted_ranged_dispersion_penalty",
            config.mounted_ranged_dispersion_penalty );
    config.ranged_dispersion_skill_reduction = jo.get_int( "ranged_dispersion_skill_reduction",
            config.ranged_dispersion_skill_reduction );
    config.mounted_ranged_proficiency_bonus = jo.get_int( "mounted_ranged_proficiency_bonus",
            config.mounted_ranged_proficiency_bonus );
    config.proficiency_practice_seconds = jo.get_int( "proficiency_practice_seconds",
                                          config.proficiency_practice_seconds );
    config.mounted_combat_proficiency = proficiency_id( jo.get_string(
                                            "mounted_combat_proficiency", config.mounted_combat_proficiency.str() ) );
    config.mounted_ranged_proficiency = proficiency_id( jo.get_string(
                                            "mounted_ranged_proficiency", config.mounted_ranged_proficiency.str() ) );
    config.mounted_bashing_proficiency = proficiency_id( jo.get_string(
            "mounted_bashing_proficiency", config.mounted_bashing_proficiency.str() ) );
    config.mounted_cutting_proficiency = proficiency_id( jo.get_string(
            "mounted_cutting_proficiency", config.mounted_cutting_proficiency.str() ) );
    config.mounted_piercing_proficiency = proficiency_id( jo.get_string(
            "mounted_piercing_proficiency", config.mounted_piercing_proficiency.str() ) );

    if( config.move_practice_chance < 1 || config.minimum_move_cost_multiplier <= 0.0 ||
        config.minimum_move_cost_multiplier > 1.0 || config.proficiency_practice_seconds < 0 ||
        config.melee_fall_base_chance < 0.0 || config.melee_fall_damage_scale < 0.0 ) {
        jo.throw_error( "invalid riding configuration: chances, durations, and movement bounds must be positive" );
    }
}

void reset_riding_config()
{
    config = riding_config();
}
