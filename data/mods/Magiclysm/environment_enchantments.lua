local ccb = require("ccb")
local content = ccb.content

-- effects/effects.json
ccb.runtime.handler("context_enchantment_inline_ench_effect_ethereal_grasp_0_value_0_add", function(ctx)
    return (((-30) + (ctx.character_inputs.character_variables["ethereal_grasp_affected_level"] * (-4))) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_ethereal_grasp_0", function(ctx)
    return (ctx.character_inputs.physiology.body_size <= 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_ethereal_grasp_0",
    load_character_inputs = { character_variables = { "ethereal_grasp_affected_level", "evocation_spell_affected_proficiency" }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_effect_ethereal_grasp_0_value_0_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_inline_ench_effect_ethereal_grasp_1_value_0_add", function(ctx)
    return (((-20) + (ctx.character_inputs.character_variables["ethereal_grasp_affected_level"] * (-3))) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_ethereal_grasp_1", function(ctx)
    return (ctx.character_inputs.physiology.body_size == 2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_ethereal_grasp_1",
    load_character_inputs = { character_variables = { "ethereal_grasp_affected_level", "evocation_spell_affected_proficiency" }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_effect_ethereal_grasp_1_value_0_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_inline_ench_effect_ethereal_grasp_2_value_0_add", function(ctx)
    return (((-10) + (ctx.character_inputs.character_variables["ethereal_grasp_affected_level"] * (-2))) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_ethereal_grasp_2", function(ctx)
    return (ctx.character_inputs.physiology.body_size == 3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_2",
    condition_handler = "context_enchantment_active_inline_ench_effect_ethereal_grasp_2",
    load_character_inputs = { character_variables = { "ethereal_grasp_affected_level", "evocation_spell_affected_proficiency" }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_effect_ethereal_grasp_2_value_0_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_inline_ench_effect_ethereal_grasp_3_value_0_add", function(ctx)
    return (((-5) + (ctx.character_inputs.character_variables["ethereal_grasp_affected_level"] * (-1))) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_ethereal_grasp_3", function(ctx)
    return (ctx.character_inputs.physiology.body_size == 4)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_3",
    condition_handler = "context_enchantment_active_inline_ench_effect_ethereal_grasp_3",
    load_character_inputs = { character_variables = { "ethereal_grasp_affected_level", "evocation_spell_affected_proficiency" }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_effect_ethereal_grasp_3_value_0_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_0", function(ctx)
    return (ctx.character_inputs.physiology.body_size == 1)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_monster_0",
    condition_handler = "context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_0",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add = -60 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_1", function(ctx)
    return (ctx.character_inputs.physiology.body_size == 2)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_monster_1",
    condition_handler = "context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_1",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add = -40 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_2", function(ctx)
    return (ctx.character_inputs.physiology.body_size == 3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_monster_2",
    condition_handler = "context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_2",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add = -30 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_3", function(ctx)
    return (ctx.character_inputs.physiology.body_size == 4)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_monster_3",
    condition_handler = "context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_3",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add = -15 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_4", function(ctx)
    return (ctx.character_inputs.physiology.body_size == 5)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ethereal_grasp_monster_4",
    condition_handler = "context_enchantment_active_inline_ench_effect_ethereal_grasp_monster_4",
    load_character_inputs = { physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add = -5 }))

ccb.runtime.handler("context_enchantment_inline_ench_entangled_1_value_0_add", function(ctx)
    return (((-20) + (ctx.character_inputs.character_variables["vegetative_grasp_affected_level"] * (-4))) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_entangled_1", function(ctx)
    return ((ctx.character_inputs.physiology.body_size == 1) and
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_entangled_1",
    condition_handler = "context_enchantment_active_inline_ench_entangled_1",
    load_character_inputs = { character_variables = { "evocation_spell_affected_proficiency", "vegetative_grasp_affected_level" }, environment = { terrain_flags = { "DIGGABLE" } }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_entangled_1_value_0_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_inline_ench_entangled_2_value_0_add", function(ctx)
    return (((-15) + (ctx.character_inputs.character_variables["vegetative_grasp_affected_level"] * (-3))) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_entangled_2", function(ctx)
    return ((ctx.character_inputs.physiology.body_size == 2) and
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_entangled_2",
    condition_handler = "context_enchantment_active_inline_ench_entangled_2",
    load_character_inputs = { character_variables = { "evocation_spell_affected_proficiency", "vegetative_grasp_affected_level" }, environment = { terrain_flags = { "DIGGABLE" } }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_entangled_2_value_0_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_inline_ench_entangled_3_value_0_add", function(ctx)
    return (((-5) + (ctx.character_inputs.character_variables["vegetative_grasp_affected_level"] * (-2))) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_entangled_3", function(ctx)
    return ((ctx.character_inputs.physiology.body_size == 3) and
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_entangled_3",
    condition_handler = "context_enchantment_active_inline_ench_entangled_3",
    load_character_inputs = { character_variables = { "evocation_spell_affected_proficiency", "vegetative_grasp_affected_level" }, environment = { terrain_flags = { "DIGGABLE" } }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_entangled_3_value_0_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_inline_ench_entangled_4_value_0_add", function(ctx)
    return ((ctx.character_inputs.character_variables["vegetative_grasp_affected_level"] * (-1)) * ctx.character_inputs.character_variables["evocation_spell_affected_proficiency"])
end)

ccb.runtime.handler("context_enchantment_active_inline_ench_entangled_4", function(ctx)
    return ((ctx.character_inputs.physiology.body_size == 4) and
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_entangled_4",
    condition_handler = "context_enchantment_active_inline_ench_entangled_4",
    load_character_inputs = { character_variables = { "evocation_spell_affected_proficiency", "vegetative_grasp_affected_level" }, environment = { terrain_flags = { "DIGGABLE" } }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add_handler = "context_enchantment_inline_ench_entangled_4_value_0_add", load_skills = {  } }))

ccb.runtime.handler("context_enchantment_active_inline_ench_entangled_monster_0", function(ctx)
    return ((ctx.character_inputs.physiology.body_size == 1) and
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_entangled_monster_0",
    condition_handler = "context_enchantment_active_inline_ench_entangled_monster_0",
    load_character_inputs = { environment = { terrain_flags = { "DIGGABLE" } }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add = -40 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_entangled_monster_1", function(ctx)
    return ((ctx.character_inputs.physiology.body_size == 2) and
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_entangled_monster_1",
    condition_handler = "context_enchantment_active_inline_ench_entangled_monster_1",
    load_character_inputs = { environment = { terrain_flags = { "DIGGABLE" } }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add = -30 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_entangled_monster_2", function(ctx)
    return ((ctx.character_inputs.physiology.body_size == 3) and
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_entangled_monster_2",
    condition_handler = "context_enchantment_active_inline_ench_entangled_monster_2",
    load_character_inputs = { environment = { terrain_flags = { "DIGGABLE" } }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add = -20 }))

ccb.runtime.handler("context_enchantment_active_inline_ench_entangled_monster_3", function(ctx)
    return ((ctx.character_inputs.physiology.body_size == 4) and
        ctx.character_inputs.environment.terrain_flags["DIGGABLE"])
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_entangled_monster_3",
    condition_handler = "context_enchantment_active_inline_ench_entangled_monster_3",
    load_character_inputs = { environment = { terrain_flags = { "DIGGABLE" } }, physiology = true },
    native_modifier_order = true,
}
    :value("SPEED", { add = -10 }))

-- mutations/mutation_paths/fantasy_species.json
ccb.runtime.handler("context_enchantment_active_inline_ench_elven_sight_0", function(ctx)
    return (ctx.character_inputs.environment.outside and
        (ctx.character_inputs.environment.weather == "clear" or
        ctx.character_inputs.environment.weather == "sunny"))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ELVEN_SIGHT_0",
    condition_handler = "context_enchantment_active_inline_ench_elven_sight_0",
    load_character_inputs = { environment = { outside = true, weather = true } },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add = 20 })
    :value("OVERMAP_SIGHT", { add = 6 })
    :effect("effect_magiclysm_craft_in_darkness", 1))

ccb.runtime.handler("context_enchantment_active_inline_ench_elven_sight_3", function(ctx)
    return (not (ctx.character_inputs.environment.outside) and
        (ctx.character_inputs.fine_detail_vision <= 7))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_ELVEN_SIGHT_3",
    condition_handler = "context_enchantment_active_inline_ench_elven_sight_3",
    load_character_inputs = { environment = { outside = true }, fine_detail_vision = true },
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add = 6 })
    :effect("effect_magiclysm_craft_in_darkness", 1))

ccb.runtime.handler("context_enchantment_active_inline_ench_lizardfolk_build_1", function(ctx)
    return ctx.character_inputs.traits["SCALES"]
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_LIZARDFOLK_BUILD_1",
    condition_handler = "context_enchantment_active_inline_ench_lizardfolk_build_1",
    load_character_inputs = { traits = { "SCALES" } },
    native_modifier_order = true,
}
    :encumbrance("mouth", { add = -1 }))
