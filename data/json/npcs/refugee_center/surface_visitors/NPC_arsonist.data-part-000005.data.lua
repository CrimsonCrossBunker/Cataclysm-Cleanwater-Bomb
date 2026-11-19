local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_TRADING",
    line = ccb.content.text("I made some nice things with that ammonium nitrate you got me.  Want to trade?"),
    replies = {
        {
            text = ccb.content.text("I'll buy."),
            native_actions = { "start_trade" },
            next_topic = "TALK_ARSONIST",
        },
    },
}
