local ccb = require("ccb")

ccb.content.define_mission {
    id = "directions_hospital_2_CABIN",
    name = ccb.content.text("Check out that cabin"),
    description = ccb.content.text("Maybe there's something left in that cabin you heard about."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Cabin_2", terrain = "cabin_2", reveal_radius = 3 },
        handler = "mark_mission_BGSS_hospital_2_started_quest",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Any luck finding the cabin?"),
        success = ccb.content.text("Thanks so much for coming back here with me!  I'm not sure I would have ever gotten here alive."),
        success_lie = ccb.content.text("Great!"),
        failure = ccb.content.text("Not that surprising."),
    },
}
