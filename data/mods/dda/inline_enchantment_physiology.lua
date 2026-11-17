local ccb = require("ccb")
local content = ccb.content

-- data/json/effects.json
ccb.runtime.handler("inline_physiology_inline_ench_triffid_fiber_indigestion_0_value_0_multiply", function(ctx)
    return (ctx.character_inputs.vitamins["triffid_fiber"] / (-275))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_triffid_fiber_indigestion_0",
    load_character_inputs = { vitamins = { "triffid_fiber" } },
    native_modifier_order = true,
}
    :value("STOMACH_SIZE_MULTIPLIER", { multiply_handler = "inline_physiology_inline_ench_triffid_fiber_indigestion_0_value_0_multiply", load_skills = {  } }))
