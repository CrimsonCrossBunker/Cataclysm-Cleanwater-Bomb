local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "MSU14_LOCKED_START" },
    line = ccb.content.text("&<color_light_blue>Cyma Interface [version 0.67.0459]\n************************************************\n*  Copyright (c) Cyma Enterprise Systems 2022  *\n************************************************</color>\n\nDATA TRANSMISSION COMPLETED.  NO FURTHER ACTIONS REQUIRED.\n\n"),
    replies = { { text = ccb.content.text("Shut down."), next_topic = "TALK_DONE" } },
}
