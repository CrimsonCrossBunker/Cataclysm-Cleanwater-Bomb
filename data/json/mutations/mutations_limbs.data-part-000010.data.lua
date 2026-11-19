local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PADDED_FEET",
    name = ccb.content.text("Padded Feet"),
    description = ccb.content.text("The bottoms of your feet are strongly padded.  You receive no movement penalty for not wearing shoes, and your steps are significantly quieter, as added tissue dampens the noise."),
    categories = { "BATRACHIAN", "RABBIT", "URSINE", "FELINE", "LUPINE", "SPIDER", "BEAST" },
    types = { "SOLES" },
    points = 1,
    vitamin_cost = 60,
    visibility = 1,
    flags = { "TOUGH_FEET" },
    enchantments = { "INLINE_ENCH_PADDED_FEET_0" },
}

ccb.content.define_mutation {
    id = "HOOVES",
    name = ccb.content.text("Hooves"),
    description = ccb.content.text("Your feet have fused into hooves.  This allows you to perform a powerful kicking attack, provides natural armor, and removes the need to wear shoes; however, you cannot wear normal shoes.  Reduces wet effects."),
    categories = { "CATTLE", "CHIMERA" },
    types = { "FEET", "SOLES" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 175,
    visibility = 2,
    ugliness = 2,
    flags = { "TOUGH_FEET" },
    destroys_gear = true,
    restricts_gear = { "foot_sole_l", "foot_sole_r" },
    enchantments = { "INLINE_ENCH_HOOVES_0", "INLINE_ENCH_HOOVES_1" },
    wet_protection = { { part = "foot_l", neutral = 10 }, { part = "foot_r", neutral = 10 } },
}
