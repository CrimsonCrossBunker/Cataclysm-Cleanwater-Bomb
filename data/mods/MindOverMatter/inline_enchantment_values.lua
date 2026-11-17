local ccb = require("ccb")
local content = ccb.content

local random = ccb.services.random

local function native_random(maximum)
    local rounded = maximum < 0 and math.ceil(maximum - 0.5) or math.floor(maximum + 0.5)
    return random.native_int(math.min(0, rounded), math.max(0, rounded))
end

-- effects/effects_artifact.json
ccb.runtime.handler("inline_value_inline_ench_effect_mom_artifact_electrical_zap_attack_0_melee_damage_0_add", function(ctx)
    return (native_random(40) + 40)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_mom_artifact_electrical_zap_attack_0",
    native_modifier_order = true,
}
    :melee_damage("electric", { add_handler = "inline_value_inline_ench_effect_mom_artifact_electrical_zap_attack_0_melee_damage_0_add", load_skills = {  } }))

-- effects/effects_psionic.json
ccb.runtime.handler("inline_value_inline_ench_effect_clair_weak_point_0_value_0_add", function(ctx)
    return (((ctx.character_inputs.character_variables["discern_weakness_clear_power_level"] * 1.5) + 2) * ctx.character_inputs.character_variables["discern_weakness_clear_intelligence"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_weak_point_0",
    load_character_inputs = { character_variables = { "discern_weakness_clear_intelligence", "discern_weakness_clear_power_level" } },
    native_modifier_order = true,
}
    :value("ARMOR_ALL", { add_handler = "inline_value_inline_ench_effect_clair_weak_point_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_photokin_enemy_light_0_value_0_add", function(ctx)
    return math.min((((2 + (ctx.character_inputs.character_variables["photokinesis_power_level"] * 3)) * ctx.character_inputs.character_variables["photokinesis_intelligence"]) * ctx.character_inputs.character_variables["nether_attunement_photokinesis_scaling"]), 60)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_photokin_enemy_light_0",
    load_character_inputs = { character_variables = { "nether_attunement_photokinesis_scaling", "photokinesis_intelligence", "photokinesis_power_level" } },
    native_modifier_order = true,
}
    :value("LUMINATION", { add_handler = "inline_value_inline_ench_effect_photokin_enemy_light_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_vita_super_heal_pain_allayed"] * (-0.1))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_1_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_vita_super_heal_pain_allayed"] * (-0.1))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_2_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_vita_super_heal_pain_allayed"] * (-0.1))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_3_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_vita_super_heal_pain_allayed"] * (-0.1))
end)

ccb.runtime.handler("inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_4_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["effect_vita_super_heal_pain_allayed"] * (-0.1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vita_super_heal_pain_allayed_0",
    load_character_inputs = { effect_intensities = { "effect_vita_super_heal_pain_allayed" } },
    native_modifier_order = true,
}
    :value("PAIN_PENALTY_MOD_STR", { multiply_handler = "inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_0_multiply", load_skills = {  } })
    :value("PAIN_PENALTY_MOD_DEX", { multiply_handler = "inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_1_multiply", load_skills = {  } })
    :value("PAIN_PENALTY_MOD_INT", { multiply_handler = "inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_2_multiply", load_skills = {  } })
    :value("PAIN_PENALTY_MOD_PER", { multiply_handler = "inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_3_multiply", load_skills = {  } })
    :value("PAIN_PENALTY_MOD_SPEED", { multiply_handler = "inline_value_inline_ench_effect_vita_super_heal_pain_allayed_0_value_4_multiply", load_skills = {  } }))

