local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_MARIA_1",
    name = ccb.content.text("Cotton Conundrum"),
    description = ccb.content.text("Find 300 cotton patches for Maria Serrano."),
    goal = "MGOAL_FIND_ITEM",
    item = "cotton_patchwork",
    item_count = 300,
    difficulty = 6,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 15 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_MARIA_2",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get 300 cotton patchworks."),
        offer = ccb.content.text("I'm starting to run low on cotton for my sewing.  I think three hundred cotton patches should hold me for a while; I'll pay you for them if you get me some."),
        accepted = ccb.content.text("Great stuff!"),
        rejected = ccb.content.text("How am I supposed to tailor if I have nothing to tailor with?"),
        advice = ccb.content.text("You could try cutting up some unneeded sweaters from a clothing store, or you could make some yourself."),
        inquire = ccb.content.text("Have you found the cotton?"),
        success = ccb.content.text("Thank you, <name_g>.  This should do me for a while."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_MARIA_2",
    name = ccb.content.text("Spinning Wheels"),
    description = ccb.content.text("Find an electric spinning wheel for Maria Serrano."),
    goal = "MGOAL_FIND_ITEM",
    item = "electric_spinwheel",
    difficulty = 6,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +2, value +1).
    finish = { item_rewards = { { item = "icon", count = 10 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get an electric spinning wheel."),
        offer = ccb.content.text("I want to try making my own cloth, it's getting harder to find the quantities I need.  I'll buy an electric spinning wheel if you can find one, it'd vastly expedite the process."),
        accepted = ccb.content.text("Great stuff!"),
        rejected = ccb.content.text("It'd really help me in getting your stuff to you faster."),
        advice = ccb.content.text("A textile museum should have one lying around."),
        inquire = ccb.content.text("Have you found the spinning wheel?"),
        success = ccb.content.text("This is wonderful!  I'll really be able to put the pedal to the metal!"),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}
