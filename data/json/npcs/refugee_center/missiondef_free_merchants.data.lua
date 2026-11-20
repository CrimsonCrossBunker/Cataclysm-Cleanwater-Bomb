local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REACH_REFUGEE_CENTER",
    name = ccb.content.text("Reach Refugee Center"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 1,
    value = 0,
    start = "reveal_refugee_center",
    origins = { "ORIGIN_COMPUTER" },
    destination = "evac_center_18",
    finish = { handler = "mark_found_refugee_center" },
}
