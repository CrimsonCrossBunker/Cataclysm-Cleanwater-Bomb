local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_PORTAL_TRAVELER_telepathy" },
    line = ccb.content.text("«Jasz vata aralas mat!  On de farah shatan!  Mazeh jast ond!»"),
    replies = { { text = ccb.content.text("Well, that didn't help either."), next_topic = "TALK_DONE" } },
}
