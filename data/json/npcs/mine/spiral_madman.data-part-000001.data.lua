local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_SPIRAL_MADMAN_FIRST_MEETING",
    line = ccb.content.text("Spirals?"),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_first_meeting", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Hello there!"),
            next_topic = "TALK_SPIRAL_MADMAN_GENERIC",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } })),
        },
        {
            text = ccb.content.text("I'm outta here.  Bye."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } })),
        },
        {
            text = ccb.content.text("Poor fellow - looks like you're out of your mind.  Can't help you, sorry.  I'm outta here.  Bye."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_first_meeting" } }),
        },
    },
}
