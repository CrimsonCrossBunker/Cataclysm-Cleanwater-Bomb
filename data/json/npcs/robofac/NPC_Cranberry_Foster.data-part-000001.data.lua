local ccb = require("ccb")

ccb.content.define_dialogue_topic { id = "TALK_ROBOFAC_MERC_1_STAY_AWHILE", line = ccb.content.text("Cool.") }

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_PLACEHOLDER_TEXT", "TALK_ROBOFAC_MERC_1_OTHER_MERCS" },
    line = ccb.content.text("I sure did.  Sorry, just a stupid icebreaker.  Old habits and all that.\"  They sit up.  \"What's up?"),
    replies = {
        { text = ccb.content.text("Who exactly are you?"), next_topic = "TALK_ROBOFAC_MERC_1_WHO" },
        {
            text = ccb.content.text("I thought I was the only one working for the people here."),
            next_topic = "TALK_ROBOFAC_MERC_1_OTHER_MERCS",
        },
        {
            text = ccb.content.text("Just saying hi.  I'll be on my way now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_OTHER_MERCS",
    line = ccb.content.gendered_line("Surprise!\"  They do jazz hands.  \"Sorry.  Well, I'm told that I'm part of a small group right now.  Maybe you were the first.", { "speaker" }),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_WHO",
    line = ccb.content.text("Just the same as you.  Some nobody doing dirty work for scraps.  Uh, no offense."),
    replies = {
        {
            text = ccb.content.text("None taken.  I guess that makes two of us."),
            next_topic = "TALK_ROBOFAC_MERC_1_TWO_OF_US",
        },
        { text = ccb.content.text("Well, never mind."), next_topic = "TALK_DONE" },
    },
}
