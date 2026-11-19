local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_SPECIES_DWARF",
    name = ccb.content.text("Child of the Stone"),
    points = 1,
    description = ccb.content.text("Trust the humans to make a mess of the world.  Trust a dwarf to rebuild it better than they found it."),
    valid = false,
    purifiable = false,
    threshold = true,
}
