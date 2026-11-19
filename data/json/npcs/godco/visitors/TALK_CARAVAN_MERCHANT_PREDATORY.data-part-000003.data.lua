local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
    line = ccb.content.text("Heh, always good to do business."),
    replies = {
        {
            text = ccb.content.text("Actually, I had a little more to trade still."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("You got anything else?"),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_askinterval",
        },
        {
            text = ccb.content.text("Your prices seem awfully high."),
            next_topic = "TALK_CARAVAN_MERCHANT_PREDATORY_Price",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_paidoff" } })),
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
