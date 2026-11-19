local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_TRYING",
    line = ccb.content.text("Getting by will do for now."),
    replies = { { text = ccb.content.text("I guess it has to."), next_topic = "TALK_WARRENER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_DOING",
    line = ccb.content.text("I raise my rabbits, I seem to have more in common with them every day."),
    replies = { { text = ccb.content.text("Well, then…"), next_topic = "TALK_WARRENER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WARRENER_WORLD",
    line = ccb.content.text("People come to me to learn how to keep rabbits.  They learn and they go.  I like to think I'm making the world better."),
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_WARRENER" },
        {
            text = ccb.content.text("Anyone nearby I should meet?"),
            next_topic = "TALK_WARRENER_ISHERWOOD",
        },
        {
            text = ccb.content.text("That sounds optimistic?"),
            next_topic = "TALK_WARRENER_WORLD_OPTIMISTIC",
        },
    },
}
