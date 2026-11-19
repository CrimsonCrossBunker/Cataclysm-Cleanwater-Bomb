local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Uyen_1",
    line = ccb.content.gendered_line("*studies you with interest, her eyes lined with fatigue but still alert.  She brushes a lock of hair off her forehead.  \"Hi there.  You look new, nice to meet you.  My name's Uyen.\"", { "interlocutor" }),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Uyen_Tran", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Uyen_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Uyen."),
            next_topic = "TALK_REFUGEE_Uyen_1_firstmeet",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
