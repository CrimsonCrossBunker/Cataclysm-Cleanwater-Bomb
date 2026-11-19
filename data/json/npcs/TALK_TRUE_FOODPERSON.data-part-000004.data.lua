local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FOODPERSON_ONLYONE",
    line = ccb.content.text("There can be only one!"),
    replies = {
        {
            text = ccb.content.text("I AM THE ONE!"),
            next_topic = "TALK_DONE",
            native_actions = { "hostile" },
            opinion = { trust = -20, value = -20 },
        },
        {
            when = predicates.negate(predicates.has_trait("speaker", "PROF_FOODP")),
            text = ccb.content.text("Wow, calm down, it's just a prank bro."),
            next_topic = "TALK_DONE",
            opinion = { trust = -20, value = -20 },
        },
        {
            when = predicates.has_trait("speaker", "PROF_FOODP"),
            text = ccb.content.text("WAIT!  There might be another way!"),
            next_topic = "TALK_NONE",
        },
        {
            when = predicates.has_trait("speaker", "PROF_FOODP"),
            text = ccb.content.text("I don't want to fight you.  I'm leaving."),
            next_topic = "TALK_DONE",
        },
    },
}