-- effects/effects_scenario.json
ccb.runtime.handler("inline_value_inline_ench_effect_scenario_heart_of_fire_need_to_channel_0_value_0_add", function(ctx)
    return ((-5) - (ctx.character_inputs.effect_intensities["effect_scenario_heart_of_fire_need_to_channel"] * 3))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_scenario_heart_of_fire_need_to_channel_0",
    load_character_inputs = { effect_intensities = { "effect_scenario_heart_of_fire_need_to_channel" } },
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_CHILL", { add_handler = "inline_value_inline_ench_effect_scenario_heart_of_fire_need_to_channel_0_value_0_add", load_skills = {  } }))

-- mutations/psi_passives.json
ccb.runtime.handler("inline_value_inline_ench_biokin_needs_0_value_0_multiply", function(ctx)
    return (((-0.03) - (0.00075 * ctx.character_inputs.spell_school_level_sums["BIOKINETIC"])) * ((ctx.character_inputs.effect_intensities["effect_nether_attunement_biokinetic_inversion"] > 0) and (-1) or 1))
end)

ccb.runtime.handler("inline_value_inline_ench_biokin_needs_0_value_1_multiply", function(ctx)
    return (((-0.03) - (0.00075 * ctx.character_inputs.spell_school_level_sums["BIOKINETIC"])) * ((ctx.character_inputs.effect_intensities["effect_nether_attunement_biokinetic_inversion"] > 0) and (-1) or 1))
end)

ccb.runtime.handler("inline_value_inline_ench_biokin_needs_0_value_2_multiply", function(ctx)
    return (((-0.03) - (0.00075 * ctx.character_inputs.spell_school_level_sums["BIOKINETIC"])) * ((ctx.character_inputs.effect_intensities["effect_nether_attunement_biokinetic_inversion"] > 0) and (-1) or 1))
end)

ccb.runtime.handler("inline_value_inline_ench_biokin_needs_0_value_3_multiply", function(ctx)
    return ((0.03 + (0.00075 * ctx.character_inputs.spell_school_level_sums["BIOKINETIC"])) * ((ctx.character_inputs.effect_intensities["effect_nether_attunement_biokinetic_inversion"] > 0) and (-1) or 1))
end)

ccb.runtime.handler("inline_active_inline_ench_biokin_needs_0", function(ctx)
    return not (ctx.character_inputs.character_flags["NO_PSIONICS"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BIOKIN_NEEDS_0",
    condition_handler = "inline_active_inline_ench_biokin_needs_0",
    load_character_inputs = { character_flags = { "NO_PSIONICS" }, effect_intensities = { "effect_nether_attunement_biokinetic_inversion" }, spell_school_level_sums = { "BIOKINETIC" } },
    native_modifier_order = true,
}
    :value("HUNGER", { multiply_handler = "inline_value_inline_ench_biokin_needs_0_value_0_multiply", load_skills = {  } })
    :value("THIRST", { multiply_handler = "inline_value_inline_ench_biokin_needs_0_value_1_multiply", load_skills = {  } })
    :value("METABOLISM", { multiply_handler = "inline_value_inline_ench_biokin_needs_0_value_2_multiply", load_skills = {  } })
    :value("VITAMIN_ABSORB_MOD", { multiply_handler = "inline_value_inline_ench_biokin_needs_0_value_3_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_electro_shield_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.spell_school_level_sums["ELECTROKINETIC"] * (-0.00035))
end)

ccb.runtime.handler("inline_value_inline_ench_electro_shield_0_incoming_damage_0_add", function(ctx)
    return (ctx.character_inputs.spell_school_level_sums["ELECTROKINETIC"] / (-0.2))
end)

ccb.runtime.handler("inline_active_inline_ench_electro_shield_0", function(ctx)
    return not (ctx.character_inputs.character_flags["NO_PSIONICS"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ELECTRO_SHIELD_0",
    condition_handler = "inline_active_inline_ench_electro_shield_0",
    load_character_inputs = { character_flags = { "NO_PSIONICS" }, spell_school_level_sums = { "ELECTROKINETIC" } },
    native_modifier_order = true,
}
    :value("PAIN", { multiply_handler = "inline_value_inline_ench_electro_shield_0_value_0_multiply", load_skills = {  } })
    :incoming_damage("electric", { add_handler = "inline_value_inline_ench_electro_shield_0_incoming_damage_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_pyrokin_adaptation_0_value_0_add", function(ctx)
    return (0.05 * ctx.character_inputs.spell_school_level_sums["PYROKINETIC"])
end)

ccb.runtime.handler("inline_active_inline_ench_pyrokin_adaptation_0", function(ctx)
    return not (ctx.character_inputs.character_flags["NO_PSIONICS"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_PYROKIN_ADAPTATION_0",
    condition_handler = "inline_active_inline_ench_pyrokin_adaptation_0",
    load_character_inputs = { character_flags = { "NO_PSIONICS" }, spell_school_level_sums = { "PYROKINETIC" } },
    native_modifier_order = true,
}
    :value("BODYTEMP_SLEEP", { add_handler = "inline_value_inline_ench_pyrokin_adaptation_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_telekinetic_grab_pockets_0_value_0_multiply", function(ctx)
    return ((-0.1) + (ctx.character_inputs.spell_school_level_sums["TELEKINETIC"] * (-0.00075)))
end)

ccb.runtime.handler("inline_active_inline_ench_telekinetic_grab_pockets_0", function(ctx)
    return not (ctx.character_inputs.character_flags["NO_PSIONICS"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_TELEKINETIC_GRAB_POCKETS_0",
    condition_handler = "inline_active_inline_ench_telekinetic_grab_pockets_0",
    load_character_inputs = { character_flags = { "NO_PSIONICS" }, spell_school_level_sums = { "TELEKINETIC" } },
    native_modifier_order = true,
}
    :value("OBTAIN_COST_MULTIPLIER", { multiply_handler = "inline_value_inline_ench_telekinetic_grab_pockets_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_telepathic_suggestion_0_value_0_add", function(ctx)
    return (5 + (0.075 * ctx.character_inputs.spell_school_level_sums["TELEPATH"]))
end)

ccb.runtime.handler("inline_value_inline_ench_telepathic_suggestion_0_value_1_add", function(ctx)
    return (5 + (0.075 * ctx.character_inputs.spell_school_level_sums["TELEPATH"]))
end)

ccb.runtime.handler("inline_value_inline_ench_telepathic_suggestion_0_value_2_add", function(ctx)
    return (5 + (0.075 * ctx.character_inputs.spell_school_level_sums["TELEPATH"]))
end)

ccb.runtime.handler("inline_active_inline_ench_telepathic_suggestion_0", function(ctx)
    return not (ctx.character_inputs.character_flags["NO_PSIONICS"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_TELEPATHIC_SUGGESTION_0",
    condition_handler = "inline_active_inline_ench_telepathic_suggestion_0",
    load_character_inputs = { character_flags = { "NO_PSIONICS" }, spell_school_level_sums = { "TELEPATH" } },
    native_modifier_order = true,
}
    :value("SOCIAL_INTIMIDATE", { add_handler = "inline_value_inline_ench_telepathic_suggestion_0_value_0_add", load_skills = {  } })
    :value("SOCIAL_LIE", { add_handler = "inline_value_inline_ench_telepathic_suggestion_0_value_1_add", load_skills = {  } })
    :value("SOCIAL_PERSUADE", { add_handler = "inline_value_inline_ench_telepathic_suggestion_0_value_2_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_teleporter_protect_0_value_0_add", function(ctx)
    return (0.01 + (0.00025 * ctx.character_inputs.spell_school_level_sums["TELEPORTER"]))
end)

ccb.runtime.handler("inline_active_inline_ench_teleporter_protect_0", function(ctx)
    return not (ctx.character_inputs.character_flags["NO_PSIONICS"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_TELEPORTER_PROTECT_0",
    condition_handler = "inline_active_inline_ench_teleporter_protect_0",
    load_character_inputs = { character_flags = { "NO_PSIONICS" }, spell_school_level_sums = { "TELEPORTER" } },
    native_modifier_order = true,
}
    :value("EVASION", { add_handler = "inline_value_inline_ench_teleporter_protect_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_vitakinetic_health_0_value_0_multiply", function(ctx)
    return (0.1 + (0.0005 * ctx.character_inputs.spell_school_level_sums["VITAKINETIC"]))
end)

ccb.runtime.handler("inline_active_inline_ench_vitakinetic_health_0", function(ctx)
    return not (ctx.character_inputs.character_flags["NO_PSIONICS"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VITAKINETIC_HEALTH_0",
    condition_handler = "inline_active_inline_ench_vitakinetic_health_0",
    load_character_inputs = { character_flags = { "NO_PSIONICS" }, spell_school_level_sums = { "VITAKINETIC" } },
    native_modifier_order = true,
}
    :value("REGEN_HP", { multiply_handler = "inline_value_inline_ench_vitakinetic_health_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_vitakinetic_health_1_value_0_multiply", function(ctx)
    return (0.05 + (0.0005 * ctx.character_inputs.spell_school_level_sums["VITAKINETIC"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VITAKINETIC_HEALTH_1",
    load_character_inputs = { spell_school_level_sums = { "VITAKINETIC" } },
    native_modifier_order = true,
}
    :value("MAX_HP", { multiply_handler = "inline_value_inline_ench_vitakinetic_health_1_value_0_multiply", load_skills = {  } }))

-- mutations/traits.json
ccb.runtime.handler("inline_value_inline_ench_verdant_hand_protocols_0_melee_damage_0_add", function(ctx)
    return (ctx.skills["unarmed"] / 2)
end)

ccb.runtime.handler("inline_active_inline_ench_verdant_hand_protocols_0", function(ctx)
    return (not (ctx.character_inputs.armed) and
        not (ctx.character_inputs.character_flags["NO_PSIONICS"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VERDANT_HAND_PROTOCOLS_0",
    condition_handler = "inline_active_inline_ench_verdant_hand_protocols_0",
    load_character_inputs = { armed = true, character_flags = { "NO_PSIONICS" } },
    native_modifier_order = true,
}
    :melee_damage("bash", { add_handler = "inline_value_inline_ench_verdant_hand_protocols_0_melee_damage_0_add", load_skills = { "unarmed" } }))

ccb.runtime.handler("inline_value_inline_ench_verdant_hand_protocols_1_melee_damage_0_multiply", function(ctx)
    return (ctx.character_inputs.spell_school_level_sums["BIOKINETIC"] * 0.01)
end)

ccb.runtime.handler("inline_active_inline_ench_verdant_hand_protocols_1", function(ctx)
    return (not (ctx.character_inputs.armed) and
        not (ctx.character_inputs.character_flags["NO_PSIONICS"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VERDANT_HAND_PROTOCOLS_1",
    condition_handler = "inline_active_inline_ench_verdant_hand_protocols_1",
    load_character_inputs = { armed = true, character_flags = { "NO_PSIONICS" }, spell_school_level_sums = { "BIOKINETIC" } },
    native_modifier_order = true,
}
    :melee_damage("bash", { multiply_handler = "inline_value_inline_ench_verdant_hand_protocols_1_melee_damage_0_multiply", load_skills = {  } }))
