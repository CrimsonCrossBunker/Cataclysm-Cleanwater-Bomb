local content = require("ccb").content

-- perks.json
content.add(content.Enchantment { id = "INLINE_ENCH_perk_STR_UP_0", condition = "ALWAYS" }
    :value("STRENGTH", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_STR_UP_2_0", condition = "ALWAYS" }
    :value("STRENGTH", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_DEX_UP_0", condition = "ALWAYS" }
    :value("DEXTERITY", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_DEX_UP_2_0", condition = "ALWAYS" }
    :value("DEXTERITY", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_INT_UP_0", condition = "ALWAYS" }
    :value("INTELLIGENCE", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_INT_UP_2_0", condition = "ALWAYS" }
    :value("INTELLIGENCE", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_PER_UP_0", condition = "ALWAYS" }
    :value("PERCEPTION", { add = 1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_PER_UP_2_0", condition = "ALWAYS" }
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_mighty_thews_0", condition = "ALWAYS" }
    :effect("effect_perk_mighty_thews", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_pantherish_grace_0", condition = "ALWAYS" }
    :effect("effect_perk_pantherish_grace", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_eagle_eyes_0", condition = "ALWAYS" }
    :effect("effect_perk_eagle_eyes", 1))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_built_tough_0", condition = "ALWAYS" }
    :value("ARMOR_ALL", { multiply = -0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_thick_skin_0", condition = "ALWAYS" }
    :post_armor_damage("bash", { add = -2 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_hauler_0", condition = "ALWAYS" }
    :value("CARRY_WEIGHT", { add = 10000 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_vacationer_0", condition = "ALWAYS" }
    :value("CLIMATE_CONTROL_HEAT", { add = 10 })
    :value("CLIMATE_CONTROL_CHILL", { add = 10 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_quickdraw_0" }
    :value("OBTAIN_COST_MULTIPLIER", { multiply = -0.25 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_big_eater_0" }
    :value("CONSUME_TIME_MOD", { multiply = -0.1 })
    :value("STOMACH_SIZE_MULTIPLIER", { multiply = 0.33 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_tuck_and_roll_0", condition = "ALWAYS" }
    :value("FALL_DAMAGE", { multiply = -0.4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_surgical_strikes_0", condition = "ALWAYS" }
    :value("OVERKILL_DAMAGE", { add = 30.0 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_bloody_mess_0", condition = "ALWAYS" }
    :value("OVERKILL_DAMAGE", { add = -1000.0 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_jumpy_0", condition = "ALWAYS" }
    :value("SPEED", { multiply = 0.03 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_sleepy_0", condition = "ALWAYS" }
    :value("SLEEPY", { add = 15 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_hobbyist_0", condition = "ALWAYS" }
    :value("LEARNING_FOCUS", { add = 5.0 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_artifact_resonance_reduction_0", condition = "ALWAYS" }
    :value("ARTIFACT_RESONANCE", { add = -1500 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_safety_net_0", condition = "ALWAYS" }
    :value("FORCEFIELD", { add = 0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_lucky_dodge_0", condition = "ALWAYS" }
    :value("EVASION", { add = 0.05 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_long_shot_0", condition = "ALWAYS" }
    :value("RANGE", { add = 4 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_crafty_hands_0" }
    :value("CRAFTING_SPEED_MULTIPLIER", { multiply = 0.1 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_thickblood_0" }
    :value("BLEEDING_RATE", { multiply = -0.333 }))

content.add(content.Enchantment { id = "INLINE_ENCH_perk_hive_queen_1" }
    :value("SOCIAL_PERSUADE", { add = -5 })
    :value("SOCIAL_INTIMIDATE", { add = -5 }))
