local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("inline_enchantment_effects_asleep", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["asleep"]
end)

ccb.runtime.handler("inline_enchantment_effects_effect_pattern_tattoo_meditation", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["effect_pattern_tattoo_meditation"]
end)

-- player/traits.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_TATTOOS_BASIC_TRAIT_1",
    condition_handler = "inline_enchantment_effects_asleep",
    load_character_inputs = { effects = { "asleep" } },
}
    :value("POWER_TRICKLE", { add = 1000 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_TATTOOS_BASIC_TRAIT_2",
    condition_handler = "inline_enchantment_effects_effect_pattern_tattoo_meditation",
    load_character_inputs = { effects = { "effect_pattern_tattoo_meditation" } },
}
    :value("POWER_TRICKLE", { add = 3500 }))
