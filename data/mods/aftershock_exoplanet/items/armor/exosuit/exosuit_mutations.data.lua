local ccb = require("ccb")

ccb.content.define_mutation {
    id = "exo_climb_mutation",
    name = ccb.content.text("Exosuit Climb Assist"),
    points = 0,
    description = ccb.content.text("Your exosuit is equipped with a variety of climbing assists."),
    valid = false,
    purifiable = false,
    types = { "Equipment" },
    flags = { "WALL_CLING" },
}
