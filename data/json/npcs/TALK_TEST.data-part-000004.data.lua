local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_TIME",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is a is day test response."),
            next_topic = "TALK_DONE",
            when = predicates.conversation_state("daylight"),
        },
        {
            text = ccb.content.text("This is a is night test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.conversation_state("daylight")),
        },
    },
}
