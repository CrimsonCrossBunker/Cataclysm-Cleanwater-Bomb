local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_1a",
    line = {
        choices = {
            ccb.content.text("*looks up from her computer and gives you a quick, thin smile.  \"Hello again.\""),
            ccb.content.text("*tips the lid of her laptop closed and looks up.  \"Nice to see you again.\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Jenny.  What are you up to these days?"),
            next_topic = "TALK_REFUGEE_JENNY_2",
        },
        { text = ccb.content.text("Sorry Jenny.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_2",
    line = ccb.content.text("I'm puttering around, I always have stuff on the go.\"  Jenny rubs the bridge of her nose briefly, blinking fatigue from her eyes.  \"Gotta keep busy, keep my mind off stuff, you know?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
