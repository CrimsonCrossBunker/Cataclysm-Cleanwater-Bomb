local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_DRACO_FAE",
    name = ccb.content.text("Go check out this island"),
    description = ccb.content.text("This is where the island I agreed to a strange deal is.  I wonder if they're still there."),
    goal = "MGOAL_CONDITION",
    difficulty = 3,
    start = { target = { terrain = "boann_sidhe_island", special = "Boann's Island", reveal_radius = 6 } },
    value = 5000,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Have you checked on them?"),
        success = ccb.content.text("Good, that's one less thing to worry about."),
        success_lie = ccb.content.text("I'm glad to hear they are fine.  Why haven't they been by then?"),
        failure = ccb.content.text("At least you came back with your life…"),
    },
    complete_when = "complete_mission_draco_fae",
}
