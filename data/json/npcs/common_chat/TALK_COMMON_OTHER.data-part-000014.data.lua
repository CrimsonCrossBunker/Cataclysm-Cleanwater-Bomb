local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_DISALLOW_KEEP_ITEM",
    line = ccb.content.text("Don't try and talk yourself out of this, drop it now."),
    replies = {
        {
            text = ccb.content.text("Okay, I'm dropping it…"),
            native_actions = { "drop_stolen_item" },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ALLOW_KEEP_ITEM",
    line = ccb.content.text("Just this once, you can keep it.  Don't tell anyone else."),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_DONE",
            native_actions = { "remove_stolen_status" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_KEEPING_ITEM",
    line = ccb.content.text("Right… I don't want any trouble."),
    replies = {
        {
            text = ccb.content.text("Smart choice."),
            next_topic = "TALK_DONE",
            native_actions = { "remove_stolen_status" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_EQUIPMENT",
    line = {
        choices = {
            ccb.content.text("No, and if you ask again, I'll fucking obliterate you!"),
            ccb.content.text("No, fuck off!"),
        },
    },
    replies = {
        { text = ccb.content.text("Okay, okay, sorry."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("Seriously, give me more stuff!"),
            next_topic = "TALK_SHARE_EQUIPMENT",
        },
        { text = ccb.content.text("Okay, fine, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_SIZE_UP", "TALK_ASSESS_PERSON", "TALK_LOOK_AT", "TALK_OPINION", "TALK_SHOUT" },
    replies = { { text = ccb.content.text("Okay."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DELIVER_ASK",
    line = ccb.content.text("I'm willing to pay <topic_item_price> per batch for a total of <topic_item_your_total_price>."),
    replies = {
        { text = ccb.content.text("Works for me."), next_topic = "TALK_DELIVER_CONFIRM" },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}
