local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_FREE_MERCHANT_DOING",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("I keep to my own business, and you keep to yours, marshal.  Seems like a fair deal?"),
        no = ccb.content.text("Well, we're part of the caravan depot set up to keep regular trade with the Exodii, here.  I'm in charge of keeping things running and restocking the caravans, but also doing trade with scavs and the like.  Happy to trade food and supplies, if you're interested."),
    },
    replies = {
        { text = ccb.content.text("Sounds good"), next_topic = "TALK_EXODII_FREE_MERCHANT" },
        {
            text = ccb.content.text("So do you plan to stick around here permanently?"),
            next_topic = "TALK_EXODII_FREE_MERCHANT_PERMENANT",
        },
    },
}
