local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Trade",
    line = ccb.content.text("Always good to do a little trading."),
    replies = {
        {
            text = ccb.content.text("Actually, I had a little more to trade still."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Thanks.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Thanks for that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
