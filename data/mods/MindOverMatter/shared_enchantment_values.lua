local ccb = require("ccb")
local content = ccb.content

local psychic_scaling = require("psychic_enchantment_scaling")
local power_modifier = psychic_scaling.power

local function clamp(value, minimum, maximum)
    return math.min(math.max(value, minimum), maximum)
end

-- effects/effects_npc.json
ccb.runtime.handler("shared_enchantment_inline_ench_effect_electrokinetic_speed_boost_npc_0_value_0_add", function(ctx)
    return math.min((((5 + ctx.character_inputs.character_variables["speed_boost_electrokin_power_level"]) * ccb.runtime.call_number("attribute_scaling", ctx.character_inputs.character_variables["speed_boost_electrokin_intelligence"])) * ctx.character_inputs.character_variables["nether_attunement_speed_boost_scaling"]), 35)
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_electrokinetic_speed_boost_npc_0_value_1_add", function(ctx)
    return math.min((((10 + (ctx.character_inputs.character_variables["speed_boost_electrokin_power_level"] * 1.5)) * ccb.runtime.call_number("attribute_scaling", ctx.character_inputs.character_variables["speed_boost_electrokin_intelligence"])) * ctx.character_inputs.character_variables["nether_attunement_speed_boost_scaling"]), 60)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_electrokinetic_speed_boost_npc_0",
    load_character_inputs = { character_variables = { "nether_attunement_speed_boost_scaling", "speed_boost_electrokin_intelligence", "speed_boost_electrokin_power_level" } },
    native_modifier_order = true,
}
    :value("LEARNING_FOCUS", { add_handler = "shared_enchantment_inline_ench_effect_electrokinetic_speed_boost_npc_0_value_0_add", load_skills = {  } })
    :value("SPEED", { add_handler = "shared_enchantment_inline_ench_effect_electrokinetic_speed_boost_npc_0_value_1_add", load_skills = {  } }))

