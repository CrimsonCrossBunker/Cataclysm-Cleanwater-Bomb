local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_WHATELY_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
        yes = {
            choices = {
                ccb.content.text("Outsider."),
                ccb.content.text("Hello."),
                ccb.content.text("Hospitality rites are civilization."),
                ccb.content.text("Guest."),
                ccb.content.text("How's the madness outside?"),
            },
        },
        no = ccb.content.text("We don't get outsiders around here all that much."),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_whately", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } })),
            next_topic = "TALK_WHATELY_firstmeet",
        },
        {
            text = ccb.content.text("What is this place?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
            next_topic = "TALK_WHATELY_place",
        },
        {
            text = ccb.content.text("What's your story?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
            next_topic = "TALK_WHATELY_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
            next_topic = "TALK_WHATELY_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("How do I join the family?"),
            next_topic = "TALK_WHATELY_ask_membership",
        },
        { text = ccb.content.text("I'm going on my way now."), next_topic = "TALK_DONE" },
    },
}
