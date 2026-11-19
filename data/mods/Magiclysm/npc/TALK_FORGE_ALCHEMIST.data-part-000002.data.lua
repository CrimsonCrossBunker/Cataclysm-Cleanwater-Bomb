local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_ALCHEMIST",
    line = {
        choices = {
            ccb.content.text("…then another 15 minutes for purifying.  Oh, hello.  Do you need potions?"),
            ccb.content.text("Huh?  *mumble*  What?  Are you buying something?"),
            ccb.content.text("I don't have a lot of time.  Did you want something or just looking around?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            native_actions = { "start_trade" },
            next_topic = "TALK_FORGE_LORD_ALCHEMIST",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_FORGE_ALCHEMIST_DOING",
        },
        {
            text = ccb.content.text("Do you have any more brewing?"),
            next_topic = "TALK_FORGE_ALCHEMIST_ASK_INTERVAL",
        },
        { text = ccb.content.text("Well, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_ALCHEMIST_DOING",
    line = ccb.content.text("What does it look like I'm doing?  I brew and sell potions.  If you have some magical plants, I'll buy them from you."),
    replies = {
        {
            text = ccb.content.text("Let's talk business, then."),
            next_topic = "TALK_FORGE_LORD_ALCHEMIST",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_ALCHEMIST_ASK_INTERVAL",
    line = ccb.content.text("I'll probably brew another batch soon.  Check back on <restock_time_point>."),
    replies = { { text = ccb.content.text("Take care."), next_topic = "TALK_FORGE_LORD_ALCHEMIST" } },
}