-- effects/effects_psionic.json
ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_physical_0_value_0_add", function(ctx)
    return ((1 + (ctx.spell_levels["biokin_physical_enhance"] / 5)) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_physical_0_value_1_add", function(ctx)
    return ((1 + (ctx.spell_levels["biokin_physical_enhance"] / 5)) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_physical_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("STRENGTH", { add_handler = "shared_enchantment_inline_ench_effect_biokin_physical_0_value_0_add", load_skills = {  }, load_spell_levels = { "biokin_physical_enhance" } })
    :value("DEXTERITY", { add_handler = "shared_enchantment_inline_ench_effect_biokin_physical_0_value_1_add", load_skills = {  }, load_spell_levels = { "biokin_physical_enhance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_flexibility_0_value_0_multiply", function(ctx)
    return (((-0.2) + ((ctx.spell_levels["biokin_flexibility"] + ctx.spell_levels["biokin_flexibility_knack"]) * (-0.02))) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_flexibility_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("FALL_DAMAGE", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_flexibility_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_flexibility", "biokin_flexibility_knack" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_reflex_0_value_0_add", function(ctx)
    return ((1 + (ctx.spell_levels["biokin_reflex_enhance"] / 5)) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_reflex_0_value_1_add", function(ctx)
    return math.min(((5 + ctx.spell_levels["biokin_reflex_enhance"]) * power_modifier(ctx)), 30)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_reflex_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("PERCEPTION", { add_handler = "shared_enchantment_inline_ench_effect_biokin_reflex_0_value_0_add", load_skills = {  }, load_spell_levels = { "biokin_reflex_enhance" } })
    :value("SPEED", { add_handler = "shared_enchantment_inline_ench_effect_biokin_reflex_0_value_1_add", load_skills = {  }, load_spell_levels = { "biokin_reflex_enhance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_armor_skin_0_value_0_multiply", function(ctx)
    return ((ctx.spell_levels["biokin_armor_skin"] * (-0.02)) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_armor_skin_0_incoming_damage_0_add", function(ctx)
    return ((-6) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_armor_skin_0_incoming_damage_1_add", function(ctx)
    return ((-3) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_armor_skin_0_incoming_damage_2_add", function(ctx)
    return ((-4) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_armor_skin_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("PAIN", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_armor_skin_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_armor_skin" } })
    :incoming_damage("bash", { add_handler = "shared_enchantment_inline_ench_effect_biokin_armor_skin_0_incoming_damage_0_add", load_skills = {  } })
    :incoming_damage("stab", { add_handler = "shared_enchantment_inline_ench_effect_biokin_armor_skin_0_incoming_damage_1_add", load_skills = {  } })
    :incoming_damage("cut", { add_handler = "shared_enchantment_inline_ench_effect_biokin_armor_skin_0_incoming_damage_2_add", load_skills = {  } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_climate_control_0_value_0_add", function(ctx)
    return (((ctx.spell_levels["biokin_climate_control"] * 7.5) + 15) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_climate_control_0_value_1_add", function(ctx)
    return (((ctx.spell_levels["biokin_climate_control"] * 7.5) + 15) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_climate_control_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_HEAT", { add_handler = "shared_enchantment_inline_ench_effect_biokin_climate_control_0_value_0_add", load_skills = {  }, load_spell_levels = { "biokin_climate_control" } })
    :value("CLIMATE_CONTROL_CHILL", { add_handler = "shared_enchantment_inline_ench_effect_biokin_climate_control_0_value_1_add", load_skills = {  }, load_spell_levels = { "biokin_climate_control" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_enhance_mobility_0_encumbrance_0_add", function(ctx)
    return ((-1) * (ctx.spell_levels["biokin_enhance_mobility"] * power_modifier(ctx)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_enhance_mobility_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :encumbrance("all", { add_handler = "shared_enchantment_inline_ench_effect_biokin_enhance_mobility_0_encumbrance_0_add", load_skills = {  }, load_spell_levels = { "biokin_enhance_mobility" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_metabolism_enhance_0_value_0_multiply", function(ctx)
    return (math.min(((0.33 + (ctx.spell_levels["biokin_metabolism_enhance"] * 0.07)) * power_modifier(ctx)), 3) * ((ctx.character_inputs.effect_intensities["effect_nether_attunement_biokinetic_inversion"] > 0) and (-1) or 1))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_metabolism_enhance_0_value_1_multiply", function(ctx)
    return (math.min(((0.33 + (ctx.spell_levels["biokin_metabolism_enhance"] * 0.07)) * power_modifier(ctx)), 3) * ((ctx.character_inputs.effect_intensities["effect_nether_attunement_biokinetic_inversion"] > 0) and (-0.32) or 1))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_metabolism_enhance_0_value_2_multiply", function(ctx)
    return (math.max((((-0.1) + (ctx.spell_levels["biokin_metabolism_enhance"] * (-0.01))) * power_modifier(ctx)), (-0.4)) * ((ctx.character_inputs.effect_intensities["effect_nether_attunement_biokinetic_inversion"] > 0) and (-1) or 1))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_metabolism_enhance_0_value_3_multiply", function(ctx)
    return (math.max((((-0.25) + (ctx.spell_levels["biokin_metabolism_enhance"] * (-0.02))) * power_modifier(ctx)), (-0.7)) * ((ctx.character_inputs.effect_intensities["effect_nether_attunement_biokinetic_inversion"] > 0) and (-1) or 1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_metabolism_enhance_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "effect_nether_attunement_biokinetic_inversion", "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("KCAL", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_metabolism_enhance_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_metabolism_enhance" } })
    :value("VITAMIN_ABSORB_MOD", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_metabolism_enhance_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "biokin_metabolism_enhance" } })
    :value("METABOLISM", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_metabolism_enhance_0_value_2_multiply", load_skills = {  }, load_spell_levels = { "biokin_metabolism_enhance" } })
    :value("SLEEPINESS", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_metabolism_enhance_0_value_3_multiply", load_skills = {  }, load_spell_levels = { "biokin_metabolism_enhance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_0_value_0_multiply", function(ctx)
    return math.max(((-0.05) + ((ctx.spell_levels["biokin_combat_dance"] * (-0.015)) * power_modifier(ctx))), (-0.7))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_0_melee_damage_0_multiply", function(ctx)
    return ((ctx.spell_levels["biokin_combat_dance"] * 0.02) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_0_melee_damage_1_multiply", function(ctx)
    return ((ctx.spell_levels["biokin_combat_dance"] * 0.02) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_0_melee_damage_2_multiply", function(ctx)
    return ((ctx.spell_levels["biokin_combat_dance"] * 0.02) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_combat_dance_0", function(ctx)
    return ctx.character_inputs.effects["effect_biokin_physical"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_0",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_combat_dance_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_physical" }, stats = true },
    native_modifier_order = true,
}
    :value("MELEE_STAMINA_CONSUMPTION", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } })
    :melee_damage("bash", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_0_melee_damage_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } })
    :melee_damage("cut", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_0_melee_damage_1_multiply", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } })
    :melee_damage("stab", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_0_melee_damage_2_multiply", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_1_value_0_multiply", function(ctx)
    return (((ctx.spell_levels["biokin_combat_dance"] * (-0.03)) - 0.15) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_combat_dance_1", function(ctx)
    return ctx.character_inputs.effects["effect_biokin_overcome_pain"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_1",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_combat_dance_1",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_overcome_pain" }, stats = true },
    native_modifier_order = true,
}
    :value("PAIN", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_1_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_2_value_0_add", function(ctx)
    return (((ctx.spell_levels["biokin_combat_dance"] * 1) + 4) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_combat_dance_2", function(ctx)
    return ctx.character_inputs.effects["effect_biokin_flexibility"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_2",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_combat_dance_2",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_flexibility" }, stats = true },
    native_modifier_order = true,
}
    :value("DODGE_CHANCE", { add_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_2_value_0_add", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_3_value_0_multiply", function(ctx)
    return (((ctx.spell_levels["biokin_combat_dance"] * 0.025) + 0.15) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_combat_dance_3", function(ctx)
    return ctx.character_inputs.effects["adrenaline"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_3",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_combat_dance_3",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "adrenaline" }, stats = true },
    native_modifier_order = true,
}
    :value("CARDIO_MULTIPLIER", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_3_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_4_incoming_damage_0_add", function(ctx)
    return (((-6) * power_modifier(ctx)) * math.max((0.5 + (ctx.spell_levels["biokin_combat_dance"] * 0.05)), 1))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_4_incoming_damage_1_add", function(ctx)
    return (((-3) * power_modifier(ctx)) * math.max((0.5 + (ctx.spell_levels["biokin_combat_dance"] * 0.05)), 1))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_4_incoming_damage_2_add", function(ctx)
    return (((-4) * power_modifier(ctx)) * math.max((0.5 + (ctx.spell_levels["biokin_combat_dance"] * 0.05)), 1))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_combat_dance_4", function(ctx)
    return ctx.character_inputs.effects["effect_biokin_armor_skin"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_4",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_combat_dance_4",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_armor_skin" }, stats = true },
    native_modifier_order = true,
}
    :incoming_damage("bash", { add_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_4_incoming_damage_0_add", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } })
    :incoming_damage("stab", { add_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_4_incoming_damage_1_add", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } })
    :incoming_damage("cut", { add_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_4_incoming_damage_2_add", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } })
    :effect("effect_biokin_combat_dance_no_stun_or_daze", 1))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_5_value_0_add", function(ctx)
    return (((ctx.spell_levels["biokin_combat_dance"] * (-5)) - 50) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_5_melee_damage_0_multiply", function(ctx)
    return (((ctx.spell_levels["biokin_combat_dance"] * 0.03) + 0.25) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_combat_dance_5", function(ctx)
    return (ctx.character_inputs.effects["effect_biokin_hammerhand"] and
        not (ctx.character_inputs.armed))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_5",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_combat_dance_5",
    load_character_inputs = { armed = true, character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_hammerhand" }, stats = true },
    native_modifier_order = true,
}
    :value("OVERKILL_DAMAGE", { add_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_5_value_0_add", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } })
    :melee_damage("bash", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_5_melee_damage_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_7_value_1_multiply", function(ctx)
    return (((ctx.spell_levels["biokin_combat_dance"] / 8) + 1) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_combat_dance_7", function(ctx)
    return ctx.character_inputs.effects["effect_biokin_reflex"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_7",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_combat_dance_7",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_reflex" }, stats = true },
    native_modifier_order = true,
}
    :value("RECOIL_MODIFIER", { multiply = -0.3 })
    :value("BONUS_DODGE", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_7_value_1_multiply", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_combat_dance_8_value_0_multiply", function(ctx)
    return math.max((((-0.1) + (ctx.spell_levels["biokin_combat_dance"] * (-0.02))) * power_modifier(ctx)), (-0.5))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_combat_dance_8", function(ctx)
    return (ctx.character_inputs.effects["effect_biokin_reflex"] and
        not (ctx.character_inputs.effects["effect_biokin_perfected_motion"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_8",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_combat_dance_8",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_perfected_motion", "effect_biokin_reflex" }, stats = true },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_combat_dance_8_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_combat_dance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_guided_evolution_0_value_0_add", function(ctx)
    return math.max(1, (((ctx.spell_levels["biokin_guided_evolution"] * 0.25) + 1) * power_modifier(ctx)))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_guided_evolution_0", function(ctx)
    return not (ctx.character_inputs.effects["effect_biokin_guided_evolution_backfire"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_guided_evolution_0",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_guided_evolution_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_guided_evolution_backfire" }, stats = true },
    native_modifier_order = true,
}
    :value("MUT_ADDITIONAL_OPTIONS", { add_handler = "shared_enchantment_inline_ench_effect_biokin_guided_evolution_0_value_0_add", load_skills = {  }, load_spell_levels = { "biokin_guided_evolution" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_perfected_motion_0_value_0_multiply", function(ctx)
    return math.max((((ctx.spell_levels["biokin_perfected_motion"] * (-0.015)) + (-0.5)) * power_modifier(ctx)), (-0.96))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_perfected_motion_0", function(ctx)
    return (not (ctx.character_inputs.effects["effect_teleport_stride"]) and
        not (ctx.character_inputs.effects["effect_telekinetic_momentum"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_perfected_motion_0",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_perfected_motion_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_telekinetic_momentum", "effect_teleport_stride" }, stats = true },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_perfected_motion_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_perfected_motion" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_perfected_motion_1_value_0_multiply", function(ctx)
    return math.max(((((ctx.spell_levels["biokin_perfected_motion"] * (-0.015)) + (-0.5)) + ((ctx.spell_levels["teleport_stride"] * (-0.02)) - 0.05)) * power_modifier(ctx)), (-0.96))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_perfected_motion_1", function(ctx)
    return (ctx.character_inputs.effects["effect_teleport_stride"] and
        not (ctx.character_inputs.effects["effect_telekinetic_momentum"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_perfected_motion_1",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_perfected_motion_1",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_telekinetic_momentum", "effect_teleport_stride" }, stats = true },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_perfected_motion_1_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_perfected_motion", "teleport_stride" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_perfected_motion_2_value_0_multiply", function(ctx)
    return math.max(((((ctx.spell_levels["biokin_perfected_motion"] * (-0.015)) + (-0.5)) + (ctx.spell_levels["telekinetic_momentum"] * (-0.005))) * power_modifier(ctx)), (-0.96))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_perfected_motion_2", function(ctx)
    return (ctx.character_inputs.effects["effect_telekinetic_momentum"] and
        not (ctx.character_inputs.effects["effect_teleport_stride"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_perfected_motion_2",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_perfected_motion_2",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_telekinetic_momentum", "effect_teleport_stride" }, stats = true },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_perfected_motion_2_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_perfected_motion", "telekinetic_momentum" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_perfected_motion_3_value_0_multiply", function(ctx)
    return math.max((((((ctx.spell_levels["biokin_perfected_motion"] * (-0.015)) + (-0.5)) + (ctx.spell_levels["teleport_stride"] * (-0.005))) + (ctx.spell_levels["telekinetic_momentum"] * (-0.005))) * power_modifier(ctx)), (-0.96))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_biokin_perfected_motion_3", function(ctx)
    return (ctx.character_inputs.effects["effect_teleport_stride"] and
        ctx.character_inputs.effects["effect_telekinetic_momentum"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_perfected_motion_3",
    condition_handler = "shared_enchantment_active_inline_ench_effect_biokin_perfected_motion_3",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_telekinetic_momentum", "effect_teleport_stride" }, stats = true },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_perfected_motion_3_value_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_perfected_motion", "telekinetic_momentum", "teleport_stride" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_hurricane_blows_0_value_0_add", function(ctx)
    return math.min((((ctx.spell_levels["biokin_hurricane_blows"] * 75) + 400) * power_modifier(ctx)), 1800)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_hurricane_blows_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "shared_enchantment_inline_ench_effect_biokin_hurricane_blows_0_value_0_add", load_skills = {  }, load_spell_levels = { "biokin_hurricane_blows" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_hurricane_blows_2_0_melee_damage_0_multiply", function(ctx)
    return (((ctx.spell_levels["biokin_hurricane_blows"] * 0.015) + 0.1) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_hurricane_blows_2_0_melee_damage_1_multiply", function(ctx)
    return (((ctx.spell_levels["biokin_hurricane_blows"] * 0.015) + 0.1) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_biokin_hurricane_blows_2_0_melee_damage_2_multiply", function(ctx)
    return (((ctx.spell_levels["biokin_hurricane_blows"] * 0.015) + 0.1) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_hurricane_blows_2_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :melee_damage("bash", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_hurricane_blows_2_0_melee_damage_0_multiply", load_skills = {  }, load_spell_levels = { "biokin_hurricane_blows" } })
    :melee_damage("cut", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_hurricane_blows_2_0_melee_damage_1_multiply", load_skills = {  }, load_spell_levels = { "biokin_hurricane_blows" } })
    :melee_damage("stab", { multiply_handler = "shared_enchantment_inline_ench_effect_biokin_hurricane_blows_2_0_melee_damage_2_multiply", load_skills = {  }, load_spell_levels = { "biokin_hurricane_blows" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_night_eyes_0_value_0_add", function(ctx)
    return (((ctx.spell_levels["clair_night_vision"] * 1.5) + 2) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_night_eyes_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add_handler = "shared_enchantment_inline_ench_effect_clair_night_eyes_0_value_0_add", load_skills = {  }, load_spell_levels = { "clair_night_vision" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_speed_reader_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["clair_speed_reading"] * 0.15) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_speed_reader_0_value_1_multiply", function(ctx)
    return math.max((((ctx.spell_levels["clair_speed_reading"] * (-0.02)) + (-0.15)) * power_modifier(ctx)), (-0.6))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_speed_reader_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("READING_EXP", { add_handler = "shared_enchantment_inline_ench_effect_clair_speed_reader_0_value_0_add", load_skills = {  }, load_spell_levels = { "clair_speed_reading" } })
    :value("READING_SPEED_MULTIPLIER", { multiply_handler = "shared_enchantment_inline_ench_effect_clair_speed_reader_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "clair_speed_reading" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_premonition_0_value_0_add", function(ctx)
    return math.max(((3 + ((ctx.spell_levels["clair_danger_sense"] + ctx.spell_levels["clair_danger_sense_knack"]) * 0.5)) * power_modifier(ctx)), 25)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_premonition_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("MOTION_ALARM", { add_handler = "shared_enchantment_inline_ench_effect_clair_premonition_0_value_0_add", load_skills = {  }, load_spell_levels = { "clair_danger_sense", "clair_danger_sense_knack" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_see_auras_0_value_0_add", function(ctx)
    return math.min(((ctx.spell_levels["clair_see_auras"] + 5) * power_modifier(ctx)), 20)
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_see_auras_0_value_1_add", function(ctx)
    return math.min(((ctx.spell_levels["clair_see_auras"] + 5) * power_modifier(ctx)), 20)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_see_auras_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("SOCIAL_LIE", { add_handler = "shared_enchantment_inline_ench_effect_clair_see_auras_0_value_0_add", load_skills = {  }, load_spell_levels = { "clair_see_auras" } })
    :value("SOCIAL_PERSUADE", { add_handler = "shared_enchantment_inline_ench_effect_clair_see_auras_0_value_1_add", load_skills = {  }, load_spell_levels = { "clair_see_auras" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_ranged_enhance_0_value_0_add", function(ctx)
    return (((ctx.spell_levels["clair_ranged_enhance"] * 0.25) + 1) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_ranged_enhance_0_value_1_multiply", function(ctx)
    return math.min((((ctx.spell_levels["clair_ranged_enhance"] * 0.025) + 0.1) * power_modifier(ctx)), 5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_ranged_enhance_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("RANGE", { add_handler = "shared_enchantment_inline_ench_effect_clair_ranged_enhance_0_value_0_add", load_skills = {  }, load_spell_levels = { "clair_ranged_enhance" } })
    :value("AIMING_SPEED", { multiply_handler = "shared_enchantment_inline_ench_effect_clair_ranged_enhance_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "clair_ranged_enhance" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_dodge_0_value_0_add", function(ctx)
    return math.min((((ctx.spell_levels["clair_dodge_power"] * 0.015) + 0.25) * power_modifier(ctx)), 0.95)
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_dodge_0_value_1_add", function(ctx)
    return math.min(((ctx.spell_levels["clair_dodge_power"] * 0.5) * power_modifier(ctx)), 10)
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_dodge_0_value_2_add", function(ctx)
    return (1 + math.min(((ctx.spell_levels["clair_dodge_power"] * 0.2) * power_modifier(ctx)), 4))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_dodge_0_value_3_add", function(ctx)
    return (1 + math.min(((ctx.spell_levels["clair_dodge_power"] * 0.2) * power_modifier(ctx)), 4))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_dodge_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("RANGE_DODGE", { add_handler = "shared_enchantment_inline_ench_effect_clair_dodge_0_value_0_add", load_skills = {  }, load_spell_levels = { "clair_dodge_power" } })
    :value("DODGE_CHANCE", { add_handler = "shared_enchantment_inline_ench_effect_clair_dodge_0_value_1_add", load_skills = {  }, load_spell_levels = { "clair_dodge_power" } })
    :value("FREE_DODGES", { add_handler = "shared_enchantment_inline_ench_effect_clair_dodge_0_value_2_add", load_skills = {  }, load_spell_levels = { "clair_dodge_power" } })
    :value("BONUS_DODGE", { add_handler = "shared_enchantment_inline_ench_effect_clair_dodge_0_value_3_add", load_skills = {  }, load_spell_levels = { "clair_dodge_power" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_craft_bonus_0_value_1_multiply", function(ctx)
    return (((ctx.spell_levels["clair_craft_bonus"] * 0.01) + 0.04) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_craft_bonus_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = 3 })
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply_handler = "shared_enchantment_inline_ench_effect_clair_craft_bonus_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "clair_craft_bonus" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_astral_projection_0_value_3_add", function(ctx)
    return math.max(((((ctx.spell_levels["clair_astral_projection"] + ctx.spell_levels["clair_astral_projection_knack"]) * 0.15) + 1) * power_modifier(ctx)), 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_astral_projection_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = -0.96 })
    :value("EVASION", { add = 1 })
    :value("REGEN_STAMINA", { multiply = -1 })
    :value("PHASE_DISTANCE", { add_handler = "shared_enchantment_inline_ench_effect_clair_astral_projection_0_value_3_add", load_skills = {  }, load_spell_levels = { "clair_astral_projection", "clair_astral_projection_knack" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_group_tactics_other_0_value_0_add", function(ctx)
    return (1 + ((ctx.spell_levels["clair_group_tactics"] / 8) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_clair_group_tactics_other_0_value_1_add", function(ctx)
    return (1 + ((ctx.spell_levels["clair_group_tactics"] / 8) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_group_tactics_other_0",
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "shared_enchantment_inline_ench_effect_clair_group_tactics_other_0_value_0_add", load_skills = {  }, load_spell_levels = { "clair_group_tactics" } })
    :value("BONUS_BLOCK", { add_handler = "shared_enchantment_inline_ench_effect_clair_group_tactics_other_0_value_1_add", load_skills = {  }, load_spell_levels = { "clair_group_tactics" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_electrokin_reduce_pain_0_value_0_multiply", function(ctx)
    return math.max((((ctx.spell_levels["electrokinetic_reduce_pain"] * (-0.02)) + (-0.15)) * power_modifier(ctx)), (-0.5))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_electrokin_reduce_pain_0_value_1_multiply", function(ctx)
    return math.min((((ctx.spell_levels["electrokinetic_reduce_pain"] * 0.02) + 0.1) * power_modifier(ctx)), 0.5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_electrokin_reduce_pain_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("PAIN", { multiply_handler = "shared_enchantment_inline_ench_effect_electrokin_reduce_pain_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "electrokinetic_reduce_pain" } })
    :value("PAIN_REMOVE", { multiply_handler = "shared_enchantment_inline_ench_effect_electrokin_reduce_pain_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "electrokinetic_reduce_pain" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_electrokinetic_speed_boost_0_value_0_add", function(ctx)
    return math.min(((5 + ctx.spell_levels["electrokinetic_speed_boost"]) * power_modifier(ctx)), 35)
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_electrokinetic_speed_boost_0_value_1_add", function(ctx)
    return math.min((((ctx.spell_levels["electrokinetic_speed_boost"] * 1.5) + 10) * power_modifier(ctx)), 60)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_electrokinetic_speed_boost_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("LEARNING_FOCUS", { add_handler = "shared_enchantment_inline_ench_effect_electrokinetic_speed_boost_0_value_0_add", load_skills = {  }, load_spell_levels = { "electrokinetic_speed_boost" } })
    :value("SPEED", { add_handler = "shared_enchantment_inline_ench_effect_electrokinetic_speed_boost_0_value_1_add", load_skills = {  }, load_spell_levels = { "electrokinetic_speed_boost" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_photokin_dodge_0_value_0_add", function(ctx)
    return math.min(((((ctx.spell_levels["photokinetic_light_dodge"] / 100) * 2) + 15) + power_modifier(ctx)), 0.85)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_photokin_dodge_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("EVASION", { add_handler = "shared_enchantment_inline_ench_effect_photokin_dodge_0_value_0_add", load_skills = {  }, load_spell_levels = { "photokinetic_light_dodge" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_photokin_camouflage_0_value_0_add", function(ctx)
    return math.min((((ctx.spell_levels["photokinetic_camouflage"] * 3) + 10) * power_modifier(ctx)), 60)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_photokin_camouflage_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", { add_handler = "shared_enchantment_inline_ench_effect_photokin_camouflage_0_value_0_add", load_skills = {  }, load_spell_levels = { "photokinetic_camouflage" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_photokin_hide_ugly_0_value_0_multiply", function(ctx)
    return math.max(((((ctx.spell_levels["photokinetic_hide_ugly"] + ctx.spell_levels["photokinetic_hide_ugly_knack"]) * (-1.5)) + (-0.6)) * power_modifier(ctx)), (-1))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_photokin_hide_ugly_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("UGLINESS", { multiply_handler = "shared_enchantment_inline_ench_effect_photokin_hide_ugly_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "photokinetic_hide_ugly", "photokinetic_hide_ugly_knack" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_pyrokinetic_aura_0_value_0_add", function(ctx)
    return ((((ctx.spell_levels["pyrokinetic_aura"] + ctx.spell_levels["pyrokinetic_aura_knack"]) * 5) + 10) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_pyrokinetic_aura_0_value_1_add", function(ctx)
    return ((((ctx.spell_levels["pyrokinetic_aura"] + ctx.spell_levels["pyrokinetic_aura_knack"]) * 12) + 20) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("LUMINATION", { add_handler = "shared_enchantment_inline_ench_effect_pyrokinetic_aura_0_value_0_add", load_skills = {  }, load_spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" } })
    :value("CLIMATE_CONTROL_CHILL", { add_handler = "shared_enchantment_inline_ench_effect_pyrokinetic_aura_0_value_1_add", load_skills = {  }, load_spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" } })
    :hit_you({ id = "pyro_aura_attack", self = false }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_momentum_0_value_0_multiply", function(ctx)
    return math.max(((ctx.spell_levels["telekinetic_momentum"] * (-0.01)) * power_modifier(ctx)), (-0.3))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_momentum_0_incoming_damage_0_multiply", function(ctx)
    return math.max(((ctx.spell_levels["telekinetic_momentum"] * (-0.01)) * power_modifier(ctx)), (-0.3))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_momentum_0_incoming_damage_1_multiply", function(ctx)
    return math.max(((ctx.spell_levels["telekinetic_momentum"] * (-0.005)) * power_modifier(ctx)), (-0.15))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_momentum_0_incoming_damage_2_multiply", function(ctx)
    return math.max(((ctx.spell_levels["telekinetic_momentum"] * (-0.005)) * power_modifier(ctx)), (-0.15))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_momentum_0_incoming_damage_3_multiply", function(ctx)
    return math.max(((ctx.spell_levels["telekinetic_momentum"] * (-0.02)) * power_modifier(ctx)), (-0.6))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telekinetic_momentum_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("ATTACK_SPEED", { multiply_handler = "shared_enchantment_inline_ench_effect_telekinetic_momentum_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "telekinetic_momentum" } })
    :incoming_damage("bash", { multiply_handler = "shared_enchantment_inline_ench_effect_telekinetic_momentum_0_incoming_damage_0_multiply", load_skills = {  }, load_spell_levels = { "telekinetic_momentum" } })
    :incoming_damage("stab", { multiply_handler = "shared_enchantment_inline_ench_effect_telekinetic_momentum_0_incoming_damage_1_multiply", load_skills = {  }, load_spell_levels = { "telekinetic_momentum" } })
    :incoming_damage("cut", { multiply_handler = "shared_enchantment_inline_ench_effect_telekinetic_momentum_0_incoming_damage_2_multiply", load_skills = {  }, load_spell_levels = { "telekinetic_momentum" } })
    :incoming_damage("bullet", { multiply_handler = "shared_enchantment_inline_ench_effect_telekinetic_momentum_0_incoming_damage_3_multiply", load_skills = {  }, load_spell_levels = { "telekinetic_momentum" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_momentum_1_value_0_multiply", function(ctx)
    return math.max(((ctx.spell_levels["telekinetic_momentum"] * (-0.005)) * power_modifier(ctx)), (-0.15))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_telekinetic_momentum_1", function(ctx)
    return (not (ctx.character_inputs.effects["effect_clair_astral_projection"]) and
        not (ctx.character_inputs.effects["effect_biokin_perfected_motion"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telekinetic_momentum_1",
    condition_handler = "shared_enchantment_active_inline_ench_effect_telekinetic_momentum_1",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_perfected_motion", "effect_clair_astral_projection" }, stats = true },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "shared_enchantment_inline_ench_effect_telekinetic_momentum_1_value_0_multiply", load_skills = {  }, load_spell_levels = { "telekinetic_momentum" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_slowfall_0_value_0_multiply", function(ctx)
    return math.max((((ctx.spell_levels["telekinetic_slowfall"] * (-0.04)) + (-0.5)) * power_modifier(ctx)), (-0.95))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telekinetic_slowfall_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("FALL_DAMAGE", { multiply_handler = "shared_enchantment_inline_ench_effect_telekinetic_slowfall_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "telekinetic_slowfall" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_strength_0_value_0_add", function(ctx)
    return (((ctx.spell_levels["telekinetic_strength"] * 3) + 15) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telekinetic_strength_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("STRENGTH", { add_handler = "shared_enchantment_inline_ench_effect_telekinetic_strength_0_value_0_add", load_skills = {  }, load_spell_levels = { "telekinetic_strength" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_armor_0_incoming_damage_0_add", function(ctx)
    return (((ctx.spell_levels["telekinetic_shield"] * (-0.5)) + (-2)) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_armor_0_incoming_damage_1_add", function(ctx)
    return (((ctx.spell_levels["telekinetic_shield"] * (-1.5)) + (-5)) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_armor_0_incoming_damage_2_add", function(ctx)
    return (((ctx.spell_levels["telekinetic_shield"] * (-1)) + (-3)) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telekinetic_armor_0_incoming_damage_3_add", function(ctx)
    return (((ctx.spell_levels["telekinetic_shield"] * (-2.5)) + (-12)) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telekinetic_armor_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :incoming_damage("bash", { add_handler = "shared_enchantment_inline_ench_effect_telekinetic_armor_0_incoming_damage_0_add", load_skills = {  }, load_spell_levels = { "telekinetic_shield" } })
    :incoming_damage("stab", { add_handler = "shared_enchantment_inline_ench_effect_telekinetic_armor_0_incoming_damage_1_add", load_skills = {  }, load_spell_levels = { "telekinetic_shield" } })
    :incoming_damage("cut", { add_handler = "shared_enchantment_inline_ench_effect_telekinetic_armor_0_incoming_damage_2_add", load_skills = {  }, load_spell_levels = { "telekinetic_shield" } })
    :incoming_damage("bullet", { add_handler = "shared_enchantment_inline_ench_effect_telekinetic_armor_0_incoming_damage_3_add", load_skills = {  }, load_spell_levels = { "telekinetic_shield" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepathic_learning_bonus_0_value_0_add", function(ctx)
    return ((ctx.spell_levels["telepathic_concentration"] * 2.5) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telepathic_learning_bonus_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("LEARNING_FOCUS", { add_handler = "shared_enchantment_inline_ench_effect_telepathic_learning_bonus_0_value_0_add", load_skills = {  }, load_spell_levels = { "telepathic_concentration" } })
    :value("MOVE_COST", { multiply = 3 }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_0_melee_damage_0_multiply", function(ctx)
    return (((ctx.spell_levels["telepathic_network"] * 0.005) + 0.05) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_0_melee_damage_1_multiply", function(ctx)
    return (((ctx.spell_levels["telepathic_network"] * 0.005) + 0.05) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_0_melee_damage_2_multiply", function(ctx)
    return (((ctx.spell_levels["telepathic_network"] * 0.005) + 0.05) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telepath_network_effect_0",
    native_modifier_order = true,
}
    :melee_damage("bash", { multiply_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_0_melee_damage_0_multiply", load_skills = {  }, load_spell_levels = { "telepathic_network" } })
    :melee_damage("cut", { multiply_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_0_melee_damage_1_multiply", load_skills = {  }, load_spell_levels = { "telepathic_network" } })
    :melee_damage("stab", { multiply_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_0_melee_damage_2_multiply", load_skills = {  }, load_spell_levels = { "telepathic_network" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_0_add", function(ctx)
    return (1 + ((ctx.spell_levels["telepathic_network"] / 12) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_1_add", function(ctx)
    return (1 + ((ctx.spell_levels["telepathic_network"] / 12) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence)))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_2_add", function(ctx)
    return (((ctx.spell_levels["telepathic_network"] * 0.2) + 1) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_3_add", function(ctx)
    return (((ctx.spell_levels["telepathic_network"] * 0.25) + 3) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_4_multiply", function(ctx)
    return (((ctx.spell_levels["telepathic_network"] * 0.005) + 0.05) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_5_multiply", function(ctx)
    return (((ctx.spell_levels["telepathic_network"] * 0.005) + 0.05) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_6_multiply", function(ctx)
    return (((ctx.spell_levels["telepathic_network"] * 0.25) + 1.5) * ccb.runtime.call_number("attribute_scaling", ctx.stats.intelligence))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telepath_network_effect_1",
    native_modifier_order = true,
}
    :value("BONUS_DODGE", { add_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_0_add", load_skills = {  }, load_spell_levels = { "telepathic_network" } })
    :value("BONUS_BLOCK", { add_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_1_add", load_skills = {  }, load_spell_levels = { "telepathic_network" } })
    :value("PERCEPTION", { add_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_2_add", load_skills = {  }, load_spell_levels = { "telepathic_network" } })
    :value("RANGE", { add_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_3_add", load_skills = {  }, load_spell_levels = { "telepathic_network" } })
    :value("EVASION", { multiply_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_4_multiply", load_skills = {  }, load_spell_levels = { "telepathic_network" } })
    :value("RANGED_DAMAGE", { multiply_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_5_multiply", load_skills = {  }, load_spell_levels = { "telepathic_network" } })
    :value("COMBAT_CATCHUP", { multiply_handler = "shared_enchantment_inline_ench_effect_telepath_network_effect_1_value_6_multiply", load_skills = {  }, load_spell_levels = { "telepathic_network" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_teleport_ephemeral_walk_0_value_0_add", function(ctx)
    return math.max((((ctx.spell_levels["teleport_ephemeral_walk"] * 0.1) + 1) * power_modifier(ctx)), 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_teleport_ephemeral_walk_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("PHASE_DISTANCE", { add_handler = "shared_enchantment_inline_ench_effect_teleport_ephemeral_walk_0_value_0_add", load_skills = {  }, load_spell_levels = { "teleport_ephemeral_walk" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_teleport_stride_0_value_0_multiply", function(ctx)
    return math.max((((ctx.spell_levels["teleport_stride"] * (-0.02)) - 0.05) * power_modifier(ctx)), (-0.6))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_teleport_stride_0", function(ctx)
    return (not (ctx.character_inputs.effects["effect_clair_astral_projection"]) and
        not (ctx.character_inputs.effects["effect_biokin_perfected_motion"]) and
        not (ctx.character_inputs.effects["effect_mom_tindalos_hounds_corrupted_stride"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_teleport_stride_0",
    condition_handler = "shared_enchantment_active_inline_ench_effect_teleport_stride_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, effects = { "effect_biokin_perfected_motion", "effect_clair_astral_projection", "effect_mom_tindalos_hounds_corrupted_stride" }, stats = true },
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply_handler = "shared_enchantment_inline_ench_effect_teleport_stride_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "teleport_stride" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_teleport_warped_strikes_0_value_0_add", function(ctx)
    return math.max(1, (((ctx.spell_levels["teleport_warped_strikes"] * 0.2) + 1) * power_modifier(ctx)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_teleport_warped_strikes_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("MELEE_RANGE_MODIFIER", { add_handler = "shared_enchantment_inline_ench_effect_teleport_warped_strikes_0_value_0_add", load_skills = {  }, load_spell_levels = { "teleport_warped_strikes" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_teleport_warper_combat_0_value_0_add", function(ctx)
    return math.min(((ctx.spell_levels["teleport_warper_combat"] * 0.2) * power_modifier(ctx)), 4)
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_teleport_warper_combat_0_value_1_add", function(ctx)
    return (((ctx.spell_levels["teleport_warper_combat"] * 0.025) + 0.1) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_teleport_warper_combat_0_value_2_add", function(ctx)
    return math.min((((ctx.spell_levels["teleport_warper_combat"] * 0.25) + 1) * power_modifier(ctx)), 4)
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_teleport_warper_combat_0_melee_damage_0_multiply", function(ctx)
    return (((ctx.spell_levels["teleport_warper_combat"] * 0.03) + 0.05) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_teleport_warper_combat_0_melee_damage_1_multiply", function(ctx)
    return (((ctx.spell_levels["teleport_warper_combat"] * 0.03) + 0.05) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_teleport_warper_combat_0_melee_damage_2_multiply", function(ctx)
    return (((ctx.spell_levels["teleport_warper_combat"] * 0.03) + 0.05) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_active_inline_ench_effect_teleport_warper_combat_0", function(ctx)
    return (not (ctx.character_inputs.character_flags["DIMENSIONAL_ANCHOR"]) and
        not (ctx.character_inputs.worn_flags["DIMENSIONAL_ANCHOR"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_teleport_warper_combat_0",
    condition_handler = "shared_enchantment_active_inline_ench_effect_teleport_warper_combat_0",
    load_character_inputs = { character_flags = { "DIMENSIONAL_ANCHOR" }, character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true, worn_flags = { "DIMENSIONAL_ANCHOR" } },
    native_modifier_order = true,
}
    :value("MELEE_TO_HIT", { add_handler = "shared_enchantment_inline_ench_effect_teleport_warper_combat_0_value_0_add", load_skills = {  }, load_spell_levels = { "teleport_warper_combat" } })
    :value("RANGE_DODGE", { add_handler = "shared_enchantment_inline_ench_effect_teleport_warper_combat_0_value_1_add", load_skills = {  }, load_spell_levels = { "teleport_warper_combat" } })
    :value("BONUS_DODGE", { add_handler = "shared_enchantment_inline_ench_effect_teleport_warper_combat_0_value_2_add", load_skills = {  }, load_spell_levels = { "teleport_warper_combat" } })
    :value("EVASION", { add = 0.15 })
    :value("PERCEPTION", { add = -4 })
    :melee_damage("bash", { multiply_handler = "shared_enchantment_inline_ench_effect_teleport_warper_combat_0_melee_damage_0_multiply", load_skills = {  }, load_spell_levels = { "teleport_warper_combat" } })
    :melee_damage("cut", { multiply_handler = "shared_enchantment_inline_ench_effect_teleport_warper_combat_0_melee_damage_1_multiply", load_skills = {  }, load_spell_levels = { "teleport_warper_combat" } })
    :melee_damage("stab", { multiply_handler = "shared_enchantment_inline_ench_effect_teleport_warper_combat_0_melee_damage_2_multiply", load_skills = {  }, load_spell_levels = { "teleport_warper_combat" } })
    :mutation("GENERIC_UNCANNY_DODGE_TRAIT")
    :hit_me({ id = "teleport_warper_combat_warp_chance_attacked", self = true, trigger_once_in = 3 })
    :hit_you({ id = "teleport_warper_combat_warp_chance_attacker", self = false, trigger_once_in = 3 }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_0_value_0_multiply", function(ctx)
    return clamp((((ctx.spell_levels["vita_slow_bleeding"] * (-0.03)) + (-0.15)) * power_modifier(ctx)), (-0.99), 0)
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_0_value_1_multiply", function(ctx)
    return (((ctx.spell_levels["vita_slow_bleeding"] * 0.05) + 0.15) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vitakin_slow_bleeding_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("BLEEDING_RATE", { multiply_handler = "shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "vita_slow_bleeding" } })
    :value("BLEED_STOP_BONUS", { multiply_handler = "shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "vita_slow_bleeding" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_vita_increase_hp_0_value_0_multiply", function(ctx)
    return (((ctx.spell_levels["vita_increased_hp"] * 0.02) + 0.15) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vita_increase_hp_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("MAX_HP", { multiply_handler = "shared_enchantment_inline_ench_effect_vita_increase_hp_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "vita_increased_hp" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_vitakin_healing_trance_0_value_0_multiply", function(ctx)
    return (((ctx.spell_levels["vita_healing_trance"] * 0.75) + 4) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_vitakin_healing_trance_0_value_1_multiply", function(ctx)
    return (((ctx.spell_levels["vita_healing_trance"] * 0.25) + 1) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vitakin_healing_trance_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("REGEN_HP", { multiply_handler = "shared_enchantment_inline_ench_effect_vitakin_healing_trance_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "vita_healing_trance" } })
    :value("MENDING_MODIFIER", { multiply_handler = "shared_enchantment_inline_ench_effect_vitakin_healing_trance_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "vita_healing_trance" } })
    :value("REGEN_HP_AWAKE", { multiply = 1 }))

-- obsolete/effects.json
ccb.runtime.handler("shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_01_0_value_0_multiply", function(ctx)
    return (((ctx.spell_levels["vita_slow_bleeding"] * (-0.03)) + (-0.33)) * power_modifier(ctx))
end)

ccb.runtime.handler("shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_01_0_value_1_multiply", function(ctx)
    return (((ctx.spell_levels["vita_slow_bleeding"] * 0.05) + 0.15) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vitakin_slow_bleeding_01_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("BLEEDING_RATE", { multiply_handler = "shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_01_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "vita_slow_bleeding" } })
    :value("BLEED_STOP_BONUS", { multiply_handler = "shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_01_0_value_1_multiply", load_skills = {  }, load_spell_levels = { "vita_slow_bleeding" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_02_0_value_0_multiply", function(ctx)
    return (((ctx.spell_levels["vita_slow_bleeding"] * 0.05) + 0.15) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vitakin_slow_bleeding_02_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("BLEED_STOP_BONUS", { multiply_handler = "shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_02_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "vita_slow_bleeding" } }))

ccb.runtime.handler("shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_03_0_value_0_multiply", function(ctx)
    return (((ctx.spell_levels["vita_slow_bleeding"] * 0.05) + 0.15) * power_modifier(ctx))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_vitakin_slow_bleeding_03_0",
    load_character_inputs = { character_variables = { "nether_attunement_power_scaling" }, effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" }, stats = true },
    native_modifier_order = true,
}
    :value("BLEED_STOP_BONUS", { multiply_handler = "shared_enchantment_inline_ench_effect_vitakin_slow_bleeding_03_0_value_0_multiply", load_skills = {  }, load_spell_levels = { "vita_slow_bleeding" } }))
