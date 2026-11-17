local content = require("ccb").content

-- enchantments.json
content.add(content.Enchantment { id = "melee_perk_ench_undodging", condition = "ACTIVE" }
    :value("DODGE_CHANCE", { add = -20000000 }))
