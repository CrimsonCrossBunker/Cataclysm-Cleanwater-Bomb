local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_FEAR_GAZE",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Predator's Mien"),
    description = ccb.content.text("With a bit of stolen blood and a savage expression, you can send your enemies fleeing."),
    spells_learned = { vampire_fear_gaze_spell = 1 },
}
