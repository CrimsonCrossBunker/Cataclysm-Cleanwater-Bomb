local ccb = require("ccb")

-- Mostly copied from Huge with some Tough mixed in.  Strength bonus includes improvements from STR_UP mutation that's normally required for LARGE
ccb.content.define_mutation {
    id = "GOBLIN_FRUIT_GIANT_GROWTH",
    name = ccb.content.text("Giant-sized"),
    points = 2,
    visibility = 10,
    ugliness = 8,
    mixed_effect = true,
    description = ccb.content.text("Eating that goblin fruit has made you grow to enormous size!"),
    flags = { "TEMPORARY_SHAPESHIFT", "SHAPESHIFT_SIZE_HUGE" },
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    social_modifiers = { intimidate = 15 },
    enchantments = { "ench_giant_growth_size_bonuses", "INLINE_ENCH_GOBLIN_FRUIT_GIANT_GROWTH_1" },
}

-- Until the day EOCs can spawn equiped items, the fruit will give a mutation that holds the music player.
ccb.content.define_mutation {
    id = "GOBLIN_FRUIT_MUSIC",
    name = ccb.content.text_without_extraction("The fruit's song"),
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text_without_extraction("Gives the integrated music player.  Should not be player-visible."),
    integrated_armor = { "internal_mp3_fruit" },
}
