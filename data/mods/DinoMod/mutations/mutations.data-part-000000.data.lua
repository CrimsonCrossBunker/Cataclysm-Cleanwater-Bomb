local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_RAPTOR",
    name = ccb.content.text("Raptor"),
    points = 1,
    description = ccb.content.text("The chance to undo not one but TWO extinction events.  You're confident you'll do fine."),
    valid = false,
    purifiable = false,
    species_anger = { DINOSAUR = 20, REPTILE = 20, BIRD = 20, MAMMAL = 20 },
    ignored_by = { "PLANT" },
    threshold = true,
}
