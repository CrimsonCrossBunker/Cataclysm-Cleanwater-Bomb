local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SCUTTLE",
    name = ccb.content.text("Scuttle"),
    description = ccb.content.text("Your hook-shaped feet curl inward to grip the ground, allowing you to easily walk along the bottom when you're underwater.  They're also a bit quicker at climbing over obstacles, even on dry land."),
    categories = { "CRUSTACEAN" },
    prerequisites = { "CRAB_LEGS" },
    threshold_requirements = { "THRESH_CRUSTACEAN" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 4,
    ugliness = 2,
    flags = { "WALK_UNDERWATER" },
    enchantments = { "INLINE_ENCH_SCUTTLE_0" },
}

ccb.content.define_mutation {
    id = "CRAB_LEGS",
    name = ccb.content.text("Crab Legs"),
    description = ccb.content.text("You have four prong-tipped legs, splayed out and articulated like a crab's.  They're a little quieter than human feet."),
    categories = { "CRUSTACEAN" },
    types = { "LEGS", "FEET", "SOLES" },
    prerequisites = { "CHITIN2", "CRUSTACEAN_CARAPACE" },
    additions = { "SCUTTLE" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 210,
    visibility = 8,
    ugliness = 9,
    flags = { "TOUGH_FEET" },
    destroys_gear = true,
    restricts_gear = { "leg_l", "leg_r", "foot_l", "foot_r" },
    enchantments = { "INLINE_ENCH_CRAB_LEGS_0" },
}
