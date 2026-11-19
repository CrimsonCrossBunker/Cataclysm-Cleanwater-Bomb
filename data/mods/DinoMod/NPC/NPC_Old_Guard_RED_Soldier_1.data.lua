local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_RED_SOLDIER",
    line = {
        choices = {
            ccb.content.text("I'm afraid I can't talk now."),
            ccb.content.text("Stay safe out there."),
            ccb.content.text("Kill all dinosaurs."),
            ccb.content.text("Welcome to whatever this is."),
            ccb.content.text("I'm supposed to direct all questions to my leadership, that's Red over there."),
        },
    },
    replies = { { text = ccb.content.text("Sure sure…"), next_topic = "TALK_DONE" } },
}
