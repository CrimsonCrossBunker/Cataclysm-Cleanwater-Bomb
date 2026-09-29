#pragma once
#ifndef CATA_SRC_RIDING_CONFIG_H
#define CATA_SRC_RIDING_CONFIG_H

#include <string>

#include "type_id.h"

class JsonObject;

/** Data-driven balance parameters shared by animal riding mechanics. */
class riding_config
{
    public:
        int saddled_mount_difficulty = 6;
        int unsaddled_mount_difficulty = 10;
        double mount_skill_weight = 2.0;
        double mount_dexterity_weight = 0.25;

        int legacy_survival_conversion_cap = 6;
        double legacy_survival_conversion_ratio = 0.5;

        int move_practice_chance = 40;
        int move_practice = 1;
        int melee_practice = 1;
        int ranged_practice = 1;

        double spook_skill_reduction = 0.75;
        double balance_skill_reduction = 0.08;
        double melee_fall_base_chance = 10.0;
        double melee_fall_damage_scale = 1.0;

        double mounted_move_cost_penalty = 0.25;
        double move_cost_skill_reduction = 0.025;
        double minimum_move_cost_multiplier = 0.85;

        double mounted_melee_hit_penalty = 2.0;
        double melee_hit_skill_reduction = 0.20;
        double mounted_melee_proficiency_hit_bonus = 1.0;
        double mounted_melee_proficiency_damage_bonus = 0.15;

        int mounted_ranged_dispersion_penalty = 300;
        int ranged_dispersion_skill_reduction = 25;
        int mounted_ranged_proficiency_bonus = 150;

        int proficiency_practice_seconds = 4;

        proficiency_id mounted_combat_proficiency = proficiency_id( "prof_mounted_combat" );
        proficiency_id mounted_ranged_proficiency = proficiency_id( "prof_mounted_archery" );
        proficiency_id mounted_bashing_proficiency = proficiency_id( "prof_mounted_bashing" );
        proficiency_id mounted_cutting_proficiency = proficiency_id( "prof_mounted_cutting" );
        proficiency_id mounted_piercing_proficiency = proficiency_id( "prof_mounted_piercing" );
};

void load_riding_config( const JsonObject &jo, const std::string &src );
void reset_riding_config();
const riding_config &get_riding_config();

#endif // CATA_SRC_RIDING_CONFIG_H
