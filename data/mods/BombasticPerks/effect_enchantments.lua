local content = require("ccb").content

-- perkdata/bellringer.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_perk_bellringer_0" }
    :incoming_damage("bash", { multiply = -0.33 }))

-- perkdata/duck_and_weave.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_perk_duck_and_weave_0", condition = "ALWAYS" }
    :value("BONUS_DODGE", { add = 1 })
    :value("DODGE_CHANCE", { add = 5 })
    :value("RANGE_DODGE", { add = 50 }))

-- perkdata/empath.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_zombie_0", condition = "ALWAYS" }
    :value("PAIN", { multiply = -0.99 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_animal_0", condition = "ALWAYS" }
    :value("COMBAT_CATCHUP", { multiply = 4.0 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_insect_0", condition = "ALWAYS" }
    :incoming_damage("acid", { multiply = -1 })
    :incoming_damage("bash", { add = -8 })
    :incoming_damage("cut", { add = -8 })
    :incoming_damage("bullet", { add = -8 }))

-- perkdata/ewww_de_zombie.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_ewwww_de_zombie_1" }
    :mutation("TRAIT_EWWWW_DE_ZOMBIE_SCENT"))

-- perkdata/moonstruck.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_perk_moonstruck_full_0" }
    :value("STRENGTH", { add = 3 })
    :value("DEXTERITY", { add = 3 })
    :value("INTELLIGENCE", { add = 3 })
    :value("PERCEPTION", { add = 3 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_perk_moonstruck_waxing_0" }
    :value("STRENGTH", { add = 1 })
    :value("DEXTERITY", { add = 1 })
    :value("INTELLIGENCE", { add = 1 })
    :value("PERCEPTION", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_effect_perk_moonstruck_new_0" }
    :value("STRENGTH", { add = -2 })
    :value("DEXTERITY", { add = -2 })
    :value("INTELLIGENCE", { add = -2 })
    :value("PERCEPTION", { add = -2 }))

-- perkdata/popeye.json
content.add(content.Enchantment { id = "INLINE_ENCH_spinach_strength_0", condition = "ALWAYS" }
    :value("STRENGTH", { add = 2 }))

-- perkdata/second_chance.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_perk_second_chance_0", condition = "ALWAYS" }
    :value("EVASION", { add = 1 })
    :value("CLIMATE_CONTROL_HEAT", { add = 2000 })
    :value("CLIMATE_CONTROL_CHILL", { add = 2000 }))

-- perkdata/twice_shy.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_perk_twice_shy_0", condition = "ALWAYS" }
    :value("BONUS_DODGE", { add = 1 })
    :value("DODGE_CHANCE", { add = 2 }))

-- perkdata/undying_loyalty.json
content.add(content.Enchantment { id = "INLINE_ENCH_effect_perk_undying_loyalty_0" }
    :value("ARMOR_ALL", { multiply = -0.15 }))
