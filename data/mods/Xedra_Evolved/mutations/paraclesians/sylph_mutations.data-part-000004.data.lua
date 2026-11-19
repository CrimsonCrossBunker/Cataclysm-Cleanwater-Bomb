local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SYLPH_LIGHTNING_MELEE_ATTACKS_ACTIVE",
    name = ccb.content.text_without_extraction("Fulgurating Strikes Active"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text_without_extraction("The actual trait that grants you fulgurating strikes.  It's a bug if you have it."),
    categories = { "SYLPH" },
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "ench_sylph_fulgurating_strikes_basic", "ench_sylph_fulgurating_strikes_advanced" },
}

ccb.content.define_mutation {
    id = "SYLPH_DEX_BONUS_1",
    name = ccb.content.text("Spring Breeze Stride"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    replacements = { "SYLPH_DEX_BONUS_2" },
    prerequisites = { "SYLPH_SPEED_INCREASE" },
    description = ccb.content.text("The Sylph's moves like the wind.  +2 Dexterity."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_DEX_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_DEX_BONUS_2",
    name = ccb.content.text("Storm-Runner's Speed"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SYLPH_DEX_BONUS_1" },
    secondary_prerequisites = { "SYLPH_SPEED_INCREASE2" },
    description = ccb.content.text("The Sylph's moves like a sudden burst of wind.  +5 Dexterity."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_DEX_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_INT_BONUS_1",
    name = ccb.content.text("Ice-Clear Thoughts"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    replacements = { "SYLPH_INT_BONUS_2" },
    prerequisites = { "SYLPH_SKIN_2", "SYLPH_SKIN_3" },
    description = ccb.content.text("The Sylph's mind has the clarity of pure frozen water.  +2 Intelligence."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_INT_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_INT_BONUS_2",
    name = ccb.content.text("Lightning Mind"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SYLPH_INT_BONUS_1" },
    description = ccb.content.text("The Sylph's thoughts move as quickly as a bolt of lightning.  +4 Intelligence."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_INT_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_PER_BONUS_1",
    name = ccb.content.text("Eagle's Sight"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SYLPH_EYES" },
    description = ccb.content.text("Like a bird soaring on the wind, the Sylph's keen eyes take in their surroundings.  +3 Perception."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_PER_BONUS_1_0" },
    flags = { "ENHANCED_VISION" },
}

ccb.content.define_mutation {
    id = "SYLPH_FAST_CAST",
    name = ccb.content.text("Zephyr Chant"),
    points = 7,
    description = ccb.content.text("Like the blowing winds, the Sylph's mana races from of their body at their command.  -20% spell casting speed when outdoors."),
    prerequisites = { "SYLPH_INT_BONUS_2" },
    replacements = { "SYLPH_FAST_CAST2" },
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "sylph_fast_cast" },
}

ccb.content.define_mutation {
    id = "SYLPH_FAST_CAST2",
    name = ccb.content.text("Whistling Zephyr Chant"),
    points = 10,
    description = ccb.content.text("The wind finds it way through any crack, and so does the Sylph's mana come to their call regardless of what movements they make.  -20% spell casting speed when outdoors and the Sylph no longer needs to gesture to use their magick."),
    prerequisites = { "SYLPH_FAST_CAST" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    enchantments = { "sylph_fast_cast2", "INLINE_ENCH_SYLPH_FAST_CAST2_1" },
}
