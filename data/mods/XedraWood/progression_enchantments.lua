local ccb = require("ccb")
local content = ccb.content

-- effects/forest_magic_effects.json
ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_forest_traverse_the_wilds_1", function(ctx)
    return (ctx.character_inputs.spell_levels["effect_forest_traverse_the_wilds"] > 7)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_forest_traverse_the_wilds_1",
    condition_handler = "progression_enchantment_active_inline_ench_effect_forest_traverse_the_wilds_1",
    load_character_inputs = { spell_levels = { "effect_forest_traverse_the_wilds" } },
    native_modifier_order = true,
}
    :value("PHASE_DISTANCE", { add = 2 }))
