local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Pablo_1",
    line = ccb.content.text("*looks up at you with a young faced lined prematurely with concern.  \"Hi there.  I'm Pablo, nice to see a new face.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Pablo_Nunez", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Pablo_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Pablo, hey?  Nice to meet you."),
            next_topic = "TALK_REFUGEE_Pablo_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Pablo, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
