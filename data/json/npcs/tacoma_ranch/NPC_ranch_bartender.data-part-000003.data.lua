local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "RANCH_BARTENDER_ASK_TOKEN",
    line = {
        choices = {
            ccb.content.text("Bring the token back with your glass and I'll exchange it for a merch."),
            ccb.content.gendered_line("Oh, that?  There were too many people stealing our glasses, so I started stamping a logo on some bottle caps as a token and raised the drink prices a bit to encourage their return.  I'll give you a merch back when you bring me the token with your glass.", { "interlocutor" }),
            ccb.content.text("Some people like to hang on to them thinking they'll have value someday, but I'd prefer it if you brought it back with your glass and I'll give you a merch back from your purchase."),
        },
    },
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_RANCH_BARKEEP" } },
}
