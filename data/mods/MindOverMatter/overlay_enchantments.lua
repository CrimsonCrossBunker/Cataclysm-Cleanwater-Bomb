local ccb = require("ccb")
local content = ccb.content

-- effects/effects_monster.json
content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_effect_monster_heightened_reflex_enhanced_0",
    native_modifier_order = true,
}
    :value("VISION_RANGE", { multiply = 0.2 })
    :value("SPEED", { multiply = 0.35 })
    :value("RANGE_DODGE", { add = 0.15 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_effect_photokinetic_illuminate_enemy_0",
    native_modifier_order = true,
}
    :value("LUMINATION", { add = 35 }))

-- mutations/mutation_overrides.json
ccb.runtime.handler("overlay_enchantment_active_inline_ench_interstice_resonance_2_0", function(ctx)
    return ctx.character_inputs.environment.dimension == "default"
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_INTERSTICE_RESONANCE_2_0",
    condition_handler = "overlay_enchantment_active_inline_ench_interstice_resonance_2_0",
    load_character_inputs = { environment = { dimension = true } },
    native_modifier_order = true,
}
    :value("ARTIFACT_RESONANCE", { add = 1250 })
    :effect("psi_nether_attention", 1))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_INTERSTICE_RESONANCE_3_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("ARTIFACT_RESONANCE", { add = 1250 })
    :effect("psi_nether_attention", 3))
