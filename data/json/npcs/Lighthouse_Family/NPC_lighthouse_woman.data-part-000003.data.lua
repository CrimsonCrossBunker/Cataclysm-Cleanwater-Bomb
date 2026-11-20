local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_lighthouse_woman_0",
    generic_rewards = false,
    name = ccb.content.text("Protect fisherman's wife"),
    description = ccb.content.text("She looks like a nice woman.  Maybe you should not let her die?"),
    goal = "MGOAL_CONDITION",
    difficulty = 0,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("-"),
        accepted = ccb.content.text("-"),
        rejected = ccb.content.text("-"),
        advice = ccb.content.text("-"),
        inquire = ccb.content.text("-"),
        success = ccb.content.text("-"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
    failure = { handler = "mark_flag_death_lighthouse_wife_dead" },
}
