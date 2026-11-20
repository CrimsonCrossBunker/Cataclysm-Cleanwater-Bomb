local ccb = require("ccb")

-- TK add update mapgen.
ccb.content.define_mission {
    id = "MISSION_REFUGEE_Boris_WORKSPACE",
    name = ccb.content.text("Bring Boris a circular saw."),
    description = ccb.content.text("Find a circular saw for Boris.  Smokes might be selling one if it's available in stock."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "circsaw_off",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_REFUGEE_Boris_LAPTOP",
    dialogue = {
        describe = ccb.content.text("Find a circular saw for Boris."),
        offer = ccb.content.text("We now have a space to work in, and I have wood and nails to spare.  All I need is a saw.  I would love a table saw and mitre saw, but I can work with a hand held circular saw for now.  I have looked, and what we have is garbage.  Can you bring me a good one?"),
        accepted = ccb.content.text("You are a kind soul."),
        rejected = ccb.content.text("Ah well.  I can ask around myself, perhaps."),
        advice = ccb.content.text("It is not hard to find.  I have even seen them for sale at the merchants, but they save them as trade goods and will not give me as a gift."),
        inquire = ccb.content.text("Greetings, my friend.  Have you found a saw I can use?"),
        success = ccb.content.text("Ah, good.  VonWalt is good brand, I had a saw like this at home.  Now I shall set to work, and make myself a shop back there.  Oh yes, here is a little payment I saved."),
        success_lie = ccb.content.text("I see…"),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_completed_Boris_mission_2",
            "advance_counter_refugee_center_refugee_happiness_by_2",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Boris_LAPTOP",
    name = ccb.content.text("Bring Boris his son's lost writing."),
    description = ccb.content.text("Find Boris' son's laptop in the evac shelter marked on your map."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "laptop_boris",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    start = {
        target = {
            terrain = "shelter",
            special = "Evac Shelter",
            reveal_radius = 1,
            random = true,
            search_range = 120,
        },
        map_updates = {
            {
                layout = {
                    item_placements = {
                        { id = "laptop_boris", x = 15, y = 12 },
                        { id = "mbag", x = 15, y = 12 },
                    },
                },
            },
        },
    },
    dialogue = {
        describe = ccb.content.text("Find Boris' son's laptop."),
        offer = ccb.content.text("My son, Ash, had a laptop on which he kept his writing.  If you can find it, it would mean so much to me.  I will give you directions to the shelter where he left it.  It was barely a shelter, broken and torn apart.  It should just be on the floor where it was dropped."),
        accepted = ccb.content.text("You are a kind soul."),
        rejected = ccb.content.text("Ah well.  I can ask around myself, perhaps."),
        advice = ccb.content.text("You can tell it is his because he covered it in stickers."),
        inquire = ccb.content.text("I know it is a hard thing to hope, but were you able to find Ash's laptop?"),
        success = ccb.content.text("It is so strange to see this again, like a little piece of my old life.  I don't know if I can bring myself to read what's on it yet, but having this piece of him is a great comfort."),
        success_lie = ccb.content.text("I see…"),
        failure = ccb.content.text("Even that you tried means a lot to me."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_completed_Boris_mission_3",
            "advance_counter_refugee_center_refugee_happiness_by_2",
        },
    },
}
