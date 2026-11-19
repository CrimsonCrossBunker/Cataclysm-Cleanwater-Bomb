local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_STRANGER_NEUTRAL", "TALK_STRANGER_FRIENDLY" },
    replies = {
        {
            text = ccb.content.text("Another survivor!  We should travel together."),
            next_topic = "TALK_SUGGEST_FOLLOW",
        },
        { text = ccb.content.text("What are you doing?"), next_topic = "TALK_DESCRIBE_MISSION" },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TRADE_HALLU",
            when = predicates.has_trait("interlocutor", "HALLUCINATION"),
            switch = true,
            default = false,
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_DONE",
            native_actions = { "start_trade" },
            switch = true,
            default = false,
        },
    },
}
