local ccb = require("ccb")
local content = ccb.content

local progression = require("enchantment_progression")

local vampire_traits = {
    "BLOODHASTE",
    "BLOODHEAL",
    "BLOOD_FUN",
    "BLOOD_FUN_UPGRADE",
    "COAGULANTWEAVE",
    "COMMUNE_NIGHT",
    "DHAMPIR_AVOID_EAT_SLEEP_DRINK",
    "DHAMPIR_BLACKEN_SOUL_ARION",
    "DHAMPIR_FANGS",
    "DHAMPIR_MEND_WOUNDS_FASTER",
    "DHAMPIR_REDUCED_COLD_TEMPS",
    "DHAMPIR_REDUCED_PAIN",
    "DHAMPIR_RESIST_DISEASE_POISON_INFECTION",
    "DHAMPIR_SLOWFALL",
    "EYEGLEAM",
    "EYEGLEAM_UPGRADE",
    "HYPNOTIC_GAZE",
    "MAGICFORBLOOD",
    "STAMINAFORBLOOD",
    "TRUE_VAMPIRE_POWER",
    "VAMPIRE_BAT_FORM",
    "VAMPIRE_BEAST_CLAWS",
    "VAMPIRE_BIG_STOMACH",
    "VAMPIRE_BLIND_THE_SUN",
    "VAMPIRE_BLOOD_FOR_POTENCY",
    "VAMPIRE_BLOOD_FOR_POTENCY_REAL",
    "VAMPIRE_BLOOD_TEMPORARY_BOOST",
    "VAMPIRE_BONUS_HP",
    "VAMPIRE_CARDIO_BONUS",
    "VAMPIRE_COMMAND_BEAST",
    "VAMPIRE_DETECT_VAMPIRES",
    "VAMPIRE_DISTILLATE_INNER_BLOOD",
    "VAMPIRE_DOMINATE",
    "VAMPIRE_DRINK_VAMPIRE_BLOOD",
    "VAMPIRE_EARTH_SLUMBER",
    "VAMPIRE_FEAR_GAZE",
    "VAMPIRE_FEIGN_DEATH",
    "VAMPIRE_FORM_UPGRADE",
    "VAMPIRE_GAIN_BLOOD_GIFTS",
    "VAMPIRE_HEALTH_BONUS",
    "VAMPIRE_HEAL_IN_DARK",
    "VAMPIRE_HEIGHTENED_SENSES",
    "VAMPIRE_INSTANT_BLEED",
    "VAMPIRE_INVISIBLE_IN_DARK",
    "VAMPIRE_IRON_MIND",
    "VAMPIRE_LAST_BREATH_MIST",
    "VAMPIRE_LAST_BREATH_MIST_UPGRADE",
    "VAMPIRE_MASTER_MORTAL_MIND",
    "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE",
    "VAMPIRE_MIST_FORM",
    "VAMPIRE_MOTION_ALARM",
    "VAMPIRE_NO_BREATHE",
    "VAMPIRE_NO_ILLNESS",
    "VAMPIRE_NO_ILLNESS_UPGRADE",
    "VAMPIRE_SEE_HEAT",
    "VAMPIRE_SEE_THROUGH_NIGHT_EYES",
    "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT",
    "VAMPIRE_SHADOW_FORM",
    "VAMPIRE_SILENT_MOVE",
    "VAMPIRE_SILENT_MOVE_UPGRADE",
    "VAMPIRE_STORE_MORE_BLOOD",
    "VAMPIRE_STORE_MORE_BLOOD_UPGRADE",
    "VAMPIRE_TORPOR",
    "VAMPIRE_WALK_ON_WALLS",
    "VAMPIRE_WOLF_FORM",
    "VAMPIRIC_DODGE",
    "VAMPIRIC_RESILIENCE",
    "VAMPIRIC_STEALTH_BONUS",
    "VAMPIRIC_STRENGTH",
}

