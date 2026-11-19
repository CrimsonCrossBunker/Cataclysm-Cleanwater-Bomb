local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_TYRANT",
    name = ccb.content.text("Tyrano Sapien"),
    points = 1,
    description = ccb.content.text("Thunder lizard, dragon, tyrant.  All these names pale before your majesty."),
    valid = false,
    profession = true,
    purifiable = false,
    species_anger = { DINOSAUR = 20, REPTILE = 20, BIRD = 20, MAMMAL = 20 },
    ignored_by = { "PLANT" },
    threshold = true,
}
