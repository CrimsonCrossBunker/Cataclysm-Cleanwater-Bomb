local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_FELICITY_1",
    name = ccb.content.text("Writers' Will"),
    description = ccb.content.text("Get 800 sheets of paper for Felicity Powell."),
    goal = "MGOAL_FIND_ITEM",
    item = "paper",
    item_count = 800,
    difficulty = 3,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +3, value +2).
    finish = { item_rewards = { { item = "icon", count = 8 } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_FELICITY_2",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some paper."),
        offer = ccb.content.text("Since <the_cataclysm> happened, I've had a surprising amount of free time.  I want to start writing, but there's very little paper around here.  For the time being, eight hundred sheets should do; I'll pay if you can get it for me."),
        accepted = ccb.content.text("Thanks, you'll be the first to see my writing."),
        rejected = ccb.content.text("I can understand that.  The offer's still available if you reconsider."),
        advice = ccb.content.text("A bookstore or office supply should have tons of it."),
        inquire = ccb.content.text("Have you found the paper?"),
        success = ccb.content.text("I appreciate it.  I'll get to work on my manuscript."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("How unfortunate…"),
    },
}
