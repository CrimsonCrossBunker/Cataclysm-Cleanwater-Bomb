local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_DOING",
    line = ccb.content.text("I burn down buildings and sell the Free Merchants the materials.  No, seriously.  If you've seen burned wreckage in place of suburbs or even see the pile of rebar for sale, that's probably me.  They've kept me well off in exchange, I guess."),
    replies = {
        {
            text = ccb.content.text("I'll buy."),
            native_actions = { "start_trade" },
            next_topic = "TALK_ARSONIST",
        },
        { text = ccb.content.text("Who needs rebar?"), next_topic = "TALK_ARSONIST_DOING_REBAR" },
    },
}
