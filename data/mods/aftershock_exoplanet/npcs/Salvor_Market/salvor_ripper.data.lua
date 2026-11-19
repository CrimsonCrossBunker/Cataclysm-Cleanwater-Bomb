local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_EXPLAIN",
    line = ccb.content.text("&The ripper looks up at you, surprised that you would ask such a thing.  See all these brutes out here?  I try to make them realize the computers they smash for bits have useful stuff in them beyond the pretty crystals, and that they should try some data recovering and bring that to me.\"\n\n\"But they usually don't care.  Now though if you want into the buisness, I can sell you a computer and a copy of OpenVault, so you can start salvaging data yourself.  Or you can just go back to your smashing, whatever.\""),
    replies = { { text = ccb.content.text("Interesting."), next_topic = "TALK_SALVOR_RIPPER_MAIN" } },
}
