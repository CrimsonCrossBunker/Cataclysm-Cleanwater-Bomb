local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_1",
    line = ccb.content.text("*looks you up and down for several seconds before speaking.  \"Oh, great.\"  Her voice is husky with years of smoking, and her glare suggests it's a habit she's recently given up.  \"Another new mouth to feed?  Just what we need.  Well, I'm Vanessa.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Vanessa_Toby", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Vanessa_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm not a new mouth to feed, but nice to meet you too."),
            next_topic = "TALK_REFUGEE_Vanessa_1_firstmeet",
        },
        { text = ccb.content.text("Yeah, no.  I'm going."), next_topic = "TALK_DONE" },
    },
}
