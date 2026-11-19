local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_SPIDERS",
    line = ccb.content.text("Spiders it is then.  But of course, there are several different kinds of spiders out there.  Which type are you interested in?"),
    replies = {
        {
            text = ccb.content.text("Web spinners in a forest."),
            next_topic = "TALK_FORGE_LORD_DIVINER_SPIDERS_WEB",
        },
        {
            text = ccb.content.text("A pit full of spiders."),
            next_topic = "TALK_FORGE_LORD_DIVINER_SPIDERS_PIT",
        },
        {
            text = ccb.content.text("Demonic spiders."),
            next_topic = "TALK_FORGE_LORD_DIVINER_SPIDERS_DEMON",
        },
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}
