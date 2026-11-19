local ccb = require("ccb")

ccb.content.define_mutation {
    id = "AFS_HYPERMETABOLISM",
    name = ccb.content.text("Hypermetabolism"),
    description = ccb.content.text("Your particular metabolism allows you to burn calories at a prodigious rate to regenerate tissues in a matter of minutes; this is, however, a very wasteful process.  Activate to start healing."),
    threshold_requirements = { "THRESH_COMBAT_BRUTE" },
    categories = { "COMBAT_BRUTE" },
    types = { "METABOLISM" },
    points = 15,
    active = true,
    vitamin_cost = 350,
    transform = {
        target = "AFS_HYPERMETABOLISM_active",
        message = ccb.content.text("Your hyper-metabolism starts burning up calories."),
        active = true,
        moves = 0,
    },
}

ccb.content.define_mutation {
    id = "AFS_HYPERMETABOLISM_active",
    copy_from = "AFS_HYPERMETABOLISM",
    name = ccb.content.text("Hyper-Metabolism: burning"),
    description = ccb.content.text("You're burning calories like crazy to heal your wounds."),
    valid = false,
    cooldown = "1 s",
    cost = 9,
    consumes_calories = true,
    transform = {
        target = "AFS_HYPERMETABOLISM",
        message = ccb.content.text("Your hyper-metabolism slows down."),
        active = false,
        moves = 0,
    },
    enchantments = { "INLINE_ENCH_AFS_HYPERMETABOLISM_active_0" },
}
