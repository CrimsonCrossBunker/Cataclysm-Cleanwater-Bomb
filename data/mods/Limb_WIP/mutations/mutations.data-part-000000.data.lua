local ccb = require("ccb")

ccb.content.define_mutation {
    id = "COMPOUND_EYES",
    name = ccb.content.text("Compound Eyes"),
    points = 2,
    visibility = 9,
    ugliness = 5,
    description = ccb.content.text("Your eyes are compound, like those of an insect.  This increases your Perception by 2 whenever you aren't wearing eyewear."),
    types = { "EYES" },
    prerequisites = { "EYEBULGE" },
    valid = false,
}
