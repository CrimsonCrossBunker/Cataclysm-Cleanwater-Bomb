local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_EXPLORE_SARCOPHAGUS",
    name = ccb.content.text("Follow Sarcophagus Team"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 50000,
    start = {
        target = {
            terrain = "haz_sar_b_4",
            special = "Hazardous Waste Sarcophagus",
            reveal_radius = 1,
            min_distance = 60,
        },
        item_rewards = { { item = "sarcophagus_access_code" } },
        native_actions = { "follow" },
    },
    origins = { "ORIGIN_SECONDARY" },
    destination = "haz_sar_b_4",
    dialogue = {
        describe = ccb.content.text("You wouldn't believe what I found…"),
        offer = ccb.content.text("Holy hell, the crash you recovered the black box from wasn't as old as I thought.  Check this out, it was on its approach to pick up a team sent to secure and destroy something called a 'Hazardous Waste Sarcophagus' in the middle of nowhere.  If the bird never picked up the team then we may still have a chance to meet up with them.  It includes an access code for the elevator and an encoded message for the team leader, I guess.  If we want to join up with what remains of the government then now may be our only chance."),
        accepted = ccb.content.text("Fuck ya, America!"),
        rejected = ccb.content.text("Are you going to forfeit your duty when the country needs you the most?"),
        advice = ccb.content.text("If there is a military team down there then we better go in prepared if we want to impress them.  Carry as much ammo as you can and prepare to ditch this place if they have a second bird coming to pick them up."),
        inquire = ccb.content.text("Having any trouble following the map?  Remember to search underground."),
        success = ccb.content.text("Maybe these things are what remains of the team we were searching for…"),
        success_lie = ccb.content.text("What?!  I oughta whip your ass."),
        failure = ccb.content.text("Damn, we were so close."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_INHALER",
    name = ccb.content.text("Find Inhaler"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 150000,
    urgent = true,
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    deadline = { "2 days", "3 days" },
    dialogue = {
        describe = ccb.content.text("I'm… short… of breath…"),
        offer = ccb.content.text("I'm asthmatic.  I need you to get an inhaler for me…"),
        accepted = ccb.content.text("Oh, thank god, thank you so much!  I won't last more than a couple of days, so hurry…"),
        rejected = ccb.content.text("What?!  Please, I'll be dead soon without your help!"),
        advice = ccb.content.text("There's a town nearby.  Check pharmacies; it'll be in the back with the good stuff."),
        inquire = ccb.content.text("Find any inhaler yet?"),
        success = ccb.content.text("Oh thank god!  I'll be right as rain in no time."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("How am I not dead already?!"),
    },
    start = {
        actions = {
            ccb.content.dialogue_actions.replace_mutation("interlocutor", "ASTHMA"),
            ccb.content.dialogue_actions.remove_items("interlocutor", "inhaler"),
            "assign_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", false),
        },
    },
    finish = {
        actions = {
            "stop_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", true),
            ccb.content.dialogue_actions.transfer_items("inhaler"),
            "npc_thankful",
        },
    },
    failure = { actions = { "npc_die" } },
    complete_when = "complete_mission_get_inhaler_inhaler",
}

ccb.content.define_mission {
    id = "MISSION_GET_ANTIBIOTICS",
    name = ccb.content.text("Find Antibiotics"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 150000,
    urgent = true,
    origins = { "ORIGIN_OPENER_NPC" },
    deadline = "1 day",
    dialogue = {
        describe = ccb.content.text("This infection is bad, totally bad…"),
        offer = ccb.content.text("I'm infected.  Badly.  I need you to get some good antibiotics for me…"),
        accepted = ccb.content.text("Oh, thank god, thank you so much!  I won't last more than a couple of days, so hurry…"),
        rejected = ccb.content.text("What?!  Please, I'll be dead soon without your help!"),
        advice = ccb.content.text("There's a town nearby.  Check pharmacies; it'll be in the back, either antibiotics or broad-spectrum antibiotics will do."),
        inquire = ccb.content.text("Find any antibiotics yet?"),
        success = ccb.content.text("Oh thank god!  I'll be right as rain in no time."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("How am I not dead already?!"),
    },
    start = {
        actions = {
            ccb.content.dialogue_actions.add_effect("interlocutor", "infection", { permanent = true }),
            ccb.content.dialogue_actions.remove_items("interlocutor", "antibiotics"),
            "assign_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", false),
        },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.remove_effects("interlocutor", { "infection" }),
            "stop_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", true),
            "npc_thankful",
            { handler = "deliver_mission_get_antibiotics" },
        },
    },
    failure = { actions = { "npc_die" } },
    complete_when = "complete_mission_get_antibiotics",
}

ccb.content.define_mission {
    id = "MISSION_GET_BLACK_BOX",
    name = ccb.content.text("Retrieve Military Black Box"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 100000,
    item = "black_box",
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GET_BLACK_BOX_TRANSCRIPT",
    dialogue = {
        describe = ccb.content.text("We've got the flag, now we need to locate US forces."),
        offer = ccb.content.text("We have the flag but now we need to locate US troops to see what we can do to help.  I haven't seen any but I'm figurin' one of those choppers that were flyin' round during th' outbreak would have a good idea.  If you can get me a black box from one of the wrecks I'll look into where we might open 'er at."),
        accepted = ccb.content.text("Fuck yeah, America!"),
        rejected = ccb.content.text("Do you have any better ideas?"),
        advice = ccb.content.text("Survivors were talkin' 'bout seeing 'em falling out of the sky but I don't know where.  If I were a pilot I'd avoid crash landing in a city or forest though.  Black boxes are housed in the tail to survive the crash so check there when you do find one.  Now get to it!"),
        inquire = ccb.content.text("How 'bout that black box?"),
        success = ccb.content.text("America, fuck yeah!"),
        success_lie = ccb.content.text("What?!  I oughta whip your ass."),
        failure = ccb.content.text("Damn, I'll have to find 'er myself."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_BLACK_BOX_TRANSCRIPT",
    name = ccb.content.text("Retrieve Black Box Transcript"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "black_box_transcript",
    start = {
        target = {
            terrain = "microlab_generic_surface",
            special = "4x4_microlab_surface",
            reveal_radius = 3,
            random = true,
            z = 0,
        },
        item_rewards = { { item = "black_box" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_EXPLORE_SARCOPHAGUS",
    dialogue = {
        describe = ccb.content.text("With the black box in hand, we need to find a lab."),
        offer = ccb.content.text("Thanks to your searching we've got the black box but now we need to have a look inside her.  Now, most buildings don't have power anymore but there are a few that might be of use.  Have you ever seen one of those science labs that have popped up in the middle of nowhere?  Them suckers have a glowing terminal out front so I know they have power somewhere inside 'em.  If you can get inside and find a computer lab that still works you ought to be able to find out what's in the black box."),
        accepted = ccb.content.text("Fuck yeah, America!"),
        rejected = ccb.content.text("Do you have any better ideas?"),
        advice = ccb.content.text("When I was playin' with the terminal for the one I ran into it kept asking for an ID card.  Finding one would be the first order of business."),
        inquire = ccb.content.text("How 'bout that black box?"),
        success = ccb.content.text("America, fuck yeah!  I was in the guard a few years back so I'm confident I can make heads-or-tails of these transmissions."),
        success_lie = ccb.content.text("What?!  I oughta whip your ass."),
        failure = ccb.content.text("Damn, I maybe we can find an egg-head to crack the terminal."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_DEPUTY_BADGE",
    name = ccb.content.text("Find Deputy Badge"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "badge_deputy",
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Those twisted snakes…"),
        offer = ccb.content.text("I hope you will find use from what you got out of the deposit box but I also have another job for you that might lead you to an opportunity to deal out justice for those who cannot.  First things first, we can't just look like ruffians.  Find us a deputy badge, easy enough?"),
        accepted = ccb.content.text("I'd check the police station."),
        rejected = ccb.content.text("We're also official… just hang in there and I'll show you what we can really do."),
        advice = ccb.content.text("They shouldn't be that hard to find… should they?"),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Great work, Deputy.  We're in business."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("The day of reckoning will come for the criminals if it hasn't already."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_FLAG",
    name = ccb.content.text("Find Flag"),
    goal = "MGOAL_FIND_ITEM",
    start = { actions = { ccb.content.dialogue_actions.remove_items("interlocutor", "american_flag") } },
    difficulty = 2,
    value = 100000,
    item = "american_flag",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_GET_BLACK_BOX",
    dialogue = {
        describe = ccb.content.text("Does our flag still yet wave?"),
        offer = ccb.content.text("Does our flag still yet wave?  We're battered but not yet out of the fight, we need the old colors!"),
        accepted = ccb.content.text("Hell ya!  Find me one of those big ol' American flags."),
        rejected = ccb.content.text("Seriously?  God damned commie…"),
        advice = ccb.content.text("Find a large federal building or school, they must have one."),
        inquire = ccb.content.text("Rescued the standard yet?"),
        success = ccb.content.text("America, fuck ya!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("You give up?  This country fell apart because no one could find a good man to rely on… might as well give up, I guess."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RECORD_ACCOUNTING",
    name = ccb.content.text("Find Corporate Accounts"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 140000,
    item = "record_accounting",
    start = { reveal_terrain = "office_tower" },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_GET_SAFE_BOX",
    dialogue = {
        describe = ccb.content.text("Those twisted snakes…"),
        offer = ccb.content.text("Our world fell apart because our leaders were as crooked as the con-men that paid for their elections.  Just find me one of those corporate accounting books and I'll show you and the rest of the world just who is at fault."),
        accepted = ccb.content.text("You'll see, I know I'm right."),
        rejected = ccb.content.text("I know it isn't pressing but the big corporations didn't get a chance to destroy the evidence yet."),
        advice = ccb.content.text("Try a big corporate building of some sort, they're bound to have an accounting department."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Great, let's see… uh… hmmm….  Fine, I didn't even do my own taxes but I'm sure this will prove their guilt if we get an expert to examine it."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("The day of reckoning will come for the corporations if it hasn't already."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RECORD_PATIENT",
    name = ccb.content.text("Find Patient Records"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 60000,
    item = "record_patient",
    start = { reveal_terrain = { "office_doctor", "hospital_2" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_REACH_FEMA_CAMP",
    dialogue = {
        describe = ccb.content.text("I hope I don't see many names I know…"),
        offer = ccb.content.text("I've lost so many friends… please find me a patient list from the regional hospital or doctor's office.  I just want to know who might still be out there."),
        accepted = ccb.content.text("Thank you, I suppose it won't change what has already happened but it will bring me closure."),
        rejected = ccb.content.text("Please, I just want to know what happened to everyone."),
        advice = ccb.content.text("I bet you'll run into a lot of those things in the hospital, please be careful."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Oh dear, I thought Timmy would have made it…"),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("I bet some of them are still out there…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RECORD_WEATHER",
    name = ccb.content.text("Find Weather Log"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 50000,
    item = "record_weather",
    start = { reveal_terrain = "station_radio" },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("I wonder if a retreat might exist…"),
        offer = ccb.content.text("Everyone who dies gets back up, right?  Which means that whatever is causing this it must be airborne to have infected everyone.  I believe that if that is the case then there should be regions that were not downwind from where-ever the disease was released.  We need to find a record of all the weather patterns leading up to the outbreak."),
        accepted = ccb.content.text("Thanks so much, you may save both of us yet."),
        rejected = ccb.content.text("Ya, it was a long shot I admit."),
        advice = ccb.content.text("I'm not sure, maybe a news station would have what we are looking for?"),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("These look more complicated than I thought, just give me some time."),
        success_lie = ccb.content.text("This isn't what we need."),
        failure = ccb.content.text("If only we could find a great valley or something."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_HOLY_SYMBOL",
    name = ccb.content.text("Find a Holy Symbol"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 100000,
    item = "holy_symbol",
    start = {
        reveal_terrain = { "church_1" },
        actions = { ccb.content.dialogue_actions.remove_items("interlocutor", "holy_symbol") },
    },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_GET_RELIC",
    dialogue = {
        describe = ccb.content.text("Any variant is fine, I am not that choosy…"),
        offer = ccb.content.text("The sky has torn apart and creatures beyond our wildest imaginations lurk in the dark now.  I beg you, find me a holy symbol.  Maybe some faith can help me sleep better at night."),
        accepted = ccb.content.text("May whatever god or spirits that now reign the world protect you."),
        rejected = ccb.content.text("I guess the stress may just be getting to me…"),
        advice = ccb.content.text("A church must be full of them and who knows, maybe some of those <zombies> carry some.  But please, do not waste your time making one yourself."),
        inquire = ccb.content.text("Any luck?  Please find me a holy symbol.  Any of them will do."),
        success = ccb.content.text("Thank the heavens."),
        success_lie = ccb.content.text("What good does this do me?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RELIC",
    name = ccb.content.text("Find Relic"),
    description = ccb.content.text("Find a relic of a forgotten saint.  Places like <color_yellow>cathedrals</color> or <color_yellow>museums</color> might have one."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 100000,
    item = "small_relic",
    start = { reveal_terrain = { "cathedral_1", "museum" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_RECOVER_PRIEST_DIARY",
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("As the world seems to abandon the reality that we once knew, it becomes plausible that the old superstitions that were cast aside may have had some truth to them.  Please go and find me a religious relic… I doubt it will be of much use but I've got to hope in something."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("I suppose a large church or cathedral may have something."),
        inquire = ccb.content.text("Any luck?  Please find me a small relic.  Any relic will do."),
        success = ccb.content.text("Thank you, I need some time alone now…"),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_SAFE_BOX",
    name = ccb.content.text("Retrieve Deposit Box"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 30000,
    item = "safe_box",
    start = {
        actions = { "follow_only" },
        target = { terrain = "bank", match = "PREFIX", special = "bank", random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    item_placements = {
                        { id = "safe_box", x = { 18, 21 }, y = { 4, 6 }, amount = 1 },
                    },
                },
            },
        },
    },
    finish = {
        actions = {
            "stop_following",
            { handler = "reward_mission_get_safe_box" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GET_DEPUTY_BADGE",
    dialogue = {
        describe = ccb.content.text("Those twisted snakes…"),
        offer = ccb.content.text("Now I don't mean to upset you but I'm not sure what I can do with the accounting ledger at the moment.  We do have a new lead though, the ledger has a safe deposit box under the regional manager's name.  Guess what, dumb sucker wrote down his combination.  Come with me to retrieve the box and you can keep any of the goodies in it that I can't use to press charges against these bastards."),
        accepted = ccb.content.text("You may make a tidy profit from this."),
        rejected = ccb.content.text("I know it isn't pressing but the world is going to be just as corrupt when we start rebuilding unless we take measure to stop those who seek to rule over us."),
        advice = ccb.content.text("This shouldn't be hard unless we run into a horde."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Great, anything I can't use to prosecute the bastards is yours, as promised."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("The day of reckoning will come for the corporations if it hasn't already."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_SOFTWARE",
    name = ccb.content.text("Retrieve Software"),
    description = ccb.content.text("Retrieve the software in their computer marked on your map."),
    goal = "MGOAL_FIND_ANY_ITEM",
    difficulty = 2,
    value = 80000,
    place = "near_town",
    start = "place_npc_software",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh man, I can't believe I forgot to download it…"),
        offer = ccb.content.text("There's some important software on my computer that I need on USB."),
        accepted = ccb.content.text("Thanks!  Just pull the data onto this USB drive and bring it to me."),
        rejected = ccb.content.text("Seriously?  It's an easy job…"),
        advice = ccb.content.text("Take this USB drive.  Use the console, and download the software."),
        inquire = ccb.content.text("So, do you have my software yet?"),
        success = ccb.content.text("Excellent, thank you!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("Wow, you failed?  All that work, down the drain…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_ZOMBIE_BLOOD_ANAL",
    name = ccb.content.text("Analyze Zombie Blood"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 8,
    value = 250000,
    item = "software_blood_data",
    start = {
        target = { terrain = "hospital_2", special = "hospital", reveal_radius = 3 },
        item_rewards = { { item = "vacutainer" }, { item = "usb_drive" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("It could be very informative to perform an analysis of zombie blood…"),
        offer = ccb.content.text("I need someone to get a sample of zombie blood, take it to a hospital, and perform a centrifuge analysis of it."),
        accepted = ccb.content.text("Excellent.  Take this blood draw kit; once you've produced a zombie corpse, use it to extract blood from the body, then take it to a hospital for analysis."),
        rejected = ccb.content.text("Are you sure?  The scientific value of that blood data could be priceless…"),
        advice = ccb.content.text("The centrifuge is a bit technical; you might want to study up on the usage of computers before completing that part."),
        inquire = ccb.content.text("Well, do you have the data yet?"),
        success = ccb.content.text("Excellent!  This may be the key to removing the infection."),
        success_lie = ccb.content.text("Wait, you couldn't possibly have the data!  Liar!"),
        failure = ccb.content.text("What a shame, that data could have proved invaluable…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_CULT",
    name = ccb.content.text("Investigate Cult"),
    description = ccb.content.text("Investigate the strange cabin in the woods and find an item that may clue you in about <color_yellow>a potential human sacrifice</color> the cult has performed, such as <color_yellow>human bones or other remains</color>."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "etched_skull",
    start = { target = { terrain = "cabin_strange", special = "Strange Cabin", reveal_radius = 3 } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_INVESTIGATE_PRISON_VISIONARY",
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("You have no idea how interesting this diary is.  I have two very promising leads… first things first, the Catholic Church has been performing its own investigations into global cult phenomenon and it appears to have become very interested in a local cult as of recently.  Could you investigate a location for me?  I'm not sure what was going on here but the priest seemed fairly worried about it."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path… You may need it this time more than the past excursions you have gone on.  There is a note about potential human sacrifice in the days immediately before and after the outbreak.  The name of the cult is believed to be the Church of Starry Wisdom but it is noted that accounts differ."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("I doubt the site is still occupied but I'd carry a firearm at least… I'm not sure what you might be looking for but I'm positive you'll find something out of the ordinary if you look long enough."),
        inquire = ccb.content.text("I'm positive there is something there… there has to be, any luck?"),
        success = ccb.content.text("Thank you, your account of these… demonic creations proves the fears the churches had were well founded.  Our priority should be routing out any survivors of this cult… I don't known if they are responsible for the outbreak but they certainly know more about it than I do."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_PRISON_VISIONARY",
    name = ccb.content.text("Prison Visionary"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "visions_solitude",
    start = {
        target = { terrain = "prison_1_4", special = "Prison", reveal_radius = 3 },
        map_updates = {
            {
                terrain = "prison_1_4",
                layout = { item_placements = { { id = "visions_solitude", x = 15, y = 22 } } },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("I have another task if you are feeling up to it.  There is a prisoner that the priest made special mention of.  I was wondering if you could see what may have happened to him or if he left anything in his cell.  The priest admits the individual is rather unstable, to put it lightly, but the priest personally believed the man was some kind of repentant visionary.  I'm not in a position to cast out the account just yet… it seems the man has prophesied events accurately before concerning the Church of Starry Wisdom."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path… I can only imagine that the prison will be a little slice of hell.  I'm not sure what they would have decided to do with the inmates when they knew death was almost certain."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("The worst case scenario will probably be that the prisoners have escaped their cells and turned the building into their own little fortress.  Best case, the building went into lock-down and secured the prisoners in their cells.  Either way, navigating the building will pose its own difficulties."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Thank you, I'm not sure what to make of this but I'll ponder your account."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_JOIN_TRACKER",
    name = ccb.content.text("Find Deputy Badge"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 0,
    urgent = true,
    item = "badge_deputy",
    start = { native_actions = { "follow" } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Well damn, you must be the guys here to pick me up…"),
        offer = ccb.content.text("I got the brief so I know what I'm getting into.  Let me be upfront, treat me like shit and I'm going to cover my own hide.  However, you treat me well and give me something to believe in, even if it's just a shiny bit of metal, and I'll do you right.  Without a strong band a man doesn't stand a chance in this world.  You ready to take charge boss?  This world could use a Sheriff just about now."),
        accepted = ccb.content.text("Before we get into a major fight just make sure we have the gear we need, boss."),
        rejected = ccb.content.text("I don't think you're going to find many other survivors who haven't taken up a faction yet."),
        advice = ccb.content.text("I'm a pretty good shot with a rifle or pistol."),
        inquire = ccb.content.text("Any problems boss?"),
        success = ccb.content.text("Wait… are you really making me a deputy?"),
        success_lie = ccb.content.text("I don't think so…"),
        failure = ccb.content.text("Quitting already?"),
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_100_Z",
    name = ccb.content.text("Kill 100 Zombies"),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "ZOMBIE",
    monster_kill_goal = 100,
    difficulty = 5,
    value = 250000,
    start = { native_actions = { "follow_only" } },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_KILL_HORDE_MASTER",
    dialogue = {
        describe = ccb.content.text("You seem to know this new world better than most…"),
        offer = ccb.content.text("You're kitted out better than most… would you be interested in making this world a little better for the rest of us?  The towns have enough supplies for us survivors to start securing a foothold but we don't have anyone with the skills and equipment to thin the masses of undead.  I'll lend you a hand to the best of my ability but you really showed promise taking out that other beast.  You, I, and a 100 zombies laid to rest, what do you say?"),
        accepted = ccb.content.text("Hell ya, we may get ourselves killed but we'll be among the first legends of the apocalypse."),
        rejected = ccb.content.text("Hey, I know I wouldn't volunteer for it either… but then I remember that most of us survivors won't make it unless someone decides to take the initiative."),
        advice = ccb.content.text("I'd secure an ammo cache and try to sweep a town in multiple passes."),
        inquire = ccb.content.text("Got this knocked out?"),
        success = ccb.content.text("Man… you're a goddamn machine.  It was a pleasure working with you.  You know, you may just change our little neck of the world if you keep this up."),
        success_lie = ccb.content.text("I don't think that was quite a hundred dead zeds."),
        failure = ccb.content.text("Quitting already?"),
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_HORDE_MASTER",
    name = ccb.content.text("Kill Horde Master"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 250000,
    urgent = true,
    start = {
        target = { terrain = "house", match = "CONTAINS", min_distance = 10, random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_zombie_master",
                            x = { 12, 15 },
                            y = { 12, 15 },
                            target = true,
                            name = ccb.content.text("Demonic Soul"),
                        },
                        { group = "GROUP_ZOMBIE", x = { 12, 15 }, y = { 12, 15 }, repetitions = { 21, 29 } },
                    },
                },
            },
        },
        native_actions = { "follow_only" },
    },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_RECRUIT_TRACKER",
    dialogue = {
        describe = ccb.content.text("I've heard some bad rumors so I hope you are up for another challenge…"),
        offer = ccb.content.text("Apparently one of the other survivors picked up on an unusually dense horde of undead moving into the area.  At the center of this throng there was a 'leader' of some sort.  The short of it is, kill the son of a bitch.  We don't know what it is capable of or why it is surrounded by other zombies but this thing reeks of trouble.  Do whatever it takes but we can't risk it getting away."),
        accepted = ccb.content.text("I'll lend you a hand but I'd try and recruit another gunslinger if you can."),
        rejected = ccb.content.text("What's the use of walking away, they'll track you down eventually."),
        advice = ccb.content.text("Don't risk torching the building it may be hiding in if it has a basement.  The sucker may still be alive under the rubble and ash."),
        inquire = ccb.content.text("Got this knocked out?"),
        success = ccb.content.text("May that bastard never get up again."),
        success_lie = ccb.content.text("I don't think we got it yet."),
        failure = ccb.content.text("Quitting already?"),
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_JABBERWOCK",
    name = ccb.content.text("Kill Jabberwock"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 200000,
    urgent = true,
    start = {
        target = {
            terrain = "forest_thick",
            replace_terrain = "forest",
            reveal_radius = 1,
            random = true,
            min_distance = 5,
            z = 0,
        },
        map_updates = {
            { layout = { monster_placements = { { id = "mon_jabberwock", x = 11, y = 11, target = true } } } },
        },
    },
    finish = { native_actions = { "npc_thankful" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_KILL_100_Z",
    dialogue = {
        describe = ccb.content.text("The eater of the dead… something was ripping zombies to shreds and only leaving a few scattered limbs…"),
        offer = ccb.content.text("A few days ago another survivor and I were trying to avoid the cities by staying in the woods during the day and foraging for gear at night.  It worked well against the normal zeds but one night something caught onto our trail and chased us for ten minutes or so until we decided to split up and meet-up back here.  My buddy never showed up and I don't have the means to kill whatever it was.  Can you lend a hand?"),
        accepted = ccb.content.text("Thanks, make sure you're ready for whatever the beast is."),
        rejected = ccb.content.text("Hey, I know I wouldn't volunteer for it either."),
        advice = ccb.content.text("I'd carry a shotgun at least, it sounded pretty big."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("You look a little shaken up, I can't tell you how glad I am that you killed it though."),
        success_lie = ccb.content.text("Something in the shadows still seems to stare at me when I look at the woods."),
        failure = ccb.content.text("I'm glad you came back alive… I wasn't sure if I had sent you to your death."),
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_ZOMBIE_MOM",
    name = ccb.content.text("Kill Zombie Mom"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 120000,
    urgent = true,
    start = {
        target = {
            terrain = "house",
            match = "PREFIX",
            reveal_radius = 1,
            random = true,
            min_distance = 5,
            z = 0,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_zombie", x = 12, y = 12, target = true, random_name = "female" },
                    },
                },
            },
        },
    },
    finish = { native_actions = { "npc_thankful" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh god, I can't believe it happened…"),
        offer = ccb.content.text("My mom… she's… she was killed, but then she just got back up… she's one of those things now.  Can you put her out of her misery for me?"),
        accepted = ccb.content.text("Thank you… she would've wanted it this way."),
        rejected = ccb.content.text("Please reconsider, I know she's suffering…"),
        advice = ccb.content.text("Find a gun if you can, make it quick…"),
        inquire = ccb.content.text("Well…?  Did you… finish things for my mom?"),
        success = ccb.content.text("Thank you.  I couldn't rest until I knew that was finished."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("Really… that's too bad."),
    },
}

ccb.content.define_mission {
    id = "MISSION_NULL",
    name = ccb.content.text("Null mission"),
    goal = "MGOAL_NULL",
    difficulty = 0,
    value = 0,
    place = "never",
}

ccb.content.define_mission {
    id = "MISSION_REACH_FARM_HOUSE",
    name = ccb.content.text("Reach Farm House"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 60000,
    start = { native_actions = { "follow_only" } },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    destination = "farm_2",
    dialogue = {
        describe = ccb.content.text("I just need a place to start over…"),
        offer = ccb.content.text("I've accepted that everyone I used to know is dead… one way or another.  I really wish I could have done something to save my brother but he was one of the first to go.  I'd like to start over, just rebuild at one of the farms in the countryside.  Can you help me secure one?"),
        accepted = ccb.content.text("Thank you, let's find a remote one so we don't have to worry about many zombies."),
        rejected = ccb.content.text("Please, I just don't know what to do otherwise."),
        advice = ccb.content.text("Traveling the backroads would be a good way to search for one."),
        inquire = ccb.content.text("Shall we keep looking for a farm house?"),
        success = ccb.content.text("Well, my adventuring days are over.  I can't thank you enough.  Trying to make this place self sustaining will take some work but the future is looking brighter.  At least it ought to be safe for now.  You'll always be welcome here."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("I guess it was just a pipe dream."),
    },
}

ccb.content.define_mission {
    id = "MISSION_REACH_FEMA_CAMP",
    name = ccb.content.text("Reach FEMA Camp"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 60000,
    start = { native_actions = { "follow_only" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_REACH_FARM_HOUSE",
    destination = "fema",
    dialogue = {
        describe = ccb.content.text("Maybe they escaped to one of the camps…"),
        offer = ccb.content.text("I can't thank you enough for bringing me the patient records but I do have another request.  You seem to know your way around… could you take me to one of the FEMA camps?  I know some were overrun but I don't want to believe all of them could have fallen."),
        accepted = ccb.content.text("Thank you, just bring me to the camp… I just want to see."),
        rejected = ccb.content.text("Please, I don't know what else to do."),
        advice = ccb.content.text("We should go at night, if it is overrun then we can quickly make our escape."),
        inquire = ccb.content.text("Any leads on where a camp might be?"),
        success = ccb.content.text("I guess this wasn't as bright an idea as I thought."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("I bet some of them are still out there…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_REACH_SAFETY",
    name = ccb.content.text("Reach Safety"),
    goal = "MGOAL_GO_TO",
    difficulty = 1,
    value = 0,
    start = "find_safety",
    origins = { "ORIGIN_NULL" },
}

ccb.content.define_mission {
    id = "MISSION_RECOVER_PRIEST_DIARY",
    name = ccb.content.text("Recover Priest's Diary"),
    description = ccb.content.text("Find something that may reveal what the church's stance is on these events.  Something like <color_yellow>a priest's diary</color> would suffice."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 70000,
    item = "priest_diary",
    start = {
        target = { terrain = "house", match = "PREFIX", min_distance = 5, random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    item_placements = { { id = "priest_diary", x = { 3, 21 }, y = { 6, 21 }, amount = 1 } },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_INVESTIGATE_CULT",
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("From what I understand, the creatures you encountered surrounding this relic were unlike anything I've heard of.  It is laughable that I now consider the living dead to be part of our ordinary reality.  Never-the-less, the church must have some explanation for these events.  I have located the residence of a local clergy man, could you go to this address and recover any items that may reveal what the church's stance is on these events?"),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("If the information is confidential the priest must have it hidden within his own home."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Thank you, a diary is exactly what I was looking for."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_RECRUIT_TRACKER",
    name = ccb.content.text("Recruit Tracker"),
    description = ccb.content.text("Go to the cabin in the woods where the Tracker is camping and <color_yellow>recruit them</color>."),
    goal = "MGOAL_RECRUIT_NPC",
    difficulty = 5,
    value = 70000,
    start = {
        target = { terrain = "cabin", special = "Cabin", reveal_radius = 2 },
        map_updates = {
            { layout = { npc_placements = { { id = "tracker_gunslinger", x = 11, y = 11, target = true } } } },
        },
        native_actions = { "follow" },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("You seem to know this new world better than most…"),
        offer = ccb.content.text("We've got another problem to deal with but I don't think we can handle it on our own.  So, I sent word out and found us a volunteer… of sorts.  He's vain as hell but has a little skill with firearms.  He was supposed to collect whatever he had of value and is going to meet us at a cabin in the woods.  Wasn't sure how long we were going to be so I told him to just camp there until we picked him up."),
        accepted = ccb.content.text("Roger, if he's a no-show then any other gunslinger will do… but I doubt he'll quit before we even begin."),
        rejected = ccb.content.text("Hey, I know I wouldn't volunteer for it either… but then I remember that most of us survivors won't make it unless someone decides to take the initiative."),
        advice = ccb.content.text("I hope the bastard is packing heat… else we'll need to grab him a gun before we hit our next target."),
        inquire = ccb.content.text("Found a gunslinger?"),
        success = ccb.content.text("Great, just let me know when you are ready to wade knee-deep in an ocean of blood."),
        success_lie = ccb.content.text("I don't think so…"),
        failure = ccb.content.text("Quitting already?"),
    },
}

ccb.content.define_mission {
    id = "MISSION_RESCUE_DOG",
    name = ccb.content.text("Find Lost Dog"),
    goal = "MGOAL_FIND_MONSTER",
    difficulty = 3,
    value = 100000,
    start = {
        target = { terrain = "house", replace_terrain = "field", match = "PREFIX", random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_dog", x = { 3, 21 }, y = { 6, 21 }, friendly = true, target = true },
                    },
                },
            },
        },
        item_rewards = { { item = "dog_whistle" } },
    },
    origins = { "ORIGIN_OPENER_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh, my poor puppy…"),
        offer = ccb.content.text("I left my poor dog in a house, not far from here.  Can you retrieve it?"),
        accepted = ccb.content.text("Thank you!  Please hurry back!"),
        rejected = ccb.content.text("Please, think of my poor little puppy!"),
        advice = ccb.content.text("Take my dog whistle; if the dog starts running off, blow it and he'll return to your side."),
        inquire = ccb.content.text("Have you found my dog yet?"),
        success = ccb.content.text("Thank you so much for finding him!"),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("Oh no!  My poor puppy…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_CITY_COP_MOMENTO",
    name = ccb.content.text("Break into armory to retrieve family photo"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 800,
    item = "family_photo",
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need you to get my family photo from the armory safe."),
        offer = ccb.content.text("I left the only photo I have from my family in the armory.  I don't have the code, can you get in?"),
        accepted = ccb.content.text("Thanks, it's great to see someone willing to help a out."),
        rejected = ccb.content.text("Well, I'll find someone else to do it for me, real shame with all those guns locked up too…"),
        advice = ccb.content.text("You look like a resourceful sort, maybe you can hack it or something."),
        inquire = ccb.content.text("Got the photo?  Should've been in my gun safe."),
        success = ccb.content.text("Thanks!  I'll be sure to put in a good word for you around town."),
        success_lie = ccb.content.text("OK, then hand it over."),
        failure = ccb.content.text("Shit happens."),
    },
}

ccb.content.define_mission {
    id = "MISSION_PROVE_YOUR_WORTH",
    name = ccb.content.text("Prove your worth to Foodperson"),
    description = ccb.content.text("Prove your dedication to the Foodperson and Foodplace as a whole by finding <color_yellow>10 Foodplace loyalty cards</color>."),
    goal = "MGOAL_FIND_ITEM",
    item = "fp_loyalty_card",
    item_count = 10,
    difficulty = 1,
    value = 0,
    finish = {
        item_rewards = { { item = "badge_foodkid" } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_foodperson_impressed", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Prove your dedication to Foodplace."),
        offer = ccb.content.text("Show me the proof of your loyalty to the great Foodplace, and I'll consider you worthy of my friendship.  Ten loyalty cards should be enough, I'm sure you already have much more than that waiting for you at home, right?"),
        accepted = ccb.content.text("That's the spirit!  Good luck kid."),
        rejected = ccb.content.text("That's alright not everyone is cutout for this."),
        advice = ccb.content.text("Those are very precious, people would probably keep them on their person or in bank vaults.  And definitely not throw them in the trash!"),
        inquire = ccb.content.text("How is it going?  Do you have them?"),
        success = ccb.content.text("YES!  I knew you could do it!  You proved your worth and I'm proud to call you a friend."),
        success_lie = ccb.content.text("Well… where are they?"),
        failure = ccb.content.text("I'm so disappointed in you kid…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_PROVE_YOU_ARE_A_SURVIVOR",
    name = ccb.content.text("Prove You're A Survivor"),
    description = ccb.content.text("Prove you're a survivor by surviving for 10 days after the Cataclysm, and then returning to the person who gave you this mission."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    origins = { "ORIGIN_OPENER_NPC" },
    finish = { native_actions = { "follow" } },
    dialogue = {
        describe = ccb.content.text("It's hard to tell who actually has the skills to survive these days…"),
        offer = ccb.content.text("It's hard surviving out here on our own, and we'd probably have a better chance working together.  Problem is, I don't really know you and what you're capable of.  You might have what it takes, or you might not.  Either way, I'm going to need some proof.  Come back in a few days and I'll gladly follow you.  It's basically a win-win for me: either you come back and I'll know you've got what it takes, or you don't and I'll know that I was right not to follow you."),
        accepted = ccb.content.text("I'll see you then… or I won't, and then I'll know I made the right decision."),
        rejected = ccb.content.text("Ya, it was a long shot I admit."),
        advice = ccb.content.text("Don't die.  If you're asking me for advice, that doesn't bode well for you."),
        inquire = ccb.content.text("Well, you're not dead… yet."),
        success = ccb.content.text("I'll be honest, I wasn't really expecting to see you again.  A promise is a promise, I'll follow you now!"),
        success_lie = ccb.content.text("I know time is relative and all that."),
        failure = ccb.content.text("I'm not quite sure how you failed to survive AND are talking to me."),
    },
    complete_when = "complete_mission_prove_you_are_a_survivor",
}

ccb.content.define_mission {
    id = "MISSION_LEARN_ABOUT_CATTAIL_JELLY",
    name = ccb.content.text("Gather cattail stalks to create cattail jelly"),
    description = ccb.content.text("Gather <color_yellow>60 cattail stalks</color> from the swamp and bring them back to <color_light_red>learn how to craft cattail jelly</color>.  Raise your <color_yellow>survival skill to at least 1</color> by harvesting cattail stalks.  <color_yellow>Bring back the provided bag with the 60 cattail stalks in them</color> as well."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    generic_rewards = false,
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    start = { target = { terrain = "forest_water", reveal_radius = 3 }, actions = { { item = "swag_bag" } } },
    finish = {
        actions = {
            ccb.content.dialogue_actions.transfer_items("cattail_stalk", 60),
            ccb.content.dialogue_actions.transfer_items("swag_bag"),
            { handler = "prepare_60_cattail_stalks" },
            { handler = "teach_cattail_jelly" },
            ccb.content.dialogue_actions.notify_player(ccb.content.text("You learn how to craft cattail jelly.")),
            { item = "cattail_jelly", count = 5, container = "bag_zipper" },
        },
    },
    dialogue = {
        describe = ccb.content.text("Medical services are a little sparse following <the_cataclysm>, but people have been surviving using their wits and the bounty of Mother Nature for a long time.  Care to learn a little?"),
        offer = ccb.content.text("Did you know that cattails are a source of a jelly that works as an antiseptic and analgesic?  Something like that is likely to be mighty helpful out here.  I want you to take this bag, head to the nearest swamp, collect 60 cattail stalks, and bring them back here.  In exchange, I'll show you how to harvest the jelly."),
        accepted = ccb.content.text("Great!  <color_yellow>This bag should be big enough to hold all of the stalks we'll need.  Don't forget to bring it back.</color>"),
        rejected = ccb.content.text("Your loss."),
        advice = ccb.content.text("The cattails grow in the fresh water in swamps.  You can't miss them."),
        inquire = ccb.content.text("Got those cattail stalks yet?  Don't forget to <color_yellow>bring back my bag with the stalks in them</color> and to work on improving your survival skill as well."),
        success = ccb.content.text("Great!  Hand them over and I'll show you how this works."),
        success_lie = ccb.content.text("OK, then hand them over."),
        failure = ccb.content.text("Well, that's a shame."),
    },
    complete_when = "complete_mission_learn_about_cattail_jelly_swag_bag",
}

-- NPC will ask player to burn tagged house. Will follow player after accepting mission.
-- Change first topic to do proper checks. MGOAL_GO_TO to check if player stands on tagged tile.
-- At the end of the mission, will place fire on tagged tile and NPC will join player faction.
ccb.content.define_mission {
    id = "MISSION_PYROMANIAC",
    name = ccb.content.text("Angry pyromaniac"),
    description = ccb.content.text("Bring the pyromaniac to <color_light_blue>their rival's house</color> and don't forget to <color_yellow>bring at least 200 units of gasoline</color>.  After you got there, talk to the pyromaniac to start burning the house."),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 0,
    generic_rewards = false,
    start = {
        target = { terrain = "house", replace_terrain = "forest", match = "PREFIX", random = true, z = 0 },
        actions = { "follow_only", ccb.content.dialogue_actions.set_first_topic("MISSION_PYROMANIAC") },
    },
    finish = {
        actions = {
            "follow",
            { handler = "deliver_gasoline_200_items" },
            ccb.content.dialogue_actions.update_map("MISSION_PYROMANIAC_BURN"),
        },
    },
    origins = { "ORIGIN_OPENER_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh man, I want to fucking burn it so bad…"),
        offer = ccb.content.text("I'm so fucking infuriated!  I've got an enemy that ruined my life, and now I want to get revenge!  I don't care about <the_cataclysm>, I just want to burn his house!  Would you help me, <name_g>?"),
        accepted = ccb.content.text("Good.  Let's go to his house and goddamn burn it down!  Oh, by the way, could you bring gasoline with you, <name_g>?  I was so angry I forgot to bring it with me…"),
        rejected = ccb.content.text("Seriously?  It's such an easy job…"),
        advice = ccb.content.text("Maybe we can find some gasoline at a gas station."),
        inquire = ccb.content.text("Are you ready, <name_g>?"),
        success = ccb.content.text("Sweet, sweet revenge!  Ah, smells so nice!  Feels like the smell of napalm in the morning!  All his stuff, and probably even that <name_b>, will burn to ashes in a matter of minutes.  You helped me get my revenge, so I'll follow you to the end, <name_g>!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("Wow, you failed?  How…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_PORTAL_DUNGEON",
    name = ccb.content.text("Investigate Strange Location"),
    goal = "MGOAL_GO_TO",
    description = ccb.content.text("You could find this place upside down, dizzy and blindfolded.  Its presence is too altered to allow the mercy of ignorance."),
    difficulty = 0,
    value = 0,
    invisible_on_complete = true,
    start = { target = { global_position = "portal_dungeon" } },
}

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_PORTAL_STORM_CENTER",
    name = ccb.content.text("Center of the storm"),
    goal = "MGOAL_CONDITION",
    description = ccb.content.text("This is the center of the portal storm, you could find it upside down, dizzy and blindfolded.  Its presence is too altered to allow the mercy of ignorance."),
    difficulty = 0,
    value = 0,
    invisible_on_complete = true,
    start = { target = { global_position = "portal_storm_center" } },
}

ccb.content.define_mission {
    id = "MISSION_CAMP_LEADERSHIP_CHANGE",
    name = ccb.content.text("Faction succession"),
    goal = "MGOAL_CONDITION",
    description = ccb.content.text("You have some time left until you can transfer control to your companions, provided you have <color_yellow>established a Basecamp</color> and <color_yellow>have at least 1 NPC companion</color>."),
    difficulty = 0,
    value = 0,
    deadline = "3 days",
    invisible_on_complete = true,
    start = { actions = { { handler = "start_faction_succession_cooldown" } } },
}

-- For MISSION_PYROMANIAC. Will spawn fire on tile where PC is standing.
ccb.content.define_mapgen {
    kind = "update",
    id = "MISSION_PYROMANIAC_BURN",
    layout = {
        liquid_placements = { { id = "gasoline", x = { 5, 20 }, y = { 5, 20 }, amount = 5, repetitions = 40 } },
        field_placements = { { id = "fd_fire", x = { 5, 20 }, y = { 5, 20 }, repetitions = 40 } },
    },
}
