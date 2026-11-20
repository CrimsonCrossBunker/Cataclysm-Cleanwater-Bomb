local ccb = require("ccb")

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
