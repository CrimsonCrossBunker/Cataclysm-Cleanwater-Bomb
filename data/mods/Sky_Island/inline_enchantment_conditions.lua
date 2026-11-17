local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("inline_enchantment_not_traits_awayfromhome", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.traits["awayfromhome"])
end)

-- mutations.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_mut_skyisland_sunblock_0",
    condition_handler = "inline_enchantment_not_traits_awayfromhome",
    load_character_inputs = { traits = { "awayfromhome" } },
}
    :mutation("mut_skyisland_sunblock_real"))

content.add(content.Enchantment {
    id = "INLINE_ENCH_mut_skyisland_windblock_0",
    condition_handler = "inline_enchantment_not_traits_awayfromhome",
    load_character_inputs = { traits = { "awayfromhome" } },
}
    :mutation("mut_skyisland_windblock_real"))

content.add(content.Enchantment {
    id = "INLINE_ENCH_mut_skyisland_personal_temperature_adaptation_0",
    condition_handler = "inline_enchantment_not_traits_awayfromhome",
    load_character_inputs = { traits = { "awayfromhome" } },
}
    :value("CLIMATE_CONTROL_HEAT", { add = 999 })
    :value("CLIMATE_CONTROL_CHILL", { add = 999 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_mut_skyisland_radblock_0",
    condition_handler = "inline_enchantment_not_traits_awayfromhome",
    load_character_inputs = { traits = { "awayfromhome" } },
}
    :effect("effect_island_radblock", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_mut_skyisland_island_steady_0",
    condition_handler = "inline_enchantment_not_traits_awayfromhome",
    load_character_inputs = { traits = { "awayfromhome" } },
}
    :effect("effect_island_steady", 1))
