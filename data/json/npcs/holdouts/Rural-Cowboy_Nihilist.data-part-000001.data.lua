local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_MAIN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyn" } }),
        yes = ccb.content.text("Yeah?"),
        no = ccb.content.text("Oh.  Hey there."),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_cowboyn", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Thought I heard someone.  What are you doing here?"),
            next_topic = "TALK_COWBOYN_INTRODUCTION1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyn" } })),
        },
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_COWBOYN_BACKGROUND",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyn" } }), predicates.negate(predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmota" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }) })) }),
        },
        {
            text = ccb.content.text("Would you like to come with me?"),
            next_topic = "TALK_COWBOYN_FOLLOW",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmota" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }) }),
        },
        {
            text = ccb.content.text("See you around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyn" } }),
        },
    },
}
