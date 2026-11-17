local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("inline_enchantment_wielded_flags_matrix_crystal_telepathy", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.wielded_flags["MATRIX_CRYSTAL_TELEPATHY"]
end)

ccb.runtime.handler("inline_enchantment_effects_effect_biokin_enhance_mobility", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["effect_biokin_enhance_mobility"]
end)

ccb.runtime.handler("inline_enchantment_effects_effect_mom_tindalos_hounds_corrupted_stride", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["effect_mom_tindalos_hounds_corrupted_stride"]
end)

ccb.runtime.handler("inline_enchantment_not_character_flags_no_psionics", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.character_flags["NO_PSIONICS"])
end)

ccb.runtime.handler("inline_enchantment_not_effects_sleep", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.effects["sleep"])
end)

ccb.runtime.handler("inline_enchantment_effects_sleep", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["sleep"]
end)

-- effects/effects_artifact.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_mom_artifact_mind_sight_container_0",
    condition_handler = "inline_enchantment_wielded_flags_matrix_crystal_telepathy",
    load_character_inputs = { wielded_flags = { "MATRIX_CRYSTAL_TELEPATHY" } },
}
    :effect("effect_mom_artifact_mind_sight", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_mom_artifact_telepathic_shield_container_0",
    condition_handler = "inline_enchantment_wielded_flags_matrix_crystal_telepathy",
    load_character_inputs = { wielded_flags = { "MATRIX_CRYSTAL_TELEPATHY" } },
}
    :effect("effect_mom_artifact_telepathic_shield", 1))

-- effects/effects_psionic.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_biokin_combat_dance_6",
    condition_handler = "inline_enchantment_effects_effect_biokin_enhance_mobility",
    load_character_inputs = { effects = { "effect_biokin_enhance_mobility" } },
}
    :mutation("GENERIC_UNCANNY_DODGE_TRAIT"))

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_teleport_stride_1",
    condition_handler = "inline_enchantment_effects_effect_mom_tindalos_hounds_corrupted_stride",
    load_character_inputs = { effects = { "effect_mom_tindalos_hounds_corrupted_stride" } },
}
    :value("MOVE_COST", { multiply = -0.05 })
    :effect("effect_mom_tindalos_hounds_corrupted_stride_warning", 1))

-- mutations/psi_passives.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_CLAIR_SENSES_1",
    condition_handler = "inline_enchantment_not_character_flags_no_psionics",
    load_character_inputs = { character_flags = { "NO_PSIONICS" } },
}
    :effect("effect_clair_passive_sense_protection", 1))

-- mutations/scenario.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_SCEN_HEART_OF_FIRE_0",
    condition_handler = "inline_enchantment_not_effects_sleep",
    load_character_inputs = { effects = { "sleep" } },
}
    :effect("effect_scenario_heart_of_fire_awake_attunement_gain", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_SCEN_HEART_OF_FIRE_1",
    condition_handler = "inline_enchantment_effects_sleep",
    load_character_inputs = { effects = { "sleep" } },
}
    :effect("effect_scenario_heart_of_fire_asleep_attunement_gain", 1))
