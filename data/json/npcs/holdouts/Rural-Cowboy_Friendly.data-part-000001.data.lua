local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYFR_MAIN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        yes = ccb.content.text("Hello again."),
        no = ccb.content.text("Ayuh, I was thinkin' it's just another monstah skulkin' about.  Who are you?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_cowboyfr", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Just a survivor, looking around.  What are you doing here?"),
            next_topic = "TALK_COWBOYFR_INTRODUCTION",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } })),
        },
        {
            text = ccb.content.text("What did you before all this?"),
            next_topic = "TALK_COWBOYFR_BACKGROUND",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        },
        {
            text = ccb.content.text("Is there something I can do for you?"),
            next_topic = "TALK_COWBOYFR_HELP",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        },
        {
            text = ccb.content.text("How about we travel together?"),
            next_topic = "TALK_COWBOYFR_FOLLOW",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        },
        {
            text = ccb.content.text("What's with the accent?"),
            next_topic = "TALK_COWBOYFR_ACCENT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cowboyfr" } }),
        },
    },
}
