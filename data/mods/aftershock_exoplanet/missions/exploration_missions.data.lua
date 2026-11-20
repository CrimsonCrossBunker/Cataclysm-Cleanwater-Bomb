local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REACH_SPACEPORT",
    name = ccb.content.text("Reach the spaceport"),
    goal = "MGOAL_GO_TO",
    description = ccb.content.text("You spotted a spaceport in the distance.  You should head there to see if you can find a way off this planet."),
    difficulty = 0,
    value = 0,
    start = { target = { terrain = "land_pad_outpost_a1", special = "landing_pad", reveal_radius = 5 } },
}
