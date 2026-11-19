local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYT_MAIN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        yes = ccb.content.text("Hey there."),
        no = ccb.content.text("Hey!  Who goes there?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_cowboyt", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Just another survivor.  What are you doing here?"),
            next_topic = "TALK_COWBOYT_INTRODUCTION",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } })),
        },
        {
            text = ccb.content.text("I'm you, from the future.  I've come to warn you."),
            next_topic = "TALK_COWBOYT_JOKE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } })),
        },
        {
            text = ccb.content.text("I am a ghost.  I died here 37 years ago, yet I cannot depart this mortal realm."),
            next_topic = "TALK_COWBOYT_JOKE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } })),
        },
        {
            text = ccb.content.text("What did you before all this?"),
            next_topic = "TALK_COWBOYT_BACKGROUND",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        },
        {
            text = ccb.content.text("Is there something I can help you with?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        },
        {
            text = ccb.content.text("How about we travel together?"),
            next_topic = "TALK_COWBOYT_FOLLOW",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        },
        {
            text = ccb.content.text("See you around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyt" } }),
        },
    },
}
