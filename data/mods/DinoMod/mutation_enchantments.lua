local content = require("ccb").content

-- mutations/mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_THICKSKIN2_0" }
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_THICKSKIN3_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = -0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_STRONGBACKDINO_0" }
    :value("CARRY_WEIGHT", { multiply = 0.7 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TAIL_HORNED_0" }
    :value("DODGE_CHANCE", { add = 1 }))
