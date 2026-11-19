local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_HighFive",
    line = {
        choices = {
            ccb.content.text("*high fives you back enthusiastically."),
            ccb.content.text("*returns the high five with a flourish"),
            ccb.content.text("*leaps into the air and gives you a spinning high five."),
            ccb.content.text("*smacks your hand with a resounding clap."),
            ccb.content.text("*pretends to fake you out for a moment, then grins and returns the high five"),
        },
    },
    replies = {
        { text = ccb.content.text("[Nod and continue talking.]"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("[Nod and head on out.]"), next_topic = "TALK_DONE" },
    },
}
