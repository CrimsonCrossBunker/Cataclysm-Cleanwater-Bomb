local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BEM_KEYCARD_SELLER_ASK",
    line = ccb.content.text("Well that'd be telling.  Suffice to say that a few friends found them, and none of us are into the lab-dive business."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_KEYCARD_SELLER_NO_DISCOUNTS",
    line = ccb.content.text("Not a bargain bin kid, the price's the price."),
    replies = {
        {
            text = ccb.content.text("See you around then."),
            native_actions = { "end_conversation" },
            next_topic = "TALK_DONE",
        },
    },
}
