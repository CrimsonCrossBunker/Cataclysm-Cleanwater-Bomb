local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Cardboard",
    line = ccb.content.text("*bows deeply.  \"Thank you.  Our expertise with the most sacred of materials comes from a past long gone.\"  He gazes off into the distance, lost in thought.  You wait, but he doesn't talk again."),
    replies = { { text = ccb.content.text("Uh, you there?"), next_topic = "TALK_DINODAVE_Gift" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Gift",
    line = ccb.content.text("You've given us an idea, a way we could repay a small fraction of your aid.  Come back in a day, and your blessing will be here for you."),
    replies = {
        {
            text = ccb.content.text("See you in a day, then."),
            next_topic = "TALK_DINODAVE_Gift_Bye",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Gift_Bye",
    line = ccb.content.text("Make sure you don't let the sandman in.  He can't be trusted."),
    replies = {
        {
            text = ccb.content.text("Always good to catch up, Dave.  Keep on being you."),
            next_topic = "TALK_DONE",
        },
    },
}
