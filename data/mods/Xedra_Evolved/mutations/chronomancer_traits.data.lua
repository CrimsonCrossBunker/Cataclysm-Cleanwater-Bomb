local ccb = require("ccb")

ccb.content.define_mutation {
    id = "XEDRA_CHRONOMANCER_LOOPING_WOUND",
    name = ccb.content.text("Time Looped Knife Wound"),
    points = -4,
    description = ccb.content.text("You have suffered a time looped wound, forcing you to repeatedly endure the harm of an earlier wound.  Every 24 hours you are impaled by a non-existent knife."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    vitamin_intervals = { xedra_chronomancer_insight = -86400 },
}

ccb.content.define_mutation {
    id = "XEDRA_CHRONOMANCER_TIME_SLOWDOWN",
    name = ccb.content.text("Slowed Timestream"),
    points = -4,
    description = ccb.content.text("Your timestream remains slightly slower than baseline reality.  You act 10% slower."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    vitamin_intervals = { xedra_chronomancer_insight = -86400 },
    enchantments = { "INLINE_ENCH_XEDRA_CHRONOMANCER_TIME_SLOWDOWN_0" },
}

ccb.content.define_mutation {
    id = "XEDRA_CHRONOMANCER_UNSTABLE_POWERS",
    name = ccb.content.text("Unstable Chronomancy"),
    points = -4,
    description = ccb.content.text("Your chronomantic powers have inherent instability.  While attempting to maintain them over long periods of time, your powers may randomly fail."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    vitamin_intervals = { xedra_chronomancer_insight = -86400 },
}
