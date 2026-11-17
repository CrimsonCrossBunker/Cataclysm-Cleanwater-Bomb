local ccb = require("ccb")
local content = ccb.content

local psychic_scaling = require("psychic_enchantment_scaling")
local power_modifier = psychic_scaling.power

-- effects/effects_psionic.json
ccb.runtime.handler("progression_enchantment_inline_ench_effect_clair_better_senses_0_value_0_add", function(ctx)
    return ((((ctx.character_inputs.spell_levels["clair_better_senses"] + ctx.character_inputs.spell_levels["clair_better_senses_knack"]) / 3) + 1) * power_modifier(ctx))
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_clair_better_senses_0_value_1_add", function(ctx)
    return ((((ctx.character_inputs.spell_levels["clair_better_senses"] + ctx.character_inputs.spell_levels["clair_better_senses_knack"]) / 5) + 1) * power_modifier(ctx))
end)

ccb.runtime.handler("progression_enchantment_inline_ench_effect_clair_better_senses_0_value_2_multiply", function(ctx)
    return (((ctx.character_inputs.spell_levels["clair_better_senses"] + ctx.character_inputs.spell_levels["clair_better_senses_knack"]) * 0.25) * power_modifier(ctx))
end)

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_clair_better_senses_0", function(ctx)
    return not ((ctx.character_inputs.effects["hallu"] or ctx.character_inputs.effects["datura"] or ctx.character_inputs.effects["taint"] or ctx.character_inputs.effects["hallucination_attacks"] or ctx.character_inputs.effects["visuals"] or ctx.character_inputs.effects["fearparalyze"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_better_senses_0",
    condition_handler = "progression_enchantment_active_inline_ench_effect_clair_better_senses_0",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        effects = { "datura", "fearparalyze", "hallu", "hallucination_attacks", "taint", "visuals" },
        spell_levels = { "clair_better_senses", "clair_better_senses_knack" },
        stats = true
    },
    native_modifier_order = true,
}
    :value("PERCEPTION", {
        add_handler = "progression_enchantment_inline_ench_effect_clair_better_senses_0_value_0_add",
        load_skills = {}
    })
    :value("OVERMAP_SIGHT", {
        add_handler = "progression_enchantment_inline_ench_effect_clair_better_senses_0_value_1_add",
        load_skills = {}
    })
    :value("HEARING_MULT", {
        multiply_handler = "progression_enchantment_inline_ench_effect_clair_better_senses_0_value_2_multiply",
        load_skills = {}
    }))

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_clair_better_senses_1", function(ctx)
    return (((ctx.character_inputs.spell_levels["clair_better_senses"] + ctx.character_inputs.spell_levels["clair_better_senses_knack"]) * power_modifier(ctx)) >= 6)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_better_senses_1",
    condition_handler = "progression_enchantment_active_inline_ench_effect_clair_better_senses_1",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "clair_better_senses", "clair_better_senses_knack" },
        stats = true
    },
    native_modifier_order = true,
}
    :effect("effect_clair_better_senses_eye_membrane", 1))

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_clair_better_senses_2", function(ctx)
    return (((ctx.character_inputs.spell_levels["clair_better_senses"] + ctx.character_inputs.spell_levels["clair_better_senses_knack"]) * power_modifier(ctx)) >= 8)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_better_senses_2",
    condition_handler = "progression_enchantment_active_inline_ench_effect_clair_better_senses_2",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "clair_better_senses", "clair_better_senses_knack" },
        stats = true
    },
    native_modifier_order = true,
}
    :effect("effect_clair_better_senses_see_sleep", 1))

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_clair_better_senses_3", function(ctx)
    return (((ctx.character_inputs.spell_levels["clair_better_senses"] + ctx.character_inputs.spell_levels["clair_better_senses_knack"]) * power_modifier(ctx)) >= 10)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_better_senses_3",
    condition_handler = "progression_enchantment_active_inline_ench_effect_clair_better_senses_3",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "clair_better_senses", "clair_better_senses_knack" },
        stats = true
    },
    native_modifier_order = true,
}
    :effect("effect_clair_better_senses_safecracking", 1))

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_clair_better_senses_5", function(ctx)
    return ((ctx.character_inputs.traits["PER_SLIME"]) or
        (ctx.character_inputs.effects["hallu"] or ctx.character_inputs.effects["datura"] or ctx.character_inputs.effects["taint"] or ctx.character_inputs.effects["hallucination_attacks"] or ctx.character_inputs.effects["visuals"] or ctx.character_inputs.effects["fearparalyze"]))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_better_senses_5",
    condition_handler = "progression_enchantment_active_inline_ench_effect_clair_better_senses_5",
    load_character_inputs = {
        effects = { "datura", "fearparalyze", "hallu", "hallucination_attacks", "taint", "visuals" },
        traits = { "PER_SLIME" }
    },
    native_modifier_order = true,
}
    :effect("effect_clair_better_senses_pain", 1))

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_clair_night_eyes_1", function(ctx)
    return (ctx.character_inputs.effects["effect_clair_better_senses"] and
        not (ctx.character_inputs.effects["effect_clair_better_senses_pain"]) and
        ((ctx.character_inputs.spell_levels["clair_better_senses"] * power_modifier(ctx)) >= 8) and
        (ctx.character_inputs.fine_detail_vision <= 7))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_clair_night_eyes_1",
    condition_handler = "progression_enchantment_active_inline_ench_effect_clair_night_eyes_1",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        effects = { "effect_clair_better_senses", "effect_clair_better_senses_pain" },
        fine_detail_vision = true,
        spell_levels = { "clair_better_senses" },
        stats = true
    },
    native_modifier_order = true,
}
    :effect("effect_clair_craft_in_darkness", 1))

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_1", function(ctx)
    return (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 3)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_1", emitter = "emit_pyrokinetic_aura_1",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_1",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_2", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 3) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 6))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_2", emitter = "emit_pyrokinetic_aura_2",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_2",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_3", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 6) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 9))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_3", emitter = "emit_pyrokinetic_aura_3",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_3",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_4", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 9) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 12))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_4", emitter = "emit_pyrokinetic_aura_4",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_4",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_5", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 12) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 15))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_5", emitter = "emit_pyrokinetic_aura_5",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_5",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_6", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 15) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 18))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_6", emitter = "emit_pyrokinetic_aura_6",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_6",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_7", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 18) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 21))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_7", emitter = "emit_pyrokinetic_aura_7",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_7",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_8", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 21) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 24))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_8", emitter = "emit_pyrokinetic_aura_8",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_8",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_9", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 24) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 27))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_9", emitter = "emit_pyrokinetic_aura_9",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_9",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_10", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 27) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 30))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_10", emitter = "emit_pyrokinetic_aura_10",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_10",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_11", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 30) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 33))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_11", emitter = "emit_pyrokinetic_aura_11",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_11",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_12", function(ctx)
    return ((((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) > 33) and
        (((ctx.character_inputs.spell_levels["pyrokinetic_aura"] + ctx.character_inputs.spell_levels["pyrokinetic_aura_knack"]) * power_modifier(ctx)) <= 36))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_pyrokinetic_aura_12", emitter = "emit_pyrokinetic_aura_12",
    condition_handler = "progression_enchantment_active_inline_ench_effect_pyrokinetic_aura_12",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "pyrokinetic_aura", "pyrokinetic_aura_knack" },
        stats = true
    },
    native_modifier_order = true,
})

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_telekinetic_momentum_2", function(ctx)
    return ((ctx.character_inputs.spell_levels["telekinetic_momentum"] * power_modifier(ctx)) >= 30)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telekinetic_momentum_2",
    condition_handler = "progression_enchantment_active_inline_ench_effect_telekinetic_momentum_2",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "telekinetic_momentum" },
        stats = true
    },
    native_modifier_order = true,
}
    :effect("effect_psi_blocking_huge_attacks", 1))

ccb.runtime.handler("progression_enchantment_active_inline_ench_effect_telekinetic_armor_1", function(ctx)
    return ((ctx.character_inputs.spell_levels["telekinetic_shield"] * power_modifier(ctx)) >= 25)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_telekinetic_armor_1",
    condition_handler = "progression_enchantment_active_inline_ench_effect_telekinetic_armor_1",
    load_character_inputs = {
        character_variables = { "nether_attunement_power_scaling" },
        effect_intensities = { "weary_1", "weary_2", "weary_3", "weary_4", "weary_5", "weary_6" },
        spell_levels = { "telekinetic_shield" },
        stats = true
    },
    native_modifier_order = true,
}
    :effect("effect_psi_blocking_huge_attacks", 1))
