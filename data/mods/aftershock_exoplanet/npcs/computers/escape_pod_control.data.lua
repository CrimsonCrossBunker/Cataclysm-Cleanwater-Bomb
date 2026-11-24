local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "ESPOD_CONTROL_START" },
    line = ccb.content.text("&Cyma Interface [version 2.85.1004]\n************************************************\n*  Copyright (c) Cyma Enterprise Systems 3013  *\n************************************************\n\nEscape Pod Control:"),
    replies = {
        { text = ccb.content.text("Ready escape pod."), next_topic = "ESPOD_CONTROL_READY" },
        { text = ccb.content.text("Shut down."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "ESPOD_CONTROL_READY" },
    line = ccb.content.text("&************************************************\n\nINTEGRITY CHK : ███████████████ 100% (COMPLETE)\nNAV TRANSFER :  ███████████████ 100% (COMPLETE)\nFUELING :       ███████████████ 100% (COMPLETE)\n\n************************************************\n*  Operation Successful                         *\n************************************************"),
    replies = {
        {
            text = ccb.content.text("Continue."),
            next_topic = "ESPOD_CONTROL_CONTINUE",
            actions = { actions.handler("dlg_a_aftershock_exoplanet_946f9b1b3869") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "ESPOD_CONTROL_CONTINUE" },
    line = ccb.content.text("&Escape pod launch procedure:\n\n    1) Ready escape pod.  (COMPLETE)\n    2) Secure Passengers/Cargo.\n    3) Launch from pod controls."),
    replies = { { text = ccb.content.text("Shut down."), next_topic = "TALK_DONE" } },
}
