local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_FREE_MERCHANT_EXODII",
    line = ccb.content.text("If you say so.  Can't say I can really tell the difference.  No offense."),
    replies = { { text = ccb.content.text("Anyway…"), next_topic = "TALK_EXODII_FREE_MERCHANT" } },
}
