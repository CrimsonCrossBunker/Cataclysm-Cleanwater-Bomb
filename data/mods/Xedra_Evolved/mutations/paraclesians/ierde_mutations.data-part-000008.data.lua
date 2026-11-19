local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_TOUGH",
    name = ccb.content.text("Durability of the Earth"),
    points = 2,
    description = ccb.content.text("The Ierde has some of the toughness of the earth.  +15% hit points."),
    replacements = { "IERDE_TOUGH2" },
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_1", "IERDE_SKIN_2", "IERDE_SKIN_3" },
    enchantments = { "INLINE_ENCH_IERDE_TOUGH_0" },
}

ccb.content.define_mutation {
    id = "IERDE_TOUGH2",
    name = ccb.content.text("Durability of the Stone"),
    points = 5,
    description = ccb.content.text("The Ierde has some of the toughness of the stone.  +30% hit points."),
    replacements = { "IERDE_TOUGH3" },
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_2", "IERDE_SKIN_3" },
    secondary_prerequisites = { "IERDE_TOUGH" },
    enchantments = { "INLINE_ENCH_IERDE_TOUGH2_0" },
}

ccb.content.define_mutation {
    id = "IERDE_TOUGH3",
    name = ccb.content.text("Durability of the Mountain"),
    points = 9,
    description = ccb.content.text("The Ierde has the toughness of the enduring mountains.  +45% hit points."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_SKIN_3" },
    secondary_prerequisites = { "IERDE_TOUGH2" },
    enchantments = { "INLINE_ENCH_IERDE_TOUGH3_0" },
}

ccb.content.define_mutation {
    id = "IERDE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to grow a goblin fruit from a earth or stone."),
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_STR_BONUS_1",
    name = ccb.content.text("Vigor of the Soil"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    replacements = { "IERDE_STR_BONUS_2" },
    description = ccb.content.text("Like the bountiful soil, the Ierde is filled with power.  +3 Strength."),
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_STR_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "IERDE_STR_BONUS_2",
    name = ccb.content.text("Vigor of the Stone"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_STR_BONUS_1" },
    secondary_prerequisites = { "IERDE_SKIN_1", "IERDE_SKIN_2", "IERDE_SKIN_3" },
    replacements = { "IERDE_STR_BONUS_3" },
    description = ccb.content.text("Like the stone, the Ierde can withstand any punishment.  +5 Strength."),
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_STR_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "IERDE_STR_BONUS_3",
    name = ccb.content.text("Vigor of the Mountain"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_STR_BONUS_2" },
    secondary_prerequisites = { "IERDE_CARDIO2" },
    replacements = { "IERDE_STR_BONUS_4" },
    description = ccb.content.text("Like the mountain, the Ierde is unmoved by calamity.  +7 Strength."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    enchantments = { "INLINE_ENCH_IERDE_STR_BONUS_3_0" },
}

ccb.content.define_mutation {
    id = "IERDE_STR_BONUS_4",
    name = ccb.content.text("Vigor of the Bedrock"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_STR_BONUS_3" },
    secondary_prerequisites = { "IERDE_HEAL_FASTER_UNDERGROUND" },
    description = ccb.content.text("Like the bedrock, the Ierde's might can support the entire world.  +9 Strength."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    enchantments = { "INLINE_ENCH_IERDE_STR_BONUS_4_0" },
}

ccb.content.define_mutation {
    id = "IERDE_PER_BONUS",
    name = ccb.content.text("The Hills Overlook the Valleys"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_EYES" },
    description = ccb.content.text("Like an observer on a mountaintop, the Ierde sees more than most.  +3 Perception."),
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_PER_BONUS_0" },
}

ccb.content.define_mutation {
    id = "IERDE_FEEL_NO_PAIN",
    name = ccb.content.text("The Mountain Is Unflinching"),
    points = 12,
    description = ccb.content.text("While on living earth or stone or underground, the Ierde is as impassive as the mountains and feels no pain at all."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_FEEL_HALF_PAIN" },
    enchantments = { "INLINE_ENCH_IERDE_FEEL_NO_PAIN_0" },
}

ccb.content.define_mutation {
    id = "IERDE_NO_DISEASE_OR_PARA",
    name = ccb.content.text("The Stone Does Not Rot"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_STR_BONUS_3", "IERDE_STR_BONUS_4" },
    description = ccb.content.text("The stones do not rot as the trees or humans do, and neither is the Ierde affected by the frailties of the flesh.  They are immune to disease and cannot suffer from parasites."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    flags = { "PARAIMMUNE", "NO_DISEASE" },
}

ccb.content.define_mutation {
    id = "IERDE_NO_MIND_PROBLEMS",
    name = ccb.content.text("Mind of Iron"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_PER_BONUS" },
    secondary_prerequisites = { "IERDE_CARDIO3" },
    description = ccb.content.text("The Ierde's mind has the resilience of iron, and they cannot be affected by delusions, hallucinations, or other mental problems."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    enchantments = { "ench_ierde_no_mind_problems" },
}
