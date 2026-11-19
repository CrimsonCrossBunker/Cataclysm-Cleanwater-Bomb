local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_TOPIC_ITEM_MUTATOR",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = { { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" } },
    repeat_replies = {
        {
            items = { "bottle_glass" },
            reply = {
                text = ccb.content.text("This is a repeated item bottle_glass test response"),
                next_topic = "TALK_TEST_TOPIC_ITEM_MUTATOR_2",
            },
        },
    },
}
