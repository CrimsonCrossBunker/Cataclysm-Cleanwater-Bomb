local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Price",
    line = ccb.content.gendered_line("Like I said, I'm a businessman and business is my job.  Those other yahoos you've been talkin' to don't know what they're doing.", { "interlocutor" }),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_trade_u_think_suspicious_price", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Alright.  I'd like to buy something."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I think you're full of shit.  I know you're gouging for your own benefit, and wouldn't it be a shame if this information were to get out?"),
            trial = {
                kind = "persuade",
                difficulty = 5,
                modifiers = { { score = "INTIMIDATE", scale = 4 } },
            },
            success = { next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Pricegouge_Win" },
            failure = { next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Pricegouge_Lose" },
        },
        {
            text = ccb.content.text("Alright.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
