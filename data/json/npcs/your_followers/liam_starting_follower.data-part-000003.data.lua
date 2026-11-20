local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_FIND_LIAM",
    name = ccb.content.text("Check to see if Liam is OK"),
    goal = "MGOAL_CONDITION",
    start = { target = { terrain = "cabin_liam", special = "cabin_liam", reveal_radius = 1, random = false } },
    difficulty = 0,
    value = 0,
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_find_liam",
}
