local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } }),
        yes = {
            choices = {
                ccb.content.text("*whispering.  \"Welcome back to the Library.\""),
                ccb.content.text("*whispering.  \"Hello again.  Can I help you find something?\""),
                ccb.content.text("*whispering.  \"Hello.\""),
            },
        },
        no = ccb.content.text("*waves and smiles.  \"Welcome fellow reader.\""),
    },
    replies = {
        {
            text = ccb.content.text("Hello, who are you?  This is a library, is it?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Intro",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_Elvira", "yes") },
        },
        {
            text = ccb.content.text("Oh sorry, I'm not interested right now."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } })),
        },
        {
            text = ccb.content.text("I wanted to talk."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } }),
        },
        {
            text = ccb.content.text("Let me see what you have."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_DoneTrading",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } }),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Just saying hello."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } }),
        },
    },
}
