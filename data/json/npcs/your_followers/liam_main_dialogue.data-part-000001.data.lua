local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_GUARD_Liam",
    line = ccb.content.text("*shrugs.  \"Not my favorite job, but sure.  I'll keep an eye out.\""),
    replies = {
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND_Liam",
            native_actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND_Liam" },
        { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_Abilities",
    line = ccb.content.text("As you know, I am experienced in practically every low-wage job on the Eastern seaboard, and I'm probably a regional leading expert on video games.  My dad made me learn archery and I kinda kept it up.  What else is there?"),
}
