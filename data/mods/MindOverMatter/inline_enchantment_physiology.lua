local ccb = require("ccb")
local content = ccb.content

-- effects/effects_penalty.json
ccb.runtime.handler("inline_physiology_inline_ench_effect_biokin_overload_0_value_0_multiply", function(ctx)
    return ((-0.15) - (ctx.character_inputs.vitamins["vitamin_psionic_drain"] * (-0.01)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_overload_0",
    load_character_inputs = { vitamins = { "vitamin_psionic_drain" } },
    native_modifier_order = true,
}
    :value("MELEE_STAMINA_CONSUMPTION", { multiply_handler = "inline_physiology_inline_ench_effect_biokin_overload_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_inline_ench_effect_electrokin_overload_0_value_0_add", function(ctx)
    return ((-0.1) * ctx.character_inputs.vitamins["vitamin_psionic_drain"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_electrokin_overload_0",
    load_character_inputs = { vitamins = { "vitamin_psionic_drain" } },
    native_modifier_order = true,
}
    :value("SLEEPY", { add_handler = "inline_physiology_inline_ench_effect_electrokin_overload_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_inline_ench_effect_photokin_lumination_overload_0_value_0_add", function(ctx)
    return (50 + ctx.character_inputs.vitamins["vitamin_psionic_drain"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_photokin_lumination_overload_0",
    load_character_inputs = { vitamins = { "vitamin_psionic_drain" } },
    native_modifier_order = true,
}
    :value("LUMINATION", { add_handler = "inline_physiology_inline_ench_effect_photokin_lumination_overload_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_inline_ench_effect_pyrokin_overload_0_value_0_add", function(ctx)
    return ((-15) - (ctx.character_inputs.vitamins["vitamin_psionic_drain"] / 10))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokin_overload_0",
    load_character_inputs = { vitamins = { "vitamin_psionic_drain" } },
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_CHILL", { add_handler = "inline_physiology_inline_ench_effect_pyrokin_overload_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_physiology_inline_ench_effect_vitakin_overload_0_value_0_multiply", function(ctx)
    return ((-0.125) - (ctx.character_inputs.vitamins["vitamin_psionic_drain"] * (-0.0035)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vitakin_overload_0",
    load_character_inputs = { vitamins = { "vitamin_psionic_drain" } },
    native_modifier_order = true,
}
    :value("REGEN_HP", { multiply_handler = "inline_physiology_inline_ench_effect_vitakin_overload_0_value_0_multiply", load_skills = {  } }))

-- effects/effects_psionic.json
ccb.runtime.handler("inline_physiology_active_inline_ench_effect_biokin_physical_1", function(ctx)
    return (ctx.character_inputs.stats.strength >= 25)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_physical_1",
    condition_handler = "inline_physiology_active_inline_ench_effect_biokin_physical_1",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :effect("effect_psi_blocking_huge_attacks", 1))

ccb.runtime.handler("inline_physiology_active_inline_ench_effect_biokin_combat_dance_9", function(ctx)
    return (ctx.character_inputs.stats.strength >= 20)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_9",
    condition_handler = "inline_physiology_active_inline_ench_effect_biokin_combat_dance_9",
    load_character_inputs = { stats = true },
    native_modifier_order = true,
}
    :effect("effect_psi_blocking_huge_attacks", 1))
