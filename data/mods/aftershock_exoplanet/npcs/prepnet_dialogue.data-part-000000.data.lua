local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
        yes = {
            choices = {
                ccb.content.text("Hey there."),
                ccb.content.text("Hello."),
                ccb.content.text("How are you?"),
                ccb.content.text("Welcome!"),
                ccb.content.text("How's the weather?"),
            },
        },
        no = ccb.content.text("Howdy!  You seem new, what brings you here?"),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_prepnet_gardener", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } })),
            next_topic = "TALK_PrepNet_gardener_firstmeet",
        },
        {
            text = ccb.content.text("What is this place?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
            next_topic = "TALK_PrepNet_gardener_place",
        },
        {
            text = ccb.content.text("What's your story?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
            next_topic = "TALK_PrepNet_gardener_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
            next_topic = "TALK_PrepNet_gardener_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("How do I join the phyle?"),
            next_topic = "TALK_PrepNet_gardener_ask_membership",
        },
        { text = ccb.content.text("I'm going on my way now."), next_topic = "TALK_DONE" },
    },
}
