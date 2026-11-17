local ccb = require("ccb")

ccb.runtime.handler("blood_potency_active", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.active_traits.VAMPIRE_BLOOD_FOR_POTENCY
        and inputs.vitamins.human_blood_vitamin >= -500
end)

ccb.content.add(ccb.content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_BLOOD_FOR_POTENCY_0",
    condition_handler = "blood_potency_active",
    load_character_inputs = {
        active_traits = { "VAMPIRE_BLOOD_FOR_POTENCY" },
        vitamins = { "human_blood_vitamin" },
    },
    native_modifier_order = true,
}
    :mutation("VAMPIRE_BLOOD_FOR_POTENCY_REAL"))
