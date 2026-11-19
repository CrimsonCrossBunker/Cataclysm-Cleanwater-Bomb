local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_CAMP_RESIDENT",
    line = ccb.content.text("I'm working at the camp."),
    replies = {
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND",
            native_actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_UNCOMFORTABLE",
    line = ccb.content.text("I really don't feel comfortable doing so…"),
    replies = { { text = ccb.content.text("I'll give you some space."), next_topic = "TALK_FRIEND" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_PERSONAL",
    line = ccb.content.text("I'd prefer to keep that to myself."),
    replies = { { text = ccb.content.text("I understand…"), next_topic = "TALK_FRIEND" } },
}
