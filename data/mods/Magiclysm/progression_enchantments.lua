local ccb = require("ccb")
local content = ccb.content

-- effects/effects.json
ccb.runtime.handler("progression_enchantment_inline_ench_dark_sight_0_value_0_add", function(ctx)
    return (ctx.character_inputs.spell_levels["dark_sight"] + 3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_dark_sight_0",
    load_character_inputs = { spell_levels = { "dark_sight" } },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", {
        add_handler = "progression_enchantment_inline_ench_dark_sight_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("progression_enchantment_inline_ench_dark_sight_1_value_0_add", function(ctx)
    return (ctx.character_inputs.spell_levels["dark_sight"] / 4)
end)

ccb.runtime.handler("progression_enchantment_active_inline_ench_dark_sight_1", function(ctx)
    return (not (ctx.character_inputs.environment.daylight) and
        (ctx.character_inputs.spell_levels["dark_sight"] >= 4))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_dark_sight_1",
    condition_handler = "progression_enchantment_active_inline_ench_dark_sight_1",
    load_character_inputs = { environment = { daylight = true }, spell_levels = { "dark_sight" } },
    native_modifier_order = true,
}
    :value("OVERMAP_SIGHT", {
        add_handler = "progression_enchantment_inline_ench_dark_sight_1_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_druid_traverse_the_wilds_1", function(ctx)
    return (ctx.character_inputs.spell_levels["druid_traverse_the_wilds"] > 7)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_druid_traverse_the_wilds_1",
    condition_handler = "progression_enchantment_active_inline_ench_effect_druid_traverse_the_wilds_1",
    load_character_inputs = { spell_levels = { "druid_traverse_the_wilds" } },
    native_modifier_order = true,
}
    :value("PHASE_DISTANCE", { add = 2 }))
