local content = require("ccb").content

-- effects/effects_artifact.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_speed_boost_0" }
    :value("SPEED", { add = 200 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_physical_boost_0" }
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_increase_pain_0" }
    :value("PAIN", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_movement_exertion_0" }
    :value("MOVEMENT_EXERTION_MODIFIER", { multiply = 0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_hardened_skin_0" }
    :value("PAIN", { multiply = -0.2 })
    :incoming_damage("bash", { add = -6 })
    :incoming_damage("stab", { add = -3 })
    :incoming_damage("cut", { add = -4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_perception_boost_0" }
    :value("PERCEPTION", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_lightning_immune_0" }
    :incoming_damage("electric", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_illumination_on_self_0" }
    :value("LUMINATION", { add = 8000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_lambent_illumination_0" }
    :value("LUMINATION", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_burning_cloak_0", emitter = "emit_pyrokinetic_aura_4" })

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_slow_0" }
    :value("SPEED", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mom_artifact_regeneration_0" }
    :value("MENDING_MODIFIER", { multiply = 15 })
    :value("REGEN_HP", { multiply = 1.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.8 }))

-- effects/effects_items.json
content.add(content.Enchantment { id = "INLINE_ENCH_instability_remover_0", condition = "ALWAYS" }
    :value("MUT_INSTABILITY_MOD", { add = -2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_force_field_generated_0", condition = "ALWAYS" }
    :value("FORCEFIELD", { add = 0.94 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_black_nether_water_disease_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = -40 }))

-- effects/effects_monster.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_physical_enhancement_0" }
    :melee_damage("bash", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_physical_enhancement_improved_0" }
    :melee_damage("bash", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_hardened_skin_0" }
    :incoming_damage("bash", { add = -9 })
    :incoming_damage("stab", { add = -4 })
    :incoming_damage("cut", { add = -6 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_heightened_reflex_0" }
    :value("VISION_RANGE", { multiply = 0.1 })
    :value("SPEED", { multiply = 0.17 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_psi_biokin3_hurricane_blows_0" }
    :value("SPEED", { add = 400 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_feral_heightened_senses_0" }
    :value("VISION_RANGE", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_feral_heightened_senses_2_0" }
    :value("VISION_RANGE", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_feral_combat_sense_2_0" }
    :value("RANGE_DODGE", { add = 0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_feral_combat_sense_3_0" }
    :value("RANGE_DODGE", { add = 0.8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_feral_heightened_senses_3_0" }
    :value("VISION_RANGE", { multiply = 0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_neuro_acceleration_0" }
    :value("SPEED", { multiply = 0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_neuro_acceleration_enhanced_0" }
    :value("SPEED", { multiply = 0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_photokinetic_illumination_0" }
    :value("LUMINATION", { add = 200 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_pyrokinetic_fire_immunity_0" }
    :incoming_damage("heat", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_momentum_alteration_0" }
    :value("SPEED", { multiply = 0.03 })
    :incoming_damage("bash", { multiply = -0.1 })
    :incoming_damage("stab", { multiply = -0.1 })
    :incoming_damage("cut", { multiply = -0.1 })
    :incoming_damage("bullet", { multiply = -0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_inertial_barrier_0" }
    :incoming_damage("bash", { add = -10 })
    :incoming_damage("stab", { add = -20 })
    :incoming_damage("cut", { add = -15 })
    :incoming_damage("bullet", { add = -35 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_inertial_barrier_improved_0" }
    :incoming_damage("bash", { add = -18 })
    :incoming_damage("stab", { add = -32 })
    :incoming_damage("cut", { add = -25 })
    :incoming_damage("bullet", { add = -50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_monster_telekinetic_aegis_0" }
    :value("TOTAL_WEIGHT", { multiply = 10000 })
    :incoming_damage("bash", { add = -100000 })
    :incoming_damage("stab", { add = -100000 })
    :incoming_damage("cut", { add = -100000 })
    :incoming_damage("bullet", { add = -100000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_whispering_amalgamation_whispers_1" }
    :value("PERCEPTION", { add = -2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_teleport_reactive_displacement_monster_0" }
    :hit_me({ id = "teleport_reactive_displacement_monster_teleport" }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vitakinetic_healing_down_0" }
    :value("REGEN_HP_AWAKE", { multiply = -1 })
    :value("REGEN_HP", { multiply = -0.5 })
    :value("REGEN_STAMINA", { multiply = -0.15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vitakinetic_healing_down_super_0" }
    :value("REGEN_HP_AWAKE", { multiply = -1 })
    :value("REGEN_HP", { multiply = -0.8 })
    :value("REGEN_STAMINA", { multiply = -0.3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_nether_silent_one_resistances_0" }
    :incoming_damage("head", { multiply = -0.45 })
    :incoming_damage("electric", { multiply = -0.95 })
    :incoming_damage("psi_telepathic_damage", { multiply = -0.5 }))

-- effects/effects_nether_attunement.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_nether_attunement_attenuation_0" }
    :value("CASTING_TIME_MULTIPLIER", { multiply = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_nether_attunement_pyrokinetic_fever_0" }
    :value("STRENGTH", { add = -2 })
    :value("DEXTERITY", { add = -1 })
    :value("CLIMATE_CONTROL_CHILL", { add = -10 })
    :value("SWEAT_MULTIPLIER", { multiply = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_nether_attunement_pyrokinetic_fog_0", emitter = "emit_fog_plume" })

-- effects/effects_penalty.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_pyrokin_overload_1" }
    :value("SWEAT_MULTIPLIER", { multiply = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_teleporter_overload_0" }
    :value("OBTAIN_COST_MULTIPLIER", { multiply = 0.1 })
    :value("MOVE_COST", { multiply = 0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_telekin_overload_0" }
    :value("CARRY_WEIGHT", { multiply = 0.75 })
    :value("MOVE_COST", { multiply = 0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vitakin_overload_1" }
    :value("MENDING_MODIFIER", { multiply = -0.5 }))

-- effects/effects_potions.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_biokin_potion_0" }
    :incoming_damage("bash", { add = -6 })
    :incoming_damage("stab", { add = -3 })
    :incoming_damage("cut", { add = -4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_biokin_potion_comedown_0" }
    :incoming_damage("bash", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_pyrokin_potion_comedown_0" }
    :value("LUMINATION", { add = 80 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_telekin_potion_0" }
    :value("CARRY_WEIGHT", { multiply = 1.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_telekin_potion_comedown_0" }
    :value("CARRY_WEIGHT", { multiply = 0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_telepath_potion_0" }
    :value("LEARNING_FOCUS", { add = 15 })
    :value("SKILL_RUST_RESIST", { add = 100 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_telepath_potion_comedown_0" }
    :value("LEARNING_FOCUS", { add = -30 })
    :value("READING_EXP", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vitakin_potion_0" }
    :value("MAX_HP", { multiply = 0.2 }))

-- effects/effects_psionic.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_biokin_hurricane_blows_2_1" }
    :value("ATTACK_SPEED", { multiply = -0.25 })
    :value("RANGE", { multiply = -1.99 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_clair_better_senses_pain_0" }
    :value("PERCEPTION", { add = -3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_clair_perfect_shot_0" }
    :value("RANGED_DAMAGE", { multiply = 1.5 })
    :value("WEAPON_DISPERSION", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_photokin_light_local_0" }
    :value("LUMINATION", { add = 5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_photokin_light_barrier_0" }
    :value("LUMINATION", { add = 15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_pyrokinetic_flame_immunity_0" }
    :incoming_damage("heat", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_telekinetic_aegis_0" }
    :incoming_damage("bash", { add = -100000 })
    :incoming_damage("stab", { add = -100000 })
    :incoming_damage("cut", { add = -100000 })
    :incoming_damage("bullet", { add = -100000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_teleport_reactive_displacement_0" }
    :hit_me({ id = "teleport_reactive_displacement_teleport" }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_teleport_slow_0" }
    :value("SPEED", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vitakin_hurt_0" }
    :value("SPEED", { multiply = -0.05 })
    :value("REGEN_HP", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vitakin_no_need_for_sleep_0" }
    :value("SLEEPINESS", { multiply = -1 })
    :value("LEARNING_FOCUS", { add = -15 })
    :skill("speech", { multiply = -0.5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_vita_degenerating_touch_0" }
    :value("REGEN_HP", { multiply = -1 })
    :value("SPEED", { multiply = -0.33 }))
