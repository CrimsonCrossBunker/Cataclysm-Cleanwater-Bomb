local ccb = require("ccb")

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
