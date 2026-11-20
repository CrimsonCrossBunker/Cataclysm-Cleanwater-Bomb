local ccb = require("ccb")

ccb.content.define_mission {
    id = "directions_farmer",
    name = ccb.content.text("Check out that farm"),
    description = ccb.content.text("There's maybe still some farmers left."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Farm Mutable", terrain = "farm_2", reveal_radius = 5 },
        handler = "set_BOSS_mission_directions_to_farmer",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("There's maybe still some farmers left."),
        offer = ccb.content.text("There's maybe still some farmers left."),
        accepted = ccb.content.text("Good good."),
        rejected = ccb.content.text("Sure, fine."),
        advice = ccb.content.text("Maybe bring like a bat or something?"),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great."),
        success_lie = ccb.content.text("Great."),
        failure = ccb.content.text("Not that surprising."),
    },
}
