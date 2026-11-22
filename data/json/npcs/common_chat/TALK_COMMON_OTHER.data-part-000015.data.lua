local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_DELIVER_CONFIRM",
    line = ccb.content.text("Pleasure doing business!"),
    replies = {
        {
            text = ccb.content.text("You might be seeing more of me…"),
            next_topic = "TALK_DONE",
            actions = { "u_bulk_trade_accept" },
        },
    },
}
