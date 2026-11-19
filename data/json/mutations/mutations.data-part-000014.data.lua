local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PAINREC3",
    name = ccb.content.text("Very Quick Pain Recovery"),
    description = ccb.content.text("You recover from pain much faster than normal."),
    categories = { "MEDICAL" },
    types = { "PAIN_RECOVERY" },
    prerequisites = { "PAINREC2" },
    points = 8,
    vitamin_cost = 300,
}
