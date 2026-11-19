local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
        yes = {
            choices = {
                ccb.content.text("What brings you here today?"),
                ccb.content.text("Hello."),
                ccb.content.text("How are you?"),
                ccb.content.text("Welcome!"),
                ccb.content.text("Are you ready to leave this marble?"),
            },
        },
        no = ccb.content.text("You look like one of my niece's lab assistants."),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_cyrus", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } })),
            next_topic = "TALK_CYRUS_firstmeet",
        },
        {
            text = ccb.content.text("What is this place?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
            next_topic = "TALK_CYRUS_place",
        },
        {
            text = ccb.content.text("How did you get here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
            next_topic = "TALK_CYRUS_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
            next_topic = "TALK_CYRUS_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?  Are you as crazy as your niece?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_cyrus" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("I'm going on my way now."), next_topic = "TALK_DONE" },
    },
}
