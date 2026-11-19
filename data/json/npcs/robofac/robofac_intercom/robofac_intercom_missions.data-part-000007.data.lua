local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_1_COMPLETE", "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_2" },
    line = ccb.content.text("&The intercom is silent for a few seconds while the tray slides back in.  \"Yes it is.  It's unfortunate that only the data was salvageable, but you have our thanks for returning it nonetheless.\""),
    replies = {
        {
            text = ccb.content.text("Alright, I've done my part.  What now?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_3",
        },
        {
            text = ccb.content.text("Is \"unfortunate\" how you usually describe someone being eviscerated by a robot?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_2",
    line = ccb.content.text("Dr. Prado knew the risks, and she chose to follow through with the test anyway.  Her death is cause for sadness, and it will affect us, but you didn't even know her.  At least now, something of her work will remain."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_3",
    line = ccb.content.text("&The voice hesitates.  \"About that.  Give me a moment.\"  After a pause, you hear muffled back-and-forth conversation.  You can't make out what's being said, but you can make out at least two other distinct voices."),
    replies = { { text = ccb.content.text("[Wait.]"), next_topic = "TALK_ROBOFAC_INTERCOM_1_JOBS" } },
}
