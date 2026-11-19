local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_SUCCESS_LIE",
    replies = {
        {
            text = ccb.content.text("Well, um, sorry."),
            next_topic = "TALK_NONE",
            native_actions = { "clear_mission" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_FAILURE",
    replies = {
        {
            text = ccb.content.text("I'm sorry.  I did what I could."),
            next_topic = "TALK_NONE",
            native_actions = { "clear_mission" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_REWARD",
    line = ccb.content.text("Sure, here you go!"),
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_NONE",
            native_actions = { "clear_mission" },
        },
        {
            text = ccb.content.text("Thanks, bye."),
            next_topic = "TALK_DONE",
            native_actions = { "clear_mission" },
        },
    },
}