-- effects/effects.json
ccb.runtime.handler("progression_enchantment_inline_ench_eyegleam_0_value_0_add", function(ctx)
    return (((((5 + (progression.vampire_tier_one_with_potency(ctx) * 1)) + (progression.vampire_tier_two(ctx) * 2)) + (progression.vampire_tier_three(ctx) * 3)) + (progression.vampire_tier_four_with_potence(ctx) * 4)) + (progression.vampire_tier_five_with_cauldron(ctx) * 5))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_eyegleam_0",
    load_character_inputs = {
        effect_intensities = { "effect_player_anathema_potency_boost" },
        traits = vampire_traits
    },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", {
        add_handler = "progression_enchantment_inline_ench_eyegleam_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampiric_strength_0_value_0_add", function(ctx)
    return (((((1 + (progression.vampire_tier_one_with_potency(ctx) * 0.25)) + (progression.vampire_tier_two(ctx) * 0.33)) + (progression.vampire_tier_three(ctx) * 0.5)) + (progression.vampire_tier_four_with_potence(ctx) * 0.75)) + (progression.vampire_tier_five_with_cauldron(ctx) * 1))
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampiric_strength_0_value_1_add", function(ctx)
    return ((((((-10) + (progression.vampire_tier_one_with_potency(ctx) * (-1))) + (progression.vampire_tier_two(ctx) * (-2))) + (progression.vampire_tier_three(ctx) * (-3))) + (progression.vampire_tier_four_with_potence(ctx) * (-4))) + (progression.vampire_tier_five_with_cauldron(ctx) * (-5)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampiric_strength_0",
    load_character_inputs = {
        effect_intensities = { "effect_player_anathema_potency_boost" },
        traits = vampire_traits
    },
    native_modifier_order = true,
}
    :value("STRENGTH", {
        add_handler = "progression_enchantment_inline_ench_effect_vampiric_strength_0_value_0_add",
        load_skills = {}
    })
    :value("OVERKILL_DAMAGE", {
        add_handler = "progression_enchantment_inline_ench_effect_vampiric_strength_0_value_1_add",
        load_skills = {}
    }))

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampire_unholy_devastation_0_value_0_add", function(ctx)
    return ((((((1 + (progression.vampire_tier_one_with_potency(ctx) * 0.25)) + (progression.vampire_tier_two(ctx) * 0.33)) + (progression.vampire_tier_three(ctx) * 0.5)) + (progression.vampire_tier_four_with_potence(ctx) * 0.75)) + (progression.vampire_tier_five_with_cauldron(ctx) * 1)) * (ctx.character_inputs.effect_intensities["effect_vampire_unholy_devastation"] * 0.25))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampire_unholy_devastation_0",
    load_character_inputs = {
        effect_intensities = { "effect_player_anathema_potency_boost", "effect_vampire_unholy_devastation" },
        traits = vampire_traits
    },
    native_modifier_order = true,
}
    :value("SMASH_BONUS", {
        add_handler = "progression_enchantment_inline_ench_effect_vampire_unholy_devastation_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampiric_resilience_0_incoming_damage_0_multiply", function(ctx)
    return math.max((((((progression.vampire_tier_one_with_potency(ctx) * (-0.01)) + (progression.vampire_tier_two(ctx) * (-0.02))) + (progression.vampire_tier_three(ctx) * (-0.04))) + (progression.vampire_tier_four_with_potence(ctx) * (-0.06))) + (progression.vampire_tier_five_with_cauldron(ctx) * (-0.08))), (-0.66))
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampiric_resilience_0_incoming_damage_1_multiply", function(ctx)
    return math.max((((((progression.vampire_tier_one_with_potency(ctx) * (-0.003)) + (progression.vampire_tier_two(ctx) * (-0.007))) + (progression.vampire_tier_three(ctx) * (-0.015))) + (progression.vampire_tier_four_with_potence(ctx) * (-0.025))) + (progression.vampire_tier_five_with_cauldron(ctx) * (-0.035))), (-0.25))
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampiric_resilience_0_incoming_damage_2_multiply", function(ctx)
    return math.max((((((progression.vampire_tier_one_with_potency(ctx) * (-0.005)) + (progression.vampire_tier_two(ctx) * (-0.01))) + (progression.vampire_tier_three(ctx) * (-0.02))) + (progression.vampire_tier_four_with_potence(ctx) * (-0.03))) + (progression.vampire_tier_five_with_cauldron(ctx) * (-0.04))), (-0.33))
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampiric_resilience_0_incoming_damage_3_multiply", function(ctx)
    return math.max((((((progression.vampire_tier_one_with_potency(ctx) * (-0.012)) + (progression.vampire_tier_two(ctx) * (-0.025))) + (progression.vampire_tier_three(ctx) * (-0.05))) + (progression.vampire_tier_four_with_potence(ctx) * (-0.075))) + (progression.vampire_tier_five_with_cauldron(ctx) * 0.1)), (-0.85))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampiric_resilience_0",
    load_character_inputs = {
        effect_intensities = { "effect_player_anathema_potency_boost" },
        traits = vampire_traits
    },
    native_modifier_order = true,
}
    :incoming_damage("bash", {
        multiply_handler = "progression_enchantment_inline_ench_effect_vampiric_resilience_0_incoming_damage_0_multiply",
        load_skills = {}
    })
    :incoming_damage("stab", {
        multiply_handler = "progression_enchantment_inline_ench_effect_vampiric_resilience_0_incoming_damage_1_multiply",
        load_skills = {}
    })
    :incoming_damage("cut", {
        multiply_handler = "progression_enchantment_inline_ench_effect_vampiric_resilience_0_incoming_damage_2_multiply",
        load_skills = {}
    })
    :incoming_damage("bullet", {
        multiply_handler = "progression_enchantment_inline_ench_effect_vampiric_resilience_0_incoming_damage_3_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampiric_dodge_0_value_0_add", function(ctx)
    return math.min((0.15 + (((((progression.vampire_tier_one_with_potency(ctx) * 0.012) + (progression.vampire_tier_two(ctx) * 0.025)) + (progression.vampire_tier_three(ctx) * 0.05)) + (progression.vampire_tier_four_with_potence(ctx) * 0.075)) + (progression.vampire_tier_five_with_cauldron(ctx) * 0.1))), 0.7)
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampiric_dodge_0_value_1_add", function(ctx)
    return math.min((1 + (((((progression.vampire_tier_one_with_potency(ctx) * 0.25) + (progression.vampire_tier_two(ctx) * 0.45)) + (progression.vampire_tier_three(ctx) * 0.65)) + (progression.vampire_tier_four_with_potence(ctx) * 0.95)) + (progression.vampire_tier_five_with_cauldron(ctx) * 1.25))), 15)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampiric_dodge_0",
    load_character_inputs = {
        effect_intensities = { "effect_player_anathema_potency_boost" },
        traits = vampire_traits
    },
    native_modifier_order = true,
}
    :value("EVASION", {
        add_handler = "progression_enchantment_inline_ench_effect_vampiric_dodge_0_value_0_add",
        load_skills = {}
    })
    :value("DODGE_CHANCE", {
        add_handler = "progression_enchantment_inline_ench_effect_vampiric_dodge_0_value_1_add",
        load_skills = {}
    })
    :value("BONUS_DODGE", { add = 2 }))

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampiric_stealth_bonus_0_value_0_add", function(ctx)
    return math.min((30 + (((((progression.vampire_tier_one_with_potency(ctx) * 0.25) + (progression.vampire_tier_two(ctx) * 0.4)) + (progression.vampire_tier_three(ctx) * 0.55)) + (progression.vampire_tier_four_with_potence(ctx) * 0.75)) + (progression.vampire_tier_five_with_cauldron(ctx) * 1))), 60)
end)

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_vampiric_stealth_bonus_0", function(ctx)
    return (not (ctx.character_inputs.environment.daylight) or
        not (ctx.character_inputs.environment.outside))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampiric_stealth_bonus_0",
    condition_handler = "progression_enchantment_active_inline_ench_effect_vampiric_stealth_bonus_0",
    load_character_inputs = {
        effect_intensities = { "effect_player_anathema_potency_boost" },
        environment = { daylight = true, outside = true },
        traits = vampire_traits
    },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", {
        add_handler = "progression_enchantment_inline_ench_effect_vampiric_stealth_bonus_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampire_feign_death_2_value_0_multiply", function(ctx)
    return (((((ctx.character_inputs.character_variables["vampire_total_tier_one_traits_plus_potency"] * 0.02) + (ctx.character_inputs.character_variables["vampire_total_tier_two_traits"] * 0.03)) + (ctx.character_inputs.character_variables["vampire_total_tier_three_traits"] * 0.04)) + (progression.vampire_tier_four_with_potence(ctx) * 0.05)) + (ctx.character_inputs.character_variables["vampire_total_tier_five_traits_plus_cauldron"] * 0.06))
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampire_feign_death_2_value_1_multiply", function(ctx)
    return (((((ctx.character_inputs.character_variables["vampire_total_tier_one_traits_plus_potency"] * 0.03) + (ctx.character_inputs.character_variables["vampire_total_tier_two_traits"] * 0.04)) + (ctx.character_inputs.character_variables["vampire_total_tier_three_traits"] * 0.05)) + (progression.vampire_tier_four_with_potence(ctx) * 0.06)) + (ctx.character_inputs.character_variables["vampire_total_tier_five_traits_plus_cauldron"] * 0.07))
