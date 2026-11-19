local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_1_JOB",
    line = ccb.content.text("I was sent here to assist in setting up the farm.  Most of us have no real skills that transfer from before the Cataclysm, so things are a bit of trial and error."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_RANCH_FARMER_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_1_HIRE",
    line = ccb.content.text("I'm sorry, I don't have anything to trade.  The work program here splits what we produce between the refugee center, the farm, and ourselves.  If you are a skilled laborer, then you can trade your time for a bit of extra income on the side.  Not much I can do to assist you as a farmer though."),
    replies = { { text = ccb.content.text("Oh."), next_topic = "TALK_RANCH_FARMER_1" } },
}
