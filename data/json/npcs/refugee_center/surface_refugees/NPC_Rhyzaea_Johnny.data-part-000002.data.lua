local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Rhyzaea_1",
    line = ccb.content.text("Hi there.  I don't think we've met before.  I'm Rhyzaea, people call me Rhy."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Rhyzaea_Johnny", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Rhyzaea_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Rhy."),
            next_topic = "TALK_REFUGEE_Rhyzaea_1_firstmeet",
        },
        {
            text = ccb.content.text("Nice to meet you, Rhy.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
