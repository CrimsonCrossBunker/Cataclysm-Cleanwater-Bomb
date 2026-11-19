local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "ESPOD_CONTROL_CONTINUE" },
    line = ccb.content.text("&Escape pod launch procedure:\n\n    1) Ready escape pod.  (COMPLETE)\n    2) Secure Passengers/Cargo.\n    3) Launch from pod controls."),
    replies = { { text = ccb.content.text("Shut down."), next_topic = "TALK_DONE" } },
}
