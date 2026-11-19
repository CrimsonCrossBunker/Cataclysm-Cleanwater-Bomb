local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PAINREC2",
    name = ccb.content.text("Quick Pain Recovery"),
    description = ccb.content.text("You recover from pain faster than normal."),
    categories = { "MEDICAL" },
    types = { "PAIN_RECOVERY" },
    prerequisites = { "PAINREC1" },
    replacements = { "PAINREC3" },
    points = 5,
    vitamin_cost = 210,
}