end)

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_vampire_feign_death_2", function(ctx)
    return ctx.character_inputs.traits["VAMPIRE_TORPOR_REFINEMENT_FEIGN_DEATH"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampire_feign_death_2",
    condition_handler = "progression_enchantment_active_inline_ench_effect_vampire_feign_death_2",
    load_character_inputs = {
        character_variables = {
            "vampire_total_tier_five_traits_plus_cauldron",
            "vampire_total_tier_one_traits_plus_potency",
            "vampire_total_tier_three_traits",
            "vampire_total_tier_two_traits"
        },
        traits = {
            "TRUE_VAMPIRE_POWER",
            "VAMPIRE_BAT_FORM",
            "VAMPIRE_BLOOD_FOR_POTENCY",
            "VAMPIRE_DOMINATE",
            "VAMPIRE_FORM_UPGRADE",
            "VAMPIRE_INVISIBLE_IN_DARK",
            "VAMPIRE_MIST_FORM",
            "VAMPIRE_NO_BREATHE",
            "VAMPIRE_NO_ILLNESS",
            "VAMPIRE_NO_ILLNESS_UPGRADE",
            "VAMPIRE_STORE_MORE_BLOOD_UPGRADE",
            "VAMPIRE_TORPOR",
            "VAMPIRE_TORPOR_REFINEMENT_FEIGN_DEATH",
            "VAMPIRE_WOLF_FORM"
        }
    },
    native_modifier_order = true,
}
    :value("REGEN_HP", {
        multiply_handler = "progression_enchantment_inline_ench_effect_vampire_feign_death_2_value_0_multiply",
        load_skills = {}
    })
    :value("MENDING_MODIFIER", {
        multiply_handler = "progression_enchantment_inline_ench_effect_vampire_feign_death_2_value_1_multiply",
        load_skills = {}
    })
    :value("REGEN_HP_AWAKE", { multiply = 1 })
    :value("SLEEPINESS", { multiply = -0.5 }))

