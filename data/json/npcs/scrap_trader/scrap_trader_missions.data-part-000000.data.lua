local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_SCRAP_TRADER_GET_25_MAGNETRON",
    name = ccb.content.text("Find 25 Magnetrons"),
    description = ccb.content.text("Obtain 25 magnetrons in exchange for credit with the scrap merchant."),
    goal = "MGOAL_FIND_ITEM",
    item = "magnetron",
    item_count = 25,
    difficulty = 2,
    value = 10000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_SCRAP_TRADER_GET_75_CHARCOAL",
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_trade_specific_metal_tradeable", "yes"),
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need help…"),
        offer = ccb.content.text("Since business is increasing around here, I've decided to start selling more specialized metal.  Problem is, I can't separate the metal out.  Fortunately, I found some old schematics on a machine for this sort of thing.  If you could get me 25 magnetrons, I can melt down the sorted stuff into bars.  I can quickly pay you in raw materials."),
        advice = ccb.content.text("Magnetrons can be found in microwaves.  An apartment block should have tons of them."),
        accepted = ccb.content.text("I'll be here when you get back.  Good luck!"),
        rejected = ccb.content.text("Someone's got to do it."),
        inquire = ccb.content.text("Do you have the magnetrons?"),
        success = ccb.content.text("Wonderful!  I'll start the smelting as soon as possible."),
        success_lie = ccb.content.text("Where are they?  I don't believe you."),
        failure = ccb.content.text("That's unfortunate.  I guess I'll do it myself."),
    },
}
