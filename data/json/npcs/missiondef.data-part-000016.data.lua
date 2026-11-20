local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REACH_SAFETY",
    name = ccb.content.text("Reach Safety"),
    goal = "MGOAL_GO_TO",
    difficulty = 1,
    value = 0,
    start = "find_safety",
    origins = { "ORIGIN_NULL" },
}
