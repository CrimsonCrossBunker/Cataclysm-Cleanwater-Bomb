local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GOTO_LOCATION_RADIO",
    line = ccb.content.text("*pssshht* ten-four, I'll make my way there, over."),
    replies = { { text = ccb.content.text("Affirmative."), next_topic = "TALK_DONE" } },
}
