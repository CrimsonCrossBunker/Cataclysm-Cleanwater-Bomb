local ccb = require("ccb")
local content = ccb.content

local skyisland_active = content.is_mod_active("skyisland")

-- effects/effects.json
ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_1_0_value_0_add", function(ctx)
    return ((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 10)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception))
end)

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_1_0_value_1_add", function(ctx)
    return (((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 4)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception)) * (((ctx.character_inputs.traits["SYLPH"] and 1 or 0) > 0) and 1.2 or 1))
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_1_0", function(ctx)
    return ((ctx.character_inputs.environment.outside and
        ctx.character_inputs.traits["SYLPH"]) or
        ((ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain_flags["YOUNG"] or
        ctx.character_inputs.environment.terrain == "t_barkfloor" or
        ctx.character_inputs.environment.terrain == "t_barkfloor_noroof") and
        ctx.character_inputs.traits["ARVORE"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_paraclesian_dodge_bonus_1_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_1_0",
    load_character_inputs = { environment = { outside = true, terrain = true, terrain_flags = { "DIGGABLE", "SHRUB", "YOUNG" } }, traits = { "ARVORE", "SYLPH" } },
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_1_0_value_0_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } })
    :value("DODGE_CHANCE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_1_0_value_1_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } }))

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_1_1_value_0_add", function(ctx)
    return (((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 10)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception)) * 0.5)
end)

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_1_1_value_1_add", function(ctx)
    return ((((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 4)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception)) * (((ctx.character_inputs.traits["SYLPH"] and 1 or 0) > 0) and 1.2 or 1)) * 0.5)
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_1_1", function(ctx)
    return ((not (ctx.character_inputs.environment.outside) and
        ctx.character_inputs.traits["SYLPH"]) or
        (not ((ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain_flags["YOUNG"] or
        ctx.character_inputs.environment.terrain == "t_barkfloor" or
        ctx.character_inputs.environment.terrain == "t_barkfloor_noroof")) and
        ctx.character_inputs.traits["ARVORE"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_paraclesian_dodge_bonus_1_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_1_1",
    load_character_inputs = { environment = { outside = true, terrain = true, terrain_flags = { "DIGGABLE", "SHRUB", "YOUNG" } }, traits = { "ARVORE", "SYLPH" } },
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_1_1_value_0_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } })
    :value("DODGE_CHANCE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_1_1_value_1_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } }))

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_2_0_value_0_add", function(ctx)
    return ((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 10)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception))
end)

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_2_0_value_1_add", function(ctx)
    return (((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 4)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception)) * (((ctx.character_inputs.traits["SYLPH"] and 1 or 0) > 0) and 1.2 or 1))
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_2_0", function(ctx)
    return ((ctx.character_inputs.environment.outside and
        ctx.character_inputs.traits["SYLPH"]) or
        ((ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain_flags["YOUNG"] or
        ctx.character_inputs.environment.terrain == "t_barkfloor" or
        ctx.character_inputs.environment.terrain == "t_barkfloor_noroof") and
        ctx.character_inputs.traits["ARVORE"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_paraclesian_dodge_bonus_2_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_2_0",
    load_character_inputs = { environment = { outside = true, terrain = true, terrain_flags = { "DIGGABLE", "SHRUB", "YOUNG" } }, traits = { "ARVORE", "SYLPH" } },
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_2_0_value_0_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } })
    :value("DODGE_CHANCE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_2_0_value_1_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } }))

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_2_1_value_0_add", function(ctx)
    return (((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 10)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception)) * 0.5)
end)

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_2_1_value_1_add", function(ctx)
    return ((((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 4)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception)) * (((ctx.character_inputs.traits["SYLPH"] and 1 or 0) > 0) and 1.2 or 1)) * 0.5)
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_2_1", function(ctx)
    return ((not (ctx.character_inputs.environment.outside) and
        ctx.character_inputs.traits["SYLPH"]) or
        (not ((ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain_flags["YOUNG"] or
        ctx.character_inputs.environment.terrain == "t_barkfloor" or
        ctx.character_inputs.environment.terrain == "t_barkfloor_noroof")) and
        ctx.character_inputs.traits["ARVORE"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_paraclesian_dodge_bonus_2_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_2_1",
    load_character_inputs = { environment = { outside = true, terrain = true, terrain_flags = { "DIGGABLE", "SHRUB", "YOUNG" } }, traits = { "ARVORE", "SYLPH" } },
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_2_1_value_0_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } })
    :value("DODGE_CHANCE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_2_1_value_1_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } }))

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_3_0_value_0_add", function(ctx)
    return ((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 10)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception))
