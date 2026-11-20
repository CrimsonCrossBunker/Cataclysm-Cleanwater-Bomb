local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_thi_location",
    name = ccb.content.text("Vanishing Arc's transponder"),
    goal = "MGOAL_NULL",
    description = ccb.content.text("The location of your ship, the Vanishing Arc."),
    difficulty = 0,
    value = 0,
    invisible_on_complete = true,
    start = { target = { global_position = "ship_new" } },
}
