local content = require("ccb").content

-- data/json/effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_photophobia_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = -0.5 })
    :incoming_damage("bash", { add = 15 })
    :incoming_damage("stab", { add = 15 })
    :incoming_damage("cut", { add = 15 })
    :incoming_damage("bullet", { add = 50 }))

content.add(content.Enchantment { id = "INLINE_ENCH_Shadow_Reveal_0", condition = "ALWAYS" }
    :value("LUMINATION", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_earphones_0" }
    :value("HEARING_MULT", { multiply = -0.75 }))

content.add(content.Enchantment { id = "INLINE_ENCH_melatonin_0", condition = "ALWAYS" }
    :value("SLEEPY", { add = 4 })
    :value("SLEEPINESS", { add = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_lightsnare_0" }
    :value("SPEED", { multiply = 0.01 }))

content.add(content.Enchantment { id = "INLINE_ENCH_bile_stink_0" }
    :value("SCENT_MASK", { add = 500 }))

content.add(content.Enchantment { id = "INLINE_ENCH_dermatik_0" }
    :value("METABOLISM", { multiply = 3.0 }))

content.add(content.Enchantment { id = "INLINE_ENCH_pre_common_cold_0" }
    :value("SLEEPINESS", { multiply = 0.025 })
    :value("SLEEPINESS_REGEN", { multiply = -0.025 }))

content.add(content.Enchantment { id = "INLINE_ENCH_pre_flu_0" }
    :value("SLEEPINESS", { multiply = 0.05 })
    :value("SLEEPINESS_REGEN", { multiply = -0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_common_cold_0" }
    :value("SLEEPINESS", { multiply = 0.05 })
    :value("SLEEPINESS_REGEN", { multiply = -0.05 })
    :value("SLEEPY", { add = -5 }))

content.add(content.Enchantment { id = "INLINE_ENCH_flu_0" }
    :value("SLEEPINESS", { multiply = 0.15 })
    :value("SLEEPINESS_REGEN", { multiply = -0.15 })
    :value("SLEEPY", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_weed_high_0" }
    :value("VOMIT_MUL", { multiply = -0.9 }))

content.add(content.Enchantment { id = "INLINE_ENCH_weakened_gravity_0" }
    :value("CARRY_WEIGHT", { multiply = 1.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_triffid_fiber_indigestion_1", condition = "ALWAYS" }
    :value("THIRST", { multiply = 0.2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_polyp_out_of_phase_0", condition = "ALWAYS" }
    :value("RANGE_DODGE", { add = 0.66 }))

content.add(content.Enchantment { id = "INLINE_ENCH_nl_phase_goo_0" }
    :value("MOVE_COST", { multiply = 0.75 })
    :value("MOVECOST_OBSTACLE_MOD", { multiply = -1 })
    :value("PHASE_DISTANCE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_mon_feral_serum_user_armus_0" }
    :incoming_damage("bash", { multiply = -0.75 })
    :incoming_damage("cut", { multiply = -0.666 })
    :incoming_damage("stab", { multiply = -0.5 })
    :incoming_damage("bullet", { multiply = -0.2 }))

-- data/json/effects_on_condition/medicine_eocs/learning_serum_eoc.json
content.add(content.Enchantment { id = "INLINE_ENCH_learning_serum_crash_0" }
    :value("SLEEPINESS", { multiply = 0.25 })
    :value("LEARNING_FOCUS", { add = -25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_regen_serum_slow_time_0" }
    :value("AIMING_SPEED", { multiply = 0.25 })
    :value("ATTACK_SPEED", { multiply = -0.25 }))

-- data/json/effects_on_condition/medicine_eocs/night_operations_serum.json
content.add(content.Enchantment { id = "INLINE_ENCH_night_ops_serum_main_0" }
    :value("NIGHT_VIS", { add = 20 })
    :value("HEARING_MULT", { multiply = 1 })
    :value("MAX_STAMINA", { multiply = 1 })
    :value("SLEEPINESS", { multiply = -1 })
    :value("STAMINA_REGEN_MOD", { add = -0.45 })
    :value("THIRST", { multiply = 0.2 })
    :value("SCENT_MASK", { add = 350 }))

content.add(content.Enchantment { id = "INLINE_ENCH_night_ops_serum_crash_0" }
    :value("SCENT_MASK", { add = 350 })
    :value("STAMINA_REGEN_MOD", { add = -0.5 }))

-- data/json/effects_on_condition/medicine_eocs/regen_serum_eoc.json
content.add(content.Enchantment { id = "INLINE_ENCH_regen_serum_main_0" }
    :value("REGEN_HP", { multiply = 50 })
    :value("REGEN_HP_AWAKE", { multiply = 1 })
    :value("MENDING_MODIFIER", { add = 50 })
    :value("METABOLISM", { multiply = 2 })
    :value("HUNGER", { multiply = 2 })
    :value("SLEEPINESS", { multiply = 1 })
    :value("STAMINA_REGEN_MOD", { multiply = -0.5 })
    :value("VOMIT_MUL", { multiply = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_regen_serum_crash_fatigue_0" }
    :value("STAMINA_REGEN_MOD", { multiply = -0.5 })
    :value("SLEEPINESS", { multiply = 1 }))

-- data/json/effects_on_condition/medicine_eocs/resilience_serum_eoc.json
content.add(content.Enchantment { id = "INLINE_ENCH_resilience_serum_main_0" }
    :incoming_damage("bash", { multiply = -0.75 })
    :incoming_damage("cut", { multiply = -0.666 })
    :incoming_damage("stab", { multiply = -0.5 })
    :incoming_damage("bullet", { multiply = -0.2 })
    :mutation("INFRESIST"))

content.add(content.Enchantment { id = "INLINE_ENCH_resilience_serum_main_1" }
    :value("BLEEDING_RATE", { multiply = -0.8 }))

content.add(content.Enchantment { id = "INLINE_ENCH_resilience_serum_side_effect_jittery_0" }
    :mutation("JITTERY"))

content.add(content.Enchantment { id = "INLINE_ENCH_resilience_serum_side_effect_badmood_0" }
    :mutation("BADTEMPER"))

content.add(content.Enchantment { id = "INLINE_ENCH_resilience_serum_side_effect_hallucinations_0" }
    :mutation("SCHIZOPHRENIC"))

content.add(content.Enchantment { id = "INLINE_ENCH_resilience_serum_side_effect_downed_0" }
    :effect("downed", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_resilience_serum_crash_0" }
    :value("BLEEDING_RATE", { multiply = 0.75 }))

-- data/json/effects_on_condition/medicine_eocs/speed_serum_eoc.json
content.add(content.Enchantment { id = "INLINE_ENCH_speed_serum_crash_0" }
    :value("EXTRA_ELEC_PAIN", { multiply = 1 })
    :value("KCAL", { multiply = -0.15 })
    :value("SLEEPINESS_REGEN", { multiply = -0.3333 }))

-- data/json/items/armor/altered_object_auras.json
content.add(content.Enchantment { id = "INLINE_ENCH_artifact_teleportitis_aura_0" }
    :every(4, { id = "AEA_TELEPORT" }))

content.add(content.Enchantment { id = "INLINE_ENCH_artifact_slow_aura_0" }
    :value("ATTACK_SPEED", { multiply = 1.5 })
    :value("SPEED", { multiply = 0.5 }))

-- data/json/items/relics/highland_censer.json
content.add(content.Enchantment { id = "INLINE_ENCH_purple_incense_effect_1" }
    :value("ARTIFACT_RESONANCE", { add = 4500 })
    :value("SPEED", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_red_incense_effect_0" }
    :value("SPEED", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_yellow_incense_effect_1" }
    :value("SPEED", { add = -10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_green_incense_effect_1" }
    :value("PHASE_DISTANCE", { add = 2 })
    :value("SPEED", { add = -10 })
    :value("DODGE_CHANCE", { add = -25 })
    :value("EVASION", { add = 10 }))