end)

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_3_0_value_1_add", function(ctx)
    return (((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 4)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception)) * (((ctx.character_inputs.traits["SYLPH"] and 1 or 0) > 0) and 1.2 or 1))
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_3_0", function(ctx)
    return ((ctx.character_inputs.environment.outside and
        ctx.character_inputs.traits["SYLPH"]) or
        ((ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain_flags["YOUNG"] or
        ctx.character_inputs.environment.terrain == "t_barkfloor" or
        ctx.character_inputs.environment.terrain == "t_barkfloor_noroof") and
        ctx.character_inputs.traits["ARVORE"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_paraclesian_dodge_bonus_3_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_3_0",
    load_character_inputs = { environment = { outside = true, terrain = true, terrain_flags = { "DIGGABLE", "SHRUB", "YOUNG" } }, traits = { "ARVORE", "SYLPH" } },
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_3_0_value_0_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } })
    :value("DODGE_CHANCE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_3_0_value_1_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } }))

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_3_1_value_0_add", function(ctx)
    return (((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 10)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception)) * 0.5)
end)

ccb.runtime.handler("context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_3_1_value_1_add", function(ctx)
    return ((((1 + (ctx.spell_levels["paraclesian_spell_dodge_bonus"] / 4)) * ccb.runtime.call_number("attribute_scaling", ctx.stats.perception)) * (((ctx.character_inputs.traits["SYLPH"] and 1 or 0) > 0) and 1.2 or 1)) * 0.5)
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_3_1", function(ctx)
    return ((not (ctx.character_inputs.environment.outside) and
        ctx.character_inputs.traits["SYLPH"]) or
        (not ((ctx.character_inputs.environment.terrain_flags["SHRUB"] or
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain_flags["YOUNG"] or
        ctx.character_inputs.environment.terrain == "t_barkfloor" or
        ctx.character_inputs.environment.terrain == "t_barkfloor_noroof")) and
        ctx.character_inputs.traits["ARVORE"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_paraclesian_dodge_bonus_3_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_paraclesian_dodge_bonus_3_1",
    load_character_inputs = { environment = { outside = true, terrain = true, terrain_flags = { "DIGGABLE", "SHRUB", "YOUNG" } }, traits = { "ARVORE", "SYLPH" } },
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_3_1_value_0_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } })
    :value("DODGE_CHANCE", { add_handler = "context_enchantment_inline_ench_effect_paraclesian_dodge_bonus_3_1_value_1_add", load_skills = {  }, load_spell_levels = { "paraclesian_spell_dodge_bonus" } }))

