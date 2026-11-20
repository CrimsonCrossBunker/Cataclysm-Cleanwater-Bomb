local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_NULL",
    name = ccb.content.text("Null mission"),
    goal = "MGOAL_NULL",
    difficulty = 0,
    value = 0,
    place = "never",
}
