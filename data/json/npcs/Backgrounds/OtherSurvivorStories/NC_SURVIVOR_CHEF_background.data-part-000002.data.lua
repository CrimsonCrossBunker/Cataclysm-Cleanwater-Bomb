local ccb = require("ccb")

ccb.content.define_mission {
    id = "directions_chef",
    name = ccb.content.text("Check out that restaurant"),
    description = ccb.content.text("Maybe that chef is still alive."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { terrain = "s_restaurant", special = "restraunt", reveal_radius = 5 },
        handler = "set_BOSS_mission_directions_to_chef",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Maybe that chef is still alive."),
        offer = ccb.content.text("Maybe that chef is still alive."),
        accepted = ccb.content.text("Good good."),
        rejected = ccb.content.text("Sure, fine."),
        advice = ccb.content.text("Maybe bring like a bat or something?"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great."),
        success_lie = ccb.content.text("Great."),
        failure = ccb.content.text("Not that surprising."),
    },
}
