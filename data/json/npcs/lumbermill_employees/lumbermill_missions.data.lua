local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_DRIVEBELTS",
    name = ccb.content.text("Find Drive Belts"),
    description = ccb.content.text("Obtain 3 drive belts in exchange for credit with the loggers."),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 4000,
    complete_when = "complete_mission_get_drivebelts",
    finish = {
        actions = {
            { handler = "deliver_mission_get_drivebelts" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_LUMBERMILL_GET_1000_NAILS",
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need three drive belts."),
        offer = ccb.content.text("Some of our machinery received some damage before <the_cataclysm> and we were waiting on replacement parts.  Now everything's changed and those parts are more important than ever.  Get us three drive belts and I'll give you some credit with us."),
        advice = ccb.content.text("If you can't find actual drive belts on engines, a good replacement can be made from a belt and some duct tape.  Nothing difficult."),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Someone's got to do it."),
        inquire = ccb.content.text("Do you have the belts?"),
        success = ccb.content.text("Wonderful!  Thanks, <name_g>, we'll be fine for a long while from now."),
        success_lie = ccb.content.text("Where are they?  I don't believe you."),
        failure = ccb.content.text("That's unfortunate.  I guess we'll have to find someone else to do it."),
    },
}

ccb.content.define_mission {
    id = "MISSION_LUMBERMILL_GET_1000_NAILS",
    name = ccb.content.text("Get 1,000 Nails"),
    description = ccb.content.text("Obtain 1,000 nails in exchange for credit with the loggers."),
    goal = "MGOAL_FIND_ITEM",
    item = "nail",
    item_count = 1000,
    difficulty = 5,
    value = 300000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_LUMBERMILL_GET_6800_NAILS",
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need 1,000 nails."),
        offer = ccb.content.text("Along with those drive belts, we were waiting for some nails for structural repairs.  Due to <the_cataclysm>, we obviously never received them.  So, I need you to get us 1,000 nails.  We'll pay you fairly."),
        advice = ccb.content.text("Taking apart some furniture in town should get what you need."),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Someone's got to do it."),
        inquire = ccb.content.text("Do you have the nails?"),
        success = ccb.content.text("Our warehouse was about to fall apart.  These will be extremely helpful to us."),
        success_lie = ccb.content.text("Where are they?  I don't believe you."),
        failure = ccb.content.text("That's unfortunate.  I guess we'll have to find someone else to do it."),
    },
}

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

-- Dynamic response dialogs would be more natural to accept so many alternate items here.
ccb.content.define_mission {
    id = "MISSION_LUMBERMILL_GET_6_BLANKETS",
    name = ccb.content.text("Find 6 Blankets"),
    description = ccb.content.text("Obtain 6 blankets or quilts in exchange for credit with the loggers."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 4000,
    origins = { "ORIGIN_SECONDARY" },
    finish = {
        map_updates = {
            {
                terrain = "lumbermill_1_1_ocu",
                layout = { nested = { { x = 0, y = 0, id = "occupied_lum_hotel_1_1" } } },
            },
        },
        handler = "deliver_mission_lumbermill_get_6_blankets",
    },
    followup = "MISSION_LUMBERMILL_SET_TRADE_ROUTE",
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need 6 blankets."),
        offer = ccb.content.text("Now that we should be safe from harm, I decided to start adding a few things to this place.  Right now, we don't have anywhere to comfortably sleep, so we're building a small sleeping quarter.  We just need 6 big, warm blankets or quilts to finish our project."),
        advice = ccb.content.text("I figure any hotel or motel in town should have lots of blankets."),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Well, someone's got to do it."),
        inquire = ccb.content.text("Did you find us some bedding yet?"),
        success = ccb.content.text("Thanks!  Feel free to sleep here if you want.  It's the least we can do for the help."),
        success_lie = ccb.content.text("How is this supposed to help us?"),
        failure = ccb.content.text("That's unfortunate.  I guess we'll have to find someone else to do it."),
    },
    complete_when = "complete_mission_lumbermill_get_6_blankets",
}

ccb.content.define_mission {
    id = "MISSION_LUMBERMILL_SET_TRADE_ROUTE",
    name = ccb.content.text("Establish A Trade Route"),
    description = ccb.content.text("Establish trade relations between the loggers and a refugee center, and bring back a writ of the agreement."),
    goal = "MGOAL_FIND_ITEM",
    item = "trade_writ",
    item_count = 1,
    difficulty = 35,
    value = 4000,
    origins = { "ORIGIN_SECONDARY" },
    start = { target = { terrain = "evac_center_18", special = "evac_center", reveal_radius = 0 } },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("Go negotiate a trade agreement."),
        offer = ccb.content.text("While some of us were out scavenging, we spotted an old evac shelter that looks like it might have some people inside.  I want you to go over there, find whoever runs the joint, and see if we can make a deal with them for some processed lumber.  This will be invaluable to our survival."),
        advice = ccb.content.text("It should be pretty simple making the deal, but I'd recommend taking a car over there myself."),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Please give it a try?  This is really important to us."),
        inquire = ccb.content.text("What did they say about the deal?"),
        success = ccb.content.text("Thank you!  We're set for life on this one!"),
        success_lie = ccb.content.text("How does this help us?"),
        failure = ccb.content.text("That's unfortunate.  I guess we'll have to find someone else to trade with."),
    },
}
