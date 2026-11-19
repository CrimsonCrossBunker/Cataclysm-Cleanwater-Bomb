local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_FOREST_DETECT",
    name = ccb.content.text("The Forests' Warning"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_EYES" },
    replacements = { "ARVORE_FOREST_DETECT_AND_OVERMAP" },
    additions = { "ARVORE_FOREST_MAPPING" },
    description = ccb.content.text("In the whispers of the leaves and the movement of the grasses, the forest warns you of nearby creatures.  While the forest can distinguish between a bird and a zombie, some fine distinctions are still lost to it."),
    categories = { "ARVORE" },
    purifiable = false,
    enchantments = { "arvore_forest_detect_enemies" },
}

ccb.content.define_mutation {
    id = "ARVORE_FOREST_DETECT_AND_OVERMAP",
    name = ccb.content.text("The Whispers of the Leaves"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_FOREST_DETECT" },
    additions = { "ARVORE_FOREST_MAPPING" },
    description = ccb.content.text("In the whispers of the leaves and the movement of the grasses, the forest warns you of nearby creatures.  While the forest can distinguish between a bird and a zombie, some fine distinctions are still lost to it.  Also, you can see further when you're standing in a forest."),
    categories = { "ARVORE" },
    purifiable = false,
    enchantments = { "arvore_forest_detect_enemies", "arvore_forest_see_overmap" },
}

ccb.content.define_mutation {
    id = "ARVORE_VERDANT_HAIR",
    name = ccb.content.text("Verdant Hair"),
    points = 2,
    purifiable = false,
    visibility = 6,
    ugliness = -3,
    description = ccb.content.text("Your hair now has flowers and small vines and leaves growing in it.  It's pleasant to look at but has no further game effect."),
    categories = { "ARVORE" },
}

ccb.content.define_mutation {
    id = "ARVORE_FLORAL_SCENT",
    name = ccb.content.text("Floral Scent"),
    points = 4,
    visibility = 0,
    ugliness = -2,
    types = { "SCENT" },
    prerequisites = { "ARVORE_VERDANT_HAIR" },
    replacements = { "ARVORE_MIND_CONTROL_POLLEN" },
    cancels = { "SMELLY", "SMELLY2" },
    description = ccb.content.text("The flowers in your hair produce a pleasant smell, obvious without being overpowering.  You no longer smell anything like a human and other beings will react to you appropriately."),
    categories = { "ARVORE" },
    purifiable = false,
    scent_type = "sc_flower",
}
