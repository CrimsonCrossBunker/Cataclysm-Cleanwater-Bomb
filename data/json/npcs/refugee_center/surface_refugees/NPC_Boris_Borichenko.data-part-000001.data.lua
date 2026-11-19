local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_1",
    line = ccb.content.text("Ah, another new face.  Hello.  I am Boris."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Boris_Borichenko", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Boris_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Boris."),
            next_topic = "TALK_REFUGEE_Boris_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Boris, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
