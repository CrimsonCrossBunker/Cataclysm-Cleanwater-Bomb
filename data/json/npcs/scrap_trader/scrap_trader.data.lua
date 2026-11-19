local ccb = require("ccb")

-- this is all the dialogue related to buying bulk metal or scrap.
ccb.content.define_dialogue_topic {
    id = "TALK_SCRAP_TRADER_BULK_SELL",
    line = {
        choices = { ccb.content.text("Sure thing.  I've got a few things on hand.  What'll ya have?") },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Let's take a look at your stock."),
            next_topic = "TALK_SCRAP_TRADER_BULK_SELL_END",
            native_actions = { "start_trade" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCRAP_TRADER_BULK_SELL_END",
    line = { choices = { ccb.content.text("Anything else you need?") } },
    replies = {
        { text = ccb.content.text("No, that's all."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Find anything good?"),
            next_topic = "TALK_SCRAP_TRADER_ASK_INTERVAL",
        },
        {
            text = ccb.content.text("Can I have another look?"),
            next_topic = "TALK_SCRAP_TRADER_BULK_SELL_END",
            native_actions = { "start_trade" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCRAP_TRADER_ASK_INTERVAL",
    line = ccb.content.text("Nope, although I have a really good claim by the river.  Gonna go fetch them soon, be right back after <restock_time_point>."),
    replies = { { text = ccb.content.text("Well, good luck."), next_topic = "TALK_NPC_SCRAP_TRADER" } },
}