ccb.runtime.handler("progression_enchantment_inline_ench_effect_xedra_chronomancer_chronal_accel_0_value_0_add", function(ctx)
    return progression.chron_spell(ctx, ctx.character_inputs.spell_levels["xedra_chronomancer_chronal_acceleration"], 5, 0)
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_xedra_chronomancer_chronal_accel_0_value_1_add", function(ctx)
    return (-math.max((1000 - (25 * ctx.character_inputs.spell_levels["xedra_chronomancer_chronal_acceleration"])), 250))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xedra_chronomancer_chronal_accel_0",
    load_character_inputs = { spell_levels = { "xedra_chronomancer_chronal_acceleration" }, stats = true },
    native_modifier_order = true,
}
    :value("SPEED", {
        add_handler = "progression_enchantment_inline_ench_effect_xedra_chronomancer_chronal_accel_0_value_0_add",
        load_skills = {}
    })
    :value("MAX_MANA", {
        add_handler = "progression_enchantment_inline_ench_effect_xedra_chronomancer_chronal_accel_0_value_1_add",
        load_skills = {}
    }))

ccb.runtime.handler("progression_enchantment_inline_ench_effect_xedra_rewrite_wound_causality_0_value_0_multiply", function(ctx)
    return progression.chron_spell(ctx, ctx.character_inputs.spell_levels["xedra_chronomancer_rewrite_wound_causality"], 5, 0)
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_xedra_rewrite_wound_causality_0_value_1_multiply", function(ctx)
    return progression.chron_spell(ctx, ctx.character_inputs.spell_levels["xedra_chronomancer_rewrite_wound_causality"], 5, 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xedra_rewrite_wound_causality_0",
    load_character_inputs = { spell_levels = { "xedra_chronomancer_rewrite_wound_causality" }, stats = true },
    native_modifier_order = true,
}
    :value("REGEN_HP", {
        multiply_handler = "progression_enchantment_inline_ench_effect_xedra_rewrite_wound_causality_0_value_0_multiply",
        load_skills = {}
    })
    :value("MENDING_MODIFIER", {
        multiply_handler = "progression_enchantment_inline_ench_effect_xedra_rewrite_wound_causality_0_value_1_multiply",
        load_skills = {}
    })
    :value("REGEN_HP_AWAKE", { multiply = 1 }))

