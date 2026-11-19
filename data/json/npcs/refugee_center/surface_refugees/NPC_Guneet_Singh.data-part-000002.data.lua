local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Guneet_1",
    line = ccb.content.text("*is a young man in a white turban, surprisingly clean compared to the rest of his outfit.  He turns from the window as you approach, then raises his eyebrows when he sees you're a new face.  \"Oh, hello.  I don't think I've seen you around before.  I'm Guneet, people call me Gunny.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Guneet_Singh", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Guneet_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Gunny."),
            next_topic = "TALK_REFUGEE_Guneet_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Gunny, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
