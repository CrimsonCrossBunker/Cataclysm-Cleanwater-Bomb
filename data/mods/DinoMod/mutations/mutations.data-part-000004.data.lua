local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_STEGO",
    name = ccb.content.text("Stego"),
    points = 1,
    description = ccb.content.text("Slow, methodical, heavily armored.  A walking tank."),
    valid = false,
    profession = true,
    purifiable = false,
    species_anger = { DINOSAUR = -20, REPTILE = -20, PLANT = 20, MAMMAL = -20 },
    ignored_by = { "BIRD" },
    threshold = true,
}
