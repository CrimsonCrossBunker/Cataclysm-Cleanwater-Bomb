local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading",
    line = {
        choices = {
            ccb.content.text("Hope it helps."),
            ccb.content.text("Give me second to write that down… okay, done."),
            ccb.content.text("You know where to find me."),
        },
    },
    on_enter = {
        { actions = { "distribute_food_auto" } },
    },
    replies = {
        {
            text = ccb.content.text("About other things…"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Let's trade."),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_5376c19ccc7f") },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading", actions = { "start_trade" } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO" },
        },
        {
            text = ccb.content.text("When will you have new stuff in stock?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AskedRestock",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
