local ccb = require("ccb")
local content = ccb.content

-- effects/effects.json
content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_haste_0",
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = -0.7 })
    :value("ATTACK_SPEED", { multiply = -0.7 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_effect_flame_immunity_0",
    native_modifier_order = true,
}
    :incoming_damage("heat", { multiply = -1 }))

-- mutations/mutation_paths/fantasy_species.json
ccb.runtime.handler("overlay_enchantment_active_inline_ench_lizardfolk_build_0", function(ctx)
    return ctx.character_inputs.traits["SLIT_NOSTRILS"]
end)

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_LIZARDFOLK_BUILD_0",
    condition_handler = "overlay_enchantment_active_inline_ench_lizardfolk_build_0",
    load_character_inputs = { traits = { "SLIT_NOSTRILS" } },
    native_modifier_order = true,
}
    :encumbrance("mouth", { add = -10 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_PRED_LIZ_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("COMBAT_CATCHUP", { multiply = 1.5 }))

content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_MUZZLE_LONG_LIZ_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :bodypart_change("", "mouth")
    :bodypart_change("muzzle_long", ""))
