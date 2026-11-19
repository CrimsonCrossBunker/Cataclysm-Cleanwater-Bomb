local ccb = require("ccb")

ccb.content.define_mutation {
    id = "CANNOT_GAIN_PSIONICS",
    name = ccb.content.text_without_extraction("Can't Become An Esper"),
    points = -4,
    description = ccb.content.text_without_extraction("You can't Become An Esper.  Oh well!"),
    valid = false,
    player_display = false,
    starting_trait = false,
    purifiable = false,
    cancels = { "ESPER", "ESPER_ADVANCEMENT_OKAY", "ESPER_STARTER_ADVANCEMENT_OKAY" },
}

ccb.content.define_mutation {
    id = "ESPER",
    name = ccb.content.text("Esper"),
    points = 0,
    description = ccb.content.text("You are an esper, capable of accessing the hidden powers of the human mind."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "ESPER_ADVANCEMENT_OKAY",
    name = ccb.content.text("Esper Legacy"),
    points = 2,
    description = ccb.content.text("One of your ancestors received noetic treatments during the Hyperspace Era and that legacy has been passed down to you…but the powers have not.  Nonetheless, you were raised with the knowledge that it was always a possibility and to avoid receiving any genetech treatments that could damage your family's esper powers."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = {
        "AFS_PHYSICAL_CAPABILITY_GENEMOD", "AFS_MENTAL_CAPABILITY_GENEMOD",
        "AFS_HEALTH_CAPABILITY_GENEMOD", "AFS_RECOVERY_CAPABILITY_GENEMOD", "AFS_BEAUTY_GENEMOD",
    },
}

ccb.content.define_mutation {
    id = "ESPER_STARTER_ADVANCEMENT_OKAY",
    name = ccb.content.text_without_extraction("Esper Advancement"),
    points = 2,
    description = ccb.content.text_without_extraction("This is the trait for the Esper scenario that lets them advance.  It exists to have a different description than Esper Legacy and is not visible during gameplay."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    cancels = {
        "AFS_PHYSICAL_CAPABILITY_GENEMOD", "AFS_MENTAL_CAPABILITY_GENEMOD",
        "AFS_HEALTH_CAPABILITY_GENEMOD", "AFS_RECOVERY_CAPABILITY_GENEMOD", "AFS_BEAUTY_GENEMOD",
    },
}

ccb.content.define_mutation {
    id = "AFS_ELECTROKINETIC",
    name = ccb.content.text_without_extraction("Spark"),
    points = 0,
    description = ccb.content.text_without_extraction("The ability to control electricity with your mind."),
    types = { "ESPER" },
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    spells_learned = { afs_classless_toggleable_concentration_end = 1 },
}

ccb.content.define_mutation {
    id = "AFS_PRECOG",
    name = ccb.content.text_without_extraction("Sybil"),
    points = 0,
    description = ccb.content.text_without_extraction("The ability to see the future."),
    types = { "ESPER" },
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    spells_learned = { afs_classless_toggleable_concentration_end = 1 },
}

ccb.content.define_mutation {
    id = "AFS_TELEKINETIC",
    name = ccb.content.text_without_extraction("Geist"),
    points = 0,
    description = ccb.content.text_without_extraction("The ability to move objects without touching them."),
    types = { "ESPER" },
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    spells_learned = { afs_classless_toggleable_concentration_end = 1 },
}

ccb.content.define_mutation {
    id = "AFS_TELEPATH",
    name = ccb.content.text_without_extraction("Whisper"),
    points = 0,
    description = ccb.content.text_without_extraction("The ability to read thoughts and influence others' minds."),
    types = { "ESPER" },
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    spells_learned = { afs_classless_toggleable_concentration_end = 1 },
}

ccb.content.define_mutation {
    id = "AFS_PRECOG_CRAFT_BONUS_01",
    name = ccb.content.text("Intuitive Artistry"),
    points = 0,
    description = ccb.content.text("Gazing into the near future lets you know what part goes where."),
    valid = false,
    craft_skill_bonuses = { electronics = 1, tailor = 1, mechanics = 1, cooking = 1, chemistry = 1, fabrication = 1 },
}

ccb.content.define_mutation {
    id = "AFS_PRECOG_CRAFT_BONUS_02",
    name = ccb.content.text_without_extraction("Intuitive Artistry"),
    points = 0,
    description = ccb.content.text_without_extraction("Gazing into the near future lets you know what part goes where."),
    valid = false,
    player_display = false,
    craft_skill_bonuses = { electronics = 2, tailor = 2, mechanics = 2, cooking = 2, chemistry = 2, fabrication = 2 },
}

ccb.content.define_mutation {
    id = "AFS_PRECOG_CRAFT_BONUS_03",
    name = ccb.content.text_without_extraction("Intuitive Artistry"),
    points = 0,
    description = ccb.content.text_without_extraction("Gazing into the near future lets you know what part goes where."),
    valid = false,
    player_display = false,
    craft_skill_bonuses = { electronics = 3, tailor = 3, mechanics = 3, cooking = 3, chemistry = 3, fabrication = 3 },
}

ccb.content.define_mutation {
    id = "AFS_PRECOG_CRAFT_BONUS_04",
    name = ccb.content.text_without_extraction("Intuitive Artistry"),
    points = 0,
    description = ccb.content.text_without_extraction("Gazing into the near future lets you know what part goes where."),
    valid = false,
    player_display = false,
    craft_skill_bonuses = { electronics = 4, tailor = 4, mechanics = 4, cooking = 4, chemistry = 4, fabrication = 4 },
}

ccb.content.define_mutation {
    id = "AFS_PRECOG_CRAFT_BONUS_05",
    name = ccb.content.text_without_extraction("Intuitive Artistry"),
    points = 0,
    description = ccb.content.text_without_extraction("Gazing into the near future lets you know what part goes where."),
    valid = false,
    player_display = false,
    craft_skill_bonuses = { electronics = 5, tailor = 5, mechanics = 5, cooking = 5, chemistry = 5, fabrication = 5 },
}

ccb.content.define_mutation {
    id = "AFS_PRECOG_CRAFT_BONUS_06",
    name = ccb.content.text_without_extraction("Intuitive Artistry"),
    points = 0,
    description = ccb.content.text_without_extraction("Gazing into the near future lets you know what part goes where."),
    valid = false,
    player_display = false,
    craft_skill_bonuses = { electronics = 6, tailor = 6, mechanics = 6, cooking = 6, chemistry = 6, fabrication = 6 },
}
