local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Pricegouge_Win",
    line = ccb.content.text("Woah woah woah, cool your jets.  I can't let this spread about me, so name your price and keep quiet, and I might give you a discount."),
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "general_meeting_u_paidoff", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("50 merch and you have a deal."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_2effb650b682") },
        },
        {
            text = ccb.content.text("You know what, I don't want your <freaking> dirty money.  Go fuck yourself."),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
    },
}
