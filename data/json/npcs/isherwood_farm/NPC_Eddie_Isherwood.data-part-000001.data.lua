local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_ConvincedMarshal",
    line = {
        joined = {
            ccb.content.text("*looks up warily as you approach"),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text(", looking at your marshal badge immediately.  \"Nope.  Agreement or not, I'm not talking to you while you're wearing their sign, and I don't appreciate the disrespect.\""),
                no = ccb.content.text(", his eyes darting to the spot where your marshal badge would be.  \"What now?\""),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("…[Leave.]"),
            next_topic = "TALK_DONE",
            opinion = { trust = -10, value = -10 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("What's the deal with you and the Old Guard, anyway?"),
            next_topic = "TALK_ISHERWOOD_EDDIE_Marshal",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}
