local ccb = require("ccb")

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
