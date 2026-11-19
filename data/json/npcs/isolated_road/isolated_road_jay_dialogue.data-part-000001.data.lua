local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_RESTOCK",
    line = ccb.content.text("Next series of currency gotta be ready around <restock_time_point>, fresh off the print!"),
    replies = {
        {
            text = ccb.content.text("I'll make sure to take a look.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_SHOP_ABOUT",
    line = ccb.content.text("Fuck yeah.  New currency is death and I'm dealing it."),
    replies = {
        {
            text = ccb.content.text("I understand, but how does this work exactly?"),
            next_topic = "TALK_GUNSMITH_SHOP_ABOUT_MORE",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}