-- effects/effects_changeling_seasonal_magic.json
ccb.runtime.handler("context_enchantment_inline_ench_effect_changeling_spring_reduce_scent_0_value_0_multiply", function(ctx)
    return ((((-0.15) - (ctx.character_inputs.spell_school_counts["CHANGELING_SEASONAL_MAGIC_SPRING"] * 0.015)) - (ctx.skills["gramarye"] * 0.035)) * ((ctx.character_inputs.global_variables["global_what_is_the_season"] == 3) and 0.5 or 1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_spring_reduce_scent_0",
    load_character_inputs = { global_variables = { "global_what_is_the_season" }, spell_school_counts = { "CHANGELING_SEASONAL_MAGIC_SPRING" } },
    native_modifier_order = true,
}
    :value("SCENT_MASK", { multiply_handler = "context_enchantment_inline_ench_effect_changeling_spring_reduce_scent_0_value_0_multiply", load_skills = { "gramarye" } }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_spring_protective_plant_armor_1", function(ctx)
    return not (ctx.character_inputs.environment.season == "autumn")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_spring_protective_plant_armor_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_spring_protective_plant_armor_1",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_HEAT", { add = 50 })
    :incoming_damage("cold", { multiply = -0.5 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_summer_protect_from_hot_weather_0", function(ctx)
    return ctx.character_inputs.environment.season == "summer"
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_protect_from_hot_weather_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_summer_protect_from_hot_weather_0",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :incoming_damage("heat", { multiply = -0.33 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_summer_slow_and_sweat_debuff_0", function(ctx)
    return not (ctx.character_inputs.environment.season == "winter")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_slow_and_sweat_debuff_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_summer_slow_and_sweat_debuff_0",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :value("SPEED", { multiply = -0.15 })
    :value("SWEAT_MULTIPLIER", { multiply = 0.5 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_summer_slow_and_sweat_debuff_1", function(ctx)
    return (ctx.character_inputs.environment.season == "winter" and
        ctx.character_inputs.environment.outside and
        ctx.character_inputs.environment.daylight)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_slow_and_sweat_debuff_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_summer_slow_and_sweat_debuff_1",
    load_character_inputs = { environment = { daylight = true, outside = true, season = true } },
    native_modifier_order = true,
}
    :value("SPEED", { multiply = -0.15 })
    :value("SWEAT_MULTIPLIER", { multiply = 0.5 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_summer_run_for_long_periods_0", function(ctx)
    return (not (ctx.character_inputs.environment.season == "winter") or
        (ctx.character_inputs.environment.season == "winter" and
        ctx.character_inputs.environment.outside))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_run_for_long_periods_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_summer_run_for_long_periods_0",
    load_character_inputs = { environment = { outside = true, season = true } },
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", { add = 200 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_summer_stay_awake_in_sunlight_0", function(ctx)
    return (ctx.character_inputs.environment.outside and
        (ctx.character_inputs.environment.weather == "clear" or
        ctx.character_inputs.environment.weather == "sunny"))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_summer_stay_awake_in_sunlight_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_summer_stay_awake_in_sunlight_0",
    load_character_inputs = { environment = { outside = true, weather = true } },
    native_modifier_order = true,
}
    :value("SLEEPINESS", { multiply = -1 }))

ccb.runtime.handler("context_enchantment_inline_ench_effect_changeling_autumn_scare_humans_0_value_0_multiply", function(ctx)
    return (45 * ((ctx.character_inputs.global_variables["global_what_is_the_season"] == 1) and 0.6 or 1))
end)

ccb.runtime.handler("context_enchantment_inline_ench_effect_changeling_autumn_scare_humans_0_value_1_multiply", function(ctx)
    return (-45)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_autumn_scare_humans_0",
    load_character_inputs = { global_variables = { "global_what_is_the_season" } },
    native_modifier_order = true,
}
    :value("SOCIAL_INTIMIDATE", { multiply_handler = "context_enchantment_inline_ench_effect_changeling_autumn_scare_humans_0_value_0_multiply", load_skills = {  } })
    :value("SOCIAL_PERSUADE", { multiply_handler = "context_enchantment_inline_ench_effect_changeling_autumn_scare_humans_0_value_1_multiply", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_autumn_protection_from_ranged_1", function(ctx)
    return ctx.character_inputs.environment.season == "autumn"
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_autumn_protection_from_ranged_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_autumn_protection_from_ranged_1",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", { add = 33 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_winter_walk_in_silence_0", function(ctx)
    return not (ctx.character_inputs.environment.season == "winter")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_winter_walk_in_silence_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_winter_walk_in_silence_0",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :value("FOOTSTEP_NOISE", { multiply = -0.9 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_winter_walk_in_silence_1", function(ctx)
    return ctx.character_inputs.environment.season == "winter"
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_winter_walk_in_silence_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_winter_walk_in_silence_1",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :value("FOOTSTEP_NOISE", { multiply = -1 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_winter_see_craft_darkness_0", function(ctx)
    return not (ctx.character_inputs.environment.season == "summer")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_winter_see_craft_darkness_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_winter_see_craft_darkness_0",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :effect("effect_changeling_winter_see_craft_darkness_actual", 1))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_changeling_winter_see_craft_darkness_1", function(ctx)
    return (ctx.character_inputs.environment.season == "summer" and
        ctx.character_inputs.environment.outside)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_changeling_winter_see_craft_darkness_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_changeling_winter_see_craft_darkness_1",
    load_character_inputs = { environment = { outside = true, season = true } },
    native_modifier_order = true,
}
    :effect("effect_changeling_winter_see_craft_darkness_actual", 1))

-- effects/effects_monster_only.json
ccb.runtime.handler("context_enchantment_active_inline_ench_effect_monster_viridian_cuirass_1", function(ctx)
    return not (ctx.character_inputs.environment.season == "autumn")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_monster_viridian_cuirass_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_monster_viridian_cuirass_1",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :incoming_damage("cold", { multiply = -0.5 }))

-- effects/goblin_fruit_effects.json
ccb.runtime.handler("context_enchantment_inline_ench_effect_goblin_fruit_altitude_speed_0_value_0_add", function(ctx)
    return math.max(((ctx.character_inputs.environment.position_z + 1) * 3), 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_goblin_fruit_altitude_speed_0",
    load_character_inputs = { environment = { position_z = true } },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_effect_goblin_fruit_altitude_speed_0_value_0_add", load_skills = {  } }))

-- mutations/mutations.json
ccb.runtime.handler("context_enchantment_active_inline_ench_dhampir_weakness_sun_sensitivity_1", function(ctx)
    return (ctx.character_inputs.environment.daylight and
        ctx.character_inputs.environment.outside and
        (ctx.character_inputs.environment.weather == "sunny" or
        ctx.character_inputs.environment.weather == "clear"))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_DHAMPIR_WEAKNESS_SUN_SENSITIVITY_1",
    condition_handler = "context_enchantment_active_inline_ench_dhampir_weakness_sun_sensitivity_1",
    load_character_inputs = { environment = { daylight = true, outside = true, weather = true } },
    native_modifier_order = true,
}
    :value("STRENGTH", { add = -2 })
    :value("DEXTERITY", { add = -2 })
    :value("INTELLIGENCE", { add = -2 })
    :value("PERCEPTION", { add = -2 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_vampire2_0", function(ctx)
    return ((skyisland_active and ((not (ctx.character_inputs.effects["vampire_blind_the_sun"]) and
        not (ctx.character_inputs.traits["mut_skyisland_sunblock_real"])))) or (not skyisland_active and ((not (ctx.character_inputs.effects["vampire_blind_the_sun"])))))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE2_0",
    condition_handler = "context_enchantment_active_inline_ench_vampire2_0",
    load_character_inputs = { effects = { "vampire_blind_the_sun" }, traits = { "mut_skyisland_sunblock_real" } },
    native_modifier_order = true,
}
    :effect("effect_vampire_albino", 1))

ccb.runtime.handler("context_enchantment_active_inline_ench_vampire3_2", function(ctx)
    return ((skyisland_active and ((not (ctx.character_inputs.effects["vampire_blind_the_sun"]) and
        not (ctx.character_inputs.traits["mut_skyisland_sunblock_real"])))) or (not skyisland_active and ((not (ctx.character_inputs.effects["vampire_blind_the_sun"])))))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE3_2",
    condition_handler = "context_enchantment_active_inline_ench_vampire3_2",
    load_character_inputs = { effects = { "vampire_blind_the_sun" }, traits = { "mut_skyisland_sunblock_real" } },
    native_modifier_order = true,
}
    :effect("effect_vampire_burn_under_sunlight", 1))

ccb.runtime.handler("context_enchantment_active_inline_ench_vampire4_6", function(ctx)
    return ((skyisland_active and ((not (ctx.character_inputs.effects["vampire_blind_the_sun"]) and
        not (ctx.character_inputs.traits["mut_skyisland_sunblock_real"])))) or (not skyisland_active and ((not (ctx.character_inputs.effects["vampire_blind_the_sun"])))))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE4_6",
    condition_handler = "context_enchantment_active_inline_ench_vampire4_6",
    load_character_inputs = { effects = { "vampire_blind_the_sun" }, traits = { "mut_skyisland_sunblock_real" } },
    native_modifier_order = true,
}
    :effect("effect_vampire_burn_to_death_in_sunlight", 1))

ccb.runtime.handler("context_enchantment_active_inline_ench_blood_drinker_1", function(ctx)
    return ((skyisland_active and ((not (ctx.character_inputs.effects["vampire_blind_the_sun"]) and
        not (ctx.character_inputs.traits["mut_skyisland_sunblock_real"])))) or (not skyisland_active and ((not (ctx.character_inputs.effects["vampire_blind_the_sun"])))))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_BLOOD_DRINKER_1",
    condition_handler = "context_enchantment_active_inline_ench_blood_drinker_1",
    load_character_inputs = { effects = { "vampire_blind_the_sun" }, traits = { "mut_skyisland_sunblock_real" } },
    native_modifier_order = true,
}
    :effect("effect_vampire_burn_to_death_in_sunlight", 1))

-- mutations/paraclesians/arvore_mutations.json
ccb.runtime.handler("context_enchantment_active_inline_ench_arvore_mood_changes_with_seasons_0", function(ctx)
    return ctx.character_inputs.environment.season == "spring"
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_MOOD_CHANGES_WITH_SEASONS_0",
    condition_handler = "context_enchantment_active_inline_ench_arvore_mood_changes_with_seasons_0",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :value("SLEEPINESS", { multiply = -0.1 })
    :value("SLEEPINESS_REGEN", { multiply = 0.1 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_arvore_mood_changes_with_seasons_1", function(ctx)
    return ctx.character_inputs.environment.season == "summer"
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_MOOD_CHANGES_WITH_SEASONS_1",
    condition_handler = "context_enchantment_active_inline_ench_arvore_mood_changes_with_seasons_1",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :value("SLEEPINESS", { multiply = -0.25 })
    :value("SLEEPINESS_REGEN", { multiply = 0.25 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_arvore_mood_changes_with_seasons_2", function(ctx)
    return ctx.character_inputs.environment.season == "autumn"
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_MOOD_CHANGES_WITH_SEASONS_2",
    condition_handler = "context_enchantment_active_inline_ench_arvore_mood_changes_with_seasons_2",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :value("SLEEPINESS", { multiply = 0.1 })
    :value("SLEEPINESS_REGEN", { multiply = -0.1 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_arvore_mood_changes_with_seasons_3", function(ctx)
    return ctx.character_inputs.environment.season == "winter"
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_MOOD_CHANGES_WITH_SEASONS_3",
    condition_handler = "context_enchantment_active_inline_ench_arvore_mood_changes_with_seasons_3",
    load_character_inputs = { environment = { season = true } },
    native_modifier_order = true,
}
    :value("SLEEPINESS", { multiply = 0.25 })
    :value("SLEEPINESS_REGEN", { multiply = -0.25 }))

-- mutations/paraclesians/homullus_mutations.json
ccb.runtime.handler("context_enchantment_active_inline_ench_homullus_gain_bionic_power_and_mana_0", function(ctx)
    return (ctx.character_inputs.character_variables["homullus_is_in_civilization"] == 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_GAIN_BIONIC_POWER_AND_MANA_0",
    condition_handler = "context_enchantment_active_inline_ench_homullus_gain_bionic_power_and_mana_0",
    load_character_inputs = { character_variables = { "homullus_is_in_civilization" } },
    native_modifier_order = true,
}
    :value("REGEN_MANA", { multiply = 0.25 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_homullus_crafting_bonus_1_0", function(ctx)
    return (ctx.character_inputs.character_variables["homullus_is_in_civilization"] == 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_CRAFTING_BONUS_1_0",
    condition_handler = "context_enchantment_active_inline_ench_homullus_crafting_bonus_1_0",
    load_character_inputs = { character_variables = { "homullus_is_in_civilization" } },
    native_modifier_order = true,
}
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.15 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_homullus_crafting_bonus_2_0", function(ctx)
    return (ctx.character_inputs.character_variables["homullus_is_in_civilization"] == 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_CRAFTING_BONUS_2_0",
    condition_handler = "context_enchantment_active_inline_ench_homullus_crafting_bonus_2_0",
    load_character_inputs = { character_variables = { "homullus_is_in_civilization" } },
    native_modifier_order = true,
}
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.25 })
    :skill("electronics", { add = 1 })
    :skill("fabrication", { add = 1 })
    :skill("mechanics", { add = 1 })
    :skill("tailor", { add = 1 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_homullus_crafting_bonus_3_0", function(ctx)
    return (ctx.character_inputs.character_variables["homullus_is_in_civilization"] == 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_HOMULLUS_CRAFTING_BONUS_3_0",
    condition_handler = "context_enchantment_active_inline_ench_homullus_crafting_bonus_3_0",
    load_character_inputs = { character_variables = { "homullus_is_in_civilization" } },
    native_modifier_order = true,
}
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.35 })
    :skill("electronics", { add = 2 })
    :skill("fabrication", { add = 2 })
    :skill("mechanics", { add = 2 })
    :skill("tailor", { add = 2 }))

-- mutations/paraclesians/ierde_mutations.json
ccb.runtime.handler("context_enchantment_active_inline_ench_ierde_strong_equipment_0", function(ctx)
    return ((ctx.character_inputs.environment.position_z <= (-1)) or
        ((ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain == "t_rock_floor" or
        ctx.character_inputs.environment.terrain == "t_rock_floor_no_roof") and
        not (ctx.character_inputs.environment.terrain == "t_vitrified_sand") and
        not (ctx.character_inputs.environment.terrain == "t_pit_corpsed") and
        not (ctx.character_inputs.environment.terrain == "t_fungus") and
        not (ctx.character_inputs.environment.terrain == "t_glassed_sand") and
        not (ctx.character_inputs.environment.terrain == "t_rubber_mulch") and
        not (ctx.character_inputs.environment.terrain == "t_swater_surf") and
        not (ctx.character_inputs.environment.terrain == "t_woodchips")))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_IERDE_STRONG_EQUIPMENT_0",
    condition_handler = "context_enchantment_active_inline_ench_ierde_strong_equipment_0",
    load_character_inputs = { environment = { position_z = true, terrain = true, terrain_flags = { "DIGGABLE" } } },
    native_modifier_order = true,
}
    :value("EQUIPMENT_DAMAGE_CHANCE", { multiply = -0.5 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_ierde_regain_stamina_underground_0", function(ctx)
    return ((ctx.character_inputs.environment.position_z <= (-1)) or
        (ctx.character_inputs.environment.terrain_flags["DIGGABLE"] and
        not (ctx.character_inputs.environment.terrain == "t_vitrified_sand") and
        not (ctx.character_inputs.environment.terrain == "t_pit_corpsed") and
        not (ctx.character_inputs.environment.terrain == "t_fungus") and
        not (ctx.character_inputs.environment.terrain == "t_glassed_sand") and
        not (ctx.character_inputs.environment.terrain == "t_rubber_mulch") and
        not (ctx.character_inputs.environment.terrain == "t_swater_surf") and
        not (ctx.character_inputs.environment.terrain == "t_woodchips")))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_IERDE_REGAIN_STAMINA_UNDERGROUND_0",
    condition_handler = "context_enchantment_active_inline_ench_ierde_regain_stamina_underground_0",
    load_character_inputs = { environment = { position_z = true, terrain = true, terrain_flags = { "DIGGABLE" } } },
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", { multiply = 0.5 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_ierde_heal_faster_underground_0", function(ctx)
    return ((ctx.character_inputs.environment.position_z <= (-1)) or
        (ctx.character_inputs.environment.terrain_flags["DIGGABLE"] and
        not (ctx.character_inputs.environment.terrain == "t_vitrified_sand") and
        not (ctx.character_inputs.environment.terrain == "t_pit_corpsed") and
        not (ctx.character_inputs.environment.terrain == "t_fungus") and
        not (ctx.character_inputs.environment.terrain == "t_glassed_sand") and
        not (ctx.character_inputs.environment.terrain == "t_rubber_mulch") and
        not (ctx.character_inputs.environment.terrain == "t_swater_surf") and
        not (ctx.character_inputs.environment.terrain == "t_woodchips")))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_IERDE_HEAL_FASTER_UNDERGROUND_0",
    condition_handler = "context_enchantment_active_inline_ench_ierde_heal_faster_underground_0",
    load_character_inputs = { environment = { position_z = true, terrain = true, terrain_flags = { "DIGGABLE" } } },
    native_modifier_order = true,
}
    :value("REGEN_STAMINA", { multiply = 0.5 })
    :value("REGEN_HP", { multiply = 0.33 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_ierde_feel_no_pain_0", function(ctx)
    return ((ctx.character_inputs.environment.position_z <= (-1)) or
        ((ctx.character_inputs.environment.terrain_flags["DIGGABLE"] or
        ctx.character_inputs.environment.terrain == "t_rock_floor" or
        ctx.character_inputs.environment.terrain == "t_rock_floor_no_roof") and
        not (ctx.character_inputs.environment.terrain == "t_vitrified_sand") and
        not (ctx.character_inputs.environment.terrain == "t_pit_corpsed") and
        not (ctx.character_inputs.environment.terrain == "t_fungus") and
        not (ctx.character_inputs.environment.terrain == "t_glassed_sand") and
        not (ctx.character_inputs.environment.terrain == "t_rubber_mulch") and
        not (ctx.character_inputs.environment.terrain == "t_swater_surf") and
        not (ctx.character_inputs.environment.terrain == "t_woodchips")))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_IERDE_FEEL_NO_PAIN_0",
    condition_handler = "context_enchantment_active_inline_ench_ierde_feel_no_pain_0",
    load_character_inputs = { environment = { position_z = true, terrain = true, terrain_flags = { "DIGGABLE" } } },
    native_modifier_order = true,
}
    :value("PAIN", { multiply = -1 }))

-- mutations/paraclesians/paraclesian_mutations.json
ccb.runtime.handler("context_enchantment_active_inline_ench_arvore_4", function(ctx)
    return (ctx.character_inputs.environment.outside and
        ctx.character_inputs.environment.daylight and
        (ctx.character_inputs.global_variables["global_what_is_the_season"] ~= 4))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ARVORE_4",
    condition_handler = "context_enchantment_active_inline_ench_arvore_4",
    load_character_inputs = { environment = { daylight = true, outside = true }, global_variables = { "global_what_is_the_season" } },
    native_modifier_order = true,
}
    :effect("effect_arvore_is_day_in_the_sun_not_winter", 1))

-- mutations/paraclesians/undine_mutations.json
ccb.runtime.handler("context_enchantment_active_inline_ench_undine_more_mana_regen_0", function(ctx)
    return (ctx.character_inputs.environment.divable or
        ctx.character_inputs.environment.terrain == "t_water_dp" or
        ctx.character_inputs.environment.terrain == "t_water_sh" or
        ctx.character_inputs.environment.terrain == "t_swater_dp" or
        ctx.character_inputs.environment.terrain == "t_swater_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_water_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_water_hot" or
        ctx.character_inputs.environment.terrain == "t_water_murky" or
        ctx.character_inputs.environment.terrain == "t_water_sh_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_sh_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_sh" or
        ctx.character_inputs.environment.terrain == "t_water_moving_dp" or
        ctx.character_inputs.environment.terrain == "t_water_moving_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_water_sh_murky_underground")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_UNDINE_MORE_MANA_REGEN_0",
    condition_handler = "context_enchantment_active_inline_ench_undine_more_mana_regen_0",
    load_character_inputs = { environment = { divable = true, terrain = true } },
    native_modifier_order = true,
}
    :value("REGEN_MANA", { multiply = 0.5 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_undine_more_mana_regen_and_mana_0", function(ctx)
    return (ctx.character_inputs.environment.divable or
        ctx.character_inputs.environment.terrain == "t_water_dp" or
        ctx.character_inputs.environment.terrain == "t_water_sh" or
        ctx.character_inputs.environment.terrain == "t_swater_dp" or
        ctx.character_inputs.environment.terrain == "t_swater_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_water_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_water_hot" or
        ctx.character_inputs.environment.terrain == "t_water_murky" or
        ctx.character_inputs.environment.terrain == "t_water_sh_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_sh_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_sh" or
        ctx.character_inputs.environment.terrain == "t_water_moving_dp" or
        ctx.character_inputs.environment.terrain == "t_water_moving_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_water_sh_murky_underground")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_UNDINE_MORE_MANA_REGEN_AND_MANA_0",
    condition_handler = "context_enchantment_active_inline_ench_undine_more_mana_regen_and_mana_0",
    load_character_inputs = { environment = { divable = true, terrain = true } },
    native_modifier_order = true,
}
    :value("REGEN_MANA", { multiply = 0.5 })
    :value("MAX_MANA", { multiply = 0.5 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_undine_more_mana_regen_and_mana_and_stamina_0", function(ctx)
    return (ctx.character_inputs.environment.divable or
        ctx.character_inputs.environment.terrain == "t_water_dp" or
        ctx.character_inputs.environment.terrain == "t_water_sh" or
        ctx.character_inputs.environment.terrain == "t_swater_dp" or
        ctx.character_inputs.environment.terrain == "t_swater_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_water_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_water_hot" or
        ctx.character_inputs.environment.terrain == "t_water_murky" or
        ctx.character_inputs.environment.terrain == "t_water_sh_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_sh_underground" or
        ctx.character_inputs.environment.terrain == "t_swater_sh" or
        ctx.character_inputs.environment.terrain == "t_water_moving_dp" or
        ctx.character_inputs.environment.terrain == "t_water_moving_dp_underground" or
        ctx.character_inputs.environment.terrain == "t_water_sh_murky_underground")
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_UNDINE_MORE_MANA_REGEN_AND_MANA_AND_STAMINA_0",
    condition_handler = "context_enchantment_active_inline_ench_undine_more_mana_regen_and_mana_and_stamina_0",
    load_character_inputs = { environment = { divable = true, terrain = true } },
    native_modifier_order = true,
}
    :value("REGEN_MANA", { multiply = 0.5 })
    :value("MAX_MANA", { multiply = 0.5 })
    :value("REGEN_STAMINA", { multiply = 1 }))

-- mutations/playable_changeling.json
ccb.runtime.handler("context_enchantment_active_inline_ench_changeling_noble_inhuman_mindset_1", function(ctx)
    return (ctx.character_inputs.physiology.perceived_pain >= 50)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_CHANGELING_NOBLE_INHUMAN_MINDSET_1",
    condition_handler = "context_enchantment_active_inline_ench_changeling_noble_inhuman_mindset_1",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :effect("effect_changeling_temporary_psychopath", 1))

ccb.runtime.handler("context_enchantment_active_inline_ench_changeling_noble_inhuman_mindset_2", function(ctx)
    return (ctx.character_inputs.physiology.sleepiness >= 200)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_CHANGELING_NOBLE_INHUMAN_MINDSET_2",
    condition_handler = "context_enchantment_active_inline_ench_changeling_noble_inhuman_mindset_2",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :effect("effect_changeling_temporary_psychopath", 1))

ccb.runtime.handler("context_enchantment_active_inline_ench_trow_less_metabolism_underground_0", function(ctx)
    return (not (ctx.character_inputs.environment.outside) and
        (ctx.character_inputs.environment.position_z <= (-1)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_TROW_LESS_METABOLISM_UNDERGROUND_0",
    condition_handler = "context_enchantment_active_inline_ench_trow_less_metabolism_underground_0",
    load_character_inputs = { environment = { outside = true, position_z = true } },
    native_modifier_order = true,
}
    :value("METABOLISM", { multiply = -0.5 })
    :value("THIRST", { multiply = -0.5 })
    :value("CLIMATE_CONTROL_HEAT", { add = 50 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_trow_stealth_underground_on_rock_0", function(ctx)
    return ((ctx.character_inputs.environment.terrain == "t_stone_masonry_floor_balcony" or
        ctx.character_inputs.environment.terrain == "t_stone_masonry_floor" or
        ctx.character_inputs.environment.terrain == "t_rock_floor_no_roof" or
        ctx.character_inputs.environment.terrain == "t_rock_floor" or
        ctx.character_inputs.environment.terrain == "t_marble_floor" or
        ctx.character_inputs.environment.terrain == "t_railroad_rubble") or
        (not (ctx.character_inputs.environment.outside) and
        (ctx.character_inputs.environment.position_z <= (-1))))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_TROW_STEALTH_UNDERGROUND_ON_ROCK_0",
    condition_handler = "context_enchantment_active_inline_ench_trow_stealth_underground_on_rock_0",
    load_character_inputs = { environment = { outside = true, position_z = true, terrain = true } },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", { add = 25 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_painresist_trow_0", function(ctx)
    return (not (ctx.character_inputs.environment.outside) and
        (ctx.character_inputs.environment.position_z <= (-1)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_PAINRESIST_TROW_0",
    condition_handler = "context_enchantment_active_inline_ench_painresist_trow_0",
    load_character_inputs = { environment = { outside = true, position_z = true } },
    native_modifier_order = true,
}
    :value("PAIN", { multiply = -0.5 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_painresist_trow2_0", function(ctx)
    return (not (ctx.character_inputs.environment.outside) and
        (ctx.character_inputs.environment.position_z <= (-1)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_PAINRESIST_TROW2_0",
    condition_handler = "context_enchantment_active_inline_ench_painresist_trow2_0",
    load_character_inputs = { environment = { outside = true, position_z = true } },
    native_modifier_order = true,
}
    :value("PAIN", { multiply = -0.5 }))

-- mutations/xe_lilin.json
ccb.runtime.handler("context_enchantment_active_inline_ench_thresh_lilin_1", function(ctx)
    return (ctx.character_inputs.environment.daylight and
        ctx.character_inputs.environment.outside and
        (ctx.character_inputs.environment.weather == "sunny" or
        ctx.character_inputs.environment.weather == "clear"))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_THRESH_LILIN_1",
    condition_handler = "context_enchantment_active_inline_ench_thresh_lilin_1",
    load_character_inputs = { environment = { daylight = true, outside = true, weather = true } },
    native_modifier_order = true,
}
    :value("STRENGTH", { add = -2 })
    :value("DEXTERITY", { add = -2 })
    :value("INTELLIGENCE", { add = -2 })
    :value("PERCEPTION", { add = -2 }))
