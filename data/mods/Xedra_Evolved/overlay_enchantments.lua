local ccb = require("ccb")
local content = ccb.content

-- effects/effects.json
content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_effect_flame_immunity_0",
    native_modifier_order = true,
}
    :value("CLIMATE_CONTROL_CHILL", { add = 1000 })
    :incoming_damage("heat", { add = -1000 }))

-- obsoletion_and_migration/effects.json
content.upsert_enchantment(content.Enchantment {
    id = "INLINE_ENCH_haste_0",
    native_modifier_order = true,
}
    :value("MOVE_COST", { multiply = -0.7 })
    :value("ATTACK_SPEED", { multiply = -0.7 }))
