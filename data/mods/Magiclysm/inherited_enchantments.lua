local content = require("ccb").content

-- mutations/mutation_paths/fantasy_species.json
content.add(content.Enchantment { id = "INLINE_ENCH_LIZARDFOLK_BUILD_2" }
    :value("MOVECOST_SWIM_MOD", { multiply = -0.1 })
    :value("STRENGTH", { add = 1 })
    :value("DEXTERITY", { add = 1 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 0.25 })
    :value("CARRY_WEIGHT", { multiply = 0.05 }))
