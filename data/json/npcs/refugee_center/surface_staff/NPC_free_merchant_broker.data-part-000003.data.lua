local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_SEALED1",
    line = ccb.content.gendered_line("Well, there's the downstairs section, we can't fit more people down there so it's out of bounds.  Then there's the second bay that we were using as a staging area at first.  Things went… wrong.  I hear the shopkeeper is offering a reward to clear it out, if you're feeling suicidal.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What went wrong with your staging area?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_SEALED1wrong",
        },
    },
}
