local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_xe_abyssal_coffee",
    name = ccb.content.text("A W A K E"),
    description = ccb.content.text("Wow, that coffee was strong."),
    rating = "good",
    duration_add_percent = 10,
}
    :flag("CANNOT_SLEEP")
    :flag("CANNOT_GAIN_WEARINESS")
    :enchantment("INLINE_ENCH_effect_xe_abyssal_coffee_0")
    :modifier("sleepiness", "minimum", { base = -1 })
    :modifier("sleepiness", "minimum_value", {  })
    :modifier("sleepiness", "tick", { base = 300 })
    :modifier("sleepiness", "chance_numerator", { base = 4 })
    :modifier("heart_rate", "tick", { base = 120 })
    :modifier("heart_rate", "minimum", { base = 2 })
    :modifier("heart_rate", "chance_numerator", { base = 5 })
    :modifier("heart_rate", "maximum_value", { base = 150 }))
