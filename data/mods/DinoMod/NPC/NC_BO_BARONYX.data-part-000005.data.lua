local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_SUGGEST_FOLLOW_SWAMPER",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.text("Oh, you know my friend Brigitte.  Well in that case, let's go!"),
        no = ccb.content.text("No, I must remain here to oversee the company."),
    },
    replies = {
        {
            text = ccb.content.text("Of course CEO Baronyx."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.has_trait("speaker", "seer_mark")),
        },
        {
            text = ccb.content.text("Sweet!"),
            native_actions = { "follow" },
            when = predicates.has_trait("speaker", "seer_mark"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Not just now.  You should remain here to oversee the company."),
            when = predicates.has_trait("speaker", "seer_mark"),
            next_topic = "TALK_NONE",
        },
    },
}
