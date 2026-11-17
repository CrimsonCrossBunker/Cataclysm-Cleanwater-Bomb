local ccb = require("ccb")
local content = ccb.content
local random = ccb.services.random

ccb.runtime.handler("martial_enchantment_unarmed", function(ctx)
    return not ctx.character_inputs.armed
end)
ccb.runtime.handler("martial_enchantment_armed", function(ctx)
    return ctx.character_inputs.armed
end)

ccb.runtime.handler("drunken_unarmed_bash", function(ctx)
    local drunk = ctx.character_inputs.effect_intensities.drunk
    return random.native_float(drunk * 1.8, drunk * 4)
end)
ccb.runtime.handler("drunken_armed_bash", function(ctx)
    local drunk = ctx.character_inputs.effect_intensities.drunk
    return random.native_float(drunk * 1.2, drunk * 2.6)
end)
ccb.runtime.handler("ki_strike_bash", function(ctx)
    return ctx.skills.unarmed * 2
end)

-- These techniques can also be supplied by Xedra Evolved.
local drunken_inputs = { armed = true, effect_intensities = { "drunk" } }
content.upsert_enchantment(content.Enchantment {
    id = "DRUNKEN_UNARMED",
    condition_handler = "martial_enchantment_unarmed",
    load_character_inputs = drunken_inputs,
}:melee_damage("bash", { add_handler = "drunken_unarmed_bash" }))

content.upsert_enchantment(content.Enchantment {
    id = "DRUNKEN_ARMED",
    condition_handler = "martial_enchantment_armed",
    load_character_inputs = drunken_inputs,
}:melee_damage("bash", { add_handler = "drunken_armed_bash" }))

content.upsert_enchantment(content.Enchantment {
    id = "KI_STRIKE",
    condition_handler = "martial_enchantment_unarmed",
    load_character_inputs = { armed = true },
}:melee_damage("bash", { add_handler = "ki_strike_bash", load_skills = { "unarmed" } }))
