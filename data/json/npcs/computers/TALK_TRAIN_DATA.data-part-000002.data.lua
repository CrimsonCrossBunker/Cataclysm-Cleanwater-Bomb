local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_TRAIN_DATA_MONRAIL_REQUEST",
    line = ccb.content.text("UNABLE TO CONTACT MONORAIL LINE.  PLEASE SEE YOUR ADMINISTRATOR FOR ASSISTANCE."),
    replies = {
        { text = ccb.content.text("Go back."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Power off."), next_topic = "TALK_DONE" },
    },
}
