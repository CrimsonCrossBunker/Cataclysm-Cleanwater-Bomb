local content = require("ccb").content

-- sweet_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_SUGAR_0" }
    :value("WEAKNESS_TO_WATER", { add = 5 })
    :value("FAT_TO_MAX_HP", { multiply = -0.9 })
    :value("HEALTHY_RATE", { multiply = -1 })
    :value("SWEAT_MULTIPLIER", { multiply = -1 })
    :value("THIRST", { multiply = -1 })
    :value("REGEN_HP", { multiply = -1 })
    :value("REGEN_HP_AWAKE", { multiply = 0.0 }))
