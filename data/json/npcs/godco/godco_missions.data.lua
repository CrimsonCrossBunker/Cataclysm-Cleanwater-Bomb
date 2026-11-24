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

ccb.content.define_mission {
    id = "MISSION_GODCO_FOOD_GUARD_BETTER_FOOD_STORAGE",
    name = ccb.content.text("Store Up Your Grain"),
    description = ccb.content.text("Find 5,398 pounds of sheet metal (408 units) to help Eddie build a warehouse."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 0,
    item = "sheet_metal",
    item_count = 408,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I'd like to have better food storage."),
        offer = ccb.content.text("I've been drawing up some plans to expand our food storage around here.  Now that we won't starve to death anytime soon, our old crates just aren't cutting it, so we're going to build a small warehouse to store everything, and I've gathered a crew to build it.  We've got most of the materials covered, but we don't have enough sheet metal to make the shelves.  If you could get us about 5,000 pounds of the stuff, I'll pay you handsomely with what we have.  How does that sound?"),
        accepted = ccb.content.text("Just bring it to me when you have it."),
        rejected = ccb.content.text("Alright, I'll find someone else."),
        advice = ccb.content.text("If you can find a steel mill, I'd look there."),
        inquire = ccb.content.text("Do you have the sheet metal?"),
        success = ccb.content.text("I can't thank you enough, here's the pay for it.  Here in a while, we'll have a spot to put all of our food."),
        success_lie = ccb.content.text("Alright, where's it all at?"),
        failure = ccb.content.text("Sorry, I had to find someone else since you didn't come through."),
    },
    -- Native mission phases did not apply the giver opinion (trust +7, value +6, anger -3).
    finish = { actions = { { handler = "start_godco_warehouse" }, { item = "icon", count = 175 } } },
    -- Native mission phases did not apply the giver opinion (anger +3).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_GET_GUITAR_STRING",
    name = ccb.content.text("Obtain a guitar string"),
    description = ccb.content.text("Find a length of tempered steel wire to be used as a guitar string."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "qt_wire",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need a new guitar string."),
        offer = ccb.content.text("One of my guitar strings busted from where I smacked a zombie.  If you could get me a new string, I can fix my guitar."),
        accepted = ccb.content.text("Thanks.  I'll give you a performance when you get back with it."),
        rejected = ccb.content.text("I guess I'll just skip that note."),
        advice = ccb.content.text("I read that musical wire is made of tempered steel.  Music shops should have some, or you could take apart a piano."),
        inquire = ccb.content.text("Do you have it?"),
        success = ccb.content.text("Thank you so much!  This should last for a while."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Don't worry about it, I'll do it myself."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        item_rewards = { { item = "icon", count = 1 } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_completed_sonia_guitar_fixed", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_DARRYL_WELL1",
    name = ccb.content.text("Well Construction"),
    description = ccb.content.text("Find eight pipes for Darryl Johnson."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "pipe",
    item_count = 8,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_GODCO_DARRYL_WELL2",
    dialogue = {
        describe = ccb.content.text("I need eight pipes to start construction."),
        offer = ccb.content.text("Now that's some enthusiasm, pal.  Ever since our water supply shut off, we've been using the nearby river for most of our water needs.  Who knows how many bloated corpses have decayed in that.  I want to construct a well, but I'm missing some building materials - eight pipes to be exact."),
        accepted = ccb.content.text("I wish you the best, pal.  I appreciate it."),
        rejected = ccb.content.text("Come back when you get a chance."),
        advice = ccb.content.text("Try disassembling some lockers.  Just don't destroy our furniture, we'll be needing it."),
        inquire = ccb.content.text("Well, do you have them?"),
        success = ccb.content.text("Great, I can finally start constructing this thing."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I guess it was just a pipe dream."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        map_updates = {
            {
                terrain = "godco_5",
                layout = {
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_null", x = 15, y = 23 },
                        { shape = "point", operation = "terrain", id = "t_covered_well", x = 15, y = 23 },
                    },
                },
            },
        },
        item_rewards = { { item = "icon", count = 3 } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_completed_godco_darryl_mission1", "in-progress"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_DARRYL_WELL2",
    name = ccb.content.text("Water Pump Construction"),
    description = ccb.content.text("Find a mechanical pump for Darryl Johnson."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "well_pump",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_GODCO_DARRYL_COOP1",
    dialogue = {
        describe = ccb.content.text("I need a mechanical pump to finish construction."),
        offer = ccb.content.text("It's less like a well, and more like a covered pit currently.  I'll need you to find a mechanical pump, one that will make this <freaking> thing work."),
        accepted = ccb.content.text("Take care of yourself out there."),
        rejected = ccb.content.text("Come back when you get a chance.  We need skilled survivors."),
        advice = ccb.content.text("Try disassembling another well."),
        inquire = ccb.content.text("Managed to find that pump?"),
        success = ccb.content.text("Much obliged, survivor.  Thanks to you, we don't need to worry about where our water's gonna come from.  Here, take this as a token of our gratitude."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        map_updates = {
            {
                terrain = "godco_5",
                layout = {
                    tile_edits = {
                        { shape = "point", operation = "terrain", id = "t_water_pump", x = 15, y = 23 },
                    },
                },
            },
        },
        item_rewards = { { item = "icon", count = 5 } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_completed_godco_darryl_mission1", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_DARRYL_COOP1",
    name = ccb.content.text("Chicken Coop Construction"),
    description = ccb.content.text("Get 150 nails for Darryl."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "nail",
    item_count = 150,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I need nails to build a chicken coop"),
        offer = ccb.content.text("Now that we've got a steady supply of water, I've been thinking about raising some livestock.  I'm starting with some chickens I found on a farm the other day, but I don't have a coop for them.  If you can get me 150 nails, I can start building one."),
        accepted = ccb.content.text("Take care of yourself out there."),
        rejected = ccb.content.text("Its a simple job."),
        advice = ccb.content.text("You could take apart some furniture in town, or make them yourself."),
        inquire = ccb.content.text("Got the nails?"),
        success = ccb.content.text("Thank you.  I should have some eggs in a week, once I finish the coop.  Come back and buy some!"),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = { actions = { { handler = "start_godco_coop" }, { item = "icon", count = 5 } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_RUSSELL_TROPHY1",
    name = ccb.content.text("Trophy Hunt I"),
    description = ccb.content.text("Help Russell Connelly expand his trophy collection by gathering three hunks of slime glob."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "slimepit_z0", special = "Slime Pit", reveal_radius = 3 } },
    item = "slime_scrap",
    item_count = 3,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_GODCO_RUSSELL_TROPHY2",
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("I have the location for an alien crash site.  I want you to investigate and bring me anything you'd find interesting."),
        accepted = ccb.content.text("Good luck out there!"),
        rejected = ccb.content.text("That's all right.  Not everyone is cut out for this."),
        advice = ccb.content.text("Worst case scenario you'll be covered in slime.  There's nothing to fear, I hope."),
        inquire = ccb.content.text("Any luck, survivor?"),
        success = ccb.content.text("Good one!  Survivor, you have just passed my test.  I knew you could do it.  Your work shall be rewarded!"),
        success_lie = ccb.content.text("You liar!"),
        failure = ccb.content.text("You give up?  This country fell apart because no one could find a good man to rely on… might as well give up, I guess."),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +1).
    finish = { item_rewards = { { item = "icon", count = 4 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_RUSSELL_TROPHY2",
    name = ccb.content.text("Trophy Hunt II"),
    description = ccb.content.text("Continue the quest for trophies by finding an unhatched spider egg."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_GODCO_RUSSELL_TROPHY3",
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("<the_cataclysm> didn't spare us humans.  Our former selves would look at us in disgust at the things we do for survival.  At least, that's what I was told.  I heard reports of arachnids deep in the woods.  I can't exactly pinpoint where their webs are, but I'm sure you'll figure it out once you're stuck in them.  I'd like me a spider egg!"),
        accepted = ccb.content.text("Thanks, make sure you're ready for whatever beast is waiting for you."),
        rejected = ccb.content.text("That's all right.  Not everyone is cut out for this."),
        advice = ccb.content.text("Don't worry <name_g>, I wouldn't send you on a suicide mission, would I?"),
        inquire = ccb.content.text("Managed to succeed, survivor?"),
        success = ccb.content.text("Nice catch!  Friend, you've proven yourself to be an extraordinary survivor.  Maybe there's still hope for humanity.  I'll take that egg, thank you very much.  Here's your reward and some bullets for your effort."),
        success_lie = ccb.content.text("You liar!"),
        failure = ccb.content.text("You give up?  This country fell apart because no one could find a good man to rely on… might as well give up, I guess."),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        item_rewards = { { item = "270win_jsp", count = 8 }, { item = "icon", count = 6 } },
        handler = "deliver_mission_godco_russell_trophy2",
    },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    complete_when = "complete_mission_godco_russell_trophy2",
}

ccb.content.define_mission {
    id = "MISSION_GODCO_RUSSELL_TROPHY3",
    name = ccb.content.text("Trophy Hunt III"),
    description = ccb.content.text("Bring one last trophy to Russell Connelly.  Harvest a sting from a bee."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 0,
    start = { target = { terrain = "hive", special = "Bee Hive", reveal_radius = 3 } },
    item = "bee_sting",
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("It feels like I'm doing this for revenge.  I have one last mission for you.  Ever seen those ginormous bee hives?  Well, I can tell you where the closest one is.  Just kill off one stray bee, harvest its stinger and bring it to me."),
        accepted = ccb.content.text("I wish you the best of luck, may God guide your path."),
        rejected = ccb.content.text("This passion of mine may just be getting to me…"),
        advice = ccb.content.text("If I were you, I'd bring a gun and a butcher knife.  I don't think bug spray work anymore."),
        inquire = ccb.content.text("How is the hunt going, survivor?  Any luck?"),
        success = ccb.content.text("Well, partner, this might just be the end of the road.  I hope you enjoyed it as much as I have.  In the meantime… here's your reward, a handful of icons, that's all I have left.  Spend them all, I think you've deserved it."),
        success_lie = ccb.content.text("You liar!"),
        failure = ccb.content.text("You give up now?  This country fell apart because no one could find a good man to rely on… might as well give up, I guess."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            { item = "270win_jsp", count = 16 },
            { item = "icon", count = 8 },
            ccb.content.dialogue_actions.add_effect("interlocutor", "hunt_godco_russell", { permanent = true }),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

-- Quest handled via external dialogue, player will never see this text.
ccb.content.define_mission {
    id = "MISSION_GODCO_ZACHARY_KILL_NIGHTMARE",
    name = ccb.content.text("End The Nightmare"),
    goal = "MGOAL_KILL_MONSTER",
    description = ccb.content.text("Kill whatever's keeping Zachary up at night."),
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "forest", reveal_radius = 1, random = false, min_distance = 5, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = { { id = "mon_zombie_screecher", x = 11, y = 11, target = true } },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {
        handler = "mark_mission_meeting_zachary_willing_to_follow",
        item_rewards = { { item = "icon", count = 12 } },
    },
    -- Native mission phases did not apply the giver opinion (anger +3).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Kill whatever's keeping Zachary up at night."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("Any luck with that horror?"),
        success = ccb.content.text("Oh thank you!  Now I can finally get a nights sleep.  Here, I've got some icons saved up, I want you to have them."),
        success_lie = ccb.content.text("I can still hear it, crying out in the night."),
        failure = ccb.content.text("I'm not gonna go and fix this <freaking> mess."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_GREENWOOD_1",
    name = ccb.content.text("Fungus Among Us"),
    description = ccb.content.text("Purge the cultists in exchange for <reward_count:icon> icons."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 4,
    value = 0,
    start = {
        target = { terrain = "field", reveal_radius = 1, random = true, min_distance = 20 },
        map_updates = {
            {
                layout = {
                    rows = {
                        "     ..............     ",
                        "  .........&&.........  ",
                        " ......,,,&,,,,,,...... ",
                        " ....,,,,,&,&,,,,,,.... ",
                        " ...,,,,,&&__&,,,,,,... ",
                        "...,,,,&&&___&___,,,,...",
                        "...,,,&&____&_____,,&...",
                        "..,,,,_&&&&&___&__&&,,..",
                        "..&&,_&__&__&&&_&&_,,,..",
                        "..,,&_&_&_______&__,,,..",
                        "..,,_&_&&_______&__&&,..",
                        "..,&&&_&___XX_&&&&&&,,..",
                        ".&&,&__&___XX_&_&___,,..",
                        "..&,&__&&_____&_&_&_,,..",
                        "..&&&&__&&&&&&___&&,,,..",
                        "..,&,&&_______&____,,,..",
                        "..,&,,&____&&&___&&&,,..",
                        "...&,,&&__&____&&_,,,...",
                        "..&,,,,&&&_&&&&__,,,,...",
                        " ...,,,,,&__&_,,,,,,... ",
                        " ....,,,&&,,,&,,,,,.... ",
                        " ......&,,,,,,&&,...... ",
                        "  ..............&&....  ",
                        "     ..............     ",
                    },
                    flags = { "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN" },
                    monster_placements = {
                        { id = "mon_marloss_zealot_m", x = 10, y = 10, target = true },
                        { id = "mon_marloss_zealot_f", x = 11, y = 11, target = true },
                        { id = "mon_marloss_zealot_m", x = 12, y = 12, target = true },
                        { id = "mon_marloss_zealot_f", x = 13, y = 13, target = true },
                    },
                    terrain = {
                        [" "] = {
                            { id = "t_grass_dead", copies = 4 },
                            { id = "t_dirtmound" },
                            { id = "t_grass" },
                            { id = "t_fungus" },
                        },
                        ["."] = { { id = "t_grass_dead", copies = 2 }, { id = "t_fungus" } },
                        [","] = {
                            { id = "t_grass_dead", copies = 3 },
                            { id = "t_fungus", copies = 7 },
                            { id = "t_fungus_mound" },
                        },
                        _ = {
                            { id = "t_fungus", copies = 25 },
                            { id = "t_fungus_mound" },
                            { id = "t_tree_fungal", copies = 3 },
                            { id = "t_tree_fungal_young", copies = 2 },
                        },
                        ["&"] = "t_fungus_mound",
                        X = "t_marloss",
                    },
                    furniture = {
                        [" "] = {
                            { id = "f_null", copies = 18 },
                            { id = "f_boulder_small", copies = 3 },
                            { id = "f_boulder_medium", copies = 2 },
                            { id = "f_boulder_large" },
                            { id = "f_flower_fungal", copies = 2 },
                            { id = "f_fungal_mass" },
                        },
                        ["."] = {
                            { id = "f_null", copies = 18 },
                            { id = "f_flower_fungal", copies = 4 },
                            { id = "f_fungal_mass", copies = 3 },
                            { id = "f_fungal_clump" },
                        },
                        [","] = {
                            { id = "f_null", copies = 12 },
                            { id = "f_fungal_mass", copies = 2 },
                            { id = "f_flower_fungal" },
                            { id = "f_fungal_clump" },
                        },
                        _ = {
                            { id = "f_null", copies = 10 },
                            { id = "f_fungal_mass", copies = 2 },
                            { id = "f_fungal_clump" },
                        },
                        ["&"] = {
                            { id = "f_fungal_tangle", copies = 8 },
                            { id = "f_fungal_clump" },
                            { id = "f_fungal_mass" },
                        },
                    },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = { item_rewards = { { item = "icon", count = 15 } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_GREENWOOD_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("There's a weird fungus that started to invade ever since <the_cataclysm>, and several individuals in strange robes are cultivating it.  I've seen what it can do, so I need you to execute them and destroy all traces of these strange mushrooms."),
        accepted = ccb.content.text("God bless you!"),
        rejected = ccb.content.text("That fungus is going to kill us all if it isn't stopped."),
        advice = ccb.content.text("Despite how fast it grows, it's highly vulnerable to fire."),
        inquire = ccb.content.text("Have you dealt with them?"),
        success = ccb.content.text("Thank you.  I don't like killing people, but this time we had to.  Here, take this; its some of our internal money that we've started using.  You know those religious pamphlets shaped like bills people would leave?  These are some of those, couldn't stand 'em myself."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("We'll have to try again, I suppose."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_GREENWOOD_2",
    name = ccb.content.text("Relic Recovery"),
    description = ccb.content.text("Retrieve a religious relic for Greenwood in exchange for <reward_count:icon> icons."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "small_relic",
    start = {
        target = { terrain = "cathedral_1_SE", special = "cathedral", reveal_radius = 1, random = false },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_GREENWOOD_3",
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("I've been looking to spruce up this place with some iconography, and a small relic would do just that.  It'd help tremendously with morale around here, so I need you to find one for me."),
        accepted = ccb.content.text("Please bring it back as soon as possible."),
        rejected = ccb.content.text("It'd really help us…"),
        advice = ccb.content.text("I know most cathedrals keep small relics, that's a good place to look."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Thank you, <name_g>.  Take these for your trouble."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I'll have to make my own, I guess…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 10 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

-- 5.50 (price of bibles) x 20 (count), with a 10% upcharge as a delivery fee. Divide by 2.50 to convert to icons.
ccb.content.define_mission {
    id = "MISSION_GODCO_GREENWOOD_3",
    name = ccb.content.text("Bible Belt"),
    description = ccb.content.text("Find twenty King James Bibles for Greenwood in exchange for <reward_count:icon> icons."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "holybook_bible1",
    item_count = 20,
    start = {
        target = { terrain = "s_bookstore", special = "s_bookstore", reveal_radius = 1, random = false },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need your help…"),
        offer = ccb.content.text("When we skipped town during <the_cataclysm>, most of us left our possessions behind.  We only have a few Bibles here for all of us, and they're starting to fall apart.  If you could get 20 more, in the King James version, I'd pay well for them."),
        accepted = ccb.content.text("May God bless you."),
        rejected = ccb.content.text("It'd really help us…"),
        advice = ccb.content.text("A book store should have enough, I'll mark one for you."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("May God bless you, <name_g>."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I'll have to make my own, I guess…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 48 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_JULIAN_PAPER",
    name = ccb.content.text("Remnants of Civilization"),
    description = ccb.content.text("Find ten rolls of toilet paper for Julian Ray."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "toilet_paper",
    item_count = 10,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_JULIAN_RINGS",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I have a job for you…"),
        offer = ccb.content.text("As a matter of fact, yes you can.  You see, we're running low on toilet paper.  It's not something we can't live without, but it's luxury we can afford.  I can pay you handsomely if you find us ten rolls of toilet paper."),
        accepted = ccb.content.text("Well, that's great.  Good luck."),
        rejected = ccb.content.text("Changed your mind already?"),
        advice = ccb.content.text("You remember what toilet paper is, right?"),
        inquire = ccb.content.text("How's the search going?  Any luck?"),
        success = ccb.content.text("Thank you.  Maybe you people aren't so bad after all."),
        success_lie = ccb.content.text("Could you give it to me then?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = { item_rewards = { { item = "icon", count = 8 } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
}

ccb.content.define_mission {
    id = "MISSION_GODCO_JULIAN_RINGS",
    name = ccb.content.text("The Honeymooners"),
    description = ccb.content.text("Get two wedding rings for Julian."),
    goal = "MGOAL_FIND_ITEM",
    item = "ring_wedding",
    difficulty = 7,
    item_count = 2,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +4, value +4).
    finish = {
        item_rewards = { { item = "icon", count = 20 } },
        handler = "set_world_godco_julian_wedding_to_1",
    },
    -- Native mission phases did not apply the giver opinion (anger +4).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_JULIAN_DRESS",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get two wedding rings."),
        offer = ccb.content.text("Olwen and I have been dating for a while now, and I was planning on asking her to marry me.  I never got the chance to buy our rings before <the_cataclysm>, but I think I'll surprise her with some in a few days.  If you could get me two of them, I'll pay a fair price: $50 in icons."),
        accepted = ccb.content.text("Thanks <name_g>, I'm counting on you."),
        rejected = ccb.content.text("I'd mean so much to the both of us, and there's a lot of money involved."),
        advice = ccb.content.text("A jewelry store should have a pair.  If not, I'd check a wedding venue."),
        inquire = ccb.content.text("Have you found the rings?"),
        success = ccb.content.text("Here's the money, as per our terms.  I really do appreciate this."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("I'll have to look for them myself…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_JULIAN_DRESS",
    name = ccb.content.text("The Wedding"),
    description = ccb.content.text("Get a wedding dress for Julian's wedding with Olwen."),
    goal = "MGOAL_FIND_ITEM",
    item = "dress_wedding",
    difficulty = 7,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +4, value +4).
    finish = {
        item_rewards = { { item = "icon", count = 25 } },
        handler = "set_world_godco_julian_wedding_to_2",
    },
    -- Native mission phases did not apply the giver opinion (anger +4).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get a wedding dress."),
        offer = ccb.content.text("Olwen said yes!  I can't thank you enough <name_g>, she was delighted.  I now want to give her a proper wedding like the ones before <the_cataclysm>, but I can't find a good enough dress for her in here.  If you could get me a proper wedding dress, I'll reward you handsomely."),
        accepted = ccb.content.text("Thanks <name_g>, I knew I could count on you."),
        rejected = ccb.content.text("Please!  I only want to give her a beautiful day like she deserves, and if you help me I can pay you like before."),
        advice = ccb.content.text("A mall should have some in exhibition.  If not, I'd check a wedding venue or clothing store."),
        inquire = ccb.content.text("Have you found the dress?"),
        success = ccb.content.text("It's beautiful!  Thank you, she will love it, You are definitely invited to the wedding <name_g>!  I hope to see you there!"),
        success_lie = ccb.content.text("Why would you do this?!"),
        failure = ccb.content.text("Well, thanks for trying…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_GEMMA_SUPPLEMENTS",
    name = ccb.content.text("Retrieve the fertility supplements"),
    description = ccb.content.text("Get Gemma's 25 fertility supplements."),
    goal = "MGOAL_FIND_ITEM",
    item = "fert_supplement",
    item_count = 25,
    difficulty = 1,
    value = 0,
    start = {
        target = {
            terrain = "s_pharm",
            special = "s_pharm",
            reveal_radius = 1,
            random = false,
            min_distance = 3,
        },
        map_updates = {
            { layout = { item_group_placements = { { group = "fertility_supplements", x = 15, y = 15 } } } },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        actions = {
            { item = "icon", count = 15 },
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_meeting_gemma_got_supplements", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some supplements."),
        offer = ccb.content.text("To be honest, I'm not alright.  Have you met Darryl?  He's my husband, and we had a go at getting a baby recently.  The thing is, its not happening.  Now that we're in a safe spot, on our feet again, I want to try.  I'm trying to find some fertility supplements.  I ordered some before <the_cataclysm>, but I never got to pick them up.  If you'd go over and get them for me, I'd pay you."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("This means so much to me."),
        advice = ccb.content.text("They should be near the counter, or on a shelf."),
        inquire = ccb.content.text("Have you found my pills?"),
        success = ccb.content.text("Oh thank you!  Darryl will be so happy to hear about this!  Take there for your payment, it must've been hard for you."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("How unfortunate…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_GEMMA_SEEDS",
    name = ccb.content.text("Find cactus seeds"),
    description = ccb.content.text("Find ten cactus seeds for Gemma."),
    goal = "MGOAL_FIND_ITEM",
    item = "seed_cactus",
    item_count = 10,
    difficulty = 1,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = { item_rewards = { { item = "icon", count = 5 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some cactus seeds."),
        offer = ccb.content.text("I'm wanting to try growing some new plants.  I've never tried growing cactus; if you could find some seeds for me, I'd pay you."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("I suppose more local fauna could work."),
        advice = ccb.content.text("I'd try a gardening store or a home supply store would have some."),
        inquire = ccb.content.text("Have you found any cactus seeds?"),
        success = ccb.content.text("I appreciate that, here's your money.  Parts of the cactus, such as the fruit, are edible.  I'll have to ask Simon if he can experiment with some of them."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("How unfortunate…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_JANE_PILLS",
    name = ccb.content.text("Retrieve Thorazine"),
    description = ccb.content.text("Get 75 anti-psychotics for Jane."),
    goal = "MGOAL_FIND_ITEM",
    item = "thorazine",
    item_count = 75,
    difficulty = 3,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {
        actions = {
            { item = "icon", count = 150 },
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_meeting_jane_willing_to_follow", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +3).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some antipsychotics."),
        offer = ccb.content.text("I'm running out of antipsychotics, and Arturo is starting to see things again.  I'd pay for seventy-five antipsychotic pills, and be eternally grateful."),
        accepted = ccb.content.text("Thank you.  Arturo will be happy to get these."),
        rejected = ccb.content.text("Would you please reconsider?  Arturo's had some bad hallucinations before, he'll go crazy without them."),
        advice = ccb.content.text("The storage room of a pharmacy should have them."),
        inquire = ccb.content.text("Have you found the antipsychotics?"),
        success = ccb.content.text("God bless you, <name_g>.  Arturo shouldn't have to worry about his hallucinations for a long time."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("How unfortunate…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_CORRIE_MACHINE1",
    name = ccb.content.text("Renewable Energy"),
    description = ccb.content.text("Find a solar panel array or 4 solar panels of either regular or advanced variant for Corrie."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I have a plan…"),
        offer = ccb.content.text("Okay, great.  We're gonna create a charger and a generator all in one.  Here's the battle plan.  Zack could create the framework, you'll get me a solar panel, the rest I can craft or repurpose from the bus.  Helena's promised us a reward if this thing lives up to her standards."),
        accepted = ccb.content.text("With my brains and your brawn we'll make an excellent team.  A regular solar panel will do just fine."),
        rejected = ccb.content.text("No electricity for us then."),
        advice = ccb.content.text("All you need is a good wrench and a solar car."),
        inquire = ccb.content.text("Do you have the solar panel?"),
        success = ccb.content.text("The great work is now complete.  Are you good with words, by the way?  I was thinking, maybe you should be the one to negotiate with Helena.  But whatever you do, don't accept their icons.  Our work is worth a lot more than their valueless currency."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("No electricity for us then."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            { handler = "deliver_mission_godco_corrie_machine1" },
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_completed_godco_corrie_machine", "in-progress"),
            ccb.content.dialogue_actions.update_map("place_solar_farm", "godco_1"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    complete_when = "complete_mission_godco_corrie_machine1",
}

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

ccb.content.define_mission {
    id = "MISSION_GODCO_KATHERINE_1",
    name = ccb.content.text("Fishy Business"),
    description = ccb.content.text("Find three cans of sardines, tuna, or salmon for Katherine."),
    goal = "MGOAL_CONDITION",
    difficulty = 6,
    value = 0,
    -- Native mission phases did not apply the giver opinion (value +1).
    finish = { item_rewards = { { item = "icon", count = 6 } }, handler = "deliver_mission_godco_katherine_1" },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get some tuna."),
        offer = ccb.content.text("I've had a craving for fish recently.  Could you find three cans of tuna for me?  I'll pay you for them."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("Alright.  I'll do it myself."),
        advice = ccb.content.text("A house or grocery store should have some."),
        inquire = ccb.content.text("Have you found the fish?"),
        success = ccb.content.text("Thank you, here's your payment."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
    complete_when = "complete_mission_godco_katherine_1",
}

ccb.content.define_mission {
    id = "MISSION_GODCO_KOSTAS_1",
    name = ccb.content.text("Natural Chemistry"),
    description = ccb.content.text("Get a chemistry set for Kostas."),
    goal = "MGOAL_FIND_ITEM",
    item = "chemistry_set",
    difficulty = 3,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +2, value +1).
    finish = { item_rewards = { { item = "icon", count = 12 } } },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_KOSTAS_2",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get a chemistry set."),
        offer = ccb.content.text("I've decided to start making more concentrated remedies for more serious cases, but I don't have a way of refining any herbs to that degree.  I'd pay for a chemistry set."),
        accepted = ccb.content.text("Thanks, <name_g>."),
        rejected = ccb.content.text("We could all use the medicine, including you."),
        advice = ccb.content.text("A laboratory or pharmaceutical factory should have one."),
        inquire = ccb.content.text("Have you found the chemistry set?"),
        success = ccb.content.text("Blessings be unto you."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}

-- Enough pebbles for 28 planters.
ccb.content.define_mission {
    id = "MISSION_GODCO_KOSTAS_2",
    name = ccb.content.text("Pebble Pusher"),
    description = ccb.content.text("Get 814 pounds of pebbles (5,600 pebbles) for Kostas."),
    goal = "MGOAL_FIND_ITEM",
    item = "pebble",
    item_count = 5600,
    difficulty = 5,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +3, value +2).
    finish = { actions = { { item = "icon", count = 120 }, { handler = "start_godco_garden" } } },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GODCO_KOSTAS_3",
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get 5,600 pebbles."),
        offer = ccb.content.text("Demand for my herbal medicine has gone up recently, and I'm struggling to get all of my ingredients sustainably.  I'm going to build some planters on the rooftop, but I lack the material to do so in full.  I'd compensate you fairly for 814 pounds of pebbles."),
        accepted = ccb.content.text("Thanks, <name_g>."),
        rejected = ccb.content.text("I understand that it seems formidable, but there is a good deal of money for you."),
        advice = ccb.content.text("An outdoor emporium should have some.  Of course, you could always dig them up from a lakeshore or driveway."),
        inquire = ccb.content.text("Do you have the pebbles?"),
        success = ccb.content.text("Blessings be unto you.  I'll start on the garden right away."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}

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

ccb.content.define_mission {
    id = "MISSION_GODCO_OLWEN_2",
    name = ccb.content.text("Radio-active"),
    description = ccb.content.text("Get six antennae for Olwen Powell."),
    goal = "MGOAL_FIND_ITEM",
    item = "antenna",
    item_count = 6,
    difficulty = 4,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        actions = {
            { item = "icon", count = 6 },
            ccb.content.dialogue_actions.update_map("olwen_radio_adapter", "godco_1_2"),
            ccb.content.dialogue_actions.set_actor_value("speaker", "general_mission_godco_has_radio", "yes"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +2).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get six antennae."),
        offer = ccb.content.text("Corrie and I have been working on a way to get in touch with anyone who's still out there, and we've started rigging up an internet-to-radio broadcast.  The only thing we need are antennae, six of them specifically."),
        accepted = ccb.content.text("This could give us a prosperous future, <name_g>."),
        rejected = ccb.content.text("We've got to see how many people are out there."),
        advice = ccb.content.text("A radio tower should have some lying around in storage."),
        inquire = ccb.content.text("Have you found the antennae?"),
        success = ccb.content.text("Now we can get in touch with a lot more people, see what's out there.  Thank you, <name_g>."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("That's too bad…"),
    },
}

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

ccb.content.define_mission {
    id = "MISSION_GODCO_HELENA_3",
    name = ccb.content.text("Purging Heresy"),
    description = ccb.content.text("Kill some bandits for Helena Misinter."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 13,
    value = 0,
    start = {
        target = { terrain = "church", special = "church", reveal_radius = 1, random = true },
        map_updates = {
            {
                layout = {
                    npc_placements = {
                        { id = "bandit", x = 15, y = 8, target = true },
                        { id = "thug", x = 12, y = 10, target = true },
                        { id = "bandit", x = 9, y = 13, target = true },
                        { id = "bandit", x = 8, y = 15, target = true },
                        { id = "thug", x = 17, y = 15, target = true },
                    },
                },
            },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +3, value +2).
    finish = { item_rewards = { { item = "icon", count = 60 } } },
    -- Native mission phases did not apply the giver opinion (anger +4).
    failure = {},
    followup = "MISSION_GODCO_HELENA_4",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Purge the heretics."),
        offer = ccb.content.text("Blasphemy, heresy, the righteous judgment of God!  I have found the scum of Hell pillaging a church for valuables!  Even in <the_cataclysm>, I shall not stand for this.  I want you to go there and wipe those <freaking> <name_b>s from the Earth."),
        accepted = ccb.content.text("Righteous judgment shall come!"),
        rejected = ccb.content.text("Are you standing with them?"),
        advice = ccb.content.text("Attack at night to surprise them.  Barring that, go in full force, guns blazing.  I wouldn't try to call a horde in, I don't want to ruin such a holy place."),
        inquire = ccb.content.text("Are the heretics purged?"),
        success = ccb.content.text("Thank you."),
        success_lie = ccb.content.text("Why have you failed us?!"),
        failure = ccb.content.text("As expected of such a person…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_HELENA_4",
    name = ccb.content.text("Preservation of Sustenance"),
    description = ccb.content.text("Find five canning pots for Helena Misinter."),
    goal = "MGOAL_FIND_ITEM",
    item = "pot_canning",
    item_count = 5,
    difficulty = 5,
    value = 0,
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        before_rewards = "set_world_godco_has_canningpots_to_1",
        item_rewards = {
            { item = "icon", count = 30 },
            { item = "pickled_egg", count = 10, container = "jar_glass_sealed" },
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Get five canning pots."),
        offer = ccb.content.text("While we are blessed with a bountiful stock, we need a way to preserve our newer food, mainly those potatoes Darryl's growing.  Fortunately, he brought a book on canning things.  We need five canning pots to get the setup going in full fashion."),
        accepted = ccb.content.text("May the Lord bless you."),
        rejected = ccb.content.text("I'll find someone else, then."),
        advice = ccb.content.text("An old factory might have one, or a hobby shop."),
        inquire = ccb.content.text("Have you found the canning pots?"),
        success = ccb.content.text("Thank you.  You're welcome to some of our first batch, if you're interested."),
        success_lie = ccb.content.text("What good is this?"),
        failure = ccb.content.text("As expected of such a person…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GODCO_HELENA_VISIT_MERCHANTS",
    name = ccb.content.text("Investigate the Center"),
    description = ccb.content.text("Go to the location Helena told you about and see who's there."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    start = "reveal_refugee_center",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        before_rewards = "set_world_godco_met_merchants_to_0",
        item_rewards = { { item = "icon", count = 5 } },
        handler = "wait_half_hour",
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("See who's over there."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("What have you found out?"),
        success = ccb.content.text("This should be very useful to us.  Now we can truly begin our march of righteousness."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("As expected of such a person…"),
    },
    complete_when = "complete_mission_godco_helena_visit_merchants",
}

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
