local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Draco_Dune" } }),
        yes = ccb.content.gendered_line("Always good to see you, friend.", { "speaker" }),
        no = ccb.content.text("Well now, good to see another new face!  Welcome to the center, friend, I'm Draco."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Draco_Dune", "yes"),
                actions.set_first_topic("TALK_REFUGEE_Draco_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Draco."),
            next_topic = "TALK_REFUGEE_Draco_1_firstmeet",
        },
        {
            text = ccb.content.text("Hi Draco, nice to meet you.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
