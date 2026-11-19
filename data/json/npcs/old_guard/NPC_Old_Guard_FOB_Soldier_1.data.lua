local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_FOB_SOLDIER",
    line = {
        choices = {
            ccb.content.text("I'm afraid I can't talk now."),
            ccb.content.text("Stay safe out there."),
            ccb.content.text("Welcome to camp Arabella"),
            ccb.content.text("I'm supposed to direct all questions to my leadership."),
            ccb.content.text("If you're looking to trade you'll need to talk to the quartermaster."),
        },
    },
    replies = { { text = ccb.content.text("Don't mind me…"), next_topic = "TALK_DONE" } },
}
