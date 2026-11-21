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
