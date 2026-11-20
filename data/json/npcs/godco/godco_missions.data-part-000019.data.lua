local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_HELENA_1",
    name = ccb.content.text("Plumbing Maintenance"),
    description = ccb.content.text("Find 200 pipes for Helena Misinter."),
    goal = "MGOAL_CONDITION",
    difficulty = 6,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = { item_rewards = { { item = "icon", count = 40 } }, handler = "deliver_mission_godco_helena_1" },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    followup = "MISSION_GODCO_HELENA_2",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get 200 pipes."),
        offer = ccb.content.text("We were in the process of refurbishing the retreat when <the_cataclysm> interrupted us.  Some of the plumbing around here was troublesome, and we need to fix that.  200 pipes should be all we need to finish it."),
        accepted = ccb.content.text("May God protect you."),
        rejected = ccb.content.text("I'll find someone else, then."),
        advice = ccb.content.text("A public works or a craft shop should have some lying around.  If not, try a steel mill."),
        inquire = ccb.content.text("Have you found the pipes?"),
        success = ccb.content.text("Thank you."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("As expected of such a person…"),
    },
    complete_when = "complete_mission_godco_helena_1",
}
