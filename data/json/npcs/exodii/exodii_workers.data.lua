local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_WORKER",
    line = {
        choices = {
            ccb.content.text("&You see a human-like robot walking nearby."),
            ccb.content.text("&You see a mechanical humanoid moving somewhere in a hurry."),
            ccb.content.text("&You see some sort of robot walking in a hurry."),
            ccb.content.text("&This robot doesn't seem to be very busy."),
        },
    },
    replies = {
        { text = ccb.content.text("Hello?"), next_topic = "TALK_EXODII_WORKER_2" },
        { text = ccb.content.text("[Move away.]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_WORKER_2",
    line = {
        choices = {
            ccb.content.text("&They seem to completely ignore you."),
            ccb.content.text("&They ran past you, completely ignoring your presence."),
            ccb.content.text("&They don't seem to want to talk to you."),
            ccb.content.text("&They seem to greet you, but that's it."),
        },
    },
    replies = { { text = ccb.content.text("How rude."), next_topic = "TALK_DONE" } },
}
