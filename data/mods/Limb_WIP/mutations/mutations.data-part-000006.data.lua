local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WINGS_BIRD",
    name = ccb.content.text("Bird Wings"),
    points = 2,
    visibility = 4,
    ugliness = 2,
    description = ccb.content.text("Your arms have mostly transformed into a huge pair of feathered wings.  Though you retain a few fingers, your fine manipulation is greatly hampered.  On the other hand, you can glide from ledges and will take less damage if you fall, provided you're healthy and unburdened."),
    types = { "ARMS", "HANDS" },
    enchantments = { "INLINE_ENCH_WINGS_BIRD_0" },
    prerequisites = { "ARM_FEATHERS" },
    secondary_prerequisites = { "HOLLOW_BONES" },
    threshold_requirements = { "THRESH_BIRD" },
    categories = { "BIRD" },
    restricts_gear = { "arm_l", "arm_r", "hand_l", "hand_r", "arm_stub_r", "arm_stub_l" },
    vitamin_cost = 300,
    valid = false,
    flags = { "WINGS_2" },
}
