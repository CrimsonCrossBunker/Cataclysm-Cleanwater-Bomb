local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_SPECIES_LIZARDFOLK",
    name = ccb.content.text("Scaled One"),
    points = 1,
    description = ccb.content.text("The old world was nothing like your home swamps, but this new world is something you understand."),
    valid = false,
    purifiable = false,
    threshold = true,
}
