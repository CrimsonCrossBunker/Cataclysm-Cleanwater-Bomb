local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_WENDI",
    line = ccb.content.text("I'm so cold and hungry.  I need your food and warmth."),
    replies = {
        {
            text = ccb.content.text("I have food you can have."),
            next_topic = "TALK_CIVILIAN_WENDI_FOOD",
        },
        { text = ccb.content.text("You're on your own."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Let's see what we can do."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_WENDI_FOOD",
    line = ccb.content.text("It's not enough.  It's not enough!"),
    replies = { { text = ccb.content.text("[You step back.]"), next_topic = "TALK_DONE" } },
}
