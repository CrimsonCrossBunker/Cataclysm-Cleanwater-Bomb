local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_TEST_GUARD" },
    replies = {
        {
            text = ccb.content.text("I have a custom response to a common topic"),
            next_topic = "TALK_TEST_FACTION_TRUST",
        },
    },
}
