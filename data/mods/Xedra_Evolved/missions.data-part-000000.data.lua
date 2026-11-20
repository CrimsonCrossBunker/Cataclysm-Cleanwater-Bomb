local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_SAFEHOUSE",
    name = ccb.content.text("Return to the safehouse and grab your gear."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "safe_house",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "safe_house", special = "safe_house" } },
    origins = { "ORIGIN_GAME_START" },
}
