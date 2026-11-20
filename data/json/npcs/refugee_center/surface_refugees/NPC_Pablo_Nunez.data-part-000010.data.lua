local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_TACOMA_Nunez",
    name = ccb.content.text("Find out if the Nunez family can find work at Tacoma Ranch."),
    goal = "MGOAL_NULL",
    difficulty = 2,
    value = 1000,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Find out if the Nunez family can find work at Tacoma Ranch."),
        offer = ccb.content.text("n/a"),
        accepted = ccb.content.text("n/a"),
        rejected = ccb.content.text("n/a"),
        advice = ccb.content.text("n/a"),
        inquire = ccb.content.text("n/a"),
        success = ccb.content.text("n/a"),
        success_lie = ccb.content.text("n/a"),
        failure = ccb.content.text("n/a"),
    },
}
