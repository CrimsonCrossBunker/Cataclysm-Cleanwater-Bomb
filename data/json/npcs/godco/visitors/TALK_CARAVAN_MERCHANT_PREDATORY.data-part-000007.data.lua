local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_PREDATORY_Pricegouge_Lose",
    line = ccb.content.text("What proof do you have <name_b>?  Nothing is what you got, and your the only one here who's full of shit."),
    on_enter = { { actions = { actions.set_first_topic("TALK_CARAVAN_MERCHANT_PREDATORY_NoTalk") } } },
    replies = {
        {
            text = ccb.content.text("If you don't wanna cooperate, I'll stop this by force."),
            next_topic = "TALK_DONE",
            actions = { "hostile" },
        },
        { text = ccb.content.text("…"), next_topic = "TALK_DONE" },
    },
}
