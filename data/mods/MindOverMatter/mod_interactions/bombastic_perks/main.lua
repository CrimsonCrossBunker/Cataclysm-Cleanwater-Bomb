local ccb = require("ccb")
local content = ccb.content

-- mod_interactions/bombastic_perks/perks.json
ccb.runtime.handler("interaction_enchantment_active_inline_ench_perk_efficient_slumber_0", function(ctx)
    return not (ctx.character_inputs.effects["effect_biokin_metabolism_enhance"])
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_efficient_slumber_0",
    condition_handler = "interaction_enchantment_active_inline_ench_perk_efficient_slumber_0",
    load_character_inputs = { effects = { "effect_biokin_metabolism_enhance" } },
    native_modifier_order = true,
}
    :value("SLEEPINESS_REGEN", { multiply = 0.2 })
    :value("SLEEPINESS", { multiply = -0.2 }))

ccb.runtime.handler("interaction_enchantment_active_inline_ench_perk_grace_under_pain_0", function(ctx)
    return not ((ctx.character_inputs.effects["effect_biokin_overcome_pain"] or ctx.character_inputs.effects["effect_electrokin_reduce_pain"] or ctx.character_inputs.effects["effect_telepathic_morale"]))
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_grace_under_pain_0",
    condition_handler = "interaction_enchantment_active_inline_ench_perk_grace_under_pain_0",
    load_character_inputs = {
        effects = { "effect_biokin_overcome_pain", "effect_electrokin_reduce_pain", "effect_telepathic_morale" }
    },
    native_modifier_order = true,
}
    :value("PAIN_PENALTY_MOD_INT", { multiply = -0.33 }))

ccb.runtime.handler("interaction_enchantment_active_inline_ench_perk_grace_under_pain_1", function(ctx)
    return (ctx.character_inputs.effects["effect_biokin_overcome_pain"] or ctx.character_inputs.effects["effect_electrokin_reduce_pain"] or ctx.character_inputs.effects["effect_telepathic_morale"])
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_grace_under_pain_1",
    condition_handler = "interaction_enchantment_active_inline_ench_perk_grace_under_pain_1",
    load_character_inputs = {
        effects = { "effect_biokin_overcome_pain", "effect_electrokin_reduce_pain", "effect_telepathic_morale" }
    },
    native_modifier_order = true,
}
    :value("PAIN_PENALTY_MOD_INT", { multiply = -0.66 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_mastery_of_form_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("MUT_INSTABILITY_MOD", { add = -2 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_perk_wary_sleeper_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("MOTION_ALARM", { add = 10 }))
