local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_safety_lead",
    line = ccb.content.text("Are we there yet, <name_g>?"),
    replies = {
        {
            text = ccb.content.text("Yes, you can relax now."),
            next_topic = "TALK_meteorologist_safety_done",
            when = predicates.handler("dlg_p_dda_f67f3b47ebe4"),
        },
        {
            text = ccb.content.text("Don't worry, we're getting there soon."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_safety_done",
    line = ccb.content.text("Thank you.  I will never forget your kindness, <name_g>.  Take this book as token of my gratitude."),
    replies = {
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_e9a3927a8073"), "stop_following", actions.set_first_topic("TALK_meteorologist_safe") },
        },
    },
}
