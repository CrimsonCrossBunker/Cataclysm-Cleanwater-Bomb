local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_1a",
    line = ccb.content.gendered_line("*peers at you for a while before speaking.  \"Oh, you're back.\"", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Hi, Vanessa.  What's up?"),
            next_topic = "TALK_REFUGEE_Vanessa_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_1_firstmeet",
    line = ccb.content.text("Well that's good.\"  She purses her lips and gives you another judgmental stare.  \"If you're going to pull your own weight I guess that's an improvement."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_2",
    line = ccb.content.text("Not much is up.  Not enough, in fact.  Here we are stuck in this slum pit with a bunch of strangers, and all we can do is sit around staring at our hands."),
}
