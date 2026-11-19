local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_OUTFITTER" },
    line = ccb.content.text("&You find the clerk in between stacked second hand outfits of all kinds."),
    replies = {
        {
            text = ccb.content.text("I want to buy some gear."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}
