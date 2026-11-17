local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_iso_pain_adjust_value_pain_multiply", function(ctx)
    return ctx.character_inputs.pain > 40 and -1 or -0.4
end)

content.add(content.Enchantment {
    id = "iso_pain_adjust",
    condition = "ALWAYS",
    load_character_inputs = { pain = true },
}
    :value("PAIN", { multiply_handler = "enchantment_iso_pain_adjust_value_pain_multiply" }))

local safe_areas = { iso_elevator_safe = true, iso_hallway_safe = true, iso_next_level_elevator = true }
ccb.runtime.handler("isolation_assassins_drive_active", function(ctx)
    return not safe_areas[ctx.character_inputs.environment.overmap_terrain]
end)

content.add(content.Enchantment {
    id = "iso_bionic_vampire_buff",
    name = content.text("Assassin's Drive"),
    description = content.text("Hey man, it's just business."),
    condition_handler = "isolation_assassins_drive_active",
    load_character_inputs = { environment = { overmap_terrain = true } },
}:value("POWER_TRICKLE", { add = -5000 }))
