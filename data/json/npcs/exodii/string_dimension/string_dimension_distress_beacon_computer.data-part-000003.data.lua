local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_STRING_DIMENSION_EXODII_DOME",
    name = ccb.content.text("Investigate the Blinking Dot"),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "string_dimension_dome_x1y2z0",
    start = {
        target = {
            terrain = "string_dimension_dome_x1y2z0",
            special = "string_dimension_dome",
            reveal_radius = 0,
            random = false,
        },
    },
    difficulty = 2,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("-"),
        accepted = ccb.content.text("-"),
        rejected = ccb.content.text("-"),
        advice = ccb.content.text("-"),
        inquire = ccb.content.text("-"),
        success = ccb.content.text("-"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}
