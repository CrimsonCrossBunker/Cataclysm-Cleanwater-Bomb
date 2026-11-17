local content = require("ccb").content

-- effects/effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_haste_vampire_0" }
    :value("RANGE_DODGE", { add = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vampire_resilience_flesh_of_marble_0" }
    :value("FORCEFIELD", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_wild_hunt_illumination_0" }
    :value("LUMINATION", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_reduced_healing_0" }
    :value("REGEN_HP", { multiply = -0.6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_shadow_damage_reduction_0" }
    :incoming_damage("bash", { multiply = -0.75 })
    :incoming_damage("bullet", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_dhampir_corpselike_pallor_pale_0" }
    :mutation("PALE"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_dhampir_resist_disease_poison_infection_0" }
    :mutation("POISRESIST"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vampire_feign_death_0" }
    :mutation("WINTER_FEIGN_DEATH_TRAITS"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vampire_feign_death_1" }
    :effect("downed", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vampire_mist_form_0" }
    :value("EVASION", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_eater_lump_pool_0" }
    :value("STRENGTH", { add = 6 })
    :value("REGEN_HP", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_spell_unbreakable_eff_0" }
    :mutation("eater_unbreakable"))

content.add(content.Enchantment { id = "INLINE_ENCH_bleed_karma_0", emitter = "emit_blood_karma" })

content.add(content.Enchantment { id = "INLINE_ENCH_effect_arvore_poison_pollen_0", emitter = "emit_arvore_poison_pollen" })

content.add(content.Enchantment { id = "INLINE_ENCH_effect_ierde_slow_enemies_0" }
    :value("SPEED", { multiply = -0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_ierde_rooted_in_place_0" }
    :incoming_damage("bash", { multiply = -0.25 })
    :incoming_damage("stab", { multiply = -0.25 })
    :incoming_damage("cut", { multiply = -0.25 })
    :incoming_damage("bullet", { multiply = -0.25 })
    :incoming_damage("heat", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_ierde_buff_armor_allies_0" }
    :value("MOVE_COST", { multiply = 0.1 })
    :value("BLEEDING_RATE", { multiply = -0.333 })
    :incoming_damage("bash", { multiply = -0.3 })
    :incoming_damage("stab", { multiply = -0.3 })
    :incoming_damage("cut", { multiply = -0.3 })
    :incoming_damage("bullet", { multiply = -0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_ierde_earthen_shield_0" }
    :value("FORCEFIELD", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_homullus_reduced_visibility_ally_0" }
    :value("STEALTH_MODIFIER", { add = 50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_hidden_flame_immunity_0" }
    :value("CLIMATE_CONTROL_CHILL", { add = 1000 })
    :incoming_damage("heat", { add = -1000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_salamander_emit_heat_0", emitter = "emit_salamander_heat" })

content.add(content.Enchantment { id = "INLINE_ENCH_effect_salamander_phoenix_healing_0" }
    :value("REGEN_HP", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_salamander_smoke_form_0", emitter = "emit_smoke_blast" })

content.add(content.Enchantment { id = "INLINE_ENCH_effect_salamander_smoke_form_1" }
    :value("MELEE_DAMAGE", { multiply = -1.0 })
    :value("RANGED_DAMAGE", { multiply = -1.0 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_sylph_hindering_wind_0" }
    :value("SPEED", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_sylph_increase_ally_speed_0" }
    :value("MOVECOST_FLATGROUND_MOD", { multiply = -0.2 })
    :value("MOVECOST_OBSTACLE_MOD", { multiply = -0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_sylph_cloud_body_0" }
    :value("MOVE_COST", { multiply = -0.8 })
    :value("EVASION", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_undine_escape_grabs_0" }
    :value("FALL_DAMAGE", { multiply = -0.6 })
    :value("EVASION", { add = 0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_undine_acid_resist_ally_0" }
    :incoming_damage("acid", { multiply = -0.75 })
    :hit_me({ id = "undine_acid_resist_ally_thorns", self = false, trigger_once_in = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_hedge_magic_luck_spell_0" }
    :value("BONUS_DODGE", { add = 1 })
    :value("FREE_DODGES", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_hedge_increase_healing_rate_0" }
    :value("REGEN_HP", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_hedge_increase_bandaging_rate_0" }
    :value("BLEED_STOP_BONUS", { multiply = 0.66 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_hedge_extinguish_fire_spell_self_resistance_0" }
    :value("CLIMATE_CONTROL_CHILL", { add = 1000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_hedge_astral_projection_0" }
    :value("MOVE_COST", { multiply = -0.96 })
    :value("EVASION", { add = 1 })
    :value("PHASE_DISTANCE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_trow_no_eating_or_sleep_0" }
    :value("METABOLISM", { multiply = -1 })
    :value("THIRST", { multiply = -1 })
    :value("SLEEPINESS", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_dream_drainer_speed_0" }
    :value("SPEED", { add = 70 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_dream_drainer_armor_0", condition = "ALWAYS" }
    :value("ARMOR_ALL", { add = -15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_moon_withdrawal_0", condition = "ALWAYS" }
    :value("SPEED", { add = -130 }))

content.add(content.Enchantment { id = "INLINE_ENCH_lilit_prevent_death_escape_0" }
    :value("EVASION", { add = 0.55 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_lilin_silent_at_night_0" }
    :value("FOOTSTEP_NOISE", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_sleep_shield_0" }
    :value("SLEEPY", { add = 9999 })
    :value("CLIMATE_CONTROL_HEAT", { add = 500 })
    :value("CLIMATE_CONTROL_CHILL", { add = 500 })
    :value("FORCEFIELD", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_lilin_aoe_daze_0" }
    :value("SPEED", { multiply = -0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_lilin_supernatural_disease_0" }
    :value("SPEED", { multiply = -0.1 })
    :value("ARMOR_ALL", { multiply = 0.05 })
    :value("VISION_RANGE", { multiply = -0.15 })
    :value("REGEN_HP", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_lilin_supernatural_disease_focused_0" }
    :value("SPEED", { multiply = -0.25 })
    :value("ARMOR_ALL", { multiply = 0.1 })
    :value("VISION_RANGE", { multiply = -0.35 })
    :value("REGEN_HP", { multiply = -0.95 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_xedra_time_freeze_0" }
    :value("EQUIPMENT_DAMAGE_CHANCE", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_xedra_dreamer_generate_accelerated_time_0", emitter = "xedra_dreamer_emit_accelerated_time" })

content.add(content.Enchantment { id = "INLINE_ENCH_effect_xedra_dreamer_accelerated_time_0" }
    :value("SPEED", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_xedra_eater_erosion_0" }
    :hit_you({ id = "xedra_eater_erosion_attack" }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_xedra_chronomancer_destabilizing_strikes_0" }
    :hit_you({ id = "xedra_chronomancer_destabilizing_strikes_attack" }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_xedra_time_loop_0" }
    :value("EQUIPMENT_DAMAGE_CHANCE", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_xedra_monster_erosion_0" }
    :hit_you({ id = "xedra_monster_erosion_attack" }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_anathema_resilience_0" }
    :incoming_damage("bash", { multiply = -0.66 })
    :incoming_damage("stab", { multiply = -0.25 })
    :incoming_damage("cut", { multiply = -0.33 })
    :incoming_damage("bullet", { multiply = -0.85 })
    :incoming_damage("heat", { multiply = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_anathema_resilience_1" }
    :value("EVASION", { add = 0.7 })
    :value("DODGE_CHANCE", { add = 15 })
    :value("BONUS_DODGE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_anathema_resilience_2" }
    :hit_me({ id = "VAMPIRE_ANATHEMA_REACT_TO_HIT", self = true }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_anathema_battle_started_0" }
    :value("SPEED", { add = 125 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_anathema_final_form_0" }
    :value("SPEED", { add = 468 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_xe_werewolf_walk_through_walls_0" }
    :value("EVASION", { add = 1 })
    :value("PHASE_DISTANCE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_withering_healing_down_0" }
    :value("REGEN_HP", { multiply = -0.5 }))

-- effects/effects_alchemy.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_xe_abyssal_coffee_0" }
    :value("SLEEPINESS", { multiply = -1 }))

-- effects/effects_changeling_seasonal_magic.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_gain_dreamdross_from_dreams_0" }
    :mutation("BADTEMPER"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_spring_protective_plant_armor_0" }
    :mutation("ARVORE_MOSS")
    :mutation("BARK"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_spring_enchanted_butterfly_wings_0" }
    :mutation("MUTATION_COSMETIC_BUTTERFLY_WINGS")
    :mutation("MUTATION_NO_RIGID_TORSO_ARMOR"))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_spring_enchanted_butterfly_wings_1" }
    :bodypart_change("wing_gossamer_l", "")
    :bodypart_change("wing_gossamer_r", ""))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_spring_turn_target_into_tree_0" }
    :value("METABOLISM", { multiply = -1 })
    :value("THIRST", { multiply = -1 })
    :value("REGEN_HP", { multiply = 50 })
    :value("REGEN_HP_AWAKE", { multiply = 2 })
    :value("SLEEPINESS_REGEN", { multiply = 0.5 })
    :value("MENDING_MODIFIER", { multiply = 25 })
    :value("SLEEPY", { add = 150 })
    :value("CLIMATE_CONTROL_HEAT", { add = 150 })
    :effect("effect_xe_hidden_infection_recovery", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_spring_charm_control_target_0" }
    :value("SPEED", { multiply = 0.05 })
    :incoming_damage("bash", { multiply = -0.1 })
    :incoming_damage("cut", { multiply = -0.1 })
    :incoming_damage("stab", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_summer_light_0" }
    :value("LUMINATION", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_fire_melee_damage_2" }
    :value("LUMINATION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_summer_ring_of_flames_0" }
    :value("KNOCKBACK_RESIST", { add = 100 })
    :value("CLIMATE_CONTROL_CHILL", { add = 1000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_summer_powerful_sunlight_0" }
    :value("LUMINATION", { add = 8000 })
    :every(4, { id = "changeling_summer_powerful_sunlight_spell_aura_effects" }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_autumn_touch_of_frailty_character_0" }
    :value("STRENGTH", { add = -3 })
    :value("DEXTERITY", { add = -2 })
    :value("SPEED", { add = -5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_autumn_stop_supernatural_healing_0" }
    :value("REGEN_HP", { multiply = -0.667 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_autumn_wither_with_time_character_0" }
    :skill("melee", { multiply = -1 })
    :skill("stabbing", { multiply = -1 })
    :skill("bashing", { multiply = -1 })
    :skill("cutting", { multiply = -1 })
    :skill("dodge", { multiply = -1 })
    :skill("gun", { multiply = -1 })
    :skill("archery", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_winter_feign_death_0" }
    :mutation("WINTER_FEIGN_DEATH_TRAITS")
    :effect("downed", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_changeling_winter_frozen_breath_0" }
    :value("SPEED", { multiply = -0.1 }))

-- effects/effects_martial_arts.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_xe_ma_arvore_beneath_falling_tree_weakpoints_bonus_0" }
    :value("WEAKPOINT_ACCURACY", { multiply = 0.4 }))

-- effects/effects_monster_only.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_vampire_monster_resilience_0", condition = "ALWAYS" }
    :incoming_damage("bash", { multiply = -0.35 })
    :incoming_damage("stab", { multiply = -0.2 })
    :incoming_damage("cut", { multiply = -0.25 })
    :incoming_damage("bullet", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vampire_monster_speed_0" }
    :value("SPEED", { multiply = 1 })
    :value("RANGE_DODGE", { add = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_viridian_cuirass_0", condition = "ALWAYS" }
    :incoming_damage("bash", { add = 15 })
    :incoming_damage("stab", { add = 8 })
    :incoming_damage("cut", { add = 10 })
    :incoming_damage("bullet", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_swirl_of_autumn_leaves_0" }
    :value("RANGE_DODGE", { add = 0.45 }))

-- effects/effects_nether_sorcery.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_xe_nether_sorcery_wind_dodge_shell_0" }
    :value("EVASION", { add = 0.4 })
    :value("RANGE_DODGE", { add = 0.8 })
    :value("BONUS_DODGE", { add = 1 }))

-- effects/goblin_fruit_effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_heal_0" }
    :every(30, { id = "goblin_fruit_regeneration_spell" }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_speed_0" }
    :value("ATTACK_SPEED", { add = -15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_keep_warm_0" }
    :value("CLIMATE_CONTROL_HEAT", { add = 50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_dodge_0" }
    :value("BONUS_DODGE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_shadow_0" }
    :value("FOOTSTEP_NOISE", { multiply = -0.67 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_perception_0" }
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_stealth_0" }
    :value("STEALTH_MODIFIER", { add = 50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_combat_skill_boost_0" }
    :skill("bashing", { add = 2 })
    :skill("cutting", { add = 2 })
    :skill("melee", { add = 2 })
    :skill("throw", { add = 2 })
    :skill("dodge", { add = 2 })
    :skill("stabbing", { add = 2 })
    :skill("unarmed", { add = 2 })
    :skill("archery", { add = 2 })
    :skill("gun", { add = 2 })
    :skill("launcher", { add = 2 })
    :skill("rifle", { add = 2 })
    :skill("shotgun", { add = 2 })
    :skill("smg", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_craft_skill_boost_0" }
    :skill("mechanics", { add = 2 })
    :skill("tailor", { add = 2 })
    :skill("computer", { add = 2 })
    :skill("cooking", { add = 2 })
    :skill("electronics", { add = 2 })
    :skill("fabrication", { add = 2 })
    :skill("chemistry", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_immovable_0" }
    :value("KNOCKBACK_RESIST", { add = 100 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_dodge_instant_0" }
    :value("DODGE_CHANCE", { add = 100 })
    :value("RANGE_DODGE", { add = 100 })
    :value("BONUS_DODGE", { add = 15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_focus_boost_0" }
    :value("LEARNING_FOCUS", { add = 20 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_teleport_0" }
    :every(1, { id = "goblin_fruit_teleport_spell" }))

content.add(content.Enchantment { id = "INLINE_ENCH_goblin_fruit_carry_boost_0" }
    :value("CARRY_WEIGHT", { add = 30000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_slowing_armor_0" }
    :value("ARMOR_ALL", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_social_boost_0" }
    :value("SOCIAL_LIE", { add = 15 })
    :value("SOCIAL_PERSUADE", { add = 15 })
    :value("SOCIAL_INTIMIDATE", { add = 15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_cold_resist_0" }
    :incoming_damage("cold", { multiply = -0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_goblin_fruit_cold_resist_1" }
    :value("CLIMATE_CONTROL_HEAT", { add = 30 }))

-- spells/XAEA.json
content.add(content.Enchantment { id = "INLINE_ENCH_xe_str_0" }
    :value("STRENGTH", { add = 15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_xe_int_0" }
    :value("INTELLIGENCE", { add = 12 }))

content.add(content.Enchantment { id = "INLINE_ENCH_xaea_electric_emit_0", emitter = "emit_shock_cloud_big" }
    :incoming_damage("electric", { add = -100 }))

content.add(content.Enchantment { id = "INLINE_ENCH_xe_motion_vision_0", condition = "ALWAYS" }
    :vision({ distance = 30, descriptions = { { id = "moving_creature", color = "c_white", symbol = "?", text = content.text("You sense something moving here.") } } }))
