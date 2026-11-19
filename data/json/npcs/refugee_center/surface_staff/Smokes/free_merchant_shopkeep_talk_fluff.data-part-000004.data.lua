local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = {
        "TALK_FREE_MERCHANTS_MERCHANT_AskJoin", "TALK_FREE_MERCHANTS_MERCHANT_AskJoin1",
        "TALK_FREE_MERCHANTS_MERCHANT_AskJoin2",
    },
    line = ccb.content.text("I'm sorry, but the last thing we need is another mouth to feed.  Most of us lack any real survival skills, so keeping our group small enough to survive on the food we trade for is the main thing keeping us alive."),
    replies = {
        {
            text = ccb.content.text("Another time, then."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("I can pull my own weight!"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AskJoin1",
        },
        {
            text = ccb.content.text("Maybe I could change your mind…?~"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AskJoin2",
            when = predicates.has_item("speaker", "condom"),
        },
    },
}
