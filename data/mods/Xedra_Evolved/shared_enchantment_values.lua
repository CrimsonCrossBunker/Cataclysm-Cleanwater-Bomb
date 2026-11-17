local ccb = require("ccb")
local content = ccb.content

-- effects/effects.json
ccb.runtime.handler("shared_enchantment_inline_ench_effect_homullus_add_learning_focus_0_value_0_add", function(ctx)
    return (((ctx.spell_levels["homullus_add_learning_focus_spell"] * 1.5) + 5) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_homullus_add_learning_focus_0",
    native_modifier_order = true,
}
    :value("LEARNING_FOCUS", { add_handler = "shared_enchantment_inline_ench_effect_homullus_add_learning_focus_0_value_0_add", load_skills = {  }, load_spell_levels = { "homullus_add_learning_focus_spell" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_salamander_increase_speed_0_value_0_add", function(ctx)
    return ((5 + (ctx.spell_levels["salamander_increase_speed_spell"] * 1.5)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.strength))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_salamander_increase_speed_0",
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "shared_enchantment_inline_ench_effect_salamander_increase_speed_0_value_0_add", load_skills = {  }, load_spell_levels = { "salamander_increase_speed_spell" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_sylph_bonus_melee_range_0_value_0_add", function(ctx)
    return (((ctx.spell_levels["sylph_bonus_melee_range_spell"] * 0.25) + 1) * ccb.runtime.call_number("attribute_scaling", ctx.stats.dexterity))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_sylph_bonus_melee_range_0",
    native_modifier_order = true,
}
    :value("MELEE_RANGE_MODIFIER", { add_handler = "shared_enchantment_inline_ench_effect_sylph_bonus_melee_range_0_value_0_add", load_skills = {  }, load_spell_levels = { "sylph_bonus_melee_range_spell" } }))
