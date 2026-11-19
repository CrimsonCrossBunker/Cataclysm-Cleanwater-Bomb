local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_RECRUITED",
    line = ccb.content.text("Golly.  I didn't expect that, but I'm as good as my word.  <lets_go>"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<lets_go>"),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
        },
    },
}
