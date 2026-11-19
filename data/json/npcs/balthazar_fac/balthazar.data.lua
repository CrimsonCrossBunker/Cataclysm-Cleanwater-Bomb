local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_NO_TRADE_YET",
    line = ccb.content.text("I'll first need to gather up some supplies before I can even consider trading."),
    replies = { { text = ccb.content.text("Alright then."), next_topic = "TALK_BALTHAZAR_INTERCOM_MAIN" } },
}
