local ccb = require("ccb")
local content = ccb.content

-- mutations/nonhuman_species.json
ccb.runtime.handler("thermal_overlay_enchantment_inline_ench_coldblood4_liz_0_value_1_add", function(ctx)
    return ccb.runtime.call_number("cold_blood_speed_adjustment", ctx.character_inputs.environment.temperature_fahrenheit, 65, ctx.character_inputs.climate_heat, 0.5)
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_COLDBLOOD4_LIZ_0",
    load_character_inputs = { climate_heat = true, environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("METABOLISM", { multiply = 0.5 })
    :value("SPEED", {
        add_handler = "thermal_overlay_enchantment_inline_ench_coldblood4_liz_0_value_1_add",
        load_skills = {}
    }))
