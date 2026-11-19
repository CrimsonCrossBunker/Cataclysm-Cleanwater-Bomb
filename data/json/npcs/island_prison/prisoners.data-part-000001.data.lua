local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PRISONER_GENERIC",
    line = ccb.content.text("Get the fuck out of here."),
    replies = {
        { text = ccb.content.text("Ok, sorry, I'm already leaving!"), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Hey, fuck you, <name_b>!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
        },
    },
}
