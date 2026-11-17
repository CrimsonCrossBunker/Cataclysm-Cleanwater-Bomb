local ccb = require("ccb")
local content = ccb.content

-- food/effect.json
ccb.runtime.handler("inline_value_inline_ench_cd_delight_strength_enhancement_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["cd_delight_strength_enhancement"] * 0.1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_cd_delight_strength_enhancement_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "cd_delight_strength_enhancement" } },
    native_modifier_order = true,
}
    :value("STRENGTH", { multiply_handler = "inline_value_inline_ench_cd_delight_strength_enhancement_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_cd_delight_dexterity_enhancement_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["cd_delight_dexterity_enhancement"] * 0.1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_cd_delight_dexterity_enhancement_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "cd_delight_dexterity_enhancement" } },
    native_modifier_order = true,
}
    :value("DEXTERITY", { multiply_handler = "inline_value_inline_ench_cd_delight_dexterity_enhancement_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_cd_delight_perception_enhancement_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["cd_delight_perception_enhancement"] * 0.1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_cd_delight_perception_enhancement_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "cd_delight_perception_enhancement" } },
    native_modifier_order = true,
}
    :value("PERCEPTION", { multiply_handler = "inline_value_inline_ench_cd_delight_perception_enhancement_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_cd_delight_intelligence_enhancement_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["cd_delight_intelligence_enhancement"] * 0.1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_cd_delight_intelligence_enhancement_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "cd_delight_intelligence_enhancement" } },
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { multiply_handler = "inline_value_inline_ench_cd_delight_intelligence_enhancement_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_cd_delight_focus_regen_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["cd_delight_focus_regen"] * 0.1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_cd_delight_focus_regen_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "cd_delight_focus_regen" } },
    native_modifier_order = true,
}
    :value("FOCUS_REGEN", { multiply_handler = "inline_value_inline_ench_cd_delight_focus_regen_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_cd_delight_satiety_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["cd_delight_satiety"] * 0.1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_cd_delight_satiety_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "cd_delight_satiety" } },
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", { multiply_handler = "inline_value_inline_ench_cd_delight_satiety_0_value_0_multiply", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_cd_delight_nourishment_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.effect_intensities["cd_delight_nourishment"] * 0.1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_cd_delight_nourishment_0", condition = "ALWAYS",
    load_character_inputs = { effect_intensities = { "cd_delight_nourishment" } },
    native_modifier_order = true,
}
    :value("REGEN_HP", { multiply_handler = "inline_value_inline_ench_cd_delight_nourishment_0_value_0_multiply", load_skills = {  } }))
