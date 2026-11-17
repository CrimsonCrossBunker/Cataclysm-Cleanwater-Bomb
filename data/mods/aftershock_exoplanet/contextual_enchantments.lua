local ccb = require("ccb")
local content = ccb.content

-- effects_esper.json
ccb.runtime.handler("contextual_enchantment_inline_ench_effect_afs_precog_ranged_enhance_1_value_0_multiply", function(ctx)
    return math.min((((ctx.character_inputs.spell_levels["afs_precog_ranged_enhance"] * 0.08) + 0.1) * ccb.runtime.call_number("attribute_scaling", ctx.character_inputs.stats.intelligence)), 9)
end)

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_afs_precog_ranged_enhance_1", function(ctx)
    return (ctx.character_inputs.wielded_skills["pistol"] or
        ctx.character_inputs.wielded_skills["rifle"] or
        ctx.character_inputs.wielded_skills["gun"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_precog_ranged_enhance_1",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_afs_precog_ranged_enhance_1",
    load_character_inputs = {
        spell_levels = { "afs_precog_ranged_enhance" },
        stats = true,
        wielded_skills = { "gun", "pistol", "rifle" }
    },
    native_modifier_order = true,
}
    :value("WEAKPOINT_ACCURACY", {
        multiply_handler = "contextual_enchantment_inline_ench_effect_afs_precog_ranged_enhance_1_value_0_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("contextual_enchantment_inline_ench_effect_afs_precog_melee_enhance_1_value_0_multiply", function(ctx)
    return math.min((((ctx.character_inputs.spell_levels["afs_precog_ranged_enhance"] * 0.08) + 0.1) * ccb.runtime.call_number("attribute_scaling", ctx.character_inputs.stats.intelligence)), 9)
end)

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_afs_precog_melee_enhance_1", function(ctx)
    return (ctx.character_inputs.wielded_skills["melee"] or
        ctx.character_inputs.wielded_skills["bashing"] or
        ctx.character_inputs.wielded_skills["stabbing"] or
        ctx.character_inputs.wielded_skills["cutting"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_afs_precog_melee_enhance_1",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_afs_precog_melee_enhance_1",
    load_character_inputs = {
        spell_levels = { "afs_precog_ranged_enhance" },
        stats = true,
        wielded_skills = { "bashing", "cutting", "melee", "stabbing" }
    },
    native_modifier_order = true,
}
    :value("WEAKPOINT_ACCURACY", {
        multiply_handler = "contextual_enchantment_inline_ench_effect_afs_precog_melee_enhance_1_value_0_multiply",
        load_skills = {}
    }))
