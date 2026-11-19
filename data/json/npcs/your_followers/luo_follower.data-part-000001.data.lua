local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_GUARD_Luo",
    line = ccb.content.text("I love just standing around, it's what I was made for."),
    replies = {
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND_Luo",
            native_actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND_Luo" },
        { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Luo_Abilities",
    line = ccb.content.text("My 'abilities'?  I can shapeshift, and teleport, but I can't do it on command.  Also, I have unique powers of thyroid failure."),
}
