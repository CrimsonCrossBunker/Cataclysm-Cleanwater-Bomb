local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_SPECIES_ELF",
    name = ccb.content.text("Firstborn"),
    points = 1,
    description = ccb.content.text("The first elves sprang forth from magic and moonlight before the ancestors of humanity stopped scurrying through the underbrush to avoid the dinosaurs.  You won't let that legacy die with you."),
    valid = false,
    purifiable = false,
    threshold = true,
}
