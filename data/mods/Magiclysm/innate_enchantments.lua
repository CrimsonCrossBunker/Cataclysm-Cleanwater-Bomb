local ccb = require("ccb")
local content = ccb.content

-- effects/effects.json
ccb.runtime.handler("innate_enchantment_inline_ench_effect_manatouched_external_mana_luminance_0_value_0_add", function(ctx)
    return math.min((ctx.character_inputs.category_counts["MANATOUCHED"] * 3), 50)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_manatouched_external_mana_luminance_0",
    load_character_inputs = { category_counts = { "MANATOUCHED" } },
    native_modifier_order = true,
}
    :value("LUMINATION", {
        add_handler = "innate_enchantment_inline_ench_effect_manatouched_external_mana_luminance_0_value_0_add",
        load_skills = {}
    }))

-- mutations/mutation_paths/black_dragon.json
ccb.runtime.handler("innate_enchantment_inline_ench_dragonblood_0_value_0_add", function(ctx)
    return ccb.runtime.call_number("cold_blood_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 0.2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRAGONBLOOD_0",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("SPEED", {
        add_handler = "innate_enchantment_inline_ench_dragonblood_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_dragonblood2_0_value_1_add", function(ctx)
    return ccb.runtime.call_number("cold_blood_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 0.333)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRAGONBLOOD2_0",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("METABOLISM", { multiply = 0.25 })
    :value("SPEED", {
        add_handler = "innate_enchantment_inline_ench_dragonblood2_0_value_1_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_dragonblood3_0_value_1_add", function(ctx)
    return ccb.runtime.call_number("cold_blood_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 0.5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DRAGONBLOOD3_0",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("METABOLISM", { multiply = 0.5 })
    :value("SPEED", {
        add_handler = "innate_enchantment_inline_ench_dragonblood3_0_value_1_add",
        load_skills = {}
    }))

-- mutations/mutation_paths/fantasy_species.json
ccb.runtime.handler("innate_enchantment_active_inline_ench_elven_sight_1", function(ctx)
    return (ctx.character_inputs.environment.outside and
        not (ctx.character_inputs.environment.weather == "clear") and
        not (ctx.character_inputs.environment.weather == "sunny") and
        ((ctx.character_inputs.environment.moon_phase >= 2) and
        (ctx.character_inputs.environment.moon_phase < 7)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ELVEN_SIGHT_1",
    condition_handler = "innate_enchantment_active_inline_ench_elven_sight_1",
    load_character_inputs = { environment = { moon_phase = true, outside = true, weather = true } },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add = 10 })
    :value("OVERMAP_SIGHT", { add = 2 }))

ccb.runtime.handler("innate_enchantment_active_inline_ench_elven_sight_2", function(ctx)
    return (ctx.character_inputs.environment.outside and
        not (ctx.character_inputs.environment.weather == "clear") and
        not (ctx.character_inputs.environment.weather == "sunny") and
        ((ctx.character_inputs.environment.moon_phase <= 1) or
        (ctx.character_inputs.environment.moon_phase == 7)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ELVEN_SIGHT_2",
    condition_handler = "innate_enchantment_active_inline_ench_elven_sight_2",
    load_character_inputs = { environment = { moon_phase = true, outside = true, weather = true } },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add = 2 }))
