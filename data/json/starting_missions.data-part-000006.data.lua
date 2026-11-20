local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_HELICOPTER_REFUEL",
    name = ccb.content.text("Refuel your helicopter."),
    description = ccb.content.text("You were flying towards a nearby private airport before your forced landing.  You could still reach it by ground, and scavenge it for fuel."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "s_air_hangars",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "s_air_hangars", reveal_radius = 5, special = "o_airport" } },
    finish = { handler = "morale_mission_helicopter_refuel" },
    origins = { "ORIGIN_GAME_START" },
}
