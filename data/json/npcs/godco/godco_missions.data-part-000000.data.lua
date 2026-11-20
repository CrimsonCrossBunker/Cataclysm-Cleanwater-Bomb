local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_COOK_FOOD_1",
    name = ccb.content.text("Picky Meals"),
    description = ccb.content.text("Find 15 pounds (2000 units) of salt."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "salt",
    item_count = 2000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_COOK_FOOD_2",
    dialogue = {
        describe = ccb.content.text("I need a supply of salt."),
        offer = ccb.content.text("I know this doesn't sound important, but I am running low on salt.  We don't just need it as a seasoning, it's also vital for food preservation.  Could you find about 15 pounds of salt for me?"),
        accepted = ccb.content.text("Don't forget to tell me when you have them."),
        rejected = ccb.content.text("It's okay, I can do without them.  Just let me know if you reconsider."),
        advice = ccb.content.text("There's a lot of places to look.  They are common in house kitchens, restaurants or grocery stores."),
        inquire = ccb.content.text("How is the search going?  Have you found 'em?"),
        success = ccb.content.text("I really appreciate your help.  Don't worry, you won't leave empty-handed."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Don't worry about it, it's not that important."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 20 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_COOK_FOOD_2",
    name = ccb.content.text("Pickled Meals"),
    description = ccb.content.text("Find 40 glass jars (3 L)."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "jar_3l_glass_sealed",
    item_count = 40,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_COOK_FOOD_3",
    dialogue = {
        describe = ccb.content.text("I need several glass jars."),
        offer = ccb.content.text("This task is bit more serious.  I don't have enough jars to preserve perishables for the future, and we can't just store everything in salt.  We could do our own canning if we had some more glass jars.  I think 40 jars should be enough."),
        accepted = ccb.content.text("Thanks for accepting this task.  It'll take a load off my shoulders.  I finally won't have to worry about this problem anymore."),
        rejected = ccb.content.text("Just let me know if you change your mind."),
        advice = ccb.content.text("Glass jars are not that hard to find.  I'd look for them in residential areas."),
        inquire = ccb.content.text("Have you found the jars?"),
        success = ccb.content.text("Thank you for your help.  Here's your reward.  I have one more task to do."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("It's not a big deal, it isn't that urgent."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 10 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_COOK_FOOD_3",
    name = ccb.content.text("Prickled Meals"),
    description = ccb.content.text("Find a butcher knife."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "knife_huge",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need something sharper."),
        offer = ccb.content.text("I don't have any butcher knives in here.  It's difficult to cut anything hard without it.  It's good to have one, even though I won't use it that often.  Could you get me one, or anything similarly suitable?"),
        accepted = ccb.content.text("Thank you for accepting.  I can't cut anything with this dull knife."),
        rejected = ccb.content.text("I guess I have to cut them with my steak knife."),
        advice = ccb.content.text("Butcher knives are not that rare to find.  They are commonly found in kitchens."),
        inquire = ccb.content.text("Do you have that knife now?"),
        success = ccb.content.text("I am grateful for the help you've done."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Don't worry about it, it's not that important."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 2 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_FOOD_GUARD_BOOK",
    name = ccb.content.text("Busy While Working"),
    description = ccb.content.text("Find 3 mystery novels."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "novel_mystery",
    item_count = 3,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I'd like to read some mystery novels."),
        offer = ccb.content.text("Sometimes it gets a little bit boring up here, and I like to read something to take my mind off of things.  Problem is, I've run out of books.  I've been wanting to read some mystery novels as of late, so could you get me three of them?"),
        accepted = ccb.content.text("Just bring them to me when you have it."),
        rejected = ccb.content.text("Nevermind then.  I hope you'll change your mind."),
        advice = ccb.content.text("I'd loot libraries and bookstores."),
        inquire = ccb.content.text("So, have you found the books?"),
        success = ccb.content.text("Thank you.  This will keep me busy for a while.  Please take this as a token of my gratitude."),
        success_lie = ccb.content.text("Could you give them to me?"),
        failure = ccb.content.text("Fine.  I can read something else."),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +1).
    finish = { item_rewards = { { item = "icon", count = 18 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_FOOD_GUARD_CANNING_STARTUP",
    name = ccb.content.text("Canning Startup"),
    description = ccb.content.text("Find 100 medium tin cans to can with."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "can_medium",
    item_count = 100,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_FOOD_GUARD_GET_TRAP_BOOK",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I'd like to have some cans to store food in."),
        offer = ccb.content.text("Now that we have some canning pots from Helena, we can start storing foodstuffs more easily around here.  Recycling our old tin cans is great and all, but if we get a big influx of new foods, then we can't properly store it all.  As such, if you could find about 100 more empty medium tin cans for me, I'd really appreciate it."),
        accepted = ccb.content.text("Just bring it to me when you have it."),
        rejected = ccb.content.text("Nevermind then.  I hope you'll change your mind."),
        advice = ccb.content.text("I'd look anywhere there's food waste or scrap piles.  We can wash out the cans when we get them."),
        inquire = ccb.content.text("So, have you found the cans?"),
        success = ccb.content.text("Thank you, now we won't have to worry about running out of food in the winter."),
        success_lie = ccb.content.text("Could you give them to me?"),
        failure = ccb.content.text("Fine.  I'll get them myself."),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +1).
    finish = { item_rewards = { { item = "icon", count = 10 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_FOOD_GUARD_GET_TRAP_BOOK",
    name = ccb.content.text("Find a copy of The Modern Trapper"),
    description = ccb.content.text("Find a copy of The Modern Trapper so Eddie can learn how to lay traps."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "manual_traps",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_FOOD_GUARD_BETTER_FOOD_STORAGE",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I'd like to read some trapping guides."),
        offer = ccb.content.text("Since we've got all the stuff to store away food, I figure that it's time we get some more.  I've been talking it over with Russell, and I think setting out animal traps is a good way to go.  The problem is, nobody here knows how to do it.  I've heard that The Modern Trapper is a good place to start, so if you could get me a copy, I'd really appreciate it."),
        accepted = ccb.content.text("Just bring it to me when you have it."),
        rejected = ccb.content.text("Too trivial for you?"),
        advice = ccb.content.text("I'd loot libraries and bookstores."),
        inquire = ccb.content.text("So, have you found it?"),
        success = ccb.content.text("Thank you, me and Russell will start studying it soon."),
        success_lie = ccb.content.text("Where is it?"),
        failure = ccb.content.text("Fine.  I can read something else."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 9 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}
