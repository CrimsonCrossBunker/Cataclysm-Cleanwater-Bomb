local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_1",
    line = ccb.content.text("*seems to look past you for a while before realizing you are there.  \"Hello.  I'm sorry, if we've met before, I don't really remember.  I'm… I'm Stan.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Stan_Borichenko", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Stan_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Stan, hey?  Nice to meet you."),
            next_topic = "TALK_REFUGEE_Stan_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Stan, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
