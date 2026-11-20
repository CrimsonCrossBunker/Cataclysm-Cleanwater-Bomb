local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_HELICOPTER_CRASH",
    name = ccb.content.text("Return to base"),
    description = ccb.content.text("Your helicopter was crashed to the ground, communications were lost with ground base, and the rest of your team died while landing, at least you still know the way back to the base."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "helipad_nw",
    difficulty = 4,
    value = 0,
    start = {
        target = {
            terrain = "helipad_nw",
            reveal_radius = 10,
            special = "military helipad",
            min_distance = 25,
            z = 0,
        },
    },
    origins = { "ORIGIN_GAME_START" },
}
