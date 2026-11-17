local content = require("ccb").content

-- effects/monster_effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_mon_xw_chirurgeon_sleeper_0" }
    :value("REGEN_HP", { multiply = 10 })
    :value("CLIMATE_CONTROL_HEAT", { add = 30 }))

-- effects/recipe_effects.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_xedrawood_hedge_magic_spirit_quest_completed_0" }
    :value("REGEN_MANA", { multiply = -999 }))
