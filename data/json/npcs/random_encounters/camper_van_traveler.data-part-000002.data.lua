local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_LEAVING_WHEN",
    line = ccb.content.text("I'll be gone here in a day or two, just stopping long enough to get some supplies and fix anything wrong with the camper."),
    replies = { { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_CAMPER_VAN_TRAVELER_TRADE",
    line = ccb.content.text("I don't have a whole lot, but I've got a few things that I could stand to be rid of, too much weight tanks the gas mileage.  I could always use more fuel, food, and clean water if you have any to spare.  Entertainment is also appreciated, it's pretty fucking boring looking at nothing but road for 10 hours a day."),
    replies = {
        {
            text = ccb.content.text("Let's take a look."),
            next_topic = "TALK_NPC_CAMPER_VAN_TRAVELER",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
