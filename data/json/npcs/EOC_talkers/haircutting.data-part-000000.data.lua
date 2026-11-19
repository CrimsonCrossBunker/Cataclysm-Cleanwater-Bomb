local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CUT_HAIR_OR_BEARD",
    line = ccb.content.text("Do you want to shave, or cut your hair?"),
    replies = {
        { text = ccb.content.text("Shave your beard."), next_topic = "TALK_CUT_YOUR_BEARD" },
        { text = ccb.content.text("Cut your hair."), next_topic = "TALK_CUT_YOUR_HAIR" },
        { text = ccb.content.text("Don't do either."), next_topic = "TALK_DONE" },
    },
}
