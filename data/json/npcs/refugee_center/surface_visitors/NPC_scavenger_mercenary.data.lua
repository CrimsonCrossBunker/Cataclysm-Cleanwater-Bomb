local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_MERCH",
    line = ccb.content.text("Merch is what they call dollar bills around here.  Free Merchant Credit Notes or something.  If you want to buy stuff around here and you don't want to barter away your guns, you need merch."),
    replies = {
        {
            text = ccb.content.text("I see.  Let's try this again from the start."),
            next_topic = "TALK_SCAVENGER_MERC",
        },
        {
            text = ccb.content.text("Okay, how much merch do I need?"),
            next_topic = "TALK_SCAVENGER_MERC_HIRE",
        },
        {
            text = ccb.content.text("Well, thanks for the info.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SCAVENGER_MERC_HIRE_SUCCESS",
    line = ccb.content.text("I guess you're the boss."),
    replies = {
        {
            text = ccb.content.text("Glad to have you aboard."),
            success = {
                native_actions = { "follow" },
                opinion = { trust = 1, value = 1 },
                next_topic = "TALK_DONE",
            },
        },
    },
}
