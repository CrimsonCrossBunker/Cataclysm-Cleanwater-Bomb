local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TRADE_HALLU",
    line = ccb.content.text_without_extraction("<hallu_dont_trade>"),
    replies = { { text = ccb.content.text("Fair enough."), next_topic = "TALK_NONE" } },
}
