local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_DENY_VITAKINETIC_HEALING_NON_PERSUADE",
    line = ccb.content.text("I don't think so.  I know there are zombies out there and the world is all fucked up, but I'd rather keep that fucked-up-ness as far away from me as possible.  No offense."),
    replies = { { text = ccb.content.text("Alright, if you insist."), next_topic = "TALK_DONE" } },
}
