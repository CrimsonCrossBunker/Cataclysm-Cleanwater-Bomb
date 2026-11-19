local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_ITEM_REPEAT",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = { { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" } },
    repeat_replies = {
        {
            items = { "beer", "bottle_glass" },
            reply = {
                text = ccb.content.text("This is a repeated item beer, bottle_glass test response"),
                next_topic = "TALK_DONE",
            },
        },
        {
            categories = { "manuals" },
            reply = {
                text = ccb.content.text("This is a repeated category manuals test response"),
                next_topic = "TALK_DONE",
            },
        },
        {
            categories = { "manuals", "food" },
            reply = {
                text = ccb.content.text("This is a repeated category manuals, food test response"),
                next_topic = "TALK_DONE",
            },
        },
    },
}
