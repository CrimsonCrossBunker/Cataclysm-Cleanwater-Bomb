local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Millyficent_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
        yes = {
            choices = {
                ccb.content.text("What did you bring me?"),
                ccb.content.text("Hello."),
                ccb.content.text("How are you?"),
                ccb.content.text("Welcome!"),
                ccb.content.text("Do you smell something?"),
            },
        },
        no = ccb.content.text("New test subjects!  I'm so glad you showed up!"),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_millyficent", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } })),
            next_topic = "TALK_millyficent_firstmeet",
        },
        {
            text = ccb.content.text("What is this place?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
            next_topic = "TALK_millyficent_place",
        },
        {
            text = ccb.content.text("How did you get here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
            next_topic = "TALK_millyficent_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
            next_topic = "TALK_millyficent_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?  Do I want to?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_millyficent" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("I'm going on my way now."), next_topic = "TALK_DONE" },
    },
}
