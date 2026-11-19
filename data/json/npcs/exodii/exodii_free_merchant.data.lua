local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_FREE_MERCHANT_PERMENANT",
    line = ccb.content.text("Who knows?  Lots of scavs come through.  The Exodii are quick to dispatch any <zombies>.  And the Exodii seem happy about it all.  Seems good a place as any to settle down."),
    replies = { { text = ccb.content.text("Anyway…"), next_topic = "TALK_EXODII_FREE_MERCHANT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_FREE_MERCHANT_INTERVAL",
    line = ccb.content.text("Around <restock_time_point>, if the caravan doesn't run into trouble."),
    replies = { { text = ccb.content.text("Thanks for the info, bye."), next_topic = "TALK_DONE" } },
}
