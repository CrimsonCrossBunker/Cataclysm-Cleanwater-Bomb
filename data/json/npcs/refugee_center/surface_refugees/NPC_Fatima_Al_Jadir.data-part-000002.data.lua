local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_1",
    line = ccb.content.text("*is a fit young woman dressed in smudged coveralls.  She looks at you with interest and concern.  \"Oh, hey, a new face.  Hi, I'm Fatima.  Just visiting I hope?  It's nice to meet new people but there are no beds to share.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Fatima_al_Jadir", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Fatima_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Fatima.  I'm just passing through."),
            next_topic = "TALK_REFUGEE_Fatima_1_firstmeet",
        },
        {
            text = ccb.content.text("Nice to meet you too, Fatima.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
