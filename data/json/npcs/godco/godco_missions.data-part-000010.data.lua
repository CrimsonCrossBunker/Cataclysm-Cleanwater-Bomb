local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_TRADER",
    name = ccb.content.text("Investigate the Trader"),
    description = ccb.content.text("Find some proof that the representative near the New England Community Church is crooked."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Find some proof about that merchant."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("What have you found out?"),
        success = ccb.content.text("Thanks, we'll take the needed initiative."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("Of course, you have no evidence."),
    },
    complete_when = "complete_mission_investigate_trader",
}
