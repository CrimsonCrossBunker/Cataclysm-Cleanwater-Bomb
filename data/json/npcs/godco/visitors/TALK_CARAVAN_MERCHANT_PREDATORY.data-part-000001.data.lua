local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_2",
    line = ccb.content.text("What can I do for you, <name_g>?"),
    replies = {
        {
            text = ccb.content.text("Do you have anything to trade?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Your prices seem awfully high."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Price",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_paidoff" } })),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Story",
        },
        {
            text = ccb.content.text("Nothing much.  Just passing through."),
            next_topic = "TALK_DONE",
        },
    },
}
