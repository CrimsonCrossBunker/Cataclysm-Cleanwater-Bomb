local content = require("ccb").content

-- mutations/path_mutations.json
content.add(content.Enchantment { id = "INLINE_ENCH_MORE_PSI_ALPHA_0", condition = "ALWAYS" }
    :custom("awakening_odds_traits_mod", { add = 1 }))

-- mutations/temporary.json
content.add(content.Enchantment { id = "INLINE_ENCH_PHOTOLIXIR_LIGHT_active_0" }
    :value("LUMINATION", { add = 150 }))

-- mutations/traits.json
content.add(content.Enchantment { id = "INLINE_ENCH_STRONG_LEGS_MOM_0" }
    :value("MOVE_COST", { multiply = -0.12 }))

content.add(content.Enchantment { id = "INLINE_ENCH_WEAK_MOM_0" }
    :value("STRENGTH", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_WEAK_MOM_2_0" }
    :value("STRENGTH", { add = -2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CLUMSY_MOM_0" }
    :value("DEXTERITY", { add = -1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_CLUMSY_MOM_2_0" }
    :value("DEXTERITY", { add = -2 }))
