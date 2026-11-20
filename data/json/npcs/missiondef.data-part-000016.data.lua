local ccb = require("ccb")

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
