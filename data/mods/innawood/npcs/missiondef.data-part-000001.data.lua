local ccb = require("ccb")

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
