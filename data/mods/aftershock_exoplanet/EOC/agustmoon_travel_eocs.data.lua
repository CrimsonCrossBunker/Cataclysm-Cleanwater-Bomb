local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REACH_AUGUSTMOON_SHUTTLE",
    name = ccb.content.text("Reach the Port Augustmoon shuttle"),
    goal = "MGOAL_GO_TO",
    description = ccb.content.text("Your shuttle has landed nearby.  It will wait for up to 3 hours before returning to port, you might what to reach it before then."),
    difficulty = 0,
    value = 0,
    invisible_on_complete = true,
    start = { target = { global_position = "landing_site" } },
}
