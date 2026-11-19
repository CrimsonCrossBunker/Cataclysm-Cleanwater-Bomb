local ccb = require("ccb")

ccb.content.define_mutation {
    id = "seer_mark",
    name = ccb.content.text("Mark of the Seer"),
    points = 1,
    description = ccb.content.text("A strange occult symbol carved into your hand by Brigitte LaCroix."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}
