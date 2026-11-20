local ccb = require("ccb")

-- 170 wood walls * 40 nails per wall
ccb.content.define_mission {
    id = "MISSION_LUMBERMILL_GET_6800_NAILS",
    name = ccb.content.text("Get 6,800 Nails"),
    description = ccb.content.text("Obtain 6,800 nails in exchange for credit with the loggers."),
    followup = "MISSION_LUMBERMILL_GET_6_BLANKETS",
    goal = "MGOAL_FIND_ITEM",
    item = "nail",
    item_count = 6800,
    difficulty = 32,
    value = 2000000,
    origins = { "ORIGIN_SECONDARY" },
    finish = {
        map_updates = {
            {
                terrain = "lumbermill_0_0_ocu",
                layout = { nested = { { x = 0, y = 0, id = "occupied_lum_wall_0_0" } } },
            },
            {
                terrain = "lumbermill_0_1_ocu",
                layout = { nested = { { x = 0, y = 0, id = "occupied_lum_wall_0_1" } } },
            },
            {
                terrain = "lumbermill_1_0_ocu",
                layout = { nested = { { x = 0, y = 0, id = "occupied_lum_wall_1_0" } } },
            },
            {
                terrain = "lumbermill_1_1_ocu",
                layout = { nested = { { x = 0, y = 0, id = "occupied_lum_wall_1_1" } } },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need 6,800 nails."),
        offer = ccb.content.text("While fairly sturdy, the metal fence around this place won't hold out for long.  So, we've decided to replace it with a wall.  However, the nails we had were used to repair our existing structures, and they weren't nearly enough.  After some calculations, we need 6,800 nails to do it.  That may seem like a lot, but we're willing to give you a TON of credit for it."),
        advice = ccb.content.text("You might have to do more than just scrapping a bunch of furniture.  Dismantling a building somewhere in town could get you what you need."),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Well, I suppose that's reasonable."),
        inquire = ccb.content.text("Do you have the nails?"),
        success = ccb.content.text("That's absolutely amazing!  I can't thank you enough for this!"),
        success_lie = ccb.content.text("You're a fucking scammer, <name_b>!"),
        failure = ccb.content.text("That's unfortunate.  I guess we'll have to find someone else to do it."),
    },
}
