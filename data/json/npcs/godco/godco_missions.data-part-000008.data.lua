local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_KOSTAS_3",
    name = ccb.content.text("Out Of This World Cures"),
    description = ccb.content.text("Find a Marloss berry for Kostas."),
    goal = "MGOAL_FIND_ITEM",
    item = "marloss_berry",
    difficulty = 6,
    value = 10000,
    origins = { "ORIGIN_SECONDARY" },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {},
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("Get a Marloss berry."),
        offer = ccb.content.text("I'm wanting to experiment with some of the more…  otherworldly fauna that have appeared recently.  I saw these pink berries inside a fungal infestation the other day before I burned it with a Molotov.  If you could get me one, I can pay you with a discount on my medicine."),
        accepted = ccb.content.text("Thanks, <name_g>."),
        rejected = ccb.content.text("I understand that it seems formidable, but there is a good deal of money for you."),
        advice = ccb.content.text("I'd wear a hazmat suit while I'm in there.  Those spores are absolutely nasty for your health, if my observations of <zombies> nearby are any indication."),
        inquire = ccb.content.text("Do you have the berry?"),
        success = ccb.content.text("I'll have to be careful with this thing, thanks for getting it for me.  Let's see what this can do…"),
        success_lie = ccb.content.text("Did you eat the thing?  Please tell me your joking."),
        failure = ccb.content.text("That's too bad…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_TOM_1",
    name = ccb.content.text("Digital Revolution"),
    description = ccb.content.text("Get a e-ink tablet PC for Tom Powell."),
    goal = "MGOAL_FIND_ITEM",
    item = "eink_tablet_pc",
    difficulty = 6,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 2 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_TOM_2",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get an e-ink tablet PC."),
        offer = ccb.content.text("I've assembled quite a collection of evidence in my research, and I want an easier way to organize it.  If you could get me one of those e-ink tablets, I could scan all my documents into an easily-preserved digital format.  There's some money for you, too."),
        accepted = ccb.content.text("Thank you, <name_g>.  The truth is ever closer!"),
        rejected = ccb.content.text("Don't you want to know the truth behind <the_cataclysm>?"),
        advice = ccb.content.text("I'd check an electronics store for one."),
        inquire = ccb.content.text("Have you found the tablet?"),
        success = ccb.content.text("Here's the money I promised you.  I'll start organizing my collection."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_TOM_2",
    name = ccb.content.text("Missing Persons"),
    description = ccb.content.text("Find 25 missing person posters for Tom Powell."),
    goal = "MGOAL_FIND_ITEM",
    item = "missing_poster_adult",
    item_count = 25,
    difficulty = 6,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = { item_rewards = { { item = "icon", count = 5 } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_TOM_3",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get 25 missing posters."),
        offer = ccb.content.text("I want to take a look at some of the missing posters for any links.  If you could get me twenty-five of them, I could start my analysis.  Make sure to get posters for adults, I don't think any children could provide links."),
        accepted = ccb.content.text("Thank you, <name_g>.  The truth is ever closer!"),
        rejected = ccb.content.text("Don't you want to know the truth behind <the_cataclysm>?"),
        advice = ccb.content.text("There should be plenty on poster-boards around town.  A police station should have a lot."),
        inquire = ccb.content.text("Have you found the posters?"),
        success = ccb.content.text("I wonder what the link could be.  Too much information?  Government conspiracy?  Aliens?  I'll have to find out."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_TOM_3",
    name = ccb.content.text("Finding Files"),
    description = ccb.content.text("Find 200 files for Tom Powell."),
    goal = "MGOAL_FIND_ITEM",
    item = "file",
    item_count = 200,
    difficulty = 8,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +3, value +1).
    finish = { item_rewards = { { item = "icon", count = 5 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get 200 files."),
        offer = ccb.content.text("I've decided to broaden my horizons with my research, now I need more general documents for examination, get the big picture.  If you could get me two hundred files, on anything, I'll pay you for them."),
        accepted = ccb.content.text("Thank you, <name_g>.  The truth is ever closer!"),
        rejected = ccb.content.text("Don't you want to know the truth behind <the_cataclysm>?"),
        advice = ccb.content.text("Office buildings, police stations, any high-profile place should have what we want."),
        inquire = ccb.content.text("Have you found the files?"),
        success = ccb.content.text("This should occupy my work for a while.  Thanks <name_g>, we'll discover the truth one of these days."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_OLWEN_1",
    name = ccb.content.text("Mathematical Measures"),
    description = ccb.content.text("Find some MatheMAX for Olwen Powell."),
    goal = "MGOAL_FIND_ITEM",
    item = "software_math",
    difficulty = 6,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 1 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_OLWEN_2",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get MatheMAX software."),
        offer = ccb.content.text("I've started working on a small project of mine which requires a great deal of computational input.  A piece of MatheMAX software would be a great help."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("Doing this many calculations by hand isn't very fun, you know."),
        advice = ccb.content.text("I'd check one of the local schools for a USB stick with it."),
        inquire = ccb.content.text("Have you found the software?"),
        success = ccb.content.text("This'll be quite useful in the future.  Thank you, <name_g>."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}
