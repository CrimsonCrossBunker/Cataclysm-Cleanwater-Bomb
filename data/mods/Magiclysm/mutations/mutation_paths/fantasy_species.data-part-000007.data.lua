local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_SPECIES_GOBLIN",
    name = ccb.content.text("Night Stalker"),
    points = 1,
    description = ccb.content.text("Long ago, the others feared your people as hunters in the night.  In this new world, it's time to revive that legacy."),
    valid = false,
    purifiable = false,
    threshold = true,
}
