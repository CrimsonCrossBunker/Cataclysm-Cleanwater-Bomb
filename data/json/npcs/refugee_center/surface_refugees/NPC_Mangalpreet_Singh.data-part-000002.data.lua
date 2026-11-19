local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mangalpreet_1",
    line = ccb.content.gendered_line("*is a well-kept middle aged woman with dark hair tied back in a long braid.  She looks surprised as you approach.  \"Ah!  You are new.  I'm sorry, I'm Mangalpreet.\"", { "speaker" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Mangalpreet_Singh", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Mangalpreet_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Mangalpreet."),
            next_topic = "TALK_REFUGEE_Mangalpreet_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Mangalpreet, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
