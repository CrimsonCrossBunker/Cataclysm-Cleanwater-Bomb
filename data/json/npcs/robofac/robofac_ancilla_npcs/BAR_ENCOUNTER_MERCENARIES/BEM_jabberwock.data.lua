local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BEM_JABBERWOCK_4",
    line = ccb.content.text("&<mypronoun> silently points at your maps with a trembling hand."),
    on_enter = { { actions = { actions.assign_mission("BEM_jabberwock_mission") } } },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_DONE",
            actions = { "end_conversation" },
        },
    },
}
