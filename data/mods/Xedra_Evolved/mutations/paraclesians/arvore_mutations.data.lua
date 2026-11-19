local ccb = require("ccb")

-- Healing values copied from the Regeneration mutation
-- NETHER_EMANATION missing from the above list is deliberate--they hone in on mental activity and the transformed Arvore still thinks.
ccb.content.define_mutation {
    id = "ARVORE_TREE_FORM_TRAITS",
    name = ccb.content.text("Ancient Tree"),
    points = 10,
    description = ccb.content.text("You are a tree.  You will heal much more quickly and resting is more beneficial.  You are unable to see, hear, or move, but have a dim awareness of nearby movement."),
    valid = false,
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    appearance = { id = "t_tree", tile_category = "terrain" },
    flags = {
        "DEAF", "BLIND", "SEESLEEP", "NO_SCENT", "NO_SPELLCASTING", "IMMUNE_HEARING_DAMAGE",
        "CANNOT_MOVE", "CANNOT_ATTACK", "SUFFOCATION_IMMUNE", "CANNOT_CONSUME_DRUGS",
    },
    wet_protection = {
        { part = "head", ignored = 40 },
        { part = "leg_l", ignored = 40 },
        { part = "leg_r", ignored = 40 },
        { part = "foot_l", ignored = 40 },
        { part = "foot_r", ignored = 40 },
        { part = "arm_l", ignored = 40 },
        { part = "arm_r", ignored = 40 },
        { part = "hand_l", ignored = 40 },
        { part = "hand_r", ignored = 40 },
        { part = "torso", ignored = 40 },
    },
    ignored_by = {
        "MAMMAL", "AMPHIBIAN", "MUTANT", "CYBORG", "REPTILE", "FISH", "KRAKEN", "MIGO", "SLIME",
        "LEECH_PLANT", "INSECT", "CENTIPEDE", "INSECT_FLYING", "SPIDER", "BIRD", "MOLLUSK", "WORM",
        "ZOMBIE", "NETHER", "PLANT", "FERAL", "ROBOT", "HORROR", "ABERRATION", "HUMAN", "VAMPIRE",
        "NIGHTMARE", "HOMULLUS",
    },
    enchantments = { "INLINE_ENCH_ARVORE_TREE_FORM_TRAITS_0" },
}

-- No messages so you aren't constantly spammed while you're walking in and out of buildings.  Being a fae spirit, the arvore doesn't need uncovered arms or head or anything--simply being in the sun is enough.
ccb.content.define_mutation {
    id = "ARVORE_SUN_MANA_BONUS",
    name = ccb.content.text("Solar Empowerment"),
    points = 10,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like a tree, you are fueled by the sun.  When standing in the sunlight, you will absorb its energy as nutrients, heal slightly faster, your mana regenerates much quicker, and you gain a bonus to your maximum mana."),
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    types = { "METABOLISM" },
    prerequisites = { "ARVORE_SUN_NUTRIENTS_AND_MANA" },
    replacements = { "ARVORE_SUN_POWER_MANA_STATS" },
    enchantments = { "INLINE_ENCH_ARVORE_SUN_MANA_BONUS_0" },
}

-- No messages so you aren't constantly spammed while you're walking in and out of buildings.  Being a fae spirit, the arvore doesn't need uncovered arms or head or anything--simply being in the sun is enough.
ccb.content.define_mutation {
    id = "ARVORE_SUN_POWER_MANA_STATS",
    name = ccb.content.text("Solar Ascendancy"),
    points = 10,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like a tree, you are fueled by the sun.  When standing in the sunlight, you will absorb its energy as nutrients, heal slightly faster, your mana regenerates much quicker, you gain a bonus to your maximum mana, and you gain a +2 bonus to all stats."),
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    types = { "METABOLISM" },
    prerequisites = { "ARVORE_SUN_MANA_BONUS" },
    enchantments = { "INLINE_ENCH_ARVORE_SUN_POWER_MANA_STATS_0" },
}
