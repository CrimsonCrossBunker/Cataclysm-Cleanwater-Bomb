local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_FIND_SUNKEN_HELICOPTER",
    name = ccb.content.text("Find the sunken helicopter"),
    description = ccb.content.text("You got the location of a sunken helicopter, all that's left to do is find a way to get there."),
    goal = "MGOAL_GO_TO",
    value = 0,
    difficulty = 0,
    start = { target = { terrain = "sunken_helicopter", special = "sunken_helicopter", reveal_radius = 5 } },
    finish = { handler = "mark_eoc_sample_item_transporter_set_coordinates" },
    origins = { "ORIGIN_NULL" },
    invisible_on_complete = true,
}
