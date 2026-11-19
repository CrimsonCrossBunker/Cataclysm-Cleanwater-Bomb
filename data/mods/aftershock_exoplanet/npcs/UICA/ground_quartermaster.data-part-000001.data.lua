local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_GROUND_QUARTERMASTER_BRIBE_FAILURE" },
    line = ccb.content.text("I think you should leave."),
    replies = { { text = ccb.content.text("Nevermind then."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_UICA_GROUND_QUARTERMASTER_BRIBE_RECENTLY_FAILED" },
    line = ccb.content.text("I already told you no."),
    replies = { { text = ccb.content.text("Nevermind then."), next_topic = "TALK_DONE" } },
}
