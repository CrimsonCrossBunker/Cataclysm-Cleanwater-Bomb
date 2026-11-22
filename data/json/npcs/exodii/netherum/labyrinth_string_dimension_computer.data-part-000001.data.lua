local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_LS_SD_Download_Data",
    line = ccb.content.text("&The screen starts to auto-populate with green text, and the process speeds up rapidly until it is just a blur.  It suddenly stops and the terminal beeps - you then hear a ka-thunk as the storage device is ejected from the machine."),
    replies = {
        {
            text = ccb.content.text("[Take the Exodii electronic storage device]"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_2382c546991c") },
        },
    },
}
