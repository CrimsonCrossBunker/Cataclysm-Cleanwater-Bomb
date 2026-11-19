local ccb = require("ccb")

-- No messages so you aren't constantly spammed while you're walking in and out of buildings.  Being a fae spirit, the arvore doesn't need uncovered arms or head or anything--simply being in the sun is enough.
ccb.content.define_mutation {
    id = "ARVORE_SUN_NUTRIENTS",
    name = ccb.content.text("Solar Rejuvenation"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like a tree, you are fueled by the sun.  When standing in the sunlight, you will absorb its energy as nutrients and heal slightly faster."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    types = { "METABOLISM" },
    replacements = { "ARVORE_SUN_NUTRIENTS_AND_MANA" },
    enchantments = { "INLINE_ENCH_ARVORE_SUN_NUTRIENTS_0" },
}

-- No messages so you aren't constantly spammed while you're walking in and out of buildings.  Being a fae spirit, the arvore doesn't need uncovered arms or head or anything--simply being in the sun is enough.
ccb.content.define_mutation {
    id = "ARVORE_SUN_NUTRIENTS_AND_MANA",
    name = ccb.content.text("Solar Revitalization"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like a tree, you are fueled by the sun.  When standing in the sunlight, you will absorb its energy as nutrients, heal slightly faster, and your mana regenerates much quicker."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    types = { "METABOLISM" },
    prerequisites = { "ARVORE_SUN_NUTRIENTS" },
    replacements = { "ARVORE_SUN_MANA_BONUS" },
    enchantments = { "INLINE_ENCH_ARVORE_SUN_NUTRIENTS_AND_MANA_0" },
}

ccb.content.define_mutation {
    id = "ARVORE_MOOD_CHANGES_WITH_SEASONS",
    name = ccb.content.text("The Eternal Cycle"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    mixed_effect = true,
    description = ccb.content.text("Your energy changes with the seasons: in spring and summer, you're more awake and need less sleep, and the reverse is true in autumn and winter."),
    prerequisites = {
        "ARVORE_SUN_NUTRIENTS", "ARVORE_SUN_NUTRIENTS_AND_MANA", "ARVORE_SUN_MANA_BONUS",
        "ARVORE_SUN_POWER_MANA_STATS",
    },
    categories = { "ARVORE" },
    purifiable = false,
    enchantments = {
        "INLINE_ENCH_ARVORE_MOOD_CHANGES_WITH_SEASONS_0",
        "INLINE_ENCH_ARVORE_MOOD_CHANGES_WITH_SEASONS_1",
        "INLINE_ENCH_ARVORE_MOOD_CHANGES_WITH_SEASONS_2",
        "INLINE_ENCH_ARVORE_MOOD_CHANGES_WITH_SEASONS_3",
    },
}

ccb.content.define_mutation {
    id = "ARVORE_SUN_FOODS",
    name = ccb.content.text("Solar Repast"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_SUN_NUTRIENTS_AND_MANA", "ARVORE_SUN_MANA_BONUS", "ARVORE_SUN_POWER_MANA_STATS" },
    description = ccb.content.text("Like a tree, you draw nourishment from the sun and the soil.  When standing in the sunlight and on natural terrain, you absorb its energy as food.  You still need to drink water and you will still get hungry."),
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    types = { "DIET" },
    enchantments = { "ench_arvore_sun_foods_on" },
}

ccb.content.define_mutation {
    id = "ARVORE_PAIN_RESISTANCE",
    name = ccb.content.text("The Fallen Branch Suffers Not"),
    points = 5,
    visibility = 1,
    types = { "PAIN" },
    description = ccb.content.text("Filled with the energy of life, pain does not affect you as strongly."),
    prerequisites = { "JAUNDICE_ARVORE_ALCHEMY", "ARVORE_SKIN_1", "ARVORE_SKIN_2", "ARVORE_SKIN_3" },
    secondary_prerequisites = { "ARVORE_NURTURING_THE_GREEN" },
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_ARVORE_PAIN_RESISTANCE_0" },
}
