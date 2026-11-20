local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_LAST_DELIVERY",
    name = ccb.content.text("Deliver Your Cargo"),
    description = ccb.content.text("You're not sure who orders takeout when the world's ending, but that doesn't matter.  Evacuation doesn't matter.  Nothing, indeed, matters, save for safely delivering your precious cargo to its destination: a remote mansion."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "mansion_c3",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "mansion_c3", special = "Mansion_Road" } },
    origins = { "ORIGIN_GAME_START" },
}
