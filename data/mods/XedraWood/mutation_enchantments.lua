local content = require("ccb").content

-- mutations/nonhuman_species.json
content.add(content.Enchantment { id = "INLINE_ENCH_STRONGER_RESISTWARM_LIZ_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_CHILL", { add = 25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_REGEN_LIZARDFOLK_0" }
    :value("MENDING_MODIFIER", { multiply = 19 })
    :value("REGEN_HP", { multiply = 0.5 })
    :value("REGEN_HP_AWAKE", { multiply = 0.2 }))

-- player/traits.json
content.add(content.Enchantment { id = "INLINE_ENCH_XEDRA_WOOD_COMPUTER_ILLITERATE_0" }
    :skill("computer", { multiply = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_TATTOOS_BASIC_TRAIT_0", condition = "ALWAYS" }
    :value("POWER_TRICKLE", { add = 100 }))
