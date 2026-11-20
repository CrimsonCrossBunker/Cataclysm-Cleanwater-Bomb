local ccb = require("ccb")

ccb.content.define_mission {
    id = "directions_lapin",
    name = ccb.content.text("Check out that cabin in the woods"),
    description = ccb.content.text("Maybe still a guy in a cabin in the woods."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Cabin_Lapin", terrain = "cabin_lapin", reveal_radius = 5 },
        handler = "set_BOSS_mission_directions_to_lapin",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Maybe still a guy in a cabin in the woods."),
        offer = ccb.content.text("Maybe still a guy in a cabin in the woods."),
        accepted = ccb.content.text("Good good."),
        rejected = ccb.content.text("Sure, fine."),
        advice = ccb.content.text("Maybe bring like a bat or something?"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great."),
        success_lie = ccb.content.text("Great."),
        failure = ccb.content.text("Not that surprising."),
    },
}
