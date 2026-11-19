local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_HOW_ARE_YOU",
    line = ccb.content.text_without_extraction("<BALTHAZAR_HOW_ARE_YOU>"),
    replies = { { text = ccb.content.text("Thats great."), next_topic = "TALK_NONE" } },
}
