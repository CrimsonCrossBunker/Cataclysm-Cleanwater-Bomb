local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_WAKE_UP",
    line = {
        when = predicates.has_effect("interlocutor", "sleep"),
        yes = {
            when = predicates.handler("dlg_p_dda_d03e6b7290e6"),
            yes = ccb.content.text("No, just no…"),
            no = {
                when = predicates.handler("dlg_p_dda_db3bbd60cd2c"),
                yes = ccb.content.text("Just let me sleep, <name_b>!"),
                no = {
                    when = predicates.handler("dlg_p_dda_ea60ec832f23"),
                    yes = ccb.content.text("Make it quick, I want to go back to sleep."),
                    no = ccb.content.text("Just few minutes more…"),
                },
            },
        },
        no = ccb.content.text("Anything to do before I go to sleep?"),
    },
    replies = {
        {
            text = ccb.content.text("Wake up!"),
            next_topic = "TALK_NONE",
            actions = { "wake_up" },
        },
        {
            text = ccb.content.text("Go back to sleep."),
            next_topic = "TALK_DONE",
        },
    },
}
