local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SALVOR_RIPPER_PERSUADE_SUCCESS",
    line = ccb.content.text("&The ripper looks you up and down again.  They nod slowly, as if coming to a decision.  \"Cute, and stupid.  Alright maybe you aren't a complete write-off.  Name's Raxell, I run this salvage op.  Digital stuff, data, software, archives, that kind of thing.  I don't have time to teach you how to do it, but if you want to buy or sell some stuff, I'm open.\""),
    replies = { { text = ccb.content.text("Wont be a problem."), next_topic = "TALK_SALVOR_RIPPER_MAIN" } },
}
