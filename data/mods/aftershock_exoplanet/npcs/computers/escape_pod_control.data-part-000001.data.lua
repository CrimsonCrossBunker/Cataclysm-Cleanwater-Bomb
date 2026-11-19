local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "ESPOD_CONTROL_START" },
    line = ccb.content.text("&Cyma Interface [version 2.85.1004]\n************************************************\n*  Copyright (c) Cyma Enterprise Systems 3013  *\n************************************************\n\nEscape Pod Control:"),
    replies = {
        { text = ccb.content.text("Ready escape pod."), next_topic = "ESPOD_CONTROL_READY" },
        { text = ccb.content.text("Shut down."), next_topic = "TALK_DONE" },
    },
}
