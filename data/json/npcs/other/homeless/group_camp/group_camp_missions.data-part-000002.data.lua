local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_5",
    name = ccb.content.text("Refurbishments Pt. V"),
    description = ccb.content.text("Obtain a shovel."),
    goal = "MGOAL_FIND_ITEM",
    item = "shovel",
    item_count = 1,
    difficulty = 1,
    value = 2500,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_6",
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp",
                layout = { nested = { { x = 0, y = 0, id = "homeless_camp_refurb_4" } } },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("Our sanitation here has become… problematic.  We've mostly just been going outside the walls to piss.  Not only is it kinda unhealthy, but the last time I wandered out I almost got eaten!  So, if you'd get us a shovel, we could make a latrine for ourselves.  We'll pay you fairly, as usual."),
        advice = ccb.content.text("A hardware store should have one lying around."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have the shovel?"),
        success = ccb.content.text("Thank you.  We're eternally grateful to you."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("I'll do it myself, then."),
    },
}
