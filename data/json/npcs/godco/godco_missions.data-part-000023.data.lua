local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_HELENA_2",
    name = ccb.content.text("Planning Planers"),
    description = ccb.content.text("Find two planers for Helena Misinter."),
    goal = "MGOAL_FIND_ITEM",
    item = "planer",
    item_count = 2,
    difficulty = 12,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +2, value +1).
    finish = {
        actions = {
            ccb.content.dialogue_actions.update_map("helena_planer", "godco_8"),
            { handler = "start_godco_wall" },
            { item = "icon", count = 80 },
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    followup = "MISSION_GODCO_HELENA_3",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get two planers."),
        offer = ccb.content.text("I'm looking to construct some fortifications around the church, should any of Satan's devils decide to run amok.  We have most of the material needed for such an undertaking, but processing our raw lumber is taking far too long.  I've heard a planer could do such in a fraction of the time; I'll pay for two of them."),
        accepted = ccb.content.text("May God protect you."),
        rejected = ccb.content.text("I'll find someone else, then."),
        advice = ccb.content.text("I'd poke around any industrial sites for some."),
        inquire = ccb.content.text("Have you found the planers?"),
        success = ccb.content.text("Thank you."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("As expected of such a person…"),
    },
}
