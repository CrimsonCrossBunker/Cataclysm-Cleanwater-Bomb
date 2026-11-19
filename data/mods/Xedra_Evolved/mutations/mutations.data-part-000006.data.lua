local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BLOOD_FUN",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Sanguine Ecstasy"),
    description = ccb.content.text("Your palate adapted to your new condition.  Drinking human blood will make you feel great."),
}
