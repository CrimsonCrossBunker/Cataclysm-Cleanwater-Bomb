local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_AGREE_FOLLOW",
    line = ccb.content.text("You got it, I'm with you!"),
    replies = {
        { text = ccb.content.text("Awesome!"), next_topic = "TALK_FRIEND" },
        { text = ccb.content.text_without_extraction("<lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_FOLLOW",
    line = ccb.content.text("Yeah… I don't think so."),
    replies = { { text = ccb.content.text("Oh, okay."), next_topic = "TALK_DONE" } },
}
