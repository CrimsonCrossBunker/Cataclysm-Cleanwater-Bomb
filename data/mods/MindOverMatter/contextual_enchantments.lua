local ccb = require("ccb")
local content = ccb.content

local psychic_scaling = require("psychic_enchantment_scaling")
local power_modifier = psychic_scaling.power

-- effects/effects_psionic.json
ccb.runtime.handler("contextual_enchantment_inline_ench_effect_clair_ranged_enhance_1_value_0_multiply", function(ctx)
    return math.min((((ctx.character_inputs.spell_levels["clair_ranged_enhance"] * 0.08) + 0.1) * power_modifier(ctx)), 9)
end)

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_clair_ranged_enhance_1", function(ctx)
    return (ctx.character_inputs.wielded_skills["pistol"] or
        ctx.character_inputs.wielded_skills["rifle"] or
        ctx.character_inputs.wielded_skills["gun"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_ranged_enhance_1",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_clair_ranged_enhance_1",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "clair_ranged_enhance" },
        stats = true,
        wielded_skills = { "gun", "pistol", "rifle" }
    },
    native_modifier_order = true,
}
    :value("WEAKPOINT_ACCURACY", {
        multiply_handler = "contextual_enchantment_inline_ench_effect_clair_ranged_enhance_1_value_0_multiply",
        load_skills = {}
    }))
