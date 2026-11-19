local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DELIGHT_FIRST_TASTE",
    name = ccb.content.text("Morning Taste"),
    description = ccb.content.text("You have a special sensitivity to the first bite of food each day, and that flavor is etched into your body until the next day begins."),
    points = 1,
    starting_trait = true,
    purifiable = false,
    valid = false,
}
