local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_FIND_BALTHAZAR_BUNKER",
    name = ccb.content.text("Reach source of mysterious transmission"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "balthazar_bunker_00",
            special = "balthazar_bunker",
            reveal_radius = 1,
            random = false,
        },
    },
    origins = { "ORIGIN_COMPUTER" },
    destination = "balthazar_bunker_00",
}
