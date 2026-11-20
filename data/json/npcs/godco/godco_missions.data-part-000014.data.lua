local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_FELICITY_2",
    name = ccb.content.text("Writers' Will II"),
    description = ccb.content.text("Get 30 pencils for Felicity Powell."),
    goal = "MGOAL_FIND_ITEM",
    item = "pencil",
    item_count = 30,
    difficulty = 1,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            { item = "icon", count = 10 },
            ccb.content.dialogue_actions.record_time({ scope = "interlocutor", key = "timer_trade_writing_manuscript" }),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some pencils."),
        offer = ccb.content.text("I've been writing for a bit, and I've used up my pencils.  If you could get me thirty more, I'll give you some money."),
        accepted = ccb.content.text("I do appreciate it."),
        rejected = ccb.content.text("I can understand that.  The offer's still available if you reconsider."),
        advice = ccb.content.text("An office building should have tons."),
        inquire = ccb.content.text("Have you found the pencils?"),
        success = ccb.content.text("Thank you so much!  I'll get back to work on my manuscript, I should have it ready in a month or so."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("How unfortunate…"),
    },
}
