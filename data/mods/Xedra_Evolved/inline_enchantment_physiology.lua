local ccb = require("ccb")
local content = ccb.content

local function clamp(value, minimum, maximum)
    return math.min(math.max(value, minimum), maximum)
end

-- effects/effects.json
ccb.runtime.handler("inline_physiology_inline_ench_effect_dhampir_enervated_blood_0_value_0_multiply", function(ctx)
    return (0.05 + clamp(((ctx.character_inputs.vitamins["human_blood_vitamin"] + 500) * 0.001), 0, 1))
end)

ccb.runtime.handler("inline_physiology_inline_ench_effect_dhampir_enervated_blood_0_value_1_multiply", function(ctx)
    return (0.05 + clamp(((ctx.character_inputs.vitamins["human_blood_vitamin"] + 500) * 0.001), 0, 1))
end)

ccb.runtime.handler("inline_physiology_inline_ench_effect_dhampir_enervated_blood_0_value_2_multiply", function(ctx)
    return (0.05 + clamp(((ctx.character_inputs.vitamins["human_blood_vitamin"] + 500) * 0.001), 0, 1))
end)

ccb.runtime.handler("inline_physiology_inline_ench_effect_dhampir_enervated_blood_0_value_3_multiply", function(ctx)
    return ((-0.025) + clamp(((ctx.character_inputs.vitamins["human_blood_vitamin"] + 500) * (-0.00025)), (-0.5), 0))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_dhampir_enervated_blood_0",
    load_character_inputs = { vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :value("HUNGER", { multiply_handler = "inline_physiology_inline_ench_effect_dhampir_enervated_blood_0_value_0_multiply", load_skills = {  } })
    :value("THIRST", { multiply_handler = "inline_physiology_inline_ench_effect_dhampir_enervated_blood_0_value_1_multiply", load_skills = {  } })
    :value("SLEEPINESS", { multiply_handler = "inline_physiology_inline_ench_effect_dhampir_enervated_blood_0_value_2_multiply", load_skills = {  } })
    :value("REGEN_STAMINA", { multiply_handler = "inline_physiology_inline_ench_effect_dhampir_enervated_blood_0_value_3_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_active_inline_ench_effect_vampiric_strength_1", function(ctx)
    return (ctx.character_inputs.stats.strength >= 25)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampiric_strength_1",
    condition_handler = "inline_physiology_active_inline_ench_effect_vampiric_strength_1",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :effect("effect_xe_blocking_huge_attacks", 1))

ccb.runtime.handler("inline_physiology_inline_ench_effect_lilin_owl_form_pass_through_walls_0_value_0_add", function(ctx)
    return (0.4 + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 18000))
end)

ccb.runtime.handler("inline_physiology_active_inline_ench_effect_lilin_owl_form_pass_through_walls_0", function(ctx)
    return ctx.character_inputs.traits["TURN_INTO_OWL_TRAITS"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_lilin_owl_form_pass_through_walls_0",
    condition_handler = "inline_physiology_active_inline_ench_effect_lilin_owl_form_pass_through_walls_0",
    load_character_inputs = { traits = { "TURN_INTO_OWL_TRAITS" }, vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :value("EVASION", { add_handler = "inline_physiology_inline_ench_effect_lilin_owl_form_pass_through_walls_0_value_0_add", load_skills = {  } }))

-- mutations/mutations.json
ccb.runtime.handler("inline_physiology_active_inline_ench_dhampir_trait_0", function(ctx)
    return (not (ctx.character_inputs.traits["DHAMPIR_WEAKNESS_SLOWER_BLOOD_GAIN"]) and
        not (ctx.character_inputs.effects["effect_dhampir_the_blood_is_the_life"]) and
        (ctx.character_inputs.vitamins["human_blood_vitamin"] < 1799))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_TRAIT_0",
    condition_handler = "inline_physiology_active_inline_ench_dhampir_trait_0",
    load_character_inputs = { effects = { "effect_dhampir_the_blood_is_the_life" }, traits = { "DHAMPIR_WEAKNESS_SLOWER_BLOOD_GAIN" }, vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :effect("effect_dhampir_slow_blood_gain", 1))

ccb.runtime.handler("inline_physiology_active_inline_ench_dhampir_trait_1", function(ctx)
    return (ctx.character_inputs.traits["DHAMPIR_WEAKNESS_SLOWER_BLOOD_GAIN"] and
        not (ctx.character_inputs.effects["effect_dhampir_the_blood_is_the_life"]) and
        (ctx.character_inputs.vitamins["human_blood_vitamin"] < 1799))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_TRAIT_1",
    condition_handler = "inline_physiology_active_inline_ench_dhampir_trait_1",
    load_character_inputs = { effects = { "effect_dhampir_the_blood_is_the_life" }, traits = { "DHAMPIR_WEAKNESS_SLOWER_BLOOD_GAIN" }, vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :effect("effect_dhampir_slow_blood_gain_with_weakness", 1))

ccb.runtime.handler("inline_physiology_active_inline_ench_dhampir_trait_2", function(ctx)
    return (ctx.character_inputs.vitamins["human_blood_vitamin"] >= 1800)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_TRAIT_2",
    condition_handler = "inline_physiology_active_inline_ench_dhampir_trait_2",
    load_character_inputs = { vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :effect("effect_dhampir_slow_blood_loss", 1))

ccb.runtime.handler("inline_physiology_active_inline_ench_dhampir_trait_3", function(ctx)
    return (ctx.character_inputs.vitamins["human_blood_vitamin"] < 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_TRAIT_3",
    condition_handler = "inline_physiology_active_inline_ench_dhampir_trait_3",
    load_character_inputs = { vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :effect("effect_dhampir_enervated_blood", 1))

ccb.runtime.handler("inline_physiology_active_inline_ench_dhampir_trait_4", function(ctx)
    return (ctx.character_inputs.vitamins["human_blood_vitamin"] > 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_TRAIT_4",
    condition_handler = "inline_physiology_active_inline_ench_dhampir_trait_4",
    load_character_inputs = { vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :effect("effect_dhampir_empowered_blood_indicator", 1))

ccb.runtime.handler("inline_physiology_inline_ench_dhampir_mend_wounds_faster_0_value_0_multiply", function(ctx)
    return math.max((ctx.character_inputs.vitamins["human_blood_vitamin"] / 250), 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_MEND_WOUNDS_FASTER_0",
    load_character_inputs = { vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :value("MENDING_MODIFIER", { multiply_handler = "inline_physiology_inline_ench_dhampir_mend_wounds_faster_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_active_inline_ench_vampire4_1", function(ctx)
    return (ctx.character_inputs.vitamins["human_blood_vitamin"] <= 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE4_1",
    condition_handler = "inline_physiology_active_inline_ench_vampire4_1",
    load_character_inputs = { vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :value("MENDING_MODIFIER", { multiply = -1 })
    :value("REGEN_HP", { multiply = -1 }))

ccb.runtime.handler("inline_physiology_inline_ench_vampire4_2_value_0_multiply", function(ctx)
    return (5 + (ctx.character_inputs.vitamins["human_blood_vitamin"] / 300))
end)

ccb.runtime.handler("inline_physiology_active_inline_ench_vampire4_2", function(ctx)
    return ((ctx.character_inputs.vitamins["human_blood_vitamin"] > 0) and
        (ctx.character_inputs.vitamins["human_blood_vitamin"] < 1800))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE4_2",
    condition_handler = "inline_physiology_active_inline_ench_vampire4_2",
    load_character_inputs = { vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :value("REGEN_HP", { multiply_handler = "inline_physiology_inline_ench_vampire4_2_value_0_multiply", load_skills = {  } })
    :value("REGEN_HP_AWAKE", { multiply = 1 })
    :value("MENDING_MODIFIER", { multiply = 2 }))

ccb.runtime.handler("inline_physiology_inline_ench_vampire4_3_value_0_multiply", function(ctx)
    return (11 + ((ctx.character_inputs.vitamins["human_blood_vitamin"] - 1800) / 325))
end)

ccb.runtime.handler("inline_physiology_active_inline_ench_vampire4_3", function(ctx)
    return ((ctx.character_inputs.vitamins["human_blood_vitamin"] >= 1800) and
        (ctx.character_inputs.vitamins["human_blood_vitamin"] < 4400))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE4_3",
    condition_handler = "inline_physiology_active_inline_ench_vampire4_3",
    load_character_inputs = { vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :value("REGEN_HP", { multiply_handler = "inline_physiology_inline_ench_vampire4_3_value_0_multiply", load_skills = {  } })
    :value("REGEN_HP_AWAKE", { multiply = 1 })
    :value("MENDING_MODIFIER", { multiply = 6 }))

ccb.runtime.handler("inline_physiology_inline_ench_vampire4_4_value_0_multiply", function(ctx)
    return (19 + ((ctx.character_inputs.vitamins["human_blood_vitamin"] - 4400) / 600))
end)

ccb.runtime.handler("inline_physiology_active_inline_ench_vampire4_4", function(ctx)
    return (ctx.character_inputs.vitamins["human_blood_vitamin"] >= 4400)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE4_4",
    condition_handler = "inline_physiology_active_inline_ench_vampire4_4",
    load_character_inputs = { vitamins = { "human_blood_vitamin" } },
    native_modifier_order = true,
}
    :value("REGEN_HP", { multiply_handler = "inline_physiology_inline_ench_vampire4_4_value_0_multiply", load_skills = {  } })
    :value("REGEN_HP_AWAKE", { multiply = 1 })
    :value("MENDING_MODIFIER", { multiply = 12 }))

-- mutations/xe_lilin.json
ccb.runtime.handler("inline_physiology_active_inline_ench_lilin_silent_at_night_0", function(ctx)
    return (not (ctx.character_inputs.environment.daylight) and
        (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_SILENT_AT_NIGHT_0",
    condition_handler = "inline_physiology_active_inline_ench_lilin_silent_at_night_0",
    load_character_inputs = { environment = { daylight = true }, vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :effect("effect_lilin_silent_at_night", 1))

ccb.runtime.handler("inline_physiology_inline_ench_lilin_bonus_persuasion_0_value_0_add", function(ctx)
    return (12 + (12 * (ctx.character_inputs.traits["THRESH_LILIN"] and 1 or 0)))
end)

ccb.runtime.handler("inline_physiology_active_inline_ench_lilin_bonus_persuasion_0", function(ctx)
    return (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_BONUS_PERSUASION_0",
    condition_handler = "inline_physiology_active_inline_ench_lilin_bonus_persuasion_0",
    load_character_inputs = { traits = { "THRESH_LILIN" }, vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :value("SOCIAL_PERSUADE", { add_handler = "inline_physiology_inline_ench_lilin_bonus_persuasion_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_inline_ench_lilin_bonus_lying_0_value_0_add", function(ctx)
    return (12 + (12 * (ctx.character_inputs.traits["THRESH_LILIN"] and 1 or 0)))
end)

ccb.runtime.handler("inline_physiology_active_inline_ench_lilin_bonus_lying_0", function(ctx)
    return (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_BONUS_LYING_0",
    condition_handler = "inline_physiology_active_inline_ench_lilin_bonus_lying_0",
    load_character_inputs = { traits = { "THRESH_LILIN" }, vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :value("SOCIAL_LIE", { add_handler = "inline_physiology_inline_ench_lilin_bonus_lying_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_active_inline_ench_lilin_steady_speed_0", function(ctx)
    return (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_STEADY_SPEED_0",
    condition_handler = "inline_physiology_active_inline_ench_lilin_steady_speed_0",
    load_character_inputs = { vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :effect("effect_lilin_steady_speed", 1))

ccb.runtime.handler("inline_physiology_inline_ench_lilin_gain_more_focus_0_value_0_add", function(ctx)
    return (((5 + clamp((ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 100), 0, 10)) + clamp(((ctx.character_inputs.vitamins["lilin_ruach_vitamin"] - 1000) / 250), 0, 10)) + clamp(((ctx.character_inputs.vitamins["lilin_ruach_vitamin"] - 3000) / 500), 0, 10))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_GAIN_MORE_FOCUS_0", condition = "ALWAYS",
    load_character_inputs = { vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :value("LEARNING_FOCUS", { add_handler = "inline_physiology_inline_ench_lilin_gain_more_focus_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_inline_ench_lilin_easier_weakpoint_attacks_0_value_0_multiply", function(ctx)
    return (0.5 + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 2000))
end)

ccb.runtime.handler("inline_physiology_active_inline_ench_lilin_easier_weakpoint_attacks_0", function(ctx)
    return (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_EASIER_WEAKPOINT_ATTACKS_0",
    condition_handler = "inline_physiology_active_inline_ench_lilin_easier_weakpoint_attacks_0",
    load_character_inputs = { vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :value("WEAKPOINT_ACCURACY", { multiply_handler = "inline_physiology_inline_ench_lilin_easier_weakpoint_attacks_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_inline_ench_lilin_resist_cold_0_value_0_add", function(ctx)
    return (15 + (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 100))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_RESIST_COLD_0", condition = "ALWAYS",
    load_character_inputs = { vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_HEAT", { add_handler = "inline_physiology_inline_ench_lilin_resist_cold_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_0_value_0_multiply", function(ctx)
    return ((-0.15) - (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 10000))
end)

ccb.runtime.handler("inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_0_value_1_multiply", function(ctx)
    return ((-0.15) - (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 10000))
end)

ccb.runtime.handler("inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_0_value_2_multiply", function(ctx)
    return ((-0.15) - (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 10000))
end)

ccb.runtime.handler("inline_physiology_active_inline_ench_lilin_reduced_needs_with_ruach_0", function(ctx)
    return (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_REDUCED_NEEDS_WITH_RUACH_0",
    condition_handler = "inline_physiology_active_inline_ench_lilin_reduced_needs_with_ruach_0",
    load_character_inputs = { vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :value("HUNGER", { multiply_handler = "inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_0_value_0_multiply", load_skills = {  } })
    :value("THIRST", { multiply_handler = "inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_0_value_1_multiply", load_skills = {  } })
    :value("METABOLISM", { multiply_handler = "inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_0_value_2_multiply", load_skills = {  } })
    :value("KCAL", { multiply = -0.333 }))

ccb.runtime.handler("inline_physiology_inline_ench_lilin_bonus_healing_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 250)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_BONUS_HEALING_0", condition = "ALWAYS",
    load_character_inputs = { vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :value("REGEN_HP", { multiply_handler = "inline_physiology_inline_ench_lilin_bonus_healing_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_active_inline_ench_lilin_limb_score_bonuses_at_night_0", function(ctx)
    return (not (ctx.character_inputs.environment.daylight) and
        (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_LIMB_SCORE_BONUSES_AT_NIGHT_0",
    condition_handler = "inline_physiology_active_inline_ench_lilin_limb_score_bonuses_at_night_0",
    load_character_inputs = { environment = { daylight = true }, vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :effect("effect_lilin_limb_score_bonuses_at_night", 1))

ccb.runtime.handler("inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_and_kcal_drain_0_value_0_multiply", function(ctx)
    return ((-0.15) - (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 10000))
end)

ccb.runtime.handler("inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_and_kcal_drain_0_value_1_multiply", function(ctx)
    return ((-0.15) - (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 10000))
end)

ccb.runtime.handler("inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_and_kcal_drain_0_value_2_multiply", function(ctx)
    return ((-0.15) - (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] / 10000))
end)

ccb.runtime.handler("inline_physiology_active_inline_ench_lilin_reduced_needs_with_ruach_and_kcal_drain_0", function(ctx)
    return (ctx.character_inputs.vitamins["lilin_ruach_vitamin"] >= 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LILIN_REDUCED_NEEDS_WITH_RUACH_AND_KCAL_DRAIN_0",
    condition_handler = "inline_physiology_active_inline_ench_lilin_reduced_needs_with_ruach_and_kcal_drain_0",
    load_character_inputs = { vitamins = { "lilin_ruach_vitamin" } },
    native_modifier_order = true,
}
    :value("HUNGER", { multiply_handler = "inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_and_kcal_drain_0_value_0_multiply", load_skills = {  } })
    :value("THIRST", { multiply_handler = "inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_and_kcal_drain_0_value_1_multiply", load_skills = {  } })
    :value("METABOLISM", { multiply_handler = "inline_physiology_inline_ench_lilin_reduced_needs_with_ruach_and_kcal_drain_0_value_2_multiply", load_skills = {  } })
    :value("KCAL", { multiply = -0.333 }))
