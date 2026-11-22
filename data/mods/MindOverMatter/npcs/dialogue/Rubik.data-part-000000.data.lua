local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_EXODII_MERCHANT_Talk" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("What's with those clusters of weird plants I've seen around?"),
            next_topic = "TALK_EXODII_MERCHANT_alien_flora",
            when = predicates.handler("dlg_p_mindovermatter_62abf232ddd6"),
        },
    },
}
