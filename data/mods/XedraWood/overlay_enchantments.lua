local ccb = require("ccb")
local content = ccb.content

-- effects/psi_effects.json
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

-- mutations/nonhuman_species.json
content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_LIZARDFOLK_BUILD_0",
    native_modifier_order = true,
}
    :value("MOVECOST_SWIM_MOD", { multiply = -0.1 })
    :value("STRENGTH", { add = 1 })
    :value("DEXTERITY", { add = 1 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 0.25 })
    :value("CARRY_WEIGHT", { multiply = 0.05 })
    :value("MAX_HP", { multiply = 0.2 }))

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
