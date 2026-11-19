local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_START",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = { { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" } },
}
