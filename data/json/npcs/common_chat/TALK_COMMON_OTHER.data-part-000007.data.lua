local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_NPC_FORCE",
    line = ccb.content.text("Alright, show me how it's done."),
    replies = {
        {
            text = ccb.content.text("Okay, let's begin."),
            next_topic = "TALK_DONE",
            native_actions = { "start_training_npc" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_FORCE",
    line = ccb.content.text("Alright, let's begin."),
    replies = {
        {
            text = ccb.content.text("Sounds good."),
            next_topic = "TALK_DONE",
            native_actions = { "start_training" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_GUARD",
    line = ccb.content.text("Not a bloody chance, I'm going to get left behind!"),
    replies = { { text = ccb.content.text("Fine."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_GUARD",
    line = ccb.content.text("I'm on watch."),
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
