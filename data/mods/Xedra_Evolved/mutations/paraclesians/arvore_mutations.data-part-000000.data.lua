local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_SKIN_1",
    name = ccb.content.text("Viridian Skin"),
    points = 0,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Your skin has turned the color of spring growth.  Your skin is now a viridian green.  This has no gameplay effects."),
    types = { "SKIN" },
    additions = { "ARVORE_SKIN_2" },
    categories = { "ARVORE" },
}

ccb.content.define_mutation {
    id = "ARVORE_SKIN_2",
    name = ccb.content.text("Vegetal Cuticle"),
    points = 2,
    visibility = 2,
    ugliness = 1,
    description = ccb.content.text("Your skin has turned into a type of plant matter, which in addition to any armoring slows your loss of fluids."),
    types = { "SKIN" },
    categories = { "ARVORE" },
    purifiable = false,
    prerequisites = { "ARVORE_SKIN_1" },
    replacements = { "ARVORE_SKIN_3" },
    enchantments = { "INLINE_ENCH_ARVORE_SKIN_2_0" },
    integrated_armor = { "integrated_vegital_cuticle" },
    flags = { "TOUGH_FEET" },
}

ccb.content.define_mutation {
    id = "ARVORE_SKIN_3",
    name = ccb.content.text("Bark Skin"),
    points = 3,
    visibility = 8,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("The skin on your body has grown into a barklike state.  This provides significantly more armor but reduces flexibility."),
    types = { "SKIN" },
    prerequisites = { "ARVORE_SKIN_2" },
    threshold_requirements = { "THRESH_ARVORE" },
    categories = { "ARVORE" },
    purifiable = false,
    wet_protection = {
        { part = "head", ignored = 5 },
        { part = "leg_l", ignored = 16 },
        { part = "leg_r", ignored = 16 },
        { part = "foot_l", ignored = 5 },
        { part = "foot_r", ignored = 5 },
        { part = "arm_l", ignored = 14 },
        { part = "arm_r", ignored = 14 },
        { part = "hand_l", ignored = 4 },
        { part = "hand_r", ignored = 4 },
        { part = "torso", ignored = 30 },
    },
    integrated_armor = { "integrated_bark_skin" },
    flags = { "TOUGH_FEET", "BARKY" },
}

-- This needs its own ID to be only a type SKIN mutation
ccb.content.define_mutation {
    id = "JAUNDICE_ARVORE_ALCHEMY",
    name = ccb.content.text("Jaundice"),
    points = 0,
    vitamin_cost = 60,
    visibility = 1,
    ugliness = 1,
    purifiable = false,
    description = ccb.content.text("It's subtle, but your skin has definitely taken on a sickly yellow-green hue."),
    types = { "SKIN" },
    categories = { "ARVORE_ALCHEMY" },
}

ccb.content.define_mutation {
    id = "ARVORE_MOSS",
    name = ccb.content.text("Patches of Moss"),
    points = 1,
    purifiable = false,
    visibility = 5,
    ugliness = 3,
    body_temperature = { 250, 600 },
    enchantments = { "INLINE_ENCH_ARVORE_MOSS_0" },
    wet_protection = {
        { part = "head", neutral = 4, good = 5 },
        { part = "leg_l", neutral = 8, good = 15 },
        { part = "leg_r", neutral = 8, good = 15 },
        { part = "foot_l", neutral = 3, good = 5 },
        { part = "foot_r", neutral = 3, good = 5 },
        { part = "arm_l", neutral = 8, good = 14 },
        { part = "arm_r", neutral = 8, good = 14 },
        { part = "hand_l", neutral = 3, good = 4 },
        { part = "hand_r", neutral = 3, good = 4 },
        { part = "torso", neutral = 15, good = 27 },
    },
    description = ccb.content.text("A viridian moss has grown on your skin, forming whorls and eldritch patterns, providing some protection from the cold and the wet.  It also provides a small amount of armor against acid or fire."),
    armor = { { part_types = { "ALL" }, resistances = { acid = 2, heat = 4 } } },
    prerequisites = { "ARVORE_SKIN_2", "ARVORE_SKIN_3" },
    categories = { "ARVORE" },
}

ccb.content.define_mutation {
    id = "ARVORE_TRIFFID_NEUTRALITY",
    name = ccb.content.text("Pact of the Green"),
    description = ccb.content.text("You are in tune with the forest and the triffids will allow you safe passage in their lands, so long as you do not harm them."),
    valid = false,
    points = 3,
    visibility = 0,
    ugliness = 0,
    species_anger = { PLANT = -100 },
}

ccb.content.define_mutation {
    id = "GREENSTRIDE",
    name = ccb.content.text("Greenstride"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The trees recognize you as one of their own and allow you to pass easily beneath their boughs.  The grass moves under your feet to speed your passage, and shrubs bend out of the way.  When walking on grass, trees, or other natural foliage, your movement speed is increased."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    additions = { "ARVORE_DEX_BONUS" },
    replacements = { "GREENSTRIDE_UPGRADE" },
    enchantments = { "INLINE_ENCH_GREENSTRIDE_0" },
}

ccb.content.define_mutation {
    id = "GREENSTRIDE_UPGRADE",
    name = ccb.content.text("Forestwalker"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The trees recognize you as one of their own and allow you to pass easily beneath their boughs.  The grass moves under your feet to speed your passage, and shrubs bend out of the way.  When walking on grass, trees, or other natural foliage, your movement speed is increased.  In addition, when in a forest, the trees bend out of your way, allowing you to pass"),
    categories = { "ARVORE" },
    purifiable = false,
    prerequisites = { "ARVORE_DEX_BONUS" },
    secondary_prerequisites = { "ARVORE_FOREST_DETECT_AND_OVERMAP" },
    enchantments = { "INLINE_ENCH_GREENSTRIDE_UPGRADE_0", "INLINE_ENCH_GREENSTRIDE_UPGRADE_1" },
}

-- This only causes growth in existing plants.  Growing new plants from nothing should be advanced mutations/spells.
ccb.content.define_mutation {
    id = "ARVORE_NURTURING_THE_GREEN",
    name = ccb.content.text("Nurturing the Green"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Arvore may greatly speed plant growth.  With enough practice, you will even be able to bring forth mighty trees from the dry earth."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    spells_learned = { arvore_nurture_the_green = 1 },
}
