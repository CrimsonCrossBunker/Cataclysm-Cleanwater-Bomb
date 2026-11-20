local ccb = require("ccb")

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
