local ccb = require("ccb")

ccb.content.define_mutation {
    id = "EYES_INSECT_2",
    name = ccb.content.text("Dragonfly Eyes"),
    types = { "EYES", "HEAD" },
    prerequisites = { "EYES_INSECT" },
    secondary_prerequisites = { "CHITIN2", "CHITIN2_MOLTED" },
    points = 2,
    description = ccb.content.text("You remember having tiny, unassuming eyes condemned into cramped slits in your face.  No more.  Since your last molt your eyes take up most of your head, giving you unparalelled reactions at the cost of fine vision.  You wouldn't want to cover up too much of the view, however.  <color_red>This change is permanent.</color>"),
    categories = { "INSECT" },
    threshold_requirements = { "THRESH_INSECT" },
    valid = false,
    purifiable = false,
    vitamin_cost = 500,
    enchantments = { "INLINE_ENCH_EYES_INSECT_2_0" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_FOOT",
    name = ccb.content.text("Gastropod Foot"),
    points = 1,
    mixed_effect = true,
    description = ccb.content.text("Your legs have consolidated into a single muscular 'foot' that goes up into your belly.  You move about a fourth of your previous speed and can no longer wear pants or shoes, on the other hand you make significantly less noise.  In addition to being harder to knock down, you can move through sludge-covered surfaces easily."),
    categories = { "GASTROPOD" },
    types = { "RUNNING", "LEGS", "FEET" },
    prerequisites = { "SLIMY" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    additions = { "GASTROPOD_BALANCE" },
    flags = { "SLUDGE_IMMUNE" },
    enchantments = { "ENCH_GASTROPOD_FOOT", "INLINE_ENCH_GASTROPOD_FOOT_1" },
    visibility = 8,
    ugliness = 9,
    encumbrance = { leg_l = 10, leg_r = 10, foot_l = 10, foot_r = 10 },
    restricts_gear = { "leg_l", "leg_r", "foot_l", "foot_r", "leg_stub_r", "leg_stub_l" },
    destroys_gear = true,
}
