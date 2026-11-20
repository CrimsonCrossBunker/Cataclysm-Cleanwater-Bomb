local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_1",
    name = ccb.content.text("Refurbishments"),
    description = ccb.content.text("Obtain 100 planks."),
    goal = "MGOAL_FIND_ITEM",
    item = "2x4",
    item_count = 100,
    difficulty = 1,
    value = 10000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_2",
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp_npc",
                layout = { nested = { { x = 0, y = 0, id = "homeless_camp_refurb_1" } } },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("My buddies and I have decided to stay here for a while.  This is about the only safe place out here, and it's kinda become our home.  Anyway, we're going to build a wall.  Our old logs have provided a bunch of the wood, but we still need quite a few planks.  About 100 of them.  If you could get it for us, I'd be grateful."),
        advice = ccb.content.text("Any nearby forest should have all you need.  Otherwise, you might try breaking down some furniture in town."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have my lumber?"),
        success = ccb.content.text("Thank you.  We'll start right away."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
}

ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_2",
    name = ccb.content.text("Refurbishments Pt. II"),
    description = ccb.content.text("Obtain 150 planks."),
    goal = "MGOAL_FIND_ITEM",
    item = "2x4",
    item_count = 150,
    difficulty = 1,
    value = 15000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_3",
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp_npc",
                layout = { nested = { { x = 0, y = 0, z = 0, id = "homeless_camp_refurb_2" } } },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("Now that we've got the wall done, we decided to move out of these old tents.  We still have some leftover nails but we need more wood.  So, if you could get us 150 planks, we'd be grateful."),
        advice = ccb.content.text("Any nearby forest should have all you need.  Otherwise, you might try breaking down some furniture in town."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have my lumber?"),
        success = ccb.content.text("Thank you.  We'll start right away."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
}
