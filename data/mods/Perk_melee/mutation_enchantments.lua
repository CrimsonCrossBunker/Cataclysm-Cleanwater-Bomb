local content = require("ccb").content

-- PERKS/perks.json
content.add(content.Enchantment { id = "INLINE_ENCH_MELEE_PERK_BLOCK_0" }
    :value("BONUS_BLOCK", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_MELEE_PERK_DODGE_0" }
    :value("BONUS_DODGE", { add = 1 }))
