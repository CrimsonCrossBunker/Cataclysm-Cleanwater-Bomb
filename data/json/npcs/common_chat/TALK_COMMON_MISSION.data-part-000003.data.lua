local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_OFFER",
    replies = {
        {
            text = ccb.content.text("I'll do it!"),
            next_topic = "TALK_MISSION_ACCEPTED",
            native_actions = { "assign_mission" },
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_MISSION_REJECTED" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ACCEPTED",
    replies = {
        { text = ccb.content.text("Not a problem."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Got any advice?"), next_topic = "TALK_MISSION_ADVICE" },
        {
            text = ccb.content.text("Can you share some equipment?"),
            next_topic = "TALK_SHARE_EQUIPMENT",
        },
        { text = ccb.content.text("I'll be back soon!"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ADVICE",
    replies = {
        { text = ccb.content.text("Sounds good, thanks."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Sounds good.  Bye!"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_REJECTED",
    replies = {
        { text = ccb.content.text("I'm sorry."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Whatever.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}
