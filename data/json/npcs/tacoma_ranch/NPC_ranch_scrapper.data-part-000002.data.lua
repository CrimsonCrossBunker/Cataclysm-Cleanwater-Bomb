local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCRAPPER_JOB",
    line = ccb.content.text("I chop up useless vehicles for spare parts and raw materials.  If we can't use a vehicle immediately, we haul it into the ring we are building to surround the outpost.  It provides a measure of defense in the event that we get attacked."),
    replies = { { text = ccb.content.text("Interesting."), next_topic = "TALK_RANCH_SCRAPPER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCRAPPER_HIRE",
    line = ccb.content.text("I don't personally, the teams we send out to recover the vehicles usually need a hand, but can be hard to catch since they spend most of their time outside the outpost."),
    replies = { { text = ccb.content.text("OK."), next_topic = "TALK_RANCH_SCRAPPER" } },
}
