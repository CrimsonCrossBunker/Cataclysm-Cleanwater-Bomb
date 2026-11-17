local ccb = require("ccb")
local content = ccb.content

-- data/json/mutations/mutations.json
ccb.runtime.handler("innate_enchantment_inline_ench_coldblood_0_value_1_add", function(ctx)
    return ccb.runtime.call_number("cold_blood_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 0.2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_COLDBLOOD_0",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("METABOLISM", { multiply = -0.333 })
    :value("SPEED", {
        add_handler = "innate_enchantment_inline_ench_coldblood_0_value_1_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_coldblood2_0_value_1_add", function(ctx)
    return ccb.runtime.call_number("cold_blood_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 0.333)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_COLDBLOOD2_0",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("METABOLISM", { multiply = -0.5 })
    :value("SPEED", {
        add_handler = "innate_enchantment_inline_ench_coldblood2_0_value_1_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_coldblood3_0_value_1_add", function(ctx)
    return ccb.runtime.call_number("cold_blood_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 0.5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_COLDBLOOD3_0",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("METABOLISM", { multiply = -0.5 })
    :value("SPEED", {
        add_handler = "innate_enchantment_inline_ench_coldblood3_0_value_1_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_coldblood4_0_value_1_add", function(ctx)
    return ccb.runtime.call_number("thermal_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 0.5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_COLDBLOOD4_0",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("METABOLISM", { multiply = -0.5 })
    :value("SPEED", {
        add_handler = "innate_enchantment_inline_ench_coldblood4_0_value_1_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_str_alpha_0_value_0_add", function(ctx)
    return ccb.runtime.call_number("alpha_attribute_bonus", ctx.character_inputs.base_stats.strength)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_STR_ALPHA_0",
    load_character_inputs = { base_stats = true },
    native_modifier_order = true,
}
    :value("STRENGTH", {
        add_handler = "innate_enchantment_inline_ench_str_alpha_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_dex_alpha_0_value_0_add", function(ctx)
    return ccb.runtime.call_number("alpha_attribute_bonus", ctx.character_inputs.base_stats.dexterity)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DEX_ALPHA_0",
    load_character_inputs = { base_stats = true },
    native_modifier_order = true,
}
    :value("DEXTERITY", {
        add_handler = "innate_enchantment_inline_ench_dex_alpha_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_int_alpha_0_value_0_add", function(ctx)
    return ccb.runtime.call_number("alpha_attribute_bonus", ctx.character_inputs.base_stats.intelligence)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_INT_ALPHA_0",
    load_character_inputs = { base_stats = true },
    native_modifier_order = true,
}
    :value("INTELLIGENCE", {
        add_handler = "innate_enchantment_inline_ench_int_alpha_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("innate_enchantment_inline_ench_per_alpha_0_value_0_add", function(ctx)
    return ccb.runtime.call_number("alpha_attribute_bonus", ctx.character_inputs.base_stats.perception)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_PER_ALPHA_0",
    load_character_inputs = { base_stats = true },
    native_modifier_order = true,
}
    :value("PERCEPTION", {
        add_handler = "innate_enchantment_inline_ench_per_alpha_0_value_0_add",
        load_skills = {}
    }))
