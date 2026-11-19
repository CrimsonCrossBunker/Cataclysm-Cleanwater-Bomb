local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "MSU14_START", "MSU14_lOGIN_FAILED" },
    line = ccb.content.text("&<color_light_blue>Cyma Interface [version 0.85.1004]\n************************************************\n*  Copyright (c) Cyma Enterprise Systems 2023  *\n************************************************</color>\n\nLogin:\n\n"),
    replies = {
        { text = ccb.content.text("Attempt a login"), next_topic = "MSU14_lOGIN_FAILED" },
        {
            text = ccb.content.text("Login using the scribbled credentials"),
            next_topic = "MSU14_MAIN",
            when = predicates.has_item("speaker", "msu14_password"),
        },
        {
            text = ccb.content.text("Login with Hub 01 credentials"),
            next_topic = "MSU14_MAIN",
            when = predicates.has_mission("RD_1"),
        },
        { text = ccb.content.text("Shut down"), next_topic = "TALK_DONE" },
    },
}
