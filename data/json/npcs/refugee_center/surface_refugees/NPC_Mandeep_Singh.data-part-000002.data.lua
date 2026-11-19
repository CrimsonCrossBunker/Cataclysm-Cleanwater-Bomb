local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mandeep_1",
    line = {
        joined = {
            ccb.content.text("*is a middle-aged man with a crisp turban and a large blade at his side.  He meets your gaze as you approach, his expression stony.  \"Hello "),
            {
                when = predicates.actor_state("speaker", "male"),
                yes = ccb.content.text("sir"),
                no = ccb.content.text("ma'am"),
            },
            ccb.content.text(".  I am Mandeep Singh.\""),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Mandeep_Singh", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Mandeep_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Mandeep."),
            next_topic = "TALK_REFUGEE_Mandeep_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Mandeep, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
