local ccb = require("ccb")

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
