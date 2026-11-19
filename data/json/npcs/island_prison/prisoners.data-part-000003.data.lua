local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_READY_TO_MUG",
    line = ccb.content.gendered_line("You think you're immortal, huh, <name_b>?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Gee, what's the matter with you?  Okay, okay, I'm leaving."),
            next_topic = "TALK_PRISONER_MUG",
        },
        {
            text = ccb.content.text("It would be you who will regret talking to me like that."),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_MUG",
    line = ccb.content.text("Not so fast, I think you need to pay for breaking your promise and bothering me.  Give me your shit, now!"),
    replies = {
        {
            text = ccb.content.text("Please don't hurt me!  Take all that you want."),
            next_topic = "TALK_MUG",
        },
        {
            text = ccb.content.text("What, <no>!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}
