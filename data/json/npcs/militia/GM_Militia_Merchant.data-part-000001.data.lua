local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_MAIN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } }),
        yes = ccb.content.text("Hello again."),
        no = ccb.content.text("Welcome to our camp.  Behave yourself while you are here.  What can I do for you?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_MILITIAMAIN", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you do here?"),
            next_topic = "TALK_MILITIA_INTRODUCTION",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } })),
        },
        {
            text = ccb.content.text("What's the story behind this place?"),
            next_topic = "TALK_MILITIA_BACKGROUND",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } }),
        },
        {
            text = ccb.content.text("Is there something I can do for you?"),
            next_topic = "TALK_MILITIA_HELP",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } }),
        },
        {
            text = ccb.content.text("Do you have anything to trade?"),
            next_topic = "TALK_MILITIA_TRADE",
        },
        {
            text = ccb.content.text("Time for me to leave."),
            next_topic = "TALK_MILITIA_BYE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_MILITIAMAIN" } }),
        },
    },
}
