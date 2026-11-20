local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REACH_FEMA_CA",
    name = ccb.content.text("Reach FEMA Camp"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 60000,
    start = { target = { terrain = "fema", reveal_radius = 5, special = "FEMA Camp" } },
    origins = { "ORIGIN_SECONDARY" },
    destination = "fema",
    dialogue = {
        describe = ccb.content.text("Things must be better at the camp…"),
        offer = ccb.content.text("We're all in this together, looking forward to meeting you there."),
        accepted = ccb.content.text("Everything is going to be all right."),
        rejected = ccb.content.text("No worries friend, good luck to you."),
        advice = ccb.content.text("The hard part is getting there."),
        inquire = ccb.content.text("Any progress on getting to the camp?"),
        success = ccb.content.text("Well, success I guess."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Such a disappointment…"),
    },
}
