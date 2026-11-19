local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BALTHAZAR_MEET_REWARD_NEGOTIATE_WEAK_3",
    line = ccb.content.text("Y- You know what?  Fuck you, I'll just wait for someone else."),
    on_enter = { { actions = { "end_conversation" } } },
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}