-- mutations/vampire_trait_eocs.json
ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampire_torpor_1_value_0_multiply", function(ctx)
    return (((((ctx.character_inputs.character_variables["vampire_total_tier_one_traits_plus_potency"] * 0.05) + (ctx.character_inputs.character_variables["vampire_total_tier_two_traits"] * 0.075)) + (ctx.character_inputs.character_variables["vampire_total_tier_three_traits"] * 0.1)) + (progression.vampire_tier_four_with_potence(ctx) * 0.2)) + (ctx.character_inputs.character_variables["vampire_total_tier_five_traits_plus_cauldron"] * 0.3))
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_vampire_torpor_1_value_1_multiply", function(ctx)
    return (((((ctx.character_inputs.character_variables["vampire_total_tier_one_traits_plus_potency"] * 0.05) + (ctx.character_inputs.character_variables["vampire_total_tier_two_traits"] * 0.075)) + (ctx.character_inputs.character_variables["vampire_total_tier_three_traits"] * 0.1)) + (progression.vampire_tier_four_with_potence(ctx) * 0.2)) + (ctx.character_inputs.character_variables["vampire_total_tier_five_traits_plus_cauldron"] * 0.3))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vampire_torpor_1",
    load_character_inputs = {
        character_variables = {
            "vampire_total_tier_five_traits_plus_cauldron",
            "vampire_total_tier_one_traits_plus_potency",
            "vampire_total_tier_three_traits",
            "vampire_total_tier_two_traits"
        },
        traits = {
            "TRUE_VAMPIRE_POWER",
            "VAMPIRE_BAT_FORM",
            "VAMPIRE_BLOOD_FOR_POTENCY",
            "VAMPIRE_DOMINATE",
            "VAMPIRE_FORM_UPGRADE",
            "VAMPIRE_INVISIBLE_IN_DARK",
            "VAMPIRE_MIST_FORM",
            "VAMPIRE_NO_BREATHE",
            "VAMPIRE_NO_ILLNESS",
            "VAMPIRE_NO_ILLNESS_UPGRADE",
            "VAMPIRE_STORE_MORE_BLOOD_UPGRADE",
            "VAMPIRE_TORPOR",
            "VAMPIRE_WOLF_FORM"
        }
    },
    native_modifier_order = true,
}
    :value("REGEN_HP", {
        multiply_handler = "progression_enchantment_inline_ench_effect_vampire_torpor_1_value_0_multiply",
        load_skills = {}
    })
    :value("MENDING_MODIFIER", {
        multiply_handler = "progression_enchantment_inline_ench_effect_vampire_torpor_1_value_1_multiply",
        load_skills = {}
    })
    :value("REGEN_HP_AWAKE", { multiply = 1 })
    :value("SLEEPINESS_REGEN", { multiply = 20 })
    :value("SLEEPINESS", { multiply = -0.99 }))

