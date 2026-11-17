local ccb = require("ccb")
local content = ccb.content

-- effects/effects_changeling_seasonal_magic.json
ccb.runtime.handler("contextual_enchantment_inline_ench_effect_changeling_spring_healing_increase_while_outside_0_value_1_multiply", function(ctx)
    return (((10 + ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SPRING"]) + (ctx.character_inputs.skills["gramarye"] * 2)) * ((ctx.character_inputs.global_variables["global_what_is_the_season"] == 3) and 0.5 or 1))
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_effect_changeling_spring_healing_increase_while_outside_0_value_2_multiply", function(ctx)
    return (((3 + (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SPRING"] / 3)) + ctx.character_inputs.skills["gramarye"]) * ((ctx.character_inputs.global_variables["global_what_is_the_season"] == 3) and 0.5 or 1))
end)

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_changeling_spring_healing_increase_while_outside_0", function(ctx)
    return (ctx.character_inputs.environment.outside and
        ctx.character_inputs.identity.avatar)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_spring_healing_increase_while_outside_0",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_changeling_spring_healing_increase_while_outside_0",
    load_character_inputs = {
        environment = { outside = true },
        global_variables = { "global_what_is_the_season" },
        identity = true,
        skills = { "gramarye" },
        spell_school_counts = { "CHANGELING_SEASONAL_MAGIC_SPRING" }
    },
    native_modifier_order = true,
}
    :value("REGEN_HP_AWAKE", { multiply = 1 })
    :value("REGEN_HP", {
        multiply_handler = "contextual_enchantment_inline_ench_effect_changeling_spring_healing_increase_while_outside_0_value_1_multiply",
        load_skills = {}
    })
    :value("MENDING_MODIFIER", {
        multiply_handler = "contextual_enchantment_inline_ench_effect_changeling_spring_healing_increase_while_outside_0_value_2_multiply",
        load_skills = {}
    })
    :effect("effect_xe_hidden_infection_recovery", 1))

ccb.runtime.handler("contextual_enchantment_inline_ench_effect_changeling_spring_healing_increase_while_outside_1_value_1_multiply", function(ctx)
    return (((10 + ctx.character_inputs.character_variables["spring_magic_spell_count"]) + (ctx.character_inputs.character_variables["spring_magic_deduction_level"] * 2)) * ((ctx.character_inputs.global_variables["global_what_is_the_season"] == 3) and 0.5 or 1))
end)

ccb.runtime.handler("contextual_enchantment_inline_ench_effect_changeling_spring_healing_increase_while_outside_1_value_2_multiply", function(ctx)
    return (((3 + (ctx.character_inputs.character_variables["spring_magic_spell_count"] / 3)) + ctx.character_inputs.character_variables["spring_magic_deduction_level"]) * ((ctx.character_inputs.global_variables["global_what_is_the_season"] == 3) and 0.5 or 1))
end)

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_changeling_spring_healing_increase_while_outside_1", function(ctx)
    return (ctx.character_inputs.environment.outside and
        ctx.character_inputs.identity.npc)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_spring_healing_increase_while_outside_1",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_changeling_spring_healing_increase_while_outside_1",
    load_character_inputs = {
        character_variables = { "spring_magic_deduction_level", "spring_magic_spell_count" },
        environment = { outside = true },
        global_variables = { "global_what_is_the_season" },
        identity = true
    },
    native_modifier_order = true,
}
    :value("REGEN_HP_AWAKE", { multiply = 1 })
    :value("REGEN_HP", {
        multiply_handler = "contextual_enchantment_inline_ench_effect_changeling_spring_healing_increase_while_outside_1_value_1_multiply",
        load_skills = {}
    })
    :value("MENDING_MODIFIER", {
        multiply_handler = "contextual_enchantment_inline_ench_effect_changeling_spring_healing_increase_while_outside_1_value_2_multiply",
        load_skills = {}
    })
    :effect("effect_xe_hidden_infection_recovery", 1))

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_changeling_summer_absorb_strength_0", function(ctx)
    return ctx.character_inputs.identity.monster
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_absorb_strength_0",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_changeling_summer_absorb_strength_0",
    load_character_inputs = { identity = true },
    native_modifier_order = true,
}
    :melee_damage("bash", { multiply = -0.2 })
    :melee_damage("cut", { multiply = -0.2 })
    :melee_damage("stab", { multiply = -0.2 }))

ccb.runtime.handler("contextual_enchantment_inline_ench_effect_changeling_summer_absorb_strength_1_value_0_add", function(ctx)
    return math.max((((-1) + (ctx.character_inputs.character_variables["changeling_summer_glamour_tracker"] / (-8))) + (ctx.character_inputs.character_variables["changeling_gramarye_tracker"] * (-0.3))), (-6))
end)

ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_changeling_summer_absorb_strength_1", function(ctx)
    return ctx.character_inputs.identity.character
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_absorb_strength_1",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_changeling_summer_absorb_strength_1",
    load_character_inputs = {
        character_variables = { "changeling_gramarye_tracker", "changeling_summer_glamour_tracker" },
        identity = true
    },
    native_modifier_order = true,
}
    :value("STRENGTH", {
        add_handler = "contextual_enchantment_inline_ench_effect_changeling_summer_absorb_strength_1_value_0_add",
        load_skills = {}
    }))

-- effects/effects_weather.json
ccb.runtime.handler("contextual_enchantment_active_inline_ench_effect_xe_weather_ominous_fog_monster_buff_0", function(ctx)
    return (ctx.character_inputs.species["ZOMBIE"] and
        ctx.character_inputs.environment.outside and
        ctx.character_inputs.environment.weather == "xe_weather_ominous_fog")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_xe_weather_ominous_fog_monster_buff_0",
    condition_handler = "contextual_enchantment_active_inline_ench_effect_xe_weather_ominous_fog_monster_buff_0",
    load_character_inputs = { environment = { outside = true, weather = true }, species = { "ZOMBIE" } },
    native_modifier_order = true,
}
    :value("SPEED", { multiply = 0.25 })
    :value("VISION_RANGE", { add = 20 })
    :incoming_damage("bash", { multiply = -0.1 })
    :incoming_damage("stab", { multiply = -0.1 })
    :incoming_damage("cut", { multiply = -0.1 })
    :incoming_damage("bullet", { multiply = -0.1 })
    :incoming_damage("cold", { multiply = -0.1 })
    :incoming_damage("heat", { multiply = -0.1 })
    :incoming_damage("electric", { multiply = -0.1 })
    :incoming_damage("biological", { multiply = -0.1 })
    :incoming_damage("xe_shadow_damage", { multiply = -0.1 })
    :incoming_damage("withering_damage", { multiply = -0.1 }))
