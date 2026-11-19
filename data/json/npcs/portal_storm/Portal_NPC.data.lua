local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_PORTAL_PERSON_1",
    line = ccb.content.text("Dell hastro bovice?  Arand natick res?"),
    replies = { { text = ccb.content.text("What?"), next_topic = "TALK_PORTAL_PERSON_2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PORTAL_PERSON_2",
    line = ccb.content.text("Jand rawdle?  Ignate hasture."),
    replies = {
        {
            text = ccb.content.text("I guess there's no reason to expect an interdimensional traveler to speak English."),
            next_topic = "TALK_DONE",
        },
    },
}
