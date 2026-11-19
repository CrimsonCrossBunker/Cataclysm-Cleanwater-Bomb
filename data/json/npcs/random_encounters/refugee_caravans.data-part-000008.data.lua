local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_REFUGEE_B1_Join_Yes",
    line = ccb.content.text("This is the beginning of a beautiful thing.  I'm with you."),
    on_enter = { { actions = { "follow" } } },
    replies = { { text = ccb.content.text("Yes!"), next_topic = "TALK_DONE" } },
}
