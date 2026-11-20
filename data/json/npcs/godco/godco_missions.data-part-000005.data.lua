local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_THERESA_1",
    name = ccb.content.text("Get some oxycodone"),
    description = ccb.content.text("Find seven oxycodone pills for Theresa."),
    goal = "MGOAL_FIND_ITEM",
    item = "oxycodone",
    item_count = 7,
    difficulty = 1,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +4, value +4).
    finish = {
        handler = "mark_general_completed_theresa_going_away",
        item_rewards = {
            { item = "icon", count = 25 },
            { item = "cane" },
            { item = "silver_ring" },
            { item = "gold_necklace" },
            { item = "glasses_reading" },
            { item = "knitting_needles" },
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +6).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some pills."),
        offer = ccb.content.text("I've got an idea to solve my problem.  I'll pay you if you can find seven oxycodone pills for me; the ones they used to prescribe after a surgery."),
        accepted = ccb.content.text("Thank you, <granny_name_g>.  I'm glad the youngsters still help the elderly."),
        rejected = ccb.content.text("I can understand your hesitation <granny_name_g>.  I wouldn't worry about it too much."),
        advice = ccb.content.text("An old doctors office should have some.  They have those fancy autodocs upstairs."),
        inquire = ccb.content.text("Have you found my painkillers?"),
        success = ccb.content.text("I want you to have these few things of mine, I won't be needing them anymore.  I think I'll take a walk in the woods, get some fresh air for these old bones…"),
        success_lie = ccb.content.text("Deceitful rogue, you…"),
        failure = ccb.content.text("How unfortunate…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_JEREMIAH_1",
    name = ccb.content.text("Dinner for Two"),
    description = ccb.content.text("Get a candle for Jeremiah."),
    goal = "MGOAL_FIND_ITEM",
    item = "candle",
    difficulty = 1,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +2, value +3).
    finish = { item_rewards = { { item = "icon", count = 1 } } },
    -- Native mission phases did not apply the giver opinion (anger +3).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get a candle."),
        offer = ccb.content.text("Have you met Chloe?  She's the girl with the butcher knife, came here with Sonia.  This may sound silly, but I want to ask her out on a date, have a picnic some time.  The only thing I need to get this plan to come together is a candle.  If you happen to find one, I'll pay you for it."),
        accepted = ccb.content.text("Thanks, <name_g>."),
        rejected = ccb.content.text("Please?  The dating scene isn't that big around here."),
        advice = ccb.content.text("Someone's house might have one."),
        inquire = ccb.content.text("Have you found the candle?"),
        success = ccb.content.text("I appreciate it."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}
