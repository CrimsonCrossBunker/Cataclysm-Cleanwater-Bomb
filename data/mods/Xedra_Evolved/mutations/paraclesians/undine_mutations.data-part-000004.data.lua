local ccb = require("ccb")

ccb.content.define_mutation {
    id = "UNDINE_STR_UP_1",
    name = ccb.content.text("Waves Erode the Stones"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Even the weakest waves will erode the strongest rock, given enough time.  +1 Strength."),
    prerequisites = { "UNDINE_WATER_PUSH_AWAY" },
    replacements = { "UNDINE_STR_UP_2" },
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_STR_UP_1_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_STR_UP_2",
    name = ccb.content.text("Waves Erode the Shore"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Year by year, meter by meter, the waves gradually erode the beaches.  +3 Strength."),
    prerequisites = { "UNDINE_STR_UP_1" },
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_STR_UP_2_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_DEX_UP_1",
    name = ccb.content.text("Grace of the Creek"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Undine's flexibility has increased, allowing them to move in increasingly more fluid ways.  +2 Dexterity."),
    prerequisites = { "UNDINE_SKIN_1" },
    replacements = { "UNDINE_DEX_UP_2" },
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_DEX_UP_1_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_DEX_UP_2",
    name = ccb.content.text("Grace of the Stream"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like the babbling brook, the Undine flows over everything in their way.  +4 Dexterity.  However, they must also drink 15% more water."),
    prerequisites = { "UNDINE_DEX_UP_1" },
    replacements = { "UNDINE_DEX_UP_3" },
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_DEX_UP_2_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_DEX_UP_3",
    name = ccb.content.text("Grace of the River"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like the flowing river, the Undine can twist back on themselves and pass through any obstacle.  +6 Dexterity.  However, they must also drink 25% more water."),
    prerequisites = { "UNDINE_DEX_UP_2" },
    secondary_prerequisites = { "UNDINE_WATER_BODY" },
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_DEX_UP_3_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_PER_UP_1",
    name = ccb.content.text("Seeing the Depths"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Undine's senses take in their environment like a fisher gazing to the bottom of a clear pond.  +2 Perception."),
    prerequisites = { "UNDINE_RIVER_MAPPING" },
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_PER_UP_1_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_NO_COLD_UNDERWATER",
    name = ccb.content.text("The Pond's Depths Do Not Freeze"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "UNDINE_ABSORB_WATER" },
    description = ccb.content.text("Though the ice over the top grows thick, the water below remains liquid.  The Undine is completely immune to cold temperatures when underwater."),
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_NO_COLD_UNDERWATER_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_WATER_BODY",
    name = ccb.content.text("Fluid Body"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Even the Undine's internal organs are becoming more liquid.  Bashing and cutting damage is reduced even further, and ballistic damage is halved.  However, the Undine needs to drink more water."),
    prerequisites = { "UNDINE_SKIN_2", "UNDINE_SKIN_3" },
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "ench_undine_water_body", "INLINE_ENCH_UNDINE_WATER_BODY_1" },
}

ccb.content.define_mutation {
    id = "UNDINE_MORE_MANA_REGEN",
    name = ccb.content.text("Like the Flowing Fountain"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "UNDINE_FAST_SWIM_SPEED" },
    replacements = { "UNDINE_MORE_MANA_REGEN_AND_MANA" },
    description = ccb.content.text("Like the fountain continuously flowing with water, the Undine's mana regenerates 50% faster while standing in or under water."),
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_MORE_MANA_REGEN_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_MORE_MANA_REGEN_AND_MANA",
    name = ccb.content.text("Like the Rushing Fountain"),
    points = 7,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "UNDINE_MORE_MANA_REGEN" },
    secondary_prerequisites = { "UNDINE_RIVER_MAPPING" },
    replacements = { "UNDINE_MORE_MANA_REGEN_AND_MANA_AND_STAMINA" },
    description = ccb.content.text("Like the fountain continuously flowing to the brim with water, the Undine's mana regenerates 50% faster and they have 50% more mana while standing in or under water."),
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_MORE_MANA_REGEN_AND_MANA_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_MORE_MANA_REGEN_AND_MANA_AND_STAMINA",
    name = ccb.content.text("Like the Overflowing Fountain"),
    points = 10,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "UNDINE_MORE_MANA_REGEN_AND_MANA" },
    description = ccb.content.text("Like the fountain overflowing with water, the Undine's mana regenerates 50% faster, they have 50% more mana, and their stamina regenerates 100% faster while standing in or under water."),
    categories = { "UNDINE" },
    purifiable = false,
    threshold_requirements = { "THRESH_UNDINE" },
    enchantments = { "INLINE_ENCH_UNDINE_MORE_MANA_REGEN_AND_MANA_AND_STAMINA_0" },
}
