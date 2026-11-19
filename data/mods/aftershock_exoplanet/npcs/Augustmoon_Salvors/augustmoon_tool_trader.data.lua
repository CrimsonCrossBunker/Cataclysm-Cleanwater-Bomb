local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_TOOL_TRADER" },
    line = ccb.content.text("&The store is full of high tech gadgets, both new and salvaged.  The clerk behind the counter looks up as you enter, and gives you a nod."),
    replies = {
        {
            text = ccb.content.text("I want to buy some gear."),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}
