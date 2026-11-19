local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_GIVE_CURE",
    line = {
        choices = { ccb.content.text("Here you go.  It should be more than enough to treat the affliction.") },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_AID_DONE",
    line = {
        choices = { ccb.content.text("All patched up.  Your current wounds will heal up nicely now.") },
    },
    replies = {
        { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
