local content = require("ccb").content

-- npcs.json
content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_FLIMSY_0" }
    :value("MAX_HP", { multiply = -0.999 }))

content.add(content.Enchantment { id = "INLINE_ENCH_DEBUG_FLIMSY2_0" }
    :value("MAX_HP", { multiply = -0.99 }))
