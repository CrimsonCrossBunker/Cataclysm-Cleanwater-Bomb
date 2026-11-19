local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "MSU14_MISSION_COMPLETE",
    line = ccb.content.text("&Processing 1 of 1 - Installing Sys3_rnp_4b12\n[====================] 100%\nThe operation completed successfully.\n\nRestart to apply changes.\nDo you want to restart now?  (Y/N)\n\n"),
    replies = {
        {
            text = ccb.content.text("Restart the computer and leave."),
            next_topic = "TALK_DONE",
            actions = { actions.set_first_topic("MSU14_LOCKED_START") },
        },
    },
}
