local ccb = require("ccb")
local content = ccb.content

local function clamp(value, minimum, maximum)
    return math.min(math.max(value, minimum), maximum)
end

-- data/json/effects.json
ccb.runtime.handler("world_enchantment_inline_ench_strengthened_gravity_0_value_0_add", function(ctx)
    return ctx.character_inputs.global_variables["portal_dungeon_carry_strength"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_strengthened_gravity_0",
    load_character_inputs = {
        global_variable_defaults = { portal_dungeon_carry_strength = -1 },
        global_variables = { "portal_dungeon_carry_strength" }
    },
    native_modifier_order = true,
}
    :value("CARRY_WEIGHT", {
        add_handler = "world_enchantment_inline_ench_strengthened_gravity_0_value_0_add",
        load_skills = {}
    }))

ccb.runtime.handler("world_enchantment_inline_ench_slowed_time_0_value_0_add", function(ctx)
    return ctx.character_inputs.global_variables["portal_dungeon_slow_strength"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_slowed_time_0",
    load_character_inputs = {
        global_variable_defaults = { portal_dungeon_slow_strength = -1 },
        global_variables = { "portal_dungeon_slow_strength" }
    },
    native_modifier_order = true,
}
    :value("SPEED", {
        add_handler = "world_enchantment_inline_ench_slowed_time_0_value_0_add",
        load_skills = {}
    }))

-- data/json/effects_on_condition/medicine_eocs/regen_serum_eoc.json
ccb.runtime.handler("world_enchantment_inline_ench_regen_serum_crash_cardio_0_value_0_multiply", function(ctx)
    local calories = ctx.character_inputs.calorie_history
    local ratio = math.max(calories.spent_yesterday, 1) / math.max(calories.ingested_yesterday, 1)
    return (-1 / clamp(ratio, 0, 0.6)) / 5
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_regen_serum_crash_cardio_0",
    load_character_inputs = {
        calorie_history = {
            ingested_yesterday = { day = 1, kind = "ingested" },
            spent_yesterday = { day = 1, kind = "spent" }
        }
    },
    native_modifier_order = true,
}
    :value("CARDIO_MULTIPLIER", {
        multiply_handler = "world_enchantment_inline_ench_regen_serum_crash_cardio_0_value_0_multiply",
        load_skills = {}
    })
    :value("STRENGTH", {
        multiply_handler = "world_enchantment_inline_ench_regen_serum_crash_cardio_0_value_0_multiply",
        load_skills = {}
    }))
