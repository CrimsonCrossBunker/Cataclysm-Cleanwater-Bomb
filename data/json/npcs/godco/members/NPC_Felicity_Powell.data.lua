local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Manuscript_InProgress",
    line = ccb.content.text("I'm still working on it.  I'll have it ready soon."),
    replies = { { text = ccb.content.text("Good luck with that."), next_topic = "TALK_GODCO_Felicity_3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Angry",
    line = ccb.content.text("Overall, you've been quite unpleasent to us, and I've frankly had enough of your prude nature.  I won't repeat myself more, go away."),
    replies = {
        {
            text = ccb.content.text("Alright <name_b>, I'll see you later."),
            next_topic = "TALK_GODCO_Felicity_3",
        },
    },
}
