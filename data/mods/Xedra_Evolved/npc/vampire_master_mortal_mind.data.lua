local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_YOUR_NEW_RENFIELD",
    line = ccb.content.text("[As your blood is consumed to reshape who they are, you see something die in their eyes, replaced by an obsession to follow your orders]"),
    replies = {
        { text = ccb.content.text("I want to discuss with you."), next_topic = "TALK_FRIEND" },
        {
            text = ccb.content.text("Just follow me and my orders for now."),
            next_topic = "TALK_DONE",
        },
    },
}
