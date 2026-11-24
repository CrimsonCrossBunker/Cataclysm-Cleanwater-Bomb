local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_mission {
    id = "MISSION_GET_INHALER",
    name = ccb.content.text("Find Spurge Tea"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 150000,
    urgent = true,
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    deadline = { "30 days", "48 days" },
    dialogue = {
        describe = ccb.content.text("I'm… short… of breath…"),
        offer = ccb.content.text("I'm asthmatic.  I need you to get some kind of medicinal tea for me…"),
        accepted = ccb.content.text("Oh, thank god, thank you so much!  I won't last more than a couple of days, so hurry…"),
        rejected = ccb.content.text("What?!  Please, I'll be dead soon without your help!"),
        advice = ccb.content.text("I'm dead unless I can get this special tea.  Maybe it's from a flower?"),
        inquire = ccb.content.text("Find any tea yet?"),
        success = ccb.content.text("Oh thank god!  I'll be right as rain in no time."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("How am I not dead already?!"),
    },
    start = {
        actions = {
            ccb.content.dialogue_actions.replace_mutation("interlocutor", "ASTHMA"),
            ccb.content.dialogue_actions.remove_items("interlocutor", "spurge_tea"),
            "assign_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", false),
        },
    },
    finish = {
        actions = {
            "stop_guard",
            ccb.content.dialogue_actions.set_ally_rule("investigate_noises", true),
            ccb.content.dialogue_actions.transfer_items("spurge_tea"),
            "npc_thankful",
        },
    },
    failure = { actions = { "npc_die" } },
    complete_when = "complete_mission_get_inhaler_spurge_tea",
}

ccb.content.define_mission {
    id = "MISSION_GET_ANTIBIOTICS",
    name = ccb.content.text("Find Cattail Jelly"),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 150000,
    urgent = true,
    origins = { "ORIGIN_OPENER_NPC" },
    deadline = { "24 days", "48 days" },
    dialogue = {
        describe = ccb.content.text("This infection is bad, totally bad…"),
        offer = ccb.content.text("I'm infected.  Badly.  I need you to get something antiseptic for me…"),
        accepted = ccb.content.text("Oh, thank god, thank you so much!  I won't last more than a couple of days, so hurry.  Get me some cattail jelly.  That should hopefully be good enough."),
        rejected = ccb.content.text("What?!  Please, I'll be dead soon without your help!"),
        advice = ccb.content.text("I think if you can pull cattail jelly out of some cattails from like a swamp or something, I can smear it on the wound."),
        inquire = ccb.content.text("Find any jelly yet?"),
        success = ccb.content.text("Oh thank god!  I'll be right as rain in no time."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("How am I not dead already?!"),
    },
    start = {
        actions = {
            ccb.content.dialogue_actions.add_effect("interlocutor", "infection", { permanent = true }),
            ccb.content.dialogue_actions.remove_items("interlocutor", "cattail_jelly"),
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
        },
    },
    failure = { actions = { "npc_die" } },
    complete_when = "complete_mission_get_antibiotics_cattail_jelly",
}

ccb.content.define_mission {
    id = "MISSION_GET_FLAG",
    name = ccb.content.text("Make a Flag"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 100000,
    item = "grass_blanket",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Does our flag still yet wave?  Maybe we will have to make it."),
        offer = ccb.content.text("You haven't truly visited a place until you've driven a flagpole down into its dirt.  I've got the pole and the paint here, but I need a large canvas for the flag itself.  Get me a large sheet woven out of grass, and we can claim this land in the name of America!"),
        accepted = ccb.content.text("Hell ya!  Fetch me a large grass sheet!  Large enough to be used as a blanket!"),
        rejected = ccb.content.text("Seriously?  God damned commie…"),
        advice = ccb.content.text("You'll need to collect some straw and spin it into yarn first."),
        inquire = ccb.content.text("Got the cloth?"),
        success = ccb.content.text("America, fuck ya!  I name this land…  New New England!  How does that sound?  I like it!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("You give up?  Our country fell apart because no one could find a good man to rely on, and now you're telling me this place ain't any better?  Might as well give up, I guess."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RECORD_ACCOUNTING",
    name = ccb.content.text("Find Secrets in Leather Journal"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 140000,
    item = "leather_journal",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Those twisted snakes…"),
        offer = ccb.content.text("I left my dream journal in the swamp while I was doing my naked snake yoga.  There's some pretty wild stuff in there so I want it back."),
        accepted = ccb.content.text("Please don't read it unless you are prepared for some graphic and disturbing content."),
        rejected = ccb.content.text("I know it isn't pressing but I want it.  I have an incredible imagination.  I had a dream about a horse once and it talked.  Amazing stuff."),
        advice = ccb.content.text("The swamps are pretty dangerous and I'm not really sure where I was.  If you want to just make me a new dream journal that would be all right too."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Great, let's see…  Oh.  Well I can just start over I guess.  My imagination is an endless play place of amazement!"),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Now my nightmares are let loose upon the shivering land."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RECORD_PATIENT",
    name = ccb.content.text("Find Patient Records in Leather Journal"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 60000,
    item = "leather_journal",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("I hope I don't see many names I know…"),
        offer = ccb.content.text("I've lost so many friends… please find me a patient list in a leather journal.  I just want to know who might still be out there."),
        accepted = ccb.content.text("Thank you, I suppose it won't change what has already happened but it will bring me closure."),
        rejected = ccb.content.text("Please, I just want to know what happened to everyone."),
        advice = ccb.content.text("You may have some difficulties finding a full list with things how they are.  If you can't get me the list, can you just make or find me a leather journal for me to make my own?"),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("I'm making a list and checking it twice…"),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("I bet some of them are still out there…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RECORD_WEATHER",
    name = ccb.content.text("Find Weather Log in Leather Journal"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 50000,
    item = "leather_journal",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("I wonder if a retreat might exist…"),
        offer = ccb.content.text("Everyone who dies gets back up, right?  Which means that whatever is causing this it must be airborne to have infected everyone.  I believe that if that is the case then there should be regions that were not downwind from where-ever the disease was released.  We need to find a leather journal with all the weather patterns leading up to the outbreak."),
        accepted = ccb.content.text("Thanks so much, you may save both of us yet."),
        rejected = ccb.content.text("Ya, it was a long shot I admit."),
        advice = ccb.content.text("You may have some difficulties finding those weather pattern records with things how they are.  If you can't get me the list, can you just make or find me a leather journal for me to make my own?"),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("These look more complicated than I thought, just give me some time."),
        success_lie = ccb.content.text("This isn't what we need."),
        failure = ccb.content.text("If only we could find a great valley or something."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_RELIC",
    name = ccb.content.text("Find Rock"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 100000,
    item = "rock",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("As the world seems to abandon the reality that we once knew, it becomes plausible that the old superstitions that were cast aside may have had some truth to them.  Please go and find me a religious relic… I doubt it will be of much use but I've got to hope in something.  It will look like a normal rock to you, but I can divine secrets from its earthly essence."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("I hear rocks may be found in the woods.  They tell me things.  The spirits.  Religion!"),
        inquire = ccb.content.text("Any luck?  Please find me a small relic.  Any relic will do.  It looks like a rock."),
        success = ccb.content.text("Thank you, I need some time alone now…"),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_RECOVER_PRIEST_DIARY",
    name = ccb.content.text("Recover Holy Symbol"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 70000,
    item = "holy_symbol",
    start = {
        target = {
            terrain = "standing_stones",
            match = "PREFIX",
            special = "Standing stones",
            min_distance = 5,
            search_range = 80,
            random = true,
            z = 0,
        },
        map_updates = {
            {
                layout = {
                    item_placements = { { id = "holy_symbol", x = { 3, 21 }, y = { 6, 21 }, amount = 1 } },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_INVESTIGATE_CULT",
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("I have learned so much from this sacred relic.  I have attuned to it.  We must go deeper.  I now understand that buried in the deep forest is a special place with even larger rocks, I mean sacred relics.  Go there, and get me a holy symbol of this place."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("The woods are deep and dark and probably dangerous.  Bring a friend if you can."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Thank you, this is exactly what I was looking for."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_CULT",
    name = ccb.content.text("Investigate Cult"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "etched_skull",
    start = {
        target = { terrain = "cave_rat", special = "Rat Cave", reveal_radius = 3 },
        map_updates = {
            {
                layout = {
                    item_placements = { { id = "etched_skull", x = { 3, 21 }, y = { 6, 21 }, amount = 1 } },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_INVESTIGATE_PRISON_VISIONARY",
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("You have no idea how interesting this holy symbol is.  I have two very promising leads… first things first, I have learned of dark whispers of mystic significance, telluric resonances that tingle the spine and give me kind of a dizzy feeling, but not entirely unpleasant.  Could you investigate a location for me?  I'm not sure what was going on here but the whispers seem fairly worried about it."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path… You may need it this time more than the past excursions you have gone on.  There is a whisper about potential human sacrifice in the days immediately before and after the grand mystical shift.  The name of the cult is not revealed to me, except for an incessant squeaking."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("I doubt the site is still occupied but I'd carry some form of weapon at least… I'm not sure what you might be looking for but I'm positive you'll find something out of the ordinary if you look long enough."),
        inquire = ccb.content.text("I'm positive there is something there… there has to be, any luck?"),
        success = ccb.content.text("Thank you, your account of these… demonic creations proves the fears the whispers had were well founded.  Our priority should be routing out any survivors of this cult… I don't known if they are responsible for the disaster but they certainly know more about it than I do."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_PRISON_VISIONARY",
    name = ccb.content.text("Mad Hermit"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "visions_solitude",
    start = {
        target = { terrain = "island_forest_thick", special = "Island", reveal_radius = 3 },
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
        offer = ccb.content.text("I have another task if you are feeling up to it.   There is a mad hermit that the whispers made special mention of.  I was wondering if you could see what may have happened to them or if they left anything behind.  The whispers admit the individual is rather unstable, to put it lightly, but the whispers believe the hermit was some kind of mystical visionary.  I'm not in a position to cast out the account just yet… it seems the hermit has prophesied events accurately before."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path… I can only imagine that the island will be a little slice of hell.  I hope you can swim."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("With things as they are you probably won't just find a boat lying around.  Maybe make one?  Maybe swim?"),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Thank you, I'm not sure what to make of this but I'll ponder your account."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_SOFTWARE",
    name = ccb.content.text("Retrieve Stick"),
    goal = "MGOAL_FIND_ITEM",
    item = "stick",
    difficulty = 2,
    value = 80000,
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh man, I can't believe I forgot to bring it…"),
        offer = ccb.content.text("There's some important notes on my special stick that I need."),
        accepted = ccb.content.text("Thanks!  Just get the stick and bring it to me."),
        rejected = ccb.content.text("Seriously?  It's an easy job…"),
        advice = ccb.content.text("Don't worry, you'll know the stick when you see it, it is unmistakable."),
        inquire = ccb.content.text("So, do you have my stick yet?"),
        success = ccb.content.text("Excellent, thank you!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("Wow, you failed?  All that work, down the drain…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_ZOMBIE_BLOOD_ANAL",
    name = ccb.content.text("Analyze Alien Fungus"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 8,
    value = 250000,
    item = "veggy_tainted",
    start = {
        target = { terrain = "forest", reveal_radius = 3 },
        map_updates = {
            {
                layout = {
                    item_placements = {
                        { id = "veggy_tainted", x = 14, y = 15, amount = { 10, 20 }, repetitions = { 1, 3 } },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("You've seen these walking fungus things around?  I would like to take a closer look at their flesh.  For science."),
        offer = ccb.content.text("I need someone to get a sample of strange alien fungus chunks and bring it to me."),
        accepted = ccb.content.text("Excellent.  Get me those nasty chunks."),
        rejected = ccb.content.text("Are you sure?  The scientific value of those smelly chunks could be priceless…"),
        advice = ccb.content.text("I was cutting up a fungus creature in a nearby forest.  I was chased of by a big raven before I could finish, but perhaps you are brave enough to fetch the remains.  Alternatively, you could go and kill and butcher one of those things yourself."),
        inquire = ccb.content.text("Well, do you have the disgusting chunks yet?"),
        success = ccb.content.text("Excellent!  This may be the key to removing the infection."),
        success_lie = ccb.content.text("Wait, you couldn't possibly have the nasty chunks!  Liar!"),
        failure = ccb.content.text("What a shame, that horrible chunk could have proved invaluable…"),
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
            search_range = 60,
            min_distance = 5,
            z = 0,
        },
        map_updates = {
            { layout = { monster_placements = { { id = "mon_jabberwock", x = 11, y = 11, target = true } } } },
        },
    },
    finish = { native_actions = { "npc_thankful" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("The eater of the dead… something was ripping trees to shreds and only leaving a few scattered limbs…"),
        offer = ccb.content.text("A few days ago another survivor and I were in the woods.  One night something caught onto our trail and chased us for ten minutes or so until we decided to split up and meet-up back here.  My buddy never showed up and I don't have the means to kill whatever it was.  Can you lend a hand?"),
        accepted = ccb.content.text("Thanks, make sure you're ready for whatever the beast is."),
        rejected = ccb.content.text("Hey, I know I wouldn't volunteer for it either."),
        advice = ccb.content.text("Make sure you have a good weapon.  It sounded pretty big."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("You look a little shaken up, I can't tell you how glad I am that you killed it though."),
        success_lie = ccb.content.text("Something in the shadows still seems to stare at me when I look at the woods."),
        failure = ccb.content.text("I'm glad you came back alive… I wasn't sure if I had sent you to your death."),
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_ZOMBIE_MOM",
    name = ccb.content.text("Kill Zombie Bear"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 120000,
    urgent = true,
    start = {
        target = { terrain = "forest", reveal_radius = 3 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_zombear", name = ccb.content.text("Willa"), x = 12, y = 12, target = true },
                    },
                },
            },
        },
    },
    finish = { native_actions = { "npc_thankful" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh god, I can't believe it happened…"),
        offer = ccb.content.text("My bear… she's… she was killed, but then she just got back up… she's one of those things now.  Can you put her out of her misery for me?"),
        accepted = ccb.content.text("Thank you… she would've wanted it this way."),
        rejected = ccb.content.text("Please reconsider, I know she's suffering…"),
        advice = ccb.content.text("She's still a bear, and seemed furious, so be wary.  And please, make it quick…"),
        inquire = ccb.content.text("Well…?  Did you… finish things for my bear?"),
        success = ccb.content.text("Thank you.  I couldn't rest until I knew that was finished."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("Really… that's too bad."),
    },
}

ccb.content.define_mission {
    id = "MISSION_RESCUE_DOG",
    name = ccb.content.text("Find Lost Dog"),
    goal = "MGOAL_FIND_MONSTER",
    difficulty = 3,
    value = 100000,
    start = {
        target = { terrain = "forest", reveal_radius = 3 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_dog",
                            name = ccb.content.text("Sparky"),
                            x = 12,
                            y = 12,
                            target = true,
                            friendly = true,
                        },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_OPENER_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh, my poor puppy…"),
        offer = ccb.content.text("I left my stupid dog in the woods, not far from here.  Can you retrieve it?"),
        accepted = ccb.content.text("Thank you!  Please hurry back!"),
        rejected = ccb.content.text("Please, think of my poor little puppy!"),
        advice = ccb.content.text("Good luck!"),
        inquire = ccb.content.text("Have you found my dog yet?  His name is Sparky!"),
        success = ccb.content.text("Thank you so much for finding him!"),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("Oh no!  My poor puppy…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_CITY_COP_MOMENTO",
    name = ccb.content.text("Go into deep woods to retrieve family seeds"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 800,
    item = "seed_weed",
    origins = { "ORIGIN_SECONDARY" },
    start = {
        target = { terrain = "forest", reveal_radius = 3 },
        map_updates = {
            { layout = { item_placements = { { id = "seed_weed", x = 14, y = 15, amount = { 10, 20 } } } } },
        },
    },
    dialogue = {
        describe = ccb.content.text("I need you to get my family seeds from the deep woods."),
        offer = ccb.content.text("I left some special seeds from my family in the deep woods.  Can you get them?"),
        accepted = ccb.content.text("Thanks, it's great to see someone willing to help out."),
        rejected = ccb.content.text("Well, I'll find someone else to do it for me, maybe there are a lot of people left…"),
        advice = ccb.content.text("I'll know the seeds when I see them.  Just bring me any seeds you find."),
        inquire = ccb.content.text("Got the seeds?  They're important to me."),
        success = ccb.content.text("Thanks!  I'll be sure to put in a good word for you around the woods.  With like birds or whatever."),
        success_lie = ccb.content.text("OK, then hand it over."),
        failure = ccb.content.text("Shit happens."),
    },
}

ccb.content.define_mission {
    id = "MISSION_LEARN_ABOUT_CATTAIL_JELLY",
    name = ccb.content.text("Gather cattail stalks to create cattail jelly"),
    description = ccb.content.text("Gather <color_light_blue>80 cattail stalks</color> from the swamp and bring them back to <color_light_red>learn how to craft cattail jelly</color>.  Raise your <color_light_blue>survival skill to at least 1</color> by harvesting cattail stalks.  <color_light_blue>Bring back the provided bag</color> as well."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    generic_rewards = false,
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    start = {
        target = { terrain = "forest_water", reveal_radius = 3 },
        actions = { { item = "backpack_leather" } },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.transfer_items("backpack_leather"),
            ccb.content.dialogue_actions.transfer_items("cattail_stalk", 80),
            { handler = "prepare_80_cattail_stalks" },
            { handler = "teach_cattail_jelly" },
            ccb.content.dialogue_actions.notify_player(ccb.content.text("You learn how to craft cattail jelly.")),
            { item = "cattail_jelly", count = 7, container = "stomach_sealed" },
        },
    },
    dialogue = {
        describe = ccb.content.text("Medical services are a little sparse here, but people have been surviving using their wits and the bounty of Mother Nature for a long time.  Care to learn a little?"),
        offer = ccb.content.text("Did you know that cattails are a source of a jelly that works as an antiseptic and analgesic?  Something like that is likely to be mighty helpful out here.  I want you to take this bag, head to the nearest swamp, collect 80 cattail stalks, and bring them back here.  In exchange, I'll show you how to harvest the jelly."),
        accepted = ccb.content.text("Great!  This bag should be big enough to hold all of the stalks we'll need.  Don't forget to bring it back."),
        rejected = ccb.content.text("Your loss."),
        advice = ccb.content.text("The cattails grow in the fresh water in swamps.  You can't miss them."),
        inquire = ccb.content.text("Got those cattail stalks yet?  Don't forget to bring back my bag and to work on improving your survival skill as well."),
        success = ccb.content.text("Great!  Hand them over and I'll show you how this works."),
        success_lie = ccb.content.text("OK, then hand them over."),
        failure = ccb.content.text("Well, that's a shame."),
    },
    complete_when = "complete_mission_learn_about_cattail_jelly_backpack_leather",
}

-- NPC will ask player to burn tagged forest tile. Will follow player after accepting mission.
-- Change first topic to do proper checks. MGOAL_GO_TO to check if player stands on tagged tile.
-- At the end of the mission, will place fire on tagged tile and NPC will join player faction.
ccb.content.define_mission {
    id = "MISSION_PYROMANIAC",
    name = ccb.content.text("Angry pyromaniac"),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 0,
    generic_rewards = false,
    start = {
        target = { terrain = "forest", match = "PREFIX", search_range = 75, random = true, z = 0 },
        actions = { "follow_only", ccb.content.dialogue_actions.set_first_topic("MISSION_PYROMANIAC") },
    },
    finish = {
        actions = {
            "follow",
            { handler = "deliver_tinder_1_items" },
            ccb.content.dialogue_actions.update_map("MISSION_PYROMANIAC_BURN_INNAWOOD"),
        },
    },
    origins = { "ORIGIN_OPENER_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh man, I want to fucking burn it so bad…"),
        offer = ccb.content.text("I'm so fucking infuriated!  I've got a tree that ruined my life, and now I want to get revenge!  I don't care about <the_cataclysm>, I just want to burn that tree!  Would you help me, <name_g>?"),
        accepted = ccb.content.text("Good.  Let's go to the tree and goddamn burn it down!  Oh, bring some tinder so we can start the fire.  I can make the sparks."),
        rejected = ccb.content.text("Seriously?  It's such an easy job…"),
        advice = ccb.content.text("Maybe we can find a stick in the woods."),
        inquire = ccb.content.text("Are you ready, <name_g>?"),
        success = ccb.content.text("Sweet, sweet revenge!  Ah, smells so nice!  Feels like the smell of napalm in the morning!  It will all burn to ashes in a matter of minutes.  You helped me get my revenge, so I'll follow you to the end, <name_g>!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("Wow, you failed?  How…"),
    },
}

-- MISSION_PYROMANIAC mission set this topic as starting topic for mission giver.
ccb.content.define_dialogue_topic {
    id = "MISSION_PYROMANIAC",
    line = ccb.content.text("Are we there yet, <name_g>?  I can't wait to burn that tree!"),
    replies = {
        {
            text = ccb.content.text("We're here.  Let's do it!"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.all({ predicates.actor_state("interlocutor", "mission_complete"), predicates.has_inventory("speaker", "tinder", 1) }),
        },
    },
}

-- For MISSION_PYROMANIAC. Will spawn fire on tile where PC is standing.
ccb.content.define_mapgen {
    kind = "update",
    id = "MISSION_PYROMANIAC_BURN_INNAWOOD",
    layout = {
        item_placements = { { id = "tinder", x = { 5, 20 }, y = { 5, 20 }, amount = 5, repetitions = 40 } },
        field_placements = { { id = "fd_fire", x = { 5, 20 }, y = { 5, 20 }, repetitions = 40 } },
    },
}
