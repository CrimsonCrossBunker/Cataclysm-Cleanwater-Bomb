local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_Warrener_ISHERWOOD",
    name = ccb.content.text("Visit the Isherwoods"),
    description = ccb.content.text("There is a family nearby that I'd like you to check in on.  After you talk to all of them, come back to me and tell me how they are doing."),
    goal = "MGOAL_CONDITION",
    difficulty = 3,
    start = {
        target = { terrain = "farm_isherwood_2", special = "Isherwood Farm Mutable", reveal_radius = 3 },
    },
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
    complete_when = "complete_mission_warrener_isherwood",
}
