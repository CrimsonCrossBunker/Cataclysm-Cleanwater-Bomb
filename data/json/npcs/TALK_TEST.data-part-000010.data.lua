local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SET_TOPIC",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is an npc_first_topic test response."),
            next_topic = "TALK_DONE",
            actions = { actions.set_first_topic("TALK_TEST_SET_TOPIC") },
        },
    },
}