-- mutations/mutations.json
ccb.runtime.handler("progression_enchantment_active_inline_ench_vampire_health_bonus_0", function(ctx)
    return not ((ctx.character_inputs.effects["effect_dhampir_enervated_blood"] or ctx.character_inputs.effects["withering"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_HEALTH_BONUS_0",
    condition_handler = "progression_enchantment_active_inline_ench_vampire_health_bonus_0",
    load_character_inputs = { effects = { "effect_dhampir_enervated_blood", "withering" } },
    native_modifier_order = true,
}
    :effect("effect_vampire_health_bonus", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_BLOOD_DRINKER_0",
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_HEAT", { add = 9999 })
    :value("STAMINA_REGEN_MOD", { add = 0.1, multiply = -0.333 })
    :value("KCAL", { multiply = -100 })
    :value("VITAMIN_ABSORB_MOD", { multiply = -100 })
    :value("HUNGER", { multiply = -1 })
    :value("THIRST", { multiply = -1 })
    :value("METABOLISM", { multiply = -1 }))

-- mutations/paraclesians/homullus_mutations.json
ccb.runtime.handler("progression_enchantment_active_inline_ench_homullus_can_use_computers_0", function(ctx)
    return (ctx.character_inputs.skills["computer"] <= 7)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_CAN_USE_COMPUTERS_0",
    condition_handler = "progression_enchantment_active_inline_ench_homullus_can_use_computers_0",
    load_character_inputs = { skills = { "computer" } },
    native_modifier_order = true,
}
    :skill("computers", { add = 2 }))

ccb.runtime.handler("progression_enchantment_active_inline_ench_homullus_can_use_computers_1", function(ctx)
    return (ctx.character_inputs.skills["computer"] <= 8)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_CAN_USE_COMPUTERS_1",
    condition_handler = "progression_enchantment_active_inline_ench_homullus_can_use_computers_1",
    load_character_inputs = { skills = { "computer" } },
    native_modifier_order = true,
}
    :skill("computers", { add = 1 }))

-- mutations/playable_changeling.json
ccb.runtime.handler("progression_enchantment_active_inline_ench_changeling_noble_inhuman_mindset_3", function(ctx)
    return (ctx.character_inputs.effects["formication"] or ctx.character_inputs.effects["visuals"] or ctx.character_inputs.effects["hallu"] or ctx.character_inputs.effects["bite"] or ctx.character_inputs.effects["infected"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_CHANGELING_NOBLE_INHUMAN_MINDSET_3",
    condition_handler = "progression_enchantment_active_inline_ench_changeling_noble_inhuman_mindset_3",
    load_character_inputs = { effects = { "bite", "formication", "hallu", "infected", "visuals" } },
    native_modifier_order = true,
}
    :effect("effect_changeling_temporary_psychopath", 1))
