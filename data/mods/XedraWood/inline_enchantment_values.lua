local ccb = require("ccb")
local content = ccb.content

-- effects/forest_magic_effects.json
ccb.runtime.handler("inline_value_inline_ench_effect_forest_traverse_the_wilds_0_value_0_multiply", function(ctx)
    return ((ctx.spell_levels["forest_traverse_the_wilds"] * (-0.015)) - 0.05)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_forest_traverse_the_wilds_0",
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "inline_value_inline_ench_effect_forest_traverse_the_wilds_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "forest_traverse_the_wilds" } }))

-- player/traits.json
ccb.runtime.handler("inline_value_inline_ench_tattoos_basic_trait_3_value_0_add", function(ctx)
    return (100000000 + (50000000 * ((ctx.character_inputs.character_variables["flames_tattoo_count"] + ctx.character_inputs.character_variables["mountain_tattoo_count"]) + ctx.character_inputs.character_variables["forest_tattoo_count"])))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_TATTOOS_BASIC_TRAIT_3", condition = "ALWAYS",
    load_character_inputs = { character_variables = { "flames_tattoo_count", "forest_tattoo_count", "mountain_tattoo_count" } },
    native_modifier_order = true,
}
    :value("BIONIC_POWER", { add_handler = "inline_value_inline_ench_tattoos_basic_trait_3_value_0_add", load_skills = {  } }))

ccb.runtime.handler("inline_value_inline_ench_xedrawood_the_wise_0_value_0_add", function(ctx)
    return ((ctx.character_inputs.spell_school_counts["FOREST_MAGIC"] * 72) + (ctx.skills["deduction"] * 145))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_XEDRAWOOD_THE_WISE_0", condition = "ALWAYS",
    load_character_inputs = { spell_school_counts = { "FOREST_MAGIC" } },
    native_modifier_order = true,
}
    :value("MAX_MANA", { add_handler = "inline_value_inline_ench_xedrawood_the_wise_0_value_0_add", load_skills = { "deduction" } }))
