local ccb = require("ccb")

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
